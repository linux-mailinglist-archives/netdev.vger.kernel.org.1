Return-Path: <netdev+bounces-131415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1120098E79C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DB41F25D0C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF2442C;
	Thu,  3 Oct 2024 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKpt1QSv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750E629
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914484; cv=none; b=eTx2lX5dsaZvSYyn9Llpce91DqK8anIvMgIH7RIwStGfaficfO5k91IHypt75DdKL8B0LNTBM+P8mPaz8pcz2lhgaLAQemLukuh04En2QdBnmyPOF+WmwxgChvADM73zWREiJH9wfY6vnDD/7xom2FMnqOYInAaZxd208DmX9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914484; c=relaxed/simple;
	bh=ln+ZgeH6pNm0an/kVEfJYvD6JtZqZIzDW1Rau4/MtGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi1YRJVt0oUgtTFCI8FbtislbQxxU9mKQP9RQuYuPvjLCrhGlmdzkcjamgS8uupZhhm7UHzbRXqDCF9uoq54uCSSqZ3/KYrKoqicdlBp6/GGnBABXCQpap7yBT51MKAl2K8U3dxfh1ZnLF20bAvSEzAswdD/wVSSRuGnvv7nm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKpt1QSv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727914482; x=1759450482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ln+ZgeH6pNm0an/kVEfJYvD6JtZqZIzDW1Rau4/MtGA=;
  b=aKpt1QSvWcc2jnNbM5Jj1nIPy8GQXLMllQacjJlQiHYxBWd5RbEMVN2R
   PPbck0jwwn62b1/+kCKg132jN+Q2hCnV1+sYjhil2M8C8A7ERBD2wL4Sj
   PxUbGhtNe95Gc973WU/SnPLKSoMowqHEs1YQ6w9ePhpFQGkQWaP6OmAfJ
   R1rDIROZ5JLPwvptN7+vr4u6ATSfjpBElOMmqNo2Jao8T+yU6GmRAHOon
   uQSVoto9axtK0vQ3jbb6IrBj/3wBG6Wy/zWTAwClaS4zYUuv+Fn1QJAwH
   k+DpTiuRtnxFPqpS5kOAY19TkDFMhleA2pdm/9pF1DjuykjYzsEApOrD2
   Q==;
X-CSE-ConnectionGUID: q1QInvL1RBeVrmuj8px8Qw==
X-CSE-MsgGUID: +bsaB4qlRSuK9eXV88pxyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30893418"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="30893418"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 17:14:42 -0700
X-CSE-ConnectionGUID: YVBe2U8fSGOmlBSa1ZtaXg==
X-CSE-MsgGUID: N/1g1eB4QLOXSx0gaDdQKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="78594582"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 02 Oct 2024 17:14:40 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.128])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DEF551266F;
	Thu,  3 Oct 2024 01:14:38 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 2/2] ice: support optional flags in signature segment header
Date: Thu,  3 Oct 2024 02:10:32 +0200
Message-ID: <20241003001433.11211-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241003001433.11211-4-przemyslaw.kitszel@intel.com>
References: <20241003001433.11211-4-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An optional flag field has been added to the signature segment header.
The field contains two flags, a "valid" bit, and a "last segment" bit
that indicates whether the segment is the last segment that will be
sent to firmware.

If the flag field's valid bit is NOT set, then as was done before,
assume that this is the last segment being downloaded.

However, if the flag field's valid bit IS set, then use the last segment
flag to determine if this segment is the last segment to download.

Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2: co/- authorship change
---
 drivers/net/ethernet/intel/ice/ice_ddp.h |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_ddp.c | 24 +++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index 79551da2a4b0..8a2d57fc5dae 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -181,7 +181,10 @@ struct ice_sign_seg {
 	__le32 signed_seg_idx;
 	__le32 signed_buf_start;
 	__le32 signed_buf_count;
-#define ICE_SIGN_SEG_RESERVED_COUNT	44
+#define ICE_SIGN_SEG_FLAGS_VALID	0x80000000
+#define ICE_SIGN_SEG_FLAGS_LAST		0x00000001
+	__le32 flags;
+#define ICE_SIGN_SEG_RESERVED_COUNT	40
 	u8 reserved[ICE_SIGN_SEG_RESERVED_COUNT];
 	struct ice_buf_table buf_tbl;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index a2bb8442f281..859009940af0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1434,6 +1434,12 @@ ice_download_pkg_config_seg(struct ice_ddp_send_ctx *ctx,
 	return ice_dwnld_cfg_bufs_no_lock(ctx, bufs->buf_array, start, count);
 }
 
+static bool ice_is_last_sign_seg(u32 flags)
+{
+	return !(flags & ICE_SIGN_SEG_FLAGS_VALID) /* behavior prior to valid */
+	       || (flags & ICE_SIGN_SEG_FLAGS_LAST);
+}
+
 /**
  * ice_dwnld_sign_and_cfg_segs - download a signing segment and config segment
  * @ctx: context of the current buffers section to send
@@ -1446,11 +1452,9 @@ static enum ice_ddp_state
 ice_dwnld_sign_and_cfg_segs(struct ice_ddp_send_ctx *ctx,
 			    struct ice_pkg_hdr *pkg_hdr, u32 idx)
 {
+	u32 conf_idx, start, count, flags;
 	enum ice_ddp_state state;
 	struct ice_sign_seg *seg;
-	u32 conf_idx;
-	u32 start;
-	u32 count;
 
 	seg = (struct ice_sign_seg *)ice_get_pkg_seg_by_idx(pkg_hdr, idx);
 	if (!seg) {
@@ -1466,7 +1470,15 @@ ice_dwnld_sign_and_cfg_segs(struct ice_ddp_send_ctx *ctx,
 	conf_idx = le32_to_cpu(seg->signed_seg_idx);
 	start = le32_to_cpu(seg->signed_buf_start);
 
-	return ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start, count);
+	state = ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start,
+					    count);
+
+	/* finish up by sending last hunk with "last" flag set if requested by
+	 * DDP content */
+	flags = le32_to_cpu(seg->flags);
+	if (ice_is_last_sign_seg(flags))
+		state = ice_ddp_send_hunk(ctx, NULL);
+
 exit:
 	ctx->err = state;
 	return state;
@@ -1544,9 +1556,7 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 						    hw->pkg_sign_type))
 			continue;
 
-		ice_dwnld_sign_and_cfg_segs(&ctx, pkg_hdr, i);
-		/* finish up by sending last hunk with "last" flag set */
-		state = ice_ddp_send_hunk(&ctx, NULL);
+		state = ice_dwnld_sign_and_cfg_segs(&ctx, pkg_hdr, i);
 		if (state)
 			break;
 	}
-- 
2.46.0


