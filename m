Return-Path: <netdev+bounces-36867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CCE7B209A
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E45A01C20A91
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA14CFD8;
	Thu, 28 Sep 2023 15:11:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86744CFD3
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:11:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953DF1A4
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBuHd6+kbZpUOlc06IIRs0oWZ1O3bJ+MgROZxzOtRPLY0N4GAthjkRdiEKKo0vUxf/yMSrbFl9OaQmWY0rXoWxW/svrjR03bKFzz39SrB+dMKKJw8f1w+lYHYZskyWDqortT5O/s0i7et9y4ugfmeOaGezxnU644xu4xYQkMN+L4xbRZL43eN/Si8Bbwbc2chNVDdIjEsXkWo2xwE3q6BMcigSzpaAF78waVrV/f6tVVOyXSWz4YpwX1IG2q49UWwtYcOnrQuZRHAf+UetwrFW3ChadbnTHrxFuYvh7zcQnBThYLc3gkCO7ntWBYVmLgPO0MTrLhH9kJwh0Vj6LIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCW52u+tBc46A5Q40B4wUAdQxT8ZaBWBmiCBr+q8NVU=;
 b=m8YT7Iylpu/TwL5bc20e0uokEQ/ngP9QUzLXr3CMjB9tt9A+YX0BzyDwEpAF0g/0u0FeGwBgbaS7GNKhUtO7eYzlYWt+NQ5r0nlEXbMwpRaY2pQk2xEEJeLWufPmr6xubnwpdIeqggF3Vp+uBYM20T/yrV72gitBwz3GKqIobgnclT4d6QhEatCAKgooDISU5FW1aVbJpPSQNkJcrko9RKxl818tCbbWzDeVA0Nlo/NX2GVCxNFCsJa9dUVK2xYbYdg6ZALygJU+gJ5u+WJFpTUXI+hi+V48S28g7IM7zdxBK0ERcC4e+P6WC0OcFTlnFtpEKmZJSVjhricWnzNpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCW52u+tBc46A5Q40B4wUAdQxT8ZaBWBmiCBr+q8NVU=;
 b=EvT4JYLTM5N94Gt9kcGjdz/jfM6Ua0C5xWOguPEYIDw9SZj16mOlebCg/PVFXQvTH5gJRqAno+xs0L5DBrY94DfM9UZ0GZo5IknlSZiyOFXbmHplyY2bcAL3ccf4FDtmil9bLVhSXqjkeIIo8N6g3NAl8X+ZCrx+6iM/cH/uImLWvYvJ5ApqFsdnCYxTRZH4sDpvOsZ0SZ8Es4YpBR7wi//D/OGqaR79PEe+xEB4nRMEK7IND5R8FQdK2py9jkJvzQ28EXAIkdnjedhqr1LP2o0U/per6w/VK7mWivrjy3YStdaAtiCJXVTi9E+tJjkYI5fF+vuaXhrjhe6AxQHl8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 15:11:23 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:11:23 +0000
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
Subject: [PATCH v16 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Thu, 28 Sep 2023 15:09:46 +0000
Message-Id: <20230928150954.1684-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbd7d82-c8c4-4cf2-c24a-08dbc0352d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ph0u5G8CU4hHrZ5a8dob+GAo20vKnN4tLMaC2K//zrEGTIUSKjNniuqFz9S5kL4peNrpXEyR0Fze50QkoPb+Fb7tBcnRbyJ/hVDo+z0JGoFpjUaGtCc/tTBHOTzCHLgcF4x5PvX692gwx6MU8PJi+FdDGp4v67vTuGljpXCyVEQfyfJyVNLW/SJoU+noBP6mmiokEs/wEcYiq9d7ZtGoeRQrYfSvqpxhVWSapjAy7sfJVSIvGjYFJ8sa9YPKGnX897OZX+ckaYKJBVNTQXlCsqGX3BG1rL4+A474hoAx3v6/js6UZ8+lZ1xY52vInZNplDPV58v4F0mjg4P6RPXmscCah6IM8/2XTdzuZ1G18QuwosS/U32r2GHG11vq/6+0Szh/m6WTOyF70/EjY0vzWqfy33E1Hvt4zQ2ufkrAnYfhAEJUNM8zNFRVoV5jv9nIPHKccMj9vnGBM/ZgfIh4aYD/hOpcbmfnjvL4omg+2YG+OzBubdzZTD/E8D8a2OWD4JOaYBzhP28jVOzl8Y0As4mMGlZlmuJa7oGsDbUE6qBnHTEiFM6ZPmZtaAmRV0OZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(6512007)(6666004)(6506007)(1076003)(38100700002)(107886003)(2616005)(66556008)(66476007)(66946007)(86362001)(478600001)(6486002)(83380400001)(26005)(36756003)(5660300002)(7416002)(316002)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGm9D7UDZBpUz+dE8Qu3o8FH7Odrpa9ikgS7mJxlqB7gethpBCwzR5tK0EXp?=
 =?us-ascii?Q?WXyrCri08HVPyaltU4Arnf81AfkxlIP4+Ks2YGjkiPBuB9/Bpa8j/RuXlCa3?=
 =?us-ascii?Q?sXBGWs0FaY+nthH/MVoFhvbCN20TSsiAvVM7joXzSU59ccqgFv/eRHWp1OOa?=
 =?us-ascii?Q?l4Q+V6UHBYFpsfj5EMwjdjwqiOT3cbYNSq47cQ132JmyrmumwvQVDo2mvZV2?=
 =?us-ascii?Q?55u2Q1lxJOeLgT6u47RdIn2KAeyNl5xU1wQHDAc1QZcuqWOxxhq8g6yPBaI6?=
 =?us-ascii?Q?mKri032TS2fIJEN8vMKcNAGeymrVohGHAR9EWsTRMOSPqOon5k3QOj2npCvL?=
 =?us-ascii?Q?MoAoStNffJrgFJfTF0WttWySl9NaNZaL2CeUndMSict6NuUaKmDmsVILraYl?=
 =?us-ascii?Q?VpTG1KDYta1GVd7b6nts87lrA5rdOj6eqbuFVq4jD7tSeDEpTy2Yz3hk1gl+?=
 =?us-ascii?Q?r1dmQk9LCf3dzDO0owV2D/nrzQ0yNnn7TzXaXa1NrIEetzhhSR1MSqZYUqEg?=
 =?us-ascii?Q?lbfVMKMlLRhfATeKgSOK6gb84Uv8GnDO1fITdKzANwYKYhFF22fcc7dLL5Ht?=
 =?us-ascii?Q?q/6H+7QKYiaPCaVC3wafLJL2g7euC1r2XcJ6WeM/yy+jK6EJEVlWqdAm5IdC?=
 =?us-ascii?Q?i8dYHXUXuK4ZKCLw+yZw8It0VDDiTVSo2ElJSQuyfXjDPb2rb8He+yH4pJiQ?=
 =?us-ascii?Q?F4psVFk8gPVd9opGQnJOT4U0sSDW4sEuqXZRimAr5/plB230bC26+9M+LwrU?=
 =?us-ascii?Q?qComcSlHC8ZeDj2CjwUNmPMF7ndFYzFkEnd7l23tIVjmDD7FxRVggTzuH0Zv?=
 =?us-ascii?Q?OkfI308lCjnOSraRezSirGZ52fNQQSxM4htE8ZoGKo3MG1ZyxosBH8pF3pIR?=
 =?us-ascii?Q?lBVO5h9yD4J38crLUbStltpus4DD9SU+noIxXqrBchEf7ijoYumqXnOacVzQ?=
 =?us-ascii?Q?jNwR4+Z6DcaDjY5WvQxZTmtzu5qmvMvjxb22mdqMB/X2iVS3ExMhVUHyHRxr?=
 =?us-ascii?Q?kkx7Z+giq87MEzfnDTHxUopIb9T8TgK5HySHvkKDR3MSDV0Lw1UMB6hKaclV?=
 =?us-ascii?Q?o9an/eOhk0ZN9zDGtCvb3EaHaF5vAa0q5+JfOmb/s8h6Uj48gWc6HVm0mELY?=
 =?us-ascii?Q?P7yBGO/Hj0H3f08kWxSuCAQ0uwPl6XZAlscRhORrjTpWJJZfHcNET91yUpgV?=
 =?us-ascii?Q?NsRw1kYzQvkzLk3ZmgKT3loT03Qf7LvOqbZUpvAlQobusFH6ivJ/04dWdpSd?=
 =?us-ascii?Q?3OLEAxZO5/7pnNWY1O4H5Yw2g8qMHOlMDM3RJyKNoiGlCvMLONsNmdc0chqU?=
 =?us-ascii?Q?wiAe5fJ260V9SeZQcwVMXvGaAcy+Iey0/XqrJmGs0MR7iB/2YpOgVYyvDhxy?=
 =?us-ascii?Q?8id4mHr4YwfbRwaxQZwi2Eq43zrUFhRxEzHTY7EF3OzejDMCexOkSN0KCtlM?=
 =?us-ascii?Q?tCuHCHCrBYJLdcyZ/gAeWu22kN8OJjV5DGhRQrEGBDtRt5I+FieukbwnsVOE?=
 =?us-ascii?Q?NGX24VpPH8cASSbZyCx3FtNUkRWkUvvc4gnKBHNlfl/byla7GRMhQkotU3BV?=
 =?us-ascii?Q?EWykEER1VMHdE2igsJsxMVsmFts/NPgeyOxAQom7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbd7d82-c8c4-4cf2-c24a-08dbc0352d7d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:11:23.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eYmFozCd8BGZ6YFhBY9sUwPVsphX2dYiA0Bsq7QPShSAV+Fd62dZhhDjo9XEI1RAoACOhMpvGxBZIZVXirfjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
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
index 7ed01daf8a1d..ffac40b5fa3c 100644
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
@@ -796,7 +797,11 @@ struct mlx5_err_cqe {
 
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
@@ -845,6 +850,19 @@ struct mlx5_cqe64 {
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
@@ -880,6 +898,28 @@ enum {
 
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
@@ -1220,6 +1260,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1427,6 +1468,14 @@ enum mlx5_qcam_feature_groups {
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
index ce317b4cdfeb..3b149c043272 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1455,6 +1455,20 @@ enum {
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
@@ -1479,7 +1493,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3454,6 +3470,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3706,7 +3723,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3737,7 +3756,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11909,6 +11929,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11916,6 +11937,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12281,6 +12303,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12294,6 +12330,13 @@ enum {
 
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
@@ -12316,7 +12359,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12610,4 +12666,15 @@ struct mlx5_ifc_msees_reg_bits {
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


