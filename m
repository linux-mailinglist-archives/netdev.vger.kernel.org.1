Return-Path: <netdev+bounces-121487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF41E95D641
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747481F22247
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83857190682;
	Fri, 23 Aug 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+9g5/z+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EA3A8CE
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442824; cv=fail; b=gnDNTRLXTMSKkMrGXKEgZ8Dno9IWkQxK2TCoM6vpuuFn+E7Dc7FnSXc71ry9zoGUFje+gfqgyIWmUyf1PlzujOoddDYf+ZYORHtLIiJl6XPrhCAIlAGUp9FFeGDoG0RzdL1idCxMwIwZiC/RDZ8hEcoQ9A4EUSaeJ2Wy1j0HeLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442824; c=relaxed/simple;
	bh=z8HYLmjLXvEjwBC1oD6whbJ+bkU1+c6MMkCDV2pmvFI=;
	h=Content-Type:Message-ID:Date:Subject:From:To:CC:References:
	 In-Reply-To:MIME-Version; b=qxet6X5zStqAnhs3eGdPKX6ekWJB9BDe6M04f5oTHt7r9RmeZ+cZD3T6twVv/Hr3B+IlTdEgdmugImeRZ5lcJlN9khxq5zTFyb3hexkvvKKPUQhrxOogg9x707ZexC5oyZvKtVN4gEc251njnB6kUnSBabo3AqyBXBCUFM4ps34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+9g5/z+; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724442822; x=1755978822;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:mime-version;
  bh=z8HYLmjLXvEjwBC1oD6whbJ+bkU1+c6MMkCDV2pmvFI=;
  b=S+9g5/z+6mL19CTspDuBubKbAErWngfM8jaehWRUi62Af5AtEGMTBHqs
   KaPN6StUJjF2hVXbjo99cMBw61O5iyfcVR2Gs0SpsV1mWKjJmKyrWcrqM
   nxcczI+H/YPL44oQBHTgP7+FEIwQQJoHldG8gwjhGUkuMn7p9uQauaEVR
   pJ9lNoY6HnfuV6sm6BPlUM1ALYH7fgvWvsCgMg186PRKH6hx3dbREuW0+
   PdBay1Mu+N4NPBlhOX81KTNz876NjEym/dSz6DsIgaMzQhvdfkziu3Y85
   CYCNH/prXUxWd1muftF9JxGzQn1qXbx05Avgm7jd8mQXKYMfzOrHpBeJK
   Q==;
X-CSE-ConnectionGUID: qBAFYMQ4RnOSm89gZUKmGw==
X-CSE-MsgGUID: dq9ubA+6R5u407+e96tP7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22815586"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="22815586"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:53:41 -0700
X-CSE-ConnectionGUID: FxzYxN5zTQSe88ywwg6lSg==
X-CSE-MsgGUID: HmrQEFqIQ66GKIxIrxTjUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61913597"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 12:53:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 12:53:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 12:53:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 12:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UU+UknRLYHXrqrz+bcAv3PNc0f18UOV7b++z+NKkcmOLssbjuJH1QU8korU+y9JOf4POUIBes1qnOU5qRUzt76CCdUqszk/KVGfhcM0Dp4LC685bljhdpbaq+f2ktN+YA9qDJpxBEwZzxfvPx1xXLnEd1qPBWOLxfVwR0dRkZEcYvXJ+C34dvrDwkWo91mDxdVtwtdvAbvIIr4vziPMcyoOHsn0+XKHsGmQbYmBeCEXG36CXfUpu/KSiOzo6HEQuOTbijogfNkKWoGfkXf0XzHdhwRV28i2PIrW6IxBPLVYlOwaVurz1rZfZZuda9aXWyjztxWsAgImAsAAbrfEDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMShI5LPUYTeDpxoLArIHizc5Hy/GNz5OJ2nNepvkXQ=;
 b=SWIwyVdzR/db4PGLMCmDADnj4FARlKZdePFZPKMc7r8fIxj1DBB9vPG5tLklb6ZRAXjD+yJGT4lyKL76gYvsQIeETF8Z4echve5Jx6/gU3COO4MGsTRYI/tyDG5XRwKzEJT0+9JLCWeA6xZrwST+gZPtQBeVzwzuj9E1+Ew0qgZqhg1vk4NNNPV8ONJX5MQfAXYr+VzFe3W1Q+5R0MAHaHgKiY93pizexx3lZk0rTJeuE4TjjhLKdRiGX4tsun9R8XBFNwTZcrPprbgmA5uRyMJp6JM28ctzlcxPDQR7Yoilpzb8+GA2pqLp4f0ppvjuZOsxOlZSuLCkt9N/2v/weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 19:53:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 19:53:38 +0000
