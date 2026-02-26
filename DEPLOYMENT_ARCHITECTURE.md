# 🏗️ Deployment Architecture

## Overview

This document explains how your AI-HRMS platform is deployed across Vercel and Render.

---

## 🎨 Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                         USERS                                │
│                    (Web Browsers)                            │
└────────────────────────┬────────────────────────────────────┘
                         │
                         │ HTTPS
                         │
         ┌───────────────┴───────────────┐
         │                               │
         │                               │
         ▼                               ▼
┌─────────────────┐            ┌─────────────────┐
│     VERCEL      │            │     RENDER      │
│   (Frontend)    │   API      │   (Backend)     │
│                 │◄──────────►│                 │
│  React + Vite   │   Calls    │  Node.js +      │
│  Static Assets  │            │  Express API    │
│  CDN Delivery   │            │                 │
└─────────────────┘            └────────┬────────┘
                                        │
                                        │ SQL
                                        │
                               ┌────────▼────────┐
                               │     RENDER      │
                               │  (PostgreSQL)   │
                               │                 │
                               │   Database      │
                               │   Managed DB    │
                               └─────────────────┘
```

---

## 🔧 Component Details

### Frontend (Vercel)
**URL**: `https://your-app.vercel.app`

**What it does:**
- Serves React application
- Handles routing (SPA)
- Delivers static assets via CDN
- Provides SSL/HTTPS automatically

**Technology:**
- React 18
- Vite build tool
- Tailwind CSS
- React Router

**Configuration:**
- Build: `npm run build`
- Output: `dist/` directory
- Environment: `VITE_API_BASE_URL`

**Features:**
- Auto-deploy on git push
- Preview deployments for PRs
- Edge network (CDN)
- Zero configuration SSL

---

### Backend (Render Web Service)
**URL**: `https://your-backend.onrender.com`

**What it does:**
- REST API endpoints
- Authentication (JWT)
- Business logic
- Database queries
- AI calculations

**Technology:**
- Node.js 18+
- Express.js
- TypeScript
- JWT authentication

**Configuration:**
- Build: `./render-build.sh`
- Start: `npm start`
- Port: 3000
- Environment: Multiple variables

**Features:**
- Auto-deploy on git push
- Automatic SSL
- Health checks
- Log streaming

---

### Database (Render PostgreSQL)
**URL**: Internal connection string

**What it does:**
- Stores all application data
- Organizations, employees, tasks
- Productivity scores
- User authentication data

**Technology:**
- PostgreSQL 15
- Managed service
- Automatic backups

**Configuration:**
- Connection: DATABASE_URL
- Internal networking
- Automatic backups

**Features:**
- Managed backups
- Point-in-time recovery
- Automatic updates
- Monitoring dashboard

---

## 🔄 Data Flow

### 1. User Visits App
```
User Browser → Vercel CDN → React App Loads
```

### 2. User Logs In
```
React App → API Call → Render Backend → PostgreSQL
                                      ↓
                                   Verify Credentials
                                      ↓
                                   Generate JWT
                                      ↓
React App ← JWT Token ← Render Backend
```

### 3. User Creates Employee
```
React App → POST /api/employees → Render Backend
                                        ↓
                                   Validate Data
                                        ↓
                                   PostgreSQL INSERT
                                        ↓
React App ← Employee Data ← Render Backend
```

### 4. Dashboard Loads
```
React App → GET /api/dashboard/metrics → Render Backend
                                              ↓
                                         Query Database
                                              ↓
                                         Calculate Stats
                                              ↓
React App ← Dashboard Data ← Render Backend
```

---

## 🌐 Network Configuration

### CORS (Cross-Origin Resource Sharing)
```
Backend CORS_ORIGIN = https://your-app.vercel.app
```
This allows frontend to make API calls to backend.

### Environment Variables

**Frontend (Vercel):**
```env
VITE_API_BASE_URL=https://your-backend.onrender.com/api
```

**Backend (Render):**
```env
DATABASE_URL=postgresql://user:pass@host:5432/db
CORS_ORIGIN=https://your-app.vercel.app
JWT_SECRET=your-secret
```

