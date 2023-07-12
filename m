Return-Path: <netdev+bounces-17246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958D750E53
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040AC281095
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B314F6D;
	Wed, 12 Jul 2023 16:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22021508
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:19:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5AF211E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWJlYBjyhkgFEX40AiDK3j04isoqJali8m6rE3uZvup3O+XVF7ZpoTuzMuPYUXq1JSeZec9kow792k7VBjYqsdf/q+qqztFPae0p+/S03RFOvm0eqJspwV4+dqXVEMhEaZ+f+yye+rEloupSJ3g8xEQzLjQsHmh392hl8v00iOFuNjVxA+4Z7LIXuYrlK+F682FJ8qIRTqFph2bn9NqcLeC4YLWlTNbcfIbx9aCuZgoJRA4+9TxCCTRNeXWYNBreF5t5JHTgJ3ZBaEY0lHDEBX4vEOTJZ8Ajrpe5JVGaU52ugySgvRLcc59OaektHt3fs/BhNHC94d7yhwe8YjOuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukGyWnvrkYkgDK+/vOE1fE2hg2Jvy3nC0ELoNTWWmlw=;
 b=cOmNBzz48P/a66Qxl6MPtK3yCIqzHl3B7g+8F4PT6M71yNAoQRByEPdzdogQpw/aY0mRNVDfaYJwuqcfFn2IW9C/xGYV0H2lpy3nf3y1snGKkbA7MxRjQP7E43EcslbjP5Or79cnmH+zQDc0FKOkOyvNPj0ibHlxTMHi4omUY/QlrGIvJ3dxsSnT6qWUx5qYkNDh+P/v6bo4oS7Kxx5zo2CNJMh/f3r2nP78gcmHONGYV3g+HXJXocyTvUu8mYR8VwgvztSAapmT7cSXXK2B4oKM1heKEVGteeqcXSRS7x0vJYjlOEDu8Wr4Uxun+dQ5LhPKzpWDHO85fAhvJC13Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukGyWnvrkYkgDK+/vOE1fE2hg2Jvy3nC0ELoNTWWmlw=;
 b=eXrCeFvPa9rJMPPLHVcNL+rcvllnEDdnpEFCpLyvLD/riRR+nbO/VhEQBP6OJ7b9HQhMLqbHfGWjRXZGm/syfLTjwV+1TF++O/xZAj5jJp3CAA/9FDfqp/tU0Rl0XiOtmp2/XyNKAa8/Hg74Zo7L1BOuoK9mLSlJ708Q9idpzPrmzkNN7UqTWpxPJsLQ2PSu7eBHiMWa2oWPMn9cDQsH/MI/PjhIpDsY0Jqv+5l8JnCx9cvxDGSZa/lJkii2i6UaCdhLKaHmT0+jIhuOKG+/PZNAfddbMVmxTCf3zK/jjzQsOBih/HDe1hYL/dVOsngLp7qNUnW8cRjb3XXZqIProA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 16:18:04 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:18:04 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v12 17/26] net/mlx5e: Refactor doorbell function to allow avoiding a completion
