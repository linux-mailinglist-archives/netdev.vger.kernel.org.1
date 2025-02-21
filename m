Return-Path: <netdev+bounces-168532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A9BA3F3CA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45E84242AE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5320C000;
	Fri, 21 Feb 2025 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOtfmDJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2620CCE7
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139525; cv=none; b=ERuwb9OzE+uGbAlBw8F6A6hb9X0OIbM4nchsm5801bFBJPorTMzHGMhKDR/a0P2KIiIVRkdjd+iv+8zGaiRZQ7B5ecCobppnKg86YqphkxM2KziMtbCSjX8iYUlZCsy8DbNyORti0iHYFEBk6Op0i1//Ozkcyex35MeMf+f7GvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139525; c=relaxed/simple;
	bh=UB8k1AyLIpZYnaP6FCULE6VrrMRmaCyFv7xqZebE5K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPjhPIc+AQQlwvgc6bdHANk0fWJRDILxJ1NWWWBUX9/Gv+cmL+kn6r9Iyf5jboYvZZPIV9MOZWyeUrKR8slkpGrAWXUOX49Yd8tOWiu+FvJU9TiLcKx1+pJfQrOv76btTyai5FMT3VE0SGv5GWHkxItyfzCdH5WPbg1jHhCr8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOtfmDJ+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740139523; x=1771675523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UB8k1AyLIpZYnaP6FCULE6VrrMRmaCyFv7xqZebE5K4=;
  b=EOtfmDJ+4bT1lwdIW1iZt99kgECx5tUvt4H+waR7jgUBF56pejXulS69
   wCg2jwD/+lzunE4/ZsglcmQDk206aOn3D01FW1Bec7o0amnWVIARVKVwe
   lociJ5i7Ej0VQFPPHqDlmWG2ixA8FCVfTj1glTcl3wEstY/vHi0YEcOMY
   69stVVKPPKXpPE/lX57P3Cz2fJFhhK2NxMFxuOjzsiRWmx6d3vh8NLQAJ
   p5xAlb/sE36vSnyWkvk7NS+wCkycHstwBvqsLUautR3meS6XcKii+q33v
   7GCK10lzUYl4BJCJq9j5usGR3xlYqoJpkjL231AjvJT9ls+A+9DjtjSIM
   Q==;
X-CSE-ConnectionGUID: pkMvOrVZSYao4fNewdjWOQ==
X-CSE-MsgGUID: Mv0+mbszS6iD/lL+jkzBbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51598978"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51598978"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:05:23 -0800
X-CSE-ConnectionGUID: WDBpEXiCR3qZlccB7fBvUg==
X-CSE-MsgGUID: mDFnhjJTQJOSES79mbVRYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116260313"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 21 Feb 2025 04:05:20 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiri@nvidia.com,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v5 06/15] ixgbe: read the OROM version information
Date: Fri, 21 Feb 2025 12:51:07 +0100
Message-Id: <20250221115116.169158-7-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
References: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>

Add functions reading the OROM version info and use them
as a part of the setting NVM info procedure.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 172 ++++++++++++++++++
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  15 ++
 2 files changed, 187 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 3654b7e32cc8..bad4bc04bb66 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2582,6 +2582,35 @@ static int ixgbe_read_nvm_module(struct ixgbe_hw *hw,
 	return err;
 }
 
