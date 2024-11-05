Return-Path: <netdev+bounces-142111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B819BD874
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA64C284242
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB33216A05;
	Tue,  5 Nov 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYTQIJEa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B647216440
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845444; cv=none; b=UIF5d8DLz5L5f7ALFaqVIrORqdGqDxtqu0oN9hCznFzWNilpHhLE73Xs8PwURuzEOADv+N2QtqD8JbxmsBHrAUH+f+WO2Sgv/ILq2emGyVjKI/M4ftaOUXzyqFeP8tCihzMzzXe83PtOxqOxKoNv4wG+l3pbjm7LJVll6iCzkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845444; c=relaxed/simple;
	bh=UB1BKs1NFcAJOY2+bDKUzdHQt3Fu6qA38RZCd3GAWI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMUNfToxEixfc7CSGT9nolPFqECtewTr0x2cPiFl6IpiV30JMPHfZEm8Se2e4OQp/G0lXtpqIKXTwRq65BEV+22b+OqfxEfjwcg+oICTv35LtGnPUrnT3ajGPb0Muikxba2cTMasSUIvdKkSeTD58PwCCvO7sPoeCvbWL8vj2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYTQIJEa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845442; x=1762381442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UB1BKs1NFcAJOY2+bDKUzdHQt3Fu6qA38RZCd3GAWI0=;
  b=DYTQIJEaXSnfw8ideNf/yXotMOPLSUuBkfDArJ/R9C4ML9JpL6Pbuu7X
   nKMcltCPcew41jpku/T9FtFov1YTModLaeYxDWRtjEC6gg6emyRTs+CR8
   SGRATUnL0uIEmNvnoTqDLMtlEAVFTc/HzfBBcMGBmEhZD62jWYZmqf1MA
   wzGkZ/J9whYZBeWjyHs7p6j4AcnhuYpO7r192Hj+Myylb/bY8Ba6F51R4
   nF2DvMwoKn0dLxUdL668OtMBDkcOKMaFLrGySW/tByci+I9ICcWPDQDNu
   2MaiB9xySOU4h2VTJjsIec9knviG7mgRnaWVTip781r8KGffFSscOsB6y
   Q==;
X-CSE-ConnectionGUID: GB06rV0FQt6FoJSFAAZM4A==
X-CSE-MsgGUID: PkIxZwKsSOuSaEPSjUUMcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314267"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314267"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:00 -0800
X-CSE-ConnectionGUID: 8OEOOppQSReGxvh9cpVPQQ==
X-CSE-MsgGUID: nJAHV4PUSMeAkeeDcAtuEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322438"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:23:58 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 04/15] ice: refactor "last" segment of DDP pkg
Date: Tue,  5 Nov 2024 14:23:38 -0800
Message-ID: <20241105222351.3320587-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Add ice_ddp_send_hunk() that buffers "sent FW hunk" calls to AQ in order
to mark the "last" one in more elegant way. Next commit will add even
more complicated "sent FW" flow, so it's better to untangle a bit before.

Note that metadata buffers were not skipped for NOT-@indicate_last
segments, this is fixed now.

Minor:
 + use ice_is_buffer_metadata() instead of open coding it in
   ice_dwnld_cfg_bufs();
 + ice_dwnld_cfg_bufs_no_lock() + dependencies were moved up a bit to have
   better git-diff, as this function was rewritten (in terms of git-blame)

CC: Paul Greenwalt <paul.greenwalt@intel.com>
CC: Dan Nowlin <dan.nowlin@intel.com>
CC: Ahmed Zaki <ahmed.zaki@intel.com>
CC: Simon Horman <horms@kernel.org>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 288 ++++++++++++-----------
 1 file changed, 151 insertions(+), 137 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 272fd823a825..3e1173ef4b5c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1210,6 +1210,131 @@ ice_aq_download_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
 	return status;
 }
 
