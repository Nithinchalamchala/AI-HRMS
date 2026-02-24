# 🧪 Testing Checklist - AI-HRMS Platform

## Current Status
✅ Backend code implemented
✅ Frontend code implemented  
✅ npm packages installed (backend)
❌ PostgreSQL not installed
❌ Database not created
❌ Environment variables not configured
❌ Frontend packages not installed

## 📋 Pre-Testing Setup Steps

### Step 1: Install PostgreSQL

**On macOS:**
```bash
# Option A: Using Homebrew (recommended)
brew install postgresql@15
brew services start postgresql@15

# Option B: Download from postgresql.org
# Visit: https://www.postgresql.org/download/macosx/
```

**Verify installation:**
```bash
psql --version
# Should show: psql (PostgreSQL) 15.x
```

### Step 2: Create Database

```bash
# Create the database
createdb ai_hrms

# Verify it was created
psql -l | grep ai_hrms
```

### Step 3: Configure Backend Environment

```bash
# Copy the example file
cp backend/.env.example backend/.env

# Edit backend/.env with your settings
# Required changes:
# - DB_PASSWORD (your PostgreSQL password, or leave empty if no password)
# - JWT_SECRET (any random string)
# - JWT_REFRESH_SECRET (another random string)
```

**Quick setup command:**
```bash
cat > backend/.env << 'EOF'
NODE_ENV=development
PORT=3000

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=ai_hrms
DB_USER=postgres
DB_PASSWORD=
DB_POOL_MIN=2
DB_POOL_MAX=10

# JWT Configuration
JWT_SECRET=my-super-secret-jwt-key-for-development-12345
JWT_REFRESH_SECRET=my-super-secret-refresh-key-for-development-67890
JWT_EXPIRES_IN=1h
JWT_REFRESH_EXPIRES_IN=7d

# CORS Configuration
CORS_ORIGIN=http://localhost:5173

# Logging
LOG_LEVEL=info
EOF
```

### Step 4: Run Database Migrations

```bash
npm run migrate --prefix backend
```

**Expected output:**
```
Running migrations...
✓ 001_create_organizations.sql
✓ 002_create_employees.sql
✓ 003_create_tasks.sql
✓ 004_create_productivity_scores.sql
✓ 005_create_blockchain_transactions.sql
✓ 006_create_skill_taxonomy.sql
✓ 007_create_role_requirements.sql
✓ 008_create_notifications.sql
All migrations completed successfully!
```

### Step 5: Seed Database (Optional)

```bash
npm run seed --prefix backend
```

**Expected output:**
```
Seeding database...
✓ Inserted 35 skills
✓ Inserted 10 role requirements
Database seeded successfully!
```

### Step 6: Install Frontend Packages

```bash
npm install --prefix frontend
```

### Step 7: Configure Frontend Environment

```bash
# Copy the example file
cp frontend/.env.example frontend/.env
```

**Quick setup command:**
```bash
cat > frontend/.env << 'EOF'
VITE_API_BASE_URL=http://localhost:3000/api
EOF
```

---

## 🧪 Testing Plan

### Phase 1: Backend Unit Tests

```bash
# Run all backend tests
npm test --prefix backend

# Run tests with coverage
npm run test:coverage --prefix backend
```

**What to verify:**
- ✅ All tests pass
- ✅ Code coverage > 80%
- ✅ No failing assertions

**Expected tests:**
- Password hashing tests
- Database constraint tests
- Authentication tests
- Task status transition tests

### Phase 2: Backend API Testing

#### 2.1 Start Backend Server

```bash
npm run dev --prefix backend
```

**Expected output:**
```
Server running on port 3000
Environment: development
Database connected successfully
```

**Verify:**
- ✅ No error messages
- ✅ Server starts on port 3000
- ✅ Database connection successful

#### 2.2 Test Health Endpoint

```bash
curl http://localhost:3000/api/health
```

**Expected response:**
```json
{
  "status": "healthy",
  "timestamp": "2024-02-24T...",
  "database": "connected"
}
```

#### 2.3 Test Authentication Flow

**Register Organization:**
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Company",
    "email": "admin@testcompany.com",
    "password": "Admin123!",
    "industry": "Technology"
  }'
```

**Expected response:**
```json
{
  "message": "Organization registered successfully",
  "organizationId": 1
}
```

**Login:**
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@testcompany.com",
    "password": "Admin123!"
  }'
```

