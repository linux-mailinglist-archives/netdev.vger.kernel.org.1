Return-Path: <netdev+bounces-263652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKhNIz/xp2mGmgAAu9opvQ
	(envelope-from <netdev+bounces-263652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:45:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 652741FCD02
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C533014116
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211B7382299;
	Wed,  4 Mar 2026 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgYV3ZW1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF048375AD9
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613757; cv=none; b=BNZ2Vdkglm1ZiI3iogQxmH6IvnXNPnDG3pf/AmWIK/QXbNuGnDHAxguiPo5EuBnJfSmoKpoeMmS3QNkYrH8p9gzyq52bw5KXcCyH8OQr+oJJ9HOLSAxVAnzrfT44xb1RocTGTUOkpp2+hx4ZAIT2A41w+pl320ldkqJf08OIxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613757; c=relaxed/simple;
	bh=BKssnUpC3b9eO8LjpnPOwjycyVQrdp45Uj5fbygo95o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHkLWikfdemjMlgYbHs40067AGyz04q4yx1BA2yPtHtshDOpCKDMYWnxWQUnE5LNDns0RrFBYMOF8c3hDOLujTt/f7NQwmWtlsHNmGRFm/XB2X/6qPr9CckpfRtIeROni3INv916u+DrdLo4QqZIEtN6g3Hd+/j0Cqoa2Yeko2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgYV3ZW1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772613756; x=1804149756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BKssnUpC3b9eO8LjpnPOwjycyVQrdp45Uj5fbygo95o=;
  b=mgYV3ZW1PGEBfTL+GauFzzN+f2jwoI8RM63Aseka+34UyMDSymxEgp2O
   NojTtREnFpK+qH8BOEl+RDMJf2BchAyBy00CiqKFbXuQt8I8gVJOrPEWP
   InnvXNpiBlS5OvR6BIdBbYDjSy6dFG/rYCH68ibB3VZslaamu6psYfuW3
   h6x3qyPZfoXhkEeGYmdHkDdiGB9Co54oHKvILK64Z1i7rob5VAqXGVdGT
   pRnAwoYjYZsA3bIRv7it/8vV2AUkoDkBHvN06R9M8qDoES/vMSKh1m9zd
   Hn2RA3SlZ8DljGgkkH3wbc3jUQOpKo9cERcKeTxnBzFsC1bwaVrvy1DuO
   A==;
X-CSE-ConnectionGUID: OtJFI7bgQfyQwBTD1O5jMg==
X-CSE-MsgGUID: oNmpr1jUTaS91x+a4M+CFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73736620"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="73736620"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 00:42:35 -0800
X-CSE-ConnectionGUID: OgIxrAcgSuKhqP54zY8mEw==
X-CSE-MsgGUID: bwVf6cETSwS5ob7SiSHtsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="223270421"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2026 00:42:34 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-net v1] ixgbe: stop re-reading flash on every get_drvinfo for e610
Date: Wed,  4 Mar 2026 09:42:32 +0100
Message-ID: <20260304084232.2937498-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 652741FCD02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263652-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

ixgbe_get_drvinfo() calls ixgbe_refresh_fw_version() on every ethtool
query for e610 adapters.  That ends up in ixgbe_discover_flash_size(),
which bisects the full 16 MB NVM space issuing one ACI command per
step (~20 ms each, ~24 steps total = ~500 ms).

Profiling on an idle E610-XAT2 system with telegraf scraping ethtool
stats every 10 seconds:

  kretprobe:ixgbe_get_drvinfo took 527603 us
  kretprobe:ixgbe_get_drvinfo took 523978 us
  kretprobe:ixgbe_get_drvinfo took 552975 us
  kretprobe:ice_get_drvinfo   took       3 us
  kretprobe:igb_get_drvinfo   took       2 us
  kretprobe:i40e_get_drvinfo  took       5 us

The half-second stall happens under the RTNL lock, causing visible
latency on ip-link and friends.

The FW version can only change after an EMPR reset.  All flash data is
already populated at probe time and the cached adapter->eeprom_id is
what get_drvinfo should be returning.  The only place that needs to
trigger a re-read is ixgbe_devlink_reload_empr_finish(), right after
the EMPR completes and new firmware is running.  Additionally, refresh
the FW version in ixgbe_reinit_locked() so that any PF that undergoes a
reinit after an EMPR (e.g. triggered by another PF's devlink reload)
also picks up the new version in adapter->eeprom_id.

ixgbe_devlink_info_get() keeps its refresh call for explicit
"devlink dev info" queries, which is fine given those are user-initiated.

Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   | 13 +++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 10 ++++++++++
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index d227f4d..f32e640 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -474,7 +474,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 	adapter->flags2 &= ~(IXGBE_FLAG2_API_MISMATCH |
 			     IXGBE_FLAG2_FW_ROLLBACK);
 
-	return 0;
+	return ixgbe_refresh_fw_version(adapter);
 }
 
 static const struct devlink_ops ixgbe_devlink_ops = {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index dce4936..047f040455 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -973,7 +973,7 @@ int ixgbe_init_interrupt_scheme(struct ixgbe_adapter *adapter);
 bool ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 			 u16 subdevice_id);
 void ixgbe_set_fw_version_e610(struct ixgbe_adapter *adapter);
-void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter);
+int ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter);
 #ifdef CONFIG_PCI_IOV
 void ixgbe_full_sync_mac_table(struct ixgbe_adapter *adapter);
 #endif
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index bb4b53f..358b50c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1155,12 +1155,17 @@ static int ixgbe_set_eeprom(struct net_device *netdev,
 	return ret_val;
 }
 
-void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
+int ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	err = ixgbe_get_flash_data(hw);
+	if (err)
+		return err;
 
-	ixgbe_get_flash_data(hw);
 	ixgbe_set_fw_version_e610(adapter);
+	return 0;
 }
 
 static void ixgbe_get_drvinfo(struct net_device *netdev,
@@ -1168,10 +1173,6 @@ static void ixgbe_get_drvinfo(struct net_device *netdev,
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 
-	/* need to refresh info for e610 in case fw reloads in runtime */
-	if (adapter->hw.mac.type == ixgbe_mac_e610)
-		ixgbe_refresh_fw_version(adapter);
-
 	strscpy(drvinfo->driver, ixgbe_driver_name, sizeof(drvinfo->driver));
 
 	strscpy(drvinfo->fw_version, adapter->eeprom_id,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c58051e4..8b07f25 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6289,6 +6289,16 @@ void ixgbe_reinit_locked(struct ixgbe_adapter *adapter)
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		msleep(2000);
 	ixgbe_up(adapter);
+
+	/* E610 has no FW event to notify all PFs of an EMPR reset, so
+	 * refresh the FW version here to pick up any new FW version after
+	 * a hardware reset (e.g. EMPR triggered by another PF's devlink
+	 * reload).  ixgbe_refresh_fw_version() updates both hw->flash and
+	 * adapter->eeprom_id so ethtool -i reports the correct string.
+	 */
+	if (adapter->hw.mac.type == ixgbe_mac_e610)
+		(void)ixgbe_refresh_fw_version(adapter);
+
 	clear_bit(__IXGBE_RESETTING, &adapter->state);
 }
 
-- 
2.52.0


