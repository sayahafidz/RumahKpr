@extends('layout.landing')

@section('content')
<style>
    .background-section {
        height: 50vh !important;
    }
</style>
<section class="background-section" class="text-center">
    <div class="container text-center">
        <h1 class="display-4 fw-bold">Booking</h1>
    </div>
</section>

<section>
    <div class="container my-5">
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Perumahan</th>
                        <th scope="col">Tipe</th>
                        <th scope="col">Harga</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>{{ $properti->judul }}</td>
                        <td>{!! $properti->deskripsi !!}</td>
                        <td>{{ number_format($properti->harga, 2) }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="form">
            <form action="{{ route('checkout.store', $id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="mb-3">
                    <label for="" class="form-label">No. KTP/SIM/PASPOR</label>
                    <input type="text" name="no_identitas" class="form-control" id="">
                </div>
                <div class="mb-3">
                    <label for="" class="form-label">Pekerjaan</label>
                    <input type="text" name="pekerjaan" class="form-control" id="">
                </div>
                <div class="mb-3">
                    <label for="" class="form-label">Gaji</label>
                    <input type="text" name="gaji" class="form-control" id="">
                </div>
                <div class="mb-3">
                    <label for="">KTP</label>
                    <input type="file" class="form-control" name="ktp" placeholder="" id="">
                </div>
                <div class="mb-3">
                    <label for="">Kartu Keluarga</label>
                    <input type="file" class="form-control" name="kk" placeholder="" id="">
                </div>
                <div class="mb-3">
                    <label for="">Rekening 3 Bulan Terakhir</label>
                    <input type="file" class="form-control" name="rekening" placeholder="" id="">
                </div>
                <div class="mb-3">
                    <label for="">NPWP</label>
                    <input type="file" class="form-control" name="npwp" placeholder="" id="">
                </div>
                <div class="mb-3">
                    <label for="floatingTextarea">Alamat</label>
                    <textarea class="form-control" name="alamat" placeholder="" id=""></textarea>
                </div>
                <div class="mb-3">
                    <label for="" class="form-label">Jenis Pembayaran</label>
                    <select class="form-select" name="jenis_pembayaran" aria-label="Default select example">
                        <option selected hidden>Pilih</option>
                        <option value="tabungan_mandiri">Tabungan Mandiri</option>
                        <option value="tabungan_lainnya">Tabungan Lainnya</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Jangka Waktu (Tenor)</label>
                    <select name="jangka_waktu" id="waktu" class="form-select">
                        <option selected hidden>Silahlan pilih..</option>
                        <option value="10">10 Tahun</option>
                        <option value="15">15 Tahun</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Bunga Pertahun (%)</label>
                    <input type="number" class="form-control" name="bunga" readonly id="bunga"
                        value="{{ @$_GET['bunga'] }}">
                </div>
                <div class="mb-3">
                    <label for="" class="form-label">Janji Temu</label>
                    <input type="datetime-local" name="janji_temu" class="form-control" id="">
                </div>
                <button type="submit" class="btn btn-primary w-100">Selesaikan</button>
            </form>
        </div>
    </div>
    <section />

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var waktu = document.getElementById('waktu');
            var bunga = document.getElementById('bunga');
            var bunga_pertahun = 0;

            waktu.addEventListener('change', function() {
                if (waktu.value == 10) {
                    bunga_pertahun = 8.88;
                } else if (waktu.value == 15) {
                    bunga_pertahun = 7.5;
                }
                bunga.value = bunga_pertahun;
                console.log(bunga_pertahun);
            });
        });


    </script>
    @endsection