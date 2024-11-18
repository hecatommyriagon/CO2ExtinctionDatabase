import psycopg2
import getpass
import csv

'''
Uploads a file to the postgres database
'''

filename = "data/actual_data_sample.csv"

def read_file(file_path):
    """
    Reads data from a semicolon-separated file and parses it into a list of tuples.

    Args:
        file_path (str): The path to the file containing the data.

    Returns:
        list of tuples: Parsed data.
    """
    data = []
    with open(file_path, 'r') as file:
        for line in file:
            fields = line.strip().split(';')
            if len(fields) != 6:
                print(f"Skipping malformed line: {line}")
                continue
            
            country = fields[0]
            year = int(fields[1])
            co2_pcap = float(fields[2]) if fields[2].lower() != 'null' else None
            gdp_pcap = float(fields[3]) if fields[3].lower() != 'null' else None
            life_expectancy = float(fields[4]) if fields[4].lower() != 'null' else None
            child_mortality = float(fields[5]) if fields[5].lower() != 'null' else None
            
            data.append((country, year, co2_pcap, gdp_pcap, life_expectancy, child_mortality))
    return data

def main():

    # Connect to PostgreSQL db
    conn = psycopg2.connect(
        host = "codd.mines.edu",
        database = "csci403",
        user = input("User: "),
        password =getpass.getpass("Password: "),
        port=5433
    )
    cursor = conn.cursor()

    data = read_file(filename)

    print("First 10 entries of data: ")
    for i in range(min(10, len(data))):
        print(data[i])

    insert_query = """
    INSERT INTO data (country, year, co2_pcap, gdp_pcap, life_expectancy, child_mortality)
    VALUES (%s, %s, %s, %s, %s, %s)
    """

    cursor.executemany(insert_query, data)
    conn.commit()

    print(f"{cursor.rowcount} rows inserted successfully.")

if __name__ == '__main__':
    main()
