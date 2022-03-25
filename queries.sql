/*Queries that provide answers to the questions from all projects.
 COMMENTS ARE RESULTS RUN on data inserted form schema only.
*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE CAST(to_char(date_of_birth, 'YYYY') AS INTEGER) BETWEEN 2016 AND 2019;

SELECT name FROM animals WHERE  neutered IS TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name LIKE 'Agumon' OR name LIKE 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered IS TRUE;

SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Transactions
BEGIN;

UPDATE animals SET species =' unspecified';


SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SELECT * FROM animals;

SAVEPOINT sp1;

UPDATE animals SET weight_kg = (weight_kg * -1);

SELECT * FROM animals;

ROLLBACK TO sp1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

SELECT * FROM animals;

-- How many animals are there
SELECT COUNT(*) total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) as never_escpaed FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) as average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name, MAX(escape_attempts) as max FROM animals GROUP BY neutered, name ORDER BY max DESC LIMIT 1;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg) as max_weigth, MIN(weight_kg) AS min_weight FROM animals GROUP by species;

SELECT species, AVG(escape_attempts) FROM animals
GROUP BY species
WHERE  date_of_birth >= '1990/01/01' AND date_of_birth <= '2000/31/12';

-- Write queries with join

SELECT a.name AS animal, o.full_name AS owner FROM animals a LEFT JOIN owners o ON a.owners_id = o.id WHERE o.full_name = 'Melody Pond';

SELECT a.name AS animal, s.name AS belongs_to FROM animals a LEFT JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

SELECT o.full_name AS owner, a.name AS animal FROM animals a RIGHT JOIN owners o ON a.owners_id = o.id;

SELECT s.name AS specie, COUNT(a.*) AS total FROM animals a LEFT JOIN species s ON a.species_id = s.id GROUP BY s.name;

SELECT o.full_name AS owner, a.name AS animal, s.name AS specie FROM animals a RIGHT JOIN species s  ON s.id = a.species_id RIGHT JOIN owners o ON a.owners_id = o.id WHERE s.name LIKE 'Digimon';

SELECT a.name AS animal, o.full_name AS owned_by FROM animals a JOIN owners o ON a.owners_id = o.id WHERE o.full_name LIKE 'Dean Winchester' AND a.escape_attempts <= 0;

SELECT o.full_name AS owner, COUNT(a.*) AS total_animals FROM animals a RIGHT JOIN owners o ON a.owners_id = o.id GROUP BY o.full_name ORDER BY total_animals DESC LIMIT 1;


-- next

--Who was the last animal seen by William Tatcher?
SELECT vets.name, animals.name, date_visited FROM vets JOIN visits ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id WHERE vets.name ='William Tatcher' ORDER BY visits.date_visited DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(*) as total_animals from vets JOIN visits ON vets.id = visits.vet_id WHERE name='Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT 
	vets.name,
	species.name as specialization
from vets
LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN  species ON specializations.species_id = species.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name ,date_visited from animals 
JOIN visits ON animals.id= visits.animal_id JOIN vets ON vets.id=visits.vet_id
 WHERE vets.name= 'Stephanie Mendez' AND visits.date_visited BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name, COUNT(*) as total_visit from animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY total_visit DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, date_visited FROM vets JOIN visits ON vets.id=visits.vet_id
JOIN animals ON animals.id= visits.animal_id WHERE vets.name ='Maisy Smith' ORDER BY visits.date_visited ASC LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT
	date_visited,
	animals.date_of_birth as animal_dob,
	animals.escape_attempts,
	animals.neutered,
	animals.weight_kg as animal_weight,
	vets.name as vet_name,
	vets.age as vet_age,
	vets.date_of_graduation
from visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY date_visited DESC
LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
JOIN specializations ON specializations.vets_id = visits.vet_id
WHERE animals.species_id != specializations.species_id;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name as specialization , COUNT(visits.animal_id) from visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY species.name DESC 
LIMIT 1;
