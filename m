Return-Path: <netdev+bounces-96369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87AA8C577F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8B1282736
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425001448EA;
	Tue, 14 May 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="UEHyJnzM"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB96D1A7
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695392; cv=none; b=MbPV35nqcwpnw+MoUGC14XWz1GiaAKuxrsMfe403PqlQdOvvSwnJavHu11d1G5obDJm27kn26ikcrbHj5R/luoTx/WWfhiYFIVf6+O/+63xxvew8XWk7aU2c5kcoutG8gHhA5Xea/ptNc82S4HL75tz1bSqt1ahw28dzebc5FWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695392; c=relaxed/simple;
	bh=Q23/aKu4i2YT/OD5u00bUgJ9yeUU9RQBAFAnB9R9z+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYjpLeL7YHRrPM+BsL8NFamdYc7iKsbaZqivN0BAqe4g/qEiYzvoKk1NSAUZmuncfjQHWvvgknzvFXbm4ewFPt0KkJCNG8zG0NApXWugNNrAooM5idPZG89RWk3i/PgCEMQ3IBa8Wzp1CT4w2KNFCKmtGeUF8MUXjbCkTaTLKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=UEHyJnzM; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024051412223846ff346061121c8d94
        for <netdev@vger.kernel.org>;
        Tue, 14 May 2024 14:22:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LPGohqmOK72ipupZwALJmvxGKmEGysxO6IJocO3bJug=;
 b=UEHyJnzMnUHg0NTgKmLyzHqjMEC2o/Y6RjFsNOzoEepXQEmFcfEJXtn6R1cpUURcwC3HEc
 oqX33ppk7jlMmIpz+bVMkmLWiy+9aBrX6q7P53FoYy7BiSmDUt0rokBkLArcdP5Sme7XQnYI
 mrH9YcqduzgDzvdiKI7g+wo0smlWw=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH 1/2] net: ethernet: ti: am65-cpsw-nuss: rename phy_node -> port_np
Date: Tue, 14 May 2024 14:22:27 +0200
Message-ID: <20240514122232.662060-1-alexander.sverdlin@siemens.com>
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
2.44.0


