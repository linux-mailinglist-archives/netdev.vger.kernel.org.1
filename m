Return-Path: <netdev+bounces-29675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72110784512
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957B21C20B0F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442241DDE2;
	Tue, 22 Aug 2023 15:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6468464
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:06:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED221B9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzao//yDK4HqE47j88FxnQQxAlY2iJyJqeI2ZD428yK31oil0nSPyemh6uxfe4KRx1Mhz06DvithN3BE3cmE8tJNaXwKJ8Zs6+SWjUrK1xPoOtckuz6mXh2HDMPWdagY6iwO9ZMmlN2tuAZ4oAj09Med8J8OCsN38u4JtiZrDHC/2C8tO4CuQSL4Iz0xmkXAQYiRnJuvhXlZ+ypm1yTQ7K2/2U9PobciZz68k/LkW2pjYv5R34TKrZC4HWS8h09j6XWGby8WPeZfxWJC9L3aAR6OyidSo842r69/om5MX431Q6TAnBA2YEqDIR22tdoFs6gAG+X7+mQgEsNdRawq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRXsVQTP3O6+XKzVg6Vnp5wMvBLi+T5jKmtctXPWKnU=;
 b=LSr0XJg8Qc1vu02o+Xt/K4lDmmh575G7AXqs+b/XMdh/D6WMPOpzva/f0TXzX3fE2komm5lNoqqzyrBhbI1/Ea+4FHrYNtX9hjZb0APYC9+LVGgqR3/w4sniglHhIrS5OLF5MyLgspZZZgqRgVMiF9wRLBkrmsKSHZiJGojC4KYoCBcWGCd7bgk3rilJy0mcAiezed2rPHBbp3KK0+9r+15mirdLGii9N98D8x2qPoJ49A/64c4Y74A2d7mt8td77yteXNdljGIKFb6fHUDCHh/1hlY2dPD/odA07lsy4t59/Uqq65EZRNMlUwneHI3gFui8xLyfVceclZSkLVg9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRXsVQTP3O6+XKzVg6Vnp5wMvBLi+T5jKmtctXPWKnU=;
 b=OO/5bAQizZ7Ch6NywQpIb7w2Rj5W/qBM5dsXrFXgqnozD913Q4KqHjxvsBaVHNOzsNqfzA0FhJtF+OsBzTmgbpQLVc6pUqCtoMtzfNNB/IutAaLXoASnFghQmZuJ/HWakT1Vt8Crf0lszO1ayYYWazryrfEiLBld/ad8+hVlQsl7P/0pednW+2N9D4czOc3lhj/G/XtEnknDV9cQ0rXaO3B05k8beeKyehY3butw5XIvQjAkxSQjvhGmhQyl779AMkXap6NU/K71mW5Jz4ABsDC9mnOHdm7JRMO5CAxZvHhM1e4Wb5UgAws9xLLbxO9TfMjMRHneVZvRjAivD54L9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:06:20 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:06:20 +0000
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
Subject: [PATCH v13 16/24] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Tue, 22 Aug 2023 15:04:17 +0000
Message-Id: <20230822150425.3390-17-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c708292-0dd8-4b9d-e91e-08dba32157a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mpI5Zj/37SelYpSD7t5IKMDXXicNoMh1nARsj1xu7ejnw5eTiUwJe+eAM3QRrBqtjbXAZvvl6SgTp7ImGLm4ekaWDPQke36zklH6538TdDBy5NRKX4+VUO9gxQVKAEB8kYsRz93jz7WHgv1vHTXHRRGPmN60mB340ZdnESNA8+WRNVTu5Wwi4wKRTOYYe6TRsr5xjWk2GjZd6eyhlSothe33EtYHL576/O+jlIKPI6pV+W22Cd2ihZH8p/NRfLiemxXvLZCUEMoQPKAJCZI4Lkouvi3ZdXkpwvj6VhIl1afVwil3IiCjTl8JCcpr41wgpLC5+mNzGj1/3uM30DkzFyPuojAzUr5DIQiEwt+FNTCl57OqXpWKupn2YE7DwT6+3dNlaBacbA+rxdt+mHesgzp283XTk/A6FTgbOvk7UFDUGxbVGpBXX6J5ZYQnF1LKONxYS4eZ24v1760/6N+6H84un6xuh66xaqYcoZ1L9v2wdRMCnEmCt+O24MuDcJXnh0T69jw9HWEUcz3Fzbz7foul/ahSbkP6gd4gr7a8PiwP7RAaYQpZsbabQG6azuP5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?120+Ydp18JnHUylMax0I3sB//sldGDulm9mqHaH2Pcw2j9EUMxBMBUbq24GD?=
 =?us-ascii?Q?7JvY1gWkei5lvjJckIvoIhWwEB4SVaSqivBmEKPk9FbGzQvBruUyO/3agbGz?=
 =?us-ascii?Q?SnrMYJfpmZz+o0Om4vNJHiem5hMCy/ePXgJGES1lciLUy0T5naJfCxiQpbMd?=
 =?us-ascii?Q?d8YmlwqHBaXxHPEPV4lixbvaOczP47FZp5VPQsFOe8Yex/sudEnNkXP9lmYk?=
 =?us-ascii?Q?9AWRo+6IyUTdattH/pju4C0Ev3M21r+mDbZaQNn/BrgkE03/L+zT3K28iTUF?=
 =?us-ascii?Q?+biOopfxj9PipPOd4DVfyjh5V5vCiQzI3CnaeviiTnDirsOeaBgLv9OwFlf7?=
 =?us-ascii?Q?1H4aXuPByt1x9xS3TUhPionFWzdCEwpcUIoE5I+hkNtXU5sWVG6hcNUJyA6M?=
 =?us-ascii?Q?n1sKC4BvqGA2av22OiNnvhJrGofT5un2qGsidrkey2HmlsM+Wrs9PsOIydDF?=
 =?us-ascii?Q?utHhTMN7+t2fltkkHpB8JDq3+fxU2TBvBQFuy/tt5ThdWjBqkHSTXU+3FEzq?=
 =?us-ascii?Q?dfDdNmMacV8Hpf3YagH8xfmzory5g6TL6lslBJGhEJcv8vd63CfemQbHdW7t?=
 =?us-ascii?Q?FQDtPZ6P7VX8B8xXPWybuWSobW6ruXxHauYeCjNmaXXo1CXzqlH3exvfN3an?=
 =?us-ascii?Q?sUDBTmP0xTRzfYwPqnythdbjFc/fviYb/5tPMcCWYdKSNvJ4TaJRebAkB0WF?=
 =?us-ascii?Q?yKvsLZDfpOugPE+Er3d/rDcVMBve36F6hM/YoVXmN7XXAFxObldAGCLPHmqm?=
 =?us-ascii?Q?H4o/BdFdGcgbafWS4iqR503PwnKw4WkqxvPEOZC7yKtAzVK+pCOpL+UJTcid?=
 =?us-ascii?Q?WJ/KZu4hbGVYHE/GVbnaX17nwYocwBVYsCbZWa+bKOHtd2JOLHtFFgo9yLmY?=
 =?us-ascii?Q?Vbc3zqCL2V2HIUw4UCG3+rdVJoutJNu5bVpatu79alY0/WbzSxNgsOEBdpQs?=
 =?us-ascii?Q?+sQSJ42YJI/1OC9y4SYmK10EzTjQIFJL/qcr3ykXRgZEG5tvJtY95b0my6Ng?=
 =?us-ascii?Q?+qo5tKBBjI018U+rOVDsmjLwgG2BP6YfCkWWBRwLtiCStC5FDu4q9ESntyVS?=
 =?us-ascii?Q?Zdcnhs7Z1Dz2cOYu5mFByRApZMWkdCamJAYTZWZBgsE8jYosal0bZPPsD4DD?=
 =?us-ascii?Q?drFyNkGs4tcn3GIkAgtvSe5JzMr+72Wwzr9IeTza0VBmENHRrd+zAkThOTJK?=
 =?us-ascii?Q?Ll7Aqx9TfDyXHKHFK4FuUt5tfulPG4JmjFJHCtfBGcloaJciNviNt3cxdU0l?=
 =?us-ascii?Q?lFo5Y7DOBvPQAZ8UV/0hsas2KjVTLHQ83A32umHsOgVG/EKyeyfrpIbmMpnz?=
 =?us-ascii?Q?0k36iwrK/ESdfkv7I7hsjaXq1oeGya48q6RkIitYH93TQPfmA2fBLYzJZLai?=
 =?us-ascii?Q?cv+zLrOFBzWLsSqXqsYUNV8NV/G21gFF8gh2HHRzPL0JoOSDJOkTMS89ACHL?=
 =?us-ascii?Q?Oh0jHTIbEu/YhsdWQt9a0pqbr2Bt5upQkOJyOW2MRLsGp3vfx3BaprtoQUCu?=
 =?us-ascii?Q?D0N39ufGOVPf4tTW86o69nYaEWak3/suUc1oT0SCirAu+sl7ZEfw5dInU8/u?=
 =?us-ascii?Q?mRgOyo2Dn2jdGx+gb07L/uzyEM0n23mFI+aCWwwi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c708292-0dd8-4b9d-e91e-08dba32157a2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:06:20.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46zDU/ECASPtQGsQLSPw6tUK1uFRAiiRG+iZJgRUFo+YduAOdX7ALVMEHEChFtMqyWrNo7i6gcnAcWQSlKFusA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 3b1d15abc8d7..d772c07e1327 100644
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
@@ -1217,6 +1257,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1424,6 +1465,14 @@ enum mlx5_qcam_feature_groups {
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
index d44b0795470a..d7394a409ca5 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1453,6 +1453,20 @@ enum {
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
@@ -1477,7 +1491,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3451,6 +3467,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_virtio_emulation_cap_bits virtio_emulation_cap;
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3703,7 +3720,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3734,7 +3753,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -11904,6 +11924,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -11911,6 +11932,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12276,6 +12298,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12289,6 +12325,13 @@ enum {
 
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
@@ -12311,7 +12354,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12550,4 +12606,15 @@ struct mlx5_ifc_modify_page_track_obj_in_bits {
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


