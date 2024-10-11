Return-Path: <netdev+bounces-134669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66F99AB8C
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9961F245F0
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0FE1D0E18;
	Fri, 11 Oct 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQ/YWw/X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802771D0B85;
	Fri, 11 Oct 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672613; cv=none; b=eA+rRErLfmEblQ/amwFcBCAFjiG1+Cwn2xSkhfvkOXqeho7bzBl/2BW9spe/JAjrvMrKx7/1QIrMtW8DH1egbrD2avToFObdiqmkahi1lx5hzFYPJoDHo44sXLvDEo6jCjvgvJsuzqycv+sNOOp1xuxl5uaB28PeazLQ1mEY2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672613; c=relaxed/simple;
	bh=d5lJ1hd4SKBBUGBSA1li9aT2ZRuCfpifwu5GtgeDQJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnmPFkvSxGfFoxDWcRniuvLniXvq+2dMOE8Rr9lRjdbmXE5jwHx9CRF0iTKKFgQLxORujKWADBEWFcrXgJ+j3CNil4ecawC4ABdUuDfYLF2YuDHUA5EqSX/7cU2gTI5CUTMm4UzNyt1l0wpvl9okorNHxe3IgJ3TN6kFNmBepO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQ/YWw/X; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728672612; x=1760208612;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=d5lJ1hd4SKBBUGBSA1li9aT2ZRuCfpifwu5GtgeDQJU=;
  b=DQ/YWw/XcUIRnfWEcjnC3X4jx0n2h0Ps1Hdh4w2tgWUdqXo2h7rWUoo9
   ROi+PbsfEEYr6B6doM4h4NMn8H8vs1npHqNO9i29/YBTs7tgu5NML2ZLy
   OQfWCiUKRvAfrRESFaeA9KH3liQoaL9ARXBk1o6iAxl6nJ0NcQqFV7V0c
   SpmWeMcA2l7pbZIyau6N3VgH4nFeqo8a3x5TXbD4e5HCwvC/BzBBlcktT
   FavH6CLFWGenOLyDZ2zPMNUbD7AO3la5bAOSqoSXN8Cj4KHe6ZjrfDvXX
   mD/+sPmc4pQRGCTNa2Gyp8bBuwJI8Tn1L7TXq2DgU3afeXzPvv/5MGdqB
   g==;
X-CSE-ConnectionGUID: P0oMw16aQV2VQ3bXSxLeVQ==
X-CSE-MsgGUID: 4VuT26kXQkOGv1gGmEd7PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50626194"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="50626194"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:07 -0700
X-CSE-ConnectionGUID: ytYJ9ugQQy+zGauIpJNw0w==
X-CSE-MsgGUID: VTGJ+GNySkulBFkE3RXvww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77804168"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Oct 2024 11:48:36 -0700
Subject: [PATCH net-next 8/8] ice: cleanup Rx queue context programming
 functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-packing-pack-fields-and-ice-implementation-v1-8-d9b1f7500740@intel.com>
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

The ice_copy_rxq_ctx_to_hw() and ice_write_rxq_ctx() functions perform some
defensive checks which are typically frowned upon by kernel style
guidelines.

In particular, they perform NULL checks on buffers which are never expected
to be NULL. Both functions are only called once and always have valid
buffers pointing to stack memory. These checks only serve to hide potential
programming error, as we will not produce the normal crash dump on a NULL
access.

In addition, ice_copy_rxq_ctx_to_hw() cannot fail in another way, so could
be made void.

Future support for VF Live Migration will need to introduce an inverse
function for reading Rx queue context from HW registers to unpack it, as
well as functions to pack and unpack Tx queue context from HW.

Rather than copying these style issues into the new functions, lets first
cleanup the existing code.

For the ice_copy_rxq_ctx_to_hw() function:

 * Remove the NULL parameter check.
 * Move the Rx queue index check out of this function.
 * Convert the function to a void return.
 * Use a simple int variable instead of a u8 for the for loop index.
 * Use a local variable and array syntax to access the rxq_ctx.
 * Update the function description to better align with kernel doc style.

