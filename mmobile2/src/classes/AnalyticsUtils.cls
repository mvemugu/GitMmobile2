public with sharing class AnalyticsUtils {
	
	
	public static tabularReportResponse getTabularReportResponse(Id reportId) {
		tabularReportResponse trr = new tabularReportResponse();
		List<fieldDef> reportFields = new List<fieldDef>();	
		List<List<fieldData>> fieldDataList = new List<List<fieldData>>();	
		
        //get the report result
    	Reports.ReportResults results = Reports.ReportManager.runReport('00O1a000002VMFU', true);
        
		//get the metadata
		Reports.ReportMetadata reportMetadata = results.getReportMetadata();

		//get a string array of the field names
		List<String> fieldNames = reportMetadata.getDetailColumns();		
		
		//get the extended metadata
		Reports.ReportExtendedMetadata reportExtendedMetadata = results.getReportExtendedMetadata();

		//get the map of the column names to their name and label
		Map<String, Reports.DetailColumn> detailColumnMap = reportExtendedMetadata.getDetailColumnInfo();
		
	
		//loop over the detailColumnMap and get the name, label, and data type
		for (String fieldName: fieldNames) {
			Reports.DetailColumn detailColumn = detailColumnMap.get(fieldName);
			fieldDef fd = new fieldDef();
			fd.fieldName = detailColumn.getName(); 
			fd.fieldLabel = detailColumn.getLabel();
			fd.dataType = detailColumn.getDataType().name();
			reportFields.add(fd);
		}
		
		
		// Get the fact map from the report results
		Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails)results.getFactMap().get('T!T');		
		
		List<Reports.ReportDetailRow> reportDetailRowList = factDetails.getRows();
		
		//loop over the rows
		for (Reports.ReportDetailRow reportDetailRow: reportDetailRowList) {
			Integer cellCounter = 0;
			List<fieldData> fieldDataRow = new List<fieldData>();
			//loop over the cells in the row
			for (Reports.ReportDataCell reportDataCell: reportDetailRow.getDataCells()) {
				fieldData fd = new fieldData();
				fd.fieldValue = (String)reportDataCell.getValue();
				fd.fieldLabel = (String)reportDataCell.getLabel();
				fd.dataType = reportFields[cellCounter].dataType;
				fd.isHyperLink = isHyperlink(fd.fieldValue);
				cellCounter++;
				fieldDataRow.add(fd);
			}
			
			//add the row to the list
			fieldDataList.add(fieldDataRow);
		}

		trr.reportFields = reportFields;
		trr.fieldDataList = fieldDataList;		
       // system.debug('trrr==' + trr);
        return trr;
	}	
	
	
	
	
	public static Boolean isHyperlink(String sVal) {
		Boolean isHyperLink = true;
		Id theId;
		try {theId = (Id)sVal;}
		catch (Exception e) {isHyperLink = false;}
		return isHyperLink;
	}	
	
	
		

	
	public class tabularReportResponse {
		public List<fieldDef> reportFields {get; set;}
		public List<List<fieldData>> fieldDataList {get; set;}
		public tabularReportResponse(){}
	}
	
	public class fieldDef {
		public String fieldName {get; set;}
		public String fieldLabel {get; set;}
		public String dataType {get; set;}
		public fieldDef(){}
	}

	public class fieldData {
		public String fieldValue {get; set;}
		public String fieldLabel {get; set;}
		public String dataType  {get; set;}
		public Boolean isHyperLink {get; set;}			
		public fieldData(){isHyperLink=false;}
	}	
		
	
}