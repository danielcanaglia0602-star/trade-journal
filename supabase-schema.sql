-- TradeDiario: schema completo. Eseguilo in Supabase > SQL Editor > New query > Run.
-- Puoi rieseguirlo senza problemi.

create table if not exists public.backtests (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name        text not null default 'Sessione',
  symbol      text not null default '',
  timeframe   text not null default '',
  date_from   date,
  date_to     date,
  capital     numeric not null default 0,
  description text not null default '',
  created_at  timestamptz not null default now()
);

create table if not exists public.trades (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  trade_date  date not null,
  symbol      text not null,
  direction   text not null check (direction in ('long','short')),
  entry_price numeric not null,
  exit_price  numeric not null,
  size        numeric not null check (size > 0),
  fees        numeric not null default 0 check (fees >= 0),
  note        text not null default '',
  created_at  timestamptz not null default now()
);

alter table public.trades add column if not exists backtest_id uuid references public.backtests(id) on delete cascade;
alter table public.backtests add column if not exists symbol text not null default '';
alter table public.backtests add column if not exists timeframe text not null default '';
alter table public.backtests add column if not exists capital numeric not null default 0;
alter table public.backtests add column if not exists name text not null default 'Sessione';

create index if not exists trades_user_date_idx on public.trades (user_id, trade_date);

alter table public.trades enable row level security;
alter table public.backtests enable row level security;

drop policy if exists "trades_select_own" on public.trades;
drop policy if exists "trades_insert_own" on public.trades;
drop policy if exists "trades_update_own" on public.trades;
drop policy if exists "trades_delete_own" on public.trades;
create policy "trades_select_own" on public.trades for select using (auth.uid() = user_id);
create policy "trades_insert_own" on public.trades for insert with check (auth.uid() = user_id);
create policy "trades_update_own" on public.trades for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "trades_delete_own" on public.trades for delete using (auth.uid() = user_id);

drop policy if exists "bt_select_own" on public.backtests;
drop policy if exists "bt_insert_own" on public.backtests;
drop policy if exists "bt_update_own" on public.backtests;
drop policy if exists "bt_delete_own" on public.backtests;
create policy "bt_select_own" on public.backtests for select using (auth.uid() = user_id);
create policy "bt_insert_own" on public.backtests for insert with check (auth.uid() = user_id);
create policy "bt_update_own" on public.backtests for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "bt_delete_own" on public.backtests for delete using (auth.uid() = user_id);
