Return-Path: <netdev+bounces-109386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A1928397
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237B51F2170D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781913AA2C;
	Fri,  5 Jul 2024 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHQ2ulEM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA541A81;
	Fri,  5 Jul 2024 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167715; cv=fail; b=XN1qe73wdc+al8Y+5u6sDe+ocMzrc/FF5SWN6QpWbnDsYfuQITDOppm3FgLvC6ZqlLEVMqgrx688AkTqY12oIQiToR7AVzWvjiNqMvhxBQy4z98znPIyx2pjpI9iF/36NA5pAnRmIW8+1lftn7fh8lRYB97WR/hKy7Jy7EGL0jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167715; c=relaxed/simple;
	bh=DdApAjFpke6T5Fh3EvQ3bnOePgI50Iz1TXFOgt1ZqOI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PBHmvdIHAVj41o4X/uf+OEWM31wxihO81iGrAC1OPl13g7DfHscZjuRjBs+5w+OTDjZMsDwZHqN5BxFjyasmFS/msyQpjmih9AEMgocIHjiSoeUFiEZCIouT8nRT4eZflRoehBANzdfOQUzItI6g+kRNvOwlrBG6NbraN4QJjsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHQ2ulEM; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720167713; x=1751703713;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DdApAjFpke6T5Fh3EvQ3bnOePgI50Iz1TXFOgt1ZqOI=;
  b=IHQ2ulEMyAScYCmWrWfQN4O3hANeO+EiRx3JeIlSc0okrZI6U2m30hF1
   wiOhvthHp8O50JeRNXwXvafJM7quto+7Qe44rVw8jvRJ2cQh+8jwbAzmD
   4ie0s7PxKnmNsbtnlj835rCkflv5zyZumu6+tyd5qBwIVhArt76nuB/yL
   Rf2eNUBMcIWnAjIruXwhcK0BCdzUagd27UzHr8ZGkE7y/44zX8q0fyvGB
   o8GpVzgllSaSMJlSbnKoSsI/LiK5XMX0vzqK1G8rnhpHgthk74bEETLKR
   PFMRD4Oo6ygtqT3eG2VkneuIho3e7nL1pMe1k2bVpxvXh+NliZbAW2y4f
   w==;
