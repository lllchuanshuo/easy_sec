package com.easykoo.web.controller;

import com.easykoo.mybatis.model.Account;
import com.easykoo.mybatis.model.DataTablesResponse;
import com.easykoo.mybatis.model.Feedback;
import com.easykoo.mybatis.model.Subscribe;
import com.easykoo.service.IAccountService;
import com.easykoo.service.IAccountSessionService;
import com.easykoo.service.IFeedbackService;
import com.easykoo.service.ISubscribeService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Locale;

/**
 * Feb 22, 2014    Steven
 */

@Controller
@RequestMapping("/ajax")
public class AjaxController {
    protected final Log logger = LogFactory.getLog(getClass());
    private IAccountSessionService accountSessionService;
    private IAccountService accountService;
    private IFeedbackService feedbackService;
    private ISubscribeService subscribeService;
    private MessageSource messageSource;

    @ResponseBody
    @RequestMapping(value = "/allAccount.do", produces = "application/json")
    public DataTablesResponse showUser(@RequestParam int iDisplayStart, @RequestParam int iDisplayLength, @RequestParam int iSortCol_0, @RequestParam String sSortDir_0, HttpServletRequest request) {
        DataTablesResponse<Account> dt = new DataTablesResponse();

        Account account = new Account();
        account.setPageActived(true);
        account.setPageSize(iDisplayLength);
        account.setDisplayStart(iDisplayStart);
        String sortColumn = request.getParameter("mDataProp_" + iSortCol_0);
        account.addSortProperties(sortColumn, sSortDir_0);
        List<Account> accountList = accountService.findAccountWithPage(account);

        dt.setData(accountList);
        dt.setTotalDisplayRecords(account.getTotalRecord());
        dt.setTotalRecords(account.getTotalRecord());
        return dt;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteAccount.do", produces = "application/json")
    public String deleteAccount(@RequestParam(value = "accountId") int accountId) {
        Account dbAccount = accountService.selectByPrimaryKey(accountId);
        if (dbAccount != null) {
            accountService.deleteByPrimaryKey(accountId);
            return "true";
        }
        return "{\"error\":\"no user\"}";
    }

    @ResponseBody
    @RequestMapping(value = "/banAccount.do", produces = "application/json")
    public String banAccount(@RequestParam(value = "accountId") int accountId) {
        Account dbAccount = accountService.selectByPrimaryKey(accountId);
        if (dbAccount != null) {
            dbAccount.setLocked(true);
            accountService.updateByPrimaryKey(dbAccount);
            return "true";
        }
        return "{\"error\":\"no user\"}";
    }

    @ResponseBody
    @RequestMapping(value = "/unbanAccount.do", produces = "application/json")
    public String unbanAccount(@RequestParam(value = "accountId") int accountId) {
        Account dbAccount = accountService.selectByPrimaryKey(accountId);
        if (dbAccount != null) {
            dbAccount.setLocked(false);
            accountService.updateByPrimaryKey(dbAccount);
            return "true";
        }
        return "{\"error\":\"no user\"}";
    }

    @ResponseBody
    @RequestMapping(value = "/adminAccount.do", produces = "application/json")
    public String adminAccount(@RequestParam(value = "accountId") int accountId) {
        Account dbAccount = accountService.selectByPrimaryKey(accountId);
        if (dbAccount != null) {
            dbAccount.setRoleId(1);
            accountService.updateByPrimaryKey(dbAccount);
            return "true";
        }
        return "{\"error\":\"no user\"}";
    }

    @ResponseBody
    @RequestMapping(value = "/addFeedback.do")
    public String addFeedback(@ModelAttribute("feedback") Feedback feedback) {
        feedbackService.insert(feedback);
        return "true";
    }

    @ResponseBody
    @RequestMapping(value = "/readFeedback.do")
    public String readFeedback(@RequestParam(value = "id") int id) {
        Feedback feedback = feedbackService.selectByPrimaryKey(id);
        feedback.setViewed(true);
        feedbackService.updateByPrimaryKey(feedback);
        return "true";
    }

    @ResponseBody
    @RequestMapping(value = "/getFeedbackCount.do")
    public int getFeedbackCount() {
        return feedbackService.getUnreadFeedbackCount();
    }

    @ResponseBody
    @RequestMapping(value = "/getTop5Feedback.do")
    public List<Feedback> getTop5Feedback() {
        return feedbackService.getTop5Feedback();
    }

    @RequestMapping(value = "/deleteFeedback.do", produces = "application/json")
    public
    @ResponseBody
    String deleteFeedback(@RequestParam(value = "id") int id) {
        Feedback feedback = feedbackService.selectByPrimaryKey(id);
        if (feedback != null) {
            feedbackService.deleteByPrimaryKey(id);
            return "true";
        }
        return "{\"error\":\"Feedback doesn't exist!\"}";
    }


    @ResponseBody
    @RequestMapping(value = "/subscribe.do", produces = "application/json")
    public String subscribe(@ModelAttribute("subscribe") Subscribe subscribe) {
        try {
            subscribeService.insert(subscribe);
        } catch (DuplicateKeyException e) {
            logger.error(e);
            return "{\"error\":\"Already\"}";
        }
        return "true";
    }

    @ResponseBody
    @RequestMapping(value = "/checkUsername.do", produces = "application/json")
    public String checkUsername(@RequestParam("username") String username, Locale locale) {
        if (accountService.checkUsername(username)) {
            return messageSource.getMessage("message.error.already.exists", null, locale);
        }
        return "true";
    }

    @ResponseBody
    @RequestMapping(value = "/checkEmail.do", produces = "application/json")
    public String checkEmail(@RequestParam("email") String email, Locale locale) {
        if (accountService.checkEmail(email)) {
            return messageSource.getMessage("message.error.already.exists", null, locale);
        }
        return "true";
    }

    @ResponseBody
    @RequestMapping("/checkVerifyCode.do")
    public String checkVerifyCode(@RequestParam("verifyCode") String verifyCode, HttpServletRequest request, Locale locale) throws IOException {
        String currentVerifyCode = (String) request.getSession().getAttribute("currentVerifyCode");
        if (currentVerifyCode != null && currentVerifyCode.equals(verifyCode)) {
            return "true";
        }
        return messageSource.getMessage("message.error.wrong.verify.code", null, locale);
    }

    @ResponseBody
    @RequestMapping(value = "/allFeedback.do", produces = "application/json")
    public DataTablesResponse allFeedback(@RequestParam int iDisplayStart, @RequestParam int iDisplayLength, @RequestParam int iSortCol_0, @RequestParam String sSortDir_0, HttpServletRequest request) {
        DataTablesResponse<Feedback> dt = new DataTablesResponse();

        Feedback feedback = new Feedback();
        feedback.setPageActived(true);
        feedback.setPageSize(iDisplayLength);
        feedback.setDisplayStart(iDisplayStart);
        String sortColumn = request.getParameter("mDataProp_" + iSortCol_0);
        feedback.addSortProperties(sortColumn, sSortDir_0);
        List<Feedback> feedbackList = feedbackService.findFeedbackWithPage(feedback);

        dt.setData(feedbackList);
        dt.setTotalDisplayRecords(feedback.getTotalRecord());
        dt.setTotalRecords(feedback.getTotalRecord());
        return dt;
    }

    public MessageSource getMessageSource() {
        return messageSource;
    }

    @Autowired
    public void setMessageSource(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    public IAccountService getAccountService() {
        return accountService;
    }

    @Autowired
    public void setAccountService(IAccountService accountService) {
        this.accountService = accountService;
    }

    public IAccountSessionService getAccountSessionService() {
        return accountSessionService;
    }

    @Autowired
    public void setAccountSessionService(IAccountSessionService accountSessionService) {
        this.accountSessionService = accountSessionService;
    }

    public IFeedbackService getFeedbackService() {
        return feedbackService;
    }

    @Autowired
    public void setFeedbackService(IFeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    public ISubscribeService getSubscribeService() {
        return subscribeService;
    }

    @Autowired
    public void setSubscribeService(ISubscribeService subscribeService) {
        this.subscribeService = subscribeService;
    }
}
