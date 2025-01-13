Return-Path: <netdev+bounces-157851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC15A0C0BC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2B118853BC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB36189906;
	Mon, 13 Jan 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gipVWrcI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A11C4609
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794257; cv=fail; b=hb9RCWxasVaHBln5q5tStttaPNd18seahoynVwBrlkliwGAWUTxFitbTqoy8/KRFHFFSyYjiUot1sYqAEzxXhkpAx6Vo9hvllqRp50iIJ8+MkW83mI65aqT9Fngsuzspg/rqsGsHRZsphG4wAAaYAC+iCrUy2TaT+anVapVQdjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794257; c=relaxed/simple;
	bh=vW7XhvFpMEQUUMo9hWfCqz+VwbfMrEEMfXbRKHhFLo8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eU/tOHJHwdOF81DhOYNLhgpsBchOmBIe/uRlnZlZJZc2+GVb0JgCPXbp2k8Ywvw5eHO/2UsSemShs5dG+KH3+AXQIrxthb6LNh19Z9xd0sTOutCMmtsQUKrxLJfkwEBjSYciB8GQwKFo3NmBZAHTxOaKRt9mNuNQNp2oOGUDjrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gipVWrcI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736794256; x=1768330256;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vW7XhvFpMEQUUMo9hWfCqz+VwbfMrEEMfXbRKHhFLo8=;
  b=gipVWrcIy4CBUMAdR2QA96ymzKfpB9JfeIEHnJhgtVMUQQzjdJBaU4vk
   sVXPqGWPhb2MvWr902oaC4S18a+ot/KbST7i2cmfEG5WbRaL4n+SrlOoV
   G9X3zcKP6yrgMStCcWUzViteauCuauLRRTyfkWAdH/MvoWS8nlytUuY5A
   qlasKH+5eya3xv/e76OAttOatxkh2R0/RcDE7fx7fdToZAomn+7mnJgxj
   O1CGVraMTGa55kcXML9K0U/rj2x9N78RiN7ntUwKSANAvaWD3hLxDZAb5
   UA56qXzPFWKORD6nYeWL/6QLJ6TLNKmNvl0JeiY7vbI8KBfX6yuN/MpGg
   g==;
X-CSE-ConnectionGUID: JliwcouZQy+CcfVJbO3grQ==
X-CSE-MsgGUID: 3gFBLmm+Q4OvvNI8N4Ygwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39885046"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="39885046"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:50:43 -0800
X-CSE-ConnectionGUID: jdloqw/wQyyb6CrDyYgiYw==
X-CSE-MsgGUID: kv+3GZm6SVS+ZAvq7dhVvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="109588159"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 10:50:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 10:50:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 10:50:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 10:50:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0VOiQdHxH3DoIToeyDhPbknZyd9AYwG2+C5RqZW/rR2s9BmiFaRVByypVNPJpNUnn0sWqQLwT/cXLYS6yNzpkTW2V5rJQid9aMH7YT7odnOzlkPhNB6IvI0PbvzCL0TQvafqwerBnUD8ZfCUb3NkNacQjwDEJMmvlPdhnvV+GuOLW5KxSzHg27++lRzh4+LfJmX89hF7cPXdWXvdmp4Hu8hBcWeWLLkHV98Ul5eylDttY2hO1ODSoJNpCMXjSvDWnT74Y/TvELOODbww8Sb1vh2DLtPHg8z3W4dUsVuRG4GC3RSlPNB8ZZP1SRsvnLWLIAMBJjDR31Oj7tX82ncbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hop2YYYAI66y/vQr5TlUQIh0h1Nbzii5W/wKrIHe4Ow=;
 b=Fl4eV+N5EBZ4K/MbEIi6sBr5bYafsAfzL+lMaOVmwECWqL3lTC9WEC3NDTvekOClJW2rVSQa7bxDxN99zP2ha6AZlDezA9DvoAhndg08b0qQTEdZ0ZokHfDg+FtC4wKZeOCPHBGEH5h1h13hoyba+7VM7HKt6qhZ4FxvWh6Z4x6+liZX+7+tgr+rYW88MUzUPotFizjlnbfvPeosZD3+bUzcdAtTDXaxrz9Dr/T7uVjS649lATCGOfvpXisvYwcP0ZFebyYdWzXQwzuTtSGNapbhDmPnaw8aitcWrbJ4ztNx4uocu+mLQGNtB+rTdXJ8qYCEiDFwYQOq0Z35vWI4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 18:50:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 18:50:40 +0000
