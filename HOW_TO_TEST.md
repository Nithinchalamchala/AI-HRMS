# 🧪 How to Test AI-HRMS Platform

## Quick Start

You have **3 ways** to test the platform:

### 1. 🤖 Automated API Testing (5 minutes)
Run the automated test script:
```bash
./test-api.sh
```

This will automatically test all 13 backend API endpoints and give you a pass/fail report.

### 2. 🌐 Manual UI Testing (20 minutes)
1. Open browser: **http://localhost:5173**
2. Follow the step-by-step guide in `COMPLETE_TESTING_GUIDE.md`
3. Test all features through the user interface

### 3. 🔧 Manual API Testing (15 minutes)
Use curl commands from `COMPLETE_TESTING_GUIDE.md` to test each endpoint individually.

---

## 📚 Testing Documentation

We've created comprehensive testing guides for you:

### Main Testing Guide
**File:** `COMPLETE_TESTING_GUIDE.md`
- 33 detailed test cases
- Step-by-step instructions
- Expected results for each test
- Pass/fail criteria
- Bug tracking template

### Quick Reference
**File:** `TESTING_QUICK_REFERENCE.md`
- Quick commands
- Common troubleshooting
- Server management
- Database operations

### Test Results
**File:** `TEST_RESULTS.md`
- Current test status
- What's been tested
- Known issues
- Next steps

### Full Checklist
**File:** `TESTING_CHECKLIST.md`
- Complete setup steps
- Troubleshooting guide
- Performance testing
- Security testing

---

## 🎯 Recommended Testing Order

### Phase 1: Verify Setup (5 min)
```bash
# 1. Check servers are running
curl http://localhost:3000/api/health
curl http://localhost:5173

# 2. Run automated tests
./test-api.sh
```

### Phase 2: Test UI (20 min)
1. Open http://localhost:5173
2. Test registration and login
3. Test employee management
4. Test task management
5. Test dashboard and productivity

### Phase 3: Test Integration (10 min)
1. Complete end-to-end user flow
2. Test multi-tenancy isolation
3. Test task completion workflow

### Phase 4: Test Security (5 min)
1. Test authentication protection
2. Test authorization
3. Test input validation

**Total Time: ~40 minutes**

---

## 🚀 Quick Test Commands

### Automated Testing
```bash
# Run all API tests
./test-api.sh

# Run backend unit tests
npm test --prefix backend
```

### Manual API Testing
```bash
# Health check
curl http://localhost:3000/api/health

# Register
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test Co","email":"test@test.com","password":"Test123!"}'

# Login (save the token!)
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"Test123!"}'

# Use the token for authenticated requests
export TOKEN="your-access-token-here"

# Create employee
curl -X POST http://localhost:3000/api/employees \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"name":"John Doe","email":"john@test.com","role":"Developer","department":"Engineering"}'
```

### UI Testing
1. **Open:** http://localhost:5173
2. **Register:** Create new organization
3. **Login:** Use your credentials
4. **Test:** All features through the UI

---

## ✅ What to Test

### Backend (13 tests)
- [x] Health check
- [x] Registration
- [x] Login
- [x] Create employee
- [x] List employees
- [x] Get employee
- [x] Update employee
- [x] Create task
- [x] List tasks
- [x] Update task status
- [x] Dashboard metrics
- [x] Productivity scoring
- [x] Authentication security

### Frontend (14 tests)
- [ ] Registration page
- [ ] Login page
- [ ] Dashboard display
- [ ] Employee list
- [ ] Create employee
- [ ] Edit employee
- [ ] Delete employee
- [ ] Task list
- [ ] Create task
- [ ] Update task status
- [ ] Productivity page
- [ ] Navigation
- [ ] Responsive design
- [ ] Error handling

### Integration (3 tests)
- [ ] End-to-end flow
- [ ] Multi-tenancy
- [ ] Task workflow

### Security (3 tests)
- [ ] Authentication
- [ ] Authorization
- [ ] Input validation

---

## 📊 Expected Results

After testing, you should verify:

✅ **Backend**
- All API endpoints respond correctly
- Authentication works with JWT tokens
- Data validation prevents invalid inputs
- Multi-tenancy isolates organization data

✅ **Frontend**
- All pages load without errors
- Forms validate user input
- Data displays correctly
- Navigation works smoothly

