Return-Path: <netdev+bounces-295573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7iSPAcYsImroTQEAu9opvQ
	(envelope-from <netdev+bounces-295573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:56:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0D96448D1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:56:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=mDFpb+o5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295573-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295573-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C386D306989F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED513E8341;
	Fri,  5 Jun 2026 01:46:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1E3E7152;
	Fri,  5 Jun 2026 01:46:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623991; cv=fail; b=InzCFFZVL65XHhFrEy8Fs9JQT4Tgm24gCtxPkCj3igQ7HQPuTJMWFITj60jnlB4FVr/f/B/HT7Kvlb4MOnKfXfVMNcwY33HgI63Y0aTsPjw9B6MW9g7q1QKKUcYzb44UI1uliaIXAnOIOXn3ikcaRMvTMsf4T6FQkg9HBEx2P3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623991; c=relaxed/simple;
	bh=O0ngp+j/58fXxBWmrxuC/9FJuarRmAquztzWNyhXvlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kDxrxYkac5eZPsJoDmh+zk0oF2KgcpV9mUYjPM0rfnU/5H5ToBDoX7m/l+BxexDye7wh8oIzwIotr2dCgmZSn3ad++vIhFFf5stnFDB0u3dhyaggUO6FGn2cMO5Q2UrHpjUQdotKL1VpJ//X7HRwiQgR/Au6AZRR0TS5ltDMtZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mDFpb+o5; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ2I+BvhjYE5hIwwp6VHAQaOiarttojGBW0hZrcbBYxhcV/O7qwwtZaILZpINezI80NoD0QRG8XYRLz+55Bs9JAnBsLIKOhaXHh7uFRUIpEyqEvX4/6x0ohM0NY9UotUIr5grj4UQbliUlHdjeLa6tvT67KOZQlN9KYqcIJ6iqLqiGPaDV7DPUl1iMxEYHsOo50oW2HxXBXlxk9SNhotfKfcK9yr3SpAJ0OQ8ULDMCLK1zfQlQc4QqiwOiIwKTiYEM+w5DlUf/nt3VROgncjEWi5qCEBkihyaYMsfdFo3uJjJOXcdKCvw3AR8aOHMW86hncVG0Ftq0TzOn744mGgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SadSiZlve6Pfa/DYVsrF8AKVPCeNHW1KS4sT5uw2xQI=;
 b=Y3ur5XbXiSqX1EIgJ6+89MwolPwdxaVh0kBsdK6ZcFekBxXZRSGjnviolgw0iNiOyq3wI5wA8OIzcwCmUP0Zxj2TC1sTmLCmtsz/JKgsGfPfeNz2wHgBopkVaEG1kJijc6htCCRKOI++iIhvZidSAW72e/G/u7e5+jc+ExXLD222yKA1K+XaLsnTREZOh2inbJAXTdEoumDf5jDPSsGjYhFn3kkyd3RCqp36NCnj2rzYNsIRFIKwlWN2EL5UqgztJKD1X6whFw26fEmU7JoJuil2bUXY/Hh8Ejyw05ScenldRXy6DjktSCv1JuwYYqpsRinDcVyiSf9OPCdasCN/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SadSiZlve6Pfa/DYVsrF8AKVPCeNHW1KS4sT5uw2xQI=;
 b=mDFpb+o56cULAIEMAiQuANeYzQoTmOeeTH/oqvfMZukYfkqXvfEjY15yO9UHdmDY19bEc1YxK8m1KDakf1CvKOaIVakAYs/3QI0OFxcHp+l+jQaKc3V/1UvDx6+jGJbjo7du/WMu5o1gJiSAf2YXilTZogRS+qAT8l0e8P1r92mKtZtBd03SDlBy6ysPMiw+v5a+dzSBnVBHBmPdGe4rb8oJNVEyxdWxLFx9KR8EMrF0jWa95qqXhLq5EVrLIbTxtiy/6+WRIyXf7qhC3UqTSm1JtO+EFPjRaeL7Iki2IxM/svBciv6/3fuuqgnUs+77CjumGykXxCbf1knWlejUfw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:55 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:55 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 9/9] net: dsa: netc: implement dynamic FDB entry ageing
