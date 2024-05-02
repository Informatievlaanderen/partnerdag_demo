-- Table: public.telraam

-- DROP TABLE IF EXISTS public.telraam;


CREATE TABLE IF NOT EXISTS public.telraam
(
sensor text,
object text,
telling double precision,
tijd text,
wegsegment text;
geoemtry geometry(geometry, 4326)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.telraam OWNER to ldes;

-- Step 2: Create a function that will convert WKT to geometry and update the geom column
CREATE OR REPLACE FUNCTION update_geometry()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.geom := ST_GeomFromText(NEW.wkt_string, 4326); -- Assuming SRID 4326, adjust if necessary
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

-- Step 3: Create a trigger that calls the function before inserting or updating the table row
CREATE TRIGGER trig_update_geom
BEFORE INSERT OR UPDATE ON spatial_data
FOR EACH ROW EXECUTE FUNCTION update_geometry();