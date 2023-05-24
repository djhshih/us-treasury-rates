#!/bin/bash
# Download US treasury rates

set -euo pipefail
IFS=$'\n\t'

outdir=data
mkdir -p $outdir

get_treasury() {
	year=$1
	curl -o $outdir/daily-treasury-rates_$year.csv "https://home.treasury.gov/resource-center/data-chart-center/interest-rates/daily-treasury-rates.csv/$year/all?type=daily_treasury_yield_curve&field_tdr_date_value=$year&page&_format=csv"
}

#years=( 2010 2011 2012 )
years=( 2022 2023 )

for year in ${years[@]}; do
	get_treasury $year
done
