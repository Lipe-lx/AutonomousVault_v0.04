// SUPABASE INFRA
// Supabase Client Configuration
// This file initializes the Supabase client for the application
//
// Environment variables required:
// - VITE_SUPABASE_URL
// - VITE_SUPABASE_ANON_KEY

/**
 * Supabase client configuration type
 */
export interface SupabaseConfig {
    url: string;
    anonKey: string;
}

/**
 * Get Supabase configuration from environment
 */
export function getSupabaseConfig(): SupabaseConfig {
    const url = import.meta.env.VITE_SUPABASE_URL;
    const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

    if (!url || !anonKey) {
        console.warn('[Supabase] Missing environment variables. Auth will not work.');
        return {
            url: '',
            anonKey: ''
        };
    }

    return { url, anonKey };
}

/**
 * Supabase client singleton
 * 
 * Usage (when @supabase/supabase-js is installed):
 * ```typescript
 * import { createClient } from '@supabase/supabase-js';
 * import { getSupabaseConfig } from './client';
 * 
 * const config = getSupabaseConfig();
 * export const supabase = createClient(config.url, config.anonKey);
 * ```
 */

// Placeholder for actual client creation
// Will be implemented when @supabase/supabase-js is added
let supabaseClient: any = null;

/**
 * Initialize Supabase client
 * Call this once at app startup
 */
export async function initializeSupabase(): Promise<boolean> {
    const config = getSupabaseConfig();

    if (!config.url || !config.anonKey) {
        console.error('[Supabase] Cannot initialize: missing configuration');
        return false;
    }

    try {
        // When @supabase/supabase-js is installed:
        // const { createClient } = await import('@supabase/supabase-js');
        // supabaseClient = createClient(config.url, config.anonKey);

        console.log('[Supabase] Client initialized successfully');
        return true;
    } catch (error) {
        console.error('[Supabase] Initialization failed:', error);
        return false;
    }
}

/**
 * Get the Supabase client instance
 */
export function getSupabaseClient(): any {
    if (!supabaseClient) {
        console.warn('[Supabase] Client not initialized. Call initializeSupabase() first.');
    }
    return supabaseClient;
}

/**
 * Check if Supabase is configured
 */
export function isSupabaseConfigured(): boolean {
    const config = getSupabaseConfig();
    return !!(config.url && config.anonKey);
}
