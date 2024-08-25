{
Una librería requiere el procesamiento de la información de sus productos. De cada producto
se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:

a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados
por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza cuando se
lee el precio 0.

b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.

c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.

d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
métodos vistos en la teoría.

e. Muestre los precios del vector resultante del punto d).

f. Calcule el promedio de los precios del vector resultante del punto d).
}

program ej4;
CONST
	dimF = 8;
	dimF2 = 30;
type
	producto = record
		cod, codR: integer;
		precio: real;
	end;
	
	lista = ^nodo;
	nodo = record
		dat: producto;
		sig: lista;
	end;
	
	vector = array[1..dimF] of lista;
	
	vector3 = array[1..dimF2]of producto;
	
procedure insertarOrd(var pri: lista; p: producto);
var
	act, ant, nue: lista;
begin
	new(nue);
	nue^.dat:= p;
	nue^.sig:= nil;
	if(pri = nil)then
		pri:= nue
	else begin
		act:= pri;
		ant:= pri;
		while(act <> nil) and (act^.dat.cod < p.cod)do begin
			ant:= act;
			act:= act^.sig;
		end;
		if(ant = act)then begin
			nue^.sig:= pri;
			pri:= nue;
		end
		else begin
			ant^.sig:= nue;
			nue^.sig:= act;
		end;
	end;
end;

procedure cargarInfo(var v: vector);

	procedure preguntas(var p: producto);
	begin
		writeln('cod: '); readln(p.cod);
		writeln('cod rubro: '); readln(p.codR);
		writeln('precio: '); readln(p.precio);
	end;
var
	p: producto;
begin
	preguntas(p);
	while(p.precio <> 0)do begin
		insertarOrd(v[p.codR], p);
		preguntas(p);
	end;
end;

procedure mostrarCods(v: vector);
var
	i: integer;
	act: lista;
begin
	for i:= 1 to dimF do begin
		act:= v[i];
		writeln('Rubro: ', i, ' codigos: ');
		while(act <> nil)do begin
			write(act^.dat.cod,', ');
			act:= act^.sig;
		end;
	end;
end;

procedure incC(var v3: vector3; l: lista; var dimL: integer);
begin
	dimL:= 0;
	while(l<>nil)and(dimL < dimF2)do begin
		dimL:= dimL + 1;
		v3[dimL]:= l^.dat;
		l:= l^.sig;
	end;
end;

procedure incD(var v3: vector3; dimL: integer);

	procedure imprimir(v: vector3);
	var
		i: integer;
	begin
		for i:= 1 to dimF2 do begin
			writeln('precio: ', v[i].precio:0:2);
		end;
	end;
var
	i, j: integer;
	act: producto;
begin
	for i:= 2 to dimL do begin
		act:= v3[i];
		j:= i - 1;
		while(j > 0)and(v3[j].precio > act.precio)do begin
			v3[j + 1]:= v3[j];
			j:= j - 1;
		end;
		v3[j + 1]:= act;
	end;
	imprimir(v3);
end;

VAR
	v: vector;
	v3: vector3;
	dimL: integer;
BEGIN
	cargarInfo(v);
	mostrarCods(v);
	incC(v3, v[3], dimL);
	incD(v3, dimL);
END.

