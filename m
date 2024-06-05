Return-Path: <netdev+bounces-100951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C28FCA38
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FBC1C24F56
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B5A192B72;
	Wed,  5 Jun 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEUJHUeA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593A17C79;
	Wed,  5 Jun 2024 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586306; cv=fail; b=ecZTz8SGrC4kKH4F2UqrZwNiUc3Yjg2uwHeuYOfuXXe6uEK+7UB4PElnO+vUTpgEfceHWcORZK7Ij4K7AbBCMkMTvYXs8yzb8qzZmehPrDXQm1mFKsqjLVMevc0BbDmkV5v/jmWigYkJKhmFAI59yLZoZNCTRbfY6OujpJSMvb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586306; c=relaxed/simple;
	bh=WBTqr+PDaLCTC6vXwzTpedXR0Bu5eSqioySrhVmn0R4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dIIbi1gZqRE/7JMG0W94sBL12GIWk9wdNrz7HsKleyx0RSdIYoaEUz6EdQfILEEEZIUA/sNWsFd44IsFZSx+sZqmTHjab4ZTMcOPNJ/BN1h/kfWTrTgVvmcKFV5cXQozb9Mo2t4HdY7vDeIDzVJ4BwHPKzZxU3IWVfP6gy/D128=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEUJHUeA; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586305; x=1749122305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WBTqr+PDaLCTC6vXwzTpedXR0Bu5eSqioySrhVmn0R4=;
  b=BEUJHUeAxRdP2Rgk22ZQolsIaQgOYCjg1Ii8WBVHVT6iZPk3A+9ALQDD
   rQ8Bu6x/0gZABH28Wnv2rXL9zD+fBxbYrkZfMsNxPMOMefohQwHuoU/uU
   qeWZ6M+BdFvt1zCx5buhzaLJ8joIQhZ10juThuR/BW7YQCr67+nXjOe2B
   VDiCt3DCqSjyOeoNcu+WjBqKFw60KQ/v3IHAptUeYqq7UaW4FZNCABDhV
   skurcSUOEsXnTvn449u6+GvL7rYqfOZxenZxMeGCZgQs4tVJcaAtHV6SO
   gevhTmI56L2m+kZ5E+GGpnKuOwjDEhXWO5dJZ0TnJW/QbWq/wbJGvO+hW
   Q==;
X-CSE-ConnectionGUID: i9e5tqtIQjafMTF2gWRkTA==
X-CSE-MsgGUID: qFg/OZk1TreD7FM8EYRVEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17976788"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="17976788"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:18:24 -0700
X-CSE-ConnectionGUID: 3FRkE3BgSTGwE8s9ya9JDg==
X-CSE-MsgGUID: honWU/KMQgiFcHLCDeGe1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37499593"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 04:18:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 04:18:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 04:18:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 04:18:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 04:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av13bnTL7geYYTUYMRvFsiox5VtKMXbXLpWWeiMgAdz+7eClX9KE3tnpPuBZCoRFIKcRo5mUCFWwG5rQL5BVht43CppgnfqTfg/WEyWtmj0JUnI2VKGZiEHNR+4qfpV5/neLUZD5rBDAneWTl5Nuge7zx3zFLccdC4NMBB4x8qqIWl0L9JV8j18ZHEfvj1VRCCWXATrpPT6T55mHVtssvNNAlrl6hL667eKryCWFuCjLErySc1vjpVQid8AvCmztewREOyY6So5Dg7OJl/LtdUKAbhQT12EpaxZfaiFvcH0EvE/MH6feBu89Pn739y/0M0bZ2TfFEI4iG1bci0NuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7gRxzFcD047ip8I18d/NbDH2Eh5+HVjFJ0h3nlZRNQ=;
 b=DU7K/mByEVzkldzHmplEsNlerSBE9N4E5tsRlDUiMv3Z/ZlA1O5KHDydGzsuBxvfBw2KdVYl2oHhcvJMWeD8fL/+1TIJzKO0Z80iEKE3/Ug8zhtTG3V41uvEdHTU/bH8Y1Bo6N26Is0r4GFlN+f7ZAZJtNmC9gLy94p7jAToLYtTHjdtubb669jGKnlJgoqMX+0P/TVMa3xhJszwHAE6WMwEdMXboMXMahL8DDS9ujxnmpiIF1qCyZSkxZjdFs+ZRjTwnxGzG5t6mguZeUHlFd/aNY0iGRG9Y91B43riobDJj0x4zBy902Sug+xNyeAH6V7pitt/5SxzsDkhlCDNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 5 Jun
 2024 11:18:21 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:18:21 +0000
