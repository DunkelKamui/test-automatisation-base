@REQ_HU-1 @CrearPersonajesMarvel @agente1
Feature: Crear Personaje Marvel

  @id:1 @crearPersonaje
  Scenario: T-API-HU-1-CA1- Crear Personaje Marvel
    * header content-type = 'application/json'
    * def body = read('classpath:../data/PersonajesMarvel/PMCreacion.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And request body
    When method POST
    Then status 201
    * print response
    * def personajeId = response.id
    * match response.name == body.name
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId
    When method DELETE
    Then status 204

  @id:2 @crearPersonajeDuplicado
  Scenario: T-API-HU-1-CA2- Crear Personaje Marvel Duplicado
    * header content-type = 'application/json'
    * def personajes = read('classpath:../data/PersonajesMarvel/PMCreacionDuplicado.json')
    * def body1 = personajes[0]
    * def body2 = personajes[1]
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And request body1
    When method POST
    Then status 201
    * print response
    * def personajeId = response.id

    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And request body2
    When method POST
    Then status 400
    * print response
    * match response.error == 'Character name already exists'

    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId
    When method DELETE
    Then status 204

  @id:3 @crearPersonajeSinCamposRequeridos
  Scenario: T-API-HU-1-CA3- Crear Personaje Marvel con Datos Faltantes
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And def body = read('classpath:../data/PersonajesMarvel/PMCreacionIncompleto.json')
    And request body
    When method POST
    Then status 400
    * match response ==
      """
      {
        "name": "Name is required",
        "description": "Description is required",
        "powers": "Powers are required",
        "alterego": "Alterego is required"
      }
      """
