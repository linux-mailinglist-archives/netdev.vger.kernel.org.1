Return-Path: <netdev+bounces-32254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADBC793B7B
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DC62813EF
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2ADDCB;
	Wed,  6 Sep 2023 11:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45CED6
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:33:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4641992
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZSMWiC0PfKf7x82+c2S6ejuvNJ6vZ6/WPJzqaNeT//tNzRDYAgTcEi2Jeu4EsoZWCZz8PngDoHEFVGNQovlELjClXaNm0lNTxlz0JJc4uZEh7jotxQ2gN5dz5HRnvMUPcBi2dWyA75IbfBFJEaB12kA9UKmYDCDX/Ptg2seO78qG56pSvFKaQWgiNd1XbAeKYapB8mpusec8gXaeh7OEP5u7bjugaxkJ67R/UTonzteCIUjZqYk9mJ+SMpIYgFfM7AgdpXR3246yEdOvuiHx/jwYuk3VuDKGRLtkRP6nHdnv8ePUaqwv5s9DX3D0YjlU/x1vGifBk62VWpUEAokhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPtZQbSkiI1HYDJVJf0Fl/rVAs+l6vYqpxRJ+jbxOw0=;
 b=SmH9dkIIXFfB5Ab1UuBKbrB7DTCKgdZOXWMcDIB5kbM4d499Mw77Q4KVBJzWe/QlS4OV5TUE+74290BJ1MItwPcEbl8ARzC/YH+AxHuRq8P1BQI61BwjaHG0od+DTZrsNP0UCrxNhf7SuPMTJmrtiBFSht7xR71WeGwX9HBDhiNWVeGXre8Eg+c7qBgxfs5Akn9qNvSEW+lz4+vBAEz06OS0nPmgcPqSv9NBoZY6VtluuGAme3LCmgYW+/H+NBVgI7g2h686OAKPIyqTZCexdVHG2Q0OgcKJs3UC/URzWFxBvUFwYgBW6jAp2+dpxbsiLxVbTV5FbZ8EmO8L6OeVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPtZQbSkiI1HYDJVJf0Fl/rVAs+l6vYqpxRJ+jbxOw0=;
 b=CiQXBge3PYqeTvffK5O78/Xm0+PT5dPoi+w2APJROFxHz8luH7jL3mZ/H0lrHhiO3cGjrEvMztBStsx20EDtBonZjl6FC+65gci6LQ6DvYQ0SzZN+63HPSWrrqzzbpIt59RL3/UykuK7S5tDuw0qYKCrqunPQwJq3i+F+7lXPvdl2CNlUolOCM7TTsvMDYV/gWdRRTxvLFXjdRExi4hVw8BCntbx5OS5/2fgf8PqNtQZF2EY9Zmj61PP8avkNs9q6iVN4HlcZSt9hYuQb0COI5edt+heGKlD+RYf38eZTLdescSY1Wf5/qVMAxTUJS9LMX3e24MT3voKeI7nNy8ceg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:32:24 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:32:24 +0000
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
Subject: [PATCH v14 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Wed,  6 Sep 2023 11:30:15 +0000
Message-Id: <20230906113018.2856-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 37308300-1e70-4ce9-80a9-08dbaeccf109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rGCACGRN9DwJQPjMMmKJWlSWfU62WPkrYRh4ePVijyCPdn7Qb8F7g00tfUvLhIl0Swf4vCJ4nRD850R8ooRtOECEzVmGTCaYTx64h/Bq+KntSMCpUofUHemNXMcqmpmhZkvGMKUEd7Bp7J+ulVCMPgrWt4bJvbgg0h2x+8twEcPVPKEBspD7rmDAHrK9w7Ps75RSVvUHKv6Z4IHMBaZ9n9ezZDsVvNUKxp7/cgsdOA3lSqzRJWlXZVY5rQHhGxwbSkts/QudzUnsnqG5ZhQdlfx574d36cxufgHRIlpcgDbsEkFTvvNDh8ActLxHEPpUCHNPKDOCHuZtTHybBAk8wRaF0E2s+u3BNJE3LLSjnbVe//o1F9NrI70gvJCisWnONL39CxUYoYJqBm+ITC00bT7nTcg3qqcsPD7OKOBzF7QaeBP8FbfaUJDMbSFSecyfvxOjkpCH1nMOLtUfabLRr0QW5zRwBcnjMT/y0OoMjQpAdf6Map35aCBc8H7TO3LdFiY13JVDgPuCVHOI/3jpCJeohKb9ypofFVj7cJxyyYYyBgx3OyY91lehzjFMnFYd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(186009)(1800799009)(451199024)(6512007)(2616005)(83380400001)(26005)(6486002)(4326008)(6506007)(5660300002)(8676002)(8936002)(38100700002)(107886003)(1076003)(6666004)(478600001)(7416002)(86362001)(41300700001)(36756003)(2906002)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aY2Hry9sUvQJ/Pg91UriDHrd+u52YCoZURURA3gTkzdfgbhLRW1Z7K7Zn/P/?=
 =?us-ascii?Q?AuFwxWe+ry5mql0B91l30MkkxH1hnwDCBuUXFx6e3MIZ++/YFl+jAmh+fkIg?=
 =?us-ascii?Q?gO1P50f6f6LrJYFfiwc2uMdefrimZWLD1ZPrcwClKo/DeMmZsIwn8EbLcGTL?=
 =?us-ascii?Q?4d29jDkhNORwKQFa+cAIU4NrqNCPbY+vHAGYesIuBb3Gc/XBr866rsT7B11T?=
 =?us-ascii?Q?TRVTcBwouGICpVzseKXz8rxdLp3SBbo9YND5RsNpobWu9QERp8RV/vAuny1m?=
 =?us-ascii?Q?t/26H7lkilzttFzsAJ8mVnNzKfxo0KDDubcrIx++JHwib16bIqkWM+scjI/M?=
 =?us-ascii?Q?YxX4wbu2kBzm6hom61wol8u4mjhNgaxvEwIDCwiysc0f/lTnUqp7WbZhS49f?=
 =?us-ascii?Q?j1we4Gb76MS/Y/gIOdcGc/c5Fwnkv3UI5PgPRaGomEqbBD9CL6RUwIYnNs1a?=
 =?us-ascii?Q?Boa2dCEaPV67Ix1Xd/MqfK9RQSwIbK5WM4s8HTxkcjFI36bfyW5KohzMxsUA?=
 =?us-ascii?Q?+n1ZA6tx4Kox9L9p3x5i9vpdu/AQlrj077Q/X5sXs3QsQd7Z70eUZqw9oMg0?=
 =?us-ascii?Q?rNemUYwAu3Htig3ZDaYNpCHenFaipcmpRhlE9aNfrdGJW1AqZSx/sathjTxx?=
 =?us-ascii?Q?RcmisD68H84l9IjyZxtLWrMtR3YYWxMXOdN99IpI+8hDcsAhXVjD7ufmyfUq?=
 =?us-ascii?Q?SCSuQltIdCfpIu6giTYK1+I2SwKMo6ovlHAcL47hHEQBQRUTn0Vt5/ocMWTG?=
 =?us-ascii?Q?UoyFqJr5pmGQTtV6hoFnAaPrGqy+oaEuKdPy/teOJNAHcTKPSA4xDDgKWi7V?=
 =?us-ascii?Q?9kl+EopjkYBSMaow3S8ScU0RAOtUOKuXFt/Kug6J9m/y24unzmqwO7o0oF+i?=
 =?us-ascii?Q?TX015HpZh+zmQwgTkCIUIWAGuicEVSH7pyk07+gBthlXE+LXHGJuaP6FsJ/g?=
 =?us-ascii?Q?OhcXPUzMTfmBNaNUF+QvuxX47WPHvM7ADfsIU/Mb4cEXxmJLj1a2vJdvN2Eo?=
 =?us-ascii?Q?F9ZA4Nfm9ak7sH1oXOgixn19WDJMNlPJAU2IOMsJwBwqkJYHIkSYcO8PenyO?=
 =?us-ascii?Q?phPv8LKcLNzx3qgC63U+i6xg3KyiSWW8c36vC4XwQNy8WveRIJ1u/iG+zQzm?=
 =?us-ascii?Q?xkeOO5A+v+3+4VdtH5O3PP36U1zXsNlMv28ODNyT5Go0khUGmviLrOah3Ils?=
 =?us-ascii?Q?q4idWNAl/Yreal7NuT69jr5Ar/8LsDfh+qPV6DtiRmR5kg7GJNdYwt4qwrEk?=
 =?us-ascii?Q?Bc7Y37tVfP0xISkqGnU+KywAf0WSvltBtScwrMlgIhVOocXLrvW1ca0hpE7g?=
 =?us-ascii?Q?n+Cunr1fx0AesLVYUbzgbmCz4gjULTNXjCU9Kw9fDx3MKmqmwBLe5jvOIsxD?=
 =?us-ascii?Q?MNEUJ07Lw9nh2VeTyuBoMvPc06jb8A4+r1cn1zl3rvesKVIj/nTF11qSNxn5?=
 =?us-ascii?Q?3xi9USPYh6JUXAASfXTVLgMTgfHhd6aMQ9R+aSrv2r3cVURlbTPxBZVuHvtm?=
 =?us-ascii?Q?Ucgu4vNYq0qscE2tDRu833F7bjqXHjlqjkRSLt6lC6OhkwCeef6gt/eeHJqZ?=
 =?us-ascii?Q?YpLLDBVZ3iiYzYIE3hxXI602MPRfvuxGxYvJvuSK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37308300-1e70-4ce9-80a9-08dbaeccf109
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:32:24.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lNwScxebfcHI0TrCKo6vj5OnA8LsoZv75sA1yhcv+3ZLB3pHWym9hcbITS/Yx0omotOKvqMlFUC7CKxLgdtig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
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