Message-ID: <560d5efc-11fd-4ce6-a1e9-c4657e61d9b9@intel.com>
Date: Wed, 5 Jun 2024 13:18:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 1/3] net: lan743x: disable WOL upon resume to
 restore full data path operation
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
References: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
 <20240605101611.18791-2-Raju.Lakkaraju@microchip.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240605101611.18791-2-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: e0edc78c-bf46-4ea2-6bec-08dc85513504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmVIOElHVUhvaEt2eVlsK0ZtalZudDRRdjJIRHdHOXB2Zm5NczNyU0hPUk01?=
 =?utf-8?B?YmpYcnh1Wi80a1N4OEJyL0FkWk1YNS90QXFtSHNkR2k0YTdLY1E1V2JJNXkv?=
 =?utf-8?B?REViR1Z0MTFDUGRPSkNKVXpvTXExcVVaaXFWVjM3ZUhsS3Jid3hGaXhNUmts?=
 =?utf-8?B?c2kvTFo3OVZ1c002RytETEt6amZkYTJzZ0ZMdEM5cFNPZWVzVGpZZ3Q2N1ZV?=
 =?utf-8?B?UWozYzR2dmExVVV1ZStKcC9QMlFzUHo3MDVyaW1CUGpVRFFVNE5Ndk1udzhw?=
 =?utf-8?B?R2ZuQjBlcCtNajJUVHdpTGFlbU82OTBUWEprb01xL0xXSXllcFRmR2txUG4x?=
 =?utf-8?B?S2ZHd3Z1NUlScitNMVVuNGtlY3FHcng1NEFxaGdFa0Z3MWVRQi9qem1NSEhE?=
 =?utf-8?B?NW81YTJ1UlFUYmNmdyt2eVBkbVUrTmFTVTVMNUhsV2h3S0NmQWpacENIMzBo?=
 =?utf-8?B?UlBrYzQ5T1JVL2Z0N1dXdTUzNi9kSCtVY25aMlV5bjg1YlI0N25reXVMYnlz?=
 =?utf-8?B?c040UUowaE9vWGNHcFhibmFscHd6UXVNWGQxRlB0M2kzeU5FN3JKM0pFeTVO?=
 =?utf-8?B?bXV3cDMxaHpnWm42ajJodkgvWU41ckM4bDRwaTl1b1g4czUwUU9BQndHUS9r?=
 =?utf-8?B?ZVpGVDF1VW1jVUkvS0YwcTlIUzBCdkdLaU9GcTNKZ281SWdUc20yTkxwYTYw?=
 =?utf-8?B?LzNnUVpNdXg1ZnpqdlFwNko0aUNZbCt4cTdqektOcVAwNG81NE82anhoT2ds?=
 =?utf-8?B?dmEyYWphdURpRThDT3M0eDZ5Z0pWS1VUZE9QR00zREYraDIzQlBtN2o5QzdH?=
 =?utf-8?B?SVNBNms0UFFrVXRydGs1QzgvUG4zRDRpamJnTnA3UzV4cFVFaDhlL1J0SDVt?=
 =?utf-8?B?cmhRTThrRU50N3hzUEFTMmNkQjFpV0lHa2pHckF1SVplZzBIODluU0ZzT3oy?=
 =?utf-8?B?cmRGdkdER0s5S3BpTGF3YU1wNnF5Sk9pZHNyV2pGR0FpRloxb3dTRHJaSlEx?=
 =?utf-8?B?cmtEY005RWFEa3V1d1NQV21kSTZWWjBsdHlxZWU4VWNxT2Nua29yam5zbmd3?=
 =?utf-8?B?cUhlSWEzd1I2d21USGJkWVptMVQzUXFMWnNweEU5c3U5THgrWFhTVmQvYm1V?=
 =?utf-8?B?TXhxd0FvaWY5NFpISERPSURGMTdWTSt5N0VKUzhZdGpvOVN6djZ6K3hSRVd4?=
 =?utf-8?B?ME0vYVEwK1JnYlY2THFnN3dmbmZpK3NjRHNDeGdoV2JFMHBEUmFNekw4c0ds?=
 =?utf-8?B?YWFtUGhWQ3ZmNnh6eWlaWkxVSWFoWWp0ZmxxenVFRkNoZVJMVmNaV1NzMXN5?=
 =?utf-8?B?K2dxMXUwbVNoNkZCMjAycnB1WFVBd1ZYaWJkSmIwbTdWUGthNUVma1J3SnVH?=
 =?utf-8?B?cGg3QzFJa3V5enAzNzF2U1JZN0kxZkNTc2dpWlR1d3JRUkVKZ3BEczc5TS9x?=
 =?utf-8?B?M244ZjFrbDdDOHowYnU5MFRtN2JsOVBWR1BLcWQvLzBkNHZ6MmFRZGVRMGlx?=
 =?utf-8?B?aU9EUDFSR0lzZDVzTVJZVVBXbm5Bd2x2cnRENXpMT0MxUExycE5VTzVsUjJp?=
 =?utf-8?B?T1dQcjNWWk9WNXFFZDZjbTY5VkxESkxLSjlWUTlMbHpqWHNsUlFRRFUrREdN?=
 =?utf-8?B?Z0s1NUdyeCtNazJ1NWg2aFErUUUyanVCa1pBbjhOUlYxV1NvbSs0MUFvNkRH?=
 =?utf-8?B?L1BmR3dKMDc1OHp5SWdoOGZueVVHZVE0dnBRZmxZYUZzYjJaamZOYUNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTVzcXZFTm83M1ZWRG0xc2Y3MGJ3L3QxWTJtQ01FSDlQQXBxbS9rVWwrdWxk?=
 =?utf-8?B?WFR4K1JHNWNScUpvTS84VDBlSmprTjMyK01ISEFkWlVNVlVkczhPSGZTdXlC?=
 =?utf-8?B?aDhvK3NqU0FvT0tXR2pSeEZPaUlKTHNsM1BacElJREI0dW4waEs4ZmdlUUNP?=
 =?utf-8?B?RXBJS0FSUEdEV25PTzZCUkRUUVlwMkRlTkMyWGdEQ1N5QmhLbk1tZXFIeDRE?=
 =?utf-8?B?dlkzb2RnT1plaFpONlhNSGQ3QUMwbDV3KzZGdyswSU12Q0ViOEJoWVBNaWNL?=
 =?utf-8?B?VnF1TDNCS2o3bW14Sm1VUUpKcHlWMHlwZG5GSXY1OG1Sak9Scnp5QnBKcDEv?=
 =?utf-8?B?YVlnVFBncFZickpBQ2VVem9yUU85VEViSjRJc2ZRN3BRTlBFQjNsNDlQYTRt?=
 =?utf-8?B?ei9ndTNXUmd6akU5L0FLTjkybUhFc3FoRzlRMmRDSTJ5WngyYk8reDI3YVp0?=
 =?utf-8?B?THU2V2tFaU85L0Yxa3h0Zm54dUNua1pZSmR0SXhtKy85NG05SEtnOVV3cHdX?=
 =?utf-8?B?N0Y3UFd3WnlSenR0NExWOWNZaFlTUXQwRGJqaXFuc0prSjF6VHhHcDR2c0N6?=
 =?utf-8?B?alFTZkxXUTVQRkg5eWtCUW9naktIK2VGMU1xaFRVd24vTUFqeDhhRFg5Njgw?=
 =?utf-8?B?ODZjcDhRaHE1elVxaml3T0RLOTNSZkY0NCszaXNPODd0cGp6d21Ub3V3UCtn?=
 =?utf-8?B?b3l5YTlYMTFtOTN1ODF6QVVYVkJOb0lyWWVQNjBwL3g2N3lmWUhHaVhoMzYz?=
 =?utf-8?B?Y2oxTHcvSm9TSEpQQW9MbFZibjNVbUpkaG5pUnhjSEMzS1AxODE3V25wYU43?=
 =?utf-8?B?Vks4eDQrNWhId2NxbStKMktRamUrTkx6Z2tOTzFqaTZyVW5ONnVFY2VIdmN2?=
 =?utf-8?B?Ujcwc1dsM044Uld4RGFJaGQ2ZThjYlR2TGpueUtXYnRqdWp3Qnc3MkM3T0NM?=
 =?utf-8?B?VFcyMXp0TzNUUzRWeWVQVmNLdzh4aG9IMEorMDFZUVhLUUF6OEEwSmZoUWxH?=
 =?utf-8?B?M2hva09ZaDQwQ3ZnSUhEWUJ0MGdHRXhsMmJoSnR0RUxCZzlkUWxIS0d5STNX?=
 =?utf-8?B?bmhDK0JMM0x4dTh4SjFlUk9XazZqNFozMENQSVhZa1JTSGwrc3pTeDVBNmxt?=
 =?utf-8?B?VWdrRE1QTmFrN3prSUtGWkF0WVBWZlRYQU5PeXpvUnpTTHR0eDQwa2JzdEZK?=
 =?utf-8?B?bHhaNHcycnZuYU1kMFN1bDVIWmh4cmtyRlc2c0dXS0xRNW5lVmQzSVBqOE9n?=
 =?utf-8?B?TFdZMXFPeFFWTVhWcjdoZ2pTYW8rYzdadVRYbnA4Y0RST3E0Nk9jU3V4UlJN?=
 =?utf-8?B?QlNzM3d3MzB6VUFEVWV3RHpqWlRKbTdjUmtFcEFxU011Zk5ETTZGT25CejNM?=
 =?utf-8?B?OFJBSGZFTVpBZEUxU2JickswK1VTemd3eHJ4V0lqR3RPYjNpMzdxWlk0cWtX?=
 =?utf-8?B?OW1raGtDdDNyaThBbVNXcGpnMGJDYy9xQ2hocFVHSzZtUmlDRWxrc0FJVkd2?=
 =?utf-8?B?WTZIbDJkQVpaQmlFODF3eEhSNWUrcVBCOVVxcWRpOWxMcUR2VXNpZDJhaTJT?=
 =?utf-8?B?L1BLQVp0MlhWRGxQVDNNYmV4M2FtSkllV0VyU2JsQXMvYXByamY2aDhsUnVt?=
 =?utf-8?B?Wmwwb1NKYkdGZmZvdVRCcFZqbHNnd251RmtUY2lJd1F5UWxOeWU4ZFUrOTR1?=
 =?utf-8?B?NVlNZnl5TG1hMGtLemNpTVY0NkUrYmhSN3BFTzEwR2dZWnR0T2JrTnduV0t6?=
 =?utf-8?B?K2tSbmM3YzA3QUE3Vk91VEdnc01veGVERllSS1JDUDIvaDNJZGlINHBLSjZ6?=
 =?utf-8?B?Nll4bjR1am4zNXVpNUsvam1Kdkt2L1BmSXV6YnB1Wk5tTE5JTFF3K3B0Qkxj?=
 =?utf-8?B?eWgyTmxTWDRpdVVLSFRSNW80aWdrK2EvOUFvTGdsQm1DZmtiVXlDU2pucncv?=
 =?utf-8?B?cmxRRi9hdHNTWFVvUE51cVB1RnA0UGZmajhDbk0xbHM4UlBrTW1KQnBxc3pJ?=
 =?utf-8?B?WnQrNlRJV3ZCU3FSaU0rWG5Od3prNi9JVjBNWkt5Tko5bWlRaWpQZ0dlSDNn?=
 =?utf-8?B?dWJCTkxsazNSekhaVndoSUNsZzdSTGFIc21Vd0FRVWxTalFWa1dkUE1Gc2lu?=
 =?utf-8?B?Mlc5TzRDOFMxUHNjS1JESDdWUUNVRFA2WFNIRXo0bUhPTnNhOHFxckJ5aHB5?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0edc78c-bf46-4ea2-6bec-08dc85513504
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 11:18:21.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sO3mzZVedeQIQpElE68eWUCZLvhQcplq2rEBo0A3QYrwiLpmOyYq6KJem+LYnXTkuKVBXd3hsbAFKNAGevJly+u16A8oEs3y6rVnLD525c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
X-OriginatorOrg: intel.com



