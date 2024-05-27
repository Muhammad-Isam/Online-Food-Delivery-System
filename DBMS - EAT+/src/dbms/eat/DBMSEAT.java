/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package dbms.eat;

import Class.Coupon;
import Class.Menu;
import Class.Order;
import Class.Restaurant;
import Class.Review;
import Class.User;
import java.util.ArrayList;

/**
 *
 * @author Adil
 */
public class DBMSEAT {

    public static void main(String[] args) {
        // TODO code application logic here
        User u = new User();
//        System.out.println(u.getRiderDetail("zk@fd.com", "abc"));
//        u = u.getUserDetail("ar@gmail.com", "ar2223");
//        System.out.println(u1);
//        u.signUpUser("test", "test@gmail.com", "test", "505", "Test Area", "Karachi", "2020-05-02");
//        u.deliverRiderOrder(3);
//          ArrayList<Coupon> cList = u.getUserCoupon("ar@gmail.com");
//          for (int i=0; i<cList.size();i++)
//          {
//              Coupon c;
//              c=cList.get(i);
//              System.out.println(c);
//          }
//        CartGUI cg = new CartGUI();
//        CouponGUI c1 = new CouponGUI(cg, u);
//        c1.setVisible(true);
//    ArrayList<Order> oL = u.getUserOrderInfo(1);
//     for (int i=0; i<oL.size();i++)
//          {
//              Order o;
//              o=oL.get(i);
//              System.out.println(o);
//          }

//    HomePageGUI hg = new HomePageGUI();
//    OrderHistoryGUI oh = new OrderHistoryGUI(hg, u);
//u.setuEmail("as@gmail.com");
//u=u.getUserDetail("as@gmail.com", "as1213");
//    OrderHistoryGUI oh = new OrderHistoryGUI( u);
//    oh.setVisible(true);
//System.out.println(u.getResID("Kababjees Fried Chicken", "Ground Floor Komal Heaven Apartment Jauhar"));
//        System.out.println(u.checkReviewEligibility("as@gmail.com", 2));
//    System.out.println(u.getLastOrder());
//    Review r=new Review();
//    ArrayList<Review> rList;
//    rList=u.viewRestaurantReviews("Kababjees Fried Chicken");
//    for (int i=0; i<rList.size(); i++)
//    {
//        r=rList.get(i);
//        System.out.println(r);
////    }
//        Restaurant r1 = new Restaurant();
//        ArrayList<Restaurant> rL;
//        rL = u.getRestaurantByName("Soft Swirl");
//        System.out.println(u.getRestaurantRating("Kababjees Fried Chicken","Ground Floor Komal Heaven Apartment Jauhar"));
//        for (int i = 0; i < rL.size(); i++) {
//            r1 = rL.get(i);
//            System.out.println(r1.getrName() + r1.getrAddress());
//        }
        u.setuEmail("as@gmail.com");
        u.setuPassword("as1213");
       SearchPageGUI sp = new SearchPageGUI(u);
       sp.setVisible(true);
//       Menu m;
//        ArrayList<Menu> mL;
////        mL = u.getRestaurantMenu("Kababjees Fried Chicken","Ground Floor Komal Heaven Apartment Jauhar");
//        mL = u.searchItem("Choc","Kababjees Fried Chicken","Ground Floor Komal Heaven Apartment Jauhar");
////        System.out.println(u.getRestaurantRating("Kababjees Fried Chicken","Ground Floor Komal Heaven Apartment Jauhar"));
//        for (int i = 0; i < mL.size(); i++) {
//            m = mL.get(i);
//            System.out.println(m.getiName()+ m.getiDescription()+m.getiPrice());
//        }
        ArrayList<String> aList;
                User uL = u.getUserDetail("as@gmail.com", "as1213");
               aList = uL.getuAddressList();
               System.out.println("a");
               System.out.println(uL.getuAddress());
               System.out.println(aList.size());
               for (int i=0; i<aList.size();i++)
               {
                   System.out.println(aList.get(i));
               }
        
    }
}
