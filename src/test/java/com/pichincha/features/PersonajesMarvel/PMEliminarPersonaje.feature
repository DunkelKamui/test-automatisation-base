@REQ_HU-1 @EliminarPersonajesMarvel @agente1
Feature: Eliminar Personajes Marvel

  @id:8 @eliminarPersonajes
  Scenario: T-API-HU-1-CA8 - Eliminar Personaje Marvel
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters'
    And def body = read('classpath:../data/PersonajesMarvel/PMEliminacion.json')
    And request body
    When method POST
    Then status 201
    * print response
    * def personajeId = response.id
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/' + personajeId
    When method DELETE
    Then status 204

  @id:9 @eliminarPersonajeInexistente
  Scenario: T-API-HU-1-CA8 - Eliminar Personaje Marvel
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/daecifue/api/characters/999999'
    When method DELETE
    Then status 404
    * print response
    * match response.error == 'Character not found'