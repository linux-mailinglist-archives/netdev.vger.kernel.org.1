Return-Path: <netdev+bounces-295107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4LSkGoI6IWrmBQEAu9opvQ
	(envelope-from <netdev+bounces-295107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:42:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD563E161
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:42:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=Hk8ypayt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295107-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295107-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7022130A7D48
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941E3DA5CC;
	Thu,  4 Jun 2026 08:34:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4F3C199E;
	Thu,  4 Jun 2026 08:34:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562050; cv=fail; b=m6uG8SgU49u3xsOPQ/rU0kWbAz7nDzTXrj4hQ0uOojjpoxr3WNEoL99QgIlNzDzygcW4Ci1/hjOwJpzTSDRhCRpuPKknaeP7NkLaQgn9CX34Qx/orrUGXH7tP2CSepRTpCKbYI8RvqupQYYlWCl2Hwje9U3vNUOlV3gO+t6K5ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562050; c=relaxed/simple;
	bh=aPn/8lSIhemSZzwOo8z8Etet9Med20jwY+CbdBMFOdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNxWmCcfoo8H78DgRUNZGmJSfXiube/8wIBn8o1pOGB6yLQdr4wxCQJ6ch71vmKZWKjnqKmWKG8lPrOCPuDyn+VQLPfi/58U26NfEhULNVIhEl6uEbDLuTvQ4v5/+hTETBxUIptQtd+ggmN9YKgbeUMU+ApLT52IVckwDvXg2qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Hk8ypayt; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHie+PGA96JvnMx8kVVXwbmaJIkQLopzF3Exl9f0Dl1v0+mpVnRRgmNeyiifsJ3Z70pugqwq5R/4WGFCkLLepw298fi9B21lLzgSyNwSEcMknuja1TbRlsHahpNNZZ4U+SEIEE+3N8V86mE+YD7rUlhOlSgGOTJ0R1OK5JH2GR/mHxUBn7cpjX13QfIRLJV+MNBCkU3rvzCZDt1yz9G9QNf1b5h3/+D6YL0+RScd9Jv672p+5MIa1uAc1yahyyAP1238BJQz/0IiYx2fC1SJHYwe1CyUr1NQ2gNrFC3Hci85clazTwBIvdtm38vXEjErpGvrQPoXIdwte+IFSm3aPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNSBByl0f5m3bkbjfxqX4mfNAWXpKVD66R9cmM81gMY=;
 b=Uu78NEOy0lllKNuUV1x3kP3IbgOzqvaW4yjrgyFAFhXgZ0o1s/shity0+CNxi8ZLbjUFerjfchSFMwWbT+UeheIxa1kufhiNJqZTvsHu90vzHI02kNuCJ2jfnyiuE0uLR4DjCXwJ1vm7eEuny2PflVmYjG8A5XcqkZVLMaVimjXMX4gTiqSxnBGz1OqiEYKWujZjXzsScRtTgdRNx7wjP1SE7EPDdneVaL0ttzZ3jLl3uQNa2ADadXR3yZxttwBzT5TdA3w0DNghbF9MzSr8CUCWDy3CiI9Yw9VejUnF4nJBlnl7QJXRxV2oXaTxsrurlcyoLSWUY2ZA8RbV/7Nhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNSBByl0f5m3bkbjfxqX4mfNAWXpKVD66R9cmM81gMY=;
 b=Hk8ypayttbEdkbXRXxkz8998gOPwqyE9Q0Rvmvc5YyWt/0JKjqYG+2LzuY8iqP3T6GrBZDdi7NVBNt78ICnlbtzuR8L4npUxMpRpj59IWVs2dHYEloAFv9mHp5d+gIZ3xDbCsx99tMyPmzjMTkKW11+sfFEIIg8c75tXkIiEgixnEB9zGR1UFJFuzn1BXmvNIAuD5Ho9t8Vdfulngsc7iNP1nush/kf7Nd1Wy4/u0Nvuf7l4lPV4Qp9dBexJF7WtvcZiTsTiCQDGLhdmSedIj1tRSz95CRyl1D9DVjm/YRCq19Yt/z3kfyLu0bWrlVQMD1dTrk4SpXfV1juB26Yo1g==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 08:34:07 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 08:34:07 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] net: stmmac: fix l3l4 filter rejecting unsupported offload requests
