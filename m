Return-Path: <netdev+bounces-134667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EAE99AB87
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E441F23426
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A41D0799;
	Fri, 11 Oct 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzfdhMQR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD561D07A2;
	Fri, 11 Oct 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672611; cv=none; b=o311eIH9X4fWNVU+Gh2X3Rh++MoSv9qVzJvSmldFfwkVUoKma/9P9321JpSCczbK7uXWrB0ku6Uz01n7yV7FJEw6JGQxpY6FL2gEg7iV3HETTRm0C3WaEQi1ozKkXFDQHyv0xwSLqzL0qzNMmkHLH5gPSbrE+OICBHdVDJK5kKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672611; c=relaxed/simple;
	bh=h0E/fVSvAhcSsbuHu7qeR6WBLpGgBonSHWlsTUDSNGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbLdojbd2dI0GjgppCD9nSPcTqE9LtLYEOMfEOqrevBacih9CNA5irSyQi7te8BOGi9baeC3Hw8CmiH7nFqNKaZyGVlIXMnZpzpIKh6JmgFe4siSQ6q4dTtDyaQjv6z3TwJo591gw8Jtd9WzgyBjSgQKUr6MI9ohuHdwPX14Rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzfdhMQR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728672610; x=1760208610;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=h0E/fVSvAhcSsbuHu7qeR6WBLpGgBonSHWlsTUDSNGk=;
  b=bzfdhMQRnfcB2Bn9yE+2c57zj3N/oBUVreZtGKXQcmr7/bZWDBCDLhm9
   ZxkZpiKwUi0iMoHBjAIJInGE5ag8D5TonHL4Xs+31I3EDQ2fduC7M+9vo
   c5xFVWietBJhxgWZGLBh4y0GqJTLkL7kOIwTCI/LR9tFggwrvF/8s+9FZ
   WXPNk+h2chLA1EKcCUErdOHsrb9FRvB+jRwEYqNSPWZG9DSwx4garXEUi
   41PLWNFgb7Lh9uR5WCZcb62oHz3qrDUe6uvhccj7CP/+rUprT+cZfc2RV
   vSNwjuY9WT7KUuqpzykOdNVDl4s9GDeyJLko6aqoyMzLKobqDeJDcZDXV
   Q==;
X-CSE-ConnectionGUID: monAkVBoQkuOc7AUssDJuQ==
X-CSE-MsgGUID: /87WIp9LQZSk6xEQs0xHHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50626182"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="50626182"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:07 -0700
X-CSE-ConnectionGUID: CrCiY9CmTjWbvKLZWfY7nQ==
X-CSE-MsgGUID: U+9VwytXTQyn06omZKOvGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77804166"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Oct 2024 11:48:35 -0700
Subject: [PATCH net-next 7/8] ice: move prefetch enable to ice_setup_rx_ctx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-packing-pack-fields-and-ice-implementation-v1-7-d9b1f7500740@intel.com>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
In-Reply-To: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1

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
index 9fb7761bad57..c9b2170a3f5c 100644
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
index 87db31b57c50..67e5f8729dc4 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1435,14 +1435,13 @@ void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len)
 }
 
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
@@ -1452,8 +1451,6 @@ int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 	if (!rlan_ctx)
 		return -EINVAL;
 
-	rlan_ctx->prefena = 1;
-
 	ice_pack_rxq_ctx(rlan_ctx, ctx_buf);
 
 	return ice_copy_rxq_ctx_to_hw(hw, ctx_buf, rxq_index);

-- 
2.47.0.265.g4ca455297942


