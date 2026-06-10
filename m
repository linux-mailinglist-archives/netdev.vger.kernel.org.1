Return-Path: <netdev+bounces-297571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+GbFAQ1KWp0SQMAu9opvQ
	(envelope-from <netdev+bounces-297571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B16680D2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:57:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=HWg6YOcQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297571-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297571-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6FE31C012C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A63E3C49;
	Wed, 10 Jun 2026 09:46:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71153DD86D;
	Wed, 10 Jun 2026 09:46:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084793; cv=fail; b=IHl41+3WRQUEREJHgZd+EpXksDv5KMKlq1zrNoXgVR8Nw3UtknXHiOJYJR1JXY5v05RTHZBcgPAywgm6BsPbfW6rt5ppwQwL+jvIhZFYYIHssI3oW61dOyYw064xF4vFFU+5O1Y64k8Vqn0eH36EebxGee0pRgToo3l6lpEry+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084793; c=relaxed/simple;
	bh=qiR1xXDm2HyKs7/PIx28Y5NxVO19U3cg/APRvORnChE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGLIo0mVWfH47pIAAQuArBP0H6L59PC/zX1DMd0nckvKvAurhby+StAzbzOSjNW+efTE1iDCVDwUuHqoWCBzVs2KpLs7VS5OJMK7IE8PIi2OJUjoYEXtwKelPsvj0Py/R45QNESk7TZ4MBbH9a6QDtsN9WnUG8e950r684MyqVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HWg6YOcQ; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPeZYPRilvN3LN2WjdXAaJ0g1WhYZn0knEnyInwa7HszfsQLTFfMTFBk/NkmzoJH7hmu0ptOi+dMvwflEphkN5q6VLsMUCVXX2IafZoali3a5BUtysaR0UTuJ2RL79FTyFE37fNUefQFtoGnDxKSgsQ4sFVitSxNregBSHS6B6lNBgGnXdFI6wbanSR5QdhYpH/3z7HT+Sss1dQbAK4SrcO5mxyuHejpfkSJFx/uo8PUpH4Uw6o+S8yqrgaj9ZzHYMRjUumaoNDgYDfgpagCk6Z8+k1maqj81iaa+xARHpdNW6GXquBgqKHolpDiHtrjLyNLu/ZHyu4xmq9V6kFx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeIYabRarpZr0qQu6tvVI99vPDCE6mufirrkCdvPgXU=;
 b=Wm+9hn8hLMjDSRsIJcD96dp/dtcyOtocOqWmhrGsUs7LEHBsftR0MCbYqZQXMb/FVy4D9SOjov7rBDPVknQv44rh213nd5/6gpR7UkVL+rZsWQCBHUfpsXY/CmD6gl6j4rfxLiiq8bIq7e9CKjF7ffvb2KEi4Z01rQSkFEbV2QubKk9eFdvkFk6UWIDLbggdu54ncOmpYWv8fHF7vKWxMq8PGDR9O1jRPn0dvwY24UY1PMmbNQzZ0ahr3LuSOiQJI3hd+WzCf4KxUkriP1BzPrN5of+Wdku+BNEYbKde/rJieNwceXHshdcVUao+ZBT/aeIXzV9RoNvPRShi+V9Hkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeIYabRarpZr0qQu6tvVI99vPDCE6mufirrkCdvPgXU=;
 b=HWg6YOcQAApfe6D2Ky4NSmGdopaM992qU4+XEIRlWepGlSP6YZ4CcH6E8gz/zker/MT9PeWgZ2I+X+oBudrbGaks1GUhRpGQSo98jIHEeJ0/x2Q9yhlk0gVWEnsLRTy2pgybPTZkCoMJiweitQdfhp8PkNd5u3v0Q2Ko1f4K6BmuJNVSXnpSSPBL9aVptcrZ3JRfFr3SwcwUJfgxmcn/bfxtcLqtxhA59a9spIXqAN0JIWvZnRfd7F/jHsr9k7rijkEj+ExY2RxikLVoWos7NQLUbsv/HC2ngt5BkcN9o1YXkdw0c8yfspyOg9gXY8uSUiPURZAfpHmWTtgGp54j/A==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:23 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:23 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 04/15] net: enetc: add link speed message support to PF driver
