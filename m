Return-Path: <netdev+bounces-305340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5Z4rNKO9TGoZpAEAu9opvQ
	(envelope-from <netdev+bounces-305340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7587195A2
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:49:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=eywq45nZ;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305340-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305340-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 271BF304AC34
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B52B37472F;
	Tue,  7 Jul 2026 08:47:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256B34E75D;
	Tue,  7 Jul 2026 08:47:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414034; cv=fail; b=MZYQJDKVH8GaWbkC/xgiS4h4gTh/0c9T4znYg5LEDhbG5wi+vCara4aMYUa7wjSpMTyWk1UsVVvV7Fos+zSXHsFhLLawRiPuxSe9e9hYhJ/6Gg80qKz8RFVWLfZFRhB8iQMjOWWYbJEo/h6W6kJrSYHVC4NMDBEukSHIuJgT6Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414034; c=relaxed/simple;
	bh=M2p3/EWdecM17tBDI2KHGMdi4oXMrt1tHiizKl71D9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DsIEltZwoz2nuBmEo1Y81h0CLfqaMXbTreXHF4UEsRSNY+PF6aAaINPdmFSjh/lGq6IEOGy2tjE4EOXsmLOKTSxv49dGufbPIwmZHAhKOzv06Ba1huClWUFU0Y+516uqZER54EQV2r7DKCqEOdgx4hesHS6EZxkP66efW/UKHXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eywq45nZ; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKJVNcFA7Gct+V/MR1ZsBmaqZH5vUj8lFmqJVztO3Q7pCMHiKbfV7gc5k1oZ1ajHyUTiiEYJXKwlQsXym/Dw5tDOhHwKoOAQ+AJVMLK26jZ60HHGmK+znHL35GDeESFSrN/aaCDVcxFFWJtxPiuyJfghOYw4/jbcplCQWcDcqXF1TrcmOJ3XtBFT6pcKENMZIP9htQPKgZ3+3y0rY+2J/m+sqrcxZUemlxKWRoN2VEX6dC+TZgdSi/cil+bpYWI9Xp9BoEZGMud+FZlNQMq8Ii59/EjhBYOQwpVvvE+ZB7rHpGeyk+E53OOqjA2osafhQJ9m+ZqL5nbpaQfqztIeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=UwFZZmHdiBny5hCynh1gNypoJzpOGxTXIhGLfCbfOBl6agEjtF9LBRWwjmX5cLN1a+OmcHyjYZLm9Vq9kU/6Jfpr7FTKS0cs/eGrSRff2/QdNN5wJfdl/aIby2YwljPbP8I3Mzv14kz986XAr5mDwXGPBclCsmzRn7tRL/SrixMX0SaLA7Y56+j866U7jK3XjdresbSvBWRmcxs8BTmNQmnXkfS+GdHBwf1uYJUruJWL8/kGyl9RVsmwoTXgrljTAjoSte8kYFYLTcLQ/NWw/X5EGlwcrM5YPAAJqfPG8ZPXFoHNwAsHUhMQlgISw9kiPZTGNnUdeyU2iIAzyAaG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=eywq45nZV4aeflakdBvNAyJ4b+cr7gaOCEvahBmyQ8yetBdj0txlOtj18kvvVPK+UXPzSj4IY5c6pwVtFy4JhumbdjCNMSMPDjV5KzxZV6DYRRTo9BWvAsg+T+Wk2trV9siHKWd9N0F424znGnVncvQlk4he3XAWYpusdxfbDRgekluGe0HSfdVBT7ZEwR/xmVmvGZKargdvUAE7Ri+54RGxX6TiP5c9cqwwjTp3JPRL7Tgt2fcukmrLdNVXd1pQAgWtXBD9R3BDjEMLA0urgezDJLAn4/8NrW2hcHenErX3YVWpGhnf8y968uN4Qk1+8Mo5xzk9UGeK7I3goLdXWw==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:09 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:09 +0000
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
Subject: [PATCH v4 net-next 03/14] net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
Date: Tue,  7 Jul 2026 16:18:23 +0800
Message-Id: <20260707081834.710730-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0320.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e24ca2e-d03c-459a-9fe9-08dedc0454b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	wrsmd0XAG5k52ZXtO8aC+kQteB1qfsvAFenQak7ANTAIIT8vp8QuoGPvnMJ2xjePoI6XLr9tvir8iZRW8yWJFInSqqd6Ss7+i8A3dCIdiz+XlgJIi+vP5AWtaftWmuWBMJy56iezz8nOCQH+oc8W3PAyA+RWHEbecP+JE/0g9baaC34t70XDvXDdWdslt0zFUGBwfwYTgQyK3P6d4gpNt9snoTU0PbPe2bTpl1tJICW0s/vwEhRz0tySb6/rkbaykRPDMMpkVsBUtToeOQ/EtI3/qRAlol1pZKVowBl49R69ZUqd5Z2842SP8nG94nISZPAOzW4CApe2q04viNvs231eXa+MYfyj7erZ3s8cmppYhlNx2oBXYpSFUr064wov6utI+UU7gevtaTrh0OZRjuk9O3+q1unYD6KgpwL8wQdLlhMEshs+wvG53vzFvl0rznPRfmMb56UrcOTWsSnr8Y0h0dUgIdZcBQb1sM0Y7+bSK4kZBgUdJ/7rnOZrHKge4HrCkUdEIB8aXRlZyKEDsnTkFur/03P4qo5KYfQYDZiPuNr36PGYNnUhMJ5THRk6LrlwDtMjHenBgnc/LuNdbqNADhCjQm5mV5Q8Ldq6/ZQkiNS/9SiYGbFajciv5zBV66Us6yTp9z89Ez+lgYzX8wSpdgiuYj0+8XSJQixdgN2+yk/N8Z+/l5STbcXtab9KJVlEIwO+otfJjQ+SCZcFjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obVfsns+f3OAf770YvBrUAZloQ8yaYVbQ8JLLJIDZ2Xg/5oYEgV14ToTM72c?=
 =?us-ascii?Q?qe5OQn8hhdmlS81QRX7IrL2yIPJklAH1j6s/Com9pG7alTPaQ5snfq7mDlkw?=
 =?us-ascii?Q?dRLVxiRGoRJlrEd4vSOEircN531R9l5JOLDPEIXBCeAr71RNYIdg8+eHHgSX?=
 =?us-ascii?Q?+cIX+tUXl2LoAdgRGO/we19x55CdmdekorA4inQ6Vs0/9x5f6R6usdvdb/4W?=
 =?us-ascii?Q?uZoV25gFqa/tXLEE+0gGsWfAQHxIb4f3eCtihtMGnAUZ3OywhQf2WyVPSzJE?=
 =?us-ascii?Q?qkNLeRsn888m4g8MVwzechFxCQelHygLN6d+aTvH8IwSkCQNDd4Ikr9XwPFg?=
 =?us-ascii?Q?XYl6Ik/zuQjgGWyhOD11JvDug1sFIwhmHTXPfJyHGTaR64U63v183cF/en8d?=
 =?us-ascii?Q?0JkbzBERL0HOSxgnZBW/kilBuYjEqLa4rQl7odkzfPVqcisJPqGnMnN7mLQO?=
 =?us-ascii?Q?KGQuIJd/8LoZnFsz8ullQA4AKotAF3cY6pWTbiCQ3I3JquuvLRgX8sg8DlZO?=
 =?us-ascii?Q?qXck9wxCLa9TskATmssavKDQLea4WrW1BGyRREFNgY4XhxPAYlaA15CMTArz?=
 =?us-ascii?Q?ATbXHZ3p54bpEyqSvyA4gQcaOpTctAiZh5YgLPg6UPvaSuZdvp8UE8shlocA?=
 =?us-ascii?Q?rp4WBCXec2lWnPCtMaDE1Fw2l3dwUvuwxjj+/pgEt680nwfOIj+hy/E8wqTv?=
 =?us-ascii?Q?oQVLtnbQi3HIIGz2zfh6Ww/tJIEpN2Mv+/lMLqpjUr2SwC/QzLvxB3XvXyIR?=
 =?us-ascii?Q?ssJbkXthOmb98LqkEMbhJ1KSL0Q84YCJGh/n7PhBSct2M4GD2WuEnqDLK9z6?=
 =?us-ascii?Q?imp1q72znI36M5pxL9Uq/eJGin4rIxMTyg7PgI/GVXEUQEaVvgtfM1BcvLLY?=
 =?us-ascii?Q?H6SIVelOZJ+B8UQGvq0TFi8dwVYVvKWRDZ+ivxP7GP7I1e8qUCkdrIYLqIuX?=
 =?us-ascii?Q?Nntrm6mXeUnCCP4Ny1D0nugFx7yp+wiA92slHfDxt5mTRgnhVaQbKpR1idtF?=
 =?us-ascii?Q?GjfZe8MmPBSc2I9UmAcqJ+iPwtUbfq1S2bkz3WPjMIp0kGysBuItdGUpcFt7?=
 =?us-ascii?Q?BAhhT4OLD3Vfd0lFsu8GU8548eu5hKbB+IrN420Jz01Jan8cDAdvrfPDiIrT?=
 =?us-ascii?Q?tCmsCMglk9gtgS+bGTW0FmJu885FddGKUjlNQyO+pB5fVOc7Ro2qAY3nQufj?=
 =?us-ascii?Q?mr4EIHtdQbu9CtUd6/96+0ZiagbI7uppJZoBSiIMBlgkxbMiIaPT0WCF/gnJ?=
 =?us-ascii?Q?00MH5csED2NQhppoyGB61NSkJNLqPQA5BbpHvD2HNITDI8j49o22ny+k8qtF?=
 =?us-ascii?Q?Ir41ffTHdC0MVDggAJyzWCAeId8GPI8e5YGvyJ9k9AdzOWnKEwf1Ngc2ffHZ?=
 =?us-ascii?Q?sJ0PaLBmkqV3fRcR0PI7VMYcqgqZoOULnBf4CXznCzZh0EYqG+miqb8sUcew?=
 =?us-ascii?Q?CAmeamqtm6Scew9RXZ6yyNXpuSvPJNV24LbjIwbAKz8870oSlpOpbitB6sgP?=
 =?us-ascii?Q?hD0aoH02OHERF2Vdf1zdRaFECu0iB0DfS4hE6SPdzSErNau8akWwLGxMhY3V?=
 =?us-ascii?Q?suoD8crj1LT4uoBIC1lM+68wZvSfU2+GN/ARZferYoev7ce/tmnbcp9q9+vE?=
 =?us-ascii?Q?BFWh/WNuxP/6k01AYlHQuKFafQLfi2PpnS0sYhzJmUoujMs5Z2Q87oQ0s+mQ?=
 =?us-ascii?Q?OGe7CTX31hXuCLSvUyifU/YukZRD3U2l7LLfwQbTYvvH34bjQb63tAFC38aO?=
 =?us-ascii?Q?llY70L5fOUUdsQsWrwB7MMBtCrpS841UXBIQWzcCenKBiAOYE2IT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e24ca2e-d03c-459a-9fe9-08dedc0454b5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:09.3981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0Gn+px0atIRFDSn7yUts8WNRoR3XK3p/be2ce/1yvAU0cxtBGpSGfJWws6r+Jb8kQgm7zzOyy9UPiGNHt1BaHyo7H4uVXkThGFGle7+ezzqHsozvIzyWR6XFjGjZ0TL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305340-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C7587195A2

From: Wei Fang <wei.fang@nxp.com>

The current ndo_set_rx_mode() is called under netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. To work around
this limitation, the enetc driver uses a dedicated workqueue to defer
MAC address list updates to a sleepable context.

Since commit 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and
netdev_rx_mode_work") introduced the ndo_set_rx_mode_async() callback,
drivers can now handle address list updates directly in a sleepable
context.

Therefore, convert the enetc driver to use ndo_set_rx_mode_async() and
remove the dedicated workqueue and the deferred work item accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |   2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 178 ++++++------------
 2 files changed, 58 insertions(+), 122 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 04a5dd5ea6c7..06a9f1ee0970 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -324,8 +324,6 @@ struct enetc_si {
 	const struct enetc_drvdata *drvdata;
 	const struct enetc_si_ops *ops;
 
-	struct workqueue_struct *workqueue;
-	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 48a74db90ed5..a02b01753ff2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -101,24 +101,23 @@ static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
-				      struct enetc_mac_addr *mac,
-				      int mac_cnt)
+				      struct netdev_hw_addr_list *uc)
 {
 	struct maft_entry_data maft = {};
+	struct netdev_hw_addr *ha;
 	u16 si_bit = BIT(0);
-	int i, err;
+	int err;
 
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
-	for (i = 0; i < mac_cnt; i++) {
-		ether_addr_copy(maft.keye.mac_addr, mac[i].addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, i, &maft);
-		if (unlikely(err)) {
-			pf->num_mfe = i;
+	netdev_hw_addr_list_for_each(ha, uc) {
+		ether_addr_copy(maft.keye.mac_addr, ha->addr);
+		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
+					  &maft);
+		if (unlikely(err))
 			goto clear_maft_entries;
-		}
-	}
 
-	pf->num_mfe = mac_cnt;
+		pf->num_mfe++;
+	}
 
 	return 0;
 
