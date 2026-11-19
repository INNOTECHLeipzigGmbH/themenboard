# Themenboard

Themenregister je Projekt (Themenlandkarte, Themenakte, Wochenrunde, Protokollpunkte, Rückmeldungen, externe Zugänge).

- Projekt wählen: Auswahlfeld oben oder direkt `index.html?p=<projekt_id>` (z. B. `?p=proj-rbl-keller`) – als Lesezeichen pro Projekt nutzbar.
- Projekte stammen aus `kaufland_status` (Statusboard). Neue Projekte erscheinen dort automatisch.
- „⚙ Projekt“: Protokoll-Ordner und Handlungsfelder des Projekts festlegen (Tabelle `themen_projekt`). Ohne Eintrag wird der Ordner automatisch erkannt, Handlungsfeld = „Allgemein“.
- `extern.html?t=<token>`: persönliche Ansicht für externe Personen; zeigt alle für sie freigegebenen Themen, bei mehreren Projekten mit Projektname.
- Supabase: `themen`, `thema_*`, `themen_projekt`, RPC `thema_ext_laden` (liefert `projekt_id`/`projekt`).
