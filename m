Return-Path: <netdev+bounces-29667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0AE784502
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB35280FBB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8511DA3B;
	Tue, 22 Aug 2023 15:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C951FD0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:05:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD9D1BE
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEIv61nSqVUXzv6WS4jDsbfzGqbhAarccPb7DoXyEssJYNjXeOZl7Fc7h5LGKBLrezicNKJ8dXQVjermAYz6lcoLLGomLseP3+HzxQH5agQmgdxma65Tyns7FJwOjppg0cLbLXISCG5TpzSXHw+QQgU632PA5fx6dp/5n5ywhaJmw+TkZw2q3p1pHqxBMrrWCr9OrPci115UR+NIzMDh9aXs6KI9KRs/Oo07tSmP08mkxszxnyxKyAJgDQ93007ork0nPbj1ceubMAVhoxfLs07DhRp4xdpOSQloYCRNXO2fb92wyCd8jnoaZ2XqzQsgfmGQ7nzAruelPMqeCpepYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+anthLxvE80SkJs+cPSd+Vf8+E2pIUvCd/ZdLArGAw=;
 b=U7QpthqryGf3riUA0ivC+IE7z+mOSyE9hzU4EDvupnWKFDAhu2AM8WgCw8MdTvWtgXYcx2FAdJivjK2ffiXzNydnMS8InCi6HfPBMBgcT3CB2p/NycqfCAxhHD7gwZz5xdLP0cH4g4MIFKzIOUckeRldJE4KoFpsDMJdK8EEYd79skoW4f4g7yvB2cfXpRZ+HWG23xPUZLKx/7bKdsrY9zPB1J8LLI3mMLp8/6x3b9V2/sCjmjhd7Bl1l6DkActOuEVyBxTgVXth/w9QsoElzWyOFcdpx9GoyGJ1x5jFsw5sQsDui1oygAMz234f7Up4z6XslcphMLzwtxL6Yd/C7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+anthLxvE80SkJs+cPSd+Vf8+E2pIUvCd/ZdLArGAw=;
 b=VWMmt4CvWEm6Fldxbk08NLC1CREV5alOgwOwW/J1kgW8d5lhczuvNlNPnhGk9e4Rotqs8spRLRazhOpC8Pjk7D5fc1o16MBrJl7scxGQY1XIOepOSZRevbjok6bcFFnaD6n6gmLRAkwnEKocK72G/toccVK8CSy+mblv85PNxi4LQdp8HOn8wni/jVl0ZlgGquKHxe6E/31DX7uLD+1lReqdTl6vUNQDAHXAqgQNStqSzagXxlXhiSNSwsjEI8hskSBeJC0KoRU/SEHdPMiyyiqc3heShxPQjV/YiEdwlYAxxXLwJ57Ccw5NCarn8gx0en3hfsuXsw/Z7DGFhPnF7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:05:33 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:05:33 +0000
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
Subject: [PATCH v13 08/24] nvme-tcp: Add DDP data-path
Date: Tue, 22 Aug 2023 15:04:09 +0000
Message-Id: <20230822150425.3390-9-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0169eb-3599-4e65-5543-08dba3213b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mP+K0PWsodxfki2qlWQ7Uix/upejW12rA3BsQKNODT84jOUG8f/FLp4dhLUuxCWsGYMT/jihjaCMtgDBkOHyNoqGqyckCCIsfQDUXAMUxwh15NwhZC6F6AWG0CmbdWHEABmhR+L4sgbfCxtW3oPFT2RjVFNBkMpa45faPBfljkbiNuPx04CXfKINVSuwRRBzigfVTqC3vfYeBIXbA2MaI87K3agyhNdaj60WGRuEAaG/0CGJKDk6qeGnaoV8aoYgZYX/vNYnvYPtZifGO+N5GbXGLY9ErWSNJC61RR9E9SAikqqUar+bTR+0DK5h1mLb5zAT1TVrmJd05E2N+D/k2vQSabDXGA4uWOfjYTvXDSGpyzMkdKtPh0J2unYSCBJDDVEBVdVNgHTj/UkrwzY29uOFSj1QfuX16RSso+PACryxQ1TbvihykzfMPWbDwWb7B8iHKfESdgqpp486zSyTLRiEM6LmLqcw8zSCKeP2AW22bgpHHaixo6f40EO+92XqfItGqVfIlVwXe1afW08jxJ1zxHyLp1a3w3Us78ihJheDIwwBb6Z7pVunXShJhR7i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(66556008)(66476007)(6512007)(316002)(2616005)(8676002)(8936002)(4326008)(107886003)(41300700001)(36756003)(1076003)(478600001)(6666004)(66946007)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gKXTR3h2pIrVA5cmEyGXGGDlIx2aNB2E5isBDPkl9hdmlracfDUT2NechiJS?=
 =?us-ascii?Q?MPKke0MSx+GVDOyiet9CGn4+DZ3CuumjaJwiObu2mlimwtmHyfAlhl2kwtgC?=
 =?us-ascii?Q?u2475mMqz7cFeozck4T0KehvxloLw/bL3LKkZ/WOkRW1Mm6pWV4Mg3OlhUTJ?=
 =?us-ascii?Q?vvPk5lDNAQuaIHV7gFo7A366G1sGrJbgrx/2qxCkktRcbVRLPW9hoWcP6FBB?=
 =?us-ascii?Q?OBWDq5yYGOaetZ+KLtmp/JANpFUEAybAqwbF2RI7D4cFeOqGr//+Lv1irrk1?=
 =?us-ascii?Q?8CnuyKoEDqkBlp7VuIImKBcI9unOg2UHIpB6tF+eIO/tkTxxZ//fIIRzONAR?=
 =?us-ascii?Q?pXaj2kIyNesHIcpBdEoxmqNqgLCfdIeZNUmBhpnN8k74FZZt7Bv5lQ/qtmjA?=
 =?us-ascii?Q?qxc/g01aFH4aztidg2c891SXtDTf3BweNaUztmodiTULrJQBhv3RyL/W+z94?=
 =?us-ascii?Q?pGVZ/0xEMZy83TE6YinJgbgCBN57MHRJUgWGlU7Frm2I589A9sxMZzgOYZv4?=
 =?us-ascii?Q?8f0bRHJ3gVKJJf9I/woD6VNktSqyusEe4rllrU8druiStcNQYATRCNh7MFSY?=
 =?us-ascii?Q?ZTlOrsrITH2agATJIsSnFcZo3kfT2t1tS8HXRkqPUkfl99tSLp/2KpTA0hS7?=
 =?us-ascii?Q?D6DFvmf0l1s3C762cQiZ/veve9J9qkB9I6fKYxk/XbIW3KaanBpRdrloBxkf?=
 =?us-ascii?Q?s8q9n4loj/Opwp811zzNeOKO+gBreDOCQHBMv3Nyr+vCsj2OgF3Yak+WZuSs?=
 =?us-ascii?Q?KDIMP3gWY3Bs4NY+w7i5uJfXrRAFz37uU2+XO2+JndUCyqlW8aeiPTQ4AQjw?=
 =?us-ascii?Q?exIVn80ENw/qMDogEjJ22hfqKHQrcbjExjEyr5nhEvAU/x7Uw40EeLeOqVPo?=
 =?us-ascii?Q?NmNVVpd7cbFSkf2PB+o3GBq4tk2/SWQpp5+guuBQOyM9ZWKgAlrnH5DwQHVN?=
 =?us-ascii?Q?iqN+RxkBReErezZLYyGp+pLNgOZZMMxQULl2BKIcUMmaH9wL8vs8MpDxtf73?=
 =?us-ascii?Q?xztVb1BxOPuxxewPmWHnuCsm7xY7aCfHC5aYl/1eFcWUqqN8NC+w/6GFZXYc?=
 =?us-ascii?Q?SyTJLcDjur49p5wV3k0tKDzc0WxQqg+D2Smah5eM2uWt3RWjNRZ9CXh+pIG3?=
 =?us-ascii?Q?4pxuSs60CPRs7BqX+LpacYHu3HO/D4+xN5IQ2VP2R7kkgaZhsEdF4nAi0j0f?=
 =?us-ascii?Q?FSrMgy15htc3tNCIqZ93ExbbwfzTB4RdqE2p+qS0tVXv3Q5u9ZpDqmU0/63l?=
 =?us-ascii?Q?S6S8Ym/2XLz3kYOuwUfQE12s/jo0A8jxGU+bLxTdVrYvMfmKKneUHNFxa9O4?=
 =?us-ascii?Q?4/WXmHYm29eCxS03qOthSWAva9Xt09Cr0OAr4tvAbtnqehs7Ww0T/ah/WuSG?=
 =?us-ascii?Q?7Bxqn2cpyK1Nft6RyIR6RZgNcsy79DANRoN3Lu5AOiQPjIIF876y8MNt/MTn?=
 =?us-ascii?Q?GPGNA0N2ikEdYic8aAoPqJP4YK5PGtB4WH5gEF4+3U98axgA54No0KmscNKA?=
 =?us-ascii?Q?eu+tbR2bhTBd9JSPteaF7AU3ApYVUhRu/JI7Oo33L5BjzNRG0TV+z6FSRwRg?=
 =?us-ascii?Q?oWyGBPX7BJ88W4SVJRnL1PiuHATTht3uJ8zlktYZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0169eb-3599-4e65-5543-08dba3213b92
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:05:33.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIZrpfvz3QYegEr0o6CENICVa5buI1nOS2GTgcsSX5uvGp7alE8ab0svSJe7e/tJyIAbOzsEGNiYARMT9xEIBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/nvme/host/tcp.c | 108 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4d530448584f..63e64494e257 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -127,6 +127,13 @@ struct nvme_tcp_request {
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
@@ -337,10 +344,62 @@ static bool nvme_tcp_ddp_query_limits(struct nvme_tcp_ctrl *ctrl)
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
+static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			      struct request *rq)
+{
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
+
+	if (rq_data_dir(rq) != READ ||
+	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
+		return 0;
+
+	req->ddp.command_id = nvme_cid(rq);
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ret = sg_alloc_table_chained(&req->ddp.sg_table,
+				     blk_rq_nr_phys_segments(rq),
+				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
+	if (ret)
+		return -ENOMEM;
+	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
+
+	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
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
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
@@ -445,6 +504,12 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
 
 #else
 
+static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
+			      struct request *rq)
+{
+	return -EOPNOTSUPP;
+}
+
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {}
 
@@ -723,6 +788,26 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
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
@@ -742,10 +827,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
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
 
@@ -943,10 +1027,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
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
@@ -1253,6 +1340,14 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	else
 		msg.msg_flags |= MSG_EOR;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
+		ret = nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
+		WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
+			  nvme_tcp_queue_id(queue),
+			  pdu->cmd.common.command_id,
+			  ret);
+	}
+
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
@@ -2703,6 +2798,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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


