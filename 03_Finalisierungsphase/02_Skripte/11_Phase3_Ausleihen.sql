USE buchtausch_app;
/* 
 3.5. Statusänderung bei Ausleihe
 Diese SQL-Vorlage dient als Grundlage für die spätere App-Entwicklung. Die konkrete angebots_id wird vom Anwendungscode übergeben.*/

-- Angebot ausleihen
UPDATE angebot
SET verfuegbarkeit = 'ausgeliehen'
WHERE angebots_id = :angebots_id
AND verfuegbarkeit = 'verfuegbar';