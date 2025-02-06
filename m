Return-Path: <netdev+bounces-163343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D6A29F5A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D691887750
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C84152E12;
	Thu,  6 Feb 2025 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoS8TZqs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49D1509BD;
	Thu,  6 Feb 2025 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812384; cv=fail; b=isj8DTI9cEwpwKe/Cf3OORPbceooGvYnD1cVBYE6wZnP9ehMr50SATk0Pw0Ndvovusd/ZZpAMHzlX8dDWVWQcmJ5UJQ/04hp+wk7mxX/KqL+yxDl4UZmuGKoWbe10euzE9XawEIJ6HqpmkBl5Auv47ZxwullX9C1YRB/CX5EIOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812384; c=relaxed/simple;
	bh=4v4/Z7fmGQSXAp/CrAm9sjDwXVhM5CvYG7NUukKkCio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HGR+voEyLgUYpk25SDKrUyAQ6v8zhETaA80WaQEOLz0CJCTqpU4diA8IO338qQ1toaJxJgZA9HisX16hiVbtygedHRXJDKZU3d3pU3D9taZvcgDuqqgZcwrID1e4yxExB7oeAQkcapAWigsc+aOcfb7qRP2hi8LycxSD9vTp4RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoS8TZqs; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738812382; x=1770348382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4v4/Z7fmGQSXAp/CrAm9sjDwXVhM5CvYG7NUukKkCio=;
  b=KoS8TZqsFewvIss4mLpoCbHTzjdIhBRW0xVrRsXikEddS31FWzCTNY13
   e8lCKeRjjnKItIWf94Y7BrKwFxrIRvn2lzGzlQIemQ5qh8hnKHAY1yIjC
   QgD5fEE0DtRiDg/t6ZSncX1OrxxczS+b11ZWh6K0Lv4uJyxLKs4s/S+Ns
   4eczmxDicddRLazEe2LI4t8ZEHKR4/UkuGyObuW6QX60XYeY/WGEMdWCd
   p6bCjm1P0aeUFiDtD9qv+ZhufZSRX/6n3echY4f179OsfztlMOymr+kek
   7z8l0sAHthwMywNTiCElaFzYo8uwvhfoz1ByWQPRZJvgv/O77TrnZUuZA
   A==;
X-CSE-ConnectionGUID: 98U+GHa+QhyjXdk9bMj46A==
X-CSE-MsgGUID: LWHanQ2NQVCqzB77s7dTSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39099570"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="39099570"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 19:26:21 -0800
X-CSE-ConnectionGUID: CSj+aP0qTRahtoqpu0ijzA==
X-CSE-MsgGUID: rG4yvWd+TcOhsw5Rht0PTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116040953"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 19:26:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 19:26:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 19:26:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 19:26:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o41jQARz6sVd9fF8IQ1Z+70pCXQEwwlGXzsfj5D2dCLqd/OMjwBTzKx5lN77PFLx6mlN1/7KogKH2HpfymZhruegTm+0KNZrZEsnhuqNWM6lBVmfB2WtU7s9WWSr1LwmnPHAPssPX3hnVFiRVcVxLW39iwQQ1M6bIq4Xb2G2B1S0Vyp4woPUE15tYPX+4rlzYQSRm6ptB9Q+vn7vrEb6WW1jZOURDabqU7gwXF/81DIHSD0PyvnekPSSw6HQIpeudnxHpgDMy7BSYPAE62r0UmncYw+4r6+5K0Lp8OfWwoGFJ86eDmTWFrLu6z3TytF2+eznjJe7Zbn+yg+i6MYZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FFfvzFCfti4gC6l3DgfnMlcc3Kom42N9cRlkmpiXOY=;
 b=k4vF8pjv3dsvDXl/1Qqs2xe3NZBjWVBPiYVasypSimZM11qysxGpE50ZuuJ/4y26MI6pJMeE/9X5lVJcB1eaiWPsUzJxA3s4Cdxl7djJ2mRn+4KWrmZoh2rh1ZWi8WYGfeHaTkDrcZMR5CGq9el/MY680w/kXvCfsIprwK/GWHwKqepJe75zEZmhwFF1PPazTYAoXIh1FwCXEnZw4B0dIa1Bb5RqygVSu93agDJUP3w2hGJlZwkm4m+Hstry6t26XM5RF5Gg5iFvXqmIi5dVLSHhJpOtoqHGbXjg3OTAakjU5Aw7EmaJMjsEiLk62p/WQMVhaoBEutZtpQCNO2ZNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 03:26:18 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%6]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 03:26:17 +0000