Date: Thu,  4 Jun 2026 01:33:49 -0700
Message-ID: <20260604083350.1701-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fd8ca9-4aba-46d0-188a-08dec21402ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	cqNGk1htM4kFem6hblAEpYKfZ3BSncbew5HLZ+n0rjRMHZbaMxbMXZQm/4KZWn5AnWLCOF6EE5ORsoUAVp6mcO53uI65DpZf8BzjvzAMIQLJK/Wy0eTEBBu+cGXfYKk5oFC4E9uYCVQ5TBGTP04/wxFzYLjwAeee5zq4+GgANPc62SaDbRRX7kJ1qAxhNoh493ZK/uhsWJ/r13bSkY4GlTDu9WxrCkNQfTPXCe34+3QgJ8Du4NxkJA8RUnIN0hsfboHReW68MeH4HHB55RpXQ9uFG/v5IgrJtsf8PDAWr20fLDfl41E4f01n/aIQ0zUKfCbpIn0/qvhIWjF87C3e2JOCNBxrcWpVdyNRSYkxWxNDJ57aeNgIaqqynvx7TKs2aTlcyHlSFpPzBRtNuRzS/IxmibAYOFn85U4edeE/l16SnsMLAHP0iHWqoXpFk2j0sy58vbTn4fmIqx6sx1LqV/vM4UEpCgH4wLyoJS4jsr85tAdkUjDZslRojhAvf2M8027E8zog+YF+Sdcm6uz3squ42NRcDMIdIvFtW+/g3eYN94L521uuvY9bmlnNOb+OEVoB4F5WXuxqyeE1k4SKVsK+NvkF0a/FlPtGhWqesPq9BwNJD0IbKEIw2aVVKzkTtGEioulGzy+tRl5hj8nJd38O6XVT6U85MxIrDTGpKhjZ0WdkimtV0mTFLEjewTMk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RopEgAM7o6F0oTMSz/eE6y0FrwgOZdVPhZMrQjP0qNDG3i17wrDFFi3MROE/?=
 =?us-ascii?Q?MRvfMgOJEKNZ7eckpwmbRhx0ndE1bEYQHEK/25sJldKSIfLVO6aRdB6oj1mK?=
 =?us-ascii?Q?A2ADQu6Iz07DUcoYNHTQfDjk/yP1DV0RoaVpHQc8mL2b21nN5EpAab9uGf3l?=
 =?us-ascii?Q?ySx0npAnFz5jW4nVk9gFIRnbXv9N35z5pFh4fJhpOgjbswImA5Lhqrrhdtm+?=
 =?us-ascii?Q?pKFP1SVn8lao0BcuwExZk5ygZX8kDtGd83taED52nHA6ZlyOC1OXBw/kMe/k?=
 =?us-ascii?Q?3/sQZkTSmsTDLsTVzk/wKZdpyvene5xqbzgTM98nil0HGF5i4hUirwjVhMu4?=
 =?us-ascii?Q?WuYHTWUG7SxXaQUg8gp52oR80HwwMPsuJ3x4e2UtbHgPJRRgVaLKIgt1PQqM?=
 =?us-ascii?Q?Hgl5k8Sb0sQR7tJNPJ+i+UCVGGYQSSQSalGtg9UusLFH4d8mSIZ/EiicRGhc?=
 =?us-ascii?Q?QBP/2Sz4qTwgmcDcPT3oNG2uUwatakDfyGjeQMnnx1ddFDqseZG3LnuHYVDS?=
 =?us-ascii?Q?M64xZ0lnBMAfmc1XGF0NHY5qDDoEVGvX4ftYCCZqDxjf0iXVka2ln2+tUF9I?=
 =?us-ascii?Q?anc5E4gBEcItz76RSFtSs0ak/MlLDhDr/eFpuNWt5pPhfFtK1bn9F7bQo5WQ?=
 =?us-ascii?Q?3GjqiLCG6hjyP7ZyWqqGXPXoiB6x/Y/bxmlwVceFlmer+4agfAfjYReRcehn?=
 =?us-ascii?Q?gHbiRAWUpTm1zWd3yc/RkmLzhF+ZjYh6DRtsOEKhf3k5tBfCd8YAU1wIFOoz?=
 =?us-ascii?Q?sDCLlldCVR0YghOTA8FxuYKpiu6xLTSk5BUWN42jPE49GOoj+kTKi9XCE08K?=
 =?us-ascii?Q?iIBfqnjGGrQQzglp98gdx0wcYy/aVOaxejODxIHrFD/rKdRU5kCQAQ2otHyc?=
 =?us-ascii?Q?UKAE2ypPcKzcW4CVorg8w7zu5Xmjb9z2dQVhTo0Quo2gIeooS9bfAxYEIOnl?=
 =?us-ascii?Q?4RNHkLGAm1pERCb1YSSVDusT0jzxwZDIVqqv/dfEA6tHXFEQ6lZThlBXXf+g?=
 =?us-ascii?Q?xLhQryVvYZpnYwJxdHSWjbtZk4l4MxEdzjmZ3UMwuAL8ZgHkUAFj8OP2acls?=
 =?us-ascii?Q?cYLRU002nnijadeGJNVwzjWT9/RGx6LKvh8gy0XP5w3jcL9ochNM0cVMOUxj?=
 =?us-ascii?Q?G636UrEW8Tk1hkPwRW9KuXq+waz0pnGlOj6PBkfTadBKqyVriXRdJ5XSAHuc?=
 =?us-ascii?Q?aUnCtUPNHYAWvL1TZU7dxBJp8kH45xHMKQ61F9N9sXRBoUXJUiyz/o0EuMtt?=
 =?us-ascii?Q?iLgSja3CQY4sakfdZJAmca0qrErQMVKIuRez7iQnsWoqWIDfFHI7P34NoKZK?=
 =?us-ascii?Q?C1DwVRoePSlBvJYP0BGZ6qTZKjbk9n5FBBEhlofKpxdGA5GTJhQmLiFqZV5o?=
 =?us-ascii?Q?m2RJE9+dvRZka9kkPejceXEHrlyguZo3Z/wZF9yRjKIomYyZrLG9fxTfWXhs?=
 =?us-ascii?Q?PuSsJq1rZd7bzQxNW80GXexrJRAFYEo6iFZGvkQbPKlq8HlyE4e5MyTLH9RN?=
 =?us-ascii?Q?/IutdadjjOXxPMwekRMkL23aL8Zb4OKSycqKY3s2rKspnXGOOixrzkcR+HB4?=
 =?us-ascii?Q?8srL55kWJE0YurWrYkUiUPulZOa7PjK3/FbbHvlB6ZoJCoGURGsI0P7o9+9D?=
 =?us-ascii?Q?P1WVzLTT+ElwNB3G3fNDzvyolLF1XlVxD1m5PgNZPW2igSCmsOq7NPr7rWvp?=
 =?us-ascii?Q?6Rvvc0jr7VAQyLhhwN5iNRQ6xDXRhqtrvh9VNWU0YYNcayRHUIBdAQky1bEB?=
 =?us-ascii?Q?KISjJBCKBpeKswGlh/rzUNuzHLSA1PlInQvhFDDkq4jOZxNXEOg2ap644Dc0?=
