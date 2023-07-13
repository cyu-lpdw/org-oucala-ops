{{/*
Expand the name of the chart.
*/}}
{{- define "stacks.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common definition of backend application.
*/}}
{{- define "stacks.app.back.name" -}}
{{- $prefix := ternary .Values.stacks.app.back.prefix 'back' -}}
{{- printf "%s-%s-%s" .Release.Namespace $prefix (include "stacks.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common definition of frontend application name.
*/}}
{{- define "stacks.app.front.name" -}}
{{- $prefix := ternary .Values.stacks.app.front.prefix 'app' -}}
{{- printf "%s-%s-%s" .Release.Namespace $prefix (include "stacks.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common definition of backend docker image name.
*/}}
{{- define "stacks.app.back.image.fullname" -}}
{{- $provider := ternary .Values.stacks.app.back.image.provider 'docker.io' -}}
{{- $organization := ternary .Values.stacks.app.back.image.organization 'deepnox' -}}
{{- $image := ternary .Values.stacks.app.back.image.name (include "stacks.app.front.image" .) -}}
{{- $tag := ternary .Values.stacks.app.back.image.tag 'dev' -}}
{{- printf "%s/%s/%s:%s" $provider $organisation $image $tag }}
{{- end -}}

{{/*
Common definition of frontend docker image name.
*/}}
{{- define "stacks.app.front.image.fullname" -}}
{{- $provider := ternary .Values.stacks.app.front.image.provider 'docker.io' -}}
{{- $organization := ternary .Values.stacks.app.front.image.organization 'deepnox' -}}
{{- $image := ternary .Values.stacks.app.front.image.name (include "stacks.app.front.image" .) -}}
{{- $tag := ternary .Values.stacks.app.front.image.tag 'dev' -}}
{{- printf "%s/%s/%s:%s" $provider $organisation $image $tag -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "stacks.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "stacks.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "stacks.labels" -}}
helm.sh/chart: {{ include "stacks.chart" . }}
{{ include "stacks.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "stacks.selectorLabels" -}}
app.kubernetes.io/name: {{ include "stacks.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "stacks.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "stacks.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
