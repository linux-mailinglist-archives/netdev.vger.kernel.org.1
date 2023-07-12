Return-Path: <netdev+bounces-17238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61011750E36
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F893280D81
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9537114F6E;
	Wed, 12 Jul 2023 16:18:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827852150D
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:18:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE99273F
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv4R2VygCbCNFHwOUKtzVePksvOPY0EdP1sWacaGpladdycofGz8ehRusVmGKtUX0WMLIUjdmT5l1EtWQoEGQb2F6CSx1iIfej/a4kDMJZghVBXQqRGJaR41sTkYrlHv2mkMuhQxNWjc5F5+3uQDCuFmn+nzqyfWz6aPuHSSTLT/uoL1NWSzxb5VX+IovKqhKAxa/JcoEWS0sjZnTgT7pqiKvgitGZ8zPX94nfLNUYr0aw3rO2fa6R3dXLv+BBuqXOLvUipDi+bsd15unhzLEfI45nHF7u635NdxLO+8MqvmDHGZKbBntlSjAY9GJ2YvrrvLIKVDfMiqRVRzW/3RPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc2C3+T+eK2pQSQvC+04W1d3vmdPgHmjMHCJP+AcIsQ=;
 b=lRj0LHxu9/3BphaEI00RFUQQcTc07bIZPWB5ogjgRO4I/fq+6qK4JIN3ePaD2e+ig7hoRLkVw3hXSeHd2vwLPQnOWYWi2j5ThzcVSzFqIN5TPdOsNGR2xHUfv1MNjrUTn53MBv1Z9K7G6Szpl46RUamWavhm3ywi609Ne0NLG5YvIMpvzptlhS/wyOzZYgNJF8ZQl+och1wdp28xq/1HANGDRifFKMRloi2XCe+Jcyq6lDwFHUNREGUN4WnFK+6x2ebFze06iHsNXE+yyWZHdaNiVDwNX49Wan1EDFMYgxuDAfdohYj7ZdVucVvofu6XHLG847I4a9mL5LozzFqnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc2C3+T+eK2pQSQvC+04W1d3vmdPgHmjMHCJP+AcIsQ=;
 b=BopwWd8QxnXJzDbxo5tehKuTPbEd/B1m/SHsoZQzC1gsaHyAuyJe65RY2dXIScSBE3rfYnwqly3wSgx8mfWe23UvoyWt/oBM+Oz2biQz3PxxebZXNgpcnmddqtGMTTqwlYodQUgKc44QPPXxvKKHAvMY7k9WsEGWI6kgX4H+nF5s1A23uZffzV0+pI0Zv5HUZVHMuYNKaGn9ph/h+qZWnooRPgWWzaA5Gl8M1hWlF9yTk6YArD1XsV/WR9fjOUI6DJ6Mv0Rv3n6P70/X6pKP40t2y6JLAfkp3fI3VsAhLaJFvkzaEX8Bw5z4YEFUtc7xS0Zwbk8arliPI2OM02noeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:17:16 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:17:16 +0000
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
Subject: [PATCH v12 09/26] nvme-tcp: RX DDGST offload
Date: Wed, 12 Jul 2023 16:14:56 +0000
Message-Id: <20230712161513.134860-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb1c67f-32f2-49eb-f4b7-08db82f375a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ksHMoCezjZEDL7F08WWqNNkHvayjcaJQOUFuihXcuoqMi77BxTVWuhtCiWA7zkfDKUXztAGmMX90PYa99u+sv9h89SFOr8rICnlaFWhcb7O0dbgOWZbdgi4VsWKmqZFjIQfwwrZbS33bVMdfJYOCyKgNiE8dCKNoPXZOgKKD6r0o0GoXagIW1esgIjZXRK7+A7xaekVMrc16cSV5yA7JFtLI0bOt/F+rJo4DO8L8etoGP0oCa9dLrVTWfkJyV4QFIrN1Uj1u68MT+ne1Wrdbk++EEYo2kZ7TRuBQdJHTuqNLDbXy63P3eC1jitCNBHti1jo+XbmhPtwKIBDqJWegr7yZmQ8XAb+4CpYUgXrU+IlIpGjYpRJluSw+b3xKhoVoRFUG3mSA8waol4knnPS4YvhtN5BM8P6i4SfHE8LQVOLgLqNzSE4KdL2dQEhU55+XVzMwX6Ko9Iul98ul7Or6+aMdovZ5z2Hc9BzQmQt3ZZSeYp7cxh4rdJFKoa/7ZAXaMiAiVYOX9WS56NeDna2SXdP1v2Uv7E79bKwU3rOE+VUlJsH92o88lHjiEfO9OJ02
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e8w11rYTLdwAl4vgRKt2Vtee6yWemYnLDY6eROtsBGpnEMqbRio+KtLIbmyE?=
 =?us-ascii?Q?Y9mHnhORBKi0nmQIXnTswe59K/c7rv5vADz4bI3vVaxjYJrzoQvQknba9r6N?=
 =?us-ascii?Q?aibayO2XotJqKR92xN92+hs9hFXmqZyJM8XRAz7DabeEK816M/KYpArVwv6J?=
 =?us-ascii?Q?X1HoVXoKk9b24qnvmgHS3OtSLxXFCi2VVcOqfrCjMTAxNP/RbnlR1Hzmv2nn?=
 =?us-ascii?Q?/NuYbiiD55l6BtjOkm0nZTH/GZx4a6vh4qd1ZcEoy0NFOPqtztTRNY4I5QSZ?=
 =?us-ascii?Q?peBA5EOCXijHNfbpJQwPWKdQnskMqP8AyNpcdhAGm/UuFxC80BMUUt6YLiRp?=
 =?us-ascii?Q?eruVs1MVltpJRh4CyAozWDv0UAg4GtlYfAMgC0qdpA76J3JbKFKH6hPKfpnz?=
 =?us-ascii?Q?DUDAgOW03QhAO2PuuXlsVo8yBi3Bxj64xe7T8P77M25QgysXgUrpZvZxmZYX?=
 =?us-ascii?Q?+GkczDZLaHDSiC9kwOM3Q9D5tRO1Ledl4kj9sgAA332WbHbWz8uTHaow1/OA?=
 =?us-ascii?Q?GV9Tqv4U01v9YbV59MguiSb9QaqJadPSvhl5W758yWBJqU+tk8b3gBvlmV46?=
 =?us-ascii?Q?V++iePU4alclvRFtm1uNou+tK2dIEojgMKxfqGy8/eVZg8Ez3mxrpWvHW66G?=
 =?us-ascii?Q?Wse6Cx6XRQunjYR5Ne61P/pwSCTjoxfe7AYKTjga6UNtRftM3NW3kh0s/Ras?=
 =?us-ascii?Q?MLYewAg16ih1BtI7/FEw7OxYaDpNkzoYxgD45EnK17oR4IabW83LlxZLHQ3H?=
 =?us-ascii?Q?Z2+4MoPDU9ZqbaYvKooHgrqo8CwK/L3SuXrRttkoY73oZNFOi52QSFbH1PXV?=
 =?us-ascii?Q?ZgL/AzrM8mcqF+2pcGHtZeZ2ltrVOeQqsvQ+qZLBzHGH45uu/YrPSA3K52pp?=
 =?us-ascii?Q?SUrww5WxgrMOlJyWH1tsyyqQ7UqiothYp8FXTwLSoAzmfIJQGLw0m7pM/Edj?=
 =?us-ascii?Q?45/zchwAfijS/q6bumJDRdBfr2vRTpU891qF4dw2KwWAcCaOlPZOLFadydA7?=
 =?us-ascii?Q?s16Kih49jmQBu9BSkIHGX/0qSBAobi+Fy8ABATiPWeNi5lyRrwuyYpGARrYx?=
 =?us-ascii?Q?V1daSsnPjaefKHSEmUvBs3Y3MW3V5w1EJciCBnPA5+fkjx1dDBTp5Kjbdtk2?=
 =?us-ascii?Q?DPZOWHza2HuMF4NAtn4c+2OrTUAujpI7/K8BMTusGadfFv+netZBb1KyUkXF?=
 =?us-ascii?Q?lbkSt6Pm7vAt3mf2KXON0eX8MS2GwWqWjm8skGOf983o9vRiTDm/5LwQOsiO?=
 =?us-ascii?Q?yaxl91IvoYPjbXPomQ7MmXy4l8Khz/Y6/5T7YwkGfzScWLTXNl9N9SrGwXRe?=
 =?us-ascii?Q?098Gjmkb8qrONUUk1OBV1sNr9fz0/Vz0tfMuOkRyEnszYg2KTq9xAbCn/AAB?=
 =?us-ascii?Q?ZtkE1ksBQAtzc91aBQbTd9FAIn293T64I8K6qb1G+EnCXuw58y/jOk+e9YVM?=
 =?us-ascii?Q?fga/LPebMxBBkrO3vCouRKA2LdZH9lad5cF0zn10KJfWdbTl/T3O/m/F2/+C?=
 =?us-ascii?Q?JeO66FAyAqOZ/aXnbFQeTbV4yIc80xN2ZAcFoKIVlVjMuZF7QbN9USopU5KL?=
 =?us-ascii?Q?Wc6C+5LUq/L3P5qP6fu+Dz/aw32L3Q9Tr5ohQppO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb1c67f-32f2-49eb-f4b7-08db82f375a9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:17:16.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZ1NtiXwROMBQCdIw6qZRsNdOyOoH22Xo9/2hQ2OrfgfxF04/rnwAi6ba1i9is7D/r1VDjUxPAiLocsVBZHjTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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
 drivers/nvme/host/tcp.c | 120 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 112 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6057cd424a19..df58668cbad6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -130,6 +130,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_OFF_DDP	= 3,
