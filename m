Return-Path: <netdev+bounces-116416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C559094A5B2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449621F20944
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B79C1D3641;
	Wed,  7 Aug 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQgE5JLF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936613F435
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027058; cv=none; b=N+XNZTWlRbh9Lt6QU5i1CFY6jMAQ4M/kwnWbUJOn76yGHP+h7dlrurmtk017lwNZLzN2p6vZBG1bezCG0vaL0fWBIJU6DJXM9CuY8pwA37lljZ8ERCyoWUYDkaq5emOtYS2Wfap3+H0Z13zJ3sHQkUbTirF6s9KGoNDGQsh9lOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027058; c=relaxed/simple;
	bh=0XEm14Tl2rJzO8ff+7cL4TIM6tCXDLraeADPofWpbhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OAptuzz9X5MtpE02LKRY6t+KEP9N2encNllPeGpEZ49jlsha6woIPdo6wLleLswufLfA8AI5i1vh29Hs1MnIq2ORoAAp7XvbQEdcMWyXAk2fLXHZQ0U/7cf5VFhhy2zDzhLLqGknfhmQ5y73A139cDhN2gvYm74Bu+Aougt4G4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQgE5JLF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723027056; x=1754563056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0XEm14Tl2rJzO8ff+7cL4TIM6tCXDLraeADPofWpbhk=;
  b=ZQgE5JLFlTVQTaTfk8AeWB4rB7YOcMRFYlW9TeQ6C3OTOb05+HZm/Say
   x4Ia/VJ1SvjdkS68+EWcd6gWi9CmjCW5tIlBg2arEFvcKc14PDt8VVm5I
   DjTrYAv0inv5PLniZhx/KaM2a9dj13xWPCD9b0O0j1aiUTbmyAGmo3SBq
   IHKobvVau8JxaWbyWZAe34Dk5eqR6WLKN9RWFm8cgsLCmQq5n/+CziqF5
   OXYu/TnT//AXPLUqVL9ZrA9ZvXfJEmRTVejkZjUxaKylf1laYDSNUVSZ4
   ixWjF5UaeD+a88ocZi7J5nZVgl1UyRc+d//yOyhdn8WspnNdNwF7UVMe5
   w==;
X-CSE-ConnectionGUID: zFId2GleRy++1Sx1eqGdeA==
X-CSE-MsgGUID: JHHQB3lTQkOBeMJ6prFRDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21061362"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="21061362"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 03:37:35 -0700
X-CSE-ConnectionGUID: u3disdMhRSS37LB7ztinqw==
X-CSE-MsgGUID: 4HgT/+geR5+UthpF1rdXbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61694712"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 07 Aug 2024 03:37:34 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2E9E228763;
	Wed,  7 Aug 2024 11:37:32 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	kuba@kernel.org
Subject: [PATCH iwl-next v3] ice: Implement ethtool reset support
Date: Wed,  7 Aug 2024 12:35:05 +0200
Message-Id: <20240807103505.208650-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ethtool reset support. Ethtool reset flags are mapped to the
E810 reset type:
PF reset:
  $ ethtool --reset <ethX> irq dma filter offload
CORE reset:
  $ ethtool --reset <ethX> irq-shared dma-shared filter-shared \
    offload-shared ram-shared
GLOBAL reset:
  $ ethtool --reset <ethX> irq-shared dma-shared filter-shared \
    offload-shared mac-shared phy-shared ram-shared

Calling the same set of flags as in PF reset case on port representor
triggers VF reset.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v2: remap ethtool flags to ice resets
v3: resend, add changelog, rebase, fix doc
---
 .../device_drivers/ethernet/intel/ice.rst     | 31 ++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 77 +++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 934752f675ba..3c46a48d99ba 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -101,6 +101,37 @@ example, if Rx packets are 10 and Netdev (software statistics) displays
 rx_bytes as "X", then ethtool (hardware statistics) will display rx_bytes as
 "X+40" (4 bytes CRC x 10 packets).
 
