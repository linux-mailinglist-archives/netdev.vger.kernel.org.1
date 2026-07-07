Return-Path: <netdev+bounces-305348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ECdeEQK/TGphpAEAu9opvQ
	(envelope-from <netdev+bounces-305348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:55:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9911A719692
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:55:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="Eux1/zMJ";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305348-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305348-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FE5F303D12E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71CB37D12F;
	Tue,  7 Jul 2026 08:48:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0865367F26;
	Tue,  7 Jul 2026 08:48:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414084; cv=fail; b=e2OxCV+ic+YiAcrma+Om9C2eW/UoAAGRi87Yq80ndFHDT0/ot/FjQM9OH5JxQZlaCTQeZOrK0Zx9YOks1coEabuZFhmsEpiMfB2haZJF7pqvugzzgbgrXXisEXfZFgcPmbBXqzq9usGVHEED+3dk3bIXu5HYqZxpgNqYIiTEpBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414084; c=relaxed/simple;
	bh=os8nZpvyegweKdzlt7uHgGZFuYjZulTjLz3jdb2MYHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RqqwxscykiKXh+Cp+b/zLRlBYhwCcxgqcwYH5Ql+3/Fzzl2g7R0yXDjfakBQDvj8gh41hIaVf+v0XuFhZSkAqVLyaHlkU6NUh3yO6BW1s7bi2+rX2A+Z35bs6oIX9q8rBs0PiO8GayOEKT+oFsMM6csbscRcd6B0/2ciqe2W2Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Eux1/zMJ; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMod4qFJdD2gSLMe8V2hO3WVgs8dfBibe/vCmGwA27+iBsUYmS44pvD6juIFcHZUubwbl1kGrSwRdXCllMHuF6T3KNHuYXQ41Xk1PgA5K8qgSdo0n58npx8X1Ffc0OKiPqVSgpWq1ZtUXR7OuZeBfWhqaYxBX7FEmGjs47yl/5WhgSlW75ybUeXinitnWU05B6SqoQph3B+Pjad7ShMP8ZSqqGvmVBwBJWxnj+LQbkat2VupAcMmo4iOqFC/VKS/ODOYkLP02ryGy1XP5N7EUSv4FGHac/+DXdRXlrQUXbiy5tPTf5X7vwFsBPTAOzNQzRWZTX68uUBheOFMZ/+IyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+y78fiqMkApwkZWG4to5BCfnVS+OQEVvEE68nctz6g=;
 b=Aw+nL2NZPhWrQd/dMRwmzdi12gAsdd9G+pfzVY7NjkTK58lkvacm6lpR3k0SqDYy4zMAOpwAjwerRJnJnYx4bJbIa5ZsrONrN1vudCrmDXf5E7TkcdgSo+GNcR8FvZmnFPSdY3hLsNKzFzUysTBF7aXhXJs+5bB+10Jq6/x39zTLPmCuC5PeLH4YR9/w022raNvtvO0BwiJMHQGiL0oNgoZhxsSRl8iQ7r9p+6f6G7JtvmtbfGeX8BOXt8skjm+SkpL6uI4HacDVstyrBokUswDrbMZRa6NN+Jr427+EsqI3kf6dTWB+nRCdd5NSg6KXahWVCBU1lmeoeazrM6kUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+y78fiqMkApwkZWG4to5BCfnVS+OQEVvEE68nctz6g=;
 b=Eux1/zMJgYkr1/+ANJV3bGFTptVnRHXIIIJxMr2a3BFE1M9NszHyoHBc/gJLUSuL5MiDmOMoxkfloWnAmB4cr/OwAK0irAQXcpVty+MqfBqKqbcIAgSuAgRmffoItIumDoti129WMRZOZNGdBc338b9xHV26ff40M39NAX6tF62LpbV/K4/4htan4OK+V4PDYxKHWY9IRDMBvPovr7R3bQdAYEy3c6pBQfBJragMA/aYZ0qwH2x4C+m68pPq27yLMCgVHBfqQjny1CdEyWvxeKshXuyui0Q3xGHgKOuUkdJX0pC6LQlEvnWT2CI0K11OvbjRvWjVmhvl5EDKrVvOSQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:59 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:59 +0000
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
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 11/14] net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
Date: Tue,  7 Jul 2026 16:18:31 +0800
Message-Id: <20260707081834.710730-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 03473591-184a-4fa4-9160-08dedc047267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	nvMsjW7wpBTezgJSidb+4qVbSDkjBxVxuBGmnBANj48FeUfneWekQ6sPPCGY3PRQn6SNhygPiAJttp3Wf+8Yt8KrmEEH2tq9WWLLECYl21SkhwRNsLP9fNVZRxmBb1VXlWqCduxpF9JXklVAaToGEWL73veKLby9VEUWKap2t/F2pEbqmWVvNdhFBlsLnbGAHQYJUDNvYkMljmuJN4++fhtvDyx427yWpblerML/kXPFsBBrSYy/bvOlp2ezea0UX3xsMH3q+e83YoTwbjfUw7wSG6snFDnPezg/mDDgIpi6CHfr4Ta5IdKVF68OScf7gYSwPCKWRnMykSfmFo5xEiAaXqqpfdNAxFTh8ggZo9JjE+8Lz1Mn5BhdDIUh19IF2jm3HdlOwJWNGWzucx8k20xZ1ak3BNAh4uVX5yRDNZII7xS24gW6bNo9AKRMyHE7l6jK+ilsCALrQhn5dAlzOHC/ccNZBcvzl7M942wUmAgj2xwZ4j0bhsim8SvG8CY5v4sfFV/ZIEqWnOyo4o9n82I5bI0/PUPoi1QVUcIr4N0uT0T3h6CVtkPNH2T4C+DHdTmBj4GPpnp+Cj9q5uU9lTGeeEp7SkXC2Q0TtAa2TpWRzyPvShXOFmPccRYgb6pUrczsnJhNyyK5ofJKycFUUbHemDyfazdAdfJmrnbygtxIlfjJfvvJSljibpruI1EKxWKIopOrsGj/bTRkhwsSBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuLtncWup+3vbLk/dj1RdZGkyBgemRsqfTyWJMnuWWsxNBGrTHFzDvBq+RKr?=
 =?us-ascii?Q?RVch1I5R/j1v7ELBjEWdOYjAzgbEpRYA8Yq63gZKxofCJChdhfrYfTrBFiyp?=
 =?us-ascii?Q?a7vWdF3zAwb0RbCEK5qqv6N/8a0L4KnQPhjT6mMzImDy8vpRW2GCeGv3//zZ?=
 =?us-ascii?Q?yxQp9qwRAiJpdGxU+8wtehw+jKZN+PlhZEzwZuCVZWCVpsxvEB0OKc+zhxVb?=
 =?us-ascii?Q?RWPx91hJDteUhw2hwpEV/9cbSCsrhNUidACa5LAdxx0E/7FUP87QwWF22Bha?=
 =?us-ascii?Q?pRfSCBU+EH3iceQ2TQuPDnDGI42nJVhyXf6af6dd0fax59tNAc1hxlMQYTFC?=
 =?us-ascii?Q?o/CoyzQ+JLzHN5KrFp2+2g1w8Kr/UCOZxDjhXzUHV8Vn6tPwClKOWHKbm780?=
 =?us-ascii?Q?Ibpgha24L87HkwzNqrnCwkdBJ46xQ5vPo7hE6ZCj/en0v4QYkWFIy8QeGqXQ?=
 =?us-ascii?Q?otqoxclEru4BussApjyltEhokiRP6h+S/q7oOjDU+avrnpwOeYAPptUc7nYH?=
 =?us-ascii?Q?one41bXefrD5eZuvizp8h+0r9GwAtreCn2+G4Ah/SUBj3wFhA9Jcb8OwDqHl?=
 =?us-ascii?Q?uIx16fJQh/ayiGGt3pdh9TUAffNj0ehqNv/k9XRwxPUlV2E6P/aM0fFeq3d3?=
 =?us-ascii?Q?Kmk78ICaKqvfFnNRjJ+wkWMsaUH40HO0waQiX0MF+6SUrpEQ5PktxRVUDX0w?=
 =?us-ascii?Q?LjW2nW7Yux/jwvN/hcnuyOW9b54sdeG1qpzfXlI2Doy85DccA1g9CHUF9lvi?=
 =?us-ascii?Q?nDx9CyCQS8hZftnHSvQ+zjR/lDLnGZkIzsiPXB4rZXNqCAX4PZXB5dyTwuVH?=
 =?us-ascii?Q?6zaWJ4NKoZQS4fFCY10vTUvnj8q/rGob04YgJFAuoxWVOhf65j+4qNMcBKob?=
 =?us-ascii?Q?vHMxuJecwcF5B50vvaWAziS6cm0LAnqWhyNc/oGnvA6FAj7kVymswnjUUP2O?=
 =?us-ascii?Q?FGNfoY9bNwCmGhKuQUIEu8eCln0/S4eBByGoRj6jcXHYn/XbkQDhu18L5oyg?=
 =?us-ascii?Q?9bkVgV275PEcv4Mz7fBAEpZKDBEMRl6mAX4+mB7qQs05ciddFa4I/hfLn1du?=
 =?us-ascii?Q?GKJxvjOWMeAwNdrTK3ojFFGLkTpHeDXLun6os1hEoxmomRVS3/IgyqNt0FYf?=
 =?us-ascii?Q?INVOIRQiC/K3aLAL/Q3WutsQHkgrZoLdxN6Z7f89fOpMr2T/8rNP4+NXRiGo?=
 =?us-ascii?Q?6qkWKVKjnC+ka9GZnCULbZjvWQMv7R4uwHgqGOtVNAdPJmvKU37ILOzBamep?=
 =?us-ascii?Q?nUQQCrSljsJ7jZRP0o91Ku/UD5/A174133vb9EqBAeeKbJqc1NZ9HEIr0zei?=
 =?us-ascii?Q?BhxX10GztPkZ/InMkl+xwKgPJaWRqiaI+lN7BtQlU0pQR3vwW/T5LupIdUGp?=
 =?us-ascii?Q?m8xQ8VpxUb5BG9pWbpdHKnVPxPu4QJP79CWeUgEgsWtXE+sqj9Nu0K/BN6g4?=
 =?us-ascii?Q?oY1nKfmGidWGQCpERUgcH113Vk9rDKdNGxV0JAidZw70mcCdJEV9YvBgqXSf?=
 =?us-ascii?Q?4I3j6mKqrLm6Fu9DHvr9mVCpFEr6x+xSTiyFtHZgcqkdQAhIQlM8Tl+rbuj4?=
 =?us-ascii?Q?IDatU9emYnnjeqHMoERM4aHUPuETSSD9QTNbeF7pfUnvbcNaPp1gm4A62xKA?=
 =?us-ascii?Q?FkFcnFrceK7LJOIrBmsxjf9ipZYqAjWcfGFyUYCqt3NKfbibT+5F4gp13ziU?=
 =?us-ascii?Q?GWh+F0eHK5mAkpdQbWmLvCYeTkwss795aZe4FtBEQRFySu8qsWqy7jeebQdu?=
 =?us-ascii?Q?LM6u6weBKE5oXX3lcV40wzpPtQBx+UglyBGR9dSvSmKyQt6Z8arv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03473591-184a-4fa4-9160-08dedc047267
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:59.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRWggNxa2J02kvSpzxIeSycye49RxRobkiAPix3QlZABT4gMphLW+Yk8W6V8KLIro1a5AX3T0ZYgi8+/hogUVpPJwuPwL0x9e2fMHpQoXVnLmR4b410Wr2KFFv3ARsMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305348-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:maxime.chevallier@bootlin.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9911A719692

