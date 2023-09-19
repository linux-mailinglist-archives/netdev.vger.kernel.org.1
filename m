Return-Path: <netdev+bounces-35031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717B7A685D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E226D1C20912
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E492374EF;
	Tue, 19 Sep 2023 15:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A5374EE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:50:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC5D9
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6no4KBfiv8lBJ4of7svmOkzFCLhPfCuoyjIWE4FfXytgxOPNcNYrojGkjrZTa8tEhoOQO+KRU05ZLzNr79GMGpSaWvS39sM3blZtQGQTNB5dvwYaQBHENnbPdrmWcTxunaT8GwsSxrirIOq89R/p4YnW2rm0evytHAQuEYXgw9KajJvZhRFxeMHlj/wkS2JaJ3gSy8ieV6qgGNAWSbnHIhVjoLg7HJloRj3nHqzDYEzbW25e4QjMWWGomgKyvAdztRhjr+PHoSeBzv5d7/x+/pftF0jeg8ZJa34+315Qfa+96hyJ2KmANnU47wIa4F1BBP1iS4fUWyyHDxA0wjBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGMLIim/p0v5+uWBxZNG7Zz8sY5G+NIBGwGArDUvrMM=;
 b=YUUgI7VJ5GTvyjyFmD8RMK7YLg56fYpuZrCgLNr2r+ZyNzZEYGq61K4WRwODMAAGccM6IA7M8PTDAYI/ZV2Px98LOkBAZPvQgQSeVzLswrdLu6h6a5eVbKZM1thGk5DLMMguk4bJYQBX8YvdD40yeIw2ejbo1ETOx76mWXin5bx7Wtqg2t9Iou6uau7nERIAElGxrRwDHvhTzWthGdNYyxcxqrBZfbl+8F9TVg8qBwrlhCJigE6VuxQqvSwu5C4gNTlniULoJZcd/74JE+xonBU0RaEBYmDwcmxYTtl1eoBon+m6IvORsn2PtelJJ2HKJvdSQP4gbe5J0e+qc4NfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGMLIim/p0v5+uWBxZNG7Zz8sY5G+NIBGwGArDUvrMM=;
 b=iBxpvwo5JLTESV0Ylxr1Xjxw0AScX08jbMqyPYJ4ltOl3K2axGTQAYIifrEWZXh1o4w1L7kT3flsDpgdD0Khm/ibPhdYXZVEYqZyYswEHJf9oym8Cfds+ZAJFM3k0KqyRl/6Eka3GhLfZGZ8PTOeCB6xYSevmU4QA+Fi7m+Fx9AaOnLHQHxrpklhSkq55ia2fdFkuXY7M8WiYbaw6lXSK8PcOiJ2fqjZUFrqJDyYPhTxyWWAOOev0jaUqxg3mh/Q/IhWuzdURkNi+wl5P37KSO7umVqNRYkAi/1LDLO//eExVSlrR0R8ZTxlpv8Ef4tgzWZ99Ls6Xc21gletWu1wWA==
Received: from SJ0PR13CA0067.namprd13.prod.outlook.com (2603:10b6:a03:2c4::12)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:43:41 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::cc) by SJ0PR13CA0067.outlook.office365.com
 (2603:10b6:a03:2c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 15:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 15:43:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 08:43:23 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 08:43:21 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 2/3] mlxsw: spectrum_acl_flex_keys: Add 'ipv4_5b' flex key
Date: Tue, 19 Sep 2023 17:42:55 +0200
Message-ID: <099dfb2a2576f9d8aee69aa22e8d84ed69b7247f.1695137616.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d71e2ec-b20f-4928-fa0f-08dbb92732ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2xvq3+XpPZeMATVYeAta2a5XP+opvd2lGEXxMWj7WF+HSiBtzAaemrWMiZe+55XoHyLVrgj0h0KWQIxb8MgAi5yZZWrwGA7Grm6ULoe3E1CYMknLRsgShTjLJL5WzZWO8oQ0xuTFvTZElln1qt6vDAiNGUO+thZNFaa7YSKsDzApvGGxCUmJGVWEUOqg81xdfvjn5rd0bMp/0QV/PQoyFmMukMgGfqrANMsULX7mcNobB6lMiICVfKh5+hsTEBzRs3+eBMfzu2BMpQf6t2xIUWg7+ifrPx1lwzfF2PEofyi59zX0OhEgKfPfpvMh8eruxdQ3zlVCvhGYXqdahrBhd5Eo5qMbxhYjsu+R8QbEZOpkKOmlaeIP64oWZ66H3me31qmzw+75tU6HrhY95rG0A9Z30bmgH/rHZLdkJEYGyC/pZEeRpAdH8AWcEryQndNPMg4QqPV+nhy5o4+OmnvCDPUO4Vt0TLi1+gSkKF3HozlG5PjPFIK/Xjdf1wEEDEcXDFS6JNQ8tOTB1CdRbBblzeaEeUlDIGQhooTByX02VCYfa88YXY1d8ZeWyBG4p6BuMB56hzMjlAYXQ/DpSBrxT7ZT3Z5a/mCbf708KuoeviU3xa28XIislUMTI+0JW+cw3uFDeMMUQTSKIxP8R0GJ0R6fbxA22sTCrGCOeiZEGH0X/fh/CZzn74YjBQG/7oVKea42tbEBp9bNP1DyiGJuXzB3Ma6q2LrdYtMMnV0qu8Q=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(16526019)(2616005)(26005)(107886003)(7696005)(36860700001)(82740400003)(47076005)(356005)(36756003)(86362001)(7636003)(426003)(336012)(66574015)(83380400001)(40480700001)(110136005)(5660300002)(478600001)(41300700001)(54906003)(70206006)(70586007)(316002)(4326008)(8676002)(8936002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:43:40.6710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d71e2ec-b20f-4928-fa0f-08dbb92732ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Cohen <amcohen@nvidia.com>

The previous patch replaced the key block 'ipv4_4' with 'ipv4_5'. The
corresponding block for Spectrum-4 is 'ipv4_4b'. To be consistent, replace
key block 'ipv4_4b' with 'ipv4_5b'.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index cc00c8d69eb7..7d66c4f2deea 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -321,8 +321,8 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
 	MLXSW_AFK_ELEMENT_INST_EXT_U32(SRC_SYS_PORT, 0x04, 0, 9, -1, true), /* RX_ACL_SYSTEM_PORT */
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4b[] = {
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER, 0x04, 13, 12),
+static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5b[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER, 0x04, 20, 12),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
@@ -339,7 +339,7 @@ static const struct mlxsw_afk_block mlxsw_sp4_afk_blocks[] = {
 	MLXSW_AFK_BLOCK(0x38, mlxsw_sp_afk_element_info_ipv4_0),
 	MLXSW_AFK_BLOCK(0x39, mlxsw_sp_afk_element_info_ipv4_1),
 	MLXSW_AFK_BLOCK(0x3A, mlxsw_sp_afk_element_info_ipv4_2),
-	MLXSW_AFK_BLOCK(0x35, mlxsw_sp_afk_element_info_ipv4_4b),
+	MLXSW_AFK_BLOCK(0x36, mlxsw_sp_afk_element_info_ipv4_5b),
 	MLXSW_AFK_BLOCK(0x40, mlxsw_sp_afk_element_info_ipv6_0),
 	MLXSW_AFK_BLOCK(0x41, mlxsw_sp_afk_element_info_ipv6_1),
 	MLXSW_AFK_BLOCK(0x47, mlxsw_sp_afk_element_info_ipv6_2b),
-- 
2.41.0


