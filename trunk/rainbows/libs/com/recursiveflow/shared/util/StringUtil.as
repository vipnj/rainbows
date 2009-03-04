package com.recursiveflow.shared.util 
{
    /**
     * Home to static helper methods providing string processing functionality not available in the standard Flash API     *
     * @author Alastair Dant
     */
    public class StringUtil 
    {
        public static var MAX_DEPTH : Number = 3;

        public static function properCase(data : String) : String 
        {
            return (data.length < 2) ? data.toUpperCase() : data.charAt(0).toUpperCase() + data.substr(1).toLowerCase();
        }

        public static function trimTrailingSpace(data : String) : String
        {
            var lastRealChar : Number = data.length;
		
            for (var i : Number = data.length - 1;i >= 0; i--) 
            {
                var c : Number = data.charCodeAt(i);
			
                if (c > 32 && c < 127)
                {
                    break;		
                }
				else
                {
                    lastRealChar--;
                } 						
            }
		
            return data.substring(0, lastRealChar);
        }

        public static function dumpToLog(obj : Object, depth : Number) : void
        {
            var cdepth : Number = depth || 0;
            var ndepth : Number = cdepth + 1;
            var prefix : String = "";
		
            for (var i : Number = 0;i < cdepth; i++)
            {
                prefix += "    ";	
            }
		
            for (var key : String in obj) 
            {
                trace(prefix + key + " == " + obj[key]);
			
                if (ndepth <= MAX_DEPTH)
                {
                    dumpToLog(obj[key], ndepth);	
                } 
            }	
        }

        public static function getHexValue(target : Number) : String
        {
            return target.toString(16);
        }

        public static function zeroPad(number : Number, digits : Number) : String
        {
            var output : String = number.toString();
		
            while(output.length < digits) 
            {
                output = "0" + output;	
            }	
			
            return output;
        }
    }
}