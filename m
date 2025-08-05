Return-Path: <netdev+bounces-211689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDAB1B3A6
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8B6181DA3
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264227056B;
	Tue,  5 Aug 2025 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="UFaKZ+6h";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="fpdI8SlY"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1B1A0BFD;
	Tue,  5 Aug 2025 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397900; cv=fail; b=miBhmwEj3D6sCu3Fgd2m89uSJPfQzhLkouGAvpYwN0YsfJGEI4mR9ELTYXW93PlVI6VuHQo3ngPMFJhwOyyEbM2T0si9gE+SUevNXp4k8tUnjKJjzkeFJ37kEcnE6Vei6VF93ia//+m9pXpCo4pQT8o94YN7ytEuXD3UgMWBM6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397900; c=relaxed/simple;
	bh=QQXp1jYKCLG1KDTI2f32YQ0JfyXLcZaLZTt8I7vQCA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gD88Yt2n9aK463KwR2L32XBlRnoCKWp5QIvit9764lQ53QVmRkO+v+TYTP4gtkEn6iRg4zbSYLqc6LzVjae9ZOvNMgHomhkIZ9uuWM57Pd5OeJbJ3byAi4cGjb5jJP8iD0pHdAT+trrBOuFr+ikqsIe5Tr3U5esOzbZjntQ11dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=UFaKZ+6h; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=fpdI8SlY; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5755qA7A3492870;
	Tue, 5 Aug 2025 14:44:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=2uQa1DB7EC4JsfvOHgHjqq84
	tUM57mC8PWCb1Hvc6Fs=; b=UFaKZ+6h8SK7tHFdQMIgOsPqC9Ci/2y5n+9U+w+p
	Ft7G+6bYkCuvfx0nBWGUY+T2Fv+jNGLZUFVrymcBVt99UNy4RVcNXp6yYSwEeBKM
	Z0D7/615I9WShdE5Nz2iWDg+dZlwksQm1VqGAUYhvMTNKxj5rzoPcZSMh9jEPMmW
	3fY7GGS/NgzKfZuSSKMbtngqvWktghJU/X72sP6Q8P2TxhhGBNbASb/YTttLyPYW
	ucDqS1GgzYoC+VtYoa45vPVPI19/iRGIzPBtG95tfBE37ASRPDx+OiQxuNQuptD7
	CMs66x+Sd10Uz6OMzuQiC8aC9b7FovLiZaCNE3P7PUz4bQ==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2136.outbound.protection.outlook.com [40.107.22.136])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4896p1thpq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:44:24 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9uH9Og/JfsqCO9WbybybX1koMW8ILSr/DXJRvcXqAVVrVGC2KsLRZjfqosH/wSuY96gbiAL+pRhl4bvVM9FLBGchdJ+gqiIZbhFBRtpbLLZ4fTAI1CuwkgAPXFBFlaQLFKNqTA8oMrwejeLZBN2lSeOQ7RlTv2gfJ+VPG9cVwJYsIQiJgksGXtjwWmzTHfAWCiFyhIXzeCgiwnXDGk4Hvjg4HTkGRtjtro01KuNfs3Cdtfp2HDO6TldvxBMW4Y+iQFxXvScUxXKZs+oHx4gZ/WMLJ4+kMGh6zFo6arPEjZPep9n6MzLANvTZuxUVj0rOgFPzTjY1qWykdTts/kuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uQa1DB7EC4JsfvOHgHjqq84tUM57mC8PWCb1Hvc6Fs=;
 b=k1sJkF8Lg77b3Kf1m1lnpAbdBdNSZgr4NSjfHbzASU/BFUYAohew3Bt9fG2wyU6RW8XdYC0K1tO1vSsNGIimOJf/nr84DvHUuXh8ZEs8AYnFYcf6Egq1LLmj6cK1n0ve4+fq1VsdLF9tqVfagnW+JaSo/70lvF8+rLljACsOvGQF2xXDl4pufcyjphMw1o0rffWclDOXsHbIfT+5rSMi+iU52Pb91HnDwNLCDq3UZQe964QBrPZ/4Qv5es5B778yh4T6B7UOGBIXWlb9x7xMJv4EACerBA898SBUj7V7dSGZDPFKMdVvjC5bkagcLPuY1ASOn7knycN6o8ioliHUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uQa1DB7EC4JsfvOHgHjqq84tUM57mC8PWCb1Hvc6Fs=;
 b=fpdI8SlYqUlaPRc58WtNfKVuE5aFjOeNNcEHmBpKXy/tNFsV9Mc5E0mBrqtgtWEy7hswTWXDVcSFXH5FwOh/banSjq1brwEymtUMaISaVQoZQN7+U/+ifXtlqRo3++S1OtHBcfupo/7rFnqvT7Mde8hGSbnQ/ZU1JG98nD8Hf0s=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB9P192MB1963.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.12; Tue, 5 Aug
 2025 12:44:23 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9009.011; Tue, 5 Aug 2025
 12:44:22 +0000
