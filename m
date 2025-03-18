Return-Path: <netdev+bounces-175776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA8A6778A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB796188556C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1785D20E021;
	Tue, 18 Mar 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkiRi05d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B2186294;
	Tue, 18 Mar 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310897; cv=fail; b=Pyw/NaqXqtw+O9yvm3LXgFxm6vhV90XPCnOCdpeEq4TsoiiSwcqVac7N+tf2xYW+5/N0SWgMwBSNVw99bAZrpYbuexjzR3fLVwxHukUG7EZUxdLNUsMvWwbvnxeKrXp0+FgrsGKMtMIMuwlXWGmxOCFTXUyk0F7s4gcpzXjXeGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310897; c=relaxed/simple;
	bh=wSRyWvbuxW4CB9YfjHLDesO+qw4EDZRvY5n+tmzQEmY=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=qaMXZigVdz2nx+zp+ACEfYp34gYWRCKQ+gV/62c5bzGPHpDDPN/xkun1K0vxK47E58dA75fnA4o9zRHmSPqHKcYR0xcbYbtzXNvrXadA+SVAtsvXk+y8OIVz6bsrSvp2XFS828ClHb6BFPWLpqSsNEtnKjKhqbiToRk1dgHoW2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkiRi05d; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742310894; x=1773846894;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wSRyWvbuxW4CB9YfjHLDesO+qw4EDZRvY5n+tmzQEmY=;
  b=PkiRi05dk3Fhfwd0XBbFFfI7r2RlLtqiwIF7WqU0lBXqdLoTbLaGq8iM
   j9BrMkS02/FmYt78UGzxTgDmSQrAQ6IPTz8hHWiv62j9iKiJFfj+55Xk0
   uECK60x2Lqqrlk+Py6JQANB++0m3uQX3Al9Ur8NaavYUL2vWq/fm/4ZUv
   55zoTnsWE36jmcEOjb+c+ITqZ49ZoOVjZHNu4doK8s1ysjB3SBbHNCYAF
   JNvSzHecg4SrmI+TSMHJt4C6uSjBR+L0prdXASqkQrdYwG36Ekti+P2kM
   bFb8qEFunJLJ2MVP3vhGV0XW2CbLug261fdv6T8QEssGiCd1GdiKtp30m
   Q==;
X-CSE-ConnectionGUID: m3wD2H+pSayYj4MAawMl5Q==
X-CSE-MsgGUID: A7z3imZ3RAeI8lUQXnlraw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47235842"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47235842"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:14:54 -0700
X-CSE-ConnectionGUID: 4XQBrAw/Qvu1+tiOejRxDA==
X-CSE-MsgGUID: 30FRQYEUQxqJ0bH2ywwhXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122778330"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:14:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 08:14:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 08:14:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 08:14:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUuBBWh13BBkgzrE/Y2sna3B0M9ayYYlqsrUaSCZJvv7c71ChvKWRqYPlYvkplqEUSup5ENBzs3f8FlDyHxjBQJm/WeZeqfYAo+hdkBI3b0qjWPkumDf5CdYkeFbZhF5kT5UsW/0k8Bq8+BpTa6WKh3NusNdJzLDk7HfLza0deQ79QyzLvNdctHgWbJWG2vpT7CpTNeIItjidt6rGYb4E8U2yBlnr37i87S5TcCiuWSo6HInPu8hwlPsR3NqNoQmpKBbCoFZyBPDmi18OYxct7mpgMO6wLhhz+xHRISl8VhgPA6UI7/9dU7iybEoQOZk0e/afpkd6ZwL4z+Qxt/zBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78SSGOLnxpk8WjDvDoU0X/Ol9ghbxAEHyJewfJDG1bE=;
 b=iG4M4CVNJ4vR2bCzs92dISJXrKxfpBfdtpNOw8Mn5HmXhfA6mMizeR4Dr0Gx8FhXf0Rcm6ZD+y7GivF0ORJgGy/pog31DNV2K1v4TDFdmk0l4Rv0f4lvEc4Xkaa8jM5lmXE3O+jNC0Orlgc56Fztrwk5boaJ9WWHZ1G8wLRoeoZ0d0LENZS80i07AdN5gHh4kt3kMLSG8/EGhxuF2ISuvw7aS9Imk1zZTx4LdAaP4YKAdEG7J4hnXaX0wmxk0WCs5KpljrnOsXC9vDjWt+9Zh/WxJIeR1iOz3EA9WaRykPBdAB1upIIrwwd1Z3qIfD93Xux8Bf36ym11pBQFVhTv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 15:14:46 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 15:14:44 +0000
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: enable HW vlan tag
 insertion/stripping by default