Date: Wed, 12 Jul 2023 16:15:04 +0000
Message-Id: <20230712161513.134860-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 977ba878-d729-4f3e-ce13-08db82f39225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eJ9qYNOAsL0my03yfAEg527msYTWXJNUdQtHAn1v3OITOIVrjaBoYXJOfXD11OwGtQPCcKFxvobC5GQibdWeefwJhLBSbGGls0IF1jWoiRbh+WlJmnQ0xP1Mn5GAJcIGkgJvTn4Lu2K+dH/xSZPFghkFrcUukKSKtRviSx9R9GFYZY616GmJKvy0qrx9K/iXQw7e4o21PXZn+sqFQ7oSgV+452w6fx8S5U1+0LKT4YeZs40gRAKJBHq5rLIhaVjGZnvdXLOk6kGOf3pNN1alKiZPJ0+3v/BI/uoLk6tB0T7dhzt/zYXFW9rapKjXVZOp6c9MCsftAg39soBa+1l49fSQ7bia6A7VQpZ8ZwHRvJUCzyzyT+gLfeIbQeAzod1fSTGgQzSJDZeemdJP3aDtys2GL8qx7PHsn5Wf1ctc4jrhl1q3F8oKnhKR8PS4qk4k9uQZZfLorUWoi/UzSoFDMTvFoz7va/D+R3Sbio8QPF0Kp7NEzoql8HpP9/VeyyHjaBnp+kH5jDMGUcislsL+F1Jokx8rQTdV3P92BrbQdvVmCKI1PGbxJljFkUklncWb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(4326008)(66556008)(66946007)(66476007)(6512007)(38100700002)(107886003)(86362001)(186003)(26005)(6506007)(1076003)(2616005)(83380400001)(36756003)(478600001)(6486002)(41300700001)(5660300002)(8676002)(8936002)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ki3Kbs8rmEiz1PWpytdO8g9QNiGQPhUZzRwbS9RIOwEnTloTO9nTOTm7c2L6?=
 =?us-ascii?Q?2ZSRrQpfBPNCBewwH3l2Xay+3EUKeaqGnE8mTvcR9P8E5qnn/mU+Cnta45aM?=
 =?us-ascii?Q?dkFohCcM/y2231UNfTO4OeO4Qq1Lg6AfKbPIVLx7dhOFxIc2ou31tQ35CbGi?=
 =?us-ascii?Q?m42LHJHAuHR/73GSTlGFhpmwoZP6gDG89Es5fbH4q6btcZlr9ODahjNm5fsq?=
 =?us-ascii?Q?mFMhXxMuX21acZERAsLwxjYxNlehMRwx+KF9vJ5q4rjOi1GxKND6YXjPDjr1?=
 =?us-ascii?Q?f6PYv83C8c0QhKbaY5JenjUyvwE+cLMgyVQSp9spc084TuDn09TLukwKfmdO?=
 =?us-ascii?Q?cm1O17WTsmmgiFTQOm5uvQLy9AoGVN0VXuKtIR/8ju7+P+yju0Fj7PCQpUGg?=
 =?us-ascii?Q?Sl8IYxTGj7FgqgIEgjgoIn5OSkVZ5LekF38vmRgoW/czmqiAbLTKyfB3/Nhz?=
 =?us-ascii?Q?XcT5VznqDIshVV1o2okzGHesWk20wgXGZNt+YjCckRAt9cBt3YWiI1ju1am1?=
 =?us-ascii?Q?YBHGEZJlzJniGyTSpup+1gfS0GO1eRmpv95rKQj+4kKE6rZjWjNar8pABW+v?=
 =?us-ascii?Q?FzWsjmDKMfhuht4Kl06bEHh0PNR4N3e+vZIBKEA5H+8dbuBR4AaRQze+pDgD?=
 =?us-ascii?Q?Hc9FelBjwBALKK5O9Qy0dDOJfw3EXNmK+n4wRBFI21pnTdYq2vbjTkZrXiQG?=
 =?us-ascii?Q?FfSeQzhatieeXPACiS/pMKq8B2OEgOM42KGe0FTICm3hXKP7mKDDBhofwai7?=
 =?us-ascii?Q?d9/nv53q9Ajq84jrkRBMntC5sGd69MDfd2+BW//SBuBqLzhPWfBXg2oMkrRd?=
 =?us-ascii?Q?LdxbCAl424mzCWxTO+wkCywV3MEYdhU0vyMGsWy8wV/OSa/zAgF5cRR0Af1t?=
 =?us-ascii?Q?b7ZgsAGyrkz4cgKsrTjFJHa+DxNMOdnMMTpVI+FXv6tPlSs84WDuS5qsz5Io?=
 =?us-ascii?Q?sHI39mO7V4v0lThyxWdvI44RzxwvMvWScneBWKPBhM75DSMohZcCxqSwj3Mc?=
 =?us-ascii?Q?qR5ckY6nC6zlL8/TY3VznwTP5erAKIsV2k7Dce6PPpRRGHzu3iHSphAhdlQW?=
 =?us-ascii?Q?fOKZ061luQ5ahh8pwdp1x842OKsjT6yuXkqWJOWBt0iES6iC8PlY7RAGHBjY?=
 =?us-ascii?Q?enm0YfCXfj9HH+zWRlMr6GMMcNLt4zowttbSrMpnlm9YlfJ57/P7DF1PMg03?=
 =?us-ascii?Q?q9kr4RB3jnord2QagovelTbbMBb3KqFPswpWkmCwJ3nS45BSUGizIXsZ3bfL?=
 =?us-ascii?Q?W7w2YtgYVLo4EWSxaVZAbIeSTjlTTBTCW2qSTo97Q9gNFUWkV6EsPtk0pR+l?=
 =?us-ascii?Q?lTP+WSxE/wxnetDknOicWjGUeCuh2xRIGdhK8ljLupDNUZWERvKUXwQ1/oxV?=
 =?us-ascii?Q?0D0NPmCKm3Q+cjN2I0SfWhotRs96LtOoElD99KkckNQZxTK+fSH5wfUB8rFJ?=
 =?us-ascii?Q?US2IQxSqR3R0NjRdbi+DbaulPzLwlxCQKwsd6kK3qaT5Tz8CG0SuolPXLiZy?=
 =?us-ascii?Q?5QF0EUw7ZNq920iPqdnH+yIXVrSHWqci+M7c34WMTG52LsDfjEFjCRMPE0Zd?=
 =?us-ascii?Q?i5TLoGMAVxIICdYSxn6Pz6eWlRS4fWE9jHK1VBCp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977ba878-d729-4f3e-ce13-08db82f39225
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:18:04.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaHy8ODnUaHAwoeiBUHKF70ucphWaYt9kuSDRZjpm0dI9Pc2grF+YMXAePZj6HsIRbnDt6QHjFbExMNJW378Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Or Gerlitz <ogerlitz@nvidia.com>

Currently the doorbell function always asks for completion to be generated.

Refactor things such that all existing call sites are untouched and no
branching is added. This is done using inner function which can be invoked
directly in cases completion is not desired (as done in downstream patch).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index cdd7fbf218ae..3807536932e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -256,10 +256,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -273,6 +273,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
-- 
2.34.1


