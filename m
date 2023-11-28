Return-Path: <netdev+bounces-51749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B476E7FBE93
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6974728235E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3C35285;
	Tue, 28 Nov 2023 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yb4XPLt0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B210EB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:52:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltzteRScOrUA2oVChMSFICbgOIrZFad4aJIHoUkQqY09fNinD0ukd0ANih51aGwDrciMLr9auAVu1vJFuw91j+5/Ky+AnZ/nXgveCRbUya7V8WygW8i8Tjt2QXEJLiVNfjHrE2zL4o+Wu9Ca2lOpBZR3wPiQx31UxXOXzza1djbfNANsZTUFpsO/nlEnwk1P4zWRIM5sYydgPkQlAyw8sAWujow4wTKxafAyjmHavMkvq+LKVjWf16JoxJs9SLo/6zmR8PDsUmoOOxhE52MHCWJCnEEmz1Apx869cur8PkGRySe1WmKnjAHk3nsZ5xheZrLk43D9eX1m2e0CkuoMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7IWDF5KpM1YQL2k/JD3DXmWvt2UtspIEQOHZhBvsOM=;
 b=MkEleK0FJXYLnQvyP91d40JGtO4bSjrY5R4KVd187ZxJH9JSV1oc0WnU+4mh7m0gChZrCIlmn7lNAO0Sma3IBFvODWnp1rCGdFugoA8klqNu5KZeoA2SkJZtKg6X8e/Gg1dZKYPj9qpw7S4etMV55h2lMOlla3j8rVlxyJ0sXhUPpp+EJkF/XphRqb/Qx6Rt6H/pxzstVpHrtSPbYvqw5vFD97DjnHG1I87vRoKyMhR9oiRvigW+2yx1zCgnPNMMjdTPcSJ71lHhHgSF1sQ47GJXPmZovhJF2/PRJkz/HRGNGFsg9Fovw1b7PPjRRKumefRy5/W15y+yJTbUU0H0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7IWDF5KpM1YQL2k/JD3DXmWvt2UtspIEQOHZhBvsOM=;
 b=Yb4XPLt0sKDAugpu03bEWWdX0Hd8w3SxkqK4OKUxWoEJTSHxCEpVuJuGYDkqkDEETFVaGx6ZoJiD5PgrXJ+xIyL2e3MZh0BmPKWmlssUVZRLE0/npz1u26ftqmAH76OVxxne8BVz0roT0YyhnfTUctzdC5+WMSVKhiOVewmuJbqlhhQmQ+quZI2tP4EJ+sNxEFPwJngEsmPq62jallZQ8DNQp1m3opR8mcvqpjwtBg5L+wr5IEtaxuPDXWn778yQiccgnkCkSmHWilXOwH+5aPnRYIwjtWABl2Di1jVRiCjZWk3dYd2uEgYLrjj3MPBnaaGIgojSQFxAOxMZtb6+vQ==
Received: from MW2PR2101CA0028.namprd21.prod.outlook.com (2603:10b6:302:1::41)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:57 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::9c) by MW2PR2101CA0028.outlook.office365.com
 (2603:10b6:302:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.3 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:38 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:36 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 12/17] mlxsw: spectrum_fid: Add an object to keep flood profiles
