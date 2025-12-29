# Edge Functions

This directory will contain Supabase Edge Functions for server-side execution.

## Planned Edge Functions

### `dealer-cycle`
Executes a single dealer analysis cycle.
- Called by scheduled cron job OR on-demand
- Receives: encrypted private key, execution password, settings
- Decrypts key in-memory only
- Calls AI adapter for analysis
- Executes trades via execution adapter
- Returns: cycle results

### `sync-portfolio`
Syncs portfolio state from exchange.
- High-frequency sync (every 15s when active)
- No signing required - read-only

### `market-data`
Fetches market data for analysis.
- Proxies to exchange APIs
- Caches results briefly
- Rate limit aware

## Non-Custodial Requirements

All Edge Functions MUST:

1. **Never persist decrypted keys** - decrypt in-memory only
2. **Require user password** - for decryption
3. **Clear memory after use** - no key retention
4. **No admin override** - user controls execution
5. **Audit logging** - all executions logged

## Implementation Notes

```typescript
// Example Edge Function structure (NOT IMPLEMENTED)
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';

serve(async (req) => {
  const { encryptedKey, password, settings } = await req.json();
  
  // Decrypt key in-memory
  const privateKey = await decrypt(encryptedKey, password);
  
  try {
    // Execute trade
    const result = await executeTrade(privateKey, settings);
    return new Response(JSON.stringify(result));
  } finally {
    // CRITICAL: Clear key from memory
    privateKey = null;
  }
});
```
