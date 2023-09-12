Return-Path: <netdev+bounces-33135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AB79CCBE
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4EA280F34
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5E171C6;
	Tue, 12 Sep 2023 10:00:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19616410
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:00:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0411737
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8gdI43vMJ5DRbRZZHticwPa3bgbd2jBJEqgzRfulz3SOPAGS9IjEYdEiU2s6q50Z3mj0hgTlvu3BxsOpVLCT6qV9TEyhenmOeLBX8I/8OZ+N3m9gjOE1slFNoWnSHoce5SxkbuHmVwvBrcIZVMmjJ9/Qr9YxpReVETldyBYZWhvwdrMXZ+UY2tfcrfXwxT4nVhFquhXGGcPMANB00HNFBFQP/miFYPmVVpPeQAMq8FYkwe0wAtGiSR+GfdJUR9mzsnp2NHnW67taoF1hcFk21u9BdMQw7eVZDgHvbM02HURwhF65HrX+ayt4WUf8ilZR+DdQaCb02PBWshB5k9pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWH5MI8Ool4axJYuH2LsMifYS4ir5UYmWfQlg/PEYgU=;
 b=QNdNDpDGXjRcIsnLRkrtYbb20UniOR7XyRhGECG/AjwJ7o4ExA9ewT+XAtOk/yd6z58n+Hfzdbc1YBjpHW38QBqTad3X+5bujchNttcmEXHNGiw5UGkkSK3xaBmhfuGQAkGGofPEiKBVpPfyeu4YBQlyUE7jHRPXiVFvbSoFdrWuQ0Y89/l/apzl4ylvmexGBttXeubO7Qufy1ZPHQ//MuxzxbDWyRPpa8Pu+qcDxMe1falBJYVSyXYER2TM2WIpUR07aMnbRKdD71d7viKgBP7y8MVlOQKNX8WreA7ZA2ssCfkyt/eTe21beecVu5gD+/xkZW92OzplFoN0pL4MJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWH5MI8Ool4axJYuH2LsMifYS4ir5UYmWfQlg/PEYgU=;
 b=aVsbnYFIJUsVM2k6wRzqRYiE2AVaEXF2Tp5vQgkMe9Wa/Q15pbBdwPTotEc6igZaXd2+faQl+CBiscFpTWfu/toYWm8/Kl4oKck+JSSf0sgJG9S6qKKGikRUvj77lZkHfuJJ43NyZTY5O1EO0XaTTtRNtjt+ei+Q2DbEk9LeHmcw6Wy8AVr3UtcJzHpPuGbtTdc/jBoHuV3XV5qotyAMzUoOrEpcJuFDNlCQDnIVpssEGZtvMCbu/4VqwnA45w0Z+i9ZBQMYgXFMuIHpP1RFZAYEFY96eaJW08S58jJ2NbUFBW91UeYWPOMUBUjFuTMp4c5jaTc3F1paL1V6r+di9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:00:41 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:00:41 +0000
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
Subject: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
Date: Tue, 12 Sep 2023 09:59:34 +0000
Message-Id: <20230912095949.5474-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: efa22a48-0165-4c41-7342-08dbb3771f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PkQGrjFwVtOJepRHjW3WPUdQJMuZ2TgarqU7+zppZHnZQU0ABow6TUGL20cvdAO/NMqdKMOw/MYMwlBq0zbckOmpEWEauPB/xISm54PhSkyfC9Z7YuG/weDv4nzzs3RaeB5R/sZO8VXwxaO6GCZTm922iJidJ5tU3B+ydZmPiiRmtUMxUfBEuqY27bFmvRY5xRDb3dq1oN1XP1Q/3dXz4pygsLhGiLLnV++DjGgs8+AQDx+IFCTo5aSN8jZjgaomApSQiM98lpz9dWJ/HwTjFDfkTvJWVnYLWTmpVZovSbB8C/MXHd4GKRq8W3pI67zdplNGxxuno/FGCpZX3GXJHlOCkz+kDVq/LoMpihWubcCmnuhdf92PjLwmnJjBVhtD3V98dLTbj5wBixLVSxtk0aDrUssD6OkP5ilQ5cmLzJtGsNk1R7rRB4u09T3nwgtnRqB5c4+7++fzZqF8/S9AmeTOfKdGIhy9dKR43u/SOT+FQCPQ7iZ4hBQ+5DDZT8H8Zi9I1s3nM1vBCNV+V977Qgkl9zmu9oS2IA/jrlmYKZXlzqfBrxMK2GDZFAHUyPNk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(107886003)(86362001)(83380400001)(2616005)(6486002)(6506007)(30864003)(2906002)(6666004)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3VyxLzMnLI6Q5FyzCJM92s4KRBDgmKvC1fet/GJcr59iAk9DdH3p3ssQy/D?=
 =?us-ascii?Q?Iat7MGdpELZfvBI3WsDTw7zr74trdEoh1DkjeBjk52wWg3dzsh3dXW1nDxY8?=
 =?us-ascii?Q?C8FWWVlvQM/8aO6jy5zHfL0c1UWWQsFNH+ZADdtsEK6ldRX5fjxjDRRVdCNf?=
 =?us-ascii?Q?VYXJvMtQgro2UMyneHd7fOGwvxnfxmWWsd6o2Z+g8IJGc0ghB4Dr/YN9c7xD?=
 =?us-ascii?Q?xzWNGfF+qclxCFviZXGG01Ec+NsYg9QyZqjbHpKBCzSm4ey9eXaVZOTa7YvG?=
 =?us-ascii?Q?iVAp4zv28hDC2dqmOvcqVvsSg3rqTKuq4bJL3hKqt2hUIW0/BIvL3mZjWg9C?=
 =?us-ascii?Q?g9Yp4fwQsRsjSXfPCWSCa7aunWuIfEGdBs/l+Msd1/AtOKRtDC4WJ/71BiTr?=
 =?us-ascii?Q?EDvVST34ZYhUgKu4+1qBj/Ayc8A8P3J/cXQimb8u5Q9BvCrxTvYHlT/NLkyz?=
 =?us-ascii?Q?rhQH3AzJfpayFca+wxFK1RG4luCuGE86ZSdrsAhcmNdUSCEHIUHAi8TJ4yrN?=
 =?us-ascii?Q?/JoPwxbaAHeVRs1xpUWVW2+U42HGR+XaI084WFVrvesGJdRfwZCyK7VNU8wi?=
 =?us-ascii?Q?oaeT+qDNO0DOTeEyB2PCv7l+hpOT6cy0gzHDOQ+auCSnCGxKDHOzlN6zxni2?=
 =?us-ascii?Q?d+o4dhu5w/7WZ9VMuUuQjVxagM/u5JSf86Vf1WFm6ejQOoKIQpTsQk9zQRRT?=
 =?us-ascii?Q?eJ3qx5Bq0I9Yj8IaceUEucCD7C4xt+2WhQnTDFFIYrgsVv3bKO6QIALujjWP?=
 =?us-ascii?Q?zyKD1f/8VGD6a778iyH9pKy2stBJRpq9cA2a1jCFjK7weP6E5km0pN5gFmeM?=
 =?us-ascii?Q?aDb417tdvlxQvv+FnE0FxE8EAPmH5jFPp1J/DB5UdJzhy6rwvizD/aj6peft?=
 =?us-ascii?Q?8dh7gB1lm2tOUgXwU3O4LO9uJnHy/tDJx9E2JVtw7EmkUlNXVXSbi4KHCnnp?=
 =?us-ascii?Q?6FRVAapD5dA6PUm9jaPL5u3ax5wDA1NDf0q/kWNJ3dfheJ6hIgmNPAeChepi?=
 =?us-ascii?Q?H7Km3eG85pfGxSU0GS5plUzGQE7cuoMhYOmwJKYK5sCT5sKURIt8HiFI+64z?=
 =?us-ascii?Q?RhSjprq7BgKv2XFkjO5YJfLHLxdbOU9LPAkC7MP+8WBJ4FZrIhvKOEzNop7H?=
 =?us-ascii?Q?+HtojPB+ioXaZ0/1DlKZyZMhFhHd24AW44nsKBsBHzQO2hg1/FP1+XFp5BiD?=
 =?us-ascii?Q?tTIGSS8/LI/8oFcH0PdpQEdsxCc8uE4iko3f7Uwg4mswxW7FOWI3MiBxxhVu?=
 =?us-ascii?Q?0jrdskx5UTxvxGNZQPbngkE9oBW2oguu861pFDzVf82JSAw4w22TRJH+AhI1?=
 =?us-ascii?Q?xsiNcm3mgAIU93u/3ylmO/Vxcj4HabCmRf2u9xLAFlMxDat50MgYcmVvAOw1?=
 =?us-ascii?Q?KAmuGVC/zmrRzOCo+KYB3UtA55NrPV+9lFsS4AkkAgttNHKUqn3hf2MSGJl/?=
 =?us-ascii?Q?4HLLOV4MYIynSWflo92+qPm1y8zjF6KyCKby4/LjCMcKqiJ7/oKfU30Bnyif?=
 =?us-ascii?Q?UxQEVlsdUx/7g2NmifI3bArFV9Hqrp32DgBXvWw85thqd55zaKRj0K/3oT1p?=
 =?us-ascii?Q?uAT1bq3GIumNaKEa1CunS6Ct5sT3o2hKQuBi/LOE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa22a48-0165-4c41-7342-08dbb3771f29
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:00:40.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXczW9Hbk9Nbkv8aMOn7Ngn0w0i6hYnZd/xGpaaNrSUFJiZAUZtiV9F1PBT9T4vLRiVsyUc9z8iVYBLrjSnJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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
 drivers/nvme/host/tcp.c | 226 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 217 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5b332d9f87fc..f8322a07e27e 100644
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
+	 * resync_req is a speculative PDU header tcp seq number (with
+	 * an additional flag at 32 lower bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_req;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -170,6 +197,12 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+#ifdef CONFIG_ULP_DDP
+	struct net_device	*ddp_netdev;
+	u32			ddp_threshold;
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -273,6 +306,136 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static bool nvme_tcp_ddp_query_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	return ddp_offload &&
+		ulp_ddp_query_limits(ctrl->ddp_netdev,
+				     &ctrl->ddp_limits,
+				     ULP_DDP_NVME,
+				     ULP_DDP_C_NVME_TCP_BIT,
+				     false /* tls */);
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
+	config.nvmeotcp.io_cpu = queue->sock->sk->sk_incoming_cpu;
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
+	resync_val = atomic64_read(&queue->resync_req);
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
+	if (atomic64_cmpxchg(&queue->resync_req, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_req))
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
+	atomic64_set(&queue->resync_req, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
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
@@ -715,6 +878,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1665,6 +1831,15 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
+#ifdef CONFIG_ULP_DDP
+	if (nvme_tcp_admin_queue(queue) && queue->ctrl->ddp_netdev) {
+		/* put back ref from get_netdev_for_sock() */
+		dev_put(queue->ctrl->ddp_netdev);
+		queue->ctrl->ddp_netdev = NULL;
+	}
+#endif
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1707,19 +1882,52 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+		if (ret)
+			goto err;
+
+#ifdef CONFIG_ULP_DDP
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+#endif
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
+#ifdef CONFIG_ULP_DDP
+		/*
+		 * Admin queue takes a netdev ref here, and puts it
+		 * when the queue is stopped in __nvme_tcp_stop_queue().
+		 */
+		ctrl->ddp_netdev = get_netdev_for_sock(queue->sock->sk);
+		if (ctrl->ddp_netdev) {
+			if (nvme_tcp_ddp_query_limits(ctrl)) {
+				nvme_tcp_ddp_apply_limits(ctrl);
+			} else {
+				dev_put(ctrl->ddp_netdev);
+				ctrl->ddp_netdev = NULL;
+			}
+		} else {
+			dev_info(nctrl->device, "netdev not found\n");
+		}
+#endif
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
 
-- 
2.34.1


