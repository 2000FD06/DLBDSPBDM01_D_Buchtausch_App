USE buchtausch_app;


-- 3.2 Erweiterung der Benutzertabelle um Passwort-Hash
-- Die Datenbank speichert nur den erzeugten Hash, nicht das echte Passwort.

ALTER TABLE benutzer
ADD COLUMN passwort VARCHAR(255) NULL;

-- Dummy-Wert für bestehende Testdaten.
-- Dieser Wert dient nur als Platzhalter für die Projekt-Dokumentation.
UPDATE benutzer
SET passwort = '$2y$10$dummyhashnurfuertestzwecke'
WHERE passwort IS NULL;

SELECT * FROM benutzer;


/*
   3.3 Performance-Optimierung durch Indize

-- Indizes auf häufig verwendeten Fremdschlüsseln und Suchfeldern.
-- Dadurch können JOIN- und Suchabfragen bei größeren Datenmengen schneller werden.s*/

CREATE INDEX idx_buch_genre ON buch(genre_id);
CREATE INDEX idx_buch_sprache ON buch(sprache_id);
CREATE INDEX idx_buch_autor ON buch(autor_id);
CREATE INDEX idx_buch_verlag ON buch(verlag_id);
Show Index From buch;

CREATE INDEX idx_angebot_buch ON angebot(buch_id);
CREATE INDEX idx_angebot_benutzer ON angebot(benutzer_id);
CREATE INDEX idx_angebot_standort ON angebot(standort_id);
Show Index From angebot;

CREATE INDEX idx_buchungsliste_benutzer ON buchungsliste(benutzer_id);
CREATE INDEX idx_buchungsliste_angebot ON buchungsliste(angebots_id);
Show Index From buchungsliste;

CREATE INDEX idx_reservierung_buchungsliste ON reservierung(buchungsliste_id);
Show Index From reservierung;

CREATE INDEX idx_ausleihe_reservierung ON ausleihe(reservierung_id);
Show Index From ausleihe;

CREATE INDEX idx_zahlung_ausleihe ON zahlung(ausleihe_id);
Show Index From zahlung;

CREATE INDEX idx_rechnung_zahlung ON rechnung(zahlungs_id);

/* 
   3.4 View für verfügbare Bücher als Grundlage für Filtersystem
-- Die View fasst wichtige Informationen aus mehreren Tabellen zusammen.
-- Eine spätere Webanwendung könnte darauf filtern, z. B. nach Genre, Sprache oder Ort.*/

CREATE OR REPLACE VIEW verfuegbare_buecher AS
SELECT 
    b.buch_id,
    b.titel,
    au.autorname,
    g.genrename AS genre,
    sp.sprache,
    v.verlagsname,
    a.angebots_id,
    a.zustand,
    a.verfuegbarkeit,
    a.leihdauer,
    a.versandoption,
    st.ort,
    st.postleitzahl,
    st.adresse
FROM angebot a
JOIN buch b ON a.buch_id = b.buch_id
JOIN autor au ON b.autor_id = au.autor_id
JOIN genre g ON b.genre_id = g.genre_id
JOIN sprache sp ON b.sprache_id = sp.sprache_id
JOIN verlag v ON b.verlag_id = v.verlag_id
JOIN standort st ON a.standort_id = st.standort_id
WHERE a.verfuegbarkeit = 'verfuegbar';

-- Test der View
SELECT * FROM verfuegbare_buecher;

SELECT * FROM verfuegbare_buecher WHERE genre = 'Manga';

SELECT * FROM verfuegbare_buecher WHERE sprache = 'Deutsch';

SELECT * FROM verfuegbare_buecher WHERE ort = 'Budenheim';


/* 
 3.5. Statusänderung bei Ausleihe und Rückgabe
 Diese SQL-Vorlage dient als Grundlage für die spätere App-Entwicklung. Die konkrete angebots_id wird vom Anwendungscode übergeben.*/


-- Angebot ausleihen
UPDATE angebot
SET verfuegbarkeit = 'ausgeliehen'
WHERE angebots_id = :angebots_id
AND verfuegbarkeit = 'verfuegbar';

-- Angebot zurückgeben
UPDATE angebot
SET verfuegbarkeit = 'verfuegbar'
WHERE angebots_id = :angebots_id
AND verfuegbarkeit = 'ausgeliehen';


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
