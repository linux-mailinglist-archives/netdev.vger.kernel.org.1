Return-Path: <netdev+bounces-29672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AA78450C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C0280E23
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA71C1D301;
	Tue, 22 Aug 2023 15:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AF1D2ED
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:06:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089DB198
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py7Il2wkNDbDMFkl+RaHdBMTbm9gHGb3O+WQUwRe4IMl4MOWtR802FXIYl1AA6n+C6R/dAPi7CI/8gx00KKXzuuLEzDaSRErMihdfXML1IZLFVAnUHoJbVGDLjdjakkauywoI2gNm2/RqosJOl7l4xb/3wrjeTjK3paiSNUn9NPKMjlIBWI4EUSPYNK5MWWCSE4hHQpK9qnF/hlDci8Su5X1EI6WrkGQDPUjLPAGb+lkPX7P2WIPBIrddAg0uveAQEXkGSVCiGpRVDnoqk2mzSRFYFCffTC4DXPmA1+lQAq+U2GJVQM53JvhRKsx6S/1KAqBgUo3x788Xk6z3L4spw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wRssR8HT5wW2oyWYRZhFlB+vgZDclYP5nc+tF/bd7A=;
 b=N8ZiDZTMpa29R2fqVF2emTYnGWjQoU4m0UZLZ8BrEqPjdqn3EHgqtqV8t0vNby4vUcXyPnbsL+VoiJfs65XunyA34X3pL1RlLYf3UfEwgVllXNDEPwGvnrsUsJlKL5sNWclu+sGRfZ4yUTdcONrBPU3cSPZgrS7F1qFzmL7uD7IPCaWjhVjuXW2jP5Xw4x4dvSTkoGXYZWuVxVmCzOxjT36cd0fjn5QnYCNumxZKOatP6R4o6xmlllDBgMbhI8xxZNs9iFw6RHjPurclSzWfaDlpqyBm3hx8djitVDODaMIOQ1YQ+kxJNI4tiqusQPpzZPJPN/MvBO0gFkTtP7oqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wRssR8HT5wW2oyWYRZhFlB+vgZDclYP5nc+tF/bd7A=;
 b=sPqiR+CYOCSwL3uLqql9AHPGF6e6yjsVcMGJ/OGnhKw95oj/0bTqT1HsGmaJmGs6ay0o1JF9YCAveR5wezAGu6y8wrRjycgzj4JmX0EqOe1SuLCIECLKPQCi7GhPcgmAA6Rpetu7IOHSofsUId6QdbJpjGMBS6tZJsbJxmcFN4an3YekokVuN3TmCDaYR5Hm1Mni20Nd69hpzYivStfQrOeQUmO7bYuMA2ALL9LKJEN3AaRP2lgVWZ6p8EDOCcmkz88NYkGlrbUo5urvieR+iaLGVCQIcY9I0YLmTJ8NX5uSSSr+ILS73zo2IqLjuxpTzSCkL6L8EissNrIPf4NAAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:06:02 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:06:02 +0000
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
Subject: [PATCH v13 13/24] net/mlx5e: Refactor ico sq polling to get budget
Date: Tue, 22 Aug 2023 15:04:14 +0000
Message-Id: <20230822150425.3390-14-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e63fda-c10d-4992-d905-08dba3214ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N++SAvcxM//UK7yrPaK1mnuDexQmGVMOiDSDbEfwqjhBfw9Zy/XP1WR3jwX7P9f4USsBAKaeqU61OwbN8ZLvXsF6HuiVqiWbH6G2gNWKNp3tohD47QJV7Hv9njZv8HrYrHWwivUgSLIxLwwES/tfHZyt/jEA5ad3+GfVFQHp1eaizONJLNVd58yhZIpe4TMH5S1gG693+jQQQ2u+iFgUnHlMFn+7hHIk1PznzmVVM+59k4Wcw/p1PIREVWERTC8LWkZBjxHoeqjbh7QaflaVFlJzG7Dx98vHumUXywDvKihZen5JFH/WHZqIc9L9PjPcnOspPdTYHGmz/OeV36VqM1hCVWUlHHAaG/LLoGYIqXw4OxgLBco8MbDgyhxZHzfbBvIinbS34JdVr7cR28AtdbZfOJW7134W8kO8glnROFCSsNgUw/xCcaWGR19pIRV87uRNCTbG9Yt45PLgmHlEmpDJPIAlJRhuK/ImW8BprUOQCPsxhoQVpwdPDEQmbwsQr6qpf7G9OkrpbLzafGyvjZpxk60pzA4YLC01/nYHn63zPdJyclrlsX61CeeBCvhu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z2jEwvhpVKuGAB24Znfle1pr/XsM0oF5bbpcYvOy4G7CalLi/beKBkQPJJ8l?=
 =?us-ascii?Q?OfW/rMZCrxeibRQwFtfpTXPoPTfcM2Sd8tYJ2XmhWEfmQ3S31iAYvmKqJ4WY?=
 =?us-ascii?Q?+raWudWvHkAKtr+ZyUQcLdu4G0oAwQ88SCjB3XwPvIJA6Ztyys5k29VZYXwS?=
 =?us-ascii?Q?rm1gvaLdMnCjrJol3rVt32JzF95cIadWwXzFCqkwCv0/rKt/z5LqdznMCXaP?=
 =?us-ascii?Q?g291uLBmnv+H3feSWwPJbzRc2/iG8FnhySf4EO7eqCwqbbmI7Yj5PsN2MCHu?=
 =?us-ascii?Q?3yVuxj+i7TemvHAw0TrWrzttc4LH+8SUsa83bWIyUSRwQU5wuaIYQqry6sAk?=
 =?us-ascii?Q?lWQZxPQk1a8VggAbMBL/rp7AuBDoOrTYid+lOZOzcQlafxnrbVAEKxHcUYks?=
 =?us-ascii?Q?hK+cgq6z2wub30egho2itAbLwyvImbJ5juv4BPocCprFPeWsxzCJZfg5y8bX?=
 =?us-ascii?Q?xsiqY0J07HH8BbDZxXHyYchHCNqWj+WGduSZVuvsQkpPGL0vhRKY1N+cTfHE?=
 =?us-ascii?Q?g+lN/gtL1mShoKTXPIEHzm1TJDEhAWuO6L2KNwpFZw5RjIhhTYeuj6Z1Y1qJ?=
 =?us-ascii?Q?IPWaLPQAdQavyEIL0JX/4wmLovPyUr0J//XQWUgIkO+7mxPSFF6Mh+SPgTxF?=
 =?us-ascii?Q?Fa/oexDVHtVfU2Aojh1XHZDfp7TpOQJ/bZX/JrWoJoJY3VHxdRFmLLPUIvvI?=
 =?us-ascii?Q?C6ZnyNXxQaxiHDjJFVwLn+RQRsdBEYe89FXxQRfqrFY/rmzjGvRQLrDOXyWL?=
 =?us-ascii?Q?t5+bsjRPQrL4GSbUAKeoQOAwT7qS0S+osi7/D9yOsreKChwmXj30+AkV/Zs+?=
 =?us-ascii?Q?mMwDoDcj5y0ZFMjcuZSsZWHZJzEREqoINIt3BBYmm7SR4Vcp/523E12B+fQa?=
 =?us-ascii?Q?RIxIV9eBcQFuq8r5ixdDpi7swrgeviWkHiCjHLecXCSfQaUtCZOB+qnHuody?=
 =?us-ascii?Q?cU/YCIG/aV70DADyCKQGvM1cKOsqcn3gNo1+GBPFsssuW3GTwGe+NbGB8qVs?=
 =?us-ascii?Q?ONjahys5W6HH8FGnJjmK3Ei3KEKzrL3t0FlBjkgTT9Sa31ACGiL+u8lqfWJF?=
 =?us-ascii?Q?evRz3cnHAJeQekPTL9fy4UPWTE9ZSY5QB7qCxrE4Ik/8QKmE2REnuw0DQkVx?=
 =?us-ascii?Q?tCDAChOrOO/tIPXxEI/I8mv3SrstVAt3em4oySKDnVYmBaDSGhQM2Cty+tv4?=
 =?us-ascii?Q?shTAaDCtTmPSt+cILxYPmJMzWcr2UXpyhvSm2NObQ2KtyLdtJ8tdVuXlXkgg?=
 =?us-ascii?Q?QdSqz/RjPMDLzxEjdFp0KYY8m7v76YlFrdOvzfMpZQmctdwCiErs4Vu6yxy/?=
 =?us-ascii?Q?G1KI7q9KMownGUwzB5+rAnOts8YKRX4NRJIsSYAPBliLaM1gEYz1zC55FxNX?=
 =?us-ascii?Q?vIkCSP7x7iV39T5IaA0zi6NtT8QHKtxJXG2k9gG3P2G+oCRsr2ibYRxSQRfz?=
 =?us-ascii?Q?Xqn6fW5/BSn809ZDUQUDIZahi7TX1aBoNO+VVl/cphe12/nbyfOq14inyb+X?=
 =?us-ascii?Q?DmsXjqKSy6FqqCGSh9xWD3LjntVleOjlJTE2yAt9h9PF9rOe7HOKVw9U77CL?=
 =?us-ascii?Q?OxfSJvlQMZQvI0UDObdUe4WEqui1y44FESz2itfG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e63fda-c10d-4992-d905-08dba3214ce8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:06:02.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUpEHAPsLqrEkr6vB0b1LCSNkIF3oYNXH4EBgAxytSKr66Ef5D7uPw/0/gFbd2HZYYKn7u7pIRXiSGSJ8iAs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Or Gerlitz <ogerlitz@nvidia.com>

The mlx5e driver uses ICO SQs for internal control operations which
are not visible to the network stack, such as UMR mapping for striding
RQ (MPWQ) and etc more cases.

The upcoming nvmeotcp offload uses ico sq for umr mapping as part of the
offload. As a pre-step for nvmeotcp ico sqs which have their own napi and
need to comply with budget, add the budget as parameter to the polling of
cqs related to ico sqs.

The polling already stops after a limit is reached, so just have the
caller to provide this limit as the budget.

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 879d698b6119..cdd7fbf218ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -62,7 +62,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3fd11b0761e0..387eab498b8f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -976,7 +976,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1051,7 +1051,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index a7d9b7cb4297..fd52311aada9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -178,8 +178,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	busy |= work_done == budget;
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.34.1


