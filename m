Return-Path: <netdev+bounces-236028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8DC37EA9
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B44E999C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C861359FB8;
	Wed,  5 Nov 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYDrdItW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C235028C
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376841; cv=none; b=XFITy4aC3oCAjsoBy1jRHuE57usS4KYE6mdi6dD9q3GJDzZpQ/k/24+me0bA0LH0W2IalNv0vN6Clb+z1LyZotLA2E7n1kzq00wKhvINlTy3cJDd2PZuM0NJ/Vwq8jk8AM3poMk2EjuTvVkyjHvgGTag3c/7GIj7vWg77mIq2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376841; c=relaxed/simple;
	bh=C7Ub1lQiPkE76ZdA+gKucj8P3cMmzoBNp+zDOI78nro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LV+EqwavMiGbZd/RnKQ8dSAIXCnlNJZPCpFI7P0wx3cRQ0tDAvXTqgpc6tI2X12TIoWHNJ5yu7uLJvPHH0ym9rj278ffbktb9UP9mF+IWe/cbdgvdAuVWgBCGbj+X/TNyZoTjuIowWa5+R0mbG+JwVejbCVgIsQuNc+3TRS5E+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYDrdItW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762376839; x=1793912839;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=C7Ub1lQiPkE76ZdA+gKucj8P3cMmzoBNp+zDOI78nro=;
  b=WYDrdItWGdzkO41TRLztdzQrEpy0tCZcb9SO3INyyI4P9dFWHF7AU6kG
   SIn2+F/6SRxWqVxq93WdjkE/apklNc6CPi1q/Vk39DEEefwUlnPrj00ga
   IYH2OIXsJuWanyfAKsIwsW62kLG5SDbHTKmF9lD1+EKBtpx4kb9eV4nDj
   GrNCfvh30I3+aYWwJKJseQDYzTLu9v3dALB6vePZ9icLUpcRu83qf65Kz
   j8AANYCVjSGb8CbEltK6bZSwPb8EAJCKghlP7x+0RtjJMyLuL6nsYyUfZ
   RVgTGEjR5Ql+3G0CMgtI6YAFvIFQ1UhinjZzQQVmB2OSeG6BVMCcy+qFp
   w==;
