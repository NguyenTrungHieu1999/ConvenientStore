using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Models.EF;
using PagedList;

namespace Models.GetData
{
    public class NotificationData
    {
        ConvenientStoreDBContext db = null;
        public NotificationData()
        {
            db = new ConvenientStoreDBContext();
        }
        public Notification GetByID(long ID)
        {
            return db.Notifications.Find(ID);
        }
        private static string HtmlToPlainText(string html)
        {
            const string tagWhiteSpace = @"(>|$)(\W|\n|\r)+<";//matches one or more (white space or line breaks) between '>' and '<'
            const string stripFormatting = @"<[^>]*(>|$)";//match any character between '<' and '>', even when end tag is missing
            const string lineBreak = @"<(br|BR)\s{0,1}\/{0,1}>";//matches: <br>,<br/>,<br />,<BR>,<BR/>,<BR />
            var lineBreakRegex = new Regex(lineBreak, RegexOptions.Multiline);
            var stripFormattingRegex = new Regex(stripFormatting, RegexOptions.Multiline);
            var tagWhiteSpaceRegex = new Regex(tagWhiteSpace, RegexOptions.Multiline);

            var text = html;
            //Decode html specific characters
            text = System.Net.WebUtility.HtmlDecode(text);
            //Remove tag whitespace/line breaks
            text = tagWhiteSpaceRegex.Replace(text, "><");
            //Replace <br /> with line breaks
            text = lineBreakRegex.Replace(text, Environment.NewLine);
            //Strip formatting
            text = stripFormattingRegex.Replace(text, string.Empty);

            return text;
        }
        public IEnumerable<Notification> ListAllNotification(string searchString, int page, int pageSize)
        {
            IQueryable<Notification> model = db.Notifications.OrderBy(x => x.CreateDate);
            if (!string.IsNullOrEmpty(searchString))
            {
                searchString = HtmlToPlainText(searchString);
                model = model.Where(x => x.ContentNotification.Contains(searchString));
            }
            return model.OrderBy(x => x.CreateDate).ToPagedList(page, pageSize);
        }
        //
        public List<Notification> ListAllNotification()
        {
            return db.Notifications.Where(x => x.Show == true).OrderBy(x => x.NotiID).ToList();
        }
        //        
        public bool ChangeStatus(long id)
        {
            var notification = db.Notifications.Find(id);
            notification.Show = !notification.Show;
            db.SaveChanges();
            return notification.Show;
        }
        public bool insert(Notification entity)
        {
            try
            {
                db.Notifications.Add(entity);
                db.SaveChanges();
                return true;
            }
            catch(Exception)
            {
                return false;
            }
        }
        public bool update(Notification entity)
        {
            try
            {
                var notification = db.Notifications.Find(entity.NotiID);
                notification.ContentNotification = entity.ContentNotification;
                notification.ModifiedDate = entity.ModifiedDate;
                notification.ModifiedBy = entity.ModifiedBy;
                notification.Show = entity.Show;
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public bool Delete(long ID)
        {
            try
            {
                var notification = db.Notifications.Find(ID);
                db.Notifications.Remove(notification);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
