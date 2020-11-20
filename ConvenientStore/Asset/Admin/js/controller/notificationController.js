var notification = {
    init: function () {
        notification.registerEvents();
    },
    registerEvents: function () {
        $('.btn-notiactive').off('click').on('click', function (e) {
            e.preventDefault();
            var btn = $(this);
            var id = btn.data('id');
            $.ajax({
                url: "/Admin/Notification/ChangeStatus",
                data: { id: id },
                dataType: "json",
                type: "POST",
                success: function (response) {
                    console.log(response);
                    if (response.status == true) {
                        btn.text('Hiển thị');
                    }
                    else {
                        btn.text('Ẩn');
                    }
                }
            });
        });
    }
}
notification.init();