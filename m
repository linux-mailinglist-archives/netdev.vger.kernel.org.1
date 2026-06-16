Return-Path: <netdev+bounces-299894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PRqsEo50MWoKjwUAu9opvQ
	(envelope-from <netdev+bounces-299894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3458691B13
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GMsSQRKJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299894-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299894-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5EC530DCF28
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD143E9FE;
	Tue, 16 Jun 2026 15:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A644CF4E;
	Tue, 16 Jun 2026 15:50:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625027; cv=none; b=MlbkF6ELp+Jk9RTOmHT0ZXjzgyTLzHENQ2kgPaN+4khwQzTb4mN6SZ2WjoaY1TPl7GbtizivwvjUX0fspgh5jmtIUz+ZrcieBK4ASUjOQwEFXW1RBfskXtZGB1KiKvaxdMo9cHnLetkboYWAHbnhqTM9GNtdRfHNNaPb/eumRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625027; c=relaxed/simple;
	bh=wUFlrHhdh51KH0JT/X7j89feiCjAUfGHCvP5NvQI+a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqJDrgkfR1cOF5OF49FRB8/SXm7RvH6m2ZdkPb4aW0zSm2auc3nkOuUYw9HZMeZ0cKoFXIQxTNsQCBZrAYXbX7ejWjARXvPfwxuv0bxJB4RddkOCfzFGmbAoGEg/u6eh9JlX78BncCp/xv55QepSnhBG0AlMZ8FLN8SnZNjQSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMsSQRKJ; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781625025; x=1813161025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wUFlrHhdh51KH0JT/X7j89feiCjAUfGHCvP5NvQI+a0=;
  b=GMsSQRKJA00ArfSCJoPsyiVv2ut1OnIkHXCvp0CBs9sTuOzrX6MxSIFN
   uef44/si/BCxskvTQ4bDykL9Hq6u2RXp7aFveErzWiNw0tKXC4re29sOV
   asjarunopTTLa4QFCt/sHg36yc2IjE1tOyIXVjkEJ7WgVrpaHYTBrmM4b
   NcYo/RkteAw+Qx9RZ1LI5sV1wEfrXWAUSJtto22tOY734fEPiTn+eZWrG
   tkmXsb+y2u1/qjbRgbp0Q0ciUFP4Hy3/vmVUSFeFx6uJTO6EubQ9YrGBr
   Joia5YGPii70zpY9+42xOeHeLO/bR3CAYU9NRarpnfhTH3FqDQ4AQjm+n
   A==;
X-CSE-ConnectionGUID: VrfWPZIYQ02nBwpvdAJr9A==
X-CSE-MsgGUID: Hm/vMRFmQaK7RhqMjys+qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86232994"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86232994"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:25 -0700
X-CSE-ConnectionGUID: O0kxsP17TgaWjaQWk4KWpA==
X-CSE-MsgGUID: n/yDDw/xRsK3VjB4H4vDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247684300"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:21 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next 1/3] selftests/xsk: make poll timeout mode explicit
Date: Tue, 16 Jun 2026 21:19:52 +0530
Message-ID: <20260616154955.1492560-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:tushar.vyavahare@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299894-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3458691B13

Stop inferring timeout behavior from RX UMEM initialization state.
That ties timeout semantics to setup internals and obscures intent.

Use test_spec::poll_tmout as the explicit timeout-mode selector in
TX and RX paths.

In RX, treat poll timeout as expected only in timeout mode.
In TX, let send_pkts() own loop completion in non-timeout mode
and use __send_pkts() only for progress and timeout detection.

This makes timeout logic explicit and keeps control flow predictable.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 44 +++++++++----------
 .../selftests/bpf/prog_tests/test_xsk.h       |  1 +
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 72875071d4f1..ca47a16ceb1a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -65,11 +65,6 @@ static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
 	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
 }
 
