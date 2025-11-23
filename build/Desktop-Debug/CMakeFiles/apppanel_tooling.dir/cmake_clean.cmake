file(REMOVE_RECURSE
  "panel/Back.png"
  "panel/LineItem.qml"
  "panel/SchedulePage.qml"
  "panel/TestSettingsPage.qml"
  "panel/logo.png"
  "panel/main.qml"
  "panel/pageAjaste.qml"
  "panel/pageAjasteSystem.qml"
  "panel/pageAjasteTime.qml"
  "panel/pageInfo.qml"
  "panel/pageLineEdit.qml"
  "panel/pagePass.qml"
  "panel/pagePassCh.qml"
  "panel/pageStart.qml"
  "panel/pageTest.qml"
  "panel/pageTestEx.qml"
  "panel/pagereserv.qml"
  "panel/password.qml"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/apppanel_tooling.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
