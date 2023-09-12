Return-Path: <netdev+bounces-33136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EF679CCC0
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7207D1C20D2B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F901798E;
	Tue, 12 Sep 2023 10:00:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30AABE50
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:00:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF7819BB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKfRmT0Jo+qjTuTue1DSY01V2IxJhuesx+Qwy6NqcXh35cTYkAXy1caKFV69qI63zKt802/CBcBAzpn55v9blKxpmUUW8M9VxeXpaZPU30pafVtXiiD3D+BSoslJ0pcWRx7Zzgv4O4tklVeZ4NreVJSwU/kXEZuDXPy/tVl8HjVKNtYHkTa+YuPWsMj85O9KEU9XoLl/7piBw/OkWduBgEG7Mve7NperQMnhLFeG+1+XNtMuINqcZ0mEdWPhQHQOtmSBFcGD8FcCn2nve0Co7fBvIuVSJQu3YPIaewu9ElIOvNcSsUP69kNOVx6jFdr/CUbBFS9xttvhTWGHiVWWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRFyHG3Gcp/ozfzrx+Og4F6a0BDySVwR6/w9kq7T+Ug=;
 b=S0DPVxSgSE2RVhwzwyJtgdOqVNGDZGD74JiKEw3S5VBHXkTHApu0ZTBRBV1qBba/WkUh+9pK+pnP+zchEXTuly4oHiD4Mq3lIzKky/eXoGKsBz4ni7DRrkCYa5y62z0JDuFkFLVHW0Oi2MbwNfv8DAlfnSSDX1XGPvx6BPpP9BKtYYYt+s2ZKgKcXnfap+qi4SK+YPoyV1Qj2q0vtnIT0yq/ttnhk6nwzICM+5OSC+YPneO4QSLMQuaQKsVKAKubNPyBFbrFb0TOKDFAFSf5YiKT0NSDqDzuOsoItj3DNXNoBFavIS5U5XZ9clrZirAZBEXxxrlGcbU/9uIBHkarFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRFyHG3Gcp/ozfzrx+Og4F6a0BDySVwR6/w9kq7T+Ug=;
 b=t/yTewGzARQRkmkSSkTgrUQGM73SIRtTjwEp9iX/IPk9MlJMHWmo6lXuAEu6H7/aTstGGnk2q2D9xiENQnR5T0f+xu/PeVegHHeJza6gU/YXxt8/Ju5RBCKl1lbRviGAsBX63q4E5UzM0boGyq5+h2oRlOVNrZ3By7LV505omD/QiJZCGDuTilB6uBnXhFomKyimW+HcIYpFAZmVbMm97rwGZhjmuqIXtE6BqGzeTk9prVh4MUAUhqOk4vylVXW4DWAa9Oa7c4mBhqsumYyYWCHpv9zz1MqH0GHDAyHRGBK7XKXCRHRL6tb5ms/8G1Qi/ZgbUInM5oPjUD7AK7tb4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 10:00:46 +0000
