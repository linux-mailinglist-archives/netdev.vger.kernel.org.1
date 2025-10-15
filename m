Return-Path: <netdev+bounces-229749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8EBE07C2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A255A507FED
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CEA33EAE9;
	Wed, 15 Oct 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H62bC3vI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842BA3128D9;
	Wed, 15 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556813; cv=none; b=IUM8/2ucrcIbv2/lKUDgboWWLm57KQf8AMBhfh0jy2NfBGRRHQHz9hPwsH4KUb+AyoU1c/EJ+isUF6lkVyLMRXqb6/NjvhirRpJtIUnlWdLCD78thpKr32RZfS8LqLap7CONjK51mLBN0qE5vvRchog1m3swUE79NNsN3GR24KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556813; c=relaxed/simple;
	bh=0YPZ8kN0xDFzPx4eOmBQGeoHeFzYLj3kTyvDZYdZ/K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfZCwCfqnGEvVNiL0glVie9TYebgkgagh6Y73iwCtT951FuF9YLXrN+7UTSaCcGLyY3pbnyj16lkvrI9pawxXtE2HVSrPLFonmhAn12zKsRqtK+SecKxEsF0Kmjnjr9qgQW5DykVJ4oeqG6oERDFA6whOWmkhfAB9g5QVjkUeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H62bC3vI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556810; x=1792092810;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0YPZ8kN0xDFzPx4eOmBQGeoHeFzYLj3kTyvDZYdZ/K0=;
  b=H62bC3vIJNMk0xhLINPYrZyOO88O40RxM2xbDJ57pyDPJqC2THVXWKWe
   POtgnnSxX2OcNZ2sW0jg3kDHBwypOn6fdXkp3VufoBZJ6dBC2CvOPK8EA
   Bd/Swc2YMqY77z4+dMzgse8CLHSzqletai9KYVlVYrkB3j5rY5FbKUAuB
   joV8vL41/TjzWLGF5GDndERe1pOWYKBcN1UvD6Zpug8pSG7lSj0q2+uMb
   uVXNIAhJNuv4wUZ19EtUMf4BIFzObSAXYGc710cVBFcyTLVyNkrPPiCBJ
   MaLop43O+ui4L+PgJCPFIBwATlJpVdXw1lLzFG4FNyxI+Fpz9/GtfjAJ7
   g==;
X-CSE-ConnectionGUID: NyMOs1oIRjC+uizRNuvmOA==
X-CSE-MsgGUID: hiTP5rB3QbqkA8HsZd7k6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74083581"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74083581"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:16 -0700
X-CSE-ConnectionGUID: Xgd/AHWKTo6/6bJgkG/ZOw==
X-CSE-MsgGUID: O27QGzv8QyWLVHORrObKww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182044913"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 15 Oct 2025 12:32:10 -0700
Subject: [PATCH net-next 14/14] e1000e: Introduce private flag to disable
 K1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251015-jk-iwl-next-2025-10-15-v1-14-79c70b9ddab8@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
In-Reply-To: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 =?utf-8?q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Dima Ruinskiy <dima.ruinskiy@intel.com>, 
 Avraham Koren <Avrahamx.koren@intel.com>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=8780;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=oAY1c4dYNUs/VsyRZ8VffpRmz9QaW5ieBWzoumsBvf0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz3334eamx2P933bp608SyZ4Gl1vYUNHuV/ppzZs5Y/7
 Nh8LqPMjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbyvI/hN5vBk0V5zsbvnhyP
 LDTkusn2s5dX3C6hpfuk4tkyM5OGWQz/tFaUBumuO8/Ml8drs/zZy45tMmoPn9X1LNoStK5QZF4
 +DwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

The K1 state reduces power consumption on ICH family network controllers
during idle periods, similarly to L1 state on PCI Express NICs. Therefore,
it is recommended and enabled by default.
However, on some systems it has been observed to have adverse side
effects, such as packet loss. It has been established through debug that
the problem may be due to firmware misconfiguration of specific systems,
interoperability with certain link partners, or marginal electrical
conditions of specific units.

