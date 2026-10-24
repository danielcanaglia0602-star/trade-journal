# TradeDiario

Trading journal con account, dati privati per utente e pubblicazione su Vercel (gratis).

## 1. Supabase (gratis)
1. Crea un progetto su supabase.com.
2. SQL Editor > New query > incolla `supabase-schema.sql` > Run.
3. Authentication > Sign In / Providers: lascia attiva la registrazione con email.
4. Project Settings > API: copia Project URL e anon public key.
5. Apri `config.js` e incolla i due valori.

## 2. Vercel (gratis)
1. Carica questa cartella su GitHub (repository nuovo).
2. Su vercel.com: Add New > Project > importa il repository. Framework: Other. Nessun comando di build.
3. Dopo il deploy, sostituisci `IL-TUO-DOMINIO` con il tuo indirizzo `.vercel.app` in `index.html`, `robots.txt` e `sitemap.xml`, poi fai commit.

## 3. Google
1. Vai su search.google.com/search-console e aggiungi la proprietà (URL prefix).
2. Verifica il sito e invia `sitemap.xml`.
