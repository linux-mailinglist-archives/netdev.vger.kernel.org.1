Return-Path: <netdev+bounces-32256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C4D793B84
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562392813F4
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2B710949;
	Wed,  6 Sep 2023 11:33:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907576126
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:33:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1191BC0
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgTDBNyCh0fVBDXa8hn90PNgL3GPi8PsFgk9SrzH369GJnWrx0Mjlm/nzgX8xUzgFTpA0M0h1xIRZFbaNeCycgcF6ymKemMe6YyRLuR3NltlUeCWmLX1ls7fFGyfr2CrxAOJSen18JiupaGwraWOtP8fDaytLD8cfuv0OVSRKPxsN7DfJ8lM+LLU5EPdQrnlqlNG0mjE/1sE8RrATO6hKhFxqAT0mKucnawDH/clSUBKpmuRYnKDH+OZYQossqd4eL+STm5Kx30o67z/LS1MCUELk/M+b7BLYxwrzvd/u+oR8h0hZWk5vP+7dM+LG3jk7yONd51LFg6TRRy2MFmiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aviAbnfTC1zJEeH5GytM4MKZjJ/MmS2ecBDSMux3OE=;
 b=I2Smto8nmQEjnImLYNdYST6b5SgPjROfwQvOwBbKtg8yU2NTvnbdyEOeMcCn2FToRElxPThaqcoFZzK7L3OiBzdaafQuVQ27qr7aY5jRYdYCQ25VZBuZVTNFhsvnSjxou488J8yZ6//MahQd25R0zoMNWxmw1bFUlLwv7Xr5rlecOg2IHrRx+JsEylzFvQU5b8useGjSLwfPHTepDp3OzVraUny4DH+9GbWE6hMDp8Yjw5kIqwuotJYd2h923h8Xf1K43m+GS13qnSrjGmbQJamZeu1hTSolLfFysMgKOY2lWrABFdyGo5XQ8NpgVRlPrURIUV4JO7Rq8YeeSi+aTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aviAbnfTC1zJEeH5GytM4MKZjJ/MmS2ecBDSMux3OE=;
 b=my2oj2D2+o9j+OysRE6gQwfLzUwqaT+msAw+m8mh1MmqPdex1RturPhJznjvvWaVpg/IpXX1CmMGduJWiD+krVeDgjr34pA9qNebxNna0wFDEutqG6zbNZY7QTh1fDAvkdAabp81KdGy+lMjiMaM3OvX6/EIufMSpNs/+/WeZNcLNWEekMTsErSKxuQFV2EsWQfQDYKxDFDesfX25vevdPo47rh5olB4O2zqmeiNZNDU0UCqLH5EYtN1aK173u1/C0TIx5CW+ntfN8ltmsePRB9EDBPsl6I9VoQhT55scvqSc6Us5mth7xxoUqn1earWLibPbdrZKWmoBYjOypPYuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:32:31 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:32:31 +0000
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
Subject: [PATCH v14 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Wed,  6 Sep 2023 11:30:16 +0000
Message-Id: <20230906113018.2856-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: be8eb3c8-ef61-4c50-a94e-08dbaeccf511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8jdibxxqw4IfiG2By51LKgj23RGlRMLbCayJ1xXW0Wx14u18X5hmieckpe+5K9awxGHkPRgxERmMaZ3cUC9KC21Rn0WD2MjBIsHzJtAir+fWgeNGgQKJC34OzAmFy+T2HeDMPdBsxwGwCPcxN0YTW3DjPOLp2P/TStd7hJ+6DS7poxdUN06OnmOcbMqwojZxamnR+GZFRI7GNgbx+GeRjY5COFsx/D/m1uBI6CwQx4TQMlf89gi/2zNJXkKZc0I+Grmskkf+ZfAXEkRmW0cegFwRB3Xhc7iJtXJtoJPGNTm5g33i3fiy+Z0Hnun1L3IN0uIU8CqaRPNP0TINwnYklvQMCozs1MUhkA0+zm6YqQABc36Pa1C9AM94p3HUp0deuvnqHD3SU5VRGWAh14hQdZZHqOEen7EHJA00G7PiYhM1mDWRbjds7vCO4iv5k+BdzEdrxWzP4is02nZjRJ99Gv0qzw2rwQcWki9oK0RV8ewnVkZttJEDDG/08XQHLZB5+NrlfJiRM6w0C4w6FAWCPyYSGFwee7Uw/XjF/0nclTgWg+TAGFxY3+cDfNs+1LEm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(186009)(1800799009)(451199024)(6512007)(2616005)(83380400001)(26005)(6486002)(4326008)(6506007)(5660300002)(8676002)(8936002)(38100700002)(107886003)(1076003)(6666004)(478600001)(7416002)(86362001)(41300700001)(36756003)(2906002)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nadERUdUfXYHJd8Ki+iq1HgHpDuLgiSlwE3zOGptfRiyM8ENTvOUtRARuSEW?=
 =?us-ascii?Q?Esn2qdo985nSskMwTL7tmFw2SnhRrUGg0PT8RuounEn/XJ5GubJLFxspdbDT?=
 =?us-ascii?Q?y/ravc9ZI5tkyBhJq7P7mauDxe+P7LL4ercEVo0HW/Kfu5amVwz8nQIjeF+p?=
 =?us-ascii?Q?LP8K/u4DlTDtp+YtjuxZH4m/zAKVy18gPlckqTVeHISbKvg+deUEAIfpQsbx?=
 =?us-ascii?Q?2JjS37KJxb1S9dJJpMvxYzedCu/n050uysYeHQbmkP2aa0FazvMQJxfSgZBl?=
 =?us-ascii?Q?abUOlkTpsdAeJ85V66cKOWs0wxAHY9NLfsRHYothumrnvVJv0RChTlJ0lVXQ?=
 =?us-ascii?Q?nLQ0zQvlg6yYB+pwoDrxN6yPUfqeheYGfc2c7C7Bw9rrvhyk8OITsMQ+H1Vr?=
 =?us-ascii?Q?sfTK3MOhut8zfX4Y+Bd2zRd9nxXQ0d6qa7H6cDayD5n6nlgLnqcTRthFFmVa?=
 =?us-ascii?Q?3JR5bOTKoLku0khd1csPX0rKb7kRb0SEQfm+7TyvJwE1t7mf/tCL5jRzJei2?=
 =?us-ascii?Q?jquJUhd/hEJBi+j1lBsAtEtShaKuV4hQVGiO+Cp1EaZsf12zSmXGiGpUwJTc?=
 =?us-ascii?Q?HN1NurDInKhlwNS3tIQLwP8cos+UA59TI4TeOKoKRe6z1ncSOhhHuwEa7jr9?=
 =?us-ascii?Q?AQKNMZ6dXeGimirWlbx1WAZPc2pMEXcmB+9VrjkQS2aAgHpd4EFLpH5WmPh4?=
 =?us-ascii?Q?ZfQlG9u5Jx3L/sIvJa11etxKCJoVVvJrLJf0WDR1C3ZTkBzrM2WX7eqM4u3S?=
 =?us-ascii?Q?JkYEiJXtCEOR246WTS0hKky74qS6KInTOSBUff8TCLE8WyFhxDS6yV+GL+qB?=
 =?us-ascii?Q?YZyggjygdj/DfmJxupMzr/RdsfyDyFsLu6Y+8Ub6mMYGPRF5EAlle5decC4w?=
 =?us-ascii?Q?Qq12KiukDE0JG8wkuZwBHjPwY7A5kjqvpZKCCuaiq9sGVRZIr7x78SJSR7s7?=
 =?us-ascii?Q?MPcvKfottyX89K9nLvxC6NVjCH5Bmx4bUEsDj9FMalyOvDg3fMVagiW2S59N?=
 =?us-ascii?Q?y77K+592QeJSOKLkrsBO+FhkeEyv0DU0Ag1SkPmxW9y7uZogEeNhOZp3TGe3?=
 =?us-ascii?Q?m2JoehfxN7wze6C99RiGbYsVKEAGAhJt6qeiUxkRXo3R4Nf8WZbioimNkFM3?=
 =?us-ascii?Q?Yn1xtelhUPS3HsbIom6ALyLQSsBCqr3LVtEDHlRcciAP56e17nJoUeasNzUI?=
 =?us-ascii?Q?x9tDYqhXd+9xB8M0u3xAkaLTjEPVGznyxbKKkTi7glubRhr3ZfvzsopCPdDS?=
 =?us-ascii?Q?52Ba0Al2EdR6C4ZyQNXyKkkgBqXxRh039hbc6WH8dcvqdg+CbHiCAZVqHCIt?=
 =?us-ascii?Q?BMHQcCG9fgJ4LOmUXzF2imGXbWL9paxPrjfPgUtY9zMhm9B/8ezaiBjeCJnf?=
 =?us-ascii?Q?KjU1LD+yZXxbq4qOJSmw9CyvEgNhlUlSoiyLQR8I1zsCaUhKp/R+XWpAE3FV?=
 =?us-ascii?Q?8phwgl3Qby1kloszuAOdWosPF8a40JpJSQT2Y4b8V6xgZjEfQvXD/CqkvWMJ?=
 =?us-ascii?Q?0TcY/E8IMO+l1eN3S+1ad0gyYC5crn6BgwVro3K0vJ+Bj+wAhDiwyaN9qfYi?=
 =?us-ascii?Q?7tXQAhmtIBHTQQh/vgOtVx/obTCYJvXgjp1RnpCj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8eb3c8-ef61-4c50-a94e-08dbaeccf511
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:32:31.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlFdF0tUJNujNktRHotzxkvbwva6oVPdMxMRQBpnAEXcO57BXssgX2+ILd/9C1Rh4QNn/rDW+45UuXI6GxptRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


