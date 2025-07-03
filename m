Return-Path: <netdev+bounces-203893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5219AF7F46
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A720480DBF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADBC2F2378;
	Thu,  3 Jul 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGieolk2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E62F2345
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564571; cv=none; b=NdBm9c3sY8yYI/UPbzI0dz29u54tPwWlyuO7kVVPF6ndPk3OMTeoq4vA1JsrvIU1XPB8ThI0YzFeh4QDI8DtSMJD0QVkz+lILmsECwYvAiecGj37U+TghFsV83p7tvxMe/PzW7hkC3XWh0mDyz9hBNNS64PZ2bMXCe7AXkBts9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564571; c=relaxed/simple;
	bh=j9CtcdAoQ8n0wE8+BbU6GTVIhX4LZcIbldFphmpWXus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByEYxyYFPb0hjOMTT7DECmWceroJmeDmJbAZHzwHl+Er9iHmV29+M5gvAiWatUQqgkok9gjhmaIKPssCNPxAbEzJKqaO0XRFdJvNc4p4DZfON+ZNPnoOeHBENnC+5ybfHEIIM2qO8j5ejVQvQ0V554oj2mnAjSVrX3ZTkO6oDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGieolk2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564570; x=1783100570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9CtcdAoQ8n0wE8+BbU6GTVIhX4LZcIbldFphmpWXus=;
  b=WGieolk2JKbVkcRNGhy+ivl3WiXEflPG/fg2oCj1TiFG9mcnCk7x/JiV
   liXeO6mQwV/qlSEs7E0DtcBrTha0Wpb2RNpEWCK8XowkNvbZwVRlnm/wV
   TGBOTCUvq3pWwlihiVY0jELhszVDd9Z2nw8aUSl60TsOALHRbOrvvrbXu
   A+ZuK0sk/rvfu7u3dY7nqofn17Bm5JUmo9dV2OgD/cpKolXahQhcHrcwx
   RhDUlBS/se2HebN5QRJyrkvxgxQt3LXfVlwnhpEBIvjo6VJT5jWYWgmgy
   Ex2w5b649qrt5/UiVSHEv555RrZ1h85I4TyDk7zlhby/ALfZBke3q93Tz
   Q==;
X-CSE-ConnectionGUID: aLqrAByIRHe2xjCzl7rfaQ==
X-CSE-MsgGUID: SQtcgWqgTXiCHPAR3MJB6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767909"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767909"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:49 -0700
X-CSE-ConnectionGUID: rfgoOCqQTtWwOE3AKUO6Kw==
X-CSE-MsgGUID: CMKE8SWUSuWBZIalyT54lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997886"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 03/12] igb: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  3 Jul 2025 10:42:30 -0700
Message-ID: <20250703174242.3829277-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6.

It is time to convert the Intel igb driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl() path
completely.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  9 ++++--
 drivers/net/ethernet/intel/igb/igb_main.c |  6 ++--
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 37 +++++++++++------------
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index f34ead8243e9..c3f4f7cd264e 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -626,7 +626,7 @@ struct igb_adapter {
 	struct delayed_work ptp_overflow_work;
 	struct work_struct ptp_tx_work;
 	struct sk_buff *ptp_tx_skb;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	unsigned long ptp_tx_start;
 	unsigned long last_rx_ptp_check;
 	unsigned long last_rx_timestamp;
@@ -771,8 +771,11 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter);
 void igb_ptp_rx_rgtstamp(struct igb_q_vector *q_vector, struct sk_buff *skb);
 int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			ktime_t *timestamp);
-int igb_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
-int igb_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
+int igb_ptp_hwtstamp_get(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config);
+int igb_ptp_hwtstamp_set(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack);
 void igb_set_flag_queue_pairs(struct igb_adapter *, const u32);
 unsigned int igb_get_max_rss_queues(struct igb_adapter *);
 #ifdef CONFIG_IGB_HWMON
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b76a154e635e..a9a7a94ae61e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3062,6 +3062,8 @@ static const struct net_device_ops igb_netdev_ops = {
 	.ndo_bpf		= igb_xdp,
 	.ndo_xdp_xmit		= igb_xdp_xmit,
 	.ndo_xsk_wakeup         = igb_xsk_wakeup,
+	.ndo_hwtstamp_get	= igb_ptp_hwtstamp_get,
+	.ndo_hwtstamp_set	= igb_ptp_hwtstamp_set,
 };
 
 /**
@@ -9317,10 +9319,6 @@ static int igb_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 	case SIOCGMIIREG:
 	case SIOCSMIIREG:
 		return igb_mii_ioctl(netdev, ifr, cmd);
-	case SIOCGHWTSTAMP:
-		return igb_ptp_get_ts_config(netdev, ifr);
-	case SIOCSHWTSTAMP:
-		return igb_ptp_set_ts_config(netdev, ifr);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 793c96016288..05d30aba66db 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1094,21 +1094,22 @@ void igb_ptp_rx_rgtstamp(struct igb_q_vector *q_vector, struct sk_buff *skb)
 }
 
 /**
- * igb_ptp_get_ts_config - get hardware time stamping config
+ * igb_ptp_hwtstamp_get - get hardware time stamping config
  * @netdev: netdev struct
- * @ifr: interface struct
+ * @config: timestamping configuration structure
  *
  * Get the hwtstamp_config settings to return to the user. Rather than attempt
  * to deconstruct the settings from the registers, just return a shadow copy
  * of the last known settings.
  **/
-int igb_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr)
+int igb_ptp_hwtstamp_get(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
-	struct hwtstamp_config *config = &adapter->tstamp_config;
 
-	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
-		-EFAULT : 0;
+	*config = adapter->tstamp_config;
+
+	return 0;
 }
 
 /**
@@ -1129,7 +1130,7 @@ int igb_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr)
  * level 2 or 4".
  */
 static int igb_ptp_set_timestamp_mode(struct igb_adapter *adapter,
-				      struct hwtstamp_config *config)
+				      struct kernel_hwtstamp_config *config)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsync_tx_ctl = E1000_TSYNCTXCTL_ENABLED;
@@ -1275,30 +1276,26 @@ static int igb_ptp_set_timestamp_mode(struct igb_adapter *adapter,
 }
 
 /**
- * igb_ptp_set_ts_config - set hardware time stamping config
+ * igb_ptp_hwtstamp_set - set hardware time stamping config
  * @netdev: netdev struct
- * @ifr: interface struct
- *
+ * @config: timestamping configuration structure
+ * @extack: netlink extended ack structure for error reporting
  **/
-int igb_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr)
+int igb_ptp_hwtstamp_set(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
-	struct hwtstamp_config config;
 	int err;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = igb_ptp_set_timestamp_mode(adapter, &config);
+	err = igb_ptp_set_timestamp_mode(adapter, config);
 	if (err)
 		return err;
 
 	/* save these settings for future reference */
-	memcpy(&adapter->tstamp_config, &config,
-	       sizeof(adapter->tstamp_config));
+	adapter->tstamp_config = *config;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /**
-- 
2.47.1


