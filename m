Return-Path: <netdev+bounces-256504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA4LImihgmlgWwMAu9opvQ
	(envelope-from <netdev+bounces-256504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:31:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 102B1E071B
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3A33015CB3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7223EAA0;
	Wed,  4 Feb 2026 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6P3uOC5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08D21ABC9;
	Wed,  4 Feb 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770168656; cv=fail; b=VcjXm4M1yZ1au/u2TMdUbUeeec2DAnOrjWVt0egtFtyofqQeZm87R2AGj9VTfBIDH8N2kNH++Re2ibVbqmavqbA3AhZz5gTU7WvflfgC7IkfIBBiKI+LmX8Cf+DpVBAadnOvM9CkQFXdTNg/4X3Tjmq2RTFv3MYjU1Ea9gcEtQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770168656; c=relaxed/simple;
	bh=J+8g5eFPCBh5p7rkPI6/m+5DpWjHyUASrYyzzJxHywc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gK5KyctIWWCTAL/dI2kQ+/wWOAioWrmJpT9aYRnqyMWIpAeE1f7Sy4VrMUaa6W3ZCBsgS3g+R6R9X5u+NEcXroEDVCCYwEH3MvjVDhVawFdQYZnDc3Ww1jVzR80GQ78G8NWrmpKr7g79kVE9/BdC6uGMuB1jsLxEEMbuSZ/ewho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6P3uOC5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770168656; x=1801704656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J+8g5eFPCBh5p7rkPI6/m+5DpWjHyUASrYyzzJxHywc=;
  b=Y6P3uOC5LRHb+XYi2gjVibA4YJQzgaHLhIl854yhExH0ESBcphXMJ7Zv
   St9wcLdtM7fePfVtrwQwswT4XR7GgqHW3b76qaAORTnxq38nNc76LI84x
   DeV4Of6E5zYMK+MJt/Y/aZnBs3s8zqFsr6unQme5ip6x72WehQKhS8n12
   G0ZWVSX3ATSvkeC3UbkE+GDo5S60ZcJp3lvBAwVgD/8MWFl8+HqXmNwwH
   wJ4ygmCC7kFl7Iw0Ab2XKZE1IgcTGBGlm5ykMH18ktg3vMvMc31otjtNF
   o4DCiNUsIsqc9ulMLcJISyUTNBAF5ZT+ESRk1i1u/I4WBGw49jEqGrlkk
   Q==;
X-CSE-ConnectionGUID: 9brbVtTRTLSMtCiktVlYbg==
X-CSE-MsgGUID: 3z4OjVSzQguWjI2TUSyPUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82462665"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="82462665"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:30:55 -0800
X-CSE-ConnectionGUID: xUIsKGTITz2LMV2uAJoqqQ==
X-CSE-MsgGUID: Op27cxl4TCKVBeUVgpIWmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210092179"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:30:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 17:30:53 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 17:30:53 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 17:30:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlpT3mUmxtbq7s3BWcXDqU34Rl+nz7dM3H1owK3i0AJG6klnK75op4t7NKCzRvDY4EWgrWrt7oxXxvqNTM14y+hEJXbWf+0+XYzvKVDKlaKSi3/Ifpd34QZpKt21yqvLGZlCDWz9xAURW2BJnqE8OKhpNiYp1eJlKTwW5bSvbqQyvIeQiJzWZ/Q9AVwMhaYRFufuLWQKxLV0qSaFWDZbt3EUKrCSUJd12iVJlXz45/lcln3++pV8b2tEC1ORiK9d2iaH3mMPuwfUzYLXH4FIrA/VYWOu8x+urem8w000/z/K+2xS6q8jXcwPlHjwhmO0AkTKFEJsYNO32QILr5QESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLkwqhSvs25bxniaoYZQGL/WEN4lXBWxstfEnG9gcHs=;
 b=o1kxfryKFqmSaN+idkzPXiMWot3GRKOv3vqYahn+IkGqBjYOOXK0W3dOzE8B6gwKeSlFbNpy0guOxBmKx2H/pBx7fXSGobNZguyq5NmiUAQr63Z/QHMAheIbjc0ol1WRnldcTXslI59iHk5er0/sJZ2uh47P9+uTNkCF1GGqivT5D6BJyPwWMSGnKHNiYF3OEDLOeaWdbuyxz/Hhcy0PmcrbVM4J6s7Z865DrX5MjM2Choue5OsUPhYdXU43644HPM500r+aXhNQCqLTn37RUqDnE0CPAfSZugkLMLvvXbQOIo7SxxygjzIRDIR/bDwTNw7K9HxwrZx0y7ATIAQZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Wed, 4 Feb 2026 01:30:50 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 01:30:49 +0000
Message-ID: <2b7049bd-1b85-4e6a-be3e-0f3efe3b809a@intel.com>
Date: Tue, 3 Feb 2026 17:30:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hns3: fix double free issue for tx spare buffer
To: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260202105837.1909444-1-shaojijie@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260202105837.1909444-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0315.namprd04.prod.outlook.com
 (2603:10b6:303:82::20) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9efd26-d1d7-4c8c-afdd-08de638d06f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnAzYWZmYXhrY1lsWHV4TFhiNThRSHlHQTlFQUViWDNsVS9mQzIvSDRiTHBJ?=
 =?utf-8?B?OFVBRnh4OGl6WmVGWGlIWXh6emRjcVBKa0QwVGxmQzloRkpZVDJQTUlqY3R2?=
 =?utf-8?B?S0ZQMHMvdTBiZTA2SmVya3FzMWRzTllnT1BOWFI3WktjSlRtNHZTQkhEVHZ4?=
 =?utf-8?B?aStJcnNNVWRiS0VuRzhsT0RHbVYxSVhqVDFmMUsrbHo4VWJ3bDY4UmxyMm96?=
 =?utf-8?B?bXIvMUF5K0s4V1lYVjY5YUNsbGhOZjloVTgvYzBmeGg0SXhCRmlaQzNjWXpr?=
 =?utf-8?B?LzlPNVVUdjBVc0tzazVsOGxRbGZwdndTQnhKMVdvL3RpN3lacmtFWTdjZnIr?=
 =?utf-8?B?dTA2WFNZRW9wZTl3a0QxeTZyNkZiK3ZvTm9oeE1kdzN2Q016OERVYmI1TEdt?=
 =?utf-8?B?UVNGZXFRejIrTSt3SXc3WmVUVzdIMFNhRFdwY2o3SHp2Q1dRUVZmOE0zdGlP?=
 =?utf-8?B?SFMyOTJrL2M2V2QvR0pJaTJZeVVab2xPOVNCSi9uOFJwNlpWMjc4aGFteWhF?=
 =?utf-8?B?NDZLaUlLZ1Z4ZXY1YkhVVVBjb21BczhoYzljT1VINUFkc3pkRVk5NmF4cXZW?=
 =?utf-8?B?TDdYUG5SOWdpWTBhVHphRUtRVE13NG03TFZnRGVYSTFFdEVKbnpYcEQ0WHc1?=
 =?utf-8?B?ZGxoM1lYeThBVmlPNWo5N3JCeFVveG8wM2RoUENmdUVDZWZSNk50R0ZJRmQ1?=
 =?utf-8?B?REszMUdlTjlOeVBIZXBTdXlaTDhEb21SZDBGVllHYWJEQmQ4b3FDTnlESnZ2?=
 =?utf-8?B?ZERHSTNBc1l2UFFQS0hxVlp3MlNaeGoyYk5mRmNCY0o2QVh2VkV6M3ZsYlM0?=
 =?utf-8?B?ZjZHeVhrcFRhM1U0R0NKbElRblIxUWE2TnBqbm41bHF1VjRsaldvbG9HN1V3?=
 =?utf-8?B?NFJoNk5DNVIwYjVFZUZ3NFIxM2tOcTZYd1NIN3RwU1M5cVJkTnJ3M3BQZ0oz?=
 =?utf-8?B?cTNPdUcyWDFKRGdtc0VVUE1NcE03MXJUL3M1SEJFTjMrZVZMM0c2a1E1MXVL?=
 =?utf-8?B?OC92a2N2dlYzeVYyUy9UdTRQVlk4OUZKQjdWL1lSdElkajRaZDZnTXAvZHlj?=
 =?utf-8?B?RWpxdFlibWtkMWpCVzdxTzNRb3h5Tm5LcnZsWitzUXhHYnVZVHd4WWxRcDky?=
 =?utf-8?B?bzA5WUc2cTluSTUxK0YwcElCZnNzRWRZUm9JTTczdXBuOGYrcm55d0xvNzEr?=
 =?utf-8?B?RWs5V3ZJV20zTWVaQVdsWURMTzBuVCtDUXZJNG9aQlR6VG5Sa2k0ZzBpczhs?=
 =?utf-8?B?dWtUU0trUGZ1Q3NHK21FSGl2S1JuMzlyNG45YUpsdVBUZ3VwZlFjZ0NBbVpi?=
 =?utf-8?B?UTNLKytmeUZQZ2p2cjBxcjFqUXJlTWwxRDczcEtmcjZYS1RhdXpQUkU5bjlZ?=
 =?utf-8?B?ZHlEUlJSd2NUc0pwL3VJOHl5bDhwKzN4WkJ0TTFjd3NtblE1UDZwMlM4SUpv?=
 =?utf-8?B?V3l5d2gxMCsrb1F5UVY1NDNxVDk0c24rL1FXeW5EL1N0STVvZ3dVclArODB3?=
 =?utf-8?B?aEN1a1ZzUlcxK2U1L0Fyd0dRcjBJQlpyWWpBdHl5bGduUHNrWUQ3UmRPaG1K?=
 =?utf-8?B?L2xpdEtwbGdBS3VFRXY0eWoydVhQbi9vcVFUWVAvT09LQkN0b2JXRHlDVVND?=
 =?utf-8?B?RGdtVmlKUTVYR2RDdng2Z2RBM0x2bDZRendtMmFhb0QvNlZRUWpCTHpJYlhE?=
 =?utf-8?B?b2UvcjlHOXdlR1NSeFREcWMzMXVzZ2dMTExpNnFuNVFBeDZsRHhBc2o2QXlT?=
 =?utf-8?B?S09MUEpXUm1WeVp1N0J1TlAwaWxjVk53MHpJMEhEL1dJZTJHODJ4OWJOWERB?=
 =?utf-8?B?TEpXRUl3UWpqMFgwOTdBUExMdGRjenFMNEcrSG9aNGZiTEtBUWtNbzlocDl2?=
 =?utf-8?B?d2xMeSthMitCbWdYaHRRUTZNY1A1dzkyTGFoZVJ5RjJMNTdQS2tFa0V5OUs4?=
 =?utf-8?B?Y3dJSjFEalhtMWxWbk9XUFBRNXdTRXVYZUlCQ1RIL2REak1HQklnKzRSVDM2?=
 =?utf-8?B?S0pJckxqazVXd0hFZmZYZkg2aVhueEV0NmtKZ1N5RlV3d2Rrd0JDRHJEb0dj?=
 =?utf-8?B?OGVXMFNtMTFWK3JaY3NndE5FMGpqcVZFR3diVUhoWlg0UjB4NlduYnJWeElC?=
 =?utf-8?Q?ccjE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZxUDhYeWJ5RWlWRWRHYVJrc0xGYm5XRGE1T3BrSGtRcEZaU2xxSVJ1MS9p?=
 =?utf-8?B?WHFhV3hhM1hnb0Y0bDgrQnM2SWM0bGM1OHhPWC9FOVJGMi90M3YzbDZsM2g5?=
 =?utf-8?B?dlVmVXVlcVR2SUJoOGZ4d21JME5GNHZEOVVFQzZtWUViYStLcld6K3lOUFZB?=
 =?utf-8?B?T2YxVDZkT1BQMzNtNENFSjd1enVVZEtVamMwK2xtTjhHZFE2UVdFVXlHY2ta?=
 =?utf-8?B?R0lWbVo1Nmh5dlJFR1NvdDkrL2VoVlFoQTIzN1U0Q1BaM2toWWJtVkc3ZE0w?=
 =?utf-8?B?dXVQc0hDOWlmUEpCdzFTTC9UbWN3V2FnWlNabTRQa21Rb2JYMitCTFJrNUJB?=
 =?utf-8?B?UEthRWM4bmVpa3pxMlZidUVneDY0SGNMOU8rTGJ3czdQWjNrOXNEYUx3LzNW?=
 =?utf-8?B?TDBHYkRaMTRhL3NDZVFlMjE1S2FZM3ROeDVHb01WM3FYd0trYTcrS0RpWmtR?=
 =?utf-8?B?RXRMVlVJazg3dnV3R3dNd1llNXpPVVhGMytDbUEzYkpIRVlJa2JVQ1lVQ1NY?=
 =?utf-8?B?K1YvVUVGNS80NW1oN0lnMGtuSlZpQjgzaXQ1T3dzMG5vRHZRWTVWTloxbzRt?=
 =?utf-8?B?L0dUWTFCWEprTEw0UGhOdTg2QkhnK0ZYMHlmNWVYRmtGeFdrMk0xY2xNR0NC?=
 =?utf-8?B?NC9HZHB1MFphL3owWE1OMnFYTmdVdFFVdy83YWFtSy9CY2xBbnpKb290OXFq?=
 =?utf-8?B?c1liWWxKSzdmUUYwNHlyUHRRV2NMa3BIbmV0ZGVqU2Q4cy9qS2orT2xiaUtm?=
 =?utf-8?B?aG5FblB3c1g1aE9BKzJSQVhMakwzcnJlTWdNeVRrTUV1UGVYVmZXVndGUzJO?=
 =?utf-8?B?WmxPZmFXbHdZdXJaSnp6azg5amhxTlBEN1V0dm00cEFGK2c3c0Q5NjhYbnJm?=
 =?utf-8?B?VXJiNkJ0UkFTMlhQQnJ2RlUrQTV3dnJVWkVwYUhETkxkQXMweHY4RVpKc2Va?=
 =?utf-8?B?VjVpR3AzbXNjOWdMS3FwWExUeUtjZGNUcmt5MC9GV0p6bW5CaW1IUWF3WlFO?=
 =?utf-8?B?U3hyYXJRY3lycU9NUmZURHo1c1VkTTZSeXJGaXhQVElZY0FFN2FQRHYvN05X?=
 =?utf-8?B?RG93cjJGMHpyRCttcksvZTg3RHlVcDlTVk1OdGpiV2EvOWw1QnNxRlBVeDFO?=
 =?utf-8?B?SkVldkc3R2x1M2dSL3ZNeWN4TDd3WG4xOU9EdXR5c0MzbHlWVlR4NkpHOWVa?=
 =?utf-8?B?VjB2NEllMWt6VkhvTHl4TTk1bVd0R0FHclFZT1hoT3FIOUIxL3dUNGwvMnJ5?=
 =?utf-8?B?RjFDSmh3S1o5RnJVdHJub2lkM0F0emc3ZEhBT0o4Rm9WaUFKbHE4aVV6Mnhu?=
 =?utf-8?B?VHJhTVhzL0FKY2dXcC8zYmJKVHdhR1JJdUFZTURxd1hlN1VnTzdRSEoyeWtu?=
 =?utf-8?B?TENuUmp0ZXkvRGFtNkloZ3Q2THUram9VUzV6Z1JLMW1oNmZ1UUErTHNNbGYv?=
 =?utf-8?B?Ulp3SzVKaEJjZEdkcGFEK005RGQ4cW1iRlVlSFBuckF3NHA1V3NRYWNZbHlP?=
 =?utf-8?B?d0JLM1ZZelVGUmpXMnA5Zy9ic0RCM2tQMmdwM1BtOFNnUG1CTlFsSjl3dnhq?=
 =?utf-8?B?V2lIOHMvWFdXUnVkYTdIdEVjWXlOdTg5NFpnejVOaG5oN2R5V2tIbEk3VVB6?=
 =?utf-8?B?MjAwdjJuTm9EdG5YY1FjWHpsSEo3TXArSEZLVjJlMG1qSTJIeUs2bVpRaVJX?=
 =?utf-8?B?STAvbFNmMndheE5USmQzWHFOanUrMlVyeDR5S2Q2WG81RG42MzFaY2RmRHhX?=
 =?utf-8?B?MFNvd3hUMUhxUkdXYmt6dmtGZC8xYXBBYmZIQnNPNSt3c21SeDJkWFdlSGhR?=
 =?utf-8?B?RCtpcjgxVVgxY0FVSjNWK0wxaHNQdlF1TlY5VXE3QWp0OExlbXNLNW50eWdV?=
 =?utf-8?B?T2FwanAwZ3BIUU5rbWNJUnZZeGZVMjFNN3NzOHhEM3huTXNGSXpwK1lBSG1N?=
 =?utf-8?B?eG9zbnRMYjRISTBSa1MxQXlxU2VVQXk2RGRGaXNwNXMwQ3RyeFVPZ0FLYU4x?=
 =?utf-8?B?SStrZTUxRm0rQXc2QXRkYW9vNzI1SG1kc2xWV0xFelpvakZOSTJQRnNSUk1h?=
 =?utf-8?B?UCs3V04rbXpvalE1MndJTUJ2WkdmL2M1MnJNT3k2NWFPd1hIcXdMRVNzUlFr?=
 =?utf-8?B?Z1VLcklYZlBjRlk4bXgvTGN6d1k0VC9PUjIyVEJBMnRyOUIrU0VYQ3RHVTh6?=
 =?utf-8?B?WjVIdjFKUkl4cHlwWGRaenpMYllGUXRVZ21zbU1JaCtVN2U3UFd0blJ2ZGZW?=
 =?utf-8?B?UTNMcGMrWk1SOFBaTDM4dHlUcmJiVlJjRmhKWlRObXFMbzR5UDN1TzhrTlUy?=
 =?utf-8?B?OWh5UmJwaTBrcXRIRkY3L2h0eVQzbmN6cWFIM0k2c0YyN3VrRVVnZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9efd26-d1d7-4c8c-afdd-08de638d06f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 01:30:49.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MeXsiBbfnPDz5uU6OXYst4Gd4xGSUTKzZCb13mHMXxV6kqAKQjnPBqE+A5N+RvlWLheqcKMtCRY7IXB+naYCow5foTREED3QHzcdGaCDZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-256504-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 102B1E071B
X-Rspamd-Action: no action



On 2/2/2026 2:58 AM, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> The driver missed to clear ring->tx_spare to NULL when
> fail to initialize tx spare buffer. And it will try to
> free the tx spare buffer in hns3_fini_ring() if tx_spare
> is not NULL. So it may cause double free issue.
> 
> Fixes: 907676b130711 ("net: hns3: use tx bounce buffer for small packets")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 7a9573dcab74..e879b04e21b0 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -1048,13 +1048,13 @@ static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
>   	int order;
>   
>   	if (!alloc_size)
> -		return;
> +		goto not_init;
>   
>   	order = get_order(alloc_size);
>   	if (order > MAX_PAGE_ORDER) {
>   		if (net_ratelimit())
>   			dev_warn(ring_to_dev(ring), "failed to allocate tx spare buffer, exceed to max order\n");
> -		return;
> +		goto not_init;
>   	}
>   
>   	tx_spare = devm_kzalloc(ring_to_dev(ring), sizeof(*tx_spare),
> @@ -1092,6 +1092,13 @@ static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
>   	devm_kfree(ring_to_dev(ring), tx_spare);


>   devm_kzalloc_error:
>   	ring->tqp->handle->kinfo.tx_spare_buf_size = 0;
> +not_init:
> +	/* When driver init or reset_init, the ring->tx_spare is always NULL;
> +	 * but when called from hns3_set_ringparam, it's usually not NULL, and
> +	 * will be restored if hns3_init_all_ring() failed. So it's safe to set
> +	 * ring->tx_spare to NULL here.
> +	 */
> +	ring->tx_spare = NULL;

This feels weird. If it was already NULL there's no reason to write a 
NULL to it. And if it isn't NULL, we should have released and 
overwritten it previously by whatever caller was going to free it, 
otherwise you'd just have a different kind of memory leak...

It looks like the only places that call devm_kfree on the tx_spare is 
hns3_fini_ring. It sets the value to NULL after freeing it. I am not 
following how it can ever be non-NULL where setting this to NULL and 
overwriting it would not lead to a memory leak (aside from the fact that 
this is devm memory and will be released on removing the device)

Is it because the ring memory isn't zero-initialized?? But that wouldn't 
be a double-free that would be a freeing a bad address...

Hmm. You create a copy of the ring parameters in hns3_set_ringparam. 
Then if that fails, you copy things back. Otherwise you release the 
tmp_rings... but the new rings didn't get cleared memory.. So the issue 
is that your ring structures effectively have garbage memory in them 
when initialized in set_ringparam.

You can't just check the old tx_spare and release it here because doing 
so would corrupt the memory pointed by the temporary copy made when 
changing ring paramters (as it would no longer be valid), and you can't 
assume it was zero initialized because your new rings were built in 
place on top of the old ring structures.

Ok. The fix makes sense but it does take a bit to understand why. You 
effectively have to treat the memory in tx_spare as "uninitialized garbage".

Other solutions would require more significant refactoring. You could 
memset or otherwise zero out the ring array structures entirely when 
allocating new rings in hns3_init_all_ring() for example. Not sure that 
is any easier to follow, and its not my driver so:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>   }
>   
>   /* Use hns3_tx_spare_space() to make sure there is enough buffer


