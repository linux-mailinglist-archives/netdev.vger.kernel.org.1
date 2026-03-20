Return-Path: <netdev+bounces-269876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOWnFgAevWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:14:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F692D88C4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88B7A3006B59
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32525301474;
	Fri, 20 Mar 2026 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6qnrD9r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B82D3A93
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001663; cv=fail; b=E5OcYb+kOOPnDvM09xK/MK4rly+uuir4ZGsuMRIbTN/0yR3aTsFq6yn25DvI+9l2/er7C+sqUdkGjO1yDRdaU0La5r2uQlbbAAZumv8kEreLDn+YvBloUAyxyeojhUsTXvCa5/IjSQFs2tS3sMFzIZqdSCxUN0jvMf0Y6jtcxS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001663; c=relaxed/simple;
	bh=z7qbI8Jj/fDVaIv/pG/9PHYU1CjA0Wr93qW/C1reZIk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YHDGZ19FX6T8UtXua5eYi7hYh9x7BqbIc3ozQA34gsl/GmVdXFLLLC5gWjxg3hJTf9Rll8TZAoNDNOjGnA/Z0/UvJDGgj8NKgp8lWRRgNKnn2CEHV+L9uU8a5lSHlRtiaTmHs2kPC13hC+6olp+WhKpbU//sIOC5yTBM303+lz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6qnrD9r; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774001661; x=1805537661;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z7qbI8Jj/fDVaIv/pG/9PHYU1CjA0Wr93qW/C1reZIk=;
  b=d6qnrD9rNfQfgVRDn2rTunac5l/6JHnf8oe+K+MDpJaQUZ8cogOaFdDH
   ZVBByvmjX5Cv5QNW5upUiCrCQGnQ36mu07thQhtiSlLMVGGw0qPmW4vLF
   Www7MwE9+0qb9Z20eY5WQkRnrjXA58kWfZpKBwU8q/5AYFmV/GfxP7vA8
   29AXhaafjplZcxAp/r+HVP+ool+3B7W40t1exV/S5LXKn0PqaPNJ/bY0O
   QjLpYSfI3k8h7vRZ22hIlnYTuze0asrTE2nDKcb5e14aHZUiiXSEgfih0
   dgzcZgFi/a0WDNKxNXk/Ym/xbAR+U9lxHP/9TfEu8piyNctLtK/hN/7XN
   g==;
X-CSE-ConnectionGUID: FsUakh2MTdOLCgOfpcP67w==
X-CSE-MsgGUID: uQFfO/UGSb+l8xoLILw6lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78988509"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78988509"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:14:20 -0700
X-CSE-ConnectionGUID: hi85SgU4Sg+F3FBb2EZIZQ==
X-CSE-MsgGUID: 4K9ZY9F4RU6gWHhuAJ9jdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222336629"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:14:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:14:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 03:14:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:14:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+HiRtRTmEkpYeU+VikADszb+eC1GkeA4H5JO3ULyIbt0+VGAjv2+0V7ARjJq6GGWZGjRapia+gH9cCMCPe9qHHet3GTB84wloE8IcH8uDJXDbS1tqKCsPvj3IkbE6ssLxPitC6vGgF6tmdWUQvdSsvoDD22zUbYxtX7VCGZZHmun5oE62fn9C9jFr+xSpz010a1cps/Lt83Vn/YVikYeq4Bgw5Iq/yoDqaATkpMCI+381Lzucj3P9cEq1N6y0sQ0M7K7+wxLPk43jpKjyaqsV3VUr73MyFK3XFIIj99dZtT3p2mgQ0XQqaBJ+rLJw99xhnyilZ1ZKnAtsJKemXHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWyPiZQqKmTLUAQXyBgA6T4B8tWMS9okRm6ekuLeA/k=;
 b=Fi9yReDg4DD4KHLEvrHWtPjEIUX5F3N5xt5/YKWRnu4TDqVskjwlAd/w+yknm8yf6rGrcVgsjpzrArSVmI6Ay6QNRgktmhgUsJGeh/sNOw+ThE8xTPh9kiJ+x0vRa/U3qp0IfmiEE5x6v4EXrvnBDmfSNKJchA59Q5DnM7dkZ06VEcG6eTNmUXM9Vd8+XThDCbZqwqKGv4c3IokIRQkaaHpG+3L8MHwFn6MErXoP/zzxefCKYJN95NonD2rFae22J3QHIJWQZ4b8YcUE+LQQiU/qzZAKle269C1gSWLRkXeGzbRHSIFMoozG8Jswk7yU+Yrvfrk8RqbY8eAnJeHIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 10:14:11 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::2769:b184:69c6:6eb0]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::2769:b184:69c6:6eb0%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 10:14:11 +0000
