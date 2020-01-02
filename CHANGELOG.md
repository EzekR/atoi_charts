## [17.4.40] - 12/17/2019

**Features** 
* Provided support for 100% stacked line, 100% stacked area, 100% stacked column, 100% stacked bar, range area, spline area, and step area chart types.
* Provided support to delay the hiding of trackball and crosshair.
* Provided support to display the tooltip at the pointer location.
* Provided support to calculate the empty points average with a custom implementation.
 
**Breaking changes**
* `borderMode` property in area series has been renamed as `borderDrawMode`.

## [17.3.26] - 11/05/2019

**Bug fixes**
* Data labels are positioned properly and will not collide with the y-axis.
* Now exception will not be thrown while using the chart with tooltip template in the tab widget.

## [17.3.14] - 10/03/2019

**Breaking changes**
* `roundingPlace` property has been changed to `decimalPlaces` in the axis and tooltip.
* `child` property has been changed to `widget` in chart annotation.
* `position` property has been changed to `labelAlignment` in dataLabelSettings.
* `imageUrl` property has been changed to `image` in markerSettings.
* `backgroundImageUrl` property has been changed to `backgroundImage` in SfCartesianChart.
* `initialSelectedDatIndexes` property has been moved to series from SfCartesianChart. 

**Bug fixes**
* Tooltip format with point.y value is working properly now.
* Bar chart with negative values is rendering properly now.

## [1.0.0-beta.5] - 09/17/2019

**Features**
* Stacked line, stacked area, stacked column, stacked bar, range column, pyramid and funnel chart types.
* Logarithmic axis.
* Axis crossing support.
* Plot bands and recursive plot bands support.
* Dynamic data source update animation.

**Bug fixes**
* Tooltip template will not be displayed for hidden series.
* Now the axis interval will be calculated properly for small decimal values.
* Normal range padding is working fine for category axis.
* Few more improvements and bug fixes.

## [1.0.0-beta.4] - 08/29/2019

**Bug fixes**
* Now, the category axis will work properly with additional range padding.
* Now, the column series of category axis with a point can be placed on the ticks.
* Trackball interactive tooltip will be shown only for the visible series.
* On panning with grid lines, the grid lines will be moved within the chart area.
* Panning will work properly on adding or removing the chart series dynamically.
* Now, the data labels will not be hidden on scrolling.
* The circular chart will render at the center position along with the legend.
* Now, the panning is working properly for the inversed axis.
* Now, the data labels appearance can be customized using onDataLabelRender event.
* The tooltip and explode in the circular charts will work together. properly.
* The scatter series is rendering properly with image markers.
* Few more improvements and bug fixes.

## [1.0.0-beta] - 07/16/2019

Initial release.

**Features** 
* Line, spline, area, column, bar, bubble, scatter, step line, fast line, pie, doughnut and radial bar chart types.
* Numeric, category and date time axis types.
* User interactive features like zooming and panning, trackball, crosshair, selection and tooltip.
* Additional features like animation, marker, data label, empty points, legend, annotation and much more.