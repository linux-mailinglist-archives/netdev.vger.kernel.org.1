Return-Path: <netdev+bounces-278212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI7ZOalp3WnfdwkAu9opvQ
	(envelope-from <netdev+bounces-278212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:09:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2293F3B71
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7A23039C8D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED3039B489;
	Mon, 13 Apr 2026 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VmslWjCh"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEF33F593
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118105; cv=none; b=PET8cMWFUTmGLu8kAjeyfTlSW5a0QXfyG0+hs6uSlVt/sjwiIVVyQQHzxUvjH7SplkDBZ9/hyp4Ul27YWYI0T9Axk7peQ75R0uciTVATMFLzd5Bd64698vkkBmjx7rnoGeeWMIKOyyZV150Tw6wPhhOby9VBf6Q8g9v0yT+xA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118105; c=relaxed/simple;
	bh=yGT7xreL41+47z2jMZ7kapt4R+ZjwI4aPGYoDAgiMgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlPIm4SxBLix6KgmPJODLrQpHsLZvXTFsYa7u0xiqmIGZqczGhminFooVcMtPXq3suOI1ENqmvbV+jTz3L7+ouB+h/v7P39yYQCM316JeHaEx3gSG1ztcy3+IGKZf+bxoyxtY83/osGD4lCiInkWP6qlCbuO8sOMvbAElAZZxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VmslWjCh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pGjSeeW2FtCqbbzuIpNI8Xu4yjQgGlm/8OkOW1Qu9xE=; b=VmslWjChLCQGX0Y079ehnyn6MQ
	4Lau09e8qMJKN7HOCcWBdtRchqUNNZ1Q0NlhUqpaUaKzyWwJaB65T+CGaxBWCaaSPxsOCKRDxFS20
	kT00VEGHVHtfimbLFUabiyYYU2zKoOxF2pdv17cCsTZl+2idVWSJGQ0/r6UGWEPW+O9vChETYpLzF
	blAC7v6NYJIBriRjkkAoRcxaKmNnKl+QglMt9jGeRI+tYFCDY8DcInTiCvFoS7KErpfgM/4pryf2V
	uakK7Jf4nbaDv8YkCO8vb20PyE5Dqr3Dvx3ReQiWRYq+/Q+6F0KZWRVwAHpxB7O/0fGgISZvTRvCG
	yR+S450w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCPRz-000DWa-1m;
	Tue, 14 Apr 2026 00:08:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	dw@davidwei.uk,
	pabeni@redhat.com,
	razor@blackwall.org
Subject: [PATCH net-next v2 2/3] selftests/net: Split netdevsim tests from HW tests in nk_qlease
Date: Tue, 14 Apr 2026 00:08:05 +0200
Message-ID: <20260413220809.604592-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413220809.604592-1-daniel@iogearbox.net>
References: <20260413220809.604592-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27970/Mon Apr 13 08:24:33 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278212-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,lib.py:url]
X-Rspamd-Queue-Id: 1F2293F3B71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As pointed out in 3d2c3d2eea9a ("selftests: net: py: explicitly forbid
multiple ksft_run() calls"), ksft_run() cannot be called multiple times.

Move the netdevsim-based queue lease tests to selftests/net/ so that
each file has exactly one ksft_run() call.

The HW tests (io_uring ZC RX, queue attrs, XDP with MP, destroy) remain
in selftests/drivers/net/hw/.

Fixes: 65d657d80684 ("selftests/net: Add queue leasing tests with netkit")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/netdev/20260409181950.7e099b6c@kernel.org
---
 .../selftests/drivers/net/hw/nk_qlease.py     | 1142 ----------------
 tools/testing/selftests/net/Makefile          |    1 +
 tools/testing/selftests/net/nk_qlease.py      | 1168 +++++++++++++++++
 3 files changed, 1169 insertions(+), 1142 deletions(-)
 create mode 100755 tools/testing/selftests/net/nk_qlease.py

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index 2bc5ffe96c7d..aa83dc321328 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -1,7 +1,6 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-import errno
 import re
 import time
 import threading
@@ -10,23 +9,17 @@ from lib.py import (
     ksft_run,
     ksft_exit,
     ksft_eq,
-    ksft_ne,
     ksft_in,
     ksft_not_in,
     ksft_raises,
 )
 from lib.py import (
     NetDrvContEnv,
-    NetNS,
     NetNSEnter,
     EthtoolFamily,
     NetdevFamily,
-    RtnlFamily,
-    NetdevSimDev,
 )
 from lib.py import (
-    NlError,
-    Netlink,
     bkg,
     cmd,
     defer,
@@ -46,1100 +39,6 @@ def set_flow_rule(cfg):
     return int(values)
 
 
-def create_netkit(rxqueues):
-    all_links = ip("-d link show", json=True)
-    old_idxs = {
-        link["ifindex"]
-        for link in all_links
-        if link.get("linkinfo", {}).get("info_kind") == "netkit"
-    }
-
-    rtnl = RtnlFamily()
-    rtnl.newlink(
-        {
-            "linkinfo": {
-                "kind": "netkit",
-                "data": {
-                    "mode": "l2",
-                    "policy": "forward",
-                    "peer-policy": "forward",
-                },
-            },
-            "num-rx-queues": rxqueues,
-        },
-        flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
-    )
-
-    all_links = ip("-d link show", json=True)
-    nk_links = [
-        link
-        for link in all_links
-        if link.get("linkinfo", {}).get("info_kind") == "netkit"
-        and link["ifindex"] not in old_idxs
-    ]
-    nk_links.sort(key=lambda x: x["ifindex"])
-    return (
-        nk_links[1]["ifname"],
-        nk_links[1]["ifindex"],
-        nk_links[0]["ifname"],
-        nk_links[0]["ifindex"],
-    )
-
-
-def create_netkit_single(rxqueues):
-    rtnl = RtnlFamily()
-    rtnl.newlink(
-        {
-            "linkinfo": {
-                "kind": "netkit",
-                "data": {
-                    "mode": "l2",
-                    "pairing": "single",
-                },
-            },
-            "num-rx-queues": rxqueues,
-        },
-        flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
-    )
-
-    all_links = ip("-d link show", json=True)
-    nk_links = [
-        link
-        for link in all_links
-        if link.get("linkinfo", {}).get("info_kind") == "netkit"
-        and "UP" not in link.get("flags", [])
-    ]
-    return nk_links[0]["ifname"], nk_links[0]["ifindex"]
-
-
-def test_remove_phys(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    src_queue = 1
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        result = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": src_queue, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        nk_queue_id = result["id"]
-
-    netdevnl = NetdevFamily()
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["ifindex"], nk_guest_idx)
-    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
-
-    nsimdev.remove()
-    time.sleep(0.1)
-    ret = cmd(f"ip link show dev {nk_host}", fail=False)
-    ksft_ne(ret.ret, 0)
-
-
-def test_double_lease(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=3)
-    defer(cmd, f"ip link del dev {nk_host}")
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    src_queue = 1
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        result = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": src_queue, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        ksft_eq(result["id"], 1)
-
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": nsim.ifindex,
-                        "queue": {"id": src_queue, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.EBUSY)
-
-
-def test_virtual_lessor(netns) -> None:
-    nk_host_a, _, nk_guest_a, nk_guest_a_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host_a}")
-    ip(f"link set dev {nk_host_a} up")
-    ip(f"link set dev {nk_guest_a} up")
-
-    nk_host_b, _, nk_guest_b, nk_guest_b_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host_b}")
-
-    ip(f"link set dev {nk_guest_b} netns {netns.name}")
-    ip(f"link set dev {nk_host_b} up")
-    ip(f"link set dev {nk_guest_b} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_b_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": nk_guest_a_idx,
-                        "queue": {"id": 0, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-
-def test_phys_lessee(_netns) -> None:
-    nsimdev_a = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev_a.remove)
-    nsim_a = nsimdev_a.nsims[0]
-    ip(f"link set dev {nsim_a.ifname} up")
-
-    nsimdev_b = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev_b.remove)
-    nsim_b = nsimdev_b.nsims[0]
-    ip(f"link set dev {nsim_b.ifname} up")
-
-    netdevnl = NetdevFamily()
-    with ksft_raises(NlError) as e:
-        netdevnl.queue_create(
-            {
-                "ifindex": nsim_a.ifindex,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim_b.ifindex,
-                    "queue": {"id": 0, "type": "rx"},
-                },
-            }
-        )
-    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-
-def test_different_lessors(netns) -> None:
-    nsimdev_a = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev_a.remove)
-    nsim_a = nsimdev_a.nsims[0]
-    ip(f"link set dev {nsim_a.ifname} up")
-
-    nsimdev_b = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev_b.remove)
-    nsim_b = nsimdev_b.nsims[0]
-    ip(f"link set dev {nsim_b.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=3)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim_a.ifindex,
-                    "queue": {"id": 1, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": nsim_b.ifindex,
-                        "queue": {"id": 1, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.EOPNOTSUPP)
-
-
-def test_queue_out_of_range(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": nsim.ifindex,
-                        "queue": {"id": 2, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.ERANGE)
-
-
-def test_resize_leased(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 1, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-
-    ethnl = EthtoolFamily()
-    with ksft_raises(NlError) as e:
-        ethnl.channels_set({"header": {"dev-index": nsim.ifindex}, "combined-count": 1})
-    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-
-def test_self_lease(_netns) -> None:
-    nk_host, _, _, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    netdevnl = NetdevFamily()
-    with ksft_raises(NlError) as e:
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nk_guest_idx,
-                    "queue": {"id": 0, "type": "rx"},
-                },
-            }
-        )
-    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-
-def test_veth_queue_create(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    ip("link add veth0 type veth peer name veth1")
-    defer(cmd, "ip link del dev veth0", fail=False)
-
-    all_links = ip("-d link show", json=True)
-    veth_peer = [
-        link
-        for link in all_links
-        if link.get("ifname") == "veth1"
-    ]
-    veth_peer_idx = veth_peer[0]["ifindex"]
-
-    ip(f"link set dev veth1 netns {netns.name}")
-    ip("link set dev veth0 up")
-    ip("link set dev veth1 up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": veth_peer_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": nsim.ifindex,
-                        "queue": {"id": 1, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-
-def test_create_tx_type(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_idx,
-                    "type": "tx",
-                    "lease": {
-                        "ifindex": nsim.ifindex,
-                        "queue": {"id": 1, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-
-def test_create_primary(_netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, nk_host_idx, _, _ = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_host} up")
-
-    netdevnl = NetdevFamily()
-    with ksft_raises(NlError) as e:
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_host_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 1, "type": "rx"},
-                },
-            }
-        )
-    ksft_eq(e.exception.nl_msg.error, -errno.EOPNOTSUPP)
-
-
-def test_create_limit(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=1)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": nsim.ifindex,
-                        "queue": {"id": 1, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-
-def test_link_flap_phys(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}")
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    src_queue = 1
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        result = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": src_queue, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        nk_queue_id = result["id"]
-
-    netdevnl = NetdevFamily()
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
-
-    # Link flap the physical device
-    ip(f"link set dev {nsim.ifname} down")
-    ip(f"link set dev {nsim.ifname} up")
-
-    # Verify lease survives the flap
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
-
-
-def test_queue_get_virtual(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}")
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    src_queue = 1
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        result = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": src_queue, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        nk_queue_id = result["id"]
-
-        # queue-get on virtual device's leased queue should not show lease
-        # info (lease info is only shown from the physical device's side)
-        queue_info = netdevnl.queue_get(
-            {"ifindex": nk_guest_idx, "id": nk_queue_id, "type": "rx"}
-        )
-        ksft_eq(queue_info["id"], nk_queue_id)
-        ksft_eq(queue_info["ifindex"], nk_guest_idx)
-        ksft_not_in("lease", queue_info)
-
-        # Default queue (not leased) also has no lease info
-        queue_info = netdevnl.queue_get(
-            {"ifindex": nk_guest_idx, "id": 0, "type": "rx"}
-        )
-        ksft_not_in("lease", queue_info)
-
-
-def test_remove_virt_first(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    src_queue = 1
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        result = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": src_queue, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        ksft_eq(result["id"], 1)
-
-    netdevnl = NetdevFamily()
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
-
-    # Delete netkit (virtual device removed first, physical stays)
-    cmd(f"ip link del dev {nk_host}")
-
-    # Verify lease is cleaned up on physical device
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_not_in("lease", queue_info)
-
-
-def test_multiple_leases(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=3)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=4)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        r1 = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 1, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        r2 = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 2, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-
-    ksft_eq(r1["id"], 1)
-    ksft_eq(r2["id"], 2)
-
-    # Verify both leases visible on physical device
-    netdevnl = NetdevFamily()
-    q1 = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
-    )
-    q2 = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
-    )
-    ksft_in("lease", q1)
-    ksft_in("lease", q2)
-    ksft_eq(q1["lease"]["ifindex"], nk_guest_idx)
-    ksft_eq(q2["lease"]["ifindex"], nk_guest_idx)
-    ksft_eq(q1["lease"]["queue"]["id"], r1["id"])
-    ksft_eq(q2["lease"]["queue"]["id"], r2["id"])
-
-
-def test_lease_queue_tx_type(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": nsim.ifindex,
-                        "queue": {"id": 1, "type": "tx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-
-def test_invalid_netns(netns) -> None:
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": 1,
-                        "queue": {"id": 0, "type": "rx"},
-                        "netns-id": 999,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.ENONET)
-
-
-def test_invalid_phys_ifindex(netns) -> None:
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        with ksft_raises(NlError) as e:
-            netdevnl.queue_create(
-                {
-                    "ifindex": nk_guest_idx,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": 99999,
-                        "queue": {"id": 0, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-        ksft_eq(e.exception.nl_msg.error, -errno.ENODEV)
-
-
-def test_multi_netkit_remove_phys(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=3)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    # Create two netkit pairs, each leasing a different physical queue
-    nk_host_a, _, nk_guest_a, nk_guest_a_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host_a}", fail=False)
-
-    nk_host_b, _, nk_guest_b, nk_guest_b_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host_b}", fail=False)
-
-    ip(f"link set dev {nk_guest_a} netns {netns.name}")
-    ip(f"link set dev {nk_host_a} up")
-    ip(f"link set dev {nk_guest_a} up", ns=netns)
-
-    ip(f"link set dev {nk_guest_b} netns {netns.name}")
-    ip(f"link set dev {nk_host_b} up")
-    ip(f"link set dev {nk_guest_b} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_a_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 1, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_b_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 2, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-
-    # Removing the physical device should take down both netkit pairs
-    nsimdev.remove()
-    time.sleep(0.1)
-    ret = cmd(f"ip link show dev {nk_host_a}", fail=False)
-    ksft_ne(ret.ret, 0)
-    ret = cmd(f"ip link show dev {nk_host_b}", fail=False)
-    ksft_ne(ret.ret, 0)
-
-
-def test_single_remove_phys(_netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_name, nk_idx = create_netkit_single(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_name}", fail=False)
-
-    ip(f"link set dev {nk_name} up")
-
-    netdevnl = NetdevFamily()
-    netdevnl.queue_create(
-        {
-            "ifindex": nk_idx,
-            "type": "rx",
-            "lease": {
-                "ifindex": nsim.ifindex,
-                "queue": {"id": 1, "type": "rx"},
-            },
-        }
-    )
-
-    # Removing the physical device should take down the single netkit device
-    nsimdev.remove()
-    time.sleep(0.1)
-    ret = cmd(f"ip link show dev {nk_name}", fail=False)
-    ksft_ne(ret.ret, 0)
-
-
-def test_link_flap_virt(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}")
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    src_queue = 1
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        result = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": src_queue, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        nk_queue_id = result["id"]
-
-    netdevnl = NetdevFamily()
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
-
-    # Link flap the virtual (netkit) device
-    ip(f"link set dev {nk_guest} down", ns=netns)
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    # Verify lease survives the virtual device flap
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
-
-
-def test_phys_queue_no_lease(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}")
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 1, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-
-    # Physical queue 0 (not leased) should have no lease info
-    netdevnl = NetdevFamily()
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": 0, "type": "rx"}
-    )
-    ksft_not_in("lease", queue_info)
-
-    # Physical queue 1 (leased) should have lease info
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-
-
-def test_same_ns_lease(_netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_name, nk_idx = create_netkit_single(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_name}", fail=False)
-
-    ip(f"link set dev {nk_name} up")
-
-    netdevnl = NetdevFamily()
-    result = netdevnl.queue_create(
-        {
-            "ifindex": nk_idx,
-            "type": "rx",
-            "lease": {
-                "ifindex": nsim.ifindex,
-                "queue": {"id": 1, "type": "rx"},
-            },
-        }
-    )
-    ksft_eq(result["id"], 1)
-
-    # Same namespace: lease info should NOT have netns-id
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["ifindex"], nk_idx)
-    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
-    ksft_not_in("netns-id", queue_info["lease"])
-
-
-def test_resize_after_unlease(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 1, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-
-    # Resize should fail while lease is active
-    ethnl = EthtoolFamily()
-    with ksft_raises(NlError) as e:
-        ethnl.channels_set({"header": {"dev-index": nsim.ifindex}, "combined-count": 1})
-    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
-
-    # Delete netkit, clearing the lease
-    cmd(f"ip link del dev {nk_host}")
-
-    # Resize should now succeed
-    ethnl.channels_set({"header": {"dev-index": nsim.ifindex}, "combined-count": 1})
-
-
-def test_lease_queue_zero(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        result = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": 0, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        ksft_eq(result["id"], 1)
-
-    netdevnl = NetdevFamily()
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": 0, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
-
-
-def test_release_and_reuse(netns) -> None:
-    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
-    defer(nsimdev.remove)
-    nsim = nsimdev.nsims[0]
-    ip(f"link set dev {nsim.ifname} up")
-
-    src_queue = 1
-
-    # First lease
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": src_queue, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-
-    netdevnl = NetdevFamily()
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-
-    # Delete netkit, freeing the lease
-    cmd(f"ip link del dev {nk_host}")
-
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_not_in("lease", queue_info)
-
-    # Re-create netkit and lease the same physical queue again
-    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
-    defer(cmd, f"ip link del dev {nk_host}", fail=False)
-
-    ip(f"link set dev {nk_guest} netns {netns.name}")
-    ip(f"link set dev {nk_host} up")
-    ip(f"link set dev {nk_guest} up", ns=netns)
-
-    with NetNSEnter(str(netns)):
-        netdevnl = NetdevFamily()
-        result = netdevnl.queue_create(
-            {
-                "ifindex": nk_guest_idx,
-                "type": "rx",
-                "lease": {
-                    "ifindex": nsim.ifindex,
-                    "queue": {"id": src_queue, "type": "rx"},
-                    "netns-id": 0,
-                },
-            }
-        )
-        ksft_eq(result["id"], 1)
-
-    netdevnl = NetdevFamily()
-    queue_info = netdevnl.queue_get(
-        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
-    )
-    ksft_in("lease", queue_info)
-    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
-
-
 def test_iou_zcrx(cfg) -> None:
     cfg.require_ipver("6")
     ethnl = EthtoolFamily()
@@ -1324,47 +223,6 @@ def test_destroy(cfg) -> None:
 
 
 def main() -> None:
-    netns = NetNS()
-    cmd("ip netns attach init 1")
-    ip("netns set init 0", ns=netns)
-    ip("link set lo up", ns=netns)
-
-    ksft_run(
-        [
-            test_remove_phys,
-            test_double_lease,
-            test_virtual_lessor,
-            test_phys_lessee,
-            test_different_lessors,
-            test_queue_out_of_range,
-            test_resize_leased,
-            test_self_lease,
-            test_create_tx_type,
-            test_create_primary,
-            test_create_limit,
-            test_link_flap_phys,
-            test_queue_get_virtual,
-            test_remove_virt_first,
-            test_multiple_leases,
-            test_lease_queue_tx_type,
-            test_invalid_netns,
-            test_invalid_phys_ifindex,
-            test_multi_netkit_remove_phys,
-            test_single_remove_phys,
-            test_link_flap_virt,
-            test_phys_queue_no_lease,
-            test_same_ns_lease,
-            test_resize_after_unlease,
-            test_lease_queue_zero,
-            test_release_and_reuse,
-            test_veth_queue_create,
-        ],
-        args=(netns,),
-    )
-
-    cmd("ip netns del init", fail=False)
-    del netns
-
     with NetDrvContEnv(__file__, rxqueues=2) as cfg:
         cfg.bin_local = path.abspath(
             path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx"
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 231245a95879..a275ed584026 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -65,6 +65,7 @@ TEST_PROGS := \
 	netdevice.sh \
 	netns-name.sh \
 	netns-sysctl.sh \
+	nk_qlease.py \
 	nl_netdev.py \
 	nl_nlctrl.py \
 	pmtu.sh \
diff --git a/tools/testing/selftests/net/nk_qlease.py b/tools/testing/selftests/net/nk_qlease.py
new file mode 100755
index 000000000000..6ed4fb5e90f6
--- /dev/null
+++ b/tools/testing/selftests/net/nk_qlease.py
@@ -0,0 +1,1168 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import errno
+import time
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
+    cmd,
+    defer,
+    ip,
+)
+
+def create_netkit(rxqueues):
+    all_links = ip("-d link show", json=True)
+    old_idxs = {
+        link["ifindex"]
+        for link in all_links
+        if link.get("linkinfo", {}).get("info_kind") == "netkit"
+    }
+
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
+        and link["ifindex"] not in old_idxs
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
+def create_netkit_single(rxqueues):
+    rtnl = RtnlFamily()
+    rtnl.newlink(
+        {
+            "linkinfo": {
+                "kind": "netkit",
+                "data": {
+                    "mode": "l2",
+                    "pairing": "single",
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
+    return nk_links[0]["ifname"], nk_links[0]["ifindex"]
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
+    ksft_eq(queue_info["lease"]["ifindex"], nk_guest_idx)
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
+        ksft_eq(result["id"], 1)
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
+def test_veth_queue_create(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    ip("link add veth0 type veth peer name veth1")
+    defer(cmd, "ip link del dev veth0", fail=False)
+
+    all_links = ip("-d link show", json=True)
+    veth_peer = [
+        link
+        for link in all_links
+        if link.get("ifname") == "veth1"
+    ]
+    veth_peer_idx = veth_peer[0]["ifindex"]
+
+    ip(f"link set dev veth1 netns {netns.name}")
+    ip("link set dev veth0 up")
+    ip("link set dev veth1 up", ns=netns)
+
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        with ksft_raises(NlError) as e:
+            netdevnl.queue_create(
+                {
+                    "ifindex": veth_peer_idx,
+                    "type": "rx",
+                    "lease": {
+                        "ifindex": nsim.ifindex,
+                        "queue": {"id": 1, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_create_tx_type(netns) -> None:
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
+                    "type": "tx",
+                    "lease": {
+                        "ifindex": nsim.ifindex,
+                        "queue": {"id": 1, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_create_primary(_netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, nk_host_idx, _, _ = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_host} up")
+
+    netdevnl = NetdevFamily()
+    with ksft_raises(NlError) as e:
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_host_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": 1, "type": "rx"},
+                },
+            }
+        )
+    ksft_eq(e.exception.nl_msg.error, -errno.EOPNOTSUPP)
+
+
+def test_create_limit(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=1)
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
+                        "queue": {"id": 1, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_link_flap_phys(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}")
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
+    # Link flap the physical device
+    ip(f"link set dev {nsim.ifname} down")
+    ip(f"link set dev {nsim.ifname} up")
+
+    # Verify lease survives the flap
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
+
+
+def test_queue_get_virtual(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}")
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
+        # queue-get on virtual device's leased queue should not show lease
+        # info (lease info is only shown from the physical device's side)
+        queue_info = netdevnl.queue_get(
+            {"ifindex": nk_guest_idx, "id": nk_queue_id, "type": "rx"}
+        )
+        ksft_eq(queue_info["id"], nk_queue_id)
+        ksft_eq(queue_info["ifindex"], nk_guest_idx)
+        ksft_not_in("lease", queue_info)
+
+        # Default queue (not leased) also has no lease info
+        queue_info = netdevnl.queue_get(
+            {"ifindex": nk_guest_idx, "id": 0, "type": "rx"}
+        )
+        ksft_not_in("lease", queue_info)
+
+
+def test_remove_virt_first(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
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
+        ksft_eq(result["id"], 1)
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
+
+    # Delete netkit (virtual device removed first, physical stays)
+    cmd(f"ip link del dev {nk_host}")
+
+    # Verify lease is cleaned up on physical device
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_not_in("lease", queue_info)
+
+
+def test_multiple_leases(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=3)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=4)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        r1 = netdevnl.queue_create(
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
+        r2 = netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": 2, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+
+    ksft_eq(r1["id"], 1)
+    ksft_eq(r2["id"], 2)
+
+    # Verify both leases visible on physical device
+    netdevnl = NetdevFamily()
+    q1 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    q2 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
+    )
+    ksft_in("lease", q1)
+    ksft_in("lease", q2)
+    ksft_eq(q1["lease"]["ifindex"], nk_guest_idx)
+    ksft_eq(q2["lease"]["ifindex"], nk_guest_idx)
+    ksft_eq(q1["lease"]["queue"]["id"], r1["id"])
+    ksft_eq(q2["lease"]["queue"]["id"], r2["id"])
+
+
+def test_lease_queue_tx_type(netns) -> None:
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
+                        "queue": {"id": 1, "type": "tx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_invalid_netns(netns) -> None:
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
+                        "ifindex": 1,
+                        "queue": {"id": 0, "type": "rx"},
+                        "netns-id": 999,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.ENONET)
+
+
+def test_invalid_phys_ifindex(netns) -> None:
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
+                        "ifindex": 99999,
+                        "queue": {"id": 0, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.ENODEV)
+
+
+def test_multi_netkit_remove_phys(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=3)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    # Create two netkit pairs, each leasing a different physical queue
+    nk_host_a, _, nk_guest_a, nk_guest_a_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host_a}", fail=False)
+
+    nk_host_b, _, nk_guest_b, nk_guest_b_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host_b}", fail=False)
+
+    ip(f"link set dev {nk_guest_a} netns {netns.name}")
+    ip(f"link set dev {nk_host_a} up")
+    ip(f"link set dev {nk_guest_a} up", ns=netns)
+
+    ip(f"link set dev {nk_guest_b} netns {netns.name}")
+    ip(f"link set dev {nk_host_b} up")
+    ip(f"link set dev {nk_guest_b} up", ns=netns)
+
+    with NetNSEnter(str(netns)):
+        netdevnl = NetdevFamily()
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_a_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": 1, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_b_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": 2, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+
+    # Removing the physical device should take down both netkit pairs
+    nsimdev.remove()
+    time.sleep(0.1)
+    ret = cmd(f"ip link show dev {nk_host_a}", fail=False)
+    ksft_ne(ret.ret, 0)
+    ret = cmd(f"ip link show dev {nk_host_b}", fail=False)
+    ksft_ne(ret.ret, 0)
+
+
+def test_single_remove_phys(_netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_name, nk_idx = create_netkit_single(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_name}", fail=False)
+
+    ip(f"link set dev {nk_name} up")
+
+    netdevnl = NetdevFamily()
+    netdevnl.queue_create(
+        {
+            "ifindex": nk_idx,
+            "type": "rx",
+            "lease": {
+                "ifindex": nsim.ifindex,
+                "queue": {"id": 1, "type": "rx"},
+            },
+        }
+    )
+
+    # Removing the physical device should take down the single netkit device
+    nsimdev.remove()
+    time.sleep(0.1)
+    ret = cmd(f"ip link show dev {nk_name}", fail=False)
+    ksft_ne(ret.ret, 0)
+
+
+def test_link_flap_virt(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}")
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
+    # Link flap the virtual (netkit) device
+    ip(f"link set dev {nk_guest} down", ns=netns)
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    # Verify lease survives the virtual device flap
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
+
+
+def test_phys_queue_no_lease(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}")
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
+    # Physical queue 0 (not leased) should have no lease info
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 0, "type": "rx"}
+    )
+    ksft_not_in("lease", queue_info)
+
+    # Physical queue 1 (leased) should have lease info
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+
+
+def test_same_ns_lease(_netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_name, nk_idx = create_netkit_single(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_name}", fail=False)
+
+    ip(f"link set dev {nk_name} up")
+
+    netdevnl = NetdevFamily()
+    result = netdevnl.queue_create(
+        {
+            "ifindex": nk_idx,
+            "type": "rx",
+            "lease": {
+                "ifindex": nsim.ifindex,
+                "queue": {"id": 1, "type": "rx"},
+            },
+        }
+    )
+    ksft_eq(result["id"], 1)
+
+    # Same namespace: lease info should NOT have netns-id
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["ifindex"], nk_idx)
+    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
+    ksft_not_in("netns-id", queue_info["lease"])
+
+
+def test_resize_after_unlease(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
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
+    # Resize should fail while lease is active
+    ethnl = EthtoolFamily()
+    with ksft_raises(NlError) as e:
+        ethnl.channels_set({"header": {"dev-index": nsim.ifindex}, "combined-count": 1})
+    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+    # Delete netkit, clearing the lease
+    cmd(f"ip link del dev {nk_host}")
+
+    # Resize should now succeed
+    ethnl.channels_set({"header": {"dev-index": nsim.ifindex}, "combined-count": 1})
+
+
+def test_lease_queue_zero(netns) -> None:
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
+        result = netdevnl.queue_create(
+            {
+                "ifindex": nk_guest_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": 0, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+        ksft_eq(result["id"], 1)
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 0, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
+
+
+def test_release_and_reuse(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    src_queue = 1
+
+    # First lease
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
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
+                    "queue": {"id": src_queue, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+
+    # Delete netkit, freeing the lease
+    cmd(f"ip link del dev {nk_host}")
+
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_not_in("lease", queue_info)
+
+    # Re-create netkit and lease the same physical queue again
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
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
+        ksft_eq(result["id"], 1)
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
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
+            test_create_tx_type,
+            test_create_primary,
+            test_create_limit,
+            test_link_flap_phys,
+            test_queue_get_virtual,
+            test_remove_virt_first,
+            test_multiple_leases,
+            test_lease_queue_tx_type,
+            test_invalid_netns,
+            test_invalid_phys_ifindex,
+            test_multi_netkit_remove_phys,
+            test_single_remove_phys,
+            test_link_flap_virt,
+            test_phys_queue_no_lease,
+            test_same_ns_lease,
+            test_resize_after_unlease,
+            test_lease_queue_zero,
+            test_release_and_reuse,
+            test_veth_queue_create,
+        ],
+        args=(netns,),
+    )
+
+    cmd("ip netns del init", fail=False)
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