Content-Type: multipart/mixed;
	boundary="------------nu9z00GWcj9k5O31nBAAo0R1"
Message-ID: <86162cd5-8d5e-4f75-94e0-842684cd432a@intel.com>
Date: Fri, 23 Aug 2024 12:53:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
 <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
 <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>
 <20240821135859.6ge4ruqyxrzcub67@skbuf>
 <0aab2158-c8a0-493e-8a32-e1abd6ba6c1c@intel.com>
 <20240821202110.x6ljy3x3ixvbg43r@skbuf>
 <7f9c481a-28a9-439f-a051-5fd9d44aa5a5@intel.com>
 <9170351b-3038-419a-8414-fe8513a5bb57@intel.com>
Content-Language: en-US
In-Reply-To: <9170351b-3038-419a-8414-fe8513a5bb57@intel.com>
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f309f1-544c-4dd9-8694-08dcc3ad47ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGUwUVliZ0hwVWJUZmR5WTJRN1VrSE5KRzF4NjdVeUFqR2tQcUN6UitnWjB5?=
 =?utf-8?B?MG1KRTVCWDlVUmp1VlFUSDhnNTczY0lBYTBYMURKQjZQNmRzQVZmZ002dHNt?=
 =?utf-8?B?aTJtY0p2L0FuQ1Fxd2pwWTVUOUlYYmVvQStuRndMZmRHZytmTjlMbkE2QjM4?=
 =?utf-8?B?TDhQdUs4OWhGK0I5SjdMdlpNU0hmcEJ2MkNUeGdpRTVuajJ3VHVCbDF5cENX?=
 =?utf-8?B?Tml5Z1UramtwSzVWWjlvSGxUN0d3NTNTTXdpWUpIUjJNTTNPcXpEak9qQUpG?=
 =?utf-8?B?dWpFL3pQbTc1c1JVUGxKUFBrRGg5dXRQSWRQSXhRQTZvS1N0UTZxNXh6YVFk?=
 =?utf-8?B?TW45U3B4bVJ3QytCZlQ5SXd0WkNOWXR3eTN3YVRVdGxGSHYvVWticGJ1RCts?=
 =?utf-8?B?NC8wa2kwOHNlWC9YYVRXRTVIZVBYT1VMSTBlUldXcVdDeDRjZUkvVmo3L1By?=
 =?utf-8?B?UVJHZVRqaTBiSTB0ei85eXlHZ21HSlUwVU5sMFJrMTExU3BwZEwvR2lCTWoy?=
 =?utf-8?B?NVZyQi9TVEplN1cyV3Fkc2pENDMxYU5wMi9sSlg2Vmp6WFk4VGJBUFpvUnl1?=
 =?utf-8?B?Sk9QMWJBN0l5L21jazRHbm9UNTdXb0Rlc2RUV0xoWk5WQ0Z3NFhsb04rbWpZ?=
 =?utf-8?B?MXd4cHRDcVZRcXNYM0VrZXhzQWhMN2J3dm1rVmdKNml5U0p1bGhmYXNMeXBD?=
 =?utf-8?B?SHZGQk9aNXUwU2NlbW9jZlg2OFN4M0cwZy9XWGtDWlQrYmZMSzZrL2pEZXda?=
 =?utf-8?B?cWpqR2ZYWlRFbFBmTVNNNGF6bTY4bmthdUJ0d3RxdTRrSUJEWlBXRWRzNm9O?=
 =?utf-8?B?WGErQVBRNGdBbkl0NFduVE5RTkdYamdtdDhTNUdwUy9aQ1JGWFIwblc2SUZF?=
 =?utf-8?B?Wk05bkx4VGxLR3I5TjZXeGpTYkZDMm5sNkZCRlNYN20xckRxbWYzcElZWSta?=
 =?utf-8?B?Q3RhMVgxb2RzTHhRMGJtaGk0MXJ3YmlRaWp3NnNTU2V0eVVLOUhSd0pxZkFx?=
 =?utf-8?B?bWpIa29BeFhtM2NnLzJyQmltdDhSQlB2VGhrc1VGeHdYUFpjSnZVdzVFanJE?=
 =?utf-8?B?WTF3b1d2QnhqeFVyTzkzb3lrcGdhbTlTaHU5K0k4b1ZoZGFoOW5JTjR4ZVBW?=
 =?utf-8?B?dXAxTjhqTVJGaXRRcDhISFF5NVYwUFJScGNacHZGYXhhWmg1R1pFUWszTW9x?=
 =?utf-8?B?UllJWS9IUk1UOENpb1U5aDJaV2FNUXVlWC9kdkVCdXpSNkFQMmRqOG8zaHFU?=
 =?utf-8?B?QUFpczdxb2JnN29lVGFHdjNvWitWOWNLNk8rTWpKTmhoMmdtZHR4VHBDdVdo?=
 =?utf-8?B?WFhRK1lYZWprb09MaDFvWDMyTUdiWWVrT1pjOE5aTlZPMnNUVHBabFRmVTdZ?=
 =?utf-8?B?czk3Z3JOK2FyRllQeUhzSkE3ci9HeG15MEhTM0FqQTlGQVB5UWVGZ3djbUNE?=
 =?utf-8?B?Ukh2NzdPbjhQVXI2MERvSVNBaUphQm14OTdNS3UzZHpMMmF1VEp0eGlmYkpi?=
 =?utf-8?B?cjBFQmxWYVFCSUhMekpkaEszanJMa1pDVk9vekRaOXQza29WRm54bGVydDFh?=
 =?utf-8?B?RFJvTUZYckJaZDBEdUg5ZFZDTG8xSmxOK1VLZWQ5Y0V0ZU5LZDZUazQvMGYz?=
 =?utf-8?B?eEVhaHNaU0E1dU0yLzBSVGEwVE91TjVVSDZibktCS0ZQWWx5d1dpL3YyV1dH?=
 =?utf-8?B?K2JqaDBvUUF3OHpwYjNvRENVQU1LdnVPZWFTNnJWNFN5Wm5idDNMd3JmbE1V?=
 =?utf-8?B?NmhUWGFjZk5ZUG5ROEhLWHNTQ0dZT3E1aDE5cFVCaTlvOU1PRkUxYnBTb2I3?=
 =?utf-8?B?Y1NVdjhqUmRvSjRlaWx3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGN1azZCalpHTUNWNHFpSC8xWUhWdDYySjhaMmg3cERwdWlqc3YwdXg1YWlY?=
 =?utf-8?B?b0ozb2xjcm1pYjJzZ0pFNlpBdnpuL01zTENNdklhRnA4OENlMURNQWJUZDRy?=
 =?utf-8?B?aWhxTGVrNk0rVmxVekhrNHRiWi9JT3YyWWtseFFibjdTY1pBQlJHWnhTMktX?=
 =?utf-8?B?TFlkbkJvdGEydHhMeHlsdVB6QUxmUERHTU54YWU3RlNJODRWTXA4ZGxZTmIz?=
 =?utf-8?B?bDFnOVRBMVJSRnl6Ukd6ZDAxQ3ZobGFUTjk5VDBJd3NxZkduY1pzZkExbEU1?=
 =?utf-8?B?OWlqbWJGSmJOVEVjcnIzWW5XbFF2a3JpU1RMSHoySDBPM1VyczVzN2RFWDJX?=
 =?utf-8?B?UXhxSmtSMHZnSFhvWkhGTE85a1djZVlWMVlnRjcwb2tQTE92R2YydzA3bWpX?=
 =?utf-8?B?UWpOR3AvWVVTd1UvRVFyMTl0cFNRelZYUHlMZXh1VERSYWV5TUYycVNaejEz?=
 =?utf-8?B?YzBkb1RtTk01K2VOQXAxdjVRNE9IcUM2cUhMNm15bUR4UG1xMEpKM3FEYXZp?=
 =?utf-8?B?NTcwVHo4b3l0eXpqOWxoZmFURlIwa0d5ckFFVHdnYnVvMDRtUnBFWE1rcFZs?=
 =?utf-8?B?UEN5SFluZ2RYckEyc0p1VGZMQWRMaytmclV3emN6RzZmZzBLbGcvRVN0NE9G?=
 =?utf-8?B?WEdVMVdINXNlSXU3clFOOVlYdzV1Q2V3eGl1WWZJbHZjWXp1MGMwd2JRNHpy?=
 =?utf-8?B?OHUrK21WNlkyOThYQkp2UFJ1QkF5RlliWXFEZGpmRDVXVGtST2NDaEdjbSs4?=
 =?utf-8?B?dXVWdUxzdFVvK0I1cEVrdnF0OE9nYlM2Q2p6Q0VMVjR1T1Y2Rm9xN3FlbmFW?=
 =?utf-8?B?MzBzRFJiNWY0eGlqV1RzYnRpZHpxdEFsOVhEZ0QrWjFMRm55eXVlTXVzUWRj?=
 =?utf-8?B?cG9kYTRwenpHdnd3TjRHcURtKzZoQ1lPMjZBY2FBQjZEbElPbWdWT0xvSHI3?=
 =?utf-8?B?VmR2UzBzZ3FoOW5NOUhMVThyV1ZUM3g5UUJycGRWVndCR2VJVExWTlBac255?=
 =?utf-8?B?TEVQa3p6cmxMNzRpc0pJblVoa3NXTWFybHlmS25UMjRTam8wMGZwWS9RUXR3?=
 =?utf-8?B?WnB2a2U5S2dsQlRQMjZkYWRkSVJBQXM3MkpyTzI5TktiOGtlai9hR0VsSmli?=
 =?utf-8?B?RDlza1pDdC9MbDFhNnZUMHBaMzhFemdVam9vUGdoUk9KZjBGc01TbVJ5bVJo?=
 =?utf-8?B?ajFvSy9Ea0I4OFNUekJLRU9WbGJSTHh6SEFlcVZSUFh4dDJ0WTV3Nm9ndVhX?=
 =?utf-8?B?cXd0THJEWElIdDFKQzRkTldDejNzNFFPL1ZGM3hXbUpWNE1RNFRCRWtFeW9K?=
 =?utf-8?B?cmprNnplKytMdmpHU2VsYXJZU2JzNUNwMmxTQXVnNlM2dXdvaHlUNVZZUnpI?=
 =?utf-8?B?KzBhMXpIM1U4cHR0SmpPMG1MM1pCcFhDYUlXb3QzeUt6WXZFdTVLb3JETHA0?=
 =?utf-8?B?blJDS2Nra0d1NXRDRC9RWE91cWtBQnVwaWxHTnJuRCtvV2t4bkp2bGJ6cnVs?=
 =?utf-8?B?Yjl5MGs0T2x3WGVVaFVSYVRxclFRUGJRbkE5RVo0eThwdUJadjdnejVZL3Q0?=
 =?utf-8?B?UXBUV1B1dTlpSHhIRVVlcW5XbkFnN0pFMGFxUEExcHBneUJxRUw1eS9TQmIv?=
 =?utf-8?B?d0VoSGJQNXIyT3FMZ296SlZVcWo4bzBxb214bXRHR1pwUFozdWJyenNPelhw?=
 =?utf-8?B?OE9CY0RpRjhIcE00WjZZdnRuKzVDQmZPbWlid3Q5ZG11QVFDRjFPNzNkWldJ?=
 =?utf-8?B?K3ZOZUVHZ0t1cGRkcVZZSk55czRtK0lFbXBBcmlPZk9HMW5LTzZqZ3VmT3VG?=
 =?utf-8?B?T29GMGIyTkhibmlKTEdsekdJdUtpUnVvelpSVmNnTGVWUHR2U2Fhb3BLL3BP?=
 =?utf-8?B?aWUvN1l1N29KaGRncmoyZEZxYmRSQXlkdkUzUjlMN2tEMCtCWHpDR0RTdjVQ?=
 =?utf-8?B?aDJham5Yam9TV2tRSFNWSWJHV3duWGdEYjVMTzRrQjE4WWJzbW9oZ1Q5M1Uw?=
 =?utf-8?B?RDdrSG01VjBzcVpZQjk2SzhhZUMwWEovV0tlY3p6ZnEzNlUrb2xJNW40TjV2?=
 =?utf-8?B?bU45TllEdDZBaDFIeDR1bm1zZTdFVndVcHpHU29WbjF5V2lDdXQ1d2NRUnN5?=
 =?utf-8?B?b3VoNmRzaGtFN0xCL3ZabjVrK0VGVkpuY1RTSU4yVndKVm9saWdZMTZENkto?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f309f1-544c-4dd9-8694-08dcc3ad47ae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 19:53:38.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnV7+Ko2iaU2WNkVwm6GeH60pEUxe3kYtnwF+xEKMPjbqqSSdUQ6pZ84SUN0dg8prgbIalTXoYK8OX0RW0eT8SnmrvRPtfmjYK0ogEMJNl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

