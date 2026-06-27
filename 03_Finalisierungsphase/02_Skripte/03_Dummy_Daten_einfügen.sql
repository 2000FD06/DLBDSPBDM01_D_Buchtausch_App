USE buchtausch_app;
-- Input der dummy Daten benutzer
INSERT INTO benutzer 
(name, adresse, geburtsdatum, e_mail, telefonnummer, rolle)
VALUES
('Max Mustermann', 'Musterstraße 1, 55257 Budenheim', '1997-06-29', 'max.mustermann@example.com', '015100000001', 'Benutzer'),

('Anna Beispiel', 'Buchweg 2, 55257 Budenheim', '2000-03-13', 'anna.beispiel@example.com', '015100000002', 'Administrator'),

('Lukas Weber', 'Lesestraße 3, 55257 Budenheim', '2008-07-06', 'lukas.weber@example.com', '015100000003', 'Benutzer'),

('Mia Schneider', 'Tauschallee 4, 55257 Budenheim', '1992-01-27', 'mia.schneider@example.com', '015100000004', 'Benutzer'),

('Noah Fischer', 'Romanweg 5, 55257 Budenheim', '1997-05-18', 'noah.fischer@example.com', '015100000005', 'Benutzer'),

('Lea Wagner', 'Bibliotheksweg 6, 55257 Budenheim', '1983-02-27', 'lea.wagner@example.com', '015100000006', 'Benutzer'),

('Ben Hoffmann', 'Seitenstraße 7, 55257 Budenheim', '1979-12-24', 'ben.hoffmann@example.com', '015100000007', 'Benutzer'),

('Emma Becker', 'Kapitelweg 8, 55257 Budenheim', '1989-09-09', 'emma.becker@example.com', '015100000008', 'Benutzer'),

('Paul Schulz', 'Bücherplatz 9, 55257 Budenheim', '2003-11-17', 'paul.schulz@example.com', '015100000009', 'Benutzer'),

('Sofia Richter', 'Leseplatz 10, 55257 Budenheim', '1985-06-21', 'sofia.richter@example.com', '015100000010', 'Benutzer'),

('Tim Klein', 'Medienweg 11, 55257 Budenheim', '1985-08-03', 'tim.klein@example.com', '015100000011', 'Benutzer'),

('Laura Wolf', 'Tauschstraße 12, 55257 Budenheim', '1999-10-18', 'laura.wolf@example.com', '015100000012', 'Benutzer');

-- Zeigt das Innere der Tabelle an
SELECT 
    benutzer_id,
    name,
    adresse,
    DATE_FORMAT(geburtsdatum, '%d.%m.%Y') AS geburtsdatum,
    e_mail,
    telefonnummer,
    rolle
FROM benutzer;

-- Input der dummy Daten genre
INSERT INTO genre
(genrename)
VALUES
('Roman'),
('Krimi'),
('Fantasy'),
('Science Fiction'),
('Thriller'),
('Biografie'),
('Sachbuch'),
('Ratgeber'),
('Kinderbuch'),
('Jugendbuch'),
('Manga'),
('Comic'),
('Drama'),
('Romance'),
('Sport');

-- Zeigt das Innere der Tabelle an
SELECT * FROM genre;

-- Input der dummy Daten autor
INSERT INTO autor
(autorname)
VALUES
('Eiichiro Oda'),         

('Akira Toriyama'),       

('Masashi Kishimoto'),     

('Koyoharu Gotouge'),      

('Gege Akutami'),          

('Chugong'),              

('J. K. Rowling'),

('Stephen King'),

('Agatha Christie'),

('George Orwell'),

('J. R. R. Tolkien'),

('Cornelia Funke');

-- Zeigt das Innere der Tabelle an
SELECT * FROM autor;

-- Input der dummy Daten
INSERT INTO sprache
(sprache)
VALUES
('Deutsch'),

('Englisch'),

('Türkisch'),

('Japanisch'),

('Koreanisch'),

('Französisch'),

('Spanisch'),

('Italienisch'),

('Arabisch'),

('Russisch');

-- Zeigt das Innere der Tabelle an
SELECT * FROM sprache;

-- Input der dummy Daten verlag
INSERT INTO verlag
(verlagsname)
VALUES
('Shueisha'),

