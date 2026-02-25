# 🚀 AI-HRMS Platform - Deployment Guide

## Overview

This guide covers deploying the AI-HRMS platform to production. We'll use free/affordable services suitable for a portfolio project and internship submission.

---

## 🎯 Recommended Deployment Stack

### Option 1: Free Tier (Recommended for Demo)
- **Frontend**: Vercel (Free)
- **Backend**: Railway (Free tier - $5 credit/month)
- **Database**: Railway PostgreSQL (Free tier)

### Option 2: Alternative Free
- **Frontend**: Netlify (Free)
- **Backend**: Render (Free tier)
- **Database**: Render PostgreSQL (Free tier)

### Option 3: AWS (If you have credits)
- **Frontend**: AWS Amplify
- **Backend**: AWS Elastic Beanstalk
- **Database**: AWS RDS PostgreSQL

---

## 🚀 Quick Deploy - Railway + Vercel (Recommended)

### Prerequisites
- GitHub account (✅ Already have)
- Railway account (Sign up at railway.app)
- Vercel account (Sign up at vercel.com)

---

## Part 1: Deploy Database & Backend to Railway

### Step 1: Create Railway Account
1. Go to https://railway.app
2. Sign up with GitHub
3. Verify email

### Step 2: Create New Project
1. Click "New Project"
2. Select "Deploy PostgreSQL"
3. Wait for database to provision (~30 seconds)

### Step 3: Get Database Credentials
1. Click on PostgreSQL service
2. Go to "Variables" tab
3. Copy these values:
   - `PGHOST`
   - `PGPORT`
   - `PGUSER`
   - `PGPASSWORD`
   - `PGDATABASE`
   - `DATABASE_URL` (full connection string)

### Step 4: Deploy Backend
1. In same Railway project, click "New Service"
2. Select "GitHub Repo"
3. Connect your GitHub account
4. Select `Nithinchalamchala/AI-HRMS` repository
5. Railway will auto-detect Node.js

### Step 5: Configure Backend Environment Variables
Click on backend service → Variables → Add these:

```env
NODE_ENV=production
PORT=3000
DATABASE_URL=<copy from PostgreSQL service>
JWT_SECRET=<generate strong secret - use: openssl rand -base64 32>
JWT_REFRESH_SECRET=<generate another secret>
CORS_ORIGIN=*
```

### Step 6: Configure Build Settings
1. Go to Settings tab
2. Set Root Directory: `backend`
3. Build Command: `npm install && npm run build`
4. Start Command: `npm start`
5. Click "Deploy"

### Step 7: Run Database Migrations
1. Wait for backend to deploy
2. Go to backend service → Settings → Generate Domain
3. Copy the domain (e.g., `your-app.railway.app`)
4. In your local terminal:

```bash
# Set DATABASE_URL from Railway
export DATABASE_URL="<your-railway-database-url>"

# Run migrations
cd backend
npm run migrate
npm run seed
```

Or use Railway CLI:
```bash
# Install Railway CLI
npm i -g @railway/cli

# Login
railway login

# Link to project
railway link

# Run migrations
railway run npm run migrate
railway run npm run seed
```

---

## Part 2: Deploy Frontend to Vercel

### Step 1: Create Vercel Account
1. Go to https://vercel.com
2. Sign up with GitHub
3. Import project

### Step 2: Import Repository
1. Click "Add New" → "Project"
2. Import `Nithinchalamchala/AI-HRMS`
3. Vercel auto-detects React/Vite

### Step 3: Configure Build Settings
- Framework Preset: Vite
- Root Directory: `frontend`
- Build Command: `npm run build`
- Output Directory: `dist`
- Install Command: `npm install`

### Step 4: Add Environment Variables
Add in Vercel dashboard:

```env
VITE_API_URL=https://your-backend.railway.app/api
```

### Step 5: Deploy
1. Click "Deploy"
2. Wait 2-3 minutes
3. Get your live URL (e.g., `your-app.vercel.app`)

### Step 6: Update Backend CORS
Go back to Railway → Backend service → Variables:
```env
CORS_ORIGIN=https://your-app.vercel.app
```

Redeploy backend.

---

## 🔧 Alternative: Deploy to Render

### Backend on Render

1. Go to https://render.com
2. Sign up with GitHub
3. New → Web Service
4. Connect `AI-HRMS` repo
5. Configure:
   - Name: `ai-hrms-backend`
   - Root Directory: `backend`
   - Environment: Node
   - Build Command: `npm install && npm run build`
   - Start Command: `npm start`
   - Instance Type: Free

6. Add Environment Variables (same as Railway)

7. Create PostgreSQL Database:
   - New → PostgreSQL
   - Copy Internal Database URL
   - Add to backend as `DATABASE_URL`

8. Run migrations via Render Shell or locally

### Frontend on Render

1. New → Static Site
2. Connect repo
3. Configure:
   - Root Directory: `frontend`
   - Build Command: `npm install && npm run build`
   - Publish Directory: `dist`

4. Add Environment Variable:
   ```env
   VITE_API_URL=https://ai-hrms-backend.onrender.com/api
   ```

---

## 📋 Pre-Deployment Checklist

### Backend Preparation

