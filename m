Return-Path: <netdev+bounces-59768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A481C038
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B801F24CC6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C676DC0;
	Thu, 21 Dec 2023 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HwLzp6jr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DC7762C
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO8SpIdbggvg+xAehpoh6rjm6lfLHJ8l9LeF9fCNevm70V6NbqYu4KWk2D7rUjGmr1PUotOrVsIF15xlcZWNgwCIKRfaaBuah92/fBXnCTDpPWcAKDRWY5ZSjd81fVcJVfZz8foczU8dSx/o1MNWY2U9FV/DKiiOyupazmdBTBn9tgu3G55mJhZHLc72JuCstQyfIR+Q1PDy4HP0xixr3waWgJFWya8h7M8lwtR/wbiQpEmHZ7cC3g9d9Hsd3delceLGaSq0gQvP4i8IXWYa7IEMGEORgejy4bnpZnO+5ccyxT8V8d0+yUsfsIkU/ndEj1Mxb3Nv985rkp37Bw7InQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GOEd5v+KnrQZ2n36YinE8eqG1INtRsRCy5/N+TQmY4=;
 b=FLd/xftmiGwmb9yQXlZSjc5Up87Ljip4dD+iumNlUbjOLbyIJDmAuiNEpCbwQ2LQC/0JJwCCPHPM+uk4P53DUhFAXmiJWojKKdERR0hwRn5nki6Ua88P1pIb1uKQQ6OYH4AZQFqMTAZH+7RAVY8j5+YzBo3U8/X9fplnz4b0CDatTk3/a2HL/zg+sL61mVl0hKlYSRKq5umCDubhhelESjkQDKPKrRz95pEyIOZac+v7DYU4xYAoGrewlR9KwRm/PTnEQYobQ2MrrA1VfzmgujTpeB9e0ANeI7X6g5C9Zn2aDGeiprXQPfXK0SsB1l069AP9DDwAzTCmhavOqYzFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GOEd5v+KnrQZ2n36YinE8eqG1INtRsRCy5/N+TQmY4=;
 b=HwLzp6jrZVGdq6yNcu8uab22Z32nGt9FiqE8vTEn1HPlGyXd+MDxv//SxR+jasMODUA2G2ee5iReeDSXu7/PbJpA/145xwgGlUYu1xj1EmSVhE4YdDgKQUE/YH5CH+OtSUychz5TiCiXTak+wfFdBMexGdB6Q22eUH98M3gQqF4zqhXs1r5hivu2Aizo1HfjJaankL726vKalxcRD0kFlIje/bov4rc75aeoS+eLL1Bflns0bHBW66ZSpyG9KhMV7J5Ixwvet6//AVUraQ4N8TR9qx0V32ryVhSX3FJ7DaVehtqLboNV0wivPpz5I1UgtdQgE4dXD8sjGhpbLcMqkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:34:34 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:34 +0000
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
Subject: [PATCH v22 06/20] nvme-tcp: Add DDP data-path
Date: Thu, 21 Dec 2023 21:33:44 +0000
Message-Id: <20231221213358.105704-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0107.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a5d352-c496-4f5e-d538-08dc026c9ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tVWTLmwo2XJaLLTaN/q9r6lRK2e0m6NlFR1Od6nwL7nv+r9Nac8r6RNG+7JFJ7y4JeSMjBRgjyrbzGZ1SVrN3C968CalvljZrIPybA9RTGwoLIQ/IFArzY7X1t85vSc+LqLWri566zuvpl7javdGDBK2iZLk2HBr9tWkCiVswB5VcvrkYFIuxbTPLzBYEBaMyg31ocW/tnxVLDqzFhcoojPo5fIZ1V8XXgiH8l/KImgJqbgoCTmdFgIrv3kb0raASlPVDyXuXrZ/UB2EiKTB6ii5v88XdhSqqHI9UXB76W95lZxzaG83F4ZqxC2iSm66z7ldHb8wNsPdg1Rs9eLYo5112ttybBRnTl5mufgT08pDEYSk2kupK2HnRytnAGZvRi/gO8ZsY1O0UvuBeSDpnf7G0RfALbPL9QQnbk3RGllGhyeb0CU3SDA/c+lCJ1pXTwj8ytXDuz4UzlV41C7lQeS8trsO3IG9LR0xD31ev2zWl552IuLWPlRcweBxQpwZ8Aipaa5w1L8ugfhsY4a0871o7tf5ZFfV4x9k+HphdbY/+XXvA8K/013sA6tkHz3Av3Bh5+KFjFh2evTSPLyeOS6Lnr5tcyOjw+G3uLA70PQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(6666004)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDB5svY6PN+xzJsXt+JLCfgWnMrfIw29mqQJzl2cT0JYUCu3+oClCsv/91h/?=
 =?us-ascii?Q?Nmr+Og91K5edH+egHZ3GWP4ZtiqwPgpMozxM5ZPbpc6xL3H/daGCTg/RTROC?=
 =?us-ascii?Q?7Xbf/wjAivylXGkdRHlGBq6KJmRnePfxdK1UlgzyTw0Tics+y76k1AfIsHM8?=
 =?us-ascii?Q?4W3n9k0EvgycTVpNsoHCj2UWc9vTvj0HHn5HAO2NVDjwKFTeait7BfsEFBO6?=
 =?us-ascii?Q?PObM21Iad5D+YKkkQ/pZ1x4fuUygiKSRZmUrmQaxm18MR/AGjvJQcib0rHCo?=
 =?us-ascii?Q?dbrFYYad1u54tX+5A9+D/LykPpUwGxLTpSunI5bTvct9t3p9i56XWvZQ6GWt?=
 =?us-ascii?Q?juln/bbNWUvsFBWAKPzZf7HS2BON9FNsM4PKywBiQazAnQBEtF6UwhR8tY1Z?=
 =?us-ascii?Q?YI/xmIM9jye2dtY69rspUqjPrbewo++jbT4/UdPGa10q1uNe8MDhIwV+iZZJ?=
 =?us-ascii?Q?rWkd8e0qfMZjym5QkJaGz2YkhgWqnG3aurvSIOGmfHuNnbeUTjHxxWlVig/Q?=
 =?us-ascii?Q?PavPKXVRisc0Qa1mvHlBdvu072LV6a8bJSOB8T4/a8t2LN9N5NoHol/O/32v?=
 =?us-ascii?Q?noghmsa5ALyIbKRkcycCrTV9yV9jvZI97LcNZgYB8NCeCJLs+V9imO4a//m8?=
 =?us-ascii?Q?AJmcM7x4mp29JdNla0dJ6w5dvakQLXRU2eWVVEWRe76ZG2XNmDoaTIeGGGyO?=
 =?us-ascii?Q?zo57aZIbiPzgcQeq38n6jpjfM9OAKVxk51rTkjPCyB/LAx7EZaqYWHbIwYi7?=
 =?us-ascii?Q?DgXQgux3NRE/3eCZX9Gt6VWOgpquSF+I5ldai25ld5zJewUt3DPcVonaNvI4?=
 =?us-ascii?Q?0WeGlzHru5eVDK4cC02gz+w8JRb/G4xUpITHBXND1Ir/uHXKYUxcsiUNj4Rn?=
 =?us-ascii?Q?m81pk0jC6q2fkqzFOg3ANM9xhVOfM4KCivQQnZAkLnH9ryEpX+yPezh+3ov/?=
 =?us-ascii?Q?LPGc0PSgSjEVGBVDpYus71NHtqd4b8R9FFrejOPR5oUglVd2IoNRSO315tPZ?=
 =?us-ascii?Q?Npmg7eWDTlZbwiqBnh0lRpSSFwetoYv4v4bxR1Wk+YaYr6bn8pidP8QMkBoh?=
 =?us-ascii?Q?EjKeLiKKI/slv7jFxLaMX129nOPVOG1ohuDR+VPXa+yMEf5hIoNzypER+jce?=
 =?us-ascii?Q?ZkTwj8tLlIbdyWJzI06Ch8uGudpCGFkEEkeyqbzOiBlSakD6swHTeNMbcgOB?=
 =?us-ascii?Q?WlkNB4eAIEMZHncRfYAchVAqNHePGUTvrJUdfHvLFFrl4BXjKKx7ZWDline1?=
 =?us-ascii?Q?YkE4L+bJQ2rrw+++OKxMYuesm/3ZDpI5eVUMmpvAH+yG//p/S0R5kzPNj8Tj?=
 =?us-ascii?Q?6ln2O09h9MjCmp5dJmwro2e1tuKKUYcj0lo8G+i9XkuNV6Qk1ldHYSndzRPI?=
 =?us-ascii?Q?5mbOUJa9qVtroF/QH3GN7k42/xldT+yCrtuvEjDgzwOm2R6WsLNCZKAFhASQ?=
 =?us-ascii?Q?PA89ht/VukkB+Yl1XxuZ8ge+PXZ6zWXb/Sq1uj9gw9IDWkxMefAtebPlu++x?=
 =?us-ascii?Q?ubiaAssVcSoPD0LjT09K3gnpHWxHHfxyzl8xFgQnbvKpZj5F4jpbCkLz/5eB?=
 =?us-ascii?Q?fBljLm11Dbj/3S+MBShBYtFAL6Q2f0gklPVSyAva?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a5d352-c496-4f5e-d538-08dc026c9ffc
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:34.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14nk83ls47J+7JFI/0ILn83qCuC62xLsogXHzL1SRTjUnc0dvWgHCRuu4xB9V/SC+vsgtBLJRUfIB3vtw+gTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

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
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 125 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ddfc7cf6c83b..420b8be309a4 100644
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
@@ -333,6 +342,11 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 
 #ifdef CONFIG_ULP_DDP
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return req->offloaded;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -366,10 +380,72 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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
@@ -473,6 +549,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
+{
+	return false;
+}
+
 static struct net_device *
 nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 {
@@ -490,6 +571,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
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
@@ -765,6 +854,24 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
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
@@ -784,10 +891,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -985,10 +1091,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -2728,6 +2837,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_ULP_DDP
+	req->offloaded = false;
+#endif
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2766,6 +2878,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 	}
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, rq);
+
 	return 0;
 }
 
-- 
2.34.1


