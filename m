Return-Path: <netdev+bounces-35031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A19087A6859
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FC21C209FC
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D238DD2;
	Tue, 19 Sep 2023 15:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA5374EF
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:50:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D3C0
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF7Al6H82cQFvF7IgFnltqqUMRmL5b244QfWSsDeYy41ycnTsG6WPc1ZkwLNTKvOZ3uFqrni7oDxuCE4yti8HQquD/0wnwZHjLzxCRi8hRncBYx8Sag+OFB/5KvnflU0Lra9KrdyWTOVn7Cor09w0ol1qJ1zMHKNW6zkZRWQSnmgOKNTXMhV2H+9bSJzXr19ezkCWpuIbT2Vz0r7nLPC8wyrPVJGJ50Bl8JsHzRUIpLEA4SN5OKzJSvqja6+BQGjpUQLiu8LFXoArmr7D7gxvAonVhWBjmveZH3eJ8IR8NFreBAx9oiR4Jqaa2aVDPjjQMyy1CieNN2BWVgXKL7u9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3khkxnLvcG9inlC0f3SUwzk4ZDaK6QYGCT3u2iI631o=;
 b=EQwIOxiZ+m+FDU724LpAXf+V8gRZKIg74m2yBRl3C300Z1H9KCk7Vb8e2GNqqChRLtFmPsXKvDU7pN7uAlpDXJfxVsooBD5Rel8h79XQnayMjPntwKIP2gOM0k0PS9tcFGV75/P0XVyzu5ssVvhOMeIK48mKmXGoXHIunq28fJlCXoeTgRNpGf9bWIScj1n7LvBx/1kEjEtQ1UzMUQcX0tpWfLpyYZv7IA7czCfevRqQJ35RXSAMaiOS8jKekvvEeH3h96juEJLHn68/tH2YkHotb8aq4pF16XmDIkkUVTym08HPXAjzlikDZbZhgbALQ2dQjfMGKircch4W2G1+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3khkxnLvcG9inlC0f3SUwzk4ZDaK6QYGCT3u2iI631o=;
 b=nXwBzVnZXCWalqFfSvYK0TXl4L1qv3GyN3qH0fkwn8bAHrYlWAqbL715Qlj1rxD8UtL8xtS6L/3HUdD6aQ8pQtmZtLC3+KAYznUeq3wXzumby2WMvfEfl+HLHiT4iGYB1DZcqC5qdbWiXMx//1zI1gg7ZxoR3kcEKd3ex8yVp1cTNUlQbklKkNhTwVsZVPT5+wv7rcZtwSiCYxCj2Ya++ytIuh6Olxg5u8x5oB3sLPZFdS0uL47Jptc4AXnVOhXCJaHtci3ZkkrMzFt80AlFZ1m0NySuYP3ppVjfX1if6sogMzS6DybVB3Harl0qKeSl/MSD9M0E3/vv+mqjYGCKaw==
Received: from MN2PR20CA0039.namprd20.prod.outlook.com (2603:10b6:208:235::8)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:43:33 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:235:cafe::fa) by MN2PR20CA0039.outlook.office365.com
 (2603:10b6:208:235::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 15:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 15:43:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 08:43:21 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 08:43:18 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 1/3] mlxsw: Add 'ipv4_5' flex key
