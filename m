Return-Path: <netdev+bounces-17253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB64750E6A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075871C211C5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122882419C;
	Wed, 12 Jul 2023 16:20:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11321504
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:20:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B770626A3
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXbwz0Zvzex2JUnH+ZhCzCA0nqv5eLegW7g6qYiG6GI1wJD0njVbAi3jcxrRuL/QDo9rKNpkE14ofBYZhbPWYZRHDCll2IDdOEOmHEouNloJt79FXZIKOAmfRuHX8mvVjMcuoeJoHmqf5BLAU5Q5tz4ZwbEk4P3xws+xWL8ROfsjiy2iyyDSHMZ7kVvKmQ6+yeEPS/v94xjbLy9aYTOTqbPkyXr+qMod09VTL4W83PbkM81udpYsetNC3Jl82Hxwtu9U/AQSXKWLJq69nWx3fWe+IUZxClkZ/ZpmjkVmPowfAfio9+C03MiCQ0lya6tyx9YnPIbM+2B74Y5BGCNA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yEhJdrUOQCZQqY/tXuA0RX1CAHRBEARxxql8hKgOKE=;
 b=YikkGysa2rH9EzB+vqwPpTBFcOOqUqzXnJu1CHs4neTwqN4Xcm+kO6/3WWrLmZWkct1Hfx9mw5lJPATqpw2u839A3GShEEuz8X8KPiqIh1T2kHLFXbOYZtLXjrOHQGh1YzPICHfn4o8naBBTNfEKardrkgSZ6u5q/djxJekNo/9FzBCTaJeezPtj2vztnvRAKLqczsqfl0/qq9LiGB1hxuuTnvhHn1tNl0BfWzZc6swX+/pRwP14J5D87KbbXEBA2a3sRG4jhWdnsJowNsYM0SO/0HUPQTlzqadhiFyJEFIPWh/LWuDP7MDtfLO4dYCakcLFP67zMAqKlFgNueqHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yEhJdrUOQCZQqY/tXuA0RX1CAHRBEARxxql8hKgOKE=;
 b=gTd/Ta1+cq1UmHwesgqMezMG6/vwAp1L14ecONNz6vqILpiB128DnMO6KQLyCpdnDVf3nst/MKRInMp/nzgZjBU4kNnzcvw7XUpLXIt1LBp0IG2pAu++thmRhaL9EmoCre1l72LbO/isfm9kOCw6NNYwA6Eg6YwDD46mAeU1Mc5Rc6wvQ/KTTRKUAlzfvSlnYltFGfKJV2TAAXyfA8S1LqQYn+nnivdgyoVoT3zmlFrlGXSkTZIHckYeZhuJCW94PhNG9arrX2+PaxTIkw24AxTyMAeGDPuTkhsI2OG2leB7BacoS/p9zRJ+YhVC8cajoTBPEUAcVH5GeKKPCOZdww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 16:18:53 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:18:53 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v12 26/26] net/mlx5e: NVMEoTCP, statistics
