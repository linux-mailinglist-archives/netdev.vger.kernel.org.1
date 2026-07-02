Return-Path: <netdev+bounces-303945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xx6JBBHbRWp5GAsAu9opvQ
	(envelope-from <netdev+bounces-303945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:29:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F66F33F6
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:29:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=pA0zOQsm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303945-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303945-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41C9E30378AE
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CC31353C;
	Thu,  2 Jul 2026 03:25:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A7314D0D;
	Thu,  2 Jul 2026 03:25:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962749; cv=fail; b=mXgEfO3oDB27zSms+DII8tyBxzS3ZZQuWuE6060vLgV74UVe5xJ7f1OQ0LF/7Lfehq5BbGCFgsnW5kJqjEFjsAausY1VPsuRJbZs9heKGsEy86ILIebqtC5EWiK6vz3+A0lOqmHOxILyQ03C8evbyRQnVlIJoWg2DD/rTysRZ2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962749; c=relaxed/simple;
	bh=Uu/FsTOSg4zMHV9RFjw9OUszYGNTUQo39EWNqwYNKaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Khadx5YRIhL+zsnXF2AYo9xCIPXJIR0WhNF1jBjGc0896AdfiAakHM6bcuyBSJrBK1wMWCXJQnn1EQQDT9ok9XwnRYfROVzYKXKxK8LrktkgmqsomAARgeZdfkp0Z1xXFDMYa1/Fk+z3g04qmO93XajZkWbfmOcBdpBw+xvPZ20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pA0zOQsm; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjhAEqyBrCeim2gk5OB93rGCTShadLSOQ1kDeMiykSkCGmC6xTYkknVFTbe3TsJDEcjMgFhNst0vP41XvuQ4DVy4W72n0pFZdiLZZUrRL6mEVynlKGDP20PF8fo1ifL0xvylJJNb2jZ4AG/1laZvT6v2fdC+Brhjp5GWBFyMbS1+Um0jEluPm+2rZf3OH+Q7hbMV5s16mIUUNaXwK6LcRsJwZPUGOnGE5uWphnhTm6y3m6SpN1QqgTnDxeBLFE+3EmKAKEqUgfpHauruFcqXHgdrfbbiLo4a7bjs0UpTMNH4EvuYN3+zRxyBr5acklnUNLineGZHktcVyCLXoZdJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
 b=cR3n3Xt3SzHhN3wXD+f+SejjKlZfQPKtkCYTmMhvs6pZhSE3Br8xlJwtEzLLSsnl5ek//fl72w5bcAuytXV+SAPfmJiWRYhEP/iT+Z9revbV4q32v/keY8jEFiJEp/JRFajyymSJcXtTEauyKCHaPQmiI2T9Uk1/YhI/44tE7W1zlmm95zR6pJb5YTNrN83PEynkPazy3pGMsU7jm/XByHlPXP6sPob7PlWun3P5cazLrZzf0RwPekGqWVmjyXT1wFyNwyVrKiv/1F+uqZ8DcoFGVhJwzIteFJb4iOwMJ0od5uW3V5dSVmK8bBj++moC+JSmSMOG4iLJGzxU32OFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
 b=pA0zOQsmZ5B1V8Q5zjYPHplBWFG4OQlUrBe/lLiau0R9fPIluOMYdRy2iJu1YmCvXxF0k01k3/ZBjhPnJUniHxHDhSk/q0rfa70Lk7kbLAcygiB96MxqQA4mToG8zUOoN9hbVkNRv2AaBOM7SH663S0V0zPRNSUib4itnwVazo2nCHSN/BoztEJICZzTmkQUGkdXUMepBGctWaDHXvnZV6SS738lVHsqkkWoEmtirxm0D7ElQyGPiFIpStsh4ylADadUiuG19OgR0hiwECwiWg2uETgLMcCusgGIhBfR++mDlKqIZYTwI0CYz5I6GwWG+QMLWeTaF59kgvWCvyofQg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:25:43 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:25:43 +0000
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
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 05/14] net: enetc: use PCI device name for debugfs directory
Date: Thu,  2 Jul 2026 10:57:05 +0800
Message-Id: <20260702025714.456233-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0187.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: af5062b2-ee64-427f-1203-08ded7e9996e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RK+JBqxnwZduxQYORTPMAxr1KYu46lunQfCjVj+c81Z/zJoaVyp7ia7kkj4Cxp7ufc5BV1EdbidACqalkJnPx2PRndBmjRgnCC54CV6qvH8SZnMDEMKWcyAXLZs2dgsCSImgfoEmPJLzQrM0kdFdH9ZbFvh/aNZ5aQ5ay/RGHZNeUs74bOFuy5wlFJzmNMjDQxcr+H71jPN1Efj1+B+6WEIoCXvUeSZDI2mqi/dyWmMPNvHB01XwcKjGxXW2KqkvCv2nmsNxYdXU1Qkw4UFS7C48bYt+8lE1w4/MqFKgkxVm0NfNNQNxhL6nNoFqNWPBURoKDB1KX7W9b866fvi8v+Ne3LDdG45mCTEEMYZMTZko+UZR0OXy0fxGk7M/aLFecWQRv694NElig4C+m2x9e5OWIicdCri1fS2ptO1aMe1RNdlKK05hk0D+hbRVGykO0f2N7SwqHsNxlKoYuxmUxSacBHQKN4FqSAVmhJNkSo0jtwp7Zr9+Ktcipj1fJlXyt2kBw43HtWhylrQrXGYprTx1pWTi5g+YUw4TzGEBgoBat1yvHUAMP3fPrr7buPdo3bPcwykwLdK16TpcriWBD3hS1WyQ0Hg9NVmG26hvg/39vgCxam7+Y0xidybTSG9U2RelZYTaLkei8n4j5e0t6w7WgfOfKPseDVHFYtjwZw7OINDfExvk8fX/FgiQdv9huuFV5mZCE59V11JLVnqocg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AJVD8XjnObJOj5nyXJKOesaUZhEsFJQiNSOGsNP5oXv1UrdeRaOliHWCyGgt?=
 =?us-ascii?Q?2HWGUIfZbQC7hsbj9Tu1Qr9U8msZXZZHhXY1qNcV6mUr4Z3oubj5YEEdrDyA?=
 =?us-ascii?Q?QTqLmWLRDrBdZmj/FF+46w9XHkWf/SdNt1IgcWC7bZXhlpeUulnvklJxbqOb?=
 =?us-ascii?Q?S6ZwjK87Kx8fyYdzwZheYZP2LivtCn58utV0DTWQtIeyCJNopP1bLINBDhfq?=
 =?us-ascii?Q?sDFkHad+rhnaGcCk2AhCYhDnSSFinEcbeVCX+PBMxVJq9HFVETDSLfrKxURD?=
 =?us-ascii?Q?5rGzHYSUgxvQijd1rEGs4StWLEWNy64iwkOgpyaZBvH2aJfzZ+8PVinPDyN2?=
 =?us-ascii?Q?camXQpGhLFUHeO8e//QSBGmAuRcfrbtKLTKlGgGENoY4bea73buR6brTCtFR?=
 =?us-ascii?Q?ku91zN3tRqfC0RpA8yORb0TGtB+R6JrNhlbtQpJcI76JWxu99AHhH0x5amWv?=
 =?us-ascii?Q?lc19vP+zm1Ri1ibN2nixFBETMepogoZT3uSx4bFPnKPh70bC+g7Xj9y9B4e7?=
 =?us-ascii?Q?qKt/A/I1fkp8zZPlYhYkHZ8tZd5KGVidovmZFIounDGUDMAh3SwNSyqKobCX?=
 =?us-ascii?Q?Arx9TyjE56v4NWMahWjWsprYMazTn6YC3hLLGTKNHUSbSd73OsdveehySQqa?=
 =?us-ascii?Q?kVGvzg4eIbYP5NB3MyUjChP1pf1c65w+A3J0nE1rnNnutLBbBj/2gPLWxwQQ?=
 =?us-ascii?Q?1xolFgf37x1UBzBuGPU8UenTEErMojSZNdKy9VQoyydEisyNOjfsAQY+smRt?=
 =?us-ascii?Q?GJa5VRHiLxJiNPgjIFi6q4VhqS+88D9pqjmjAfGMk0Uqm8iQ6dNX7vtX+d0n?=
 =?us-ascii?Q?HDyQ2Rf1S541Q21ZvYd40k8ntah4J5qK5wQAb07z+gTnmfgZppoxkBYL91ly?=
 =?us-ascii?Q?37Y1keJDkvr4DnBv+on/N9O0AFtXfJFX/ipAGCgC4Y33+MfOH95FQ9E3JHKc?=
 =?us-ascii?Q?Nrw5KXobmCjuC0nqOOkKM50veerZH5VLqWBPBxqJ8qybNtNsHZy1PQ6VSo/e?=
 =?us-ascii?Q?3YjZgHIM0A2Not+DsAjS6A2GvfTGgUqPrfLkJgoKOL2Hc3nX3sFO9Az6zqQB?=
 =?us-ascii?Q?TbG3OKZKX3uNmAMOllQr7Qn2joToezOxTN611k47fjKYZ5d+pAqIOOELdrAy?=
 =?us-ascii?Q?RTvf4EesY6JWR2yMVOyEAge3E5X7JGBJR5xlN8K2i0FJY9H7QBrArWqzBcGL?=
 =?us-ascii?Q?mpYEPZQF21cSOzzCIeCYVi1XbJgya3+YgxR2soaW8HPUozRxpIgq+MwwVTPa?=
 =?us-ascii?Q?3Hisj819du9/0e3Yo4RrWhyuL4va1Kr8rzLfGsQ/OxYZ5KeykQpb2mhVZZ3J?=
 =?us-ascii?Q?62FTAHm0YJSfqhEetywmlCcfCV9rQZ2omu/QiVhf5fn1wXWg2jvCb+qN6s3k?=
 =?us-ascii?Q?7/+FlBEfaagOME1MZmoLOw0l5NgPU7DP8NFw5WRVMLdXznekQ4M4kLO44kV2?=
 =?us-ascii?Q?o2N3VrEZCPtdwLeflpcMq5GJyn74/zD03jR94HK4raEToQKqx4lN5/56+AdK?=
 =?us-ascii?Q?3cty2CEUn+jXu3YoET0ouWVgjJ6wwo2YMgUEBI7D5QqRM6cKpSIagvORIr21?=
 =?us-ascii?Q?cQiNuA5+ZqjIGdZex1pvP0g7n/4jRqB3Y5/8SeTDILsiOEIIya5V4QFEvV1r?=
 =?us-ascii?Q?CFA1IZYVqmAnykZGxwX5VdCCDpSyRRWTz9AVmluFlxx25XWXZpbTLW8v1Yh8?=
 =?us-ascii?Q?b3F6Q9vCAnYRfnexaetVNSUrUCxQM49rhdpFGxZF6iVHIuDRfCImOj5U0T/o?=
 =?us-ascii?Q?q91dfVLWm1sshOFn26+6LDKlStX5tVPDxB/mmvtkySJotShPFOhM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5062b2-ee64-427f-1203-08ded7e9996e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:25:43.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wljhQxrFDlAOtxwYZCV2EIbOToL7ZnICsa5NqslrdcodBjdq41s810M6ZafF2BgYokfx1Aq5mbRJovIX5yZ4Nh7AHH0Hz0OMptq3IzGiMwuzIKNNceBMPbI5iplGzcH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248
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
	TAGGED_FROM(0.00)[bounces-303945-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 628F66F33F6

From: Wei Fang <wei.fang@nxp.com>

enetc_create_debugfs() is called right after register_netdev(), at which
point ndev->name still holds the format template "eth%d" rather than the
final assigned name (e.g., via udev rules).

Use pci_name() instead of netdev_name() to name the debugfs directory.
The PCI device name is unique, stable, and available from the start,
making it a more reliable identifier for the debugfs entry.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 4a769d9e5679..be378bf8f74d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -81,10 +81,9 @@ DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
 void enetc_create_debugfs(struct enetc_si *si)
 {
-	struct net_device *ndev = si->ndev;
 	struct dentry *root;
 
-	root = debugfs_create_dir(netdev_name(ndev), NULL);
+	root = debugfs_create_dir(pci_name(si->pdev), NULL);
 	if (IS_ERR(root))
 		return;
 
-- 
2.34.1