@@ -128,23 +127,29 @@ static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 	return  err;
 }
 
-static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
+static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
 {
-	int max_num_mfe = pf->caps.mac_filter_num;
-	struct enetc_mac_filter mac_filter = {};
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_addr *mac_tbl;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[UC];
 	struct netdev_hw_addr *ha;
-	int i = 0, err;
-	int mac_cnt;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, uc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(pf->si, 0, hash);
+}
+
+static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
+{
+	int mac_cnt = netdev_hw_addr_list_count(uc);
+	struct enetc_si *si = pf->si;
 
-	mac_cnt = netdev_uc_count(ndev);
 	if (!mac_cnt) {
-		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -152,79 +157,42 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 		return 0;
 	}
 
-	if (mac_cnt > max_num_mfe) {
-		err = -ENOSPC;
-		goto unlock_netif_addr;
-	}
-
-	mac_tbl = kzalloc_objs(*mac_tbl, mac_cnt, GFP_ATOMIC);
-	if (!mac_tbl) {
-		err = -ENOMEM;
-		goto unlock_netif_addr;
-	}
-
-	netdev_for_each_uc_addr(ha, ndev) {
-		enetc_add_mac_addr_ht_filter(&mac_filter, ha->addr);
-		ether_addr_copy(mac_tbl[i++].addr, ha->addr);
-	}
-
-	netif_addr_unlock_bh(ndev);
+	if (mac_cnt > pf->caps.mac_filter_num)
+		return -ENOSPC;
 
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
-			ENETC_MADDR_HASH_TBL_SZ);
-	enetc_set_si_uc_hash_filter(si, 0, hash);
+	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
+	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
-
-	kfree(mac_tbl);
+	}
 
 	return 0;
