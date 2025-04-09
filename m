Return-Path: <netdev+bounces-180713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6501FA823AB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF3919E8814
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC025E448;
	Wed,  9 Apr 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6Eq/JZo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371E42566D9
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198606; cv=none; b=o3qMyodKvv3tHTs8HpQ5adC05M2cuLgrV2B//1zi+eRSgO1ZNmmZjvJysNetYrhBq5y5zaJOdZyc9WQ3eihtH8ng0AOU7M3lq8pr6mkWGIxyNA3kvM3HBr5pWRhg/3ESGXHcOIDZhVW5Fp86lgIhTVJzvcF8xquVu2YsURehCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198606; c=relaxed/simple;
	bh=CAy8k0n5r7NmP0cM4NF6+yLjW+YXMQ4/bf2tOLA1Vxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnPANYCWjeU5Xi+3XBKR7OaKHNu40vhp3M2rnefA5Wkm0PocVy2H/MFEQkrD4QdgRe9emMq1Zj76IzVn9soP1RGTvnOXIBeoE4zV47iOmGmVfVKWBw0DvUrcnp7Qquw1ISuvwu3vT7h6piOvdfhHLWwv9Y4/MVXnX3QvaZEflJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6Eq/JZo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744198606; x=1775734606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CAy8k0n5r7NmP0cM4NF6+yLjW+YXMQ4/bf2tOLA1Vxc=;
  b=I6Eq/JZoXc7wNWiBU5SsIWUKPKPCYN64reyZYwbQaM9XOCVErxq1AOnJ
   Fay+ChAEJCA6rZMAjb/6kXkgJQvOQRphe18pjtAvokXQ6UWNsLS3WZoM8
   2daf/3405jz87NyZHsigYDUVEKd17rtNXODOsdTv+DJZ/Xy6QRxnBeoDU
   cOJPQlJId/FPejYvGmRyRivXLS5fWwUF5LTdU76i13tXLjiMtCuBGN1jy
   Yn/67QYlrV8Pssn5ambYl4vOQn92Ei0w87TFZOIKiEom0VEOjVb4sRAsz
   cmUdyHqq9r+KdVUj6vAN5SGzIxE4RAOueoB5VH9NXoj/kI6qc+A293/ip
   Q==;
X-CSE-ConnectionGUID: NMU9K4hCT86fsBJnR2BsqQ==
X-CSE-MsgGUID: 1CrJ/DkDRJqZGgvY/69JsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45799650"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45799650"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 04:36:45 -0700
X-CSE-ConnectionGUID: 9//HFy2QTE6DkXx6HOxboA==
X-CSE-MsgGUID: e2ZSjSbOQrufvJdz3yAIpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="159536677"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa001.fm.intel.com with ESMTP; 09 Apr 2025 04:36:42 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-next 1/2] ice: add link_down_events statistic
Date: Wed,  9 Apr 2025 13:36:23 +0200
Message-ID: <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new ethtool statistic to ice driver, `link_down_events`,
to track the number of times the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The counter increments when a link-down event occurs and is exposed
via ethtool stats as `link_down_events.nic`.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 7200d6042590..6304104d1900 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -621,6 +621,7 @@ struct ice_pf {
 	u16 globr_count;	/* Global reset count */
 	u16 empr_count;		/* EMP reset count */
 	u16 pfr_count;		/* PF reset count */
+	u32 link_down_events;
 
 	u8 wol_ena : 1;		/* software state of WoL */
 	u32 wakeup_reason;	/* last wakeup reason */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b0805704834d..7bad0113aa88 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -137,6 +137,7 @@ static const struct ice_stats ice_gstrings_pf_stats[] = {
 	ICE_PF_STAT("mac_remote_faults.nic", stats.mac_remote_faults),
 	ICE_PF_STAT("fdir_sb_match.nic", stats.fd_sb_match),
 	ICE_PF_STAT("fdir_sb_status.nic", stats.fd_sb_status),
+	ICE_PF_STAT("link_down_events.nic", link_down_events),
 	ICE_PF_STAT("tx_hwtstamp_skipped", ptp.tx_hwtstamp_skipped),
 	ICE_PF_STAT("tx_hwtstamp_timeouts", ptp.tx_hwtstamp_timeouts),
 	ICE_PF_STAT("tx_hwtstamp_flushed", ptp.tx_hwtstamp_flushed),
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a03e1819e6d5..d68dd2a3f4a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1144,6 +1144,9 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	if (link_up == old_link && link_speed == old_link_speed)
 		return 0;
 
+	if (!link_up && old_link)
+		pf->link_down_events++;
+
 	ice_ptp_link_change(pf, link_up);
 
 	if (ice_is_dcb_active(pf)) {
-- 
2.47.0


