Return-Path: <netdev+bounces-256825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Lb5vLT+4g2lwtQMAu9opvQ
	(envelope-from <netdev+bounces-256825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 22:21:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AF9ECB28
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 22:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 737C8301544E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7399B2C21E6;
	Wed,  4 Feb 2026 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2K0ZBGU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16986156F20;
	Wed,  4 Feb 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240059; cv=fail; b=eTLufHYcSpXyRQCxtPdDU4Y2uMyMfGGQRBiHjoEGHG7e3FS6zdZ+x7ZsTgw0+2hi13fo0VU5nJmxAQ3qH1hM1nLJJ158n2mOdyWFrVz9tMlGxMSiyfa1PcNBrzqJe+Wn6Oc/HyccmaonJOqR07qKI6uDkLSbBWkiv6WQW4ucb+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240059; c=relaxed/simple;
	bh=cgz/1DIDFZ2DhM/8IG1muqqsT/B2j0erHWAo0Hf4UTs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aAienxA70dn5KNt+NtfTNAY3yqi8WJcn4+ugh+r9EMtrX3/4QqOhYs1s2pS+QPHkjXE+uMDf/5tEF2AkNE4hnwBdH7JmTlLJRk0Zi4U350vIMUWo6RlMaq4MKINaWI1YrKZZ9cHvFs2wRgbVNYabpWpoUpWEUSlb4PcUkc1/6Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2K0ZBGU; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770240059; x=1801776059;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cgz/1DIDFZ2DhM/8IG1muqqsT/B2j0erHWAo0Hf4UTs=;
  b=j2K0ZBGUpo83qiUtqdooKaXcgUFQeOExOyDxwdrb+m3q2Ed9df0nR2ai
   uW6sKu1QoJyOEOA0GMHpNIyUoxgIC5sI4Lvvb3XZFt8Q+e5EtP2mpyTQJ
   F6JoxmrfT6p07hw+VNQ5RzpeKiD9QuK9WG00T33DY43XTDzek60U8JbHF
   oBPZOn6zojby66LfFMvQlc3SyaLzP0weKEkIFoXGlCYqXnlx3INDlqSIt
   B727vEniYJo3FoK7IZ6yd6wKsmumA/DaqGIv+rR4gEio+BQe9OhILJuLR
   wbk/sYlH7KWmZ6I2QdIq/axGdmFsxiLAjnDN+06BtKefCMj4S0901cht/
   g==;
X-CSE-ConnectionGUID: 4toLZGJfSWuH0BlXAZKy+w==
X-CSE-MsgGUID: 43uz/7kQRHCyhDe42f9KZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71164681"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="71164681"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:20:58 -0800
X-CSE-ConnectionGUID: cG5H9aHgRDyXYEePhZ4yCQ==
X-CSE-MsgGUID: xXV51mKgRGiyeWlCazUdHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="209655437"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:20:58 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 13:20:57 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 13:20:57 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 13:20:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=casq1Y8CIikX9mpPBtBAgdMWVuEseMwhJ9zr/g33rj+yD7U2EbWpWSK5pKSGv3yrMf5j3uvTeP1vCDJfYrgGB9C4YP2Eglhb9UK5rqD/C5CxH1OezqLyf7tLPNsbwEAGkJfTGbOXjKI0O1xRx3R+ExW4+TpOlMZ+hldmTnXYcWS72Zh3zZmK2bkB4oAss8AMVoks0r7jWQUlq0Av4WlWL4d+o4EmE9Tx1kArLEFUuvC6DFR8oCJxhZ4zReqOLkZIqgxqmXkgUbznxsbi/c2pCMbak49pK7711RlsPpDuocEQSZ2MlhsTeo8Q+hBZTcVX83qhFq3MkJRr0s3v2lDsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zElonTE3eI0Lr7OpR2D6FXRpQkmdxtJ+U3rmxR7ViEM=;
 b=KmdnSKGOJCrndM9UZNALzfJXJg0QFleLSNOIlOMrrOalXRoA/ipGA5s8q956F4xG7p6g0jMdvW8HqSfS728plJwlRfktZmrpRLhFTjTLKRLyYOUKWvXLu86K9H8ZFJzTBR227kSbcIcNamFkqSVHkDAEiz42rviqbG3ZxS1a0pQzAlV7zs9SfgI+OXik+4bOrY92sAHouxdG16r/aI0fcjSkDdVhqkJjSxner7D8WBIvL9JPlimWEIhveOvLu61la+AtVm1fmZp/DMwmRJi/KcHTFMDEctd6pCVY2/8vFuCWzLWVQ6G9CIllN0xW33UTVEEKfsd0DpN2EelGgITNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 CH3PR11MB7796.namprd11.prod.outlook.com (2603:10b6:610:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 21:20:53 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 21:20:53 +0000
Message-ID: <1ce0492b-d17f-458a-a4df-5849ade047a0@intel.com>
Date: Wed, 4 Feb 2026 13:20:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hns3: fix double free issue for tx spare buffer
To: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260202105837.1909444-1-shaojijie@huawei.com>
 <2b7049bd-1b85-4e6a-be3e-0f3efe3b809a@intel.com>
 <81f552d6-fc53-4aa0-8c7d-d098a3bb6f04@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <81f552d6-fc53-4aa0-8c7d-d098a3bb6f04@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|CH3PR11MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9ae654-7776-4f17-7d18-08de6433473e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFMyUUVmZmh0Z0dBdi9JaUtSZm9QZE1vWkc2M2NjL2tYRERVK08rb0xXT3Ry?=
 =?utf-8?B?SXNrS2lKMlBnVXJUOGszVVlucEFwZDNGZ2ZQN2JYRCtKbmVnZ0JHU0NKMjlt?=
 =?utf-8?B?MXpwUDdRTWx0T2I3V3piV0N5VUlZWCtJUWdFb2JodFRJWks2TjNJL3FzOFBi?=
 =?utf-8?B?eC9yOFVPbnRqM1M1T3UxOGt2aThMenhlZzVFakhKK2p4cEtIWk82ekUyRFBa?=
 =?utf-8?B?cGNKQUZTb0JIb0l2NDVrdHpjQWwxUW1nT21KcVdWQmgwdlJUdlhINmxEOFlt?=
 =?utf-8?B?OE1CV2tGd250d1VGTmYwNTlWSUJoMG5GMVo2dzNhd0JXWHpudzNiRktNYzg1?=
 =?utf-8?B?am1XVGtqRkFXOWd4RStxYmxrS2dPRlVnd1ZYeUVEN1o5U2pEMlF3dUVPbGFW?=
 =?utf-8?B?Q3VDZnAxQTNHUlF0aHV5UEdWanlKZ0ZGM1VSM3QxeDA1VWFXbCt3OEQ0eWxZ?=
 =?utf-8?B?Sldvc2tlbE5iZ0l2UGFtYzVkNDJNTHNBRlFhUk80M1NaL1lQY0FQUnZYWnBu?=
 =?utf-8?B?cjFybEFHT0g2YWxQTmFBek1EdTFXalBkWGMvTTJSVi9jUjlIRmxwNVFUK2Uz?=
 =?utf-8?B?eG00Q25YWlFoNVJQdVFLak5wZ0FvWmUzeWl2M0lqN3BLaU9wY1dOZzNUVita?=
 =?utf-8?B?anJ1aDV2clRXUlJidkNqVnJXczVINURGbDRjc3VrOERQdk9xNzJEbmg1WGxJ?=
 =?utf-8?B?bTVXYTIveTZESHNqVFd3ekZDK1Y4Q2VlL0g1dlgxa0Z6WGtGK0NSemhHUlAr?=
 =?utf-8?B?REhKdFhRaVNHUHFub3FIL3BwWSt1eSs0VTgwSjhBL01hakhGTHhIdzc1WXNJ?=
 =?utf-8?B?Z0pUSXRnUjdzdFhRU1ZibzBhQWF1dmhuYUcza2VJNm9pZnlJcjVpUkFiL2lZ?=
 =?utf-8?B?QW01dFc3dGZNd0hTamd3b3pCRjM4eDBqMVZ5d3p6WExSWGMwZCtWQkV5VnJB?=
 =?utf-8?B?bk55ZElDNkpidEF1ZjNMd2VsNGp2TzQ3aEFjTjdvZTBoSXFqeHBzVENPeURj?=
 =?utf-8?B?Y3JiNXUxcEdXelNyN2NQMVB6TGFXZ05rRVBpWW9KSmlSa2k4MkJZZklXUDF6?=
 =?utf-8?B?NU1HTU40TSsvcjZEQkVGSG5KRjJCRWJjSEhaWnFNUWd3a2podGhjSUxZWHZj?=
 =?utf-8?B?MnVqcDVnalVkNUsxMTRjWDhFYkUycS84cTI4RjZhL2Z3d0JVK2t6QmZUbFhi?=
 =?utf-8?B?Wk1FNHRLZXlLbFFSRlA2WXI3OHp3Q1UxSmNFWng1Q1N5dGZmSGdlc1RnVzFV?=
 =?utf-8?B?aUZJY3VOVllGbkhsMWRIb3RvZzlVaU44VjFMalJqclZ1WHpiNExMK0pJSjFW?=
 =?utf-8?B?MGQ0T0FuRGVJRlBVRDkxeGtaeXFlQnNuNWdmemJyMFltcGVCM2x5NWpnY0Vn?=
 =?utf-8?B?c3IvSGk4N29idDVUN1VaN2RTa3o3NHpDZmhrK2Z4cXkxWDRjem9aL2g5ZFY2?=
 =?utf-8?B?QmlWY0duUzlxZFJ4MU9vRDlnK2J6WU54WEJsbzdBemNaZXRjcmVoSVNJQm96?=
 =?utf-8?B?a2ZIdWlIdGV2WHBmT21JNG42cWVOQnlINW5KL25tZ2tldnJrSE85bzlET3pX?=
 =?utf-8?B?T2c0U0U3RHdOODYvM1AzOUVZZmdOc1dhMmh2NTJsZnJxckRzWlhMU0kzU0Z4?=
 =?utf-8?B?Vzl1dmxTak9veCtvOU5wekl2K09qa2N0em9rcTJqcGxNbnJRYnpFNzJrUmIx?=
 =?utf-8?B?KzdQenMyWTFGSm9IRnhKVUZYMmpXR1U0OVBIQVV5WXFKWVp6NzVmOThzTFZ2?=
 =?utf-8?B?aEw2RUpTYzYyL1cvcU9IZ0NUa21pMlBqaXlGeGY0dnB4SFNaUTJYVmtWZGNR?=
 =?utf-8?B?bWxqb24vcjdpTTNqb3AzRjFVeDd4M2VZUU1EOVhSSitLL2ZxUVlIZlZMbk15?=
 =?utf-8?B?eUZ6QkVmWUZzSmdaanJUZ21ScTBUK3BrL0czdWsvdit4SENhVnl0cVVtV1dr?=
 =?utf-8?B?RC9iYS9oQ3hlK09UK2hWL2FIZFM3QktrcFpWR1RXOWtpSlYyK0J6VFdlZEk0?=
 =?utf-8?B?RExNUlpSWkpSRVFJNVU5d2tNOW94WG0rL2hSYkJ0Zzh5alRuVjdWUTEzcE1k?=
 =?utf-8?B?bGwydUJWU3MrZHBnVDVSQ01oSXp1dDVMcmc5N2ZVcytBWlh2Z0dxa0FLb0h1?=
 =?utf-8?Q?duGk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjUwdzBYNkJLNXFMblk5cHZxRkxMeFZPa0IxVmRDVzRMUXZwbGhUZk1tM29V?=
 =?utf-8?B?ZFRPZ0c4TDZFQ3UrQ3JRVDRyYjBsTy9hMlVEUHBxZXZEOEppZmsyeUI0VFVE?=
 =?utf-8?B?c3VBK0hUcE45SUFRTVdQYW45VTdwWSsrQ3pCMnVyNmxkZDB1RTVuS2dRODgy?=
 =?utf-8?B?THl0MUtXSS9SdkRmMEhEbzFra21xQ1FLcFNQR2FUWFpJMlpxWjdLVWJKRVR1?=
 =?utf-8?B?OENEZ1dTeWRvVGJ5S0VLcWhybDhKTDd3RUpZTndKUnBtcHFGem9temR0S1BB?=
 =?utf-8?B?NWZ5QWwxVTNDU1FuN0JXNi8wVW1XaU9nZmpPU0k1eUhjUkF3d2sxY3ZTa1pU?=
 =?utf-8?B?VWlmSEVpbENHMmFxYXRQMzdRSGJBY0tHbFZGY3lXa05qR0IxTEJUT09RUFJT?=
 =?utf-8?B?SkFPcTJMMVRNanY3RzBqK1o3bk1NRmN0ZUo5eTJaWnFJSStGcWc4R0xiQWZx?=
 =?utf-8?B?aDUxWG8vZzRkVjlpa1pxK1lldGNmdFd3K3VLYUp6OGpmNzRFU2YrTmh1bGxF?=
 =?utf-8?B?QWR6N3FuSnJsaTE0MTVINFFiUVZjQVlBVDJNclExY3lYM3hYMVUrYWtXcThs?=
 =?utf-8?B?d1BmNHFqdUgwaURDTURqUlFIWklnbFFEb0lCOW45Q0U3VGpRN3VKTENOcnRK?=
 =?utf-8?B?V1draktmT0VmWVZ2cnJYZ01EbXRZM2ZQUnVEWWNpMG01M21mdE5pbmU5aWpF?=
 =?utf-8?B?WU9mWUhvMldITmpXWGNxZ216aU1nUWZ6S3Y3VmlrTVNOb3pOQ0FSc0gxR202?=
 =?utf-8?B?ZnNSWXFrM09oK3F0cnI0L0VicEVkaVkyMC9uTmw3dEZSVnlzQXNVSVY2UjE3?=
 =?utf-8?B?b2dWQ1cvYWNwVS82VnRyd1pyaDhHeW5mNE1aSlBlNkl4eStvRFc0dDFuUjhx?=
 =?utf-8?B?STZQMXdiWVJCTkFhTzZsNG5sbWllbVcrc0JuSGFEZlloa0FNc01tSUw0T01J?=
 =?utf-8?B?UnZoZG9YQkJGL3BiZG1xSWxGdGdiTnJCR3A3SDNHYnhKZm4vMXExWXp0UXZY?=
 =?utf-8?B?MVFjdUVSVHBoT1VQMUdFd2dKZkM2c08xeDFpbGlzMDVVUS9rOEdPNTEwaDIx?=
 =?utf-8?B?MGFnWlJwSng3b1BLZkNwOUk3ZnVRYUFvcC9FTGFEckJsd3RkbU5qNlpTdFJx?=
 =?utf-8?B?RVlxNy82UHJrZkdObWRzb1JJNU5MeVErRWR2Y1BnMXZhK1VxNTNqdzBycTlD?=
 =?utf-8?B?RHFMUTZqK0cvSERqRXpHN3BlSmI2bnpUSFFCZ2JEN1ViVVByYTY5enBLWGhE?=
 =?utf-8?B?ZWlkanVFb3lzSks0WVVrZThncFJCWGxSRkQ4U1dyWk95RWdkT1ZReTlhem52?=
 =?utf-8?B?YnpEc2lZRjNUcUtlVFFzY2tyMzlVL3g0ZU0zcjNsR2FVYjc0MkF5SWZpSXdX?=
 =?utf-8?B?dG9ObTZnb3Q2eWFQUEdlV3RGS0taTUlaUkQyOEhhcGtMa2l5WGgybjdxTk82?=
 =?utf-8?B?SkVaQXBZWVp1djBKblVjZ3hsNXJSM3NSNEVCWlZRU2JUdy9Oc3BBbmhqSGxB?=
 =?utf-8?B?OU53b3pIZGNkbUNLS0pjUkdEaWl6MlZyclA1UHR6bDdWYytVc0FhNTRwVXhW?=
 =?utf-8?B?N1FralNhTkV3ME5aNWNqdlhGWGFXSGs0VS9oVmVxM1BMRk05UmU3REhJVkpM?=
 =?utf-8?B?ait2UDl1Y1VkWHhmM2V0dXpNTVVqVUJ2MFFVMTJlMTZIZFB3R1hYRllnN0d6?=
 =?utf-8?B?c0xIZ1Z5c1NIV2F1MlJ6b2ZzbmthL3lJYXp3M3VMUXhobHlJaS91aGlEaW9y?=
 =?utf-8?B?NEFuaVN5blZ2bHFaUEJnS1d6RnpJQ1Y4b0ZITldCZW1SSVJnbXduUngyTkpR?=
 =?utf-8?B?dERJWURFY0VCaE1hU3dkc1V4cWw5bHpURTdkSGhjY0hLZmhCQ2NVejRydWNm?=
 =?utf-8?B?Mmw2aU45ZXVhb2pFTWVyKy8rbUJQRVRMT2Z2NVl6a1FQeFZuTVYzUEZoVDFJ?=
 =?utf-8?B?c3UxcmV2ZlFrWTFsbmhOd3ZRL3Qyb2E2aUtuWG5adzR4bm1qbmxuY3lnaXVX?=
 =?utf-8?B?UGRPOVVoT01ZSmY2MzJZT0gyMGdGUUp1aG5FSVNOQXFLaDA0cG5vTURBNkQx?=
 =?utf-8?B?ZHlaeUxobW9qRWMyT0ZRdzdneG41Zlp0aEpWRU13MDdqWXdxaWhNWThkRWtU?=
 =?utf-8?B?eC92REMzTjNYbzlnRVVVM3JkL2JuUHNBcElibXBvOUEyaEhELzYxUFh3Sm81?=
 =?utf-8?B?YWorOHJ4VzhGeHdKRkNNNUUvejhwQktBU0NSSXgvOGg2SUxUMVpSbVBYQ3lC?=
 =?utf-8?B?b2pIMEc3VmtYWUdEMFVjNUZwRk1rL3JFTzlhWXZ6aFI1aElKQzZyL284dmFw?=
 =?utf-8?B?cEppTG9wQ0EyUHN2c2N6WkZqN2RIbmZYU1EwbzZJS1M4NGNIMU9qS0poTUVB?=
 =?utf-8?Q?+vQw8fh6sKlOMy4E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9ae654-7776-4f17-7d18-08de6433473e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 21:20:53.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmwXx+TH/cm+m8a3DNefNq7FSmWYNwCFcY+YIdIuDsiG7Fb5/AcGwkZ6Iihx964oks1r3n4ajkGwjQcBn+bUS8UQstUoA3PigKnzLWrpAqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7796
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-256825-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D5AF9ECB28
X-Rspamd-Action: no action



On 2/4/2026 6:25 AM, Jijie Shao wrote:
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Thank you for your careful review, I apologize for the trouble this 
> patch has caused you.
> 
> We considered the logic to be quite complex, so we added comments in the 
> code to explain it.
> However, for reviewers who are not familiar with our driver, these 
> comments might be a bit unclear.
> I will add more detailed explanations in the commit message for v2.
> 
> Thanks,
> Jijie Shao

Appreciate it, thanks! Please feel free to add my Reviewed-by to v2 if 
the code remains unchanged.

Regards,
Jake

