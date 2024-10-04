Return-Path: <netdev+bounces-132277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD6999126E
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C561F21FDD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6BF1B4F3B;
	Fri,  4 Oct 2024 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kp/PjhAT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575361B4F12
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081645; cv=fail; b=LweBjE6tYPQUNCOpCvI01+5oGOhDw2cJGOBXyBVKu0h01fkcck8fT0GUhJYoO8qegPUAEw6SE/PY+sYZ4kYwAz8OuAbfBQBozqXcpIvmAUuAueQbFMkoH3SJ+wq/OWmFvm4wn+niTlKEkwi5x/jWFc1dtBX1Mw425/GbieuN3Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081645; c=relaxed/simple;
	bh=PDPvTkF4VINELUfQ3+keWM/5rx6MDMremUwaJGDtvcs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sTWPHlG9Jp5XTz0XGQmDg6OWT+TUFGnP048Ckg4U+PrR0L/b73GnA1YRCkOw+Qy9I6bntWSqrIbF2AdEnFmMGGowBGqRIe0AA4adEYgwMTf8h5XWffEcEUBdAFhIxbIPQXaxmhpoVmDoqFBb0zwgeudcYz5fsNXrp1/peoe/1TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kp/PjhAT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728081644; x=1759617644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PDPvTkF4VINELUfQ3+keWM/5rx6MDMremUwaJGDtvcs=;
  b=kp/PjhATl6acT21FncHSgzhpFvlnE5JBsbckab4TANbGR3pT11XnCyqV
   AL0lyAab/ErWrWebaj2s+Nr9mN/22H97mjWT45097veuqlj818LmYstEA
   yG4XxWtmlmKct78wrCn+5/0IMBhzQGGkNOiHWe6SbY0kmviEGPZEZnVZ6
   5odS9ItX5RHG9LzshXUNStB7yXQUS+NH8KAVL8CeZjwSFSxm25z4LKJtE
   nFcUEjGcAgI1z0IXcCaw+e8hMmPZzB+m+FT0cqtSFR7ukBRhlZ+lBHBjn
   6EVZ5eAq/xUmoaJdJoAdHfcMelwxSoVKhUTVq8sVuh5xW5xavaxnYwf9F
   Q==;
X-CSE-ConnectionGUID: fEGNFF3DQs2pTM6RikUfdQ==
X-CSE-MsgGUID: Kn8fmY8CT32TJVvKZLMTNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27448370"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27448370"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:40:44 -0700
X-CSE-ConnectionGUID: 3P8KooUcTA6Od+zxYX3hVA==
X-CSE-MsgGUID: fij2EdgUQuuGNulsOHiRyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="75662460"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:40:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:40:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:40:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:40:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdonjH3YIUgylXfRcECBuPgejft4Q3UfKYgWlN5QkEohaGcTZkSsPfMUdvis7/FLqbE47cE+nGO5lw3UmnuiL+BOR8zMSov7codnEvqE4Mywi5HBb93xUeIAFSeJOr2pHZIRHcZd36Tj6bBtHgL9bjYxwxXeU0w+eUdR4U+jEMfdI9nJDy3I2XJMVuyy+Elf/T0DLU75gnOP6KJyQDdi1RRdlVp36TIn64ajHtv0h0fzsS5NFTi4BAG7gGT56YTzHKrkF8fPZuafbHT8ZFWvd70QhjeJa5dwvi392ow3CrY8N/mMo8vm+EEuid3hLLlfftjAxIlKSgdN+/wnivViJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExQoew4KyVx7w6Tjs1E4XNPxdsI2hh6Af74eHHka3/U=;
 b=Ew218hJ2kqaFL7PINrfQMeUOAe76k7vKYOBV2h4ydHWTOzY39C1yb4UVlQe3xfZXJtk8rPwRS7+SXQe/P8I2nv/Ngcggo7WaDcyJWhlp4gEjS5jTL2xZGw11TsW3w5/UXNSYN/cN+mRk9Y38+XdHJb03FAeZIXM7u0QU0MQxrGNjdymRjlzvzdQu8Bmuj7DYHtIWuZKj8X+q8jBoe19dDz+xzhgDQwKWFQj1u02P1afdrXoQ2Ckvx1NP7MeCC3TV/6uSm5SXkvQNdsxvk5IxugyTJgnEmPdruqzyYZLJnSoVdwjfcxSzfiPxQC3bJYWH72nmvpQrsHM6k9ceg/CUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 22:40:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:40:40 +0000
