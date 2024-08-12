Return-Path: <netdev+bounces-117678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEDD94EC14
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992B61C20B0A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02187176FB8;
	Mon, 12 Aug 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6F90V+9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F7F14EC53
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463424; cv=fail; b=NW25xuZptaEIL+fHx80HHmbmGNjJ9v2GO7x3HYAgpUFdFo4ipLQD4rpDeovmuTotqS+WQuM4k5N2UA94CxoUTFU7QfqSk5tpMbSy+1nk5BNXbT301g0lu8ol6WvtXxmsDYDnF/PbbbWeiAwErR1o/ItbHuQZ1mMqIh7JVjnBlZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463424; c=relaxed/simple;
	bh=nOhO3SXFQWRANMrSkocNxoZE9SKAXJ4InbDEQAUQ1y4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FH0vzWcTvLKkoIX0flDkgbhgIShiNpjQpkVe7GG/3Z5HeeQWMvchGJrnzOvMDrsE5XmTYCdoo9MEsjURjbzltScXEbAvDrkHxJOg4kr+TadEqLmpgEucGYbAiTQPzRe7jCN5uRR+d3zykxUuKjFbADgew4CSvx02WtGhoH6cKuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6F90V+9; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723463423; x=1754999423;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nOhO3SXFQWRANMrSkocNxoZE9SKAXJ4InbDEQAUQ1y4=;
  b=B6F90V+9m/beYWh1P9JObNobPUYB85jdfV0dZQh5vQDe5iuVEQa+J1/a
   Nt892whX5Cin9gD0d+Kd8rxdotcqCbGdPmJnUaUi1RNXITVGt/lyBP1wD
   dl+UIHeyVMR52D2o51DXuRpgHKH3HYSJZwW/r1TpeHc7QOCA9v/POEBn2
   BsxCYihP6Ly6A4N8YHlL/BZADGmkg6dA+40Y2oIR1WKF8XdHPU/K5IbOb
   NvSQ1MGfXCZek+/75+n7YqnWh1W+azIowHnqajYe00TsLZOUtR4NZtwpe
   uusyvBURwm026D5e9iVST4iFgt87udQi4Fevdft2RuOaOeDZm1Q6FYRBv
   A==;
X-CSE-ConnectionGUID: IasWn/jtThqNfTIAAKhicg==
X-CSE-MsgGUID: W5K/+bO+TpCp4FwaQCNP9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32243865"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32243865"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 04:50:22 -0700
X-CSE-ConnectionGUID: M1wEvPfARqWDPit2bCIy+A==
X-CSE-MsgGUID: YCOQHNhtTHapchsfLNDh/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58152692"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 04:50:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 04:50:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 04:50:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 04:50:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 04:50:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyyDMG7RD68QduNElf6USc1SkKrBkSEI3AF8j7rV7g7Tf2j5itguTJU3j0Eu7a8o7k2rHsJpsZR1a6CqmT8BIvM8txyQou6wjEI/1Yy3OSP4bsdnxkV4DwhaS7p3IuU4oUIU1qkwuhcpFSn2FAv95JwDTIB9rjFaNEQq8gRrSSZ1pDi7ftt8BTdY+ww0+PMYSpu4lNhC8fxJPnXSJcFzDhsuRHKOUOcl8zgWQMwJWf3kwqqa1Yh5d77JsC1+8pcPN7UDoXUuPz3pCXqHcNm5NnlfNvcE71pdMk2NHZmnjP52krMws98fZQ2LYdY6AQK0Vih/kJjxWmuPabVSB9Q8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE3cAT1Q774tD1XW5BzV8n5OBm6n+zzedtGyGnZHEIo=;
 b=VoyFEurAWiirZoVyQoM7p7MnYo0JuzpOHNcXdyvcvlBhA55Vh/H8xpxC1h/5gvQ0XV8RPEpWtmUZbQPYxicm13+y8lSwiDvaunvFUkcc9ub0atuaeGLqfhgwrALBfeoibEzDHroAXQZGYQGT1FGmkXKcWtCXn7CRPuZDMUNyJC1z1nqh7Tva1DjbHwst0ztWSll9/eCdHSBK7WcmSFg+ewDxxMWnbEgcUPEo4CiSkhZD+yHawSJHibgp5zxHPADFsbiq8hLt3axeGT+XvgpMxJnBJkNLUaRtniB/sKmnYCMbuO1YTBHsEyQXwZc4sWqZSxPNd/nYpFXdKF2eh3D2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Mon, 12 Aug
 2024 11:50:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 11:50:13 +0000
