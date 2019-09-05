USE iris_db;
SELECT 
measurements.sepal_length,
measurements.sepal_width,
measurements.petal_length,
measurements.petal_width,
species.species_name,
species.species_id
 FROM measurements
JOIN species ON(species.species_id=measurements.species_id)