// TradeOmy - servizio per l'installazione come app.
// Interviene solo sui file del nostro sito. Tutto il resto (Supabase, grafici, ecc.)
// e le pagine di navigazione passano direttamente dal browser. Nessun dato in cache.
self.addEventListener('install', function (e) { self.skipWaiting(); });
self.addEventListener('activate', function (e) { e.waitUntil(self.clients.claim()); });
self.addEventListener('fetch', function (e) {
  var url = new URL(e.request.url);
  if (url.origin !== self.location.origin) return;
  if (e.request.mode === 'navigate') return;
  return;
});
