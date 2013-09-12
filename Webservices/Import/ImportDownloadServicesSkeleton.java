/**
 * ImportDownloadServicesSkeleton.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis2 version: 1.5.1  Built on : Oct 19, 2009 (10:59:00 EDT)
 */
package au.edu.unsw.sltf.services;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.net.InetAddress;
import java.net.URI;

import javax.servlet.http.HttpServletRequest;

import org.apache.axis2.databinding.types.URI.MalformedURIException;

/**
 * ImportDownloadServicesSkeleton java skeleton for the axisService
 */
public class ImportDownloadServicesSkeleton {

	/**
	 * Auto generated method signature
	 * 
	 * @param importMarketData
	 * @throws ImportDownloadFaultException
	 *             :
	 */

	public au.edu.unsw.sltf.services.ImportMarketDataResponse importMarketData(
			au.edu.unsw.sltf.services.ImportMarketData importMarketData)
			throws ImportDownloadFaultException {
		// TODO : fill this with the necessary business logic
		// throw new
		// java.lang.UnsupportedOperationException("Please implement "+
		// this.getClass().getName() + "#importMarketData");
		ImportMarketDataResponse res = new ImportMarketDataResponse();
		String sec = importMarketData.getSec();
		String url = importMarketData.getDataSourceURL().toString();
		Date start = importMarketData.getStartDate();
		Date end = importMarketData.getEndDate();

		DataBase db = new DataBase();
		db.Init();
		List list = new ArrayList();
		CsvReader cr = new CsvReader();
		String eventid = db.GenerateID();

		int tag = 0;

		list = cr.readcsv(url, eventid, sec, start, end);
		if (list.isEmpty()) {
			// show.println("error");
			eventid = "";
		} else {
			tag = db.ExecuteSQL2(list);
			if (tag != 1) {
				// show.println("error");
				eventid = "";
			} else {
				// show.println(eventid);

			}
		}

		db.SQLRelase();

		res.setEventSetId(eventid);
		return res;
	}

	/**
	 * Auto generated method signature
	 * 
	 * @param downloadFile
	 * @throws ImportDownloadFaultException
	 *             :
	 */

	public au.edu.unsw.sltf.services.DownloadFileResponse downloadFile(
			au.edu.unsw.sltf.services.DownloadFile downloadFile)
			throws ImportDownloadFaultException {
		// TODO : fill this with the necessary business logic
		// throw new
		// java.lang.UnsupportedOperationException("Please implement "+
		// this.getClass().getName() + "#downloadFile");
		DownloadFileResponse dfr = new DownloadFileResponse();
		org.apache.axis2.databinding.types.URI url;
		DataBase db = new DataBase();
		db.Init();
		CsvReader cr = new CsvReader();
		String eventid = downloadFile.getEventSetId();
		ResultSet rs = db
				.ExecuteSQL("select count(*) as no from stock where eventid='"
						+ eventid + "'");

		String dataURL = "";

		try {
			rs.next();
			if (Integer.valueOf(rs.getString("no")) > 0) {
				rs = db.ExecuteSQL("select * from stock where eventid='"
						+ eventid + "'");
				// dataURL = request.getScheme() + "://" +
				// request.getServerName() + ":" + request.getServerPort() + "/"
				// + cr.RStoCSV(rs, eventid);
				dataURL = "http://localhost:14080/" + cr.RStoCSV(rs, eventid);
			} else {
				rs = db.ExecuteSQL("select count(*) as no from merge where eventsetid='"
						+ eventid + "'");
				rs.next();
				if (Integer.valueOf(rs.getString("no")) > 0) {
					rs = db.ExecuteSQL("select * from merge where eventsetid='"
							+ eventid + "'");
					rs = db.ExecuteSQL("select * from stock where eventid in('"
							+ rs.getString("eventsetidone") + "','"
							+ rs.getString("eventsetidtwo") + "') order by "
							+ rs.getString("sortby") + "");
					// dataURL = request.getScheme() + "://" +
					// request.getServerName() + ":" + request.getServerPort() +
					// "/" + cr.RStoCSV(rs, eventid);
					dataURL = "http://localhost:14080/" + cr.RStoCSV(rs, eventid);
				}

			}

			url = new org.apache.axis2.databinding.types.URI(dataURL);
			dfr.setDataURL(url);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		db.SQLRelase();
		return dfr;
	}

}
