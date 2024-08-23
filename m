Return-Path: <netdev+bounces-121333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9195CC6A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE1728320E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09818562A;
	Fri, 23 Aug 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izw9lctb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349A4430;
	Fri, 23 Aug 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416465; cv=fail; b=GpsGpAX0d8Ck4Es5XlLy9Dh03f2yyWbigI62/Z858aJn1XgUysmZ0H8DBv5OJZDw6ivA3P1HNiLZi+WhZpvY+sfZW3FRGT9Ty7TEQ45PudKeEyde/bWxzb3FIFlbdgFYJX8rVeMGMN7PMn60vQkik4q/PJP60PRr62PGIlDCFOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416465; c=relaxed/simple;
	bh=/m8e75jKQwIbwXTtsXNCDhkc4c0ZvmMTfstuX0i4i9w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XU9IGTVd7Vd0aPhwC13Q+Rj9FwvwXseM9920FEphVyTNeyecfKHj14NAcnbAo2ijG2HiIyaY+/ubFwT+mxPKqB2982hkUd47SNhRQKAMviSY48vqMAsQFm8ws2d9SgeiQpL4Y66Qy9tdVSvEYcYO1ADjTPnOnNlOgrQuUClFM8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izw9lctb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724416464; x=1755952464;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/m8e75jKQwIbwXTtsXNCDhkc4c0ZvmMTfstuX0i4i9w=;
  b=izw9lctbeTuxP2idbVaDnquzlzO1D98UVT1Al91tVSWXxeX2gc+LiIKc
   Zd4/Hxa861HgWQHvXXqMKhQeaC1fxYfn1NLNU6U0ahFeotfkGoGvXeO5+
   eU75ftTNfGuESOoNKcYkDLdJHki5wyVuY0rPjkisW0rIi0xWcR7YKzEtf
   1I9eAaVbQTOccvZ1FlhFHlyNhefT968m8o8Am/3Zg7ZSUYG19PzYh8WBl
   QFEs+cUGy62GBVnJhlUBc/B1nOkVmlWSAcqKEAASQ4HFBUTuI6Oz4ruCU
   C64Llfstr3zUkq5o/X3347m1a7dz3lAk3kKoS3nOXgAcfsVfj1FhojFmm
   w==;
X-CSE-ConnectionGUID: DG4qfdycR+O708JZv2QS6g==
X-CSE-MsgGUID: 2pFXTbVLRWi7T5LgVJDF7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34298417"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34298417"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:34:22 -0700
X-CSE-ConnectionGUID: JniJ7iewQqie8CWW18lOzQ==
X-CSE-MsgGUID: PCQs3FVGQRiKUfVKEEUHsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61761653"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 05:34:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 05:34:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 05:34:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 05:34:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 05:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6KpTlKF6Kahu9xBapI0+E9iibT6RPjhjuHzHEiqVfQQFR01rLiyHiM+FRVkiSGdtFpCdnWNl44UdW+HQLiXgToEU0UOCfWuaAAksCBS8W+Hm72xc/ax5hfezfP5gCC9EvXJf+E9WraEKWpuqM897XG1UqzePY0+H4T9YThTpaaUoq8on9XyWQsHARcYVA5NZ797CLnCDsC/oxMvflruUB2B/xpqF7EL/F7JjM8oU/ed2DoFN3VnnTqNUkLmrmT8Ftc50ErJMOz/jgYp8JHbQ0Eo1yux53s4PUP8tITwaodzvggo5rP7ibMJ3zcUp7QL3V0yGOqviHcJ6GAr4yG/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2bgBmV4jMOIFz04CWZ51SIeAYjTWPrG/pTNb86+LhQ=;
 b=QRbhyXq6hl/2mvYCXt8C7JnTWbiHok/WPGMegpinnsD+YqSpMpFOViszUXUSrf/EfmorGRDUp5YR6Cvc5/F8ySahgN9PI8fkEscP3d28V8rJQ8jvuR+M3pyiTyJlgBWmkEX6q7wmT4ja95RpQVPX+7A+hPD+UaHy1WPbJyLVjXTlzyvaJ1gQOEUMsoNvAjDeGbmrCFuwmNoGQGtAPR87357oqwWfj8lAKlLPzmVrGFLiNY6P19iLwbKq+RVzHK7Y3murdEbtP535ALwlX7EH5fXjZ6n6/n8WjrhONO9nRy8t5GFs2fM0EDCPlI88j1tRoHsqV2jRtc9UuErNa5OeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 12:34:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 12:34:18 +0000
Message-ID: <6c72dbc6-98a1-4682-97ca-e2f76c81a178@intel.com>
Date: Fri, 23 Aug 2024 14:34:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused
 __UNUSED_NETIF_F_1
