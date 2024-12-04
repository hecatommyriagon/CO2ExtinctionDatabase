from flask import Flask, render_template, request
import query_db

app = Flask(__name__)

# Initialize global variables to store user input
user_year = None
user_country = None
data = [(" ", " ", " ", " ", " ", " ", " ")]

@app.route("/", methods=["GET", "POST"])
def index():
    global user_year, user_country, data  # Declare 'data' as global
    if request.method == "POST":
        # Save the user input to global variables
        user_year = request.form.get("year")
        user_country = request.form.get("country")

        # Query and update the global data variable
        data = query_db.query_table(user_country, user_year)
    return render_template(
        "index.html",
        year=user_year,
        country=user_country,
        co2=str(data[0][2]),
        gdp=str(data[0][3]),
        life=str(data[0][4]),
        mort=str(data[0][5]),
    )

if __name__ == "__main__":
    app.run(debug=True)
