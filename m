Return-Path: <netdev+bounces-262496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ItBMB8ipWnd3wUAu9opvQ
	(envelope-from <netdev+bounces-262496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:37:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068B1D3246
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9773B302AD1E
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623B26E706;
	Mon,  2 Mar 2026 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FdN3iRqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389630EF94
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429684; cv=none; b=o+blRLwCuAqKl3DzhTTFwx2evK1GvoF3rRLDL4UheVlqzi6egaD78b4LReL/kNZ49LMxgjJXBVduf/EznnwHVLrf3GTEgW4gE4g9v5Dta0sh+5R6I3j2p92cN3pYW76KJJT/9W97mMR30ek7/VG3mJ6nY2yxaq0gN5ZdJEqA1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429684; c=relaxed/simple;
	bh=vDcSgAQa409cRXTgaJAR5riXfK3updODx7nPBDQA+tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EztZmZ96OVZxIuTJ6JfDE2MMI4c2u9F+5kAcq8mBSe9iGuw+Q/MeEHfs7j9BwnPD6/01BH8oQcYWh11vkaXqjCzBHKbDY0R/JU5phvmgflnGo4Zd24qvDvyzfPYVcNTr/ZluMCurS+cgZ0fA7Rr3MeaWxTJAW12+RwKESGnu5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=FdN3iRqv; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4bc9e48bbso1885358a34.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 21:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772429681; x=1773034481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLSAB8keKBWKMqgkX9ivvWJMREPDLIIa1nSzFsdU3GE=;
        b=FdN3iRqvfu1YurCErOz9jBnSmssRgY2SFRlpqgXD45OPlZWcF/A9Q3k8VyDfEcnLIu
         xhDsggy+FC6rkeSMVJmdNL/v6nrAiLTC+AEh5sh3PK9/FaYDSMauJfP59Zp74WcNBkEH
         nc6TkekQXBRWd03nUucxAkLmkrDgxzbmnEvbZkwHqQ/DppYHNGtUhW4pu4pvHAGoEDwI
         hzq/YtA/p1wkVdvj0Xyt39VGuEUPd4LbQKWWCmh20vowb4Ue8xozWEVGIuQFEYFjzfGt
         eXhQA/8CgkFEKhgNM7E5YLmzQFFtdVAYZ4vMbt9IDGaDCfxBQwdrNUrLBfaNF6zOqQH6
         G9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429681; x=1773034481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gLSAB8keKBWKMqgkX9ivvWJMREPDLIIa1nSzFsdU3GE=;
        b=Z/NiXf9/0V7dNENKOYUoeFaBIUTOJdsDG/8JpcxNSBmpqQk2AHmx9MMWhv8vJ9hDw0
         ZkS6fpEgeeKYX/JITxF0a/e+AZK2/MqOdDd3NE8uhvKbUcNNPTfzx0394tovgyvP0gaB
         RnqkOwwIfHHZXIDQn1m+GAtfdn26p6/tdugl4T6oMM6k5h7lSfysYK27TNIqeKkPK75M
         3FYZO4saWvBYZpVHe9O8Rczbz6KN9spOhgGPiExMAiUEbaOwYmn9CNkasVHiCYky4tyV
         7Q1j5Y4p5GzjKNh+ClTCDwJtmB48+gWZRsTQRFhcTTN8S2jmmAIBVS52O4J4bdFJUvP4
         u/1w==
X-Gm-Message-State: AOJu0Yy2p2QDnUQr8EOnC4y7sTCN8WE+h3S3lGC3TEyIzxwm2nGMioVe
	+opAf/PMoFIsKRm6YLsqLMPEn37dpthoudahrHn0TUtrcRVSEhbmC7YB9jRG4CHEPPJEPgksj7J
	vKV59
X-Gm-Gg: ATEYQzydFoEXaAFlaaaeQtRsFgSrOXpvg96Ez1V6Bzdoe4v2eFkdjV28cJFWfdTBgz0
	Gz2rFC+AJ1YnoJa/sxyZFY4L0me0puxUN9qQORdcYXboQfj9fGsy/TD+65XJ1PJEp5unhdhHwNP
	Elhtg9kWWPzNhRIKzxyng/61AT5lVqMU0TblsI9ybnmJSyq/y87xydzSix3Yu+r7ivhtMdpdXkq
	Fag8oZ8kkb1mSkyN79nFvU6dDF+1RqOZix6uEvGQbY3DCGu16mgWHhaOpMO6oGu+rlsK1cl94UJ
	EkeIuM+/uK8oJLASm9pHapQMGMOHc3dWBeLONYtVXDjj1pNpmMKfyI96aBNrRlvEqz/MCdGMTK8
	r9AyppmKNeG0FRSiiovEwUAjbO6Oxf4ICONjICVAzQRu9QWcqzCq56jXOmau/1X8Duz5NuMUNZo
	FFgPuV5atsRye0BV0ZahlAr/yEBOzModJilBn+hZPN
X-Received: by 2002:a05:6830:4103:b0:7cf:d7fe:fa2d with SMTP id 46e09a7af769-7d591bcdb0cmr7028936a34.17.1772429681461;
        Sun, 01 Mar 2026 21:34:41 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866541e5sm10108207a34.20.2026.03.01.21.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:34:41 -0800 (PST)
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
Subject: [PATCH net-next v2 3/4] selftests/net: Add env for container based tests
Date: Sun,  1 Mar 2026 21:33:14 -0800
Message-ID: <20260302053315.1919859-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302053315.1919859-1-dw@davidwei.uk>
References: <20260302053315.1919859-1-dw@davidwei.uk>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262496-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei-uk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netns.name:url,davidwei.uk:mid,davidwei.uk:email,lib.py:url,iogearbox.net:email]
X-Rspamd-Queue-Id: 2068B1D3246
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
 .../testing/selftests/drivers/net/README.rst  |  38 ++++
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
 .../selftests/drivers/net/lib/py/env.py       | 208 ++++++++++++++++++
 4 files changed, 254 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index eb838ae94844..24bf4e10024f 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -62,6 +62,44 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
 
 Local and remote endpoint IP addresses.
 
