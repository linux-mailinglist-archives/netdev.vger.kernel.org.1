Return-Path: <netdev+bounces-218331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23F1B3BFC4
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1284B3A7A24
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE0C2222A9;
	Fri, 29 Aug 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzxGWHMd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4F1FDA8E;
	Fri, 29 Aug 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482404; cv=fail; b=LnGf6VgrKaF7ClzzivEaY+8Z0qI3kyiRbOlJLj93rMXD3KvRZHSR8AXfJmzqHhhIWOt4Z1nwkp/JRbaF2E+1vO+DpEf+vfIMxoANsbR+Qd7vfE+nnAQiQdjry11vftttlFRU0EmJP9+b13wAXAb6oY2PJKoLvflWp+pCpLMoB1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482404; c=relaxed/simple;
	bh=JuvkCKdzb+Jq4prItLAYFEaJPJ8uWTvFBfEpCiDpf3U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCGI5oF7JwPWMsmcx/3rN3OI7BZV1wRd3aZ6+CgdAxl+BU5kjkRTMVwBPm/O/CMdV2YjRz/aQAZ1nNwlRXbDn2/vEqLwxm8FUdSgy+6LrxrXNHdRZkiLgzdF8UwjdWn1B9R7L4v7q9W1U1HBjq+R6QQOyzu+AKYgobkjlldDGhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzxGWHMd; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756482402; x=1788018402;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JuvkCKdzb+Jq4prItLAYFEaJPJ8uWTvFBfEpCiDpf3U=;
  b=fzxGWHMdhY36DWY0RbuapazN2LNunARcsmJ7L2QsbL3cBAGmuRTcjK8n
   7p7/a9iumjjIc4GgSaPhylaInzDEmXlITlmjC6HEo6wGfRKCMoHjBWW99
   HAZOrClpGmKAT6PRNixUVzH/9I8UfgZ6GoWRbKd8133hkK2x/39OiM9FG
   RF8Kt7zYfOk2TtsRDxy9XirG4tbPwLXB0VBRta0KcqIIEGjCb0g/DiFMj
   MAue/mg0TSNVbn0kRUd07JVSzlIycR5CKoq0LRu1TnXdMO7CjFuNGQs9A
   wpWa0ha+cM0pHsDEb7yMYeLafskps9RZf1bJL2YTuTBYLrc+jz+ZL843+
   g==;