Date: Tue, 5 Aug 2025 14:44:15 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: HE1PR05CA0336.eurprd05.prod.outlook.com
 (2603:10a6:7:92::31) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB9P192MB1963:EE_
X-MS-Office365-Filtering-Correlation-Id: 76057776-0f31-49a9-f5b9-08ddd41dcdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AU4/7tkNauP10f2bnEXoy7jnGSSgc3AQlNWRCbywYsMPRI6U/qU5aJMCDdKf?=
 =?us-ascii?Q?sn/vU4y6+roxCsVntyaTpSwguuN9KIndCrBKirhmEOnHA3Ye5o2Ha8f6qCDB?=
 =?us-ascii?Q?m4lwY5iUwZUH71FC6KkZiOWjg/eil4trQLfixF8h5U3vVodbFqSdDthoWKaF?=
 =?us-ascii?Q?dhk65ruSBS9XV+oi8Bo7chY0I8fPUQk/iafHa0D9kBZYT06REqeAySBCw4qo?=
 =?us-ascii?Q?bo6iYsqtq0YRQDsB+sj1Hx/vt6mqAM5R/1XdxEtzjOTkpQKE2n/6JZfm7gun?=
 =?us-ascii?Q?BEuHH0uwG9JoOOLvNz5t7yhTvMSEd0g+32kZEEJUX/TrtsiWOGvYP1XRACUM?=
 =?us-ascii?Q?Qkb4YWAtmJsYExEIEmuNXJqOVpyvGmxfwKVm0JtaWiIoDIDE7MprZ2cMlNM2?=
 =?us-ascii?Q?/GNXJVO2XL6CiOgLZacM8o5yq//cWXKRW6lUF+mjg6AwZPutD0dGJM7spZWN?=
 =?us-ascii?Q?rrV7A6/3bwVpziI+mvxwX/6vPiiy689JPpB7e5i3JvmldC+iTGR88+LRJzi/?=
 =?us-ascii?Q?4+tepNVqTi2jED5c9PrTBMzhSfXi0itbnAMOyAumcbQCugQ8nS1kJK6/+wNT?=
 =?us-ascii?Q?EIzPClzQ3YQQLmXHCk5oTaMMqItbrRoiMubcnzQoU9UxJuuCH5jHRRVvidWD?=
 =?us-ascii?Q?R/+GQK4p+iCGGcfHiB9d48w+cp6ymhRpWaU3zzjdI/EjR9dbyymIiC2tv9Fe?=
 =?us-ascii?Q?G1aY7oGlY9kOv/q6r6b1YwhCsoH1NyfzCueTDocTyz/XsA9HCmzLNh1nQ1ej?=
 =?us-ascii?Q?AQzIFzEnQcFIsGt46WH7Rezxbx+xhdwdXqqtZyWBqiivEdhgASJMLv9vYbqd?=
 =?us-ascii?Q?CXOvs912oJBR2NUGiXxIxtO6ZjpC08crEyyAyfOZXaAi3qxa6KPT17RIj6rg?=
 =?us-ascii?Q?yg7ZGvBlex/vGYXgpkD2NJIivov/2PSjB5LkrMEyQ09dbJtR2v8Tnivt1qWT?=
 =?us-ascii?Q?YLO0s9viwls23kcaYt3pR0WAzqG+07ytgtVdywgGL05cLixwsgURvxt1GBDF?=
 =?us-ascii?Q?IqDun7cQbM8WDalEfrgw0BRbgeYpoXnEqv7sfWvu1piES9qtVbR1bXmWv1sa?=
 =?us-ascii?Q?smoOERAOFvHcBGO2iNRtdbiwLx5zx/PgWQEFJhcv5j+fBLCq5aAsIQvNVdXT?=
 =?us-ascii?Q?GiEyUaw/1FhGK/GA9WAWCDnPRBt/bpT/9WHU1M4IezeSzijxzBnXWb+MeuCk?=
 =?us-ascii?Q?yLBgEpsGYeZjkcwhoYFqD60kigPDgQzN40RREn0wpfcXBbZBy3k9jdkaLI3O?=
 =?us-ascii?Q?/eZjZ4Qqp6pnP2qm9WcCn7JZknzVIUE8VSRqBghujUaktVuujbm3QN2IUG8I?=
 =?us-ascii?Q?XTtylVJwh1Zvn91S/lZCJqMB0M2KwuDBNdg3ufOe0pzbJMJUhXUbNNPNRu9X?=
 =?us-ascii?Q?UvGlmFiij+VnQhCmX6A/Ee1PUidZyhllh2K8RukpaxI6izqaYW+vSE2tPvHS?=
 =?us-ascii?Q?yvA8JjVTUDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JbHBgz4gjiaMxVK8O8W80irfO2uHXidkyUfbX1t+ErKmYS7o24NezlGLOCSu?=
 =?us-ascii?Q?9Nmh7iPsJWbbn/gOZlSOiaoi+Yuqg+1uEKYIwuIFYu8M4jhN92tHYdfD3+HJ?=
 =?us-ascii?Q?gilguNtbB3ZNEBwd7NU1+LMTQ3gyNP4aHZFEXIad7bi6Alozr5+EbzOYZXg6?=
 =?us-ascii?Q?1ALcZDOLgGbQgFOhCgNpGavFmAeMDZ5DazN09LjTrLGb+CxLflrg72vZaVXX?=
 =?us-ascii?Q?r3TlvX8OQceDCx/iiIaMGzdFFaQ3LLBG89KicZ7u/jtRBq7u0fuvdvtDP3zO?=
 =?us-ascii?Q?Ab9SM5CCpFcQSTmdZAtJYGaFrfTSLLzN9AQhQ+9KvOZj3e8uXW8r7tVjJ74Y?=
 =?us-ascii?Q?yz7Pbi8dsp2hiQHihEQzaMM6TP4LoDmfl1u7akHJdZN29YgL93Q6dXlmGphy?=
 =?us-ascii?Q?2W5Kg/WuD6LHbu7oVIv47S/NY+dLLkfqJYLzqWCAqZCpbC+ySgVRzN4wgrTu?=
 =?us-ascii?Q?BwBJOJe77fK8fY/HnUcQ+aqN4+ccdFYo2axQFiXHiDvIS1+NrmcAHRN1Cfdl?=
 =?us-ascii?Q?ACdfzqJy3tD+HEOQI2xtWC5KacGv5Mpa/8jdUGrSi0kEcLFdmluB6b78gv8U?=
 =?us-ascii?Q?i8Ujmekqi6ly+thkz3NKdW3PKiqXHatukuHzsYTXXGiixCUHfsUHJiY1URGP?=
 =?us-ascii?Q?yJEC+z90jESnc4vCPot77G7ixvCNwiEDgjbwr3+JENqdjNkfByIHC+7alkhZ?=
 =?us-ascii?Q?ywpBTnfSt1HuqPOgPTAlXdP8BkVWTPdhuT7msVPeDn7wymy0U45bwQhnkONw?=
 =?us-ascii?Q?8YsnxC64aVbAveUMCya+VUeavfQhTyFHFwh99ZzRQSCsdXEFA7hIIET3zxS3?=
 =?us-ascii?Q?8udvxsyi0ADKsuCM1kcXI20IhlKQCB70sMqEOXwe5ZQ0Tg8rCL7fKTt73o3M?=
 =?us-ascii?Q?nbPwpLMguVtbGzKZZGvA6RuOfYy8b3B9Wr5DMO0RBo/R/vQoxZSJOpc5gFHJ?=
 =?us-ascii?Q?hmXzbLY2fl9LHiNzQfdQg3SveoudWvpEnZ3isbz4ZA1PDk1y2LuvhpnRnF4Z?=
 =?us-ascii?Q?pulVGseuBg6b4Md44mp7wi/zzyrdyeIMnzgIfRWRJRRUTG59cKW7mgEADdUG?=
 =?us-ascii?Q?RsMaZOFWbTM4klVXBmE2fM3pea7VA9d8Dgu5x6USxz6yY7eR4cEIkYUaBlbc?=
 =?us-ascii?Q?vfW953Qpor0nsH07/gFp4gaY6/mrha+P4EwS5bC93mqD+c2KAmcTtkTPYnK6?=
 =?us-ascii?Q?LOGVv1ohpNKsxv76DWYoM1ymyt8O27NNTRS4Xae8XM78Ofszv79uP2jIYsea?=
 =?us-ascii?Q?h60vc6RaPmhwT74Fj1SyVIrZpBt3tw2kobSKuOREo8+SKR3MNrNY16l73t0U?=
 =?us-ascii?Q?DquEmwta05jW7nef8u0nwq/xpnz4/fE9KIyDSDEj+hnfIjTKuP6zXmTqGQO6?=
 =?us-ascii?Q?1sM79TkrTsFCUMtvQQrZ/Zvbt3r3fkc4GyrikJg1gIrA5vxz1xK2pzFCWPxH?=
 =?us-ascii?Q?9sxu1gQ98Uy9fUADBfkOmiSdvLnBP+JytynX6+agEsAdgvdHQcR3+4mvCVLq?=
 =?us-ascii?Q?F/mfCnGG+Y1S+F4LNJNo6SRLe7C8FcZWH4YJ8QXM3I+ANGPawHyk9Di19AjF?=
 =?us-ascii?Q?DmeMaKEtUeIYN9ej1Sg7NU3rg4I2jE1+3YXUMj8A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fQUhKYVXT3p7taNCe3sZrHxSqiSWK1XJV7lIOXKDWobyfIztul36evQynn16OCvc2hHqUbS9tbJwQlmSq4d2LqPVdMOGxE7cCDdKfS7jGSL16pe8sOh+b1AIFtLr4h5/KuV5cEQ2jQErQsJDcMFshpgcrW8VXimlG8iPS9dcRbeMw6ER8iHvkocyRUXYXMbsKlr0ZSlLJpMTNMmrSeWYOgoG86ada/iKHTj+pVGJKBbW9yBtJqfqlTiP7nuREbp3dUM66RMJM3/t1G9q+7VOkoq/l8vMooHACnxAxyd8fniqmJbYwZgDXtpyvJT63EQFJ6IxuD+MqOoXWXuAOmWVYDKT8xOY7GPJ4CsQPhwTTViLeQExAUyqoO2Nsyc6pKu3QxIAzsZoCXH1kDQM8J61yvFbLzRtx0wlFN+IQuwiH8ZD3mQDFwozCSZMYcC+NltDBCDIlVcOVWt87S8XTkDYn1F1T0esmY5gTd4CmFB2HDjeFGujlpEjVWNOB54gBX4BkrxdaIFJqeNTHdX1VoW1qJcoDdrDBsbPU2VDOqQtScOtlSmlE4opcP7Smca3GOBsEkvqMhbJPait6eUXJLDQJZdcuq1CwBhkssEtJaXychMn3K0u0NqfCAxErFn9+KWS
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76057776-0f31-49a9-f5b9-08ddd41dcdb4
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 12:44:22.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQMreQVQ5E1LCTHXpNITSKXCa859mgikbooumeH7jph+4kMhJNX5Hic1Y+qq/jebmM8YLZiZLyN5z298+TYRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1963
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
X-OrganizationHeadersPreserved: DB9P192MB1963.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: NkAg_t8r9ZYBnB-222TIU7iuV4WQMT9k
X-Authority-Analysis: v=2.4 cv=O+I5vA9W c=1 sm=1 tr=0 ts=6891fca8 cx=c_pps
 a=aWW8uTPRsEyXF+XoJW2mgw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=a4Qfyb6v1e0rI2Eer9MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MyBTYWx0ZWRfXzN/9hpl2RzLe
 dqB0NBVGPgupmqvaHKqQAXVQQqBgbgzyl4GFpa3F6HXw2dWBamuU6Y1iuV9af2Zy0mrYTMabXMx
 uTAJ3UexcsIWJ/BWcz4MxsSASRx2nFgApMUgvbeEGlbcybb10zfBEomYpP/bxbPpCJ0KN3rqgI5
 iEsEfv428qzLXjEcY/2ndAcjGX7eKr/dPagUDdm+NLgUSVm5UNgKru+VoGj3R29J5xW5Nf1c529
 D3c5K9FbbKmKCEwQjWX6qF7N/kE1+t3+8c7sBJMFkbAurZwrdD2mXJo/sxmy5Hoj0c1dPA2UH+z
 ePHlmc4HzL4xVitZE7Dkn5QSgR/JKe6Jsjz6XR1phKlrziBe0XeqAuWQCUdEgM=
