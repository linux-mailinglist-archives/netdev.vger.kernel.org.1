Return-Path: <netdev+bounces-211658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC403B1AFF6
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD38F17D95C
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099F23372C;
	Tue,  5 Aug 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="KAv3Y8eR";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="oMfrOJXS"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F41221555;
	Tue,  5 Aug 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380831; cv=fail; b=uqtgZnMO/C3vdJsx/DP/n+pRCW533MksVPeVNadl+dg3DpJ9eYrt2yNrjLZRIrlWqmjrHn84vvUbxf7u6Me99G+eKfrk1JK8mmpYUfLYqLBwwJihnj8JX11SytzBg93HDcXcNl/n6lbGMBPD2G/O7+0ERW3oj4MFLIVvuFYq/K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380831; c=relaxed/simple;
	bh=/2oOUwY6tVmj9TpUq+2+bncYvcy5rD8XBtPgQLn0FWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YXXzdjsePk0XXNPqSmbcWbo8mND/XSgyNEiT1kBS1dAYAsd0UPVZ+9RJkq+KamVO/G2zeZ1wfkb1SvGc7e2VZBkViULzS5zTfApvVDuAYNyF8DFlKUs1EmNi9RFP0h/SBTVWMs6DGrSELDYSFT4v3cwZcGhPntdqIeReVh7Iy6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=KAv3Y8eR; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=oMfrOJXS; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5754i8Q92795578;
	Tue, 5 Aug 2025 10:00:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=R9kNAyy+1K92zokx+ytBT7U0
	5kZuXarNjfTtMSc8Hvg=; b=KAv3Y8eRoRjyE1X24S5PyLIJ9PzIbfNbATaI535M
	wn9FdYO1/AtcB2wUFt727XgPQQ1y1nowgpmoHvRILTNjQIVag2sUf/UxyQDNl7RM
	t967kysP1VQKc23t8d9zrK4ypWOp+eyNXz7vGWXEryMJsmM+BYkWzwjoahUi2hvQ
	MmBTLyfQa61GmNLlRnQFVl6fsZpc8J+xhYrwORcBZAg7a/zJ2kNR6Smr6Sp0hOvf
	SNfUygBi2vgXoyUf6JLWDvRInau/KID+Z15dns7ymF7+Ay2N+5sdJ+9VwYKXZIHw
	PXHP5ffPGpZxJp439TdfgHo2+kAr+TVccAhTSmF0VZS/Zw==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48971a2m8u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 10:00:05 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynLiyIf9i3wOfdKH2oEn3ZmkQ9LS30gv7wDbh1qr+PyjFj5CP2rP9/3nMl53xMS4kMbz0GVimPSJLx0Y/YxeeFcFnEcBnFjjn0PpHDMbERmyx9h+5BVo/0AZSl7oYo3RRl1crDY4O2jK8Gyk19V2YxrsL1s+rbtgesD4dNGkXkU0NoRktgBzNanku9iJTPMmsep/RmSEbKSFR7gP2gefhG7jezbKHyo62xd2ZI5prFMF/zt6nRp4vl61k1JKVqUp3RUHEZXtp3sXQ4B2Dgisph0R1Ekw6kEvnToD/jrDkuhCCrlJ7BBhH7smCUMVFPPcjO2zdeSZCdcrSbJBh91q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9kNAyy+1K92zokx+ytBT7U05kZuXarNjfTtMSc8Hvg=;
 b=V9/nIVQzsJI/8SyXuPdcQzJ7PCeSlNSwfUJoQqBZDLWuGiO8jmlBHkkpnAJ1OIBtIwrHzf+wIzgFsBF7AEuDa0YMF41wGQ97QpdMgCwRRg/AEzDikM3I9fFIU3nqpeuQWUf6XVuIRkL1SkIIhm9X7qt7i8DZwmOBFrwKizkg3dyxU4ima5KeN1bfcWGATz/A18sUcJqhq0O4gje1hnbXqtIbJpBpZF+uzW0vDgyoRmoggFhIG3pfzOlLtJR3VwDcSxbirYkKLJyb1zpUnWrD7kRDBM4AJ+EJrvYcvLIjn59Sv/GxhLm0mDLCli5XKEoL0Nk2+5ghV1ahCW1GZegUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9kNAyy+1K92zokx+ytBT7U05kZuXarNjfTtMSc8Hvg=;
 b=oMfrOJXS5claBWOT7XdGCHK1quz5USgJXKszI4S1TWjDCMgq75jXqxQgE4EBzeaUGDeVztvVWH6nGlH5gZw0WlmmACYqfc0FsIEpWVppdld9zPxoHc+u5RZ43mHuQJW9KsjxPYfvgmkfCZ4VNhMx7yuF6U64yBchIBQDALvB6lM=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PAXP192MB1584.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:28c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.12; Tue, 5 Aug
 2025 08:00:03 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9009.011; Tue, 5 Aug 2025
 08:00:03 +0000
