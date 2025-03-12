Return-Path: <netdev+bounces-174208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8EA5DDA9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA01C189EE21
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FFE245021;
	Wed, 12 Mar 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDcPymb7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74027251797
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785199; cv=none; b=nCsF3/ymYv0seNJEdGhMXRqD9idFjs6D8hJI+uRSVSYRSGOXH4WO/fKVdVWcwkr1m2IMDrK+z5LdNGpqlxhpKcV7aoVdK7f5PLGb1MAZWC9haBB4/FybC2+IbXry9VKfLCLuYN0yHfCHbrjjHr1xP0iHRNODGzqstfIQhzg085M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785199; c=relaxed/simple;
	bh=F4lLfSGiLt2yRItrqfitTxRGCpqwDwCy3FuuWP5+s3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1iXqSOY6CD+/wDqHR49KOeCKEFrTZlAbYN7FUvoMo9Zyx7Vgge3GsKeWlzcwxK+MkfB6NCoUyC2jsEeoxDbU/QF3MGdBJTruNb40WI0BMddU95vrvyVkHwf6fK2gSxOWW4hZnZggjY1TLIFx9nW9RezkgZtR/UQHnkgARD74zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDcPymb7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741785198; x=1773321198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4lLfSGiLt2yRItrqfitTxRGCpqwDwCy3FuuWP5+s3k=;
  b=CDcPymb7xkfBh4ShJcR97zXZMkJgdrjNwBGHq+sLBZvlg1aZdcJdsYFI
   HR9Ia8sBybY15nM1nXc/Jmv1uElKirfiqSA/LWnglBGbTFu0mWNU38B8p
   qlRjfdVWgqHY7rVOfOsrwjB0Hgz2mX4IY7pJo+yXnfn/QivFIXGIp7033
   7KJj2EGsVAdWSWY2IjPhgnIw+NoyPRGBYABuTEQFTcXZ9VxG92VXahE6Q
   qYW35jZNsa3/fOc1GizZ/DS1zGwDTMorLlqEkwjTvVyaCDMmVxoZjKZjR
   RhQe+S2OQf+RYoNkeRvlAh4v9Aqd9HzruaWl2cdnbdDmBzCM/C5hzYM/g
   A==;
X-CSE-ConnectionGUID: PSNhTq23QhC/wlflP31L3g==
X-CSE-MsgGUID: 7G90bWcYTKGrsL8fOr3YJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53510723"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53510723"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 06:13:17 -0700
X-CSE-ConnectionGUID: 7GK+Q6TyQ0yVmv6DdBFl6g==
X-CSE-MsgGUID: 8elS5De6R+Ot5h60CJFvkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="121542156"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2025 06:13:15 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Bharath R <bharath.r@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: [PATCH iwl-next v7 09/15] ixgbe: add E610 functions getting PBA and FW ver info
Date: Wed, 12 Mar 2025 13:58:37 +0100
Message-Id: <20250312125843.347191-10-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
References: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce 2 E610 specific callbacks implementations:
-ixgbe_start_hw_e610() which expands the regular .start_hw callback with
getting FW version information
-ixgbe_read_pba_string_e610() which gets Product Board Assembly string

Extend EEPROM ops with new .read_pba_string in order to distinguish
generic one and the E610 one.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v7: add .init_params() callback implementation
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 184 +++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   2 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   1 +
 10 files changed, 194 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 365310a6910d..8f44c3dee0b5 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -198,7 +198,7 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	if (err)
 		goto free_ctx;
 
