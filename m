Return-Path: <netdev+bounces-33257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2720779D37F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46071C20D52
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222418C13;
	Tue, 12 Sep 2023 14:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73F18C05
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:22:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA9110
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAaHx8u26epG7YsB89xiIeRhaB84NpHOLENYYrygR6FEtPLwQaZ/eAvFfvTEycJyk58tuaqS3KKK6jvLPq7DoJKPqdfXpreLZefNdgOs/RhJpbNWBoPLd67H6lnRtJXGp8zbcN/igbEzw5KvYkCgCr7NuUK3QHFM9Q3wzaZvICxFC2LQTQyJABthBsBdz6l00lxAC58VhEculXjnxTuUPr5+Ne5vssenDy28DP9MUIn5IfRJ4+gkfynBIt3Z9KvF3bAtGktYTsAG6cCc+TxgRmzbR+PHfji7Gviv/H3JTi16eRXq1LPJen7cBPAgQjBHB/V4M907p1xhVAKDUyW6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jto2N4hXTY1Y1s32B6HG8MYviT2F0gqZBT+K2zwtYdQ=;
 b=ZzppZKgxerEPxUpZ6Xo0UEfZXCmlT6tmfHXYd3zUhArgSsCGXS2eu8gL0Xmi1ibalWXL1MQIU7XD1HVGjpKLFgNvUzEQLrK6Kp34TW3TPySoOoXulKcrWaX7z2bH9wA9lvcsL5auS4SKVsT0V4T9DzIUmqRZ/XNxvETqmSinJbCSeOra8SlnUIzaPO8qH3yc/+EdfqOFufB27N0+VHiD8Y7WcbKeipuQbt6Yr8DKuQe2J7DSddoTAXIBrEpszVCN5MNItWbdULo88oNiV8sBeMOYVnlEP+TAMeewnyp6n70dSLWWCQ+IVvDvfv+PxCX0Nk9P2gIGkRkKnSbYKdhVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jto2N4hXTY1Y1s32B6HG8MYviT2F0gqZBT+K2zwtYdQ=;
 b=iUnAAC+avzhogmsGbjZqTepvWjHzNPnSv9IWZkil/r4giFGdZtWPNTNYD6zec7A8GCQFKO+Kiz2AdOErGHKq4svvn4OmZ7dn9rozUwvEdXGkT8Y4nlt28kfqH7VoB3XYPZ8gF1Lwc6JYHfOxbeU64v+ZWJP1R06hYfuBDGKc4hs=
