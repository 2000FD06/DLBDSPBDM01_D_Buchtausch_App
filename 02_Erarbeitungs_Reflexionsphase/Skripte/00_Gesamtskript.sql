-- DB anzeigen
SHOW DATABASES; 

-- DB erstellen
CREATE DATABASE buchtausch_app
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

-- DB auswählen
USE buchtausch_app;

-- DB auswahlanzeigen
SELECT DATABASE();

-- Tabelle erstellen: Benutzer
CREATE TABLE benutzer (
    benutzer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    adresse VARCHAR(255),
    geburtsdatum DATE,
    e_mail VARCHAR(100) NOT NULL UNIQUE,
    telefonnummer VARCHAR(30),
    rolle ENUM('Benutzer', 'Administrator') NOT NULL
);
	 -- Tabellen anzeigen
	SHOW TABLES;
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE benutzer;
	-- Zeigt das Innere der Tabelle an
	SELECT * from benutzer;


-- Tabelle erstellen: Genre
CREATE TABLE genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genrename VARCHAR(100) NOT NULL UNIQUE
);
	 -- Tabellen anzeigen
	SHOW TABLES;
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE genre;
	-- Zeigt das Innere der Tabelle an
	SELECT * FROM genre;


-- Tabelle erstellen: Autor
CREATE TABLE autor (
    autor_id INT AUTO_INCREMENT PRIMARY KEY,
    autorname VARCHAR(255) NOT NULL
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE autor;
	-- Zeigt das Innere der Tabelle an
	SELECT * from autor;


-- Tabelle erstellen: Sprache
CREATE TABLE sprache (
    sprache_id INT AUTO_INCREMENT PRIMARY KEY,
    sprache VARCHAR(100) NOT NULL UNIQUE
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE sprache;
	-- Zeigt das Innere der Tabelle an
	SELECT * from sprache;

-- Tabelle erstellen: Verlag
CREATE TABLE verlag (
    verlag_id INT AUTO_INCREMENT PRIMARY KEY,
    verlagsname VARCHAR(255) NOT NULL
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE verlag;
	-- Zeigt das Innere der Tabelle an
	SELECT * from verlag;

-- Tabelle erstellen: Standort
CREATE TABLE standort (
    standort_id INT AUTO_INCREMENT PRIMARY KEY,
    ort VARCHAR(100) NOT NULL,
    postleitzahl VARCHAR(10) NOT NULL,
    adresse VARCHAR(255) NOT NULL
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE standort;
	-- Zeigt das Innere der Tabelle an
	SELECT * from standort;

-- Tabelle erstellen: Buch
CREATE TABLE buch (
    buch_id INT AUTO_INCREMENT PRIMARY KEY,
    titel VARCHAR(255) NOT NULL,
    sprache_id INT NOT NULL,
    erscheinungsjahr YEAR,
    autor_id INT NOT NULL,
    genre_id INT NOT NULL,
    verlag_id INT NOT NULL,
    
	-- Fremdschlüssel
    CONSTRAINT fk_buch_sprache
        FOREIGN KEY (sprache_id)
        REFERENCES sprache(sprache_id),

    CONSTRAINT fk_buch_autor
        FOREIGN KEY (autor_id)
        REFERENCES autor(autor_id),

    CONSTRAINT fk_buch_genre
        FOREIGN KEY (genre_id)
        REFERENCES genre(genre_id),

    CONSTRAINT fk_buch_verlag
        FOREIGN KEY (verlag_id)
        REFERENCES verlag(verlag_id)
        );
	-- Zeigt die Struktur der Tabelle an.  
	DESCRIBE buch;    
	-- Zeigt das Innere der Tabelle an
	SELECT * from buch;
    
-- Tabelle erstellen: Angebot
CREATE TABLE angebot (
    angebots_id INT AUTO_INCREMENT PRIMARY KEY,
    buch_id INT NOT NULL,
    benutzer_id INT NOT NULL,
    standort_id INT NOT NULL,
    verfuegbarkeit ENUM('verfuegbar', 'reserviert', 'ausgeliehen', 'nicht_verfuegbar') NOT NULL DEFAULT 'verfuegbar',
    leihdauer INT NOT NULL,
    versandoption ENUM('ja', 'nein') NOT NULL DEFAULT 'nein',
    zustand VARCHAR(100),
    
	-- Fremdschlüssel
    CONSTRAINT fk_angebot_buch
        FOREIGN KEY (buch_id)
        REFERENCES buch(buch_id),

    CONSTRAINT fk_angebot_benutzer
        FOREIGN KEY (benutzer_id)
        REFERENCES benutzer(benutzer_id),

    CONSTRAINT fk_angebot_standort
        FOREIGN KEY (standort_id)
        REFERENCES standort(standort_id)

);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE angebot;
	-- Zeigt das Innere der Tabelle an
	SELECT * from angebot;

-- Tabelle erstellen: Zeitslot
CREATE TABLE zeitslot (
    zeitslot_id INT AUTO_INCREMENT PRIMARY KEY,
    datum DATE NOT NULL,
    angebots_id INT NOT NULL,
    uhrzeit_von TIME NOT NULL,
    uhrzeit_bis TIME NOT NULL,
    verfuegbarkeit_abholung ENUM('verfügbar', 'reserviert', 'nicht_verfügbar') NOT NULL DEFAULT 'verfügbar',
    
	-- Fremdschlüssel
    CONSTRAINT fk_zeitslot_angebot
        FOREIGN KEY (angebots_id)
        REFERENCES angebot(angebots_id)
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE zeitslot;
	-- Zeigt das Innere der Tabelle an
	SELECT * from zeitslot;
    
-- Tabelle erstellen: Buchungsliste
CREATE TABLE buchungsliste (
    buchungsliste_id INT AUTO_INCREMENT PRIMARY KEY,
    benutzer_id INT NOT NULL,
    angebots_id INT NOT NULL,
    hinzugefuegt_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
	-- Fremdschlüssel
    CONSTRAINT fk_buchungsliste_benutzer
        FOREIGN KEY (benutzer_id)
        REFERENCES benutzer(benutzer_id),

    CONSTRAINT fk_buchungsliste_angebot
        FOREIGN KEY (angebots_id)
        REFERENCES angebot(angebots_id)
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE buchungsliste; 
	-- Zeigt das Innere der Tabelle an
	SELECT * from buchungsliste;
    
-- Tabelle erstellen: reservierung
CREATE TABLE reservierung (
    reservierung_id INT AUTO_INCREMENT PRIMARY KEY,
    buchungsliste_id INT NOT NULL,
    reservierungsdatum DATE NOT NULL,
    reservierungsstatus ENUM('offen', 'bestätigt', 'abgelehnt', 'storniert') NOT NULL DEFAULT 'offen',
    
	-- Fremdschlüssel
    CONSTRAINT fk_reservierung_buchungsliste
        FOREIGN KEY (buchungsliste_id)
        REFERENCES buchungsliste(buchungsliste_id)
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE reservierung; 
	-- Zeigt das Innere der Tabelle an
	SELECT * from reservierung;
    
-- Tabelle erstellen: ausleihe
CREATE TABLE ausleihe (
    ausleihe_id INT AUTO_INCREMENT PRIMARY KEY,
    reservierung_id INT NOT NULL,
    ausleihdatum DATE NOT NULL,
    rueckgabedatum DATE,
    status ENUM('aktiv', 'zurückgegeben', 'überfällig', 'storniert') NOT NULL DEFAULT 'aktiv',
    
	-- Fremdschlüssel
    CONSTRAINT fk_ausleihe_reservierung
        FOREIGN KEY (reservierung_id)
        REFERENCES reservierung(reservierung_id)
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE ausleihe; 
	-- Zeigt das Innere der Tabelle an
	SELECT * from ausleihe;


-- Tabelle erstellen: bewertung
CREATE TABLE bewertung (
    bewertung_id INT AUTO_INCREMENT PRIMARY KEY,
    benutzer_id INT NOT NULL,
    buch_id INT NOT NULL,
    sternenbewertung INT NOT NULL,
    kommentar VARCHAR(255),
    datum DATE NOT NULL,
    
	-- Fremdschlüssel
    CONSTRAINT fk_bewertung_benutzer
        FOREIGN KEY (benutzer_id)
        REFERENCES benutzer(benutzer_id),

    CONSTRAINT fk_bewertung_buch
        FOREIGN KEY (buch_id)
        REFERENCES buch(buch_id),
        
    CONSTRAINT chk_sternenbewertung
        CHECK (sternenbewertung BETWEEN 1 AND 5)
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE bewertung; 
	-- Zeigt das Innere der Tabelle an
	SELECT * from bewertung;

-- Tabelle erstellen: zahlung
CREATE TABLE zahlung (
    zahlungs_id INT AUTO_INCREMENT PRIMARY KEY,
    ausleihe_id INT NOT NULL,
    zahlungsoption ENUM('bar', 'paypal', 'überweisung', 'karte') NOT NULL,
    betrag DECIMAL(10,2) NOT NULL,
    zahlungsstatus ENUM('offen', 'bezahlt', 'storniert') NOT NULL DEFAULT 'offen',
    
	-- Fremdschlüssel
    CONSTRAINT fk_zahlung_ausleihe
        FOREIGN KEY (ausleihe_id)
        REFERENCES ausleihe(ausleihe_id)
);

	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE zahlung; 
	-- Zeigt das Innere der Tabelle an
	SELECT * from zahlung;

-- Tabelle erstellen: rechnung
CREATE TABLE rechnung (
    rechnungs_id INT AUTO_INCREMENT PRIMARY KEY,
    zahlungs_id INT NOT NULL,
    rechnungsdatum DATE NOT NULL,
    rechnungsname VARCHAR(255) NOT NULL,
    rechnungsadresse VARCHAR(255) NOT NULL,
    betrag DECIMAL(10,2) NOT NULL,
    
	-- Fremdschlüssel
    CONSTRAINT fk_rechnung_zahlung
        FOREIGN KEY (zahlungs_id)
        REFERENCES zahlung(zahlungs_id)
);
	-- Zeigt die Struktur der Tabelle an.
	DESCRIBE rechnung; 
	-- Zeigt das Innere der Tabelle an
	SELECT * from rechnung;


-- Input der Dummy-Daten benutzer
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
-- Input der Dummy-Daten standort

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

SELECT * From standort;

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



-- hinzufügen weiterer Dummy daten von zeitslot
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

-- hinzufügen weiterer Dummy daten von buchungsliste
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

-- hinzufügen weiterer Dummy daten von reservierung
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

-- hinzufügen weiterer Dummy daten von bewertung
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

-- hinzufügen weiterer Dummy daten von zahlung
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

-- hinzufügen weiterer Dummy daten von rechnung
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

-- Weitrer Select Befehl zum testen Der Tabllen
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