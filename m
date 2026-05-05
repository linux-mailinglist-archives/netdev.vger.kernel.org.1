Return-Path: <netdev+bounces-284409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKtNCerv+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A244CE70B
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7B7302F346
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C3D47D959;
	Tue,  5 May 2026 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ntuXhJka"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97725478E28
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987426; cv=none; b=qeABBFeyMvIQK5F1uPoAeJnQdBRY1Owc6IEoHU3milHsRbT36zNMYea0VYYwSdXyjIm9RMGp51wd0+vkvnxqZx+SggqA0lf+UXM8PNe+YUjxyHCJh5hth8NXMJyN1W7n6oqRNyYnhnd31i4xOWUjsYqBldwXzuZpUmLMHg2PrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987426; c=relaxed/simple;
	bh=tB/5Uig6mcP84PKGeHAG1MZPlC1PO6yVeUo9Nmh8AkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcyESF7QUygKRZe8nW3N8LyHsJbsglt0DLpFh6zYQuCWRmdo41VgNk0k+LkzPMVeabnpsRlPe1FRzXtQSKn1XuEUR2YilpdEgDItMd6Q+HDsCvGIda0xFXIX7o8P2K0UneHUg1S8MEhV7phclgBtnO4fvx4cgeTHZTu4VzOC6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ntuXhJka; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CB42120704;
	Tue,  5 May 2026 15:23:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4V6T4mwrm2D; Tue,  5 May 2026 15:23:40 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A210C206E9;
	Tue,  5 May 2026 15:23:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A210C206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777987420;
	bh=Jt5NishGy6ZKSgZPMuwBiy3Hlt3cgEZ70XiQ24jLCDA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ntuXhJkaY107WpzlLMv1uO30uE+JWRWK3phaNqo1vDi4KlDQxMRL5WDmEZRsXp34L
	 WohuMOyGrOajJOV4Lf/+jzfxEVA6pPBe+PMRH8xi+SaqzLDmaFJ0eYyQNKWc3tSYWB
	 y/hHAMLektPbHepPw4yC3RTBzELqxF1z9UbXZTNicfB9KTcI6X+dxwr/PXk8p3wNwD
	 kCc+SyYnPnZt5NZJclGZHuk2dyqtdc3oFo5bQ+P7WMmdLibwF+VdMJ0nKgPCxlirfk
	 2W6XyP2yILEd/J3r8MwzIlnREeeBgS08sMxh6TaDXn46EPJifB0C8d7nPV79Tc+1AT
	 fOhYUzY5QE95g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 15:23:40 +0200
Received: (nullmailer pid 1364089 invoked by uid 1000);
	Tue, 05 May 2026 13:23:30 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/8] tools/selftests: Add a VXLAN+IPsec traffic test
Date: Tue, 5 May 2026 15:23:00 +0200
Message-ID: <20260505132326.1362733-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132326.1362733-1-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: B8A244CE70B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-284409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,secunet.com:dkim,secunet.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,ipsec_vxlan.py:url,lib.py:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Cosmin Ratiu <cratiu@nvidia.com>

There are VXLAN tests and IPsec tests, but there is no test that
combines the two protocols and exercises the tunnel-over-ipsec code
paths. Fix that by adding a traffic test with VXLAN and IPsec using
crypto offload. This is runnable on HW which supports ESP offload (so no
nsim unfortunately).

Traffic is done with iperf3 and the test validates that there are no
packet drops and iperf3 can get to at least 100 Mbps (a very
conservative value on today's crypto offload HW, as it can typically
reach multi-Gbps rates).

Ran right now, the test fails due to a recently exposed bug in xfrm,
which will be fixed in the next patch:
 # ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
 TAP version 13
 1..4
 # Check| At ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py,
 # line 161, in test_vxlan_ipsec_crypto_offload:
 # Check|     ksft_eq(drops_after - drops_before, 0,
 # Check failed 189 != 0 TX drops during VXLAN+IPsec
 # Check| At ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py,
 # line 163, in test_vxlan_ipsec_crypto_offload:
 # Check|     ksft_ge(bw_gbps, 0.1,
 # Check failed 0.0015058278404812596 < 0.1 Minimum 100Mbps over
 # VXLAN+IPsec
 not ok 1 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v4_inner_v4
 ...

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   5 +
 .../selftests/drivers/net/hw/ipsec_vxlan.py   | 204 ++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 85ca4d1ecf9e..3b6ff4708005 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -30,6 +30,7 @@ TEST_PROGS = \
 	gro_hw.py \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
+	ipsec_vxlan.py \
 	iou-zcrx.py \
 	irq.py \
 	loopback.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index dd50cb8a7911..ae0168c2bbe6 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -12,5 +12,10 @@ CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_ESP_OFFLOAD=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_UDMABUF=y
 CONFIG_VXLAN=y
