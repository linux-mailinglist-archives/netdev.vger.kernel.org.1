Return-Path: <netdev+bounces-13087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A373A1F0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C363E2819E7
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1011F943;
	Thu, 22 Jun 2023 13:34:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94661D2D1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:34:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E8BC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FggoLJXPrH4etuqSEpnOUd0E4icnr4sKrOKoDvJnshkiWVp1TTUv2YTyLdhy4L6D4dGceIj0gIL51/wW3oPeigdU48qALN0dc6owjM6DBFju9ud6B+1o/EFLNSai3cGfx2/sS8zb8STnTE0unpbDDqFEFJXO89ck8qMor9feq0HId5+8qptE+mLceYtTIV7XC4Hv96/8ioKKMWTwicyqTbTmY9jgztrZTp70iOJVCcXDan3k7mwBh7cA9C3VO5+qyZf7rNHasbIy23Mo2+tonDI05F2AWQi/onJq+RuvnG6xL6zkK4RzMylgiy98GtTDkOrvaoPmRngZtwxL0Uhl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ci6hwsZR4w65W7NFdDB/m71TwF2l2Zv/pwJ1GhnZ2w=;
 b=hnCLg8UL8C63ZZoXveCof/EP7cSYsb61j1s/CAMsBsEbtYpk8Yb2wccbrur9MFQZhHmERc0eWn/+GU6xTDWt1mJB7RXHmhsa+Q/T97+sgNZn+raajTup8j8wTlUODAxwrXBdIT93VbyLh5tQTlT8oJdAEHqf8ASEhTXlEdInGyxrT7HciL4np0hTVq5tNzCKeIPCJFRRNIpl5SwutTY3wS0QtVXP4owbG2nYibl1P878JxOwCiqYsQqRRm3Urjhs1Z4nyym2pGoa4AmeKPUgG6Hlni5C+6HZ3WpIO7hi0xqe3b+FOA/jsipTEqz0XzlwMEft0OJ3n0aGylI8L5EVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ci6hwsZR4w65W7NFdDB/m71TwF2l2Zv/pwJ1GhnZ2w=;
 b=AXhcOjJPH9M69mGh4BfFppCt76830ZS9eZN/f4IwgxxlKMxt3fIS5iTSalHwoxsZrZrLVg8vBzyEIXTyXoXXGNRXglP+GatIBCIToX9K+kay+At0xikv7ucxNTaSDdEuQhVNS6TKAOtZcp2gGXJyFHeu7Zo3en/VECOgtPhKIO32BngVgVrCWuoTM3JU5zzEs+DAduCEABRx1j6rB8M756+Ap+MFglb5p+ojcvZYc79chBOaaYYdlcCJKAvKtpM1na5xbJ1dgrevFmFEEc7LS83SritrViR8i4P/ZdHIcZp5D1cj5Zz1Zg0/EfFGsqzSSQLLDPv7KNol1CTI33i59A==
Received: from SA1PR02CA0019.namprd02.prod.outlook.com (2603:10b6:806:2cf::12)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 22 Jun
 2023 13:34:02 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::a2) by SA1PR02CA0019.outlook.office365.com
 (2603:10b6:806:2cf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 13:34:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:48 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 8/8] mlxsw: spectrum_router: Track next hops at CRIFs
