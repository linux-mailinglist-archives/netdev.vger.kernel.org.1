Return-Path: <netdev+bounces-25177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B47732D3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 00:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C911C20442
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2162617AA5;
	Mon,  7 Aug 2023 22:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30217736
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 22:11:26 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71575E1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 15:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4qaWym8CYj7sreyBPeMXQBUAs+i9pptYkUH13BhIx7g3OMMK4465aivBnipaqgPuRUXEf0k7E/Z7RH+d323IPiq60//rXxAkTCYo9AqlqsTOszO5WNT84jvSfSluSTHk+HZBxg99/h/14KzqMtLradF4lNvu4yFGcjETEe9m1TFA/lev3KDm999VMbNduGD8203yFffvgsWJ+J2OsV4xhA0KouFAAH2p6v6LWBAT0akJ3RCeAvz6HyGOvLR6ZqNrsbTMRke29xiJoCetZeDeIro1MHIlzFt2lemDv115ubFydJlBzGixk7VCZHoqpxkJOiecCgIGqw80RpwLqhw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGvmgjKqjRa5k+atW6Wf1sHxDAtT/axLJz5O0Zgd1Cc=;
 b=MijkQUbMtM0CNHOq4KdsIJxMzzgW9CJ9ZeI1kjXXY5scF/qVDpBJ9sfaN6bWFlCTkGObtPZzPDy/HjkLKWYY7s5+Bxj5jZ3OwhqZ1RFbgBC+N/HYc8DbXR7kSbT+6sAH2AdoHN3naskX1QTQSMyXuqkxgOeKL1I+6LYzU05zrHi/8dbT2u6jvN5hmfxKQKyGO6z8cGV+/ukQq3B0J6l+1OG9by08pLqItDC0QdQ62DpROaPGyZ/7yRef9w/2fQpkf4ofONptT1F2ZHwcGD6C/ODe+1iyOh74pBvk7lX+qpjPtZdcVA1xlIUiZoQyNDEPrKrOWkAhrbHm314BGWM5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGvmgjKqjRa5k+atW6Wf1sHxDAtT/axLJz5O0Zgd1Cc=;
 b=CCKZH4E25SJSSkfDqvEgyldJYPiX1HNXxytFQ3EhJaVG61srTJur9YCZLpJGicyk6SZxIM64+z2zvPgHD6iNp5IydBVMkdiRVeNIjUPTYRvbE5g8mhhfS8IObzDR8bzIN+pKkGGgz049v2ozHrjh00Xu/YBpNrq4FmyVY3kg0FQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 22:09:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 22:09:47 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 iproute2 1/2] tc/taprio: don't print netlink attributes which weren't reported by the kernel