Date: Fri,  5 Jun 2026 09:48:08 +0800
Message-Id: <20260605014808.686024-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0f395f-3035-4555-fba9-08dec2a42efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	24jboa+j62lgm1eT9ctIUBWv5HM2Z0Jhd7WM7Wm08QYBt9xbHokLuXYiEf6XYQ0e+Io7vm+g6MSIN8L6YquG2FbB4RR3SvseG7XAbJ14CGDX4w/PDqYHkwjqNr7cZaxGyRBmemjIuEMGYlfVdfKxBeHqJ45E0+1aQ3erWCiG73L7yQcLtwLUC7T+wEYKalnyxMYhaFCa+Tt0okP+ANi2dmrbPn57GbJzhe00WIpmIUqdG4003TUDkv/mY1vGpy0Hghz/JpFFPGlDATC9hEitgT7CmDQkkUK+cI6ifMKJhjWbIifUFFqj3ghuAfTu6RBeX0k3/n9QWUDJW03Yg5ldthweePj07EPnFBtxk+ESrWu3+huzEBwWJzoEkk3fzLN1uFePCmXTprygz4EGF5u+UkZ4fw7uzNqtaCFkYg/NkBvFPNshPUDPPwDbRQI9VTHZlZbQ9Jmfh6O49RvrphfQRGOQ9o1rhEjiRi+Iwkma4JSWThyWcu/1fSoHRTQCmFKXDARrT991k2RwBMXTeE+pY45nNee/ApSFKKYWQnw0s+KgM6wz3EHNSdAWy+a8ICFEIEVJ3SDd6aIh/e/k/F7XTGvQDL/ungonSXfEzERt1WC1GgsXSqh58uW/8BZRVBVi+7Hgq0bjTwxYSYHoKdQrIC4sfVHshkkprOQPD796n4U2tAOrSyesqZrFg8mo3m8yGoPk43YstoJizLg5ep3t0md1BalDKi/RESjfrw3JM7I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OwtE061b69JhjMdw4jzhX6o/EgeHVfkFbmwqbRUQk1DrD9P+z5KM4mGNbckh?=
 =?us-ascii?Q?n9A2DqRRhuA7Oncxap1jci57lWCW4Zk/w8+xYdBcmwqhbRpcA3FVmIDlsVbg?=
 =?us-ascii?Q?Rom66MoxVaUE6Xi9WOzqGlkoFojE6aUxmfdyORPaKGIrOINLi67Kk06Ypyxx?=
 =?us-ascii?Q?decNCBi0VzUO7hl4rwH9kwH2YDOKAtiY2N1WrMOELNbgphNwFeAemAqtgyoR?=
 =?us-ascii?Q?VS6qVhaa38uVOeGj5wRVUwWAP7tsR3/ApioRX2Ou1ApzKmm9PfRVOKzr7VEi?=
 =?us-ascii?Q?mr5jb9fAfUQ3TME/sUYdtxYimKhP6HuQZJP2jRcSIGCS1QpNsBRWw/Aj5cL3?=
 =?us-ascii?Q?A6c7K9yf46LwmhNtJIpQuByQEKqkbS6xBRgYp3UThGICgIKN/bwImcM1W1hL?=
 =?us-ascii?Q?p1/MONsaDjwPyq6EpYpcgYwvkGxDqz0UpgtcOWpI048q0p7hzRMGGLDN20Ht?=
 =?us-ascii?Q?RJkg5G7LnGf5xuHexQOGMg97AgurSM2ukXek19Y/Na64GsbWDiq1vTESK9U3?=
 =?us-ascii?Q?vAWSPkdRa2z4yk+LuDTDiCIii3f9mPwuudAKvrolzHqXQ7WqBIvoZnXDF7wP?=
 =?us-ascii?Q?nCyJtcTReTLYRGyo5e952WpsuGUBFHtIOUvbMF4RJnaY+nIZA9ZWjGaduVcj?=
 =?us-ascii?Q?eJI58g8gYOnIBoYdetFUCoGLtZoQ6XGg6A5VeSghx5fx6wKf9HidyFqTjarW?=
 =?us-ascii?Q?rtwKeVtMG6GDrDPiyLb0xZAdG0dV4cMUeJDqxOF/IKAGH3RPwxqUjxzRwrZx?=
 =?us-ascii?Q?cEbS8XuJZ4zMvob/84P4BEaT1T9Y6794B9MpV+SJ5073JOod/Om+5riOLJJg?=
 =?us-ascii?Q?I4EzTm3n6av0Gwd4phO+IuXfL5uVc2B3DNcTb5qqR/3Ltp8poFJMUhYqRM1G?=
 =?us-ascii?Q?CcmU/Tc/O6/Kc2YgScNVH/5cps3hNiNR36ooh6Y+LY1YXL1/qNVfGkzI/ESl?=
 =?us-ascii?Q?PkM0goRgEWN/17RpckUEq+/JCi7eVMgpu80Uxp2/i+9K7MP49yQfKs0F61QF?=
 =?us-ascii?Q?e8XdlmQRzL4hqN9zW8wP11fd8zFHhqmE9WrCpYeitoB/S2U+wL6Teoy//Tfq?=
 =?us-ascii?Q?wdadWaAVIDpkKgJTYi85/Kmajupc5FZSUl2zV/k3mYKAmrcICwBkhKJZFUEJ?=
 =?us-ascii?Q?Xe4k5KNq4poId9d01bCxh0JTAXJk0ECWYH9KToV2arwgGl7rW20PweuZt7kY?=
 =?us-ascii?Q?1uVeNTBPUgyYxyDKGjEc7JCdnuqlGj7P8X110X3it8ZWkiA4c+vA2DFWS5E4?=
 =?us-ascii?Q?qBnyVjF7qhP8zVQgrXejzN6q4/uDAozz0roZf8bkiEWCrgjl6uANjmx+EAun?=
 =?us-ascii?Q?kXXmliOVxsfKujK62oPMBpVrwWS0I4dQ73bFdCl0TRSk294p1B8fbTTy1wV/?=
 =?us-ascii?Q?oCnRECAEgoL+hwuueFzGjldqor1mVnnPTjKEv4G1zxRUqGhbKCuv+mpT4ppx?=
 =?us-ascii?Q?t1HPllBsmHUIcUGYHltx81n+ggxxbt/jKbE4SdxnoKVZ3ZbgSFHn6MvZ6tTD?=
 =?us-ascii?Q?TQgHviQv5AXsv414bTUiVfLNNyHGr0yCveOLUrjqiHvfQijwBnJDHtAJh/mU?=
 =?us-ascii?Q?70loh3uT2Rk7aLgRx419sNRCsHOvYURt4p+YxQ6iorQL6fNaxavebHTUSRyl?=
 =?us-ascii?Q?4RggRH+btjGT07pCx6w4pN0xYORIqUr8dlowWx+6+H4hdiCuNyQDztdhANZl?=
 =?us-ascii?Q?1vyR3g1BrVVV0/cxlXizTYIKpsfmkXh1vk06WzUjkEaaY74czygpdiakwS2s?=
 =?us-ascii?Q?uGXSaqQyIljymWY/TAP+AFVqlxNyqTYt8QJbC8bKfw0oO3RhfR0k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0f395f-3035-4555-fba9-08dec2a42efd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:55.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyZCP5N/pJJFnt2gyGakmVYSP/ZyfjWpbPg4vlHtfiMIE2mCdFbgSdb2SDrKbha9+rpIO1Zuzgs9nr46x1+8b6TO/M2WAHWoElGMSH9AkadqHEqvXjWoylb8oA040VIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295573-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,oss.nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D0D96448D1

