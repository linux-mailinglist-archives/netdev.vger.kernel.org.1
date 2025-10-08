Return-Path: <netdev+bounces-228169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9332ABC3B9B
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 09:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 193CA352251
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 07:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680C213236;
	Wed,  8 Oct 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="wnlvneiW";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="lqxlOuH0"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28A1F12E9;
	Wed,  8 Oct 2025 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759909923; cv=fail; b=o50deWnAg7G5GbkqxCV7FFOqpSWU2sp6c+YVZCSD3H0z0xUADLAgoMG5Wg2PcVEOs8ytiPhUdIq1/IC6xLJcRo7GhnjmB1owvMzHaGaEpUy33ih+Ak65tMviVX/7+gT8JreiXmdBlmQALKITESCpit6qXa8GTmUfo4t4xY7WA64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759909923; c=relaxed/simple;
	bh=5dbLdmXZAEbkSkea0etLsSmIdmC+ZRl6PXoMSjskzVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZEbBXk6XkQQ8fp4pWDTCGXyExpolcOtckfhnSqhyb3N+Hi2pPu3yAUdtiNhrT6KZmLBGNP+uAhNA+CvUtt/ffMoy2N3GEPPF6DmKD5FJvFOBUtt+jt9Oc1y7RJT+769F0jWfmV8HYGx/k+/3XnEZI57XCnCKhjqMYQsBP6LhGAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=wnlvneiW; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=lqxlOuH0; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5985Mg6V935342;
	Wed, 8 Oct 2025 09:47:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=EkdH95OVj8ntweOGi/MIkhqB
	4EfFWEVo584uZONszTk=; b=wnlvneiWU1ZAiG0qpma6VDCTn1WQTTvJTXuWKP/O
	At09+azs/JfZm6HZMZxLHs6KPgEOI5tOHcag9Mr76wZvgMq9FkLqqyprBBU/yPcO
	NOc+eH5er0U2GBH1IPYxKdM76kzW3eveKy/9PwU4qBNOLuAnYrWM5owVEpuNMjnR
	Mc7qJd/iU8RWLP0tNUjTNcxKsgudt78sacJbFHp2sgf92W0ZqAjZmochRCy1PBpp
	M4vVDKwe2Xet6cHG0WuU7hhdaPNkAQbvcz82uIA5elPUMEt3sTiDOC4yVkb12pFU
	QDDdDaqP5M1FAONBJJb84UYS6JumZCXXMOlqYrGwiXUySA==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020084.outbound.protection.outlook.com [52.101.84.84])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 49jryfun8y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:47:39 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8jdP9JBh/8i5VX/ozExvjNqAt7DgGexAb1CaR9AIasfFOneDF6kEXt9kLVVIZaMRL9M55GkHt+c4qpYYj8Y0S8R599whShA0ZuLIFRc+t7bU0y44w80AM0ePuJafwiG3vrgHUD/5Ruxt1YslcCv44ZtF+7kMzbHRXBrn0OrtlNBllZK3luEfQFX8ytbED9857D0VNpRZ6l5mZft22sXa81Jk/QWM0WIrCM47gFAImuxwcaui194yumobXvKmTWoS/gIRjzfCcUUCq18InaehVcCkEcepJy9nR0lSZgZi8vjTmDt5/uy2UguGe6CxZtjOIRqu4RqPwBp81dbwZ3Rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkdH95OVj8ntweOGi/MIkhqB4EfFWEVo584uZONszTk=;
 b=QnU3htDtONte4XB7UYAkm5PrNSGZPVIjVSGAZQ76X0VFXBop0i9dXqrpZOcq8ZIFmwDLPWdVEfMRiY+SE57vIDK8UMm0kF3Q42SubHmjC2dJqX9tNFk07mQQylI9JX3JNeeRM3KQdRyXuh4VtztBkmd7dqxPqj3FX3kh2+u5/eqMXPkJ1fV7znzAuvHBIIPmCyOjIIf+zX9zj74Wx/Lw21Gc6gd6XVz50htBPclrSJluix5en5fnaJUpqtfxMuHDFvhsR4adZc/V+KeJDClhKkfHu7ND+Pm3v4AxKBDAfv+0iqlut4zbZhtWmnRhm21yOetW4W0Vt/twqWMaZWMfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkdH95OVj8ntweOGi/MIkhqB4EfFWEVo584uZONszTk=;
 b=lqxlOuH0GD7V6CDFF9S+o76TItuxy3L//x5/V2p/b+NcW4j33LbPVB5KA64amOf4JYpuGP3ojSP6OGlF/ZQVEqOYdNK/ypU7ZWkEKAmsXw1hOGrJJ7iCbYE0whtWYgn4m2bmf3CX13+zi5pxaYsn/z6JCo7j2PQiZcozB6XFeiA=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by GVXP192MB1760.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:47:34 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9160.015; Wed, 8 Oct 2025
 07:47:34 +0000