---

## 🔒 Security

### SSL/TLS
- ✅ Vercel: Automatic SSL for all domains
- ✅ Render: Automatic SSL for all services
- ✅ Database: Encrypted connections

### Authentication
- JWT tokens with expiration
- Refresh token rotation
- Bcrypt password hashing
- Protected API routes

### Data Isolation
- Multi-tenant architecture
- Organization-level data separation
- Row-level security in queries

---

## 📊 Scaling

### Free Tier Limits
- **Vercel**: 100GB bandwidth/month
- **Render Web**: 750 hours/month, sleeps after 15 min
- **Render DB**: 1GB storage, shared CPU

### Production Scaling
- **Vercel Pro**: 1TB bandwidth, analytics
- **Render Web**: Always-on, 512MB RAM
- **Render DB**: Dedicated resources, backups

### Future Scaling Options
- Add Redis for caching
- Enable connection pooling
- Add CDN for API responses
- Implement rate limiting
- Add load balancer

---

## 🔍 Monitoring

### Vercel
- Real-time logs
- Analytics dashboard
- Performance metrics
- Error tracking

### Render
- Application logs
- Resource usage metrics
- Database metrics
- Uptime monitoring

### Health Checks
```
GET https://your-backend.onrender.com/api/health
Response: {"status":"ok"}
```

---

## 🚀 Deployment Pipeline

### Automatic Deployment
```
1. Developer pushes to GitHub
   ↓
2. GitHub webhook triggers
   ↓
3. Vercel builds frontend (2-3 min)
   ↓
4. Render builds backend (5-10 min)
   ↓
5. Both services go live automatically
```

### Manual Deployment
```
# Frontend
cd frontend
vercel --prod

# Backend
# Push to GitHub, Render auto-deploys
```

---

## 💰 Cost Breakdown

### Free Tier ($0/month)
```
Vercel Frontend:     $0
Render Backend:      $0
Render Database:     $0
─────────────────────────
Total:               $0/month
```

**Good for:**
- MVP/Demo
- Development
- Low traffic
- Testing

**Limitations:**
- Backend sleeps (cold starts)
- Limited storage
- Shared resources

### Production Tier ($34/month)
```
Vercel Pro:          $20
Render Backend:      $7
Render Database:     $7
─────────────────────────
Total:               $34/month
```

**Good for:**
- Production apps
- Real users
- Always-on
- Better performance

**Benefits:**
- No cold starts
- More resources
- Analytics
- Priority support

---

## 🔧 Maintenance

### Regular Tasks
- Monitor error logs
- Check resource usage
- Review security updates
- Backup verification
- Performance optimization

### Updates
- Dependencies: Monthly
- Security patches: Immediate
- Feature releases: As needed

### Backup Strategy
- Database: Automatic daily backups (Render)
- Code: Version controlled (GitHub)
- Environment: Documented in .env.example

---

## 🆘 Troubleshooting

### Frontend Issues
**Problem**: Page not loading
- Check Vercel deployment logs
- Verify build succeeded
- Check browser console

**Problem**: API calls failing
- Verify VITE_API_BASE_URL
- Check CORS settings
- Test backend health endpoint

### Backend Issues
**Problem**: Service not responding
- Check Render logs
- Verify environment variables
- Test database connection

**Problem**: Slow response (free tier)
- Normal for cold starts (30-60s)
- Consider upgrading to paid tier
- Or use cron job to keep warm

### Database Issues
**Problem**: Connection errors
- Verify DATABASE_URL
- Check database status in Render
- Ensure same region as backend

---

## 📚 Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Render Documentation](https://render.com/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Express.js Best Practices](https://expressjs.com/en/advanced/best-practice-performance.html)

---

## 🎯 Next Steps

After understanding the architecture:

1. ✅ Review deployment guides
2. ✅ Deploy your application
3. ✅ Test all functionality
4. ✅ Monitor performance
5. ✅ Plan for scaling

---

**Questions?** Check the deployment guides or reach out for support!
