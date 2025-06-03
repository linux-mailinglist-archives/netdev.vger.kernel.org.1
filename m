Return-Path: <netdev+bounces-194742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F5ACC333
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25CF3A3D53
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596D281379;
	Tue,  3 Jun 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3srCh39"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26266280CD3;
	Tue,  3 Jun 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943305; cv=fail; b=PKwQ3QtX/p5MXKHt8vx4iAEqVJYzZRI1heRQQHKE2RkuGMC8PsLtvng/cx38AjED2StFkvN+aSn2OqbJ3RUZDYIWbooMMfYNdQIMKrT4mcmNWbY/mKToqeRsuchpkIa7su5Ff4H0YGBC7tNYwFIJl3H9ajVcbk7CILiKIWGiVi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943305; c=relaxed/simple;
	bh=lcTN9u6U4wPusoDgHmbxmQS3Vq4FBbZ7GEpU0JUTJOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pBmzL5/j4NZ3v0ELOe/p5Um0TFi04w0226hjpSO60GSvYWMhIlniiql4J7txphT0+E4ZbWuNdTqlwjoVlYfafdfTGvrpwfGxr/n75giWsshqbwmbYgYYSdthVnyyoiBHHJWcZYbn8LzL5XiuOp45J8ouwsJD7Ik/UmIx/c9eOg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3srCh39; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748943303; x=1780479303;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lcTN9u6U4wPusoDgHmbxmQS3Vq4FBbZ7GEpU0JUTJOk=;
  b=a3srCh39NjzTZ5gj9H6QuzYAA54VZSNuapvzHdgWOT8Jp1XeSGtU2D4x
   WZfBx0GwdUUc+RvmziGAfhGY0HmrvjtpVxlz7p3Lb9aPRAaX1ybwIg97F
   fQBiK5iOqZEjde5qDgaSmOAkQpUUwHl9sr5ws/stTON17erKA4+BexBSh
   we5ljSP5FSmv3zdPVdv5sBG6twKvcpUGl9v/P54kKdZHfN0rPTsJBINey
   hlUNJh7QEpbJdv3bT82qXU6z6SzniHFN1hLwb3Gck7ePIBwjQEUSRoD8U
   nb4NsWfsDasnu1h82sP1pMp7h7KDx0hvyl9qrybJLQrhUVTXAq4y7vKLB
   g==;
