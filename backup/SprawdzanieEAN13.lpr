program SprawdzanieEAN13;
uses
SysUtils;

var
EAN13 : array [0..12] of Integer;
poprawnosc : boolean = false;
ciagEAN13 : string;

numery : array [0 .. 126] of Integer = (
0, 10, 11, 12, 13, 2, 30, 31, 32, 33, 34, 35, 36, 37, 380, 383, 385, 387, 40,
41, 42, 43, 44, 45, 46, 470, 471, 474, 475, 476, 477, 478, 479, 480, 481,
482, 484, 485, 486, 487, 489, 49, 50, 520, 528, 529, 531, 535, 539, 54, 560,
569, 57, 590, 594, 599, 600, 601, 608, 609, 611, 613, 619, 621, 622, 624,
625, 626, 627, 628, 629, 64, 690, 691, 692, 70, 729, 73, 740, 741, 742, 743,
744, 745, 746, 750, 759, 760, 770, 773, 775, 777, 779, 780, 784, 786, 789,
790, 80, 81, 82, 83, 84, 850, 858, 859, 860, 867, 869, 87, 880, 885, 888, 890,
893, 899, 90, 91, 93, 94, 950, 955, 977, 978, 979, 98, 99 );

kraje : array [0 .. 126] of String = (
'USA i Kanada', 'USA i Kanada', 'USA i Kanada', 'USA i Kanada', 'USA i Kanada',
'Do użytku wewnętrznego', 'Francja', 'Francja', 'Francja', 'Francja',
'Francja', 'Francja', 'Francja', 'Francja', 'Bułgaria', 'Słowenia',
'Chorwacja', 'Bośnia-Hercegowina', 'Niemcy', 'Niemcy', 'Niemcy', 'Niemcy',
'Niemcy', 'Japonia', 'Rosja', 'Kirgistan', 'Tajwan', 'Estonia', 'Łotwa',
'Azerbejdżan', 'Litwa', 'Uzbekistan', 'Sri Lanka', 'Filipiny', 'Białoruś',
'Ukraina', 'Mołdawia', 'Armenia', 'Gruzja', 'Kazachstan', 'Hong Kong',
'Japonia', 'Wielka Brytania', 'Grecja', 'Liban', 'Cypr', 'Macedonia', 'Malta',
'Irlandia', '540-Belgia i Luksemburg', 'Portugalia', 'Islandia', 'Dania',
'Polska', 'Rumunia', 'Węgry', 'RPA', 'RPA', 'Bahrain', 'Mauritius', 'Maroko',
'Algeria', 'Tunezja', 'Syria', 'Egipt', 'Libia', 'Jordania', 'Iran', 'Kuwejt',
'Arabia Saudyjska', 'Emiraty Arabskie', 'Finlandia', 'Chiny', 'Chiny',
'Chiny', 'Norwegia', 'Izrael', '730-Szwecja', 'Gwatemala', 'Salwador',
'Honduras', 'Nikaragua', 'Kostaryka', 'Panama', 'Dominikana', 'Meksyk',
'Wenezuela', 'Szwajcaria', 'Kolumbia', 'Urugwaj', 'Peru', 'Boliwia',
'Argentyna', 'Chile', 'Paragwaj', 'Ekwador', 'Brazylia', 'Brazylia', 'Włochy',
'Włochy', 'Włochy', 'Włochy', 'Hiszpania', 'Kuba', 'Słowacja', 'Czechy',
'Jugosławia', 'Korea Północna', 'Turcja', '870-Holandia', 'Korea Południowa',
'Tajlandia', 'Singapur', 'Indie', 'Wietnam', 'Indonezja', 'Austria',
'Austria', 'Australia', 'Nowa Zelandia', 'EAN - IDA', 'Malezja', 'ISSN',
'ISBN', 'ISMN', 'Kupony', 'Kupony' );


function sprawdzenieSumyKontrolnej(): boolean;
var
suma: Integer;
begin

suma := 1 * EAN13[0] +
3 * EAN13[1] +
1 * EAN13[2] +
3 * EAN13[3] +
1 * EAN13[4] +
3 * EAN13[5] +
1 * EAN13[6] +
3 * EAN13[7] +
1 * EAN13[8] +
3 * EAN13[9] +
1 * EAN13[10] +
3 * EAN13[11];

suma := suma mod 10;
suma := 10 - suma;
suma := suma mod 10;

if suma = EAN13[12] then
result := true
else
result := false;

end;

function zwrocKraj(): String;
var
kod, i, j : Integer;
begin
result := 'nieznany';
kod := 0;

for i := 0 to 2 do
begin
kod := kod * 10;
kod := kod + EAN13[i];

for j := 0 to 126 do
if numery[j] = kod then
begin
result := kraje[j];
break;
end;

if result <> 'nieznany' then
break;
end;
end;

procedure sprawdzanieEAN13(numerEAN13: String);
var
i : integer;
begin

if (length(numerEAN13) <> 13) then
poprawnosc := false
else
begin
for i := 0 to 12 do
EAN13[i] := strToInt(numerEAN13[i+1]);

if sprawdzenieSumyKontrolnej() then
poprawnosc := true
else
poprawnosc := false;
end;
end;


begin
writeln('Nie uzywaj spacji i myslnikow!');
write('Wprowadz EAN13: ');
readln(ciagEAN13);

sprawdzanieEAN13(ciagEAN13);

writeln;
if poprawnosc then
begin
writeln('Numer EAN13 jest prawidłowy');
writeln('Kraj pochodzenia ' + zwrocKraj());

end
else
begin
writeln('Numer EAN13 jest nieprawidłowy');
end;
readln;
end.

