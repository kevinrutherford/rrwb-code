Feature: Report time
  Reporting time using the timelog application

  Background:
    Given I create a new timelog database
    And I run timelog -u fred -h 6 proj1
    And I run timelog -u jim -h 7 proj1
    And I run timelog -u alice -h 4.5 proj1

  Scenario: project total
    When I run timelog proj1
    Then a total of 17.5 hours are reported

  Scenario: project_total_for_missing_project
    When I run timelog proj2
    Then a total of 0 hours are reported

  Scenario: user_total
    When I run timelog --user fred proj1
    Then a total of 6 hours are reported

  Scenario: user_total_for_missing_user
    When I run timelog --user harry proj1
    Then a total of 0 hours are reported

  Scenario: user_total_for_missing_project
    When I run timelog --user fred proj2
    Then a total of 0 hours are reported