Date: Wed, 12 Jul 2023 16:15:13 +0000
Message-Id: <20230712161513.134860-27-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 362914b6-c44b-4ad0-086a-08db82f3af71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8UBGTkQirlt6PajrtyAF+Q+0FNri23DnJvdzJ/cJ6xUBMvDWa3xzjb5hVYsJVtKImdekoSfC7YrzwIzNKmt6B5MXt4EmYWZGF540MF5bjvsUGgwZtPav66zu8fQae9U7Trncb4wlO6btjGNrozkvS+lJ2i5cyA80MQr2NpdBUzDZTgJxkQo6Ew/aoiq8wq364kn7seuCF3HSKF3IduUc98N/i5cNVH3/BgOShjXvna7FchYAI/bXMWHxuHzhJR5I4MPgJZhfua6hmlCLOKEFSLJkB9lQF2cO+0j5tWeNWbFiuYuD97sRgI1Nq+jp/7tXuL9Itq723a2qGNdRs1mVDW9fu0pxiblCZ790LLNZej0oeokdJE8Hx8xLM/E82Lq7UY0YE53iAtRsJ3UBqCsFtpphCyr5kUs5A+MNcoTgSNh3Mt0vJx1lx1KAc0+QrxxS+AXvHO6qD8BA1fumiGwH4qM5mg7x/uIIs+YM0tnQGz6lWN7Ti/vlX8Kv5ihiRzE6riAuOft3iFrPzWDxEbxM79MzaFtahVuhnywtXKylMBCeRdQs/2+gbJ0mWBOYjGOG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(4326008)(66556008)(66946007)(66476007)(6512007)(38100700002)(107886003)(86362001)(186003)(26005)(6506007)(1076003)(2616005)(83380400001)(36756003)(478600001)(6486002)(6666004)(41300700001)(5660300002)(8676002)(8936002)(30864003)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SypwXcrAx7nRalnIizAZBuU7kLz/YxeIDJsIdNFpCQ8NuGDj4XgSRDtKTuy/?=
 =?us-ascii?Q?kRnnrXCYOWZGpB3Ezsq+16FN3MyNFFczKmuAiO4c4/YXwize9iu4DWBm6RXy?=
 =?us-ascii?Q?Z1njoBx3/lmqdNpMH+/7b52l7P6iJQ6tdBSohsWQHbSB1RryxWuUjyew2Lhv?=
 =?us-ascii?Q?+LZPnITtSUa1GsC14FbUqVMG0eWQYd289F4nfK5qmDhEWYvQeAF/vQpZFVRm?=
 =?us-ascii?Q?prY3PW+u0/NGYJQjwFrSs/3iekQ1FfXe/bD/UJ5jVg4vfh0OoCjB3UEzrAvk?=
 =?us-ascii?Q?w7/bZ4rlV4c70cQUoFB8y5QSPJVp9xmYgrlJOwH2FkubBxt9Rwlb+movQlmI?=
 =?us-ascii?Q?e5tkKPk9sC4C4giXzzaVI+M51neW+0Sm3EfNGQEr3eLNRAkx2QMEedcC6loJ?=
 =?us-ascii?Q?jjTxD+HB4ANCoaq3kjF9eM4yKXkEPtr4/ZRpb3iOGDFMPxnELgvNw0DNjSl/?=
 =?us-ascii?Q?UuRmXNyG6vabKDzAIDbUIFTknJ5D1WXnbxmo0ydmbzQZC6XQIcX+V/VWpeia?=
 =?us-ascii?Q?Dmc4NiqT4Xn2lK9SI3sZAuU1Z7r0XARP59o/ph3Ybn0sk/wvSxrJtmHD6ADA?=
 =?us-ascii?Q?cVko33k+pzMxxvNK7OqlsSrKJv49MidiRo/vQ7L8vdnh1WxV8pcxHTZe6rKQ?=
 =?us-ascii?Q?asPvlkeSgWrmtZmGJVKdSvWL47pr9wDUS+Z8BkeO1O6JR6+dngm3v7UT2AkN?=
 =?us-ascii?Q?1mqZlm1gK1v3WubWMLcK5PV9tM7FMU4Mql4MKiYsFLbnC/AGwBrpGxDAa7sc?=
 =?us-ascii?Q?dTnreXVHD3T+vW7aqLmgbBgJqwiXuZO6hXOjUHOaJGv8ypyUQd92HTDLJ8fh?=
 =?us-ascii?Q?UTzlqUbRRkzOjzKcrCowaIl7dOey10kxvLU9cCwWKa1gy93ymUesZnKSp6Yn?=
 =?us-ascii?Q?oztrdaBIyHYeP3JMOrNvwEYDDNRWaCk1kdCILDjBGEx6ZwNRezkmtso79vAt?=
 =?us-ascii?Q?Lt7v7gByKdlp6/2xnM6NXsWIG1zDktikt7jWrIuX2PjfbYNPNhJwYYoOwuD/?=
 =?us-ascii?Q?bQPlsVC4tbFyycnyTsoD0s63L/SeeMl7U++jMb8X/PlK8p/uJWz1V5sAFvKs?=
 =?us-ascii?Q?DZDnApzBEwOcRsOZCk5iqCfYgCUALHIXpwqlbdSqIKx0l4DOOEqWnD247TCD?=
 =?us-ascii?Q?wJQhsd3WMKrNJlo6yE2oo1k8yx1N4+aNhdgY2XrpLJn0VfBUbDa2IuBsZ5ju?=
 =?us-ascii?Q?pO5KtYkpotWpjA63sBWp+r3+8szV/6cwIqxx/pBzZnY/JMOjtl2EFwzx8JjI?=
 =?us-ascii?Q?KZmBoEeGQdGvHmvKuvOfaozs/EkQqGgfF1lR+Gwgy00Ecg5GPJdzvDi4ycvJ?=
 =?us-ascii?Q?skEaDoDU8hemnGygz2rs6Fejuvo4oEDBVsF7avooGAF+QiaDZdlxDkCvpP1o?=
 =?us-ascii?Q?bl+z4nFEhJt7RP41RtVXEad3WaaD272dW9krkfU9XoX5uKs0zA2FEOeJU3g3?=
 =?us-ascii?Q?a3OKMRn60KV7OaiXKa9/qEqDGMWaZJo2sJF76tHJD6Do/TvaGZWQ5AeEcjjg?=
 =?us-ascii?Q?mvDW1p7AIag24JnKZSuOX31AAUngYbHGSWqVXbXHOunJJ7S8KNNzW1JC5Ym1?=
 =?us-ascii?Q?CFNVKupR3sgU64G5731oUsPalGcW7Zqd5186CFUV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362914b6-c44b-4ad0-086a-08db82f3af71
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:18:53.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YACFMiEOVoKDZBRysrikGv1ZZtanZxCPbKMtr71MPKhh/Z/Sg79MNYtkIFTc0YLhWnZK5hQNhQuci+7vUHjhXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

