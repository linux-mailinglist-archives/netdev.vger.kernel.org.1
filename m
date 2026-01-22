Return-Path: <netdev+bounces-252372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PhYE7Q2cmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:39:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A468049
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 886FB8AA2C7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB93329C7D;
	Thu, 22 Jan 2026 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HKDDtlkh"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AA321456;
	Thu, 22 Jan 2026 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089633; cv=fail; b=OPwEK4eKRFLEGn05N2GIud/3p/RfCCnvoLxxRvlMkgy7K7mlU0RTsu+GWfc9fcrjez9eIhVnbjE1IF3+IhJ0DmBnBqoJoytupfbRJR2PCIYw278Nm6cT/bR+wappincW7aReOUZF3MJFz6jnKuDpXHEJJ+z6v6txHfSnLxBnsZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089633; c=relaxed/simple;
	bh=mFerQSfdbNGXgbiX4CNZIxLoQK3TRBxdN8Lyje9QirA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GFAXtDFKgXC70r+96K85YsFjmTA88rC13zxc/aWSICCjaGKbsWpaE3D2XzjTlcZHsean5RxCKcUAM+0hi88dkgVyhXmeB2yPjpvZ8ox0ogcTM0HtEeCpG+dgmtYci7I15Aq4mWBSHi8IpvB5EUQSGPlFY1lK55RLrVLzEb8bTtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HKDDtlkh; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWumrRGXR4AwV9PC1G+lWlqj8Bly/zPaQCef7bbTcKY63lmZ218DSwA3zRYaBB4qUii6HAPmhgEwViUu3vSX9bdC/Y8yYC8wkUXYo+F+143sCK0Kdusgz//3rDupU59GuqxMwH1U7BreEYsu+mDXF2eKOa1meVqtqBXm0RbImDL2vT/gAIJw6XJnaOCLomOSHtrWGaPpoMjz+A/lt9qOgE/B9xj+3fcXatjxWB2C0CocsmEIkzNNSmLr0wysvK6vLYInaxMKD68vEY9+oXCxkYiHMgv1mJ03GF1Tjdlb6H/vOB+ZltvQ3bALf+lYrCva1zU5uFyXOq6sjF4v+BvvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aoq3HmhaW+KQESQ4NEurpHxc7347C5Yz4lRiCD/Acg=;
 b=b3KrmE5br5jPT8tmRxtqkjHHfdBGZ1p5C1vsmNXrZsh0NAUUwQb3UvCxy2SPtAYIt8BFd9jLHFU2L8juJGyWDdxjdqoBJmN25vSCuyYw4nb/oM5VU5v+hSIVUZjHfVBRP0DMLqzPlwjn5a2ZQiou35XhmlVvt2m6JfN5J2fSEWJxj5KQdR6dzz4f2Zd9RsT0Ov5z9OidEqdtKfngjzaHagDOl1IECdZ/en7vTvyMLogERdeWk/YisAhDEcoQSZxzOO9DsCzotCF7mza8swP6g769V67mF2g9QeGZw+PBChnfa5cFued1LWX59L8JO5f68cNKY7+nHJX8LZ2mTuAELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aoq3HmhaW+KQESQ4NEurpHxc7347C5Yz4lRiCD/Acg=;
 b=HKDDtlkh7rbUWo5a/fP1JiWhSAtxK71PRR/ibaw6Eu5T2XImgG33xCahfPFViCLis3T3eVyy5zZWzkk4Ja5Qi6jhehAxxbh+SD7reXZAm8GdUxSaDK9lygn7AZ0ofvugrVdIXsSWTfksyp8NGQB4nD7UNK0SzLPdEgbOXDhmDadwvITnDntR93LtArB7WSSSHkjFLcNvI5gbWRvJmmh1wXmVuaEn4WXWN3rIBi/U3o+rNfAsj0saXG6R8KoplA4pC1G24mPhGomIymlGSvHgVfHhkIvfEveipnGhQrTQrU2ZWB94HxgVxlB3y5ya262kdv+ZEL6Pd/0GLmGy3ZOI7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 13:47:08 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 13:47:08 +0000
