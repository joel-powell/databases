def reset_tables
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "localhost", dbname: "social_network_test" })
  connection.exec(seed_sql)
end
