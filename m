Return-Path: <netdev+bounces-36860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAB87B2091
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id CD63DB20BA0
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5FD4C87C;
	Thu, 28 Sep 2023 15:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CC4CFBA
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:10:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158471A7
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEm4spMGRhTScczaQ1V0OJHw0Oyi9mMqMSCeXBHreju+hyUU7ONxzqoD8Hx+z9RPUS1BarNugJ7NWMNH2L5rWx6DW62AI48LTFSvbQQ4DDc4IF+Ujn0jXFgXWVULkJ94HOrbIN6bfE9WplE6USZIbRKf+KFwPzEmXDp3n/tz1Pe85qDq8BpP1mNMf5S4NsMuu4JmTBWRC6N0fFzW/UZa6TcaLso3LlaQudeSmHT9VqYo34iPRjPjfmDNbIGKvivcVXB0mXbNYAUCpY9+A4cCZstHMVAC2E3Ih7YKDQa+yBUY+YgXWRdSLqbim8Mx8lJkHger5qFtCI/DltKQaiklbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU1MvVy/y+QR92ZMPAuEao+B/PhhbXCPrKjS0LDEzhs=;
 b=fPBcVcS/nInN93TV3O5Voij79BENLK14NZabo7YfNixHLWDOoUgjV0CgUFjYSjuIZPqF8dvtR3DuLcibT7OTyjDrjivOsug22P/9HwQWa9/b5bGhnGdXhUoRD6W07R87OOchG7IR5aph8cWnBKOuani2G3TTAPl3rT1YDkwpu79kY3XHa9DN0ZLP+ejg0MpUUpMzQXGddDYrytibjKIzHGpeVUn1Dq97iGYiUozeAoiJlgRUGS97+P0EYpRCSf3qLlixPPMUjKtLPs7W5dcu8LeQuGZX/selLMtuxUH367q1AsgV48LPLccbXFfylVYsWocF0P7EpFNNSUqzI3gJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU1MvVy/y+QR92ZMPAuEao+B/PhhbXCPrKjS0LDEzhs=;
 b=YYSrS2+EAxxn5jpdQJfxbo4jEuddCJvHmuUEnexo4VG2cDgfNCbHl0HvMMc+S998ug3wOyBdzPgatPXvdDG92rettmrsQsvw4yZs5sitE7BEvlz7rDS6o85Zmkhy5m3lcSnzogg4jYoZK5jxYrktyoRbhWIfUwpVr+F1HvCPaFVnTHsFGWrgEUvL2slOXCCbauhNU76qtLP5cCYtRI9XieBOE2s5r8cVUKxzfuBWi1yMFTY/Nfa+OeNt9foQ2ViAUHT4n3D8iSIasnR/xoMWmlhGKM5Ss+Xi5GGIQyTwKpidCdqwv/9JRbyemmzAkOKkPkZRNqF5gNbMsPXfa3nC/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 15:10:37 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:37 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v16 05/20] nvme-tcp: Add DDP offload control path
