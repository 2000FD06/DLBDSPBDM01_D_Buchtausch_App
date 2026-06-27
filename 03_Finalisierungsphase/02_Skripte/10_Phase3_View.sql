USE buchtausch_app;
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
