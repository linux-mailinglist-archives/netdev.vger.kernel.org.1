Return-Path: <netdev+bounces-130291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BF1989F4A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C09283930
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE772188714;
	Mon, 30 Sep 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAPZghm6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A6183CC1;
	Mon, 30 Sep 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691715; cv=fail; b=aPlHWgQgJRu/Vs0Xit3QiQYkRgg/1pINkCnNaamPvBKYOnOvye1UrFZXRreDYtK+9ICrakDjUi5hYXp+Yz+caFqmhZeDoIlh4p6JRRPfK+/L2YWXH6WO7Lr3shEU8wPt2eCQ9l7ihfRtDPPaUMvWqE+h2hiomgpJnN70EuU/Gh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691715; c=relaxed/simple;
	bh=mD9c07WJ/cqeoYf4BsInQFJpP+0V7Qrg7Iqj8XuvSWg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y7etI3ExAoclaHkD94vrV7n7yZnIIc9bfqw8XicLQoUJXr1IGFDzS547ahkKoZT2D1JNSXmBxmYkL4HO9G/pOu08EGVIwdYjNh0VVouk44P4O6HW1LFlR3UmwK7PQFk0Oi69SvyGeYV3zngfSbvpe0XVKgdDETfWS4W8t6ly9JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAPZghm6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727691714; x=1759227714;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mD9c07WJ/cqeoYf4BsInQFJpP+0V7Qrg7Iqj8XuvSWg=;
  b=TAPZghm6zRLpbbDGlMRjbvw5NgVeq3N3EuHLHt/DWlnrbvce2Yapxe0g
   rIqE5TeApon2DeTeuTiEGRyVXch8einZmWz3yKdmdlpGEPKFR6YHnyedc
   teL7gERbcS+oB9MDpxD/nOtAreEVlqzivVfm1UdLrOmFJdNm3f3bZs3KE
   Px9KCHNtugcPYxCrrh4UUi1nZSt52nCGPnlTXUmfHQk44HHWCrwsHfQ/W
   cHabYiLXUatSnj6FmBTqmbONkqO/poFAq4JieolXagYpOV7lEkf+j4fHS
   8EgWVcxffxylgX/Jvb0ar4ur1VMKAZNksssSRBrcUt74bO6uEV7qUsYAe
   g==;
X-CSE-ConnectionGUID: llbsIR/ERsWCJTagMyJ7yg==
X-CSE-MsgGUID: uf7M0isBRlivlxev3WL4UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="30471070"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="30471070"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 03:21:53 -0700
X-CSE-ConnectionGUID: DpmXndeXRc2YrpJ2Ihp97g==
X-CSE-MsgGUID: oTxS04lTQ5+zzc5nh37qzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77766913"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 03:21:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:21:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 03:21:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 03:21:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFccb2HnzYQ/XqJfoGs6K7wQ0PacKE24/EcC/w98wR8nrz8lcM0TpMh4iauqVo6MckdDRm4JV4YDqm9lLsyLeRfa2+BDSBU6aXY5Z6nFqXhEeZCFQh/f5LaNJlErAFRUo2UzIlra1/2ZmQZQhXYe1tiAsDB+OtI+QNhYXwF8oztI0cMMlPP+qR6m0d5ZJYVzXcvNv1pHxptasGr2PyZMoOlxmcikzgHUaSNbYvUbUY7/puUCEr08/QmR8XDL1eNt+T3PMolR9oG3Yo10P+i7m8gGb+KFZboeScS9GJ9rJ5muzNuZwZHD5fsTvAizvungM2vf8WckLfGdywhaF6EeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0OjlwciV1SZowhHZlQ+TfU0SRp7H76eiJBw+dZTJH8=;
 b=uzWZ7ogpseIBOqoow2QqHLd84SWCQ69Jh/0hwPR4fpeK4+jLUTBeO5EauKQPUqa0jGMCV3cDnDbBva3lOBC0ZXkJ174zMl8K1AWu1QlvYuzzYCuQmERpG2aAxqI90AfkVwcke5LbG7QTQuFEMogRxWO31UIUNU180GIyvTb/zsVhVGTUscyZKxh6VKHZTDXsbzZQDBEKYRXQE8MM4ssD5RqpgJU1H+ZItXopj9yaAz4d6t0CFwJi9BMxjWSlAIyIBW5EC6p3Yy87o8FzFDG+gkQGPS2EvAlqIST9V0DPkzj9Tx5qVBTgcSn61wWs2+c/2PfXE+2HljTafgM1a4DEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 10:21:49 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 10:21:49 +0000
