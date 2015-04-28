import gulp from 'gulp'
import gutil from 'gulp-util'
import del from 'del'
import plumber from 'gulp-plumber'
import webpack from 'webpack'
import webpackdevserver from 'webpack-dev-server'

let paths = {
  assets: [
    './src/**/*.{html,png}', '!./src/vendor/**/*.{html,png}'
  ],
  scripts: [

  ]
}

gulp.task('default', ['build', 'watch'], () => {});

gulp.task('build', ['assets:copy', 'webpack:build', 'js:copy', 'coffee:compile'], () => {});

gulp.task('clean', (callback) => {
  del(['dist/**'], callback);
});

gulp.task('watch', () => {
  console.log('watch');
});
