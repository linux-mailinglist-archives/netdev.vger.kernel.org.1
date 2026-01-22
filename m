Return-Path: <netdev+bounces-252367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHzfNhgscmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:54:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD6867959
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E8AC92C701
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0430F949;
	Thu, 22 Jan 2026 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aRb1T3SV"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011000.outbound.protection.outlook.com [40.107.130.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0513148C3;
	Thu, 22 Jan 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088693; cv=fail; b=W/3inROLNlrmLmd1GUXM5AYmr4RtPkmBo62bgY2yInP0TOIH7PhNg/cD9/PuLbB7ti3O5paOntClnfdHK2ywkG88aQ350mg6GKvC7X8fK6jijKt9xf28VDTJOTz7W83U6tTC0J2B76llLEowsOJNyFIaln8JiK8rkgMPAnIvrbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088693; c=relaxed/simple;
	bh=Ca1XbwuuGcl4L8X7dQsqFx1W2FtuIlYXAnfdfIg3M0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rdtpH53oTOnwlpoz05N4H9H3+4VZJgkUax/I9RR9tnClXCfuf1BMZWSybs+F0AvIYy4x70jvxqep90XLHUrM+hSI2/wBAGVZZbzJX1CrLGA3chQQ9nVf6U63iOY/o+fzDmA7G11YuUIHlaOMXzcyhTeXyCy0QDJK7QbKz9qjHA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aRb1T3SV; arc=fail smtp.client-ip=40.107.130.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfyKeZM0dVyOAmNmmCXDUVooj25PRRD4koKF5WvzCMkSDWtxqnkdcfqCIswSee4H58hkPartH55KN9zzFuGtHVF5sJl/SHPayAjIq3Og7axeXJBrboMIfWLc45XEAi1RcA1R9asNayxhGe9j6dCMo7MuXySTZ1nXz7Kuze9vWwEInv4yrBnTlfXTrkRfAEMat7g4ESRBPkY+pog/512OqglkthYQp6hCT4oz2K9Q6okHTeeo2/t0B295iRsgg6Z00T5b/qg1Ko3xsOdK5nDsiy0Omuf50LfpPxy/2OxT0fKf9GX1d6Tzr17kQ9WJpJOyHPZc5N4d9MGXZQDnGQmKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpjzwiDI8Z4D8jntqRmpJ1KPDJJMygGWMRntQGcrI0U=;
 b=UK1yiZv0XwghCYsm1Vybj4Sn8CpNeKdXacavc7Yprc0gUZT8GQFUMfuogeYd614GcXmchV4qMDXZHQ99QgMZJFiQvSwX5+Qg9fcIUHN91rU704q+XTdFn9dCMQUoxiagj9hsE7MPWN9IfrSa6PXeiauD6oen4boCl975AQNH97My76hYI2yB7W7aAv2t9zOv207QjQ+3dhruJmy8ZnMjjZvBdNdCO3la56hIkbGwLHSHONDTFSyeZoVeCQCX1kk9hwCzGu+MR2E2wax8kPyJeXQKEayag5cc9hh1y1yXIStDdRLGAXsPZn5HYcEx7dS/Ekvg+ZUOVsdAKZpgH4GVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpjzwiDI8Z4D8jntqRmpJ1KPDJJMygGWMRntQGcrI0U=;
 b=aRb1T3SVw0Qh9Z2YjHf7jr7wX4K5+zisS2Sg3daNRS9pK+9JoBs1Hb659f4sLFzTrZG3Vu8lIAK1mPHNVdmEwTFj/vaf74YHpdlUpv8t/RVaLcdt6eLGiaMQfzi4XipEwURyxVmEKjJc2uN55Xbuzd4zOULXl3TMB3CSZF8VBb87aMcvFVOURqVBAKBjKUHgYwM6bxWIMCuCKfqPRxCTBx3YnOAnrn8A/uJNhu3oFtnHb2/pya5tmNrxcTtNzMZcUvOmqZNTzFgSwvDFKuq2wHeL7q59T1Fd9HMjMAfBk6MnbN8E7Ulrsxs2McDwk5PnwhmyiLQpq2q8CBgTmzcpRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7866.eurprd04.prod.outlook.com (2603:10a6:10:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 13:31:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 13:31:27 +0000
Date: Thu, 22 Jan 2026 15:31:23 +0200
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
Subject: Re: [PATCH v2 net-next 03/15] net: mdio: add generic driver for NXP
 SJA1110 100BASE-TX embedded PHYs
Message-ID: <20260122133123.w3jr7gdga4fhlj5z@skbuf>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-4-vladimir.oltean@nxp.com>
 <aXIWBpIvp7KZYZCn@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIWBpIvp7KZYZCn@smile.fi.intel.com>
X-ClientProxiedBy: VI1PR10CA0107.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::36) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: ed256242-dcb4-41c0-2ebd-08de59ba8b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IGnscPuA9cFr0/JXVBDJgWFcCHYgXu1r4pS4Oyosjd3Isrmo2yon5VQ+kO1/?=
 =?us-ascii?Q?z2DL9RpVlwEBxZ6AtUEu1xhclAsWKcpPQQ34UhLHnwQd4JGueiI/3QrBE3hX?=
 =?us-ascii?Q?XxoxeW9GR1ASbwnJx/JhXjd222crHQlTPClT3LD7qAHSugaFlRqBb9/Z8rST?=
 =?us-ascii?Q?hcLeJiOtwJVKkR4tH2b2biL/NdpDFQvPPE9pLtCz5tYuw9se4SYtMWgPK1db?=
 =?us-ascii?Q?WPkWTSrfI9o2y62CjGUJJdfcTdZDyBq/xyFyCDf5wREL5tYcVom7U2PeUMnW?=
 =?us-ascii?Q?CfCLJ/sxyKTsIetfoUIFjRGT3KNKHPIpepQC3iFaNCDHV3re1GSgvPSc8hsN?=
 =?us-ascii?Q?2PziglUqM2IPdi0llSm56GaVJGiM0r+cFVebGPuq1qA8xGgRQsZlghNaicJd?=
 =?us-ascii?Q?hJ9HV4LWQ9DDnRlxdJYB9iofLXwglt89W3sw8QB49F/wTXH9e4imZp/vypej?=
 =?us-ascii?Q?HRVL15cwpuRz6Lgzd9gbeb/N97Y3L1h354iUVNKi2CM3H5Fume7nGcvNDdbT?=
 =?us-ascii?Q?tucdAb3Vq28aB5JL7o8RZWPzW59ugaQQ0NU0J0dvjhyUmOYpaADhVlGxva04?=
 =?us-ascii?Q?vCycBMshdC7Nz+vr89jsJ+4+Z9ZbVdLuiq0Z6dbuCY2VZwClZNGd9RImVFdn?=
 =?us-ascii?Q?qdcIp1veC09CTbXJHzxIaDSjiMILobFBW0nYB4bExkRjHH1xkWdnqEpUWKL8?=
 =?us-ascii?Q?5euFHI08jwxxN/TsPcUa8p/2sHtSLPsvR1FPKNk6sHWB6xxbjBqBzBJbWSHB?=
 =?us-ascii?Q?kGQc6BsdU4acxASt20HYsSLYrh/YL4hqGsEGG6xCMXAefEBS6uWZkfQ0Wwy0?=
 =?us-ascii?Q?9U8Ag7CN699GqLHr4Jc2aORpen0JKu6mSRNg6hhYF/+xajJxMmRTQVk01KjL?=
 =?us-ascii?Q?iRT6nNFnY8A0Md44NfE518DHQO0KAQkj6c3yYnQAzPA/tfjis3ltk5rRJRig?=
 =?us-ascii?Q?tf66YGRAKbGUuwrNWwQFIQ+Tcf3mvfVcCGrOsJlGmPY4zOl3/5P+Jc8YPs7M?=
 =?us-ascii?Q?kv7RqD6gFNLiZJ17a5ScL4P/KPJxx8Pz07nJ4k605bPaBzkot1yg/+qXVl7s?=
 =?us-ascii?Q?ZwpMLF4FFhXcQUknxDb2t+gHcl6pq9So6u1wPDdtjy8b2lQ+0l4S/uVUY1iL?=
 =?us-ascii?Q?LeDwVinZzdXganFLdneyhZPQT4KrW66eHofzwGQsOWr6Gz0Ef8r6D6kzHGLk?=
 =?us-ascii?Q?c7ZX8HT18/I0I9tz1+5LF3uc0u6/3CblPGKPVpobUDLs2PkTMEHjyUWfePM+?=
 =?us-ascii?Q?ENispONpCRRn9S3UUSjDLvEX4b8viFOlHCJv5E+xKV1Q7XZUr9vOhl8k9wPX?=
 =?us-ascii?Q?ESDGOHURs5bbpoXWzEJVv28b9yv6oyqHS5au1wGpQ49VzFslUeo3e+ydxpOo?=
 =?us-ascii?Q?lkz5MRJWLzrqzXN5Rg/A7OpxjF36EjOAzHIkWPpPBApSr+PhJTtlz5MDyPs/?=
 =?us-ascii?Q?zPNrYhQOmAkRp8N4eXQEHvGQ5WUm+/+oEbQokir0En0DGe1LExpns0qgG/G+?=
 =?us-ascii?Q?WzOceKmH3/AYcRueIK8zoLAttVA2MFQka96ERHY8bRfwnLv0eWLNJ/njmh5O?=
 =?us-ascii?Q?5g5X7bmbBV0HfeUybuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OrWdfu7IQaxSYS/FyczJTbVCn8uJIw5s8MPeSyOcqX8wAduW7KLebfT10aiZ?=
 =?us-ascii?Q?iyaefnYp7+uk/kDd4rAKpzdRa3JlkeJqXloA1HH1aRwkeI7UoPokUk/r26Tf?=
 =?us-ascii?Q?fBAzNVePjkonchfnnPiYVIB1b7FhVX+HNmaCTl/NlqByAd5uDgazBZcUb0sm?=
 =?us-ascii?Q?udfU/e/yQE1emOyvsKnIENchA5r6oYdvHy4U98P1dxZMUEQ8U2iiKMTvagbT?=
 =?us-ascii?Q?hSSGYNbCCmnjm9viYdj2vMkfiKS6ANKHz7HWd7ZMimzaROqZ+6gL7fvd1hD3?=
 =?us-ascii?Q?XheWqQ2Tls/G1NmACmMLq3uyOPXt+JbhqzMK0v77oR5WsGQ6dVCS2h6TBrU/?=
 =?us-ascii?Q?gZmK5/3yGF8a4CFqb8t+aIfhgDcHRM0vjtEWM1wCi41q19LN5YgdF8HS9dHn?=
 =?us-ascii?Q?V4UbiOuY/dLbk9oWdRp63JBVpITO/qZuDGTJGgzoGSB8c8v7+Ukyk6oEWHlh?=
 =?us-ascii?Q?zxkyORKnh7YS2mD0sBQ3eyOl5l+5Lj/UHInQZ/WDKQA8wNRgVCE8U50tZ5p8?=
 =?us-ascii?Q?j2YZenirOQO7q2QJPiyL8STT7FQinba70Oe18bdEyqUPa4uapEaNG2Qml/mi?=
 =?us-ascii?Q?XpO2xVV+au862vN3s+iPh9KKxjR1X4LDkN4YLnMGTzcQv3JsRCyVfGD7PNVE?=
 =?us-ascii?Q?V3+RaQJ2/VGsworVn5Zoq3M/MDVUIkGBpAgj9bWdwl6aH3kMBf4Fg0BWzr+0?=
 =?us-ascii?Q?/B+aWMCfwCdcJrRU4bRhmJnfJG4SvbjQMRjVuv66fnE1FEntkJwgyvWpIoD5?=
 =?us-ascii?Q?8PaS+sG7hAnqgIu+4udwtO3pffT5NvXjmQghORQSPaI+MMAF+dfnG+Iency6?=
 =?us-ascii?Q?j9aUE72Sv8cpLnsmg4TqkUti5T2X0IPxycjuO/VEh4gtQPghwLtBXQZLt8tq?=
 =?us-ascii?Q?q8x2unRO5KdK6lxZj3h/61pdlEwcyNa4LpH3UVTZOzj8TFlKj9i3oFCsCA0F?=
 =?us-ascii?Q?MW70c4dMCMkyb2PEp9rQ/MjKoXHXsWagnWKB75BAr+kf9BKpedFenubiTDKj?=
 =?us-ascii?Q?IkvRrFa17AyciLk58YgvKZC+fMUlozMcew9U5/uFngA+0DQC5TmVUgr8V6aB?=
 =?us-ascii?Q?CJSVGuOGincXlu3qzo3J7cyZDnNAi2FCKG5PLLIrUYmN+c0D3dN9FK6VcFHr?=
 =?us-ascii?Q?Q/wW4e5Mgk55+3XbXX7tjqS5mdXBAG7e+/fUinzG1eti4psR+n/fVIYc3yYB?=
 =?us-ascii?Q?qYZeRgSmspQEhGEif+XMA98T04XMGyqpbnY/tFbA3jrcQnjzk8hTnGOonVs0?=
 =?us-ascii?Q?ryjtvddNTTq47BYZ1YQaDv8S0wvXfmaBoud61REzt48HtTiydqA7S9Vy84ZZ?=
 =?us-ascii?Q?6YE/zxON7Vag29Cvpt433LsDXHjKmJ3n/CA/Qsxe3OGKciDEdupw225l2L94?=
 =?us-ascii?Q?YBQ10B0qz7VkXSku1usF94/dL+Yt2PRhxfwDYDyWgokd0QFUcmRCU5ZwnXTW?=
 =?us-ascii?Q?pSxnIDh9hq14KqMoXFPRZBs/KoqSz8YDqFRBpBal+OIuSAOa/g+k5qX+NUWJ?=
 =?us-ascii?Q?XuDf0QVfxkeoDUKXzmXNVxGT4e3shA8lrVJYA7P0DL0kXCIYjgJ+B+cr8l2O?=
 =?us-ascii?Q?YnUf83u5p+h5k5sHsVbPt8da7DrZ7V+aMPcLI87skfyEoLmnEYT8dq0Hi9HB?=
 =?us-ascii?Q?v06tgFHJN9L40uM3ht532lfzSh7lGB2s/rcMUbm0jFVj4OWnyH4Dg5KYwDtc?=
 =?us-ascii?Q?Ezi+3Q9Y52ouMjW5s1pGJ2n+M2EbuThE+/0i6ee6KAzHgWs6+AsALHf9QmWs?=
 =?us-ascii?Q?2B85H8cvwR7t7SnVFIE1ihrG+kzxcQhz7GbeF1Pd/wMvjAZSCwSomtfZJ2Qw?=