X-Proofpoint-ORIG-GUID: NkAg_t8r9ZYBnB-222TIU7iuV4WQMT9k

Am Tue, Aug 05, 2025 at 01:20:56PM +0300 schrieb Vladimir Oltean:
> On Tue, Aug 05, 2025 at 09:59:57AM +0200, Alexander Wilhelm wrote:
> > I have a ping running in the background and can observe that MAC frames and
> > TX-RMON packets are continuously increasing. However, the PHY statistics remain
> > unchanged. I suspect the current SGMII frames originate from U-Boot, as I load
> > the firmware image via `netboot`. These statistics were recorded at 2.5G speed,
> > but the same behavior is also visible at 1G.
> > 
> > Do you think the issue still lies within the MAC driver, or could it be related
> > to the Aquantia driver or firmware?
> 
> So the claim is that in U-Boot, the exact same link with the exact same
> PHY firmware works, right? Yet in Linux, MAC transmit counters increase,
> but nothing comes across on the PHY side of the MII link? What about
> packets sent from the link partner (the remote board connected to the PHY)?
> Do packets sent from that board result in an increase of PHY counters,
> and MAC RX counters?
> 
> For sure this is the correct port ("ffe4e6000.ethernet" corresponds to fm1-mac4,
> port name in U-Boot would be "FM1@DTSEC4")? What SoC is this on? T1 something?
> What SRDS_PRTCL_S1 value is in the RCW? I'd like to trace back the steps
> in order to establish that the link works at 2.5G with autoneg disabled
> on both ends. It seems to me there is either a lack of connectivity
> between the MAC used in Linux and the PHY, or a protocol mismatch.

