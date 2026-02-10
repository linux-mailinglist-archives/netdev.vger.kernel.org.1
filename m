Return-Path: <netdev+bounces-258158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEtZLniPi2nYWAAAu9opvQ
	(envelope-from <netdev+bounces-258158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:05:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1252411EE12
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6BD3059F0B
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2832FA32;
	Tue, 10 Feb 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BBUXNKuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF463314AE
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753868; cv=none; b=Og1JtVXqM4PPBDhMJRFBUx+UDp4mpoXu0zPqofRNS22vN9JqC7tNAX2DdNNZzcF0fm6g9pAcuucLBZuH9kepu1pZ+8QFbW7HgDVprmV3m+jKTT5H8nIoW75nIPqTV0MnydwMc/WCqAlEN8Gc5c9uO45M2FZi+DvJp8mG5Yloawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753868; c=relaxed/simple;
	bh=KJHmpTFbuQVt2Wxj0KgOgFgBfD8Yxl+IHvx8jo5giJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQh05g4HNnGCa0H/4un9y+PHoBzasBjYOv0X6xVq6QXqTzgaIxZd7PdXrX4hoLsd2iH+IzvxOQx3hiFtA4w4cYz+zjL2aIkCgj1c1bxA/8WSOdhgzOGQCu9UnIR3TwFNSRqw2Bj+Qqph5DOm4eiSaHZVtlLfsdCO64EfHPD0GDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BBUXNKuV; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45f09874c4cso3768303b6e.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1770753864; x=1771358664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR9nbpLN2Gu54/2NhwwCxGKaB4y/oVq6WVUPqlxtYd8=;
        b=BBUXNKuVEUUwV/eJcluTaoDidg40JFUh4jatukFiuliF5qvi1N+x0ykl8TuKJ51C9Y
         EMQbqkihkwjXQc6+S3BKPm438kLpLvuYRD65/ogedI3E7uB2XWzbXToSUUvK6A8iBKVP
         VAW4HbfIR4FYyyHTmIf4jY/VWBfZ3s3sj0a9GHevcaty9LUtalztZEy6CsdgLpaHY086
         On1alxHX+dAiAO02TArPWFP13yG/vyas+99f9LfJchPE82GSJO1sbjKI0UqJER0okr7T
         R5jXpGTl7nCt5PHX2tytDs1ONZ6aAUcD+ES7WjKWueVXDjZVC/X/JF7ZsFHWEsRxtcBf
         3wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753864; x=1771358664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UR9nbpLN2Gu54/2NhwwCxGKaB4y/oVq6WVUPqlxtYd8=;
        b=LVVIy+DdLtGNV1t+6ef9J5+LeibQ9e6WiUP1fKzO0Xd/oSaY2NyEcpUo18Sx8DjMCH
         j68q1hN/JSSv9IljbuoMkd12TUhecy4a2DTMWS9HnwW703ts3jpgfiSOqyruki2Git8Z
         gpraB2qivxpCp4Zoq5IoqeQFEcVBaVeBW2hgejAABQUhKBbTkG+6BajZgnYRMYRivvp3
         uqSEfw1sBdTgI2Zn9xcHpV6a2Y+TzvOfbinO1LVsKunGN/xnLDw1iO0JkYFU+isZNjCc
         oPCyYqSTgNqAWIrT0z0F+XQ22Wm4gUE4A2XQdUhDjJLYmzjpbiKoDBSNHMHAX6scHNP5
         G7xA==
X-Gm-Message-State: AOJu0YySTq9fkvdDnxAoWbfwewFx/7cOeI2XIDJK4odbcOF21Uv9NkWx
	b13kjRf55VTxLCgUSX9C31kMsdR82Vfq5g1OPgunVzNJNjsSNZF7ki8V84C0zMq+AF72Mn+YqzD
	2ATzU
X-Gm-Gg: AZuq6aL/hME4xhbFP21yaztBib1AbTgKjXm1093u2DHGpVNzEDG1Ui2oNJjR1jbqI6F
	b/oMh/bWtGVDJIeD5rx9NJIxxigwUdSd6Ixr3XQ+kgLAR18jGaSWlJjKAgljIH/gJExaleGzs7M
	3Sz3SXi1MUtbKyQuwDVAmhPRJ3XwHHDNzYm+wkEgYxoIpTmJIZ+KvS2qpkqrp6NuUNjVH0whSQ0
	23hHKJcuv1SMvQCW2LbI4ODs7VamX7Rvbx6joJ8eee9Cx1AmpRo1XXWraWjrQ4LD4EkutRctjrO
	FYKQQJdFZ1cvIWnNfLrVWTHh374M6DDh42gUHXg40ZTP5G9JbDHSg0LW3vRrNO4jWq6ww+M9KVw
	c5Ub5ksMuBaNmErZYyWJZKlh6sEwS+oMZVKXTfQZLHSmlopCjaLo63ANZqJVLGY9lvL1X7MlPNi
	fni3H7htUOKhKlEtMkGq4FOZGxehUFqmYhIPrzvw==
X-Received: by 2002:a05:6808:1306:b0:45a:55e6:33e with SMTP id 5614622812f47-4635398d889mr1619893b6e.18.1770753864189;
        Tue, 10 Feb 2026 12:04:24 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feb5455dsm8665484b6e.17.2026.02.10.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:04:23 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 3/4] selftests/net: Add env for container based tests