Message-ID: <84f41bd3-2e98-4d69-9075-d808faece2ce@intel.com>
Date: Mon, 30 Sep 2024 12:21:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<amadeuszx.slawinski@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
 <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>
 <faff2ffd-d36b-4655-80dc-35f772748a6c@stanley.mountain>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <faff2ffd-d36b-4655-80dc-35f772748a6c@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW3PR11MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 9792237b-8892-4139-895d-08dce139b1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzZiMnBYcE9xZVpUV2NsazgxT0xRbC9mcDlsbU04WE9uMDhpUTk0Z2VQcXJj?=
 =?utf-8?B?NkxpR1hDWXpldXN3SUcwTnFqdDFkTHUxeTl0NmtsMW9kOUpWMjVLYXQ2V3pX?=
 =?utf-8?B?bldEdWM2ejBsdkgzYkJZMG5TQkNwbnRlaHdkc2hEaVcwU2I1M1NzRjJFM1VL?=
 =?utf-8?B?QmRGTkpWWFkyR3Y0QkFUNVd3aklqK3Nmek1hUFdjalNQT2gwUUUzZ21TMFJX?=
 =?utf-8?B?R3ZQNkZlVFlMWFJ0MkhUNlV5Tlczd0tYSkFEbzFMbU82L1c3MFVmckh0NnQ1?=
 =?utf-8?B?TGVWaHhTbzN5bWlGcDFya093TkptQi8xZERkQmNjbk5ETFhZV1Q2emNGRjF1?=
 =?utf-8?B?V1FNd1VxaTVIRjMyNHhUNDEwVlp2QnNoU3lsZ0Mya3lWQTlpN090N0xvRlVI?=
 =?utf-8?B?ZkNMZTBYbTdhdXVhRVJmeG84UzRxaTg1ZHBjeERoVmk4T3ZUaGFVeU9jL2Js?=
 =?utf-8?B?ZStsYWRITnRDMGNjalNPLzgwYUQ2SVpiVHBoYXJDb3F1c1p1UlNuaHp4dEFX?=
 =?utf-8?B?SW1icGZKRXF4UElMdEVGMVBkb204V25TOTUyb0JxWUhPQnh4NVI5MmhYbHIy?=
 =?utf-8?B?SVBGb0hFYWFabGdSS1d3R0NuSXAyNjJVbnhLazBrVUI4Q1RZWHdJS0ZESFNv?=
 =?utf-8?B?eVFKVk4xWTNNTnRzTmFoWEo4cmhpSmEzejhCL2ZTSFFVZllxaDdHNHp2WkE2?=
 =?utf-8?B?R3YvS3YzTGU0YllGQ2hreFR5NHFDQzM0UHJxc2d4OVp4Q3pNdWZjaVJwZUVr?=
 =?utf-8?B?dVJGR2p2bHMwMElnYlhVck5uYTZZOENuL1I5RCs1TEgzbnBZVWxPRWhReG0w?=
 =?utf-8?B?NlNLYVBBbzNxMzBmZFRHQ2toRmtLclRWZjh1WmJrd0VGa1BuWm9OS0RKaGx4?=
 =?utf-8?B?LzFRN25CeGQrV3BQUkNhUU9IMGxXNnY5RGtZV0h1Yk45ZjVZOGNWMTM2SnNJ?=
 =?utf-8?B?bmpuYnZOSERtQ2J4MVdVd3RvT1I2azVOdUNoR1llR0kwMVJLVVowRlBCMGhR?=
 =?utf-8?B?ZE8rd1p4NC9vRmF5NlNReTZxcmtMcDNTN0srZWlmd1NEWEZpQlZBcVFxVG9k?=
 =?utf-8?B?cDdJR0RtMUUrM212a0hCVGZTVi8wYmk2alJQTFN5anZraVpoaWZLYTc5VmhJ?=
 =?utf-8?B?WkVuTEVwSGFOZi9FTVBKdHkrR29SZlNPMG5XN1V2V2ZXeTRxTzduZU9rc0xK?=
 =?utf-8?B?K3A5ZGRSYnBsUDhCaytyaU9GRjZXREQ0OExMRG1uRTJTbDZSU3pKcXJZVGx3?=
 =?utf-8?B?V2wyUFQwazNPeVh6c1NJaHdEbEFMQVhMbk1NemhPM2JXMG5mUmgySFoxYzNY?=
 =?utf-8?B?QTR4N1pVUlA5ZEhETW13NGFRQWZNbnhvTm13WWpFaFBZT25DTVFlVzJYZkFV?=
 =?utf-8?B?OHlvMGJDbHQvalVaNUtoY1dDdmQyaGMwdk5mQ2JER1Bqb0NONFlFdjRvbllS?=
 =?utf-8?B?eU52clBRKzBkbWNBTmR5eVJ0dnVmVXViNmtqaGlTZDdhY1JFVmhHTVhicXNw?=
 =?utf-8?B?eVZEWkpIUzRTWm1wZWFwMVJvc0FBRnZYZkpMalRQTjBnZjFMUnhYS2dYSTFH?=
 =?utf-8?B?V05NeW5XQ0x4ckhXQzVLb3hLY0lPdFcraUxVMFFLeVJ0c0lSZ2xSM1NwS2lm?=
 =?utf-8?B?b0xZYjQ1M1dNQnRmK2tjVkl1MVhUTERHcTBYNFF4Y0pQTlYzNVIvMzMyOGFP?=
 =?utf-8?B?RlhCeGpmc2xrcUlVcUF3MjI2U1FsRXRvclhWTkJoQk1sQkxjV0YwNWF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWd0N0NHK0dzN3oxK0VkN1VPbk01MHRRelhseVo3bHpaWXBLOHFvOFVoU1Bt?=
 =?utf-8?B?UWlVR3dKNzkyNDNyY3lWVGsyRytWMjZieG4rLzZUY2hxMmFJTWkyV1FRb215?=
 =?utf-8?B?QzFrK01Fck1wYXI4RkoydzFLVWhPM2VpRUFiT2szb1BOS3BUazU2L1NPOFpN?=
 =?utf-8?B?QXZTL2tPR0cxSnE3MTdmY3ZBNGhCR3cwcmlwTG5jd3RpUE9sL295K1V6Umhk?=
 =?utf-8?B?RlNCYm9rSmJpWXlycE14YkdDbUZqZDNNQzh1cFVPQUdOVTUxUTFrVDVsdjF2?=
 =?utf-8?B?cVVlVWNHdFBpTlcraDZRTEUxTFhmVW5lem90ZFBRNkNXSTlHVDlSYnBkQ3hm?=
 =?utf-8?B?L0p1ZjgrSEIrT3p2TW5WRWtvajh4cnBJS3cxbGFyTjNabzVBYmx5NmNSeHZv?=
 =?utf-8?B?dWlCaC9TNlJ6c0lOaCs1dFJHTGlTK2w5TFo4bksyQjNWWEg0ZFlpbVhrUi9D?=
 =?utf-8?B?TnBzMmcrU2NpOVFSczI3dXVWakhYdEZmQjZnclFDeVQ2ZWVDUFhiL2h5NVhE?=
 =?utf-8?B?UTdsV1FWYStjWGZQUzZEZVdSSEMxSFJtZWtnU2tWSmFUbkR6VHE4RkF0VVZm?=
 =?utf-8?B?UmpQeUxGdlRyUW9ZaDBnVmk3ZTNrVUJ5WGV0a3QyTzFkYXhjMk5tNm51SEp0?=
 =?utf-8?B?Zm4xSndOQjZQQzRSWm41QUJkcjI0aUp2anR4RXBodGxWRjcySEV3WmhISXF0?=
 =?utf-8?B?VUZwSFRXemNKMzFlWGlOS3pEUUphSzU4VHJnSmZBbksyNzg5WE1uNkRTa1M3?=
 =?utf-8?B?bUMwMXh6UUVqdmt6WXdmaVhZajZER2RaZjhuZ21ldzArem9ud1RIY2V4cnU4?=
 =?utf-8?B?NzhuK092U0htZzYvVnBmazFwbCs2dXJabmh4c0NyVWN4M2VMdUlyUnpVejRa?=
 =?utf-8?B?Z2p2MkJHOEhJQ1NVWVNCV1FPZ0luUGZ6Q0MyUXdWZmJwdjRzWUlnSkRPY0xv?=
 =?utf-8?B?WnVNWlhEVGRMRE5td1RSTUJzK1F3b3RwRmJYTVFaWlpDSVdvellPMTRSaWRo?=
 =?utf-8?B?RkJKSTJsSVJYZUlaTG9uWW8rSStoNzlKdmlsUEZEWXZLeUpKN1U1ZkR4OWlo?=
 =?utf-8?B?VENrQ0JOWDNkSThOZUJ5Y3FGdUN0ei9MZTJudEpiTzg3QmVFK1hCMXdRNnhB?=
 =?utf-8?B?ZERUQ0R3cjNtekZLSGJ4Q1FxbjBadVRMMGxwMWNrOVcwSHlTK1BianAzMVJI?=
 =?utf-8?B?TjdxOUQ2NGlJeERqMFJZMzBHYkNmZ3ZuY2dTZXpxWjgrV2k0eElMV2RyVVIy?=
 =?utf-8?B?VXNLTWxKRC9jb2VIUXdxZEJVdzluWDQ5RGhTSGRIcEtXa056eG5TVUVLN3N6?=
 =?utf-8?B?MUpjUTU3TTJtVDh6UC9HSVQ5SzJLdW5GRFJ4T1k0L0pZSDNjdXBXdjBKQkJR?=
 =?utf-8?B?dWFtWE9lWFI5R0xUTzZsM2JybkZPYkZZdm55Z0dNUHVXVHVYZGZSKy9qU2Zx?=
 =?utf-8?B?VituYnd5Yk1JQ0s0SnpyYmdlVkd1NWZXNDZabVhYODhCOUN3YVN0ZnFSTCs2?=
 =?utf-8?B?czg2UTZOUmF1bEVHd2RNUWE1VFdLSDlWZmF1SVBUckxvK3VpUlpGUVhtWm5J?=
 =?utf-8?B?VkJwcXZmVUppeTM1SC8ySWwrNHhraDBkd09GWDlyWTl6MnNTUzhQU3NPNnNh?=
 =?utf-8?B?SmNRTUg2aUE5ZUU2M1M1bEJrV1FIZVNNYUVFRktzd09RNjJGS1lOVWU0ZkJQ?=
 =?utf-8?B?dkl2TmxwZTdPL292M0lyTHd1NmkxNCsyN25DR0dyZ2VJbFR6TXc3NGZOT0c3?=
 =?utf-8?B?MTR0ZzR0b25MRThnZ0VRUEU1ZXdOa1hoOTVMVnBVc0hyM0NIZ1RQelV0aklE?=
 =?utf-8?B?UURmTmU1MGZHeE03bm0wdFFFUndMbnhrVmVyeUxRdncxRkU3MWZoY1UyQzkz?=
 =?utf-8?B?YlhFcXdiQ1Y1REhOR2FsYlp1RC84OUgzZGJxbUpoNHZoeHo5YUY1RTZoamNu?=
 =?utf-8?B?ZTh1UDlocG1ZdUFseko2RCtYcFZjR2gwNTZ6MFZTQ2g4M2YvczNRcE9pWE1k?=
 =?utf-8?B?NGU5bDZPTklDVHFVQWEreUJVL2hYSHcrb2ZBYVN0SndHVUdaaFFCR25kc29O?=
 =?utf-8?B?MzRWR1owTTdOb0hwcU9JMDlYYlIxdEY4SlRlTVJ1YnJ0U2VCdG9abjVDR3ZP?=
 =?utf-8?B?K00xQW1XMndOQTRzYzdPOW5UVHp4WXhnWHQxWkEvMmp6b1RtTHhWaCtVcDV1?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9792237b-8892-4139-895d-08dce139b1b2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 10:21:49.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs8Xasa1WnwYqpdA0pW/ZvBCkpUbANNBjbTSXrT8/9QeC+7G6XynI+1aNKkecJ/+emN57UlDDYZnLY9+QN67bFFRc0RV4fCVtpXYsL4LujQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com

