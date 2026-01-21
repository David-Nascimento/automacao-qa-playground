#!/bin/bash

ALLURE_RESULTS="reports/allure-results"
ALLURE_REPORT="reports/allure-report"
HISTORY_DIR="$ALLURE_REPORT/history"

if [ -d "$HISTORY_DIR" ]; then
  echo "📊 Copiando histórico do Allure..."
  mkdir -p "$ALLURE_RESULTS/history"
  cp -R "$HISTORY_DIR"/* "$ALLURE_RESULTS/history/"
else
  echo "ℹ️ Nenhum histórico anterior encontrado."
fi