Date: Tue, 10 Feb 2026 12:04:18 -0800
Message-ID: <20260210200419.3555944-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210200419.3555944-1-dw@davidwei.uk>
References: <20260210200419.3555944-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258158-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei-uk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei.uk:mid,davidwei.uk:email]
X-Rspamd-Queue-Id: 1252411EE12
X-Rspamd-Action: no action

Add an env NetDrvContEnv for container based selftests. This automates
the setup of a netns, netkit pair with one inside the netns, and a BPF
program that forwards skbs from the NETIF host inside the container.

Currently only netkit is used, but other virtual netdevs e.g. veth can
be used too.

Expect netkit container datapath selftests to have a publicly routable
IP prefix to assign to netkit in a container, such that packets will
land on eth0. The BPF skb forward program will then forward such packets
from the host netns to the container netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/README.rst  |  19 ++
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
 .../selftests/drivers/net/lib/py/env.py       | 163 ++++++++++++++++++
 4 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index eb838ae94844..39370a83f238 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -62,6 +62,25 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
 
 Local and remote endpoint IP addresses.
 
+LOCAL_PREFIX_V4, LOCAL_PREFIX_V6
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Local IP prefix/subnet which can be used to allocate extra IP addresses (for
+network name spaces behind macvlan, veth, netkit devices). DUT must be
+reachable using these addresses from the endpoint.
+
+  +-------------+        +----------------------------+
+  | INIT NS     |        | TEST NS                    |
+  | +---------+ |        | +------------------------+ |
+  | | NETIF   | |  bpf   | | Netkit                 | |
+  | |         |-|--------|>| nk_guest               | |
+  | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
+  | +---------+ |        | +------------------------+ |
+  | | Netkit  | |        +----------------------------+
+  | | nk_host | |
+  | +---------+ |
+  +-------------+
+
 REMOTE_TYPE
 ~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index d5d247eca6b7..022008249313 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -3,6 +3,7 @@
 """
 Driver test environment (hardware-only tests).
 NetDrvEnv and NetDrvEpEnv are the main environment classes.
+NetDrvContEnv extends NetDrvEpEnv with netkit container support.
 Former is for local host only tests, latter creates / connects
 to a remote endpoint. See NIPA wiki for more information about
 running and writing driver tests.
@@ -29,7 +30,7 @@ try:
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
-    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
@@ -44,8 +45,8 @@ try:
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
-               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
-               "Iperf3Runner"]
+               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
+               "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index a18e21069f7a..6b55068d5370 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -3,6 +3,7 @@
 """
 Driver test environment.
 NetDrvEnv and NetDrvEpEnv are the main environment classes.
+NetDrvContEnv extends NetDrvEpEnv with netkit container support.
 Former is for local host only tests, latter creates / connects
 to a remote endpoint. See NIPA wiki for more information about
 running and writing driver tests.
@@ -43,12 +44,12 @@ try:
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
 
-    from .env import NetDrvEnv, NetDrvEpEnv
+    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
 
-    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
-                "Iperf3Runner"]
+    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
+                "Remote", "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 41cc248ac848..857ae0f37516 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,13 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import ipaddress
 import os
 import time
+import json
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
 from lib.py import cmd, ethtool, ip, CmdExitFailure
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
+from . import bpftool, RtnlFamily, Netlink
 
 
 class NetDrvEnvBase:
@@ -289,3 +292,163 @@ class NetDrvEpEnv(NetDrvEnvBase):
                 data.get('stats-block-usecs', 0) / 1000 / 1000
 
         time.sleep(self._stats_settle_time)