These problems typically cannot be fixed in the field, and generic
workarounds to resolve the side effects on all systems, while keeping K1
enabled, were found infeasible.
Therefore, add the option for users to globally disable K1 idle state on
the adapter.

Additionally, disable K1 by default for MTL and later platforms, due to
issues reported with the current configuration.

Link: https://lore.kernel.org/intel-wired-lan/CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.com/
Link: https://lore.kernel.org/intel-wired-lan/20250626153544.1853d106@onyx.my.domain/
Link: https://lore.kernel.org/intel-wired-lan/Z_z9EjcKtwHCQcZR@mail-itl/
Link: https://github.com/QubesOS/qubes-issues/issues/9896
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2115393

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Timo Teräs <timo.teras@iki.fi>
Tested-by: Timo Teräs <timo.teras@iki.fi>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Avraham Koren <Avrahamx.koren@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   |  1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c | 45 +++++++++++++++++++++++++----
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 41 ++++++++++++++------------
 drivers/net/ethernet/intel/e1000e/netdev.c  |  3 ++
 4 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 018e61aea787..aa08f397988e 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -461,6 +461,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
 #define FLAG2_CHECK_RX_HWTSTAMP           BIT(13)
 #define FLAG2_CHECK_SYSTIM_OVERFLOW       BIT(14)
 #define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
+#define FLAG2_DISABLE_K1		   BIT(16)
 
 #define E1000_RX_DESC_PS(R, i)	    \
 	(&(((union e1000_rx_desc_packet_split *)((R).desc))[i]))
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 8e40bb50a01e..cee57a2149ab 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -26,6 +26,8 @@ struct e1000_stats {
 static const char e1000e_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define E1000E_PRIV_FLAGS_S0IX_ENABLED	BIT(0)
 	"s0ix-enabled",
+#define E1000E_PRIV_FLAGS_DISABLE_K1	BIT(1)
+	"disable-k1",
 };
 
 #define E1000E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(e1000e_priv_flags_strings)
@@ -2301,26 +2303,59 @@ static u32 e1000e_get_priv_flags(struct net_device *netdev)
 	if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
 		priv_flags |= E1000E_PRIV_FLAGS_S0IX_ENABLED;
 
+	if (adapter->flags2 & FLAG2_DISABLE_K1)
+		priv_flags |= E1000E_PRIV_FLAGS_DISABLE_K1;
+
 	return priv_flags;
 }
 
 static int e1000e_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
+	struct e1000_hw *hw = &adapter->hw;
 	unsigned int flags2 = adapter->flags2;
+	unsigned int changed;
+
+	flags2 &= ~(FLAG2_ENABLE_S0IX_FLOWS | FLAG2_DISABLE_K1);
 
-	flags2 &= ~FLAG2_ENABLE_S0IX_FLOWS;
 	if (priv_flags & E1000E_PRIV_FLAGS_S0IX_ENABLED) {
-		struct e1000_hw *hw = &adapter->hw;
-
-		if (hw->mac.type < e1000_pch_cnp)
+		if (hw->mac.type < e1000_pch_cnp) {
+			e_err("S0ix is not supported on this device\n");
 			return -EINVAL;
+		}
+
 		flags2 |= FLAG2_ENABLE_S0IX_FLOWS;
 	}
 
-	if (flags2 != adapter->flags2)
+	if (priv_flags & E1000E_PRIV_FLAGS_DISABLE_K1) {
+		if (hw->mac.type < e1000_ich8lan) {
+			e_err("Disabling K1 is not supported on this device\n");
+			return -EINVAL;
+		}
+
+		flags2 |= FLAG2_DISABLE_K1;
+	}
+
+	changed = adapter->flags2 ^ flags2;
+	if (changed)
 		adapter->flags2 = flags2;
 
