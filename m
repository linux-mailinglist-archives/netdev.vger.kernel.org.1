Return-Path: <netdev+bounces-252277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMqEIosGcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:14:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83665CE0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8ACA889181
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B341C30B;
	Thu, 22 Jan 2026 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IFvxvx9Q"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66FC3EFD1B;
	Thu, 22 Jan 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079444; cv=fail; b=COSIaUZSpHfFR+xM3ZEMMFo19eWWythDfF1Mq3Ef+s6KkSYw67ZrlwyBCijaV55G1GjLwq7ieKamts7hZlTv53/zw60gLixCte6BgB+Idp5gV1wTRwXXGrFiFyGP5rhRFE41kjadi5sMnLadIs+qwR8p5kCX/N8UR4glUqSoKVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079444; c=relaxed/simple;
	bh=d9h1U3e0J8oZ79hfVMSCSyQc9W0zSY6sMV0gdgclNdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvkjssqVZHTAJBqvnZhGz4VbeOKpPbhnDTvV/6lsgJI468Nzoiv1yrZukxOgaApBESDRCidVzhkTfuDnfw8gW0D2QcZsiXAKq8t4zcBzq36FtN7yqsBo80bDfgsHaUHdPnnsExNroWWVYFAcJAtqvZGzDvpOvEB9BSeb2FPQP2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IFvxvx9Q; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naTok62DV9QCoQ/tpuqPH8b6SIvtbF1tl51UJUYDIPIYhy2ZWeYFYWXRlROUFCFkLB2XDjOVKfMArZye4ITdQs14Fe6j4b+b9tl6oaK8qYgh/L6hyJ2+5EnYkg3lGYhfzSxV8ABZdYlJJMe807NcF3u9pv/5spdYpdlRMglCHdIa7QuQhPNSlyenW6jwhjsPciAYTpACSvP8RBrfR7k3tTWtp5jm1VVo392tKSmtIQhJdzx63kwCgS/IcALiyC5woCNkcXX3X3jso8lch7rZ418hjYq+zcVK0RYZC+mQWk0JozzC/TJL2XKsL/HSFLdC+ZWipKxxuigNhQ+e/pHaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT1MFqeVTORz8ZsHpY0YKaaMRmS0zFs++wPM05kjSBo=;
 b=VmvZKrBMPTj/8O5wUAoElvISYmvbYS2COmhcS48nlIGcVANtooecCGQfiShUPdlv28hk78Dz57CfjpFCZpLIDvtoc0jGoNQ//uipDQeDHbF5Vq9WIqxPQRu0pC2oR7OV16JcyQAjd5Jx+IizS2iIyr9QXtOCtKo+af9IHTxhNFi0hWHkjKu6cDN5WAUoJ9wS7tBM+c8tSS5vkGi1NrFTDxRjzXF06j0bOPedhopBFCZBZPMmTg6PX5s0pPdBi5SzvB7vPalEaSLIomn75ub9o/UA03SwHKBrNMcvEWE7NXcTR+dW++NtEaVLF1GFRtjVrAymOGWMvDzZC5nCbAir6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT1MFqeVTORz8ZsHpY0YKaaMRmS0zFs++wPM05kjSBo=;
 b=IFvxvx9QrQGMlE5mkDMKkr1dzz2GFw31O3hZACRWeVOvm0cq21qRkRbOeoVVmJaOxG1ymAV6Ut3dUH34GwVPrkUi85Wg1sPbcmoZ/SFkhPVgJktGyGoN3NI/T+BgCdn1TawWxjtgQWmTTIAJjV2wntHu1jaEtsogjHB7cPRbzIV6gZef0sz+h6Bx4WkLhJekbfBfktOd80K0/XVyKn9qYZbu1QfObMXvFQxhiE/KLa31NuPsoq4FqbdkguUKh9kSNqmvAqEY2n2TgfTqjhJnKSdvfq6WPJJKewuiEIt+yEPFApt1OUWbeGNHKtuolJm41IUEr2D4iZS1hXag5Qya+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:13 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 net-next 03/15] net: mdio: add generic driver for NXP SJA1110 100BASE-TX embedded PHYs
