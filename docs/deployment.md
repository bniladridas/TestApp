# Deployment

TestApp is configured for deployment on Vercel and GitLab.

## Vercel Setup

1. Connect your GitHub repository to Vercel
2. Set up database on Neon (see Database Setup below)
3. Add environment variables (see Environment Variables below)
4. Deploy automatically on push to main

## Database Setup

1. Sign up at [Neon](https://neon.tech)
2. Create a new project
3. In the project overview, copy the `DATABASE_URL` connection string
4. The database tables are created automatically on first API call

## Build Configuration

- **Build Command**: `npm run build`
- **Output Directory**: `dist`
- **API Routes**: `/api/*` handled by serverless functions

## Environment Variables

- `DATABASE_URL`: PostgreSQL connection string from Neon
- `JWT_SECRET`: Secret key for JWT tokens (generate with `openssl rand -base64 32`)
- `GEMINI_API_KEY`: Your Google AI API key
- `SENTRY_DSN`: Sentry DSN for backend error monitoring (optional)
- `VITE_SENTRY_DSN`: Sentry DSN for frontend error monitoring (optional)

## GitLab Deployment

TestApp is mirrored to GitLab for additional CI/CD.

- **Trigger**: Automatic on push to main via GitHub Actions
- **Process**: Rewrites commit messages, pushes to GitLab
- **Requirements**: GITLAB_TOKEN secret in GitHub repo

## Manual Deployment

Vercel handles deployment automatically. For manual builds:

```bash
npm run build
# Vercel deploys dist/ and api/ serverless functions
```

## CDN and Asset Optimization

Vercel provides global CDN distribution with automatic optimization:

- **Global CDN**: Assets served from edge locations worldwide
- **Automatic Compression**: Gzip/Brotli compression enabled
- **Code Splitting**: Optimized chunks for vendor, UI, router, and utilities
- **Image Optimization**: Automatic WebP conversion and responsive images

## Monitoring Setup

### Error Tracking

1. Create a Sentry project at https://sentry.io
2. Add the DSN to environment variables
3. Configure alerts for production errors

### Performance Monitoring

- Core Web Vitals automatically tracked
- API performance monitored via Sentry
- Database connection pooling metrics available

### Health Checks

Monitor application health at `/api/health` and `/api/health/database`.

## Production URL

After deployment, your app will be available at the Vercel-provided URL.
