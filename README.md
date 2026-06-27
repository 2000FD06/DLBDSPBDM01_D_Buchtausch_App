Projekt: Buchtausch-App – Data-Mart-Erstellung in SQL
Autor: Furkan Demir
Matrikelnummer: IU14138041
Kurs: DLBDSPBDM01_D – Data-Mart-Erstellung in SQL
Datum: 27.06.2026

---------------------------------------------------------

Übersicht

---------------------------------------------------------

Diese ZIP-Datei enthält die vollständige finale Abgabe zum Projekt „Data-Mart-Erstellung in SQL“ für die Buchtausch-App. Das Projekt umfasst die Konzeptionsphase, die Erarbeitungs-/Reflexionsphase und die Finalisierungsphase. Es beinhaltet SQL-Skripte, Dokumentation, Abstract und einen GitHub-Verweis.

Die Datenbank wurde mit MySQL/MariaDB implementiert und in DBeaver getestet. Sie bildet zentrale Funktionen einer Buchtausch-App ab, darunter Benutzer, Bücher, Autoren, Genres, Sprachen, Verlage, Standorte, Angebote, Zeitslots, Buchungslisten, Reservierungen, Ausleihen, Bewertungen, Zahlungen und Rechnungen.

---------------------------------------------------------

Ordnerstruktur

---------------------------------------------------------

Die finale ZIP-Datei ist in folgende Hauptordner unterteilt:

01_Konzeptionsphase

→ enthält die Dokumentation der Konzeptionsphase.

Enthalten ist:

- Demir_Furkan_IU14138041_DLBDSPBDM01_D_P1_A.pdf

02_Erarbeitungs_Reflexionsphase

→ enthält die Dokumentation der Erarbeitungs-/Reflexionsphase und die SQL-Skripte der Datenbankumsetzung.

Enthalten sind:

- Demir_Furkan_IU14138041_DLBDSPBDM01_D_P2_A.pdf
- Skripte/

03_Finalisierungsphase

→ enthält die finale Dokumentation, die Dateien aus den vorherigen Phasen, das Abstract und die SQL-Skripte der Finalisierungsphase.

Enthalten sind:

- 01_Dokumente/
- 02_Skripte/

README

→ diese Datei beschreibt den Aufbau der Abgabe und die Ausführung der SQL-Skripte.

---------------------------------------------------------

Detailliertes Inhaltsverzeichnis

---------------------------------------------------------

01_Konzeptionsphase
└── Demir_Furkan_IU14138041_DLBDSPBDM01_D_P1_A.pdf

02_Erarbeitungs_Reflexionsphase
├── Demir_Furkan_IU14138041_DLBDSPBDM01_D_P2_A.pdf
└── Skripte
    ├── 00_Gesamtskript.sql
    ├── 01_Datenbank_einrichten.sql
    ├── 02_Tabellen_erstellen.sql
    ├── 03_Dummy_Daten_einfuegen.sql
    ├── 04_Anzahlpruefung_Tabellen.sql
    ├── 05_Select_Abfragen.sql
    ├── 06_Testfaelle.sql
    └── 07_Entwicklungsskript_Notizen.sql

03_Finalisierungsphase
├── 01_Dokumente
│   ├── Demir_Furkan_IU14138041_DLBDSPBDM01_D_P1_A.pdf
│   ├── Demir_Furkan_IU14138041_DLBDSPBDM01_D_P2_A.pdf
│   ├── Demir_Furkan_IU14138041_DLBDSPBDM01_D_P3_A.pdf
│   └── Demir_Furkan_IU14138041_DLBDSPBDM01_D_P3_A_Abstract.pdf
│
└── 02_Skripte
    ├── 00_Gesamtskript.sql
    ├── 01_Datenbank_einrichten.sql
    ├── 02_Tabellen_erstellen.sql
    ├── 03_Dummy_Daten_einfuegen.sql
    ├── 04_Anzahlpruefung_Tabellen.sql
    ├── 05_Select_Abfragen.sql
    ├── 06_Testfaelle.sql
    ├── 07_Entwicklungsskript_Notizen.sql
    ├── 08_Phase3_passwort_update.sql
    ├── 09_Phase3_Indizes.sql
    ├── 10_Phase3_View.sql
    ├── 11_Phase3_Ausleihen.sql
    ├── 12_Phase3_Rueckgabe.sql
    ├── 13_Phase3_Metadaten.sql
    └── 14_Phase3_Optimierung_und_Erweiterung_final.sql

