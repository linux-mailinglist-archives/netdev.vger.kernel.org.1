Return-Path: <netdev+bounces-298980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dc71OTiDLWpNhAQAu9opvQ
	(envelope-from <netdev+bounces-298980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:20:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 407C467F0B6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:20:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Gkw121Hv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298980-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298980-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B180C302003E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF434B1A3;
	Sat, 13 Jun 2026 16:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E05318B83;
	Sat, 13 Jun 2026 16:20:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367605; cv=none; b=Or9pNqJNuDTi6h9PVlsMCVeRM+LLdTztgO9lyYMVE9Bg4xRQYhn0teDVuX16ocxot2LEziiw0G2sPDDi1uL9QGW60a8c5xRQgdcXQGGsZnodhXdVCpET36uMXzjBr/qGX0RWNj0fMPZcQlrys6dcVrgZHNw4PGQQxXCBjXb1tDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367605; c=relaxed/simple;
	bh=Xt8xKPvZAp8VCACq1n8BR/xB9avta5EB2Pa8EGLNK90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7V6GWUryI/o7NYLTXG+cUBSEjlZdFeSJRn3ey32z8n1Pf5A0gwZrCGbdIOp5kFzC2fyemQAw7/c4ajccl7hjjLdEJJyjCqzjo3nJmk7utkqzq/OpPzW9z6Wpaw4C+O0Wk0nplt3pYSjKm33UPEZwXWQK1csKSObB96J+Al8Mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkw121Hv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690DA1F00A3A;
	Sat, 13 Jun 2026 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781367603;
	bh=WBzr7Bu9ztFcAu9PXZ0SG/2gOYwYXt62+im1kpGi0cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gkw121Hv/LB1wguEFTUg7jR36e/LZYaAVeaUuVtVhv4qCLW8tp+iLpYau1wOrk0vb
	 k9XJZ+YarJLckoJyOw372uDmdTqgPH7xgZyS4oyca+NYZdCDmo0h4HCcN6qxlKvkMP
	 N56nh2t36l4ROwIkrRIudWP5wHXVhJU9VpHIboC2CWL8h4Nejx6S9Gsf3JCslr70oo
	 3vGZNl0z+1b7E08jWw/0rlHF78tlKoqqOK1ozKDtGUonYTyI2tvvuBHP3q6IKiBZLJ
	 6FYpEENFewIzxTjTIDAu4kUPCaVk8hsTy5EfdyDICPnkinY2AJ4isYOdsIGGRfCZMS
	 0x++5qejCjkWw==
Date: Sat, 13 Jun 2026 09:20:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next V2] selftests: drv-net: Test queue stall upon
 reconfig
Message-ID: <20260613092002.72fc7906@kernel.org>
In-Reply-To: <20260613014855.1717712-1-mohsin.bashr@gmail.com>
References: <20260613014855.1717712-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mohsin.bashr@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:mohsinbashr@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lib.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 407C467F0B6

