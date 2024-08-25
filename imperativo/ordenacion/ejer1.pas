program ejer1;
CONST 
	dimF = 6;
type
	ventas = record
		dia, cod, cant: integer;
	end;
	vector = array [1..dimF] of ventas;

procedure cargarV(var vect: vector; var dimL: integer);

	procedure preguntas(var v: ventas);
	begin
		v.dia:= random(32);
		writeln('dia: ', v.dia);
		if(v.dia <> 0)then begin
			v.cod:= random(16) + 1;
			writeln('cod: ', v.cod);
			writeln('ingrese la cantidad vendida: ');
			readln(v.cant);
		end;
	end;
var
	vent: ventas;
begin
	dimL:= 0;
	preguntas(vent);
	while(vent.dia <> 0) and (dimL < dimF)do begin
		dimL := dimL + 1;
		vect[dimL]:= vent;
		preguntas(vent);
	end;
	writeln(dimL);
end;

procedure ordenarV(var v: vector; dimL: integer);

	procedure imprimirV(v: vector; dimL: integer);
	var
		i: integer;
	begin
		for i:= 1 to dimL do begin
			writeln;
			writeln('Cod: ', v[i].cod);
		end;
	end;

var
	i, j, pos: integer; item: ventas;
begin
	for i:= 1 to dimL - 1 do begin
		pos:= i;
		for j:= i + 1 to dimL do
			if(v[j].cod < v[pos].cod)then pos:= j;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item;
	end;
	imprimirV(v, dimL);
end;

procedure incE(var v: vector; dimL: integer);

	function buscarPosInf(v: vector; dimL: integer; valInf: integer):integer;
	var
		pos: integer;
	begin
		pos:= 1;
		while(pos <= dimL) and (valInf > v[pos].cod)do begin
			pos:= pos + 1;
		end;
		if(pos > dimL)then 
			buscarPosInf:= 0
		else
			buscarPosInf:= pos - 1;
	end;
	
	function buscarPosSup(v: vector; dimL, posInf, valorSup: integer): integer;
	begin 
		while(posInf < dimL)and(v[posInf].cod <= valorSup)do begin
			posInf:= posInf + 1;
		end;
		if(posInf > dimL)then 
			buscarPosSup:= dimL
		else
			buscarPosSup:= posInf - 1; 
	end;

var
	valorInf, valorSup, posInf, posSup, i: integer;
begin
	writeln;
	writeln('Ingrese valor inf: '); readln(valorInf);
	writeln('Ingrese valor: sup'); readln(valorSup);
	posInf:= buscarPosInf(v, dimL, valorInf);
	if(posInf <> 0)then begin
		posSup:= buscarPosSup(v, dimL, posInf, valorSup);
		for i:= posSup + 1 to dimL do begin
			v[posInf]:= v[i];
			posInf:= posInf + 1;
		end;
		dimL:= dimL - (posSup - posInf - 1);
	end;
end;

procedure imprimirE(v: vector; dimL: integer);
	var
		i: integer;
	begin
		for i:= 1 to dimL do begin
			writeln;
			writeln(v[i].cod,' ', v[i].dia,' ', v[i].cant);
		end;
	end;

var
	vVentas: vector; 
	dimL: integer;
BEGIN
	Randomize;
	cargarV(vVentas, dimL);
	ordenarV(vVentas, dimL);
	incE(vVentas, dimL);
	imprimirE(vVentas, dimL);
END.
