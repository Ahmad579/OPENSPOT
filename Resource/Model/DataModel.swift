//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper


class UserResponse: Mappable {
    
    var success: Bool?
    var message: String?
    var data:    UserInformation?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["user"]
    }
}

class UserProfile: Mappable {
    
    var success: Bool?
    var message: String?
    var data:    [UserInformation]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["user"]
    }
}

class BookingList : Mappable {
    
    var success: Bool?
    var message: String?
    var data:    [BookingListObject]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["data"]
        
    }
    
}

class GroundTime : Mappable {
    
    var success: Bool?
    var message: String?
    var data:    [TimeOFGround]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["data"]
        
    }
    
}

class UserFavourite : Mappable {
    
    var success: Bool?
    var message: String?
    var data:    [UserFavouriteObject]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["collection"]
        
    }
    
}




class BookGround : Mappable {
    
    var success: Bool?
    var message: String?
    var data:    BookGroundObject?
    var groundInfo : [BookGroundObject]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["data"]
        
        groundInfo <- map["data"]
        
    }
    
}
class UserFavouriteObject : Mappable {
    
    var idOfFav: Int?
    var name: String?
    var image:    String?
    var location:    String?
    var information:    String?
    var type:    String?
    var isFav : String?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        idOfFav <- map["id"]
        name <- map["name"]
        image    <- map["image"]
        location    <- map["location"]
        information    <- map["information"]
        type    <- map["type"]
        isFav    <- map["is_fav"]

        

        
        
    }
    
}


class BookGroundObject : Mappable {
    
    var name: String?
    var date: String?
    var time:    String?
    var duration:    String?
    var price:    String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        date <- map["date"]
        time    <- map["time"]
        duration    <- map["duration"]
        price    <- map["price"]

        
    }
    
}


class BookingListObject  : Mappable {
    
    var booking_id: Int?
    var name : String?
    var location : String?
    var image : String?
    var type : String?
    var information : String?
    var date : String?
    var time : String?
    var duration : String?
    var time_until : String?
    var booking_ids : String?

    
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        booking_id <- map["booking_id"]
        name <- map["name"]
        location <- map["location"]
        image <- map["image"]
        type <- map["type"]
        information <- map["information"]
        date <- map["date"]
        time <- map["time"]
        duration <- map["duration"]
        time_until <- map["time_until"]
        booking_ids <- map["booking_ids"]
   }
    
    
}


class GroundDetail : Mappable {
    
    var success:        Bool?
    var message:        String?
    var data:           GetALlGroundObj?
    var imagesArray      :  [GroundImages]?
//    var timeArray        :  [TimeOFGround]?
    var timeObject       :  TimeInfoOfGround?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["ground"]
        timeObject <- map["times"]
        imagesArray <- map["images"]

    }
    
}

class GroundImages : Mappable {
    
    var image: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        
    }
    
}

class TimeInfoOfGround: Mappable {
    
    var morning     : [TimeOFGround]?
    var noon        : [TimeOFGround]?
    var afterNoon   : [TimeOFGround]?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        morning <- map["Morning"]
        noon <- map["Noon"]
        afterNoon <- map["Afternoon"]
        
        
    }
    
}


class TimeOFGround : Mappable {
    
    var time_id: Int?
    var time_from: String?
    var time_to: String?
    var price: String?
    var is_GroundBooked  : String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        time_id <- map["time_id"]
        time_from <- map["time_from"]
        time_to <- map["time_to"]
        price <- map["price"]
        is_GroundBooked <- map["is_booked"]

        
    }
    
}
//images
class AllGroundList : Mappable {
    
    var success: Bool?
    var message: String?
    var data:    [GetALlGroundObj]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data    <- map["data"]
    }
    
}


class GetALlGroundObj  : Mappable {
    
    var idOfGround: Int?
    var name : String?
    var location : String?
    var image : String?
    var type : String?
    var information : String?
    var favOrUnfav      : String?
    var timeOfGround : [TimeOFGround]?

    

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        idOfGround <- map["id"]
        name <- map["name"]
        location <- map["location"]
        image <- map["image"]
        type <- map["type"]
        favOrUnfav  <- map["is_fav"]

        information <- map["information"]
        timeOfGround <- map["times"]
        
    }
    
    
}


class UserData : Mappable {
    
    var user: UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        
    }
    
}


class Audition : Mappable {
    var success: Bool?
    var message: String?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
    
}

class GetALlCategories : Mappable {
  
    var success: Bool?
    var message: String?
    var contestantInfo  :  [GetALlCategoriesObj]?

    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        contestantInfo <- map["categories"]
        message <- map["message"]

    }
}


class GetSaloonStafObj  : Mappable {
    