X-CSE-ConnectionGUID: sPEBFimOSyOuM/T44ddQqg==
X-CSE-MsgGUID: 3Jl92geWStiUvsSXCsqGQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68528279"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="68528279"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:35:02 -0700
X-CSE-ConnectionGUID: tFM9qJzDSLCz97Rq+DolFQ==
X-CSE-MsgGUID: wRGssukAQnigw9ZAJBibIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="149854668"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:35:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 02:35:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 02:35:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 02:35:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOuSg3k1Q+GbskNsou52p7F+WOVje4YztdmCFFBo9MsMSzwAfIfJpxVYLJkkF9fSQtk8NQuzXBsp1r87Ycn/I1EgOCeWda2XDnX1/NnbC9ytMlqB0/Wigs9x8AorimIYkKuLtQC9vFSg6DhjQ5CpXPhRYhB3RT0bJHRIgCy1q4CuRUivVW6KiHzMlXPB7t9o8W4wbqaC7xJYqmPilW0sNEg22Ja/OJrhGzj0TSkYg5SWXEKpLMSuCx90WJpRnhxgyVLjm2INMV5cgGcqqY2M70nDfW6Elvzh4mHA1AM6yAuToiLKAS1IBNY4uZXsusA2X0kgi8wypuxCmg851vGguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM742b0q5QSASKXaDs+ReLU19wmUAKuFxDoKhJnUZR4=;
 b=v9JKd/U0Fx4VTAKnVGcAafGqWbztD3yic85kepOTAMJtkGYq6mG+d4MMM38QZu8Z7p8rmBqXOh+fjhPkV9QcrpoVng1XHdVoIQBblRNUXaZ+XmEkGNowic1GvcEKAp+rqjeRXsyq6ZhiPeiVkWpycnFf80I7/4iFuhCtodLCI+cP7qqke3jzLiBrbJqOT1L+ttKCN2TsYLp0RSTR4B1G7vhjP2Td6a/XUn0t5uN6oDBlGYkn0Ao7NWGP6fGQ+BH73yUyt9IJx7ccrtmaZIsW1IlQ1EnRGQN3xgLKIYUuVPmVhsMeNgGyHM6J1mzlaFb+fEHCdht965K5IIimi52t7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CY8PR11MB6964.namprd11.prod.outlook.com (2603:10b6:930:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Tue, 3 Jun
 2025 09:34:52 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 09:34:52 +0000
Date: Tue, 3 Jun 2025 11:34:40 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jinjian Song <jinjian.song@fibocom.com>
CC: <chandrashekar.devegowda@intel.com>, <chiranjeevi.rapolu@linux.intel.com>,
	<haijun.liu@mediatek.com>, <m.chetan.kumar@linux.intel.com>,
	<ricardo.martinez@linux.intel.com>, <loic.poulain@linaro.org>,
	<ryazanov.s.a@gmail.com>, <johannes@sipsolutions.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
	<corbet@lwn.net>, <linux-mediatek@lists.infradead.org>, <helgaas@kernel.org>,
	<danielwinkler@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<sreehari.kancharla@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>
Subject: Re: [net v3] net: wwan: t7xx: Fix napi rx poll issue
Message-ID: <aD7BsIXPxYtZYBH_@soc-5CG4396X81.clients.intel.com>
References: <20250530031648.5592-1-jinjian.song@fibocom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530031648.5592-1-jinjian.song@fibocom.com>
X-ClientProxiedBy: VI1PR06CA0174.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::31) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CY8PR11MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c705f7-f499-49a4-0bbe-08dda281e43b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WPyRM8yfbwiNeCBehKeqDyXD2RVD61bHtFFR3KhWtYLFFuxW54FAz/RIVjul?=
 =?us-ascii?Q?jdPcll14m7uziGDmXm9vZoS1MS3FeQX5aciS9sf4GPkBO8HJgqqeuLpOQ1dm?=
 =?us-ascii?Q?LNtZLDII/6ACTyOXws27VXefGlR69LaquvnU5ikxUMwpaKdGRIL2SNbgo4cA?=
 =?us-ascii?Q?JUpf9j9GZYV2ZV+BkDQ8tvoJdmi6vtVt85zvYT+vGetDWmH/H2zH6mCsa8Jq?=
 =?us-ascii?Q?ooKDWOUmhvy9Y44Oq8qj9UzCHFNhKkk2PXUFFwdwWqgf3nHl5SjRnM5O/Adj?=
 =?us-ascii?Q?RFdHsZg3dI7RewuuYZZl/P5eus8MGOYJffZSFRt4Gyg+sdUkR+sFKCygGULG?=
 =?us-ascii?Q?M3SQ1w9sLQ8M9fuwyS2eN9MHyY7kTA/aM5ruv6/Uo+XY0Rf3w29S5mNRKqOk?=
 =?us-ascii?Q?SSvvugLkFqUFBwadkW7rXPtevc4Nes9i6Fg3qz26ntYxJtt7ayFPWVnOEbQE?=
 =?us-ascii?Q?ioaYmTqEBrWU+7+G5bhrElxeM4kV5wFErXkarkuMNA8U41mLAmAz1/cphz9R?=
 =?us-ascii?Q?5OYwE4lNUhZZEcPgs1mjc1acVWaxoBcuClK0FZIdhO0EYqcxkUv+5Ptm2dmh?=
 =?us-ascii?Q?0E1F1rcEax9EbWTbDq3y73GHg/p/bmubNdkVvFOSnWoEIyjdEa9QZUN0zX5j?=
 =?us-ascii?Q?/Ug6+i+qFmT3gk7xhQ4fwNVju81V/XtPzL8GyyfuFBHzl2eN12hje0jr6IdD?=
 =?us-ascii?Q?B/SdIkCBgd/5JePBHtwjffJ19KDztOGcXmUZxPtYFFIjlBWAJtKtjZVPrjAZ?=
 =?us-ascii?Q?R9F6UG7Ir7e3q1UjBAStTIkX9XTLRe5np8kRqDOFavoSkc6opDeZ+b5kyxa+?=
 =?us-ascii?Q?mAzWOTzAC2mizn/8CUQs/tOVZ4cL9AFYMIx65q9s9JTK56cx2uNIxMHo6ldf?=
 =?us-ascii?Q?aFmlULnL119ee/slbGgXTrh4fQ6GFr4izaGXN/sq2cRaQET54c+EDyTi7yD/?=
 =?us-ascii?Q?EShl/y1rgEsrtIuMLxdK7eWFM4gF7iwi2F/N/6l3P+oeymo5uehy/PAEjuaQ?=
 =?us-ascii?Q?cj8Q06iawqddQV/BHSeyfq7ZDSPV5D4wpDWyaINKPTOg4P+NBKCTNzToHj6Q?=
 =?us-ascii?Q?m18J//gQZ470EIjXCFaXCzCcFGcjbYx31Hwc5mkstdzEK9O8lg538XB2eXGW?=
 =?us-ascii?Q?CKgO+SM8mMa+cEBiicvUelljOg4d+sua++/3zeF9DsJ6kqD8iY7fL7ywY2KQ?=
 =?us-ascii?Q?Z44Di4AX3FD6DLqEAr1EQ/p3oUThtMLbUskpd0ycGbR598l3//3NcxfDbytU?=
 =?us-ascii?Q?L8VjDMTvtWA4D2cLWVSENZMRmovgD2mhh4Kd/TuYBmjKuPzYz1rLxi4hYu7J?=
 =?us-ascii?Q?lMXiIi40f9QPoVQsaX/gT1wnXP6p0RuiotRgPx95/+a+03iSQ8cGtm3bHq4X?=
 =?us-ascii?Q?MRRABySFj0E+Og0y+cijoVnk5AfRSF+ltJqH0mV46U0XvHCPbxxVgrsy5PTL?=
 =?us-ascii?Q?RNliCONNTSg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nfmQLVVNk8M0xsiaJ1RG41CvqZnMykgv5pFw568l7lbNJ4MAVTRIvw8H0NJ2?=
 =?us-ascii?Q?srGBd4OkVfC2igyYSS4atfOMgYhXsdg/dyD+4kZmJE68SGegn7rGilw2xltI?=
 =?us-ascii?Q?Peq/u73MeVJQUPXWjtObReRKdDHhkdsQz9bGOrZdN7wtsNq5OQkE8SX2JLlF?=
 =?us-ascii?Q?GNWl0Mv23/PBGhg18irEJZb8Y863w4lz2LC3sPD/NnBS1PzffKTn+5oa1iVR?=
 =?us-ascii?Q?gT79X6PSu6NOaqGyJ+i6/l8O/9XuDr6jvGNRB8TfH8mUVyLL7/BNYNxq6ZOK?=
 =?us-ascii?Q?YtkxKzAsdvxAPlcbKL0foya6+SaR9ax06ujsRcB4gAV+GKc69I8e+aXkO0ER?=
 =?us-ascii?Q?2l+0dK8H3spIZBUXmwkslfIzEu1KscNR2OVIPS9ov0+Dtzn1CSJHEWvxO2oW?=
 =?us-ascii?Q?a2hAMscOP4VGS5U1uqYTXYQpb8iZVyATcZVgmJQfiSqrW28XwPbQYmY9p+wD?=
 =?us-ascii?Q?A8/bYZFk/x2SxQLgMnLZpwyP8AkRqYLl/sWqKooDmQQXEYjVDVhE/LcUOFZ2?=
 =?us-ascii?Q?1KZuPcEDIpqXKv6b6LjGe8zZ8gwci3JbUIH/D8nB2qCLe09DVwYEzGr9tHiA?=
 =?us-ascii?Q?1HAz/rfGfu6SsufMWSuUf2aO7BC+nAcnd8MzoOMoEYYRFSOC9qffWbuzhoy9?=
 =?us-ascii?Q?/oCzGQp/lMWlJ3Mk9m38wXw0jPvV2056zWiG9ogzwDExIiHVJN0iKBbzph3s?=
 =?us-ascii?Q?crlAnt060hhkh2AI+AfdClOOl5OEgtpC0XUczpDLUwZ2Wldc/m2rdoZr/HQb?=
 =?us-ascii?Q?AXYtFuswVftKDuTPQ7aed2v8ycDUGLEWG9JLD5TgK2mf0Zskjw63caxbFGF2?=
 =?us-ascii?Q?c+FhcNZ4qWM5vLuHqZm2vNSJf64AbHAd+05IPQG+QF+CiVhoKRvk2VFYUm4B?=
 =?us-ascii?Q?WNpVKNzfhDJC5CAeE4gkBL3JvPfuyMdccRCF+IcoAqvdDWNw4IR720XWKpGE?=
 =?us-ascii?Q?Xdk5AL0mNh79TLinJXsi4Mh5/qaBcZeyW0vuG1Z/ojeb6hIRKR67+D6GkwoN?=
 =?us-ascii?Q?V14JPDaz+fG60Xzn9x0I4vMSCEQr/g4fuXzvymCisaxyI3LH4lT0Kkjz2UH7?=
 =?us-ascii?Q?54myjFOgzWLXWvcWvPcSMDvgtGx5p/5p8JUoHTi3hyFOWF8k7CcC6mbwwyOb?=
 =?us-ascii?Q?NNyuXRBe8BXibk/cNJ8QtyODKgzTiBcivxxjW7F7jzB+Pv4V32qpwlz/py+T?=
 =?us-ascii?Q?qnS2rJr7CKTBrksDGaxrf6xJpTyMIF8AfHQdShuV9WbY0BleaP7jnE6tAj/B?=
 =?us-ascii?Q?ZcGOWZ4ssAj0n7TWNHNfBSrEMTJMnaF3NQU6Jjd1lap+xOP/pohqkpxkKc8C?=
 =?us-ascii?Q?LTLxh37BSLs/508jq8WaGzLY7yb0F/YrnniGPQewIM1Jzptk/3zpDBd9ikVg?=
 =?us-ascii?Q?yJvzOD8DBIqloTyp/r0jcehMkBv4Vb3AI643w0PhnO8OhXXUu/NV3vy24YCC?=
 =?us-ascii?Q?MrdMwzH4HTnDoSCaAtIiOADJub4bHanE2Ct33bjgsOZ23TWVZiZ8jmxsULAN?=
 =?us-ascii?Q?bI7sYGpW+v6uPVEEW54JZyYqfJi5le3LVQVSmWFPY/70DTjX40mZtakx+5Pw?=
 =?us-ascii?Q?VNeTCdCmbwzdw9Vxt/iKIqTVTUXydVU4560sRK0DnR0yJu3DORGb6LdpLx9d?=
 =?us-ascii?Q?KItHsPn9T1eIFOBsKuKXj9hiJTHja9xzIjnrB6+VuQQBGpZCU4U/lx8QIl/V?=
 =?us-ascii?Q?zz8kSg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c705f7-f499-49a4-0bbe-08dda281e43b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 09:34:52.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +su0xe2hDkaNazl8MzwzZK5L421ZduOkGJVZu/OTbqxkfWlDwcqhVn5JMxjCY/WoqzzCpzjYthMfkznZpOBirYLIMkRkhIcJ3rb8sBPSUYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6964
