Return-Path: <netdev+bounces-217226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3AB37DEA
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F532460FB3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5018B33A023;
	Wed, 27 Aug 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="W0zkAUH0";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="V5yq4LVV"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D930338F50;
	Wed, 27 Aug 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283586; cv=fail; b=EPddqBkXtJYP9jju35cp2ii/QJpXr3lO6nF+YjLwFspD8Nkza0/d8FlEwWzMVMDvif06aNFQEJ96fQVJJmDQcdZxGStoxdl+qT8NkvP1C8JZanCKDxsBx9sVecHTHP7F/9UotU102IFy3jGU0Z5B+nEGJXRqH0Olg9C0cTCpy+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283586; c=relaxed/simple;
	bh=ZmWZjEjEtqh+jj0rHxd6PLqLB+lV0Fgl/YYSFeFjeTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lwE5lR9cyb6uRiG7celRGC25bai1HvETzVjiABlh1xo45hbtUq5lK8f1UoEIRH7qVPJaYfQvRES/HhEjT55B66idvIexDhckN8E+wH7bMFYyGCSgM2E8cVD8zZxmj46L+4RZMhdI1+znlztdGsCPR5FTXviM4HLCgpAksH+q3iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=W0zkAUH0; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=V5yq4LVV; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R4t7bn1996285;
	Wed, 27 Aug 2025 10:32:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=HJ2Er49RZhibQBFCQA98jCrc
	UYXQIIlu+2IIcoUaxSs=; b=W0zkAUH0Gz5XjJvfNlqBCkeo+EExTvF8ShgbnOau
	r+B5YxZMezYTkh+kqGRrba43oMjDyd/wUkZ5hxSgtrbLLp44DkJVtf4YkPnrHdVg
	O/+lZTFJ6M0VjNad2VvODbGKjAiOdxrXQRVCxkk2xNOCXT3Ki2CuQzE70OYIRLzU
	7hxjHeZIihfFXpS67Yjv5Zij4Ry8ZvBrzSJM69f2zXdLq0+SsJUvUw8hJyBoytIi
	Sc/AqMGFS6XIMbH2dqreU0xEtEz30tzLV44kpFYq5GyGHpaG58EHvVm4EI9F95Pp
	j2C8aJOzk4bgRfeQuyLPMIz2bn3wj4v1qD4ULoa2K3sfQw==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2109.outbound.protection.outlook.com [40.107.249.109])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48q32ebxgc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 10:32:32 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbtZMrupQPYCfEJ5Ql+D6v3q8X380utxcc1n5o+/lXgS/HkYA8Ygx/JuGywNFX77rArog9TsL5tLZ9FOecefimSAQYcgLykbkdlIbiIGa+JY5TojcOmGLH5zFRNPC8Evv0Ky7vvBwMWEVyM4pnZi+yi3vf5KQOmNdwhwo0DoSha6mAf7hqc9fdqQWc5e1HoK9FHF8F4hxgkJAwNMd+u3z4F1dlXjy2bHOA2J2is7OC2OOuGtEoEHkJxj5aW44hBKq/d65wx6KRu/313UxhG6LVR+ytdxA2I1zfIgK8lQD/CC3Jic/zRy9XHdwI4eGBsTQ1NodcUpyG+7fRtXlRqkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ2Er49RZhibQBFCQA98jCrcUYXQIIlu+2IIcoUaxSs=;
 b=nmseUw3JfZjcEFORL9xeUaH8UNRziuk99A3OblWXPPXfRrHLUfZbPXEhsjkI9RMq0/Bi0aFu0ge31yp7VMc6+Uz0fnIoqO4lvx5mQuOF8aPSOttvNh/VHfJ3b3tydMXveQODWjm5rmSjgH+5J2lWXZbRlqDeQNt1iErLwLbDv8PYY1zNKFsp12SEF6MQd5XtMLPRVIluCW7dGmTrKgNr5Ls+r4BnMqg7TgceW8t/87XimLrLK1kzYTx/zWC24kizMRJGZRsnom/jNlDPbeplzogy7J4Bvs1+jl8KjDSsatg4Ui++tJXlKTFk8eihibC5BQFHOh+aK2hPF1g5auUdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ2Er49RZhibQBFCQA98jCrcUYXQIIlu+2IIcoUaxSs=;
 b=V5yq4LVV9yLGcJntWtNMDNQytM8EElQ1adC0ctBACsvk+BaS9I6hontlz7oPpnltkxsXqdpVlCozi4Uwer0kGxbHf8rQpzfq7Y1+/1ddBZ+HsDxzCw61l49Wbob2dvbWLhLRPUB2v3DPoJxStxoZFOy7JuqJdg1ocT6T5uiDZDo=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PRAP192MB1579.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 08:32:31 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 08:32:30 +0000