--------------nu9z00GWcj9k5O31nBAAo0R1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On 8/22/2024 6:41 PM, Jacob Keller wrote:
> 
> 
> On 8/21/2024 4:41 PM, Jacob Keller wrote:
>>
>>
>> On 8/21/2024 1:21 PM, Vladimir Oltean wrote:
>>> On Wed, Aug 21, 2024 at 12:12:00PM -0700, Jacob Keller wrote:
>>>> Ok. I'll investigate this, and I will send the two fixes for lib/packing
>>>> in my series to implement the support in ice. That would help on our end
>>>> with managing the changes since it avoids an interdependence between
>>>> multiple series in flight.
>>>
>>> There's one patch in there which replaces the packing(PACK) call with a
>>> dedicated pack() function, and packing(UNPACK) with unpack(). The idea
>>> being that it helps with const correctness. I still have some mixed
>>> feelings about this, because a multiplexed packing() call is in some
>>> ways more flexible, but apparently others felt bad enough about the
>>> packing() API to tell me about it, and that stuck with me.
>>>
>>> I'm mentioning it because if you're going to use the API, you could at
>>> least consider using the const-correct form, so that there's one less
>>> driver to refactor later.
>>
>> Yep! I've got those patches in my series now. Though I should note that
>> I did not include any of the patches for the other drivers. I'll CC you
>> when I send the series out, though it may likely go through our
>> Intel-Wired-LAN tree first.
>>
>> I've refactored your self tests into KUnit tests as well!
>>
> 
> I was writing additional tests and I think I ran into another issue with
> QUIRK_MSB_ON_THE_RIGHT, when the bit offsets are not aligned to a byte
> boundary:
> 
> When trying to unpack 0x1122334455667788 from the buffer between offsets
> 106-43, the calculation appears to completely break.
> 
> When packing:
> 
>> [18:34:50] box_bit_width = 3
>> [18:34:50] box_start_bit = 2
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 2
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 5
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 3
>> [18:34:50] new_box_start_bit = 1
>> [18:34:50] new_box_end_bit = -3
>> [18:34:50]     # packing_test_unpack: EXPECTATION FAILED at lib/packing_test.c:264
>> [18:34:50]     Expected uval == params->uval, but
>> [18:34:50]         uval == 1234605616436508544 (0x1122334455667780)
>> [18:34:50]         params->uval == 1234605616436508552 (0x1122334455667788)
>> [18:34:50] [FAILED] msb right, 16 bytes, non-aligned
>> [18:34:50] # packing_test_unpack: pass:19 fail:1 skip:0 total:20
> 
> Notice that the box end bit is now negative. Specifically this is
> because the width is smaller than the start bit, so subtraction underflows.
> 
> When unpacking:
>> [18:34:50] box_bit_width = 3
>> [18:34:50] box_start_bit = 2
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 2
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 8
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 0
>> [18:34:50] new_box_start_bit = 7
>> [18:34:50] new_box_end_bit = 0
>> [18:34:50] box_bit_width = 5
>> [18:34:50] box_start_bit = 7
>> [18:34:50] box_end_bit = 3
>> [18:34:50] new_box_start_bit = 1
>> [18:34:50] new_box_end_bit = -3
>> [18:34:50]     # packing_test_unpack: EXPECTATION FAILED at lib/packing_test.c:264
>> [18:34:50]     Expected uval == params->uval, but
>> [18:34:50]         uval == 1234605616436508544 (0x1122334455667780)
>> [18:34:50]         params->uval == 1234605616436508552 (0x1122334455667788)
>> [18:34:50] [FAILED] msb right, 16 bytes, non-aligned
>> [18:34:50] # packing_test_unpack: pass:19 fail:1 skip:0 total:20
> 
> Specifically, it looks like we basically fail to calculate valid new box
> offsets.
> 
> What's weird to me is that when the box width is larger than the start
> bit position, we just calculate the same exact offsets, so I don't see
> why the existing calculations are there at all. Something is obviously
> wrong here.
> 

