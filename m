Return-Path: <netdev+bounces-32255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1BF793B80
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C92281383
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C2107BF;
	Wed,  6 Sep 2023 11:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967B107A8
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:33:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BFD199A
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IshgC9zzj0odr45HRZehQY6vOpJltUseqkh9X4VFWYEIMYK9PGhoZLhAKZcSmXi0JbAVf4KS5/s5h4Kap8FqCjfW5ekEFuC/WdOsM4L3y347j1b1T1eEat55U55X5JSa34oPAYGmJqpUnzuH855PghmfUcbuJrO6KOavOHGoVFA7B5bu2GjJJyrbK89h65vl2BexAxpNy3SQ8DrLz/kOheeld3sx1sm+clHNuGvcZDY1apx2CZ8nFo0i+NnICjFYxKmiWdkK4DSNIXcEBs3iT/29EkJ5tgzWH7Bkudm63znFEBKQ/XaMTlGDMexZHDpCuTq9hO98CjT8bZh6IHYtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FJ6swElhY/KLgASUCSQfvh1NeOvyOaxqsmIatDJKq0=;
 b=Cq4ysKc3XrN93XgQH/Z1iEVDI8y4qFzzrx8W3yX48P9mveZkNNQ9Y9Apppv/fTvbNTO2iZzOsIFg71PAUrUtx44FgEph833pzRamGv/2K9URF5pfxzffJKdInDsaG+Dt2vOKlgAw7fs8CLjAZgSBsUJNXu4M9iy7anhhZVpp8uV5xhtCpw5m//L+WvY//uhpTbwoHUz3mad51gom8IFNacFWRYrtef1wCOFYByXqb3ueBzwDyMzKROPWUAtvWjNwa4blDXWgf+e5dXQKHRZ8vdVsl3ANvx3ysZDpzg7JbO9qU/je6d/l9sMMg/ZgvsfSKWN1F4vqjgHJCdSzjFKJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FJ6swElhY/KLgASUCSQfvh1NeOvyOaxqsmIatDJKq0=;
 b=aAaTiJtDi7tUg2ubFULlitAauWXsiLDRa3ie6R2QkJX1K2DxhAoft+tGtPfbviZ+dGoTzH+AuiuDMPhgGaagtB/Ffdn+jAIj9saSJ0rf+vzZlrZUH6G8xoZPkdsAqy4IEke/yySDfzhNbUVTS0+hKQbS1gJwUOgGMQYc3crWjIqb3XizvxHhyys5FClDp3ZRhRsXnLP7D3E/ImD/L4Yb+sp5E8e6Hl1eAAm2aMYML1w+vUp+oWpmoo0k846n9tYj62da1RB9IkD4bd+Z2UgEcvmNF3vu1TG9o4uBTJ4rsUStUWGCW+3ty4Ig+1ejHUfbsfXkQh332/AQ8OhgnzkcMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:32:12 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:32:11 +0000
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
Subject: [PATCH v14 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Wed,  6 Sep 2023 11:30:13 +0000
Message-Id: <20230906113018.2856-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d574a3b-32d6-4c5a-387f-08dbaecce969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BVknRrYYfp6G4bqcyeN8JMx2TzER36jTxhYIH/iVdh6FmtzmC0Neawk37D7kQeQ0Lrg/MmfL6oMJNRURJV48kDSZLxchN3zNQWJi36jScZNS9/u8BH5kvsEVttnmJFQ88As0CnAH5hxmtbtbW153hEEhKAiBb9IldHN6cwEBHdb4gdZYGr2VL55GlROu1cyy3uzn07PqQmtEdGgzzjbE4p+OCLCzHI2zJXEg5yviUn68IKvzER+rbw5nPwwe3+MrvHdSwQqAQ6OQjMnF06vNYXFYDKExj197O08ckWlbOD5LpG1v+PSUm0Aitg09Ly51DBjQVN0K/OA8mDmDPzCHvJl7cxVuzBs2RVNiLDDdqQ5aOSRddM3bi9jklGqhkAC4TTIokU3ftGBlCuCQo1SjChcAupVMVp4mMUqAeCIGLjFNEhYfw/kLlSqmeZs3n7Jrqs+NYXXEnDUUNZieLXJ1F7575y1too0wAghVpFiT/P2km+1KabPncxs0sPcCMquPk51Ze7VygZcc8XK0AmUZ7KDRsVDLAPlSwoPXtdq+K6v20WTWkIkJ9DN6dFgDvcNj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(6486002)(6506007)(36756003)(86362001)(38100700002)(107886003)(1076003)(2616005)(2906002)(26005)(6512007)(83380400001)(478600001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(7416002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LpyC5WqUqyPQxjmFqIORHZ5LoaawKQziNQWUmCxVyVq0fUdBNtW3XlZn92m9?=
 =?us-ascii?Q?YuKh3kIVTdv7sq05ga8cpy/7B7qaBx3OxclUwnzDfD/gSNsVLMUH5RyVC2rS?=
 =?us-ascii?Q?TIFkVVE+yAEmjynJQr/6ALFaQbir/6ffDG+pNMJrqpkxO0+Y0YzCx5kY2jq5?=
 =?us-ascii?Q?pbzBl9K0PNmV7VAvbk/+hY418+3xpinWe9LRSe/ruGx4E6R81xQkUZDaQKdK?=
 =?us-ascii?Q?aTuXihV3m5A7oomsRGIlzcWNKs5YPUviNQwu3OWNP5Q3XanKdltfsEOqvkhM?=
 =?us-ascii?Q?fIrSYI00JFpZxDsRdp61DFKhVO+7zAW6JgUFEtL4SwCo4IlF78qI8lXASEzX?=
 =?us-ascii?Q?B09IkxNXxhjHI7JQciBjy50+n4OU9m7uaFTSi2uGJ6IBMqgmke+AYE/Rr2iL?=
 =?us-ascii?Q?s01UCQmEvAxskNZzdx2fgkQ39EmEp0hTRuNc2cwGHDgF4NBcSrojBITyZgF1?=
 =?us-ascii?Q?W6mX4xTjFG9Yn6Pj7qfbYb1oR1z2ZiQpNKIkvyBKz8vyrWs+ljqMLxp9j+zl?=
 =?us-ascii?Q?ZTlCBEbWNBc/vwlP8p9RbsKStKDZ7Ro41evheMq3wszEu/sW/MRQ0TFjwkYl?=
 =?us-ascii?Q?YtQaCr9hM09SpDAHQjFpnn4cVaef6/iuSsLOsYBZ22o8PbD5qOlXM1vXKCvA?=
 =?us-ascii?Q?RCKPkbvFHT+TaNpktmkDXYqz4aFKhSM+/Eh7sYUhDnrh5BX1uZtnO7MbClz5?=
 =?us-ascii?Q?be8h+xsZ8j2daX3IhtYtAdL0ERIOr94Lzaz2uLjKgIZ4CEr3Z/R6Qg6kVd1x?=
 =?us-ascii?Q?kvImJ6vuWDphfB8KUm+lAgybSiP22+N6XWRanN+YcreRbEN6Xgtvm8KGHSvv?=
 =?us-ascii?Q?dxbx5+R5JGG6BNbsJ3zv0/ht62IWvmlk7KYzeqT0y/2oDc3n7Eezwu0hWsyg?=
 =?us-ascii?Q?vPUz/f90jgvdq5gKaOWVgHVP+kDyKc6gLCwcXpxqyIQXOraUe+7pE784BRuE?=
 =?us-ascii?Q?CD73yZXJH1IuuuaEDn+WCEc4Nv3Z/b2vzHZEbwo+QYFxj+J5kZQu2Di4P+XR?=
 =?us-ascii?Q?/cR8ETiGqSWIx4JsG//zwyqJFaqi4WakigVmPBFNdhvnM2NEN0XytSSj6kkz?=
 =?us-ascii?Q?AtqfstN30ytZzI+inSX6sjoYpFNRGO0NK+xqRH86QrPN5TuetCoLn0319i75?=
 =?us-ascii?Q?EWEppR4QlYOeZeECiHCqf3kOv4NCSsCKWIMeX6ucAmw8zJF1+PV+J4cw8uVt?=
 =?us-ascii?Q?ZoMpUSBoDfIkPyikzlRaRYjvY9Erv9PCrxMQKKeMz+pGMnjp5UXM1UyEbddl?=
 =?us-ascii?Q?PfLXUmaiv52VRxaVyNm0WhJptarOEZuQPhSAaPKHXFVRF0v2y1kQGzCH8Siv?=
 =?us-ascii?Q?txzPmx1Oq48eIORiPfQ22J/+QvpBIq81J030xyCQAkfsUXd73xe3Th9+YWI6?=
 =?us-ascii?Q?Cf5ZTvRj962Utx0RWnhWOqtnCMoTn+onbpNO19LGDOdtf88OELQEnpTrd1NS?=
 =?us-ascii?Q?OiUtc1sF7k5ncYBH+drNKEizGtN2busMfTJmlmos7LbUT8kPZtscXoWrKtX2?=
 =?us-ascii?Q?/ByH7BcYvNvrp0hCkAOhf/NZL5MarGc9ZBtWbb+k1xE+wR46vpiDQKHRThHa?=
 =?us-ascii?Q?UTNHv3XtIUkF4J6UzTclsbV2pVY6EFR0pJA6K21I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d574a3b-32d6-4c5a-387f-08dbaecce969
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:32:11.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vscWQgPUXcH4IjOP7mrSfGMvwYLRjQg3OWBlxSL5Loqe1jPiW677QfDrm3AnG+cVpQ3aSZwC8vld7EtJzpz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 9ddee04a1327..0fba80b1bb4c 100644
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
index 387eab498b8f..48a9b44752ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1044,6 +1044,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
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


