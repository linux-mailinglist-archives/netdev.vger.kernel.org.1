Return-Path: <netdev+bounces-86446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBD389ED34
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1CC2831AB
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4253E13D2A3;
	Wed, 10 Apr 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0giZtvY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4C13D501
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736516; cv=fail; b=SdPTNh4kmIZih1QEfFviuljcDGeE8lvYKima7Ivc8J2a91cH6MaSetxPdmchPsmKOifVIvh8SX96x3OdmdwPE8NwaMwyNloK99ZVUgzHIoDhKTwABYK3WpRAzMURMfgrXqfWJmX/URSYMSuesr6lr4uc4SOAnwBD1HxShZ79HhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736516; c=relaxed/simple;
	bh=PTXwZGcXSGyZktWF4oUn5Q8as0WndtrpAKzeudF/c5I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Dz6nNYLOP5QVlqfkCQbUhYAE8LwDy1gbkvxEOg4xPKC2qqTcbLRIKbi6htBzETooRLWGGZZwivR74d5vaYaOWuMRJmBRWFsEyyAxGFvTn38TTP2L6UX8YtSrj7W4KF7fdMY58nr7/pAEtLANWrLd7q54iup0YnTRvKWyYy9OJhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0giZtvY; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712736512; x=1744272512;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=PTXwZGcXSGyZktWF4oUn5Q8as0WndtrpAKzeudF/c5I=;
  b=U0giZtvY7ZU6j7v4waEAoIFbS4VkueJsO8y/hNZNOeBXzzHX3Hhd9C03
   BclcxWktBMqMXDqJZNXVCUMftUbIXXwXgjAwoW8LqV+oa63LMEOu/e1Bj
   Wdkl2k1fC0Y2zmlbb03cBdJh5nKh9d8fQxH/5n6Z4aupLoBy1c9dfiLia
   hmnfmFNAwoKo+xM2NEAaRPlUHgD5lVgQDMWLWim7JhxBU7cM56t/ICEeK
   ORn9qNdvD5GVYcZTErcoYHfDaeEZTcbw7hU86unislbv1D6u2lZwHyD9k
   ZT/1MUMZxZ4xYQnyePhqaPHAlirqbt5JHIncZpd9RAAFyt/sVMkrLPgU9
   g==;