Date: Tue, 5 Aug 2025 09:59:57 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804160234.dp3mgvtigo3txxvc@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVZP280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::10) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PAXP192MB1584:EE_
X-MS-Office365-Filtering-Correlation-Id: bc960742-0f00-428a-f532-08ddd3f615c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?moBydv2eFe2GnPKk868Ut8fHV1ovsWWpiCTYfY9Y9lRrrMgTNAE21l5TzOem?=
 =?us-ascii?Q?3e1F43XfXGdA9kiUmb73OFgnGwiynJtalmKnfltcKp3kRGLVvWy+JHxJr8C/?=
 =?us-ascii?Q?ya0ZddtwPvBx4cuLpRrebfX/CsEBJdNicB+ML2vtmYq+pR0JwNdOlCe+mpWs?=
 =?us-ascii?Q?UgpA7WuYL6rHdjMEOoXIVpPD3SZyBJILd38I//V25NrrBU1s58D27OnHLcBv?=
 =?us-ascii?Q?NOQjm2DC/KEHxYfP+sYr+UySkt4BRwt2ssw3fbOGgreQBeF0M9DMUDY0FadA?=
 =?us-ascii?Q?rrncmnRKGIO/ePF33twfYMNQ1GLgFJkHLGf5PtysuzTwYwPiuS9O/wnqKBVg?=
 =?us-ascii?Q?YKJWITsOZj+jGAj8YThbh8Q42+wSYPCzO7/L5l+EGmLCBcxFspFmFBkwonGe?=
 =?us-ascii?Q?BqfTDWYm5uQpREE/bNztiFOpxJkVqROImGlNV0tGS7bDeDTXJoNnHlM7ex9f?=
 =?us-ascii?Q?tnoVIo1TEnu3t4m75s+x3L9vg0/3bAVbkbjGWcmT6B9KbldSWCqHTBOEMMEJ?=
 =?us-ascii?Q?9dxA58vy0j3x/gugRfnFr4wCZE0QQ9Dcbx37AiEyMWJnKP1p4Q8+uDQpjC8p?=
 =?us-ascii?Q?49D8KO+quoCk/eh8XslPSnGfQU1z96THtKB10Ns/mwCtKitPVm6AemZOd3g9?=
 =?us-ascii?Q?TmywJcT7UsE1FZPWowSxPFBm8RrU5RA5m76wSA8mNrWD0fTsZr+sVxAKJ6cS?=
 =?us-ascii?Q?ZuPFr3jdZ8kN0rMCNZ9694ARr+wBpjrAhzmC+otM8T508alVjwk5HdKOqzT+?=
 =?us-ascii?Q?Egz5u0Lzx/u9+9inaoffzVTB9XhdJsQoQU2YZPH0n2Cm2ut/NSOXCwW/tGxL?=
 =?us-ascii?Q?pJvIdDXq2LDWlw2syErKCIGoxnjgvsOatDxflZocu37jyEFljkjKKq6HfHpq?=
 =?us-ascii?Q?3a20eSdWNRapZMKVKFkchB18/4m1bJqwUwremOAnFtmHjAlle56Fysw8j5oZ?=
 =?us-ascii?Q?NpTJj8ttsDwk0VCqfco4Q7HRPJkkM46/5A/MWyBPcK0LIwugS67FGJaRutQJ?=
 =?us-ascii?Q?QfUs2OAfbKM5BFQd7aXxc2pkmh8mmW+U8HUR88Ho1S7pjEYKUfTqmy79nDhF?=
 =?us-ascii?Q?ig6OYm4WztH3td9yS6SgSTHd+NWnKnXTKp9WctvHyc8HPpKjoDyngM928F8W?=
 =?us-ascii?Q?XpJBjY3AWDKAxc3kcz2HQAQVMgJR4Zp2Hy26ar1Q4Uuo9BlK2pA11XMQGUOA?=
 =?us-ascii?Q?psZcW7J2yKddvGNy/yMP6+ulKJT28o6jmUmldRo05oHQGOoJ3GFEEc0UbDI7?=
 =?us-ascii?Q?hcQg0MnSNL0EXMt4VLcQdJGapLQHF4nOY2IR+O4cjHIn2esGq6qFHG4Wi5N8?=
 =?us-ascii?Q?Zpe6mTi+csIFM6nvrxTJcuY7FQ4v5634friMeisUmglIlc1DOWUk4c7j3bkV?=
 =?us-ascii?Q?i6dxh5sylT+Ol/Zc3LVvkUkzEIL4w5aqhhOxkW5Ggk/pXViL21+ru3pNOPkT?=
 =?us-ascii?Q?hIqyCsqGd6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPz+EHGmVxR5HeidTubbyzFjXR4Y6rUPKgU4l7mUH6xMSqUn6qgkAdSnS1Eg?=
 =?us-ascii?Q?nY2aY+fJ5QdmpVBweIyXYQOmix4RQxt32He2FU9Z9nHHacsDYozDWVVSoUEw?=
 =?us-ascii?Q?JuqXgXlB7siNgRATYL9rE+yEf2WLTwnDjcZr58bPkcT2/SI32Z7YUtAC/Te/?=
 =?us-ascii?Q?jNbcRdzSFiW6kFfRHv3ah+AjzuEvTaP6HZGr5obJL4tZfyuYtS3g48ZrTVc1?=
 =?us-ascii?Q?sagU9luch23ss+i/C1l4wR7JpL13Y1Pp2VuygMjFjLo8hUzLg1ZPKaLWrT3C?=
 =?us-ascii?Q?8pRxjxsa78u9kjj48/aLoVUJERCwgHkA0nYyF2jtZvJcomDzShZ/5/CclYrg?=
 =?us-ascii?Q?/+2xcjLiJogr/tE+gmbe6R36bhv2pOFklJs5W+MWvD1MgxCo07shEYRT34e3?=
 =?us-ascii?Q?Uh5W2R4b7Du+ywhRp00pjxSyFoIS3JLsZhkcANIn9A/sf3bcoEGaWvxl4BWo?=
 =?us-ascii?Q?1LWRMOHQkhXCYbdZqacuMVDQnBNNu/p/6ljHF/t2SWXHLdTfHFggGJA4GzMn?=
 =?us-ascii?Q?hdmd7QA5TSpaIEXm5jv1XhjruVfQWZIC5JSzzzfi+OHv+ERTRwbFNEwJrzdo?=
 =?us-ascii?Q?G9h+oXtAX+gtMGuXlqlBnnH9jy73jJ9CrFqpfVQBQMoMrtxNdQuzNGfplZ2O?=
 =?us-ascii?Q?0ayxzWJO0WDMNSL4D8cbJSgW0rffUcZYdjk1n4S+xpdzGePHdOc75uCAM7kj?=
 =?us-ascii?Q?obtKcCKy7EYsbK69nVNNwIRP9NdVq5P9RFgneavAnF4yP5U+fw5QxGwllZD6?=
 =?us-ascii?Q?eyKmhTznAtPqIs78tl3nvenfCjo3OLEytRft/KJ3LZIkLqmFW5+8igx+pibp?=
 =?us-ascii?Q?Tp9NVbxQACrBcHybl3jjPCXANnpXB9FKQtQbG8ktbG4qcfPUAyhD9G9wnZ9u?=
 =?us-ascii?Q?01CkonnHGIO8xEcgv94WdY4x3lYEI/jd4y+dupHYtSKJdOS/RbI1getEu5vX?=
 =?us-ascii?Q?R0I7kq9hFN4W9bJcgj+6e+Iq48ytfAv650ejmlkgJ37/vbXJdeiaeWJJkZiI?=
 =?us-ascii?Q?fcxYsmLYYnCgRzLqezLYLIN88ME3Cs4V3pExBRArXR/h44MRdey50NoBn0p5?=
 =?us-ascii?Q?kJy4e6yDZGLfC9S0SBctlvnnT/y0yth97kF7mxnIl49i+a5LHuVTV/CCFgu9?=
 =?us-ascii?Q?iIAi9aiCiwRO0y9tWXGdlFVS/PKyhLt6QjhpYdxMK3n3ZPnuB4IcUxgvtUhs?=
 =?us-ascii?Q?J6iIxREU4yl1x4b5IREsB927XrPl43ejG4wk4/Co/wO6VBv3xiFJc5vVZLra?=
 =?us-ascii?Q?g9XRzWRA5EUbzO4bXm96PuGEsjYFZLUcJew5MPVGB20ap0Un+Hz/z7y2ZBF8?=
 =?us-ascii?Q?qN8XWTNnWVAOxelVSpmT/HSvfkPnngNt1yoi5cdhQGpey+PbGHRI/cw0glI9?=
 =?us-ascii?Q?t1C1N1QtPs3GaWVvPeQ+F26o2WMPxl5qkaiPSr2T0iXoZP354s3Cm3qZdLl5?=
 =?us-ascii?Q?GRr2lvya2a51xwxZWZ7JvV7yeGyaXcf1PI411+u5/2nvB3hxx467m9+RsWM3?=
 =?us-ascii?Q?48g6SFAFlT7pSAyS7JajGWpW331r68hI3337JZwRhsf+MqSI6Zh7Lz0wM0i4?=
 =?us-ascii?Q?vmv/ybXPY+9HKJlwaa0J5KlQwsFUTVrjXD6GePev?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QrIFETO0YDBAR/HFkRAf6twxR8sxFfhjc9hSRcpXrJ+vQVvUW6oUIJbxCTco7ASrN212YM2a7noMfoeo5PJhZbQ7TLMpa5qdwOA2bUijLpFAtT2BmMI655ZOcf+MA1qiltxjqnFzyFweHBDLgyQhBNqAl91ej1KR0oNEq3bdXPmELZ8rtIuv+bxjqMKvp+3T0JarVr04sw7N1W91TX2eytBKFUh9s5T1SzhD7W0Ekc+BEMT94mWb1eYlnsRFpsiLaY+XS8lNwAP/3K6VK6E/LGJFx7f0gUBFtlX/uhFmIEHHNrAkPwO8xadMUwhz2wYkzOgo/pYPZ1y+i8G/0KlxhM/K6TNtHvxiSjEqrp8EYuUWCPmDe8bCWcJnEFFcma9FRRHFgpKZOW+yeeiKqrwhScoM1BzDUEfgb/29/0cnKNBL0asnRfths5o09RTXD+BDjnqqK7yEI1Qm+NqoFN9NdKGrfhhsuPiKp5oo9iyqFOk81sLABrZ65Dk2iKQsTtM7Ial1Fp3L0283sFn+Jnyvd6zT4Dg+hVbCHqHeY8CeCCSBAjC6phZ4EfwZPd1hbnqWXB+1si0+VVeRhrA0Ti06KwE0ULv/DnXdsTNqBapQG2CrYdeXG5IkDoU1zDsdf7PT
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc960742-0f00-428a-f532-08ddd3f615c0
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:00:03.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb2iTlwIQQjUH7PaRR176Hi5rOH7ZxlwHeWSW2wFmKcFFmxjXgZJ41OxDCsX4kqlWLU4EHh9D2T/RvgjyBB60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1584
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PAXP192MB1584.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=JeO8rVKV c=1 sm=1 tr=0 ts=6891ba05 cx=c_pps
 a=qOIXlmJt9mzowr3NHK3Qvg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=Yi-vpBeI7XLzyeBKmhcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xd9HlDxH9b29nb8nIouyG2KuSdrW4aF6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA1NyBTYWx0ZWRfX/r65efFggcKZ
 Q4KWA4gNHgFNaFuoTTRmE6M8/bD3bcfOkkMaPPSUvtexfUv1858SgT6OMyWw3DtIFhvUOPX3lQa
 j3L3OTPhpvf3W2Qnke1DRNBN/2px/7gDxcemLwkj9Myj1oP+6igaQV/rbEave7KiAk/Q/6dmKLJ
 pgtulG2FaaMbnCE9HlLiNfdRvfIso4WbTsqa295jkeJiO9Bdc8PwlmKtL+sge/KI0BExuH6kGsd
 I3O0Es94FrVrTyFID+/H07C+bt3+xo0f49SrquJfuwTzohF+tMt1f0cc7y0Ukk0c+Txksd3odpG
 g+Z8bWT921ebt0wSoI1OI0PVxI/sMHLUjbzz0D65xhs1WbbgaK8AjDEJninCFI=
