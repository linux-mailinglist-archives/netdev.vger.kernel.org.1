Return-Path: <netdev+bounces-278053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJYeB0vW3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:40:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E003EB69D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17F10302307E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B63C0612;
	Mon, 13 Apr 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a9+n9qVJ"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40C3A9603
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080419; cv=none; b=aCvcYkYWuAFiklAMzDNNrO8mqPQj2+mqANwwRe4VYhStTsubzc3XhuGOV/J45MEg16NEKXyE3COrMktZscnDksPC0VZB1kK6n4EIl3Rvzawe6hmyfPWfcwqv36Au569WyF8wVOy/Uq8cVaD4vxPuef68A3qbOw80WBbkLG9uJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080419; c=relaxed/simple;
	bh=ZsDjSh96quXjXI6kWyHO4W/RZSxi3qMrdvsiOrEHvLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agCWjzfr+zR3RVI3Ox7RaFV/TkW5Qo0qMmXMs4Ui2A/RyjubRIj/hbFYGZOTFgIE+v0Qnd+Zh8IGrD/k/0yfWC7zjddudpgMqnMqQLfRRwo5Ecr+a8J2MFWz+Du73aMobaGdNSrjfqCcgCh3akf0YSyvJDsU5WMWrGtNU/qPCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a9+n9qVJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5ASwqNQt4SpYLzb+IDdbn5vN5IB18BBcCHE4DvbtrpE=; b=a9+n9qVJ1+j/A3moraJDjfDWKa
	UISjeKYDG/O0OCsf2JyTp/SvpFRKIJM2111YsO23aMcJY8mBIchgCZdMKroVipRDn2xdxe4dAll8F
	/kzk84XsEuS76KntbW7PmZ8N/q9EUelH/QxG11ECyH6JF0XJi8/YCthX9NIaJtE6ZoXYbePo8eN3J
	fqoehBOA3k8H+iV5k4LcfUjgYwhchwaJVjNcoZAaaQjZ1oxRNOI6pTXuw4iD7hhdjbtta1+is8i3u
	HLYFyJ2T+029QwztYog4wQFV84nH5Nne5HZnkBR1uhNT6FdErO8rzfRqwXrusmpmj4T9NBmG22hnT
	Uj2D1+SQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCFeI-000IMC-26;
	Mon, 13 Apr 2026 13:40:14 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	dw@davidwei.uk,
	razor@blackwall.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests/net: Add additional test coverage in nk_qlease
Date: Mon, 13 Apr 2026 13:40:10 +0200
Message-ID: <20260413114011.588162-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413114011.588162-1-daniel@iogearbox.net>
References: <20260413114011.588162-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27970/Mon Apr 13 08:24:33 2026)
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278053-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,ns_b.name:url,netns.name:url,test_ns.name:url]
X-Rspamd-Queue-Id: 70E003EB69D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add further netkit queue-lease coverage for netns lifecycle of the guest
and physical halves, channel resize across active leases, single-device
and multi-lessee scenarios, L3 mode operation, lease capacity exhaustion,
and corner-cases of e.g. queue-create rejection paths.

