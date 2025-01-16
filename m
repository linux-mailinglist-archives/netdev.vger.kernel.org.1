Return-Path: <netdev+bounces-158905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB4A13B72
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF82188BDCC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8296622A803;
	Thu, 16 Jan 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN5YWLla"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F891F37B0
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035967; cv=fail; b=HG95gnRKVT5NNIrF9sSggHZ3GUaFZVl/k0o9pRneKQjgrw67AvMLUzAKRCA8pNxouzSQph0qO1GmLKZwUJm96K1aDSaDPDf7tXFBAXUGw8nsK7dgYvgiC8UB9mJDyMzJ6OoZ9qvw3PgWGeEJcb0UT1BT78ffU/4TqUn1ZX+f4Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035967; c=relaxed/simple;
	bh=II20p07GFfa5Vvmb2W70tTLX2rPQ3R4Kc/87PxZYoYM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=minoDJxfCfBLsNH3QjMtuVPTq6V5fmuVE0pEBufoyfI5GDSFaP7hednwn2SafW+sRWy3e4sZz0WcQZuw0tCTHOWRhaB4n2lF+cfWzIR632ezETr4StNKEEghcFIhmw9FTyl8X0zIBmlnzgEPBGdt1jexdnc5b+81lA+gQ19N9pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN5YWLla; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737035966; x=1768571966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=II20p07GFfa5Vvmb2W70tTLX2rPQ3R4Kc/87PxZYoYM=;
  b=TN5YWLla03FU/W/jgLRpG79AXafaOCtpQ85bC4d75eYtMJNnH8anzTwl
   Qq4wAUuGKwOOFXGfhvTIBwsoIamMiDBO/SJWt43H2WmqJ+5BKCFUKiQuR
   I7pXXFiFIBZyfuMy3dOIKFOKK9J9l1DJ1uuCWXIwYT3mRKoYkV0dwttGG
   gSdiRB2J5EQSP819R8YKEcjy84SKki+oj6LcIYeC7oUu+K6Z9sBSvmJJO
   jJxjsAtYDJznWqCX7Oiu0EMTL3oIlLGLyZk3U/esyc8IbjTxRMZ3ejmmk
   QAcvPuaWVsEFoaFTyPVYtVuNVKhnmxGLGB5jvqudWHsRNLFjrOeC3wvSi
   Q==;
X-CSE-ConnectionGUID: 8igwYnX/QrGfsLefTw9Ksw==
X-CSE-MsgGUID: nime2uSFROargKXLnHuo0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37337217"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37337217"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:59:25 -0800
X-CSE-ConnectionGUID: Nd5h25JURAmQpbgrnwT9ow==
X-CSE-MsgGUID: FruA4E3DQe2PAQ2dn1ZeSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105548267"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 05:59:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 05:59:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 05:59:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 05:59:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0LyWpD5nH1Fo0nZRn9dvoHYacDxbiy7ZFxys3hZo0EDj4Y6pwoMY5B/fJJoFRM+1QbhRkj5NRafzfEi8wXWfGrRlIhNhuw/igZsFKj/KHbrTXOOpJENGqHRguwEcFIDpTT5FWUuD+Mik2hGsFf2d/h8QgzR5YcwJJn1EKS2MVo6N+9A09synY0CNHn6Ssc0BSX/y87aPRn8GiZGVOHAMOVmP8GHt8baDcs4IetlOPN8NNtUwh5zgIFotACqtfwRsdf041LeHvlCuHuopG2fBswOBJ/4WqJwJEq2P0Me90E0Kd2r0hhbq/cVBoR6SwgLwIf4k2Oe9vLlxYHAL4Ix+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAF7XamrLM2NNWuD9TmwnrfRkLgDY14iq7shK4osgmU=;
 b=YXVfQm2Kfv9JAst+Pp8Y9VruNVGwrzsa7ZWZt575Pn1rTdCO+FlIe8oFZfTqowCaWWQYli8CtvEt6t03FWTzJZFBGwN6R4DFDHd8swLI8OeXBKPMNr2pr1eIjY/NqvamEuNALJ7GP8Lw9EfE8kIqY+mrFTl1Lh5M4rEbS9gFpju0Aata1HYmRxT2pNzUw6dYi7M7v7WNr76LsOS0dmTOHSVCvRSN9/pWS/mLTyWKrmli5zjFQurlxb49Y3MHUm+TGAyLy5OfhZADolDp6lb2WmSrKG+KaYsCuAmP3nj1T/LMbXCluE5T7DpyOVVSzXzUDLBiibmnHuVt6NONwmMjyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 13:59:07 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 13:59:06 +0000
