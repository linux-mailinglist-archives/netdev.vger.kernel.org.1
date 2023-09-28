Return-Path: <netdev+bounces-36873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D77B20A1
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A9890282790
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E604CFDB;
	Thu, 28 Sep 2023 15:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C24C87C
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:12:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4525194
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtxQjYCQ3+8xHmk+0woqBP18DP64gkpUfaWzIVBJoSS18Punjf0xnKWSz+p3WzrI3jr4X7iWVh5w+SqCVgksj5B+aWR5QR4QcRjMm/lEKmgYTPJ6XXHmDOLBkrgK65ZLI/jd97InLFm8OSQHOMiUjE81BjW0lpb7tXrB29qNgNQnCL3AUXra/DU0LTzO3kTt0mvvEHjg9xUc5W+yPvrkbJGECymhwkWFW3el4RfMD9Ob2VrcZvamDLoDkEJqDcoSnbKWAB4FmwwlEripWtEgYTxF96zGfVdfshhrQ5XEe7OSwexwZe9L7+NWa8acQJ6sqFie9ImH7iuzt8t3SBUp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcnZg2gtJsthAnjTyRQ0LeRc9xbcJ7vnvj6m+/1hfqM=;
 b=Y2KwOtuUIEztHgfwFiY1imZbEjk5EoX0HTLUvMBmZV5AYdKGlTDYZEdhEERmvXWXAdQVhNmOdMoHtKJh08A8JIQP5zpjrs+qsTOmvMqirr1c2y5zczJb6o9YwTMfarXOMMRkk44DfpLNRRLv9TpKHSYbakG4Gv5jB2ZOWL4OhNl0R8HADLNedxiersycWoXqSJQHQz/kFbLbREpGZb9O3rfiCVQ1iJU3l9ZWNruq+DOSvmC1cCUO5ihK9n1IZ8hCYvYvJPB88lsseWklgdD078Qe75UiUf5O/GQqpO39FyOnKjn4q1e/Z0ZpgJXwQkgosbYdYpIkDWUdONrrtSqseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcnZg2gtJsthAnjTyRQ0LeRc9xbcJ7vnvj6m+/1hfqM=;
 b=dZZEEI3KzC8tAatJQ341IW8J+k+8PRDxDfWorn5wK4edaugX1xJN6pximS/4LGSrTk48oixCXWuKwoo517A4WEXJ6qSo1+hAYTbu1p9fX6retgMzPj6Ms1lrr5Tn8Mx1AxxRVdNRGheK/Zp7mcUAChnXAlrA3BgCIvwX2sXGNGO7IRYswqtFRT+pY4cNz3vwscZYIdIK5BhmHiBQlHvX6pRlQSFbB1OUM4UA7nuyWhwHiuQx4Hn0RYyq2OWr5DralFInrdPC5ynKLRkpLY//o+osvAM7X8h8HKbr2VdC4uuwDbFPWwhk2vtioI7JOeLWbUC4pQqzcqjZgcMzRImuiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Thu, 28 Sep
 2023 15:12:01 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:12:01 +0000
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
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v16 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Thu, 28 Sep 2023 15:09:52 +0000
Message-Id: <20230928150954.1684-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a5ab84-0ffb-4fc4-8b83-08dbc035440d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kFzTAQalHbaxyszGzfQbwdMJhOBHJZBsBnvselJ0hkb1CkEz5AM1ryVgcqS+yIKr+UyJTCZRwRMKd4p7gdslRhqX/VgFJXefuOkjirX2xETLEC7e5twu8V20IIRIiKNWphFtqZi/AwZM4nd6Guxg73DfOKg2aUZI+qdMJzmXusO2kDaVqwz+UO/NkqzOwcYf+K4guiFbnIocLo8NETDRGuRMNEAdoEnAD0PeojRkCl8rGoJz6JxDdJbzG6/mTLarXh8VVIj6fjwOl/k3IWd/YV4SFuqTodXEc3CQLp0DcByM4UwN25o6J3pad9gvI/P5Zga4hfFwp2LPAcZ6SdwcpA4k4LhgBWj5fvqdHS3IxrRSgqVJrm7nWwmcYWUHLiaiWlTTwp11XXHjC4i1sDLdPcDgencpfofTxRziy6GSDNJ/Fv0TmnMOYEWWvc5PsU6zt9b4IZFe/OJ/HB3TchXbZTXeFmcJQKqmrAiDmXNgwXEYgv4Cymfm+UIK+uNj4RBZNe11E8Xr/slW6BlopElcJ65zDlNZ+AwZcI83CQbAFe+/II3DEpNOUbVBAa3mtxvU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(4326008)(7416002)(1076003)(66556008)(66476007)(66946007)(26005)(8676002)(5660300002)(8936002)(41300700001)(2906002)(316002)(6512007)(478600001)(6666004)(38100700002)(36756003)(6486002)(6506007)(2616005)(83380400001)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFI6jbqDvJTfo/KJJX4aEmDicOtuPQW+Dp8XytIcI0lDck7CMLuQmqna3dA+?=
 =?us-ascii?Q?xPSXDiEepHj5RKlgQ939yFGKsyC8phzaGKoNzKELSg4CKagpC4LYOICDOW6O?=
 =?us-ascii?Q?V7mkQZc+HUg2LWThiZVN0ewQpomyIPgWDZweT3zO3eb4VQ4OZpEvFFHJkY6G?=
 =?us-ascii?Q?mcF4E4zkmFLg9tt9v5lVHjIK5SYNi4p2hPUTuYWcP+4VZLv2/puXheeoR9qp?=
 =?us-ascii?Q?1cDYgSJIyoGqSzOZdIayAbxQkLzt2r0AS9NBb+czL37865k70aUWX51stu+Z?=
 =?us-ascii?Q?OdFnANtaofWcJxBCYRTOmxHBkhHZFzJcDavQafmUx+5UzjcJtkRjcy4NxREq?=
 =?us-ascii?Q?QdDA4idxovLF6xDv4o1vdWoDMYWLSFjgJj0bkKGEc6/KUIy0qmlJLGtzctfN?=
 =?us-ascii?Q?z5StZfCHbA9G2hwmRaCjrq2DVWnG0uEo2KvIqIF91XkgfPIx+543ds6YVBVP?=
 =?us-ascii?Q?kwfN6kntkjBBDHXF3XENlREnbd08y5qGRnGka9+XzeS9/LR5bnDSRvLOyEDO?=
 =?us-ascii?Q?8TPVSxyjMbvR+RTzM7SFSxV0gC4k7e5QYSc5gpOfHHdFBfS7jtptpe/sNMQ8?=
 =?us-ascii?Q?Bdv92zNY5k5fnbHaLYmfWufQD8A7WEURNhzCF/Cv6b7mRHPp9/ZZ53xz1qUZ?=
 =?us-ascii?Q?+VgVZ/Pb+4iI1ez97wyZTuPKaE34jnDqkeJFOtkfGES6YjLgJS9p0W3fyc6P?=
 =?us-ascii?Q?Zm6i8NVwcIJis5AhAMfKcqaxPtmuJ+GjlrkUdZrrzAh95xNaiqgwG+uyH0Cf?=
 =?us-ascii?Q?1BleZ9WP9wWh4en3QB2UOJrQRpK3n/QRvqdIkH2mRIv67B3jD7fxrV7MmpB/?=
 =?us-ascii?Q?y4++/noeTfFsb72BsEGjNoctPCILVID6Qo8W8rd0Tzvt6GZAxnBDgpjgbWpq?=
 =?us-ascii?Q?DCWpcAFLIrrsTF3kV3dHjNodTyVKJhokl08Bt3NG6dWTcFLqyfJmTg8E9ezj?=
 =?us-ascii?Q?soRyfjj+pDU+Y7kA19DXG2Vs4vfQePi5inkO/ReQw9Z8BUgDT0GfPn3CVYs9?=
 =?us-ascii?Q?POTTPLZF3Zzr9r5rjagUP6V5QG6GrK4x7lrcbK5eXaSap2gTQDz/SVospwJX?=
 =?us-ascii?Q?vzZRwmeBt61F93wsNwL2Oi4qxIyQnPp7pEPxsSJZsxrPjDRdp2cYHBkjypL7?=
 =?us-ascii?Q?OoltcGRPukeopWTsfDJE4x2yPYcpbxmN5URXzyDJ004nFSh6FdfjGKl0XFdR?=
 =?us-ascii?Q?Gbo76y1OoMCK6Pc53CgVI6rUee+KDLjtZPHbLhXPoP66PoVBgTLE46m0B/wJ?=
 =?us-ascii?Q?9eKkGK0KNh//9eE99xJq8b3fZ1Z6QhVuAktXbv+4flLLQE5a3vAhUJVd56P4?=
 =?us-ascii?Q?luKfG8TcZt3HKavbCndyH/+h/VLmOX5uuJ+FUUtbFwklpyi/dvNIwlbtNNiZ?=
 =?us-ascii?Q?1MAAXBf6oemqOam9BUGM/u8Re+EQNCcREDdseTcA/vyR6mqUueB0WF4xwNTI?=
 =?us-ascii?Q?IMeBvyldimuhDodpSr2OAfuVd1Tg0J1swvBEYI7D7XmSKCh6G2YJU1gcU47i?=
 =?us-ascii?Q?f257gj3zT3RRF95vUwr2pHEchi77p3TWkHYUwD5jMvDgHxZJabdvrO3kENdt?=
 =?us-ascii?Q?PQ36LzhYyedwxTKF0Pc7MfYtupgGELeKFrJfkJxE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a5ab84-0ffb-4fc4-8b83-08dbc035440d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:12:01.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw1DaodyPNF3i3aazOKXUVVeBwkQeQAG72xq4F4lmheb97686S9ESlRyTmBBA5cbU0fwZT1+r9uyfYBWKNvg7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ben Ben-Ishay <benishay@nvidia.com>

