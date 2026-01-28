Return-Path: <netdev+bounces-254292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDltBKAfemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:39:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF9A2F24
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FEDA30AB639
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F235B14B;
	Wed, 28 Jan 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ozAOmJd+"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD2358D34;
	Wed, 28 Jan 2026 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610906; cv=fail; b=jsMfQJL7tPVSFI8QHFBwMMWpkpxXGi6nUZA+BrSVMzvGpvTXkHHCXvWYqBUxfuB5WUZKc3FMvSJqauopR7hAgc1V99wonIh0amyt7XwPF0zJwQB7MPim4MxQCTh/Cp8DlvjL7xY8reqJKyJQOD45jk5qZjFLnzvC1Jvbe05iBSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610906; c=relaxed/simple;
	bh=QqZ2sSxHzjgFcAKiwj4+w5tkya9eBOPEFFRU4aXJ/h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLqpyKdpCuczwl2+ylCjm1fDZl15xq+W7X6nezUqaGOO4PFfIETRURGj9AvmOlVRvsVmXy9BqTBoc4tHYlD2XN+DuQWlXi4H0GrE8GwipvnoZs0QHc+ZsmZW8tD7JhToOz1Tp7k6EDzftuUT7vO3Hz+SXhgXTtvh4x3SOWHtfek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ozAOmJd+; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N233nQ0Ti6D0AHx1XJwjURGp6rBty9ednKv5fqA6SFw5t8mCOLT8k4SD/zh5V/w1RoSsJla2w28SZr7v3BnTku2e+dd5YlWF15AVnWLZ1XsEuOos3S4z3XVVDluoVyHH03rLujtJqgy+RxaduKCN5Gqjc4gbAE0q/OE9WjteYXcDM75PLfqaQrJXlznOfb73zqgwOmt7zGwFaZUlwKYGuzHD1LTi/dUMQzHAuJaGak4m3M6Do1FGflIoEkGyrMvNAfeDtV32RKGfvgrJXbApQ5rITW22HjJcvmKycmNLZ3T0c1z9pyJ1WY1hxZTK37alsqebb2YUJbOUGVmgp4MVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkUE/rrAdLqzHmtqGeXvaURmSlfqGne/WguM0cRwYw0=;
 b=ZOFyC7ljV7wuqA7PTUv3UKcet5JBD1Ge9ZB0AYU2jvXGbUmv+HQHEqINKY28kSDoe3OhCUM98TRAWLEpowv3fjI3aN7kC6IAGUW5Ut0SeO9fwcy4KCjxIBxBu9W/L5AZxTSz+qPs4MN9hK6pntjo7QEzUDg5cFzCF9jrwDqG9jCxyFQun9YUKm5CTxYeKlrPY+EGIKQcyotJvwR+vj0maDnsGhnpCKgKLi9tQ0ejNTvN6TXh43vp9taXK+Apk0Yix4rg8pbYh47rk6eR6iWgjQrKm5LgoLOQXmLyC2Z69qZLezxjZcgA5+I8PWNjIrGGhBtmLgKIlWd4U023Xg2pPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkUE/rrAdLqzHmtqGeXvaURmSlfqGne/WguM0cRwYw0=;
 b=ozAOmJd+3YU1UIo2A9yq8Q0pHxmXOb9iodbMxb4NjDcGPxiARBMxF9FnLklNMrdHrn/pScBWE39+HYTBaevH5WxUwcSH4XERx+N/KRIQ4UTol6+Gjgpia31u4J8g0cXCOtZnSPDhvx1Lsysf/PUBQRJPCXOL2u8jVdvdIyLj1jwTjn1VK2cWXlj5TwWpFMFwk+QDT7///d9cCr1fJw4fB2jlWsop+UiSVYYyUgtKrEwu8pEBy0OWZDZGX9SHVk+8LEtuTCepOpZF1aBJo9XZ8va0UP7rKjM83fz6GZ8rqxYBwypkuM/IPA9D7wUA52QYooztYVzRx00IwE1UGLGkdA==