    var image: String?
    var staff_name : String?
    var rating : Int?
    var staff_id : Int?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        staff_name <- map["staff_name"]
        rating <- map["rating"]
        staff_id <- map["staff_id"]

    }
    
    
}


class GetALlCategoriesObj  : Mappable {
    
    var category_id: String?
    var category_name : String?
    var image : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        category_id <- map["category_id"]
        category_name <- map["category_name"]
        image <- map["image"]

    }
    
    
}

class GetALlSubCategories : Mappable {
    
    var success: Bool?
    var message: String?
    var subList  :  [GetALlSubCategoriesObj]?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        subList <- map["sub_categories"]
        message <- map["message"]
        
    }
}

class GetALlSubCategoriesObj  : Mappable {
    
    var subcategory_id: String?
    var category_name : String?
    var image : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        subcategory_id <- map["subcategory_id"]
        category_name <- map["category_name"]
        image <- map["image"]
        
    }
    
    
}

class GetAllUserAppointment : Mappable {
    
    var success: Bool?
    var message: String?
    var userAppointment : FullyPaidOrHalf?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        userAppointment <- map["appointments"]

        
    }
}

class FullyPaidOrHalf : Mappable {
    
    var fullInstallments : [UserAppointmentObject]?
    var partialInstallments : [UserAppointmentObject]?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        fullInstallments <- map["fullInstallments"]
        partialInstallments <- map["partialInstallments"]
    }
}


class UserAppointmentObject  : Mappable {
    
    var shop_id : String?
    var shop_image : String?
    var shop_name : String?
    var shopTime : Int?
    var shopType : Int?
    var stuffId : String?
    var stuffNAme : String?
    var userAppointmentService  : AppointmentServicesUser?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        shop_id <- map["shop_id"]
        shop_image <- map["shop_image"]
        shop_name <- map["shop_name"]
        shopTime <- map["time"]
        shopType <- map["type"]
        stuffId  <- map["staff_id"]
        stuffNAme <- map["staff_name"]
        userAppointmentService <- map["services"]
        
    }
    
    
}
class AppointmentServicesUser : Mappable {
    var duration: String?
    var price: String?
    var service_id: String?
    var service_name : String?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        duration <- map["duration"]
        price <- map["service_price"]
        service_id <- map["service_id"]
        service_name <- map["service_name"]
        
    }
    
}


class GetALLFavShop : Mappable {
    
    var success: Bool?
    var message: String?
    var allFavShop  :  [GetALlShopObj]?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        allFavShop <- map["shops"]

    }
}

class GetALlShop : Mappable {
    
    var success: Bool?
    var message: String?
    var allShop  :  [GetALlShopObj]?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        allShop <- map["shops"]
        message <- map["message"]
        
    }
}




class GetALlShopObj  : Mappable {
    
    var distance: String?
    var IsFavorite: Bool?
    var latitude : String?
    var longitude : String?
    var rating : String?
    var shopTime : String?
    var shop_id : Int?
    var shop_image : String?
    var shop_name : String?
    var totalReviews : Int?


    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        distance <- map["distance"]
        IsFavorite <- map["IsFavorite"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        rating <- map["rating"]
        shopTime <- map["shopTime"]
        shop_id <- map["shop_id"]
        shop_image <- map["shop_image"]
        shop_name <- map["shop_name"]
        totalReviews <- map["totalReviews"]


        
    }
    
    
}

class GetShopProduct : Mappable {
    
    var success: Bool?
    var message: String?
    var allShopProduct  :  [GetShopProductObj]?
    
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        allShopProduct <- map["shopProducts"]
        
    }
}

class GetShopProductObj  : Mappable {
    
    var price: Int?
    var productID : Int?
    var productImage : String?
    var productName : String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        price <- map["price"]
        productID <- map["productID"]
        productImage <- map["productImage"]
        productName <- map["productName"]
    }
    
    
}

class UserInformation : Mappable {
    
    var id: Int?
    var name: String?
    var email: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
    }
}

class VoteInfo : Mappable {
    var success: Bool?
    var message  : String?
    var voteInfoObj  :  [VoteInfoObj]?

    

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        voteInfoObj <- map["user"]
        message <- map["message"]
    }
}

class VoteInfoObj : Mappable {
    var idOfModel : String?
    var name: String?
    var profile_pic: String?
    var votes: String?
  
    required init?(map: Map){
        
    }

    func mapping(map: Map) {
        idOfModel <- map["id"]
        name <- map["name"]
        profile_pic <- map["profile_pic"]
        votes <- map["votes"]
    }
    
}


class SocialInfo : Mappable {
    var success: Bool?
    var message  : String?
    var socialInfoObj  : SocialInfoObj?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        socialInfoObj <- map["user"]
        message <- map["message"]
    }
}