-	err = ixgbe_read_pba_string_generic(hw, ctx->buf, sizeof(ctx->buf));
+	err = hw->eeprom.ops.read_pba_string(hw, ctx->buf, sizeof(ctx->buf));
 	if (err)
 		goto free_ctx;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 4aaaea3b5f8f..444da982593f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -1169,6 +1169,7 @@ static const struct ixgbe_eeprom_operations eeprom_ops_82598 = {
 	.calc_checksum          = &ixgbe_calc_eeprom_checksum_generic,
 	.validate_checksum	= &ixgbe_validate_eeprom_checksum_generic,
 	.update_checksum	= &ixgbe_update_eeprom_checksum_generic,
+	.read_pba_string        = &ixgbe_read_pba_string_generic,
 };
 
 static const struct ixgbe_phy_operations phy_ops_82598 = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 964988b4d58b..d5b1b974b4a3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -2230,6 +2230,7 @@ static const struct ixgbe_eeprom_operations eeprom_ops_82599 = {
 	.calc_checksum		= &ixgbe_calc_eeprom_checksum_generic,
 	.validate_checksum	= &ixgbe_validate_eeprom_checksum_generic,
 	.update_checksum	= &ixgbe_update_eeprom_checksum_generic,
+	.read_pba_string        = &ixgbe_read_pba_string_generic,
 };
 
 static const struct ixgbe_phy_operations phy_ops_82599 = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 7beaf6ea57f9..5784d5d1896e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -332,6 +332,7 @@ int ixgbe_start_hw_generic(struct ixgbe_hw *hw)
  * Devices in the second generation:
  *     82599
  *     X540
+ *     E610
  **/
 int ixgbe_start_hw_gen2(struct ixgbe_hw *hw)
 {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index b34570b244d9..457d1f4b8784 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -343,6 +343,41 @@ void ixgbe_fill_dflt_direct_cmd_desc(struct ixgbe_aci_desc *desc, u16 opcode)
 	desc->flags = cpu_to_le16(IXGBE_ACI_FLAG_SI);
 }
 