Message-ID: <432a5c45-717b-4d48-9d2e-241500b77e0d@intel.com>
Date: Wed, 5 Feb 2025 19:26:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] netdev-genl: Elide napi_id when not present
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>, Amritha Nambiar <amritha.nambiar@intel.com>, Mina Almasry
	<almasrymina@google.com>, open list <linux-kernel@vger.kernel.org>
References: <20250205193751.297211-1-jdamato@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20250205193751.297211-1-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b4900c-01f9-428e-9e48-08dd465e049d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmxWd0M3VnpUN2NNRjYwTHRHcjVrY2tBelFsblJ4V2NkTXRqL3JUOUhPalFy?=
 =?utf-8?B?djVXMVVKYUk4ODdIRW9hY2lYMklXTHhCSUJsU2M2K2ErVXNwYTRuUmhEVzd5?=
 =?utf-8?B?dEM0ZC8yRENWQnBld0ErbTJjcDM4RlFVa1ltK2dPNi8yTGpGS3BkcVdnWkFC?=
 =?utf-8?B?cWxiOWs3dE5ka0JGYkFOOHkvTitOL0NiM1g3SElGbmdKNnVQUXh6OGsycUZk?=
 =?utf-8?B?WGxWZGM3aGMrMUExcDhWZWR2N3pTZy8zQWhibldkVWRFZUJYYzJSVnNEU1ZY?=
 =?utf-8?B?dUVLaHFJcU42MGhKV2VvaUVVdExmOEg2WUl2dXJic2lIVEhpdFJSbWRZcHIx?=
 =?utf-8?B?NkQvUFR3QjU5Nit2c283WE8vdWVVQ1RhOXZwY3doNWRiaUtWTGhGQ0tURTBj?=
 =?utf-8?B?aXpyMDlQNVN0SGVrVEZsS0tvNXUzRUNqeHhjUmdGRnp0eENJZFBTVEwrdXRx?=
 =?utf-8?B?VHg0bDM1ZHdkK01SOTBiWktic1UzMkNBNEpmZDczcXRFV08zN2xLSXRoY2hY?=
 =?utf-8?B?QkxNaXpDcE9ONjEydDVMMXZ2a0xNbTJ0YWRQejZURjNkeWpaZGtOVXg2Ykhx?=
 =?utf-8?B?ZHhBT3lYOWRHWWhJdy9lNXZLYy9FWFVnVUFNYzJ3M0dsQjFwY2xwcXluZHBw?=
 =?utf-8?B?UjJ4V3Q5cTZDNWlneVoxTzl5QzAwNGdqa0ErT1daQVlCelB1a2I3aXArTFZR?=
 =?utf-8?B?RmlGVEZZMGNKdzBjbGVmSzJwTlpJKytRUVVRaStXN3ArWmdtR3h2Ny9FQmcx?=
 =?utf-8?B?OGY1cTlBU1NFb2tJeThCU1YzK2ExMTluOFhlTmVzVmkvMHZuS0ZPL0FXNFYy?=
 =?utf-8?B?VTdIK2hiUkVwRXQvRnkxY09nTHlad3RpdUVOeFc5bXNScko2MWZLMDZhdEZo?=
 =?utf-8?B?ZTdscHAySm9uSXhWZWZwY0tJVE0ycHBpQTN1Z0JPY3ZYNzFGQTk5VlJyQm1O?=
 =?utf-8?B?WS9KVjZ4QmgvRFgvYW8xWUlTemhMSHJSTnBibVVXNlBUMlFzL1VGUU9CUHJ6?=
 =?utf-8?B?dGtyUUVqcUhKbndON3hqSHJXcFBKejl1Mjd5SDgxKzVIeUlDVU1vck9yTW5s?=
 =?utf-8?B?M20razl3MUNjNWh3S21rVnhtYnVIT2VtTVlSeWR2SDFRYVdZRTI4YSs4RC84?=
 =?utf-8?B?dnNQZHpxc3NqTi9JWE84c3M5TndpOTlQM1UxbWJMYUIrbndDdW5qZWlnbXdr?=
 =?utf-8?B?MTU3dnkzVS9USjZZc1RoaHFFSjkzd253Uytwa0I3VFNETTZPOU0rNG9ZSzVT?=
 =?utf-8?B?R0pZMXNSdys4dFlYMEJXeEZTTnpRWjd0S3ZzU2lMbFEvTUNRbHdUMEVQT2lM?=
 =?utf-8?B?WG1KYWZYblpHZEtPKzc1cEc2ZlNXR29wb0o1M04wVW1XeG9VSGR4WnRWQVRL?=
 =?utf-8?B?emphbGU1MnNMWDMrNG5WNDFEbzhyWGJlVnA4NTlRdVpqSzkzbWQ0cGZQbzZt?=
 =?utf-8?B?M1lOYWQ5WGd2TkVaRFVjUkxsakZ5YjVvT3FFNHVobUw3azVWUGY1RndCZHVm?=
 =?utf-8?B?MlpLK0pLOGxZNlpRUWhjU1NOb3hSSmlHeWVwWk1JeXlRN1Q1Nzl1aEpEOWZq?=
 =?utf-8?B?dFcraldpeVJGRG9ncGd4eGYyR3kwcno5UVJyK0NEeUVqNThQTDQ3L2lOUHBK?=
 =?utf-8?B?eks3cFRyL3o2L0Q5WG1jYStUdm1RQytCTVpYYnFGdXZpZ1hJUG9ZZzJ2a3pz?=
 =?utf-8?B?OHRKazhSTllWQnBSMExLY2pteXpDQnZoMjJVS2ZnTlhIeFFFRlpHanZ2bVJP?=
 =?utf-8?B?Q2puVG9jeG5hcGhSRWZDbkFFcnBEMTkyWUZTWHV5Q0JIMjJWZFRXcXBZWjJq?=
 =?utf-8?B?c2pMRW5VWk9DOEM5czdqVHhxQzQ4SjBzSjdiY2NLbklSZjk5ZXlxUzQ0UWZC?=
 =?utf-8?Q?Pe9ppjqn3jh/O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3BVR2ZQYnZjMmZKQTA1R01kcjNZZFVMSmlLWVJ6M0lzWEVwZHpWRXpWcHVp?=
 =?utf-8?B?ckJqWGI1dHVTTytGNm9NdEJxUjd2NkRzbmd4UHpWRGZHWTJTUjZ5N2pYbnB1?=
 =?utf-8?B?VW10MWZuUGw3bzdoc2k5QXF3VHVkNEdvc0I3VEV5ZlgxWnFVaTV4dldmUDdz?=
 =?utf-8?B?QXNiWXFkK3hYTHU4L2VRbzY3QWZzS1pkckhiWG5ZSDZpUHNtbTN5K3BwR1l5?=
 =?utf-8?B?SERnd2w2SytTQ29CcWRPN08vRllCQW5UczdWRzBqcGIraGQrVmZ3VWFleDh3?=
 =?utf-8?B?ZldBRkZmTjh4R1ZQTFpraXZlbUNEUFJNczFNYmp2Ym5XT2VXMU0vKzh4RHFH?=
 =?utf-8?B?YWExVDlvR01ESDB4R3c4anJyQmdUY0h6cEF5SVFyZ2wzMHNQbWRBMVFwWXJ0?=
 =?utf-8?B?OVhtVjZKS1NyK1lCQXc0RVpIbkNTRlVZOFlYTHFtUkpnSHB3QndwbEpockpx?=
 =?utf-8?B?UjVUU0FOMm1FQ1V2bkNwOEh5cHRBUDA3YjB4N2pXZmdpT1djTVltOTZ2Wk8r?=
 =?utf-8?B?TjhvcFFUMFk4ZW1YdTJRMTJCcDFqd2RvaHY4VFk0VjNVeWxFYVRwZHNOb0pq?=
 =?utf-8?B?QmtFTFJIVURGKzlibHpvUkpURTJSZmJKYUV3NFpnU0R4Sk16TVhrbFdoZzcr?=
 =?utf-8?B?OTFhVE9iVjc2eDZrUWdJb2RRSS85dGxnc3VWRjdQTmxEUVZzaFFGMkttM28z?=
 =?utf-8?B?b3dPaE5HMG9seXZTNG41dVVzT1QxQmFxaWR2ZkFObmN5RG9vQ2tYdlpzcTJx?=
 =?utf-8?B?dHRkSDQ4cW53NFI1U0ZhbEpQV3hMWjdTWGFRRWdRRHJWYzhJSGxzRTY4cUlv?=
 =?utf-8?B?aFpXUy95R2RPQkU5L2ZwYmttcnRpc0VBL1VNRHV2SjMvSTVVaFlKTDI2K2lK?=
 =?utf-8?B?VDU1R0lucnBWQTk4QzI2SVpwejBxWjJBVWtzSTM2Y2NPZk1FOUsvRzhucGJT?=
 =?utf-8?B?d0tvK09JejBpdmV2N1ZtdnI2YzdibWl5M0M0ZUJ6cGM3R0RoVzZFWWF6bU13?=
 =?utf-8?B?UG1KNHVHekhxUVVzQlB2UTNWWTM0emVRWE1MOXZBb0psNFZkR05WQjRqYU9R?=
 =?utf-8?B?RTRjLzJHcHZFa2EveW5zSVI0bUZKUlQ5NTBkWmVzVVFHTWNUTVJPR2xvOE9q?=
 =?utf-8?B?aFo3aThYZTVra21KNkQrWUtXb29ydGhuVldVTy9ORFoyNTM3MUN5VVhmaDlL?=
 =?utf-8?B?bVgrR2lTc0E3OWZwN21JcnlFOER5ZFVDR3RaQ3NkdjR1SHR6ZEIydjFEQVMy?=
 =?utf-8?B?MzJ5S1VIRlJSUHVLeEdZSzNsNFZQaXRSK0tUZ2RZRjVXQUtsSjFVdlhnR28v?=
 =?utf-8?B?dUJwc2hWRUtNZHZJWjdYWi9rU2ZmRE5GVUYxNmhQUm1OL0g0Z0dVQzdxRHp4?=
 =?utf-8?B?QURRNVpsR09UU2tuYzBIZWNRMXN3d0ZON2paZ1BLUHJtaHQ2S2lYdk4yWlZu?=
 =?utf-8?B?NWVVeDRqN0h1TXd5aEtQSXE5TTBwdmUwb3ErR1JFWGNrQUpmUUxvcERwRHBu?=
 =?utf-8?B?bS9rYTBoSHdpUzEzTnpQSS9aaWVmNktMbnFNWCsrdkJOb0dBR3dVbEJ5Zm9K?=
 =?utf-8?B?YkM5N0tQb2NhaGIva0c5dUt0a2gyd1BzS0JLdGZRbGRza1dWTThuQWd5VlFt?=
 =?utf-8?B?UlU4WndwYmxSczIyVUZGN0xnMmVlZzlqUjBTNTVpRm43WlFYS0JYeDdOZ09C?=
 =?utf-8?B?c1U4Z0xISmNMcnhXZ09jUWpBOEE4TEp5dmpOcmJ5dXRXWkZqOWRtM0NEZ2hG?=
 =?utf-8?B?b214MWVYcHhXSk55TEt4VHdsWU9rQno2RzhyeGlWVXFjbDcrZzVqdVZhVnpY?=
 =?utf-8?B?dUJwbnFudlZrcWhHZFgycmN2Zi9NWTloWXVQWjFkbU5PajV5Z2pQNEpMdjJV?=
 =?utf-8?B?M2VSM0FXcmlUYUo0Q3RIUWFNU3V4NEFTZS90anlOSmJjeTAyc2lGbndmSzBS?=
 =?utf-8?B?Qk9wd1VsSlJvZlIvbWNwQkFZOXNQZTZHOUl6bjJTWnhHS205Yy81Z05lcThu?=
 =?utf-8?B?OVZYek1KTzBtdkVBQk4yOWRkRGRIUTZXVmVHckxteWxIa0d4ZWdxNXZIbTFM?=
 =?utf-8?B?SEFHN2tSUDd5ckd2WlpETnpvZm5MczlubnpKMzBsdjJmdXp5RmVnUGxzbVpp?=
 =?utf-8?B?KzBBWXBKWDZlU1gzZUt0aGRFOWM2UXliL2xPa2NMTHpEWFRYSEYvYWZGQVpH?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b4900c-01f9-428e-9e48-08dd465e049d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 03:26:17.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZkhIflp50CqQV3mKErAGx7E51qxxPk2WsnGexDERi+AwPurAfkCHcS93BMOa6nOXv8HQ+Wj6oYl1xotPr5ReWxQgQA2Xnt4N2WlOT8LKTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com



On 2/5/2025 11:37 AM, Joe Damato wrote:
> There are at least two cases where napi_id may not present and the
> napi_id should be elided:
> 
> 1. Queues could be created, but napi_enable may not have been called
>     yet. In this case, there may be a NAPI but it may not have an ID and
>     output of a napi_id should be elided.
> 
> 2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
>     to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
>     output as a NAPI ID of 0 is not useful for users.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

