Return-Path: <netdev+bounces-29681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC094784519
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A10280E16
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82191DDF8;
	Tue, 22 Aug 2023 15:07:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528F1DA25
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:07:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23084126
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn1RsRnNL6l5kjIb5sX9vghFBfWOBmtaquN7lmZAMxljL9U3zhl1MrFKyA2DRNzb+iQgAKaPX+9gL7PHFXFNjMzExqtBewK/p4sUyutDpKkqRFD+XJPp5f4Lpldd+V6RryaJZHmDYp7r5b55N5FbqIb2xS6g7C/99qZscJ3WyCvGDsJBceLyVKdUjw70BnChkWuBW/yTjaCoWNiHnzjZNdqgF0UVNyN7j47AE9tv6qV6WTShEdcscOBeKvh1AO6NabjaXMPaKHq/g4bZgTEdBFDv9VTLG8vuzTBVsf8brt/RVffjwKp9YHZD8NdTRGtbPH9yIHi325Qw8IvJ5HPTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aviAbnfTC1zJEeH5GytM4MKZjJ/MmS2ecBDSMux3OE=;
 b=dUZL9F6gXVnQmojh+d/psCEYDe6udII9ODkpe2z3AG5OWMhh+nR/C3+4Brt5hZG5B8Kjjggg7KvoaVFdJYiIBiPfA1F4Se5y/kp8rd+S4RYxHma6i1glTbuQdBKbcAk+kIPmYVAhMLY6LRnFl1pneMx+4Av0GfFXaeqq0rOFvk8x28fJtIGQVRrUPDqmFYeeRLWuhgeLOy0lufFZMI5jbwvvkN5z4NERWHs4QVyBcMwa/gYj3noSubxDmQfZvMebk5S8uExPWdouTFWnkUwlodXDpcFe85ajaq/FikSgMH9eEHn0BC1bbKbNKDY5LsMtiC3PHhxtYj4gk54UBX7J5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aviAbnfTC1zJEeH5GytM4MKZjJ/MmS2ecBDSMux3OE=;
 b=HoMY24ygRgzeVQ3+vCJXF0OOcWCdgdEfuQ9IkJLvhx4dtzeo76Cp46bg5xvSdqxjdDeQktCjkHUsRErcMzmCrjlUpJySUqkxEUJE6PjML1C3CXzS5VGrXzWZ/KUNeRLSyN8DV+3Xhl9Ygpw9RxKhuK6RhepNSFRhUxczOlcfVM1ZbAQO312nw7RyC5W1Z1w7Yq9PFmpFSaRfBm2r1JlToYAI1qmO5QRTNaJwG+qgYBSsOE0hasLNvgX6se++aE2RE1LQ3XZa1ZmraToQ9A18Pba6uRgmePpQN1zKaWoel4Rs6UK/4/dlMVnBOxGPSZ7k0R23eHfyME2A0zOBbHp9MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:07:04 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:07:03 +0000
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
Subject: [PATCH v13 22/24] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Tue, 22 Aug 2023 15:04:23 +0000
Message-Id: <20230822150425.3390-23-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: d7461b85-e927-4cda-64b5-08dba3217177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oq3E1Ghwr/J3UID1+fkQTxDL/4F1o89sAXvoGgmdFc29YSL1CeVe16bUjfrPkgT0FpRBbg3qolZrwPeLJ+g97xuUGkLGoLrMY9Eitinbg4uw3mqCT1CH7uBNV3hP69//dSmCdAa33GsliqpcOp2UiN/V6csPRxWnmYb1pErIhFIA+kUGsMIOmEYIWt11KCqVtvPrtaXuVvMeQVXlc4JgEF8P/S/Oxuf2mkhuKPshAYZWjj2NP+jtYS/WUjaZO+t9ncBJyiKCnUzpcDnP7uWqnz7WKluuSvtYJZPPSxrLUGlbRIccjetmokd9HrsK0o8f8FbMFcfhrEfT1foN5/lmttkDkRFuhVsLr9EaflN4hCVzAUv7zVtcq1Dgq4GJn93T4Qgf2o1DAtMJdQGGRLFhPaGbjWVNpKhNEWW+b9DzPYynHZ4xxedCuVr0g6LYRy1DBi0fYuoZWPimI+Wm9YtMLvq+40ibaTH3x6v6e+EcYuF/QpZz+rfjzx6Rc7nyp4S4nDgjc6BEGjuL5ItH42y0STk9at4qGkUvFf0dlNFtDrKqQv/i7eOi+mML1Jic8Lbm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xXxTk8tFWlsHUcV1AmJY/4bo2owzG8eDDYzCXr+LJV9iHa0RXoIPVo87a/UV?=
 =?us-ascii?Q?A1v8P0kgcpMx9LHf9bcwrqEOGX6RwkxE8/pxUmDQ1BO8xWKpP8ZTZHmXZb6N?=
 =?us-ascii?Q?JkNIDubtGyjoAMDez34N688rTq17MPqxqtDZu9r0b7Dp35VwLLHxxTIWhtOq?=
 =?us-ascii?Q?xfwr+yDdFzC/sz4BkqqAvLO6RKAgzGi0LSjHGAXcSSP4d0Do3PbhaomHC5oY?=
 =?us-ascii?Q?MnQzptsEFL4ViUrUAc1oOHFtlZixQ7rUrNTilcXS6fwehb3S9UD+XsZEYOeL?=
 =?us-ascii?Q?Z0CN4+c+Xu9vFGhqPwxN4YzPWXw0GjrYFnZEaWFk+LIh6fUKc4WkRvoQEqln?=
 =?us-ascii?Q?gIyssbUWNjlpE7Cb+DgBdke+/MiChPkTnUTdoOiLvBMYb/1Wr97SiplrKtUi?=
 =?us-ascii?Q?2TMHfVaLRBqUdPnNK7mMOwpObf/ltvnUeU1AX7wdDFIDThTxJLKAAjYcRGM1?=
 =?us-ascii?Q?KMg+JTjYosKwa7H/PguT3nRGi430qDT31tVg3VpRpyQ7evVP5JfoT4+EwgE8?=
 =?us-ascii?Q?8Tf+UtzP1OXKlwWkkbdFXxOCj0SomLpsCIywg5+i9D8bfZ1BgivPtnikB+Kg?=
 =?us-ascii?Q?zMBKQ2eN3S1660giqRu104iliNT33ZdnEVrlIobJ8YQ6YMLrTcgFNvj7r7Sr?=
 =?us-ascii?Q?VUkuL7TgsCQKJ6hT9mNiTxv2uVQ28H3QO6cNAe8miiit1sUt2l/1v7oas9ND?=
 =?us-ascii?Q?Uljb+YzBlPlT/KjkCtiVlkKqJZkAGl2Dl1YGC6ZAcKYl4NlytQTLoa+FlwYx?=
 =?us-ascii?Q?6wzWmgdSBL+M7qXZxK0zdq45aq8yWtX6TMae9MBoA9pwdxMY9j02Ikaq25A+?=
 =?us-ascii?Q?t81HXXaF/NpQAYYo0P5PzGtd4TiO4cUVnrqBmGqKtClcaRLaV1TB20GFF6PF?=
 =?us-ascii?Q?QkYOkWbrSgo1mcdXMgirV5Etsmj/V8nrimN7yKFu/UGKnfrODZLTB95CC/fo?=
 =?us-ascii?Q?cKuFHRueRjzg4KP0hYgGcC6WTZ875l+zscaIekGqSvO5nZoa5KNkAJa9lvNI?=
 =?us-ascii?Q?9bxDqSRW2+80DJvsMkwgt7zdxBUOmMLtfBaIHTbM4nCBWtCa5utu4FC/AlvT?=
 =?us-ascii?Q?ZQZemoXpiv+d5tyWaaEk+eYAXGN6GSdBIVk46oroLJvuDNaVLIcZTR08S9zn?=
 =?us-ascii?Q?R/l+iQtLV+XMWvB/b5wf7uaTeRrJ4+Cr8tPI/60s+1/g3Ypb8AEA84S514+u?=
 =?us-ascii?Q?eAu39sLlIcalt5Dm9HxzXNZwn+UQNRzJuiA7dZSdPRHWzktpS5ZNWnodMp/F?=
 =?us-ascii?Q?y7r46CfDfaSdrIICal0P9CELMm6iELENK2lTh3FCjYvfw4Hx9VFOqtp0vpMK?=
 =?us-ascii?Q?sbPn/BFqfLGnv5lMup0HPDmtFrj1kVbb8UOMbwx3LiZ559tfyDT82SKAEbRA?=
 =?us-ascii?Q?dKPNelHTpaTytcNTx0DutDuBm7vD8KHXsukf3xzKJ2yfzNIIW+Vg09Z7KGEB?=
 =?us-ascii?Q?gLD82dk5i1os9U2ZeE3BfHV8gzhocec/Z7OwpSDsBVgi9g2Bfcoi9P5JXXB6?=
 =?us-ascii?Q?T1LjQQGCg6EsEzzI/AJnQyEMYfikDsPTBjZz59XYZBYfU+lUdTeAGWNEiPBz?=
 =?us-ascii?Q?wh5azy1wYuHUrJqWUBWSZMn2J93og0lte3mcEqWF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7461b85-e927-4cda-64b5-08dba3217177
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:07:03.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r6Y4L1dDb9FnYRHvKXUS9YtrE89p6iPHBWSehRWlrN5Bhl8NsZYIkZIj2TqiSUFNrWsrCizWBK9tsKfl5kGKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 8f9af0f2fb1f..c5bfc1578ddf 100644
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
 
@@ -843,12 +858,43 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
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