For the ice_write_rxq_ctx() function:

 * Use the more common '= {}' syntax for initializing the context buffer.
 * Move the Rx queue index check into this function.
 * Update the function description with a Returns: to align with kernel doc
   style.

These changes align the existing write functions to current kernel
style, and will align with the style of the new functions added when we
implement live migration in a future series.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 42 ++++++++++++-----------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 67e5f8729dc4..e974290f1801 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1358,34 +1358,22 @@ int ice_reset(struct ice_hw *hw, enum ice_reset_req req)
 }
 
 /**
- * ice_copy_rxq_ctx_to_hw
+ * ice_copy_rxq_ctx_to_hw - Copy packed Rx queue context to HW registers
  * @hw: pointer to the hardware structure
- * @ice_rxq_ctx: pointer to the rxq context
+ * @rxq_ctx: pointer to the packed Rx queue context
  * @rxq_index: the index of the Rx queue
- *
- * Copies rxq context from dense structure to HW register space
  */
-static int
-ice_copy_rxq_ctx_to_hw(struct ice_hw *hw, u8 *ice_rxq_ctx, u32 rxq_index)
+static void ice_copy_rxq_ctx_to_hw(struct ice_hw *hw, u8 *rxq_ctx,
+				   u32 rxq_index)
 {
-	u8 i;
-
-	if (!ice_rxq_ctx)
-		return -EINVAL;
-
-	if (rxq_index > QRX_CTRL_MAX_INDEX)
-		return -EINVAL;
-
 	/* Copy each dword separately to HW */
-	for (i = 0; i < ICE_RXQ_CTX_SIZE_DWORDS; i++) {
-		wr32(hw, QRX_CONTEXT(i, rxq_index),
-		     *((u32 *)(ice_rxq_ctx + (i * sizeof(u32)))));
+	for (int i = 0; i < ICE_RXQ_CTX_SIZE_DWORDS; i++) {
+		u32 ctx = ((u32 *)rxq_ctx)[i];
 
-		ice_debug(hw, ICE_DBG_QCTX, "qrxdata[%d]: %08X\n", i,
-			  *((u32 *)(ice_rxq_ctx + (i * sizeof(u32)))));
+		wr32(hw, QRX_CONTEXT(i, rxq_index), ctx);
+
+		ice_debug(hw, ICE_DBG_QCTX, "qrxdata[%d]: %08X\n", i, ctx);
 	}
-
-	return 0;
 }
 
 #define ICE_CTX_STORE(struct_name, struct_field, width, lsb) \
@@ -1437,23 +1425,27 @@ void __ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx, void *buf, size_t len)
 /**
  * ice_write_rxq_ctx - Write Rx Queue context to hardware
  * @hw: pointer to the hardware structure
- * @rlan_ctx: pointer to the rxq context
+ * @rlan_ctx: pointer to the packed Rx queue context
  * @rxq_index: the index of the Rx queue
  *
  * Pack the sparse Rx Queue context into dense hardware format and write it
  * into the HW register space.
+ *
+ * Return: 0 on success, or -EINVAL if the Rx queue index is invalid.
  */
 int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		      u32 rxq_index)
 {
-	u8 ctx_buf[ICE_RXQ_CTX_SZ] = { 0 };
+	u8 ctx_buf[ICE_RXQ_CTX_SZ] = {};
 
-	if (!rlan_ctx)
+	if (rxq_index > QRX_CTRL_MAX_INDEX)
 		return -EINVAL;
 
 	ice_pack_rxq_ctx(rlan_ctx, ctx_buf);
 
-	return ice_copy_rxq_ctx_to_hw(hw, ctx_buf, rxq_index);
+	ice_copy_rxq_ctx_to_hw(hw, ctx_buf, rxq_index);
+
+	return 0;
 }
 
 /* LAN Tx Queue Context */

-- 
2.47.0.265.g4ca455297942


