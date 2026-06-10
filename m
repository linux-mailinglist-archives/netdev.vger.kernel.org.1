Return-Path: <netdev+bounces-297518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cYpYHasbKWokQwMAu9opvQ
	(envelope-from <netdev+bounces-297518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:09:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A75666F4C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:09:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=Fd8w+om+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297518-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297518-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 035B431C4458
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977BA3A2E2B;
	Wed, 10 Jun 2026 08:03:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE9394793
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:03:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078632; cv=none; b=GlIw86m5joyIfk+WPf7FZBSz/IHN6c1UPI1ZhcyQThANpz2lRm9ufaVjOi0BEkZjFM9gA7tY5vko7CdrFc5Ddc+fTW/YQAgY/OkYeUClmVNAG0XuBLHwgc55UepoPh3PCmC1TWPn555rKmSOpnp7fcfeG8liL657yD1bRiyRByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078632; c=relaxed/simple;
	bh=b5B1Z9dKGWYwR04zkfBHRqmnA2pPux/JgYwQUn83lOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHMmprTG1kLVKvyzuc4+uRoNBms3lKbAodl86z0UyrRXo8vIk9xAArOQvd3BXguQGUx0giX3dEXcvcPFA8Zh7prHQuSK+Nk3p7C4e7Qg/19t5oqHJTzRKA2tcP/GIIydOeSAW9L0Uci1qcf8R7kCikYk9/fVHZnwIcguMqyHz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Fd8w+om+; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=I8LssJhvxwrAC6Pis+dAsvshegp/hr26k5MD8A+ETsA=; b=Fd8w+om+FUgJ414Vv/BxXiNG0R
	uDLA1sOEwj44joEMozZ/fACvrdzXuiEXKJgd9HffTGjOlzFUEEl5lA1MTDIKmMM68Orw1RzdTW+w+
	bcwtBE6PK/lYQBOZ0RuifFdn9AcEA5sx2gBpZuJChNtKu8ewgQkmvILLJaSRCn/fzp3foAtohDoMU
	H7jdkZ0i1/RSwQPauFXXH1sTRAIBeePRmYZNcTubxT1X2t8+mmuRl69GBd0ROyaYzq//UYgZM6DT1
	bzLv98T2RTxxmein8ru1O9dK43iqMnA4OE/q+phT2bNQnYos1UZb2uQu9QNiMZ9IbHeXFRn9ILDMw
	6iohskrA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXDuc-0009Vt-1E;
	Wed, 10 Jun 2026 10:03:46 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/4] selftests/net: Move netkit lease hw setup into per-test fixtures
Date: Wed, 10 Jun 2026 10:03:41 +0200
Message-ID: <20260610080344.701380-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610080344.701380-1-daniel@iogearbox.net>
References: <20260610080344.701380-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28027/Wed Jun 10 08:29:13 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297518-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lib.py:url,netns.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2A75666F4C

The HW counterpart of nk_qlease.py was carrying its lease setup in main()
and stashing src_queue / nk_queue / nk_*_ifname on cfg, which had drawbacks
called out during the review at [0].

