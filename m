Return-Path: <netdev+bounces-105663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8287A9122F1
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB53B22C23
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC576172BD8;
	Fri, 21 Jun 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh4CvU5R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16648172BD3;
	Fri, 21 Jun 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967708; cv=fail; b=OAV2iUlOwMIxPAZ/60o3GHLGpfpMIxQMR4UnpmFPobHp297WcYf67K5VK5xMVvnLFbgtXs0K9D3afoIMlOQoSExXWVqnm3smRyN3tAZ0QHrnSLmHYVPJ4Cfs6cLXfRU8pL97mP3OJ7L0YA1idO6s1QnDOpYk/2qtwXr6Ek73PJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967708; c=relaxed/simple;
	bh=UMuGUR2IoXRoISPhA2a62NN5WDMYbfce0Dw5YAI+i68=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nAIqK5hpSVCVF5Rsukaya3Wfsv5aa8ra2yvvbucLGhunINahiGH4yOj10fqobLLMOo0efgE4V5JLsqQXOEjzRpCSd4kTa8gVDR+lKbNMS3DkJ6SZdKizv8F1rkQUZA1aRfgv2OiO/l+Ak2hRg2tmbVI1S80IhNDQEeh+50F/ds8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh4CvU5R; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718967707; x=1750503707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UMuGUR2IoXRoISPhA2a62NN5WDMYbfce0Dw5YAI+i68=;
  b=Rh4CvU5RQctk3mIvb2CLveuZYFRbFNr+o4h8Qs0gQIdGyCymMZeucz77
   Wxma6u2Yms+i0LS4MT6APZfDBv5kbG530otkK9hdfBGURKLQj32VUKTC+
   nFnS5tZJx9I3sszxeuyfKIQ5bgMEaE5NOsGn0NmTOOMiHW8q0rtUVfaiC
   CFcrHFlyvUJvC2q94i2rsDM4wEkCCmLZN/szsS6C9y7ypIsF3BEombcld
   WvWyyocbY/S8CQoz2GEn9c3TOWaF4tBu5At2gIsjqNfh/yG0UMlfUtqkX
   4sf5HcJwCxedZ4SwedTCLSwkUTzKlpnMwBA8G34pMPEmIcXBNOmvysi69
   g==;
X-CSE-ConnectionGUID: /lVHXVuSTGyeBA/9yLsI5A==
X-CSE-MsgGUID: So907mY7QRa2v1ZQa3zalg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="18904114"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="18904114"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 04:01:46 -0700
X-CSE-ConnectionGUID: jX/LRQZeQj2V7hJQv9h/cA==
X-CSE-MsgGUID: hMckt3GlSJmsY9v97tyi0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="73305845"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 04:01:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 04:01:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 04:01:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 04:01:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlmeSxVNm1m02Vb7L13WR5HNP0xR6luyC58bxy/a4IfcyHpI5HfMUyjhhDkVYal0ChHdpz+pL+HCiCX17TJhYUQ4pVsOW3NQCa0gzDF6qlK+hrgHeYKirKDvOk8yBH99V4Rbas4N2y8Fka9TwAOX+6x5jOLuwEJpqb9R2202sx2Hc6rTBlJIYkggEqKtHe312Ogg0tW/MsbR2GuCPTmYP/oStGJpOh5S+X5E/z9QzJ1AM4Z4O+po8daG5LDnVDKTepv713jXMCA23/5b7KXzTzohtleJc6ybprHbm8j53lFRafSI2lNJR3TnztOVqxsKvGM8azEPCYXJ2MOOyBRVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiqEekREnNru1PFdFQImlVZtXRvRm6sm7VMOBfDqTMI=;
 b=XeULyt5n2JmAZR2Lryaw4rnE0L706//k/eItV1bwxn5bIcTQPCPU9iu/cC/Nj4s0MgRMa5apvp+o+J23DRJJ6IAGB9ll6reCmAOVbL+/KQHiTwyeymws9WJI4ud3dCmmpx0AmqE7QkZNCg7N794wvBAYdrJ3ThwHz2mWsy8mXPWg0d0DScyH6aejRSMocNydWb++iZ0ZUSebj3wUNmoYbypRcKQa4Y790Ww/RGo/xxwFTjo6/JYkn100Aa5v4WGQai8lobyQdd1+hfTJaFfWMDLssEYE4h+TXZhM3Zzx37fL3CVvogGNKODxwkS8TlfVFdMbT3i/PESOoi0nI+NErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 11:01:43 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 11:01:43 +0000
