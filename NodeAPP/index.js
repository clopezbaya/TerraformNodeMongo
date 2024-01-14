const express = require('express')
const { MongoClient } = require('mongodb')

const username = 'christian-unir'
const password = 'unir12345'
const host = '172.31.2.28'
const port = '27017'
const database = 'test'

// Cadena de conexión a MongoDB (URI)
const uri = `mongodb://${username}:${password}@${host}:${port}/${database}`
let stringMongoConection

// Verificacion conexion a MongoDB
async function checkMongoDBConnection() {
  try {
    const client = new MongoClient(uri)
    await client.connect()
    console.log('Conexión exitosa a MongoDB')
    stringMongoConection = `Mongo Conectado correctamente a: ${uri}`
    await client.close()
  } catch (error) {
    console.error('Error al conectar a MongoDB:', error)
    stringMongoConection = `Error al conectar a MongoDB: ${error}`
  }
}
checkMongoDBConnection()

// Crea una instancia de la aplicación Express
const app = express()

// Configura una ruta básica
app.get('/', (req, res) => {
  res.send(
    '|| Hola, mundo!. Soy Christian Lopez Baya ||           \n' +
      `||${stringMongoConection}||`
  )
})

// Escucha en el puerto 3000
const puerto = 3000
app.listen(puerto, () => {
  console.log(`El servidor está escuchando en el puerto ${puerto}`)
})
