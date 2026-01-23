Return-Path: <netdev+bounces-252850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNVLIcJ9c2mQwwAAu9opvQ
	(envelope-from <netdev+bounces-252850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:55:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB57682B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2BB7301A3B5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BB27FD51;
	Fri, 23 Jan 2026 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D0F9ZRuC"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B71286A7;
	Fri, 23 Jan 2026 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176511; cv=fail; b=qQZDQ/zWKN9J7ykvVUHXPnjYPqv/TkGRrLiC8rdh3U4UVJcChwK7/5ZRj0zcD7rZHeCwAUfuTn3ClMk2rHL+q+OfyoRiGzhaGJVVnC2pmVyyC1pBG1Q0VUxN1ipRdDZult08+IfycFDANZwR16+XNVTJMZ3wVJhojlF6ggKgyw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176511; c=relaxed/simple;
	bh=sVD4EUMTW20O12UdIyUHjfKAA3tI6xI3MgclJpisDYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BWIF4gYRF0vifvTuRWd5qHPQBO+VXEXKesuQ36BVPvuhCsDbXMsVSx2Zbxt/BO+CtwAXkivITLjaSYkNApKVdC16hQg/aTk3pF/9I8+1wz8uwQOCD/Cs8W0rO82nFtXuebgAjLLlbyz8Yw2OVj9Jlp2iQCNY3tCqmHMNiN06MsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D0F9ZRuC; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNjTWDb7pA2mBiXPBsBFbmqlR1CDE5ugpJialIAZfqODzy4/fSi98ciJKlwkLzoS7tgKJRnSCTTmOxdaIxShwMV6WwvkdPVPLPjmm9skk97O3imFWwHOJUOpaS9UmIoE6X6Hhjjh0X9c2TyT+YQHhUchUukLeU2xCKjMxjjRFhUmTeq1YrsaDI87cG5lLVjmdUA14USIQgK99P6QOZy6oNz7xl9g+89urQWLe8IXXBnvN74iyiPfUw4ZL24/LEuDRECqjva+qXsXwwmIF3rDTMTCDeiV9t3X+preEuK8bumcR3BqR7h+FEV5lhw8Lk5uao/3QqqByAy9wLuciEujkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsv/T1hw3wUtYjPAJKcKameIYkFV3VLE/6qJsJTtcAg=;
 b=oT1/gWlqMd2GQ8qsE4dXgLMLmE8wzwiWOoi/bqMYGGdYEbhBGQWTZwi8bqu+gAyTJT4IDi9hvsoj35SIEdtCGaSH//MbYiB3yTTm3ZkwuWd6MLLhdn/Y/VzcRliOs7ZW1dy42NdLpz1xV19VZP+HtDl6d84kcXavOuewrwp1esKmDgvQwSPGQPLBAAdOnZ3fguAk8h6HfTxQ53QK5VCIUt1zGgAE4xoac5B7qh21MomvR6KVGwPgNRG/EnDfzZ93bmEjLVz3pMRth5wyXii8dLxH2vbHHr64dz5E8HWlFn1OOiY5Bf+UH3S8Et9ASIpr01SdH7EyWvc37g5Q7oI0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsv/T1hw3wUtYjPAJKcKameIYkFV3VLE/6qJsJTtcAg=;
 b=D0F9ZRuC9f2HY/Md5FtaiVe4w7eUZOYakKiRAtsPRZfMw/Q9FPoH7vpI1d+K3GaX+Wi+Tbp/y+h3PHHDfR/Xsplv5rCfHkFNSj8TlRXmuGtbAz+h3/W+hiO1Aur70Z49+uKzzqP+Bg86qH/9R5dMnJ41DP9WlCQks47CRpetzSX2tTySwONH8I8xDZJouisK5Dj2Pui2lWr/KbxagR0VRnpTqWXZTppds3QqnihIlD0LYVGJR/LBQEgF6qAX0nriMWTfgQ7fAmhh4SRVQyfCoioWBlmsXNlX+ByxTUXA0XYuY/w3nBfwMRlk1hseiMNDX2fBDslQA47wM4pv40J5Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV2PR04MB11144.eurprd04.prod.outlook.com (2603:10a6:150:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 13:55:06 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Fri, 23 Jan 2026
 13:55:05 +0000
Date: Fri, 23 Jan 2026 15:55:01 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <20260123135501.7m5wqkcfluxqeowb@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
 <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
 <20260122221848.py4p7mwxzybicnsq@skbuf>
 <aXMhWo0NpPK-BELG@smile.fi.intel.com>
 <20260123121529.inik6xrfdianljq6@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123121529.inik6xrfdianljq6@skbuf>
X-ClientProxiedBy: VI1P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::13) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV2PR04MB11144:EE_
X-MS-Office365-Filtering-Correlation-Id: b873fd77-3f7f-443b-ac95-08de5a870302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KOdsM3vTHjVJTxXtNU4Ee5xervvhPwZ31J0TPlAgWAVdU/6PNJzh+l/6Us7R?=
 =?us-ascii?Q?KFQ13SP5uZYn/9Cllhqd+2AhBXdUvn+kW1FpypWVX0jHXdwEXyJIclwUUM8u?=
 =?us-ascii?Q?t+6FHD13tgQEVI4Fni08sVTjrw1siC1R3fj7rWVZtGoiJHtWH17bEov6Ro8o?=
 =?us-ascii?Q?nYgXBr6PhxhSMJTyAy0KSlAxSHx5XvkyISWK52ywZVQplfGEDXSjbKeHf84S?=
 =?us-ascii?Q?EAAVUExtFXevxfswVzAoubYBY7QZ7kUO9MxYp1fhBQroVbLTq9KdcsN40+8T?=
 =?us-ascii?Q?y3Vv//Iigr8Ioli+RRDf3GKfo9okbwy3glZ9aUFCesXoPx1dgCQlBApsnP7e?=
 =?us-ascii?Q?YR44+CgzS+1/wpZivoI8Aj+YSii+J5mF8rdlCZ5aVImC7LEHPvaH00KrFGV+?=
 =?us-ascii?Q?r/FCK2qqGCrFH36/wyT+ZtQkPxTP1EAJ4c/XAKoaTYRLfc5ohGXr0nHIXRxl?=
 =?us-ascii?Q?CJTu2W9NhIKfrlRYS31ANLdBoVXuQqhf7aieT02j7wFOg4OaAAXsxp7mq2C8?=
 =?us-ascii?Q?KMyracdhytV6Y9UyewYkBh12o7wpQRuSu+ThEUXp+7cVwxQCT7s1wL1a0MVx?=
 =?us-ascii?Q?l0fIgyqGm62FATCGbOfsKu2Z+kduMiMGfqYHlqFmlvLjmCEesgUu4GW/Hyub?=
 =?us-ascii?Q?tyr3z5ixt8JcO2OnlYKR3geGSbkcqvYiyDhFAjln1faPlM5vAqTFgF7zMP/p?=
 =?us-ascii?Q?JIRTDInacJWePzaPXx8NqScrPraCNdLTuGAAR6Jud518gouky0wDMBSwdO5w?=
 =?us-ascii?Q?AcdVX7ZSEC55svPI4LgkEfqkZot9FUSgOE8Q0rEzs7cqtvoh6Q4MzwvVE06x?=
 =?us-ascii?Q?owrSqBMYxD4GXKb5aa/z7jwlqmH3z8MJdyhQ+YcJP1TgEm76EMKVae8BoXG3?=
 =?us-ascii?Q?exRSVV4yjVKRXthP7X9dziYU/29Ul+4exRgjFCtyYyAUuahwbHXg01KqVtf0?=
 =?us-ascii?Q?K2jHIzJ+fcC8SwZU+adfBXSd1V0gC2l5hVzMr6wdvJE+YroHmg2oAzgusR1n?=
 =?us-ascii?Q?V9949F5oUreITEIr15G+9g4UcJXTfCZjXnn5ytp2kI45R8SnkV/WaQ4I+Whg?=
 =?us-ascii?Q?GnT2rRmajfrBI6habKaUBPF7yEmQl3DeoTTVJsfcljX7Mr327DeaBfD3zKwW?=
 =?us-ascii?Q?QR+pZWxLZzMtIrAXaddoKxmCK4XgD5tDmQ7leGx27BDrqpy1m2LussRLbouS?=
 =?us-ascii?Q?IJ7f8BwZnWhMzQqvjNJdr6ZiIhOmC9RXpE/hNkRSxGtpMRsiTcSvPL781giZ?=
 =?us-ascii?Q?X4bHrbiMLM46/MKTAjKTJWESkdgUaLhMWm52gXz/tXy5ho4xe8013X2n8fF4?=
 =?us-ascii?Q?gYJm1UMhjqrqeZxxvo1fTmmOULGaRaGvTNYnHiFKoYpMBwwzBAcbMPj6ojZb?=
 =?us-ascii?Q?0NCiP2RovdDvTogSmnnaByX/q+dmDjxlnvWByilRiA7SX4Jhiku2k6jMH3gB?=
 =?us-ascii?Q?4QWdN/5JQXOh0oYTXiJ6S5F/JtS3PAMUBaCMCIGJuxJ1UHq6PcqAParkRyAn?=
 =?us-ascii?Q?Tei+6Ji5McKD6u13ZGKq+K4ZivNpuNwmyf7L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nBtAtiP6WtZbPwPLAeXNR6Hnfc5CLMW7qBT9m2Ux9Gqj2QtZrQV0xhQ4+mGA?=
 =?us-ascii?Q?TcLV0ctOPp3aZ39P6YrnQRapAFXAzG11sIWjg+hfoOzW6Bl1CNQp+gawzXyM?=
 =?us-ascii?Q?IN3VS28ZM9lMvxCO3w+7981RwbAKTmH19Ft6ciqASBbFHLDWCsR9CFfYh9DI?=
 =?us-ascii?Q?RP7sVeYw6mNCw1d5kKhvVPEdZHVvsO1yjpKjt17TcmrnKkP5xTjza5lu8yOi?=
 =?us-ascii?Q?5yxqd9w+GmVwP8aoJ1PdxhANzqMV3SLwf93f89SCq9SlFqZXn1hYijU6BfIq?=
 =?us-ascii?Q?EH5DyTQbZCmH/xmWlW3PK98lGEEgper0Nl+5SusH9GRYvi5LznIhcHyAaDqn?=
 =?us-ascii?Q?gC+S4v5zYBOQNL22fQ90V3v/I/AZzWBZC3xS2T3nF2vjHT7Yjf0Q1Bx8eAF9?=
 =?us-ascii?Q?wcHluss59JAuhJcWyGb38bRH8zJ0jrsij2DhEKQ45v21k4gch/1DQv9JuhNj?=
 =?us-ascii?Q?MRIsRi9PoqvsJgde5KdM5+JsdZUlwtaUsPNy0NdWordc6d3rgw8c7SaxEMvL?=
 =?us-ascii?Q?wzyT9BWZ3ocxp0iQkVWouRSSmEz6AuiJAfaUw0rf0Kb4/Iv6OcRh39Lfw7P7?=
 =?us-ascii?Q?iKGlx1S5kGWc4EIa7vdnh0z1ZcCg+qLc3S5UnxqR5Ek68rbtq76HxU3qHtsx?=
 =?us-ascii?Q?eTx8yap7+sHbFYxafcnEHAfG2Ej4CnnlzctZ3p+g7b2SlqOAJrS38+OliN5y?=
 =?us-ascii?Q?7R4vNCa96+9c3uRh6jEDXhiaBljijkEDu45B+Ty7wgLznGADD/VZH2noUYwS?=
 =?us-ascii?Q?cjF8zIS3l4VgZz3XwdvyZHKggR08bSjYlIKIAaSmceDcFwwNd6S3hmMsbBHf?=
 =?us-ascii?Q?9s+XYyzUSd81kOcaQkgbah+GfAfUeDofmWARUeic1klhhilJSQbA4bZ2h8et?=
 =?us-ascii?Q?YZ9sYbfi//l3Egt5iBOq3i2606f2Kk/w43eI+WNjqDpKq+I1E1cIjRmAB+6b?=
 =?us-ascii?Q?oB3QFkuorq2YZAQJi3hd2a1X1VQjHgh26uN8jWnYvAAe2mtKRU2TwnNQTvSi?=
 =?us-ascii?Q?GmlCF1DUwZ0DekLVDdZNooUhmr+0Rp/vHSbLiMzkZp1vuOVKIbGeNRJ8OYeg?=
 =?us-ascii?Q?6o1Hk96LtTtROBUIyCKkw45uH0LwtmyowiZ/VskCVysqdPbPGtBpkto52Em2?=
 =?us-ascii?Q?56IGrHyymwrS4RaQt/FI5RN4v163h9y19rHZgKN8LyFMPxJtYAFKGwfBtZiT?=
 =?us-ascii?Q?dtyshHvj9ooHPikKhRh4jVJBKI3zPeY82SC5rgx8/lpYH/O8eWZi6qPu8/pl?=
 =?us-ascii?Q?MnDOwKRX86kUyk23WrsCU23ZoveuaN9NK2gWlENhVMclgb1WWECirD9RmCSt?=
 =?us-ascii?Q?H8O7c8nf46N9lq8LXZJocsY5+iVXWfVbfKZmudPT22DHGZElo+n/IXVE3F7e?=
 =?us-ascii?Q?d7zXtlJujbyVRr02GbCb/WjFqWEoTqMMOXg0GAIEp9czJT66IVJigda7Us+w?=
 =?us-ascii?Q?cDsl9dZO7jpkEUgd/CQmOEpuTA6EDoNlV3Z+xn5vZgvp/FF5myGQROBbwhTf?=
 =?us-ascii?Q?T6MycuRnbepvPq6w+sLxe/yAmh5H+7lLnLWvl4UY9wT8vuvv8a3P3Wef7PUn?=
 =?us-ascii?Q?BJ3gA1SUPGK2Gk3UyHjEmlpRO+or3y3Lu130SMqCL0HaqV6dDw719omVnK0m?=
 =?us-ascii?Q?U0LthrqN2UZJVB6hZDkOyd89tFN/489KpE4LYhi6GDFUwZgBzwJMsC0OeNOL?=
 =?us-ascii?Q?Z+5HGpY9TYXBuYkRLHxnbTPrX1D/mMnGQASCIeLXU3f6bZZ2SmssrqM0/LFp?=
 =?us-ascii?Q?kjKqpAJYejU4qpcV8/tPT4wEenSZkVud2f916LT272A63nhQ59Eg/IanVJWu?=
X-MS-Exchange-AntiSpam-MessageData-1: KExF3YL7sx4TdWqr8D7AhtHMDHYevnRua+0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b873fd77-3f7f-443b-ac95-08de5a870302
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 13:55:05.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WisB3QkYqBRC4hX5Q7uRB+U2rLKkjPzfQypw77hSBtuN1KYJat8fdCpZZ4Ayo8Jv026A8d+vVX/xVd0OstByRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252850-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,trustnetic.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1BB57682B
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:15:29PM +0200, Vladimir Oltean wrote:
> > > > > > > > +	unsigned int base;
> > > > > > > 
> > > > > > > Hmm... resource_size_t ?
> > > > 
> > > > > > Well, regmap_read() takes "unsigned int reg".
> > > > > > https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/regmap.h#L1297
> > > > > > So in practice, a truncation will be done somewhere if the register base
> > > > > > exceeds unsigned int storage capacity. But I didn't feel that it's worth
> > > > > > handling that.
> > > > > 
> > > > > Would this address your feedback?
> > > > 
> > > > Yes and no. See my remarks below.
> > 
> > ...
> > 
> > > > > -	if (config->resource)
> > > > > +	if (config->resource) {
> > > > 
> > > > Btw, this might be not enough, one should check size and flags as well
> > > > before use. There was a discussion about this recently. Maybe we should
> > > > just move to a simple unsigned int in the config for now? Because handling
> > > > resources maybe considered as over engineering in this case.
> > > 
> > > The resource flags are never taken into consideration, but I can for
> > > sure replace the resource in struct mdio_regmap_config with just an
> > > unsigned int start and an end, but that doesn't get rid of the resource
> > > usage. The dev_get_resource(dev->parent, NULL) call is how we learn of
> > > where our register window is located in the "one big regmap" provided by
> > > the parent (SJA1105). So we still need this check somewhere else if we
> > > wanted to not fail silently in case of address bits truncation.
> > 
> > Hmm... Bu why we can't embed the full struct resource in such a case?
> 
> We can also embed the full struct resource, I never said we can't...
> 
> > Because resource should have a flag check, otherwise it's a wrong check.
> > 
> > Discussion I mentioned is this:
> > https://lore.kernel.org/lkml/20251207215359.28895-1-ansuelsmth@gmail.com/
> > 
> > Fixes due to that finding:
> > https://lore.kernel.org/lkml/20251208200437.14199-1-ansuelsmth@gmail.com/
> > https://lore.kernel.org/lkml/20251208145654.5294-1-ilpo.jarvinen@linux.intel.com/
> 
> The linked issues seem unrelated; they are caused by the assumption that
> resource_size() can be zero. But I'm not using the resource_size()
> helper, and even if I were, I'm not testing it against zero.
> 
> As opposed to the PCI BAR case, we don't keep around in an altered form
> the resources exceeding 4G. Just need to reject them once and be done
> with them.
> 
> Also, what else to even check about the resource flags? We get the
> resource using "platform_get_resource(pdev, IORESOURCE_REG, 0)", so we
> know they're of that type. I don't think IORESOURCE_REG resources have
> any other valid bits in flags except for IORESOURCE_TYPE_BITS.
> 
> > > > > +		if (config->resource->start > U32_MAX ||
> > > > > +		    config->resource->end > U32_MAX) {
> > > > 
> > > > Ideally it should be resource_overlaps() check. But see above.
> > > 
> > > resource_overlaps_with_what? The only problem is that the resource can
> > > exceed the 32 bit representation that regmap works with.
> > 
> > Obviously with the 4G address space :-)
> > 
> > 	struct resource r4g = DEFINE_RESOURCE...(..., 0, SZ_4G...);
> > 
> > 	if (resource_overlaps(&r4g, config->resource))
> > 		aiaiai! // using %pR to print the content
> 
> This is a buggy replacement of my intention. I need to sanity check that
> my IORESOURCE_REG resource is entirely within the 0-4G region.
> 
> The correct way to express this using helpers:
> 
> 	if (!resource_contains(&r4g, config->resource))
> 		nazad!
> 
> but... you see my point? In trying to make use of "standard" helpers, we
> overcomplicate simple things and introduce bugs.
> 
> My initially proposed test can be written even simpler:
> 
> 	if (config->resource->end > U32_MAX) {
> 		...
> 
> because end >= start, so also testing resource->start is redundant.
> 
> > > > > +			dev_err(config->parent,
> > > > > +				"Resource exceeds regmap API addressing possibilities\n");
> > > > > +			return ERR_PTR(-EINVAL);
> > > > > +		}
> > > > >  		mr->base = config->resource->start;
> > > > > +	}

A data structure which I find a bit under-utilized in the kernel is

/**
 * struct regmap_range - A register range, used for access related checks
 *                       (readable/writeable/volatile/precious checks)
 *
 * @range_min: address of first register
 * @range_max: address of last register
 */
struct regmap_range {
	unsigned int range_min;
	unsigned int range_max;
};

I could imagine a helper like:

/* Type adaptation between phy_addr_t and unsigned int */
static inline int __must_check regmap_range_from_resource(const struct resource *res,
							  struct regmap_range *range)
{
	struct resource r4g = DEFINE_RES(0, SZ_4G, res->flags);

	if (res->flags != IORESOURCE_REG) {
		pr_err("%s should be used only with IORESOURCE_REG resources\n");
		return -EINVAL;
	}

	if (!resource_contains(&r4g, res)) {
		pr_err("Resource exceeds regmap API addressing possibilities\n");
		return -EINVAL;
	}

	range->range_min = res->start;
	range->range_max = res->end;

	return 0;
}

and then proceed to use the simpler and validated regmap_range structure in the driver.
Too bad such use is not an established coding pattern...

