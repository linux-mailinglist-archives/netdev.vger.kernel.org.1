Return-Path: <netdev+bounces-37657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA87B67D1
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7DA1028217D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648121363;
	Tue,  3 Oct 2023 11:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A881219F4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:26:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCDA9B
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8+RXzDUvWeP+TEmeEN+rnvmoNkJ0usY6WV4waCbADOTxPFAVIlVEZY6hBs+1UnGdYDt/lcdTh0A+CHrzgoZA2q07VoI4Hht6x3Fuf6kB+jG8vGLNr0hnLOZ284Cc+dal6FD2UiPJXYS2WsiNY80uZQhWyD3WKz5MYA2RRBdJVFwkZNXUEHzZa9q4yTYhh7e50O0T+en3vJ87isaY3san2stJ+GnGKthk0tQC8xFOKLlTXNeT2KmCMHhdDmNRqAG9yFZTyxbcxtpb5aTAMtmcb17GFMEnwKjwB8RnaTv49gjIgOb5ysCBqYk9wAUwVCFbgsSryMS17lxjfcCuEWy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoYEqe6RfPUIqrSXHOWsWfFQRvZvxNd91p0ZS5yhqTg=;
 b=WbIemvIEtlQhnyeBU3h8TY5qs+BlOrw8EC7qgWjzGPem/fBjYZNmwO4Ovjnkee8JXyvM8xzjZFuf4y8pqr/sEwq3pwvS3QAmYgiLQY+jsotFdQY7u51HxDDvmPt9JJ1UXOzdX+RMHSDYeKTYTsTujH+5mVowk1WufgArrqxywEM9MSGj0uslHD+G/TQ+wVCbUdRYEmFHU00GrKD0CbYx9GTWhEp/wDTSmBPbOC4RELOZUR0nGNCbjHhPtFcqVG85SUSI0RvA9rPNAiHkzbD3x1NsxluZxfbElwmUREUvymi19jc+hNezRlyr1QC0jIkAmoq+IiRjst+PvnssvaG8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoYEqe6RfPUIqrSXHOWsWfFQRvZvxNd91p0ZS5yhqTg=;
 b=cT8HuDTUWs+lj+/9nw4HsDBGK/A9Ue2PufZ3Qmr+a+tL2LZKhnTGUQoyRB8l/vRKsNhn6mBFJVAL2X5oO/h540tjW1MoSZulzK9p65TYgARnuBIAgDG6EgLypBIDWx7GX66VOTl7V0v9brxG2cipsDFlQXsOfLfX/J3xl4rWeBJSdu5+0hxXk/6eTxSXX4Q6g+3Ii1gVL/Xl4i6hi+HMxo7T39RxHXA120yUeHGYO6aS1yJK5Wfo++8teoXkTo58WUd468mi+1c/9+mk7lMbCybqRCMrPoYTTyYzcM3I6W73rCPomPsIj5IUKwpMOD29v9DlcXTk5q3BzNO/oDFJbA==
Received: from SA0PR11CA0037.namprd11.prod.outlook.com (2603:10b6:806:d0::12)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Tue, 3 Oct
 2023 11:26:09 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::6a) by SA0PR11CA0037.outlook.office365.com
 (2603:10b6:806:d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 11:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:26:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 04:25:56 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 3 Oct 2023 04:25:54 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/5] mlxsw: core_acl_flex_keys: Save chosen elements in all blocks per search
