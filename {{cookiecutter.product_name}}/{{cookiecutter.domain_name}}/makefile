profile_dir =  --profiles-dir ./
debug:
	dbt debug $(profile_dir)

run:
	dbt run $(profile_dir)

build:
	dbt build $(profile_dir)

test:
	dbt test $(profile_dir)

clean:
	dbt clean $(profile_dir)

docs:
	dbt docs generate $(profile_dir)
	dbt docs serve $(profile_dir)

