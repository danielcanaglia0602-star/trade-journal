-- Esegui questo script in Supabase: SQL Editor > New query > Run

create table if not exists public.trades (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  trade_date  date not null,
  symbol      text not null check (char_length(symbol) between 1 and 16),
  direction   text not null check (direction in ('long', 'short')),
  entry_price numeric not null,
  exit_price  numeric not null,
  size        numeric not null check (size > 0),
  fees        numeric not null default 0 check (fees >= 0),
  note        text not null default '' check (char_length(note) <= 1000),
  created_at  timestamptz not null default now()
);

create index if not exists trades_user_date_idx on public.trades (user_id, trade_date);

-- Ogni utente vede e modifica solo le proprie operazioni
alter table public.trades enable row level security;

create policy "trades_select_own" on public.trades
  for select using (auth.uid() = user_id);

create policy "trades_insert_own" on public.trades
  for insert with check (auth.uid() = user_id);

create policy "trades_update_own" on public.trades
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "trades_delete_own" on public.trades
  for delete using (auth.uid() = user_id);
