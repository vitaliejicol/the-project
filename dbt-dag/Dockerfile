FROM astrocrpublic.azurecr.io/runtime:3.1-13

RUN python3 -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip3 install --no-cache-dir dbt-snowflake && deactivate