Date: Wed, 10 Jun 2026 17:18:33 +0800
Message-Id: <20260610091844.3423693-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 58df379d-fe3b-4722-aaea-08dec6d521b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|921020|18002099003|22082099003|21046099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	GG6VhCXUldlRSXpWrgBQn1dTW7qYivA9Z6l23iwkRYLF+qo6KbUPAd02vOUEBQyN0dbBKqm3dcCcSBiiTuN14kOc7fgjJPOr8QBuuwaUeALg2ye0959oj2OrAgjyN0a4a82oKB2yitTKlTACVDjy6oPYTERc1ls+2U0E7bY9yknILxmQgnvdNROor3Z4zMRBk9DADJNoYnfhgrgslU5riXiFekPgKGZJB2zdOyJ4pd87tZIpEI1539XG6FmfQjJrqp86lrSuKwOpHAyRT9697j06RUWnWqZ7EeD6eu4sYL9GDwx2kR64H32EwJs2EQs9NBw0Sfa4ayY5nVYYNNQz85r+t5g1v9dsd+Pqy4gSL0g3Abc32O7+KlbR7nP76t16kpTZmW2hstOZg9aeZmIAzoMaDDGBETxEMpJBNLGAuH8ouLBr6+YkEx7xH0HTBQqidLbdeINfWIYwNOFwmnpRASexiKHaU4dQ1L/xzNiAEiPTAtTV/pZ9mVsb4CkhzEQHHWPm1YMnWwtO94fU7tytBa46mtvihVhvirZmLVSXlzXNk9Dz5PGEyEKpL+3IJgs1qpwMGPH23nwMH5jwo2rEnrmhvt1LKCPksYy0zOAiYtBl6MwAfzsKlqDbgA6rQcF7Xb6Z/Zbxm1pnku2vVRvQHdO3cwL8fU4jezaO70ErJg5U5WLmFnPSbVa6B1YmrITthmJGVoJzbNRRIcWtimPsfy4lIFTTrV8kIQP7aq3Mde8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(22082099003)(21046099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4shJbnN0kpMyJeWPap+xj8lYozyJilnL+WlgBvcdqZ2VO1Heqcuy8ARzdWD?=
 =?us-ascii?Q?yvGricCW5gJNEFUQ5mN1oBoAn5EvxiRnxPtICm35x6ej8EXWgTT14z/9WHWy?=
 =?us-ascii?Q?e0nE1jaRhltf202xnlqIrpxGPeDNaOJ5ljpGavUKjrnGMoQpkrF8fi9ECxDP?=
 =?us-ascii?Q?aGy5vHq/H1VfPxQVKkMqHveE1tHUCHFcIWS+9kBKc/MEK15vQnVxHpPFENZ2?=
 =?us-ascii?Q?fGMTzYsa/N3cS14XxsKN6Ef3DybSIxE88ZPDcjqVxIi17TFK7wnEsJzK3dUp?=
 =?us-ascii?Q?3DSVa9n0vXJzBVl5UbgCo6U9IdDxoeNFaVMICOJAhDTKHledOLzh166v3Ez7?=
 =?us-ascii?Q?9oOhNzttDBcA7UDmcYi+Hcq+pg8+mJswbueubOj7HADo4TetaOewraMGrFZw?=
 =?us-ascii?Q?2racb9z8VcuZjEY6t0asCywSwQqx9k0GVvJJGw1Z+Kh/6FRFZpdG0M9J6O6g?=
 =?us-ascii?Q?MONL+6qU1b+ly/zBnxIs5kxRmal+Tk+Hxs/9JLZ+yUrP5+7glKTrOjE4vbZG?=
 =?us-ascii?Q?EpYwRLFcHZdP0RGKrT3CAm5SC5JUtcHN7moAIwXPAbIZvv7viiJepPHYxHC/?=
 =?us-ascii?Q?e0lEpTdwI1uQdj6JqwI0RrW8f9HPzwIiE3j94CbtYTl3AX38n4/9pRGywPtY?=
 =?us-ascii?Q?bGeQ/Vz6jT46i8OTbN7/Lb8RrSVfFOVwTC0dnAQ6dK47IJNCKYfTMv9mlyC7?=
 =?us-ascii?Q?n2IoLr/Fst1CvVtELetvE2/FeZ5ylRFWj8od5BjdowDvGf73nroYApU+Scpk?=
 =?us-ascii?Q?+c9ts4uKyKKLMfxdmN22rWSeSDzcX+CPPcIA6cN3o12lhDYGAE+BTLx9cVUP?=
 =?us-ascii?Q?SXzW3ZTxGRno1djLGgoV0eAn/HTOoFIHpwxupLgHGFT43OixhmxLsbKab1Pr?=
 =?us-ascii?Q?uDi1fPbjyKTgPHhkvRHUNnmA6/qQCOSDYuNSSvSlmp/kZuF02FcqPt8svpGb?=
 =?us-ascii?Q?hbOSAAncLmSSV3egXWTwhDrPK7NooklpLjuLWgLR4AIlJFPQMljt5e2EvSuK?=
 =?us-ascii?Q?hMGhdYyMhf9lndjo3m6hBO6oL7mlgJrupiWR0eTjFtEIse9Vma9CdXajSSPQ?=
 =?us-ascii?Q?mlFBOoFH8dfrzcaoJrjoZ6tOC0HxXnGT+vev90GSnRDgWs06kJpg+5qCH0D0?=
 =?us-ascii?Q?o08EvWXjJ2PnEoDyPQS1Ar3HIR1mynkwLxVMjsRwk3Sg0eIa1FdZQfmmtivi?=
 =?us-ascii?Q?cBdLpWNbNna3NrSnENBFoKP9a1lNglF2pxaui6q2qfxPcpH2S6FpnroXTHVL?=
 =?us-ascii?Q?9aEZP3yBXAb2ahtbzxjKr6y2zKmmvJzm9ZlPqk83AKDM5uVGfLM3CCXT7DGe?=
 =?us-ascii?Q?BFtKqXCF4cctJBZ2XuvXpXJPxrZT7pw7niUign2zs6M4urDeE66CLbJfHfRh?=
 =?us-ascii?Q?rFTCw7vS0mUGDjSp/jDzQgODg89gAW8H1pcsalOxZ2SwVxiQXr8Eyfq9y3DW?=
 =?us-ascii?Q?qU//3hOmiyhzQZIZFSLngNTecB8cknbhBNLYVEUj0ruVDo0+cMld0Zuzk+wA?=
 =?us-ascii?Q?CvTh/as6Opq57us4wYGGuNOTcmZkc09GzJeGLDHU9zhKMGXqACyJ/aoQTbU2?=
 =?us-ascii?Q?oWVTcEFPRLUkI+q/TsOEdrypko4/l2SeuZTtS8ALjWppTnwBjGWqSRx7ot91?=
 =?us-ascii?Q?NZTYy6TOnI0tbkOFTe7F7TTPfkqpMwmXUcFUdb20ZVBOuYr+ohbmQz+Z37Ep?=
 =?us-ascii?Q?uAH8fBz0iNwQD/hT+gq+/ds/pIf3OvrfkgMFLD5+zpF6t+IQIfRqUkkOP7wM?=
 =?us-ascii?Q?VMI8tGq+Ofb3JxvCU9ry77rDJLK/L3LxTPqF7HKSqErFL5qCDNJv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58df379d-fe3b-4722-aaea-08dec6d521b3
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:23.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVIF0plJPCX1jpskymhqBuGZQkFzOHUe28qXkUQEKaHN/rA/Kwcqad+gdzMMe0sSgeL6JFd9ZL6/twpxn8w/3DT1KdQJjnaH19PPpeZueQ9ur64fZWXUX0+vl9H4uIQk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297571-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD1B16680D2

From: Wei Fang <wei.fang@nxp.com>

When a VF is driven by DPDK, the VF relies on the PF to provide accurate
link speed information so that the VF-side user space application can
make correct forwarding and configuration decisions.

Therefore, add link speed message support for DPDK-owned VF. The PF will
reply the current link speed when it receives the get link speed message
from VF.

With this enhancement, VFs controlled by DPDK can obtain real-time link
speed information from the PF, improving overall link state visibility,
synchronization between PF/VF, and enabling more accurate performance
adjustments in VF-side applications.

Note that currently the link speed change notification is not supported.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 30 +++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 85 +++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 43b9ee2ab3e4..46446330e222 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -108,6 +108,7 @@ enum enetc_msg_class_id {
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
 	ENETC_MSG_CLASS_ID_LINK_STATUS		= 0x80,
+	ENETC_MSG_CLASS_ID_LINK_SPEED		= 0x81,
 	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
@@ -125,6 +126,13 @@ enum enetc_msg_link_status_cmd_id {
 	ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER,
 };
 
+enum enetc_msg_link_speed_cmd_id {
+	ENETC_MSG_GET_CURRENT_LINK_SPEED,
+	/* The following command IDs are not currently supported */
+	ENETC_MSG_REGISTER_SPEED_CHANGE_NOTIFIER,
+	ENETC_MSG_UNREGISTER_SPEED_CHANGE_NOTIFIER,
+};
+
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
@@ -136,6 +144,23 @@ enum enetc_link_status_class_code {
 	ENETC_LINK_STATUS_CLASS_CODE_DOWN,
 };
 
+/* Class-specific notifications/codes of link speed */
+enum enetc_link_speed_class_code {
+	ENETC_MSG_SPEED_UNKNOWN,
+	ENETC_MSG_SPEED_10M_HD,
+	ENETC_MSG_SPEED_10M_FD,
+	ENETC_MSG_SPEED_100M_HD,
+	ENETC_MSG_SPEED_100M_FD,
+	ENETC_MSG_SPEED_1000M,
+	ENETC_MSG_SPEED_2500M,
+	ENETC_MSG_SPEED_5G,
+	ENETC_MSG_SPEED_10G,
+	ENETC_MSG_SPEED_25G,
+	ENETC_MSG_SPEED_40G,
+	ENETC_MSG_SPEED_50G,
+	ENETC_MSG_SPEED_100G,
+};
+
 struct enetc_msg_swbd {
 	void *vaddr;
 	dma_addr_t dma;
@@ -179,6 +204,11 @@ struct enetc_msg_mac_exact_filter {
  * cmd_id 0x0: get the current link status
  * cmd_id 0x1: register link status change notification
  * cmd_id 0x2: unregister link status change notification
+ *
+ * Link speed message, class_id 0x81.
+ * cmd_id 0x0: get the current link speed.
+ * cmd_id 0x1: register link speed change notification, not supported yet
+ * cmd_id 0x2: unregister link speed change notification, not supported yet
  */
 struct enetc_msg_generic {
 	struct enetc_msg_header hdr;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index eac71f90d80b..b24903b23a61 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -9,6 +9,9 @@
 					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
 #define ENETC_PF_MSG_PERM_DENY	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
 					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
+#define ENETC_PF_MSG_SPEED(s)	(FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					    ENETC_MSG_CLASS_ID_LINK_SPEED) | \
+				 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (s)))
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -274,6 +277,84 @@ static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
 	}
 }
 
+static u16 enetc_msg_get_link_speed(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct ethtool_link_ksettings link_info = {};
+
+	/* A malicious or malfunctioning VM could potentially spam these
+	 * messages in a tight loop causing global rtnl_lock contention,
+	 * which may severely starve other processes on the host that
+	 * require rtnl_lock for routine network configuration, resulting
+	 * in a system-wide control-plane denial of service. Therefore,
+	 * we expect the VF query for link speed to be trusted. There's no
+	 * need to consider the transition from trusted to untrusted here,
+	 * as this won't cause rntl_lock() to be called frequently.
+	 */
+	mutex_lock(&vf_state->lock);
+	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		mutex_unlock(&vf_state->lock);
+
+		return ENETC_PF_MSG_PERM_DENY;
+	}
+	mutex_unlock(&vf_state->lock);
+
+	rtnl_lock();
+	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
+	rtnl_unlock();
+
+	switch (link_info.base.speed) {
+	case SPEED_10:
+		if (link_info.base.duplex == DUPLEX_HALF)
+			return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_10M_HD);
+		else if (link_info.base.duplex == DUPLEX_FULL)
+			return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_10M_FD);
+		else
+			return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_UNKNOWN);
+	case SPEED_100:
+		if (link_info.base.duplex == DUPLEX_HALF)
+			return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_100M_HD);
+		else if (link_info.base.duplex == DUPLEX_FULL)
+			return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_100M_FD);
+		else
+			return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_UNKNOWN);
+	case SPEED_1000:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_1000M);
+	case SPEED_2500:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_2500M);
+	case SPEED_5000:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_5G);
+	case SPEED_10000:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_10G);
+	case SPEED_25000:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_25G);
+	case SPEED_40000:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_40G);
+	case SPEED_50000:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_50G);
+	case SPEED_100000:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_100G);
+	default:
+		return ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_UNKNOWN);
+	}
+}
+
+static u16 enetc_msg_handle_link_speed(struct enetc_pf *pf, int vf_id,
+				       void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_CURRENT_LINK_SPEED:
+		return enetc_msg_get_link_speed(pf, vf_id);
+	case ENETC_MSG_REGISTER_SPEED_CHANGE_NOTIFIER:
+	case ENETC_MSG_UNREGISTER_SPEED_CHANGE_NOTIFIER:
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
+}
+
 /* If *pf_msg is set to 0, it means that PF has responded to VF in
  * enetc_msg_handle_rxmsg() through enetc_pf_reply_msg(), which also
  * clears the corresponding VF MR bit in PSIIDR.
@@ -356,6 +437,9 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	case ENETC_MSG_CLASS_ID_LINK_STATUS:
 		*pf_msg = enetc_msg_handle_link_status(pf, vf_id, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_LINK_SPEED:
+		*pf_msg = enetc_msg_handle_link_speed(pf, vf_id, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
@@ -540,6 +624,7 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
 			goto err_en_sriov;
 		}
+
 	}
 
 	return num_vfs;
-- 
2.34.1


