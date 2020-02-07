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
app.kubernetes.io/name: {{ include "generic-chart.name" . }}
helm.sh/chart: {{ include "generic-chart.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create default route host depending on `.Chart.Name`, `.Release.Name`
and `.Values.route.zone` ("ch" or "shared")
*/}}
{{- define "generic-chart.host.default" -}}
{{- $base := printf "%s-%s" .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- $isProd := ne (regexFind "-prod$" .Release.Name) "" -}}
{{- $prefix := regexFind "^(ch)|(sh)" .Values.route.zone -}}
{{- $suffix := $isProd | ternary "" "-test" -}}
{{- printf "%s.%sapp%s.os1.balgroupit.com" $base (required "A valid .Values.route.zone is required when using default host!" $prefix) $suffix -}}
{{- end -}}
