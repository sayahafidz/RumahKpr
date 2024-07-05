<?php

namespace App\Http\Controllers;

use App\Models\FotoPembayaran;
use App\Models\Pembayaran;
use App\Models\Booking;
use App\Models\Dokumen;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PembayaranController extends Controller
{
    public function store(Request $request, $id)
    {
        $data = $request->validate([
            'ktp' => 'required|file|mimes:jpeg,png,pdf|max:2048',
            'kk' => 'required|file|mimes:jpeg,png,pdf|max:2048',
            'rekening' => 'required|file|mimes:jpeg,png,pdf|max:2048',
            'npwp' => 'required|file|mimes:jpeg,png,pdf|max:2048',
            'alamat' => 'required|string|max:255',
        ]);

        try {
            DB::beginTransaction();

            // Save booking data
            $data['properti_id'] = $id;
            $data['user_id'] = auth()->id();

            $booking = Booking::create($data);

            // Handle file uploads and save file names to database
            $files = ['ktp', 'kk', 'rekening', 'npwp'];
            foreach ($files as $file) {
                if ($request->hasFile($file)) {
                    $uploadedFile = $request->file($file);
                    $fileName = time() . '_' . $uploadedFile->getClientOriginalName();
                    $uploadedFile->storeAs('public/dokumen', $fileName);

                    // Save document record
                    $dokumen = Dokumen::create([
                        'file' => $fileName,
                        'booking_id' => $booking->id,
                        'jenis_dokumen' => $file, // Save the type of document
                    ]);
                }
                dd($dokumen);
            }

            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Terjadi kesalahan: ' . $e->getMessage());
        }

        return redirect()->route('riwayat')->with('success', 'Data berhasil disimpan');
    }

    public function update(Request $request, $id)
    {
        $data = $request->validate([
            'foto' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'tanggal_transfer' => 'required',
            'jumlah_transfer' => 'required'
        ]);

        $request->foto->store('public/bukti_transfer');

        $data['foto'] = $request->foto->hashName();
        $data['pembayaran_id'] = $id;

        FotoPembayaran::create($data);

        Booking::find($id)->update([
            'status' => 'pending'
        ]);

        // dd($data, $request->all(), $id);


        return redirect()->route('riwayat')->with('success', 'Data berhasil disimpan');
    }

    public function index_admin()
    {
        return view('page.pembayaran.index', [
            'pembayaran' => Booking::all()
        ]);
    }

    public function update_status(Request $request, $id)
    {
        $request->validate([
            'status' => 'required',
            'catatan' => 'required'
        ]);

        try {
            DB::beginTransaction();
            if ($request->status == "approve") {
                $foto = FotoPembayaran::find($id);
                $foto->update([
                    'status' => 1,
                    'catatan' => $request->catatan
                ]);

                $pembayaran = Booking::find($foto->pembayaran_id);
                $jumlah_dibayar = $foto->jumlah_transfer + $pembayaran->jumlah_dibayar;
                $status = $jumlah_dibayar >= $pembayaran->properti->harga ? 'paid' : 'loan';
                $pembayaran->update([
                    'status' => $status,
                    'jumlah_dibayar' => $jumlah_dibayar
                ]);


                // // sum all total transfer
                // $totalTransfer = 0;
                // $fotopembayaran = FotoPembayaran::where('pembayaran_id', $id)->get();
                // foreach ($fotopembayaran as $fotopembayaran) {
                //     $totalTransfer += $fotopembayaran->jumlah_transfer;
                // }

                // // update the total amount of transfer to the booking
                // $booking = Booking::find($id);
                // $booking->jumlah_dibayar = $totalTransfer;





            } else {
                $foto = FotoPembayaran::find($id);
                $foto->update([
                    'status' => 1,
                    'catatan' => $request->catatan
                ]);

                $pembayaran = Booking::find($foto->pembayaran_id);
                $pembayaran->update([
                    'status' => 'last_payment_decline',
                ]);
            }
            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->route('dashbord.pembayaran')->with('error', 'Data gagal disimpan' . $e->getMessage());
        }

        return redirect()->route('dashbord.pembayaran')->with('Success', 'Data berhasil disimpan');
    }


    public function bayar()
    {
        return view('page.pembayaran.index', [
            'pembayaran' => Booking::all()->load('foto')
        ]);
    }


    public function uploadBuktiTransfer(Request $request, $id)
    {
        $request->validate([
            'bukti_transfer' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
            'tanggal_transfer' => 'required|date',
            'jumlah_transfer' => 'required|numeric'

        ]);

        if ($request->file('bukti_transfer')) {
            $imageName = time() . '.' . $request->bukti_transfer->extension();
            $request->bukti_transfer->storeAs('public/bukti_transfer', $imageName);

            // Save the path to the database (assuming you have a 'foto' table and a 'Foto' model)
            $foto = new FotoPembayaran();
            $foto->pembayaran_id = $id;
            $foto->foto = $imageName;
            $foto->tanggal_transfer = $request->tanggal_transfer;
            $foto->jumlah_transfer = $request->jumlah_transfer;
            $foto->status = 0;
            $foto->save();


            // Update the status of the booking
            $booking = Booking::find($id);
            $booking->status = 'pending';
            $booking->save();


            // get all fotopembayaran
            $fotopembayaran = FotoPembayaran::where('pembayaran_id', $id)->get();
            // count total amount of transfer
            $totalTransfer = 0;
            foreach ($fotopembayaran as $fotopembayaran) {
                $totalTransfer += $fotopembayaran->jumlah_transfer;
            }

            // update the total amount of transfer to the booking
            $booking = Booking::find($id);
            $booking->jumlah_dibayar = $totalTransfer;


            // get the booking
            $booking = Booking::find($id);
            // check if the total amount of transfer is equal to the total amount of the booking
            if ($totalTransfer >= $booking->properti->harga) {
                $booking->status = 'paid';
                $booking->save();
            } else {
                $booking->status = 'loan';
                $booking->save();
            }
        }

        return redirect()->back()->with('success', 'Bukti transfer uploaded successfully.');
    }
}
