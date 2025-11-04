Return-Path: <netdev+bounces-235322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002CEC2EB27
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F0B3AC578
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31C2135B8;
	Tue,  4 Nov 2025 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPwx47Td"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A920371E
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218443; cv=none; b=CYFAalXuMndRsXKvcsDNeYMv9hEuaR+YRKxeYVDlrxafgGk+xr66rJkSYN9M30Fq5eHaK/6FZS4NrjDYfx5g9OiKiYjiDq2SpftIqaEoJRhNi0hUpu+gv8vu0hFAIfIx7SuDjNXNi/X3HSjIaGrHSnlabcNBW3U2tl+3pObyM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218443; c=relaxed/simple;
	bh=vYXOfblKU6E/r5YF7kyNk+CDg83/W3BJmW47Puu9Y1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILALLpjxw7nrroesqRLtcB6qWM8dCtdss/Gu/D/+xiRbTA796QlFWddF5D/igZ+7ciztVLzOlUEsbWi7iAEtcXvWkcObE6i2c48UvaTRI2IU+knMKHG+EGZ/Ai7B0t2UmD2olpy2NbEq8Id+siUkCPH1xs7onnIAXIHuceH5yRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPwx47Td; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762218442; x=1793754442;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vYXOfblKU6E/r5YF7kyNk+CDg83/W3BJmW47Puu9Y1c=;
  b=IPwx47TdCrzYZ58YXWAu8zvAOs+Rzm8f34wBV1Cma6vlDq/h+7krG2+n
   5OwDoBT+j0sziZdfBc65PUwBGbaerBXMFX24SjMiGjP5vSUg/0ECFzG6I
   QHf8EU1WR/eJWfce6T+4vZrTLj7MOUdlfiJA/g6WAAJ0ZVMpYv0KD7W4M
   mWbHcQP8P/1d4DPmdFVP0iXnaOIcWCBzZL/QuUyP9NTmcfmGDgfbdzIgb
   zX/XPXecgBsUngo7ORzN3a/t1H8biUOPmE2BVRxpWmgO83U93Pxdn9LmL
   p/AAtCWHhkkYpTN9JlVygx9INsA78F8BiU2OwY3hyn4fm+/T4DBB115Ss
   w==;
X-CSE-ConnectionGUID: Yq+H2qIGQFOIuc3/tdRcRg==
X-CSE-MsgGUID: QOvW7o1eSj6spHvqkOE3hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75656557"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75656557"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:18 -0800
X-CSE-ConnectionGUID: GXMhBiUnToy8XeyMgMBssQ==
X-CSE-MsgGUID: J9Eq+1uwQ8OAuM2MpeaIlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="217828756"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:15 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Nov 2025 17:06:47 -0800
Subject: [PATCH iwl-next 2/9] ice: use cacheline groups for ice_rx_ring
 structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-jk-refactor-queue-stats-v1-2-164d2ed859b6@intel.com>
References: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
In-Reply-To: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=6485;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=vYXOfblKU6E/r5YF7kyNk+CDg83/W3BJmW47Puu9Y1c=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzOwAPd6p0eJbp2/63FnPalH0zb4rF8yWd2/aZHrD3HO
 KZKTZLuKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCL3zjAyvHRwz3HumLnzWXRf
 2PZDlgIqyYvVDsorcfDNLr4hYrP3OyNDq9LFmS46tQ8figseLLkzZWvHykWMxokHpt7aaH0lpCe
 DEQA=
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


