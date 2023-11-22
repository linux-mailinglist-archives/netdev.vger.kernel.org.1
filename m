Return-Path: <netdev+bounces-50067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4B7F4838
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A7B28143B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4144E612;
	Wed, 22 Nov 2023 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QN4bNnwi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9BD52
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcPUAEsDc0w0OqnC7/go3EQgrW7vhhE6yDSehp5CdBtq0d/ys2jNkM9uBSGYRCrY5Vb/zvcHoAsyGhE0Fhn7GIRIFh9gGTz1sDshTkDlBdgyFiBsvlVYJ6vJNqR4oBv1sYAHNDEzS9XIkOn/nHLjMQCoelauXzFwAS5AjvO05ySb9QTF4fK0s1UQ7U+np60rTrKxa1sTAJw3/3y2ZSrQwR1gikk7OJ0LNW7D9WhVqEelPEBY/2+lOVnf5SkIj0ylc5iqTSvZa4mDz6ah88rGJLgd7iu403XsgRVD3uMG0M/htOwfBkG+YhhfoN36EIPwESy5MAepo+rTOh+l9THo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMNrKi2nhF/Q9ZopjVTPHnyykhTo2h0LSfNT4g9TsSw=;
 b=e8XSvlJ1BvsA6Sbw4leYjjF6GnhymOjYaXk6GvSAFlsRPtrMujuxD/woM7fzimHJrj4OLv7Dby+AUkn3zMNCgph4+w2R+eHGfzoNrsRBLGHHuB3iQv3K/8XT8AXv+TL2UNv37BlJ3xlYEBSoHt9G1lujg+ebR7iBEtvAi/5E61nBHn1dWGFYmfq7sckYAXFzBQnzu9aeTimBC4deG3I/5c6wbAToQS64674YDjiw1MSPG/cA6JWZVYDZI+9bBRqB/4r2K0QMwLJLtI6i450C1JwOZ+H0d8yKSMQFe8fa0q0sEcdd2oFW1EazReqvUIf6ffTVVNvcW+pnzKukEyYNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMNrKi2nhF/Q9ZopjVTPHnyykhTo2h0LSfNT4g9TsSw=;
 b=QN4bNnwiKaQfCdGJbH6olCE4FwzUtUbHFEyedHBi8XoFzoPXZjJGDhgU+S5juG+YVAMnzh0cSCo0yEyx1cG8vezW/Lh5R1YQoSuj6b3cqCPZlDaFTtHhYPaSX6muTHFganBDGMjO32D2tueDLWlmjcs30y7xQtKHNIqkaixN2bOYFtqXjSfhvtDsNya8K4ohvJNtiFpGn4ilPjsljma63mClOZ66VnNFOg8Tp4KZbv+nu+hD/kPCA9I2RmDCnTcqoBi20LfR5dh9zhSNcjBiVI0tr6zVJGMMUEmUX4Hy+QS/FkLhJOi8uEzHhmGPh4iuOTbPX/BXRDrwEeLXvMOlIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:50:15 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:50:15 +0000
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
Subject: [PATCH v20 19/20] net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload
Date: Wed, 22 Nov 2023 13:48:32 +0000
Message-Id: <20231122134833.20825-20-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: f988186b-718b-4f62-e42b-08dbeb61f461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B8UPdWW18xnwqLJifDGeQkAAq6LTGL+cjFNNiRdL+cRo/wVePEBLAcPwhY15c8BBXfZYRNr6JU+DVOTyagHMjLdg8eAwHYxwpH0NY85SMYfIlsoA+sgcvXOMwYneuPjxSKJvkf61yd3zp4qOhGLLFgiCCuSUgrPNNWbrakaODMe2AuWHi138HigXBJE5HM++bSG/i6YshLWXuxgMrPd6pYUbIKOU2S4ZB5UQG6oAacbK3e0OhKSXA66ET+znMIVTpNJcs7rk+A3ABfOW42Fk6Zh3YQCMLairhbW6viquxk5ip7vLk0hSjdJRxrNYDlXqIDVaDiIXVrw2f4W/dRIlyDiPftydhxqWFKfeBnk1Yl0fqsdGrTOMQxDEgZsO28wb5sNn5qbeWVStmUhaDUOkZrEDx+s5OL8L5WfFm5U+v1frIddyGufN+Rzpg4+Yasx4hRgrRDUbmVs5LBSNmzd+w5Ykz8Ni1Tj5JXJLG3wOCScRujvNIAahFOpG9XpuWmGFn6StVXDA06ZAkMiM4z1PmgpRXXqWntbi9L0N8dinwgx/EA8iWmbYAGudXrgSlXLk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(30864003)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?poi1yhbSVpw1N0MfadVHTWGxHeCDrxiAhB+d31ys5r3qGHXwUGJKVZ6dzwXx?=
 =?us-ascii?Q?1hM7DQbkFyu0ODL7/44ab+o9Uapt+zmM0VSEzlddlS7wx345tNh7AtruXBXD?=
 =?us-ascii?Q?YRQQKG/v3lL2zYqg0dz8rOAyj79cgPcUH7zfzaUg43UUHQeQfTS9q6Rc0mFm?=
 =?us-ascii?Q?EJS/qGestl/XRWkegAukByWx9rXWSu5PVWT6gCZPtSkgpTpxC/9x2gLafgHP?=
 =?us-ascii?Q?x3n3lQUfiUgAXIjuQiddhXKRGKykLYcbMyglRIgwRQetXpkoCsL6R0PgKUJR?=
 =?us-ascii?Q?Ae+63RVMZBgnRjjXOgonFxEkoyxKXxsM+spD9TMxwNhzn6+5/8Du01TpXncV?=
 =?us-ascii?Q?VVi9/MH7aiPy8Qop71yy+d8cAsvL4b7Zc/tPwnujnREu4MVufthruQXE/CUO?=
 =?us-ascii?Q?LIRWCpu3CBS1PU0+cHk6J2ompzqFD2K22pAA0JXVpZA12KmLb7X1fXtnP/dT?=
 =?us-ascii?Q?hKyh4zLEh2EDi0Yeg1GNlRIyGFo6HXq/RXD9tPcXV6HA5v9ueuDnHK9qN2Rx?=
 =?us-ascii?Q?433NpkNvRkZtKbxJz8KiaMznO13b+c95HLtVEzPYjJ8wO0v+kNYKQvPDiH6Q?=
 =?us-ascii?Q?LenQwzv3l1Dd3wkBswt82F6CNhiaaqs4V6yKrdTKB6ZaC20jb+lL5LMcPFKt?=
 =?us-ascii?Q?R+Spq804niyWMzz93CsJP+uvuKfGdwh63TbW8tsnWvFehJpolvHPo2eJZgsb?=
 =?us-ascii?Q?avaKrWBgQQ7QdYGDVtvYmumP902B1cS/E6ErgmwKQcD7iBiGgoZYsGU7fGLq?=
 =?us-ascii?Q?nzyq/QN5azxlJxD+Zz1ji1NOwXouATjDGegjr3jLXMDxaZiQpu2e49qojqEY?=
 =?us-ascii?Q?b6wWcIW+bLs8EeUP/2J3s3igpkjFnFPyQ4L0BU5CHqlOzJ86cfXxWITviro6?=
 =?us-ascii?Q?DiUnshf2GPrA4JYs6jBJZs+QXwETb7FMWcBqOb0RiGe17M2U2UzLJAonEbiW?=
 =?us-ascii?Q?FNudM44tewJEib3AI60L0X2Sg7bNCfmiXaxxkrY0g2/kFDqmYO6J4rOoTAhY?=
 =?us-ascii?Q?VY8yYZddrPMvAU5Kv3XwQrKZo9jHPAfGBCx+4qvfRC21PuvhEI0GCDpsMrWg?=
 =?us-ascii?Q?s565bqY3xk5Rrm8u4GQuLgScPKUUukVKQyBYruDGRGzJaAXEuiv9Y4foo/zc?=
 =?us-ascii?Q?UBro0Gqp365LOaplkxLeaeSGESuNczrKMf8AOTDlnTwoyKemTi9qeqm+HJtn?=
 =?us-ascii?Q?1ERgzhBWGP1RPd5TXq/y5U5AjhcbjE7Gel4eBnFqJ5tBNhOpkvkv68L5RAqy?=
 =?us-ascii?Q?dNUeSmP3ekONl8JvIWQ+Lh6G7DEGioVx4TdpOX2QQOnva5l3exEVfAob4ZFZ?=
 =?us-ascii?Q?M1m8R9ju6LpK+QPK5T2lcAXFNaEqd2EWo/DO8eNdb6ReAFon6LOmfJ4rAMxr?=
 =?us-ascii?Q?nKEBsiuiZ2NbIJU7gQW8WbYTGc4K5o4QwNqkfqPdnagGd5t/bDyfvv02sWwH?=
 =?us-ascii?Q?zrS9+2zuOP7/NZTtsPWfq9KTtEvGyCJRHKoQiumaaFo0EMqs64ZToyirVhc2?=
 =?us-ascii?Q?A5Q1F/jMjNn8SAuAZDVgJ05axEoLJs+XPMannuDdKKUXQGqWPohTT+g2SpCz?=
 =?us-ascii?Q?01R6l6y01BkMzWnoWGoMDcMJFm+xYUwxOpZpvUx9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f988186b-718b-4f62-e42b-08dbeb61f461
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:50:14.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXdZbJ6WVgNYSyBTPjaEfTc7lrUBcqunUehW8N6GoCiGNJJ6QtWa4+VCs1kcEZBoNxacIZuX4WTzASRaW7b14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

