Return-Path: <netdev+bounces-122930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1B596333A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF211F25504
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55A1AC45C;
	Wed, 28 Aug 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOj49pmB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60191AC8AF
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878656; cv=none; b=GitxqnOCzvYZFK217w2nrHY61jpVh4vcbgRtn51QdsDPq4IV1I0ibc6r0PLALHrBBjxTZfamKTVX0wHeFQer7MeAKSqutomVuZbt5YO+X8u4Xnet0fh/fSeldtPN9A794vEIVLcCILkOpqtuXQci2PbWEeGHsaj+eqoQ2q/qkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878656; c=relaxed/simple;
	bh=3StCIl9iRUheph9NqthsyQu4RQhBny1GfUuc1Bjb8QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEI4pYu46KhHmRFn3RSw+hob2jwzabOlc2PMONRbFsFzRFG/Ct9+Xvc65F75oO5QquKkLgHY/f2pNiYOsvIPGlP6Xp0mEQTYl6qs5OoZ3i0BVqTDvfeFFrZV3dvFh/2bXc+k64GIpdqlOuE3Gdk0De8fNi9nElGvag8l48qlgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOj49pmB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724878655; x=1756414655;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3StCIl9iRUheph9NqthsyQu4RQhBny1GfUuc1Bjb8QE=;
  b=WOj49pmBdkD3GIMnY8iqsjYfnJCI4LgnG2tQ3lBGlKF2lDAgaNRkvLvm
   NAJAWyz4A34Mx88lfHlhcl9KUz2FbZirwi/dfiI3KyphrYzZOvoXQf3Ut
   TQKO6Dgz863HH3VeG83DRAA3M84OKdp5afVkajWIxZ3i/iwkfm/lBqVAa
   dIqInQ3QK92mzMn9ZwwMt1QkUMAAzI2p2+lvs0aC0aGEXl/gmL5SsL+Zw
   tXnX2goUr0zITyu6eG5cDv1zJeFpLaLMVxwm9T/GA9beQHH836dEGCUdE
   MU8TtlNe0cxs+L4gnjVZSZW7rpqhgG7wc7licSzt9f/abbCSAHM6nmRB8
   Q==;
X-CSE-ConnectionGUID: PoROD12CQLeYNx6dDsCcFQ==
X-CSE-MsgGUID: qLA84ftxQY2+mOMbahtAAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34592619"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34592619"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:31 -0700
X-CSE-ConnectionGUID: g9HeQsFDQxiJTxbxMiycZg==
X-CSE-MsgGUID: rCeAd+JRTSySexEXV26jFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="64049992"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 28 Aug 2024 13:57:28 -0700
Subject: [PATCH iwl-next v2 12/13] ice: move prefetch enable to
 ice_setup_rx_ctx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-12-558ab9e240f5@intel.com>
References: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
In-Reply-To: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.0

The ice_write_rxq_ctx() function is responsible for programming the Rx
Queue context into hardware. It receives the configuration in unpacked form
via the ice_rlan_ctx structure.

This function unconditionally modifies the context to set the prefetch
enable bit. This was done by commit c31a5c25bb19 ("ice: Always set prefena
when configuring an Rx queue"). Setting this bit makes sense, since
prefetching descriptors is almost always the preferred behavior.

However, the ice_write_rxq_ctx() function is not the place that actually
defines the queue context. We initialize the Rx Queue context in
ice_setup_rx_ctx(). It is surprising to have the Rx queue context changed
by a function who's responsibility is to program the given context to
hardware.

Following the principle of least surprise, move the setting of the prefetch
enable bit out of ice_write_rxq_ctx() and into the ice_setup_rx_ctx().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c   | 3 +++
 drivers/net/ethernet/intel/ice/ice_common.c | 9 +++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1881ce8105ca..3fe87a30c29e 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -453,6 +453,9 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Rx queue threshold in units of 64 */
 	rlan_ctx.lrxqthresh = 1;
 
+	/* Enable descriptor prefetch */
+	rlan_ctx.prefena = 1;
+
 	/* PF acts as uplink for switchdev; set flex descriptor with src_vsi
 	 * metadata and flags to allow redirecting to PR netdev
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 09a94c20e16d..67273e4af7ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1495,14 +1495,13 @@ const struct ice_ctx_ele ice_rlan_ctx_info[] = {
 };
 
 /**
- * ice_write_rxq_ctx
+ * ice_write_rxq_ctx - Write Rx Queue context to hardware
  * @hw: pointer to the hardware structure
  * @rlan_ctx: pointer to the rxq context
  * @rxq_index: the index of the Rx queue
  *
- * Converts rxq context from sparse to dense structure and then writes
- * it to HW register space and enables the hardware to prefetch descriptors
- * instead of only fetching them on demand
+ * Pack the sparse Rx Queue context into dense hardware format and write it
+ * into the HW register space.
  */
 int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		      u32 rxq_index)
@@ -1512,8 +1511,6 @@ int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 	if (!rlan_ctx)
 		return -EINVAL;
 
-	rlan_ctx->prefena = 1;
-
 	ice_pack_rxq_ctx(rlan_ctx, ctx_buf);
 
 	return ice_copy_rxq_ctx_to_hw(hw, ctx_buf, rxq_index);

-- 
2.46.0.124.g2dc1a81c8933


