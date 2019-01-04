
# IP Spoofing Tester v1.4 (http://spoofer.caida.org/)

## About the idea

The CAIDA Spoofer project, building on the MIT ANA Spoofer project,
measures the Internet's susceptibility to spoofed source address IP
packets.  Malicious users capitalize on the ability to "spoof"
source IP addresses for anonymity, indirection, targeted attacks and
security circumvention.  Compromised hosts on networks that permit
IP spoofing enable a wide variety of attacks.  New spoofing-based
attacks regularly appear (most recently against the DNS
infrastructure) despite decades of previous exploits and
prevention/tracing attempts.

The Spoofer client attempts to send a series of spoofed UDP packets
that test the ability to send different classes of spoofed traffic,
including private IP addresses (e.g. RFC1918), routable IP
addresses, and neighboring adjacent IP addresses.  The tool also
estimates where along the path filtering is employed, and infers the
presence of a NAT device along the path.

The Spoofer client contains these components:
* Prober (spoofer-prober): performs the spoofing test
* Manager: manages the Prober (optional, but recommended)
  - Scheduler (spoofer-scheduler): a long-running background service
    that runs the Prober periodically or after a network change
  - GUI (spoofer-gui): a graphical user interface to the Scheduler
  - CLI (spoofer-cli): a command line interface to the Scheduler

To limit impact on our servers and remote networks, the spoofer
server permits up to three sessions within a seven day period from
any single address.  However, periodically running our Prober, even
from the same point in the network, gives us additional data related
to the evolution of ISP filtering policies.  If you are unable or
choose not to run the Spoofer Scheduler component, we request that
you run the Prober in a monthly cron job.

For more information: https://www.caida.org/projects/spoofer/faq.xml


## Installation

```
  docker run --network=host -it --rm spoofer
```
The spoofer-scheduler will run automatically after installation and
whenever the system boots, and by default will periodically run the
spoofer-prober in the background.  The scheduler can be paused, resumed,
or stopped (but not started) via spoofer-gui or spoofer-cli.

* Windows
  The spoofer-scheduler is installed as a Windows Service, and
  can be controlled through the Services Control Panel.

* Mac OSX
  The spoofer-scheduler is installed as a launchd(8) daemon with
  job label "org.caida.spoofer-scheduler" and configuration file
  "/Library/LaunchDaemons/org.caida.spoofer-scheduler.plist", and
  can be controlled with launchctl(1).


## Feedback

Currently maintained by Máximo Zarza (zmaximo1990@gmail.com) and Matias Silve (matiasnicolas.silva@gmail.com)
at UNLP (Universidad Nacional de La Plata).
Feedback, improvements and bugfixes are welcome.