X-OriginatorOrg: intel.com

On Fri, May 30, 2025 at 11:16:48AM +0800, Jinjian Song wrote:
> When driver handles the napi rx polling requests, the netdev might
> have been released by the dellink logic triggered by the disconnect
> operation on user plane. However, in the logic of processing skb in
> polling, an invalid netdev is still being used, which causes a panic.
> 
> BUG: kernel NULL pointer dereference, address: 00000000000000f1
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> RIP: 0010:dev_gro_receive+0x3a/0x620
> [...]
> Call Trace:
>  <IRQ>
>  ? __die_body+0x68/0xb0
>  ? page_fault_oops+0x379/0x3e0
>  ? exc_page_fault+0x4f/0xa0
>  ? asm_exc_page_fault+0x22/0x30
>  ? __pfx_t7xx_ccmni_recv_skb+0x10/0x10 [mtk_t7xx (HASH:1400 7)]
>  ? dev_gro_receive+0x3a/0x620
>  napi_gro_receive+0xad/0x170
>  t7xx_ccmni_recv_skb+0x48/0x70 [mtk_t7xx (HASH:1400 7)]
>  t7xx_dpmaif_napi_rx_poll+0x590/0x800 [mtk_t7xx (HASH:1400 7)]
>  net_rx_action+0x103/0x470
>  irq_exit_rcu+0x13a/0x310
>  sysvec_apic_timer_interrupt+0x56/0x90
>  </IRQ>
> 
> Fixes: 5545b7b9f294 ("net: wwan: t7xx: Add NAPI support")
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
> v3:
>  * Only Use READ_ONCE/WRITE_ONCE when the lock protecting ctlb->ccmni_inst
>    is not held.

