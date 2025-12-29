// SUPABASE INFRA
// Main exports for Supabase infrastructure

// Client
export * from './client';
export * from './env';

// Auth
export * from './auth/auth.service';

// Setup Wizard
export * from './setup-wizard.service';

// Edge Functions (types only)
export type {
    DealerCycleRequest,
    DealerCycleResponse,
    SyncPortfolioRequest,
    UsageTrackingRequest
} from './edge-functions/functions';

// Monetization
export * from './monetization/limits.stub';

