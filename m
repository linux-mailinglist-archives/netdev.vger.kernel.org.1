Return-Path: <netdev+bounces-119637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A29566DB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBFA1C204E8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78F15C14A;
	Mon, 19 Aug 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFbFKVJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF528373
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059681; cv=none; b=qCfk9Xnp7kzooiw+dMb5V5sU9DVEukN9BwVYQxerIDyqb3xMU+A6iI3W1mTOOZorn5alHCLOPPQn/LwF3i0aT+Qtfbd4FNbXEbMXSVgbNeiG/TpAXrX/gaoA6npqRCbS/vvHgrkW79+6LXeXKFzKBW5VrOmqDdZFzpbW4+y0aIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059681; c=relaxed/simple;
	bh=T8WThPouRabXOB4PlAbbOGFKVRHDj2T9p6hhLoSHQhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FZlDFCpyn8uC3W8tbplWpGdjZAnuKrEKk3OTSv1y5Az2zWESH30gZ8gy5hBX42utCa92EMAm8f80VWERTIn9EaDDmO3R1dkvlWiCGdJ5Vaz4cXM/0tO/5yX1HH1oGYV+dUGpFQm8h0Cn0c+WgCIt0ibdG6MdE1EpPkSFOmSmYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFbFKVJ/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724059679; x=1755595679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T8WThPouRabXOB4PlAbbOGFKVRHDj2T9p6hhLoSHQhw=;
  b=hFbFKVJ/frQwVO26c0CwAtyhUN/PE8GfJ+4DtciT61tb/S8iQ4k7soxT
   I+hjN+v3PeGWEoUJxXa0kWNNTSLJ5gntNDYzw/EK6YasPsCCNOU1PwVgU
   1x61FQ2a8Tu42fvBHJ7G4P3U7hd/VCKwYNUBYZzI5T5tE5dp38fFm6EOU
   DnfOPXUFfoKT12GXbYvZYLEvwIal/NLDGuhqyBKpo11GHRwcqCv4NjXHE
   A7vOjxekngI0smy6YtlnPd9GujZz0wKtv5u1GiaS1EzhZyn+zt5LeTkLV
   xzri/7NK2tsJMMJbotb5waUaVTCMKZ6ISxsp55wiQoCosgRCizM0Y4w7Z
   w==;
X-CSE-ConnectionGUID: OEEi7R3sTtelFzQzqpYKbA==
X-CSE-MsgGUID: Bo3HKQeOS7a6il1HDGNHjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21841935"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="21841935"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 02:27:59 -0700
X-CSE-ConnectionGUID: 1XTFY1D+SoWvqW8rxzrYtg==
X-CSE-MsgGUID: tryv5rn6Q+upwnN/50JV2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91088133"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 02:27:57 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next v3] i40e: Add Energy Efficient Ethernet ability for X710 Base-T/KR/KX cards
Date: Mon, 19 Aug 2024 11:27:56 +0200
Message-Id: <20240819092756.1113554-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "EEE: Enabled/Disabled" to dmesg for supported X710 Base-T/KR/KX cards.
According to the IEEE standard report the EEE ability and and the
EEE Link Partner ability. Use the kernel's 'ethtool_keee' structure
and report EEE link modes.

Example:
dmesg | grep 'NIC Link is'
ethtool --show-eee <device>

Before:
	NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None

        Supported EEE link modes:  Not reported
        Advertised EEE link modes:  Not reported
        Link partner advertised EEE link modes:  Not reported

After:
	NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None, EEE: Enabled

        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
                                   10000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
                                    10000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full
                                                 10000baseT/Full

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2->v3 removed double space from code
v1->v2 removed some not mandatory changes, some style improvements
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 36 ++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 23 ++++++++++--
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d546567..0f25a48 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
+#include <linux/linkmode.h>
 #include <linux/avf/virtchnl.h>
 #include <linux/net/intel/i40e_client.h>
 #include <net/devlink.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1d0d2e5..47c5d05 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5641,50 +5641,78 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
