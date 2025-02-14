Return-Path: <netdev+bounces-166374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835ADA35C16
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0757A188FD96
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9407D25A627;
	Fri, 14 Feb 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KF6PEgGV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F62186E40
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530917; cv=fail; b=HVanJu5VpNu0LxVbAmteQrG2u48ubrffle6veC7BcRd8NSWPMT0Hc8qVts0UUrIfdWG7yxYjhAzljUy2JNkcbXnsAZMPccDTRHDgwXj55h2uQAjAbn7JFziKQUmdeSCmaOlJ5YCXS59m821j+pnahZgt7FylAGlI+FJC6ZbvdFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530917; c=relaxed/simple;
	bh=xGyahzNkIVm4Wjg9huThlZD+SVvLQs8OMpKFomBpvVU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rlMsCZz/Vo/WhPmcDt43/76fae5RzDrphUvfjv/i+AerKerRoa1WwA7OxkClAx24TQ2R68jfB2RJsmddHkTP0F+VNxdBNx1A+7FuJY9GxtzhakhBdcOyL7nlqcEGGWwY2pwAFqDffV1WIIp8VeUkoDoD+SL0y0O7TZAepRmiJiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KF6PEgGV; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739530916; x=1771066916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xGyahzNkIVm4Wjg9huThlZD+SVvLQs8OMpKFomBpvVU=;
  b=KF6PEgGVipFtzV8r1UCj92QNSp/mbIZHglPAmgVn+GlRS8cFgMI4tyIw
   r8NpIsVE3HgVXqPhFV0AMvO9k2YZ8GIjEGp3cl3vP9wlWXm+Nyzs1uM41
   tQIjzvsoQuEr1oJaj9k/v+avpyv0iKHAPv2RrS7vcK6a9F18Cl6jeqhzP
   jOvIhkCv33er2C6VDuJuivZdF3n7CdV+YwTkJ0rbP8+/pwkkqRVFsFFeU
   M+jqlj6t19qdwfy82Rn/sXp0m8qTbxZ21KyraxyKI8S+xbg72Ob/qy9ZZ
   2S8u+lI27KNBfWCSoeg85fwOIAoGWrwQ7vHKNepUvbZEfQcMOABJd+VEU
   g==;
