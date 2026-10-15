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

```

Summary Results

| Spesialisasi | Jumlah Dokter | Total Janji Temu | Rata-Rata / Dokter | Status Beban Kerja |
| :--- | :---: | :---: | :---: | :--- |
| **Mata** | 2 | 424 | **212.00** | Sangat Padat |
| **Umum** | 8 | 1.680 | **210.00** | Sangat Padat |
| **Penyakit Dalam** | 3 | 598 | **199.33** | Padat (Optimal) |
| **THT** | 2 | 394 | **197.00** | Padat (Optimal) |
| **Kulit** | 2 | 389 | **194.50** | Padat (Optimal) |
| **Anak** | 3 | 576 | **192.00** | Padat (Optimal) |
| **Kandungan** | 2 | 377 | **188.50** | Moderat |
| **Gigi** | 3 | 562 | **187.33** | Moderat |

Key Insights & Recommendations

    1. Spesialisasi Paling Padat: Dokter Spesialis Mata memiliki beban kerja tertinggi (212 janji temu/dokter), diikuti oleh Dokter Umum (210 janji temu/dokter).
    2. Volume Dokter Umum: Dokter Umum menangani 33.6% dari total seluruh janji temu di Klinik Medinara (1.680 dari 5.000 janji temu).
    3. Rekomendasi Operasional:
        a. Spesialis Mata: Pertimbangkan pembukaan shift tambahan atau merekrut 1 dokter spesialis Mata baru.
        b. Dokter Umum: Tingkatkan efisiensi alur pendaftaran dan triase untuk mencegah kemacetan di ruang tunggu.
