# [Project Name]

## About this project

This project is a template for [brief description of your project type]. It [main functionality or purpose]. The project structure is flexible and can be adapted to your preferred coding language and framework.

## Project structure

```
[project-name]/
├── src/
│   ├── components/
│   │   ├── ui/
│   │   │   └── [component].tsx
│   │   └── [other-components].tsx
│   ├── pages/
│   │   ├── api/
│   │   │   └── [api-routes]/
│   │   ├── _app.tsx
│   │   └── index.tsx
│   ├── [backend-folder]/
│   │   ├── [backend-component1].ts
│   │   └── [backend-component2].ts
│   ├── styles/
│   │   └── globals.[css/scss]
│   ├── types/
│   │   └── [type-definitions].ts
│   └── utils/
│       └── [utility-functions].ts
├── [database-folder]/
│   └── [database-schema].[extension]
├── public/
│   └── [static-assets]
├── [env-files]
├── [linter-config-files]
├── [framework-config].js
├── package.json
├── README.md
├── [styling-config].[js/ts]
└── tsconfig.json
```

# Next.js T3 Project Template

## About this project

This project template follows the best practices for a modern Next.js T3 application. It provides a scalable and maintainable structure for building full-stack web applications with TypeScript, tRPC, Prisma, and Next.js.

## Project Structure

```
nextjs-t3-app/
├── src/
│   ├── components/
│   │   ├── ui/
│   │   │   ├── button/
│   │   │   │   ├── Button.tsx
│   │   │   │   └── index.ts
│   │   │   └── (other ui components)/
│   │   ├── layout/
│   │   │   ├── Header.tsx
│   │   │   └── Footer.tsx
│   │   └── (other composed components)/
│   ├── pages/
│   │   ├── api/
│   │   │   ├── trpc/
│   │   │   │   └── [trpc].ts
│   │   │   └── (other API routes)/
│   │   ├── _app.tsx
│   │   ├── index.tsx
│   │   └── (other pages)/
│   ├── server/
│   │   ├── api/
│   │   │   ├── routers/
│   │   │   │   └── exampleRouter.ts
│   │   │   └── root.ts
│   │   ├── auth.ts
│   │   ├── db.ts
│   │   └── trpc.ts
│   ├── styles/
│   │   └── globals.css
│   ├── types/
│   │   └── index.ts
│   └── utils/
│       └── api.ts
├── prisma/
│   └── schema.prisma
├── public/
│   ├── favicon.ico
│   └── (other static assets)/
├── .env
├── .env.example
├── .eslintrc.json
├── next.config.js
├── package.json
├── README.md
├── tailwind.config.js
├── tsconfig.json
└── (other configuration files)/
```

## Naming Conventions

1. **Files and Directories:**

   - Use kebab-case for directory names: `user-profile/`
   - Use PascalCase for React components: `Button.tsx`, `UserProfile.tsx`
   - Use camelCase for utility files and non-component files: `api.ts`, `useCustomHook.ts`

2. **React Components:**

   - Use PascalCase for component names: `export default function Button() { ... }`

3. **Functions and Variables:**

   - Use camelCase: `const getUserData = () => { ... }`

4. **Constants:**

   - Use UPPER_SNAKE_CASE: `const MAX_ITEMS = 10`

5. **Types and Interfaces:**

   - Use PascalCase: `interface UserData { ... }`

6. **Database Models (in Prisma schema):**

   - Use PascalCase for model names: `model User { ... }`

7. **API Routes:**

   - Use kebab-case for file names: `pages/api/user-data.ts`

8. **CSS Classes:**
   - Use kebab-case: `<div className="user-profile-container">`
