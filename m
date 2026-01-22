Return-Path: <netdev+bounces-252546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L05KWqgcmnangAAu9opvQ
	(envelope-from <netdev+bounces-252546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:10:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 484386E0ED
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3C21301464D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64363D448B;
	Thu, 22 Jan 2026 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k1KNR4BN"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984E3D330C;
	Thu, 22 Jan 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119844; cv=fail; b=bz3ImXCnm5zwOn5knuxrnaorcJD/5dXFucw713S11XZLfibU5T+S4MLfRIt2XQ1HtN/lp/2l+tBB/5eLKHKErZ15q6pl4N8nkwxWFAkfMwUM1m3JLy8CRCrS7ynLgJ74IuMt3yXnPtr9Yg1eQESd+eQMf+5dFps8VzQV+YXuZhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119844; c=relaxed/simple;
	bh=Xa+ariMEaRWFMkKHo/WJGqv+XCq0J+ZusCYwuBArzQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c/4Ne5p/NZazQyWPjMEuPdRQ7M3HjoEICue32ymSaH1M+Ex8oNwwOJwHN9Cca6tYCZVqapYEVQJtvck4mFOBP+gn+ffZg5XpR06ptk6PEiXeNl5JjaIvaxUjXdf+BBJ3v8Ud/+ChTGPd+JEdWnzYXUa2qdL4JFYtB5Au/b36TuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k1KNR4BN; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zri02KmONunj/0OrAGQquRwHh9KPL/9sfhib8NiXIB8S7stxL8RyOE53jeuK36Y7wob552hlR55pEiurYIIQXktSRfkqRGnQjmLG2NPI3r9qPkFP3olQMYPR7dkiKHcg+iD0lH60jAl3wYSOXtXHArAAAbo888b2MK2vat4WSnWPaEBCOOev2aoIcYhHo+qSOpQZL9jlr3x/WN/FJZgcroNGh/pQuouEVsYp7Td5v5LewQP+1Xp/enCFlHFGnvj4pLcmQfYX5UQAsgWBbjLH89zbxV3VhVkgWTU6stkuWN6gedIdQ8HrryT5pecksSfHHz14eHhlcd5gR1wvGRoyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88WwjI15EMQkzr47jQz6VsPMBB6M4/v9dVUVLMAaIOk=;
 b=V+xMo+5Cp8Mu5W1UhJaX3neAJE5qZxP/Lspk6xbIPf1f3PKPq4kRth/zI5CU61eOpv76wZ69BF5pDL7BqRZ6QFB5zvXeAfhJsyie6YrnyTG6XMefjPxgpBS1X/TjYZtVDhFs4wIu+AJ/6pf/UlAcpgf75mvDypaYFofMo8TJyuuaXTZy1m21XK3F9MRuWjIfXfPfw+sHZIS6ykNyXKtITwz5SnBOgRP4zjTYJDCaENJ0dPVS7KqhWF/xsxEDPv90sU/k6HFROOxlu8gdbq22+GLy/s+k1Au7wpymW7uT5GUmzylHE/llhCzW8xefQeQ5zKzc6AsiH/if3p6LXB7Ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88WwjI15EMQkzr47jQz6VsPMBB6M4/v9dVUVLMAaIOk=;
 b=k1KNR4BN6/cxzcALP8W99YlCuRUGeZnx8Z3e6U0p694F91ujSPsgm3vHyol6kRE3G6Y3GafKDoHEJQXkY0vS2WKgMk8JYLEDw7sUVjU3ZYHlWTH2yjp1wxbGb6s8OW26YdJYjzJU1kG45kTU7/ot+gwUbPRxQJ5dZ7GJ/begF1vMuQH12VkzNUSsrs5sOHYcUNrYXVv0jSqZ/qTzSqJfKTwdUobiqdtvjrLTPzwVPud4HvdqlXWYFzrE6JRdMsfWUxjsX6+7ZsQC6ZFrTn8Jfvs454CuX0a6205n4eLXbwmKXuusGkhE3QPD8Q7B12aPF1j/YZMcYFTCfBryZetO8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 22 Jan
 2026 22:10:07 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 22:10:07 +0000
Date: Fri, 23 Jan 2026 00:10:03 +0200
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
Message-ID: <20260122221003.p2cbemzvi2mayety@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-3-vladimir.oltean@nxp.com>
 <aXIUJbEwnAvIkeKK@smile.fi.intel.com>
 <20260122124708.pxckp6vgi2rvagmm@skbuf>
 <aXI339TiHFaEAWXE@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXI339TiHFaEAWXE@smile.fi.intel.com>
X-ClientProxiedBy: VE1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:118::32) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d920d18-72f0-42a7-cc85-08de5a030007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFOpyFTwhtPlnunItLD39MlIu9wgGXtS0WS7y0GAR1Y+0vJ1t5i6txmRNvwm?=
 =?us-ascii?Q?QPDdMJOA15jRmSvhgBU9fFCqBsCSB9fMsMI1OutZQWe5pB472n4X2rlq2U7k?=
 =?us-ascii?Q?kmo5y+PJ/NJ1Xxg84+uzq1ZJwR2oywyFfYBFoLt+cYOWrZWWjlKWNJI4GKbO?=
 =?us-ascii?Q?9V9jAZ01/2WuEZKG0Yc8vmabhztFJLqJo+HW7wc3rrb0+VF+XEXdyZZNEwG7?=
 =?us-ascii?Q?VIdWQLc3cThCK047eJmO+byM1VVPcfdQB7eSM8ZlYKx67yXSWNJnEw5Yk45W?=
 =?us-ascii?Q?+63wvcHwF6RyhSBAyo+p+TuVrvtbDgCMGfOd2wu6xFhOoxmf/l/JLxBgbho5?=
 =?us-ascii?Q?MT/MWjeqLMsYbbg4ZATaBXu8NMue2ZFD34DH7zUHeJvJ2javdKiqdkJskO5m?=
 =?us-ascii?Q?Fmb6oaNRvB0kI2gU42GLgweoUF96xpjVo8WGyWzJN5XUAHLIXRQmQDFfIpaB?=
 =?us-ascii?Q?c7E8w+zQEQm1x8YHKGZQIEjhOTseYchSqoBVlO1nj6bohOA3y0B7EOvqLImL?=
 =?us-ascii?Q?bB7lac1ORsOxcWzCPxTesGbQHFpj8dB8h60uJhK1AWj6zVUXFFG9jg/EdjBY?=
 =?us-ascii?Q?EhMmpQGo0XeFXDUKbwYHbqVnYFQy5Nbe40bY6osEOVKODeoBK2s2ISN7wHAE?=
 =?us-ascii?Q?YQIm9Ma8wJjAZCQITOx4UI87VbOLgUpHgx9RfAL9BWgKtYfvm4Afk8KCLU6Q?=
 =?us-ascii?Q?EV54+d7XAtFtCTOVpziclTBQ31YMZKe4UGb7+mwhhN+a64W3UwxQEkPi0cVx?=
 =?us-ascii?Q?WBjV85q90441DMaxOxEZXihT6FFjkDBeSFO4CObGYJkFw4dnRfhNi8C5saqJ?=
 =?us-ascii?Q?4r+f4h2cTBpE4nZVfCFySJr6VcT2Ey6Nn4cnldvysa7r48/FzTJYoB/IBtkO?=
 =?us-ascii?Q?70qUN4ARqiTsO5ChyaiiqtN5qdPZ6ADEiiAlCtE61/eWC29+EWKqc60OIeiZ?=
 =?us-ascii?Q?WQAxc1rJIGMp9qgwyxlGlQEjR3RbONIsEMQvAkbIcfgtXFNynVUdO6iqym/V?=
 =?us-ascii?Q?HcJUT+gEN3ixSiPm1yttKWAQi4EkvHxLv3w5K2m2+rZWDNkNF2PIgdeLlt2l?=
 =?us-ascii?Q?OyV3bopYi6xwEJjbWvMnRXmkx8fWARqd2kP7t77+G9veasA0ud6/lXnuYWgj?=
 =?us-ascii?Q?mKM6OpZQpE84kYLIqIDQncYwc2Moxgv26RrjPOeRAhOVG9pX68dXUbGRoxag?=
 =?us-ascii?Q?yKZF0vzZ7Jjo/xGRBoLrL/A5kHz1aLCtxdAZrTobPPFd6tLMbSRkOKVtR8/W?=
 =?us-ascii?Q?Sn3FIbY1o/UzsP8l1S/dcMe9lqmRtphb0GVTNA0d4LvN82EBSx27fPCaBtsb?=
 =?us-ascii?Q?ib51f4EpF9t0y6G/8kO1f6PKCxiWyZBoRCaxdyHvjB7Ezn3382eaQb0Bf2AY?=
 =?us-ascii?Q?OdC+wAvOqf0wvAdZmlnX2EyPc3cX0/oSIWpx/6A1vbiaMjb0+ZY39tUcf5Ra?=
 =?us-ascii?Q?KiMQUPovRuOzwjTZMxEB0IwJukuOv1X6+9kYSRuR9BMZgWDp1LTZETk49rEE?=
 =?us-ascii?Q?N4fHI1j3Xz0/EgnXXN3x1SpSuHIkHATZxSYzHiIi/RQbCXM45qmRJtzsg1x0?=
 =?us-ascii?Q?XH8264JZ3CGY4+1Of70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PCf/k6o+91u8wG006KqUXwHKJ9VRffVKR6XcqxRGP98BWRaJrxHJdIvzr6ER?=
 =?us-ascii?Q?b5dSUn/IMWYhh/GrNrXtunbCAFh/PlSbVBmdDbYmifiWFXT5OYhcYf4BNFCu?=
 =?us-ascii?Q?hAX2PpGnjEYcAlQBeeUMvZUFrmVzQa/D7sL8JVZPkBZDQ2w68Gzpt0aHrtlQ?=
 =?us-ascii?Q?yy1nEPRj62z68UXu4jTRc6ssQuAJBmwWCkQbtZalQMKGw+RH45cjx/7+DpcC?=
 =?us-ascii?Q?HdQM0a8mEoVM+7uJNeyOSSI5UAsfPa/AQGCdQwjdS3ZhsK7q6/gkYFnsheKS?=
 =?us-ascii?Q?XqJJMqnrYyntAHMQjhHXCTqX4bpEXCrnLzB7DGOB02M4RLxSrnFHBiRyujG3?=
 =?us-ascii?Q?5lXjb/b1nsoTy4DlBGIxEpVHu7clN1MEvknPVRlXXAAIaN+jS5d/adIX8gT/?=
 =?us-ascii?Q?j/cxh89ZZldYxOnnjFJM2nIuPovSuiWZwevHAwyT0VPzvpv+hz4deqg9iaNP?=
 =?us-ascii?Q?e4wUYRt/eWjD+ZAcHol4cKnfiBb6IoRjurTTkjT6QNs//CceeBvs+4XBXrsG?=
 =?us-ascii?Q?OuFSZIzfl4yfu+41CRwGy7J4IG5FwMffxWBhA94hMESljoBIrEoBgpbSCf9m?=
 =?us-ascii?Q?5AXYSXy4vDMa2Zvmjur0dzUInQHDGgH8m7ZX10MPU4Slj8QOjonxapubNDY4?=
 =?us-ascii?Q?1YkHLzBo020oyMZ39nlRf98280TnHKlNbbSMQtyM4c2/5YwBJz10iWO1p0Fr?=
 =?us-ascii?Q?gpeW3wfHyRQX7veKP1aQ+1fQb0V4C8qMXFDfHwSI0T1EhaLAylF9PkE3/M5e?=
 =?us-ascii?Q?rZJ31L3BNPy1NwNIP/xrqegW4ivudOXC+8OClKoTueYhW1HMXJd6Wtk0I6v0?=
 =?us-ascii?Q?uKUsOknAlCRYzWuvOj1ol76arDE4X5DQMDUPCFfjhs6981aX+UPASuDFbQm1?=
 =?us-ascii?Q?c3Ogcp+aiP1O3NDQzUpxU5YES8sHE1GhMWJsWWyiYUlaZsHfQR9UNQGI/lEs?=
 =?us-ascii?Q?hglkmLFC0LPm9XK/rgtcyS3HAnAbjY/uo0yK70D64lwSKtDt3416Imk33vWs?=
 =?us-ascii?Q?IAXMPKg0XZq3fW3RVj0rP/bgKwxsCKSLcD3KaAUV8chSgbNBBJ/24KEMWLYV?=
 =?us-ascii?Q?xMwm6ovrtnoNPOu1zL32V5g4aiQD9Qswlk8Y8/DquiG6uRvGpNTF5akQWRzU?=
 =?us-ascii?Q?2NNhs5kA4ouvIiW+4sS55YZxH3VBTPtMMi+5qj6M15MKLRjQBm8C0Mnnh/U0?=
 =?us-ascii?Q?Kbt128cpAywNJ7o5iomV6EwPAkCvZjXBDr4I7N7OW8kM/CzI+W6HvQjaecNJ?=
 =?us-ascii?Q?lVkcoSRh7ovZ8qhAl3NFwFid8QvKhYMI9vFudydTNqgoLtgA9swCfG2FQ73C?=
 =?us-ascii?Q?hz/8+l3L4YWBPIie8YPx5lFVJHPcDnTiB4K+WpxKPvzh7QCWzl+xELCGwiRb?=
 =?us-ascii?Q?M0iSzG/Oyk6eu2ktykl7tfUz49+HZcLEyZ1DSL5lzXof4ZRtPaogq4zOKn9+?=
 =?us-ascii?Q?6ATvEXfJGZW3Lz8Y1RmMy3IjhBFUJ5XADBim0dpX4GgmFfEbQNhBcZyMGvUJ?=
 =?us-ascii?Q?tiY5sF0Ww7x8E/tJ4WKEzVtmFq/IiI+6hdGsyqchDUPW71oj2RtfYT2d2FJ5?=
 =?us-ascii?Q?PvLpNyD0iKgwsstWYoAg2SJZoOpg9HqjiR+eNewefdn7i2MVrseKhfdX68Hl?=
 =?us-ascii?Q?rC0+QUVU1M1F7psbxO7xUbcxDfpcy8jHNo9+5tPyFDiXmjUuMYLn4+cCnH46?=
 =?us-ascii?Q?xQAzt6REorZ98iL4rdcOExXf61RK3GrQyZZ3aq342TNV0v7h4kjhf9mtMs9X?=
 =?us-ascii?Q?xidZ4w9PnbEpKLD2ztQ7fUVHdpwTv2vGoDzwXiWxlL1AJBZeNFK84FJSGols?=
