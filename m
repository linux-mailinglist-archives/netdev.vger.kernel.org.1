Return-Path: <netdev+bounces-175930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE7A68006
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B962D8811CB
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0DB20765F;
	Tue, 18 Mar 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="mk2tHaS7";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="Rrwnuhat"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C5212F98
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338246; cv=fail; b=JpJqW+692RlzCK8z9YoXyjENxht+eUHIaMTxBsMiT6nO76EFfWCMQerPKnGxbUOctTuP8DSJG3WLhp9/1vs/5q9k7ffBNJgor3tQgTQNJB6AZWZQLv8W3U1gLwFBa8lo1OQphRdOWRiE3URpybDyhtnmYGkTA7jDwFrbxpbdvJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338246; c=relaxed/simple;
	bh=IOb6Wx4jqm3QvTSaXLKIsjyr6nJaNivnrWQtG3da/BA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJHrYRHqaa14LBfdLSWhZqvGKEfD5mYvramFHNKs2YmJHEO37q7vY3yqW74JBARl+9cpdCZbHm9pS9noN4hW12LSxWAF2xjpI/+uh8UcdRuHg3NzZHZO2kmbTDjEmCJaYGZkZFEVtPZjVqQTTG+H95eDbCaOHteQwouip8W/EQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=mk2tHaS7; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=Rrwnuhat; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ILtRCh031942;
	Tue, 18 Mar 2025 17:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=6rqjl
	1mUKmyyVqe05hV9nE2s/KTrpj5+OVuMxR89bsU=; b=mk2tHaS7/UT4yXLOExhDJ
	0nrJfZvbpopkPoRU7CukkgHzuZrJ35pthE7YbWQ+cxVUIBiY0ZqumlR/r+nIPwbU
	E8eEFHb34ZEh+wHFr1/QE3rShQ6zmTL4SwLTXhGdwkGcmsBIojwrwNOlEyjoy+p5
	/jXkc+twuKua6fFYkNr9Dh6yZy7S3cWCQ9K7VGenef6cWfjtailwUOsIMsW5H4Lg
	9fhoSWWzjMSPDYY6MLuMifbVk11fJsDU5/wvI+aPhWA9+CKeFdttLiQq1WGhSCyq
	7ico8XGQQtgakoPed4V/fQ0r7HksWW0ek5Vyk5zesZZwZ98LSbrwoDSI/yfwB0Wy
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012055.outbound.protection.outlook.com [40.93.20.55])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45fc11rmk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 17:50:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxFOMr7s+R5dZdMbrpwt/Hz4EXZMb2vDG1QGuynYHyLp7VjPwACNtd9/AtUlnlCQ+MltLS17kPipdDv5Rqqri6EL3rvHbojskG3PgeMM3Rez4hyHrxqGX2TerMMVqANaEJBqLxAeukTPlE6kzEwd6uRWSb/MgdIcEF7gA/KBKryZMdqzh06LIzdXVO8sC07VsZQ04h46g6U5+ZhGSgXCCfwee29D15S8i2Y2OmFtg3s+ST9zzjpkAt6upa7oebAxjHo8cB8kMk74p+az1tkH+CmR2Q23DL80VkiwG0xC9V+Y+D3RDSoRkmXzvUvC52KOmFj0ELUDw75hl+FKWDcUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rqjl1mUKmyyVqe05hV9nE2s/KTrpj5+OVuMxR89bsU=;
 b=iCyYr7ga3LzHohH2UdtVcYnUYC2ZOoq/1GRjc+j5FcNDodJZZTHTsRCoK5shQYz/iFi7iZylodbuIUioAf1OIjo8C6yS/97kRHnJJBArzs47kuKu04a6sppM+qNrU4e7rh4ZH0yI6n966xnpZxkC0mMWzPZsDd8H4BGWkNxvqllQvBlTOy49qrGua7bMMLbxRv41AW6jGTiwKStN/peID3g8o0wEo0T8sjP286jJQL+Z/u9N96c1lZR50yz4unL6GMd9H6bjAi6g4MM5cbmcmfDhnJixjtp7Krwiw/yrPbg7jLMSqp35VPTZ1s6m9JD6/3U4TmO7Z4+cvWQwWWYSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rqjl1mUKmyyVqe05hV9nE2s/KTrpj5+OVuMxR89bsU=;
 b=RrwnuhatDGCJd/xToOYCNXCiOR6XI8HVjNhXahTa+MegMXiFLjvo/MZnAxa3yXt9ZDhq7wOgI41qBO8rFmAA3kqDaGUSAw17dFLk6DGffFKUQ1XlHxM+5sz9WkGZrZQFiZJjRE83UdwayUxGYeX8ciYXIJ789BEKgEw/hJZm5SZO+Rwn/7EiIf/r24cm0GKv8sIl6oeA7Nl99HAy2odMaOxoSJqBg0kY+y/e3oWA+2tS5Z6DWSWs2CvuoECnOje9Vi5cB7lGx4GUasT5nmHkz1ozPaTggZKOzx9fQf4NJ8YEjrDmWjPT2gO//WBmltyPtjzldvI6zQhX0YZFAv4TxA==
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by PH0PR04MB7493.namprd04.prod.outlook.com (2603:10b6:510:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 22:50:39 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::49) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Tue,
 18 Mar 2025 22:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 22:50:38 +0000
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 17:50:31 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Tue, 18 Mar 2025 17:50:33 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Mar 2025 17:50:32 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 17:50:32 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>
Subject: [RFC iproute2-next 2/2] ip: link: Support mdb_notify_on_flag_change knob
Date: Tue, 18 Mar 2025 18:50:26 -0400
Message-ID: <20250318225026.145501-3-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318225026.145501-1-Joseph.Huang@garmin.com>
References: <20250318225026.145501-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|PH0PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca603a5-e919-4957-2d1a-08dd666f4d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ng3tPF7jqgUKZS4dtg9MqLGbgDHbQa54JPeWEECpSBPEH+6IJyFro2MXW6U5?=
 =?us-ascii?Q?JSoxcTwVvduNMOPqStaUqg65GkhtmJHmywernF+IUsphXZ/w/2w3fDbnzOV0?=
 =?us-ascii?Q?kdrawwSxQWm8ANCnBqw9pni9scHdxav6C9/Gf2/B2XodjMA5z3Yu3ncUpXhh?=
 =?us-ascii?Q?sT6icFG+bcpWzH/+HFyb0jLHrv0MVX4mfTYAX73rIh1IaAj2oQngx70s24c9?=
 =?us-ascii?Q?RR44Wbr183HpPQMPJKDFqMQ8EZ9uL9VvqcmgUTiHvtSuTV23j3MUPoC6sYko?=
 =?us-ascii?Q?Cq8vKAejiohZAsaLf4AnMunGzrZWbrfc0/F2memcql82PIDEZ6ZcnQDGy15r?=
 =?us-ascii?Q?nh48cl+d1frR0+thLPyGytR+WpgPnEr61eF4+HUwp/KLsuZ4d0tHwEvHh97x?=
 =?us-ascii?Q?Z8c8vL7MLatuT04UnZeIztNizU3yAQGNaFu5LiFG6hysT5E3N3KmrKDCti5Q?=
 =?us-ascii?Q?tXMYmBU5HkijJf7eZ6prj2hYb4+mt+1jVZX2Uofnuibq3tcRAPQjDMpj8ggf?=
 =?us-ascii?Q?lk4RS3z65AemVlXr6c7FRE8e+GQN6n4fOylN3PKus88tkoyonlwKq6yyK3YL?=
 =?us-ascii?Q?/jn7An1ib0aJRH8i0VlM80jINkrCduLA0H2O/M8DcOFPS9EK9tVdg1q1y/4X?=
 =?us-ascii?Q?tIeI1Gb+gM2WLhzDcJco6Ywz2FEPmHr9o/E6P7ytLMD4EpVRXl8dECtg+ND4?=
 =?us-ascii?Q?JGv3M0NI9vmcltCBxVUzDMjokQDSSGUDpAQTXafRfU5f+wWV4aIeq7uRRx4Y?=
 =?us-ascii?Q?TnmDUptURj9A7bx0K0ZaidH3zeOtB3tI+1ymQOFCdh0ZWYHUFeQx97gczAA4?=
 =?us-ascii?Q?1SdGK10LiyFavxyeh8/lp7BKpmnJzKVOfsiko+8hLS/gyLzDI+2lQu6sH0uf?=
 =?us-ascii?Q?+A8N3MrpbTfIH8jO4dOCi21EoA/ujT7eCFT9a4xKmnxuFRx6BRFoKAdBeMUq?=
 =?us-ascii?Q?6XgcTJIH3XLAgwRz6kLJem/Tf/pR8RqQXOeAbpEdtyWwVBeNbAka4AHBAqOR?=
 =?us-ascii?Q?b7JjzkAWLErSPhxT76Ct5Vu3eKPG0aohjAGAf5wGjfuQwCvPtkD3g+XvgMkJ?=
 =?us-ascii?Q?gM3JGuKLaqDGxP2QWaJ9OXDYvCjnpFu3GSAzSErhszkIczyhpJpM1CDWk1sO?=
 =?us-ascii?Q?xkjk+dP6YWumQ8oq/hEZiyKLlNWlMoFwMb2No3aCSOMsUfRa7+LAYmmKtDEA?=
 =?us-ascii?Q?BI61kNjJU22dKgQFFvWCPtZnSJb8F3DBsAHtnHs0a0whnM6iNbHRmuZOw/Vc?=
 =?us-ascii?Q?zThlunLqgFiGxbwwL961aMOcSCF8tSo7Ijeld7o8MzjGfePlCq8ApIXLgqVh?=
 =?us-ascii?Q?/7XhwcSvV73+VWF7EcrOLgWYRV2U/X3ivPz1abSIUGBYLLW5wmqLbmXib9kv?=
 =?us-ascii?Q?i8PyM6GkyY7CkezMoRpAR5sFX/811Q3gO862vgjQTOX7JAh6zD946D5mt1EG?=
 =?us-ascii?Q?5ukk7XjZ8PocyFrW5jy9foXnw3ehf4W73Cllq078xGUG/R6PjD7o2vE8Ip9p?=
 =?us-ascii?Q?/5K4iuFLHVUBvXk=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:50:38.4006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca603a5-e919-4957-2d1a-08dd666f4d96
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7493
X-Proofpoint-ORIG-GUID: ttaSLnKdKcoJW4L-veJgzHRSC8-jyExu
X-Authority-Analysis: v=2.4 cv=A7FsP7WG c=1 sm=1 tr=0 ts=67d9f8c3 cx=c_pps a=qdevHIbYfAzI1c5gbp2lUA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=ulV1-np_jjjgYyqnrH4A:9 cc=ntf
X-Proofpoint-GUID: ttaSLnKdKcoJW4L-veJgzHRSC8-jyExu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1031 mlxlogscore=975
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503180165