Message-ID: <589aed8d-500c-4e92-91ca-492302bb2542@intel.com>
Date: Mon, 12 Aug 2024 13:50:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] devlink: embed driver's priv data callback
 param into devlink_resource
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-5-przemyslaw.kitszel@intel.com>
 <ZrMZFWvo20hn49He@nanopsycho.orion> <20240808194150.1ac32478@kernel.org>
 <ZrX3KB10sAoqAoKa@nanopsycho.orion>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZrX3KB10sAoqAoKa@nanopsycho.orion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fe7dd3-366e-4abb-eeca-08dcbac4ecd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWZiZ1J3aDVFdkhoZFJMd1V0clVnVjAwMURjckNuVUI4VHhYNHpYYnRVUUJn?=
 =?utf-8?B?N2xNWE1wNDNPR2M1dGJ2Smw2Rk41R2NmRTJQUS91Q0VqMFZMVDBnUnVBZE5K?=
 =?utf-8?B?OHJlWncxRWFsQ0lNTHJSYVdwZXNwMjdRRU1OKzJBU3lONlJSelJjWGozK0wr?=
 =?utf-8?B?R3VnN3AvNXc5Z3lRR1Q1ZzBYdCtZSmVlVXRPbG5sWDFtNDEyRGo3RXpXRTdv?=
 =?utf-8?B?d1FuU0VTbkJYRDFqcXFhTjJnU28xMStKVitTcEYxZkxxenJPV3hGSVV0L1Rq?=
 =?utf-8?B?dC9VU3phWE9zWTJwd09peFR0L094ZFE3SDNDQzZTdTQ0OVlUSWJWNXNFaTE0?=
 =?utf-8?B?bk8xSzFVZVQ4VTVRVEc5QkFzMW5admRZMXRIMlBWQUU5ZFh5WTQvY2ZFLzJh?=
 =?utf-8?B?c2F4UjlSWFRRU3dRRDNjOVc0Z0hXaUIxcWR0QThGOWJEMkhaYlRpc3UvaVNM?=
 =?utf-8?B?SW9TdEhGYmk1SGZ6YmUwSFB3QmwrdkprQjhhcmdzN0tSNE1DNEZ3NFVib1pF?=
 =?utf-8?B?UUZyNzZBODJ5QnpzNEdBa3VmR05CL3hsSjVvM3J6SkkvWVVsTXRFaUVqZEJR?=
 =?utf-8?B?bDFRSnp0OUY4T3FqOGNGVDh4NWQyMlBzRExWOFhGcGlJOHRTWDBVRytJNVg4?=
 =?utf-8?B?akE2RC9VeHhJUjRlWWtjckwrcml0YW1nMEVmK0N5bkVWU0RKbHY2SUs2Nzdn?=
 =?utf-8?B?UE5DRTV4NVBuWGVQYVNpMlRxTHB4Y0JPeUVZb240WkxHR05DdG5LNjBJV3FQ?=
 =?utf-8?B?TW9xZjVyRkpJM2dDTFhzRDN5Rkh5dHdMb3daVUtpREhlVmdUYzZHZk5leVRB?=
 =?utf-8?B?WWs5eU1sUHJjSmwydzRRQTNLN1Y4RVRSMVRLYmFaTUR4azlON3o2UW9EL0pi?=
 =?utf-8?B?Q1luMUQ3SUM3YW1oNkxrMnd4K3FsN3Q3RXpzK2xxWm1rZzI0WFYvN1ZYdnY5?=
 =?utf-8?B?U25XSy8rVWo3UkJiV09TSW9HWFoxZ25sTmgyR1RaTFZFQm8vMlg4WDR5SUU1?=
 =?utf-8?B?dnJJVmVoM1p1MkRGOGtzYjdJSHFQRk44T25XampkOWo5d2djNVFISWcxRW9D?=
 =?utf-8?B?dnRJbm9wd1BicEhxeG1XeEQwS3JXUnRINGwrS0V0ZUd5dC9LbHBoZCtsUm1q?=
 =?utf-8?B?SVVpWXN2TzZqQ3I1VjFvK1ZpSHdnbjVDZTZTc0Ezd2NWL0xyZ3NLKzFjeUVm?=
 =?utf-8?B?L1lWRjJ5eFlRYUw0a2ZzQ1NDVWhybmdKQmRhd0JQYkRwN2ViSU43SGpKZkdq?=
 =?utf-8?B?bEFiNitONHZhTzhBVWZrYmZudUJqMUFPN2NvWjlnUzVCYjJPejJNcFYvRm03?=
 =?utf-8?B?c2VXZ2puR1ZzRk9EcDh5cU53NEdPaXZPbnluVC9haGtBK21zMURQZ1Vidkkr?=
 =?utf-8?B?WExkTnhNV3JoV0hZbmdPRC9ISjdUOEpuN1ZVN0hTZU5wSlVaZUxobkpFdjZl?=
 =?utf-8?B?SUI3Y1FDWnZOUWU4NWVpSzJadEVhZkVWWnV4Sk5aZ3hkanVDOEpzVTJsU01Y?=
 =?utf-8?B?QU01c0x0VWFVdVhsdkVZQlk5cld1R2t2cW1BdlJybjZXRUhTSlc5eVBDei94?=
 =?utf-8?B?blN4enV2RGpvN25pUkVMQ215OW1HU1FZcTJlRTNGcnhGS0syM3lLbjZrREZP?=
 =?utf-8?B?ZEoxSUEvUmZYWWNoR1NJRFJlK3Zvc2V3ZTFwNXRoWmR2eWxhT3l4N0JCeXg2?=
 =?utf-8?B?OExCSjNyZDhXTU9qRlpZbVc3S3c0UDE3YVdRalpld1I0aXBUL2FGQXlYV3Vi?=
 =?utf-8?B?cm5nS1FPeFZvYkxUWldwLzhFbGZydW9RR0dqclFOZ3hUVFozSHNLd2pDY0dK?=
 =?utf-8?B?d0R4L3VzdjczeU5MQzI5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emU5aW81NlE0MENIRGw4aFFoTWZFd3l4UHF0Z3NnaHBYcHpZaWxhRTdkNmNW?=
 =?utf-8?B?b09KTS96amJqd09VdDRWQnhwbzlEamdma0ovRlgvMnpHMWRIQWlCOTY4T0V5?=
 =?utf-8?B?SjhkOE5VRHdMeitKTkg3aHZXMjhnZUloTVVIS2Z1TlhCc2FyM3lQY0pUeGF2?=
 =?utf-8?B?UUg2R052L1BZZnp1dEtSU2ZkMlo0TDhMKzhoTXRZajRGdjV2OGdpOFEzaUZq?=
 =?utf-8?B?NTlJdCtSMHFtRjhTQjN5K2tZUWl1dmZobTNnUXFBazM5U0V0NEF3dk5KbTg0?=
 =?utf-8?B?eEx4enBYcnVZSld1bVhRQjhIZk9SUitiN1hRcDUwcVd3WVFvQ0NHYlo4M2t2?=
 =?utf-8?B?NTgyYi9vQVFJTnVraGsyRjBXVmlqMWVORVNad0hpRjYvNXo2OXVHYU1CRklv?=
 =?utf-8?B?TDltWnFhRFZHQmdCWHRWOFRxZlNEbVgzYlE4UDZiN08zNStYVFZVN0IwYmh3?=
 =?utf-8?B?cVB1VXIzQ0dldFNPOEg2N2x4R3RFaXcvbGM4WjJHVWU5b1NucFlMSWVwQ1Yw?=
 =?utf-8?B?VFVUVEF2eWJWWncyYTFpaXpVTWdTQ0pTU1dHdUJoQ3FaWERNZ2g3MTJYb1RC?=
 =?utf-8?B?QmtsU000ZXRKQWdiRlQxRFVyemovbkhNdjFMV2dENC9saUVzV2h0NS8xS0Vr?=
 =?utf-8?B?Tm9XaDlPaTlSUlQ4eTdDL0pHVzh0TmZ4ZmNBTW1pUitLWWt5enp3V0NFTkdu?=
 =?utf-8?B?U3ZhT1RNRm94V0xJWnprQkNnWVh4K2czTDFSY2Vub1ZmUEloMW1pcUNndWlF?=
 =?utf-8?B?OHhrdGJMcEp1azE2U0tLUFNuQkZWVTd5VGJrQklCVFVNNnJtd1BrQmRKWGJa?=
 =?utf-8?B?NUxEdmVlWEpmYW9LQnZSV3k0T0RON2RRN09WY1lxRkR0cm5VRGVpOWJlZnAv?=
 =?utf-8?B?RFVuNitxSTU0QzltK1lEN2tHSUtOUWZKMmRLVFYvSVg2OHIzUmR0OTgvZnpJ?=
 =?utf-8?B?czRQbWJaQ0JPbHVYc1BBY1FMMHMxVkJEMTFkbkg2R1FFczVUcmlrdGI2Ukhi?=
 =?utf-8?B?Q2VTQWFrVkVtVFJ6TDlhSitZTmt4ZU5uRlFodGZ0Tkt1SEVISkNPN05YRDRV?=
 =?utf-8?B?cFMvY1hzOFFZNHVnM1JHNUhIL2RsN1JsalJ1SzBJSFUxUy94cW5teFBFNEIx?=
 =?utf-8?B?Tk5ZMWJpTkE0dFVPNXI5dFFXeG0zOFUvQzBTSlhDWCtjdVREcTZxcGxCa0p1?=
 =?utf-8?B?Rk5sRFl5UTJJUjVId2ZmOThhbzlVWENOMWdZRGJNN1lNKzNCc3BoM0Z5Nndm?=
 =?utf-8?B?RklQcVEwNHRsVjcrTXN1TkFZMlR6cFVEbXowMm9yZnRVanY5K2dabkYxOHJP?=
 =?utf-8?B?TDZUMUNIbllLMmhra2RNckt1bXVobzVKVDRINUF4Qkc2UE1JazJLZWxjUjRl?=
 =?utf-8?B?RnhuSjkrbERMQUJRcXdNRkVaMFVPR1JoZ2ZGdXpMY3o2MGJPTkFKZmIxNVdZ?=
 =?utf-8?B?ZlAzNjk0bFBKRXYxVnJGY3NZblREUFhBbnZMbGREbDlNdFJuR1lNaHZGa29G?=
 =?utf-8?B?MlRRbmRnUDJsUkV0TzA2MDhCbFk0V2ZZY2xRVU5UVisrcG1lZ1BHZTZnMG5W?=
 =?utf-8?B?Mk4yZWlmalV5bEF1WjZOZWxWaFZMTlZMdFVweDB5SThITURvYndaWUZjcnlq?=
 =?utf-8?B?VWJycHZvWUZUWk9qRXdoczVXWjA1bXlXQ3c0RXk4ZUZhblNyN3IyVWRBQ0lR?=
 =?utf-8?B?WHJLWkVmMG9HNHJaUWRmeVFwd0tzbVB2OXhTUmhtRjdINDBmTDlaSWVnN2Q3?=
 =?utf-8?B?cW1tbUQ2RDdVcGljaktIUTJkcFJ2anFKaVhwVWdNSk5CL2lVdW04N2RTN3Iy?=
 =?utf-8?B?VytYcjV2RUVPazJnWTZHdElGL3MrWkwzYVV3TW8zdFlNSHlpRzJSVTJoQUxq?=
 =?utf-8?B?cHFUc0N6SzlIbHIwNE8xcHVWc0w3WmY3Mmc2MDRneGtyQUE3UFJrMENmK0Na?=
 =?utf-8?B?UVhRTnFhZVU2WStySHJNNFpmaHQ5VmVSQkpHSlljTStFOVNXQ01BcW1EbW4v?=
 =?utf-8?B?T3gzYmNQTVd0c1F2ejBhbk1NZHF0b2N3TElvVFo2NE10Zk1KTlhHQTFhYVlH?=
 =?utf-8?B?b1c4R2J4SHBVOWVYRFdWVDR3aS9PKy8zNTh4Vk1kbmhWS0hMWFdLUE1vdkYz?=
 =?utf-8?B?QVl3RTlQTG05Umd5ZE5QUUJGVjFUSlhNSDNkVWVWV2lueE1kQ2VlOXNWWUZD?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fe7dd3-366e-4abb-eeca-08dcbac4ecd1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:50:12.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ls0Aii63RWitpKVl6ahw1Nu2mhwIF/JKSZdFDIo5o5IflpgNCZXt27B3eMgickV+2PlnrgBUAY/6QDxkPRKDiQ+1Ii3VoUbvNgUcht/lQOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com

