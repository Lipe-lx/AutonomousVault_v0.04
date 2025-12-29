-- SUPABASE INFRA
-- Database schema placeholder for Supabase
-- This will define the RLS-protected tables for user data
--
-- CRITICAL: Never store decrypted private keys
-- Encrypted keys MAY be stored (user's choice)

-- ============================================
-- USER SETTINGS
-- ============================================

CREATE TABLE IF NOT EXISTS user_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  
  -- Dealer Settings (JSON for flexibility)
  dealer_settings JSONB DEFAULT '{}',
  
  -- Trading Pairs
  trading_pairs TEXT[] DEFAULT '{}',
  
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  
  UNIQUE(user_id)
);

-- RLS: Users can only access their own settings
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY user_settings_policy ON user_settings
  FOR ALL USING (auth.uid() = user_id);

-- ============================================
-- ENCRYPTED KEYS (OPTIONAL - USER CHOICE)
-- ============================================

CREATE TABLE IF NOT EXISTS encrypted_keys (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  
  -- Key identifier (e.g., 'hyperliquid', 'polymarket')
  key_name TEXT NOT NULL,
  
  -- AES-GCM encrypted private key (encrypted client-side)
  encrypted_value TEXT NOT NULL,
  
  -- Salt used for encryption (stored for decryption)
  encryption_salt TEXT NOT NULL,
  
  -- Wallet address (public, for reference)
  public_address TEXT,
  
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  
  UNIQUE(user_id, key_name)
);

-- RLS: Users can only access their own keys
ALTER TABLE encrypted_keys ENABLE ROW LEVEL SECURITY;

CREATE POLICY encrypted_keys_policy ON encrypted_keys
  FOR ALL USING (auth.uid() = user_id);

-- ============================================
-- TRADE HISTORY (AUDIT LOG)
-- ============================================

CREATE TABLE IF NOT EXISTS trade_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  
  -- Trade details
  exchange TEXT NOT NULL, -- 'hyperliquid', 'polymarket'
  coin TEXT NOT NULL,
  action TEXT NOT NULL, -- 'BUY', 'SELL', 'CLOSE'
  size_usdc DECIMAL(18, 8),
  price DECIMAL(18, 8),
  leverage INTEGER,
  
  -- Execution details
  order_id TEXT,
  cloid TEXT,
  status TEXT NOT NULL, -- 'pending', 'filled', 'failed'
  error TEXT,
  
  -- AI decision context
  confidence DECIMAL(3, 2),
  reason TEXT,
  
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS: Users can only access their own history
ALTER TABLE trade_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY trade_history_policy ON trade_history
  FOR ALL USING (auth.uid() = user_id);

-- Index for querying recent trades
CREATE INDEX trade_history_user_created_idx 
  ON trade_history(user_id, created_at DESC);

-- ============================================
-- USAGE TRACKING (FOR MONETIZATION)
-- ============================================

CREATE TABLE IF NOT EXISTS usage_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  
  -- Usage period (monthly)
  period_start DATE NOT NULL,
  
  -- Counters
  cycles_executed INTEGER DEFAULT 0,
  trades_executed INTEGER DEFAULT 0,
  ai_tokens_used BIGINT DEFAULT 0,
  
  -- Plan limits (denormalized for quick checks)
  max_cycles INTEGER DEFAULT 100,
  max_trades INTEGER DEFAULT 50,
  max_ai_tokens BIGINT DEFAULT 1000000,
  
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  
  UNIQUE(user_id, period_start)
);

-- RLS: Users can only access their own usage
ALTER TABLE usage_tracking ENABLE ROW LEVEL SECURITY;

CREATE POLICY usage_tracking_policy ON usage_tracking
  FOR ALL USING (auth.uid() = user_id);

-- ============================================
-- NOTES
-- ============================================

-- 1. All tables use RLS for user isolation
-- 2. encrypted_keys stores CLIENT-ENCRYPTED data only
-- 3. Server NEVER has access to decryption password
-- 4. trade_history provides audit trail
-- 5. usage_tracking enables monetization limits
