Return-Path: <netdev+bounces-36604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B9E7B0BC7
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8EA791C20905
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A34C86F;
	Wed, 27 Sep 2023 18:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135384C84C
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:14:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4631011D
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRxAPSbmKn5vaTD+FH2Y5H8HN3s586CWH52ZI8GzQo11mnv7C2Rsk/YT5IzoJryTg3BwXRnIh7cPG91gXt6puubwXEGNvR+nN9S0T6q3u/FJE4nKRKuy7jgTLeUXOf+v9rAnz7rCM9hxBTMEHP4NG4XkHRF3VXuiouhXyWxQ8iIQd0pP3drsWrt9juls2tulyZb12GfyOmvGBfVTArqBBpy+YsUmwNLL+3NcHLATLA3l6xFX0jDPMvEni5XrK1hr7WKblU9Uj4yVnffJmd2LCAbJfQgEhJpDdSXVsSxRmPaufc1smsnbVS79UMRWR2qzdwdymrzMbGNPseUyDfzeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sbWH9lgZKSmKud3P4+FlLCnszaAgnU89ovwEAc4Zgo=;
 b=fDJYDGAIPWMzli2MmamUWeLuK9nk+AiJHD/EtW7oZnauUhFmKdGZ5Mkv87k49aaVIll27frYJhPyHeWidVL3FwtZBBL17Gh9nhCkryJpRU1kyRhe3ZTjB3iXXQ8e+d3DvbDiLVjkCb5WetUD4vGslgFVP6Bqx8rzA377pc/+D3ciE3/HfT92PmATEqNVGNHPK6UG2TMDDxU55h+1s4irXpczRUfphz8tCzhbiWl7GVbaH+sbiOTBWy6c8fgkUHBoMySo2Lj+MHTOJb4kgCt+vlxoW1CsQB/Uy20/86X0SIGsvEFPirVJHJlH+yvnN7jMbBD92r+K+lj2c+Y8zwFqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sbWH9lgZKSmKud3P4+FlLCnszaAgnU89ovwEAc4Zgo=;
 b=3RO53ImQMQ5RnSOyNvjvl/IA1lwJZ4x+u/uoBu/GZOYOy8rjJPII89QCPOTkDrhYpr+bkdCf0gJr5zFTV9gmE3cpd0OdwglRDcB2084i1k+eIzeuF13vkZIlNBxUiX8nzVbgMkflsv/Niy8yzdwVRtP/K35hozdw/RPFLgEsTB0=
