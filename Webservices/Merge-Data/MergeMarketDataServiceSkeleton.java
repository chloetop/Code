/**
 * MergeMarketDataServiceSkeleton.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis2 version: 1.5.1  Built on : Oct 19, 2009 (10:59:00 EDT)
 */
package au.edu.unsw.sltf.services;

import java.sql.ResultSet;

/**
 * MergeMarketDataServiceSkeleton java skeleton for the axisService
 */
public class MergeMarketDataServiceSkeleton {

	/**
	 * Auto generated method signature
	 * 
	 * @param mergeMarketData
	 * @throws MergeMarketDataFaultException
	 *             :
	 */

	public au.edu.unsw.sltf.services.MergeMarketDataResponse mergeMarketData(
			au.edu.unsw.sltf.services.MergeMarketData mergeMarketData)
			throws MergeMarketDataFaultException {
		// TODO : fill this with the necessary business logic
		// throw new
		// java.lang.UnsupportedOperationException("Please implement "+
		// this.getClass().getName() + "#mergeMarketData");
		MergeMarketDataResponse mdr = new MergeMarketDataResponse();
		String eventSetIdOne = mergeMarketData.getEventSetIdOne();
		String eventSetIdTwo = mergeMarketData.getEventSetIdTwo();
		String Options = mergeMarketData.getOptions();

		DataBase db = new DataBase();
		db.Init();
		String eventSetId = db.GenerateID();

		if (eventSetIdOne.equals(eventSetIdTwo))
			eventSetId = "";
		ResultSet rs = db
				.ExecuteSQL("select count(*) as no from stock where eventid='"
						+ eventSetIdOne + "'");
		// DataBase db1=new DataBase();
		int tag = 0;
		int row = 0;
		try {
			rs.next();
			if (Integer.valueOf(rs.getString("no")) > 0) {

				rs = db.ExecuteSQL("select count(*) as no from stock where eventid='"
						+ eventSetIdTwo + "'");

				rs.next();

				if (Integer.valueOf(rs.getString("no")) > 0) {

					tag = db.ExecuteSQL2("insert into merge values('"
							+ eventSetId + "','" + Options + "','"
							+ eventSetIdOne + "','" + eventSetIdTwo + "')");
					if (tag == 0) {
						eventSetId="";
					}
				} else {
					eventSetId = "";
				}
			} else {
				eventSetId = "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		db.SQLRelase();
		mdr.setEventSetId(eventSetId);
		return mdr;
	}

}