On 05.06.2024 12:16, Raju Lakkaraju wrote:
> When Wake-on-LAN (WoL) is active and the system is in suspend mode, triggering
> a system event can wake the system from sleep, which may block the data path.
> To restore normal data path functionality after waking, disable all wake-up
> events. Furthermore, clear all Write 1 to Clear (W1C) status bits by writing
> 1's to them.
> 
> Fixes: 4d94282afd95 ("lan743x: Add power management support")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> Change List:
> ------------
> V2 -> V3:
>   - No change
> V1 -> V2:
>   - Repost - No change
> V0 -> V1:
>   - Variable "data" change from "int" to "unsigned int"
> 
>  drivers/net/ethernet/microchip/lan743x_main.c | 30 ++++++++++++++++---
>  drivers/net/ethernet/microchip/lan743x_main.h | 24 +++++++++++++++
>  2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 6be8a43c908a..6a40b961fafb 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3575,7 +3575,7 @@ static void lan743x_pm_set_wol(struct lan743x_adapter *adapter)
>  
>  	/* clear wake settings */
>  	pmtctl = lan743x_csr_read(adapter, PMT_CTL);
> -	pmtctl |= PMT_CTL_WUPS_MASK_;
> +	pmtctl |= PMT_CTL_WUPS_MASK_ | PMT_CTL_RES_CLR_WKP_MASK_;
>  	pmtctl &= ~(PMT_CTL_GPIO_WAKEUP_EN_ | PMT_CTL_EEE_WAKEUP_EN_ |
>  		PMT_CTL_WOL_EN_ | PMT_CTL_MAC_D3_RX_CLK_OVR_ |
>  		PMT_CTL_RX_FCT_RFE_D3_CLK_OVR_ | PMT_CTL_ETH_PHY_WAKE_EN_);
> @@ -3710,6 +3710,7 @@ static int lan743x_pm_resume(struct device *dev)
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	u32 data;
>  	int ret;
>  
>  	pci_set_power_state(pdev, PCI_D0);
> @@ -3728,6 +3729,30 @@ static int lan743x_pm_resume(struct device *dev)
>  		return ret;
>  	}
>  
> +	ret = lan743x_csr_read(adapter, MAC_WK_SRC);
> +	netif_info(adapter, drv, adapter->netdev,
> +		   "Wakeup source : 0x%08X\n", ret);
> +
> +	/* Clear the wol configuration and status bits. Note that
> +	 * the status bits are "Write One to Clear (W1C)"
> +	 */
> +	data = MAC_WUCSR_EEE_TX_WAKE_ | MAC_WUCSR_EEE_RX_WAKE_ |
> +	       MAC_WUCSR_RFE_WAKE_FR_ | MAC_WUCSR_PFDA_FR_ | MAC_WUCSR_WUFR_ |
> +	       MAC_WUCSR_MPR_ | MAC_WUCSR_BCAST_FR_;
> +	lan743x_csr_write(adapter, MAC_WUCSR, data);
> +
> +	data = MAC_WUCSR2_NS_RCD_ | MAC_WUCSR2_ARP_RCD_ |
> +	       MAC_WUCSR2_IPV6_TCPSYN_RCD_ | MAC_WUCSR2_IPV4_TCPSYN_RCD_;
> +	lan743x_csr_write(adapter, MAC_WUCSR2, data);
> +
> +	data = MAC_WK_SRC_ETH_PHY_WK_ | MAC_WK_SRC_IPV6_TCPSYN_RCD_WK_ |
> +	       MAC_WK_SRC_IPV4_TCPSYN_RCD_WK_ | MAC_WK_SRC_EEE_TX_WK_ |
> +	       MAC_WK_SRC_EEE_RX_WK_ | MAC_WK_SRC_RFE_FR_WK_ |
> +	       MAC_WK_SRC_PFDA_FR_WK_ | MAC_WK_SRC_MP_FR_WK_ |
> +	       MAC_WK_SRC_BCAST_FR_WK_ | MAC_WK_SRC_WU_FR_WK_ |
> +	       MAC_WK_SRC_WK_FR_SAVED_;
> +	lan743x_csr_write(adapter, MAC_WK_SRC, data);
> +
>  	/* open netdev when netdev is at running state while resume.
>  	 * For instance, it is true when system wakesup after pm-suspend
>  	 * However, it is false when system wakes up after suspend GUI menu
> @@ -3736,9 +3761,6 @@ static int lan743x_pm_resume(struct device *dev)
>  		lan743x_netdev_open(netdev);
>  
>  	netif_device_attach(netdev);
> -	ret = lan743x_csr_read(adapter, MAC_WK_SRC);
> -	netif_info(adapter, drv, adapter->netdev,
> -		   "Wakeup source : 0x%08X\n", ret);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
> index 645bc048e52e..fac0f33d10b2 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -61,6 +61,7 @@
>  #define PMT_CTL_RX_FCT_RFE_D3_CLK_OVR_		BIT(18)
>  #define PMT_CTL_GPIO_WAKEUP_EN_			BIT(15)
>  #define PMT_CTL_EEE_WAKEUP_EN_			BIT(13)
> +#define PMT_CTL_RES_CLR_WKP_MASK_		GENMASK(9, 8)
>  #define PMT_CTL_READY_				BIT(7)
>  #define PMT_CTL_ETH_PHY_RST_			BIT(4)
>  #define PMT_CTL_WOL_EN_				BIT(3)
> @@ -227,12 +228,31 @@
>  #define MAC_WUCSR				(0x140)
>  #define MAC_MP_SO_EN_				BIT(21)
>  #define MAC_WUCSR_RFE_WAKE_EN_			BIT(14)
> +#define MAC_WUCSR_EEE_TX_WAKE_			BIT(13)
> +#define MAC_WUCSR_EEE_RX_WAKE_			BIT(11)
> +#define MAC_WUCSR_RFE_WAKE_FR_			BIT(9)
> +#define MAC_WUCSR_PFDA_FR_			BIT(7)
> +#define MAC_WUCSR_WUFR_				BIT(6)
> +#define MAC_WUCSR_MPR_				BIT(5)
> +#define MAC_WUCSR_BCAST_FR_			BIT(4)
>  #define MAC_WUCSR_PFDA_EN_			BIT(3)
>  #define MAC_WUCSR_WAKE_EN_			BIT(2)
>  #define MAC_WUCSR_MPEN_				BIT(1)
>  #define MAC_WUCSR_BCST_EN_			BIT(0)
>  
>  #define MAC_WK_SRC				(0x144)
> +#define MAC_WK_SRC_ETH_PHY_WK_			BIT(17)
> +#define MAC_WK_SRC_IPV6_TCPSYN_RCD_WK_		BIT(16)
> +#define MAC_WK_SRC_IPV4_TCPSYN_RCD_WK_		BIT(15)
> +#define MAC_WK_SRC_EEE_TX_WK_			BIT(14)
> +#define MAC_WK_SRC_EEE_RX_WK_			BIT(13)
> +#define MAC_WK_SRC_RFE_FR_WK_			BIT(12)
> +#define MAC_WK_SRC_PFDA_FR_WK_			BIT(11)
> +#define MAC_WK_SRC_MP_FR_WK_			BIT(10)
> +#define MAC_WK_SRC_BCAST_FR_WK_			BIT(9)
> +#define MAC_WK_SRC_WU_FR_WK_			BIT(8)
> +#define MAC_WK_SRC_WK_FR_SAVED_			BIT(7)
> +
>  #define MAC_MP_SO_HI				(0x148)
>  #define MAC_MP_SO_LO				(0x14C)
>  
> @@ -295,6 +315,10 @@
>  #define RFE_INDX(index)			(0x580 + (index << 2))
>  
>  #define MAC_WUCSR2			(0x600)
> +#define MAC_WUCSR2_NS_RCD_		BIT(7)
> +#define MAC_WUCSR2_ARP_RCD_		BIT(6)
> +#define MAC_WUCSR2_IPV6_TCPSYN_RCD_	BIT(5)
> +#define MAC_WUCSR2_IPV4_TCPSYN_RCD_	BIT(4)
>  
>  #define SGMII_ACC			(0x720)
>  #define SGMII_ACC_SGMII_BZY_		BIT(31)

