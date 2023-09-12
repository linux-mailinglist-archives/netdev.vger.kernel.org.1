Return-Path: <netdev+bounces-33141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7D079CCDD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25677281D1C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56D17757;
	Tue, 12 Sep 2023 10:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9217725
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2893410F5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFegbZ4O1na44FcrQXMFur7U75kHGMKJ19t1/fPaA3b7MaXSIIrufFrQLY4VH6tRLpF4lca04OVl5iZP1SOFmnZlKCwSs3TYf7TC3+mMJStJhaZ+sSfGwOOwG+4V1sTM5cMUndD6FmvYA25HZQYRsO2JlA11Y+KadewvGyLbjEPcgE184fQ2JmMjeU40uTRaeNDuUdqIlhIJmkg/u+c5OiySPKg6TrF9qKE7Nz3oE58v3OAI2T3r8Z+922ZynJbYG1hfqnFh5BcHaE55lhSRuCTK5PuFYTeQ4MbHQQzJvfAYKh53xdsEk8hVfoFF51ocTaI8FUyPGMCuIyyi7HvaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smKil+QXC/4BIgbF9/VFLOo8KkrTKoyfafMBSFa8F6M=;
 b=GYCWkOKFU2epEfgGAHZn9q0RvYX/3OkIHF/XNxPF1SLI/mv0HZSZJjyt1iSEoNMuB/ZjswcI5U3V1BwVakfF7qGIlBWcSnDj5Hqqn4r/PVFnAOTbhG+0W5kw1g5wqqtWu+l4689uC67Cg2d0xBAzg33owsW4znTNBgZCZZo29Rmr+WAq8rTktE1nQpePmvWl1r9XYsakMAFdThZoCb1paBC9AqIFeOpPuXmMF2q31Bzc/o298BWSJV1wSNQ8n9EtSM+3fp8R7AUnqhiEQUbm79RyQTxBZOYROW6rs44Fcnfrr/dCY+Xk7z0OSmJxM5PkifWmH116QgyhGf9fEw7KvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smKil+QXC/4BIgbF9/VFLOo8KkrTKoyfafMBSFa8F6M=;
 b=hLUz6G6yl5c8eTITGWJg9O/p68Lwf2E+yU8AUoMvHYL7vniOjdzXGm5lmo1DQCOTuTAQk0t+vmdOVzyXnXQ2LqAEMQaWpr8q/BSyDxHzMndCLbNAvY+RuwFysMZqASzOsXghW6fDi0A2dy8lIJbXIClTe0MRNJSpt6Il4XLDHSTTwYgqrWs++2G+xccfwC2FAw3sJCRU0nvUn7ypWMsHgtbD3Z+GkoyeSDFsKBxTyvyey+RDu2hnxHNtCmQH3dGMxHM8DzZZeBuuqN1aMYEDbRq72CWG835XiJDthuc1cZzscR4UEAzCv35qa5QDDmbGt7Q5uoKAFHst9TSjX1kZXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:01:14 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:01:14 +0000
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
Subject: [PATCH v15 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Tue, 12 Sep 2023 09:59:40 +0000
Message-Id: <20230912095949.5474-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd7b206-444c-4d35-d4c1-08dbb377335b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JCTmj5RcayZ+DEqVqSRCLtwa2XcJeJ9K8w4/G7CwxVnaohg+RrGwpZPmUbRX7T5yYNa4gpwWoZePG7+WajeOYCKgs/XC/TPh35g+Rp0fuhqOS3wSrchZ1uBK333+G11KGpcJEwlBlzE0oAkbUcOy1D2PcdIp4CGyd2rjL6lwoswBFWIT4+SE09ZGAWUmYR1TBksmAEUq9tkZmeBHQJ6nAkaIcZM3YFKR9Iwl8jgZQA8gbdr0CqwryMtsDdzimRc6Aijydy6s0vII2iYyCoIjNtR0dt4uY4kZkey130E9Bi+50gqdFdFZT6kR40yNZZzxociSdzIsrzNOZ/p9hrTfeoym6Iq87M+BKj3aenEy/pkzWOlNaKrIRD35bh9JjeuJsVXzN/r+9rZ5mpFI7mm5ESFip375/omasTgvyRMtmWKabFFPjsNwOqOD9e+9X9O4KDG20LKkqLi09/HPGVbycEqURVdysIfj1ZtYo2OHciUvSlN/aO2Oy9KrellpaNXV//LWhv8juRgpJDv/H2CV62FDt64qYC2QpwuExxkegCuIB3RwhFj5cvMYweX9r2hx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(107886003)(86362001)(83380400001)(2616005)(6486002)(6506007)(2906002)(6666004)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SkKjdD3wRIMEJCCCtEutbnpYdJ/IGM9R9vZU3342w/ESPDw9I9+3xhrMfvlZ?=
 =?us-ascii?Q?EO2GcnNewg2SCa8i5hQVEs+ovjBHYXU+e6Zo5YpfRX7uTAU40CwfZ98uGut9?=
 =?us-ascii?Q?FRXrSAvXg9nKsU8Cnnx17I6gYQgFj/RU2T+GeuP0HqikhBWlU0xgS+aQ4pPP?=
 =?us-ascii?Q?gh50zLyuYsDDA/vjpRsGfSFMlraIJNckPwNegpy3OGGIX62T1yR0OWZhUx6y?=
 =?us-ascii?Q?efWCizHfH4pRF4hT7+0IaTz7cN5LNlgzniv1IzqiWGXPRx/dTzII8CH3fDT7?=
 =?us-ascii?Q?Iy3MF9jDmsjg1w9eaekVXJvgEBJYbkXD7XoYjhjU245/UEknNuZn7M/Ql23O?=
 =?us-ascii?Q?P18mcGgUq03tIJHKANdOKkuwHl8Diioeez5PZtLRtY4ohCmLW2GfXA1Tjf+a?=
 =?us-ascii?Q?crJulTRtzR9hb56ijAt8MKp7v0eFRIY30WSdKAd10o3X/pcobnwhOkg3CEkN?=
 =?us-ascii?Q?/kujQTRBZL/NjRudBYu/afPDXx4mzjv9vpnpk4fDhcxDur+s8tYhf4PClPAW?=
 =?us-ascii?Q?Y0eahcPbQ0/+2mFvJt9LPxdRS4kpLLdoofqvXQlbf59/CzQBf3sw+UNsoamu?=
 =?us-ascii?Q?m+5tshSBcMJRvBoe+Nm7bEqEaV4P5sIq/3YThgyNzJGDT72ZRDWPYGI0SY8Z?=
 =?us-ascii?Q?nrZOHStxtKwoV1Qm2oNVUz0Gd/ymV+yG7G6YdP0sxSeII/31/MnobBJdVfct?=
 =?us-ascii?Q?zNwLwvovTa5ZI3UX02ySw16slWD516UWEaUWsezy+i87hEm1CqHURh3FwtAH?=
 =?us-ascii?Q?/mB2zejDZ4rMe5/A1xkoTmd63IbEVOyboudoOMqi0ZjIrTY7z5BwzsZdRKkl?=
 =?us-ascii?Q?Zymv0rRV5L0jHbIM4JEi2N0G59Er7ghQqGsatGlpLwIPkDbF+/9eUEMYYpHz?=
 =?us-ascii?Q?v2o5lhCJOw0m0nXiHuviTWSspvFqDsLiHuJCziBed7ooUu+iDEFAm6G1oSfX?=
 =?us-ascii?Q?DJ0Q6dOy8jku6ppo3TeuxFT0ZW/rF2xiBbWTlc0UIUrPPI1kmB2mBsSHbw3+?=
 =?us-ascii?Q?BoqnPBama/W+RrZ0j9G69Qz9FczSrH3C51TiLONDS1vVjxQChz/kxSLche8A?=
 =?us-ascii?Q?m8c5L52HEaWidB3jAaS4xMYJkTXE66zbwzdIULHYj3DgsLcazCcI6oFcczrp?=
 =?us-ascii?Q?mDyU9uDyzJBgAnsWMet8G2Dhn9kP7PXEiJcYJDIjmk2dW1sMvsPK1Bo5ec9q?=
 =?us-ascii?Q?LtRck9nhMQaLNRyalYACM9JKIASJ3Ntw7TnhdS/2wftjn9RkR8JJmOspzTyh?=
 =?us-ascii?Q?ZKNcLaIoRn782pVLYun3bfWyKD2xHjxChJw5AP5Xlzr3pPxjbBsjRERwJywc?=
 =?us-ascii?Q?whHktySWVoVO3fFPVYL33OsvpvJ3FmegyaBDdUBbRSnHKqflQ0lSYIWKbLJd?=
 =?us-ascii?Q?QZK9Aj3owhk4qoWxv3xJQXfIqahEtPf308bJxiy/sxYpwHgFqZ/NwX5d5W3/?=
 =?us-ascii?Q?El1gaX6AWId7fbxTyt5SAbz0beLMBkEbc+rKBhmWrJuRs3iKMDje+5e6aeCM?=
 =?us-ascii?Q?S8+VdQdUFRgp7jaRFsD7IxDVU668JAQz0QwOdT43W/Um3Jl170xArgbO505C?=
 =?us-ascii?Q?rYNdrE+u+7QMItAcdCeNoFkaNGvS4tA0sDvgM4Zd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd7b206-444c-4d35-d4c1-08dbb377335b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:01:14.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAkrviZkhi73eFsbfqTcGypKl8HM9B5rSKwTz1uI+qhCVqaZLSkwJLe1giB6peDPk6nY5lgQxXhCpLXtSNbKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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


