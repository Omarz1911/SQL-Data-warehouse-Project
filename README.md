# SQL Data Warehouse Project

## Overview

This project implements a data warehouse using Microsoft SQL Server, following a layered architecture to prepare data for analytical reporting.

This project was completed as a hands-on learning project guided by the SQL Data Warehouse from Scratch tutorial by Data with Baraa.

## Architecture

The data warehouse consists of three layers:

- **Bronze:** Stores raw source data.
- **Silver:** Cleans and transforms the data.
- **Gold:** Organizes curated data for analytical use through fact tables, dimension tables, and views.

## Technologies

- Microsoft SQL Server
- SQL
- SQL Server Management Studio (SSMS)

## Project Structure

- `Datasets/` — Source datasets, where redistribution is permitted.
- `Scripts/Bronze/` — Bronze-layer scripts.
- `Scripts/Silver/` — Silver-layer scripts.
- `Scripts/Gold/` — Gold-layer scripts.
- `docs/` — Architecture diagrams and project documentation.

## Key Concepts

- ETL processes
- Data cleaning and transformation
- Data warehouse modeling
- Fact and dimension tables
- Star schema

## Acknowledgment

Educational reference: Data with Baraa — SQL Data Warehouse from Scratch.

Original tutorial: https://www.youtube.com/watch?v=9GVqKuTVANE

## How to Run

1. Install Microsoft SQL Server and SQL Server Management Studio.
2. Download or clone this repository.
3. Review the source data and database setup scripts.
4. Execute the SQL scripts in the correct order: Bronze, Silver, then Gold.
5. Verify the results using the provided queries.
