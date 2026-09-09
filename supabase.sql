-- Prüfungsrouten Hattingen – Supabase Setup
-- Einmal im Supabase SQL Editor ausführen.

create table if not exists public.exam_points (
  id text primary key,
  name text not null,
  query text,
  lat double precision not null,
  lon double precision not null,
  cat text not null default 'mixed',
  task text,
  verified boolean not null default false,
  amb boolean not null default true,
  updated_at timestamptz not null default now()
);

alter table public.exam_points enable row level security;

-- Öffentliche App: Lesen + Bearbeiten der Kartenpunkte.
-- Hinweis: Damit kann grundsätzlich jeder Besucher der öffentlichen Seite Punkte ändern.
-- Für einen späteren Admin-Login können die Schreib-Policies auf authenticated beschränkt werden.
drop policy if exists "Public read exam points" on public.exam_points;
create policy "Public read exam points" on public.exam_points
for select to anon, authenticated
using (true);

drop policy if exists "Public insert exam points" on public.exam_points;
create policy "Public insert exam points" on public.exam_points
for insert to anon, authenticated
with check (true);

drop policy if exists "Public update exam points" on public.exam_points;
create policy "Public update exam points" on public.exam_points
for update to anon, authenticated
using (true)
with check (true);

insert into public.exam_points (id,name,query,lat,lon,cat,task,verified,amb) values
('tuev','TÜV Hattingen','An der Becke 17, 45527 Hattingen',51.40155,7.22065,'start','Prüfungsstart/-ende; Zufahrt oben/unten',true,false),
('holthausen','Holthausen','Holthausen, Hattingen',51.3922,7.2178,'long','von oben / von unten',false,true),
('hol_sack','Holthausen Sackgasse','Holthausen, Hattingen',51.3914,7.2155,'basic','Umkehren / Sackgasse',false,true),
('hol_vb','Holthausen VB','Holthausen, Hattingen',51.3930,7.2140,'residential','Verkehrsberuhigter Bereich',false,true),
('welper','Welper','Welper, Hattingen',51.4121,7.2064,'long','Stadt ↔ Fahrschule / Schule',false,true),
('wel_sack','Welper Sackgasse','Welper, Hattingen',51.4140,7.2070,'basic','Umkehren / Sackgasse',false,true),
('wel_hoch','Welper Hochhaus','Welper, Hattingen',51.4115,7.2072,'residential','kleine / große Runde',false,true),
('hellweg','Hellweg','Hellweg, Hattingen',51.3992,7.2107,'priority','bergauf / bergab',false,true),
('blank','Blankenstein','Blankenstein, Hattingen',51.4062,7.2295,'long','Ortsdurchfahrt',false,true),
('blank_kh','Blankenstein KH Sackgasse','Krankenhaus Blankenstein Hattingen',51.4058,7.2257,'basic','Sackgasse / Umkehren',false,true),
('blank_vb','Blankenstein VB','Blankenstein, Hattingen',51.4050,7.2305,'residential','Verkehrsberuhigter Bereich',false,true),
('sprock','Sprockhövel','Sprockhövel',51.3682,7.2485,'long','Prüfgebiet / Verbindung',false,true),
('quer','Querspange Richtung Haßlinghausen','Hattingen Richtung Hasslinghausen',51.3790,7.2310,'long','Richtung Haßlinghausen',false,true),
('oster','Osterhöfgen','Osterhöfgen, Hattingen',51.3885,7.2010,'priority','Stoppschild / Prüfpunkt',false,true),
('glueck','Glückaufhalle','Glückaufhalle Hattingen',51.3940,7.1900,'basic','Grundfahraufgaben',false,true),
('sport','Sportplatz','Sportplatz Hattingen',51.3932,7.1940,'basic','Grundfahraufgaben / Umkehren',false,true),
('sued','Südstadt','Südstadt Hattingen',51.3890,7.1810,'residential','Wohngebiet',false,true),
('altefw','Alte Feuerwehr links','Feuerwehr Hattingen',51.3990,7.1820,'priority','links',false,true),
('bus_vb','Busbahnhof VB','Busbahnhof Hattingen Mitte',51.4002,7.1814,'residential','VB / Innenstadt',false,true),
('neuefw','Neue Feuerwehr','Feuerwehr Hattingen',51.3943,7.1762,'long','Prüfpunkt',false,true),
('gruen','Grünstraße','Grünstraße, Hattingen',51.3980,7.1830,'priority','Straßenbeobachtung',false,true),
('nord','Nordstraße','Nordstraße, Hattingen',51.4030,7.1840,'priority','KH Richtung Harzer / andersrum',false,true),
('ober','Oberwinzerfeld','Oberwinzerfeld, Hattingen',51.3865,7.1740,'residential','Stop / Einbahnstraße / Wohngebiet',false,true),
('harzer','Harzer','Harzer Weg Hattingen',51.3925,7.1760,'priority','Richtung Avantgarde / andersrum',false,true),
('tal','Talstraße','Talstraße, Hattingen',51.3970,7.1910,'priority','von oben / von unten; Stop',false,true),
('bhf','Bahnhofstraße','Bahnhofstraße, Hattingen',51.3979,7.1770,'priority','Innenstadt / Einbahnstraße',false,true),
('mc','Gegenüber McDonald’s links','McDonalds Hattingen',51.3970,7.1870,'priority','Linksabbiegen',false,true),
('salz','Salzweg','Salzweg, Hattingen',51.3920,7.1665,'residential','Wohngebiet',false,true),
('besch_blank','Beschleunigungsstreifen → Blankenstein','Hattingen Blankenstein',51.4045,7.2115,'long','Beschleunigungsstreifen',false,true),
('besch_hat','Beschleunigungsstreifen → Hattingen','Hattingen',51.4038,7.2095,'long','Beschleunigungsstreifen',false,true),
('pol','Polizei links','Polizei Hattingen',51.3985,7.1818,'priority','Linksabbiegen',false,true),
('avant','Avantgarde Hotel','Welperstraße 49, 45525 Hattingen',51.4050,7.1955,'priority','Richtung Kreis / andersrum; Sackgasse; Ampel; Stop / Einbahnstraße',true,false),
('rvl','Rechts vor links','Hattingen',51.3900,7.1800,'residential','Rechts-vor-links Schwerpunkt',false,true),
('rvl_netto','Rechts vor links Netto','Netto Hattingen',51.3970,7.1940,'residential','Rechts vor links',false,true),
('dier','Diergardt','Diergardtstraße Hattingen',51.4030,7.2010,'priority','Stoppschild',false,true),
('stolle','Stolle Stop','Stolle Hattingen',51.3950,7.2040,'priority','Stoppschild',false,true),
('aldi','Aldi Einbahnstraße','Aldi Hattingen',51.3990,7.1775,'priority','Einbahnstraße',false,true),
('markt','Marktplatz','Marktplatz Hattingen',51.3983,7.1810,'priority','Einbahnstraße kleine / große Runde',false,true),
('tanz','Tanzschule','Tanzschule Hattingen',51.3990,7.1840,'priority','Einbahnstraße',false,true),
('hirsch','Hirschberger','Hirschberger Straße Hattingen',51.3905,7.1810,'priority','Einbahnstraße',false,true),
('park','Parklücke','Hattingen',51.3950,7.1850,'basic','Längs einparken',false,true),
('boxv','Parkbox vorwärts','Hattingen',51.3960,7.1860,'basic','Vorwärts einparken',false,true),
('boxr','Parkbox rückwärts','Hattingen',51.3965,7.1865,'basic','Rückwärts einparken',false,true),
('turn','Umkehren','Hattingen',51.3940,7.1830,'basic','Umkehren',false,true),
('brake','Gefahrbremsung','Hattingen',51.3920,7.1900,'basic','Gefahrbremsung',false,true)
on conflict (id) do nothing;

create or replace function public.set_exam_points_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists exam_points_updated_at on public.exam_points;
create trigger exam_points_updated_at
before update on public.exam_points
for each row execute function public.set_exam_points_updated_at();
