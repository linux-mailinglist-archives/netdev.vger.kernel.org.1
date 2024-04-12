Return-Path: <netdev+bounces-87275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B288A2686
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA58283131
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA753BB2E;
	Fri, 12 Apr 2024 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2uN1nZS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33239FFB
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903190; cv=none; b=tYdHyvdkv4SUzY5sRHJL9LUNsgayYZD7fioF7eur0oaV7NRcfUL/cH92pdZh1L3N0YYXN3oYwWWitWKBe8p3Gv3me4mXQwqeB6ZMSFI17UVxS4tWmID2T/wXnX4/ebURgJ6kc2I5zYYn/WLmGH7Rqah5vnd7LLsjrFHLir0aq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903190; c=relaxed/simple;
	bh=A9td/u3rL3CsEVlgoV3nHZed2uzaUWhm37Vu6ewAR6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvS5amaX1JAnuZub9OhQBKwM1sLylmg/PfTSBWpQwBrHCjvs2j9TLEUhin2SbA5Arcjf5e5sf6Cqar9pWLUsz3V4Z+7vBAAWvlG+hpawlRNObt+Y+6FKk8N54CWJ2vbuwgsfUke8rYwdAAglRwLM+Y6yzftAivY01VsfqBszjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2uN1nZS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712903189; x=1744439189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A9td/u3rL3CsEVlgoV3nHZed2uzaUWhm37Vu6ewAR6k=;
  b=H2uN1nZSuvO07ib8rrOThAOern+onS1Tg7ahNCEJojaB/QqWowiPhr+2
   X3f6fbGdrsjroZ/NAKiN8OZIRROs6iF3u4JgWB4ad2fI7kw8KkneqJEz+
   G81uqZuEBzSDedD1v2WadS8k1pTzUhHq/4P18PXNNYnvkk4vAjsrPfZfO
   dOiIqzLfwuKhqcmN97yokHx3rgWM30Dqexh9PqBypt9g/0t6j58Fo/tAb
   jLSyN9gMeSHfdY50hPFWgCj4iUnMwW8oiOkuO+yGhMfvxMaH3hwWYdbru
   q9Nds8EiLicqDp/nsgdNTphJwG+KARf6C46zlDUPvk8a7zCiPnSvODZnE
   w==;
X-CSE-ConnectionGUID: PQKvGaOKSFmgBK9oQIUoAA==
X-CSE-MsgGUID: ZeT9JUC1Tm+io7HJdSFFFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18952968"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="18952968"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:26:29 -0700
X-CSE-ConnectionGUID: Otg8klPlT5iZgQ1f8g7TNQ==
X-CSE-MsgGUID: FyWT2il0RuGOqk5CPCrdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21105129"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 11 Apr 2024 23:26:26 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v3 6/7] ice: implement netdev for subfunction
Date: Fri, 12 Apr 2024 08:30:52 +0200
Message-ID: <20240412063053.339795-7-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Raczynski <piotr.raczynski@intel.com>

Configure netdevice for subfunction usecase. Mostly it is reusing ops
from the PF netdevice.

SF netdev is linked to devlink port registered after SF activation.

Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 85 ++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 70f7cbe6c609..2b69dd5facf9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -2,11 +2,85 @@
 /* Copyright (c) 2024, Intel Corporation. */
 #include "ice.h"
 #include "ice_lib.h"
+#include "ice_txrx.h"
 #include "ice_fltr.h"
 #include "ice_sf_eth.h"
 #include "devlink/devlink_port.h"
 #include "devlink/devlink.h"
 
+static const struct net_device_ops ice_sf_netdev_ops = {
+	.ndo_open = ice_open,
+	.ndo_stop = ice_stop,
+	.ndo_start_xmit = ice_start_xmit,
+	.ndo_vlan_rx_add_vid = ice_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = ice_vlan_rx_kill_vid,
+	.ndo_change_mtu = ice_change_mtu,
+	.ndo_get_stats64 = ice_get_stats64,
+	.ndo_tx_timeout = ice_tx_timeout,
+	.ndo_bpf = ice_xdp,
+	.ndo_xdp_xmit = ice_xdp_xmit,
+	.ndo_xsk_wakeup = ice_xsk_wakeup,
+};
+
+/**
+ * ice_sf_cfg_netdev - Allocate, configure and register a netdev
+ * @dyn_port: subfunction associated with configured netdev
+ * @devlink_port: subfunction devlink port to be linked with netdev
+ *
+ * Return: 0 on success, negative value on failure
+ */
+static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
+			     struct devlink_port *devlink_port)
+{
+	struct ice_vsi *vsi = dyn_port->vsi;
+	struct ice_netdev_priv *np;
+	struct net_device *netdev;
+	int err;
+
+	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
+				    vsi->alloc_rxq);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, &vsi->back->pdev->dev);
+	set_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
+	vsi->netdev = netdev;
+	np = netdev_priv(netdev);
+	np->vsi = vsi;
+
+	ice_set_netdev_features(netdev);
+
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
+			       NETDEV_XDP_ACT_RX_SG;
+
+	eth_hw_addr_set(netdev, dyn_port->hw_addr);
+	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
+	netdev->netdev_ops = &ice_sf_netdev_ops;
+	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
+
+	err = register_netdev(netdev);
+	if (err) {
+		free_netdev(netdev);
+		vsi->netdev = NULL;
+		return -ENOMEM;
+	}
+	set_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+
+	return 0;
+}
+
+static void ice_sf_decfg_netdev(struct ice_vsi *vsi)
+{
+	unregister_netdev(vsi->netdev);
+	clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
+	free_netdev(vsi->netdev);
+	vsi->netdev = NULL;
+	clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
+}
+
 /**
  * ice_sf_dev_probe - subfunction driver probe function
  * @adev: pointer to the auxiliary device
@@ -55,18 +129,26 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 		goto err_vsi_decfg;
 	}
 
+	err = ice_sf_cfg_netdev(dyn_port, &sf_dev->priv->devlink_port);
+	if (err) {
+		dev_err(dev, "Subfunction netdev config failed");
+		goto err_devlink_destroy;
+	}
+
 	err = ice_fltr_add_mac_and_broadcast(vsi, vsi->netdev->dev_addr,
 					     ICE_FWD_TO_VSI);
 	if (err) {
 		dev_err(dev, "can't add MAC filters %pM for VSI %d\n",
 			vsi->netdev->dev_addr, vsi->idx);
-		goto err_devlink_destroy;
+		goto err_netdev_decfg;
 	}
 
 	ice_napi_add(vsi);
 
 	return err;
 
+err_netdev_decfg:
+	ice_sf_decfg_netdev(vsi);
 err_devlink_destroy:
 	ice_devlink_destroy_sf_dev_port(sf_dev);
 err_vsi_decfg:
@@ -89,6 +171,7 @@ static void ice_sf_dev_remove(struct auxiliary_device *adev)
 
 	ice_vsi_close(vsi);
 
+	ice_sf_decfg_netdev(vsi);
 	ice_devlink_destroy_sf_dev_port(sf_dev);
 	devlink_unregister(devlink);
 	devlink_free(devlink);
-- 
2.42.0


