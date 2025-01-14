import os
import subprocess
import json
from pathlib import Path


def run_command(command):
    """Run a shell command and display its output."""
    try:
        print(f"Running command: {command}")
        result = subprocess.run(command, shell=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(e)
        print(f"Error: {e.stderr}")

def main():
    
    project_name = "{{cookiecutter.product_name}}"
    contract_name = "{{cookiecutter.domain_name}}"

    current_dir = Path(os.getcwd())

    target_dir = current_dir / contract_name

    os.chdir(target_dir)
    print("Project directory: ", os.getcwd())
    run_command("dbt deps --profiles-dir ./")
    print("Do you want to add a source database? (yes/no)")
    add_source = input().strip().lower()

    if add_source != "yes":
        print("No source database to add. Exiting.")
        return

    database_name = input("Enter the database name: ").strip()
    if not database_name:
        print("Database name cannot be empty. Exiting.")
        return

    schema_name = input("Enter the schema name: ").strip()
    if not schema_name:
        print("Schema name cannot be empty. Exiting.")
        return

    print("Enter table names (comma-separated):")
    table_names_input = input().strip()
    table_names = [table.strip() for table in table_names_input.split(",") if table.strip()]
    if not table_names:
        print("No table names provided. Exiting.")
        return

    source_args = {
        "database_name": database_name,
        "schema_name": schema_name,
        "table_names": table_names,
        "include_database": True,
        "include_schema": True,
    }

    print("Running `generate_source` operation...")
    run_command(f"dbt --quiet run-operation generate_source --args '{json.dumps(source_args)}' --profiles-dir ./ > ./models/staging/source.yml")

    for table_name in table_names:
        base_model_args = {
            "source_name": f"{schema_name.lower()}",
            "table_name": table_name.lower(),
        }
        print(f"Running `generate_base_model` for table: {table_name}...")
        run_command(f"dbt --quiet run-operation generate_base_model --args '{json.dumps(base_model_args)}' --profiles-dir ./ > ./models/staging/{schema_name}_{table_name}.sql")

    print("All operations completed successfully.")

if __name__ == "__main__":
    main()
