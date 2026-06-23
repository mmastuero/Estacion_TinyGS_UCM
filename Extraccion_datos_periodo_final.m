% =========================================================================
% Análisis de Rendimiento de Estación TinyGS
% Autor: Mario Más 
% =========================================================================

clear; clc; close all;

%% 1. Importar los datos de la hoja de calculo

filename = 'Paquetes UCM_Station 6_5_26_a_22_6_26.xlsx';
datos = readtable(filename, 'PreserveVariableNames', true);

datos.Timestamp = datetime(datos.serverTimeISO, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSS''Z''', 'TimeZone', 'UTC');
fechas_sin_hora = dateshift(datos.Timestamp, 'start', 'day');
%% 2. Separar los datos de las dos antenas
% Se instala la estación en la UCM el 17 de junio 
fecha_cambio_antena = datetime(2026, 6, 17, 0, 0, 0,'TimeZone', 'UTC');

% Crear índices lógicos para cada antena
idx_antena1 = datos.Timestamp  < fecha_cambio_antena;
idx_antena2 = datos.Timestamp >= fecha_cambio_antena;

% Extraer RSSI, SNR  y CRC para cada antena
rssi_ant1 = str2double(datos.rssi(idx_antena1));
snr_ant1  = str2double(datos.snr(idx_antena1));
crc_correcto= strcmpi(datos.crc_error,'false');

[conteo_diario1, dias_unicos1] = groupcounts(fechas_sin_hora(idx_antena1));%groupcounts agrupa y cuenta cuántos paquetes se reciben cada día

rssi1_filtrado = rssi_ant1(crc_correcto(idx_antena1));
snr1_filtrado  = snr_ant1(crc_correcto(idx_antena1));

paquetes_validos1 = sum(crc_correcto (idx_antena1));
porcentaje_error1 = (sum(~crc_correcto(idx_antena1)) / length(crc_correcto(idx_antena1))) * 100;
% Antena 2
rssi_ant2 = str2double(datos.rssi(idx_antena2));
snr_ant2  = str2double(datos.snr(idx_antena2));

[conteo_diario2, dias_unicos2] = groupcounts(fechas_sin_hora(idx_antena2));

rssi2_filtrado = rssi_ant2(crc_correcto(idx_antena2));
snr2_filtrado  = snr_ant2(crc_correcto(idx_antena2));

paquetes_validos2 = sum(crc_correcto (idx_antena2));
porcentaje_error2 = (sum(~crc_correcto(idx_antena2)) / length(crc_correcto(idx_antena2))) * 100;
%% 3. Mostrar métricas por consola (Para tablas del TFG)
fprintf('--- Resultados del Análisis ---\n');
fprintf('Antena 1: %d paquetes recibidos.\n', length(rssi_ant1));
fprintf('  Paquetes sin error de CRC: %d de %d\n', paquetes_validos1, length(crc_correcto(idx_antena1)));
fprintf('  Tasa de Error de Paquetes (PER): %.2f%%\n', porcentaje_error1);
fprintf('  RSSI Medio: %.2f dBm | SNR Medio: %.2f dB | RSSI Medio Filtrado: %.2f dBm | SNR Medio Filtrado: %.2f dB \n', mean(rssi_ant1,'omitnan'), mean(snr_ant1,'omitnan'), mean(rssi1_filtrado,'omitnan'), mean(snr1_filtrado,'omitnan'));

fprintf('  Días activos de recepción: %d días\n', length(dias_unicos1));
fprintf('  Media de paquetes diarios: %.0f paquetes/día\n', mean(conteo_diario1));
fprintf('  Día con más tráfico: %s (%d paquetes)\n\n', ...
    datestr(dias_unicos1(conteo_diario1 == max(conteo_diario1))), max(conteo_diario1));

fprintf('------------------------------------------------------------\n');

fprintf('Antena 2: %d paquetes recibidos.\n', length(rssi_ant2));
fprintf('  Paquetes sin error de CRC: %d de %d\n', paquetes_validos2, length(crc_correcto(idx_antena2)));
fprintf('  Tasa de Error de Paquetes (PER): %.2f%%\n', porcentaje_error2);
fprintf('  RSSI Medio: %.2f dBm | SNR Medio: %.2f dB | RSSI Medio Filtrado: %.2f dBm | SNR Medio Filtrado: %.2f dB \n', mean(rssi_ant2,'omitnan'), mean(snr_ant2,'omitnan'), mean(rssi2_filtrado,'omitnan'), mean(snr2_filtrado,'omitnan'));

fprintf('  Días activos de recepción: %d días\n', length(dias_unicos2));
fprintf('  Media de paquetes diarios: %.0f paquetes/día\n', mean(conteo_diario2));
fprintf('  Día con más tráfico: %s (%d paquetes)\n\n', ...
    datestr(dias_unicos2(conteo_diario2 == max(conteo_diario2))), max(conteo_diario2));