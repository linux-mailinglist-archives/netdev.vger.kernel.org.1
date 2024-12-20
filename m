Return-Path: <netdev+bounces-153799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C794F9F9B0E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA4818907B2
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804722912A;
	Fri, 20 Dec 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6rB0x96"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103022618F
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725769; cv=none; b=dWflHNWTd7Rge5x8cqTJm48uswyiOfAzOAKtsbflRk9NCFXmNcDfXB12rr/XbcmdfOY4Md2to06Ya/u8AL2sFHTkMJfmRx+nu8dRACHNLp0ny0ZZvC/HVlov/NkcCwxox2sKvuL92zyBDA4AkIuxEOLuySVPa7MR5i1Pzq4GQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725769; c=relaxed/simple;
	bh=ClH4mbYIilJIJr/kp6pw3IImjZTZi858Sm/M+Uvt7CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD7LoKm3bkjiHZb0+cnWL1mN3Mr5fFd9zhd2ZyIAvkP1mu/wGzfTMyXGgKfaksCutEoc9Klet5gxQTJvEVivzk8ZfRZd+i28ExsTv/EErxUepNbFZCrR83ocAUmPtI8vVdZeJflw1zAQ2CyUhsmVbHL067WxjEnGpeGUY6YXN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6rB0x96; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734725767; x=1766261767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ClH4mbYIilJIJr/kp6pw3IImjZTZi858Sm/M+Uvt7CY=;
  b=E6rB0x96mUzgrwMjX5RQXSS02rLNlqBRZ9EmjuJgdbryDx0f43QfeLk6
   U82HAAiLk4kRH5J/inyWoMD/df1xeHzGtKsmiMFtEeP+YvOJkZKA2GvZb
   DQ5qBGtUJJBIMjh1FQQMnoAohwrPjUYIaK8+TGuNQ//cTpKz6C1eUVFE5
   buOCfAPMx6UgtPmFPQ0UclSbaF8qwDMsSCa5X05M178PhsXFzPlO24mjo
   HhleToPoIaPtjOOLAg0Y/1PEmAiEi3RnT2x2bWvNmC75AXnGhVo1mfl1i
   bJinBJsgrn9EKp9GQ7IX3jsf250hhz6eP8UmEriULOEY2nrb48NvpJcuq
   Q==;
X-CSE-ConnectionGUID: bzlWJzZBRc25TsaXrfTbFQ==
X-CSE-MsgGUID: AZWsOE/QScKguUS9iOaoSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46292414"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46292414"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:16:03 -0800
X-CSE-ConnectionGUID: hrJyBn6KR/iGcGh0MBak8A==
X-CSE-MsgGUID: n3Dzb55YTjKcYzVwRDxQ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102717110"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 12:16:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 07/10] ixgbe: Clean up the E610 link management related code
Date: Fri, 20 Dec 2024 12:15:12 -0800
Message-ID: <20241220201521.3363985-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
References: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Required for enabling the link management in E610 device.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 +++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 ++++++------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 13b777d702a2..2656f2617a8f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -237,6 +237,9 @@ static int ixgbe_get_parent_bus_info(struct ixgbe_adapter *adapter)
  * bandwidth details should be gathered from the parent bus instead of from the
  * device. Used to ensure that various locations all have the correct device ID
  * checks.
