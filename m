Return-Path: <netdev+bounces-190676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8EAAB8457
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922C29E45D9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965C2980AD;
	Thu, 15 May 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgaQofa+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773381E9B2F
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306248; cv=none; b=l5SFTuF4HTg7x4WPBjMwiP+QpSu4rQal2tJkbf4GnLB9/TWcplRkovrt4pj9hHn+xKmSZS+gmiS8OZW+ByrMn4soP1T9pss/V77gIPUBzAeE90bjMnKVGyzfU2vhPy8tL8RU2SuOmuOResTReJ7pPdun7udmw94Ir71o56+dRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306248; c=relaxed/simple;
	bh=fnKe0Y9oLUlJLRR2AxHq3OTfP7glGHmX2LeMJdSBU0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5jQYVXg5cx6NpH9FOSpCtcjstG+D0T5CHNHYNWyQpdk0ASF1Vw0RQoWWDIqUaOWtUt7RWjlKlOIMUlFEhrMQrlVk6gHaB+NXQ6YwqW7c6nCqYh7P47W6mCNF6NPm2q+gmJvSD7uF6eMNg3SJP+ubgKEvLfIpFxP74V3iA4+QwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgaQofa+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747306246; x=1778842246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fnKe0Y9oLUlJLRR2AxHq3OTfP7glGHmX2LeMJdSBU0E=;
  b=fgaQofa+5Ovx/cxkrKj43N85Qj1EUjcLjgB2SiAyMxE554etaDu8pJbd
   fhnX6sdY/Cid7slY1SduE+p1azPjb9YmSQd56lA1WYEKk7VBWATftf7wT
   6PFTqDjgTfm1wN+aOAEVR9CgGvlmyeqAR2Ouoi/IuUNuErDrI1RneIIJ2
   zxMggCPGsCdkqYN0TLM+Asy96FmLuHTsZf8s4F3dkGQBmUJxw/5IihXJc
   dSw+gM97T+yHgYso+CdWFmFraqkbbsSGe9OWT/nJ4dzbC7GMqKNFh9mBE
   T2efrGpRIjD+WMVtHgNmxtgASoKo80ibgkpZeMcYFwzZWWFIKXslWpscX
   Q==;
X-CSE-ConnectionGUID: 29S1swdmTseiBudjWNrfvQ==
X-CSE-MsgGUID: z0gL3DIESb2HFKOUEkDyOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66786974"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66786974"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 03:50:46 -0700
X-CSE-ConnectionGUID: 7dKUWLZMRhmavTIXzpWivQ==
X-CSE-MsgGUID: lCrao+o2RNSHBEAS8BWx3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138873966"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa007.jf.intel.com with ESMTP; 15 May 2025 03:50:44 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	dawid.osuchowski@linux.intel.com,
	pmenzel@molgen.mpg.de,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v4 2/2] ixgbe: add link_down_events statistic
Date: Thu, 15 May 2025 12:50:10 +0200
Message-ID: <20250515105011.1310692-3-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com>
References: <20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a link_down_events counter to the ixgbe driver, incremented
each time the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The value is exposed via ethtool's get_link_ext_stats() interface.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 47311b134a7a..c6772cd2d802 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -752,6 +752,7 @@ struct ixgbe_adapter {
 	bool link_up;
 	unsigned long sfp_poll_time;
 	unsigned long link_check_timeout;
+	u32 link_down_events;
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index d8a919ab7027..1dc1c6e611a4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1033,6 +1033,14 @@ static void ixgbe_get_regs(struct net_device *netdev,
 	regs_buff[1144] = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT);
 }
 
+static void ixgbe_get_link_ext_stats(struct net_device *netdev,
+				     struct ethtool_link_ext_stats *stats)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+
+	stats->link_down_events = adapter->link_down_events;
+}
+
 static int ixgbe_get_eeprom_len(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
@@ -3719,6 +3727,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.set_wol                = ixgbe_set_wol,
 	.nway_reset             = ixgbe_nway_reset,
 	.get_link               = ethtool_op_get_link,
+	.get_link_ext_stats	= ixgbe_get_link_ext_stats,
 	.get_eeprom_len         = ixgbe_get_eeprom_len,
 	.get_eeprom             = ixgbe_get_eeprom,
 	.set_eeprom             = ixgbe_set_eeprom,
@@ -3764,6 +3773,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.set_wol                = ixgbe_set_wol_e610,
 	.nway_reset             = ixgbe_nway_reset,
 	.get_link               = ethtool_op_get_link,
+	.get_link_ext_stats	= ixgbe_get_link_ext_stats,
 	.get_eeprom_len         = ixgbe_get_eeprom_len,
 	.get_eeprom             = ixgbe_get_eeprom,
 	.set_eeprom             = ixgbe_set_eeprom,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 03d31e5b131d..1982314aaf3c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7991,6 +7991,8 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 	if (!netif_carrier_ok(netdev))
 		return;
 
+	adapter->link_down_events++;
+
 	/* poll for SFP+ cable when link is down */
 	if (ixgbe_is_sfp(hw) && hw->mac.type == ixgbe_mac_82598EB)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
-- 
2.47.0


