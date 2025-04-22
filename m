Return-Path: <netdev+bounces-184898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30ABA97A16
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73E33A9374
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A23B22F76E;
	Tue, 22 Apr 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWS83qYj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6272701AC
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359689; cv=fail; b=EM5kfOQY6LsUPE8zGvU8i8yh6FtsGsZXoqe7YcApTi3hjcopuDCqoGeTVv7XwgNA7q0vsnC96rfMfKa3aRQ6Bhjp2YL71h1F17UUOhQtzMUj6oA00kOfsMocuX31IBxJaECLluNGeGNwoNcSgtvdvSkKZ2MdTZh8TotAaEjtlSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359689; c=relaxed/simple;
	bh=YE4h2OEz2DaGMBSmu0koqlTCfiPYdyQfImIOyHiF+Us=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dqfhTDloqxVrhH9P19SmFlVBbdAcgv5FYZNoXmoZC5d/gGsTVTOeNZRX7NKHtDyGY/CFKIkk/2gFcyaSvz7xNQ0uf72vtCn/+IlRsMXQcMtKmdAxG8ydD1wlg/5vbeHBJe9rcQ2Rsk+/tt1lJXTHqJy+5u2cybcDa0A8QLyi6iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWS83qYj; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745359688; x=1776895688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YE4h2OEz2DaGMBSmu0koqlTCfiPYdyQfImIOyHiF+Us=;
  b=JWS83qYjFmORxLAWXZlzZgOC99OX1+OIZ1FK9YkP4I0Yi5ThZrgLyHtK
   aGt+3NZmL1or3/hW9/zIXDMG2zwekoMK4wNBmJy8H/7oHyQi43fiBWZAf
   tFiA3Ja13/YDdqSPxYJyjZdgNTphdblgexOiymxDv7uVFYxhoP8PNjj4W
   ImaPamk2B3gitrhdMFE6JplDn3I6hrWD2WBfVjo/qQhslaJWTsOVi4jRl
   hM7BJL9v94r11COT6BoHvalJ+ovUy8lhBi6endMz8di4KLlciNsaujlKz
   G851WsxwizFUd7PpW+HGIxV2hcNsee8AqG9VQ0x8kgqMamBWKCAp/9tSn
   A==;
