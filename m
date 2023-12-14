Return-Path: <netdev+bounces-57437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F9813188
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCB728337C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167956750;
	Thu, 14 Dec 2023 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R1Rf45FX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C7F11D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:27:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyTwJGhKRghSIfQuiF/D2J0FyZRpDEfkaCqwfFvVUAJW+eAGJJ1MSqOJ+2viJGTvHEYUCbrRj0pYGr7TsXl64bOLWJOZcaZzd61kVhD79VKH1GxUNl+TJpYWHm9gP1u9BPbXtdbNvQzhQOxxy9d8GdP7daPWZRawwMLdVhab1u55Hs4DimLNdecedN3u5jCeOMJ/YzMWKUMNVao1Bm1HbssyX0wQM4Yn41Cvfm4pidN6/FTVl/GZFti2j/mjiyRO+3iMKoUSNsPWbtDPaO7Bnq+MbbhZ0dNTpJRY5VhY8t9hnVQOuACB9yri0Tc0o5A9p6iUNCNlkhbdQ2tHNJmPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9lt3Ba11ThnV/prDSeJRhzhxa/vdb9mj9zjkoj30S4=;
 b=kbQp3e6/N4JYylKMNZ0s4zLRD0X6IJcx9v24gVh3Vf0SaKiHsT6dJlleQnAPQyepFr4x6jyoOJFE36zXimrCqSA7sUZ2gfO5iR99n4MyV8xOiv2zkV35mtfki8uK7IggW4ZWhAymq/wZh7qTSJp89HA3lQhYCvlZZrrx3lNYmK2TWE5YDCpU5jN+LvmOEoJ1dKm3RDVp5StJr59cQXJ6c7RsW+vk8eiotOhN064W930axJ91WxJiHsqEEOIbfvmcdqdyauWc6ByrLLlDPmLD/ElczcV4W1HS3s+yQ5p8Kn59epfyIi6nvzzzPRGmyVtJdb9hRhYS0WsafOR1iqsQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9lt3Ba11ThnV/prDSeJRhzhxa/vdb9mj9zjkoj30S4=;
 b=R1Rf45FXDgsOtVdDqiOpQasE2kKIaOqWRcyytUe1EK2Tpmo3CuGvb6PeoTBYg/VSdy3MjOvJ5MPZcl8vxLdW28WJhdN3Mn1LsDmFNMKB2/AHgkKVntopYChMxvwuKbtPpQ0M8NyKPbdp7b/3xK24y4gLDYRxKUGv62GPVVhFYRBU1QQ7xf3peHyYbWPPEsy3DCym4GgaF7bv9UteEhbNDH+wym2cVISM8MDfStnsLc1IQq+VYwWGLVIfb6Q6H/i7KgxwDehVByCILN+Zoii4/tRI+Jm17h2fxGIP1w5VE+zYEJ0HdgobjZ0ZMl+k0jgkQwL2qLliWpfndzbUmAl8Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:06 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:06 +0000
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
Subject: [PATCH v21 06/20] nvme-tcp: Add DDP data-path
Date: Thu, 14 Dec 2023 13:26:09 +0000
Message-Id: <20231214132623.119227-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 2212da2a-93cd-4f44-2e38-08dbfca85dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Tt/Gi3wpahfKIG/77cK1QMrROu2JjehSiXSrvDZZI01KqOs4lTXqwovpvhXU661MS92hHur23yGPbWx1E9tuZNu93Rv0LFH6LmYVrGkyPj3fLXrCYQ3yncnx8srYr2PN+mE/ifBdWdAlSUFGae5aKCLKK9pBAOG+b4eDmOm5V2LEACkZo/bcL4Ac5Nc6xYILG7H5joSqlXS9s0no8J8FJjfjdsvWaUy/z/XAV8xFlrGsTsvV4mEpXbX8W4Mb/6+zJv8FBi6pieY8g5LKitls/j14+kzqY9ybOfWYVM3hFHI+xxyIZsUaoGoThH2W9DMiJ4+7FgCTMvjMeTXRoB7Q0wntcrbb9jP4HMNBin5Q5dw4VIzjG3uRPoMiTFT+NIQOD/LTeShfjhAbw9CnmUpIX/S4+QADpLIVAqYoCkpDsEdhmcisnKPuQB9KnWtAnlBDZm3xgGnLEqzNc/dmG1pcGDLNXgHnTf/XvUfBRykjdz3HUE/9vkfogCuiJttY4seqWRXtZeeIvpmBjMLaFQm1cyIMNtBgUDYo18Qj1VGPBpxGdilJbmg0nmq4ZkUAUzu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(2906002)(38100700002)(36756003)(41300700001)(86362001)(2616005)(4326008)(8676002)(8936002)(6512007)(6486002)(478600001)(83380400001)(66476007)(66556008)(316002)(66946007)(6506007)(5660300002)(1076003)(107886003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DvBhUNCT9C4wFoa1UkMiffAw5EXcti/IIBr2RdK++5tNv8fJxAHd9ZxRv8OR?=
 =?us-ascii?Q?kH9nEBSGGTc2C6f2XcxliRCgpReNDdlZ6MK0bKHY3HfVkASCypU29abkFK9U?=
 =?us-ascii?Q?a/Yl5U3eqLGu5jBtRl8bhq9RnsLVJ2gzL0NPnUlhn6BF20RtK1cOrd6wIrLC?=
 =?us-ascii?Q?GBCr1g/+fw2Vje4BSda0HqqJxFen32QiG1nW3pFKQC38lQchTDiPpOzuurqy?=
 =?us-ascii?Q?ZLhpg0Iv4gH3QT2mVhHBpy+FLQflFdV0lECEQs2xq7IDckUZTsybvG3Egcih?=
 =?us-ascii?Q?qEHxZ51HxDy9V9S6nz5mYmVfyBZAzs6a/XpMUrWBbN9aw4jx7M2H+qHjryIF?=
 =?us-ascii?Q?kCtO/lp+FLTLH4KHvlpE2I1VI+SRGfZgYs343LauzvAx1YrF1CNHQG0rLoWL?=
 =?us-ascii?Q?nCKyFI6m3wwgYZT7CKZSJjM7ElSo9IeYPSqr49YwHoLjbAnC0FbzRrFN8jgR?=
 =?us-ascii?Q?d4ixnZqfd0YraaKGKwL36IIwvFvJtYYGYlM9kDT71zmNF/G37htCXRh8QawT?=
 =?us-ascii?Q?FiHwc9TagoqKB0qECzX0O6TtUsgciYm1Z954tvWWwl0/ex12aa2Z5hKWRA1F?=
 =?us-ascii?Q?EYqNt3J9slVniy+Cz+cE+8NwditBQJPkzXF8Yev9Pu72nejK0D9+lf76kohA?=
 =?us-ascii?Q?aDfl63gQHirY1AWL1efSKErg2n7xPqH1rQlTyALN1W6DJsqBMyaS20dNTJ8c?=
 =?us-ascii?Q?y1nIClozleJn/5XDbYLusPjZA72e8xzsZeZmb3A3QREhRM+uC/Rhpaf/mU5M?=
 =?us-ascii?Q?MIWNpX/zfOGQmYTsx5AcAmp2agZIgcMDpaTdcIuifzztWCRGlUDlAmcOtE/E?=
 =?us-ascii?Q?zNZWJ8cmQzn4FApi27hQYR4PyzPKL0VzzHttqv4FjJNA/aGG6XUJzsBm9A0w?=
 =?us-ascii?Q?DYjiaorIpvK6SqIedUnOsID3M3rq0r6DWRmciNfG5ZOXteBTJrrapeI0pzuy?=
 =?us-ascii?Q?qfUs+jqKy32gGRP2gGw4dtbkwdIEBMLHhl2PAb1c1wf2LP3nQu03e8e+ok5x?=
 =?us-ascii?Q?ZlgBwYI8NNFLtnBWBtyoB2t5nAqvZSp9Wc51YI2MZAOb/DqZr+jIXHopChcQ?=
 =?us-ascii?Q?rZw3Sm5oeRMDr95Evopi78pEZIc932JrV0qH3VHxorpeLJpcrrD9kBSt1JZI?=
 =?us-ascii?Q?XmeS3xniDt4DJOCD//O+xvHBYETdURn8JoO2n2HB9bmi9ozjntTI73/w1lvo?=
 =?us-ascii?Q?t/uJBfZ88/ClmJ0Fa9bWDP/7LyvxB+Aw6RG5PW1feHlWxnD5V5J8hapJ2peX?=
 =?us-ascii?Q?K6TMSrAfFO+IZR3zeVoyRaUT0tOUSixf6jXbbeGSNHXppavr5W7yhD/0DeSB?=
 =?us-ascii?Q?OIyAfMzNzwtIyJQybGZJoOJ0TBWdXJji3BK2ECG0A8bsta/UquNqXkFvcnPy?=
 =?us-ascii?Q?Ws0TpbF2ag2LS4PTOeNDKU2kaF+gvO30x4EQF98JMyFxhUlaIQoT4GJWtOwS?=
 =?us-ascii?Q?3mqW0UpuIAzRbW89Z2ivYXVIiIaNQQwZzZ28SjeCYBlNj7aM4B8L7ch+JGcJ?=
 =?us-ascii?Q?FNj8kcwDh0DmvE96zOtzJlNIZWCe5jndwlyHRPJbnEckb+iSFYpoJvl9zkue?=
 =?us-ascii?Q?Kqqwsp6bDoAkP/hXGwHNV4+K+KWj0zSI1ZU1utAE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2212da2a-93cd-4f44-2e38-08dbfca85dee
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:06.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBDbqpK0P/0vOXMFhgDC760PZIfjJrCk23gB/EsO++lwqgA/2o//SCcBuHC5Z6N5YWsrHHYSsreWw6cdsEB7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

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
 drivers/nvme/host/tcp.c | 125 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 52b129401c78..09ffa8ba7e72 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -120,6 +120,10 @@ struct nvme_tcp_request {
 	struct llist_node	lentry;
 	__le32			ddgst;
 
+	/* ddp async completion */
+	__le16			nvme_status;
+	union nvme_result	result;
+
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
 
@@ -127,6 +131,11 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+#ifdef CONFIG_ULP_DDP
+	bool			offloaded;
+	struct ulp_ddp_io	ddp;
+#endif
 };
 
 enum nvme_tcp_queue_flags {
@@ -332,6 +341,11 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
 #ifdef CONFIG_ULP_DDP
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return req->offloaded;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -365,10 +379,72 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 }
 
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
 	.resync_request		= nvme_tcp_resync_request,
+	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
 };
 
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	ulp_ddp_teardown(netdev, queue->sock->sk, &req->ddp, rq);
+	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+}
+
+static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
+{
+	struct request *rq = ddp_ctx;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (!nvme_try_complete_req(rq, req->nvme_status, req->result))
+		nvme_complete_rq(rq);
+}
+
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
+
+	if (rq_data_dir(rq) != READ ||
+	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
+		return;
+
+	/*
+	 * DDP offload is best-effort, errors are ignored.
+	 */
+
+	req->ddp.command_id = nvme_cid(rq);
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		goto err;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+
+	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
+	if (ret) {
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+		goto err;
+	}
+
+	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
+	req->offloaded = true;
+
+	return;
+err:
+	WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
+		  nvme_tcp_queue_id(queue),
+		  nvme_cid(rq),
+		  ret);
+}
+
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
@@ -472,6 +548,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -489,6 +570,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
+static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
+				  struct request *rq)
+{}
+
 static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
@@ -764,6 +853,24 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static void nvme_tcp_complete_request(struct request *rq,
+				      __le16 status,
+				      union nvme_result result,
+				      __u16 command_id)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (nvme_tcp_is_ddp_offloaded(req)) {
+		req->nvme_status = status;
+		req->result = result;
+		nvme_tcp_teardown_ddp(req->queue, rq);
+		return;
+	}
+
+	if (!nvme_try_complete_req(rq, status, result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -783,10 +890,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -984,10 +1090,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -2727,6 +2836,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2765,6 +2877,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