+/**
+ * ixgbe_aci_get_fw_ver - Get the firmware version
+ * @hw: pointer to the HW struct
+ *
+ * Get the firmware version using ACI command (0x0001).
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_aci_get_fw_ver(struct ixgbe_hw *hw)
+{
+	struct ixgbe_aci_cmd_get_ver *resp;
+	struct ixgbe_aci_desc desc;
+	int err;
+
+	resp = &desc.params.get_ver;
+
+	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_get_ver);
+
+	err = ixgbe_aci_send_cmd(hw, &desc, NULL, 0);
+
+	if (!err) {
+		hw->fw_branch = resp->fw_branch;
+		hw->fw_maj_ver = resp->fw_major;
+		hw->fw_min_ver = resp->fw_minor;
+		hw->fw_patch = resp->fw_patch;
+		hw->fw_build = le32_to_cpu(resp->fw_build);
+		hw->api_branch = resp->api_branch;
+		hw->api_maj_ver = resp->api_major;
+		hw->api_min_ver = resp->api_minor;
+		hw->api_patch = resp->api_patch;
+	}
+
+	return err;
+}
+
 /**
  * ixgbe_aci_req_res - request a common resource
  * @hw: pointer to the HW struct
@@ -1410,6 +1445,32 @@ int ixgbe_configure_lse(struct ixgbe_hw *hw, bool activate, u16 mask)
 	return ixgbe_aci_get_link_info(hw, activate, NULL);
 }
 
+/**
+ * ixgbe_start_hw_e610 - Prepare hardware for Tx/Rx
+ * @hw: pointer to hardware structure
+ *
+ * Get firmware version and start the hardware using the generic
+ * start_hw() and ixgbe_start_hw_gen2() functions.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_start_hw_e610(struct ixgbe_hw *hw)
+{
+	int err;
+
+	err = ixgbe_aci_get_fw_ver(hw);
+	if (err)
+		return err;
+
+	err = ixgbe_start_hw_generic(hw);
+	if (err)
+		return err;
+
+	ixgbe_start_hw_gen2(hw);
+
+	return err;
+}
+
 /**
  * ixgbe_get_media_type_e610 - Gets media type
  * @hw: pointer to the HW struct
@@ -3369,9 +3430,128 @@ int ixgbe_reset_hw_e610(struct ixgbe_hw *hw)
 	return err;
 }
 
+/**
+ * ixgbe_get_pfa_module_tlv - Read sub module TLV from NVM PFA
+ * @hw: pointer to hardware structure
+ * @module_tlv: pointer to module TLV to return
+ * @module_tlv_len: pointer to module TLV length to return
+ * @module_type: module type requested
+ *
+ * Find the requested sub module TLV type from the Preserved Field
+ * Area (PFA) and returns the TLV pointer and length. The caller can
+ * use these to read the variable length TLV value.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
+				    u16 *module_tlv_len, u16 module_type)
+{
+	u16 pfa_len, pfa_ptr, pfa_end_ptr;
+	u16 next_tlv;
+	int err;
+
+	err = ixgbe_read_ee_aci_e610(hw, IXGBE_E610_SR_PFA_PTR, &pfa_ptr);
+	if (err)
+		return err;
+
+	err = ixgbe_read_ee_aci_e610(hw, pfa_ptr, &pfa_len);
+	if (err)
+		return err;
+
+	/* Starting with first TLV after PFA length, iterate through the list
+	 * of TLVs to find the requested one.
+	 */
+	next_tlv = pfa_ptr + 1;
+	pfa_end_ptr = pfa_ptr + pfa_len;
+	while (next_tlv < pfa_end_ptr) {
+		u16 tlv_sub_module_type, tlv_len;
+
+		/* Read TLV type */
+		err = ixgbe_read_ee_aci_e610(hw, next_tlv,
+					     &tlv_sub_module_type);
+		if (err)
+			break;
+
+		/* Read TLV length */
+		err = ixgbe_read_ee_aci_e610(hw, next_tlv + 1, &tlv_len);
+		if (err)
+			break;
+
+		if (tlv_sub_module_type == module_type) {
+			if (tlv_len) {
+				*module_tlv = next_tlv;
+				*module_tlv_len = tlv_len;
+				return 0;
+			}
+			return -EIO;
+		}
+		/* Check next TLV, i.e. current TLV pointer + length + 2 words
+		 * (for current TLV's type and length).
+		 */
+		next_tlv = next_tlv + tlv_len + 2;
+	}
+	/* Module does not exist */
+	return -ENODATA;
+}
+
+/**
+ * ixgbe_read_pba_string_e610 - Read PBA string from NVM
+ * @hw: pointer to hardware structure
+ * @pba_num: stores the part number string from the NVM
+ * @pba_num_size: part number string buffer length
+ *
+ * Read the part number string from the NVM.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_read_pba_string_e610(struct ixgbe_hw *hw, u8 *pba_num,
+				      u32 pba_num_size)
+{
+	u16 pba_tlv, pba_tlv_len;
+	u16 pba_word, pba_size;
+	int err;
+
+	*pba_num = '\0';
+
+	err = ixgbe_get_pfa_module_tlv(hw, &pba_tlv, &pba_tlv_len,
+				       IXGBE_E610_SR_PBA_BLOCK_PTR);
+	if (err)
+		return err;
+
+	/* pba_size is the next word */
+	err = ixgbe_read_ee_aci_e610(hw, (pba_tlv + 2), &pba_size);
+	if (err)
+		return err;
+
+	if (pba_tlv_len < pba_size)
+		return -EINVAL;
+
+	/* Subtract one to get PBA word count (PBA Size word is included in
+	 * total size).
+	 */
+	pba_size--;
+
+	if (pba_num_size < (((u32)pba_size * 2) + 1))
+		return -EINVAL;
+
+	for (u16 i = 0; i < pba_size; i++) {
+		err = ixgbe_read_ee_aci_e610(hw, (pba_tlv + 2 + 1) + i,
+					     &pba_word);
+		if (err)
+			return err;
+
+		pba_num[(i * 2)] = FIELD_GET(IXGBE_E610_SR_PBA_BLOCK_MASK, pba_word);
+		pba_num[(i * 2) + 1] = pba_word & 0xFF;
+	}
+
+	pba_num[(pba_size * 2)] = '\0';
+
+	return err;
+}
+
 static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.init_hw			= ixgbe_init_hw_generic,
-	.start_hw			= ixgbe_start_hw_X540,
+	.start_hw			= ixgbe_start_hw_e610,
 	.clear_hw_cntrs			= ixgbe_clear_hw_cntrs_generic,
 	.enable_rx_dma			= ixgbe_enable_rx_dma_generic,
 	.get_mac_addr			= ixgbe_get_mac_addr_generic,