**Expected response:**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "organization": {
    "id": 1,
    "name": "Test Company",
    "email": "admin@testcompany.com"
  }
}
```

**Save the accessToken for next tests!**

#### 2.4 Test Employee Management

**Create Employee:**
```bash
# Replace YOUR_TOKEN with the accessToken from login
curl -X POST http://localhost:3000/api/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "name": "John Doe",
    "email": "john@testcompany.com",
    "role": "Frontend Developer",
    "department": "Engineering",
    "skills": ["JavaScript", "React", "TypeScript"]
  }'
```

**Expected response:**
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@testcompany.com",
  "role": "Frontend Developer",
  "department": "Engineering",
  "skills": ["JavaScript", "React", "TypeScript"],
  "status": "active"
}
```

**List Employees:**
```bash
curl http://localhost:3000/api/employees \
  -H "Authorization: Bearer YOUR_TOKEN"
```

#### 2.5 Test Task Management

**Create Task:**
```bash
curl -X POST http://localhost:3000/api/tasks \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "title": "Build login page",
    "description": "Create responsive login UI with validation",
    "assigned_to": 1,
    "complexity": "medium",
    "estimated_hours": 8
  }'
```

**Update Task Status:**
```bash
curl -X PATCH http://localhost:3000/api/tasks/1/status \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "status": "in_progress"
  }'
```

**Complete Task:**
```bash
curl -X PATCH http://localhost:3000/api/tasks/1/status \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "status": "completed"
  }'
```

#### 2.6 Test Dashboard Metrics

```bash
curl http://localhost:3000/api/dashboard/metrics \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected response:**
```json
{
  "totalEmployees": 1,
  "activeEmployees": 1,
  "assignedTasks": 0,
  "completedTasks": 1,
  "completionRate": 100,
  "averageProductivityScore": 75
}
```

#### 2.7 Test AI Productivity Scoring

```bash
curl http://localhost:3000/api/ai/productivity/1 \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected response:**
```json
{
  "employeeId": 1,
  "score": 75,
  "completionRate": 100,
  "averageCompletionTime": 8,
  "calculatedAt": "2024-02-24T..."
}
```

### Phase 3: Frontend Testing

#### 3.1 Start Frontend Server

```bash
npm run dev --prefix frontend
```

**Expected output:**
```
VITE v5.x.x  ready in xxx ms

➜  Local:   http://localhost:5173/
➜  Network: use --host to expose
```

#### 3.2 Manual UI Testing

Open browser to: **http://localhost:5173**

**Test Registration:**
1. ✅ Click "Sign up" link
2. ✅ Fill in organization details
3. ✅ Submit form
4. ✅ See success message
5. ✅ Redirect to login page

**Test Login:**
1. ✅ Enter email and password
2. ✅ Click "Login"
3. ✅ Redirect to dashboard
4. ✅ See dashboard metrics

**Test Employee Management:**
1. ✅ Click "Employees" in sidebar
2. ✅ Click "Add Employee" button
3. ✅ Fill in employee form
4. ✅ Submit form
5. ✅ See employee in list
6. ✅ Click edit icon
7. ✅ Update employee details
8. ✅ See updated data

**Test Task Management:**
1. ✅ Click "Tasks" in sidebar
2. ✅ Click "Add Task" button
3. ✅ Fill in task form
4. ✅ Select employee from dropdown
5. ✅ Submit form
6. ✅ See task in list
7. ✅ Change status dropdown: Assigned → In Progress → Completed
8. ✅ See status update

**Test Dashboard:**
1. ✅ Click "Dashboard" in sidebar
2. ✅ See total employees count
3. ✅ See active employees count
4. ✅ See task counts
5. ✅ See productivity indicators
6. ✅ Metrics update after completing tasks

**Test Productivity Page:**
1. ✅ Click "Productivity" in sidebar
2. ✅ See employee list with scores
3. ✅ Click "Recalculate All" button
4. ✅ See updated scores
5. ✅ Scores reflect task completion

**Test Responsive Design:**
1. ✅ Resize browser window
2. ✅ Test on tablet size (768px)
3. ✅ Sidebar collapses on mobile
4. ✅ Tables remain usable

**Test Error Handling:**
1. ✅ Try invalid login credentials
2. ✅ See error message
3. ✅ Try creating employee with duplicate email
4. ✅ See validation error
5. ✅ Try invalid task status transition
6. ✅ See error message

### Phase 4: Integration Testing

#### 4.1 End-to-End User Flow

**Complete workflow test:**
1. ✅ Register new organization
2. ✅ Login with credentials
3. ✅ Create 3 employees
4. ✅ Create 5 tasks assigned to different employees
5. ✅ Update task statuses
6. ✅ Complete 3 tasks
7. ✅ View dashboard - verify metrics
8. ✅ View productivity scores
9. ✅ Logout
10. ✅ Login again - verify data persists