Date: Thu, 22 Jun 2023 15:33:09 +0200
Message-ID: <e7c1c0a7dd13883b0f09aeda12c4fcf4d63a70e3.1687438411.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f76474-14f7-4c35-45da-08db73255755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q8xDz0hS3WzPJijxzdyU2Tb1k63rK3ihJbretYoaEMpJvRpv6DE3sMvrVcOTgAy7gYYdVa2JxJtkllBGG5hgKQPaH8APstcDxLci+0jlDMepBez/IfeVzhFfwhq/LQ+PIrErSBdhgBFzyUOc/sP3AKn+ZLXoVAVtAV/0NfVwunfpbWzUs6nGgnEVXrXpekKirKO/86gUIG27qUDLoq+YDDmJSzyC/B6Qfy5XI8J2su1blxMVlZ2K4WCiALuzOCKQkCHxykDzdjTHQm5/mmiZLFaEhg51n1pUduHiIs3oMp12vo1XLKKiEayvxOuBV8mT6A/ZXctMf3U2HdSZPh3WdbFWJGwUqNIcX4SCxMDTZ+EbyOXU0QYTIylH6FCTLGV7ojvhZxGQi1sTKxWHZTytfBOXHeQFljfOcNFyDocjOcPXCfkRPSkUxgmOTPDYZOqjM++T3xSDScfXITlI3nKWei2vL2Le0hP+uskOKkupPJFHh81Yoh4T7O7XsBEAZWqjMvQAoeKtOSGnxMAV6ZGnv5arhgHBXSgRvN2SaJyeh7VscDAE62jXm4RHSdB47U3cX6+kArlhgE+t3XEi7vrhym1AMuLiUlEP42z1W10WuuOzcJqPvrvJT/GUEFo+X9A8vxXkz/R72yGlutYQk1bRuN8pbAJYYQ9Ysbov/gwxZ9QX6RX/rBjXZXyPmExPSgEWHnRL2yKE222zOB5WbNcUu3+X2rSJU+IdERDlWXPpnA8ZGUWnDZMUEpDS5v6TyZVH
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(30864003)(478600001)(54906003)(82310400005)(66574015)(110136005)(47076005)(2616005)(426003)(336012)(36756003)(5660300002)(6666004)(70586007)(70206006)(83380400001)(4326008)(316002)(82740400003)(86362001)(41300700001)(36860700001)(40480700001)(8936002)(8676002)(7636003)(356005)(16526019)(107886003)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:34:01.7841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f76474-14f7-4c35-45da-08db73255755
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the list of next hops from struct mlxsw_sp_rif to mlxsw_sp_crif. The
reason is that eventually, next hops for mlxsw uppers should be offloaded
and unoffloaded on demand as a netdevice becomes an upper, or stops being
one. Currently, next hops are tracked at RIFs, but RIFs do not exist when a
netdevice is not an mlxsw uppers. CRIFs are kept track of throughout the
netdevice lifetime.

Correspondingly, track at each next hop not its RIF, but its CRIF (from
which a RIF can always be deduced).

Note that now that next hops are tracked at a CRIF, it is not necessary to
move each over to a new RIF when it is necessary to edit a RIF. Therefore
drop mlxsw_sp_nexthop_rif_migrate() and have mlxsw_sp_rif_migrate_destroy()
call mlxsw_sp_nexthop_rif_update() directly.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 127 +++++++++++-------
 1 file changed, 75 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 6c9244c35192..445ba7fe3c40 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -59,6 +59,7 @@ struct mlxsw_sp_crif {
 	struct mlxsw_sp_crif_key key;
 	struct rhash_head ht_node;
 	bool can_destroy;
+	struct list_head nexthop_list;
 	struct mlxsw_sp_rif *rif;
 };
 
