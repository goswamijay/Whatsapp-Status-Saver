
import 'package:device_info_plus/device_info_plus.dart';

class AppConstants  {

 // static String Whatsapp_path="/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses";
  //static String Whatsapp_path = "/storage/emulated/0/WhatsApp/Media/.Statuses";
 //static String Whatsapp_path="/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses";
 //static String Whatsapp_path="/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses"

  static String Whatsapp_path = "";

   static getInfo1() async {
   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
   AndroidDeviceInfo info = await deviceInfo.androidInfo;

   print( info.version.sdkInt.toString());
   if(info.version.sdkInt < 28){
       Whatsapp_path = "/storage/emulated/0/WhatsApp/Media/.Statuses";
     return Whatsapp_path.toString();
   }else{
      Whatsapp_path="/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses";
      return Whatsapp_path.toString();
   }
  }





}
