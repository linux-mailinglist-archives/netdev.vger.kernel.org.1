Return-Path: <netdev+bounces-36872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458347B209F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ECEB1282C86
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEB14D90F;
	Thu, 28 Sep 2023 15:12:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E31E4CFC7
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:11:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCF71A8
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDJ6ppMIL96WF9TUqzlF0r5UFoBfjKuj6sDwPYwPc3hqPsgHVZXkBuNwXh3mAN9/ibTAVpkr1VOGL+3udDvFOBDoGyp7Kie0DM3Sk+/V3XF0kCRxlqw6kGmxPzm/fefn22AXNG7pThEyH0XOZj3833NHtLPfoHJFdQ+eC6HQekdr7TaPMJzta/gG0/PLv/Jlh0s3PuTeR7n2dC7klaERHD9j+FY8FfXbKv8xrCVg1Wg6SRi05UhTlYl7kiQ9lScUwSA3e4SarZ4fGh7P+z5uvQ2V5h+k6q3iHu23b15/Nd/Lh7wQQu90PRAm3xp8xapm3rhIhsg/a7l28tA70bsQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7Q8CxWOyVaJjWFz5HSpLU+DiSVUzXdmyFq5NQ8Lios=;
 b=i9szcnftn9rrmQQB3R985zzwDy+oeEQojLS3+5M8M3kKeJudVTX+jdu5ewAo2YyyS1RQL/3tD6ccRCEkl2CA3tmcPqSdA9/Aqe5viLcLsamd7xg7rplPjykWaai4rL9zpCWbN9dWBRthT2jdk0aOCkKXQUzW1d13BpUJPr2SUO49J2aImtyRmpHcicdPIRfq+nq5s2QOL6Jw7GCudWD3YWGk16T+WNXaooKIpUApzRj8wr4lGTjZhvHcSi2cu0k2d7NpN5ClTvrkjT/5Fdwy6fhEiPiWMK5GppsNRA3/ZX2JVAU14MhmTaZqn6Kq4MA9axs2V3Kk+aYfkou6NF1/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7Q8CxWOyVaJjWFz5HSpLU+DiSVUzXdmyFq5NQ8Lios=;
 b=dUjGG54Bd92lIRhCU89U0otfbIFRa74W6yz5mGgKdjigbkAgtcyovut/Hj/PITC4iVv/br6nMWzA+N5f61I6Ki9oiLFJ7tUvIaEJV96XciuxGnp6GdJu78Jf+fh5iyj1JzEocx2wJ7IZcWR8PmoOUYVx132ceQop9heqQfhdPzCWmgktyH3Y0nfsXBtLP7UhQ2qRXGZCun7uhr4z5ZpDzV+xyBosiKy7Py6dmghufGAcM781Q9JNGwkEyFGGxqAOQ6C9Z8nOtiIS8ldQOaqEZ+0uegRQJsO765WeoVfy2p7GQEs0SXFoKUb30fG30BN22qahDOCHobL04c+03WDnAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Thu, 28 Sep
 2023 15:11:55 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:11:54 +0000
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
Subject: [PATCH v16 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Thu, 28 Sep 2023 15:09:51 +0000
Message-Id: <20230928150954.1684-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: f721feb7-5778-4cb6-39cd-08dbc035401d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7/MMjZmL8i448bHs37RFWiHM6ydPED5Q8Ro6wlfanj+/bLkh3MAH9pF7WCNLGVN7txi9dxyEPfOZpI8QLwdWKZk4fgwDPX5QeY6Z/ynyZdQ7137+Pcp1gzYpxOdnHoP6Jp4L8/plZXBsX0bPAtzrZgVE6AYkXG2XvX62AcE3kZJF5KM2fiJOtYF5e3ukinmX/csiXVtc97/mtCrIRhPvSnfbbMlV95am9cSwKlv0HPrZt5Pgr6yMlQYrzdRvNAP4554cD34rsiudV6ugHNtAS0R8rrM+syeA2fUkS7DaKCfhUEEd4jUu8zdMmlYcWyxgnXZwIETiP0RCFRTHDhI2kZ1FLmvnEhgFU6IRH+G9VvCVj9TjYs/GCLWEqHzlDul8quHliOjexlJwagkW217g/xI53mVL78/LM2ebgmcD6jZMgbl2CqtmOelLsXJkZO3uYuFJeXIsdf3lk5EwDLDr9ZPt9w4HVaxIbH8VRxVY1kufNtur0x1eI1G5Gmup9BHqLgFchlHy8Gpgz8zJvk/X/H2MJHzxcSfO/imVZbzonWH0r43HwNK2gEm7mcQLDaVg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(4326008)(7416002)(1076003)(66556008)(66476007)(66946007)(26005)(8676002)(5660300002)(8936002)(41300700001)(2906002)(316002)(6512007)(478600001)(6666004)(38100700002)(36756003)(6486002)(6506007)(2616005)(83380400001)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W20IKk2NKBeI4xAd+9PSig8Qogze3EQfl0M6hSx+NsqfLwffeNM8UYuJKLoL?=
 =?us-ascii?Q?LYxtKGlmaB+09L1Guyx+nFR57YVEXkh10RT97EfSPSytQtsKdq4kzKH7RuBT?=
 =?us-ascii?Q?9g2IiLcmCkWhGXLNwCyhNqakC3mjAh3o+Y6MqdcJeo+0Ofms+8MSxzd/mCNm?=
 =?us-ascii?Q?EsMgua+EnKkXDjRe0W+N+Tnxa27DbQVGhpA5DRW/btjNnhB3O0GbTTE1+2cN?=
 =?us-ascii?Q?B93BGekjiyYBjRG0P/b3XRmEViBcFv8VWLrkWNctR7gHFpyxeaGxC+R03g59?=
 =?us-ascii?Q?XzewpTKpT2s/sdnIma77fGSQ4XepzrzgkTdxRSU1yuyJaiH2cKu006nq1bQn?=
 =?us-ascii?Q?rSF3SUVK5LId6cDk/LZz/+F4QwG6OGlHMhHgLetHalXTgkbfvHY2cL2o//TK?=
 =?us-ascii?Q?5VT/veZ+iu+68iYN90fDWQHVK9JGTjwhNdroM197ZQqk9YQFOy2sDOSBFoDg?=
 =?us-ascii?Q?7Dt3XQl9Rm9/s7rU4T7N6VDCTfoe+Kyc+cUn/shnruJB7ApTMW4wn3+oAn4c?=
 =?us-ascii?Q?g9hVJ2fqzzNaQ4JDiAFtuTjk7962MIJ1mBWDODwcmn18VRfEAlh88Zt3mdrz?=
 =?us-ascii?Q?hd4dxwGg0vCZb24c8HLhi57/YFIoQ/zS/ZU5wly3qRgSZA5lEr/qIXIU6wRr?=
 =?us-ascii?Q?DI3Sgpeh/sTNh+k1GucyW4XjF2kj5s+cbHpORMSOLWNKbToKbyGPaXrJ6UHj?=
 =?us-ascii?Q?w3VrwqB4O3dEDjoBORBrHjBZoWhghi/otLlzcIHD//RTwu1xpIp2qvJMWMws?=
 =?us-ascii?Q?B33+Fa7abi/1fyucEHORqdmPIG5Igmfxjib9g+167UQZcvB4VAk6cLZY+dhB?=
 =?us-ascii?Q?o/3GzLKrXv0zzSj1D/g8xCfpgg3mw6Ce4ZIO4E3ebIsgU9RoJTJ1lZcGq5Jc?=
 =?us-ascii?Q?FCufYlJ5O+44Ki7Lpxy0JOZW8wRrm91GxOdp3u4aD8GzRBGNXtNfTrGrRIOv?=
 =?us-ascii?Q?lmxepnA5cvxrLpIut0ZXbNciI+7A2SHtYDS5YcHzuKUxbfgydpR57T+TNHL/?=
 =?us-ascii?Q?yAdHmgV5yyYDFbcOVQxdJAFPF8nwaE8DMX9F6oV8BdQKN5wHyAwE1CJYh6Nj?=
 =?us-ascii?Q?IvQ+fHp6JLP8kIeC34MahBEqmrYnXUjgeYcLmO3Ohv2xLHnZlM7g5bj+vQg6?=
 =?us-ascii?Q?UDziyLJbrJB/A7zfvChm0AEffMyD9DjEPPLQQg6Eem4FqTCoEvCIQUYj2fhV?=
 =?us-ascii?Q?54KywZZR6e2Ag3adDjkZcvaJWLCTrNrN1svEqkRnEYDUMKhXeWCzKRV5rdWC?=
 =?us-ascii?Q?jt04Q8FhLpNK/jsIsQ4kB16RBUFA8XWu4mylL2AjqR2PoQPOWMSofE0OGERt?=
 =?us-ascii?Q?TEzysKfJo3aimJ+/9MlyJV/IGtHVoSr2BmzLC6jqJmsMB80SgM90Iy+0a40O?=
 =?us-ascii?Q?lKz+kjiNn3ElY6jN3QzR8bEcmStIhD1C5x17+4q+ROXCc/8SzI3utZYJ9jEU?=
 =?us-ascii?Q?U4jgwtYsTpUdnjlscHs+KRlaIiQ0qjpMRK7ZyomTeFGlPeI9FkfSUSzJnEzL?=
 =?us-ascii?Q?apQ9KbH3OTXlYh8XKkTcFYJ74r8+41gt9j2YFxX6vVEoGUjvlzSY/bke4PlP?=
 =?us-ascii?Q?Fnb/sEp04NIEi6TG87vgBKtJvq8qWZy7KKChD69M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f721feb7-5778-4cb6-39cd-08dbc035401d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:11:54.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmRzpGFRhoTVX22KeWKdIlVf19DzcYbu0l91lSeQuOJB1xFQaobSrmJ0cDqsZH+qszvbvziyZM4yn34Jjtaa6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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
index f419ec6ae3aa..ea7e4cc1bbed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -684,19 +684,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
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
 
@@ -719,6 +856,11 @@ static void
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


