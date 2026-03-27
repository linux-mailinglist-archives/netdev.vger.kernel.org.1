Return-Path: <netdev+bounces-272541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFkCOBF0xmkCKgUAu9opvQ
	(envelope-from <netdev+bounces-272541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:12:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E6834403C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAFF5305FDBA
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0933BADB5;
	Fri, 27 Mar 2026 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MA46AKuf"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1539B4A9;
	Fri, 27 Mar 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613488; cv=none; b=SfZxniQGS15enQC3FN38lV3hnw/H8cAxe6njuumvfPih/mFiZasBTN0EphkFMYdcq4/2s6jHtnzTVoMr2Lsh4YAo0BRTAS7uDc6jtpBVPE79uPHl1Apsasm4bxCCotos42SmDCPmTyHJz0pQ8gJ0zph9m70LMSU2IGWEwd/cVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613488; c=relaxed/simple;
	bh=GKMzyAz7kb8aCAzEY+j/uWWSNNUcvKCZgdPZxY9q0Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV5ZxxI38cmyuDFfTUt8v6Qy65MLOjcdfxT6IQmDxhvYPwwUuQUje5YXIlYGdSvTEtz2xeNuGKKwTv2tM2mhsxrQqszn2gtm5gAdQ2OPCs/IsaDgPp48aYAEJJfakk9udNOK9E28OqPZE29QLrUp11GRasexm/pcy+eub8fof6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MA46AKuf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Vp2WtWArUAm8tDZNKlcnZ04raV04yAqn+eFYmnB4pQI=; b=MA46AKufmHZL/MXwv3+TWiLZVm
	8B8jqlQEZaQiMWUMOyClPpLpFQ5oHnAQHAnWjNfmHnvQwKVP2WzkcLKX5WEItJOwhy0uG0YqspQOu
	E1bzf2+n+gvewG/UEiiUwToJCDf5kcifrsJRSbqz81OsAdYmjOC+ff/niLEnCvK0zj0S2yH6/nsJK
	5HhwxYVDPgEcoT5x9Llw2RIQFHG59mlONMIi6RAx4qOSscn6rJZs/Ze18Yxe9I+FYxuFJp9mec9/U
	tuUB96Yt752ppEZT1jCTmY/2y+snrtQDKj1tqYUVGnXgkhwxdJG+TbdEHI0lzTjcISIWMdvqZW1Gq
	c9YyQoeQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w661r-000APq-2m;
	Fri, 27 Mar 2026 13:11:07 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v10 14/14] selftests/net: Add queue leasing tests with netkit
Date: Fri, 27 Mar 2026 13:10:49 +0100
Message-ID: <20260327121049.334562-15-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327121049.334562-1-daniel@iogearbox.net>
References: <20260327121049.334562-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27953/Fri Mar 27 07:24:46 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272541-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davidwei.uk:email,lib.py:url,nk_qlease.py:url]
X-Rspamd-Queue-Id: 88E6834403C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Wei <dw@davidwei.uk>

Add a selftest for netkit queue leasing, using io_uring zero copy test
binary inside of a netns with netkit. This checks that memory providers
can be bound against virtual queues in a netkit within a netns that are
leasing from a physical netdev in the default netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   4 +-
 .../selftests/drivers/net/hw/nk_qlease.py     | 597 ++++++++++++++++++
 3 files changed, 600 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3c97dac9baaa..45a2a897fec7 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -34,6 +34,7 @@ TEST_PROGS = \
 	loopback.sh \
 	nic_timestamp.py \
 	nk_netns.py \
+	nk_qlease.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index b8d9ae282390..0fd866641695 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -20,7 +20,7 @@ try:
     # Import one by one to avoid pylint false positives
     from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily, DevlinkFamily, PSPFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
