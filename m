Return-Path: <netdev+bounces-126995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D1973939
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDF8288A7C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE6192D60;
	Tue, 10 Sep 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9cf6jid"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A321193099
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976747; cv=none; b=W6VG/2zVLW2ae3kAoV3HMYUmiHdYRWIvnCsCkPmQ1D/Se1K5hexfCFMm6rDukoXAU3IVkRLCpfHMkJwgH/S28xMDhCM4KmNMDMu6tC158WSRURHf91puDQP9qiHO4NsmiFuUfXjzdk3hWWM3QSceYVWLjFpIuvPZPpKV0d0KLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976747; c=relaxed/simple;
	bh=A9vnovoJ6RCpux/CpGxMIlLHjNbXDQ2+KzXezxtkdUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCx9tiLWk5BeJ5dn78orlSxCg/5gVGZuhfiKkYkYZWxrfgGeomMo1sBxAyx8PrRvzpgi19uhaYs99seqkMiT00RItsYdQTsI0X4S9IWlbDHfs4EbPco6os0PwjF3P41KzIBka7hx2TO0JvD58sBHGhsRmflD87v3kQh41gVKJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9cf6jid; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725976746; x=1757512746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A9vnovoJ6RCpux/CpGxMIlLHjNbXDQ2+KzXezxtkdUo=;
  b=g9cf6jidMMMkb1LFizYRi7t+jc1tPSizUDRQa9OxsmWiwcluHeaD8qSW
   Hq+ThB2uiZ9u0Wm6ASyqsY74efhxEtns8VMPceX0vNwBX5LJLdTN5Gdwq
   v6H3BPnyg01taZ3wdrk2/pOLjlVCeCb/zVb/c7bp4xvkiuTZ3IibdXWDv
   BiK7xLvsOYhcnbwzHXd3mGamw/nik0SK4H4Am7sglGktGjHlZE8M8657n
   rB/k7e8g3IEhfxTinkpm1WUcWB6zTKxwEOIfOJAmU3l7Hxuceo/0XXZf/
   wSU8w1a9XXoJCmHHQwcUzk6Wv+esdXbWVqMNot6KXi2U//Cwzzm/2pWfm
   g==;
X-CSE-ConnectionGUID: HgAv8uElT/6wX/ogLsjHVA==
X-CSE-MsgGUID: 5fnISywSTNuU7mDVb2OPKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28614413"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="28614413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:59:05 -0700
X-CSE-ConnectionGUID: iwDbtjOAQqijO85QWaeczg==
X-CSE-MsgGUID: 4YdcaoniSYyTC8dlThI46w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66997721"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2024 06:59:02 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.31])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A1CB427BAD;
	Tue, 10 Sep 2024 14:59:00 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-net v2] ice: fix memleak in ice_init_tx_topology()
Date: Tue, 10 Sep 2024 15:57:21 +0200
Message-ID: <20240910135814.35693-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix leak of the FW blob (DDP pkg).

Make ice_cfg_tx_topo() const-correct, so ice_init_tx_topology() can avoid
copying whole FW blob. Copy just the topology section, and only when
needed. Reuse the buffer allocated for the read of the current topology.

This was found by kmemleak, with the following trace for each PF:
    [<ffffffff8761044d>] kmemdup_noprof+0x1d/0x50
    [<ffffffffc0a0a480>] ice_init_ddp_config+0x100/0x220 [ice]
    [<ffffffffc0a0da7f>] ice_init_dev+0x6f/0x200 [ice]
    [<ffffffffc0a0dc49>] ice_init+0x29/0x560 [ice]
    [<ffffffffc0a10c1d>] ice_probe+0x21d/0x310 [ice]

Constify ice_cfg_tx_topo() @buf parameter.
This cascades further down to few more functions.

Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
CC: Larysa Zaremba <larysa.zaremba@intel.com>
CC: Jacob Keller <jacob.e.keller@intel.com>
CC: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
CC: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
this patch obsoletes two other, so I'm dropping RB tags
v1, iwl-net: https://lore.kernel.org/netdev/20240904123306.14629-2-przemyslaw.kitszel@intel.com/
    wrong assumption that ice_get_set_tx_topo() does not modify the buffer
    on adminq SET variant, it sometimes does, to fill the response, thanks
    to Pucha Himasekhar Reddy for finding it out;
