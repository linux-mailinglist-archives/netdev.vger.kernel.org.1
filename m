Return-Path: <netdev+bounces-25023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1F5772A2A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482821C20C37
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34411C88;
	Mon,  7 Aug 2023 16:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D53125A3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:09:02 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D02171A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLxZddNpMpI1QMeZPrkpDyw9jgip+k85w5JeSIyZ6UYcOPsCQERe0Z6JFP4qWzg9Yrz05FdO1ckfOY+Xj9OwX2TJ67drZ8YLi9v/jeHNg/CDGnEmNiJPqG7pirzRmVN78XLWWS8wsKdAP4AwDbB4okO6d5XIBFmB1Z+n9ldBZ175uKtXoJCmHaK1qA3MjOsJqtKp/utmKMZDKErFlz3s857k1SW20D4y4kRTfl+LNhVYJmigE15dUcxAJ2uNAXg943POGl0stdGMjRQ8Iqib6esQyLZ1tIEtJ3YzDOGlhcVe722seLN5LvE5+pJ0PCLRE+LNl5DCe4QS41y2J7m2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ojRdZUVUb0brb47nACVPz+n5h/EuHL3M/GdNB4CDO8=;
 b=SKzGn6Q/2aSVJ9soMtSF1JCBmJOej/0oWr/FFXx2sh9SlUcL3F0u1PR3nFBcs/3ssQ6EsAgLHrkLl23/mJbT48Lp5M/37dYps3JhCRWP+YrJOTEq0fqlV+HEl09uNoAGNgq8Gg41uPuil0F2/XfKecBxIuu8m0v1HqMQ4aZtpIZjor6D0Bx2j4cMEag/xAWubVGlpwko9hm0L0DNJQwFLiJ8IgNJab1UtSzQg00GVDoyzE/LLtYt2XNJV1y/OrnpivjqTN92Ei0NFQPz7MAutcCnpR2w7U5x+Kvl+Qjwi8v5953Pmk2wcveXDXBpk3xba0reLgb2fea1I8nOwSFHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ojRdZUVUb0brb47nACVPz+n5h/EuHL3M/GdNB4CDO8=;
 b=SzaFN/G1nAr/2SdU0eqGPS43fT0lTuHHKuBEj5Y1PD0QrK+jPuTYAyrXkhNDtVqLf5eOVMfVPA+o2Xh42mbAFf+lJP+hY8YKboiMg1wnaaozIo65PQjINWnrUfDldtn+Jv5e82HxyBOdg+h4yGto/MhkZuMkg1/VLYtnrBYDUd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 16:08:43 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:08:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH iproute2 1/2] tc/taprio: don't print netlink attributes which weren't reported by the kernel
