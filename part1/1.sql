with conn.cursor() as cur:
    cur.execute("""SELECT AVG(empty_seats) as empty_seats FROM (
        SELECT (count(s.seat_no) - (SELECT count(seat_no) FROM Boarding_passes AS bp WHERE bp.flight_id=f.flight_id)) AS empty_seats
        FROM Flights AS f
        INNER JOIN Seats AS s ON f.aircraft_code = s.aircraft_code
        GROUP BY f.flight_id
    ) as name""")
    print(DF(cur.fetchall()))