('Carlsen Verlag'),

('Crunchyroll Manga'),

('Altraverse'),

('Bloomsbury'),

('Heyne Verlag'),

('Atlantik Verlag'),

('Fischer Verlag'),

('Klett-Cotta'),

('Dressler Verlag');

-- Zeigt das Innere der Tabelle an
SELECT * From verlag;


-- Input der dummy Daten standort
INSERT INTO standort
(ort, postleitzahl, adresse)
VALUES
('Budenheim', '55257', 'Musterstraße 1'),

('Budenheim', '55257', 'Buchweg 2'),

('Budenheim', '55257', 'Lesestraße 3'),

('Budenheim', '55257', 'Tauschallee 4'),

('Budenheim', '55257', 'Romanweg 5'),

('Budenheim', '55257', 'Bibliotheksweg 6'),

('Budenheim', '55257', 'Seitenstraße 7'),

('Budenheim', '55257', 'Kapitelweg 8'),

('Budenheim', '55257', 'Bücherplatz 9'),

('Budenheim', '55257', 'Leseplatz 10');

Select * from standort;

-- Input der dummy Daten buch
INSERT INTO buch
(titel, sprache_id, erscheinungsjahr, autor_id, genre_id, verlag_id)
VALUES
('One Piece Band 1', 1, 1997, 1, 11, 2),

('Dragon Ball Band 1', 2, 1984, 2, 11, 2),

('Naruto Band 1', 3, 1999, 3, 11, 2),

('Demon Slayer Band 1', 4, 2016, 4, 11, 3),

('Jujutsu Kaisen Band 1', 1, 2018, 5, 11, 3),

('Solo Leveling Band 1', 7, 2018, 6, 11, 4),

('Harry Potter und der Stein der Weisen', 2, 1997, 7, 3, 2),

('Es', 6, 1986, 8, 5, 6),

('Mord im Orient-Express', 5, 1934, 9, 2, 7),

('1984', 9, 1949, 10, 7, 8),

('Der Herr der Ringe', 10, 1954, 11, 3, 9),

('Tintenherz', 8, 2003, 12, 8, 10);

-- Zeigt das Innere der Tabelle an
SELECT 
    b.buch_id,
    b.titel,
    s.sprache,
    b.erscheinungsjahr,
    a.autorname,
    g.genrename,
    v.verlagsname
FROM buch b
JOIN sprache s ON b.sprache_id = s.sprache_id
JOIN autor a ON b.autor_id = a.autor_id
JOIN genre g ON b.genre_id = g.genre_id
JOIN verlag v ON b.verlag_id = v.verlag_id;

-- Löschen des Buches mit der ID Nummer 10 
DELETE From	buch 
where buch_id = 10

-- Input der dummy Daten buch
INSERT INTO buch 
(titel, sprache_id, erscheinungsjahr, autor_id, genre_id, verlag_id)
VALUES 
('1984', 9, 1949, 10, 7, 8);

-- Input der dummy Daten angebot
INSERT INTO angebot
(buch_id, benutzer_id, standort_id, verfuegbarkeit, leihdauer, versandoption, zustand)
VALUES
(1, 1, 1, 'verfuegbar', 14, 'nein', 'Neu'),

(2, 2, 2, 'verfuegbar', 21, 'ja', 'gut'),

(3, 3, 3, 'reserviert', 14, 'nein', 'gut'),

(4, 4, 4, 'verfuegbar', 10, 'ja', 'sehr gut'),

(5, 5, 5, 'ausgeliehen', 21, 'nein', 'gebraucht'),

(6, 6, 6, 'verfuegbar', 14, 'ja', 'neu'),

(7, 7, 7, 'verfuegbar', 30, 'nein', 'gut'),

(8, 8, 8, 'nicht_verfuegbar', 14, 'nein', 'gebraucht'),

(9, 9, 9, 'verfuegbar', 21, 'ja', 'schlecht'),

(10, 10, 10, 'reserviert', 14, 'nein', 'gut'),

(11, 11, 1, 'verfuegbar', 30, 'ja', 'sehr gut'),

(12, 12, 2, 'verfuegbar', 14, 'nein', 'gut');