On Fri, 12 Jun 2026 18:48:54 -0700 Mohsin Bashir wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
>=20
> Add a reconfig_tx_stall test that detects the possibility of a TX stall
> after ring reconfiguration. The key observation is that drivers using
> netif_tx_start_all_queues() are prone to experiencing a stall when
> reconfiguration completes compared to drivers using
> netif_tx_wake_all_queues(). start_all_queues only clears DRV_XOFF, while
> wake_all_queues also calls __netif_schedule() to kick the qdisc. Without
> the kick, qdisc backlog present at reconfig time can stay stuck until a
> new trigger is issued.
>=20
> The test caps the TX ring at 64 entries so it fills quickly, then
> installs FQ on a target TX queue and sends UDP packets with SO_TXTIME
> scheduled in the future. With napi_defer_hard_irqs slowing completions,
> the small ring can fill when FQ releases the burst, leaving requeued
> qdisc backlog with no FQ timer to rescue it. A subsequent ring reconfig
> must wake the queues to drain the backlog. Simply starting the queues can
> leave it stuck.
>=20
> On host with problematic driver:
>  Sent 128 SO_TXTIME packets (+100ms)
>  Sent 128 SO_TXTIME packets (+200ms)
>  Backlog before reconfig: 52632 bytes
>  Check| At /root/ksft-net-drv/./drivers/net/ring_reconfig.py, ...
>  Check|     ksft_eq(0, backlog,
>  Check failed 0 !=3D 52632 qdisc backlog stuck on queue 1 after ring reco=
nfig
> not ok 3 ring_reconfig.reconfig_tx_stall
>=20
> On host with fixed driver:
>  Sent 128 SO_TXTIME packets (+100ms)
>  Sent 128 SO_TXTIME packets (+200ms)
>  Backlog before reconfig: 76024 bytes
> ok 3 ring_reconfig.reconfig_tx_stall
>=20
> Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


pylint is not on board:

+tools/testing/selftests/drivers/net/ring_reconfig.py:169:37: W1514: Using =
open without explicitly specifying an encoding (unspecified-encoding)
+tools/testing/selftests/drivers/net/ring_reconfig.py:162:17: W0613: Unused=
 argument 'cfg' (unused-argument)
+tools/testing/selftests/drivers/net/ring_reconfig.py:253:0: C0116: Missing=
 function or method docstring (missing-function-docstring)

> diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/s=
elftests/drivers/net/config
> index 617de8aaf551..1ef07fae74c1 100644
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -4,6 +4,10 @@ CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
>  CONFIG_INET_PSP=3Dy
>  CONFIG_IPV6=3Dy
>  CONFIG_MACSEC=3Dm
> +CONFIG_NET_ACT_SKBEDIT=3Dm
> +CONFIG_NET_CLS_ACT=3Dy
> +CONFIG_NET_CLS_FLOWER=3Dm
> +CONFIG_NET_CLS_MATCHALL=3Dm
>  CONFIG_NETCONSOLE=3Dm
>  CONFIG_NETCONSOLE_DYNAMIC=3Dy
>  CONFIG_NETCONSOLE_EXTENDED_LOG=3Dy
> diff --git a/tools/testing/selftests/drivers/net/ring_reconfig.py b/tools=
/testing/selftests/drivers/net/ring_reconfig.py
> index f9530a8b0856..11491a0b7013 100755
> --- a/tools/testing/selftests/drivers/net/ring_reconfig.py
> +++ b/tools/testing/selftests/drivers/net/ring_reconfig.py
> @@ -5,10 +5,18 @@
>  Test channel and ring size configuration via ethtool (-L / -G).
>  """
> =20
> +import socket
> +import struct
> +import time
> +
>  from lib.py import ksft_run, ksft_exit, ksft_pr
>  from lib.py import ksft_eq
> +from lib.py import KsftSkipEx
>  from lib.py import NetDrvEpEnv, EthtoolFamily, GenerateTraffic
> -from lib.py import defer, NlError
> +from lib.py import cmd, defer, rand_port, tc, NlError
> +
> +# Added in Python 3.13; fallback to 61 for x86/ARM/MIPS
> +SO_TXTIME =3D getattr(socket, "SO_TXTIME", 61)
> =20
> =20
>  def channels(cfg) -> None:
> @@ -151,6 +159,169 @@ def ringparam(cfg) -> None:
>          GenerateTraffic(cfg).wait_pkts_and_stop(10000)
> =20
> =20
> +def _write_sysfs(cfg, path, val):
> +    with open(path, "r", encoding=3D"utf-8") as fp:
> +        orig_val =3D fp.read().strip()
> +    if str(val) =3D=3D orig_val:
> +        return
> +    with open(path, "w", encoding=3D"utf-8") as fp:
> +        fp.write(str(val))
> +    defer(lambda p=3Dpath, v=3Dorig_val: open(p, "w").write(v))
> +
> +
> +def _get_mq_handle(cfg):
> +    qdiscs =3D tc(f"qdisc show dev {cfg.ifname}", json=3DTrue)
> +    for q in qdiscs:
> +        if q.get("kind") =3D=3D "mq":
> +            return q["handle"]
> +    raise KsftSkipEx(f"no mq qdisc found on {cfg.ifname}")
> +
> +
> +def _get_qdisc_backlog(cfg, queue, mq_handle):
> +    qdiscs =3D tc(f"-s qdisc show dev {cfg.ifname}", json=3DTrue)
> +    target_parent =3D f"{mq_handle}{queue + 1:x}"
> +    for q in qdiscs:
> +        if q.get("parent", "") =3D=3D target_parent:
> +            return q.get("backlog")
> +    return None
> +
> +
> +def _setup_fq_qdisc(cfg, mq_handle, port, target_queue, other_queue):
> +    mq_child_parent =3D f"{mq_handle}{target_queue + 1:x}"
> +
> +    # Save the original child qdisc to restore after test
> +    qdiscs =3D tc(f"qdisc show dev {cfg.ifname}", json=3DTrue)
> +    default_qdisc =3D cmd("sysctl -n net.core.default_qdisc").stdout.str=
ip()
> +    orig_kind =3D default_qdisc
> +    for q in qdiscs:
> +        if q.get("parent", "") =3D=3D mq_child_parent:
> +            orig_kind =3D q.get("kind", default_qdisc)
> +            break
> +    try:
> +        tc(f"qdisc replace dev {cfg.ifname} parent {mq_child_parent} fq")
> +    except Exception as exc:
> +        raise KsftSkipEx("fq not available (CONFIG_NET_SCH_FQ)") from exc
> +    defer(tc,
> +          f"qdisc replace dev {cfg.ifname} parent {mq_child_parent} {ori=
g_kind}")
> +
> +    qdisc_j =3D tc(f"qdisc show dev {cfg.ifname}", json=3DTrue)
> +    has_clsact =3D any(q['kind'] =3D=3D 'clsact' for q in qdisc_j)
> +    if not has_clsact:
> +        tc(f"qdisc add dev {cfg.ifname} clsact")
> +        defer(tc, f"qdisc del dev {cfg.ifname} clsact")
> +
> +    proto =3D "ipv6" if int(cfg.addr_ipver) =3D=3D 6 else "ip"
> +    try:
> +        tc(f"filter add dev {cfg.ifname} egress protocol {proto} "
> +           f"pref 1 flower ip_proto udp dst_port {port} "
> +           f"action skbedit queue_mapping {target_queue}")
> +    except Exception as exc:
> +        raise KsftSkipEx("tc flower/act_skbedit not available") from exc
> +    defer(tc, f"filter del dev {cfg.ifname} egress pref 1")
> +
> +    tc(f"filter add dev {cfg.ifname} egress pref 100 "
> +       f"matchall action skbedit queue_mapping {other_queue}")
> +    defer(tc, f"filter del dev {cfg.ifname} egress pref 100")
> +
> +
> +def _create_sotxtime_socket(cfg):
> +    sock =3D socket.socket(socket.AF_INET6 if cfg.addr_ipver =3D=3D "6"
> +                         else socket.AF_INET, socket.SOCK_DGRAM)
> +    try:
> +        sock.setsockopt(socket.SOL_SOCKET, SO_TXTIME, struct.pack("Ii", =
1, 0))
> +    except OSError as exc:
> +        sock.close()
> +        raise KsftSkipEx("SO_TXTIME not supported") from exc
> +    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BINDTODEVICE,
> +                    cfg.ifname.encode())
> +    return sock
> +
> +
> +def _send_sotxtime_burst(sock, addr, port, count, delay_ns, ipver):
> +    payload =3D b'\x00' * 1400
> +    txtime_ns =3D time.clock_gettime_ns(time.CLOCK_MONOTONIC) + delay_ns
> +
> +    ancdata =3D [(socket.SOL_SOCKET, SO_TXTIME, struct.pack("Q", txtime_=
ns))]
> +    if int(ipver) =3D=3D 6:
> +        dest =3D (addr, port, 0, 0)
> +    else:
> +        dest =3D (addr, port)
> +    for _ in range(count):
> +        sock.sendmsg([payload], ancdata, 0, dest)
> +
> +
> +def reconfig_tx_stall(cfg) -> None:
> +    target_queue =3D 1
> +    other_queue =3D 0
> +
> +    ehdr =3D {'header': {'dev-index': cfg.ifindex}}
> +    chans =3D cfg.eth.channels_get(ehdr)
> +
> +    if 'combined-max' not in chans:
> +        raise KsftSkipEx("device does not support combined channels")
> +    if chans['combined-count'] < 2:
> +        raise KsftSkipEx("need at least 2 combined channels")
> +
> +    rings =3D cfg.eth.rings_get(ehdr)
> +    if 'rx' not in rings or 'tx' not in rings:
> +        raise KsftSkipEx("device does not expose rx/tx ring params")
> +    tx_cur =3D rings['tx']
> +    if tx_cur <=3D 64:
> +        raise KsftSkipEx("tx ring size already at minimum")
> +    defer(cfg.eth.rings_set, ehdr | {'tx': tx_cur})
> +
> +    tx_min =3D 64
> +    cfg.eth.rings_set(ehdr | {'tx': tx_min})
> +
> +    # Slow completions so the ring stays full after FQ releases packets
> +    napi_defer =3D f"/sys/class/net/{cfg.ifname}/napi_defer_hard_irqs"
> +    gro_timeout =3D f"/sys/class/net/{cfg.ifname}/gro_flush_timeout"
> +    _write_sysfs(cfg, napi_defer, 100)
> +    _write_sysfs(cfg, gro_timeout, 1000000000)
> +
> +    mq_handle =3D _get_mq_handle(cfg)
> +    port =3D rand_port()
> +    _setup_fq_qdisc(cfg, mq_handle, port, target_queue, other_queue)
> +
> +    sock =3D _create_sotxtime_socket(cfg)
> +    defer(sock.close)
> +
> +    pkt_count =3D tx_min * 2
> +
> +    for delay_ms in [100, 200, 500]:
> +        delay_ns =3D delay_ms * 1_000_000
> +        _send_sotxtime_burst(sock, cfg.remote_addr, port, pkt_count,
> +                             delay_ns, cfg.addr_ipver)
> +        ksft_pr(f"Sent {pkt_count} SO_TXTIME packets (+{delay_ms}ms)")
> +        time.sleep(delay_ms / 1000 + 0.3)
> +
> +        backlog =3D _get_qdisc_backlog(cfg, target_queue, mq_handle)
> +        if backlog:
> +            break
> +    else:
> +        raise KsftSkipEx("failed to build qdisc backlog")
> +
> +    ksft_pr(f"Backlog before reconfig: {backlog} bytes")
> +
> +    # Trigger ring reconfig =E2=80=94 driver should call wake, not just =
start
> +    cfg.eth.rings_set(ehdr | {'tx': tx_cur})
> +
> +    # Let completions proceed normally
> +    _write_sysfs(cfg, napi_defer, 0)
> +    _write_sysfs(cfg, gro_timeout, 0)
> +
> +    # Poll for backlog to drain
> +    for _ in range(100):
> +        backlog =3D _get_qdisc_backlog(cfg, target_queue, mq_handle)
> +        if not backlog:
> +            break
> +        time.sleep(0.1)
> +
> +    ksft_eq(0, backlog,
> +            comment=3Df"qdisc backlog stuck on queue {target_queue} "
> +                    f"after ring reconfig")
> +
> +
>  def main() -> None:
>      """ Ksft boiler plate main """
> =20
> @@ -158,7 +329,8 @@ def main() -> None:

the NetDrvEpEnv() setup needs to ask for 2+ queues, otherwise this
fails in netdevsim mode:

# ok 3 ring_reconfig.reconfig_tx_stall # SKIP need at least 2 combined chan=
nels

>          cfg.eth =3D EthtoolFamily()
> =20
>          ksft_run([channels,
> -                  ringparam],
> +                  ringparam,
> +                  reconfig_tx_stall],
>                   args=3D(cfg, ))
>      ksft_exit()
> =20


