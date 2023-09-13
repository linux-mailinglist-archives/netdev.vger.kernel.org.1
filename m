Return-Path: <netdev+bounces-33623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77DB79EEEB
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193821C2104C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BAC1F931;
	Wed, 13 Sep 2023 16:41:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153451F167
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 16:41:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9B5243
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdTGRNA8/Dm0fcp1Q2o7Du5SM/PhGJen+aU0Fvar8TGLa/vFTRzFfAZxaqlnvDxEDTrHjk6eDTPix3rnzwTQcyFVpre3hfjCzCJ0SuCBQ+bvUAUidD23+rTOavwSTpGI5tetYfIt+fb4oolaB27j3bKftfPEpUpozzg8njQJa63uIo7MhTMEbnTn0fHhBd9peH9FISkRfaQSECffSM2EghJ7wN5zCLD6J573O5IhDPDdAQcrs2hfCoQx+b+zOF5hW9UystxPqqZJBRtQMKGRh9rCoxv39j5Blt2OxV+sS7CkI2wSCaQhm6YzG5sWWbq93G8TXXW4bv7QsKVTaUZlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLAddiIrSNCTtRohgDc7XTftr+TsHvH5PKzrfJW/0BY=;
 b=cVL5veKNy396T2TixEK9wbp69JKhg/EJIZMLjlORWKWmvPXFlVbhF8tzDEG6S1XnKdPrRP7FBYYs3DSF8uVAmJ7lEHYXFxHzdzpAeG1YQ5FmBATfLOzk3yVVIluS8St9TB5ZFll/1PYWAXWiZCyJTUKaiCo8KBsAqq0LOSO0kp6yNuiJhIhKvozmTWuCfrcYl3a64sXzXigL6ueYmbEWK6l8Bj4ZzYgDxTPRwiWpePOLfXZhHzbBI5a5Ar62OZ+V7f4o1RHHuuJ8x2du0qzcNC2RT54Ygj21B+9uFpmOIFea6juvLvsP58QF4k3zMBUxoekNjyiDpQo/He1XkLL6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLAddiIrSNCTtRohgDc7XTftr+TsHvH5PKzrfJW/0BY=;
 b=UOVnclwEP6OcQawjLtWveySddXByI6uUwpoGMWgYc7+NjSRuUr/UdJXpcei0BSIAip2iWRJnIuGHvHFlqqez0j3dbm50hmG8cuT5yFxCyQz8wkOVDdP8a0pwIxL/f1hnaVgI58tIrEzZWuq79+qiUS8JUDFnbwU4Hq22IzirxuiKITZEw7lW1BY2WWjR11xSrP6QYmUU3PTTbqtr4sWJnGu6B9KSI92oZH/bo10z0npHRsDvlTNF64/VZLB4OMt2u0bqVJddC0i4GCqspFOgeB2VZuhPZ/44h58E3zAgnPIQQrpap4sliYnFOYy1q6DgN4KThgwnt7J/kZ5h0rM2gw==
Received: from CH2PR14CA0042.namprd14.prod.outlook.com (2603:10b6:610:56::22)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.40; Wed, 13 Sep
 2023 16:41:27 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::fe) by CH2PR14CA0042.outlook.office365.com
 (2603:10b6:610:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Wed, 13 Sep 2023 16:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 16:41:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Sep
 2023 09:41:14 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Sep 2023 09:41:12 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/3] mlxsw: Edit IPv6 key blocks to use one less block for multicast forwarding
