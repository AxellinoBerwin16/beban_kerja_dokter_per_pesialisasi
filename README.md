Doctor Workload Analysis (SQL Case Study)

Project Overview
Proyek ini menganalisis beban kerja 25 dokter di Klinik Medinara berdasarkan 5.000 data janji temu (*appointment*). Analisis dilakukan menggunakan SQL untuk membantu Manajer Klinik mengidentifikasi spesialisasi yang paling padat dan mengevaluasi keseimbangan alokasi dokter.

Business Questions
1. Spesialisasi mana yang memiliki beban kerja janji temu paling tinggi/padat?
2. Apakah rasio jumlah dokter dengan volume janji temu sudah seimbang?
3. Apa rekomendasi operasional untuk alokasi jadwal atau penambahan dokter?

Tools Used
SQL (MySQL) via DBeaver
Git & GitHub

SQL Query

```sql
SELECT 
    d.specialization AS spesialisasi,
    COUNT(DISTINCT d.doctor_id) AS jumlah_dokter,
    COUNT(a.appt_id) AS total_janji_temu,
    ROUND(COUNT(a.appt_id) * 1.0 / COUNT(DISTINCT d.doctor_id), 2) AS rata_rata_per_dokter,
    CASE 
        WHEN (COUNT(a.appt_id) * 1.0 / COUNT(DISTINCT d.doctor_id)) >= 200 THEN 'Sangat Padat'
        WHEN (COUNT(a.appt_id) * 1.0 / COUNT(DISTINCT d.doctor_id)) BETWEEN 190 AND 199.99 THEN 'Padat (Optimal)'
        ELSE 'Moderat'
    END AS status_beban_kerja
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.specialization
ORDER BY rata_rata_per_dokter DESC;