Message-ID: <4b1927b5-2a3c-4465-9181-2e8885afd122@intel.com>
Date: Fri, 20 Mar 2026 11:13:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: call mutex_lock() before
 mutex_unlock() in ice_dcb_rebuild()
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Bart Van Assche
	<bvanassche@acm.org>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, "Katarzyna
 Wieczerzycka" <katarzyna.wieczerzycka@intel.com>,
	<anthony.l.nguyen@intel.com>
References: <20260320050522.422355-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20260320050522.422355-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: b5eed3a6-6bf4-445f-e556-08de86695326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 21tyKi3nqRoiTatfOt0jqg2MZoKqvxzB64AiggVklAklj0vMqaMISaSZbdCgJiQZE6BdFbDQfQVCTNUl2OUcTxVK5OqVxmo18JRGIYYdcWUpgJDKvOtUYmvbkTPhFgg5Jw2rd2edE6Ew23nchCMhnADfIKlelo8+klLTVshW2ImDZnFvxueZ83HM1O2U/w0+BtKgCB79PlOscYe5Gd2rec2M30P94peJuZ8TvEtrzTLO4t6PMmia0Q3pEFLb/IIFg9s13tJOgeuV3cxyQuhy3xvq9PZN+qiZJrFEf3eMrtQCkGOZnHT0ZbtGe/sUkpCApBiHwo3OlgNRVXLU2EXnsL90thB7D5WOkt9x4KPVxhJeXfMVraeLINpNh818k/DCcRzUWcawkyX5o/8kOd9D4TqGPkcKipTr8NbyCreAe8W2B+NRSbgQcW+Jx4XqFlxqZrrZNrhIZgbISabTiDEhZTd+4ytNP6+yI5/rpHLBn5FG0oeaXXcJ7sHMNSgsFPdPwg2vJ7ODv6bMyDibOTONEeylBXPIhzs7TQEc+P0x+//Ho9HWS5upyuSpWSVOZ08hMRVDhZQ8rnBlfajclKcpl2g1iAUXmb5tIF1acLuDado1cmiC25KrqTifLC5Dx2P2V93SpXgOiBn5mPP6gkpLKrDbjis+uRRDrOPdQ6D7eznkHzPytEdQCDVYVBjlcyS3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVZpVmZOdDRNUVN0bXpUU3hEMkRRWFJyUTZpUGpjRU5VU1ZXcmx1YTFuWldE?=
 =?utf-8?B?RFNUTzdUbE8vTmVxOWFMSzJrZHdLd2wrd3dlYlQzV3E5SGNyZzhNcGtjVTRH?=
 =?utf-8?B?ZVI2MnFpN2FsSTVvbEtCUlNKd3pIdzBSMVVrKzFSL2VRNkJON0t3YUxLYVIw?=
 =?utf-8?B?Q1p3Z2VhWmZxZDJZNmU0ZUx5UTdHd3l4ZEpIMDNOTFE4NGZCZkFIWEJDWjF0?=
 =?utf-8?B?ODdET2lxaE1JUlN5Ty9IQmJrVWhIeDBmbGtoM3ZpckwycWU2QXoybDk1WXhi?=
 =?utf-8?B?aGRTSDFMYjBxcGI2Y21GUGJEbVkvZXBjeVNVeTI0VUU0dTZoeGp0YjE0cTA5?=
 =?utf-8?B?TklRTm5NWHVDcjVnVlNNLzJCY1crdXdGUy9XL2VHc3MzWVpXSDhUOWE3NVdJ?=
 =?utf-8?B?bE5xSjNQYk80UlNmUytxcFN0TVdYaVNieWViOGhWNzBXbXNseWdtNHFGamox?=
 =?utf-8?B?Q0szOWpLaGZCRnFBcVV3QmVjVzliY1N4b2ovUlNIQ0EvVUlIaTR0eWRvcnVp?=
 =?utf-8?B?WHlnZGtIM0dTOVlNRWZzR3RqWXZyWWNZNmttajZCMkxDQnJic2plRzdUTU1W?=
 =?utf-8?B?dFFJV1d2K1Z4K1A0SWJQZGw4VHB2R3VQaVpNUEdwSFllZEI0M0Q5WHFrdVdY?=
 =?utf-8?B?SjdhTXUrbnM1QnFEN3BoODFOOVRZSkZEazJhZ3RvSThCMndqMW9tN3pqNnVo?=
 =?utf-8?B?WklkU3BScVV3T211dC9NUlpsZE9BTFpwcDBhU2hFYVhoV2hmZElOcG9xZXEy?=
 =?utf-8?B?ckxLOEo1S1J0bmQrTE4vWTdYQjdmb2o4UVQxbEVadmp1YkphNlpJWDNGZWdl?=
 =?utf-8?B?T3FVZUxrN25Uc0NrRG9oVHc3czBudVVwcFlXTjFaQVRYZm91NXBBM0JRL1Nk?=
 =?utf-8?B?UU5mTm12c1Z3ZXNONTdMMlpSQ25TczBueUxlZWlXRFBMZWJ4OU16VWFYUjlm?=
 =?utf-8?B?ZnFFbS94RkhORmNEdlh0bEcvejh0SG1IUXQ5RnAyQnVsWDBjWmJMakozY1lM?=
 =?utf-8?B?Wm9FTW1vUjVWUmtlRG1FbS9zcHA1dHB3UTZrN0Job3JvZ2pHUysrN2lFV2dT?=
 =?utf-8?B?c3kzcEpINTFGTXBOeTRBUlZrZ1M2bEpGVEFnTHVoaENSZFExMDUwelVDQUVP?=
 =?utf-8?B?TjRBVGdoZUxSSDFzMTNMd2ZPMTZGUEh1emZJcm94T3dSUnBRUVJoS1Y2Q2JQ?=
 =?utf-8?B?OW1Yd0x2djh5endRR09XREpmWXZlRWpVOWgwNmVsSWRLNUI1M3dGRHZweUpj?=
 =?utf-8?B?QzNCTGhlWCtQek9yU0M5VUZOQkRUUy85dktyeHFiVHBTd2RrUDM0RVdaamgw?=
 =?utf-8?B?WExFejNUcklPSFdYYW5UbVc1OGxoTU9DZ0pEV2h6QTI5OVJLdENhZXAwYTFQ?=
 =?utf-8?B?NUQyQ0pmdE9aRmFCYWZtemVTb0FibDA3SGhWUFhYU3FoRnBpdDFXbnN0WVpX?=
 =?utf-8?B?L0x5RW5jNmMrRVdtVGYxWnVrSGF5K2VnUUVzcStPTkJaREE1cjJ4ZG5mZ0Ro?=
 =?utf-8?B?aUJ4Q3ZZRlRmay8vQzAxeVdJSnljWTFGdGlyZ1EvRTc1YTNnZEhyMkM2T3dp?=
 =?utf-8?B?YURwc0lrNTAyTGRUU0RQWGFveXJuYUN1cmJKSnVteWF6RkYvOWRSRlQ5TjBt?=
 =?utf-8?B?MDdGR0xVTjZLWHVDM1dBdFNDLzEvV25yUEYxeGJLTjZqMkcrcjZjMlNUa2tY?=
 =?utf-8?B?UW02NEpya04yQU1yZGUxU3Rlb0VGajFhWVRDSXFHYWZoalNJODh2WUJlUUFD?=
 =?utf-8?B?Z2t5VnhNQjFHd0lHMzFGaTNlL0JKVGwrci95S1JJMGtwTDdzRW91c0JCYkNa?=
 =?utf-8?B?dVBtNHVtQ2o2MGNEQlJ6dmhBT21SNEQ1L1ZnZStNZVRPRlkxeVltUGo0ZElK?=
 =?utf-8?B?NTlXaHdGUWJGTjJLa2QvNFI5czBvZGxPaHQrOU1hZlJodFRPMEpZSzRDWDlY?=
 =?utf-8?B?WWNoSUpDOTVBNk5HZTRFdEszYmtzb29kdUxubEZOTGQ1MGs5dWFFQTdFZ3lI?=
 =?utf-8?B?R1U4S0dtck1VMHI3cUsrNzZFejRPYzZNMkRjU2V2bmZCTThyR290UEd5RWZP?=
 =?utf-8?B?SkEySm5sekNsaE1CanNSenBMU01HQ0ZHMTRhOEx1QnpwajdNbWZWeHRzYWdH?=
 =?utf-8?B?UWxvUk1RdGw3bUVLcjJ0cmNEZ3V1V0NlY0RmbUNMRTJXYkpWczFoZU9ibXlL?=
 =?utf-8?B?MGlmQUkveWxsdUw2RWdsS3MvUmlLbEh6S0d6bnllWEhodFQzb3ZVamUza0lR?=
 =?utf-8?B?R05wRjNMRk1oU1FYQm9MZDZhdStQQ0wwOVBkcFVLb1Jzei9NcTIrYi9oVUxC?=
 =?utf-8?B?eGY0dTBmbEh6c2J5N0REZEwvZ2Z0NnBFVHNqa1ZhSGRSYVFTRVNsamF5cVN2?=
 =?utf-8?Q?D3xoU00DtJ/2ygWw=3D?=
