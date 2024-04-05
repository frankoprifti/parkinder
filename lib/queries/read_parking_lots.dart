String readParkingLots = """
  query ReadParkingLots(\$limit: Int!, \$offset: Int!) {
   getAllParkingLots(limit: \$limit, offset: \$offset) {
    image,
    id,
    address,
    live_date,
    name,
    size,
    status,
    type
  }
  }
""";