NVMEoTCP offload statistics include both control and data path
statistic: counters for the netdev ddp ops, offloaded packets/bytes,
resync and dropped packets.

Expose the statistics using ulp_ddp_ops->get_stats()
instead of the regular statistics flow.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  3 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 53 ++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 16 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 11 +++-
 .../mlx5/core/en_accel/nvmeotcp_stats.c       | 66 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  7 ++
 6 files changed, 145 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 95001ee1503b..884c16276f07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -105,7 +105,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o \
+					en_accel/nvmeotcp_rxtx.o en_accel/nvmeotcp_stats.o
 
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index c5bfc1578ddf..86637269c76d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include <linux/nvme-tcp.h>
+#include <linux/ethtool.h>
 #include "en_accel/nvmeotcp.h"
 #include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
@@ -615,9 +616,15 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 {
 	struct nvme_tcp_ddp_config *config = &tconfig->nvmeotcp;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_nvmeotcp_queue *queue;
 	int queue_id, err;
+	u32 channel_ix;
+
+	channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
+						      config->io_cpu);
+	sw_stats = &priv->nvmeotcp->sw_stats;
 
 	if (tconfig->type != ULP_DDP_NVME) {
 		err = -EOPNOTSUPP;
@@ -644,11 +651,11 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	queue->id = queue_id;
 	queue->dgst = config->dgst;
 	queue->pda = config->cpda;
-	queue->channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
-							     config->io_cpu);
+	queue->channel_ix = channel_ix;
 	queue->size = config->queue_size;
 	queue->max_klms_per_wqe = MLX5E_MAX_KLM_PER_WQE(mdev);
 	queue->priv = priv;
+	queue->sw_stats = sw_stats;
 	init_completion(&queue->static_params_done);
 
 	err = mlx5e_nvmeotcp_queue_rx_init(queue, config, netdev);
@@ -660,6 +667,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	if (err)
 		goto destroy_rx;
 
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add);
 	write_lock_bh(&sk->sk_callback_lock);
 	ulp_ddp_set_ctx(sk, queue);
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -673,6 +681,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 free_queue:
 	kfree(queue);
 out:
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add_fail);
 	return err;
 }
 
@@ -686,6 +695,8 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 
 	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
 
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_sk_del);
+
 	WARN_ON(refcount_read(&queue->ref_count) != 1);
 	mlx5e_nvmeotcp_destroy_rx(priv, queue, mdev);
 