Date: Tue, 19 Sep 2023 17:42:54 +0200
Message-ID: <e1414034b3fcfeabc5ad7e299d7f78d133977df7.1695137616.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695137616.git.petrm@nvidia.com>
References: <cover.1695137616.git.petrm@nvidia.com>
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
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e42fef-eec4-46a4-1742-08dbb9272e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mMnlKQpgZuFGznVePcHbfoyzSBfF8noL0MNP64kmR5pIuU1wpv+E0zrhJonKbb6fRBcwu+4Mx9jzcZ3/Ittx5d2beBPOuWnOeLehK/j91RtVHTi/o0lSkCCYClsaf3nivCXNJt6HUNooQnz+EZdOewDSXvksF85goadrC9dPFub9zTSVdd7C2O1/q2/TFCQVI5YkUw1ZG7hscwA4YaBqoHLkkPkA4gTYSZPdPxYZamkvMvlfgaWOu9XQ08mxXu90RVqbz5pt5RqQ1z1UivuUdnG9CukIspFwMP+tTlvxCz0rjpv/kFNnAeOxgEheJeNyRpUPKjcoc6KuPXtZPsa8Zoj/QoiXhfxgfzSRyhEgEFJOGb7x4znR0vINdUC33M1P/kp+H8B+NnWNeTOryF8K2xY5f/rkDlbxTg1zaOrxXJLV0HdOiT835zvUU5Xry8eD5xmvgbHoB+o6syG8E+M2/qRi6RSa86t/vVtYCd/bWy+1Br0gLi/PrjLM6Cjcg4/CBbiKX3N2g/TcKqtUm4jJNP5W/9QOOVP8YtzmeMlUhQuKnVu1A7w1Ft2e97cJWbrVeUKEArLviezJfWOqWCY7C8j8RmfQpOtCQNZfRFvrI7R1AGVldWr4oZ5ynShj8WdRjPrR+mFvhVHDPD7zlKjnxOvAYHLzaGu1ajmPac3ueyYTVVJiczlN8iGtwOCYpVQE7d7ak/KJstktKtgCMQjqrjSTLq8LPr9fW3X9+cy8ON7Pya9v3p2aLRv2bpZJmVKL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(7636003)(356005)(26005)(16526019)(82740400003)(2616005)(8936002)(8676002)(4326008)(40460700003)(107886003)(83380400001)(36860700001)(2906002)(47076005)(36756003)(426003)(336012)(66574015)(40480700001)(5660300002)(86362001)(7696005)(478600001)(6666004)(316002)(54906003)(70586007)(110136005)(70206006)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:43:33.3610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e42fef-eec4-46a4-1742-08dbb9272e5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Cohen <amcohen@nvidia.com>

Currently virtual router ID element is broken to two sub-elements -
'VIRT_ROUTER_LSB' and 'VIRT_ROUTER_MSB'. It was broken as this field is
broken in 'ipv4_4' flex key which is used for IPv4 in Spectrum < 4.
For Spectrum-4, we use 'ipv4_4b' flex key which contains one field for
virtual router, this key is not supported in older ASICs.

Add 'ipv4_5' flex key which is supported in all ASICs and contains one
field for virtual router. Then there is no reason to use 'VIRT_ROUTER_LSB'
and 'VIRT_ROUTER_MSB', remove them and add one element 'VIRT_ROUTER' for
this field.

