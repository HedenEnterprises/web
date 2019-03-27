
{{/*

  _              _            ______       _                       _                 _       
 | |            | |          |  ____|     | |                     (_)               (_)      
 | |__   ___  __| | ___ _ __ | |__   _ __ | |_ ___ _ __ _ __  _ __ _ ___  ___  ___   _  ___  
 | '_ \ / _ \/ _` |/ _ \ '_ \|  __| | '_ \| __/ _ \ '__| '_ \| '__| / __|/ _ \/ __| | |/ _ \ 
 | | | |  __/ (_| |  __/ | | | |____| | | | ||  __/ |  | |_) | |  | \__ \  __/\__ \_| | (_) |
 |_| |_|\___|\__,_|\___|_| |_|______|_| |_|\__\___|_|  | .__/|_|  |_|___/\___||___(_)_|\___/ 
                                                       | |                                   
                                                       |_|                                   

*/}}



{{/*---------------------------------
-------------------------------------

    Expand the name of the chart

-------------------------------------
---------------------------------*/}}

{{- define "heden-enterprises-web.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}



{{/*---------------------------------
-------------------------------------

    Create a default fully qualified app name

    We truncate at 63 chars because some Kubernetes name fields are
    limited to this (by the DNS naming spec)

    If release name contains chart name it will be used as a full name

-------------------------------------
---------------------------------*/}}

{{- define "heden-enterprises-web.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}



{{/*---------------------------------
-------------------------------------

    Create chart name and version as used by the chart label

-------------------------------------
---------------------------------*/}}

{{- define "heden-enterprises-web.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}



{{/*---------------------------------
-------------------------------------

    Override names of deployment, service, ingress if so desired

-------------------------------------
---------------------------------*/}}

{{- define "heden-enterprises-web.deployment-name" -}}
{{- if (.Values.names) and (.Values.names.deployment) -}}
{{- default (include "heden-enterprises-web.fullname" .) .Values.names.deployment | trunc 253 | trimSuffix "-" -}}
{{- else -}}
{{ printf "%s" (include "heden-enterprises-web.fullname" .) }}
{{- end -}}
{{- end -}}

{{- define "heden-enterprises-web.service-name" -}}
{{- if (.Values.names) and (.Values.names.service) -}}
{{- default (include "heden-enterprises-web.fullname" .) .Values.names.service | trunc 253 | trimSuffix "-" -}}
{{- else -}}
{{ printf "%s" (include "heden-enterprises-web.fullname" .) }}
{{- end -}}
{{- end -}}

{{- define "heden-enterprises-web.ingress-name" -}}
{{- if (.Values.names) and (.Values.names.ingress) -}}
{{- default (include "heden-enterprises-web.fullname" .) .Values.names.ingress | trunc 253 | trimSuffix "-" -}}
{{- else -}}
{{ printf "%s" (include "heden-enterprises-web.fullname" .) }}
{{- end -}}
{{- end -}}



{{/*---------------------------------
-------------------------------------

    Replica count for the deployment

    default replicas = 2

-------------------------------------
---------------------------------*/}}

{{- define "heden-enterprises-web.replicas" -}}
{{- if .Values.replicaCount -}}
{{- default 2 .Values.replicaCount -}}
{{- else -}}
{{ printf "%d" 2 }}
{{- end -}}
{{- end -}}



{{/*---------------------------------
-------------------------------------

    Annotation for GKE/GCP external IP

    default = web-external-ip

-------------------------------------
---------------------------------*/}}

{{- define "heden-enterprises-web.externalIPName" -}}
{{- if .Values.externalIPName -}}
{{- default "web-external-ip" .Values.externalIPName -}}
{{- else -}}
{{ printf "web-external-ip" }}
{{- end -}}
{{- end -}}
