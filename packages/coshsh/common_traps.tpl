{% for mib in application.trap_events %}
{% set names = [] %}
{% for event in application.trap_events[mib] %}
{% do names.append(event.name) %}
{{ application|service(application.trap_service_prefix + "_traps_" + mib + "_" + event.name) }}
  use                             passive_traps,{{ application.trap_service_prefix }}_traps
  host_name                       {{ application.host_name }}
  _MIB                            {{ event.mib }}
  _OID                            {{ event.oid|replace('\\', '') }}
}
{% endfor %}
{% endfor %}
