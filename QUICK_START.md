# 🚀 Quick Start Guide - AI-HRMS Platform

## ✅ What You Have

A complete, production-ready AI-powered HRMS platform with:
- Full-stack application (Backend + Frontend)
- AI productivity scoring
- Task management
- Employee management
- Real-time dashboard
- Secure authentication

## 📋 Prerequisites Check

Before starting, ensure you have:
- ✅ Node.js installed (v18+)
- ✅ PostgreSQL installed and running
- ✅ npm packages installed in backend (you just did this!)

## 🎯 5-Minute Setup

### Step 1: Create Database

```bash
# Option A: Using psql command line
createdb ai_hrms

# Option B: Using PostgreSQL GUI (pgAdmin, TablePlus, etc.)
# Create a new database named: ai_hrms
```

### Step 2: Configure Backend

```bash
cd backend

# Copy environment file
cp .env.example .env

# Edit .env file with your database credentials
# Change these lines:
# DB_PASSWORD=your_password_here
# JWT_SECRET=your_super_secret_jwt_key_change_this
# JWT_REFRESH_SECRET=your_super_secret_refresh_key_change_this
```

**Important:** Update these values in `.env`:
- `DB_PASSWORD` - Your PostgreSQL password
- `JWT_SECRET` - Any random string (e.g., "my-super-secret-key-123")
- `JWT_REFRESH_SECRET` - Another random string

### Step 3: Run Database Migrations

```bash
# Still in backend directory
npm run migrate
```

Expected output:
```
✓ Migration 001_create_organizations.sql completed successfully
✓ Migration 002_create_employees.sql completed successfully
✓ Migration 003_create_tasks.sql completed successfully
... (8 migrations total)
All migrations completed successfully
```

### Step 4: Seed Database (Optional but Recommended)

```bash
npm run seed
```

This adds:
- 35+ skills (JavaScript, Python, React, etc.)
- 10 role templates (Developer, Manager, Designer, etc.)

### Step 5: Start Backend

```bash
npm run dev
```

Expected output:
```
Server running on port 3000
Environment: development
Database connection successful
```

✅ Backend is now running at `http://localhost:3000`

### Step 6: Setup Frontend (New Terminal)

```bash
cd frontend

# Install packages
npm install

# Copy environment file
cp .env.example .env

# Start frontend
npm run dev
```

✅ Frontend is now running at `http://localhost:5173`

## 🎉 You're Ready!

Open your browser and go to: **http://localhost:5173**

## 📝 First Steps in the App

### 1. Register Your Organization
- Click "Sign up"
- Enter:
  - Organization Name: "My Company"
  - Email: "admin@mycompany.com"
  - Password: "Admin123" (must have uppercase, lowercase, number)
  - Industry: "Technology" (optional)
- Click "Create Account"

### 2. Login
- Use your email and password
- You'll see the dashboard

### 3. Add Your First Employee
- Click "Employees" in sidebar
- Click "Add Employee"
- Fill in:
  - Name: "John Doe"
  - Email: "john@mycompany.com"
  - Role: "Frontend Developer"
  - Department: "Engineering"
  - Skills: "JavaScript, React, TypeScript"
- Click "Save"

### 4. Create Your First Task
- Click "Tasks" in sidebar
- Click "Add Task"
- Fill in:
  - Title: "Build login page"
  - Description: "Create responsive login UI"
  - Assign To: Select "John Doe"
  - Complexity: "Medium"
- Click "Save"

### 5. Update Task Status
- In the tasks list, change status dropdown:
  - Assigned → In Progress → Completed
- Watch the dashboard metrics update!

### 6. View Productivity Scores
- Click "Productivity" in sidebar
- Click "Recalculate All" to generate scores
- See AI-calculated productivity rankings

## 🔍 Testing the API

You can test the API directly:

```bash
# Health check
curl http://localhost:3000/api/health

# Register (replace with your data)
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test Org","email":"test@test.com","password":"Test123"}'

# Login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"Test123"}'
```

## ❌ Troubleshooting

### Issue: "Database connection failed"

**Solution:**
1. Check PostgreSQL is running: `pg_ctl status`
2. Verify database exists: `psql -l | grep ai_hrms`
3. Check credentials in `backend/.env`

### Issue: "Port 3000 already in use"

**Solution:**
```bash
# Find and kill the process
lsof -ti:3000 | xargs kill

# Or change port in backend/.env
PORT=3001
```

### Issue: "CORS error in browser"

**Solution:**
1. Ensure backend is running
2. Check `CORS_ORIGIN` in `backend/.env` matches frontend URL
3. Restart backend after changing `.env`

### Issue: "npm run migrate fails"

**Solution:**
1. Ensure database exists: `createdb ai_hrms`
2. Check database credentials in `.env`
3. Verify PostgreSQL is running

### Issue: "Frontend shows blank page"

**Solution:**
1. Check browser console for errors
2. Ensure backend is running on port 3000
3. Check `VITE_API_BASE_URL` in `frontend/.env`

## 📊 What to Demo

1. **Authentication** - Register and login flow
2. **Employee Management** - Add, edit, delete employees
3. **Task Management** - Create tasks, update status
4. **Dashboard** - Real-time metrics
5. **AI Productivity** - Automatic score calculation
6. **Multi-tenancy** - Each organization sees only their data

## 🎓 For Your Submission

### Key Points to Highlight:

1. **Full-Stack Engineering**
   - Node.js/Express backend with TypeScript
   - React frontend with modern hooks
   - PostgreSQL database with proper schema

2. **AI Integration**
   - Productivity scoring algorithm
   - Automatic calculation on task completion
   - Performance rankings

3. **Architecture**
   - Multi-tenancy by design
   - JWT authentication
   - RESTful API design
   - Separation of concerns

4. **Security**
   - Password hashing (bcrypt)
   - JWT tokens with refresh
   - Input validation
   - SQL injection prevention

5. **Product Execution**
   - Complete MVP in working state
   - User-friendly interface
   - Real-world use cases
   - Scalable architecture

## 📁 Important Files to Review

- `IMPLEMENTATION_STATUS.md` - Complete feature list
- `SETUP_GUIDE.md` - Detailed installation guide
- `GTM_STRATEGY.md` - Go-to-market strategy
- `backend/src/controllers/` - API logic
- `frontend/src/pages/` - UI components

## 🚀 Next Steps

1. Test all features thoroughly
2. Take screenshots for documentation
3. Record a demo video (optional)
4. Prepare your presentation
5. Submit with confidence!

## 💡 Tips

- The app auto-saves as you work
- Logout/login to test authentication
- Try creating multiple employees and tasks
- Watch productivity scores update
- Test on different screen sizes

## 🎯 Success Criteria Met

✅ Organization onboarding
✅ Employee management
✅ Task tracking with status
✅ AI productivity scoring
✅ Dashboard with metrics
✅ Secure authentication
✅ Responsive UI
✅ Multi-tenancy
✅ Clean code architecture
✅ Complete documentation

---

**Need Help?** Check:
1. SETUP_GUIDE.md for detailed instructions
2. IMPLEMENTATION_STATUS.md for feature list
3. Backend logs in `backend/logs/` directory
4. Browser console for frontend errors

**You're all set! Good luck with your submission! 🎉**