Date: Thu, 22 Jan 2026 15:47:04 +0200
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <20260122134704.pxeikyk4q7nhay55@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122121301.cyxyevi7xvqw2axk@skbuf>
X-ClientProxiedBy: BE1P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee14197-8506-415e-743c-08de59bcbc25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|19092799006|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXCz6N/LdsqQTtRRpuqzNfXQLFw/Q4K12XFRdNtJFFdPcXa+Ah6DTpV4aGVI?=
 =?us-ascii?Q?AyvgXA4jwpNggds7BOyQqolCQrHCDYJWS/qZrSiDG9AzMl9/dwqV20vsr2ag?=
 =?us-ascii?Q?EMXWOuafenY8ErPBQJezSechfx8DhFG5r9rbZZf1mk7zpwNydELGoGuSXyyR?=
 =?us-ascii?Q?nlsC8a2PgYHNGogBlgbS4V+6J9SLVwzM/OZlb4mJpTNhvDO2fFBDgHe1T31Y?=
 =?us-ascii?Q?555Rqn2yMrhc6WfpTT6iCR7GafYvRUAOwXSrVDEAliu9Tky9Y6S50L+2eHLk?=
 =?us-ascii?Q?eBz4veU+TnOn+6DifXd6SwpJecmyxAdFklh3/3/CPOdbwpHhAcU4FYuvaRt/?=
 =?us-ascii?Q?T47IMM2pYb1KoKLgSst7icvnzL7foV/louri7IESh11DZArSvIwDgGnoizvj?=
 =?us-ascii?Q?Mb7sFQVMW3UmNjSVMkPmkTgPw2TQZZ1BH3JYazhM+W4JObQJlTHIEwsuhqw9?=
 =?us-ascii?Q?5qTgogdna2HTuk6g0A1jMuUs1kVppvuY8aKMari73fesFP5JS5/WxeOzAW43?=
 =?us-ascii?Q?znitg/I26NlgeNK6SpD214ogNtAdoh0XVTDheFOJGMUCv08gwBm+AGH+FZ6Q?=
 =?us-ascii?Q?65r4MG5fbnbnCSvie6Pgum0QrGEjSwwwM6Nuazs5ERk+c87x9ZL2E08p8jaO?=
 =?us-ascii?Q?cSHoBXiwv8vbyEoOnk6CXDp4sLICw/YfsWe+0hinfjnIu16m72PtkACsOtlo?=
 =?us-ascii?Q?sJGMzGX+BrlkQosDzAHn3DHU0fvcvMOVMyJrjHPx8OqU4ryyiA/ejhXTzMQ6?=
 =?us-ascii?Q?xNNJJ0iMOlzr8m9gr/jPhCUqJ1WQKy9JTl9mNik0V1Teq5Ghe3nscgnjsEaF?=
 =?us-ascii?Q?kzGyP+Ojna/rvJcKXWOLSqFkc7eKaL0osTYz0MVr3KxdlCtL9k2ovvM2az1z?=
 =?us-ascii?Q?zJZYfuIRXWVtJYaXVCF17FjjVyk1R6ydhtydecC4BJP3fudlCbfcCEpQ3fee?=
 =?us-ascii?Q?kDiyBkFRmAroYEerxaynHIoTcEn1ynhOgkMOYWZR5C5cUiW6mDzipLRMov5i?=
 =?us-ascii?Q?EdvgrtQobjWfHTqUEJpHrKCo1IqFFUpWoQ5LZQS7zPqOmY3ND5vpWIg3akzL?=
 =?us-ascii?Q?hH/1u8DwBGWo3eBgV6xhP8N15tzpSq5/TdhnE+QzWtfUxssjKw6yMstOE3Z4?=
 =?us-ascii?Q?KIrM/R8hMaYkqdTd81YmKolGYg2pjG2tY0KojNVD7z5sydU1bmqvn14hEs74?=
 =?us-ascii?Q?EGSnMceh5o1L/UZji2bKrF18+06MlecIODFQMrGrrekX+SEAbkZOunGGJmHA?=
 =?us-ascii?Q?Wqc+o7qNken+OH4JAhD30Fq7Tt2YP4wDa2OwmXyyw4Gk6KvV/6y2xNitnCWC?=
 =?us-ascii?Q?rq5OjRLU6TavJJVMg2kvCSs50l3QBG/gSYDxOwh5KnXWtA/WEA0l5AljaUkQ?=
 =?us-ascii?Q?XgPGLv8IZz2WCcGTeHrUWSNNgqdYEkZSlhsWlDK+eQpU/Y/IEh8xsvzH4Ojq?=
 =?us-ascii?Q?fjxl60tY48J/8uMcA1jxWacNW1dmVVM+NVKdWyrce3YI5Koc7wq8PRsooayC?=
 =?us-ascii?Q?GBV2OTKs3FKWjclF46jOSPwFdhSYmLZE+xyx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C+Obope0Ff4q/N6IdfdJL1NAIOMH229zECj1bPuYeOeaC8XdPusCb+mcgwDD?=
 =?us-ascii?Q?O8JbpmZ/jJfte6cwDYBLwi538eSZOP2EG8bjAaJmHGvBrKPwZ9qxC5Flbhc4?=
 =?us-ascii?Q?UyrpG7nvB5nsyHBZyR5yXoLTkfioLtcwpNHJkhcsZVeo/1KZs0xOgp00m1yC?=
 =?us-ascii?Q?LopB+RS0QKVthCT5srht2qE4WsmRaN23nLHUAhCUHjM76zGMJd8Iwr5MSlU6?=
 =?us-ascii?Q?Nr36LdWQQeVMSI7cz7oXauicRNLSZD2GtO9ZDe47WwYTrvg1if810Kb21uNC?=
 =?us-ascii?Q?/JMGIlZTzs96qreuzpbEU+IfGVLgfT1U/jXlNEwa3u4Tkb7fEFz5V9IDITXR?=
 =?us-ascii?Q?1X/neXi3A4TjB2mJbFiT1ePFcSgaN5dWe2ygu8cLdE2pzX1BCpcWbugmAZGg?=
 =?us-ascii?Q?taE6yOEdNFIWaexKng7aYx+FjDIoyZC+TdWVwzOBzgv4hy+T7t07ML2CGTsq?=
 =?us-ascii?Q?pE5y+JpXfYpJdhuyGtChte5PguV0iOrNT9HthueRKezWj0kbSsnGAheXhxJq?=
 =?us-ascii?Q?CdynSpYIs0tmWNjU5w1OyRUCZJYMZY2JclWVI9qX0xxG+s10XFcF2kCnvs7v?=
 =?us-ascii?Q?Mc5wIw1pgB8z9cpa+BZzWABpdoy0aWkK8t5ZYXRESBOQ1af3pzCKkoAh4rVh?=
 =?us-ascii?Q?OEvQHXsjS6REDOJtBk1C8nsoQL3Im5Eg09zPHAqVFw89H9obiXBzxftg568R?=
 =?us-ascii?Q?nbzPWqNPHGAhHtPtS3QEs+3BbH3lqFDeKglqCBadcDwX7icAmpb8OpudlyV2?=
 =?us-ascii?Q?YZQyKBI+11It3Bvwn1Ba43IMwazyhy1rbLAzu2s2kkHzwPpI//1N5FQrmNEF?=
 =?us-ascii?Q?fG43tynJb9d7PzxhW8kC8gCabSdL1yYxbo4yOj0/rPXrBR30HnCKWthbZgDE?=
 =?us-ascii?Q?RFW1jZCDPMTd1fjU6s8uaCQom9dKlZmGPs/1TC9/4HfW3nyh0b1TW8ZXK0Cj?=
 =?us-ascii?Q?po9Ggigiyy4gkXm5jTIVa0xxmRuoSkLrDfA1wsGmzYu2TeDlQq/gyDZf9yeG?=
 =?us-ascii?Q?VZeblHcpgHSx1/nMs7u/EKHeNveCXmAW7dmob5ROgUsdAOrtZZZ9WZTe43hZ?=
 =?us-ascii?Q?e1ZVfxlbcP3enfQcPcXRgpolJ6rukneCQC2r9UZMORSrut7veObjM0mobw8Z?=
 =?us-ascii?Q?Bt7jRhoxa4R3L/m9ufUl6spxOHmLzw8jQmZu1rAdFDM/bpxenwBkIbZwEhiM?=
 =?us-ascii?Q?HV5wj+lE/MXAydWodBT7qQn/VAHg25bmLT6ptAg7LyryR+sv2dwR7wbnuKAk?=
 =?us-ascii?Q?NPhtGWpEBkzSkJnL7UAndahXwH4SBchHPCwTR4xT3QZlOdQKPX6QS+8qV3D0?=
 =?us-ascii?Q?Kb9LUnPx1jNZOePdr3Q36IfEghFDoQXdkH2oEwI9jySQjMCRMEJcNJEytV8U?=
 =?us-ascii?Q?C2GxatdlRYpHyvHdAlf7ze9jN6YfB8+Hnk73JkPe0LjePC8x9O/3pW85AZQX?=
 =?us-ascii?Q?Vv/iR8jPIKGvJIxUaL+PXg2nivOcPoA6I5+6//9Ss/1kVUo0VP+HF0c3f0cG?=
 =?us-ascii?Q?RLvN0K051KXHm+fXj1w9Bc+C4emQrtel0UIa8hw8NC/pTu4Qjb0Myq6jloJ2?=
 =?us-ascii?Q?/UlZT5Kb4tG1Gn6x8bWi4RjQ2brjSmarqOaEGkB70PlrDxAar4p5ubaQFXzg?=
 =?us-ascii?Q?RaPgcvzVV3I6eeQECDnedzMYXfi2JG/y458MOu6P+zxywSNY/0NXVwSHB5M8?=
 =?us-ascii?Q?bZBLtvFUWvz1nLqcreuZNQFPXoY134YgxDRLyc79Sfqq6dLbgofus9OIcGdK?=
 =?us-ascii?Q?+QDR5USa8I8aotfBrv5g2/yeMEjN8UmmBgORq40NsbZqZrjn8/Z7egK3d41G?=
