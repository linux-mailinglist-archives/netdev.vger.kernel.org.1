Return-Path: <netdev+bounces-123863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA8966B1C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3046A1F23C98
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763B1C1AB1;
	Fri, 30 Aug 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJ9l/YOg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422B1C1742
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051905; cv=none; b=eihJ4ZjgejcoohZ+yOEo09q1q3xQprleAyStUj5TrYE7fgYXDztTqSGd7IkzzkHwlxBwA80SvyIG6SiMzUKbLmMaBV+Q769/yWGcEOoW7pLElx8eZCuQ+QkYzAW5lazOWrAd3YGibtqBhSJlukA3lJ2K3pVs3Mr/BQ4xDNm+HTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051905; c=relaxed/simple;
	bh=pfHm8pEad+bj5kcY6uGHeb3zxGUNHWPcF2a7dP857I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rh1jJL6+pPtlBjgpTCpm+J8wXed4hSeKOitKw/6UJSG6u0Y+MEaCpdBx3xqhygC4+AcYDGgJ7Z8GJCC+D5Ys/PcfuoNeudWYWzmS8T9HHMV7mIux/sFj+4RwJHGAMh7xj1hJ48y6+fm5rZgu2jWBIwy1uUJfY1qk0xDKhE8N9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJ9l/YOg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725051903; x=1756587903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pfHm8pEad+bj5kcY6uGHeb3zxGUNHWPcF2a7dP857I0=;
  b=gJ9l/YOgwom9IcCQy0MNihcL5tDLH6wJ9ZXaTq0OPJe3gTq1tjKiqCuG
   0YAl4M/TxmJfX43AmSqgjRCD2ZdFA8oEb3apv/Pl87zUlu8ekzkoCNApd
   qgAt+KLRbjRc15Ef1TT97koqbkXUXzb+H0qK9uxLn6AeKLCEEMg0msbCV
   42mKiY24d69M5WkarxqCC/dUKkBWUZd1fDNP3oukmu7w7Og0Wauqh3SU6
   zO/u+/DIds8CjA+1iOT76Ukx/K5CDiRdfblQy0Rwmw+ySQ/mKyLfjtOuP
   g2Yc7Popa+CsatEHl89XlQtHZuUjdDAqokwtuAVSjNLcrjFj7BOECL4Ed
   Q==;
X-CSE-ConnectionGUID: Jyq2+PnARrm/xFxijtEpsg==
X-CSE-MsgGUID: Hi2seM3aS8KjQi4YaV0xag==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13304290"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13304290"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:05:01 -0700
X-CSE-ConnectionGUID: AAqRURvTQiG9aHoHY9mgRQ==
X-CSE-MsgGUID: clNlk1qvSra/N6CnVThR/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63625266"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 30 Aug 2024 14:05:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 6/6] i40e: Add Energy Efficient Ethernet ability for X710 Base-T/KR/KX cards
Date: Fri, 30 Aug 2024 14:04:48 -0700
Message-ID: <20240830210451.2375215-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Add "EEE: Enabled/Disabled" to dmesg for supported X710 Base-T/KR/KX
cards. According to the IEEE standard report the EEE ability and the
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 36 ++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 24 +++++++++++--
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d546567e0286..2089a0e172bf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_H_
 #define _I40E_H_
 
+#include <linux/linkmode.h>
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1d0d2e526adb..3a6bece623f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5641,6 +5641,26 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
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
@@ -5648,7 +5668,7 @@ static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
-	int status = 0;
+	int status;
 
 	/* Get initial PHY capabilities */
 	status = i40e_aq_get_phy_capabilities(hw, false, true, &phy_cfg, NULL);
@@ -5661,11 +5681,18 @@ static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
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
 
@@ -5681,10 +5708,11 @@ static int i40e_is_eee_param_supported(struct net_device *netdev,
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
index cbcfada7b357..03205eb9f925 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7264,6 +7264,26 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 }
 #endif /* CONFIG_I40E_DCB */
 
+static void i40e_print_link_message_eee(struct i40e_vsi *vsi,
+					const char *speed, const char *fc)
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
+
 /**
  * i40e_print_link_message - print link up or down
  * @vsi: the VSI for which link needs a message
@@ -7395,9 +7415,7 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
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
2.42.0


