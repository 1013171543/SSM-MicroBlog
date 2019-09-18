package jkworld.serviceImp;

import com.alibaba.fastjson.JSONObject;
import jkworld.util.ImageCut;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;


@Service(value ="basicFunctionService")
public class BasicFunctionService {

	public void getStringFromStream(HttpServletRequest req, HttpServletResponse response, MultipartFile file) throws IllegalStateException, IOException {
		//获取图片剪裁的[x,y,h,w]
		String parameter = req.getParameter("cropData");
		//将其json
		JSONObject parseObject = JSONObject.parseObject(parameter);
		String x = parseObject.getString("x");
		String y = parseObject.getString("y");
		String w = parseObject.getString("w");
		String h = parseObject.getString("h");

		//获取图片名称
		String originalFilename = file.getOriginalFilename();


		String rootPath = req.getSession().getServletContext().getRealPath("/")+"resources/images/";


		System.out.println("rootpath="+rootPath);

		//存图片
		File photoPath =new File(rootPath+originalFilename);
		file.transferTo(photoPath);



		//修改图片名称  uuid.xxx
		int imageX = Double.valueOf(x).intValue();
        int imageY = Double.valueOf(y).intValue();
        int imageH = Double.valueOf(h).intValue();
        int imageW = Double.valueOf(w).intValue();
        //这里开始截取操作
        //返回剪裁后的图片路径
        String newFileName = ImageCut.imgCut(rootPath+originalFilename,imageX,imageY,imageW,imageH,rootPath);

		System.out.println("newFileName="+newFileName);
        //存入json
        parseObject.put("imgName",newFileName);

		System.out.println("imgName="+newFileName);
        response.getWriter().print(parseObject);

        //上传完毕删除原图
        boolean delete = photoPath.delete();
	}

}
