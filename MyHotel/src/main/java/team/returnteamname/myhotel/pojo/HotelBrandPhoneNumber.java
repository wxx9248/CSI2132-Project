package team.returnteamname.myhotel.pojo;

public class HotelBrandPhoneNumber
{
    private String hotelBrandName;
    private String phoneNumber;

    public HotelBrandPhoneNumber()
    {}

    public HotelBrandPhoneNumber(String hotelBrandName, String phoneNumber)
    {
        this.hotelBrandName = hotelBrandName;
        this.phoneNumber    = phoneNumber;
    }

    public String getHotelBrandName()
    {
        return hotelBrandName;
    }

    public void setHotelBrandName(String hotelBrandName)
    {
        this.hotelBrandName = hotelBrandName;
    }

    public String getPhoneNumber()
    {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber)
    {
        this.phoneNumber = phoneNumber;
    }
}
