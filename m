Return-Path: <netdev+bounces-47715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E997EB019
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DD3B20A9A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333BD3FB2E;
	Tue, 14 Nov 2023 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/thFDuY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FB3D961
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:44:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9113A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOibifuX9nTF42p2kqY3RRraH1WAX2ptGQsmMS9dGEJjQle+NSt6XIGyVfb/bVnslr1zsiIdubN1bLX1hz3mUIZCP/ZACtDpLgo/PeHnUcABvNJ2i6d7cqVulkRq5rwDpVQrA1qxBtWD4Q3NcLPcTBf700fKsteeWHPsOrKPssJETh0jLoUHkwdniJIAaaF7MWE64uq/xAqH2eSkK4LPhea4zvWBG/nTLQpFJHcKci8ANaFD5hLVkJC0yKoxO58BCZEhqC/+FnP8uq5eunewDgRITrX3pmBrrUmkZXrTEgH4d1/MZSullig6J0+sCqVraZT+ZNwfYKn+lrcLGUs3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvb7MfjxhflAFlTyS3xrsn3CQoP0HBbIVNA+ozK2lQ8=;
 b=kKXMolrFwqrP6lHQVnxExUko5qbqcpf/PnZ1rJ6yxZuX1aAC1rvZWt2nXNUe9IF7W8OGkYfJycYocuZUf3c/R+1lM/aw2bOVqPBfOdBW0R9ea+2Pdw/YDkdanUXJdnca2uJJX/kT5X94krqverN1vkRUyT0DjPKCVvBHt9Wlij9XkkdffUN9D4IZYg6p7JGTohK2ENxIu2tb3/YjKXpv9ypVDHnM80iaTy7iRx2nt5EICTf7tj8IYACeTYBHg3DSz7XGXShgl5PyxkMrwREwVB8iC9KD5gvXMAcO8Hqh8p7MbIgaMMw0SggETEIRjmKdv5GmrtGRT6blcTFXjyoVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvb7MfjxhflAFlTyS3xrsn3CQoP0HBbIVNA+ozK2lQ8=;
 b=s/thFDuY8tshKb1FHn5+UWEWTV0IymV8qF/9AdUAPZajzZDpGyT/9WEyc+OFnsWBVDB50SSgBg0MLPY302s28jIOlxt861mBnXGizymf8NFSK/DJMqRR21UF3qne38AqpCmfhj02QUhfm8fr0BVSdMgE/QYhBSJnK4VbHGXLhWIkYmK8yPJdZcQCePrGfQ3lSXkj3a+NwAYykO9sClj7FFk9t9j7hQhVvPzllNSHWeQ/9qPtJ/2zaClyXgVmaaffwLAz1RpEzvIK9hpz57Pk8wITgi18jpa+cmiKPd3fB0ta8OCmIflnKlbewY8wDjDNr+jZLF1HuFK1QWblWxEtbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:44:30 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:44:30 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v19 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Tue, 14 Nov 2023 12:42:51 +0000
