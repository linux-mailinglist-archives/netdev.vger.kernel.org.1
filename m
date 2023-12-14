Return-Path: <netdev+bounces-57450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9527A813199
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8842832C1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33D55C18;
	Thu, 14 Dec 2023 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XDxikaiY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A24F182
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:28:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKgtCG1N91vGgzH7KXKeaRhwt+Gf9wkZsUoNZ7zdyzJFiwUlc3/4diJ5plnXjLmobssbYrGra4et8wsS1P8rGKDhZJpeK7KrfKch8gZCTwILkoKXx/oMK0vBLobsPlY+W7X9Z+Y28FmgTHwVw3SPs0tW74KMCiUncjJfYBGoojNF07RwZf4EZsvvuqFXVUNNFQRP4nzZzzmhkjApvnjmRzn7dkGqQZNqSIMhpggRd9mPbvHDQqjlSy4wNOXSlT0xP6b3DGjD7JbGqM2XHkYkac4PB89Pah3c8Ex/6Ae4s8VIpRjUGQSa82reQbWYTDUARrAIZUxURWHrkTtvccd+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvb7MfjxhflAFlTyS3xrsn3CQoP0HBbIVNA+ozK2lQ8=;
 b=YZT59HBlJ5bozV9Yss58c9/Bez7qMpT/VUsV0tZ/f3eOZr4QiRsYWKihQ5mbwugRZ5fIAsjUrLiZ4gj0hHxFU7av2cRs3Y8yQyoVDxG7NDm2BMCQGAPBpTIeyd9ubp5eyNyHl2loV6B/zQ1Nluy7WuWa7cDmo6a7jKktRLYgt8/WqWIqDtuQKcYLvn4ZZTA2qEt589CII83aScPmzOFpSwvfSW5lZDVi52eRcFRM/srtbghUHeq5r5fJIoy8TUJmpN9AxTvGvtY0zb/Zwx0KYxLrOSopo5dCF9iBcEOmt+pkHGRwq8cpB3Pmo3EnhGRgKok6RCipz5n2wwFHswYSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvb7MfjxhflAFlTyS3xrsn3CQoP0HBbIVNA+ozK2lQ8=;
 b=XDxikaiYwvQJJw0+qUXIOX2jx0oRxsOs1R1N4Tu5KLiNoUXiNG1WSw/hUZ0VTc8dPl9uy8yqoFSpIdarj8xk6Zppzr9qYYc8BcqrhO4G8o/9KSi/vDubj1pgTmXEdhm8JRSmjU9nAaRxDKKUyQhEs2Dp0400A7YBzdUhXJTV+zn7kD1V4UuCB5PGCLLauz+MOHlr/lDw107LQOfWPLwxiOC7IWTrIBxQwkCKgBkmwiF+j9IXMjUYYYVManHxgUoo8IspUC/rTEc0ce4FB8Pn2kw7wwf4uJrJjQdFjqkp626BkAz9jArf744YADH6qHxREMD6eU2/aiY/tlupjA2VlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:59 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:59 +0000
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
Subject: [PATCH v21 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Thu, 14 Dec 2023 13:26:20 +0000
Message-Id: <20231214132623.119227-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfab0b4-30cd-4040-9556-08dbfca87d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	elWf+/jO4nBghej+65nK0JmAnnl0XIoJOsUGKEKBqN59xCtLU675SVEsML/lDUHYvhic9iiH+0Z6VLvFHzPNj0qOjrKOIFkerMJhn4/6hjforx6AIUc4LZeCDzKs1p1QwbiLUS3LLvHXcJZyx/TgI++KKwUbgK0fVPaHAvmW9Sv1ZOUi5P4CQouINyP2TOZBleZAM4WsFA/4redqG9Mq5cGwor02NmYjsBQFgdJYTOq2BuJdxf+xKPfBSm+aNr3dfjrelOrxYjVXcfuYbM0D3WEDseTo/R/N8c9WzayoKgKpbk30BaHoXx8a1MNd4GJjF34oZ1GVKoacJOVTm912wpnsNv5t/K33V4jfWywU8tQ9AzslC7rxgPGNmSmCbLDGOnCedLPc8g2q3NBR2TfQj3/KBC5Y7xGVtZXdIE8uJoGhCcioZrMz5mYW/8GvnX9VeM59ONdlYWzZXC4onqooXJwzohNf2JgbntlHdexRTADW14OAmAn9yqQjCVGoaiH+fm75RVeQFc1bG3+cN/U4BHlTraKnJm3dwPvYkzae7mXICTzQrBEHjI2a3MavVQ7r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(107886003)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86k+9f6vu5DNNiMZklz2UEOaVNBVzC33uFO8iv54nh1oIJAuFpFIaK8LvJ3h?=
 =?us-ascii?Q?egT5lJJHTLH6nMVLwmM/mlBzNrk5kHPpsK49HHDpIRSja8Cs9MCZCkMbS7S9?=
 =?us-ascii?Q?UNKNLS2eee4cTwOsdVWphg2dVxBkazI5u56I8/gbeJSHeNCxAHEEP7L8OwCc?=
 =?us-ascii?Q?J9EjuZj7bnb6Fwfk018+NAjJrJ26OzD1rJGwTeU3RCKeQlXojz3wl7z5M8Au?=
 =?us-ascii?Q?rG+TKEemn4xh03HqoW7QvBPUlAdhNZKX2Dqa8qSoIFwZ58T5SCDT/EULsk//?=
 =?us-ascii?Q?ZzoWglUhIBua7gozRIXxe0SOQR9f19D6dQYO3BHrtXvJVsQt+NF/2NF8WEFZ?=
 =?us-ascii?Q?cWi5OK+N/lGGPldCvQ+vdLUeSZ2MQvX9MMOHGpfthAlCjYSJlO3IWnscAu8w?=
 =?us-ascii?Q?ITr+dlhJkmxlPm/eHVq0op5QyBFg2xIIh+qoGT4dhZQLXJh5OdC4ihq0iLyx?=
 =?us-ascii?Q?IJnzM5ILtt5xvNKB3Ky8QvhdgltdD2JngT141Rnly2FDapipHcJDvkmBZkZZ?=
 =?us-ascii?Q?lgJdqyBThf2wwGGEFvkzxdkcZB8l753m8EkkBpqpBZ6TyUnoofzcKVDvh/PE?=
 =?us-ascii?Q?ceM+JLCaBOgTmIAsNFkAtXD4gyu+8aga2hUpbrTtFfXIut612B99ygxEf8tJ?=
 =?us-ascii?Q?eMUcMQkygiWGWgioxGCCqT4nCHhk5Vhe9KlPrvZBEMXbTB9Rvh9jmwT6qAz/?=
 =?us-ascii?Q?KnlQPvtx/KQj5x5n/VumIGyuSXCJ7DMXrExjCUrbEiZyCm2JLGde+w5OEP+E?=
 =?us-ascii?Q?LT3IwOz7Jg2TZp6JnrVPebGQkoEaOfxXxqfU7bXgp4cRt/1mc46sftz6FZZu?=
 =?us-ascii?Q?c8jWzv+vaady/zS1dKLlM2W8x0tTyk4GaGMKkwoL+bSXvogf2JSIaUXZKnP3?=
 =?us-ascii?Q?4YnuL0/ge7jd5uPRbGVQ5WVxUEBFFi/pn6oH6ULqNi+M/pHr/8+PTGpSxmmA?=
 =?us-ascii?Q?XdwoOYdG5d0Z5K9+GrQHCcOemT1DdwDeA1Yp8hra0CFw0JFrJT7ozmAXz97v?=
 =?us-ascii?Q?uz+JAZSmqZtDpbtTba/xhdcV9+FbntizsgwUqVzEHiMQXyvdWiCRTQuDjoZE?=
 =?us-ascii?Q?/v0leDARJ1GpaKC1QsUWWr8USHA1dnVUORJQnf9LuQaowbCdzS0fZvkHy53Y?=
 =?us-ascii?Q?sy+XGxS8Llxmo/cC+W6DgWuuJ16GolOqJwk8Cn2R/Ttu6tox7jQs6nb24Vt+?=
 =?us-ascii?Q?xngGTgpLVsN7SRpUK/Y/fH+t9qlLAXX7ahp/pu7fVQX1ABIh2yLocZrjSe6O?=
 =?us-ascii?Q?oDFjAlSQc4TrqOdoVD5rDD43wiAVlnLkReHMhSaz1OP3VRLtPSSMPz2fzCNa?=
 =?us-ascii?Q?SWEAS4mam0Hf0+cxfmEV8naFX+A3ln7rP6gixDuQ/kh9CTXKwh8kSWv8MhbN?=
 =?us-ascii?Q?+yzv0l4FU7JWuJm1sHNHCHNS2fcnQCLaJlAlmtwQBUp+f4C8JUZDK1IsTxBV?=
 =?us-ascii?Q?wPHMzF0FlOIDPfAHVpM1XPtuFcykBoRU4cka4ibTerL58Zou0E7ulKzaIQlM?=
 =?us-ascii?Q?DgPMWC5TAlOJcJejgcSmegJ59tSn1m96y6wqJHjHuoIhIDM19UnSZY+Z21C0?=
 =?us-ascii?Q?072vlGNHQMQvq0rCRXXqlz43KtXcgW9QHSPwl9VX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfab0b4-30cd-4040-9556-08dbfca87d8c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:59.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yva0dFM5+3t9ychfTcEDv6ZEfHDiKGFuHX5uSyKfyStgz9rDRexEbPDswhkMmp5VmzSiGF1FvL+nLNbNSBVlMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 146 +++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 56969fe337e7..8644021b8996 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -684,19 +684,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (count <= 0)
+		return -EINVAL;
 
-	/* Placeholder - map_sg and initializing the count */
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -719,6 +856,11 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


