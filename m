Return-Path: <netdev+bounces-36862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8427B2093
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CC0E1282098
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714324CFCB;
	Thu, 28 Sep 2023 15:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B34CFA5
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 15:10:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B688F194
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXRWHBYIpQh6HdSZEUVdcCO/4P9WfCY4vXkPsOf/5SZ3rtltCXv7MOjOVRrJZoUnnwJHRnuAwAy9/kjEay8VNXP03IEUDA6uVRXcAWSn1C8yxPfqjD4pSnrSRsn1Cw3BHE7AYyaNJ20WCKCen2XR41Fi4reGCUR753BCBMzKrO2rqN9311A+6RZ3Y+mEsDqzcQKt+nGlVZXtsDAt2uApDwpNA9fzxnB/jmQqLptIksfOFgcevlQvbvR76CpDUzzFV986MrHmTC9m5Zf7Oq4x155q28d3S5lx2VdE2ZnWtevr8pYQkqw4oOIcz/f1E0n9y+cupH07XOG0UmxzpVQTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cbwb8lRKkaBKWj9HC+/vTjnwIw+2U7k3+lRzIjTCWM4=;
 b=H0ROfkW2A8jnL2dM5w+jOQsCvJHrMHw5go6wDUaPErVAbaSzffPBBClzSWmI0bkXT9JQs0goQyd8HqLp7FCi4C5T6xj9FyeFjkvk4MOWjvfITvFeyK7pwPZFFuWKrzywlgTl1R+a4CRSdQhHm53a5q2KFBq0MIJfKNGklnRynhPnCLoIOj0rbvdOMfcWoRUKYAsVPGG28wyzeM89+x84MAB+poHPHHVtmNc8+ZrEf33vRQBTxfHXbFHX9/Y7kP8AHcUUOWOgYuHToCapSml725et54K4W96zPxrAQ5uJa/ekWywDL9Hf69frly3X8YDECDqPuqUtrIP7ATcR7LJTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cbwb8lRKkaBKWj9HC+/vTjnwIw+2U7k3+lRzIjTCWM4=;
 b=IFvnJgjWuZI8pWbx+fLXd2sZiXmntli9YecUZdEmqMwaMQIJIcXWp70k7EYNSwpjKXQE8dyPIEyKs05zQsiPaB6KXwgzkUlcUChgsbOaJ0kiCj4c4Cp31juq9TKJbWnq/PFbfOirvbO8QTdIVrI26zvJ79rPh0Cay473JKKQNycgzBMchwtTM9vmnUHqR0Cqxxlpd7eW/7tAr70MbKJ6ds0W3hJhoZjh2LNMXk1Ijcp4I8pXop/BeOsS7+eG/qsx037HjNe4QpVAOI8K285T8GkoeXZ/w3YrdrQqaAeLXwdG3iAFRr2dp9Jv9CejRPA73FOYfryM3u0/rpzq95II+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 28 Sep
 2023 15:10:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:10:51 +0000
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
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v16 07/20] nvme-tcp: RX DDGST offload
Date: Thu, 28 Sep 2023 15:09:41 +0000
Message-Id: <20230928150954.1684-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928150954.1684-1-aaptel@nvidia.com>
References: <20230928150954.1684-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: d782b6cc-9efd-4883-be69-08dbc0351a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ByNUCkN/WPRRvYFlVzAf/blw3ZWEqdk9T1yHPZxRC0kM3bS9WaLACp1aI0L3A93h2XrLvensYOnhVMvFgx7LPl5kM0+aH8kMmwk/Ygpd5U6RdCUxbIKuG+AMN4am3wc7SuOVpzETtG8qtFGtRpUJ7wcX32eBbffouDh3F++AZ73wdjnmoB3nfYueIm4/pr2BDRvEDymqjZ20kg1lGzW6l2/pd2aDDu9vD3Iw11HxQsTnlVubzVhlZZkOJbM+I9mwhRLjzheSlIVrV9kJT0sIfL7sYBz4Cs7x9oljM8zee31M8BOiIU2C9pmcc9/iJsw9uz6PwCD2dpIDNQ+jQMGRqFVyQNC6QR2CTjngP1a32Drk9btC47jp+H4bdvNrNEU8UDC14OUvzY/f9kDDxUIQd8LOCSMpbnEMo75z7mdGkgW6HrxLZGGnMN3IQT1dVfmRKi0Xp4vWAcRAjphgUM+esqNAr8C5ibgb4Y8SPL+CaKv4AdgciPdD7/YUYHOdVy9JMiGxtryBu1jsOk1Lc9MMezEewIP6rvPJetN6+6CquByTwynbJ9Z/s2nCQeXOSm/N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6666004)(38100700002)(478600001)(66556008)(316002)(66476007)(66946007)(6512007)(107886003)(2616005)(1076003)(6486002)(26005)(6506007)(8676002)(36756003)(7416002)(8936002)(41300700001)(2906002)(4326008)(5660300002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zzrrwNv8EXhMFingNJ0l8KwK7AoXweVvx7SuHHA0r+x1y//C+qsuRlechMzG?=
 =?us-ascii?Q?wQq/irNmU1lYSmXxY3QyAz4KKugtlfLekMHRa1q+TqB9o2gKAoTBu7dV74P0?=
 =?us-ascii?Q?RWjVtO54iQuZAOnUb2eYy03wlu+vwGXJ6mD77HrGeY2p4KAD7l6ZsINsWuEs?=
 =?us-ascii?Q?P+C3QbOoWoKEPks3eWWsbzhdZMN2um4PXICfLJAYB2ezaD9StDD1tlyRQOKO?=
 =?us-ascii?Q?zFrPO2y7Z3FsWagZiI1m6uGsEi8XJZ0PTJKkbbwGL3kw44mge1ACTAN2vHn1?=
 =?us-ascii?Q?2VSbHqQZ9TyOaqYcmkFF9TaUlehPo3S+f05DS3hqK8fCt2O+1hD0KA3PoP6S?=
 =?us-ascii?Q?HJGklrd1V/BuquFF7LNViMfqOV6BXCjiJDr9Nw8CW+a6ZhzqwKr+l6kkNeVe?=
 =?us-ascii?Q?Yx3H72+u0TwyQAA/zkSB96vTbmoXW3+kc6q1xZYSYbz0RHA+2ch+4vSy0wdz?=
 =?us-ascii?Q?CfnVHXFVHhDEFD9tlLAf1s5eB9zzcstKChPhhcv3TjpOvp48gm8G8ms7xSn2?=
 =?us-ascii?Q?OmQISkN4ls6r8KyGIXblxQKkdqIip54REfWa9Y+hm2ELzKW8J1aKgR+jxPkb?=
 =?us-ascii?Q?PECaxaiIg+OD5k8C5bXdSzOnOvohsieKhfxvlCNtxhh+TcI5Ur5PJWVkOr6o?=
 =?us-ascii?Q?NDROEPSssOeFkKLZVW0Y2oVDFBVKSzA6tdQT5xV+7TCapgagH/IO73v11gIr?=
 =?us-ascii?Q?J23UCX8+TzeYEojdaJTMVaTg2u9hUG24khRy+WovMkOSK6HCOHexf2Xh78hR?=
 =?us-ascii?Q?OJ6zxHw5mScMfY0DFjYMTbEgRi+lSz19LTybEbsJ41wtI8kLCXpGlhiRcFJC?=
 =?us-ascii?Q?Npz+NivyT/FZs7QSqV4TK3A2YrbgiA9P3qrahonz7shIt2Nj31sMsEBxxvlD?=
 =?us-ascii?Q?C+EtoKwUc+G0wGwoSIC0i6VPc7fotpmLexhcpXNYxZulV/ZlJY8O3a8NQh0P?=
 =?us-ascii?Q?vEwRllaB0UgOEbXGIZm8EtsTcaHawrs+QxI9auFAYvjUFYCXn8mavwtv9C67?=
 =?us-ascii?Q?kT1JPJs/yEJlaX1VaMEArqMg+5JVBOuhHYCOelGxh2N0L8WV3RLLpohxumJj?=
 =?us-ascii?Q?v8zFO15I2h34ZrXPK8h1KiFFik9/WYxkx0VYyA2negggT9kkpxbXlsvLnYX1?=
 =?us-ascii?Q?9mjrxfM9K+DP3kftP0QXDyZ7vVRYvBVkiPRdZpcV5HD0YpvOcuo/fsKdCA4q?=
 =?us-ascii?Q?Nl4rRt4Plg4MO/PTJVKZuTKIMrf1FqnqEHKAALSyciMqAwNrKSpRohH6njph?=
 =?us-ascii?Q?icQMM2yGa94KQcfa+MjEGr36bouSLD1kw0j+ys8H1FhwN4eyGiRGamOpYvwg?=
 =?us-ascii?Q?z9hxNeCP7s9Xc0HwmfR1DdQLInw0YujKBY7ciYUGyTn+KQiL3oc8nn6ixO3c?=
 =?us-ascii?Q?DGqG8lJPjGV1wMagPNhqlaYb7z2mYdZYraa3XJCNneJnaNVCUPEYZ/fT0eqo?=
 =?us-ascii?Q?zOvxKCdoFgwDMlqzFcpFR+lCXuRBeNR295G8k5AeRiVicmzFOYka6g/yHHbS?=
 =?us-ascii?Q?6aC1FuDnlB2a7tuf+5BbDuEjsfLUU8QrOEQQ1MHkkKwuYTsmoX90SIlsiqgq?=
 =?us-ascii?Q?HWi/xuslHanLeLtVMrEDR3IJc7vmcT4el+S5rBAq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d782b6cc-9efd-4883-be69-08dbc0351a26
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:10:50.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8t4aKMwVcDWVM7No6jb2jdk2aJWXQdxleQJ3MyxRWpBhSqhUTKXI4KVtiJipm/ucdGfbpQipRP8AqJhABhceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yoray Zack <yorayz@nvidia.com>

Enable rx side of DDGST offload when supported.

At the end of the capsule, check if all the skb bits are on, and if not
recalculate the DDGST in SW and check it.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 84 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 655f73dacc09..49975e8e7cde 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -126,6 +126,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -163,6 +164,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -342,6 +344,33 @@ static struct net_device *nvme_tcp_get_ddp_netdev_with_limits(
 	return netdev;
 }
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{
+	if (queue->ddp_ddgst_valid)
+		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+
+	if (!rq)
+		return;
+
+	req = blk_mq_rq_to_pdu(rq);
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -412,6 +441,8 @@ static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
 static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	bool offload_ddgst_rx = test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
+					 queue->ctrl->ddp_netdev->ulp_ddp_caps.active);
 	int ret;
 
 	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
@@ -431,6 +462,8 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest && offload_ddgst_rx)
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -438,6 +471,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -537,6 +571,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -797,6 +845,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1064,6 +1115,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (queue->data_digest &&
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1092,7 +1147,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1134,8 +1190,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct request *rq;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1146,9 +1205,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+			    pdu->command_id);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
+		/*
+		 * If HW successfully offloaded the digest
+		 * verification, we can skip it
+		 */
+		if (nvme_tcp_ddp_ddgst_ok(queue))
+			goto out;
+		/*
+		 * Otherwise we have to recalculate and verify the
+		 * digest with the software-fallback
+		 */
+		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
+					  &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1159,9 +1234,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+out:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


