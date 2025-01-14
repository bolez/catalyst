{% raw %}
{% macro create_share(share_name, object_name) %}

    CREATE SHARE IF NOT EXISTS {{ share_name }} SECURE_OBJECTS_ONLY=FALSE;
    GRANT USAGE ON DATABASE {{var('domain_database')}} TO SHARE {{ share_name }};
    GRANT USAGE ON SCHEMA {{var('schema')}} TO SHARE {{share_name}};

{% endmacro %}
{% endraw %}

