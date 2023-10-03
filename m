Return-Path: <netdev+bounces-37658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5117B67D3
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 32500282314
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3FA21365;
	Tue,  3 Oct 2023 11:26:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64E21369
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:26:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB08E
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSajf58tDfxn9///k8qOjAbvH5/YL50PwD1FoepLBe8y4Dz78JdUGL9TOw/gCC9kbHqru4H4/trcuJjF6vWyY9ipxB+iNboKbyiYIFArN/nyppiYqpGt3iywLcYMUKmtMrwqnj30oLjibFzG/sokUCv5oLYjBVuaWksjP+aj8P7zn1I4JYJFjlDE1/Cmpha3gJHCl2bHXqvMuRpC+8j5KRDEZntqifnHXkt7ABHqStndb9U1mdr6OtFjzaghxvBRhYVKS9UI0stl1sPg96rEarAwzgRqR4/3lb8Jo6S4zmV8vDSqEJPReCijeTmlX8hXRqLhoaouqdjbLgv+gay0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fb3C0kYfhVlls6q5GctX0Hvfh8w8K8IxO9xwM8px3g=;
 b=e01OPQCXLzGi7zV/Jtw2e7dyTZIyH2pK4YyXf901C1VP6+DdpGtz3g8reaut2lr2buEs/Co9EKOzyA57gRYUdaMcX73yknqgtj46kt8SABn0R/ZRMwh86dCIfyEAsTa9HCNZQiaMXJhMPnZyHYwBD1SAb6jJxe1+Sq3HyYGanZvPzOFmmTH+gpI3kQ9wIlXcpyuBL94i6r4xpUWVhTZ6Qn0u074faIwhSuEplEmD9b/5s7brcdabwElAw+EYAcBds1W8awzdSU2v1JG+c054gXsrTcBqknYJD8puYN2iFvlS+xt2okAvjwnTBFHsAFGFlUdLyOrTlfeKazvQ32VP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fb3C0kYfhVlls6q5GctX0Hvfh8w8K8IxO9xwM8px3g=;
 b=QJc7zH/+CgpmpDWtxNhOKt5YUrKaeCUG2G2+xIEehSD/j1BviGQzFtcxal/gv0CPGVTgZEnM8wsqeH7aM6NdGS9XVgZLzB33ZpD1sLTZKuWBGtTTxsXolAyE8Fixw6+Cb87VPP2kIY/SUmZOaCdHkr90plDmzPJJHgBjQF56sFRFbITk0UueQz5TAVWYblegyQoEk44W2hd6C5xsu8mSv7Jt9WYPmrnxlSswX61V5w+Ef+krDQOg/gVkSjtjwuKQfx9gNGdQRepejE4IcZ6DMYXve033FEON6wWlGN0cZaNz1Y+NeZQ3UZE/CydrE9ZPe05yvJwr6BIX0lKki4pJAA==
Received: from SN6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:805:66::46)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 11:26:11 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::56) by SN6PR08CA0033.outlook.office365.com
 (2603:10b6:805:66::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 11:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:26:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 04:25:59 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 3 Oct 2023 04:25:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/5] mlxsw: core_acl_flex_keys: Fill blocks with high entropy first
