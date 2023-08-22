Return-Path: <netdev+bounces-29678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6B784515
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEE1C20988
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B131D2F5;
	Tue, 22 Aug 2023 15:06:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C079D0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:06:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF64419A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROaCjoqzHBhTNJDV5LspT7y0WYjdPfttvrsmfV/S7UZDgQvQ/43XNqpeW6qcpDk6rSFvNbMIVFX9h55/vFQSYBvq3y1ENQvnC+i0Pg0pcYnKmpZ8nd1GQXuw7jbCBM23F18q2jNuZ676ERnXUcFGreg/+3T9G31xcuaDRhigCPA91f6ijGOOIOkQG8N+EEGm27vQnEPA6Sno5LGHEXk70fC8AsLV5vx2PBmhtB4+B6fxNFn8W772f2p+W9oZVDZXQ8xvQbgX8asFhK4Hh35SDnaozLoLheNiGhTAXgyBZvifBUxip5C5/HC76VUBJm9C4GRgy8cXhJeaWCBOBnwQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/N2+aWpEKoJHIpzPz4HX4AsFWpvq0dqa3uSNRJEvmE=;
 b=of6ZrjjzBLI7ag/uWNkdpHGiWl8JWZ7dXy/oZNyPnJdX4N0aecoLFSMOyIjORWnRXRHSiSum+exhsrRGw79VgL5GnT2sZzJdJ0p+i4UeXkP8ulFGzG9W719IQheWYF6jpY/c5P+g3ASt2+tPkN5jq0FEVwnWTh0iH9BQ4GUw0RsuVRPzzU6ImIQmsPDZ+LRAaI0CB6OUqPhr/PD7hdbtBHoWuc0DN6qZ+xgd/zBVH12Hk6M63L9rfclIXqbJX2vQpRDefs9zT9j7sXEIDDVzbiDlzRGffHWER9FegikANuabAYxDxeS/GPwBKQRa1/hcA6BRx+1FzYvs1ynlS6EFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/N2+aWpEKoJHIpzPz4HX4AsFWpvq0dqa3uSNRJEvmE=;
 b=CcNtQ+ZCwD3Y9puYGTwIFUJolTeyaCBMPURMmk6+/Yueg2gp3GOM2mgqY7OH48ztlCpB07hKT+DjLAtt1hpceBJhZOvgDdf1dbKuQStdejDAeAeHfld8e8UYN5/Ybb71Z9YLRnWO0xJL19aW2R/4s2yFjFuU7SUFEArONR+DBIFfZpO72ZSOCPWwJnaaOYVRKHoyrGe3GkwwMEQatocClLbNLV6pGKmf+Qd98t3/P6NgZ8QpwoVQTxYw7yLWq/1JNznqmdeBo8YW9KE34WVjOqYSE87UVGrPopLK9khtvc5Ku3AL/UmcpS1zMHBmAnOiM5koVRXSEo2EFiu1/zh9zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:06:44 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:06:44 +0000
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
Subject: [PATCH v13 19/24] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Tue, 22 Aug 2023 15:04:20 +0000
Message-Id: <20230822150425.3390-20-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5657f1b9-f51f-4823-0597-08dba3216601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HWznhNUqiI9enjz2enQEI3/i5lX+c/s/8KO88/OEFlnUuce7agEoxzBX+bfuyTKdW/zWrcb47QHNUHxo9Ulun3zRrmQChGzdhLRRVGZznL333AdJ6zZ32m4sQw2BtJFe9E9MSv0g0mUCO721EcbNgCS5ox/s7Te+FyvQrEZ4AZkVW75IKTPXSbCofTb5EItSQO36x3kg47qz5BRSOQ9VTLOt4ltWnZExjcF2JBCudEBW6x549E9Ud+LD/pyk1Cj3mBBxhX+M37jzuoGG3qXF4+PZ7Ben34RwW3nWh7y6yRKwh1PnISNqGs6QGfdAaWh1/rP4dEUATrCRYEeh9Sn2QS+fOIn04Xk8IiLy11bblauNU36mBBcaRqmRlV+/zHN84lKbTjdMlgNsulKtrGJdtHL9DxcpqaSDVV81o7txrgXTOM9tHJToAJhVLFHhMeTByZsHNJHm0C+8yamBPpONLQSjHtrXD8UxQVwKskD1IDS3kCIo3Rp4j2CGzEQOOIHKfrNkdjBjRBUxmIJBSlhCNQwNKuZl3SsnbdSKz3X4ZqXOqwKtyokwqxMH3Ixk4bob
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hv2t4VBh/fTekNrCCxEbhnwN5xwXpXnFtWWfiHCUav6uOcsQVzX6KqCfaQon?=
 =?us-ascii?Q?sANhzEV++NmqlHjWt7Dig6VexTCBZ0EaaEXccJJ35D+6xMAI6xxhXFvqrACL?=
 =?us-ascii?Q?7tNbsIr7nEmTbUiu+fQTX9vmHcWvwZn7oackQNMNxzgQlTxpfCAw57jBe8QT?=
 =?us-ascii?Q?25YPm4M5ZnmZEiQVvNS4lRGeo7cx0lNOTaOA72qM83kfn538wP9GrtM2Mm5s?=
 =?us-ascii?Q?dpCKqMZVLynGlH0DaNbqVKrPEhb+jXc4YY2/o4aRmWLIIceUm3DxmWVaF3zE?=
 =?us-ascii?Q?fHc/KXgULD6bd4dzs2kvObKrJbz59hseq3ganc8D/GpZcnn0b8hoFf6+oozx?=
 =?us-ascii?Q?cgvCgEdtLneJ/8acY+Ua3ppolPYYGlSRlpk9pE5AQO4DDkA++CSIQtoHah5W?=
 =?us-ascii?Q?qJa4vo/IplZJOT0vMpE/B3r6UwGMpp44z47RnrTckLpHBWZLY8mX7s2cO2SN?=
 =?us-ascii?Q?eJ1eKh7pEcSdDVNDwwTzuQE1c+IS794T2gOevDoirJo+SQlGEZwQC6G6F7vc?=
 =?us-ascii?Q?d6D4Pltg/FqsONdiw130Ijc9xGsmfx4WOwStMR7VHX2imyKGL7f1GBgioWNT?=
 =?us-ascii?Q?HleOpVeh4yYVa2xsw00QBcLmficuUt7JExOxs0ZQLyLWSkBxxE7eZFLJ6ynV?=
 =?us-ascii?Q?Bjh/3ETqoPFCCAS2VLQGTIQShzrkD+HVFGTJHWHBBlwUl5d0omZ+biPzJSSM?=
 =?us-ascii?Q?Vx8gaGUmVCH0ZCiSHmze2dJyiXsakq+bKTwa88wtMu29InhB/lmFHPtsP9It?=
 =?us-ascii?Q?E0Dd6cij6UOrtcJxNII6+irQ6s0SdjOZ0LeH6NMyPZR9jftQLsXwraNyJyBP?=
 =?us-ascii?Q?oQeTf3Xzytfo3vnR9EOwsre4mdfbX9/rFHqXn17snqkbFnZdAfSVIiIgzVG+?=
 =?us-ascii?Q?dRhObFnq5uQRyZI0Dfc1k5X/qsU2I9ynVcPCtyc55JIbJGiCI+MIb81asaYs?=
 =?us-ascii?Q?8AuL9z/4kCh6KuHHy8dPAVHu/OoKh1RFGwwy0ES5ZAwM0Lsp+97DY6AxRJUr?=
 =?us-ascii?Q?6hF4Y7xDWAtlle7vN7QvKsJ0k6T+9s0D0SvKl5HUT+csDnJW6d9xFbDQhWA0?=
 =?us-ascii?Q?En/JuK8rNSDtm65GixWejljioqY2MulD9ZsgLYwwXEflxp3PzQmdpf8l1/mH?=
 =?us-ascii?Q?9iR8eU++IHCXBsrP4LJPr/sQIgwV2RqvfmQOjyy3joutJf2eU3n6z9vcLcI2?=
 =?us-ascii?Q?1cELCoNgCoDGAayKHZncvfN5yuyhbIh8SS+qbUCnQ3RwT9jwVrgYxq1abhiW?=
 =?us-ascii?Q?qPK0DdrKNOl9LwKKa9X9rjo3pHP+hyXJg8/5wa0Iw7rTuCj/ji1ap6pE4X+2?=
 =?us-ascii?Q?6nN6FhAIPrpJZO4Lw05gkPZZGiLlj66oGjQT8B5th04mTXBTIUBTR3tzJH+B?=
 =?us-ascii?Q?E/W9kSzJR19hUUWOoUXQlyu8uxU2o1F2PvOi5n3BjkZrVi1tKSExul9maTKC?=
 =?us-ascii?Q?JJaskH20t2gyp6G40aSoZbgdujC6hExLg9pSnmLJHbxp7YpZn8LqgTNJAXQK?=
 =?us-ascii?Q?+bzJw0Z9rLsZ+1qWwORagpH8rqAneuwu8ESdNlEdpbB5xdIPbY4Ot60opMPW?=
 =?us-ascii?Q?Jvgo7HXBzhdbLQrhgagb8tHt+KVHOShJmscRY1cL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5657f1b9-f51f-4823-0597-08dba3216601
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:06:44.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2S1M7YZxpVEMVB+5sVWwdZ/pDRDGlgoBgnlLB63gI9Ye4Y7NNrp2nI0YMRwzaOWBo9kooaAIHN1/F7ZIoOJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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


