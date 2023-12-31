/*Queries that provide answers to the questions from all projects.*/

SELECT 
* 
from 
animals 
WHERE 
name LIKE '%mon';

SELECT
name
FROM 
animals
 WHERE
 date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

 SELECT
 name
 FROM
 animals
 WHERE
 neutered = true AND escape_attempts < 3;

 SELECT
 date_of_birth
 FROM
 animals
 WHERE
 name IN ('Agumon','Pikachu');

 SELECT
 name,
 escape_attempts
 FROM
 animals
 WHERE
 weight_kg > 10.5;

 SELECT
 *
 FROM
 animals
 WHERE
 neutered = true;

 SELECT
 *
 FROM
 animals
 WHERE
 name <> 'Gabumon';

 SELECT
 *
 FROM
 animals
 WHERE 
 weight_kg >=10.4 AND weight_kg <=17.3;

 -- Begin Transaction
BEGIN;

-- Update the Animals Table
UPDATE animals
SET species = 'unspecified';

-- Verify the Change
SELECT * FROM animals;

-- Rollback the Transaction 
ROLLBACK;

-- Verify Rollback
SELECT * FROM animals;


-- Update animals with names ending in 'mon'
UPDATE 
animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update animals with no species set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Verify the changes before committing
-- You can run SELECT queries to check the changes
SELECT * FROM animals;

-- Commit the transaction
COMMIT;

-- Verify the changes persist after committing
-- Run another SELECT query to check the changes
SELECT * FROM animals;

-- Delete all records in the animals table
DELETE FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify if all records in the animals table still exist
-- Run a SELECT query to check the records
SELECT * FROM animals;

-- Begin transaction
BEGIN TRANSACTION;

-- Delete animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create savepoint
SAVEPOINT my_savepoint;

-- Update all animals' weight to be weight * -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to savepoint
ROLLBACK TO my_savepoint;

-- Update negative weights to positive
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit transaction
COMMIT;

SELECT COUNT(*) AS total_animals
FROM animals;

SELECT COUNT(*) AS non_escape_animals
FROM animals
WHERE escape_attempts = 0;

SELECT
AVG(weight_kg) AS average_weight
FROM
animals;

SELECT neutered, SUM(escape_attempts) AS total_escapes
FROM animals
GROUP BY neutered
ORDER BY total_escapes DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


SELECT name FROM animals A
INNER JOIN owners O
ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

SELECT A.name FROM animals A
INNER JOIN species S
ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT full_name, name FROM owners O
LEFT JOIN animals A
ON A.owner_id = O.id;


SELECT COUNT(*), S.name FROM animals A
INNER JOIN species S
ON A.species_id = S.id
GROUP BY S.name;

SELECT A.name FROM animals A
INNER JOIN species S ON A.species_id = S.id
INNER JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

SELECT name FROM animals A
INNER JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT COUNT(*) as count, full_name FROM animals A
INNER JOIN owners O ON A.owner_id = O.id
GROUP BY O.full_name
ORDER BY count DESC;


-- JOIN tables

SELECT A.name FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
INNER JOIN vets B ON V.vet_id = B.id
WHERE B.name = 'William Tatcher'
ORDER BY V.date_of_visit DESC LIMIT 1;

SELECT COUNT(*) As animals FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
INNER JOIN vets B ON V.vet_id = B.id
WHERE B.name = 'Stephanie Mendez';

SELECT B.name AS vet, S.name AS species FROM specializations C
FULL OUTER JOIN vets B ON C.vets_id = B.id
FULL OUTER JOIN species S ON C.species_id = S.id;

SELECT A.name FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
INNER JOIN vets B ON V.vet_id = B.id
WHERE B.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT A.name FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
GROUP BY A.name
ORDER BY COUNT(date_of_visit) DESC LIMIT 1;


SELECT A.name FROM visits V
INNER JOIN animals A ON V.animal_id = A.id
INNER JOIN vets B ON V.vet_id = B.id
WHERE B.name = 'Maisy Smith'
ORDER BY V.date_of_visit LIMIT 1;

SELECT A.name AS animal, B.name as vet, V.date_of_visit FROM visits V
INNER JOIN animals A ON A.id = V.animal_id
INNER JOIN vets B ON B.id = V.vet_id
ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(*) AS visits FROM visits V
WHERE V.vet_id = (SELECT id FROM vets B
  INNER JOIN specializations C ON B.id != C.vets_id LIMIT 1);


SELECT S.name, COUNT(S.name) AS visits FROM animals A 
INNER JOIN visits V ON A.id = V.animal_id
INNER JOIN vets B ON V.vet_id = B.id
INNER JOIN species S ON A.species_id = S.id
WHERE B.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY visits DESC LIMIT 1;