Return-Path: <netdev+bounces-59780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455D81C048
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED751F212E2
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B376DD6;
	Thu, 21 Dec 2023 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bEiI4zNX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55463501
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/6gqW4RghTQF/1dogyAiHeWeTP/+xGJqvCkxECmUJBv0Tv0mXLFLS4mwgSwzch4DL0V7jPmm4/gI+CtW6HGPch/qr2iGAHfdylZ6Jou8+dJ3e7FlZgC5sf5eIjXdH11WWBlBG2LCgPBSyGuUmK997sMrZqXmkKzLZRqI1ZQ2sgWoea4ADiWG8RGAhMC31E6Da9sDDRYo8Z7707Z2XLDCujWluiD5aC0xvdbz8dbhrbyf5lU3ObxC9qVDlAnLCRgeeIxLQ9YC94xhbsLzg+Y7KBF+FN0OT91f20tl9ehujC1b7kbntYztTa1rH3IQ0Ny5XNn2pjVTDILQKZEER46dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOlZDxSyHsLEZF97yXuUaM5RscokUivVILbVgtgH0yI=;
 b=gLiVPK2/YHr/YyUPvQAh3Lvnvf9chKbNNMLMkyCnn4KxCvqg7qrTHiiHY+LpM6LzPQH+PucJ0PspPTKUOsBAbvPq17j2UkfX823Lqaazj4DyqZDDEOQeWR9qsZ7QMkkAXcNonPBbuGl34bvBobixnbLvsxhx6/uvNtaMLugphEWY1XR84YP6TCV23OUHFHdPPkaYPxqLcVdttmdO+sTbrMTxGv/LVruOSq/eGIpqaPDSRFQLPAUj1FsXuHaDa76AbHSI95Y0HQKRqs41yVPMQ9F1qZ5w+1Osfj3zheyswoiSQV1bnQ2jiSBr4LgE9JK59/ZtLDudrHN3yJu4dprEXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOlZDxSyHsLEZF97yXuUaM5RscokUivVILbVgtgH0yI=;
 b=bEiI4zNXPxCpWiBkRbWrUEnRWjTI2k3meziH1wwGQl7w6A+I+2SJluoSu/i/ne5BfrEVoyHtQv8tJ5CA+z8KX0QZL1K79mmXkDpvbJjlMiAG58NAHfxYsOeBqi1lqrjHDJ0zo3zs0cLOxP91p6+/BjFnwcma4bB/9ampr+mjzlYuPHe+B+TE/uhmAf10GJr26X0fvtUXAyc/P3z1HeivNqCcaTGVps9oNT9TldJCB5IijLm9cE3OpBLShLsyBGDZvkyzFFQge4EebWrrQ9ezQApFMPGp4FMTlcIvdgd3wqCFFDpSfG22Wla272hmL3Rb7psiHz7SwDVe3aZeyyf2dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:35:34 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:35:33 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v22 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Thu, 21 Dec 2023 21:33:56 +0000