+/**
+ * ice_is_buffer_metadata - determine if package buffer is a metadata buffer
+ * @buf: pointer to buffer header
+ * Return: whether given @buf is a metadata one.
+ */
+static bool ice_is_buffer_metadata(struct ice_buf_hdr *buf)
+{
+	return le32_to_cpu(buf->section_entry[0].type) & ICE_METADATA_BUF;
+}
+
+/**
+ * struct ice_ddp_send_ctx - sending context of current DDP segment
+ * @hw: pointer to the hardware struct
+ *
+ * Keeps current sending state (header, error) for the purpose of proper "last"
+ * bit setting in ice_aq_download_pkg(). Use via calls to ice_ddp_send_hunk().
+ */
+struct ice_ddp_send_ctx {
+	struct ice_hw *hw;
+/* private: only for ice_ddp_send_hunk() */
+	struct ice_buf_hdr *hdr;
+	int err;
+};
+
+static void ice_ddp_send_ctx_set_err(struct ice_ddp_send_ctx *ctx, int err)
+{
+	ctx->err = err;
+}
+
+/**
+ * ice_ddp_send_hunk - send one hunk of data to FW
+ * @ctx: current segment sending context
+ * @hunk: next hunk to send, size is always ICE_PKG_BUF_SIZE
+ *
+ * Send the next hunk of data to FW, retrying if needed.
+ *
+ * Notice: must be called once more with a NULL @hunk to finish up; such call
+ * will set up the "last" bit of an AQ request. After such call @ctx.hdr is
+ * cleared, @hw is still valid.
+ *
+ * Return: %ICE_DDP_PKG_SUCCESS if there were no problems; a sticky @err
+ *         otherwise.
+ */
+static enum ice_ddp_state ice_ddp_send_hunk(struct ice_ddp_send_ctx *ctx,
+					    struct ice_buf_hdr *hunk)
+{
+	struct ice_buf_hdr *prev_hunk = ctx->hdr;
+	struct ice_hw *hw = ctx->hw;
+	bool prev_was_last = !hunk;
+	enum ice_aq_err aq_err;
+	u32 offset, info;
+	int attempt, err;
+
+	if (ctx->err)
+		return ctx->err;
+
+	ctx->hdr = hunk;
+	if (!prev_hunk)
+		return ICE_DDP_PKG_SUCCESS; /* no problem so far */
+
+	for (attempt = 0; attempt < 5; attempt++) {
+		if (attempt)
+			msleep(20);
+
+		err = ice_aq_download_pkg(hw, prev_hunk, ICE_PKG_BUF_SIZE,
+					  prev_was_last, &offset, &info, NULL);
+
+		aq_err = hw->adminq.sq_last_status;
+		if (aq_err != ICE_AQ_RC_ENOSEC && aq_err != ICE_AQ_RC_EBADSIG)
+			break;
+	}
+
+	if (err) {
+		ice_debug(hw, ICE_DBG_PKG, "Pkg download failed: err %d off %d inf %d\n",
+			  err, offset, info);
+		ctx->err = ice_map_aq_err_to_ddp_state(aq_err);
+	} else if (attempt) {
+		dev_dbg(ice_hw_to_dev(hw),
+			"ice_aq_download_pkg number of retries: %d\n", attempt);
+	}
+
+	return ctx->err;
+}
+
+/**
+ * ice_dwnld_cfg_bufs_no_lock
+ * @ctx: context of the current buffers section to send
+ * @bufs: pointer to an array of buffers
+ * @start: buffer index of first buffer to download
+ * @count: the number of buffers to download
+ *
+ * Downloads package configuration buffers to the firmware. Metadata buffers
+ * are skipped, and the first metadata buffer found indicates that the rest
+ * of the buffers are all metadata buffers.
+ */
+static enum ice_ddp_state
+ice_dwnld_cfg_bufs_no_lock(struct ice_ddp_send_ctx *ctx, struct ice_buf *bufs,
+			   u32 start, u32 count)
+{
+	struct ice_buf_hdr *bh;
+	enum ice_ddp_state err;
+
+	if (!bufs || !count) {
+		ice_ddp_send_ctx_set_err(ctx, ICE_DDP_PKG_ERR);
+		return ICE_DDP_PKG_ERR;
+	}
+
+	bufs += start;
+
+	for (int i = 0; i < count; i++, bufs++) {
+		bh = (struct ice_buf_hdr *)bufs;
+		/* Metadata buffers should not be sent to FW,
+		 * their presence means "we are done here".
+		 */
+		if (ice_is_buffer_metadata(bh))
+			break;
+
+		err = ice_ddp_send_hunk(ctx, bh);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * ice_get_pkg_seg_by_idx
  * @pkg_hdr: pointer to the package header to be searched
@@ -1269,137 +1394,21 @@ ice_is_signing_seg_type_at_idx(struct ice_pkg_hdr *pkg_hdr, u32 idx,
 	return false;
 }
 
-/**
- * ice_is_buffer_metadata - determine if package buffer is a metadata buffer
- * @buf: pointer to buffer header
- */
-static bool ice_is_buffer_metadata(struct ice_buf_hdr *buf)
-{
-	if (le32_to_cpu(buf->section_entry[0].type) & ICE_METADATA_BUF)
-		return true;
-
-	return false;
-}
-
-/**
- * ice_is_last_download_buffer
- * @buf: pointer to current buffer header
- * @idx: index of the buffer in the current sequence
- * @count: the buffer count in the current sequence
- *
- * Note: this routine should only be called if the buffer is not the last buffer
- */
-static bool
-ice_is_last_download_buffer(struct ice_buf_hdr *buf, u32 idx, u32 count)
-{
-	struct ice_buf *next_buf;
-
-	if ((idx + 1) == count)
-		return true;
-
-	/* A set metadata flag in the next buffer will signal that the current
-	 * buffer will be the last buffer downloaded
-	 */
-	next_buf = ((struct ice_buf *)buf) + 1;
-
-	return ice_is_buffer_metadata((struct ice_buf_hdr *)next_buf);
-}
-
-/**
- * ice_dwnld_cfg_bufs_no_lock
- * @hw: pointer to the hardware structure
- * @bufs: pointer to an array of buffers
- * @start: buffer index of first buffer to download
- * @count: the number of buffers to download
- * @indicate_last: if true, then set last buffer flag on last buffer download
- *
- * Downloads package configuration buffers to the firmware. Metadata buffers
- * are skipped, and the first metadata buffer found indicates that the rest
- * of the buffers are all metadata buffers.
- */
-static enum ice_ddp_state
-ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
-			   u32 count, bool indicate_last)
-{
-	enum ice_ddp_state state = ICE_DDP_PKG_SUCCESS;
-	struct ice_buf_hdr *bh;
-	enum ice_aq_err err;
-	u32 offset, info, i;
-
-	if (!bufs || !count)
-		return ICE_DDP_PKG_ERR;
-
-	/* If the first buffer's first section has its metadata bit set
-	 * then there are no buffers to be downloaded, and the operation is
-	 * considered a success.
-	 */
-	bh = (struct ice_buf_hdr *)(bufs + start);
-	if (le32_to_cpu(bh->section_entry[0].type) & ICE_METADATA_BUF)
-		return ICE_DDP_PKG_SUCCESS;
-
-	for (i = 0; i < count; i++) {
-		bool last = false;
-		int try_cnt = 0;
-		int status;
-
-		bh = (struct ice_buf_hdr *)(bufs + start + i);
-
-		if (indicate_last)
-			last = ice_is_last_download_buffer(bh, i, count);
-
-		while (1) {
-			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
-						     last, &offset, &info,
-						     NULL);
-			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
-			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
-				break;
-
-			try_cnt++;
-
-			if (try_cnt == 5)
-				break;
-
-			msleep(20);
-		}
-
-		if (try_cnt)
-			dev_dbg(ice_hw_to_dev(hw),
-				"ice_aq_download_pkg number of retries: %d\n",
-				try_cnt);
-
-		/* Save AQ status from download package */
-		if (status) {
-			ice_debug(hw, ICE_DBG_PKG, "Pkg download failed: err %d off %d inf %d\n",
-				  status, offset, info);
-			err = hw->adminq.sq_last_status;
-			state = ice_map_aq_err_to_ddp_state(err);
-			break;
-		}
-
-		if (last)
-			break;
-	}
-
-	return state;
-}
-
 /**
  * ice_download_pkg_sig_seg - download a signature segment
- * @hw: pointer to the hardware structure
+ * @ctx: context of the current buffers section to send
  * @seg: pointer to signature segment
  */
 static enum ice_ddp_state
