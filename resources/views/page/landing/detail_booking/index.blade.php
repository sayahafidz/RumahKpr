@extends('layout.landing')

@section('content')
<section class="background-section" style="height: 50vh" class="text-center">
    <div class="container text-center">
        <h1 class="display-4 fw-bold">Detail Booking</h1>
    </div>
</section>

<section>
    <div class="container my-5">
        <div class="card">
            <div class="card-header">
                Detail Transaksi
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">Nama Lengkap</th>
                                <td>{{ $pembayaran->user->name }}</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">Email</th>
                                <td>{{ $pembayaran->user->email }}</td>
                            </tr>
                            <tr>
                                <th scope="row">No. KTP/SIM/PASPOR</th>
                                <td>{{ $pembayaran->no_identitas }}</td>
                            </tr>
                            <tr>
                                <th scope="row">Telepon</th>
                                <td>{{ $pembayaran->user->phone }}</td>
                            </tr>
                            <tr>
                                <th scope="row">Alamat</th>
                                <td>{{ $pembayaran->alamat }}</td>
                            </tr>
                            <tr>
                                <th scope="row">Waktu DP</th>
                                <td>{{ $pembayaran->created_at }}</td>
                            </tr>
                            <tr>
                                <th scope="row">Jenis Pembayaran</th>
                                <td>{{ $pembayaran->jenis_pembayaran == 'tabungan_mandiri' ? 'Tabungan Mandiri' :
                                    'Tabungan Lainnya' }}
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Janji Temu</th>
                                <td>{{ $pembayaran->janji_temu }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-header text-center">
                <h1>Detail Angsuran</h1>
            </div>
            {{-- {{ dd($item) }} --}}
            @foreach ($items as $item)
            <div class="card-body">
                <div class="table-responsive">
                    @php
                    $kpr = [
                    'jangka_waktu' => $item->jangka_waktu * 12
                    ];
                    $table = [];
                    $sisa_pinjaman = $item->properti->harga;

                    $total = count($item->foto) + 1;

                    for ($i = 1; $i <= $total; $i++) { $result['pokok']=$item->properti->harga /
                        $kpr['jangka_waktu'];
                        $sisa_pinjaman -= $result['pokok'];
                        $result['bunga'] = $item->properti->harga * ($item->bunga / 100) / 12;
                        $result['angsuran'] = $result['pokok'] + $result['bunga'];

                        $table[] = [
                        "bulan" => $i,
                        "pokok" => $result['pokok'],
                        "bunga" => $result['bunga'],
                        "angsuran" => $result['angsuran'],
                        "sisa" => $sisa_pinjaman,
                        ];
                        }
                        @endphp

                        <div class="table-responsive mt-3">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th scope="col">Bulan</th>
                                        <th scope="col">Pokok</th>
                                        <th scope="col">Bunga</th>
                                        <th scope="col">Angsuran</th>
                                        <th scope="col">Sisa Pinjaman</th>
                                        <th scope="col">Aksi</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($table as $row)
                                    @if( $row['bulan'] <= $kpr['jangka_waktu'] ) <tr>
                                        <td>Bulan ke {{ $row['bulan'] }}</td>
                                        <td>Rp{{ number_format($row['pokok'], 0, ',', '.') }}</td>
                                        <td>Rp{{ number_format($row['bunga'], 0, ',', '.') }}</td>
                                        <td>Rp{{ number_format($row['angsuran'], 0, ',', '.') }}</td>
                                        <td>Rp{{ number_format($row['sisa'], 0, ',', '.') }}</td>
                                        <td>
                                            {{-- {{ dd($row['bulan'],
                                            count($item->foto),
                                            $row['bulan'] >=
                                            count($item->foto) &&
                                            $item->foto[$row['bulan']-1]->status ==
                                            0) }} --}}
                                            @if ($row['bulan'] > count($item->foto) )
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal"
                                                data-bs-target="#buktiTransfer-{{ $item->id }}">
                                                Bayar
                                            </button>

                                            @elseif($row['bulan'] >= count($item->foto) &&
                                            $item->foto[$row['bulan']-1]->status ==
                                            0)
                                            <p>DALAM REVIEW ADMIN</p>
                                            @else
                                            <p>LUNAS PADA {{ $item->foto[$row['bulan']-1]->tanggal_transfer }}
                                            </p>
                                            @endif
                                        </td>
                                        </tr>

                                        </tr>
                                        <div class="modal fade" id="buktiTransfer-{{ $item->id }}" tabindex="-1"
                                            aria-labelledby="buktiTransfer-{{ $item->id }}Label" aria-hidden="true">
                                            <div class="modal-dialog modal-xl">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5"
                                                            id="buktiTransfer-{{ $item->id }}Label">
                                                            Bukti pembayaran
                                                        </h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">

                                                        <p class="text-muted">No proof of payment uploaded yet.</p>


                                                        <form action="{{ route('uploadBuktiFotoBayar', $item->id) }}"
                                                            method="post" enctype="multipart/form-data">
                                                            @csrf
                                                            <div class="mb-3">
                                                                <label for="bukti_transfer" class="form-label">Upload
                                                                    Bukti
                                                                    Transfer</label>
                                                                <input type="file" class="form-control"
                                                                    id="bukti_transfer" name="bukti_transfer" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="tanggal_transfer" class="form-label">Tanggal
                                                                    Transfer</label>
                                                                <input type="date" class="form-control"
                                                                    id="tanggal_transfer" name="tanggal_transfer"
                                                                    required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="jumlah_transfer_mantap"
                                                                    class="form-label">Jumlah
                                                                    Transfer</label>
                                                                <input type="text" class="form-control"
                                                                    id="jumlah_transfer_mantap"
                                                                    name="jumlah_transfer_mantap"
                                                                    value="Rp{{ number_format($row['angsuran'], 0, ',', '.') }}"
                                                                    readonly>
                                                                <input type="hidden" class="form-control"
                                                                    id="jumlah_transfer" name="jumlah_transfer"
                                                                    value="{{ $row['angsuran']}}">
                                                                {{-- notes --}}
                                                                <small class="text-muted mt-2">*Jumlah transfer
                                                                    harus
                                                                    sama
                                                                    dengan angsuran bulan ini</small>
                                                            </div>
                                                            <button type="submit"
                                                                class="btn btn-primary">Upload</button>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary"
                                                            data-bs-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        @endif
                                        @endforeach
                                </tbody>
                            </table>
                        </div>
                </div>
            </div>
            @endforeach

        </div>
    </div>


</section>


@endsection