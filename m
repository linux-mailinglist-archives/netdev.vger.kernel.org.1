Return-Path: <netdev+bounces-297573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J6nyHlQ1KWp/SQMAu9opvQ
	(envelope-from <netdev+bounces-297573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF87A6680FF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:58:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=UCXDEksv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297573-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297573-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943D130C28EE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA373E317D;
	Wed, 10 Jun 2026 09:46:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C13A7F45;
	Wed, 10 Jun 2026 09:46:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084801; cv=fail; b=JlIjQdrLWLlqbJaIZ9dAU3ZdXodZS60OKl1AhbMNCG9Hc2Vt0I15BrKHMoLqCz4toQfWTZwf2nW9zBtwDiQO2s4oB6Ya3wYKmMN4nv4wsMpM3+lgnnJbc4gEtvLTRRHEAL11r1NgO+m7kyIBU76bzmdwimt/0BY5qhUnvxsCaxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084801; c=relaxed/simple;
	bh=XxeZ/6ouPCrMIRkwxX+wcjp3LtI1/BIFTmRcB7sItyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iG1xUabdRHYgMHidvWnlSMJ53Rvoi9ArvTGKw/QUQMChrCfeR9C5pPvnB8PpnpdV3L67gxtTkPBqZb2S3fotONxzIyzYSwWlH86AVxoCJvX/AnP2QoCXmYzyliM7DFkU8pS+/58N3JvqL1IbzOs4yzkeLY8d5KAOaDbFI3x2M9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UCXDEksv; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPC3BBWQIy7mafygar5axmF6pobvvluLj3aMtYafWH9LVOAiSaGSkIR54HKQ5sl3YaAatGV5Zfaf26cqiu3vt9OMej815y42IXad7+/KXSqBwpUApqyNUnOTeKime7vhSNJkK9F6LFcSWlwS64InCY5UyNdvjlDWA0XybmyzZltKh565aXTX0PYRBViZZrqeQ8PJpT9bfq+wiBxShou8ig3wF7Uz05kNBIXG+sigKEpQ9q7OuNd6SXPAFaCOBVSwH8UfKA4nkTectyX9xstTk6nZTBu5C+gQskhdGpAHGEgh4+KS/mosLeB3tRZUlhTCikm2bI/U6FFE41SDkO7+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNe7Bgv2V+0izV61aNppqC+zu1Zp7JtRwezOnrijuDs=;
 b=IAns4MBUedSy0YUPsq0cLvZozROExNNdb7aT4uBqmujjSjeAwcWelT2HEIO7fUmgDec5cpUIyjGAVvTGZaWQFjvPVO+qKce6z+8H7ViZKoibpmu9miq6fW8banllbvEscavS0B6cmsPnAZUc7xfCD/tcMu4Emlu39agIL0JPM6aAcyLiQF5ypRlAA9QtPkLiD5akXtqPJUJfvDDqS+ZS1P8v6rhsaG5z1KG/A8P3elJVUTQAAeHQCEg2K3EP6/Aj4jwRDbLbtsud2so6xKuBEc/xFMwP0aAmpaQaoG/JgOKErDJG6abISzzb861a7Pb9aX/qbG/O+Skp+J7PD/vtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNe7Bgv2V+0izV61aNppqC+zu1Zp7JtRwezOnrijuDs=;
 b=UCXDEksvwZ3gz0HQJELaf0PsFTjJZ92XuxXYZnmq3OElnAvJz9LT/s4PpFYyGz/8v5Hd41PfcyEoNcK7PSD1G948FxPrz3Bjwdy/AojtpN6pJnb+EMWmesJHeFPZBoz6LOcoST7MD6MsaoCzvlDjUs6UprIjV29ImSH4VtTVbXZM50vfBULLBqn44Efp55PyRQbR6/Pdkjc54VPTsaIOOdGNJiMudMmGDBWak5n5wgLBAjBwEJimmYLaMdJ8M0Eoz2csShtPweHGZeRw+eX+tBwCn6XSh81EL1iY71pdhtefchLuPcBgGAy+ruPeGx4zz+csV3jgnJJtaxS4kROAEw==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by DU4PR04MB12129.eurprd04.prod.outlook.com (2603:10a6:10:643::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:46:35 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:46:35 +0000
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
Subject: [PATCH v2 net-next 06/15] net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
Date: Wed, 10 Jun 2026 17:18:35 +0800
Message-Id: <20260610091844.3423693-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|DU4PR04MB12129:EE_
X-MS-Office365-Filtering-Correlation-Id: 2946e4be-6b14-4d51-27a5-08dec6d52905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a73yYSGhyINqaK4K8h859Oyiu9tCFQKgz4sZbgB49/KnaR0+EHfmbUDV12wYh6diw2YYsiwdDIcA1B5JF/TSbqsTwlJ2BfK3l0a4qjrSTAdNeP/nNT6UusjxFymbfvh6dgaTg58H+VTg02PyjEIppA0E3QHnq9E7H32wW6yy0qUmG38ExOCOrBF5nxDvaI586KL8KvUCIb9BNfdsZEFJVgUG8bBXlejZCHYC1Uouz15umuOnn3p6j/ujA/jl6v0ufFrwN9VEwKXs2kgaZpMI2i/c2eLIBlgSPs8Y8IihFL6YoZSfGRl+WC9k7Stzgdy1F5IgEP1MFH9Mwd4tue6jc7MFp9h3+kuSN4I5LACcHexV2oeFQJKb3yfx6GRcNd2hHQKOoliuysiWK0EtmzW53ZeAFf2phz7s9pU15BPngFlHG+TpsoNPyTxFVEJAYTqJbftq4zVauVt5vPGBjiWG44wWa8GvSOfBIRPE3FtazbVymiKXGaPaNBxUkKwuw4S2o19HmhWWhh1RSk09c+9Bg09wstlMmBy/2HFejpBYSoTp9+l0DTRe/ZI0SLkUwHp9+2v+uMXQTrf2Zx3SXQwu5sZ9BboUAMgehWqkbO08eVfA+aE/fQQSmCuMjnC06tVv63Xu+2E5I+OzMlm9ptc+XQQ2DIcnP8jG3iBL1kDcsP3FEsjz04G5X7tCylox9DQDBGbSkgAgTBYwK4O22F49M5U3WkPWM2lBjGHRIrpNG3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5mIv95XtHZ5x1jNeGKjBBMm77r/F9o31w00TC0bWP5iECwgv7jS6Bo/rwU7C?=
 =?us-ascii?Q?ilTVlkFrzPVQ/OSkJcMNs6ePAi8G8Rn8cjG3XNaIfp8NDoN6FSIL0o3oyC5Y?=
 =?us-ascii?Q?TkO4qyXD8axbp9b7rzStCJA/tNHNLf+G353ywDhnRR/x09x7Cv3Bsreww/UW?=
 =?us-ascii?Q?uABNHtj+wHb6/xB3iKieLGV50Ijn6+3zMjR0mrUxAFiwYtVBeyi+1rDhUoTr?=
 =?us-ascii?Q?T354WWjj5jXvl70YdQ3tV27RO6eEqkqQ7ZSj/CdhVKBoJwqPJYquAVezRPVq?=
 =?us-ascii?Q?uVk/BwvEaT9HE/6IHjEb75y1IKCoFgUZw9hyoLb71+BbcrnNAXlTh7RXmWXH?=
 =?us-ascii?Q?c+qxUkzbCqFEjjW+5hBzc2CGybj8GCsm+C9Q64fVOwloW/c8Z1rmJJDsR/jP?=
 =?us-ascii?Q?gNyfPklk9VvmKU7ennJXq5Al9KCleekJXK5jSxDX2ifi+j1VbDjh/GplOyta?=
 =?us-ascii?Q?q69AHcyLQ/JgdwEfud1JLtKHDuJ7A2qOJU+W5wS+KLukEPXTxDScnfQXAAm2?=
 =?us-ascii?Q?22sDVBkDG5u3A02uupzbPp5WXx8qUHyHLbJibFbWHJK0MZfqHBLi+34rwq2H?=
 =?us-ascii?Q?fPMg31tvmHi9neOzjK23UkziQYBdfgyEuH1XPqZg8y5HgGhosda4Uzn/LECy?=
 =?us-ascii?Q?IFBzHma0vFndhavLrtZeexta1lDjkLWYjYFrWT4J6gPKatN6OV/dYjJssI7n?=
 =?us-ascii?Q?Xidkv365D/bnmUi/eTIF34gYIP50+2HTqhOLl5mbUoorT7mLzeGkFhRDHsgt?=
 =?us-ascii?Q?chjul+/b5IZLStafWuFsJmK5rawUIMb1EXiZwqMBiv1pifYU3bwPhI+Bu93T?=
 =?us-ascii?Q?M6QX0lsmMQdtKTsgNXG5ZPa2HAbqtOxT9d6wU0Lt41TYTdb3skoMILLkJbOr?=
 =?us-ascii?Q?UR2SU9mPjgVR56WHRDz1antStE0lNRQtP3DZzoBuDPEC84C4rEOFWpd9kcqn?=
 =?us-ascii?Q?PwIJaMS4iuR3YovgHVcaAZC07d/7K5UB30Z/wYNmU+ojgKQH2BecyQd29kFA?=
 =?us-ascii?Q?JQ/hLFT2jBH6/gLVzvIp5FLW8OYiaamCJ2Xe3jMhfE5BWrptKsYDydv7TEkd?=
 =?us-ascii?Q?lhmMbEji5EvwAexwWtdGL7v4By9e/jJSLwTUrMBmObggl1zmtH5cjjLofd+j?=
 =?us-ascii?Q?ZARw+9BDfRj/nKsN6fEIEuuO2ozwpAU6QOso9VdyfFWL0vkBP6NCVgEAWlA9?=
 =?us-ascii?Q?p7vczVwCIz+wZMiMT0zt27Lo1bqAJUFCY+oamxuTM7ZyAMZozL+ZpUs25kF8?=
 =?us-ascii?Q?VzHgMg6n/+ypXVt8wcvRl00x0Sr59pjNSGb6zxQiPCsaFKYxvaF25OytD8Na?=
 =?us-ascii?Q?SR0sjgQ44PYefkN2ERPEmOQWyeX4IP9XrxiYMU2aKAZ4bnhx6anlwxu/kNXy?=
 =?us-ascii?Q?DSFSM7zAnkReco9q7etS3ntIcoISGx19WT5z70F12HxHqJogfvpv5Rsmyl9i?=
 =?us-ascii?Q?IFi26bmYYYNK0Bc6Gw/OzdkAhrTbb9C1T0V3CItR8PYe+yBA2kgjwokadpTX?=
 =?us-ascii?Q?BuOs+xjybEXvefdd9rOKTyrQS15bickt3fflYbaI/ZuAO4ydkevC2LCci8cM?=
 =?us-ascii?Q?hQOl2tMfDfowJizLqcxVIw9sIeLoL5lC6TLWP/5lX4uYr5ZSPHaMUt+9a+oy?=
 =?us-ascii?Q?UHBDKBnKxrgfUYf11oaRbW/SK6EZrXrX14I6spuuvPV9ajigRKsf8AABFuvl?=
 =?us-ascii?Q?/AJs4mqH1HUeTbjZsMUEWNEGvEiXt9/CtzMJQpKMggYtCFpd9j1CsLyqjqzk?=
 =?us-ascii?Q?RlwNIVEow2SBixs2mXaYDffVtwQjiJCTlxarCf/07D6xtgAVwrYS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2946e4be-6b14-4d51-27a5-08dec6d52905
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:46:35.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vipG5yGpE3U4NzsR0GS8ifx5CBiyT73+A43mOtlNeuoZgeZKE+98x8IcOCv234v2LXs4CKC9VCq6oaalmBuXa27m4G7OJOntaSXW2iS23gYo+HuIOmx71I3E28Y7qVxi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12129
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
	TAGGED_FROM(0.00)[bounces-297573-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF87A6680FF

From: Wei Fang <wei.fang@nxp.com>

Move enetc_pf_set_vf_mac() into enetc-pf-common driver as a generic
interface for both ENETC v1 and v4 PF driver to use.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 22 ------------------
 .../freescale/enetc/enetc_pf_common.c         | 23 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 4a16bc49312b..38fcc7b5fc6d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -239,28 +239,6 @@ static void enetc_set_loopback(struct net_device *ndev, bool en)
 	}
 }
 
-static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_vf_state *vf_state;
-
-	if (vf >= pf->total_vfs)
-		return -EINVAL;
-
-	if (!is_valid_ether_addr(mac))
-		return -EADDRNOTAVAIL;
-
-	vf_state = &pf->vf_state[vf];
-
-	mutex_lock(&vf_state->lock);
-	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
-	enetc_set_si_hw_addr(pf, vf + 1, mac);
-	mutex_unlock(&vf_state->lock);
-
-	return 0;
-}
-
 static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 				u8 qos, __be16 proto)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index e3bed5580d17..85e1efa6a8ce 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -487,5 +487,28 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 }
 EXPORT_SYMBOL_GPL(enetc_pf_set_vf_trust);
 
+int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	if (!is_valid_ether_addr(mac))
+		return -EADDRNOTAVAIL;
+
+	vf_state = &pf->vf_state[vf];
+
+	mutex_lock(&vf_state->lock);
+	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
+	enetc_set_si_hw_addr(pf, vf + 1, mac);
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_set_vf_mac);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index bbe21c739cf7..b2a2b06c794a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -18,6 +18,7 @@ int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
+int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


