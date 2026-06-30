Return-Path: <netdev+bounces-303026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ApXVNO11Q2pGYwoAu9opvQ
	(envelope-from <netdev+bounces-303026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:53:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D76E168D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:53:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=KU1qj9du;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303026-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303026-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B8E93038A1C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5233E9C23;
	Tue, 30 Jun 2026 07:49:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E83EA971;
	Tue, 30 Jun 2026 07:49:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805795; cv=fail; b=WePsS+2QYSMQvowgF52eEWpg7tZHtxFPhQbvqK60JXLIwsUHE9pPQaMitgDWoTXLpZ/UWuIWeKv/5UcN0lX4ElUl9HCrAMY+32k6OJKa8K2HEDDDoDvcYamNbQL9y/QPuxCWMxFlsalHpwK7MzOy4iNiY1j+wu48LvThcGo+OJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805795; c=relaxed/simple;
	bh=/FkriXiq/fQ6Mll+FFAseFlbY6AdqqL1B66K6IkkwKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOhsy7yyD1AMP3g3NcmTNwKggo1+yP+fhFZOdhz55CpssonvB6bme+26ksPo9DIRh8DGSBRk7muUDv6QwYb6AktwKUhdfE1DQTjYqPZNq3cI1JtSi3Yhb/BhT4xu06CiJZztA/NTz6WJEfKITm8oIU7C4ID7oRxGMjlxRyzwKuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KU1qj9du; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQH/0jVhDI4n1wFFEM5MgSqMethUlLKqQBszPdhjPFqfgfqUjBmIdSFJGPkR8zPpIYY7qfgSb5m2LPRcmUHgZVfP2iZ450WG0C4TsX2KeNYLblihl6QNY0UWclwVwVdr+1K5nsEaNIy6DZUBG7zwkbYXS00mIZGG+ZPVjGmked1tIhAj5TMKFN7Ey/TvG8PSxkKGMtuv1O1V8NGL725HhZ+huqG1guCWy4zCFR8ib2ZK97b/oHZglrL+VDZvPfxTmH2D6bJuwNJ27ToPg7lkG313FdZiEVOP4WWRgf0UltKICunTKgunEfE2OJK1Rq17PEb6dc7vKJyBYiSI6PIMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2aNDUtTpvMZSHHH68Kz+CpRELw5sQlUW3RfIv/bH0M=;
 b=GCrd7HzN6mvZ8fU846AlxKQxswS8KeHZ+2LZQ+92t1Z42H7Hn2609LKpBx4SfCzQ9i7EwKl8nnqAeaAk/cgA/kLSRhqyrzavfyxy4nE8IKtg7ZsQbvvHgOyHSAYAqBEHPNNgnwal1q2h1XjNc9WPwd5Up//0SojtZQyiOugBBmaK5GXrBv2eDorLk6F7XJAaqF7rgz3rBZrzsFgDhOK2hNKC6kLDKb6TzuQaP+NNjTK0pDPU266Z757tyol3mtfojsT0Lu4TVDoT/V2j0rsfq1n8t+kbKvmzF971mHCCeMvGDYXwwIMmzPgVDTYNSO5mP+I/Dl5CsnJ2OiUXD4sqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2aNDUtTpvMZSHHH68Kz+CpRELw5sQlUW3RfIv/bH0M=;
 b=KU1qj9du/cxqS792Ua7uYoF3Llh/ujE800u1gD/UB/Knl7YV70o0dhChoIcCSUQ5npDMNgWsClnaUCDe9jQHKDv9aPYFJmCOd1alP4TVcfnhANdP2Cq+Jo5VeTLJzSsIB4j7cmL6tHhj/j7IxLQKidDi2DTSIMUnHyNPQmDL49I2vfclhrZjWPYdwxF8Tb9539JWemtzWWkpUoP2DPld67J9aQaaRkLXvgWGGzcDQmtylIXXO2yaCeoe4hgxJfn1iLP94/3akik3H/p7MEXfJ2FGAmR+GZadalhuWY6pBaMz6LBgfwyRG7n73hDqDmAcPsgFoCCVg8CScENxOcC57w==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DUZPR04MB9918.eurprd04.prod.outlook.com (2603:10a6:10:4db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 07:49:50 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:48 +0000
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
Subject: [PATCH net-next 12/14] net: enetc: remove redundant num_vsi field from enetc_port_caps
Date: Tue, 30 Jun 2026 15:20:34 +0800
Message-Id: <20260630072036.382761-13-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DUZPR04MB9918:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a142af1-5788-4c6e-fcbf-08ded67c28b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|921020|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	aNbc8Xqt2hnAMfUGC1q0zxQTD4TNZC5HL21m1b7wBotaWdMZpKBpwiMo9ZKdHtgoTSGJYjjNu9I8c7wuiXXJcYp09ybQytG3kacm6FoR9xQ5cE4PHUgSCotvl6wbQ+P12zpqy2buWpRBX3Aojnu3EwnSOF79WFtJ8Gm3Q1fcYi/9PaAlplG7gnsMrQLUbwMBY/pVCESW1TXE+lJI1Uzwl9hURUYFBXXGgmmAxC4xUGBagd8eTjtkT8yNaHeRPDcMoi+9JjgrflDW+lSQtjdgZBjA1Oj8oRn2gKGjPhO77tY2ydrVdp9jk/IN0w4QPQfZU80b4xbQ6f/PpRmAFv84BNivLU6LWVXV/IH/WvYIpHJg/W8l4b/5GTi01wDrbsAWlwDt5UeEnOfQtiJxarXq3c8Cm81kywrh0GoepTdxZl3COTcXP0dHFGNdkbaaCSFGrkEatWVgibrmIxDHnZh367gV7gQR18vUABw9pPStfZXTMWfz7lsN5aMajVGmgKr62Y57g3xZM14SfOjEsFd/dLN5X4KUC8/dtYVSAgpsrWPta5j05tCzR3ozFeZvpPyn39va0HIHFKhRLpqklRj1txmOCMN9e2mPngn9m0QvNRmjmK6PRzYDQl4c39eGQJA8U6k/BdJljnBD+I4qjs/N4BSrCic5OnbTTbSG0pAHgJztuuj48BOE/pSWDaXzfhTObc7RIOt6pJ0zYgu6GlJHBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(921020)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YnbRedkb75w2VkmPu2BjYLKnvSuFqYD4jP09NKvILfLv7/q2I9TfDKgSM4v4?=
 =?us-ascii?Q?erA8EiBVdsCSE//Oyk+1FcXplBpFusE5t577Dw9X3U5XKhc2ExREF+DdVoyd?=
 =?us-ascii?Q?kSS3T+6zRPU9Udm4pwPSxY9AfeT7labnx9yVS5p0oPsgElQNfcOq9y+Iswnd?=
 =?us-ascii?Q?Tu8F7+njs2tDYlsZNH06+hxeXZ/XHSDim84Wf65VfPNfRx85mNvYqZ5W2cLM?=
 =?us-ascii?Q?DN4q1QFT0ekrco8JmGD9/HQnnYCzETfBHUTyGe/F12M2wu6uNietZ2gxDVoO?=
 =?us-ascii?Q?0z2KlgQRrCW4UhxgvER8VDarZG2/aRFhULz2GbCMXN/dNstWFY2q9GwZWgud?=
 =?us-ascii?Q?ELw+/z6f6LI1kLiByHK25WsgFY8RT2JwDxPepOjUXoBsJRCf7KDJpbiPugV9?=
 =?us-ascii?Q?UjgtHubdmEhmHdwnUjZX7ITfKkMZdBrd5+i1xUP02oNZrb6I4kE5r5ceF1OZ?=
 =?us-ascii?Q?+b+JLKliKO2ssnxRMRwmtnEKSwCsAO+nHk8R1ah+MKUe6t3LmO0dBobTCaTN?=
 =?us-ascii?Q?n0CfHG5t0gixCHempEOyM+pDUWQkGABJ/XtAQgQV0z0vQpNv/+LEs9jfvNrB?=
 =?us-ascii?Q?z/P0Zua9814LwTikg69AsygCDXO/1zi1RqgTa1i2pzNDaGu73muKDVMgRyby?=
 =?us-ascii?Q?d9cUc6ND3uTPg7pHLZZaYZ6u3c9Qie2knhAajCmwRJ+ai0fMREuYS3C3KquF?=
 =?us-ascii?Q?5ofT1od2+yT9De3g7oh3eROL0Ctlj0nLtPhpCkDr7jdV2+t5U0C+/+nrPmZK?=
 =?us-ascii?Q?J7qHB9WuqDlmlAuSHaQWeSbWZyHO+dVrpx+vJziMTRkiUE0phX1T1KME2vQq?=
 =?us-ascii?Q?VpD8lHl9nvvYyv4+RaGG7NgQEbtAhj5PofSqG/+s06YCIKE4BXXdY3E7ay2l?=
 =?us-ascii?Q?O293Rnd+MGKTJyQuB5IOBy3CSCl0ksDpf4C7xYECA++JRRegHC41J1iwqA2q?=
 =?us-ascii?Q?cCZW4JEWTrKqZRwYWM3PBThQoDeKAoR3GbalLMiuI8CWPIvfMpWu0Eng1x6j?=
 =?us-ascii?Q?QqB0i6j1JH2bq+r0aQjTWp4ajT8EL2/8nRQHSXiZ8dRNwyWlAGk8agu0Anpk?=
 =?us-ascii?Q?vB6wdtvskMFJ5PV2cqw4lPiTw6wyBvjoREAL5cnK2HspLCfU+LeHQ87/6riJ?=
 =?us-ascii?Q?CXc3BrwKp+QJZGCzS3Bg5dEuupfJ5xN0zd+ABxj3tZHurnma5pFtyQNWtTV3?=
 =?us-ascii?Q?mzeXVCh73OdiyywEO0kGERpwyIeVWBOWymI+7xkzUpg1ZSk/Y3FjSsP29fIv?=
 =?us-ascii?Q?cXe3haRIMDTwIVqVzl2H2oYdvbtLyKEAqkQwu64codiqR1Z+gCf0m+ebsTsR?=
 =?us-ascii?Q?6ZfOIIUlouMtMYZQ09Btk4Q/Ls9XUXz/Ms9xkBhA99R+bf5Dwpo1ydPxBGmS?=
 =?us-ascii?Q?uK+fhg/preudU8o8j1p7evXLMcY0IqxAEYPS7xVFY8/VYlwqPxufx0s+Ais/?=
 =?us-ascii?Q?1hCdUkcblBePs6hXgsGEUjBwtleLjWT6LcQ0l3CQwRrOA4iDudP6LZ8i9qLX?=
 =?us-ascii?Q?8xXq5RGYh0SbnM90hY3SxLb1AyG0TEVY3iVIFTc/qMUaFjx13UItPVbvptb8?=
 =?us-ascii?Q?prLBL4iQOd5CjfrmuESaSd95f8FX0tada4OmvWFxLgCsCsXnLUS+zfaJV42s?=
 =?us-ascii?Q?d28D0KIouSa6c+qzRarNkNAA2z9j3o2FsL+sQOcRIO3eWhSLgbYdbbK3+atS?=
 =?us-ascii?Q?YFnf27JGyeQ4izrb+FEGTTOf7F4HwQfCbwMMAjv+S4eyeUGGY4YejTVetexi?=
 =?us-ascii?Q?Jck757/Dzu4dPj8QL9Y1qEXcCtPdMR1feMm54VQuL42t6B5lRXw0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a142af1-5788-4c6e-fcbf-08ded67c28b8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:48.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDAuymZcozzCbcmsDs2uMCrz48xwURWf2Fhk2npfX0zf5hOaduMdypXtzZPN9f2eSzWpsUpMYCDksAGLBN+EnLzV9gCpC0HsOPqYGStKVaIbPPWlFroECpVV/xwh0Qg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9918
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303026-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A0D76E168D

From: Wei Fang <wei.fang@nxp.com>

The num_vsi field in struct enetc_port_caps is populated by reading the
NUM_VSI field of the ECAPR1 register, which reports the number of VSIs
supported by the ENETC4 port. This value is equivalent to the total
number of VFs reported by the PCI SR-IOV capability, which is already
stored in pf->total_vfs during probe via pci_sriov_get_totalvfs().

Since pf->total_vfs carries the same information and is already
available throughout the driver, there is no need to read and cache
num_vsi separately in the port capabilities structure. Remove the
num_vsi field from enetc_port_caps and the associated ECAPR1_NUM_VSI
macro, and replace all uses of pf->caps.num_vsi with pf->total_vfs in
the ring allocation, MSI-X configuration, SI enable, and debugfs code
paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 13 +++----
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 37 +++++++++----------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index be378bf8f74d..5029038bf99f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -28,17 +28,14 @@ static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
 
 static int enetc_mac_filter_show(struct seq_file *s, void *data)
 {
-	struct enetc_si *si = s->private;
-	struct enetc_hw *hw = &si->hw;
+	struct enetc_pf *pf = enetc_si_priv(s->private);
+	struct enetc_hw *hw = &pf->si->hw;
+	int num_si = pf->total_vfs + 1;
 	struct maft_entry_data maft;
 	struct ntmp_user *user;
-	struct enetc_pf *pf;
 	u32 val, entry_id;
-	int i, num_si;
 	int err = 0;
-
-	pf = enetc_si_priv(si);
-	num_si = pf->caps.num_vsi + 1;
+	int i;
 
 	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
 	for (i = 0; i < num_si; i++) {
@@ -52,7 +49,7 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
-	user = &si->ntmp_user;
+	user = &pf->si->ntmp_user;
 	rtnl_lock();
 
 	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 7a3ccc94b036..72b54fe02e65 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -50,7 +50,6 @@
 #define  ECAPR1_NUM_MCH			GENMASK(9, 8)
 #define  ECAPR1_NUM_UCH			GENMASK(11, 10)
 #define  ECAPR1_NUM_MSIX		GENMASK(22, 12)
-#define  ECAPR1_NUM_VSI			GENMASK(27, 24)
 #define  ECAPR1_NUM_IPV			BIT(31)
 
 #define ENETC4_ECAPR2			0x8
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 52f84b5b838e..b4b8d3f08ab8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -23,7 +23,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	u32 val;
 
 	val = enetc_port_rd(hw, ENETC4_ECAPR1);
-	pf->caps.num_vsi = (val & ECAPR1_NUM_VSI) >> 24;
 	pf->caps.num_msix = ((val & ECAPR1_NUM_MSIX) >> 12) + 1;
 
 	val = enetc_port_rd(hw, ENETC4_ECAPR2);
@@ -258,34 +257,35 @@ static void enetc4_default_rings_allocation(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
 	u32 num_rx_bdr, num_tx_bdr, val;
+	int num_vfs = pf->total_vfs;
 	u32 vf_tx_bdr, vf_rx_bdr;
 	int i, rx_rem, tx_rem;
 
-	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
-		num_rx_bdr = pf->caps.num_rx_bdr - pf->caps.num_vsi;
+	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + num_vfs)
+		num_rx_bdr = pf->caps.num_rx_bdr - num_vfs;
 	else
 		num_rx_bdr = ENETC_SI_MAX_RING_NUM;
 
-	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
-		num_tx_bdr = pf->caps.num_tx_bdr - pf->caps.num_vsi;
+	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + num_vfs)
+		num_tx_bdr = pf->caps.num_tx_bdr - num_vfs;
 	else
 		num_tx_bdr = ENETC_SI_MAX_RING_NUM;
 
 	val = enetc4_psicfgr0_val_construct(false, num_tx_bdr, num_rx_bdr);
 	enetc_port_wr(hw, ENETC4_PSICFGR0(0), val);
 
-	if (!pf->caps.num_vsi)
+	if (!num_vfs)
 		return;
 
 	num_rx_bdr = pf->caps.num_rx_bdr - num_rx_bdr;
-	rx_rem = num_rx_bdr % pf->caps.num_vsi;
-	num_rx_bdr = num_rx_bdr / pf->caps.num_vsi;
+	rx_rem = num_rx_bdr % num_vfs;
+	num_rx_bdr = num_rx_bdr / num_vfs;
 
 	num_tx_bdr = pf->caps.num_tx_bdr - num_tx_bdr;
-	tx_rem = num_tx_bdr % pf->caps.num_vsi;
-	num_tx_bdr = num_tx_bdr / pf->caps.num_vsi;
+	tx_rem = num_tx_bdr % num_vfs;
+	num_tx_bdr = num_tx_bdr / num_vfs;
 
-	for (i = 0; i < pf->caps.num_vsi; i++) {
+	for (i = 0; i < num_vfs; i++) {
 		vf_tx_bdr = (i < tx_rem) ? num_tx_bdr + 1 : num_tx_bdr;
 		vf_rx_bdr = (i < rx_rem) ? num_rx_bdr + 1 : num_rx_bdr;
 		val = enetc4_psicfgr0_val_construct(true, vf_tx_bdr, vf_rx_bdr);
@@ -302,26 +302,25 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	int i, num_msix, total_si;
+	int num_si = pf->total_vfs + 1;
+	int i, num_msix;
 	u32 val;
 
-	total_si = pf->caps.num_vsi + 1;
-
-	num_msix = pf->caps.num_msix / total_si +
-		   pf->caps.num_msix % total_si - 1;
+	num_msix = pf->caps.num_msix / num_si +
+		   pf->caps.num_msix % num_si - 1;
 	val = num_msix & PSICFGR2_NUM_MSIX;
 	enetc_port_wr(hw, ENETC4_PSICFGR2(0), val);
 
-	num_msix = pf->caps.num_msix / total_si - 1;
+	num_msix = pf->caps.num_msix / num_si - 1;
 	val = num_msix & PSICFGR2_NUM_MSIX;
-	for (i = 0; i < pf->caps.num_vsi; i++)
+	for (i = 0; i < pf->total_vfs; i++)
 		enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), val);
 }
 
 static void enetc4_enable_all_si(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
+	int num_si = pf->total_vfs + 1;
 	u32 si_bitmap = 0;
 	int i;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 574ab4e76d8b..9c36ba50a7f0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -18,7 +18,6 @@ struct enetc_vf_state {
 
 struct enetc_port_caps {
 	u32 half_duplex:1;
-	int num_vsi;
 	int num_msix;
 	int num_rx_bdr;
 	int num_tx_bdr;
-- 
2.34.1


