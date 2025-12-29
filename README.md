# AutonomousVault v0.04

**Advanced Non-Custodial Autonomous Trading System**

AutonomousVault v0.04 represents the next-generation architecture for the AutonomousVault non-custodial autonomous trading system. It features a clear separation of concerns, VPS integration for continuous operation, and advanced AI-driven trading logic.

---

## 🚀 Key Features

- **🛡️ Non-Custodial & Secure**: Private keys remain on the client. Transactions are signed locally or via secure, user-authorized server execution.
- **🧠 AI-Driven Trading**: Deep integration with Google Gemini for market analysis, reasoning, and decision making.
- **☁️ VPS & Cloud Sync**: Seamless synchronization between local client and VPS Agent for 24/7 operation and data persistence.
- **⚡ High-Performance Architecture**:
    - **Core**: Pure business logic (TypeScript) with zero dependencies.
    - **Adapters**: Clean interfaces for external services (Hyperliquid, AI, Storage).
    - **Infra**: Robust infrastructure layer using Supabase.
    - **Client**: Modern React + Vite frontend with real-time updates and TailwindCSS styling.
- **📊 Advanced Analytics**: Real-time visualization of market data, indicators, and AI reasoning logs.

---

## 🏗️ Architecture

The project follows a strict layered architecture (Monorepo style) to ensure maintainability and scalability:

```
AutonomousVault_v0.04/
├── core/              # Domain Core (PURE Logic) - No external dependencies
├── adapters/          # Interface Adapters (Ports) - Bridges Core to Outer World
├── infra/             # Infrastructure Implementations (Supabase, API Clients)
└── client/            # Frontend Application (React 19 + Vite)
```

### Module Responsibilities

- **@/core**: Contains the brain of the operation.
    - `dealer/`: Decision logic and position sizing.
    - `indicators/`: Technical indicator calculations.
    - `strategy/`: Market condition detection.
    - `types/`: Shared type definitions.

- **@/adapters**: Defines how the core communicates with the outside world.
    - `execution/`: Trade execution interfaces.
    - `market-data/`: APIs for fetching price and volume data.
    - `ai/`: Interfaces for AI providers.

- **@/infra**: Specific implementations.
    - `supabase/`: Database, Auth, and Edge Functions.

- **@/client**: The user interface that ties everything together, handling user interaction and visualization.
    - **Tech Stack**: React 19, Vite, TailwindCSS, Radix UI, Framer Motion.

---

## 🔒 Non-Custodial Guarantees

This system observes strict security protocols:

- **NEVER** signs transactions without explicit user activation.
- **NEVER** moves funds arbitrarily.
- **NEVER** persists decrypted private keys.
- **NEVER** recovers or bypasses user passwords.

Server-side execution (if enabled via VPS) requires explicit user authorization and uses encrypted parameters.

---

## 🛠️ Installation & Setup

### Prerequisites
- **Node.js**: v22 or higher
- **Package Manager**: npm or pnpm

### Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Lipe-lx/AI-AgentVault_v1.git
    cd AutonomousVault_v0.04
    ```

2.  **Install Dependencies:**
    All dependencies are managed within the `client` directory (which coordinates the monorepo-style imports).
    ```bash
    cd client
    npm install
    # or
    yarn install
    ```

3.  **Environment Configuration:**
    Ensure you have the necessary API keys configured (Google GenAI, Supabase, Hyperliquid Wallet).
    *Create a `.env` file in the `client/` directory if required, following the project's environment variable standards.*

4.  **Run Development Server:**
    Start the local frontend application.
    ```bash
    npm run dev
    ```
    The application will be available at `http://localhost:5173`.

---

## ⚙️ Configuration & Usage

### 1. Dashboard Overview
The dashboard provides a real-time view of:
- **Market Data**: Prices, charts, and indicators.
- **Dealer Status**: Active/Inactive state of the autonomous trader.
- **Analysis**: AI-generated market analysis and trade reasoning.

### 2. VPS Agent Integration
To enable 24/7 trading without keeping your local machine on:
- Use the **VPS Toggle** in the UI to connect/disconnect the VPS Agent.
- The system automatically syncs "Thinking" logs and trade history from the VPS to your local client, ensuring you never miss an action.

### 3. Strategy Customization
- **Risk Management**: Configure Stop Loss, Take Profit, and position sizing in the settings.
- **Indicators**: Toggle and configure technical indicators (RSI, MACD, Bollinger Bands, etc.) to feed into the AI's decision process.

---

## 📦 Major Dependencies

- **Frontend**: `react`, `react-dom`, `vite`
- **Styling**: `tailwindcss`, `tailwindcss-animate`, `class-variance-authority`
- **UI Components**: `@radix-ui/*`, `lucide-react`, `framer-motion`
- **Blockchain**: `@solana/web3.js`, `@raydium-io/raydium-sdk`, `ethers`
- **AI**: `@google/genai`
- **Data**: `firebase`, `supabase`, `idb-keyval`
- **Analysis**: `technicalindicators`, `recharts`

---

## 📁 File Structure & Boundaries

Files are organized with strict boundary comments to enforce architectural rules:
```typescript
// DOMAIN CORE     - Pure logic, no dependencies
// ADAPTER         - Interface definitions
// SUPABASE INFRA  - Infrastructure implementation
// CLIENT-ONLY     - Must remain on client
```

---

*AutonomousVault v0.04 - Empowering Sovereign Trading.*
