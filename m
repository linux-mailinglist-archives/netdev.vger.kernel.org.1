Return-Path: <netdev+bounces-29673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723CD78450D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AB81C20B3F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A5B1DDD1;
	Tue, 22 Aug 2023 15:06:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63451D2ED
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:06:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A390CC6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alLl2NTvwI1JfAmdijREmAL8tmqJ67kFYxrrvf5H5bC12VfMG3Tg5yV1w6ENKmipYuU8VU6qMjQU1wY67YnFnmlhMc5LRrzRetb5OV/dEA7xd8/SXbIKQs9LHWPjCZ0Z5C7tExzLsojAL5A9pzzeDKs2RQM6kxLPh1geytcwChHg4fUyqaCuBKmH3t1TqIjIbZp5NYuNE8u41btl1aXvIrccI1AXeEISvFuzhQPhf1w5wSGxUlcFfIAMpda8FWOsVcvmhR7PyADAOHb/GCj5TyHAX8gLmHWmQ3KM8F0sqb6vJbOV6zn7bR5V9e/0ZPvGAiFxUc4nU7rtT3ozV43h/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1/ZP1Dm1edYifhmRXtlLFAwAxhNQznXA5IHeqXUwFw=;
 b=N9go0yiLbhiyCeHe9yO1fI44JYDf9zHxF8GYJVjcrttHFlbP11xugvFSktgKZ4wxmo8aVkSF/2qYiVdF20zRo2NwZ4DRDJK+6DBe3oSSuLjWzRl4gAgKQqfoqHLd+PFwql/plLiuvX0fJu5zegm7gfwwA9SDKRnuoZKnYTowUaJwwUw1CItnHVuu1mCGYcPyV1zj/H2oqg2JVOL+XcH6cDVzFTGixbf9R6Ci1IJ2fpXmZ6mo1VinpFK6rnYf0gqX2bMeK5gwIHjWcaYcGUFblqGy0Lm3AF+Pf7OMRmCvssTf9DhBltMSKpc8Te1+wU0jJPv0mpqp4G4UzW5T3T29vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1/ZP1Dm1edYifhmRXtlLFAwAxhNQznXA5IHeqXUwFw=;
 b=IEsNC5nQFuwKgxb47VY4VY5S8mZPHRsaYQAC+9Tc2O+uEqW42OTH3taMJZrgqwqKZJ85z765rKnSpr4c+nMcVr7xSYWrCdY2m3wHl8VeJ5WI7mSfc+zbJJjUIhLWlzZjUVgFBnzK2EIUALfnMFW2UOXL3xsF9kYw39GN9MfPLS2zv5oqER5vIZiGvFZZ5AnGAcMAaoJNElREhjo/gddybfH/eZJOlcXNi2q0nWzrVEIfdeJHz4IjsH0Di1fEr/b6kFDej6By+Dksn6QMul189VGCpb92sC08quAPULC2JARXonYHByuxKwrkexsySRWLsggk/KLjUY00Kv8sWyCiUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:06:09 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:06:09 +0000
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
Subject: [PATCH v13 14/24] net/mlx5e: Have mdev pointer directly on the icosq structure
Date: Tue, 22 Aug 2023 15:04:15 +0000
Message-Id: <20230822150425.3390-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: fb91f0b3-88b4-4ab7-cb93-08dba32150b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aF/ite6vXYWF1Gnt0alxLgE7oF9rHB1cT8CZLLgpOCoxdH84/6jNvRg1OkkxFMt2QOzQmRqn7tI6LehzYIliW/+zaJ2mjOWotx7D1UbCP78OY35DM/6khbbOs4HT42xKrsBuj8vwKMANR/7reg/LYAfkGCt34fHz54UMHMcY5iLBHnaxhc+S6+RSqe4egLLKO+V2RvP32jWyLJEA422oqOMQ8igoiaDDx9HZQC0e4laN2ovlwnarm90ZgYbG6G8YaZcI5hbU4oQ3M4HIhrRd8fPPYCZDmhNehZzqxUOcvvVtAno2L5hnrDn1QHGlrg9R1PHFMc4NTbBjULLO/L+F7w/zrNvCXolUEbe+kEM+D6uYHAcOKb/Q1rvEhbwjSbJWgoffYila+81Y2+3lK72IcJvGEIA3Io7v83zVO8JtDdYS37qn6exRPGNIOrd4gpP2XBQlBtfGKelRqeoULi+9xQNxNSGU0aaPFpP/yQElpHamtUvC1fIrfpKI/X02j4RoYJdiofXR1U3a7PBx3aNEvZCqXzlRHoEFtBwCst67bC+Q0nnrwXg1hzLEz+6E3rZ5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0O2qaXFhVFf5OmOc0FOt5MAgGjGdQlbSq7acyUvlhevrWbj/IleCG3vkDhj?=
 =?us-ascii?Q?TDp4zAl8x0qp2mZS95X38lnLx3r0Uvt6VUOj50xIHXsz/TCbUZ7kqMAf0+fC?=
 =?us-ascii?Q?qWWZGLD3ZMbKovFCdvO1cqDNicMPdSvBO2ZR2V7uu9Ot9Vvh314+nhXqWQU1?=
 =?us-ascii?Q?WdTXahRGahc4B8s+3xY4AUD18PTz9fuplZkHszMnWR5xLwsiLs/EGfUZa1vU?=
 =?us-ascii?Q?1PeedBjUagBySrPP3gHEUPtUG0m3IHxNUwV0uc4ZIDFE0QT8BPY30W8dK+6Q?=
 =?us-ascii?Q?jrMRDa0NpCvjXhQy1Np4LP9sptm4OXfaI+GVMMT2BZeIWBEr8dUNMJpoB6/s?=
 =?us-ascii?Q?IM/kuLWW0NatQGpPxAzAXOnWcZ+csVXvSGBxGPPx/ujglTGBjmuElnOgINod?=
 =?us-ascii?Q?+86K8Laa8mfXX+XNre3DytkXGqpjnFiKkd/j54pU89pjiyFDRxnxtlbUNsxl?=
 =?us-ascii?Q?wEte2/ssZA5vNloAOy1YiVHNavTd9mc80px1ncuh/udVXeI4N565ffC6Xo4u?=
 =?us-ascii?Q?rCe/MdwECJm+yOSSBr3MMBJzgSpmsafuGVrs15lWHAxrG1zsDy0NQidqxvZg?=
 =?us-ascii?Q?dfLslq56R9dmjPB46COGziOPbQ76c+ZEG+PbRnfLZ9RSo6M4WXj2G79IVZnS?=
 =?us-ascii?Q?/iTbAE5sH9dszjp2hoENMGGiOngHkr1oOTISKJudz4UAqKmHoNkvucikPulb?=
 =?us-ascii?Q?KAb0fLGb/Fbsbv81en2dBiorp/oRYlvJ0e3rLt5h7KVB4BcKkobl0WOlr5nH?=
 =?us-ascii?Q?0T8aIgj+SDbEbLbQjBR4Ha6/1gm2ghNSOLXH5pD7UWqewmQXVPNSdj7s8N09?=
 =?us-ascii?Q?xA0znoaUx2rlYotL+x3WAT/vRA2JZzUW6p0vuGnEyn1cGuyGAGY0CKRgIepv?=
 =?us-ascii?Q?FyNaK7sQUK3ndC1aE+Qnp8Jyuep0nKwvOclxsgo416X5b72AH90ux0jB2nLd?=
 =?us-ascii?Q?j0FLVV7ivZKyc33jXj6aRcA4r/qNsE/pCPp28gn4+urGtwd/R1et8F3rfT1+?=
 =?us-ascii?Q?ztn9Shi6oTzQ26ub9RzFEPEeQxY0gknlMKdF9JirFU5X9VFwjHcdzY+eaYEp?=
 =?us-ascii?Q?jr7N8CcVpErDYCt76KeSb7J2Ki1+GgctxW6rEhmtd7tQ3XZahsMweh3Ndk3j?=
 =?us-ascii?Q?dHdCxEnjV1uZZEpwkkMkFi2zv6MzSW/epxt6+AnS3dX7eeq2R7hOfXldgasP?=
 =?us-ascii?Q?dT8BdD0sIdyuOUoPVPdhlMFdyn3cGA9/SizlQYVEPHK/LTDviAddtumtUMwn?=
 =?us-ascii?Q?0Rtgken9oSYTmMQrrJkY/Cenx4zHcHSbjOpvGRE9vy5c9GSXryhFxdouTaj5?=
 =?us-ascii?Q?4jCJFHbLStX0wD+OVOWO95ESTt3MVKN6WdR7Fj7UQ9h66VcTKDB0wR6lpAnp?=
 =?us-ascii?Q?YdEb8GwfgpsyqFFK3lElIwIaIezmnmtCtmgVJSHewTC0/uQ3snmtZp+advGT?=
 =?us-ascii?Q?1keU/yMu+7ODhwvjUtwJBDnNg0ey9IIkFTN8xAyIlrTpUFRIeRHMjvkNsp3s?=
 =?us-ascii?Q?v4Ypm4s1rZnP/RTm4+QaeSCWUoODBM79JsqHoM+LPsnZ+04FOL0YDXDQEB8J?=
 =?us-ascii?Q?DVG3hwwUsLsoCSoCWNYOifhybD4l6aEswJL2hEy5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb91f0b3-88b4-4ab7-cb93-08dba32150b7
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:06:08.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33VTf92t4ZCyrIA1nTOdeax1ZYU3ZZe/sP7r4fpzf+KCPVYB5MusrLBmU6ihosDprpmHMZAXdC+vCGbLBrUNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Or Gerlitz <ogerlitz@nvidia.com>

