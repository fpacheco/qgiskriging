# qgiskriging
Kriging with R in QGis 

Los que trabajamos en el rubro de variables naturales usamos kriging seguido.

Los que trabajamos con QGis sentimos falta un modulo que nos permita interpolar con este método en forma rápida, sin mayores formalismos, a los efectos de ver en forma rápida y gráfica las variaciones espaciales del fenómeno y sin irnos de la interface de QGis.

¿Que es esto?
=============

Los dos archivos R de este directorio (IngesurKriging.rsx y IngesurKriging.rsx.help) funcionan con la caja de herramientas de QGis y permiten hacer kriging automático (se autoestima el semivariograma) a partir de una capa espacial de puntos con un campo numérico.

¿Como se instala?
=================

Manual
------
Copie los dos archivos al directorio $HOME/.qgis2/processing/rscripts