This is the deferred half of the cleanup that landed in commit e254ffb9502c
("selftests/net: Split netdevsim tests from HW tests in nk_qlease") which
was the SW counterpart of nk_qlease.py.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/netdev/20260408162238.16709090@kernel.org/ [0]
---
 .../selftests/drivers/net/hw/nk_qlease.py     | 192 +++++++++++++-----
 1 file changed, 146 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index 139a91ebd229..81125856727f 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -18,8 +18,10 @@ from lib.py import (
     NetNSEnter,
     EthtoolFamily,
     NetdevFamily,
+    RtnlFamily,
 )
 from lib.py import (
+    Netlink,
     bkg,
     cmd,
     defer,
@@ -31,9 +33,117 @@ from lib.py import (
 from lib.py import KsftSkipEx, CmdExitFailure
 
 
-def set_flow_rule(cfg):
+def _create_netkit_pair(cfg, rxqueues=2):
+    if cfg._nk_host_ifname:
+        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
+        cfg._nk_host_ifname = None
+        cfg.nk_guest_ifname = None
+    if getattr(cfg, "_tc_attached", False):
+        cmd(
+            f"tc filter del dev {cfg.ifname} ingress pref {cfg._bpf_prog_pref}",
+            fail=False,
+        )
+        cfg._tc_attached = False
+
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
+    if len(nk_links) != 2:
+        raise KsftSkipEx("Failed to create netkit pair")
+
+    nk_links.sort(key=lambda x: x["ifindex"])
+    cfg._nk_host_ifname = nk_links[1]["ifname"]
+    cfg.nk_guest_ifname = nk_links[0]["ifname"]
+    cfg.nk_host_ifindex = nk_links[1]["ifindex"]
+    cfg.nk_guest_ifindex = nk_links[0]["ifindex"]
+
+    ip(f"link set dev {cfg.nk_guest_ifname} netns {cfg.netns.name}")
+    ip(f"link set dev {cfg._nk_host_ifname} up")
+    ip(f"-6 addr add fe80::1/64 dev {cfg._nk_host_ifname} nodad")
+    ip(
+        f"-6 route add {cfg.nk_guest_ipv6}/128 via fe80::2 "
+        f"dev {cfg._nk_host_ifname}"
+    )
+    ip(f"link set dev {cfg.nk_guest_ifname} up", ns=cfg.netns)
+    ip(f"-6 addr add fe80::2/64 dev {cfg.nk_guest_ifname}", ns=cfg.netns)
+    ip(
+        f"-6 addr add {cfg.nk_guest_ipv6}/64 dev {cfg.nk_guest_ifname} nodad",
+        ns=cfg.netns,
+    )
+    ip(
+        f"-6 route add default via fe80::1 dev {cfg.nk_guest_ifname}",
+        ns=cfg.netns,
+    )
+
+    cfg._attach_bpf()
+
+
+def _setup_lease(cfg, rxqueues=2):
+    _create_netkit_pair(cfg, rxqueues=rxqueues)
+
+    ethnl = EthtoolFamily()
+    channels = ethnl.channels_get({"header": {"dev-index": cfg.ifindex}})[
+        "combined-count"
+    ]
+    if channels < 2:
+        raise KsftSkipEx(
+            "Test requires NETIF with at least 2 combined channels"
+        )
+    src_queue = channels - 1
+
+    with NetNSEnter(str(cfg.netns)):
+        netdevnl = NetdevFamily()
+        bind_result = netdevnl.queue_create(
+            {
+                "ifindex": cfg.nk_guest_ifindex,
+                "type": "rx",
+                "lease": {
+                    "ifindex": cfg.ifindex,
+                    "queue": {"id": src_queue, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+    return src_queue, bind_result["id"]
+
+
+def _teardown_netkit(cfg):
+    if cfg._nk_host_ifname:
+        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
+        cfg._nk_host_ifname = None
+        cfg.nk_guest_ifname = None
+
+
+def set_flow_rule(cfg, src_queue):
     output = ethtool(
-        f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.src_queue}"
+        f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {src_queue}"
     ).stdout
     values = re.search(r"ID (\d+)", output).group(1)
     return int(values)
@@ -41,6 +151,8 @@ def set_flow_rule(cfg):
 
 def test_iou_zcrx(cfg) -> None:
     cfg.require_ipver("6")
+    src_queue, nk_queue = _setup_lease(cfg)
+    defer(_teardown_netkit, cfg)
     ethnl = EthtoolFamily()
 
     rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
@@ -65,13 +177,16 @@ def test_iou_zcrx(cfg) -> None:
         },
     )
 
-    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    ethtool(f"-X {cfg.ifname} equal {src_queue}")
     defer(ethtool, f"-X {cfg.ifname} default")
 
-    flow_rule_id = set_flow_rule(cfg)
+    flow_rule_id = set_flow_rule(cfg, src_queue)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = (
+        f"ip netns exec {cfg.netns.name} {cfg.bin_local} "
+        f"-s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {nk_queue}"
+    )
     tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
@@ -80,25 +195,29 @@ def test_iou_zcrx(cfg) -> None:
 
 def test_attrs(cfg) -> None:
     cfg.require_ipver("6")
+    src_queue, nk_queue = _setup_lease(cfg)
+    defer(_teardown_netkit, cfg)
     netdevnl = NetdevFamily()
     queue_info = netdevnl.queue_get(
-        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
     )
 
-    ksft_eq(queue_info["id"], cfg.src_queue)
+    ksft_eq(queue_info["id"], src_queue)
     ksft_eq(queue_info["type"], "rx")
     ksft_eq(queue_info["ifindex"], cfg.ifindex)
 
     ksft_in("lease", queue_info)
     lease = queue_info["lease"]
     ksft_eq(lease["ifindex"], cfg.nk_guest_ifindex)
-    ksft_eq(lease["queue"]["id"], cfg.nk_queue)
+    ksft_eq(lease["queue"]["id"], nk_queue)
     ksft_eq(lease["queue"]["type"], "rx")
     ksft_in("netns-id", lease)
 
 
 def test_attach_xdp_with_mp(cfg) -> None:
     cfg.require_ipver("6")
+    src_queue, nk_queue = _setup_lease(cfg)
+    defer(_teardown_netkit, cfg)
     ethnl = EthtoolFamily()
 
     rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
@@ -123,18 +242,21 @@ def test_attach_xdp_with_mp(cfg) -> None:
         },
     )
 
-    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    ethtool(f"-X {cfg.ifname} equal {src_queue}")
     defer(ethtool, f"-X {cfg.ifname} default")
 
     netdevnl = NetdevFamily()
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = (
+        f"ip netns exec {cfg.netns.name} {cfg.bin_local} "
+        f"-s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {nk_queue}"
+    )
     with bkg(rx_cmd):
         wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
 
         time.sleep(0.1)
         queue_info = netdevnl.queue_get(
-            {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+            {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
         )
         ksft_in("io-uring", queue_info)
 
@@ -144,13 +266,15 @@ def test_attach_xdp_with_mp(cfg) -> None:
 
     time.sleep(0.1)
     queue_info = netdevnl.queue_get(
-        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
     )
     ksft_not_in("io-uring", queue_info)
 
 
 def test_destroy(cfg) -> None:
     cfg.require_ipver("6")
+    src_queue, nk_queue = _setup_lease(cfg)
+    defer(_teardown_netkit, cfg)
     ethnl = EthtoolFamily()
 
     rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
@@ -175,16 +299,19 @@ def test_destroy(cfg) -> None:
         },
     )
 
-    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    ethtool(f"-X {cfg.ifname} equal {src_queue}")
     defer(ethtool, f"-X {cfg.ifname} default")
 
-    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {cfg.nk_queue}"
+    rx_cmd = (
+        f"ip netns exec {cfg.netns.name} {cfg.bin_local} "
+        f"-s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {nk_queue}"
+    )
     rx_proc = cmd(rx_cmd, background=True)
     wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
 
     netdevnl = NetdevFamily()
     queue_info = netdevnl.queue_get(
-        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
     )
     ksft_in("io-uring", queue_info)
 
@@ -199,17 +326,14 @@ def test_destroy(cfg) -> None:
     cfg.nk_guest_ifname = None
 
     queue_info = netdevnl.queue_get(
-        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
     )
     ksft_not_in("io-uring", queue_info)
 
-    cmd(f"tc filter del dev {cfg.ifname} ingress pref {cfg._bpf_prog_pref}")
-    cfg._tc_attached = False
-
-    flow_rule_id = set_flow_rule(cfg)
+    flow_rule_id = set_flow_rule(cfg, src_queue)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.src_queue}"
+    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {src_queue}"
     tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(cfg.port, proto="tcp")
