package com.lingdu.common.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.lingdu.common.util.ConfigUtil;


@WebListener
public class InitListener implements ServletContextListener {

    public InitListener() {
    }

    public void contextInitialized(ServletContextEvent evnet)  { 
    	
    	evnet.getServletContext().setAttribute("path", ConfigUtil.get("path"));
    }

    public void contextDestroyed(ServletContextEvent evnet)  { 
    }
	
}
