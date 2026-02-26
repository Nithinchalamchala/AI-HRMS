# 🚀 AI-HRMS Platform

> A comprehensive AI-powered Human Resource Management System with Web3 integration built for the RizeOS Core Team Internship.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0+-blue.svg)](https://www.typescriptlang.org/)
[![React](https://img.shields.io/badge/React-18+-61DAFB.svg)](https://reactjs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-336791.svg)](https://www.postgresql.org/)
[![Tests](https://img.shields.io/badge/tests-passing-brightgreen.svg)](./test-api-simple.sh)

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Quick Start](#quick-start)
- [Testing](#testing)
- [Deployment](#deployment)
- [Documentation](#documentation)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Screenshots](#screenshots)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

AI-HRMS is a modern, full-stack workforce management platform that combines traditional HRMS functionality with AI-powered insights and blockchain integration. Built with scalability, security, and user experience in mind.

**Current Status:** ✅ MVP Complete (77% - 30/39 tasks)

## ✨ Features

## ✨ Features

### 🔐 Authentication & Security
- JWT-based authentication with refresh tokens
- Bcrypt password hashing
- Multi-tenancy with complete data isolation
- Protected routes and API endpoints
- Input validation and sanitization

### 👥 Employee Management
- Complete CRUD operations for employees
- Skills and role tracking
- Department organization
- Status management (active/inactive)
- Advanced filtering and search

### 📋 Task Management
- Create and assign tasks to employees
- Status tracking (assigned → in_progress → completed)
- Complexity and time estimation
- Due date management
- Task filtering by status, employee, department

### 📊 Dashboard & Analytics
- Real-time metrics and KPIs
- Employee statistics
- Task completion rates
- Productivity indicators
- Visual data representation

### 🤖 AI-Powered Features
- **Productivity Scoring**: Automatic calculation based on task completion (0-100 scale)
- **Skill Gap Detection**: Identify missing skills for roles (Coming Soon)
- **Smart Task Assignment**: AI-recommended employee matching (Coming Soon)
- **Performance Trends**: Predict performance changes (Coming Soon)

### 🔗 Web3 Integration (Coming Soon)
- Blockchain logging on Polygon network
- Smart contract for workforce events
- Wallet connection (MetaMask/Phantom)
- On-chain activity verification

## 🛠 Tech Stack

## 🛠 Tech Stack

### Backend
- **Runtime**: Node.js 18+
- **Framework**: Express.js
- **Language**: TypeScript
- **Database**: PostgreSQL 15+
- **Authentication**: JWT (jsonwebtoken)
- **Password Hashing**: bcrypt
- **Validation**: express-validator
- **Testing**: Jest, ts-jest

### Frontend
- **Framework**: React 18+
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Routing**: React Router v6
- **State Management**: React Context + React Query
- **HTTP Client**: Axios
- **Build Tool**: Vite

### Blockchain (Coming Soon)
- **Network**: Polygon (Mumbai Testnet)
- **Smart Contracts**: Solidity
- **Development**: Hardhat
- **Library**: ethers.js

### DevOps & Tools
- **Version Control**: Git
- **Package Manager**: npm
- **Code Quality**: ESLint, Prettier
- **Testing**: Jest, Automated API tests

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ installed
- PostgreSQL 15+ installed and running
- npm or yarn package manager

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/Nithinchalamchala/AI-HRMS.git
cd AI-HRMS
```

2. **Run automated setup** (macOS/Linux)
```bash
chmod +x setup-and-test.sh
./setup-and-test.sh
```

Or follow manual setup:

3. **Install backend dependencies**
```bash
cd backend
npm install
```

4. **Install frontend dependencies**
```bash
cd frontend
npm install
```

5. **Setup PostgreSQL database**
```bash
createdb ai_hrms
```

6. **Configure environment variables**
```bash
# Backend
cp backend/.env.example backend/.env
# Edit backend/.env with your database credentials

# Frontend
cp frontend/.env.example frontend/.env
```

7. **Run database migrations**
```bash
cd backend
npm run migrate
npm run seed  # Optional: seed with sample data
```

8. **Start the servers**

Backend:
```bash
cd backend
npm run dev
# Server runs on http://localhost:3000
```

Frontend (in new terminal):
```bash
cd frontend
npm run dev
# App runs on http://localhost:5173
```

9. **Open the application**
```bash
open http://localhost:5173
```

### 🎬 Demo Account (Pre-configured)

For quick testing and video demonstrations, use the pre-configured demo account:

```
Email: demo@techcorp.com
Password: Demo123!
```

**What's included:**
- 10 employees across 4 departments
- 15 tasks with various statuses
- Productivity scores and AI data
- All features ready to demonstrate

**To reset demo data:**
```bash
cd backend
npm run seed
```

## 🧪 Testing

### Automated API Tests
```bash
# Run automated test suite
./test-api-simple.sh

# Expected output: 7/7 tests passing
```

### Backend Unit Tests
```bash
cd backend
npm test

# Run with coverage
npm run test:coverage
```

### Manual Testing
Follow the comprehensive testing guide:
```bash
open COMPLETE_TESTING_GUIDE.md
```

**Test Coverage:**
- ✅ Backend API: 7/7 automated tests passing
- ✅ Unit Tests: 16/16 passing
- ⏳ Frontend UI: Manual testing ready
- ⏳ Integration: Ready for testing

## 🚀 Deployment

Ready to deploy your app to production? We've got you covered!

### Quick Deploy (40 minutes)
Deploy your AI-HRMS platform using:
- **Frontend**: Vercel (free tier available)
- **Backend**: Render (free tier available)
- **Database**: Render PostgreSQL (free tier available)

### Deployment Guides

Choose the guide that fits your style:

- **[DEPLOYMENT_QUICK_REFERENCE.md](./DEPLOYMENT_QUICK_REFERENCE.md)** - One-page quick reference
- **[VERCEL_RENDER_DEPLOYMENT.md](./VERCEL_RENDER_DEPLOYMENT.md)** - Complete step-by-step guide
- **[DEPLOYMENT_CHECKLIST.md](./DEPLOYMENT_CHECKLIST.md)** - Interactive checklist
- **[DEPLOYMENT_SUMMARY.md](./DEPLOYMENT_SUMMARY.md)** - Overview and guide selection

### Quick Start Deployment

```bash
# 1. Generate JWT secrets
./generate-secrets.sh

# 2. Follow the deployment guide
open DEPLOYMENT_QUICK_REFERENCE.md

# 3. Deploy backend to Render (15 min)
# 4. Deploy frontend to Vercel (10 min)
# 5. Test your live app!
```

**Cost**: Free tier available ($0/month) or production tier ($34/month)

## 📚 Documentation

Comprehensive documentation is available:

- **[QUICK_START.md](./QUICK_START.md)** - 5-minute setup guide
- **[SETUP_GUIDE.md](./SETUP_GUIDE.md)** - Detailed installation instructions
- **[HOW_TO_TEST.md](./HOW_TO_TEST.md)** - Testing overview
- **[COMPLETE_TESTING_GUIDE.md](./COMPLETE_TESTING_GUIDE.md)** - 33 detailed test cases
- **[TESTING_SUMMARY.md](./TESTING_SUMMARY.md)** - Current test status
- **[IMPLEMENTATION_STATUS.md](./IMPLEMENTATION_STATUS.md)** - Feature completion status
- **[GTM_STRATEGY.md](./GTM_STRATEGY.md)** - Go-to-market strategy

## 📁 Project Structure

```
AI-HRMS/
├── backend/                 # Node.js/Express backend
│   ├── src/
│   │   ├── config/         # Configuration files
│   │   ├── controllers/    # Route controllers
│   │   ├── database/       # Database migrations & seeds
│   │   ├── middleware/     # Express middleware
│   │   ├── routes/         # API routes
│   │   ├── services/       # Business logic
│   │   └── utils/          # Utility functions
│   ├── package.json
│   └── tsconfig.json
├── frontend/               # React frontend
│   ├── src/
│   │   ├── components/    # Reusable components
│   │   ├── contexts/      # React contexts
│   │   ├── lib/           # Utilities & API client
│   │   ├── pages/         # Page components
│   │   └── main.tsx       # Entry point
│   ├── package.json
│   └── vite.config.ts
├── blockchain/            # Smart contracts (coming soon)
├── .kiro/                 # Kiro AI specs
├── docs/                  # Documentation
└── tests/                 # Test scripts
```

## 🔌 API Endpoints

### Authentication
- `POST /api/auth/register` - Register organization
- `POST /api/auth/login` - Login and get JWT tokens
- `POST /api/auth/refresh` - Refresh access token

### Employees
- `GET /api/employees` - List all employees
- `GET /api/employees/:id` - Get employee by ID
- `POST /api/employees` - Create new employee
- `PUT /api/employees/:id` - Update employee
- `DELETE /api/employees/:id` - Delete employee

### Tasks
- `GET /api/tasks` - List all tasks
- `GET /api/tasks/:id` - Get task by ID
- `POST /api/tasks` - Create new task
- `PUT /api/tasks/:id` - Update task
- `PATCH /api/tasks/:id/status` - Update task status
- `DELETE /api/tasks/:id` - Delete task

### Dashboard
- `GET /api/dashboard/metrics` - Get dashboard metrics
- `GET /api/dashboard/trends` - Get trend data

### AI Features
- `GET /api/ai/productivity/:employeeId` - Get productivity score
- `POST /api/ai/batch-calculate` - Calculate all scores

### Health
- `GET /api/health` - Health check endpoint

**Full API documentation:** See [API.md](./docs/API.md) (coming soon)

## 📸 Screenshots

### Dashboard
![Dashboard](./docs/screenshots/dashboard.png)
*Real-time metrics and productivity indicators*

### Employee Management
![Employees](./docs/screenshots/employees.png)
*Complete employee CRUD with skills tracking*

### Task Management
![Tasks](./docs/screenshots/tasks.png)
*Task assignment and status tracking*

### Productivity Scores
![Productivity](./docs/screenshots/productivity.png)
*AI-powered productivity scoring*

## 🗺 Roadmap

### ✅ Phase 1: Core MVP (Complete)
- [x] Authentication system
- [x] Employee management
- [x] Task management
- [x] Dashboard metrics
- [x] AI productivity scoring
- [x] Frontend UI
- [x] Testing infrastructure

### 🚧 Phase 2: Advanced AI (In Progress)
- [ ] Skill gap detection
- [ ] Smart task assignment
- [ ] Performance trend prediction
- [ ] Advanced analytics

### 📋 Phase 3: Web3 Integration (Planned)
- [ ] Smart contract development
- [ ] Wallet connection
- [ ] On-chain logging
- [ ] Transaction verification

### 🎯 Phase 4: Production Ready (Planned)
- [ ] Comprehensive testing
- [ ] Performance optimization
- [ ] Security hardening
- [ ] Deployment setup
- [ ] CI/CD pipeline

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Nithin Chalamchala**
- GitHub: [@Nithinchalamchala](https://github.com/Nithinchalamchala)
- Project: Built for RizeOS Core Team Internship

## 🙏 Acknowledgments

- RizeOS for the internship opportunity
- Open source community for amazing tools and libraries
- All contributors and testers

## 📞 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check the [documentation](./docs/)
- Review the [testing guide](./COMPLETE_TESTING_GUIDE.md)

---

**⭐ Star this repository if you find it helpful!**

**🚀 Built with passion for the RizeOS Core Team Internship**
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