X-CSE-ConnectionGUID: eMMeeh27RdOFH/yrKEzE3A==
X-CSE-MsgGUID: 5xT8Oex9Q0uT1MGhR9togw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44042312"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="44042312"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 03:01:56 -0800
X-CSE-ConnectionGUID: luo0zHu4QIaLoDW5CmupiQ==
X-CSE-MsgGUID: WiWomB9CQNWB6jNYpboBkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118050920"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 03:01:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 14 Feb 2025 03:01:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 03:01:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 03:01:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4RbnYmh7QZUwUtXgtmtkBaf/v7B+85C2jOa/nP1Jeg3hKHThaLN41Y37lN2kgUvcAu1ynrQHPaXQ5J6W7SsAscB1/do7sy+zBEL6OUeVdUwHrhPvp0Vv5TbS4iQFh9JVpKGvSRE8U1d0rRFugh9lcvIu3q4ei8bQcHNmAB+ns1ovpIZeWTJ+f6XkiGWQLG3l2aY5rarwOVohDg89nyYzolucz1HQ24+uKFYMofuFd4EPOvvt/cWfcF3H41ISye5nscTzPPtNxoie7nLfzw6mPaJ91GrJdxRAvUqytxdcM0LrLVWPAw0x6b9b76zwMW9Zik/i/lvbx/ek7sTsT9auQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1jM0XhS4C62uwRAYrdPj/rPWgqSDXhyLi3l6+8BBe4=;
 b=WHV4gZDnv4lhUfBwMIImrS3rVCyN29kR5RylsQUlnqGxUHePV+0e2tZ6D7mJAKsYz3CRng7vNrqMB66B1x0kea5YayVVENC+Y2s33wgZloi39yBNGSXIQEBXWiClZPkNJAdRqy3czxWiZb0NiCBTwI9kAL9/uMelyBU+45h0wHPz3YYgizGtwqtmjMg80IibC0WEWhjnhfr6kvKt3DZ9vrYcQT7+fzISpmQGE/KIJe+rr78K4MFJ4WIJc5r8XHB8NR0BM0KT6KshcuhQBRaoQY2zd9CGkf/mDOrIb7faRBT0F+TIGub3nz7yglyKTvCwfbYFK3/77iJWqU9iu1h7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by SJ2PR11MB8423.namprd11.prod.outlook.com (2603:10b6:a03:53b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 11:01:43 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 11:01:43 +0000
Message-ID: <3cec5888-25d4-45a6-bbb4-b3bac8632346@intel.com>
Date: Fri, 14 Feb 2025 12:01:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: phy: remove helper phy_is_internal
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <f3f35265-80a9-4ed7-ad78-ae22c21e288b@gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <f3f35265-80a9-4ed7-ad78-ae22c21e288b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|SJ2PR11MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7a583d-08aa-4072-6db5-08dd4ce6f738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlB3bmxqc0owTm1NL0JKbTUwUEpUeFYvbEduOHNQakJoWWkzSllkZCtFM2M4?=
 =?utf-8?B?aG44WDAwM2F1cHk4UHhnY0N3OFp6cWtUS2hTOGtKYVBXOGlFMGtGcVlyeG9m?=
 =?utf-8?B?TExkSXpwTlFSdHZwYjhuQkZzZlgxWEZKenB0Q2NjNG9vZXQ2ZTA2c2NBbUZn?=
 =?utf-8?B?ckhiVFdKWmF1ZysrNUtLOVE0Vml3bncvV3FETEhlUkJXYmc2QkhtbURXYzlt?=
 =?utf-8?B?QlJKUi91Wk9OSkJ0N0xZeDJsWFY2Y0J6UnFlUGFjcExOVEJ6TGxsdjhUaHcz?=
 =?utf-8?B?TUpCU3RYUXRjUUZKaE9Lb2ltV2pzQTE3M09aNWZPVS9nZHF3YlliM2F6MjJP?=
 =?utf-8?B?VjhmaGhQcGdWSFFRZGkydTVsdzhoYTZhMGo0UTlWTlV5dm85WjZ1cGVWazF3?=
 =?utf-8?B?akRMM1hpQ1hsK2Zsa0FZMU00UUFYNEM0YkwxMDY3NmdDNk1PUW1hQ0VUdHhN?=
 =?utf-8?B?YlVYMDlKWWVjZis2TDNNSkM3bU51cTMra3hxcDU4Mk0yU2hLRHZHcHFlN1Zs?=
 =?utf-8?B?YW1melA0ZGQ0WVlUQitYbXJsR3FnTmM2cy9uQllqSENsNFpKNkVGWGdndVg3?=
 =?utf-8?B?SFQ4aGo1bmt3UWV2WFdJVFNmVXJ2cTI0eEZUNUZxbVpSbXBna0VaZ1hLN20w?=
 =?utf-8?B?VWpSM0FZRDVqR2pUc2VmWk5WaXFoLzl6Wms0NjUyaTFqa1Zuc2QrSy9iUTA1?=
 =?utf-8?B?c3h1d2hHblR1QngydFB4eXkzRFNXeDZEdHVHcC8wSk82b0VoNk9BR1l5bGx5?=
 =?utf-8?B?dEZUMHkzSmJLeWZXSHhtS3JmaXJMbXlpZWhZRWJNd3JqS0MxN2hqaFFqS2pw?=
 =?utf-8?B?MGpqb3BoVHpDSHhpaElRR3hEOHE2SitTSnNUMFFjbFhCdUUxdmhRZXJwS1pB?=
 =?utf-8?B?akp2QmlHbDlSZTQ2TE5UR1pLV0lldlZ5OW9VUEhyWlJpb3ZFK0lWSmRUa21x?=
 =?utf-8?B?d1lFSkZzaXA4V0VXanpTWVlNUjhiOEZFNzdvZlVROUFMaXhOYTZ6Y1dHMXpm?=
 =?utf-8?B?bnkyaTBzVVBUN1Z4Q2JIUlgyTGRXNWw2T3BYSW1jSlFHSWZrVHJZb0FYRWNH?=
 =?utf-8?B?bk1wTUR6Z05qeXJjZEdQaFBGeVUyYXpxMExETURTTndYazBucFJoT3BhQ21o?=
 =?utf-8?B?WlJ3N3JlamhvZmVlVkw5YTB3UnI1WFJlbEZoNks3OGkreHNLVy8wMFBCalVy?=
 =?utf-8?B?UzU3Z2dxWkowbFBwbEw1a0E3MVp5RHZWeGJrNVR6Tk0wVjdoQ0ZKV0dsNUht?=
 =?utf-8?B?ejF3TDNodDBQT2dPcmxVL1hVMUN5RCswWGJFbnA2ZW5HUGdnOVdEbm1IM0Ex?=
 =?utf-8?B?bWdZclZxc3I5L0hLMk9HSmJkZnBNem5ocVl4MExvbVhKVDQ3S2dFV3hablZG?=
 =?utf-8?B?NmRTandCQzBNNFhuVmNMRVVpb2V5bzFtZFZneWhnTnNIL0NuYUZrb1ZZYzNC?=
 =?utf-8?B?QU8zSWVacWFvMGM3bVRPYkVpdHc1VndyRWd0Zkh4Y1FCVkZPQytyMUoyQ010?=
 =?utf-8?B?ZWkxOGhlamtJM1hEZ1VlUzhCY0dvTVJUOXlnbGt0Y2RmUVo0dUxYdUNqT1JX?=
 =?utf-8?B?NGw0T3NTMlVlSDQ0YXVIMUJsZWNHMEdnb0lsZTB1RFpsVGUxUVlkYlo1TDh0?=
 =?utf-8?B?RjFwVHR3UGwzdG5rZ3JtT3NwYXFzc2Q0RXhXME05RWxtaEhvb1ByTjNER2sx?=
 =?utf-8?B?em05VktKRHNNc1NyUHhjTmgyYkl4RzR3K3JIRmhucmRaY1A4SEp4QndaOEJ3?=
 =?utf-8?B?aHR3YVFpRGpxL09odmFpQ2ZCSU9EY3ZxMDEzajBlSldCckZ1MnNQRU9JVk9v?=
 =?utf-8?B?a2lWcjdPV2d4QVpuRkdzZmtSdGwvaDRNUnJ3K3V3Szl0a0hBSUt3bHIydG0y?=
 =?utf-8?Q?+QRXRZnKt0asz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpmU1c5MUJnTTVnU3d5RGVHMEhLenZXMEljNjBKSDBwQ2NsN0RNS2kyM21I?=
 =?utf-8?B?YjRJbFpQaFV3UGNQaWJvMHoxWFhjNHVGREprT1hnVFVSaVdnc3ZLUGFKc2lR?=
 =?utf-8?B?VjViY1hVZXdTaFRUVFJNMG1Qa1FYdERjZ2pPekJqbUVUUmo5UFBnd2N0OFBV?=
 =?utf-8?B?LzRxYm9FQ25Ea2JsUzJTVjB2bC9Sc2dqUHdVTjhTQmhJU2lwKzBVRXlFYkRH?=
 =?utf-8?B?SnVjSWo2R0YrL0wyUGJXdmpqMmxVZGd0TEo1K2l6Z2ZQR0dkd0FSV3duZHlM?=
 =?utf-8?B?N2Z2anp4UHNnYU9ldFlINHh0dmgwMzFpeVZycW9uNnZlVzlRTGlrdDNsSE1Y?=
 =?utf-8?B?cmpMSXNIYUxoNGRPV3BqVWVwK20veDQ4NzN2ckJnb0lOazNVSWxQd1dndU9n?=
 =?utf-8?B?RmJjUGVlOEZkUFZCamhRVVRSM25zS0J5cXNhdSs5Mm9HNkNoRE1QZUYrVzVa?=
 =?utf-8?B?cHJPa3ptYXRwazdZVU1FZkQ5QWxOZVlXbGpzQkJVbVVnU016cENjY25GTVFt?=
 =?utf-8?B?RlhtdmdlS0xVWmFMd0RXODI0ek9FSE1SRHlDMlY0ZjUrOS9hcStoODdubWFz?=
 =?utf-8?B?ME03T09HUVBoakxXTFp4VXlvNXhWMXhxdHg0RXJQdW5NS0JaY1N0THZqcXZz?=
 =?utf-8?B?eWRiUDlWQTB3NFA5WXQvenFvWDg5LzlSLzgybnhIc3ZKTkRiVDE2U002ZlFk?=
 =?utf-8?B?RytKaXhiVnh1Rjl5ZFc3YnJITjF4S3NEcHFIR1cxN3R3cVhJMWVhaUE1aE1Q?=
 =?utf-8?B?M0pMbHZNZHA5TkhrUDhmTVNaYWtTTGs1dVBNdFhISnQxMEFUa1lvTzZZblh0?=
 =?utf-8?B?T0I0RisrNk5Za0RQZFh2cjNOZmluQkhySEhjb3JtTWh0YlpodHV1SVFHamMy?=
 =?utf-8?B?SldsTWVrWVU5Z3lMY0tndW9SV1dNMG1XZnY3ZHk5Y0RlVUEyYXNieFpJYzcy?=
 =?utf-8?B?VURpb2dnYmhkVGtFSnFqc0JXS2kxVVh2M3ZVK2M3WmZvdngxaWpGQ3FOby9k?=
 =?utf-8?B?TGhLNTlMQkh4OUdxa0F4MWdwanM3NGVNdmFLSmwwOThxUm03Y1A0RklHUHgv?=
 =?utf-8?B?NGdhUDNIR0lsUkFHMGt6NkhuZ2hiU1NOak5sM2lwd1RMZk5hL0EzUEp4bXF3?=
 =?utf-8?B?WGtLVVovemdtbmg5aUZ0d3ljK2d0RVM0WkxWL3RTVFlEMkM3MG9idXJDSDdi?=
 =?utf-8?B?dlk4SkRxd3pZdkUzUXRmTURORGJJbDVvT3ZEYms3bWJpQ3NJdE9nZlJyUStK?=
 =?utf-8?B?a1BKMlZoUWgreUJJOGE3NXpZMkRCNWlVdzNSRDVFbzVUMG9nQUVLemNLeU82?=
 =?utf-8?B?dDVrSHNFSXIyYklLT2JCQTB1MERLUFNMNGNMNHhkbmxMcDZxZnNzajRRVmZz?=
 =?utf-8?B?NGhseEZJeGg2TmcydUFFVVJvYmRNZUh0dVR0MHVLV2JGc3M5Z0ppQjBId2Jn?=
 =?utf-8?B?Mk9SZW5ZR09wVUxSeXNuNTE3ZzZuNmJkemNpNFJSaXZmTWUrTSs3YzdVNkFY?=
 =?utf-8?B?YVNURW1rWHM1eHNzT0xodlk5SWdoMGlCM0k3djZRaTBzazJMWENXallmMFFY?=
 =?utf-8?B?QmNMSHEyalpWbDhWWFErdXJkbng1dVJwYUdTV296eEhNWG91QTVma2I1L0Er?=
 =?utf-8?B?UE9aZWFvRzJiRzBpaGNNYzFRVWgzZEVlMC9XdzUrR0NFRGpsL0RYSytRTEtP?=
 =?utf-8?B?OU52TFY2dnZxSjlVNTVwNFRpQU82bkU2K28yUnM3bTY1dFVuU05GdEt6YUVM?=
 =?utf-8?B?NU5jNEE0VUhSSklKT2xoWHdnaHc2MkFOeXM4YWFuQnFYOS9SWUxlTGFJVFhR?=
 =?utf-8?B?Tk84SkdaM2ZVNXhYcm1SSTVVUE82MHh5MEE4VEhCQTFsMWZRUEpLT1kvcGFG?=
 =?utf-8?B?cVRub1BmN0tRdkd0OVpXdEJ6YWkxZExxNXI2YmV1RXROVVRMeDA5bmlqRkgw?=
 =?utf-8?B?VGo1amV4a05nMm11SUJ2T3FmYTgzci9CenhVU0xKc3hkVnc4RHIxRHJFek80?=
 =?utf-8?B?S1cxVGlWd2RraDhMZE9wVXhSUjMyU1dKMmN5eWMwUWhXZnJMWVdLemUzczd1?=
 =?utf-8?B?RGVTWFh6REFVWHlaYmdSY2tJb2U3MERqNU8yUTlUdzVScUs0cEhodlNwajRO?=
 =?utf-8?B?T1pOdjBOek5rMEdYeHo0cFFCZURaQmY3ZmVBbDg0dnFmYk1Dbnk0SDVlYUd2?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7a583d-08aa-4072-6db5-08dd4ce6f738
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:01:43.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACsf60rbdGLNiGBBpHlm0kj/oLaADib/LrmQjnXfNB6zk7M8n6KW4zS3GZpuKV9tmykxLuG/CmCs9Qmd6kdzERhed7CFe7dJRLDUhLL7JV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8423
X-OriginatorOrg: intel.com



On 2/13/2025 10:51 PM, Heiner Kallweit wrote:
> Helper phy_is_internal() is just used in two places phylib-internally.
> So let's remove it from the API.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/phy/phy.c        | 2 +-
>   drivers/net/phy/phy_device.c | 2 +-
>   include/linux/phy.h          | 9 ---------
>   3 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 8738ffb4c..77b3fb843 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -302,7 +302,7 @@ void phy_ethtool_ksettings_get(struct phy_device *phydev,
>   		cmd->base.port = PORT_BNC;
>   	else
>   		cmd->base.port = phydev->port;
> -	cmd->base.transceiver = phy_is_internal(phydev) ?
> +	cmd->base.transceiver = phydev->is_internal ?
>   				XCVR_INTERNAL : XCVR_EXTERNAL;
>   	cmd->base.phy_address = phydev->mdio.addr;
>   	cmd->base.autoneg = phydev->autoneg;
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 1c10c774b..35ec99b4d 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -544,7 +544,7 @@ phy_interface_show(struct device *dev, struct device_attribute *attr, char *buf)
>   	struct phy_device *phydev = to_phy_device(dev);
>   	const char *mode = NULL;
>   
> -	if (phy_is_internal(phydev))
> +	if (phydev->is_internal)
>   		mode = "internal";
>   	else
>   		mode = phy_modes(phydev->interface);
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index bb7454364..8efbf62d8 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1729,15 +1729,6 @@ static inline bool phy_is_default_hwtstamp(struct phy_device *phydev)
>   	return phy_has_hwtstamp(phydev) && phydev->default_timestamp;
>   }
>   
> -/**
> - * phy_is_internal - Convenience function for testing if a PHY is internal
> - * @phydev: the phy_device struct
> - */
> -static inline bool phy_is_internal(struct phy_device *phydev)
> -{
> -	return phydev->is_internal;
> -}
> -
>   /**
>    * phy_on_sfp - Convenience function for testing if a PHY is on an SFP module
>    * @phydev: the phy_device struct

Thanks for that change.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