Date: Mon,  7 Aug 2023 19:08:26 +0300
Message-Id: <20230807160827.4087483-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:205::35)
 To AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b1e047-26a0-434d-6bf5-08db9760926c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rEnv4UkFKuqBlhNNlS3OFeM1+1fGsuoonAb/yQovE+V3CNtTFrcnLuL8VD9zdCiteNi9wrkpSby/suiPq4dU9vDEXyOqmsymrVMAwDBVY4hf2gf1uPgAcCjJui4hiiSM73HRlxQjhX/9WgYcXSWSrPeGBr2EzXTG7edXT42+yDJOihFdwTlxlZuZfKX8YQd6hX5BFVgFwakRH0MnNjmqO81xpkPoenjkTw9zDQrE8+MqQnYdc5VkP3t+QXf7bNBC0uC9I5lUoQLyEsDHkNPNEYX4U0d9bUSJVH6fpIZpn7tFdlHiM18tcQgqgLnujoAJxCzgv9dcLYIYxARq8WN/CBct/Wq0LtE4J3URwYyqA0/8eE2KZNcuXygWnKPpkr+QOWzwPirqlMJbqQ8VkhBUTqenhtVzAgEv2xncEBj1olNk54VQsQwm0Q1CQLsR5BjyXfb+Vubdqy7+CLbiwsriL+dgR0DwomJ53fhRyaCS8E2dBJdEK/L7TLxEAbnulG0lmk8IccbIkfJg4wMci+lDYNLrMrrjaIZu2EmE6heI4Knm2OYmBAVBTBi8hRcoY/OyHx/uvpgk11rNqqYp9yDOGHnvq7vFETW2mzD41tsCWhc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(186006)(1800799003)(2616005)(36756003)(966005)(6512007)(4326008)(316002)(6916009)(86362001)(38350700002)(38100700002)(54906003)(52116002)(66946007)(6666004)(478600001)(6486002)(66556008)(66476007)(6506007)(41300700001)(1076003)(26005)(8676002)(8936002)(2906002)(83380400001)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HexqLDZ46UOcdrxdrGBXxpp9p7kPYgBzDUHGkBb1gp5McfZGpnQiph3Bc6nt?=
 =?us-ascii?Q?FftwDwyJ6TcyvXOpPN0XuKLVx+Je6EUKOma1ODUHfntwkvoUwSBK3PSAIYfk?=
 =?us-ascii?Q?xsRQOvoNMgxufQsycE6rP1RgH2rWwTSjnP1zWDDztISkoHIaSmgsIkZhHSMk?=
 =?us-ascii?Q?KJhlrqDwLmcIiNhk0wKXWqIUTn+la11b7Th6LjBQwpRIZ2S+VcMNA6rEVIam?=
 =?us-ascii?Q?0tirGQCjZSJ+lqydV9yWnpV3J8Go8pqGUwG7nTkjrjL4SM+nDmoAPmE3Kr2Y?=
 =?us-ascii?Q?0qibK57LMqxlVe0e6JHu4IwJZY63/VXl3Px/PriCVTL6oocHaL5ZgP+wruWJ?=
 =?us-ascii?Q?9eUPu6/VA4gXP24p4j+LBgkP8bX8XNoPb5szh0zOaNTyBd49TtDL7W0skyVT?=
 =?us-ascii?Q?DD9M16gcv1WEtTCZpX+aWFSRR7N6fXxO4texnbr5B4OsTX7AxUcgE9vj6jji?=
 =?us-ascii?Q?+eCk2uP31+4E53B5D9bzGT6nCmadFZ2kh3S39BwYFfminrLACqIZMx4MciCY?=
 =?us-ascii?Q?qei2UdYbsa+4ahXBBaPZJcoJqn0hP4d/IdfFWWpttM1N4ZRpXSiWf3haRk1s?=
 =?us-ascii?Q?cBHMpxKTfrNd0VOc99VBn18mMgOHwIZIze5BCCeDkY19jx3Et9ngndeiaNrh?=
 =?us-ascii?Q?cli4Cj73RDeF2/AUP6DJflOMFyVDy4nXav8DoYbdJh8pmfe2I8WG6VP/QXe5?=
 =?us-ascii?Q?aDsjcxK56myvjSGJnhKsWC/wN0sV/tW8aIrFmfeOhe2VD0VwIvZrak+bim0V?=
 =?us-ascii?Q?411eCdImfxT3TvE1a26088zrRHNOzLjwm4MTcu77ws9Cs1Jkq7ZcvOE2Ekjs?=
 =?us-ascii?Q?ZA3Cb67ZXhgDIzWKaDHL8vlJoE1Jqq6AQW49p1zYlL/bwcV/wDX+kZrhvIyv?=
 =?us-ascii?Q?xskI1HyLWf+tDFi6JVjOkxIXj46Xt34aagY9FRL4IP24sKPIaR1Y/x/bRBbA?=
 =?us-ascii?Q?F+1EAsnFZ4ED2J6AdRQsz0f3JmZiPAgnay05Iq8+qjOLfTF6vSjQca4NNl8R?=
 =?us-ascii?Q?8NfUth5X/Wb1H8BP+qfUK/jqzVrJcs5xPcMnfANjt1FHXk57I32ld0jkuiXz?=
 =?us-ascii?Q?CUPP1lAuRO1wgvm/KH41lc0fkihhwgYvaAXT5aLWLXR1MwWyXhXN/eL6zqpB?=
 =?us-ascii?Q?8R1CJiS0YA26zqnVnRrdK0WBEFtViyuqfKwBZSgVQwTE4dunKAruDFJ2+640?=
 =?us-ascii?Q?avI6MYlAK9XQqRurt1TOOxB/NXkPuB3l3oYXPTq87Kmu4lwryPAcc7p21kIT?=
 =?us-ascii?Q?YFxXihIAUsJLIsribgnMusAu4PReNTTKluEo9dKRHWuL/i+zWrREOAZQd506?=
 =?us-ascii?Q?a9/FzvLpPPSr0ZbrhhY0dJBIRgSHW8bzVeyQwa9fX260fZh1UxFPgGslsSDP?=
 =?us-ascii?Q?EDNyT2A4WgQG+4uRhc0bRvTmPRxjSqeY4ivKXe6MTBkcoBAz/tisgI00D/cm?=
 =?us-ascii?Q?cZHiYse1ZRohUgDryEOPx1jfUSbTV3ogcGACPQIchg+QEcANp/qq+xasY6Um?=
 =?us-ascii?Q?UPy6lGqHoI9uN8gq91nIo80hPJKH3wD/jympuoAUqqCpjAZ+txhaB/p3M0In?=
 =?us-ascii?Q?5lotYMBd0F8EIVmDTtPb0lTzBPsZG+sE9DP5VhMWsus13XSamgIJ/pI2lUq5?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b1e047-26a0-434d-6bf5-08db9760926c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:08:43.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACGQO+CQ8+IzBSwlx44yZz0TT5Ul5Duics344rbvIP9yucs0sA6fsFyF3vELSWCOJIXYqYjgB5NVQbZHXB7Q6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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