Date: Tue,  8 Aug 2023 01:09:35 +0300
Message-Id: <20230807220936.4164355-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba896e5-2361-4bd2-efcc-08db97930320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gVHKRL+BAXKW7AAwZDwV25LksEjaC81iln5pS72jOF4t/DUTraZDbwnuiV+D/0k0AyyStWKzGyKwsyiLEpc2+k6T1UBJ/xihSHv4VM0NfeG0s/reaipxQmNA+Tsww2xoIH3XCGJbHJKWiI6aWzvQebYI2tc14dW+l3ICKnJcntQtia5RJuXnNfFJndtvebsUvNFWeMNgpHsvMdAjEncpHPNsIYOrWhQKcfjVfD/IjAqhM5WGSeYnbuBIHjIvB7W0mPbrL/xQAM3/KbDzb0R0LPeMbm05YhxU59xjrYLczkmCfVzlzLXOihjvFhIwOpdk5gl+0TYXIObfE/24fwU6UJzLxfaozjCYYXumpMFPuJ5HTGTzEW9Og0X0xl8YK1p+yZQzpkKUgiRJoed+DZMaZcz5Ug1dWzJ0Q4Qmk6xNPVBsISMaI+KaFJ9TKnjfu/02vEvSw9lcWbb3J9BIUfBAVr703ppJpvbqBMzzpYaUiEixRtreIIko6VbsaiXvC5SZbB59jkY7XZkrrVTPN5oES07skBtAl+2T5cIXWQeNP7RvdoKGETDA92WGmoSe77tKUzCBFG7wE3vWTjpFmqIH3OEEEruSq/+eoqRKt3MUM6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(44832011)(83380400001)(5660300002)(8936002)(8676002)(2616005)(478600001)(6916009)(86362001)(6506007)(316002)(38350700002)(38100700002)(54906003)(6486002)(66476007)(66556008)(52116002)(66946007)(6666004)(966005)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VAF7oKQsE9jAFpETzxSLcX1424NfWEHPRKM2DiuKxS7UcTe6OaOvyrJBvrV4?=
 =?us-ascii?Q?ZtYhzHqDOK06JSOc8JPbArARNlyJR+jOawQCitVa4eXVHJGXleRhzolig0NX?=
 =?us-ascii?Q?dtL7uE8BN/xzqucBLjVs6FXLk3lWPmg5YU7XV1D4GyG/EKbhgfQUROZwKmtr?=
 =?us-ascii?Q?6bjVjXRyTCaFm1g9yNHwBNUJ69flsHkrde7hqowLnQw5Edh/WSskYUodlzy8?=
 =?us-ascii?Q?yfxdqcZje24vbZL6IimIuACildabDjNEXIFYm1aQFotfERWpG1EqBu9bnQfn?=
 =?us-ascii?Q?HZS2mBXlmb3ceNMJgt5q1nII5DhRBTBrzGsG8zYpKdDmGoTr6r9uGmkJEa2i?=
 =?us-ascii?Q?1NJSI7naxAED2QDqd6xSctTtfIGEebrWPbiCTBN+ocJ/umzN8x+BLro7qgci?=
 =?us-ascii?Q?3WYvnuIzijdkDgJEXbHMPBMqx9GfniQtG1gX7+mbWC5WKyIlhWaXfYyzKq2y?=
 =?us-ascii?Q?l/XW2rCZ3JYZx8WZbVixTKxq6Z3WhHw0Z0J+upUEna0YQLKsVIfWGy+Kfx+e?=
 =?us-ascii?Q?owUUtBNDDOFu+D0oXAMVlVqGKUkbu6P89wUjRY8DjOEwb4cuUbJ14PijMzRq?=
 =?us-ascii?Q?SPL/f2jDGqSZIYWWOhbeuanlIJEI0RHNo4OUT+2jYbwMAsdc1tWaaT0um9Al?=
 =?us-ascii?Q?jMfQgrsKmEAF5GyG7BPfeNTPSn+F+Um1F0bgVu3UkzxoFvI6h0IFwhQonaPk?=
 =?us-ascii?Q?nRINFE8joqsgm7Bq7slgvXzCIeURQJpuWeeQ8O6xA8V+B8wq0UGvTWRj/M/e?=
 =?us-ascii?Q?RDjfPy+SnERZ5ZGHKz0bkMoJRMMJG+xn9MJHWqPvZ3xHOT/U/E+N95DiEPbQ?=
 =?us-ascii?Q?DA5zeZlT3q+M3YlteLMsw4XBOZBwzL37jzl8Sxi6Z2i8JQh39Ca0tPFATtA3?=
 =?us-ascii?Q?tPEX2T5mNyJ2YOWTV5ghK2BD5zHa+IBppTmGD+GGJ/HhGHyoA/5Wrsi9cxII?=
 =?us-ascii?Q?sWVpegkxLlNUMfp3bD2GVaEIVs2D3Cysoya0huiAqWeIMj8e7ZdCHHrXFCJT?=
 =?us-ascii?Q?zaEQJ3K0cBeA+st17dfAv1ZoM9Aqm5OEgO3np4x287ks8Atpoq7qkknfpAAl?=
 =?us-ascii?Q?w1ypybzFAD7urNq4mGPNbnUTSvaWN/HeSXB19gbOUiRkmqSYY0hVB8bm3YKT?=
 =?us-ascii?Q?F0AXda1t6bIL/p0/EUoYI+D4GILEFmC/JFg0mkmjpMLtenB7jQZ0wQh/Kdyv?=
 =?us-ascii?Q?yJFpXXYyW7otPw2xGgsPbAGhhPRywbpoxYJllD9AdZ6Hm33QDwrD4o5e0ii4?=
 =?us-ascii?Q?sM4BRKyg5uuHyOyyTKT0LizgkhJI4q8fTNcER4HKbPDR3WiCH488E9XNIPOi?=
 =?us-ascii?Q?+EEfLtfDu5nIPTgm1hh6T2MUcelwwQvxVbGdrXNQ3/4/ne9JY04ZIrn5qYLN?=
 =?us-ascii?Q?2cV8QWg0jgdpyqwGD3bqoxaaCvSRNjqookDkLybyEfrWOo3C5ZfkYM+uce5n?=
 =?us-ascii?Q?pSNMQznv9jbYuVvy+hOQwvnhjfRS8keGu7PnoLhfM97kKFOf24CJ6QpvMjC4?=
 =?us-ascii?Q?G5LeHd/3YBLzoEJrf4xiooEPa8HZxFkFjXcfgLGrhaWwQMP5iOULMOy3eQbU?=
 =?us-ascii?Q?7LAbdhtmDn8JMV1U2MffQ/HArjt+8g5URCg7srgakk7y/2EWER8BG5H3uYMa?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba896e5-2361-4bd2-efcc-08db97930320
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:09:47.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgGX8/q+bRMaWaAj1fggqlPiiakfF9w8McUyKlV5kkTXHR0YuaK1HAVTxz6TMwhQDbXk4/LSUbhzC50+TQSKww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When an admin schedule is pending and hasn't yet become operational, the
kernel will report only the parameters of the admin schedule in a nested
TCA_TAPRIO_ATTR_ADMIN_SCHED attribute.