X-CSE-ConnectionGUID: ZbQcQYiPTdeyVmEDUqA1Yw==
X-CSE-MsgGUID: 9QrJMgrrQiGVLxy8UVxisw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25589355"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25589355"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:08:13 -0700
X-CSE-ConnectionGUID: NCAFEofgQvmq2o+Q9zdWwA==
X-CSE-MsgGUID: 3WhAhH2RQw+s0xXkGRnDyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20950856"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 01:08:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 01:08:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 01:08:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 01:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKHknVMcbouFxsEM9i9cKH5g1zIxrJ8K+/7rt/DE92f/w1bP3DGCrCsacAJt14tqk135ewsFto7CV3cDjHHIqiia1uXBgIiZ14R2XTrELWGF9IKn/dhEE27udJsH1eesDQeiPn2V4D4yL4igven5CNHAunIsVtA5YOW58BKrZfdZKr3On9AVUkzAEpQeqgan8ZpgGYgihhjGVYv2o75VYeXyIwGzRQ1A4IAQ8vfWdoqAeHeHb63ghxH1GaQhdQPa/Bji8qOlTs7k3dYQLUzl1H3COLPoJFrS4Fasf7eieV/1owA+JL2VyzFAmJFr+IkG9qassCqRYXQir+U/fiBeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di50ZxCN1tmky5PAtV/FyOfXDYDRhInfKNHrQHx1Q/M=;
 b=BZqTIyegGIpPwdHuvSG7LiZ1XyeIrfbiF9qNY1K1tki7XiPbcvQvXMyNY+Imm/jlPi2aK1YXf9asZ/dI/xozrzcyMMuTCp5mv19/nvc1RWRFrfBDdbr2EPYvUhMOPvnsK/FmtfR4mVNZ5nc6H1wKjuws7VR43cNQpJxA1btV160bzrymHIu+Q906PDv8R/HZlEtvJoAyy2BV79u+UJ87tFUz4BiG6f+qnW01pOkd7VIPH7PSMkqrSvACvr5aiK9L21RxRTCzD7Y22qoQkcfuvg3ENBFmtsgKFeW9AvfGUARG+czn5rzjCgLX/+CHUuUs8kFCqjJyXSv5XG+0B/o26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7683.namprd11.prod.outlook.com (2603:10b6:8:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 10 Apr
 2024 08:08:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 08:08:09 +0000
Date: Wed, 10 Apr 2024 16:08:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [af_unix]  dcf70df204:
 stress-ng.epoll.ops_per_sec -92.6% regression
Message-ID: <202404101427.92a08551-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7683:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fs57pM8NTFNCVxtgLg1SSvjaJ0esVlweSDtKjm04kGzal9yBSSRw7UHtj28VOPktPWtQrDtc/bigMussBDXYIO/qXZ5lWmfTvzz9efB1wVHKzs+Dh2qIoDPmIRKaSB4COwKgbygV4XfpmZQPL9Giv1QSQr07b4VmNhyfFBdAN6Y38pLm7fFNjr4YdV1Vz2Ny/Q7jGnUcGovgwcyOUo6GE43zEe5NLi/aT1cH7l0v4HLZEipuKNimE8+XO5FTxp2oIzzcT/0jVJKke3nUNs3dU7cog+tOeo2fJaYHKLHywaep+ycYOBOsPnxcchVd0bHjZcAUv9P8mXFh5gH0MTX2dOOtT2vJvGyPcarMnw1KlCkUxq3Gaydowxbn60gqk+GYhhwXHguETgGlKsvkt/6muzV8nXnfk3ajbYnEGidPiuFqUh2oPCGq9HSzTIXsKXzd7mjHBAMZpvpzEvgOs7xg8UoEaVYVKaPYKvgySZZ3hlR8CHgM7CFGZS5MVK1n54O0DoAfEJcu+x1ddRESsSqJ2V9RGlhh2HlOPyQiSYq4HOmdGYYEajpoxuFSFSoqj6XNahamzthj4m9gY2dDIaeI0lAqAXDQEq+knZMdM8eAGE4/gfcNUf+NCUZO3iXLk/S8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?98ZVygDCACL/60z1OrL19bTO7vhqMFmL68JCzP8ci4ng9/so3bWkNxdBkW?=
 =?iso-8859-1?Q?JBDvlVnr5sGDDnYmpmXxYfeC4QyK76/nAgXzqNqBJeAbi5pvuVP4Chh/Qs?=
 =?iso-8859-1?Q?Og6tChcKI9OwV0kLXWAiJdzqli4y/i/qWbyYyp2UjBlatB7gE3kwWrGu7B?=
 =?iso-8859-1?Q?Tjaj5Y8jrW/VVoWOrQNUsdm2VTi7/OrT3g7RPHHJP0KMLq5HpcziTGdeyw?=
 =?iso-8859-1?Q?MuKGq7M3OlLmu4zNgsDUL2UQuSbgkhZ+O/IvBmi8Jb3pcOV79+xazk8sh4?=
 =?iso-8859-1?Q?S7PTupWX9Z3A0eonVJp+Ec1EJa84z52vNlwL2bbrpHE3trzVqR3xlhQlgD?=
 =?iso-8859-1?Q?LpQhJMVgHa5fKrBBa4iuNu+3PwyNGOLJTupU83K0MOWBobUHkULPtjKDjC?=
 =?iso-8859-1?Q?+TmezK3+SFTsJckwBAmCwlA4h4WFaKUdQbUvKWJKm+JAB2q0cbenIctIer?=
 =?iso-8859-1?Q?7vo04ObUudjihCWLoF7wuL3o6Am6bIwunc2fuUFia8w/OXy1YYZKT+DLJt?=
 =?iso-8859-1?Q?u/gEw427jxB2Igx6hHcSbTP8Bj43gXoio9UuvfJbLpKe5Q30Ca/GNiHpQJ?=
 =?iso-8859-1?Q?jpg9KdH8nykQIrqL/aShrKHoSgFUxrwbDEMhnICre//qH5L17UCB1RR3te?=
 =?iso-8859-1?Q?xt6ylKO8Yuz6exAdSdzf1mvhSOpd1QxGVA3YgRgVHm2VQlBdUqNXNY7GGT?=
 =?iso-8859-1?Q?dEvLDcBo02bl9F0hee3D83SfpWEQ59v00tmrPzExv7hz4rR+r4HZVCaxeN?=
 =?iso-8859-1?Q?OBliI3z2P/JEX2gsglDaifmbE+IctrZ4OKvliu5QR+neDIxPchTP7M7WaJ?=
 =?iso-8859-1?Q?DFlE13p3Phy3g3UPbnWswAmpwcixPldpoZiKwMeR0J9kjfmOZzi9Hu0sPR?=
 =?iso-8859-1?Q?oJMYzZWSX9M8mBKUF5iwgEuRlNA6plwwCm/c7FKTWBwXgQVAbhz5YwDVlP?=
 =?iso-8859-1?Q?O9NrxfwbLzFmY9SnyQwoJvm8laikk5lVxgMcNuHOGHCc+5pRNaAaVU0gba?=
 =?iso-8859-1?Q?48HlSeYW6PMlOALNbifRxaA+8vB1fEkSi5N14zcedMr+GBszXhM6SaEID7?=
 =?iso-8859-1?Q?ZCay/4zK18MwXa9bbNG8ETQ/BJZNYjADlGEb2ssh4OCixNBbMD79VTe3OW?=
 =?iso-8859-1?Q?XNv7f+i3C2N5JC/9tAdUOKsWxpzjksUU0WcazVD3omihDyjQOhhChSuKag?=
 =?iso-8859-1?Q?v/kuC8zvGlMMAzA3njB6K4wBQHpJhO7TK5wMKFpuR6rfrYx+lGAkPoZKS0?=
 =?iso-8859-1?Q?LU1LrsHVBs22daLNmaRI1EBAfVnNdoxlMbBXVdgRc4VYwibLsLIwOJfL84?=
 =?iso-8859-1?Q?Cnd106wjYqBlGmIInjDJ4Rez7YPKvUxwiFnyvFQzOh6HNYqsjRBljNFW/5?=
 =?iso-8859-1?Q?aMgrI/iY+0dkuyBzR2K+yNtsPZUL0u4iK9DHx2SoB1IFHT1F9J35nRAHUW?=
 =?iso-8859-1?Q?1KmKiAR9EaiMl05+99huaVp5cRMAwT69e+o8Pe3vVf77huRO8rEi9pt5Jm?=
 =?iso-8859-1?Q?NUUalobeTZxjm1POWq7xRUj5FI9dJhAXCCes+mrey31uEnsZcMFQIXYPm4?=
 =?iso-8859-1?Q?pBwAsZxAm2JmXEOzg+I3FSEyB8mHjdSU1vYwerfTl4MmDvay322QbMOxZQ?=
 =?iso-8859-1?Q?jZpvKE7faL164spNqq6rfzf/qosc7RgtbZxFXjAQZfpp/2sN9MXZ7I2A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aefeeb-647c-4cb5-cbbd-08dc59355c29
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:08:09.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpfZQyW7y4+7gf+XhYAsN18sNUNf0UMAJjXQmLd2T3JMwxj0F3W4MKi1xoVSizecp74jtYw4s5IQnLEVPLlXeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7683
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -92.6% regression of stress-ng.epoll.ops_per_sec on:


commit: dcf70df2048d27c5d186f013f101a4aefd63aa41 ("af_unix: Fix up unix_edge.successor for embryo socket.")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: epoll
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404101427.92a08551-oliver.sang@intel.com


we also noticed the data become less stable on this commit:

  "stress-ng.epoll.ops_per_sec": [
    47530.93,
    40960.07,
    332631.31,
    44100.9,
    43576.32,
    37547.67,
    40540.35,
    42700.75,
    298256.41,
    50348.57
  ],


as a contrast, pretty stable on parent:

  "stress-ng.epoll.ops_per_sec": [
    1312139.89,
    1336348.98,
    1298572.32,
    1266633.09,
    1329577.86,
    1331007.0,
    1395179.61,
    1362220.55,
    1344377.88,
    1323383.26
  ],


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240410/202404101427.92a08551-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/epoll/stress-ng/60s

commit: 
  aed6ecef55 ("af_unix: Save listener for embryo socket.")
  dcf70df204 ("af_unix: Fix up unix_edge.successor for embryo socket.")

aed6ecef55d70de3 dcf70df2048d27c5d186f013f10 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 2.271e+08 ± 59%   +1574.0%  3.801e+09 ±  3%  cpuidle..time
      2245 ±  6%    +159.5%       5827 ±  2%  uptime.idle
  41690997 ±  4%     -91.2%    3649185 ±105%  numa-numastat.node0.local_node
  41741557 ±  4%     -91.2%    3677235 ±104%  numa-numastat.node0.numa_hit
  45137725 ±  3%     -92.8%    3245699 ±107%  numa-numastat.node1.local_node
  45163260 ±  3%     -92.7%    3298938 ±106%  numa-numastat.node1.numa_hit
      8706 ± 27%     -99.6%      32.90 ±163%  perf-c2c.DRAM.local
     23673 ±  8%     -99.0%     228.60 ±148%  perf-c2c.DRAM.remote
     24497 ±  6%     -96.8%     772.70 ±181%  perf-c2c.HITM.local
     14530 ±  5%     -99.3%     104.50 ±130%  perf-c2c.HITM.remote
     39027 ±  5%     -97.8%     877.20 ±175%  perf-c2c.HITM.total
      7.33 ± 40%   +1199.0%      95.26 ±  2%  vmstat.cpu.id
     88.77 ±  3%     -95.7%       3.78 ± 54%  vmstat.cpu.sy
     98.04 ±  5%     -95.3%       4.58 ± 31%  vmstat.procs.r
    545129 ±  5%     -97.3%      14717 ± 30%  vmstat.system.cs
    198180 ±  4%     -92.6%      14642 ± 47%  vmstat.system.in
      4.43 ± 70%     +90.8       95.19 ±  2%  mpstat.cpu.all.idle%
      0.35 ±  4%      -0.3        0.03 ± 29%  mpstat.cpu.all.irq%
      0.90 ± 24%      -0.8        0.09 ± 80%  mpstat.cpu.all.soft%
     90.36 ±  3%     -86.6        3.78 ± 52%  mpstat.cpu.all.sys%
      3.94 ±  4%      -3.1        0.88 ± 18%  mpstat.cpu.all.usr%
     13.30 ± 57%     -85.0%       2.00        mpstat.max_utilization.seconds
  79869351 ±  2%     -92.6%    5883742 ±111%  stress-ng.epoll.ops
   1329944 ±  2%     -92.6%      97819 ±111%  stress-ng.epoll.ops_per_sec
  16955523 ±  7%     -97.4%     434535 ± 21%  stress-ng.time.involuntary_context_switches
     36492            -5.7%      34400        stress-ng.time.minor_page_faults
      5985           -95.9%     244.50 ± 55%  stress-ng.time.percent_of_cpu_this_job_got
      3509           -95.9%     142.53 ± 53%  stress-ng.time.system_time
    100.83           -94.7%       5.30 ±106%  stress-ng.time.user_time
  16195270 ±  3%     -99.0%     163813 ± 62%  stress-ng.time.voluntary_context_switches
   1640258 ± 12%     -96.6%      55940 ±148%  meminfo.Active
   1640219 ± 12%     -96.6%      55901 ±148%  meminfo.Active(anon)
   5437008           -40.9%    3211837 ±  2%  meminfo.Cached
   4204826           -52.7%    1988149 ±  4%  meminfo.Committed_AS
   1627059 ± 12%     -39.5%     985026        meminfo.Inactive
   1626831 ± 12%     -39.5%     984800        meminfo.Inactive(anon)
    156827 ±  2%     -33.4%     104375 ±  3%  meminfo.KReclaimable
    646722 ± 16%     -83.0%     110112 ±  4%  meminfo.Mapped
    156827 ±  2%     -33.4%     104375 ±  3%  meminfo.SReclaimable
    330183 ± 13%    +271.9%    1228007 ±  2%  meminfo.SUnreclaim
   2361293 ±  3%     -94.2%     136118 ± 66%  meminfo.Shmem
    487011 ±  9%    +173.6%    1332383 ±  2%  meminfo.Slab
     87847 ± 55%     -97.8%       1944 ±178%  numa-vmstat.node0.nr_active_anon
    133753 ± 55%     -89.7%      13721 ± 57%  numa-vmstat.node0.nr_shmem
     37328 ± 18%    +333.9%     161951 ±  8%  numa-vmstat.node0.nr_slab_unreclaimable
     87847 ± 55%     -97.8%       1944 ±178%  numa-vmstat.node0.nr_zone_active_anon
  41741071 ±  4%     -91.2%    3676979 ±104%  numa-vmstat.node0.numa_hit
  41690511 ±  4%     -91.2%    3648928 ±105%  numa-vmstat.node0.numa_local
    323427 ± 19%     -96.3%      12036 ±155%  numa-vmstat.node1.nr_active_anon
    914814 ± 29%     -67.6%     296418 ±105%  numa-vmstat.node1.nr_file_pages
    287735 ± 24%     -53.6%     133591 ± 30%  numa-vmstat.node1.nr_inactive_anon
    110214 ± 30%     -90.8%      10148 ±101%  numa-vmstat.node1.nr_mapped
    457411 ± 17%     -95.6%      20336 ±131%  numa-vmstat.node1.nr_shmem
     44827 ± 22%    +221.4%     144054 ±  7%  numa-vmstat.node1.nr_slab_unreclaimable
    323427 ± 19%     -96.3%      12036 ±155%  numa-vmstat.node1.nr_zone_active_anon
    287735 ± 24%     -53.6%     133591 ± 30%  numa-vmstat.node1.nr_zone_inactive_anon
  45162863 ±  3%     -92.7%    3298178 ±106%  numa-vmstat.node1.numa_hit
  45137328 ±  3%     -92.8%    3244939 ±107%  numa-vmstat.node1.numa_local
    351186 ± 55%     -97.8%       7804 ±177%  numa-meminfo.node0.Active
    351151 ± 55%     -97.8%       7774 ±178%  numa-meminfo.node0.Active(anon)
    204119 ± 46%     -65.8%      69822 ± 53%  numa-meminfo.node0.Mapped
    149884 ± 18%    +333.4%     649533 ±  8%  numa-meminfo.node0.SUnreclaim
    534553 ± 55%     -89.7%      54876 ± 57%  numa-meminfo.node0.Shmem
    233627 ± 14%    +206.5%     716057 ±  8%  numa-meminfo.node0.Slab
   1293132 ± 19%     -96.3%      48142 ±155%  numa-meminfo.node1.Active
   1293129 ± 19%     -96.3%      48134 ±155%  numa-meminfo.node1.Active(anon)
   3657699 ± 29%     -67.6%    1185604 ±105%  numa-meminfo.node1.FilePages
   1149605 ± 24%     -53.4%     535291 ± 30%  numa-meminfo.node1.Inactive
   1149573 ± 24%     -53.4%     535243 ± 30%  numa-meminfo.node1.Inactive(anon)
     72853 ± 29%     -48.4%      37568 ± 53%  numa-meminfo.node1.KReclaimable
    439538 ± 30%     -90.8%      40354 ±101%  numa-meminfo.node1.Mapped
     72853 ± 29%     -48.4%      37568 ± 53%  numa-meminfo.node1.SReclaimable
    179725 ± 22%    +221.8%     578296 ±  7%  numa-meminfo.node1.SUnreclaim
   1828087 ± 17%     -95.6%      81277 ±131%  numa-meminfo.node1.Shmem
    252578 ± 19%    +143.8%     615865 ±  8%  numa-meminfo.node1.Slab
    411280 ± 12%     -96.6%      13978 ±148%  proc-vmstat.nr_active_anon
   1359754           -40.9%     802977 ±  2%  proc-vmstat.nr_file_pages
    405874 ± 12%     -39.4%     246135        proc-vmstat.nr_inactive_anon
    160881 ± 15%     -82.8%      27709 ±  4%  proc-vmstat.nr_mapped
    590823 ±  3%     -94.2%      34045 ± 66%  proc-vmstat.nr_shmem
     38990 ±  2%     -33.3%      26021 ±  3%  proc-vmstat.nr_slab_reclaimable
     82314 ± 13%    +272.8%     306855 ±  2%  proc-vmstat.nr_slab_unreclaimable
    411280 ± 12%     -96.6%      13978 ±148%  proc-vmstat.nr_zone_active_anon
    405874 ± 12%     -39.4%     246135        proc-vmstat.nr_zone_inactive_anon
    119086 ± 16%     -96.4%       4320 ±144%  proc-vmstat.numa_hint_faults
     57959 ± 19%     -97.2%       1615 ±263%  proc-vmstat.numa_hint_faults_local
  86906733 ±  2%     -92.0%    6978194 ±105%  proc-vmstat.numa_hit
  86830631 ±  2%     -92.1%    6896903 ±105%  proc-vmstat.numa_local
     47908 ± 21%     -79.0%      10057 ± 57%  proc-vmstat.numa_pages_migrated
    487967 ±  9%     -90.9%      44528 ± 80%  proc-vmstat.numa_pte_updates
    580949 ± 12%     -95.4%      26484 ±133%  proc-vmstat.pgactivate
 1.038e+08           -91.1%    9291091 ±101%  proc-vmstat.pgalloc_normal
    521972 ±  3%     -49.6%     263108 ±  5%  proc-vmstat.pgfault
 1.029e+08           -91.4%    8873570 ±106%  proc-vmstat.pgfree
     47908 ± 21%     -79.0%      10057 ± 57%  proc-vmstat.pgmigrate_success
      3.35 ±  2%     -55.7%       1.48 ± 16%  perf-stat.i.MPKI
 1.422e+10 ±  3%     -90.0%  1.423e+09 ± 65%  perf-stat.i.branch-instructions
      0.82 ±  3%      +1.9        2.72 ± 30%  perf-stat.i.branch-miss-rate%
 1.102e+08 ±  3%     -67.1%   36283485 ±  8%  perf-stat.i.branch-misses
     41.81           -24.8       17.04 ±  7%  perf-stat.i.cache-miss-rate%
 2.467e+08 ±  3%     -92.9%   17605895 ± 58%  perf-stat.i.cache-misses
 5.827e+08 ±  3%     -90.2%   56915263 ± 98%  perf-stat.i.cache-references
    565322 ±  5%     -97.3%      15214 ± 30%  perf-stat.i.context-switches
      2.99 ±  2%     -57.0%       1.29 ±  7%  perf-stat.i.cpi
 2.203e+11 ±  3%     -94.9%  1.129e+10 ± 46%  perf-stat.i.cpu-cycles
      2328 ± 38%     -93.0%     163.78 ± 58%  perf-stat.i.cpu-migrations
 7.297e+10 ±  3%     -90.0%  7.277e+09 ± 68%  perf-stat.i.instructions
      0.35 ±  5%    +168.0%       0.93 ±  2%  perf-stat.i.ipc
     15.96 ±  4%     -97.9%       0.34 ±123%  perf-stat.i.metric.K/sec
      7474 ±  3%     -56.1%       3282 ±  6%  perf-stat.i.minor-faults
    457559 ±  4%     -96.2%      17371 ±156%  perf-stat.i.page-faults
      3.39 ±  2%     -25.3%       2.53 ±  7%  perf-stat.overall.MPKI
      0.77            +2.4        3.15 ± 29%  perf-stat.overall.branch-miss-rate%
      3.02 ±  2%     -43.6%       1.71 ± 13%  perf-stat.overall.cpi
    892.57 ±  3%     -24.8%     671.17 ±  8%  perf-stat.overall.cycles-between-cache-misses
      0.33 ±  2%     +81.2%       0.60 ± 16%  perf-stat.overall.ipc
 1.399e+10 ±  3%     -90.0%  1.403e+09 ± 65%  perf-stat.ps.branch-instructions
 1.078e+08 ±  3%     -66.8%   35761592 ±  8%  perf-stat.ps.branch-misses
  2.43e+08 ±  3%     -92.8%   17399245 ± 57%  perf-stat.ps.cache-misses
 5.736e+08 ±  3%     -90.2%   56146272 ± 98%  perf-stat.ps.cache-references
    555564 ±  5%     -97.3%      15021 ± 30%  perf-stat.ps.context-switches
 2.167e+11 ±  2%     -94.9%  1.116e+10 ± 45%  perf-stat.ps.cpu-cycles
      2281 ± 39%     -92.9%     161.26 ± 58%  perf-stat.ps.cpu-migrations
 7.174e+10 ±  3%     -90.0%  7.175e+09 ± 67%  perf-stat.ps.instructions
      7354 ±  3%     -56.1%       3227 ±  6%  perf-stat.ps.minor-faults
    449719 ±  5%     -96.2%      17089 ±156%  perf-stat.ps.page-faults
 4.445e+12           -90.1%  4.411e+11 ± 67%  perf-stat.total.instructions
   1925881           -98.2%      34225 ± 91%  sched_debug.cfs_rq:/.avg_vruntime.avg
   2323630 ±  8%     -97.2%      65544 ± 56%  sched_debug.cfs_rq:/.avg_vruntime.max
   1584300 ±  3%     -99.0%      15977 ± 99%  sched_debug.cfs_rq:/.avg_vruntime.min
    208210 ± 31%     -95.0%      10339 ± 58%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.87 ±  6%     -78.7%       0.19 ± 28%  sched_debug.cfs_rq:/.h_nr_running.avg
      2.45 ± 14%     -55.1%       1.10 ± 27%  sched_debug.cfs_rq:/.h_nr_running.max
      0.54 ±  5%     -32.5%       0.37 ± 19%  sched_debug.cfs_rq:/.h_nr_running.stddev
     14.85 ± 20%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
   1925881           -98.2%      34225 ± 91%  sched_debug.cfs_rq:/.min_vruntime.avg
   2323630 ±  8%     -97.2%      65544 ± 56%  sched_debug.cfs_rq:/.min_vruntime.max
   1584300 ±  3%     -99.0%      15977 ± 99%  sched_debug.cfs_rq:/.min_vruntime.min
    208210 ± 31%     -95.0%      10339 ± 58%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.63 ±  3%     -70.6%       0.19 ± 28%  sched_debug.cfs_rq:/.nr_running.avg
      1008 ±  3%     -64.6%     356.49 ± 31%  sched_debug.cfs_rq:/.runnable_avg.avg
      1988 ± 11%     -34.3%       1305 ± 23%  sched_debug.cfs_rq:/.runnable_avg.max
    198.55 ± 85%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    735.99 ±  2%     -51.8%     355.06 ± 31%  sched_debug.cfs_rq:/.util_avg.avg
    124.90 ± 94%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    483.25 ± 11%     -94.2%      27.85 ± 33%  sched_debug.cfs_rq:/.util_est.avg
      1459 ± 10%     -67.9%     468.90 ± 15%  sched_debug.cfs_rq:/.util_est.max
    338.04 ±  6%     -70.8%      98.71 ± 22%  sched_debug.cfs_rq:/.util_est.stddev
    441948 ±  5%     +74.6%     771587 ±  9%  sched_debug.cpu.avg_idle.avg
      2.77 ± 30%     -49.9%       1.39 ± 12%  sched_debug.cpu.clock.stddev
      1621 ±  3%     -76.1%     387.55 ± 24%  sched_debug.cpu.curr->pid.avg
      0.87 ±  7%     -78.6%       0.19 ± 29%  sched_debug.cpu.nr_running.avg
      2.40 ± 15%     -54.2%       1.10 ± 27%  sched_debug.cpu.nr_running.max
      0.55 ±  6%     -32.7%       0.37 ± 20%  sched_debug.cpu.nr_running.stddev
    268510 ±  4%     -98.3%       4440 ± 64%  sched_debug.cpu.nr_switches.avg
    341886 ±  7%     -95.3%      15958 ± 51%  sched_debug.cpu.nr_switches.max
    182545 ± 19%     -99.6%     774.85 ± 77%  sched_debug.cpu.nr_switches.min
     40026 ± 37%     -91.8%       3299 ± 47%  sched_debug.cpu.nr_switches.stddev
      0.13 ± 44%     -79.7%       0.03 ± 49%  sched_debug.cpu.nr_uninterruptible.avg
    119.50 ± 18%     -84.3%      18.80 ± 25%  sched_debug.cpu.nr_uninterruptible.max
   -161.15           -90.8%     -14.80        sched_debug.cpu.nr_uninterruptible.min
     56.46 ± 37%     -90.1%       5.60 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
     25.69 ±  7%     -24.7        1.00 ±200%  perf-profile.calltrace.cycles-pp.timer_create
     25.58 ±  7%     -24.6        0.93 ±200%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_create
     25.57 ±  7%     -24.6        0.93 ±200%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_create
     25.54 ±  7%     -24.6        0.91 ±200%  perf-profile.calltrace.cycles-pp.__x64_sys_timer_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_create
     25.44 ±  7%     -24.6        0.86 ±200%  perf-profile.calltrace.cycles-pp.do_timer_create.__x64_sys_timer_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_create
     24.04 ±  8%     -23.8        0.22 ±200%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_timer_create.__x64_sys_timer_create.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.71 ±  8%     -23.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_timer_create.__x64_sys_timer_create.do_syscall_64
     23.79 ±  5%     -23.1        0.65 ±200%  perf-profile.calltrace.cycles-pp.timer_delete
     23.70 ±  5%     -23.1        0.59 ±200%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_delete
     23.69 ±  5%     -23.1        0.59 ±200%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_delete
     23.65 ±  5%     -23.1        0.57 ±200%  perf-profile.calltrace.cycles-pp.__x64_sys_timer_delete.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_delete
     23.31 ±  6%     -22.8        0.46 ±200%  perf-profile.calltrace.cycles-pp.posix_timer_unhash_and_free.__x64_sys_timer_delete.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_delete
     22.56 ±  6%     -22.4        0.18 ±200%  perf-profile.calltrace.cycles-pp._raw_spin_lock.posix_timer_unhash_and_free.__x64_sys_timer_delete.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.25 ±  6%     -22.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.posix_timer_unhash_and_free.__x64_sys_timer_delete.do_syscall_64
     12.47 ±  5%      -7.8        4.66 ±197%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      7.83 ± 14%      -5.5        2.31 ±200%  perf-profile.calltrace.cycles-pp.epoll_ctl
      7.30 ± 15%      -5.4        1.89 ±200%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.epoll_ctl
      7.22 ± 15%      -5.4        1.85 ±200%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_ctl
      6.96 ± 16%      -5.2        1.74 ±200%  perf-profile.calltrace.cycles-pp.__x64_sys_epoll_ctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_ctl
      8.24 ±  5%      -5.1        3.13 ±200%  perf-profile.calltrace.cycles-pp.sock_close.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.21 ±  5%      -5.1        3.12 ±200%  perf-profile.calltrace.cycles-pp.__sock_release.sock_close.__fput.__x64_sys_close.do_syscall_64
      6.49 ± 17%      -5.0        1.48 ±200%  perf-profile.calltrace.cycles-pp.do_epoll_ctl.__x64_sys_epoll_ctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_ctl
      8.04 ±  5%      -5.0        3.06 ±200%  perf-profile.calltrace.cycles-pp.unix_release.__sock_release.sock_close.__fput.__x64_sys_close
      7.98 ±  5%      -4.9        3.04 ±200%  perf-profile.calltrace.cycles-pp.unix_release_sock.unix_release.__sock_release.sock_close.__fput
      6.74 ±  6%      -4.4        2.31 ±200%  perf-profile.calltrace.cycles-pp.accept
      6.64 ±  6%      -4.4        2.27 ±200%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.accept
      6.63 ±  6%      -4.4        2.26 ±200%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.accept
      6.20 ±  6%      -4.1        2.10 ±200%  perf-profile.calltrace.cycles-pp.__x64_sys_accept.do_syscall_64.entry_SYSCALL_64_after_hwframe.accept
      6.19 ±  6%      -4.1        2.10 ±200%  perf-profile.calltrace.cycles-pp.__sys_accept4.__x64_sys_accept.do_syscall_64.entry_SYSCALL_64_after_hwframe.accept
      6.01 ±  6%      -4.0        2.02 ±200%  perf-profile.calltrace.cycles-pp.do_accept.__sys_accept4.__x64_sys_accept.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.81 ± 25%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.0        0.97 ± 28%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.06 ± 49%      +3.1        4.12 ± 34%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.06 ± 49%      +3.1        4.12 ± 34%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.06 ± 49%      +3.1        4.12 ± 34%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00            +5.6        5.63 ± 46%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +5.7        5.67 ± 45%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00           +15.7       15.68 ± 47%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.00           +21.3       21.28 ± 47%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00           +40.9       40.95 ± 47%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00           +41.4       41.37 ± 48%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +42.0       41.99 ± 48%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00           +44.5       44.54 ± 48%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +48.5       48.47 ± 48%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +48.5       48.52 ± 48%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +48.5       48.54 ± 48%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.00           +50.0       49.95 ± 47%  perf-profile.calltrace.cycles-pp.common_startup_64
      0.00           +53.4       53.44 ± 49%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     95.41           -58.4       37.05 ± 69%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     95.14           -58.3       36.84 ± 69%  perf-profile.children.cycles-pp.do_syscall_64
     46.07 ±  7%     -45.8        0.23 ± 56%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     49.49 ±  6%     -45.5        3.96 ± 72%  perf-profile.children.cycles-pp._raw_spin_lock
     25.72 ±  7%     -24.5        1.22 ±158%  perf-profile.children.cycles-pp.timer_create
     25.54 ±  7%     -24.5        1.09 ±160%  perf-profile.children.cycles-pp.__x64_sys_timer_create
     25.44 ±  7%     -24.4        1.04 ±159%  perf-profile.children.cycles-pp.do_timer_create
     23.82 ±  5%     -23.0        0.83 ±150%  perf-profile.children.cycles-pp.timer_delete
     23.65 ±  5%     -22.9        0.73 ±147%  perf-profile.children.cycles-pp.__x64_sys_timer_delete
     23.31 ±  6%     -22.7        0.57 ±152%  perf-profile.children.cycles-pp.posix_timer_unhash_and_free
      8.05 ± 14%      -5.7        2.31 ±200%  perf-profile.children.cycles-pp.epoll_ctl
      6.99 ± 16%      -5.2        1.75 ±200%  perf-profile.children.cycles-pp.__x64_sys_epoll_ctl
      6.52 ± 17%      -5.0        1.49 ±200%  perf-profile.children.cycles-pp.do_epoll_ctl
      6.78 ±  6%      -4.4        2.33 ±200%  perf-profile.children.cycles-pp.accept
      6.21 ±  6%      -4.1        2.11 ±200%  perf-profile.children.cycles-pp.__x64_sys_accept
      6.20 ±  6%      -4.1        2.10 ±200%  perf-profile.children.cycles-pp.__sys_accept4
      6.02 ±  6%      -4.0        2.02 ±200%  perf-profile.children.cycles-pp.do_accept
      2.93 ± 30%      -2.9        0.04 ±113%  perf-profile.children.cycles-pp.__mutex_lock
      2.44 ±  9%      -1.8        0.61 ±139%  perf-profile.children.cycles-pp.init_file
      2.19 ±  9%      -1.8        0.38 ±165%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      2.30 ±  9%      -1.8        0.50 ±142%  perf-profile.children.cycles-pp.security_file_alloc
      1.47 ±  9%      -1.2        0.28 ±158%  perf-profile.children.cycles-pp.security_sk_free
      1.33 ±  9%      -1.2        0.16 ±163%  perf-profile.children.cycles-pp.apparmor_sk_free_security
      1.40 ±  9%      -1.1        0.25 ±182%  perf-profile.children.cycles-pp.security_socket_post_create
      1.39 ±  9%      -1.1        0.24 ±181%  perf-profile.children.cycles-pp.apparmor_socket_post_create
      0.66 ±  7%      -0.5        0.16 ±155%  perf-profile.children.cycles-pp._copy_from_iter
      0.36 ±  7%      -0.3        0.09 ± 84%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.14 ±  9%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__memset
      0.12 ±  5%      +0.1        0.26 ± 29%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.12 ±  9%      +0.2        0.27 ± 43%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.2        0.18 ± 62%  perf-profile.children.cycles-pp.__perf_sw_event
      0.06 ± 12%      +0.2        0.29 ± 39%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.3        0.26 ± 62%  perf-profile.children.cycles-pp.__memcpy
      0.10 ±  6%      +0.3        0.37 ± 25%  perf-profile.children.cycles-pp.lookup_fast
      0.10 ±  9%      +0.3        0.41 ± 44%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.06 ±  7%      +0.3        0.38 ± 40%  perf-profile.children.cycles-pp.step_into
      0.01 ±203%      +0.4        0.40 ± 50%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.4        0.41 ± 59%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.01 ±203%      +0.4        0.42 ± 48%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.17 ±  5%      +0.5        0.69 ± 40%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.26 ± 10%      +0.5        0.81 ± 25%  perf-profile.children.cycles-pp.process_one_work
      0.03 ± 82%      +0.6        0.60 ± 47%  perf-profile.children.cycles-pp.sched_clock
      0.10 ±  6%      +0.6        0.68 ± 42%  perf-profile.children.cycles-pp.read_tsc
      0.01 ±200%      +0.6        0.65 ± 46%  perf-profile.children.cycles-pp.native_sched_clock
      0.05 ±  8%      +0.6        0.69 ± 47%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.12 ±106%      +0.6        0.77 ± 43%  perf-profile.children.cycles-pp.newidle_balance
      0.27 ± 10%      +0.7        0.97 ± 28%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.8        0.80 ± 48%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.11 ±  5%      +0.9        1.00 ± 35%  perf-profile.children.cycles-pp.walk_component
      0.00            +0.9        0.89 ± 50%  perf-profile.children.cycles-pp.get_slabinfo
      0.86 ±  6%      +1.0        1.84 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.09 ±102%      +1.0        1.11 ± 45%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +1.0        1.03 ± 51%  perf-profile.children.cycles-pp.slab_show
      0.01 ±300%      +1.1        1.07 ± 50%  perf-profile.children.cycles-pp.schedule_idle
      0.08 ±  7%      +1.2        1.26 ± 46%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +1.2        1.19 ± 50%  perf-profile.children.cycles-pp.seq_read
      0.10 ±103%      +1.2        1.30 ± 48%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.25 ±  4%      +1.2        1.48 ± 32%  perf-profile.children.cycles-pp.link_path_walk
      0.10 ±102%      +1.2        1.33 ± 48%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +1.2        1.24 ± 51%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +1.3        1.26 ± 53%  perf-profile.children.cycles-pp.main
      0.00            +1.3        1.26 ± 53%  perf-profile.children.cycles-pp.run_builtin
      0.02 ±159%      +1.3        1.36 ± 35%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +1.4        1.41 ± 44%  perf-profile.children.cycles-pp.rest_init
      0.00            +1.4        1.41 ± 44%  perf-profile.children.cycles-pp.start_kernel
      0.00            +1.4        1.41 ± 44%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +1.4        1.41 ± 44%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +1.5        1.50 ± 50%  perf-profile.children.cycles-pp.rebalance_domains
      0.12 ±104%      +1.6        1.75 ± 47%  perf-profile.children.cycles-pp.load_balance
      0.00            +1.9        1.91 ± 49%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +2.0        2.04 ± 45%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.00            +2.2        2.21 ± 50%  perf-profile.children.cycles-pp.menu_select
      1.97 ±  9%      +2.6        4.57 ± 13%  perf-profile.children.cycles-pp.__do_softirq
      0.07 ±  8%      +2.7        2.78 ± 49%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +2.8        2.83 ± 50%  perf-profile.children.cycles-pp.execve
      0.00            +2.8        2.84 ± 50%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +2.9        2.86 ± 50%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +2.9        2.88 ± 50%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +3.0        2.96 ± 49%  perf-profile.children.cycles-pp.vfs_read
      0.10 ± 64%      +3.0        3.07 ± 39%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +3.0        3.00 ± 49%  perf-profile.children.cycles-pp.ksys_read
      0.10 ±  8%      +3.0        3.12 ± 47%  perf-profile.children.cycles-pp.ktime_get
      1.06 ± 49%      +3.1        4.12 ± 34%  perf-profile.children.cycles-pp.kthread
      0.00            +3.1        3.11 ± 50%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +3.2        3.15 ± 49%  perf-profile.children.cycles-pp.read
      1.06 ± 49%      +3.2        4.22 ± 34%  perf-profile.children.cycles-pp.ret_from_fork
      1.06 ± 49%      +3.2        4.26 ± 34%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.22 ±  6%      +3.3        3.56 ± 47%  perf-profile.children.cycles-pp.exc_page_fault
      0.12 ±  5%      +3.4        3.50 ± 48%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.15 ± 30%      +3.4        4.54 ± 22%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.38 ±  6%      +3.8        4.18 ± 43%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.22 ±  4%      +4.4        4.62 ± 48%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.24 ±  4%      +5.9        6.12 ± 48%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.31 ±  5%      +9.3        9.57 ± 48%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.32 ±  5%      +9.6        9.94 ± 48%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.47 ± 23%     +14.9       16.37 ± 41%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.50 ± 22%     +34.0       35.52 ± 45%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.10 ±103%     +41.3       41.41 ± 47%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.10 ±103%     +41.4       41.46 ± 47%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.11 ±102%     +42.0       42.13 ± 47%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.11 ±102%     +42.2       42.27 ± 47%  perf-profile.children.cycles-pp.cpuidle_enter
      0.11 ±102%     +45.9       45.97 ± 47%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.13 ±103%     +48.4       48.54 ± 48%  perf-profile.children.cycles-pp.start_secondary
      0.13 ±103%     +49.8       49.92 ± 47%  perf-profile.children.cycles-pp.do_idle
      0.13 ±103%     +49.8       49.95 ± 47%  perf-profile.children.cycles-pp.common_startup_64
      0.13 ±103%     +49.8       49.95 ± 47%  perf-profile.children.cycles-pp.cpu_startup_entry
     45.52 ±  7%     -45.3        0.23 ± 56%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.13 ± 10%      -1.8        0.36 ±167%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      1.29 ± 10%      -1.1        0.16 ±163%  perf-profile.self.cycles-pp.apparmor_sk_free_security
      1.36 ±  9%      -1.1        0.24 ±181%  perf-profile.self.cycles-pp.apparmor_socket_post_create
      0.65 ±  7%      -0.5        0.15 ±153%  perf-profile.self.cycles-pp._copy_from_iter
      0.35 ±  6%      -0.3        0.08 ± 87%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.11 ±  8%      +0.1        0.26 ± 30%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.2        0.25 ± 66%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.5        0.49 ± 48%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.09 ±  7%      +0.6        0.66 ± 43%  perf-profile.self.cycles-pp.read_tsc
      0.01 ±300%      +0.6        0.63 ± 47%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ±109%      +0.8        0.86 ± 46%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.9        0.88 ± 50%  perf-profile.self.cycles-pp.get_slabinfo
      0.78 ±  6%      +1.0        1.76 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.08 ±  7%      +1.2        1.26 ± 46%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.07 ± 12%      +2.6        2.63 ± 48%  perf-profile.self.cycles-pp.ktime_get
      0.04 ±141%     +22.7       22.74 ± 48%  perf-profile.self.cycles-pp.acpi_safe_halt




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


