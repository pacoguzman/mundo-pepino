Característica: implementación de pasos habituales
  Para escribir sólo la definición de los pasos específicos de mi proyecto
  Como usuario de Cucumber
  Quiero tener definidos e implementados los pasos más habituales

  Escenario: huerto con tres bancales
    Dado que hay un huerto "Hortalizas"
       Y que dicho huerto tiene tres bancales "Acelgas, Tomates y Pepinos"
       Y que dichos bancales tienen como longitud "2" metros
       Y que el bancal "Acelgas" tiene como matas "7"
       Y que dicho bancal tiene las siguientes acelgas:
         | nombre | peso | longitud |
         |      A |   30 |      115 |
         |      B |   23 |       35 |
         |      C |   41 |      135 |
         |      D |   91 |      215 |
         |      E |   65 |      145 |
         |      F |   83 |      195 |
         |      G |   49 |      155 |
       Y que dichas acelgas tienen como variedad "Gigante carmesí"
       Y que el bancal "Tomates" tiene como matas "2"
       Y que dicho bancal tiene cuatro tomates "A, B, C y D"
       Y que el tomate "A" tiene como variedad "Raf"
       Y que dicho tomate tiene como diámetro "97" milímetros
       Y que el tomate "B" tiene como variedad "Ramo"
       Y que dicho tomate tiene como diámetro "43" milímetros
    Entonces existe un huerto
           Y 7 acelgas
	   Y 4 tomates
	   Y el huerto "Hortalizas" tiene un bancal "Acelgas"
           Y el bancal "Acelgas" tiene una acelga "F"
           Y la acelga "F" tiene como peso "83"
	   Y como variedad "Gigante carmesí"
           Y el bancal "Tomates" tiene un tomate "A"
	   Y el tomate "A" tiene como variedad "Raf"
	   Y el tomate "A" tiene como diámetro "97"