Date: Wed, 8 Oct 2025 09:47:28 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aOYXEFf1fVK93QeS@FUE-ALEWI-WINX>
References: <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
 <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
 <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3PEPF0000367F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::39f) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|GVXP192MB1760:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbbe95f-9265-4294-5e4c-08de063ef1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgiMSibAPUZDN9NTZ86LoaTcpFJUcyevWN6ojdxKXCHnbrJZumIJFl7SKm7U?=
 =?us-ascii?Q?E58agNeFL3QuQLJeKp8McBScLkkI0KHEolYAurrocnLfQ4MCv7eVaIdneV4q?=
 =?us-ascii?Q?6I8/dGqe3CVWELxaiRlsS98+pSixHvMMvvBul180zk8wHibqfpN6zT7+ZAGZ?=
 =?us-ascii?Q?b0XYoAV1nLrAvqG2LZzExNneliCWfyg1P5fiUQSON6gEvEUf6GQCcBr6uwoF?=
 =?us-ascii?Q?FWTOKz9wlwL4jrvJzdtFFhynlGoyuqalKFY4qXCUiia30wU5/ifHScOTno1l?=
 =?us-ascii?Q?nakJ3euDkHhbhjo2Lavw2cqU0Q79rJQVkrTNcE0guQJg/tU/euvNedrFVhfs?=
 =?us-ascii?Q?8qb/JnO89BF/mHnwRWHeoNl6ZihOUzz5irGHHH10+plhFl1QSpmgE8CmV1OM?=
 =?us-ascii?Q?gSFoaprrtZF0gmFE/ZCFdTuBcFPJHM7Obdx3SnR7pGN7MYFjwYWifF7TINP/?=
 =?us-ascii?Q?gXJxPVjTRf+lNm72/beO/SrMa+CfoSeqg7flnyi87yq44dle5iGj07EiWthn?=
 =?us-ascii?Q?Vg/i9ChUXJXJaYy+riY2GFBeY2nBIUpvwkkTqc3fyompBNE/zzHk2eYj/OjG?=
 =?us-ascii?Q?uML6svGQy6cF3djzkK/KqNmoTiLHppRJL7myl9XCf0eWLRzpTyNF5QFOwJGD?=
 =?us-ascii?Q?qOplfL/9fwtKLifMM5wqF7PcCXx6aKmEghWRBVrtdItIECWxeWesM45qCa0k?=
 =?us-ascii?Q?9Rw9jZtlva42aOg3UwpEpewVNU6FIvOiXRscVDDDjHoqq2pHAEikHNMgU0k1?=
 =?us-ascii?Q?yYyZ6RIZDzRk/v4YK9G4Fwlmvu2Cf4AaumYsZJCY95NT2wXN8ZO715SyWtn4?=
 =?us-ascii?Q?QbVfPq62XCxchsGy6RsUJDnh7CtJA0KSv+n/i70XbdmE5G8VVw43e88qj1Fx?=
 =?us-ascii?Q?r4VInx1pNkIsgt4znGHgPCZ9wdX+nT7OqunKn2eiaXwrO59DlCfJsBin3tZT?=
 =?us-ascii?Q?goeWtbv9bJAAno4tTcBZPrDNYk5qqPhhBqN/rXP/pQz56XpWrh+49dMHPCXW?=
 =?us-ascii?Q?nzO3y6YecQ9ei0PnGRVLylXOp7TQ1g4vcN5rEeLzn3dCJjrOEv1t7OCVzvLC?=
 =?us-ascii?Q?wSrXiRdr1/tyZD6Jc3jO7q8e26AVRMDEaeEepssFxyZ5czhKHCgyQ+K5RaSX?=
 =?us-ascii?Q?OSSvGp5XoSMsUpCC1Q5O0IbtFRvEwnNGC80DC21YbiANmWEQFl/olOtVdCKd?=
 =?us-ascii?Q?3jQYdj3/iJ8sGkvWXwrS3KBMLRbPxmIo+Nb9/r9E22reMtqsQ1T2hAZEFfhg?=
 =?us-ascii?Q?LfoIMsXyboas2jL2lxW/+71amebyPYyIJPVReyyH/ZjmA2wlMccT6zV6Y/qC?=
 =?us-ascii?Q?OUjQkCCCBDAZnyenMURk6FNW6Biud9OzpvgqEoolq75AHE+Unu00zYKoWF9V?=
 =?us-ascii?Q?A3E3+clEX+4C0svN58kv5mcde5RD8euViaw9FKdVBN9HolzY7pshCgmscaIc?=
 =?us-ascii?Q?XOvmk4LTX8v6CirQgqiBMwTpR66F1CKT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKeA7jEGNbib+lQkGcAdOHVS8OMWNqHePKoAfESnBF1k3L6Pq4G/LJZHYHxu?=
 =?us-ascii?Q?V+DM8HLWHBOOgDesXyI5An/6P0H7ymNlMnTseAz26h7QQgIFM7snaxkwFO/v?=
 =?us-ascii?Q?duJy7Bm35eIHlA7VuacbaY+Boi9NMI+Xwh29XQzA3VkOFIWCfFDxVmi6I1RB?=
 =?us-ascii?Q?eqKZNcUlTNYlOqYrxncrrspjUCmTRDh1t7RVZ2egDiPpxxeGYTtJDkVMSv3L?=
 =?us-ascii?Q?GCJMorUO6ELdnlg3Qevw/j3NC1/ScWGG/QGOP0clP6sdHJip1fnzJQxp1/XQ?=
 =?us-ascii?Q?SUPnWZ1hl/uVCb4GtsCcuIeOs6dhrHbhlbLD6OhQE26FTJsHGA4zkQGrGMll?=
 =?us-ascii?Q?V2Po/sWgZHtoMseOuwZfccPPwc0La5u2l8lch5YMAAGpK8lGfcSvzW8TvVpx?=
 =?us-ascii?Q?ciUS1CTcm+bGH836wkAkh9naJiij7rdt27iVYIoKVQ4dkg7aovqWK6rNppv/?=
 =?us-ascii?Q?uEpvHeEeT7NW29EwG/CKc1CP4WNJreJsGCNpgzQuxup+WbtVx5qBbdSd7LHg?=
 =?us-ascii?Q?f1MqXf6Na5XvZScFU8zkktKq9Hwxxt/uXymtNtMLG1tCPL3GpTYzsLyQ6qh0?=
 =?us-ascii?Q?8LWJ6iTjhE36uOO+4uRxTuN2MpmNwrAsapTG+KOtDsLEdRZv0LZmX7HoGhfO?=
 =?us-ascii?Q?7oE2UQF5HwSbj9bkHG/jfncqBAHlxOmOLaoYnshOViq+4RSbzXGj5Kc9fE/K?=
 =?us-ascii?Q?1QkRpbhUi0LgeiK1Hr1GM5FKoM+YNxP5qaeL8nRL3Aoj+/zXOQLAgGdd7Uy2?=
 =?us-ascii?Q?bL0lfnLFUgLN2BzMVWPHEH7RpthNm2NxhEU69tLPWnoS1KsMrK6iBWh62Zz1?=
 =?us-ascii?Q?5+8ac1MRyNc3bnEllCiuMAWj6xsLQdhnTQK+Df+kFskPNvJbTde2iBTHGYzJ?=
 =?us-ascii?Q?8LNTH7VV/gw9hMbLS97DohS12nqzVWMVN0KZgIoV2z6qLRGpsm3IFJkkqBhH?=
 =?us-ascii?Q?R8SWYKUwmmLVkxRWpQv3fnTs6S8A8kXWuG0CYAuFkMUXod5av075gOyDoqWZ?=
 =?us-ascii?Q?RYgM8dIyJ4KP6nEcj5Rlef6eZZBCoNJoBPBK0qLvA4ED/jT9RU9VgMmZDNx6?=
 =?us-ascii?Q?cFe5LGJGjI59Toec+xwC5Pi8NndD4X27J1jEhKSe6iH5d57KlS717P8VRR9i?=
 =?us-ascii?Q?E+KZdF8v5gsAxu6fm7Er0C0vxNH0f+7K4zfk0d39HUoFua+ZT5FzEDSXwSmQ?=
 =?us-ascii?Q?Rarz4R7rD9w4XKmIVjo5X4kOIVjif7WBZtsgmYrps1CVbgve0bWVO/3SmDkA?=
 =?us-ascii?Q?IxVj9BepplSOd+mQEcFkBESYXCiJsQVA2BmTtqqpGCBdYB+JK9rhKhu0PLGp?=
 =?us-ascii?Q?isJxhcoJAxI9tOHUY0mjEofStYNe8LLRnWyB0pnNnsi8wR1i5xlJYhwx5+OB?=
 =?us-ascii?Q?ZwCXUPiGgUy8kNve1DIi8bdaJYJzY5BUzxpEm7B1cx9NMz3E8PbDncu4UF5Y?=
 =?us-ascii?Q?YUHG3nosi6+PDWU4XPGYc1ClYti1/S1ywzJVx39Jz7lT4sWPNSqZLU+fWXJU?=
 =?us-ascii?Q?k8n97dA/qecMR2gm86rgQS0c8b5V205QDuIDzTB7ss/TrUP/VQF7lO7LimEO?=
 =?us-ascii?Q?l8oRz0Jcxhq85Ti92utfmEFCfm3lHRwFQkzNIHpw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gkohCjgB6AFl3I4CaJ6fV6SF3f6VIcp4VPwVGIMHzdJO4vgYeELtpOzp23yZu5gCzIijEMADwJ9zJ/CZVD20cuvRlke0g53b3scgSPvt6EXzO1psHk8RsZbH9JHLnnJiUTFwk7q+OTJTp7zmZTJ7J013ywKIfqtX6K4hADM1GYVTHqiTNc16Z1Q4rsGpWXimNC2GOsk5WJ5T501HBIrgmGETZDuAqpX1Jmrl/Y8cP7YvIrgHDyjcnFo/8SWr99qnejj6KoJMhBIwccTswYkyjYv0ZPmh9Ys6DUwNIw6OBC0nA7snjFOg/1twx/vORSXxwRbB5xuDuTj8VMmIWscz9E2OOk5cn2VkBBdgOHpNLJB8A5E6WVVQYZvi4r3I9+Lv1+U+jwnUeqyu7exq733utekTCjHZms1ZdwAY71QukjISosH9MuedarLTngzvSHHw2bgb4v4ngHS134XrTFDUzb2jW5lub4myFdf79N6LcTjKEKLf0FpcoOYclbgyqiGDDLA5lMXRl62jYQhA8m8A4FPGHoLP6NbN3rnsQPuz8/VJK9QRL6AFqDn4gyZBsf1Sx0jTMpzh6qoWcHy0J2psECPN6AeM6ilW5EJj9Anim6BWKh73Jpztd3Sr8hkgjQ2a
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbbe95f-9265-4294-5e4c-08de063ef1d1
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:47:34.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y62W/Q/6NjrVUBBOn0opNz4CgOajecRvG09JBpsGqKjq19W/FBp8NaoDd8uWHxnwvGpJ/rmUXVVzxj/vmbXRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB1760
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
X-OrganizationHeadersPreserved: GVXP192MB1760.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: VtnK_BG9WwzltMLJpuPvxARfdln338Bt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA1MiBTYWx0ZWRfX+SyyUrNbHEsy
 0ZMbQFjFk0bJBbs1j9r7idwdSTlX2lDZas8ilLFEKVWbqjSN2ZgBbf4y+VxK7Rz6QUboZZnLXYa
 3IspE5QDWOGkn6tEGOiH96TO9uz0iSqWt5ZLtL520CJX7kX04R71DVWbGZQm0NW5m7wgL7j9W/Y
 +6v+csCw3HH0jdpVsVLWh/793XZvE96CvbxBKs7Qie+e9RGsz/Ne3QfSKRZ6Kw5AnqsZywRIdGB
 PuEPOwqXUFAn1ncu+zQXQVRtfdDEwPH6+f1CxNSMJj/ZsLOTDPFMthZZtWDCVTeGFtHVOb2ItwA
 ZXYpkFggmZfjOaKyYcy46Y3FQsrm4/f0iqTonYdb4GeDmUs/MEQ5SZoVQ3B8ckj6xRTN6omF7NW
 CBAbiZHiRzw9swf40NOr2wg7wlboDg==
