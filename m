Return-Path: <netdev+bounces-212614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C819B21753
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A9F189362E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EEE2E2F03;
	Mon, 11 Aug 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuXRRX3W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C42E2DCB
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947672; cv=fail; b=A1e2KSrCXH+89LC85vJzHq5ST0zhncsyFttEeOU5gVsmluT1UU5zeM4M0zCzDfA4TScFJLs1n4HcxYxZ4II368citkZUB8uOfoGHzXZg0oU1q5dNvzxABMLed0nhhdadiQNyEM0LkwOu7JeELrHWnbzwv/d937kNhal/wvZLUSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947672; c=relaxed/simple;
	bh=uWH7uEUlyvqZvdimfKwdCXRkGXjQ/oiVnDr+bHjOaHs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fraTPw6M0VmBVSQltbgv1AM1/XvYkqCcwkn4Jf3CqLrzSojXYaTdKstH/QiGE2M2AFMPOA+AmKXuPkMu80fSPkOYgMq6xpk93RyAxkkfYCf1jbCQrl6qa9YGzNGouQANLtDgPywScMbmekoaPuUWoDZ2ES6lRjmRA7f+CGEeWX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuXRRX3W; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754947671; x=1786483671;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWH7uEUlyvqZvdimfKwdCXRkGXjQ/oiVnDr+bHjOaHs=;
  b=VuXRRX3W4n0g011xEorWWSimaHQcBMdxqmOCF50WwVQ/shCWZpIPUWef
   jir9znxpzr5ybQfsW3AMKbv9ZLwVG/5VWVXUO49eEl09M8XOQRW8DEgAi
   4p/eQb8OjOO3W7uZQ4ELU8Pq+1Tf2x7GRSdK6AMFv6s0HmIV4cSwwU3k8
   OPgG1OMEZAjp35RXpzjyWUrv4cCsztT3Rmdz7FVNBvlRD1KrKC4o0UhXM
   Ur4pVVEVUz7tPadcvwPHoBB8YUWv1+oXrmkGC7ZY3pBr5ikNJjkQ2SuFK
   zYa7SikBTq/0h8SnP945Q4sVjwcjqIhTWHk4zRO2FYrFHvfi9edGsyzIM
   A==;
X-CSE-ConnectionGUID: fECYNZlgQE2k+s4OlJNe0w==
X-CSE-MsgGUID: Z66udtFJRoW9CuQc/80ilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57166509"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57166509"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:27:46 -0700
X-CSE-ConnectionGUID: FbUxLoVNT+OsTtltYgDt+A==
X-CSE-MsgGUID: Ihiu0ENvTBW+OXOzr8kWYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170234980"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:27:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:27:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 14:27:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.42)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8+IgtDCYRepdVaLBVlgre8kMQXjBIPnnDBS8miGviV3n3EvR4u9ed1AdxNW42BxZruYB/9KpUYSeDuve8ZTTrCjF0iEGyz7+f/z1ENN0FHNo4RnMGB1m6cXJw4SFTm8m/3VSzEu+uGhgSfdwmorqK4qN5ilb02Bc59jUSSLnCkQmI39AxnoX0CvWZRixPEl9l46zWTAQWHwWNotDpHdn29Ry2bKd5g4bmD5g/lRIvFFhootyukaY0lYZCzQD+amuCKeslovs3nDxHtPjTdktEwvTxP20+RfR/mRc5yAmi8hB1PvPk9b9shJyxHPbRc5AWkAP8r8W2dQ2LIN7XtclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCstQXu2Fv+0t8bYLx8x19JB2eqUXbMYUfZLK3C55w4=;
 b=r9v1bJ8rsriTeQfsDwb4u4V0e6w0YWlflRL64yoSId0USDS2Y5e9LBJIBSgZAeLLcs6r+4IYjhoFQbLpmoO4gj4w0YCmaJGl48u0yQXr+K/bPYTvpqgtK414oSuzs/dhMkAgZBmV6lYJHWmtJ8K5Cf5Hluqf1pLfbp5VzI9hoJ+NhhnPCsP6fJGAlJaNLHr3cEdtZynhxkWF476XLY0FTOhNGvAwatN2uCRKJ/J/ktlnLYgJp2Mio+XfN6DbKgQ6PVRewbFLQs/FF+Nbzt2HjYpy9dY+UIBENiYWKwHMbNCOtglZ4ICZjMcve/8mhpvTXo+xb6YQZkkLEXiAFYZ6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 21:27:43 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 21:27:43 +0000
