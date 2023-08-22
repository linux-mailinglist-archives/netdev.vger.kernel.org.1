Return-Path: <netdev+bounces-29640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32C784331
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121031C20B48
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F81CA0F;
	Tue, 22 Aug 2023 14:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF87F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:06:14 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2092.outbound.protection.outlook.com [40.107.247.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A79FE60
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIrHtKnEhFw+VByqX1rwJAhs6F3iMmkszLdxkXOZtudh7zYBJK8SORU6frCPS90G6ziTVyxH7bEZP7tKoKCOXbCnIv/HgD25yHqZKQaXpFys5ECZBVrAxGrpukGI0vfun6QVzCJWyIYdk5J9l2iOX+0p78h1Au8fYlkzAPtKjYSABNyS9xLZDigDNfRmkQCajhj4v1IR/AsoFZY6oT75iKLHLrk39DoaC9Ky13yR39rqeBlW/FHEKdhD5hc0Hn7/ECr3gUi1RU5hz8hsSvCMFaSAxzF3L9K4sNjazF+9jjH/T35KQfnmwxR3jb27PE//AorFv8lgu3PR6uEN8PfNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuawKD8jrnR0so3R5hBsaQkU7S/g7p1U60x0LdwTObo=;
 b=izE2VrLgViRrR0om4jD+yyEhW0P9xFQa6pqET+ie81R06wb2zGvNOYgAjraqzuCFR1N0YOIssrgdKSNgk4rSA0baEPOtz3MnatgRhTckeZlUU+hy6CILXvHaA+ILJ/tYSeOGpwnrlYSPnzE2EZoF8dBX7ZOhR5hR27/zUd+nQIVhZDrDKF0DN60plIP+Sn4TZcdX9vS+OhGGwWumEOGAcVK85ao7aJNLUgGXK8EC1PnmWFnizUIWRkyh6vO7qx1BUWj4jQwbX5SJY4DUebky/jWHZKsJ5KqfhtO9rp7DB+3jR3TeLCHvQeOl29C2S+aH7KTanGBGI8L6rkY3Tpl5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuawKD8jrnR0so3R5hBsaQkU7S/g7p1U60x0LdwTObo=;
 b=umPpUbLTSAQ2s16vL4sxCPUjODTMj1VKR8eotqxnNov0uZO0OZW4F4mBGKFDF81CSu6Rcf9y3oTDKCot1nAapUztRhaAs7PLGTm6LtIpuukUnE9ud6W1H4OLUNjSFr26zjDGrfFqvQv2ww3pkLUdojqRUFVDZM7nWos0Tkn9Wjx3rRGMu7fB3D2B1amvvuweUkwoe8fNyGsywLGS1a7I2L+4LrB6sXgttZ36UawSoLqeGZxZJ756HAC8SpX4S2sLRMzyJI8WluzMmXMu8HMwn1TkD0IOCuPxUfru9Hhse+jQ3AykBnhWQFDoJ5iMz3xtlo9SjvfeP4q/8zzCnNADLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by DU0PR03MB8161.eurprd03.prod.outlook.com (2603:10a6:10:350::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 14:04:46 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:04:46 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	stephen@networkplumber.org,
	Francois Michel <francois.michel@uclouvain.be>
Subject: [PATCH iproute2-next 1/2] tc: support the netem seed parameter for loss and corruption events
Date: Tue, 22 Aug 2023 16:04:02 +0200
Message-ID: <20230822140417.44504-2-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822140417.44504-1-francois.michel@uclouvain.be>
References: <20230822140417.44504-1-francois.michel@uclouvain.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0429.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::9) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|DU0PR03MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 764a36fd-e938-4036-0a03-08dba318bde5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2fYdWCaEG/0gxPwvAZNEgRE4tQ7M6hLOXR/590HhLarHrik+yKkjDTbm2WJZfbiqzZEios3p3OL7+ThHpvcU6u8viVF8+4YowgDRZZZkmklPnApsYaEBIsEN9SZLAIXyTs1ipb9Ld0+XY0tXswLOprr7VzNDqbTjnqC4SFApWjviXCyxufYaoGVvJ/H+1K3k/tTdIr9J7vakhyB2qH0xLdFB0WHjy193Zbp8PJfA2n6SMSlNM+NkjUZDjOrqKN/PPPQUYy+sgy46IuwCTsMyIjlIEwVXn7qYfGzzsijlo4+L3/v8iBejyBfZzlQXzKCQBJjdRtRQxpSIaFPTsXhK0rSP7K/lctPO/QWaipZhqpwkt8WrAOtO6mKGuB3W90Onlqs/V6tpqFHd412jx4nJUwTMf67NXa0cfWfrZDOI9ZE5o7peH31leeFZYAQgglbSLtcPNl2RZe9d1WX/jOO7c5Eu+zFHkxR6GUhmanP/EItPXnwAUkKmI3rSZa4V1uKNHTj7nKffoRv/0S6X90U9ozApEqctrAoqJf65mgN9Vo5q/oPzkK19N+lAuFQOGrGT4hWAVOTA3usqCZUKbd3qnt6scemRYp4p1zKJzu2snxk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(109986022)(66476007)(786003)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(52116002)(6486002)(6506007)(83380400001)(66574015)(2906002)(86362001)(5660300002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjljYjduVlpUZUJqOGJOZk45YVZmdXd4WVgwQ0Y2QjRHdU0yaURIdjQ0NTVJ?=
 =?utf-8?B?MmpwUnJxaDk1QmVaNTNrcjI1NjljUEwvbGEySkNHblR5ZittaGk1cytGS0Fk?=
 =?utf-8?B?WmZMZUVyZEFxbWVrQjRHWDdmaUppY1VJSUQ4Wjd0MzRsYnExMDh5UWMwbGti?=
 =?utf-8?B?d0lYWU92YWlGR0ZpaWZmUUJOeTJmdC9lUEVZNjE2VTdYd2JiYWh2Z0t6KzdI?=
 =?utf-8?B?UUFCYVlQOVlhYTNSaHFlOXJySUdZSTFrZzRNM29KeFQ0VkNoZWR6NHh2L2hU?=
 =?utf-8?B?Mkh5VWdzN2dDYmVnY29PN012Q3F1dTJJbVg3MnBNUEd6N0JIKzEzK1N3OFR2?=
 =?utf-8?B?UnV6djVnNWthRGJ4cEZPYmkrMFZmM1h3b3BjWFJaNWttMVVBV1NZWG1jc21Y?=
 =?utf-8?B?dmNXcms5THhuMjFwMk9MNkhQU011K0l6WkI5MjlLQTl5Q0xQMWRLQmkwei9I?=
 =?utf-8?B?THRZSHhtK1MxUXlJMXUyUlg2OVZRSElTb3R4UDhCdytaNGQzQW53UFRNVHZV?=
 =?utf-8?B?QkF2WWN4QmZPaCt5WmtwVUNBK3ROSk9BTzZIMUNDcGxhM2dKVEkyckVwTVlT?=
 =?utf-8?B?bFZEMGM3RzJiTC9ZMk90SWMreFNkbWtUQTBhcVZJWi9ocmdmbDlVS1dJWklo?=
 =?utf-8?B?NkpHVSt3WFJWTWF1alVmQ3ZQWVJERGs5V0ZlL0J0Z1dOaS85OThaNWVDMk1C?=
 =?utf-8?B?N3VZemxNK2JMSlZMdlRhNVA2elowYnhlOXlYWlVpQTM4cWdiWUVuR0NkUHky?=
 =?utf-8?B?WmVQZ21wKzE3MGpqdDBUZUtBM0VJcmUrMmYveGJhSU53emFBb09mV0VSd3gx?=
 =?utf-8?B?ZDVvT1dqTkJPVzFkQ3dFUHpGMzFPUnYrZXd0N090RmtZa20vRFFxbW5GL0Y4?=
 =?utf-8?B?WlVXbHVzb1d6cVZQd0NMTEtvcFUzZ3g0KzIyT1IwRFExKzFWdU1aeWxiNHMw?=
 =?utf-8?B?dU8zNHdIQmRLb1dUT2tXU0JoZ0RMTlU4MkdUYWUzbTdPUU9jdDl0YUlmeVdS?=
 =?utf-8?B?dzh5L1d3ZllCQ0V4RVkrMDAvQytkdFZ6ZlREa2lQUTlhQ3QxdmNZayswOG0w?=
 =?utf-8?B?Y0Fuc3RiVXJEOCtyckhvQW1ncTdXTnlRd29tMXo1WHlsUEQvRlhtR2UwT0Ny?=
 =?utf-8?B?a3EvbWVMRmkwOXovdmQ1Zk9uclJQQlRHUDVGWFNDcGxhNGsrVy9kb2JwZndH?=
 =?utf-8?B?NUc3eVcyUFV6NUI2NXhSbERVU01OWUU5aUhLaUZhVE1MVzM2K3lIcmt3T0RX?=
 =?utf-8?B?VFVhZ2RHUDlxM2o0RjRYRnRRQlNsRlpXUy9JYTE1T3dUcjB5RU1yWHA1L3A1?=
 =?utf-8?B?cmppQytXSkFJN3ZsM0NYbDQxVFloMStadnhIM3I5bEFPMUs1VHNnZXVZN3VJ?=
 =?utf-8?B?Q0VtNWxOdXRWeE1abnJiNWRyN0FKQUM3QktFY0U1QmhQRUlkaHM1UzdGemJw?=
 =?utf-8?B?aVRqL3c5Tm9COEYySVJTOTlCRU0xaVlvQUx3eHpkc0dPK2tiTEE2RFl6Z0xO?=
 =?utf-8?B?ZnNOcnFqN2YvQzAreWVHR3pFbzhGMmdyd1NZQ1hWVk5mVjBvb29rUEYwTG84?=
 =?utf-8?B?eGYxT0FwTEN3clNGKzVQS2s0MVJtK2RpRklPQU1wUWc1dWJmUkJVTzQ4VS8v?=
 =?utf-8?B?RnZ5K0JzY3FOR1B3MGZER3ZYRTBMZjZkSGxRSlpmM0FqNkl1Rk9obVMzTGpD?=
 =?utf-8?B?SjFuMXVDYnJ3ekhTVzBCZDVFdEc5ekticEo4RXg1VE1rQnZyaSs2LzdpUWo1?=
 =?utf-8?B?dE5DY0VreHZtVXpzdEFHMCtTbU9YbDlwREhaNHV5OHhsZmM5TkRKTE4xd3lE?=
 =?utf-8?B?amhoZ0hPeE52bU5iMWxRWVNsQ0FDYS82bERwbU9mMWEwZE05cU4xQlQxUnZz?=
 =?utf-8?B?YXRtNjZGeWhVaXByY2hzMGpXdGJZVW1xYmtDMzJVS0ZjTGdHSUcrS0F0K1lJ?=
 =?utf-8?B?bzVmdmZ1WS9LVjNDZFZWRHVpSzNsZVRBNmRUdDdVUlZ1YTBYa3ZWSnJIcnR6?=
 =?utf-8?B?QlNYUHBNMFhvN3FhMVN2Nk5wZUxURmF1WGpQYjJuVGdRSG5BZndLY1NVOEFl?=
 =?utf-8?B?VFlXOCtKdTlGRE9qSEVSOVJxUmhKM0JpaGxYeWlXRFF2TTUyMWhDYnc2M0NM?=
 =?utf-8?B?eXZXVEg2TjhWU2FsSVcwdHJiWE51RzhqdkdHdU02dUFMY3kyZE9ZQWdYN1FN?=
 =?utf-8?B?ZzM5MlB0Tk1ibWthZnNYQVBFeHMzbjh1V1lZcy90T3Q5K0V0bXdSVENEanUv?=
 =?utf-8?B?MlRrMiswUTZaTVA2alpONUt1OWtBPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 764a36fd-e938-4036-0a03-08dba318bde5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:04:46.4796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aeF3F1ov50HPuZiiSZqj6EOhyR3tQ7jFf4ktIJQ2jjsnbpYzcYuYqo+6XNAy1bXmeymP9aPcimvJkfm7u+KjFo0Ih8rFVuBPOnqnwsUmfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8161
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
index 8ace2b61..6d48081a 100644
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
@@ -795,6 +818,9 @@ static int netem_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 		close_json_object();
 	}
 
+	if (seed_present)
+		print_u64(PRINT_ANY, "seed", " seed %llu", seed);
+
 	if (rate && rate->rate) {
 		open_json_object("rate");
 		rate64 = rate64 ? : rate->rate;
-- 
2.41.0


