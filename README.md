# ST Padel Tour — Supabase connected

Project URL and publishable key are already configured in `index.html`.

## Finish setup
1. In Supabase Dashboard > SQL Editor run `supabase-setup.sql`.
2. Authentication > Users > Add user: create an admin email/password account.
3. Copy that user's UUID. Run in SQL Editor: `insert into public.admin_users(user_id) values ('UUID');`
4. For live updates enable Realtime for `site_state` (optional; refreshing works without it).
5. Upload `index.html` to GitHub Pages or another static host.
6. Log in via إدارة; add players, teams and matches.

Public pages can read results. Only approved admins can write via RLS. Do not store private phone numbers in the public database.

## Limitations
The site stores its full state in one JSON row. Simultaneous admin edits can overwrite each other; use one admin editor at a time. Data migration from the older local demo is not automatic. Tournament logic is a prototype and should be verified before official scoring. GitHub Pages deployment is not performed by this package.
