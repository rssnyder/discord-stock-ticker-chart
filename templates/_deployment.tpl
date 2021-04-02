{{/*  Deployment Template  */}}
{{- define "deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}
  labels:
    app: {{ .Chart.Name }}
spec:
  replicas: {{ .Values.global.replicas }}
  {{- with .Values.global.strategy }}
  strategy:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  selector:
    matchLabels:
      app: {{ .Chart.Name }}
  template:
    metadata:
      labels:
        app: {{ .Chart.Name }}
    spec:
      restartPolicy: Always
      containers:
      - name: {{ .Chart.Name }}
        image: {{ .Values.global.image.repository }}:{{ .Values.global.image.tag }}
        imagePullPolicy: {{ .Values.global.image.pullPolicy }}
        env:
            {{- if or .Values.env .Values.global.env  }}
            {{- range $key, $val := .Values.global.env }}
          - name:  {{ $key }}
            value: {{ $val | quote }}
            {{- end }}
            {{- range $key, $val := .Values.env }}
          - name:  {{ $key }}
            value: {{ $val | quote }}
            {{- end }}
            {{- end }}
{{- end -}}
