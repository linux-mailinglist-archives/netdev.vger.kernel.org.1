Return-Path: <netdev+bounces-304067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7uEhMIw3RmrSLwsAu9opvQ
	(envelope-from <netdev+bounces-304067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:03:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D216F59D1
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:03:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=cOAtX+0k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304067-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304067-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530773211B86
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744A48A2CD;
	Thu,  2 Jul 2026 09:35:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430D47CC89
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:35:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984914; cv=none; b=XxJMWKkpnFVWsjUaHjR8ncnVuY+Vh+JH3r3ThpjjZ6GUtCUlJgUiJcnd19xUU4D2cWKfXTkNc9xd4h5Wp7akBqg3fh9aWEejjR2dqpUmOF3aSkIGzYhG+8d9dnO/5d4Gu+YOO1Vd8JA11+Fh0HkG3ZR4cnRPlGgQUH3tGTXhDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984914; c=relaxed/simple;
	bh=NoRhnNPu9yFlRsA8qdXk5V8zjS4iJyDdqtRGbyso1oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ar375QhY2/YDXntt+a42MSdJ6DrRyP7reTVzPxTRVUBWnfar74zxGLGSLB4BwM/CiEUo6pEfsT2dlp3HgXSc7m0/kUUPgktdkKio9n/kPw89zmSUzzK3OYRWc3G4gikYaV5L4IIo2Euod2qwlZ+KU6ugkeYBZKF2VyUwjBL7O2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOAtX+0k; arc=none smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782984913; x=1814520913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NoRhnNPu9yFlRsA8qdXk5V8zjS4iJyDdqtRGbyso1oQ=;
  b=cOAtX+0kHCr9bXT11Gqe0r6F26X7ZCFukLWJN8Hba0Z+E2nGngu2bI1c
   aS1cy2jubRJ6tVsAth5QlSwOS0tCBAtmMSpWU0e/aXpZI2A8aCUFtUG93
   MPRUOqjbyr4GX/d2HB3pe1n5EJgy1TaBADc0jaeSdJIk7+QjeLgmQmOTy
   SFZ5sZ7Vr+xPAOvlnb/HkZurGSIOfZ8YAegCxf88FBPvOSWukIKUiL9/Z
   59cUzwyMxirZrhtM+JgIofVkT1NkgOjAMSzuutW7OQsWwPNQjyOPnKCTn
   Xie7By9kZlduYWuWYDtHOEwzesJDHrcfXkwr33COBazgPbh2LQlVlzmcU
   w==;
X-CSE-ConnectionGUID: vwWw32NHTmqauvZwhpw6Sw==
X-CSE-MsgGUID: MqmLAmHNQJy5CcAExqpPbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87649802"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87649802"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:13 -0700
X-CSE-ConnectionGUID: jn5wKI0QSae2XjIB7R2G4Q==
X-CSE-MsgGUID: U9Aft8JYQwW7k4OajYLUig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253476405"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2026 02:35:12 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 1/6] ixgbe: E610: init Link Status Events mask just once
Date: Thu,  2 Jul 2026 11:15:48 +0200
Message-Id: <20260702091553.57112-2-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304067-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:jedrzej.jagielski@intel.com,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47D216F59D1

Current approach is that LSE mask is configured each time the LSE feature
itself is toggled. The set of bits corresponding to LSE trigger causes
remain the same for the whole ixgbe lifecycle. There's no support for
enabling or disabling specific bits within LSE mask.

This is redundant; there's no need to configure LSE mask over and over.
The mask persists in hardware and only needs to be set once so should
be separated from the LSE toggling logic.

Do it just once at the init phase.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 34 ++++++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 28 +++------------
 4 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 30f62174acf2..17e0a9824777 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -821,7 +821,6 @@ struct ixgbe_adapter {
 	struct ixgbe_mac_addr *mac_table;
 	u8 tx_hang_count[IXGBE_MAX_TX_QUEUES];
 	struct kobject *info_kobj;
-	u16 lse_mask;
 #ifdef CONFIG_IXGBE_HWMON
 	struct hwmon_buff *ixgbe_hwmon_buff;
 #endif /* CONFIG_IXGBE_HWMON */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 831cfe9a4697..d451da68fd6d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1536,7 +1536,7 @@ int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, bool ena_lse,
  *
  * Return: the exit code of the operation.
  */
-int ixgbe_aci_set_event_mask(struct ixgbe_hw *hw, u8 port_num, u16 mask)
+static int ixgbe_aci_set_event_mask(struct ixgbe_hw *hw, u8 port_num, u16 mask)
 {
 	struct ixgbe_aci_cmd_set_event_mask *cmd;
 	struct libie_aq_desc desc;
@@ -1551,25 +1551,25 @@ int ixgbe_aci_set_event_mask(struct ixgbe_hw *hw, u8 port_num, u16 mask)
 	return ixgbe_aci_send_cmd(hw, &desc, NULL, 0);
 }
 
+static int ixgbe_aci_init_event_mask(struct ixgbe_hw *hw)
+{
+	u16 mask = ~((u16)(IXGBE_ACI_LINK_EVENT_UPDOWN |
+			   IXGBE_ACI_LINK_EVENT_MEDIA_NA |
+			   IXGBE_ACI_LINK_EVENT_MODULE_QUAL_FAIL |
+			   IXGBE_ACI_LINK_EVENT_PHY_FW_LOAD_FAIL));
+
+	return ixgbe_aci_set_event_mask(hw, (u8)hw->bus.func, mask);
+}
+
 /**
  * ixgbe_configure_lse - enable/disable link status events
  * @hw: pointer to the HW struct
  * @activate: true for enable lse, false otherwise
- * @mask: event mask to be set; a set bit means deactivation of the
- * corresponding event
- *
- * Set the event mask and then enable or disable link status events
  *
  * Return: the exit code of the operation.
  */
-int ixgbe_configure_lse(struct ixgbe_hw *hw, bool activate, u16 mask)
+int ixgbe_configure_lse(struct ixgbe_hw *hw, bool activate)
 {
-	int err;
-
-	err = ixgbe_aci_set_event_mask(hw, (u8)hw->bus.func, mask);
-	if (err)
-		return err;
-
 	/* Enabling link status events generation by fw. */
 	return ixgbe_aci_get_link_info(hw, activate, NULL);
 }
@@ -1597,6 +1597,16 @@ static int ixgbe_start_hw_e610(struct ixgbe_hw *hw)
 
 	ixgbe_start_hw_gen2(hw);
 
+	err = ixgbe_aci_init_event_mask(hw);
+	/* In case of error just log it, don't fail the whole init */
+	if (err) {
+		struct ixgbe_adapter *adapter =
+				container_of(hw, struct ixgbe_adapter, hw);
+
+		e_dev_err("Cannot configure Link Status Event mask, err = %d\n",
+			   err);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 2cb76a3d30ae..ecda35a77adb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -34,8 +34,7 @@ int ixgbe_update_link_info(struct ixgbe_hw *hw);
 int ixgbe_get_link_status(struct ixgbe_hw *hw, bool *link_up);
 int ixgbe_aci_get_link_info(struct ixgbe_hw *hw, bool ena_lse,
 			    struct ixgbe_link_status *link);
-int ixgbe_aci_set_event_mask(struct ixgbe_hw *hw, u8 port_num, u16 mask);
-int ixgbe_configure_lse(struct ixgbe_hw *hw, bool activate, u16 mask);
+int ixgbe_configure_lse(struct ixgbe_hw *hw, bool activate);
 int ixgbe_aci_set_port_id_led(struct ixgbe_hw *hw, bool orig_mode);
 enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw);
 int ixgbe_setup_link_e610(struct ixgbe_hw *hw, ixgbe_link_speed speed,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7a0783c1abc1..2c8968b9b86c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5969,23 +5969,14 @@ static void ixgbe_configure(struct ixgbe_adapter *adapter)
 /**
  * ixgbe_enable_link_status_events - enable link status events
  * @adapter: pointer to the adapter structure
- * @mask: event mask to be set
  *
  * Enables link status events by invoking ixgbe_configure_lse()
  *
  * Return: the exit code of the operation.
  */
-static int ixgbe_enable_link_status_events(struct ixgbe_adapter *adapter,
-					   u16 mask)
+static int ixgbe_enable_link_status_events(struct ixgbe_adapter *adapter)
 {
-	int err;
-
-	err = ixgbe_configure_lse(&adapter->hw, true, mask);
-	if (err)
-		return err;
-
-	adapter->lse_mask = mask;
-	return 0;
+	return ixgbe_configure_lse(&adapter->hw, true);
 }
 
 /**
@@ -5998,14 +5989,7 @@ static int ixgbe_enable_link_status_events(struct ixgbe_adapter *adapter,
  */
 static int ixgbe_disable_link_status_events(struct ixgbe_adapter *adapter)
 {
-	int err;
-
-	err = ixgbe_configure_lse(&adapter->hw, false, adapter->lse_mask);
-	if (err)
-		return err;
-
-	adapter->lse_mask = 0;
-	return 0;
+	return ixgbe_configure_lse(&adapter->hw, false);
 }
 
 /**
@@ -6039,10 +6023,6 @@ static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 {
 	struct ixgbe_adapter *adapter = container_of(hw, struct ixgbe_adapter,
 						     hw);
-	u16 mask = ~((u16)(IXGBE_ACI_LINK_EVENT_UPDOWN |
-			   IXGBE_ACI_LINK_EVENT_MEDIA_NA |
-			   IXGBE_ACI_LINK_EVENT_MODULE_QUAL_FAIL |
-			   IXGBE_ACI_LINK_EVENT_PHY_FW_LOAD_FAIL));
 	bool autoneg, link_up = false;
 	int ret = -EIO;
 	u32 speed;
@@ -6070,7 +6050,7 @@ static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 
 	if (hw->mac.ops.setup_link) {
 		if (adapter->hw.mac.type == ixgbe_mac_e610) {
-			ret = ixgbe_enable_link_status_events(adapter, mask);
+			ret = ixgbe_enable_link_status_events(adapter);
 			if (ret)
 				return ret;
 		}
-- 
2.31.1


