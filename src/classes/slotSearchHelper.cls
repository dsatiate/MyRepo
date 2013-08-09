public class slotSearchHelper{

    /*    Description: This function searches the avilable slots based on 
     *                 the site list, the selected product and the date range . Return the list of availble slot.  
     *
     *    Input: 
     *    siteList - List of selected site
     *    selectedProduct - Selected product
     *    
     *    Output:
     *    slot - List of all availble slot                  
     */
    
    public static slot getAvailableSlot(){     
    //public static slot getAvailableSlot(List<site> siteList, Product selectedProduct, DateTime StartDate, DateTime EndDate){
        /*
        Step 1 - Prepare list of practitioner working at the selected sites.
        
        Step 2 - Prepare list of Room available as per the product requirement.
        
        Step 3 - Create a roomEquipmentkey for each of the room from the above list:
                 E.g - 
                 suppose a room is having 3 satic equipments and the site is having 3 mobile equipment
                     static - Gastroscan,Heating pad, Medical glove
                     mobile - Fiberscope(2),Gait belt  
                 the roomEquipmentkey would look like this
                     "Gastroscan-1+Heating pad-1+Medical glove-1+Fiberscope-2+Gait belt-1"   
        
        Step 4 - Filter the rooms based on the product's required equipment(with qantity) presence in the room.
                 E.g - 
                 suppose a product "ABC" needs following equipments
                     Gastroscan,Heating pad,Fiberscope(2)
                 filter the rooms based on
                 if roomEquipmentkey contains  Gastroscan-1 And
                    roomEquipmentkey contains  Heating pad-1 And
                    roomEquipmentkey contains  Fiberscope-2
                 then
                     Add it the suitable room list
                 else
                     reject the room       
        
        Step 5 - using the practitioner list created in the first Step 1 query the diary session object to get the avalability
                 of the practitioner.
                 create solts out of availbaility using beolw formula
                 
                 PractitionerSlots = dairy session / Product duration 
                 
                 And calculate availablePractitionerSlots = PractitionerSlots - booked slots
                 
        Step 6 - simillary, calculate availableRoomSlots
        
        Step 7 - simillary, calculate availableEquipmentSlots    
        
        Step 8 - create a list called masterAvailableSlots and populate it as follows
                 
                 iterate over availablePractitionerSlots list
                     iterate over availableRoomSlots list
                         iterate over availableEquipmentSlots list      
                            if the slotKey of all the above three record is matching
                            then
                                create a new solt record and populate the following field
                                slotKey, practitionerId, siteId, roomId, euipmentId
                                and add the slot to masterAvailableSlots list
                            else 
                                reject the slot
        
        Step 9 - apply date range filter on the masterAvailableSlots 
        */
        return new slot();
    }
}