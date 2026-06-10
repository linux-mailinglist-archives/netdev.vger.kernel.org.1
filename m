Return-Path: <netdev+bounces-297516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1JAlH2cbKWoLQwMAu9opvQ
	(envelope-from <netdev+bounces-297516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:08:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD82E666F08
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:08:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=cSJEqh2m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297516-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297516-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E451305993D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A139F18A;
	Wed, 10 Jun 2026 08:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815B39EF30
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:03:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078631; cv=none; b=f5lxEwnSjWVNnpUys/pFFkdOPQhcZ7QgrhszSE7Ul/r9fljZ9FabLyQGoi2HQJGjkvG0Qcaym/uWdRJEKPuy8qDLQ084LXV3hkFHe3V+SZREPsqOgzxqnmiiy511iieHqDcPLDHecnqSMFUtrF89LhileepEzXVgtXRQ2BcRz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078631; c=relaxed/simple;
	bh=kRWmdIBQSuXvaFTmUSakgDOzMT4UylfO41FsTxAAMi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKDQWA6ztf4MwbgGiCUQbwF1BN7A5LwHsosBCbUPZU6xC+GOR+LfTywhucBVYX0ksF/rXAU3ZTHiurm9XvL3QuaBaLZk6eo3KiBw+Qcus0W2dHNEdlcTKn69FKdLQGXtBY5Wfp5nAHGFfl4/8r9w3YCKzSF6B8XUY4WL5gn2V54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=cSJEqh2m; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iXPgm5v6nMKn4bY8evvEB6PTPyTcZtzLXcndWcGS9i0=; b=cSJEqh2mU3EiOIq5O4G30xqdFL
	8qCJ2adlx5X/5I6vtQb0ONypmuwwQbf+4aWy8sIC/txaEuflZgFUSTyAOR9bxJUReD5rm2s66wV6c
	buWmiDaLGY0xU1OC4yQrhGlqiSBf5p51FcM535CiTmZy/RcrHFxtUw7wOK5bvr7hOyL2pNJFc3Y8d
	qu2QarFoBO8bLw54LplbXFyKLeqGkBwppD5Q6piMQRzKvuY2/fLB4RpGWRmrRQkufg/ipU6PUxlZi
	2qMcU3OV4pfNQA7rDOl+mrHmzQUot9llE+DPetzw1Mhwp40Xu+aFDKvPfxvi6O4rGggUP3ZQZiJZT
	wz1B+bTw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXDud-0009Ws-1n;
	Wed, 10 Jun 2026 10:03:47 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/4] selftests/net: Add netkit io_uring ZC test for large rx_buf_len
