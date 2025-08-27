Return-Path: <netdev+bounces-217442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDDAB38B47
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B001C21859
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB92C2377;
	Wed, 27 Aug 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYyGemqb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB42192F4
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756329492; cv=none; b=e2/krBk/bUKcns6dWqBtGc3C0Dp56x1aYfTWUD3hdfRUI1UdYgG3u2d0yVerKjd3YXkRe0vJXx7Qmll9jUBvPDlcFQPdQmvPK7wo1jHNN+PsCrnn8CJ9tuLmobuZSlYjDS62oLnwd5uaMnL7myhEcxkKmDhIvC3sbNU0rEoY0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756329492; c=relaxed/simple;
	bh=tn6EVHu8sY4G0Bw0cvnGYUOHgfvWC1wVHiDE8mxKM5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LXijbqw3uqIUMuODy3kXAgEeGxVKSnc9l5R0lGy6/Xb/IUUIF0tjCAJUaoNOKqebH8rwccDkiVLklUYen9E9sjIpDgD5bLt/tra2207KX89SDU86OrvdO6tsUvdLUVe7b3aHhmAU17gpRPSYANLpb0RO7e4w5FJfew76DZpk/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYyGemqb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756329491; x=1787865491;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=tn6EVHu8sY4G0Bw0cvnGYUOHgfvWC1wVHiDE8mxKM5w=;
  b=EYyGemqbvghTRhFhGroGAweHEJ8ejBJUkMkp1PzWCsdxvRovF81Txaac
   jUXDGP97Bw6/KWyRJv7xHeGC3HDJoI2tnIsrGuxIFVKgMHeS2xAipq2Jy
   pd7erhL6qaW1hnfUnbfiKB5xI1H+97vPP2MlY7/Et6flr6aicxqU2ktvi
   Fu2+BjdozAdCvOCzCWOJnNtardUL6f8IXsDuRr58vVeFlmeC2Y3LMon+e
   8RDiXp1jaHdtqx2X4OYEUzcwSEAYxkjSOSnTSzqQQtfU27sDa/BYxWgyL
   8z/rwY9u7wqvzw2gCT0inFYo8rNsAHyVkyt31VappSgOII/X1NUu768OT
   Q==;
X-CSE-ConnectionGUID: Wro/IJyiRlirQMuFPOVPcw==
X-CSE-MsgGUID: FhIHGkTARsqTrJW01mh9gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62412344"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="62412344"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 14:18:10 -0700
X-CSE-ConnectionGUID: abDajAz7TAWPLUS6E55idg==
X-CSE-MsgGUID: 05L5hV2UTLas6ygaNCECzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169188315"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 14:18:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 27 Aug 2025 14:17:36 -0700
Subject: [PATCH iwl-net v3] i40e: fix Jumbo Frame support after iPXE boot
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-jk-fix-i40e-ice-pxe-9k-mtu-v3-1-14341728e572@intel.com>
X-B4-Tracking: v=1; b=H4sIAPB1r2gC/43PTQ6CQAwF4KuYWVvD/DAzuPIexoWUjlYFDCBqD
 Hd3YKWJUZfNa77XPkRLDVMrlrOHaKjnlusqDno+E7jfVjsCLuIsVKLSxEsNhyMEvgGbJEZIcL4
 RZEcouwuo3BaJtkpikYkInBuKqxO+Fnw9QUWd2MRgz21XN/eptJdT/I/fS5DgtDPSbgOixBVXH
 Z0WWJdj3d9ECPHCkAeTu8+E+UmgzpRV3oXc+RdifK5Xrw+lXyk1UuRThwVa49+oYRielcB8Hp4
 BAAA=
X-Change-ID: 20250813-jk-fix-i40e-ice-pxe-9k-mtu-2b6d03621cd9
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-c61db
X-Developer-Signature: v=1; a=openpgp-sha256; l=8440;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=tn6EVHu8sY4G0Bw0cvnGYUOHgfvWC1wVHiDE8mxKM5w=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz1ZbznZv57Ou2O5L43y/SCsoQlvF3kUqWD2rZP38O9u
 9n5V+L/jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbyLZGR4avlu1OWFxMr6lc/
 y/u4s7d8cmr5rXNbXtuXW2idF712dTXDH26jg5ty4pT8+wzOV12/LhBx+UKkqu+X9c+VU2QPHSw
 pZwQA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The i40e hardware has multiple hardware settings which define the Maximum
Frame Size (MFS) of the physical port. The firmware has an AdminQ command
(0x0603) to configure the MFS, but the i40e Linux driver never issues this
command.

In most cases this is no problem, as the NVM default value has the device
configured for its maximum value of 9728. Unfortunately, recent versions of
the iPXE intelxl driver now issue the 0x0603 Set Mac Config command,
modifying the MFS and reducing it from its default value of 9728.

