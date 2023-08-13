Return-Path: <netdev+bounces-27178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D777AA23
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084331C20370
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC7E8C19;
	Sun, 13 Aug 2023 16:49:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4296FB6
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:49:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDB5129
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 09:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRlMS3mAbB+HzyOKapd1513r49KAsZtlqqH/cvMiUWKNKFIwAQhXnvvk7+/aLFEiiTRA74sNg3zabvdvESinO+NKty4sqUbhXJMNEWRndAnfyUaIiomejEyXvPbYP3myd4e46yYgyVwY+usmWP348UIpTCpN/Q3+Y5ZLmnZa4lr/lW4NLtz4uHTwcVsNW7EbY1jVEXe4lR9JPxMPBWLesfbxqZsEb6XtDuJy9R2tWdp8FbravYcpvYXRcs3CDs/RaJFr8arGmmASIQLvy87VIsJv5kN6Yaf6Idm4AUFXCmnO+kmBATq6qqwJ6aDTAUFtSPLGg0K/qgBbPwxBdEbTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo0RegdHl8+3FeFDq7X6+lWoeQG3vZ3reXPOX6GRfYA=;
 b=DeN+ITsW4N5dKTv6gVMg723VF/ubJG1l5WMidZTG9f+hRypCE14Ijc7spuhSv+H7YXdSRjujB3jPpXj3BDMhLa0unp34IGsTwgXPbxeErTn1koOBz+wfyzJGtfdIM3PyJoJ8Nf2kaNM0qkY8+CaX3uOB0RX8wTvryEoQAktg84eR6+1XEv7xKeMv95TOWHyG2/9b4PAy7+XMBvteGoYHp9TX1D7lSXi+SXFFnH9P7VwxYsIOCfu0O08k+286NoR2JDSolTiQOFGjC8divalP7C3SMS0e0t5qO8AKRvmCmS3JmaBRZfGG+Cx/LG3CyF7MZZo6Gdb/fXo07zhcv95y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo0RegdHl8+3FeFDq7X6+lWoeQG3vZ3reXPOX6GRfYA=;
 b=FM0kzUJPDNVxkCzO5pDshNB9XLNscds/GXTuwo9wvDTHMv1K7qx7eGAFnuZS2OCUw1gR5YXrsjGYvzZvO44Hse/ISFjA9NEtMK+wdDf2rlye219V3HDaDGGqeh7YMckBLiWpURGPtYRNBA7xBAHA5NNuYrlHdZUhUEsjOKTtF/dTuS8FgD6tQmfKPQ22q7TE7A+8MlJ/rMFI5zidUrY79fyzLBUiQ4kJR7LC4sU+JunreOblHS6jjmOSIyu8PTUveXFouU0aLmnfw7yTck3PUh8EvtdGpolY486RpEAsLtAcqBKwqNJ6l/DCU0+unUbSKITOEuq3DjORkiOJNVCdQQ==
Received: from MW4PR04CA0314.namprd04.prod.outlook.com (2603:10b6:303:82::19)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Sun, 13 Aug
 2023 16:49:36 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::41) by MW4PR04CA0314.outlook.office365.com
 (2603:10b6:303:82::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Sun, 13 Aug 2023 16:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Sun, 13 Aug 2023 16:49:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 13 Aug 2023
 09:49:27 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 13 Aug 2023 09:49:24 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/2] nexthop: Simplify nexthop bucket dump
