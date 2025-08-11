Return-Path: <netdev+bounces-212619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651BB21784
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A9D190539E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA982D877D;
	Mon, 11 Aug 2025 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Act4bI1o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13474221F24
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948305; cv=fail; b=up8N53OOJKJfBIQSm1rx0vQ+lFbpGNGPW4OIRHsgtBE/TMH/tD3Z+9XFpaVDoEDIBB8bArjFDkDfcVukwIV9QBCF4gtk1c0E/KPllohc1ctkvymGMeD4L2bVcobgpIIBrkfQe5tpq6zBNqWhxZqNXH3QbkY0YklutSBJTtNLWUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948305; c=relaxed/simple;
	bh=U5mhgaGDtqU0vtBX0tq5L8sxxyWXz3OgmsJ5glfRKsM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TS+qXfpbVkDvNad31zpl6AUZdMVQ5dKki7iwVtKOYbLDvqR7YqbJEKKPvyDk3jj7UevboNfaIHGwJVxZe8fayr9qR97HWSxi07tK+XWYdoaPPZfmPMJ8TaLmX+kzdfaGtZo5CW+Zu4zFROw/O89+NRzwxsHoJGQFU3B5t5IvkJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Act4bI1o; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754948305; x=1786484305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U5mhgaGDtqU0vtBX0tq5L8sxxyWXz3OgmsJ5glfRKsM=;
  b=Act4bI1oUgvgYyBZenQ1LKoNYH+Crij4pVHsjpmf0Bpt57WvQ+DRbuEu
   O05OjwmIUY03vZ2uIHFILtD0AG8/ZvxyrFOQlrldLd3ypG2gZwX9gKwtL
   LOvGSm6aKCfWKUaLqgvfcZZs8gBp+5mGZw2UyljuYPHousqOEtoqmxjos
   8AVTa6Og4PU0Bq2cVBR5rsWqTQRMBVTuXQWQ08koaq+56CRX1/tVosyeL
   5tLw6RBMlbSJ6EU7ijMADM7MC04kSGOj0lgGKqZcrgtmE59TYyqhyWge6
   vCJf0AD3hLCA6ROeCZKFAOWoXfi5U+xHTmwqEyN8jbJlePL6rC/WQne56
   Q==;
X-CSE-ConnectionGUID: OsGOObMnSO2x5BhXV7jJLg==
X-CSE-MsgGUID: 0EiGL9PpQk6iU6eC6T65qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="79782857"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="79782857"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:36:39 -0700
X-CSE-ConnectionGUID: CUdv0vo9QVm92pXmBi5mrg==
X-CSE-MsgGUID: J3VxiQ17T1+DSoHVy7LAiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170464669"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:36:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:36:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 14:36:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.69)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F30vtaGn55LpZ/LdGz8sL0RDuXTyZn14fJpGyh7Au424wCWYRrv9gqErScPJvSr7IUbWcEYJDvJR6oF8so97oaRbIAVMmSKp/cs6/TlKjnQGrEJe1wMSfEJPRbMQvxQRJi8IIsYZYxqf8cRGSems8vnYMa5jx6FB/si7IaI/lr8i9+EnRrDoktENGi/FJhEiCrM4oCSFwT1uSsooQlUneykcDvsQ1dm8g990FPIOxX65ZFjmqkSkILpQIVv0g06OBc2yRnyNPUgwC6sEMsdnzoiK/XvW4Hrg90YwhiCghVEB4AsNZZDxyq4SoDCr5hp/HybH0LB9N9aOPHsW4IGU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaazqUfZylzgQNvWg7ep5Q1niulFo6T4Zh8j0aeo9n8=;
 b=kCtAUo2ZibD5sInk3XKd5O1n7kTkPKoiuvzv8uaElPhDHFbx3fdvq6lxA1l1jNpiqy93N+XL8qfQN9I9G0GZz7yCXimq2EWmTCz59NX0zJSFaWVLMtG9eb7/JvC6QV9LUNYrx+5ipfYZEu4/G3QIBXaam6tHOlCOaXYYLBmakdN44V8m2BECZjRxlO+TTxqKgCM2JTr4YToNVYMRjuZGLgqEPhedmHV/7LWuPoffeV6F1z2D+lt9tf4VD3v6r5vM5XWsGegs1hB3MgYQQGxx4FI2TSB9ikslyn1UedtbTxTNGNnoOW6iR4BhfkfDNSWDI7LX0qYnVRj21PhcXi8Oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:36:31 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 21:36:30 +0000