@@ -35,7 +35,7 @@ try:
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
-               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
new file mode 100755
index 000000000000..d2626f75f15b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -0,0 +1,597 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import errno
+import re
+import time
+import threading
+from os import path
+from lib.py import (
+    ksft_run,
+    ksft_exit,
+    ksft_eq,
+    ksft_ne,
+    ksft_in,
+    ksft_not_in,
+    ksft_raises,
+)
+from lib.py import (
+    NetDrvContEnv,
+    NetNS,
+    NetNSEnter,
+    EthtoolFamily,
+    NetdevFamily,
+    RtnlFamily,
+    NetdevSimDev,
+)
+from lib.py import (
+    NlError,
+    Netlink,
+    bkg,
+    cmd,
+    defer,
+    ethtool,
+    ip,
+    rand_port,
+    wait_port_listen,
+)
+from lib.py import KsftSkipEx, CmdExitFailure
+
+
+def set_flow_rule(cfg):
+    output = ethtool(
+        f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.src_queue}"
+    ).stdout
+    values = re.search(r"ID (\d+)", output).group(1)
+    return int(values)
+
+
+def create_netkit(rxqueues):
+    rtnl = RtnlFamily()
+    rtnl.newlink(
+        {
+            "linkinfo": {
+                "kind": "netkit",
+                "data": {
+                    "mode": "l2",
+                    "policy": "forward",
+                    "peer-policy": "forward",
+                },
+            },
+            "num-rx-queues": rxqueues,
+        },
+        flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
+    )
+
+    all_links = ip("-d link show", json=True)
+    nk_links = [
+        link
+        for link in all_links
+        if link.get("linkinfo", {}).get("info_kind") == "netkit"
+        and "UP" not in link.get("flags", [])
+    ]
+    nk_links.sort(key=lambda x: x["ifindex"])
+    return (
+        nk_links[1]["ifname"],
+        nk_links[1]["ifindex"],
+        nk_links[0]["ifname"],
+        nk_links[0]["ifindex"],
+    )
+
+
+def test_remove_phys(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    src_queue = 1
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        result = netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": src_queue, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+        nk_queue_id = result["id"]
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
+
+    nsimdev.remove()
+    time.sleep(0.1)
+    ret = cmd(f"ip link show dev {nk_host}", fail=False)
+    ksft_ne(ret.ret, 0)
+
+
+def test_double_lease(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=3)
+    defer(cmd, f"ip link del dev {nk_host}")
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    src_queue = 1
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": src_queue, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+
+        with ksft_raises(NlError) as e:
+            netdevnl.queue_create(
+                {
+                    "ifindex": nk_guest_idx,
+                    "type": "rx",
+                    "lease": {
+                        "ifindex": nsim.ifindex,
+                        "queue": {"id": src_queue, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.EBUSY)
+
+
+def test_virtual_lessor(netns) -> None:
+    nk_host_a, _, nk_guest_a, nk_guest_a_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host_a}")
+    ip(f"link set dev {nk_host_a} up")
+    ip(f"link set dev {nk_guest_a} up")
+
+    nk_host_b, _, nk_guest_b, nk_guest_b_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host_b}")
+
+    ip(f"link set dev {nk_guest_b} netns {netns.name}")
+    ip(f"link set dev {nk_host_b} up")
+    ip(f"link set dev {nk_guest_b} up", ns=netns)
+
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        with ksft_raises(NlError) as e:
+            netdevnl.queue_create(
+                {
+                    "ifindex": nk_guest_b_idx,
+                    "type": "rx",
+                    "lease": {
+                        "ifindex": nk_guest_a_idx,
+                        "queue": {"id": 0, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_phys_lessee(_netns) -> None:
+    nsimdev_a = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev_a.remove)
+    nsim_a = nsimdev_a.nsims[0]
+    ip(f"link set dev {nsim_a.ifname} up")
+
+    nsimdev_b = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev_b.remove)
+    nsim_b = nsimdev_b.nsims[0]
+    ip(f"link set dev {nsim_b.ifname} up")
+
+    netdevnl = NetdevFamily()
+    with ksft_raises(NlError) as e:
+        netdevnl.queue_create(
+            {
+                "ifindex": nsim_a.ifindex,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim_b.ifindex,
+                    "queue": {"id": 0, "type": "rx"},
+                },
+            }
+        )
+    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_different_lessors(netns) -> None:
+    nsimdev_a = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev_a.remove)
+    nsim_a = nsimdev_a.nsims[0]
+    ip(f"link set dev {nsim_a.ifname} up")
+
+    nsimdev_b = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev_b.remove)
+    nsim_b = nsimdev_b.nsims[0]
+    ip(f"link set dev {nsim_b.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=3)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim_a.ifindex,
+                    "queue": {"id": 1, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+
+        with ksft_raises(NlError) as e:
+            netdevnl.queue_create(
+                {
+                    "ifindex": nk_guest_idx,
+                    "type": "rx",
+                    "lease": {
+                        "ifindex": nsim_b.ifindex,
+                        "queue": {"id": 1, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.EOPNOTSUPP)
+
+
+def test_queue_out_of_range(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        with ksft_raises(NlError) as e:
+            netdevnl.queue_create(
+                {
+                    "ifindex": nk_guest_idx,
+                    "type": "rx",
+                    "lease": {
+                        "ifindex": nsim.ifindex,
+                        "queue": {"id": 2, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.ERANGE)
+
+
+def test_resize_leased(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": 1, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+
+    ethnl = EthtoolFamily()
+    with ksft_raises(NlError) as e:
+        ethnl.channels_set({"header": {"dev-index": nsim.ifindex}, "combined-count": 1})
+    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_self_lease(_netns) -> None:
+    nk_host, _, _, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    netdevnl = NetdevFamily()
+    with ksft_raises(NlError) as e:
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nk_guest_idx,
+                    "queue": {"id": 0, "type": "rx"},
+                },
+            }
+        )
+    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_iou_zcrx(cfg) -> None:
+    cfg.require_ipver("6")
+    ethnl = EthtoolFamily()
+
+    rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
+    rx_rings = rings["rx"]
+    hds_thresh = rings.get("hds-thresh", 0)
+
+    ethnl.rings_set(
+        {
+            "header": {"dev-index": cfg.ifindex},
+            "tcp-data-split": "enabled",
+            "hds-thresh": 0,
+            "rx": 64,
+        }
+    )
+    defer(
+        ethnl.rings_set,
+        {
+            "header": {"dev-index": cfg.ifindex},
+            "tcp-data-split": "unknown",
+            "hds-thresh": hds_thresh,
+            "rx": rx_rings,
+        },
+    )
+
+    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    flow_rule_id = set_flow_rule(cfg)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
+        cmd(tx_cmd, host=cfg.remote)
+
+
+def test_attrs(cfg) -> None:
+    cfg.require_ipver("6")
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+    )
+
+    ksft_eq(queue_info["id"], cfg.src_queue)
+    ksft_eq(queue_info["type"], "rx")
+    ksft_eq(queue_info["ifindex"], cfg.ifindex)
+
+    ksft_in("lease", queue_info)
+    lease = queue_info["lease"]
+    ksft_eq(lease["ifindex"], cfg.nk_guest_ifindex)
+    ksft_eq(lease["queue"]["id"], cfg.nk_queue)
+    ksft_eq(lease["queue"]["type"], "rx")
+    ksft_in("netns-id", lease)
+
+
+def test_attach_xdp_with_mp(cfg) -> None:
+    cfg.require_ipver("6")
+    ethnl = EthtoolFamily()
+
+    rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
+    rx_rings = rings["rx"]
+    hds_thresh = rings.get("hds-thresh", 0)
+
+    ethnl.rings_set(
+        {
+            "header": {"dev-index": cfg.ifindex},
+            "tcp-data-split": "enabled",
+            "hds-thresh": 0,
+            "rx": 64,
+        }
+    )
+    defer(
+        ethnl.rings_set,
+        {
+            "header": {"dev-index": cfg.ifindex},
+            "tcp-data-split": "unknown",
+            "hds-thresh": hds_thresh,
+            "rx": rx_rings,
+        },
+    )
+
+    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    netdevnl = NetdevFamily()
+
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    with bkg(rx_cmd):
+        wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
+
+        time.sleep(0.1)
+        queue_info = netdevnl.queue_get(
+            {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+        )
+        ksft_in("io-uring", queue_info)
+
+        prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+        with ksft_raises(CmdExitFailure):
+            ip(f"link set dev {cfg.ifname} xdp obj {prog} sec xdp.frags")
+
+    time.sleep(0.1)
+    queue_info = netdevnl.queue_get(
+        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+    )
+    ksft_not_in("io-uring", queue_info)
+
+
+def test_destroy(cfg) -> None:
+    cfg.require_ipver("6")
+    ethnl = EthtoolFamily()
+
+    rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
+    rx_rings = rings["rx"]
+    hds_thresh = rings.get("hds-thresh", 0)
+
+    ethnl.rings_set(
+        {
+            "header": {"dev-index": cfg.ifindex},
+            "tcp-data-split": "enabled",
+            "hds-thresh": 0,
+            "rx": 64,
+        }
+    )
+    defer(
+        ethnl.rings_set,
+        {
+            "header": {"dev-index": cfg.ifindex},
+            "tcp-data-split": "unknown",
+            "hds-thresh": hds_thresh,
+            "rx": rx_rings,
+        },
+    )
+
+    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_proc = cmd(rx_cmd, background=True)
+    wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+    )
+    ksft_in("io-uring", queue_info)
+
+    # ip link del will wait for all refs to drop first, but iou-zcrx is holding
+    # onto a ref. Terminate iou-zcrx async via a thread after a delay.
+    kill_timer = threading.Timer(1, rx_proc.proc.terminate)
+    kill_timer.start()
+
+    ip(f"link del dev {cfg._nk_host_ifname}")
+    kill_timer.join()
+    cfg._nk_host_ifname = None
+    cfg._nk_guest_ifname = None
+
+    queue_info = netdevnl.queue_get(
+        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+    )
+    ksft_not_in("io-uring", queue_info)
+
+    cmd(f"tc filter del dev {cfg.ifname} ingress pref {cfg._bpf_prog_pref}")
+    cfg._tc_attached = False
+
+    flow_rule_id = set_flow_rule(cfg)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.src_queue}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(cfg.port, proto="tcp")
+        cmd(tx_cmd, host=cfg.remote)
+    # Short delay since iou cleanup is async and takes a bit of time.
+    time.sleep(0.1)
+    queue_info = netdevnl.queue_get(
+        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+    )
+    ksft_not_in("io-uring", queue_info)
+
+
+def main() -> None:
+    netns = NetNS()
+    cmd("ip netns attach init 1")
+    ip("netns set init 0", ns=netns)
+    ip("link set lo up", ns=netns)
+
+    ksft_run(
+        [
+            test_remove_phys,
+            test_double_lease,
+            test_virtual_lessor,
+            test_phys_lessee,
+            test_different_lessors,
+            test_queue_out_of_range,
+            test_resize_leased,
+            test_self_lease,
+        ],
+        args=(netns,),
+    )
+
+    cmd("ip netns del init", fail=False)
+    del netns
+
+    with NetDrvContEnv(__file__, rxqueues=2) as cfg:
+        cfg.bin_local = path.abspath(
+            path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx"
+        )
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+        cfg.port = rand_port()
+
+        ethnl = EthtoolFamily()
+        channels = ethnl.channels_get({"header": {"dev-index": cfg.ifindex}})
+        channels = channels["combined-count"]
+        if channels < 2:
+            raise KsftSkipEx("Test requires NETIF with at least 2 combined channels")
+
+        cfg.src_queue = channels - 1
+
+        with NetNSEnter(str(cfg.netns)):
+            netdevnl = NetdevFamily()
+            bind_result = netdevnl.queue_create(
+                {
+                    "ifindex": cfg.nk_guest_ifindex,
+                    "type": "rx",
+                    "lease": {
+                        "ifindex": cfg.ifindex,
+                        "queue": {"id": cfg.src_queue, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+            cfg.nk_queue = bind_result["id"]
+
+        # test_destroy must be last because it destroys the netkit devices
+        ksft_run(
+            [test_iou_zcrx, test_attrs, test_attach_xdp_with_mp, test_destroy],
+            args=(cfg,),
+        )
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


