with conn.cursor() as cur:
    cur.execute("""SELECT f.aircraft_code, AVG(f.actual_arrival - f.actual_departure) as average_flight_duration
                   FROM flights AS f
                   GROUP BY f.aircraft_code
                   ORDER BY average_flight_duration DESC
                   LIMIT 3""")
    print(DF(cur.fetchall()))
