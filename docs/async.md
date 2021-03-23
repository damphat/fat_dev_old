## future
- code của future được run ngay, vì thế không catchError ngay có thể gây lỗi
- code của stream được run khi listen

```
    test('will faile', () {
        var future = Future.error();
    })
```

- Future.error('err') có ngừng một event loop? chỉ ngừng zone?