Return-Path: <netdev+bounces-36861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E347B2092
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9FB5C282666
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B34CFA5;
	Thu, 28 Sep 2023 15:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245144CFCB
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:10:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0021A1
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giszrx1hzB8VRaZqZOkTM+359ek5IWqPk6BTSPFGUKX3aLt5Jlo6ZXkAPwIttHwbaoCHtMCuDmu9RwarNWoZcdJgKfje+r7WpwJySxIbyFAI9ex92OLVcjGk4rhlMVFrfP0FvjMKgHl3+dKrMjGExefF3VvXa7kH0JQVFM3WydTsBhyKFMnHNweC1/GMER75jpUXoDYdpKyA785KSQ9T/ylWxXkzhRV8Aopb8bB14ih2++RxyFStZZFSJAe/lwetG0w768qbiXW3RRRm3dl2ZGcQorvMaVYrmcqGwrqh0VmXsmMIFfiKhZroVm+ADy0tPoVDYpp9YqkovyLrdoa8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb+JC9muH3kFhCfV/0Ao2pYydNUjg+JOFsILFFJL5sQ=;
 b=PTQek/KElJZYLEhCnLLVirzu2/W++9s7m7EwHYgqkmQI6bjmiUFGoS/s0hj5GXOvvw1PMEoAZeZhTHtS42yKONW2yE1RZunBSIIDcAtnFmkHJdqtPRX25tuo3V88g+seCmhzsvc8lDQoRl/FwfWIv6sPXtc/xgrPcalCyKfRK2CMUGYLrsZN3/4gIL3SHd5Y9taPLNJRQ4J3dEcr+MQ2bSvk0WNAPP6oufp3MWzqgnz5hCAl4iDKPbjvcAoiV77pVTsE+r1/iieQcvmOY2BA4X3LQYyaplvpQTBXXCkUZrN4tWSp8iiFCRrKn08psVhHx7VTfQkknhZ7HrJnyL6iFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb+JC9muH3kFhCfV/0Ao2pYydNUjg+JOFsILFFJL5sQ=;
 b=ElwAyR1WSoiAjLnW3lfSAnzPIs8IDxeV4lenHWt0keZsOxiVHOE8C4TO+yI/HXFds28MEQY0vr34CxK2BhecshEQE+/sRhzk/puDfMdCIFOY37skSKj74kBrs+7Lw8p42P1fITvjmRcXCyK4ISPXGlOEBAYNCtHnJOM0HCSNfHa23OTY08aaqMPMXKFZQ12a6tKc+TRlftSDyBN2DMpHKWjOjrNhTohfRGm6xjzreTLXCAJBAzQtOp5SmfSsjTzrLwUcJ4UEGDTIM4c34G9vtm4JPHCx/7Xb7cRR/vLXtFcRnmiZaLDozqw5glX/Wvh/qFyYb6WqxKIUHcgsgLdeXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 15:10:44 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:44 +0000
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
Subject: [PATCH v16 06/20] nvme-tcp: Add DDP data-path
Date: Thu, 28 Sep 2023 15:09:40 +0000
Message-Id: <20230928150954.1684-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf8f90c-d53e-4fab-ddd1-08dbc035166a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RmBJS6GNsB9OCODPrMZOIpDlbDevGOkhRXCjwUOnnkV5okI34A+ooosWwLUAUKiDiyExRf7gDbNzD+0yV4oKryqjfE8U+dP3e1ihpl2I2jr+mlfmpUXIhOv7gBg8dbxsLnFysy50HqORokOrUldiu3viihDiWoI9y2eITBMA0b04sOyS0Sci43ZWA3n6Epp5DEpc2pUyIXlGF8FcktjZeWsb1YwSrLokMSdOrRlc21JexnIac/LN911EZ1/1byJqk49ywhTZ6Rz7OkH7lZELqeuqlNS0HdYAAi+Epy+WoQISff5c1/CiGobzpWyOWmckcaD9WG6NK3b3fL3iQ8tmyG3f2JX4EeybcqVztm6dhYGfwF/2U41+YclOhsGT/L+cfrTkKtzy8BiDry2a0UlWiGwS0kYNWsG3bwxIW5xaUcJqH8XXnkNBuDInTEXBnvF+rDS9BnxOqzU7b47tt1gdoqM/Eabjk3iI/+X16WQ1gf+WJP8NgqtPbXTgJzcbXfXi33HfxTL1UeDr5Vqh2ToYI+DjTKadZkKtc62aQeF+QBZvTcZhO4r6oxhwY2zrtdBM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(86362001)(107886003)(6512007)(1076003)(2616005)(36756003)(478600001)(6666004)(6486002)(6506007)(38100700002)(83380400001)(26005)(7416002)(8676002)(8936002)(4326008)(5660300002)(66476007)(41300700001)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ekIWLgxWZNiD/Jd4UB/770Wdmz8n7pwuH1nK7j/MciXKMY+cNmBaOmKPdxN0?=
 =?us-ascii?Q?3lO31S4ssyYlpm4Oy3rk4wJ6GI3tQV/Jgk3TCGWg4iMfl6Z+FHIiEdHvRcKp?=
 =?us-ascii?Q?zrhqNUNNITcxC9qjAQoyJrRRL2lFRSqU7JJIHFYTy/jwBvnM6nPg1JnuylXn?=
 =?us-ascii?Q?umgEGlOShRvpGAWRlD0mIVYa8qqLRAfQDp8qBEsucV2DWifwqlhS8E28l6TK?=
 =?us-ascii?Q?yLZuim2spQ0V5oEhjY1k29RKHrFCVZH7yhE5jYCE0unBXuPj9E56wTbsSXns?=
 =?us-ascii?Q?qkJ+wrwWb5byH1NZFKMppzevtqxPm5PRAaHPfZL6wim05eehwos4ckci4/tm?=
 =?us-ascii?Q?p3webJsj2xlQK4id2GgGS7nTj2OziknZPa3V43kcCQToeGuon8Xwrd0oC/64?=
 =?us-ascii?Q?Ep/oOgvbrkF5P2ky3RnXmXZFpFpEfWvyTRAqJYPKdZ4+PL3GFChXzuiNQJsU?=
 =?us-ascii?Q?snMG6twlLUd/ITqB+j76J/4Jt7lWrdXPVBeUBeL9TvpLJEkAPeneXs+Phqj7?=
 =?us-ascii?Q?Zy89GkITO75FIqklplzwycyXl+JKRJopl5MJxKwMFo2xP5PQy6NzQjzzm+9v?=
 =?us-ascii?Q?+60rdG72HWTMyZuidWeqI21AdcqOO12CX0PU9vTRG0e2lXKwhmCuqkqEDeI8?=
 =?us-ascii?Q?YQvlR7gbR5ILF7F41CzQUxisaRB39NkS/qMtvOhHe3PlRKUKmq+jRFZywyJ+?=
 =?us-ascii?Q?PshowBC96APatLnlqeZYvlFeJpzEQByAOcawzo9isIuZcgxscd8Tcmg4Qd4w?=
 =?us-ascii?Q?6SR3/WsXwquSzUVGCw94+esUzSm9ZF/5hny9HRsNamjX0FG7JWIQeroYs+oD?=
 =?us-ascii?Q?+XmX1OsHhcykPrwrvY+AE0XypH6WJwqRB5P6Acx4MYotnaVUMEGXHathe1lL?=
 =?us-ascii?Q?411vS0ynBJ27eXVa8DD1diXWwGvYmNiYWAGl9AEsilcLzSNAhLhz8iEMw4o/?=
 =?us-ascii?Q?LGhJ656OWOUOT1txSugXieZ7rzq3rUJFkIx8UsZfpPTj3QjH5IXxwXNYYc0u?=
 =?us-ascii?Q?AQMPL7v6uGjXmVKduOrNYtg+T8xTIGynxsoT4xw9D4CZ7y7DzAgyoxfal7J8?=
 =?us-ascii?Q?zP9GsWKaalLfYURStxB0JMxnU5EcIzXvpX+HG741lUtVjAY6/S7gXVh7lKJf?=
 =?us-ascii?Q?J0SLXxMPNPbZmosDS2GZn0Z9Wv2vPvAq0TtAXyVPpdIJNOpBmI7CWwMirVFq?=
 =?us-ascii?Q?5tOdigrhQRSwJfqxKKzrHvfD/NN+SN99ewMak9tUxE9cf4cbzKMF983gSgKk?=
 =?us-ascii?Q?U6pxpoN9ePpORcSNkP7wwA/3JTiUAfYd7In/G6Etcgeg/+S38GI2KXRM3v5x?=
 =?us-ascii?Q?sWP2quAiVpXfkoE/mZ22eARbTIkxse/tDtHXBgdffDn9KHMQ7iBognspVbvw?=
 =?us-ascii?Q?+ET3eZ8A7nUPngSQMIMu/dwSDClVcy31fjXcu2ze3cmRJKkNfeF10zAcaaGi?=
 =?us-ascii?Q?e1MHZ6mbI2Pnd4Tjcr/Kblvt5WM47pf5UVu5Dv4tJyqFl/d0uqaYF7UP5Ovk?=
 =?us-ascii?Q?Doo1L86Wd7ymbKhCsRWRmPAHkmIvI5aHnELWliWUjUeZYtK86F6OSOQY3h6D?=
 =?us-ascii?Q?Ejj++4r5Liw7UWqhRNQW55LtN3GgCkb/4ochUJsI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf8f90c-d53e-4fab-ddd1-08dbc035166a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:44.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xen6lJ5zHdU5Wb8eulFFIabO9rsSGpnZDGTLY7CVmgXT/xVI0C+s8eUwIpiCH8GNqegVXDsBGZEX0k9XRG2k7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
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
 drivers/nvme/host/tcp.c | 111 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 604649c29838..655f73dacc09 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -112,6 +112,13 @@ struct nvme_tcp_request {
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
@@ -336,10 +343,72 @@ static struct net_device *nvme_tcp_get_ddp_netdev_with_limits(
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
+	if (!nvme_try_complete_req(rq, req->ddp_status, req->result))
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
@@ -460,6 +529,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
 static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
@@ -735,6 +808,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
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
@@ -754,10 +847,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -955,10 +1047,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -1265,6 +1360,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		msg.msg_flags |= MSG_EOR;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2566,6 +2664,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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


