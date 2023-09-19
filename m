Return-Path: <netdev+bounces-35031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FE27A6856
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F928131E
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE337C95;
	Tue, 19 Sep 2023 15:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC23717C
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:50:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08501BE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdxLXJfUDo4ULSGoHW+38SxO5sRkgj5mOVSZtSdIAeE9fIEDAmhr4CmOQKuAS3/hcC0bHOaASnaU3GaEC8k07KeVct2PxbJuw6kTCP9HibwcaBWdlp5tXiBng/XGNtQ3zrNYIu1OiuCx9HyDG63UAgj3xLjyIgm0c76xKX6WaQh/cp+xuQ5zK+IX1ohYCdcPNPRf/P9V8ZT094xmb4onFzldLAg8Se/eA2Q9Y5h8b1lI2znBelipGncqRJcri26ikTw1gGLU+7qSi3inq3nQF+L7U5s5rZjATyxPleCRP2RB21Ouu28sq8USDwqdxX+poCHnLw1dVXpmGNqHAqXI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLAddiIrSNCTtRohgDc7XTftr+TsHvH5PKzrfJW/0BY=;
 b=ELcLApI7ric/TCxZSM62qnUJW6whqTFH98g8Jf1766f+qZ7YFPLyMia+lYGIEXFSnorFtpRzCAH4OdRT2DfL+FjoBQZX2uOBc/+HAxmnKx7PfnwzuNH+rNN3Gqjmu/+ChMZwTTw2qsV/lHSIdX9fMu16alCHAmuVTXZHTElYc2OALJEuZ9hTmwwZltVGAoosT9TVab9xu/nRnRjRO6teqrkDbOPppwlY2+snoii3uDawqFqDPd+OYdZ19BL3w6e5Ud65viSwRSMDV00V+d1K9M625Nnc7z1/ALLWtkLibRKCLzHPahbMf6iSYbW7DYM5c0khMHJt7X2Pk0usQL3H+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLAddiIrSNCTtRohgDc7XTftr+TsHvH5PKzrfJW/0BY=;
 b=aFWCIpoiGiyYFtpErg9rlnOcSVfLvHhHIiZ7GbqUaKJXDDjZh0heUQEto4Vf+/uBpjyYAeyrxueWpMOLaaLuFyYzpg9/oziDg9CaJkTFjd/xKy4C7DQpO/m/aSeXYIqs/ywX9CBQjLguT3ed6P0WgH8bnIDcpybwy8u4lWUhu4T4EBfSYYn15dbtHbxMDRxZ4RpXVRCj81BoozhGIJ9cjHMoaCHP1zi3G5vX0pfuy7sK1gyI0b6bSxLqwXv5/SavrzEq72HKDZ5YKTT0GvVSrc/0Ws1kMI3Ofla0j1Kd7MApE0iBe2zJYGcGCojiGVvBBautrVcvh6bx0E7L1JYvTw==
Received: from SN4PR0501CA0106.namprd05.prod.outlook.com
 (2603:10b6:803:42::23) by MW6PR12MB8998.namprd12.prod.outlook.com
 (2603:10b6:303:249::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:43:46 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::e3) by SN4PR0501CA0106.outlook.office365.com
 (2603:10b6:803:42::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 15:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 15:43:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 08:43:26 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 08:43:23 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 3/3] mlxsw: Edit IPv6 key blocks to use one less block for multicast forwarding
Date: Tue, 19 Sep 2023 17:42:56 +0200
Message-ID: <1eef364e0a42ad93e07352f9a3134bc5c6841668.1695137616.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: d35809b2-8524-4381-746f-08dbb92735e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cTunCIU4qKvE1nqQ+o+1pqA9YR9E74HmoB0pCmdu6PkWDbEWMbEnbIChrXLdi1rxWCJLHnA4HxOcppacSL/c75Myf7FsbILjwZEu0eXcVcyNoOgseg2wSV9o8kJd/evvsyUmtttq9M1QbAE5M+fFT9pf2IvfMcy+VvsvF3sqrRiX9nPNaA/L6r66BcEQfoPNT3T/tVVzx2X49Ntbl/rLwLHtjBsL8wsOQsObw1aKksrBN7oNOUR601x14hpHrRbya8OQ1/LmByrFDBnvY/gHaJ4isVAExwRbLvUWsAjV1SxNyg7fjEOxMTbRDXPjeLznNhCc4JlH/OaxobDVA6NBMp44jSd7MhhaIwRfEQS0md4973KjjdZ9ujpqiOOnaNO5UADVVjT5RlOJapmHuWkWvqPPFCrSa58wcZd9N2UFsNL7+4nNuh4douVR5HpOoFNHE6styOSAh5mqJk3nAGhIs3PkDWcK2BpVYvkMuNrpijtepn+WI6p7I45kUAmpWXMthXUZf3TbpqY3fyp5Xu57KucGh/B7m5rLr+c+QrqbPFroxUQrPQDkV7CrbdphWZD9Af/67qs8mQiJKrYepTYXcXRH2hywC+WPD7lxCwucx6Vy1uHqzzkn923BHGrImqUpiHjYh9UUmHPJuHrQ73RQMqcHRs6pcqBi99EBlZo8UssnuCHKevUGSpFcdM7c/0ERnyw/qhKSlBhX4oQw37I3LJHDn2tyz55PHB449yrvJrgwsM+F09VYUuIGP+IqEFas
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(356005)(7636003)(82740400003)(36756003)(40480700001)(40460700003)(86362001)(478600001)(54906003)(70206006)(2906002)(70586007)(110136005)(6666004)(7696005)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(47076005)(36860700001)(66574015)(107886003)(26005)(16526019)(2616005)(426003)(336012)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:43:46.1006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35809b2-8524-4381-746f-08dbb92735e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


