Return-Path: <netdev+bounces-17237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A52750E35
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E70E1C2119A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BE32151A;
	Wed, 12 Jul 2023 16:17:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E59214F4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:17:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10141FD6
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwxw65e39R6o1fR0d4RLac6qTb48nVsLI9AXWpnbfG8ZvjbM1f//nQeC5E1gv2PY22hTRbK5QqHb4I0HIBsfl2UFNrC/eSGYJlOb3r/+lZ3rQS98ns6poOg76Un5I88XpBae0VlJKkpudCZalgVnpzCJ/XHBM+tvrs1VMfHrMspEMNjfCas80UadvGRHhFq5qBxwNut4UoiVN6H9UnK8z0n5cGHbhgXRgsFRN/aJmIm32/ARRVogpTv4PKyLakvnAJTbahm0k8XR5XpVYHZeYcsNdu2KyYh5q2RAWWI5H2J6ysxR4+KofaBgpx8QTcz+qhl0daDHafuRGE1TQpq2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky8EZ6qkVzWc1AQxdW0p4TcH09+mb5OshYVrxVSEyJs=;
 b=WnYEFEsFxFWB/l6y7yFeHJCRXikBoCnWMOvGlacfc2LKfXwlosNJqtMONpXtnUlJgO1nQO2rMu+df4p7xqKlqrqqzRPEkCum6D5Lvepq8V22EH9YO4FJnZQDjizEagMAHbbIV42hzo7/fioRTI0NVHXwmOMgEsoDqNrz1YvCqvkMZ5Jsp/srxpGIfN3m+ldc1roSbT/9aQ8KpSc1kV8tqzJEnttzbTOXr8W8cTkKuNwELmS4QMykZbl4NlO9qR0nPwpLp2wTfaFrEZxu5zXE+aAv6Ed3w09lbeR/2ceRgMCXkainprWQCe/csNNkiQ76+hWUMLdC9WMXmOhbHwYPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky8EZ6qkVzWc1AQxdW0p4TcH09+mb5OshYVrxVSEyJs=;
 b=fQYDeWanWwGeu016ysYdNaU0EYPHeP+asqgutaYpwWL+vJ+FGebXsqA9xpmSLhqskTS+JtsHEBY4krDE6oGWuxp7WaY9qD5Ni1bvZfpTeSTwUMDwk7mkbsf7KyQ+Lnx4hkn6n3Ld9fKAWojDhujRhS2wD2kvMXCpf7nUON8c0Ngl2Uw/XWWEWMvnFafmEkZLqtn8DzdNuEnE/ppAMiwkilsf27ciIv1lpJlEvbQlmvQzDMEzxR7IUZoZccgrBeS5n/pw0gU5Bbhc6dEpTDJxPmk3oWkOOqLiy6iMWTrtigetXaC5Ia1TPK8p+FDVJvYrEKIswYmpHNh5c7MK2Y5uXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:17:11 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:17:11 +0000
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
Subject: [PATCH v12 08/26] nvme-tcp: Add DDP data-path
Date: Wed, 12 Jul 2023 16:14:55 +0000
Message-Id: <20230712161513.134860-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd89ae2-1fdb-4e80-a00f-08db82f372a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hum+Ru3DFrlxHTqz45i2nwquMeQsS7Ks/aOCt/5VtauDTY4zim0A3vg3k5DOD6r9KOraKZw1D7Q+l9m72STP/Pe6K8ytxagB9xXiyDpcAT+vhbio27YA4QC2G7zsiWViYVlg64iPg/JGOOTIk3Oxye5tvfPDpED2+jQxJYuktjd33cqp2m5UIVHg7YeHyfg2w299ZNb9TQS7qsU8tyVl5fNFOkrJkhhCvp6d6JrHcvH6mbOuJLn6wj6kSHEQUSnrGDQD0ZZxXiiUkg1fWmaR2C7gAZeyy3ypObyhMswbs9BQvYiEMGfhdolsDTqsqda5QsZ6Ro0GQgxW9gWSjD5tWz33KoBjio6fNXmg4e94FsTVOv8nv8BLyWKcu75memWqFqHMdAPIBPnX/nlTKuAWssBeuB/88qYJIi3UKFI1AeRTAnZZ+vJZs5Bbg5Lt57nlw5bEBM7UKi596LoRAuBn2RbjEZAJzFMddbmWv6ca3AOhlepV0y39Om0TxJk5n1Puy5bcBl2KTSZSCkgqYoZ3D5SD/IhPLb+3An6x37etfg9iljAfx6IiQB2fvisVI7w9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wJ250WuYUCf+YIUuSJmVmZzIVL/uVAYa4MAk5CyoBMqg3/H/wUoPrhPohf9J?=
 =?us-ascii?Q?w2nT0pw3HDOEFaaqUgf4MLoQQ6vQu/KViPuy12AAlSttmiMjbz7hO/ajwyko?=
 =?us-ascii?Q?gy/CI0SFye1nyk2agKyBdC0SH6a9MVme73LoSvexjY4u1JrYGUiRt1mVmDdU?=
 =?us-ascii?Q?myOZiRyjVc6i+skIOahEhpmrQnzWvqzhZQc0n5hxelEhLYFazPw42gCWOI8H?=
 =?us-ascii?Q?+pVEKRS7c53RHlwmI3/DrV96n4LXzIcFzATy0QgQhic70SPi342B6Az0aaKf?=
 =?us-ascii?Q?tGpWz4El0YbSOTxGaaTPibTs8L79w54DcMwg3bmlsIa57ErcdmhxeLuu4OaJ?=
 =?us-ascii?Q?Eb8VBvv0o1PK5PPy/lwq8n7vaFVfidlDeDPKXSEgD4PmVNmPStej4AEqn9M+?=
 =?us-ascii?Q?xRpKkVF0n7O/K/L31XpwGTjlc4/9dlH+PR+/sq3uo//uWZIqqNtq0jrhV480?=
 =?us-ascii?Q?5iyX6rGPPMv4lCiO2qIIpRJCYRXlczxPhHy7Fa+E3bxs4BdWSywBNWkR+Akr?=
 =?us-ascii?Q?p9sGJWXMy44go8hPHQ7ABhAvjrkQQg1YZtSxbMUQ+DSMhXHBqESW+ztOM6ao?=
 =?us-ascii?Q?+943VoAXoqH4YZVcOWaKbEzXfYsMJ+PvKh86vHB6f1E5jU04ZDnkRPA0A7rT?=
 =?us-ascii?Q?vTRGqVQr89eU+oIeSNDdEaDr0Hxuu8DbYx1qyHZotlgt8YZAf3ipiuOqQ/Ue?=
 =?us-ascii?Q?qJCJ0uidMXu+HfzeU2eX9GTG8Iq4C848uV22gLGZ5oBkvZ4NpchzKuSg6gjU?=
 =?us-ascii?Q?R+osXyfZ81Eu8DoR1plTEyjr7jzoExmFDO5XHBhwHifSqIGLA4DuR0tZZxWc?=
 =?us-ascii?Q?ix2Lxe/vAIy3paCcwX9Z1c+Ccm7Fh+mkCQmiFum7IISO4bS8/IPU0rliQkar?=
 =?us-ascii?Q?rYZQtbID3kIWHtDfcVCRnElnW6Qe4i74GsK/A6HXzKV1KtV6cGzSHNhwV4YT?=
 =?us-ascii?Q?xKmRNLWcm+AxXazKwsZSUbcRAW5FsXXwHxxwFHvJZOzdK8XRzvcfprLCi0MQ?=
 =?us-ascii?Q?VpUs4v+qDGkJ+YPURd6WFbm+uUWJLJcYLTtEUyB3ksqi3iN44SeKbrfvm5hB?=
 =?us-ascii?Q?an7h3IsPyGIHopWtbS0muMQh587/eEqoVB1yriCZgHOJNfLnutWgM/CAGGsg?=
 =?us-ascii?Q?to+nXD65arKTPyEAGPgbuwU8eJdgfzD1Gr66pGwi+TwK8smfaA0+hHg4GXhj?=
 =?us-ascii?Q?RdHf1S0wFK6mUXDgJKhRweMy9EHJzPcKb6CEY42Nj8IDH85fFE7Ihlh2+WsD?=
 =?us-ascii?Q?x7SFBeyFcX7E4TjzGnaqSYzvrCaXXWtK1iJbzcym6NPKqN7fA4YNlDIwN5JK?=
 =?us-ascii?Q?oMKSdr97/1W2vDUMPOjEZLg4LTtjA8Q2RetWJNbvz9vcJDinNPkts2gQFdWQ?=
 =?us-ascii?Q?JvkDZcli8tuku/CkO169TutG5mADXEs+NgYNQi9zOWqOnXMvrJTMcG5Ohlsd?=
 =?us-ascii?Q?heo11Wot7pWBq9fWCxYLfY0vXYFWKmVOdFzXu+0/jZeEGNgOPLwuf2R+F1Nd?=
 =?us-ascii?Q?G682S3QbQNQbX9/KE10TSBUXDcpy1tCv8teijZVJmV9D8gBig379CMjP1YLa?=
 =?us-ascii?Q?D3TnXK9qHQ9AN4qZezC8ZgS5KjvZ4wRGTcZqffs8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd89ae2-1fdb-4e80-a00f-08db82f372a5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:17:11.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+FON8kaessT57CCeok3cdXLZDEuWl4bFyafq0dMpf9xIMOvq7GzwTZKM9Zj6Mbcyf6PyD+4Xj9RXIbsbkJoRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Boris Pismenny <borisp@nvidia.com>

