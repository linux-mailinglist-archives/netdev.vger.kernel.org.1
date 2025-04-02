Return-Path: <netdev+bounces-178881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9653DA79543
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E68917080E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9BE1DB346;
	Wed,  2 Apr 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpYAtbDY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE44198833
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619338; cv=fail; b=J4ctlUmElOJqx2wnTA3JllkGgtdZCZGSneSAW22ZFhQB4ZfsDE0O5xM3tRqSebxUbdO4raR/tlguho7YO3tLQ60Nsri1lUMiKuvMTsgTk6UkIJ/je1tiskPfDq9Z/mLR9K1NsH40tZw/vGNja3jt8NsPHdJceCSUdsJNCI/KuUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619338; c=relaxed/simple;
	bh=aHoYR4YGBirUJNgyLwU5ZqDwALgzVGbfjwsTjwl4Vj0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KxUimqx9n+rwsR/x6daX9etDbEchbLYVVwynfANOuN7Z/6YsVYxHGwcAuQKPGd4w2KiBSRYXbbaOHJvyHoxXpkTPpTeFIP/IRhOtg0hC9UiQMUPRcpbcAu9Ez0pmcZ0l8jn8Eg2pCcmxUHNdPRr4QzMlbuQeSiDbJ0yyv/AmReA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpYAtbDY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743619337; x=1775155337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aHoYR4YGBirUJNgyLwU5ZqDwALgzVGbfjwsTjwl4Vj0=;
  b=YpYAtbDY5VAWi9AuQZSfWz3fxj8EXQTvouziINwCT0DQ+qbO6mm8ezy9
   lyUEml+mwnmi4q1qLgHyat+pmYb6FhDRZ3dGzPj4WUl77A6dZ5WaqcweM
   ojxsbLhl+/gvRzbTNCXLfZ3YDUdgiBxhlG5oWoyD0qEzBUlgqqAxJTIN+
   aaiHOJ5FugrbDz15uynlpqwPiX0pgjQEcSb5R7FOmDh0eZY5JDoi0aqKw
   73YO86RpielA560rOBIBTYXPNXawUmr1K7R/7yMA8cYbSSKw/SI0SGs1j
   TkNyD0Y4ygKhqQQHwKOWvu8W3JfBDs6JdikBRYgWz+Rhr8byGmch4QzdS
   w==;
