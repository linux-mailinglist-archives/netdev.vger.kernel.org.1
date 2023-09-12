Return-Path: <netdev+bounces-33255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5379D37D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE1A281DCD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E918B1A;
	Tue, 12 Sep 2023 14:22:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB918AEE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:22:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22E3110
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsAuwwy8RX79iBgdKSuwOFaXK46sUklnFsxlGlLMx9GYU+hUxbhp6ydjXG7BQzNy0EBIgYiShTTIuU/BS8mh3FeXDKLM0hw+BukBZUELdBKvPzMnU7x+tDF+0mS278lPRCbRC7YrR/VhvZHaKtZTCw0tMk1db2vspj3tMAGhx8PY1RkX26LMftvsGTQiu7QRiLNvMBH8zUIaDK5Ag7Ol+0weswF5zhNupBsD94HEcW4HkOsSEF5uzhjlILBKtpZ1Ua/g1INAefnyVYQxMeFLRV1BFHnyp7blHX1Uk29dkxiBnh5grnK7AeI2oQPSPNbivgx8/3T/CKf1ywIhuj0J+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z34O/3YzNNi/Ujyu7vTVxznFFfXItspFLIU2m4qlqvI=;
 b=YJdz4+sP6xiJwdyUvhGS9eJWFGSdWNRI9RikW5wCeEbDLs+T3adfeh/x443SgQBORd444nX6nH+aH4OBkf15N9IDZZenc5jEw+zjzE3jUFo+X9SR6rGgh7gii8Z2CB2G1vE1Ik1sRb4WYBc0urtlW+mv/JuPBTXCQm1oXQtgtN68O3dJPz7q+OM9tOBd8sZ9z44kWl438JrV/VT/8zukMuCZgPe+Ln6Ebwf3rnlNbRuogik++q9/jNMowxxK0HkMoMkb1GvrayyWccpFP4puwE1R0vVQFWyhPan97ATVBXgTV9ubQjf9nh8JNN6PHDIuTp5HTwRt7BzkekyYRwpvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z34O/3YzNNi/Ujyu7vTVxznFFfXItspFLIU2m4qlqvI=;
 b=GI0xwe78xxk4QgnHVni0lXXqXdyY7Ie07+AEHwYdFzkslkBNzgJDZUuZ29EknFeewNWu2LaiIgjhA5SE5525RuENRTlHHUv93le4H5cReSsRZUkSmFnUXPnfP7YKO91iCrtCbiMzoqYcHrrx/aKLOwfVnfBOmQ+n/OzIrKPI+iQ=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Tue, 12 Sep 2023 14:22:26 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::1) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.17 via Frontend
 Transport; Tue, 12 Sep 2023 14:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 14:22:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 07:22:25 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 12 Sep 2023 09:22:22 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [RFC PATCH v3 net-next 2/7] net: ethtool: attach an IDR of custom RSS contexts to a netdevice