Message-Id: <20231114124255.765473-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0306.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 585b5078-662d-480f-da39-08dbe50f71d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PgGrKpNeaLfrWCZRAw4PTKw4+1IRZQoGfNYrXL7/gazLcFkbXeqN2t7rIAGX9vKTMwIMMUA7ZHbjEI5Pub+QnymGYfAB0PLE1TG8+6nvKhGxiH2mfwDO76D4MGEshFNiJhuwb0KCKswt1oVXLnX8CJf5m++SdoxK0zbcEGKH/2AtUyPegUQlVS2irbHoEzULkLwTcmfZ4l6vqxE2Wr0XPnIO6kDxu8VWFYm1SFFZ6VMNn0jgEMoBaUZp2P1ndYPPAmezx6MNooBcY5NmNLXOrzIE2guxKzBf0DR790GBOYXek449hgS0fXE2EynzER9nYy8IhVlOuCcoL+kyjI+Vezg0qIUyrxnGmlAZs9CV+DjxmQyD4KxAOFkKiTWLiCqMXQkEyXgtm+XuKgWmSph1QaS6OITP84Db56RdfAXdslmavCvvAwkOuiYzOed32fp2CoI9Jyt1TJ9KH68wEpTEO3wJYTtlOtCjQEowayLuWtMANT0FkqDbEmwE6NanlvoN5AmhNME4QX5iTPvQhDIMUiVLavaV6Ly/Q3G1KH++y1t244k3MwxXwO2ILfr4066t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(1076003)(107886003)(6506007)(6666004)(2616005)(6512007)(83380400001)(8936002)(4326008)(5660300002)(7416002)(41300700001)(8676002)(2906002)(6486002)(478600001)(316002)(66556008)(66946007)(66476007)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7o+jn8NUyVLrwI1pTpt4rlHnhDdoEP1iguJ5V9kww+/zg+vHMTMacY0g7kL?=
 =?us-ascii?Q?10AG9WwQAEEtD7ADSTH5B3kLZEpLVxWVqovJGoVA+PDVASfYiVAK8iOXg5pj?=
 =?us-ascii?Q?LG3+NBIp4R2DjpXc4WDTPjNBP9HQ7loiLWG10UJ3PGHt/zp1R8INdvtmiYBL?=
 =?us-ascii?Q?tbcnMYdx+Hci2mP2F7BnZHo6WcKOsDHxsPbvrUxJ+FfBkO8PR4YKBT33SjqX?=
 =?us-ascii?Q?3sMzOTzUeLOItTZJDXCsQWm7xUR29XKvgzb6JIVDppIBjEITJQijXqKHafm+?=
 =?us-ascii?Q?UckeNzMeJrAX15N9hFsRr4aIBWBkr2mcEpyjJ4p8rNqVpSoXqYvo9NTN5S7c?=
 =?us-ascii?Q?ErbtczW5QKYEIuzlCHMSwDS3KxONsoBc0QRzZzWWDWXW382gmVRpzusxPqBE?=
 =?us-ascii?Q?APwoNKe91gyqlWCLMD1BCGuTRikdWXZtDJD0zwRxX7DD7lU6K3a2saXk51s4?=
 =?us-ascii?Q?PVqHyaA+e8En1860jWmvDbTLU2AdVhtoYxIuIruDg+N8LoG4UmWtbJx27esP?=
 =?us-ascii?Q?UvrXvLKioADvUdKmmMFc6a7Mzb98w4OK1Y8NVreRuk0C3+G7Qet4luXga6G6?=
 =?us-ascii?Q?75ZRUtmdXyM+9IuHSetGtFK2IeiUb30jKsCAH8C5uIqz3DtiIsfixtJ/3FfM?=
 =?us-ascii?Q?KqePpHEcSYWLrF5vKyuIYtPBIGHzCQ/jlGdb81vh2k/lYXcl3jC67zZeTIWQ?=
 =?us-ascii?Q?yta8pMS0NWPdG4RDejxXqvjvZGQ1S2v66nJ5++w1W/FfcAKnHCevybyMRMUX?=
 =?us-ascii?Q?CRKuqXk0KtXNQs8oZBWKax+u5bU61Dwum4k/2dCvaV7EbVvlp+HSdtWnYlMo?=
 =?us-ascii?Q?FEuNwtnDOAQQq6xltB9ejaRjKHU3T5UXd1tu+P0R4Nj348LiTfpcmZlgqhTr?=
 =?us-ascii?Q?qUMnfkWzFJ49FdOEi9ZMwAz6oEerzBR4LTrpJFIigYA/AJTUs7IcmK6Q4wfc?=
 =?us-ascii?Q?LZP8NWFamZvzj5/kAitXQYU5gp6AItxkXx/DyIUvKe0eFr/2ps8d2OB4zy6A?=
 =?us-ascii?Q?wulJsIDcC1l/RJbDhKo6FvLqmbXx64PDmxGbZuYpM5MOkUNEMMS/TBLzVHu3?=
 =?us-ascii?Q?c6QTpsUmBRpVa59oNAC0RZDjNKU7sSdaxBSwjxtuxnBkJiS61Ou4XvZLsq7M?=
 =?us-ascii?Q?jaIfiur9kS+tg90auj1uIPEX2hEBl62XbXoXbRy+pMfNGEYyHo+SBqZA2pAe?=
 =?us-ascii?Q?QlGDg186QczLdltL5tPTEk6D0nhh0+Nt6P8rUqIHGrSJArCviguxQZ7epdPx?=
 =?us-ascii?Q?Unhw3bIJeNYlsMDOYxKvyPFGI1sqnQdvaFlozQ2MKcsackSUYPLYpv2YIbXD?=
 =?us-ascii?Q?stJFljnWUkmNWzUmau6xnGd7Q6hPqhirhPOAF5I3EqnA5ZKLt0xMWso49dad?=
 =?us-ascii?Q?C7aEvjtFcepq+NPcn29IxxZYHlC2XpBbL0lBWLa5KNGOqFthvetIqrTj1Pni?=
 =?us-ascii?Q?VxP824LZ/5os6ReF5K1ItEd/4mgHW8CJMmfyFMxgq+bKY/o/3K58IFY+8fQX?=
 =?us-ascii?Q?r2+W0wWDQcurL07pfkKhXPa+DxEw+Y+CO6l4NMnVcqK8bP+Z3/ucyKT0yQMn?=
 =?us-ascii?Q?jUdJpybZmoKcN5u52x9Y4NOGadZFE20ZfnmfQMLM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585b5078-662d-480f-da39-08dbe50f71d1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:44:30.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64YqkDI2dqV4EtCnXyT4jt7OzH6dYDnIzIPv7lWiFxVR+ofspsOtoUDj78ngvUITZt7lY0Wq44GwEzoGkMpIXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463

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
index 56969fe337e7..8644021b8996 100644
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


