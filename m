Return-Path: <netdev+bounces-236024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006FC37F1F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525551A24552
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D763350283;
	Wed,  5 Nov 2025 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnwgdXMj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002F350282
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376836; cv=none; b=hIrHec41QgoGsZwE18f/zD6vLX/haJ7FUulNaONIcbA4WScmxcTY4X1nZ5CX96tX3zqSjFXxzaLLbZ0Mnbh6BFkfI/OHXvmJ1ibcxtLHYWNQvE9bfQspPOc2o1ja71ldx427a2X1+Xr2lhp5gTFR7fxu5LeLWptR8eauCi17uuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376836; c=relaxed/simple;
	bh=qABfgYXzS+4ObKC7rOBwDd1q59Enwx9YNDXR5XuIlYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUJNoGow1631b/FfjBuPPCR9ZToj5T7ruRqvMTSUrxkTyVS0HEvJSkwn+5YvRrDC7o2t1ZIO0sB1JQ2TizMEJ9vN9+VWcImly+zTdyR6dhJjDZc0LsGk5xa2/q5d9Rzvq2rk0xFppbjFliZlice59SW4VePts1QR3xBkpz7BpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnwgdXMj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762376835; x=1793912835;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qABfgYXzS+4ObKC7rOBwDd1q59Enwx9YNDXR5XuIlYo=;
  b=fnwgdXMjoTbnDPfz2L8aCHfqVbZC/7qdCrkHIVOHuHfr7+TR3YB0hzx0
   ERwMyJJ0EojeZZZ22CFWSS8TeXfI5Nyr1bXf5a2hN9J7NjWeWOXJmwShx
   8nSVgeYTBs2Ae0IwZfFZ+ovsfBlt2uteA1YgZysXon4aspRIUjxCjRHPO
   JjCMsG/a4zylhBu4ulDQUBkg2EpMUWcOba6wrJyV0fXw/alUfvN60abT4
   alIT5DvMConzYmPA5cd4FURDBsowr8CcY/M6K74Hd29g5CkDxKVd2fNcx
   ZvIg6HmRPoahjwNyTwF2JahUQOD9jLjTODZCtXmlYXETpuiv3rbkNUvVP
   Q==;