X-Proofpoint-ORIG-GUID: VtnK_BG9WwzltMLJpuPvxARfdln338Bt
X-Authority-Analysis: v=2.4 cv=Jb6xbEKV c=1 sm=1 tr=0 ts=68e6171b cx=c_pps
 a=aSH5gkV704JMk1CQ8BmRmg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=8gLI3H-aZtYA:10
 a=NEAV23lmAAAA:8 a=kIi0kHNJlgp8Yc8EId8A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

On Tue, Oct 07, 2025 at 05:08:19PM +0300, Vladimir Oltean wrote:
> Hi Alexander,
[...]
> Sorry for the delay. What you have found are undoubtebly two major bugs,
> causing the Lynx PCS to operate in undefined behaviour territory.
> Nonetheless, while your finding has helped me discover many previously
> unknown facts about the hardware IP, I still cannot replicate exactly
> your reported behaviour. In order to fully process things, I would like
> to ask a few more clarification questions.

Sure.

> Is your U-Boot implementation based on NXP's dtsec_configure_serdes()?
> https://urldefense.com/v3/__https://github.com/u-boot/u-boot/blob/master/drivers/net/fm/eth.c*L57__;Iw!!I9LPvj3b!An_LkChNHfp-qG89smQddcR4wAXVZC8Bt69TrktvBZg6BJNUrhH52LbgCRpu9sduQCpqfTfwsnXf8UB6VdHiAOeWo73T1jQe$ 

