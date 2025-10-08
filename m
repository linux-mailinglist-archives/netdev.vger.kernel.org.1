Return-Path: <netdev+bounces-228227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B761BC532B
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29575403C4F
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F12848AF;
	Wed,  8 Oct 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="OfKp8NlJ";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="gWvqj7+j"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29738283CAF;
	Wed,  8 Oct 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930115; cv=fail; b=Ng/tYu7snzZZp0eB6sL8fDpdaRwJOpQLVf/TOXxYAoa8quM3KMFt0+Gd5KaO1Ew2TDdGXPPO9yOUvRs8oLR8jrpZ2eQ2IkkNWRRfyOyfXlOxnSHZ4aKaZvFoMnJAKeaduAdF53DrK9cAVvHgd0ohbWr1rCgvCP+UOBm1ORbkr5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930115; c=relaxed/simple;
	bh=r+yixmqn3mAcEAyh/IN770LNRJYJ5pXYFw2Wpq8kA1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KlyhFu6JDijsOVbpUg6QMpnm+HhtEEed/oh+FB9wRxfRRnlvntZfyXqAz+e0sMLMw5XuMDZXMLq3KLpqVZwAHf1PA4jE76r0bo+7V4I5zh4b9B2xAeOQdH1NYGJ9kouzDmJfvxJVky3sFhteDbN6VClxsPV6MNpPGhWjKnd7wdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=OfKp8NlJ; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=gWvqj7+j; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 598BoQLS1565372;
	Wed, 8 Oct 2025 15:28:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=QA4z3A++2U4gIo+8YCKJqvRA
	rbRxPWb0RRrenKgUIPk=; b=OfKp8NlJ6mxwaBI/xbg7eM1WLfuqCW7eKD6cXy8t
	ULmyMHIaZ5CluV3tMVg0VBpT8/GM2PQD8Xti5jIpah+0C1AymQUdCdk50+btn7ZE
	xcj+QdU5KhS/emQEBsfvUjyIiaWzjEFBguctL9/OGSW3Sb+OFwlbsz/4djA784ZG
	twbIQqrnrsbUdS/X4yKb+Z89THxk1fUp/i7rveSwX22kNpgMY4fs1RmprDcPkhnw
	VOwFFVwI1CsW4wTwEPbrsl2QdMcSOGL/hN44JQDjX8nell0JXUPekYEYkmS3MPT5
	FqgIyCnbWMX6DgpZvWFzL3Ea7lLOUTubcySRvdSDz8magA==
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11021121.outbound.protection.outlook.com [40.107.130.121])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 49nqefg2yt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:28:13 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv7rUtwsXdcxE0OLQrKD3Aykuj6aVGV3LWsMj+5tY1fgm7PecdhyWJ/+fTgn0A/2XfEQzz0PBDfSIZOgvPWwFS7djc3CrRYDjjqcwgLsnyxWXCZhmllCWVz+ewTdujqxlTtYboU5mupibl7XXM56Z1HkRY3Z2G2tipRJSwi5mYLg3YwkJOFXjIfRDpfvl1mDqNw1Tt11LXYeRZnD9Tq7YQCcuUPLNa3j8QVSofZ+nWmhs/GLme1olBgx6EH/TXU+gRchbEPNvz2wtRgv/DvAeFEJc4NxRk+o2IomVcqtm7UK+DIJa594QLAvYT9j92SXC9+pJgaNTPpVsl9LWkRlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA4z3A++2U4gIo+8YCKJqvRArbRxPWb0RRrenKgUIPk=;
 b=c05zP9dfYRFfLm0WkeXq3f6EzBsOCFx2rBonksiEvOgIEe/nEcsA7c12TVM5DtpCXiSZwoT9h2HUPi4Io4yjOqXfrkd1Jz56TyVxu1DvazpK8QPanZhEF9dCqrftPqjkYC9wySosuq5uKxZmLzdnHgXwSlgl8/E33HKOgW2yCVvemytMQdE0ANZzmuLwEqkSOuHYTbCDlO92mtecQXOG7B5ITK8oB621w/ekPX0BWgORxprJ0Fh7yaDHd7PJHWBm9LLV0W5KtHuE1dOxWjuV6VmPcIsdI6FVrh6fctGXlB7Mp3jzzVZVv1iicK5YPbqedS9NPL1Fy6zXxgJ8Ex6XWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA4z3A++2U4gIo+8YCKJqvRArbRxPWb0RRrenKgUIPk=;
 b=gWvqj7+jgG+g1gCubC7GAk9fbv8l8L1zsveNtUzmtMFvuxvDOSZuxBilZ2r7zYzi+PwNEype5lY2MEeqfpScLP0pIIlUD+JQy99eQpR+nwaQQHp9tsxTJ44RVn8GbDom3fVSrhzluVmQbHYjRUde2YVNtR2qflV/RqJ//ZHBz0Y=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB9P192MB3133.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 8 Oct
 2025 13:28:11 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9160.015; Wed, 8 Oct 2025
 13:28:10 +0000
