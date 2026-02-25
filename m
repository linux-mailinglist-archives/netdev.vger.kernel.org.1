Return-Path: <netdev+bounces-260908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ACbHwrlnmkCXwQAu9opvQ
	(envelope-from <netdev+bounces-260908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:03:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FA2196F39
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9140E301DAD9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9974396D24;
	Wed, 25 Feb 2026 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5tv8Cni"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CC33D4F0;
	Wed, 25 Feb 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020973; cv=fail; b=DeBw9Of07OHHKWstaTqZcPxMyYmS/pm5t21Gel0w4z2m6MWyigYoVCln99ejlIYR16pqye8Jgc+N0gFBPMLGYTn24epWodLNf2qKGzTa0+a0AzG62QhMiMHvfIfdiAQOCKuQEkZEXORosihUyFESMQvddisXHv6nOPnkc5Aj/MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020973; c=relaxed/simple;
	bh=TUTO/8ChlOQ+NdrWaod1wvQK8tC8TfEitf3gcc4kUUQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6mHP4C7X2e++t2DbJns/43d1/9h3UbulG8j4rgQmxZp4jnKs/KG1Js7HMiFjr8l4+914UuIQGbNMBAwd8IA6mlniB1mSjoFZapv0l3UVpl+M8r1BvgbxFg0my6gWs9zXxYLB87IVeljGSmE8yB1MgM8S3QSC0miexmxi4Vtzyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5tv8Cni; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772020973; x=1803556973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TUTO/8ChlOQ+NdrWaod1wvQK8tC8TfEitf3gcc4kUUQ=;
  b=T5tv8CninEBsN0ieOCnvIwHcUu7v869yHtN6u+R3YgG57Ab0ya68W1q8
   jDW2ibhFLGs9RpcVfM8/XMj9BmcqOnDLC2Ku4UI/xqLZtGRLjHU5ejxqB
   jK11sSgbNZxiXKO3n4Wgy6gM+X6rzTdCFPNObR8pSKU/ojYmY2rmy4ZZh
   lGmNofcQFyk1Nk9Wfej2SZG0tqGsSUdpUjnO6Ya+z5R6/tQEJCcGnR3g0
   E9c8A5YST57xLDBtUo/DUTiQofnLbMvh+/De6ZPi94+LdZ6VjMkOOzw5e
   Oa2ho3OF8tMI0JwzrLsRVJIxlPjbBJEC0y99TXe0BOi25BuWsHmMUJLic
   Q==;
X-CSE-ConnectionGUID: rjcAtaptSFWcruys/XXYlg==
X-CSE-MsgGUID: XfiE6HB+QMyDbRc86gTs3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90471008"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="90471008"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 04:02:46 -0800
X-CSE-ConnectionGUID: ggLK5R4vQSCNmjbocgN1sA==
X-CSE-MsgGUID: dgv8ejkwRKq+wktfr+OBwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220707313"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 04:02:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 04:02:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 04:02:43 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 04:02:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5KW1eYiKcwIS4DPCQsypAmO2n6qe/8srsDEMhYia5JoelRMTM/f1ntfMYcbxYKRZ2ec+HkW2ZEE/fjTGExUzwkK2BU1yH9CYXk4UJBEPSpntpW+jfckiW/UmV/z3xjNudzbPNsIDe0Dpyt89jS3vqbERuyVfN5VahxiUtTHFVXPiFWidRa/U32YdLJ3R02rLxTC1vyV7iHO7lhL9zg1L7WSVVZDiTaqhNzy+XIqS4H/KWxjqLPLiEROsq0TYfFxJUF2Zl5M1aGwp+tHPR0Sj1Pp7A+zx84NlKCR25vDqDk7EstvUsefcBdFS3XIUuBq2rpNeq50Vzy1eDgcATNNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB4rOS0AjA86HV+adGMCj4BTgaAiBHGb8gWlLtiMQxo=;
 b=OvWj2LPqoVpIih88wnLTavDaBDE0ip/zn8alh7l9B8qVvJHdC1KldKh9kovHHyYgqS4ng8RrHtRIHdysDQhSSfcI9q3QeQ5wk1WFdIVXJEILPz4+oTcKZh3NxjoiGE7E1Jvz5ijAV0FLuKZmqDX71NYOQDGD6wmI5ovUEH8Mtr3+lZlBh7Xg7OxTdkdPtEUX5xitInbCOUu2jOFCODnu+1VPvdeeYvxGP9QUyF0bCLFNg+f/Xrm/nzaScKl9b1/CBMPjLMMQXmMVyEB5pIDDmPyXA6gaPfpVa0q1+zu0l+5DvyM8WZi5ESoKvIkxlS9ZneY2eFOgksQaO9EY4yjKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 12:02:41 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:02:40 +0000
Message-ID: <7e4e207b-e839-4cfd-941b-5bec7a9ebff4@intel.com>
Date: Wed, 25 Feb 2026 13:02:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/3] ice: use better bitmap API
To: Yury Norov <ynorov@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Yury Norov <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, Andrew Morton
	<akpm@linux-foundation.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: David Laight <david.laight.linux@gmail.com>
