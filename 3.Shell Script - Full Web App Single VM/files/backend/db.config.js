module.exports = {
  HOST: "localhost",
  USER: "backend",
  PASSWORD: "P@ssw0rd",
  DB: "backend",
  dialect: "mysql",
  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000
  }
};
