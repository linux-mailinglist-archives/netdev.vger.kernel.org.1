Return-Path: <netdev+bounces-57442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09781318F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB801C21A7D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C656441;
	Thu, 14 Dec 2023 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r4OHV4PB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEC0184
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:27:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFCK6Wg6JPsW4bwsY257YQwIpC+c30ySLA2hVhNY/RenzWZ58nyEq3pperfVMO5OpM6DCHYlYEl3vcfB92MdoVYZAe4sq8YT1UZUzJgrSgTnaTKoEACae54QcYsAqV6BaoYU+LMDGWpWqXSW5+wzRBFWGnPIZUjvFT/4RXu/hFEB62XRTvaRZ/RuVzglYXgla3zoz1mOIATmftwmFe8BrFdlkFJJJ1+L4Btleg1RcQ9AC0BN7A6hVUEE/741ZBM24+cXjKeN9RuJy1x2j2aLh14GWGgdbOXSAF9SR7pvC4Me09U5KpCSPlTJLrvX5KkL0AkZ23uyOT/9eIXqtL3VQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4vFytacI0akD5fbZ1CgExCmkcknh3sDQSfZMK1L8/M=;
 b=VTjuyTGx1or6faNq6llOpYbwc3L1iXlCJUoYRzer8Nl/WA+T1WkY7HPpjAMxn1nkACB0+ITwbLMI2ZzMhdTUiH1va+2BH4/ZvIn5Rh7HJan0gjZ/FZ4ZTisWFweOw2VuO9pt8c2N6Opj+NnxFFC64wUNAasXTYMwR9mdMQbdTDQd4DoYYrUdbej1v7hzoP2MiyThys9hQTRd1PxA1mJPvkfKtXPb+ns33uRuiBMitmEF/WoKvLNqRgUSqMxEuAGlLS33q8G0n9ObcymHSpBuQSi622XdK+ziaS3tYH9JU1QXLQgaay1KStcTJHm3uT/kxak7qzKX9FJu/A5dVSrl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4vFytacI0akD5fbZ1CgExCmkcknh3sDQSfZMK1L8/M=;
 b=r4OHV4PB//vuMkeFLowQP0k9pbsTMO5DjODdzBw5XHergZ4PAfzGST2ps1ZIxdMF0D4ZnKuu6McFfTQ/XLbltEyInvQ1TZZKYsCS3PTen1eOr/23C8GIHv/SkPLbg1XaLJim7SFxKqguXi+YziJjK/R1/CVpZfIO8MuBiTL5Rt1FYjJcBEsb5F53I3jSCur0hkTtxas2m449n1q/AgoxMg4Kh4GdGwiczx0HnTyghlvhbV4uFM2jus2Y8foo5AGgMcLZJjVZX3kNMmp1B+wCSqzVFhTSXq8mUIfx3tyNHXeIbSb9YUVgp6Ea8e31u0RtA3QSMQC/3D70voZ2VAADIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:30 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:30 +0000
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
Subject: [PATCH v21 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Thu, 14 Dec 2023 13:26:14 +0000
Message-Id: <20231214132623.119227-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c12702-12d3-43a3-ba3c-08dbfca86c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f5Xf+9Ph6H/4zcfDMYcq7KofVIuLnJ1cBn2CjiPt5wk2+3P/QfRAbVutyMdg89L300Bd9ieoEXmpPxxMWdQIKtpErTx5vcfsW5Y3xhyHS7OFSN+bwpwMXdG4g4PxXyAFY44u1ZbkYa9ekOnB15TD2mL7FXcuWfXX62PRQmjWMtYjuaWrKbHsx8ETX/NbaBLDmdE0NdQ+0ySb2NUCwD5LeVtlOBXz+HfHwDCv/e8Ko/ZKxVQ8qP2JrGmMY2fj85/3LrUUq90uMf0Z2ReX/GEK0siPUBYZoK+biq9S8ATaq/oKbxeHE5EfvSAt3KKWASq8vmmFpKPSUvsU7ImuASKbXviNC6PM92ySS+QOpz/tPP3q+Jy/WkxgAtQHxkv4CKqB6wrrBEsZiQRsKpYfPH+ejPrpYCB2xDYYm5L2qyONuWwjvggkL35tmFiy3njfQ0XMVLib2qvbtBWNCokTpvIQpTFUyQYUB4q/LLx93Vs1rCRlXCj7Bxu6EsFEybARYC3rxFfk9I9IKA8Wmt0TvDhCP17APVTw+ZDdlcMJY+abw7fJfYJUZCFrC43f9cMgTBuM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(107886003)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AO2CPjt7H26XRQ9EcDlsE7bg+us4K+h7Jv95+GTMf2mj5tETd11XGIsU6dnK?=
 =?us-ascii?Q?uprHb5sNermRJG2HIfHPCtOM9TOWvqt/pQdwoqEnO0gSXbqYfNJAvXqP0/lM?=
 =?us-ascii?Q?G5UfHQkD82svUJOrx+d30fqSi+GCTKnLmWusB/UzfrJmyxpkDz1Ml/LJtwVp?=
 =?us-ascii?Q?DM3Tg0UYuTvGvsKYyGuUT8BS4A/vKtDN9ad24o9CVAdLIfwSx6B5Z+osfXSx?=
 =?us-ascii?Q?vP4Th2eMH40RmgEKGvSKCHdRoeagh6OaQQkGTlK2cJKAThCkUx6hPUxjbSKw?=
 =?us-ascii?Q?zCYZz8BZFJF/jpk1IJtTJxOaLPcqryR6U7fEI18jMCJygxvaJUrLwe16qphD?=
 =?us-ascii?Q?ZgBPH+M0WXbRdAMr2SHn8OTwcoH7emdqeTx1afWK4tp9YQ7p5gECPuy2tdrE?=
 =?us-ascii?Q?yHBiBCz4wx5C8Cs+Ei0B5MWXBDbIymm+POYVyJW+yI+ZP/I0H1npgCqbfaJv?=
 =?us-ascii?Q?BBkxIq6L6oGg/xJHcMWVwyu0WzsebpbP+6cobJGSEc9UnkZmBUUjkZkLraAv?=
 =?us-ascii?Q?3yYDU6Zcsx5T3ojPHw6M5MOSIslH7P7/UAtt3cQzYU/QHdOc3+iIK2QRal91?=
 =?us-ascii?Q?KiijNiVxTHkh07x2fibYJd09iPuv/v3XkOA+Za9tEueQnWjWdo4zSRSVD/tg?=
 =?us-ascii?Q?d+bz2dsNDjXmd42+8YOaUdfcsOijWblFgwhVrh4Vqj5pEBbo8UhKR7G9YYT3?=
 =?us-ascii?Q?hpbAeNp8W/+A2FQ+U/Ief+9klNh1X4OZJ0ASX14tGqxlSVS4jsfaUc2Bbn07?=
 =?us-ascii?Q?AH5mz7QooKXnirLx8uDgZF9r+pymkOtLLfKtWFMgEkwV0srYBfkK9S9nKeiw?=
 =?us-ascii?Q?NLrKVhUWLtC+8gld5pDfTMl2It68nnLErpCuatYFzg+GqhIpod/VxSKc5p4m?=
 =?us-ascii?Q?m/0/pXJIuTroMK6UiBvU1JDu4VUjAh/PSblnXmwgutiXl6/bO6NWW4N5H5mD?=
 =?us-ascii?Q?WYTg2OjE+2w9EkHriJqs9GyroQVsQNPG6qoSM485Pc7KSo5PSMHKO6wOIoaz?=
 =?us-ascii?Q?C/G97qzkNvfyTkwW4ShDSl8T33y0iaq12M9fD/jTq630wv0wo8gly55yq1Fj?=
 =?us-ascii?Q?UgvyIiycVZ1EdXICGfl3kXa752VxqIHHUAA3LUW+r9pFihho10oc7dAsBlUY?=
 =?us-ascii?Q?Ncbyr5mruHkDAjRXVv53fdP3DS6GGNdrhwfz+GBkXJ/lyXmsShfVjQpQ7DmQ?=
 =?us-ascii?Q?WaQLV30z4VFSLq3vUhXAyiWau0hkLZPHfCUZH6xMEsBU7nD6xulj1yiWL1Em?=
 =?us-ascii?Q?vcRR1uQw6wNXe7tNX+VK2XZz4k/Fs/QiIGT2x5a7gMAxJkR+kHHQRltKQ+Rp?=
 =?us-ascii?Q?CKpWUi9fjGZ2o0BYUzMjMIty3Jvbyc9UEJsrxw9YLIxv+nF7j3mA1NOS+Ne9?=
 =?us-ascii?Q?NELXO4EHAl5oVS4iFn/uKBEBUJ8FAINtcZGGXY3sPvbt1drWJLaWtH8LXMkr?=
 =?us-ascii?Q?qABnvoPBo4XKt5X04bmO6xG/PDlcSdR8QAgO4es4wT+Bq3WV54+ZBDXG1Njy?=
 =?us-ascii?Q?99Norms59vCj3vDSbsnifvppWvhppjU7cNQ+DLv2MyCFOC1oWHGgDlHNQ5Bu?=
 =?us-ascii?Q?pbuTKXJQE+kA5AtyF/csp1S1pf07kKrC+EWYpMPM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c12702-12d3-43a3-ba3c-08dbfca86c00
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:30.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytDYPvXNKSsxQWJybGm4FVfK59wf2x4p6IXhNz6pfet9RlNX7I3A3cebNcb/MDHvd1W9EJFQ3YVf2L8kgpwcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

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
index 43f027bf2da3..34be754f712c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -557,6 +557,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 4358798d6ce1..9cde6ce17992 100644
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
index 26a98cfb0a59..5740772a7b10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1501,6 +1501,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1899,11 +1900,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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
index 8d9743a5e42c..addf8905fc35 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -993,7 +993,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1068,7 +1068,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
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