Date: Thu, 22 Jan 2026 12:56:42 +0200
Message-Id: <20260122105654.105600-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122105654.105600-1-vladimir.oltean@nxp.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB11853:EE_
X-MS-Office365-Filtering-Correlation-Id: b975d718-e7fe-4b5c-0443-08de59a4ff5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfXgFzRjDg+z9gwmGQvXecqMa3So4NNG8gymPIOEuqqk+daYMSvJrZyjzY5n?=
 =?us-ascii?Q?N08YnDf2snbRiBw1Udyqj+sKw8K0Nk007gM3luNTgy07oSOIv+XriAfZ5R7K?=
 =?us-ascii?Q?y1IptTaYK3ByCtAjHvtr5RfO7NYjvzbtQUL94RIk32DWQG/akdn7C3eB3ls2?=
 =?us-ascii?Q?fgJF3gTZyyGzy9jtZ2IzLlFDTtwq0PU44wRzZMuKw5LKuhgP1POXA2Q5g9vX?=
 =?us-ascii?Q?JG9QA84GQuXwQ8AOkgMLs5jcAJn8b/PczgDsXYrn9+HRKCeMlMHrzXTLi5x1?=
 =?us-ascii?Q?t+kpYaN4eqo5UyM01auFnwh8vbOMpW6RoHMI1ZwKjX/jTaIbtVtc7KTiwuu5?=
 =?us-ascii?Q?d9k9AalGayVIZaflCKAQfsRxMjd/yScqV15hMwgGX3QTzuaC0dBHHdCdqD31?=
 =?us-ascii?Q?NS7zu5yPd1aIemSjZ0InbMhXY1xFsEvuLYcFEtynn7MExM+52LibzbhH7oGK?=
 =?us-ascii?Q?zNykPVLFb1yK4WxA7Gd7C6k/leQqeK5aguFDb9MEsQ+0E91NEHbqNPt1siDd?=
 =?us-ascii?Q?H9OcO/7EFqPk5pD6Y2f5JAcPQooS1TSHUze64RIx9fvbqqZ3/a5QcplTCFCI?=
 =?us-ascii?Q?FIP1EElVKwpdNQPD3koU+z5svQlh3twhe+H0TKKYg+cdzsDzprGxc2XaF18B?=
 =?us-ascii?Q?rzHILtMPGMIJXKAakjd8hw/wQKLernxChVksNF8ItaeVdO8EyB79NJ+Va5Qt?=
 =?us-ascii?Q?RWv9o0PxnOw3WXtdj63ZTtN7pe04oVxPXhaenxeXwQu/wfhRt0d1YDRhZiCJ?=
 =?us-ascii?Q?w3Ab+XJxq5L79P3U03z8d+Rc9ifuF2FRgWtb6GWUI0ZhU3pf2gTScxmRT1B5?=
 =?us-ascii?Q?4QoB8ZDV4xvvgE9DjNzAC8tIp8j+YPqTwoQG+u2xhByxTdJ3+dHODGUo9PTf?=
 =?us-ascii?Q?E7749PJB7H2kfC7ZIT1pF8CxtjBzeEOSRKaB524EsyOWtNQIYe1QrNtCy+TU?=
 =?us-ascii?Q?/dLx3iuaLI5nZjD7B0Lg15w2eUPnZ96RduwCyxwXb1Z3pRQZuFnmIRpXh/YS?=
 =?us-ascii?Q?zEydcg4ovSHtUJpGXOJHxjQtoinppv2/NZv48SwCfyDhN+UyEUWQWvqPEjDz?=
 =?us-ascii?Q?PexeeRswYhfW1b+13AYn3zirWvCQ8mEJDdbCOsTOXltN1Wl0BtuYXdtnCNZd?=
 =?us-ascii?Q?0I41jRpYVu8glH4dgOLeBNNoMvcQscs/x0PlelgE7MhhMPQalyA9z6PYpjY9?=
 =?us-ascii?Q?m3gBI6sg+Fs2NCaPdPw90rSZnO3iCRviDhjxqmOo/fBczrDhQEHK097ET+xu?=
 =?us-ascii?Q?uKB9Ryr8vzImRwVMraNX3AP4BVQ8fVANfEq638KmUsU9igYk1677svUUL+qe?=
 =?us-ascii?Q?OfOFybrA3pH1Ft/u7NmqOpUykPcbs47SQt3aUQPxXDl+PLAwYnyfUC/bke/G?=
 =?us-ascii?Q?LCPml03AqMP0CeHYzkTljffidX+zsbkjsKKA/5cnnHE/Dxtoltvzq+HP6bdG?=
 =?us-ascii?Q?+g7b8oSmiUEHj1TElNTzsngVhvexd0O5IwY4XVtTvbEUewV9v6QoGbY39qRo?=
 =?us-ascii?Q?IHuwJMJerlAS+ljNP5b+2ZzD9yxizRrdov8zB9PIWhko+OeS+vpASXJU0ttT?=
 =?us-ascii?Q?IsaoKilas1gFlfNGs/CyNB15o4/Ja1U4Bo4B9QDSVxjDgFYuMGyUu71T+7NF?=
 =?us-ascii?Q?sSjQ9bEbaZDkj69ZrO31E5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OexFPv0fIsHEmVXN8P5+s5uYAtiV6cWGnz70LkOxP/F+Td8vgj+RJCMl/IuW?=
 =?us-ascii?Q?f5a0SLNOezO+5060TQ03N1IQkhFl2vLyMTpFHV7i1mSxcWEPlugZYNnBwNBH?=
 =?us-ascii?Q?F3Y88FKuhAzI882bln2c1+VJrhnlbTXhTdPwPLfv4NlB2n8omRv0FXwwvhBy?=
 =?us-ascii?Q?EOwCCK7B2UpjjDe/5GXLWzqRSSCVAMm1HS7VtG4hevky5phy8NxDg3vBdOrC?=
 =?us-ascii?Q?UQp+K2jG+sM0oyfMgaRqMxMxjaMN8Xiccy+pjCPByoOjsff3u84dHG4/ONIP?=
 =?us-ascii?Q?Da/xuT1tXjtTFOaEvBrW3FhU9L7wawUI0iMarFH9vsG5XQMr0QnwqAjIFIwk?=
 =?us-ascii?Q?LeniQrooMuNmZ/4VeiOwNSofpcAe7/03/27n4IChuVc8cXmbuMMc45GHISi4?=
 =?us-ascii?Q?43FgGlOFJJNZaQbzJWeHphRhUltWJ2SXkS5jmaBIHj8En9y8emGgFi/poQjV?=
 =?us-ascii?Q?1A60LFJawyq8e+azuBYeCnqIiFeapJiTt0LMZxdM92Pjqp4gIyQPsxKQQCZ7?=
 =?us-ascii?Q?6LyOHE2+ffHzg6TAQL4UQdKTaTGPqcu+Ve1yD9l0OQdOcCYLkeQV8nIlKjVw?=
 =?us-ascii?Q?uCuxTuJcQyQxYr5rVlsdamJRaLFx/S2ouYQpDTsgjjErJBa+yvOPEDDrKEWG?=
 =?us-ascii?Q?l/xq9DAY5jWCMU0Uji6G3+MEphyv6rBVJNOOapV2KnFcSiK7KGJIABQktMb/?=
 =?us-ascii?Q?+cJ+g5zlYXA05cOEh7pmoNhoDhOpSX/RtrIGEL8uV2VMsux5peoM2fUEDTLv?=
 =?us-ascii?Q?Br4AF6fpBRw1m45Eu8e8NeSbgxsQi4b0eRJZRYHy1NR0ZxkAoKctYywkHJhy?=
 =?us-ascii?Q?buB/lIWpD4I2eR7jUrxSbZBK9AiqLrlRlJ+rQ9+UpPOV+FmkAsCSwCmUxv2C?=
 =?us-ascii?Q?cYgNz8s3CrjQvD7CfTRQ8zIk7yAs7lJrWFvAtJRgGzCQcRs4Xoew7kz6m5C2?=
 =?us-ascii?Q?ffPjGqZIUnJMAF0Xzwiw1aiCwCYnUIiqBIsonongcw8SOt9DQwdQb1Em9FlF?=
 =?us-ascii?Q?uf3/2Glb/kcAMPHY9gyBl2VHzfQlN3MW4hl7PfQzCZvipCRYl7+dq1vzHJ6V?=
 =?us-ascii?Q?OieT2AppA/uXpKsBY5rhPuXQ+bCY96qPviP4yapCEPPmL9pmvxoKIAA1Qya4?=
 =?us-ascii?Q?CWlvTntjF6uEE7v2NKpGzxG1mgkxHoyT7VrnsCNAQWl1rogh481tNcfa8Bul?=
 =?us-ascii?Q?HOVDTBUJeIx2OkEF5o3j+NrQZXHXOmaX9Qyg4FBswS/wW5oBhu4k0RXi3aDM?=
 =?us-ascii?Q?2AsCtburY4WJtCBUjprAGZNsnnLl35aBD8QQNvK4yEs1w6sCd0X+pSXBJrNU?=
 =?us-ascii?Q?4cdVIbsDbGsVr0lT9NCNSypTqQmqfVHMQZlLaUtyAYaM8+cVS0Doo/yQ9mX7?=
 =?us-ascii?Q?2EiaIufYTcVwQ+tjq022OP7XT5UCDF4WzUJ/s1d1MvH7NZ/6yeEMvyR48l+y?=
 =?us-ascii?Q?fqtY8NHUshqMH2DxMkUJQ+4LoZEPTbYPdlUlery+jRFUgjvZLy4FOdIoBCQq?=
 =?us-ascii?Q?b0i0dj6TO9Kuf0SstM+S/sRerm6a2zDY+YZXLV0/bR1fYdSqbyc1KChhofke?=
 =?us-ascii?Q?tZ2wH/caoJSlXbMCvXlkGA4Q6NXqg2Ba/B7WTGjMoAQgjjWBsDZzra1f76J6?=
 =?us-ascii?Q?16TpO6/0H1kXrkB2do76mlkD9JdphAkTKaG3vcduQeDWYNX+5RS3xeJgSINw?=
 =?us-ascii?Q?tFwcaJ5vCaVfKUrma4CBhiDVdo2UhRY+xHCqwigGEHxXhtnjvNIxK0xI0tf1?=
 =?us-ascii?Q?JDuqhpILvw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b975d718-e7fe-4b5c-0443-08de59a4ff5e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:12.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o99SD3R3rTHUFdeSquJqrKTqg2Fd8ennrlqFYeNr2HUJthdKY02oLTi3bTveXUbyX5y29ehehh4r5nOwQdq5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11853
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252277-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,bootlin.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,config.name:url]
X-Rspamd-Queue-Id: ED83665CE0
X-Rspamd-Action: no action

