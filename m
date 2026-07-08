Return-Path: <netdev+bounces-305804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lGuvABNITmptKAIAu9opvQ
	(envelope-from <netdev+bounces-305804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:52:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52A726789
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:52:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=fQeyYRDE;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305804-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305804-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9CA2301D624
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C4453495;
	Wed,  8 Jul 2026 12:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster4-host1-snip4-10.eps.apple.com [57.103.69.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E4348C5E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:51:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515121; cv=none; b=Tf7ukt+wBQPjEjlq8CkfyEwEdQtv/VQDemxJl9yNVbCXT+gLrUZfcYq8tERb2uYM+UZGR9134H60YRVhdg9PzgD9Ud9z4HkA+2T9TkvTzvJ6dufhUHaVp+8Tl3/z/b59J+GEJn2kdRc9hy4L8Y/JGg+0n4DxlIRZCf9yjziq+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515121; c=relaxed/simple;
	bh=epJE3FjRRMZH1j6w83nuzNXHE1DUTjxiXNRFyBT89hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imKEhEkqktWLn1OJC18En6jKI2qZXS8ABQmvC0IFMLS4OgNzJINzNCIPO8DQiPm40+uTPgqgjgEIcJPs7XJNJhDnX0NaLY+B81r1tJfhW2ds9aLaGe820rhB4aolGHUEirspA/CupO9OVPryGKW2Fy+v1Rlz0bGGMP+5uzaZAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=fQeyYRDE; arc=none smtp.client-ip=57.103.69.201
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id C6421180124A;
	Wed, 08 Jul 2026 12:51:54 +0000 (UTC)
X-ICL-RepId: 019f41c8-ece5-7edc-8754-c21d3f1ea987
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNDGRBWAVhWXQVNGlwYWQ8cHUtWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTA8bBAwHXgtADE9XXgdSV0kAQVFaB11QRVtNB1pVDgsTD0oDDlJeBkQXSQRVBF4DRA1NBkNQAkZeXR1fBEUKXDBPHUEJXghGXl4fDU1DEkIVBBtGHkMEXy9dF14MXgU=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783515117; x=1786107117; bh=1mg1MAu0S8MHTtkv+qfYoBgJ3Q1TF/jdB077ZSFG5MY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=fQeyYRDEiMN9snNTyC77qoh0rZRo5Fb8ESl15stsGNtH58gmDsdjg/id/BlC03e8vEv/mRMtXuYlZ18q9RWLcjmQqXuaemEmi4hRUxt8UnxNo6T8zgk+K1MoBxQ9rpkFROrim1y8uu4dHnPdP5eQxvlXtLIuVKY/1sXHbjHI2/ydU+L4ESmZsILyy7dl5Duswj0cvVnj82V6Et+EbRR8+ZP5+AEDen1QkORgHKuTiEgt3wy695M9OmZIO0kLF76ztrkMOmKY1jC1tuhbrNGkC93GfHsdfnDjUmlrhdRLBGOq7Zidr8HTpUcSBhY7+IQwnrKHmktnHe+j8X5r/9SdQQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id 5D583180012A;
	Wed, 08 Jul 2026 12:51:51 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: lorenzo@kernel.org
Cc: sdf@fomichev.me,
	kuba@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	sdf.kernel@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next 1/1] selftests: drv-net: add XDP RX checksum metadata tests
Date: Wed,  8 Jul 2026 15:51:44 +0300
Message-ID: <6c7a059057d309e999b706b5b547be9c620ce544.1783514455.git.deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1783514455.git.deliran@verdict.gg>
References: <akZ7QPfn83OUx5Vm@lore-desk> <cover.1783514455.git.deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lAfsODhRtDN3VrE34zpvOhq97Yg9ssWC
X-Proofpoint-ORIG-GUID: lAfsODhRtDN3VrE34zpvOhq97Yg9ssWC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyNSBTYWx0ZWRfXzwc+VowR7H55
 XCRoML9MXRSBSIo7Ao4kc9MPPXuQsmO76+PHK5rhtcpZxCj1pMYfWRAd+W68fXXsDzPfunRDLyE
 kVgqim3B9eyPDLx54Jyn27zNJ/nPK6Qv3zVMHb/yOAAHZ6N3kLRqz2qLSZSD81MXaFLRa4nHdcb
 0jkY8qT63d7zbMRtD0d9GfVSbpnhup60HAmBkvpldRvOG+AT4nwPrzQdrnDI1vBn2VzoJUaBqKw
 56oEbdX4bVz+k0msDgTnXv1bKnUsiBzOKXLxQFQVovsYZvXDnSN/tG+6aO6rK7LC2NMUsc4pijX
 EunUDCG0bJhMFO4lCtz
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305804-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[verdict.gg];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:sdf@fomichev.me,m:kuba@kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:sdf.kernel@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[fomichev.me,kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,verdict.gg];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F52A726789

Extend the xdp_metadata.py driver test with coverage for
bpf_xdp_metadata_rx_checksum().

Add an xdp_rx_csum program to xdp_metadata.bpf.o that reads the RX
checksum verdict and stores the ip_summed bitmask, the hw checksum
value and the checksum level into a map.  The L4 port/protocol filter
is the same as in the existing xdp_rss_hash program, so move it into a
common helper.

The new cases only run on devices whose driver implements the
xmo_rx_checksum callback, detected through the "checksum" bit of the
xdp-rx-metadata-features netlink attribute; on other devices they
report SKIP:

 - xdp_rx_csum_valid (tcp/udp variants): traffic with a correct
   checksum sent from the remote endpoint must be reported with a
   usable verdict, i.e. CHECKSUM_UNNECESSARY and/or CHECKSUM_COMPLETE;

 - xdp_rx_csum_invalid: UDP packets with a corrupted L4 checksum
   (sent with the net/lib csum tool) must not be reported as
   CHECKSUM_UNNECESSARY.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 .../selftests/drivers/net/hw/xdp_metadata.py  | 103 ++++++++++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 112 ++++++++++++++++--
 2 files changed, 202 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
index 33a1985356d9..687c43a1797a 100644
--- a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
+++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
@@ -8,6 +8,8 @@ These tests load device-bound XDP programs from xdp_metadata.bpf.o
 that call metadata kfuncs, send traffic, and verify the extracted
 metadata via BPF maps.
 """
+import time
+
 from lib.py import ksft_run, ksft_eq, ksft_exit, ksft_ge, ksft_ne, ksft_pr
 from lib.py import KsftNamedVariant, ksft_variants
 from lib.py import CmdExitFailure, KsftSkipEx, NetDrvEpEnv
@@ -81,8 +83,22 @@ _RSS_KEY_TYPE = 1
 _RSS_KEY_PKT_CNT = 2
 _RSS_KEY_ERR_CNT = 3
 
+_CSUM_KEY_IP_SUMMED = 0
+_CSUM_KEY_CKSUM = 1
+_CSUM_KEY_LEVEL = 2
+_CSUM_KEY_PKT_CNT = 3
+_CSUM_KEY_ERR_CNT = 4
+
 XDP_RSS_L4 = 0x8  # BIT(3) from enum xdp_rss_hash_type
 
+# Mirror of enum xdp_checksum from include/net/xdp.h
+XDP_CHECKSUM_NONE = 0x1
+XDP_CHECKSUM_UNNECESSARY = 0x2
+XDP_CHECKSUM_COMPLETE = 0x4
+
+# Fixed destination port of the net/lib csum tool
+_CSUM_TOOL_PORT = 34000
+
 
 @ksft_variants([
     KsftNamedVariant("tcp", "tcp"),
@@ -130,6 +146,91 @@ def test_xdp_rss_hash(cfg, proto):
             f"RSS hash type should include L4 for {proto.upper()} traffic")
 
 
+def _require_rx_csum_meta(cfg):
+    """Skip unless the device exposes XDP RX checksum metadata."""
+    dev_info = cfg.netnl.dev_get({"ifindex": cfg.ifindex})
+    rx_meta = dev_info.get("xdp-rx-metadata-features", [])
+    if "checksum" not in rx_meta:
+        raise KsftSkipEx("device does not support XDP rx checksum metadata")
+
+
+@ksft_variants([
+    KsftNamedVariant("tcp", "tcp"),
+    KsftNamedVariant("udp", "udp"),
+])
+def test_xdp_rx_csum_valid(cfg, proto):
+    """Test RX checksum metadata for packets with a correct checksum.
+
+    Loads the xdp_rx_csum program, sends traffic with a valid L4 checksum
+    from the remote endpoint, and verifies that the device reported a
+    usable checksum verdict (CHECKSUM_UNNECESSARY and/or a
+    CHECKSUM_COMPLETE value) via bpf_xdp_metadata_rx_checksum().
+    """
+    _require_rx_csum_meta(cfg)
+
+    prog_info = _load_xdp_metadata_prog(cfg, "xdp_rx_csum")
+
+    port = rand_port()
+    bpf_map_set("map_xdp_setup", _SETUP_KEY_PORT, port)
+
+    csum_map_id = prog_info["maps"]["map_csum"]
+
+    _send_probe(cfg, port, proto=proto)
+
+    csum = bpf_map_dump(csum_map_id)
+
+    pkt_cnt = csum.get(_CSUM_KEY_PKT_CNT, 0)
+    err_cnt = csum.get(_CSUM_KEY_ERR_CNT, 0)
+    ip_summed = csum.get(_CSUM_KEY_IP_SUMMED, 0)
+
+    ksft_ge(pkt_cnt, 1, comment="should have received at least one packet")
+    ksft_eq(err_cnt, 0, comment=f"RX checksum error count: {err_cnt}")
+
+    ksft_pr(f"  ip_summed: {ip_summed:#x} cksum: "
+            f"{csum.get(_CSUM_KEY_CKSUM, 0):#010x} "
+            f"level: {csum.get(_CSUM_KEY_LEVEL, 0)}")
+    ksft_ne(ip_summed & (XDP_CHECKSUM_UNNECESSARY | XDP_CHECKSUM_COMPLETE), 0,
+            "device should report a checksum verdict for a valid packet")
+
+
+def test_xdp_rx_csum_invalid(cfg):
+    """Test RX checksum metadata for packets with a corrupted checksum.
+
+    Sends UDP packets with an intentionally bad L4 checksum using the
+    net/lib csum tool and verifies the device does not claim it validated
+    them: the CHECKSUM_UNNECESSARY bit must not be set.
+    """
+    _require_rx_csum_meta(cfg)
+
+    ipver = cfg.addr_ipver
+    bin_remote = cfg.remote.deploy(cfg.net_lib_dir / "csum")
+
+    prog_info = _load_xdp_metadata_prog(cfg, "xdp_rx_csum")
+
+    bpf_map_set("map_xdp_setup", _SETUP_KEY_PORT, _CSUM_TOOL_PORT)
+
+    csum_map_id = prog_info["maps"]["map_csum"]
+
+    cmd(f"{bin_remote} -i {cfg.remote_ifname} -n 20 -{ipver} "
+        f"-S {cfg.remote_addr} -D {cfg.addr} -r 1 -T -E",
+        host=cfg.remote)
+
+    # no receiver to synchronize against; let NAPI drain the last packets
+    time.sleep(1)
+
+    csum = bpf_map_dump(csum_map_id)
+
+    pkt_cnt = csum.get(_CSUM_KEY_PKT_CNT, 0)
+    ip_summed = csum.get(_CSUM_KEY_IP_SUMMED, 0)
+
+    ksft_ge(pkt_cnt, 1, comment="should have received at least one packet")
+
+    ksft_pr(f"  ip_summed: {ip_summed:#x}")
+    ksft_eq(ip_summed & XDP_CHECKSUM_UNNECESSARY, 0,
+            "device must not report CHECKSUM_UNNECESSARY for a corrupted "
+            "checksum")
+
+
 def main():
     """Run XDP metadata kfunc tests against a real device."""
     with NetDrvEpEnv(__file__) as cfg:
@@ -137,6 +238,8 @@ def main():
         ksft_run(
             [
                 test_xdp_rss_hash,
+                test_xdp_rx_csum_valid,
+                test_xdp_rx_csum_invalid,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
index f71f59215239..70decae0a663 100644
--- a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stddef.h>
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/if_ether.h>
@@ -40,6 +41,24 @@ struct {
 	__uint(max_entries, 4);
 } map_rss SEC(".maps");
 
+/* RX checksum results: key 0 = ip_summed bitmask, key 1 = hw cksum value,
+ * key 2 = cksum level, key 3 = packet count, key 4 = error count.
+ */
+enum {
+	CSUM_KEY_IP_SUMMED = 0,
+	CSUM_KEY_CKSUM = 1,
+	CSUM_KEY_LEVEL = 2,
+	CSUM_KEY_PKT_CNT = 3,
+	CSUM_KEY_ERR_CNT = 4,
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 5);
+} map_csum SEC(".maps");
+
 /* Mirror of enum xdp_rss_hash_type from include/net/xdp.h.
  * Needed because the enum is not part of UAPI headers.
  */
@@ -55,8 +74,20 @@ enum xdp_rss_hash_type {
 	XDP_RSS_L4_ICMP = 1U << 8,
 };
 
+/* Mirror of enum xdp_checksum from include/net/xdp.h.
+ * Needed because the enum is not part of UAPI headers.
+ */
+enum xdp_checksum {
+	XDP_CHECKSUM_NONE = 1U << 0,
+	XDP_CHECKSUM_UNNECESSARY = 1U << 1,
+	XDP_CHECKSUM_COMPLETE = 1U << 2,
+};
+
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
+					enum xdp_checksum *ip_summed,
+					__u32 *cksum, __u8 *cksum_level) __ksym;
 
 static __always_inline __u16 get_dest_port(void *l4, void *data_end,
 					   __u8 protocol)
@@ -78,41 +109,39 @@ static __always_inline __u16 get_dest_port(void *l4, void *data_end,
 	return 0;
 }
 
-SEC("xdp")
-int xdp_rss_hash(struct xdp_md *ctx)
+/* Return true when the packet matches the L4 protocol and destination
+ * port configured in map_xdp_setup (zero/unset filters match anything).
+ */
+static __always_inline bool xdp_match_setup(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
-	enum xdp_rss_hash_type rss_type = 0;
 	struct ethhdr *eth = data;
 	__u8 l4_proto = 0;
-	__u32 hash = 0;
-	__u32 key, val;
 	void *l4 = NULL;
-	__u32 *cnt;
-	int ret;
+	__u32 key;
 
 	if ((void *)(eth + 1) > data_end)
-		return XDP_PASS;
+		return false;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
 		struct iphdr *iph = (void *)(eth + 1);
 
 		if ((void *)(iph + 1) > data_end)
-			return XDP_PASS;
+			return false;
 		l4_proto = iph->protocol;
 		l4 = (void *)(iph + 1);
 	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
 		struct ipv6hdr *ip6h = (void *)(eth + 1);
 
 		if ((void *)(ip6h + 1) > data_end)
-			return XDP_PASS;
+			return false;
 		l4_proto = ip6h->nexthdr;
 		l4 = (void *)(ip6h + 1);
 	}
 
 	if (!l4)
-		return XDP_PASS;
+		return false;
 
 	/* Filter on the configured protocol (map_xdp_setup key XDP_PROTO).
 	 * When set, only process packets matching the requested L4 protocol.
@@ -121,7 +150,7 @@ int xdp_rss_hash(struct xdp_md *ctx)
 	__s32 *proto_cfg = bpf_map_lookup_elem(&map_xdp_setup, &key);
 
 	if (proto_cfg && *proto_cfg != 0 && l4_proto != (__u8)*proto_cfg)
-		return XDP_PASS;
+		return false;
 
 	/* Filter on the configured port (map_xdp_setup key XDP_PORT).
 	 * Only applies to protocols with ports (UDP, TCP).
@@ -133,9 +162,24 @@ int xdp_rss_hash(struct xdp_md *ctx)
 		__u16 dest = get_dest_port(l4, data_end, l4_proto);
 
 		if (!dest || bpf_ntohs(dest) != (__u16)*port_cfg)
-			return XDP_PASS;
+			return false;
 	}
 
+	return true;
+}
+
+SEC("xdp")
+int xdp_rss_hash(struct xdp_md *ctx)
+{
+	enum xdp_rss_hash_type rss_type = 0;
+	__u32 hash = 0;
+	__u32 key, val;
+	__u32 *cnt;
+	int ret;
+
+	if (!xdp_match_setup(ctx))
+		return XDP_PASS;
+
 	ret = bpf_xdp_metadata_rx_hash(ctx, &hash, &rss_type);
 	if (ret < 0) {
 		key = RSS_KEY_ERR_CNT;
@@ -160,4 +204,46 @@ int xdp_rss_hash(struct xdp_md *ctx)
 	return XDP_PASS;
 }
 
+SEC("xdp")
+int xdp_rx_csum(struct xdp_md *ctx)
+{
+	enum xdp_checksum ip_summed = 0;
+	__u8 cksum_level = 0;
+	__u32 cksum = 0;
+	__u32 key, val;
+	__u32 *cnt;
+	int ret;
+
+	if (!xdp_match_setup(ctx))
+		return XDP_PASS;
+
+	ret = bpf_xdp_metadata_rx_checksum(ctx, &ip_summed, &cksum,
+					   &cksum_level);
+	if (ret < 0) {
+		key = CSUM_KEY_ERR_CNT;
+		cnt = bpf_map_lookup_elem(&map_csum, &key);
+		if (cnt)
+			__sync_fetch_and_add(cnt, 1);
+		return XDP_PASS;
+	}
+
+	key = CSUM_KEY_IP_SUMMED;
+	val = (__u32)ip_summed;
+	bpf_map_update_elem(&map_csum, &key, &val, BPF_ANY);
+
+	key = CSUM_KEY_CKSUM;
+	bpf_map_update_elem(&map_csum, &key, &cksum, BPF_ANY);
+
+	key = CSUM_KEY_LEVEL;
+	val = cksum_level;
+	bpf_map_update_elem(&map_csum, &key, &val, BPF_ANY);
+
+	key = CSUM_KEY_PKT_CNT;
+	cnt = bpf_map_lookup_elem(&map_csum, &key);
+	if (cnt)
+		__sync_fetch_and_add(cnt, 1);
+
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.0


