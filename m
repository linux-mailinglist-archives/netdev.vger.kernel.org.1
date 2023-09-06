Return-Path: <netdev+bounces-32247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6251793B66
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD228133D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329B883D;
	Wed,  6 Sep 2023 11:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A076126
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:32:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C12419AA
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofuxyn3GHmHi8i6FTdbH35FFBMktITPl0+JD6y+RuzCz2J72gNOkOxVrDDClNAL2UERy5Xo/oxCCLR2CLX3XbAhEduzjBa9BIlOIks4VvYJnbIuPxTnM8dJ+qv5Flj+IfBo34/ygi0c0SFB2bwX48nNztcqktT0DLf6scHFv0K1dTFjQEeDbRPuTBhxJIgVIki25mkpPDfC2m4ZlPvXWd3SHz1kxSG1XzwNf7DIjvGNF5MDrqzXTYjLxWDdh8iOl0M68uK1kdAoEOEu8EaIrD7520tMrB80CAf+ZbwQMPSoh6BfNQLLKIVALFfI/l/mAB/zwqEZ9hDXmjoXcmTTfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWH5MI8Ool4axJYuH2LsMifYS4ir5UYmWfQlg/PEYgU=;
 b=Vv4mZ3z4KWsCdDE8d1K5ZeJuKMHOOnZ/3w/rghTGk27eA/m7q7ophqSWxTJNybw+wNw2qzZShN8jWlOFEs2TnKAvWx08PvhKyhapyVFjAhueAPOEVfD/YTmUOyWvmC9xqQ2PJk9fbMVM5BLtSx1Oltc0Hh8Yr82e/rUvtE35M60uk/OnkZGsywm2Ln/aoNGwFftvYV4u+pFbhLpkI9GGVwp3PNMfgAT0lQqdQSsSfk6cXVlXpy+pQh+5jbMVls8+Wrw6+JaRXqpTW03qPo1jdB0pGcDbG8xenm4b49dyF14vK/hVHxE8NGWpKMukvrFXd6Wj+fQOQstHx8lL7RmcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWH5MI8Ool4axJYuH2LsMifYS4ir5UYmWfQlg/PEYgU=;
 b=kW06nuAE6BXfzNX9Q/Eii1Oj7EgMvvVZ2yyhVBJNgRH+dBmIY1Q6b9f/bGuFg6JzpXOvtasRDbeT1fdD9mV5fzMc8eSVTiVbMk0pdlzfg7zzsdmjvZGxWi4r29GqhP0GVXWA2yCt6Ha493c2RhTlaodDCpzwzxUECc8O2oIoUqrFbT3/jRCGcFHAgFvE4x8Fm3sw+QoJeorofXl/1G4g1zPNF+2k6DSOeeU97d6K+wuArPK6nF9r+y3UI/5J+mc3JaVQwyttxu1aYLTTMShI2lzPCfq6Mj5lmMEiUfg7yTJ44Hm6Y8YMzTzpTs91yg1aaJcchOB9LqPGdYZ+ctSh2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:31:05 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:31:05 +0000
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
Subject: [PATCH v14 05/20] nvme-tcp: Add DDP offload control path
Date: Wed,  6 Sep 2023 11:30:03 +0000
Message-Id: <20230906113018.2856-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906113018.2856-1-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: d69561a6-84c4-4ee5-f243-08dbaeccc1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	80Hx3LRwpbH2Eqeh3b5lBZ3cSSC1RMaAN2yeSoLhhT28wA1ywvrwzFmAszTzsTIAyMxII9a8pLtJO8R5zVm63rTqbikWIyGpaJrSJYSXyZHvNEqT46CUgRnCaK40C432A/X5rbs77+XTAn+eMzN6sUTUmorcqyeL/MT7zVnBPoEuGY13QXtRqe2cB2t9Mpp++QH9fKmder8AT8YEHiv7WZawhMH0An0LsDQGv59LQLQn7j/3izTDjXBfVMAWo2JteMWmVZUFbuCWiE893XEMUw9H/1VxQe3AwrmP57947iVrPd0lA3E7iF+YMnMkpKKGPI2fxO0mjgEdMa1WSsiMjFxYs8vgHssiBUWdRxr+vxiosxV+xDtK6SeaftIPDmO2OzK7QEeeblB6BSTso3nNljttYbP9oZ4UV+B+iW+L8fD0N9qPWt45ItWfIy+6KNW5UmQxDHbVbA9UU0zy+HAm+g0z8VFO5LSgRS/5MCGXM4Dgdnz4HkvwnuNhETf2uPQkXBQrW41EK5tUcENpE2umKAzXGd8s9LuXbkf1TTFx4Mrjx6SivckWV+se2EPOK1g4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(2616005)(1076003)(8936002)(66556008)(316002)(8676002)(66946007)(107886003)(66476007)(4326008)(6486002)(6506007)(6512007)(41300700001)(478600001)(7416002)(26005)(83380400001)(5660300002)(30864003)(2906002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/Mel7z5btXuih/fxxqSEI8lq1ROgknAv8tnB37JqwHqB1lutq3x7eDCEJEH?=
 =?us-ascii?Q?dF4HPm7CousWh7GXWFsiLeqKPl6jYCTxiJToSp9/SnIvhkFUy7csiuCKwd8e?=
 =?us-ascii?Q?J7ja0RxBfoj7UdUJOg3JmtyndPtx9/JYIPBAHzTxFE0Q2+PAeTYlG3VRm/bP?=
 =?us-ascii?Q?j4XBPkErp7pFuYsjNW3mQRuU1Yyq5oRpoZT0tdm5D4yylpuY8dGkAgyJtPTB?=
 =?us-ascii?Q?TDiXCpmQrHKOVYejITlXV9YwOptfnWrieKtbE7PmDPvz2gZYAnaG/5kA+ibG?=
 =?us-ascii?Q?u1avn2bzX2RXGLnvHIai3en3MiRkgxM/WhvCVvAyEojeQLc8Uwf9WNYcwH4J?=
 =?us-ascii?Q?WGJoo0KnBlw2ik6VI0ralcmxwBJxhyerY9gJGmAUwBX0aL9o+5R/gvANu305?=
 =?us-ascii?Q?WAEFQO3Om05mIXtWq7X2CPf6VilPppcosHmEYkiJGlh5/ToXeknN1+H9Ci1e?=
 =?us-ascii?Q?JrAB5fz3d+KmlKmAkHu6nK9TT+2NrHGyDtNxa/VQ5Eh4qeslwyrPFtMNo2Bf?=
 =?us-ascii?Q?qKDEHy5nvi1sGK8maSqSnPFU2I++Y+1RJeWRLXkU5zvFoCA67+FiQKsS9/ao?=
 =?us-ascii?Q?IkW07pIJDn8p2PPa8sULNri4xo2xcRokvk9AFKYBPpgTPrqPB3CUbhOccrko?=
 =?us-ascii?Q?0doOoC36Pm2agAzoN1ivyRwTRkd/EOnJtB7SPJ7fL0L1+mzj+atjHJ6iXLjm?=
 =?us-ascii?Q?HBoNA8qSLQos2xYDN2gnFBdjcTsxf2R1Y/IUF8erwDh2YwB0n1Lon8uNSZiZ?=
 =?us-ascii?Q?49FE1NgnGACGkygbpXbefeiTRuzMkFpkNDOlwiFXeThJL0bducisd4V8IaYc?=
 =?us-ascii?Q?DaSINMMOnz9vEA2rmy1bd1zVreQIlHzBa2/CK7qkUaXvgt8ERChOt7dhdL+K?=
 =?us-ascii?Q?NRDmbdwCdSJIv+O59kY7QmuDBZy1Zc0J+KqdpyDk0Vjbs3Lj3E0wI8uVouZ4?=
 =?us-ascii?Q?GfpVjqB9VdaqTq4O+JQKZGekucg86NQGFknOwD3jz6wE2ChwEiK9Jwzsq3Yn?=
 =?us-ascii?Q?0D2F5nWkP5X6ZHt3UN+RQqmcoj1I8fKPxqHHtuuqXGgdWZH/IX/s7X01SSaN?=
 =?us-ascii?Q?44wG6/mst5/sJZZt8AkV5YBvE5bhHLTg6g9YFk6pLy9DlUWv7AA6yhgUTKkn?=
 =?us-ascii?Q?ulxNWnzd86rW2onXdqixz/GtMBRZhRwlnOr4E/f6bSxti5EM6ikJ/1TWUhu8?=
 =?us-ascii?Q?0+8nyLylIaSB/eYRvrP41WNaW6TD7tkM1RaTOFuH9x98/oGv2Qv+OaaNtuqR?=
 =?us-ascii?Q?TvduSmboDWHg9zToIt1wf80Zd+lvAihKOOa9KMxGVbtR2jtGiRCTXKe0bWZ4?=
 =?us-ascii?Q?iaRUBjx95O6hBcg3HuL9VB4dPELCn/83DfZLsHeyguJA9A6Stspmk9t12LgE?=
 =?us-ascii?Q?LafIgDTxp4/ut+c8FeKSm+hRGz5rcrYx1LtY3TBg0E9Zyp9sB460N4D6hkFX?=
 =?us-ascii?Q?zjvZdZbq4EdmFWYfAdzAnwwsh7M2XCPxvJgxrFA/xNfhRskHvIucv++oH7Kn?=
 =?us-ascii?Q?36rC2mz+MxnWWqBbij6r9rf5S+0zlQS1U1/CksXOtp9KW9Mu2GGwpLc7tBec?=
 =?us-ascii?Q?dlcazMsQ+n08H/SnbLQaf7m/YEvjWypj2mz0avkU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69561a6-84c4-4ee5-f243-08dbaeccc1d3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:31:05.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0qTrbZgrTgdUve6I+h8EVsZsRMUgIHwUVnGpr5HKOWFgt3Z3MSrjvJoyp/nYKkGx97OwHBia2DJQy3VifZXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
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


