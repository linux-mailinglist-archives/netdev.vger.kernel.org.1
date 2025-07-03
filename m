Return-Path: <netdev+bounces-203891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD9AF7F43
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DCA3BF231
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105A2F235B;
	Thu,  3 Jul 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eviPn3MB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001F279DB9
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564570; cv=none; b=tI6nLYTOC73ZdxHjI9uoZ7atfx21uoialv9G5Da06jMNv+DvAHQZ7ix64F+BgVFC3bstH5y9PGEp0N/Ix620/+eTo9GsbJWurl5vwiXJwGtH9cCohp+IixLErGcXPDW8H+7PIdcBymL23Yi9V7v286uCt+QhzSWKZiYj25J0D8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564570; c=relaxed/simple;
	bh=f600Ayz0XtATDfqDeVlM/cfFqa4kWg+Jfzh65HfCvdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjHacddUyJXA/Vro8vJ+vfK+j3qkpWLrGkJvXZybr2IRfgicyOQiHCUBn6P9EdsGzcn4MLSxDhdYYmD9gQYWa+1dZfAZqU6jumBqpWyXweH0sax0NtJm2t/g3W/46avx9r3Ck1hEF0uNQakQKbwSb/y9VuxLOi8eTj/rQVWkBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eviPn3MB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564569; x=1783100569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f600Ayz0XtATDfqDeVlM/cfFqa4kWg+Jfzh65HfCvdA=;
  b=eviPn3MBGHfKb3MBcdh+nBUu+gnAMhrtrDKXi1vrLXK9OCliMn+zXr8N
   0nYYQ2/8pBcd0T0kqWWKf+kaczdgYs4nztF6WCaDkPQ33yLMxTAnIlTaB
   2RTEaNmDdLNshCIzA0Onvd6IXW8CdWQygsTlTAbmSLWaNyUKRYalEdZGv
   Mj94bQr4IG0Wq8IZvMvsUxRjXdbwyYLlNX1ZZL09HS0ahV2vzCbMxjqRD
   L+OAdTe82fa8a6NatSdhLcNXAscT4oOEFSdkpdjErGWxJNDPd+eISx+rZ
   WZ5c0nYg9ZDsXQB/+SpEXL/0Nz0JitXtMssGctpUQagHuuR3147Hm4CNU
   w==;
X-CSE-ConnectionGUID: IKzoBN/9TJCbQJSdg4ppzA==
X-CSE-MsgGUID: V8+YArehQyeb70FrX2G1+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767883"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767883"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:48 -0700
X-CSE-ConnectionGUID: WrVyS3vNQQqLHIeKr/yylw==
X-CSE-MsgGUID: NlhBpVUPQruHYcf3HpGUaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997873"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:47 -0700
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 01/12] ice: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  3 Jul 2025 10:42:28 -0700
Message-ID: <20250703174242.3829277-2-anthony.l.nguyen@intel.com>
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

It is time to convert the Intel ice driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl() path
completely.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 +-----------
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 45 ++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  | 17 ++++++---
 3 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f8ef80069e3d..af68869693ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7901,27 +7901,6 @@ int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	return err;
 }
 