+
+
+class NetDrvContEnv(NetDrvEpEnv):
+    """
+    Class for an environment with a netkit pair setup for forwarding traffic
+    between the physical interface and a network namespace.
+    +-------------+        +----------------------------+
+    | INIT NS     |        | TEST NS                    |
+    | +---------+ |        | +------------------------+ |
+    | | NETIF   | |  bpf   | | Netkit                 | |
+    | |         |-|--------|>| nk_guest               | |
+    | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
+    | +---------+ |        | +------------------------+ |
+    | | Netkit  | |        +----------------------------+
+    | | nk_host | |
+    | +---------+ |
+    +-------------+
+    """
+
+    def __init__(self, src_path, rxqueues=1, **kwargs):
+        super().__init__(src_path, **kwargs)
+
+        self.netns = None
+        self._nk_host_ifname = None
+        self._nk_guest_ifname = None
+        self._tc_clsact_added = False
+        self._tc_attached = False
+        self._bpf_prog_pref = None
+        self._bpf_prog_id = None
+        self._init_ns_attached = False
+
+        self.require_ipver("6")
+        local_prefix = self.env.get("LOCAL_PREFIX_V6")
+        if not local_prefix:
+            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
+
+        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
+        self.ipv6_prefix = f"{local_prefix}::"
+        self.nk_host_ipv6 = f"{local_prefix}::2:1"
+        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
+
+        rtnl = RtnlFamily()
+        rtnl.newlink(
+            {
+                "linkinfo": {
+                    "kind": "netkit",
+                    "data": {
+                        "mode": "l2",
+                        "policy": "forward",
+                        "peer-policy": "forward",
+                    },
+                },
+                "num-rx-queues": rxqueues,
+            },
+            flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
+        )
+
+        all_links = ip("-d link show", json=True)
+        netkit_links = [link for link in all_links
+                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
+                        and 'UP' not in link.get('flags', [])]
+
+        if len(netkit_links) != 2:
+            raise KsftSkipEx("Failed to create netkit pair")
+
+        netkit_links.sort(key=lambda x: x['ifindex'])
+        self._nk_host_ifname = netkit_links[1]['ifname']
+        self._nk_guest_ifname = netkit_links[0]['ifname']
+        self.nk_host_ifindex = netkit_links[1]['ifindex']
+        self.nk_guest_ifindex = netkit_links[0]['ifindex']
+
+        self._setup_ns()
+        self._attach_bpf()
+
+    def __del__(self):
+        if self._tc_attached:
+            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
+            self._tc_attached = False
+
+        if self._tc_clsact_added:
+            cmd(f"tc qdisc del dev {self.ifname} clsact")
+            self._tc_clsact_added = False
+
+        if self._nk_host_ifname:
+            cmd(f"ip link del dev {self._nk_host_ifname}")
+            self._nk_host_ifname = None
+            self._nk_guest_ifname = None
+
+        if self._init_ns_attached:
+            cmd("ip netns del init", fail=False)
+            self._init_ns_attached = False
+
+        if self.netns:
+            del self.netns
+            self.netns = None
+
+        super().__del__()
+
+    def _setup_ns(self):
+        self.netns = NetNS()
+        cmd("ip netns attach init 1")
+        self._init_ns_attached = True
+        ip("netns set init 0", ns=self.netns)
+        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
+        ip(f"link set dev {self._nk_host_ifname} up")
+        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
+
+        ip("link set lo up", ns=self.netns)
+        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
+        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
+        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
+        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
+
+    def _tc_ensure_clsact(self):
+        qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
+        for q in qdisc:
+            if q['kind'] == 'clsact':
+                return
+        cmd(f"tc qdisc add dev {self.ifname} clsact")
+        self._tc_clsact_added = True
+
+    def _get_bpf_prog_ids(self):
+        filter = json.loads(cmd(f"tc -j filter show dev {self.ifname} ingress").stdout)
+        for bpf in filter:
+            if 'options' not in bpf:
+                continue
+            if bpf['options']['bpf_name'].startswith('nk_forward.bpf'):
+                return (bpf['pref'], bpf['options']['prog']['id'])
+        if self._bpf_prog_pref is None:
+            raise Exception("Failed to get BPF prog ID")
+
+    def _attach_bpf(self):
+        bpf_obj = self.test_dir / "nk_forward.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("BPF prog not found")
+
+        self._tc_ensure_clsact()
+        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._tc_attached = True
+
+        (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
+        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
+        map_ids = prog_info.get("map_ids", [])
+
+        bss_map_id = None
+        for map_id in map_ids:
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name").endswith("bss"):
+                bss_map_id = map_id
+
+        if bss_map_id is None:
+            raise Exception("Failed to find .bss map")
+
+        ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
+        ipv6_bytes = ipv6_addr.packed
+        ifindex_bytes = self.nk_host_ifindex.to_bytes(4, byteorder='little')
+        value = ipv6_bytes + ifindex_bytes
+        value_hex = ' '.join(f'{b:02x}' for b in value)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
-- 
2.47.3


