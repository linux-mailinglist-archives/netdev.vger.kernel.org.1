Return-Path: <netdev+bounces-165537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4247BA32717
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92377166D69
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933A20E6EC;
	Wed, 12 Feb 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jt70IHGS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4E20F067
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366905; cv=none; b=aaZuf+mjgmg3ZVodo6E04YQtNl3ncTNAgO/HXnA9x2Z3pDBUfgO2Z2baCp9Q9led294TBcJSMsGjiasYw1zwiRz2wVvMQ++MMncslEQHNGhxijI6K/FAeboMYxYGFD4klwrW3By7eMvKdPpQlqgNwjl2pwIlQQYKr8g+n8NLXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366905; c=relaxed/simple;
	bh=iOTHyVTsy5nZKxDg161IqK1gJpubBV8+ZlOwjcHZuiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFykrlF1fuA5N9VqGeiHO36GVrvXHKbqdCnapsrRfPSg+KNCFjgSkShFDqLt1gtbtqOmgSpj6pETZpAECeyMGRIsdsfKLXSWg/P5veRL/MFg0H40mJBYLSPmRA57ZV3IJNcfXXC5UQPKReK/UBFLq3x8vWPhSPRfrucJu6+tq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jt70IHGS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739366904; x=1770902904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iOTHyVTsy5nZKxDg161IqK1gJpubBV8+ZlOwjcHZuiQ=;
  b=Jt70IHGSBwSpG6dTg/EVH9XiAgGfBNxXVzzy01JCgOpI1UZaAYtgFxr1
   EY2/Ii1vZPAxzy9bSi56ExyPaVtJeyUVL8bI3Zp/gvP4a15IXbPzI20e+
   lVu8naIqSJrvLeqBd/EkhWmDTZO6yO0dvi5ajQgrsb8g6cIisVdatDhki
   KMJZ/sxEhTZ+uGw9l5ENeU9EaBGwGp1HXjdcWk271FBiokKUHrm6s2wOF
   lbsK60fjyZQXFbJb38KT3dUBK1AYfIx2gc6jfAv0jmPi4YGomPoDA/RBk
   8jq5BY3OtLMwuqGPc47KLHOR26LwE+0WFu5Uuh8bzCYIRZUpB1wY8BChP
   A==;
X-CSE-ConnectionGUID: Es+VURCSQxy9RmscOtOIEQ==
X-CSE-MsgGUID: HTcX32HOQDuvbklcTjlOAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50665576"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50665576"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:28:23 -0800
X-CSE-ConnectionGUID: YqcgKpG1TsqsmH44ht3+WA==
X-CSE-MsgGUID: ggU2/FAKT4m1nKpkLhepNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="117830708"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa004.jf.intel.com with ESMTP; 12 Feb 2025 05:28:21 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v3 12/14] ixgbe: add FW API version check
Date: Wed, 12 Feb 2025 14:14:11 +0100
Message-Id: <20250212131413.91787-13-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250212131413.91787-1-jedrzej.jagielski@intel.com>
References: <20250212131413.91787-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add E610 specific function checking whether the FW API version
is compatible with the driver expectations.

The major API version should be less than or equal to the expected
API version. If not the driver won't be fully operational.

Check the minor version, and if it is more than two versions lesser
or greater than the expected version, print a message indicating
that the NVM or driver should be updated respectively.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 31 +++++++++++++++++++
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  4 +++
 4 files changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 3d15a5a0c580..2c54c6fa55a2 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -488,6 +488,8 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 
 	*actions_performed = BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
 
+	adapter->flags2 &= ~IXGBE_FLAG2_API_MISMATCH;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 0dbb2e205557..59dceb96e76a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -671,6 +671,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_PHY_FW_LOAD_FAILED		BIT(20)
 #define IXGBE_FLAG2_NO_MEDIA			BIT(21)
 #define IXGBE_FLAG2_MOD_POWER_UNSUPPORTED	BIT(22)
+#define IXGBE_FLAG2_API_MISMATCH		BIT(23)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 4523f7d5a12e..0a4922e4e9cf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8361,6 +8361,31 @@ static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
 	rtnl_unlock();
 }
 
+static int ixgbe_check_fw_api_mismatch(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	if (hw->mac.type != ixgbe_mac_e610)
+		return 0;
+
+	if (hw->api_maj_ver > IXGBE_FW_API_VER_MAJOR) {
+		e_dev_err("The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
+
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+		return -EOPNOTSUPP;
+	} else if (hw->api_maj_ver == IXGBE_FW_API_VER_MAJOR &&
+		   hw->api_min_ver > IXGBE_FW_API_VER_MINOR + IXGBE_FW_API_VER_DIFF_ALLOWED) {
+		e_dev_info("The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+	} else if (hw->api_maj_ver < IXGBE_FW_API_VER_MAJOR ||
+		   hw->api_min_ver < IXGBE_FW_API_VER_MINOR - IXGBE_FW_API_VER_DIFF_ALLOWED) {
+		e_dev_info("The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+	}
+
+	return 0;
+}
+
 /**
  * ixgbe_check_fw_error - Check firmware for errors
  * @adapter: the adapter private structure
@@ -8371,6 +8396,7 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 fwsm;
+	int err;
 
 	/* read fwsm.ext_err_ind register and log errors */
 	fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
@@ -8385,6 +8411,11 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 		e_dev_err("Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
 		return true;
 	}
+	if (!(adapter->flags2 & IXGBE_FLAG2_API_MISMATCH)) {
+		err = ixgbe_check_fw_api_mismatch(adapter);
+		if (err)
+			return true;
+	}
 
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 93d854b8a92e..4d591019dd07 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -112,6 +112,10 @@
 #define IXGBE_PF_HICR_SV			BIT(2)
 #define IXGBE_PF_HICR_EV			BIT(3)
 
+#define IXGBE_FW_API_VER_MAJOR		0x01
+#define IXGBE_FW_API_VER_MINOR		0x07
+#define IXGBE_FW_API_VER_DIFF_ALLOWED	0x02
+
 #define IXGBE_ACI_DESC_SIZE		32
 #define IXGBE_ACI_DESC_SIZE_IN_DWORDS	(IXGBE_ACI_DESC_SIZE / BYTES_PER_DWORD)
 
-- 
2.31.1