However, we default to printing zeroes even for the parameters of the
operational base time, when that doesn't exist.

Link: https://lore.kernel.org/netdev/87il9w0xx7.fsf@intel.com/
Fixes: 0dd16449356f ("tc: Add support for configuring the taprio scheduler")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
v1->v2:
- move variable declarations to their respective "if" blocks
- use "nla" instead of "tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]"


 tc/q_taprio.c | 89 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index 913197f68caa..6250871fb5f2 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -416,14 +416,11 @@ static int taprio_parse_opt(struct qdisc_util *qu, int argc,
 	return 0;
 }
 
-static int print_sched_list(FILE *f, struct rtattr *list)
+static void print_sched_list(FILE *f, struct rtattr *list)
 {
-	struct rtattr *item;
+	struct rtattr *item, *nla;
 	int rem;
 
-	if (list == NULL)
-		return 0;
-
 	rem = RTA_PAYLOAD(list);
 
 	open_json_array(PRINT_JSON, "schedule");
@@ -432,60 +429,82 @@ static int print_sched_list(FILE *f, struct rtattr *list)
 
 	for (item = RTA_DATA(list); RTA_OK(item, rem); item = RTA_NEXT(item, rem)) {
 		struct rtattr *tb[TCA_TAPRIO_SCHED_ENTRY_MAX + 1];
-		__u32 index = 0, gatemask = 0, interval = 0;
-		__u8 command = 0;
 
 		parse_rtattr_nested(tb, TCA_TAPRIO_SCHED_ENTRY_MAX, item);
 
-		if (tb[TCA_TAPRIO_SCHED_ENTRY_INDEX])
-			index = rta_getattr_u32(tb[TCA_TAPRIO_SCHED_ENTRY_INDEX]);
+		open_json_object(NULL);
 
-		if (tb[TCA_TAPRIO_SCHED_ENTRY_CMD])
-			command = rta_getattr_u8(tb[TCA_TAPRIO_SCHED_ENTRY_CMD]);
+		nla = tb[TCA_TAPRIO_SCHED_ENTRY_INDEX];
+		if (nla) {
+			__u32 index = rta_getattr_u32(nla);
 
-		if (tb[TCA_TAPRIO_SCHED_ENTRY_GATE_MASK])
-			gatemask = rta_getattr_u32(tb[TCA_TAPRIO_SCHED_ENTRY_GATE_MASK]);
+			print_uint(PRINT_ANY, "index", "\tindex %u", index);
+		}
 
-		if (tb[TCA_TAPRIO_SCHED_ENTRY_INTERVAL])
-			interval = rta_getattr_u32(tb[TCA_TAPRIO_SCHED_ENTRY_INTERVAL]);
+		nla = tb[TCA_TAPRIO_SCHED_ENTRY_CMD];
+		if (nla) {
+			__u8 command = rta_getattr_u8(nla);
+
+			print_string(PRINT_ANY, "cmd", " cmd %s",
+				     entry_cmd_to_str(command));
+		}
+
+		nla = tb[TCA_TAPRIO_SCHED_ENTRY_GATE_MASK];
+		if (nla) {
+			__u32 gatemask = rta_getattr_u32(nla);
+
+			print_0xhex(PRINT_ANY, "gatemask", " gatemask %#llx",
+				    gatemask);
+		}
+
+		nla = tb[TCA_TAPRIO_SCHED_ENTRY_INTERVAL];
+		if (nla) {
+			__u32 interval = rta_getattr_u32(nla);
+
+			print_uint(PRINT_ANY, "interval", " interval %u",
+				   interval);
+		}
 
-		open_json_object(NULL);
-		print_uint(PRINT_ANY, "index", "\tindex %u", index);
-		print_string(PRINT_ANY, "cmd", " cmd %s", entry_cmd_to_str(command));
-		print_0xhex(PRINT_ANY, "gatemask", " gatemask %#llx", gatemask);
-		print_uint(PRINT_ANY, "interval", " interval %u", interval);
 		close_json_object();
 
 		print_nl();
 	}
 
 	close_json_array(PRINT_ANY, "");
-
-	return 0;
 }
 
 static int print_schedule(FILE *f, struct rtattr **tb)
 {
-	int64_t base_time = 0, cycle_time = 0, cycle_time_extension = 0;
+	struct rtattr *nla;
 
-	if (tb[TCA_TAPRIO_ATTR_SCHED_BASE_TIME])
-		base_time = rta_getattr_s64(tb[TCA_TAPRIO_ATTR_SCHED_BASE_TIME]);
+	nla = tb[TCA_TAPRIO_ATTR_SCHED_BASE_TIME];
+	if (nla) {
+		int64_t base_time = rta_getattr_s64(nla);
 
-	if (tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME])
-		cycle_time = rta_getattr_s64(tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]);
+		print_lluint(PRINT_ANY, "base_time", "\tbase-time %lld",
+			     base_time);
+	}
 
