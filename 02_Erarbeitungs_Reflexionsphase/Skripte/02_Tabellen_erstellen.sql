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



