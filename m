Return-Path: <netdev+bounces-29680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FD784518
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6A81C20ACA
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB31DA24;
	Tue, 22 Aug 2023 15:07:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7141FD0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:07:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E6619A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k61ELey94anSkCy9ipk3AahlOj8nQfr+LjuDTDmuOBLoTVprNV5sKGm0Tev8oTbI371DhclxddFOi5IRMnmMM4dLLgRt1OOak0Iy//lrnIUVk28SwNO5m6u8XEJGOuFCmaFg4fKAliz/u7UQ3oqL09EV+HFnpKVFXejm7Be8a+HWDNshON8oY2ewL2F6E6Hjt+eociRGAy/9SrtrM4yGJaxyRIowptIfe+W+W9zGn0Yr03tZqsmpa5O9mZHY9GH7rNYSRMQP6/2RYh7gG7QQ2Wr2ZEYNDRuYjtWIMxvabwn95WwF67oYu3ZypVYHHvWji3bkR1m4P3YcHk4UbVmm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPtZQbSkiI1HYDJVJf0Fl/rVAs+l6vYqpxRJ+jbxOw0=;
 b=a/Jm9aQKkERuh2vpHGJNEisLgJu8bYu0+0rSf+lSYZ1TwSazZzUUTqm4SPav4BzLHhIiO1DVXUiQ460yCYcOC41FChYgIwPvHtX58VNghIkv3kDXLsAOlUkUS+vXZokai9GS5Y24+XA4p5Q1TefvaB6xqShJ5L3JCD+ICvLAP+XehC3YOurqCVfUJFuo3rranjS8kiKD2oyuAj8q7va1E7L3oZPcJYS2LY6lt5SiXWN4poJRNVeAuu9Nd3QK1WV0RMohjDSCOoFe7N3Kpv4NY7sNzjvdqyjh/b39tFlJRglxghvmCxWyI83jphy3ZVRjRZmg21BW2HIV8Hsk2ELGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPtZQbSkiI1HYDJVJf0Fl/rVAs+l6vYqpxRJ+jbxOw0=;
 b=eCV9vXb9rw2J9ANPQTHJyRibsutoafHsStunmCukSFgcUgbJvnEoG/RDGOvt4fnAvSgHhsS0KYa9eElS7PoloFF6akAQz68eqThxWdXWB8t2kBa0RtDlpXHhHgl2DaIVPnrFnV8NmPXD+PvwUMrAem0c/EdQYQy195LL2lw+cK4+Nft+GK9UiD4OSU8IbOetzMkrFIsJXfcLS2tom4zAkxgj3cWS5D+aiUWdTBtF4vbUci74dKknNiJV3WFoX74JDy6V3TXviww3xTSur/ZKteSJeLZzjOZYm3Z0WoDEufvzduknhfv5mYzHfl4Pi3vItSysMA/T/r5NMmXCLSU4dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:06:56 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:06:56 +0000
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
Subject: [PATCH v13 21/24] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Tue, 22 Aug 2023 15:04:22 +0000
Message-Id: <20230822150425.3390-22-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: df20cfe3-1882-4aff-80a7-08dba3216d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pcynLn+VTnWWZEYRqZKDB2IVTRQxfWZsp7JqilSoythccH2Qn282i/HwSLjwy3j6+bvYE2vtncNfErLsRVB/ta31PAjrJa7kMA7nDOxCR1WRTbV/UumQaakcwfXKblWHoG7RX+yS6lx/zVoikewyN4DYtKHcIW+Y0OA8CV0/7ypOdRwTWeVeGrsOZ8XgWFhfOzxW3p6RjN7wQqXh8l+tsjFThjaMl8UkV/mne7f/5aTgvXx3Tp01vPbxC30vq0t9A2UlQgOAJe9PIRx77nS2/qGAiBf+Ko406ho575nx/aSNqZUAc7YeLxTOApeYo1s+eojQsGyt14oxcPC8x92o0dMsE9QxOaDiunydnXLZWPy5W4zcdkg1QY1zJtNcT9LKVCfhmu/pvG9n0HI4pMypTZwxSIBXZwEaJ3YBWCVy+nP9PIJptN3B4FEKwgAgyLfFuJrmqUGDT0L8TqGpw2EaYssRc5syRLnf+Vuw+YUF7FUNKXQTVsYxKpoB6eNyRlZekt+Fc85fC08TjXVm9qRE0PAAnKoCIiC9cn+7VH9ORy8bW0UUJ3E/WSL5cLvdR7m2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?voPjTLknWxwWKdT0qG9xUgmXv2ZzFAG2VQIYC7BJbykE66/b4zOauMeNMfIe?=
 =?us-ascii?Q?mGKqhroQN9lFTQD//CaT9YH4zsSUECa+eGW+SrhTZy0HVDc9ti5Wox131Bwv?=
 =?us-ascii?Q?Prrq5aSOEHb/LpPVL4+/mQQjI0Sya+RZpAoe5ZopZlVgPHxkfEw7+/3ef+RC?=
 =?us-ascii?Q?q/etWVjbKW7+i0DHQOdQbgOCVxXDLOcJl8R0tQdmNqjj6XfSRuAj8oWgJMJ5?=
 =?us-ascii?Q?s6g/gdX+FyNf2tQ4AGBIudd6BBw7xnqt+Nt7MmRPvm5dd9br50/5iAui1KgZ?=
 =?us-ascii?Q?YKv+7zevbLR5z6yjR7iOoHR4iZ3lef9yChYNW+FLQ2H+mp3ioDbRdgIVVO1N?=
 =?us-ascii?Q?B7/WEdPohXWjXSdhrfFZ01iHjiYD3N20I8iVA+BihReGlFTxdACzuoFmkCeB?=
 =?us-ascii?Q?W7/k9ta/7Ft8wgCJxGn/Lz5O56z77ufdC8nvEKd4+pTuOhRyKJibuZrxPuOX?=
 =?us-ascii?Q?R9uvb4t/3idWTXHKQV6SLh//Z8FAMFj+CyVU3m1GsU+p71bUBGIHNtPNeA86?=
 =?us-ascii?Q?nk13RjlFztKxRBrOvCcO4cNLhb1/TznjGQYE64EtL51qUFBNWu813RQYcmTJ?=
 =?us-ascii?Q?Mt+bEIN0NTF+0dAYWDjeH2snr14JuJoba2PrAA86/qZQ29TBXcV7ok4WUF17?=
 =?us-ascii?Q?MLF78SKALYCLP9A6RxkkJT98tqzA6PQmBvZc4hog8OsKBbokjM+sdUfUrGd8?=
 =?us-ascii?Q?w2emJwDwVHNz4eGWRVQO/MyfEhxQKVjKypEtrwdHhs31egxzRlxejVtmQvSz?=
 =?us-ascii?Q?KcbaIK0g6y3qoqtCYhPIDLsXfPTGmlqHYe/dVDEDZTcI1WIjjUSGGRCSVwCq?=
 =?us-ascii?Q?vxEwfr+NgveQnv4yt9aPy2uJCRolPNOEJBUqB7qVkBNVZkvAGwOoYfI1cIU+?=
 =?us-ascii?Q?Q07Be4Q6nrPrmuhojfIr/kuWyl5DWWMh1XWZoxsgHBHvDlqSpZGzmQGywP8t?=
 =?us-ascii?Q?nLwY8lviPof9ua6nivYCKJd5m8g+ZwQEBFpIJ1ToUvD27MFE86WAYJzyOcFk?=
 =?us-ascii?Q?3BEsKPxMwv4MSqKJ55j0eGH+b09LfD4ns+24oWYeSWEyohF5dNmMaHs3866W?=
 =?us-ascii?Q?zoztTSX0qfi0SXJ1Ax2zLz2op91ZOlD//AL5HMsSuZAioAyDkB38Lk8z2GRr?=
 =?us-ascii?Q?ACr9RF3Bgof0oP9T/6aUqTQmvizED2c0gz5Gw5nb7G20gUB7wODsK5HZSmto?=
 =?us-ascii?Q?WYVAUa+zXGjWK4LGDTUQD8+GBvPYmr8bhk4VBD13lZT6ORX0o8svPLPUP9+7?=
 =?us-ascii?Q?8W4tTMJW8V+CVfGbWc5bwl5SdCzz7BvFwHucST5qQBV2vCUA2+Ky120TNIKD?=
 =?us-ascii?Q?j9SD53IouInUtmb18AStYNqLe7FnEMt8FQV+Opb9bTYYrmztWPbxgvdI9948?=
 =?us-ascii?Q?OSrhF6ixbhSvKWrxvG2gZm/xpv7huRvs5arNDDOtHn6OaYdxmVY9Pc7fW9fS?=
 =?us-ascii?Q?tZbgWqv0hGdGUF70xPPvZIKh8Y6I/XY9RMFl2rXDMddhYajbWa5aoOpycCOY?=
 =?us-ascii?Q?ioFbWL9BmSspL4o8jZmB8MwjkP+o0d8oHjLNnkqluejpWjDdMX/7jdjV84Qf?=
 =?us-ascii?Q?eo5MofpT54Jh84e7myi0dlhgjHjl9mwsTn3RI6L1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df20cfe3-1882-4aff-80a7-08dba3216d0d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:06:56.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEfFQCYOv0ukh9AZjMmHchbHW4inz8hwwqvqX6AnwfTTD/36ZO2nGGtirUrOlpHBZ10HAfQv/7DoKoPUcBcmxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