-ice_download_pkg_sig_seg(struct ice_hw *hw, struct ice_sign_seg *seg)
+ice_download_pkg_sig_seg(struct ice_ddp_send_ctx *ctx, struct ice_sign_seg *seg)
 {
-	return  ice_dwnld_cfg_bufs_no_lock(hw, seg->buf_tbl.buf_array, 0,
-					   le32_to_cpu(seg->buf_tbl.buf_count),
-					   false);
+	return ice_dwnld_cfg_bufs_no_lock(ctx, seg->buf_tbl.buf_array, 0,
+					  le32_to_cpu(seg->buf_tbl.buf_count));
 }
 
 /**
  * ice_download_pkg_config_seg - download a config segment
- * @hw: pointer to the hardware structure
+ * @ctx: context of the current buffers section to send
  * @pkg_hdr: pointer to package header
  * @idx: segment index
  * @start: starting buffer
@@ -1408,8 +1417,9 @@ ice_download_pkg_sig_seg(struct ice_hw *hw, struct ice_sign_seg *seg)
  * Note: idx must reference a ICE segment
  */
 static enum ice_ddp_state
-ice_download_pkg_config_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
-			    u32 idx, u32 start, u32 count)
+ice_download_pkg_config_seg(struct ice_ddp_send_ctx *ctx,
+			    struct ice_pkg_hdr *pkg_hdr, u32 idx, u32 start,
+			    u32 count)
 {
 	struct ice_buf_table *bufs;
 	struct ice_seg *seg;
@@ -1425,21 +1435,20 @@ ice_download_pkg_config_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
 	if (start >= buf_count || start + count > buf_count)
 		return ICE_DDP_PKG_ERR;
 
-	return  ice_dwnld_cfg_bufs_no_lock(hw, bufs->buf_array, start, count,
-					   true);
+	return ice_dwnld_cfg_bufs_no_lock(ctx, bufs->buf_array, start, count);
 }
 
 /**
  * ice_dwnld_sign_and_cfg_segs - download a signing segment and config segment
- * @hw: pointer to the hardware structure
+ * @ctx: context of the current buffers section to send
  * @pkg_hdr: pointer to package header
  * @idx: segment index (must be a signature segment)
  *
  * Note: idx must reference a signature segment
  */
 static enum ice_ddp_state
-ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
-			    u32 idx)
+ice_dwnld_sign_and_cfg_segs(struct ice_ddp_send_ctx *ctx,
+			    struct ice_pkg_hdr *pkg_hdr, u32 idx)
 {
 	enum ice_ddp_state state;
 	struct ice_sign_seg *seg;
@@ -1450,21 +1459,20 @@ ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
 	seg = (struct ice_sign_seg *)ice_get_pkg_seg_by_idx(pkg_hdr, idx);
 	if (!seg) {
 		state = ICE_DDP_PKG_ERR;
-		goto exit;
+		ice_ddp_send_ctx_set_err(ctx, state);
+		return state;
 	}
 
 	count = le32_to_cpu(seg->signed_buf_count);
-	state = ice_download_pkg_sig_seg(hw, seg);
+	state = ice_download_pkg_sig_seg(ctx, seg);
 	if (state || !count)
-		goto exit;
+		return state;
 
 	conf_idx = le32_to_cpu(seg->signed_seg_idx);
 	start = le32_to_cpu(seg->signed_buf_start);
 
-	state = ice_download_pkg_config_seg(hw, pkg_hdr, conf_idx, start,
+	state = ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start,
 					    count);
-
-exit:
 	return state;
 }
 
@@ -1519,6 +1527,7 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 {
 	enum ice_aq_err aq_err = hw->adminq.sq_last_status;
 	enum ice_ddp_state state = ICE_DDP_PKG_ERR;
+	struct ice_ddp_send_ctx ctx = { .hw = hw };
 	int status;
 	u32 i;
 
@@ -1539,7 +1548,9 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 						    hw->pkg_sign_type))
 			continue;
 
-		state = ice_dwnld_sign_and_cfg_segs(hw, pkg_hdr, i);
+		ice_dwnld_sign_and_cfg_segs(&ctx, pkg_hdr, i);
+		/* finish up by sending last hunk with "last" flag set */
+		state = ice_ddp_send_hunk(&ctx, NULL);
 		if (state)
 			break;
 	}
@@ -1564,6 +1575,7 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 static enum ice_ddp_state
 ice_dwnld_cfg_bufs(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
 {
+	struct ice_ddp_send_ctx ctx = { .hw = hw };
 	enum ice_ddp_state state;
 	struct ice_buf_hdr *bh;
 	int status;
@@ -1576,7 +1588,7 @@ ice_dwnld_cfg_bufs(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
 	 * considered a success.
 	 */
 	bh = (struct ice_buf_hdr *)bufs;
-	if (le32_to_cpu(bh->section_entry[0].type) & ICE_METADATA_BUF)
+	if (ice_is_buffer_metadata(bh))
 		return ICE_DDP_PKG_SUCCESS;
 
 	status = ice_acquire_global_cfg_lock(hw, ICE_RES_WRITE);
@@ -1586,7 +1598,9 @@ ice_dwnld_cfg_bufs(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
 		return ice_map_aq_err_to_ddp_state(hw->adminq.sq_last_status);
 	}
 
-	state = ice_dwnld_cfg_bufs_no_lock(hw, bufs, 0, count, true);
+	ice_dwnld_cfg_bufs_no_lock(&ctx, bufs, 0, count);
+	/* finish up by sending last hunk with "last" flag set */
+	state = ice_ddp_send_hunk(&ctx, NULL);
 	if (!state)
 		state = ice_post_dwnld_pkg_actions(hw);
 
-- 
2.42.0