Received: from DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb]) by DS7PR12MB6069.namprd12.prod.outlook.com
 ([fe80::8ce3:c3f6:fc3a:addb%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:00:46 +0000
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
Subject: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
Date: Tue, 12 Sep 2023 09:59:35 +0000
Message-Id: <20230912095949.5474-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912095949.5474-1-aaptel@nvidia.com>
References: <20230912095949.5474-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 8409e8e9-276a-42d7-501d-08dbb3772256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ba2QT2msR6tUaXnyqlw6I+aD1+keyuI17m+1Za650sZ314Y5U8k4QFGZx7z6B/vn/RELYptgQhSlUSQrRj4S8iI4XZ4SvxpThbACfbSi3VdipuS1l4nr3meX8Scc3tOYoKXvFU7oomTlAyksmnpZXuVqKXPEYcKPtabmJPEsa3/c+ChFCMQkmuSsjewdeQqIAx7ItkaAyqrw1td7YqQhYzCODHKmyxs2WiBy7xdH+RMtyVRignw6f1bAqD9L6ZNkED6eSYmkcuh3sHVT68TQa9yYPHzJ+bx6DcGxElJGuELjYxtyjKhOIj4XMDH/PM3MPCdIybDgt5uzePqFMMvaDg2T1FTu4VWgxLJQwjzARQBdNI7yvIyqXjDaYEuaPAKCALUcD4c7tg4INs+0Sc/1LryQWsYmEbgf689CK/qTWU3PfPrG6cnRlS8fZP5UYmFwiOcqMcixkffu3D0eUD8nk8hT4/LRMglLj0Uz7mh8Zmwa+SP7z+k1orE+bwYD31RTpykT/RFMfhE5gqgWf92bxXrkyKtzTqIa6r7Y+JLraD58Y/JbJMXk5szpH04MT2D9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(1076003)(26005)(107886003)(86362001)(83380400001)(2616005)(6486002)(6506007)(2906002)(6666004)(7416002)(6512007)(38100700002)(36756003)(478600001)(4326008)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bU5AAnFOhk+xwB8WQKs+MJ2zKFc5MyV6dXwhEWLTJGhEyd5ed1PIEjuRApmo?=
 =?us-ascii?Q?QjCAbcA37OqYzolhvE+I8eAXbSQXU5I4iSifq/v2oDpm08dzZr3TTTANy7+0?=
 =?us-ascii?Q?nZoD2UQ/s8u2hy9CPrPCrSsf6iuY8a/lOaM76B8F/C54FDznK5V8MR5ploe8?=
 =?us-ascii?Q?d3A1v871Nu4GkKqMd5B5Kf52KGZe75hi2+XPb/ombdn+gXefNoU5gh3Cw/1Y?=
 =?us-ascii?Q?xxjpmap5//alOrXrTZQ7xmylCt5X/yoiJi33DGgqYzW5cw618Rfm8mMGcWZM?=
 =?us-ascii?Q?8x4Ymqv18Tp0icRi0ce6c0/r0jBTEJSkpWTRN3SutYaUwtenrHCXr22gNHsj?=
 =?us-ascii?Q?o/2tXEe3MLUeEuVZ+NbUkEN5iJQ6po9kRrUA/p6gHfX/hhrOIAfGTiaaB+zP?=
 =?us-ascii?Q?op4oYfx/RSGhc6b3axEixWdih5x27PGlKBFniKaISO1xXs+ZIG+dbKNY8Jck?=
 =?us-ascii?Q?xs9/JqhyTJBZH6y862Pp3RLzuxTMi2lKGyHYyiGMLJnmVcJe6OP1crI00LY8?=
 =?us-ascii?Q?QAINU4VUvIp+uHbnGo/1rD30Meqdsd8NYPMoWYWhvsJuDJzdklzsA5xWg56O?=
 =?us-ascii?Q?yUesoPo78FanJ+M99pPqcveb8lxG8ZV0pv6Zy/8j13HhJgJpMFMGD/6sO8yi?=
 =?us-ascii?Q?7kkWz/bi7Y4SWLPzFplHqUM0wto/Kkt/awCGKb6HKPrF0JFgqblBbKqf7SJq?=
 =?us-ascii?Q?GKVArkb1lJm9jU9jEFMIQyRiWjEdPISaaC4h28SFWE+GAjwyEXpUOPI5QyIr?=
 =?us-ascii?Q?oQrxtaK+qoag41pNZp7WqvQu8NmFgJ8A+RCkFuKFWnLmF8yX3j4VLs6OqILC?=
 =?us-ascii?Q?CXWAjuHTys81A+EIc3XcU/4SkiGLg+PH2F6APNMsjBq7px5bgluC49DoDuKm?=
 =?us-ascii?Q?SF21KZYNXW0vrozgEuBnCagNHwbF3seAorM3HdDq/y2gvqEV/BVB4mMf1mxv?=
 =?us-ascii?Q?gGHFsRl2ChzP7ioKc/hHEj8ZxiOoO+PcwF9RmV2PQdT3xjoZEs8xHQ/7idIu?=
 =?us-ascii?Q?1LlVmdV7WkRCnC8Zhl1pFgPSaISY/Fq+Fh6eQE7dQwUvswhauqatpuT+t41J?=
 =?us-ascii?Q?PEn1AcEo02JfN518rxKmFVHVeieGcnWhxCk1J3FLb6RWL1yLj2Q4FX0h7c+P?=
 =?us-ascii?Q?gS0xTi+2TcmqeHXh0snrUQdCzQso+pi/QsX9uOgCLKVD5fws+p93fBRThROj?=
 =?us-ascii?Q?W433jB77QFL1hhby1Dl3RaB+Uzdx0Cq7+7Wo76+r8AlBVPlPia0hixkAU0Y4?=
 =?us-ascii?Q?n3ZiDEl2pnkhhqIR7Aii2jXR6Kj7rkWeGAjujktq4FlnzL6KRVRt6CEh66Kq?=
 =?us-ascii?Q?OIG/OhfZbMRE7ig2pv5CT4mI+KIGKYg/3AdM4Kq3FT/gWflX8kZlvlYfE35R?=
 =?us-ascii?Q?dtgz/ltFt0qJ+XClSmuoJTbeN6/jwT/xJwU/vFmhB1HHuVD0sWXg8nJ/qz/i?=
 =?us-ascii?Q?ELjp2LdxZms+gIdrkUjGfbeFhYMifjL8Z0HRXHPWIXd1uBvow24zDaqxduOe?=
 =?us-ascii?Q?KSRplRMnrPbSNj6VmOyiZl2I8jo90eDrOgbLTj99bf524e0QcLYdntAKMJ6S?=
 =?us-ascii?Q?Y4rENiypgfjmhEPbsV+IyW+k0VYo4k6DFu1XcXxZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8409e8e9-276a-42d7-501d-08dbb3772256
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:00:46.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b//OD/TARsIi4QnFSi8phIRZ1BDvLnVs0+E0+QSk8AXkfOIOybCYab4CvRkZCy69Isr+RlEZhIGeFbf6FqiQ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034

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
index f8322a07e27e..48bc8afe272d 100644
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
@@ -319,10 +326,72 @@ static bool nvme_tcp_ddp_query_limits(struct nvme_tcp_ctrl *ctrl)
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
@@ -427,6 +496,10 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			       struct request *rq)
+{}
+
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
@@ -705,6 +778,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
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
@@ -724,10 +817,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -925,10 +1017,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -1235,6 +1330,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		msg.msg_flags |= MSG_EOR;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2541,6 +2639,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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


