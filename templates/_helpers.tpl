{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "generic-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "generic-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "generic-chart.labels" -}}
app: {{ include "generic-chart.name" . }}
helm.sh/chart: {{ include "generic-chart.chart" . }}
release: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}

{{/*
Create default route host depending on `.Chart.Name`, `.Release.Name`
and `.Values.ingress.zone` ("ch" or "shared")
*/}}
  {{- define "generic-chart.host" -}}
    {{- if .Values.ingress.zone -}}
    {{- $base := .Release.Name | trunc 63 | trimSuffix "-" -}}
    {{- $isProd := hasSuffix "-prod" .Release.Name -}}
    {{- $prefix := .Values.ingress.zone | default "" | regexFind "^(ch)|(sh)" | required "A valid .Values.ingress.zone is required when using default host!" -}}
    {{- $suffix := $isProd | ternary "" "-test" -}}
    {{- printf "%s.%sapp%s.os1.balgroupit.com" $base $prefix $suffix -}}
  {{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "generic-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{ default (include "generic-chart.name" .) .Values.serviceAccount.name }}
{{- else -}}
{{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