After the ULP consumed the buffers of the offloaded request, it calls the
ddp_teardown op to release the NIC mapping for them and allow the NIC to
reuse the HW contexts associated with offloading this IO. We do a
fast/async un-mapping via UMR WQE. In this case, the ULP does holds off
with completing the request towards the upper/application layers until the
HW unmapping is done.

When the corresponding CQE is received, a notification is done via the
the teardown_done ddp callback advertised by the ULP in the ddp context.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 66 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index c87dca17d5c8..3c124f708afc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -52,6 +52,7 @@ enum mlx5e_icosq_wqe_type {
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE,
 	MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP,
 #endif
 };
@@ -230,6 +231,9 @@ struct mlx5e_icosq_wqe_info {
 		struct {
 			struct mlx5e_nvmeotcp_queue *queue;
 		} nvmeotcp_q;
+		struct {
+			struct mlx5e_nvmeotcp_queue_entry *entry;
+		} nvmeotcp_qe;
 #endif
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index ea7e4cc1bbed..fb38d1dee03f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -142,10 +142,11 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
 		       enum wqe_type klm_type)
 {
-	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
-		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
-	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
-		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 id = (klm_type == BSF_KLM_UMR) ?
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT) :
+		 queue->ccid_table[ccid].klm_mkey;
+	u8 opc_mod = (klm_type == BSF_KLM_UMR) ? MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS :
+		     MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR;
 	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