Date: Tue, 12 Sep 2023 15:21:37 +0100
Message-ID: <9c71d5168e1ee22b40625eec53a8bb00456d60ed.1694443665.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 977b8bce-65bb-4f50-136e-08dbb39bb06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lYSTLr/DOKy++WQRhKLk/hLutEGcAfLGnEApJH2O1wQihhTWNgORxIulsxbs/eE9U6qNEDaR5XHj+oK1H5ykPzcXvKwPqOd0ik69vRxK3w3ie2a98j9nEpHJzGQil0lSEdE+dvF7ey+lUPdGwBvXEMKF9jamokAM6JfHkevb5emHyqtjrCutCTmdjVCGoGbAwvwH+XFQP5QwNkLFgH4iOlRO4P+DI4JTI24R0ZHE30cbXPFkSjypqLvP66AxSlwmymWj1aJl/+zSXptcbhYGMnM6XTGUTbKfHLvS/PeaAySnSiGPk0QYQf/LvkCDoHep3mTZAkGidNUwQLph8b4+xLKO/18DiIowMkMEQazq+g95eQi1QAfCWss4aknjUhY+RD6xxEXrD3QciGBaKqpwgxTB7fMUfmQBRzNFk06pda52+qad0hrb7e2EfrwQcTA+gZDs2N7yxhZ5YfuJ+6pnUWl2Ya9cphuDJckI7Firoihu1qVvS3Y9LCZxFAaZMfH06B3mdgp7dO97D3b22DSlldKeIa89jy6zUUgGhuovRkNi6/Cnlo+gubDA9vi0zlKonK3KWubrZdZZjhFPMgqIAJny+hwtZyxuDPJaZIZYGZuZkGpt8vhuWuaCb8J518GqM7zLjwOjiKhpOZpnxsPXFFi/Q7hthIK2c0nZ6uOdsFCnEt/CHZSuuNf9CpuNCMzNjwpIJEa9/vanhoNxY9UNjVA8bogCP63csXcp3rg3EQoFJE9FnNMn0Oq2H7xlkKeP18vM5MkoAQnL2flThu7aJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(81166007)(41300700001)(316002)(7416002)(26005)(40480700001)(336012)(426003)(2876002)(110136005)(54906003)(8676002)(4326008)(70586007)(70206006)(2906002)(8936002)(478600001)(5660300002)(6666004)(40460700003)(9686003)(36756003)(36860700001)(47076005)(83380400001)(86362001)(55446002)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:22:26.3517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977b8bce-65bb-4f50-136e-08dbb39bb06d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867

From: Edward Cree <ecree.xilinx@gmail.com>

Each context stores the RXFH settings (indir, key, and hfunc) as well
 as optionally some driver private data.
Delete any still-existing contexts at netdev unregister time.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 43 ++++++++++++++++++++++++++++++++++++++++-
 net/core/dev.c          | 23 ++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 8aeefc0b4e10..c770e32d79e6 100644
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
+ * @rss_ctx:		IDR storing custom RSS context state
+ * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
  * @wol_enabled:	Wake-on-LAN is enabled
  */
 struct ethtool_netdev_state {
-	unsigned		wol_enabled:1;
+	struct idr		rss_ctx;
+	u32			rss_ctx_max_id;
+	u32			wol_enabled:1;
 };
 
 struct phy_device;
diff --git a/net/core/dev.c b/net/core/dev.c
index bb3841371349..4bbb6bda7b7e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10050,6 +10050,9 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		return ret;
 
+	/* rss ctx ID 0 is reserved for the default context, start from 1 */
+	idr_init_base(&dev->ethtool->rss_ctx, 1);
+
 	spin_lock_init(&dev->addr_list_lock);
 	netdev_set_addr_lockdep_class(dev);
 
@@ -10852,6 +10855,24 @@ void synchronize_net(void)
 }
 EXPORT_SYMBOL(synchronize_net);
 
+static void netdev_rss_contexts_free(struct net_device *dev)
+{
+	struct ethtool_rxfh_context *ctx;
+	u32 context;
+
+	if (!dev->ethtool_ops->set_rxfh_context)
+		return;
+	idr_for_each_entry(&dev->ethtool->rss_ctx, ctx, context) {
+		u32 *indir = ethtool_rxfh_context_indir(ctx);
+		u8 *key = ethtool_rxfh_context_key(ctx);
+
+		idr_remove(&dev->ethtool->rss_ctx, context);
+		dev->ethtool_ops->set_rxfh_context(dev, indir, key, ctx->hfunc,
+						   &context, true);
+		kfree(ctx);
+	}
+}
+
 /**
  *	unregister_netdevice_queue - remove device from the kernel
  *	@dev: device
@@ -10956,6 +10977,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 
+		netdev_rss_contexts_free(dev);
+
 		call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
 
 		if (dev->netdev_ops->ndo_uninit)

