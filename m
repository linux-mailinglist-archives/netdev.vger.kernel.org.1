Return-Path: <netdev+bounces-50064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B097F4833
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF5CB21108
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFF54FBC;
	Wed, 22 Nov 2023 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TLAiaVPO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9423D6C
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:50:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT14rE1dmYqfXCKp92H/wkch1Y0DVU+ZdXuTVdEUNJWCZ21jF0Z3pqTlAAb6c4KhvD3FRhvaeke/uz5VuCxtHdetdZLE0286ZV3EWxd6K9mWq4rSMY/AE/BL/p6ANpdNUrYuSWb41epwUVEdKRHexYSiZf7iodo/ydGWrA+R8ZZRcd1Sd+YDBOR2qiPrzNU0Pgtc05RFQqrDrvsgpZ9+5SEuABlDfbZ9BwJb9nkdLbX4qjYlfO/Dotkzkn1Oa4rZEpm3oLVCsfYVR4nW7+esO0O21wRNBjFA1h0vTn0yq+7B+mKDBtyogN9KL0pa6s7r8eX2tkVP3DpnYmSlFmCGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvb7MfjxhflAFlTyS3xrsn3CQoP0HBbIVNA+ozK2lQ8=;
 b=Mst7qQu0xVRIvXxGkeTvY1IK1J7bVQdhHV1UWCyO5MELJGhY2L98wqMKsuET2Gr10BEH/uSH8cWZC+IDNsutC5QGNpWV1rF3bOdDeLHQOtTizOCLHan+aPsySeNeSmTEVvQF2uPHKtsojuXAeQ+h62jkCeSgBKieGlviMTwemtikslNp+reV/UxU/jK8FSeHMUPWFp5SjIxgN/2rY5TQHLjnn50CC0zJPKzjS50q6Odhtp4rzR4QFs0RYxU2xFfl2RhTnFURz0ASrlbOnReu5OG/KdzM/c1Sl9+5ptzQq4g1VnDJdVTUGA76hnlK3SUlYgYkrkjtd+Ug5d09p5Utrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvb7MfjxhflAFlTyS3xrsn3CQoP0HBbIVNA+ozK2lQ8=;
 b=TLAiaVPO+ilL4iU0dggGmUTngMX8k7eFIxCVid548pmcx75Ln+iYHaZ6zKeJBdwkjBXQq9NZhcsCn3bDCe4LMRivcNV6PDOy6ZWC0TNkTiO4ox8z+NBIOSxCI4wpL5zr0FkRfJaablTACNOOZ2WjY/df7FD6Qy3fH+teoAYuiDwgwCWMutVDpAb8tPsOPYKZfgXaIEcpWJFg0pS6RnE1GqJ1kUVJpYLeoyPWz5hDg2spTs3FxgCe+ZoI7rkzdTYHZqPS6MkbxrAjyfHwrtE+kZUqzgqHv3dOSo/NQjTJ/3qUFpkpIKrFqaPaWSNTYBawmdTOOCGa+aBPr6Y7TSsCdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:50:03 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:50:03 +0000
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
Subject: [PATCH v20 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Wed, 22 Nov 2023 13:48:30 +0000
Message-Id: <20231122134833.20825-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4a1bec-f0e3-4940-cf53-08dbeb61ed59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mhGwOYVq1dlEPC+GYgDOyfeDq1rBDaellUmshTUZIVdQQpFFel1Pzn3ZtyqKmD84RcAXV4yzBGWHRC7KqDFIB3gLsjg50IELG96jYYz8QfdqahEFNxgOhAcoRa7Y6cNgLPJeJW4CYx/6FGxIFXkZfjPZZ8D5OLL8ZyIDxIadhg95e5y4eSB2prr2Xtx3xQ6K6vYqbp8B2m7ESs8E6UzHgb/JQ1KcTaRtIhU1VOr3Fj1QWn8obxuYVFEuJfiBcNZPdyWKtRTvfpLjxx38OB7oDQySbIScC8nlFxAFK1BtCMgIJblCQmTnHrUKUE2dKcdpWBxmEcQPPRghb80ZpHCWLti+N0wJPNFVPZiPh6Qz0YliW6vCNS1hkzusJwOTo3Vmk7eWZHihd6Xnvfv8Ldlc2xn+6x0XNfWgfpSqgck6gnhxTo+mJrLGaTAlNUID+TIFhbanQY9GGZFSei24vmUEOc9Pae9Q2b11L+73V2EbzL0v5ZNRCDmH9ww21Dl7zryYqaxVa0HPDmMj+rk7iW9HOUqNqftP7P49Ad+ghUt2PAZPLsh3T0UR5tWjh7S1+IRp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxNzp/WUNzr54SBASanzhFTx5kuUDIHEHmFRgSIpVldUGLvcqEeo5WH7badA?=
 =?us-ascii?Q?ZpgC7Gonh7DkptwI+XeC+qsKdSVHiSa/U0LHvEUWCImJ0/GI/t7+urje5hNC?=
 =?us-ascii?Q?NTrHvTjUetAet/AN+/zNQ3G4ok8fqUU7LMiK0jYwHSg6X9EMDtB1plkFCc7F?=
 =?us-ascii?Q?4fvg2astZKuoduMpjO051lCWUuE55MRLF4XYTXTlyHCnSxB4WFisSh79bXpT?=
 =?us-ascii?Q?F2Z8hvmsH5T9jWXXWIHEFFXHw5YwX0K41UTPoEgLgB8QMh5JZDlOxFEHd6ax?=
 =?us-ascii?Q?2vo1ChHeizvKdzToeS7A3qeRdntNnJ146TvtMdEfthyhfAJhAKfMvHDSTFpA?=
 =?us-ascii?Q?b/sdHyUOMBqxTZVO7iddVeQ0tmAazHdSyTly4ArIzBcyZBW62WPGIx2ILlMU?=
 =?us-ascii?Q?zCpV228iEte8aQWJ9mBxq8Ui1twLsUOUhTtRud5R/Q8qz4Z2ZQfDw3IdJZYj?=
 =?us-ascii?Q?htH+m8btEyn90AVkXg/Qan4DHSGNKqf3+soZMGxbSKoZ7SX5hY9kCmytP6ah?=
 =?us-ascii?Q?e7zomqoUsjC85izcF7qB04djS4o7TfxOBPcaBVB5opT3MTAzWiv13WXzkRp8?=
 =?us-ascii?Q?iQ3I4XhicPbXiLLvQqBECnGbQP8C9iQW9HpymDlFb6oxVXc75m8Qqe4CbNb4?=
 =?us-ascii?Q?FIpzAlH4HdMV0py/I4X3OStcre61dSons4d0o+JNzpupJuOr00jv5iWJxro2?=
 =?us-ascii?Q?Noqq/Jb9dKQI5xeaIKFRStbcVwoER7TLNwJgx/bqPKBCI6Bgej/8TnxCd5V6?=
 =?us-ascii?Q?DqoJsKqHx/CC4ooDCOyZe6WsU829O66vLQakuk5TRKiPmfLt9ySmQwuqrBYY?=
 =?us-ascii?Q?a2d5Ah7ABfDCtz330aQNvoSahbEmFdSIp1h87nH44s8WuElR7ES20TqA4oAn?=
 =?us-ascii?Q?gq2WDAIQ8fuVrE8EDEaZDqw3PGDVciuVo+4hlCu9pw+lXQv8V6cm0+hk0qZT?=
 =?us-ascii?Q?BXUXcA3Qu/AqlMb2jkyJhuqI8QMB6RJ6GJyJAXCa7vpleBlJLSgKh3Pyuwet?=
 =?us-ascii?Q?sLWEA74FAXDjAR/N5bxXDCizHnD7yOPRBMBRPTOhx4NUU1/4D9uKQ226lOAO?=
 =?us-ascii?Q?4nzD/NoJxls54qDxlCRPC8kuZgHPx1CkCZk+4nixaBwkSeHFP8Vgijchf0cc?=
 =?us-ascii?Q?T5QIRU6Y5FaIlDxk41RiAz/oN73UQv2xGMK2u2hM3CsZzhQyGVPd5mI8qBry?=
 =?us-ascii?Q?cgiKfhq9StWYDue+mIpR+NHurBMaIMemwCpU9H0IH9n8uA+nxB1Tb2AfyZdw?=
 =?us-ascii?Q?Hu8p/ieeGIDHYN1MQaHLUzQHRnmInd6TgitEa7ZlUQSQh4Yuut5nzl081iz+?=
 =?us-ascii?Q?XgV/mk/zBAgkNSQpQSXLCC85NSOyvByueeS205K8c1TJpt1xppew4iTRejEQ?=
 =?us-ascii?Q?2u5I1hoaVe/xYCLw4kjdkaYomaZAWhm0zeQUgMGHNZtUof0FsWzh3CETkUL+?=
 =?us-ascii?Q?DyMEcI7q7nhWbPfTWhLtntI3X1+0fLwqBVgpwTwIHGXlLC6G2yI8PUV1QS35?=
 =?us-ascii?Q?HQsiud2AK7nGceqDbVReHOrJWRFkrARf/japa3sgAtdyO2eJPF37HQzDGpkj?=
 =?us-ascii?Q?wIL9wNM5smkUO0PCFpaRVMd5fjEfbKe4lY0NZb8J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4a1bec-f0e3-4940-cf53-08dbeb61ed59
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:50:03.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4Vpn6NUQajQ2HsN+QxcAZuhHh3fUuT/anaQzn6o17tUV72Yzmx/dcpB1kMLMewEDv+0pNN4ScQ81FInxQ943A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

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