X-MS-Exchange-AntiSpam-MessageData-1: dvFRA6OgBLhipw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fd8ca9-4aba-46d0-188a-08dec21402ea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 08:33:53.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAvgQ8wrt7GIX2CQArrGvfBY3MMfyh4hgxaC6qyavrEWLCmYnzyw4xkEZE5plkiYZzDEb43lFH+xZLHRM2BrOXl5yliirGGOeRzqgohKu5/6eGmgqaKhx12J8Kget+bjCuUiJPpPWXgQL9Lk76WEBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24AD563E161

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The basic flow parser in tc_add_basic_flow() does not validate match
keys before proceeding. Unsupported offload configurations such as
partial protocol masks, non-IPv4 network proto, or non-TCP/UDP transport
proto are silently accepted instead of returning -EOPNOTSUPP.

Add validation to return -EOPNOTSUPP early for:
- No network or transport proto present in the key
- Partial protocol mask (only full mask supported)
- Network proto is not IPv4
- Transport proto is not TCP or UDP

Also propagate -EOPNOTSUPP from the basic flow parser in tc_add_flow()
to fail early rather than continue with subsequent parsers.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index d78652718599..869f84756ca5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -446,6 +446,7 @@ static int tc_parse_flow_actions(struct stmmac_priv *priv,
 }
 
 #define ETHER_TYPE_FULL_MASK	cpu_to_be16(~0)
+#define IP_PROTO_FULL_MASK	0xFF
 
 static int tc_add_basic_flow(struct stmmac_priv *priv,
 			     struct flow_cls_offload *cls,
@@ -461,6 +462,25 @@ static int tc_add_basic_flow(struct stmmac_priv *priv,
 
 	flow_rule_match_basic(rule, &match);
 
+	/* Both network proto and transport proto not present in the key */
+	if (!match.mask || !(match.mask->n_proto || match.mask->ip_proto))
+		return -EOPNOTSUPP;
+
+	/* If the proto is present in the key and is not full mask */
+	if ((match.mask->n_proto && match.mask->n_proto != ETHER_TYPE_FULL_MASK) ||
+	    (match.mask->ip_proto && match.mask->ip_proto != IP_PROTO_FULL_MASK))
+		return -EOPNOTSUPP;
+
+	/* Network proto is present in the key and is not IPv4 */
+	if (match.mask->n_proto && match.key->n_proto != cpu_to_be16(ETH_P_IP))
+		return -EOPNOTSUPP;
+
+	/* Transport proto is present in the key and is not TCP or UDP */
+	if (match.mask->ip_proto &&
+	    match.key->ip_proto != IPPROTO_TCP &&
+	    match.key->ip_proto != IPPROTO_UDP)
+		return -EOPNOTSUPP;
+
 	entry->ip_proto = match.key->ip_proto;
 	return 0;
 }
@@ -598,6 +618,12 @@ static int tc_add_flow(struct stmmac_priv *priv,
 		ret = tc_flow_parsers[i].fn(priv, cls, entry);
 		if (!ret)
 			entry->in_use = true;
+		else if (ret == -EOPNOTSUPP)
+			/* The basic flow parser will return EOPNOTSUPP, if a
+			 * requested offload not fully supported by the hw. And
+			 * in that case fail early.
+			 */
+			break;
 	}
 
 	if (!entry->in_use)
-- 
2.43.7