+ *
+ * Return: true if information should be collected from the parent bus, false
+ *         otherwise
  */
 static inline bool ixgbe_pcie_from_parent(struct ixgbe_hw *hw)
 {
@@ -5533,7 +5536,9 @@ static void ixgbe_sfp_link_config(struct ixgbe_adapter *adapter)
  * ixgbe_non_sfp_link_config - set up non-SFP+ link
  * @hw: pointer to private hardware struct
  *
- * Returns 0 on success, negative on failure
+ * Configure non-SFP link.
+ *
+ * Return: 0 on success, negative on failure
  **/
 static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 {
@@ -7222,11 +7227,11 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
 	for (i = 0; i < 16; i++) {
 		hwstats->qptc[i] += IXGBE_READ_REG(hw, IXGBE_QPTC(i));
 		hwstats->qprc[i] += IXGBE_READ_REG(hw, IXGBE_QPRC(i));
-		if ((hw->mac.type == ixgbe_mac_82599EB) ||
-		    (hw->mac.type == ixgbe_mac_X540) ||
-		    (hw->mac.type == ixgbe_mac_X550) ||
-		    (hw->mac.type == ixgbe_mac_X550EM_x) ||
-		    (hw->mac.type == ixgbe_mac_x550em_a)) {
+		if (hw->mac.type == ixgbe_mac_82599EB ||
+		    hw->mac.type == ixgbe_mac_X540 ||
+		    hw->mac.type == ixgbe_mac_X550 ||
+		    hw->mac.type == ixgbe_mac_X550EM_x ||
+		    hw->mac.type == ixgbe_mac_x550em_a) {
 			hwstats->qbtc[i] += IXGBE_READ_REG(hw, IXGBE_QBTC_L(i));
 			IXGBE_READ_REG(hw, IXGBE_QBTC_H(i)); /* to clear */
 			hwstats->qbrc[i] += IXGBE_READ_REG(hw, IXGBE_QBRC_L(i));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index d9a8cf018d3b..1de05443d3a2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3505,13 +3505,13 @@ static int ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	return status;
 }
 
-/** ixgbe_set_ethertype_anti_spoofing_X550 - Enable/Disable Ethertype
+/** ixgbe_set_ethertype_anti_spoofing_x550 - Enable/Disable Ethertype
  *	anti-spoofing
  *  @hw:  pointer to hardware structure
  *  @enable: enable or disable switch for Ethertype anti-spoofing
  *  @vf: Virtual Function pool - VF Pool to set for Ethertype anti-spoofing
  **/
-static void ixgbe_set_ethertype_anti_spoofing_X550(struct ixgbe_hw *hw,
+static void ixgbe_set_ethertype_anti_spoofing_x550(struct ixgbe_hw *hw,
 						   bool enable, int vf)
 {
 	int vf_target_reg = vf >> 3;
@@ -3527,12 +3527,12 @@ static void ixgbe_set_ethertype_anti_spoofing_X550(struct ixgbe_hw *hw,
 	IXGBE_WRITE_REG(hw, IXGBE_PFVFSPOOF(vf_target_reg), pfvfspoof);
 }
 
-/** ixgbe_set_source_address_pruning_X550 - Enable/Disbale src address pruning
+/** ixgbe_set_source_address_pruning_x550 - Enable/Disable src address pruning
  *  @hw: pointer to hardware structure
  *  @enable: enable or disable source address pruning
  *  @pool: Rx pool to set source address pruning for
  **/
-static void ixgbe_set_source_address_pruning_X550(struct ixgbe_hw *hw,
+static void ixgbe_set_source_address_pruning_x550(struct ixgbe_hw *hw,
 						  bool enable,
 						  unsigned int pool)
 {
@@ -3831,9 +3831,9 @@ static int ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	.set_mac_anti_spoofing		= &ixgbe_set_mac_anti_spoofing, \
 	.set_vlan_anti_spoofing		= &ixgbe_set_vlan_anti_spoofing, \
 	.set_source_address_pruning	= \
-				&ixgbe_set_source_address_pruning_X550, \
+				&ixgbe_set_source_address_pruning_x550, \
 	.set_ethertype_anti_spoofing	= \
-				&ixgbe_set_ethertype_anti_spoofing_X550, \
+				&ixgbe_set_ethertype_anti_spoofing_x550, \
 	.disable_rx_buff		= &ixgbe_disable_rx_buff_generic, \
 	.enable_rx_buff			= &ixgbe_enable_rx_buff_generic, \
 	.get_thermal_sensor_data	= NULL, \
-- 
2.47.1


