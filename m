Return-Path: <netdev+bounces-127929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27421977149
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7A1C23E15
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC21C2330;
	Thu, 12 Sep 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="halACpkI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3521C231B
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168284; cv=fail; b=d/JTALkUYyWk/CXPWripJ58Y4Gcw6pvM5tp7qZeww0rQlvPpqMtjAuv7cevJAoKw5qpA1mVKCHHax4/AhuRFNBQ13R1OEKztKP642CMv/5CL4bicYvz0fXVXTLtZh25RzGvlw/8qPZOejG8y4lEmGGCnpek2A4DRhq9Us9sxy3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168284; c=relaxed/simple;
	bh=oFobKJE3xJLJBK5ygnhVuGfi7BYQ+cy7WXY34DWvT8g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IvovUWFr0E1VXqPdEeE4dmnSPoeLacb68NjSCVbpwNDv3dnomv3YSPA7m+D1mzkOf5zRiJQ0iagLH1bt7Ccs02MDCvtrJrHht/nEVP3JyqzoS+R9B3shCZ8iyI+9HT7R0Kn0D7t4yaKwKrJCVI8S6F2NQ87WfACQ5SugNErtJoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=halACpkI; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168283; x=1757704283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oFobKJE3xJLJBK5ygnhVuGfi7BYQ+cy7WXY34DWvT8g=;
  b=halACpkIQhs861cJJWNskvIvnGFK3upnBEDe1pXfaIgaFIDcsGZR0oNW
   TJ7hK0TtvyEfeb9WqC8B7uQVYLudFVemh2V06zoka9Q5SIMQQHubki2mZ
   IWzjzlGyjJ2w0w3RX4/kdfDICDyRj1WQ3W/gIWMQ9Q/ZfrW2kzH/t5xG3
   MXOGddhFQ9imQdCs9OKtfQ9u0D4pXx2UD9ecVC+torc/YIa5jH1E+tejH
   VODiiNZQA3nMIPwUh7aOLWkR3oNlSRK8KbeZBj61jDBU40oYLs3bJ/AMc
   tyPIRUVe2gCISnkyReu5f4+DAF9qjfUFoIG5q8mlDFDllL5HXDVUtI33a
   Q==;
X-CSE-ConnectionGUID: Nw8lVETkStW2YHKgVO9vlw==
X-CSE-MsgGUID: uUH8AEzGSlqrnAQeeuL17Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36395645"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36395645"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:11:23 -0700
X-CSE-ConnectionGUID: fEO/QD53QvSRTNjcrGLN4g==
X-CSE-MsgGUID: W25bFureTR6hVGyR/H+Ucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67515786"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:11:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:11:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:11:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdLJ1CMQkOYxJeXwr4U5RISWEeIoy1J/sljKzhY6T/OIxHBjv5SvXboGdEVWNSe6iJxcJy049DwSlSzWJH22KnQvKLb6k2rIT9RTHn1ZzEfb7OiF4pM6agcdU/j60QZu2j2f3Gj5z5a+m+5NDkki/K2Rb65NTEtelw1ISbXh3VtOWlQe7Su272Xce4a0SA94nX8w+Hf8jKEm1ccC0gi981Oy3UNgbWtTNCRgeIPF1yap/FxKGNskkmPuQmoFcVT2dyaFWfZ6th4/TkVZYNuxHwAbWX/lClonWKkmMwmRsX9w3GWf85mH/CHtgc1EYD9Hrbm9cMhohPR/xfdOCcUmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8FfrpjyfOhw72BnlBuYrlDMexwOwaufrkLuFeYL3j4=;
 b=Y1/eA43sTfNeTqa35xg2wNdrlhddCSUlSbRgqQ5qxHbhB1tYauvB9M2nDQzM3BUh87x9DZinKLP/kw814k67jw4MjA6k7F47Ppo38VizQAhjQjx/dyS5TfS4frU4EAVCt6cH9StezrKH/v+XF31pB3UxbQSOxq7MZaQu2kal0WDDuBFSJiBDxUbFFglZP878HAY/yBK8JIBAFcCQYSsKXdv54C7bcfCNUY2PcXSWsgUj7Unk2PAsFbrlcEfC2eATq83KEs88UWh3zwd5sxhWLLC2/vfP4eeNZgsaw7cVYvvuRJJYbHqcm4J7/pEtDtZ6PnzQnPhT6FBDHcuxhh0MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:11:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:11:07 +0000