@@ -3436,6 +3616,8 @@ static const struct ixgbe_eeprom_operations eeprom_ops_e610 = {
 	.read				= ixgbe_read_ee_aci_e610,
 	.read_buffer			= ixgbe_read_ee_aci_buffer_e610,
 	.validate_checksum		= ixgbe_validate_eeprom_checksum_e610,
+	.read_pba_string		= ixgbe_read_pba_string_e610,
+	.init_params			= ixgbe_init_eeprom_params_e610,
 };
 
 const struct ixgbe_info ixgbe_e610_info = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a6bddea6b482..d853d10ccccb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6846,7 +6846,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	adapter->tx_work_limit = IXGBE_DEFAULT_TX_WORK;
 
 	/* initialize eeprom parameters */
-	if (ixgbe_init_eeprom_params_generic(hw)) {
+	if (hw->eeprom.ops.init_params(hw)) {
 		e_dev_err("EEPROM initialization failed\n");
 		return -EIO;
 	}
@@ -11600,7 +11600,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (expected_gts > 0)
 		ixgbe_check_minimum_link(adapter, expected_gts);
 
-	err = ixgbe_read_pba_string_generic(hw, part_str, sizeof(part_str));
+	err = hw->eeprom.ops.read_pba_string(hw, part_str, sizeof(part_str));
 	if (err)
 		strscpy(part_str, "Unknown", sizeof(part_str));
 	if (ixgbe_is_sfp(hw) && hw->phy.sfp_type != ixgbe_sfp_type_not_present)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 5fdf32d79d82..5f814f023573 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3446,6 +3446,8 @@ struct ixgbe_eeprom_operations {
 	int (*validate_checksum)(struct ixgbe_hw *, u16 *);
 	int (*update_checksum)(struct ixgbe_hw *);
 	int (*calc_checksum)(struct ixgbe_hw *);
+	int (*read_pba_string)(struct ixgbe_hw *hw, u8 *pba_num,
+			       u32 pba_num_size);
 };
 
 struct ixgbe_mac_operations {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index a1c963cf7127..aa063d39091a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -12,6 +12,7 @@
 /* Checksum and Shadow RAM pointers */
 #define IXGBE_E610_SR_NVM_CTRL_WORD		0x00
 #define IXGBE_E610_SR_PBA_BLOCK_PTR		0x16
+#define IXGBE_E610_SR_PBA_BLOCK_MASK		GENMASK(15, 8)
 #define IXGBE_E610_SR_NVM_DEV_STARTER_VER	0x18
 #define IXGBE_E610_SR_NVM_EETRACK_LO		0x2D
 #define IXGBE_E610_SR_NVM_EETRACK_HI		0x2E
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index 1fc821fb351a..f1ab95aa8c83 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -894,6 +894,7 @@ static const struct ixgbe_eeprom_operations eeprom_ops_X540 = {
 	.calc_checksum		= &ixgbe_calc_eeprom_checksum_X540,
 	.validate_checksum      = &ixgbe_validate_eeprom_checksum_X540,
 	.update_checksum        = &ixgbe_update_eeprom_checksum_X540,
+	.read_pba_string        = &ixgbe_read_pba_string_generic,
 };
 
 static const struct ixgbe_phy_operations phy_ops_X540 = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 277ceaf8a793..1d2acdb64f45 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3959,6 +3959,7 @@ static const struct ixgbe_mac_operations mac_ops_x550em_a_fw = {
 	.validate_checksum	= &ixgbe_validate_eeprom_checksum_X550, \
 	.update_checksum	= &ixgbe_update_eeprom_checksum_X550, \
 	.calc_checksum		= &ixgbe_calc_eeprom_checksum_X550, \
+	.read_pba_string        = &ixgbe_read_pba_string_generic, \
 
 static const struct ixgbe_eeprom_operations eeprom_ops_X550 = {
 	X550_COMMON_EEP
-- 
2.31.1


