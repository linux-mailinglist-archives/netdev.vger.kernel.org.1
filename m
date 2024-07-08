Return-Path: <netdev+bounces-109775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ADB929E56
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB61F1C21763
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068B54645;
	Mon,  8 Jul 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDvwLGtF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279C4F88C;
	Mon,  8 Jul 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720427610; cv=fail; b=BEXBotUxNDKm6h58zA7aee88HfBX2tKtoIISVnH6GAOHwAG+oVT3NVMz1taV46pxV7I9UyqaiLHEyR3HAcK37PAj7tqJmHKFpQH0+g/5eNAf9AZU/qTYEZQpmqtdI3uS5CduBbvC7eSnNGq440jQ1PRaOK+bjMBsHIPPpn8K6sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720427610; c=relaxed/simple;
	bh=OHqAnTdR1kFmHz/qbNEddh163erHtm59vurK2pMyyfU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNxZHup03AoLstIe4BQ/cEmpnq0oa2khHAxCncYbQ1Ebqmp9pbm4HuKNRTpfzbBIq4xtuNwrWXFDONTdXinzXjHxcPO407Ghymv2mQDJYOqkzTxwlvJAxnfBwCSSjZf9G+xjgEHDxL8o33Py+13Hab6o3x3P1ZDP1CU+CgvA1t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDvwLGtF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720427609; x=1751963609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OHqAnTdR1kFmHz/qbNEddh163erHtm59vurK2pMyyfU=;
  b=iDvwLGtFV0mpP8nIRJsAzY4YkuXzChHooKofmh0Sbfiy+Ica42+PN9NE
   m2VSvc8qkn+pw2tURW1QGNA5pD3TakAtT+Tep6+75IFSNCmjdV6o6A+To
   Yw6GC5MbneyvzVMUiIxar2aYcue2EppCZA90vbOzTfVAjl0Ohfnw8lNMS
   AsvY18jhERdFblSIrGaLO6yp/TcX88U4kfY4cxPDicJjYhCCZpQgp2+XK
   K3vqcHoSMGsBuffhwzplMuVyB/9MrkBf+LMaYdPc4GN54dzoJYtkSgDI6
   NU9+HbNZsOy5qzGcNwscdZMaoKYOMpFb+mMU64Gud7q4AelbfojPUqSTl
   g==;
X-CSE-ConnectionGUID: R8oKVIsbRr+tSOnbzAFF9w==
X-CSE-MsgGUID: Sq7ia0dxTGK51XjYTI1guQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28221323"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="28221323"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 01:33:28 -0700
X-CSE-ConnectionGUID: IebOhsaNSdGavzLwyT/O3Q==
X-CSE-MsgGUID: CNr0xuRRT4Ou+0F7pEkASw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47317751"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 01:33:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 01:33:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 01:33:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 01:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrBPWdtn/7z6NSFj0l0bRDdxxUpDmvMOiTDM4TWmAgsUgBdSPJ3m3bjeYOB9CHQSWIkRSV2Ir79mkRrULHdQ0alzdQzD0Pc4M5r5pVnO7VYIlzKQJaNn4m/tQ08c6g9yOH5Jtcerf25a4qRQCEgaliselHbPrI27SUIh3qaX0vhNRsfyRC5wfDTvNSccho5VkuMo+TVtjDTHctzrnO+Nyo/5m68U32u5PFytfXgkKI44javaTY1hSEJaZasO8a+neIgQEJAF+WI8mtDwHBawYRd5hqGxPHBzo3mR98J/tF2nZbrS3t35n3OwSQt0vzz4kbDMcR/AJjfpOmQMJn3Euw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNIcYxpkt/jUSXKGlV2F1I+zEbbNRgf6D8j1uUKNLJQ=;
 b=M7CB4eeWhJJGptoplPmiPag2ppsxDJQlEHphghy7MDCmN7zFN5jc/k3fPUopCLk+yekRznfoHzXaVlF9L6zlWg+BeZ2LaO/utsO0FbVUDpyxu7p+sqzC9kYfDrIpuBQoB3uEYiBlJuH+SyPfBd2TNxplmxOg7VTYs3YRI6ThSrotFP9UpoBJJ87JgiUCrf7Bpt00F1+sqtlwZ3RhcUapjyro+nfZUuppvF2a7rYnaRH+K2V1mTRL4QUq+p9mduTAHao+DOObq4CtWynTsuZAM7szcSiAQyofFe905idNFEXJN0fwfS/f5nJy4INKldKHeSVAcQd8cIC8xF8zD1M/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:33:23 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 08:33:23 +0000
