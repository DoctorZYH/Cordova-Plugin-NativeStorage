package org.apache.cordova.storage;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class NativeStorage extends CordovaPlugin {

    @Override
       public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
           if (action.equals("set")) {
               JSONObject jsonObject = new JSONObject(args.getString(0));
               setStorage(jsonObject);
               return true;
           } else if (action.equals("get")) {
               JSONObject jsonObject = new JSONObject(args.getString(0));
               getStorage(jsonObject, callbackContext);
               return true;
           }
           return false;
       }

       private void setStorage(JSONObject jsonObject) {
           String spName = jsonObject.optString("name");
           String key = jsonObject.optString("key");
           String value = jsonObject.optString("value");
           SPUtils.getInstance(spName).put(key, value);
       }

       private void getStorage(JSONObject jsonObject, CallbackContext callbackContext) throws JSONException {
           String spName = jsonObject.optString("name");
           String key = jsonObject.optString("key");
           String value = SPUtils.getInstance(spName).getString(key);
           JSONObject pluginResponse = new JSONObject();
           pluginResponse.put("value", value);
           callbackContext.success(pluginResponse);
       }
}
