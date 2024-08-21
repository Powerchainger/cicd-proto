{{/*
Number of replicas.
*/}}
{{- define "SampleApp.replicaCount" -}}
{{- if .Values.replicaCount -}}
{{- .Values.replicaCount -}}
{{- else if eq .Values.environmentType "prod" -}}
{{- 0 -}}
{{- else -}}
{{- 1 -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "SampleApp.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Full image
*/}}
{{- define "SampleApp.image" -}}
{{- default .Values.image.image -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "SampleApp.fullname" -}}
{{- $name:= .Chart.Name -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "SampleApp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "SampleApp.labels" -}}
app.kubernetes.io/name: {{ include "SampleApp.name" . }}
helm.sh/chart: {{ include "SampleApp.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "SampleApp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "SampleApp.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

