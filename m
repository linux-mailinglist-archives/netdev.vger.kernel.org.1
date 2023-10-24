Return-Path: <netdev+bounces-43854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DDB7D5063
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1A0B21029
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDD3273F6;
	Tue, 24 Oct 2023 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d3oBw5AL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303D273E8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:55:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A812D79
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOhQXkWqjyjvFkISuvMKvz35Tfw8WRQYHA9NtZz6UX4xZg4If8p/RX/yIDgwMGHrVlE1dlqrTQmETiZurIVvq6LyzTqSqVj+7KcKGMiVt/cS68a3Aj44FsMVFHuwWXdhjbCqWPrOguIQ/+q5o6AfTtzPQnf/rkcxHAMukSZzBt7Nef1H7qOyvvasFf0VdMorN3GGph7KAnCbAP+jSn09aiBxs0o7GzJrrw3tqtmWvEjdiUyw0vS2kwNufAtZJQ05DtQ1v29IcHgskGNnssXaBYaI6U8wrC6XwbCHksviey1JBtPM/lgehMJUiFZuIqAG0JW59pFhUrrSKyWYqPqyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljsmDkfnuvEsij/0xKBBVMwZA8Q7hwdwEX10rcLzXMM=;
 b=lra7twhvkUP85fB0f/wcoRwSTl34K8ptGCRJgU2/J6ipFgqtlqs/z5+pSUKRHelPLnw6xfeVg0mX6lTjjsPMl0ljmESDnRGtjANQ8a7gmIkcs0/o/sx19ZX2Tpc5dEShLxfTs5l9T2N8Jy80kKIOHHnfGE6PV4SVoPOX/gVhEKk3aU69dCWvgijLKhGo1vPLa51JOtAecPUGoB2said6qEh16iYdx5RMOnDwyljF2g2WleyFsDgyFWiyFpTZhPFdCim8W8pr63TAxEPvH/wEYlFLZTVzaP2C42sLWbH3+M2r0S6QVgjQuokUf597Q5wBtL3J19jFtjd+QbVjID3RNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljsmDkfnuvEsij/0xKBBVMwZA8Q7hwdwEX10rcLzXMM=;
 b=d3oBw5ALuwq/G5kKXmNw3JJGVIDpnWDRSPKL/At2Y1fCVsK3FksRAbdPSZRk/22bDNdZ4KZTkGGRIj/2Sv1RY6/Cewf4oygSrX0uQJEK8vfDgLkQGsviZWJ1ktvOAj9PQHQOFpSA/v2XP1XdKF6Nc6Zg9pFxRQNWWzLdf6Wb4oN/OMV3KSiU3I1Lkps48/EPWK3fJv4ydj3mN3kjAxAX7GgfZbWsmpd/oH2w7GyUfW8bRVDRIl8hngq+vI87SP9ZMxbauR1BKS8eiAViQD/j7OIXaSqjIAMy2wu1HikzutL7GxZCB4QZVoeuPGiaNqp4Re3EKkTqd8rSVy+rcrIRSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:55:31 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:55:31 +0000
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
Subject: [PATCH v17 06/20] nvme-tcp: Add DDP data-path
Date: Tue, 24 Oct 2023 12:54:31 +0000
Message-Id: <20231024125445.2632-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c97a5dc-a771-4c3b-aa14-08dbd4908102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sWuw9zhRUwA3Wrsdg3XbeearvZ7BrQuxKLbdCdT9db3UrxwY4Z+4sw1lFax4M4YM8GA6sKnBvBTorpsmOeWC0ZVcqNFduV60YduKj8JU10Hz25KLogIPAxLvxeK+yaG6NUY6qs4oX646cv4FeWYk/pU1M/ybuMaxd3PB2GmBmFqai0aPVgBpsTmxGGapO78miQ8V6RvCG26nyanPOXhT96HyMXy/9HVuTeW5frFu/1Pf2UAR3MQtC52CsYBfX1lvXej/y6RgP9AIqMimZz0u2tJVqrQMO8GNLD7mHtULvDtK+9x/Cy6a1tcfPr4ZhSZbCO0/EPi5r5ArGSdn6a1sGpwjCXpSjA3wCnu1K4xiZffTXJSqym2O/VWDjmG1gRjLCHmwspWbEnbCmpDGHWoiDQ6PNDEvTmAwrtNZSL06XN6PVYIkP5JnvL6EnjkQGaXlWY8OmO6CCGH32irBVRHJywj+0ZTy7QxTjjLRrb1+oyKPpKmvypdvQjVpLMnwddTkJu48ZM0iVykp0cuaFctgUJLx78E5V6iIscSb5d7Q6sd7V2ORSpguOATVcfWx00Tt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(107886003)(2616005)(6512007)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1h9Vt4ql9f5YCSWa9ax9UZCLN+86BbcFX8TIFBPa5No/tIPjPQ+1f+6XOWg?=
 =?us-ascii?Q?mfC5dyZBE0S08tm1ZDmvylg3XpR1PtRAYzQ6Guv0Z+98fHRJAy0YVw+BNIkj?=
 =?us-ascii?Q?O+I14RswspsXceiCEXqi4ujrU/VQfNLlPc8A95AEPU976S/4fAwvjsclE9NW?=
 =?us-ascii?Q?tv5XlkGP4rIBmuyvpGh3TBHpsYYurb0Su+BIKJhyKh4wpvCZTnMAyww/iQsi?=
 =?us-ascii?Q?MeeZifvaQLEWJ4557yiUlsgp22EmWYqP9pospU6nNfFgZwr8NKJgGSXrnLDL?=
 =?us-ascii?Q?L2ixxwVxjRjIBHOvXlp0Q5P7uP1RX6Nbu/anFMalgbJVr4QZ+NE9OYTYcs7E?=
 =?us-ascii?Q?TZjdobRdR3N0CzpXEWPjERavJ/Gi0Dzbq6k8QLKRtCmQ2aBplWXQMQorUFhp?=
 =?us-ascii?Q?4xfGElEWDsw2LIntBPTk5b0/wHoE2zDCjstKyzIFEdVBuPcCZ6el7YYAKoj1?=
 =?us-ascii?Q?CsqD8dtJVeb94i2FQJPfs8nG4edHLX7DnHbpaRS+FhmDp61+l4nch7WLXgEn?=
 =?us-ascii?Q?kwbZLsJlPxFAmsZTzvnjNf5mc1amtGM/hFZvB6rh85q3gcRpkQeiZg8r3rUg?=
 =?us-ascii?Q?Pn0gUx6W+mLa0y47/1fIX9A55ixFOVU2/2yiQlMYKr0aagO30jbiJBVi4eWc?=
 =?us-ascii?Q?ppzfjkHwxTXuV2iLijeBuRJO0S7S5QSGGZBwjUVVoUf09vxDyCBkB6fk9Kit?=
 =?us-ascii?Q?El96qNJpMpCp/1VzqbeWBZWhUr9lmjAPyS4W/6QUTR4mm5gj0KoUyLegz8ly?=
 =?us-ascii?Q?QH9Luq+8+c+IsYXr9x1hKVWCYMeAxuKkWw1HVYtt7CWzM3drsZ4rjMhtEFhp?=
 =?us-ascii?Q?24j1UyysixZutdChSg3HN3iHjhIALRQXsXNwFTQ4G7lvO9hN+URqhAddBSjl?=
 =?us-ascii?Q?WvMk/hoPIMgohoD9g8YQiloz90bttlgLq21QJ9qQVH5DPTi3dh1ldcCbG8Qv?=
 =?us-ascii?Q?Rnn476jdTdtBK3fh3ct8OmbRdGDo50B2lcFNf26FrQJVXWBBxIe7cd57mP90?=
 =?us-ascii?Q?540EbREQfzeXCZfFi0OVEHHcrcuMnodoqHiL17vDFtB88vbadXG1OGanJfHb?=
 =?us-ascii?Q?9jl2t77mfRbXK3i3l4GtBtUU8k6LoAnLooFY40me6V0AAPcTbtvB8ffZZKPM?=
 =?us-ascii?Q?bsm7d8i3PoBC+f+Rc33iUPllp3ZPGCDR2v9aO67JD0JVGw+V1U/9U6ldL/Ql?=
 =?us-ascii?Q?ktzrXolH8gmHjXNWk2L32ZY/CjwSPDsuA6OYAKPDH+aTzCq7mQNyPyhtjyG0?=
 =?us-ascii?Q?hy6s3MzKwBouDFFUI4dENPcyxAPD03kV6x+e1LqGzqwRnyexe7YWYrxcTy4i?=
 =?us-ascii?Q?PSldq8p2/9tAgMUUblriZsWZ1sWOpRAcwbUcH7LLuT+Urms2Clq7yIhlWEZn?=
 =?us-ascii?Q?lLelAzI103cGRtINXUyujcoDbmMcw97q5/FVKbi2RCydCQpKM/+Of2r3z3yb?=
 =?us-ascii?Q?0si8xwvyldWvC0d4sfIHGQZbqvMxCdnKA+b0clsn18MPcBIWOOoE0fU4bB0c?=
 =?us-ascii?Q?9OoBLRwA4LxjfeJGyE9MB1SDY0Ubc7n5DopS1l1UCtPYFmVDHDFoy12l7++q?=
 =?us-ascii?Q?SFxna4pT9bgtbe0icL046/9dGaLa5ZizzqQ12nOf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c97a5dc-a771-4c3b-aa14-08dbd4908102
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:55:30.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62iYTGtFzt0PdK5EFm87VnRscN4SLHxpRXOwrnqW6gdPKihjolPALo8Y1w1H/JbeNLgvslm1pnMPLhEaJqT19Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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
index 387093cb0ca6..8ad03670eeb5 100644
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
@@ -336,10 +343,72 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
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