This is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
Same kind of differences between this driver and the embedded DSA one
apply: regmap is being used for register access, and addresses are
multiplied by 4 with regmap.

In fact this is so generic that there is nothing NXP SJA1110 specific
about it at all, and just instantiates mdio-regmap. I decided to name it
mdio-regmap-simple.c in the style of drivers/mfd/simple-mfd-i2c.c which
has support for various vendor compatible strings.

Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- reorder MAINTAINERS entry to be alphabetic
- clarify that platform_get_resource() is optional (thanks to Maxime)
- update copyright to 2026

 MAINTAINERS                           |  1 +
 drivers/net/mdio/Kconfig              | 15 ++++-
 drivers/net/mdio/Makefile             |  1 +
 drivers/net/mdio/mdio-regmap-simple.c | 80 +++++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/mdio/mdio-regmap-simple.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d3fec699c577..2b910fdd1122 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15671,6 +15671,7 @@ MDIO REGMAP DRIVER
 M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	drivers/net/mdio/mdio-regmap-simple.c
 F:	drivers/net/mdio/mdio-regmap.c
 F:	include/linux/mdio/mdio-regmap.h
 
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 9819d1dc18de..c6e824baf228 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -179,14 +179,23 @@ config MDIO_REALTEK_RTL9300
 config MDIO_REGMAP
 	tristate
 	help
