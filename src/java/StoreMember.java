/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author spstudent
 */
public class StoreMember {
    //Constants

    //Class variables and methods prototype

    //Instance variables and methods prototype
    private String nric;
    private String name;
    private String address;
    private String email;
    private String contact;
    private String creditCardType;
    private String creditCardNo;
    private String password;

    //Constructor
    StoreMember(String nric, String name, String address, String email,
                String contact, String creditCardType, String creditCardNo,
                String password){
        this.nric = nric;
        this.name = name;
        this.address = address;
        this.email = email;
        this.contact = contact;
        this.creditCardType = creditCardType;
        this.creditCardNo = creditCardNo;
        this.password = password;
    }

    public String getNRIC(){
        return nric;
    }

    public String getName(){
        return name;
    }

    public String getAddress(){
        return address;
    }

    public String getEmail(){
        return email;
    }

    public String getContact(){
        return email;
    }

    public String getCCType(){
        return creditCardType;
    }

    public String getCCNo(){
        return creditCardNo;
    }

    public String getPassword(){
        return creditCardType;
    }
}
