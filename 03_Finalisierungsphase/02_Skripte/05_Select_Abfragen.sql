-- Weitrer Select Befehle zum testen Der Tabllen
SELECT * FROM benutzer;
SELECT *from genre g 


SELECT benutzer_id, name
FROM benutzer
ORDER BY benutzer_id;

SELECT angebots_id, buch_id, benutzer_id, versandoption
FROM angebot
ORDER BY angebots_id;


SELECT * FROM autor;
SELECT * FROM sprache;
SELECT * FROM verlag;
SELECT 	* FROM standort; 

SELECT 
    ag.angebots_id,
    b.titel,
    u.name AS anbieter,
    u.adresse AS benutzeradresse,
    s.adresse AS abhol_oder_versandadresse,
    ag.versandoption,
    ag.verfuegbarkeit,
    ag.leihdauer,
    ag.zustand
FROM angebot ag
JOIN buch b ON ag.buch_id = b.buch_id
JOIN benutzer u ON ag.benutzer_id = u.benutzer_id
JOIN standort s ON ag.standort_id = s.standort_id
ORDER BY ag.angebots_id;

SELECT 	* FROM zeitslot z ; 
SELECT
    z.zeitslot_id,
    z.datum,
    z.uhrzeit_von,
    z.uhrzeit_bis,
    z.verfuegbarkeit_abholung,
    ag.angebots_id,
    b.titel,
    u.name AS anbieter
FROM zeitslot z
JOIN angebot ag ON z.angebots_id = ag.angebots_id
JOIN buch b ON ag.buch_id = b.buch_id
JOIN benutzer u ON ag.benutzer_id = u.benutzer_id
ORDER BY z.zeitslot_id;

SELECT 
    bl.buchungsliste_id,
    u.name AS benutzer,
    b.titel AS vorgemerktes_buch,
    bl.hinzugefuegt_am
FROM buchungsliste bl
JOIN benutzer u ON bl.benutzer_id = u.benutzer_id
JOIN angebot ag ON bl.angebots_id = ag.angebots_id
JOIN buch b ON ag.buch_id = b.buch_id
ORDER BY bl.buchungsliste_id;

SELECT * FROM buchungsliste;
SELECT * FROM reservierung;
SELECT 
    r.reservierung_id,
    r.reservierungsdatum,
    r.reservierungsstatus,
    u.name AS benutzer,
    b.titel AS reserviertes_buch
FROM reservierung r
JOIN buchungsliste bl ON r.buchungsliste_id = bl.buchungsliste_id
JOIN benutzer u ON bl.benutzer_id = u.benutzer_id
JOIN angebot ag ON bl.angebots_id = ag.angebots_id
JOIN buch b ON ag.buch_id = b.buch_id
ORDER BY r.reservierung_id;

SELECT * FROM ausleihe;

SELECT * From bewertung;

SELECT 
    bw.bewertung_id,
    u.name AS benutzer,
    b.titel AS bewertetes_buch,
    bw.sternenbewertung,
    bw.kommentar,
    DATE_FORMAT(bw.datum, '%d.%m.%Y') AS datum
FROM bewertung bw
JOIN benutzer u ON bw.benutzer_id = u.benutzer_id
JOIN buch b ON bw.buch_id = b.buch_id
ORDER BY bw.bewertung_id;

SELECT * FROM zahlung;

SELECT 
    z.zahlungs_id,
    z.ausleihe_id,
    u.name AS ausleiher,
    b.titel AS buch,
    z.zahlungsoption,
    z.betrag,
    z.zahlungsstatus
FROM zahlung z
JOIN ausleihe a ON z.ausleihe_id = a.ausleihe_id
JOIN reservierung r ON a.reservierung_id = r.reservierung_id
JOIN buchungsliste bl ON r.buchungsliste_id = bl.buchungsliste_id
JOIN benutzer u ON bl.benutzer_id = u.benutzer_id
JOIN angebot ag ON bl.angebots_id = ag.angebots_id
JOIN buch b ON ag.buch_id = b.buch_id

SELECT * FROM rechnung;

SELECT 
    r.rechnungs_id,
    r.rechnungsdatum,
    r.rechnungsname,
    r.rechnungsadresse,
    r.betrag AS rechnungsbetrag,
    z.zahlungsoption,
    z.zahlungsstatus
FROM rechnung r
JOIN zahlung z ON r.zahlungs_id = z.zahlungs_id
ORDER BY r.rechnungs_id;

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


-- Test 1
SELECT 
    ag.angebots_id,
    b.titel,
    u.name AS anbieter,
    CONCAT(s.adresse, ', ', s.postleitzahl, ' ', s.ort) AS abholort,
    ag.verfuegbarkeit,
    ag.leihdauer,
    ag.versandoption,
    ag.zustand
FROM angebot ag
JOIN buch b ON ag.buch_id = b.buch_id
JOIN benutzer u ON ag.benutzer_id = u.benutzer_id
JOIN standort s ON ag.standort_id = s.standort_id
WHERE ag.verfuegbarkeit = 'verfuegbar'
ORDER BY b.titel;

-- Test 2
SELECT 
    bl.buchungsliste_id,
    r.reservierung_id,
    a.ausleihe_id,
    z.zahlungs_id,
    re.rechnungs_id,
    u.name AS ausleiher,
    b.titel AS buch,
    r.reservierungsstatus,
    a.status AS ausleihstatus,
    z.zahlungsstatus,
    re.betrag AS rechnungsbetrag
FROM buchungsliste bl
LEFT JOIN reservierung r ON bl.buchungsliste_id = r.buchungsliste_id
LEFT JOIN ausleihe a ON r.reservierung_id = a.reservierung_id
LEFT JOIN zahlung z ON a.ausleihe_id = z.ausleihe_id
LEFT JOIN rechnung re ON z.zahlungs_id = re.zahlungs_id
JOIN benutzer u ON bl.benutzer_id = u.benutzer_id
JOIN angebot ag ON bl.angebots_id = ag.angebots_id
JOIN buch b ON ag.buch_id = b.buch_id
ORDER BY bl.buchungsliste_id;

-- Test 3 
SELECT 
    bw.bewertung_id,
    u.name AS benutzer,
    b.titel AS bewertetes_buch,
    bw.sternenbewertung,
    bw.kommentar,
    DATE_FORMAT(bw.datum, '%d.%m.%Y') AS datum
FROM bewertung bw
JOIN benutzer u ON bw.benutzer_id = u.benutzer_id
JOIN buch b ON bw.buch_id = b.buch_id
ORDER BY bw.bewertung_id;

-- Test 4
SELECT 
    z.zahlungs_id,
    z.ausleihe_id,
    u.name AS ausleiher,
    b.titel AS buch,
    z.zahlungsoption,
    z.betrag,
    z.zahlungsstatus
FROM zahlung z
JOIN ausleihe a ON z.ausleihe_id = a.ausleihe_id
JOIN reservierung r ON a.reservierung_id = r.reservierung_id
JOIN buchungsliste bl ON r.buchungsliste_id = bl.buchungsliste_id
JOIN benutzer u ON bl.benutzer_id = u.benutzer_id
JOIN angebot ag ON bl.angebots_id = ag.angebots_id
JOIN buch b ON ag.buch_id = b.buch_id
ORDER BY z.zahlungs_id;

UPDATE ausleihe
SET status = 'zurückgegeben',
    rueckgabedatum = CURDATE()
WHERE ausleihe_id = 1;

-- Test 5
SELECT 
    ausleihe_id,
    reservierung_id,
    ausleihdatum,
    rueckgabedatum,
    status
FROM ausleihe
where ausleihe_id = 1;