From: Wei Fang <wei.fang@nxp.com>

The NETC switch does not age out dynamic FDB entries automatically.
Without software management, stale entries persist after topology
changes and cause incorrect forwarding.

Add a delayed work that periodically removes entries that have not been
refreshed within the specified cycles. The effective ageing time is:

  ageing_time = fdbt_ageing_delay * 100

Default values are 3s interval and 100 cycles (300s total), matching
the IEEE 802.1Q default ageing time. The work starts when the first
port joins a bridge (tracked via br_cnt) and is cancelled when the
last port leaves. All FDB operations are serialized under fdbt_lock.

Implement .set_ageing_time() to allow the bridge layer to reconfigure
ageing parameters on demand.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 67 ++++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  7 ++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index b61152c16e7b..a8e036a7046c 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -447,6 +447,25 @@ static void netc_free_ntmp_user(struct netc_switch *priv)
 	netc_free_ntmp_bitmaps(priv);
 }
 
+static void netc_clean_fdbt_ageing_entries(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct netc_switch *priv;
+
+	priv = container_of(dwork, struct netc_switch, fdbt_ageing_work);
+
+	/* Update the activity element in FDB table */
+	mutex_lock(&priv->fdbt_lock);
+	ntmp_fdbt_update_activity_element(&priv->ntmp);
+	/* Delete the ageing entries after the activity element is updated */
+	ntmp_fdbt_delete_ageing_entries(&priv->ntmp, NETC_FDBT_AGEING_THRESH);
+	mutex_unlock(&priv->fdbt_lock);
+
+	if (atomic_read(&priv->br_cnt))
+		schedule_delayed_work(&priv->fdbt_ageing_work,
+				      READ_ONCE(priv->fdbt_ageing_delay));
+}
+
 static void netc_switch_dos_default_config(struct netc_switch *priv)
 {
 	struct netc_switch_regs *regs = &priv->regs;
@@ -872,6 +891,10 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	priv->fdbt_ageing_delay = NETC_FDBT_AGEING_DELAY;
+	atomic_set(&priv->br_cnt, 0);
+	INIT_DELAYED_WORK(&priv->fdbt_ageing_work,
+			  netc_clean_fdbt_ageing_entries);
 	INIT_HLIST_HEAD(&priv->vlan_list);
 	mutex_init(&priv->vft_lock);
 
@@ -936,6 +959,7 @@ static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
+	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
@@ -1961,6 +1985,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 				 struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	int err;
 
@@ -1988,6 +2013,10 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 out:
 	netc_port_remove_host_flood(np, np->host_flood);
 
+	if (atomic_inc_return(&priv->br_cnt) == 1)
+		schedule_delayed_work(&priv->fdbt_ageing_work,
+				      READ_ONCE(priv->fdbt_ageing_delay));
+
 	return 0;
 
 disable_mlo:
@@ -2014,6 +2043,7 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct net_device *ndev = np->dp->user;
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	bool mc, uc;
 
@@ -2021,6 +2051,9 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
 	np->pvid = NETC_STANDALONE_PVID;
 
+	if (atomic_dec_and_test(&priv->br_cnt))
+		cancel_delayed_work_sync(&priv->fdbt_ageing_work);
+
 	netc_port_remove_dynamic_entries(np);
 	uc = ndev->flags & IFF_PROMISC;
 	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
@@ -2041,6 +2074,37 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
 }
 
