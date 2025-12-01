Return-Path: <netdev+bounces-243075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9FC993C5
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229283A5866
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1655280A56;
	Mon,  1 Dec 2025 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qqc5St3n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10723EA9D
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625448; cv=fail; b=T35t3oT/OeajkcFDnC0/FH1T3/YyR4A1IEsWl2P1ud6qIAO/WkzwWEFqyTprTqdeMJ+nfa9Hf2R2N9xi8oDk1MT6y+IrGlQrd2nd3PDYm0+yDuGt9Tk7hWOIpDyB/ZgQXIOnvNJRq6yoOKo1MXb58Tl/Zt4TcKA4Ymwt8+pXA70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625448; c=relaxed/simple;
	bh=R8JfsUDLd8jJmxls4kJb5TJN6UfhlAjqcRyyN15Rx7k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hDoRvxFeWmWHbdoN1NE81AvBiPWCOOPDyQwdAG90z7RPF4blt3VKY28bCacSLFlm1f30r0nrE1A2KnYUNnr95bmRP0bnQ87BKXY6lLyqZbY3oAac8Cdh/L0UyDZHJ5RmwMAaPD09rVnG2n4SlmPZ1evXkBfCpZdOGyknGSlDnqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qqc5St3n; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764625446; x=1796161446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R8JfsUDLd8jJmxls4kJb5TJN6UfhlAjqcRyyN15Rx7k=;
  b=Qqc5St3nvqpxK2GhatAz8W4nOvK+OF1OHlskq21O5J47ZMQ12535vLok
   Ygdnvv7pGRIXvPmetu7JU6m0sQGLp35/tsfFni9HwPFjZh15azExjjOqE
   sYd63DtWG+A5ME+1HnIQmx+KbaKiNwsVkFtT24I0rljZdo4T8EbNalAaw
   txjYSMIQMK3ISUKGa+lmN5XllnkBExxDGyDcAkc31WKK+o+ibqLMbUpQH
   Hg4xYg74zast8bs1GZ3o02rPmT2UUPHoaBVDEi+kIQKZIchSxzjpKw/l0
   WDYjzjnD5Ohri4GSyn3yofdwuLsJ6wLuWLDWQ0EnIHy0ixmTL7EzPjZUp
   w==;
X-CSE-ConnectionGUID: 2Ab8LFI1Q7aZERPSL4eiTg==
X-CSE-MsgGUID: srLBF31JTt2sPZ32XShUsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="70437791"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="70437791"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:44:06 -0800
X-CSE-ConnectionGUID: MaGfHxkbQy6Rx3LFV9E9zw==
X-CSE-MsgGUID: eKpgGbk4TiOf61Bur9iLtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194626518"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:44:06 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 13:44:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 13:44:05 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 13:44:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MceJwm/PPrRLyDaaXhpwPV67AdOw30w6XCm9Ya5wAqxX5x9WlR9LelC6GHUJeklqH7QpbJu+FiKBuZOGXLqCHEO33nFcwc5bm3T+C7z0jHr3FP6F1dpEdGj6Vy6MH//yyOJfNBtSZOiBOfN3o+8Juc9Kk0kP+gyy4l5M0d+Nr9ZfqdxGZTz4OkYq/WQeP1jh8x5SEnstLNVMVxdfJWeOoSGo0ahaqXwS6a2FR0t9pAUeauNR0Qmnnewy0cS0QIg46uj/Ich1agW1SWxm9FRxlDlEcVC18Z0NTR6Hnz3vjBcO5gYHD4otinyv5EVVc2eYfSTEh9lL5G6Y0CCcdGns+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlDelYmTdCC+Y6aZUPOjwCblObX8P5/vakpJ65Yo5QI=;
 b=T978fSki2dWjcvGolQPVdz/QgBg5nfvNQxXmO8D3gkJ0B1DaPLCGtXk3LkvngPyJRs+5px3hgWdfUGVR3je12mbUzJjkoQD45rCx8nuL3UTyd8K5yIMbplYraw5txNI//8AE59TJiSCi+OUtZd1YuuESzYM/XofZdgBYQ9dKIR7Bmc80NWpPjwn99eBgbOj96W64E9cRtIQ1D8siJAFp5e8D3QjohhNoGiVWE/jYKdmZ/CYkXoKLkIVnBlFnfmjer0M99dWmI3vm/kUHIF66jd7RpCp9hdZjvZYC+ZDIrU4lOT+TK7lyh4xGnqftM+IEyYpUVlH0wwX8ORFQq16oUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5690.namprd11.prod.outlook.com (2603:10b6:610:ed::9)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 21:44:04 +0000
