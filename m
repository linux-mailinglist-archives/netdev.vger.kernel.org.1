Return-Path: <netdev+bounces-57451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD381319A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843351F222F4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC256458;
	Thu, 14 Dec 2023 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGsPZXVS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630912B
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:28:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx5SsnSwYatL4Hu7BiqEulljxKPqHyM2MXxOBUGHstgTcyFajhOwZqZES81EpmUlosiu6/YpW6HgedAdABKLUbAMl9cXE/2u+XsEnYDLri160f9rOHkpK4E4qGwLKcK9Fl4jmYWLttSTsrv6QClABLIpRIeYW+JkS14awoyXS6Jz6d8h4KG5dl23XjK7UqHqJM/uy0spl4Edm/cTHeas4mAPAy71G8YEJxFXuFSZ7nnA1SYCyU3Cshr2zROg7zxb8BH/PqzgtA6GIQyhM8TCClt2MmkqDFjXWahAfhe4WicdRDnE2JmL5PUgPuvpAlvovw65Fk1H9AOjyK6wKRzuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOlZDxSyHsLEZF97yXuUaM5RscokUivVILbVgtgH0yI=;
 b=Q6Wm2S4UbxLgaFQ6D16v7QB1cdW+VKmO6Kw6gaA+dxrkkbEdmfqZtwFfhVIsCfqCc6/EtNwTIiQzIs+isB1qr6vvEcZ/Xw83vTMvByflkcQ7xthkJ6T8eKiiw66godTMlR5rDxLa2TGXFGryGO86ce4gtdCHHUXq+G6iFBfa4OC+NJpVRhlj7fK5n9knePSELqgoxVaWRx+3CrIeyCsVElqu7nYoafbBkTusQHdwJhXH33XlX0yGgdG7XAD2CbV1kQfwLn3BGtAQW66G2Q3Rq53YFfSej43qyQGoPuXT5lR14fp6Nw9UVm5oDYXdkskLjQCRjhSLTZ2eYe9dSWCVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOlZDxSyHsLEZF97yXuUaM5RscokUivVILbVgtgH0yI=;
 b=JGsPZXVSAcNfATgVB1V5IV9qwuvkHZla8ZxDqb8rzJxZHtmkusFE/oCJvIHQ3jbJNrV1ZbGtH1YEB6Zx4jbLCcPIraw13IISAEVE3ooyjdpxgWxd7KXaFDIPixMd085lBYQInmxuQJqM/78LR+kVuzpA4PSKXS1yLuNbTB24/EIVp+99e7DDlMyDCrHCTa+p7x3ox8MiVamH9vN2TUtPWNGIKkL0VB2ha3Xqkv0at+mVA+FBXe1TAQ8XBus1XUogrxykhAsNmvL6ZkVOSaNR3JP7QHBvpqSYG+tg5pYjoC3Az/hIzwvgAYmnHc7HIlQ6G7oLJ5w5KjdIKU2chhdcaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:28:03 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:28:03 +0000
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
Subject: [PATCH v21 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Thu, 14 Dec 2023 13:26:21 +0000
Message-Id: <20231214132623.119227-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: ae10b87f-1b0b-4618-2b27-08dbfca88009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ippbjWf9u+4jvMVGI8xU5IaCvsUEzZypP0etYOwBrlNpBeJWFBs+ykFp3K03qCDkFnVjbpsBbJWLadxpa4abxyOwQxuStBGwdBmflpBmjl2OMlNJ6KYwef+BoL2bTJONXGWjiOKudAI9slgCsVX7zEqQtJaBGHxs1/tEf+trSYoGbKCWbpckDXy6nJ58AxBqfbm3IbXWyUiCg6NmCjuxcd2LCOTrf+YBfz+MmyqT/RUf7Q94sVKz795chf5LWCJ0Ea++P+Uo7lt571uPEYfRKoTv9PjTKD6+7jYLP24IMTL1jGmh9GWiRlUncCPN0LaBpgivbkwazO3Ht/qWd6KiLZrOhQfDO5Io/adnZgxGBgN4FN0IWwkmKO9j0ybOti77F74+Qqqvcki3J09wytaW91ha3ae684vppWjHrbbAs9MtB/ZYrGU3kycoV/4/tn+c7QyPzBIhkN0jFEQvxXZ1zcLdAXN/LKjPdOGoFFwzEtxrkr3GgprwoTJ83Bf4BccDliGhlRxFgES+E3Sqv3X5fJDsA+vN3rQ8M7dzAvkZFzZjLvUV9CIvdU7ml9HU3CB7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(107886003)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O8743IfeYrI15vTUt5kmpyf4udpwiR85hjHHDmY+DwTIwEkiFSxVRIgYzSyM?=
 =?us-ascii?Q?LVoEoO4FA/xrSwxhsnnqNjshLN0g0NOeAlcS6iAancQUXYBhP/wSldjqUUzF?=
 =?us-ascii?Q?iUeFLukeJF6JHosEVo7avNngI4m/LGESM8yX6COIVA4RsVAtZYDolN3ZUI/n?=
 =?us-ascii?Q?yUxwwKi6GAarryCRrCkYU4FAqrWTQLUwBz5hK5f9x81niV3/mTvbryOQM0lA?=
 =?us-ascii?Q?wQCN5kz/2uhWq5cfk798u8Hb0Z4AJEhUnksgXNGNtyjt7qvo0kFtK3I1tOSA?=
 =?us-ascii?Q?enfiLs0OF93Vt8OkMr9D7UuHeGniMA9zb+Hqfs8Givqm9f2CgN/Oa3WNkGaa?=
 =?us-ascii?Q?JubtOiTymv35E1lFImmcdMDXmiv3UjesdXnhYtJJXXSipQXaaRjtPXkPiLfV?=
 =?us-ascii?Q?aKk14+caIUTscJspFXTu+sGO3kJyT72Mc1+U1ZxdphYk2/JRbJFEra7ytXit?=
 =?us-ascii?Q?JPN3KGGlDzFSMLCC+Vshixxz5w4rnDjW6WdTzhokDjCYMD9lLX5haRkYfDeW?=
 =?us-ascii?Q?pEFvpjAjSqxUhMcuo2d8lv2lkp0m+E1gFs2mutS5t5eSZHJP3K4tyq31BFBd?=
 =?us-ascii?Q?9hpOjEvybGJBvzrTgFtzfFFsoAb+/eOFq8POoLlNPS1oespZOXhu6ryeCjLx?=
 =?us-ascii?Q?4DvStV/EtGM8s5Ncgn/DCfCK932cpVO7TbKaVKAuCcJK1+vidr19FQgAHktb?=
 =?us-ascii?Q?XG+bkCt1/oA8fXVbPQEgbv1PzmZAVQWGaOZldWxYBJ8xX4wf+vecyHdcTZ9g?=
 =?us-ascii?Q?FMdW3s/ugb96hMKnCBnJ14UlZkIHyVGU4I8l5Yqro3crV7cBGCNhFVkhF6X9?=
 =?us-ascii?Q?vuWeiHIE7M9elrHpjm4UOf1gD7Fxh0B+DvOQGiB2/pEsXHm6FaNACKtPWze/?=
 =?us-ascii?Q?coYnSdHxyr9gth7r5y8ulRu6cFmSe0DAz1GRJJ2EUsbczbsP2jYhrVs/fFia?=
 =?us-ascii?Q?/2ZDWRZZ7lMzPpQ01/qXGs/BFDTydjUGxNilVqb3s01Rn8nvPsI38+TJ/yL5?=
 =?us-ascii?Q?/TAhiwUGJIwXxgIzLA1y87mqnPdbs8wYj/OaOkvBfo3mMd/l25oLT+bBEHp2?=
 =?us-ascii?Q?2zH4ZLxafvCpEojux/deN+7Cq+VDVutbF9Xj/v5/bHYj6+5JAZ2Qe2VOG7CS?=
 =?us-ascii?Q?NTynGERQ/188T1hzGwgg42cHhq5MGug2Cbh+PlLn/ZuknyZopsFdv/JamzgO?=
 =?us-ascii?Q?xVFhMYiPq5S7i9FyYqjv6JeHsbEioolQxCc4h+mbDvN0uZCIWAUy5KPfBGlL?=
 =?us-ascii?Q?dIYAy++HvYEbNUc283mcxy++u+I8D2OiOFAbW8dnsWEjrOyh0GdZ6/rIuPFm?=
 =?us-ascii?Q?uq6s8wNQkQFvD5BrOOQ/F2paGTLi4yVsNgMwN0SSY0oYHuPYNKuAHEqzhXYA?=
 =?us-ascii?Q?h3OCRkDc+b3AvEnkif0EW/QgXCROG5qZe1yg3ITYEsbc3pKfB4Q1NLJdMuRw?=
 =?us-ascii?Q?Tkjumlm7MkonXY8Di/fyworOvLgDs5/VbJL3/DGWi3Ttxjh9JIV6s//a+izC?=
 =?us-ascii?Q?rCsoJ24jpSzekEEv/fd1lXRRqnT57SvM9wxrHyR4kP09HG13qq8oj09LIH3b?=
 =?us-ascii?Q?hGZCMdlJgqEswE6y88DfFkPMTs2h/eams3jyUXf8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae10b87f-1b0b-4618-2b27-08dbfca88009
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:28:03.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5elXwgAXFe6NW2wNow+nQDmLQyLnuF28H4PFpoXa/f2Th4tbfHLTZgrlpNoiGJFxVtn0nFQ82UkJIC12Navgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

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
index 8644021b8996..462e0d97f82c 100644
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
 
@@ -844,12 +859,43 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
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
index 8b29f3fde7f2..13817d8a0aae 100644
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
index 1ed206b9d189..b0dabb349b7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -968,6 +968,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 			break;
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
+		case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 			mlx5e_nvmeotcp_ctx_complete(wi);
 			break;
@@ -1073,6 +1076,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
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


