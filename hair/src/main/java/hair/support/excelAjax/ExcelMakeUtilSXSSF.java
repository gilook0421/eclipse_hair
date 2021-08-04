package hair.support.excelAjax;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ExcelMakeUtilSXSSF {

	private static final Logger logger = LoggerFactory.getLogger(ExcelMakeUtilSXSSF.class);
	
	@SuppressWarnings("rawtypes")
	public static void excelMaker(String[] headers, List<?> voDataList, String xlsxFileNm, HttpServletResponse response) throws Exception{
		
		if(voDataList == null || voDataList.size() >= 100000 ) {
			throw new RuntimeException("10만건 이상의 대용량 다운로드는 관리자에게 문의하세요.");
		}

		// 헤더정보 검증
		if(headers == null || headers.length < 1 ) {
			throw new RuntimeException("헤더컬럼명은 필수입니다.");
		}
		
		List<Map<String, String>> headerList = new ArrayList<Map<String, String>>();
		for(String header: headers) {
			Map<String, String> tmpMap = new HashMap<String, String>();
			String[] splitHeader = header.split(":");
			tmpMap.put("title", splitHeader[0]);
			tmpMap.put("colnm", splitHeader[1]);
			tmpMap.put("type", splitHeader[2]);
			headerList.add(tmpMap);
		}
		// --헤더정보 검증
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		SXSSFSheet sheet = (SXSSFSheet)workbook.createSheet("sheet1");
		sheet.setRandomAccessWindowSize(100); // 메모리 행 100개로 제한, 초과 시 disk로 flush.
		
		
		try {
			xlsxFileNm = URLEncoder.encode(xlsxFileNm, "UTF-8");
			sheet.setDefaultColumnWidth((short) 20);
			
			int xIndex = 0;
			int yIndex = 0;
			
			// 헤더 맵핑
			for(Map<String, String> header: headerList) {
				SXSSFCell headerCell = GETCELL(sheet, 0, xIndex);
				headerCell.setCellValue(header.get("title").toString());
				xIndex++;
			}
			
			String voType = "vo";
			
			// 데이터 맵핑
			for(Object vo: voDataList) {
				xIndex = 0;
				
				Class<?> clazz = vo.getClass().getSuperclass();
				if(clazz.getName().equals("java.util.AbstractMap")) {
					voType = "map";
				}
				
				Method[] methods = null;
				if(voType.equals("vo")) {
					methods = vo.getClass().getMethods();
				}
				
				for(Map<String, String> header:headerList) {
					Object curData = null;
					String headerName = header.get("colnm").toString();
					
					if(voType.equals("vo")) {
						for(Method method:methods) {
							if(method.getName().equals("get" + headerName.substring(0, 1).toUpperCase() + headerName.substring(1))) {
								curData = method.invoke(vo);
							}
						}
					}
					else if(voType.equals("map")) {
						curData = ((Map)vo).get(headerName);
					}

					String curStrData = "";
					
					if(curData != null) {
						// cell 설정
						switch(header.get("type").toString()) {
							case "String":
								curStrData = curData.toString();
								SXSSFCell cell = GETCELL(sheet, yIndex, xIndex);
								cell.setCellValue(curStrData);
								break;
							case "Int":
								BigDecimal curBDMData = new BigDecimal("0");
								if(curData instanceof String) {
									curBDMData = new BigDecimal(curData.toString());
								}
								else if(curData instanceof Integer) {
									curBDMData = new BigDecimal((int) curData);
								}
								else if(curData instanceof Long) {
									curBDMData = new BigDecimal((long) curData);
								}
								else {
									curBDMData = (BigDecimal)curData;
								}
								SXSSFCell  intCell = GETCELL(sheet, yIndex, xIndex);
								intCell.setCellValue(curBDMData.doubleValue());
								break;
							case "Money":
								break;
							case "Date":
								break;
							default:
								curStrData = curData.toString();
								SETTEXT(GETCELL(sheet, yIndex, xIndex), curStrData);
						}
					}
					xIndex++;
				}// end of for
				yIndex++;
				
			}// end of for
			
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "attachment: filename=\"" + xlsxFileNm + ".xlsx\"");
			
			ServletOutputStream out = response.getOutputStream();
			workbook.write(out);
			out.flush();
		}
		catch(Exception e) {
			logger.error("엑셀 파일 생성시 오류 : " + e.toString());
		}
		finally {
			
		}
		
	}
	
	
	private static SXSSFCell GETCELL(SXSSFSheet sheet, int row, int col) {
		SXSSFRow sheetRow = (SXSSFRow)sheet.getRow(row);
		if(sheetRow == null) {
			sheetRow = (SXSSFRow) sheet.createRow(row);
		}
		
		SXSSFCell sheetCell = (SXSSFCell) sheetRow.getCell((short)col);
		if(sheetCell == null) {
			sheetCell = (SXSSFCell) sheetRow.createCell((short)col);
		}
		
		return sheetCell;
	}
	

	private static void SETTEXT(SXSSFCell cell, String text) {
		cell.setCellType(1);
		cell.setCellValue(text);
	}
	
}


