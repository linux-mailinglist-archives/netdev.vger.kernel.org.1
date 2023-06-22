Return-Path: <netdev+bounces-13082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1EE73A1E2
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EF8281990
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FAF1F17E;
	Thu, 22 Jun 2023 13:33:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B831E513
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:33:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F751BC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBng8x2VVK0DchReBHIlmKr9JN7OXvJzDThRPN6mmTQ/xneQOBXKkNF9xSJ1KWtGwhRVll1hJnR4LLZVpFGu9On3iTY4ZwR01/hcEU70N4pE8PZPj69qH22+lOw7Xb2Ipcyt/r1xb+uZRvU3EozJkBqKC/rJTvW+mKDxfbX7AzHazD6s2eRZsS/lRXCIlas1b3AUgwN5KJRENMtMWnlQRQm9kfjwsFBOZBqAr5fJl9ihacInnOy0QYzYEXJ6rBBkVJXnOp+RO6b0nsQLin63K3DzTbLg9aa6JCmhrK2kcb+TCS8H6blBwfnVuIeT90IUJdzkIP3uv/iEdFGmZEAoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og99m7Jgs5jXHll061CU1DuWdQaLkMofiPMgLyLZEfM=;
 b=diGdXly+d02yoc03BOTAerl1mgGQYdv6SwRuDBkX+JLXuzSDhSACC1nonybS6EgF0+Ac+cr28oghLAHKByzDTd6/N/TYrzyggCH59dXEP1mkm+NU6Rho8XfZRksDoFWYNOX+9cAVhQono9aifmGsY6UPnwzAVA0qHPkv2hn0vq6xAslfaxyHQsdwoJv3XKQAaJwC8W55YLKsbzFubAadvY+Sphn9EjOxdnG7rNfeWEIaRXcXXJ/f+lyEbfPGr82MWmKBrP6rw/Ki1kGY2Wty/yheejqqp1+wHALVF3jgzTWBx+QB+iXiE2WpFW36fojk98AEd30S0orM7AUN33Fi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og99m7Jgs5jXHll061CU1DuWdQaLkMofiPMgLyLZEfM=;
 b=Z40PTXo8Hm/LmImhLw/lwk04hhlvNTTY2oH5cqcBJefWG5d3Jo0w6PvMZMRd78QluCEkHFhArTzM4vdFOL9/1IL5CPFUANVSxSKGT5NiitXXPd+btmGAakUNU2vF3nxXYIKjMYcPkLQ0LkEwuAepvSaIJbGikBsZSBCKoj75A51DZElzfCxfq4CIT8AJTFk2Mae3B4ZnpTSTBbiypTySexVAKI4IihGXQSVYnyTtiFqg5ZllLLmIQRcPmC5Z7s/tVjPWducnzNE6nyn1QkQSDO8t11JP1h1DDFyjGN8bl5wlYlLCZ9reye+9mp2svLqm6y9y+ZyRIfCQojzQzbmO+g==
Received: from DS7PR03CA0155.namprd03.prod.outlook.com (2603:10b6:5:3b2::10)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:33:44 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::47) by DS7PR03CA0155.outlook.office365.com
 (2603:10b6:5:3b2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 13:33:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:35 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/8] mlxsw: spectrum_router: Maintain a hash table of CRIFs
