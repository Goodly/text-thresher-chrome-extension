# Text Thresher Chrome Extension

This is the content repository for the Text Thresher Chrome Extension.

###### Why Text Thresher?

Text Thresher is a web application for researcher-directed crowd annotation of text. It allows researchers to decompose traditional qualitative annotation tasks (often referred to as "hand-coding") so that large jobs can be done by crowd workers with minimal training. Text Thresher also maintains provenance of annotation/labeling so that peer researchers can review crowd work and ensure the validity of crowd annotations. Since all the annotation is digital, labels can be used to create algorithms via machine learning as well.

### Setup

To setup this extension for development in your local environment.

* Clone the git repository to your local machine.
* Open `chrome://extensions` in your Google Chrome browser and in the top right-hand corner tick the `Developer Mode` checkbox.
* You should now see a box marked `Load Unpacked Extensions`. Click on that and navigate to the project directory and click `Ok`.
* You should now have the extension loaded up in the extensions panel and an icon in your toolbar that will open the popup.

### Development

To develop in this repository.

* Run `npm install` and `bower install` in the project directory
* Run `gulp` from the command line which will run both the file watcher and the build assembly too.
* For the time being, touch either `bundle.jsx` or `vendor.coffee` to kick off a new build for the popup.
* Refresh your browswer to see your changes.
