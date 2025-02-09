import subprocess
import yaml

def run_dbt_generate(model_name):
    """Run dbt operation to generate schema YAML for a specific model."""
    try:
        dbt_command = [
            "dbt", "--quiet", "run-operation", "generate_model_yaml",
            "--args", f'{{"model_names": ["{model_name}"]}}'
        ]
        result = subprocess.run(dbt_command, capture_output=True, text=True, check=True)

        yaml_output = result.stdout.strip()
        parsed_dict = yaml.safe_load(yaml_output)

        # Save to file
        file_name = f"models/marts/contracts/{model_name}.yml"
        with open(file_name, "w") as file:
            yaml.dump(parsed_dict, file, default_flow_style=False)

        print(f"YAML output saved to {file_name}")

    except subprocess.CalledProcessError as e:
        print(f"DBT command failed: {e.stderr}")
    except yaml.YAMLError as e:
        print(f"Error parsing YAML: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")

if __name__ == "__main__":
    model_name = input("Enter the model name: ").strip()
    run_dbt_generate(model_name)
