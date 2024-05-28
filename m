Return-Path: <netdev+bounces-98423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE588D15FC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDB21C22772
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B313F01A;
	Tue, 28 May 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="O8M/ObzG"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0413E3E4
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883821; cv=none; b=AN5cpmudkZuZi8vuMztxDKSjEWPp1rGenfD+b7PlYmvm13zG16c+z0+ssC3WdbxqtXwiFNPo03HyDgQgFM085YRAqMuiQV2OWDaeTAMI7HuKJWbj9Qppm6nanLl+9Bj0kGUiS5qScbvXzKFdm6eSP3/Tb+LFkK2qscBLLqb2+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883821; c=relaxed/simple;
	bh=hUGxzWZCbG9CgUPPS8GRGisRvmeTyw0DaMqtBsfarVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5s/YxG/5It0H1+0i/GKMOWIG1aLdHWHCdQLQ5ctZIgfVJXV2KtIZfvdi7B+MpDrAarBI9Q20z+qtZYXajOTWOm49XgkngB1XXCtfXveHigJQsWCsKM8sLjLoY6YpCT5f85aEKARawsK4CEWkbAHiOhCoVxbuVnaKEGEQnXFwbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=O8M/ObzG; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240528080002b06c9ad8b24f583cf0
        for <netdev@vger.kernel.org>;
        Tue, 28 May 2024 10:00:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9J++/nxeAwRJ3UV5r58wtBtkNiUMu/M5NJncIt+/vBM=;
 b=O8M/ObzGoE7sSRlPCnulYX0xNpxa6pbFjRQqsvyNZ7+otapAHqW00NbptqFqM2ICTjpciT
 vuweg6aRk2KLN/T49EhlWVAWRLn1CNrkJSmK3PNJVcsSY6X65k7aZuIDVOWgdeOXSInNpeEY
 BPjbKm68iuudPoOh9fefOH7cDiR4s=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH net-next 1/2] net: ethernet: ti: am65-cpsw-nuss: rename phy_node -> port_np
Date: Tue, 28 May 2024 09:59:49 +0200
Message-ID: <20240528075954.3608118-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20240528075954.3608118-1-alexander.sverdlin@siemens.com>
References: <20240528075954.3608118-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Rename phy_node to port_np to better reflect what it actually is,
because the new phylink API takes netdev node (or DSA port node),
and resolves the phandle internally.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 6 +++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 4e50b37928885..eaadf8f09c401 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -896,7 +896,7 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
 	/* mac_sl should be configured via phy-link interface */
 	am65_cpsw_sl_ctl_reset(port);
 
-	ret = phylink_of_phy_connect(port->slave.phylink, port->slave.phy_node, 0);
+	ret = phylink_of_phy_connect(port->slave.phylink, port->slave.port_np, 0);
 	if (ret)
 		goto error_cleanup;
 
@@ -2611,7 +2611,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 				of_property_read_bool(port_np, "ti,mac-only");
 
 		/* get phy/link info */
-		port->slave.phy_node = port_np;
+		port->slave.port_np = port_np;
 		ret = of_get_phy_mode(port_np, &port->slave.phy_if);
 		if (ret) {
 			dev_err(dev, "%pOF read phy-mode err %d\n",
@@ -2760,7 +2760,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	}
 
 	phylink = phylink_create(&port->slave.phylink_config,
-				 of_node_to_fwnode(port->slave.phy_node),
+				 of_node_to_fwnode(port->slave.port_np),
 				 port->slave.phy_if,
 				 &am65_cpsw_phylink_mac_ops);
 	if (IS_ERR(phylink))
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index d8ce88dc9c89a..e2ce2be320bd6 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -30,7 +30,7 @@ struct am65_cpts;
 struct am65_cpsw_slave_data {
 	bool				mac_only;
 	struct cpsw_sl			*mac_sl;
-	struct device_node		*phy_node;
+	struct device_node		*port_np;
 	phy_interface_t			phy_if;
 	struct phy			*ifphy;
 	struct phy			*serdes_phy;
-- 
2.45.0