Date: Tue, 28 Nov 2023 16:50:45 +0100
Message-ID: <15e113de114d3f41ce3fd2a14a2fa6a1b1d7e8f2.1701183892.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfc3a8d-fc39-44c2-fea1-08dbf029f37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n3o7YdsGzZ9yZ+eU7I9lVDRWUkHc/Nj5sxmR0kdjFt9maUxEElEwN6SOVk7antrR5UAp+3fAmZ7SymRMoVmgLHlFkE7FoXsmapeKzXbvwoRmgG6gt7uzcj7vC8zEwI9WLdqatAtrlfVOuY77UjyNqkXF3z4jSLHpaOZfyd8mH6vFxjpbnQ4zh9p29MK5lLv7BhiLlfmvJPFe/30L0JZf3XvoRe0Qcd7KAEuIOYrZNvbrqbowHsA5AQ88POCoH93bhSTOiWVlPwlLDKGHyvChZuXyEm0Dxf20DvZep7nI+61srZnQnX2uloNRP2GGKdx91iAwdDeT29LzSf8fblZiq/E4Nqx70Xu4DkdoDQVfyk6rjPBnxU8ranZ+5mBxOatU2FFV+KGiJ8tfb0vgeQnS8wMeiS1QT2Ad2Vse6e8m8rPy1ktlhWDfWvYiSa33id4IlJWX4ZAh8CjelfZ5nvkUmy0J0CrRHy178WpReoJzTCDQXo/HbZtfVKRyj3vLZmZEW6nwVRHWNhTdqmLMjrQY9dbIcMg3fcek6qzoYhacLo6XYaBnAKYTTFCMFCt58XSLKsHxvpWpmU3i3cyE2SMyvIhFvqwz6Xoia+A5g1WjVAr+XuaX4EeL5j3IjUqt2r6DvFUs3LwWpF2LBgn5IHRzfrMXZ/8Cgy7dd6AGarelxB7zqAGCkYmsmkug557D3RIsXJ6297hs2IjUE8GK3H702LjhKYkNoJgniHGBPzpsFnCMVNAjoNm7mtURY0Sq09kI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(4326008)(6666004)(8936002)(8676002)(110136005)(54906003)(316002)(478600001)(40460700003)(356005)(47076005)(7636003)(36756003)(40480700001)(41300700001)(86362001)(107886003)(26005)(2906002)(36860700001)(70586007)(2616005)(426003)(83380400001)(16526019)(70206006)(82740400003)(5660300002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:57.1696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfc3a8d-fc39-44c2-fea1-08dbf029f37f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

A flood profile is a mapping from traffic type to an offset at which a
flood vector should be looked up. In mlxsw so far, a flood profile was
somewhat implicitly represented by flood table array. When the CFF flood
mode will be introduced, the flood profile will become more explicit: each
will get a number and the profile ID / traffic-type / offset mapping will
actually need to be initialized in the hardware.

Therefore it is going to be handy to have a structure that keeps all the
components that compose a flood profile. Add this structure, currently with
just the flood table array bits. In the FID families that flood at all,
reference the flood profile instead of just the table array.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 50 ++++++++++++-------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 76b0df7370b3..af460a0d030b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -113,6 +113,11 @@ struct mlxsw_sp_fid_ops {
 			      const struct mlxsw_sp_port *mlxsw_sp_port);
 };
 