Date: Tue, 3 Oct 2023 13:25:30 +0200
Message-ID: <a04741d96823e55e2bbba0a0be8b8745ca2a57e7.1696330098.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 13cab653-2ab9-4707-cee5-08dbc4038bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r4X3sc6R7c8Rr4VMdj7LLMxniUnsTMVcZSncfG8IuSfZ5gcbI4ShXLNgx7GirHfV4lNOpZaJEGZBxmgtLsUItE9+c3wWGUi/MjdbHFpAroo9HzncyQdq/RkDXylJMLAodln/KVFv3ksW9xCRZLCZJiKe6u63re3zcWQX0dDqCqhKRNNpEpTRyjVLq+X6gB9WWo/6BJDN+i9uk+AR0MQgawp2fWPjdVPbrxFY3C7tsGRkYlXHXxWQck7GSVjjYg1gIiXcDWNZiy6QpQ4kRNINdJoTfcTSMn38FHh2NXwcNEJBxzgekuq7aGA5V+UtF8184943Xng3jkxlDHN2iJzhDNUB0kN0eSFKpliP0pBXbmZKr67aC8iUWJkd2Jg3RashHrWXHFKDqEA9zyVOj2D3RMnK1NMJ+y/BZMDAN7339PdliNNBqkrqkLHKKZob99gOZCC1zJuKqm/+lPg+GiK0FesIHWpfIIPgtVNY9fAC8IR64110/liupYPQDn9+k4gjFE8kf3YeOVssqRfKTU35nBbt4rM1dfA455r/gyhHFgPGroWQYrjMnZj2LyTROhpUcdFsENU6btVbURJcFC4JUfFRYhh64u2NMjuLILGx3ug6hYyASmKWlPtqqCA9XFp6uFGF+Sx2Z3dozJaMN0n6W3Zh5unvKJsIf4B0A3VV6TTnlkaDYaHkg2TfwrQFAjlEU79Ih3YrcIiEaC2Rja4tbymUUIJ5KbN8+MVQ95Gta4OQCy0j4MbaoedBkNsBvthY
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(36840700001)(40470700004)(46966006)(6666004)(7696005)(478600001)(426003)(83380400001)(336012)(2616005)(16526019)(26005)(107886003)(2906002)(41300700001)(70586007)(70206006)(54906003)(316002)(110136005)(5660300002)(8676002)(8936002)(4326008)(36756003)(36860700001)(47076005)(86362001)(82740400003)(7636003)(356005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:26:11.3033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cab653-2ab9-4707-cee5-08dbc4038bef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Amit Cohen <amcohen@nvidia.com>

The previous patches prepared the code to allow separating between
choosing blocks and filling blocks.

Do not add blocks as part of the loop that chooses them. When all the
required blocks are set in the bitmap 'chosen_blocks_bm', start filling
blocks. Iterate over the bitmap twice - first add only blocks that are
marked with 'high_entropy' flag. Then, fill the rest of the blocks.

The idea is to place key blocks with high entropy in blocks 0 to 5. See
more details in previous patches.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/core_acl_flex_keys.c       | 37 ++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index c0e0493f67b2..0d5e6f9b466e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -221,6 +221,36 @@ static int mlxsw_afk_picker_key_info_add(struct mlxsw_afk *mlxsw_afk,
 	return 0;
 }
 
+static int mlxsw_afk_keys_fill(struct mlxsw_afk *mlxsw_afk,
+			       unsigned long *chosen_blocks_bm,
+			       struct mlxsw_afk_picker *picker,
+			       struct mlxsw_afk_key_info *key_info)
+{
+	int i, err;
+
+	/* First fill only key blocks with high_entropy. */
+	for_each_set_bit(i, chosen_blocks_bm, mlxsw_afk->blocks_count) {
+		if (!mlxsw_afk->blocks[i].high_entropy)
+			continue;
+
+		err = mlxsw_afk_picker_key_info_add(mlxsw_afk, picker, i,
+						    key_info);
+		if (err)
+			return err;
+		__clear_bit(i, chosen_blocks_bm);
+	}
+
+	/* Fill the rest of key blocks. */
+	for_each_set_bit(i, chosen_blocks_bm, mlxsw_afk->blocks_count) {
+		err = mlxsw_afk_picker_key_info_add(mlxsw_afk, picker, i,
+						    key_info);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 			    struct mlxsw_afk_key_info *key_info,
 			    struct mlxsw_afk_element_usage *elusage)
@@ -275,16 +305,13 @@ static int mlxsw_afk_picker(struct mlxsw_afk *mlxsw_afk,
 			  picker[block_index].chosen_element,
 			  MLXSW_AFK_ELEMENT_MAX);
 
-		err = mlxsw_afk_picker_key_info_add(mlxsw_afk, picker,
-						    block_index, key_info);
-		if (err)
-			goto out;
 		mlxsw_afk_picker_subtract_hits(mlxsw_afk, picker, block_index);
 
 	} while (!bitmap_equal(elusage_chosen, elusage->usage,
 			       MLXSW_AFK_ELEMENT_MAX));
 
-	err = 0;
+	err = mlxsw_afk_keys_fill(mlxsw_afk, chosen_blocks_bm, picker,
+				  key_info);
 out:
 	bitmap_free(chosen_blocks_bm);
 err_bitmap_alloc:
-- 
2.41.0


