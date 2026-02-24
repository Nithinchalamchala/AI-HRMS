# AI-HRMS Platform - Setup & Installation Guide

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v18 or higher) - [Download](https://nodejs.org/)
- **PostgreSQL** (v14 or higher) - [Download](https://www.postgresql.org/download/)
- **npm** or **yarn** package manager
- **Git** for version control

## Project Structure

```
ai-hrms-platform/
├── backend/          # Node.js/Express API
├── frontend/         # React application
├── blockchain/       # Solidity smart contracts (optional)
└── .kiro/           # Spec files
```

## Backend Setup

### 1. Install Dependencies

```bash
cd backend
npm install
```

### 2. Database Setup

Create a PostgreSQL database:

```bash
# Login to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE ai_hrms;

# Exit psql
\q
```

### 3. Configure Environment Variables

```bash
cp .env.example .env
```

Edit `.env` with your configuration:

```env
# Server
NODE_ENV=development
PORT=3000

# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=ai_hrms
DB_USER=postgres
DB_PASSWORD=your_password_here

# JWT Secrets (change these in production!)
JWT_SECRET=your_super_secret_jwt_key_change_this
JWT_EXPIRES_IN=1h
JWT_REFRESH_SECRET=your_super_secret_refresh_key_change_this
JWT_REFRESH_EXPIRES_IN=7d

# CORS
CORS_ORIGIN=http://localhost:5173
```

### 4. Run Database Migrations

```bash
npm run migrate
```

This will create all necessary tables:
- organizations
- employees
- tasks
- productivity_scores
- blockchain_transactions
- skill_taxonomy
- role_requirements
- notifications

### 5. Seed Database (Optional but Recommended)

```bash
npm run seed
```

This populates:
- 35+ skills in the skill taxonomy
- 10 role templates with required skills

### 6. Start Backend Server

```bash
# Development mode with auto-reload
npm run dev

# Production mode
npm run build
npm start
```

Backend will run on `http://localhost:3000`

### 7. Verify Backend

Test the health endpoint:

```bash
curl http://localhost:3000/api/health
```

Expected response:
```json
{
  "status": "healthy",
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

## Frontend Setup

### 1. Install Dependencies

```bash
cd frontend
npm install
```

### 2. Configure Environment Variables

```bash
cp .env.example .env
```

Edit `.env`:

```env
VITE_API_BASE_URL=http://localhost:3000/api
```

### 3. Start Frontend Development Server

```bash
npm run dev
```

Frontend will run on `http://localhost:5173`

### 4. Build for Production

```bash
npm run build
npm run preview
```

## First Time Usage

### 1. Register Your Organization

1. Open `http://localhost:5173` in your browser
2. Click "Sign up" on the login page
3. Fill in your organization details:
   - Organization Name: Your Company Name
   - Email: admin@yourcompany.com
   - Password: Must be 8+ chars with uppercase, lowercase, and number
   - Industry: (Optional) e.g., Technology

### 2. Login

1. Use your registered email and password
2. You'll be redirected to the dashboard

### 3. Add Employees

1. Navigate to "Employees" in the sidebar
2. Click "Add Employee"
3. Fill in employee details:
   - Name, Email, Role, Department
   - Skills (comma-separated): e.g., "JavaScript, React, Node.js"
4. Click "Save"

### 4. Create Tasks

1. Navigate to "Tasks"
2. Click "Add Task"
3. Fill in task details:
   - Title and Description
   - Assign to an employee
   - Set complexity (Low/Medium/High)
   - Optional: Set due date
4. Click "Save"

### 5. Track Productivity

1. Update task statuses as work progresses:
   - Assigned → In Progress → Completed
2. Navigate to "Productivity" to view AI-generated scores
3. Click "Recalculate All" to refresh scores

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register organization
- `POST /api/auth/login` - Login
- `POST /api/auth/refresh` - Refresh token
- `GET /api/auth/me` - Get current organization

### Employees
- `POST /api/employees` - Create employee
- `GET /api/employees` - List employees
- `GET /api/employees/:id` - Get employee
- `PUT /api/employees/:id` - Update employee
- `DELETE /api/employees/:id` - Delete employee
- `POST /api/employees/:id/wallet` - Connect wallet

### Tasks
- `POST /api/tasks` - Create task
- `GET /api/tasks` - List tasks
- `GET /api/tasks/:id` - Get task
- `PUT /api/tasks/:id` - Update task
- `PATCH /api/tasks/:id/status` - Update status
- `DELETE /api/tasks/:id` - Delete task

### Dashboard
- `GET /api/dashboard/metrics` - Get metrics
- `GET /api/dashboard/trends` - Get trends

### AI
- `GET /api/ai/productivity/:employeeId` - Get score
- `POST /api/ai/batch-calculate` - Recalculate all
- `GET /api/ai/scores` - Get all scores

## Testing

### Backend Tests

```bash
cd backend
npm test
```

Runs all unit tests and property-based tests.

### Frontend Tests

```bash
cd frontend
npm test
```

## Troubleshooting

### Database Connection Issues

**Error:** "Connection refused"

**Solution:**
1. Ensure PostgreSQL is running: `pg_ctl status`
2. Check database credentials in `.env`
3. Verify database exists: `psql -U postgres -l`

### Port Already in Use

**Error:** "Port 3000 is already in use"

**Solution:**
1. Change PORT in backend `.env`
2. Or kill the process: `lsof -ti:3000 | xargs kill`

### CORS Errors

**Error:** "CORS policy blocked"

**Solution:**
1. Ensure `CORS_ORIGIN` in backend `.env` matches frontend URL
2. Restart backend server after changing `.env`

### JWT Token Expired

**Error:** "Token expired"

**Solution:**
- The app automatically refreshes tokens
- If issues persist, logout and login again

## Production Deployment

### Backend

1. Set `NODE_ENV=production` in `.env`
2. Use strong JWT secrets
3. Configure proper database credentials
4. Set up SSL/TLS
5. Use a process manager like PM2:

```bash
npm install -g pm2
pm2 start dist/index.js --name ai-hrms-backend
```

### Frontend

1. Build the production bundle:

```bash
npm run build
```

2. Serve the `dist` folder using:
   - Nginx
   - Apache
   - Vercel
   - Netlify

### Environment Variables for Production

**Backend:**
- Use strong, random JWT secrets
- Enable HTTPS
- Configure production database
- Set appropriate CORS origins

**Frontend:**
- Point `VITE_API_BASE_URL` to production API

## Features Implemented

✅ **Core HRMS**
- Organization authentication (JWT)
- Employee management (CRUD)
- Task management with status tracking
- Real-time dashboard metrics

✅ **AI Features**
- Productivity scoring algorithm
- Automatic score calculation on task completion
- Batch score recalculation
- Performance rankings

✅ **Security**
- Password hashing (bcrypt, 10 rounds)
- JWT authentication with refresh tokens
- Multi-tenancy data isolation
- Input validation & sanitization
- CORS protection

✅ **Frontend**
- Responsive React UI with Tailwind CSS
- Protected routes
- Real-time updates with React Query
- Toast notifications
- Modal forms

## Next Steps (Optional Enhancements)

- Implement blockchain integration (Polygon)
- Add skill gap detection
- Add smart task assignment recommendations
- Add performance trend prediction
- Implement data export (CSV/JSON)
- Add email notifications
- Deploy to cloud (AWS/Azure/GCP)

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review the API documentation
3. Check backend logs in `logs/` directory
4. Verify database migrations ran successfully

## License

MIT
