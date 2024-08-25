{- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se
ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura finaliza
cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.

HICE ESTE PROCEDIMIENTO PARA PROBAR LOS INCISOS.
procedure imprimir(v: vector; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		writeln('cod: ', v[i].cod);
	end;
end;
}

program ej2;
CONST
	dimF = 5;
type
	oficina = record
		cod, dni, valorExp: integer;
	end;
	vector = array [1..dimF] of oficina;

procedure cargarV(var v: vector; var dimL: integer);

	procedure preguntas(var o: oficina);
	begin
		writeln('cod: '); readln(o.cod);
		writeln('dni: '); readln(o.dni);
		writeln('valor expensa: '); readln(o.valorExp);
	end;
var
	o: oficina;
begin
	dimL:= 0;
	preguntas(o);
	while(dimL < dimF)and(o.cod <> - 1)do begin
		dimL:= dimL + 1;
		v[dimL]:= o;
		preguntas(o);
	end;
end;

procedure insercion(var v: vector; dimL: integer);

var
	i, j: integer; actual: oficina;
begin
	for i:= 2 to dimL do begin
		actual:= v[i];
		j:= i - 1;
		while(j > 0)and(v[j].cod > actual.cod)do begin
			v[j + 1] := v[j];
			j:= j - 1;
		end;
		v[j + 1]:= actual;
	end;
end;

procedure seleccion(var v: vector; dimL: integer);

var
	i, pos, j: integer; item: oficina;
begin
	for i:= 1 to dimL - 1 do begin
		pos:= i;
		for j:= i + 1 to dimL do
			if(v[j].cod < v[pos].cod)then pos:= j;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item;
	end;
end;

VAR
	dimL: integer; v: vector;
BEGIN
	cargarV(v, dimL);
	insercion(v, dimL);
	seleccion(v, dimL);
END.