Message-ID: <929107ae-2ed3-4d3b-b719-62b7ccd60413@intel.com>
Date: Fri, 21 Jun 2024 13:01:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix initializing a static union variable
To: Yabin Cui <yabinc@google.com>, Nick Desaulniers <ndesaulniers@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor
	<nathan@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>
References: <20240620181736.1270455-1-yabinc@google.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240620181736.1270455-1-yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d7f6ee-f274-4a7a-2966-08dc91e188db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0tiRVJZYWNGOTFwMEV5a1oxNjZyQXNicVFFOW5nR0NKVVlwczBLOTFBVkNU?=
 =?utf-8?B?MHRxdXl3WU5ERWxyWUl5emkvTVBDL3psR0pNY0lGb1FQTjdwZGNGdWc1eVk3?=
 =?utf-8?B?SzVucEk4WHlWT0NPdlVheW41ajMrOEc1NExuWVorZTNCdmhadHlmMS9ZZm5L?=
 =?utf-8?B?L0lCU1BoMUJKUXZpeDJiRUEwZDd0TlBWL29tdlhyVWUvcVNoek1EblpYMlRt?=
 =?utf-8?B?bmxZQ3orU1NCa3VpNzgzRlhWemNCN2hvNmJtNEZCR1M3b2NoM0NMYnFoUzB2?=
 =?utf-8?B?OVFlSGp5LzFqUHZ3Y0hSeld2T294bzFCOWpCODJpNk1oMEhYUVQ5cWdYejlv?=
 =?utf-8?B?WHZoanAzK21sZk5IUHQ5YVY5d0hWRGhnQmtrSWRrdUd3MXhmai9oc3huQmhz?=
 =?utf-8?B?RnF0NkpFOUxkdm5rMFFDY0RnMEo5ejEzeiswU1lEaUdpSU1wcW41QWZzR2hT?=
 =?utf-8?B?OVY2MmhBMEYyK1pDbUc3WFcxZlp2YmFZcWpISlQ3NWF0TUFqQjFzV2Z4M3RL?=
 =?utf-8?B?V2hxTnBvYlg1MzVPWDd6eFZzQTh0RlRjUEw3RG5CQ0grZWpLRlBabTFQOVJm?=
 =?utf-8?B?bllESGxibG51Q2RWWVdlOGJLdkNQc0lVbjN1cTJGT1J6ZWhoRDI3bmFUZjNi?=
 =?utf-8?B?T1ZsaUpWblkxSlZXdmh2OU41aEZNaVZYRWp6Mml4RkpHVzZUVFczRE5aNmlW?=
 =?utf-8?B?RzFtek9ES1QzL1djWVhJVlg1aDlsQ01jY090WWc3eEo5eVJxcWdkeTlvYXVa?=
 =?utf-8?B?TjZCNmxQZUNKMEQ1RTA4N1ROZ3cxTWtGeDlKTkRPbHdIbjgwbk9wV0w3R29P?=
 =?utf-8?B?VndnNitFalhiREIrU1V5cnAvcnd3cG9CWUV2VjQ5MG5Qa0hUNzl2bks5dTE0?=
 =?utf-8?B?djZkaDlsR0VrSWlWY2t2VnRlMFRZZWRhL0p5bzByOFJzQXJMYkxLamNUaGJt?=
 =?utf-8?B?enQ3ZGpYdUNQS1NlVFM0Y1ZPQnJ0L01EajJnclRhQXM5bVFkV0JhcTNXWHhq?=
 =?utf-8?B?QmpjcmJSck5KZEFxOStEQUFXMHlqbWFYeEZBd2JHMGN0UnhWaTVhQml2YVN4?=
 =?utf-8?B?ZkpBamZnYlhyMnIybnFsN1h1MkI2SE9hUyt5VjVGUTBFYjFac1ZLdnk1c0tq?=
 =?utf-8?B?OXEyRTNjYmFndXRyMjJ3d0g0d0tTWEhoM2pIWnBiM2Mvc1B2OXVtdnlXb2xL?=
 =?utf-8?B?azh2dVc1RTVGK2NVUFNZSzgvdm1wdjJMVm9rRmJFeStvdkVWdlNkSFdGZnVa?=
 =?utf-8?B?MER6Ly9UOERvSkFWVGJZcitNRUkvS0N2dG5XL3diYlZtTEdaOEdyUjJ0cmJv?=
 =?utf-8?B?RkluOXhYS2FoQ3VOL1ZnOHFJZDgyK0o5clBUN0xWTldvaFpjZlNheTcxWlhv?=
 =?utf-8?B?YU9qaUs4djYyN2pxZk1xZEFnemZYZ1FiZWQ4eU04bkRGeFY4cnQyYzlsb0tG?=
 =?utf-8?B?RGJjRmRudG01dzhXV3BQVWJUOWh0QlcySjkvL1Foa2VZM214em5mbzlXTmVv?=
 =?utf-8?B?OXFVMEpZbytxbmp0ZmtURGZWYmtWeHpCWlRVTFdHWmJ4Vnh4UFV6MFZ3OGxC?=
 =?utf-8?B?RGhLa1FaaVJNb2tEQ3JjZmpaTzVUMkhPYllzbG5iUVhPVFd5eCtnR2kraG9h?=
 =?utf-8?B?MFZwb1ZrUEtOcFRoSk5TRk1pQVRMQ3ZCNDRQWERQcWFnNkhQV1d3UmJGZWtB?=
 =?utf-8?Q?RJeMuGuctFKA36G7d6kL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEoxbW43SjF3VTRINWRKTDROekJSSVlnM0pQR3pETUZ3cWV6ZzBLQVh4MUZY?=
 =?utf-8?B?RCtuY3dPMHh2VlNOVTFObEN2T1lWdHlpSzB6TnBtclZVUWZkK292WWNSSVp3?=
 =?utf-8?B?MnZYNjJITEo3bXdRYitHOWtJYjhiSTFJTHVlc0ZTSHUxMTBxeVNaVDhwSzhl?=
 =?utf-8?B?QUN0QllFNDJFRzU1WFFvYkN2UDdGMEJjRHVydG43NW1iSUg5eE9ITStnbVVy?=
 =?utf-8?B?TEY4SlBvZUhidjBGa2VTZXVOZXlMcGtsSmthTS9KR1k0RzY4WWYwRk5uVFM1?=
 =?utf-8?B?WkErNkYzVUx0bEtVcU9OcDdLUmF3WUtMbE50cUhpUldlQ24wY0F4dytCTFJO?=
 =?utf-8?B?bVhkVU5UYXQyVmVrMVhUcXNsUDl1TDFiSUZrRDVuUitKWVN0YndxeXc5SFAv?=
 =?utf-8?B?SitaZndMcnBLTmlkQmI0SCtRaGd0RGJpR0M5Z2xOckJqYjdBTnZTVUluMWxP?=
 =?utf-8?B?Q2NQcHB6ZmJZY0VrVjhHU2FPVWtKSDYvcHBQVVNobncyRFBUT1Rid2d1MG93?=
 =?utf-8?B?blV6YTN4K3BBLzhwQWNYeXdCZHZTODVQY25MampYdlhjQmljL3U3QjQ1RHY3?=
 =?utf-8?B?MnB4MWd2U2ZhY2IzUEpDbkJoNll2ODU4eU14NENNbnZ2dUI3QWx3K2t5Qnlm?=
 =?utf-8?B?K3p2d2Jxdk4rWm5NREh1NkVZVEFnM2ZRRnhkVkNjWXk3YVJ4a0tKUUtmWitJ?=
 =?utf-8?B?QWYvay8vMzZUWFhidmsxckRHZ1Zqend4RDd6a2tmM05SRlRHVldrbDgrNU1W?=
 =?utf-8?B?TjdXOFBVVlV5ekNTNy8zeEx2ZUZCNlNieldpdHJCNlZoNWJpelFRZHFPMjla?=
 =?utf-8?B?RlVZTE9LVGxBa2tMSE01TWtSbVRhSVEvMG94U25qNXhyZFRkTjNVTmlFKzNy?=
 =?utf-8?B?bU1vRGVUZVo4RVRiSlZtWHdTRHllNXNIWmV6NzJjU3Y3NnB0eW41OGtaTjB3?=
 =?utf-8?B?c0dROE43azFIU1o2QjNWbFpZNHVWK25pb0RPdGNhYWdFR0FUM0NBU0Z5aXNF?=
 =?utf-8?B?b3cvS0dvUDBBUmtlaUJTMTA2bmFIbk1jL2ljVm1VY09hVzRqcWJ6WGxVRzZw?=
 =?utf-8?B?Vzh5Y3R6ZHBNS0xmeElDTjE5MnhZa0w3NWJja3A0V1hwUHpGaE1kMWhHdklT?=
 =?utf-8?B?WTFjc3gwUFZmUjdLZ21qVWd6WDdSZnRiMzJkQXJ4cHo3a1pETTBLVEVWdUhy?=
 =?utf-8?B?R3V0d1BBaHJiVURiNmgxQWJkbXZETjB1OFNXKzVnMXBqQlFJWXR0WVBIQS9O?=
 =?utf-8?B?TVJXR05jLzFESGhScU9PbS9oeHNUQkUrNGU1TlVDMk91aG1JYkM1NVVwRkEv?=
 =?utf-8?B?ZUFVd1dJcU9QWEFyYitQMTRGWFFvRU1rNkd4YS9RNmJQSUJnTC8wbHAvdUhY?=
 =?utf-8?B?NFN4T2grWE5la0VVcC9GR2hlZ01xQ2VVK3ljOGJzWloxMjljdGEzUTBlOUdN?=
 =?utf-8?B?czIyRlVYdzRYMEhXYXNSZWhKZm9nOGZqVVZmS3dMNWFaN1FUaFJ5ZHJNcFFT?=
 =?utf-8?B?VTdUaVhNY2pGMlZwb2d0YUtSVjRKWDNxbm9VVXhJdlVNV0hDUWw2L2RkY3dx?=
 =?utf-8?B?aUtaYi9mN05OU3d3cUtNeEJNRUxvQ0V5aVoySHk1YkFqQ283RWt5eXVjdTdm?=
 =?utf-8?B?Z0lIYi9NNUo0NTlvbmVBS2N5SFhzTnBMT0xaSUdSTktIUzVTUTJmcVhMUGE3?=
 =?utf-8?B?azdFNlVOOWZsUFI2MHlRTG1yZ2VMeXBHWjM0aDhYdmZlVlhHK2dZMEtGZXlE?=
 =?utf-8?B?ZWNFZUdKYjJ6eU9NU2tYRkhVZEJwMGZnSkEyN3drd2l2OVBuSnBRQ0hVeTBj?=
 =?utf-8?B?VjNRMkJiam9abWV5ODlNOEVaR09NbXdNZ3EwWnFFOFVQbFcxSkVKRG9NUTJx?=
 =?utf-8?B?dmNTRzU3OHFCajE3OERSNnBZL0ZLamhCSUVodDhkTnMzTm5KL1RUWkVCYmxa?=
 =?utf-8?B?YU91MHJQeHlHdFc2SWtxYzhiTjVUTlIvMTRQUnZkMlRPSXY5eG1qOXJOREpM?=
 =?utf-8?B?cjI1ejdhNUk3d05ac3dQamhtMU1JeXE1c2ptd1crY2h2dlB6SEJBditsQjFB?=
 =?utf-8?B?bktPdlUzRUdJbkM3aXRzZUlBVkFqY2o2WWFKTkdPcTVWa3prYUQvZnhycUYr?=
 =?utf-8?B?eWRBTnJybVplRldQVm1OV0JubktiVWRjdXpzVnlnOWR6ZWE4SXA4TjdCSG93?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d7f6ee-f274-4a7a-2966-08dc91e188db
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:01:43.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BscpKwgoPZXemsQqDSWd9T8Bs2EKMYK+nuphGu6ckMGhzIwI8L0t+E1w0AoTsWcVKmVxITvy/h7wdLCRPRmMT0JZV1T9phHD4HipGT3t/uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com

On 6/20/24 20:17, Yabin Cui wrote:
> saddr_wildcard is a static union variable initialized with {}.
> But c11 standard doesn't guarantee initializing all fields as
> zero for this case. As in https://godbolt.org/z/rWvdv6aEx,
> clang only initializes the first field as zero, but the bits
> corresponding to other (larger) members are undefined.

Nice finding!

You have to add a Fixes tag, perhaps:
Fixes: 08ec9af1c062 ("xfrm: Fix xfrm_state_find() wrt. wildcard source 
address.")

And the other thing is that I would change the order in the union, to
have largest element as the first. Would be best to also add such check
into static analysis tool/s.

> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>   net/xfrm/xfrm_state.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 649bb739df0d..9bc69d703e5c 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>   		struct xfrm_policy *pol, int *err,
>   		unsigned short family, u32 if_id)
>   {
> -	static xfrm_address_t saddr_wildcard = { };
> +	static const xfrm_address_t saddr_wildcard;
>   	struct net *net = xp_net(pol);
>   	unsigned int h, h_wildcard;
>   	struct xfrm_state *x, *x0, *to_put;


