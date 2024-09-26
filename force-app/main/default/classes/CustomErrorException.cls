/*
Author: Nishant Mohan Wavhal
General Custom Error Exception Class
*/

public class CustomErrorException extends Exception{
    public String message;
    public String errorCode;
    public CustomErrorException(String errorCode, string message){
        this.errorCode = errorCode;
        this.message = message;
    }
}