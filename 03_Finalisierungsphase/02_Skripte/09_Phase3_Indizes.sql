USE buchtausch_app;

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
