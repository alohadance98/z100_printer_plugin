package com.example.z100_printer_plugin;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.Layout;
import android.util.Log;

import androidx.annotation.NonNull;

import com.zcs.sdk.DriverManager;
import com.zcs.sdk.Printer;
import com.zcs.sdk.SdkResult;
import com.zcs.sdk.Sys;
import com.zcs.sdk.print.PrnStrFormat;
import com.zcs.sdk.print.PrnTextFont;
import com.zcs.sdk.print.PrnTextStyle;

import java.io.ByteArrayInputStream;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** Z100PrinterPlugin */
public class Z100PrinterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private DriverManager mDriverManager;
  private Sys mSys;
  private Printer mPrinter;
//  private CardReaderManager mCardReadManager;
  private static final int READ_TIMEOUT = 60 * 1000;
  public static final byte[] APDU_SEND_RF = {0x00, (byte) 0xA4, 0x04, 0x00, 0x0E, 0x32, 0x50, 0x41, 0x59, 0x2E, 0x53, 0x59, 0x53, 0x2E, 0x44, 0x44, 0x46, 0x30, 0x31, 0x00};
  public static final byte[] APDU_SEND_FELICA = {0x10, 0x06, 0x01, 0x2E, 0x45, 0x76, (byte) 0xBA, (byte) 0xC5, 0x45, 0x2B, 0x01, 0x09, 0x00, 0x01, (byte) 0x80, 0x00};

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "z100_printer_plugin");
    channel.setMethodCallHandler(this);
    mDriverManager = DriverManager.getInstance();
    mSys = mDriverManager.getBaseSysDevice();
//    mCardReadManager = mDriverManager.getCardReadManager();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    try {
      if (call.method.equals("initSdk")) {
        int status = mSys.sdkInit();
        if(status != SdkResult.SDK_OK) {
          mSys.sysPowerOn();
          try {
            Thread.sleep(1000);
          } catch (InterruptedException e) {
            e.printStackTrace();
          }
        }
        status = mSys.sdkInit();
        if(status == SdkResult.SDK_OK) {
          result.success("success");
        } else {
          result.success("fail");
        }
      } else if (call.method.equals("printText")) {
        mPrinter = mDriverManager.getPrinter();
        String content = call.argument("text");
        int printStatus = mPrinter.getPrinterStatus();
        if (printStatus != SdkResult.SDK_PRN_STATUS_PAPEROUT) {
          PrnStrFormat format = new PrnStrFormat();
          format.setTextSize(25);
          format.setAli(Layout.Alignment.ALIGN_CENTER);
          format.setStyle(PrnTextStyle.NORMAL);
          format.setFont(PrnTextFont.SANS_SERIF);
          mPrinter.setPrintAppendString(content, format);
          printStatus = mPrinter.setPrintStart();
          result.success("printText success: " + printStatus);
        }
      } else if (call.method.equals("printPicture")) {
        mPrinter = mDriverManager.getPrinter();
        byte[] data = call.argument("picture");
        Bitmap bitmap = BitmapFactory.decodeStream(new ByteArrayInputStream(data));
        int printStatus = mPrinter.getPrinterStatus();
        if (printStatus != SdkResult.SDK_PRN_STATUS_PAPEROUT) {
          mPrinter.setPrintAppendBitmap(bitmap, Layout.Alignment.ALIGN_CENTER);
          printStatus = mPrinter.setPrintStart();
          result.success("printPicture success: " + printStatus);
        }
      }
      else {
        result.notImplemented();
      }
    } catch (Exception e) {
      Log.e("Z100_printer_plugin",e.getMessage());
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
