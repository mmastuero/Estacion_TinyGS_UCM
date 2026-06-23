% =========================================================================
% Análisis de Rendimiento de Estación TinyGS
% Autor: Mario Más 
% =========================================================================

clear; clc; close all;

%% 1. Importar los datos de la hoja de calculo
filename = 'Paquetes UCM_Station 15_2_26_a_29_3_26.xlsx';

datos = readtable(filename, 'PreserveVariableNames', true);

% La variable de tiempo se llama serverTimeISO
datos.Timestamp = datetime(datos.serverTimeISO, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSS''Z''', 'TimeZone', 'UTC');
fechas_sin_hora = dateshift(datos.Timestamp, 'start', 'day');
%% 2. Extración de los datos de interés

% Extraer RSSI, SNR, CRC y día
rssi_ant1 = str2double(datos.rssi);
snr_ant1  = str2double(datos.snr);
crc_correcto= strcmpi(datos.crc_error,'false');

[conteo_diario, dias_unicos] = groupcounts(fechas_sin_hora);%groupcounts agrupa y cuenta cuántos paquetes se reciben cada día

rssi_filtrado = rssi_ant1(crc_correcto);
snr_filtrado  = snr_ant1(crc_correcto);

paquetes_validos = sum(crc_correcto);
porcentaje_error = (sum(~crc_correcto) / length(crc_correcto)) * 100;

%% 3. Mostrar métricas por consola
fprintf('--- Resultados del Análisis ---\n');
fprintf('Antena 1: %d paquetes recibidos.\n', length(rssi_ant1));
fprintf('  Paquetes sin error de CRC: %d de %d\n', paquetes_validos, length(crc_correcto));
fprintf('  Tasa de Error de Paquetes (PER): %.2f%%\n', porcentaje_error);
fprintf('  RSSI Medio: %.2f dBm | SNR Medio: %.2f dB | RSSI Medio Filtrado: %.2f dBm | SNR Medio Filtrado: %.2f dB \n', mean(rssi_ant1,'omitnan'), mean(snr_ant1,'omitnan'), mean(rssi_filtrado,'omitnan'), mean(snr_filtrado,'omitnan'));
fprintf('  Días activos de recepción: %d días\n', length(dias_unicos));
fprintf('  Media de paquetes diarios: %.0f paquetes/día\n', mean(conteo_diario));
fprintf('  Día con más tráfico: %s (%d paquetes)\n\n', datestr(dias_unicos(conteo_diario == max(conteo_diario))), max(conteo_diario));