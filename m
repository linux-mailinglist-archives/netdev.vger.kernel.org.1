Return-Path: <netdev+bounces-29944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A09B7854D3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE351C20C5A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39AAD53;
	Wed, 23 Aug 2023 10:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CDAD52
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:04:27 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2121.outbound.protection.outlook.com [40.107.7.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE1393
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAd6o4KPetkxfNRLiNn2X/VnfoNkxxbFE8iW+0RzIP22+9UsztGYzadzU5PcsuYvrrcVAXMCo8Yl3Evj9BeskUtUOMymRd41JvwBNt3Vf1Fc+3f/sl/3K9UUPzRgSgtmxg+myn7NqLPRNQFFHDsg+3tw64OFKI2QLQBiLcvHn94rcOvFWkLneiEtPGAt/RS/uYjpV5MYD8duN7E8DkU7ZCtyXG8qz7tdr2OXwsOrkaikv4UZKHz5nS+R6ByQZ6dG0G14R1OtgtyNJvM8hfV5k415Lg11A8wVe2MWAUcZfd/tTT25i2VxM2nUsakHoxF45AL/N4L5lLdcMGZYux2AEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeR3/mWc/ykdZ1pUDM6QI3MoOhDAak1Fyoa10xLA5go=;
 b=PJmpLqIwzqr2RbveW+CvCE6vIk9+beH6A+BenVtMpD/Lks56z4qBt2Ix3W9uwyEnAirvMr8s7/ZMt0Ix1FoqsnJeKuS9EKhapu1sYFqYieYNrRVPvu2kR/RoNM4tDEjCNPO3mQwOEWnFza5rx5fDHHXr0Lf1eC0iaylflrrFxAOXlaMHg7xvl2DtI7jeNDm/PTnTv6+5DWpurlQ+H5aFGD94pRDU3vAVYJgNTL3WfQlIBr8Hw80Snyoi89zOJLJi9M2FSq2hWbFPufkCbofCSnV4rdcS3pQtFVfg5RrB5THc6gWEV6Vj/vsmg/5jp5uYzESDmFnt1YNdPdngTovvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeR3/mWc/ykdZ1pUDM6QI3MoOhDAak1Fyoa10xLA5go=;
 b=cFBRaJkpePOhEMBXDfy0021kpKk2K6n5+Kc6mg6kMhXWUQUAgqImNcOMfNpPzR886qXxYHfzymtgstzsgyMUsQyAUPFPthjj+GW9HY2Ss96NaMtxIG2RczyhGroCMxjHUTdsrmYWmRnrNZcwY1VgF7ilsrM0xKO5LDBJi6R9qIgRYRMUWPxl+NDWnMh4gacG9IGhtZm0KgOLtIAG5RQa2fGnSjDPg5+QWMajw1dbFFfLoqpxPeifnxy79jZviyDb+WUCZtdeEs9NAj6pVeS2jlr5MO3QphsC9+op1hj6jkTLSl/ZSIAVm4Ae8R3zxw1B9vz5g4VgLkXcV5OoxutrGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAWPR03MB9668.eurprd03.prod.outlook.com (2603:10a6:102:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 10:04:19 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 10:04:19 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	stephen@networkplumber.org,
	Francois Michel <francois.michel@uclouvain.be>
Subject: [PATCH v2 iproute2-next 1/2] tc: support the netem seed parameter for loss and corruption events
Date: Wed, 23 Aug 2023 12:01:09 +0200
Message-ID: <20230823100128.54451-2-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823100128.54451-1-francois.michel@uclouvain.be>
References: <20230823100128.54451-1-francois.michel@uclouvain.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|PAWPR03MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad4efa2-44ff-4618-627e-08dba3c05157
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n4lNmLWgmokAl3jC7FQgAmBlpTZL+XQ6GsYIX5wI1P+55Wbx//0WXqYFEgJFa2NL+GesnKjWiYeWAEx/qr9NescmrSe0fbV25POdsroazHx+F1oSkc6Ynsg7pIqR7JDjiDE0EJOY7EqsKFf7X3PrPS7WMUnClM/snes6pNwN6f902bA/8E9lWMDZE+XXxwfozJnS+gp0kVb5ZcgZ+YK7Jtl1ulHeTnv0bQNnGKE0QsKUKDxwxWTwUB7k/zZ4P35hhRQ9WMR6ooAcSlCbmVqzCWU/+DhiBzXh6YZ752V7P+REbzqFJSEkFv3pHj+1hvdY2IrWqSIyQhjID1nx2Zt6wYlr2vE41JrmPxQvFbkoEROnVNyYArDL8qfDk8wzi5kMWQnPh1cN4pk3hIGIkBATpFKGHzQFOdACg2iBVP7G5V2JhbLDANhwK99IaPntNLOlngS/xc2EpQ8bjmAqREUFHqV8+dDWze21an2qyd9r7xhgAovRe/FdUoFLFg4v+PPbkniVphg7JVKiceXPe1tPhYCNmIHkph64pJ+7zIncYdzcxv771XO+rt/2lpNnlXD980N3QPklWTtDNwS/eF/WbWTwFYIHXkBgtO1HO1edGRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(109986022)(786003)(66476007)(66556008)(66946007)(6512007)(9686003)(316002)(8676002)(8936002)(107886003)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(52116002)(6506007)(6486002)(83380400001)(66574015)(2906002)(86362001)(5660300002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em1IaFFzWkxWWlBZVVBCd29IUlRJOFdVb1B1UnpnTDBwYWtEU1Rnck45eS9K?=
 =?utf-8?B?aTdXUmMvbERCOVNYMmtqOW1sYnZhNHpxTi9qbExrYjliQWN2NWpGaGw3OEJ5?=
 =?utf-8?B?eW9oYnh4aVMzMlJDc1BPcktJeklUSVZ2VzRXamhZeE9DTUltZnN5TlBkUkZy?=
 =?utf-8?B?clNweE1sMmNBMUJ2K291aW8yOTVMY2l4S0pMRmhMSjUvWC9zYkMrT2h4S3Y3?=
 =?utf-8?B?ZG5CRlFpYzJ0aGJrUlk1VytSYko0elFleGZxS3Z6bDZIOEFmNHQ2ODBGaGlp?=
 =?utf-8?B?VVA2OG9VNGp3TEhDZzFZTzZ5U20vaFFLY3RqcnZSdDlJaUJMVnUzbzE0Rk5J?=
 =?utf-8?B?cml6YzhDRWpRMlMwWGJjNWY0czVERlF2RjJ6NEtsdTRiaHQvTUUzVE1oZ3Qv?=
 =?utf-8?B?T3hBdFZsc0tpWElkaGxkWkxHMDZJcFVKUTlwNS92SEFEMXV6ck1lNFg4VTJ6?=
 =?utf-8?B?SHcwdVNaRE42T0hobkVZUUNhdFJKL3p4OGE4M3Fqc1FZNDc4U1F1eVN2ekxH?=
 =?utf-8?B?QmJFT3lQKzAzakZzR1RPb1p0STZaaE4yTitLeTdpQWkwVWJEc1pTeWIyY0E2?=
 =?utf-8?B?OFl6NEl0WElJWmVvVUtiQVlrMkZVTDVCTUR4eE9vVUoxeE5sYk9TUTh2LzZM?=
 =?utf-8?B?U0ZmS2hyYVBaSmtUcWlVR2F4Z3lkRHBpdXFVbC8zdXhMSkJxRVE1NVB6YU45?=
 =?utf-8?B?REZFK0JKejNSanBGRVlmYXRCYVV6UVZkeEFKTEoyRHVmVnEzS1NNdWw2SGcw?=
 =?utf-8?B?WkdIb3RQQVB3a1A3RWFlTVhMMTZyelorOWJ3N1hpb0REOHhscThObG9pKzZM?=
 =?utf-8?B?bUlKR2ZFd3phalZ1S3B6M0RFQVJuVDVwTm9KVmswZ2VwclVmQ3JLZitZZkx6?=
 =?utf-8?B?elZEbXdsYkwyam9vaWF4M3RJY0ttaTRLT3EvVGdmZFJwZjhZUnlaVjREV2RJ?=
 =?utf-8?B?eHhBRHlqbHpJWHhlY0NHMWRFZENWb3lKRDA5U0FxbU5ZbUpSRkYvdFVJajA2?=
 =?utf-8?B?Y2JiUU9qdnpoak5VNEprQy91Y1BxNmtMQjNtcExZcS9JV3ZPdUVlYkIyMFEz?=
 =?utf-8?B?bzJZbzUrSVJUMzFJOVNYVkpKM2xPaFN3SG1JSC9iNSs3ODdsS1FEMkFvd290?=
 =?utf-8?B?WjdMUERLQ3M5K0wwd0xKTWhkcW1JMVpxRWFQTVdhYUdlYXp5QlB6ZmJxWk1s?=
 =?utf-8?B?bk9YU2tZQ05vYzlRdExNcjMxeEE4SnZVamQzaHAwNFB6UUFhOGNOUlFkU2t4?=
 =?utf-8?B?c1pNWERpdDN5UERJTFZaWk16a214dHU2RnJTYXF6dDExV1B4U2htSEFVUUxv?=
 =?utf-8?B?Qksrd3N1SW5zcVhreUt1U1RDUWxVREVoUG9va1NPY1NDaG8rY00xTjAzWXBR?=
 =?utf-8?B?aER5RnRBc2ZvRXE4cDJzTjdRaUVUQVZTUzJYV29iS0lvcVk3SkgzTy9BY1R6?=
 =?utf-8?B?YTBzcDhhRnVTcDNtblZyVTVrM2ZKY2dJVEVLdjV6ajBLbWJxK0lyeVZGYzFx?=
 =?utf-8?B?K1NWaEhDVkpuZWxEaUV6Z2hJTk5aWFBkM3RGRGdhaHUxdTFZT0hKVWVtY1Bq?=
 =?utf-8?B?NzNZZ2VwVzRXSG15cmprd0ZCZWExWVVoT0t6dFhNT01KUWRkQWhhd1MwY2da?=
 =?utf-8?B?LzRyOWl2dXp5b0JQWDdZV3hSa0x4eG5zRzYzZERHR3NvOW1pRWhCVGJ0c1pk?=
 =?utf-8?B?WHhLVjIyMlczTjlQMEtxajl6ellueWJVZVBPaStaRXJQTmF1M1N6MHE4R3Js?=
 =?utf-8?B?S0pONXVRM0xTTkZvNE1Mb1VOMGV5TmRaQ0JqdWFzVWwxWlNrN0ErNUtGNFU2?=
 =?utf-8?B?SkcxM21TNkcrb0MzRmQwSGFWK0N4YnJaczNxYzVueldwaytnRFpVZFBVSXFl?=
 =?utf-8?B?R1VzTlJ6cW5JRFRrUmQwVFhtNmpUWklRS3J4VHdFdGJMT2ZqSG5uVDhSNnpm?=
 =?utf-8?B?S2tJTTNrUmdOOS9jNlB5a1ZUOEk0bnJ2eWNiNmJHMTQxQnFSNWhoc2xxWFJE?=
 =?utf-8?B?Y2NjYUM4QldzY1RvYzJFT3BSOEs0WjVKUDJzd3JqejJpWTZwUlRqVU9mUW0r?=
 =?utf-8?B?UGZlcTBMZXBERXpXSEhJTXN4OWNxV1BxOExBK3dqSmdtTnkrUmNaSlNGYWVt?=
 =?utf-8?B?Y3BWazFKcGdPbnlucnFiTmw5bEpVOHJwb2F0YzRWSElDc2NvUlBIS3NSSDFN?=
 =?utf-8?Q?JLGYVTG1H055OL+IoOViB6SOAaCcn/JA8cXa0AD35l33?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad4efa2-44ff-4618-627e-08dba3c05157
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 10:04:19.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkAs9QJCn3xLPOK2zlYgQVCBM5L2l3ik2x6WnnvhZTlkx+l2LraUeZLAEe5yjfo99QZ5FAX5HaFgFAcxYpLqA1gU9JKFlJ7UcnKl6IJHPq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: François Michel <francois.michel@uclouvain.be>

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 include/uapi/linux/pkt_sched.h |  1 +
 tc/q_netem.c                   | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 00f6ff0a..3f85ae57 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -603,6 +603,7 @@ enum {
 	TCA_NETEM_JITTER64,
 	TCA_NETEM_SLOT,
 	TCA_NETEM_SLOT_DIST,
+	TCA_NETEM_PRNG_SEED,
 	__TCA_NETEM_MAX,
 };
 
diff --git a/tc/q_netem.c b/tc/q_netem.c
index 8ace2b61..febddd49 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -31,6 +31,7 @@ static void explain(void)
 		"                 [ loss random PERCENT [CORRELATION]]\n"
 		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
 		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
+		"                 [ seed SEED \n]"
 		"                 [ ecn ]\n"
 		"                 [ reorder PERCENT [CORRELATION] [ gap DISTANCE ]]\n"
 		"                 [ rate RATE [PACKETOVERHEAD] [CELLSIZE] [CELLOVERHEAD]]\n"
@@ -208,6 +209,7 @@ static int netem_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	__u16 loss_type = NETEM_LOSS_UNSPEC;
 	int present[__TCA_NETEM_MAX] = {};
 	__u64 rate64 = 0;
+	__u64 seed = 0;
 
 	for ( ; argc > 0; --argc, ++argv) {
 		if (matches(*argv, "limit") == 0) {
@@ -363,6 +365,13 @@ random_loss_model:
 					*argv);
 				return -1;
 			}
+		} else if (matches(*argv, "seed") == 0) {
+			NEXT_ARG();
+			present[TCA_NETEM_PRNG_SEED] = 1;
+			if (get_u64(&seed, *argv, 10)) {
+				explain1("seed");
+				return -1;
+			}
 		} else if (matches(*argv, "ecn") == 0) {
 			present[TCA_NETEM_ECN] = 1;
 		} else if (matches(*argv, "reorder") == 0) {
@@ -627,6 +636,12 @@ random_loss_model:
 			return -1;
 	}
 
+	if (present[TCA_NETEM_PRNG_SEED] &&
+	    addattr_l(n, 1024, TCA_NETEM_PRNG_SEED, &seed,
+		      sizeof(seed)) < 0)
+		return -1;
+
+
 	if (dist_data) {
 		if (addattr_l(n, MAX_DIST * sizeof(dist_data[0]),
 			      TCA_NETEM_DELAY_DIST,
@@ -657,6 +672,8 @@ static int netem_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	struct tc_netem_qopt qopt;
 	const struct tc_netem_rate *rate = NULL;
 	const struct tc_netem_slot *slot = NULL;
+	bool seed_present = false;
+	__u64 seed = 0;
 	int len;
 	__u64 rate64 = 0;
 
@@ -722,6 +739,12 @@ static int netem_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 				return -1;
 			slot = RTA_DATA(tb[TCA_NETEM_SLOT]);
 		}
+		if (tb[TCA_NETEM_PRNG_SEED]) {
+			if (RTA_PAYLOAD(tb[TCA_NETEM_PRNG_SEED]) < sizeof(seed))
+				return -1;
+			seed_present = true;
+			seed = rta_getattr_u64(tb[TCA_NETEM_PRNG_SEED]);
+		}
 	}
 
 	print_uint(PRINT_ANY, "limit", "limit %d", qopt.limit);
@@ -823,6 +846,9 @@ static int netem_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 		close_json_object();
 	}
 
+	if (seed_present)
+		print_u64(PRINT_ANY, "seed", " seed %llu", seed);
+
 	print_bool(PRINT_JSON, "ecn", NULL, ecn);
 	if (ecn)
 		print_bool(PRINT_FP, NULL, " ecn ", ecn);
-- 
2.41.0