X-Proofpoint-GUID: xd9HlDxH9b29nb8nIouyG2KuSdrW4aF6

Am Mon, Aug 04, 2025 at 07:02:34PM +0300 schrieb Vladimir Oltean:
> On Mon, Aug 04, 2025 at 07:00:37PM +0300, Vladimir Oltean wrote:
> > Can you apply the following patch, which adds support for ethtool
> > counters coming from the mEMAC, and dump them?
> > 
> > ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon | grep -v ': 0'
> 
> I forgot to mention how to show flow control counters:
> 
> ethtool -I --show-pause eth0

Hi Vladimir,

Thank you for providing the patch. I was able to apply it successfully and
retrieve the desired statistics using the following command:

    user@host-A:~# ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon | grep -v ': 0' && ethtool --phy-statistics eth0 | grep -v ': 0' && ethtool -I --show-pause eth0
    Standard stats for eth0:
    eth-mac-FramesTransmittedOK: 2188
    eth-mac-OctetsTransmittedOK: 337884
    eth-mac-MulticastFramesXmittedOK: 76
    eth-mac-BroadcastFramesXmittedOK: 2112
    tx-rmon-etherStatsPkts64to64Octets: 16
    tx-rmon-etherStatsPkts65to127Octets: 1587
    tx-rmon-etherStatsPkts128to255Octets: 63
    tx-rmon-etherStatsPkts256to511Octets: 522
    PHY statistics:
         sgmii_rx_good_frames: 20785
         sgmii_rx_false_carrier_events: 1
         sgmii_tx_good_frames: 21120
         sgmii_tx_bad_frames: 52
    Pause parameters for eth0:
    Autonegotiate:  on
    RX:             off
    TX:             off
    RX negotiated: on
    TX negotiated: on
    Statistics:
      tx_pause_frames: 0
      rx_pause_frames: 0

I have a ping running in the background and can observe that MAC frames and
TX-RMON packets are continuously increasing. However, the PHY statistics remain
unchanged. I suspect the current SGMII frames originate from U-Boot, as I load
the firmware image via `netboot`. These statistics were recorded at 2.5G speed,
but the same behavior is also visible at 1G.

Do you think the issue still lies within the MAC driver, or could it be related
to the Aquantia driver or firmware?


Best regards,
Alexander Wilhelm

