Return-Path: <netdev+bounces-37655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579EE7B67CF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DAEBF1C209DA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C61219FB;
	Tue,  3 Oct 2023 11:26:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A521352
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:26:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012AAC
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABST8MEbH02MHLLcY8MSkswic30Vdax53Zay1PWf7/DgPy9LLqTyaOpqeA5TOOpnQ+tE+EQ7LwUnidnLaE6RrwLSjr7gfgFaOytGx96bUfdLkW5A9HE/qg+dJf1Bl+1Ks4S85afIDSfKtyrBLrWTbGGpV9dai7xvotnqgDMqhsSBZSfjQS/DB/C1hojIi1epLUtQhtLkmf95NnBg0LOtRPenxXuDNpeyIGX5fx4wtfFNT98dbD4r8mf7s8OA3GHfsZrGxXoS8yPv5Af41pvC+PWG4uajrvv/M9TXpCz/lgsFLIbZkD18dJ+R+i3LdZOWWxGehbNQLCnz66wesE358A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwkxeg5lmz3PowmoapNWdScvBdop7AcSWOXm4UXsLdU=;
 b=IpGh6UsHz4dMcdvK8ei2w30TlnhDCYOseOkY3jAZmjfBRLV1FLlJGky1f+ICfghkZOEyz0XhJorT6+kCT6gYwtmU86c4DXfEjLA56O4BnC2CoA6HxkS2CA8sqsm8KTrrQ4WxYPS6sNDYldqRZBneuyTAVBacf9qhztSFpsC7plqyvbmjwa5Q12xYh8+Bi/H6PhUGhzoNYnyGvbuU6g96qNWTmctkoNx5yLf2P9jblO36rq3WtfQ2QN1nCCzLXTwvCwVbWBu9NBRqzABBI5R/CoVRm6Dnmj6vLMrnimjg8arEgkq9IJI7kTihbsGIWeuPQCBJ8uOPadQc3PgePsIrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwkxeg5lmz3PowmoapNWdScvBdop7AcSWOXm4UXsLdU=;
 b=seg5aGsa/M0l2NSCMmxjapWWfM/auCAgcCGyDGUyG/L0GGreVQF9ZU8TgcmYjp/poCpEfiDkCydX0HU3HQ3rlTBAlQQVHuOjytznhMlp/Vr8DzJTYaBZ13x1RZEaqY4zkvbsJaeBZre2wq6Tl/47pUzMD4A6QRiVAlcGuBTzlj1HBPYXi/KuxhJEVDEZKgBQEJdOyqnhMUE0vz351yOeS8sgUuAXIyxSXQrTyIRPB18ER3RxQzHPyoPoeHdg05bZjmSBBEwY8CSG1O6aRBZ0enlRL3N5NeZTFS4XEGYxhedKDLfQ6quHowAgf1Hi+E+dGSW+vP5akJWofS0VyiRwJw==
Received: from SN6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:805:66::36)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Tue, 3 Oct
 2023 11:26:05 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::49) by SN6PR08CA0023.outlook.office365.com
 (2603:10b6:805:66::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 11:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:26:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 04:25:51 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 3 Oct 2023 04:25:49 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/5] mlxsw: core_acl_flex_keys: Add a bitmap to save which blocks are chosen
Date: Tue, 3 Oct 2023 13:25:27 +0200
Message-ID: <8f118572e0f2fe4f800303977bcc4c6606c78642.1696330098.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: ec72f841-1442-4d95-8a54-08dbc403879d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pF8UjiX2jBc6KkzjUtIs7sHZ3f+MTGF6grsQZy22u0ZGRL0R7XtaiGnUu/Iau4gLp9ywFhtTYXMfSxxt1fqARkWXtjPbXngZXiyfU/pZP3w1I1F/YZCI7cP4tILQhGVio9gu4nwvFkCcv21csRVw9+DsPrJZaRLF6H3WAvgCmeptwyHxToRTrySRksz2y3FtxkEtcLjlDnMWl7eGNb1VLaqbSewqA/GeU7tp6o2tYezlxdbQjydPw9U8Fh7g7kKrcx6pjvBOH+0JmiHBkp67b0ltf52ZWp11jWGj943hoTmSjMZwRP80GCBimO8a67xRt9mObeInVWaAB62lfRw6jZN27mOR889BxX2lsxacr3L6aai4QV7ljjn1WMFZ63Vo6WtqAgbA33cuzGZMUc9hy1uf1x0BJIASOPla0wHxBvkSyJVzspwZW2Flmb7toDg/dalvxi32YO+kI54afBr2sSlRJAQUBwEFh0IgXFw4gQByT5vDCynJQnh15etDfcw1vD0LeU0r9yOxClkf0HMaE1vUZ/twfUU65OpfbmAAOfUrPkyrgpXoWUy1eo2ArNievFq6AzuVIoI1rAZsdd2XiZzV5Q0Ptafl/VZS0Jxt5MgqnFT/4HIFUZnJUTfymc2yMUu2e6ZcppUz/6ubbq836BDPhwC8dfzinX0nGxAmzVOw0iWVacN7zu5jVQle8iZSuNuk4fCqthn1RcPEWqWL3nNQ2mH5kWhyDSkXAlM49qHg4NDkQ2yY6CdSBGcph+3L
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(7696005)(478600001)(6666004)(107886003)(7636003)(47076005)(356005)(86362001)(82740400003)(41300700001)(426003)(16526019)(336012)(83380400001)(110136005)(2616005)(26005)(36860700001)(36756003)(2906002)(70206006)(54906003)(70586007)(5660300002)(8676002)(316002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:26:04.0845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec72f841-1442-4d95-8a54-08dbc403879d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
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
are required. The indexes of the chosen blocks should be saved, so then
the relevant blocks will be filled at the end of search.

Allocate a bitmap for chosen blocks, when a block is found with most
hits, set the relevant bit in the bitmap. This bitmap will be used in a
following patch.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 745438d8ae10..e0b4834700dd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -225,6 +225,7 @@ static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 			    struct mlxsw_afk_element_usage *elusage)
 {
 	struct mlxsw_afk_picker *picker;
+	unsigned long *chosen_blocks_bm;
 	enum mlxsw_afk_element element;
 	int err;
 
@@ -232,6 +233,12 @@ static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 	if (!picker)
 		return -ENOMEM;
 
+	chosen_blocks_bm = bitmap_zalloc(mlxsw_afk->blocks_count, GFP_KERNEL);
+	if (!chosen_blocks_bm) {
+		err = -ENOMEM;
+		goto err_bitmap_alloc;
+	}
+
 	/* Since the same elements could be present in multiple blocks,
 	 * we must find out optimal block list in order to make the
 	 * block count as low as possible.
@@ -256,6 +263,9 @@ static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 			err = block_index;
 			goto out;
 		}
+
+		__set_bit(block_index, chosen_blocks_bm);
+
 		err = mlxsw_afk_picker_key_info_add(mlxsw_afk, picker,
 						    block_index, key_info);
 		if (err)
@@ -265,6 +275,8 @@ static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 
 	err = 0;
 out:
+	bitmap_free(chosen_blocks_bm);
+err_bitmap_alloc:
 	kfree(picker);
 	return err;
 }
-- 
2.41.0


