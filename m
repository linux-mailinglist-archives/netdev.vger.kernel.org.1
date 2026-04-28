Return-Path: <netdev+bounces-281731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IgzGqt48GmiTwEAu9opvQ
	(envelope-from <netdev+bounces-281731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:06:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD0480E9B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20401319B1A7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00B3D5640;
	Tue, 28 Apr 2026 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbYUW3at"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF823D6473;
	Tue, 28 Apr 2026 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365981; cv=none; b=awQ6oYDwufl3bM8NzjBbRnBgW7TvwlS+gadtRVtOZvmm50VNikcdM180vi6S2jMvukavtH+B5EMj73mhY0y/2ZEwOfeIJNhMfwvUH3xpSB8RQHSD7CSOp0sThL0JxYScxqy7ug1EtwuvHQByrhKYYY+DGIWOGxReiJiFg4EBxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365981; c=relaxed/simple;
	bh=PQrHTOGiygm1mkM+sfHvfzzW3mJyvpCupyrZEhirKqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T365A7+OD/b6+jUmkG2zExejWLH29QqXff9zXloMg/V9ACvv9h8AX+A2NsTmq+umecyCWI/MgZXcO1URSA4McFpy1rcntiE+E3Zn9d0JP1AFNAKh2lKAs5JcEd5NX57uWZXMmUQrslobPPrWVOLPG0LVjMLARwvW4KxLZY6nivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbYUW3at; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777365980; x=1808901980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQrHTOGiygm1mkM+sfHvfzzW3mJyvpCupyrZEhirKqY=;
  b=mbYUW3atbvjxW7G4bmD1WuHtUMkdD9HYWXkUMMzljy+0mLpV6uqMFp07
   VK+eXG2ZhV+uDVNmISEzxFi3JglP/k3Z0GOS97VZxUxS/Mzv8sUg1H4jL
   ljKxwW9TXKVwIKD7W+WLdf/hrfG6AWKftDlsBm9vK46MXoseq7ntLVzr8
   BzYiNjrmG2ACCSobEeLjt8fPYA/ra1pWoVImQ+3wLDCLABtS32uQwNlMx
   MerRcN1xcxKqoTvBjgrQyjvk6ejqwQpDDcJOTXNqKbiUrkw36RZxE8J0m
   zG73zMKJxfoz1NOPfvIWsdR9F/Touqt6uYignA/R6SBXwAfm/YND2vPwv
   Q==;
X-CSE-ConnectionGUID: ybXQXsEOTG+CSYJ8eJUdCQ==
X-CSE-MsgGUID: HhFZAVA7RG2GC9oTXEqILg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77433284"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77433284"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:20 -0700
X-CSE-ConnectionGUID: EadI68k4R1mfAhayWo3kWw==
X-CSE-MsgGUID: +rEInIFFRF6ccI9/bMvNlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233027357"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:16 -0700
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
Subject: [PATCH 4/5] selftests/xsk: Use umem_size() helper consistently
Date: Tue, 28 Apr 2026 13:33:15 +0530
Message-ID: <20260428080317.702124-5-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428080317.702124-1-tushar.vyavahare@intel.com>
References: <20260428080317.702124-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CFDD0480E9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Replace remaining open-coded `umem->num_frames * umem->frame_size`
calculations in test_xsk.c with the existing `umem_size()` helper.

This keeps UMEM size computation centralized, avoids duplicated arithmetic,
and improves readability with no intended behavior change.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index ea229ea446ca..ba4768f83eb6 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -828,12 +828,12 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 			  u32 bytes_processed)
 {
 	u32 seqnum, pkt_nb, *pkt_data, words_to_end, expected_seqnum;
+	u64 umem_sz = umem_size(umem);
 	void *data = xsk_umem__get_data(umem->buffer, addr);
 
 	addr -= umem->base_addr;
 
-	if (addr >= umem->num_frames * umem->frame_size ||
-	    addr + len > umem->num_frames * umem->frame_size) {
+	if (addr >= umem_sz || addr + len > umem_sz) {
 		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
 			       (unsigned long long)addr, len);
 		return false;
@@ -1581,7 +1581,7 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	int ret;
 	u32 i;
 
-	umem_sz = umem->num_frames * umem->frame_size;
+	umem_sz = umem_size(umem);
 	mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 
 	if (umem->unaligned_mode)
@@ -1700,7 +1700,7 @@ void *worker_testapp_validate_rx(void *arg)
 static void testapp_clean_xsk_umem(struct ifobject *ifobj)
 {
 	struct xsk_umem_info *umem = ifobj->xsk->umem;
-	u64 umem_sz = umem->num_frames * umem->frame_size;
+	u64 umem_sz = umem_size(umem);
 
 	if (ifobj->shared_umem)
 		umem_sz *= 2;
@@ -2091,7 +2091,7 @@ int testapp_send_receive_mb(struct test_spec *test)
 int testapp_invalid_desc_mb(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
-	u64 umem_size = umem->num_frames * umem->frame_size;
+	u64 umem_sz = umem_size(umem);
 	struct pkt pkts[] = {
 		/* Valid packet for synch to start with */
 		{0, MIN_PKT_SIZE, 0, true, 0},
@@ -2101,7 +2101,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
@@ -2132,7 +2132,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 int testapp_invalid_desc(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
-	u64 umem_size = umem->num_frames * umem->frame_size;
+	u64 umem_sz = umem_size(umem);
 	struct pkt pkts[] = {
 		/* Zero packet address allowed */
 		{0, MIN_PKT_SIZE, 0, true},
@@ -2143,11 +2143,11 @@ int testapp_invalid_desc(struct test_spec *test)
 		/* Packet too large */
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false},
 		/* Up to end of umem allowed */
-		{umem_size - MIN_PKT_SIZE - 2 * umem->frame_size, MIN_PKT_SIZE, 0, true},
+		{umem_sz - MIN_PKT_SIZE - 2 * umem->frame_size, MIN_PKT_SIZE, 0, true},
 		/* After umem ends */
-		{umem_size, MIN_PKT_SIZE, 0, false},
+		{umem_sz, MIN_PKT_SIZE, 0, false},
 		/* Straddle the end of umem */
-		{umem_size - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
+		{umem_sz - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
 		/* Straddle a 4K boundary */
 		{0x1000 - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
 		/* Straddle a 2K boundary */
@@ -2165,9 +2165,9 @@ int testapp_invalid_desc(struct test_spec *test)
 	}
 
 	if (test->ifobj_tx->shared_umem) {
-		pkts[4].offset += umem_size;
-		pkts[5].offset += umem_size;
-		pkts[6].offset += umem_size;
+		pkts[4].offset += umem_sz;
+		pkts[5].offset += umem_sz;
+		pkts[6].offset += umem_sz;
 	}
 
 	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
-- 
2.43.0