Date: Wed, 13 Sep 2023 18:40:47 +0200
Message-ID: <46610a17078f8bc68fb2b0189a24403f038610fe.1694621836.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694621836.git.petrm@nvidia.com>
References: <cover.1694621836.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: d41ffa68-5159-4d84-16e9-08dbb4784646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P26kOvmRIQSDmdlQTJgplHI5hhUPYCsbAA3m3Ipe+1aYeByeZr24WSURGKtuAt3o7SHs0McmeP+HTBAdOhOnzusdrDvHEiOJ4VTPqk6nS21+hs4K2BNU/dPUUmyIGK/gurODNWC9DmdxU94om4Mi+fLKBwO3EebPI0nGSAWQDWM0mokfM1JIYY96A1EXeqVr/n4lY1zAPngSb2sxbQnvLHs/7+PNinKMJ5HoMdMIRQB/N79eo666k92UzlN/MJtRDhPeYwRUSHVdkcfhLndQU7tNF04gS4nzp09y3AXJX87XcpWjB0ScpI1yoAxg3g3XMzzBzVZKfoFFN7Jq+d/igXEOIuX49TjkxWek06fpnM+KfNZv/jmSud7fi1aw2g0JKR216mCZLz8Vqps6EzwgO1E6hKyOYxKCJoQW9o59Bazw9QhsHzE+ZXwbtrV23aJgk75VuYTMDSFVcFA8l2qA6DjTmQmM0fvL5x+n0zOf3MCDprcs8lC6bJUbyWilZ/ukQC242QNXV7gjhk0g2i0NT8K7prH7VMxZ9mUTlFTVH+GUk0ltjBg/rsn71Wiyd2nsPLnOOjvNZhM+VNZmW+J1qUYu1tnxlyDkMXY/qjhyOgVY7kJNbE//7LHXUyb2iHRl+bGk65988UKI/cGpo/QlTiSOhugSa+SWKMj6UFJ+Po9YRu/UQ+5/XiuQD5v8f2W8Wi36/tPqzk5UUIqekrkdmlILesh1xek7N/v0k13c/olahUMNaK0eqr7B6qfPlgYI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(36860700001)(40460700003)(47076005)(66574015)(2906002)(36756003)(86362001)(82740400003)(356005)(7636003)(40480700001)(107886003)(2616005)(26005)(16526019)(8936002)(4326008)(8676002)(6666004)(41300700001)(54906003)(110136005)(70206006)(70586007)(316002)(83380400001)(7696005)(336012)(426003)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:41:26.9724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41ffa68-5159-4d84-16e9-08dbb4784646
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

From: Amit Cohen <amcohen@nvidia.com>

Two ACL regions that are configured by the driver during initialization are
the ones used for IPv4 and IPv6 multicast forwarding. Entries residing
in these two regions match on the {SIP, DIP, VRID} key elements.

Currently for IPv6 region, 9 key blocks are used:
* 4 for SIP - 'ipv4_1', 'ipv6_{3,4,5}'
* 4 for DIP - 'ipv4_0', 'ipv6_{0,1,2/2b}'
* 1 for VRID - 'ipv4_4b'

This can be improved by reducing the amount key blocks needed for
the IPv6 region to 8. It is possible to use key blocks that mix subsets of
the VRID element with subsets of the DIP element.
The following key blocks can be used:
* 4 for SIP - 'ipv4_1', 'ipv6_{3,4,5}'
* 1 for subset of DIP - 'ipv4_0'
* 3 for the rest of DIP and subsets of VRID - 'ipv6_{0,1,2/2b}'

To make this happen, add VRID sub-elements as part of existing keys -
'ipv6_{0,1,2/2b}'. Note that one of the sub-elements is called
VRID_ROUTER_MSB and does not contain bit numbers like the rest, as for
Spectrum < 4 this element represents bits 8-10 and for Spectrum-4 it
represents bits 8-11.

Breaking VRID into 3 sub-elements makes the driver use one less block in
IPv6 region for multicast forwarding. The sub-elements can be filled in
blocks that are used for destination IP.

The algorithm in the driver that chooses which key blocks will be used is
lazy and not the optimal one. It searches the block that contains the most
elements that are required, chooses it, removes the elements that appear
in the chosen block and starts again searching the block that contains the
most elements.

When key block 'ipv4_4' is defined, the algorithm might choose it, as it
contains 2 sub-elements of VRID, then 8 blocks must be chosen for SIP and
DIP and we get 9 blocks to match on {SIP, DIP, VRID}. That is why we had to
remove key block 'ipv4_4' in a previous patch and use key block that
contains one field for VRID.

