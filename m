Return-Path: <netdev+bounces-252548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LRjGmOicmkOnwAAu9opvQ
	(envelope-from <netdev+bounces-252548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:19:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C551C6E1BC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F38301176B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5953D5F24;
	Thu, 22 Jan 2026 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kjiAuH3u"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8D3C1979;
	Thu, 22 Jan 2026 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120350; cv=fail; b=ucRnqAznKnjSflZq/VwC9oSBlg3zkkth3QK14unumNnuH+SGpoeOKGG9HZ5XUV/k7J7PxYEy/zCuvTrtyvXsjlalxx3jBxELV69IZDIorF/iJe489okKUDv0nwp5MUD5k92akIPPnuwlea9qvI/c0AYpQKQeZiijoHnXN5yjXRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120350; c=relaxed/simple;
	bh=9m+jRRtxx2WsOuk/dtAKEAx0m6MiJYn8m9Uwp9kGw9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bF2j5tYzurfST5noJv4FlnVtIuTWTWboPvYIGQxNq/v/wQ0+lRlk3TnqhAXYtp2L3Fc3kabywCpTwGin0mKI0aZbHbZcKdLJ7hwXYjrIZn1zGLAqtfmFxziX0hvc5z4wFlLUB7RSPrjKouU8XrLZlyzAURoK9zaxr4GWTTDLkCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kjiAuH3u; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYKugHaeRPRxKBWVMQTr8yNw9gNFtBBSWebkuvI6LslEu4Eh9IbBnOMxt16Fr/K5sU7DO5sQ+zQX6bXhD6jOjr1sUE/MkDeWGfyHGAI6PYDIJCgttyvEq+Wq0qOQy7POQ8X1Y0tKYu/AeGljd8F8zmt+b0wuoRN+bGVdAHzy5wAGRb7LKDWsBaco80IXjPUSX7f8BJetfQ5Tsmj3he97beSBhEPFV4YAnFWISUueVW49bKsiLiy/qYVWRREt/1Q0TutJTgIlDlcPOKRlkFsfZ3x/7A1FkpJxdhcrlWoDEKcLr+wuW009H5j13dKGg1HvpWbGZ6PFTFeG/FcHGqxSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuR5TFAmK32nlA3Gdra4yO1kBsxNwCpkWk5DNwmVYEA=;
 b=ZM+czijHMhe0OHr5PL64Ign3FExPY99Ot05FDD4ELH3gT26qRcKpDPNTkAlaUmqGOKKjWWm6kbjE14MB2LmBeq8c3kLsJUX1dwDaLdFpUkerz68bO65cvlPDmhiar92P/7S85GCoJ4xw5+g6eCEdBtAQYA9nLIlHoFKdiZ1qRpDrSth+1YgSU0iivw4YTAziqywGoekcw9jUaD7PqRIfPnCwEESrNfHS8UpzFEU/UWvextReqg2ytjGSwOQmGco/ujiIoLBZRi1E6fx/Q4ZbHRqgSWcXlt/SDiVqxY2sxDMOzxLkcxyYfhTClkT50X6JVQwNnX+ZEdfhNp/NakKgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuR5TFAmK32nlA3Gdra4yO1kBsxNwCpkWk5DNwmVYEA=;
 b=kjiAuH3ueonvwm6X0YjBIADQ0SFT6WPAiKoPWT6CSH+9AOImGNI3b7yX7AkA1/E5YwuGd7wXUDGupH3MB+LPYbnfdYcdIzG2/r/tuG3wHCfjs4reZbyyhe+KmzDvKPaq2fPnCUKII/+RGbd9bRwUL2BuPlbdDEAlubACjXDH7uM8NMBqfAO3WUn1dE4xvHhy+H9OShovnhgialINCOzF0cDF/5V9D4KVUoKYKlmnb4ZZSoVG17QQqNegmyp7vqSdtm4NAKf2DWQgSoIVcEAbd2wWNd4MKsGchwMeWQoccnlwp75U7pLTOCT4SJKjNniHpSYBADy492KoKbBpFlNm3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by MRWPR04MB12048.eurprd04.prod.outlook.com (2603:10a6:501:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 22:18:54 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 22:18:54 +0000
Date: Fri, 23 Jan 2026 00:18:48 +0200
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
Message-ID: <20260122221848.py4p7mwxzybicnsq@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
 <20260122134704.pxeikyk4q7nhay55@skbuf>
 <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXI2bWhDtNNfr8M8@smile.fi.intel.com>
X-ClientProxiedBy: VI1P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::33) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|MRWPR04MB12048:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb40792-1c91-4c31-0556-08de5a0438ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9j6p16Ss+XVKSv1bnTL3ATHWGCXwc6Jf4KQnutewUlsJeCSs5FYIEisrZ4Pw?=
 =?us-ascii?Q?l1qFAudAxkFZR1ebk67fOw7E9wD92pYNgS4uZXXP2uxS9x3w6e7c66FaPu5z?=
 =?us-ascii?Q?tQ5T1q9a2P9UyIDHihesZLgYOJYyi/Pl6ahrTSnE5vNCtxUd4p8fiy9K6VCp?=
 =?us-ascii?Q?+kioq+ceATbSbx2qctQj7o/6N5uvnjCueddvYjrTJeWC6dfrl+uY5s0+/kgT?=
 =?us-ascii?Q?pUYGzQwA0C33vN571ob7WCZpwuRzP2K5HNklfKmjfkzMVeplageu6Az+DR65?=
 =?us-ascii?Q?+9aMzrkrDYixeBeZQC4fw+GzpdUuFUl3t5FJaAcAAc57k4CD4muv1oi1uR1v?=
 =?us-ascii?Q?k3e7WXvaSSkeFHLu6MAvzt9VW+8CUgYpkTviQMP9fs5yv8Kk72yW6tp76110?=
 =?us-ascii?Q?HP/k6UpG5fQB5XZI24qJ/AfNezN323JGRDdtJkDEKIUU+rMnEgtjlSp1G0/w?=
 =?us-ascii?Q?Qtj8ZZmY8/i2kDDw35MRSRKEYvt078u2GLCuXHmKhuBJYov4K4xfEbSnXEaT?=
 =?us-ascii?Q?wN4Yxb8gnmA4e8fUeoJzqjmJa+/0VRxVi5gAp7GZtIbRyjruP53qLhxfgawH?=
 =?us-ascii?Q?UdK2m/S7z1cbkynsVgqrUdSsrezAT2kRv2ODMdUkCphtQpMb08Wn2+doPy45?=
 =?us-ascii?Q?hyQeRHgpcrDcBih19/pqTdbSHrNui6L6Wus1gEADPPsk3snFXpZWTASfJGep?=
 =?us-ascii?Q?U6DREB8Ufk7xe+QLHC3Y1QRvJ3lLqIWrC/42hU/X0R8tczDvQpRVga+f0elg?=
 =?us-ascii?Q?Kuh13M1Py2XzLRniF0/aBXljY+RrkCL3mNDFfc/z9gFcENJns9TMF1RYkFW7?=
 =?us-ascii?Q?2NBaPBwzfy8VpHHBCTD3wMcxwSxm3NrHgxDN42xDVaxQs6JIpmGF34D+TMfc?=
 =?us-ascii?Q?/U7PVlBQAq3aWqzBle4pIO5in8K8y8RHgy910AqxWgb16IbPU7dgjDxBlnYN?=
 =?us-ascii?Q?T1xvUJypWPfOQ1G6Fx/f+BK9wzX+HsO7FJsb6uul/ViwjsK6cVCt8kf2OHfh?=
 =?us-ascii?Q?z/IITj/L4sKFvjDL2YCByopqBIr0K7k2c1kYTf1CIVCHjIYraCLgnLiTeMMa?=
 =?us-ascii?Q?RkbrPynSF87nQlBpoBhGPRiPVBV/KTRqBzKUE8Nj/EBmeK8GsLR6o3YOLeaY?=
 =?us-ascii?Q?OhAgP70/rwfVj8xKE6LwdRJ+hUGTx6Tt+TXP8mMIkQqaS8Dvv1TYLi24d0D/?=
 =?us-ascii?Q?GPO523LLniguEz14V47SKIYen5vnYXNtR4rjdpr26wROmmFJpAtVUhvap5Z2?=
 =?us-ascii?Q?Oooczyed9zwwg5dvWDbCYJQoSR88mOjN3F0z7n9EzghYrLs3lUznCI4janAC?=
 =?us-ascii?Q?dVAcOQbeIaCIeNw6vJIHth6a8DTV3cgIxX63oELs1TZsA1e+0H7YpbrMPrUf?=
 =?us-ascii?Q?9BVLZgRzs3CHZNE4MtId95bQIz6kbWKc/+Yf6hHM2YIJDRdj34eZb6cbSWxd?=
 =?us-ascii?Q?cWoOv3Pe99K0MfG08bO65N1K+z0tU/0yjfQjbxlBZ0zSumD/M2J57MzBbjPO?=
 =?us-ascii?Q?3CasbtgPg4tKpTRJIkelUdCn6sCyBL37VQAj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HIYeb8+qIkvd3wQuolo985zsmDS9UHoFKRDhfwSslilpK1wclE5RVKRD2JR2?=
 =?us-ascii?Q?fqYfKOF7ID2E19tGcAHiWPQeKYqwR+06/Zkk2jHfem2UXAvXc33H5BB1ul7w?=
 =?us-ascii?Q?MyEcSfYP2FqeBYZImqALAa4+gBKD/Anv0xKgzawyMWhvabPdNg89h865ebTf?=
 =?us-ascii?Q?9JZm5K2Y8RRLLeniUPgM8etUynCNvgkVa286NQGKtxx2KK4Hr/qVCA5V3j1n?=
 =?us-ascii?Q?P1+wd3MMDEH7qq68nuAavXQJfY10EXuGLz1eKUjeJutpTjXw8FzZxaYu+qZZ?=
 =?us-ascii?Q?ROGjzRgTcK8ho5p1HlljFhWJAVQwCcJT5le3xJRWe2W6zFFbRF8C2cgwq4mv?=
 =?us-ascii?Q?VpD+mi2A/mOYAfb4Rrc9hF8Zn2ut9wzeSXqsWFvQ9XSrEyq54RiqDWsmmPnZ?=
 =?us-ascii?Q?6AmWuf/Mu7CYrH3nPSKYm7dwEqkZfrKxQAkV/k9iTxFlgnbQL4SqIGRfjzKh?=
 =?us-ascii?Q?2gq7oPPxv1ylzlC5uTraN0WgG87tP2e8gMC1FqgcHIgbW+1Vymey4sLpPGF8?=
 =?us-ascii?Q?cEM/2RIVU882LjYm+zPPc4pmpg++9eZ+ki+zAqxTKjPYtQP4R76MeSyrB7Ls?=
 =?us-ascii?Q?BewO8JCUends2h5XSsdve74MTN/kUA9Zld/HDMkil7FwA7tRxvOMw5wiD+9r?=
 =?us-ascii?Q?+gxX+AJi6xN7ume4H2zlYOFNQz/RzH43ZikY3i+WTZp9FJWtsXK4iSSOVURu?=
 =?us-ascii?Q?j5KM03l3/XG0WEAVOrHMU2+Gaulyay31Cx1smO1DszpfzrX29a28g9TQltEa?=
 =?us-ascii?Q?WfR2+xKlRE897PygLxKhrx4eIh4Z323VyZfbf8yTJF1buXri4KlAY9YBPDf/?=
 =?us-ascii?Q?z9+xE2ZHWPiqs9zyGbpiv7O4wVCmpd6l+2Bs8vigPDKQu0DfR01J5oN5z6EP?=
 =?us-ascii?Q?7H84+tSlV5Khcn7gH1zwdtMv6S9QNtaGZBrZs72WKHydt9on4p6ADnBrv226?=
 =?us-ascii?Q?ABn4qLr3c63gOEjxHGm7eQNTB61CGEccN6xd6kktLuKMjkVKDHHkyI2/uhYK?=
 =?us-ascii?Q?rl6jlp9uX+ykAgGdPnVujpFeYQZR9wo8zbKv0tO+lltK4roTagfBOZH2Olky?=
 =?us-ascii?Q?WndsmQXVnowpCm3HCT7NZ5fSLLUCQbWmQ20cw3ECxbEBw+wtY3irmPUa3Mz0?=
 =?us-ascii?Q?chsOBxenHJTXEMp+bSxsthTZYovXYxO+xdVxywIj/boKQruCeuaUz5rMbUdp?=
 =?us-ascii?Q?8fK3X3DLhG5y0niuTXicaiEbgPWdo23zOlWr0pPb+gi68veQrZ3H+3hNt9F8?=
 =?us-ascii?Q?SbgPZCikPSrRFUdf3Cz3PR4e7MtqAgzN0GPsy1rzmXO9p7sLQ7Paa6kZ9VwQ?=
 =?us-ascii?Q?nNnChJ8GugTLuW5Nh76vsiLZ+WunyvcGpDnc0fuTXO+uvUVev+fkefSN+rdp?=
 =?us-ascii?Q?8JtCekYbxOXruXQdc6+7MnmIP33EF2FcnyajHb6mMlHDzI8CUbITsRfF5eoL?=
 =?us-ascii?Q?/a/lU+d3WHeI0SLlSt+asV9sLHbgXij09Cn6dfvU7siUxVlAieVPFvhLWCpz?=
 =?us-ascii?Q?bS+aW4UgPp5AG4MrwhUQVtWKPMeQutI0e3ibyA8CBLPRPA4W3aGlu8l6BVLZ?=
 =?us-ascii?Q?zLG2EYf1WxdG3YjV58BsaRYDN1qcBH1ibWpTVZVR8xeXr1tyf6pJYQLTDkLq?=
 =?us-ascii?Q?u/AbAN/kAXOTy4yQp2dhDxq8PB6XSogQX4me0ixWUH8LnITz2M0mkQto04XY?=
 =?us-ascii?Q?ctRujFTcCgf09kmFli+v8r+f9TiW+wFis6Pc24ALZ9Zrz8DnuGolowOwpEwR?=
 =?us-ascii?Q?Pgosh/4ctQ4FesdBvmYp5yzVJXRD36mYu5lHgsRJyBcGs2bOnnMu2UZ8Hj34?=
X-MS-Exchange-AntiSpam-MessageData-1: /p34SHpaQl9sXnBs7meKlcgF1EccHl4G8Dw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb40792-1c91-4c31-0556-08de5a0438ea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 22:18:54.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbF8Ne+FU1lUcC5zRxDb+b5y7qf0VUrM6rTYHQo//j0kneH33ZJVKfHwFF5WaGAvkCPI2cNnVsKN97X3zbl45Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12048
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
	TAGGED_FROM(0.00)[bounces-252548-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,nxp.com:dkim]
X-Rspamd-Queue-Id: C551C6E1BC
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:38:37PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 03:47:04PM +0200, Vladimir Oltean wrote:
> > On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:
> 
> ...
> 
> > > > > +	unsigned int base;
> > > > 
> > > > Hmm... resource_size_t ?
> 
> > > Well, regmap_read() takes "unsigned int reg".
> > > https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/regmap.h#L1297
> > > So in practice, a truncation will be done somewhere if the register base
> > > exceeds unsigned int storage capacity. But I didn't feel that it's worth
> > > handling that.
> > 
> > Would this address your feedback?
> 
> Yes and no. See my remarks below.
> 
> > diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
> > index 2a0e9c519fa3..416ff4e13e8f 100644
> > --- a/drivers/net/mdio/mdio-regmap.c
> > +++ b/drivers/net/mdio/mdio-regmap.c
> > @@ -67,8 +67,15 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
> >  	mr = mii->priv;
> >  	mr->regmap = config->regmap;
> >  	mr->valid_addr = config->valid_addr;
> > -	if (config->resource)
> > +	if (config->resource) {
> 
> Btw, this might be not enough, one should check size and flags as well
> before use. There was a discussion about this recently. Maybe we should
> just move to a simple unsigned int in the config for now? Because handling
> resources maybe considered as over engineering in this case.

The resource flags are never taken into consideration, but I can for
sure replace the resource in struct mdio_regmap_config with just an
unsigned int start and an end, but that doesn't get rid of the resource
usage. The dev_get_resource(dev->parent, NULL) call is how we learn of
where our register window is located in the "one big regmap" provided by
the parent (SJA1105). So we still need this check somewhere else if we
wanted to not fail silently in case of address bits truncation.

> > +		if (config->resource->start > U32_MAX ||
> > +		    config->resource->end > U32_MAX) {
> 
> Ideally it should be resource_overlaps() check. But see above.

resource_overlaps_with_what? The only problem is that the resource can
exceed the 32 bit representation that regmap works with.

> > +			dev_err(config->parent,
> > +				"Resource exceeds regmap API addressing possibilities\n");
> > +			return ERR_PTR(-EINVAL);
> > +		}
> >  		mr->base = config->resource->start;
> > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

