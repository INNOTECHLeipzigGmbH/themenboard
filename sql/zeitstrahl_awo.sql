-- Zeitstrahl für Themenboard (Supabase SQL Editor, Projekt „Protokoll“)
create table if not exists public.thema_zeitstrahl (
  id uuid primary key default gen_random_uuid(),
  thema_id uuid not null references public.themen(id) on delete cascade,
  datum date not null,
  datum_bis date,
  datum_text text,
  wer text,
  quelle text,
  wortlaut text,
  ms_label text,
  ms_unsicher boolean not null default false,
  ms_hervor boolean not null default false,
  pos integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists thema_zeitstrahl_thema_idx on public.thema_zeitstrahl(thema_id);
alter table public.thema_zeitstrahl enable row level security;
drop policy if exists allow_all_thema_zeitstrahl on public.thema_zeitstrahl;
create policy allow_all_thema_zeitstrahl on public.thema_zeitstrahl for all to public using (true) with check (true);

-- Einträge aus der PDF (nur einmal ausführen)
insert into public.thema_zeitstrahl(thema_id, pos, datum, datum_bis, datum_text, wer, quelle, wortlaut, ms_label, ms_unsicher, ms_hervor)
select '236ad782-7bd6-432b-981c-7b9fdbfc92fd'::uuid, x.pos, x.datum::date, x.bis::date, x.dt, x.wer, x.quelle, x.wl, x.ms, x.u, x.h
from (values
  (0,'2026-09-22','2026-10-13',null,$q$BJP an Innotech$q$,$q$Bauprotokoll 42, Nr. 48 (Innotech, KW 40, offen)$q$,$q$„Es ist zu klären wie der Umschluss und der Übergangsbetrieb der Heizzentrale erfolgt."$q$,$q$Heizzentrale: Umschluss offen$q$,false,false),
  (1,'2026-09-29',null,null,$q$BJP an Innotech$q$,$q$Bauprotokoll 43, Nr. 48 (offen)$q$,$q$Gleicher Punkt, Ergänzung: „29.09.26: Die Abstimmung zur Inbetriebnahme erfolgt mit Herr Fränkel."$q$,$q$Abstimmung mit Hr. Fränkel$q$,false,false),
  (2,'2026-10-13',null,null,$q$BJP$q$,$q$Bauprotokoll 45, Nr. 48 (offen; gescannt, OCR)$q$,$q$Weitere Ergänzung: „13.10.26 Herr Fränkel hat auf die Dringlichkeit hingewiesen!"$q$,null,false,false),
  (3,'2026-10-27',null,null,$q$Innotech an BJP$q$,$q$Zuarbeit Nr. 46, Allgemeines (VE 00), Verantwortlich: Sanitär- und Heizungstechnik GmbH (Info)$q$,$q$„Bauheizung eventuell über Fernwaermeleitung". Erste Nennung der Fernwärme-Lösung.$q$,$q$Idee: Fernwärme (Zuarbeit 46)$q$,false,false),
  (4,'2026-10-27',null,null,$q$BJP$q$,$q$Bauprotokoll 47, Nr. 15, VE 5901 Boels (KW 45, Info) und Neue Sachverhalte Nr. 1$q$,$q$„Nachrichtlich: Heizer im WC-Contaier defekt. Angebot zu Bauheizung über Fernwärmenetz einreichen." Neue Sachverhalte (BJP, zeitnah, in Klärung): „Bauheizung in Abstimmung mit Innotech".$q$,null,false,false),
  (5,'2026-10-30',null,$q$30.10.2026, 06:25$q$,$q$Riedel an BJP$q$,$q$Mail „Protokollzuarbeit TGA"$q$,$q$Zuarbeit zum Protokoll (Inhalt zur Bauheizung nicht im Volltext geprüft).$q$,null,false,false),
  (6,'2026-11-02','2026-11-03',$q$02./03.11.2026$q$,$q$ENERENT$q$,$q$Mietangebot (Anhang der Mail vom 19.11.)$q$,$q$Angebot über 2 mobile Heizgeräte mit je 50 kW.$q$,$q$ENERENT: 2 Mietgeräte à 50 kW$q$,true,false),
  (7,'2026-11-03',null,$q$03.11.2026, 11:00$q$,$q$Innotech (Zuarbeit Nr. 47), Termin vor Ort$q$,$q$Zuarbeit Nr. 47, Allgemeines (VE 00); Verantwortlich: Sanitär- und Heizungstechnik GmbH (erledigt), BJP (Info)$q$,$q$Ergänzung (3.11.2026): „Termin mit Bauheizungsfirma vor Ort 11:00 Uhr". BJP: „QM pro Ebene übermitteln". Abstimmungsergebnis: „Beide Etagen können an die Fernwärmeleitung angeschlossen werden. Dazu erforderlich sind folgende Kernbohrungen: 1x KB DN 100 in den AR unrein EG, 1x KB DN 100 in den AR unrein OG, 1x KB DN 100 in die obere Etage. Vorschlag sind zwei Geräte pro Etage in der Mitte, um die Leitungswege kurz zu halten." Sanitärcontainer: „Heizung defekt", Ergänzung (3.11.2026): „Wurde an die Kollegen vor weitergegeben. Rückinfo dazu offen" (BJP).$q$,$q$Vor-Ort-Termin, 11:00$q$,false,false),
  (8,'2026-11-03',null,null,$q$BJP an Innotech$q$,$q$Bauprotokoll 48, Nr. 53 (Innotech, KW 46, offen)$q$,$q$„Prüfung Angebot zur Bauheizung, was wird noch benötigt. Abstimmung mit R+K." Der Boels-Punkt Nr. 15 (Angebot zu Bauheizung über Fernwärmenetz) steht hier auf offen.$q$,null,false,false),
  (9,'2026-11-06',null,$q$06.11.2026, 08:18$q$,$q$Riedel an BJP$q$,$q$Mail „Zuarbeit TGA"$q$,$q$Zuarbeit zur Bauheizung.$q$,null,false,false),
  (10,'2026-11-06',null,$q$06.11.2026, 12:11$q$,$q$BJP an Innotech und R+K$q$,$q$Mail „WG: AW Ihre Online-Anfrage 261102-150209, Angebot ANB036191-1"$q$,$q$BJP leitet ein Angebot zur Bauheizung weiter.$q$,$q$BJP leitet Angebot weiter$q$,false,false),
  (11,'2026-11-09',null,null,$q$BJP$q$,$q$Baubesprechungsprotokoll 48 (Versand)$q$,$q$Protokoll der Besprechung vom 03.11. mit dem Stand der Abstimmung.$q$,null,false,false),
  (12,'2026-11-10',null,null,$q$BJP, R+K, Innotech$q$,$q$Bauprotokoll 49, Nr. 53 (offen); Zuarbeit Nr. 49, Ergänzung (10.11.2026)$q$,$q$Protokoll: „Nachrichtlich: Laut R+K ist das Betreiben der Bauheizung über Fernwärme umsetztbar." Zuarbeit (BJP, KW 46, Aufgabe): „QM pro Ebene übermitteln (Verantw.: BJP). Abstimmungsergebnis: [wie am 03.11.] Eventuell über R+K (Verantw.: R+K). Nachträglich: Geräte werden nicht über R+K geliefert." Boels-Punkt: „Sanitärcontainer: Heizung defekt – Ergänzung 3.11.2026: Wurde an die Kollegen vor weitergegeben. Rückinfo dazu offen (Verantw.: BJP)".$q$,$q$R+K: Fernwärme machbar$q$,false,true),
  (13,'2026-11-16','2026-11-18',$q$16.–18.11.2026$q$,$q$BJP, Innotech, Riedel$q$,$q$Protokoll 49 (16.11.), Bauprotokoll 50 in der TGA-Fassung (17.11.), Mail „TGA Ergänzungen" (18.11., 21:41)$q$,$q$Nr. 53 steht im Protokoll 50 unverändert auf offen, einschließlich des Satzes „Laut R+K … umsetztbar". Der Boels-Punkt Nr. 15 steht dort auf erledigt. Neue Sachverhalte: „Bauheizung in Abstimmung mit Innotech", in Klärung.$q$,null,false,false),
  (14,'2026-11-19',null,$q$19.11.2026, 09:26$q$,$q$Riedel an BJP, cc R+K$q$,$q$Mail „Bauheizung"$q$,$q$Anfrage zur Bauheizung.$q$,null,false,false),
  (15,'2026-11-19',null,$q$19.11.2026, 17:10$q$,$q$Riedel an R+K (Zelle)$q$,$q$Mail „Bauheizung" mit ENERENT-Anhängen$q$,$q$Fragen zu Liefertermin, Schlauchlänge und Kernbohrungen. R+K soll einen Nachtrag erstellen. IBM und Installation sollen über R+K laufen.$q$,$q$Anfragen an R+K, Nachtrag$q$,false,false)
) as x(pos,datum,bis,dt,wer,quelle,wl,ms,u,h)
where not exists (select 1 from public.thema_zeitstrahl where thema_id='236ad782-7bd6-432b-981c-7b9fdbfc92fd');

-- Die zuvor angelegten 16 Verlaufs-Einträge ersetzt der Zeitstrahl
delete from public.thema_verlauf where thema_id='236ad782-7bd6-432b-981c-7b9fdbfc92fd' and quelle in ('Protokoll','Zuarbeit','Mail','Angebot');
insert into public.thema_verlauf(thema_id, datum, quelle, text)
select '236ad782-7bd6-432b-981c-7b9fdbfc92fd', date '2026-11-19', 'Änderung', 'Zeitstrahl mit 16 Einträgen angelegt (Stand 19.11.2026)'
where not exists (select 1 from public.thema_verlauf where thema_id='236ad782-7bd6-432b-981c-7b9fdbfc92fd' and text like 'Zeitstrahl mit 16%');
