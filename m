Return-Path: <netdev+bounces-249047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D09D1318E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ECDD30198E4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB7260588;
	Mon, 12 Jan 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bH5wqie1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3B244675
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227523; cv=none; b=TgI3u7dUmQIgfYEtiF7luyk+FW48XPMqeugstZ4wdfUafFCN4+LDhRWfeVDI/wKKH/UI8IuCYJcEbfQfNLGN4Cs8qc5iVnoF+S4TdPKR0agLkB1V45EY5s4tLnrrQoD8w/XLHl2m24L/OteyUztaOTfBepMY51W/zA3pjQRaQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227523; c=relaxed/simple;
	bh=nFJJYjWICI1M8ZrMgVJkDUTWu17fao6IyUHM3cWgSRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cget+fg7kfMolfqF+lT9Leo8sTlTzPU2pIe4jm57MwZZTJMVcKZaY5Cj8+QHYSqkpBhyk5W8+tTYaKssCsXTEMvyaB+4aNMsL9y+FeaUmPM2TB1RZlNrvzw2QBCpu2QgRAeoRnZ8x1qQfANoUn/73YZDxZDhu2nkagMpfk6XvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bH5wqie1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768227522; x=1799763522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nFJJYjWICI1M8ZrMgVJkDUTWu17fao6IyUHM3cWgSRM=;
  b=bH5wqie11d55zNqfuvJKGzSgURvW1JUbN2csyFPIKQKGwWcJDHcEpeNE
   +mMZAMuLuorKzNvtfekyArccWoeQgLwV7SsZKJ31rbIBL81Jn8Pcjv6jQ
   NCKR13mLbl5UD32MoJfPY11Myl/KSpxf2Pysqeb4SO7Nvxf3Pz5pg/oLS
   DDC21qGtzl1L4y8W5SD+m1sRS+ZoL1wy1P6tb6PUhbTqw4KlMl3tJnxHi
   /4aHMQuMOPNxUk4BztmMWWOrbfwgd7fU72+I2AQGmUcT6DKpRAUceJQ0F
   h8+EmVQdeveF5ushpltDUQnrTTWrCeoP7MJrFHgzNVe64qsHmdOda0S6M
   Q==;
X-CSE-ConnectionGUID: WWj2lAkvStSRsQNVgPU4YA==
X-CSE-MsgGUID: 4tfI3oUbTeW7gI4IsEWogg==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352286"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73352286"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 06:18:41 -0800
X-CSE-ConnectionGUID: DOaeo8ENQRS70DPRm9A2Jg==
X-CSE-MsgGUID: ANpCmzn4RWGSgBRyGYklJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="227355634"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:40 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 3/7] ixgbe: E610: update EEE supported speeds
Date: Mon, 12 Jan 2026 15:01:04 +0100
Message-Id: <20260112140108.1173835-4-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite there was no EEE (Energy Efficient Ethernet) feature
support for E610 adapters, eee_speeds_supported variable was
defined and even initialized with some EEE speeds.

As E610 adapter supports EEE only for 10G, 5G and 2.5G speeds,
update hw.phy.eee_speeds_supported. Remove unsupported speeds -
10M, 100M and 1G.

Add also entry for 5G speed in EEE speeds mapping array used
by ethtool callbacks.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c    | 11 ++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 71409a0ac2fe..bd0345ae863a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1998,9 +1998,14 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	/* Set PHY ID */
 	memcpy(&hw->phy.id, pcaps.phy_id_oui, sizeof(u32));
 
-	hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_10_FULL |
-				       IXGBE_LINK_SPEED_100_FULL |
-				       IXGBE_LINK_SPEED_1GB_FULL;
+	/* E610 supports EEE only for speeds above 1G */
+	if (hw->device_id == IXGBE_DEV_ID_E610_2_5G_T)
+		hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_2_5GB_FULL;
+	else
+		hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_2_5GB_FULL |
+					       IXGBE_LINK_SPEED_5GB_FULL |
+					       IXGBE_LINK_SPEED_10GB_FULL;
+
 	hw->phy.eee_speeds_advertised = hw->phy.eee_speeds_supported;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 25c3a09ad7f1..5764530b9667 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3535,6 +3535,7 @@ static const struct {
 	{ IXGBE_LINK_SPEED_100_FULL, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_1GB_FULL, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseX_Full_BIT },
+	{ IXGBE_LINK_SPEED_5GB_FULL, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_10GB_FULL, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
 };
 
-- 
2.31.1


