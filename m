Return-Path: <netdev+bounces-271998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIVjG8MexWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:55:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10119334C50
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FC3630929E1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294173FBEB0;
	Thu, 26 Mar 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HChDtBbN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7143FB7FD;
	Thu, 26 Mar 2026 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525802; cv=none; b=SX2KPb/9BlqCpZ/yZRpFoRB1iN/9Zn6A3FQRRxHwrPD272Ojl6LM1SUzmdraYIltnjoSZsNyU/eoDoxDCCRPC7G4JD1DdwigkmZ90Bo2e/3VX+Vk4/8PJDa3E0lhMHr58OXYaitdO2Afqf0HepoIEIP52ZL3lRXtxUHXvicEyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525802; c=relaxed/simple;
	bh=J57BK9sBNCaQf7KgZJxvzeutVaG94MCuRhfmbZmW3+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMc7mwskAOA+rZ0Ky95up4zWCHPV2q7lKOTtL8HcQ1qm8GULJOO47JQ/jgPK38rOw/Jke9wj83UWzrxe5wzc3q9eN1SVVpYCKHuo5UgzjIaHapr7urwJW3l4JwfRehSj0zFkLf7oRIObY4m+yLKZBfwKNaGVPMzo4TBULM/7+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HChDtBbN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525792; x=1806061792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J57BK9sBNCaQf7KgZJxvzeutVaG94MCuRhfmbZmW3+E=;
  b=HChDtBbNRYjRBLxnCJWofi32R7/Bqn5kaUAGBfNqsr1e7ex2Ru6ELd/D
   WTwfnWUdi4wiYmf0xNJumrGYXfc2IxdUDJZuRh1tHLBX4L+c2CXWhZGdW
   3X4J6jNfWtWFj22AS3SdAdTtsCLwjvd1MZq8ugkGV0if+rzrbyrSGIJza
   0ZF6xvINwu0hqOpt9RIBGZXp/V+fO5RzboObZa0zGFmkjvrf0UN4SxXPU
   w0FO1OHgbTMr/o2yr8FaGHbJvDeIe1Kj84DTIKKwUahdDKwJOgE7zYdOC
   oLvgLVuylTnHZFDsIm/rdErq2Bsa7zHIHt+5ZU0xoGb4DA3tHHS2Z6AdH
   g==;
X-CSE-ConnectionGUID: KMZvcXiCTyqVgZqbaBUCFQ==
X-CSE-MsgGUID: suqYndxjQCKk8m1Dv4f+2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776263"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776263"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:47 -0700
X-CSE-ConnectionGUID: GLRUNFYwQ1WMWYj3Hc9DQw==
X-CSE-MsgGUID: pfhe3qLbQG6Vx7KYfKx/0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029061"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:44 -0700
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
Subject: [PATCH v4 net 06/11] selftests: bpf: fix pkt grow tests
Date: Thu, 26 Mar 2026 12:49:14 +0100
Message-Id: <20260326114919.519456-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271998-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 10119334C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip tail adjust tests in xskxceiver for SKB mode as it is not very
friendly for it. multi-buffer case does not work as xdp_rxq_info that is
registered for generic XDP does not report ::frag_size. The non-mbuf
path copies packet via skb_pp_cow_data() which only accounts for
headroom, leaving us with no tailroom and causing underlying XDP prog to
drop packets therefore.

For multi-buffer test on other modes, change the amount of bytes we use
for growth, assume worst-case scenario and take care of headroom and
tailroom.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 62118ffba661..ee60bcc22ee4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2528,16 +2528,34 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
 
 int testapp_adjust_tail_grow(struct test_spec *test)
 {
+	if (test->mode == TEST_MODE_SKB)
+		return TEST_SKIP;
+
 	/* Grow by 4 bytes for testing purpose */
 	return testapp_adjust_tail(test, 4, MIN_PKT_SIZE * 2);
 }
 
 int testapp_adjust_tail_grow_mb(struct test_spec *test)
 {
+	u32 grow_size;
+
+	if (test->mode == TEST_MODE_SKB)
+		return TEST_SKIP;
+
+	/* worst case scenario is when underlying setup will work on 3k
+	 * buffers, let us account for it; given that we will use 6k as
+	 * pkt_len, expect that it will be broken down to 2 descs each
+	 * with 3k payload;
+	 *
+	 * 4k is truesize, 3k payload, 256 HR, 320 TR;
+	 */
+	grow_size = XSK_UMEM__MAX_FRAME_SIZE -
+		    XSK_UMEM__LARGE_FRAME_SIZE -
+		    XDP_PACKET_HEADROOM -
+		    test->ifobj_tx->umem_tailroom;
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	/* Grow by (frag_size - last_frag_Size) - 1 to stay inside the last fragment */
-	return testapp_adjust_tail(test, (XSK_UMEM__MAX_FRAME_SIZE / 2) - 1,
-				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
+
+	return testapp_adjust_tail(test, grow_size, XSK_UMEM__LARGE_FRAME_SIZE * 2);
 }
 
 int testapp_tx_queue_consumer(struct test_spec *test)
-- 
2.43.0