This occurred as part of iPXE commit 6871a7de705b ("[intelxl] Use admin
queue to set port MAC address and maximum frame size"), a prerequisite
change for supporting the E800 series hardware in iPXE. Both the E700 and
E800 firmware support the AdminQ command, and the iPXE code shares much of
the logic between the two device drivers.

The ice E800 Linux driver already issues the 0x0603 Set Mac Config command
early during probe, and is thus unaffected by the iPXE change.

Since commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set"), the
i40e driver does check the I40E_PRTGL_SAH register, but it only logs a
warning message if its value is below the 9728 default. This register also
only covers received packets and not transmitted packets. A warning can
inform system administrators, but does not correct the issue. No
interactions from userspace cause the driver to write to PRTGL_SAH or issue
the 0x0603 AdminQ command. Only a GLOBR reset will restore the value to its
default value. There is no obvious method to trigger a GLOBR reset from
user space.

To fix this, introduce the i40e_aq_set_mac_config() function, similar to
the one from the ice driver. Call this during early probe to ensure that
the device configuration matches driver expectation. Unlike E800, the E700
firmware also has a bit to control whether the MAC should append CRC data.
It is on by default, but setting a 0 to this bit would disable CRC. The
i40e implementation must set this bit to ensure CRC will be appended by the
MAC.

In addition to the AQ command, instead of just checking the I40E_PRTGL_SAH
register, update its value to the 9728 default and write it back. This
ensures that the hardware is in the expected state, regardless of whether
the iPXE (or any other early boot driver) has modified this state.

This is a better user experience, as we now fix the issues with larger MTU
instead of merely warning. It also aligns with the way the ice E800 series
driver works.

A final note: The Fixes tag provided here is not strictly accurate. The
issue occurs as a result of an external entity (the iPXE intelxl driver),
and this is not a regression specifically caused by the mentioned change.
However, I believe the original change to just warn about PRTGL_SAH being
too low was an insufficient fix.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
Link: https://github.com/ipxe/ipxe/commit/6871a7de705b6f6a4046f0d19da9bcd689c3bc8e
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v3:
- Don't disable CRC. Otherwise, Tx traffic will not be accepted
  appropriately.
- Link to v2: https://lore.kernel.org/r/20250815-jk-fix-i40e-ice-pxe-9k-mtu-v2-1-ce857cdc6488@intel.com

Changes in v2:
- Rewrite commit message with feedback from Paul Menzel.
- Add missing initialization of cmd via libie_aq_raw().
- Fix the Kdoc comment for i40e_aq_set_mac_config().
- Move clarification of the Fixes tag to the commit message.
- Link to v1: https://lore.kernel.org/r/20250814-jk-fix-i40e-ice-pxe-9k-mtu-v1-1-c3926287fb78@intel.com
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h |  1 +
 drivers/net/ethernet/intel/i40e/i40e_prototype.h  |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_common.c     | 34 +++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c       | 17 ++++++++----
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 76d872b91a38..cc02a85ad42b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1561,6 +1561,7 @@ I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
 struct i40e_aq_set_mac_config {
 	__le16	max_frame_size;
 	u8	params;
+#define I40E_AQ_SET_MAC_CONFIG_CRC_EN	BIT(2)
 	u8	tx_timer_priority; /* bitmap */
 	__le16	tx_timer_value;
 	__le16	fc_refresh_threshold;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index aef5de53ce3b..26bb7bffe361 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -98,6 +98,8 @@ int i40e_aq_set_mac_loopback(struct i40e_hw *hw,
 			     struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_set_phy_int_mask(struct i40e_hw *hw, u16 mask,
 			     struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
+			   struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
 			   struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_set_link_restart_an(struct i40e_hw *hw,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 270e7e8cf9cf..59f5c1e810eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1189,6 +1189,40 @@ int i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
 	return status;
 }
 
+/**
+ * i40e_aq_set_mac_config - Configure MAC settings
+ * @hw: pointer to the hw struct
+ * @max_frame_size: Maximum Frame Size to be supported by the port
+ * @cmd_details: pointer to command details structure or NULL
+ *
+ * Set MAC configuration (0x0603). Note that max_frame_size must be greater
+ * than zero.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
+			   struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_set_mac_config *cmd;
+	struct libie_aq_desc desc;
+
+	cmd = libie_aq_raw(&desc);
+
+	if (max_frame_size == 0)
+		return -EINVAL;
+
+	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_set_mac_config);
+
+	cmd->max_frame_size = cpu_to_le16(max_frame_size);
+	cmd->params = I40E_AQ_SET_MAC_CONFIG_CRC_EN;
+
+#define I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD	0x7FFF
+	cmd->fc_refresh_threshold =
+		cpu_to_le16(I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD);
+
+	return i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+}
+
 /**
  * i40e_aq_clear_pxe_mode
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b83f823e4917..4796fdd0b966 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16045,13 +16045,18 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %pe last_status =  %s\n",
 			ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 
-	/* make sure the MFS hasn't been set lower than the default */
 #define MAX_FRAME_SIZE_DEFAULT 0x2600
-	val = FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
-			rd32(&pf->hw, I40E_PRTGL_SAH));
-	if (val < MAX_FRAME_SIZE_DEFAULT)
-		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
-			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
+
+	err = i40e_aq_set_mac_config(hw, MAX_FRAME_SIZE_DEFAULT, NULL);
+	if (err) {
+		dev_warn(&pdev->dev, "set mac config ret =  %pe last_status =  %s\n",
+			 ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
+	}
+
+	/* Make sure the MFS is set to the expected value */
+	val = rd32(hw, I40E_PRTGL_SAH);
+	FIELD_MODIFY(I40E_PRTGL_SAH_MFS_MASK, &val, MAX_FRAME_SIZE_DEFAULT);
+	wr32(hw, I40E_PRTGL_SAH, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out

---
base-commit: ceb9515524046252c522b16f38881e8837ec0d91
change-id: 20250813-jk-fix-i40e-ice-pxe-9k-mtu-2b6d03621cd9

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


