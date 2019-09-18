package jkworld.service;

import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Demo TabService
 *
 * @author root
 * @date 2019/9/10
 */
public interface TabService {
    ModelAndView getAllTabs();

    ModelAndView getByTabNameEn(String type);

}