Date: Wed, 27 Aug 2025 10:32:27 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aK7CmzwQoINd1eYA@FUE-ALEWI-WINX>
References: <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <aK68-Bp77-HiOAJk@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK68-Bp77-HiOAJk@shell.armlinux.org.uk>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3PEPF00002E5F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PRAP192MB1579:EE_
X-MS-Office365-Filtering-Correlation-Id: d18a720d-595c-41e5-b1e7-08dde544435b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sUIzJ5q5/QHLqrsIH4qyp2rJhKTBFt64H2WYrWBalFMyLDw6hcji70FSznzc?=
 =?us-ascii?Q?IhbwWrh2fxVqlAJrjrHlFgbo9RygURnrNRsqPlIBI3uvTk4/CI0UqedLbRS/?=
 =?us-ascii?Q?uGnONwXTbEFzGtlJxOgUeBXbMLNUfRzZuxLSryQgZG6gLmNksJyCxGcBaZOw?=
 =?us-ascii?Q?39xwYYcrcNsdyEqXz0JHwHNPGyuRrDhF5DnrW0IVVKDYL8edxl6rV29l8JF2?=
 =?us-ascii?Q?tz+2lusgYGgnegSWIawLnGGzd9l+lqt7S1srbpmp/HKyDi010xbfbZ8UN7t7?=
 =?us-ascii?Q?QUk7mqiEVrOrxoIw0Q/IRCIEmDumfCyFqQhC+7yOaeAyzGfGNWGIczm8tDKR?=
 =?us-ascii?Q?8UExi7GiWDcHZwNHlOEo6oo/PagR+CNsYseh6AoT6jI4SEJNxQ2KF4vgGpYh?=
 =?us-ascii?Q?xiptBT6b5WJZymWvLRwUC5ey0iMcrdgBKhGExolfWn7Y2U4zJ7pLe9+0X5I7?=
 =?us-ascii?Q?/BujSHZa4X/H8H0Whob0K9wz46LpZq+hz9Ovdl4osdA30SuIm6RxzerZfZG0?=
 =?us-ascii?Q?WUEDW1hKJFu+fcuwgNzpmeD2UsVzEYAcIt10X7YClB+VJ/8ulxnxScWa03HP?=
 =?us-ascii?Q?NSqzJw2CaAu6GubEiNsEP/LY9n+lHK21OOHfZIWG9XA9ywW3pQP/8jINsiFT?=
 =?us-ascii?Q?rbpET/N1xSt2kuAvT0dIPv1noKwH9XtqIY5WxSq+pyjJb23LtfXAmLHk+K4X?=
 =?us-ascii?Q?zL1fWxhXcYio7e9eMHVF9dkhbnol8f5A/izR7E1mHKkHCG3+oXS4+ZpCSat6?=
 =?us-ascii?Q?PS7bDpkxKAE1otB1CIeoSsJMk1Ve0pjDlUkjnAtuFyDsPitKsJszWmv/kC+U?=
 =?us-ascii?Q?MgdSX9mwLsP9K4VPJ9Rd5ObzdgYMSWe6I6MhsUJIge8Grh6pfiRP2z505Cgp?=
 =?us-ascii?Q?bgSxImLy9huXpY96kZBjhg49QtuRd6HbhDRDAIZT5I+vICmaVWZ8tUxZyKSP?=
 =?us-ascii?Q?Um0cd0SfhDlWUE2vUE/et3uB+9ZsDoRHFcOcaiZwUano1e9ZvZjhfw2uLPXm?=
 =?us-ascii?Q?csITIIXfx9bp/SwFHQFGH6/RJidSfskOLPQEEJq7XEXVl8M6aWof/lr7cDeo?=
 =?us-ascii?Q?KDs2e2DRB3bKqSevf8UKZy/vYj0KkAA4vblEdmapKw434SHvjCOqtOjJJGrn?=
 =?us-ascii?Q?3DkKg6GzbCRlGRMtU9qegJ2p2ly3Sv8ggRqN05Gzu192fl6Q8pAhAV+ndHbK?=
 =?us-ascii?Q?RJIhXpmL5WoVZX+1cTMGkJwSPROEoVIjy9SpSRP0JWJz/KbSZ91vU76pRa4P?=
 =?us-ascii?Q?vR3UwNwrzyXfUAUffO/2XcEfUk7+m5aNsv4X6gjjmKkoxkNiqBBek/zZuazP?=
 =?us-ascii?Q?P0fFIlARomkbpn8sBR1MIwPrerbNpokW9wjZhrXh56LhxCWM0DEE59Sn0Aw+?=
 =?us-ascii?Q?RSOjvWyElLEx2EFG/T3EOD94k7wjT4CfKZvvgwtjFmZXL7J52A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ctuNtPXAa+/oqf4c4O5wcgiNUYZ633E+mD/uiCmGE6Bv4zYtSNXvPB9GMbV/?=
 =?us-ascii?Q?9tg0jJp6d6VQSzTraXEvCTPxONF/gxgspMt/XEJpJWdBezH7CcxSddo/Q6sy?=
 =?us-ascii?Q?o/cV+UAReA8pGwtEY5Y5wHFma/UCMwoQ/J44ag0/rGmQOw9rTU4NWiN3S2EO?=
 =?us-ascii?Q?ve1nsggjf6Zt+whDF7c9ew/UbYYLOyuCGxWO7U9I7SaqlUoxlzcKXXzVOupC?=
 =?us-ascii?Q?+uE8FAEOYMcwUK1iADtfH/O5V9dTpnsz45k5uEiNEeYwc/Vcf+h0MFZIhCwU?=
 =?us-ascii?Q?GceljyHcW8wHH6Tzwk+clUmqu4vYX3RRK3WcQdh/NHa4J/jvQVEfHTcVCV1Z?=
 =?us-ascii?Q?IAiNPpaiLRRU9eyqcQkrtOYCezqizxf1CBH1cTUPYHaFMtV2wiXKtyXfT3mW?=
 =?us-ascii?Q?Uq6M8PfbgcdgTecFmdKnjQjqs6lb/mw6lQX2IYHq3juIx/eo8PV+Og/goU4J?=
 =?us-ascii?Q?FnjfImQHIDqFI8SRPZ8cyR8U9UcX0cR0gOeyf2C9iJCRPr2rpWpIs1Q+4aOh?=
 =?us-ascii?Q?kEbGKbymcDJ1DrOJZozH9pxXqkKhiOoV4/PPUCzKQR5aNSHTbibQh52FEq50?=
 =?us-ascii?Q?jFEzNmLtSpK9y0xdmX44UXK+kLBadis/v/kH01TmLN5DdhR/DLxBqYco+9Ay?=
 =?us-ascii?Q?xsy37dXiYURU4c4Kyc1O7eo6OURfLABkjIL2f8L9MqG3qcgPnAj8GNKutPn7?=
 =?us-ascii?Q?13a0FveaEWZoh/lAeubOp+4hzs7D+mi6C0Iyp2J8GpS1azB+IlcIhJZPQyjv?=
 =?us-ascii?Q?DLX4xraAY0mKTdDP+OCwEwhFteZIl0NHZd3zSNGSvgFtcuuE3ltlWyyZE6E4?=
 =?us-ascii?Q?KIW+xdhz8djkzQCXnh3jMaxsTSWvK0Tk7E7pCDHvHHklidpKPVm+hXjrKiy5?=
 =?us-ascii?Q?RZny37p9cMJvWTFCpchB+gxm+ZwucJwuVZ63Mmkhnx4ssczLDxcBLDkC32Io?=
 =?us-ascii?Q?1XQeNfDPM7H28SfWQiMxvaWX3zAl5+5yziN8uw2bK+mWj180vMknmOLjjSli?=
 =?us-ascii?Q?Dng+apw62Qsnso7VRfCVRl0Vmh/8sE0EI00LiKFGnhSG7JxRCxTwLqFm4qlS?=
 =?us-ascii?Q?WsJzg+MSyDxSz2XESQ47VLDAtISzHR3KAf4SicIN1HG+l3jQ9TRP8l3R2blk?=
 =?us-ascii?Q?XVQCz9rKaLXjVwSRmkp4qdhARu7RJNYw7g4n2/RHZmfLhbdHeSL1cEIYfxFn?=
 =?us-ascii?Q?R6Wbi/X0ZV/aY4hX11gZ2ytUh7sf6hcj+ofHRX1Kc1p5/Ksg6jDQ4TimvKxx?=
 =?us-ascii?Q?Vi0VPIWlB7Xld3Ura0KxwZVI7Km9unbNs6fIeQYnc8nRWhckfWr2QetJYYVQ?=
 =?us-ascii?Q?q1kKYXSjkp+wbVR4g1y05EChfwIfPSMypPrCG0k0/BoV8mvt28Ca5Q0BNF7h?=
 =?us-ascii?Q?0bt7htpxG7Lr/F+cURjh84JwVGDFe/fajIT6DnF4YHtXUh4Gb4DLfO69yXf3?=
 =?us-ascii?Q?ocAigMY0NMwTXnORaaZzjjEfSuN2hfNdjvyuq3A6hmWze6k3ftcq2p92DozM?=
 =?us-ascii?Q?dslBQxvZlmq+ctBUBka5gEuxOxzA01F5ku/wfTkbHfWlEW2yXBE/cE9gh+je?=
 =?us-ascii?Q?KUOcfj4Jy2YeKBvjHa1SvodydiU3KeSWyvBAJcwV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M8OHn2F4PE/ceXWad8zCc02RIoF6LtFTk/tOdi6R2zloKhhywKuCGLaALGecM6+di9Uk0GAsPhn/GT9DWi5An3ugFkWIIFturY3YsJlXqswnFDuiqTrkPDhm/XUSOyArsJS4Dpts6+1M3uR0tr94M9fRl8UYGi1m5SEXSLpjO55hkT+yvDIH4yMfSfztIRuXpICDI75TMBotajB0Stc7EUrU6WZ6K5AZAcMVcHJyk79ZW/VsBE/encAXuqVW+q7AflW4I0+e+AvxZ8GCl4fBxTInoyb9QkKMIy/KOk8Mv0GZVq3PY65aN0g+hPiVdHJtIkYHBmekEmWvWMOdgNLRjKaT5EQjHj1pqa7/QtHUuZz5wSDGee+P9H12ILVfPAa2+9WJAvn0c5Lbxmn3G4fC3glvrUwV10wAkfM3zZ/iYhQA9O/VCEWLpV0wy9akx4M9CWxQ7pQAuIA8SM6reqpHDVJWME7Rhziz3rvZ+7pOATJ7I7xVZxRku9n5cJ/UxkzTJAEzdZ88s1RuM5R3rnWvPxY4EGFCmFfIDzvBAv+iV59tEHxiKNCI5abOYzh26dv4evYa8jmHWYM8ln0YkYXME6TlhpKaSCuKc/BPXlMe3usvW/dJRM8DYsiJDoLSXRxp
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18a720d-595c-41e5-b1e7-08dde544435b
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 08:32:30.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+H+yKLp2UM4pHGf2I03vOaToYf2+GUYmQb7mn3OO9DPwzcPX8WVXlypoOio+H5RBKdNkiMtoiZsQ3L7NgRyNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP192MB1579
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
X-OrganizationHeadersPreserved: PRAP192MB1579.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: MLY6AAIyZAu3dZPvQzYNWn0JAS2YktZ1
X-Proofpoint-ORIG-GUID: MLY6AAIyZAu3dZPvQzYNWn0JAS2YktZ1
X-Authority-Analysis: v=2.4 cv=P+U6hjAu c=1 sm=1 tr=0 ts=68aec2a1 cx=c_pps
 a=0UdJJU0ysNg8wLXy93/pzg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=lfzfwBLCeWt4POdeWLEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDA3MSBTYWx0ZWRfXx+lSR729F0cY
 iW0gQzD5fTR0xLChBJf7V8DNGhIftIhwaJ2HUx/mWGOKP+KnUCorQXnQu48mYBX8Oab7GQ8OGLr
 LE5xh1r4BEu86fFVs9sm2XWqIJUwr5jZYUxMflnAEfZ6GzfRueAXYs5+tnsnjAyD+1cJw3P+hAC
 Ek3z6JICTX+5+YGXO8rIOCURRylNaWmOl8+dKpcdfhGvaKnfeg6OnpN9yJ19ZYCHz/KAv1PSLz0
 h145F+GWDCip3BNf/LC1epxN6N0Kb3/r4zcVx+o0250sW/PX7Icgcwti4AQViKE9eKfQE3eaxTE
 RhHGb/XBGaWk5ZGv4OCq43+b59UcJ2LBYPYy2rpBj7/RZg/ZNh7B7HYeJy3Lh4=

