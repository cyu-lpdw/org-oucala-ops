{{/*
 Expand the name of the chart.
*/}}
{{- define "stacks.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Common definition of backend application.
*/}}
{{- define "stacks.back.name" }}
{{- printf "%s_%s-%s" (default .Values.env "dev" ) .Chart.Name (default .Values.stacks.back.suffix "back") -}}
{{- end }}

{{/*
 Common definition of backend docker image name.
*/}}
{{- define "stacks.back.image.fullname" }}
{{- printf "%s/%s/%s:%s" .Values.stacks.back.image.provider .Values.stacks.back.image.organization .Values.stacks.back.image.name .Values.stacks.back.image.tag | quote }}
{{- end }}