-static bool is_umem_valid(struct xsk_socket_info *xsk)
-{
-	return !!xsk->umem->umem;
-}
-
 static u32 mode_to_xdp_flags(enum test_mode mode)
 {
 	return (mode == TEST_MODE_SKB) ? XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE;
@@ -1010,7 +1005,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			return TEST_FAILURE;
 
 		if (!ret) {
-			if (!is_umem_valid(test->ifobj_tx->xsk))
+			if (test->poll_tmout)
 				return TEST_PASS;
 
 			ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);
@@ -1149,7 +1144,7 @@ static int receive_pkts(struct test_spec *test)
 			break;
 
 		res = __receive_pkts(test, xsk);
-		if (!(res == TEST_PASS || res == TEST_CONTINUE))
+		if (res != TEST_CONTINUE)
 			return res;
 
 		ret = gettimeofday(&tv_now, NULL);
@@ -1166,7 +1161,8 @@ static int receive_pkts(struct test_spec *test)
 	return TEST_PASS;
 }
 
-static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
+static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
+		       bool test_timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
@@ -1178,7 +1174,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
 	/* pkts_in_flight might be negative if many invalid packets are sent */
 	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
-	    buffer_len)) {
+	    buffer_len) && !test_timeout) {
 		ret = kick_tx(xsk);
 		if (ret)
 			return TEST_FAILURE;
@@ -1191,7 +1187,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	while (xsk_ring_prod__reserve(&xsk->tx, xsk->batch_size, &idx) < xsk->batch_size) {
 		if (use_poll) {
 			ret = poll(&fds, 1, POLL_TMOUT);
-			if (timeout) {
+			if (test_timeout) {
 				if (ret < 0) {
 					ksft_print_msg("ERROR: [%s] Poll error %d\n",
 						       __func__, errno);
@@ -1271,7 +1267,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	if (use_poll) {
 		ret = poll(&fds, 1, POLL_TMOUT);
 		if (ret <= 0) {
-			if (ret == 0 && timeout)
+			if (ret == 0 && test_timeout)
 				return TEST_PASS;
 
 			ksft_print_msg("ERROR: [%s] Poll error %d\n", __func__, ret);
@@ -1279,14 +1275,14 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 		}
 	}
 
-	if (!timeout) {
+	if (!test_timeout) {
 		if (complete_pkts(xsk, i))
 			return TEST_FAILURE;
 
 		usleep(10);
-		return TEST_PASS;
 	}
 
+	/* Loop completion is driven by send_pkts() stream progress checks. */
 	return TEST_CONTINUE;
 }
 
@@ -1322,7 +1318,6 @@ bool all_packets_sent(struct test_spec *test, unsigned long *bitmap)
 
 static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 {
-	bool timeout = !is_umem_valid(test->ifobj_rx->xsk);
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	u32 i, ret;
 
@@ -1337,19 +1332,18 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 				__set_bit(i, bitmap);
 				continue;
 			}
-			ret = __send_pkts(ifobject, &ifobject->xsk_arr[i], timeout);
-			if (ret == TEST_CONTINUE && !test->fail)
-				continue;
-
-			if ((ret || test->fail) && !timeout)
-				return TEST_FAILURE;
-
-			if (ret == TEST_PASS && timeout)
+			ret = __send_pkts(ifobject, &ifobject->xsk_arr[i], test->poll_tmout);
+			if (ret != TEST_CONTINUE)
 				return ret;
 
-			ret = wait_for_tx_completion(&ifobject->xsk_arr[i]);
-			if (ret)
+			if (test->fail)
 				return TEST_FAILURE;
+
+			if (!test->poll_tmout) {
+				ret = wait_for_tx_completion(&ifobject->xsk_arr[i]);
+				if (ret)
+					return TEST_FAILURE;
+			}
 		}
 	}
 
@@ -2231,6 +2225,7 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 
 int testapp_poll_txq_tmout(struct test_spec *test)
 {
+	test->poll_tmout = true;
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
 	test->ifobj_tx->xsk->umem->frame_size = 2048;
@@ -2241,6 +2236,7 @@ int testapp_poll_txq_tmout(struct test_spec *test)
 
 int testapp_poll_rxq_tmout(struct test_spec *test)
 {
+	test->poll_tmout = true;
 	test->ifobj_rx->use_poll = true;
 	return testapp_validate_traffic_single_thread(test, test->ifobj_rx);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 4313d0d87235..20eaaa254998 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -207,6 +207,7 @@ struct test_spec {
 	bool set_ring;
 	bool adjust_tail;
 	bool adjust_tail_support;
+	bool poll_tmout;
 	enum test_mode mode;
 	char name[MAX_TEST_NAME_SIZE];
 };
-- 
2.43.0


