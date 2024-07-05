@extends('layout.landing')

@section('content')
<style>
    .background-section {
        height: 50vh;
    }
</style>
<section class="background-section text-center">
    <div class="container text-center">
        <h1 class="display-4 fw-bold">Riwayat</h1>
    </div>
</section>

<div class="container my-5">
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col">Daftar</th>
                    <th scope="col">Harga</th>
                    <th scope="col">Jumlah dibayarkan</th>
                    <th scope="col">Tanggal</th>
                    <th scope="col">Janji Temu</th>
                    <th scope="col">Jenis Pembayaran</th>
                    <th scope="col">Status</th>
                    <th scope="col">Opsi</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($pembayaran as $item)
                <tr>
                    <td>{{ $loop->iteration }}</td>
                    <td>{{ $item->properti->judul }}</td>
                    <td>Rp{{ number_format($item->properti->harga, 0, ',', '.') }}</td>
                    <td>Rp{{ number_format($item->jumlah_dibayar, 0, ',', '.') }}</td>
                    <td>{{ $item->created_at }}</td>
                    <td>{{ $item->janji_temu }}</td>
                    <td>{{ $item->jenis_pembayaran == 'tabungan_mandiri' ? 'Tabungan Mandiri' : 'Tabungan Lainnya' }}
                    </td>
                    <td>
                        @if ($item->status == 'unpaid')
                        Belum Dibayar
                        @elseif($item->status == 'loan')
                        Masih dalam cicilan
                        @elseif($item->status == 'paid')
                        Lunas
                        @elseif($item->status == 'last_payment_decline')
                        Bukti pembayaran ditolak
                        @else
                        Dalam review admin
                        @endif

                    </td>
                    <td>
                        <a href="{{ route('detail_booking', $item->id) }}" class="btn btn-primary">Detail</a>
                        {{-- <button type="button" class="btn btn-success" data-bs-toggle="modal"
                            data-bs-target="#buktiTransfer-{{ $item->id }}">
                            Bayar
                        </button> --}}
                    </td>
                </tr>
                <div class="modal fade" id="buktiTransfer-{{ $item->id }}" tabindex="-1"
                    aria-labelledby="buktiTransfer-{{ $item->id }}Label" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="buktiTransfer-{{ $item->id }}Label">
                                    Bukti pembayaran
                                </h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">

                                {{-- @if ($item->foto->isNotEmpty() && $item->status == 'paid')
                                @foreach ($item->foto as $key => $foto) --}}
                                {{-- <div class="row mt-2">
                                    <div class="col-6">
                                        <img src="{{ asset('storage/bukti_transfer/' . $foto->foto) }}" alt=""
                                            class="img-fluid">
                                    </div>
                                    <div class="col-6">
                                        <div class="d-flex">
                                            <h4>Tanggal Transfer :</h4>
                                            <h4>{{ $foto->tanggal_transfer }}</h4>
                                        </div>
                                        <div class="d-flex">
                                            <h4>Jumlah Transfer :</h4>
                                            <h4>Rp{{ number_format($foto->jumlah_transfer, 0, ',', '.') }}</h4>
                                        </div>
                                    </div>
                                </div> --}}
                                {{-- @endforeach --}}
                                {{-- @else --}}
                                {{-- <p class="text-muted">No proof of payment uploaded yet.</p>


                                <form action="{{ route('uploadBuktiFotoBayar', $item->id) }}" method="post"
                                    enctype="multipart/form-data">
                                    @csrf
                                    <div class="mb-3">
                                        <label for="bukti_transfer" class="form-label">Upload Bukti Transfer</label>
                                        <input type="file" class="form-control" id="bukti_transfer"
                                            name="bukti_transfer" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="tanggal_transfer" class="form-label">Tanggal Transfer</label>
                                        <input type="date" class="form-control" id="tanggal_transfer"
                                            name="tanggal_transfer" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="jumlah_transfer" class="form-label">Jumlah Transfer</label>
                                        <input type="number" class="form-control" id="jumlah_transfer"
                                            name="jumlah_transfer" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Upload</button>
                                </form> --}}
                            </div>
                            {{-- @endif --}}
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                @endforeach
            </tbody>
        </table>
    </div>
</div>
@endsection