+/**
+ * ixgbe_read_orom_module - Read from the active Option ROM module
+ * @hw: pointer to the HW structure
+ * @bank: whether to read from active or inactive OROM module
+ * @offset: offset into the OROM module to read, in words
+ * @data: storage for returned word value
+ *
+ * Read the specified word from the active Option ROM module of the flash.
+ * Note that unlike the NVM module, the CSS data is stored at the end of the
+ * module instead of at the beginning.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_read_orom_module(struct ixgbe_hw *hw,
+				  enum ixgbe_bank_select bank,
+				  u32 offset, u16 *data)
+{
+	__le16 data_local;
+	int err;
+
+	err = ixgbe_read_flash_module(hw, bank, IXGBE_E610_SR_1ST_OROM_BANK_PTR,
+				      offset * sizeof(data_local),
+				      (u8 *)&data_local, sizeof(data_local));
+	if (!err)
+		*data = le16_to_cpu(data_local);
+
+	return err;
+}
+
 /**
  * ixgbe_get_nvm_css_hdr_len - Read the CSS header length
  * @hw: pointer to the HW struct
@@ -2678,6 +2707,143 @@ static int ixgbe_get_nvm_srev(struct ixgbe_hw *hw,
 	return 0;
 }
 
+/**
+ * ixgbe_get_orom_civd_data - Get the combo version information from Option ROM
+ * @hw: pointer to the HW struct
+ * @bank: whether to read from the active or inactive flash module
+ * @civd: storage for the Option ROM CIVD data.
+ *
+ * Searches through the Option ROM flash contents to locate the CIVD data for
+ * the image.
+ *
+ * Return: the exit code of the operation.
+ */
+static int
+ixgbe_get_orom_civd_data(struct ixgbe_hw *hw, enum ixgbe_bank_select bank,
+			 struct ixgbe_orom_civd_info *civd)
+{
+	struct ixgbe_orom_civd_info tmp;
+	u32 offset;
+	int err;
+
+	/* The CIVD section is located in the Option ROM aligned to 512 bytes.
+	 * The first 4 bytes must contain the ASCII characters "$CIV".
+	 * A simple modulo 256 sum of all of the bytes of the structure must
+	 * equal 0.
+	 */
+	for (offset = 0; (offset + SZ_512) <= hw->flash.banks.orom_size;
+	     offset += SZ_512) {
+		u8 sum = 0;
+		u32 i;
+
+		err = ixgbe_read_flash_module(hw, bank,
+					      IXGBE_E610_SR_1ST_OROM_BANK_PTR,
+					      offset,
+					      (u8 *)&tmp, sizeof(tmp));
+		if (err)
+			return err;
+
+		/* Skip forward until we find a matching signature */
+		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp.signature,
+			   sizeof(tmp.signature)))
+			continue;
+
+		/* Verify that the simple checksum is zero */
+		for (i = 0; i < sizeof(tmp); i++)
+			sum += ((u8 *)&tmp)[i];
+
+		if (sum)
+			return -EDOM;
+
+		*civd = tmp;
+		return 0;
+	}
+
+	return -ENODATA;
+}
+
+/**
+ * ixgbe_get_orom_srev - Read the security revision from the OROM CSS header
+ * @hw: pointer to the HW struct
+ * @bank: whether to read from active or inactive flash module
+ * @srev: storage for security revision
+ *
+ * Read the security revision out of the CSS header of the active OROM module
+ * bank.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_get_orom_srev(struct ixgbe_hw *hw,
+			       enum ixgbe_bank_select bank,
+			       u32 *srev)
+{
+	u32 orom_size_word = hw->flash.banks.orom_size / 2;
+	u32 css_start, hdr_len;
+	u16 srev_l, srev_h;
+	int err;
+
+	err = ixgbe_get_nvm_css_hdr_len(hw, bank, &hdr_len);
+	if (err)
+		return err;
+
+	if (orom_size_word < hdr_len)
+		return -EINVAL;
+
+	/* Calculate how far into the Option ROM the CSS header starts. Note
+	 * that ixgbe_read_orom_module takes a word offset.
+	 */
+	css_start = orom_size_word - hdr_len;
+	err = ixgbe_read_orom_module(hw, bank,
+				     css_start + IXGBE_NVM_CSS_SREV_L,
+				     &srev_l);
+	if (err)
+		return err;
+
+	err = ixgbe_read_orom_module(hw, bank,
+				     css_start + IXGBE_NVM_CSS_SREV_H,
+				     &srev_h);
+	if (err)
+		return err;
+
+	*srev = srev_h << 16 | srev_l;
+
+	return 0;
+}
+
+/**
+ * ixgbe_get_orom_ver_info - Read Option ROM version information
+ * @hw: pointer to the HW struct
+ * @bank: whether to read from the active or inactive flash module
+ * @orom: pointer to Option ROM info structure
+ *
+ * Read Option ROM version and security revision from the Option ROM flash
+ * section.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_get_orom_ver_info(struct ixgbe_hw *hw,
+				   enum ixgbe_bank_select bank,
+				   struct ixgbe_orom_info *orom)
+{
+	struct ixgbe_orom_civd_info civd;
+	u32 combo_ver;
+	int err;
+
+	err = ixgbe_get_orom_civd_data(hw, bank, &civd);
+	if (err)
+		return err;
+
+	combo_ver = le32_to_cpu(civd.combo_ver);
+
+	orom->major = (u8)FIELD_GET(IXGBE_OROM_VER_MASK, combo_ver);
+	orom->patch = (u8)FIELD_GET(IXGBE_OROM_VER_PATCH_MASK, combo_ver);
+	orom->build = (u16)FIELD_GET(IXGBE_OROM_VER_BUILD_MASK, combo_ver);
+
+	err = ixgbe_get_orom_srev(hw, bank, &orom->srev);
+
+	return err;
+}
+
 /**
  * ixgbe_get_nvm_ver_info - Read NVM version information
  * @hw: pointer to the HW struct
@@ -2768,6 +2934,12 @@ int ixgbe_get_flash_data(struct ixgbe_hw *hw)
 	err = ixgbe_get_nvm_ver_info(hw, IXGBE_ACTIVE_FLASH_BANK,
 				     &flash->nvm);
 
+	if (err)
+		return err;
+
+	err = ixgbe_get_orom_ver_info(hw, IXGBE_ACTIVE_FLASH_BANK,
+				      &flash->orom);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 1e4f18432e75..9b04075edd4a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -26,6 +26,11 @@
 #define IXGBE_E610_SR_NETLIST_BANK_PTR		0x46
 #define IXGBE_E610_SR_NETLIST_BANK_SIZE		0x47
 
+/* The OROM version topology */
+#define IXGBE_OROM_VER_PATCH_MASK		GENMASK_ULL(7, 0)
+#define IXGBE_OROM_VER_BUILD_MASK		GENMASK_ULL(23, 8)
+#define IXGBE_OROM_VER_MASK			GENMASK_ULL(31, 24)
+
 /* CSS Header words */
 #define IXGBE_NVM_CSS_HDR_LEN_L			0x02
 #define IXGBE_NVM_CSS_HDR_LEN_H			0x03
@@ -1014,6 +1019,16 @@ struct ixgbe_hw_caps {
 #define IXGBE_EXT_TOPO_DEV_IMG_PROG_EN	BIT(1)
 } __packed;
 
+#define IXGBE_OROM_CIV_SIGNATURE	"$CIV"
+
+struct ixgbe_orom_civd_info {
+	u8 signature[4];	/* Must match ASCII '$CIV' characters */
+	u8 checksum;		/* Simple modulo 256 sum of all structure bytes must equal 0 */
+	__le32 combo_ver;	/* Combo Image Version number */
+	u8 combo_name_len;	/* Length of the unicode combo image version string, max of 32 */
+	__le16 combo_name[32];	/* Unicode string representing the Combo Image version */
+};
+
 /* Function specific capabilities */
 struct ixgbe_hw_func_caps {
 	u32 num_allocd_vfs;		/* Number of allocated VFs */
-- 
2.31.1


