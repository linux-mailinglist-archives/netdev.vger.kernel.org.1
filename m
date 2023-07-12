Return-Path: <netdev+bounces-17247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2352C750E54
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC02D281AA1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2B14F6E;
	Wed, 12 Jul 2023 16:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C520FB2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:19:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::60c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BF2109
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFHm8XzZiaZ7C355CgU10C3og29X9hLt4B30civVuUwSHUVaJWauTD2n4HR2tmG4ccXFwM4ey9sxj+iofsEl1atXrWrP5l9vIA9C0k70zwQ9MKGGW+VxkYQSi+ohokqiHMiFastBoYTy47ftDR8cAY3F1ze7z9u7TN94zjMBp/yRZ9WS7zmAb8UBx3N7/qMV0mPUP7geGO4hVyzRMrOoQ9zQRF8+nwSgg/0KmkRC0BQzj0vURgsKqilfDltLYUSOmrnowFrtvxDmRYurGiSeRRG+FkL1FT/OgISGY6M0DYgGwK5DAa+XOOOu8Ss5ulkDmM3kmPbC/pqKGbVAlQ9xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNK9jd4+rXfBjE3kWlpXUMxBMoezNGmBk0vf7oWjo/s=;
 b=Fg2Qs5KMMhEgLwNT9i8eC9PQPM9XSlne+OQ3mooG+JJGKqf2pCKC9YRG6ouJEuwfI5mpoxTzM2sFQfMuNhVP39kIVYbVNSDin4gYXrMzopOh2wsfDNokNOOXvv+asrrKidjedt9s29wIn2UesLJNbv4gV3q3JEiUpkcjOy8BTzS0Sz6cptpkAalfQh+1EGUiA+uCT1r1oOUTVS0Wj9VQUkk3ebEIAqm7kNAe+FM84r7fkxsys7MQ/3bLij47Z6JKGBxxkTpCT8JFx9h9rhfjHN0PJvp6vMCfnmP9d3ozSvcWTlNbWLCoakwJdTy1K70r8L1FCdLWC61o2gNo1p1hCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNK9jd4+rXfBjE3kWlpXUMxBMoezNGmBk0vf7oWjo/s=;
 b=LqgGr+sX2xDh04cg2ovXhTeOP0swQsADWG615MpdRRceSbjz7P05A+NM0iJmuv47VmmvlcljcwwTL8VC4A+SupjlyWVUENvu+8OTo5lTlsu6EXIS0BYsZMtieRr+dkePzr7lex+Oaxr14S/ZrR0Ymg+TImy+DVQlhy9lVryJ3ZOnKDyUsJr+GpqebTLjWnIDTIofTV7dTCa48GTNocNEpFL2DN7RdZllUsKEEMs5kV2yxV54IP0xEM+KeNlvlPKqpi+mG8bWevkqfi9TbFJAkpiMYVody/FeIxYz88Mrhf6rJJc7gOujES2yBufl8X1bw2JC8Gk3Kzl53md594+9Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:18:25 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:18:25 +0000
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
Subject: [PATCH v12 21/26] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Wed, 12 Jul 2023 16:15:08 +0000
Message-Id: <20230712161513.134860-22-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af53c27-21d6-421d-a4f6-08db82f39e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q8rq2HGaQQSiftGA9AGwoCc1zeZR4kqP7dsg9//vv4dopIBd03ULjqmUeWGk4TBit+GeN0p6xqnF9h3phN5QZnE9wSWehA4UOvZCyar0VFj85Yn5d3M7p9aniriD+OREqvBxt2woL1SR6TFBGDdsvziZh7Yc6rVUDkXK2pksh0/l8GGvhUGVOPtCRvvXsXPSzfbAkTum1TuHxfHBnXGHYzfnnxDHZP+im1TTtq0P1QhurjuOza8+7ZEo7h0C+1mn40n3zTr9XE8ulqG46HGv41rcgM6YPzS+Mz9l96JsAl6jnM+nh118hG4Vz/4D4XwTEQ1wbLcqnyAH8Ze01q8UjqWKZRawQEgOsuRxOXpc/7ufQEnsLx0Gr3tFZ1Ld6BYGpyuX9mBYPveRn5XBFCcm3bBx0lZ9/bLT+YS68GfzTNHSEoHoj/e/2UEEJ4xVrOnr4lPk0ORH6dgSHUZ25GAa/SyOHTUCyFx/pFv2Yzc4JQPbgCV73rzpQciCKCeFbkj1+lWNBNMf56UrsBPEgQptgUj5Y1FmX86ao1Yp1tPXNuR6W28wmP+7pP0oBxqHtDrV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?12rzaTn6BuGjsuCcy0wc2i8TfTxx+csXc5X/yBZ1mxAVicD5PrQzNuixlFpD?=
 =?us-ascii?Q?EEuobI5P2Rx1qn5gr0Rtq13O3tKsk8E89xQ9qRFIdj1Hx8G23xBkuC6t2/u1?=
 =?us-ascii?Q?s1COT35ifYERpA6qwVW45fGS+rVi/aFL7KP0AXUvFSM8cL5xmb3BoE0BtyNa?=
 =?us-ascii?Q?cSFmftsBXjW247RAzc1aVR6DlwX0NnwbVwNNaV7weS0peXPTi5qg6e/SwYG/?=
 =?us-ascii?Q?Cepxp2lKgtKZzoFM8J12a7d1WGeo+/Wxj5AgtLAo5xdaJxqti09x5hNXaiSw?=
 =?us-ascii?Q?8OYp2u0QNbSJ60TJbmKNnFsJvWN7FnHgyU7cpW1b8L+rVrDQgolNC/WEIUC3?=
 =?us-ascii?Q?jYvBJ1w0CYZ2OWIXpQjgE5wBAQeBOmMlxYcY2TQeLiMh4fw+tEGhA9ntGjyC?=
 =?us-ascii?Q?KRHc+wi5b9mDdsAlf+m3EYuKhuP2gHKrwtlIWfVJ4BSFu28nCrv//nyHJu0r?=
 =?us-ascii?Q?wjy+3Nt1x5vWzrBgkkMGesXyXon2f2fc85XEMtCH18TCDP/IOIQsU0lwlWLZ?=
 =?us-ascii?Q?8CiHhkYMAaRFgk22HltE/2CENsiglDI+tGQE4tuDfNA2h6kY2kUicwkCjJYf?=
 =?us-ascii?Q?Gpc3MOk7iaSOdwxXQ0Mj9PLLVlADIUfRm8hzvlSc4nkSA+K5ui3kUC6kuUd7?=
 =?us-ascii?Q?BL76PRASkFIKuSAcjDM+sdWC9V5UDMWCzduD4BEN0Oa+6pSxT+qFW8YfRbOk?=
 =?us-ascii?Q?WuyUa4/tzDAi+mV7y0G4fn7M0tAMNYXSdLdRV4AgcBt+rBBMi1qd1UwtS/j7?=
 =?us-ascii?Q?hbSmqY3dYnNH8PxpFNIrfeywTd865smclpTu3E6He/xGAbh0InxQJMkF4CZ0?=
 =?us-ascii?Q?y0S3kav9+5AhmftjPh5eHSS8gjP8y/Sp2JuUQGsuqZWpenZjhG0ss4fHe5XI?=
 =?us-ascii?Q?m8adfzUS2JaBOxTKSFonhgyuVPn4PGE7c4BxxJXnfJDulFWG26G02YsKpH3M?=
 =?us-ascii?Q?w1Zu2mXyRFxZckTqu9z+9h2YZYisn+GK7K3U5q5DosIquYxWVwBKcc3ZAnqH?=
 =?us-ascii?Q?KMJOVV8xEu6a1kkf/6bNuOM91FoUeiMISXKOYlq4bI3yCBBJtMZEP+Zh1bn3?=
 =?us-ascii?Q?e8b16xdehNBGfaGdSXHIHEmPzLqf+OaBEcUgtH7fHyveRQ98pxqGyHNypQ7n?=
 =?us-ascii?Q?MuuR+GCXKJpj7b64FO9kzhbVCUY2+mOveP7bSiNIMd0eFNhsG1TdvZ1IPuEH?=
 =?us-ascii?Q?zeB61JIsD2PJRFUdCl7H4y98oXLVuxeb3wKRVLLKfxT0I4hE6o2QfWvNubM0?=
 =?us-ascii?Q?ZK+VHnH1SEqo0iGJ14OABGtgWQ/cIniNqQg62o5xGr/UQ8Si36+GO/PmzSJf?=
 =?us-ascii?Q?1gKb/9Ow+QXd9DD5qDTJLZj9cPWfjDUwveJZJE+DM5GcSX+Kq0ZqQWzTDU5j?=
 =?us-ascii?Q?MCSWMcuVT96LIIEy03JamEECEVr/kMa8SMdUXp7G/KKYgGPSrkn5BXQxZOdT?=
 =?us-ascii?Q?TzI+wLsmQeVIJCmk2fMxJEedPKYPls+YC1/kChUdIyeBrJ7cDcAHMeCNKXhC?=
 =?us-ascii?Q?jVmTFdsFRs8/10fw85Vv57dYq5IRV+UkwUz5qfSAd/w7iQaIuk9PS8rLfPmm?=
 =?us-ascii?Q?M2UaaPyAsaETvFmKlAQXg+AO6ZR+nOYrrd7XJJab?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af53c27-21d6-421d-a4f6-08db82f39e7e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:18:25.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqdedUxZ+cvIjLRoeeQA2J3YMi2B/L3dxyTrGDgDjd9x/nGg/6Yrqze+oMe5Ghm7rnaB5MNKytOudxP4M1oxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   3 +
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 123 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 4 files changed, 155 insertions(+)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 3807536932e4..294fdcdb0f6c 100644
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
index 84ea8594e1b6..9dc182ebdaee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1036,6 +1036,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
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


