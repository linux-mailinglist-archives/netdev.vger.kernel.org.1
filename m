Return-Path: <netdev+bounces-166922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DEBA37DEA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9565F3A8A5B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6B1A3157;
	Mon, 17 Feb 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6CzhRh1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD5155316
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783211; cv=none; b=mDs0euGMdTimenRlqn8JUYjnO90QzbbYMnm60AT55mCw2tGqHnJVn7dNHCUP/0riinwfrK3uxEir/HXZTk7N3yQ9NUHFtdEH4gQsAiUg4aDr0Vl5/ozEzxkGHZDV1+IJdQYkk4PKZ2taBlcc9PJWHFNBrISEy8xmFtqWpT4GbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783211; c=relaxed/simple;
	bh=nJCkytmPtDyYoEpk7Y2B0AQ4HJ0hsEDOqc+k3dFC+kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/8Qewdngxk41cM5O4lJPh4aKIQ086aLIMtk38rIyRDEJ3oQMihzDq2KSIOkeo7TTuogrcwbvZPgceJnKJwTHcOuRrclBTVFJLWNCcXJpnXEGYVRA8hb4URdmqS/jPzdaVTDZRZzJ2RLF0TLv6hIUVOfrb6/+DQGlxfTfmmutTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6CzhRh1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739783209; x=1771319209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJCkytmPtDyYoEpk7Y2B0AQ4HJ0hsEDOqc+k3dFC+kY=;
  b=V6CzhRh1Hq8YdbDl+3HZN7Yx9hDmKF0Qq9ndwbOGqzz/yhZh/eujOLWi
   Fg10XpDnWOImBodjbNE/KMvDkhBhAei0GLMv2/ClaKupAVIPL7Xhao/u8
   Xrk1y6YNkwbQBq6Bb4qeHLQFi6ZPsa8h6AHQCLdBL/AnC/InyNVCCFKMB
   XAyufCb4/rgwLyvFXV62F7bbbtAHqaQjTFGlAOUBCQ705cic9xMY4QfVm
   6H2FAzGqMnuADJ6Hs3/nwcQKrW6TZ/bjcMwg+iGuKe7LN4zzaacU2+ggf
   aKDdblSQrilqv8XSVkptl3nbS7g07GTUDSTASCH8Da4nP9oF4yMsXTA8N
   g==;
X-CSE-ConnectionGUID: I+NslV/qS7WaItDtz0+fZQ==
X-CSE-MsgGUID: NcDjsk8vRP2caaYyXyP+0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51078515"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="51078515"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:06:49 -0800
X-CSE-ConnectionGUID: 6cIaYjYMR3SucZqcu8CbZg==
X-CSE-MsgGUID: 2YPdZIDPTdKjw092Rjbk6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="113937627"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa006.fm.intel.com with ESMTP; 17 Feb 2025 01:06:47 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de
Subject: [iwl-next v3 4/4] ixgbe: turn off MDD while modifying SRRCTL
Date: Mon, 17 Feb 2025 10:06:36 +0100
Message-ID: <20250217090636.25113-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
References: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

Modifying SRRCTL register can generate MDD event.

Turn MDD off during SRRCTL register write to prevent generating MDD.

Fix RCT in ixgbe_set_rx_drop_en().

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 22148e65e596..873b46d21042 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4099,8 +4099,12 @@ void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 #endif
 {
-	int i;
 	bool pfc_en = adapter->dcb_cfg.pfc_mode_enable;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int i;
+
+	if (hw->mac.ops.disable_mdd)
+		hw->mac.ops.disable_mdd(hw);
 
 	if (adapter->ixgbe_ieee_pfc)
 		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
@@ -4122,6 +4126,9 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 		for (i = 0; i < adapter->num_rx_queues; i++)
 			ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
 	}
+
+	if (hw->mac.ops.enable_mdd)
+		hw->mac.ops.enable_mdd(hw);
 }
 
 #define IXGBE_SRRCTL_BSIZEHDRSIZE_SHIFT 2
-- 
2.42.0


