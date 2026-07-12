
## Environment setup

run in a simple python venv:

```
python3.13 -m venv venv
source venv/bin/activate

pip install dbt-core==1.11.11 dbt-bigquery==1.11.3

```

## Initial data

Uploaded the raw data to bigQuery, then used it as a source. 

## Let's go

Build, run, test, or create documentation:
```
dbt build
```