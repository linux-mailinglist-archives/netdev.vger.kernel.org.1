Return-Path: <netdev+bounces-120349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB20959059
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7403A1F216FC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31814D444;
	Tue, 20 Aug 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inskA1xS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4829D19
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724192126; cv=fail; b=oABYgWq3p04EcsAg9lRnKp+KzC28XvfvKvygztGIDvYvfE87AIX95t4pVSnl1FzkSNt9tfWMztD8eIEwSLR7h0gN2Xz2vBA8sRZnJqq2jMGshssAeFQOqelpyxEohhYK/nC3EwWbaEgKdS2+dZGNhIXDD+jcVphDeSNRziTu13s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724192126; c=relaxed/simple;
	bh=np5OXVAibvpcV9bNljEVac5Wagl7jF1ysV6RMFfYEuA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9I7k2e7MRWzO8cBKzeNaJvh9Fx7xT3Ws3TqtInkgpPmiHrQcyJIczbfvPNWm+6CWuXuEQjiYsuemwbs11C8AUR36PZ8kG/UcP/dXYZe/x4a5A//OCRbFF3KC3HGz3L/GtFGpEbQgTAIN8atG0MuywQHERSpMiWrZJ2ZaL3v0GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inskA1xS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724192124; x=1755728124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=np5OXVAibvpcV9bNljEVac5Wagl7jF1ysV6RMFfYEuA=;
  b=inskA1xSk6pgsivwhUxZ7iCtvE43tl+K+o7DbvvSt1S+3E6Uz2tVrasI
   cy8M1Gc4wVuERTlO1JA7Z4/MNtqiDZVlzj/Bcov8vhJiuQEyFhUhOzA2i
   5Dp6qYdWur036JkctviH6+xWJqEoBqTXpNQDh49TrMEbE5f+nrC6ikDrY
   MMqvtOuxdSmZ3XrgHnwHBzrMs4Bmpm1Nhtes+nfrXQBncll50wy6A0TIk
   I0JTcAyqcutgg98B01ydoQhoiGbEjsA0faegjo0rraQOdU9NVNJLT5vT7
   Hb7OGwSwahaa0OQ1zmAERKFG0vA99TWcqX0DsBLkB3YSqFrD3sRfCi7Ja
   g==;
X-CSE-ConnectionGUID: r/NvPTPYR1aFM5J+YpAuxg==
X-CSE-MsgGUID: huOPQpEuRS2hkehP97OBuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="13120232"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="13120232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:15:23 -0700
X-CSE-ConnectionGUID: q3Agzw6jT+GjzFUVR4ZpVw==
X-CSE-MsgGUID: 6n0+1+1HStmC4ZM0eW2EOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="98350629"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 15:15:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 15:15:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 15:15:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 15:15:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKp/h92PriEFh8u40/NJruuZf5PK0r/4gj5xgEkkgxAHhMsQcqkft3D2A40dCoVauQcVmyzthjxP3j8ayivFR2VJQL5884/mYFoZ4UJYAb5A8ZxNGcWviIAzq+IaBooW/ECJY5wLeVOTO/IImjSZ3dm7Y674PfKjYLRRscoGLyCorBEsozpSs+kr94iqIZFlnbLEV8q0uQjFYb0xRhfxkT1st3YvA1SbX1bbnpLFVNq5Ul6vKjFfZyKY8KZUg5SexhHvrrb4Il4J85yF1s5eTqFbGXGaRRluf8l0EqsFl5wdFSCMpwhbMrv1h6KsprgXrNZ8GT7Fz8gvs/NnUN9ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0Pjd7H9PFzZvWSiDhmQS1qX1bkj0w/y9yvFX0WZc9Q=;
 b=hbzyaLTexRQl3ArDbchhQKFgOkekqmE9T0HF/JkVx0X1Mw1o/pm2o2/ab1OWcTdpQBheEp8ssGzO/LPsjo/trmyDaRIb7OZldCT+R0cKn3cvBQE+Wo/uIqyTcdLZynLWjQFCohGf1LLvOpjvS8JNoe/+cAugb33VSmYpB0a7bltZ1maGMtY+Dft/0aU6grvyLmKKBBrrQZ2fkMLU+Xa1kqz70lNw4aoBSUQqTnChISE2d8dfSs8f2+1J19+Fs6liKoOT6X9rqroOmoEEnkbU8MlACXBxBr5CIngUre861SvYpeSjVQbL63faYQkTwifVrvNOmqs3V2kSoKurTD51vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 22:15:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 22:15:19 +0000
