-- Dummy-Daten und Datenkonsistenz
SELECT 'benutzer' AS tabelle, COUNT(*) AS anzahl FROM benutzer
UNION ALL
SELECT 'genre', COUNT(*) FROM genre
UNION ALL
SELECT 'autor', COUNT(*) FROM autor
UNION ALL
SELECT 'sprache', COUNT(*) FROM sprache
UNION ALL
SELECT 'verlag', COUNT(*) FROM verlag
UNION ALL
SELECT 'standort', COUNT(*) FROM standort
UNION ALL
SELECT 'buch', COUNT(*) FROM buch
UNION ALL
SELECT 'angebot', COUNT(*) FROM angebot
UNION ALL
SELECT 'zeitslot', COUNT(*) FROM zeitslot
UNION ALL
SELECT 'buchungsliste', COUNT(*) FROM buchungsliste
UNION ALL
SELECT 'reservierung', COUNT(*) FROM reservierung
UNION ALL
SELECT 'ausleihe', COUNT(*) FROM ausleihe
UNION ALL
SELECT 'bewertung', COUNT(*) FROM bewertung
UNION ALL
SELECT 'zahlung', COUNT(*) FROM zahlung
UNION ALL
SELECT 'rechnung', COUNT(*) FROM rechnung;




