# img-upload

img-upload is a Bootstrap/jQuery plugin which shows a preview of the image to be uploaded.
Images can be uploaded both from file or URL.

## Demo

http://egonolieux.github.io/img-upload/

## Dependencies

- Bootstrap 3.x
- jQuery 1.4+

## How it works

### HTML

Place this in your HTML wherever you need img-upload.

```HTML
<div class="panel panel-default img-upload">
    <div class="panel-heading">
        <ul class="nav nav-pills">
            <li class="img-file-btn active">
                <a href="javascript:;">File</a>
            </li>
            <li class="img-url-btn">
                <a href="javascript:;">URL</a>
            </li>
        </ul>
    </div>
    <div class="panel-body img-file-tab">
        <div>
            <span class="btn btn-default btn-file img-select-btn">
                <span>Browse</span>
                 <!-- The file is stored here. -->
                <input type="file" name="img-file-input">
            </span>
            <span class="btn btn-default img-remove-btn">Remove</span>
        </div>
    </div>
    <div class="panel-body img-url-tab">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="http://example.com/image.jpg">
            <span class="input-group-btn">
                <span class="btn btn-default img-select-btn">Submit</span>
            </span>
        </div>
        <!-- The URL is stored here. -->
        <input type="hidden" name="img-url-input">
    </div>
</div>
```

The input with name attribute ```img-file-input``` contains the image file.
The input with name attribute ```img-url-input``` contains the image URL.

### jQuery

#### Using Default Options

When using default options, allowed formats are ```jpg```, ```png``` and ```gif```.

```jQuery
$('img-upload').imgUpload();
```

#### Allow Specific Formats Only

```jQuery
$('img-upload').imgUpload(
{
    allowedFormats: [ "jpg" ]
});

```
