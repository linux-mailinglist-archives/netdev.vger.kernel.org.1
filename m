Return-Path: <netdev+bounces-17236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0103750E33
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D60281A6D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F342151D;
	Wed, 12 Jul 2023 16:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0502151A
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:17:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CAF210C
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNvwWkSWk/JBwDeN3zi5k1Ma/MHpb3HUCLZKLXAzKBeeRJXL5R9VoCMDsWLlKUa0BpeYqgb0w/2/4Es2HiwClxbJTKtMG0QfIyiy1pvXkRmzXbLkj34QuMA31G8wFYzrugFgThwn+S3sXY/Z56QZlHTgKO1MSEaw6JnbQA/GZrKtTSIuyinfqjaPfsbCnPv3uMievoz3AdJD11rSqvRQsDUze3IAOWLwpk2LiG4yqbnkRM9sfU8sZ8hx2r99dsf2e/1vaNEs16PVCRWZUM1XhO9+PDtIuy896W5MFRsEWtvWEASxKQKj9s95fOazrr6XbjOmwzwx75qBwzaH1UK1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g96EH88skumRSoyTiZmnvfzUPrVp9fYEYIlwk/Mit54=;
 b=YgGk/CaeG1cY34YEipQL7EeugGhzeZfICXJHMbn7BPh9d/yNtSbRNfhjGueKKcCmg7rpK4R3LXxdr17bFWHaLE5ar1lLPyTzNyZ29/fvG3jCZwG62UBKr8hf0BtsrWdrHguWCFA345yd8D+Sf15/qjYCCMi1bLRI6eimFBwo3Dksy0uYiKzxE3vr4UBmFeOGAtEiQVm/vwcMIUPDolCjKprCqrJt8PC2uID5Uv6sVFetwyeR6XCltdbM8imfj1pOYMb5Rq7P6Iu/EMFuHj9zuecr27UXenV973U8+lRgZYJ+E3slxv/k5JeesI4Lav6UVY8YZOOVSvhIxNYtk6Uxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g96EH88skumRSoyTiZmnvfzUPrVp9fYEYIlwk/Mit54=;
 b=CB7jJ1wjzPHuNJ/KMazuauEX7nF0P1cE+IAAHa1lu2+R3g2IM6h5XjdMDPVECCvlPDF4zS8Mt6xXAVzI3OhHbWfpRs1Ttrcutk5W1K5WmuSS1dSpD470vDcQ3evPwokNN8qh3LIMxUdfu73mFOMU18T34N8ssak0pXL8GmzCvqfO1uR4pLndGIeKbvBif6sMn61yQNog6j3w3G0F8fQP/82Kt3m5nhcjvTK5cBZ2lWvq49A+pBikDOMp+O7sU0Ur2q8S5hzgx8shWLFs0GwIFKlEANuU/Mz4WbLsnnQhktEsMUlzK6AuWmWv90ekOaq57tKyKSwEafmklCQGrpBUig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:17:05 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:17:05 +0000
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
Subject: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Date: Wed, 12 Jul 2023 16:14:54 +0000
Message-Id: <20230712161513.134860-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cd03f4-c207-45f4-838f-08db82f36eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+dbsT0hfTiNofQ9e+4NWNvrsJKsEbtOO+ph1T8jj22sd6HFgluBTZcc7hhbniM26wluIqyXaN3SY84jKf3a5VpB/UpO44UbG5fPMGVkUu0Ccagtf4nW/OVVlxkjMdgV0q+6ScMaxEqBPEXKu3EYqMq5J6ONtzsoVTf8j7wVebs14IrYlDoDndULFtRVMDWBOX/gLniv1O/D/fg//HJalPgppHy+nmdCkPYsghrvMzLA6YuURbjQW/DxDTp2/B5OiIAr6AXPVbFV2HNj17Z/2vx1yp6Dp6OMJgt5gK27wIVTgtzKkDB3tWUTlVazFLyeSfE5LXADdZobg5O/dpcdbbnuRmToG2Bv6rGQJ+GNAWh9g45WUzcWIAPOi7+ThRWypnms0em7S/lLW8wfjCN0IWT8Ceb5sGIKQCcEg8Z7jjYAnQE8nJb87hfwc4v4g6zKIEBmhEowJ5FwJhZXGN64JbnL9cdpIBN0azlcb4lEgzYqMKZRMgFg2DUUMLQsa5Db1LD0aC4Vy8cIHROuRYu4dvyXWH706FjbEGiqX3ccylBzAf5sCZMdWiw1eOjrEd1tY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(30864003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wHoSrBv2zWzQvAJRYbN7hDr0WB/8ea0b6ya0O67nTQzcigViLT+N2AfRLlvb?=
 =?us-ascii?Q?+vqAIhOdUv42L3MhdRYfC4kKv5Yt1thk6iGgsqGcr/jgIR6M7wWWe50mwhef?=
 =?us-ascii?Q?pqPC8kkYqSXuT1juNXkjarMgYX8CLj9HEcNCPl1GFLGrIuXZObelXr//1XTl?=
 =?us-ascii?Q?pyXCq5PYADVxtSze8Jkd0EYE0rpTPh4BNpRkV+gzoFXjyX+yvDEmWa4v9lCS?=
 =?us-ascii?Q?8KMfdWAzLamJu7ZvSMP+NqYhXux2HVte+UeGkckqoDAXz7Z0X+78dJT7UA+5?=
 =?us-ascii?Q?RAMR9bCWj5YT3rdwSOF2lEYN0GzIGaSY+7wh8WqfnqUkPRGVCkDYBFjmLtrb?=
 =?us-ascii?Q?GqwJmdMs7Sa+QTTE9BjOL0hanVXoTyckFKwXorIMdYqINUQoO4/T/JIGm7ZW?=
 =?us-ascii?Q?Qzfn69WhQdssjPM1eWZygsiZ8MFX2ceKeIjs3br9KNRq+rturMjEUgdWnk5B?=
 =?us-ascii?Q?5wSgrgH0rNKIrOoWhZVUBOx6m8TaSEvezOOXub8NIeqW6D2cjyzsyqZZAn3u?=
 =?us-ascii?Q?4uqm2C4nQOUTOtE3Wy6lvih2c6/8B75k3+FUGdDVy1HKHw75picEN03Tx4oj?=
 =?us-ascii?Q?HoyYJFzgB/rJadA1Gd9EpxyWQ4yTs/uKQeP/7rOebV4Z9mtEVJuaKl25bp7D?=
 =?us-ascii?Q?FmnJ9P5yP3ZUGgL8MA0GyTHc+Ih9vCMGjNtMUVHyaclUQLUbNwM8rc12pINa?=
 =?us-ascii?Q?2vBcwNB2HJqPvw4/V110QoHsr/v6meLuuBS/fO9iVg7279bLCFI0xmQ7LsFi?=
 =?us-ascii?Q?D25TjvFroIolE023yYo7RcUilKl1YuQ/q6/c/Rk2VLoTBJIFE31DbGGCyohD?=
 =?us-ascii?Q?+YeNnuhwV32BNwG4BO9n8TPwt2snMAT1DglcSD+G1UjgRzFwCKyn2e5EsMN7?=
 =?us-ascii?Q?Wni1arN0+OTTg45I2XQBOeSvBPRkHSkGAQeFYfbX1K35qMi7hfAHcRDml42I?=
 =?us-ascii?Q?sg0UU/l/o4hwENOSA/OM9ZhBrvkOXyNZG6oReqrXlas1auwIiRGs2ZpQhe6E?=
 =?us-ascii?Q?cUBO4p1O/Z9zWw9UBGRgc4C6n0cjA/AYyA1zwSD7yJHG7jFzqV8INHWtog6z?=
 =?us-ascii?Q?+ypK3YAyVUs4maUrUqGjy3OcncM0cK0OFv3NOy0oj3txx1uGBDFC1g14fbGd?=
 =?us-ascii?Q?FkC/CigfCofvnQq7IBZUotAVImWmqctXDssBzD/8Dls1stAuh22M7tmKLAFh?=
 =?us-ascii?Q?9gnJ64yh9QG1jgMwAs/keNmYu7FjkE+GO45LlLnMhJh5oTQXruO6Qc8Yp8yf?=
 =?us-ascii?Q?Rq37oyMZwV5QvwoqUjODk0bZfnU2hcVVYdtCreXxSl50BFpaobiPcUbkBqwK?=
 =?us-ascii?Q?basrMAVuXEcfoxKvkaYSd0qvLJuNytg3uxlci6PInhBmgXJVe39i1mp2SHn3?=
 =?us-ascii?Q?7OBtt0JVmNnEAcjvqEPxJdmKboJPsEDe188QucFq5t4WPiHfap/+MAzD7ZOi?=
 =?us-ascii?Q?ozOxbNASLOjHyiYeH84DrG6GC+Ujg9Q+hvtHBIHmQz+XZ3BKxDDTD53jqFpp?=
 =?us-ascii?Q?paZhkGx8rvg5FcnTdbSQ6/RpLzeqroB0kvghdvd8XHx2JOsZ+Dt/u23k61Fa?=
 =?us-ascii?Q?x+uhrOFcmO/UjwVTApVmL7oomm6Q8XM32tH8w73f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cd03f4-c207-45f4-838f-08db82f36eee
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:17:05.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAB/tvwn3e5iLSGMxyFL/rkW5jQDtZU3/eO7k4lGnInmXZygtiVA4NFtgBPzQjm4beyCQPyxRsNUx+kTcP5olw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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
 drivers/nvme/host/tcp.c | 272 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 263 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4a8b32bd5257..7d3b0ac65c03 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,6 +20,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -118,6 +122,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFF_DDP	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -145,6 +150,19 @@ struct nvme_tcp_queue {
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
+	struct ulp_ddp_limits	ddp_limits;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -187,6 +205,9 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*offloading_netdev;
+	u32			offload_io_threshold;
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -290,6 +311,204 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static bool nvme_tcp_ddp_query_limits(struct net_device *netdev,
+				      struct nvme_tcp_queue *queue)
+{
+	int ret;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops->limits)
+		return false;
+
+	queue->ddp_limits.type = ULP_DDP_NVME;
+	ret = netdev->netdev_ops->ulp_ddp_ops->limits(netdev, &queue->ddp_limits);
+	if (ret == -EOPNOTSUPP) {
+		return false;
+	} else if (ret) {
+		WARN_ONCE(ret, "ddp limits failed (ret=%d)", ret);
+		return false;
+	}
+
+	dev_dbg_ratelimited(queue->ctrl->ctrl.device,
+			    "netdev %s offload limits: max_ddp_sgl_len %d\n",
+			    netdev->name, queue->ddp_limits.max_ddp_sgl_len);
+
+	return true;
+}
+
+static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
+						struct nvme_tcp_queue *queue)
+{
+	if (!netdev || !queue)
+		return false;
+
+	/* If we cannot query the netdev limitations, do not offload */
+	if (!nvme_tcp_ddp_query_limits(netdev, queue))
+		return false;
+
+	/* If netdev supports nvme-tcp ddp offload, we can offload */
+	if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
+		return true;
+
+	return false;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
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
+	config.nvmeotcp.io_cpu = queue->io_cpu;
+
+	/* Socket ops keep a netdev reference. It is put in
+	 * nvme_tcp_unoffload_socket().  This ref is dropped on
+	 * NETDEV_GOING_DOWN events to allow the device to go down
+	 */
+	dev_hold(netdev);
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev,
+						      queue->sock->sk,
+						      &config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+
+	if (!netdev) {
+		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
+		return;
+	}
+
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, queue->sock->sk);
+
+	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
+	dev_put(netdev); /* held by offload_socket */
+}
+
+static void nvme_tcp_offload_apply_limits(struct nvme_tcp_queue *queue,
+					  struct net_device *netdev)
+{
+	queue->ctrl->offloading_netdev = netdev;
+	queue->ctrl->ctrl.max_segments = queue->ddp_limits.max_ddp_sgl_len;
+	queue->ctrl->ctrl.max_hw_sectors =
+		queue->ddp_limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
+	queue->ctrl->offload_io_threshold = queue->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	queue->ctrl->ctrl.quirks |=
+		queue->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
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
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
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
+		netdev->netdev_ops->ulp_ddp_ops->resync(netdev,
+							queue->sock->sk,
+							pdu_seq);
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
+static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
+						struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return -EOPNOTSUPP;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_offload_apply_limits(struct nvme_tcp_queue *queue,
+					  struct net_device *netdev)
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
@@ -732,6 +951,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1795,6 +2017,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1831,25 +2055,55 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[idx];
+	struct net_device *netdev;
 	int ret;
 
 	queue->rd_enabled = true;
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+		if (ret)
+			goto err;
+
+		netdev = queue->ctrl->offloading_netdev;
+		if (is_netdev_ulp_offload_active(netdev, queue)) {
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
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
+		netdev = get_netdev_for_sock(queue->sock->sk);
+		if (!netdev) {
+			dev_info_ratelimited(ctrl->ctrl.device, "netdev not found\n");
+			ctrl->offloading_netdev = NULL;
+			goto done;
+		}
+		if (is_netdev_ulp_offload_active(netdev, queue))
+			nvme_tcp_offload_apply_limits(queue, netdev);
+		/*
+		 * release the device as no offload context is
+		 * established yet.
+		 */
+		dev_put(netdev);
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


