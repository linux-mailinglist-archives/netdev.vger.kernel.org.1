Return-Path: <netdev+bounces-133358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C5995BB8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663CF288D4B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA721859A;
	Tue,  8 Oct 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHkqQsJY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF47216458;
	Tue,  8 Oct 2024 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430490; cv=none; b=AlTH/+KJVAQ8Yn3Uc3n00opFO5T7s9Agi9nu40sTR6dhN0jiikNcS2GLPrRgDPxSr/POSt4Q0F4iUEFxqE30X7dtAn3QpU5U6/r7DrBh9rUYp8BtfCvoaTZ0QFCwaAxGfWR/72zEB6NOzbMUl1syU/C10AaHFIbjQ1D++6mrtLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430490; c=relaxed/simple;
	bh=IDetDnaS6LoraSWjR4cq12PAA9VewtVbWrxTZYqMYe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJQMduMBBpUNTAgqsF3NPjWGz+z9CvkVr0AcO6b51dpx/27aYhUDh76EMSUgY068/X/L2U/YbkJwTYpch2vQWfH68RC/AvJG077kfs/Q6eV54/jORl0fV03GV3/dSw8Kb218VNPRG8SMMaXldl9h81OpCWqzHxJgeG3r9CH4URM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHkqQsJY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430489; x=1759966489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IDetDnaS6LoraSWjR4cq12PAA9VewtVbWrxTZYqMYe8=;
  b=PHkqQsJYghN++HSKWnimXBFLKOmzWKhRFAh6l1B98evSm24DFaJDEw82
   jOdNWZgyTjLvPveIb48kO/tSv/Iiv9wHpHmfGbxoeYpIiIZmX0krN5VsB
   P0bAyeTbPtAsFpCQiKxehaIbz8xdf+HvlQC4XWvpXKe1jeFnAFWQl8CUy
   j1ou6hvE8x+fH9dxTEsiAdow5tqIPmjWwnlg2KcA6G7WDlIXZyVYx7lox
   Cz7aNvb1OBVqOvPc6wbYX0v+BocEVIY5gDPKTYj5LNChMG1RdOlK8Chsa
   qc9pl0dN7pP2c/J8MfezJKFDG7JiEuMITBWpLgdySbOsNUwywnCKfWhGc
   A==;
X-CSE-ConnectionGUID: aDkCTd0kQ8uFl/zwkqAlwA==
X-CSE-MsgGUID: VgOUA6t2RoimQmFAGAJxpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779859"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779859"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:47 -0700
X-CSE-ConnectionGUID: 6jjIKvtSSb6kURotU7Rrdw==
X-CSE-MsgGUID: iM1smRucT9yLWBMzgrUs+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794176"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 01/12] ice: Implement ethtool reset support
Date: Tue,  8 Oct 2024 16:34:27 -0700
Message-ID: <20241008233441.928802-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

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
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index d5cc934d1359..2924ac61300d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4716,6 +4716,81 @@ static void ice_get_fec_stats(struct net_device *netdev,
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
@@ -4752,6 +4827,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.nway_reset		= ice_nway_reset,
 	.get_pauseparam		= ice_get_pauseparam,
 	.set_pauseparam		= ice_set_pauseparam,
+	.reset			= ice_ethtool_reset,
 	.get_rxfh_key_size	= ice_get_rxfh_key_size,
 	.get_rxfh_indir_size	= ice_get_rxfh_indir_size,
 	.get_rxfh		= ice_get_rxfh,
@@ -4804,6 +4880,7 @@ static const struct ethtool_ops ice_ethtool_repr_ops = {
 	.get_strings		= ice_repr_get_strings,
 	.get_ethtool_stats      = ice_repr_get_ethtool_stats,
 	.get_sset_count		= ice_repr_get_sset_count,
+	.reset			= ice_repr_ethtool_reset,
 };
 
 /**
-- 
2.42.0