#### 4.2 Multi-Tenancy Testing

**Test data isolation:**
1. ✅ Register Organization A
2. ✅ Create employees and tasks for Org A
3. ✅ Logout
4. ✅ Register Organization B
5. ✅ Create employees and tasks for Org B
6. ✅ Verify Org B cannot see Org A's data
7. ✅ Login as Org A again
8. ✅ Verify Org A data is intact and isolated

#### 4.3 Security Testing

**Test authentication:**
1. ✅ Try accessing API without token - should get 401
2. ✅ Try accessing with expired token - should get 401
3. ✅ Try accessing with invalid token - should get 401

**Test authorization:**
1. ✅ Try accessing another org's data - should get 403
2. ✅ Try SQL injection in inputs - should be sanitized
3. ✅ Try XSS in text fields - should be escaped

### Phase 5: Performance Testing

```bash
# Install Apache Bench (if not installed)
# brew install httpd (on macOS)

# Test API performance
ab -n 1000 -c 10 http://localhost:3000/api/health
```

**Verify:**
- ✅ Response time < 100ms for simple endpoints
- ✅ Response time < 500ms for complex queries
- ✅ No memory leaks during load
- ✅ Database connections properly pooled

---

## 📊 Test Results Template

### Backend Tests
- [ ] Unit tests: __/__ passed
- [ ] Code coverage: __%
- [ ] Health endpoint: ✅/❌
- [ ] Auth endpoints: ✅/❌
- [ ] Employee endpoints: ✅/❌
- [ ] Task endpoints: ✅/❌
- [ ] Dashboard endpoints: ✅/❌
- [ ] AI endpoints: ✅/❌

### Frontend Tests
- [ ] Registration flow: ✅/❌
- [ ] Login flow: ✅/❌
- [ ] Employee CRUD: ✅/❌
- [ ] Task CRUD: ✅/❌
- [ ] Dashboard display: ✅/❌
- [ ] Productivity page: ✅/❌
- [ ] Responsive design: ✅/❌
- [ ] Error handling: ✅/❌

### Integration Tests
- [ ] End-to-end flow: ✅/❌
- [ ] Multi-tenancy: ✅/❌
- [ ] Security: ✅/❌
- [ ] Performance: ✅/❌

---

## 🐛 Common Issues & Solutions

### Issue: "Cannot connect to database"
**Solution:**
```bash
# Check if PostgreSQL is running
brew services list | grep postgresql

# Start PostgreSQL
brew services start postgresql@15

# Verify connection
psql -U postgres -c "SELECT version();"
```

### Issue: "Port 3000 already in use"
**Solution:**
```bash
# Find process using port 3000
lsof -ti:3000

# Kill the process
kill -9 $(lsof -ti:3000)

# Or change port in backend/.env
PORT=3001
```

### Issue: "JWT token invalid"
**Solution:**
- Ensure JWT_SECRET in .env matches between requests
- Check token hasn't expired (1 hour default)
- Verify Authorization header format: "Bearer <token>"

### Issue: "CORS error"
**Solution:**
- Verify backend is running
- Check CORS_ORIGIN in backend/.env matches frontend URL
- Restart backend after changing .env

### Issue: "Migration fails"
**Solution:**
```bash
# Drop and recreate database
dropdb ai_hrms
createdb ai_hrms

# Run migrations again
npm run migrate --prefix backend
```

---

## ✅ Success Criteria

Before moving to next implementation phase, verify:

- [ ] All backend unit tests pass
- [ ] All API endpoints respond correctly
- [ ] Frontend loads without errors
- [ ] Can register and login
- [ ] Can create employees
- [ ] Can create and complete tasks
- [ ] Dashboard shows correct metrics
- [ ] Productivity scores calculate correctly
- [ ] Multi-tenancy works (data isolation)
- [ ] No console errors in browser
- [ ] No server errors in backend logs

---

## 📝 Notes

- Keep backend and frontend running in separate terminals
- Check browser console for frontend errors
- Check backend terminal for API errors
- Use Postman or curl for API testing
- Take screenshots of working features for documentation

---

## 🎯 Next Steps After Testing

Once all tests pass:
1. Document any bugs found
2. Fix critical issues
3. Proceed with remaining features:
   - AI skill gap detection
   - Smart task assignment
   - Performance trend prediction
   - Blockchain integration
   - Advanced frontend features

---

**Ready to test? Start with Step 1: Install PostgreSQL!**