X-Exchange-RoutingPolicyChecked: mMxOikmQ0Q57ggDID1JiuPJQSi3Cxi1Vd21UVYqSB2UOfK8nnMAPrmxLEILLoKWZ7xlSQXr9pijKjOChTrBdgiCjHvh0vuuwZHtZDoZpXTz1ZA42Ox1SCU4rOPEeqlNzxHFyDu5mIOVLcdQjkSZX4nnW6xVWIk5nj32Dwg88W5S17RkQfPOEW+aSsVWBOh0D3fYfE3wk/FcohmMKrCztwlQfkg573J8NHAP/X8bT3fz9Jf9lwZ177JiM4JLJVEwhEaf+Mg2z+WcaN8aMECcWrZASsaem7oedaYeevvMMRJltyNF/29VtY3jmSvP4j0gj2pVlBnJAb/9oKF/WWuoV8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5eed3a6-6bf4-445f-e556-08de86695326
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:14:11.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHBybLSQsrMf6epGD5Zd0XeKBdxEno8eW+YGjsQ8faLsH8NySzCnJIa0rw3JZbCug+GgrHSFMapqBmfY/EHVTTs7NEKETJ2muKn/8ljz68w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 27F692D88C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 06:05, Aleksandr Loktionov wrote:
> From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> 
> In ice_dcb_rebuild(), the first call to ice_query_port_ets() is checked
> for error, and on failure jumps to the 'dcb_error' label. The error path
> always calls mutex_unlock(&pf->tc_mutex), but at this point in the code
> the mutex has never been locked -- mutex_lock() came after the check.
> 
> Releasing a mutex that was not locked is undefined behaviour and can
> cause a deadlock or crash. Fix this by moving mutex_lock() to before
> the error check, so that 'dcb_error' always pairs with a prior lock.
> 
> Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
> Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

NACK

there is a better fix proposed by community, we are awaiting v2
https://patchew.org/linux/20260223220102.2158611-1-bart.vanassche@linux.dev/20260223220102.2158611-20-bart.vanassche@linux.dev/

> ---
>   drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> index bd77f1c..d516734 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> @@ -538,12 +538,11 @@ void ice_dcb_rebuild(struct ice_pf *pf)
>   	int ret;
>   
>   	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);

the difference is to move mutex_lock() over ice_query_port_ets()

> +	mutex_lock(&pf->tc_mutex);
>   	if (ret) {
>   		dev_err(dev, "Query Port ETS failed\n");
>   		goto dcb_error;
>   	}
>   
> -	mutex_lock(&pf->tc_mutex);
> -
>   	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
>   		ice_cfg_etsrec_defaults(pf->hw.port_info);
>   