Received: from CH0PR11MB5690.namprd11.prod.outlook.com
 ([fe80::6b98:f467:da49:e062]) by CH0PR11MB5690.namprd11.prod.outlook.com
 ([fe80::6b98:f467:da49:e062%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 21:44:04 +0000
Message-ID: <31f701e6-fbd3-4674-82ef-2f835d4a8b41@intel.com>
Date: Mon, 1 Dec 2025 13:44:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 5/5] idpf: fix error handling in the init_task
 on load
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<Aleksandr.Loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"decot@google.com" <decot@google.com>, "willemb@google.com"
	<willemb@google.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "iamvivekkumar@google.com"
	<iamvivekkumar@google.com>
References: <20251121001218.4565-1-emil.s.tantilov@intel.com>
 <20251121001218.4565-6-emil.s.tantilov@intel.com>
Content-Language: en-US
From: "Chittim, Madhu" <madhu.chittim@intel.com>
In-Reply-To: <20251121001218.4565-6-emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To CH0PR11MB5690.namprd11.prod.outlook.com
 (2603:10b6:610:ed::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5690:EE_|DM6PR11MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbd523f-f5d2-4bb9-813b-08de3122bf20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDFudmZ5RldvaWdNNW4rN3FuV3N1YW94bGpsbTZ4RSs1cjhUdU0wS1h0Si8x?=
 =?utf-8?B?VzVBejNISy9yaStrQm5meHVBY2xXVTFiOExYY1RvOUZTdkZmRUo0NUdXaFhD?=
 =?utf-8?B?MHhBNDJpeTA4T2pvRTVlbENTbFpzUldielpvQ05uNnRzc09TdDB5MHZNUXNy?=
 =?utf-8?B?VzVSTWd4RDhmbXA5TG9ZVTZ6VysxWUllN1cyV3Z3VTB1aW1tMGMwbktJSk5x?=
 =?utf-8?B?akh2cGh6UUU3eDNwemFvYlFTSWlmWGhKL3ZrOWFsV0ljYytldXFVSHFlZVJp?=
 =?utf-8?B?KzR4UWJ3Z3pTNjZHdVM5amhBZ1dOc2FtUUpYcWNOY0hCckFCNlkxd1hMaUxm?=
 =?utf-8?B?VzloaDd3VmxXWnJwQWpLbVErUjhXYXgyN2szVnJrMThsbmJqVDI3akpFNkVH?=
 =?utf-8?B?UVZLRE1CNDNmeDRFc3pSaDlnZ2RNQjdKT2NPZGJ0MkZQQjdmUTBZT1NmdEJ2?=
 =?utf-8?B?SGRoSkl3UGRhc09Md3NtTGxUWDY1ZmxqNzRkSHl6UW1iUDZYM3YrNkZhRTM5?=
 =?utf-8?B?TXh1cEZxV2s1NmVmQmNHYTNJVktNekUwNnljVlFMWVhGQUZiUlFvenBIL0h6?=
 =?utf-8?B?MW4zUlEyZXh6TzBXVEVxOG5Md1lzNWtub2ZpSkpCY3FMcW1RUGJjQkFiQXpS?=
 =?utf-8?B?aWFKOU1WaGRBcGdsNktCOHpIZ0NPWE1KOGtDTStQMS8zVE1WcExsY3EvUExs?=
 =?utf-8?B?RndwU00xNzBibGlnamZBUE1KRjNxdjk5NHptUEgxYWhjRm43UlZJVTNSWnNq?=
 =?utf-8?B?KzZpMDV1c0ZRNnQ2Y0EyMWJpZmtBZGZWeFQ4R1Q2MGVpYkNwcU02MFZPR01r?=
 =?utf-8?B?dXIxT2ZkWXhQbGcvaG9Ra2FhVmE5SW90a29MMFlGY0p4NFhyQ0lFVWRMcEQ4?=
 =?utf-8?B?ZWpxTEhpbkk3dUJRRVo0cS81ZldObmtBY2V2WFdXd2tESmFoVFpOSC9kRTFZ?=
 =?utf-8?B?d0pIOVNiRnpjcmRndlYyRVgwV0l4cll4Q3FRYzlIb2NNbW9GT3dZY2EyNXgz?=
 =?utf-8?B?ckFpa3o4dU42RUExTDAvVW54cWVQQUdNa01xVElzaTl6b3g5ZS9GMitBVW9j?=
 =?utf-8?B?My9NVmZHYmpmUnV3MDBtcTNod3ZKMS9YWTZjVXFmWk1lZzdGNDMyRjhYUG9D?=
 =?utf-8?B?eVZtMHJJWFVOQTMzS3JCVWY4b2VGNE0wbUI2VTR3djNrd252dmN1dDNTQVNP?=
 =?utf-8?B?SGxXQWZ5MUpRZXlacFZZN0RsMEhqdExhcWNsa3Y3dkRQSjlBT2R4ejluT2NZ?=
 =?utf-8?B?SVpuNVJlZmZXRnlrSWg0dnA5cTlBMFgxWVV5alFaS2l6c3hGMjY0dFlxZW44?=
 =?utf-8?B?UlVNSmNVZ3ZCbXBueEM1SzhON21iSThVZlR6ZWdBblE5Y2t5ZlRZQjlmcVRV?=
 =?utf-8?B?RWw3WXVzZENQTDJRM25XSkprWjZPMG8yUGVwV0hiR0V6VzFiSjJSWm1jVi8r?=
 =?utf-8?B?Q3gvU08wemhKR3pDYXhHUG8yZVpvSkM1V0dNQ2ZMdUppMFlMRjN4OGxUREE1?=
 =?utf-8?B?ckZaSGxBc0RCRENjWkpEKzBEUHFhRU40Z095THNLWUpQdzZvV2JxNlAyMDBL?=
 =?utf-8?B?TGdWQ1lENnhvWnVONk5rMzBlM0YwK2RMUDVQVUcvaElQbHZxUVFkQXZFU0ts?=
 =?utf-8?B?QkRlOUJoTk9PZTN0UzVuUEoxenFEdmJ5ZldPcnFmak5OS0tudGNTQVIzUHM3?=
 =?utf-8?B?NEpYZzZoTmV6VEtNNlBZeDRxUkdENUlray82M05US0F5NVlWQWxJd0VCMW5O?=
 =?utf-8?B?K0sxd0JyTkhmRE1BV2EyS2NDUWVIcFloL3o4c2owZkIvNVRtVk5HanNrT0RY?=
 =?utf-8?B?dU9lNkpuV0UyZi92WHYrU3ZUbk9GeE5GQmVKOXRRZTNBZWRQQlVoVGdpT0xO?=
 =?utf-8?B?djZ5aGVDSmZNZ0VLM0UwUDVSbmh0NkIwQXlRdlh6L3RmVi93VWZybTRxQThy?=
 =?utf-8?Q?BuOCnwJ7eART9z0bDAY8T346PUxm7Jdv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNjcDZpNGtrQTlIaUNpcUV6NnhLeDVORzFFM2R5N0I0R2N6Nm0rSHI4dlY5?=
 =?utf-8?B?WVY0U1dIRU5KOVV3SEg2WFF6azg4MHZWM0t5NG0vV1FVL2dMZ0hFTGRLSFEy?=
 =?utf-8?B?VUdEbEx5TGk0SHBHWk5GMEljMjlnQlVQUyt2eTBscWMvbjR4V3ZyeG0yUmlX?=
 =?utf-8?B?ejlzYnNPaEYxdGl6UWM0cndhTitLQngxcHUzSXluYSt5bTJNTFZrQzE0ZHJF?=
 =?utf-8?B?RzJQWlRlbVk0ZWpLOU5DQ3hZVWlSS1IvbElWUFdCaWtFcE1NY3hxKzVUdmxj?=
 =?utf-8?B?Nm1TdStYWjljM1h3aGpJSGVja0hNWndWMStlS2ROTEZMVnZuQzVZYVRwWHBk?=
 =?utf-8?B?c1FNRzhRYnpqeEJlU2QrbW1IczdyVXpqOEZwM3U2NStoSTQ3MHJZNGhGcEJ1?=
 =?utf-8?B?eUUxMkpWQnoyUmZJUm9GZzRiNEcyZzYwRDlWbEI5bWEwQmhDQjZ0WVhsdWs5?=
 =?utf-8?B?U1dFSXloZkx1b0N0VS9TYlNubmVCWGlFQkRTdHFtUGo1VGtBWitpdXZnQWIr?=
 =?utf-8?B?WVVUdGdQVzdwc3hqbDhTelh4aGRNREtQaGl3VHlaUGNHclFBWThEM29RNzJO?=
 =?utf-8?B?aHNuTGhKcldhV0EwaFFheURMTlJ4S0tuTXBON3pYa0JJbEtWejBzeExGY0JZ?=
 =?utf-8?B?U3ZXRVV2encvMnVxQnRTZ1hGRnJSV2dDRWVmRVJ2dCtjVlVweHpoeHZoZnl5?=
 =?utf-8?B?UXNuN3NuQ0UxSjdJTTBmMXR2ajRBUE5xVXFtU3FDQXJFamVOaHFKNTJkWlBo?=
 =?utf-8?B?R3B1NFVFUzU2K1JSamp1M0JDYk9PMUUyRnoyTFJyYzcvTmtsclYvSzJ1MHRP?=
 =?utf-8?B?SjM1MnVJWDFKQmhtdXErYVZBUktiN21OWXpnRTVnNEdYdHdab1ppalFQaWtL?=
 =?utf-8?B?YTlWTUVLWmFPQWZ1M0puMGZvY2tnNW5oSGY4OXJhM094Vk9DL3MySW5velRX?=
 =?utf-8?B?bWVRVCt5QlVEWHcxTzdPVCtZMzhpTXdSODJuc1BMZWNaamZjUG04L2F4ODBB?=
 =?utf-8?B?VnZjWU8zc0J1LzFuV0c5MjdqeElKbWlmdThqR3FvbEozV3lyNWxVZTNoQ3pG?=
 =?utf-8?B?Wi9XNnI4SVM3UWZWZ1ZWbHZZcldISTVDQkNGQm1DOWloZ3plL0lwU2hNcktx?=
 =?utf-8?B?cGNkeXZ0S0xZSnpnNHI2Nm1EOUd0Y0cyTlphQVpUdE81WEErSk1VZC9uemdP?=
 =?utf-8?B?dXVBOUJlUXJQNm1FZjMzSW5CRjNGSkhGM0d0TFpNaHJZTlMrUktKV2NKZVRv?=
 =?utf-8?B?WGNJWWloRU95cWdxeWtRdlkxL1ZZQ1hzU3pnZFFSRUgvZEd6Q1psSHZEWEFQ?=
 =?utf-8?B?NERyTyt3cFlKSDFrRy80SWRLL3o4Q09UTFowN096ZE0yYTBoUW4zTi81R1pY?=
 =?utf-8?B?U3ZWM3hOS2xmRFhDdUx2TEo2M2NnVDlkN2ZudnZMR3oya09odWlxalN3ZGIv?=
 =?utf-8?B?MW5EdVYyRWlkQ1c2SnRSdzUzZ05mZjlGL2ZzUHZWWDk2a1p4U1BubUJGd0Jz?=
 =?utf-8?B?U2hJK212NjFTMU01WDNiMjNKc3pBNG5IaWpwVTNSeVVhbUpJcmViTW05dHBX?=
 =?utf-8?B?RHpXNUFDSmc0YlBvWVY1SmxhU2JWM1VZa0x4MHhrdGRyVWtLbUM3bUdYaXpZ?=
 =?utf-8?B?ZUZCak9Rb0V6TTEzdlJJK1UyUU1LVEJoZTE4ZWs5YXlkbEVvNFJjNE0vMFVX?=
 =?utf-8?B?a1lJYzdjNU5MNFdvTHdsTzA4d1phbTBVM1dEYnNjV2MzdlBZcElBaXJjQ25V?=
 =?utf-8?B?WlppSk9MSlU1cW1zN0E1U1JsKzY0RS9zY0h6MjRHVTJSbTFYNEYvbE1odjBs?=
 =?utf-8?B?cXo4bURuVDB5bmJENHZrM2Q1TkhrcWtmTFhXVGxPc3AreWJldzZHYjNHYUpZ?=
 =?utf-8?B?ZWVHYm8xQUxrdll1YkYyelhYaWFmTStxQldzNkgzME9GVHpSazRTb09DM2xQ?=
 =?utf-8?B?RnpVaDRhTW16cGpGeWlYWVYrWDhoMjROcXlWMURqN0E5R3pnTnAwcnFBcTFx?=
 =?utf-8?B?bTl3TzBpK0hsQ2J2WTZRZlNDZ3R2RmV1LzFtVXh3NkF5SSswT2diVzN0dUpT?=
 =?utf-8?B?YUVSNEhCNC9zcWE5cUJqRGZjb3hMSTZRTTEvOVhSdHN3cDlGdmFCWkZlTHN4?=
 =?utf-8?B?L29QL0pYOTVxTUxyYWp4ZmxrNmFXRHRLWDNaMXhtcmdMWFgxSFF4RFdtbkYv?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbd523f-f5d2-4bb9-813b-08de3122bf20
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 21:44:04.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2iudynt4zi7mJhOT9sC+5vQRwGyCDPcS3X4ku47oPmJx11udQiY1qO6hfwm+1D7EbmLSvzQlFbdNmnZqjvpag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-OriginatorOrg: intel.com



On 11/20/2025 4:12 PM, Tantilov, Emil S wrote:
> If the init_task fails during a driver load, we end up without vports and
> netdevs, effectively failing the entire process. In that state a
> subsequent reset will result in a crash as the service task attempts to
> access uninitialized resources. Following trace is from an error in the
> init_task where the CREATE_VPORT (op 501) is rejected by the FW:
> 
> [40922.763136] idpf 0000:83:00.0: Device HW Reset initiated
> [40924.449797] idpf 0000:83:00.0: Transaction failed (op 501)
> [40958.148190] idpf 0000:83:00.0: HW reset detected
> [40958.161202] BUG: kernel NULL pointer dereference, address: 00000000000000a8
> ...
> [40958.168094] Workqueue: idpf-0000:83:00.0-vc_event idpf_vc_event_task [idpf]
> [40958.168865] RIP: 0010:idpf_vc_event_task+0x9b/0x350 [idpf]
> ...
> [40958.177932] Call Trace:
> [40958.178491]  <TASK>
> [40958.179040]  process_one_work+0x226/0x6d0
> [40958.179609]  worker_thread+0x19e/0x340
> [40958.180158]  ? __pfx_worker_thread+0x10/0x10
> [40958.180702]  kthread+0x10f/0x250
> [40958.181238]  ? __pfx_kthread+0x10/0x10
> [40958.181774]  ret_from_fork+0x251/0x2b0
> [40958.182307]  ? __pfx_kthread+0x10/0x10
> [40958.182834]  ret_from_fork_asm+0x1a/0x30
> [40958.183370]  </TASK>
> 
> Fix the error handling in the init_task to make sure the service and
> mailbox tasks are disabled if the error happens during load. These are
> started in idpf_vc_core_init(), which spawns the init_task and has no way
> of knowing if it failed. If the error happens on reset, following
> successful driver load, the tasks can still run, as that will allow the
> netdevs to attempt recovery through another reset. Stop the PTP callbacks
> either way as those will be restarted by the call to idpf_vc_core_init()
> during a successful reset.
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Reported-by: Vivek Kumar <iamvivekkumar@google.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>

> ---
>   drivers/net/ethernet/intel/idpf/idpf_lib.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 5193968c9bb1..89f3b46378c4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1716,10 +1716,9 @@ void idpf_init_task(struct work_struct *work)
>   		set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
>   	}
>   
> -	/* As all the required vports are created, clear the reset flag
> -	 * unconditionally here in case we were in reset and the link was down.
> -	 */
> +	/* Clear the reset and load bits as all vports are created */
>   	clear_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
> +	clear_bit(IDPF_HR_DRV_LOAD, adapter->flags);
>   	/* Start the statistics task now */
>   	queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
>   			   msecs_to_jiffies(10 * (pdev->devfn & 0x07)));
> @@ -1733,6 +1732,15 @@ void idpf_init_task(struct work_struct *work)
>   				idpf_vport_dealloc(adapter->vports[index]);
>   		}
>   	}
> +	/* Cleanup after vc_core_init, which has no way of knowing the
> +	 * init task failed on driver load.
> +	 */
> +	if (test_and_clear_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
> +		cancel_delayed_work_sync(&adapter->serv_task);
> +		cancel_delayed_work_sync(&adapter->mbx_task);
> +	}
> +	idpf_ptp_release(adapter);
> +
>   	clear_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
>   }
>   
> @@ -1882,7 +1890,7 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
>   	dev_info(dev, "Device HW Reset initiated\n");
>   
>   	/* Prepare for reset */
> -	if (test_and_clear_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
> +	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
>   		reg_ops->trigger_reset(adapter, IDPF_HR_DRV_LOAD);
>   	} else if (test_and_clear_bit(IDPF_HR_FUNC_RESET, adapter->flags)) {
>   		bool is_reset = idpf_is_reset_detected(adapter);