Hi Vladimir,

thank you, you just solved my problem. I indeed have made an error in the DTS
file by setting the wrong MAC.

I'm using the T1023E CPU with e5500 core. For the SRDS_PRTCL_S1 value I set
0x135. That corresponds to the following:

* A: Aurora (5G/2.5G)
* B: sg.m3 (2.5G)
* C: PCIe2 (5G/2.5G)
* D: PCIe1 (5G/2.5G)

My PHY is directed to the `FM1@DTSEC3`, MAC3 instead of previously configured
MAC4. I fixed it by using ethernet `eth@ffe4e4000`. Now I have ping in both
directions with 2.5G and 1G speed settings. I cannot test 10M, because my host
does not support it. And 100M still does not work, as it does not work in U-Boot
as well.

> Could you please also apply this PHY debugging patch and let us know
> what the Global System Configuration registers contain after the
> firmware applies the provisioning?

Patch is applied. Here are the registers log:

    user@host:~# logread | grep AQR115
    Aquantia AQR115 0x0000000ffe4fd000:07: Speed 10 SerDes mode 4 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 2 macsec 0
    Aquantia AQR115 0x0000000ffe4fd000:07: Speed 100 SerDes mode 4 autoneg 0 training 1 reset on transition 0 silence 1 rate adapt 2 macsec 0
    Aquantia AQR115 0x0000000ffe4fd000:07: Speed 1000 SerDes mode 4 autoneg 0 training 1 reset on transition 0 silence 1 rate adapt 2 macsec 0
    Aquantia AQR115 0x0000000ffe4fd000:07: Speed 2500 SerDes mode 4 autoneg 1 training 1 reset on transition 0 silence 1 rate adapt 0 macsec 0
    Aquantia AQR115 0x0000000ffe4fd000:07: Speed 5000 SerDes mode 0 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 2 macsec 0
    Aquantia AQR115 0x0000000ffe4fd000:07: Speed 10000 SerDes mode 0 autoneg 0 training 0 reset on transition 0 silence 0 rate adapt 0 macsec 0
    fsl_dpaa_mac ffe4e4000.ethernet eth0: PHY [0x0000000ffe4fd000:07] driver [Aquantia AQR115] (irq=POLL)

