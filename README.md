# BetterRest: Introducción

Este proyecto SwiftUI es otra aplicación basada en formularios que le pedirá al usuario que ingrese información y la convertirá en una alerta.

El motivo es estudiar una de las características verdaderamente poderosas del desarrollo de iOS: el aprendizaje automático (ML).

Todos los iPhones vienen con una tecnología llamada Core ML integrada, que nos permite escribir código que hace predicciones sobre nuevos datos en función de los datos anteriores que ha visto. Comenzaremos con algunos datos sin procesar, se los daremos a nuestra Mac como datos de entrenamiento y luego usaremos los resultados para crear una aplicación capaz de hacer estimaciones precisas sobre nuevos datos, todo en el dispositivo y con total privacidad para los usuarios.

La aplicación que estamos desarrollando se llama BetterRest y está diseñada para ayudar a los bebedores de café a dormir bien por la noche haciéndoles tres preguntas:

- ¿Cuando quieren despertar?
- ¿Aproximadamente cuántas horas de sueño quieren?
- ¿Cuántas tazas de café beben al día?

Una vez que tengamos esos tres valores, los introduciremos en Core ML para obtener un resultado que nos indique cuándo deben irse a dormir. Si lo piensas, hay miles de millones de respuestas posibles: todas las horas de vigilia multiplicadas por todas las horas de sueño, multiplicadas nuevamente por el rango completo de cantidades de café.

![image](https://github.com/user-attachments/assets/7679943b-8029-4dc1-9335-5da5cd4fea8c)


# Desafío
Una de las mejores formas de aprender es escribir tu propio código con la mayor frecuencia posible, por lo que aquí tienes tres formas en las que deberías intentar ampliar esta aplicación para asegurarte de que entiendes completamente lo que está sucediendo:

- Reemplaza cada ``VStack`` con una ``Section``, donde la vista de texto sea el título de la sección. ¿Prefieres este diseño o el diseño con VStack? ¡Es tu aplicación, tú eliges!
- Reemplaza el stepper de "Número de tazas" con un ``Picker`` que muestre el mismo rango de valores.
- Cambia la interfaz de usuario para que siempre muestre la hora de acostarse recomendada con una fuente bonita y grande. Deberías poder eliminar por completo el botón "Calcular".

![image](https://github.com/user-attachments/assets/81244b87-2713-4fce-8c85-f821da9a94ff)