The motivation is to get rid of 'ipv4_4' flex key, as it might be chosen
for IPv6 multicast forwarding region. This will not allow the improvement
in a following patch. See more details in the cover letter and in a
following patch.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c    |  3 +--
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h    |  3 +--
 .../net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c | 13 ++++---------
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c         | 10 ++++------
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 70f9b5e85a26..22e5efb0eb8c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -32,8 +32,7 @@ static const struct mlxsw_afk_element_info mlxsw_afk_element_infos[] = {
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_TTL_, 0x18, 0, 8),
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_ECN, 0x18, 9, 2),
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_DSCP, 0x18, 11, 6),
-	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_MSB, 0x18, 17, 4),
-	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_LSB, 0x18, 21, 8),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER, 0x18, 17, 12),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_96_127, 0x20, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_64_95, 0x24, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_32_63, 0x28, 4),
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
index 2eac7582c31a..75e9bbc36170 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -33,8 +33,7 @@ enum mlxsw_afk_element {
 	MLXSW_AFK_ELEMENT_IP_TTL_,
 	MLXSW_AFK_ELEMENT_IP_ECN,
 	MLXSW_AFK_ELEMENT_IP_DSCP,
-	MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-	MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
+	MLXSW_AFK_ELEMENT_VIRT_ROUTER,
 	MLXSW_AFK_ELEMENT_FDB_MISS,
 	MLXSW_AFK_ELEMENT_L4_PORT_RANGE,
 	MLXSW_AFK_ELEMENT_MAX,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
index b1178b7a7f51..2efcc9372d4e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
@@ -45,8 +45,7 @@ static int mlxsw_sp2_mr_tcam_bind_group(struct mlxsw_sp *mlxsw_sp,
 }
 
 static const enum mlxsw_afk_element mlxsw_sp2_mr_tcam_usage_ipv4[] = {
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
+		MLXSW_AFK_ELEMENT_VIRT_ROUTER,
 		MLXSW_AFK_ELEMENT_SRC_IP_0_31,
 		MLXSW_AFK_ELEMENT_DST_IP_0_31,
 };
@@ -89,8 +88,7 @@ static void mlxsw_sp2_mr_tcam_ipv4_fini(struct mlxsw_sp2_mr_tcam *mr_tcam)
 }
 
 static const enum mlxsw_afk_element mlxsw_sp2_mr_tcam_usage_ipv6[] = {
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
+		MLXSW_AFK_ELEMENT_VIRT_ROUTER,
 		MLXSW_AFK_ELEMENT_SRC_IP_96_127,
 		MLXSW_AFK_ELEMENT_SRC_IP_64_95,
 		MLXSW_AFK_ELEMENT_SRC_IP_32_63,
@@ -189,11 +187,8 @@ mlxsw_sp2_mr_tcam_rule_parse(struct mlxsw_sp_acl_rule *rule,
 
 	rulei = mlxsw_sp_acl_rule_rulei(rule);
 	rulei->priority = priority;
-	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
-				       key->vrid, GENMASK(7, 0));
-	mlxsw_sp_acl_rulei_keymask_u32(rulei,
-				       MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-				       key->vrid >> 8, GENMASK(3, 0));
+	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_VIRT_ROUTER,
+				       key->vrid, GENMASK(11, 0));
 	switch (key->proto) {
 	case MLXSW_SP_L3_PROTO_IPV4:
 		return mlxsw_sp2_mr_tcam_rule_parse4(rulei, key);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index cb746a43b24b..cc00c8d69eb7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -171,9 +171,8 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_2[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(IP_PROTO, 0x04, 16, 8),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4[] = {
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_LSB, 0x04, 24, 8),
-	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER_MSB, 0x00, 0, 3, 0, true),
+static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5[] = {
+	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER, 0x04, 20, 11, 0, true),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_0[] = {
@@ -220,7 +219,7 @@ static const struct mlxsw_afk_block mlxsw_sp2_afk_blocks[] = {
 	MLXSW_AFK_BLOCK(0x38, mlxsw_sp_afk_element_info_ipv4_0),
 	MLXSW_AFK_BLOCK(0x39, mlxsw_sp_afk_element_info_ipv4_1),
 	MLXSW_AFK_BLOCK(0x3A, mlxsw_sp_afk_element_info_ipv4_2),
-	MLXSW_AFK_BLOCK(0x3C, mlxsw_sp_afk_element_info_ipv4_4),
+	MLXSW_AFK_BLOCK(0x3D, mlxsw_sp_afk_element_info_ipv4_5),
 	MLXSW_AFK_BLOCK(0x40, mlxsw_sp_afk_element_info_ipv6_0),
 	MLXSW_AFK_BLOCK(0x41, mlxsw_sp_afk_element_info_ipv6_1),
 	MLXSW_AFK_BLOCK(0x42, mlxsw_sp_afk_element_info_ipv6_2),
@@ -323,8 +322,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4b[] = {
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_LSB, 0x04, 13, 8),
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_MSB, 0x04, 21, 4),
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER, 0x04, 13, 12),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
-- 
2.41.0


