import path from 'node:path'
import type { PrismaConfig } from 'prisma'
import { PrismaPg } from '@prisma/adapter-pg'

// npm install @prisma/adapter-pg pg
// npm install -D @types/pg

export default {
  earlyAccess: true,
  schema: path.join('prisma', 'schema.prisma'),
  migrate: {
    async adapter() {
      const { Pool } = await import('pg')
      const pool = new Pool({
        connectionString: process.env.DATABASE_URL,
      })
      return new PrismaPg(pool)
    },
  },
} satisfies PrismaConfig