---------------------------------------------------------

Projektbeschreibung

---------------------------------------------------------

Im Rahmen des Projekts wurde eine relationale Datenbank für eine Buchtausch-App entwickelt. Ziel war es, eine konsistente und nachvollziehbare Datenbankstruktur zu erstellen, die den lokalen Austausch und die Ausleihe von Büchern zwischen Usern unterstützt.

Die Datenbank bildet den Prozess von der Bereitstellung eines Buches bis zur Ausleihe und Rückgabe ab. User können Bücher erfassen, Angebote erstellen, Standorte und Zeitslots hinterlegen, Bücher reservieren, Ausleihen dokumentieren und Bewertungen abgeben. Zusätzlich werden Zahlungen und Rechnungen berücksichtigt.

Durch die Trennung von Stammdaten und prozessbezogenen Daten wird die Datenbank übersichtlich und normalisiert aufgebaut. Zu den Stammdaten gehören Benutzer, Buch, Autor, Genre, Sprache, Verlag und Standort. Prozessbezogene Daten werden unter anderem durch Angebot, Buchungsliste, Reservierung, Ausleihe, Bewertung, Zahlung und Rechnung abgebildet.

---------------------------------------------------------

Datenbankinformationen

---------------------------------------------------------

Datenbankname: buchtausch_app
DBMS: MySQL/MariaDB
Verwendetes Tool: DBeaver
Zeichensatz: utf8mb4
Anzahl der Basistabellen: 15
Zusätzlich: 1 View
Gesamtgröße der Datenbank: 0,73 MB

---------------------------------------------------------

Hinweis zur Ausführung

---------------------------------------------------------

1. ZIP-Datei entpacken.
2. MySQL/MariaDB starten.
3. DBeaver öffnen und eine Verbindung zur lokalen Datenbank herstellen.
4. Die SQL-Skripte nach Nummerierung ausführen.

Grundaufbau der Datenbank:

01_Datenbank_einrichten.sql
02_Tabellen_erstellen.sql
03_Dummy_Daten_einfuegen.sql

Kontrolle und Tests:

04_Anzahlpruefung_Tabellen.sql
05_Select_Abfragen.sql
06_Testfaelle.sql
07_Entwicklungsskript_Notizen.sql

Finalisierungsphase:

08_Phase3_passwort_update.sql
09_Phase3_Indizes.sql
10_Phase3_View.sql
11_Phase3_Ausleihen.sql
12_Phase3_Rueckgabe.sql
13_Phase3_Metadaten.sql
14_Phase3_Optimierung_und_Erweiterung_final.sql

Wichtiger Hinweis:

Die Dateien 11_Phase3_Ausleihen.sql und 12_Phase3_Rueckgabe.sql sind SQL-Vorlagen für eine spätere App- oder Webintegration. Sie sind nicht als einmalige Einrichtungsskripte gedacht. Die konkrete angebots_id wird später dynamisch über den Anwendungscode übergeben.

---------------------------------------------------------

GitHub-Repository

---------------------------------------------------------

Der vollständige Projektstand wird zusätzlich über GitHub bereitgestellt.

GitHub-Repository:
https://github.com/2000FD06/DLBDSPBDM01_D_Buchtausch_App

---------------------------------------------------------

Datenschutz-Hinweis

---------------------------------------------------------

Die verwendeten Daten sind Dummy-Daten und dienen ausschließlich zu Test- und Demonstrationszwecken. Personenbezogene Angaben wurden im Rahmen der Finalisierung durch neutrale Testdaten ersetzt. Das Repository enthält keine produktiven Zugangsdaten oder echten Passwörter.

---------------------------------------------------------

Kontakt

---------------------------------------------------------

Furkan Demir
IU Internationale Hochschule
Matrikelnummer: IU14138041
