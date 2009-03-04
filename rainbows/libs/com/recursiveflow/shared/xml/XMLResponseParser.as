package com.recursiveflow.shared.xml
{
    /**
     * Designates classes capable of parsing an XML document into appropriate data model object(s).
     */    public interface XMLResponseParser
    {
        /**
         * Parses the supplied XML and returns a structured model object.
         * 
         * @param xml The XML document to be parsed
         * @return The appropriate object from the data model
         */
        function parse(xml : XML) : Object;
    }
}