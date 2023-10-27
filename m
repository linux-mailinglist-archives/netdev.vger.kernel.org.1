Return-Path: <netdev+bounces-44754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C87D9833
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C0A1F23764
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606F2D79F;
	Fri, 27 Oct 2023 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1DuTNW0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76728695
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:29:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFD192
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hABhyBgm2SmJZhYEboqn27PKyN3XlDYNejnVfMzpxMKSAqy/a1q1k8X+fKyVos9hthZ2Ze8ScYrQ7BRSctWRTFizuhL9xmfbYJE3qkssW4lAI74mw8YK1+DBVv6mTVjr32Ovdp4LyLo2GPTbInWdoerR6Ghr5ZaizOLdlRzBdFqWZuMU604SwUwIz6LLI8GDanSVf69okEfsVpG9Ga4Dx0nIa3jud6spyQCUe3P3hlZ6vxxRLSqGItQi/ySnBn0Yh/uXjkjs37eApepi6vGjm65yrp6QwZsWKzSSwePB/fNgfNxjkf64XpdPYYC1vkQaUTpZW6HNBgiDbk1Zm+sBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTUkjcuV07Pg3PvgKTqfLmlXN/wv5EJ2zOgiD58rK04=;
 b=oXhZjIO6+FGPQkhKD8wnPo6Y38igspF5cHPB2Ee7QYQoJGiZ4vBYZygD7xk1/TJzbQR71wNRotz52UqIz10yCcUtZ2xNgDdv9kpECfAWMNISYQkoHtdszwHE3HKfEv21y+CJGx7e2phkkSsVuUS7IvOaMcdJbthbusAbvcmqZhFQrdc9Z1jGGrweVnDvtPKpJGy7isD+vc48SHhAue1sfaN/n/klW9LjbS6buj/HiSQmv4LFvRMnZ13RA8tq8oCpcni7rXpYSTBagHfC0uqGx/PolI3qPwN+RX36/zDO+EJXhaXO2VorjhM/ClD30Sf3JC5hW/rNLU8zkcAcFF7tdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTUkjcuV07Pg3PvgKTqfLmlXN/wv5EJ2zOgiD58rK04=;
 b=g1DuTNW03PYVZVu2uSuRaFpfyXCJhyJBhW+6UEdX0GRtqiSHPr5GjQ4lCjSv+1+Qgz50KNW+oTNe3RaosMmnXieFpyPnPyT8sFpfyrejm4TcVMYVSO0T/jzDybn2IJ5/pDft5/K/HTkrsA5tBRGB00D+VVsxbIANQXomAPNFUekqofTfBbVYs9SfwFXlYhpQNUMyFaiIjepoIRI87ICQJa3GDKHDS/eDO4N4I1rYGfkHERzvE8wkS1fzqP7xT7Fc0FiLmmYlPO/lC+zbS6lhFLqqFxjYg1QpGVMfnyf9PC0fdo0/1bkRgNZeOY686Whb6oJDyYoq1w3+Cny74MURKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 12:28:57 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:28:57 +0000
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
Subject: [PATCH v18 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Fri, 27 Oct 2023 12:27:47 +0000
Message-Id: <20231027122755.205334-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0160.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d22b19c-c626-418f-19e4-08dbd6e84a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	42lgL/bnIMeD10StzMxee44mW9mJ8iH/a/wI/UFmwxi5VVUTiHpbKRBrVORkWzYYslffXtok6ui7eZenFYmStqK5/rxocrZ0WHjnj2gnEDxXE7eA6bXcLJbqbxRGCT5huwLXoL9pYPydpvSyN3YxKGbt4SMSzvQKqAH+73/q5tnRdfRpE+8lDZcmRs7xDeR6Rl1yTd7ZSDSRLzHm8+Jo5vYgnfksUnrnE6q4AFFpWoJCX+qEEczub1UxbjDcDu48mfBahdjVCqDrY5B3bm38gKTkqKUMLRVU3nHnGJrjI9CppIIYppddP4b6780t2EUfuPK2CQ3ttrdod/EPCpf/Nj7qJpbzMVGjndGSfNNUc6qMWkS5WNU7evyaElJjRvrxt1anjmJLD88Jof0Z9Baq/sosCyd+YhDrllQRbb8bQhwT+4vFQLf2zo5BuA9tHZ+dav1PH+kefraNwgrqwv5fsSkHPXoGMSouNP1w43s9M8D3Ip425tZ6lVgt2jM2JhWKaPIMQ3CkrQ/tt789GbAFVK3odje+9vQ6ERVRZCgquv01PqIIAQdp6one1bOPHthu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(8676002)(66946007)(66476007)(316002)(6486002)(66556008)(6666004)(107886003)(8936002)(2906002)(478600001)(6506007)(5660300002)(83380400001)(1076003)(38100700002)(2616005)(6512007)(86362001)(36756003)(41300700001)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Pjte4mwxWj5fhSaaaIIHiUqxWc098m1eq7D3ew7UahlRexBWKhD/gxZ02R0?=
 =?us-ascii?Q?v4cSAwc7VZkrjhMXQa4xVNnfWp1HQubCLLkT438/rzkPelC9SMyGzA+VhV8Y?=
 =?us-ascii?Q?aaOz2Np9sZ6FhVq2WNBMZ50vA5s+951zTAtkqCOn3p3OPF4NEKst9B1kZuqB?=
 =?us-ascii?Q?t3NpTDjA7Gqp9+kqW2+ZMxxGPGVRBjGFr8wdt92ONBozICt1NzNdapRT94UU?=
 =?us-ascii?Q?HPg1OaSF0iWc7SGsdU0goYbhsqJj5Uijs5JykBL9j+DYCjeslV4NONpA7/VV?=
 =?us-ascii?Q?4DlOeDqzZNtdN7QlGwRK+duM1Biw5ixPLOI6dP3ErMpeAnQvl5hECHgKsgEO?=
 =?us-ascii?Q?mZuvSUOAuGPbodplhaXlWS6k0zBYaMtdNjQEewiSXKe3cvAqVplIt11IoTML?=
 =?us-ascii?Q?VI0cLa1ddNOcamA35N078X/mur8DCWjZcI7T4nJkknB/TnxbNcxAEHXCdbeP?=
 =?us-ascii?Q?uI+yAUJLs0XghqGn2xHgaRBajKwYUQjjI3+QyaNhMFAqzDnDGL6gJRTpMrUO?=
 =?us-ascii?Q?CiVS4pADbByFfHhu/7FovKoEtuTEW3nwZRP0yKxE213RL/hbLV1f7Qrig+SS?=
 =?us-ascii?Q?sOfx9pEHQWkwpNQ5gluWr+2s3pXpKBOPyWCsf2k+W8KaK9zxEhZxEvzU/dqy?=
 =?us-ascii?Q?1OujFV975ocbsrLr0ZFqCHsCNq/WxTrGgrGbC+f6naiqW3eAXwxpwpijEncP?=
 =?us-ascii?Q?+jUB2IYD96SMBq1AX4KKEzjUL4zy8tIe+YOe1047XhkldJhOp5bKUJfHrNne?=
 =?us-ascii?Q?YQAYg0woMXxw3p3I6S9Wmiu0szcz2kzTQ8SjzdBXD5zoBJUv6urTUA5RdBs3?=
 =?us-ascii?Q?AjS0zTusSLqwIpyWiq3mniYswKNOmoL9MaIYKE6iRjXPJA3mngppLtzzJpvz?=
 =?us-ascii?Q?4HBLPzxrU9QNQEmnJF+KHqG+WJFx43Wg4oJ7XzzIg9tszXe7gUQ2DnDFjW/B?=
 =?us-ascii?Q?RW2Op3vjFe2bEf/9Elg+008uHkayvZ+g5Xi6gTrf0LtRhFvkcQjdEweUkezk?=
 =?us-ascii?Q?zVIdFNg8B6hdrJ03dnv+2mGw0DisG0wUHcu3VqfYNFpZyV1B6tEgZssNqvNa?=
 =?us-ascii?Q?SzFIV1yhBWqlavUBJbPrV45HNjuFlKOl0JlS/PdLExjjiZmdLONYwmNB2Eh3?=
 =?us-ascii?Q?Q7G/6XSgT6Od/jycrSlufzz1Y7t1ULa1enKavy4dyqPlxxGZMvxXiu6ypjY/?=
 =?us-ascii?Q?9PkIE/qQtKm3rymbP0WGRi5eS/aocasdHglghox4XrxLs5AagqUxSCz232Ha?=
 =?us-ascii?Q?P8gcOTZ55FeUGP+qTQLlWu5Nkx089+KA2r7J8kU2Xxno2wIcJj4gdcw0YFKX?=
 =?us-ascii?Q?lpR3nzt1xaS0vLY8dGJXG32UHQ/DOfs1Ku67HGYwsqfNxq1a1q7a7VNSFV1E?=
 =?us-ascii?Q?1qJjLs2V5S/GayLtv4VqDxb6TxKwdF4aI/Tg7ncmutG6riwLvg8ZvD/XYDUS?=
 =?us-ascii?Q?XeFwXJ60HGZfxs6FYSd6SvObYT+SKEbR+gm1i3+vIQEr+sX16crbfD9XwIOm?=
 =?us-ascii?Q?CWOmuJxv0qYaAundBKBJVUGQTCAVfzNB0bHR5v9vV9ipXRF+mE42tG/CvtSc?=
 =?us-ascii?Q?mum5m4Bx8iGEbBFkQed9Q/iZgbT67UYlIry0AwHw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d22b19c-c626-418f-19e4-08dbd6e84a85
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:28:57.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9aLPG4tLvMSAkXNGyV1U68kQwWry/6/WOufeAq/+KVh7T+4/PbA1hWRCHbRHaO2o8yYb4cgetRzCAvsKOousQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

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
index 9aa81c8c5b14..f67e1b2c3196 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1456,6 +1456,20 @@ enum {
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
@@ -1480,7 +1494,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3469,6 +3485,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3721,7 +3738,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3752,7 +3771,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11965,6 +11985,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11972,6 +11993,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12338,6 +12360,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12351,6 +12387,13 @@ enum {
 
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
@@ -12373,7 +12416,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12672,4 +12728,15 @@ struct mlx5_ifc_msees_reg_bits {
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


