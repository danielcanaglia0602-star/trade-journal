// TradeOmy - servizio per l'installazione come app.
// Passa ogni richiesta alla rete: nessun dato viene messo in cache sul telefono.
self.addEventListener('install', function (e) { self.skipWaiting(); });
self.addEventListener('activate', function (e) { e.waitUntil(self.clients.claim()); });
self.addEventListener('fetch', function (e) {
  e.respondWith(fetch(e.request));
});