1. **Add Production Start Script**
   
   Update `backend/package.json`:
   ```json
   {
     "scripts": {
       "start": "node dist/index.js",
       "build": "tsc",
       "dev": "ts-node-dev --respawn --transpile-only src/index.ts",
       "migrate": "node dist/database/migrate.js",
       "seed": "node dist/database/seed.js"
     }
   }
   ```

2. **Ensure TypeScript Compiles**
   ```bash
   cd backend
   npm run build
   ```

3. **Test Production Build Locally**
   ```bash
   NODE_ENV=production npm start
   ```

### Frontend Preparation

1. **Update API URL Handling**
   
   Check `frontend/src/lib/api.ts` uses environment variable:
   ```typescript
   const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';
   ```

2. **Build Frontend**
   ```bash
   cd frontend
   npm run build
   ```

3. **Test Production Build**
   ```bash
   npm run preview
   ```

---

## 🔐 Security Checklist

Before deploying:

- [ ] Generate strong JWT secrets (32+ characters)
- [ ] Set `NODE_ENV=production`
- [ ] Configure proper CORS origins (not `*` in production)
- [ ] Use HTTPS for all connections
- [ ] Don't commit `.env` files
- [ ] Use environment variables for all secrets
- [ ] Enable database SSL in production

---

## 🧪 Post-Deployment Testing

After deployment:

1. **Test Health Endpoint**
   ```bash
   curl https://your-backend.railway.app/api/health
   ```

2. **Test Frontend Loads**
   - Visit your Vercel URL
   - Check browser console for errors
   - Verify API calls work

3. **Test Full Flow**
   - Register new organization
   - Login
   - Create employee
   - Create task
   - Complete task
   - Check dashboard
   - Test AI features

---

## 📊 Monitoring & Logs

### Railway
- View logs: Service → Deployments → View Logs
- Monitor metrics: Service → Metrics tab
- Database metrics: PostgreSQL service → Metrics

### Vercel
- View logs: Project → Deployments → View Function Logs
- Analytics: Project → Analytics tab
- Performance: Project → Speed Insights

### Render
- View logs: Service → Logs tab
- Metrics: Service → Metrics tab

---

## 🐛 Common Deployment Issues

### Issue 1: Database Connection Fails
**Solution**: 
- Check `DATABASE_URL` is correct
- Ensure database allows external connections
- Verify SSL mode if required

### Issue 2: Frontend Can't Reach Backend
**Solution**:
- Check `VITE_API_URL` is set correctly
- Verify CORS is configured
- Check backend is running

### Issue 3: Migrations Not Run
**Solution**:
- Run migrations manually via Railway CLI
- Or use Railway's one-off command feature

### Issue 4: Build Fails
**Solution**:
- Check Node version compatibility
- Verify all dependencies in package.json
- Check build logs for specific errors

---

## 💰 Cost Estimate

### Free Tier (Recommended for Demo)
- Railway: $5 credit/month (enough for demo)
- Vercel: Unlimited for personal projects
- **Total: FREE for first month**

### After Free Tier
- Railway: ~$5-10/month (if you exceed free tier)
- Vercel: FREE (stays free for personal)
- **Total: $5-10/month**

---

## 🎥 For Video Demo

Once deployed, you'll have:
- ✅ Live frontend URL (e.g., `ai-hrms.vercel.app`)
- ✅ Live backend API (e.g., `ai-hrms-backend.railway.app`)
- ✅ Production database with seed data
- ✅ HTTPS enabled automatically
- ✅ Professional URLs for portfolio

---

## 📝 Custom Domain (Optional)

### Add Custom Domain to Vercel
1. Buy domain (Namecheap, GoDaddy, etc.)
2. Vercel → Project → Settings → Domains
3. Add your domain
4. Update DNS records as instructed
5. Wait for SSL certificate (~5 minutes)

### Add Custom Domain to Railway
1. Railway → Service → Settings → Domains
2. Add custom domain
3. Update DNS CNAME record
4. Wait for SSL

---

## 🚀 Quick Deploy Commands

```bash
# 1. Commit latest changes
git add -A
git commit -m "chore: Prepare for deployment"
git push origin main

# 2. Install Railway CLI
npm i -g @railway/cli

# 3. Login to Railway
railway login

# 4. Link project (after creating on Railway dashboard)
railway link

# 5. Run migrations on Railway
railway run npm run migrate
railway run npm run seed

# 6. Deploy frontend to Vercel (via dashboard or CLI)
npm i -g vercel
cd frontend
vercel --prod
```

---

## ✅ Deployment Checklist

- [ ] Create Railway account
- [ ] Deploy PostgreSQL database
- [ ] Deploy backend to Railway
- [ ] Configure environment variables
- [ ] Run database migrations
- [ ] Test backend health endpoint
- [ ] Create Vercel account
- [ ] Deploy frontend to Vercel
- [ ] Configure frontend environment variables
- [ ] Update backend CORS settings
- [ ] Test full application flow
- [ ] Verify all AI features work
- [ ] Note down live URLs for video

---

## 📞 Support

If you encounter issues:
- Railway: https://railway.app/help
- Vercel: https://vercel.com/support
- Check deployment logs first
- Verify environment variables
- Test locally with production build

---

**Ready to deploy?** Follow the Railway + Vercel guide above for the fastest deployment!

**Estimated Time**: 20-30 minutes for complete deployment