X-CSE-ConnectionGUID: 2gmH03rVRWGCSYuBtnOtgg==
X-CSE-MsgGUID: ZAsJQijrT1O+zUnzK88Cnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62604962"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62604962"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 08:46:41 -0700
X-CSE-ConnectionGUID: NWfZ+QhuQtSuuMQAizXdIg==
X-CSE-MsgGUID: 8bYi2WW8T46jV/DN8V1AKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="171203971"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 08:46:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 08:46:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 08:46:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.79)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 08:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hA1LYhs27DRyFpZDDBdpVfektn0MDHgvJTlEdQf1JddPIM7DUakqSBwzN8TcPFShGVFgEDYqCz+4BXLTDei1+s4wPCCu7AJk/j1U5iHRPorl01k2dDHuuesMg9S7aSpdZHtjnfZ2UT/d6smv3HfslVpbZ+ulIqmJKSi3BzeE2x10dfcWeUoY46YYKkjg72Fp7/ufJWT5OcVQppQqLv7CgQ93Gp4LtR9wp3Q+DrePodhJour4Ynfk0KzRALCczKphxswkLQq3G9qNngysEw+f9QS4tYoOdhIXWiPCcOo8MQ95hLJqTQ0o6Q/VUpihHi/GebGiV/t4otoy+kpqAivteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anqlYnZKeCTREbuggymfH2BjPIyQ49/DJJkQ7ybOxxA=;
 b=j3MQP03zscoAkMiYWE9rHjWWMq2IRWPJu51RlkEBXXkWVykVURLhtVF/Pkc9R+kKvjkZ6MPh90DbI/e/YsVv68zzuNrDD9d2KmeZeF17A7YBwr2ensQxFVLEKBN0SJ7lH+1NjMLV7ztmp/pNJ7ggtzKdDpmECtEGV04JfVSmT18JorYtPdJmHMg0Pr17vbafujmo7L7Rq2NHCdpPGKu2eKfa24GO5qePqGZ5HoOBeIYHs/ZHqMGrdoxuBwwll3UBtFSiY1xIETiVzSO1P3islSI495jUwKCQpE3H5vsO/705JxHTopdxA6KyFElfKJx8f6IziDkreuRdyueLwdrvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB9479.namprd11.prod.outlook.com (2603:10b6:8:296::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 29 Aug
 2025 15:46:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 15:46:33 +0000
Message-ID: <18594f40-f86f-4a28-a97a-22d8d8b614b6@intel.com>
Date: Fri, 29 Aug 2025 17:46:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for
 cleanup
To: Yue Haibing <yuehaibing@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250829100946.3570871-1-yuehaibing@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250829100946.3570871-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b444eb9-683e-461d-c77f-08dde7133ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE5yUU1pM3ptN1c5UStCeGVkVUY0dmx3cFliTzFvK0hqSks1WXV3RGRjTmNw?=
 =?utf-8?B?OUlhV1B5bmt4WFVvUTBJN3NSYXJhMTFCUVllMENtbVEwOENURU9CbzZGVzV1?=
 =?utf-8?B?NFVFc1UvVjVmTzdGeDVMNEZNL0ZJOGw2b3hNeVVIWk9iTUE2Nzg2OXdoV0I3?=
 =?utf-8?B?WlRDdHVLdWZOcUp5L1FGRDZNeUFHek9iV0FodmJhOE81RUdPYmZzbG9yU2J2?=
 =?utf-8?B?MHZoK1haOXByWE5XWFdSVmhKWFVHNVRzTzdKNFdIMlpMR3BOajJRUmMzNU1Q?=
 =?utf-8?B?T1p6bTNlT2xRS1JLd3YrNUNhKzN6dU43MGQwZ1c1Q2RqTVZnNmFHRGxJYnZn?=
 =?utf-8?B?YVdTRWtxTkRRSFFFV3o4MzJZZkhBQzVlWDRCTFlvRFJSbjFuWTJibG01ZUhk?=
 =?utf-8?B?UExuSHdUZjNtdDduQlNsajg0bmpTOWE2WnFlanNYUG04Y3pKY1VsTHRyQ0hP?=
 =?utf-8?B?ZkpRaGJMQU1iSktwbi9pZVlPNXRaeVBPRy9uVmNhQnl3Sm5NWFFhOXQxOG9q?=
 =?utf-8?B?N2dvNDBrc0x5Sk5nbElmWnNmRUFXdFp4Y2swUFZldEJpbzJVc0FUSUFkSEgv?=
 =?utf-8?B?TEZncmQzcVlLQk1CWlBUaC9zRzZLNHZXa01DS2tHOU4zdXBvTzlrWi9peVc3?=
 =?utf-8?B?RG5HeEVHTXZwaFNJSi94ejA1V01yTVNjUHE2NkpQMGw4MUpHNU00VmVYY09M?=
 =?utf-8?B?RUtkMk5tVVVuMEJXNk5oQkNqZytocWYrbjJvSFJMeXdELys1VUY3NkpINlVk?=
 =?utf-8?B?TExVblp2bDRjdlFyT1ArbDNVQlpyZm5PT3RsTkV5Zi9yckVEY09VWnc4b0ow?=
 =?utf-8?B?VDZWY1hWUGxvTDdPcitvOFVrdzZWZXVhRXl6blpqbkF5eXYwazQ3a0RlSks1?=
 =?utf-8?B?MW1qcmVNU2RiTHRHM0huVW9EZjY4L1lFU21PSzVSRURQaU5wZXU1ZUx5RG1W?=
 =?utf-8?B?T1VrM1QzMStJdVJDbkJpcUJHVGlwZE1uQW9oMUFaUHppdHBzOUVvYUs5WE1I?=
 =?utf-8?B?SURCSU5YS0F4TkNjb1cyUU1LSkNwTVF5WVhvVWJ3bmtEanNjclFmMmNlZUUv?=
 =?utf-8?B?aVRXY28zSzFhWHBGTHRLVHVweGJWY3IwOC8yZVpoSEVGSDAzOTk0SUZtMHJq?=
 =?utf-8?B?c0wwSDFncTAvMDhBcVI5cG1tdUhSdFVuM1VIb1hlaUo3ME1mL1o5YXZUZDk3?=
 =?utf-8?B?ekdzaEU4eHlCSzBFeUNFdFRGM1E1T3pKNVlOZ3hHYUJrMk1pWEZRcmVIRnAv?=
 =?utf-8?B?UkZJMWlUTWk5ZnRSWEdBRWRja3NEeW4yOVdWSmxwMnZTTFhwa0pTZHhJSDA3?=
 =?utf-8?B?TlVRMHNNVVNvN1c5UnpJRTRMYjFxdDhPZTR3TUs3NUNjQ2h3bEt1Y1h0RlpT?=
 =?utf-8?B?dnoxaUVKMzJGSDRNV0N4eXpxU3B1RE9STFA5YlNYOXg4VkM4Q01OS1lKMW1E?=
 =?utf-8?B?T0ZVcFMvTmFSYnhFU2lBbmwrcnFwK3JHVksxYk9zTGJENlhiUjl2S1hZQ0pS?=
 =?utf-8?B?cHk3KzlrYjhwcGlxak8rVzU4Z1liQUZGeXdCQndnaXdBcU1KdlZKN1Zaa1BO?=
 =?utf-8?B?NnBHdWJKNmRCSXZhUHVwSGhHZUdVMTJWTjBMb2VZc0RvQmdEQ0c0cTN5OG9P?=
 =?utf-8?B?MVYyVDFLTEl0VENQMkE4c3FjdHVDVlQ5cGpZeW9OalR0N1NFbnNSODMzRTQ5?=
 =?utf-8?B?RW1JWDRaaUNjeU0yNmloWkd0cysrUzFIUFFNL3ZMMW9sZElCc0NhVEZsVHlJ?=
 =?utf-8?B?VXpGVUg1VWMzWEZKNzkrWkxUR1FuTElnS0Z6QSt4ZjJyczNCaUh1REZkdVl4?=
 =?utf-8?B?YTlPRVFsTUxwY3Jpa2tTTyt1UHg4RGVmaGg1VGo0clhUQVhZc1ZPV3RkUHVK?=
 =?utf-8?B?NHJ3U3JQb0pOZHhMZlROOFROL3BTTjBERnpsNnlvMEoyU3hWUDNoS1ZGaitB?=
 =?utf-8?Q?IYzNWnMZJdo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnMyM2pOUkFIbHlndTBZWVM2MkF0QlJKSGJyTzhHSDlPZGhEY2pLL2pOVHBt?=
 =?utf-8?B?MHBYanZ5bVpEVUNBVEw5NS9zM3UwbUlFOFowNFFudk5uUDU5S29tYXcxcFJm?=
 =?utf-8?B?ZUZmM3Y2TzZMbkpPaWtBUFJEenY0Q3FFTHhyZTNKVUNjbk1ZN3ZrRUtvT2xI?=
 =?utf-8?B?YjRienh6dWhnTmhYZFdyOEhnaTZ0QUJmSEpKMFdXS2VERm54SnUzemdyZVYr?=
 =?utf-8?B?TDRoK05LRjZRNGRIcmRucWsza1RJejhvWG9SdlJEektjcDlEUEkyRzNiNHhu?=
 =?utf-8?B?TlFZYmJHZVlTeU1qdHdYeHd6dVMxZEdqanNFUEc4VTRlbmI3cjZDZnFPN0g0?=
 =?utf-8?B?MkNvdjdTYlBpbmtlY1F5Tm8zRW8wSWpDR0hEQTFkK1B6aTRjVU9JT0hkR0M2?=
 =?utf-8?B?Y3BOc0dydTJ0dW8yWUExNEZvZkRhZGNVQ3o3WGoyczl3UjZraUZtQTh5WnFO?=
 =?utf-8?B?MmljTDdRMXBaN2dldHhoOXRRRnFBNVJ2Z2x3M0FZK1dSaVM0UzdZTGhWOWNz?=
 =?utf-8?B?NTREdEk0ek1oYSszc1NYSzVnQVFtb0NxT3F3L2M1R0d6VnpKRnpWR2tZT2NM?=
 =?utf-8?B?eEF4cHhjSlZ1UFZMMVE5a1laL2Mwd20rUXltWjQyOG9uL0JaT3ExM2hTeFpF?=
 =?utf-8?B?eXZZM3FKT2FhOWlxWkhtNlB3R2hUbzZYK2dxYUxrS2REZzJlUTVLNmtiQk5E?=
 =?utf-8?B?NjlGa2NDTTE1cjY0K1FIYTlVYnJwYXpBVkVRcHQwS0UxUW1FVzd0UDRnS09q?=
 =?utf-8?B?VnNoTE13SE5vY0t4b1d3T1ZxeVpFaDZ0MVJpSERDZXdBbEp2ekQxcFhpU1Vq?=
 =?utf-8?B?bDFRejN2S3VaQmVTNEhIM0V4OVJIMzlHdGUzZS9SUTM5WkxZUC9wV21GU0tq?=
 =?utf-8?B?MElwazRUNldaWFczeEY3WnBYOGZvemZTb0pRR3JVV251N1dMVE91ZTFjcE5X?=
 =?utf-8?B?NmhxdGorS1dmb25XSDBPelg5OVY1SU5JQUlTa1Jpclp5ZXJsNlBSUkhmVWlV?=
 =?utf-8?B?WUxkb2dFMWNoTlQ4c0MwRG9zOGpBYU43Y29lenpETjdQKy9XUGJRQ0grZzcz?=
 =?utf-8?B?SVc0OFV2OGVrT2xMSVdxK2JvWFREY0NxV2pxcFQ3cXRiV0NTaWdHQXZnQlA1?=
 =?utf-8?B?bkM3Wit0blpBTEQxM056SmxOcFlxUUJiN3J1NXYzbXE1K3c1cUIyU3Q4RE1L?=
 =?utf-8?B?aEw4aVQzR3lxeW9HMS9wc0cweEg0Q3R4RjNKcjRYU1dwZjEvMzNxUmdJVlBt?=
 =?utf-8?B?ek9obkQ2QjhDbDdkcHVhb1U4bnVYT0NPTGVEOXNQUXV4YnZwUFlmTHFQdkZG?=
 =?utf-8?B?TDNNdHlmNVBrQ3FGVVJYNlg5cWQwcngrM29WQUJjLzc2b0ExTU5ZcDY2Qmlx?=
 =?utf-8?B?UkM5Z2p3SE4xUlJpalpsVWxBWHY4N3JHRS9iQS8xK0hUc2pmcjYwR3ZCTUsz?=
 =?utf-8?B?dEtSYUR3UnVVYnAzMGJwZ011K2Z1UUViUFpYZHd0cXNBQmM3K0xLM1BvZVdQ?=
 =?utf-8?B?N2x2WGRRNFc0ZUVIWU15MUFXRkdEM0huM21pUWRTVTl0SWNzSUd5NkhyUUdD?=
 =?utf-8?B?M0NjVWhoZ09SdlVtUFBxN1kvWWxnTm9zd1A0ZEJYaHhWT3cveDJ4R0g1QzJt?=
 =?utf-8?B?N2RFdVFreVFwbEpvSUgzZ3l2WWpXY2VHdzZXTEVvekJ4VVI2SDVLNW03WFVO?=
 =?utf-8?B?aFFTd2dVeCtUcmI0OXZ3MEhhRXkzVk1WQTdGelk1UURxSjdhekdxNE0vVWFt?=
 =?utf-8?B?RXRJbGRjZXJWQjJ1SWVOQUUxYUV3UTNBOUxES3I5aXFmZ3p6V1E0Nmg0UFlq?=
 =?utf-8?B?U2FyQWNLU3Y4V0ozUmttcktnaFBBS3liMGpnbWhPOGhSaXk5bDhjajJwOHRS?=
 =?utf-8?B?bjJHcExQMXFTZHhmb0tsWVltNlJER2RTbWpOSzlndHU5YUt2ZUp2b2t4amR6?=
 =?utf-8?B?N3lHeEJENzdkT3ZFYzJMM1FEbnVKU0xSc0ZTUE1YNUtHdkxQOVdqMmRQZVV0?=
 =?utf-8?B?R0RlSEpCUGJyblRqcVlZcFAvUG5OdXV0WHRaUHVLTG0xN0RiRE5yVlR4bGtU?=
 =?utf-8?B?c29DNXJvQXVud2dCMXhTL1dHYlRkeWRQUmh0NkpTRVA3N2NnTUN5N2hLSndW?=
 =?utf-8?B?dnczZXZlbGxmOEt6THNHRHN1T3dEaGkvdHNYMDlzQUFQM3Z3STYyRWFZV0F5?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b444eb9-683e-461d-c77f-08dde7133ac8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 15:46:33.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KhNOhKlR5AZ2ifGLz3+HZ3fQY62Ge357+9L7V1WQFMHuzg1Sb2SbA5dy9fA++WAvICT+yKoA924pYkJx5G1rzjfFc0wr6TVrcE9A1wcGXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9479
X-OriginatorOrg: intel.com

From: Yue Haibing <yuehaibing@huawei.com>
Date: Fri, 29 Aug 2025 18:09:46 +0800

> Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
> ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.
> No functional change intended.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> 
> On a x86_64, with allmodconfig object size is also reduced:
> 
> ./scripts/bloat-o-meter net/ipv6/sit.o net/ipv6/sit-new.o
> add/remove: 5/3 grow/shrink: 3/4 up/down: 1841/-2275 (-434)
> Function                                     old     new   delta
> ipip6_tunnel_dst_find                          -    1697   +1697
> __pfx_ipip6_tunnel_dst_find                    -      64     +64
> __UNIQUE_ID_modinfo2094                        -      43     +43
> ipip6_tunnel_xmit.isra.cold                   79      88      +9
> __UNIQUE_ID_modinfo2096                       12      20      +8
> __UNIQUE_ID___addressable_init_module2092       -       8      +8
> __UNIQUE_ID___addressable_cleanup_module2093       -       8      +8
> __func__                                      55      59      +4
> __UNIQUE_ID_modinfo2097                       20      18      -2
> __UNIQUE_ID___addressable_init_module2093       8       -      -8
> __UNIQUE_ID___addressable_cleanup_module2094       8       -      -8
> __UNIQUE_ID_modinfo2098                       18       -     -18
> __UNIQUE_ID_modinfo2095                       43      12     -31
> descriptor                                   112      56     -56
> ipip6_tunnel_xmit.isra                      9910    7758   -2152
> Total: Before=72537, After=72103, chg -0.60%
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: add newlines before return in ipip6_tunnel_dst_find()
>     add bloat-o-meter info in commit log
> ---
>  net/ipv6/sit.c | 95 ++++++++++++++++++++++++--------------------------
>  1 file changed, 45 insertions(+), 50 deletions(-)
> 
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 12496ba1b7d4..60bd7f01fa09 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -848,6 +848,49 @@ static inline __be32 try_6rd(struct ip_tunnel *tunnel,
>  	return dst;
>  }
>  
> +static bool ipip6_tunnel_dst_find(struct sk_buff *skb, __be32 *dst,
> +				  bool is_isatap)
> +{
> +	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
> +	struct neighbour *neigh = NULL;
> +	const struct in6_addr *addr6;
> +	bool found = false;
> +	int addr_type;
> +
> +	if (skb_dst(skb))
> +		neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
> +
> +	if (!neigh) {
> +		net_dbg_ratelimited("nexthop == NULL\n");
> +		return false;
> +	}
> +
> +	addr6 = (const struct in6_addr *)&neigh->primary_key;
> +	addr_type = ipv6_addr_type(addr6);
> +
> +	if (is_isatap) {
> +		if ((addr_type & IPV6_ADDR_UNICAST) &&
> +		    ipv6_addr_is_isatap(addr6)) {
> +			*dst = addr6->s6_addr32[3];
> +			found = true;
> +		}
> +	} else {
> +		if (addr_type == IPV6_ADDR_ANY) {
> +			addr6 = &ipv6_hdr(skb)->daddr;
> +			addr_type = ipv6_addr_type(addr6);
> +		}
> +
> +		if ((addr_type & IPV6_ADDR_COMPATv4) != 0) {
> +			*dst = addr6->s6_addr32[3];
> +			found = true;
> +		}
> +	}
> +
> +	neigh_release(neigh);
> +
> +	return found;
> +}
> +
>  /*
>   *	This function assumes it is being called from dev_queue_xmit()
>   *	and that skb is filled properly by that function.
> @@ -867,8 +910,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>  	__be32 dst = tiph->daddr;
>  	struct flowi4 fl4;
>  	int    mtu;
> -	const struct in6_addr *addr6;
> -	int addr_type;
>  	u8 ttl;
>  	u8 protocol = IPPROTO_IPV6;
>  	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
> @@ -878,28 +919,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>  
>  	/* ISATAP (RFC4214) - must come before 6to4 */
>  	if (dev->priv_flags & IFF_ISATAP) {
> -		struct neighbour *neigh = NULL;
> -		bool do_tx_error = false;
> -
> -		if (skb_dst(skb))
> -			neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
> -
> -		if (!neigh) {
> -			net_dbg_ratelimited("nexthop == NULL\n");
> -			goto tx_error;
> -		}
> -
> -		addr6 = (const struct in6_addr *)&neigh->primary_key;
> -		addr_type = ipv6_addr_type(addr6);
> -
> -		if ((addr_type & IPV6_ADDR_UNICAST) &&
> -		     ipv6_addr_is_isatap(addr6))
> -			dst = addr6->s6_addr32[3];
> -		else
> -			do_tx_error = true;
> -
> -		neigh_release(neigh);
> -		if (do_tx_error)
> +		if (!ipip6_tunnel_dst_find(skb, &dst, true))
>  			goto tx_error;
>  	}

Ooops, sorry that I didn't notice that before.
You can flatten the conditions now:

	if ((dev->priv_flags & IFF_ISATAP) &&
	    !ipip6_tunnel_dst_find(skb, &dst, true))
		goto tx_error;

>  
> @@ -907,32 +927,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>  		dst = try_6rd(tunnel, &iph6->daddr);
>  
>  	if (!dst) {
> -		struct neighbour *neigh = NULL;
> -		bool do_tx_error = false;
> -
> -		if (skb_dst(skb))
> -			neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
> -
> -		if (!neigh) {
> -			net_dbg_ratelimited("nexthop == NULL\n");
> -			goto tx_error;
> -		}
> -
> -		addr6 = (const struct in6_addr *)&neigh->primary_key;
> -		addr_type = ipv6_addr_type(addr6);
> -
> -		if (addr_type == IPV6_ADDR_ANY) {
> -			addr6 = &ipv6_hdr(skb)->daddr;
> -			addr_type = ipv6_addr_type(addr6);
> -		}
> -
> -		if ((addr_type & IPV6_ADDR_COMPATv4) != 0)
> -			dst = addr6->s6_addr32[3];
> -		else
> -			do_tx_error = true;
> -
> -		neigh_release(neigh);
> -		if (do_tx_error)
> +		if (!ipip6_tunnel_dst_find(skb, &dst, false))
>  			goto tx_error;
>  	}

Same here:

	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
		goto tx_error;

Thanks,
Olek

