Return-Path: <netdev+bounces-29674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541FC78450F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084222810C0
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2572A1D30F;
	Tue, 22 Aug 2023 15:06:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7F79D0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:06:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7419A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNJZ/Hnt+HPusyjeebnIFlQQH3aHDCeo7Mv4jpm/+U6v/ryVI4IFC+IZ5f8BgN72Qr1aE7yRtAa0i9gN4B6c91/ujdP8wDMgMlJSTSsPCUVRGtPiOiHdfRytNMUp8iJICzL9I6o1VyDB3yPfWdn3P8NloHAbSOYIOQL/+/ngWTqfdvHvyy3YFH8zAFIW/AB8WvXBAW67/T5BdnqO/VIFxCGeb/o5KmzIS2stNuQy5GhUVj7gJjLL8BHZSltybKkyDsWN43t5W7mMk+Ha2OeQ59r+6l/oEiQaGp5zwftDn0VFbE4WRnEyAVMfWnM4qtrOdAvfMEQiEEwfC6V4eG3ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukGyWnvrkYkgDK+/vOE1fE2hg2Jvy3nC0ELoNTWWmlw=;
 b=jrABGK9syt47ZncuVUDNbmFavG0ZgutzDQ7i7XBI+keXZaHvzwdzkYNih4YWnhufDPGyngXMMfAWEprM3sNQQ/J/wvUVAaffB/W8CQTCm/wUinI6XRaCoSXcdzpkR8YCHQb8UrG5YCKtQjZ/Ajoag81s4DQf4i08tcQKgkVs1wmO+1/nMuVIzhgLqlUVV+IHwx9dBChU7tHEsvspkXLX+ClH30BNX5YQ0P2rJ1368kI7rMV+1uOPSWdDRDAsRXur4rNDeapIoCLcgXkyXrRCOGCXyQkK80WMol+stesfWWiWTZTn+qytnw7Mk4RMgsqPb7K7e2kalMfTWOhPa44eoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukGyWnvrkYkgDK+/vOE1fE2hg2Jvy3nC0ELoNTWWmlw=;
 b=jfAKscsLtlyEahq+eV/sZbWBcKtKIT7aWVBBpwRAS+7yWYOUpoP7pySAZoAdcM0cVweWX8uyBWPmIXocPqfxbxyqBo4ztiT1uUz6pFRGpLBtmz/4rfU5ve7nY0FLiG2ByJ0+gtIDOgnb/CbtzXqNTOxg0jmIYpoyEYj73JzWeJkVrAV4UG76xrCKOYuGlXBf3wFt+YUKr3IaJOwqQILRGiNImrV/pbQemtimKuxzUgylTLfdCrvTv7io2ET1kYBR4+TF4MIOeYKkfAym+swmyY+j5pDHMcS/H6Lgm+5t26YFlUpBo/mkgEVuGd5mV/2OIC15bsHH0HlywK6OI0lCoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:06:15 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:06:14 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v13 15/24] net/mlx5e: Refactor doorbell function to allow avoiding a completion
