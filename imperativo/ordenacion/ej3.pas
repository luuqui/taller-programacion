{
3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre
de 2022. De cada película se conoce: código de película, código de género (1: acción, 2: aventura,
3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje promedio
otorgado por las críticas.

Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:

a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1. 

b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..

c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.

d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).
}
program ej3;
CONST
	dimF = 8;
type
	pelicula = record
		codP: integer;
		codGen: 1..8;
		puntajeProm: real;
	end;
	
	maximos = record
		codMax: integer;
		puntMax: real;
	end;
	
	listaP = ^nodo;
	nodo = record
		dat: pelicula;
		sig: listaP;
	end;
	
	vector = array [1..dimF] of listaP;
	vectorB = array[1..dimF] of maximos;
procedure agregAt(var l: listaP; p: pelicula);
var
	nue, act, ant: listaP;
begin
	new(nue);
	nue^.dat:= p;
	nue^.sig:=nil;
	if(l = nil)then
		l:= nue
	else begin
		act:= l;
		ant:= l;
		while(act <> nil)do begin
			ant:= act;
			act:= act^.sig;
		end;
		ant^.sig:= nue;
	end;	
end;

procedure cargarL(var v: vector);
	procedure preguntas(var p: pelicula);
	begin
		writeln('codigo p: ');readln(p.codP);
		if(p.codP <> -1)then begin
			writeln('cod g: ');readln(p.codGen);
			writeln('puntaje prom: '); readln(p.puntajeProm);
		end;
	end;
var
	p: pelicula;
begin
	preguntas(p);
	while(p.codP <> -1) do begin
		agregAt(v[p.codGen], p);
		preguntas(p);
	end;
end;

procedure inicializarListas(var vec: vector);
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		vec[i]:= nil;
	end;
end;

procedure inicializarMaximos(var vec: vectorB);
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		vec[i].codMax:= -1;
		vec[i].puntMax:= -1;
	end;
end;

procedure incB(v: vector; var vMax: vectorB);
var
	i: integer;
	act: listaP;
begin
	for i:= 1 to dimF do begin
		act:= v[i];
		while(act <> nil)do begin
			if(act^.dat.puntajeProm > vMax[i].puntMax)then begin
				vMax[i].puntMax := act^.dat.puntajeProm;
				vMax[i].codMax:= act^.dat.codP;
			end;
			act:= act^.sig;
		end;
	end;
end;

procedure incC(var vMax: vectorB);
var
	i, j: integer;
	actual: maximos; 
begin
	for i:= 2 to dimF do begin
		actual:= vMax[i];
		j:= i - 1;
		while(j > 0)and(vMax[j].puntMax > actual.puntMax)do begin
			vMax[j + 1]:= vMax[j];
			j:= j - 1;
		end;
		vMax[j + 1]:= actual;
	end;
end;

procedure incD(vMax: vectorB);
var
	i: integer;
begin
	for i:= dimF downto 1 do begin
		if(i = dimF)then
			writeln('Codigo de pelicula con mayor puntaje: ', vMax[i].codMax);
		if(i = 1)then
			writeln('Codigo de pelicula con menor puntaje: ', vMax[i].codMax);
	end;
end;

VAR
	v: vector;
	vMax: vectorB;
BEGIN
	inicializarListas(v);
	cargarL(v);
	inicializarMaximos(vMax);
	incB(v, vMax);
	incC(vMax);
	incD(vMax);
END.