X-MS-Exchange-AntiSpam-MessageData-1: xp6ffly/NZEGZqjAAECJ0YeNlL3W7D/qHBs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d920d18-72f0-42a7-cc85-08de5a030007
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 22:10:07.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuNvCXXXPTpLo1nKyrsYEZwGjkCM4zyqqvwZ+8agCqln1PIym4XG+blbIMwJSmaEkS89UpUtinOyUrZlAv0TBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252546-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linux.intel.com,trustnetic.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 484386E0ED
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:44:47PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 02:47:08PM +0200, Vladimir Oltean wrote:
> > On Thu, Jan 22, 2026 at 02:12:21PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jan 22, 2026 at 12:56:41PM +0200, Vladimir Oltean wrote:
> 
> ...
> 
> > > > +static int sja1110_base_t1_mdio_read_c22(struct mii_bus *bus, int phy, int reg)
> > > > +{
> > > > +	struct sja1110_base_t1_private *priv = bus->priv;
> > > > +	struct regmap *regmap = priv->regmap;
> > > > +	unsigned int addr, val;
> > > > +	int err;
> > > > +
> > > > +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
> > > 
> > > GENMASK() ? Or do you have already a defined mask for this?
> > 
> > Hmm, I can't find a definition for this. In the MDIO world it is
> > "well known" that clause 22 offers a 5-bit register address space.
> > So the 0x1f number doesn't seem too magical to me.
> > 
> > But I think my assumptions date since before the MDIO bus API was split
> > between separate clause 22 and clause 45 reads/writes. I don't know
> > whether masking reg & 0x1f is the best practice. I'm surprised that
> > __mdiobus_read() doesn't enforce a limit on "regnum", and I don't see
> > other MDIO bus drivers explicitly C22 registers >= 32. I really don't
> > know what is the best practice.
> 
> Me neither. At bare minimum to check / perform two things:
> - make sure this approach is consistent across the kernel
> - define the magic with meaningful name
> 
> Maybe (assuming second one is done) fix the rest in the future
> via some helper function?

I wasn't prepared to go down this rabbit hole, but it turns out that the
__mdiobus_read() and __mdiobus_write() functions do support regnum >= 32.

I don't have time to investigate why that is, plus the fact that the
majority of drivers don't reject such register addresses but truncate
them to 5 bits. In the next version I will:
- add a "#define MII_BUS_MAX_C22_REGNUM	0x1f" in include/linux/phy.h and
  use it to reject registers out of range in mdio-sja1110-cbt1.c.
- allow registers >= 32 in mdio-regmap.c and just disallow what exceeds
  the passed resource->end. Although standard MDIO framing has 5-bit
  register addresses, mdio-regmap.c represents a non-standard linear
  mapping of those registers inside an address space, with no such
  inherent limitation. Besides, as mentioned in commit f3b766d98131
  ("net: phy: add basic driver for NXP CBTX PHY"), the NXP CBTX PHY
  register map extends well beyond the standard 32 registers, and I was
  wondering how to expose the rest. Turns out there isn't any problem as
  long as the PHY and its MDIO controller driver are paired together.

> ...
> 
> > > > +static int sja1110_base_t1_mdio_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct sja1110_base_t1_private *priv;
> > > > +	struct device *dev = &pdev->dev;
> > > > +	struct regmap *regmap;
> > > > +	struct resource *res;
> > > > +	struct mii_bus *bus;
> > > > +	int err;
> > > 
> > > > +	if (!dev->of_node || !dev->parent)
> > > 
> > > Can we avoid dereferencing? And perhaps dev_fwnode(dev)?
> > 
> > Avoid dereferencing what?
> 
> of_node

Why? The driver is useless when bound to a device without an of_node.
of_mdiobus_register() will fall back gracefully to __mdiobus_register(),
and still technically get registered, but its child PHYs will be
inaccessible through phandles.

> > > > +		return -ENODEV;
> > > > +
> > > > +	regmap = dev_get_regmap(dev->parent, NULL);
> > > > +	if (!regmap)
> > > > +		return -ENODEV;
> > > > +
> > > > +	bus = mdiobus_alloc_size(sizeof(*priv));
> > > > +	if (!bus)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	bus->name = "SJA1110 100base-T1 MDIO bus";
> > > > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> > > > +	bus->read = sja1110_base_t1_mdio_read_c22;
> > > > +	bus->write = sja1110_base_t1_mdio_write_c22;
> > > > +	bus->read_c45 = sja1110_base_t1_mdio_read_c45;
> > > > +	bus->write_c45 = sja1110_base_t1_mdio_write_c45;
> > > > +	bus->parent = dev;
> > > > +	priv = bus->priv;
> > > > +	priv->regmap = regmap;
> > > > +
> > > > +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> > > > +	if (res)
> > > > +		priv->base = res->start;
> > > > +
> > > > +	err = of_mdiobus_register(bus, dev->of_node);
> > 
> > Why would I use dev_fwnode() if I need to pass it as OF to
> > of_mdiobus_register() here?
> 
> dev_of_node() then. Wondering if we can use fwnode_mdiobus_register_phy() here
> (I remember that OF/fwnode code in MDIO/PHY is not trivial, but I don't know
>  all the details).

fwnode_mdiobus_register_phy() shall be read as: "hey MDIO bus, please
register a PHY for this fwnode!"

of_mdiobus_register() shall be read as: "I have this mii_bus structure
and I want it registered as an active MDIO bus, associated with this OF
node".

So the two do not serve the same purpose; one is not the more generic
variant of the other.

There is no fwnode variant of of_mdiobus_register(). Perhaps this
snippet from drivers/net/ethernet/marvell/mvmdio.c can clarify:

	/* For the platforms not supporting DT/ACPI fall-back
	 * to mdiobus_register via of_mdiobus_register.
	 */
	if (is_acpi_node(pdev->dev.fwnode))
		ret = acpi_mdiobus_register(bus, pdev->dev.fwnode);
	else
		ret = of_mdiobus_register(bus, pdev->dev.of_node);

Out of the two API functions, I used OF because that's what I need
to support.

> > > > +	if (err)
> > > > +		goto err_free_bus;
> > > > +
> > > > +	priv->bus = bus;
> > > > +	platform_set_drvdata(pdev, priv);
> > > > +
> > > > +	return 0;
> > > > +
> > > > +err_free_bus:
> > > > +	mdiobus_free(bus);
> > > > +
> > > > +	return err;
> > > > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

