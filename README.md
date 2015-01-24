# Text Thresher Chrome Extension

This is the content repository for the Text Thresher Chrome Extension.

###### Why Text Thresher?

Text Thresher is a web application for researcher-directed crowd annotation of text. It allows researchers to decompose traditional qualitative annotation tasks (often referred to as "hand-coding") so that large jobs can be done by crowd workers with minimal training. Text Thresher also maintains provenance of annotation/labeling so that peer researchers can review crowd work and ensure the validity of crowd annotations. Since all the annotation is digital, labels can be used to create algorithms via machine learning as well.

### Setup

To develop in this repository in your local environment or build the extension.

* Clone the git repository to your local machine.
* Make sure `npm`, `bower`, `node`, and `gulp` are all installed globally on your machine.
* Run `npm install` and `bower install` in the project directory

### Building the Extension

To build the chrome extension so it can be installed in the browser.

* Run `gulp` from the command line which will run both the build assembly and the file watcher tool.

* If you've already installed the extension, refresh your browswer to see your changes.

### Installing the Extension

To install this extension so it will run in your chrome browser.

* Open `chrome://extensions` in your Google Chrome browser and in the top right-hand corner tick the `Developer Mode` checkbox.

* You should now see a box marked `Load Unpacked Extensions`. Click on that and navigate to the top-level project directory and click `Ok`.

* You may see warnings about keyfiles like `foo.pem` being included in the repository. Don't worry--it's not insecure, these are just test files!

* You should now have the extension loaded up in the extensions panel and an icon in your toolbar that will open the popup.