Date: Thu, 28 Sep 2023 15:09:39 +0000
Message-Id: <20230928150954.1684-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BN9PR12MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ae1aba-fb01-4bbd-4481-08dbc035122e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dQ9A3/HE+LLYfo1n3Uq7MVVMUwzpQf3hyxg7HG5IHPdJzSafo2NeQeAJzNVsYG3VhVQ3Lbe9Axwj6UY9ZCVeVxwOtA3gsFp9Y8MauewJMq9+l78BML4SuUC7LnA0M1N6PugVWWQO6ovolpzqOL3Z3vvW2hIyGEC6VGP9A3odHRuPnZYtNkJv86NrP9fq1vwKqeIJCqrZGiLBIWdarMACb8IepbUxAWragsb+dVc+923E+Ud34a98d5eKSdzCC8DJU+cIKPiC1ziom2Xx09XbesHKhdGbv5OUSrcSh+CBJml8a2ReMQUg4js3R9ChxlZ6Zyv+KWWG+KNFCS1hia+HIpWS82bE8VgbVak9AmfSCMxt8p79Oh+vWQllBCrVHnj6W8u8Dkxn6CjqFQbUPO0KE4SlrcNHYn+RT9cRz6uTAOWxfYRJjdpFZwjlGeGN/VKiT8ATQsNAR4rH++GQI+8ETYLkaAg/suPhxrgfK7PZCTJ16I55Vb2s9o5vLN8dstkEvI3Tmf0Nj9JVgb7lAwybqW2xFb0k/v5AGVmds0qhgRu0yi/jtyOr/nElPX7ZhZJE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(30864003)(7416002)(107886003)(1076003)(6506007)(26005)(5660300002)(36756003)(316002)(66556008)(41300700001)(8936002)(4326008)(6512007)(2906002)(8676002)(83380400001)(66946007)(2616005)(6486002)(478600001)(66476007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pg9qqay3ehfLHGau63XyywdYje7tEUH9uKGt7R5OB8m7TCWHdaU/4JeBcwC+?=
 =?us-ascii?Q?hCMgiWWsMt+YTxxEKdO6EAehNDEDItcw0K78u2kGebU1HuFi91IW0DvX0YyY?=
 =?us-ascii?Q?i7WICSu/IVhRnfWDGPrJmwYQ81hEmhr1iqzKYNe3Q5ZAkrUAP1kNq4xglcSF?=
 =?us-ascii?Q?9Rm8p1rodT89Aato3B7sBlq6bERJxjJnWXz8MKXpNJvqu2B/7not/v2X+INq?=
 =?us-ascii?Q?O10YmpszxoI5ulW7A153SL50lgsLJCNU85Kuf/kRV2gk2tkX4NeCXD7FRd2e?=
 =?us-ascii?Q?aG/Uf8N0InwvDkIVibwKDFzcgc60nrfRVKszaauTrkjmEIXLd1p9HNuQSTxr?=
 =?us-ascii?Q?pEmrZidgrAJUQh6u2WGb5IQYc0tKvLCM5UQJvOpzR0nQiofeSXxDoXwYjTNM?=
 =?us-ascii?Q?rCZYdDWvKS4DeOiK7rAD8zUJBt2gNzRYpLdBcBYfK8l9FDd693mbQZXXOCtU?=
 =?us-ascii?Q?v/gMiXGBjoTvmIHutqY/LeG81C7JKN4P1+wwYsrR9huPCVeVnZtQWXpnmTHu?=
 =?us-ascii?Q?OOJZm0YVRpsBRuVGzhjYT16KyZNpNQyQwE/3qgvoncVZY3tMersbsf+GOguV?=
 =?us-ascii?Q?DWjqFqb61ZTBn2Sdj+XB+8YLqMvmI2NwrlAo91mtmHbBhXWYQ7Z37FrI+jU3?=
 =?us-ascii?Q?alfN76YCzp/MrKr69Cq3AUOuZWr2uzwK+U/YBIov7oTJbozWaJO2avfl0OK6?=
 =?us-ascii?Q?UxReLVq1hq8lduo+Z1LcewuYi+eucDg4dBfixvy2F5/qf/18EmnU5hIlNFGN?=
 =?us-ascii?Q?kYRhFLbDY2laoJS0J/TO9dC+jdeCLCu9i1nA4YpCc1YO01p50DYgw5dT5YWE?=
 =?us-ascii?Q?+vUzUCxFcVwdipk7t8rM2n6wa4/fV2d14k1FplCsvs8iHq8POTAKXMElALqO?=
 =?us-ascii?Q?e6BX8s0FaFK6jmvUIGul3zjPC/D7anpkY/xtYZvp01tE2jHk4vhrc5mMc/J4?=
 =?us-ascii?Q?f0eedoMR2D6PrPmJBZmBLLIHIA6np6Ou//gr4KTz+gPZ0ja3m4QdC++fL0lQ?=
 =?us-ascii?Q?WBhKDQ+iA0M4FrJZWj90H8/SL3htavO1EEEbRAIRRK6pIDfDIQwsjobGHN2m?=
 =?us-ascii?Q?E6ps382kPqfwFDtHDA4G21tn352ZUjyUURl8ub5WPdo+6bmYNxKzzc2bnatB?=
 =?us-ascii?Q?V9o743Pol++PwjKgrzI8h987HVqQyrlTDt/WLvKT5sAPu84nT1hsMHADd3nE?=
 =?us-ascii?Q?jxczESO8iUjE438SWU6Bo+cGbKy6s2arkNqyi7XczOHDjaQ9SfU0QjJUiAwE?=
 =?us-ascii?Q?iefo8T0BYbRVqPrErz3Smwm+HS2odnU/V+ex3lN48koaW0oQD3wEldbHBb5q?=
 =?us-ascii?Q?hDu52fN0zsl6qTQVY6kvNsG34iBLzZWjI5xDpddcv0hygpVE0pjoG/wQRiEB?=
 =?us-ascii?Q?BMFjAE/1yNZ4JTnIv+PoTxLPI+KN8V+AD8jF2+75kkKP75F24musb50g2f9r?=
 =?us-ascii?Q?eiqq7hU5up8jsRfT0VVV5uwusHqKDRHunbnigBZHhq+NCOCJ8xsyqOXf/O9Q?=
 =?us-ascii?Q?+vHCbixvNNKejm7usBnqwWCulpndpAXudtmiYXI96ufMiKld2L2skWBlZHt+?=
 =?us-ascii?Q?h141v56G7PQ3oc4WPpS9CppYlRnFrJT3nyhdU4cz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ae1aba-fb01-4bbd-4481-08dbc035122e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:37.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDgWzfwun67+RBhEnWYzeoKzYI0YcKjIfaiPyHLbB+1Bve1qAfLWrPmez9O7B33beWP6UhiypWxkJA8H8uaR6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (resync), which will update the HW, and resume offload
when all is successful.

Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
for queue of size N) where the linux nvme driver uses part of the 16
bit CCID for generation counter. To address that, we use the existing
quirk in the nvme layer when the HW driver advertises if the device is
not supports the full 16 bit CCID range.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Socket operations need a netdev reference. This reference is
dropped on NETDEV_GOING_DOWN events to allow the device to go down in
a follow-up patch.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 261 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 247 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5b332d9f87fc..604649c29838 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -16,6 +16,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -31,6 +35,16 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ddp_offload;
+module_param(ddp_offload, bool, 0644);
+MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -104,6 +118,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -131,6 +146,18 @@ struct nvme_tcp_queue {
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
 
+#ifdef CONFIG_ULP_DDP
+	/*
+	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
+	 * an additional flag in the lower 32 bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_tcp_seq;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -170,6 +197,12 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -273,6 +306,166 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *nvme_tcp_get_ddp_netdev_with_limits(
+	struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	bool ok;
+
+	if (!ddp_offload)
+		return NULL;
+
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk);
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	ok = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
+				   ULP_DDP_NVME, ULP_DDP_C_NVME_TCP_BIT,
+				   false /* tls */);
+	if (!ok) {
+		dev_put(netdev);
+		return NULL;
+	}
+
+	return netdev;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	int ret;
+
+	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
+	config.nvmeotcp.cpda = 0;
+	config.nvmeotcp.dgst =
+		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.nvmeotcp.dgst |=
+		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
+	config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
+
+	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
+			     queue->sock->sk,
+			     &config,
+			     &nvme_tcp_ddp_ulp_ops);
+	if (ret)
+		return ret;
+
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ddp_limits.max_ddp_sgl_len << (ilog2(SZ_4K) - SECTOR_SHIFT);
+	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	ctrl->ctrl.quirks |=
+		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
+}
+
+/* In presence of packet drops or network packet reordering, the device may lose
+ * synchronization between the TCP stream and the L5P framing, and require a
+ * resync with the kernel's TCP stack.
+ *
+ * - NIC HW identifies a PDU header at some TCP sequence number,
+ *   and asks NVMe-TCP to confirm it.
+ * - When NVMe-TCP observes the requested TCP sequence, it will compare
+ *   it with the PDU header TCP sequence, and report the result to the
+ *   NIC driver
+ */
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_tcp_seq);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
+		return;
+
+	/*
+	 * Obtain and check requested sequence number: is this PDU header
+	 * before the request?
+	 */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	/*
+	 * The atomic operation guarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_tcp_seq))
+		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	/*
+	 * "seq" (TCP seq number) is what the HW assumes is the
+	 * beginning of a PDU.  The nvme-tcp layer needs to store the
+	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
+	 * indicate that a request is pending.
+	 */
+	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static struct net_device *nvme_tcp_get_ddp_netdev_with_limits(
+	struct nvme_tcp_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -715,6 +908,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1665,6 +1861,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1681,6 +1879,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+
+	nvme_tcp_stop_queue(nctrl, 0);
+
+	/*
+	 * We are called twice by nvme_tcp_teardown_admin_queue()
+	 * Set ddp_netdev to NULL to avoid putting it twice
+	 */
+	dev_put(ctrl->ddp_netdev);
+	ctrl->ddp_netdev = NULL;
+}
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -1707,19 +1919,37 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+		if (ret)
+			goto err;
+
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
+
+		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
+		if (ctrl->ddp_netdev)
+			nvme_tcp_ddp_apply_limits(ctrl);
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+
+	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	return 0;
+err:
+	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	dev_err(nctrl->device,
+		"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
@@ -1911,7 +2141,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	if (remove)
 		nvme_remove_admin_tag_set(ctrl);
 	nvme_tcp_free_admin_queue(ctrl);
@@ -1954,7 +2184,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -1969,7 +2199,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2077,7 +2307,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 destroy_admin:
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, new);
 	return ret;
@@ -2257,7 +2487,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (nvme_tcp_admin_queue(req->queue))
+		nvme_tcp_stop_admin_queue(ctrl);
+	else
+		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.34.1


