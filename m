Return-Path: <netdev+bounces-257916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDGvB82hiWlU/wQAu9opvQ
	(envelope-from <netdev+bounces-257916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 09:58:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7442310D49A
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 09:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF749303B4D2
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA2325721;
	Mon,  9 Feb 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gxHY2ne9"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867C238C1A;
	Mon,  9 Feb 2026 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627374; cv=fail; b=uoCuV72H4MOTdNX2VfTRXjyYBEcvpeE6k8zPljj8L1YsoHWNxL99tIMNQncQf6g4D4ugRLneZRYckhYAXoQL2uLCDp92cehWjnDst/3NDA+9Pxu/Ajz7lvkGWSk7MRRTPV9RWLgX5oaqGhyOGZNRkNlLB1KUn9R7XlMp/yZcxCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627374; c=relaxed/simple;
	bh=N11W+J5zQaAf0icjbwPYeL35nIOvhvvPmpky/W+/rrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AU1dTBIMZyn3FcKQDZVR2zBoc9gJjT99XKc8InkPb/ugXq5HoHC3uJZEc9iIcSGPF33/8GuwOuQqFG9iliawpPp3ms2Of7cIVxEQxbNEmPsOZ/ZQZFfkcdduq2z/50WfB63x+ocqNtFWhW0jAdwm8pe1LtvdHDG/rgciE+Is4Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gxHY2ne9; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCug3EitWf31F2S9B5QpK7s6Rfkqg+Km1Y45uqGSSP9IyxKQAR/TBjBo9XZgP+k2Bn7TscuAZ3ME+M8r5p3pdws+E/qdtm3YIkAEVmqIWfHny3Q9ooIUBdwlZZ2BiHnM+FrHCC1okbbXfpxV6NHY+AZbdIzoe/uAruo4xm/byGmHYOHrZbE4U8uz3rAVhXpDFamDWHamwsUU1HHCrhszjRZZbtpG8UaWGysWPHr/68NCxyWQ/Km05SPs39LvHtCjIsJ2pPchTZEFrmS99q4hjTlNZ+3WrktSYwQSIhQYTRJO/zaewySyxh+q9mNPhGKswW2gadvsSBTv95Tz+jv5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzOQDmp8sMPTri4wpSmL6IZ3pk3d+PpdE32mdxEkopo=;
 b=KCPmD/7rNyL3ovf/PBJD6FtzeEoKCiotUJobmna5BnddltmQJmytQ74yMqr8V2sJpKOZo0GZQZsinbRrhXUdqKzfxynRGg3yslNsPixKisUqIs9bZYEPc0mC+tDB2InC9MFJxM64cI9mZhdiGww6ZaMSPUr+u376mA23I0P5nJVUcCvYM3DLpDQd7lORVTyHPzwTD4QR4s10OmHdLB0PUR7/ZsW2Al16TnVjiLXOYIfNCAxpOfrElRtKgEMd3e5IF6OK+2sfoMok+qbn2VtaxHcMgKm5Hb1bTF7BtVvLmm2FssEmyeCxeNeKJpPLyr2RClSLdGeln0KQLVyDziE8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzOQDmp8sMPTri4wpSmL6IZ3pk3d+PpdE32mdxEkopo=;
 b=gxHY2ne95O6zBhjfi42P+6nlK4Wlfe0e0upAT1kpoCmeTP/8AGecSjeVQmg07BMbJUqi9oP9h6zrjDl/Di787SNFgl/rz67SSYdwTLkljCx9f0W+kY9wqby7ta84uV1Q5VtXMqOhqCE+e1uZ89jci3W+l87v1ySxjVKaH5R5E2XjX5rRgXhjcs9LMIsIgoaJwVzwBy00hy+sUusJeHivtBk3o+fyIytNTUuecTcyJQwPYkfiT9H0DwJbQaqWcF04/47ii2XgXgxa/nL/UQnn+LeLQwdLZjhwxaCDvkVqMxlaIgObYBSUjGQ+Bb94lBB+gGHCnQQxfi+1kz1/Cd8ksg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAWPR04MB9744.eurprd04.prod.outlook.com (2603:10a6:102:383::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:56:10 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 08:56:07 +0000
Date: Mon, 9 Feb 2026 10:56:04 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] net: mscc: ocelot: fix missing lock in
 ocelot_port_xmit()
Message-ID: <20260209085604.55p4tekn43dyonvq@skbuf>
References: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
X-ClientProxiedBy: BE1P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAWPR04MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bbb8f2-548c-4f0c-1a3a-08de67b91039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D3anm3ISHJifuKcQzVoIRSJig4tSkcrcGzmAStL+N9fsXbO3/+FHdRb2NKgJ?=
 =?us-ascii?Q?V3JbVdlidIbvJwQtxsxT92rxhg2cqDxzs1u9aBedWm6FH6IHrHj7CFAtd9qY?=
 =?us-ascii?Q?GCoT6llF4GXx6RZF4stTvOHpA8zOxamEy15RFl7MUrLIRoiRo4aVCvkFmNSa?=
 =?us-ascii?Q?QnD/5b4Nyu4Vr+7mYJM466zmJ3uUooU0pdYjj0FcmnvOqylPQH8BdQ3Hr86C?=
 =?us-ascii?Q?Nz/u8DpM0OIaVJ0hAePWKUFc1pIKmMss/pMMyvzwhZWz39/JkEzCeFzvmaBH?=
 =?us-ascii?Q?ScYJARY3SOClutOoBcn9fwbkuieNOg3NltBj+gFp8/nUjhzGFGWsrZMDA0Nu?=
 =?us-ascii?Q?W/RxOn+kiNXvrlNC5pwPieumghmBM8QL/LvwBaueoTnr/qRw+AHM6aQ97M9b?=
 =?us-ascii?Q?IhrWaMw0PDOIhEdgRo8SF/1oYZUKdTxJ0ru1PCNPML5VTbPKyl+hiSV97FFf?=
 =?us-ascii?Q?qHFKugX2FjbnD6AJ+zYUnGUqK5dHnFkaDiG+6kcD7VysnERDJ1AxkhY4ipNN?=
 =?us-ascii?Q?9XqLThqJDQ/xkKWd5ytvgcppCKiTpFeqVtjGCtsfVhrUnDyP0LNcr9PJzmOq?=
 =?us-ascii?Q?cT0phC3kUyK7S6BkWdpo4ut/YfUXm0Fzhd9Aou49uWzd2fz7yAF4eKT0nMI1?=
 =?us-ascii?Q?xM7ownK4pTMB00+QjlNYCnXzelySVhDZp4g4BUhjq/18a8v8mOHXXwg+OPDv?=
 =?us-ascii?Q?0d6AJMh31LEL4Lk5slkc0DhL2hzB+59kajrB9uhErfYFPF+bg2KugthNO+U5?=
 =?us-ascii?Q?SWnD9YDhv8OkVT0exvGkIF+CWaqRZ4BBM16Q2p6HZYtUHFesJq/tPDzgtSvs?=
 =?us-ascii?Q?9prLYCFajwkK0ufty14QB8YsDsUA9U1gQIMnMr0uIhn2YIa1NU2aofC4GfGz?=
 =?us-ascii?Q?mjVClLGwpChQ+7tEk5NRXobhEmFxqYTdOg7QThe8buHjEAGE+3LaHhw+Z1Mr?=
 =?us-ascii?Q?Cdb2Zk/A8OWjQN6K4G/t+5OqbNRoFxohpq1jPvyh0XB8GF9qvWpIGTNGIIC8?=
 =?us-ascii?Q?diSv6GfxYYTUVOtkjC4YENEhn2n/1Hkji5GlstYUHDq+BZsdrfmJyaunZpkb?=
 =?us-ascii?Q?iDQnJ02uD1vyPqFCksebO6aLKxWRV7BnXoj57wF/8BXB1mpzV/tu1YBRLbl6?=
 =?us-ascii?Q?RJAD2wyhZOESECeyPeUETvCekdThhBu6bKUpYBG8Hkqgj6QGijxL8EboQ/s3?=
 =?us-ascii?Q?m+gaMdS0z+2t+2fBLMpGMp1jISBCxVNJIhyosMdGwpbr0Bxa5QSW3me4fQ8i?=
 =?us-ascii?Q?T7g3qLk2L+iueTAOlrMOr2vVKbAk8l/H3H5SCEtx8WgjNyzsxiiEAESIex/a?=
 =?us-ascii?Q?h94ikyCO6zPx5I3/QHRv1mFOnD/oh7WJ0yq45cU6eRQY5ltzIcWgQ8vhcVkb?=
 =?us-ascii?Q?N6RyhlA4pdAb4lw4R2/tdOjI1mOGvxq1yQqd0qOlCvpqUilTUvNf3imginM8?=
 =?us-ascii?Q?rPmc5Vt8Q+bbJhqsIk6dZaCt3Y+qRYsaVnJiYlLsmZjJOxdAt3EUfrn6mCym?=
 =?us-ascii?Q?5uOsTamc0gzH9SLNKJNyZgJz9liJF0cNKYArzKHAkIW/niNuuTGFjnJRMIuM?=
 =?us-ascii?Q?7iOt+5/ARMGuKJCLtBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qyPRdws/bQjrY+MkO/30KPsSk3XKsunsrGx+grOCgcOR+wqESiamT0GryRTV?=
 =?us-ascii?Q?2Ahms3w34TbG1w1uNEs3BRWWfY3gaWndFxKnbOxZ2pDtrUHYMOgSrGnwCCYP?=
 =?us-ascii?Q?l3ptbM5ICQtJYCM49oVKGwByx+FFn/F0hufX0p5qOzoZsJK4gIdZXUB4ilp8?=
 =?us-ascii?Q?40IOcXlT6fgL4pqrkZaUAiAt5OE6cSAUrmLdEkQudoZ4NcleVT3xw2TDvHIm?=
 =?us-ascii?Q?/QdZF+NU0nDh9xyw+tvRXP1OCT4lqRtPM3S8RO1WuZ7uEkTQovi0+VBZxXNs?=
 =?us-ascii?Q?ohfF/d1Yqg6aRB85lhIBbDYADqeZ9fHzDwRqNWmZfebmDG0UY+aoib2gto1u?=
 =?us-ascii?Q?+RlJFjtgw3fiu5MHAguTua0MN84OS0k5Ka2Z5vBYl2/QZDS/yGLzCZJIILEv?=
 =?us-ascii?Q?Bjl6B0P8RHRSuqEongDk24petdvo5u3LmnHx4Yxr2uRFfHpw76rNiZv6/xHL?=
 =?us-ascii?Q?ebhRol6HoqiEjhHf/BVjcWIE1izOg29IaYkzw/bFxO9fJGhAZcbIwDIkL4jR?=
 =?us-ascii?Q?rYDgu48p8wSTrDPXffrMHG0uusYfqH2ERXtTKUQqn81axp4HDIceDYDMP62W?=
 =?us-ascii?Q?JYZuvJeYJnca17UqseImxG3i4HtaAB+3IwUpWwZA0x8sOOmeiCDUNJlLgQ/2?=
 =?us-ascii?Q?I/a3XW0lYXBATJp86otxDcACyulydTFyQ0qNKnK83wDXfI29PqENuy5O2t/i?=
 =?us-ascii?Q?vcksJOUZ8QrCyfaEZbNytNaq8ufS0pDx5fCl784BSHL/kAUvGxVMJPmroJCG?=
 =?us-ascii?Q?FMu6ZwHldjBuMq5bs/zUs7IQOvWaHEgx0cEdgcqkMvOISErKu6ZLoFUEfvAW?=
 =?us-ascii?Q?NNzKlqVyPCyLzcWvfxgSu0S0n287IsEkaOBw1cTlCSWdadHGP4H3WWV0Zp63?=
 =?us-ascii?Q?oTxwbcFtPLhTx0t30ycCTTkhFoRr7da0b5olO7SsPoL4lTiIhMza4QupDikL?=
 =?us-ascii?Q?zYQ+fWvlS2q1+JSaPN4oCG/9XdrkRrfN15Ag72hEVs/FFUWlEZy+QiXqI3b2?=
 =?us-ascii?Q?xqLf9ahdXY4++3bKoPPAb+oYSAtUhwFbR8Q6vB+JRGh/4Rhsosbq7jD/kGzg?=
 =?us-ascii?Q?WZ0T4qVuFeIUQRE1w1PWDVvIQ+vh1HrXhSQu9qDdjZIWgH1aalSkXUmCX2gr?=
 =?us-ascii?Q?5uEliWTrISMMAwJNeFUn5BWTGdzWffyCGrLxiNN2txVyotP5oEB5bQQHMTOG?=
 =?us-ascii?Q?IM4FfF42hYveCVwkY95nCyKuXn86zHQ/n3Gx9SIoFUWM32kx5SfIdijswz5n?=
 =?us-ascii?Q?lbrLDO4DWBzKK7PH29g2bDU+FZhDk59BRjm1FwyPaDr19VMeJ9HoSx1UB7H8?=
 =?us-ascii?Q?zD6A1NjJLyEMdESOAvphzksNWKAD4XTGyp8vCioJxAKEkRiIGKjtWhiFifgQ?=
 =?us-ascii?Q?5MbRGZD67UpeYlM6bCTgXLQVuksBdp4iqNGXznDOlCXFBJn3r+lRG0ow8Spm?=
 =?us-ascii?Q?iZjaFI7ubseOr1lGon6k3gzMBHoMJge0MufDMfoZ7gge9EdlWklzUgYxcUec?=
 =?us-ascii?Q?25wKqE23ZRyvgVG0V0vqmY8s8NjQsCNk2vLunXyvb6Rz9iQk8AXZgzWc9eYX?=
 =?us-ascii?Q?ROk6yThORfof+mR/rJBRJnmbhN6241M7Esndeqhjb4teGEqvBxBJVoiueNR7?=
 =?us-ascii?Q?FapJa+UNGoUUzuI535Gb246CoUB8No5O+PLlQnywXgKDSAmFUlbUqIdidNdn?=
 =?us-ascii?Q?VPSVAbrK2l6AdSilNXL8qJ2pzBpB2iBcNZHRX3EdGzWrty2X0+DmooVZE7zY?=
 =?us-ascii?Q?AmsPMhWSbfor82hxMUusyH5OQnQe1Gn2LMGO/6iw6FyDGkf04mL4boy3cbxQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 4q38DB9natWm2g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bbb8f2-548c-4f0c-1a3a-08de67b91039
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:56:07.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18RDxc0g4s5VO82mraU343H68bARgLSwd2lfVfoxdayKMroMQaiVTkxgWUlKS5JDtAB3Y1NCiS6lIHsHntI5cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9744
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257916-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7442310D49A
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 10:55:59PM +0000, Ziyi Guo wrote:
> ocelot_port_xmit() calls ocelot_can_inject() and
> ocelot_port_inject_frame() without holding the injection group lock.
> Both functions contain lockdep_assert_held() for the injection lock,
> and the correct caller felix_port_deferred_xmit() properly acquires
> the lock using ocelot_lock_inj_grp() before calling these functions.
> 
> this v3 splits the fix into a 3-patch series to separate 
> refactoring from the behavioral change:
> 
>   1/3: Extract the PTP timestamp handling into an ocelot_xmit_timestamp()
>        helper so the logic isn't duplicated when the function is split.
> 
>   2/3: Split ocelot_port_xmit() into ocelot_port_xmit_fdma() and
>        ocelot_port_xmit_inj(), keeping the FDMA and register injection
>        code paths fully separate.
> 
>   3/3: Add ocelot_lock_inj_grp()/ocelot_unlock_inj_grp() in
>        ocelot_port_xmit_inj() to fix the missing lock protection.
> 
> Patches 1-2 are pure refactors with no behavioral change.
> Patch 3 is the actual bug fix.
> 
> v3:
>  - Split into 3-patch series per Vladimir's review
>  - Separate FDMA and register injection paths into distinct functions
> v2:
>  - Added Fixes tag
> v1:
>  - Initial submission

For the series:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

I see you didn't specify the target tree name in the git subject prefix
(see Documentation/process/maintainer-netdev.rst). For the future,
please do so. This patch set should go to 'net'.

