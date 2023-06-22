Return-Path: <netdev+bounces-13084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F386F73A1E6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226081C21056
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F31ED46;
	Thu, 22 Jun 2023 13:33:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A591D2D1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:33:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC601996
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGRv2XxUkPvzWXErJPXhs/2QlJo/yVyYAbU+Ak2nE8lnc9PiUUUYEVRt08qFvEjj1sYuMRdp74d+9UhjsD+Uyd9L9oTYQPbkcms+W92Il2+DNEbwGLEZdKOYGOyx9/wcNjxaIOgZSJgr1LlUB3GRxEsI/bbAfPnFD/UY5WMQR3TK3McFYDoGj7xN8WRwuuIw8O2tDGN9DVjiPu18gtVWFrmOjNKAXmHIBMNdbIF4NSbpTsNFLUcknHqFO9+ZiCW8npZDz0Q3wCChZOAvk2OEdL5KhwVzdb7nJ0IoN4b0q9SL6ZxbVMuMkww8N1cFBshTiq8INX2QQ3yB7avCgd8orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQI9nyrPXhErMJddbTjszxFjqdHfYGuygXsFvBf6w3A=;
 b=l/KKgjn9w0lj8hxaJo9oBvQxP+d2wKTlxGvtrmklhotbckFU8JVmXGC7s68p9S5TObh0ru/W0jfkLoGRLpYg9sBL91d7bx0yniOD/cjJvskrsE+jS2QAZjxBaEF426Pw369LWJN8eBRsARYWoDSSONpeJBJ8biYJCsKnJi8cysFRLxYAanIYzaLKWL07SnK+KlvD3/nE+gOH86ThFUCYD40u5KcZv9tuFAt5BGJsPAoaUe/8kCnYAiCSYWpXUrfb8ka01EzROHYy6912kPxbMW8ZhXiIdrfNFcEo8CKDJ8lxZnLHHItIUXJ46NKsD894ty0KbVkJiwr15M0dFmM2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQI9nyrPXhErMJddbTjszxFjqdHfYGuygXsFvBf6w3A=;
 b=Cc0tvf9Bvbp61XUuiONQ5RxdEMHD/1EegfovWwGGSHxs0QSh8sNfNa8N6Q9gvX40lZetwERzXlllOdaCfEtZhqd5JKpsNOcYmVDLB5E4bQS2hOUkOXvsCwoHQBqMYEJD5khxoJ6FLZ6VNNZJp6OFiIBX8vH/6mhL71T3UxcylQQXvHp9QLgF31lIo3prP578jjjCkQp/zNHSTyZerBppjGQmimiPfClfCMUcihb79mHh3Qs/9UVFJOe87aUhHuQ+GhHN3erOI5eBByI18vZlcxuB8WP58CcvQvV7MRuwD1N/nAnWB2JayS8wkTQCktbmWpHIgZNd2OPvbYNslhGaSA==
Received: from SN7PR04CA0175.namprd04.prod.outlook.com (2603:10b6:806:125::30)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:33:49 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::f6) by SN7PR04CA0175.outlook.office365.com
 (2603:10b6:806:125::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 13:33:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:40 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:38 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/8] mlxsw: spectrum_router: Link CRIFs to RIFs