Full test run:

  # ./nk_qlease.py
  TAP version 13
  1..45
  ok 1 nk_qlease.test_remove_phys
  ok 2 nk_qlease.test_double_lease
  ok 3 nk_qlease.test_virtual_lessor
  ok 4 nk_qlease.test_phys_lessee
  ok 5 nk_qlease.test_different_lessors
  ok 6 nk_qlease.test_queue_out_of_range
  ok 7 nk_qlease.test_resize_leased
  ok 8 nk_qlease.test_self_lease
  ok 9 nk_qlease.test_create_tx_type
  ok 10 nk_qlease.test_create_primary
  ok 11 nk_qlease.test_create_limit
  ok 12 nk_qlease.test_link_flap_phys
  ok 13 nk_qlease.test_queue_get_virtual
  ok 14 nk_qlease.test_remove_virt_first
  ok 15 nk_qlease.test_multiple_leases
  ok 16 nk_qlease.test_lease_queue_tx_type
  ok 17 nk_qlease.test_invalid_netns
  ok 18 nk_qlease.test_invalid_phys_ifindex
  ok 19 nk_qlease.test_multi_netkit_remove_phys
  ok 20 nk_qlease.test_single_remove_phys
  ok 21 nk_qlease.test_link_flap_virt
  ok 22 nk_qlease.test_phys_queue_no_lease
  ok 23 nk_qlease.test_same_ns_lease
  ok 24 nk_qlease.test_resize_after_unlease
  ok 25 nk_qlease.test_lease_queue_zero
  ok 26 nk_qlease.test_release_and_reuse
  ok 27 nk_qlease.test_veth_queue_create
  ok 28 nk_qlease.test_two_netkits_same_queue
  ok 29 nk_qlease.test_l3_mode_lease
  ok 30 nk_qlease.test_single_double_lease
  ok 31 nk_qlease.test_single_different_lessors
  ok 32 nk_qlease.test_cross_ns_netns_id
  ok 33 nk_qlease.test_delete_guest_netns
  ok 34 nk_qlease.test_move_guest_netns
  ok 35 nk_qlease.test_resize_phys_no_reduction
  ok 36 nk_qlease.test_delete_one_netkit_of_two
  ok 37 nk_qlease.test_bind_rx_leased_phys_queue
  ok 38 nk_qlease.test_resize_phys_shrink_past_leased
  ok 39 nk_qlease.test_resize_virt_not_supported
  ok 40 nk_qlease.test_lease_devices_down
  ok 41 nk_qlease.test_lease_capacity_exhaustion
  ok 42 nk_qlease.test_resize_phys_up
  ok 43 nk_qlease.test_multi_ns_lease
  ok 44 nk_qlease.test_multi_ns_delete_one
  ok 45 nk_qlease.test_move_phys_netns
  # Totals: pass:45 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/net/nk_qlease.py | 933 ++++++++++++++++++++++-
 1 file changed, 931 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/nk_qlease.py b/tools/testing/selftests/net/nk_qlease.py
index 6ed4fb5e90f6..df35c82bccfc 100755
--- a/tools/testing/selftests/net/nk_qlease.py
+++ b/tools/testing/selftests/net/nk_qlease.py
@@ -28,7 +28,8 @@ from lib.py import (
     ip,
 )
 