Date: Thu, 22 Jun 2023 15:33:04 +0200
Message-ID: <186d44e399c475159da20689f2c540719f2d1ed0.1687438411.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687438411.git.petrm@nvidia.com>
References: <cover.1687438411.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 560ec94f-33a7-4de1-9e3d-08db73254c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Te8HwqzwTubvblOoPGW+363YBrqQpqne0ETKGMFDIgzr1SO4T8rLbuM6s7at+9HHYs5TZBTy3+KxPTBviTHy6BWujqhOEIblJHBCmgWOHKDonM/wNx+GZd3n4sBDSlhBfe3PAQZq8PLWAVyOzERhWjZhZpXlqzJJIgDSFZ6OTAmh8xArUeDe5JQe/6LaImHqbQ/X/l9IO1Wx8Z5s3TkLwZAarAG1mda5tY9o+pvk4DpXPBvIUmp55DW+2tXfxwIcpJBhcJznTM43dSSs5IvqsTrtRO/fkRpg5zkR3JiBaKtZ3xWVFmb9MxkbaM40RjTRarxgRD2al4nKNyI26YcBTQZ9ggsmYlmXCU51WO6l0NFBkYeMNHkuONe0/eQc5uirAfE+xeeUHjpt2VcOmDKeu6mweNe6Cydc34TpoiK3I7M5B2N05DWUtkyd5/xibtirrhUgYODd6fs7LobtxtDiSlOxTBAuXvDfjV4qSNGWijmlRL2c5VP3JlMCwL3nU5IavkyrUzlJ7DNgOgIwRhWAkF9OxNZ2/JXrVfh0V9Cxwh8K/958N/E3Qe132upMu6fs0OMFUsGiYOZhPhhQ5Ufk0LS0fr4upcqhI52UyQR0k5wlGWyH3LPubidgg2UqUiZjd8sUYMMa0TpuaXMmwxkZHCB7WOkPGxRru6y2DMTJTfof/ntDWdsy8INHNo408RDQ/ebtRlXPlbdKZRNBFu2xR51Gfest5OOEClQ4grd8Eyt5By2ZrFlZy3WTfXxXJEek
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(40480700001)(82310400005)(7636003)(356005)(82740400003)(86362001)(36756003)(478600001)(54906003)(110136005)(6666004)(41300700001)(316002)(8676002)(8936002)(70206006)(4326008)(70586007)(47076005)(66574015)(36860700001)(16526019)(186003)(26005)(107886003)(426003)(336012)(83380400001)(2616005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:33:43.6525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560ec94f-33a7-4de1-9e3d-08db73254c86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CRIFs are objects that mlxsw maintains for netdevices that may not have an
associated RIF (i.e. they may not have been instantiated in the ASIC), but
if indeed they do not, it is quite possible they will in the future. These
netdevices are candidate RIFs, hence CRIFs. Netdevices for which CRIFs are
created include e.g. bridges, LAGs, or front panel ports. The idea is that
next hops would be kept at CRIFs, not RIFs, and thus it would be easier to
offload and unoffload the entities that have been added before the RIF was
created.

In this patch, add the code for low-level CRIF maintenance: create and
destroy, and keep in a table keyed by the netdevice pointer for easy
recall.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 175 ++++++++++++++++++
 .../ethernet/mellanox/mlxsw/spectrum_router.h |   1 +
 2 files changed, 176 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 15ce0d557f39..d251a926d140 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -51,6 +51,21 @@ struct mlxsw_sp_vr;
 struct mlxsw_sp_lpm_tree;
 struct mlxsw_sp_rif_ops;
 
+struct mlxsw_sp_crif_key {
+	struct net_device *dev;
+};
+
+struct mlxsw_sp_crif {
+	struct mlxsw_sp_crif_key key;
+	struct rhash_head ht_node;
+};
+
+static const struct rhashtable_params mlxsw_sp_crif_ht_params = {
+	.key_offset = offsetof(struct mlxsw_sp_crif, key),
+	.key_len = sizeof_field(struct mlxsw_sp_crif, key),
+	.head_offset = offsetof(struct mlxsw_sp_crif, ht_node),
+};
+
 struct mlxsw_sp_rif {
 	struct list_head nexthop_list;
 	struct list_head neigh_list;
@@ -1060,6 +1075,56 @@ u32 mlxsw_sp_ipip_dev_ul_tb_id(const struct net_device *ol_dev)
 	return tb_id;
 }
 
+static void
+mlxsw_sp_crif_init(struct mlxsw_sp_crif *crif, struct net_device *dev)
+{
+	crif->key.dev = dev;
+}
+
+static struct mlxsw_sp_crif *
+mlxsw_sp_crif_alloc(struct net_device *dev)
+{
+	struct mlxsw_sp_crif *crif;
+
+	crif = kzalloc(sizeof(*crif), GFP_KERNEL);
+	if (!crif)
+		return NULL;
+
+	mlxsw_sp_crif_init(crif, dev);
+	return crif;
+}
+
+static void mlxsw_sp_crif_free(struct mlxsw_sp_crif *crif)
+{
+	kfree(crif);
+}
+
+static int mlxsw_sp_crif_insert(struct mlxsw_sp_router *router,
+				struct mlxsw_sp_crif *crif)
+{
+	return rhashtable_insert_fast(&router->crif_ht, &crif->ht_node,
+				      mlxsw_sp_crif_ht_params);
+}
+
+static void mlxsw_sp_crif_remove(struct mlxsw_sp_router *router,
+				 struct mlxsw_sp_crif *crif)
+{
+	rhashtable_remove_fast(&router->crif_ht, &crif->ht_node,
+			       mlxsw_sp_crif_ht_params);
+}
+
+static struct mlxsw_sp_crif *
+mlxsw_sp_crif_lookup(struct mlxsw_sp_router *router,
+		     const struct net_device *dev)
+{
+	struct mlxsw_sp_crif_key key = {
+		.dev = (struct net_device *)dev,
+	};
+
+	return rhashtable_lookup_fast(&router->crif_ht, &key,
+				      mlxsw_sp_crif_ht_params);
+}
+
 static struct mlxsw_sp_rif *
 mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 		    const struct mlxsw_sp_rif_params *params,
@@ -9148,6 +9213,95 @@ static int mlxsw_sp_router_port_pre_changeaddr_event(struct mlxsw_sp_rif *rif,
 	return -ENOBUFS;
 }
 
+static bool mlxsw_sp_router_netdevice_interesting(struct mlxsw_sp *mlxsw_sp,
+						  struct net_device *dev)
+{
+	struct vlan_dev_priv *vlan;
+
+	if (netif_is_lag_master(dev) ||
+	    netif_is_bridge_master(dev) ||
+	    mlxsw_sp_port_dev_check(dev) ||
+	    mlxsw_sp_netdev_is_ipip_ol(mlxsw_sp, dev) ||
+	    netif_is_l3_master(dev))
+		return true;
+
+	if (!is_vlan_dev(dev))
+		return false;
+
+	vlan = vlan_dev_priv(dev);
+	return netif_is_lag_master(vlan->real_dev) ||
+	       netif_is_bridge_master(vlan->real_dev) ||
+	       mlxsw_sp_port_dev_check(vlan->real_dev);
+}
+
+static struct mlxsw_sp_crif *
+mlxsw_sp_crif_register(struct mlxsw_sp_router *router, struct net_device *dev)
+{
+	struct mlxsw_sp_crif *crif;
+	int err;
+
+	if (WARN_ON(mlxsw_sp_crif_lookup(router, dev)))
+		return NULL;
+
+	crif = mlxsw_sp_crif_alloc(dev);
+	if (!crif)
+		return ERR_PTR(-ENOMEM);
+
+	err = mlxsw_sp_crif_insert(router, crif);
+	if (err)
+		goto err_netdev_insert;
+
+	return crif;
+
+err_netdev_insert:
+	mlxsw_sp_crif_free(crif);
+	return ERR_PTR(err);
+}
+
+static void mlxsw_sp_crif_unregister(struct mlxsw_sp_router *router,
+				     struct mlxsw_sp_crif *crif)
+{
+	mlxsw_sp_crif_remove(router, crif);
+	mlxsw_sp_crif_free(crif);
+}
+
+static int mlxsw_sp_netdevice_register(struct mlxsw_sp_router *router,
+				       struct net_device *dev)
+{
+	struct mlxsw_sp_crif *crif;
+
+	if (!mlxsw_sp_router_netdevice_interesting(router->mlxsw_sp, dev))
+		return 0;
+
+	crif = mlxsw_sp_crif_register(router, dev);
+	return PTR_ERR_OR_ZERO(crif);
+}
+
+static void mlxsw_sp_netdevice_unregister(struct mlxsw_sp_router *router,
+					  struct net_device *dev)
+{
+	struct mlxsw_sp_crif *crif;
+
+	if (!mlxsw_sp_router_netdevice_interesting(router->mlxsw_sp, dev))
+		return;
+
+	/* netdev_run_todo(), by way of netdev_wait_allrefs_any(), rebroadcasts
+	 * the NETDEV_UNREGISTER message, so we can get here twice. If that's
+	 * what happened, the netdevice state is NETREG_UNREGISTERED. In that
+	 * case, we expect to have collected the CRIF already, and warn if it
+	 * still exists. Otherwise we expect the CRIF to exist.
+	 */
+	crif = mlxsw_sp_crif_lookup(router, dev);
+	if (dev->reg_state == NETREG_UNREGISTERED) {
+		if (!WARN_ON(crif))
+			return;
+	}
+	if (WARN_ON(!crif))
+		return;
+
+	mlxsw_sp_crif_unregister(router, crif);
+}
+
 static bool mlxsw_sp_is_offload_xstats_event(unsigned long event)
 {
 	switch (event) {
@@ -9367,6 +9521,15 @@ static int mlxsw_sp_router_netdevice_event(struct notifier_block *nb,
 
 	mutex_lock(&mlxsw_sp->router->lock);
 
+	if (event == NETDEV_REGISTER) {
+		err = mlxsw_sp_netdevice_register(router, dev);
+		if (err)
+			/* No need to roll this back, UNREGISTER will collect it
+			 * anyhow.
+			 */
+			goto out;
+	}
+
 	if (mlxsw_sp_is_offload_xstats_event(event))
 		err = mlxsw_sp_netdevice_offload_xstats_cmd(mlxsw_sp, dev,
 							    event, ptr);
@@ -9381,6 +9544,10 @@ static int mlxsw_sp_router_netdevice_event(struct notifier_block *nb,
 	else if (mlxsw_sp_is_vrf_event(event, ptr))
 		err = mlxsw_sp_netdevice_vrf_event(dev, event, ptr);
 
+	if (event == NETDEV_UNREGISTER)
+		mlxsw_sp_netdevice_unregister(router, dev);
+
+out:
 	mutex_unlock(&mlxsw_sp->router->lock);
 
 	return notifier_from_errno(err);
@@ -10649,6 +10816,11 @@ int mlxsw_sp_router_init(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		goto err_ipips_init;
 
+	err = rhashtable_init(&mlxsw_sp->router->crif_ht,
+			      &mlxsw_sp_crif_ht_params);
+	if (err)
+		goto err_crif_ht_init;
+
 	err = mlxsw_sp_rifs_init(mlxsw_sp);
 	if (err)
 		goto err_rifs_init;
@@ -10780,6 +10952,8 @@ int mlxsw_sp_router_init(struct mlxsw_sp *mlxsw_sp,
 err_nexthop_ht_init:
 	mlxsw_sp_rifs_fini(mlxsw_sp);
 err_rifs_init:
+	rhashtable_destroy(&mlxsw_sp->router->crif_ht);
+err_crif_ht_init:
 	mlxsw_sp_ipips_fini(mlxsw_sp);
 err_ipips_init:
 	__mlxsw_sp_router_fini(mlxsw_sp);
@@ -10815,6 +10989,7 @@ void mlxsw_sp_router_fini(struct mlxsw_sp *mlxsw_sp)
 	rhashtable_destroy(&router->nexthop_group_ht);
 	rhashtable_destroy(&router->nexthop_ht);
 	mlxsw_sp_rifs_fini(mlxsw_sp);
+	rhashtable_destroy(&mlxsw_sp->router->crif_ht);
 	mlxsw_sp_ipips_fini(mlxsw_sp);
 	__mlxsw_sp_router_fini(mlxsw_sp);
 	cancel_delayed_work_sync(&router->nh_grp_activity_dw);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index 5a0babc614b4..b223e80303f5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -20,6 +20,7 @@ struct mlxsw_sp_router_nve_decap {
 
 struct mlxsw_sp_router {
 	struct mlxsw_sp *mlxsw_sp;
+	struct rhashtable crif_ht;
 	struct gen_pool *rifs_table;
 	struct mlxsw_sp_rif **rifs;
 	struct idr rif_mac_profiles_idr;
-- 
2.40.1


