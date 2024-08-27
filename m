Return-Path: <netdev+bounces-122143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9DB960107
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35C51F2257E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 05:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A3D54F87;
	Tue, 27 Aug 2024 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUS/CUXT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9EC1BDDF;
	Tue, 27 Aug 2024 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736309; cv=fail; b=onWuTVdefQ6+SsYOzfmw7Tj+t3R7idWXv4IxpIzZE4QSim+0Uzxb2Jox1m+zmwriN2IbbfOUQzmNUyaBHlA0LPVDbiV1QlaGbD4kA6P8mVgXv6rWyAznxXN2HhkXaflsjEUMaWhDb0/asVF6Pg+TSqKxRpEWq7sLjzK85+7zjY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736309; c=relaxed/simple;
	bh=cKPIwW9txyXk24/OYwjeCMX7ugyXVAnIwRpB0RsUFb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pUNhniXQOtkI7yPvVtzivsnjXIi+iQcWLQnNJbT76GN9dMwJiYbXQ2R130CIFBd8mDkhi20kuU7tWbPClxqnjzB390alo4azMLJ5Mh+WxbZf7RUmpyQribHkTowmwZJu891AH25Aiccxj8aL2i3jtTmmtZK/jq3q29i3hnwewfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUS/CUXT; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724736307; x=1756272307;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cKPIwW9txyXk24/OYwjeCMX7ugyXVAnIwRpB0RsUFb4=;
  b=PUS/CUXTQuluqOWtvy7A6qvjQXaGZLHsyys5CoPCdsI+P1PYWiamXtAB
   sX3bZworwv7FG+FLiiZGoP18ktZKe7z9z9HVNHf6EG53EFaezdlIcFtN0
   YHPg2dYu8CRbNWhyesY2aGthKE6Xw8/Bk3BwYxeN6VAJL7M2zoZT3KLg9
   6i50/V02KkPsIIueeqeGcTtLOzpI99Oadf1/YRZil1Md1C2dwwl3v4iiN
   SNsvC4ymfvggrBh4MnFUtb2viffxLLHO0MTQeboUJHEyxdBCdjKp+/vvT
   nr1wN0UsRPEfDFEz6qnNaEOHCtiGGk5gKiT50bBLtCIyIkQfDtQw7dhdS
   g==;
X-CSE-ConnectionGUID: r5u1yewpShi/CQnJ2oXOdg==
X-CSE-MsgGUID: Ym4VH76XQbmaZvy08aCOlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33816145"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="33816145"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:25:03 -0700
X-CSE-ConnectionGUID: Z0nTSqoTQPGXp0zRIRnh1A==
X-CSE-MsgGUID: zyeLa4NsSz2nmiKpBG994w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62718635"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 22:25:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 22:25:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 22:25:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 22:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDkSKDTWdJ1OWG37sODw0sDnhpSYupiBmS1B13mo7BMR1ekbc9iSp4qgCZU5D9EQwRBpWfnDP96oJmEroyOLLZCtbzr7VCIJbk4fCTdO+DpEKCIG3PT9XhSt2BwRKz5/mR0v4QlEXQUpSPmRxxGB/Zi+eXswmvRIMTtCBQZSW/6c8JcB6/Cy/JUQ7X/y9kCIw4ptnFkYhBLL5lO79rgu80Fh+E3P3UTbVESEZSKvVIh13UTV7Hdc9atsrGLGIdAyWwy6X5oVaY8b7n09E3fiIo5FRovx6OJO4TMt2ztBVckIpXCHprwP4CtfNPSoxMHjwokC1a2K4ySN3SyUZhd7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYy+bCAycDIxzDgkeqDVlKg9Q8Yg508kk40c6h5JSBc=;
 b=MlxtSHH6CXoCCAGiXY3zqwUf0FB91qWjlHliXETe1Mg8oeC4nVWzyqG6kBhNeXHOJrzSH/la7hHINetWS2K3uIj4gbJZ6mQe1L9LiN5YTOT7Pitcm6Bb31O3hNFAttSKu7fBOHB3GyiG+CheCb1HptF+6WQFBih37k4cUkszs/qC40XVc3xq/H4DYb/qM9iXxFt7YluwI9UHrnFMDmrmb5tEVVrZFUs1yiZqy2xdD+gIvyR0C/t7Bk7GWfZ7etZcSOTqwjGAXfnxb3Yxltonq+TOPUr+PcvpzQYeuZYK/U9oIR5aG932awwbvRplgXcp8Nj/6OR9rWLkYW8VLky8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 05:24:54 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 05:24:54 +0000