+static void i40e_eee_capability_to_kedata_supported(__le16 eee_capability_,
+						    unsigned long *supported)
+{
+	const int eee_capability = le16_to_cpu(eee_capability_);
+	static const int lut[] = {
+		ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+		ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+		ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+		ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+	};
+
+	linkmode_zero(supported);
+	for (unsigned int i = ARRAY_SIZE(lut); i--; )
+		if (eee_capability & BIT(i + 1))
+			linkmode_set_bit(lut[i], supported);
+}
+
 static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_aq_get_phy_abilities_resp phy_cfg;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
-	int status = 0;
+	int status;
 
 	/* Get initial PHY capabilities */
 	status = i40e_aq_get_phy_capabilities(hw, false, true, &phy_cfg, NULL);
 	if (status)
 		return -EAGAIN;
 
 	/* Check whether NIC configuration is compatible with Energy Efficient
 	 * Ethernet (EEE) mode.
 	 */
 	if (phy_cfg.eee_capability == 0)
 		return -EOPNOTSUPP;
 
+	i40e_eee_capability_to_kedata_supported(phy_cfg.eee_capability,
+						edata->supported);
+	linkmode_copy(edata->lp_advertised, edata->supported);
+
 	/* Get current configuration */
 	status = i40e_aq_get_phy_capabilities(hw, false, false, &phy_cfg, NULL);
 	if (status)
 		return -EAGAIN;
 
+	linkmode_zero(edata->advertised);
+	if (phy_cfg.eee_capability)
+		linkmode_copy(edata->advertised, edata->supported);
 	edata->eee_enabled = !!phy_cfg.eee_capability;
 	edata->tx_lpi_enabled = pf->stats.tx_lpi_status;
 
 	edata->eee_active = pf->stats.tx_lpi_status && pf->stats.rx_lpi_status;
 
 	return 0;
 }
 
 static int i40e_is_eee_param_supported(struct net_device *netdev,
 				       struct ethtool_keee *edata)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_ethtool_not_used {
-		u32 value;
+		bool value;
 		const char *name;
 	} param[] = {
-		{edata->tx_lpi_timer, "tx-timer"},
+		{!!(edata->advertised[0] & ~edata->supported[0]), "advertise"},
+		{!!edata->tx_lpi_timer, "tx-timer"},
 		{edata->tx_lpi_enabled != pf->stats.tx_lpi_status, "tx-lpi"}
 	};
 	int i;
@@ -5710,7 +5738,7 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	__le16 eee_capability;
-	int status = 0;
+	int status;
 
 	/* Deny parameters we don't support */
 	if (i40e_is_eee_param_supported(netdev, edata))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cbcfada..5c102f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7263,6 +7263,25 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 	return err;
 }
 #endif /* CONFIG_I40E_DCB */
+static void i40e_print_link_message_eee(struct i40e_vsi *vsi,
+			    const char *speed, const char *fc)
+{
+	struct ethtool_keee kedata;
+
+	memzero_explicit(&kedata, sizeof(kedata));
+	if (vsi->netdev->ethtool_ops->get_eee)
+		vsi->netdev->ethtool_ops->get_eee(vsi->netdev, &kedata);
+
+	if (!linkmode_empty(kedata.supported))
+		netdev_info(vsi->netdev,
+			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s, EEE: %s\n",
+			    speed, fc,
+			    kedata.eee_enabled ? "Enabled" : "Disabled");
+	else
+		netdev_info(vsi->netdev,
+			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s\n",
+			    speed, fc);
+}
 
 /**
  * i40e_print_link_message - print link up or down
@@ -7395,9 +7414,7 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 			    "NIC Link is Up, %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg: %s, Flow Control: %s\n",
 			    speed, req_fec, fec, an, fc);
 	} else {
-		netdev_info(vsi->netdev,
-			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s\n",
-			    speed, fc);
+		i40e_print_link_message_eee(vsi, speed, fc);
 	}
 
 }
-- 
2.25.1