@@ -158,6 +159,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
 	cseg->general_id = cpu_to_be32(id);
 
+	if (!klm_entries) { /* this is invalidate */
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+		ucseg->flags = MLX5_UMR_INLINE;
+		mkc->status = MLX5_MKEY_STATUS_FREE;
+		return;
+	}
+
 	if (klm_type == KLM_UMR && !klm_offset) {
 		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
 					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
@@ -259,8 +267,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqebbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqebbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -272,6 +280,10 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP;
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE;
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+		break;
 	default:
 		/* cases where no further action is required upon completion, such as ddp setup */
 		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
@@ -290,7 +302,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u32
 	wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->crc_rx);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -307,7 +319,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u
 	wqebbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -330,7 +342,7 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, ccid, wqe_type);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
 			       klm_length, wqe_type);
 	sq->pc += wqebbs;
@@ -345,7 +357,10 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wq
 	struct mlx5e_icosq *sq = &queue->sq;
 	u32 klm_offset = 0, wqes, i;
 
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+	if (wqe_type == KLM_INV_UMR)
+		wqes = 1;
+	else
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
 
 	spin_lock_bh(&queue->sq_lock);
 
@@ -844,12 +859,43 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
 	complete(&queue->static_params_done);
 }
 
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi)
+{
+	struct mlx5e_nvmeotcp_queue_entry *q_entry = wi->nvmeotcp_qe.entry;
+	struct mlx5e_nvmeotcp_queue *queue = q_entry->queue;
+	struct mlx5_core_dev *mdev = queue->priv->mdev;
+	struct ulp_ddp_io *ddp = q_entry->ddp;
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl,
+		     q_entry->sgl_length, DMA_FROM_DEVICE);
+
+	q_entry->sgl_length = 0;
+
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->ddp_teardown_done)
+		ulp_ops->ddp_teardown_done(q_entry->ddp_ctx);
+}
+
 static void
 mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 			    struct sock *sk,
 			    struct ulp_ddp_io *ddp,
 			    void *ddp_ctx)
 {
+	struct mlx5e_nvmeotcp_queue_entry *q_entry;
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	q_entry  = &queue->ccid_table[ddp->command_id];
+	WARN_ONCE(q_entry->sgl_length == 0,
+		  "Invalidation of empty sgl (CID 0x%x, queue 0x%x)\n",
+		  ddp->command_id, queue->id);
+
+	q_entry->ddp_ctx = ddp_ctx;
+	q_entry->queue = queue;
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
 }
 
 static void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 555f3ed7e2e2..a5cfd9e31be7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -109,6 +109,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 87ad443e73f8..e1f8a87de638 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -951,6 +951,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 			break;
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
+		case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 			mlx5e_nvmeotcp_ctx_complete(wi);
 			break;
@@ -1056,6 +1059,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
 				break;
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+				mlx5e_nvmeotcp_ddp_inv_done(wi);
+				break;
 			case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 				mlx5e_nvmeotcp_ctx_complete(wi);
 				break;
-- 
2.34.1


