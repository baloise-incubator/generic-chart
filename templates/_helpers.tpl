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
release: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}

{{/*
Define external secret name.
*/}}
{{- define "generic-chart.externalSecretName" -}}
    {{- default ( include "generic-chart.name" . ) .Values.externalSecret.overrideName -}}
{{- end -}}

{{/*
Create default route host depending on `.Chart.Name`, `.Release.Name`
and `.Values.ingress.clusterName` ("caasd01" or "caast01" or "caasp01")
*/}}
  {{- define "generic-chart.host" -}}
    {{- if .Values.ingress.clusterName -}}
    {{- $base := .Release.Name | trunc 63 | trimSuffix "-" -}}
    {{- $clusterName := .Values.ingress.clusterName | default "" | regexFind "^(caasd01)|(caast01)|(caasp01)" | required "A valid .Values.ingress.clusterName is required when using default host!" -}}
    {{- printf "%s.apps.%s.balgroupit.com" $base $clusterName -}}
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


{{- define "generic-chart.namespace" -}}
{{- if .Values.namespaceOverride -}}
{{- .Values.namespaceOverride -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}