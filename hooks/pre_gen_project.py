import os
import subprocess
import sys

def set_env_variable(var_name, value):
    """Set an environment variable and ensure it's available for subprocesses."""
    os.environ[var_name] = value
    # Export the variable for the shell session
    subprocess.run(f'export {var_name}="{value}"', shell=True, check=True)

def check_and_set_environment_variables():
    """Check if required environment variables are set, and set them if missing."""
    required_vars = ["SNF_USER", "SNF_PASSWORD"]

    for var in required_vars:
        if not os.environ.get(var):
            print(f"Error: Environment variable {var} is not set.")
            value = input(f"Please enter a value for {var}: ").strip()

            while not value:
                print(f"{var} cannot be empty. Please enter a valid value.")
                value = input(f"Please enter a value for {var}: ").strip()

            set_env_variable(var, value)
            print(f"Environment variable {var} is now set.")

def main():
    try:
        check_and_set_environment_variables()
        print("All required environment variables are set. Proceeding with project generation...")
    except subprocess.CalledProcessError as e:
        print(f"Failed to export environment variables: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
