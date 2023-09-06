Return-Path: <netdev+bounces-32249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6028A793B69
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836D31C20A7C
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5301C8C7;
	Wed,  6 Sep 2023 11:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA3CA65
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:33:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F84919A3
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcDyk8J1z2ZghxJLn6FKeuCTNPtr3vWx8bNUPPUt1l1g9ormWK7j/LM+43ZmZF23iFJfoQ9qhZV1uR2lCSpVYLBVA//zHAKAwom8KGCY08nCQeiLVznTAaxekpS1GTrSTw5xhP+Pdysmv/uJr4fim+ObVruJ+v1gW/SA7nAzOxOy5hAKk/06gerrQAaBwPbkiP69fpNuyJMuHc7RFMZqwysV41oloFrANWZi1TKkxJNE6IeTsXCYnrvAHdTZ1h3CAGC1Ee7IoVk6K+ubQlYc14l+TpUNW6cNOSRK5uMrz2YMKNWdNiG9oP2aHcg1MpZdY4JFsoOaxjHsNUVIYp5ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smKil+QXC/4BIgbF9/VFLOo8KkrTKoyfafMBSFa8F6M=;
 b=ANhJGU7tAjVEcJJWsHp1/d86+Yw5/C97HUA+ZyqB4tANY4e+QFtQpZ5PSLgU/3gfAsn1MYMec7yUp+XZrYRnSf79h5qrsI7Vw5ivPFGrnGf4KBbpNtBfVcDDGeKJdO/nVZkHlLiiUBeYFrvQL8+SZgq+a53YV8lei8hR8ijfYVCwRafeWrNDXY6YpluUDne9uOU6ZajA+pjioviy81IHmJrkh0HkEONl1rFLoHHPMA3Vt3GNVenIo45R0yHi2HoKVhwudwyz8RsEhpcG2OGacEn94klNsRIToe56ElSzI21m1cx64pK5qXfbMK+2w/mbJ4sMKccCbFKu9z4bHzMlMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smKil+QXC/4BIgbF9/VFLOo8KkrTKoyfafMBSFa8F6M=;
 b=GOUF5/XA0o1RcYCLrYL60SfQt64KX1Zg68Rny8qSeudSilDGUa5ZHC53CVkidSCqV/wpVmxIN9F1HK0y0qb+oOYss80sWsO/z6AzB4niLfsj3vXJZFLMOglEoEYWbVkPnDDfqMSnm5yhdXblkjV7+lj4IHMM9sRovCoeDdMKo59hh37oUG3is0sF7oyuJuuYI/LHPQgk6J0aMUtD59t8bML2n6D1xphqm99W1jVXfmxzuc5/ez03lxiiRFMxgzj26Hg46NZ59mb14JGgNtJ4c7CUZqv5XXl8YCU5z83iEHNIIWtFllrSBaa6JnR2KvBjJNVKelhqUA5s3B1nBdPVaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:31:45 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:31:45 +0000
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
Subject: [PATCH v14 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Wed,  6 Sep 2023 11:30:09 +0000
Message-Id: <20230906113018.2856-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa97bd0-3a62-4f9c-27cb-08dbaeccd9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o8MgOj1NYYPy76GDxKWuxNqyDrYKKG0n8cY+E/AiIgv6/LQmIa9IAnRqKW/iYAd7yOZ3MJUZPURh5wvustUOWs4RDt3zjIEfH9BDrM1sRf1IEP6yzOEDK1uHzRsJgeQgZUVcaI2ubALtxm2n9K0PtXTDRJJzpj2BsQqSE+BT/IuDByfBMDr4BuXu2GAinei83aQ1mCzrJu5xzbywlrNGcn6ma/PapwBVwuDh3F1QXTAzubZhFMZDlQlfm5q3pOghjMNg+nwTdWYNBJbO5wR7V1a1ai/K8BmdomADefz1BUJsrxV+iVnh4A/4HAd3A79EkZL9E1jNxlsL7BMl/pEe60lYxYe3Xgj3tqsI3A21F9x/49gnKfe4Yl629LooqvWshL+4oJmNFWWnlGFBVy/6J4jWlOfd22tjXnJm0K1bwVsYcd7lfTKJXtu69CbEY7dXjFX3/Rer/mH0mguyII4+7Pja9sTUK+8r2/51dW/zlLTW8Ivb1Q4IxmewulHZbJmNusH0UHZJ3Cr5OI6rPMY2JYv8XQUxoRgqVUWZNiGAKKZNm1PqKRQgUIMrVSgOYyYz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(186009)(1800799009)(451199024)(6512007)(2616005)(83380400001)(26005)(6486002)(4326008)(6506007)(5660300002)(8676002)(8936002)(38100700002)(107886003)(1076003)(6666004)(478600001)(7416002)(86362001)(41300700001)(36756003)(2906002)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xs5pcs6/G/vGMU0U1DJ8HC0Uvoe4WYIVQGHE/kD49vNLq/Hm4pIAIEJJxc3r?=
 =?us-ascii?Q?DkczrNGlbMcQYIbCLZ87eJeYeM2HjQRoKXqUZI8umXyPuNRqM1eZzwKqUbDL?=
 =?us-ascii?Q?un5COzl9cnLBIuSf1/T1scOAWznp8YpFTXlO5lLj/6bPjWvTjs0zlqLyTnCB?=
 =?us-ascii?Q?IhZBC+2W+es4JWJazwQ1rA6V6BoKYaCoa1oxU3X5xx3DqaujRT1kJVgLy3fB?=
 =?us-ascii?Q?lF+GGnn4TnWypDdoELmxhyJKZn76t878q4jHC++6szzq73gQwGx6QOO9Otyc?=
 =?us-ascii?Q?R2nI/yjyrh1qsLVwu1O1N0b8sHwa47W+g94DdBkQkhbGjz4D1pK30++khn/W?=
 =?us-ascii?Q?YmViWf/1wZmQu//JMH0gWbUdIXah8UHVvV2rDBH0gklCM/6tn+9K7qMegUj/?=
 =?us-ascii?Q?MhavPymS1W4yz9grV0oO9vWSH2doGNYfnlP8sYhe4pqwYnuYdwWLjIX6y5NM?=
 =?us-ascii?Q?ntSCEOC4CcsS4bs8t6nTd1FYsaXjv8nWVzkOsSj/V4OtJsKiz1kEXy9ALkO0?=
 =?us-ascii?Q?M/vitXY/rZvjNu2AbxUV0fEyZEvXzeqXfwQQFihuKyWYLe+Nrs0P6XJmE6nj?=
 =?us-ascii?Q?ze9M8GcoSRlrlFxBm8AhWunT7NTOMGSyDXKgy07vN0ff9Ezr5TStGsCJ5sId?=
 =?us-ascii?Q?QXh8wT5nv5AT5oUp6vbzBiva3YrouYr1OoGFZi+MA8ARIITH9I3gBFPH6R0D?=
 =?us-ascii?Q?vlGi80BemmpnwrvP23s9+HTApyFThPq9r+NovTKqF9SumHtX80/LQwuQ8Vdl?=
 =?us-ascii?Q?ejAo5Q+jqhyAimhznKMuUxeuj9l3id4aGajSmbvAyAnXQTw1AQxY3eo/A+bT?=
 =?us-ascii?Q?0dsPBjAevKnzG4rrSnvOaHy+hlIZTjGPd18HnufWbhwooTm+itVL9/WXfhyJ?=
 =?us-ascii?Q?GnO4L1vqNqOCjGepd0UpdOzb5r2/nLNop2xB/b/ez6ZuBF43Ir45BPiE8fEg?=
 =?us-ascii?Q?hjhccvJ5MC6A2ZrRy7cjRo1XZO5BYNUtW+RhcfvRNyyq9xCt2F1CzjCSZA0i?=
 =?us-ascii?Q?wtQemeGm9IA+CSF9T5YS7/pxkOzz4e26rnkZiJSBqfMzxEUpE9pe/bpYunfh?=
 =?us-ascii?Q?2X+QF7t/FQRs7xKDs2J99nWMnKdswWd3sawgKSBR6uv11uBVj9Q3HW8XDxqk?=
 =?us-ascii?Q?5iwSIUwnhZt5esAYk+Dn3zU+OoFxeSWWzfS4tZazvKfU8BIpIKiCqwqq1qKM?=
 =?us-ascii?Q?/u665esKlX4Ii+J49EjiwFAlUuUDfPqXsbjfBxRa7p+Sb8IuXo1bj8EcCpOv?=
 =?us-ascii?Q?bXZq1wUXoJyp6hvwHujMdH2WeSnEE+LPemfoZps5e/ngFJK5/WEVQLZNH4Wz?=
 =?us-ascii?Q?/WX16bLIM1ZEDS2JIw68GgRvqrPknocH2Qh1ODPo8X46b5y3FTkdobL0hydt?=
 =?us-ascii?Q?9pnoEoFZSiYzplc42pEiBk/rpdfNbzbt+xXHvwGucxRe5ykTfmQlKWXmUFXc?=
 =?us-ascii?Q?q7cFTL64byl86BLTTKj5zdNUDCQv4qepid1+vLTNpl6DhPGnsdB6VXa6+t1u?=
 =?us-ascii?Q?ADGuo034x/qORKyfYJyPpRl63jlqxd/0hLkma9Z+MAqWlnK+00O6trYd/o3v?=
 =?us-ascii?Q?q3OKbBNO27vpQW2Nhx1DE4Z1NXRCW8ZPpxFJQ4/g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa97bd0-3a62-4f9c-27cb-08dbaeccd9c2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:31:45.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs12TntYU2ABGi65R3ChBFm/SCxPPayack5nGKytqebUA3CQxUIpnuhiGsWvykibp5t8+lWFfkfAGlkC8KKwBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
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

Additionnaly, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h               | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c            | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c          | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 86f2690c5e01..d3982baefab6 100644
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