Message-ID: <c158497a-4e18-4023-83d9-a0e3b5a425f0@intel.com>
Date: Fri, 4 Oct 2024 15:40:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] gve: move DQO rx buffer management
 related code to a new file
To: Praveen Kaligineedi <pkaligineedi@google.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <jeroendb@google.com>,
	<shailend@google.com>, <hramamurthy@google.com>, <ziweixiao@google.com>,
	<shannon.nelson@amd.com>
References: <20241003163042.194168-1-pkaligineedi@google.com>
 <20241003163042.194168-2-pkaligineedi@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241003163042.194168-2-pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bc3d25-0c4e-4429-6ff1-08dce4c59312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0Z0U250eTArWEFuc0NPQlo0VmRKNU13b2lSLyt1dVg5ZzJrMFM2a0FabzMr?=
 =?utf-8?B?Q29pZWNXa1ZxMzkzOXZPYitzYzZwaHh3dFlZbU1GNXZiVytaQ3ZadUMrK1RT?=
 =?utf-8?B?bHRkQUNETVQxMzdDSUtZaDZ2RmREVFlIVDUwV2VWa1N4VEJJc1BtU0xRKzZl?=
 =?utf-8?B?eWhnelE0ZVIxSlpQYmwxNHgzTmp0eVhETFdZNHJpUlR1QzExZU4xcmQwZnQz?=
 =?utf-8?B?amdBS1ByUUxMcFFQNUxUeTl1M1hJdi9aNkxpdWZ5dFF2UVhHSmwrOHArQmpL?=
 =?utf-8?B?N2hRTHk4aTRDSDFRMkR3Yyt4ck1iZUp5TFhQbzJFUnAxZVpHMjFvb1VYT3M3?=
 =?utf-8?B?Ulc5bkJPY3FVMStVN0YyYzhvd3REWXRFZE4xczRjQXN5NytJbVNLdUxwWkF0?=
 =?utf-8?B?bnE5QXpKQzJtOFUzKy9ncUZBTFBIUkNqNUJSZU84T0hXZmlGeklHcjRITlhy?=
 =?utf-8?B?cElHNFlTWGk4STdCc0hXRi9tZUpvMjlQRmtVdlFrQWliK05rRGM3c0x1anMw?=
 =?utf-8?B?VWN1WmhJemU3MDgvZ1pTemttdWdzZVNkWGlnV0pqZTFHWW9QbFppRFZmWUl3?=
 =?utf-8?B?WDR1bndOTGRUR2lFTEFiUEdqODVicjU2Nk1RWnN5M3M4dFhRWWNzODdIY2Fl?=
 =?utf-8?B?R3JrRVpwOXRSdXVBZ1p2Mjh1WVIrTnAxWEZsWU10SkJHajdpMHdMcUk4bTFl?=
 =?utf-8?B?ekJDNnRBc0dwVlJGWThrdEVDQmZPQk43dlNmSFpKdk5hZ0xQeUJLYnNIcEp0?=
 =?utf-8?B?RU5vU3Jwa1BjdkcwYVVyY2JiTmtEMHpwMWJiajFIeTNQSnhPSEliRWJybkpX?=
 =?utf-8?B?eUpmWGR3eHZ6SVh5b0tkRysyblVGdEtzVU9DV05KQXlsaWxXVnJyTWtYZi91?=
 =?utf-8?B?cXUzNld5WFZYM2pubDZLRDJHN2YvbDhkdlpKei9HVm9Qa0JPU2Fsa2x4TFRv?=
 =?utf-8?B?SkV6bHYzQ3dibjIwMTRzbHNncXZRN0E3U3UxVE9oK3M2dGMzMTZnK3NEekVT?=
 =?utf-8?B?UkRycjNyYW1Mc1kxRmU2UjZNUGNicEQ5Sm5tblplZllqREljNHBJU2lYMjQz?=
 =?utf-8?B?TnNoUk4xTUt3eHNYemFTU29YMC9McUc2d1MyOG1xNjljNnNhM0lnTklSNWZW?=
 =?utf-8?B?WjA5Y1lEclFkb2xqY1hJMVZxeW5TZjlPb09rQzl2TzYyMWptL0UwWkU0T042?=
 =?utf-8?B?ZkQvSnduc0JnUWV6ZVYyQ3F6Um1vbS9rUWV4RGxxVzIyelpxR3VtMitBSE1o?=
 =?utf-8?B?M3J0VjJRSElxZDZidzl4OFpjTUNJbkZ1VmkveFh3R0twZEdBRTRMV0lvMEdD?=
 =?utf-8?B?bExBRHY1NUlpL3VYUVVDb3NGTTB4a2dUVnFCUW91aFM2ckZXTEIwMEVnTW95?=
 =?utf-8?B?eGxRZ3hqcWI4R2dmVlU4NXFCUUNhdjFaaEtsRTdaMW1MelYvVlpHUUc4TCtk?=
 =?utf-8?B?UHdmek1SbnJVTEpCUWswRGdoVkdHNnFLYk1KUFRtb2ovem4yYktsRkxkdjla?=
 =?utf-8?B?aEhzTVkrRGQ1ZWNUbFlUVnozNitIemRIWGI3TkZ6cCtUUGJHOWtsU3ZRVURS?=
 =?utf-8?B?MnhndUpTdmpoOEtCQktwZjU5M3lFWEE4ZTJMSXp1VVBsdVRmOWxBM3BUUVdw?=
 =?utf-8?B?eXQzSnYrd1NpYUUvcmN6U3ZsV244RWhkaVZWVTZlL0o5NnNaVjJna1FYZlYy?=
 =?utf-8?B?YWlrQnBMV3lDNUVJN1RPd2tzQWFrUGxBQTN0cUpZdm5USlBJaWdXTlBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDhzQWhvL0RpYlducHgwUjlRUjlZL1gzVTZ5aEhUMzZYT3hSRmtVNWIyYnI5?=
 =?utf-8?B?VzBwTWVpeUJheDZHY1laNWYvTlg3dGdyQ1NjSk5WOVFpcHlnN2l2V05FYUYz?=
 =?utf-8?B?Q3A4SGJzQ2FHZFY2SzBud0NEU0RGWkNEa3o2SFdFank3dE5kK1BwbE9scXU5?=
 =?utf-8?B?dE5hRjJFb3p4L0ZJVWlFaGt4TVhESUtrSWw2MHJPSk0xQ0RWRmJ6RVBPZ0N3?=
 =?utf-8?B?cTdUenBHbGQwNUdRK1ZVSVM0VnIrMVRiY3hFNXJ3cWV5MVBRUk5CT0g4L2dQ?=
 =?utf-8?B?OGYvS0txck1jbEx5Slc5Rm1OWTdEK0Y1MEd3RGsyclkyVW91L2gwaFBtT0xa?=
 =?utf-8?B?dlRJY2pKTTJKQTRza2VuRlhFNnRhRzk4dnJ6a1RxcmswOG8wVHhJNkpQK05P?=
 =?utf-8?B?UVIvS1lyemtVTHBOSUpGMnJoZ3N1WlpxNmxOQi9VTEVJa2xHS1I4enpMbVNr?=
 =?utf-8?B?Y3hsMG0remxNWU9RMnBoZCtNc2JJdVBEWmdtYW8zMGRzbkZXUnVxeGp2WUEz?=
 =?utf-8?B?dWkzWko3K2VWRzd1TXVEQjVrdWtWb1JEblF6MG80WXB1TVZyVG5WNFpVd2pr?=
 =?utf-8?B?T3pnUndZb2lreWtEbG11WEtnaDUvZytBSEVIOXRocEhJc2pxWWJmd0NDWEc3?=
 =?utf-8?B?NDh6TkxaeitxL2ZncHh2OHdzNHMxY3BWeVAxQVN1ODlYYjZZWjY2QzlMcjRW?=
 =?utf-8?B?eWpueitRVEdwZm1qNWYzYzF5YlB5MEkxbDJmaWR2V2xoVFBDc2s5VXZCeEVZ?=
 =?utf-8?B?cmh2amp3TEJNRWNvd2FhaUZTamEvNHVGK0Z5TVpIY0cxUVdudzJ4UnFpOHZC?=
 =?utf-8?B?SDFTMWZianlYRUZyRTlHa3NTRGxLMGVEUGg3Umh1bEdmZkFwYWhsM3NmcjIw?=
 =?utf-8?B?T2lGWm5NOWxMR2dtdndkUmNyT2V3ajRoR2ZJZDZNYURZNlZHSi83VDNyNE1k?=
 =?utf-8?B?YkRMUHVUL1RSSXY3RzJCSm5ZUHcvWHhrS1hEbktuUWMwbTFOUEgwbDRDV3dh?=
 =?utf-8?B?R1NCYStRVlQyYXNONFkwSU1Ebjd1aXQ5bnNLZzE0eTgvTU1KaE1GSktTMHla?=
 =?utf-8?B?TjVERFJSRThFNUxOYi9Udm1GR2dHeG5ZbmZicmQ4RURLZWd6aDVWQXpYTjBh?=
 =?utf-8?B?NmJaV0c1N1JIVmVLUkw3ampIeEtubTduVldOZEEyRVpjYmNjK29Mb0RBZjZC?=
 =?utf-8?B?MGZ2VFovc2Q5YjY0eWJrM2o5ZGJKdWl5Q0EzZU5jWmJEYy9xa3JFR2pLUDJT?=
 =?utf-8?B?TEpjU0hRVWVpNjh5ckhVMWdlWlpFSzZWb1I2a1FVTG9meFRBWFFxZTBOR245?=
 =?utf-8?B?TlRGbmxBRU5Oa3NyR1lnTFlRNXMyMjZWL0VZWVBPTG90b2k2dUhkZ1JSZHRp?=
 =?utf-8?B?VDNnZnpIVk1SMG1zUXhZdlUreXArT0M0MTFxc3pTQ0lNdHhzczkybzZQUnhZ?=
 =?utf-8?B?QlRxekV6YVRyVTBVcmp4SWl5SldaQVpaMXd1T0xKNXA2OGdhMU1PRHJpR0Er?=
 =?utf-8?B?dzg0VmtzSExxbmxOazJrVThnc2x3TlFGWnVhc0hMaDZSYThpdUVleEJTdzZr?=
 =?utf-8?B?NElUaUhMeWJPcEtleEkzWjY4TjZROHdUcE9MMXB4REV6ZVg4NW5DZGRkTEQr?=
 =?utf-8?B?aW5CU1p0T2xoRjExU3lzRk5RcmV1TVAvY1ZxRWxBRUFtVVAyUnpUdlFtYkVR?=
 =?utf-8?B?QkxUaTcwa2hPTVpYU29lb2NwOHk1R2crc3drYnRKSnlJU2VocGpvWUZMMGNN?=
 =?utf-8?B?dEhUVE02UTFZcG51Y00wTmxIUkZUeXVyV2pQM29aTDgvZUFtTS9RVlpOOXhv?=
 =?utf-8?B?b3JvUUVrRmpOS3JGaDJ4b3BBanJMbmZ2a3B0dE1TTmdXd3JwUjJQamR1bGVL?=
 =?utf-8?B?bkpGWE9DeDFrRkh0SlJVcmVHQ2hsLzNOaGpMaXYyemswSXNjMGZ6dTd2d2ty?=
 =?utf-8?B?cnpFM0NRcXpnS1FHYzA0NXJ5TDJnTXdzVWVHdmFPSFJpekhWbUhUa2RzUEM5?=
 =?utf-8?B?RytnNVgrRkhOY1JWc09tSVl0ckVjakIyWTZkZ3llTUs1Q3pHSkh2V1hUcEN3?=
 =?utf-8?B?LzhITk90Q2lrQlFwYThmWnQ5S1BXQ2NkTmpjSGFyWDFHMHRRRDIzRnAzeDdQ?=
 =?utf-8?B?ejQ1NDAya1pYNXpnYUpGaHZXbWZ5ZVA3OXFHU25aMWpSUEUrUUZNRUl1S2x4?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bc3d25-0c4e-4429-6ff1-08dce4c59312
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:40:40.8197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SbO2SAnowQNmJXSbFn81m5/TqESkEn/51CjMX8r4qGd/qT0Y9N5WZSQNKATHXSb7pnKhWQ5xyFW+XvJVJ/JHLqfeWDcRFD6FQyNeGhnEdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com



On 10/3/2024 9:30 AM, Praveen Kaligineedi wrote:
> From: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> In preparation for the upcoming page pool adoption for DQO
> raw addressing mode, move RX buffer management code to a new
> file. In the follow on patches, page pool code will be added
> to this file.
> 
> No functional change, just movement of code.
> 
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> 
I viewed this with git's '--color-moved-lines' support and it matches
what I would expect (i.e. code is moved but not altered).

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