Specifically this is making me question:

Does QUIRK_MSB_ON_THE_RIGHT mean that the msb of each bit field is on
the right? or does it mean that every byte in the buffer has its 8 bits
flipped? It seems to document that it applies to the bits within the
byte, but not to the byte ordering.

The code seems to be trying to do a mix of different things though, and
my attempts at fixing it haven't worked properly yet.

I think I was able to get pack() to behave correctly, but unpacking
seems to still be erratic. I tried adding a few more tests but so far
haven't figured out what is wrong with the unpacking code.

I think the attempt to re-use adjust_for_msb_right on both unpacking and
packing isn't working correctly. When unpacking, I think we end up
masking the wrong bits.

With the attached patch, I was able to get my test case for packing
fixed, but the following couple of tests fail:

>         {
>                 .desc = "msb right, 16 bytes, non-aligned",
>                 PBUF(0x00, 0x00, 0x00, 0x91, 0x88, 0x59, 0x44, 0xd5,
>                      0xcc, 0x3d, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00),
>                 .uval = 0x1122334455667788,
>                 .start_bit = 106,
>                 .end_bit = 43,
>                 .quirks = QUIRK_MSB_ON_THE_RIGHT,
>         },

packing for this test works with the attached patch, but fails to unpack:

 > [12:49:53]     # packing_test_unpack: EXPECTATION FAILED at