Date: Wed, 8 Oct 2025 15:28:07 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aOZm52L7k2bAEovF@FUE-ALEWI-WINX>
References: <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
 <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
 <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
 <aOYXEFf1fVK93QeS@FUE-ALEWI-WINX>
 <20251008111059.wxf3jgialy36qc6m@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008111059.wxf3jgialy36qc6m@skbuf>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF00003849.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:7) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB9P192MB3133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1324c7af-fd16-4950-0b78-08de066e863c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OuJ2zV+kBjmHHQjwtW7T+ApEp3J60ABvUpnDVJzTOTtsvdZ+UxMftIHBzDfp?=
 =?us-ascii?Q?QhqhQ+VXOoyZfVkhhJz7geWlt5oIgHGlqsP/UslbXVvdRiPN6vDdk4CYpMAE?=
 =?us-ascii?Q?zvI6M5WNyB4y8y0/Fc9ZJ+m1Wi6lL5Fc+iTZj7ofsnYk7XVTeZk8ra2WX6ns?=
 =?us-ascii?Q?PPSZ5Dv2jEIrB98pJt+duUwf3mflBHP8m96V9wuC/z6h7+gePZdG3/7jq1nb?=
 =?us-ascii?Q?moOC/KpNoIKDIAoUnkVicHjlpvlDMPYnO2MqHOCSoVv6Pdz7M4EDYJsFk4l3?=
 =?us-ascii?Q?Z5cbKJaEy5rb+mHCaZJ8RwcT+yCSZhdbmPoXGsgdhe7McC0A+gmN3QmGQg3V?=
 =?us-ascii?Q?lyeeXzAh1eV9up+YnLG70nJDg5FufzNHOqa3T4TSea7ZsL52gtypAr8d2Ldl?=
 =?us-ascii?Q?KRlIhvibTcKUoFJwBUPqUIhUSkRClMEvQGzL+NR9Vbh2x/kQgA4VRbirOicq?=
 =?us-ascii?Q?x4ApMYus46RUdkfX2KockCO1JAF+ccASVSHWhb+HeNHMvR2Utdu+QqBoqk7x?=
 =?us-ascii?Q?rcFu0S9tg8IXUfaqJI5Zaf5f99i15V3twN7PrPzgejfiV1vhNge/zQUtb4w3?=
 =?us-ascii?Q?u7QK6BIAmrtsKLr1K8JDEnuwNAPn+w+UgIcvKXT7L3YPEhsCzz0KWnQ/7sxR?=
 =?us-ascii?Q?8xQLLdMXphsHRGUvgkFJLqkqEZ6zIhpC93wEC9LEi8+GGNuqGMzpQVIpz78K?=
 =?us-ascii?Q?67lQYKMoMwLpgeDjH1mB8QYMqzbAigaHL6Kotzm5vPDu9I1E8ZvLBH2Zeeau?=
 =?us-ascii?Q?akqUH7fvZGJ1kn0OviX8RyFpci09Gedr6L/5Xsm9gN0Zx63vwxnJgCoX6u97?=
 =?us-ascii?Q?+4D5aScZfLAnUFEtwj1aDS/D9ZPRMLs8zw8P/uma830hsv+UNwF6md8ArK7L?=
 =?us-ascii?Q?KIatKkkJpz7hcehlXCR9O5WXvfHPvDaOKNazjcv3qOIxPuB4dK9OrLVLLfqH?=
 =?us-ascii?Q?xdRPPPedHRsKWXD2/KcIOA5Y1bQ24cVIWtbsoBU0qWH/87y0qlRetiYlMQZo?=
 =?us-ascii?Q?fEGUUVvOJvdO6OtNPL9p5adwITgLFgq6IqZITDF6bMniHjoMSZQLNayvKpGZ?=
 =?us-ascii?Q?DllEx2yHtoJxnP6CCO22Km0qR0VI0RCxWbvV1fcck2G+lQh6ncdY6P49ore+?=
 =?us-ascii?Q?a/bTL7/kg0IBaK6uH6H99+LVeT+J6Hz2DORa+JonuyUV/pgtT1BbY3HKO6Q+?=
 =?us-ascii?Q?4JPjhbblEpN3rb0MkT8gA84xy/zuLSyM6D8Z0G2j+WYddtKtd+A/tn0wmqhV?=
 =?us-ascii?Q?A04Ei8LeL5lN2qy/cSF6t0umyEvkE7HDqJt7Y2CWvr4REOuTgCr831GdUQVt?=
 =?us-ascii?Q?NnUtYmG/1niFVEYsgAzYdV7/2CLY4hxXg4lkfK02Shm8GjCE0iYQ1ikmXUOT?=
 =?us-ascii?Q?k6m3endgpsFQgR1hFx7fdUsFO5gmK0PIWTog9njZSrKSFnF+rqb8N3N6BpMU?=
 =?us-ascii?Q?DA2dGOg0p/2BV1+NrcDczEf8We55txWV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FM+5+KX/jIJkLGqjask9oBgJHR5FNrJOfdZ2KIIN7dQR2QjxiR7rAici7ePi?=
 =?us-ascii?Q?W/x98Pgqr2Ls2aDv5m9Wih8BZJGSSyxEiwsocmEPwbNvrSeEGERdUocYvm94?=
 =?us-ascii?Q?A6HedjpEq6aVHPyKs4/hCyssmFoHjyDnWXnZJx1KzlaOwTCwr0Rq4puZV2a5?=
 =?us-ascii?Q?zbB9q/FOnbaPLzCBB/bexd9URrPY6uG3uIOYoOZagRk1GjEKJiGaxwgVTUu6?=
 =?us-ascii?Q?G9YUFItoOuOSZnAjbLdyQUyM8PU7Tj4cOGIqeYgKS5Zn99FewR6N9VvisD1N?=
 =?us-ascii?Q?cb55M9zJPtGhyD9hpXUITKf+sF7LlQF+Y5TzeOUZ+8Xwkrnt8yu0k4ImKR2p?=
 =?us-ascii?Q?oF01xAQMQXs7RaydLe1IP5jIKYhtX0qjkqMpLkBWdD5CMiwBMI7PytKFTQYO?=
 =?us-ascii?Q?r1zsAMUPKZ42cNudmR4guQgWAISfDfVDD+a9q+WFXxlDNbw6Hd8g1PxGTuxF?=
 =?us-ascii?Q?YTYWRBY8FNYRrBBXvDFkjsZAqpy/4rLA7TBUeVKTd6kS8juMNpMUCbkvJ3Se?=
 =?us-ascii?Q?e6JVpw5w9Cd356ipUFOCD6o074ycot8BhhkNV/dMIP83RkCnf4E536Ia5d7I?=
 =?us-ascii?Q?i5gIoZyWrpbo5dYk/VmergcAKa2P2dVTyP3aTnmooQiKicFT2iAciT3QX5Dn?=
 =?us-ascii?Q?Pe57xGYW9BKo/LLvU9YaeLxy0Qd/iKuB7ncYduZBwA5+dEPtbFuNMWOjlPEc?=
 =?us-ascii?Q?+j6b68bcDy8YbqFR6vHuHrY2aMR9juuYHEZMrFJgrMOydwa2sccFomK9tUFf?=
 =?us-ascii?Q?6s9tqwMaDbCVa9f2N7oeCV4L1NDeZoHZgja2EnUI8UHBffFS4hzjPAMFwleM?=
 =?us-ascii?Q?uHYD5B6qIU4iyr+ecu7bp4asTGMI6fJNam/RirzZj2lndAxjRSlrp38wP3ri?=
 =?us-ascii?Q?IFekYy2b5x/x3LtG6OZF2YtDKS0WzM/llnKd93fRefKePpvn+R2qoRE03dtK?=
 =?us-ascii?Q?wVoCFwFFYZUQIf0Oz2pqjnMcVvUEXZT8hKaE0w/cniqG9sOHyXTHIK2kn1hv?=
 =?us-ascii?Q?GSxT6RGFJELnqedsMfhEAp1BOWWGZvDiG/7/YAZSUGOH59FV90VhlXvdix+x?=
 =?us-ascii?Q?GvoAdLtClG9Tr54rwVeqwESICIDBw77oJpEmAqgzbfPP8pH7ltLkOEeA0T/u?=
 =?us-ascii?Q?KkMmsSm1juUag0/rFgy6jzpDwH2SikvM7gEx7PGZEkTR244bWvNgkGwzc+EO?=
 =?us-ascii?Q?Tvtsy78j/AWp8ufqRpMb4GGtTNTzaqnDibxoOvVIhswA7nsLtbElw/gDy7t4?=
 =?us-ascii?Q?Oy1nu3Qoho4WS1ceDJivsGd/zgf582wM+H491TuqNx4cmrV7Vz392gKHzpDh?=
 =?us-ascii?Q?xLRDyBdtfvi6n3+z0iTs6Unor7IVIVS+DJKgFmRzYZEcPtqXvHO18vYHN1nN?=
 =?us-ascii?Q?R9gUUEqlYjFnIpWVmB/mpk0kcrC26kxfTxEeis2S68y/EkbyiqxdZykSsLa3?=
 =?us-ascii?Q?npdYXPKjA9ANWqQGITBDrA/GVU05JidkIU+K4A/2YdyZiyQ8XU5Ds8PFBvHz?=
 =?us-ascii?Q?kUCswhuNYF8Wnx8dTUlm1cThgPYxjVWfNr+sFDpWwz9Vj515W/EN/OymyHs6?=
 =?us-ascii?Q?2kWARqDrQvFBau7gJcOODlb49taDeELUc6Yq8BaI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	COad+HjsjR09f2xGYa70s9nTNiYhIXaS++R6FmTtjeAoPATL/A1FfYiI5dM4boqBQpZj+NQkxJFwrG4eby8HNvLhAZQaC4v86WlURybDvcF4Q6ZEp8T6vbmV5uU/8/0RNiubMu28bt+dOfutheLXKvVvTXi6Zm+c3oClkLThz/3Oawa16XoQVRlsKVsuqLeNwKgCyTurJVd6m+KwBkvL3xcUlDqBJCNyIH0O1iRh1ZZEpb7v2ojEgHyT+Z1I3jJTi+g3qxShgMx/dQXRmwua6vodD6YvBEmvhPGf/KoPeQRJM4D4VUiikR7M9Q+ZvC9oXRUP49LNETzmMnnHMtuZYz+SVlyUtOj8zAhB5rnxvmNK9owguyENMDVbKaxLBJILmtQ9aW3CNorrYmM9tcGZ02os23N1HsL6bTUDZbPoHjHddquAp4EP/mb9maqMoqlqOt9ErGfApx331DYNigtMYfLK7eb2hrzXAgeAw91nENgRJBdpAHok2b1wmI2GUVu2uNxMDdynXKIwjxM3uUNjs7NNt46uFHKnLJC5kOo1F6pJH0wIsIJAAkNS/JoYyNZ5efzVPVY0NygUMu6037RFxOs/b+UGzVVkJa8nBocB0KLy9dHq5WobN1zslw0s5wuQ
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1324c7af-fd16-4950-0b78-08de066e863c
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:28:10.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq0TqaH9xj0qskzk6AxrxzfFajQ7Hh/Tpb7qClJQGHUd0Wbo7Tym8TD/DxbrfV6tlxsYI9M5Ul7I+cXK9ayqMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB3133
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
X-OrganizationHeadersPreserved: DB9P192MB3133.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA5NCBTYWx0ZWRfXyXrSqTYXq+wE
 nhNco9ouV3GvbvUAZpgGe2WRIUMjUUsVddB25Yci8wFOBLO+1bsLWwWaLba+GaONxcIxabDysR4
 Vd9RyuTMpngECCEW62BoPkPcDW/YbakY0RH3b2CL3A18RP4gWgwtNYov2ph5mpzCzw3/berIbQb
 elt876fvNBp4LiQoseA5huJkSYWO2gznmQdFxvHtFATYenau+hO6qwAXXVGhhZ4b9GKfcoFzPCU
 BqJqAfEHjmuyZiANVpd52LibqLZznJgFYjX/LUmSe7fibzIuML7Ophq/HYtPcsZ60ZiEWWNN2eI
 H8dPyDOEjgjIHaGZ3kc+jqgE7k59IkH1xJr5XAQCqCK8mi25yUElt134BdOs9nzXiRzWU1USgfG
 2+o+8g1mRIbTQ3nMVKdptGPFHTj/sw==