On 8/9/24 13:02, Jiri Pirko wrote:
> Fri, Aug 09, 2024 at 04:41:50AM CEST, kuba@kernel.org wrote:
>> On Wed, 7 Aug 2024 08:49:57 +0200 Jiri Pirko wrote:
>>>> 	lockdep_assert_held(&devlink->lock);
>>>>
>>>> 	resource = devlink_resource_find(devlink, NULL, resource_id);
>>>> -	if (WARN_ON(!resource))
>>>> +	if (WARN_ON(!resource || occ_priv_size > resource->priv_size))
>>>
>>> Very odd. You allocate a mem in devl_resource_register() and here you
>>> copy data to it. Why the void pointer is not enough for you? You can
>>> easily alloc struct in the driver and pass a pointer to it.
>>>
>>> This is quite weird. Please don't.
>>
>> The patch is a bit of a half measure, true.

Another option to suit my wants would be to just pass resource_id to the
callbacks, would you accept that?

>>
>> Could you shed more light on the design choices for the resource API,
>> tho? Why the tying of objects by driver-defined IDs? It looks like
> 
> The ids are exposed all the way down to the user. They are the same
> across the reboots and allow user to use the same scripts. Similar to
> port index for example.
> 
> 
>> the callback for getting resources occupancy is "added" later once
>> the resource is registered? Is this some legacy of the old locking
>> scheme? It's quite unusual.

I did such review last month, many decisions really bother me :F, esp:
- whole thing is about limiting resources, driver asks HW for occupancy.

Some minor things:
- resizing request validation: parent asks children for permission;
- the function to commit the size after the reload is named
   devl_resource_size_get().

 From the user perspective, I'm going to add a setter, that will be
another mode of operation (if compared to the first thing on my complain
list):
+ there is a limit that is constant, and driver/user allocates resource
   from such pool.

> 
> It's been some while since I reviewed this, but afaik the reason is that
> the occupancy was not possible to obtain during reload, yet the resource
> itself stayed during reload. This is now not a problem, since
> devlink->lock protects it. I don't see why occupancy getter cannot be
> put during resource register, you are correct.
>
I could add that to my todo list

