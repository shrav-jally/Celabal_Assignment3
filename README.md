# ShopEase E-Commerce Sales Database Analysis

An analytical data engineering repository built to analyze sales execution, consumer shopping habits, and baseline performance details for ShopEase across regional Indian state divisions.

## 📊 Relational Schema Overview

The storage framework uses 4 key relational entities:
*   **`customers`**: User profile registry details with localized identity mappings.
*   **`products`**: Product catalog listing tier costs and tracking metrics[cite: 1].
*   **`orders`**: Summary headers for operational order transactions[cite: 1].
*   **`order_items`**: Line item level transactional breakdowns[cite: 1].

## 🚀 Deployment Instructions

### Prerequisites
*   MySQL Server (v8.0+) or any standard SQL-compatible RDBMS engine[cite: 1].

### Quick Start
1. Clone this repository to your local directory:
   `git clone https://github.com/shrav-jally/ShopEase-Sales-Analysis.git`
2. Import the `Sample - Superstore.csv` dataset into your SQL environment[cite: 1].
3. Run the normalization script provided in `analytical_queries.sql` to generate the relational schema[cite: 1].

## 🧪 Analytical Methodology

This repository utilizes advanced SQL to derive business insights through[cite: 2]:
*   **Data Normalization**: `SELECT DISTINCT` was utilized to enforce relational integrity and eliminate redundancy[cite: 2].
*   **Advanced Querying**:
    *   **CTEs**: Implemented to break down complex aggregations, improving code readability and modularity[cite: 2].
    *   **Window Functions**: Applied `RANK()` and `ROW_NUMBER()` to analyze performance metrics within specific partitions, preserving row-level detail[cite: 2].
    *   **Subqueries**: Employed for non-correlated filtering to ensure dynamic execution against global dataset averages[cite: 2].

## 📂 Repository Contents
*   `analytical_queries.sql`: The complete SQL script containing all analytical logic, including CTEs, Subqueries, and Window Functions[cite: 1, 2].
*   `ce3.pdf`: Official assignment requirements and objectives[cite: 2].
