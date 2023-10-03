Return-Path: <netdev+bounces-37656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF497B67D0
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 24DB0281F77
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784882135A;
	Tue,  3 Oct 2023 11:26:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E021379
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:26:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402C18E
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSZfkA3vmBfGL55mZJx+fBZ2Via4FrjmLhwW6fplgBEaOqkqiT9SNxx6qRFVRowwB+WXTub4HtHWTSvYyIp7arQ5Phmh2TUazCmirhHp1AxtO9QBd3v8LzD9wJ8FkTLm294LADaDZEe3PESFQmHExsXTySjyPRcejhHkTk5d6h/V8tANyaDR70IveX2k5srq9wuU1stVFfnacqWPQQ437P8Js56QiFuOwpYWCYMhtnisgU/EgN/AHMZYbboQWziVgLahL3Ct08zPcDkLYy69GSpSiz6cE19w6DAN0i1bGq+u/4E31q4kaYx8cDVnMnfRHWgOVWYNj4RZVD8Swgjx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M4ox8m9jR5VIDBXrBS96hjWZK2rX2hJQPvfkLeafLU=;
 b=UNE7LlFR9UuHLR6YvCNN9JDoDJ1m+WgXIivrQFBH3i2z1eGJsaw0WfpN7RwQFek8sXv2mzYuJ+pBm7yupPVk2HtGgkBg2h0WD9arahLtLQgPhuuf83l91M+7BYbLOWTha6WOBWPi066m4iz09LVvkjZWmYjiGG5t8Ab0Nsbsbf91Vi9ziy63Ckd/ZuuMdr4QEtPE1ZOp2N91hFI5k5ukS83rP2LsSuaHAwpPJhHzOyvYscnWBKfMf/nRKlJegOXtDEa4ObLmJJnSUsqweH75cswS/MCx7IT6Z15rBjR3ko4wEaIowGJRXu3Uj3ODDKZ1oYkMH9j2jomeAzuzddW0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M4ox8m9jR5VIDBXrBS96hjWZK2rX2hJQPvfkLeafLU=;
 b=izjCi8emp1atFZNqjxLp+ByALU8ZLDDRYdZ4cMBaH6Fmc/bj2QcguylqcEp7JHMggnxbmppszPCZlTi5gvn92Ic/b2d0Qr6Wpk+ADE//yEFUKGWjnmFNNrHss3ILeUKljVUH48tKb80q5weTTICKx3d7jN0CU6V4Y26SIXBsZkfl/rVj0h2RkX12Mz4sUrZQI8q7IXqw1QmtuzmX0dYNW8QDBqmGdL5pNkvWW3ELzz030Rx2W+0dcYRbccLNFkqhl7j6VNZGUnK+n2aS5KN/EqqjL+0yVGIob4DZ3TzwxZYppoZgpOgg/NWoVjw3WFQDOeZ4asC4mtribdNmC0MbYg==
Received: from SN4PR0501CA0013.namprd05.prod.outlook.com
 (2603:10b6:803:40::26) by SA3PR12MB9089.namprd12.prod.outlook.com
 (2603:10b6:806:39f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 11:26:07 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::83) by SN4PR0501CA0013.outlook.office365.com
 (2603:10b6:803:40::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Tue, 3 Oct 2023 11:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:26:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 04:25:54 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 3 Oct 2023 04:25:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/5] mlxsw: core_acl_flex_keys: Save chosen elements per block
