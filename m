Return-Path: <netdev+bounces-252342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BWbORUocmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:37:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5736A67620
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC1F79490DD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91162BCF4A;
	Thu, 22 Jan 2026 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bn9Welt1"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFB296BA9;
	Thu, 22 Jan 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086036; cv=fail; b=ChZjibt19qHs/yUr7iwu3C5yzJ3bt4bDMv7MJxQYDoIfrk5HdfjUkt4nG5wHWmTdJhUnwHQ1qXaTOF3aWMX3sS4/HcXnz0Rle/J7LWhDRxfomth3A+wZIMrIYjZc/8vZr0eP6fA1C9xRCbGodOLTxMAuc4iGD7fbWzUtr6BFjlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086036; c=relaxed/simple;
	bh=6rAQnupXaAV6DvTP+ieGDupkuBic6xuN0tnwVARpuI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZC4zu8c6i14O9pcc/p+oZDJsouCfzvlOXPOsPwL77Gr9z2TkuDUnz/1bmmpeQP2M/JhgGg+KNWDn0XLDAIxuATyrLKlVJAbY43T/7eGqwjQ3aFPSEL7P05dxoYP+yqOwIjrB/CWho8+OUQVV5McU7E+qSyKhb+PkznhwuYSOCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bn9Welt1; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4JCf+UALlkofZDVT4Ie42+sK4BaBfTHStxeTa5z1XGj8WwUL+xTsr1BfZMhDtpA481IlAD1+ZOca4aTUqKW8IS8Z/uTEtUgrrqEFEpYupeBitol4I+xh63PSt9jYkI+JD2YFpYRFk2LY4H04iT5k3YiLKnR79OZrwQ7WKsvNhWsmqdgrjAWxRctLQYfTTtlOdGVuRMvNYxkmGatcAuxridHR+5jAW0RwideO8tzzl/+FPP0Ayozaz5MmqFjHntUUbGAC72y0UY1h4yMDP6YPe4DTfDMVKsCr7AN4EpeKqicOjk3eNetzGpvYFNrBSHc7dgnX0V+yr9VircIsVCoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C04cBgaZDloCOa5v02MgZH5NGE6IOtP8EGv+fjINo90=;
 b=xmNTXOntRFXAb1uOtMFewx6ZuUw9KA/21U9S98aaXkdk5jGC3lQr4rTJvNh7JfuDgID65or1P2mGAvhrs5PxBZOV20sCnOdm1iBDSx+DmuhBl99fjNsjW5ig6dgeQn1dI2G3n+En5VEgxM9L9LzMMZ9/c4Y7cTR2+QWdBDSWOCtb4VMQPNMfVtBMtfCx5eIf8FnksNoP1Vgba9Q7+0BGAo2w0+s8x7fCqKw1zXnop1ix7miFyxKoPGCiVktbH0Yd44oLpULSpn2qM/BhVceUmm1aDii9WwM/93406cuyVVttH+coS1DDgoOeq6hFIzzT0D/8p+FcW7KOtr9prEcbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C04cBgaZDloCOa5v02MgZH5NGE6IOtP8EGv+fjINo90=;
 b=Bn9Welt1Sq3yb/IRSrTI2j8npQ/iXrFmhfvwcQ9lSHQYWWogCxqpiU17F/VuCIH/3OFYoQ1DEpokPl+GQ4B4kgLQ/4u1Kx4F3cS1oLhTz95hdGGVo91Sr297xQVdUDYyHFzJFXuYUM60VJUt1z/0alfoovW7BN73sAjU1ecehQDE7H80sCn64yeqvWMC/CmjHDL8Avj0OcHfxZr7/0D+qPFqAsgLoezXBoXla+6ZwCuXinDPn+XpFAdu5VfECkaNnzoPsxC1HRSl3lJgD63kD/3vHXIWHwNnfspf9KF3xv981imvd3gfMxuwzUa5Q2YbTf01tX2LjVe10EjjDxR4Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8441.eurprd04.prod.outlook.com (2603:10a6:102:1d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:47:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 12:47:11 +0000
Date: Thu, 22 Jan 2026 14:47:08 +0200
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
Subject: Re: [PATCH v2 net-next 02/15] net: mdio: add driver for NXP SJA1110
 100BASE-T1 embedded PHYs
Message-ID: <20260122124708.pxckp6vgi2rvagmm@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-3-vladimir.oltean@nxp.com>
 <aXIUJbEwnAvIkeKK@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIUJbEwnAvIkeKK@smile.fi.intel.com>
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd57ff6-69ad-4a14-5f71-08de59b45c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|10070799003|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OcNqytP1WQRglarKtrc49S79Q4VJZ7ooerIDQv91GbaMcCg/xNirgjt7yiWZ?=
 =?us-ascii?Q?gc4ChrX2MIw2yxzse8MF5Zs4jRsS/V/9WGnNBqEq9cyZf6x6Heut1TqoQEFB?=
 =?us-ascii?Q?JOSXKrtInNOWcGSidqU/DgKwpcz8SwXQQp9I7PTqaz7oMzYvWlbGyNNghwwR?=
 =?us-ascii?Q?EWN/6h6i9NA2yApAq0c9t87V04ryMXlEdi5/4Gju8p5LABojxhS/AH+PszE1?=
 =?us-ascii?Q?m270uiaBQ9xIBG2j7fevKGoFRP/5MQr6utMFFORMEgBX0QZBpAFAXBZ6k4iw?=
 =?us-ascii?Q?uyDUKpkNgjHCQV2fEbs6WSV++NlP+lbx0hQOnRyBsF8ugjQuxnbgQVQWjbW/?=
 =?us-ascii?Q?DbeDsxPEvpTwZqhaNWS0uFTocBR5VfOinUyLJSb+Qifnk3y125v4JyecqizO?=
 =?us-ascii?Q?ti0IVYSz5/nkJKZoto2ch/T7SeCyR4g+x/UaT+V/NLguynOzenQoilSZZMoh?=
 =?us-ascii?Q?40YEglTRDh1+Whiz0m3rwou6d54sB2zKtGBaK28N1BkB+oqFBArWmCWjrTCn?=
 =?us-ascii?Q?GX6zrxxRlzEM2fZLZokfPys1xzfZCG2rYYk/D4k3N2bUVofeTF2tuCDrRWkr?=
 =?us-ascii?Q?X/6w0LRPoddzCvQnV8YdWnCCdsL46cvaINWzKo+w0CBzzwlyWdiQpkJSdJrW?=
 =?us-ascii?Q?N9xhDYeoWBnjOX6ycPftmsU5/WDpS0fDief1fSo7Y/QrCm6evQVE3OXMiPZv?=
 =?us-ascii?Q?yOzorHma4Sh+rj/HmUdEE3hGUUZtISjEYAlKRA/YV1OZzSZBrCgPXuzszMvn?=
 =?us-ascii?Q?DO9GEoKngFTRQQvli1lpXNuwstjuR+NZGdw3OWhY++t2QaIuvuduOjmNuMcn?=
 =?us-ascii?Q?JF5A5yoeTkqYArKdFG5MZDXT4n7fW1T0nYd/4GgPugmcj6iBn/DN7aAC4F17?=
 =?us-ascii?Q?00Ts7WTrwzwiCJKLwRezAEZIqWFCLcWqC0N5oVff49Y8LqOJMKaAx+nAbdcN?=
 =?us-ascii?Q?u5juA0RXlC6zuS67T+TtIU9f5Vdx+QxRwe9SmmvxAYn3fdf1oDixiHOL1KbH?=
 =?us-ascii?Q?Wh4yZ6LzEApyBgJcbVcN3/p1Ucu8esBdjD49d3Ci2InKaq4LE46Dq/ahCVIa?=
 =?us-ascii?Q?EjN6/bjx9Yk52hoVuwotieyUmGMqM73RXHLfjkBjdxfbI1vQKv60kmLHhWC0?=
 =?us-ascii?Q?+0NMHaNSYcJHYtZbLRPQcRHhFSJJdKs/tl70YZyv+KuwrYwY8s8dtn3fTI2E?=
 =?us-ascii?Q?3qeqpHYZ2UdH3FcgGcozBfed9hZ7Lw9+FPm3jqiRGMSD5X4RnU0Y1JUTE+UO?=
 =?us-ascii?Q?FeffVhzWyd6+TSuETEkTiNaPa6Yx7suUNOZ7gTiQibBFj11VHeM6pHhaFH1p?=
 =?us-ascii?Q?DUIGxoamEG7ANOX0SmW0o9lP2+7JYSHLkFl2SGZBVlkXDKe0wr5rKnVjjj7e?=
 =?us-ascii?Q?Bus7e09mCLR0XTG1KxS/t7/wHglJDC2AmY5X5OulUcw3+vHE+U6F3KIGzQ9C?=
 =?us-ascii?Q?rjRTDPSVTtETTIURWg8wLpkyQ5vGqPuF0GMmZi4vi83sQEEolIXD2UnAMuli?=
 =?us-ascii?Q?zlFHy7I12EMtAiwTU+b+/p8Bk1YQhM5Flvr8PnG4+P5ltgModKaAYy+T6M39?=
 =?us-ascii?Q?ylwEpJsOf7vqpFZ9Kao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(10070799003)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMWHPMQn3sRPQoJkMbqEIcVJQZGcGEO131injmxYYNr5ml23SRF5iP/sWfVg?=
 =?us-ascii?Q?Og3AQgwNuoqfRlEiGb//niQWZFpvV+AcFi8cIvCfa012PwXjaXCl9TKUSbIA?=
 =?us-ascii?Q?QWI6ef4efxNP++kYmQXjFLGJFWpJSdlyQ5elwErpFNW7NIlon+AStvxqAK3S?=
 =?us-ascii?Q?ueXpDKQj2FQn7fJD/Bz9TWB+IvhN7PYNV6tTMjqOT0qtgqjqX5onPXxQvTZB?=
 =?us-ascii?Q?5ni7ry48rviZiWpRupXRZAiHxf3gHqX7U3dNxRLlib6VbMphqscazgxs9odH?=
 =?us-ascii?Q?bjnXwhJVqZcSTas5IMXI9lFEqh5E8LBc/TdkOUCXCvArjmxBAp2f8oOjbaIC?=
 =?us-ascii?Q?PpYE1NR9z3ZhQ5mRS8RUBhG2SpBA3zb0rzx1/hPx1SffHbO7IVKE/nNHoGO1?=
 =?us-ascii?Q?0qIGqcD0uVT0c7DLi8V8ycotlFiVHG+7OTJUHfopAjUUCznW6UVi9f/U+p8M?=
 =?us-ascii?Q?L4LOusim6Rt0tj38CfRNoKAouh6Q/Jee19BYGEYivpz3xBV8ESJ/NqP6E970?=
 =?us-ascii?Q?Vkt6ABzpkD7UmdIWtVNQwLCtDmVc71QyfFgzkjaTl5jxhWYwdnKoYtHlmE76?=
 =?us-ascii?Q?OumK/HJH6b4x7Wo2LlrwqtTpwLtWykNANpiqL+vb8S/uVKjGPnBafnvgcKMH?=
 =?us-ascii?Q?KNMBBwUbs5Ooi1W28p6JNjuSlQWFqSqo7ijaPcvt6A7m5nuo4zTCzFItc43+?=
 =?us-ascii?Q?2saLaXSPTK7K8hcNG/HCLx1nEt7eXQRixqyf4F/lMeTlBdUpR3Ol+sKuYwdS?=
 =?us-ascii?Q?x67WrMZPw0jBCVe1pe6jc+gfNmt1+7JVsmHuXo/swdZFaSAO6KZHJhEayCBW?=
 =?us-ascii?Q?/lA0FtDEo3t7qjxf6IJzVDCZo6uENMcQdNgyNDeNckF4c63rWcNkpxCQS1hR?=
 =?us-ascii?Q?cZFbpn2P1FBpON0aDr+H0WzoXjo+JOUUMnY80iw101QbnVKMXSTxvDXLiYTu?=
 =?us-ascii?Q?K5ciX2eVdyERUYV7eda/2GDD0qN6slk9uBudqf1v8HGQeHlxYZzddvjf0GU7?=
 =?us-ascii?Q?M9SEZJWTrG+A8Vkc2wrs9LmVP6WQtJ4riqtiSo2OGsGNV4gMKt4O/A9J/CDR?=
 =?us-ascii?Q?uw1gxoSvUrd+xtvAqkLV64GBg60tD62fn3VW1lN8wC7JWyxiR6z+v5ae5sUv?=
 =?us-ascii?Q?KsjII0BZ5b1NOzKFZK4C98p07ByFs5TuSDDQvUrqOVfEd/L/LyLisdryOsWi?=
 =?us-ascii?Q?kx9IDLGPIXxRgsKCzzTH5JWf/j2GuSGty2QdUAznCyFyIOR0lEVjozLcdw3n?=
 =?us-ascii?Q?U+FBr0hh8vyibht1xRqTdlZb5c95qq++DJaRJLO/THiMebg9ehsfOjt5g4+B?=
 =?us-ascii?Q?UlwJWIstuaAsHNtzybCCiKb9Bur1T3hEDUzUwBo1MsFS7Z83UeNf4qjBXyxu?=
 =?us-ascii?Q?QTIF91R3wjkGvSgqTsvgXnCGE2F+B5Ubf1evtn8a3jfaEbWSiazi+ckXTeVT?=
 =?us-ascii?Q?H2sVD2tV0KdjHsnOj3MPS1ZFEgvcnFgNV0V6/iK3oQKtAlPOqc7Y2/LjS4gj?=
 =?us-ascii?Q?BYrkZQ/Ix4hk80RslceNTB753CHiKfbI/mRj6LIZduJT+Nbmv2mg9ajeseTy?=
 =?us-ascii?Q?5TcqwU1D6e+YyAgYp+ubqXf+pUSMfdUKzqbs8uW/a3pDTLrhDTWAIJyFmhRI?=
 =?us-ascii?Q?tpUKvGxMWFvFTh6Gl9hTPjQ0UURIYotg7H8Pkwc4U067VeOZChMXcCa8FySN?=
 =?us-ascii?Q?1lypbEHrxWMP8wTHbVEzha+FoHXWm1pmtiPTprLTVOvD3CexOThVJvS2ZId7?=
 =?us-ascii?Q?kY+xr6AklqNjE5UcVPNtpxqgVt2DFKX2f5azmjAHctW8sAW48KOZufwwBOtP?=
X-MS-Exchange-AntiSpam-MessageData-1: sLzR+Ni4hGBmuvLQq1aRGWvLik57bt2Ak74=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd57ff6-69ad-4a14-5f71-08de59b45c6f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:47:11.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmMlmr6UwcLO5h31fph2/9xWWF7fvDXapAqFLPeAMwVRW1Kkdxy6RuaRXW5IrwtYxBEN6O1q8Xmv8h9LmmDeFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8441
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
	TAGGED_FROM(0.00)[bounces-252342-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5736A67620
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:12:21PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 12:56:41PM +0200, Vladimir Oltean wrote:
> > This driver is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
> > In terms of differences:
> > 
> > - this one uses regmaps provided by the parent as a method to abstract
> >   away the sja1105_xfer_u32() calls for register access
> > - the driver prefix has been changed from sja1105 to sja1110 (this MDIO
> >   controller is not present on the older SJA1105 family)
> > - in the sja1105 driver, each memory word has 32 bits, so addresses as
> >   seen by regmap need to be multiplied by 4. This affects what
> >   sja1110_base_t1_encode_addr() returns, and is different compared to
> >   sja1105_base_t1_encode_addr().
> 
> ...
> 
> > +static int sja1110_base_t1_mdio_read_c22(struct mii_bus *bus, int phy, int reg)
> > +{
> > +	struct sja1110_base_t1_private *priv = bus->priv;
> > +	struct regmap *regmap = priv->regmap;
> > +	unsigned int addr, val;
> > +	int err;
> > +
> > +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
> 
> GENMASK() ? Or do you have already a defined mask for this?

Hmm, I can't find a definition for this. In the MDIO world it is
"well known" that clause 22 offers a 5-bit register address space.
So the 0x1f number doesn't seem too magical to me.

But I think my assumptions date since before the MDIO bus API was split
between separate clause 22 and clause 45 reads/writes. I don't know
whether masking reg & 0x1f is the best practice. I'm surprised that
__mdiobus_read() doesn't enforce a limit on "regnum", and I don't see
other MDIO bus drivers explicitly C22 registers >= 32. I really don't
know what is the best practice.

> > +	err = regmap_read(regmap, priv->base + addr, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	return val & 0xffff;
> 
> lower_16_bits() from wordpart.h?

Ok, let's say so.

> > +}
> 
> ...
> 
> > +static int sja1110_base_t1_mdio_read_c45(struct mii_bus *bus, int phy,
> > +					 int mmd, int reg)
> > +{
> > +	struct sja1110_base_t1_private *priv = bus->priv;
> > +	struct regmap *regmap = priv->regmap;
> > +	unsigned int addr, val;
> > +	int err;
> > +
> > +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_ADDR, mmd);
> > +	err = regmap_write(regmap, priv->base + addr, reg);
> > +	if (err)
> > +		return err;
> > +
> > +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_DATA, mmd);
> > +	err = regmap_read(regmap, priv->base + addr, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	return val & 0xffff;
> 
> Ditto.
> 
> > +}
> 
> ...
> 
> > +static int sja1110_base_t1_mdio_write_c22(struct mii_bus *bus, int phy, int reg,
> > +					  u16 val)
> > +{
> > +	struct sja1110_base_t1_private *priv = bus->priv;
> > +	struct regmap *regmap = priv->regmap;
> > +	unsigned int addr;
> > +
> > +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
> > +	return regmap_write(regmap, priv->base + addr, val & 0xffff);
> 
> val is already u16.

Ok.

> > +}
> 
> ...
> 
> > +static int sja1110_base_t1_mdio_write_c45(struct mii_bus *bus, int phy,
> > +					  int mmd, int reg, u16 val)
> > +{
> > +	struct sja1110_base_t1_private *priv = bus->priv;
> > +	struct regmap *regmap = priv->regmap;
> > +	unsigned int addr;
> > +	int err;
> > +
> > +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_ADDR, mmd);
> > +	err = regmap_write(regmap, priv->base + addr, reg);
> > +	if (err)
> > +		return err;
> > +
> > +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_DATA, mmd);
> > +	return regmap_write(regmap, priv->base + addr, val & 0xffff);
> 
> Ditto.
> 
> > +}
> 
> ...
> 
> > +static int sja1110_base_t1_mdio_probe(struct platform_device *pdev)
> > +{
> > +	struct sja1110_base_t1_private *priv;
> > +	struct device *dev = &pdev->dev;
> > +	struct regmap *regmap;
> > +	struct resource *res;
> > +	struct mii_bus *bus;
> > +	int err;
> 
> > +	if (!dev->of_node || !dev->parent)
> 
> Can we avoid dereferencing? And perhaps dev_fwnode(dev)?

Avoid dereferencing what?

> > +		return -ENODEV;
> > +
> > +	regmap = dev_get_regmap(dev->parent, NULL);
> > +	if (!regmap)
> > +		return -ENODEV;
> > +
> > +	bus = mdiobus_alloc_size(sizeof(*priv));
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	bus->name = "SJA1110 100base-T1 MDIO bus";
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> > +	bus->read = sja1110_base_t1_mdio_read_c22;
> > +	bus->write = sja1110_base_t1_mdio_write_c22;
> > +	bus->read_c45 = sja1110_base_t1_mdio_read_c45;
> > +	bus->write_c45 = sja1110_base_t1_mdio_write_c45;
> > +	bus->parent = dev;
> > +	priv = bus->priv;
> > +	priv->regmap = regmap;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> > +	if (res)
> > +		priv->base = res->start;
> > +
> > +	err = of_mdiobus_register(bus, dev->of_node);

Why would I use dev_fwnode() if I need to pass it as OF to
of_mdiobus_register() here?

> > +	if (err)
> > +		goto err_free_bus;
> > +
> > +	priv->bus = bus;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +
> > +err_free_bus:
> > +	mdiobus_free(bus);
> > +
> > +	return err;
> > +}
> 
> ...
> 
> > +static const struct of_device_id sja1110_base_t1_mdio_match[] = {
> > +	{ .compatible = "nxp,sja1110-base-t1-mdio", },
> 
> Inner comma is redundant.

Ok.

> > +	{},
> 
> Terminator is terminator, trailing comma is confusing here.

Ok.

> > +};
> 
> ...
> 
> > +static struct platform_driver sja1110_base_t1_mdio_driver = {
> > +	.probe = sja1110_base_t1_mdio_probe,
> > +	.remove = sja1110_base_t1_mdio_remove,
> > +	.driver = {
> > +		.name = "sja1110-base-t1-mdio",
> > +		.of_match_table = sja1110_base_t1_mdio_match,
> > +	},
> > +};
> 
> > +
> 
> Redundant blank line.

Ok.

> > +module_platform_driver(sja1110_base_t1_mdio_driver);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

