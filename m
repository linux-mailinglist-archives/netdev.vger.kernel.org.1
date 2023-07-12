Return-Path: <netdev+bounces-17255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275E750E77
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E611C211AF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485314F88;
	Wed, 12 Jul 2023 16:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2A14F97
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:21:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8782120
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/0492OOL9eDKPNsBqB/egK2z+tE5DeboCqQSBpiVBJfkV03292n3dvhAcZEoRBKkaR8HNiZJvded1UYg7SzScJb9RB5VtZcQQX92MyMGFEfjcSykLpDxTu2xMUPfPTd7EZygFKDglMIEnicnj9JK99eDwE/CKWcFU3LA+ZCs4HdvRmmCYJTUv3h017GkXSAS323/YqeqqjxK4FcP17vcjibYSTA4xproRTbZF0P1YBIJ8cZhPloumlGBfyl2ZSDse/0X5q5qeTtW2B0ELutza44YPJB+anWtQI2nMJAxFgppu1t2R+oZoUJNnKivJSMjM0qXKbEByp2ocpb8+E0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndYdRPDIm5QrL3KGc6ks24s3ry7G69iIPfkbR6LDyXM=;
 b=hlDd0J9q9Hwe32lSC1SujiR7vsDDXvrTS4qNF0NWqxJD4kGaTQUof0GRE07KNyArDVbnE+yW3EGdoRneNAWmU+0RpFEcn292FOC9Nl00IJ/n6UWUCrDEH+nflmlWWFDujy8oD5o0Uyq559jMHbSgI7Z37olLx5Ivsm3Xf37Ti1WhvEuyjArch4F7OsbwHowufBNFpUSPpwRtwNZNHxm+eDMJI+Qja9Z/p3qNznabJfjZgFRSSLyIBLbwea1Fi2lMtzZOYCT2ZlpUME2JoY5GaOnOWQYnbya5D6N2XW9CpbMbP5xF+5jDxPl7DM7yAixM50pRb5iKlfx/5Lo+56f5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndYdRPDIm5QrL3KGc6ks24s3ry7G69iIPfkbR6LDyXM=;
 b=tjh3x0ynD3Sh7vbVfDl3VcAm/IwZw9nGd2OCd0ptGr7FJNUkzUgTgmntpwvHauLAR3IfIlIUrt6fDwL4Awt6/5godlnCnZMoflu8k8Z7wlisUVrNk26RYoL11E/jfxoDE3YYRcib2aqxvdq2+D7oZfWvNivJqvbJK6I7n7EGD4m9oGfSHlgaQl0ywph1T9wynHRc1W1rxPSCJAm6Rk89ZhurgU5H00JV3iWDcvOZZp1ymGpmwBNZDruIUoTTDYQnuMVAOFgrgZLPdSCDX/GEgfpF6ySi4bVzoCoB/KzpWjPNk0uVdz6mZYRmkpaoxypRx8POE0rdEIysr1ZqcoPefA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 16:17:58 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:17:58 +0000
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
Subject: [PATCH v12 16/26] net/mlx5e: Have mdev pointer directly on the icosq structure
Date: Wed, 12 Jul 2023 16:15:03 +0000
Message-Id: <20230712161513.134860-17-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 7817a0da-6e89-4f6c-49b9-08db82f38eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aP/mpdW32rceNhcGTCUcfBKSCurB4xqLhRP6Tp5lpFq7fG/LiuWp9clwkgzyBxK+i20C7dPDkepbLYUsbx0GHxcjYVqQZRfifu8UKYuCHmF8c4y3y8nlDwgXjDD34hHdZAEroaxResMc7caW9xV2nlH2O4HsZCbjA7ih5+9KiXAl6RzZinPmA1c2LjhtMmN2/6I2LaINZ0i/KDIczwX7kc9FaP08gg+CkFyAwQGzmj+j9FZfqMqhjwZR6CmXYMH5GpxaZWuW7QGetDm0Sk3WZEyOQq3IqlKsgerqKBUw/IKiWIxnv3iQs65RdSNsy6rKIz+3y7WTzXfxbjRWiA56Mn/c6iWxP2eyMz2UghK1LKCVOr9hqv5m617/D+xClSfimEuMFb+Jxv5gu8yE18dcZjMPl7RlW21Ur2Ygs72eEs+1DkoaQEcWuEyG0sw8eJGuXmsg3b6EZV+UANX6ldkPE/6PjK92Ot6fJykiI3ekKYIjsY4mmUe8j+Bl0t+9au+91DQCWik5tCs3TB8elLRbQgHW0QWbz8/Ub9Ls3CLs3lXcHKEeiHf71qTfSU/ozl9P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(4326008)(66556008)(66946007)(66476007)(6512007)(38100700002)(107886003)(86362001)(186003)(26005)(6506007)(1076003)(2616005)(83380400001)(36756003)(478600001)(6486002)(6666004)(41300700001)(5660300002)(8676002)(8936002)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3V+FjLsEMzanqCx+MBniQCgCAn4Jeu+FMIbhpXOxh5MwV+szYDqSybWqK2xB?=
 =?us-ascii?Q?mB6mWMSarLVID8wCbVzBE0yMPsHoaF9/mtF2s9fL4Na1D0F2WF5OOqf6Vdr4?=
 =?us-ascii?Q?F2d0JNMmsuTnJL/AQdW/pbNlxkxIF8Zl70Gt3b9B3BSP40GWbG1jIsJOSHZ4?=
 =?us-ascii?Q?UsjIKpnLc34IwSJ2QL2U1ib791LlvaAeWGNqh9F8hBsBLaujQajf3Y+Dxltp?=
 =?us-ascii?Q?D6IKMVOgRZxpFiMViBVIE0DaiSNSLnlDY/frlnyTOjeSvcv+rbs9mSQW4FfS?=
 =?us-ascii?Q?3qnBLNA2vAnoy9UvHNf8KvIYncAqcSIocEzfL1+mviiRD3otaFvhsy1FiJkE?=
 =?us-ascii?Q?fgfsjUlx/GaR0uVlET3/eWaV6bYOymnA72WQVSiES9ZzZpEaVBfsjrmjPf/c?=
 =?us-ascii?Q?lUEfdXztahZ92TOLD2VtQ3vE3CkPB8BvCwi6qHDgeO1toWEfM/w4OpgIdxPv?=
 =?us-ascii?Q?RlJwxsOLXsFSVzzs6YXSjuZOgwaNeLH+OTP9EAA8exg65NnhE37Rf95zdY8r?=
 =?us-ascii?Q?QOpIeaWPBolMvR80tFHmE/phAUTPStCQV1m6sn9CscCAHVkXablO/ehjugbO?=
 =?us-ascii?Q?AlzS/98KVI4D9m6X8kpsr+EiFjOxgd4dcQoELrg0Qk1Ffx0oUlmp/MHHQ8VG?=
 =?us-ascii?Q?EvAf4bOJ5Chfgfs8PnrK0zzkE0kQ2+4QpJt4OS18QtKOu7oGdMZq9DfLgdbA?=
 =?us-ascii?Q?IuLdvfHppwjbC0wxmYR1HKjWudeHhf/p2nPXqYcVeuNnCGUnq0fmrSiEsdrT?=
 =?us-ascii?Q?VKc5ZnQuhE0x2fRupHGCl3AgYRVtugE3uxcofZYmZQMLP4LCjZFb3Cd14FmR?=
 =?us-ascii?Q?0XRqNdZQPBrbfz7U5w9xgjtL/XBpm9AeU6BLVaz3o0NEMrDKIBfpWeIC1A7f?=
 =?us-ascii?Q?Rw2vtWZ1wAvZ+E5dhkjvNx/q9u50taZTNl4nqYFC9LAw5Su8DLeAkLK2A9xz?=
 =?us-ascii?Q?nJG04aL9yBfqAAvSqwt3YOLdTEkqFygTCm4X0VpxifaNZavEIsP+Yp7s/byz?=
 =?us-ascii?Q?xfqurMTLAz92Q5uvVJopwSus1fP9oU0CV7Rm+fu5ia1v3kErdYfwZASwK/9C?=
 =?us-ascii?Q?xsEDyKntfTECSaYaUmBHVSdn8YO2JmscuEfj4Tsl6ZiTXfkpaIxoJNFvy3gE?=
 =?us-ascii?Q?NxEryRePuUFVxPXcZ/DOJIGaElxzIdIU/Jz8bwOr4xM9Y6KLLUJnNX6dOj+t?=
 =?us-ascii?Q?ac3Q5a9gjlj+nhfVec/IaobJdGcV8sABIm4SjcUW7rBEc+r9/B5pDfUt+ZpR?=
 =?us-ascii?Q?O2G5DvEZmdWbK+NlkTlKakATAq37ti9esNYInZFZhCsvhFfa8RAA7lqsOqem?=
 =?us-ascii?Q?aVdwbXO3DQS6CmenOaUy8wr3+6qhhJMZriCtiOr17rL8k0KuuPeoizCQBvj4?=
 =?us-ascii?Q?rq+zOwRPANeKveIAM32+XjMLAqyiIG18bPGTZhid5fkV3DKHH9eyC/FzhoEV?=
 =?us-ascii?Q?KEQF/GrMvlIKbSczQLYPtSFNvittcNVmRTMI3XNOzMaNHbUTwroW+4HBEkqn?=
 =?us-ascii?Q?Jevn0uh1J6MqcocLEBA8a87w5dIRvy9H6ERmWpdl/kEdh2BjDRHZH+BALY9Q?=
 =?us-ascii?Q?CbEtsUyHmi2FvsisaX2wzuG21lAwEeqOraq//e9/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7817a0da-6e89-4f6c-49b9-08db82f38eaa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:17:58.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PuVUG2es4QUOYesHxAV4e/TrW68hBGnVjMzYMHaCFa4c8jCbnuja4SazQCDlUnazHCsyCmc2mb/r33uEQyEmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
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
index b1807bfb815f..4fcb6c7db38a 100644
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
index defb1efccb78..d1820c4c7324 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1422,6 +1422,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1820,11 +1821,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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