-def create_netkit(rxqueues):
+
+def create_netkit(rxqueues, mode="l2"):
     all_links = ip("-d link show", json=True)
     old_idxs = {
         link["ifindex"]
@@ -42,7 +43,7 @@ def create_netkit(rxqueues):
             "linkinfo": {
                 "kind": "netkit",
                 "data": {
-                    "mode": "l2",
+                    "mode": mode,
                     "policy": "forward",
                     "peer-policy": "forward",
                 },
@@ -93,6 +94,7 @@ def create_netkit_single(rxqueues):
     ]
     return nk_links[0]["ifname"], nk_links[0]["ifindex"]
 
+
 def test_remove_phys(netns) -> None:
     nsimdev = NetdevSimDev(port_count=1, queue_count=2)
     defer(nsimdev.remove)
@@ -1121,6 +1123,915 @@ def test_release_and_reuse(netns) -> None:
     ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
 
 
+def test_two_netkits_same_queue(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
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
+    src_queue = 1
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
+            {
+                "ifindex": nk_guest_a_idx,
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
+            netdevnl_ns.queue_create(
+                {
+                    "ifindex": nk_guest_b_idx,
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
+def test_l3_mode_lease(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2, mode="l3")
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    src_queue = 1
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        result = netdevnl_ns.queue_create(
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
+    ksft_eq(queue_info["lease"]["ifindex"], nk_guest_idx)
+    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
+
+
+def test_single_double_lease(_netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_name, nk_idx = create_netkit_single(rxqueues=3)
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
+    with ksft_raises(NlError) as e:
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim.ifindex,
+                    "queue": {"id": 1, "type": "rx"},
+                },
+            }
+        )
+    ksft_eq(e.exception.nl_msg.error, -errno.EBUSY)
+
+
+def test_single_different_lessors(_netns) -> None:
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
+    nk_name, nk_idx = create_netkit_single(rxqueues=3)
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
+                "ifindex": nsim_a.ifindex,
+                "queue": {"id": 1, "type": "rx"},
+            },
+        }
+    )
+
+    with ksft_raises(NlError) as e:
+        netdevnl.queue_create(
+            {
+                "ifindex": nk_idx,
+                "type": "rx",
+                "lease": {
+                    "ifindex": nsim_b.ifindex,
+                    "queue": {"id": 1, "type": "rx"},
+                },
+            }
+        )
+    ksft_eq(e.exception.nl_msg.error, -errno.EOPNOTSUPP)
+
+
+def test_cross_ns_netns_id(netns) -> None:
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
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+    ksft_in("netns-id", queue_info["lease"])
+
+
+def test_delete_guest_netns(_netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    test_ns = NetNS()
+    ip("netns set init 0", ns=test_ns)
+    ip("link set lo up", ns=test_ns)
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+
+    ip(f"link set dev {nk_guest} netns {test_ns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=test_ns)
+
+    src_queue = 1
+    with NetNSEnter(str(test_ns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+    del test_ns
+    time.sleep(0.1)
+
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_not_in("lease", queue_info)
+
+    ret = cmd(f"ip link show dev {nk_host}", fail=False)
+    ksft_ne(ret.ret, 0)
+
+
+def test_move_guest_netns(netns) -> None:
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
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        result = netdevnl_ns.queue_create(
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
+    new_ns = NetNS()
+    defer(new_ns.__del__)
+    ip(f"link set dev {nk_guest} netns {new_ns.name}", ns=netns)
+
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
+
+
+def test_resize_phys_no_reduction(netns) -> None:
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
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+    ethnl.channels_set(
+        {"header": {"dev-index": nsim.ifindex}, "combined-count": 2}
+    )
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+
+
+def test_delete_one_netkit_of_two(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=3)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
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
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+        netdevnl_ns.queue_create(
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
+    netdevnl = NetdevFamily()
+    q1 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    q2 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
+    )
+    ksft_in("lease", q1)
+    ksft_in("lease", q2)
+
+    cmd(f"ip link del dev {nk_host_a}")
+
+    q1 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    q2 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
+    )
+    ksft_not_in("lease", q1)
+    ksft_in("lease", q2)
+
+
+def test_bind_rx_leased_phys_queue(netns) -> None:
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
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+    netdevnl = NetdevFamily()
+    with ksft_raises(NlError) as e:
+        netdevnl.bind_rx(
+            {
+                "ifindex": nsim.ifindex,
+                "fd": 0,
+                "queues": [
+                    {"id": 0, "type": "rx"},
+                    {"id": 1, "type": "rx"},
+                ],
+            }
+        )
+    ksft_eq(e.exception.nl_msg.error, -errno.EOPNOTSUPP)
+
+
+def test_resize_phys_shrink_past_leased(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=4)
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
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+
+    # Shrink past the leased queue — only queue 3 removed, queue 1 untouched
+    ethnl.channels_set(
+        {"header": {"dev-index": nsim.ifindex}, "combined-count": 3}
+    )
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+
+    # Shrink further — queue 2 removed, queue 1 still untouched
+    ethnl.channels_set(
+        {"header": {"dev-index": nsim.ifindex}, "combined-count": 2}
+    )
+
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+
+    # Shrink into the leased queue — queue 1 is busy, must fail
+    with ksft_raises(NlError) as e:
+        ethnl.channels_set(
+            {"header": {"dev-index": nsim.ifindex}, "combined-count": 1}
+        )
+    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
+def test_resize_virt_not_supported(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    nk_host, nk_host_idx, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+    # Channel resize on the netkit host must fail — not supported
+    ethnl = EthtoolFamily()
+    with ksft_raises(NlError) as e:
+        ethnl.channels_set(
+            {"header": {"dev-index": nk_host_idx}, "combined-count": 1}
+        )
+    ksft_eq(e.exception.nl_msg.error, -errno.EOPNOTSUPP)
+
+    # Lease must be intact
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+
+
+def test_lease_devices_down(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+
+    # Create lease while both physical and virtual devices are down
+    src_queue = 1
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        result = netdevnl_ns.queue_create(
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
+    # Bring devices up before queue_get: netdevsim only instantiates NAPIs in
+    # ndo_open, and netdev-genl queue_get returns -ENOENT without a NAPI.
+    ip(f"link set dev {nsim.ifname} up")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": src_queue, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+    ksft_eq(queue_info["lease"]["queue"]["id"], result["id"])
+
+
+def test_lease_capacity_exhaustion(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=4)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    # rxqueues=3 means num_rx_queues=3, real_num_rx_queues starts at 1.
+    # Can create 2 leased queues (real goes 1->2->3) but not a 3rd (3->4 > 3).
+    nk_host, _, nk_guest, nk_guest_idx = create_netkit(rxqueues=3)
+    defer(cmd, f"ip link del dev {nk_host}", fail=False)
+
+    ip(f"link set dev {nk_guest} netns {netns.name}")
+    ip(f"link set dev {nk_host} up")
+    ip(f"link set dev {nk_guest} up", ns=netns)
+
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        r1 = netdevnl_ns.queue_create(
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
+        ksft_eq(r1["id"], 1)
+
+        r2 = netdevnl_ns.queue_create(
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
+        ksft_eq(r2["id"], 2)
+
+        # Third lease fails — netkit queue capacity exhausted
+        with ksft_raises(NlError) as e:
+            netdevnl_ns.queue_create(
+                {
+                    "ifindex": nk_guest_idx,
+                    "type": "rx",
+                    "lease": {
+                        "ifindex": nsim.ifindex,
+                        "queue": {"id": 3, "type": "rx"},
+                        "netns-id": 0,
+                    },
+                }
+            )
+        ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+    # Verify the two successful leases are intact
+    netdevnl = NetdevFamily()
+    q1 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    q2 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
+    )
+    ksft_in("lease", q1)
+    ksft_in("lease", q2)
+
+
+def test_resize_phys_up(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=3)
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
+    # Shrink nsim first so we have room to grow
+    ethnl = EthtoolFamily()
+    ethnl.channels_set(
+        {"header": {"dev-index": nsim.ifindex}, "combined-count": 2}
+    )
+
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+    # Grow channels — should succeed since leased queue is not removed
+    ethnl.channels_set(
+        {"header": {"dev-index": nsim.ifindex}, "combined-count": 3}
+    )
+
+    netdevnl = NetdevFamily()
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    ksft_in("lease", queue_info)
+
+    # New queue 2 should exist without a lease
+    queue_info = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
+    )
+    ksft_not_in("lease", queue_info)
+
+
+def test_multi_ns_lease(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=3)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    ns_b = NetNS()
+    defer(ns_b.__del__)
+    ip("netns set init 0", ns=ns_b)
+    ip("link set lo up", ns=ns_b)
+
+    # First netkit pair, guest in netns
+    nk_host_a, _, nk_guest_a, nk_guest_a_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host_a}", fail=False)
+    ip(f"link set dev {nk_guest_a} netns {netns.name}")
+    ip(f"link set dev {nk_host_a} up")
+    ip(f"link set dev {nk_guest_a} up", ns=netns)
+
+    # Second netkit pair, guest in ns_b
+    nk_host_b, _, nk_guest_b, nk_guest_b_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host_b}", fail=False)
+    ip(f"link set dev {nk_guest_b} netns {ns_b.name}")
+    ip(f"link set dev {nk_host_b} up")
+    ip(f"link set dev {nk_guest_b} up", ns=ns_b)
+
+    # Lease from netns
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        r_a = netdevnl_ns.queue_create(
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
+        ksft_eq(r_a["id"], 1)
+
+    # Lease from ns_b (different namespace, same physical device)
+    with NetNSEnter(str(ns_b)), NetdevFamily() as netdevnl_ns:
+        r_b = netdevnl_ns.queue_create(
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
+        ksft_eq(r_b["id"], 1)
+
+    # Verify both leases from the physical side
+    netdevnl = NetdevFamily()
+    q1 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    q2 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
+    )
+    ksft_in("lease", q1)
+    ksft_in("lease", q2)
+    ksft_eq(q1["lease"]["ifindex"], nk_guest_a_idx)
+    ksft_eq(q2["lease"]["ifindex"], nk_guest_b_idx)
+
+
+def test_multi_ns_delete_one(netns) -> None:
+    nsimdev = NetdevSimDev(port_count=1, queue_count=3)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    ip(f"link set dev {nsim.ifname} up")
+
+    ns_b = NetNS()
+    ip("netns set init 0", ns=ns_b)
+    ip("link set lo up", ns=ns_b)
+
+    # First netkit pair, guest in netns (ns_a)
+    nk_host_a, _, nk_guest_a, nk_guest_a_idx = create_netkit(rxqueues=2)
+    defer(cmd, f"ip link del dev {nk_host_a}", fail=False)
+    ip(f"link set dev {nk_guest_a} netns {netns.name}")
+    ip(f"link set dev {nk_host_a} up")
+    ip(f"link set dev {nk_guest_a} up", ns=netns)
+
+    # Second netkit pair, guest in ns_b
+    nk_host_b, _, nk_guest_b, nk_guest_b_idx = create_netkit(rxqueues=2)
+
+    ip(f"link set dev {nk_guest_b} netns {ns_b.name}")
+    ip(f"link set dev {nk_host_b} up")
+    ip(f"link set dev {nk_guest_b} up", ns=ns_b)
+
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+
+    with NetNSEnter(str(ns_b)), NetdevFamily() as netdevnl_ns:
+        netdevnl_ns.queue_create(
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
+    netdevnl = NetdevFamily()
+    q1 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    q2 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
+    )
+    ksft_in("lease", q1)
+    ksft_in("lease", q2)
+
+    # Delete ns_b — destroys nk_guest_b, triggers unlease of queue 2
+    del ns_b
+    time.sleep(0.1)
+
+    # ns_a's lease on queue 1 must survive
+    q1 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 1, "type": "rx"}
+    )
+    ksft_in("lease", q1)
+    ksft_eq(q1["lease"]["ifindex"], nk_guest_a_idx)
+
+    # ns_b's lease on queue 2 must be gone
+    q2 = netdevnl.queue_get(
+        {"ifindex": nsim.ifindex, "id": 2, "type": "rx"}
+    )
+    ksft_not_in("lease", q2)
+
+    # nk_host_b should be gone too (phys removal cascades to netkit pair)
+    ret = cmd(f"ip link show dev {nk_host_b}", fail=False)
+    ksft_ne(ret.ret, 0)
+
+
+def test_move_phys_netns(netns) -> None:
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
+    with NetNSEnter(str(netns)), NetdevFamily() as netdevnl_ns:
+        result = netdevnl_ns.queue_create(
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
+
+    # Move the physical device to a new namespace. Move it back to init_net
+    # on cleanup before the other defers fire (new_ns deletion, nsimdev.remove)
+    # so nsim lives in a stable namespace when they run.
+    new_ns = NetNS()
+    defer(new_ns.__del__)
+    ip(f"link set dev {nsim.ifname} netns {new_ns.name}")
+    defer(ip, f"link set dev {nsim.ifname} netns init", ns=new_ns)
+
+    # Physical device is now in new_ns — find its ifindex there
+    all_links = ip("-d link show", json=True, ns=new_ns)
+    nsim_in_new = [l for l in all_links if l.get("ifname") == nsim.ifname]
+    new_ifindex = nsim_in_new[0]["ifindex"]
+
+    # Moving a device across netns brings it admin-down; bring it back up so
+    # netdevsim re-creates the NAPI (netdev-genl queue_get needs it).
+    ip(f"link set dev {nsim.ifname} up", ns=new_ns)
+
+    # Verify lease survived the namespace move
+    with NetNSEnter(str(new_ns)), NetdevFamily() as netdevnl_ns:
+        queue_info = netdevnl_ns.queue_get(
+            {"ifindex": new_ifindex, "id": src_queue, "type": "rx"}
+        )
+        ksft_in("lease", queue_info)
+        ksft_eq(queue_info["lease"]["queue"]["id"], nk_queue_id)
+
+
 def main() -> None:
     netns = NetNS()
     cmd("ip netns attach init 1")
@@ -1156,6 +2067,24 @@ def main() -> None:
             test_lease_queue_zero,
             test_release_and_reuse,
             test_veth_queue_create,
+            test_two_netkits_same_queue,
+            test_l3_mode_lease,
+            test_single_double_lease,
+            test_single_different_lessors,
+            test_cross_ns_netns_id,
+            test_delete_guest_netns,
+            test_move_guest_netns,
+            test_resize_phys_no_reduction,
+            test_delete_one_netkit_of_two,
+            test_bind_rx_leased_phys_queue,
+            test_resize_phys_shrink_past_leased,
+            test_resize_virt_not_supported,
+            test_lease_devices_down,
+            test_lease_capacity_exhaustion,
+            test_resize_phys_up,
+            test_multi_ns_lease,
+            test_multi_ns_delete_one,
+            test_move_phys_netns,
         ],
         args=(netns,),
     )
-- 
2.43.0


