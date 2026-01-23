Return-Path: <netdev+bounces-252863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMdSLhyQc2l0xAAAu9opvQ
	(envelope-from <netdev+bounces-252863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:13:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8F7793C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D28306CEDF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4672BD586;
	Fri, 23 Jan 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aailX6q5"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87D2E06EA;
	Fri, 23 Jan 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181058; cv=fail; b=LKbnXAVlwYIeIodSk/XMwQnqT9kBixuNKprLxZtxmXG8kPP0eRKlomkoJ50Ic09G+FFqpTYLTVskxLOr6SSCfCGyYAXZ9IYSdAMTDzi5zW5imqhvdm+ce6P7xBguCgS/5YFFAfLJxXlpNTuej1JdaRaMK4cD6bb3IDZcVNW04kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181058; c=relaxed/simple;
	bh=5wii22jMgN20Ihi7UCukQN5bLzXmRVjS1GGAeUjQ5HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qBlq3yJod9HZqmcPYzRtSMFMPKmbBnHT+mq94RBqEw+fuPgFG+2NcIyaFiyPwCw1hW/TmVjbCE5Tl/GfVnZQVK5fsfJ0YY4rOkjBzwgHDWefUN5OgF0AMRVMWRY1U1HBqpf3s2Fg9vEBWNfOBbR7CWAHmpTRGJHABNOhNYG/HZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aailX6q5; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW/vRhPX6RuqtH+RA4ustTBV43X/gbEPjiazoqCjLpZc4lCGCBZdFYPcYyFeaDq/b2ufO9gGyt6EevJ7PwiydNcs7u0Ftf2X+W5A1XIemhNvXM/mrXR9CB9be3G8XkmRlG+QK1EdtIG8Cxzse4K/a2vhtclLhux765UqsINj4fNaCBzn9XkYyjaR39PXqyNlOyCWBZ2UEWodusKtYBLL3FafABHMGCbBKEl2n7n04eY7NpunwV26ih301Th8U6MlE+8zWpeIJ5OKs7cqqSQV/0ax4lniOKwxn4a8fHafhtDoOIrD9+ODNKjC2CAFPte5+vsKs2eW80YEJqy9C9wVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuM1FlWxPsYZ+fPbGYNtCtHHdBxxzQhZsNNz6I2P3KM=;
 b=ii8UdDKhHfU77Mjfc4BTvo47g5kKZfmIJt1DokcXqq6uC7CeRoJN1Vt5i5HCNZ2jCP6exRBDMTi6AIF73oVrK/9kSgAIh8gwEmWMnKi7QZWs/fOYIt21Mpi/MLF118jrmpUhk0krOtV6bMSNO6Dz4+qP/EeBQbEPOwHW4RglBwvjy5EdlHTfX3vC2pQdtLF+rvZIhKTdrqDcATM9JM3IjqzhXiHPW0UZ3I5N9lUnxUpvkshnYQkHPJ2tbj9Ewc+MbEICK9+fFfxaiINkVXK26MHFofImtgy5Lhn6ZlCt0riczOBrNT2xmJDgAdbn3+m1IlRyGGaLA4qG6v5wafwnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuM1FlWxPsYZ+fPbGYNtCtHHdBxxzQhZsNNz6I2P3KM=;
 b=aailX6q53l5HBkmsLwyLBL0c8khcz/1KfjCssKqVTh033E2MpdxctOXLSslZjV2b/2pHQEjh6reh7YNNYzcRYulzX3Q388hDN9d3XAw6UjZQSYwfLpLoewB+8UY8gcAWLxVip6ZnyBm1F1AdiYCjChleYCteVX3QBr1FKkyHwPYFI6suOTz6fwq74A4OkaJeohiws/RAqcl344CoErMa+DgVAZdVEJk49vcEb8t4sMhq7+IQwfgkwJ7VsPg2y7YAfLntH0NHt42GywvExYy3syGjBlnX87/Aqvomj6wWK1Na7Rght5ZwUqzjbXrYsAvQJMXALgOEYdepC0BSvbO7Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:10:52 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Fri, 23 Jan 2026
 15:10:52 +0000
Date: Fri, 23 Jan 2026 17:10:49 +0200
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
Message-ID: <20260123151049.zv7uyn4rgr75bmog@skbuf>
References: <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
 <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
 <20260122221848.py4p7mwxzybicnsq@skbuf>
 <aXMhWo0NpPK-BELG@smile.fi.intel.com>
 <20260123121529.inik6xrfdianljq6@skbuf>
 <20260123135501.7m5wqkcfluxqeowb@skbuf>
 <aXOGPUP5pfGeAQKN@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXOGPUP5pfGeAQKN@smile.fi.intel.com>
X-ClientProxiedBy: VI1P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: ed22ef79-f4d8-4685-44c0-08de5a919940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3RRLrgWV08/fvWifZoqK1L2wV1RPfcls0x9gkwKjLSFDFB71Yp3QBfE7E8QV?=
 =?us-ascii?Q?Dkid7iko7ntkM0EPxOO5EcBnG5gbuSv6r3XO6KICslbiRfrD+zZ471YOjML+?=
 =?us-ascii?Q?43MV24YR/cUO7mBNUMqlqzddc4zWJmPx0PVmGLOlaEc5A8revMfNwNwEs2vH?=
 =?us-ascii?Q?LjuOvYIbbPKm0QYALBnGHkHtkm7YQzcd37gdBIKQU5mwa4OZgNiK9NwWgKmr?=
 =?us-ascii?Q?HSuOMQdVL1Qhu5JD53AnHe4sjstY8HPWQJ9LP1kyHH6pC2O1q7jitVw6WEBk?=
 =?us-ascii?Q?TIPC9Kjn+SqQ7703ym+BbvbDNeaLUysLDHT6Y7Wx8y0kJraSU7nEdzpm2vk+?=
 =?us-ascii?Q?1dgLjfy77dqFObfWzi4dSUxR3eSIv3rIgSBwlTlak+L+NHLTNfz+v6CG2Ibr?=
 =?us-ascii?Q?V+sHIZ9SmwyILl1r1W1AzzJkR6Dt4d+c7YqNhcjLVFC3vrRxmdCukuXssb9P?=
 =?us-ascii?Q?u5DGr8ggAJA9tE/dC4QjL/HOBUmOT0s013Zn9tdB7+U8qPeCpQdrjlWk4BH1?=
 =?us-ascii?Q?sFiRYuDavsjCFjGsftExmtgN0Y2mSi0Ekz9qd0h1q5ErwATszKDPRGhA4CJb?=
 =?us-ascii?Q?lZiKDvEuMlrpcGX4u5xRl0DUDEGA0iHoes/YGg8mb/PX4UWUk5/ASC7GneIC?=
 =?us-ascii?Q?/Op7PPHX1lXXxat1A4YvlmxV7g0BmmJXbwOczOcvYCQr07L/MRESdKSVkfmv?=
 =?us-ascii?Q?xZOp610dWBW1E3o+pHtFEOXLUpKpZnu2e+rgTvyuxw+Xe8CUi1rGaqqXI8sg?=
 =?us-ascii?Q?w24oL+lF/GxXxHMsXkBx4PPx4aZEjcBjU7pl63hZXnKkPXihprmrMn8enqG/?=
 =?us-ascii?Q?jK9RwV76QCDhe9CeFVuZmAOHAL3Ip97Y+qe+1LuAYvtQsHXWgvVK22s+szAN?=
 =?us-ascii?Q?Qvpx+YaNo82HphyNCONfnVLp7dGh0p+a0sgGsnPNeAdae+YfIfK0rk1NWXrt?=
 =?us-ascii?Q?pokEiIUt+n1HbEyFelAInBJUDutM+t6atEdYWn6WfZ90PSqdZxYeOpmtPu9q?=
 =?us-ascii?Q?juMGOLFnxVQA3fj6z2Y7HzaX3VZF2/QFA0tEIKr3L29UCahKfD9KKNZyc6lQ?=
 =?us-ascii?Q?vaOk3NzpdKtNql3ydm+YcMO2gYt80Cyd/c12VLLonvLkZUl8t9m8/l9l7nOH?=
 =?us-ascii?Q?2+aQiwlgmMw0rXMDkRi1RtZhHOl3fAHJTzWL3WYuqLQivXdKkLx6OEZIIQha?=
 =?us-ascii?Q?7ZoD8NkIVX3wJsSw0MttE3/SOsZPywN9tT+a5CsGVtU3DdcS7eUmwxw/xvGg?=
 =?us-ascii?Q?xiDiOxmwisUvM/Ir+1vQGvLTPaS6nsiOim9OUd8uhUvTnwvS5OZdFS1cmdyX?=
 =?us-ascii?Q?BNsSntdpKf70KNxzQNqHhK3pXcuiKfWrReHNvds70rvyVB4MRFp9JpKnx1iP?=
 =?us-ascii?Q?OZ0fqNYd1oo/GgO76VhHrJlFybktVggJ/Zpgy06MyN+kB8cj7nGBlegBpFVZ?=
 =?us-ascii?Q?zlpqCDJbCPKmOqzze6El9Vp88mSQAyVWq0IZxI+ERblE6N491qWtVsirstlL?=
 =?us-ascii?Q?/dWtVghvFaN+4r70nXmKz/5FS+1jfIi48EvPWE9n7swwzLEJpM7lS3SyiHUv?=
 =?us-ascii?Q?df4Bs4bDnsTdwR0Ow+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rR10njkpMAe/x7kj8KHA9bkG3GKQncAdZGyxSoIksbMCPggFk8pdjFKjpapN?=
 =?us-ascii?Q?LIt5XcGiP90pENeCR9ztaMO5dC17Hq05wNUETjih7BFvd2QyL8CPoA6+cXJJ?=
 =?us-ascii?Q?cQe/4sxNeZF2B6PPw++OLaG2bkZ9Q0B4uQtMhYGJOsvcI1FTNITtZiBGPxoV?=
 =?us-ascii?Q?8o1eBTu2U0vasgU9V+C53BBxrxTsL2qWVJR1+3G7q+o9QnxEuKKQZdpOj0o5?=
 =?us-ascii?Q?kL/V/EGD6yPi71zBy/2vb2+mL77ZGfe5IUzVZh9z99Fc+jTipn7JCTMFQPRr?=
 =?us-ascii?Q?CAx2cI6PhNJ5gVA7V/nIA6p5+0CURQqZfgQb1roQT4kuLOSs+CWhwepm3mWM?=
 =?us-ascii?Q?TUAVPeFs4UfVOfJh1hu1cy7NGY2UY2h+HQEUlhHuGsENVY9FsFoVsqDRkTeQ?=
 =?us-ascii?Q?MPzFPkA7/USW/4RaoBHG4w1f/80IjnD65VLGEr2qRl9ehqV1Lik58st9FkYm?=
 =?us-ascii?Q?btHic/AmXAex/Z6iR2dRMrPbkb6Y5CGftcvsNQHY++tnoD1h5FR0VFn2H8iP?=
 =?us-ascii?Q?0YIuP1b+l1NCiq3+CcYTXqxddj1uZ0yMo49fCEiGqjHmmBflBnU8gQqFwU4Q?=
 =?us-ascii?Q?fFTWjgxWUB7DjASG1LKjviEd1lzDtJ21g0Rya7tJxWuriTabgBu+8SiITweN?=
 =?us-ascii?Q?wQWGMGXsAOJFcdbI3OeCHctZcp72mHOrKbqFWG4uJ3FCcq0OvBV8kJiw6orW?=
 =?us-ascii?Q?gh1kXnXcfVGXQzgVLbgjNvmfiOEvenuVHXGlWwNeExMb3TofaDiJVaOQgLPj?=
 =?us-ascii?Q?FdnyJQD/D6XoE2N3L7Hu/6zrcez0NMjgAx5iO0wOELDzChdMe3May8N2zPI9?=
 =?us-ascii?Q?VDF2uR23lhSdJAqkEMhsd5+1jikER3bJNO6TzOam45zAH2hFBJi+indu9/cQ?=
 =?us-ascii?Q?E31LyHOar2roVsVEfB6QOEgKC7CFl/5qau4HrCe6Qt7c8hXnC2Sz6WqbZ3zY?=
 =?us-ascii?Q?9jxxaknxOe/OK7YJ2KO9wU3NhBHeeqGBm08geDfPqp2T+RiIbpn6EoJploCZ?=
 =?us-ascii?Q?8t1Jr1Qrn/R/gLfvEFwPzNNYx0LzqgXsjSkOoax024ScV9jYXS1oM4Xqqbz8?=
 =?us-ascii?Q?g7ANcAX9GjxjH9jx9Ynv4xQZ55bUyFwcsFKzfA/NXyFfb8Rq4PjOkSGP9dgu?=
 =?us-ascii?Q?7BkAGIFDO05yW+3BTk13aKnvNzxltAvDTB5pO3RvrI5+Z7QkzcZE3z3zApaF?=
 =?us-ascii?Q?nZQMekFQ1QfDWkK+NgwSvNj+sZgce+NNfM7WCRKHTXing0idPmnCHF090VY1?=
 =?us-ascii?Q?/A/M8FX3M22+SuJG1tsfPHWvfwEAwQiQzdxyTGpIosqEQmXvuVnI5cVgL1DI?=
 =?us-ascii?Q?Sj7oF//G+ur3Z8ll4Jh5sxyhJci9G5zdiisYgHnyn8SdbBGSyuXroO/18TxP?=
 =?us-ascii?Q?t3CfcAy/QOxVEqB2P3Eaxi/TXn6ATRN8D5r95HfgnQmHQRd3LWRmXFfqlmKb?=
 =?us-ascii?Q?cDFm+rCL4Ry74M6iqGWxK4o5nNSiKwSJgZG5E6mbDFE8+oEqz3sWorXswOli?=
 =?us-ascii?Q?TMhiaIc95zbKDAQ6DDg7+sVlcbl6Ca/WstidCY+s6Q6Qs5oub2Fwr1WPikca?=
 =?us-ascii?Q?M55GTrc4tR5hOcowWyWnM+vZPIxmn/+ba1tpPFduN/lZJfPqnNkZ/pMWWuIu?=
 =?us-ascii?Q?Y3TIQfB+w+cZGeUckNfcQAkqTahvFL7JvxfAACV7uJLGczuniWzzlyddKJn/?=
 =?us-ascii?Q?Z5iXrIV6YocUj87/nalhHwBW7mi6Qnk0rKTcaMX7R4zDMNEOgssYqW0l75K/?=
 =?us-ascii?Q?hU+0Xzo6VSlq0DqiJulkoqlM7EbqTFcVnmG/57ZD0SYac79yJXbtgLFDyQs6?=
X-MS-Exchange-AntiSpam-MessageData-1: dhokAWXtyhNhs0ThuFegV6UpXXH1Bt7cpXI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed22ef79-f4d8-4685-44c0-08de5a919940
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:10:52.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nI9cAdWfp//LAYn7FAMIRM/lLjSkR2LaaTLh0Kl74KZMDZG9MudXyjIXExMf0pKCp/fusEoHnjfFzlcNgxBZYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441
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
	TAGGED_FROM(0.00)[bounces-252863-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64E8F7793C
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:31:25PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 03:55:01PM +0200, Vladimir Oltean wrote:
> > On Fri, Jan 23, 2026 at 02:15:29PM +0200, Vladimir Oltean wrote:
> 
> ...
> 
> > A data structure which I find a bit under-utilized in the kernel is
> > 
> > /**
> >  * struct regmap_range - A register range, used for access related checks
> >  *                       (readable/writeable/volatile/precious checks)
> >  *
> >  * @range_min: address of first register
> >  * @range_max: address of last register
> >  */
> > struct regmap_range {
> > 	unsigned int range_min;
> > 	unsigned int range_max;
> > };
> 
> Not sure. See below.
> 
> > I could imagine a helper like:
> > 
> > /* Type adaptation between phy_addr_t and unsigned int */
> > static inline int __must_check regmap_range_from_resource(const struct resource *res,
> > 							  struct regmap_range *range)
> > {
> > 	struct resource r4g = DEFINE_RES(0, SZ_4G, res->flags);
> > 
> > 	if (res->flags != IORESOURCE_REG) {
> > 		pr_err("%s should be used only with IORESOURCE_REG resources\n");
> > 		return -EINVAL;
> > 	}
> > 
> > 	if (!resource_contains(&r4g, res)) {
> > 		pr_err("Resource exceeds regmap API addressing possibilities\n");
> 
> %pR
> 
> > 		return -EINVAL;
> > 	}
> > 
> > 	range->range_min = res->start;
> > 	range->range_max = res->end;
> > 
> > 	return 0;
> > }
> > 
> > and then proceed to use the simpler and validated regmap_range structure in the driver.
> > Too bad such use is not an established coding pattern...
> 
> Dunno about semantics, as I only saw the use of that in regard to the special
> slices of regmap.
> 
> Also we have struct range in range.h. Maybe that one suits better? It has also
> some interesting APIs.

It is defined as

struct range {
	u64   start;
	u64   end;
};

So it could be used, but it still doesn't properly express the fact that
regmap takes unsigned int register offsets (which struct regmap_range does).
Furthermore, by using struct range you are coupling unrelated data types,
whereas by using struct regmap_range you are not (if the regmap_read()
prototype changes, the regmap_range field data types immediately follow
suit).

