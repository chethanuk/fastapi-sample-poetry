{{/*
Expand the name of the chart.
*/}}
{{- define "pyapi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pyapi.fullname" -}}
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
{{- define "pyapi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pyapi.labels" -}}
helm.sh/chart: {{ include "pyapi.chart" . }}
{{ include "pyapi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pyapi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pyapi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pyapi.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pyapi.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the affinity for pods and nodes
*/}}
{{- define "affinity" -}}
# podAntiAffinity:
#   requiredDuringSchedulingIgnoredDuringExecution:
#   - labelSelector:
#       matchExpressions:
#       - key: app.kubernetes.io/instance
#         operator: In
#         values:
#         - {{ .Release.Name }}
#     topologyKey: "kubernetes.io/hostname"
nodeAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    nodeSelectorTerms:
    - matchExpressions:
      - key: cloud.google.com/gke-nodepool
        operator: In
        values:
          - {{ .Values.affinity.component | quote}}
{{- end -}}