Message-Id: <20231221213358.105704-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: e0923194-4a7f-40aa-94c2-08dc026cc365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WvEyQYaRBjhx2/RdJRGTq6AM4PraLacGhUdJSCxp3ryxSsWDJpxukktwqrXFnyE6xrwLD00GUbcHk7DEfYg+9jQciySzIuV6Tl2GFrflSYthidXzUoqXaxGQQdUNpuXlXZXUWi1XhbFyyfiKVhNUbBQLOWm1JgoKuPJDosoPzIKlAMczzJikf5ukiNlIWBotPL2AWf48cYwNxnbXdgvNn4dThQdh9ulEw9d1QzeoTcqzHm9hlhT/RirCm+83I0/qvRcG45ut96XZM+QuIPdc/Orpn0WzxSaemYxEVSJfaiAVjLWB3Jszim+U1HW92Ib/3oCujuhthhZxgvOPJ6d1cO5vZ34lNuJC/LiXVlB6LcV2kw+1UZAK/x+BsRgQ/VuXzNmKy7o68PICMgTf3bVIxnRFWLXzW9v8svy/cppKDNIK+y8cIzgXr4w5qY7pOd1V5iiRUAUYhvX+s4+xVXxEQHPSTSeD7bKQ8CPrtBDevIbBUZIfoGwUtSDkm1FOedbu40qFidgpAF5iVTkZOqrWv2fl/bEQyG1BD5piK62U4Sh5aNkB+Y/YzE0/6U4/rIbTaGSjnUKFpvYQAeMLHSCYMFVyQ+bCrFiW+qxwZDtrzOM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(6666004)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AnXNIA3w4NDsx2N9yb3m4Xn6WphX5ipaiUyzob2LEvGZl6fqk+WqIGCL75id?=
 =?us-ascii?Q?d8H1yh7OCJs/bC7yWkD8VAisac1DoRHuEmiavnbmGHEPqOtVxRFRMvglHQF3?=
 =?us-ascii?Q?xYQIvgZmcv48VOSYmUriEdjV0PpFVUKAVhxFDbQbSeelWZDDzOvpmOA/9V2n?=
 =?us-ascii?Q?Ec/Ir/4o9sDR6dR6hVfe/2qHEn4yATM7+i/Fv/7PWwDz7JXMWOj8oFikKU1U?=
 =?us-ascii?Q?4LH7uNoQGc42WNcizb9gbvNDOEK5UZ8pB2xjItn6apWxChvk4kmG4nuO6LIb?=
 =?us-ascii?Q?QF1Sq+bxJRXt6qizti8GkaOSxxJMgUAgRQH60YYCkzHJC2t1LNUxSU6yc5dz?=
 =?us-ascii?Q?wH/EAStjvNedYrJ/gWWR+vCoCGkmOI2i1mC8pwYb+qSXkxKvDOfCSNB+la//?=
 =?us-ascii?Q?loBoSkZAxAHQ/84vos3iYA28ez3QcSIw5BRKbEWW5UWKZzLQ1V1Q4D348pur?=
 =?us-ascii?Q?36Yi0y48kEytdCUyf3QWAVLU4DKroXeiAslnuPn4c+yjVNaJdMD+RKrTWBVs?=
 =?us-ascii?Q?l9P6Zfj5hBfQYOCUQ8XJLd+HOTBbTC2vQbmbFPfGepcLI+Gz5lU8NCKHapqg?=
 =?us-ascii?Q?XU44Cju5ElQhZpBFW4SjcXosiz9WIfPxjKpfmvIvRb5mUcJm+igQRW3eqpTl?=
 =?us-ascii?Q?JVwhY5JbzM9AikPuUB/bEcSGowGRG+dSKAkjs7KBzwZqnP5nynkq8ck4zZ+N?=
 =?us-ascii?Q?uH30jPNVtW+JKvGiix1fcQ3NKulLD5x15sRf7mANF/mBV7fbAbZcxjjC3eJE?=
 =?us-ascii?Q?eKThkn0oYn++A1C/Auqovze08AmXSsWHmPfNMFDm1bYiPF0vJ8xIhKPCMFrl?=
 =?us-ascii?Q?vmQzTe3tejOY/EoYpGMqJJpx76cp+ugOw8ql+GgpsphhJIofbtoheSctuoKd?=
 =?us-ascii?Q?vv8QYab1m9P7pSbxdS9hqGVhQL64uHHJmyTUhJ1TywWKeoXu/+560fHSmA0o?=
 =?us-ascii?Q?OXRsTTDJOyjbjNYnsOyky3Fp1qkv7c5SkyGv94MZHqzpxJ9XkOQT0tIMTbLb?=
 =?us-ascii?Q?bfR2blysXiGgSAbAmSj96XABbm9SuqM8cw7MXScxH1Y9TXhXEtk0L8c9koFs?=
 =?us-ascii?Q?6mcvToDpETlPQ4jJe98mnoNV2TPYlXBndRq9FJthN3EKEeJI+PyNgCPvxd1q?=
 =?us-ascii?Q?LsblHvsvWtKZ71wqN8iXcpuO4LgOJtP+UCq220Z3R2Ay2XMzwsEnn+AjYeRo?=
 =?us-ascii?Q?59NZtVry6b7gIR4LUWG1rPxwa4ZSAiv3ylLBeHAlO7ll2VheoHxir0vl3BvL?=
 =?us-ascii?Q?lcfW7Ux/Ye+cKREBOmA/E/AI5IygWBYzg5hZ0fRl70+9tfbcyBIZPnoPabOz?=
 =?us-ascii?Q?6QBduPPLB4fRtS3IdZzF6VWw5wtd2FDv7UiMILU4bKJ5g4oJm3XnUXdoCaMo?=
 =?us-ascii?Q?RIoji+xXY1n8ujvMAQxIMSOhQlZvwQvjYPg6eDNYBvISHLZd3/cw1vfnGl9r?=
 =?us-ascii?Q?n7RKg7jD4gEzRz5InFioOU5dq9hmVutuoM1U7xywqF54y+hP+mM8iFKpZUBH?=
 =?us-ascii?Q?ql91u7rq1PvlmNSvsZ3uL7De5mPKyNkQoxW3uG+wIGp16YhtS6z/yXSOpHy2?=
 =?us-ascii?Q?NPCdbg2zhlY/N/hqhKLgrBwiPnxnGXGU3QnQ+vo7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0923194-4a7f-40aa-94c2-08dc026cc365
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:35:33.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pIWvsPn+WzqWjpf0FovaB1WyJ3nvD2fTmTVar8bIiuxMs2BCoH4YFsjT/UcL2eDy2Wix+o68dOn7d2JGxf2OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

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
index 8644021b8996..462e0d97f82c 100644
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
index 8b29f3fde7f2..13817d8a0aae 100644
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
index 1ed206b9d189..b0dabb349b7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -968,6 +968,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 			break;
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
+		case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 			mlx5e_nvmeotcp_ctx_complete(wi);
 			break;
@@ -1073,6 +1076,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
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


