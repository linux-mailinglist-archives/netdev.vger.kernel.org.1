Return-Path: <netdev+bounces-139269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2669B13B9
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 02:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A322EB20FB1
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6AF39FE5;
	Sat, 26 Oct 2024 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZL+o55vq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E11225D9;
	Sat, 26 Oct 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901163; cv=none; b=gIQ/2tMjALGNi6Ycwc9KItzlxGTeZUilSItP6IPKueI6ATRzmrnq3ju0farUIhLbm6xhkrzOgRm1eDkPUK3khkJJrea0VOioC/IK+N4tQDonJCR4Y0nqjDaD1JvpIT4b1BKRiVg15nL1snjrypjk1UcnGri0Nwspu/w52C7mdQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901163; c=relaxed/simple;
	bh=BFnklFEAbyIwseRh4bQcIzlgNjuk1kCD0uYV46V8s1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbGU9LOgL45ytb1sfxHc6Kga+GqQecc3uJ90jbOV+gozHnLM3pufMcnynbS+9F1zvVvkXCCIdGhGy0MwWaj5RXIo1vfpiMi/lO0vAZ2nj5sEWSeWWVDeamw+SwdB8QGRrD1M1f9PheHa+CNF3BwRRi34RUDc3w7oAfXXTcpvYew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZL+o55vq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729901161; x=1761437161;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BFnklFEAbyIwseRh4bQcIzlgNjuk1kCD0uYV46V8s1g=;
  b=ZL+o55vq0M7D7q1H9+CMPQd3rs0XplThJATvdCrnhLMd0eVo7xWAEvaM
   W/MVS5ibkk+AlcnUKsP2HXfgyn52ZG7cXcukSpThIhE+33T6Lcj3OFXA4
   M1TGWShc6F+Ev20I81a6bMEGE2hi8L67UhDnmrrlyahlhS+UuiwVpr9qp
   eFD73jRB07AYsj2Fe93jW8XgDg8Jc6p6HZ2skYEg7WvQZ73x6xv0FntGn
   aKwcGJrLs4wxZfRb8j2DW/t7fTETqSQ1k4Jq790zsRXWN8uJN0q6Qz/8G
   cykxijHNDpz8x/5as8uxfUgOLmSRmsq8fR5YKniGhNn6Z3bAPLIu+b7v9
   w==;
X-CSE-ConnectionGUID: 4V0z8gVpQdSN6VR8exTTfg==
X-CSE-MsgGUID: KzezKAWlR7CAXANx4k3kKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40959161"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40959161"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:54 -0700
X-CSE-ConnectionGUID: 126rWWuTQPKnLrpoxLBuWw==
X-CSE-MsgGUID: 1PgQUizVSHSTTEJXVGjeJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="104386861"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:55 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Oct 2024 17:05:00 -0700
Subject: [PATCH net-next v2 8/9] ice: move prefetch enable to
 ice_setup_rx_ctx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-packing-pack-fields-and-ice-implementation-v2-8-734776c88e40@intel.com>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
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
index 0a325dec804e..f1fbba19e4e4 100644
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
index 905f5c745a7b..3cc56b85a480 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1433,14 +1433,13 @@ static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
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
@@ -1450,8 +1449,6 @@ int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 	if (!rlan_ctx)
 		return -EINVAL;
 
-	rlan_ctx->prefena = 1;
-
 	ice_pack_rxq_ctx(rlan_ctx, &buf);
 
 	return ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);

-- 
2.47.0.265.g4ca455297942


