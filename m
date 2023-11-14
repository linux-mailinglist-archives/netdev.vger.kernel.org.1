Return-Path: <netdev+bounces-47710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217037EB014
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AD61C20AF9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE23FB0C;
	Tue, 14 Nov 2023 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tCRX+FdI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E63FB3E
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:44:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1D184
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:44:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKFK8tS3nytfNbJKmAG6ba7a+/cHbiTuiB//RyGWSVHwCqu3BGcUZyjcmdzi2N8JAtjhwsPlQqhVY7ySYWkiMs+MA+xgCWc6slwYmmXPZq70K2Ig8RAAYJFfr17iMJiioRWB15AWfv/DgcjsFWtbxdOfQwtLwdCyn6IRtOoDaFC2HHgZ4uJLftAba/ze3j21GL5rfhj3fS/WI3OWpsdHEYLeoh5rnFKTXmglmfKzuUkGNuBn4f20k8is6coSq/eEsDGeNZIADwOUA5sBQ2RziuIIYK5Oo6qwCekhKJ/cm3wRV7b2gHfrOoDDsrzyAiH2et6MsJSDEKBD3dmglNSC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm8IFxzaM/q8qRMAmdrMvAwNLzO0LPbeZT7OVqyPrLs=;
 b=QXQTkl1HL2EHYMCpAmYnVcio2w+/nEessLW1TmyMC5jTbKAd908nAUAExZBNmoyB5kS9Zh9JM92xiJfSVowUIENM2mFd0E6U0h2zevkQLoPi/FjYy0uE/4Ele6FCWLRPC61zWjSkTWqHSplRgBwPFZ0X/8/UjSLxrvM20jgHK7dnUnROjWkQHNE1E0z7mfJgHjSY6RgM+YrnFD4vQnNJGIqB/Vl16mNzOl1tiiRlB49tXfY0zs779Rn49BnQJILZtbknRj1lvSECD4SNGhv2E3IK8YFPFntcD15AZT75tjSqO57CXIRuFddo5wYVdeSZVIJAadSgtn7iYV7LIxaYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm8IFxzaM/q8qRMAmdrMvAwNLzO0LPbeZT7OVqyPrLs=;
 b=tCRX+FdIqSE1svYwoEhILb+WOifzALTmtPz0aBlI9aJN92Z5t1ewhvsJTSnELaKeIzS9hIzizPigvTTNds+i0/L1imDA1IWxiNTdVDGs4Dxwc7XvDQACxpmdQu/DGrGY/SbjbYVT/uGa3NuFaOUYrmU4okjm/zABOumWhNjQKZgkBRmcgCnwPxaAyBMuX+HinEQ1wXkKV0UkyAll6dEXSioMbUtEE+g45nDvndsjabjbe/2L3lUVLU6R/rMp7KY1kkcuR5dVqriEtEICPUuUUzFMYh51QetdFSGMpdoSfFcN6MjQFDXUdv/+zw4CbtuCTqfPn2dh7BYnyEGCftI6tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:44:06 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:44:06 +0000
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
Subject: [PATCH v19 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Tue, 14 Nov 2023 12:42:46 +0000
Message-Id: <20231114124255.765473-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f6fa1f-2df5-4622-b136-08dbe50f63c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ljSVlEgkXei9DJbiuZSSKF5YszyL9KZTNLnnmKFWbAK9jHBKKuSl34/Z5FA1jtZynFE9JnwiEP5QPsimz0EbSbmSoggmcFOlPI9eNoMnB+7hNC6dLGLq62bfbDC2FCENNnAZWxENar945GMyWf+T9CrYaeKBy4QXoZFL4Qoh5jCdEwox6hctHmMBuzWG2vsADv5TOrYkp2FbqRic89ju0zY1aV7rD8T0ctxLN0874Gir8OirJSc37NPEWVExbe8BgylMkqf2IepSKT8uzBVYaoNNosuDNVnImoPFhEqOLn1yCDGjy3Wf9WbhdoIuBngpdGQ2otUO+ovH8xL6gtBtatTPmDyO+mHkX1xdYCDd+O5o36p8tvi++FkerTB22G2vCwAdRg09+365qdMvqwL2hGEo4LZG/BXVq1cbLp0wTMSbw3W8iRxsih9L9x3EDwn9fIN05o1TK8dEV2gm8mqWjOiYVcBxfhiNo7dcxzG2P6GjXmT70qYhHk7GbY3Hs1x8pWc+Xx7ney64q0osOb5BLxfcg6CQZTTZMoIRoYkK2+esTj2SWnz9w/PNTaqKiXJv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(1076003)(107886003)(6506007)(6666004)(2616005)(6512007)(83380400001)(8936002)(4326008)(5660300002)(7416002)(41300700001)(8676002)(2906002)(6486002)(478600001)(316002)(66556008)(66946007)(66476007)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xfd+ooqvP7ypfutyTh3l46fEqqZk4Bc1hoS8I6pSrJO9LnmAJ1gG//P6QDW1?=
 =?us-ascii?Q?6xvg0BKEnHk/lL4/X2vE3IVVZSc5g5e1N7TFvi0m0fwsvgHWcrNeG3llwLW4?=
 =?us-ascii?Q?hh24+xFr/1W681MWxT2UcC8g5WToT00XM9SVjlUGFEcNlfCTq7GQe7wPDca3?=
 =?us-ascii?Q?q16HLYEvlXy2ZcZqEW6d7c4eH17priPTsOlmR3cDplx0Oj2l2rY4eHDtmPXP?=
 =?us-ascii?Q?G3NTVxSMy8pRvXK3OctEHxRREoynRaFXrBhzXDPCQa66OS3OCiHAFJRXbo9e?=
 =?us-ascii?Q?pLtlAlZBAY0p0bHe1TeGItBljADz/SJdVdnuvErcoWdXQxRARS2LilgZhvMa?=
 =?us-ascii?Q?oruIjNebOVYCIdKflzCYFXZWh0DW/q1kwl0lHYopsUCHUI4OW7FibptC76NL?=
 =?us-ascii?Q?nJwoX3E9RwP6OZG/t1SsmFJAIzyRrrQQ+3Yzdx68fn9lmiFLzm2qBd9LvOKR?=
 =?us-ascii?Q?2mI2Rnm0LClhHoQgpUNm2ipj40HREmIslrxylENiqqfeQUhPDMOUaMt8kOn0?=
 =?us-ascii?Q?0zhIVlKWtN4Myupmx+w559O3hyrMBTrj4IRQtH1IStLiV1RFItVPrY2Kgimh?=
 =?us-ascii?Q?HEIkv3Hx83TU9GKHMjHYuloqaT094qHq/YMsbboDXAbP4zVsuNDGbIvJPkVh?=
 =?us-ascii?Q?fHlQT/M031I3t20M98CP0HaD7KlW4YsnN2GSHFfPCr20baf/KNEtJkKet+Mw?=
 =?us-ascii?Q?NotuvZZShwCpv4vjj5PbPAVu0I/pU32/4UJXRustmzRQMaGikugNvawMijAq?=
 =?us-ascii?Q?Ng7oKA3ZxIYXqzWAd4qqG/6YDLUo2frZyX85TGnJseGA5fWBwdOCEmOOjTHQ?=
 =?us-ascii?Q?fjrvRO6CBYir7mkaZvITQIpwWw6fvhzm1pelG0M9DoYXeziIJEUPUkuQN7FO?=
 =?us-ascii?Q?RMwhAWzOgnfGv8gbdx2UfBzm4utsJbPeLKaw7niVUifIrvt54PU+fQ8iE3gA?=
 =?us-ascii?Q?Ev1L8C/inBQH42Dc3+0N05WvauHY9cAxAm3x4c9L62xLvgibgN8TD7mz5e3V?=
 =?us-ascii?Q?Ze7hwpd3HxZHSPMGg8PApuPWJKzcRUsj/FDsjf+TczfY+b4wCtat3ytoZ+qs?=
 =?us-ascii?Q?fVK0rNKBZDm0FMRd/k04qCdQjtH1yOacYKLQEoGaCTtxglYn7Tz7ubvf80Jc?=
 =?us-ascii?Q?ebuMALl0t6Za9DQp675kJlrMHRQ+txCrQg9vmX4Udxvjm8LBhoqdmtz9I29C?=
 =?us-ascii?Q?LImWdXw+lL+44jbQx7aBmh3EnyvwRt/akdT61vAhcgZxpFtCrey4uWz4yp2y?=
 =?us-ascii?Q?qr7Q+RZ94+JU5ZMgTM2mBIygpTo4CUxY6zAuNAPhwKq/iM5G9MVNKf0aot7H?=
 =?us-ascii?Q?eJ34ui8D0MkJVeIht66Jrl0EbT7pqYhgYKwKAivrBZpetUmh41YwOUV6kVpr?=
 =?us-ascii?Q?dqs+gxADQhKLWDTylghuwzGI0NrShjAEWF/+neWoC1O5wL8Al0NMyPnbdf+t?=
 =?us-ascii?Q?ec7HnqhIfh6U9KuCgSKiGOLGaRbwuDsd/BrU+/7UQLVi94j3PCeT4+1yx3Z/?=
 =?us-ascii?Q?TsqaVo62TP2U0WJUfJ/6/qdaAb5Sc0KlCnURYgJww4rZuy6nh+XxYQVvz2JT?=
 =?us-ascii?Q?C5ZMV0VcxSEILSIE0al1NFWcLWnUTVm0oiB1tI0i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6fa1f-2df5-4622-b136-08dbe50f63c1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:44:06.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgldDBhNDpOdKn38DOQgDdlMLNbPLZFmWdiBY+F4StP2mJt4EvaONt44SS78JeMSZjXzTnEhHBJ+ngpD1i4H0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463

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
index 931b97d9153d..8324564c313c 100644
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
@@ -11971,6 +11991,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11978,6 +11999,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12344,6 +12366,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12357,6 +12393,13 @@ enum {
 
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
@@ -12379,7 +12422,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12678,4 +12734,15 @@ struct mlx5_ifc_msees_reg_bits {
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