X-CSE-ConnectionGUID: SG9KLhmOTgS4ch5VC3ph3Q==
X-CSE-MsgGUID: Sg2k3Vy6Qj29s4BmbKEdRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="32609598"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="32609598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 11:42:16 -0700
X-CSE-ConnectionGUID: PMFwc1lyQsOfKzJJSb9aNA==
X-CSE-MsgGUID: bVVFA+HRQfe0lgoRb11NaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="127042676"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 11:42:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 2 Apr 2025 11:42:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 2 Apr 2025 11:42:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 11:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui5phgDgW/MHBxNa4TtAw8nr9uWa4ATA7w+v77dicKRd54K16sJfyYw7e/FhsEmK+77syUXQqIyMwwtu+M673XkQSjUH+Gwb0uxYWzpeTLcCvVmQB2zSoM5jGgMtvprnViLXbi3Myz6J0XOthsjjjUbdWYNOlzymXqJQkKskXhg8IqNNIeQJBngpHk9HfIm5HPcerDZLrK+Un+ZuLjCV/TkY4HPwIHzoPdEEDqjMljxDnL8SkaRd6Cg3bAYCWtN+MTs657ev15xarLwbvj7bz69dU2CzMTnHi3ylcfZVbeesfC2i4bqiPkbT6sqLExEI3hOie48FF2CiAzYcANeKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKsb5aGsTdcIqBdLQrbcRE2I/qZ1ZlApCpBTVE5atz4=;
 b=VVyELsyLugobByJDklmk7C8V9jg+8ormefhOlZEwORbv6ULAQHJIyHBbQbqFphBELBGs914vrmoQ1urD5pN5fO3OA45UHmhK1u5IPhWzpz/b3H9vmx/vC2/X/rDLS81HeYrAHe17nX/EYWuVHATm3tzVI3/GB1PNiGoas9GS5J9FEhTjgXL4gy84kQrgoeJ8xV1JOqVeuXZGdiL6xddTUFGlASNvHmk/GyqCdUkO4TwF75z8gEuydgzH8fKEi2YSJO/G9B5+oxvHi9CtQVCG2M4123FpgQnfhu/hc71SNQcv87A1QLxAaYAxdmhLnRmHX17z8LWV8zHGuPXauy4N5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5951.namprd11.prod.outlook.com (2603:10b6:510:145::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Wed, 2 Apr
 2025 18:42:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 18:42:10 +0000
Message-ID: <8d80d403-12cb-4834-a0c9-bff49de3164a@intel.com>
Date: Wed, 2 Apr 2025 11:42:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] netlink: specs: rt_addr: fix get multi command
 name
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>
References: <20250402010300.2399363-1-kuba@kernel.org>
 <20250402010300.2399363-3-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250402010300.2399363-3-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c48a490-129d-45cc-4c34-08dd721613c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXZUY3k0T0ZhRGZKZkNiS21lcFhOTlBMcW1qa3lWVXpPRXprVWc1RXRCUFdp?=
 =?utf-8?B?Z01pK3NYZGFPeXB0eEdKdC8yVDhHbzBML2huWXNUVlErcE11Q0tleXJhaGIw?=
 =?utf-8?B?dVZXaWlTaHVUcnEvRGRRN1BESnp6V2hQZHJIODYvVzFldUQySlVGWHAwdGhz?=
 =?utf-8?B?OXVDTlJST2tFOVBHb0k0U2pXcHVseGRkWk1neCtUREROTDhZd3prcDJPUmg1?=
 =?utf-8?B?bzliTXhnWE9IT2pxT3BPYlUvWHJ6WXdKanV1c1VZU2NTUlR2bGVEZGNPbzR3?=
 =?utf-8?B?d0grTG1RUnZtSWdPSzFPb2VGa0k1ZUE0aEVsNHZ0c3FkbEdWUWNLNndISHVY?=
 =?utf-8?B?eFhDQ3VkSVdiTmhJY1FFTkx3b1JuVTArTExWdVVONDMwTkw1bG05TlFIMDF4?=
 =?utf-8?B?MEtpdFhqVjN4UmwyUFpDQmc3UDd1dHdqd003NGJMRStudWdrYUVTS0ZwZEJN?=
 =?utf-8?B?YkFnYXJrb1k4Wm9zVjFscEJ4RUVxV3VYdEdjbTBVNkVLSHFIa1Ard1pZLzN5?=
 =?utf-8?B?UlVTTmdyUjdibTgwVEpvZzhTOUFRa1ZtdzhBQ3NTS2NZMTA4U1h3WkpBWWFX?=
 =?utf-8?B?M2hmVlV6WUgxOTdLbkxIUE8vMHpNcDFEaytXMmZ5WlVMMS8rd2xUVk91Y2N2?=
 =?utf-8?B?amR6OFJ2blNxSnVxcEYrYXVPaURGeWxxK2d6TXN5VlordkJJZHl6MUEzTURD?=
 =?utf-8?B?RnladXkwTVNIelhVdUZDMkM3dG5EdkVlL0tuc0I2NitSajZiMWJrTS9haVFN?=
 =?utf-8?B?RWU5TmUvV2syT2pQWFphVGlXNFFmdHF2RHpNMjlrK3BDRTVjVkxBWFh1enhO?=
 =?utf-8?B?d0xBaDBKOFhIM2kva3RCTGRXK3VxdTlCRnQvdDNlcnRiQlk4ZWhIeHZhNkln?=
 =?utf-8?B?RjF1dW5tTTJtVHc0TyttMURQSFBwSGJpekZWQ1ZlTnA1bG16UGhVLzhpUVZY?=
 =?utf-8?B?dE8xQWFmaEVIdVFtd0p0c2N4MVFWS3VrSU5aNzRhMHFJRW5RMjZzamE4NG9F?=
 =?utf-8?B?SEQ3NEVvNFJFV0M5OEVvOTJwTU1NekR2T28yT3RrK21mVFhscFhxeWpLYnZy?=
 =?utf-8?B?aXZVcXRxaEZ0TWYwT3hWcmwwNjhMK250QnNIN01jVUxtdjk0aWZ3Wm41UlV4?=
 =?utf-8?B?TXI4UVB5WmdES2dWUjRSZnVyNU5IL1B0UzZ0ckdJSDFhUi9CYVBDUU1QV1lN?=
 =?utf-8?B?RTI1Y0JCY092bXFEalc2MitnMG9nbDR3TVIzMzVYMnZpNHAwWTc1cEMreDVL?=
 =?utf-8?B?R3llbVRGbW9NSnRVcHVGeE5GRVcyakthMk1LeWZTYmlBZ2M1WlRISmFzclRw?=
 =?utf-8?B?VEdpK2lvNTBTWXNXYVplQ3hNYmNWSFQ4dmhxOHFIRnROWXpqbC9NdHFuWEpX?=
 =?utf-8?B?aXBUMXZpU3FaUzJ5Q3Zzb2x0RktEenZtSE1qTkhJcms2NEZJQVlpLzkxWXd2?=
 =?utf-8?B?TE5QZ0dpM1EzSGVwZ0wwaytZNkdiVjR4ZDBidHk1UXp0SDNZejUxRkltOVNy?=
 =?utf-8?B?V0xiWUJOalZGVUdVZXRoeFhHT3FteFJxL1lGTW8rc3lmSS9sVXFod09rSjlM?=
 =?utf-8?B?RG51dFMzU1cvSEIvcGtGdytDaGpPY2RWdFAvQy9KNjFEamFYYmFpVmd4Z3cy?=
 =?utf-8?B?cUYza3hPdHR0WHBNQnMxaDZ1c0J3cHkzbjYvRUdqYzJGYi95RXJOZmFzK2Q5?=
 =?utf-8?B?RVBtYXAzejlGQ3o3VmdRM040NDdralJMOElHNEFQT1RCYnNsYU1USGxicU9W?=
 =?utf-8?B?VUwvM1dMZEpaVkpDeEJXRURrRzljS2hhaUxsenQ0S3ArUXdkeThiTG9hV2lt?=
 =?utf-8?B?azlINkpERXRnT0dFc0IxWXJ2eW9HYWZmVUI5dmtlNWJtMmoyZ05EdXBFTEdv?=
 =?utf-8?B?Y09zODZhZDhkWUh4S2IrNTZ5WjUwdXFLNHp5MWhsS2FKRjJ0T0l2VDUxOU9G?=
 =?utf-8?Q?I+pVWR29UgI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azI3cVhRQkZETlpxVWdRRzd5MEZvMVU3eTQwZTlDRy84emxualJjV1A5SXRq?=
 =?utf-8?B?eWRLWXRJRUdjeXh2YVRtVC9YRUNtTHozcWcvZlpwcDg4b2pGN3J3b3QyNzBa?=
 =?utf-8?B?OGdkaDVVRGliT1p6VDFud0IrWC91L2c1R3Rsd2VzNHZBOS9ENnRROFo1eklq?=
 =?utf-8?B?ZnA0VmVhVEVQUENMS21jcnNERkM2YVBxdllHd0g5bHFqcW82QjRYRGZCVmRw?=
 =?utf-8?B?bWlPU0RiQTBkM3o1dXNrRjlSblNXMG5tL0lTZWR1anpmU0dqSnhvcHhIcTlW?=
 =?utf-8?B?VWNIUmJuSnBDNU5ieWxjL0c5RVR5NG1BRkJXQTR1VTJRR3ZZMExjMEhES0hl?=
 =?utf-8?B?K3FiazZiVmNGb0ZVYmI5ejNYMlBrLzNnZ1FYRzdNRCsxY2ZWa2NkZk9MbWJl?=
 =?utf-8?B?T2VJU3QwdEtUcXNWSGNCOHllWCtnMmdWUnpYb0NKbWkrVUMxYTNZMzZsUVRW?=
 =?utf-8?B?emFTU3l3MmVaWDlBbGowMWcvV2xnUFQyeEpsdjhjRVhKcnpWaSt1dmhSY0xZ?=
 =?utf-8?B?bzlZNW1PQkpLTU5HdEJPL0ZiRHFuVEZXN1A0NGQ5cEl6a0ZCMzc5NTFZRlhm?=
 =?utf-8?B?Ukk2RkZpa2NQclZKQmhRSWpwV2dkNXV4Qm8wYjdPYit6Y0xsQ3hiMkhCSExy?=
 =?utf-8?B?QTRqUmpsQVZxaVhoRWxnMTlBTnp5bWdmNWVzMWd4a0xKZmxyWTRiRkR4UUlN?=
 =?utf-8?B?SEdhYVpoOTNXU0VhYmxXUHdXajNpeW1uV1owSDhnTGRDL3FSRFFMR1FBT1dq?=
 =?utf-8?B?VStHSjU4clBWRlpIVGdKZVBVRTJOVjlYbUtDVmtId3FLTDBoOW90NFZ5dzN3?=
 =?utf-8?B?TTF5MWFhM254N0dlRE43Y1FUVEdveFAxc0xaS3RkUUtDc0NHQTdKVXZGMVpV?=
 =?utf-8?B?d09xOW1iVTZGSk1Gd1c4VXBuYlBlNVFQdThnS3hESlVPUDRJSUloUmQranFk?=
 =?utf-8?B?MVpYc0J2VloxbS9tUzNSRXhyQnFscm1TanBuQmY3TzBibGd5Y3ZzSGJ1S3VX?=
 =?utf-8?B?d0pFa1hOTERldjVselp4dFZSUzBURVdyZ1JzaDNrTVlUbGJ1RUI1VDhmZ2Mz?=
 =?utf-8?B?anFPb1NpU0h3aW04Q3RWK2o5VUJnVGROczU2ZFpxYmQ0VEZ0a0JhS2xqNEtW?=
 =?utf-8?B?ODF1R3U5QXpQLy9sc1FMN1p0NHl0UWVXdkpGb1NjaGJTcUFFOXgvN2hhREN3?=
 =?utf-8?B?WEVlQThXaGRYYTBkNk50VTFMVVRVLzJwQmlqZ1NFZ0h3eFBBajIwSkViRng5?=
 =?utf-8?B?YVFJbzFYd2F1VUtSbk5Bb2hOM3BsV1J0OS9kVG8vZE9EMkl1QzA1Qnp6VWpT?=
 =?utf-8?B?Tk9TY2VMYUxoNDBPWG9IcVJiWWg2N0dDVjJFdUx1ZU9nS2VHVlZPeDR6L3Jm?=
 =?utf-8?B?OWtPa2VQc3draE1oWHBLQmJ4L0lpR0JwckpteGJPZXZXMnN6MzdrMnZCN0Zs?=
 =?utf-8?B?eDl6UlZUb0Irajd4MHBGdjBqS0dRdGx6d3hhUENxWVRDaTVGTk94R2RLaVdJ?=
 =?utf-8?B?czdJeWhzUUpROWJLU25FeVpDRDh4bXR5dkIzUHNyNXF1WVJyZ2NBNkFrV1ds?=
 =?utf-8?B?TW5iYmNRVUdxVnBaY25PNXBBa3l6RDRDcWFScWlkaGNCYVB6R0h6VmpIc08w?=
 =?utf-8?B?ZGxHV3VkbVJtTGo5dk1uMXFvcnJ2OTZMTkZKcXZ3Zm9WZjZJaWlIR1FIQ1dj?=
 =?utf-8?B?OG40c0QyeWtiOXB1R0p3ZGFrRkVXSkpJYzVpbEg5MUduSER6NnhCOThIRE8y?=
 =?utf-8?B?S1ZkN0FzNDRKbTRVcG10akhOczV3Q00xZ2ozZWZ1aFF0TStBNFZXWllrMmdq?=
 =?utf-8?B?Ujl4NFh2VXdpMmhJcVQwNXNhV3AvWHpxc2hsMU9lUGVVVUx4MkoycWltcGhM?=
 =?utf-8?B?djVDSDNXWUlHMG9TTWNOUnhORDZYcncwSDF4UnFIZENPZ083MmFyWHJXY3BB?=
 =?utf-8?B?WFpqdWNYTnMxcXVpcFk0NndJZ2o5MEFvMCtQWHBGdTBlcndoRUhORkg0NkhG?=
 =?utf-8?B?NXo4MXNhM3NCU2Q0MGdRSFVEdWhML2wxaUtlWi93WnhPbllKQlVaQmxjeDFN?=
 =?utf-8?B?djBQMzhZMURLckRvTFBJWktvVmNxUTY2Z2JBOUFTM0lRUFJ1S0RNMTExeXpY?=
 =?utf-8?B?RXBZWi90b2p4L09SUEJlS3BsQjlDemdlN2FDMyt5M0Yrb0VRVHJ0TjhXSkgw?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c48a490-129d-45cc-4c34-08dd721613c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 18:42:10.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAeLYmWmAZCbnX62IocGvb4zp5cQ2PQ9Av+6v2RwAuoaIG5GdkINhzpCwCeW+oqUcjmzSt9cSPaJ3iQRDHk2nJFoL+1puNEwUeYtg3FdcUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5951
X-OriginatorOrg: intel.com



On 4/1/2025 6:02 PM, Jakub Kicinski wrote:
> Command names should match C defines, codegens may depend on it.
> 
> Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/rt_addr.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
> index 3bc9b6f9087e..1650dc3f091a 100644
> --- a/Documentation/netlink/specs/rt_addr.yaml
> +++ b/Documentation/netlink/specs/rt_addr.yaml
> @@ -169,7 +169,7 @@ protonum: 0
>            value: 20
>            attributes: *ifaddr-all
>      -
> -      name: getmaddrs
> +      name: getmulticast
>        doc: Get / dump IPv4/IPv6 multicast addresses.
>        attribute-set: addr-attrs
>        fixed-header: ifaddrmsg

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