Received: from CH0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:610:119::33)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 18:14:26 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::38) by CH0PR03CA0378.outlook.office365.com
 (2603:10b6:610:119::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 18:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:14:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:14:24 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 13:14:23 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of custom RSS contexts to a netdevice
Date: Wed, 27 Sep 2023 19:13:33 +0100
Message-ID: <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1695838185.git.ecree.xilinx@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e149b5-c3b6-475d-a594-08dbbf859546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R1XW10S3oNAecSPA/6kILpeUfdUehJUcNL3d7HTUZ+NCTawls7az9RE1DWWjiOMCFFsf1hjYHI9gyrXS72awI6wQ5Tg1eOG16a6qdjAKro1hOVQO95GvXzzrVKxzLXmmPTsYNF+PqVqYA+Q/kXTpZw4dztIB2b38uqpxJvEj/PgWwHA2XtvuxY/kFyxNF7UJqGk6MB8rylzF/PZSAgJViAiKyUuHKt7KvwYI3RNDBdSnr6ILvsBE7ORPOb2GL6R7cqa4iGpI0gxEr+TvQHP4wWVmkfxN10EamkmDXXLJt+uJEevnHvYfCzMZ7e6ah3+xGQwjv5fKZSlJACNkWYnrgBks3u0SPpwLfr1mCcFA3x1q5jvMMfaFO8e/owTCFT8ZdzVqmY8zxvPpzvNWqgHS1VurDGbiGWi60tVHZWdh/DuZ9fv7IPZuHlU01QDNss4lXtVAel1eGOotXWISI7x24xowVUDRCGsXI6Ztdb0F1Yu2WuXk2uvzuV2hTMXSALJvGMD180kq3V+4UFhhRzUbYlvf2NvOjG9iZiupdch/nIUSwsr2doW67Q1b6xgO/wEtnthdGU68xQVUMOd4YPkSqSZxNIOYRn66gEZSw73k4r3TdzJ1nZ4ygJl8552bz5eWQQI+nh4KXK2F4yk/F9W6Rcjxpjj2aT3UF/Wz0lo5jtmIFNZe98niEOeqhwMsBXwy1BYrWTv8/okqig6yIKz4m0tYgr+T38z7ecS4NZ/wqULwuzymUwSDnEyh5rwxq1ytU+60/AQCab72ZIAl7TVy1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(54906003)(316002)(70206006)(70586007)(110136005)(26005)(336012)(83380400001)(426003)(9686003)(36756003)(81166007)(6666004)(82740400003)(356005)(55446002)(36860700001)(47076005)(40480700001)(86362001)(478600001)(40460700003)(2876002)(2906002)(7416002)(8936002)(8676002)(4326008)(41300700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:14:25.8110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e149b5-c3b6-475d-a594-08dbbf859546
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Each context stores the RXFH settings (indir, key, and hfunc) as well
 as optionally some driver private data.
Delete any still-existing contexts at netdev unregister time.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 43 ++++++++++++++++++++++++++++++++++++++++-
 net/core/dev.c          | 25 ++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 8aeefc0b4e10..bb11cb2f477d 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -157,6 +157,43 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 	return index % n_rx_rings;
 }
 
+/**
+ * struct ethtool_rxfh_context - a custom RSS context configuration
+ * @indir_size: Number of u32 entries in indirection table
+ * @key_size: Size of hash key, in bytes
+ * @hfunc: RSS hash function identifier.  One of the %ETH_RSS_HASH_*
+ * @priv_size: Size of driver private data, in bytes
+ * @indir_no_change: indir was not specified at create time
+ * @key_no_change: hkey was not specified at create time
+ */
+struct ethtool_rxfh_context {
+	u32 indir_size;
+	u32 key_size;
+	u8 hfunc;
+	u16 priv_size;
+	u8 indir_no_change:1;
+	u8 key_no_change:1;
+	/* private: driver private data, indirection table, and hash key are
+	 * stored sequentially in @data area.  Use below helpers to access.
+	 */
+	u8 data[] __aligned(sizeof(void *));
+};
+
+static inline void *ethtool_rxfh_context_priv(struct ethtool_rxfh_context *ctx)
+{
+	return ctx->data;
+}
+
+static inline u32 *ethtool_rxfh_context_indir(struct ethtool_rxfh_context *ctx)
+{
+	return (u32 *)(ctx->data + ALIGN(ctx->priv_size, sizeof(u32)));
+}
+
+static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
+{
+	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
+}
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
@@ -937,10 +974,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 
 /**
  * struct ethtool_netdev_state - per-netdevice state for ethtool features
+ * @rss_ctx:		XArray of custom RSS contexts
+ * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
  * @wol_enabled:	Wake-on-LAN is enabled
  */
 struct ethtool_netdev_state {
-	unsigned		wol_enabled:1;
+	struct xarray		rss_ctx;
+	u32			rss_ctx_max_id;
+	u32			wol_enabled:1;
 };
 
 struct phy_device;
diff --git a/net/core/dev.c b/net/core/dev.c
index 9e85a71e33ed..05e95abdfd17 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10072,6 +10072,9 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		return ret;
 
+	/* rss ctx ID 0 is reserved for the default context, start from 1 */
+	xa_init_flags(&dev->ethtool->rss_ctx, XA_FLAGS_ALLOC1);
+
 	spin_lock_init(&dev->addr_list_lock);
 	netdev_set_addr_lockdep_class(dev);
 
@@ -10874,6 +10877,26 @@ void synchronize_net(void)
 }
 EXPORT_SYMBOL(synchronize_net);
 
+static void netdev_rss_contexts_free(struct net_device *dev)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	if (dev->ethtool_ops->set_rxfh_context)
+		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+			u32 *indir = ethtool_rxfh_context_indir(ctx);
+			u8 *key = ethtool_rxfh_context_key(ctx);
+			u32 concast = context;
+
+			xa_erase(&dev->ethtool->rss_ctx, context);
+			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
+							   ctx->hfunc, &concast,
+							   true);
+			kfree(ctx);
+		}
+	xa_destroy(&dev->ethtool->rss_ctx);
+}
+
 /**
  *	unregister_netdevice_queue - remove device from the kernel
  *	@dev: device
@@ -10978,6 +11001,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 
+		netdev_rss_contexts_free(dev);
+
 		call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
 
 		if (dev->netdev_ops->ndo_uninit)