@@ -70,7 +71,6 @@ static const struct rhashtable_params mlxsw_sp_crif_ht_params = {
 
 struct mlxsw_sp_rif {
 	struct mlxsw_sp_crif *crif; /* NULL for underlay RIF */
-	struct list_head nexthop_list;
 	struct list_head neigh_list;
 	struct mlxsw_sp_fid *fid;
 	unsigned char addr[ETH_ALEN];
@@ -1083,6 +1083,7 @@ static void
 mlxsw_sp_crif_init(struct mlxsw_sp_crif *crif, struct net_device *dev)
 {
 	crif->key.dev = dev;
+	INIT_LIST_HEAD(&crif->nexthop_list);
 }
 
 static struct mlxsw_sp_crif *
@@ -1103,6 +1104,7 @@ static void mlxsw_sp_crif_free(struct mlxsw_sp_crif *crif)
 	if (WARN_ON(crif->rif))
 		return;
 
+	WARN_ON(!list_empty(&crif->nexthop_list));
 	kfree(crif);
 }
 
@@ -1720,17 +1722,26 @@ static void mlxsw_sp_netdevice_ipip_ol_down_event(struct mlxsw_sp *mlxsw_sp,
 		mlxsw_sp_ipip_entry_ol_down_event(mlxsw_sp, ipip_entry);
 }
 
-static void mlxsw_sp_nexthop_rif_migrate(struct mlxsw_sp *mlxsw_sp,
-					 struct mlxsw_sp_rif *old_rif,
-					 struct mlxsw_sp_rif *new_rif);
+static void mlxsw_sp_nexthop_rif_update(struct mlxsw_sp *mlxsw_sp,
+					struct mlxsw_sp_rif *rif);
+
 static void mlxsw_sp_rif_migrate_destroy(struct mlxsw_sp *mlxsw_sp,
 					 struct mlxsw_sp_rif *old_rif,
 					 struct mlxsw_sp_rif *new_rif,
 					 bool migrate_nhs)
 {
+	struct mlxsw_sp_crif *crif = old_rif->crif;
+	struct mlxsw_sp_crif mock_crif = {};
+
 	if (migrate_nhs)
-		mlxsw_sp_nexthop_rif_migrate(mlxsw_sp, old_rif, new_rif);
+		mlxsw_sp_nexthop_rif_update(mlxsw_sp, new_rif);
 
+	/* Plant a mock CRIF so that destroying the old RIF doesn't unoffload
+	 * our nexthops and IPIP tunnels, and doesn't sever the crif->rif link.
+	 */
+	mlxsw_sp_crif_init(&mock_crif, crif->key.dev);
+	old_rif->crif = &mock_crif;
+	mock_crif.rif = old_rif;
 	mlxsw_sp_rif_destroy(old_rif);
 }
 
@@ -1756,9 +1767,6 @@ mlxsw_sp_ipip_entry_ol_lb_update(struct mlxsw_sp *mlxsw_sp,
 	return 0;
 }
 
-static void mlxsw_sp_nexthop_rif_update(struct mlxsw_sp *mlxsw_sp,
-					struct mlxsw_sp_rif *rif);
-
 /**
  * __mlxsw_sp_ipip_entry_update_tunnel - Update offload related to IPIP entry.
  * @mlxsw_sp: mlxsw_sp.
@@ -2987,7 +2995,7 @@ struct mlxsw_sp_nexthop_key {
 
 struct mlxsw_sp_nexthop {
 	struct list_head neigh_list_node; /* member of neigh entry list */
-	struct list_head rif_list_node;
+	struct list_head crif_list_node;
 	struct list_head router_list_node;
 	struct mlxsw_sp_nexthop_group_info *nhgi; /* pointer back to the group
 						   * this nexthop belongs to
@@ -3000,7 +3008,7 @@ struct mlxsw_sp_nexthop {
 	int nh_weight;
 	int norm_nh_weight;
 	int num_adj_entries;
-	struct mlxsw_sp_rif *rif;
+	struct mlxsw_sp_crif *crif;
 	u8 should_offload:1, /* set indicates this nexthop should be written
 			      * to the adjacency table.
 			      */
@@ -3023,9 +3031,9 @@ struct mlxsw_sp_nexthop {
 static struct net_device *
 mlxsw_sp_nexthop_dev(const struct mlxsw_sp_nexthop *nh)
 {
-	if (nh->rif)
-		return mlxsw_sp_rif_dev(nh->rif);
-	return NULL;
+	if (!nh->crif)
+		return NULL;
+	return nh->crif->key.dev;
 }
 
 enum mlxsw_sp_nexthop_group_type {
@@ -3050,7 +3058,11 @@ struct mlxsw_sp_nexthop_group_info {
 static struct mlxsw_sp_rif *
 mlxsw_sp_nhgi_rif(const struct mlxsw_sp_nexthop_group_info *nhgi)
 {
-	return nhgi->nexthops[0].rif;
+	struct mlxsw_sp_crif *crif = nhgi->nexthops[0].crif;
+
+	if (!crif)
+		return NULL;
+	return crif->rif;
 }
 
 struct mlxsw_sp_nexthop_group_vr_key {
@@ -3174,7 +3186,9 @@ int mlxsw_sp_nexthop_indexes(struct mlxsw_sp_nexthop *nh, u32 *p_adj_index,
 
 struct mlxsw_sp_rif *mlxsw_sp_nexthop_rif(struct mlxsw_sp_nexthop *nh)
 {
-	return nh->rif;
+	if (WARN_ON(!nh->crif))
+		return NULL;
+	return nh->crif->rif;
 }
 
 bool mlxsw_sp_nexthop_group_has_ipip(struct mlxsw_sp_nexthop *nh)
@@ -3559,11 +3573,12 @@ static int __mlxsw_sp_nexthop_eth_update(struct mlxsw_sp *mlxsw_sp,
 					 bool force, char *ratr_pl)
 {
 	struct mlxsw_sp_neigh_entry *neigh_entry = nh->neigh_entry;
+	struct mlxsw_sp_rif *rif = mlxsw_sp_nexthop_rif(nh);
 	enum mlxsw_reg_ratr_op op;
 	u16 rif_index;
 
-	rif_index = nh->rif ? nh->rif->rif_index :
-			      mlxsw_sp->router->lb_crif->rif->rif_index;
+	rif_index = rif ? rif->rif_index :
+			  mlxsw_sp->router->lb_crif->rif->rif_index;
 	op = force ? MLXSW_REG_RATR_OP_WRITE_WRITE_ENTRY :
 		     MLXSW_REG_RATR_OP_WRITE_WRITE_ENTRY_ON_ACTIVITY;
 	mlxsw_reg_ratr_pack(ratr_pl, op, true, MLXSW_REG_RATR_TYPE_ETHERNET,
@@ -4181,23 +4196,23 @@ mlxsw_sp_nexthop_neigh_update(struct mlxsw_sp *mlxsw_sp,
 	}
 }
 
-static void mlxsw_sp_nexthop_rif_init(struct mlxsw_sp_nexthop *nh,
-				      struct mlxsw_sp_rif *rif)
+static void mlxsw_sp_nexthop_crif_init(struct mlxsw_sp_nexthop *nh,
+				       struct mlxsw_sp_crif *crif)
 {
-	if (nh->rif)
+	if (nh->crif)
 		return;
 
-	nh->rif = rif;
-	list_add(&nh->rif_list_node, &rif->nexthop_list);
+	nh->crif = crif;
+	list_add(&nh->crif_list_node, &crif->nexthop_list);
 }
 
-static void mlxsw_sp_nexthop_rif_fini(struct mlxsw_sp_nexthop *nh)
+static void mlxsw_sp_nexthop_crif_fini(struct mlxsw_sp_nexthop *nh)
 {
-	if (!nh->rif)
+	if (!nh->crif)
 		return;
 
-	list_del(&nh->rif_list_node);
-	nh->rif = NULL;
+	list_del(&nh->crif_list_node);
+	nh->crif = NULL;
 }
 
 static int mlxsw_sp_nexthop_neigh_init(struct mlxsw_sp *mlxsw_sp,
@@ -4209,6 +4224,9 @@ static int mlxsw_sp_nexthop_neigh_init(struct mlxsw_sp *mlxsw_sp,
 	u8 nud_state, dead;
 	int err;
 
+	if (WARN_ON(!nh->crif->rif))
+		return 0;
+
 	if (!nh->nhgi->gateway || nh->neigh_entry)
 		return 0;
 	dev = mlxsw_sp_nexthop_dev(nh);
@@ -4299,15 +4317,20 @@ static void mlxsw_sp_nexthop_ipip_init(struct mlxsw_sp *mlxsw_sp,
 				       struct mlxsw_sp_nexthop *nh,
 				       struct mlxsw_sp_ipip_entry *ipip_entry)
 {
+	struct mlxsw_sp_crif *crif;
 	bool removing;
 
 	if (!nh->nhgi->gateway || nh->ipip_entry)
 		return;
 
+	crif = mlxsw_sp_crif_lookup(mlxsw_sp->router, ipip_entry->ol_dev);
+	if (WARN_ON(!crif))
+		return;
+
 	nh->ipip_entry = ipip_entry;
 	removing = !mlxsw_sp_ipip_netdev_ul_up(ipip_entry->ol_dev);
 	__mlxsw_sp_nexthop_neigh_update(nh, removing);
-	mlxsw_sp_nexthop_rif_init(nh, &ipip_entry->ol_lb->common);
+	mlxsw_sp_nexthop_crif_init(nh, crif);
 }
 
 static void mlxsw_sp_nexthop_ipip_fini(struct mlxsw_sp *mlxsw_sp,
@@ -4339,7 +4362,7 @@ static int mlxsw_sp_nexthop_type_init(struct mlxsw_sp *mlxsw_sp,
 {
 	const struct mlxsw_sp_ipip_ops *ipip_ops;
 	struct mlxsw_sp_ipip_entry *ipip_entry;
-	struct mlxsw_sp_rif *rif;
+	struct mlxsw_sp_crif *crif;
 	int err;
 
 	ipip_entry = mlxsw_sp_ipip_entry_find_by_ol_dev(mlxsw_sp, dev);
@@ -4353,11 +4376,15 @@ static int mlxsw_sp_nexthop_type_init(struct mlxsw_sp *mlxsw_sp,
 	}
 
 	nh->type = MLXSW_SP_NEXTHOP_TYPE_ETH;
-	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, dev);
-	if (!rif)
+	crif = mlxsw_sp_crif_lookup(mlxsw_sp->router, dev);
+	if (!crif)
+		return 0;
+
+	mlxsw_sp_nexthop_crif_init(nh, crif);
+
+	if (!crif->rif)
 		return 0;
 
-	mlxsw_sp_nexthop_rif_init(nh, rif);
 	err = mlxsw_sp_nexthop_neigh_init(mlxsw_sp, nh);
 	if (err)
 		goto err_neigh_init;
@@ -4365,7 +4392,7 @@ static int mlxsw_sp_nexthop_type_init(struct mlxsw_sp *mlxsw_sp,
 	return 0;
 
 err_neigh_init:
-	mlxsw_sp_nexthop_rif_fini(nh);
+	mlxsw_sp_nexthop_crif_fini(nh);
 	return err;
 }
 
@@ -4386,7 +4413,7 @@ static void mlxsw_sp_nexthop_type_fini(struct mlxsw_sp *mlxsw_sp,
 				       struct mlxsw_sp_nexthop *nh)
 {
 	mlxsw_sp_nexthop_type_rif_gone(mlxsw_sp, nh);
-	mlxsw_sp_nexthop_rif_fini(nh);
+	mlxsw_sp_nexthop_crif_fini(nh);
 }
 
 static int mlxsw_sp_nexthop4_init(struct mlxsw_sp *mlxsw_sp,
@@ -4479,7 +4506,7 @@ static void mlxsw_sp_nexthop_rif_update(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_nexthop *nh;
 	bool removing;
 
-	list_for_each_entry(nh, &rif->nexthop_list, rif_list_node) {
+	list_for_each_entry(nh, &rif->crif->nexthop_list, crif_list_node) {
 		switch (nh->type) {
 		case MLXSW_SP_NEXTHOP_TYPE_ETH:
 			removing = false;
@@ -4497,25 +4524,14 @@ static void mlxsw_sp_nexthop_rif_update(struct mlxsw_sp *mlxsw_sp,
 	}
 }
 
-static void mlxsw_sp_nexthop_rif_migrate(struct mlxsw_sp *mlxsw_sp,
-					 struct mlxsw_sp_rif *old_rif,
-					 struct mlxsw_sp_rif *new_rif)
-{
-	struct mlxsw_sp_nexthop *nh;
-
-	list_splice_init(&old_rif->nexthop_list, &new_rif->nexthop_list);
-	list_for_each_entry(nh, &new_rif->nexthop_list, rif_list_node)
-		nh->rif = new_rif;
-	mlxsw_sp_nexthop_rif_update(mlxsw_sp, new_rif);
-}
-
 static void mlxsw_sp_nexthop_rif_gone_sync(struct mlxsw_sp *mlxsw_sp,
 					   struct mlxsw_sp_rif *rif)
 {
 	struct mlxsw_sp_nexthop *nh, *tmp;
 
-	list_for_each_entry_safe(nh, tmp, &rif->nexthop_list, rif_list_node) {
-		mlxsw_sp_nexthop_type_fini(mlxsw_sp, nh);
+	list_for_each_entry_safe(nh, tmp, &rif->crif->nexthop_list,
+				 crif_list_node) {
+		mlxsw_sp_nexthop_type_rif_gone(mlxsw_sp, nh);
 		mlxsw_sp_nexthop_group_refresh(mlxsw_sp, nh->nhgi->nh_grp);
 	}
 }
@@ -4857,13 +4873,13 @@ static void mlxsw_sp_nexthop_obj_blackhole_init(struct mlxsw_sp *mlxsw_sp,
 	 * via an egress RIF, they still need to be programmed using a
 	 * valid RIF, so use the loopback RIF created during init.
 	 */
-	nh->rif = mlxsw_sp->router->lb_crif->rif;
+	nh->crif = mlxsw_sp->router->lb_crif;
 }
 
 static void mlxsw_sp_nexthop_obj_blackhole_fini(struct mlxsw_sp *mlxsw_sp,
 						struct mlxsw_sp_nexthop *nh)
 {
-	nh->rif = NULL;
+	nh->crif = NULL;
 	nh->should_offload = 0;
 }
 
@@ -7871,6 +7887,9 @@ static int mlxsw_sp_router_rif_disable(struct mlxsw_sp *mlxsw_sp, u16 rif)
 static void mlxsw_sp_router_rif_gone_sync(struct mlxsw_sp *mlxsw_sp,
 					  struct mlxsw_sp_rif *rif)
 {
+	/* Signal to nexthop cleanup that the RIF is going away. */
+	rif->crif->rif = NULL;
+
 	mlxsw_sp_router_rif_disable(mlxsw_sp, rif->rif_index);
 	mlxsw_sp_nexthop_rif_gone_sync(mlxsw_sp, rif);
 	mlxsw_sp_neigh_rif_gone_sync(mlxsw_sp, rif);
@@ -7989,7 +8008,6 @@ static struct mlxsw_sp_rif *mlxsw_sp_rif_alloc(size_t rif_size, u16 rif_index,
 	if (!rif)
 		return NULL;
 
-	INIT_LIST_HEAD(&rif->nexthop_list);
 	INIT_LIST_HEAD(&rif->neigh_list);
 	if (l3_dev) {
 		ether_addr_copy(rif->addr, l3_dev->dev_addr);
@@ -8008,7 +8026,6 @@ static struct mlxsw_sp_rif *mlxsw_sp_rif_alloc(size_t rif_size, u16 rif_index,
 static void mlxsw_sp_rif_free(struct mlxsw_sp_rif *rif)
 {
 	WARN_ON(!list_empty(&rif->neigh_list));
-	WARN_ON(!list_empty(&rif->nexthop_list));
 
 	if (rif->crif)
 		rif->crif->rif = NULL;
@@ -9290,7 +9307,13 @@ mlxsw_sp_crif_register(struct mlxsw_sp_router *router, struct net_device *dev)
 static void mlxsw_sp_crif_unregister(struct mlxsw_sp_router *router,
 				     struct mlxsw_sp_crif *crif)
 {
+	struct mlxsw_sp_nexthop *nh, *tmp;
+
 	mlxsw_sp_crif_remove(router, crif);
+
+	list_for_each_entry_safe(nh, tmp, &crif->nexthop_list, crif_list_node)
+		mlxsw_sp_nexthop_type_fini(router->mlxsw_sp, nh);
+
 	if (crif->rif)
 		crif->can_destroy = true;
 	else
-- 
2.40.1