@@ -817,25 +828,34 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct ulp_ddp_io *ddp)
 {
 	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5_core_dev *mdev;
 	int i, size = 0, count = 0;
+	int ret = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	sw_stats = queue->sw_stats;
 	mdev = queue->priv->mdev;
 	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
 			   DMA_FROM_DEVICE);
 
-	if (count <= 0)
-		return -EINVAL;
+	if (count <= 0) {
+		ret = -EINVAL;
+		goto ddp_setup_fail;
+	}
 
-	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
-		return -ENOSPC;
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev))) {
+		ret = -ENOSPC;
+		goto ddp_setup_fail;
+	}
 
-	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
-		return -EOPNOTSUPP;
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu))) {
+		ret = -EOPNOTSUPP;
+		goto ddp_setup_fail;
+	}
 
 	for (i = 0; i < count; i++)
 		size += sg_dma_len(&sg[i]);
@@ -847,8 +867,13 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	nvqt->ccid_gen++;
 	nvqt->sgl_length = count;
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
-
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup);
 	return 0;
+
+ddp_setup_fail:
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl, count, DMA_FROM_DEVICE);
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup_fail);
+	return ret;
 }
 
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
@@ -895,6 +920,7 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 	q_entry->queue = queue;
 
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_ddp_teardown);
 }
 
 static void
@@ -928,6 +954,14 @@ void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue)
 	}
 }
 
+static int mlx5e_ulp_ddp_get_stats(struct net_device *dev,
+				   struct ethtool_ulp_ddp_stats *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_nvmeotcp_get_stats(priv, stats);
+}
+
 int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -1016,6 +1050,7 @@ const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
 	.teardown = mlx5e_nvmeotcp_ddp_teardown,
 	.resync = mlx5e_nvmeotcp_ddp_resync,
 	.set_caps = mlx5e_ulp_ddp_set_caps,
+	.get_stats = mlx5e_ulp_ddp_get_stats,
 };
 
 void mlx5e_nvmeotcp_build_netdev(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index a5cfd9e31be7..f2a7f3cc945d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -9,6 +9,15 @@
 #include "en.h"
 #include "en/params.h"
 
+struct mlx5e_nvmeotcp_sw_stats {
+	atomic64_t rx_nvmeotcp_sk_add;
+	atomic64_t rx_nvmeotcp_sk_add_fail;
+	atomic64_t rx_nvmeotcp_sk_del;
+	atomic64_t rx_nvmeotcp_ddp_setup;
+	atomic64_t rx_nvmeotcp_ddp_setup_fail;
+	atomic64_t rx_nvmeotcp_ddp_teardown;
+};
+
 struct mlx5e_nvmeotcp_queue_entry {
 	struct mlx5e_nvmeotcp_queue *queue;
 	u32 sgl_length;
@@ -52,6 +61,7 @@ struct mlx5e_nvmeotcp_queue_handler {
  *	@sk: The socket used by the NVMe-TCP queue
  *	@crc_rx: CRC Rx offload indication for this queue
  *	@priv: mlx5e netdev priv
+ *	@sw_stats: Global software statistics for nvmeotcp offload
  *	@static_params_done: Async completion structure for the initial umr mapping
  *	synchronization
  *	@sq_lock: Spin lock for the icosq
@@ -88,6 +98,7 @@ struct mlx5e_nvmeotcp_queue {
 	u8 crc_rx:1;
 	/* for ddp invalidate flow */
 	struct mlx5e_priv *priv;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	/* end of data-path section */
 
 	struct completion static_params_done;
@@ -97,6 +108,7 @@ struct mlx5e_nvmeotcp_queue {
 };
 
 struct mlx5e_nvmeotcp {
+	struct mlx5e_nvmeotcp_sw_stats sw_stats;
 	struct ida queue_ids;
 	struct rhashtable queue_hash;
 	bool enabled;
@@ -113,6 +125,7 @@ void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv, struct ethtool_ulp_ddp_stats *stats);
 extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
 #else
 
@@ -122,5 +135,8 @@ static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
 static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en) { return -EOPNOTSUPP; }
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+static inline int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+					   struct ethtool_ulp_ddp_stats *stats)
+{ return 0; }
 #endif
 #endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
index 53a67ec72f0f..5c146de89905 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -140,6 +140,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	skb_frag_t org_frags[MAX_SKB_FRAGS];
 	struct mlx5e_nvmeotcp_queue *queue;
@@ -151,12 +152,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -230,7 +233,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 						 org_nr_frags,
 						 frag_index);
 	}