Date: Tue, 27 Aug 2024 13:25:52 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>, "Christophe
 Leroy" <christophe.leroy@csgroup.eu>, Herve Codina
	<herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, Marek =?iso-8859-1?Q?Beh=FAn?=
	<kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, =?iso-8859-1?Q?Nicol=F2?= Veronese
	<nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
	<mwojtas@chromium.org>, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
	<atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
	<dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-12-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240709063039.2909536-12-maxime.chevallier@bootlin.com>
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd079ba-e2a8-4dac-d34f-08dcc658953a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+3WKPqq5XZTmjSuqPk7mj9N16o8/DXa1VB1xCVYIa/fcboqRK6F+ZG85r6qh?=
 =?us-ascii?Q?crTb4B/ja5qrdbsFPoG1xO8JmGjvA9iCSnrm64mF71HzLYuhqiV94meCQ8r5?=
 =?us-ascii?Q?95K0v9CuWf+kGVePbbYQsHshTAdBsBsnDnbN/Tha1g3RVbsfDuo1gJbl4qEH?=
 =?us-ascii?Q?WQmYGkXX4MdeHqsL4mhKdT9dvQwwWXzVfE8OzGCNtIin719oACnZS3YWERkK?=
 =?us-ascii?Q?TYHAC6L++CVrl67ZBNmd0cJNyLsdzykgSaBzp/nceH9DrWfWDB4HkK6MRbSu?=
 =?us-ascii?Q?2hfNMxcqqIaAQlldoMGuaVPOeF2/ukbzexcSCgClyfvYl0OGfH9Q4TYBFM4x?=
 =?us-ascii?Q?ruLpUEUxgDxVZU4N/3cEiZ9Bx5XQVb5NATlen58SKN7/P2J8vFuk9V16IeZ5?=
 =?us-ascii?Q?nw39WIB2PqwDVw1AovW5ILWV0NL1sO0INY7wI9OXD1LnIN8sM6g+QT5eOwOA?=
 =?us-ascii?Q?FKq3UP+HbXTZNXJijeS9qSeDCxFPeZeKhvAKUHNiepWQ8za7toRnN19/QkdO?=
 =?us-ascii?Q?JgvrscMRDGYdvh5grvbQgC3dNUiGP4nlVKkyYGVcBIgfuFWl8qKrUcO6p18S?=
 =?us-ascii?Q?30EIPVny9cH6fRKG75rh0rBXLp2ifi8wYsFkLJR53xGMJuXhRNSlBf++TN6T?=
 =?us-ascii?Q?ZeM4E7VsQZZ00zLiydkZd+fqTh3zRsw5dmiJzdtor16wKcZmvWW8jnkaLwfI?=
 =?us-ascii?Q?F9KNuKhcEN7MDHhjzaO205XuPKvlt0Tk7V15/gAZDMKFJlnepzxuySt0uPnQ?=
 =?us-ascii?Q?vvWJUclRpRwd3QP7cMNfBgYEK8yTNbk7z6hPGt/dTvLkVH6VYBk8jy02WATI?=
 =?us-ascii?Q?/J/IIZAtv5rgRYOZdnAS+9w62yCvkeW1U2If1DD6+u0aQar5qV8z0kCzDEbF?=
 =?us-ascii?Q?39f9bGTUwX5PwXeZZpi5QUOuO3LucgsK9TAEbCqNjwMhBE/9Ltj8O4tJTofn?=
 =?us-ascii?Q?cH7lPBO84UPYATM6LGo3oHwYQEa/tFFA329D2acKXYYXOUhFFC9mqSaqzddW?=
 =?us-ascii?Q?SODhacslQDcsQ6ZMv6uk2GLdF112J0kPGFShYrXFoMPmpUKuFQ9rh9HlsKhl?=
 =?us-ascii?Q?aX3vRoAfpsG5Jxm2hgSHfbu7Gq2LJWQR32fX82hQ9kFUmMalRkhwXFVhp8F/?=
 =?us-ascii?Q?RLLJkLETlCrWCepcreOKk2+SmDjpDLjdJMHzeLcE601oJvCrhzbZJo3pNh0n?=
 =?us-ascii?Q?Wr5qGoYAF1COrpNcz4W/TZ8a0cYEhzjKEXQXCherGNaVGO+tBrbxjPTXHihr?=
 =?us-ascii?Q?DG0nc/sxZpmvWaoK8of+mLjIj2Zm9GdtmepvYMpbbv7gHChxt+7/BH02eizy?=
 =?us-ascii?Q?WDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mt86LYZ5TUuKesyooltzx13GrrOmE/Uz40rWxAHrvtiaY3AFRmzsYLSW5xYR?=
 =?us-ascii?Q?8TIRb4IQiGRGJr0XiB/Uswz2tE3DVhxuQXqayyo6OSw230Rbam9aZ+QVTz1a?=
 =?us-ascii?Q?AKQ0N1ALGaXBkprq2hO5IyGFxCky5ET9pTxeG/PZie/zhIR2B+kP+nZ8KuBB?=
 =?us-ascii?Q?hLNweRcveoNuBtyVDbN59ZF5NlbtPfQGD3TdfEDyIs3RsrL2vty0fNroxlQ3?=
 =?us-ascii?Q?LzwO0r4/IIMlAZaExAuEIjpE0+yJXbqRr3WupU3R19zSbJM7v8+73u6D00oq?=
 =?us-ascii?Q?0SzK4XNij4EvjTmV4i62LlMj1bYJP3yqXwel+fYQPFvY60Mvi6sN99CVcCUq?=
 =?us-ascii?Q?0fKQX++dZfepyvIlsXCLSTl7ewJ4ff1ccpsRMTirNwtGXWJruZPYSrI2conr?=
 =?us-ascii?Q?G+vKmcSDh/iT+JbGOmvXRhlC0nKL+Cu0AIJ//OafcFF8xlngVFqmHDo9LD8B?=
 =?us-ascii?Q?Y1959yKlKExT6LoeqXQgrmQFKMjvLItWsn9vjfNiTVq10jzDlTvM0TqCV1nM?=
 =?us-ascii?Q?yFqX9qZN4X6s/nf+qo11PsACKclO5dDUPLenmezLu9mJ+sWydSypyLwbEI/2?=
 =?us-ascii?Q?iHT7DBLDLKmydYWdTHLUb+ODUtRwY3yZU5ztivQfi/bE3qEHrYzVqFQbOSdc?=
 =?us-ascii?Q?WjNnN8ARfJMMe8nhVvNCebhofOLrIkRXMmeEXXUu5P4RnAOC1MTm3pq+Bnes?=
 =?us-ascii?Q?0whgqeLMr0M1PI3eHAYrrCzQyprFchJMg2/Hp98xn/a2zY3ijB4FkMf86jnq?=
 =?us-ascii?Q?r/kxfWUbam81qWUbXB4JhN3bRdUL2aSuUCRuMsIodsNf7WXMUROUhEIGnWi5?=
 =?us-ascii?Q?UK8QcYr93D2aZ14ZptD9Oms/VfeGW2Xa0iVeR79Z9K+IhnezzdSQ6jnwtmIq?=
 =?us-ascii?Q?xAg+fWjO8WVKHHiPsrWb7VFnV0kyibRluL/tH9jSy4MGjRjjMSQAnU6tBF/K?=
 =?us-ascii?Q?XMtP4AVFLEhGCp2U7FhNnBBKdhZAxLI6ydQcFPXl8T5G8i8UqR/cuDfKsqYe?=
 =?us-ascii?Q?QATwWL/i4CYQp54xi9dF/dBp0udXeNQEZLvSLMMYSnKBHNi4BOxP93YPQp8c?=
 =?us-ascii?Q?8ffGU9YOhjET7Lh40tqqqrxh+bkzt10+DXPAux80ZcLtHPnKvvbWUQ5jjWBo?=
 =?us-ascii?Q?67ZF8cbAb56QSt4aQvpJT0HLmORJh+Qsf4HHLm/Tgfe+25iskJ4gw++lPggp?=
 =?us-ascii?Q?arUYpbu2N97ygFILgF5VtDVJkeTtShrpPfeXMOgRZ4fwQLe7TM+vJXFm8Cmd?=
 =?us-ascii?Q?pxyJQPIPsAQ6UmTVuI8RJEN6VTHTXIOBmmAu4rXosO7iIexz991x5O13e06j?=
 =?us-ascii?Q?6Ig4APLNVfRGV7QuDchY3DOJLNZzgP/RgAWVnGbjr1RmqjamP/QeDyqK6YXy?=
 =?us-ascii?Q?IW7ljzQjPR3I/2yWvC2/YIOkONqja2bfDH0eWmV1AjEKWmoFUWNwZJlwMLCL?=
 =?us-ascii?Q?QhlnCE6VebOXQ5jLdsrVh2P6NAhMTLXXCohOSWqkp3XuV425oR1VCl1Ygzjm?=
 =?us-ascii?Q?dkhkxh1+B6A6DKCRazlVY7VK3AjMfeu1q25djmc+6dRQEI8nBUaLqHETcuza?=
 =?us-ascii?Q?wf0BrgxiaBLVM+CU1GJVr34nE2BZymYyyKaozYvH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd079ba-e2a8-4dac-d34f-08dcc658953a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 05:24:54.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gLgiRBi7/zBfCeqIFvApHQHkvnw3ZNgvS5jFbbXB44TIH0qdKWaf9RMf3P0CNVoS/Ixd0HRGAMW1O3nmkSCBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-OriginatorOrg: intel.com

