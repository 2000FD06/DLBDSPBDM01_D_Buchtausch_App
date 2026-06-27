USE buchtausch_app;

-- 5. Metadaten für Phase-3-Dokumentation

-- Anzahl der Tabellen
SELECT COUNT(*) AS anzahl_tabellen
FROM information_schema.tables
WHERE table_schema = 'buchtausch_app';

-- Anzahl der Einträge je Tabelle
SELECT 'benutzer' AS tabelle, COUNT(*) AS anzahl FROM benutzer
UNION ALL SELECT 'genre', COUNT(*) FROM genre
UNION ALL SELECT 'autor', COUNT(*) FROM autor
UNION ALL SELECT 'sprache', COUNT(*) FROM sprache
UNION ALL SELECT 'verlag', COUNT(*) FROM verlag
UNION ALL SELECT 'standort', COUNT(*) FROM standort
UNION ALL SELECT 'buch', COUNT(*) FROM buch
UNION ALL SELECT 'angebot', COUNT(*) FROM angebot
UNION ALL SELECT 'zeitslot', COUNT(*) FROM zeitslot
UNION ALL SELECT 'buchungsliste', COUNT(*) FROM buchungsliste
UNION ALL SELECT 'reservierung', COUNT(*) FROM reservierung
UNION ALL SELECT 'ausleihe', COUNT(*) FROM ausleihe
UNION ALL SELECT 'bewertung', COUNT(*) FROM bewertung
UNION ALL SELECT 'zahlung', COUNT(*) FROM zahlung
UNION ALL SELECT 'rechnung', COUNT(*) FROM rechnung;

-- Gesamtgröße der Datenbank in MB
SELECT 
    table_schema AS datenbank,
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS groesse_mb
FROM information_schema.tables
WHERE table_schema = 'buchtausch_app'
GROUP BY table_schema;
