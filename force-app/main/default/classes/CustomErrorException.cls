/*
Author: Nishant Mohan Wavhal
Custom Error Exception Class
*/
public with sharing class CustomErrorException extends Exception{
    public String message;
    public String errorCode;
    public CustomErrorException(String errorCode, string message){
        this.errorCode = errorCode;
        this.message = message;
    }
}