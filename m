Return-Path: <netdev+bounces-33145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA179CD20
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383CD281703
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F8179B8;
	Tue, 12 Sep 2023 10:01:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E557168D1
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33256E6A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAkx2IQQuQaoGhSf47FkyhY1tzSordjW9rLdiPb9fjcqJJ6rdJzaItA2n9mu58CNke5dZ9jTMyoj9E0YGV/N4M4iFkNLtt6zaUDUd8Op2ObOOsAHl2GccpHxg3CMn9JVY1Tg/ZxXU2+2CEf1eqwEdVovxjXQkeZonYShuctHWC3SvvLPWzXdHjYqrNTmqHrdDaBQJvmdWDmnQiVgCL+po19VLacBqke0slgRj2+3fRPQQo/LBH+NuJyeDRunYXWbzDSi2GiwUuEZOsNjYS0pJWS9ObUzJO53of/7os9+gSUtriXBv+WaVkLTKR3xsG+aB7Fz264H29YY+sER1YUrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FJ6swElhY/KLgASUCSQfvh1NeOvyOaxqsmIatDJKq0=;
 b=OHB36RsbjlvYi9i/aSHrkNzrcycKQO5n1qHoegiKskGEZXw/fsdM15lW0r77HPkxmvVBYnGlzdvy/vRpPxkyceyt9mBztk4F3/INb4FtlOKPfLGeLz/q1+4XUp92k+1bbgGLYNT1cxOW116IwwnouQiJx3wvNsZnE6R1XX78AQq3UxFFf9tAFKFIq3/20Khc0Pe/CtVRtPGUZ2E4EyuU/NetuiGPX5zlUntLpBdxcydSw9Qr3HKuuMTaGJWJxUoil1dKUNRDSgMAN8q5AZlUadCqf5b/bZNkhKQAON7OTgwMlv/tdWdK3dIK46hlz0Q4QniwGECxij6dCqKhz20mVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FJ6swElhY/KLgASUCSQfvh1NeOvyOaxqsmIatDJKq0=;
 b=Nz3sbLKXwqTINjOKFV6dyiOO5eat/BW9Y8q7twLdjG8aE0fkjMimsMttxomo3gklQV1Sod6NWCGiVg4Phtmkbl7JdLTbIZb9AAnF6/KWQJ2U0vk/ZaQob+zVE9FnCyER5Vca1DiVgda4hhp+/0kotzLDlNE1L/EBw6tf0Slp2zuT2WDv5dEJn/lwglboLM7pk2+wfSHS0ExT61Abs/3KKQpS6IpPvML5LXjvJXlYhM1QqMMnj0uwRilvRdzelfGIUQR79TjISoo014Zwi4gPT7nap63uI462l2EtHWXNes+HMBwTn1PlsZPUMMPTgdeMOdns4VocWpZSk3+VryWFOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 10:01:36 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:01:35 +0000
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
Subject: [PATCH v15 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Tue, 12 Sep 2023 09:59:44 +0000
Message-Id: <20230912095949.5474-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: e652b0f4-f9b5-43f2-b050-08dbb3773fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QcZ+hE8IgtOd8v+rjI1apVlsehMy5Z8joFqjwci9Wdm9cZqSjo+WMGYBssxyQY1x2DmvTqbqgYWHbJiQIWz4k953QF5Y5rUo6M8vsqZ0/nCFmkFmUuw+Sm9l9EACJwF2DkEgkz/rXgDkwtkOQ4sXhUOvrhyvv9kufnVPMgfRAU7K9VGf9R7s/C2y6EBovSKrKarNn21ulKPnJ8WtdQay/rNxitqvA9BFAFM8Sie9i0/kXlHdn/fN6ezBoJ1H2sc6oUdW61PMPK6U7GHZV8WMQGyapz3Kc3rYA9taZ6SnXikeVN+Afn5CDSWuphL+d8i5WZbYzdXvbBD5OwTDhP+hBGRrL2IvomeETmDo76nfR0eE8Sn3js2gz7oJSPZzIR4OpL+J0dzsPxCNy34JrS/kIDLOEqQ5BM0mAJxddfTz1Sc+MtDC5R7U8SVc/AZ1Mi0r4yIoEOE3sCg2jTpQOy+a6oUsKja3dBfjMkRb1TnN0o3yoKWflTcPnomGwX9o1eD8ekRC1Dbn3D74AlpU8yMhL1cFPu8UTxhmZvEGG6rHX12VgWK63egORHkd02lIR3nL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(26005)(6666004)(6506007)(6486002)(83380400001)(1076003)(2616005)(107886003)(2906002)(7416002)(66556008)(316002)(66476007)(66946007)(478600001)(4326008)(5660300002)(8676002)(8936002)(36756003)(86362001)(38100700002)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VIaaT7TABQXkHCM+eIxOYCWy71jm7JBe9IWX6ZpzMxMwjDwIfw0rQEym2Y+Z?=
 =?us-ascii?Q?6AZlCgw3OVWLThkr2uQk9BCQUjtT+AxEI99HQ4YCYVqmAEAGEaXa9OjGrMhX?=
 =?us-ascii?Q?rzzL0EvqKP+loim9mOi4yepnKOGwa9YePD4sFGUu26WNtpN4DZDlEfbn2qb9?=
 =?us-ascii?Q?A5T2A5WrrxorUnkja+0K3PemIsBlXiBtTsreq2ADTNaj8e781X57zyZ+tHK5?=
 =?us-ascii?Q?ilndf5vVayhIFAwzaD47jVOtX3qrh/w8Y05kCAkWFv97WdlhOqjo7TM13QHj?=
 =?us-ascii?Q?Yifv0Kc7zdHW86/+fnWO+GnjeuOcitDUWmx7zDbT8anydpojUFdRrWp4IfL1?=
 =?us-ascii?Q?XdvLulZJyEkEb5+polGvZMe4zXSgo+kiyQ9L1qbgJFzejG8xQLFdaRjUJj93?=
 =?us-ascii?Q?eAqOh5Ei2UERpFfeeSbPFoRTkDNkkf3wTKYosAIK7KWpZpZRPxNtaKXKu4y4?=
 =?us-ascii?Q?qzREoyrqXl8qmMBCsqyYPZzj/SMyXPvvMBwHqz628UFG8AKgGdqOzsKcw0Qs?=
 =?us-ascii?Q?nLjMnwPeMFZczwTACXSxFTOge4d7ZjGdlToyEVTg1bwR5iSYDP/MxvzNs9Qd?=
 =?us-ascii?Q?05slDFwyG207YovMhK6oFTZ9u8mEyqR50bnvJ/FxTCR40xDa4+VHNCKSeFJF?=
 =?us-ascii?Q?p1fqeR83q5LmqLrN13P98i9mLlXx1Oyjccf8J/6L4lWqQR9uxbenLuYgLFDn?=
 =?us-ascii?Q?gNZiwkw0N6CtZbVJNGG4UptWSop+nMQc0xe6kJfX9XLeiU619iF4WiOGtwNm?=
 =?us-ascii?Q?ZaP5cFX4i1XnBJWELWWrHHGn3rHqL1y/WDL9UFvF20ada8VoxeqbSUek12xU?=
 =?us-ascii?Q?ldtQBd6xzyfTCRoT5KbIvGjb/X+BMAjEkka6obhxgxhOMqJfSSUfTHDWfMu4?=
 =?us-ascii?Q?bpIEbQsIj/9Z6nspCmXsRZ0aVJeWOIDS9VuAiFTY/h+1/J/SdprMdMMN+ZWE?=
 =?us-ascii?Q?tm0uLx/mGCZsggFBeim98EKdES3bRSu7abmTx4M1hSn1FdWiCocEHzr3IYYj?=
 =?us-ascii?Q?HL3X/tV1VDgKfHpAlF/RtKamNzpyls0Ynb5RaPcbCEQZ+60vHFEIupnxeCx3?=
 =?us-ascii?Q?woyLQ3uTr48D0xwPmHZj6m8mlQ8bNth7amtikyY+855LD8qYrgOYRZmpcYTA?=
 =?us-ascii?Q?XaHyHW6OZ7yKWt1icjBbFhD9fjlw90sMzueZH1OGz2C6GBGBBxgfgL2keF9c?=
 =?us-ascii?Q?MVksAqww5b3P7JES4KPCimb1h/6UGLYLV3MkkR4mRnCLPgfNYo/v+PcRupG+?=
 =?us-ascii?Q?cGIbFkK12pKO3CHZfge1dBO8Ev2C2R2+xlKpQ9jdr0juh/US5lqs+XZ7CVa7?=
 =?us-ascii?Q?orm+ueUZOvqLmFAIgrzwe9pfTNlAtmq1orC/BbqlzfN7JwCS9x3z233dvXWm?=
 =?us-ascii?Q?l8I6d/PmsKewGUocmmD0OovilNBN8s7eNgpjwgkl3Z0+zCILM6W8khRk3QUm?=
 =?us-ascii?Q?PiUOgMTNuOM6UAXzvzRgneEBEXlbS0r74cBE1watkX5RvqLDIQ57+ib8efg6?=
 =?us-ascii?Q?P6rSnuK8T7xExneicAo6R3dDx3gFgULnI7ABPem84ZaOYK4NZcEob4m2oWtf?=
 =?us-ascii?Q?psWMpucDz7+JpaYvD97alo3HfvYcrdHfekV8tK7g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e652b0f4-f9b5-43f2-b050-08dbb3773fd3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:01:35.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx06Wleu7mHRlyQT0/Csn3BLbTP2Z519K7SK3dqmnagJTdW9xmcxTExdODhSezHcNFMNMK3iulZdk4Rsb7yD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

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