X-CSE-ConnectionGUID: B0e+6v2xSiKRoQaZfpfcGg==
X-CSE-MsgGUID: qmQ6mY2PRkeSfoIFvpdVhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64201031"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64201031"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
X-CSE-ConnectionGUID: 20Il3zpjRIySqyuhQBHkfA==
X-CSE-MsgGUID: QIgSlvcCQj+KB8/gcR0mcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187513287"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Nov 2025 13:06:35 -0800
Subject: [PATCH iwl-next v2 3/9] ice: use cacheline groups for ice_tx_ring
 structure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-jk-refactor-queue-stats-v2-3-8652557f9572@intel.com>
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
In-Reply-To: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=6516;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=C7Ub1lQiPkE76ZdA+gKucj8P3cMmzoBNp+zDOI78nro=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzuPXXqYSdCOYtvPKq+zKgyq+XNj+d7kh8JMb332bTO6
 rT/u/qnHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzkeycjw/P6p905tjezjQPs
 9q+f8cR3YdnzOeunOXkwrTVf2eC+5C4jQ4+czN2YPZ8aP1aaXjfP6XX0DZkvJbzGRCdJ57CRwKl
 sRgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice ring structure was reorganized by commit 65124bbf980c ("ice:
Reorganize tx_buf and ring structs"), and later split into a separate
ice_tx_ring structure by commit e72bba21355d ("ice: split ice_ring onto
Tx/Rx separate structs").

The ice_tx_ring structure has comments left over from this reorganization
and split indicating which fields are supposed to belong to which
cachelines. Unfortunately, these comments are almost completely incorrect.

 * Cacheline 1 spans from the start of the structure to the vsi pointer.
   This cacheline is correct, and appears to be the only one that is.

 * Cacheline 2 spans from the DMA address down to the xps_state field. The
   comments indicate it should end at the rcu head field.

 * Cacheline 3 spans from the ice_channel pointer to the end of the struct,
   and completely contains what is marked as a separate 4th cacheline.

The use of such comments to indicate cache lines is error prone. It is
extremely likely that the comments will become out of date with future
refactors. Instead, use __cacheline_group_(begin|end)_aligned() which is
more explicit. It guarantees that members between the cacheline groups will
be in distinct cache lines through the use of padding. It additionally
enables compile time assertions to help prevent new fields from drastically
re-arranging the cache lines.

There are two main issues if we just replace the existing comments with
cache line group markers. First, the spinlock_t tx_lock field is 24 bytes
on most kernels, but is 64 bytes on CONFIG_DEBUG_LOCK_ALLOC kernels.
Ideally we want to place this field at the start of a cacheline so that
other fields in the group don't get split across such a debug kernel. While
optimizing such a debug kernel is not a priority, doing this makes the
assertions around the cacheline a bit easier to understand.

Remove the out-of-date cacheline comments, and add __cacheline_group
annotations. These are set to match the existing layout instead of matching
the original comments. The only change to layout is to re-order the tx_lock
to be the start of cacheline 3, and move txq_teid to avoid a 4-byte gap in
the layout.

Ideally, we should profile the Tx hot path and figure out which fields go
together and re-arrange the cacheline groups, possibly along "read_mostly",
"readwrite" and "cold" groupings similar to the idpf driver. This has been
left as an exercise for a later improvement.

Finally, add annotations which check the cacheline sizes. For cacheline 3,
we enforce that tx_lock is in this cacheline group, and check the size
based on whether or not the CONFIG_DEBUG_LOCK_ALLOC is enabled. Similar to
the Rx annotations, these check that the size of each cacheline group
(excluding padding) is no greater than 64 bytes. This is primarily intended
to produce compiler failures if developers add or re-arrange fields such
that cacheline groups exceed the expected 64 byte sizes on x86_64 systems.
Because the assertions check the size excluding any padding, they should
behave the same even on systems with larger L1 cacheline sizes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.h | 32 +++++++++++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c |  1 +
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 6c708caf3a91..5350eb832ee5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -319,7 +319,7 @@ static inline void ice_rx_ring_struct_check(void)
 }
 
 struct ice_tx_ring {
-	/* CL1 - 1st cacheline starts here */
+	__cacheline_group_begin_aligned(cl1);
 	struct ice_tx_ring *next;	/* pointer to next ring in q_vector */
 	void *desc;			/* Descriptor ring memory */
 	struct device *dev;		/* Used for DMA mapping */
@@ -328,7 +328,9 @@ struct ice_tx_ring {
 	struct ice_q_vector *q_vector;	/* Backreference to associated vector */
 	struct net_device *netdev;	/* netdev ring maps to */
 	struct ice_vsi *vsi;		/* Backreference to associated VSI */
-	/* CL2 - 2nd cacheline starts here */
+	__cacheline_group_end_aligned(cl1);
+
+	__cacheline_group_begin_aligned(cl2);
 	dma_addr_t dma;			/* physical address of ring */
 	struct xsk_buff_pool *xsk_pool;
 	u16 next_to_use;
@@ -340,15 +342,18 @@ struct ice_tx_ring {
 	u16 xdp_tx_active;
 	/* stats structs */
 	struct ice_ring_stats *ring_stats;
-	/* CL3 - 3rd cacheline starts here */
 	struct rcu_head rcu;		/* to avoid race on free */
 	DECLARE_BITMAP(xps_state, ICE_TX_NBITS);	/* XPS Config State */
+	__cacheline_group_end_aligned(cl2);
+
+	__cacheline_group_begin_aligned(cl3);
+	spinlock_t tx_lock;
 	struct ice_channel *ch;
 	struct ice_ptp_tx *tx_tstamps;
-	spinlock_t tx_lock;
-	u32 txq_teid;			/* Added Tx queue TEID */
-	/* CL4 - 4th cacheline starts here */
 	struct ice_tstamp_ring *tstamp_ring;
+
+	u32 txq_teid;			/* Added Tx queue TEID */
+
 #define ICE_TX_FLAGS_RING_XDP		BIT(0)
 #define ICE_TX_FLAGS_RING_VLAN_L2TAG1	BIT(1)
 #define ICE_TX_FLAGS_RING_VLAN_L2TAG2	BIT(2)
@@ -356,8 +361,23 @@ struct ice_tx_ring {
 	u8 flags;
 	u8 dcb_tc;			/* Traffic class of ring */
 	u16 quanta_prof_id;
+	__cacheline_group_end_aligned(cl3);
 } ____cacheline_internodealigned_in_smp;
 
+static inline void ice_tx_ring_struct_check(void)
+{
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_tx_ring, cl1, 64);
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_tx_ring, cl2, 64);
+
+	CACHELINE_ASSERT_GROUP_MEMBER(struct ice_tx_ring, cl3, tx_lock);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/* spinlock_t is larger on DEBUG_LOCK_ALLOC kernels */
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_tx_ring, cl3, 128);
+#else
+	CACHELINE_ASSERT_GROUP_SIZE(struct ice_tx_ring, cl3, 64);
+#endif
+}
+
 static inline bool ice_ring_ch_enabled(struct ice_tx_ring *ring)
 {
 	return !!ring->ch;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4731dbaca9de..645a2113e8aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5917,6 +5917,7 @@ static int __init ice_module_init(void)
 	int status = -ENOMEM;
 
 	ice_rx_ring_struct_check();
+	ice_tx_ring_struct_check();
 
 	pr_info("%s\n", ice_driver_string);
 	pr_info("%s\n", ice_copyright);

-- 
2.51.0.rc1.197.g6d975e95c9d7