Date: Tue, 22 Aug 2023 15:04:16 +0000
Message-Id: <20230822150425.3390-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f40e7a5-6cf3-4b19-3b40-08dba321543f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EjJUwP3on4kRBM0PyFZbq8sCfDjVf0pFGUc7CokLMh8VsC3a+CMWUYe0Xw73B/MZUEEbOlcWT3xSumL3Oja+hiH4kKC/U2P/YEe6Km2PWraTI7H+VyVMSBVjZORC0sTu47T2HXUSmD3M/1AcKAE25zSlzZvP3pS9Z6fCHgptE8/sRyxt7N15zQLIdAyRZUO9TZJOL4HcBd9InTTHeUzZEuASVp3oCioBHU6Su26zPjf0ljQIfSYIvv7xBsJKb7xjxbiXwV/1qtNAjkMbcA8Rdy/oDtprmZCYq+lBgpRrUqzNOj61UDvhHDTDuTI2p1X1936JraMvp/d4ds+RPIZnrSwNgLIoXUsNvl+7mxuDlEmW6QajyYVLWEaaVvqEMVT7jk6ImPiuyHF9kjDkYOoheM8ASh7yVQLLKRJ5BdYjKWVQRrByW1NwoYZU1nrN6W0j0jc7hohuDUq7Nulm2+ymrFsqaiIUqDUCnXKKcZGw5mVyUbgw6CCDefNgj2Y9rn2BW8QrNWRVii0cCmffd7yBg92pJ8nspFQIkGteBYkQCH/T5CKgFSbaLyVfwCu/kEvt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nO0K3Z+9zEgE7oiIIsqGxxZk81b/M1RMyfEyJThY2aus8eK6BVF3cmrB7SeP?=
 =?us-ascii?Q?KbrZvmexgB+PCorGjLH8L/IfArcBmibVOcfeMsAjD19ZUTmBoMeHPPttjZzi?=
 =?us-ascii?Q?5JXimp/W44lX2Fc9kaVTG7JYaV87nu8PRR5AZSn6NvTFsyqV/V4l+JfZ17TJ?=
 =?us-ascii?Q?QYgG2VMx7iRU7vhOQdQvopE9kStiCA4I7vU4z9Ycm2ikypQY3qtHGXuiMsR+?=
 =?us-ascii?Q?aw+erZVxeQhSs6mS8LwYm8A5hcWkM4qMi0W3pTV3FgGAtpMmlUqNkBlDwqsu?=
 =?us-ascii?Q?8/D2ZC12QHIWaTGluo7z009QOAAznUntK3jvTBgUuW4UfVtqaMX4mX6enePP?=
 =?us-ascii?Q?k4vux+i13FC5++9t879DYjo966FioK2QIBu2oyRtQvFCoH1OqM2xN31Y5z9S?=
 =?us-ascii?Q?idu9gzUJQYGL43snOnMK6wJSHQMXjgQvXimIjgIzE0wWkg4ROe6z1WZGhATI?=
 =?us-ascii?Q?tvC9v/LRHSM9waEb81FdICvVX0XXO1e9CKb4XqasQkakWC9S+y5AGOgmbewD?=
 =?us-ascii?Q?xzny3oNsHGtVx72O8Vtrk6dpihCsy99qMw6HWFA8nOz+Yy6AcGJe5ssRAvNl?=
 =?us-ascii?Q?cqP+8PFPAYOIWu0FAw33U5+7Dt051G82Zm5dAZsFs2kxw881TdK8qZQnAI1l?=
 =?us-ascii?Q?r99BPHyA/WZD8EtrhFgcVB4/UVPcbUvSV0aBmIndCjQ/XRg/B+8+jNO5S7c1?=
 =?us-ascii?Q?UWELOU0b79bqxAS+fuHfG8dnyqqbUvBNMOzSJzV7xZhM8HFUhPc8/l9+VxXU?=
 =?us-ascii?Q?DdZVpsUZX0xVNmHYVb6jz+6QlhY8ydDO6QkEO2t1deMg2CoJTecEbCOFPtlv?=
 =?us-ascii?Q?IYfS2eCk3zccVHcYgbti/5ikJDKgHt9/UjQC9LLhEgwkzV8fkruZNyS5Csa5?=
 =?us-ascii?Q?lXv52I7gBC07rBt7Da7gMPmMLtp7/hAd5SmnpbrZVXQ/cDszj7cfatJkaU3S?=
 =?us-ascii?Q?Ug5b5jqy2yfznDaDw+2NghzACwPBt2ux424m3hOwo3wzu7cSplOOeFPyRH6o?=
 =?us-ascii?Q?Yw3vnT/1dAdXZnDfCcTkhW/E3WthUUKocVlLNohfVUfk9iiid0HyUiJXyjQ6?=
 =?us-ascii?Q?NUCNhapC58xuyhd+OoyK6H9pzyclu4RY17g/Wqzm22/D7Blu+JTkk6ioWyv3?=
 =?us-ascii?Q?fRWXtGO1A66AoBovwNAxWsYY9Rya7JalKKk2R5eTJuBpbGJdD5WMOgx1E15u?=
 =?us-ascii?Q?1wYqD5w9aLAkO7sJw8jLR5Hy/6Qnb5neUJSyOHK/yk2KXSHFInkWC3PuV0Km?=
 =?us-ascii?Q?sk0sXM5LHFaIENEZY/zdGjZ0+8L234XeLi3oaR6n8Psy73Wp2FZp23zirNgH?=
 =?us-ascii?Q?RRr0PRd9TMS2hp7tZBTtG5jbbNf1p2zkoLFUp7Kfp+d7w3W7JAiQOEYcFAwK?=
 =?us-ascii?Q?hWe17+XdyThStZRcY5r70DWb4WqoICW3YiqMNHijqZwCE7XU3bQXuMnA1PFH?=
 =?us-ascii?Q?LF3t9OLBd/qI3gRO4kRYNNsLaKQsiElcfaEwtC56OdSrg9MtOB+yjPQkMe+d?=
 =?us-ascii?Q?nlZOrGU9EzP0HL2fUL1XmDj2s98Eg34rFxIxCAoz3u22Z/DhrFJ3aNCqHuAe?=
 =?us-ascii?Q?yzZbvXPM/JbmVpxB5x9gcwz2C1GEarxz3m84GR6/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f40e7a5-6cf3-4b19-3b40-08dba321543f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:06:14.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhW/JgladVxsngRT4VkSNLnGDH0BkgE4sB4xzYTpgX5DPkEYseB2kS6PxwUsi7OeD8C0Rh69Q8zbInfPMFbZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Or Gerlitz <ogerlitz@nvidia.com>

Currently the doorbell function always asks for completion to be generated.

Refactor things such that all existing call sites are untouched and no
branching is added. This is done using inner function which can be invoked
directly in cases completion is not desired (as done in downstream patch).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index cdd7fbf218ae..3807536932e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -256,10 +256,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
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
 
@@ -273,6 +273,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
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
-- 
2.34.1


