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

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
('Agumon','2020-02-03',0,true,'10.23'),
('Gabumon','2018-11-15',2,true,'8'),
('Pikachu', '2021-01-07',1,false, '15.04'),
('Devimon', '2017-05-12', 5, true, '11');

ALTER TABLE animals ADD species varchar(255) NULL;