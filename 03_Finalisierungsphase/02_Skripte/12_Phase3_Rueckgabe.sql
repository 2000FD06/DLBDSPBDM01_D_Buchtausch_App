USE buchtausch_app;

/* 
 3.5. Statusänderung bei Rückgabe
 Diese SQL-Vorlage dient als Grundlage für die spätere App-Entwicklung. Die konkrete angebots_id wird vom Anwendungscode übergeben.*/

-- Angebot zurückgeben
UPDATE angebot
SET verfuegbarkeit = 'verfuegbar'
WHERE angebots_id = :angebots_id
AND verfuegbarkeit = 'ausgeliehen';