+static int netc_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct netc_switch *priv = ds->priv;
+	unsigned long delay_jiffies;
+
+	/* The dynamic FDB entry is deleted when its activity counter reaches
+	 * NETC_FDBT_AGEING_THRESH (100). Each delayed_work tick increments
+	 * the counter by 1 if the entry is inactive.
+	 *
+	 * Therefore:
+	 *   msecs (ms)    = NETC_FDBT_AGEING_THRESH * delay_ms (ms)
+	 *   delay_ms      = msecs / NETC_FDBT_AGEING_THRESH
+	 *   delay_jiffies = (delay_ms / 1000) * HZ
+	 *                 = (msecs * HZ) / (1000 * NETC_FDBT_AGEING_THRESH)
+	 *
+	 * Use DIV_ROUND_CLOSEST_ULL to perform a single nearest-jiffy
+	 * rounding, avoiding the two-step rounding error of the intermediate
+	 * delay_ms approach.
+	 *   Maximum error = +/-0.5 jiffy * 100 = +/-50000/HZ ms.
+	 */
+	delay_jiffies = DIV_ROUND_CLOSEST_ULL((u64)msecs * HZ,
+					      1000 * NETC_FDBT_AGEING_THRESH);
+	WRITE_ONCE(priv->fdbt_ageing_delay, delay_jiffies);
+
+	if (atomic_read(&priv->br_cnt))
+		mod_delayed_work(system_percpu_wq, &priv->fdbt_ageing_work,
+				 READ_ONCE(priv->fdbt_ageing_delay));
+
+	return 0;
+}
+
 static void netc_port_fast_age(struct dsa_switch *ds, int port)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
@@ -2332,6 +2396,7 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_vlan_del			= netc_port_vlan_del,
 	.port_bridge_join		= netc_port_bridge_join,
 	.port_bridge_leave		= netc_port_bridge_leave,
+	.set_ageing_time		= netc_set_ageing_time,
 	.port_fast_age			= netc_port_fast_age,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
@@ -2381,6 +2446,8 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = priv->info->num_ports - 1;
+	ds->ageing_time_min = 1000;
+	ds->ageing_time_max = U32_MAX;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 982c8d3a3fbf..305f2a92e2f9 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -50,6 +50,9 @@
 /* PAUSE refresh threshold: send refresh when timer reaches this value */
 #define NETC_PAUSE_THRESH		0x7FFF
 
+#define NETC_FDBT_AGEING_DELAY		(3 * HZ)
+#define NETC_FDBT_AGEING_THRESH		100
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -124,6 +127,10 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct delayed_work fdbt_ageing_work;
+	/* (fdbt_ageing_delay * NETC_FDBT_AGEING_THRESH) is ageing time */
+	unsigned long fdbt_ageing_delay;
+	atomic_t br_cnt;
 	struct hlist_head vlan_list;
 	struct mutex vft_lock; /* VLAN filter table lock */
 
-- 
2.34.1