Am Wed, Aug 27, 2025 at 09:08:24AM +0100 schrieb Russell King (Oracle):
> On Wed, Aug 27, 2025 at 07:57:28AM +0200, Alexander Wilhelm wrote:
> > Hi Vladimir,
> > 
> > One of our hardware engineers has looked into the issue with the 100M link and
> > found the following: the Aquantia AQR115 always uses 2500BASE-X (GMII) on the
> > host side. For both 1G and 100M operation, it enables pause rate adaptation.
> > However, our MAC only applies rate adaptation for 1G links. For 100M, it uses a
> > 10x symbol replication instead.
> 
> This sounds like a misunderstanding, specifically:
> 
> "our MAC only applies rate adaptation for 1G links. For 100M, it uses
> 10x symbol replication instead."
> 
> It is the PHY that does rate adaption, so the MAC doesn't need to
> support other speeds. Therefore, if the PHY is using a 2.5Gbps link
> to the MAC with rate adaption for 100M, then the MAC needs to operate
> at that 2.5Gbps speed.
> 
> You don't program the MAC differently depending on the media side
> speed, unlike when rate adaption is not being used.

You're right. The flow control with rate adaptation is controlled by PHY. The
MAC should remain on the 2.5Gbps speed. Therefore I wonder why it uses 10x
symbol repetition.


Best regards
Alexander Wilhelm

