public class LightningReportsController {
    @AuraEnabled
    public static String getReportResponse() {
        return JSON.serialize(AnalyticsUtils.getTabularReportResponse('00O1a000002VMFU'));
    }

}