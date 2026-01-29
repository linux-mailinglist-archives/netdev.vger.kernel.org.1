Return-Path: <netdev+bounces-254937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB+TKnLfe2llJAIAu9opvQ
	(envelope-from <netdev+bounces-254937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:30:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270BB5509
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D09E303DAE5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4391E314D17;
	Thu, 29 Jan 2026 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mSPYQYIY"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429536BCCC;
	Thu, 29 Jan 2026 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725758; cv=none; b=eroEsRce2kGz3Dne8uylV+pnfxfN3UuaKVeFW4GUhV/1o6Csum7Z4MTkoY7rCHcjWFN+5AXL18ly1X0xYZRamEeObOO4TCZ5QNy4aCb9LxmEQ1vxcUKiDLOp7TFRWkUp4B9YbKqDptungmrAT0wMKwvPVaxREg25yPAMAsr2c+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725758; c=relaxed/simple;
	bh=dcQEHf+ceGfcmp0SuXhzcEeMTAF6Frc5PZKOaTDasx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6gT+BVhsM0M+r9F0IdjCaNaqg3OmVb2poXlV+ZtA+hQFH26vDWu+zHfLLPTWncGI/lyDAClRfYrcTAwGwnQKp3KGWFFCYJkRuLStW/tJjq0cT+/NmNq4Ul+BXqcTeloDw9GDniZJ2S/2LZ8+tTE8k+Zom5rZPirJnmPPjfh+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mSPYQYIY; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ug54kLSMTm1GYkRBJVp2T5IsaYxEeg+1ou2sFG41k/0=; b=mSPYQYIYru/+p8ODBQJvPbY4W4
	WPSRmuxbIvtWdC5OLTX+BBeQGyIkICa/LTsXx8pRo945ZXiVmezwauDmobuI0KsD0+ehfMvVzi6Rx
	NtmWihJYjYZs9nE+awLk81QI3Uslce+zYh7TRUDC6eGsQ0O4yKji+kIYpcyDoyZwLC00Grnr3L2Ti
	YoMSClbgkgY0yzk3B+WHXVNxb0HIHZeQSxZdOtUQ5J6KRKvhKKU8XtchnEtIhT4lhALo399K603Lx
	RXOJcajte3SR/uKiwbQK9Lq2lUok+O41QCFm7zBZp6fM5M9rXSRCTCkPDbk44CQepTdRJf3yGDt7j
	h0epJh8A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vlaVN-0008qq-23;
	Thu, 29 Jan 2026 23:28:49 +0100
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
Subject: [PATCH net-next v8 16/16] selftests/net: Add netkit container tests
Date: Thu, 29 Jan 2026 23:28:30 +0100
Message-ID: <20260129222830.439687-17-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129222830.439687-1-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27896/Thu Jan 29 08:24:11 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254937-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nk_qlease.py:url,davidwei.uk:email,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2270BB5509
X-Rspamd-Action: no action

From: David Wei <dw@davidwei.uk>

Add two tests using NetDrvContEnv. One basic test that sets up a netkit
pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
program to ping from a remote host to the netkit in netns.

Second is a selftest for netkit queue leasing, using io_uring zero copy
test binary inside of a netns with netkit. This checks that memory
providers can be bound against virtual queues in a netkit within a
netns that are leasing from a physical netdev in the default netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/hw/Makefile |  2 +
 .../selftests/drivers/net/hw/nk_netns.py      | 23 +++++
 .../selftests/drivers/net/hw/nk_qlease.py     | 90 +++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 9c163ba6feee..39ad86d693b3 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,8 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_netns.py \
+	nk_qlease.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_netns.py b/tools/testing/selftests/drivers/net/hw/nk_netns.py
new file mode 100755
index 000000000000..afa8638195d8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_netns.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import NetDrvContEnv
+from lib.py import cmd
+
+
+def test_ping(cfg) -> None:
+    cfg.require_ipver("6")
+
+    cmd(f"ping -c 1 -W5 {cfg.nk_guest_ipv6}", host=cfg.remote)
+    cmd(f"ping -c 1 -W5 {cfg.remote_addr_v['6']}", ns=cfg.netns)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__) as cfg:
+        ksft_run([test_ping], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
new file mode 100755
index 000000000000..85db7c358a95
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
@@ -0,0 +1,90 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import re
+from os import path
+from lib.py import ksft_run, ksft_exit
+from lib.py import NetDrvContEnv, NetNSEnter, EthtoolFamily, NetdevFamily
+from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen, ip
+
+
+def create_rss_ctx(cfg):
+    output = ethtool(f"-X {cfg.ifname} context new start {cfg.src_queue} equal 1").stdout
+    values = re.search(r'New RSS context is (\d+)', output).group(1)
+    return int(values)
+
+
+def set_flow_rule(cfg):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.src_queue}").stdout
+    values = re.search(r'ID (\d+)', output).group(1)
+    return int(values)
+
+
+def set_flow_rule_rss(cfg, rss_ctx_id):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} context {rss_ctx_id}").stdout
+    values = re.search(r'ID (\d+)', output).group(1)
+    return int(values)
+
+
+def test_iou_zcrx(cfg) -> None:
+    cfg.require_ipver('6')
+    ethnl = EthtoolFamily()
+
+    channels = ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    channels = channels['combined-count']
+    if channels < 2:
+        raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
+
+    rings = ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    rx_rings = rings['rx']
+    hds_thresh = rings.get('hds-thresh', 0)
+
+    ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'enabled',
+                         'hds-thresh': 0,
+                         'rx': 64})
+    defer(ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                                'tcp-data-split': 'unknown',
+                                'hds-thresh': hds_thresh,
+                                'rx': rx_rings})
+
+    cfg.src_queue = channels - 1
+    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    flow_rule_id = set_flow_rule(cfg)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    with NetNSEnter(str(cfg.netns)):
+        netdevnl = NetdevFamily()
+        bind_result = netdevnl.queue_create(
+            {
+                "ifindex": cfg.nk_guest_ifindex,
+                "type": "rx",
+                "lease": {
+                    "ifindex": cfg.ifindex,
+                    "queue": {"id": cfg.src_queue, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+        cfg.nk_queue = bind_result['id']
+
+    rx_cmd = f"ip netns exec {cfg.netns.name} {cfg.bin_local} -s -p {cfg.port} -i {cfg._nk_guest_ifname} -q {cfg.nk_queue}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.nk_guest_ipv6} -p {cfg.port} -l 12840"
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
+        cmd(tx_cmd, host=cfg.remote)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__, rxqueues=2) as cfg:
+        cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+        cfg.port = rand_port()
+        ksft_run([test_iou_zcrx], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