This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h               | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          | 5 ++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index c1deb04ba7e8..365433c54edb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -547,6 +547,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e8eea9ffd5eb..1da90bda9eb0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -46,7 +46,7 @@ static int mlx5e_query_rq_state(struct mlx5_core_dev *dev, u32 rqn, u8 *state)
 
 static int mlx5e_wait_for_icosq_flush(struct mlx5e_icosq *icosq)
 {
-	struct mlx5_core_dev *dev = icosq->channel->mdev;
+	struct mlx5_core_dev *dev = icosq->mdev;
 	unsigned long exp_time;
 
 	exp_time = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, FLUSH_ON_ERROR));
@@ -91,7 +91,7 @@ static int mlx5e_rx_reporter_err_icosq_cqe_recover(void *ctx)
 	rq = &icosq->channel->rq;
 	if (test_bit(MLX5E_RQ_STATE_ENABLED, &icosq->channel->xskrq.state))
 		xskrq = &icosq->channel->xskrq;
-	mdev = icosq->channel->mdev;
+	mdev = icosq->mdev;
 	dev = icosq->channel->netdev;
 	err = mlx5_core_query_sq_state(mdev, icosq->sqn, &state);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 20994773056c..3c6c5a4692a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -267,7 +267,7 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 		goto err_out;
 	}
 
-	pdev = mlx5_core_dma_dev(sq->channel->priv->mdev);
+	pdev = mlx5_core_dma_dev(sq->mdev);
 	buf->dma_addr = dma_map_single(pdev, &buf->progress,
 				       PROGRESS_PARAMS_PADDED_SIZE, DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(pdev, buf->dma_addr))) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a2ae791538ed..40277594c93a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1437,6 +1437,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1835,11 +1836,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
 static void mlx5e_close_icosq(struct mlx5e_icosq *sq)
 {
-	struct mlx5e_channel *c = sq->channel;
-
 	if (sq->ktls_resync)
 		mlx5e_ktls_rx_resync_destroy_resp_list(sq->ktls_resync);
-	mlx5e_destroy_sq(c->mdev, sq->sqn);
+	mlx5e_destroy_sq(sq->mdev, sq->sqn);
 	mlx5e_free_icosq_descs(sq);
 	mlx5e_free_icosq(sq);
 }
-- 
2.34.1