Received: from BYAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:74::19)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 14:22:30 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:a03:74:cafe::e3) by BYAPR05CA0042.outlook.office365.com
 (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16 via Frontend
 Transport; Tue, 12 Sep 2023 14:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Tue, 12 Sep 2023 14:22:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:29 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 12 Sep 2023 09:22:27 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [RFC PATCH v3 net-next 4/7] net: ethtool: let the core choose RSS context IDs
Date: Tue, 12 Sep 2023 15:21:39 +0100
Message-ID: <b0de802241f4484d44379f9a990e69d67782948e.1694443665.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1694443665.git.ecree.xilinx@gmail.com>
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BN9PR12MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 9190fe5c-427e-4301-b056-08dbb39bb2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JKL1u+oJdj4AC1NLqAssF5n9yVY0WiEW4zy9BLlYFm61+EZWuzJat1u+886Syd7Y1VvnNC+xDG+QXgvffGAljfZoRUqm/gZ5MKm3OzfsNlLg7VSSEH6/Bd4vc2IGS6OZ2t7ulaBaTGh1U8jEgVmSDhD/SkBpkD2KFLUy+VdWgkzGfte8k+EFvfgxL3P4vhtJ1KQ2FNysBl0SBikl0v4uo1kJQn5HSnMIuaNbNwjxccDKd4MpKD9A8/7Hkfme77Oh8KPPF1k7aFGaC+tTtbd7p6YlxAvhaIAkUXQmOgzBKTImzFgjqi4ryhNgTvD6Yj4qyCJmBLd/YesbntBpOMw5KsPZt+j1wUwTqlx4ju+vTR5vZZHG8Uh0bydTvo1tCFezAyXMZjV3X2ggzVlDe54RBtKsJZk+s0bUvVV9pHCbIQmDmkU28KDqwsYFdG+x7MN9aqZf342Xqhz3dCe8VkPsrDythlSrKR2UCedx2kEXxIwx/EdtT1ysDwAVP/CBvcjafvjDftiZe6+sYsFTnPooG4FdqxD9r+GOoHHhG5RfWN5PsrY64FvsI5uynU0ha2jsJRXq1T6OlEWP6LqgN6woahIT9KaG3iQLoOaz54DtsRmfQJzOYxs2cpbggUNRz+luYN6KnfU/gtyn+vF6Okx2cw6y8ym25JBx5+epAD6TFeggQcinmgKyHWSx+MvOWn6QbeoQsb2CPpCWh4XIFj7SbhPWB2ee5DoIXfBmpzHQ/Uo14/Zz+dVETjkbxp5LZ0nhKHLHCMsf98xDeRgC7CU53g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(9686003)(478600001)(41300700001)(83380400001)(426003)(26005)(336012)(7416002)(54906003)(8936002)(70206006)(70586007)(5660300002)(2876002)(110136005)(316002)(2906002)(4326008)(8676002)(40460700003)(82740400003)(47076005)(36860700001)(86362001)(36756003)(40480700001)(55446002)(356005)(81166007)(66899024)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:22:30.4124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9190fe5c-427e-4301-b056-08dbb39bb2d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308

From: Edward Cree <ecree.xilinx@gmail.com>

Add a new API to create/modify/remove RSS contexts, that passes in the
 newly-chosen context ID (not as a pointer) rather than leaving the
 driver to choose it on create.  Also pass in the ctx, allowing drivers
 to easily use its private data area to store their hardware-specific
 state.
Keep the existing .set_rxfh_context API for now as a fallback, but
 deprecate it.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 40 ++++++++++++++++++++++++--
 net/core/dev.c          | 11 +++++--
 net/ethtool/ioctl.c     | 64 +++++++++++++++++++++++++++++++----------
 3 files changed, 94 insertions(+), 21 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f7317b53ab61..4fa2a7f6ed4c 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -747,10 +747,33 @@ struct ethtool_mm_stats {
  * @get_rxfh_context: Get the contents of the RX flow hash indirection table,
  *	hash key, and/or hash function assiciated to the given rss context.
  *	Returns a negative error code or zero.
- * @set_rxfh_context: Create, remove and configure RSS contexts. Allows setting
+ * @create_rxfh_context: Create a new RSS context with the specified RX flow
+ *	hash indirection table, hash key, and hash function.
+ *	Arguments which are set to %NULL or zero will be populated to
+ *	appropriate defaults by the driver.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
+ *	note that the indir table, hkey and hfunc are not yet populated as
+ *	of this call.  The driver does not need to update these; the core
+ *	will do so if this op succeeds.
+ *	If the driver provides this method, it must also provide
+ *	@modify_rxfh_context and @remove_rxfh_context.
+ *	Returns a negative error code or zero.
+ * @modify_rxfh_context: Reconfigure the specified RSS context.  Allows setting
  *	the contents of the RX flow hash indirection table, hash key, and/or
- *	hash function associated to the given context. Arguments which are set
- *	to %NULL or zero will remain unchanged.
+ *	hash function associated with the given context.
+ *	Arguments which are set to %NULL or zero will remain unchanged.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
+ *	note that it will still contain the *old* settings.  The driver does
+ *	not need to update these; the core will do so if this op succeeds.
+ *	Returns a negative error code or zero. An error code must be returned
+ *	if at least one unsupported change was requested.
+ * @remove_rxfh_context: Remove the specified RSS context.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx.
+ *	Returns a negative error code or zero.
+ * @set_rxfh_context: Deprecated API to create, remove and configure RSS
+ *	contexts. Allows setting the contents of the RX flow hash indirection
+ *	table, hash key, and/or hash function associated to the given context.
+ *	Arguments which are set to %NULL or zero will remain unchanged.
  *	Returns a negative error code or zero. An error code must be returned
  *	if at least one unsupported change was requested.
  * @get_channels: Get number of channels.
@@ -901,6 +924,17 @@ struct ethtool_ops {
 			    const u8 *key, const u8 hfunc);
 	int	(*get_rxfh_context)(struct net_device *, u32 *indir, u8 *key,
 				    u8 *hfunc, u32 rss_context);
+	int	(*create_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       const u32 *indir, const u8 *key,
+				       const u8 hfunc, u32 rss_context);
+	int	(*modify_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       const u32 *indir, const u8 *key,
+				       const u8 hfunc, u32 rss_context);
+	int	(*remove_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       u32 rss_context);
 	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
 				    const u8 *key, const u8 hfunc,
 				    u32 *rss_context, bool delete);
diff --git a/net/core/dev.c b/net/core/dev.c
index 4bbb6bda7b7e..6b8e5fd8691b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10860,15 +10860,20 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 	struct ethtool_rxfh_context *ctx;
 	u32 context;
 
-	if (!dev->ethtool_ops->set_rxfh_context)
+	if (!dev->ethtool_ops->create_rxfh_context &&
+	    !dev->ethtool_ops->set_rxfh_context)
 		return;
 	idr_for_each_entry(&dev->ethtool->rss_ctx, ctx, context) {
 		u32 *indir = ethtool_rxfh_context_indir(ctx);
 		u8 *key = ethtool_rxfh_context_key(ctx);
 
 		idr_remove(&dev->ethtool->rss_ctx, context);
-		dev->ethtool_ops->set_rxfh_context(dev, indir, key, ctx->hfunc,
-						   &context, true);
+		if (dev->ethtool_ops->create_rxfh_context)
+			dev->ethtool_ops->remove_rxfh_context(dev, ctx, context);
+		else
+			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
+							   ctx->hfunc,
+							   &context, true);
 		kfree(ctx);
 	}
 }
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index db596b61c6ab..4ce960a5ad4c 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1274,7 +1274,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
-	if (rxfh.rss_context && !ops->set_rxfh_context)
+	if (rxfh.rss_context && !(ops->create_rxfh_context ||
+				  ops->set_rxfh_context))
 		return -EOPNOTSUPP;
 	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
 