-- Im Inmput der Dummy gab es ein Fheler, weil es den Buch 10 nicht mehr gibt

-- Input der dummy Daten angebot 2 Versuch
INSERT INTO angebot
(buch_id, benutzer_id, standort_id, verfuegbarkeit, leihdauer, versandoption, zustand)
VALUES

(1, 1, 1, 'verfuegbar', 14, 'nein', 'neu'),

(2, 2, 2, 'verfuegbar', 21, 'ja', 'gut'),

(3, 3, 3, 'reserviert', 14, 'nein', 'gut'),

(4, 4, 4, 'verfuegbar', 10, 'ja', 'sehr gut'),

(5, 5, 5, 'ausgeliehen', 21, 'nein', 'gebraucht'),

(6, 6, 6, 'verfuegbar', 14, 'ja', 'neu'),

(7, 7, 7, 'verfuegbar', 30, 'nein', 'gut'),

(8, 8, 8, 'nicht_verfuegbar', 14, 'nein', 'gebraucht'),

(9, 9, 9, 'verfuegbar', 21, 'ja', 'schlecht'),

(11, 11, 1, 'verfuegbar', 30, 'ja', 'sehr gut'),

(12, 12, 2, 'verfuegbar', 14, 'nein', 'gut'),

(13, 1, 3, 'verfuegbar', 21, 'ja', 'neu');

-- Zeigt das Innere der Tabelle an
SELECT 
    ag.angebots_id,
    b.titel,
    u.name AS anbieter,
    s.adresse AS abholadresse,
    ag.verfuegbarkeit,
    ag.leihdauer,
    ag.versandoption,
    ag.zustand
FROM angebot ag
JOIN buch b ON ag.buch_id = b.buch_id
JOIN benutzer u ON ag.benutzer_id = u.benutzer_id
JOIN standort s ON ag.standort_id = s.standort_id
ORDER BY ag.angebots_id;

-- hinzufügen weiterer Dummy daten von standort
INSERT INTO standort
(ort, postleitzahl, adresse)
VALUES
('Budenheim', '55257', 'DHL Paketshop, Binger Straße 25'),
('Budenheim', '55257', 'DHL Packstation, Mainzer Straße 45');

-- Daten der Tabelle Verändern(Updaten) mit den neuen adressen
UPDATE angebot
SET standort_id = 11
WHERE angebots_id IN (2, 4, 9);

UPDATE angebot
SET standort_id = 12
WHERE angebots_id IN (6, 11, 13);

UPDATE angebot ag
JOIN benutzer u 
    ON ag.benutzer_id = u.benutzer_id
JOIN standort s 
    ON s.adresse = u.adresse
SET ag.standort_id = s.standort_id
WHERE ag.versandoption = 'nein';

-- Zeigt das Innere der Tabelle an
SELECT * FROM standort;

-- hinzufügen weiterer Dummy daten von standort
INSERT INTO standort
(ort, postleitzahl, adresse)
VALUES
('Budenheim', '55257', 'Wilhelmstraße 23');

-- Daten der Tabelle Verändern(Updaten) mit den neuen adressen
UPDATE angebot ag
JOIN benutzer u 
    ON ag.benutzer_id = u.benutzer_id
JOIN standort s 
    ON CONCAT(s.adresse, ', ', s.postleitzahl, ' ', s.ort) = u.adresse
SET ag.standort_id = s.standort_id
WHERE ag.versandoption = 'nein';

-- Zeigt das Innere der Tabelle an
SELECT 
    ag.angebots_id,
    b.titel,
    u.name AS anbieter,
    u.adresse AS benutzeradresse,
    CONCAT(s.adresse, ', ', s.postleitzahl, ' ', s.ort) AS abhol_oder_versandadresse,
    ag.verfuegbarkeit,
    ag.leihdauer,
    ag.versandoption,
    ag.zustand
FROM angebot ag
JOIN buch b 
    ON ag.buch_id = b.buch_id
JOIN benutzer u 
    ON ag.benutzer_id = u.benutzer_id
JOIN standort s 
    ON ag.standort_id = s.standort_id
ORDER BY ag.angebots_id;

