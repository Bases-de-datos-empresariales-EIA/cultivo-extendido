-- 0. Realizar un analisis exploratorio de datos

select * from cultivo_extendido.m_cultivo mc 

select * from cultivo_extendido.finca f 

select 
f.nombre,
l.nombre 
from cultivo_extendido.finca f 
	join cultivo_extendido.lote l 
		on l.id_finca  = f.id
order by f.nombre asc, l.nombre asc

select * from m_cultivo c
	join precio p 
		on p.id_cultivo  = c.id

select count(*) from recogida r 

select count(*) from despacho d
	
-- 1. Encontrar cultivos cuyo promedio de precios haya sido superior a un dolar en el 2023:

select 
c.nombre,
avg(p.valor)
from m_cultivo c
	join precio p 
		on p.id_cultivo = c.id
where extract( year from p.fecha ) = 2023
group by c.nombre 
having avg(p.valor)>1

-- 2. Listar las fincas que han tenido más de 10 lotes cultivados:
select 
f.nombre,
count(l.id)
from finca f
	join lote l
		on l.id_finca  = f.id
group by f.nombre
having count(l.id) > 10

-- 3. Identificar los usuarios que han recogido más de 1000 unidades en total:
select
u.nombre,
sum(r.cantidad)
from recogida r
	join usuario u
		on r.id_usuario = u.id
group by u.nombre
having sum(r.cantidad) > 1000

-- 4. Determinar los meses en los cuales la cantidad despachada superó 8000000 de unidades:
select 
extract(year from d.fecha), 
extract(month from d.fecha),
sum(r.cantidad)
from despacho d 
	join recogida r
		on r.id_despacho = d.id
group by extract(year from d.fecha), extract(month from d.fecha)
having sum(r.cantidad)>8000000

-- 5. Calcular los lotes que tuvieron un ingreso proyectado mayor a 100 millones en el 2023. 
-- El ingreso proyectado se calcula como el precio multiplicado por la cantidad de producto recogido.
select 
f.nombre,
l.nombre,
sum(r.cantidad * p.valor) as ingreso_proyectado
from recogida r
	join lote l 
		on r.id_lote = l.id
	join finca f
		on l.id_finca = f.id
	join m_cultivo c
		on l.id_cultivo = c.id
	join precio p
		on p.id_cultivo = c.id
group by f.nombre, l.nombre 
having sum(r.cantidad * p.valor) > 100000000


-- 6. Listar todas las fincas que han bajaron su producción en más de 20% entre el 2022 y el 2023


-- 7. Obtener el promedio de recolecciones por lote y listar aquellos lotes que superan el 
-- promedio general del cultivo de ese lote
-- Primero, necesitas calcular el promedio general de las recolecciones. 
-- Usa un join entre las tablas lote y recogida para obtener esta información. Una vez tengas 
-- el promedio general, procede a calcular el promedio de recolecciones por cada lote individualmente, 
--usando las mismas tablas. 
-- Finalmente, compara el promedio de cada lote con el promedio general y selecciona 
-- los lotes cuyo promedio supera el general. Este proceso puede ser facilitado utilizando
-- subconsultas o una CTE para mantener el promedio general 
-- accesible durante la comparación


-- 8. Calcular el incremento en facturación por cada mes entre el 2022 y el 2023.
-- Para calcular el incremento en facturación por cada mes entre los años 2022 y 2023 
-- utilizando Common Table Expressions (CTEs), primero debes estructurar dos CTEs separadas, 
-- una para cada año. Cada CTE deberá agrupar las facturas por mes y sumar el total de facturación
-- de cada mes. Luego, una vez que tienes estas dos tablas temporales de resultados para 2022 y 
-- 2023, debes hacer un join usando el mes como llave. Esto te permitirá tener los totales de 
-- facturación lado a lado para cada mes de ambos años en una única consulta. 
-- El siguiente paso es calcular la diferencia entre los dos totales para cada mes, 
-- lo que te dará el incremento o decremento en la facturación mes a mes.

-- 9. Calcular el incremento en cantidad de despachos por cada mes entre el 2022 y el 2023.
-- Para calcular el incremento en cantidad de despachos por cada mes entre los años 2022 y 2023 
-- utilizando Common Table Expressions (CTEs), primero debes estructurar dos CTEs separadas, 
-- una para cada año. Cada CTE deberá agrupar la cantidad de despachos por mes y año.
-- Luego, una vez que tienes estas dos tablas temporales de resultados para 2022 y 
-- 2023, debes hacer un join usando el mes como llave. Esto te permitirá tener los totales de 
-- cantidad de despacho lado a lado para cada mes de ambos años en una única consulta. 
-- El siguiente paso es calcular la diferencia entre los dos totales para cada mes, 
-- lo que te dará el incremento o decremento en la facturación mes a mes.


-- 10. Calcular el aumento porcentual anual en el total de recogidas por cultivo entre dos años consecutivos, 
-- comparando específicamente las cantidades recolectadas en 2022 y 2023.


-- 11. Comparar la eficiencia de las fincas en términos de ingreso por hectárea. 

-- El ingreso se calcula como la cantidad recogida multiplicado por el precio del cultivo en el mes que se dio la recogida.
-- El tamaño de la finca se puede calcular asumiendo que cada lote mide 4 hectáreas.
-- Para realizar un análisis detallado de la eficiencia de las fincas en términos de ingreso por hectárea, comienza creando una vista que 
-- determine el tamaño total de cada finca sumando el número de lotes y multiplicando por 4, ya que cada lote tiene 4 hectáreas. 
-- Posteriormente, desarrolla una vista para capturar los precios mensuales de cada cultivo, asegurando que los ingresos se calculen 
-- utilizando el precio correspondiente al mes de cada recogida. Utiliza esta vista de precios en una tercera vista que calcula el ingreso 
-- por lote, multiplicando la cantidad recolectada en cada recogida por el precio del cultivo en el mes correspondiente. Realiza un join entre la 
-- vista del tamaño de las fincas y la vista de ingresos por lote para combinar el tamaño de cada finca con los ingresos obtenidos de sus lotes, 
-- sumando los ingresos de todos los lotes que pertenecen a cada finca. Finalmente, calcula el indicador de ingreso por hectárea dividiendo el total de 
-- ingresos de cada finca por su tamaño total en hectáreas.
