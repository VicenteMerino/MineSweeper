```bash
███╗   ███╗██╗███╗   ██╗███████╗███████╗██╗    ██╗███████╗███████╗███████╗██████╗ ███████╗██████╗ 
████╗ ████║██║████╗  ██║██╔════╝██╔════╝██║    ██║██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝██╔══██╗
██╔████╔██║██║██╔██╗ ██║█████╗  ███████╗██║ █╗ ██║█████╗  █████╗  █████╗  ██████╔╝█████╗  ██████╔╝
██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ╚════██║██║███╗██║██╔══╝  ██╔══╝  ██╔══╝  ██╔═══╝ ██╔══╝  ██╔══██╗
██║ ╚═╝ ██║██║██║ ╚████║███████╗███████║╚███╔███╔╝███████╗███████╗███████╗██║     ███████╗██║  ██║
╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝ ╚══╝╚══╝ ╚══════╝╚══════╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝
                                                                                                  
```

- Para jugar, primero se tiene que descargar el repositorio completo, clonando el repositoro:
  - `git clone git@github.com:VicenteMerino/ProyectoA-MineSweeper-Grupo6.git` para SSH.
  - `git clone https://github.com/VicenteMerino/ProyectoA-MineSweeper-Grupo6.git` para HTTPS
- Instalar dependencias con ejecutando `bundle install` en la consola desde la carpeta raíz del juego.
- Para iniciar el juego, se debe ejecutar `ruby lib/main.rb` en la consola desde la carpeta raíz del juego.

Para jugar se tiene que introducir en consola las coordenadas de la celda a descubrir en cada turno. El jugador gana si logra descubrir todas las celdas que no contienen bombas. De lo contrario, si un jugador descubre una celda con una comba, pierde. También el jugador puede presionar la tecla `e` para rendirse en cualquier momento. Al rendirse se descubre el tablero para que el jugador conozca donde estaban las bombas.

[Video demo (0:45)](https://www.youtube.com/watch?v=W7YGL6TID7A)