-
-unlock_netif_addr:
-	netif_addr_unlock_bh(ndev);
-
-	return err;
 }
 
-static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *mc)
 {
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_filter *mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[MC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
-	if (type & ENETC_MAC_FILTER_TYPE_UC) {
-		mac_filter = &pf->mac_filter[UC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_uc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_uc_hash_filter(si, 0, hash);
-	}
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, mc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-	if (type & ENETC_MAC_FILTER_TYPE_MC) {
-		mac_filter = &pf->mac_filter[MC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_mc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_mc_hash_filter(si, 0, hash);
-	}
-	netif_addr_unlock_bh(ndev);
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_mc_hash_filter(pf->si, 0, hash);
 }
 
-static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	/* Currently, the MAC address filter table (MAFT) only has 4 entries,
 	 * and multiple multicast addresses for filtering will be configured
@@ -232,15 +200,16 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 	 * unicast filtering. If the number of unicast addresses exceeds the
 	 * table capacity, the MAC hash filter will be used.
 	 */
-	if (type & ENETC_MAC_FILTER_TYPE_UC && enetc4_pf_set_uc_exact_filter(pf)) {
+	if (type & ENETC_MAC_FILTER_TYPE_UC &&
+	    enetc4_pf_set_uc_exact_filter(pf, uc)) {
 		/* Fall back to the MAC hash filter */
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_UC);
+		enetc4_pf_set_uc_hash_filter(pf, uc);
 		/* Clear the old MAC exact filter */
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC)
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_MC);
+		enetc4_pf_set_mc_hash_filter(pf, mc);
 }
 
 static const struct enetc_pf_ops enetc4_pf_ops = {
@@ -467,17 +436,17 @@ static void enetc4_pf_free(struct enetc_pf *pf)
 	enetc4_free_ntmp_user(pf->si);
 }
 
-static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
+static int enetc4_pf_set_rx_mode(struct net_device *ndev,
+				 struct netdev_hw_addr_list *uc,
+				 struct netdev_hw_addr_list *mc)
 {
-	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
-	struct enetc_pf *pf = enetc_si_priv(si);
-	struct net_device *ndev = si->ndev;
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
 
-	rtnl_lock();
-
 	if (ndev->flags & IFF_PROMISC) {
 		uc_promisc = true;
 		mc_promisc = true;
@@ -500,17 +469,9 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
-	enetc4_pf_set_mac_filter(pf, type);
-
-	rtnl_unlock();
-}
+	enetc4_pf_set_mac_filter(pf, type, uc, mc);
 
-static void enetc4_pf_set_rx_mode(struct net_device *ndev)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_si *si = priv->si;
-
-	queue_work(si->workqueue, &si->rx_mode_task);
+	return 0;
 }
 
 static int enetc4_pf_set_features(struct net_device *ndev,
@@ -540,7 +501,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_start_xmit		= enetc_xmit,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
-	.ndo_set_rx_mode	= enetc4_pf_set_rx_mode,
+	.ndo_set_rx_mode_async	= enetc4_pf_set_rx_mode,
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
@@ -983,19 +944,6 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 	enetc_mdiobus_destroy(pf);
 }
 
-static int enetc4_psi_wq_task_init(struct enetc_si *si)
-{
-	char wq_name[24];
-
-	INIT_WORK(&si->rx_mode_task, enetc4_psi_do_set_rx_mode);
-	snprintf(wq_name, sizeof(wq_name), "enetc-%s", pci_name(si->pdev));
-	si->workqueue = create_singlethread_workqueue(wq_name);
-	if (!si->workqueue)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int enetc4_pf_netdev_create(struct enetc_si *si)
 {
 	struct device *dev = &si->pdev->dev;
@@ -1036,12 +984,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	if (err)
 		goto err_link_init;
 
-	err = enetc4_psi_wq_task_init(si);
-	if (err) {
-		dev_err(dev, "Failed to init workqueue\n");
-		goto err_wq_init;
-	}
-
 	err = register_netdev(ndev);
 	if (err) {
 		dev_err(dev, "Failed to register netdev\n");
@@ -1051,8 +993,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	return 0;
 
 err_reg_netdev:
-	destroy_workqueue(si->workqueue);
-err_wq_init:
 	enetc4_link_deinit(priv);
 err_link_init:
 	enetc_free_msix(priv);
@@ -1070,8 +1010,6 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
-	cancel_work(&si->rx_mode_task);
-	destroy_workqueue(si->workqueue);
 	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
-- 
2.34.1