To: Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
 <20240821150700.1760518-3-aleksander.lobakin@intel.com>
 <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
 <fc659137-c6f0-42bf-8af3-56f4f0deae1b@intel.com>
 <CANn89i+qJa8FSwdxkK76NSz2Wi4OxP56edFmJ14Zok8BpYQFjQ@mail.gmail.com>
 <d080d3a6-3fdd-4edc-ae66-a576243ab3f0@intel.com>
 <20240822163129.0982128f@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240822163129.0982128f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0138.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: bac2b202-e70c-4525-6fa3-08dcc36fe83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXg0Ni9RdlZhSHcvRENKRHZyQngvcVoycWpWUTdJd3huNy9SRDRhbDF3NTRQ?=
 =?utf-8?B?UisxWlByUE9MTWc5SEhiS3JBZXZuTGQ1QkEyNjVTV2htYW0vQ0IvZm5kT1pE?=
 =?utf-8?B?MFRMNFowYzZ1NFlwL0RlNTdqaE4vZDExZjcwdTdTcUJrbUJPS2pBVCtEdFJU?=
 =?utf-8?B?d0ZmOE00NE54YSs3ZzFEWS8wamk0dXFZMjdSZit2eHBTcXNNc3FSa1R6Sjdj?=
 =?utf-8?B?by9WenBhUVNrUElrMmlPTHY4K3U4ZG0weFNXcTNpSlJQRzhuYUp4bGQ2VXNE?=
 =?utf-8?B?NzFKbUh5LzhiSHkyL0hKVFRvV0JuMTlTYkM3VGRsdWJoR2Q3REg1elZkVnBq?=
 =?utf-8?B?Wjd2SFJwQVgyRzNzMm5SMm0wRnk4bGRndXJ6UkRrWlRyN25QWDNiU0RxNitu?=
 =?utf-8?B?Sk5VWGx3RXEzV0NJOHY4cStEK25HVGNUYnMvdjZaOFgzWGJqOXE5WHBXcTlM?=
 =?utf-8?B?RXovMUV6UXNmelp6QXNZaXRKUDE0akJIMTdNSEFKUytNeXp1bmpiVURJRW45?=
 =?utf-8?B?Sm81azFHNFc4NFRHMDNOK2lSbTM3Q0VWNUN5eDlGWUFUdmh1REx4UHl2VGhT?=
 =?utf-8?B?VDV6bWRVK0lRNnFaY1MvVTRNTTNsQ2g1RnFaYkh6RnBKSXFiblZwVmxWWlNo?=
 =?utf-8?B?c0NsbFZ3UGZBWTFUdUduU0o0c2JId3JZMzhyQ29rcGRvK3J2WUdKL29Dbm5N?=
 =?utf-8?B?b1lIT01MNnhwV2NmSkQ4R2N2emd2bWJ2ZHQvVkROVlJDYUtWV1hNVFFVMUQ1?=
 =?utf-8?B?NVlnbC82OUNUeG1PVGZoTTYxcnJML0tIRFNUWE5FUVRsRU5rbUd2OG5nSGl1?=
 =?utf-8?B?YmFKWmhaQXBOeXhrM3ZqZzZrOFliZE1KTTU1SXVRbEpwNVNEM0tScGdZMFVq?=
 =?utf-8?B?VzFQNEJYVEIvSHg4OVhCQlBRVGhoOW1tNFJiWkxhTm5xQ1FjcXByMjhkRnV2?=
 =?utf-8?B?Vys0M2lmZ0ZBYll1UFdwbkY3THBKRFg2QUg4ZDMwYnkzeWZkOHdrV29wSkF0?=
 =?utf-8?B?T1Eybm84S0NsUStxTGZWQlJ5aFFaWi9IMGVFRXZOV2dkSDh1d3NIUC9CL1N4?=
 =?utf-8?B?eGpYeEpqR3EzeEdkTno3MjN2bndMdE9JNGxxOUF2cXdNSU4reEhORmRtdFBK?=
 =?utf-8?B?WFNSQ2lqUkhwU1ZjWkU1MlFSVEZNdDNidTV6MWtoZ0E1UENudkVnTkljanRB?=
 =?utf-8?B?UzNPR3Y4aWdSWWN3UHV2NEE0bklPYXpEeHh4R2kxNnVaRS9VRjJmZ0ZGTDVN?=
 =?utf-8?B?SWRQZXl5V0pxK3FXQy9BNXdMSkNFTVNlQkZRRGY4TVdjcWFEUk9xcy8za251?=
 =?utf-8?B?eWJqK24xMFA5OWdrUzQ5T0kvNEs2MXN0NmNDb1g1SEVMTnZvKzhGWkxYUVpN?=
 =?utf-8?B?U1FjVUJsS3BJQ0R3djM1aThQR0F6enJvVk9sa3RzRWFkT2R3QUpJeFI3cDZi?=
 =?utf-8?B?UEpGdXFpUEV3S0RxSjlmUXgwL25vci9YNUhVZ2dTTjBadmJlNG41QkdoWW1r?=
 =?utf-8?B?T3phNkdtWUsrcTZVVFVVVk95THRRVEVqaHFPMjZ5SnMyUG9yWE1OaDJJejBo?=
 =?utf-8?B?Z3BFdDNJRDltblB3QjdpWlNCV0VqYUVJQTUzOTBlTkNxcHlBb29DQ0ZMYTJp?=
 =?utf-8?B?dVhyMGI3QzZkNnZtK2RGRFRKKzFmOVdYS2ludHUrN2hGNHlKYVpHUGRWYlM0?=
 =?utf-8?B?ZG1Qd3o4d1lrSzVsZVRYb3dKTitSK0dBR01taEtGNWpVZjlxNkpiWUFNUUd6?=
 =?utf-8?B?aXNSVktFa3Q3ZFBaVTV0blVueXlxQnM0SDBTejFpUUd3V200M0NZODNmbkVh?=
 =?utf-8?B?cVF4blBuaTJTM3lDblhZdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUhYTjV1dWQ1MkxIcmM5MHJkUG95MmhWUFdsNlNuZnhXNFI3eFVpTXRpWFJX?=
 =?utf-8?B?azRYSlFybnU3RlhpR3k5bEtQYnZpMlo3SDFuZjB5VDVTY01jQTQwd2l1L1FF?=
 =?utf-8?B?R0pxMWZiZFpjbkNIbW4zV0k1cXBHeXNRZEk5T0FhRFplcGttQkxRc0wxVEtR?=
 =?utf-8?B?RjZxaXp3TWF3MW5xVmp1SmZ4VnpjNDNBQ0xKeGY4cFlVL2IrSjhreDIzQWpI?=
 =?utf-8?B?eVRhS1JqWFBNRTd4YTQzRFRBcEIxWUZSaXFwYzlXcTQwZ3Z5VUM1azlPSWVM?=
 =?utf-8?B?cnorcFU2dDkvKzVnZ2ZSNmpSZXhPTU04YjRweExpUktxbVAyQzdQaGVOUEdw?=
 =?utf-8?B?aUxsTk51SmhQZFR2T2tBRnpDSDR0UUJTUzk3R3lxQjl4TENLUk1GeEhrVnNt?=
 =?utf-8?B?eXpKSExLM1FOT2tZWTRWaUpjRVU3QmN3ZCtTV2l0a2lyNU9CVWdpdHNUc0ti?=
 =?utf-8?B?L25hVzlqOUVDVDJsN0dpSk9WSWZkaVh2S21Yc25xU245ZEVtU2o4eXF1YTdF?=
 =?utf-8?B?bDJEZ1kxSVVDRnJQRC9GWHFkYllpTDAwM1gyRExuMXRUcCtCclkyNXI4dWdX?=
 =?utf-8?B?bUhnRVNSMkliZXVraTN4WktxYmFXZ0RCSmlKY3lYRE82YnR1NWFmdVRxV2dk?=
 =?utf-8?B?dnhCbThibno5eWV3c1BuN3drTzN6K3RhNXdtZE9URzBKUDVTSlF1MDFOZXl0?=
 =?utf-8?B?c1BQVy9ZR0FqVHY0VklhWGhPNjJEc2JRdGlIL3FKck1iNVBNSnVXb0lJVHBT?=
 =?utf-8?B?Qm5GeVc1QjRHVXdmTUc4Z2hFZk5oUld1WDJ1cFNYWG5LK3FHSUFWQ3lIaHEx?=
 =?utf-8?B?QU9icm9OdkJucXJKNjNWbVB4VURJclh0NmdlTWdnL0ZGMTlnM2t6bFZPSTdN?=
 =?utf-8?B?a2Q2Q2UzRnhOSDYzZEljRCt2dnFNdzVvVWhmbVhpRS9JdTk1bFFGUHVzS1M4?=
 =?utf-8?B?d3NXR2R2SHZlU0J5TFRzNi80NkgwK0RsMUFDRU1pdEVRdFFTRGdLay9hbUt3?=
 =?utf-8?B?aFpoVHpwTHlnWVA1aHo5dmhmSjRWT3J6UUF2TEtpVlpzR2NYeC84eU1xTkZZ?=
 =?utf-8?B?MUN3UUU1ZU5oZkZpTGJrdzdTR3c5endKOGFyRmcweXNDZFhjaGhWN1pTRVlV?=
 =?utf-8?B?OFB5MENpS2hsTDF6Vlp4VDMxOUtpL0w4MTNmQXRQNVZmcUxSY2VQYjkwaE5p?=
 =?utf-8?B?Z2NvVVl5bmwxNEhiVk9UQTJ2NGV4M0ppL2ZxaEFpa0Uwa0hza05oNEhYMHZR?=
 =?utf-8?B?N2tiMHZPZkpDbFlLTVp0YW5oR3I2QVVSbU5CViswV1ZzVTVMMWNPNGVKdG1s?=
 =?utf-8?B?YTlSaHEvZC9pcERNcllrYkR0TjZKc0wxTGdQdmUva0dabCttMGZiNXRuREQv?=
 =?utf-8?B?WUlzbVJVRndPdENpVjg1V2R4TXl3T3d6QnVCRTNqbno4eWdrdmFubG5lT3lh?=
 =?utf-8?B?ZDdjK202aEZiZTR6cm82RmR6dVNvZzhPN1gvUzlScSs4dStSclVTV01LdGoy?=
 =?utf-8?B?ZnI0cHl3alNiYVhYMm00d1hmZFI3ZUw2K1J3dlUyM0RsclE0Zm1Ib1NONmZn?=
 =?utf-8?B?MDlFT3Mzazh0MUFZZEhYNUlwdHI3bkwzM01PK20yWDl1eUlqVE5yNE9HZGxZ?=
 =?utf-8?B?SnhCa1BMQy82SUhYbGFpeE9UbExHVUlDZkFGTk9kU2JsNVhEc2VDSHpSWURp?=
 =?utf-8?B?TjdHdCttOTkrTTYyV3NkcFhQSnhMSXpROTdUSkpIU05YUEYrRk9QQVF2TlFv?=
 =?utf-8?B?U1o2NjBWZHU1bm9RRGV4c3g3Wnk5blFGOUxyUlZES2hwNzVqVDg1d2VWNG9s?=
 =?utf-8?B?bzEvbjhnV2Y5T0llVG80M1dVcnRkejRXdmFsKys0MzhXVnB5UG0vQjhNZUJQ?=
 =?utf-8?B?UEZaNCszWnpDZlRwWldxM1F3S2RHek5tV2crV0pnQ3lnS2JhbjNtZkxMckJN?=
 =?utf-8?B?citkcDdFR3p0TWR1RzQ1dmpjV0RyWTc3bGROT0h2TUJlUHMrZ3Q5bFI3OGFT?=
 =?utf-8?B?Y3pTNTJGcXB0dHZvQzRFTHluZkEzMWQwb0k2ZVR6WGQvNGdrTUE4L2lZelJk?=
 =?utf-8?B?ZXdlT09aQ1l5amM0ZERqVEVBYUtKZTJIeU0zVmF5dWVGRVlDRFh1Tk5MR29O?=
 =?utf-8?B?RmpWTXhJNVdRK2tMTEtQc0hRZER6V1JpQldWSHIvTkxIa0JtazlYWFF3bVdw?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bac2b202-e70c-4525-6fa3-08dcc36fe83e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:34:18.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFZ8eWVstEFiLqv6yYYzH9ASHbi4XD0AllwySV99OwaY/9as0OQgX8nfmS9QmuoO2ZzBbETvvw3ogufkWSpIVtK7kMqoFuyoEjKKcvfEBLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 22 Aug 2024 16:31:29 -0700

> On Thu, 22 Aug 2024 18:19:24 +0200 Alexander Lobakin wrote:
>>> I was simply suggesting to correct the changelog, and make clear we
>>> need a recent enough ethtool.  
>>
>> Yeah I got it, thanks. Will reword.
>>
>>> We can not simply say that ethtool always supported the modern way
>>> (ETH_SS_FEATURES)  
>>
>> I didn't work with Linux at all back in 2011, so I didn't even know
>> there were older ways of handling this :D Always something to learn, nice.
> 
> Are we removing the bit definitions just for code cleanliness?

Uhm, no, to free more bits to be able to add new features.

> On one hand it may be good to make any potential breakage obvious,
> on the other we could avoid regressions if we stick to reserving 
> the bits, and reusing them, but the bits we don't delete could remain
> at their current position?

Hmm, sounds fine. IOW just rename all the bits I remove to
__UNUSED_NETIF_F_xx?

Thanks,
Olek