Unfortunately, I am working with an older U-Boot version v2016.07. However,
the bug I fixed was not part of the official U-Boot codebase, it was
introduced by our team:

    value = PHY_SGMII_IF_MODE_SGMII;
    value |= PHY_SGMII_IF_MODE_AN;

I added the missing `if` condition as follows:

    if (!sgmii_2500) {
        value = PHY_SGMII_IF_MODE_SGMII;
        value |= PHY_SGMII_IF_MODE_AN;
    }

With the official U-Boot codebase I don't have a ping at none of the
speeds:

    value = PHY_SGMII_IF_MODE_SGMII;
    if (!sgmii_2500)
        value |= PHY_SGMII_IF_MODE_AN;

> Why would U-Boot set IF_MODE_SGMII_EN | IF_MODE_USE_SGMII_AN only when
> the AQR115 resolves only to 100M, but not in the other cases (which do
> not have this problem)? Or does it do it irrespective of resolved media
> side link speed? Simply put: what did the code that you fixed up look like?

In our implementation, the SGMII flags were always set in U-Boot,
regardless of the negotiated link speed. My assumption is that the SGMII
mode configuration results in a behavior where only a 100M link applies the
10x symbol replication, while 1G does not. For a 2.5G link, the behavior
ends up being the same as 1G, since there is no actual SGMII mode for 2.5G.