This improvement was tested and indeed 8 blocks are used instead of 9.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c  |  3 +++
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h  |  3 +++
 .../ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c   | 15 ++++++++++++---
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c       |  4 ++++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 22e5efb0eb8c..745438d8ae10 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -43,6 +43,9 @@ static const struct mlxsw_afk_element_info mlxsw_afk_element_infos[] = {
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_0_31, 0x3C, 4),
 	MLXSW_AFK_ELEMENT_INFO_U32(FDB_MISS, 0x40, 0, 1),
 	MLXSW_AFK_ELEMENT_INFO_U32(L4_PORT_RANGE, 0x40, 1, 16),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_0_3, 0x40, 17, 4),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_4_7, 0x40, 21, 4),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_MSB, 0x40, 25, 4),
 };
 
 struct mlxsw_afk {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
index 75e9bbc36170..1c76aa3ffab7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -36,6 +36,9 @@ enum mlxsw_afk_element {
 	MLXSW_AFK_ELEMENT_VIRT_ROUTER,
 	MLXSW_AFK_ELEMENT_FDB_MISS,
 	MLXSW_AFK_ELEMENT_L4_PORT_RANGE,
+	MLXSW_AFK_ELEMENT_VIRT_ROUTER_0_3,
+	MLXSW_AFK_ELEMENT_VIRT_ROUTER_4_7,
+	MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
 	MLXSW_AFK_ELEMENT_MAX,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
index 2efcc9372d4e..99eeafdc8d1e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
@@ -88,7 +88,9 @@ static void mlxsw_sp2_mr_tcam_ipv4_fini(struct mlxsw_sp2_mr_tcam *mr_tcam)
 }
 
 static const enum mlxsw_afk_element mlxsw_sp2_mr_tcam_usage_ipv6[] = {
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER,
+		MLXSW_AFK_ELEMENT_VIRT_ROUTER_0_3,
+		MLXSW_AFK_ELEMENT_VIRT_ROUTER_4_7,
+		MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
 		MLXSW_AFK_ELEMENT_SRC_IP_96_127,
 		MLXSW_AFK_ELEMENT_SRC_IP_64_95,
 		MLXSW_AFK_ELEMENT_SRC_IP_32_63,
@@ -140,6 +142,8 @@ static void
 mlxsw_sp2_mr_tcam_rule_parse4(struct mlxsw_sp_acl_rule_info *rulei,
 			      struct mlxsw_sp_mr_route_key *key)
 {
+	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_VIRT_ROUTER,
+				       key->vrid, GENMASK(11, 0));
 	mlxsw_sp_acl_rulei_keymask_buf(rulei, MLXSW_AFK_ELEMENT_SRC_IP_0_31,
 				       (char *) &key->source.addr4,
 				       (char *) &key->source_mask.addr4, 4);
@@ -152,6 +156,13 @@ static void
 mlxsw_sp2_mr_tcam_rule_parse6(struct mlxsw_sp_acl_rule_info *rulei,
 			      struct mlxsw_sp_mr_route_key *key)
 {
+	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_VIRT_ROUTER_0_3,
+				       key->vrid, GENMASK(3, 0));
+	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_VIRT_ROUTER_4_7,
+				       key->vrid >> 4, GENMASK(3, 0));
+	mlxsw_sp_acl_rulei_keymask_u32(rulei,
+				       MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
+				       key->vrid >> 8, GENMASK(3, 0));
 	mlxsw_sp_acl_rulei_keymask_buf(rulei, MLXSW_AFK_ELEMENT_SRC_IP_96_127,
 				       &key->source.addr6.s6_addr[0x0],
 				       &key->source_mask.addr6.s6_addr[0x0], 4);
@@ -187,8 +198,6 @@ mlxsw_sp2_mr_tcam_rule_parse(struct mlxsw_sp_acl_rule *rule,
 
 	rulei = mlxsw_sp_acl_rule_rulei(rule);
 	rulei->priority = priority;
-	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_VIRT_ROUTER,
-				       key->vrid, GENMASK(11, 0));
 	switch (key->proto) {
 	case MLXSW_SP_L3_PROTO_IPV4:
 		return mlxsw_sp2_mr_tcam_rule_parse4(rulei, key);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index 7d66c4f2deea..4b3564f5fd65 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -176,14 +176,17 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5[] = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_0[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_0_3, 0x00, 0, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_32_63, 0x04, 4),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_1[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_4_7, 0x00, 0, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_64_95, 0x04, 4),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2[] = {
+	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER_MSB, 0x00, 0, 3, 0, true),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_96_127, 0x04, 4),
 };
 
@@ -326,6 +329,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5b[] = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_MSB, 0x00, 0, 4),
 	MLXSW_AFK_ELEMENT_INST_BUF(DST_IP_96_127, 0x04, 4),
 };
 
-- 
2.41.0