Received: from AM9P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::28)
 by VI1PR07MB9900.eurprd07.prod.outlook.com (2603:10a6:800:1d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 14:34:56 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:21f:cafe::de) by AM9P195CA0023.outlook.office365.com
 (2603:10a6:20b:21f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:34:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8832423672;
	Wed, 28 Jan 2026 16:34:53 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v12 net-next 08/15] tcp: add TCP_SYNACK_RETRANS synack_type
Date: Wed, 28 Jan 2026 15:34:28 +0100
Message-Id: <20260128143435.15708-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|VI1PR07MB9900:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 015739ac-3bce-4c52-d8bc-08de5e7a67a2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?QRI75CZqd2Uzb/nEuPObjaBT4Q9MvjS1LERnbt9WPTMiwydUU0Ko9R9ZpQCL?=
 =?us-ascii?Q?VhF7GUe/DWITnWlLJe3qh6MadPnW2o/yXsVtdGVDpM4wXCf2m/hVJbXMeMyG?=
 =?us-ascii?Q?aUnxffl4gK2rpMtEW3tkOOe/f1r9NZlKBBX7XnHa3xe1Mf3VL6Aw5dSw1Tlc?=
 =?us-ascii?Q?+KEJUp784NNKyPHn5pTEZ5IWebeh0MQzkmSOc4NpZVbxNhVshSVMB46YvF0x?=
 =?us-ascii?Q?njE2ZjUbxiCiW6oC+KYIu7hdWTucCHgRsPzKomgdztCytr/G5tfkqOPQdVbr?=
 =?us-ascii?Q?fZ96iAVndIIZo3FXY1k2SlGxmmuqj5yAD1l45fQO6+8PU5kgVThqlY08NW3N?=
 =?us-ascii?Q?U91faKuA5J8+ktZfzDTxAKXjs7pjJzEuS5Cf0+J0ma38k+7yved8pdyqjB0W?=
 =?us-ascii?Q?h1hucoXq1cI33rrzfzSQcz1qFXeQEUtddlrFXX+vQNMSLRF+MRHDzBzuEzJQ?=
 =?us-ascii?Q?dJEh6Lads+fnoTUIXhFATiCymBsmcmJdgg0nZNkkTeFmMxzx0sjMzlF2eguP?=
 =?us-ascii?Q?blUlc9O4Zun34OBokr0+iTtv9bF+0ILga8nEj0lXilr9Er8NCoOdg3Ni34SZ?=
 =?us-ascii?Q?Xurm/vsWtL1nmRvOXW39sa/uFy+M3+Vx5fg4IMDzbCZhj480gj93Wq8lRqZy?=
 =?us-ascii?Q?bxTzar7OtRRtIxl4pHwDYyQnYEw6Yi6btWZnD0vb6KSjeeIfVLC7Vxx2Vnvd?=
 =?us-ascii?Q?lSWidxtlgaxDBTYyIfLTj/dI/Sm1mFnSKEvP4NAurs9ZgPidHrVtqIaSpPTq?=
 =?us-ascii?Q?MffagCvOjQlMAYD/Les2Wo3RnzT044nJZVFK77xnwMDJF4udYbCnaAhxFiSi?=
 =?us-ascii?Q?iGuz0CFKinEaWifKuvRhEP5cI43vUiJy2+z6lGc/qDSXK6C7gwcvfqkKSjiT?=
 =?us-ascii?Q?kc/P4ro8hPuOV1JoA/91TbgW/oToo53vhoWUFclluJfozTgEIwDN7EdWFL43?=
 =?us-ascii?Q?D/PyoQWIHWeoY+ELmPOpbujggQ9tMAlPGM5s1aHqV1z9LJ7D0hSri4iHoHrS?=
 =?us-ascii?Q?SuinvIDS4Hc7e0G20KUJTUrnC93GQF64UZ0uIzVC/PmIeZzAUEbkrVnHSZHi?=
 =?us-ascii?Q?0XSQP1LlP695ZyK7ogPZ3t++tT1P2jDrl5+wLBZC3Vb6iq6ueDK4d78Lc9Rs?=
 =?us-ascii?Q?wNr3fGVYAXzG2IIOlE2kKs5moUli7uW6plpgSPfwbuwVrKi+lRDzx5c6C3q8?=
 =?us-ascii?Q?GeK4DWiqskpisbR/wsEocxUULcqJN5sf9BmJmurdd1bsKukLHiUzpfI40xtR?=
 =?us-ascii?Q?F/HfC3hv7Hy+ATniQDOF+F7Q7HndlPoILHKxp1yBUVha6seSrLboYXRULUfI?=
 =?us-ascii?Q?gSF+akS61dpBsd9doB4C1L6zhoNdq/hfMlL0cy3dmN/wxUuK8DXtZUwqYOfn?=
 =?us-ascii?Q?+R9u19AAMpd39H4yHF32IaYwlljtSBE/aMDlo42qtJOjthV/cD8LvIr+UQmF?=
 =?us-ascii?Q?BzKzVmHLwiaCReNIPesLh68cgjCxyYF43x0NjdvIdUu/j1FXUvEQo1d+tsAs?=
 =?us-ascii?Q?3A/SagFSqp65Lv6oYayJP3DvA7fO4kiMJ8dXqn2sySVFs4K9tN7BKsuptT04?=
 =?us-ascii?Q?B0pdXdk0CEh+v3n0lfglORp5I9TEQRtvm5T6q+B+6QypfhcMyjGsJlSNosUr?=
 =?us-ascii?Q?mZV4Sbk5fuEk7A6tpfHG5bEA7zHtHiMeVNx/2Hn/xuG+xAZiF6qPu4DE/jpN?=
 =?us-ascii?Q?SCzNXNDklMUSnhBiF6wHUee1iPY=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 +9JsvL9t4c8m5J5MHobS0N2GhLwuK4/7b4VUBO13YRIO4EqLGCPKOOhWr1vBayCkhmfLB4dp+aQllrL496GoQMY950BFr7rhXhHAvNJBeD+gIn1gvA52SYsDa7wIJH39/iAAKJPbvXXS3pck4+NsoJbMu3Ck8PApLyZ5pq0Q7ifYotlBRputPfiBYas9wEuqL3yUB1l2GdJYz3emv4vJIbgP38WxRj4zOYvBdEBTn0ocRnxGN5GtG8MBhnTMe+Z7LmV8iatVAEz9HSiF9IOYRPUmChPBYPK5YxRPFJuFnvS7C+c/dZOyHEBKEiaclWdRKr1A4zw6ici6E3h5G/AJNsZZWvju4hs1TjQmWc1+ZvS9qveDGN0w8JLw6WbuxaJVVc9HiDMzF1Wkf2ZWF/KQCi4zTyuEl0snNMBLfCvZ6J3D5Cwgyd/hZZTAspT0uHh1
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:55.0219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015739ac-3bce-4c52-d8bc-08de5e7a67a2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9900
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254292-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AADF9A2F24
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, retransmitted SYN/ACK did not have a specific
synack_type; however, the upcoming patch needs to distinguish between
retransmitted and non-retransmitted SYN/ACK for AccECN negotiation to
transmit the fallback SYN/ACK during AccECN negotiation. Therefore, this
patch introduces a new synack_type (TCP_SYNACK_RETRANS).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v6:
- Add new synack_type instead of moving the increment of num_retran.
---
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_output.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7965d4bfb4d7..1ef0450ecc2a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -541,6 +541,7 @@ enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
 	TCP_SYNACK_COOKIE,
+	TCP_SYNACK_RETRANS,
 };
 struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 				struct request_sock *req,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b28596655d73..a1596fe8dd9f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3929,6 +3929,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
+	case TCP_SYNACK_RETRANS:
 		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
@@ -4614,7 +4615,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
-	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
+	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_RETRANS,
 				  NULL);
 	if (!res) {
 		TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
-- 
2.34.1


