package jkworld.serviceImp;

import com.alibaba.fastjson.JSONObject;
import jkworld.service.VerificationService;
import jkworld.util.HttpUtils;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service(value="verificationServiceImp")
public class VerificationServiceImp implements VerificationService {

	private HttpSession session;
	
	//图片的宽度
	public static final int WIDTH = 120;
	//图片的高度
	public static final int HEIGHT = 35;
	//创建一个字符串缓冲区，用于存储随机产生的字符
	private StringBuffer sb = new StringBuffer();
	
	
	//创建短信验证码
	@Override
	public void verificatePhoneToken(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		
		String host = "https://chanyoo.market.alicloudapi.com";
        String path = "/sendsms";
        String method = "GET";
        String appcode = "your appcode";
        Map<String, String> headers = new HashMap<String, String>();
        headers.put("Authorization", "APPCODE " + appcode);
        Map<String, String> querys = new HashMap<String, String>();
        
        //获取客户端输入的手机号
        String tel = request.getParameter("tel");
        
        //发送手机验证码
        querys.put("mobile",tel);
        //产生一个随机数
		String phoneToken = (int)((Math.random()*9+1)*100000)+"";
		
		//将随机数存入session域中
        session = request.getSession();
        session.setAttribute("phoneToken",phoneToken);

		
		querys.put("content", "您的手机号："+tel+"，验证码："+phoneToken+"，请及时完成验证，如不是本人操作请忽略。【阿里云市场】");

        try {
            HttpResponse response = HttpUtils.doGet(host, path, method, headers, querys);
            System.out.println(response.toString());
            //获取response的body
            System.out.println(EntityUtils.toString(response.getEntity()));
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	//创建图片验证码
	@Override
	public void verificateImgToken(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		sb.delete(0, sb.length());
		
		BufferedImage bufferedImage = new BufferedImage(WIDTH, HEIGHT,BufferedImage.TYPE_INT_RGB);
		
		Graphics graphics = bufferedImage.getGraphics();
		
		//设置背景颜色
		setBackgroundColor(graphics);
		//设置边框
		dropBorder(graphics);
		
		//画干扰线
		dropLine(graphics);
		//写入验证码
		writeWord((Graphics2D)graphics);
		
		//设置发送数据
		response.setContentType("image/jpeg");
		response.setDateHeader("expries", -1);
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
	
		try {
			ImageIO.write(bufferedImage, "jpg", response.getOutputStream());
			response.getOutputStream().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//将图片验证码存入session域中
		session = request.getSession();
		session.setAttribute("imgToken", sb.toString());
		
	}
	
	private void writeWord(Graphics2D graphics) {
		// TODO Auto-generated method stub
		
		graphics.setColor(Color.RED);
		
		int x = 5;
		graphics.setFont(new Font("宋体", Font.BOLD, 20));
		String base ="qwertyuiopasdfghjklzxcvbnm1234567890";
		for(int a =0;a <4;a++)
		{
			String word = base.charAt(new Random().nextInt(base.length()))+"";
			//设置要旋转的角度变量
			int degree = new Random().nextInt()%30;
	
			//设置字符旋转
			graphics.rotate(degree*Math.PI/180, x, 20);
			graphics.drawString(word, x, 20);
			//回调字符旋转
			graphics.rotate(-degree*Math.PI/180, x, 20);
			//添加到缓冲区
			sb.append(word);
			//每次移动25个像素
			x+=25;
		}
	}

	private void dropLine(Graphics graphics) {
		// TODO Auto-generated method stub
		graphics.setColor(Color.GREEN);
		
		for(int a =0;a < 5;a++)
		{
			int x1 = new Random().nextInt(WIDTH);
			int y1 = new Random().nextInt(HEIGHT);
			int x2 = new Random().nextInt(WIDTH);
			int y2 = new Random().nextInt(HEIGHT);
			
			graphics.drawLine(x1, y1, x2, y2);
		}
	}

	private void setBackgroundColor(Graphics graphics) {
		// TODO Auto-generated method stub
		//设置颜色
		graphics.setColor(Color.WHITE);
				
		graphics.fillRect(0, 0, WIDTH, HEIGHT);
	}

	private void dropBorder(Graphics graphics) {
		// TODO Auto-generated method stub
		
		graphics.setColor(Color.BLACK);
		graphics.drawRect(0, 0, WIDTH-1,HEIGHT-1);

	}

	@Override
	public boolean checkImgToken(HttpServletRequest request,
                                 HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String serverImgToken = (String)session.getAttribute("imgToken");
		System.out.println("serverImgToken........"+serverImgToken);
		String clientImgToken = request.getParameter("imgToken");
		System.out.println("clientImgToken........"+clientImgToken);
		
		if(!clientImgToken.equals(serverImgToken)){
			//如果输入的验证码与服务端产生的验证码不一致，返回0
			JSONObject json = new JSONObject();
			json.put("tokenState","0");
			response.getWriter().print(json);
			return false;
		}else{
			JSONObject json = new JSONObject();
			json.put("tokenState","1");
			response.getWriter().print(json);
			return true;
		}
	}
	
}
