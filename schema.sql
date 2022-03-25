/* Database schema to keep the structure of entire database. */
-- \c vet_clinic

CREATE TABLE animals (
    id INT  PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,   
    weight_kg DECIMAL
);

/* Next */

DROP TABLE IF EXISTS owners;

CREATE TABLE owners(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(255),
    age INT

);

DROP TABLE IF EXISTS species;
CREATE TABLE species(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255)
);

ALTER TABLE animals DROP species;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD CONSTRAINT species_id FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD  owners_id INT;
ALTER TABLE animals ADD CONSTRAINT owners_id FOREIGN KEY (owners_id) REFERENCES owners(id);