Message-ID: <e32387f1-fcf6-41fd-89a9-0b54637c99c9@intel.com>
Date: Thu, 16 Jan 2025 14:59:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: avoid race between device unregistration and
 ethnl ops
To: Antoine Tenart <atenart@kernel.org>
CC: <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
References: <20250116092159.50890-1-atenart@kernel.org>
 <8fdd6e04-c7ae-4d2f-b984-98d41d4ef8bc@intel.com>
 <173703522332.6390.7759526922746662664@kwain>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <173703522332.6390.7759526922746662664@kwain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BY1PR11MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: d67d1c0b-2a6d-472c-202e-08dd3635f116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3l5UE1ZU0xQYnJlRUhFc2NlSnVCQUdCOU9nVzg3bjNNR001bTVVUzZ4VFZ6?=
 =?utf-8?B?UHBNbDhZWFhkazBFT2w3OFoxbk4vRGY1ekgyYklnTWFXdFVpZjAyZkMwVlBH?=
 =?utf-8?B?QlExWHkrOHJFVGNVbUU2dkJ3ejh0TjhhVjBldFZJVkY2TUR5eTZ3dkQ0Ritn?=
 =?utf-8?B?alZ2dTYrRDlLeTNVRFM4c21PQTd0RE9XYVc1ZURaSjE3TTlmUjdOTDNWQnBi?=
 =?utf-8?B?NEx1eWR1RUdlK25jVW1QdmFGaDF6VGdnOXNrSEVGUXR6dkVXcEFxTFZLQjVl?=
 =?utf-8?B?emNWcVVsVDZsSUVMNXQ0L3JwRDA2T0JsS282cDZwOFJUZiswOGwzZVVML0oy?=
 =?utf-8?B?a0F1WlcySWRXMTVXUXFkRGwvUFVrN01RbVNrM2dpYzEzdWFhQm15dnZkRXl6?=
 =?utf-8?B?M0ZPZEVFRkJEYUtXazk0eDNaUjRUR0pNQ2ZhRGo1VUxFbG1CcEV5NC9aUFpp?=
 =?utf-8?B?WnI3ZmVLekhDeFRRK2xjV2l2eGY3VVVRNTlFUGFCUG1BaVFIcnloN01NWHFQ?=
 =?utf-8?B?TUlFSDdVK2hLd3c4SklNQ3NOQTV5cm9CK3VXU3U4eUxiMzk1Y2dUYnBZMEJJ?=
 =?utf-8?B?M01aZ0FzcXYzNGJrU29qa2oxbzlKeHlyU29MN1YwZ2NTMlpNWXpST1p1RWs3?=
 =?utf-8?B?c0oyV1U1ekQxWWtqdzUzWGtyM1JCNUNmR1kySG1ZRGloMGtSTWlTaWFKSUJ1?=
 =?utf-8?B?azRoWWo4WEtMaDlwWFl3eXFuN1ZvM1lNN3hpMmNDczhxRzFlUTVxMUZJS2FX?=
 =?utf-8?B?SmM1TEVLb3NmbngrbE1KamdJbXNPT1VRSjNSOFc0YTU3Y3VXclE4c2ZhNUxH?=
 =?utf-8?B?K1R4RThCTUhaeTY3U3h3VU9uNWM0a1NIellzS1VBdTErWlpwUTlwVjFBUFNG?=
 =?utf-8?B?TG1aU1VQUnRtSjdRMjFnL3o0dUVSOUFsVTRMek5SWFN4TnhyK0cwRytZdVdR?=
 =?utf-8?B?NXFpMk1ncnhvM2lKcGVXYjExaC9BdFhGbXh4aldiVSs1d3lJWSszTFJRT05S?=
 =?utf-8?B?Z1RlZG9oMDFLem1pbEF1UG9MRmVhWVBRZTY4aDNQdkJuNXNVTVJsalo0L2ZG?=
 =?utf-8?B?VVIxU0VmMWF1ZWorQkNQNjlKcHVDcU0wN3dvMjV4YlRLMFIzV1VCL0J3NTZJ?=
 =?utf-8?B?enc0UUdWKzJQelcxVUZiMWVSNldRK2c1cWxIVWI0cmFibTAxYzZEb1JKRlBU?=
 =?utf-8?B?ZnVsbHpyemsvWWluTXhmTlhnZHdzRmJnRzB6b2duaFpDNHc2Y3J3ZGJkUHZW?=
 =?utf-8?B?Rm5RZEJjWm0xcDdqL1N2ckUrYzlQKzBRZ0x6bDlndmNYdnM0V20rV1FUMSs5?=
 =?utf-8?B?TjNqb2lNa1dyWkprTFpORFI1MmRZVERYT1ltcWNEUlEyYmV4bmtDRXIwV2dv?=
 =?utf-8?B?SzNJb2hQYWpkcmlQVjZpa1k3SDZFNmdLYmpwSnB0UEFyYXBBdmExZzU4d3JS?=
 =?utf-8?B?MFpjMWhHSGJhZ0VxSUMvb1NIU0haU2J6VVlPVlJjeGdtMDd4N3M4ZGZ2UnJK?=
 =?utf-8?B?Y28raENiUXpOVUFiamdyUGkzNWRJWWtaWEZEQTdQL1BMbytIT2ZEMmI3cUlM?=
 =?utf-8?B?WTd1TUFrRythU1ltZlNwTVhEM1lYTFY1US9oam9Wb0huZG0yOWNTSXhPZzRB?=
 =?utf-8?B?cGZ1MWFZa2VkNmdvUzd4dERKVVZKcFZ1dHMyVE9abTNCQlpWTmVodm1PbXFI?=
 =?utf-8?B?blZlL0Y2MENPS3RxUnlpQk0wRTNBU3pqWE1wdE14cjMvTUhTa3hWaFNDWW0r?=
 =?utf-8?B?RlE5ejBaRW1qK2k1ZHYwR3ZabXh5cjdiS2ZucHRNKzZuclNXKzNtblZhWVlL?=
 =?utf-8?B?YWc3aFhNR1I5NWRPNFE1Y2FqVjRSajNCemFZc0pDdkhSR1NRWGFpNndKQzR5?=
 =?utf-8?Q?bVo67npfHCxST?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5lM1E1R1BWcllkczBCS2FMK05TSnpCMCtVQk5tcUhkUkV6WDNYZlF5UHJm?=
 =?utf-8?B?OU5LcUNpelFCUFhmc0g3eG14aHBjcnA0dG82RkExamJRcTg1NmFCZUMxcHFF?=
 =?utf-8?B?OFNNeUJBUTliUG9pU3Z4VnFqa1pOTUZUa2VPTEtDU0pDVm1UcFhoVnJSa3NR?=
 =?utf-8?B?WGpOWGVkZ0hYb3lDdExJM0lncUJ1Y0tkVk5qZHV0cnQ1cVpPbEVyaGw4ZzBO?=
 =?utf-8?B?Vk00L0d4ZjdpVTlXdGRXWkJrdWp3bkRzZjA1MUxjYjJSSDYzclBFSFI5bW5P?=
 =?utf-8?B?NllsNnNNTEp4NzdXM3E5NlNHRTBMN2lEVURKdG5QRTlDUUVqS1UrNHRIZlE1?=
 =?utf-8?B?clJlZmFhN1JMYjlmb1p6UytxU25veFE2L1pINWd5eWdLb3lzaGNPSmxKRjVV?=
 =?utf-8?B?clhrWDBmOFh4ODg5bnlta3dKUWNqNFppTEpMS2I0aU5mSUQ1Ry9XOFhCbGJ3?=
 =?utf-8?B?S0t5cjY1NjVjYy9oWlhINzI3SGhMYW9QY1NEell3d0pPWVNwZlhRVUg5S3NM?=
 =?utf-8?B?Y2VYbTBZanlnNkNUdmtSNTl0OG9GenFiazVvSGVVNG4rN2xIb3pYRU42TjVC?=
 =?utf-8?B?Z3RwU2E4MzJJY2dKUmR3OEtQUk1vQ01CT3lndjEwWHpyVC94S09hY3doNjJv?=
 =?utf-8?B?MWhvMzFVRklJNzFrNVJUaHlhdVEyTlA1NmE5VUxZbGk2L0ZDZ3padjljaXlQ?=
 =?utf-8?B?VVFGbkxxVENqUG5BOEYvU3pGbzlxV3dUcFppZFlzekRMVTNYckhsTDVmK2Jo?=
 =?utf-8?B?cnljazk4enRtd29pQisrYkJ1K0VBbWxNZ09WK0t6OWZQS0wxNHVlUExBQWVP?=
 =?utf-8?B?ZjlHNGlNMWNCT29iTXNyK3FvRHFaK0RsVEdTdGtUaG40TmNHdE0ySXNEczZF?=
 =?utf-8?B?YXQzQmxvMkxFdGFFQWk1QmxhOHBjUTN0b0RIdXpUYUdKaXFBeUtndVFjdEVG?=
 =?utf-8?B?ZG1qUGJoUnM5eGxVOFI4aHAvWjA2c1UyMEZsdlpJK0MyL01ZWGVmeDc1YlZ1?=
 =?utf-8?B?U2toOW5nejE0WllCOXFNRTNIN2FSY0UxNnVqLzloUUl4UUE2MzhVaXlJTFdu?=
 =?utf-8?B?eVFqSHNqbHhURjdrMWQvbVVkaVdBcHltWmJMS3c5MmFFaldqUCt3bUQ5MGZX?=
 =?utf-8?B?WjZyUGw5RjVHRWVUdks0R0xocHNMV1IzaWk4QWpLRTgvZWRZMnk2S1FROXc2?=
 =?utf-8?B?ZVRuR2cvMnRObDNXenI5ZWRVenRQK2paeHhPdSsxdG4vVkNwTWNrNHMzL0t2?=
 =?utf-8?B?ZjRVLzJHbEU1ejBydWt0VWtuQ0hxZVRhSG4vWnRhRWtOYUp0R3c1L2xRa3Y0?=
 =?utf-8?B?Rk9ZN1lkQ1hIdlpqSGRvOWMrQ3BFdkFyZjlvYTIvWWx5dDBzUnVZZWNHTEdp?=
 =?utf-8?B?ak5WbThJakI3QUhWTW1wNUlTbXorbXFUS1d2dEZiTnRmT2U0RXJaQ1FqOUlE?=
 =?utf-8?B?aTFFeHJVOU80NklvUnJkVEVNeHZGSFFOK0dZRzNtc1hDWk5laFJNNEY0R2Nt?=
 =?utf-8?B?ZlN2TVgrUGNRelZVMGtPVHU2bWo4SkhEb2NhVlFOWXdiSDIxREhXT21iT1Ez?=
 =?utf-8?B?b0tzamkxVUtJYjZ4RVp0dnBFMDBlTy9qbUVid2FWSXFHcXJsQXRmbHAyWXJh?=
 =?utf-8?B?L2drOUR2dXhoank3RUNZeitMcnIrd2pxWXBtcDZySjJqL1JGSCtaa05ZSUl0?=
 =?utf-8?B?bmV1VTkvcEU2NnBLTWRTNmlyNlVzdHFxMHVyb0tlOG1xTGs2TlBSSEVYM1NB?=
 =?utf-8?B?cHl6b1ZBTzZpNWZYNlRORzRVZHNwUm5Sa1gxQ01iNGQ4dkswKzR1VHJ1YnpN?=
 =?utf-8?B?bnJwY2JmRmhLNk1xN3RzZVhTcURYSWpOS2tldjJDNVJlUnRBSUFmbUMwdUFB?=
 =?utf-8?B?S1Izc2ljcVdrcCtFMnZwMm8wVHpKUnYzUVhXc1JJMWQwUFZzaDlZeFNCUWhp?=
 =?utf-8?B?N1JNalViZU5DaWl1V0NBL1BOellUb01oRTZjZ0lDK1lvWTJ1dDNTY1piOHla?=
 =?utf-8?B?bmtTRmdnbis5empNZU5OKzl5NFk2YlZnMHY0ZmVkVlNhdU1XckV3aGtvZ1BQ?=
 =?utf-8?B?ZzFRRnF4SktGczFNNnhnNkxJdCtBQk9NeVRHR3Nhd3NXbkdWMkVkQ1hTZDAr?=
 =?utf-8?B?SlA3WmpFTGR5bUluREVIUWduU2RwN0ZDeDlNS1ErU2ZRZmdZbHd2N1FRUFdl?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d67d1c0b-2a6d-472c-202e-08dd3635f116
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 13:59:06.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkrIxmhm6BrvycmYgeQEtBwVRGbz4ObuoUDk/MFRLX6cfu29vdR26U8YiVM0S/7Kn/vb8pj6wabxloVghFpXXOy/5AUQIC8r0+a9sXDRPvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com

