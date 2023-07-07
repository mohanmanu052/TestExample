package com.example.test_example

import android.Manifest
import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private val CHANNEL = "bluetooth_channel"
    private val REQUEST_ENABLE_BLUETOOTH = 1
    private val BLE_PERMISSIONS =
            arrayOf(
                    Manifest.permission.ACCESS_COARSE_LOCATION,
                    Manifest.permission.ACCESS_FINE_LOCATION
            )

    private val ANDROID_12_BLE_PERMISSIONS =
            arrayOf(
                    Manifest.permission.BLUETOOTH_SCAN,
                    Manifest.permission.BLUETOOTH_CONNECT,
                    Manifest.permission.ACCESS_FINE_LOCATION
            )

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            if (call.method == "enableBluetooth") {
                System.out.println("Coming to enable bluetooth 1111111")
                enableBluetooth(result)
            } else {
                System.out.println("Coming to enable bluetooth 222222")

                result.notImplemented()
            }
        }
    }

    private fun enableBluetooth(result: MethodChannel.Result) {
        System.out.println("Coming to enable bluetooth 000000000")

        val bluetoothManager: BluetoothManager = getSystemService(BluetoothManager::class.java)
        val bluetoothAdapter: BluetoothAdapter? = bluetoothManager.getAdapter()
        if (bluetoothAdapter == null) {
            // Device doesn't support Bluetooth
        } else {
            if (bluetoothAdapter != null) {
                System.out.println("Coming to enable bluetooth 0000000001")

                if (ContextCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH) !=
                                PackageManager.PERMISSION_GRANTED
                ) {
                    System.out.println("Coming to enable bluetooth 0000000002")
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S)
                            ActivityCompat.requestPermissions(
                                    activity,
                                    ANDROID_12_BLE_PERMISSIONS,
                                    REQUEST_ENABLE_BLUETOOTH
                            )
                    else
                            ActivityCompat.requestPermissions(
                                    activity,
                                    BLE_PERMISSIONS,
                                    REQUEST_ENABLE_BLUETOOTH
                            )

                    // ActivityCompat.requestPermissions(
                    //         this,
                    //         arrayOf(Manifest.permission.BLUETOOTH),
                    //         REQUEST_ENABLE_BLUETOOTH

                } else {

                    val enableBluetoothIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                    startActivityForResult(enableBluetoothIntent, REQUEST_ENABLE_BLUETOOTH)
                    result.success(null)
                }
            } else {
                result.error("UNAVAILABLE", "Bluetooth is not available on this device", null)
            }
        }
    }

    override fun onRequestPermissionsResult(
            requestCode: Int,
            permissions: Array<String>,
            grantResults: IntArray
    ) {
        when (requestCode) {
            REQUEST_ENABLE_BLUETOOTH -> {
                if (grantResults.isNotEmpty() &&
                                grantResults[0] == PackageManager.PERMISSION_GRANTED
                ) {
                    val enableBluetoothIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                    startActivityForResult(enableBluetoothIntent, REQUEST_ENABLE_BLUETOOTH)
                } else {
                    // Permission denied, handle accordingly
                }
                return
            }
        }
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_ENABLE_BLUETOOTH) {
            if (resultCode == Activity.RESULT_OK) {
                MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                        .invokeMethod("onBluetoothEnabled", null)
            } else {
                MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                        .invokeMethod("onBluetoothEnableFailed", null)
            }
        }
    }
}
