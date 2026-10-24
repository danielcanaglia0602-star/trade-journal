# TradeDiario

Contenuto della cartella:
- index.html: pagina pubblica per Google
- app.html: il journal (dashboard, giornata, calendario, operazioni, backtest, impostazioni)
- config.js: dati di Supabase (già compilati)
- supabase-schema.sql: database (da eseguire una volta su Supabase)
- vercel.json, robots.txt, sitemap.xml: pubblicazione e Google

Ordine di pubblicazione:
1. Supabase: esegui supabase-schema.sql nel SQL Editor.
2. Carica tutti i file su GitHub (repository tradediario), sostituendo quelli vecchi.
3. Vercel: il sito si aggiorna da solo. Ricarica con Ctrl + F5.