+	if (changed & FLAG2_DISABLE_K1) {
+		/* reset the hardware to apply the changes */
+		while (test_and_set_bit(__E1000_RESETTING,
+					&adapter->state))
+			usleep_range(1000, 2000);
+
+		if (netif_running(adapter->netdev)) {
+			e1000e_down(adapter, true);
+			e1000e_up(adapter);
+		} else {
+			e1000e_reset(adapter);
+		}
+
+		clear_bit(__E1000_RESETTING, &adapter->state);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index df4e7d781cb1..0ff8688ac3b8 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -286,21 +286,26 @@ static void e1000_toggle_lanphypc_pch_lpt(struct e1000_hw *hw)
 }
 
 /**
- * e1000_reconfigure_k1_exit_timeout - reconfigure K1 exit timeout to
- * align to MTP and later platform requirements.
+ * e1000_reconfigure_k1_params - reconfigure Kumeran K1 parameters.
  * @hw: pointer to the HW structure
  *
+ * By default K1 is enabled after MAC reset, so this function only
+ * disables it.
+ *
  * Context: PHY semaphore must be held by caller.
  * Return: 0 on success, negative on failure
  */
-static s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
+static s32 e1000_reconfigure_k1_params(struct e1000_hw *hw)
 {
 	u16 phy_timeout;
 	u32 fextnvm12;
 	s32 ret_val;
 
-	if (hw->mac.type < e1000_pch_mtp)
+	if (hw->mac.type < e1000_pch_mtp) {
+		if (hw->adapter->flags2 & FLAG2_DISABLE_K1)
+			return e1000_configure_k1_ich8lan(hw, false);
 		return 0;
+	}
 
 	/* Change Kumeran K1 power down state from P0s to P1 */
 	fextnvm12 = er32(FEXTNVM12);
@@ -310,6 +315,8 @@ static s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
 
 	/* Wait for the interface the settle */
 	usleep_range(1000, 1100);
+	if (hw->adapter->flags2 & FLAG2_DISABLE_K1)
+		return e1000_configure_k1_ich8lan(hw, false);
 
 	/* Change K1 exit timeout */
 	ret_val = e1e_rphy_locked(hw, I217_PHY_TIMEOUTS_REG,
@@ -373,8 +380,8 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		/* At this point the PHY might be inaccessible so don't
 		 * propagate the failure
 		 */
-		if (e1000_reconfigure_k1_exit_timeout(hw))
-			e_dbg("Failed to reconfigure K1 exit timeout\n");
+		if (e1000_reconfigure_k1_params(hw))
+			e_dbg("Failed to reconfigure K1 parameters\n");
 
 		fallthrough;
 	case e1000_pch_lpt:
@@ -473,10 +480,10 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		if (hw->mac.type >= e1000_pch_mtp) {
 			ret_val = hw->phy.ops.acquire(hw);
 			if (ret_val) {
-				e_err("Failed to reconfigure K1 exit timeout\n");
+				e_err("Failed to reconfigure K1 parameters\n");
 				goto out;
 			}
-			ret_val = e1000_reconfigure_k1_exit_timeout(hw);
+			ret_val = e1000_reconfigure_k1_params(hw);
 			hw->phy.ops.release(hw);
 		}
 	}
@@ -4948,17 +4955,15 @@ static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 	u16 i;
 
 	e1000_initialize_hw_bits_ich8lan(hw);
-	if (hw->mac.type >= e1000_pch_mtp) {
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
+	ret_val = hw->phy.ops.acquire(hw);
+	if (ret_val)
+		return ret_val;
 
-		ret_val = e1000_reconfigure_k1_exit_timeout(hw);
-		hw->phy.ops.release(hw);
-		if (ret_val) {
-			e_dbg("Error failed to reconfigure K1 exit timeout\n");
-			return ret_val;
-		}
+	ret_val = e1000_reconfigure_k1_params(hw);
+	hw->phy.ops.release(hw);
+	if (ret_val) {
+		e_dbg("Error failed to reconfigure K1 parameters\n");
+		return ret_val;
 	}
 
 	/* Initialize identification LED */
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 201322dac233..116f3c92b5bc 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7675,6 +7675,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* init PTP hardware clock */
 	e1000e_ptp_init(adapter);
 
+	if (hw->mac.type >= e1000_pch_mtp)
+		adapter->flags2 |= FLAG2_DISABLE_K1;
+
 	/* reset the hardware with the new settings */
 	e1000e_reset(adapter);
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