X-MS-Exchange-AntiSpam-MessageData-1: VTjyGtbFbiOcNUejrvSNT7BlElaUUHoZ/iw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee14197-8506-415e-743c-08de59bcbc25
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:47:08.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rjxndie2hqwWZrTz7UwhXcgPC26+9lCJaSscQPKOHD6RNt20rW/0rc+rRcefl6Ip2lJr2W2FyKcnq3VFByRmXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252372-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linux.intel.com,trustnetic.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,nxp.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: B44A468049
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:
> > >  struct mdio_regmap_priv {
> > >  	struct regmap *regmap;
> > > +	unsigned int base;
> > 
> > Hmm... resource_size_t ?
> 
> Well, regmap_read() takes "unsigned int reg".
> https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/regmap.h#L1297
> So in practice, a truncation will be done somewhere if the register base
> exceeds unsigned int storage capacity. But I didn't feel that it's worth
> handling that.

Would this address your feedback?

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index 2a0e9c519fa3..416ff4e13e8f 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -67,8 +67,15 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	mr = mii->priv;
 	mr->regmap = config->regmap;
 	mr->valid_addr = config->valid_addr;
-	if (config->resource)
+	if (config->resource) {
+		if (config->resource->start > U32_MAX ||
+		    config->resource->end > U32_MAX) {
+			dev_err(config->parent,
+				"Resource exceeds regmap API addressing possibilities\n");
+			return ERR_PTR(-EINVAL);
+		}
 		mr->base = config->resource->start;
+	}
 
 	mii->name = DRV_NAME;
 	strscpy(mii->id, config->name, MII_BUS_ID_SIZE);

(needs to be replicated in a bunch of other places)