From: Ben Ben-Ishay <benishay@nvidia.com>

This patch implements the data-path for direct data placement (DDP)
and DDGST offloads. NVMEoTCP DDP constructs an SKB from each CQE, while
pointing at NVME destination buffers. In turn, this enables the offload,
as the NVMe-TCP layer will skip the copy when src == dst.

Additionally, this patch adds support for DDGST (CRC32) offload.
HW will report DDGST offload only if it has not encountered an error
in the received packet. We pass this indication in skb->ulp_crc
up the stack to NVMe-TCP to skip computing the DDGST if all
corresponding SKBs were verified by HW.

This patch also handles context resynchronization requests made by
NIC HW. The resync request is passed to the NVMe-TCP layer
to be handled at a later point in time.

Finally, we also use the skb->no_condense bit to avoid skb_condense.
This is critical as every SKB that uses DDP has a hole that fits
perfectly with skb_condense's policy, but filling this hole is
counter-productive as the data there already resides in its
destination buffer.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   6 +
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 345 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |  37 ++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  44 ++-
 5 files changed, 419 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index f397e2eb0cdc..2db0bd83d517 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,7 +109,7 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
 
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 3c124f708afc..516054e480d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -526,4 +526,10 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
 	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
 }
+
+static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
+{
+	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
+}
+
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
new file mode 100644
index 000000000000..269d8075f3c2
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include "en_accel/nvmeotcp_rxtx.h"
+#include <linux/mlx5/mlx5_ifc.h>
+#include "en/txrx.h"
+
+#define MLX5E_TC_FLOW_ID_MASK  0x00ffffff
+
+static struct mlx5e_frag_page *mlx5e_get_frag(struct mlx5e_rq *rq,
+					      struct mlx5_cqe64 *cqe)
+{
+	struct mlx5e_frag_page *fp;
+
+	if (rq->wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ) {
+		u16 wqe_id         = be16_to_cpu(cqe->wqe_id);
+		u16 stride_ix      = mpwrq_get_cqe_stride_index(cqe);
+		u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
+		u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+		struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, wqe_id);
+		union mlx5e_alloc_units *au = &wi->alloc_units;
+
+		fp = &au->frag_pages[page_idx];
+	} else {
+		/* Legacy */
+		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
+		u16 ci = mlx5_wq_cyc_ctr2ix(wq, be16_to_cpu(cqe->wqe_counter));
+		struct mlx5e_wqe_frag_info *wi = get_frag(rq, ci);
+
+		fp = wi->frag_page;
+	}
+
+	return fp;
+}
+
+static void nvmeotcp_update_resync(struct mlx5e_nvmeotcp_queue *queue,
+				   struct mlx5e_cqe128 *cqe128)
+{
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+	u32 seq;
+
+	seq = be32_to_cpu(cqe128->resync_tcp_sn);
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->resync_request)
+		ulp_ops->resync_request(queue->sk, seq, ULP_DDP_RESYNC_PENDING);
+}
+
+static void mlx5e_nvmeotcp_advance_sgl_iter(struct mlx5e_nvmeotcp_queue *queue)
+{
+	struct mlx5e_nvmeotcp_queue_entry *nqe = &queue->ccid_table[queue->ccid];
+
+	queue->ccoff += nqe->sgl[queue->ccsglidx].length;
+	queue->ccoff_inner = 0;
+	queue->ccsglidx++;
+}
+
+static inline void
+mlx5e_nvmeotcp_add_skb_frag(struct net_device *netdev, struct sk_buff *skb,
+			    struct mlx5e_nvmeotcp_queue *queue,
+			    struct mlx5e_nvmeotcp_queue_entry *nqe, u32 fragsz)
+{
+	dma_sync_single_for_cpu(&netdev->dev,
+				nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
+				fragsz, DMA_FROM_DEVICE);
+
+	page_ref_inc(compound_head(sg_page(&nqe->sgl[queue->ccsglidx])));
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			sg_page(&nqe->sgl[queue->ccsglidx]),
+			nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
+			fragsz,
+			fragsz);
+}
+
+static inline void
+mlx5_nvmeotcp_add_tail_nonlinear(struct sk_buff *skb, skb_frag_t *org_frags,
+				 int org_nr_frags, int frag_index)
+{
+	while (org_nr_frags != frag_index) {
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				skb_frag_page(&org_frags[frag_index]),
+				skb_frag_off(&org_frags[frag_index]),
+				skb_frag_size(&org_frags[frag_index]),
+				skb_frag_size(&org_frags[frag_index]));
+		frag_index++;
+	}
+}
+
+static void
+mlx5_nvmeotcp_add_tail(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
+		       struct mlx5e_nvmeotcp_queue *queue, struct sk_buff *skb,
+		       int offset, int len)
+{
+	struct mlx5e_frag_page *frag_page = mlx5e_get_frag(rq, cqe);
+
+	frag_page->frags++;
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			virt_to_page(skb->data), offset, len, len);
+}
+
+static void mlx5_nvmeotcp_trim_nonlinear(struct sk_buff *skb, skb_frag_t *org_frags,
+					 int *frag_index, int remaining)
+{
+	unsigned int frag_size;
+	int nr_frags;
+
+	/* skip @remaining bytes in frags */
+	*frag_index = 0;
+	while (remaining) {
+		frag_size = skb_frag_size(&skb_shinfo(skb)->frags[*frag_index]);
+		if (frag_size > remaining) {
+			skb_frag_off_add(&skb_shinfo(skb)->frags[*frag_index],
+					 remaining);
+			skb_frag_size_sub(&skb_shinfo(skb)->frags[*frag_index],
+					  remaining);
+			remaining = 0;
+		} else {
+			remaining -= frag_size;
+			skb_frag_unref(skb, *frag_index);
+			*frag_index += 1;
+		}
+	}
+
+	/* save original frags for the tail and unref */
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	memcpy(&org_frags[*frag_index], &skb_shinfo(skb)->frags[*frag_index],
+	       (nr_frags - *frag_index) * sizeof(skb_frag_t));
+
+	/* remove frags from skb */
+	skb_shinfo(skb)->nr_frags = 0;
+	skb->len -= skb->data_len;
+	skb->truesize -= skb->data_len;
+	skb->data_len = 0;
+}
+
+static bool
+mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb,
+					struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
+	struct net_device *netdev = rq->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+	skb_frag_t org_frags[MAX_SKB_FRAGS];
+	struct mlx5e_nvmeotcp_queue *queue;
+	int org_nr_frags, frag_index;
+	struct mlx5e_cqe128 *cqe128;
+	u32 queue_id;
+
+	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
+	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
+	if (unlikely(!queue)) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	if (cqe_is_nvmeotcp_resync(cqe)) {
+		nvmeotcp_update_resync(queue, cqe128);
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	if (unlikely(queue->after_resync_cqe) && cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	skb->no_condense = cqe_is_nvmeotcp_zc(cqe);
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* cc ddp from cqe */
+	ccid	= be16_to_cpu(cqe128->ccid);
+	ccoff	= be32_to_cpu(cqe128->ccoff);
+	cclen	= be16_to_cpu(cqe128->cclen);
+	hlen	= be16_to_cpu(cqe128->hlen);
+
+	/* carve a hole in the skb for DDP data */
+	org_nr_frags = skb_shinfo(skb)->nr_frags;
+	mlx5_nvmeotcp_trim_nonlinear(skb, org_frags, &frag_index, cclen);
+	nqe = &queue->ccid_table[ccid];
+
+	/* packet starts new ccid? */
+	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
+		queue->ccid = ccid;
+		queue->ccoff = 0;
+		queue->ccoff_inner = 0;
+		queue->ccsglidx = 0;
+		queue->ccid_gen = nqe->ccid_gen;
+	}
+
+	/* skip inside cc until the ccoff in the cqe */
+	while (queue->ccoff + queue->ccoff_inner < ccoff) {
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
+		fragsz = min_t(off_t, remaining,
+			       ccoff - (queue->ccoff + queue->ccoff_inner));
+
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	/* adjust the skb according to the cqe cc */
+	while (to_copy < cclen) {
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
+		fragsz = min_t(int, remaining, cclen - to_copy);
+
+		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
+		to_copy += fragsz;
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	if (cqe_bcnt > hlen + cclen) {
+		remaining = cqe_bcnt - hlen - cclen;
+		mlx5_nvmeotcp_add_tail_nonlinear(skb, org_frags,
+						 org_nr_frags,
+						 frag_index);
+	}
+
+	mlx5e_nvmeotcp_put_queue(queue);
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
+				     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
+	struct net_device *netdev = rq->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5e_cqe128 *cqe128;
+	u32 queue_id;
+
+	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
+	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
+	if (unlikely(!queue)) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	if (cqe_is_nvmeotcp_resync(cqe)) {
+		nvmeotcp_update_resync(queue, cqe128);
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	if (unlikely(queue->after_resync_cqe) && cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	skb->no_condense = cqe_is_nvmeotcp_zc(cqe);
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* cc ddp from cqe */
+	ccid	= be16_to_cpu(cqe128->ccid);
+	ccoff	= be32_to_cpu(cqe128->ccoff);
+	cclen	= be16_to_cpu(cqe128->cclen);
+	hlen	= be16_to_cpu(cqe128->hlen);
+
+	/* carve a hole in the skb for DDP data */
+	skb_trim(skb, hlen);
+	nqe = &queue->ccid_table[ccid];
+
+	/* packet starts new ccid? */
+	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
+		queue->ccid = ccid;
+		queue->ccoff = 0;
+		queue->ccoff_inner = 0;
+		queue->ccsglidx = 0;
+		queue->ccid_gen = nqe->ccid_gen;
+	}
+
+	/* skip inside cc until the ccoff in the cqe */
+	while (queue->ccoff + queue->ccoff_inner < ccoff) {
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
+		fragsz = min_t(off_t, remaining,
+			       ccoff - (queue->ccoff + queue->ccoff_inner));
+
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	/* adjust the skb according to the cqe cc */
+	while (to_copy < cclen) {
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
+		fragsz = min_t(int, remaining, cclen - to_copy);
+
+		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
+		to_copy += fragsz;
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	if (cqe_bcnt > hlen + cclen) {
+		remaining = cqe_bcnt - hlen - cclen;
+		mlx5_nvmeotcp_add_tail(rq, cqe, queue, skb,
+				       offset_in_page(skb->data) +
+				       hlen + cclen, remaining);
+	}
+
+	mlx5e_nvmeotcp_put_queue(queue);
+	return true;
+}
+
+bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	if (skb->data_len)
+		return mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(rq, skb, cqe, cqe_bcnt);
+	else
+		return mlx5e_nvmeotcp_rebuild_rx_skb_linear(rq, skb, cqe, cqe_bcnt);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
new file mode 100644
index 000000000000..a8ca8a53bac6
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_RXTX_H__
+#define __MLX5E_NVMEOTCP_RXTX_H__
+
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+
+#include <linux/skbuff.h>
+#include "en_accel/nvmeotcp.h"
+
+bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt);
+
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	struct mlx5e_cqe128 *cqe128;
+
+	if (!cqe_is_nvmeotcp_zc(cqe))
+		return cqe_bcnt;
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	return be16_to_cpu(cqe128->hlen);
+}
+
+#else
+
+static inline bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{ return true; }
+
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{ return cqe_bcnt; }
+
+#endif /* CONFIG_MLX5_EN_NVMEOTCP */
+#endif /* __MLX5E_NVMEOTCP_RXTX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b0dabb349b7b..14dd03d2e402 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -53,7 +53,7 @@
 #include "en_accel/macsec.h"
 #include "en_accel/ipsec_rxtx.h"
 #include "en_accel/ktls_txrx.h"
-#include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_rxtx.h"
 #include "en/xdp.h"
 #include "en/xsk/rx.h"
 #include "en/health.h"
@@ -336,10 +336,6 @@ static inline void mlx5e_put_rx_frag(struct mlx5e_rq *rq,
 		mlx5e_page_release_fragmented(rq, frag->frag_page);
 }
 
-static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
-{
-	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
-}
 
 static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 			      u16 ix)
@@ -1566,7 +1562,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 
 #define MLX5E_CE_BIT_MASK 0x80
 
-static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
+static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      u32 cqe_bcnt,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
@@ -1577,6 +1573,13 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	skb->mac_len = ETH_HLEN;
 
+	if (IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) && cqe_is_nvmeotcp(cqe)) {
+		bool ret = mlx5e_nvmeotcp_rebuild_rx_skb(rq, skb, cqe, cqe_bcnt);
+
+		if (unlikely(!ret))
+			return ret;
+	}
+
 	if (unlikely(get_cqe_tls_offload(cqe)))
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
@@ -1623,6 +1626,8 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	if (unlikely(mlx5e_skb_is_multicast(skb)))
 		stats->mcast_packets++;
+
+	return true;
 }
 
 static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
@@ -1646,7 +1651,7 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	}
 }
 
-static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
+static inline bool mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 					 struct mlx5_cqe64 *cqe,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
@@ -1655,7 +1660,7 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+	return mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
 }
 
 static inline
@@ -1869,7 +1874,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1916,7 +1922,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1965,7 +1972,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -2011,13 +2019,18 @@ mlx5e_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 	}
 }
 
+static inline u16 mlx5e_get_headlen_hint(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	return min_t(u32, MLX5E_RX_MAX_HEAD, mlx5_nvmeotcp_get_headlen(cqe, cqe_bcnt));
+}
+
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
 				   u32 page_idx)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
-	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
+	u16 headlen = mlx5e_get_headlen_hint(cqe, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
@@ -2440,7 +2453,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2773,7 +2787,9 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 	if (!skb)
 		goto wq_cyc_pop;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
+
 	skb_push(skb, ETH_HLEN);
 
 	mlx5_devlink_trap_report(rq->mdev, trap_id, skb,
-- 
2.34.1