-	if (tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION])
-		cycle_time_extension = rta_getattr_s64(
-			tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION]);
+	nla = tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME];
+	if (nla) {
+		int64_t cycle_time = rta_getattr_s64(nla);
 
-	print_lluint(PRINT_ANY, "base_time", "\tbase-time %lld", base_time);
+		print_lluint(PRINT_ANY, "cycle_time", " cycle-time %lld",
+			     cycle_time);
+	}
 
-	print_lluint(PRINT_ANY, "cycle_time", " cycle-time %lld", cycle_time);
+	nla = tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION];
+	if (nla) {
+		int64_t cycle_time_extension = rta_getattr_s64(nla);
 
-	print_lluint(PRINT_ANY, "cycle_time_extension",
-		     " cycle-time-extension %lld", cycle_time_extension);
+		print_lluint(PRINT_ANY, "cycle_time_extension",
+			     " cycle-time-extension %lld",
+			     cycle_time_extension);
+	}
 
-	print_sched_list(f, tb[TCA_TAPRIO_ATTR_SCHED_ENTRY_LIST]);
+	nla = tb[TCA_TAPRIO_ATTR_SCHED_ENTRY_LIST];
+	if (nla)
+		print_sched_list(f, nla);
 
 	return 0;
 }
-- 
2.34.1


