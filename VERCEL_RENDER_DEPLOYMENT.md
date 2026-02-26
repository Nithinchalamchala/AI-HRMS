# 🚀 Complete Deployment Guide: Vercel + Render

This guide will walk you through deploying your AI-HRMS platform with:
- **Frontend** on Vercel (React/Vite)
- **Backend** on Render (Node.js/Express + PostgreSQL)

---

## 📋 Prerequisites

Before starting, ensure you have:
- [ ] GitHub account (to connect repositories)
- [ ] Vercel account (sign up at https://vercel.com)
- [ ] Render account (sign up at https://render.com)
- [ ] Your code pushed to a GitHub repository
- [ ] PostgreSQL database credentials ready

---

## Part 1: Backend Deployment on Render

### Step 1: Prepare Backend for Production

#### 1.1 Create Production Environment File

Create `backend/.env.production` (don't commit this):
```env
NODE_ENV=production
PORT=3000

# Database - Will be set by Render
DB_HOST=
DB_PORT=5432
DB_NAME=
DB_USER=
DB_PASSWORD=

# JWT - Generate strong secrets
JWT_SECRET=
JWT_EXPIRES_IN=1h
JWT_REFRESH_SECRET=
JWT_REFRESH_EXPIRES_IN=7d

# CORS - Will be your Vercel URL
CORS_ORIGIN=

# Optional
REDIS_HOST=
REDIS_PORT=6379
```

#### 1.2 Update Backend package.json Scripts

Make sure your `backend/package.json` has these scripts:
```json
{
  "scripts": {
    "build": "tsc",
    "start": "node dist/index.js",
    "migrate:prod": "node dist/database/migrate.js",
    "seed:prod": "node dist/database/seed.js"
  }
}
```

#### 1.3 Create Render Build Script

Create `backend/render-build.sh`:
```bash
#!/bin/bash
echo "Installing dependencies..."
npm install

echo "Building TypeScript..."
npm run build

echo "Running migrations..."
npm run migrate:prod

echo "Build complete!"
```

Make it executable:
```bash
chmod +x backend/render-build.sh
```

### Step 2: Create PostgreSQL Database on Render

1. **Go to Render Dashboard**
   - Visit https://dashboard.render.com
   - Click "New +" button
   - Select "PostgreSQL"

2. **Configure Database**
   - **Name**: `ai-hrms-db`
   - **Database**: `ai_hrms`
   - **User**: `ai_hrms_user` (auto-generated)
   - **Region**: Choose closest to your users (e.g., Oregon, Frankfurt)
   - **PostgreSQL Version**: 15
   - **Plan**: Free (or paid for production)

3. **Create Database**
   - Click "Create Database"
   - Wait 2-3 minutes for provisioning

4. **Save Connection Details**
   After creation, you'll see:
   - **Internal Database URL**: `postgresql://...` (use this)
   - **External Database URL**: `postgresql://...`
   - **PSQL Command**: For direct access
   
   Copy the **Internal Database URL** - you'll need it!

### Step 3: Deploy Backend Web Service on Render

1. **Create New Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Select your repository

2. **Configure Web Service**
   ```
   Name: ai-hrms-backend
   Region: Same as database (e.g., Oregon)
   Branch: main
   Root Directory: backend
   Runtime: Node
   Build Command: ./render-build.sh
   Start Command: npm start
   Plan: Free (or paid)
   ```

3. **Add Environment Variables**
   Click "Advanced" → "Add Environment Variable"
   
   Add these one by one:
   
   ```
   NODE_ENV = production
   PORT = 3000
   
   # Database (from Step 2)
   DATABASE_URL = [paste Internal Database URL from Step 2]
   
   # JWT Secrets (generate strong random strings)
   JWT_SECRET = [generate: openssl rand -base64 32]
   JWT_EXPIRES_IN = 1h
   JWT_REFRESH_SECRET = [generate: openssl rand -base64 32]
   JWT_REFRESH_EXPIRES_IN = 7d
   
   # CORS (will update after Vercel deployment)
   CORS_ORIGIN = https://your-app.vercel.app
   ```

   **To generate JWT secrets**, run in terminal:
   ```bash
   openssl rand -base64 32
   ```

4. **Create Web Service**
   - Click "Create Web Service"
   - Wait 5-10 minutes for first deployment
   - Watch the logs for any errors

5. **Verify Backend is Running**
   - Once deployed, you'll get a URL like: `https://ai-hrms-backend.onrender.com`
   - Test it: `https://ai-hrms-backend.onrender.com/api/health`
   - Should return: `{"status":"ok"}`

### Step 4: Parse Database URL (Alternative Method)

If you prefer separate DB variables instead of DATABASE_URL:

1. **Parse the Database URL**
   Format: `postgresql://user:password@host:port/database`
   
   Example:
   ```
   postgresql://ai_hrms_user:abc123xyz@dpg-abc123.oregon-postgres.render.com:5432/ai_hrms
   ```
   
   Becomes:
   ```
   DB_USER = ai_hrms_user
   DB_PASSWORD = abc123xyz
   DB_HOST = dpg-abc123.oregon-postgres.render.com
   DB_PORT = 5432
   DB_NAME = ai_hrms
   ```

2. **Update Backend Code** (if needed)
   Make sure `backend/src/config/database.ts` can read DATABASE_URL:
   ```typescript
   const databaseUrl = process.env.DATABASE_URL;
   
   if (databaseUrl) {
     // Parse DATABASE_URL
     const url = new URL(databaseUrl);
     config = {
       host: url.hostname,
       port: parseInt(url.port),
       database: url.pathname.slice(1),
       user: url.username,
       password: url.password,
     };
   } else {
     // Use individual variables
     config = {
       host: process.env.DB_HOST,
       port: parseInt(process.env.DB_PORT || '5432'),
       database: process.env.DB_NAME,
       user: process.env.DB_USER,
       password: process.env.DB_PASSWORD,
     };
   }
   ```

---

## Part 2: Frontend Deployment on Vercel

### Step 5: Prepare Frontend for Production

#### 5.1 Update Frontend Environment Variables

Create `frontend/.env.production`:
```env
VITE_API_BASE_URL=https://ai-hrms-backend.onrender.com/api
VITE_BLOCKCHAIN_NETWORK=polygon_mumbai
```

Replace `ai-hrms-backend.onrender.com` with your actual Render backend URL.

#### 5.2 Update API Base URL in Code (if hardcoded)

Check `frontend/src/lib/api.ts` or similar:
```typescript
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:3000/api';
```

#### 5.3 Create Vercel Configuration

Create `vercel.json` in the **root** directory:
```json
{
  "version": 2,
  "builds": [
    {
      "src": "frontend/package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/frontend/$1"
    }
  ],
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

Or create `frontend/vercel.json`:
```json
{
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

### Step 6: Deploy Frontend to Vercel

#### Method 1: Vercel Dashboard (Recommended)

1. **Go to Vercel Dashboard**
   - Visit https://vercel.com/dashboard
   - Click "Add New..." → "Project"

2. **Import Git Repository**
   - Click "Import Git Repository"
   - Select your GitHub repository
   - Click "Import"

3. **Configure Project**
   ```
   Framework Preset: Vite
   Root Directory: frontend
   Build Command: npm run build
   Output Directory: dist
   Install Command: npm install
   ```

4. **Add Environment Variables**
   Click "Environment Variables" and add:
   ```
   VITE_API_BASE_URL = https://ai-hrms-backend.onrender.com/api
   VITE_BLOCKCHAIN_NETWORK = polygon_mumbai
   ```

5. **Deploy**
   - Click "Deploy"
   - Wait 2-3 minutes
   - You'll get a URL like: `https://ai-hrms.vercel.app`

#### Method 2: Vercel CLI

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy from frontend directory
cd frontend
vercel

# Follow prompts:
# - Link to existing project? No
# - Project name: ai-hrms-frontend
# - Directory: ./
# - Override settings? Yes
# - Build Command: npm run build
# - Output Directory: dist

# Deploy to production
vercel --prod
```

### Step 7: Update CORS on Backend

1. **Go back to Render Dashboard**
   - Open your backend web service
   - Go to "Environment" tab

2. **Update CORS_ORIGIN**
   ```
   CORS_ORIGIN = https://ai-hrms.vercel.app
   ```
   
   Or for multiple origins:
   ```
   CORS_ORIGIN = https://ai-hrms.vercel.app,https://ai-hrms-preview.vercel.app
   ```

3. **Save Changes**
   - Render will automatically redeploy

---

## Part 3: Post-Deployment Configuration

### Step 8: Seed Database (Optional)

1. **Connect to Render Shell**
   - Go to Render Dashboard → Your backend service
   - Click "Shell" tab
   - Run:
   ```bash
   npm run seed:prod
   ```

2. **Or use PSQL directly**
   - Copy PSQL command from database page
   - Run in your local terminal:
   ```bash
   psql postgresql://user:pass@host:5432/dbname
   ```

### Step 9: Test Your Deployment

1. **Test Backend Health**
   ```bash
   curl https://ai-hrms-backend.onrender.com/api/health
   ```

2. **Test Frontend**
   - Visit: `https://ai-hrms.vercel.app`
   - Try to register/login
   - Check browser console for errors

3. **Test API Connection**
   - Open browser DevTools → Network tab
   - Try logging in
   - Check if API calls go to correct backend URL

### Step 10: Set Up Custom Domain (Optional)

#### For Vercel (Frontend):
1. Go to Project Settings → Domains
2. Add your domain (e.g., `hrms.yourdomain.com`)
3. Update DNS records as instructed
4. Wait for SSL certificate (automatic)

#### For Render (Backend):
1. Go to Service Settings → Custom Domain
2. Add your domain (e.g., `api.yourdomain.com`)
3. Update DNS records as instructed
4. Wait for SSL certificate (automatic)

---

## Part 4: Monitoring & Maintenance

### Step 11: Set Up Monitoring

#### Render Monitoring:
- **Logs**: Dashboard → Your service → Logs tab
- **Metrics**: Dashboard → Your service → Metrics tab
- **Alerts**: Settings → Notifications

#### Vercel Monitoring:
- **Analytics**: Project → Analytics tab
- **Logs**: Project → Deployments → View logs
- **Speed Insights**: Enable in project settings

### Step 12: Enable Auto-Deploy

Both platforms auto-deploy on git push by default:

- **Vercel**: Deploys on every push to `main` branch
- **Render**: Deploys on every push to `main` branch

To disable:
- **Vercel**: Settings → Git → Auto-deploy
- **Render**: Settings → Auto-Deploy

---

## 🔧 Troubleshooting

### Backend Issues

**Problem**: Build fails on Render
```
Solution:
1. Check build logs in Render dashboard
2. Ensure render-build.sh is executable
3. Verify all dependencies in package.json
4. Check TypeScript compilation locally: npm run build
```

**Problem**: Database connection fails
```
Solution:
1. Verify DATABASE_URL is correct
2. Check database is in same region as web service
3. Use Internal Database URL, not External
4. Ensure database is running (check Render DB dashboard)
```

**Problem**: Migrations fail
```
Solution:
1. Check migration files exist in dist/ after build
2. Run migrations manually via Render shell
3. Check database permissions
```

### Frontend Issues

**Problem**: API calls fail (CORS errors)
```
Solution:
1. Update CORS_ORIGIN on backend to include Vercel URL
2. Check VITE_API_BASE_URL is correct
3. Ensure backend is running (check health endpoint)
4. Check browser console for exact error
```

**Problem**: Environment variables not working
```
Solution:
1. Ensure variables start with VITE_
2. Redeploy after adding variables
3. Check Vercel dashboard → Settings → Environment Variables
4. Clear browser cache
```

**Problem**: 404 on page refresh
```
Solution:
1. Ensure vercel.json has rewrites configuration
2. Check Vercel build logs
3. Verify React Router is configured correctly
```

### Common Issues

**Problem**: Render free tier sleeps after inactivity
```
Solution:
1. Upgrade to paid plan ($7/month)
2. Or use a cron job to ping every 14 minutes:
   - Use cron-job.org or similar
   - Ping: https://your-backend.onrender.com/api/health
```

**Problem**: Slow first load on Render
```
Solution:
This is normal for free tier (cold starts)
- First request takes 30-60 seconds
- Subsequent requests are fast
- Upgrade to paid plan for always-on
```

---

## 📊 Deployment Checklist

### Pre-Deployment
- [ ] Code pushed to GitHub
- [ ] Environment variables documented
- [ ] Database migrations tested locally
- [ ] Build process tested locally
- [ ] CORS configured correctly

### Backend (Render)
- [ ] PostgreSQL database created
- [ ] Database URL saved
- [ ] Web service created
- [ ] Environment variables added
- [ ] Build script configured
- [ ] Migrations run successfully
- [ ] Health endpoint responding
- [ ] Seed data added (optional)

### Frontend (Vercel)
- [ ] Project imported from GitHub
- [ ] Build settings configured
- [ ] Environment variables added
- [ ] Deployment successful
- [ ] Site loads correctly
- [ ] API connection working
- [ ] All routes accessible

### Post-Deployment
- [ ] CORS updated with Vercel URL
- [ ] Both services communicating
- [ ] Login/register working
- [ ] Database operations working
- [ ] Monitoring set up
- [ ] Custom domains configured (optional)

---

## 💰 Cost Breakdown

### Free Tier (Good for MVP/Demo)
- **Render PostgreSQL**: Free (1GB storage, shared CPU)
- **Render Web Service**: Free (750 hours/month, sleeps after inactivity)
- **Vercel**: Free (100GB bandwidth, unlimited deployments)
- **Total**: $0/month

### Production Tier (Recommended)
- **Render PostgreSQL**: $7/month (256MB RAM, 1GB storage)
- **Render Web Service**: $7/month (512MB RAM, always-on)
- **Vercel Pro**: $20/month (1TB bandwidth, analytics)
- **Total**: $34/month

---

## 🎯 Next Steps

After successful deployment:

1. **Test thoroughly**
   - All CRUD operations
   - Authentication flow
   - AI features
   - Error handling

2. **Set up CI/CD**
   - GitHub Actions for tests
   - Automated deployments
   - Environment-specific configs

3. **Add monitoring**
   - Error tracking (Sentry)
   - Performance monitoring
   - Uptime monitoring

4. **Optimize performance**
   - Enable caching
   - Optimize database queries
   - Add CDN for assets

5. **Security hardening**
   - Rate limiting
   - Input validation
   - Security headers
   - Regular updates

---

## 📞 Support Resources

- **Vercel Docs**: https://vercel.com/docs
- **Render Docs**: https://render.com/docs
- **Vercel Discord**: https://vercel.com/discord
- **Render Community**: https://community.render.com

---

**🎉 Congratulations! Your AI-HRMS platform is now live!**

**Frontend**: https://ai-hrms.vercel.app
**Backend**: https://ai-hrms-backend.onrender.com

Share your deployment URLs and start showcasing your project!