X-MS-Exchange-AntiSpam-MessageData-1: fUf0Ug2Bmb2C6zSVuxwK1FpXauGMT8tY4TY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed256242-dcb4-41c0-2ebd-08de59ba8b74
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:31:27.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaB9l4SF1SAmMzy/rOtscKb3QSGRCsKUj0E4JoFIHGsUcylZHD1HBJARG2fm1aaVnBUSHbkr/WLJcv0W13CiMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7866
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
	TAGGED_FROM(0.00)[bounces-252367-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4BD6867959
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:20:22PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 12:56:42PM +0200, Vladimir Oltean wrote:
> > This is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
> > Same kind of differences between this driver and the embedded DSA one
> > apply: regmap is being used for register access, and addresses are
> > multiplied by 4 with regmap.
> > 
> > In fact this is so generic that there is nothing NXP SJA1110 specific
> > about it at all, and just instantiates mdio-regmap. I decided to name it
> > mdio-regmap-simple.c in the style of drivers/mfd/simple-mfd-i2c.c which
> > has support for various vendor compatible strings.
> 
> ...
> 
> > +#include <linux/module.h>
> > +#include <linux/of_mdio.h>
> > +#include <linux/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mdio/mdio-regmap.h>
> 
> ...
> 
> > +static const struct mdio_regmap_simple_data nxp_sja1110_base_tx = {
> > +	.valid_addr = 0,
> > +	.autoscan = false,
> > +};
> 
> Actually the  { } is enough to initialise that. But if you want to be super
> explicit... :-)
> ...