To: Rui Salvaterra <rsalvaterra@gmail.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>
CC: <edumazet@google.com>, <kuba@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250313093615.8037-1-rsalvaterra@gmail.com>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <168f5e6c-a585-fb7c-f6a8-6fa8df09d00b@intel.com>
Date: Tue, 18 Mar 2025 17:14:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20250313093615.8037-1-rsalvaterra@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To PH0PR11MB5949.namprd11.prod.outlook.com
 (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 972af0a0-c9c7-4c01-acb2-08dd662f9d2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTk2bjhVYUt1RVkraml1aVJKTGc4SXNnWEh0cUFLUklBVFZJT3ZCajN3TG1r?=
 =?utf-8?B?c05tWVJxdlgxRmFJalh3ZnB1anlheXh4SzRBNlk5WG1rVDF2NTI4Z2IrT3RG?=
 =?utf-8?B?MDJUN2dvbnpkazNGb2IrdDhUWW9Wd1NZTmU0bE9KUGQwS3hwZDM4bWZJb1Rx?=
 =?utf-8?B?UVNTbFdTRFJIODJUMEo4dXhPWGpEK21nbE9EdXdTSVFaSmVZeE81V2Y5N0FQ?=
 =?utf-8?B?YVRoWmJsZHZReWw1U3RIenFTWGlhUXdQYXlmekZ4WjF3ZERkaGZBL0l6Qjhp?=
 =?utf-8?B?NDZOcFkwTTczdkNjZ2ZYWW1kR2dtQWpNNWlpaVR5STR1ejFBSUJYMTlUeXA4?=
 =?utf-8?B?Z2d6VCs1Y01lS2xoeVdHYTN0VDZmaHBvbGpNd0FLMUdrSld5STJJVDNRK0NS?=
 =?utf-8?B?SUYrSEErWWtUazhnenB5ZzlQZ3F5anJnMk1VTnZua0swa3d2RWZiWVliYkZY?=
 =?utf-8?B?R3habXdvZTFZdnlDU01ucUhrTUxaRyt4aFBNSEU0YlN3VCtKd0NWWTJtSXlR?=
 =?utf-8?B?ZjdBNWljOTBtMlV0QVpXYXNyNUFoUzlkVkxkL2ozSHNvdWUzTFRFeTNsSVNK?=
 =?utf-8?B?UERqdm03NlBOcFJyZzA1YWZldlRBek1PTTVLVWhyV2haL3l5REJ1cTZES3Ur?=
 =?utf-8?B?TklJeW1lZnlSNkdmakdGcWE1Y1ZGVnVMTjZ1ODVvRHllemVtWEZUS0MweGJT?=
 =?utf-8?B?MTVQSHNWNDUweFZMamVQOEpQL21LVERVQmFyM3ZYZmtTTXkyNHJXS3ZsajFF?=
 =?utf-8?B?VFBQY0tlSjRqT2hiUlVDemNtcmorKzRjN3B3Z2xxL2tvMFNYUVI1RmZERlRP?=
 =?utf-8?B?dmMwdWRWcEZ2V2s5T1phamIwNjViK21zOVAyWmc3M3Rjby9ia0lqTmpsZlRs?=
 =?utf-8?B?YS9NQlNPMUkwT1RIQUNDcjNWYVowRThJMS9WbVVrNTRNekhKOHFMVjhueTlG?=
 =?utf-8?B?a1lYNHFwZDNHOVlySzJ5QXBnK0gzS25GdW45VUxrMzczeTRreW56UVVhMjdJ?=
 =?utf-8?B?ZU14ZStMeXRMTXRsU1l1R1Rjd29MSXZVRndCenBnaVdzbW02K0tsaVZZdzhF?=
 =?utf-8?B?MUc0RFQwY0dwTWIrWGttbkkrK1lQMmViTmc3T0RBZy9yb015NktweVdZemlM?=
 =?utf-8?B?QkIvc3REWTEwTjhYUDEwSXFrdWMwVWxDV2d0OUUwbUlFS0tTSVcrd2xNRFNC?=
 =?utf-8?B?ZDJkTWxCS0JxS0lPdWFTckliUG5Jei9DaWF5SlVKQzdjRU9MaHJHdGhreHZm?=
 =?utf-8?B?RVEveEhRNDlIekY5TGRvL3VkeHpYNEdzUGlOOTB2bUM0R3pGNGRlVjhnckha?=
 =?utf-8?B?aUw2cmNyQ1M2YzRoMDd5cjRJS2tuaUVFdFhTSjBzV3pJdHQ2VkhxdXNFZklz?=
 =?utf-8?B?azVXcDdJK3JtTkx6MGorc1l0ZEZvQUdvLzF5U3hHWjVQOXNQV1YwWFV6YW1M?=
 =?utf-8?B?dDBDZXZsR1doanVMTHNpcHJ1NjdZMWIrTnlJK29IbUgrK1dFRHNQOU5wZmdh?=
 =?utf-8?B?UjVJWEF5VXpXYkFLUTBPTlBsMG1QejE5STcxeTNFYkpweWwwOWc0ZlVnenJv?=
 =?utf-8?B?cVhRQmR0OHpBaTZKMTZFenlBUVJNNHhyY2hDb1hpMlB3cnF0Y2xBMFdYQ2JR?=
 =?utf-8?B?eURBc3VCSzRFRks1RHdpeG9YdWd0L3YvRmc1YzRWODhKN0VlV0ExSStLUXhs?=
 =?utf-8?B?MWYvT2xYcTY4aTIraVRmYUNQY0FmbnpRR0tHZGJ1VFJGNW1CdHczU0Q5dlNy?=
 =?utf-8?B?NzdBRFhsVXlwRnVYY3dySENsSWo5Y1ZqUTRMTnlnMTJvemk3c2lJTU5XQjZC?=
 =?utf-8?B?TytQcmgraEM4c3lVdWs1MkdUUWhBMEJCWFFxU3NJRjFMcXpQNzMrd25zSDlh?=
 =?utf-8?Q?eMbACI/lA5ERe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhPRjVGbHZPT0lQY3RQM3BvUTM3cTB3UWpUcjNoZ0tKRXIyS3RWVVNvQWFT?=
 =?utf-8?B?SzhWKzBPd1lKdmJNT20xbU5hQTFrOW12WmNUbWMvMzU4WGlPd2NiaEJvVitY?=
 =?utf-8?B?dUU0STdhOWRpOHpwV0xhMUVSbUJwN21VRnVuV05ONmFSSEFVUGE4SStyUUU3?=
 =?utf-8?B?NzhLb2J6dkFaRWlkNkgrQXVVcWdkZldQWmFOdFBVVFdmbnZGb0pUaVUxOXMy?=
 =?utf-8?B?N1lqYnlscU5rMWVTNG4reDlGV01uVDhNWXRDeGkvTEZYbjdEL3lWbmVmR0Fy?=
 =?utf-8?B?S0dmeUI5enN5aCsycFpjK0lmckdNekdSNEkvVjRVOERtNWxTQ3k0MlhxQTgz?=
 =?utf-8?B?VU9uakxqaXl5RjN5YjU4eVJtRFdZRlF4a2E1dmJ0Y25yOUZFRUZyNDJiZWw1?=
 =?utf-8?B?NU83aU40T2NhUk53RU5kdVUyN203K3VwaTdrMUVjSDNCZEhBcmJSU0o5clpT?=
 =?utf-8?B?NUI0YWM1LzExemJlSG1rNStsWUlXZlpXZ0FCS1FVY2w5ZDRmN2ROQURraUlp?=
 =?utf-8?B?RnZqbkJwVTBEcE5abVpGRHprMng0VFNTNmVUNko5QTZiU2VEUVdpblRpZEtO?=
 =?utf-8?B?RE5jVWp4YnVOTW82L0xPUEJhclNKcnFvUDY1Y3pYWTN3T2ZhS1pMWnM5blcw?=
 =?utf-8?B?eEtGMUJDR2N4MHhpdHU5MHl5cENGbEcxNGNtU0lySTZKbTJmSEgxa09JQWt6?=
 =?utf-8?B?YThMcU9panYwOTFhbXMwMzJsU00wdSswaUF2R0duWS9SNkhFV3psOXhQT0Ju?=
 =?utf-8?B?eml2blJnbTdLandLMG4reU5qV0hVd3o3elRyd1JIcmV4bDFwTmpkKzlZYW9O?=
 =?utf-8?B?cTFkUzM3RC9GaEovWHdHRkFvSXAxMGhyYkR2UmdJbEt4KzRuOWc3SVE5eEpx?=
 =?utf-8?B?UXFZbGozVUtkSHNwYktIYkN2UGRzeDFEVWw3OFdHZlFNYk5MY3FsVG1XVFdk?=
 =?utf-8?B?d0diNE92Um85bEJaYXZkRUw1TFp1L2ljKzJLcGg2RTJ6L0JVWU5Rb3dHWDRm?=
 =?utf-8?B?MGMvbVFjRDV5cFlTTWNVYWNkZEVFdWlSWlpTZTJrNDFCVXJxOUlMQVdXUDE0?=
 =?utf-8?B?ckNDVDhUb0pmWFRLZU50S0lrYzZBb0x5aWNFSDRPaDNFdXg4Q3JLOEpoZFBj?=
 =?utf-8?B?bEJjNkFkdnRqZ1BHRm1MWjVaZWQ5OERxZTNaMzYxOUswQjkrWmU1SXJnb295?=
 =?utf-8?B?eHRkYjlpczhXZmMwMXl4SlpKYllyeklzT3VhdWJ5ZTBWT2o5aGdIbjV3Kzc5?=
 =?utf-8?B?ekxsaU02OUJ0c3R1YkF5dEMyWFI0Z0tmeW5pS1IwN2xKYWRjNjlCd216eWlJ?=
 =?utf-8?B?ZW1lSjhobDZmMmZLQjdIYmUrS2VLL1NDYmRGb2g4aHhlbGhYL2VHNWhWRnFG?=
 =?utf-8?B?RVo4UVh1MnNFcS9KRXRydUJ1TUVjWUNjOGo4R1dwSW5FOVQrQTRDcDRaaUVH?=
 =?utf-8?B?QXFnNUxLMTNuVU5FMW5wNVU0M21UbzhmSWZtdGdaVm5XMlJpUUxZOGhWWDBn?=
 =?utf-8?B?Zzg2TzkxRDh4ckdjblAyd2JEaVlNbkVLd2Y2ajhqRGpnTlpreHNlcmFMY2Nk?=
 =?utf-8?B?dXJkUG5lOHVsSlFxNlVqR3BSbldjTUtrbTg0OTc4WEZpY1padlpCVXFxUTN0?=
 =?utf-8?B?akdLZHFkTmJOek1PL2hzT0VwWjdhVTF2bU1IOHJ4SG5za0p5ZUZMR3FXdnZX?=
 =?utf-8?B?eUhya1RoZmFOLzQwRGlxQUJPL2ZKVWR1T1V6dWxieC9TaHNmeDBrTXkvdVlU?=
 =?utf-8?B?L3pTN1VGc0liY1JrSmw0a0xxWkhHWEw5YWpqem9lT2hXNTQ0Q2o2aC9NdWEw?=
 =?utf-8?B?OEtnemVEaVVGb1ovVHNmaW1ZS1J2V3pzNld3aWxmSE85TGJ4STRBeklaeGl4?=
 =?utf-8?B?L2lTVGZ5RkRQWS9lN0tnVFVWdWhYU0ttdFZwdk1zVjFaYjE4Z3ZHOHk5NnZm?=
 =?utf-8?B?R0dVMVBuSTlFeGpvS0tPeTZxdUtxOE5xLzBsMVlYTGt1TUVJN3BjbDI4QWJG?=
 =?utf-8?B?bExpZUxwRUlDVStib2UvenZibjcrVFhrWHhxU1c5emZOQ1haTGRYWnU0Qk5I?=
 =?utf-8?B?a0ZraXROMFY2VXpOd3VYVDZ0c2ZRazVtbzhFWFFVSmwwRC9FU25sM0NQaWVN?=
 =?utf-8?B?UTdxRENZeXFmOFNiWGY2UlgzdCtiTXNhRUp6czNYbHhtOGVoUHdaYndkTjUr?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 972af0a0-c9c7-4c01-acb2-08dd662f9d2e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 15:14:44.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBRp/Gi9ssPF/7ctWF6TOTezV9IpBtnd3UFjYi/IfKfp1zg6HARymjQOJBebJOLzStLMoRWWkPYHhAQL69fYSUB6yhub2w+oMoRNvVSnKF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com



On 3/13/2025 11:35 AM, Rui Salvaterra wrote:
> This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
> iavf, igb and ice). Fixes an out-of-the-box performance issue when running
> OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
> VLAN configurations, as ethtool isn't part of the default packages and sane
> defaults are expected.
> 
> In my specific case, with an Intel N100-based machine with four I226-V Ethernet
> controllers, my upload performance increased from under 30 Mb/s to the expected
> ~1 Gb/s.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 84307bb7313e..1cb9ce8aa743 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7049,6 +7049,9 @@ static int igc_probe(struct pci_dev *pdev,
>   	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>   			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
>   
> +	/* enable HW vlan tag insertion/stripping by default */
> +	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
> +
>   	/* MTU range: 68 - 9216 */
>   	netdev->min_mtu = ETH_MIN_MTU;
>   	netdev->max_mtu = MAX_STD_JUMBO_FRAME_SIZE;
> 

Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

