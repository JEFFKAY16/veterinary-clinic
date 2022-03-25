/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
('Charmander.','2020-02-08',0,false,'-11'),
('Plantmon','2022-11-15',2,true,'-5.7'),
('Squirtle', '1993-04-02',3,true, '-12.13'),
('Angemon', '2005-06-12', 1, true, '-45'),
('Boarmon', '2005-06-07', 7, true, '20.4'),
('Blossom', '1998-10-13', 3, true, '17');

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
('Agumon','2020-02-03',0,true,'10.23'),
('Gabumon','2018-11-15',2,true,'8'),
('Pikachu', '2021-01-07',1,false, '15.04'),
('Devimon', '2017-05-12', 5, true, '11');

ALTER TABLE animals ADD species varchar(255) NULL;

/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
('Charmander','2020-02-08',0,false,'-11'),
('Plantmon','2022-11-15',2,true,'-5.7'),
('Squirtle', '1993-04-02',3,true, '-12.13'),
('Angemon', '2005-06-12', 1, true, '-45'),
('Boarmon', '2005-06-07', 7, true, '20.4'),
('Blossom', '1998-10-13', 3, true, '17');

INSERT INTO owners (full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

UPDATE animals SET species_id = s.id FROM (SELECT id FROM species WHERE name LIKE 'Digimon') s WHERE name LIKE '%mon';

UPDATE animals SET species_id = s.id FROM (SELECT id FROM species WHERE name LIKE 'Pokemon') s WHERE name NOT LIKE '%mon';

UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Sam Smith') o WHERE name = 'Agumon';
UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Bob') o WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') o WHERE name IN ('Pikachu', 'Gabumon');
UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Melody Pond') o WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Dean Winchester') o WHERE name IN ('Angemon', 'Boarmon');


SELECT a.name AS animal, o.full_name AS owner FROM animals a LEFT JOIN owners o ON a.owners_id = o.id WHERE o.full_name = 'Melody Pond';

SELECT a.name AS animal, s.name AS belongs_to FROM animals a LEFT JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

SELECT o.full_name AS owner, a.name AS animal FROM animals a RIGHT JOIN owners o ON a.owners_id = o.id;

SELECT s.name AS specie, COUNT(a.*) AS total FROM animals a LEFT JOIN species s ON a.species_id = s.id GROUP BY s.name;

SELECT o.full_name AS owner, a.name AS animal, s.name AS specie FROM animals a RIGHT JOIN species s  ON s.id = a.species_id RIGHT JOIN owners o ON a.owners_id = o.id WHERE s.name LIKE 'Digimon';

SELECT a.name AS animal, o.full_name AS owned_by FROM animals a JOIN owners o ON a.owners_id = o.id WHERE o.full_name LIKE 'Dean Winchester' AND a.escape_attempts <= 0;

SELECT o.full_name AS owner, COUNT(a.*) AS total_animals FROM animals a RIGHT JOIN owners o ON a.owners_id = o.id GROUP BY o.full_name ORDER BY total_animals DESC LIMIT 1;