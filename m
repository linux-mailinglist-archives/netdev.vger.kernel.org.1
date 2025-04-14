Return-Path: <netdev+bounces-182164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C515A88104
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4993A1681F4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984FE17BBF;
	Mon, 14 Apr 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buy3wUoD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00AA1CAB3
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635734; cv=none; b=YXvwsb+g19K707KNO/oNzxD6bfggBdBFmFhG+4Wa0Xf3xORc/Z5Xoyc/+S6d9HstvLfdljH0SYFqf8z53CaMZJzVFfk7Br+HjRw52f1ifqn+8+YlP50uRjkMteUu8dEwbBca3SAwMbMQO1fZDfFdlNnK2W9847AKpSSHhtcqIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635734; c=relaxed/simple;
	bh=3jzBWhsFPcQWMuPqkcQXuYy0mPdlqqMyRnI517EycH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGJP2qz6ygCQZGH2CLKB80jAORwgmRh932e2gqizORgAI6/l5tIJP4E9RpZc3NYxK81UizpRSs4fdwJgDvqz90pHe1q7KpX/cDOq9ySVa8DbHrCE7k7MODT9h0FWgnEfJOaUF940qLl9S/bnOX0G5Aw6aWGyBpG2aWYuKw/oqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buy3wUoD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744635733; x=1776171733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3jzBWhsFPcQWMuPqkcQXuYy0mPdlqqMyRnI517EycH4=;
  b=buy3wUoD+uL3fJdtKPG7Y0ge9Es1jx4GBU36Q5TmqjVFkpdjGX+tdZEZ
   oGAPgxRDO1nyK/j+YpFnwL3ojE3IgM+hpHp6gAVOFQvzf2mh15lX98P6b
   oKC2MVTvYPKb/+Rs5MoValaQRnprJAs8kPTtG5JZomlubafe/bDFZVHve
   daK3/GSyIlw+Kuk/48hoJ2Zk+rUslyVgMydWWQ7bUDWkgisjmzBx7mZ8Q
   oTDD2WkjmHdFIw2AOvxhrpl8pjeOpH374lSWcfNdiBs4w8PjYq9s1N5Vk
   xcWrFzuyFQj3RwGwp99721/S0gecD00Z9zV9h5YnElayPeJ+UJ+pYt1kG
   A==;
X-CSE-ConnectionGUID: YMylN8KcTZeC6kaRNLP3YQ==
X-CSE-MsgGUID: 7TfSQJf7TSK9zzX6f/xJyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45239367"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="45239367"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:02:12 -0700
X-CSE-ConnectionGUID: 2cBn3ekWRYua1h1FNIyifg==
X-CSE-MsgGUID: bKtcHuW6RjKkYGR1LRTjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134967695"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa005.jf.intel.com with ESMTP; 14 Apr 2025 06:02:10 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH iwl-next v2 2/2] ixgbe: add link_down_events statistic
Date: Mon, 14 Apr 2025 15:00:11 +0200
Message-ID: <20250414130007.366132-7-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
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

Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 9 +++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index e6a380d4929b..7a8b4b6053c7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -743,6 +743,7 @@ struct ixgbe_adapter {
 	bool link_up;
 	unsigned long sfp_poll_time;
 	unsigned long link_check_timeout;
+	u32 link_down_events;
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index f03925c1f521..e2c474209114 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -992,6 +992,14 @@ static void ixgbe_get_regs(struct net_device *netdev,
 	regs_buff[1144] = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT);
 }
 
+static void ixgbe_get_link_ext_stats(struct net_device *netdev,
+				     struct ethtool_link_ext_stats *stats)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(netdev);
+
+	stats->link_down_events = adapter->link_down_events;
+}
+
 static int ixgbe_get_eeprom_len(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
@@ -3602,6 +3610,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.set_wol                = ixgbe_set_wol,
 	.nway_reset             = ixgbe_nway_reset,
 	.get_link               = ethtool_op_get_link,
+	.get_link_ext_stats	= ixgbe_get_link_ext_stats,
 	.get_eeprom_len         = ixgbe_get_eeprom_len,
 	.get_eeprom             = ixgbe_get_eeprom,
 	.set_eeprom             = ixgbe_set_eeprom,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 467f81239e12..cb5c782817fa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7986,6 +7986,8 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 	if (!netif_carrier_ok(netdev))
 		return;
 
+	adapter->link_down_events++;
+
 	/* poll for SFP+ cable when link is down */
 	if (ixgbe_is_sfp(hw) && hw->mac.type == ixgbe_mac_82598EB)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
-- 
2.47.0


