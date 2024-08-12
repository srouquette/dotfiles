{{- /*replace env by real path, because expandenv doesn't seem to work */ -}}
{{- $envlist := list "USERPROFILE" "APPDATA" "LOCALAPPDATA" "CHEZMOI_SOURCE_DIR" -}}
{{- $envdict := dict -}}
{{- range $i := $envlist -}}
    {{ $env := list "%" $i "%" | join "" }}
    {{- $envdict = dict $env (env $i) | merge $envdict -}}
{{- end }}
{{- $path := . -}}

{{- range $k, $v := $envdict -}}
    {{- $path = $path | replace $k $v -}}
{{- end -}}
{{- $path -}}
