Return-Path: <netdev+bounces-50059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF297F482C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FA1B210C3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD2A4D59B;
	Wed, 22 Nov 2023 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bCrPsVRd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E2D7A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO4CiANGvzLsHiRApSE6gRL2Y6qG+F249PvURn6T1adWO7JCI77FVyVJpgC5Qra2kRe/zstIu+3/DJLWijjvP/Bc9DplKv1LA559eXcVmni2TB1UkL0Kc4AxCnV68aWohs48M5BSMz9yOXurOoCMEWaHTbPSXQimXS9vx/Ku1uicvuFLqenVC/fMq4QIEy2fwlopQcpJSgO/K2TCa2lDd/GAmmuPj8uA3olAmBjfF4avi1s4dWggxd+T+RYIn+ip0GW9JwUj1PVu4aelNkOZt23FVZXHQYMJEkcMWsGffZB4AKUFjGULTB49JNrRbX/cvEVnuraqI0TiK3t8hGTAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdxSgKaCfeYboh8zxYefJICqrLlQ/p4fRCRki+Bk6d8=;
 b=moXOwILhkxVRbJ7vxeNw4emBg8KK53PueHnWttfR202xLbM9npy4q4R4MFoE4I+OW5khzIGkG5s2wVpgql8ptf0zC7hoor21odaGqs5ZUZaYy8wTWtEtQ3DFeNQsmb/UfGKjBm83oLOktwXHhjuNBe439IfKs12q+ZLF7nmrzz5vZbBZxI8ik5vzQ0/o+42ryZSov/ttYF2a6ripTZlA2dZHc/NbzN15dGQMs6n/1sYGF25elnXCz9GRgZn277iqWpG/CCyW57MBb+Sd9KZENZvTNac5QU1yaHV6tS3vIDXIe+r8uc1d9o3OaWr7peGDioWk9i5g1RSL9FJ6IteSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdxSgKaCfeYboh8zxYefJICqrLlQ/p4fRCRki+Bk6d8=;
 b=bCrPsVRdeQE1GNUNAUuI+1quOJ4KI5n515covmT/5MmDMe4Y1fix1Jydwn1PX1UTkYAMRNtxvD0FkL89mkk/nP6uRAqB931md3ZImjBd422H+oqMimjFoPxKPJrZiagne5c73SBJDnmCT7QRp3Vg9PlzfvPolBDaiCCCyZL0Y7oyDTv8Kk5x085Rj4WTR9gXuQN9e5WnBlpys1YsoovdDzrKByL1Vfa6v42PTM2uVJ0sbq9BpUWJzXgpYwnfNr/4rU1GZ7MKndfmuuzRlM/2AyYrqLoz2ChWrZJhLZFSDnnbDUxZdLNXBRjyrUL1B3il8yAM/WvIzjWCbW/FzjDYyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:34 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:34 +0000
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
Subject: [PATCH v20 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Wed, 22 Nov 2023 13:48:24 +0000
Message-Id: <20231122134833.20825-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 794980a6-1c9b-42e4-5330-08dbeb61dc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mngx0Ycaypn5srR/CSC5GdjY+Pa8HhIt+QKWl1ffvqEbd0jyU79eNUvzBrUimlRWzAMgIFH7/eshaT70Gho8ZNrw7vkFQaq/Ucge41QaUCGHKZ1QTPULmwfdRWZ74clT2wx5l1GiZaV2ILWpssbm/u38Y+w5o8G7b3qdUtmoM4AvHo9BFoetExdQugY1K5nHe7MU4zqHWvSXYwMBTQFpapr+dEwogT9DHC6RBRObGhaApStjDSbB72VB0RsrTzlUtk6659/Ti7Tpcb3PyEVVK1pq9McH6I1nG+Fr8dHQxsaM4BEeeU/EoM8MQ04ByBvBgu+R9tr3fKAn+H3xNukpJSF4qBMsvpHmLZO2bGkwDVySRNlG4iMrcoKV0Z91fPR9qGFl6vlTVbtgVyj7cyvHh/7guF5dBETt5LXBtK48JIoUqDcLl7Zs3ttkjEwdCo4rHafBScgJjvsktqwEc4E46DDKZMDApE6IFUw5HWM2hBmxbMr/M66aAEQdCzXsVU/swjUqqiQqhH90275MKnFGyO/JI3mN51+9Uw3lNQN9WvrnojM20Gx42hdBDHex16a4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QHB8yg1XhySAw0/NiaJiEjXS5AriutNqn8DGDvLuaBEKbaLt8K0f64GyMEuG?=
 =?us-ascii?Q?nYsiNTZA6TmgjSvKU7ZACjtrh972gaFMXI5cx2B04Q45SvRjxjCGF2aso9hA?=
 =?us-ascii?Q?1deFbeHUwZomwPORUf1ouZJARlQ6++I704OOxrIoxbFFKUKpby8WsNBq0J3K?=
 =?us-ascii?Q?se2uctm28IgwIO92IMDILMM4wUaff/wMqXgqA+GXmbLa/uZrR7Cxl/8SWeRU?=
 =?us-ascii?Q?yiZRzQ3wUooQ1VHjUEgRnmjSCzGoeWygcJ6W4uNh7Ri3TmYYsRi1NFjK741G?=
 =?us-ascii?Q?Ug7IKHd5FSnVDVLulCmdXkBuYyxAoDbg0e9pxd8rzCJigWQjYmcmpKmjxLQ5?=
 =?us-ascii?Q?x41gPGGPTgfOdvVcL5ojC6xwx7bGBA423EkslWIDB6WrB9sOEYnCP5T/OLCR?=
 =?us-ascii?Q?4avgYTQGRa+IFQxUVGza8jj6E5kqxXVKiVersHlCO9o0DvpnBp040BrHZ2iI?=
 =?us-ascii?Q?HzLIOP+DSgT5gEVWep16Qi1R8kMOf7lLRZgz7e2RcG0C3BQOi+0ZN9jT/SXe?=
 =?us-ascii?Q?lDTWmjHtKqetapTIh21utl7VxtOkaFMwj2DSRLoOKTK6yKpHNw7h+g8/e/ZO?=
 =?us-ascii?Q?4ZsOvLWLVINdygtV+Rj7hfxgeoWJher7p6o9P02iIrRKKM4z6NHaRedUzJqG?=
 =?us-ascii?Q?WWObxwUNXM4yCEg2sAVKIfBJCSgY/d9Er/DsneLDr/fm0t6YgxWr1zELW5j/?=
 =?us-ascii?Q?10xNJid2LJMXxcbuGJpa0eAMk6/8YbsUR6iDot4Hxl/MJPALj3jQTUetSAbo?=
 =?us-ascii?Q?hUSko0vYMX8VVlPk4ay9uqMLrTqO2sDwm36hkvnn5mvGlUNMuTF+zCZ5Sgcj?=
 =?us-ascii?Q?A/DeX+qwYeGZGZuTqoheNsTCAwHQ+YAxhF72FaIM0+38B4gYgltxIbDPiOyB?=
 =?us-ascii?Q?eOfWQgfhkMYQEj3GfFmsmG+EFPC0K7Ez3JWpf72OO9PzzISs14r/Qod0cJql?=
 =?us-ascii?Q?ATcaIiSRm9XyULYiB5/ShyDS3M72qS0NReTvdNKqCoQh1xmw4YFl1IiVgk0v?=
 =?us-ascii?Q?DrlLRDys8Lc+FstVId69rRURL4F4FYDC3vU4tCBEPtyJ7RtzCSgRmKl35HIT?=
 =?us-ascii?Q?Cd7G1VAvKFO9jXPCA1n+tVOS9ts6lPT1EOj/ITFidX1c8DzNHgg9MmADj7ZB?=
 =?us-ascii?Q?9H2ngLT/zrnwnyvsJ5um9HHzPX6Uya1GWlbGrZnXtcSKn+x64cu/qS5hSlEb?=
 =?us-ascii?Q?3qVZJ9BibBxLY0l4mq+Atf1rqsxvS9mNNXvkiGWlWW7A7hyxhEzs+ar5MEXa?=
 =?us-ascii?Q?A0txVIQjVfbBWl0KEt5lcmXNbQBev15485tLeHva5O2U7gkbReZ8ojk5DZjA?=
 =?us-ascii?Q?0YrHOA7lSt1pkVCGvJTjiZodqN0ZEh04nmKIhlxZp+EK5ywd4+Q5Cp/KHvMD?=
 =?us-ascii?Q?EUSRJ6aiodwgBYA9H5dfcH7OY0pmltcKb00HaGaa6gRvis0apQC3SxqBPDZL?=
 =?us-ascii?Q?mzcyQV2DwJZeNixGC+ljh/JXxSksAP+gsBHyKTy5TnuW1jPI5Jz5VpDVN4ul?=
 =?us-ascii?Q?WOomkBnW+QwDCvMLo3YqB9aVvs+81ZSKrGE+9c5xNn4PM4zlUnrtaoVRZzPN?=
 =?us-ascii?Q?tloL3t9+IoJaxvu05LdD4K7HHoVTByZSS/ZlYGj2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794980a6-1c9b-42e4-5330-08dbeb61dc0e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:34.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCoAVhvUO/9JnQowjz12kjLOVQPS9jzswI93VvOge5OkkoM9qg9pV5XRURBRJ3RqKQqsiN9w9whaORgUqt4JkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

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
index b2a5da9739d2..1e1d8f3d2b24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -555,6 +555,7 @@ struct mlx5e_icosq {
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
index 3aecdf099a2f..d517c385f9b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1500,6 +1500,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1898,11 +1899,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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