@@ -1349,8 +1350,28 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 		ctx->indir_size = dev_indir_size;
 		ctx->key_size = dev_key_size;
-		ctx->hfunc = rxfh.hfunc;
 		ctx->priv_size = ops->rxfh_priv_size;
+		/* Initialise to an empty context */
+		ctx->indir_no_change = ctx->key_no_change = 1;
+		ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
+		if (ops->create_rxfh_context) {
+			int ctx_id;
+
+			/* driver uses new API, core allocates ID */
+			/* if rss_ctx_max_id is not specified (left as 0), it is
+			 * treated as INT_MAX + 1 by idr_alloc
+			 */
+			ctx_id = idr_alloc(&dev->ethtool->rss_ctx, ctx, 1,
+					   dev->ethtool->rss_ctx_max_id,
+					   GFP_KERNEL_ACCOUNT);
+			/* 0 is not allowed, so treat it like an error here */
+			if (ctx_id <= 0) {
+				kfree(ctx);
+				ret = -ENOMEM;
+				goto out;
+			}
+			rxfh.rss_context = ctx_id;
+		}
 	} else if (rxfh.rss_context) {
 		ctx = idr_find(&dev->ethtool->rss_ctx, rxfh.rss_context);
 		if (!ctx) {
@@ -1359,15 +1380,34 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 	}
 
-	if (rxfh.rss_context)
-		ret = ops->set_rxfh_context(dev, indir, hkey, rxfh.hfunc,
-					    &rxfh.rss_context, delete);
-	else
+	if (rxfh.rss_context) {
+		if (ops->create_rxfh_context) {
+			if (create)
+				ret = ops->create_rxfh_context(dev, ctx, indir,
+							       hkey, rxfh.hfunc,
+							       rxfh.rss_context);
+			else if (delete)
+				ret = ops->remove_rxfh_context(dev, ctx,
+							       rxfh.rss_context);
+			else
+				ret = ops->modify_rxfh_context(dev, ctx, indir,
+							       hkey, rxfh.hfunc,
+							       rxfh.rss_context);
+		} else {
+			ret = ops->set_rxfh_context(dev, indir, hkey,
+						    rxfh.hfunc,
+						    &rxfh.rss_context, delete);
+		}
+	} else {
 		ret = ops->set_rxfh(dev, indir, hkey, rxfh.hfunc);
+	}
 	if (ret) {
-		if (create)
+		if (create) {
 			/* failed to create, free our new tracking entry */
+			if (ops->create_rxfh_context)
+				idr_remove(&dev->ethtool->rss_ctx, rxfh.rss_context);
 			kfree(ctx);
+		}
 		goto out;
 	}
 
@@ -1383,12 +1423,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			dev->priv_flags |= IFF_RXFH_CONFIGURED;
 	}
 	/* Update rss_ctx tracking */
-	if (create) {
-		/* Ideally this should happen before calling the driver,
-		 * so that we can fail more cleanly; but we don't have the
-		 * context ID until the driver picks it, so we have to
-		 * wait until after.
-		 */
+	if (create && !ops->create_rxfh_context) {
+		/* driver uses old API, it chose context ID */
 		if (WARN_ON(idr_find(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
 			/* context ID reused, our tracking is screwed */
 			kfree(ctx);
@@ -1398,8 +1434,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		WARN_ON(idr_alloc(&dev->ethtool->rss_ctx, ctx, rxfh.rss_context,
 				  rxfh.rss_context + 1, GFP_KERNEL) !=
 			rxfh.rss_context);
-		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
-		ctx->key_no_change = !rxfh.key_size;
 	}
 	if (delete) {
 		WARN_ON(idr_remove(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);