X-CSE-ConnectionGUID: Hz1wkTfiSsy0mwGYRzJ8Bw==
X-CSE-MsgGUID: ortI8DyISpCx4fMT7aPSEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="47036105"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="47036105"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:08:08 -0700
X-CSE-ConnectionGUID: Juv8cjQoQV2iaUt4L7Z5+g==
X-CSE-MsgGUID: 4T8MQdPhSUy+CcL5bqsbVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="131976876"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:08:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 15:08:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 15:08:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 15:08:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnuT7jm9wDpzKcGvMEe7AmcCl4I0WeIC9Wb/9cLX6yGFXYwXUDHuhBEDm2v+ifhA1DeDhH8NYiF2jc/N1v6rRzdFu4dpWB43Dyfs4LM48aG8oPZ6MwLoNF+4iuHUMvS2MhkNV06HGgGI8G0IopabAYiy4o9jFJRjtr8gEygSAO6VUEeHxsKXzV2sPB8yczvFVT5CR3gLNx4ssroTqcw/om+EZqvWjEZrZITbUYj7MESC7NxLcpBckD6yGlvqrSzgVqXYcaE6CiK3DNXtoDBDaHJ/rgM8CzH3xPnwlxRAIzbaHWtpAIGhqkMmYmdG2Hnv8SOzKEvmXkAXT3K3J5BmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqW3+GbBvu5DJYp8iUarZy0jfvU5SWV2NQ1FVs+jtsM=;
 b=pIsvKOvBw/gJiITg5QoaCbgpzGDPuuMjC5c0LqUapM+munGNu0kzqnVFxrA3IDgcopWmSbLtNDp7B7aqkQ1NdUZABwz7geIUBtp9ginGrZ1BcJnFRpCBI7zopBTFaZtnSv6DdwYBBYkO/FvdMYynm4dW4i1Bftrn8I5O6+HG0ZUbG2wH6u90HzVzYEqOQZKk/X526zij2wFOAmALrjxUU/CdNBKVhJTgmm7roUw8cihL7cNswZC2GU+/NOdaQgYpo2Zq7EOatZ6E9xYbSe1+0iF8Ae+zy2og1zZu5yYpcyDq9iJ7yfIfjTuI7HkevrkG4JEoLBPuRwlxuy7qH100MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6272.namprd11.prod.outlook.com (2603:10b6:8:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 22:08:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 22:08:00 +0000
Message-ID: <cb2af494-bb50-4fbf-bf83-4b8efa7a637a@intel.com>
Date: Tue, 22 Apr 2025 15:07:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: use pci_prepare_to_sleep in rtl_shutdown
To: Heiner Kallweit <hkallweit1@gmail.com>, Realtek linux nic maintainers
	<nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <f573fdbd-ba6d-41c1-b68f-311d3c88db2c@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <f573fdbd-ba6d-41c1-b68f-311d3c88db2c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:303:8e::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7511e019-4a67-498c-4a9a-08dd81ea255c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUVCRXBPRWprQWRIdmlFTDFsZkVnM1JxeWswYnlpTFcvNmZvVDRYSlVKT2Vz?=
 =?utf-8?B?eWlJeEVBQmtFTCswVlltR1kxT21ScmYxcHltdC9tQTRnMjVuUXVCME1FWkxO?=
 =?utf-8?B?ajlxbmFaZ2tmTXlUNTloSjBnZWMzR1lzNzZPRVhPeVAvdkZxdHNEU2FLNHg0?=
 =?utf-8?B?MTBaT0IzQU5QdXhSMEFwNXFFY1dWTzdYRVdJeVpRT2VrS2ZpY0EvSHEydGlO?=
 =?utf-8?B?YS9rZnVINnZUVkxaMmZUM083TXVEVUtFcTEzNW9QWVRMTU9qZjJwcGV4K0pw?=
 =?utf-8?B?Q0hNZmduVHFIQWRReDAyMTMwVEZWN1VsWDMzU3J4RXRYTGZKb1R1R2FUOFFv?=
 =?utf-8?B?MlFFcXZsd0Y4UGY4eVJVU1FtektjR01XN3JRd3h3bVpBY2RhcjdBNG9oMGlk?=
 =?utf-8?B?YkZlYUYwSHRGNzByWDRDcUxKMDVoYUNpbnRVcXE4NG9xZFhDamZOeE5xUWEz?=
 =?utf-8?B?N0o4Q2hPUmxucWRzTlFTYkVCWGVNa09WODRPUklTK2UxczZqWURnTHFnSHNx?=
 =?utf-8?B?UUNINE83VVR3MGxoSUthT25HWWM0T29CYWdCOS9BelhzRkZYZHNXcXVKUGlU?=
 =?utf-8?B?ZEIrZ0JBeUhaeC9vako5UGRTa0h3MEExTEgzWWFJaU9RSGxvaVQzMzlPUk9K?=
 =?utf-8?B?VXduVnp2enRUK0UwclhQbkpmZzNOOEpLS3NnMkxlZzJ2MGlvUGRMWDRLeTEz?=
 =?utf-8?B?ZmFpS081V0swZGpER2VtN2Y1THIyaXBnQjBEL0RJc0RxUWxpUFlCMi9jU2lP?=
 =?utf-8?B?di9kZmNnajRUTVFDN0NhVXJ0Y24yUk1Ia0RGRDkwTTVUU1VMVmZ3dExnbWdF?=
 =?utf-8?B?UEVLRkZ0RFM1NkVRTTEvNXlMVFFhSjlTMzE4UWhlei9vTUVDa3FVc1liUFJt?=
 =?utf-8?B?ZFFVeDhldFQweUl0Lzdub3lxMC80MXdrV0RyMVZ1QVhPSzhqamFoWFBZd0lM?=
 =?utf-8?B?Nm5KSGtHaXZDb3dXTlZPdHY1NDRSZG1vcjhqMUZyTWJvdkptam5CaFUxMXUr?=
 =?utf-8?B?VktNK2puMFE3bENCTHhERUVNK3l6SFJPbk1oU00zeVhrbndONFhhMEw3akRz?=
 =?utf-8?B?S1BDaTlqcWF0WksrMWRQUWM1S1d0RFBrMnp4dXhiRTNZOEFwNVR0R2NoRTVh?=
 =?utf-8?B?Vm0yTmZLVm1BR3Y1RW4wYkF4OW1ySm5nM202Y2dPN2Y2Y25RcDRZZDJUMjJE?=
 =?utf-8?B?U1RoL1pPMGxZMk8rMlFNSDZDbDdWTGVnVEh2MTYwNWdndGRFK1FIaDBENndJ?=
 =?utf-8?B?WW5SOVpiMTVLZDMvTm1JL2dUTldvU2ZFWTZGS0k5WjJxV3J1Z3NwMFV2aUlM?=
 =?utf-8?B?ZUQvSHBES2h4QzZJckMwUFNNVUJhN1pINkJUNDFlblFJSXZNZklzcUNwZGQ2?=
 =?utf-8?B?U0ZBVU9vYnFPby80UU03WTU0Q0FEeDBDYlhrcHJuQVMwUHJVekxHZVp0djQ0?=
 =?utf-8?B?REdCWFg5bWRSZnJQYlZGc0FJOTNsNklMSmNiUUFxSTJqWjdDUDdZMUVwYWxn?=
 =?utf-8?B?eVZPdnl6TitQcGNRUFE0ek1zTkxtY05oTWorNkh0NGVDUlVsNk1WQ1FrSmlm?=
 =?utf-8?B?TGFIQkp2WW5ONVpJT3VlY1dnYnBuUW5kWkxIYW9wWlAyWXNTWmYrQ3EyUEZ2?=
 =?utf-8?B?U3QwdzlDUXhqN1c2RzlNUVhHUE1JUWZ4VHdoQlpCMnh3MllqYzJ1SGZ5TEw3?=
 =?utf-8?B?S1lPSndqMlNCcy9HQ21LRHdWUUlxSlZzZUp1SmYvQ3dpbHNlbHpSMGhOMmpN?=
 =?utf-8?B?K3JMNEtXRlZ6TGlXRDJYdGNRLzQ1eklKSTY4Ylc4RGNSQjQ4Tk90VThMdmp2?=
 =?utf-8?B?TnowaVB1RUhyY2JEcVlHTWpXdjdpcXlHdkQybjRBSDVzWENEcktKbThGRGs4?=
 =?utf-8?B?Q2Vmc0tRSFVQSUJhSlhHVDFLMUFDd0FjREYvVEhoYXpkSHVTU1FHRVpjNjlI?=
 =?utf-8?Q?PBc+IB2rMI0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SitycDJ2QlZTQkZXekM4NjZFTE5GbTZHaHN6UHBnMkhJemptSnlvd0gzaWM2?=
 =?utf-8?B?UEJpejUxZy9RMzBOQ211NDZOZ2Jyb2tRZERxbkpGaVF6NElOaGtRbEZCZ2RK?=
 =?utf-8?B?cVI0THplMmhtSXZPNUFsdkd6ajFKekhvVTN2ZG91NWg0M1FOVk12b1ZuMmVo?=
 =?utf-8?B?cHN0S3d6RHMyOGpLajIxR3Vyei9JOVE0eURuVDZxRng0SUMwc3NUM2x6bjNy?=
 =?utf-8?B?YVoycXRyWTRQYWtKM21Mbzk5YWJ6dk4xdEhWRFEzRVVsdXgwUnlPbjRZM3Vl?=
 =?utf-8?B?ZlZpWjVsMlN1NVJvdDdBQzlEV0hKSkQ4Y0NML09lSUp3bldRVnJNdkRheU56?=
 =?utf-8?B?WG1RWnE5RkRBNGlWamZxMmpjUlh1ODNTcGZZamdZWklMNXlRY05idzdsV1Ev?=
 =?utf-8?B?RjhVYTZ0cU5YaHF6M3RFeG4vQmdUYm4xSTlDL3p1ZXVlK3VhSEl0RFo2a1dN?=
 =?utf-8?B?RlVVdUUzVzNpRmtaaC8vaGpPZEhIWnBhYXVoKy9CeEpUQitVUmRTN1lWMlFP?=
 =?utf-8?B?TDdNNUczL2p4Q0l0R0k4cmVEby8xcWNwOFlJSjJPR1VQWDc5aUtsUitTM0dT?=
 =?utf-8?B?VjZSeEsxQ1lCZEltekU2cXFadmU4M0t0MG8zQjVFYWVTNUpGZzFpOXlxY05a?=
 =?utf-8?B?WDVBNko0d3VUYTBMOS9neCtEZDlPVG5NNmRSc0NxNU9HR1VUVXI2MUFkeHhF?=
 =?utf-8?B?eGlOZTNTeGE3R0twYU5BT1NyWG15QUE3aElpdUxiQWpWdDVjNDhMd29xQStZ?=
 =?utf-8?B?SDY1ODdyV1R1UzAxQko3TW83Mk9rWDFxQjJxREhDRWVqTzJzTFg3VjR0a2lJ?=
 =?utf-8?B?Lzl6RUxBRWFOYWxIRXorR1ZFZTdTaE9GWm9iUEg3UHBOYi9RWTNZUURKdGlT?=
 =?utf-8?B?QlpUZlFHMUpWb1pLNDh4TTNmamNTT05JU2kwNDZrTFFtQ09RT2ZoZUV6OE9P?=
 =?utf-8?B?cU0rc2V1R0pLczNpaGpFZ2lkN0NOZlI5QUpJamZpYU04WHdWaXk3S0NVaysr?=
 =?utf-8?B?ZTAvQzdaY01PZEhpNks3Zml5akFiYnN1V2ZZdjNSNjJTNzhZRWEwcnRYVC92?=
 =?utf-8?B?Wnc0bE5oSEJNMWthdzc2a0JLZkE1SFVEcTdrMThOUmxBR1NxaXpLU0FHY2Ns?=
 =?utf-8?B?T3k1VG0zNzQyTkc5OTRidG9nK2lRMDEwOGtnMzB0M2JQcE96MDloRS9JTXht?=
 =?utf-8?B?ZXhQd1RRNmxJTFZnMEZCSFMwL3lqYTBlMHhyRTl1NlY3cHJnUURkRWZmdkgw?=
 =?utf-8?B?dkR3N28zMlBLU1d6cm44c1MvbmQ3dUs2RzJzcGdIWFNDdUUyMmpwYUtnRytz?=
 =?utf-8?B?YjdIU1p3SzZHMnBrSDVtZTV3QTVXdlh3ZlFwMjRBMHp5Y0poM1hvQmgrSDdW?=
 =?utf-8?B?NmI3cFVqODFHL0JqdE5VU09JTjRTWG9abThwRUpHV0VGNHJXZmJyYjduQnNP?=
 =?utf-8?B?V09KR3pDdldrbFZxRnJKSTVxWjRlZ0Zvc0I5TEViaXBvQ3B5U0pDNnFPZE9l?=
 =?utf-8?B?R2FhcHpIK0pwWnlGbXJaZ0Z3SWR1NGJ0M1FTdXNuKy9TRmwxd294OTBBNDNG?=
 =?utf-8?B?QTFtMGhDRElmNHlvV1B0ZnRqV2x0bUlZNnRvQ1hKQXdQUjhBeHBPMDVzZWNo?=
 =?utf-8?B?ZWxMOG9PbGlLMXRERVcwZ3MyZkJ2dW1NVlE2RnE0YTJzRno2cG9YazUwTEdi?=
 =?utf-8?B?SmZmN2tQZ2xZRzRIVjM0RG44RWlEdExxcDFSZGFBRHd1Q1loN1AyVUlxZkY5?=
 =?utf-8?B?K2l6WW9EaXc3MVhldDJvek5pN1FzTWhCTWhTYklxWFdVbGFGMUlPZFR0RmRV?=
 =?utf-8?B?WWVEWTUrTkNkc096cEZib09UejBwYWRaOGtqbVRQQytld2hZak9hbUh3RWNh?=
 =?utf-8?B?TTMrdUd2Qm00RVN2ekNYdkNQckNReHpOWit1ZGlXazZPZTUvVGFIU0ZFMUJX?=
 =?utf-8?B?R1F6UnJsazZwV0x2ejA1cGwxSU5EUDUrb1NldmI0NEZpMFdoNDhTbld4bUFB?=
 =?utf-8?B?dEgyUkpxRlhXRTIwLy91dXN5M1pqZFZmZ1I0R1hIeWNaNGxKQyt2T1JVRTFa?=
 =?utf-8?B?TlM5NVlLbEpqU01LZWQwenVTaW5DSXR5OU9GZUdHaG9YNEZUbTVwZ3h0S2pS?=
 =?utf-8?B?UFF1UlhOemRmcnlGcWhuL0V6aEptZDlseERrL0ZJaFE2R09adHFMZXR4bjAx?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7511e019-4a67-498c-4a9a-08dd81ea255c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:08:00.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fuZFS7lF3LzaUAzrFx71dHKaQDtgZGTOV2UC3qeGylDIQV4FoV/KzNz2xHayG6ZbjwUEBP4OVvf6ZfIxa4shLRiyccLJAB8WIsUC0i1M7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6272
X-OriginatorOrg: intel.com



On 4/21/2025 2:25 AM, Heiner Kallweit wrote:
> Use pci_prepare_to_sleep() like PCI core does in pci_pm_suspend_noirq.
> This aligns setting a low-power mode during shutdown with the handling
> of the transition to system suspend. Also the transition to runtime
> suspend uses pci_target_state() instead of setting D3hot unconditionally.
> 
> Note: pci_prepare_to_sleep() uses device_may_wakeup() to check whether
>       device may generate wakeup events. So we don't lose anything by
>       not passing tp->saved_wolopts any longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index b2c48d013..64e30408a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5028,10 +5028,8 @@ static void rtl_shutdown(struct pci_dev *pdev)
>  	/* Restore original MAC address */
>  	rtl_rar_set(tp, tp->dev->perm_addr);
>  
> -	if (system_state == SYSTEM_POWER_OFF && !tp->dash_enabled) {
> -		pci_wake_from_d3(pdev, tp->saved_wolopts);
> -		pci_set_power_state(pdev, PCI_D3hot);
> -	}
> +	if (system_state == SYSTEM_POWER_OFF && !tp->dash_enabled)
> +		pci_prepare_to_sleep(pdev);
>  }
>  
>  static void rtl_remove_one(struct pci_dev *pdev)