X-Authority-Analysis: v=2.4 cv=N7Ik1m9B c=1 sm=1 tr=0 ts=68e666ed cx=c_pps
 a=BQmd26y0tCbrurBU5lHkxA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=8gLI3H-aZtYA:10
 a=FjjS3ZkKv2GPvmZrneMA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: OKwttrvaN7P0fKysbY5lREgN3XpoUIJq
X-Proofpoint-GUID: OKwttrvaN7P0fKysbY5lREgN3XpoUIJq

On Wed, Oct 08, 2025 at 02:10:59PM +0300, Vladimir Oltean wrote:
[...]
> For that, please break the link again, by making the following changes on top:
> 
> 1. Configure IF_MODE=3 (SGMII autoneg format) for 2500base-x:
> 
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index a88cbe67cc9d..ea42b8d813f3 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -152,11 +152,10 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
>  		mdiodev_write(pcs, LINK_TIMER_HI, link_timer >> 16);
>  	}
> 
> -	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
> -	    interface == PHY_INTERFACE_MODE_2500BASEX) {
> +	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
>  		if_mode = 0;
>  	} else {
> -		/* SGMII and QSGMII */
> +		/* SGMII, QSGMII and (incorrectly) 2500base-x */
>  		if_mode = IF_MODE_SGMII_EN;
>  		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
>  			if_mode |= IF_MODE_USE_SGMII_AN;
> 
> 2. Edit your MAC OF node in the device tree and add:
> 
> &mac {
> 	managed = "in-band-status";  // this
> 	phy-mode = "2500base-x";
> };
> 
> This will reliably cause the same behaviour as before, but with no dependency on U-Boot.

I have the broken 100M link state again (IF_MODE=3). Below are the debug
details I was able to observe:

* With 2.5G link:

    mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xdc01, IF_MODE 0x3

* With 1G link:

    mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xd801, IF_MODE 0x3

* With 100M link:

    mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xd401, IF_MODE 0x3

[...]
> Regarding my patch vs yours, my thoughts on this topic are: the bug is
> old, the PCS driver never worked if the registers were not as expected
> (this is not a regression), and your patch is incomplete if MII_BMCR
> also contains significant differences. I would recommend submitting
> mine, as a new feature to net-next, when it reopens for patches for 6.19.
> I've credited you with Co-developed-by due to the significance of your
> findings. Thanks.

Sure, thank you.


Best regards
Alexander Wilhelm

