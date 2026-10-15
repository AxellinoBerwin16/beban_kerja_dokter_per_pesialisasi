INSERT INTO `SELECT 
    d.specialization AS spesialisasi,
    COUNT(DISTINCT d.doctor_id) AS jumlah_dokter,
    COUNT(a.appt_id) AS total_janji_temu,
    ROUND(COUNT(a.appt_id) * 1.0 / COUNT(DISTINCT d.doctor_id), 2) AS rata_rata_per_dokter,
    CASE 
        WHEN (COUNT(a.appt_id) * 1.0 / COUNT(DISTINCT d.doctor_id)) >= 200 THEN 'Sangat Padat (Butuh Evaluasi/Tambah Dokter)'
        WHEN (COUNT(a.appt_id) * 1.0 / COUNT(DISTINCT d.doctor_id)) BETWEEN 190 AND 199.99 THEN 'Padat (Optimal)'
        ELSE 'Beban Kerja Moderat'
    END AS rekomendasi_beban_kerja
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.specialization
ORDER BY rata_rata_per_dokter DESC` (specialization,jumlah_dokter,total_janji_temu,rata_rata_per_dokter,rekomendasi_beban_kerja) VALUES
	 ('Mata',2,424,212.00,'Sangat Padat (Butuh Evaluasi/Tambah Dokter)'),
	 ('Umum',8,1680,210.00,'Sangat Padat (Butuh Evaluasi/Tambah Dokter)'),
	 ('Penyakit Dalam',3,598,199.33,'Padat (Optimal)'),
	 ('THT',2,394,197.00,'Padat (Optimal)'),
	 ('Kulit',2,389,194.50,'Padat (Optimal)'),
	 ('Anak',3,576,192.00,'Padat (Optimal)'),
	 ('Kandungan',2,377,188.50,'Beban Kerja Moderat'),
	 ('Gigi',3,562,187.33,'Beban Kerja Moderat');