-- Daten der Tabelle Verändern(Updaten) mit den neuen adressen
UPDATE angebot
SET standort_id = 11
WHERE angebots_id IN (16, 21, 24);

-- Daten der Tabelle Verändern(Updaten) mit den neuen adressen
UPDATE angebot
SET standort_id = 12
WHERE angebots_id IN (18, 22);

-- Input der dummy Daten zeitslot
INSERT INTO zeitslot
(datum, angebots_id, uhrzeit_von, uhrzeit_bis, verfuegbarkeit_abholung)
VALUES
('2026-05-05', 13, '16:00:00', '18:00:00', 'verfügbar'),

('2026-05-06', 14, '10:00:00', '12:00:00', 'reserviert'),

('2026-05-07', 15, '14:00:00', '16:00:00', 'verfügbar'),

('2026-05-08', 16, '17:00:00', '19:00:00', 'verfügbar'),

('2026-05-09', 17, '15:00:00', '17:00:00', 'reserviert'),

('2026-05-10', 18, '11:00:00', '13:00:00', 'verfügbar'),

('2026-05-11', 19, '18:00:00', '20:00:00', 'verfügbar'),

('2026-05-12', 20, '09:00:00', '11:00:00', 'nicht_verfügbar'),

('2026-05-13', 21, '13:00:00', '15:00:00', 'verfügbar'),

('2026-05-14', 22, '16:30:00', '18:30:00', 'reserviert'),

('2026-05-15', 23, '12:00:00', '14:00:00', 'verfügbar'),

('2026-05-16', 24, '15:30:00', '17:30:00', 'verfügbar');

-- Zeigt das Innere der Tabelle an
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

-- Input der dummy Daten buchungsliste
INSERT INTO buchungsliste
(benutzer_id, angebots_id)
VALUES
(2, 13),

(3, 14),

(4, 15),

(5, 16),

(6, 17),

(7, 18),

(8, 19),

(9, 20),

(10, 21),

(11, 22),

(12, 23),

-- Zeigt das Innere der Tabelle an
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

-- Input der dummy Daten reservierung
INSERT INTO reservierung
(buchungsliste_id, reservierungsdatum, reservierungsstatus)
VALUES
(1, '2026-05-05', 'bestätigt'),

(2, '2026-05-06', 'offen'),

(3, '2026-05-07', 'bestätigt'),

(4, '2026-05-08', 'bestätigt'),

(5, '2026-05-09', 'offen'),

(6, '2026-05-10', 'abgelehnt'),

(7, '2026-05-11', 'bestätigt'),

(8, '2026-05-12', 'storniert'),

(9, '2026-05-13', 'bestätigt'),

(10, '2026-05-14', 'offen'),

(11, '2026-05-15', 'bestätigt'),

(12, '2026-05-16', 'bestätigt');

-- Zeigt das Innere der Tabelle an
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

-- Updaten der reservierungs Daten in der Tabelle
UPDATE reservierung
SET reservierungsstatus = 'bestätigt'
WHERE reservierung_id IN (2, 5, 10);

-- hinzufügen weiterer Dummy daten von ausleihe
INSERT INTO ausleihe
(reservierung_id, ausleihdatum, rueckgabedatum, status)
VALUES
(1, '2026-05-06', '2026-05-20', 'zurückgegeben'),
(2, '2026-05-07', '2026-05-21', 'aktiv'),
(3, '2026-05-08', '2026-05-22', 'aktiv'),
(4, '2026-05-09', '2026-05-23', 'zurückgegeben'),
(5, '2026-05-10', '2026-05-24', 'aktiv'),
(7, '2026-05-12', '2026-05-26', 'zurückgegeben'),
(9, '2026-05-14', '2026-05-28', 'aktiv'),
(10, '2026-05-15', '2026-05-29', 'aktiv'),
(11, '2026-05-16', '2026-05-30', 'zurückgegeben'),
(12, '2026-05-17', '2026-05-31', 'aktiv');

-- Zeigt das Innere der Tabelle an
SELECT 
    a.ausleihe_id,
    a.ausleihdatum,
    a.rueckgabedatum,
    a.status,
    r.reservierungsstatus,
    u.name AS ausleiher,
    b.titel AS ausgeliehenes_buch