Date: Tue, 3 Oct 2023 13:25:29 +0200
Message-ID: <918cc4da16bf2ad38ccc11c6041ba89377bd9107.1696330098.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c8cb5f-85f4-4e46-8781-08dbc4038abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vz/WoIKynv3FvSt4vmpc198dB7ZPdGYY71bsmIJxNS1IxE7wAUxrJTOzhyupBGtSK/RTfHRsW+GyUbdIkGanFZubpd/Xm1u65USyacDagfxNPPowtwqNrATUP+Q/ak2t4WNbSsfPYVuxcqoDdY9QlxA6dIEfG24MRFJkORi5KdPAUjYTv3UjASobKUFXG+0wERk3rwyYNH6or5wl2yRu34pocGWOFMXNNFKkLSmu7BQax32udF/vbmByWFTL5RWw42WCLgWW7Me166jTQMPQ6nGW6J+MCFCg815gUwtUKts3LuB5BuUGh6U81/tZWmAnBOkkbCEgrQdov9CMj6lDT2Ma2DUDRKQl+gr/ZQ5rG8IYvkIA5gSXZWLlvYjs7jYXZMjvnFBqNVWt5P4DGEq9TK0bgLCgZFyFg7iTIqLjG2g03b56+Ju3dfMJY8YTpCVbEmG4j7+bCstwi4jYx6wyBs/FQLR8w69tMNRAwZ0uIBAErBb3AWu+/IWDgjwRUu0nwYb4HlS+SlgS+/F3ZTls3JdhwQY6Kb0VxbfUbNov4d7sbOFaX+KTAoaYYopHDC0VbgwX7yd/kWmR6E8Bweas2U4NaSF97d7/qHNNGNww7DwRJfPXPPU/RRkvpJmr5a+B7O4F0QeXb8l8tUobiwHcFyCyWKDsF3pJI7hGMhmwqrkhD134HmJReYxr2wz2wrYO/fHvgv3evisyU9vW6iksewH018KvfbUbg7WCg00SxL00T7o05hht2L6Vpy/ywLo8/PrrGQA/o2GsGa33nV7T4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(426003)(2616005)(107886003)(356005)(110136005)(70586007)(41300700001)(86362001)(6666004)(82740400003)(54906003)(36860700001)(7636003)(16526019)(478600001)(336012)(83380400001)(26005)(47076005)(40480700001)(70206006)(4326008)(8676002)(5660300002)(316002)(36756003)(8936002)(7696005)(60793003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:26:09.3248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c8cb5f-85f4-4e46-8781-08dbc4038abf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752
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
are required. Currently, the indication of whether all elements were
found in the chosen blocks is by the structure 'key_info->elusage'. This
structure is updated when block is filled as part of
mlxsw_afk_picker_key_info_add(). A following patch will call this
function only after choosing all the blocks. Add a bitmap called
'elusage_chosen' to store which elements were chosen in the chosen blocks.
Change the condition in the loop to check elements that were chosen, not
elements that were already filled in the blocks.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 7679df860a74..c0e0493f67b2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -225,6 +225,7 @@ static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 			    struct mlxsw_afk_key_info *key_info,
 			    struct mlxsw_afk_element_usage *elusage)
 {
+	DECLARE_BITMAP(elusage_chosen, MLXSW_AFK_ELEMENT_MAX) = {0};
 	struct mlxsw_afk_picker *picker;
 	unsigned long *chosen_blocks_bm;
 	enum mlxsw_afk_element element;
@@ -270,12 +271,18 @@ static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 		bitmap_copy(picker[block_index].chosen_element,
 			    picker[block_index].element, MLXSW_AFK_ELEMENT_MAX);
 
+		bitmap_or(elusage_chosen, elusage_chosen,
+			  picker[block_index].chosen_element,
+			  MLXSW_AFK_ELEMENT_MAX);
+
 		err = mlxsw_afk_picker_key_info_add(mlxsw_afk, picker,
 						    block_index, key_info);
 		if (err)
 			goto out;
 		mlxsw_afk_picker_subtract_hits(mlxsw_afk, picker, block_index);
-	} while (!mlxsw_afk_key_info_elements_eq(key_info, elusage));
+
+	} while (!bitmap_equal(elusage_chosen, elusage->usage,
+			       MLXSW_AFK_ELEMENT_MAX));
 
 	err = 0;
 out:
-- 
2.41.0