X-CSE-ConnectionGUID: qY51HGWMRX+AFR+KmPs1gg==
X-CSE-MsgGUID: lNc6PjszQlyC018r+m84Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17584918"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17584918"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 01:21:53 -0700
X-CSE-ConnectionGUID: hud//AyMS0WrJE8iQX1quw==
X-CSE-MsgGUID: Zh0iMDeLTm+R1FAeI5e/kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="47462346"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 01:21:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 01:21:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 01:21:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 01:21:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 01:21:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlyaxghRmyXU3gx5nieEtcWA3z0PH0n6eUIv1kM52hvAng0jXEE2WvSRJRCjzDPFP2jxNR814nZ+2estD36d8lgFhh7xupeE7vVN7x0It9O1b2dNf7PfF7YH34Se/x7mxELZD2/pFYfScsqIdO2uRfnnj7wuaRWkm4G7Ljifv/JJ12hMUMk7Ophpti0EV1lSU7ewX1gdAX8tjCmNqqHCgJEOZayJ1EezfHJ6fk9VrEk+csH/JguGTwK132NLgTtDxqwKfDY6lCY2qgt/nb8r5bxsuGq5X59lVJVDksftOr7oMDzp9na1M1Xkg2xHJVWcLWloWep69fKYfgGtMatJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjhGrsqReZF/AORlZX2sAh/tQrpTPC93mjwCFDQ0Ngk=;
 b=bklTEfMTU9AmG26JXeJ7JEViqxQ7sNl1ARl3fLFbmvdNOPe6rRt45uo27vTaS2wLo8TG8+zVx0GiHGL2Gr+vPUETC2HOhpG2vPGRov1rQJ35OEUIxmtbb9S7yDUQOlhdusghyS88tbA/hVzFNId6h+rAJrHiaIrL5HI97GWRQJcNDgobHs7QhNV8GKsdBZs7ynuiGyeGJt685oc9Zmrox5eEkKRSKhV1mLTgtCxCM8ikgesmDWRBS9RbH0MPMAdrNnIM/VCAG5gfwnt96gHWIqCclyOs8kD2hjeLMsHGMg/0HIVVjrgTLfAcQiqjrqSUmSub0/ew0ZzCvrhKZL1Ypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by CY5PR11MB6306.namprd11.prod.outlook.com (2603:10b6:930:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 08:21:48 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 08:21:48 +0000
Date: Fri, 5 Jul 2024 10:21:34 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Chengen Du <chengen.du@canonical.com>
CC: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ozsh@nvidia.com>, <paulb@nvidia.com>,
	<marcelo.leitner@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gerald Yang <gerald.yang@canonical.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
Message-ID: <ZoetDiKtWnPT8VTD@localhost.localdomain>
References: <20240705025056.12712-1-chengen.du@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240705025056.12712-1-chengen.du@canonical.com>
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|CY5PR11MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf61483-12e4-4324-c0d4-08dc9ccb83b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K9vQ/xJO0ehauBCf3Pi40s4O+Vr+IWqCP16NASotee6fO0Bgp6YxpZbEmbFp?=
 =?us-ascii?Q?4K2T3jAR3uzYW9PRsgZlra6wiL4FcEbg4MRuPncntepn31qvH2xYxkQ5/zoh?=
 =?us-ascii?Q?4n+icJyYsY0efC0wl0H5WpOdf544VX7qvXBg39i8doOSbAw5TiahDu/JnO31?=
 =?us-ascii?Q?lAj8yPR/pY4SDTnCvlIRmJTmO5yCGzawPu6GVHjVCiDeH7tlR9KbjTZnc9Tr?=
 =?us-ascii?Q?TdBAJrZYVRdv660a8nn9L4/zWrLLwHcotb0UlGALm2SaO4x67x/QbqmfF/sO?=
 =?us-ascii?Q?412sQFjpt4iOHlUXvVTsrbFSOEywEjHXS1QkzmHEVSv/8C8t3zvMXt+YOlGC?=
 =?us-ascii?Q?OJQOjXnq3j8gb7rk5UcJ6Dinjv5dyU4fA9nd/oSGYHecQ7wAc+vDuOkw6Y8x?=
 =?us-ascii?Q?YEJTCMMkn+w8b3Ib/RHcwTP6RZOQbLA0DwYdCIF95aLVlvILfHXxaOheZJBe?=
 =?us-ascii?Q?SB2EUjLBes4MZY24mJFrraYlMF18oFgmFbH2MH2eIw13xisxTHGt32IZ1gJ/?=
 =?us-ascii?Q?aRgsRiTR0QOEYwrOJYnNH+J/goFcPLGMp5w8ehOu8iKuCLss5l4+boqNOPIL?=
 =?us-ascii?Q?9wqPBBVQBFR+qX8ISFz/BtWfGxk0K9x0bbCXEjvjNrPecLbsiLHE7Q1V98af?=
 =?us-ascii?Q?+SHeva6M94n5n/mnOarNY+uyC+Y32O9x7UR9IdtyPo5dP5lbhI/Z5avMi8+a?=
 =?us-ascii?Q?rKTM6RTyaUdR7Xjj1bIx8WTSFwsGuxBH/TBsrSHtWcutmN1gJ6MmseYLw4hU?=
 =?us-ascii?Q?YmAzCLQkbgwWI+UCOom6/7jwHjDqHegW5vm9BxnKIdX/SEdbQlPYCDGFgOMh?=
 =?us-ascii?Q?cVs1WCO1xbYsPuXMjX1WqQAQDZy3Xc2OcSv+Exd+fvYR719Ws6Y4AjKZNiH/?=
 =?us-ascii?Q?2NkFllSiHyQMWqEGSuJ1a8s0g+KRpaLep6145PtESfjSL4SlrJVK6r9FSErz?=
 =?us-ascii?Q?74lqjXyMGFXTvwp2aTTSeCzRDoYm4PW3OG9/enCOpbPSZuzkJKI4fiShM99W?=
 =?us-ascii?Q?wUclg9owGPJ7cvi1WFgBYAm6OkItYRutVFLwuxG9LOnfcncpgCXYjkj4b87M?=
 =?us-ascii?Q?+kfFOm0UhbKfmLbP1fEx2nP23AVguwfhmiGT9+3bkZGQ1wz3brk2T4KZoPac?=
 =?us-ascii?Q?yX5JHx8+VcAYwZtc9H2DPAMIWhXgEnBfKbNR8frs/9h/dl3gZpvmwv+EnQ3G?=
 =?us-ascii?Q?kHLWg2Xqz1dfYYhKgE2ukXbjoQfTqMapPPJHBkLI5NANrkAfmUm1D0heyYvc?=
 =?us-ascii?Q?PTqG+UonVjDKe6JoLP4INGa13WufvYh4dCFKzTz+v4BIrB1T8E7ZxqO5F69W?=
 =?us-ascii?Q?GqPkZa8NL6df1W9V30CHsO1hY2eVYc6RMFag8EuMnsUbig=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDsNvttKe9KFJgWnNJYFKCit2VFi34XrME+H0GxrVp3raSzt25+Avnd4zsyL?=
 =?us-ascii?Q?OIn1XRg9phJpXrKwWOvWskgapBewwcpkO9bxAJqIeXg6bb3Afdg0R/7fCdEz?=
 =?us-ascii?Q?kWe2yDGnB342VGrmxnoedIM+rzl+x0kyYTn26XrTSUzbSSdT6MFi5xlfs1je?=
 =?us-ascii?Q?WB9HWxC4o9h5H+69n3xs5wFMi0QQYYaoh+PfXALsXVBP5YUstNnargJaoZln?=
 =?us-ascii?Q?YIPh4YhiqaX9pnq/gTeB7j0t7RLWzK3PFhjOYz8VCTDnXiNVbfYyUAQgIv9q?=
 =?us-ascii?Q?xH4NRwee/J1xy3LLm/DZdfwj1I56DgqKzj5mgYJ5MIzQXStrBaduteRLkEfX?=
 =?us-ascii?Q?YmRnBRKfgk2tqMQJGuh4KKtnNheXlhnLsSbA9NJRnFKufw66otTV43eEUfMH?=
 =?us-ascii?Q?MkoAoHgN/c9Mlq1sWEpBxp2WhtcqzWz197l99r4BliBg2Jtn6TgTFZeVDkRp?=
 =?us-ascii?Q?F97yWEPQY2YO1UYDUbrZUftM5SSvtio3oznyTa0HGenC1ERDE9EAWnYFp0bt?=
 =?us-ascii?Q?9Ko7atd81B7K5FdjkwkVTC44DFtoO1uBEqnpPNA+pE5bSqqX2MG4QMdnLJw3?=
 =?us-ascii?Q?3DDSOXle8+QY3bm30RHf9Zq/3VIJ7PlXTbn3wSMKRiubn827G/xoYc3jCGzd?=
 =?us-ascii?Q?7EXFkYfwVdBnHDNL8+wL8XK8/kQCrM4SjPmTG7ncqztZ/jfVGPxI527K888L?=
 =?us-ascii?Q?Xn0c0CQV/6xxO25da9Wc0d5CORkgl4zx0PNS9f8Ib9oi9gBH4K8M3/0rk7u1?=
 =?us-ascii?Q?CQQwZJv1yx4PzhDNFl/G5slo3LBy708A9cYBkUMKebko4WHsINikhmO4ZSRs?=
 =?us-ascii?Q?tBtx+wAC/1F1K5soKXp9rqya+FNAvsGiP94VM/k7AAxHrYIcSMuKzsn7FymD?=
 =?us-ascii?Q?TPGwKsdIetdMv7jGtBb3d+ExpaUcJqKK/5h+nfe5Brn6Z0WJLql/3eC6VEKn?=
 =?us-ascii?Q?7hdplOQ/V40uyh7EkJhNIixncI3Lozs90wnu4ucredBtfb865xvE4jt1bUQq?=
 =?us-ascii?Q?uT04Qc17sLv+TUKe6pruz19AB0GNJhdRAh0joLZy+1mrZuZPIGd/YE7xIvfI?=
 =?us-ascii?Q?s3+jKe8D1RdOtDy9i2GsSSCuzzujWBOFqxwp3+zAObamLIAzXg6IFxYMBeBC?=
 =?us-ascii?Q?91cq1JV7mFA3iApeHVI0wYpYPjqWlNCFjuGqZg/8ek1q86k6FN2xUOkCK9pm?=
 =?us-ascii?Q?/+6vAulBIzuwKJvrAJCqOsWK0mkXq5gt3qd4yauCujarw8xan+amFYNMN+P9?=
 =?us-ascii?Q?UecHvjyySC+3R1/2/FbMNFK6JCIPxPaUuAsp2otzGu0UjGAWmOyPOiZHpeN1?=
 =?us-ascii?Q?8rIr/bwu9/py2AAJhrI+E633YSNFujlk+SABrhqaPcQ9r6rWI3orfrWSCGdj?=
 =?us-ascii?Q?xJz89YHRjE2WuQ7nGSfjO/5F0zHAxo/WbNG9tlTT+yD/8PMUVvpiKxzaJrq+?=
 =?us-ascii?Q?RalJxDQvek+1Ze/Z471FBjgfKra7ka04u6g/pNhSZf68mi7Ka5M9shhBBY3y?=
 =?us-ascii?Q?kVKxtoB3D1fQNz9hZWPJ051KsIpq4d3rpXTVqISAsRC9TYhCYZ7vYvHICzCz?=
 =?us-ascii?Q?AOmMeeHuktpv159q1FsZVFdLTgo9zXx1/UKA19cRnfU16hMHo3ymGtXp8K/v?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf61483-12e4-4324-c0d4-08dc9ccb83b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 08:21:48.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRtMLVvd/In17+gxu50HhqLD3FGAQRMD+AZizpTdhKR/HXgqu7MCO239EdhlS9PWKWj3dZ1s25lnBgtzyoL/ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6306
X-OriginatorOrg: intel.com

On Fri, Jul 05, 2024 at 10:50:56AM +0800, Chengen Du wrote:
> KASAN reports the following UAF:
> 
>  BUG: KASAN: slab-use-after-free in tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
>  Read of size 1 at addr ffff888c07603600 by task handler130/6469
> 
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x48/0x70
>   print_address_description.constprop.0+0x33/0x3d0
>   print_report+0xc0/0x2b0
>   kasan_report+0xd0/0x120
>   __asan_load1+0x6c/0x80
>   tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
>   tcf_ct_act+0x886/0x1350 [act_ct]
>   tcf_action_exec+0xf8/0x1f0
>   fl_classify+0x355/0x360 [cls_flower]
>   __tcf_classify+0x1fd/0x330
>   tcf_classify+0x21c/0x3c0
>   sch_handle_ingress.constprop.0+0x2c5/0x500
>   __netif_receive_skb_core.constprop.0+0xb25/0x1510
>   __netif_receive_skb_list_core+0x220/0x4c0
>   netif_receive_skb_list_internal+0x446/0x620
>   napi_complete_done+0x157/0x3d0
>   gro_cell_poll+0xcf/0x100
>   __napi_poll+0x65/0x310
>   net_rx_action+0x30c/0x5c0
>   __do_softirq+0x14f/0x491
>   __irq_exit_rcu+0x82/0xc0
>   irq_exit_rcu+0xe/0x20
>   common_interrupt+0xa1/0xb0
>   </IRQ>
>   <TASK>
>   asm_common_interrupt+0x27/0x40
> 
>  Allocated by task 6469:
>   kasan_save_stack+0x38/0x70
>   kasan_set_track+0x25/0x40
>   kasan_save_alloc_info+0x1e/0x40
>   __kasan_krealloc+0x133/0x190
>   krealloc+0xaa/0x130
>   nf_ct_ext_add+0xed/0x230 [nf_conntrack]
>   tcf_ct_act+0x1095/0x1350 [act_ct]
>   tcf_action_exec+0xf8/0x1f0
>   fl_classify+0x355/0x360 [cls_flower]
>   __tcf_classify+0x1fd/0x330
>   tcf_classify+0x21c/0x3c0
>   sch_handle_ingress.constprop.0+0x2c5/0x500
>   __netif_receive_skb_core.constprop.0+0xb25/0x1510
>   __netif_receive_skb_list_core+0x220/0x4c0
>   netif_receive_skb_list_internal+0x446/0x620
>   napi_complete_done+0x157/0x3d0
>   gro_cell_poll+0xcf/0x100
>   __napi_poll+0x65/0x310
>   net_rx_action+0x30c/0x5c0
>   __do_softirq+0x14f/0x491
> 
>  Freed by task 6469:
>   kasan_save_stack+0x38/0x70
>   kasan_set_track+0x25/0x40
>   kasan_save_free_info+0x2b/0x60
>   ____kasan_slab_free+0x180/0x1f0
>   __kasan_slab_free+0x12/0x30
>   slab_free_freelist_hook+0xd2/0x1a0
>   __kmem_cache_free+0x1a2/0x2f0
>   kfree+0x78/0x120
>   nf_conntrack_free+0x74/0x130 [nf_conntrack]
>   nf_ct_destroy+0xb2/0x140 [nf_conntrack]
>   __nf_ct_resolve_clash+0x529/0x5d0 [nf_conntrack]
>   nf_ct_resolve_clash+0xf6/0x490 [nf_conntrack]
>   __nf_conntrack_confirm+0x2c6/0x770 [nf_conntrack]
>   tcf_ct_act+0x12ad/0x1350 [act_ct]
>   tcf_action_exec+0xf8/0x1f0
>   fl_classify+0x355/0x360 [cls_flower]
>   __tcf_classify+0x1fd/0x330
>   tcf_classify+0x21c/0x3c0
>   sch_handle_ingress.constprop.0+0x2c5/0x500
>   __netif_receive_skb_core.constprop.0+0xb25/0x1510
>   __netif_receive_skb_list_core+0x220/0x4c0
>   netif_receive_skb_list_internal+0x446/0x620
>   napi_complete_done+0x157/0x3d0
>   gro_cell_poll+0xcf/0x100
>   __napi_poll+0x65/0x310
>   net_rx_action+0x30c/0x5c0
>   __do_softirq+0x14f/0x491
> 
> The ct may be dropped if a clash has been resolved but is still passed to
> the tcf_ct_flow_table_process_conn function for further usage. This issue
> can be fixed by retrieving ct from skb again after confirming conntrack.
> 
> Fixes: 0cc254e5aa37 ("net/sched: act_ct: Offload connections with commit action")
> Co-developed-by: Gerald Yang <gerald.yang@canonical.com>
> Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  net/sched/act_ct.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 2a96d9c1db65..6f41796115e3 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>  		 */
>  		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
>  			goto drop;
> +
> +		/* The ct may be dropped if a clash has been resolved,
> +		 * so it's necessary to retrieve it from skb again to
> +		 * prevent UAF.
> +		 */
> +		ct = nf_ct_get(skb, &ctinfo);
> +		if (!ct)
> +			goto drop;

After taking a closer look at this change, I have a question: Why do we
need to change an action returned by "nf_conntrack_confirm()"
(NF_ACCEPT) and actually perform the flow for NF_DROP?

From the commit message I understand that you only want to prevent
calling "tcf_ct_flow_table_process_conn()". But for such reason we have
a bool variable: "skip_add".
Shouldn't we just set "skip_add" to true to prevent the UAF?
Would the following example code make sense in this case?

	ct = nf_ct_get(skb, &ctinfo);
	if (!ct)
		skip_add = true;



>  	}
>  
>  	if (!skip_add)
> -- 
> 2.43.0
> 
> 

Thanks,
Michal