lib/packing_test.c:282
> [12:49:53]     Expected uval == params->uval, but
> [12:49:53]         uval == 1234605616436508544 (0x1122334455667780)
> [12:49:53]         params->uval == 1234605616436508552 (0x1122334455667788)


the last few bits don't seem to be included properly.

I also tried a test case with all bits of the u64 set:

>         {
>                 .desc = "msb right, 16 bytes, non-aligned, 0xff",
>                 PBUF(0x00, 0x00, 0xe0, 0xff, 0xff, 0xff, 0xff, 0xff,
>                      0xff, 0xff, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00),
>                 .uval = 0xffffffffffffffff,
>                 .start_bit = 106,
>                 .end_bit = 43,
>                 .quirks = QUIRK_MSB_ON_THE_RIGHT,
>         },


> [12:49:53]     # packing_test_unpack: EXPECTATION FAILED at lib/packing_test.c:282
> [12:49:53]     Expected uval == params->uval, but
> [12:49:53]         uval == 2305843009213693944 (0x1ffffffffffffff8)
> [12:49:53]         params->uval == -1 (0xffffffffffffffff)

In this case, again it seems like the bits on the tail end partial bytes
don't get unpacked properly.

This test also passes packing with the attempted fix.

I so far think the likely issue is with the way we handle the box and
mask offsets. Somehow we must be shifting things in a strange way that
causes us to discard bits, but only when we deal with the
QUIRK_MSB_ON_THE_RIGHT.