+struct mlxsw_sp_fid_flood_profile {
+	const struct mlxsw_sp_flood_table *flood_tables;
+	int nr_flood_tables;
+};
+
 struct mlxsw_sp_fid_family {
 	enum mlxsw_sp_fid_type type;
 	size_t fid_size;
@@ -120,8 +125,7 @@ struct mlxsw_sp_fid_family {
 	u16 end_index;
 	struct list_head fids_list;
 	unsigned long *fids_bitmap;
-	const struct mlxsw_sp_flood_table *flood_tables;
-	int nr_flood_tables;
+	const struct mlxsw_sp_fid_flood_profile *flood_profile;
 	enum mlxsw_sp_rif_type rif_type;
 	const struct mlxsw_sp_fid_ops *ops;
 	struct mlxsw_sp *mlxsw_sp;
@@ -331,10 +335,13 @@ mlxsw_sp_fid_flood_table_lookup(const struct mlxsw_sp_fid *fid,
 	struct mlxsw_sp_fid_family *fid_family = fid->fid_family;
 	int i;
 
-	for (i = 0; i < fid_family->nr_flood_tables; i++) {
-		if (fid_family->flood_tables[i].packet_type != packet_type)
+	for (i = 0; i < fid_family->flood_profile->nr_flood_tables; i++) {
+		const struct mlxsw_sp_flood_table *flood_table;
+
+		flood_table = &fid_family->flood_profile->flood_tables[i];
+		if (flood_table->packet_type != packet_type)
 			continue;
-		return &fid_family->flood_tables[i];
+		return flood_table;
 	}
 
 	return NULL;
@@ -352,7 +359,7 @@ mlxsw_sp_fid_8021d_pgt_size(const struct mlxsw_sp_fid_family *fid_family,
 {
 	u16 num_fids = mlxsw_sp_fid_family_num_fids(fid_family);
 
-	*p_pgt_size = num_fids * fid_family->nr_flood_tables;
+	*p_pgt_size = num_fids * fid_family->flood_profile->nr_flood_tables;
 	return 0;
 }
 
@@ -382,7 +389,7 @@ int mlxsw_sp_fid_flood_set(struct mlxsw_sp_fid *fid,
 	const struct mlxsw_sp_flood_table *flood_table;
 	u16 mid_index;
 
-	if (WARN_ON(!fid_family->flood_tables))
+	if (WARN_ON(!fid_family->flood_profile))
 		return -EINVAL;
 
 	flood_table = mlxsw_sp_fid_flood_table_lookup(fid, packet_type);
@@ -1177,6 +1184,12 @@ static const struct mlxsw_sp_flood_table mlxsw_sp_fid_8021d_flood_tables[] = {
 	},
 };
 
+static const
+struct mlxsw_sp_fid_flood_profile mlxsw_sp_fid_8021d_flood_profile = {
+	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
+	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
+};
+
 static bool
 mlxsw_sp_fid_8021q_compare(const struct mlxsw_sp_fid *fid, const void *arg)
 {
@@ -1526,8 +1539,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp1_fid_8021q_family = {
 	.fid_size		= sizeof(struct mlxsw_sp_fid_8021q),
 	.start_index		= MLXSW_SP_FID_8021Q_START,
 	.end_index		= MLXSW_SP_FID_8021Q_END,
-	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
-	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
+	.flood_profile		= &mlxsw_sp_fid_8021d_flood_profile,
 	.rif_type		= MLXSW_SP_RIF_TYPE_VLAN,
 	.ops			= &mlxsw_sp_fid_8021q_ops_ctl,
 	.flood_rsp              = false,
@@ -1540,8 +1552,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp1_fid_8021d_family = {
 	.fid_size		= sizeof(struct mlxsw_sp_fid_8021d),
 	.start_index		= MLXSW_SP_FID_8021D_START,
 	.end_index		= MLXSW_SP_FID_8021D_END,
-	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
-	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
+	.flood_profile		= &mlxsw_sp_fid_8021d_flood_profile,
 	.rif_type		= MLXSW_SP_RIF_TYPE_FID,
 	.ops			= &mlxsw_sp_fid_8021d_ops_ctl,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_1,
@@ -1580,8 +1591,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021q_family_ctl = {
 	.fid_size		= sizeof(struct mlxsw_sp_fid_8021q),
 	.start_index		= MLXSW_SP_FID_8021Q_START,
 	.end_index		= MLXSW_SP_FID_8021Q_END,
-	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
-	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
+	.flood_profile		= &mlxsw_sp_fid_8021d_flood_profile,
 	.rif_type		= MLXSW_SP_RIF_TYPE_VLAN,
 	.ops			= &mlxsw_sp_fid_8021q_ops_ctl,
 	.flood_rsp              = false,
@@ -1594,8 +1604,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021d_family_ctl = {
 	.fid_size		= sizeof(struct mlxsw_sp_fid_8021d),
 	.start_index		= MLXSW_SP_FID_8021D_START,
 	.end_index		= MLXSW_SP_FID_8021D_END,
-	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
-	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
+	.flood_profile		= &mlxsw_sp_fid_8021d_flood_profile,
 	.rif_type		= MLXSW_SP_RIF_TYPE_FID,
 	.ops			= &mlxsw_sp_fid_8021d_ops_ctl,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_1,
@@ -1761,10 +1770,13 @@ mlxsw_sp_fid_flood_tables_init(struct mlxsw_sp_fid_family *fid_family)
 	if (err)
 		return err;
 
-	for (i = 0; i < fid_family->nr_flood_tables; i++) {
+	if (!fid_family->flood_profile)
+		return 0;
+
+	for (i = 0; i < fid_family->flood_profile->nr_flood_tables; i++) {
 		const struct mlxsw_sp_flood_table *flood_table;
 
-		flood_table = &fid_family->flood_tables[i];
+		flood_table = &fid_family->flood_profile->flood_tables[i];
 		if (fid_family->ops->flood_table_init) {
 			err = fid_family->ops->flood_table_init(fid_family,
 								flood_table);
@@ -1813,7 +1825,7 @@ static int mlxsw_sp_fid_family_register(struct mlxsw_sp *mlxsw_sp,
 		goto err_alloc_fids_bitmap;
 	}
 
-	if (fid_family->flood_tables) {
+	if (fid_family->flood_profile) {
 		err = mlxsw_sp_fid_flood_tables_init(fid_family);
 		if (err)
 			goto err_fid_flood_tables_init;
@@ -1836,7 +1848,7 @@ mlxsw_sp_fid_family_unregister(struct mlxsw_sp *mlxsw_sp,
 {
 	mlxsw_sp->fid_core->fid_family_arr[fid_family->type] = NULL;
 
-	if (fid_family->flood_tables)
+	if (fid_family->flood_profile)
 		mlxsw_sp_fid_flood_tables_fini(fid_family);
 
 	bitmap_free(fid_family->fids_bitmap);
-- 
2.41.0