Message-ID: <1875d5db-3960-45ae-97d9-ead2dca4769c@intel.com>
Date: Tue, 20 Aug 2024 15:15:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] ice: use internal pf id instead of function
 number
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	<horms@kernel.org>, <ksundara@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Jiri Pirko <jiri@resnulli.us>
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
 <20240820215620.1245310-5-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240820215620.1245310-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4e3785-04a9-4e68-e6fe-08dcc16593fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkFyUzN6Z295eWRjQnF0Y1p3QVJPOEYyTkNKTllrSm1PWURUdVkyOFdZSklJ?=
 =?utf-8?B?bFdQZm1OQ3JlR3Z6ckgxMC9zc2xhSmh3ZFNGZUlyNkxaSGdtWDhLN0U3Umxi?=
 =?utf-8?B?dnhQN0Zua0tPYXdvZTkyVGVJSHNwNU90VTZPaHRkY25WOTA2NDgrSXJqVk5p?=
 =?utf-8?B?aDlXMERYR2xZTDhJS3l1KzVwb2xCcWV4c2hwdkszWU1oSEhFR1lqUGF6WE1Z?=
 =?utf-8?B?aUZibUlRL09PcE02bFowNEpVTEdheG5xMk9HUU5jOHpWQUY4VnNZa2VCSTVr?=
 =?utf-8?B?NmZVeTUyV0VPMlo5a1pVS3lJR3R4Q1NoRys3b3REMlMyT1dQSGxWT3pMZUVq?=
 =?utf-8?B?T0pSWW8zU1EzQUVBaGdQVkJ2b25FaStOVTkyUEx3YVpjNDRpMTVUblowK1Yz?=
 =?utf-8?B?WmU4R2dSdTlNSEMyemNxc0x5UDIyOHd4aFJBeEpBcVBra2poV29iQTVlQkJh?=
 =?utf-8?B?Y1dmSDd0TnNkaDZ2VHNpMEJTVi80Ym9MKzFPMHVhTzFqZk1ENjV5c0s4WEdw?=
 =?utf-8?B?b3k4cGw2SVVndXRGcWprQkVLbjZRNlFHYmE1UlRUcVhpTk1HakhYWk4rYWFr?=
 =?utf-8?B?YUZUNTRsNzlRN1I1ZUtob1VDVDVWNjVsM1ZjdG04VXBudmN6UytDZi9mNW4y?=
 =?utf-8?B?VmNkVDhSajlETVlvVys2QXRFK1lwdFBWeEJZRTkwVUZIUSs2ZzlKaEgrSEtp?=
 =?utf-8?B?NkF6RGxYK1lNRE1YWEU1azdMRlkzZzhpUTZlM2tYbGhBTnFrRllrbEV3WW5S?=
 =?utf-8?B?SmR0dkFaY3l0bFYweko4anV4NzdLSUxjb3A1VFozMHVQZmJGZVJEM2piNXJD?=
 =?utf-8?B?TzRFRHpyTHZlOUVqb1JBWWtQQUFIandzL1ZRbFpaL0JqbDk1UEtsM1dpQ1pU?=
 =?utf-8?B?WWFlUWhBVG9FWHRTclJIV2g2VmtJR1I4d2E5aGs3UGpiSlp2cFlqRGIzWXVy?=
 =?utf-8?B?NCtvVGI2Yk9sTGhWQ0JPZUxjUTl6OC9UWTdIUFdHNFh0VmtiTXFRUWlvVjgr?=
 =?utf-8?B?djhLU1dOWE5Wcms5K3NCUGh5LzdmTWVxa1dpNmk0ZjJqTGtaaW9YVHUwamx5?=
 =?utf-8?B?QXhpSTJYb1RjbDg1Z2J5N212ZVZ2RkhGZlA0WmpzREdDaERzaGVPL0pCbFFM?=
 =?utf-8?B?dkFPZnh6WlVDV2Q2ZDgvRmtrKzJhMWF0VTN1djUvWG9GbVJaUEdROGRZZnNw?=
 =?utf-8?B?bWhobnJ3Ymd0OFd2VjJtdWQrYktIOUxhTGpCRmRzd1dnNE82alR6YklCVFhm?=
 =?utf-8?B?V0QrTEk5WUl5Z1VhdG5lRWJWMjFXOWZHUUpCSDZxdHR3REF5WUVOcHFlc255?=
 =?utf-8?B?WktwSWJQZUxuc04va3BmSHBnR2tjY2dIT2o5Qmp4V3NRclNwK3dwZjZGek1F?=
 =?utf-8?B?OVlYcDhycjNMaWp5TVY5YkhKTFg0akhkNTVJYWd6eHcrb2hPVFVCZnN0cUFQ?=
 =?utf-8?B?UzN1Si9CTE5jUzdrRERzc2tpbkNKc09QRStUdWxIYTNYN2xEb3NtbUFMWVZ2?=
 =?utf-8?B?Vkd2RTRWZk9jRE5XNXRaWndTTWkwbW9jMHZLYW1veGdhWUlpOER2SDVtVGsz?=
 =?utf-8?B?a3E5VE1udDdRYnZ2SHl6b2ZkY08weEJDbUNCanEvMlZkV25DYnVtZ3p0ZnJl?=
 =?utf-8?B?ekxROFQ1aWhzaXkvd20yaEtGYW5Ka0tOZ1JSd0hic0lUNEcyZmU2QzFpaXJt?=
 =?utf-8?B?bnoyaFA1TFBCa3hnYk83dnBsSy95THdTc0VIeEdBdDNTOGJGUzNmRG5XU29G?=
 =?utf-8?B?cm1oN2ROdjQvaHBpSWtVa3U3VVRzUkRhcUN6Q0g4UXlvbE9SdE1DK09iTnpT?=
 =?utf-8?B?anJpNnUxN1VrNFF1YUlBZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFNVzI2aUtkbXdNa1ZpSDJGaEhFcWZ5YjZkcy9zUjVNVWUvbWlTMEpjSkw0?=
 =?utf-8?B?OWd6TzFpQ1VWK1pzVmJoV0YwNGZsMmpSSzNEbTFiOXYzRlg1RWFRVGZZOUtn?=
 =?utf-8?B?ZDBtem01OFZtRzAzc0VpSTNNUzFwdkI2Q2xwci9RSUxYanlVMjlRMXZFYVkz?=
 =?utf-8?B?WWN6VHJ0U1ZwZzFJMWRTUU5XSm5YWmkxTStEaEVOSkZqZjgrbmVkMEFXa25C?=
 =?utf-8?B?ZDhSKzhyeE1jVUJpSDlZTzdxNG40NWMya0lqQ2Q4YVZZekhWZm92WG5ReTlh?=
 =?utf-8?B?WXVhQWZkeHhUYzUwbGN5VTVzY0pUVEQ0OXo4eDBFNXFZN1RPSnBwWmJ6L2Y1?=
 =?utf-8?B?WDFHT1MwMGVCakFCbUNKbzA3dGN1NjBoMm1rSXh0bFZyd0lCWk9RRnM2TkRP?=
 =?utf-8?B?a3U5Y2ZDOXo0d040WmZyYlVSWGlDMU83Qkg1bFk3SFQ2NmZ0MWlNSkxpZm5l?=
 =?utf-8?B?MFlKUEdkYlVNZTlqazhPcmY0emtOaC9ZUmZ0b0U3b1dDNVo1endRdWVNN1lu?=
 =?utf-8?B?bXJ2ekZEemxDVEV1K0V2VTl0b1JqZzBUbk4rRC9sWjdGUkJQb2xKQ3cvNVNN?=
 =?utf-8?B?aVV4eG9OaVdpVjl1MU5GUlBaTFpLbTN1Y1hNbHRvUW43ZHBSMlZOZXFXc20r?=
 =?utf-8?B?eHRWT3VLa2xSdWJEaFBGWUNtcjBESG1wVjUxOHByR0RCY0JJYVVhTExKWDJE?=
 =?utf-8?B?NWQzOFg1TGRJMlNVblE3Q3JhSnoyT2IxVDVmVDRxRzF5OFc2YXZzSENkcWhm?=
 =?utf-8?B?QjlwWjUyL0Y1eWh0N0t5ZlhBVTBrVU1oL2lTWkYzSFFITVI0cXlzclgyRkdx?=
 =?utf-8?B?NW5VQng4bTB6TXRVWDZYVCt6RTMrV2NnUXVUR2hJK3lBY0o3b0pGankvNUcx?=
 =?utf-8?B?UlRHSkcyczZpOE5henVhZ2FDVkJlM2EwK0lXcEZadGRDZHFRVGNOT0xsYXl4?=
 =?utf-8?B?cFRtWU02UEJCSUpHLzJucnBhZWlGQTUzeURRUVVrbmZ6WjU2anlFRHI1TGVj?=
 =?utf-8?B?V1MzMmhLRkNFZnRlekMvUE9SeGNvc29YRWNJOEZMc2JxSldKS1cxTXMvOXRv?=
 =?utf-8?B?aDlqZVhhdnpiNzRsK2IvQWJQOEZ5WmVSZm0vMCt4UXY4QUhwaXR0NFdWakVp?=
 =?utf-8?B?SmVndlgzODlITWQzRm1COFZqU3FKd3dFeENDZGxVQ1dEbTJyMkNIc3NsN0NN?=
 =?utf-8?B?cGpoaER2NXFYczhJS01CcDI3aHdjV1ppSHg1V1dheWJDUUdNV1pOa2pMazg1?=
 =?utf-8?B?N2cxbUROZkZ2c2xKNTd6SUFRK3JOS1BkeTh3OFkxTGxUcnoyejRuanh6TWdJ?=
 =?utf-8?B?ZXZoemR2RFVFMTRHYlBWRnUwQWRQa1hkaXFSK0tmV2xJc29zcXB3blc5NzRs?=
 =?utf-8?B?dzFFYytkdVA2a0c2cXI3Tk93QUIwN3RoUTRXMk14QzFEY3FGWG56elUyZUti?=
 =?utf-8?B?RzRja0VLMWNxc1VCSDFnTU94V25wcHFyL0l5ZnJzeXJpWjM0OGN1bm9WYWVP?=
 =?utf-8?B?L3ZwZ2l0Yk93TWd0STYrcGhkczcxNXR5M1oyTUpucDBvQmF6NnRjS1R3VGNa?=
 =?utf-8?B?V253dllVRzRtY1RhdC9Zd1o5U1BxcmFrOEVZTFdUNWp4UDhQM0xvb0VrRGhU?=
 =?utf-8?B?RmlkeEhpUW5tRkExblVUT3d4UURUQUZkem9wdCtlTUpMVlZJQmdCZWlQZTFa?=
 =?utf-8?B?d2xkUXlOQlhoUjEvbkhNclk5V1FmQnBDM1BhdWpXbXhscEgxS282enN3NVBI?=
 =?utf-8?B?eWFUTnppN2ZBMy8vN3dYYnJvdEM5QVdvZS9Lc1F0TGowY0dQYnNzWjhONnpy?=
 =?utf-8?B?aW1sQTY4c1cyNjA0bWVZSHRHVDErMnlwL1RFQ2xGM05pbUgvQVF2b3M2QmE5?=
 =?utf-8?B?c05uMlJKZnhlV2NnWkhzMk1oL2xja1JiTlFsazhOYlZBb3BBTklGY2lWVTNa?=
 =?utf-8?B?MXp5MHlLVmlCSnAyYTh0ZnBJOWI4TGliUnlBK1g2SGpEb1RtQnF3SFZpVjAx?=
 =?utf-8?B?di9UbU1OeUZFU0Foakx2NUV4d1haL0thYTFMR2dyYXM5dkZ2Q0JFUW4vamFv?=
 =?utf-8?B?d040dEx5aVBYaFNkVE1CNmlwWVVYRDkxN0lOMVU5SUcwRE81S2tSUkhtcUg5?=
 =?utf-8?B?YUNVYlQ0cFVqZEtXTXhuNDhJR2xKSWpFK0ZKOUxRRzRsRHRNVzVMTCs5QzJD?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4e3785-04a9-4e68-e6fe-08dcc16593fd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:15:19.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPGz6arSRM6AH/5cNRSctM2dYfn4TTuIiK3sZnDOA0V6UgREgcOCEEA0Oz0nxVwsSIry7fCH0Vhf//yjwA84NqoybZfJKWFTJZmdDLeQHBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-OriginatorOrg: intel.com



On 8/20/2024 2:56 PM, Tony Nguyen wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Use always the same pf id in devlink port number. When doing
> pass-through the PF to VM bus info func number can be any value.
> 
> Fixes: 2ae0aa4758b0 ("ice: Move devlink port to PF/VF struct")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

