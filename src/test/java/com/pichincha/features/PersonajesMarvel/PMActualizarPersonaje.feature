@REQ_HU-1 @ActualizarPersonajesMarvel @agente1
Feature: Actualizar Personaje Marvel

  @id:4 @actualizarPersonaje
  Scenario: T-API-HU-1-CA4- Actualizar Personaje Marvel
    * header content-type = 'application/json'
    * def personajes = read('classpath:../data/PersonajesMarvel/PMActualizacion.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And def body = personajes[0]
    And request body
    When method POST
    Then status 201
    * print response
    * def personajeId = response.id

    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId
    And def body = personajes[1]
    And request body
    When method PUT
    Then status 200
    * print response
    * match response.description == 'Updated description'

    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId
    When method DELETE
    Then status 204

  @id:5 @actualizarPersonajeNoExistente
  Scenario: T-API-HU-1-CA5- Actualizar Personaje Marvel No Existente
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/999999'
    And def body = read('classpath:../data/PersonajesMarvel/PMActualizacionInexistente.json')
    And request body
    When method PUT
    Then status 404
    * print response
    * match response.error == 'Character not found'