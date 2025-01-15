Return-Path: <netdev+bounces-158505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC5A123E9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DD21889DC4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF991BEF9E;
	Wed, 15 Jan 2025 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhlvrczW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6688634C
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736944858; cv=none; b=hbmZM+HknkwaKGkRU29vF2sX0F7i+ErSbRnYxvoRZFFttzpJEFal4oVb19ZAwseuVJ9NRXupL7/F6dx5RrZhMkjIE+3RN7pl1DwUs1wZy30+Nh6DwB/HZxpgEs4qrCV7LdP487kA+FcWUL2mwlJTYDQSuSFJHNoo1L0/06dn/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736944858; c=relaxed/simple;
	bh=KP6bbmkVXA6DN61BQl4jtzHB/Yy6FMxyDtzEAEA0IpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iv2ByLOjgnAdVJoJXJt20cr49HDyHbYQGEOMqmEICMwofJ1MeHxtA+eQDr9NovsMwny7wJRADyNqrgbiMIgOXXvypLGHezjIzKP7eCccX5b7t2W9NnAYv/1NUWMSvZGEst1a7O7wu1E64/tm3fQr2FBj6yUONW4WzREpSN1uzvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhlvrczW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736944856; x=1768480856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KP6bbmkVXA6DN61BQl4jtzHB/Yy6FMxyDtzEAEA0IpM=;
  b=hhlvrczWLxK0mFvILsxL/GlVLPkttGlT+p6xYeRc9d5fZSWXFyGVVPEK
   O/o05nQL1XBndAlnGQI5+ylsUW9AWJQZ8dWJrrUXDmCe4zIqvudX+Z3gX
   aBkTLQsvwuqgOwaakkk2b4G3tX7SaqL5Oaf7bxRA6SvtQWGjjP+0bF3sZ
   H8OBQjuV/7fbnFOPN/PwYtfEgXm/LZqYKU1Ja59DaJR6GV4+EI1l2QT/e
   8kpu9Vs7NbQ2VndVHnN4n4m6giVtWmIW76vRPlh0XUvlA6gA5mpDl/vE9
   nwKgFxXAGKLvoqq/349d9Aq3Hlujg+8ouSlPBtsf0B7E2TJRrZUeHGbg9
   Q==;
X-CSE-ConnectionGUID: j9vvXQsCTgipAeP3s0ogBw==
X-CSE-MsgGUID: FQfBasp6TGqzCjr8dartmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47864508"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="47864508"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 04:40:56 -0800
X-CSE-ConnectionGUID: fb7Z3i7cRDCRgMwVHgEhgA==
X-CSE-MsgGUID: ydbmevfXTKuBkTkQteBPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104982119"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa010.jf.intel.com with ESMTP; 15 Jan 2025 04:40:54 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1] ixgbe: add support for thermal sensor event reception
Date: Wed, 15 Jan 2025 13:27:20 +0100
Message-Id: <20250115122720.431223-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E610 NICs unlike the previous devices utilising ixgbe driver
are notified in the case of overheat by the FW ACI event.

In event of overheat when treshhold is exceeded, FW suspends all
traffic and sends overtemp event to the driver. Then driver
loggs appropriate message and closes the adapter instance.
The card remains in that state until the platform is rebooted.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 5 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20c9a30..5c804948dd1f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3165,6 +3165,7 @@ static void ixgbe_aci_event_cleanup(struct ixgbe_aci_event *event)
 static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_aci_event event __cleanup(ixgbe_aci_event_cleanup);
+	struct net_device *netdev = adapter->netdev;
 	struct ixgbe_hw *hw = &adapter->hw;
 	bool pending = false;
 	int err;
@@ -3185,6 +3186,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 		case ixgbe_aci_opc_get_link_status:
 			ixgbe_handle_link_status_event(adapter, &event);
 			break;
+		case ixgbe_aci_opc_temp_tca_event:
+			e_crit(drv, "%s\n", ixgbe_overheat_msg);
+			ixgbe_close(netdev);
+			break;
 		default:
 			e_warn(hw, "unknown FW async event captured\n");
 			break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 8d06ade3c7cd..617e07878e4f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -171,6 +171,9 @@ enum ixgbe_aci_opc {
 	ixgbe_aci_opc_done_alt_write			= 0x0904,
 	ixgbe_aci_opc_clear_port_alt_write		= 0x0906,
 
+	/* TCA Events */
+	ixgbe_aci_opc_temp_tca_event                    = 0x0C94,
+
 	/* debug commands */
 	ixgbe_aci_opc_debug_dump_internals		= 0xFF08,
 

base-commit: 09a7ccb316bce8347fefad05809426526b6699f3
-- 
2.31.1