> With the U-Boot fix reverted, could you please replicate the broken
> setup with AQR115 linking at 100Mbps, and add the following function in
> Linux drivers/pcs-lynx.c?
> 
> static void lynx_pcs_debug(struct mdio_device *pcs)
> {
> 	int bmsr = mdiodev_read(pcs, MII_BMSR);
> 	int bmcr = mdiodev_read(pcs, MII_BMCR);
> 	int adv = mdiodev_read(pcs, MII_ADVERTISE);
> 	int lpa = mdiodev_read(pcs, MII_LPA);
> 	int if_mode = mdiodev_read(pcs, IF_MODE);
> 
> 	dev_info(&pcs->dev, "BMSR 0x%x, BMCR 0x%x, ADV 0x%x, LPA 0x%x, IF_MODE 0x%x\n", bmsr, bmcr, adv, lpa, if_mode);
> }
> 
> and call it from:
> 
> static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> 			       struct phylink_link_state *state)
> {
> 	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
> 
> 	lynx_pcs_debug(lynx->mdio); // <- here
> 
> 	switch (state->interface) {
> 	...
> 
> With this, I would like to know:
> (a) what is the IF_MODE register content outside of the IF_MODE_SGMII_EN
>     and IF_MODE_USE_SGMII_AN bits.
> (b) what is the SGMII code word advertised by the AQR115 in OCSGMII mode.
> 
> Then if you could replicate this test for 1Gbps medium link speed, it
> would be great.

For now, I have reverted both the U-Boot and kernel fixes and added debug
outputs for further analysis. Unfortunately the function
`lynx_pcs_get_state` is never called in my kernel code. Therefore I put the
debug function into `lynx_pcs_config`. Here is the output:

    mdio_bus 0x0000000ffe4e5000:00: BMSR 0x29, BMCR 0x1140, ADV 0x4001, LPA 0xdc01, IF_MODE 0x3

I hope it'll help to analyze the problem further.


Best regards
Alexander Wilhelm

