# Desplegar la base de datos AMET en Coolify

Este despliegue crea solamente SQL Server y restaura la base `A`. La aplicación AMET permanece como un recurso Dockerfile independiente en Coolify. No se publica el puerto `1433`: ambos recursos se comunican por la misma red privada predefinida de Coolify.

## Ruta rápida

1. Copiar el backup al servidor y ajustar propietario y permisos.
2. Crear en Coolify un recurso Docker Compose desde la rama `prueba-mono` y el archivo `/dockercompose.deploy.yaml`.
3. Configurar las tres variables del recurso y activar **Connect to Predefined Network**.
4. Desplegar la base y confirmar que `amet-mssql` esté saludable y `db-init` termine con código `0`.
5. Conectar el recurso Dockerfile de AMET a la misma red predefinida y configurar su conexión a `amet-mssql,1433`.

## Requisitos previos

- Un servidor Coolify x86_64 con espacio suficiente para la imagen, el backup, la restauración y el crecimiento de la base.
- Acceso SSH mediante el alias local `coolify-adrian` o mediante el puerto `2222`.
- El backup SQL Server disponible localmente.
- La ruta privada del servidor `/srv/amet/backups/20260819_BK_A.bak`.
- Una contraseña nueva y robusta para `sa`, guardada como secreto de Coolify y no en Git.
- Una edición/licencia de SQL Server compatible con el uso previsto. El valor predeterminado es Express.

## Preparar el backup

Con el alias SSH configurado:

```bash
ssh coolify-adrian 'sudo install -d -o 10001 -g 0 -m 750 /srv/amet/backups'
scp 20260819_BK_A.bak coolify-adrian:/tmp/20260819_BK_A.bak
ssh coolify-adrian 'sudo install -o 10001 -g 0 -m 640 /tmp/20260819_BK_A.bak /srv/amet/backups/20260819_BK_A.bak && rm /tmp/20260819_BK_A.bak'
```

Sin alias, sustituir `usuario@servidor` por el destino SSH real:

```bash
ssh -p 2222 usuario@servidor 'sudo install -d -o 10001 -g 0 -m 750 /srv/amet/backups'
scp -P 2222 20260819_BK_A.bak usuario@servidor:/tmp/20260819_BK_A.bak
ssh -p 2222 usuario@servidor 'sudo install -o 10001 -g 0 -m 640 /tmp/20260819_BK_A.bak /srv/amet/backups/20260819_BK_A.bak && rm /tmp/20260819_BK_A.bak'
```

El archivo final debe pertenecer al UID `10001`, grupo `0`, con modo `640`. No colocar claves privadas, contraseñas ni el backup dentro del repositorio.

## Crear el recurso Docker Compose

1. Abrir el proyecto y el entorno correspondientes en Coolify.
2. Seleccionar **New Resource** y luego **Docker Compose** desde un repositorio Git.
3. Elegir el repositorio de AMET.
4. Establecer la rama en `prueba-mono`.
5. Mantener el directorio base en `/`.
6. Establecer la ruta del archivo Compose en `/dockercompose.deploy.yaml`.
7. Guardar la configuración sin desplegar todavía.
8. En la configuración de red del recurso, activar **Connect to Predefined Network**.
9. Configurar las variables indicadas en la siguiente tabla.
10. Desplegar y revisar primero los estados y logs de ambos servicios.

No se declara ni se codifica un nombre de red en el archivo Compose. Coolify administra sus redes y, de forma predeterminada, aísla cada recurso. La opción **Connect to Predefined Network** debe estar activa tanto en este recurso como en el recurso Dockerfile de AMET. El contenedor de base es singleton y usa el nombre privado estable `amet-mssql`; no debe existir otro contenedor con ese nombre en el mismo servidor.

## Variables de la base

| Variable | Valor | Tratamiento |
| --- | --- | --- |
| `MSSQL_SA_PASSWORD` | Contraseña robusta de `sa` | Marcar como secreto. No registrar ni mostrar el valor. |
| `MSSQL_PID` | `Express` si no se define | Elegir `Express`, `Developer`, `Standard`, `Enterprise` u otro valor admitido solo si corresponde a la licencia y al entorno. `Developer` no permite uso productivo. |
| `DB_BACKUP_PATH` | `/srv/amet/backups/20260819_BK_A.bak` | Ruta absoluta existente en el host de Coolify. |

