Return-Path: <netdev+bounces-28467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D282477F838
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85035282095
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3188C14A8E;
	Thu, 17 Aug 2023 13:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F03B14F65
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:59:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E62D62
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDXVpj8Eu432FyTDDg83KULeeTRKIM8VAa7YjssM7h9RPjJXRj3XuwiF8ZwAxwE3Ymq2W+kSaX9fcDL0u/tFJXS1Kwpfwvad7V+JLHyqKUlE6jwHfvh3TyRRE3EEI3WRmrISXR25XaUWXsq8QOYqCygF4MkKBJVhrO2ZHMpIhoqPTF+yUvUr5I8XkzIMoxfI2EmeqLeVqdIps5tw2koLeXp9OlIa4n52M9qd+1P3+hV36Wp0w6nF4ONf6rzUXl8zJ0I0I1L88scuHclJdgNMkvt4BlU8YhfvcTlm+gR0ZWZB6bjJFxuOZxaqrQGYn0R1o3oT56YzXjIMH6t6HrLLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpUd7mfs/JC6SdqyO33gj5ugnFLgr+EEtjIOxIWhNUw=;
 b=XkP7zJ3UbT41HUEWKVzQVhe8ImtGVgCTbQiXODKMpsWTLBx+43/Xb0rIFkjFFl9O65owvASm6LtEyC8rljooL0imN0IbRTNFxAItzHgLATkik+ka6ajQBkVX+79G7jj69nDXB5c+egf9n9LfzOKtwv+Zs12CaOlsYwPl/zz7vV9yvYzgsGG7IyhKvaU15jKcZJwbS2CjmxenQhEtjYHUDJ+2CnXA/LF9ysVAYCDKb8GALObP17ouMGijbH0hfkto7QUWG/UA+moixIgqlQTQfVF3J0YCLMSyOeINkTMMasLmhaBdJ6rPHglHfOUQrjpzdNnQk4aeodzpIuoM/KOxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpUd7mfs/JC6SdqyO33gj5ugnFLgr+EEtjIOxIWhNUw=;
 b=JMSoV+p0131muyA8a/hleBhNuptvxXQDGE7/32RTEeA87zxB8zqiB+KnywJpwN++DYNhIluQ6VMRDJe+BNM35yRweuavXySCy9fUyw64rcKFG3KqdhWjJl2aRyyj3xJrpVzhQF9cvuSz7LdlQPbTOVs/ST0ThPFPO4Boy5ARXeUQsIPwc5MReBcihL4V7XxfddVRZ7okPKXWXUu2NnYyCj9moSW14etOQKYR+MLHmxcTxmeK3a+SeAOqu5cq3OWrBOq9CuPSLzMPTPjYDHsR/iHy4jWQojJZuQHZuQ39NVqlC3uamfOrNE1PbORK+ZphG319kRz265WWPJ9KOkkKaw==
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 13:59:22 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::3b) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 13:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 13:59:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 06:59:11 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 06:59:08 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Danielle Ratson <danieller@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 3/4] mlxsw: Fix the size of 'VIRT_ROUTER_MSB'
Date: Thu, 17 Aug 2023 15:58:24 +0200
Message-ID: <79bed2b70f6b9ed58d4df02e9798a23da648015b.1692268427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692268427.git.petrm@nvidia.com>
References: <cover.1692268427.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c54609b-3804-4c5d-2cd1-08db9f2a28e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J3lwarrR+EnjkRz7B2+KLIhJVrseCDyifCkLfSihL1yaf6ADAdeSgajJVkgSx+DaipL4VawTQlCb+Hs7qZN7jpuw8YZqNlLsUjSgkr5TIQSBa3TqpaGc0AdrJVjVMcmapghKwEiT83FMuRNjp/qN6zH8nvDTzjPTyb79xdE+e478PqZgxJBrTKlumt0aCcTl5sCudr+9Y4wQccvnDCxwUolP/KSOT3a8EBiQ9xurUDLpTSEUDHdzM+2JxTOemWjtzjmaEMFLxNQ2YN121f8BZ3pHSQ5M8dxNe3eEKE0haCauW61SUR5IaFS5hp+vk+CH7+SulN0IhejZy+G6Ig4pLqNWQjGDQ+SV9f/5KSNkSgFD6IiGo72LvkLg384MkC/ydKHW9K/NdoTcAhvaQMwh++PaVJHlddWg8CHmosr6qj+hE8QRwzYODqnDgxiTamWjLeiZlK539OIQn3DSP/1nJyqrInb27M50dMlbMOafjEna25bM9wQ7P6kfyAxh3rbJNhkVwA7eeD283H0aj7rwYpnbtpmWbRzXlokRhCWhGN4TJfnydE+nMZjAD/CLEsmmyFbpFzWLOFylg8UWmPykDOJfVtYQwGgeKDg/HGzqVz08Sj8qx7VH+KeUJftG20GhBNn9MlWh0b/Q0bnlmtgxN+4eXvcfUyeG1qkTnUog5mfWHpai4EUOHPKHOF4jj5vxIZXAnrUy71r/VGLxyPJOX8jwcWpQnLzWN6Ax8wp+uVU8gq4V9Rt5LXhDEy3IyZXJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(36756003)(86362001)(83380400001)(40460700003)(40480700001)(8936002)(5660300002)(8676002)(4326008)(2906002)(41300700001)(26005)(336012)(16526019)(6666004)(2616005)(107886003)(47076005)(66574015)(36860700001)(426003)(478600001)(7636003)(82740400003)(356005)(54906003)(316002)(70206006)(110136005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:59:22.5515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c54609b-3804-4c5d-2cd1-08db9f2a28e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Cohen <amcohen@nvidia.com>

The field 'virtual router' was extended to 12 bits in Spectrum-4.
Therefore, the element 'MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB' needs 3 bits for
Spectrum < 4 and 4 bits for Spectrum >= 4.

The elements are stored in an internal storage scratchpad. Currently, the
MSB is defined there as 3 bits. It means that for Spectrum-4, only 2K VRFs
can be used for multicast routing, as the highest bit is not really used by
the driver. Fix the definition of 'VIRT_ROUTER_MSB' to use 4 bits. Adjust
the definitions of 'virtual router' field in the blocks accordingly - use
'_avoid_size_check' for Spectrum-2 instead of for Spectrum-4. Fix the mask
in parse function to use 4 bits.

Fixes: 6d5d8ebb881c ("mlxsw: Rename virtual router flex key element")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c     | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c      | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 7870327d921b..70f9b5e85a26 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -32,8 +32,8 @@ static const struct mlxsw_afk_element_info mlxsw_afk_element_infos[] = {
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_TTL_, 0x18, 0, 8),
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_ECN, 0x18, 9, 2),
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_DSCP, 0x18, 11, 6),
-	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_MSB, 0x18, 17, 3),
-	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_LSB, 0x18, 20, 8),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_MSB, 0x18, 17, 4),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_LSB, 0x18, 21, 8),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_96_127, 0x20, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_64_95, 0x24, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_32_63, 0x28, 4),
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
index e4f4cded2b6f..b1178b7a7f51 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
@@ -193,7 +193,7 @@ mlxsw_sp2_mr_tcam_rule_parse(struct mlxsw_sp_acl_rule *rule,
 				       key->vrid, GENMASK(7, 0));
 	mlxsw_sp_acl_rulei_keymask_u32(rulei,
 				       MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-				       key->vrid >> 8, GENMASK(2, 0));
+				       key->vrid >> 8, GENMASK(3, 0));
 	switch (key->proto) {
 	case MLXSW_SP_L3_PROTO_IPV4:
 		return mlxsw_sp2_mr_tcam_rule_parse4(rulei, key);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index b7f58605b6c7..cb746a43b24b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -173,7 +173,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_2[] = {
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_LSB, 0x04, 24, 8),
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_MSB, 0x00, 0, 3),
+	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER_MSB, 0x00, 0, 3, 0, true),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_0[] = {
@@ -324,7 +324,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4b[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_LSB, 0x04, 13, 8),
-	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER_MSB, 0x04, 21, 4, 0, true),
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_MSB, 0x04, 21, 4),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
-- 
2.41.0