Hi Maxime Chevallier,

I used syzkaller and found that: there was general protection fault in
phy_start_cable_test_tdr in Linux next:next-20240826.

Bisected and found first bad commit:
"
3688ff3077d3 net: ethtool: cable-test: Target the command to the requested PHY
"
After reverted below commit on top of next-20240826, this issue was gone.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240826_202302_phy_start_cable_test_tdr
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.prog
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/bisect_info.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240826_202302_phy_start_cable_test_tdr/bzImage_1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8.tar.gz
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240826_202302_phy_start_cable_test_tdr/1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8_dmesg.log

"
[   27.323262] Oops: general protection fault, probably for non-canonical address 0xdffffc00000000fe: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   27.324087] KASAN: null-ptr-deref in range [0x00000000000007f0-0x00000000000007f7]
[   27.324587] CPU: 0 UID: 0 PID: 729 Comm: repro Not tainted 6.11.0-rc5-next-20240826-1ca4237ad9ce-dirty #1
[   27.325203] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   27.325931] RIP: 0010:phy_start_cable_test_tdr+0x43/0x690
[   27.326320] Code: 48 83 ec 20 48 89 55 c0 48 89 75 c8 e8 b6 a6 1e fd 49 8d bc 24 f0 07 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 9c 05 00 00 4d 8d bc 24 e8 04 00 00 49 8b 9c 24
[   27.327485] RSP: 0018:ffff888022397370 EFLAGS: 00010202
[   27.327828] RAX: dffffc0000000000 RBX: ffff888022397560 RCX: 1ffffffff0c6423b
[   27.328291] RDX: 00000000000000fe RSI: ffffffff84482e0a RDI: 00000000000007f0
[   27.328763] RBP: ffff8880223973b8 R08: 0000000000000000 R09: ffffed1002715815
[   27.329232] R10: 0000000000000000 R11: 0000000000000005 R12: 0000000000000000
[   27.329691] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff84482de0
[   27.330155] FS:  00007ff6a8b4e740(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
[   27.330678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.331060] CR2: 00007ffc26df3eb8 CR3: 0000000020c62001 CR4: 0000000000770ef0
[   27.331529] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.331991] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   27.332452] PKRU: 55555554
[   27.332639] Call Trace:
[   27.332808]  <TASK>
[   27.332960]  ? show_regs+0x6d/0x80
[   27.333211]  ? die_addr+0x45/0xb0
[   27.333445]  ? exc_general_protection+0x1ae/0x340
[   27.333780]  ? asm_exc_general_protection+0x2b/0x30
[   27.334120]  ? __pfx_phy_start_cable_test_tdr+0x10/0x10
[   27.334473]  ? phy_start_cable_test_tdr+0x2a/0x690
[   27.334797]  ? phy_start_cable_test_tdr+0x43/0x690
[   27.335120]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   27.335489]  ? __pfx_phy_start_cable_test_tdr+0x10/0x10
[   27.335834]  ethnl_act_cable_test_tdr+0x718/0xe70
[   27.336161]  ? __pfx_ethnl_act_cable_test_tdr+0x10/0x10
[   27.336513]  ? debug_smp_processor_id+0x20/0x30
[   27.336822]  ? __nla_parse+0x49/0x60
[   27.337087]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   27.337446]  ? genl_family_rcv_msg_attrs_parse.constprop.0+0xbc/0x2a0
[   27.337877]  genl_family_rcv_msg_doit+0x22f/0x330
[   27.338192]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[   27.338543]  ? cap_capable+0x1d3/0x240
[   27.338813]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   27.339173]  ? ns_capable+0xec/0x130
[   27.339425]  genl_rcv_msg+0x582/0x850
[   27.339683]  ? __pfx_genl_rcv_msg+0x10/0x10
[   27.339964]  ? __pfx_ethnl_act_cable_test_tdr+0x10/0x10
[   27.340313]  ? __this_cpu_preempt_check+0x21/0x30
[   27.340632]  ? lock_acquire.part.0+0x152/0x390
[   27.340943]  netlink_rcv_skb+0x187/0x470
[   27.341216]  ? __pfx_genl_rcv_msg+0x10/0x10
[   27.341498]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   27.341809]  ? __pfx_down_read+0x10/0x10
[   27.342079]  ? netlink_deliver_tap+0x1b9/0xca0
[   27.342388]  genl_rcv+0x32/0x50
[   27.342607]  netlink_unicast+0x5a3/0x870
[   27.342878]  ? __pfx_netlink_unicast+0x10/0x10
[   27.343184]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[   27.343514]  ? __check_object_size+0x43/0x8e0
[   27.343821]  netlink_sendmsg+0x956/0xe80
[   27.344096]  ? __pfx_netlink_sendmsg+0x10/0x10
[   27.344401]  ? __import_iovec+0x1f5/0x6c0
[   27.344686]  ? __might_fault+0xf1/0x1b0
[   27.344961]  ? __pfx_netlink_sendmsg+0x10/0x10
[   27.345268]  ____sys_sendmsg+0xaba/0xc90
[   27.345544]  ? __pfx_____sys_sendmsg+0x10/0x10
[   27.345848]  ? lock_release+0x441/0x870
[   27.346115]  ___sys_sendmsg+0x122/0x1c0
[   27.346386]  ? __pfx____sys_sendmsg+0x10/0x10
[   27.346689]  ? __pfx___lock_acquire+0x10/0x10
[   27.346987]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   27.347351]  ? put_user_ifreq+0xa5/0xc0
[   27.347614]  ? __this_cpu_preempt_check+0x21/0x30
[   27.347933]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   27.348294]  ? fdget+0x188/0x230
[   27.348531]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   27.348895]  __sys_sendmsg+0x11f/0x200
[   27.349157]  ? __pfx___sys_sendmsg+0x10/0x10
[   27.349453]  ? __this_cpu_preempt_check+0x21/0x30
[   27.349777]  ? __audit_syscall_entry+0x39c/0x500
[   27.350096]  __x64_sys_sendmsg+0x80/0xc0
[   27.350371]  ? syscall_trace_enter+0x14a/0x230
[   27.350678]  x64_sys_call+0x932/0x2140
[   27.350941]  do_syscall_64+0x6d/0x140
[   27.351199]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   27.351543] RIP: 0033:0x7ff6a883ee5d
[   27.351791] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   27.352965] RSP: 002b:00007ffc26df4f28 EFLAGS: 00000282 ORIG_RAX: 000000000000002e
[   27.353457] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff6a883ee5d
[   27.353916] RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000003
[   27.354429] RBP: 00007ffc26df4f40 R08: 000000000000000c R09: 000000000000000c
[   27.354874] R10: 000000000000000c R11: 0000000000000282 R12: 00007ffc26df5088
[   27.355321] R13: 000000000040257c R14: 0000000000404e08 R15: 00007ff6a8b99000
[   27.355775]  </TASK>
[   27.355923] Modules linked in:
[   27.356255] ---[ end trace 0000000000000000 ]---
"

