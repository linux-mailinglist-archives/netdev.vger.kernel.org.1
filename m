Return-Path: <netdev+bounces-17248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F0A750E56
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1A52812BF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360020FBD;
	Wed, 12 Jul 2023 16:20:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDEA20FB2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:20:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C1268B
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJxWW+vKUqR/PHRqRcjQJm4EfsRh+nGMypRXLKFc7AACtvJWlOyySAa/N31NVt+1i4gy7jQmtVt8rix06ljEzru8y41dic6wl9NEdera0M3j+col9d87hZWHLdUbFNS/ReQ70fMqYbOfoV01ZStrf7I6H0c1FiNvfVRLK4f6r/GJtxaTGBD60JnYrgMq6rAx6ciHQCy6BsuBAUc7DRr3hj2uUAGsp5Nfk5w1FT1rL78zeMFP37Am2T6n7wrK61yetGZJj3Zf5MeAjyBQxtJv3ijcDzfG06ZdajUiLnGntHOWCgFSEUPufXcG9lGSdxr7r1gx8CuP6I/OCYjq+89okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d8KgNNk6Hye7QkRaDR9oNg40YSyKgS6r+tShNLHu9c=;
 b=G/8qYlxxVmaH5NwlAVV1np7VmOxb53qTLcKw+TvuHiyS8QnJ9oe/XkwlSjGbYVegrUtgvUFKlxE/tZZQY4mZcRcch3pD4GUPNC7XGppuVHfqedc5Ml/FstBUU8vbO40DnN7HKP0zi6iynTP/MJs8ufA9Mbe0eDyfvVvE+q61cpV0AtMHckSqslkSuJCX5U5IZLfEPOcX7BksGc808I/qow45fRaEP3B6T4QfKACQXrbEvkg6oAgjiRybxPJBYY3vxQCjXQo5PlORu1GXzbGDk7BQvj3Qx9/46gIgxJPoDTC9SOKRIfYpQjuw/dcbRCiRA0BHNHnnYwnu6GwwwcIEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d8KgNNk6Hye7QkRaDR9oNg40YSyKgS6r+tShNLHu9c=;
 b=h4nY8xzBA0Hkod2dh4XNAR+WjXyreqI1DzqQ3fdv6ID9Kx2R29D8xJe7+gh3FXYeDXkwqlpMXyx5z05U+Bu0s4H3CYRxgAfQ/5LOenps4oqI1x73ufKR05OChOSYjilVOuH9Nc4O+RVUrlOtX7UanN2KbjXXqb4lL9dWpIY366Ug2ETXPvlI5EcMaRQNzpUEM+OKKvGTgah2pRLiakWxMtFPJAHuvc4uQHqVF2QwgufHUY60ASbsQCZqslGpML7+BnBSSKVeDK19Qo3gY3tx+1v4yAf358Eb/ah/42ZH12byJIRLWVX/mJjWSsimajKwEMg21L+qhIdez+0LKuiDRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 16:18:10 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:18:10 +0000
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
Subject: [PATCH v12 18/26] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Wed, 12 Jul 2023 16:15:05 +0000
Message-Id: <20230712161513.134860-19-aaptel@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 735d4dcd-a7f2-4514-7eff-08db82f3956a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VV4eXUnmVFgkePabK2xOAFSYIIZUb+5tA8hCcE+8KYemA3Y7z3Y9d9OmtSK0+2m2KUvrJsVfL6rpucR00sP66XwXPLBU5A1B0LwXAduCg37/A5C3HNdR6Cx2g3qYwaQAmc8QtYzOoUtGcjiKk/aizgTkXz0IYNntNJuWuZHVjmMO0o+h5TKBscaS5Da/4eJl9PYlX8ykkqqtZVkQNSkHINGv3wOtTC3JZFjWfBe3+nlZ7a2a6tU0QmRNMwz2BedBV6I2tib21dWRyJQwB/BMlEk/aqR7mkG5W5zjfPjf2eTSUZmnF5IaU1297jh9ld+9jtFv+v+RL9ZyrvTCsEZxaF8GasoAaFr2xKVRPK/Cor7HwqZYKuF5vlm7SfSyYHyL3ADBLEuT2naacG39yLPZtdVD0hhY9X3dv0aPiArevcEkzUH7kiD05VABF783ic6N6swwgbp1l/EGLQ0TODFm2NBamdf9xgsNcCtEe9ftOrNipFaFS4qgo/fNTWcH6CA9kayQnXke7jW6/eCGtuo6a6SXZzHYRngZ1vZBnRec8YwiFlq6IzygUsMLzy7rROZ2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(4326008)(66556008)(66946007)(66476007)(6512007)(38100700002)(107886003)(86362001)(186003)(26005)(6506007)(1076003)(2616005)(83380400001)(36756003)(478600001)(6486002)(6666004)(41300700001)(5660300002)(8676002)(8936002)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YUN8tSxEiPoTJdRfWIORIAoWpv7QUqmKirugsVkgfFxwFKa/DHfoqH9+7kTu?=
 =?us-ascii?Q?vMiLQLm4Bco+6vuRvmK6SqQRJVpgC+BvLM/kfiRHsGIVLOj5oZuckB72LSl5?=
 =?us-ascii?Q?5/40Wjun1LDFYv2iTfR3W3z+H5CgFYBFfVbEXHFc8P7+5JapqUIGoiRa8KNV?=
 =?us-ascii?Q?jTYluHws61lgAMroRzXv6IKVgEBFvw4AJiEycjoR4g88vqCJtr/ZH0loUr9v?=
 =?us-ascii?Q?8Y+AOyGEcjoPpP4pgAIRYP8XhmV4O80pa1PhSLDWWjXArSnm7Ky2PWEOyYia?=
 =?us-ascii?Q?Q1GYGPifHcBo42LnccpATeNGKRdLxwuaky/W8BM1/lgzqKoFKcJ7WNUwzcFh?=
 =?us-ascii?Q?gkYk19pZpnDhJ9MeTj6l8nWTqIg9xW3nlm3vlvExVsIZYR/9Ayf8TaVT0rCr?=
 =?us-ascii?Q?pdXSk3mkEysSi3Fac/2rdDEZpas0+EGg2VBKbTIP2UWL6Fo+S2s50OIxb1HZ?=
 =?us-ascii?Q?Zymtqo93IO39hrtUZUXpsZaChm+fg3sDD1rJCv+573Tos8p/GvErdAhIC/i2?=
 =?us-ascii?Q?MU7KBx9FB5T6zpCuFTA28uWnotK3IxZja11FKo6JnxXlzsStE9NdOVee9gsb?=
 =?us-ascii?Q?6GpV9vHl1ed2WgeK1v8evhScsna8QBabFCVEQqo/nhaC7GDLo0OUUnIoPIZE?=
 =?us-ascii?Q?BCcGTeq9RknpzVBPBqQn4aWY2LjW7bnhapLqvNOL01nsar7wJQW6/aSp6UAR?=
 =?us-ascii?Q?3bxHB7M+W4ObpyT+gfF1OlE+/neYLruCIrqjwRvre4MhUWik5k2G4PV0kxYf?=
 =?us-ascii?Q?DCJtEmSHunU/IJUcOt9If1s5FFZlCs56/bp2s9iagjNG+ursGZt2HUHW0gDo?=
 =?us-ascii?Q?yHVmV8IN1Gc1XGi53jp00RCI170K1P1N0qN4nLVzat0qkI7tJ3NO4jnHD1on?=
 =?us-ascii?Q?9rbUeHTu2NkZkgurvvbRHOXzBF3d1NkGA1//fQEeFw/Kw9OBB9UBtK+Ng+0a?=
 =?us-ascii?Q?oifdKeSnI7YFBGH5+kCxGFBBVFM9tB7Hnf3V7Z7uPVWg6l28C9WZQiV8ycYP?=
 =?us-ascii?Q?D2sQz+5cn2pzylSM201Y79s3o/wPCmMYx00PnbOh6IfW3NVa8DOoRAzbGAIE?=
 =?us-ascii?Q?mdU+8frYqNdW2IEMcDL2UsOyS6rfmA7gPYc7fwVZOww94thqvpKvjQexzSuW?=
 =?us-ascii?Q?261JiFa8fs7QQs2M3V2TAsoocvMlWHeXGV3uzLrhaSVec0lBuJoKzvY/bAyy?=
 =?us-ascii?Q?YOpf93f1kZP0VnFkof9wlsRkR/aezETskPdNBCCvLAcG8F+NUAt65bqNw22K?=
 =?us-ascii?Q?fsU57tuD96YTwCjSpyVHdJ7TaV3hBME8IedNHrO0dyTsrwnkf5g3/YK77nS7?=
 =?us-ascii?Q?cwRmHVZh7os24elWxEn/Fj9/ko/wla9KxP0XUAx0N7dDcP5V5fyQEKCIOEME?=
 =?us-ascii?Q?96eeo9T/yjHoS4IZ1ZhdZnMRLBrGPlZjXAQ6qTc9W5z1zeCMIyGOTMcbaPlh?=
 =?us-ascii?Q?FPxTA+rE5ERrjaZdnpQquVPWH4toWDfNrO/owFonuYtFf1My4KH8ggj80EPP?=
 =?us-ascii?Q?jWXOvVkI3D20eFzULeHyWYibe1oWfCWo+Fu4O1R8k09I6APfGyBtvkcXH/Zl?=
 =?us-ascii?Q?cD9/u16U1QGmuIl9fYms96Xe7kiTzN80rj3KKwGB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735d4dcd-a7f2-4514-7eff-08db82f3956a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:18:10.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lumpcp28DG+46YhqO0O/AY9Jn5l7gnD8FHAVdv1invCI4DZPqYe0/FFe4Yp7XjRYScL/8TFB5yFYXsdszQIV+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 include/linux/mlx5/device.h                  | 51 +++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 74 ++++++++++++++++++--
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index fb2035a5ec99..763dc90b0162 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -289,6 +289,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
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
index 12bd0942d2db..23d9827c0289 100644
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
@@ -793,7 +794,11 @@ struct mlx5_err_cqe {
 
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
@@ -842,6 +847,19 @@ struct mlx5_cqe64 {
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
@@ -877,6 +895,28 @@ enum {
 
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
@@ -1219,6 +1259,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_DEV_SHAMPO = 0x1d,
 	MLX5_CAP_MACSEC = 0x1f,
@@ -1491,6 +1532,14 @@ enum mlx5_qcam_feature_groups {
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
index 08507f943f87..daf4ac33388f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1504,7 +1504,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3445,7 +3447,20 @@ struct mlx5_ifc_shampo_cap_bits {
 	u8    reserved_at_20[0x3];
 	u8    shampo_max_log_headers_entry_size[0x5];
 	u8    reserved_at_28[0x18];
+	u8    reserved_at_40[0x7c0];
+};
+
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
 
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
 	u8    reserved_at_40[0x7c0];
 };
 
@@ -3494,6 +3509,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_shampo_cap_bits shampo_cap;
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3746,7 +3762,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3777,7 +3795,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11931,6 +11950,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11938,6 +11958,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12303,6 +12324,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12316,6 +12351,13 @@ enum {
 
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
@@ -12338,7 +12380,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12577,4 +12632,15 @@ struct mlx5_ifc_modify_page_track_obj_in_bits {
 	struct mlx5_ifc_page_track_bits obj_context;
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


