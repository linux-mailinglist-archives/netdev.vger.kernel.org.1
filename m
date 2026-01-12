Return-Path: <netdev+bounces-249049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D682D1312D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3D7430060E6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4567261B92;
	Mon, 12 Jan 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I87l8soC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13E2690EC
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227527; cv=none; b=ZOclqSLO6JbdjPgq6cK9zmumIHf2zaiY3E5AxOMScp+7gKrDR+hy7KNmvxwm4F0hkyzrzWILNZy+qSwp/ZMuB5c88AczBv4YsBlf0809iLG29wluzqha5qZ2IXim4VytLhJOm5Iv4OezBAOXbeFwT6OPxW+dKaPgNEgqr+7ct/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227527; c=relaxed/simple;
	bh=AXdINbRBuIy9g/76USC93YCAVLgclKx3SgzFPZ3UToQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqTwgpZKU+sSD+iHhO3aypdgytZ0yAM3SEhJqhk/B+LwvytjKow/i2DuYOBKDZ3JVPt5GsZYfbQdWD6Bl9SP7Zm0n2jHujaF+tqD5tWA2P68UbKqQub2NMSf9N7tzeBvle4dwVux9kdGscODZL8fw5jQeZWUcFw5vDbGbQGzR4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I87l8soC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768227525; x=1799763525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AXdINbRBuIy9g/76USC93YCAVLgclKx3SgzFPZ3UToQ=;
  b=I87l8soC6ktDrkr6TNVMlfcQ1TPdWL0cxqMHY6KRMxLqAFyqkpmC0txG
   tnJBsGThTRt/EfV+qm9OWaFkVQPGFqLfz3x8z5okHRuXyUK/xg4+7p3Kz
   xRoWsdYDHtFAsAucnV+BxG7YBm/pOkylMqBF/bisUHK1d9hxzfx4EBiad
   K0Y/j6S/2dQpSqoe8oiBaDfU5FJcrXQ9IdjWZio0Uiu3cEeBnWUnNZ5zF
   GxnqH9R3euroG+zTymQsum9JQdcdLpITqKajAHBykC2j8ADPrEo5HJURb
   wNSl/hxkmM6c0JR2OZDtq+oTkNczE9v4nRXXOX2BO7hE18mT8ohgGFsVn
   A==;
X-CSE-ConnectionGUID: CC7heANrTWG8yhrg5mwk7g==
X-CSE-MsgGUID: M6dgUBFoSLipUU+jXd+oOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352293"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73352293"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 06:18:45 -0800
X-CSE-ConnectionGUID: 4sI+qMeaTKu6tQwKVRxUDQ==
X-CSE-MsgGUID: mkXci2x4QDim20my20ZE1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="227355644"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:43 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 5/7] ixgbe: move EEE config validation out of ixgbe_set_eee()
Date: Mon, 12 Jan 2026 15:01:06 +0100
Message-Id: <20260112140108.1173835-6-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make this part of the code mode reusable move all
EEE input checks out of ixgbe_set_eee().

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 95 +++++++++++--------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 5764530b9667..7a7a58fd065d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3551,6 +3551,44 @@ static const struct {
 	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
+static int ixgbe_validate_keee(struct net_device *netdev,
+			       struct ethtool_keee *keee_requested)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ethtool_keee keee_stored = {};
+	int err;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE))
+		return -EOPNOTSUPP;
+
+	err = netdev->ethtool_ops->get_eee(netdev, &keee_stored);
+	if (err)
+		return err;
+
+	if (keee_stored.tx_lpi_enabled != keee_requested->tx_lpi_enabled) {
+		e_err(drv, "Setting EEE tx-lpi is not supported\n");
+		return -EINVAL;
+	}
+
+	if (keee_stored.tx_lpi_timer != keee_requested->tx_lpi_timer) {
+		e_err(drv,
+		      "Setting EEE Tx LPI timer is not supported\n");
+		return -EINVAL;
+	}
+
+	if (!linkmode_equal(keee_stored.advertised,
+			    keee_requested->advertised)) {
+		e_err(drv,
+		      "Setting EEE advertised speeds is not supported\n");
+		return -EINVAL;
+	}
+
+	if (keee_stored.eee_enabled == keee_requested->eee_enabled)
+		return -EALREADY;
+
+	return 0;
+}
+
 static int
 ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 {
@@ -3609,53 +3647,28 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	struct ethtool_keee eee_data;
 	int ret_val;
 
-	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE))
-		return -EOPNOTSUPP;
-
-	memset(&eee_data, 0, sizeof(struct ethtool_keee));
-
-	ret_val = ixgbe_get_eee(netdev, &eee_data);
-	if (ret_val)
+	ret_val = ixgbe_validate_keee(netdev, edata);
+	if (ret_val == -EALREADY)
+		return 0;
+	else if (ret_val)
 		return ret_val;
 
-	if (eee_data.eee_enabled && !edata->eee_enabled) {
-		if (eee_data.tx_lpi_enabled != edata->tx_lpi_enabled) {
-			e_err(drv, "Setting EEE tx-lpi is not supported\n");
-			return -EINVAL;
-		}
-
-		if (eee_data.tx_lpi_timer != edata->tx_lpi_timer) {
-			e_err(drv,
-			      "Setting EEE Tx LPI timer is not supported\n");
-			return -EINVAL;
-		}
-
-		if (!linkmode_equal(eee_data.advertised, edata->advertised)) {
-			e_err(drv,
-			      "Setting EEE advertised speeds is not supported\n");
-			return -EINVAL;
-		}
+	if (edata->eee_enabled) {
+		adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
+		hw->phy.eee_speeds_advertised =
+					   hw->phy.eee_speeds_supported;
+	} else {
+		adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
+		hw->phy.eee_speeds_advertised = 0;
 	}
 
-	if (eee_data.eee_enabled != edata->eee_enabled) {
-		if (edata->eee_enabled) {
-			adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
-			hw->phy.eee_speeds_advertised =
-						   hw->phy.eee_speeds_supported;
-		} else {
-			adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
-			hw->phy.eee_speeds_advertised = 0;
-		}
-
-		/* reset link */
-		if (netif_running(netdev))
-			ixgbe_reinit_locked(adapter);
-		else
-			ixgbe_reset(adapter);
-	}
+	/* reset link */
+	if (netif_running(netdev))
+		ixgbe_reinit_locked(adapter);
+	else
+		ixgbe_reset(adapter);
 
 	return 0;
 }
-- 
2.31.1


