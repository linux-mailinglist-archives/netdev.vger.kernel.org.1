Return-Path: <netdev+bounces-33148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C509E79CD53
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BE62821CC
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C918042;
	Tue, 12 Sep 2023 10:01:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7B168D5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22CDE6C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf5LxlOW2f4aFyDA5RglfVsct02K5PDLmaT12QVMIuBXuFPoLC7MtPABxiWUAa/+dKNgniXPoxW40oW4SIjA1kjj7NihNUvhKeY6WtWUlmdmuHgvEPF6isZMOb5nNsN7s9qswQXOqD5h6dq4XuCMMYz7HH9zqnOnXTzpXhci/2OWNpXs0q4K5KeKtS/ZRFOh+xQKdtxCSa/bFqvO/BHCg9CZ25pPjvVqP0LQRDjprHllO8UFqFNWtBK2TmwJWOjtQC8NlrZdJ6VCqWLMeyosirLzFlxWxHrsdl0MO5sSTjSqWfBazRFeE575S/snb8V10HjvDgpaTntC0attwt6CGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aviAbnfTC1zJEeH5GytM4MKZjJ/MmS2ecBDSMux3OE=;
 b=PhhstUDbNqtwd8oJaQ4ADq4/AeLJAEmdUML4NIUszHiI2XR6XzNm0J64bn1IPmgjAyoiWRUKgpahKFnxK/Gea4GjhLbJxDq56wz0TgDiaaQ3G1bJeFKf1wxy353yWE4CTZdkSvE03BKEGzFAjNqhR00NfNgiKIa7cX1Wr0dCFB7jBsoryJIwMzUehAlsJJFumqG6T2eokfe2K1c7vzFczwlrHHYbPJM3YkdfMCbMrlu01UA+PRLjRRFRvrdxFh7sU5zGGI5GTFj5QQpgSV8qq5jKKcnUvIlwypqlXeDQvRDnYPEw7UWQGDtxn/p5cEZ3ExP3Iha2zuRqBT/P1A78Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aviAbnfTC1zJEeH5GytM4MKZjJ/MmS2ecBDSMux3OE=;
 b=oE5Jaf+fKgy+JvH67gFGbgiFh95v7cYC31afq9IAj8G8twzuH+l7XbTiCW+D5l98oZP3KzvHg9e2pZjkBU55ru9MsgveTbqTCjQ8wwQtpKYngKIm4lZeTqqnw6KF8TsLvNdFklLbAAXjXl92H2Al37+zwM1l9djr71/7BBZJxQ2+s6V9k0mQshPpWMTV2JE8Qhjwj3BdgjUJu2zT1QG9E9l2jwt/FlP3KdCoMRV/iWDoWozHemjDvgEDf2r571mohHYWxs3F+p66z/e/lwBiaw+Bx+QGxI4RFOPWA/+aTVSSTQ44jWvR8sta5KakvydhTz5JiXOHzqXhgow1b84wjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 10:01:52 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:01:52 +0000
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
Subject: [PATCH v15 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Tue, 12 Sep 2023 09:59:47 +0000
Message-Id: <20230912095949.5474-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 5380d477-8cc0-4659-ca4c-08dbb37749a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8cWwIDkuK1uOhJohZQ6qyhy29EZrTGnmZxk3wco7saeP5azKfDUlaNQ2KUvpJWX37sHH9NbfwuflzL7JNQAENLYu/7SfCoPL6Jr4oQ4tJRlhlmrU/EplBlqgyNMqxaX4ned0brNQTAzLAK3otuVXURZiOHi5HVFN51CYF6Zujzal3OCEBAAyV6S0VLaflWn2gVx1B58lLK0dibrcQ07DA1d3uZVPn+DVeZcLYQ1SXkeveU3RyppjOYP9ZL3zlXthIPBRWeFeVCfC0rh4XSqVJ7D9rZ8GKw0B+ikAAy5FhR//QqjpZ5iajyLCMM7lJLZLfoRn8HXID/9LFeH1yZPZf4K/TXD6iyPthcKSvG0Hc3B5wYiq+n8Nf5vLP194GgVpFZ5kbZFiPnlFq6vCwx2cZWxuHAdB7H03x6DVTtZPjpTqLyC13JHMNQlE8QQV1+uuq4PAaexfTMafaTdyf80NF2sSifIjNm9WMcydJUUuOKxAKaDGdDKKgAfTAyESp+bwP7lD2WW/JDm1lw5+qsptvr/BSi3mkJqza2LiL3kkLdcrhaJsjelWZuMj96HVYMal
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(26005)(6666004)(6506007)(6486002)(83380400001)(1076003)(2616005)(107886003)(2906002)(7416002)(66556008)(316002)(66476007)(66946007)(478600001)(4326008)(5660300002)(8676002)(8936002)(36756003)(86362001)(38100700002)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3cdIZaGfouK/EGtGBuQOGVPt7u74JHsjDlDk7n0RrQRRSo2HTV7geTODMxaL?=
 =?us-ascii?Q?dFis5kZ1cbT9RVNbxAzIhIFgwHwLNjcQpjg6DwDc4Xn4zxwcODQ4tl7kAWKs?=
 =?us-ascii?Q?1cqiRbWrFPFmZyv/+CFMak99WHo35TomCo7bBEeMGivXowKqaDv0kY9jC+WG?=
 =?us-ascii?Q?vDO/XrKqG76nECS7jLT3TbG2SFPYc1qbyEuFxkUD+ojHZsF5mdnlIa8dRv7l?=
 =?us-ascii?Q?Fno3ntw5MEKbUMgX7sCZd+ia2dvGehttarOk20YobYvrifLc0BveFBa3ZAAZ?=
 =?us-ascii?Q?z/thxAYT0BX/xsJDzfohLpLewcoHwDPCENjHFhbO2kvDqtp1HFe5PrSTyIsN?=
 =?us-ascii?Q?DruQ0uQrY76oyROGd3MzmU8tZ4Jc9zyRV16dMaGLncBji4PyRbk/PDCiyIFz?=
 =?us-ascii?Q?4Xlx1U2R5Aj6Ffq2JdppD+av5+N6WgmQyY82shD5N02SfmU440xZ2DNsCWa6?=
 =?us-ascii?Q?fuET06KVtTETKuOc9vPAP5XRLrgnvd8SGqaHUftLyE4EpdWJwYTv8XpFJmOp?=
 =?us-ascii?Q?p0JvnAjeyYO+jkSJ2j2Fevz9gJpUCTXP7Wa8FRCFPI6IjUG0BdqeUvHy6Eh0?=
 =?us-ascii?Q?HXlSccpju+CqcjuGw5o2ypuphfuH8U6qpAgM4gsCMkUs4Knlhnwj8mPaEmhn?=
 =?us-ascii?Q?0XKQnT7b9d0I6Xo21AkPUOA5wmjnR/FxJaulvGqRvLH3+Tzls8w2NmDcjMmZ?=
 =?us-ascii?Q?ySdGwZCMirz/93umqrOZcIRotXPcokikJgHiyea54h6Ac/Kd+5gtsQSHvQ/c?=
 =?us-ascii?Q?zVwARlSO8HyrQ0zcwdBWCCbylKhne/rvjnt/i8NI2/uQ8jJr8lMPt6QqlyqF?=
 =?us-ascii?Q?Mpjj5Q/GOR2AXxjvJ21SRhkOi63UJelSf5ilUg9clwmzAt+ZA3r/mskNAjNm?=
 =?us-ascii?Q?xaoTGZENEPKlwrTjaYACnmkr8EaTeSyIjw5aGo2dmN/Mbanxal2S2cn1FNte?=
 =?us-ascii?Q?gQ1wFX2hLrhNL3ERWlRzRrkWt26vLWJsN547MzZ6oqSS7CmXfGwts6FOnNBn?=
 =?us-ascii?Q?2eZB98qD20BvG+tV307Jj8N9hcDg448wDSHUUqSNsz2WAnqYdglUhouGrFuZ?=
 =?us-ascii?Q?kVCJP6DDzOAvBCphnQqngIvTpkQvxBPbn/FMRlOKUnGKRbpXYXhY9lYkXIRs?=
 =?us-ascii?Q?k7FVPKOOi3UH2x1BGAD5coUY4PjIY5oy238sP9RlT1nRDSamCZKz8pt6sNB6?=
 =?us-ascii?Q?XL06irQHHlvAfm+ZHuABoFHG92Vhii1u0XjN2eyQ1+b7ypIRcj3MU87jkkaC?=
 =?us-ascii?Q?I2iVFm+d2C5dk65hu+mXd5rALVWHbGd4dsKLxubvXVipIIzI201rKwIJ6p27?=
 =?us-ascii?Q?3Aoi5Jfikn67gQgW2wse1atQCUhhT/eL8mjLLJzOBM20E02zloCwdAPFY+8F?=
 =?us-ascii?Q?h13RzHI/L3Z5VK+PrCnrDCO4iMhd47DiyxWbkAgRgMrk7gW1A1DzXrJ3Zh0u?=
 =?us-ascii?Q?wbFuSs0mQG71OeGW5t4YgdOB6SQ07xqnmqobS26HIjnnoEu8nksEjXJoC/bh?=
 =?us-ascii?Q?dkVvcPXt0fmSlR+wXBz0Tsaf+Gx5hy3/avEYkUFm4tgJWusaZL5eIwwpntyN?=
 =?us-ascii?Q?cmGkRtWyNeI0rmfkjd2EwqlQMs8xfNQBxtBrQoQ9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5380d477-8cc0-4659-ca4c-08dbb37749a1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:01:52.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfhVdDW86WpR4M7WZPUcizwps1aOO6RqxB6QeeJS7b9l0qGxMOcV/BwUQXVXf52PNrT5ZVPEhw0stf242FiMtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

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


