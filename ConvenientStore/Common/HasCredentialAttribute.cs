﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common;

namespace ConvenientStore
{
    public class HasCredentialAttribute : AuthorizeAttribute
    {
        public string RoleID { get; set; }
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            //var isAuthorized = base.AuthorizeCore(httpContext);
            //if(!isAuthorized)
            //{
            //    return false;
            //}
            var session = (UserLogin)HttpContext.Current.Session[Common.CommonConstants.USER_SESSION];
            if(session==null)
            {
                return false;
            }
            List<string> privilegeLevels = this.GetCredentialByLoggedInUser(session.userName);
            if (privilegeLevels.Contains(this.RoleID) || session.groupID == CommonConstants.ADMIN_GROUP)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            filterContext.Result = new ViewResult
            {
                ViewName = "~/Areas/Admin/Views/Shared/401.cshtml"
            };
        }
        private List<string> GetCredentialByLoggedInUser(string userName)
        {
            var credentials = (List<string>)HttpContext.Current.Session[Common.CommonConstants.SESSION_CREDENTIALS];
            return credentials;
        }
    }
}