-/**
- * ice_eth_ioctl - Access the hwtstamp interface
- * @netdev: network interface device structure
- * @ifr: interface request data
- * @cmd: ioctl command
- */
-static int ice_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
-{
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
-
-	switch (cmd) {
-	case SIOCGHWTSTAMP:
-		return ice_ptp_get_ts_config(pf, ifr);
-	case SIOCSHWTSTAMP:
-		return ice_ptp_set_ts_config(pf, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 /**
  * ice_aq_str - convert AQ err code to a string
  * @aq_err: the AQ error code to convert
@@ -9761,7 +9740,6 @@ static const struct net_device_ops ice_netdev_ops = {
 	.ndo_change_mtu = ice_change_mtu,
 	.ndo_get_stats64 = ice_get_stats64,
 	.ndo_set_tx_maxrate = ice_set_tx_maxrate,
-	.ndo_eth_ioctl = ice_eth_ioctl,
 	.ndo_set_vf_spoofchk = ice_set_vf_spoofchk,
 	.ndo_set_vf_mac = ice_set_vf_mac,
 	.ndo_get_vf_config = ice_get_vf_cfg,
@@ -9785,4 +9763,6 @@ static const struct net_device_ops ice_netdev_ops = {
 	.ndo_bpf = ice_xdp,
 	.ndo_xdp_xmit = ice_xdp_xmit,
 	.ndo_xsk_wakeup = ice_xsk_wakeup,
+	.ndo_hwtstamp_get = ice_ptp_hwtstamp_get,
+	.ndo_hwtstamp_set = ice_ptp_hwtstamp_set,
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e7005d757477..e358eb1d719f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2197,23 +2197,24 @@ static int ice_ptp_getcrosststamp(struct ptp_clock_info *info,
 }
 
 /**
- * ice_ptp_get_ts_config - ioctl interface to read the timestamping config
- * @pf: Board private structure
- * @ifr: ioctl data
+ * ice_ptp_hwtstamp_get - interface to read the timestamping config
+ * @netdev: Pointer to network interface device structure
+ * @config: Timestamping configuration structure
  *
  * Copy the timestamping config to user buffer
  */
-int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
+int ice_ptp_hwtstamp_get(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config *config;
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = np->vsi->back;
 
 	if (pf->ptp.state != ICE_PTP_READY)
 		return -EIO;
 
-	config = &pf->ptp.tstamp_config;
+	*config = pf->ptp.tstamp_config;
 
-	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /**
@@ -2221,8 +2222,8 @@ int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
  * @pf: Board private structure
  * @config: hwtstamp settings requested or saved
  */
-static int
-ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
+static int ice_ptp_set_timestamp_mode(struct ice_pf *pf,
+				      struct kernel_hwtstamp_config *config)
 {
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
@@ -2266,32 +2267,32 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 }
 
 /**
- * ice_ptp_set_ts_config - ioctl interface to control the timestamping
- * @pf: Board private structure
- * @ifr: ioctl data
+ * ice_ptp_hwtstamp_set - interface to control the timestamping
+ * @netdev: Pointer to network interface device structure
+ * @config: Timestamping configuration structure
+ * @extack: Netlink extended ack structure for error reporting
  *
  * Get the user config and store it
  */
-int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
+int ice_ptp_hwtstamp_set(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = np->vsi->back;
 	int err;
 
 	if (pf->ptp.state != ICE_PTP_READY)
 		return -EAGAIN;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = ice_ptp_set_timestamp_mode(pf, &config);
+	err = ice_ptp_set_timestamp_mode(pf, config);
 	if (err)
 		return err;
 
 	/* Return the actual configuration set */
-	config = pf->ptp.tstamp_config;
+	*config = pf->ptp.tstamp_config;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index c8dac5a5bcd9..137f2070a2d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -259,7 +259,7 @@ struct ice_ptp {
 	struct ptp_extts_request extts_rqs[GLTSYN_EVNT_H_IDX_MAX];
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	u64 reset_time;
 	u32 tx_hwtstamp_skipped;
 	u32 tx_hwtstamp_timeouts;
@@ -291,8 +291,11 @@ struct ice_ptp {
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 int ice_ptp_clock_index(struct ice_pf *pf);
 struct ice_pf;
-int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr);
-int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr);
+int ice_ptp_hwtstamp_get(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config);
+int ice_ptp_hwtstamp_set(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack);
 void ice_ptp_restore_timestamp_mode(struct ice_pf *pf);
 
 void ice_ptp_extts_event(struct ice_pf *pf);
@@ -313,12 +316,16 @@ void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
 void ice_ptp_link_change(struct ice_pf *pf, bool linkup);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
-static inline int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
+
+static inline int ice_ptp_hwtstamp_get(struct net_device *netdev,
+				       struct kernel_hwtstamp_config *config)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
+static inline int ice_ptp_hwtstamp_set(struct net_device *netdev,
+				       struct kernel_hwtstamp_config *config,
+				       struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.47.1


