import psycopg2
from psycopg2 import sql

TABLE_NAME = "data"

# Function to query the database
def query_table(country, year):
    try:
        # Connect to the PostgreSQL database
        connection = psycopg2.connect(
            host = "codd.mines.edu",
            database = "csci403",
            user = input("User: "),
            password =getpass.getpass("Password: "),
            port=5433
        )
        cursor = connection.cursor()
        
        # Safely construct and execute the query
        query = sql.SQL(f"""SELECT * FROM {TABLE_NAME} WHERE country = '{country}' AND year = '{year}'; """)
        cursor.execute(query)
        
        # Fetch all rows
        rows = cursor.fetchall()
        
        # Print column names and rows
        column_names = [desc[0] for desc in cursor.description]
        print("Columns:", column_names)
        for row in rows:
            print(row)

        # data"Country: " + str(row[0]) + "\n Year: " + str(row[1]) + "\n CO2 Per Capita: " + str(row[2]) + "\n GDP Per Capita " + str(row[3]) + "\n Avg. Life Expectancy: " + str(row[4]) + "\n Child Mortalities per 1000: " + str(row[5])
    
    except psycopg2.Error as e:
        print("Database error:", e)
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

        print(f"Query script returning {rows}")
        return rows
