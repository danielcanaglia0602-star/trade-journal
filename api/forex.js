module.exports = async (req, res) => {
  const key = process.env.TWELVE_DATA_KEY;
  if (!key) {
    return res.status(500).json({ status: "error", message: "Dati non disponibili: chiave del server non configurata." });
  }
  const q = req.query || {};
  const intervals = ["1min", "5min", "15min", "1h", "4h", "1day"];
  if (!/^[A-Z]{3}\/[A-Z]{3}$/.test(q.symbol || "") || !intervals.includes(q.interval)) {
    return res.status(400).json({ status: "error", message: "Parametri non validi." });
  }
  const params = new URLSearchParams({
    symbol: q.symbol,
    interval: q.interval,
    outputsize: String(Math.min(parseInt(q.outputsize, 10) || 1000, 1000)),
    apikey: key
  });
  if (/^\d{4}-\d{2}-\d{2}$/.test(q.start_date || "")) params.set("start_date", q.start_date);
  if (/^\d{4}-\d{2}-\d{2}$/.test(q.end_date || "")) params.set("end_date", q.end_date);
  try {
    const r = await fetch("https://api.twelvedata.com/time_series?" + params.toString());
    const data = await r.json();
    res.setHeader("Cache-Control", "s-maxage=86400, stale-while-revalidate=86400");
    return res.status(200).json(data);
  } catch (e) {
    return res.status(502).json({ status: "error", message: "Servizio dati non raggiungibile." });
  }
};
