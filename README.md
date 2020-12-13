# Reboot on OOM

Reboot the system when traces of kernel OOM killer activity are found in dmesg.

## Background

Linux' OOM killer -- while certainly a useful thing per se -- is known to be a
reliable source of disturbance to system reliability.

If you can't guarantee that a killed process comes back to life without
unpredictable side-effects (or if you cannot get this guarantee from any
software you rely on), you probably want to reset the system.
While you can of course set `sysctl vm.panic_on_oom=1` (kernel instantly panics
on OOM), you may want other processes to exit cleanly instead.

This is what `reboot-on-oom` is about: it repeatedly greps on kernel's log
(dmesg) to search for traces of OOM killer activity.
If such traces are found, a clean reboot is performed.
If that should fail (I've seen badly broken systems where OOM killer nuked
parts of systemd, making every call to `systemctl` fail), even harder measures
are taken by using Linux' magic sysrq trigger `/proc/syseq-trigger`, escalating
one level at a time, ultimately crashing the kernel (you should make sure the
machine reboots in this case).

This project is kept simple on purpose.

If you need more fine grained control over any aspect of OOM situations, use
one of the other available OOM killers for user space.

## Installation

```
make install
```

Make this a long-lived process on the target by integrating it into service
supervision.

An optional systemd service file is available via
`make DESTDIR=foo WITH_SYSTEMD=yes`.

## Similar Projects

There are excellent OOM-killer daemons for user space!

* [earlyoom](https://github.com/rfjakob/earlyoom)
* [oomd](https://github.com/facebookincubator/oomd)

## Author

Christian Hermann <mail@hermannch.dev>

## License

ISC.

See [LICENSE](./LICENSE) for details.