References: <20260225000007.255837-1-ynorov@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260225000007.255837-1-ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::36) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d1338f-af06-4dc2-ed71-08de7465c6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: C6eC4VEPukiU2EXUtX9mpveYWcC6mDwGKZfvaMgb2wprYIEG0yKF7p06gG9QcVRP5d69txsxULUBnd08WGpxuZfP30O3pwijKdo9jXYqBmuv3qr49Ki+VwDYRkLx6vBQk5Y8h0eQ9OJ+h6x1buLoCIYFmqh25LrzyC1Umk+cNi7e5KltYn/gcKThQeWaSM9lpG0P5Cc1C9hyF9mK7keG/eQZzFzdmjUeWik94A7VgEedtsGKey4SR0/Q8bJheycJL209KW8Rbc8iacbUSbfij241jjA0E83jfBFUHMGS1XQiXo9LyueyFsyoUhjWbvi/oi5T8PXk53oOnEc2LLTNObkYHnW6CjLTOsbHZZod7wSpQMwp2E8VJYvkUNo8I/ELy6P4CM+kggBNu8SHFZRub3W0IgNa97E2S+zSZofIPrI1m1DyuArFupM5LerrgzgJoDvtaFYc1/W1T3LduC8Shcj1/MAOYWxcMu2lv+qC/jWeFqE31G36ZIXVvH179wsJYHVuUIof3JH9Wukd+uwGcu/4jADnf3d9TRhT2Wx6BTx11c7qgoowNIWJBi77zJmhfDLziPO6+rBKXAtmbVStuv5CObyvjbK9OxSRGcrqeFPUrhhl4J/C0PO2cl5DOOAmNGSXt9bv3udPyXHWjBf4ndowBgvNJEfgofsedwq3piEe2ZI78leywye+96afbkCLJLcsTEPoNOvgZ3j01lcsn5sS1pg3S/HQQhK6Aaj77O/r1WSvjMaOlvl/OH3wiVEAXw+D5UxjfHd2DyMJhFjdCPXznc3LHNqX6uME20r/Q8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZyY1krdDZBaU5sVVFIRnJRajVscHEzU0pCdmlqaWV3dFNTL1FXVys1NFpt?=
 =?utf-8?B?bDI3VmpTaWg1dXRLMzJ6dGpzSjZyaFFsUEJnNWdzMjIxZmt3bDBSODNwNEQ1?=
 =?utf-8?B?ZlBpeUtwa2huRVNZanFEWUpJMWlvZm1udWdJQ0ovMVdjMVJRak1EckVJdGNN?=
 =?utf-8?B?WlZhZ3Bib0UvQjdpeHBSRnFkbE9RZzRwbEd5NVIxNWZoNitZMUxMbVRNTUtl?=
 =?utf-8?B?dmM4N2lSWjB2MjVoc2xQNGhSa1dWeWVPcVRhMkQ5cGVnbktXRDJ0UHlUa3Zk?=
 =?utf-8?B?WEpBTkJEWWZNM2Ftd3p0Nm9EbTBrVGw2eVFnMHNCeXlFSG5STE5ibGtXMGpE?=
 =?utf-8?B?ZytnZ2pWdHVRc3IxUzhIY0FDbGIyMStSUWc3ZnE2bS95RmQ5ckd5SFRuajNX?=
 =?utf-8?B?NFgwY2FpOGZHSkpBM1ZXdU9nY3dLd0pnMG53Umx2VnZjOXUxdXZpbjhkVDE3?=
 =?utf-8?B?Y1RLcGNvYXQ2b2c0dHF6THlreVUxZHU4cENxc21Sc3JIOVNWRWhSZ1hkdmpB?=
 =?utf-8?B?bzN5YUFPKyttYXBoajZBSzhXblJYUmZ4NGVLdWgzeDhMY0J0QVgrWEEvWXZi?=
 =?utf-8?B?MXdaai84Ny9OREp6czNSR2ZLY0V2VVJMaG1hMi8yR1hTTGdOWDFLckxrdVVS?=
 =?utf-8?B?Q0V6MjhYbDVwUS9lV01CWVFQd3duTlFaQ0lnUS9vSDREa2FyNU56TW9tdVAy?=
 =?utf-8?B?OGt3ZzZGVjYxTWtoT3RWWElabEJtdkUvVUVFL00zY0xEQ0tRS1F6L0NvYm1T?=
 =?utf-8?B?YW9xVnlHZ3lFSmJ0VVd6aEJFT0g0WTJGZnhwWWhMWHFGVnRIZ093WEhlZWJM?=
 =?utf-8?B?b2pSV21xdEhJVm01aDJsVnovRnZTM1kweGs0L1Fxd2pRbmV2amlnbFdVWWhD?=
 =?utf-8?B?U2l1QWcyYTI2STVOS3NHYUo0NzFyUENrYzdjQkJXajcvdHB3Z3NHbXR0QXQw?=
 =?utf-8?B?Qk8vc0FHTC93YSt1M1FNVzdyRjM1SStVd1ZRYVZKOVRRTGVSRHdPZkUxeE1V?=
 =?utf-8?B?YlM4T0pCRy9oNElmNHMxcE4wU20wU3kwQ2RJN213RnZxTDl2WkRBYlZyU3ls?=
 =?utf-8?B?TmppUlZJVVg5WG1QejVUaVdIUDJoUldFQmwrb2R6SGZ3TS84TzMwOWlnWGJT?=
 =?utf-8?B?aHprSlFjSXM0emp2QkxHd0ZlenRsejA2VFdUeHo0MTExbTA4VGtRd0lFMzlF?=
 =?utf-8?B?VTVWMGp2OWtwWEFOTXZEVnZSR1BPZktBM1c1R0YrRXRYQmVTUXVKMVltRVkw?=
 =?utf-8?B?MUsxaGtranVSYlQxWlphRjRHMm42ck9hRHYzMi9pME90VGJpZkE4SzVhT2Rt?=
 =?utf-8?B?Ympuai8reERkUVJSMWl4Yk5pZlM4V1MxdlhUclY2WVNRNUF6NXlTc1U0aW9w?=
 =?utf-8?B?K3RlQVJFZWVSYVlZVGIxalI3SkdEMTMrS1BhSkdGRCt0VmFQR20yMDIyNkVZ?=
 =?utf-8?B?dzd2OUpUNXdzeGZzcVV2b21GdEtlS0NvWmFXZURPcERvYWFRbGVBam8zQ3VO?=
 =?utf-8?B?eUdmT1dSTzNDc2RaT2h5UDUralBFV1hCM1RjSitmNkFITDh6SzNmYVg4a0NR?=
 =?utf-8?B?SVU1RXV2blRzSUtTbHFxVjZ6SzBkcndxcXAvT3VTcUJURFIyUERyRmJlT0RN?=
 =?utf-8?B?M3dvSkFWNjc0T3hXWUdPYUlMOWlTeXhuUGVEWXRFMFo5S1RwbDEwREVOL0pt?=
 =?utf-8?B?Q3VFS3Roc2xubE9ZcDdxS2srek1vTkJDRVJsb1RNejl2VUNBTGhTY0M5TThj?=
 =?utf-8?B?bXZlYTlYUTk3ZStkZ2ZCNTBsajZwVnZtbHpSWGRkQUJJR2hBc3ppdWRMbmRB?=
 =?utf-8?B?RElRTUNhTmtsRk43anNacnV2REc3UkV1Ynh6ZXFBR1llOHBHUjZTclUvaHZx?=
 =?utf-8?B?cEtSVDVJOWkveVdDOWl0ZlJoUko5VnIrVDZqTE9SdXJIVDJwSUY5Vk12cERo?=
 =?utf-8?B?RVdZekdOdHBSOEszaCtoT1NnNXB0NnllYWV1Q3ZhM3dwb2l0UWZMd2RJamNL?=
 =?utf-8?B?cis4d042MGF6WHBFTkFiSzRuN0l2VTdML1ZFS0tVV3FQQmNCcnlqTFF4cjNx?=
 =?utf-8?B?VFhMa0N1eVlDN1pFWDZTSi8wT2JhVlMvV2JaVGJQL05COEkyNmMyTWNJTlhW?=
 =?utf-8?B?RU56NTA0Qm5udFhKUjRMM2VNaWx5Y3ZnTGpFR2tXRjYwU2ZLd1JRN3Jqd2Fo?=
 =?utf-8?B?eEdOelZGUS9jdS9hcVJON3ptTXZNcVpXT1ZyUkV4N1gvY0U5dG5yMnlvaXhi?=
 =?utf-8?B?Wlp0dDA4aytNVE9ZV3ZkK0hsckFSd2lyK1p1ZlVaWFM2dzJtRDVlQnlEbVpk?=
 =?utf-8?B?R3dKVXBXRTVsbUVjcXJ5K21Udk5qUXJUUmFJU1ExM1dQeERidVQ1cDJsWFF6?=
 =?utf-8?Q?aH4AlbW76pEOH0cc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d1338f-af06-4dc2-ed71-08de7465c6b0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:02:40.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QeCKo/y6FAAhAoope1GwZ0TqIrcDG+1f8zZDnXAri7d1uq07nOJZQYfdfdAvRmIAm+n8cp5RpP9k3CInbUSxz2VwP50n5vvH0vQzN/NHME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260908-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rasmusvillemoes.dk,linux-foundation.org,lists.osuosl.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C4FA2196F39
X-Rspamd-Action: no action

On 2/25/26 01:00, Yury Norov wrote:
> Use better bitmap API where appropriate.
> 
> Original series:
> 
> https://lore.kernel.org/all/20251223162303.434659-1-yury.norov@gmail.com/
> 
> RESEND: rebase on top of v7.0-rc1
> 
> Yury Norov (3):
>    bitmap: introduce bitmap_weighted_xor()
>    ice: use bitmap_weighted_xor() in ice_find_free_recp_res_idx()

Thank you for working on better API.
Do you want this to go through intel, then netdev, tree?
Likely that would slow any future user, if you have already one in mind.

>    ice: use bitmap_empty() in ice_vf_has_no_qs_ena

For unrelated reasons I have one series that will possibly conflict
with your patch. Would prefer to not wait/block each other, so will
be best if we (Tony) just take this one (in case you will proceed
with the first two patches via your tree)

> 
>   drivers/net/ethernet/intel/ice/ice_switch.c |  4 +---
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c |  4 ++--
>   include/linux/bitmap.h                      | 14 ++++++++++++++
>   lib/bitmap.c                                |  7 +++++++
>   4 files changed, 24 insertions(+), 5 deletions(-)
> 