Message-ID: <14d36e48-251d-4dbf-aafe-57259003e064@intel.com>
Date: Mon, 11 Aug 2025 14:36:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
 negative overflow of budget in ixgbe_xmit_zc
To: Jason Xing <kerneljasonxing@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<larysa.zaremba@intel.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
 <CAL+tcoAAq9ccjUybzxoYbVG6i3Ev1C098aGKWvAvKMUeFyG3Tw@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CAL+tcoAAq9ccjUybzxoYbVG6i3Ev1C098aGKWvAvKMUeFyG3Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SN7PR11MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8a8e31-13af-43c2-6ac3-08ddd91f2247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2pvK2FMdWNXMkkyQ1NNaUZwSlRFZS9GbHgrQVlTdmw1VkpiVU5qZzBQS2V2?=
 =?utf-8?B?Q2ZzRlh1aVU3RFJlREd4VkJ5REJHK0ZkbHV6U3FTODZNWHlGRUJzWnBvQ1Ra?=
 =?utf-8?B?V0tEV3AveWs5bXY0SzlpWnd1cjhMeXBFMUhyS3FxT21pSGx1T01jNEd3bnZP?=
 =?utf-8?B?cld3emdHMm5ib1JSMFliWnJYenVjWEZYUDVFUWl1cWlhb01VWlFaMUFFS3Fo?=
 =?utf-8?B?aGZ4NDh0OWJ6WnAxbkV4blpzSUhBV2JpemlDUUd4U2N1VEk0VzA2VENZSXJy?=
 =?utf-8?B?VWxqN0Z2RDk5enNjZW1SY2dMYTBrVFNBUVhOU2R5bVZKMkkvWHI4QmZmZmtZ?=
 =?utf-8?B?NWl2M3IvNitYaHp1eGNXLzlKWktnanhnUjBTWnZnbC9tLzdFQmcxU0N2VkVO?=
 =?utf-8?B?L0pJVkFhNHdVbTRGUEo0dHJ1NTVHYjdzaW5JOXFRR0I1Z3dCS0JzUFZsbXpE?=
 =?utf-8?B?VDNFRlZvSTRCMyt0QXpzZkJyZ2FPN284dDBaVVRLSkpvMCtsVlQzZUgwNzRE?=
 =?utf-8?B?enduMFVjY1lGNUhhYkJVZ00vc0xZUVArWXRsM1JMWVJuZU45bmpHZmZIS25r?=
 =?utf-8?B?RjV5bG9XK0xWdXcwNnJIQkxnWFEyb2t4NlpzK2JOeWV3eVBxYXlvNktINlJU?=
 =?utf-8?B?NnNGeXY3WEdaN2RzVDA4ZWtoQjRWendxTTNDOEI2NFlpUklYTmc2WGlidk5T?=
 =?utf-8?B?OTJOMVN3LzNBc2wyeW5oSWpvaU1Jc0lXRXZ5ZGNpZE5ZbndJTExLZWRkNXdK?=
 =?utf-8?B?WVdnUndzc0lIWGxocjIxZXg0TUozaTZqQmk0TXVHYmxqbCtZYUdTeFp5UUpp?=
 =?utf-8?B?TzFZS2h5UTkzNkQ4NjJ2VUgyNHdaZDRYY2gvM052UDA5c04zM3BoV3hiUzdu?=
 =?utf-8?B?dDZCU0JiMi9sS2NRV0NRR0RLamwrWTc1TDR6M2tKdkF2SW5qMWV6WmowRWpv?=
 =?utf-8?B?VGRrM2NsWHVZaDE1ekVSMDEvYWUwV0NmY2FjdHBPTkVIZXpjK3crZGRza0xW?=
 =?utf-8?B?MlZrTWVUOGxQZFUvMjU1RFFDTit1T2FkUldjU0N4WkVUd0FqdmNUeWtPTzFj?=
 =?utf-8?B?RHVxdzJqR056ZSs1Mko5UnlqN3B2OXlEWHlubGZrOGRoUGJ6UHdyYlBKRTAw?=
 =?utf-8?B?a1FLRXQ5cW5kN2FZNW8vYzhPVmtuZ3UrUzZtNmpxL3hDUkdFaElrM01GcUVV?=
 =?utf-8?B?VW82T3ZvUzVwMkZRQ0VwUmNkS0dxK2xJenhSOTFZNUErL0FnbW1oNWtZQlFN?=
 =?utf-8?B?NGh5UHp6QzlpaUYxenMxY1krMFBGdjBHQkhhbHZZdlhUS2ZTMllrVTRGSERs?=
 =?utf-8?B?VHpCbEFkSlYxeXZqNTVyUDNid1RqQlNEOTF3M21nTWRoeTF6WTd1QVBTbysr?=
 =?utf-8?B?bTBuYno1RlF3Ukw5eFp5K2ZXZ1cyMTZMb0dnVGlZTzBoYnZuQjg4WFlKdlp4?=
 =?utf-8?B?S3ZwMWFONURuUVp4OXpGcHd4RGpPQkx5VE1zbEk2cU9melNDdGZvY3QrKzdT?=
 =?utf-8?B?bWN1MWF2VjUrSjlESEx2NDRJeE5lRW5manFVbGt4eEt2WmRWMERzTUFiM2VD?=
 =?utf-8?B?UHduaXRzbUtMTXVSWlFOeitFQ2ZPMTJMQXpLd2ZyVmFTZExleU1TRlh0dHh5?=
 =?utf-8?B?Wm5IODBQTEtFa05VK05MTWoyU2pmalBsOVhlTDFCUUg1c3BoTlNqT3UyUDNE?=
 =?utf-8?B?d0VZOFJiZ2N0VlJ1dzl6M1I2aFNMYjlGYjZja0pjeHdkODFxOUxWSDNOWHNG?=
 =?utf-8?B?N1QzQzhRV1FsWFN2bU9ua3l0U0tFdTM5ejgyYTF6d1g0SEtzT2l4b2tpSS9O?=
 =?utf-8?B?Q05rOUlDZFdDcnoxZHZoL3VoWS9iMUdUQmlHYk9ZMWF0UGJReE9tZW8zQ1h4?=
 =?utf-8?B?bHlySjcrY0RrWTFlT1QwdVp1d2JNUitiUUVUTGZIUkxkZWM5UmlZT05Ycys4?=
 =?utf-8?B?aEU4TVlCc0d1ZUpMZUVBMHRkRDVtc3BLZ3dLL2N3NWpXWXlQczV0SGdON05y?=
 =?utf-8?B?NVVEd3RNVnVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFpQisra3Bnbm5sL3FHYUtSYkE0THNtb1k1a0I1Uk1GVmM5SXFUcTllRFNH?=
 =?utf-8?B?b08rdnBTNXJwRTk1UTNBNTNId2pjRjJMamtIQjBTY1U4QllGYlRoUU9YRXVi?=
 =?utf-8?B?U0lnU0k5a0xSMVVGSEd3UmpBMTdUaVRtdnNPR2FDZFNpZ0Y5OVMyUkVOMW0v?=
 =?utf-8?B?MFRpRmZiNXBsTkZWT3RYN21Rb1lDOU1iT3NKSDBzam5vZHV4d2h5RDNmMVBz?=
 =?utf-8?B?MVFvbHdORTE5WlhxL1BHUkpkMm4rVWh4c3BYUm0vQjlYMThFVStLQTRCV2RD?=
 =?utf-8?B?VFE4VmNvZmJxY2xZMXFCRTJEdm9HMkpFUFBqbHpab1YyTXg2dHE4c3R4TzFo?=
 =?utf-8?B?TC9oKzZ3WjNkcGQ4YmtrMW8xc0NYMnd6bDFMaWdxNGRQRW16ckJvRklZOU9Z?=
 =?utf-8?B?bVYwak9ZQ2UyK2xadFNQWDVINkJVL3hkWUl2b3NPVkVudXB1L2JoTnJLc1Zi?=
 =?utf-8?B?dXk1b2NkMDNqeG1PY1dmR3lKbC9CaVB6REJwV2MxdFJhMGE1ZW5QSXFVd3hk?=
 =?utf-8?B?bGduUzBHUFluUFFkSEI2WllnUEZ3SjhYUGp1YzloU2RDR3RzL1o3a2hwVDFS?=
 =?utf-8?B?d2V4emRjbUJGVzlQSWM0VEdXREV1Z2J6S1BhazRHVE0xbEdKZkhXL2RJaFpN?=
 =?utf-8?B?clRGamJ3TS9Ndk9ONFlmTjU4MXd2dWJWWCtqdlVsY3JLUTRXdVJVZFFSNE9G?=
 =?utf-8?B?aElLb1EycGszdkx5TXh0R2poQUlGWEZ3MVFzMXJzaXVyR1kvc2p2MVNBU3k3?=
 =?utf-8?B?VTBwU255VjRKZURVekw4QWlMS2RBMkhNTVMxZXhUR21GYzVhTjdxRFdKUU1X?=
 =?utf-8?B?SGZ2bHVING1nTGgxV0xSL2lXN2JISDRJY3ZqWERBamkzb3VYT05IVVdCbTdi?=
 =?utf-8?B?d3BHUkpJOCtpUzBiS3p5QW5tL0NGVUV1aXlxbHViR3pTMXQ0WjhIbDBpbWhH?=
 =?utf-8?B?MkFzakJwMHlrenYwbGdzTCsydWNRWmVVK2Z0QzZmY2NHUC9IcXRIdnR1ZVd2?=
 =?utf-8?B?SEJiVmowelFRSzNkL1ZhUDh3TXhUVzJlMWFGdDZsNjBJRmp5NFdVcTVTU05T?=
 =?utf-8?B?cUhxL0tRZW1Yb1VSYTZuTnlBb0Izc0I1NU1UeHh2eVQvWkZMSlNOL0tGT1E2?=
 =?utf-8?B?QnluSXM2dDJ6VlpWYmYrclZEZldPVUJoZFNQaDQrTDVnMjhhbVhhTVpEc3hE?=
 =?utf-8?B?UU5CWnFvM2t5L1RqbkM5VkkvTEkxUjVoZnhOWTVZOUVkSnVaZUlTVnpWZFkx?=
 =?utf-8?B?QVM1eVFJTkpxY2RieGY0R3ZtaE44cktsb3hRVk9hYVRrQ1hFZXFwMTlpQXNK?=
 =?utf-8?B?Q09BaG4xcm5QTFNwb0s3Y3U1T01SN0xZUVRrMVNUenF6N2wwQXlQY1dLaGNP?=
 =?utf-8?B?ZExid3ZpbGpiaHdTaWZaby9MU091b3Fwd0thbzZweGJzd2hlcGlwOHI1Q3RV?=
 =?utf-8?B?V0tpejZkMFJ4dU9nTnRVVDRWNzlaQU8rTkVlTm11T3RuNGw1Qk96MmpGTGNM?=
 =?utf-8?B?VEtUdkVCYUFsQ0JhblJ1T2ZuK3cwTmFGSXR2QzJ2T0VtTEREcGNURXBHMFMx?=
 =?utf-8?B?eEJIT3NDQUtBbzFxRkJXc2NpZ0hOUTZVeXlaMDJ0SDBKWkhWUVpMRG16V0tE?=
 =?utf-8?B?UVVTaW1HcXRIakxRdVpKUHFTaEFnelBuSlgycndsdTRVK05rSFRWcXNGZE4y?=
 =?utf-8?B?Z1ByYTREdUhNbHFlL3lJTk5ZYVZvWkF4VEdQbE9KMU04aVhvQkszM1NXOW04?=
 =?utf-8?B?NVkvUC9vMENkNC83M0swelltc3FvRThvVG00UTUvUE1SVThXZU1Ocno0bm5G?=
 =?utf-8?B?RXhjTzdaL2twbm9BUjBNZG90b0FNdFAyVFB0TzdVdkFBdWhFWTJQdW5hQnhJ?=
 =?utf-8?B?U09qRTVIK3l4QVhSTnQ5akFsUDZuRnlac1dVMU1udjJ2dDhsTC9qcjkySFY3?=
 =?utf-8?B?d3lxOFgzQ3VtUnVLaE1BUjFFWXJ1QTBFa09iYTlpZ1QydnNmRGpER3p0b3VU?=
 =?utf-8?B?cHl5T0lqbDBKZW5idjJ0dFZmRVMxMjNzRXRNVXFsbFFpUWIxVFpoYy9KQWhu?=
 =?utf-8?B?WnphcFduQjA4TlplQ3ZJMGdrMFVDSkNjKzBnWHlSbjU3TWRhOTBoQ2RSbU5l?=
 =?utf-8?B?VW5yem8veEJYUDNVMVBOdW1NZGZzUWFsUTIzeDU4b0h3UFBVTlBiZDBJR2ZY?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8a8e31-13af-43c2-6ac3-08ddd91f2247
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:36:30.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orwoKat2q8lIYkOK6zSwhk71kl2YmwKSI7ZHxzOEqmGQucH03eSEWR9Nzzea7ZK0yibAVhy4xn4VI2xwazakG0ASucUHY+isfyBsd4Yik+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com



