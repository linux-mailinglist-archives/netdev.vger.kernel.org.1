Return-Path: <netdev+bounces-158940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1234A13DE7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFB93A7750
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E6A22BACD;
	Thu, 16 Jan 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LO1UeVLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975C22A809
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041962; cv=none; b=eCr3GAU4fX+8HJ7Lyrw9EoRoK601fjBmoqvA9LabpsAZRKaXLT7jPIltZMbgGSLDQnj/j8dyd0mzOllyqSCcNBa4HD46Vwk5Uu9hx2/QfhFEKhMF1LXuK9cA9fER/pYwSFdPlAy2s6Mr6duX7XmNBR9mlQXo2nJa1x2p3db1l54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041962; c=relaxed/simple;
	bh=WrbUpuz6ujfppYsbwvlPMcmybHJlQGyYOtgXdzBiihA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYC3AYjzzf3EMfAoerRDV9/Rlyt+28PbZ/950k3BJWbJUloEKabfCulDlmQDugeEzdT9EqNwFB5OKZPnIofDuaaat500cgmNZI9CkbzUvKFADdcdyl5dRDhTPk1AbPplBJR0+nvyohZb3SUHS0+pR07aGp4KyOr9mOdvpFZK/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LO1UeVLQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737041961; x=1768577961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WrbUpuz6ujfppYsbwvlPMcmybHJlQGyYOtgXdzBiihA=;
  b=LO1UeVLQ/9RW9X3GEDVgqHLj4Pui+B3cNrVdc5qsxTxN/pFl6Cv/PNJv
   0TsaCYdVp6EfR0xTiw582WyB0/Zr8mm12VSdaCbx+B+Zs+MEc5K5KNZOm
   N/Z82d6LcBU8de5damPMu/PksjnXp39jHrWOE3V2caDUIittW1wFUs4ET
   C7Su/tb4xS078rXko5Jy4nLeaHplMMETSxk80fRk1CjbPbzy6Ovs1fTWA
   UsTvzwFsxSR000mA+MW37qpMGLO5GkorSF9vD6K7SzI0zBeGBCZj4OCfg
   2LougIOeTVJybSRMAe8obzroNxBG34PORnb+lrjLGr67ltAv8zd/8To32
   A==;
X-CSE-ConnectionGUID: lQDACXzFSA+5CZklc+SxjA==
X-CSE-MsgGUID: 8GlaD/JET/+w7SNeFU0myA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="25037432"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="25037432"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:39:21 -0800
X-CSE-ConnectionGUID: vQ3O71RURhq5GVM5TYhZrA==
X-CSE-MsgGUID: 8OFewnjoRgi82AjqtGLUDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="110541001"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 16 Jan 2025 07:39:18 -0800
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH intel-net 2/3] ice: gather page_count()'s of each frag right before XDP prog call
Date: Thu, 16 Jan 2025 16:39:07 +0100
Message-Id: <20250116153908.515848-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250116153908.515848-1-maciej.fijalkowski@intel.com>
References: <20250116153908.515848-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel networking drivers have a page recycling scheme that is nicely
explained by Bjorn Topel in commit 75aab4e10ae6 ("i40e: avoid premature
Rx buffer reuse"). Please refer to it for better understanding what is
described below.

If we store the page count on a bunch of fragments while being in the
middle of gathering the whole frame and we stumbled upon DD bit not
being set, we terminate the NAPI Rx processing loop and come back later
on. Then, on next NAPI execution, the page recycling algorithm will work
on previously stored refcount of underlying page.

Imagine that second half of page was used actively by networking stack
and by the time we came back, stack is not busy with this page anymore
and decremented the refcount. The page reuse logic in this case should
be good to reuse the page but given the old refcount it will not do so
and attempt to release the page via page_frag_cache_drain() with
pagecnt_bias used as an arg. This in turn will result in negative
refcount on struct page, which was initially observed by Xu Du.

Therefore to fix this, move the page count storage from ice_get_rx_buf()
to a place where we are sure that whole frame has been collected and
processing of this frame will happen under current NAPI instance, but
before calling XDP program as it internally can also change the page
count of fragments belonging to xdp_buff.

Fixes: ac0753391195 ("ice: Store page count inside ice_rx_buf")
Reported-and-tested-by: Xu Du <xudu@redhat.com>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 501df1bc881d..7cd07e757d3c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -924,7 +924,6 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	struct ice_rx_buf *rx_buf;
 
 	rx_buf = &rx_ring->rx_buf[ntc];
-	rx_buf->pgcnt = page_count(rx_buf->page);
 	prefetchw(rx_buf->page);
 
 	if (!size)
@@ -940,6 +939,22 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	return rx_buf;
 }
 
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
@@ -1229,6 +1244,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc))
 			continue;
 
+		ice_get_pgcnts(rx_ring);
 		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
 		if (rx_buf->act == ICE_XDP_PASS)
 			goto construct_skb;
-- 
2.43.0


