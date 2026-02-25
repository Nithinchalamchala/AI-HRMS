# 👥 Employee Management - How It Works

## Overview

This document clarifies how employee management works in the AI-HRMS platform MVP.

---

## 🔐 Authentication Model

### Organization-Level Authentication (Current MVP)

**Who can login:**
- ✅ Organization Admins only

**Who cannot login:**
- ❌ Individual employees (they are data records, not users)

### Why This Design?

This is an **intentional MVP design decision** for several reasons:

1. **Faster Development**: Simpler authentication model
2. **Admin-Centric**: HR/managers manage everything
3. **Reduced Complexity**: No role-based permissions needed yet
4. **Clear Scope**: Focus on AI features, not user management

### Future Enhancement (Post-MVP)

In a future version, you could add:
- Individual employee login
- Employee self-service portal
- Role-based permissions (admin, manager, employee)
- Employee can view their own tasks and scores
- Employee can update their profile

---

## 👤 Employee Records

### What Are Employees?

In the current system, employees are **data records** managed by the organization admin:

- Created by admin
- Assigned tasks by admin
- Have productivity scores calculated automatically
- Can be activated/deactivated by admin
- Cannot login themselves

Think of it like a **contact management system** rather than a user management system.

---

## ✅ Active vs Inactive Status

### What Does It Mean?

**Active Employee** (`is_active = true`):
- Currently working at the organization
- Counted in "Active Employees" metric
- Can be assigned new tasks
- Included in AI calculations
- Visible in all reports

**Inactive Employee** (`is_active = false`):
- No longer working (resigned, terminated, on leave)
- NOT counted in "Active Employees" metric
- Cannot be assigned new tasks (should be prevented)
- Excluded from AI calculations
- Historical data preserved

### How to Toggle Status

**In the UI:**
1. Go to Employees page
2. Find the employee
3. Click the Power icon (⚡) button
4. Confirm the action
5. Status updates immediately

**What Happens:**
- Status badge changes (Green "Active" ↔️ Gray "Inactive")
- Dashboard "Active Employees" count updates
- Employee excluded from future AI recommendations
- Historical data remains intact

### Use Cases

**Deactivate when:**
- Employee resigns
- Employee is terminated
- Employee on long-term leave
- Contractor engagement ends

**Reactivate when:**
- Employee returns from leave
- Rehiring former employee
- Correcting a mistake

---

## 📊 Dashboard Metrics Explained

### Total Employees
- **Count**: All employees (active + inactive)
- **Purpose**: Total workforce size
- **Includes**: Everyone ever added

### Active Employees
- **Count**: Only employees with `is_active = true`
- **Purpose**: Current workforce size
- **Includes**: Only currently working employees

### Example:
```
Total Employees: 10
Active Employees: 8
(2 employees are inactive - resigned/terminated)
```

---

## 🎯 Current Features

### What Admins Can Do:

1. **Create Employees**
   - Add name, email, role, department, skills
   - Employee starts as active by default

2. **Edit Employees**
   - Update any employee information
   - Change role, department, skills

3. **Activate/Deactivate**
   - Toggle employee status
   - Affects dashboard metrics
   - Affects AI calculations

4. **Delete Employees**
   - Permanently remove employee
   - ⚠️ Deletes all associated data
   - Use deactivate instead if you want to preserve history

5. **Assign Tasks**
   - Assign tasks to active employees
   - Track task completion
   - Triggers productivity calculations

6. **View AI Insights**
   - Productivity scores
   - Skill gaps
   - Performance trends
   - Task recommendations

---

## 🚫 What Employees CANNOT Do (Current MVP)

- ❌ Login to the system
- ❌ View their own dashboard
- ❌ Update their own profile
- ❌ View their tasks
- ❌ Update task status themselves
- ❌ View their productivity score

**Why?** This is an admin-centric MVP. Employees are managed, not users.

---

## 🔄 Typical Workflow

### Onboarding New Employee:
1. Admin creates employee record
2. Employee is automatically active
3. Admin assigns tasks
4. System tracks completion
5. AI calculates productivity

### Employee Leaves:
1. Admin deactivates employee
2. Employee removed from active count
3. Historical data preserved
4. Can still view past performance
5. Cannot assign new tasks

### Employee Returns:
1. Admin reactivates employee
2. Employee added back to active count
3. Can assign new tasks again
4. Historical data still available

---

## 💡 Best Practices

### DO:
- ✅ Deactivate employees who leave (don't delete)
- ✅ Keep employee records for historical data
- ✅ Use meaningful role and department names
- ✅ Add relevant skills for AI recommendations
- ✅ Update employee info when roles change

### DON'T:
- ❌ Delete employees unless absolutely necessary
- ❌ Leave inactive employees as active
- ❌ Forget to update skills when employees learn new things
- ❌ Assign tasks to inactive employees

---

## 🎨 UI Indicators

### Status Badge Colors:
- 🟢 **Green "Active"**: Employee is currently working
- ⚪ **Gray "Inactive"**: Employee is not currently working

### Action Buttons:
- ⚡ **Power Icon**: Toggle active/inactive status
  - Orange when active (click to deactivate)
  - Green when inactive (click to activate)
- ✏️ **Edit Icon**: Edit employee details
- 🗑️ **Trash Icon**: Delete employee permanently

---

## 📈 Impact on AI Features

### Active Employees:
- ✅ Included in productivity scoring
- ✅ Included in skill gap analysis
- ✅ Included in performance trends
- ✅ Recommended for task assignments

### Inactive Employees:
- ❌ Excluded from new AI calculations
- ✅ Historical scores preserved
- ❌ Not recommended for new tasks
- ✅ Past trends still visible

---

## 🔮 Future Enhancements

If you want to add employee login later:

1. **Add Employee Authentication**
   - Separate login for employees
   - Password management
   - Email verification

2. **Employee Portal**
   - View assigned tasks
   - Update task status
   - View own productivity score
   - View skill gaps and recommendations

3. **Role-Based Access**
   - Admin: Full access
   - Manager: Team management
   - Employee: Self-service only

4. **Self-Service Features**
   - Update profile
   - Request time off
   - View payslips
   - Training requests

---

## ❓ FAQ

**Q: Why can't employees login?**
A: This is an MVP focused on admin/HR use cases. Employee login would be a future enhancement.

**Q: What's the difference between delete and deactivate?**
A: Delete permanently removes all data. Deactivate preserves history but marks as not working.

**Q: Can I reactivate a deleted employee?**
A: No, deletion is permanent. Always deactivate instead unless you're sure.

**Q: Do inactive employees count in metrics?**
A: They count in "Total Employees" but NOT in "Active Employees".

**Q: Can I assign tasks to inactive employees?**
A: Technically yes (not blocked yet), but you shouldn't. They won't appear in AI recommendations.

**Q: What happens to tasks when I deactivate an employee?**
A: Existing tasks remain assigned. Historical data is preserved. Just can't assign new tasks.

---

## ✅ Summary

**Current System:**
- Organization admin manages everything
- Employees are data records, not users
- Active/Inactive status controls visibility
- All AI features work with active employees
- Historical data always preserved

**This is perfect for:**
- HR departments managing workforce
- Small to medium teams
- Admin-centric workflows
- MVP and demo purposes

**Future enhancement needed for:**
- Employee self-service
- Large organizations with complex permissions
- Employee-facing features

---

**The current design is intentional and works great for the MVP! 🎉**
