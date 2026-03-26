Return-Path: <netdev+bounces-271996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFjBEpIfxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:59:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3298334D30
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 255BC315E3CD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767B3FBEA1;
	Thu, 26 Mar 2026 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SM96W1tF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495A3F7899;
	Thu, 26 Mar 2026 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525800; cv=none; b=Pt/ARXr7+TkZkLY7rVjLJ1AyZZxcM0p+iwy+qkIx0L1Na/F6z8vSc6RgBrFCXBSV1YRSsssB9N9kzLKd1AiMyyKbeFFytYB/pXZqslnKDalHmqBQEJPn2fV4MwmMmIXLI6DbVOCT1guFzE2527QrQNWb1WnzrPBFd7WggAc55QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525800; c=relaxed/simple;
	bh=I8BjhB09WHI0Dd4PK6+/oKsCoUslOHLL+FHEaRMpywY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g8/tx16G2B7t6s1kxrEVtA7+kJM+30vSXazAjNiw4dRDRtSrDR/zIrVRJWvtadFfbIGLH2rIuVP+YwHPD8IJaigVVZ+HOAq0smoA2sNlx5ZgJsO0z5l5r7PNxye71j/F96VraAjTYKEy83BQPbqBkdxbZMYnRMLG86VbfwjaKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SM96W1tF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525792; x=1806061792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I8BjhB09WHI0Dd4PK6+/oKsCoUslOHLL+FHEaRMpywY=;
  b=SM96W1tFlJMPAx8P9l0G1DOqoKPaZli78txOx9lYXJl9K0Lk1qVrGdfg
   xDXMhf5hdfCgUN5bXhn0sf2XG4BSixh3Shz2TJl5+YD6nw4Kq/tP6bvsH
   85F+rjSSC4FDcMuqsmezs/0d9akP0iC3YYfFMwYZF5+Q5t1ingfVHqFJs
   brveocB11iWDZMEYu5RGGvHM7IdQ201rd6QPBLlhYvGF8yQATAJyN0qOK
   Z/yrQhbhSpjO+fhfBkzyD//NlB4d9qtBV21VGKAguf4AOG+KDb19fqnIr
   wJnO+cF9LVjvqzxMxY+IlyaKtT2d1pOzDNQyyUKqu0kmNezX0dYbNjJm8
   w==;
X-CSE-ConnectionGUID: KB8fSQIOToS7oR/ejq1+mw==
X-CSE-MsgGUID: X9oKVJ5ITduJ7F+KvkFGWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776256"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776256"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:45 -0700
X-CSE-ConnectionGUID: Kbwd/96DSHKjK6ZvZMbbxQ==
X-CSE-MsgGUID: GD5iz+jNTTqywagWdVXm3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029052"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:42 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 05/11] selftests: bpf: introduce a common routine for reading procfs
Date: Thu, 26 Mar 2026 12:49:13 +0100
Message-Id: <20260326114919.519456-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271996-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3298334D30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Parametrize current way of getting MAX_SKB_FRAGS value from procfs so
that it can be re-used to get cache line size of system's CPU. All that
just to mimic and compute size of kernel's struct skb_shared_info which
for xsk and test suite interpret as tailroom.

Introduce two variables to ifobject struct that will carry count of skb
frags and tailroom size. Do the reading and computing once, at the
beginning of test suite execution.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 25 +----------
 .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
 tools/testing/selftests/bpf/xskxceiver.c      | 44 +++++++++++++++++++
 3 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7e38ec6e656b..62118ffba661 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -179,25 +179,6 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
 }
 
-#define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
-static unsigned int get_max_skb_frags(void)
-{
-	unsigned int max_skb_frags = 0;
-	FILE *file;
-
-	file = fopen(MAX_SKB_FRAGS_PATH, "r");
-	if (!file) {
-		ksft_print_msg("Error opening %s\n", MAX_SKB_FRAGS_PATH);
-		return 0;
-	}
-
-	if (fscanf(file, "%u", &max_skb_frags) != 1)
-		ksft_print_msg("Error reading %s\n", MAX_SKB_FRAGS_PATH);
-
-	fclose(file);
-	return max_skb_frags;
-}
-
 static int set_ring_size(struct ifobject *ifobj)
 {
 	int ret;
@@ -2242,11 +2223,7 @@ int testapp_too_many_frags(struct test_spec *test)
 	if (test->mode == TEST_MODE_ZC) {
 		max_frags = test->ifobj_tx->xdp_zc_max_segs;
 	} else {
-		max_frags = get_max_skb_frags();
-		if (!max_frags) {
-			ksft_print_msg("Can't get MAX_SKB_FRAGS from system, using default (17)\n");
-			max_frags = 17;
-		}
+		max_frags = test->ifobj_tx->max_skb_frags;
 		max_frags += 1;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 8fc78a057de0..55d808eeabc5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -115,6 +115,8 @@ struct ifobject {
 	int mtu;
 	u32 bind_flags;
 	u32 xdp_zc_max_segs;
+	u32 umem_tailroom;
+	u32 max_skb_frags;
 	bool tx_on;
 	bool rx_on;
 	bool use_poll;
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 05b3cebc5ca9..2623cf4dd2c5 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -80,6 +80,7 @@
 #include <linux/mman.h>
 #include <linux/netdev.h>
 #include <linux/ethtool.h>
+#include <linux/align.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -101,6 +102,9 @@
 
 #include <network_helpers.h>
 
+#define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
+#define SMP_CACHE_BYTES_PATH "/sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size"
+
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
 static u32 opt_run_test = RUN_ALL_TESTS;
@@ -330,9 +334,28 @@ static void print_tests(void)
 		printf("%u: %s\n", i, ci_skip_tests[i - ARRAY_SIZE(tests)].name);
 }
 
+static unsigned int read_procfs_val(const char *path)
+{
+	unsigned int read_val = 0;
+	FILE *file;
+
+	file = fopen(path, "r");
+	if (!file) {
+		ksft_print_msg("Error opening %s\n", path);
+		return 0;
+	}
+
+	if (fscanf(file, "%u", &read_val) != 1)
+		ksft_print_msg("Error reading %s\n", path);
+
+	fclose(file);
+	return read_val;
+}
+
 int main(int argc, char **argv)
 {
 	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests);
+	u32 cache_line_size, max_frags, umem_tailroom;
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
@@ -354,6 +377,27 @@ int main(int argc, char **argv)
 
 	setlocale(LC_ALL, "");
 
+	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
+	if (!cache_line_size) {
+		ksft_print_msg("Can't get SMP_CACHE_BYTES from system, using default (64)\n");
+		cache_line_size = 64;
+	}
+
+	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
+	if (!max_frags) {
+		ksft_print_msg("Can't get MAX_SKB_FRAGS from system, using default (17)\n");
+		max_frags = 17;
+	}
+	ifobj_tx->max_skb_frags = max_frags;
+	ifobj_rx->max_skb_frags = max_frags;
+
+	/* 48 bytes is a part of skb_shared_info w/o frags array;
+	 * 16 bytes is sizeof(skb_frag_t)
+	 */
+	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
+	ifobj_tx->umem_tailroom = umem_tailroom;
+	ifobj_rx->umem_tailroom = umem_tailroom;
+
 	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
 
 	if (opt_print_tests) {
-- 
2.43.0