---
 tc/q_taprio.c | 91 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 38 deletions(-)

diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index 913197f68caa..795c013c1c2a 100644
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
@@ -432,60 +429,78 @@ static int print_sched_list(FILE *f, struct rtattr *list)
 
 	for (item = RTA_DATA(list); RTA_OK(item, rem); item = RTA_NEXT(item, rem)) {
 		struct rtattr *tb[TCA_TAPRIO_SCHED_ENTRY_MAX + 1];
-		__u32 index = 0, gatemask = 0, interval = 0;
-		__u8 command = 0;
+		__u32 index, gatemask, interval;
+		__u8 command;
 
 		parse_rtattr_nested(tb, TCA_TAPRIO_SCHED_ENTRY_MAX, item);
 
-		if (tb[TCA_TAPRIO_SCHED_ENTRY_INDEX])
-			index = rta_getattr_u32(tb[TCA_TAPRIO_SCHED_ENTRY_INDEX]);
+		open_json_object(NULL);
+
+		nla = tb[TCA_TAPRIO_SCHED_ENTRY_INDEX];
+		if (nla) {
+			index = rta_getattr_u32(nla);
+			print_uint(PRINT_ANY, "index", "\tindex %u", index);
+		}
 
-		if (tb[TCA_TAPRIO_SCHED_ENTRY_CMD])
-			command = rta_getattr_u8(tb[TCA_TAPRIO_SCHED_ENTRY_CMD]);
+		nla = tb[TCA_TAPRIO_SCHED_ENTRY_CMD];
+		if (nla) {
+			command = rta_getattr_u8(nla);
+			print_string(PRINT_ANY, "cmd", " cmd %s",
+				     entry_cmd_to_str(command));
+		}
 
-		if (tb[TCA_TAPRIO_SCHED_ENTRY_GATE_MASK])
-			gatemask = rta_getattr_u32(tb[TCA_TAPRIO_SCHED_ENTRY_GATE_MASK]);
+		nla = tb[TCA_TAPRIO_SCHED_ENTRY_GATE_MASK];
+		if (nla) {
+			gatemask = rta_getattr_u32(nla);
+			print_0xhex(PRINT_ANY, "gatemask", " gatemask %#llx",
+				    gatemask);
+		}
 
-		if (tb[TCA_TAPRIO_SCHED_ENTRY_INTERVAL])
-			interval = rta_getattr_u32(tb[TCA_TAPRIO_SCHED_ENTRY_INTERVAL]);
+		nla = tb[TCA_TAPRIO_SCHED_ENTRY_INTERVAL];
+		if (nla) {
+			interval = rta_getattr_u32(nla);
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
-
-	if (tb[TCA_TAPRIO_ATTR_SCHED_BASE_TIME])
-		base_time = rta_getattr_s64(tb[TCA_TAPRIO_ATTR_SCHED_BASE_TIME]);
+	int64_t base_time, cycle_time, cycle_time_extension;
+	struct rtattr *nla;
+
+	nla = tb[TCA_TAPRIO_ATTR_SCHED_BASE_TIME];
+	if (nla) {
+		base_time = rta_getattr_s64(nla);
+		print_lluint(PRINT_ANY, "base_time", "\tbase-time %lld",
+			     base_time);
+	}
 
-	if (tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME])
+	nla = tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME];
+	if (nla) {
 		cycle_time = rta_getattr_s64(tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]);
+		print_lluint(PRINT_ANY, "cycle_time", " cycle-time %lld",
+			     cycle_time);
+	}
 
-	if (tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION])
-		cycle_time_extension = rta_getattr_s64(
-			tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION]);
-
-	print_lluint(PRINT_ANY, "base_time", "\tbase-time %lld", base_time);
-
-	print_lluint(PRINT_ANY, "cycle_time", " cycle-time %lld", cycle_time);
-
-	print_lluint(PRINT_ANY, "cycle_time_extension",
-		     " cycle-time-extension %lld", cycle_time_extension);
+	nla = tb[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION];
+	if (nla) {
+		cycle_time_extension = rta_getattr_s64(nla);
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


