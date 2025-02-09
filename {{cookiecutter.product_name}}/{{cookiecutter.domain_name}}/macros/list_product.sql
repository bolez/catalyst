{% raw %}

{% macro list_product(object_schema, object_name, share_name) %}
    -- Grant SELECT permission on the table to the share
    GRANT SELECT ON TABLE {{ object_name }} TO SHARE {{ share_name }};

    -- Check if the listing already exists
    {% set existing_listings_query %}
        SHOW LISTINGS LIKE '{{ share_name }}';
    {% endset %}
    {% set existing_listings_result = run_query(existing_listings_query) %}
   
        {% if not existing_listings_result %}
        {% set object_name_str = object_name.render() %}
        {% set table_name = object_name_str.split('.')[-1] %}

        -- Define the SQL for creating the organization listing

        CREATE ORGANIZATION LISTING {{ share_name }}
        SHARE {{ share_name }} AS
        $$
        title : '{{ share_name }}'
        description: "Created using dbt and cookicutter {{ share_name }}"
        organization_profile: INTERNAL
        organization_targets:
          discovery:
              - all_accounts : true
          access:
          - account : 'PQ57060'
            roles: ['ACCOUNTADMIN']
        locations:
          access_regions:
          - name: "ALL"
        auto_fulfillment:
          refresh_type: SUB_DATABASE
          refresh_schedule: '10 MINUTE'
        support_contact: "support@somedomain.com"
        approver_contact: "approver@somedomain.com"
        data_dictionary:
          featured:
            database: "{{ var('domain_database') }}"
            objects:
              - name: "{{ table_name }}"
                schema: "{{ object_schema }}"
                domain: "TABLE"
        usage_examples:
          - title: "Return all {{ object_name }} for the {{ object_name }}"
            description: "Example of how to select {{ object_name }} information"
            query: "select * from {{ object_name }}"
        resources:
          documentation: https://www.example.com/documentation/
        $$;

  {% endif %}
    
{% endmacro %}
{% endraw %}