Return-Path: <netdev+bounces-29666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3B6784501
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514D7280E51
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E701D2FA;
	Tue, 22 Aug 2023 15:05:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322421FD0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31A5CC7
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn4O0FHkh17twqW9Ly3hWViqrIkvf6iA5kxMHk1X/CYaXB0mw1AXpCDObudRqmaQwL1frep/wt+P19djHNai3kCmCrhNVpU+otwIShgOP/DzTFjmWkOKyGbV9Im8tlLOwL3BPOCrKiNOOY3El9i0Drpj5ZMHwa4CcmPGPCf+4ufRZe432w9/CZIPGMZtEYcHRCrTQ5k7cwx66TDpUnq6tYwUi6b1jk514/PJcPRQmYdj28kZzr/qPwcUlwdMJn8PKClS0E+xL0UNaZts80TnPlO5Pm8m3xujwWvCPUflCgA5bjc9+ehq92QBePnPU0XiCJ5sBtLEadwVA7UYRR1MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9pKHbZ27wkqcih/om8NwEPw4CQRXs18uzWlhmNgIEE=;
 b=nJ17qBdXDfQvPiHyseGBrHmmkJ9PXRsb5olj24D3DNhopbxmLPVCfIXn/KqF6gnvdXJJP3/YzSyUj+qYzH3s3jMy75tlbg6MFHpDc4FzOzNMyWv6JYLrz2OD60prl8xVJ46RF1rgBGk3KogmN6W25qCbu2Av/gsleH7aJLiPnerKbPO/aD5DEQocbbf+HngKtINy97a8sW9pD6x61XXN3yFnlEbvUQjBnUF7vpOZeVczbpitiYMycCO8am2F7r+Taahahghd/98ncw8KYJKlOJq0rOKpO63PiUmxDVjGDbQBZRwIESsjJtSk9+Yxu3i/gtPxMbyQp6qllsw3Paq8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9pKHbZ27wkqcih/om8NwEPw4CQRXs18uzWlhmNgIEE=;
 b=CXXc+1YAjE48SNhvEdq439gJziHYewsj2cdgFr1GgtV2dGH9LChdzyx8je7reLnukXWjFBr+5XWpJbB0rTPzfkC7/ci/mQ+Pq0JKRAEcJiquYEAjxBKsYp+2h49mZpiaCo9RQookL1+DsO2uHKwdsesqeRK0nXYG5dm/4NKP5cnlUC6WAJA+bd/zYvpFM5fZzaGf2V2uT172vCi4IqG/VsydMtbYxjQDMt8K2FOXvAKomdStaw2q+bH1oYk/iLTt3UJ3DF9lOnR36lrMwb+miu3NWM2QEa2SOxVEw6gauEtR8coKT+PozeIbnfFoLCoV/dzmNYzTqtu4COro6iY3cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:28 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:28 +0000
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
Subject: [PATCH v13 07/24] nvme-tcp: Add DDP offload control path
Date: Tue, 22 Aug 2023 15:04:08 +0000
Message-Id: <20230822150425.3390-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f0862e-d1d3-4051-ec03-08dba3213899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aWPyiBTtmdq6BSP7hdEQyz1JJcsWG1IjIGsReDhvYLeumeeSb9P39eqAtXwFv5c9rSRUq7cGlV5EfC5qHXzfILdl+EELA6cjPD4t6ICgYP83WUT0SoU3qJYUBIJiLRsauTPjd3Q3lpBdQzQpIiWaVv9KOq5N3EsB3Qeug0XqKqMMAy34s2PGXkl9PNPqJnutkneJwaLREz219Zp5U/SzUccCMtaPnykrHNKPPbm0+ZVnuqohgqI9uBDKRij/Vl1f9KFbpBpe4KuvvE3jNuKJXutjj6j5FzKUneWNsMBHEq4p2n3F+cx2R9OGdVm72ijq9NTsWDwWTMKwNEzEXWuDndfeE7fjM6/HU+vIPwVwrDeU1HdNI1HLmH16GBG+8NRTV/afpBWiM4ReYLA/cdLdLcfmwsb60w2zt45n5hDGDQFn041T/L6AwHmORSVIgQwv3FOI0713Rqf4YrYyczit30vhKa9ZOvXM54Y+woQSmuyVk/04IPoxKd0Jx8BzOaSYEUq/BmkTcwtGO1llCDPJo5KuBpMSYKqK6CjU3cyH8w8nucafSqFNtGjTIn/oNPbj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(30864003)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wKeXSXNwyO+IX8Fq3zmYRftElL+EbUDKC/HB5P79zL3uUHYvBIK4aP9fsELe?=
 =?us-ascii?Q?TdVxf5riUwq1+Vk4HD0899YQFbOxUZchI8zBpiXjSLoy5vD/9ppCx9cV2PjG?=
 =?us-ascii?Q?ZiN56Ye/8V71LLB2yTsG0+lDF4Fa7XmXG0Nq8CBt7ySv0OuJUL97m3M1uO7c?=
 =?us-ascii?Q?UoKyCY2xPareAU5SAALiezNR7XxP12ESvwM7o3rqCWMBSF5jv34UfHplh5YK?=
 =?us-ascii?Q?Zk8Df8xTwtvD/B8qdEfL0JJbASx61lictNBaJOnF6fAUp3m1ILvZn1Y+oEk6?=
 =?us-ascii?Q?rqrh0jrjGvHnMWA270pJkv4+pWspSsiAua6rtNjck/zYFzjBgIQBIPopDVpZ?=
 =?us-ascii?Q?5xv5auG8Hxt7wK9xZAja+9PxrNpZBbDQSWeqkPCeS2YW4W7VnbuDQi3GNyYp?=
 =?us-ascii?Q?D8Q38KomAkJs0csuVvQDxcnrfkstRWusILY24sXKNQJKh+YO4b7VUl4LE00M?=
 =?us-ascii?Q?ks2jo6uNrY/K+UVCZdF812jRcwgZSKLG9zqytBopiq4NtumCRoO6x16tg2V0?=
 =?us-ascii?Q?nsrKhGQEzaK0kaZvXbh8B1tu1uN1booSDRDxCRjIZGCK4I8MVAcwT3623acR?=
 =?us-ascii?Q?CMHogKWOFheMrOsqh+vaNo30EKGtsvPhyOUcrIKIzQ/fQhNnerb/R46WROWg?=
 =?us-ascii?Q?6lI8gmphs9WfWSK8YpfOpQPeBIPENDi//WWxOqGF8WL1SXdcAfownFR6Fj85?=
 =?us-ascii?Q?sh/l+8kcu8upd5h92vFAKJViHSyHvlHcln9k5YbUJ92IWOu/zNYIhOsn/sWI?=
 =?us-ascii?Q?85WcP/AxY/GQ6b0AQNzbqkwtOwNeQrmYVHbbtAKFw0fhx5GKE/Q3dHfapqpH?=
 =?us-ascii?Q?30NkefDOZh+ky/uf2hjKniatIV+DrHSZJYe4cDDlEsVVDnqiWoNS6yIhNe/q?=
 =?us-ascii?Q?F9OkzhNgNFpsmDLKlAOdr/6BISoMjGsOd7hAqK0awCP8auOA8TQk2Ctk7U1U?=
 =?us-ascii?Q?7TgBhMF4Y3XGspRzvJDy8AwvD5m6rZ1UjhIiDiMF1VYvfNrb70O6BpUF70jR?=
 =?us-ascii?Q?DflQMNmzZmHRrodyrrHOSX/5RKlcEr2KZ2/RyoAHpNAqvUrNA0OEjucKYkF2?=
 =?us-ascii?Q?p6/Dqn+JNxNnLgzyD//Q19zvIwop2P7qY0X8cSG6nCvFeZpoxO3/xoaEzQiY?=
 =?us-ascii?Q?worlzzDV4kJBJAEISKLzZ6wEfKY6NiRJfFSyCYPxyYK392rVZJs1EhzK33Se?=
 =?us-ascii?Q?MLkChSRi/9Z8kqFWsL7TwnMgT6hx9pVRa6nvNEgjHI4O1ZEGxS9pE1UD3pBG?=
 =?us-ascii?Q?2n2suE8FQJXTOB08euG9WQz5OM4WGWxic/KgzAaDcS8eUGVx257Vr35T9hYC?=
 =?us-ascii?Q?iaNATR/bVNAp8mFevEtCVfdQRXhOPH3NGh63RaVbEkmcBKAkiNDlyM8RN1JN?=
 =?us-ascii?Q?bwH0Bu++jxYnaN5KbPmbm50WdRYAssFv4TahROwXom0siamCh7lOwRGOE6s1?=
 =?us-ascii?Q?PlTQTLUVw4nYQDmSyJ44grwCWE0rk1OOtvzJfnIUmNfah1/LTjX3itE34qxT?=
 =?us-ascii?Q?ihFHw140ihVjEZS7bQQ5R78AOne7vyXtQFOrWADEfFnxUTdc/ayRswyq2cdl?=
 =?us-ascii?Q?SUKW0L0vtLiW3a4Ml7BD4LxSGW9u88M50nV1tUbu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f0862e-d1d3-4051-ec03-08dba3213899
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:28.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R3SXt8lrOm2dPjVOJ27TjNJdguFg7YHdI+NJpJCu+jX7qpfCspu6iUEubr68vNJxzTkcBYZIDR/EjHLwoG9zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/nvme/host/tcp.c | 227 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 218 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 553efba788fb..4d530448584f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -21,6 +21,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -46,6 +50,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
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
@@ -119,6 +133,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -146,6 +161,18 @@ struct nvme_tcp_queue {
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
 
@@ -188,6 +215,12 @@ struct nvme_tcp_ctrl {
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
@@ -291,6 +324,136 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
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
+				     ctrl->ctrl.opts->tls);
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
@@ -733,6 +896,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1806,6 +1972,15 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
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
@@ -1848,19 +2023,53 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
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
+		if (!ctrl->ddp_netdev) {
+			dev_info_ratelimited(nctrl->device, "netdev not found\n");
+			goto done;
+		}
+		if (nvme_tcp_ddp_query_limits(ctrl))
+			nvme_tcp_ddp_apply_limits(ctrl);
+		else {
+			dev_put(ctrl->ddp_netdev);
+			ctrl->ddp_netdev = NULL;
+		}
+#endif
 	}
+
+done:
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