Message-ID: <611c8945-00cb-4fbf-a6a5-1fe014352b7d@intel.com>
Date: Thu, 12 Sep 2024 12:11:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 09/15] net/mlx5: Add device cap for supporting hot
 reset in sync reset flow
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-10-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-10-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:303:8f::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: dffb05f2-f4d1-4fa1-7594-08dcd35ea7b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnZYc1RJdEcxN2Zaa0kzaVNBTDFKMFh5ckFYSFRFN1pFN0lHUmZoUG9BSGNi?=
 =?utf-8?B?dG5CdHB6T2h2NlRFa2ZHNHlQbkloYkVHNmxhWXJrWUdSNURETHpmcUxDa21z?=
 =?utf-8?B?NUJ1cmVBejBhc2R5TENMcFBrVUxmS3RsTjFLck5Bb1FSR05wM3ZmbENDWHdB?=
 =?utf-8?B?emdodzFYRUUxa09PME9ZeU9KeU9IRkdWcEVyY09rZlI3ekEyTS9hUFZ4Y1E1?=
 =?utf-8?B?V0VjblppTTlDOFpPRExXS01acmZ2djBmVk03Vy93ZndLVzkvdzF6VUdxYy9O?=
 =?utf-8?B?RlhYMng3SmVLcWpMNDNPeUVVUGFXRlY3Y2FjNVczc0hoN1F5Qk1LdEhESjFa?=
 =?utf-8?B?b3RVdm91ZmFIeU5tNi9uYWpXK0pIWnN1OFBCYlQyTEp4WTBuOUtZc2hHcWVQ?=
 =?utf-8?B?OGhIbkMyWmY5U3paTm9wZGhGb1B5dmRQNVQ0aVBOUHpyOUQza0dIbVpBQWZl?=
 =?utf-8?B?NUVvSXJQV3RaL05TdkQrWjE0bi9KanQ2T2Q1allZZUFyUHVoSmRscVdtd3VR?=
 =?utf-8?B?RFVWWDR3N0NMOG5PMHRyWmR6endieng4Wk1hK1duNHhVaHVURkt3OWNpVnMv?=
 =?utf-8?B?Y0dIbW9OZzhKWVMxcHdXVkZRMklwMHRiSWp4WU5GWGdmRUMwUnRnUTc1bE8r?=
 =?utf-8?B?TlN0S0R1TXdDdVUreXpkYlR1RzFwTXJMYTdoVm1hejBJdDV0SjJWQzNhRmNE?=
 =?utf-8?B?S3Bxd0ZMSFc4alk1TzhUV3QzUklmRlFRd29PUUVCRCtOYzcxN2lCSDVUa1Ey?=
 =?utf-8?B?NWdwKzJvYmt6a2dZR1BES0xkK1NyRGNEN005ZjNTSnFTS1FaUHFzcmdQdDEr?=
 =?utf-8?B?R0ZDZ1pBZWxSbkRTQWZIRVliVUZHOXY1My9EdW1NVUZ6M3UrcWx6M05UUE5J?=
 =?utf-8?B?RVF1eGg0RENuM1VmdnhncVNHR0dSTTQ4bUtoKzNHYmtpVmhxSXREaTBBaFdP?=
 =?utf-8?B?WkwycmtSQ2tieWd4OVJBN0ErQnlWUXgxSU9TT1g4eVZXZjF0a2VwK1JkMEM2?=
 =?utf-8?B?MWRvM0pJVlZWZzRod21xbmZlTnhIazh2MmRZOW9oVmp0akxtR056akRqVWZp?=
 =?utf-8?B?VEczeFpjb3YyWWw3LzVqWGVrd2xyNU5SK0h2b1hBd1hkcTJkL0x4cWtNNVA2?=
 =?utf-8?B?bzhNVjJkc0NsNXh5ZVBQeTd5elovMDBlQXRPVXJCbENaMExQZktHUTlwdmJx?=
 =?utf-8?B?TExCancrMlpvQm5vS2ZWWE56MWdCeWhQWUxBNXBjcFJ0MTA1Z0c0Tlc2TmhR?=
 =?utf-8?B?RTRnSTV5ZVphUk13dW9kVk5melNwTWZRcW44ZXJQVjBBMG50L2dzUVgyOEJQ?=
 =?utf-8?B?ZGdteUZIUERScWNoVkpWYjNON2o3WE1wa2JWYzFlRjVUSWsrQ3RFWlIvV3Jo?=
 =?utf-8?B?UUF3T1UwQytQbXIrTWhMZmtMcXNzZFBha01XbEJNS0c1T2ZYSE5ud2oxOU1z?=
 =?utf-8?B?aXJEcUkyYm10ZWF5Zi9naFp4QzVLeDRMeEM4WmhTZlN0czJrVjkvU3hBcjR4?=
 =?utf-8?B?Z3VNZTRvblR5UysvMGd4WVk1cGlUS1NaUEU3TEh1YlFJaG01aVZjQjBjeVZD?=
 =?utf-8?B?bncvZ2lqNVZZdXZMb3owNVhYWnhiOE9Pd3F5bSs2YklsU0FZRnhLWlVxMkV3?=
 =?utf-8?B?NHB2TkdhdE9kTm5ZSGJtc0NoRERPT0hOZGszb200eEx1WXhZaXJBRFZsZkdG?=
 =?utf-8?B?dDUrZm1QbGJJMlF0ZUFBYmprTU9KRDAvM0pWMFhuSUkxYTRlaGsybEVtd0Y4?=
 =?utf-8?B?M0tWQm1tNlVSU2pjWGtreVVpRzAxUDlBL2ptd3pJV2djNkxYYkhhUDVnTXkv?=
 =?utf-8?B?YTJSNUl2UGRHN0tFL3RIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BXMlhUbWhmWStROGJNZGtyM013QUxIRFNzYkhHL0ROejBaTmMrcVJ6UnBG?=
 =?utf-8?B?NVBkdnJILy8zQ3NHVG1SKzdtMk1RN0FiODU5MEtZT29tZ3NOeUtWTWwydjR0?=
 =?utf-8?B?VFJMU01yZWV5U2pWSTlyZUVXKzVJSFFBVnM1alBNRklwRnVlcGUwai9ld3dC?=
 =?utf-8?B?M2lmMnlnWEt6cllDYlpXeU4wMUp2NHlHREhLeTFQeStvOUlVQzIzdXlyVWk2?=
 =?utf-8?B?VjFVNnNyMllNYytQbXpia0pLQUx1cEZESjludWZMNXY4SE1pR2RzSFZiTXZB?=
 =?utf-8?B?TkZIVzYzdnFjSWM1ejZzTWlLNW9NZmpWSStvdjNDVjU2N1hKdHpicjh4SEIy?=
 =?utf-8?B?aHNKQkRlRkdJYWZZclBCMWZWM3FmeWhsL3pRZWZKKys5WERick4xSWp6Z2dF?=
 =?utf-8?B?R0gzYms5eTA4MmV6aHMyamthNk5UcGQ0UVNPQTcwK0VVTVArZTVmMjdzS2gx?=
 =?utf-8?B?djB6bEpERXh4RmJLdzF5dWVlSEVjMUtmam1vaHJDRklwSDlQU0Y5SVMrWEc1?=
 =?utf-8?B?azVzMXB0a2FvTU5ySFJJNnc0KzJ1WXlzS3cyazExWENUYnpUTVlpREc4cHZR?=
 =?utf-8?B?MDh2VmVWd2dzNXd3YzUrQVE4OTM4cVNQOTRiWjZiZTc3REF2dDZCVjkzUlQv?=
 =?utf-8?B?T3FIVmRUeUo3RlZ3R2ZCK1FaRS9mZU9obEtMaUg4NWExL095VFloaGk3U0tL?=
 =?utf-8?B?ODVjcWl2dEJBdkF3SjhIME1EM3NKOUx5SEtEVFdaZlA4MnRidGdRckVoQ1VG?=
 =?utf-8?B?Z3Bta0xvaDh1WnBhZDJlT1lIMEVESk9HaDF2RDByVXRoVXIwblFyV0FqZXYz?=
 =?utf-8?B?dTlkVE43Z2pOZ1VyZW5jQmlzUUlnNWFsczNocTBBaUprNkVEa04ySExJb3ZG?=
 =?utf-8?B?TzhFZFJxSFZuVDk0K1dzQlp4c1RwNnlEQ0JwcmI0R01mVmFKeDVOaTVSWm13?=
 =?utf-8?B?VCs4bGZ1SHRoMXcrVjJuYXFsNVhhTEx4R2NQdzJic2M1Q3ovT0xBckF5RytX?=
 =?utf-8?B?Z081TG9adEtER3VqcHJjQ2xUN3JLR1lycHJGcXRaaU00N0ZpTXBWbFVoc0NY?=
 =?utf-8?B?Rkt6TUgxeW9OY1RHdXJYT1dTbDdtRE1YanRrb0REdW9mcVlvK2RCM0pzYVdz?=
 =?utf-8?B?RXFFQ3plRCtUeWFZR1RPQkpoWnYralRxdWI2K29YSzIvNW1FSnJja3djVzFw?=
 =?utf-8?B?RHdiWm52a2xNVGF5bXNqanZ6cU1uRnp0MVplUWh4UlpJckNaRmU1cklwS0J3?=
 =?utf-8?B?MXZaTlBYYnhFMDYrUlFKUGVpY2NwTmgxZk9ON3BmMmFsQStNRzhiZFVxOG80?=
 =?utf-8?B?eCtVS0xoNjAzZDZ4RXdWUWRuaVNDcnpnelFrNXBtUUxpTnJOTkxiU3Zzc29w?=
 =?utf-8?B?Sm0zRlBtR1lKQnNYSTR5aCt2QVNpYUQ1eWp2bFZyaHNicHhDb3VaTE5WNWhY?=
 =?utf-8?B?TkloZ3lIQnhLMlJCR2EyeG5Ja2xrUy8vMGpYUjVNekdpRGh1R3l0cGFQelVz?=
 =?utf-8?B?bnZySE40TGtkbWNkaHlQRHdXYTFMMlNpblhlSWhoN1ZZREVuQWN4M0hmc3pX?=
 =?utf-8?B?clAxdXFEY05sYWVpRHNNQm1qNHhRLy9OT2xBUHIrZlc1VlpHVnIzSVkvRURT?=
 =?utf-8?B?S052ZlFtaHpRaUtZVk5yNjFYcWpjNWEwSVZjNVd1SlB0aEFKeEYrM3JwYkRE?=
 =?utf-8?B?WmYrd29tTWxndWdMVXh2Z013Qk16T0pCRXZMQ1MzQkZOVGVFT3BoR3VWZitN?=
 =?utf-8?B?UlBLTHkrcWpGRU5DeHhSNVpnTFRhTjJ0L1JhVXhPU0xURC9lU3dTUDV2RFpv?=
 =?utf-8?B?Q25PQkVkL3hQa0N3MmpLVUpoM1hEM0JGZ3grRXUrZzdENm0zR0tCV1ZIaSt2?=
 =?utf-8?B?RE1jZHdJVkRmOTZLUGNuYUtVNlNJZGQvMENZcVB6RUthNW14VTBjTGMzMnhF?=
 =?utf-8?B?U1A4MExMZWZuSmdxT2toOXZlUWp5bVFPVXR0aUhQQnk5UFBsQk9GNHgvVzZ3?=
 =?utf-8?B?SkZUcHhUOGVIZWw2YU80RDBaNUJ0b1dkQUg2T1BpYVdVUjRYWnJubDJpeUVm?=
 =?utf-8?B?MWxJOVlEbFRQT3dZb2Y4Q01Rc0o0WWNMc2NZdFAvUlZGZno4NzBBVmh2TFNK?=
 =?utf-8?B?V0VUY3JQN1FSM2hibXlYdDNyNDFqSlB6ejJzZGZEK2lGUUIrRVZrVXhqK2dP?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dffb05f2-f4d1-4fa1-7594-08dcd35ea7b6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:11:07.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZtlYfNct18jpbS3GVnvsAS6sVutqYUFmSBPljqEBShgpGBTa4iQM1oKkYilyLln3YJ4XiPENh6JGM5Tj6BVZL+1/AmZWzui2anlOs0UsyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> New devices with new FW can support sync reset for firmware activate
> using hot reset. Add capability for supporting it and add MFRL field to
> query from FW which type of PCI reset method to use while handling sync
> reset events.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