FROM ausleihe a
JOIN reservierung r ON a.reservierung_id = r.reservierung_id
JOIN buchungsliste bl ON r.buchungsliste_id = bl.buchungsliste_id
JOIN benutzer u ON bl.benutzer_id = u.benutzer_id
JOIN angebot ag ON bl.angebots_id = ag.angebots_id
JOIN buch b ON ag.buch_id = b.buch_id
ORDER BY a.ausleihe_id;

-- Input der dummy Daten bewertung
INSERT INTO bewertung
(benutzer_id, buch_id, sternenbewertung, kommentar, datum)
VALUES
(2, 1, 5, 'Sehr spannender Einstieg in die Reihe.', '2026-05-21'),

(3, 2, 4, 'Gut erhalten und angenehm zu lesen.', '2026-05-22'),

(4, 3, 5, 'Tolles Buch, würde ich wieder ausleihen.', '2026-05-23'),

(5, 4, 4, 'Guter Zustand und interessante Geschichte.', '2026-05-24'),

(6, 5, 3, 'Inhalt gut, aber das Buch war etwas gebraucht.', '2026-05-25'),

(7, 6, 5, 'Sehr guter Zustand und schnelle Übergabe.', '2026-05-26'),

(8, 7, 5, 'Ein Klassiker, hat mir sehr gefallen.', '2026-05-27'),

(9, 8, 4, 'Spannend, aber teilweise sehr lang.', '2026-05-28'),

(10, 9, 4, 'Guter Krimi und einfache Abholung.', '2026-05-29'),

(11, 13, 3, 'Interessantes Buch, aber nicht ganz mein Geschmack.', '2026-05-30');

-- Zeigt das Innere der Tabelle an
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

-- Input der dummy Daten zahlung
INSERT INTO zahlung
(ausleihe_id, zahlungsoption, betrag, zahlungsstatus)
VALUES
(1, 'bar', 0.00, 'bezahlt'),

(2, 'paypal', 2.50, 'bezahlt'),

(3, 'überweisung', 1.50, 'offen'),

(4, 'karte', 3.00, 'bezahlt'),

(5, 'bar', 0.00, 'offen'),

(6, 'paypal', 2.00, 'bezahlt'),

(7, 'überweisung', 1.00, 'bezahlt'),

(8, 'karte', 2.50, 'offen'),

(9, 'bar', 0.00, 'bezahlt'),

(10, 'paypal', 3.50, 'bezahlt');


-- Zeigt das Innere der Tabelle an
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

-- Zeigt das Innere der Tabelle an
SELECT 
    zahlungs_id,
    ausleihe_id,
    zahlungsoption,
    betrag,
    zahlungsstatus
FROM zahlung
ORDER BY zahlungs_id;

-- Input der dummy Daten rechnung
INSERT INTO rechnung
(zahlungs_id, rechnungsdatum, rechnungsname, rechnungsadresse, betrag)
VALUES
(1, '2026-05-06', 'Max Mustermann', 'Musterstraße 1, 55257 Budenheim', 0.00),

(2, '2026-05-07', 'Anna Beispiel', 'Buchweg 2, 55257 Budenheim', 2.50),

(3, '2026-05-08', 'Lukas Weber', 'Lesestraße 3, 55257 Budenheim', 1.50),

(4, '2026-05-09', 'Mia Schneider', 'Tauschallee 4, 55257 Budenheim', 3.00),

(5, '2026-05-10', 'Noah Fischer', 'Romanweg 5, 55257 Budenheim', 0.00),

(6, '2026-05-12', 'Lea Wagner', 'Bibliotheksweg 6, 55257 Budenheim', 2.00),

(7, '2026-05-14', 'Ben Hoffmann', 'Seitenstraße 7, 55257 Budenheim', 1.00),

(8, '2026-05-15', 'Emma Becker', 'Kapitelweg 8, 55257 Budenheim', 2.50),

(9, '2026-05-16', 'Paul Schulz', 'Bücherplatz 9, 55257 Budenheim', 0.00),

(10, '2026-05-17', 'Sofia Richter', 'Leseplatz 10, 55257 Budenheim', 3.50);

-- Zeigt das Innere der Tabelle an
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