-
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
@@ -242,6 +246,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5e_cqe128 *cqe128;
@@ -251,12 +256,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -330,6 +337,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 				       hlen + cclen, remaining);
 	}
 
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
new file mode 100644
index 000000000000..21b0ac17f1b2
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include "en_accel/nvmeotcp.h"
+
+struct ethtool_counter_map {
+	size_t eth_offset;
+	size_t mlx_offset;
+};
+
+#define DECLARE_ULP_SW_STAT(fld) \
+	{ offsetof(struct ethtool_ulp_ddp_stats, fld), \
+	  offsetof(struct mlx5e_nvmeotcp_sw_stats, fld) }
+
+#define DECLARE_ULP_RQ_STAT(fld) \
+	{ offsetof(struct ethtool_ulp_ddp_stats, rx_ ## fld), \
+	  offsetof(struct mlx5e_rq_stats, fld) }
+
+#define READ_CTR_ATOMIC64(ptr, dsc, i) \
+	atomic64_read((atomic64_t *)((char *)(ptr) + (dsc)[i].mlx_offset))
+
+#define READ_CTR(ptr, desc, i) \
+	(*((u64 *)((char *)(ptr) + (desc)[i].mlx_offset)))
+
+#define SET_ULP_STAT(ptr, desc, i, val) \
+	(*(u64 *)((char *)(ptr) + (desc)[i].eth_offset) = (val))
+
+/* Global counters */
+static const struct ethtool_counter_map sw_stats_desc[] = {
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_add),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_del),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup_fail),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_teardown),
+};
+
+/* Per-rx-queue counters */
+static const struct ethtool_counter_map rq_stats_desc[] = {
+	DECLARE_ULP_RQ_STAT(nvmeotcp_drop),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_resync),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_packets),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_bytes),
+};
+
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv, struct ethtool_ulp_ddp_stats *stats)
+{
+	unsigned int i, ch, n = 0;
+
+	if (!priv->nvmeotcp)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(sw_stats_desc); i++, n++)
+		SET_ULP_STAT(stats, sw_stats_desc, i,
+			     READ_CTR_ATOMIC64(&priv->nvmeotcp->sw_stats, sw_stats_desc, i));
+
+	for (i = 0; i < ARRAY_SIZE(rq_stats_desc); i++, n++) {
+		u64 sum = 0;
+
+		for (ch = 0; ch < priv->stats_nch; ch++)
+			sum += READ_CTR(&priv->channel_stats[ch]->rq, rq_stats_desc, i);
+
+		SET_ULP_STAT(stats, rq_stats_desc, i, sum);
+	}
+
+	return n;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 1ff8a06027dc..7b1c3d5305ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -128,6 +128,7 @@ void mlx5e_stats_rmon_get(struct mlx5e_priv *priv,
 			  const struct ethtool_rmon_hist_range **ranges);
 void mlx5e_get_link_ext_stats(struct net_device *dev,
 			      struct ethtool_link_ext_stats *stats);
+void mlx5e_stats_ulp_ddp_get(struct mlx5e_priv *priv, struct ethtool_ulp_ddp_stats *stats);
 
 /* Concrete NIC Stats */
 
@@ -385,6 +386,12 @@ struct mlx5e_rq_stats {
 	u64 tls_resync_res_skip;
 	u64 tls_err;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 nvmeotcp_drop;
+	u64 nvmeotcp_resync;
+	u64 nvmeotcp_packets;
+	u64 nvmeotcp_bytes;
+#endif
 };
 
 struct mlx5e_sq_stats {
-- 
2.34.1


