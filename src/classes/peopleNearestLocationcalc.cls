public class peopleNearestLocationcalc {
    public static void getlocation(List<People__c> people)
    {
        list<People__c> finListafterUpdate = new list<People__c>();
        list<People__c> peoplList = new list<People__c>();
        list<People__c> finalpeoplList = new list<People__c>();
        map<people__c,Drive_Location__mdt> singleloc = new map<people__c,Drive_Location__mdt>();
        map<people__c,Drive_Location__mdt> people_mindis = new map<people__c,Drive_Location__mdt>();
        for(People__c lc:people){
            peoplList.add(lc);
        }
        list<Drive_Location__mdt> listq = new list<Drive_Location__mdt>([select Location__c,Longitude__c,Latitude__c FROM Drive_Location__mdt]);
        for(People__c lc:peoplList){
            system.debug('lc>>>>'+lc);
            Map<Drive_Location__mdt,Decimal> samplevalues = new Map<Drive_Location__mdt,Decimal>();
            Map<Decimal,Drive_Location__mdt> disCoordinates = new Map<Decimal,Drive_Location__mdt>(); // min distnace , coordinates
            for(Drive_Location__mdt ss:listq){
                system.debug('ss>>>>'+ss);
                Decimal longitude1 = decimal.ValueOf(lc.Longitude__c);
                Decimal latitude1 = decimal.ValueOf(lc.Latitude__c);
                System.debug('Long 1 :'+lc.Longitude__c);
                System.debug('Latitude 1 :'+lc.Latitude__c);
                System.debug('Long 2 :'+ss.Longitude__c);
                System.debug('Latitude 2 :'+ss.Latitude__c);
                System.debug('Drive Name'+ss.Location__c);
                if(lc.Name <> null)
                { Decimal distance = 0;
                 distance = calculateDistance(latitude1,longitude1,ss.Latitude__c,ss.Longitude__c);
                 samplevalues.put(ss,distance);
                 System.debug('result1'+samplevalues.values());
                 //Maintain distance , location and coordinates
                 disCoordinates.put(distance,ss);
                 Decimal leastdistance = calculateleastdistance(samplevalues);
                 system.debug('least distance coordinates...'+disCoordinates.get(leastdistance));
                    //get the coordinates of least distance
                 people_mindis.put(lc,disCoordinates.get(leastdistance));
                    //person and location
                 system.debug('per person min distance is'+ people_mindis);
                 system.debug('samplevalues value is'+leastdistance);
                 lc.Distance__c = leastdistance.setScale(2);
                 lc.Drive_Location__c = disCoordinates.get(leastdistance).Location__c;
                 system.debug('final drive distance'+ lc.Distance__c);
                 system.debug('final drive location'+ lc.Drive_Location__c);
                }
            }
        }
    }
    public static Decimal calculateDistance(Decimal lat1, Decimal lon1, Decimal lat2, Decimal lon2){
        Double Radius = 6371.00;
        Double dLat = toRadians(lat2 - lat1);
        Double dLon = toRadians(lon2 - lon1);
        Double a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) *
        Math.sin(dLon/2) * Math.sin(dLon/2);
        Double c = 2 * Math.asin(Math.sqrt(a));
        System.debug('Distance to drive'+Radius * c * .62);
        return Radius * c * .62;
    }
    private static Double toRadians(Decimal degree){
        Double res = degree * 3.1415926 / 180;
        return res;
    }
    //logic to calculate distnce and find for the nearest drive location
    public static Decimal calculateleastdistance(Map<Drive_Location__mdt,Decimal> samplevaluesMap){
        List<Decimal> samplevalues = samplevaluesMap.values();
        Decimal minvalue = samplevalues[0];
        For (integer i =0;i<samplevalues.size();i++)
        {
            if( samplevalues[i] < minvalue)
            {
                minvalue = samplevalues[i];
            }
            system.debug('the min value is'+minvalue);
        }
            return minvalue;
    }
    
}