Date: Sun, 13 Aug 2023 19:48:55 +0300
Message-ID: <20230813164856.2379822-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813164856.2379822-1-idosch@nvidia.com>
References: <20230813164856.2379822-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f77933-9256-4a57-90a9-08db9c1d473d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9zLDzTAhnxudOdtGh9J2v03LKT3ZLYzM3ZfP5p0RhBgxwhfvJkfEE6ppf7IISQlLf1XFqghAWTnqV0D6wRtGJQjuQ2h32Lx5KE+Vti9mq+4m1HmDIinxqFn8NxX2oFTHRfUDK6DAjIpLMpFff/Glv0MyFI7yKtRzwfaxBVoicqWwpzf+XHQBwCgiuEJWlJeyakMnERPeUhP0cHP5t43o2ko7tFDdRx65oqqk9F5BtqlWgPGT4OXwvdw4R5vZ1q39HI8Io0cZwa6iWrkVHGfKiYsPUxg1D5wL7a1m4FA08mVDvLOHkFh0lNyiYJUmykC4bBWMacOgyjkL9xhy5yRXlCLBfhGayHrloPDIowHMeZOqS0AmGiody0ej4XJpsNp6kZAxD+QhXS/PP2iyM6YknIx/rmTmChundR8ceKsCrS79qGaZ89neyfagkN/LgHVn+HKXGyVWTycA+iDPdU0mFpqGdjGiWuzbalnXogZoZcTWW+4sFHqsEfe12d4iW1N8wDzhzrarb4EO8UHX8bDiEteZ76lyURqbPbRfErJ3dwRLLJbcRz7s5e0GeNuRZCPOOREmFy8Mx256yxonQnBbKQsV+Bdfszr/nS+wsRenf2KebUQMxmGwdfYyqPywZZAYK4/hvlCcptw6DZkpQb7vv5dFUr2thxXVk9AD8Bd/gT1AwU+Lzn/fQXX2O6IqQyuHQINVQEmepmePjWg5tqQOTsM/n8Q1ZnzixfbebqkziRqXSk1qT2eh3qpnAo+dt/El
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(186006)(1800799006)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(66899021)(6666004)(36756003)(54906003)(82740400003)(7636003)(356005)(86362001)(47076005)(83380400001)(36860700001)(1076003)(336012)(107886003)(2906002)(40480700001)(478600001)(2616005)(426003)(16526019)(26005)(70586007)(41300700001)(40460700003)(8936002)(8676002)(5660300002)(4326008)(70206006)(316002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 16:49:36.5321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f77933-9256-4a57-90a9-08db9c1d473d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before commit f10d3d9df49d ("nexthop: Make nexthop bucket dump more
efficient"), rtm_dump_nexthop_bucket_nh() returned a non-zero return
code for each resilient nexthop group whose buckets it dumped,
regardless if it encountered an error or not.

This meant that the sentinel ('dd->ctx->nh.idx') used by the function
that walked the different nexthops could not be used as a sentinel for
the bucket dump, as otherwise buckets from the same group would be
dumped over and over again.

This was dealt with by adding another sentinel ('dd->ctx->done_nh_idx')
that was incremented by rtm_dump_nexthop_bucket_nh() after successfully
dumping all the buckets from a given group.

After the previously mentioned commit this sentinel is no longer
necessary since the function no longer returns a non-zero return code
when successfully dumping all the buckets from a given group.

Remove this sentinel and simplify the code.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/ipv4/nexthop.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 09d36bcbd7d4..7e8bb85e9dcb 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3337,7 +3337,6 @@ static int nh_valid_dump_bucket_req(const struct nlmsghdr *nlh,
 struct rtm_dump_res_bucket_ctx {
 	struct rtm_dump_nh_ctx nh;
 	u16 bucket_index;
-	u32 done_nh_idx; /* 1 + the index of the last fully processed NH. */
 };
 
 static struct rtm_dump_res_bucket_ctx *
@@ -3366,9 +3365,6 @@ static int rtm_dump_nexthop_bucket_nh(struct sk_buff *skb,
 	u16 bucket_index;
 	int err;
 
-	if (dd->ctx->nh.idx < dd->ctx->done_nh_idx)
-		return 0;
-
 	nhg = rtnl_dereference(nh->nh_grp);
 	res_table = rtnl_dereference(nhg->res_table);
 	for (bucket_index = dd->ctx->bucket_index;
@@ -3395,7 +3391,6 @@ static int rtm_dump_nexthop_bucket_nh(struct sk_buff *skb,
 			return err;
 	}
 
-	dd->ctx->done_nh_idx = dd->ctx->nh.idx + 1;
 	dd->ctx->bucket_index = 0;
 
 	return 0;
-- 
2.40.1