Introduce the NVMe-TCP DDP data-path offload.
Using this interface, the NIC hardware will scatter TCP payload directly
to the BIO pages according to the command_id in the PDU.
To maintain the correctness of the network stack, the driver is expected
to construct SKBs that point to the BIO pages.

The data-path interface contains two routines: setup/teardown.
The setup provides the mapping from command_id to the request buffers,
while the teardown removes this mapping.

For efficiency, we introduce an asynchronous nvme completion, which is
split between NVMe-TCP and the NIC driver as follows:
NVMe-TCP performs the specific completion, while NIC driver performs the
generic mq_blk completion.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 121 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7d3b0ac65c03..6057cd424a19 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -116,6 +116,13 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+#ifdef CONFIG_ULP_DDP
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+	__le16			ddp_status;
+	union nvme_result	result;
+#endif
 };
 
 enum nvme_tcp_queue_flags {
@@ -354,11 +361,75 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
 	return false;
 }
 
+static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request *rq)
+{
+	int ret;
+
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		return -ENOMEM;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+	return 0;
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, queue->sock->sk,
+						  &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->ddp_status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue, u16 command_id,
+			      struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->offloading_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
+
+	if (rq_data_dir(rq) != READ ||
+	    queue->ctrl->offload_io_threshold > blk_rq_payload_bytes(rq))
+		return 0;
+
+	req->ddp.command_id = command_id;
+	ret = nvme_tcp_req_map_ddp_sg(req, rq);
+	if (ret)
+		return -ENOMEM;
+
+	ret = netdev->netdev_ops->ulp_ddp_ops->setup(netdev, queue->sock->sk,
+						     &req->ddp);
+	if (ret) {
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+		return ret;
+	}
+
+	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
+	req->offloaded = true;
+	return 0;
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct net_device *netdev = queue->ctrl->offloading_netdev;
@@ -491,6 +562,12 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
 	return false;
 }
 
+static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue, u16 command_id,
+			      struct request *rq)
+{
+	return 0;
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	return -EOPNOTSUPP;
@@ -778,6 +855,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+#ifdef CONFIG_ULP_DDP
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (req->offloaded) {
+		req->ddp_status = status;
+		req->result = result;
+		nvme_tcp_teardown_ddp(req->queue, rq);
+		return;
+	}
+#endif
+
+	if (!nvme_try_complete_req(rq, status, result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -797,10 +894,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
-	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, req->status, cqe->result,
+				  cqe->command_id);
 	queue->nr_cqe++;
-
 	return 0;
 }
 
@@ -998,10 +1094,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
+				  pdu->command_id);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -1308,6 +1407,15 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		msg.msg_flags |= MSG_EOR;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
+		ret = nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id,
+					 blk_mq_rq_from_pdu(req));
+		WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
+			  nvme_tcp_queue_id(queue),
+			  pdu->cmd.common.command_id,
+			  ret);
+	}
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2739,6 +2847,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
-- 
2.34.1


