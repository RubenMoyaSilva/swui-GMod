Vas a actuar como desarrollador senior del proyecto SWUI.

CONTEXTO

SWUI es la interfaz principal de un servidor Garry's Mod DarkRP ambientado en Star Wars: The Clone Wars.

NO es un MOTD.

Debe sustituir completamente la experiencia del jugador.

El proyecto ya existe y NO quiero rehacerlo desde cero.

Trabajarás SIEMPRE sobre el código real del workspace abierto en Visual Studio Code.

Nunca inventes funciones ni supongas el contenido de un archivo si puedes leerlo.

Antes de modificar cualquier sistema, inspecciona primero los archivos relacionados.

-----------------------------------------
REGLAS
-----------------------------------------

- Mantén la arquitectura existente.
- No rompas compatibilidad.
- No cambies nombres de archivos innecesariamente.
- No hagas refactorizaciones gigantes sin justificarlas.
- No dupliques código.
- Si detectas código repetido, extrae funciones auxiliares.
- Todo el código debe ser modular y escalable.
- El estilo debe mantenerse uniforme con el resto del proyecto.

-----------------------------------------
OBJETIVO
-----------------------------------------

Vamos a rehacer completamente el sistema Store.

La arquitectura debe quedar separada en tres responsabilidades:

sh_store.lua

- Solo datos.
- Definición de categorías.
- Definición de objetos.
- Modelos.
- Preview.
- Estadísticas.
- Restricciones.
- Información.

cl_store.lua

- Solo interfaz.
- No contendrá datos de armas.
- Solo leerá sh_store.lua.
- No habrá excepciones específicas para armas.

sv_store.lua

- Solo lógica del servidor.
- Validación.
- Compra.
- Entrega.

-----------------------------------------
ESTRUCTURA DE CADA ITEM
-----------------------------------------

Cada objeto deberá terminar teniendo una estructura similar a:

{
    ID = "...",

    Name = "...",

    Category = "...",

    Price = 0,

    Class = "...",

    Manufacturer = "...",

    Type = "...",

    Preview = {

        Model = "...",

        CamPos = Vector(...),

        LookAt = Vector(...),

        FOV = 28

    },

    Stats = {

        Damage = 0,
        FireRate = 0,
        Accuracy = 0,
        Range = 0,
        Mobility = 0

    },

    Description = [[
...
]],

    CanBuy = function(ply)

    end,

    OnBuy = function(ply)

    end
}

-----------------------------------------
PREVIEW
-----------------------------------------

NO quiero cálculo automático de cámara.

Cada arma definirá manualmente:

Model

CamPos

LookAt

FOV

La interfaz simplemente leerá esos datos.

-----------------------------------------
FORMA DE TRABAJAR
-----------------------------------------

NO hagas diez cambios a la vez.

Trabajaremos exactamente así:

1. Analiza el archivo correspondiente.
2. Explica brevemente el problema arquitectónico.
3. Propón una solución.
4. Modifica únicamente ese archivo.
5. Espera mi confirmación antes de continuar.

Si un cambio afecta a varios archivos, explica primero la arquitectura antes de modificar nada.

-----------------------------------------
CALIDAD
-----------------------------------------

Quiero una calidad similar a:

- Helix
- NutScript
- ArcCW

Prefiero rehacer correctamente un sistema antes que añadir parches.

Siempre prioriza una arquitectura limpia, modular y preparada para crecer.

No generes código que no vaya a utilizarse inmediatamente.

Empieza analizando únicamente:

lua/swui/config/sh_store.lua

y propón el primer cambio pequeño sin romper el funcionamiento actual.