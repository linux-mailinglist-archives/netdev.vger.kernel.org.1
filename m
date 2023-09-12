Return-Path: <netdev+bounces-33147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F026D79CD42
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AF628204F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19A18057;
	Tue, 12 Sep 2023 10:01:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CA168D5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4191BB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koEjNYl/Kx/Lzql7gxh+dd/z6sGpOf0p+m220GQ7hZGTYzUYcHel4W2CSf6DTAKRnOYtl+tuucZ6FvWWRgIzSJLEahe4yACYF/E0eQ43JPMXn9iFD2sHzTBg6UXXy66I0Tc1QA3wAHdYHsPxWfA6Lin41eA/nWANkNkgVbKpXz6MXsE1bCaRZtw6a9QU7JNh1SgMBD3xTb2GWO1/zbpOPiO3k8afDoaDYi/5IUyPGlJeXmBw+cHFYr5+U2osIYc9IlcA+ONOpifqNZdWtU4GKJjB2ARPWDwoAOMd8ksDLypS8QxKKOQHCl4DOdgzIlcsUKD/969Hj9l0NiResxnKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPtZQbSkiI1HYDJVJf0Fl/rVAs+l6vYqpxRJ+jbxOw0=;
 b=d/aZLZDRy77L/4A9onY82Xv0jelFvhppHoo+xed/en2fGDbczmToQqSSW2Ax4RB0oq6mFcF4vWLqv3xX4AV00yoRzmbPew48mUpTm1u62auhlYgGoWtEFHXKOC+Wh0mG3OBaVU0rw3icP29aRreNqKL/L5gkOk2E9mNRKFOoIcSY98eMpuPTqTBj8vgMjlJy2JVJakL8W6bz3bqw1MTAcIYUGb3rvAjDZb2N7OAc/7r3CeDYzFW8j0bvNTFSIN+aRwTWbeN5/Rp4lzrrBx8BvUqDcfpY7qsf5+XJqcArnCVFo62Rucw6zBeR4LxGHHfoIXexsUeGdFNp+3MbF4BJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPtZQbSkiI1HYDJVJf0Fl/rVAs+l6vYqpxRJ+jbxOw0=;
 b=CJQUAqyxxQ83k6MyusdPplrNWXNzn42kaTtPRrZOGuWoAV83KBwCyKNqnyZnxBOvnJRLlJJ3uiYOTE61R4lvCRRLbYOtU3bP7WuclSDawTl0He02rXJjqk2nOedpT+EEsr1798LMcZFbfFgGDiA59IpVOzVMiFMwTWOFssxar8RAwlMpIHbu9xSk8v41jOVyv6skE9120Zfy4KLPAev4JEF4le0adUp6AX96VC7TNyuqu/IaIdUW+yEG9cXyHQLU0k9A6FAJws5cde/nMA9U14Rc8nRlmusKaEbI7nVkeFjoJmXVQBbaF0lNfHmN3H2xPlD3iVqKAhAX13rat35qQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 10:01:46 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:01:46 +0000
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
Subject: [PATCH v15 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Tue, 12 Sep 2023 09:59:46 +0000
Message-Id: <20230912095949.5474-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::16) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9811dac1-4dd1-48e0-0ab3-08dbb377460c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g6ejnBwmw1jeY6pBibj4SIhXO+5Tq8seFfh626rXgrP/FTAk3kmuQFwckKGBEodNwVP/s0PNsGizRNCN+esbek0Z5b8NyGR5fMPupVBnB28IEegS1BKbagAGR9mLNt0uIuFnq1ezg9+88S7Nc3j6mXtM87bdbmrmwjStBHU4ZWUXJRxozdMOuUZDFgtOd80bqIfQwVVaNIYY/oAkSHNP+sjycttZQDjUB7lElM3IiteJDGeMyLWSTES8/b+PoW+e/DIr/6YMvvCr+sdyrw84SNFtW7RNCMA28s1WzNDxwCXOQL1pS3KatgW5bej9RN1rJ6o8gOMaB1T8Xig8QYniL8KBXNH75Ax/8Dbmq8ttV0xgys6YATh4exp6DInB3fusfg6jA82uVd5R+yTqTXG6KUtep40o+n111a77FB7NM21erWDdw/Zw+aFxgP0RZpPzvDnTGevAevvftv72ir99UV2xDb5RNJbp2HCwMX+6wn24CrrpWTblgtk4ATWXqUuIq0hqpjEhLKbOW6j81sfbqAvWttQCi5mlbG2Qwy+21iHp1F1J1Kbm13BQDCRZZsGN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(26005)(6506007)(6486002)(83380400001)(1076003)(2616005)(107886003)(2906002)(7416002)(66556008)(316002)(66476007)(66946007)(478600001)(4326008)(5660300002)(8676002)(8936002)(36756003)(86362001)(38100700002)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oa9lbfTU1CeeiQA7/ZqsDbX4ImeTNbZItBDswk2p5WrIU0evHf4e5ztczewu?=
 =?us-ascii?Q?jOowwHKc+FQwnV8MFdmfsGBzvvVMqBbTSB3bren818sS3yGwWKZ7FK5IdEi/?=
 =?us-ascii?Q?Zp4kbcke2WU3hlw4D4Vg13zgNyePlh37WOUd8AqSRNRQTChawX7CUVKkEDbf?=
 =?us-ascii?Q?PCTTj6n9rWKPDBGDWznYGQdIqF+Gvz/noc5o7eJvc9UmF1i1J2qND+9U7iQ9?=
 =?us-ascii?Q?Sflu2xS8nCyJGlM7aA/TeeBXRJx8ZO2NktFKjwas0RuDbdmW7a8YpsrYIGOr?=
 =?us-ascii?Q?E/8SAbni6rzZTW9fT5tcwPM/jrA19rgTvbYockpy3Dqoz2qXGwapPG/T+Fx/?=
 =?us-ascii?Q?cP6l6r2o9tPsGEJV8nzjjb/ErYXkh1efONnR7wOLwVV1qxNIMZ6MG4lptKHe?=
 =?us-ascii?Q?NFnxZlTdzJ7JDV//z0vjARgJ74g3foADrEQccmZoR6jB6Ze4nfsGLzgisFCQ?=
 =?us-ascii?Q?IL8WYoSY0l66PgXedRoxPQN7HetNkQ9GX+PZmBd3UjdCwqIDw/1mJleT8vn/?=
 =?us-ascii?Q?8hFayIMknaXmqlJ5ksKEmDHgmuzCglecHH4kpgaFB6GSD7aPRfSGxr+P3iwh?=
 =?us-ascii?Q?848WXPUjsvsp12A0NRXUisnZ64echZkacfjUoL9S2+1XHeaQgwbYOdpygeL9?=
 =?us-ascii?Q?qWlNTlq5W/VoLt9cLiORoT6XxjR3vNYlbaQKNJeZZtZglNTxj3DsC4bh6RFt?=
 =?us-ascii?Q?LUZkpts62joydYmgzZpySM1ikgGU6v10aud6xbLdRSY+DZaAVCS0zM4kATbT?=
 =?us-ascii?Q?RvO3JurGh929fHNpXBlHrr0nz63LUVN/6sTwZt1dwlUHUfgAhONZ1J8hGhhe?=
 =?us-ascii?Q?qyRSqdSk9u7QrIybv0b/lI49RqDsX9c/opZmqwCz7Gy6x5uw3stF6DWt3LEe?=
 =?us-ascii?Q?ddfC0E+EZZbkBbFt5rWEZQWPal29CdU+21UU1+llygE4G1DI6hLqvXQPXdHx?=
 =?us-ascii?Q?fAr4IM382ao/AP7tpnmJ6lpb2PH+GLcqNaBK0c3bIbx0afH0j+J/e27/0d+X?=
 =?us-ascii?Q?R/fRiWIG4s5pml+MjX+nWrAiAEhdYK10bU+9d4CHtn9tFttlfF11jcyYjHfn?=
 =?us-ascii?Q?fPmv6TMm4pKDCS/ROmBHOlbT9TK5Q25PmailqQIWDb0hEhhh6EAJ1hE7cbG6?=
 =?us-ascii?Q?YDQNV8a3t+hCGzMOzZs4BEr+QQxNlxYF5evqAWXhLVcVdj+yQgroQtI3LJ5a?=
 =?us-ascii?Q?eSylkqvoYLSBWUt7geP2b54qN5encOf3ZYNtTYohwO6wCfCbSe/i1niYCd3D?=
 =?us-ascii?Q?O/c02fa1h+MH/h/gSrL4G60jUX9F+MSariNBmnWJVHMQISaiSJ127FLV1NK6?=
 =?us-ascii?Q?oP5mhXL28ufwZgxRgGVyqmzwQf9CO81XiIu1febZYCzKQwcs9ddNWBZcFd4L?=
 =?us-ascii?Q?6b+8VUdjmkbWiHLX5fV/k078ACJ/N7Z/vSizRTszVD8Kw8VNOx14M1RrvLD5?=
 =?us-ascii?Q?q7dSDmZEiZuPzqKIH3d/MX9a6Y59/T6x5ysCx4Z0B4wz1WxEUoFcZUN7FsJh?=
 =?us-ascii?Q?2OrYO6uvINJ5G18wxaSKWTqqueWeE4GxCMhGazY0ZZV9XZXmeAL8CAVXliWB?=
 =?us-ascii?Q?a4f1KirBdZYnzRLRleATnzGo4GrhMNfuds6dLtfh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9811dac1-4dd1-48e0-0ab3-08dbb377460c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:01:46.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ciwKJeyV3Ngsaf8fEbHZ/JyTo9lSlDJcOf9bqwByFGU/dWngDjUC8Eq2Kbe6jxDkp66qxgSOW3JEUsxNJ8d9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 146 +++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 770d3f2878bf..8f9af0f2fb1f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -683,19 +683,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (count <= 0)
+		return -EINVAL;
 
-	/* Placeholder - map_sg and initializing the count */
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -718,6 +855,11 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


