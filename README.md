# TFG: Estudio y Evaluación de una Estación Terrestre TinyGS

Este repositorio contiene el material de programación y los conjuntos de datos recopilados durante el desarrollo del Trabajo de Fin de Grado (TFG) en Ingeniería Electrónica de Comunicaciones. El proyecto se centra en el despliegue, estudio y evaluación de un nodo receptor para la red satelital IoT TinyGS.

## Contenido del Repositorio

El repositorio se compone de los siguientes archivos de análisis de datos y sus correspondientes bases de datos exportadas de la estación:

* **Primer periodo de evaluación:**
    * `Extraccion_datos_periodo1.m`: *Script* de MATLAB encargado del procesado y filtrado de las métricas de recepción.
    * `Paquetes UCM_Station 15_2_26_a_29_3_26.xlsx`: Datos en bruto recopilados por la estación UCM.

* **Periodo final de evaluación:**
    * `Extraccion_datos_periodo_final.m`: *Script* de MATLAB para el procesado del periodo final (cambio de antena y prueba en UCM) 
    * `Paquetes UCM_Station 6_5_26_a_22_6_26.xlsx`: Datos en bruto correspondientes a la segunda fase de pruebas.

## Requisitos previos
Para la correcta ejecución del código, es necesario disponer del software **MATLAB** instalado en el equipo.

## Instrucciones de Ejecución

Para reproducir el procesado de datos y generar las gráficas del proyecto, se deben seguir estos pasos:

1. Clonar o descargar este repositorio en el equipo local.
2. Es **estrictamente necesario** que el *script* de MATLAB (`.m`) y su correspondiente archivo de datos (`.xlsx`) se encuentren ubicados en la **misma carpeta** de trabajo.
    * *Ejemplo:* `Extraccion_datos_periodo1.m` debe ejecutarse en el mismo directorio donde se encuentre `Paquetes UCM_Station 15_2_26_a_29_3_26.xlsx`.
3. Abrir el *script* deseado en MATLAB y ejecutar el código.
