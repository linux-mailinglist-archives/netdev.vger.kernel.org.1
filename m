Return-Path: <netdev+bounces-295692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j7aBIhp7Imq/YAEAu9opvQ
	(envelope-from <netdev+bounces-295692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:30:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC3645FD3
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:30:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=CmD8vmC9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295692-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295692-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FC0D30A505B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1247F2F0;
	Fri,  5 Jun 2026 07:24:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684647F2CA;
	Fri,  5 Jun 2026 07:24:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644242; cv=fail; b=E0k9QCxAdIM5O35oSeAEt+Sj/47HYWJrQZi4VlUDjaLnfhNgVEjGCsFaMfbGRxbVcRs1S7oHe94p2H9DSAl3Wa9josJCH/eEYgaWLhsuWcNqm8NO1nmn3VSdmd7NIyRl2elMVI8dEZC8ZrV4kln2GGGUG9MQMXyWOKFg4mgHaJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644242; c=relaxed/simple;
	bh=3g6SHTWxUvuaU60K2pjTQkaAvEsY7mmIj5Z37LApWcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sVJjScBJx5cK81EkKiD6/h3A9Vn5XMpYYbogK1Bm0PMGuYNxoI6VPzwSPjaNt/nDePtKgUjmbOyRCURvkVzh4K4vsBpT33jZ72lAhHpov9cLUC1iQz5SSwRWKXCCEo3d3xwFcyqXJ+IYiEepl3nfwsjlH9Te1KCq7OtpxcS3Ao0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CmD8vmC9; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upDBop+nEW9sXFLfH4xALFbIq62Zw/t52JsU/vqQh5/u/mV5hTDFl/OKtSRUeWOhjYFMijPlsXYutvpWgRn2Rg8qKYEUrHO/I9lUXATX9ucsNB2MIfYcR41xpl/jU6OJn0O13fXI+UM1i8Ikv86lAKydJ01YpnBMbE8tYGRVNmYZssKIbebWeGFDELhoRbieYY/jXnchpl9I+gd+uv93MvU9sNUkt0G0ex/O3SWt9mf6h34mG0VfKf0QmbFYQsQC4N7gN/cJsHvNHqfHOiCqsjemNNFUn/AzC/Woxz4PZnqHQUJ9UyMl0ovmk7xvtlepdmjl1SS/XrSwQFJqiM7WbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+76DPhXYEBsuY+JKg8z0dS6+vIzKyVmWSxqXJS6w/AM=;
 b=hcvAjm5Qd0Fal+3iqaUvVK8lJaexnrixM+aMGtpAsbjzJo+ZQGm1tRuYzyvmBseFfQtYjeJtJBKjU874ANxUP1PNjStYOEDH4A5nctAkr9Uj41zIZRiBAwcBQa0QJClUFRr4uZkRDITLuPtcUXlboWd5+T2sZfUxiZ8c9KHbV0kstXaboNwp88eRMpMTiVtJCfOzoBgOfLq/uFs7RF9yxK+hPEob4CT0V9mfGgLzdixWo+R29yzZ9TmZRmSqts2rFsFmDexEOuu1+mqZT60/ujE7r9TWs9OPp8kIckxDKu19U5A+/CVGe7Y6OHZjegmbf3/B/7mOth6ObzHbFoSN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+76DPhXYEBsuY+JKg8z0dS6+vIzKyVmWSxqXJS6w/AM=;
 b=CmD8vmC9oC8F3MMnoivZGnbPs9//cH9mowIVZXYPh8fjO/JlbBsoPQeCA6tnSGxw93Nm+OdOOXnuGWM8J8wlKX8iUd67ShaiIXDj8zPSq+dCMH/mrZWHVA7nTDIAuVzpsgfM3xCpMhFUEiTR7QyuWeuhqnncvLZZxO3FjbZ9H+5UKTDrAfdDSFFD2kxlu6AizrPyjghQxROziTgWEezvId3v32cMXRk3rcoY1GJOdPUbxvDtcUt6OFna32PP6km9fXcRSIU/QLnp7DSBlbD336XBNvAh51x4Pc6Gts5QzS62VC8grdsYr1ZNpUMuiqprWroZNPuVo2Ih5asI4qQ8mg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:58 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:58 +0000
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
Subject: [PATCH net-next 10/15] net: enetc: simplify and rename PSIIER enable/disable helpers
Date: Fri,  5 Jun 2026 14:55:45 +0800
Message-Id: <20260605065550.3038579-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0123.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9b345f-668a-40ee-0d31-08dec2d36878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	hwYAGAS24CGnKu0/VjyldvP02PHNkgKaVlwhY9wXqWl4ff3XImVCP+sRnuM3ZhLei0Uvd5pMfwxaGkNcb33W/G2LMNt/xun1k7W1XPqh+eHOgbqLPFi/l6F4Uu5e7WsO516n/FWrvNaWyzsf9BHnSC23KZm6SyoTroirOR/KnHXLm3/vnV4t96x80QoNuQ7+GONqfmey2Aa7ZYUK7MmXfd2CvpJfdQL7Wau3hhCFwEa6yq7+MYzyWe0Y3GPE1UVY7z9GJ9eTEu6cRDeCrsE2c5+pihEN93HJfdmP6mGvyUIQLSpw9fX1oDriKZnrM9NXBExE6FUdjcnCnkU99vxbl7DiptQH9jOpUGOnc7qEvDVyGZ8DWtOVRpwKqGpgpKeoOtrZ1pRmdCfqvVI/awgX2ZLYP9aqNcr6l+5sNLtP+UEVTqFvI+iAYtl0RNbEZvNgNrrMFfp9uKHEq8JxQFOt/2tEEBomoIs945+7cLtvkJaIf9ww0hsovNiR7GF2VG/wo5vSnJVTMu6lfS3oBCYGPklnEz7upRZ+ib+fOHtVrrK+8gZIysB2z3Czlurlm8j0WVaTQl+iaou6OJM9DcpYCJVL6TkBG7WQufk1s9EmLnqW0+wXDJlTRRxpPet8EyB+5xTch7TImKivlcIr8coM98QqIetUs9k9IUEBv1cTaE4oVnnY4tL76MGPrX2TaXuB8ypHyq90Cuiw7at1vQDR8yvsMwPI5O+qEx8eEQXqq5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HOBTU7UrVwBygZtrYsLaRVS6q3CDicOhW0fzB0nTpt8HyulC3hAnOmgx/saH?=
 =?us-ascii?Q?9UopeGvgspmKixqWPBUSnRFemPm/hIqyGIQGvx4MN/9mc13csZ4+Ld0f0Ej1?=
 =?us-ascii?Q?PqTvRaHyDhQjYMiDtEINWvBh87Bo4sucV39Zmiog/Pwbj8WdIX6eIhO0KhZz?=
 =?us-ascii?Q?Hqx9CU0o9KQW2zY9t26X9hIcWmdjJBrwrGrTFmoAaJ/ayXk+wprMpTNeQ/8a?=
 =?us-ascii?Q?8/pi3DRMxHez4F+sld98l6AOZPPM5MkEfvvtvHyLpwacFtujYvvuZKwZF9ME?=
 =?us-ascii?Q?yognmfsL/BS4qNu6I+sloX49OCPCzHMLRG2tHf/HZ2h9EemlpAmKBsu/oRpA?=
 =?us-ascii?Q?usz+aSCiAGmyNXX/N03yoHeM30IWkoCTxSoUD9CXx+7lVWh/zsQ6Y/6JkogK?=
 =?us-ascii?Q?ib5oYKUCRS0exsbvWvGemgfmSY5ZH8P7K2t+PpcAaWHZxNe2KkwYKjiXlo6R?=
 =?us-ascii?Q?tlvGaDnxsDpCxW8Ipz6fgP7+8TSGseQ/VMSgeD4iprdG2cQU+l2U7mRWKu2n?=
 =?us-ascii?Q?yP9AN2hRL+ml492G6uGcx1AwqcxQFabzIF5PvGj9BfJtYgihECMp4pZpdr1v?=
 =?us-ascii?Q?qnqNkr4En8EVzBrK2uzY75KLbItim8gOTjjCp5XQGOdyss+3Bc9B/YdUix5n?=
 =?us-ascii?Q?U/DZ3X1l0M4gCGNhY0S4vyrOaHUPVaH1MuxWjtvB+hkkh6i9v4hp67oZbM8V?=
 =?us-ascii?Q?LEzBiFzWS32pk7VEXWuKKFz/QXLOdeBDazA9nnoRKu0LyhVaW+zbvMyL6Q5V?=
 =?us-ascii?Q?TMx9IgfIBt/y/z79RjaVOeMGzFoEy3xPlCfTQz08D2blWJ7yxZStoPy5k7lL?=
 =?us-ascii?Q?73Af3naiuZoRUmDvAkeTA7iQkdrfoXm6s/9aazWdvasWfP16ltlxDweAgFzt?=
 =?us-ascii?Q?SedwWnNlycXkd6FzNyfEQZ5SC8O0DmEHQRrWkpUShhEyar8Gm9dsNuEpbz3a?=
 =?us-ascii?Q?UWHSAeWWjrrsuY264jzN50AzkSuWqlQ2wMO5fUM/fgXxcubhqexoAdH3t39U?=
 =?us-ascii?Q?0m+01NKOB8rNahBYWlyEj65F3B214jnJR419PA8tMhoxXNWhYxZTKGsKEPcj?=
 =?us-ascii?Q?ZDCseHHKZDh5AHM/qolme5iDb74WcneTxdWzYeX0VsqaGmNiCAEA1DhC/ebo?=
 =?us-ascii?Q?gZim67+sBRaKB/ttHcX8Q4RPx6U4X+b1a5Kjo+5Re+gOQS05+hc/zmFynQr+?=
 =?us-ascii?Q?lo4lIVeGDFpyuQu0/v4IWOsDm7JK6t4fgcfZHDzATjWGClCncIDaLeBea+jr?=
 =?us-ascii?Q?cRwaO7nNxLhppJU2wEE9H38gYGl4bVowf3EjtuTRH5DSZlr5COrTAGB998Em?=
 =?us-ascii?Q?7ORj9xoHPXBZtcRIlyjdF6bR3AU85wJtw6qGqlv3SVNwOIZub3K+J0NJAB08?=
 =?us-ascii?Q?nFw3bghs/OYTea5phqGSPwBsw/C1XDwlCSx00GMLMmjI+7drkGSuIH16bBkX?=
 =?us-ascii?Q?1W7k8DO40Q2bYWgsyqWwLDh2/+f7ZTaFIhkXZMosL+OnJDMBQIzwfzsgy0XQ?=
 =?us-ascii?Q?nLfwcm9sNq7kEjh9gZnu3VsGVVh02lhROxEMQk9u3LhYhNHXP00/FAvm/hU8?=
 =?us-ascii?Q?o8uRWLXIclPnJQMHuWRH+AQNZWrBHo0NGhQ3uSpJKdjqFnPBZiJKipbTtXTy?=
 =?us-ascii?Q?fJVTuxap76J0EGyyCO2rG4tGLs1+Xf1OXzscibBerIO5rDaPYXck83HVsXWI?=
 =?us-ascii?Q?uT8rhXm/suL7bq4YW3LBSa8qqQ+VxScHxz0iz1GXlFGLl5QXfkrLkLBzcSgm?=
 =?us-ascii?Q?/W1NPLjEUf5XcG5Q11Z+NOPiZvslIen+KKnMC1yuWEqMll3/alfY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9b345f-668a-40ee-0d31-08dec2d36878
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:58.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDs0TgljH6luu3rqHo0AjhUu++T4l7NgXKgdyHSbBNsxbg2aR4gDJXNmQi5fN/Dt/6+Pd2YBlWEhD4GLRi7OClgQKZ351C9igFnb8GRiCsPK6p1zLDg3jm+ljDaj7eYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
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
	TAGGED_FROM(0.00)[bounces-295692-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,oss.nxp.com:mid,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CFC3645FD3

From: Wei Fang <wei.fang@nxp.com>

The PSIIER register controls two categories of interrupt sources:
message-receive (MR) interrupts, which fire when a VF sends a mailbox
message to the PSI, and VF FLR interrupts, which fire when a VF
performs a Function Level Reset.

The current helpers enetc_msg_enable_mr_int() and
enetc_msg_disable_mr_int() use a read-modify-write sequence to update
only the MR bits in PSIIER, intending to preserve any other bits that
may be set. However, VF FLR interrupt support is not yet implemented,
so PSIIER only ever holds MR interrupt bits at this point. The
read-modify-write is therefore unnecessary overhead.

Simplify enetc_disable_psiier_interrupts() to write 0 directly to
PSIIER, disabling all interrupt sources at once, and simplify
enetc_enable_psiier_interrupts() to write the MR mask directly without
reading the current register value first.

Rename both helpers from the MR-specific names to names that reflect
their true scope, i.e. managing all PSIIER interrupt sources rather
than just the MR bits. This prepares the code for a future patch that
adds VF FLR interrupt support, at which point
enetc_enable_psiier_interrupts() will be extended to also set the
corresponding FLR bits.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 30 ++++++++-----------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 7dcb1dcdec84..d9560e2c5385 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -11,23 +11,17 @@
 					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
 #define ENETC_PF_MSG_SPEED(s)	FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (s))
 
-static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
+static void enetc_disable_psiier_interrupts(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 psiier;
 
-	psiier = enetc_rd(hw, ENETC_PSIIER) & ~ENETC_PSIMR_MASK(pf->num_vfs);
-
-	/* disable MR int source(s) */
-	enetc_wr(hw, ENETC_PSIIER, psiier);
+	enetc_wr(hw, ENETC_PSIIER, 0);
 }
 
-static void enetc_msg_enable_mr_int(struct enetc_pf *pf)
+static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
 {
+	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 psiier;
-
-	psiier = enetc_rd(hw, ENETC_PSIIER) | ENETC_PSIMR_MASK(pf->num_vfs);
 
 	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
@@ -37,7 +31,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_si *si = (struct enetc_si *)data;
 	struct enetc_pf *pf = enetc_si_priv(si);
 
-	enetc_msg_disable_mr_int(pf);
+	enetc_disable_psiier_interrupts(pf);
 	schedule_work(&si->msg_task);
 
 	return IRQ_HANDLED;
@@ -545,7 +539,7 @@ static void enetc_msg_task(struct work_struct *work)
 	}
 
 out:
-	enetc_msg_enable_mr_int(pf);
+	enetc_enable_psiier_interrupts(pf);
 }
 
 /* Init */
@@ -620,8 +614,8 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	/* set one IRQ entry for PSI message receive notification (SI int) */
 	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
 
-	/* enable MR interrupts */
-	enetc_msg_enable_mr_int(pf);
+	/* enable PSIIER interrupts */
+	enetc_enable_psiier_interrupts(pf);
 
 	return 0;
 
@@ -637,16 +631,16 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int i;
 
-	/* disable MR interrupts */
-	enetc_msg_disable_mr_int(pf);
+	/* disable PSIIER interrupts */
+	enetc_disable_psiier_interrupts(pf);
 
 	/* de-register message passing interrupt handler */
 	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 
 	cancel_work_sync(&si->msg_task);
 
-	/* MR interrupts may be re-enabled by workqueue */
-	enetc_msg_disable_mr_int(pf);
+	/* PSIIER interrupts may be re-enabled by workqueue */
+	enetc_disable_psiier_interrupts(pf);
 
 	for (i = 0; i < pf->num_vfs; i++)
 		enetc_msg_free_mbx(si, i);
-- 
2.34.1


