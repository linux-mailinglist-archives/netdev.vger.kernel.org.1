Return-Path: <netdev+bounces-252370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EN6D84rcmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:53:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FBE67925
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB8207A63F7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E10B30F53E;
	Thu, 22 Jan 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JMAbHgKX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92B3033F9;
	Thu, 22 Jan 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089374; cv=fail; b=hMHhvGvkzoKwmanOG0mMdq96j1H0bllC+nzsPoVcrbM4v75ZdvgFiNmygM3tEoY9hCRls6F4NRguiiA87DBDliosKpoddxob63604FxwRbmqool4RDcEbdWHCRljNIKt1Lto0AMDEjhzs8b2rLzayOGD3aK/llWw/ZxgZLH9x4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089374; c=relaxed/simple;
	bh=R924J0EA/1jF5yfBYJdeNE1IBO/6HwSf2bN+Bx8AIAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3rCJlbYPOQrghX5f/9rJCBiYbZWfBT7YcHJCe+jEZfvph5L66Cmovf5F9p2+GeH9oAjSC0Tx9bvCiObyKTt9ZblyMGrpGYExm3Vt2L3FtGikLjqbjnlLSso7Y9X3N5y6wZfIL45wvpoS26Cfvhfbzf9aGer24n5LM1456IJQzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JMAbHgKX; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umlrch6K67mXsUPWNGyCH6Q5zNHBBKRliltZu8VGKyQBkELVKTVNv27uH3P4jDKiXl/MxkXG1APkxJfj6JjdpZ/I5FBBLriPy3epeebXsQdgiNVe68mUXKXhA1ZVV+w2ComYYoV4uREOXZDvNHtkBmrGKOOMk70pCt/E/9DIh5IvOQ2VknU+MycX5RSjZ0aDzqkmbXyoCpU41zExmEDHDuioS9jxYlcuBCEWOzrUSCaHqmIrNfQt1tymOL8T5WkE8gnI37RG29QoQEHGv6k8Wkgs5RLnLrmwRX7SpwZ2WBgNeP5dmeMWl1dYT2MFbQ1Lr8BAP7h7NahwfJQaLJJ/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzGU3Rcv0iQE9jwoQrGtPDWrt8bvvBKfDZjRa8nM6PA=;
 b=ROI5ztEcnfUuZDtaQs+6N8Z2SOV2+8haX2WTwqUk0dpMCzn9CGKp1Z+gzpIEL0+nux/xSWo+HE5ydjIXpQAh9GUZ/aOHRyTYATbRDurJvf0EqfTePKsBLi/vmGQC4pkadZZ58tTx9Kku6iz/ZOjTmURpwBVqjx4PddshrabIWzRAFYswpf3HFrg9GamwFSbK09aEwTmgTknDTFvM9vJwleBMLuYmdiM/IL64gZtitEc42khq/XeHqYKhH48duSIvFpULI5O1Oza1olI4LV8oGdm05ZJHCbPEAPYglVH6nQDWd6isYJDmFXUOOU4BqzmNadpGPWhcHWFnRy4Slhu31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzGU3Rcv0iQE9jwoQrGtPDWrt8bvvBKfDZjRa8nM6PA=;
 b=JMAbHgKXlejGTMwG5GZZcVxrknP2gkz9Qi/9X/FskXQpvuP68nWHk1e/QA8oNMJfHKH4+KlHhNmoqRDKDMjM2bJuJPzmErw5orWlhj5/Yfskb4K4mJY7/w5IWGf9GZtvgDQJBKbErYWt4R4IkCcteE07jOt0NB8eef5oeNQ4F5d7I1ripLjhwvjbmOogIIDifCXcLCpJdQRFEgqLkeMTRHBmlYK5IgO7S5y3TjtcJyflv7JjCmcLA3JmxoUza0zeaVeGkGdDMTPpcZdlmpWNAiPP9k7BnLbQ+ivEfVPlROk4QKP+J5B8MT40NXXoCG8CqHCfL67NaCZ864+QwxQLBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10080.eurprd04.prod.outlook.com (2603:10a6:150:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 13:42:48 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 13:42:48 +0000
Date: Thu, 22 Jan 2026 15:42:45 +0200
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
Subject: Re: [PATCH v2 net-next 04/15] net: dsa: sja1105: prepare regmap for
 passing to child devices
Message-ID: <20260122134245.i5rocwklpcauk3hw@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-5-vladimir.oltean@nxp.com>
 <aXIWttaIcR-yq0nx@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIWttaIcR-yq0nx@smile.fi.intel.com>
X-ClientProxiedBy: BE1P281CA0495.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10080:EE_
X-MS-Office365-Filtering-Correlation-Id: 735ea1c9-9475-47ab-9c9a-08de59bc2171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MeBFe3bBJ3tLosi5xRXaz8AoBpGH1IJ4d+h+2jHNST480GrHwSXyGvjfZ2Z6?=
 =?us-ascii?Q?Wlt3Uj1ATODIbW9orqk+w1hGv75qMvsLI9ZDIsMRNbFp4u5KhWnm4pSsblz8?=
 =?us-ascii?Q?5gidORS06iiuoYwZ1YajMOrsPHiiEDzs3JFDCeV6g037AWdu+oBBjIrUautY?=
 =?us-ascii?Q?w4niIjx+Yxf7RxB9oiHS7ADgjY1cejek2j7irg/73vUen7MT3T1g8ydamim0?=
 =?us-ascii?Q?ocSXUSptEeDzgfCSEVuozV54ubHlsjM8XFhOhZXd0qVMntOJkknfsG77JjSy?=
 =?us-ascii?Q?VtKmoeN1Z5qBqpjZRmvn+XTUos7cQqa8THkX5Acz0Pa3TuZdk7X5dCNbh9f2?=
 =?us-ascii?Q?jxEn0mP9OcW1o/shzJShSrXHVSrH/pEbRT2otLNSISiWK1a4KjgI2tYnne+z?=
 =?us-ascii?Q?P1C+shyYO7+5VtYJ3R+fBrIJl8zkytAGRVLjIbcMW2pJJI1M1LxTe7YoZEXH?=
 =?us-ascii?Q?rFwtM0aLd1Guxz36jswpuS0sjIT790EwreSd0hHMNndn1++6pKuXwaV9CTq3?=
 =?us-ascii?Q?M6fRkJBXY4Xh71REZCwItTdXuAwaFsHdHr8Z76HM2SP6LAU2hEt5zjuqpWg9?=
 =?us-ascii?Q?lAxUK7M+q1peVsxetHctRnFQjaG5cih1cPzd0PrM1iaXZJbLsUo6Uu5u2VIl?=
 =?us-ascii?Q?diAFOGS+GQ7yONDN0o7JrZ3EAwgxRiTtP7sg2TY15D2aereawGCTp0oIg95c?=
 =?us-ascii?Q?a50ePRwwvQ40rVBeZoYDQuieHTFDD6F+R6b8hhw+3JFU1EC8NzpyKqxbga93?=
 =?us-ascii?Q?DwxrjyJCQaXjPelbWwBE6eIhXbIGqeTyPfm6iDVasHhOA0X8zQK5H56rS0rg?=
 =?us-ascii?Q?dYMzoy5vsrq+V1kciJmvumiV3z/0LzTpGfJdvLdoXtd7VJCk+DGzO/8mdehV?=
 =?us-ascii?Q?1YCGOUHVdzamqDn2iF4BHnGWC+Tl15BXGSo0cSGKEJDewBHGHMFIaXt/GHW8?=
 =?us-ascii?Q?H7NteMXiikBdjkLZ7ejx0baLUa/UKfqABnPRrpBftciiTpxyxF4ExSjN4bLa?=
 =?us-ascii?Q?pX35gY3r2YEgF5ZPR/ZXDZxu7NtjNHhLzN/N36YR44cEjzht9eE/HZlPYX3O?=
 =?us-ascii?Q?oferWlCvEibA4Fi7HyQ4KjiwnTsQdx56VPAOIEHQTUbWI+a9eBDUSvhpR/3M?=
 =?us-ascii?Q?KaNcxiW14/v1mHmVE79CwDJ8eQCWELZVWYns5qPAts5nwKyF0EquiCqsfoaL?=
 =?us-ascii?Q?Kz6HPfqxXlNodQVMNTwO7vURQ5thFVXIiP11D1e5KGvWVNqa8AahTd7x2otl?=
 =?us-ascii?Q?XFm/TvGTB1XuyXCvhkfy4innb6LnufrBbfdEtreIvQ+nK8GRSYIAZpU95R5g?=
 =?us-ascii?Q?T9pRkNkkMgmQMV5NyyxKQgMKNCU+YHZrFqvFaPWtegYZ7GNo51I7c1s1EOZ2?=
 =?us-ascii?Q?JfvOlHWSDAa9Rc4QWcXBiHwRSRJe6W8LwAwL/OzIpYAkZtl80gbZkgrpW3r8?=
 =?us-ascii?Q?pEx6YFitXIuIbD7OJX+MW/rJL4ZJcnvToJVE30iJWkarUVwLU2TCRH5P9CgL?=
 =?us-ascii?Q?fwJZ2bcJTjdVvOC2M5jEeIHPvq82wpyEQ4XvfFBPJJOHdhtpCDRc1O+yv1+W?=
 =?us-ascii?Q?IqLBYpYNsxD79HS+jcU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EiOODSpUJsidfiOOOmqesUE5CMlXg1GsbpEcGTyyGhFVuvdjZZbmPOmuDvtX?=
 =?us-ascii?Q?Lyr26tqN1jSowkIDOq4yaH81zDeZ+96puJIAgllX87Z8H97ObIM2y9YhaydM?=
 =?us-ascii?Q?iVuZ339ycqMFZdP076RwlUcajT0HxMOZyDaFUTYL0tWg4AHf5aYYI76AYiBz?=
 =?us-ascii?Q?oR5SDJGOBb4bE0TJ/Gl3DJpGMR/MFKiCINkJZfWCuZvDSUoIYj9Zk7gFiWK0?=
 =?us-ascii?Q?QJYc5xIk8zDziau8F87PFjo6jfUBMqETuQSAJjZwrm7XZ0Jz7tYL2q1pXzUK?=
 =?us-ascii?Q?g7waoF7seV42WEqf+E6j6/IZiTCNsRBWrI3ot8F2YvshH1BhxVjg9QJtHgFF?=
 =?us-ascii?Q?BDV7FpAPD7+pKD+JOoV4eEdQRJjEe8fm1jgDEhjptO3WjKvBCzF7xOnlk5aF?=
 =?us-ascii?Q?1FTHyVDj/UdJE/0ipePPskSMWK3RnZSi8BIWhYs9xvuMf0NCF2GMfScCHhVb?=
 =?us-ascii?Q?UIKdIRkALQcixeVEYEAjicJPKH3PUjLD7dJVGtQKaQ0po2fZJH8HjrRMeMvN?=
 =?us-ascii?Q?i2HnAjgRrh4vevGE7RXqVyuJxOHYGKYYfa97v4vdtU6vmc+gT62+UqtLKBom?=
 =?us-ascii?Q?CqpWM1idS1TXnP1oCE5ZfqhdpDZELGjwmV6V2TIp0t+TmqBf/eAbZswpYmSB?=
 =?us-ascii?Q?NMYLze1gjfkiD9YP+zlkH5JN+8TkWD4E3/NfRTpfmDeCrv6UFfn1YXSH6ZRP?=
 =?us-ascii?Q?iVXQ4SOqT1PU7xdkAan0zzeEFGQmLzPgT9v+IQpKRqNQdyqd+VX07Xm+2HPe?=
 =?us-ascii?Q?JQlsdTgeRIK+2AiCqNGJFtsOhh3laREGhnwGUOMoBks1PS0/jVDm8miLAe5I?=
 =?us-ascii?Q?rBXABeIK5RR9LI9Dmq4BNYTQ29GPgtkzde3m+8CGeDpgc0vJ2QjD8qZFl1vz?=
 =?us-ascii?Q?jn0DuXd/BUWy5/saZ0QaIq0GBpWdBfQwXGTa5LrKnT78ybFb3gtlemXKCVrO?=
 =?us-ascii?Q?NYsubPlswW3hkE0CAQR6Qca9nSx5RBiPzeiOheCGLDd+m0glvLneD0hyLZuw?=
 =?us-ascii?Q?+WkOgCLOn1D6rLuHXiTeK8Dh63UwnOHqw6jzfx7Bm2USfXR7hp7sqSJOoH5S?=
 =?us-ascii?Q?goqTkftNKpXPgG1RSQZY+bbuUS+OkktapjCBazzH/5Rsb7MfEGVvyoC0v4X8?=
 =?us-ascii?Q?fe+hu1nGlU3XqIJFmtRmNUoI7vdvmcEioQwkdZO4093dJ129CpjlkblBEGN7?=
 =?us-ascii?Q?3c0+MswwXlHgxG5hS5/LCQVH5RaWXY8Hexwm3GDKD727jCUMLUvuBr08CkJD?=
 =?us-ascii?Q?vLIkYQO8/FxHk04YwUOHzcfa408799FcTPCROSHFm7U5STxMC/LPKfAT1KHj?=
 =?us-ascii?Q?0m0p0RBAw+rDKMs6rV6SEZ6A8+OuMU0g5p8+TsgTfbagjekvuIPgyKVtf1Zt?=
 =?us-ascii?Q?bcXEEZpOwCrfmcEmxAE+3qn4CG3ZSbYNvznxAySn4HJheyUObGAu8XtB2hec?=
 =?us-ascii?Q?KSVeOzZtFWERLe2PHM2GaUkcvBzUvMVPliDXcm0oUWfLeG+GYFx/ZcGrO3fr?=
 =?us-ascii?Q?pHYmj3qHvp0IxB/AudRfFHSSNCfjcvxflr7gcMDpivTKXHVEXrPQWZX8XLd3?=
 =?us-ascii?Q?7eBZw1yNIAk5fzb4qn4Wjsu5dXOtIKSTDRzvsgPyBIO87iwlW0I593vMofOz?=
 =?us-ascii?Q?WEha3nclGK6KXyH+7H0ptFjzG1lMJhdaC4BDkwK2ZY3vBJZoks/7kFydbefS?=
 =?us-ascii?Q?iIfzADIbmH5vUcb5RmSyoqrSQeik8mtUNFjV+PgqmTI+29kg8aNntHxUkdIj?=
 =?us-ascii?Q?NfxC506dyFIPnefdiCNw8wOVMocOMXFoctok7smZ8zdrZc2jbWmdzDF7HFxI?=
X-MS-Exchange-AntiSpam-MessageData-1: TfyeF8ijNhx0tp1q9Q6veD4AGluzI4nc0xM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735ea1c9-9475-47ab-9c9a-08de59bc2171
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:42:48.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StOAKVfNai4wCEUJc5drZ2H/fj1wh7LJYKSBhJVwNKs7TjhongTuRiPNokK5SyiU/EEhaOtxBbofD1c9+eu4Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252370-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linux.intel.com,trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D9FBE67925
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:23:18PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 12:56:43PM +0200, Vladimir Oltean wrote:
> > Prepare a single regmap covering the entire SPI address space of the
> > SJA1105 and SJA1110 switches which can be given to MDIO buses, XPCS,
> > irqchip drivers etc.
> > 
> > This regmap is address-zero-based (can access the entire switch address
> > space) and child devices are supposed to access their respective memory
> > region with the help of struct resource (IORESOURCE_REG, to be precise).
> > 
> > Nothing is currently done with the regmap, it is just allocated and
> > added to the device's devres list, so it doesn't need to be freed.
> 
> ...
> 
> > --- a/drivers/net/dsa/sja1105/sja1105.h
> > +++ b/drivers/net/dsa/sja1105/sja1105.h
> 
> >  #include <linux/dsa/8021q.h>
> >  #include <net/dsa.h>
> >  #include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +
> >  #include "sja1105_static_config.h"
> 
> It looks to me that somebody missed grouping above (not this change) and it's
> better to have it done:
> 
> #include <linux/dsa/8021q.h>
> #include <linux/mutex.h>
> #include <linux/regmap.h>
> 
> #include <net/dsa.h>
> 
> #include "sja1105_static_config.h"

That somebody would be me, but I don't consider this a relevant change
for this patch set.

> ...
> 
> > +	rc = devm_sja1105_create_regmap(priv);
> > +	if (rc < 0) {
> > +		dev_err(dev, "Failed to create regmap: %pe\n", ERR_PTR(rc));
> > +		return rc;
> > +	}
> 
> Hmm... Perhaps return dev_err_probe(...); ?

I never understood the point of dev_err_probe() when you know the return
code can never be -EPROBE_DEFER.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

