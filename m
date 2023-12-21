Return-Path: <netdev+bounces-59774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C181C041
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B81C24B8C
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28F77620;
	Thu, 21 Dec 2023 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QoqNKL0p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8577F0F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtUT/n+XMNbkVRsdKt+BkKkdVqcXoR50tApOJT/vCFRfhIA84bYc/d2Ns4uzFyAMJY6yRcfR/1hrZi1lICtQ5Xo+lcxYJx/6GurlytbZoF2extBzaihUUryPQ2OuoeqwWBLzT21Jy6xnsf0qAg3eo49ToCNwN+1ARuegubkol0AE1DXXMUsqDhu3m6blw7b6w7BdSWRHDDyEPm6dZCk85qc8q4PNYTdsixof9R6ZkrCwmIYai4mpmK22/ByDSfeFFpLV50oi/wRuoDAirZTHnywPNas/Aymqq0NyCCp140frmYztzrv8DjcwaOaD7xN9EEEmobumkQNb0odGK5Hf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2tSoZ3iT66rNXAP8OdSPtOyu6OiqwlCNJ8UQWUenAc=;
 b=fbuam2Fm3MFXaQKa+UlPm+V5V1gjzQ1YEddF2S6h2fwJcmUo9bl3c6GFAnETskqnzVbKmEWow8QPdRa9QBRhee7d6fwAXlksRBIekLIxGX3HcNvjwOapWIcs2p86E22NR1OcccQYy4qCxwbwlzSFfMxznfEb3owkN8R0Jua4Z0ZQzDCMloJUUTsLtC09O1fSqrhjnSnIH/rq2toXKmn5FBXdd4dja0ZPyXKl3kXLs2QAOWy7jPNUoKX/eqKXMMnps/PAoWdYnzZWXnoTl0soRNtsCvh9plXXJolJU1B8i5bmAUXKcHiaprRFwwwilOguyfFc/9f2zQlJhB+jtNEjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2tSoZ3iT66rNXAP8OdSPtOyu6OiqwlCNJ8UQWUenAc=;
 b=QoqNKL0p2OzrSWJvKaPT5aaLzz8Ic9Bdnn3ZQn/T4nlBaCwpWNBzIMg2WeV6C0k/qo0lorqwV5iKFe9qvcYHRsdAzsm5h/CKvzPOn1saWbpISjtB/ovuOhHiTxH+3fd8veKojw6S0gbM8+sJ3Y1Ei/PodvKal/cluI33H7ZuP8bh1+0rbHwJK3JpOckniU+AC9mt8JNh03q3ufZzM7EwE0yXu1ZCa77xl1bwy8rzw/i0bt5RdfaL0sA/HVGwabXDEUowGZn+lEWr4ckmtWbc0zLLiouIq3XkNYqm9jj1Ipl7kO2UFomL3XNAl0YfJd4nYbiPNVN0Gx6Fz6QLdGu+1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:35:03 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:35:03 +0000
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
Subject: [PATCH v22 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Thu, 21 Dec 2023 21:33:50 +0000
Message-Id: <20231221213358.105704-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0286.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 9449e9cb-259a-4ccd-5006-08dc026cb10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xTrsoFlSQvKoXYHeAghxMUS8RL6nYGWfOfCVts5OH0yFesNXQ9Sa1IxqnB/UUQ1GyDVf+DMF2jQIKjp2U0vaIM/fJfTsm7/BeoXL4ZjRR21QPKuTVFeHsVOEnV7eT6bMhfQSvsVuIZ0OAvdugun6y2UmS9sWnSlwBb6BDpetVySrQZ9pbHAJXfDPWXOd8FkSQjWTNjaj4dMCQ65ncBm5iLDL9NSZ0GojjDzcYpVbSfAKt36BXcDXvy3VAX0CKRXn5JQO2nqDb6cEgCci6GduRa/yWm44Eyaw2Axo3YN09Fluu2z1Z5v3/phpR5QiEdHZ80C8OcLWUm0kbywMrmlZQzhTc559zEuauyITAqVBRX6Y1btDY8JWssfxLYLKt9EFcHbCqNRO3jkP41EfJY4g6HEM5RzmPCFWfcOwU+Gkd6sYsl54grTg8Cdzx6FHWZjq7vQ62CjtLW+pojDLO7lO+Dgwko4aIThK9+YoFlkoVfBV2X1lEDjYB8eWP7RyWurJneJFqFnVNW6P87GqaCGHE0Oaib/w2rW2YuWrUbZ5CX9kHgALSitaBtvJyQoWGlT5zYjnkztw1J643wvaaKH8mVRtxMa47bSmdMyFtzvQk/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(6666004)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fFGCJKgU2fPhYi3txlgtfUYjbHS2l86Xmd1afClPEO0wr3laJVTKT7w/oZb9?=
 =?us-ascii?Q?xU2mnzBG0lDj4KENB6gpGA915QkqTokXY5c/P+s25/KQa4L9XGDv6H3fbyQW?=
 =?us-ascii?Q?tNe9iGAkoIFT0uJw3NDtJgDuTsPrbATtrH8EXy6Nnn4BGLlVDkXoGOGRjJzY?=
 =?us-ascii?Q?vFr3wrqzh2kuw5iwfIn7o8S7oKlqBGftzs9saST3Z7ryRIpIePyYzMEF9M8T?=
 =?us-ascii?Q?MOwN3bZRqltNbatQvKacuNSwIUrLgrPSi+McJYIrah0VO/fKHbfWycQGKUDN?=
 =?us-ascii?Q?CbSRBGIeOMC12qf8izezOeGqQfOKn2NorimOOaafGeBPgpl8VUfYREmRq7FY?=
 =?us-ascii?Q?iYhZcDxMeZ7o8wFrg0gDIboLfxaZpid+DsdPyT/2yu6/V+I3XlP8CmnfobJL?=
 =?us-ascii?Q?ZmRzPQasM6ykmf/fYYS71SOd5SS0+2qDZCErfw5OYz9xQLh6y3MtMr9J0iGK?=
 =?us-ascii?Q?bD5KZsSxbHH6ACNDeldkot29oP5OwFzpUv4b0ZTpBn3Eeo5ONDeoHXZunOci?=
 =?us-ascii?Q?ie9O2JfGXSejZ7BRfgqwVRH/awjdQr1TUHo//YNu4ZJUYElY4kCN6A6YXnbW?=
 =?us-ascii?Q?0Mcdtin3tcuOpR26lMY7K+b2JT9nwbSmYsfueNg10xf7/M880kdlUccPleMU?=
 =?us-ascii?Q?v+RfCWivlQukBXAPEShuQs9b7GaX/OZURYoiLOgh8TygLybp8VgiSgMSwWjf?=
 =?us-ascii?Q?Tn9WE16s5mJRE72PkppIfnw1SHOb6jo/SGld28ytFVJF2E5l2BjYn2rq0CUX?=
 =?us-ascii?Q?RPYA1i5rXD2uYaLNA8JRDIPrEXVesiTk9nRZgPC+II7et0AsA6sc3w3hoHeC?=
 =?us-ascii?Q?y+Osn0uL/yIF8v9JqsymP/ZzbdVRrKJqBAUjdtSM1MOUWR596t94yFKasZMz?=
 =?us-ascii?Q?Jw6ZXnvS/YwkHiTnIAiJx7dP6cjNWg9wyRUsC6PD91/vraIAXYt2+gnlY1dY?=
 =?us-ascii?Q?K+Gw9P2KFdThjPU+JBtrhwggU8R2g2ZXzCW15eo9rm/GH2G67t+drWvgCvck?=
 =?us-ascii?Q?LA8SnvzRkhoDfVZOqapkbrAR1ggJKi+/QpLBIOB4mp+88UVsJ0cOnxvUfQ0m?=
 =?us-ascii?Q?nUO7+05yseMMkqVGZv7giIoYL6yRWaQyoGDSr6XQWimqDiPlHktYGjt7L69Z?=
 =?us-ascii?Q?2nEOhzmU5pzYaczDpuKj7rIug8gsD3FTXF9olk6e1XZ/9bnCO6gDk6K5yfpT?=
 =?us-ascii?Q?14xol2pXSi2/XqDqCEQnLmcclHecXnMxfZ0JaCC/OJJXn7bjJJX34QI0ChIN?=
 =?us-ascii?Q?7HsndK+C2Iao+3mSkzJQASpysPdEWWvOM/e4w53+hF3TakKQ8WL23zwF9Dd4?=
 =?us-ascii?Q?wIf8ibhxMm0vKGphpZIt38Ne7A26eCrn94COxkAfiy50Mu5SKSdqnbh/xJMW?=
 =?us-ascii?Q?VkMSP3UjjuzXjZmwizbvQ+sYlZEw9P72or++AEJqghMBwv03+GVcuP9a2eOx?=
 =?us-ascii?Q?Plzw3XlBaGbxOkeVTcHX6+dyvOyxR5lC14QVXOp9eYnE7BLcBsAoP3KXtQeC?=
 =?us-ascii?Q?6ssdJRiS48m5OcXb3F+5RsY2hpP/K/91w5dYnYPeyfovFIQrGLHAKEotC2QT?=
 =?us-ascii?Q?XMKqQC1S4EPfpNbqJYcuFrWOFVUhCe7VzGz1+0o3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9449e9cb-259a-4ccd-5006-08dc026cb10a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:35:03.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGDt3TkWHrq7jtLUJFyVwc055ZNpn5NOAmensI7WD3nf+H4hgihoXDekCVW5l8XC4iqjm1aqK62jiMJ/ngoHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 75 ++++++++++++++++++--
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 58f4c0d0fafa..f1745f69337b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -280,6 +280,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index f1dde3c6a3f3..6416a5e8a8e6 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -264,6 +264,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -798,7 +799,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -847,6 +852,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -882,6 +900,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1222,6 +1262,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1429,6 +1470,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 7388410292ae..ea321c96c1c2 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1462,6 +1462,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x10];
 	u8         shared_object_to_user_object_allowed[0x1];
@@ -1486,7 +1500,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3475,6 +3491,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3727,7 +3744,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3758,7 +3777,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11974,6 +11994,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11981,6 +12002,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12347,6 +12369,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12360,6 +12396,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12382,7 +12425,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -12681,4 +12737,15 @@ struct mlx5_ifc_msees_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index bd53cf4be7bd..b72f08efe6de 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -227,6 +227,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


