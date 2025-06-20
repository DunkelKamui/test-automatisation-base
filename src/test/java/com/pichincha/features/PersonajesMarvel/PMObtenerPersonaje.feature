@REQ_HU-1 @ObtenerPersonajesMarvel @agente1
Feature: Obtener Personajes Marvel

  @id:6 @obtenerPersonajes
  Scenario: T-API-HU-1-CA6 - Obtener todos los personajes Marvel
    * header content-type = 'application/json'
    * def personajes = read('classpath:../data/PersonajesMarvel/PMObtencion.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And def body = personajes[0]
    And request body
    When method POST
    Then status 201
    * print response
    * def personajeId1 = response.id
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And def body = personajes[1]
    And request body
    When method POST
    Then status 201
    * print response
    * def personajeId2 = response.id
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    When method GET
    Then status 200
    * assert response.length > 0

    #Teardown
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId1
    When method DELETE
    Then status 204
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId2
    When method DELETE
    Then status 204

  @id:7 @obtenerPersonajePorId
  Scenario: T-API-HU-1-CA7 - Obtener un personaje por Id
    * header content-type = 'application/json'
    * def personajes = read('classpath:../data/PersonajesMarvel/PMObtencion.json')
    * def body = personajes[2]
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And request body
    When method POST
    Then status 201
    * print response
    * def personajeId3 = response.id
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId3
    When method GET
    Then status 200
    * match response.name == body.name

    #Teardown
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId3
    When method DELETE
    Then status 204

  @id:8 @obtenerPersonajeNoExistente
  Scenario: T-API-HU-1-CA8 - Obtener Personaje Marvel No Existente
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/999999'
    When method GET
    Then status 404
    * print response
    * match response.error == 'Character not found'