Message-ID: <c8473c7e-0432-481d-9db2-656c3ad7305b@intel.com>
Date: Mon, 11 Aug 2025 14:27:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] devlink: let driver opt out of automatic
 phys_port_name generation
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, <przemyslaw.kitszel@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <David.Kaplan@amd.com>,
	<dhowells@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Jacob Keller
	<jacob.e.keller@intel.com>
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
 <20250805223346.3293091-2-anthony.l.nguyen@intel.com>
 <20250808115338.044a5fc8@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250808115338.044a5fc8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea453bb-9360-4bf0-8f13-08ddd91de847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTFtNEhLWHJWeWRKbU13WUxiNlp0S0dQTVI5TWpXeHVmVVdVd0drcTB1ZUZm?=
 =?utf-8?B?cHo3Z3lzQW03clU3ZmE5aXhNSDJUeU43YU9DNkRqblNsSXkzQ3RWWW9UWHpF?=
 =?utf-8?B?Y0x0NUtpVUF1UXc0RmJoZ3IwVDlGV2gzRVZsK3didlhBUjRENUlURXMwTCtG?=
 =?utf-8?B?cCtrMkZZem85Sk41bXJkRVBPWFJWTDlZeENPUmVySGpRdWsyWEtPaEttWURl?=
 =?utf-8?B?R3VpQWtEY1ZodWUybFRXRnAwT21WZStDKzh4aGQwdkQzUzA0bkFCeDhHdHBF?=
 =?utf-8?B?QU9naTlWazBsV1F5bE5QUENOdEdPb21GUUxmWlFjVTk3bkVmVlNjeGE1WnlS?=
 =?utf-8?B?d0wyb0RJeWRQSzVXMExIb1hpSGZvMm5ueVJiek9BMHpmUWdMUmJWQ1Z4aWNP?=
 =?utf-8?B?RStrSHVJeHduOSsvUjBZZkJYVFdtUUxESStIaUVKUWRwSC9IYkp1MWVSUGx2?=
 =?utf-8?B?d0R0MjBYeWZhYTdidUVxQW95eTg3S1plWXhHRG5LcXpmenJYR0x4UmlIcnFH?=
 =?utf-8?B?OWd0cXJFVlZTeEtISWUyT2doVzF6QUYrbGViMXkrV2RQcTkySjNzbVI3Znhz?=
 =?utf-8?B?L3c3cmtpdnhXM3ljTGdvVHR2WlJsT2NBMDdWYkpCMEQzNnN1UzFFeVRIUENI?=
 =?utf-8?B?UGlLMElTQUZsUXJlNi9nVzI2RkxjOG05QlJieS9QVmV1d3Z0ck9EL0w3ckZR?=
 =?utf-8?B?SVBxNkRVZWZvcmZkOW1SNzc4bUVuSEpJZ3NUVEMyN2daSHNFampKYlFFTGpq?=
 =?utf-8?B?ekFDWTI5SWJXOHIzcko3dnhSaEw5MkpOMGFuWjEzbFZldzl4c0JCY2gvYk9C?=
 =?utf-8?B?VXYwVEtNdlBEMkJvRHZzdi9ISHRHeSt2UmtRaFdvZzlXR1ZHUnJXK1BRWDdY?=
 =?utf-8?B?K21XT0xtSWRvb09xaHdFVk1MZTY3OEoxbTRaVUwrZ1ozbUVDRlN1T3pLSDda?=
 =?utf-8?B?dDNMRnRlbTJFaVgwSFdhUjhBeVJUSzVROUQwQmorWk80emJsSm1nci80VzM1?=
 =?utf-8?B?SFVsQ0g3dHNncFNtWGVJNHpGYkxQdk5USi9GS1VadmdoL0lmY3Z2ZGNOSmtR?=
 =?utf-8?B?YlFxcVcxZnB4cjZiU3k1ZFovczFQRHcyUjRYTFdxMDhVcU1tdWRKanFvQVU0?=
 =?utf-8?B?QlZubU56bDRtN1UzWGUvRjM3WG83VmZ3ckZ5QjgwRWlEb2htSkRTOGMxYk9D?=
 =?utf-8?B?RzdFWnAxY1oxaWxuNXZrR0RaMi9qbUpKY05hbmtlZzdraWZrYmY1WTI2RUow?=
 =?utf-8?B?REtJYUlTb0MzUVh5UWY4UWYxM2xYQWdJRHJOeUVTSXdUNjJHOCs0NE84YVZY?=
 =?utf-8?B?c1ZuV1l6bm5OWWhJMFdhYVNQTlhXRFNjdE9yamkwelowaFBuV2F1OFladk1H?=
 =?utf-8?B?cXplQk1nS1ZtcFhiY2pzRWZOQnRNS3pUdlZVR2NRRjY1NnFvdkRBOHR3Sm5C?=
 =?utf-8?B?QzhNQVFGVEVMUjg3eU1EK2ZraTFTdi9QTUtCQ255VnhyYkM0Q3htY1BCTHpp?=
 =?utf-8?B?K1pEa0J1bnlvdml6OUxHMHFLd25VOXZreUs3ZGJjMEh6Smo5NThvRk12TnJl?=
 =?utf-8?B?ZGZibEpqNldvWjhPVEZ3V1ZEcWQwTWZ6UlkwV1dENlRKRHdoTGhoYW11YlZy?=
 =?utf-8?B?UXRvM0trMlREY0JOQ2Vmb2dTNUc5Y0JYRnlzekVFS1lkZVEyZzZGK3pVVXNo?=
 =?utf-8?B?V0djakhFVkRqR281VENLVWlDVXVwb3MwMjRwalRvTDQ3M0JxYVplSC9xL29P?=
 =?utf-8?B?eGd2czJGM2hTbGJQZmdNUkRRN1lGNHRGYm5TUTlIZ2VETmV4ZkJtZWdqQmtI?=
 =?utf-8?B?Njc5ZUs1UEY1MTUrTktjc1pFaDVMcVBtVWRtenNjeUhIR1VVNFZLdHo1dkkr?=
 =?utf-8?B?bWlxNmZqajZiWGRPZDA1WHpXWE1XRlRlK1I3TjBVTUsxN1RiZEFUUDdlWnAz?=
 =?utf-8?Q?PTGLTR6pu0c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjA5K20wU2Z1dlNwR3dGRmsyODVDLzdsS0hHZitCby90Yk9jbWVzdWJhaUtR?=
 =?utf-8?B?L0xWYUVaSjNwL2p0SkxBRStxSGhLM3FEdEo1ZHE5Q3Q5ZDFVMGVuakluK0E1?=
 =?utf-8?B?RTRXV3BqOUhnUGhoZDBWM292OFJaUnJuZmpvMkhIUnliMXZGcXBha2RoOWZ4?=
 =?utf-8?B?dXhKQjhMMWhIYzRDNXVyYWZHZGNjbnZXRXloa3hpcVIxQmIyNDNlQVFRakVh?=
 =?utf-8?B?a0lzL2laNmI0UjFtQ09wZG9JTUtmbXdYY1RZT3piYmZBOTM4dW1LbFNla2Fu?=
 =?utf-8?B?Z1IwRTZlODc1OFdBUEN1dUc2cHI4RHpINzYwbnJGQTZyTkJpNCtvaGFyT3p3?=
 =?utf-8?B?UkpDeHVGMmFMaHZiTlpBbjJGb1lOVTZma1M4aTk5cmVkMUxBMUtWZSttcXE5?=
 =?utf-8?B?N2V5WDhmeW82NE1XUFR1YVljOEJKOHNmNmk4eURXNFdQTmRFNjNLdWMrUzZz?=
 =?utf-8?B?Z2hERWdkQS8xUkR5OXFyWlN0MmZxYjc4SFBscTU1Wm9mdHNKLytzVFhIT1VF?=
 =?utf-8?B?ZDNYTVdiQUdPK216YzJDZ2tHNXFUTWhOTDVnS3JZaXZTT0k4N04wTTFiK3hn?=
 =?utf-8?B?Vkd6U1ovSHJCZ0F5U2RHenNuRGlmemxkTmNQTG5ZSEdMZy81UDlaZUJwa0dR?=
 =?utf-8?B?SmNpVVI1ZW1LNlZ2L0tNRXFhMUp0dHJOTUpQR0VqQmQxQlpCMVJuSUhraGlY?=
 =?utf-8?B?ODd4bTdyUjU2MDdDeStRVngvdDNCektUN20xeGNrakJvTytnUWE5Ly9TOVRr?=
 =?utf-8?B?WWVaZVdzeUxiWUxhUnVoTmZqVEY4ZkdkWVA2T2ZtN21TU01XLzJVVkVyNTdt?=
 =?utf-8?B?MnovSEQ3ZkQ1OE9XWnB3QU5ZbEdDbTZLRXdMaGZpQldpYTY1L3kzSkFVVmh0?=
 =?utf-8?B?ZXNiMkdra2tHbDk0L0VQdkQ1VDJOVnNIY3o3Tk9rNTV3c1dPNUM0S3gzb3p2?=
 =?utf-8?B?S25OdEcwbmRqanBYa0NQSVVHQmMrUnFiL2dTbE0zbE1RN3k3QjBURk1ldkVU?=
 =?utf-8?B?bW01K2gyZjFNUFNWamgvOFdiK0hDN1NSZUc3cDlxTTlPdjAvY09pM0Myc3Ax?=
 =?utf-8?B?Q3A3Yk5Hd1lyY01MeXc4WGhUbXNJaVdBTmFjdzdGSkxqWWlYN1V4Sk9Eb2pn?=
 =?utf-8?B?ZHhJSDA0dlRUQ1V5Qm10Q2dTdkwvdjhIRDk3RWpXU0ZGU2MyWXBadGZvL3lU?=
 =?utf-8?B?UDk4ZTVHbFI4YUUvWU5RTGpSWHpDcVBjRjd3MFczNlRlandlNnB4MjhLYWdQ?=
 =?utf-8?B?eldYMXIvQk13TEVnbGl5ZldSZDJhM3NtdVhjbUlJRW1QTTJ4YTNTR252WUlZ?=
 =?utf-8?B?THd1MTV1Vm1xK2lDZFgrNEVTWUt1Z3REalp0ajNld3NlSXF0YnZSL0h0cWZv?=
 =?utf-8?B?R3hTdjJTVGM3SGZyWFhkNHBnRXJwSHo4R1F6ZjdJeTJNVVQvOGwrV0pEVU0x?=
 =?utf-8?B?U1k1dHpEVFF4eE81Kys0RGgxZFY5bjBmY0dwcXJYWEZ1c2pJaVZabHNHcm95?=
 =?utf-8?B?Rk1ndk1wb3h4cEdERzB3QVdqa0Z4WEF6LzFnYUJyTVNWU3NiOU14TVlPOElQ?=
 =?utf-8?B?cjE5MGhhVW5HMjkxY3hlak92ZE9CL09TQ253aWRuTlZ2WnJLOGZQeXNuaU5i?=
 =?utf-8?B?UnF4R2ptczRjZGlZUmIvY2hiRndJaU1SN09JNkJNMDBXY0VHZVlmWGZXWVZ3?=
 =?utf-8?B?Ym9yYVRjclkwRVkvRzhMVVFycjJGSHdvQWlCMlcvRVJNU3E1K1o1SUhCUlQr?=
 =?utf-8?B?L3pOdUpMU29vSC9lWjl4L05vMUF6ZzdpakRkZWFBVFJmZzUwLzhpV0FvZWpj?=
 =?utf-8?B?a2J6QXFnOWxGUTQvbGsvU3JLWGNleUhLUSt6TUEvR0VBZXJuaVJlOEk2Snpy?=
 =?utf-8?B?djRoRngvTlFnNDV6RUwxRWFmaU1aZ2pxcFhqdlIvVjdnZENjNi9KcGk5TUQw?=
 =?utf-8?B?VnkwdWtlajg1Skc3a0t6TTQreTlhKzRsd1NUQ1Baa2gxRFUwQktuaU5KKzdn?=
 =?utf-8?B?WTlwTzRBSEdGNWdOd2VFeDc3Mno3UFRLKzlRelBDWktNVnZ4RG41VDArL1hF?=
 =?utf-8?B?dmVlNWxPWEVHTVBkbGJveTBrWnhUTm8vTEtaRThIVnorMFlzQXJ1NktzVnQx?=
 =?utf-8?B?eHFJanp6S09ZTGYrMUdtU2dOTUwwOTEyU0lNbWxIZHFFcjB2UWNZZXkxR2JP?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea453bb-9360-4bf0-8f13-08ddd91de847
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:27:43.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1ex9d1AsCqF0/lh1yrNJk3bt4ebGJ0HFW+Wn5JJfZ/RsKKd3DAtfJSiR6KSVlSXQeFh0e4fCC83azxRrA5igJMxZPKs4ueWXcWB5mC+owg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-OriginatorOrg: intel.com



On 8/8/2025 11:53 AM, Jakub Kicinski wrote:
> On Tue,  5 Aug 2025 15:33:41 -0700 Tony Nguyen wrote:
>> +	if (devlink_port->attrs.no_phys_port_name)
>> +		return 0;
> 
> Why are you returning 0 rather than -EOPNOTSUPP?
> Driver which doesn't implement phys_port_name would normally return
> -EOPNOTSUPP when user tries to read the sysfs file.

Jedrek is out so I'm not sure the reason, but it does seem
-EOPNOTSUPP would be more appropriate so I'll make that change.

Thanks,
Tony

