@isTest
public class sf1Tab_ViewTrips_Test {
	@isTest
        public static void ShowTrips() {
            sf1Tab_ViewTrips vt = new sf1Tab_ViewTrips();
            System.debug(vt.currentTrips);
            System.debug(vt.pastTrips);
        }
}