+LOCAL_PREFIX_V6
+~~~~~~~~~~~~~~~
+
+Local IP prefix/subnet which can be used to allocate extra IP addresses (for
+network name spaces behind macvlan, veth, netkit devices). DUT must be
+reachable using these addresses from the endpoint.
+
+LOCAL_PREFIX_V6 must NOT match LOCAL_V6.
+
+Example:
+  NETIF           = "eth0"
+  LOCAL_V6        = "2001:db8::1"
+  REMOTE_V6       = "2001:db8::2"
+  LOCAL_PREFIX_V6 = "fd00:cafe::"
+
+          +-----------------------------+        +------------------------------+
+  dst     | INIT NS                     |        | TEST NS                      |
+  fd00:   | +-------------+             |        |                              |
+  cafe::  | | NETIF       |             |  bpf   |                              |
+  2:2 +---|>| 2001:db8::1 |             |redirect| +-------------------------+  |
+      |   | |             |-------------|--------|>| Netkit                  |  |
+      |   | +-------------+             | _peer  | | nk_guest                |  |
+      |   | +-------------+ Netkit pair |        | | fe80::2/64              |  |
+      |   | | Netkit      |.............|........|>| fd00:cafe::2:2/64       |  |
+      |   | | nk_host     |             |        | +-------------------------+  |
+      |   | | fe80::1/64  |             |        |                              |
+      |   | +-------------+             |        | route:                       |
+      |   |                             |        |   default                    |
+      |   | route:                      |        |     via fe80::1 dev nk_guest |
+      |   |   fd00:cafe::2:2/128        |        +------------------------------+
+      |   |     via fe80::2 dev nk_host |
+      |   +-----------------------------+
+      |
+      |   +---------------+
+      |   | REMOTE        |
+      +---| 2001:db8::2   |
+          +---------------+
+
 REMOTE_TYPE
 ~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1971577d47e9..b8d9ae282390 100644
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
@@ -30,7 +31,7 @@ try:
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
-    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
@@ -45,8 +46,8 @@ try:
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
index e5ef5e949c12..374d4f08dd05 100644
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
index 41cc248ac848..36d98e1df15b 100644
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
@@ -289,3 +292,208 @@ class NetDrvEpEnv(NetDrvEnvBase):
                 data.get('stats-block-usecs', 0) / 1000 / 1000
 
         time.sleep(self._stats_settle_time)