Message-ID: <961f010f-4c53-4bb6-a625-289b6a52525a@intel.com>
Date: Mon, 13 Jan 2025 10:50:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/13] ice: implement low latency PHY timer
 updates
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<anton.nadezhdin@intel.com>, <przemyslaw.kitszel@intel.com>,
	<milena.olech@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, Karol Kolacinski <karol.kolacinski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
 <20250108221753.2055987-13-anthony.l.nguyen@intel.com>
 <20250109181823.77f44c69@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250109181823.77f44c69@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e26bb90-2612-4e61-bdce-08dd34032d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ri9xalRlMXNKdm9mMWs1MWhSU0lad1ZOdTdhTTBkMC9HWXF1RVNkZmtOYTlh?=
 =?utf-8?B?SW01b2xuZ3NjczloWTM3OU5TdHRRYkpwR204SUVuT1NscHZ1QnYzZFl6RWo5?=
 =?utf-8?B?aERuZ1llYkF0SkhmK2NQb09mZ0E1QXpSbjkwZlhPeEs4a0IvYW9XM1pBcjNp?=
 =?utf-8?B?QmVFcytBVm5FR3NuZkwyaEIzSnBuUWZHQ2VNTmM0aHBuNFF5YTg1aHlvTi9i?=
 =?utf-8?B?bnlpU3NTYjRqbFM1WFhFY1JBajZyOXk3ZnNpSDQ3aG8zOXBoRWcvc210TDNr?=
 =?utf-8?B?Z3pwZjBuTVk0OSszM0JWQ1M4NVU4NkhxSTlQaXRzZWtqaXBEMnpGdE11TnBR?=
 =?utf-8?B?RVZhK0UvZS9pOFRJRzRSTEgzVVFsb2JoRjA2Y2VvcTFyWDBFdVdGOXdWY25O?=
 =?utf-8?B?U1lBSnhkS2RBZlRxZkM2WnZBR1N2MnR2SkRWallxaEgzWGVEdUtka1Y0RE1v?=
 =?utf-8?B?ZFFsdGEya3gvMTdvTVBxZGcrOXpLTk9FWm55eUZTaHN1czRMbzErb3dCN25M?=
 =?utf-8?B?K0RQLzBtRHNkMjNPTWhGKzdEcDNFcUJrWVJEVWVzcjhHYVBLZXYydm1GZm56?=
 =?utf-8?B?OGd0cmI2SjFZV2t0aldwSEF3Yk5sQ3hFUVhQeldod3JFbFNUZFZGWFdRaGhB?=
 =?utf-8?B?czZLd1lWU0FLRnpPN2xxaG95MWNZU0M4TUJWam5vQUFBd0ZNRFI2UVg3MTU2?=
 =?utf-8?B?Y2pxeGYrU1UxRnIzNi91ME4yYjZHK2V0TXVUdmVrVGhiRE4yR3cvUEkzUkxL?=
 =?utf-8?B?R1BWb2g3UjB3Y1N6RXlKMUMwcmRLUkU5WXB5ai9ScFdId3Q0NmNtMnhmRzRu?=
 =?utf-8?B?MzNxRVpjcFFJOXdYRTdTUEFVQjlTQkFRcHFNakhrQmRJQ0dQNjhmNlNmRDlx?=
 =?utf-8?B?VTl5YkNwcXdvdzdvd2FPZzlHN2tzNlNlM0lwOEdCTDlBaFRFOVpJVkxUNEJk?=
 =?utf-8?B?YjZtRWJ1MmZiazdoQTRvZ0dGbjZFK08xYkhSYUhxK2pseFVYeWhkMisrUW54?=
 =?utf-8?B?eGFEZlZFZ1ZWK0QyWDdqLzFIb0tJVCtsV2g3MGwrcVRFM0d6bmNqSDd0OFF6?=
 =?utf-8?B?V1gvRVdyLzh6Vmg0dUpTQ3JNRWFDRnA1ODIvVWZ5V1hmOE1Ta1o0bFpoSHhI?=
 =?utf-8?B?b016TWx4c2ZaSVp0eGpCYm00THl0a0FNQzd0aHRqbXg3eTFReWpnejVYd2JY?=
 =?utf-8?B?WHlFQmNCblhrclpjNWl5a3Erald6Lys1SllUVkh5TlkzVGtjSUh3Nk05Vllp?=
 =?utf-8?B?ZEdkd0c1UFo4cmY1WmpIK1lMdEd6Z3Y1UEwwK3VBTitLTHdqdXVnRHhvUGFu?=
 =?utf-8?B?bnZEZFg3NjdENjBMZVRWTVBSU0RNejJWMEtnSDZaQ0oveG04SHNHQmMzak5Y?=
 =?utf-8?B?WWpRVlE0YmQ4Q2FCazRXdDFYRDYrV3lXYjZrN0lEWjBpYktKV3luQWdJWnpC?=
 =?utf-8?B?cVBoQTJyZVU4VkhGUm1FejUyY3Q2ZSt1WTIxWEFWZEVNWkxCdklaaGlFRFBC?=
 =?utf-8?B?VnpEcitUd2lGV0l5ZFlZTzFYS2JPOHREdGppV0ZpSTdOaTl5TkkwU3V2VDA5?=
 =?utf-8?B?VUlGekh5NUY0NDFaNHpJVmdNK0J3SEJIK2lhakRlTm1iUWJUQmdyWEhNNWU3?=
 =?utf-8?B?Y2lqRGNzZFNUT21zZXMvRlVKelNZWUkyaWpJWVA0eWxwV2VPMUZCUXpjRkhL?=
 =?utf-8?B?U0FkTEVrb2dQb0NBTDVIZVlIOGpVYkh3NDhGZFVkK1BiMVhzdFMwUXl1Rjl5?=
 =?utf-8?B?NzFwNzU2NG1JaitjRmx4UWVPUjh5cGZlRk8wWVRiMGlNcGpVcTRSemMyck5L?=
 =?utf-8?B?bnRXYW84M0RJM0Fsd2ptM3pLM1l2RzBCZ0d1bVpBb2pQeFZNdnFIOTFEV3ps?=
 =?utf-8?Q?7YDu8jtXr6gXZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzBVZCtxR3hZV0dINmhjaDVlUmNHMnk5cG1ybEZzMDFSdTBDMmdnc0hDWlM2?=
 =?utf-8?B?eHIrZTdocEh1WVdWdEZ1TlNMd3c3cVl4S0oyM0ZkTUpiV1FUanFZcFJSZW04?=
 =?utf-8?B?ZExRanM2RkhqVEczY3AybzM2TXcyWGxmZ1dURk05UEptT3FVMm5zQUNCMUg5?=
 =?utf-8?B?VXV6c0l6MXFMdTlieUtQVFdtb1dDbE5BMVdJbk9ZRjRqVk1vUXBKejl0Q2Ro?=
 =?utf-8?B?bVZwbStsc1h1QmxzZmU4VEhwR3V5ajJESnZQenJWdUJMQmtQS3JVWnNNbVg1?=
 =?utf-8?B?MXNkL2tkaE5zRDRuYklsWGNQY1lpUVZMbjJxN1BlT3hBUCs2clJYUGdhUE51?=
 =?utf-8?B?ckxyaGVWYUMwQzlmRkd4Zyt0UWd5RUxjRytwcmgzblp2WCtsTkpGV00xNEto?=
 =?utf-8?B?cDRHTGNxL082NXNjNy9HQVUyaUhBOS90T1JTVjdMcmRLY2pCdmMrTTJyQlg0?=
 =?utf-8?B?aElFZFB6OVY2MlZZOXFIMlRsU1NMU1EySHk0WDRYSUt2NlNzTnlEUnU3T2Fp?=
 =?utf-8?B?bm1TYUZWMEliTTRLdjcrSnJDWmx6T01HM2hLakRsb0JrSGpyZEhVN3o4QkhX?=
 =?utf-8?B?MzhuNTNuYlN5MWgydzA2a0ZQYm1jUE1CNVQ0cm1DM3lUazYwazJOdTFFVFEx?=
 =?utf-8?B?N2txR1JZRjZrOG1SNVQ2QlJtRGU2SGtBVWZrUnhuRGJQd2w3MUlydDlGWHBa?=
 =?utf-8?B?VE5qanZ1WkpOMVpRcVNCSXRRc0F1RDNnZXArcXhVQ1Y3MlNtK2ZQa3owei9I?=
 =?utf-8?B?NG1zOFp0c2JRU3lQSjZ6OGlBbVo5NXVjMnU4V0pMenZYVXZ2RHJtVEEzUDVu?=
 =?utf-8?B?ZHZBVXVFeW4zYjdGTTl5QUdlbWQrZURZbTdmNWlRakZHc1Y0dGFtSmIwZlFF?=
 =?utf-8?B?UFpMeHQ4dFJoUytRdmpkdHNSd280eDFoMk05c0NXeldFeEs1TDFBV01aT2ll?=
 =?utf-8?B?Y3NTTVlISEczeVFRQVFnR1ZGOWoxbjlZSTdaOGIyNUZnTTVYZXEydnBYNXZ4?=
 =?utf-8?B?Y0hVK3pmWUpOQ0VnMjYwdEs1ZVZaN0JRWm9DR1JaTU1FYnIzUlAwd0swdWZO?=
 =?utf-8?B?QUF5eTBvdkw1clVBUysyYkwvMUhCdjFTL1BTLys5ckJYV2xXTzFaaStwWmsw?=
 =?utf-8?B?Uy9JY0YyNWI0TDd1aVRLMjhzd3I2cDd4aFVad1I2Q1owcUJuUXl0dUNaSFpm?=
 =?utf-8?B?SU9qUkZsTzZlMmxzSDVrWEFnYWw3VXE5aWdxZmtxcDFacEdDQW5MLy9ZdXI0?=
 =?utf-8?B?MzhicDIvamRLcE1uS0p3dHlhc09Jd0J0VkJPSDRvb2duSjF2Smt0VjJXMTVy?=
 =?utf-8?B?MGU1ZzVFV3Z5RnFxWFkvdlI5YXpjbDcxa0tVUEs0Zi9qZkpiWlF1MXpJc2Yz?=
 =?utf-8?B?Qlo5TkdSM21PRGdoMUEwdzI2dDRjelpKWUwvSnhoQW9pVDFVOTUvV1ZvY2Nr?=
 =?utf-8?B?QVdsNE1WTU5lWTBxZDBDamN4ckdnbDZRN3FPejc3Q3ZSRXJhSHE1WDN3Q2lK?=
 =?utf-8?B?enBKeVBnQnVUVjAxVTlwMkFGZTI4YllXNTlVWEhaYTdncW51Y0w3Vzk5cDlt?=
 =?utf-8?B?U2RhVVl0V1hnMGwvYjBqMjU5ajZkdHc1M3A3ejh3bWdrQ3pGUm4xWTdUVkdQ?=
 =?utf-8?B?THRXcnphZEhJVXBJZit6WUdaV095M2FqTjdJTXIvRFp2WUQ4dCtNODBGSm5R?=
 =?utf-8?B?MHBaZFVJVHE3TFFOZUhsdExZWXlXSTFZODVaMVBSMjNQZFE2RDV4OGQ0dXZ2?=
 =?utf-8?B?VDJDeVcxWnBNbDFvVENoN0p4QUJ0SXB1eWRzcUxwT2Uwa3FWZDBmUE0yNk1G?=
 =?utf-8?B?ZTdOTkxWcXJRMytkQWRUaTJzamY0WkhpUTBpTXIrSHFaeTgvVmNpMFdQVmZi?=
 =?utf-8?B?bWpXQ1RGMzg0czV5OEFLTFlIa0JxOVpaQ0FUSnZZUEFmL3BnSVRpemhMeUFV?=
 =?utf-8?B?WTBySlArK2FibkxkYXhqaDE2eWJRWlhyU0IrYW1xRFUrTUZ1ME45aHF1b0pv?=
 =?utf-8?B?a3pnVkNtUnEvZCs0WktYOWxLUDBUUksvSHFaQ1g2U3ZqcXU2SElNTFFZVnRu?=
 =?utf-8?B?dkJyeU1QUGIrblZtekJYSTI5cisvVHQ1NHp5SmVoWmRJOTNXME5qV0I0ZDBV?=
 =?utf-8?B?ZlNFVHhSOS9FWVdVenNzTVJma2M2UERnSml2L0R5TjZadituRExLTFNoWCtw?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e26bb90-2612-4e61-bdce-08dd34032d01
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 18:50:40.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKsLCDJzF3HGDsv5n+F1bO18MXlDIjqk1/zZGQlaDseJm27CuRj4nOxGjGrEtvvpemOw04ocFAotZcapFvyVv6ETIU0ZwB/gg2z1mq3ntHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com



On 1/9/2025 6:18 PM, Jakub Kicinski wrote:
> On Wed,  8 Jan 2025 14:17:49 -0800 Tony Nguyen wrote:
>> +	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
>> +
>> +	/* Wait for any pending in-progress low latency interrupt */
>> +	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
> 
> Don't you need an irqsave() flavor of
> wait_event_interruptible_locked_irq() for this to work correctly? 🤔️

My understanding was that spin_lock_irqsave saves the IRQ state, where
as spin_lock_irq doesn't save the state and assumes the interrupts
should always be enabled.

In this case, we lock with irqsave, keeping track of the interrupt state
before, then wait_event_interruptible_locked_irq would enable interrupts
when it unlocks to sleep.. Hm

So this code will correctly restore the interrupt state at the end after
we call spin_unlock_irqrestore, but there is a window within the
wait_event_interruptible_locked_irq where interrupts will be enabled
when they potentially shouldn't be..

Oops