I hope it's helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!



On 2024-07-09 at 08:30:34 +0200, Maxime Chevallier wrote:
> Cable testing is a PHY-specific command. Instead of targeting the command
> towards dev->phydev, use the request to pick the targeted PHY.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  net/ethtool/cabletest.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
> index f6f136ec7ddf..01db8f394869 100644
> --- a/net/ethtool/cabletest.c
> +++ b/net/ethtool/cabletest.c
> @@ -13,7 +13,7 @@
>  
>  const struct nla_policy ethnl_cable_test_act_policy[] = {
>  	[ETHTOOL_A_CABLE_TEST_HEADER]		=
> -		NLA_POLICY_NESTED(ethnl_header_policy),
> +		NLA_POLICY_NESTED(ethnl_header_policy_phy),
>  };
>  
>  static int ethnl_cable_test_started(struct phy_device *phydev, u8 cmd)
> @@ -58,6 +58,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
>  	struct ethnl_req_info req_info = {};
>  	const struct ethtool_phy_ops *ops;
>  	struct nlattr **tb = info->attrs;
> +	struct phy_device *phydev;
>  	struct net_device *dev;
>  	int ret;
>  
> @@ -69,12 +70,16 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
>  		return ret;
>  
>  	dev = req_info.dev;
> -	if (!dev->phydev) {
> +
> +	rtnl_lock();
> +	phydev = ethnl_req_get_phydev(&req_info,
> +				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
> +				      info->extack);
> +	if (IS_ERR_OR_NULL(phydev)) {
>  		ret = -EOPNOTSUPP;
>  		goto out_dev_put;
>  	}
>  
> -	rtnl_lock();
>  	ops = ethtool_phy_ops;
>  	if (!ops || !ops->start_cable_test) {
>  		ret = -EOPNOTSUPP;
> @@ -85,13 +90,12 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
>  	if (ret < 0)
>  		goto out_rtnl;
>  
> -	ret = ops->start_cable_test(dev->phydev, info->extack);
> +	ret = ops->start_cable_test(phydev, info->extack);
>  
>  	ethnl_ops_complete(dev);
>  
>  	if (!ret)
> -		ethnl_cable_test_started(dev->phydev,
> -					 ETHTOOL_MSG_CABLE_TEST_NTF);
> +		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
>  
>  out_rtnl:
>  	rtnl_unlock();
> @@ -216,7 +220,7 @@ static const struct nla_policy cable_test_tdr_act_cfg_policy[] = {
>  
>  const struct nla_policy ethnl_cable_test_tdr_act_policy[] = {
>  	[ETHTOOL_A_CABLE_TEST_TDR_HEADER]	=
> -		NLA_POLICY_NESTED(ethnl_header_policy),
> +		NLA_POLICY_NESTED(ethnl_header_policy_phy),
>  	[ETHTOOL_A_CABLE_TEST_TDR_CFG]		= { .type = NLA_NESTED },
>  };
>  
> @@ -305,6 +309,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>  	struct ethnl_req_info req_info = {};
>  	const struct ethtool_phy_ops *ops;
>  	struct nlattr **tb = info->attrs;
> +	struct phy_device *phydev;
>  	struct phy_tdr_config cfg;
>  	struct net_device *dev;
>  	int ret;
> @@ -317,10 +322,6 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>  		return ret;
>  
>  	dev = req_info.dev;
> -	if (!dev->phydev) {
> -		ret = -EOPNOTSUPP;
> -		goto out_dev_put;
> -	}
>  
>  	ret = ethnl_act_cable_test_tdr_cfg(tb[ETHTOOL_A_CABLE_TEST_TDR_CFG],
>  					   info, &cfg);
> @@ -328,6 +329,14 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>  		goto out_dev_put;
>  
>  	rtnl_lock();
> +	phydev = ethnl_req_get_phydev(&req_info,
> +				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
> +				      info->extack);
> +	if (!IS_ERR_OR_NULL(phydev)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_dev_put;
> +	}
> +
>  	ops = ethtool_phy_ops;
>  	if (!ops || !ops->start_cable_test_tdr) {
>  		ret = -EOPNOTSUPP;
> @@ -338,12 +347,12 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>  	if (ret < 0)
>  		goto out_rtnl;
>  
> -	ret = ops->start_cable_test_tdr(dev->phydev, info->extack, &cfg);
> +	ret = ops->start_cable_test_tdr(phydev, info->extack, &cfg);
>  
>  	ethnl_ops_complete(dev);
>  
>  	if (!ret)
> -		ethnl_cable_test_started(dev->phydev,
> +		ethnl_cable_test_started(phydev,
>  					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
>  
>  out_rtnl:
> -- 
> 2.45.1
> 