Add support for manipulating the new mdb_notify_on_flag_change knob
of a bridge. This knob is used to control how the bridge shall notify
use space about mdb flag changes:

0 - the bridge will not notify user space about MDB flag change
1 - the bridge will notify user space about flag change if either
    MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
2 - the bridge will notify user space about flag change only if
    MDB_PG_FLAGS_OFFLOAD_FAILED has changed

The default value is 0.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 ip/iplink_bridge.c    | 15 +++++++++++++++
 man/man8/ip-link.8.in | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 1fe89551..fd8f2669 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -62,6 +62,7 @@ static void print_explain(FILE *f)
 		"		  [ nf_call_iptables NF_CALL_IPTABLES ]\n"
 		"		  [ nf_call_ip6tables NF_CALL_IP6TABLES ]\n"
 		"		  [ nf_call_arptables NF_CALL_ARPTABLES ]\n"
+		"		  [ mdb_notify_on_flag_change NOTIFY_ON_FLAG_CHANGE ]\n"
 		"\n"
 		"Where: VLAN_PROTOCOL := { 802.1Q | 802.1ad }\n"
 	);
@@ -413,6 +414,14 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			addattr8(n, 1024, IFLA_BR_NF_CALL_ARPTABLES,
 				 nf_call_arpt);
+		} else if (matches(*argv, "mdb_notify_on_flag_change") == 0) {
+			__u8 mdb_notify_on_flag_change;
+
+			NEXT_ARG();
+			if (get_u8(&mdb_notify_on_flag_change, *argv, 0))
+				invarg("invalid mdb_notify_on_flag_change", *argv);
+			addattr8(n, 1024, IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE,
+				  mdb_notify_on_flag_change);
 		} else if (matches(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -815,6 +824,12 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "nf_call_arptables",
 			   "nf_call_arptables %u ",
 			   rta_getattr_u8(tb[IFLA_BR_NF_CALL_ARPTABLES]));
+
+	if (tb[IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE])
+		print_uint(PRINT_ANY,
+			   "mdb_notify_on_flag_change",
+			   "mdb_notify_on_flag_change %u ",
+			   rta_getattr_u8(tb[IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE]));
 }
 
 static void bridge_print_help(struct link_util *lu, int argc, char **argv,
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index efb62481..2f8bc354 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1753,6 +1753,8 @@ the following additional arguments are supported:
 .BI nf_call_ip6tables " NF_CALL_IP6TABLES "
 ] [
 .BI nf_call_arptables " NF_CALL_ARPTABLES "
+] [
+.BI mdb_notify_on_flag_change " MDB_NOTIFY_ON_FLAG_CHANGE "
 ]
 
 .in +8
@@ -1977,6 +1979,23 @@ or disable
 .RI ( NF_CALL_ARPTABLES " == 0) "
 arptables hooks on the bridge.
 
+.BI mdb_notify_on_flag_change " MDB_NOTIFY_ON_FLAG_CHANGE "
+- set how the bridge notifies user space about MDB flag changes.
+.I MDB_NOTIFY_ON_FLAG_CHANGE
+is an integer value having the following meaning:
+.in +8
+.sp
+.B 0
+- do not notify user space about MDB flag change
+
+.B 1
+- notify user space if either offload flag or offload failed flag
+has changed
+
+.B 2
+- notify user space only if offload failed flag has changed
+.in -8
+
 
 .in -8
 
-- 
2.49.0


