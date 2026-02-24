# AI-HRMS Platform

A comprehensive full-stack workforce management platform with AI-powered insights and Web3 integration.

## Features

- **Organization & Employee Management**: Complete HRMS functionality with role-based access
- **Task Management**: Assign and track workforce tasks with status updates
- **AI Workforce Intelligence**:
  - Productivity scoring based on task completion
  - Skill gap detection and recommendations
  - Smart task assignment recommendations
  - Performance trend prediction
- **Web3 Integration**: Optional blockchain logging of workforce events on Polygon
- **Real-time Dashboard**: Comprehensive metrics and productivity indicators

## Tech Stack

- **Backend**: Node.js, Express, TypeScript, PostgreSQL
- **Frontend**: React, TypeScript, Tailwind CSS, React Query
- **Blockchain**: Solidity, Hardhat, Polygon (Mumbai testnet)
- **AI/ML**: Custom algorithms for workforce intelligence

## Project Structure

```
.
├── backend/          # Node.js/Express backend API
├── frontend/         # React frontend application
├── blockchain/       # Solidity smart contracts
└── .kiro/           # Spec files and documentation
```

## Getting Started

### Prerequisites

- Node.js 18+ and npm
- PostgreSQL 14+
- Redis (optional, for caching)
- MetaMask wallet (for Web3 features)

### Backend Setup

```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your configuration
npm run migrate
npm run seed
npm run dev
```

### Frontend Setup

```bash
cd frontend
npm install
cp .env.example .env
# Edit .env with your configuration
npm run dev
```

### Blockchain Setup

```bash
cd blockchain
npm install
cp .env.example .env
# Edit .env with your private key
npm run compile
npm run test
npm run deploy:testnet
```

## Development

- Backend runs on `http://localhost:3000`
- Frontend runs on `http://localhost:5173`
- API documentation available at `/api/docs` (after implementation)

## Testing

```bash
# Backend tests
cd backend && npm test

# Frontend tests
cd frontend && npm test

# Smart contract tests
cd blockchain && npm test
```

## License

MIT