class SocialInfoObj : Mappable {
    var facebook: String?
    var google: String?
    var instagram: String?
    var linkedin: String?
    var pinterest: String?
    var twitter: String?
    var watsapp: String?


    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        facebook <- map["facebook"]
        google <- map["google"]
        instagram <- map["instagram"]
        linkedin <- map["linkedin"]
        pinterest <- map["pinterest"]
        twitter <- map["twitter"]
        watsapp <- map["watsapp"]

    }
    
}

class NewsInfo : Mappable {
    var success: Bool?
    var message  : String?
    var newsInfo  : [NewsInfoObject]?
  
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        newsInfo <- map["user "]
        message <- map["message"]

    }
}

class NewsInfoObject : Mappable {
    var id: String?
    var image: String?
    var title: String?
    var descriptionOfNews: String?
    var created_at: String?
    var designation : String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        image <- map["image"]
        title <- map["title"]
        descriptionOfNews <- map["description"]
        created_at <- map["created_at"]
        designation <- map["designation"]
    }
    
}

class Appointment : Mappable {
    var success      : Bool?
    var message      : String?
    var appointmentSchedule     : AppointmentObj?
  
    required init?(map: Map){
    
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        appointmentSchedule <- map["schedule"]
 }
    
}

class AppointmentObj : Mappable  {
    var morning: [MorningObj]?
    var afterNoon: [AfterNoonObj]?
    var evening: [EveningObj]?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        morning <- map["morning"]
        afterNoon <- map["afternoon"]
        evening <- map["evening"]
    }
}

class MorningObj : Mappable {
    var hour: String?
    var isBooked      : Bool?

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        hour <- map["hour"]
        isBooked <- map["isBooked"]

    }
}

class EveningObj : Mappable {
    var hour: String?
    var isBooked      : Bool?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        hour <- map["hour"]
        isBooked <- map["isBooked"]
        
    }
}
class AfterNoonObj : Mappable {
    var hour: String?
    var isBooked      : Bool?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        hour <- map["hour"]
        isBooked <- map["isBooked"]
        
    }
}


class ShopDetail     : Mappable {
    var success      : Bool?
    var message      : String?
    var shopInfo     : ShopDetailObj?
    var services     : [ServicesType]?
    var review       : [ReviewsObject]?
    var timing       : [TimingObject]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        success  <-   map["success"]
        message  <-   map["message"]
        shopInfo <-   map["shopdetails"]
        services <-   map["services"]
        review   <-   map["reviews"]
        timing   <-   map["timing"]

    }
}

class ShopDetailObj : Mappable  {
    var about_us: String?
    var address: String?
    var business_logo: String?
    var city: String?
    var country: String?
    var latitude : String?
    var longitude : String?
    var phone_number : String?
    var rating : Int?
    var shop_image : String?
    var shop_name  : String?
    var state : String?
    var totalReviews : Int?
    var zip_code : String?
    var sliderImage : [SliderImageObject]?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        about_us <- map["about_us"]
        sliderImage <- map["slider_images"]
        address <- map["address"]
        business_logo <- map["business_logo"]
        city <- map["city"]
        country <- map["country"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        phone_number <- map["phone_number"]
        rating <- map["rating"]
        state <- map["state"]
        totalReviews <- map["totalReviews"]
        zip_code <- map["zip_code"]
        shop_name <- map["shop_name"]
        shop_image  <- map["shop_image"]
    }
}

class SliderImageObject: Mappable {
    var imageName: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        imageName <- map["0"]
    }
}

class ServicesType: Mappable {
    var type: String?
    var typeObject: [ServicesObject]?
    
     required init?(map: Map){}
    
    func mapping(map: Map) {
        type <- map["type"]
        typeObject <- map["data"]
    }
}


class ServicesDataObject: Mappable {
    var type: String?
    
    var objects: [ServicesObject]?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        objects <- map["1"]
    }
}



class ServicesObject : Mappable {
    var duration: String?
    var price: Int?
    var service_id: Int?
    var service_name : String?
    required init?(map: Map){
}
    
    func mapping(map: Map) {
        duration <- map["duration"]
        price <- map["price"]
        service_id <- map["service_id"]
        service_name <- map["service_name"]

    }
    
}

class ReviewsObject : Mappable {
    var rating: String?
    var rating_date: String?
    var service_name: String?
    var user_name : String?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        rating <- map["rating"]
        rating_date <- map["rating_date"]
        service_name <- map["service_name"]
        user_name <- map["user_name"]
        
    }
    
}

class TimingObject : Mappable {
    var day: String?
    var time: String?
 
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        day <- map["day"]
        time <- map["time"]
    }
    
}