almost-const-correct iwl-next patch:
https://lore.kernel.org/intel-wired-lan/20240904093135.8795-2-przemyslaw.kitszel@intel.com
it was just some of this patch, now it is const-correct
---
 drivers/net/ethernet/intel/ice/ice_ddp.h  |  4 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c  | 58 +++++++++++------------
 drivers/net/ethernet/intel/ice/ice_main.c |  8 +---
 3 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index 622543f08b43..00840e5a1077 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -430,7 +430,7 @@ struct ice_pkg_enum {
 	u32 buf_idx;
 
 	u32 type;
-	struct ice_buf_hdr *buf;
+	const struct ice_buf_hdr *buf;
 	u32 sect_idx;
 	void *sect;
 	u32 sect_type;
@@ -454,6 +454,6 @@ u16 ice_pkg_buf_get_active_sections(struct ice_buf_build *bld);
 void *ice_pkg_enum_section(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
 			   u32 sect_type);
 
-int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len);
+int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len);
 
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index f182179529b7..6b60b7c4de09 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -31,7 +31,7 @@ static const struct ice_tunnel_type_scan tnls[] = {
  * Verifies various attributes of the package file, including length, format
  * version, and the requirement of at least one segment.
  */
-static enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len)
+static enum ice_ddp_state ice_verify_pkg(const struct ice_pkg_hdr *pkg, u32 len)
 {
 	u32 seg_count;
 	u32 i;
@@ -57,13 +57,13 @@ static enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len)
 	/* all segments must fit within length */
 	for (i = 0; i < seg_count; i++) {
 		u32 off = le32_to_cpu(pkg->seg_offset[i]);
-		struct ice_generic_seg_hdr *seg;
+		const struct ice_generic_seg_hdr *seg;
 
 		/* segment header must fit */
 		if (len < off + sizeof(*seg))
 			return ICE_DDP_PKG_INVALID_FILE;
 
-		seg = (struct ice_generic_seg_hdr *)((u8 *)pkg + off);
+		seg = (void *)pkg + off;
 
 		/* segment body must fit */
 		if (len < off + le32_to_cpu(seg->seg_size))
@@ -119,13 +119,13 @@ static enum ice_ddp_state ice_chk_pkg_version(struct ice_pkg_ver *pkg_ver)
  *
  * This helper function validates a buffer's header.
  */
-static struct ice_buf_hdr *ice_pkg_val_buf(struct ice_buf *buf)
+static const struct ice_buf_hdr *ice_pkg_val_buf(const struct ice_buf *buf)
 {
-	struct ice_buf_hdr *hdr;
+	const struct ice_buf_hdr *hdr;
 	u16 section_count;
 	u16 data_end;
 
-	hdr = (struct ice_buf_hdr *)buf->buf;
+	hdr = (const struct ice_buf_hdr *)buf->buf;
 	/* verify data */
 	section_count = le16_to_cpu(hdr->section_count);
 	if (section_count < ICE_MIN_S_COUNT || section_count > ICE_MAX_S_COUNT)
@@ -165,8 +165,8 @@ static struct ice_buf_table *ice_find_buf_table(struct ice_seg *ice_seg)
  * unexpected value has been detected (for example an invalid section count or
  * an invalid buffer end value).
  */
-static struct ice_buf_hdr *ice_pkg_enum_buf(struct ice_seg *ice_seg,
-					    struct ice_pkg_enum *state)
+static const struct ice_buf_hdr *ice_pkg_enum_buf(struct ice_seg *ice_seg,
+						  struct ice_pkg_enum *state)
 {
 	if (ice_seg) {
 		state->buf_table = ice_find_buf_table(ice_seg);
@@ -1800,9 +1800,9 @@ int ice_update_pkg(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
  * success it returns a pointer to the segment header, otherwise it will
  * return NULL.
  */
-static struct ice_generic_seg_hdr *
+static const struct ice_generic_seg_hdr *
 ice_find_seg_in_pkg(struct ice_hw *hw, u32 seg_type,
-		    struct ice_pkg_hdr *pkg_hdr)
+		    const struct ice_pkg_hdr *pkg_hdr)
 {
 	u32 i;
 
@@ -1813,11 +1813,9 @@ ice_find_seg_in_pkg(struct ice_hw *hw, u32 seg_type,
 
 	/* Search all package segments for the requested segment type */
 	for (i = 0; i < le32_to_cpu(pkg_hdr->seg_count); i++) {
-		struct ice_generic_seg_hdr *seg;
+		const struct ice_generic_seg_hdr *seg;
 
-		seg = (struct ice_generic_seg_hdr
-			       *)((u8 *)pkg_hdr +
-				  le32_to_cpu(pkg_hdr->seg_offset[i]));
+		seg = (void *)pkg_hdr + le32_to_cpu(pkg_hdr->seg_offset[i]);
 
 		if (le32_to_cpu(seg->seg_type) == seg_type)
 			return seg;
@@ -2354,12 +2352,12 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
  *
  * Return: zero when update was successful, negative values otherwise.
  */
-int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
+int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 {
-	u8 *current_topo, *new_topo = NULL;
-	struct ice_run_time_cfg_seg *seg;
-	struct ice_buf_hdr *section;
-	struct ice_pkg_hdr *pkg_hdr;
+	u8 *new_topo = NULL, *topo __free(kfree) = NULL;
+	const struct ice_run_time_cfg_seg *seg;
+	const struct ice_buf_hdr *section;
+	const struct ice_pkg_hdr *pkg_hdr;
 	enum ice_ddp_state state;
 	u16 offset, size = 0;
 	u32 reg = 0;
@@ -2375,15 +2373,13 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 		return -EOPNOTSUPP;
 	}
 
-	current_topo = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
-	if (!current_topo)
+	topo = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
+	if (!topo)
 		return -ENOMEM;
 
-	/* Get the current Tx topology */
-	status = ice_get_set_tx_topo(hw, current_topo, ICE_AQ_MAX_BUF_LEN, NULL,
-				     &flags, false);
-
-	kfree(current_topo);
+	/* Get the current Tx topology flags */
+	status = ice_get_set_tx_topo(hw, topo, ICE_AQ_MAX_BUF_LEN, NULL, &flags,
+				     false);
 
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Get current topology is failed\n");
@@ -2419,16 +2415,16 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 		goto update_topo;
 	}
 
-	pkg_hdr = (struct ice_pkg_hdr *)buf;
+	pkg_hdr = (const struct ice_pkg_hdr *)buf;
 	state = ice_verify_pkg(pkg_hdr, len);
 	if (state) {
 		ice_debug(hw, ICE_DBG_INIT, "Failed to verify pkg (err: %d)\n",
 			  state);
 		return -EIO;
 	}
 
 	/* Find runtime configuration segment */
-	seg = (struct ice_run_time_cfg_seg *)
+	seg = (const struct ice_run_time_cfg_seg *)
 	      ice_find_seg_in_pkg(hw, SEGMENT_TYPE_ICE_RUN_TIME_CFG, pkg_hdr);
 	if (!seg) {
 		ice_debug(hw, ICE_DBG_INIT, "5 layer topology segment is missing\n");
@@ -2461,8 +2457,10 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 		return -EIO;
 	}
 
-	/* Get the new topology buffer */
-	new_topo = ((u8 *)section) + offset;
+	/* Get the new topology buffer, reuse current topo copy mem */
+	static_assert(ICE_PKG_BUF_SIZE == ICE_AQ_MAX_BUF_LEN);
+	new_topo = topo;
+	memcpy(new_topo, (u8 *)section + offset, size);
 
 update_topo:
 	/* Acquire global lock to make sure that set topology issued
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c7db88b517da..30b94eca32b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4548,16 +4548,10 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
 	u8 num_tx_sched_layers = hw->num_tx_sched_layers;
 	struct ice_pf *pf = hw->back;
 	struct device *dev;
-	u8 *buf_copy;
 	int err;
 
 	dev = ice_pf_to_dev(pf);
-	/* ice_cfg_tx_topo buf argument is not a constant,
-	 * so we have to make a copy
-	 */
-	buf_copy = kmemdup(firmware->data, firmware->size, GFP_KERNEL);
-
-	err = ice_cfg_tx_topo(hw, buf_copy, firmware->size);
+	err = ice_cfg_tx_topo(hw, firmware->data, firmware->size);
 	if (!err) {
 		if (hw->num_tx_sched_layers > num_tx_sched_layers)
 			dev_info(dev, "Tx scheduling layers switching feature disabled\n");

base-commit: b3c9e65eb227269ed72a115ba22f4f51b4e62b4d
-- 
2.46.0