While 100M transfer, I see the MAC TX frame increasing and SGMII TX good frames
increasing. But the receiving frames are counted as SGMII RX bad frames and MAC
RX frames counter does not increase. The TX/RX pause frames always stay at 0,
independently whether ping is working with 1G/2.5G or not with 100M. Do you have
any idea here?

    user@host:~# ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon | grep -v ': 0' && ethtool --phy-statistics eth0 | grep -v ': 0' && ethtool -I --show-pause eth0
    Standard stats for eth0:
    eth-mac-FramesTransmittedOK: 529
    eth-mac-FramesReceivedOK: 67
    eth-mac-OctetsTransmittedOK: 79287
    eth-mac-OctetsReceivedOK: 9787
    eth-mac-MulticastFramesXmittedOK: 43
    eth-mac-BroadcastFramesXmittedOK: 451
    eth-mac-MulticastFramesReceivedOK: 32
    eth-mac-BroadcastFramesReceivedOK: 1
    rx-rmon-etherStatsPkts64to64Octets: 3
    rx-rmon-etherStatsPkts65to127Octets: 42
    rx-rmon-etherStatsPkts128to255Octets: 18
    rx-rmon-etherStatsPkts256to511Octets: 4
    tx-rmon-etherStatsPkts64to64Octets: 5
    tx-rmon-etherStatsPkts65to127Octets: 385
    tx-rmon-etherStatsPkts128to255Octets: 26
    tx-rmon-etherStatsPkts256to511Octets: 113
    PHY statistics:
         sgmii_rx_good_frames: 21149
         sgmii_rx_bad_frames: 176
         sgmii_rx_false_carrier_events: 1
         sgmii_tx_good_frames: 21041
         sgmii_tx_line_collisions: 1
    Pause parameters for eth0:
    Autonegotiate:	on
    RX:		off
    TX:		off
    RX negotiated: on
    TX negotiated: on
    Statistics:
      tx_pause_frames: 0
      rx_pause_frames: 0


Best regards
Alexander Wilhelm