Date: Mon, 8 Jul 2024 10:33:01 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Chengen Du <chengen.du@canonical.com>
CC: Florian Westphal <fw@strlen.de>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ozsh@nvidia.com>, <paulb@nvidia.com>, <marcelo.leitner@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gerald Yang
	<gerald.yang@canonical.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
Message-ID: <ZoukPaoTJKefF1g+@localhost.localdomain>
References: <20240705025056.12712-1-chengen.du@canonical.com>
 <ZoetDiKtWnPT8VTD@localhost.localdomain>
 <20240705093525.GA30758@breakpoint.cc>
 <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SA1PR11MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ccfac1-a600-4817-166d-08dc9f28a15f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Im/4edFjjqk0Xi9dNwS0IstiTuVN6e2fXD3nagaKvUHc+Le1ocNYrnF5+eWh?=
 =?us-ascii?Q?oGbQJ58KJVn3jhTfycu/bNwEegJWYN2SC2zVrjpnh9yCZcSZcSxO6EoK36Sv?=
 =?us-ascii?Q?fHcT2V4JvfmmhiCZiI9NLqIUT47YPk+gecYgjhQRrzknkkfcWN4xBJeD1edn?=
 =?us-ascii?Q?I+miE16f0/n0KmIkIw2uFO0T7IV7qn4AW0h/yL27y066c68JRAea0EG7z386?=
 =?us-ascii?Q?7ZR6eh2AMe2YxPod7U/HZZtNWvPqIA9c65f11+gUgo6vzqZETkC90CGjWemZ?=
 =?us-ascii?Q?r35J+WCxy0QaSlewWD5C28hSIAJSHMUMhpjYfNYXeSXHhSo1zUm+rjpikP08?=
 =?us-ascii?Q?2k2fM5LuzFJ8WLW527z/FrELfuFHOS56kgK3GrbGWtwIAvgqZLJx9Kx/WChg?=
 =?us-ascii?Q?XBbIkej816a/vVHuQfn9eYkBcD2XZ5L4LTaFUYA8EGA0ksBVfY557r/07wI2?=
 =?us-ascii?Q?9oxoL5Y4NER6TqIFiXIAA95R+fjEgmrQYtlIst7kP9KxDa/u5G7w3nZDPvwM?=
 =?us-ascii?Q?xSLKAtZf7k4gO5SwUDmZLgH9ynJ1c4QvvmFVecNzLhH0EYfWhup3Hk0IByE1?=
 =?us-ascii?Q?1SrH0yjZjVZGFMijQqoSviJYZSOGSpkiLypUibs3f0DjAlZLUjGeyFvamuaV?=
 =?us-ascii?Q?38zAnLufkC6+WQUlRl+uZYhT/TyX1Rl1KO7l1VCw5xBvvFpv6zrsp/ZpFH5w?=
 =?us-ascii?Q?+r5orrGM1sY4P7BIeXyGLybctuaVyQN6jzbzM3ZCxEuzaxkwGp9g85QBVDVl?=
 =?us-ascii?Q?kNNDPlLrCLBQY4Kp1K1V7JOJvQH4pmbOaT+Zo4/jdwO6NM+dM5xUY11o66xg?=
 =?us-ascii?Q?vxOoyezuybDc4+yxXdeDDpV1Mw1OX57DUDoqmhuXW2JJ5Ngj4jb3MUsk6Ap9?=
 =?us-ascii?Q?nE9KfCPZQCQychWZLl/97ScHFzDVV5qojLysU3IJNGHFLGNZzvwR9EzpTARf?=
 =?us-ascii?Q?e7IzuBxgN989WR5O5RFd1jCL3V9VUpX/f1o7XaZH9vr/w6/MCMn2OBd5GKVs?=
 =?us-ascii?Q?rdVO+RFlNQneEYhvbT4waK2bOg9zgBq79TnKVAFzcI0qvzZ6Jgog1bIsh68i?=
 =?us-ascii?Q?r1QBLgJGl87UqlF3X+Ix99tWdmDzpYVSWBntWDoX+39NbcaCiAgWIY8WFSWA?=
 =?us-ascii?Q?8bb48npTTG0mLxBNXniobjJ+LC0xcmchywpeIWdlgNZkzOYeCkwKdyziJcZb?=
 =?us-ascii?Q?fS8Xhq0fLcoRXWJkVrqNTUt9Oj71VowprcHMVXOTkCQ/U8Z6IKDkJ53xT557?=
 =?us-ascii?Q?7P+q6eYNWBcXUfTgIG9DvFwnmEyyYlcHBMLeQGXkRuMRXrWX16lW0B0qhoFA?=
 =?us-ascii?Q?PLybDrDhSnMY3gpm4qjCJkPo3TJWYt+q7u+BnVW7WtHREw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/X792L3H4u8/mUO2zzLukBBG/EBCB6GvAMzTFbdvk5fkaFfB3A2jJCeoNlsK?=
 =?us-ascii?Q?VJYr0Ic6ctu83tnpmCl+HLXKaNIMCzwIbizk5GnVavPgugYfZ8d6pTBRL4wL?=
 =?us-ascii?Q?Q4XjyBAmExxwNygcNKGpbjEJMRhArPjjXVVXsDOB7qU+jyyCuH91hCsNxpkH?=
 =?us-ascii?Q?SefROyf5vEikuP7JMsfI9qGYY2Z7eolkIHKjFbmHW0K8kAQSI8MpY/IYw3mm?=
 =?us-ascii?Q?Njn0j2XLp39GJDSbuous+zJ3lkkwKIT/ObI7Y3cGvB76ZNo+Mlvm+BOo8MDq?=
 =?us-ascii?Q?WYA9tHvq+o5mvDq7sNiIGyKPXKrnqAg7ELThLa+bHrIkLXS4zGECELi4EeGN?=
 =?us-ascii?Q?PI+4tVB/XqVvmHD6wjy4DNtxFie+MbtP0+AXvPym847OcbClpQHKEGgLm+lT?=
 =?us-ascii?Q?GBZPYYGxhYDb8fXfmsJkWsWtFv8XHIkJgbu6i7EKsiGUfG+JaoVf7IGLm2Cr?=
 =?us-ascii?Q?ypg9LPievWcjUYW4LZ1oLE6cDuGeeh9O403EwE9JYs9nGp3iCILe96iiFf/G?=
 =?us-ascii?Q?oFtdK407bE9nV+m0HbzeFI2dXbo1yv1kTY3hH48UDJQPTEOjIan7jgLpZ7+t?=
 =?us-ascii?Q?bqGVRwSF4FzofWoUuN36GYULBunktVkz2ayARWpcQouv5vH7PVpMfM+wWnnk?=
 =?us-ascii?Q?zZcwUAK4wqavLOAVcy8h08HAvgdYjJknvWsqOgigamzEdnF3mefl6UKXDO9u?=
 =?us-ascii?Q?wNLun9LoiDgGwVtGJwwEugSAGEUG6ltuKW9s+aouPpPe8O9AjmVDm22ThS4y?=
 =?us-ascii?Q?wDRouO0HKqhiJ/n5L05OhjYVxQjI+AB8pHfkDixijkwK38xVFW3mDsKHSiVY?=
 =?us-ascii?Q?K3LPnrOoHLSv/pv2W8jqfGl0xaAZ8/UYIiEwtv10z2wOrF/61lth3bJ6t82z?=
 =?us-ascii?Q?Wgo/wgwUqk29S2NjcxDUNd7KyNonlHVhP0RhkpCwabuGkzhh2zxRcqVimwxE?=
 =?us-ascii?Q?mic4iYHut8IE74zAF1HrrCHFsX4IApBX5QTJeJcuCoWB3qoUM6Ua7As+Mt65?=
 =?us-ascii?Q?9wn00obFi25XVnNptcjuiox/eatYYfwuHptvXh6dMirQ1s2uvLl57L2b4u7w?=
 =?us-ascii?Q?ix1pvg8Xzti5DxI3hOpJzy3klCaltg/Zsufe6MDhxD1OA/mR2R0AQspaFT0n?=
 =?us-ascii?Q?nsYHL9m8E8F5W8GBIKM/outz9kTzJK+LUqmGWeseTZLrcSugOUFWFBYRYp5l?=
 =?us-ascii?Q?3ZuO3h8mYlVsTgSVOl+bxcNb3EvwiC6xuoha+aGUD4g0DS4nbUAZGVBlHvWX?=
 =?us-ascii?Q?xrf7DDbUvGrFOPu7eOnV309Y9Kh4OPztAAS1Vxs/3g06da2Y445SnD9HfFH8?=
 =?us-ascii?Q?BbI3d/RUl8ihKyM7/9PV7UgkDqH7Xu3CNMfdB3zVdtkHCSB9Wv450KtVAfOH?=
 =?us-ascii?Q?bddpiXTCHkj4OIZpXqkBxuUJtw6B8hz1Q1qHc+0I5bimBNl+b7Rys3MfCXyh?=
 =?us-ascii?Q?t8JGeeR48LOrIT91hwxFGqv5+Er5euKtxfm8NDD8qULWj3sDsjOLxe0uqO2W?=
 =?us-ascii?Q?njzdmNIMQwK/6fyTgtfFh7vygC7wF3q/BRmq9hPTwzFzsra36+m2GkY+zHfW?=
 =?us-ascii?Q?pg/kOt1Td07UYTQTAQX+mvD3WUoKWRUxBYjwtWCWy1V1fje4+6KA73dZgCSk?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ccfac1-a600-4817-166d-08dc9f28a15f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:33:23.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuiDas8+khdbDRwp/TEtB3KrWrTYXBns8e6MzJI2PFNhcopdkfwICGm7+i6Qz3XyJR6gnnjPLGK/MytROS3POA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com

