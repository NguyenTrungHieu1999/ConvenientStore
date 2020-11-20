using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ConvenientStore.Common
{
    [Serializable]
    public class UserChangePassword
    {
        public long userID { get; set; }
        public string securityCode { get; set; }
    }
}