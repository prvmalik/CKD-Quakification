rm(list = ls())
library(ospsuite.reportingengine)
workingDirectory <- getwd()
reInputFolder <- file.path(workingDirectory, "re_input")
reOutputFolder <- file.path(workingDirectory, "re_output")
configurationPlanName <- "report-configuration-plan"
configurationPlanFile <- file.path(reInputFolder, paste0(configurationPlanName, ".json"))
recordWorkflowTime <- TRUE
workflow <- loadQualificationWorkflow(
  workflowFolder = reOutputFolder,
  configurationPlanFile = configurationPlanFile
)

#' Remove watermark
workflow$setWatermark("")

workflow$inactivateTasks("simulate")
workflow$activateTasks("plotTimeProfiles")
workflow$inactivateTasks("calculatePKParameters")
workflow$inactivateTasks("plotDDIRatio")
workflow$activateTasks("plotComparisonTimeProfile")

tictoc::tic()
workflow$runWorkflow()
tictoc::toc()