On Sat, Jul 06, 2024 at 09:42:00AM +0800, Chengen Du wrote:

[...]

> >
> > > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > > index 2a96d9c1db65..6f41796115e3 100644
> > > > --- a/net/sched/act_ct.c
> > > > +++ b/net/sched/act_ct.c
> > > > @@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
> > > >              */
> > > >             if (nf_conntrack_confirm(skb) != NF_ACCEPT)
> > > >                     goto drop;
> > > > +
> > > > +           /* The ct may be dropped if a clash has been resolved,
> > > > +            * so it's necessary to retrieve it from skb again to
> > > > +            * prevent UAF.
> > > > +            */
> > > > +           ct = nf_ct_get(skb, &ctinfo);
> > > > +           if (!ct)
> > > > +                   goto drop;
> > >
> > > After taking a closer look at this change, I have a question: Why do we
> > > need to change an action returned by "nf_conntrack_confirm()"
> > > (NF_ACCEPT) and actually perform the flow for NF_DROP?
> > >
> > > From the commit message I understand that you only want to prevent
> > > calling "tcf_ct_flow_table_process_conn()". But for such reason we have
> > > a bool variable: "skip_add".
> > > Shouldn't we just set "skip_add" to true to prevent the UAF?
> > > Would the following example code make sense in this case?
> > >
> > >       ct = nf_ct_get(skb, &ctinfo);
> > >       if (!ct)
> > >               skip_add = true;
> 
> The fix is followed by the KASAN analysis. The ct is freed while
> resolving a clash in the __nf_ct_resolve_clash function, but it is
> still accessed in the tcf_ct_flow_table_process_conn function. If I
> understand correctly, the original logic still adds the ct to the flow
> table after resolving a clash once the skip_add is false. The chance
> of encountering a drop case is rare because the skb's ct is already
> substituted into the hashes one. However, if we still encounter a NULL
> ct, the situation is unusual and might warrant dropping it as a
> precaution. I am not an expert in this area and might have some
> misunderstandings. Please share your opinions if you have any
> concerns.
> 

I'm also not an expert in this part of code. I understand the scenario
of UAF found by KASAN analysis.
My only concern is that the patch changes the flow of the function:
in case of NF_ACCEPT we will go to "drop" instead of performing a normal
flow.

For example, if "nf_conntrack_confirm()" returns NF_ACCEPT, (even after
the clash resolving), I would not expect calling "goto drop".
That is why I suggested a less invasive solution which is just blocking
calling "tcf_ct_flow_table_process_conn()" where there is a risk of UAF.
So, I asked if such solution would work in case of this function.

Thanks,
Michal

> >
> > It depends on what tc wants do to here.
> >
> > For netfilter, the skb is not dropped and continues passing
> > through the stack. Its up to user to decide what to do with it,
> > e.g. doing "ct state invalid drop".