✅ **Integration**
- Complete user flows work end-to-end
- Data persists across sessions
- Metrics calculate correctly
- Real-time updates work

✅ **Security**
- Protected routes require authentication
- Organizations cannot access each other's data
- SQL injection is prevented
- XSS attacks are prevented

---

## 🐛 If Tests Fail

### Backend Issues
```bash
# Check server logs
# Look at the terminal where backend is running

# Check database connection
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
psql -d ai_hrms -c "SELECT COUNT(*) FROM organizations;"

# Restart backend
# Stop with Ctrl+C, then:
npm run dev --prefix backend
```

### Frontend Issues
```bash
# Check browser console (F12)
# Look for JavaScript errors

# Check API connection
# In browser console:
fetch('http://localhost:3000/api/health').then(r => r.json()).then(console.log)

# Restart frontend
# Stop with Ctrl+C, then:
npm run dev --prefix frontend
```

### Database Issues
```bash
# Check PostgreSQL is running
brew services list | grep postgresql

# Reset database if needed
dropdb ai_hrms
createdb ai_hrms
npm run migrate --prefix backend
npm run seed --prefix backend
```

---

## 📝 Documenting Test Results

### For Each Test:
1. ✅ Mark as PASS or ❌ FAIL
2. Note any errors or unexpected behavior
3. Take screenshots if needed
4. Document steps to reproduce issues

### Bug Report Template:
```
Bug: [Short description]
Test: [Test number and name]
Severity: Critical / High / Medium / Low
Steps to Reproduce:
1. ...
2. ...
Expected: [What should happen]
Actual: [What actually happened]
Screenshot: [If applicable]
```

---

## 🎯 Success Criteria

Before moving to next phase, ensure:

- [ ] All automated tests pass (./test-api.sh)
- [ ] All backend unit tests pass (npm test)
- [ ] Can register and login successfully
- [ ] Can create and manage employees
- [ ] Can create and complete tasks
- [ ] Dashboard shows correct metrics
- [ ] Productivity scores calculate
- [ ] Multi-tenancy works (data isolation)
- [ ] No critical bugs found
- [ ] No console errors in browser

---

## 🚀 After Testing

Once all tests pass:

1. **Document Results**
   - Fill in test results in `TEST_RESULTS.md`
   - Note any bugs found
   - Record performance observations

2. **Review Implementation**
   - Check `IMPLEMENTATION_STATUS.md`
   - Verify all completed features work
   - Identify any gaps

3. **Plan Next Steps**
   - Review remaining tasks in `.kiro/specs/ai-hrms-platform/tasks.md`
   - Prioritize next features to implement
   - Prepare for advanced features

4. **Prepare for Submission** (if ready)
   - Take screenshots of working features
   - Record demo video (optional)
   - Review `GTM_STRATEGY.md`
   - Prepare presentation

---

## 💡 Testing Tips

1. **Test in Order**
   - Start with automated tests
   - Then manual API tests
   - Then UI tests
   - Finally integration tests

2. **Keep Notes**
   - Document what works
   - Document what doesn't
   - Note any surprises

3. **Test Edge Cases**
   - Invalid inputs
   - Empty data
   - Large datasets
   - Concurrent operations

4. **Test Security**
   - Try accessing without login
   - Try accessing other org's data
   - Try SQL injection
   - Try XSS attacks

5. **Test Performance**
   - Check page load times
   - Check API response times
   - Check with multiple users
   - Check with large datasets

---

## 📞 Need Help?

If you encounter issues:

1. Check the troubleshooting section in `TESTING_CHECKLIST.md`
2. Review server logs (backend terminal)
3. Check browser console (F12)
4. Verify database is running
5. Ensure .env files are configured correctly

---

## 🎉 Ready to Test!

**Current Status:**
- ✅ Backend running on http://localhost:3000
- ✅ Frontend running on http://localhost:5173
- ✅ Database configured and migrated
- ✅ Test scripts ready

**Start Testing:**
```bash
# Option 1: Automated
./test-api.sh

# Option 2: Manual UI
open http://localhost:5173

# Option 3: Follow complete guide
open COMPLETE_TESTING_GUIDE.md
```

**Good luck with your testing! 🚀**