Yes, I guess I do.

> > +static int mdio_regmap_simple_probe(struct platform_device *pdev)
> > +{
> > +	const struct mdio_regmap_simple_data *data;
> > +	struct mdio_regmap_config config = {};
> > +	struct device *dev = &pdev->dev;
> > +	struct regmap *regmap;
> > +	struct mii_bus *bus;
> > +
> > +	if (!dev->of_node || !dev->parent)
> 
> dev->of_node check is not needed, see below.

Oh.... this is a bug. dev->of_node should have been propagated to
devm_mdio_regmap_register() -> devm_mdiobus_register(), turning it into
devm_of_mdiobus_register().

It shows that my SJA1110 testing platform (Bluebox 3) doesn't have the
CBTX PHY routed to pinout, since I didn't catch this... I'll fix this
for v3.

> > +		return -ENODEV;
> > +
> > +	regmap = dev_get_regmap(dev->parent, NULL);
> > +	if (!regmap)
> > +		return -ENODEV;
> > +
> > +	data = device_get_match_data(dev);
> > +
> > +	config.regmap = regmap;
> > +	config.parent = dev;
> > +	config.name = dev_name(dev);
> > +	/* The resource is optional, provided for finding the registers
> > +	 * within a device-wide non-MMIO regmap
> > +	 */
> > +	config.resource = platform_get_resource(pdev, IORESOURCE_REG, 0);
> 
> > +	if (data) {
> 
> We may always require data to be present. As you use a default one anyway.
> 
> > +		config.valid_addr = data->valid_addr;
> > +		config.autoscan = data->autoscan;
> > +	}
> 
> And if it is not provided we will have a crash which is fine. It will just
> point that the code was not ever been run on real HW.

Hmm. This patch is super old, so I'm revisiting it with foreign eyes,
same as you.

I think the case with .valid_addr = 0 and .autoscan = false will
constitute the vast majority of instantiations of this driver.
I would like to avoid the proliferation of the same basic config with
100 different names (nxp_sja1110_base_tx, etc).

So for v3 I'm planning to:
- rename nxp_sja1110_base_tx to mdio_regmap_simple_default_data
- delete the "if (data)" conditional and directly assign from
  device_get_match_data() to the config structure

Thanks for taking a look.

> > +	return PTR_ERR_OR_ZERO(devm_mdio_regmap_register(dev, &config));
> > +}
> 
> ...
> 
> > +static struct platform_driver mdio_regmap_simple_driver = {
> > +	.probe = mdio_regmap_simple_probe,
> > +	.driver = {
> > +		.name = "mdio-regmap-simple",
> > +		.of_match_table = mdio_regmap_simple_match,
> > +	},
> > +};
> 
> > +
> 
> Unneeded blank line.

Ok.

> > +module_platform_driver(mdio_regmap_simple_driver);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