From: Wei Fang <wei.fang@nxp.com>

The PSIPVMR in ENETC v4 has the same bit layout and functionality as the
PSIPVMR register in ENETC v1: bit n (n <= 15) controls VLAN promiscuous
mode for SI n. The only difference between the two hardware generations
is the register address offset.

Since the register functionality is identical, the VLAN promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Move enetc_set_si_vlan_promisc() from enetc_pf.c to enetc_pf_common.c
and export it so that it can be shared between the two drivers. Add a
revision check using is_enetc_rev1() to select the correct register
offset (ENETC_PSIPVMR for v1 and ENETC4_PSIPVMR for v4) while keeping
the same logic.

Remove the v4-specific enetc4_pf_set_si_vlan_promisc() from enetc4_pf.c
and replace its call site with the new common enetc_set_si_vlan_promisc()
to eliminate code duplication.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 17 ++------------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 16 --------------
 .../freescale/enetc/enetc_pf_common.c         | 22 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 4 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 505e4abf6c37..cab79f81d6fe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -295,18 +295,6 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 	enetc4_default_rings_allocation(pf);
 }
 
-static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPVMR);
-
-	if (en)
-		val |= BIT(si);
-	else
-		val &= ~BIT(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -352,7 +340,7 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 
 	/* Enforce VLAN promiscuous mode for all SIs */
 	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
+		enetc_set_si_vlan_promisc(pf->si, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
@@ -518,12 +506,11 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 {
 	netdev_features_t changed = ndev->features ^ features;
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
 		bool promisc_en = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc_en);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index afc02ed62c77..a509929f89f2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,22 +42,6 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
-				      bool promisc)
-{
-	struct enetc_hw *hw = &si->hw;
-	u32 val;
-
-	val = enetc_port_rd(hw, ENETC_PSIPVMR);
-
-	if (promisc)
-		val |= PSIPVMR_SI_VLAN_P(si_id);
-	else
-		val &= ~PSIPVMR_SI_VLAN_P(si_id);
-
-	enetc_port_wr(hw, ENETC_PSIPVMR, val);
-}
-
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
 {
 	u32 val = 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 781b22198ca8..d32a195a04c9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -171,6 +171,28 @@ void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
 
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipvmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipvmr_off = ENETC_PSIPVMR;
+	else
+		psipvmr_off = ENETC4_PSIPVMR;
+
+	val = enetc_port_rd(hw, psipvmr_off);
+
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
+
+	enetc_port_wr(hw, psipvmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_vlan_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index bf9029b0a017..8243ce0de57f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -21,6 +21,7 @@ void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