@@ -217,7 +341,7 @@ def test_destroy(cfg) -> None:
     # Short delay since iou cleanup is async and takes a bit of time.
     time.sleep(0.1)
     queue_info = netdevnl.queue_get(
-        {"ifindex": cfg.ifindex, "id": cfg.src_queue, "type": "rx"}
+        {"ifindex": cfg.ifindex, "id": src_queue, "type": "rx"}
     )
     ksft_not_in("io-uring", queue_info)
 
@@ -230,30 +354,6 @@ def main() -> None:
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
         cfg.port = rand_port()
 
-        ethnl = EthtoolFamily()
-        channels = ethnl.channels_get({"header": {"dev-index": cfg.ifindex}})
-        channels = channels["combined-count"]
-        if channels < 2:
-            raise KsftSkipEx("Test requires NETIF with at least 2 combined channels")
-
-        cfg.src_queue = channels - 1
-
-        with NetNSEnter(str(cfg.netns)):
-            netdevnl = NetdevFamily()
-            bind_result = netdevnl.queue_create(
-                {
-                    "ifindex": cfg.nk_guest_ifindex,
-                    "type": "rx",
-                    "lease": {
-                        "ifindex": cfg.ifindex,
-                        "queue": {"id": cfg.src_queue, "type": "rx"},
-                        "netns-id": 0,
-                    },
-                }
-            )
-            cfg.nk_queue = bind_result["id"]
-
-        # test_destroy must be last because it destroys the netkit devices
         ksft_run(
             [test_iou_zcrx, test_attrs, test_attach_xdp_with_mp, test_destroy],
             args=(cfg,),
-- 
2.43.0