Thanks,
Jake
--------------nu9z00GWcj9k5O31nBAAo0R1
Content-Type: text/plain; charset="UTF-8"; name="maybe-fixed-packing.patch"
Content-Disposition: attachment; filename="maybe-fixed-packing.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBjL2xpYi9wYWNraW5nLmMgaS9saWIvcGFja2luZy5jCmluZGV4IDgwYzk1ZGFj
YmZhYS4uYzdhYWIwMGIxMDZjIDEwMDY0NAotLS0gYy9saWIvcGFja2luZy5jCisrKyBpL2xpYi9w
YWNraW5nLmMKQEAgLTE0LDE0ICsxNCwxNiBAQCBzdGF0aWMgdm9pZCBhZGp1c3RfZm9yX21zYl9y
aWdodF9xdWlyayh1NjQgKnRvX3dyaXRlLCBzaXplX3QgKmJveF9zdGFydF9iaXQsCiB7CiAJc2l6
ZV90IGJveF9iaXRfd2lkdGggPSAqYm94X3N0YXJ0X2JpdCAtICpib3hfZW5kX2JpdCArIDE7CiAJ
c2l6ZV90IG5ld19ib3hfc3RhcnRfYml0LCBuZXdfYm94X2VuZF9iaXQ7CisJdTggbmV3X2JveF9t
YXNrOwogCi0JKnRvX3dyaXRlID4+PSAqYm94X2VuZF9iaXQ7Ci0JKnRvX3dyaXRlID0gYml0cmV2
OCgqdG9fd3JpdGUpID4+ICg4IC0gYm94X2JpdF93aWR0aCk7Ci0JKnRvX3dyaXRlIDw8PSAqYm94
X2VuZF9iaXQ7CiAKLQluZXdfYm94X2VuZF9iaXQgICA9IGJveF9iaXRfd2lkdGggLSAqYm94X3N0
YXJ0X2JpdCAtIDE7Ci0JbmV3X2JveF9zdGFydF9iaXQgPSBib3hfYml0X3dpZHRoIC0gKmJveF9l
bmRfYml0IC0gMTsKLQkqYm94X21hc2sgPSBHRU5NQVNLX1VMTChuZXdfYm94X3N0YXJ0X2JpdCwg
bmV3X2JveF9lbmRfYml0KTsKKwkqdG9fd3JpdGUgPSBiaXRyZXY4KCp0b193cml0ZSk7CisKKwlu
ZXdfYm94X21hc2sgPSBiaXRyZXY4KCpib3hfbWFzayk7CisJbmV3X2JveF9lbmRfYml0ID0gZmZz
KG5ld19ib3hfbWFzaykgLSAxOworCW5ld19ib3hfc3RhcnRfYml0ID0gZmxzKG5ld19ib3hfbWFz
aykgLSAxOworCisJKmJveF9tYXNrID0gbmV3X2JveF9tYXNrOwogCSpib3hfc3RhcnRfYml0ID0g
bmV3X2JveF9zdGFydF9iaXQ7CiAJKmJveF9lbmRfYml0ICAgPSBuZXdfYm94X2VuZF9iaXQ7CiB9
CkBAIC0xNzAsMTMgKzE3MiwxMyBAQCBpbnQgcGFjayh2b2lkICpwYnVmLCB1NjQgdXZhbCwgc2l6
ZV90IHN0YXJ0Yml0LCBzaXplX3QgZW5kYml0LCBzaXplX3QgcGJ1ZmxlbiwKIAkJLyogV3JpdGUg
dG8gcGJ1ZiwgcmVhZCBmcm9tIHV2YWwgKi8KIAkJcHZhbCA9IHV2YWwgJiBwcm9qX21hc2s7CiAJ
CXB2YWwgPj49IHByb2pfZW5kX2JpdDsKKwkJcHZhbCA8PD0gYm94X2VuZF9iaXQ7CiAJCWlmIChx
dWlya3MgJiBRVUlSS19NU0JfT05fVEhFX1JJR0hUKQogCQkJYWRqdXN0X2Zvcl9tc2JfcmlnaHRf
cXVpcmsoJnB2YWwsCiAJCQkJCQkgICAmYm94X3N0YXJ0X2JpdCwKIAkJCQkJCSAgICZib3hfZW5k
X2JpdCwKIAkJCQkJCSAgICZib3hfbWFzayk7CiAKLQkJcHZhbCA8PD0gYm94X2VuZF9iaXQ7CiAJ
CSgodTggKilwYnVmKVtib3hfYWRkcl0gJj0gfmJveF9tYXNrOwogCQkoKHU4ICopcGJ1ZilbYm94
X2FkZHJdIHw9IHB2YWw7CiAJfQo=

--------------nu9z00GWcj9k5O31nBAAo0R1--