+
+
+class NetDrvContEnv(NetDrvEpEnv):
+    """
+    Class for an environment with a netkit pair setup for forwarding traffic
+    between the physical interface and a network namespace.
+      NETIF           = "eth0"
+      LOCAL_V6        = "2001:db8::1"
+      REMOTE_V6       = "2001:db8::2"
+      LOCAL_PREFIX_V6 = "fd00:cafe::"
+
+              +-----------------------------+        +------------------------------+
+      dst     | INIT NS                     |        | TEST NS                      |
+      fd00:   | +-------------+             |        |                              |
+      cafe::  | | NETIF       |             |  bpf   |                              |
+      2:2 +---|>| 2001:db8::1 |             |redirect| +-------------------------+  |
+          |   | |             |-------------|--------|>| Netkit                  |  |
+          |   | +-------------+             | _peer  | | nk_guest                |  |
+          |   | +-------------+ Netkit pair |        | | fe80::2/64              |  |
+          |   | | Netkit      |.............|........|>| fd00:cafe::2:2/64       |  |
+          |   | | nk_host     |             |        | +-------------------------+  |
+          |   | | fe80::1/64  |             |        |                              |
+          |   | +-------------+             |        | route:                       |
+          |   |                             |        |   default                    |
+          |   | route:                      |        |     via fe80::1 dev nk_guest |
+          |   |   fd00:cafe::2:2/128        |        +------------------------------+
+          |   |     via fe80::2 dev nk_host |
+          |   +-----------------------------+
+          |
+          |   +---------------+
+          |   | REMOTE        |
+          +---| 2001:db8::2   |
+              +---------------+
+    """
+
+    def __init__(self, src_path, rxqueues=1, **kwargs):
+        self.netns = None
+        self._nk_host_ifname = None
+        self._nk_guest_ifname = None
+        self._tc_clsact_added = False
+        self._tc_attached = False
+        self._bpf_prog_pref = None
+        self._bpf_prog_id = None
+        self._init_ns_attached = False
+        self._old_fwd = None
+        self._old_accept_ra = None
+
+        super().__init__(src_path, **kwargs)
+
+        self.require_ipver("6")
+        local_prefix = self.env.get("LOCAL_PREFIX_V6")
+        if not local_prefix:
+            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
+
+        try:
+            net = ipaddress.IPv6Network(local_prefix, strict=False)
+        except ValueError:
+            net = ipaddress.IPv6Network(f"{local_prefix}::/64", strict=False)
+        self.ipv6_prefix = str(net.network_address)
+        self.nk_host_ipv6 = f"{self.ipv6_prefix}2:1"
+        self.nk_guest_ipv6 = f"{self.ipv6_prefix}2:2"
+
+        local_v6 = ipaddress.IPv6Address(self.addr_v["6"])
+        if local_v6 in net:
+            raise KsftSkipEx("LOCAL_V6 must not fall within LOCAL_PREFIX_V6")
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
+        if self._old_fwd is not None:
+            with open("/proc/sys/net/ipv6/conf/all/forwarding", "w") as f:
+                f.write(self._old_fwd)
+            self._old_fwd = None
+        if self._old_accept_ra is not None:
+            with open("/proc/sys/net/ipv6/conf/all/accept_ra", "w") as f:
+                f.write(self._old_accept_ra)
+            self._old_accept_ra = None
+
+        super().__del__()
+
+    def _setup_ns(self):
+        fwd_path = "/proc/sys/net/ipv6/conf/all/forwarding"
+        ra_path = "/proc/sys/net/ipv6/conf/all/accept_ra"
+        with open(fwd_path) as f:
+            self._old_fwd = f.read().strip()
+        with open(ra_path) as f:
+            self._old_accept_ra = f.read().strip()
+        with open(fwd_path, "w") as f:
+            f.write("1")
+        with open(ra_path, "w") as f:
+            f.write("2")
+
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


