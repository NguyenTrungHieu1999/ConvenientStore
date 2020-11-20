using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ConvenientStore
{
    [Serializable]
    public class UserLogin
    {
        public long userID { get; set; }
        public string userName { get; set; }
        public string groupID { get; set; }
        public string name { get; set; }
    }
}