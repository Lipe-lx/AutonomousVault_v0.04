# Supabase Database Migrations

## Overview

This directory contains database migrations for the AutonomousVault application.

## Tables

| Table | Purpose |
|-------|---------|
| `encrypted_keys` | Store client-encrypted wallet keys |
| `user_settings` | Store user preferences |
| `trade_history` | Record executed trades |
| `usage_tracking` | Track API usage for monetization |
| `portfolio_snapshots` | Historical portfolio data |

## Security

All tables implement Row Level Security (RLS):
- Users can only access their own data
- No admin backdoors
- Encrypted keys are client-encrypted only

## Running Migrations

```bash
# Using Supabase CLI
supabase db push

# Or apply schema directly
psql $DATABASE_URL < schema.sql
```

## Non-Custodial Guarantees

> [!CAUTION]
> - Decrypted private keys are NEVER stored
> - All encryption/decryption happens client-side
> - Server only stores encrypted blobs