Date: Tue, 3 Oct 2023 13:25:28 +0200
Message-ID: <d95ffeef080791802e618563957836cff59aa666.1696330098.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696330098.git.petrm@nvidia.com>
References: <cover.1696330098.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a3849d-9623-4e1c-a651-08dbc403896a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ydg4n8in3DOBFxhbuFbfavSGf2OmobGXYocK9gqdi4LkeySY5qMzoS1bdEodVKGHS/80WmaeBJO8HKxF0GWiveZ2d6H4S3mjVlQ4uvrMy08syJBEs/jbCurkQBXoaBcUQfJUA4P16KUiu6/v+yYoHRD0XpxAC5DQ5du7Pj1g172oF1AzWZp6ZALZ1SqmLcAKjdnmlUPFYl3TNYHHM4slnronmPF6i1EXtV3oWsCw2Fxwl5UedpOMr17XZmLQZ7+C8Hv9Xrr/vttPw9SgEbbHPOLaSNt24/I+DpDvA3UIFbNbECaFxbhXPp7vJWLtHMyLpDiF4atmo2/3vL6q24fRiFjXs4bLENUE74TAniaVlUPo8AUTTerVwSqrrujaYcjDjSyf3PsacRLX4Zxhd5Ay4VGGGPyzINFZ1QRWIIZckvPeS1ANuK8yP1nKraovzGg2ayKNeXD3bR5LHgPoZ8fuZgefFz2D5qnVCmpcvw8QcXAhK0ADGIKgE12oZP7E0BM4SEFpEtA0d5GnUWFin/sGnOxHQn0iVRiSGDZ9RsHKXcLvNIXUzoEilhewja2j0FF+G4D539ca3sigPIKavwkwQPXmm860t5fju7wSgSnk6ENZZ4AuYiMiiq2L5hV7zC/uAr5YFaOTTcRiEhj7wm2S/UeUWr48LTni9FpCq3+7thUmr5vqenzNuo5v8ZsndYBknkbbgpCMaO3MvCv0SLTt0iKaQ4bmTAaWnAx4a9wDA2o98IplzJVN4PBhzZxzFNvyvl1IXC/CSdWY7rLCPsDv/g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(2616005)(107886003)(40480700001)(40460700003)(82740400003)(36756003)(356005)(86362001)(7636003)(36860700001)(16526019)(6666004)(2906002)(47076005)(5660300002)(26005)(83380400001)(8936002)(316002)(41300700001)(426003)(478600001)(336012)(70206006)(70586007)(54906003)(8676002)(4326008)(110136005)(60793003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:26:07.1063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a3849d-9623-4e1c-a651-08dbc403896a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Cohen <amcohen@nvidia.com>

Currently, mlxsw_afk_picker() chooses which blocks will be used for a
given list of elements, and fills the blocks during the searching - when a
key block is found with most hits, it adds it and removes the elements from
the count of hits. This should be changed as we want to be able to choose
which blocks will be placed in blocks 0 to 5.

To separate between choosing blocks and filling blocks, several pre-changes
are required. During the search, the structure 'mlxsw_afk_picker' is
used per block, it contains how many elements from the required list appear
in the block. When a block is chosen and filled, this bitmap of elements is
cleaned. To be able to fill the blocks at the end, add a bitmap called
'chosen_element' as part of picker. When a block is chosen, copy the
'element' bitmap to it. Use the new bitmap as part of
mlxsw_afk_picker_key_info_add(). So later, when filling the block will
be done at the end of the searching, we will use the copied bitmap that
contains the elements that should be used in the block.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index e0b4834700dd..7679df860a74 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -138,6 +138,7 @@ mlxsw_afk_key_info_find(struct mlxsw_afk *mlxsw_afk,
 
 struct mlxsw_afk_picker {
 	DECLARE_BITMAP(element, MLXSW_AFK_ELEMENT_MAX);
+	DECLARE_BITMAP(chosen_element, MLXSW_AFK_ELEMENT_MAX);
 	unsigned int total;
 };
 
@@ -208,7 +209,7 @@ static int mlxsw_afk_picker_key_info_add(struct mlxsw_afk *mlxsw_afk,
 	if (key_info->blocks_count == mlxsw_afk->max_blocks)
 		return -EINVAL;
 
-	for_each_set_bit(element, picker[block_index].element,
+	for_each_set_bit(element, picker[block_index].chosen_element,
 			 MLXSW_AFK_ELEMENT_MAX) {
 		key_info->element_to_block[element] = key_info->blocks_count;
 		mlxsw_afk_element_usage_add(&key_info->elusage, element);
@@ -266,6 +267,9 @@ static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 
 		__set_bit(block_index, chosen_blocks_bm);
 
+		bitmap_copy(picker[block_index].chosen_element,
+			    picker[block_index].element, MLXSW_AFK_ELEMENT_MAX);
+
 		err = mlxsw_afk_picker_key_info_add(mlxsw_afk, picker,
 						    block_index, key_info);
 		if (err)
-- 
2.41.0