El backup se monta en modo de solo lectura. Los datos restaurados se guardan en el volumen nombrado de Docker, no en el archivo `.bak`.

## Conectar la aplicación

En el recurso Dockerfile independiente de AMET:

1. Activar **Connect to Predefined Network**, igual que en el recurso de base.
2. Configurar estas variables:

| Variable | Valor inicial |
| --- | --- |
| `DB_SERVER` | `amet-mssql,1433` |
| `DB_NAME` | `A` |
| `DB_USER` | `sa` |
| `DB_PASSWORD` | El mismo secreto configurado en `MSSQL_SA_PASSWORD` |

El usuario `sa` permite la puesta en marcha inicial. Después de validar el acceso, crear un login dedicado para la aplicación con los permisos mínimos necesarios, cambiar `DB_USER` y `DB_PASSWORD`, y conservar `sa` solo para administración.

## Primera restauración

El resultado esperado es:

- `amet-mssql`: estado **running/healthy**.
- `db-init`: estado **exited/completed** con código `0`. Es un trabajo de una sola ejecución, no un servicio permanente.
- Logs de `db-init`: mensaje de restauración y progreso, seguido de finalización correcta.
- Base `A`: disponible en SQL Server.
- Puerto `1433`: accesible solo dentro de las redes Docker conectadas, sin puerto público del host.

`db-init` espera a que SQL Server acepte una consulta real antes de ejecutar `docker/restore.sql`. La primera ejecución restaura `A` desde `/var/opt/mssql/backup/AMET.bak`.

## Redespliegues

La restauración es idempotente: si la base `A` ya existe, `docker/restore.sql` muestra que se omite la restauración y termina correctamente. Un redespliegue normal debe conservar el volumen y los datos.

Antes y después de cada cambio relevante:

- [ ] Confirmar que el volumen de `amet-mssql` sigue adjunto.
- [ ] Confirmar que el backup existe, es legible por UID `10001`/grupo `0` y mantiene modo `640`.
- [ ] Generar o validar un backup reciente antes de migraciones.
- [ ] Probar periódicamente la restauración en un entorno aislado.
- [ ] Revisar los logs de SQL Server y `db-init` sin copiar secretos.
- [ ] Confirmar que no existe una publicación del puerto `1433` en el host.

## Solución de problemas

### La contraseña es rechazada

SQL Server exige complejidad para `MSSQL_SA_PASSWORD`. Usar una contraseña suficientemente larga que combine mayúsculas, minúsculas, números y símbolos. Actualizar el secreto en ambos recursos sin mostrarlo en logs ni comandos.

### SQL Server permanece unhealthy

Revisar los logs de `amet-mssql` en Coolify. Confirmar arquitectura x86_64, aceptación de EULA, licencia seleccionada, complejidad de la contraseña, memoria y disco disponibles. Confirmar también que ninguna instancia previa ocupa el nombre de contenedor `amet-mssql`.

### db-init no termina correctamente

Revisar sus logs y confirmar que `amet-mssql` está saludable, que `DB_BACKUP_PATH` apunta al archivo correcto y que el bind mount es legible. Un error de nombres lógicos del backup requiere comparar el backup con los nombres usados en `docker/restore.sql`; no borrar la base ni el volumen como primer intento.

### La aplicación no conecta

Confirmar que ambos recursos tienen **Connect to Predefined Network** activo y que `DB_SERVER` es `amet-mssql,1433`. Redesplegar una revisión que incluya el arreglo permanente de autenticación y verificar que `db.config` exista como `root:www-data` con modo `640`. Confirmar también que los proveedores predeterminados de membresía, roles y perfiles usen la conexión `AMETConnection` a la base `A`; no aplicar parches manuales dentro del contenedor.

## Rollback

1. Detener o revertir solamente el recurso Dockerfile de AMET si el fallo está en la aplicación.
2. Si el fallo está en una nueva revisión del Compose, volver a desplegar la revisión anterior de `dockercompose.deploy.yaml` conservando el mismo volumen.
3. Si se requiere recuperar datos, detener escrituras, conservar el volumen actual, tomar un backup y restaurar una copia validada mediante un procedimiento de recuperación controlado.
4. Verificar salud, logs y acceso privado antes de reactivar la aplicación.

**No eliminar el volumen de la base de datos durante un rollback o redespliegue.** Eliminar el recurso con la opción de borrar volúmenes, ejecutar `docker compose down -v` o retirar manualmente el volumen puede destruir la única copia activa de los datos.