X-CSE-ConnectionGUID: B0x9njxMTNi0TucA1x4t7g==
X-CSE-MsgGUID: DoqSCjfwTOaeE2mDhVq5Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64201030"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64201030"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
X-CSE-ConnectionGUID: gbRS0wSuRVmFPYS5r5NJfw==
X-CSE-MsgGUID: SdTDSsX0TOiijKRW6LrnrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187513284"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Nov 2025 13:06:34 -0800
Subject: [PATCH iwl-next v2 2/9] ice: use cacheline groups for ice_rx_ring
 structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-jk-refactor-queue-stats-v2-2-8652557f9572@intel.com>
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
In-Reply-To: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=6551;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=qABfgYXzS+4ObKC7rOBwDd1q59Enwx9YNDXR5XuIlYo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzuPXUtIukmm7nytk/zm7lLLGVdfDPz688CooG91/ew/
 Lg4Sze+o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlsns/IsHz3MYNrwbauldcL
 zk54fl55Ye2bG194XrczpDwz7mc/u5iRoftK5Qo2zttb+jU2L1jjekz2d1NI9JELGovTpXe/FBb
 4ygoA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice ring structure was reorganized back by commit 65124bbf980c ("ice:
Reorganize tx_buf and ring structs"), and later split into a separate
ice_rx_ring structure by commit e72bba21355d ("ice: split ice_ring onto
Tx/Rx separate structs")

The ice_rx_ring structure has comments left over from this prior
reorganization indicating which fields belong to which cachelines.
Unfortunately, these comments are not all accurate. The intended layout is
for x86_64 systems with a 64-byte cache.

 * Cacheline 1 spans from the start of the struct to the end of the rx_fqes
   and xdp_buf union. The comments correctly match this.

 * Cacheline 2 spans from hdr_fqes to the end of hdr_truesize, but the
   comment indicates it should end xdp and xsk union.

 * Cacheline 3 spans from the truesize field to the xsk_pool, but the
   comment wants this to be from the pkt_ctx down to the rcu head field.

 * Cacheline 4 spans from the rx_hdr_len down to the flags field, but the
   comment indicates that it starts back at the ice_channel structure
   pointer.

 * Cacheline 5 is indicated to cover the xdp_rxq. Because this field is
   aligned to 64 bytes, this is actually true. However, there is a large 45
   byte gap at the end of cacheline 4.

The use of comments to indicate cachelines is poor design. In practice,
comments like this quickly become outdated as developers add or remove
fields, or as other sub-structures change layout and size unexpectedly.

The ice_rx_ring structure *is* 5 cachelines (320 bytes), but ends up having
quite a lot of empty space at the end just before xdp_rxq.

Replace the comments with __cacheline_group_(begin|end)_aligned()
annotations. These macros enforce alignment to the start of cachelines, and
enforce padding between groups, thus guaranteeing that a following group
cannot be part of the same cacheline.

Doing this changes the layout by effectively spreading the padding at the
tail of cacheline 4 between groups to ensure that the relevant fields are
kept as separate cachelines on x86_64 systems. For systems with the
expected cache line size of 64 bytes, the structure size does not change.
For systems with a larger SMB_CACHE_BYTES size, the structure *will*
increase in size a fair bit, however we'll now guarantee that each group is
in a separate cacheline. This has an advantage that updates to fields in
one group won't trigger cacheline eviction of the other groups. This comes
at the expense of extra memory footprint for the rings.

If fields get re-arranged, added, or removed, the alignment and padding
ensure the relevant fields are kept on separate cache lines. This could
result in unexpected changes in the structure size due to padding to keep
cachelines separate.

To catch such changes during early development, add build time compiler
assertions that check the size of each group to ensure it doesn't exceed 64
bytes, the expected cache line size. The assertion checks that the size of
the group excluding any padding at the end is less than the provided size
of 64 bytes. This type of check will behave the same even on architectures
with larger cache sizes. The primary aim is to produce a warning if
developers add fields into a cacheline group which exceeds the size of the
expected 64 byte groupings.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.h | 26 +++++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_main.c |  2 ++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index e440c55d9e9f..6c708caf3a91 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -236,7 +236,7 @@ struct ice_tstamp_ring {
 } ____cacheline_internodealigned_in_smp;
 
 struct ice_rx_ring {
-	/* CL1 - 1st cacheline starts here */
+	__cacheline_group_begin_aligned(cl1);
 	void *desc;			/* Descriptor ring memory */
 	struct page_pool *pp;
 	struct net_device *netdev;	/* netdev ring maps to */
@@ -253,8 +253,9 @@ struct ice_rx_ring {
 		struct libeth_fqe *rx_fqes;
 		struct xdp_buff **xdp_buf;
 	};
+	__cacheline_group_end_aligned(cl1);
 
-	/* CL2 - 2nd cacheline starts here */
+	__cacheline_group_begin_aligned(cl2);
 	struct libeth_fqe *hdr_fqes;
 	struct page_pool *hdr_pp;
 
@@ -262,8 +263,9 @@ struct ice_rx_ring {
 		struct libeth_xdp_buff_stash xdp;
 		struct libeth_xdp_buff *xsk;
 	};
+	__cacheline_group_end_aligned(cl2);
 
-	/* CL3 - 3rd cacheline starts here */
+	__cacheline_group_begin_aligned(cl3);
 	union {
 		struct ice_pkt_ctx pkt_ctx;
 		struct {
@@ -284,7 +286,9 @@ struct ice_rx_ring {
 	struct ice_ring_stats *ring_stats;
 
 	struct rcu_head rcu;		/* to avoid race on free */
-	/* CL4 - 4th cacheline starts here */
+	__cacheline_group_end_aligned(cl3);
+
+	__cacheline_group_begin_aligned(cl4);
 	struct ice_channel *ch;
 	struct ice_tx_ring *xdp_ring;
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
@@ -298,10 +302,22 @@ struct ice_rx_ring {
 #define ICE_RX_FLAGS_MULTIDEV		BIT(3)
 #define ICE_RX_FLAGS_RING_GCS		BIT(4)
 	u8 flags;
-	/* CL5 - 5th cacheline starts here */
+	__cacheline_group_end_aligned(cl4);
+
+	__cacheline_group_begin_aligned(cl5);
 	struct xdp_rxq_info xdp_rxq;
+	__cacheline_group_end_aligned(cl5);
 } ____cacheline_internodealigned_in_smp;
 
+static inline void ice_rx_ring_struct_check(void)
+{
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl1, 64);
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl2, 64);
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl3, 64);
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl4, 64);
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_rx_ring, cl5, 64);
+}
+
 struct ice_tx_ring {
 	/* CL1 - 1st cacheline starts here */
 	struct ice_tx_ring *next;	/* pointer to next ring in q_vector */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b16ede1f139d..4731dbaca9de 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5916,6 +5916,8 @@ static int __init ice_module_init(void)
 {
 	int status = -ENOMEM;
 
+	ice_rx_ring_struct_check();
+
 	pr_info("%s\n", ice_driver_string);
 	pr_info("%s\n", ice_copyright);
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


