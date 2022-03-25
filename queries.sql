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

SELECT species, AVG(escape_attempts) AS avg_escapes  FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;
