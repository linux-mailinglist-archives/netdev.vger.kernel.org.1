Return-Path: <netdev+bounces-160583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDBA1A673
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637AF3A237A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4E221148D;
	Thu, 23 Jan 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVJdsGgx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88687211715
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644503; cv=none; b=Ttlb7iPki+m5Pb3Pg1vP45EGogRaLUHDX/ocOii6snsQGECicUJ8EUfLn9dhzbB2qeIWuhKFgDm/EZ6+wGXdVx6Fek7Pf5K0prHLXggPjQDa+ZTMw4U9q4LddjlwQQeT52YiEiDO0VMgMHqsUqhZh1dlDvCV2k+ccTrW2mbyeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644503; c=relaxed/simple;
	bh=0JmrU+X7KUzqn1Xng5EfO7ePY6MpG/nVOorayH3A7kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvjE6OdtBW5qGKrWrt+L3WkN46ahk+oSvFcY7mVydzvuNGEAUU4y5d3rDvSEa9m3Z2a3dUnlUxG0E2dVHcqtbcJIZQP2hng4KmWJwJkHztmZK4MeItkN4AaMSh5HS8futC0mqbMny6tPV7HyM2btUAHnzkqPBfXm0xvCbu4/f94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVJdsGgx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737644502; x=1769180502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0JmrU+X7KUzqn1Xng5EfO7ePY6MpG/nVOorayH3A7kU=;
  b=BVJdsGgx75LhFMRqyoUtSw2YD3H6bzGbrE5GL7S//mHnnJzpg6ZzTk+b
   YdNoG4lLu2ME8Lox7b6n+v1TvN1JqN1fibyDm304VppbBBmQDMDyyvL7q
   lpXRbb0qmnYBspl19QOlW/PEL0yBym7MgQ/GQ3wcv7F82KtBjYyUoJ2y4
   +A4JbyBV/UJdoxrBWp51FglvwflxTGO8+6Pwxse60a/xsKxj2Fo9aEk3h
   8J67Jyj2GFTKXT1b8ejPl7u/yAQtA/0FqPAJxTbxvXpaGR4+Y1mm1fr19
   AocXRefSlI06IUbIltlj9WCJvqnsF+iYMl4mNZCI2HFGqAWeqldwDKkK6
   w==;
X-CSE-ConnectionGUID: g6PiqArSTxS7RHI9blvsig==
X-CSE-MsgGUID: Da+W9SRCRn+QYPZPc7D4Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38293545"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="38293545"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:01:42 -0800
X-CSE-ConnectionGUID: u5xS6IPDQWKWU/vdW8SD6Q==
X-CSE-MsgGUID: AshwNMZgRuuZI0aqee1lNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111508972"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jan 2025 07:01:37 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	jacob.e.keller@intel.com,
	xudu@redhat.com,
	mschmidt@redhat.com,
	jmaxwell@redhat.com,
	poros@redhat.com,
	przemyslaw.kitszel@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v5 iwl-net 2/3] ice: gather page_count()'s of each frag right before XDP prog call
Date: Thu, 23 Jan 2025 16:01:17 +0100
Message-Id: <20250123150118.583039-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250123150118.583039-1-maciej.fijalkowski@intel.com>
References: <20250123150118.583039-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we store the pgcnt on few fragments while being in the middle of
gathering the whole frame and we stumbled upon DD bit not being set, we
terminate the NAPI Rx processing loop and come back later on. Then on
next NAPI execution we work on previously stored pgcnt.

Imagine that second half of page was used actively by networking stack
and by the time we came back, stack is not busy with this page anymore
and decremented the refcnt. The page reuse algorithm in this case should
be good to reuse the page but given the old refcnt it will not do so and
attempt to release the page via page_frag_cache_drain() with
pagecnt_bias used as an arg. This in turn will result in negative refcnt
on struct page, which was initially observed by Xu Du.

Therefore, move the page count storage from ice_get_rx_buf() to a place
where we are sure that whole frame has been collected, but before
calling XDP program as it internally can also change the page count of
fragments belonging to xdp_buff.

Fixes: ac0753391195 ("ice: Store page count inside ice_rx_buf")
Reported-and-tested-by: Xu Du <xudu@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index e173d9c98988..cf46bcf143b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -924,7 +924,6 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	struct ice_rx_buf *rx_buf;
 
 	rx_buf = &rx_ring->rx_buf[ntc];
-	rx_buf->pgcnt = page_count(rx_buf->page);
 	prefetchw(rx_buf->page);
 
 	if (!size)
@@ -940,6 +939,31 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	return rx_buf;
 }
 
+/**
+ * ice_get_pgcnts - grab page_count() for gathered fragments
+ * @rx_ring: Rx descriptor ring to store the page counts on
+ *
+ * This function is intended to be called right before running XDP
+ * program so that the page recycling mechanism will be able to take
+ * a correct decision regarding underlying pages; this is done in such
+ * way as XDP program can change the refcount of page
+ */
+static void ice_get_pgcnts(struct ice_rx_ring *rx_ring)
+{
+	u32 nr_frags = rx_ring->nr_frags + 1;
+	u32 idx = rx_ring->first_desc;
+	struct ice_rx_buf *rx_buf;
+	u32 cnt = rx_ring->count;
+
+	for (int i = 0; i < nr_frags; i++) {
+		rx_buf = &rx_ring->rx_buf[idx];
+		rx_buf->pgcnt = page_count(rx_buf->page);
+
+		if (++idx == cnt)
+			idx = 0;
+	}
+}
+
 /**
  * ice_build_skb - Build skb around an existing buffer
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1241,6 +1265,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc))
 			continue;
 
+		ice_get_pgcnts(rx_ring);
 		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
 		if (rx_buf->act == ICE_XDP_PASS)
 			goto construct_skb;
-- 
2.43.0


