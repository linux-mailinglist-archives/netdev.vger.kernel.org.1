Return-Path: <netdev+bounces-17251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B94750E64
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398F2281AC6
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872C514F84;
	Wed, 12 Jul 2023 16:20:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B314F6B
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:20:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006302705
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtLJWWj72k54F1JMIMBYQVCAO5hNzOC0iU9S4gbXCT6IeZtJ5QqwV5vM5iaKJ0jVACwvRYKh/IFmRLG9Sgs9xLze5smAv4ij3zXZp7RcBvM/BINome6+mzPPtSKty5VpxkdcJXLKP70xqIw6K+AXI3I2gSYqmGtWxh2VPq5z9GMJuVt72FwMugpcjujwXvB5CpDJm1a3808NOAaJFBshyQMmLJRKS+9Qg4GG8xXPJoQOy3l9lmECg45htj4Q5E54u7FaHxeqf0XL+g/NGx4obpbQte1kEhsxejmUEjFtXzES2BUaCLGVn9hnbK/cLh47mfZBbNMp4GklEoSUI/8OmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPtZQbSkiI1HYDJVJf0Fl/rVAs+l6vYqpxRJ+jbxOw0=;
 b=LLMVqYJZCpJnsjEcI6kd3c+JOAuKG6xz4NwhjARDlHOhFZKA7g8S41FhwkMs4VAYXmIAIkUgdnqd/QD30SwdVQj+Gjbc84mIdqNQ72/8Rx5GzSOXaXi3JWAd1IFg2T7bbG5J+F1VU6rtry9PkE4ZcplE1SdO3Dv2mwDw5mn6EFH2sBYByimm5F9q6wLzvhkFSiHY1EtSrLXKb/GK1rydSuumGFc8bontepykH8UR0KKdc1peik0AxWhW4t+QseYKf9ssmTgn/2yRPvvhHb4y9rK0uNv1H2wc/2Qd7yK8aWbCJc0U0Her3VVzwyf4RsoNX0xTN9Quko5AebEMn2dNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPtZQbSkiI1HYDJVJf0Fl/rVAs+l6vYqpxRJ+jbxOw0=;
 b=cuaMmZNFEnlRnXGedgSI8+haxySwM2u+0bL3c0tvrLRASSyxf1WAyDd27dSm60nyaVXYtCB1xUyqOsDOZkfzLbJQu9a8t1lfhT2r8nq975+/rOCjtfQnnmAy6b0sdINuaaGqiNRR7q9GY3Ns8HFOx2/MSNSordllMehr3NW8vHHrWCBmU1ZeNtIBDBgJKy+MTpcxrE7W0ApNuw+RhlwZlcUgKOs2Y9a78mWOiuLJTGVNR3CjNebe90iV1GC9L0sdSJTfCbRImDxT2FUZGs00mcSG0Ut/jxZriwfs0nc7EL/0mSdLjX7H/iRvbehHK2ckdRwvppJa0b07z4/jPgnJMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 16:18:36 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:18:36 +0000
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
Subject: [PATCH v12 23/26] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Wed, 12 Jul 2023 16:15:10 +0000
Message-Id: <20230712161513.134860-24-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9708bd-425d-4938-04bd-08db82f3a508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6AW6oZLRF0Q+Bqs/F4RyJRvVU0RrxtCZEszgaIFELGKDWTVgarYFHGs/IL6AdAR5oTVB8R1rOqIJZWsedevEXexm6GwQ429tW+CP9CNCFqEDhEcO0q0rTkroMiMmJqJ/iXNyFj7gjz9lP+Flw9g6HRc2OmBW3SS5eh2fpSB0bcDu4sTHnj8aUQ3y2gdxJwOT46tK08RH7M5/6rgDST5zY+xXfECgcFfXftjv6s7lUyTnc1QGS+Yq8p/cITwBfbt6my2CHd9WJVCmsr9ZUNXgMzISkWuqtZwYRpyRT8Q1zPjWRK46xP7zxdchoueQdQ/OQclB/EY4qsQeftfTPar1Ca+Gy4U2exuVI5A1iUg44iUieO4mj7400aAS5fOu44uS6cUWLqrqvtogJdaIOQxoS1obhWilP9EplrZMjV/Vyb4lzwdEo4JRPJ/l7ftTozIwVvSIIVhUyhS0UWEgXcHRXz08cAQr9GtGvvQEwNNLd3SgC1oxVWnZqb+dyr64MAmDRJiZt8vh2lL3lD1TwJc0K5ll0ycn0Wd6AaZeMRPkSn4+ykVm+9IqvsdWO07Ue+ZN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(4326008)(66556008)(66946007)(66476007)(6512007)(38100700002)(107886003)(86362001)(186003)(26005)(6506007)(1076003)(2616005)(83380400001)(36756003)(478600001)(6486002)(6666004)(41300700001)(5660300002)(8676002)(8936002)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lam19OW0SmjlWk02dwMCvPN3Xih26zw3UOWM0q2jwsFzveFWQn1c/rb846NH?=
 =?us-ascii?Q?a1K6li1axPM6bsImMU5xX1W51tebbZCj5shtBfRpahWURtekMXH/q7DylRIN?=
 =?us-ascii?Q?NedJkNUjWey7X5m96j+/eGhDZ4Y1AjGjzcsV+s6t2Ms5YFtpR+7Tbh+2D9JP?=
 =?us-ascii?Q?vBzzfXURQPzs6EXLY42YaHLpB2Ed8h/VXbk/NJYDwHVBOnctFkFWO0A5+Gv3?=
 =?us-ascii?Q?nkEuwx/8qVMv7Zhrr7ie86B26CT+AJFHpkR8ucSde5ONVMCxn9ZGiCz1P7+D?=
 =?us-ascii?Q?4Ufd5H/9F4OkbXov/4QDjVefBBl7xpcAtoCi1qW1qLyJb6TMHSsu3Gw7sIDl?=
 =?us-ascii?Q?RwUTt3UgtVsSsafJxhB9YZy0Oa89PpisugnhCKYkVekdJyaXs1Os6y+0Ltly?=
 =?us-ascii?Q?lNuCRBgaETuPuYRVjSdROv6ihrHnSAtqOU/bZEUFA+q5NiFa4kMdhJ1FLZzc?=
 =?us-ascii?Q?Fwd4c8mvpTsh/PHHH1wcT3vy007J0gYbfLaupw05yapnISNjNj83vN2xnfT0?=
 =?us-ascii?Q?R2lGHNiHeBgSjcKD4kJK5t4fxKNYLKcj8z44CLSOl803bvoObIKEcwgksPBH?=
 =?us-ascii?Q?/1YSkdcBGbdhqJ0Bhue8rnuJ0t9cqSdDetMYKyPc3AzxRZh2XzpokrlQDmRg?=
 =?us-ascii?Q?kaPrDMyxweSfPaoXi4Tv1iURDUO4T+zbu8g+1lbhNNBwTfYSB5Wzgt/QOgkm?=
 =?us-ascii?Q?6uPaVH8DGW81X7lAl3TDtIqtD0ZyhdPNFob71TzEcBdYJPPgdNyj7/q7/QE5?=
 =?us-ascii?Q?OPBXULJLCzfrQGvpwhK4t/qgDEhwpiOMN5Jk+IA525+cSs0NDyZ5hB9rI1S/?=
 =?us-ascii?Q?IFedvjY1oFja1ITeJWzXltVnvnOZ1VQHmtH/6afAZSYqd4rnkIl2dURkejO8?=
 =?us-ascii?Q?wHB2yLpTiDGEtT9mKNwvJwTcmJKgM+v5RXC9KQgNsHz1Xojc6B5HvCF0sGjK?=
 =?us-ascii?Q?Aih8841RA8H3BnidGWWhooSwDixki71q7yvyumZjFoEpSiGTAYBcSuUjHbU8?=
 =?us-ascii?Q?USkYeG/n7bico8irKREAtN63GrnHVBtJTg/ZsDrt7aiS75e714Q2waxwEKIF?=
 =?us-ascii?Q?dGmi75qwfiOPgtVxNQQhzWX0WnIJeC8mXQjRGTb3hHqsEBYj0BUgxKwNuQaA?=
 =?us-ascii?Q?uCEM/V1g9K+/QqnbejlATXTQYCoxtOI8OdfwzaK6RSsxcQE+Pmb8ULzt5anu?=
 =?us-ascii?Q?/OyYohBXG6zKgmRoX/cfD7XFijPGrDaZt9zRsei26YO0kmiSxUEAJMIUuAIs?=
 =?us-ascii?Q?SmTk8tBeHxeeglQXArj0oisJGI5i5aA9fb+2RzqVj17iEOSbzKuvc/P6xpiT?=
 =?us-ascii?Q?saSYWL6CXuZ1HG5YAGbGlNTBuyt7HgIL5dqock3Ymhknx0qD6RHkb9iPMQgt?=
 =?us-ascii?Q?0pvHTHhoSVbMws+ChQDBpMZUae2ynnWTJ/s/xsGv1BBCvRBS627xL6/7WojI?=
 =?us-ascii?Q?/0o6IgPhTFEfEIlWolzzwW/IDebhUi3vYpBTGceHuOqW+twr+7miFkl0punI?=
 =?us-ascii?Q?89eRkNF2X1Fy56Nd3yV9Z2oP94jKU45KzRfSRgmO2Ec+V0RtfcCfVpG4+f5i?=
 =?us-ascii?Q?NWm+CQz6xb7vw1RNnJgBswpkpYwUBR0LIQ/rsV6C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9708bd-425d-4938-04bd-08db82f3a508
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:18:36.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tedEaVB7WTm4GL42Er6JibP5cWQcH18oOX8ngMFXAsU5HKyapUeKZSFsjQk4U19yoN8xO1rKtwsO2isZAnrww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
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