On 9/27/24 17:04, Dan Carpenter wrote:
> On Fri, Sep 27, 2024 at 04:08:30PM +0200, Przemek Kitszel wrote:
>> On 9/27/24 09:31, Dan Carpenter wrote:
>>> On Thu, Sep 26, 2024 at 03:41:38PM +0200, Przemek Kitszel wrote:
>>>> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
>>>> index d9e613803df1..6b568a8a7f9c 100644
>>>> --- a/include/linux/cleanup.h
>>>> +++ b/include/linux/cleanup.h
>>>> @@ -168,9 +168,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>>>>    #define __guard_ptr(_name) class_##_name##_lock_ptr
>>>> -#define scoped_guard(_name, args...)					\
>>>> -	for (CLASS(_name, scope)(args),					\
>>>> -	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
>>>> +#define scoped_guard(_name, args...)	\
>>>> +	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
>>>> +
>>>> +#define __scoped_guard_labeled(_label, _name, args...)	\
>>>> +	if (0)						\
>>>> +		_label: ;				\
>>>> +	else						\
>>>> +		for (CLASS(_name, scope)(args);		\
>>>> +		     __guard_ptr(_name)(&scope), 1;	\
>>>                                                  ^^^
>>>> +		     ({ goto _label; }))
>>>
>>> Remove the ", 1".  The point of the __guard_ptr() condition is for try_locks
>>> but the ", 1" means they always succeed.  The only try lock I can find in
>>
>> You are right that the __guard_ptr() is conditional for the benefit of
>> try_locks. But here we have unconditional lock. And removing ", 1" part
>> makes compiler complaining with the very same message:
>> error: control reaches end of non-void function [-Werror=return-type]
>>
>> so ", 1" part is on purpose and must stay there to aid compiler.
>>
>>> the current tree is tsc200x_esd_work().
> 
> Obviously, we can't break stuff and also checking __guard_ptr(_name)(&scope) is
> pointless if we're going to ignore the return value.
> 
> But, sure, I get that we want to the compiler to know that regular spin_lock()
> is going to succeed and spin_trylock() might not.  As a static checker
> developer, I want that as well.  Currently, whenever someone creates a new class
> of locks, I have to add a couple lines to Smatch to add this information.  It's
> not a huge deal, but it would be nice to avoid this.
> 
> I did a `git grep scoped_guard | grep try` and I think tsc200x_esd_work() is the
> only place which actually uses try locks with scoped_guard().  If it's just the
> one, then why don't we create a scoped_guard_trylock() macro?

Most of the time it is just easier to bend your driver than change or
extend the core of the kernel.

There is actually scoped_cond_guard() which is a trylock variant.

scoped_guard(mutex_try, &ts->mutex) you have found is semantically
wrong and must be fixed.

---
I have received also a bot message about "if (x) scoped_guard(y, z)"
usage (without braces), so will need to adjust it too.