Date: Thu, 22 Jun 2023 15:33:06 +0200
Message-ID: <68c8e33afa6b8c03c431b435e1685ffdff752e63.1687438411.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: f23075d7-b06e-4451-ff8e-08db73254fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XKr/9FP63AECJGd6UErhqYZE7Wtiup0dH/Buuo47vBu8fwQqkzoeQyJJgAG2EXzE4IJSax9TuH6Uag1YQsGc/rXslFsycP1cmFgO0+9TANK+ibWmR2LasCEb3lY0VWNUoyFI6bAYTMA01Y3z5zDBcs5E0VITnSln2AybiYZYgCkWVBy71YqRvMQspE5znx0ZRx6TDlBoTkXyoK+9cpPVIVldosagnFLB9C9GR6+wCIQkkZEozY6a7+P6usSE/rNhMBiQoxirP/hh3p2w4TdG+fb2oIuxv972DInqpQIqeHk4oO7VPAFQyyuMxiaE9P0DVcj5BF72UhtYJRGEfrvRrZsmIYBce6+IzdiETBJZHCQW4VD1J1WAVI/tPHKlrqogew7tGARABoH/4O6+WNEQAzkS1zJuUn5MdbxrjaE4nlE+wyfzHRrQdJxxDudAyAdgqPCkLN+PTJhMr4s79DBt4leeZt4F/w/l2ia7Yea47O6/bHpmpSGZEhrPU8PwzKkDzZFeIKzXSCqzCtDKoUtx2QmjUPH1QOFGEToJDOEWqN7prXeVUx9Bb1UCuOMuHf/C64XP33caybIOVqJrMqeGxrFcoHH6K6WgolRByam5cRTxfHgBxII3BhQYzibGWBa90KDRWjxl2eF0TSE1hLJW7wbAiHcLuj0gdfbkj2IXwEbHud4gCH+waN7hd3GbITeX7BAw8BuyUZTV7UwYK6J5DO1wIdSOQgiQfeQFcg2F9m648WG+DA41DwWIxD0uk5D4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(186003)(16526019)(8936002)(8676002)(40460700003)(41300700001)(2906002)(26005)(54906003)(110136005)(86362001)(70206006)(70586007)(4326008)(316002)(6666004)(478600001)(82310400005)(356005)(7636003)(82740400003)(336012)(83380400001)(107886003)(36756003)(426003)(2616005)(36860700001)(40480700001)(66574015)(47076005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:33:49.2231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f23075d7-b06e-4451-ff8e-08db73254fda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When a RIF is about to be created, the registration of the netdevice that
it should be associated with must have been seen in the past, and a CRIF
created. Therefore make this a hard requirement by looking up the CRIF
during RIF creation, and complaining loudly when there isn't one.

This then allows to keep a link between a RIF and its corresponding
CRIF (and back, as the relationship is one-to-at-most-one), which do.

The CRIF will later be useful as the objects tracked there will be
offloaded lazily as a result of RIF creation.

CRIFs are created when an "interesting" netdevice is registered, and
destroyed after such device is unregistered. CRIFs are supposed to already
exist when a RIF creation request arises, and exist at least as long as
that RIF exists. This makes for a simple invariant: it is always safe to
dereference CRIF pointer from "its" RIF.

To guarantee this, CRIFs cannot be removed immediately when the UNREGISTER
event is delivered. The reason is that if a RIF's netdevices has an IPv6
address, removal of this address is notified in an atomic block. To remove
the RIF, the IPv6 removal handler schedules a work item. It must be safe
for this work item to access the associated CRIF as well.

Thus when a netdevice that backs the CRIF is removed, if it still has a
RIF, do not actually free the CRIF, only toggle its can_destroy flag, which
this patch adds. Later on, mlxsw_sp_rif_destroy() collects the CRIF.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 59 +++++++++++++++----
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index c4d538e0169e..daa59fc59d3b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -58,6 +58,8 @@ struct mlxsw_sp_crif_key {
 struct mlxsw_sp_crif {
 	struct mlxsw_sp_crif_key key;
 	struct rhash_head ht_node;
+	bool can_destroy;
+	struct mlxsw_sp_rif *rif;
 };
 
 static const struct rhashtable_params mlxsw_sp_crif_ht_params = {
@@ -67,9 +69,9 @@ static const struct rhashtable_params mlxsw_sp_crif_ht_params = {
 };
 
 struct mlxsw_sp_rif {
+	struct mlxsw_sp_crif *crif; /* NULL for underlay RIF */
 	struct list_head nexthop_list;
 	struct list_head neigh_list;
-	struct net_device *dev; /* NULL for underlay RIF */
 	struct mlxsw_sp_fid *fid;
 	unsigned char addr[ETH_ALEN];
 	int mtu;
@@ -88,7 +90,9 @@ struct mlxsw_sp_rif {
 
 static struct net_device *mlxsw_sp_rif_dev(const struct mlxsw_sp_rif *rif)
 {
-	return rif->dev;
+	if (!rif->crif)
+		return NULL;
+	return rif->crif->key.dev;
 }
 
 struct mlxsw_sp_rif_params {
@@ -1096,6 +1100,9 @@ mlxsw_sp_crif_alloc(struct net_device *dev)
 
 static void mlxsw_sp_crif_free(struct mlxsw_sp_crif *crif)
 {
+	if (WARN_ON(crif->rif))
+		return;
+
 	kfree(crif);
 }
 
@@ -7970,8 +7977,9 @@ static void mlxsw_sp_rif_index_free(struct mlxsw_sp *mlxsw_sp, u16 rif_index,
 
 static struct mlxsw_sp_rif *mlxsw_sp_rif_alloc(size_t rif_size, u16 rif_index,
 					       u16 vr_id,
-					       struct net_device *l3_dev)
+					       struct mlxsw_sp_crif *crif)
 {
+	struct net_device *l3_dev = crif ? crif->key.dev : NULL;
 	struct mlxsw_sp_rif *rif;
 
 	rif = kzalloc(rif_size, GFP_KERNEL);
@@ -7983,10 +7991,13 @@ static struct mlxsw_sp_rif *mlxsw_sp_rif_alloc(size_t rif_size, u16 rif_index,
 	if (l3_dev) {
 		ether_addr_copy(rif->addr, l3_dev->dev_addr);
 		rif->mtu = l3_dev->mtu;
-		rif->dev = l3_dev;
 	}
 	rif->vr_id = vr_id;
 	rif->rif_index = rif_index;
+	if (crif) {
+		rif->crif = crif;
+		crif->rif = rif;
+	}
 
 	return rif;
 }
@@ -7995,6 +8006,9 @@ static void mlxsw_sp_rif_free(struct mlxsw_sp_rif *rif)
 {
 	WARN_ON(!list_empty(&rif->neigh_list));
 	WARN_ON(!list_empty(&rif->nexthop_list));
+
+	if (rif->crif)
+		rif->crif->rif = NULL;
 	kfree(rif);
 }
 
@@ -8228,6 +8242,7 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 	const struct mlxsw_sp_rif_ops *ops;
 	struct mlxsw_sp_fid *fid = NULL;
 	enum mlxsw_sp_rif_type type;
+	struct mlxsw_sp_crif *crif;
 	struct mlxsw_sp_rif *rif;
 	struct mlxsw_sp_vr *vr;
 	u16 rif_index;
@@ -8247,7 +8262,13 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 		goto err_rif_index_alloc;
 	}
 
-	rif = mlxsw_sp_rif_alloc(ops->rif_size, rif_index, vr->id, params->dev);
+	crif = mlxsw_sp_crif_lookup(mlxsw_sp->router, params->dev);
+	if (WARN_ON(!crif)) {
+		err = -ENOENT;
+		goto err_crif_lookup;
+	}
+
+	rif = mlxsw_sp_rif_alloc(ops->rif_size, rif_index, vr->id, crif);
 	if (!rif) {
 		err = -ENOMEM;
 		goto err_rif_alloc;
@@ -8306,6 +8327,7 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 	dev_put(params->dev);
 	mlxsw_sp_rif_free(rif);
 err_rif_alloc:
+err_crif_lookup:
 	mlxsw_sp_rif_index_free(mlxsw_sp, rif_index, rif_entries);
 err_rif_index_alloc:
 	vr->rif_count--;
@@ -8318,6 +8340,7 @@ static void mlxsw_sp_rif_destroy(struct mlxsw_sp_rif *rif)
 	struct net_device *dev = mlxsw_sp_rif_dev(rif);
 	const struct mlxsw_sp_rif_ops *ops = rif->ops;
 	struct mlxsw_sp *mlxsw_sp = rif->mlxsw_sp;
+	struct mlxsw_sp_crif *crif = rif->crif;
 	struct mlxsw_sp_fid *fid = rif->fid;
 	u8 rif_entries = rif->rif_entries;
 	u16 rif_index = rif->rif_index;
@@ -8348,6 +8371,9 @@ static void mlxsw_sp_rif_destroy(struct mlxsw_sp_rif *rif)
 	mlxsw_sp_rif_index_free(mlxsw_sp, rif_index, rif_entries);
 	vr->rif_count--;
 	mlxsw_sp_vr_put(mlxsw_sp, vr);
+
+	if (crif->can_destroy)
+		mlxsw_sp_crif_free(crif);
 }
 
 void mlxsw_sp_rif_destroy_by_dev(struct mlxsw_sp *mlxsw_sp,
@@ -9262,7 +9288,10 @@ static void mlxsw_sp_crif_unregister(struct mlxsw_sp_router *router,
 				     struct mlxsw_sp_crif *crif)
 {
 	mlxsw_sp_crif_remove(router, crif);
-	mlxsw_sp_crif_free(crif);
+	if (crif->rif)
+		crif->can_destroy = true;
+	else
+		mlxsw_sp_crif_free(crif);
 }
 
 static int mlxsw_sp_netdevice_register(struct mlxsw_sp_router *router,
@@ -10068,6 +10097,7 @@ mlxsw_sp_rif_ipip_lb_ul_rif_op(struct mlxsw_sp_rif *ul_rif, bool enable)
 
 static struct mlxsw_sp_rif *
 mlxsw_sp_ul_rif_create(struct mlxsw_sp *mlxsw_sp, struct mlxsw_sp_vr *vr,
+		       struct mlxsw_sp_crif *ul_crif,
 		       struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_rif *ul_rif;
@@ -10081,7 +10111,8 @@ mlxsw_sp_ul_rif_create(struct mlxsw_sp *mlxsw_sp, struct mlxsw_sp_vr *vr,
 		return ERR_PTR(err);
 	}
 
-	ul_rif = mlxsw_sp_rif_alloc(sizeof(*ul_rif), rif_index, vr->id, NULL);
+	ul_rif = mlxsw_sp_rif_alloc(sizeof(*ul_rif), rif_index, vr->id,
+				    ul_crif);
 	if (!ul_rif) {
 		err = -ENOMEM;
 		goto err_rif_alloc;
@@ -10120,6 +10151,7 @@ static void mlxsw_sp_ul_rif_destroy(struct mlxsw_sp_rif *ul_rif)
 
 static struct mlxsw_sp_rif *
 mlxsw_sp_ul_rif_get(struct mlxsw_sp *mlxsw_sp, u32 tb_id,
+		    struct mlxsw_sp_crif *ul_crif,
 		    struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_vr *vr;
@@ -10132,7 +10164,7 @@ mlxsw_sp_ul_rif_get(struct mlxsw_sp *mlxsw_sp, u32 tb_id,
 	if (refcount_inc_not_zero(&vr->ul_rif_refcnt))
 		return vr->ul_rif;
 
-	vr->ul_rif = mlxsw_sp_ul_rif_create(mlxsw_sp, vr, extack);
+	vr->ul_rif = mlxsw_sp_ul_rif_create(mlxsw_sp, vr, ul_crif, extack);
 	if (IS_ERR(vr->ul_rif)) {
 		err = PTR_ERR(vr->ul_rif);
 		goto err_ul_rif_create;
@@ -10170,7 +10202,7 @@ int mlxsw_sp_router_ul_rif_get(struct mlxsw_sp *mlxsw_sp, u32 ul_tb_id,
 	int err = 0;
 
 	mutex_lock(&mlxsw_sp->router->lock);
-	ul_rif = mlxsw_sp_ul_rif_get(mlxsw_sp, ul_tb_id, NULL);
+	ul_rif = mlxsw_sp_ul_rif_get(mlxsw_sp, ul_tb_id, NULL, NULL);
 	if (IS_ERR(ul_rif)) {
 		err = PTR_ERR(ul_rif);
 		goto out;
@@ -10206,7 +10238,7 @@ mlxsw_sp2_rif_ipip_lb_configure(struct mlxsw_sp_rif *rif,
 	struct mlxsw_sp_rif *ul_rif;
 	int err;
 
-	ul_rif = mlxsw_sp_ul_rif_get(mlxsw_sp, ul_tb_id, extack);
+	ul_rif = mlxsw_sp_ul_rif_get(mlxsw_sp, ul_tb_id, NULL, extack);
 	if (IS_ERR(ul_rif))
 		return PTR_ERR(ul_rif);
 
@@ -10741,9 +10773,12 @@ static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp,
 
 	/* Create a generic loopback RIF associated with the main table
 	 * (default VRF). Any table can be used, but the main table exists
-	 * anyway, so we do not waste resources.
+	 * anyway, so we do not waste resources. Loopback RIFs are usually
+	 * created with a NULL CRIF, but this RIF is used as a fallback RIF
+	 * for blackhole nexthops, and nexthops expect to have a valid CRIF.
 	 */
-	lb_rif = mlxsw_sp_ul_rif_get(mlxsw_sp, RT_TABLE_MAIN, extack);
+	lb_rif = mlxsw_sp_ul_rif_get(mlxsw_sp, RT_TABLE_MAIN, router->lb_crif,
+				     extack);
 	if (IS_ERR(lb_rif)) {
 		err = PTR_ERR(lb_rif);
 		goto err_ul_rif_get;
-- 
2.40.1


