{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Values.tenant.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Tenant labels
*/}}
{{- define "tenantLabels" -}}
rhacs.redhat.com/instance-type: "{{ .Values.tenant.instanceType }}"
rhacs.redhat.com/org-id: "{{ .Values.tenant.organizationId }}"
rhacs.redhat.com/tenant: "{{ .Values.tenant.id }}"
{{- end }}

{{/*
Tenant Annotations
*/}}
{{- define "tenantAnnotations" -}}
platform.stackrox.io/managed-services: "true"
rhacs.redhat.com/org-name: {{ .Values.tenant.organizationName }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "labels" -}}
helm.sh/chart: {{ include "chart" . }}
{{ include "selectorLabels" . }}
{{ include "tenantLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
rhacs.redhat.com/instance-type: "{{ .Values.tenant.instanceType }}"
rhacs.redhat.com/org-id: "{{ .Values.tenant.organizationId }}"
rhacs.redhat.com/tenant: "{{ .Values.tenant.id }}"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "selectorLabels" -}}
app.kubernetes.io/name: {{ include "name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Annotations
*/}}
{{- define "annotations" -}}
{{ include "tenantAnnotations" . }}
{{- end }}


{{/*
Central Annotations
*/}}
{{- define "centralAnnotations" -}}
{{ include "annotations" . }}
stackrox.io/pause-reconcile: {{ .Values.reconciliationPaused | quote }}
{{- end }}

{{- define "localNetworkCidrRanges" -}}
{{- tpl (.Files.Get "config/local-network-cidr-ranges.yaml.tpl") . -}}
{{- end -}}

{{- define "localNetworkCidrRangesIPv6" -}}
{{- tpl (.Files.Get "config/local-network-cidr-ranges-ipv6.yaml.tpl") . -}}
{{- end -}}
