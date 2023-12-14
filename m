Return-Path: <netdev+bounces-57446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD290813193
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAA11C21A0E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA6A56472;
	Thu, 14 Dec 2023 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f2tXrZS6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5969F1B2
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:28:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4tfZhKD29YHoxkkPmilzz2SHzLs9DyZfHeKA1TW9D/G09GZ7VA/cOoi2w+I9Biu6cq9AlaYPKCAFQlhLhjX8lo0a2mkyhEfUxFoOKs65xVWQ+898zWwSppXSKWL1f8VQlyLwgBP/f9uWkqQKdMmXE3u+8vkTtiDEPDESPdOetSXni2aX4JeoAkzGObNIp+REyckHSTi1wlISX/TWj3Zau8GtSi2WSB8B6wHwadLCYf5RffP2l1NynII+YSMgL9+MlHne/fK1wu68AgCdy3TfsxnKq+qwmk8qz9gKS7FEhrXSTN+8lbWfV1nhe6xlqPLraW7x/TZiF00BRhxezyGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f9wo7q1N4LBRai4Nj2wbo6zIznzFZVgTLxXBbGDdbI=;
 b=QgxSrgmYERth91vUJARweg+tGTKZo8905+OC3pPUI8sNbMp66V27+oWy/b3BfHVTRX32AEHwdCjolsCkXM20fyp70c8MN6UMA78FaZkg8RP8zytqEWXHflOf4lTq0wQbp8aWHEGQ3PwWjRQTyfm5oxb/POJCqASEWlqU1NeJY+VYtG0ZNSH6376cbhn4xSKx+217/McQHtzW2W6+VuckNVhzyYi1yobGTLJznGLfW8SEy+wEkt0Enbtndndc21J1Hm1X46u50dFoOYQFffefqT7yCPEnTMdqQ2VDPPjdODHIATWutOUSu6SAJ6JZeG9Tv/zy80ugQKMGf4otzDsWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f9wo7q1N4LBRai4Nj2wbo6zIznzFZVgTLxXBbGDdbI=;
 b=f2tXrZS6biGD/jFGMA3DrjRfxHhnh0fYF9cVtK662BViQhWUlh4pmXpfIvctp2p2AwmDzAVbz2LiWRom7D948pQZ9Lr4Gm2S4o32+CHt+nxxaYWKlTCACtzGe6mEtw2cD+yTtqiKW+0uVULsIuJg5xw7We7e15Nw0hBBsEXJoSydtcStQMXMYo55O3h2A2yi9AGCb4HshudV2ip2u38zA0yIPBbup/6ip1hJK9EtaNAhHVbHp4tfAQaBQZJx3sg1bcElSGK1EH/pgGIFs+dwB0uC9OOflVTczhJpfiXr5d7UV9scwxzbYUeHvJ3n+IjV0UO4YICXq139OOc5YOPvHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:50 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:50 +0000
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
Subject: [PATCH v21 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Thu, 14 Dec 2023 13:26:18 +0000
Message-Id: <20231214132623.119227-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2daaec-635a-4ad8-49dc-08dbfca877f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9QAlGxOOGa77evbO1mXnf4g/2ogV+GZmm9z/aZaFcUM0gXJpcbWgEcbkt/YdGbHOJkfhy9sj9eVhjSYw14D7PyyDyX4YdB7ZgNs/DK6uYO6NLOjIQve4a6bOl81bnnd1OvqlVv5aa1CQTzDX6b+7i2QId1U+OM5Xp1svssi3+moiRlr41/Drdakar3ciF9IcP3wAyO2VmP+pUO64YenqlVK1Twrw1zoIDg6yeeZSBaZftlbbkS2SEIftMBaELryxMnOGZCuMy3l+F8Ws4eUdlVzRjXEmfKg05creIMhXrIUnTeLhtstvYdlaZDvQQ7p27Mv1CPS/3kZ5uiPE1HScORnLLkDqJgmCdvyvcV904YY7G2ktTOcXTBYygpdlKiJiWlswzaHd20U7r1OIkocAy0m3cbjuEndM2jy3dM4Vi6xtyNMdMCpz21IHJGT6OTxM2AZIPlA99htYOVmUEl+flrqPPGsHisQrEXF1hQS98sMgZVLEBJkj/FGWRTMqH7XAP7SEJ6RPJlJljQqocPRWoeIckkjuanE8AcjxxZSU8uoE5yQXMlkR2y64M6P4WmIa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(107886003)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F93tFYXe8IvoNEYJKXlSaudo9m3MYqJWOOS2AQxQ8S7GnsHzn6ZgsmVyuAab?=
 =?us-ascii?Q?SJMQEgN6wqJuOle8ciXi9N+38p8/Jfja866pyuSF5pBj3FI2EvcNHdXLUIGh?=
 =?us-ascii?Q?gUT7AC+ZwiAMQnsBhT5BkHvZZ4Sq/6xzqVjIbOvJfmVmuc/tTaWwLGsvVqhD?=
 =?us-ascii?Q?00bBGAYoFh6Im2DEueM+yMqDPR3lufAan37LjHtxNYd6M8ZAJpWMWcPdAOJ5?=
 =?us-ascii?Q?dODKJe/cv76258wxO9hztm7gXud+N7P5qu+AIr0RFNMyUk/HtplEOdCLmdEs?=
 =?us-ascii?Q?833yZSszo7XVJMewsuvfQrYvenbrdvjrfIA/cqKtc3NGORhkS9LUHBqw7Za9?=
 =?us-ascii?Q?+YKReGH6hGekOP2W20NJ91yzbZYbBQ7C1rp8jvLSB3zS7BxrOxRiOHLcyNKZ?=
 =?us-ascii?Q?SlGmeSG+Jfi7VatSnR/H44ohW5gZINwa5wEFbEPnPnb/wn7CE0aQD0lwFsl2?=
 =?us-ascii?Q?mNrzXvFmgopQ+c65QBlt5j6haq3vz9giYgb/pRXys1PUNGcoJHaJ6c7sq++f?=
 =?us-ascii?Q?Q+/pcCaFoALxvxOAmFcs/lClwlGOJ/PLmUR9MTw0a4X+QyRi7q543I2/SHbv?=
 =?us-ascii?Q?PIMxJDR86+S+e+JS9yTSH6u3skwOm61+A4lX8+HxB2Y4Q1Ibx+h6K/5kBtJm?=
 =?us-ascii?Q?9pci3FOmnA7B0TEbJh/DjrI4gyFpdl7KvRqo0/Z1FFrPSmpNTYu3G7WwqY6R?=
 =?us-ascii?Q?LgQIgmwQRi1nRDigyZDRboRSEMOlTHhqGwoYRbfm5laeWwR1P5KPmG14BYiF?=
 =?us-ascii?Q?WvHPXIcdldIAgnsQAd7yeKLlpW5cdaiAHNuF7f8nYp+brOsEuYLMJRjwjggK?=
 =?us-ascii?Q?P2O9We5EkLgXpP3z5SRQt9AZ9rNVhNUSvtLFiQpVTGvjHaZxdHLU4gHA6FPU?=
 =?us-ascii?Q?PBRujavYYjoPQplldZvQSvIg6HO1lqPaoMeCXekjeaYPvVTXqX3UmNQOXqDb?=
 =?us-ascii?Q?cUt1pw6IjeM1+RzSKIj1XsuDKgXHM9ImFaK0xvaRBc9F9CdZORdKgXSjjQ3j?=
 =?us-ascii?Q?6SA+CbdK+94kHGN8E+pB2j37ho0huNMaJuv748EFWMfVch/AkH+LZq3qweWB?=
 =?us-ascii?Q?CTfte/luY5f09WnFLYgDYLtfsyeVwMCEJzjSJJsbbqXyEsR2cAwZP9ewr2QS?=
 =?us-ascii?Q?8d19lfZUMyvYv5lliDa2zToK5cQbaY/YZczMXGTxYJnNV/yHU3dS46P5Ok1+?=
 =?us-ascii?Q?b1zSL3ErqWqNWgOSkyQqU4NtWHi+PKzBTqNCaFvOgTmYCNX4ArZON9etrtj/?=
 =?us-ascii?Q?e9PdyBBfAzQ3j/v2CB5s2/w1WTLKXwpSqB5jVcMiZB0JIb4dFhjtScj4jwTc?=
 =?us-ascii?Q?DrWNPRZb5FEPuWUMkj79imEMw988Evw/4GjJiGEwFbXRG61UHvI9Ch3Lwxk5?=
 =?us-ascii?Q?8XvwnrTFD9aA6Jv6PIGJgg8wpuqNzB2fEvBWJu3cMbdrqEAFa3/L374c1bgs?=
 =?us-ascii?Q?NX7sfC0BndvAnS77vcxo4z1QdtwpCYhGjLXBYVyMSrLguFr5ffTba1J5OnRl?=
 =?us-ascii?Q?CJcsczPZhl53Ae/Pm0vwLprWxaoEfWL/n3pYc5ePB0Pg9SuzSMzPRZjWL3kS?=
 =?us-ascii?Q?Gg0jyOF72/k/iuFMogeG3vLB623qBE3zh+AQBH5O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2daaec-635a-4ad8-49dc-08dbfca877f1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:50.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdvnqoOS2uuFUMYPEj7Bae2Digo9HuMbxxvYwfJ5GYtBzBEmDi1PE62RRsCTk+uQr7UJE0Mp32htC7x3DTZ0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

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