+ethtool reset
+-------------
+The driver supports 3 types of resets:
+
+- PF reset - resets only components associated with the given PF, does not
+  impact other PFs
+
+- CORE reset - whole adapter is affected, reset all PFs
+
+- GLOBAL reset - same as CORE but mac and phy components are also reinitialized
+
+These are mapped to ethtool reset flags as follow:
+
+- PF reset:
+
+  # ethtool --reset <ethX> irq dma filter offload
+
+- CORE reset:
+
+  # ethtool --reset <ethX> irq-shared dma-shared filter-shared offload-shared \
+  ram-shared
+
+- GLOBAL reset:
+
+  # ethtool --reset <ethX> irq-shared dma-shared filter-shared offload-shared \
+  mac-shared phy-shared ram-shared
+
+In switchdev mode you can reset a VF using port representor:
+
+  # ethtool --reset <repr> irq dma filter offload
+
 
 Viewing Link Messages
 ---------------------
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b877002d549b..a981da8caf76 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4718,6 +4718,81 @@ static void ice_get_fec_stats(struct net_device *netdev,
 			    pi->lport, err);
 }
 
+#define ICE_ETHTOOL_PFR (ETH_RESET_IRQ | ETH_RESET_DMA | \
+	ETH_RESET_FILTER | ETH_RESET_OFFLOAD)
+
+#define ICE_ETHTOOL_CORER ((ICE_ETHTOOL_PFR | ETH_RESET_RAM) << \
+	ETH_RESET_SHARED_SHIFT)
+
+#define ICE_ETHTOOL_GLOBR (ICE_ETHTOOL_CORER | \
+	(ETH_RESET_MAC << ETH_RESET_SHARED_SHIFT) | \
+	(ETH_RESET_PHY << ETH_RESET_SHARED_SHIFT))
+
+#define ICE_ETHTOOL_VFR ICE_ETHTOOL_PFR
+
+/**
+ * ice_ethtool_reset - triggers a given type of reset
+ * @dev: network interface device structure
+ * @flags: set of reset flags
+ *
+ * Return: 0 on success, -EOPNOTSUPP when using unsupported set of flags.
+ */
+static int ice_ethtool_reset(struct net_device *dev, u32 *flags)
+{
+	struct ice_netdev_priv *np = netdev_priv(dev);
+	struct ice_pf *pf = np->vsi->back;
+	enum ice_reset_req reset;
+
+	switch (*flags) {
+	case ICE_ETHTOOL_CORER:
+		reset = ICE_RESET_CORER;
+		break;
+	case ICE_ETHTOOL_GLOBR:
+		reset = ICE_RESET_GLOBR;
+		break;
+	case ICE_ETHTOOL_PFR:
+		reset = ICE_RESET_PFR;
+		break;
+	default:
+		netdev_info(dev, "Unsupported set of ethtool flags");
+		return -EOPNOTSUPP;
+	}
+
+	ice_schedule_reset(pf, reset);
+
+	*flags = 0;
+
+	return 0;
+}
+
+/**
+ * ice_repr_ethtool_reset - triggers a VF reset
+ * @dev: network interface device structure
+ * @flags: set of reset flags
+ *
+ * Return: 0 on success,
+ * -EOPNOTSUPP when using unsupported set of flags
+ * -EBUSY when VF is not ready for reset.
+ */
+static int ice_repr_ethtool_reset(struct net_device *dev, u32 *flags)
+{
+	struct ice_repr *repr = ice_netdev_to_repr(dev);
+	struct ice_vf *vf;
+
+	if (repr->type != ICE_REPR_TYPE_VF ||
+	    *flags != ICE_ETHTOOL_VFR)
+		return -EOPNOTSUPP;
+
+	vf = repr->vf;
+
+	if (ice_check_vf_ready_for_cfg(vf))
+		return -EBUSY;
+
+	*flags = 0;
+
+	return ice_reset_vf(vf, ICE_VF_RESET_VFLR | ICE_VF_RESET_LOCK);
+}
+
 static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_ctx_supported  = true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
@@ -4753,6 +4828,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.nway_reset		= ice_nway_reset,
 	.get_pauseparam		= ice_get_pauseparam,
 	.set_pauseparam		= ice_set_pauseparam,
+	.reset			= ice_ethtool_reset,
 	.get_rxfh_key_size	= ice_get_rxfh_key_size,
 	.get_rxfh_indir_size	= ice_get_rxfh_indir_size,
 	.get_rxfh		= ice_get_rxfh,
@@ -4805,6 +4881,7 @@ static const struct ethtool_ops ice_ethtool_repr_ops = {
 	.get_strings		= ice_repr_get_strings,
 	.get_ethtool_stats      = ice_repr_get_ethtool_stats,
 	.get_sset_count		= ice_repr_get_sset_count,
+	.reset			= ice_repr_ethtool_reset,
 };
 
 /**
-- 
2.40.1