+CONFIG_XFRM_USER=y
diff --git a/tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py b/tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
new file mode 100755
index 000000000000..0740a4d85240
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
@@ -0,0 +1,204 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Traffic test for VXLAN + IPsec crypto-offload."""
+
+import os
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge
+from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx
+from lib.py import CmdExitFailure, NetDrvEpEnv, cmd, defer, ethtool, ip
+from lib.py import Iperf3Runner
+
+# Inner tunnel addresses - TEST-NET-2 (RFC 5737) / doc prefix (RFC 3849)
+INNER_V4_LOCAL = "198.51.100.1"
+INNER_V4_REMOTE = "198.51.100.2"
+INNER_V6_LOCAL = "2001:db8:100::1"
+INNER_V6_REMOTE = "2001:db8:100::2"
+
+# ESP parameters
+SPI_OUT = "0x1000"
+SPI_IN = "0x1001"
+# 128-bit key + 32-bit salt = 20 bytes hex, 128-bit ICV
+ESP_AEAD = "aead 'rfc4106(gcm(aes))' 0x" + "01" * 20 + " 128"
+
+
+def xfrm(args, host=None):
+    """Runs 'ip xfrm' via shell to preserve parentheses in algo names."""
+    cmd(f"ip xfrm {args}", shell=True, host=host)
+
+
+def check_xfrm_offload_support():
+    """Skips if iproute2 lacks xfrm offload support."""
+    out = cmd("ip xfrm state help", fail=False)
+    if "offload" not in out.stdout + out.stderr:
+        raise KsftSkipEx("iproute2 too old, missing xfrm offload")
+
+
+def check_esp_hw_offload(cfg):
+    """Skips if device lacks esp-hw-offload support."""
+    check_xfrm_offload_support()
+    try:
+        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    except (CmdExitFailure, IndexError) as e:
+        raise KsftSkipEx(f"can't query features: {e}") from e
+    if not feat.get("esp-hw-offload", {}).get("active"):
+        raise KsftSkipEx("Device does not support esp-hw-offload")
+
+
+def get_tx_drops(cfg):
+    """Returns TX dropped counter from the physical device."""
+    stats = ip("-s -s link show dev " + cfg.ifname, json=True)[0]
+    return stats["stats64"]["tx"]["dropped"]
+
+
+def setup_vxlan_ipsec(cfg, outer_ipver, inner_ipver):
+    """Sets up VXLAN tunnel with IPsec transport-mode crypto-offload."""
+    vxlan_name = f"vx{os.getpid()}"
+    local_addr = cfg.addr_v[outer_ipver]
+    remote_addr = cfg.remote_addr_v[outer_ipver]
+
+    if inner_ipver == "4":
+        inner_local = f"{INNER_V4_LOCAL}/24"
+        inner_remote = f"{INNER_V4_REMOTE}/24"
+        addr_extra = ""
+    else:
+        inner_local = f"{INNER_V6_LOCAL}/64"
+        inner_remote = f"{INNER_V6_REMOTE}/64"
+        addr_extra = " nodad"
+
+    if outer_ipver == "6":
+        vxlan_opts = "udp6zerocsumtx udp6zerocsumrx"
+    else:
+        vxlan_opts = "noudpcsum"
+
+    # VXLAN tunnel - local side
+    ip(f"link add {vxlan_name} type vxlan id 100 dstport 4789 {vxlan_opts} "
+       f"local {local_addr} remote {remote_addr} dev {cfg.ifname}")
+    defer(ip, f"link del {vxlan_name}")
+    ip(f"addr add {inner_local} dev {vxlan_name}{addr_extra}")
+    ip(f"link set {vxlan_name} up")
+
+    # VXLAN tunnel - remote side
+    ip(f"link add {vxlan_name} type vxlan id 100 dstport 4789 {vxlan_opts} "
+       f"local {remote_addr} remote {local_addr} dev {cfg.remote_ifname}",
+       host=cfg.remote)
+    defer(ip, f"link del {vxlan_name}", host=cfg.remote)
+    ip(f"addr add {inner_remote} dev {vxlan_name}{addr_extra}",
+       host=cfg.remote)
+    ip(f"link set {vxlan_name} up", host=cfg.remote)
+
+    # xfrm state - local outbound SA
+    xfrm(f"state add src {local_addr} dst {remote_addr} "
+         f"proto esp spi {SPI_OUT} "
+         f"{ESP_AEAD} "
+         f"mode transport offload crypto dev {cfg.ifname} dir out")
+    defer(xfrm, f"state del src {local_addr} dst {remote_addr} "
+                f"proto esp spi {SPI_OUT}")
+
+    # xfrm state - local inbound SA
+    xfrm(f"state add src {remote_addr} dst {local_addr} "
+         f"proto esp spi {SPI_IN} "
+         f"{ESP_AEAD} "
+         f"mode transport offload crypto dev {cfg.ifname} dir in")
+    defer(xfrm, f"state del src {remote_addr} dst {local_addr} "
+                f"proto esp spi {SPI_IN}")
+
+    # xfrm state - remote outbound SA (mirror, software crypto)
+    xfrm(f"state add src {remote_addr} dst {local_addr} "
+         f"proto esp spi {SPI_IN} "
+         f"{ESP_AEAD} "
+         f"mode transport",
+         host=cfg.remote)
+    defer(xfrm, f"state del src {remote_addr} dst {local_addr} "
+                f"proto esp spi {SPI_IN}", host=cfg.remote)
+
+    # xfrm state - remote inbound SA (mirror, software crypto)
+    xfrm(f"state add src {local_addr} dst {remote_addr} "
+         f"proto esp spi {SPI_OUT} "
+         f"{ESP_AEAD} "
+         f"mode transport",
+         host=cfg.remote)
+    defer(xfrm, f"state del src {local_addr} dst {remote_addr} "
+                f"proto esp spi {SPI_OUT}", host=cfg.remote)
+
+    # xfrm policy - local out
+    xfrm(f"policy add src {local_addr} dst {remote_addr} "
+         f"proto udp dport 4789 dir out "
+         f"tmpl src {local_addr} dst {remote_addr} proto esp mode transport")
+    defer(xfrm, f"policy del src {local_addr} dst {remote_addr} "
+                f"proto udp dport 4789 dir out")
+
+    # xfrm policy - local in
+    xfrm(f"policy add src {remote_addr} dst {local_addr} "
+         f"proto udp dport 4789 dir in "
+         f"tmpl src {remote_addr} dst {local_addr} proto esp mode transport")
+    defer(xfrm, f"policy del src {remote_addr} dst {local_addr} "
+                f"proto udp dport 4789 dir in")
+
+    # xfrm policy - remote out
+    xfrm(f"policy add src {remote_addr} dst {local_addr} "
+         f"proto udp dport 4789 dir out "
+         f"tmpl src {remote_addr} dst {local_addr} proto esp mode transport",
+         host=cfg.remote)
+    defer(xfrm, f"policy del src {remote_addr} dst {local_addr} "
+                f"proto udp dport 4789 dir out", host=cfg.remote)
+
+    # xfrm policy - remote in
+    xfrm(f"policy add src {local_addr} dst {remote_addr} "
+         f"proto udp dport 4789 dir in "
+         f"tmpl src {local_addr} dst {remote_addr} proto esp mode transport",
+         host=cfg.remote)
+    defer(xfrm, f"policy del src {local_addr} dst {remote_addr} "
+                f"proto udp dport 4789 dir in", host=cfg.remote)
+
+
+def _vxlan_ipsec_variants():
+    """Generates outer/inner IP version variants."""
+    for outer in ["4", "6"]:
+        for inner in ["4", "6"]:
+            yield KsftNamedVariant(f"outer_v{outer}_inner_v{inner}", outer, inner)
+
+
+@ksft_variants(_vxlan_ipsec_variants())
+def test_vxlan_ipsec_crypto_offload(cfg, outer_ipver, inner_ipver):
+    """Tests VXLAN+IPsec crypto-offload has no TX drops."""
+    cfg.require_ipver(outer_ipver)
+    check_esp_hw_offload(cfg)
+
+    setup_vxlan_ipsec(cfg, outer_ipver, inner_ipver)
+
+    if inner_ipver == "4":
+        inner_local = INNER_V4_LOCAL
+        inner_remote = INNER_V4_REMOTE
+        ping = "ping"
+    else:
+        inner_local = INNER_V6_LOCAL
+        inner_remote = INNER_V6_REMOTE
+        ping = "ping -6"
+
+    cmd(f"{ping} -c 1 -W 2 {inner_remote}")
+
+    drops_before = get_tx_drops(cfg)
+
+    runner = Iperf3Runner(cfg, server_ip=inner_local,
+                          client_ip=inner_remote)
+    bw_gbps = runner.measure_bandwidth(reverse=True)
+
+    cfg.wait_hw_stats_settle()
+    drops_after = get_tx_drops(cfg)
+
+    ksft_eq(drops_after - drops_before, 0,
+            comment="TX drops during VXLAN+IPsec")
+    ksft_ge(bw_gbps, 0.1,
+            comment="Minimum 100Mbps over VXLAN+IPsec")
+
+
+def main():
+    """Runs VXLAN+IPsec crypto-offload GSO selftest."""
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        ksft_run([test_vxlan_ipsec_crypto_offload], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