Date: Wed, 10 Jun 2026 10:03:43 +0200
Message-ID: <20260610080344.701380-4-daniel@iogearbox.net>
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
	TAGGED_FROM(0.00)[bounces-297516-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD82E666F08

Add test_iou_zcrx_large_buf, which runs iou-zcrx with rx_buf_len >
page size (-x 2) through a netkit-leased RX queue. The netkit ifindex
is opaque to io_uring, but rx_page_size is honoured by the leased
physical qops via netif_mp_open_rxq()'s lease redirect.

Originally, I also added a BIG TCP variant on top, but dropped it
here as fbnic (and the QEMU fbnic model) has no BIG TCP support
to exercise it as this point.

Tested against the QEMU fbnic emulation. The new test exercises
the > page rx_buf_len path only when the leased NIC advertises
QCFG_RX_PAGE_SIZE; otherwise it skips.

For fbnic, I used Bjorn's patches locally [0]:

  # ./nk_qlease.py
  TAP version 13
  1..5
  ok 1 nk_qlease.test_iou_zcrx
  ok 2 nk_qlease.test_iou_zcrx_large_buf
  ok 3 nk_qlease.test_attrs
  ok 4 nk_qlease.test_attach_xdp_with_mp
  ok 5 nk_qlease.test_destroy
  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

Without those patches (aka not advertising QCFG_RX_PAGE_SIZE):

  # ./nk_qlease.py
  TAP version 13
  1..5
  ok 1 nk_qlease.test_iou_zcrx
  ok 2 nk_qlease.test_iou_zcrx_large_buf # SKIP Large chunks are not supported -95
  ok 3 nk_qlease.test_attrs
  ok 4 nk_qlease.test_attach_xdp_with_mp
  ok 5 nk_qlease.test_destroy
  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/netdev/20260522113225.241337-1-bjorn@kernel.org/ [0]
---
 .../selftests/drivers/net/hw/nk_qlease.py     | 86 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
index fee114676fd8..90d688453ddf 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -32,6 +32,15 @@ from lib.py import (
 )
 from lib.py import KsftSkipEx, CmdExitFailure
 
+# iou-zcrx exits with 42 from setup_zcrx() when the NIC does not advertise
+# QCFG_RX_PAGE_SIZE (or otherwise rejects the requested rx_buf_len).
+SKIP_CODE = 42
+
+
+def _restore_hugepages(count):
+    with open("/proc/sys/vm/nr_hugepages", "w", encoding="utf-8") as f:
+        f.write(str(count))
+
 
 def _create_netkit_pair(cfg, rxqueues=2):
     if cfg.nk_host_ifname:
@@ -188,6 +197,75 @@ def test_iou_zcrx(cfg) -> None:
         cmd(tx_cmd, host=cfg.remote)
 
 
+def test_iou_zcrx_large_buf(cfg) -> None:
+    """iou-zcrx with rx_buf_len > page size, going through a netkit-leased
+    queue. Exercises the queue rx-buf-len path via netif_mp_open_rxq()'s
+    lease redirect: the netkit ifindex is opaque to io_uring, but
+    rx_page_size is honoured by the *physical* qops because the lease
+    pointer rewrites the request from netkit onto the leased physical
+    rxq before supported_params/validate_qcfg are consulted.
+    """
+    cfg.require_ipver("6")
+    src_queue, nk_queue = _setup_lease(cfg)
+    defer(_teardown_netkit, cfg)
+    ethnl = EthtoolFamily()
+
+    with open("/proc/sys/vm/nr_hugepages", "r+", encoding="utf-8") as f:
+        nr_hugepages = int(f.read().strip())
+        if nr_hugepages < 64:
+            f.seek(0)
+            f.write("64")
+            defer(_restore_hugepages, nr_hugepages)
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
+    ethtool(f"-X {cfg.ifname} equal {src_queue}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    flow_rule_id = set_flow_rule(cfg, src_queue)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    # -x 2 asks iou-zcrx for rx_buf_len = 2 * page_size (8 KiB on x86_64),
+    # backed by a 2 MiB hugepage area so the chunks are physically
+    # contiguous, which is what zcrx requires for non-default rx_buf_len.
+    rx_cmd = (
+        f"ip netns exec {cfg.netns.name} {cfg.bin_local} "
+        f"-s -p {cfg.port} -i {cfg.nk_guest_ifname} -q {nk_queue} -x 2"
+    )
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
+
+    # Probe via -d (dry run): exits with SKIP_CODE if the leased physical
+    # qops doesn't advertise QCFG_RX_PAGE_SIZE (e.g. older bnxt FW/HW).
+    probe = cmd(rx_cmd + " -d", fail=False)
+    if probe.ret == SKIP_CODE:
+        msg = probe.stdout.strip() or "rx_buf_len not supported by leased NIC"
+        raise KsftSkipEx(msg)
+
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
+        cmd(tx_cmd, host=cfg.remote)
+
+
 def test_attrs(cfg) -> None:
     cfg.require_ipver("6")
     src_queue, nk_queue = _setup_lease(cfg)
@@ -350,7 +428,13 @@ def main() -> None:
         cfg.port = rand_port()
 
         ksft_run(
-            [test_iou_zcrx, test_attrs, test_attach_xdp_with_mp, test_destroy],
+            [
+                test_iou_zcrx,
+                test_iou_zcrx_large_buf,
+                test_attrs,
+                test_attach_xdp_with_mp,
+                test_destroy,
+            ],
             args=(cfg,),
         )
     ksft_exit()
-- 
2.43.0