-	  This driver allows using MDIO devices that are not sitting on a
-	  regular MDIO bus, but still exposes the standard 802.3 register
+	  This support module allows using MDIO devices that are not sitting on
+	  a regular MDIO bus, but still exposes the standard 802.3 register
 	  layout. It's regmap-based so that it can be used on integrated,
 	  memory-mapped PHYs, SPI PHYs and so on. A new virtual MDIO bus is
 	  created, and its read/write operations are mapped to the underlying
-	  regmap. Users willing to use this driver must explicitly select
+	  regmap. Users willing to use this module must explicitly select
 	  REGMAP.
 
+config MDIO_REGMAP_SIMPLE
+	tristate
+	select MDIO_REGMAP
+	help
+	  Generic platform driver for MDIO buses with a linear address space
+	  that can be directly accessed using the MDIO_REGMAP support code and
+	  need no special handling. The regmap is provided by the parent
+	  device.
+
 config MDIO_THUNDER
 	tristate "ThunderX SOCs MDIO buses"
 	depends on 64BIT
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 9abf20d1b030..95f201b73a7d 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
 obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
 obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
 obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
+obj-$(CONFIG_MDIO_REGMAP_SIMPLE)	+= mdio-regmap-simple.o
 obj-$(CONFIG_MDIO_SJA1110_CBT1)		+= mdio-sja1110-cbt1.o
 obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
 obj-$(CONFIG_MDIO_THUNDER)		+= mdio-thunder.o