On 1/16/25 14:47, Antoine Tenart wrote:
> Quoting Przemek Kitszel (2025-01-16 10:44:40)
>> On 1/16/25 10:21, Antoine Tenart wrote:
>>> The following trace can be seen if a device is being unregistered while
>>> its number of channels are being modified.
>>>
>>>     DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>>>     WARNING: CPU: 3 PID: 3754 at kernel/locking/mutex.c:564 __mutex_lock+0xc8a/0x1120
>>>     CPU: 3 UID: 0 PID: 3754 Comm: ethtool Not tainted 6.13.0-rc6+ #771
>>>     RIP: 0010:__mutex_lock+0xc8a/0x1120
>>>     Call Trace:
>>>      <TASK>
>>>      ethtool_check_max_channel+0x1ea/0x880
>>>      ethnl_set_channels+0x3c3/0xb10
>>>      ethnl_default_set_doit+0x306/0x650
>>>      genl_family_rcv_msg_doit+0x1e3/0x2c0
>>>      genl_rcv_msg+0x432/0x6f0
>>>      netlink_rcv_skb+0x13d/0x3b0
>>>      genl_rcv+0x28/0x40
>>>      netlink_unicast+0x42e/0x720
>>>      netlink_sendmsg+0x765/0xc20
>>>      __sys_sendto+0x3ac/0x420
>>>      __x64_sys_sendto+0xe0/0x1c0
>>>      do_syscall_64+0x95/0x180
>>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> This is because unregister_netdevice_many_notify might run before the
>>> rtnl lock section of ethnl operations, eg. set_channels in the above
>>> example. In this example the rss lock would be destroyed by the device
>>> unregistration path before being used again, but in general running
>>> ethnl operations while dismantle has started is not a good idea.
>>>
>>> Fix this by denying any operation on devices being unregistered. A check
>>> was already there in ethnl_ops_begin, but not wide enough.
>>>
>>> Note that the same issue cannot be seen on the ioctl version
>>> (__dev_ethtool) because the device reference is retrieved from within
>>> the rtnl lock section there. Once dismantle started, the net device is
>>> unlisted and no reference will be found.
>>>
>>> Fixes: dde91ccfa25f ("ethtool: do not perform operations on net devices being unregistered")
>>> Signed-off-by: Antoine Tenart <atenart@kernel.org>
>>> ---
>>
>> for future submissions, please add a changelog and a link to previous
>> revisions
> 
> This one was a bit special as v2 is completely different from v1, not
> much to describe. But sure, at least a link could help.
> 
>>>    net/ethtool/netlink.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
>>> index e3f0ef6b851b..4d18dc29b304 100644
>>> --- a/net/ethtool/netlink.c
>>> +++ b/net/ethtool/netlink.c
>>> @@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
>>>                pm_runtime_get_sync(dev->dev.parent);
>>>    
>>>        if (!netif_device_present(dev) ||
>>> -         dev->reg_state == NETREG_UNREGISTERING) {
>>> +         dev->reg_state >= NETREG_UNREGISTERING) {
>>
>> looks good, but I would add a comment above enum netdev_reg_state
>> definition, to avoid any new state added "at the end"

with your interest of more improvements in the area, current patch is
fine for me as a fix, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>>
>> what about NETREG_DUMMY? you want to cover it here too?
> 
> I'm not super familiar with NETREG_DUMMY but my understanding is those
> devices aren't listed and aren't accessible through ethnl.
> 
> Having said that I do agree the checks on reg_state could be
> consolidated, eg. reusing and improving dev_isalive(). I actually
> planned to have a look at if this would make sense later on.
> 
> tl;dr; I don't think there's an issue in practice but we could probably
> consolidate the code to make things easier to maintain and to read.

agree

> 
> Thanks,
> Antoine


