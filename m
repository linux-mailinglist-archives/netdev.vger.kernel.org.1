Return-Path: <netdev+bounces-115756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769D947B3A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D58B2173B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE1B15666C;
	Mon,  5 Aug 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIiAmziC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617901803A
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862165; cv=none; b=jDq1b18hYVM3KO8YCQg7vho2mggvW8TZPUcOnN3h/hOX3ZZuzLW6v0QbI75/FwQnoMlYs4dVstwthk6elQcAjGkcF4GWJRTPY/oG4P0684NmQvExCDe91nkB83oeW1OScgVwTpeBkEjpGxmn59Z5kXhjWk5j4ha95jEQdWREtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862165; c=relaxed/simple;
	bh=PiLm9bPRE4bswuvkxe9Aicuep+TbFpE1u+KZP8w8+/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkOpkNrOa7au/xEk837IN7M3bWG2MXvirYOw2T9w0+AmBBDVwMaZQy5bQCbx9tFyTvKSNcSx4SaQZH+6X9soDILjEKGlcvKePVJk0P6u+Wm57GJ/TC1c4h1d/Nvhfmkfymq60TYpZmlVwJFOBPjT50Lj1crSHWMtYtemFTfvNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIiAmziC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722862163; x=1754398163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PiLm9bPRE4bswuvkxe9Aicuep+TbFpE1u+KZP8w8+/w=;
  b=oIiAmziCBTp+IHiGpbUedS6S7/uCPJPpqVzo154kLxzSNlb10PJixgxq
   ccU/GSZ1l8tWIxBUiSelxFLSui7Q+WYIvnSpzZnI1xwiuVVDHLgcEYvSw
   QGzwSju5UttefImZv8wWrnAUguFtb6TgZUMmdpkNhzrXEJBu2Oc0dq2EB
   aMvoLOeLF1lY35rX1vBwfabqvriUdOXHer6e4nA6N4Y/6RauOxKY1DhoM
   gUzHzn8LCbU583UGFlkF8WEpuJA4a5LAWBcrOa1aYqosttym7ymJUcCnU
   o0wQUG72om1C9f5pdgkWBgBvjcqbfwiZ247NwT0W6atYXtOdcWwOLzi++
   A==;
X-CSE-ConnectionGUID: kXEZiRzDSwa6mngEHEl+HQ==
X-CSE-MsgGUID: S5qtc5S7Q1i4+bHVVOG8mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="12870888"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="12870888"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 05:49:23 -0700
X-CSE-ConnectionGUID: 4Dv2BeK6R8+7ju42lzXuoQ==
X-CSE-MsgGUID: SrFvJRiNTvKgVpbaRl1eog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="60294031"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 05 Aug 2024 05:49:20 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3A5ED27BC6;
	Mon,  5 Aug 2024 13:49:19 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-next v2] ice: Implement ethtool reset support
Date: Mon,  5 Aug 2024 14:46:51 +0200
Message-Id: <20240805124651.125761-1-wojciech.drewek@intel.com>
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
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 .../device_drivers/ethernet/intel/ice.rst     | 28 +++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 77 +++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 934752f675ba..c043164bfacc 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -102,6 +102,34 @@ rx_bytes as "X", then ethtool (hardware statistics) will display rx_bytes as
 "X+40" (4 bytes CRC x 10 packets).
 
 
+ethtool reset
+-------------
+The driver supports 3 types of resets:
+- PF reset - resets only components associated with the given PF, does not
+  impact other PFs
+- CORE reset - whole adapter is affected, reset all PFs
+- GLOBAL reset - same as CORE but mac and phy components are also reinitialized
+
+These are mapped to ethtool reset flags as follow:
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
+
 Viewing Link Messages
 ---------------------
 Link messages will not be displayed to the console if the distribution is
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 39d2652c3ee1..14f4bd9397c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4794,6 +4794,81 @@ static void ice_get_ts_stats(struct net_device *netdev,
 	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
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
@@ -4829,6 +4904,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.nway_reset		= ice_nway_reset,
 	.get_pauseparam		= ice_get_pauseparam,
 	.set_pauseparam		= ice_set_pauseparam,
+	.reset			= ice_ethtool_reset,
 	.get_rxfh_key_size	= ice_get_rxfh_key_size,
 	.get_rxfh_indir_size	= ice_get_rxfh_indir_size,
 	.get_rxfh		= ice_get_rxfh,
@@ -4885,6 +4961,7 @@ static const struct ethtool_ops ice_ethtool_repr_ops = {
 	.get_strings		= ice_repr_get_strings,
 	.get_ethtool_stats      = ice_repr_get_ethtool_stats,
 	.get_sset_count		= ice_repr_get_sset_count,
+	.reset			= ice_repr_ethtool_reset,
 };
 
 /**
-- 
2.40.1