+	NVME_TCP_Q_OFF_DDGST_RX = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -168,6 +169,7 @@ struct nvme_tcp_queue {
 	 */
 	atomic64_t		resync_req;
 	struct ulp_ddp_limits	ddp_limits;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -358,9 +360,29 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
 	if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
 		return true;
 
+	/*
+	 * Otherwise, if netdev supports nvme-tcp ddgst offload and it
+	 * was enabled, we can offload
+	 */
+	if (queue->data_digest && test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
+					   netdev->ulp_ddp_caps.active))
+		return true;
+
 	return false;
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
 static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request *rq)
 {
 	int ret;
@@ -375,6 +397,38 @@ static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request
 	return 0;
 }
 
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
+
+	if (!req->offloaded) {
+		/* if we have DDGST_RX offload without DDP the request
+		 * wasn't mapped, so we need to map it here
+		 */
+		if (nvme_tcp_req_map_ddp_sg(req, rq))
+			return;
+	}
+
+	req->ddp.sg_table.sgl = req->ddp.first_sgl;
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+
+	if (!req->offloaded) {
+		/* without DDP, ddp_teardown() won't be called, so
+		 * free the table here
+		 */
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	}
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -434,6 +488,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 {
 	struct net_device *netdev = queue->ctrl->offloading_netdev;
 	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	bool offload_ddp = test_bit(ULP_DDP_C_NVME_TCP_BIT,
+				    netdev->ulp_ddp_caps.active);
+	bool offload_ddgst_rx = test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
+					 netdev->ulp_ddp_caps.active);
 	int ret;
 
 	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
@@ -460,7 +518,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 	}
 
 	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
-	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (offload_ddp)
+		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest && offload_ddgst_rx)
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	return 0;
 }
 
@@ -474,6 +535,7 @@ static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 	}
 
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, queue->sock->sk);
 
@@ -562,6 +624,20 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
 	return false;
 }
 
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
 static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue, u16 command_id,
 			      struct request *rq)
 {
@@ -844,6 +920,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1047,7 +1126,8 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
-	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 		nvme_tcp_resync_response(queue, skb, *offset);
 
 	ret = skb_copy_bits(skb, *offset,
@@ -1111,6 +1191,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (queue->data_digest &&
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1139,7 +1223,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1181,8 +1266,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1193,9 +1281,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
@@ -1206,9 +1310,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+out:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
@@ -2125,7 +2228,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
-	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
+	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 		nvme_tcp_unoffload_socket(queue);
 }
 
-- 
2.34.1