What do you mean by "lock protecting ctlb->ccmni_inst"? Please specify.

> ---
>  drivers/net/wwan/t7xx/t7xx_netdev.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
> index 91fa082e9cab..fc0a7cb181df 100644
> --- a/drivers/net/wwan/t7xx/t7xx_netdev.c
> +++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
> @@ -302,7 +302,7 @@ static int t7xx_ccmni_wwan_newlink(void *ctxt, struct net_device *dev, u32 if_id
>  	ccmni->ctlb = ctlb;
>  	ccmni->dev = dev;
>  	atomic_set(&ccmni->usage, 0);
> -	ctlb->ccmni_inst[if_id] = ccmni;
> +	WRITE_ONCE(ctlb->ccmni_inst[if_id], ccmni);
>  
>  	ret = register_netdevice(dev);
>  	if (ret)
> @@ -324,6 +324,7 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
>  	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
>  		return;
>  
> +	WRITE_ONCE(ctlb->ccmni_inst[if_id], NULL);
>  	unregister_netdevice(dev);
>  }
>  
> @@ -419,7 +420,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
>  
>  	skb_cb = T7XX_SKB_CB(skb);
>  	netif_id = skb_cb->netif_idx;
> -	ccmni = ccmni_ctlb->ccmni_inst[netif_id];
> +	ccmni = READ_ONCE(ccmni_ctlb->ccmni_inst[netif_id]);
>  	if (!ccmni) {
>  		dev_kfree_skb(skb);
>  		return;
> @@ -441,7 +442,7 @@ static void t7xx_ccmni_recv_skb(struct t7xx_ccmni_ctrl *ccmni_ctlb, struct sk_bu
>  
>  static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
>  {
> -	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
> +	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
>  	struct netdev_queue *net_queue;
> 

You do not seem to check if ccmni is NULL here, so given ctlb->ccmni_inst[0] is 
not being hot-swapped, I guess that there are some guarantees of it not being 
NULL at this moment, so I would drop READ_ONCE here.

>  	if (netif_running(ccmni->dev) && atomic_read(&ccmni->usage) > 0) {
> @@ -453,7 +454,7 @@ static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno
>  
>  static void t7xx_ccmni_queue_tx_full_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
>  {
> -	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
> +	struct t7xx_ccmni *ccmni = READ_ONCE(ctlb->ccmni_inst[0]);
>  	struct netdev_queue *net_queue;
>

Same as above, either READ_ONCE is not needed or NULL check is required.

>  	if (atomic_read(&ccmni->usage) > 0) {
> @@ -471,7 +472,7 @@ static void t7xx_ccmni_queue_state_notify(struct t7xx_pci_dev *t7xx_dev,
>  	if (ctlb->md_sta != MD_STATE_READY)
>  		return;
>  
> -	if (!ctlb->ccmni_inst[0]) {
> +	if (!READ_ONCE(ctlb->ccmni_inst[0])) {
>  		dev_warn(&t7xx_dev->pdev->dev, "No netdev registered yet\n");
>  		return;
>  	}
> -- 
> 2.34.1
> 
> 