On 8/10/2025 5:22 AM, Jason Xing wrote:
> On Sat, Jul 26, 2025 at 3:04 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>
>> From: Jason Xing <kernelxing@tencent.com>
>>
>> Resolve the budget negative overflow which leads to returning true in
>> ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.
>>
>> Before this patch, when the budget is decreased to zero and finishes
>> sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
>> and enter into the while() statement to see if it should keep processing
>> packets, but in the meantime it unexpectedly decreases the value again to
>> 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
>> true, showing 'we complete cleaning the budget'. That also means
>> 'clean_complete = true' in ixgbe_poll.
>>
>> The true theory behind this is if that budget number of descs are consumed,
>> it implies that we might have more descs to be done. So we should return
>> false in ixgbe_xmit_zc to tell napi poll to find another chance to start
>> polling to handle the rest of descs. On the contrary, returning true here
>> means job done and we know we finish all the possible descs this time and
>> we don't intend to start a new napi poll.
>>
>> It is apparently against our expectations. Please also see how
>> ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
>> to make sure the budget can be decreased to zero at most and the negative
>> overflow never happens.
>>
>> The patch adds 'likely' because we rarely would not hit the loop codition
>> since the standard budget is 256.
>>
>> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Hi Tony,
> 
> Any update here? Thanks! I'm asking because I'm ready to send an afxdp
> patch series based on the patch :)

Hi Jason,

I have this slated to be part of my next net series. I do already have 
this patch applied/staged on the Intel tree [1] (dev-queue branch). You 
can base it on that and send the changes now; I'll ensure that this 
patch is merged before sending the other series.

Thanks,
Tony

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/

> Thanks,
> jason


