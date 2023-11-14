Return-Path: <netdev+bounces-47713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D197EB017
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06083B20ACB
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52AD3FB3B;
	Tue, 14 Nov 2023 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qn8Tuw0V"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CD3D99C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:44:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1B134
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/LQ+ECocK0fD/baYqCdYKNEFcjmb8oGT4+ZR1rXpFKEQGiUzrCMGZPU3ws3DpGK+dkcuUaW8GrDEokv1MlZufE879APbEruwDfE1ovKUakyVkIZGvRoX4Y/pq7FGEkcErZqbd5bACNxqg2uXK4a7GowElqqYLMgik1k5xbjQm7jq8P3f1oEuZg0a5lkcVezU/VFk9Xa9qfIaczw0tyeFEIglaQFPYbWC5UOjBOVk6Q9mtJFbLVd+YMh0CXbkVjjwJmQhgKr4Q0ppiQ/FZMnrFgqyO0K48fvh8lxMO4rmqdDjfBffe1dz2ldjV5pz6zjEXRatQBTljHKKi9hpX/I5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f9wo7q1N4LBRai4Nj2wbo6zIznzFZVgTLxXBbGDdbI=;
 b=GpErTMczA6i97KKvPv5ezC99s0Rx4hGhg0YGvVr/ut47e34J+4ipWR6BY1C8A2wv77AoC6W83f0JMKsfHYIDx3lJ76lXGydGduvADaJCF58uAKFHGaDhq25Ya1npML8+8zZvw17oJFytEg4nN4duZMNcXfnF4+VO+KuyWuw6fCTE2/2tyN7C0D+6Pg4UP/p/h7tEZ9PnE7i8CqPiiXds0EWV7blLmtcG5HK71O2Sm4mWxOzhy1pgNBdmOUCbeyBgSJyURh0ZGw97L44e6tErmZ9rbLEwlpR0VwvQ+8w3Kzbl9c50YswebWQKD8CmHeODv8tIHsh+DZgTwk11R8bt4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f9wo7q1N4LBRai4Nj2wbo6zIznzFZVgTLxXBbGDdbI=;
 b=Qn8Tuw0Vt13YDbl+UZBjnd0xXqFlaob6/fLHuNqvWqhZBXKUHJWX8tfmrzF5Q1jIa9EhkCA1TFf2Fr/2R7BWdMCY60x+cXDlo3X60Cb3bqs00/STGMP0RLCdY4YfCl4jhULe7ALHjw4+zqbvh0/HbbZ2z1Z5WXc4EdwndJ7kIPJAdJHlhh3wEh0sOlHHY5fnnC5XLttidZe0O+u37Rc9RMea4nXwMUpx3YCARv/9oIiPRTVkPn84WOrFA3bY4DHMGuWlXJKYEvZ5184F9mg2x3czEnyl11uj+4f3jwptjsomlEZzNeScnIz9BiHFw64q2Em8bLBlwyIuPOz5GilfQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:44:20 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:44:20 +0000
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
Subject: [PATCH v19 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Tue, 14 Nov 2023 12:42:49 +0000
Message-Id: <20231114124255.765473-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 800578d8-0cf9-429a-b583-08dbe50f6c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SG3XYENV2O0cYKK/QMl2dadRkvYpdKOf+z8lktoZNr91WmbiPUl4EmbyzWBAXICmi/TS+CuzAzSmSYYeUWjimZk4nwweHy+4tGkz313Erpjcb+HzbvG183V5PpJ9ebuBlcxeLLZKUwnNXfip0x5iqkhKfP816WbxMAJhUbt5C9gP0Jf/jt3LdTQKKKv9p+557XbGkyofZnv9U5QWs08eRUNnOWG5AEcAwYAgvpNAwBgIRTj2790uB9/0QflJT8sq+a+ZZ0VaUbB/NEBsx0LrjPySQCG7chuovYxRsu5vGAqrCARO6m3jxF+mkI6Z3F8qHGiVoXerlIb41M19nracv1Dp5/GuTcqK5M5cCBItXvwRzYQfh1W9rLq9kEvPDKqboAukoFPeRYXW3aSRu3zGUhjNulLdhtUDH4ig3GqwrG/AlkumaAQQ2fImMN5tR6oZgvlwEuYQ9RPYSkuO2RkEh/WKCXJFz5pKsqk1JBQpYfrHuKgkx7uS1/jRm1SWreu4orMEYB5gq2UMYI11v5i+UKJHT5QKm5dUE9aoLpoJx+GqIiaUH0OVNMEM9wfNRqvC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(1076003)(107886003)(6506007)(6666004)(2616005)(6512007)(83380400001)(8936002)(4326008)(5660300002)(7416002)(41300700001)(8676002)(2906002)(6486002)(478600001)(316002)(66556008)(66946007)(66476007)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OiSb7d4iPZyFXolCXzIt3KaFX3yay/sdVlnDJllhOW0OIA2Ru04YVuhHM2dU?=
 =?us-ascii?Q?CC63SGf/PtzEINmKs2v03ry4vLzwVZ0oj0+C0/4A0VsuZV5smYfQo058u5CG?=
 =?us-ascii?Q?65sjpkvPUXUjz3WzsOWBOLaSePuM4+lCKteo9SJtSMHnxjaXDmlTkH5fl1wf?=
 =?us-ascii?Q?0eBFIb+KOdu1VmjBJe5I0ETBVTOySrITUsNRD/q4yzDQZuJVLvd2o/08F5DA?=
 =?us-ascii?Q?K++dfQig/EeaUGOVKsgq61WM8utCC6P3ngoTXd7pWVVSn1vrq6SnwVYFGOBZ?=
 =?us-ascii?Q?iiRMO3PtWGHlPRcLTL+Au67Fv+vkm5qZtEo8bPCt0yksoQ6HYAUuqAwWP7gG?=
 =?us-ascii?Q?+knYCARfQ5U29kZhp3npRh+6KSSMwAT4XbV9wyUzbvA7dGl8yjIZXv/5QOHh?=
 =?us-ascii?Q?63yfWqu9r5hP/Kh0BWJf7KWoWR2kcBmp+ryq9lQsRZFTnGmoNWbhu/iqc6D+?=
 =?us-ascii?Q?gnybdXG3J4hQY8NKQwgKQahJ9PsH+pL1d56oev73LEJ2K0uxWeX1DAMc0zj4?=
 =?us-ascii?Q?uDE/SvE8925FOoRiN6/2b5MELVNdj1vSUxGOhbWnGgxVDxqIFcnQz6Gx78ti?=
 =?us-ascii?Q?5VblE09FOwxgUi8/ocMSxY7lJGoMYyUF7+R0o5miQGK3FWHjR7+2khqA1eKW?=
 =?us-ascii?Q?qD6gSE89NUQHMWRmtyGmA9S7675omfXcOslhRfMPf6doUafDkB5vVPEF9Ulo?=
 =?us-ascii?Q?dd8MneMdWhslDaoEymsSc8iNmFue8h9kO4peOZP4FzDFQwQS6fnQekfYFCFZ?=
 =?us-ascii?Q?iY9LWKmCqnaYHzcWWSw1Uo2iPh1numepOeAgvO9FIc827mIqJosY0MvQVKGm?=
 =?us-ascii?Q?3Zsgnwrr6xHQWK5H+5zkyQbKzvzjax1ON6n4Bl7JRbAQZ5eUxAujJbZV8t+6?=
 =?us-ascii?Q?RZdlKGBZpQbCElUWWCTwuAKUwXfionL5yz32YfSua1QDzxCleEkAe3LZDMwv?=
 =?us-ascii?Q?tf22jXLZ9U2yQOzjwmtzGLm1sc1hcLKEbuzC+nrtvZEEtLOAjWhzA55kTcjq?=
 =?us-ascii?Q?6rwG58RZbE55wwOFLh3I+lzSc6UKrjg2yBq4H/JaKisFpCvfD/Ball7m3hoZ?=
 =?us-ascii?Q?2CdU7fJ/NHkOtxQQiqeq9QcPRIpDvNkB9TIcJI1EH92UEqTZt+vh9CLMusA4?=
 =?us-ascii?Q?Fk4kLaPDGIRA/+hPvcH+oBzsEmPvrNOFeNpETj/wfRNhprQJ124tayBnLPY/?=
 =?us-ascii?Q?j2p4mzei8oX+9FlyPs3Om+lBX+uhFx56WLy3PyT3dcGE+i46filpx9jXYBnV?=
 =?us-ascii?Q?WxZAbK1Zz08kubay08YirRW2b/enlmBizym+cmhdp92iYr5lnwJ4NHy17EMW?=
 =?us-ascii?Q?j0CNi4nZqxPtXNuz3f0Gj0oGxsYEw6U4J7+CXh/Qtr3LQJZkA47zx4MRChos?=
 =?us-ascii?Q?Ic8UgX3ObP9/1D8TaoCT6l3JtCUuw+SJWkUDHzkjZKeicXU+43AZIew49Ac0?=
 =?us-ascii?Q?j/4JOkvAf31cA8DmiZeqqoV4ybOp7Vk1aWHuWWQ+7QZqAnx1DucR44EBwNKj?=
 =?us-ascii?Q?P6zOchKxDmeNsRhgkX3LB7mjwaYmfic3+BFj2tTdH9H0DK6VU9nd0OS2gAs4?=
 =?us-ascii?Q?hYi/yLP9v41NZ3mqQSijYorpulDbdToffpIuBgHx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800578d8-0cf9-429a-b583-08dbe50f6c3d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:44:20.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ub0urmiIs3WrKvgGieLxuZnTsSbwrVF8XLjWk0cU/difNzNLW/X6eM/LmsJqh8sqAbMmPwRWRfPD+vOKSxbFTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for ddp operation.
Every request comprises from SG list that might consist from elements
with multiple combination sizes, thus the appropriate way to perform
buffer registration is with KLM UMRs.

UMR stands for user-mode memory registration, it is a mechanism to alter
address translation properties of MKEY by posting WorkQueueElement
aka WQE on send queue.

MKEY stands for memory key, MKEY are used to describe a region in memory
that can be later used by HW.

KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
enables to map multiple memory spaces with different sizes in unified MKEY.
KLM UMR is a UMR that use to update a KLM_MKEY.

Nothing needs to be done on memory registration completion and this
notification is expensive so we add a wrapper to be able to ring the
doorbell without generating any.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 ++-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 123 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 4 files changed, 165 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index cdd7fbf218ae..294fdcdb0f6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -50,6 +50,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -256,10 +259,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -273,6 +276,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 8f99534430f0..a9392f88bef5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
 #include "en/txrx.h"
 
@@ -19,6 +20,120 @@ static const struct rhashtable_params rhash_queues = {
 	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
 };
 
+static void
+fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe, u16 ccid,
+		      u32 klm_entries, u16 klm_offset)
+{
+	struct scatterlist *sgl_mkey;
+	u32 lkey, i;
+
+	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
+	for (i = 0; i < klm_entries; i++) {
+		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
+		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
+		wqe->inline_klms[i].key = cpu_to_be32(lkey);
+		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
+	}
+
+	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT); i++) {
+		wqe->inline_klms[i].bcount = 0;
+		wqe->inline_klms[i].key = 0;
+		wqe->inline_klms[i].va = 0;
+	}
+}
+
+static void
+build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe,
+		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
+		       enum wqe_type klm_type)
+{
+	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
+	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
+	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
+	struct mlx5_mkey_seg *mkc = &wqe->mkc;
+	u32 sqn = queue->sq.sqn;
+	u16 pc = queue->sq.pc;
+
+	cseg->opmod_idx_opcode = cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+					     MLX5_OPCODE_UMR | (opc_mod) << 24);
+	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
+	cseg->general_id = cpu_to_be32(id);
+
+	if (klm_type == KLM_UMR && !klm_offset) {
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
+					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
+		mkc->xlt_oct_size = cpu_to_be32(ALIGN(len, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
+	}
+
+	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
+	ucseg->xlt_octowords = cpu_to_be16(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	ucseg->xlt_offset = cpu_to_be16(klm_offset);
+	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
+}
+
+static void
+mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
+{
+	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
+
+	memset(wi, 0, sizeof(*wi));
+
+	wi->num_wqebbs = wqebbs;
+	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
+}
+
+static u32
+post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+	     enum wqe_type wqe_type,
+	     u16 ccid,
+	     u32 klm_length,
+	     u32 klm_offset)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 wqebbs, cur_klm_entries;
+	struct mlx5e_umr_wqe *wqe;
+	u16 pi, wqe_sz;
+
+	cur_klm_entries = min_t(int, queue->max_klms_per_wqe, klm_length - klm_offset);
+	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
+	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
+	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
+	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
+	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
+			       klm_length, wqe_type);
+	sq->pc += wqebbs;
+	sq->doorbell_cseg = &wqe->ctrl;
+	return cur_klm_entries;
+}
+
+static void
+mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wqe_type,
+			    u16 ccid, u32 klm_length)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 klm_offset = 0, wqes, i;
+
+	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+
+	spin_lock_bh(&queue->sq_lock);
+
+	for (i = 0; i < wqes; i++)
+		klm_offset += post_klm_wqe(queue, wqe_type, ccid, klm_length, klm_offset);
+
+	if (wqe_type == KLM_UMR) /* not asking for completion on ddp_setup UMRs */
+		__mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg, 0);
+	else
+		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg);
+
+	spin_unlock_bh(&queue->sq_lock);
+}
+
 static int
 mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
 			      struct ulp_ddp_limits *limits)
@@ -45,6 +160,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk),
+			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	/* Placeholder - map_sg and initializing the count */
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
new file mode 100644
index 000000000000..6ef92679c5d0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_UTILS_H__
+#define __MLX5E_NVMEOTCP_UTILS_H__
+
+#include "en.h"
+
+#define MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi) \
+	((struct mlx5e_umr_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_umr_wqe)))
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_PROGRESS_PARAMS 0x4
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
+
+enum wqe_type {
+	KLM_UMR,
+	BSF_KLM_UMR,
+	SET_PSV_UMR,
+	BSF_UMR,
+	KLM_INV_UMR,
+};
+
+#endif /* __MLX5E_NVMEOTCP_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index addf8905fc35..204a8137c1a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1061,6 +1061,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 			case MLX5E_ICOSQ_WQE_GET_PSV_TLS:
 				mlx5e_ktls_handle_get_psv_completion(wi, sq);
 				break;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
+				break;
 #endif
 			default:
 				netdev_WARN_ONCE(cq->netdev,
-- 
2.34.1


