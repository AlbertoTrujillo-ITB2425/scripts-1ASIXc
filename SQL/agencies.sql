USE agenciaviatges;
-- 1) Nom de les sucursals dels hotels de la ciutat de Barcelona.
SELECT DISTINCT s.nomSuc
FROM sucursal s
JOIN hotel h ON s.CodSuc = h.CodSuc
WHERE h.ciutat = 'Barcelona';

-- 2) Nom i cognoms dels turistes allotjats a l'hotel 'Hotel Gran Via'.
SELECT t.nom, t.cognoms
FROM turista t
JOIN allotjament a ON t.CodTur = a.CodTur
JOIN hotel h ON a.CodHot = h.CodHot
WHERE h.nom = 'Hotel Gran via';

-- 3) Número del vol amb més places totals.
SELECT num_vol
FROM vol
ORDER BY places_tot DESC
LIMIT 1;

-- 4) Nom dels turistes amb més d'un viatge.
SELECT t.nom, t.cognoms
FROM turista t
JOIN viatge v ON t.CodTur = v.CodTur
GROUP BY t.CodTur
HAVING COUNT(v.num_vol) > 1;

-- 5) Nom i cognoms dels turistes sense cap viatge.
SELECT t.nom, t.cognoms
FROM turista t
LEFT JOIN viatge v ON t.CodTur = v.CodTur
WHERE v.num_vol IS NULL;

-- 6) Nombre de turistes allotjats per cada hotel.
SELECT h.nom, COUNT(DISTINCT a.CodTur) AS num_turistes
FROM hotel h
LEFT JOIN allotjament a ON h.CodHot = a.CodHot
GROUP BY h.nom
ORDER BY num_turistes DESC;

-- 7) Nom dels hotels amb més places que la mitjana.
SELECT h.nom
FROM hotel h
WHERE h.num_places > (SELECT AVG(num_places) FROM hotel);

-- 8) Turistes que mai s'han allotjat a l'hotel 'Gran Hotel' de Barcelona.
SELECT t.nom, t.cognoms
FROM turista t
WHERE t.CodTur NOT IN (
    SELECT a.CodTur
    FROM allotjament a
    JOIN hotel h ON a.CodHot = h.CodHot
    WHERE h.nom = 'Gran Hotel' AND h.ciutat = 'Barcelona'
);

-- 9) Nom de la sucursal amb més hotels.
SELECT s.nomSuc
FROM sucursal s
JOIN hotel h ON s.CodSuc = h.CodSuc
GROUP BY s.nomSuc
ORDER BY COUNT(h.CodHot) DESC
LIMIT 1;

-- 10) Nombre total de places dels hotels de la sucursal amb codi 100.
SELECT SUM(h.num_places) AS total_places
FROM hotel h
WHERE h.CodSuc = 100;

-- 11) Sucursal amb més places d'hotel.
SELECT s.nomSuc
FROM sucursal s
JOIN hotel h ON s.CodSuc = h.CodSuc
GROUP BY s.nomSuc
ORDER BY SUM(h.num_places) DESC
LIMIT 1;

-- 12) Turistes allotjats en hotels de la sucursal 'Sants'.
SELECT t.nom, t.cognoms
FROM turista t
JOIN allotjament a ON t.CodTur = a.CodTur
JOIN hotel h ON a.CodHot = h.CodHot
JOIN sucursal s ON h.CodSuc = s.CodSuc
WHERE s.nomSuc = 'Sants';

-- 13) Turistes allotjats més de 5 dies.
SELECT t.nom, t.cognoms
FROM turista t
JOIN allotjament a ON t.CodTur = a.CodTur
WHERE DATEDIFF(a.data_sortida, a.data_ini) > 5;

-- 14) Turistes allotjats a tots els hotels.
SELECT t.nom, t.cognoms
FROM turista t
WHERE NOT EXISTS (
    SELECT h.CodHot
    FROM hotel h
    WHERE NOT EXISTS (
        SELECT a.CodHot
        FROM allotjament a
        WHERE a.CodTur = t.CodTur AND a.CodHot = h.CodHot
    )
);

-- 15) Nom de l'hotel amb més places.
SELECT nom
FROM hotel
WHERE num_places = (select max(num_places) from Hotel);

-- 16) Nombre total de places d'hotel.
SELECT SUM(num_places) FROM hotel;

-- 17) Turistes que no s'han allotjat en cap hotel.
SELECT t.nom, t.cognoms
FROM turista t
WHERE CodTur not in (select codTur from Allotjament);


-- 18) Nombre total d'hotels.
SELECT COUNT(*) FROM hotel;

-- 19) Sucursal del vol amb més places totals.
SELECT distinct s.nomSuc
FROM sucursal s JOIN vol v ON s.CodSuc = v.CodSuc
where v.places_tot = (select max(places_tot) from Vol);


-- 20) Sucursal del vol amb més places de turista.
SELECT distinct s.nomSuc
FROM sucursal s JOIN vol v ON s.CodSuc = v.CodSuc
where v.places_tur = (select max(places_tur) from Vol);

-- 21) Sucursals amb més de dos vols.
SELECT s.nomSuc, count(*)
FROM sucursal s JOIN vol v ON s.CodSuc = v.CodSuc
GROUP BY s.nomSuc
having count(*) > 2;

-- 22) Hotels sense sucursal.
SELECT h.nom, ciutat
FROM hotel h
WHERE h.CodSuc IS NULL;

-- 23) Sucursals sense cap hotel.
SELECT s.nomSuc
FROM sucursal s
WHERE not exists (select *
				from Hotel h
                where s.CodSuc = h.CodSuc);

-- 24) Turistes que han viatjat a París.
SELECT t.nom, t.cognoms
FROM (turista t JOIN viatge v ON t.CodTur = v.CodTur)
	JOIN vol vo ON v.num_vol = vo.num_vol
WHERE vo.desti = 'París';
