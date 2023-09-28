Return-Path: <netdev+bounces-36870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F97B209D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 925171C2098A
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752EB4D8E7;
	Thu, 28 Sep 2023 15:11:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF74CFC0
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:11:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65AE194
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoCr5BmOBoFcV0vrY7PpNPKdC9UKfG/IZY/xKA12qQGdC582JhnTWAtdL+MISpe7UJ5SQvVddhlT+0/j/94GkA+h6mTx/q2OEdoIkVBpDImcQj/cuJpdYZUvWs1+CiAgCPBmottLbHNo09Gn9tuIkmgrtF+SnkMmr7xsCE0M4IvMqKJcA+74gxopO1Pd6OaYq9hNF2ErwYfPQzCeJ4MhTqylfvf1oazdUgeDTUOAhsVFXDB2bkB7A6a/nZcJF398sOlz+hiVRZbOOfavZWgSgFSexfdl0t+CUhrMmIwE8q5aG31rSSDoCVfSAkJBjxfRYM3Nq9sJde4ZC70LqaThXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FJ6swElhY/KLgASUCSQfvh1NeOvyOaxqsmIatDJKq0=;
 b=jkHzEgip8EDRlzEuLKf+6dF5b0M8Yp8tcLkIbxXtcOqpFGXO9q+qtAPsiWHRRo4yad246W0xqJ8j21AEdTsV6KIElWZY6nCZ916oEtDOkDNHmMtu6OrBt5bb84q97lOh+vt8soRswh/7M9XqswE/owh08xOFUUIr7r1lk4T3a9Srena5LOHb1ItnZUauBQJaEZPxQ4oGzMMxcO96Lm9R5sLMTi/C4sudsKzFzBh+PpcJE5WiqLNuqeo4+tLNL+OfE77B7TjAb1kMJGQMqCEf6eoCgqaaXpSaMighd6cXzZlZ2SZBv8b9S4/1B46itp1nXUBTxV8SSJCkUkVkaFFscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FJ6swElhY/KLgASUCSQfvh1NeOvyOaxqsmIatDJKq0=;
 b=QoBn2vFEOQ8AeE1d8vew9KjdoXS9ttk92sGE1cgpZIuGWIXvpq9soKeCkvuXzbnayunXwl9vN2r95mGLbe9rP3bfbtGwcX+17Vd+TFdBASpFoxsQMKIktci5zrljxUkq2mErw1U8LXjvhZEOQQl4mldwOvOdsjEK3TUu/qkD8PLrsnaPwUH6rLaejzLUrhJb2TMkzP4FGG5HS+rr/wJF7MpBVc8bMLofbYAzozy2fCP/E18NzNr5jEmIIHrFUdiQA+9hrjWK4iqn5l1QTK4z+OOxop6K1de+ocu9Hr/5K7hWydk4jdJSQ1DRYkdrMPdEJJOazK14IVTnK8ukxs9pPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 15:11:43 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:11:42 +0000
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
Subject: [PATCH v16 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Thu, 28 Sep 2023 15:09:49 +0000
Message-Id: <20230928150954.1684-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BY5PR12MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: adb7a85e-35a8-40ad-2286-08dbc03538f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2UbW4xH/89CbEnP8BSlk9pGNrHEx46BymSXxuh7AVzWJibdxJznZnwXgp7Xvn4ifiZi/OnWx5yP/n+D/rMFrrMWHv1a/TxlZIo5froZIGqNU/aoJHtzlaQi69T2RaHPJzBt7qMmNP7fbyR062uu5N8UVY1Xnl9Zqv0PMEPaTyHwHK3H2rbWf78ks1ikpRzW8tWyXpvlAIjx71wnkHAsWggCRWly2gfo5/d1gnMgLqvLRi215T+qc16Dv0IKJEIbq9Mlvgwik30tuwNP8UHI29KdRFj1bgP3qfSPmgYS32wKe1XkJoz6LQTg/Ny64+Q74UAP+N4S9ma37XYMWWGaSBgBRfEiaPab2FtP5yxSiZjyP6PP1IX1rSVoMV2KJ/+lTMS6P5WWSdbqHs/OZG0lN4qwevMNZSSnM0/UuY7jPH7XNEYiU6+RxV8YTSiKj8GlsrMnP3MBMUKPkBp4dg6MExYAZbzrG4EE0TT8uSpwf2sT9uwwxGpEZ0HY5aIJ7entpAbMeMyX24Wg3CKC3LjPHAWgLCWfBMWVoaC8FCuybU5IrbkXEsKgokJAogDFWAlRf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66476007)(66946007)(66556008)(41300700001)(478600001)(7416002)(86362001)(38100700002)(2906002)(36756003)(8936002)(5660300002)(8676002)(107886003)(26005)(83380400001)(4326008)(2616005)(1076003)(6486002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?04zQIjtHc3CeXJRCvKaB9Qt4QjmwIe9mSAWoeHkrd13tI44T7AlENHqDsz92?=
 =?us-ascii?Q?lLgMk0aO7p/N24DcB2wjcpnKAm7juwOtd4CijcyxrUG/2Ej21dkC75StPb2v?=
 =?us-ascii?Q?aMhzIkiejEN25PKiOpYIHJEzX8PhT/qrO/eGw6LoOZe/2Y5XPPYZVTcj4u11?=
 =?us-ascii?Q?Wv3FVIu4A2K+5c8oigBdE4rxcEv5Rqd8gXVG7O+nuPWys5HMLPst+/E0vaXi?=
 =?us-ascii?Q?Qsx0LF6+u9av3T/1lmizy7in6cIFnoC4ZXcDT/fiiN/krKDZpVD0zNVz2hFT?=
 =?us-ascii?Q?FlskU1wF8rEQCcNGfexU1PrYctUMR5nMRFrAqveYtlR/tSPzHoCRasfuETWf?=
 =?us-ascii?Q?OBMOOr6iXqXlqK+CYiDkEGOh28z+mbEqN4Rt4LUxmhwdOvNUJ7Lj7RNH5gme?=
 =?us-ascii?Q?VGjyPYnK8kIs00w9/WPLjb9TGFWGzThb38W6rRLdTI0lXxN32s/T72HfUV+C?=
 =?us-ascii?Q?+skTT70t04TkpLh4Rtrd5uVjFsUnxYJcYH23MWoNFmVOwhXHtb4An1kPwedX?=
 =?us-ascii?Q?WDxFCSdF2+eJSDaidx6VagPf8LiyHqrdgVizZeqUf6R7L2EIJU5OFKsdYxfX?=
 =?us-ascii?Q?Cs+OTYU2JCzCNx8e0kc6Wv2p70Dsn+0lBvrrhQTzn+uffXgH5AUe6brYCit9?=
 =?us-ascii?Q?6vdytqdtfXkpZYCstowLsMkyQklCzARibk/si4CZ8ZRn/StCDULHkRaLW0Cs?=
 =?us-ascii?Q?/ZqbssfWZGFy+W0F0QFPcryYABA6IJbGpCODoOrHnJHcyjFv25K2YrRddbOA?=
 =?us-ascii?Q?0aBi9DB8stn7lYAYjPtr15EWk9g863EDRppm13hDSHbtlPo6cHXLuFQ3uPmt?=
 =?us-ascii?Q?2XYb/Owl6wkXGdJgEVaj5YODO7f2/jwOEXRa4F2bOO5a7clWXA+wmGjitbEc?=
 =?us-ascii?Q?FkV34trqU59e18idZ2tgUspWoktBR5vZZqiHYMcaSQyo3lOErhvBBL1pheUh?=
 =?us-ascii?Q?l7MPfh2CTKeRj9EDRyn5USD/Q/VsUarKZQhM1Htqnw0Y8aid/mJQxTs3bjup?=
 =?us-ascii?Q?O9undCwRNA4LCNARZO1RRif4bp5UNw5+bFOB1nm69Q1fH8E+P4Z2NYgnznhY?=
 =?us-ascii?Q?keOHOznHJiO6eHzUs1ffEUQrVRX2+8hVzh2JHa9C65ra2q8ih38tpaYzL+Kh?=
 =?us-ascii?Q?pFcrdK1JSWlptlMzW4jZfReeU2Gw7DgRsFZjVGSTo0iZNo1g0zSAdQju6qCp?=
 =?us-ascii?Q?xEOtbY/XFfpMmOXkVXiEPO1Pptn1GLBZ9pc58dtZfaZy007C1TfoSlk843uD?=
 =?us-ascii?Q?Edhak0Jrl75cj7cuHICtqiPf6yBynWTxxio8dOJB42Rg+wDdsBVg8lF82eFt?=
 =?us-ascii?Q?xrOuhKuLImthkIIEblRUfKR3TNAcOQGsJcuOvrVKz6xgibHWy+vICxmkeJ2z?=
 =?us-ascii?Q?TqeZjRCQQBijFzgBNKKvhRoLYjNNanshu2ZA+PsDycfNOm3Icvbh38F9rqUQ?=
 =?us-ascii?Q?NItdV+xQ+puatfdXscgyJPVpmtiy+kCeXsKMdj6jwbZg4vGzKTP5euKiXxjs?=
 =?us-ascii?Q?wFocH2QyOYIPdpRx1RgceTefiZ+kloCF4upzcGnCf3xyc96gP9tMHcLmOapp?=
 =?us-ascii?Q?8nvTeFG+ET9OyeLyQ84M6+A5+ievVmR6td9tCjHW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb7a85e-35a8-40ad-2286-08dbc03538f4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:11:42.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsheTDr8AuJJBtzp3w2aYJU8mRU17nNYB7nksBBxCoXsL9cha3o2VuwxeR50kCcElVsFGhDTGWiapLJgZheymQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for ddp operation.
Every request comprises from SG list that might consist from elements
with multiple combination sizes, thus the appropriate way to perform
buffer registration is with KLM UMRs.

UMR stands for user-mode memory registration, it is a mechanism to alter
address translation properties of MKEY by posting WorkQueueElement
aka WQE on send queue.

MKEY stands for memory key, MKEY are used to describe a region in memory
that can be later used by HW.

KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
enables to map multiple memory spaces with different sizes in unified MKEY.
KLM UMR is a UMR that use to update a KLM_MKEY.

Nothing needs to be done on memory registration completion and this
notification is expensive so we add a wrapper to be able to ring the
doorbell without generating any.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 ++-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 123 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 4 files changed, 165 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index cdd7fbf218ae..294fdcdb0f6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -50,6 +50,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -256,10 +259,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -273,6 +276,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 9ddee04a1327..0fba80b1bb4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
 #include "en/txrx.h"
 
@@ -19,6 +20,120 @@ static const struct rhashtable_params rhash_queues = {
 	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
 };
 
+static void
+fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe, u16 ccid,
+		      u32 klm_entries, u16 klm_offset)
+{
+	struct scatterlist *sgl_mkey;
+	u32 lkey, i;
+
+	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
+	for (i = 0; i < klm_entries; i++) {
+		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
+		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
+		wqe->inline_klms[i].key = cpu_to_be32(lkey);
+		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
+	}
+
+	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT); i++) {
+		wqe->inline_klms[i].bcount = 0;
+		wqe->inline_klms[i].key = 0;
+		wqe->inline_klms[i].va = 0;
+	}
+}
+
+static void
+build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe,
+		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
+		       enum wqe_type klm_type)
+{
+	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
+	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
+	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
+	struct mlx5_mkey_seg *mkc = &wqe->mkc;
+	u32 sqn = queue->sq.sqn;
+	u16 pc = queue->sq.pc;
+
+	cseg->opmod_idx_opcode = cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+					     MLX5_OPCODE_UMR | (opc_mod) << 24);
+	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
+	cseg->general_id = cpu_to_be32(id);
+
+	if (klm_type == KLM_UMR && !klm_offset) {
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
+					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
+		mkc->xlt_oct_size = cpu_to_be32(ALIGN(len, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
+	}
+
+	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
+	ucseg->xlt_octowords = cpu_to_be16(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	ucseg->xlt_offset = cpu_to_be16(klm_offset);
+	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
+}
+
+static void
+mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
+{
+	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
+
+	memset(wi, 0, sizeof(*wi));
+
+	wi->num_wqebbs = wqebbs;
+	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
+}
+
+static u32
+post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+	     enum wqe_type wqe_type,
+	     u16 ccid,
+	     u32 klm_length,
+	     u32 klm_offset)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 wqebbs, cur_klm_entries;
+	struct mlx5e_umr_wqe *wqe;
+	u16 pi, wqe_sz;
+
+	cur_klm_entries = min_t(int, queue->max_klms_per_wqe, klm_length - klm_offset);
+	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
+	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
+	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
+	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
+	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
+			       klm_length, wqe_type);
+	sq->pc += wqebbs;
+	sq->doorbell_cseg = &wqe->ctrl;
+	return cur_klm_entries;
+}
+
+static void
+mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wqe_type,
+			    u16 ccid, u32 klm_length)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 klm_offset = 0, wqes, i;
+
+	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+
+	spin_lock_bh(&queue->sq_lock);
+
+	for (i = 0; i < wqes; i++)
+		klm_offset += post_klm_wqe(queue, wqe_type, ccid, klm_length, klm_offset);
+
+	if (wqe_type == KLM_UMR) /* not asking for completion on ddp_setup UMRs */
+		__mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg, 0);
+	else
+		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg);
+
+	spin_unlock_bh(&queue->sq_lock);
+}
+
 static int
 mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
 			      struct ulp_ddp_limits *limits)
@@ -45,6 +160,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk),
+			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	/* Placeholder - map_sg and initializing the count */
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
new file mode 100644
index 000000000000..6ef92679c5d0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_UTILS_H__
+#define __MLX5E_NVMEOTCP_UTILS_H__
+
+#include "en.h"
+
+#define MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi) \
+	((struct mlx5e_umr_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_umr_wqe)))
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_PROGRESS_PARAMS 0x4
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
+
+enum wqe_type {
+	KLM_UMR,
+	BSF_KLM_UMR,
+	SET_PSV_UMR,
+	BSF_UMR,
+	KLM_INV_UMR,
+};
+
+#endif /* __MLX5E_NVMEOTCP_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 387eab498b8f..48a9b44752ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1044,6 +1044,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 			case MLX5E_ICOSQ_WQE_GET_PSV_TLS:
 				mlx5e_ktls_handle_get_psv_completion(wi, sq);
 				break;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
+				break;
 #endif
 			default:
 				netdev_WARN_ONCE(cq->netdev,
-- 
2.34.1