diff --git a/drivers/net/mdio/mdio-regmap-simple.c b/drivers/net/mdio/mdio-regmap-simple.c
new file mode 100644
index 000000000000..5db1ca50c374
--- /dev/null
+++ b/drivers/net/mdio/mdio-regmap-simple.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025-2026 NXP
+ *
+ * Generic MDIO bus driver for simple regmap-based MDIO devices
+ *
+ * This driver creates MDIO buses for devices that expose their internal
+ * PHYs or PCS through a regmap interface. It's intended to be a simple,
+ * generic driver similar to simple-mfd-i2c.c.
+ */
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mdio/mdio-regmap.h>
+
+struct mdio_regmap_simple_data {
+	u8 valid_addr;
+	bool autoscan;
+};
+
+static const struct mdio_regmap_simple_data nxp_sja1110_base_tx = {
+	.valid_addr = 0,
+	.autoscan = false,
+};
+
+static int mdio_regmap_simple_probe(struct platform_device *pdev)
+{
+	const struct mdio_regmap_simple_data *data;
+	struct mdio_regmap_config config = {};
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct mii_bus *bus;
+
+	if (!dev->of_node || !dev->parent)
+		return -ENODEV;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	data = device_get_match_data(dev);
+
+	config.regmap = regmap;
+	config.parent = dev;
+	config.name = dev_name(dev);
+	/* The resource is optional, provided for finding the registers
+	 * within a device-wide non-MMIO regmap
+	 */
+	config.resource = platform_get_resource(pdev, IORESOURCE_REG, 0);
+	if (data) {
+		config.valid_addr = data->valid_addr;
+		config.autoscan = data->autoscan;
+	}
+
+	return PTR_ERR_OR_ZERO(devm_mdio_regmap_register(dev, &config));
+}
+
+static const struct of_device_id mdio_regmap_simple_match[] = {
+	{
+		.compatible = "nxp,sja1110-base-tx-mdio",
+		.data = &nxp_sja1110_base_tx,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mdio_regmap_simple_match);
+
+static struct platform_driver mdio_regmap_simple_driver = {
+	.probe = mdio_regmap_simple_probe,
+	.driver = {
+		.name = "mdio-regmap-simple",
+		.of_match_table = mdio_regmap_simple_match,
+	},
+};
+
+module_platform_driver(mdio_regmap_simple_driver);
+
+MODULE_DESCRIPTION("Generic MDIO bus driver for simple regmap-based devices");
+MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


