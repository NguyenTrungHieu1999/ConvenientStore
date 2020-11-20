var comment = {
    init: function () {
        comment.registerEvent();
    },
    registerEvent: function () {
        $('#send').off('click').on('click', function () {
            var productid = $('#clsProductID').val();
            var parentid = $('#clsParentID').val();
            var commentcontent = $('#clsCommentContent').val();
            var userid = $('#clsUserID').val();
            var bl = { UserID: userid, ProductID: productid, ParentID: parentid, CommentContent: commentcontent };
            $.ajax({
                url: '/Product/ProductComment',
                data: {
                    strCmt: JSON.stringify(bl)
                },
                type: 'POST',
                dataType: 'json',
                success: function (res) {
                    if (res.status == true) {
                        alert("Bình Luận Thành Công");
                    }
                }
            });
        });
    },
};
comment.init();