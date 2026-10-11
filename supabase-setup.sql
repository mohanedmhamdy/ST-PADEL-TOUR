-- Run in Supabase SQL Editor. Do not expose service_role or database password.
create table if not exists public.admin_users (user_id uuid primary key references auth.users(id) on delete cascade);
create table if not exists public.site_state (id integer primary key check(id=1), data jsonb not null default '{}'::jsonb, updated_at timestamptz not null default now());
alter table public.admin_users enable row level security;
alter table public.site_state enable row level security;
create policy "Users may read own admin status" on public.admin_users for select to authenticated using (user_id=auth.uid());
create policy "Anyone can read ST public results" on public.site_state for select to anon, authenticated using (true);
create policy "Admins may insert ST results" on public.site_state for insert to authenticated with check (exists(select 1 from public.admin_users where user_id=auth.uid()));
create policy "Admins may update ST results" on public.site_state for update to authenticated using (exists(select 1 from public.admin_users where user_id=auth.uid())) with check (exists(select 1 from public.admin_users where user_id=auth.uid()));
-- After creating your admin user in Authentication > Users, replace UUID below and run:
-- insert into public.admin_users(user_id) values ('YOUR-AUTH-USER-UUID');
-- Optional realtime (run once):
-- alter publication supabase_realtime add table public.site_state;
