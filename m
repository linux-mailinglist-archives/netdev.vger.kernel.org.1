Return-Path: <netdev+bounces-114073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65C0940DD7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7D128497E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48586194C78;
	Tue, 30 Jul 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+e6iKod"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9517194AF2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332109; cv=fail; b=ZoHS4r1aStodn1s2vdRIVGO1/5mz8oTNUUBd7RSdLaye/tm99Li+9E1xJyO9WDagUYQcbudT3yjr8qtzve1XCZgtzNte0a7g2q7Nk51QiQrEKnTFN9tlHr1P65gt9+lzFLUmlmmmByAjvRO6rfvj622/MjYyWKAPikMXFTTZfb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332109; c=relaxed/simple;
	bh=SFbPDlfcEHHHw0D1Ns7hlrmBx+eFYMIWItKLa2HUxUs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N4+Zn7ILOzjFAQMqq6YMqlOl3TVJPFDv5ty+ufh4bM48P1dEAoWT060SsbYVZQ+T9mHVUm8+bJsw6c+KIDCcBJBr35ZyybEdA0zNyyxboyASGhot1L3O/aaKuef9LtoNt7z/hTaKgEup+FEttq/k2jel0V/YAXJQlz7a7j+zv5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+e6iKod; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332107; x=1753868107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SFbPDlfcEHHHw0D1Ns7hlrmBx+eFYMIWItKLa2HUxUs=;
  b=h+e6iKodbC5xT9UBLvMEG+ZYkNoh8Uj0zs/dYYos6MYQRGWcr9mFc9xc
   1tNfWbVtCKoWtqwQ02F8DhpfSXygPdGpBcrvLX2/65wSf1/sOwM9AOsys
   DnG5tgnKwbHQPMTO5pclU+EPlZbdFKKjttgWYIxNiPGJP6Lxcu2NCD74H
   oBs9Kix7IsZhNBnOGnHJpfGRjBszKp9UIeb4eOAirddj3Bc0dXjPlowmU
   5VjWLFqgC+RkfY64/Llbz/vABFCVhBuRwtsGFLkNx/EXr4Bg1w0Avb32Z
   8B1kQz5bvhjllogQjR9LrROihdu4nRixV+Cu06u7jLreZMgGoscCpAaK5
   Q==;
X-CSE-ConnectionGUID: aSMzYVaQSTCaP6OLbnhmcw==
X-CSE-MsgGUID: AMaDJ051SNKFfbznO10XbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="24000870"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24000870"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:35:07 -0700
X-CSE-ConnectionGUID: nG56qV76SgKjAM6IrKBNSQ==
X-CSE-MsgGUID: jnuFdi1RSmaaSF87uTypNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85228937"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:35:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:35:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:35:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:35:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmjbWQairKgQkU2d84t1h4Cqi7Rh5GcyPNxssqTOM5i6lKAAQL1uVH4ZIAkGjPcKKoGyz4TRm1CjnX2ZiTSkyX3L7yY3bYYq8q7HzdzsVpb3g4ZNa11cXql9xndkDsNgxNlUs4JyIxU9vZiKoS+oG4jFwt/ryslSMlrzMWYiz9OjNdn+7ldE23f23ytJd0NWq7CvhHhjclsCnK9G7gVRHsq9Xvv1axggUlR/AMI3lpbUDlCa3mCpASOW7NSpfpSWiFYs63TQ38syVJpVkQLHabp+IDzFCDqhLQQ7XWeJK09xsXHjHmRZ4d5wgcJ4fayGXH1Z2QYttd2418w6h/eQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hrWPlJupypJrzI6iueY+r9fghEzS8UpTwptnqsF5ts=;
 b=DvMUjq8+hTJX0idp57S8GorMnT7+nfmseXpqvGcYcuvjqEuI4pqryhXhy2dcohLSr6/u3fQyNHM67LFTDF39leISJz4vD42BvTJOrNTdu3HUAowJ0W6Nn7dewV3NUV+QQCiB0WQkQwbe84+t2tg8y4zwD3GmKvjVczfbszCgLOF9dctriJqADsng79b7as2uvrDNMdZCyt+M9LSs395gF53nmsEYXUpMaP34Pi1IkDsI50NT/5WxBor2nU4VoaOge+b3lIVnyi8WKkh3YuHg5NjxAw5U3gqmgGJsZXe0917ON5rRRLjoRVT287/Sv3aaMjSOhK50qIFESYyTa/rNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:35:00 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:35:00 +0000
Message-ID: <9e0351a7-6118-4c36-97aa-011da8882253@intel.com>
Date: Tue, 30 Jul 2024 11:34:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/8] net/mlx5: Fix error handling in
 irq_pool_request_irq
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
 <20240730061638.1831002-3-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730061638.1831002-3-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::6) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 157d3310-aad7-4a28-3186-08dcb07ae1c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGhoZTkyQmFGRzFGK3ZSVmI3bUtGcUlsRmY4endCYURad0VWNXhhS0hhajZD?=
 =?utf-8?B?Ny8xM0FLNVlCZjJBTlc5d2lhdE1rN1N2cU1IYTByKzJoVGZvNHBJaFBweWJO?=
 =?utf-8?B?K09uemk4aTlmeEhUb0JXY2NZUk9jUFV4U3VGeFN0SStRTHNkOGFzWitqMWNS?=
 =?utf-8?B?MTgxbWsrWk1nL3FHd01BK25BeCtaUEpOUXNDZzZxNXVteG1GcjllVHZFV3Fh?=
 =?utf-8?B?WWwwVU1yZFUvUjdRWXNrWlBLOGlFRDFNeHJaUG9LYnVwZTljUE1ZM0ZwZkhR?=
 =?utf-8?B?SzBvT3laVGdJWTZpbWkvWHViYmFLOXpISVJMTmU1UXJmZFJHeGF0U1lHYk42?=
 =?utf-8?B?bHZhWkRzQUI3YWtJOVdycXo4eGtZNGJhTzJqUlBUdGZZaURyazBYSkY2K1M0?=
 =?utf-8?B?WmpGWnMwTDFTaUZ6bXFkdGNzYmltYm16Q0tFY2pLbkFGWGx6Skhxa2wvdHZi?=
 =?utf-8?B?M2ZSbU1tSFRNRlV6RlM1bDQzOXNmaWdpK1ZoYVcwbDZlZU9IYTA0eTk3USt6?=
 =?utf-8?B?cnRxM0V1RHBwYytIcVlucEJaMFo4TW4vdG8wRndpRjl3eEdrMWVzdEVxblJi?=
 =?utf-8?B?Wjl0WHN0U2JoWkQ1K3V5ck0zcVdsSklxQzFPalBIcE4xVzdrd0ppZENYc21j?=
 =?utf-8?B?NlZYOTRSb1h4QVhwU3hPMVVwQ3UzRnpRTFYrbi9lc0pyQW8vTkJ2ZTdnMHFx?=
 =?utf-8?B?TnQ5NU9qemRnWVdDYVFpQVlRcUFZUVZDOU1xOU8wM3ZYSUJyOWxtTHBNakxJ?=
 =?utf-8?B?ZlptOVhoRXpmd0lqVTZFS0pPQ1NNZEM5T2JUUGNMN05ZZmVsV1E2NHQ5TlY3?=
 =?utf-8?B?bGQrSFBZd3ltVHdZOENDakFCclJ1QUQ0ZkcxZzdkY04xYTFrVmxTZG1uSThZ?=
 =?utf-8?B?QmZHMTV6NmZYQUhaL2pwV002YzkvUVRUU2FOVG05VXdxS2V0OVcreU1uWVJw?=
 =?utf-8?B?aDVmRndudm04WWhIOG04TlJjQWh5eUZaZjFJT0NIUmV5RzA2UEo1QWR6aEth?=
 =?utf-8?B?aVlGVnlXb0JrdFd6Nno5bkJaTUpjU05SY1FXSmppdWt2RmtsQk15amNpYzNH?=
 =?utf-8?B?bVl3NXEyVjhLUlAvK040Z0l4ZE5WN0wwTnV0VVN3bWFUVmtRTzlzSlVxK1Vm?=
 =?utf-8?B?UXlNZHVya1d0OVB1T3ZYM1o3NEIvbTg3cnVmb0hWNmVCNWhLTlhXa0pvZ040?=
 =?utf-8?B?dEVZbDdLNmZseEd1ZDJLN1VaWFgyeGxkemVsckJrazI5aC9PU1IvRUFJdzNL?=
 =?utf-8?B?dElQMVlMRWpGc3RwWVhvdDI2dWQ3VDQ1dVJDWWRyd3pEK2J6M0ZYUzAwQTBH?=
 =?utf-8?B?L0Y1cERRQ1pRTVpLVmhSd3FiMDFIb29OQjQwK2piKy9EUW5CMy8zU3lBV29v?=
 =?utf-8?B?MUEyY3NlY3pQT3F6QWRDc3VLL1Jjc2o1bCs5bENvaTNiV0VwOTB3VDNEYkxp?=
 =?utf-8?B?SDNOOW41bTJzTDFvRGlNWDJQU21ranNwMVFQeGMxZ2FFaDh3SVltZlNSM0Fr?=
 =?utf-8?B?TTV3dHpsSG5jUElIYlJ5NW10Sjhtb0RKc1hHYXJuMmQ0bTkyY29pN0haNWhi?=
 =?utf-8?B?SjBmdDVIUHlNSmk2UksxbUphRXZrT3pRZ25Cb29PNDFGRHYyaEpyS2RFSmtP?=
 =?utf-8?B?Vmt0UXd2YTFvVjdmTGwyaGxFZkdEdkVWeEV6VFk0VDFWcTgxaWVGcUhUYmhR?=
 =?utf-8?B?N1ZPb1dSWmNNam9WNUE3MWtka21BdmNPVjdxK0MxTTJRSzlWT0Q1R0paN2pH?=
 =?utf-8?B?N1BucHhhVzVKKzJxZmxpWUF4eDBuR1pvMk5XVzRKTjJMTFB5YmtkcHA4VzJO?=
 =?utf-8?B?eGl0eFdyRW9nNGQyOHl4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFh6alkvd0I4YWdBejhkdzEzL0RoZm93TCtqUmtIbTM0VTdoOFpmT0tlSnhs?=
 =?utf-8?B?UG4zRkI2b290dnhscVh2QjYwVWgwUmJ0SmI2N3VRS1JGeUZLTGszR0I4bzBD?=
 =?utf-8?B?emNXMDZRU0piTUJJTk5UcTZldW8zVmxDYzU0NDJ0UFhNVDUvOVd6cWU1OHc2?=
 =?utf-8?B?S2xheC9uUUx3UDVjTlRJbTVmMngyZzI3UkFncG02YWo0TkEzVzJjNjRnWHlU?=
 =?utf-8?B?TnpFZitNRDBVcUJYWEcwWm5VS2kybGRxbGFnVTdSRjMvalpiVUEwMEZWaTU1?=
 =?utf-8?B?eU8vTk9ZUXNqTWVoMmh1NG5XRHFLWDFURG5QOTUrSU95U2xnUXJGOFY5WGdC?=
 =?utf-8?B?Y2RSTzhnVWZtZFhHRlhkMmxzSDZPY1JnTStKVWpZcCtxd3phQkt3Y04rd1BO?=
 =?utf-8?B?OGpUdlBydGRNUTlGcklXZGdWZFcyUWk0OUFDdzNDbzZlUU8wRTR4ZG9BQmxN?=
 =?utf-8?B?TkYrQlV3WVBneFV4NmRBTkYrMTZSbEVhV081aUd4WTQvL0dQV0p2dk42LzlB?=
 =?utf-8?B?RUw3bi9kS0JHcWFZSFBZQktRUzJPMURxcHJSNGVzd1lzZEdHY1lUWHdyeG9x?=
 =?utf-8?B?Q3JHMTA0SGhRcUFzMnJEUUpORlNGSkxaZ2VnbFhsbWd6eWhVeEVuaTZRQ25O?=
 =?utf-8?B?TFNqTjlUN2pqZnFWcDdiKzJ6SjJNZzl5SW10YUcwT2xZa3BRcnRhczlvWDhm?=
 =?utf-8?B?anpuNnNVaitpTjQxVnhKb1pNZ3cwYVZCTWM0VjJUQ0NKeTRzZE5iMTg0dnlL?=
 =?utf-8?B?VzE5NktsREZ3UVFMeTVBelNvZ2trUmRabS9YWUZCWnM2Y3BSNms2Tlo0U1p5?=
 =?utf-8?B?YnNCN001VWUzVWVmSWFCWXdOZXpiQ0tSeE05S2ptOTd2WllueTF2QytjdFYy?=
 =?utf-8?B?YUhsRWVYb3RzZWVFb1RQaDZ5MVNIUFFyMUQzeVRWOXRsdDlNcGtSdTJzZ254?=
 =?utf-8?B?K1k3L09NRDdzc2NvQWUxZFRlZ1U3VHo2UDI4M1NDVDhIRFZNUndEaGE5aTh3?=
 =?utf-8?B?NmpDZU1mT1JYUXFZTUtEV2V4YVlud0JDdjJMSit6SUpwQ1BXY3E1MWtzVW9u?=
 =?utf-8?B?SjZOOXBzaTZvL2lmRXdUUnJDajNOVlZVOU42bkJveVpVNU1SM3V1R28wTnBQ?=
 =?utf-8?B?UDV0WVZjYzEvVjJxL2Y5WFVQNTBWZk1pSDFoVExsZWdpWVZ5QXJrOFdCVTVI?=
 =?utf-8?B?RzZjdm1sblRBVVI3V0lGZzlGbFR6eTUwbjE0VjRSUXJUeHBMZk1yTzV4eUV0?=
 =?utf-8?B?ZE1uWDdtQ1NMM25pVXMwaGZ1Snd6OUw5cHpIeUN3R0xlaG56T2M4ZU04dTVa?=
 =?utf-8?B?SGdiWkMvdHlVS294RmRDdDlUS3VVZWdJa09MVEVRWk4vQkdDRmx0UU9uRjFx?=
 =?utf-8?B?RENDUW9wWGo2OS9oYlc3MUNrR05VSmVVQy8vd0lWY1ptSDJIM2JnK0g4WldV?=
 =?utf-8?B?Tm9FeWk3cFVkcEFGOHJYRFloYzBuelNvc3IvRlRBWEtzT0c1bERWMllZaXhE?=
 =?utf-8?B?K0NPZlJEcmp2ZmJNN3lTUU9CL3ZZSm1JYnNNMDRVSXVsdTVsM2UrYmhYOTJu?=
 =?utf-8?B?KzVCWkNlVUkwa2tLOS9Xay9DN25oQnlXeTVKZjI5R214eUpza3JxdTF6QTBL?=
 =?utf-8?B?Skp4bVNjc1pLSnJYcGs1MEZhMG9KMHI0L2I2MWNVQnRldFk2TEcvTXpVSSt3?=
 =?utf-8?B?c3p0WWlaZWtPd096Y3FKTExYdDd4OVR6Y0EzbVQyLy9oc1NXK2hlWTVWcUlw?=
 =?utf-8?B?REoxVzNXUGhPTFR6YmRqTTZ4QnR4dUx4TlB2eDJsdTVldUh6OGo2S0xYeWFW?=
 =?utf-8?B?cWlyc3ZXRlBFMjUvSkRSOEt1U3dCK25TOWFsZWw4aWMxN2UwSCtOY25uaGcx?=
 =?utf-8?B?VzJ3MmRSY2tzQ3lLVXowUG4wKzBIZmh5S1RoOWsrdkx3ZzNYbXhEdEMrRGdJ?=
 =?utf-8?B?akFUZjFiN2h6TWYveUVXOFNNeGdjbHNvNlVWdUxObVAxRFVKMTdod0x4b1RH?=
 =?utf-8?B?NHJSV2xHQmtabEhNcEdwcDlXREFoS3VWVCtIYSt2Z0QvS3YzUmc5VmliTy9N?=
 =?utf-8?B?YUxIR2Nzb1dPN2krVCs1NGs0WTIwNFdtYzZQcUhQc2JNOUVxdHR5aVNiWnJW?=
 =?utf-8?Q?tUSzRXni8KccIYOgwjqvZU63J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 157d3310-aad7-4a28-3186-08dcb07ae1c0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:35:00.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUCw/5YCYg8YnQ/SNDsUPN+z5yAPuGv9QXWXc7peLrEoSJEs7L038Tg2qS2cnA7savgTmb1QwB07VLn/Mb37ZdijEaCQ6ZaLE1tC6ULIk90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com



On 30.07.2024 08:16, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> In case mlx5_irq_alloc fails, the previously allocated index remains
> in the XArray, which could lead to inconsistencies.
> 
> Fix it by adding error handling that erases the allocated index
> from the XArray if mlx5_irq_alloc returns an error.
> 
> Fixes: c36326d38d93 ("net/mlx5: Round-Robin EQs over IRQs")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index f7b01b3f0cba..1477db7f5307 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -48,6 +48,7 @@ static struct mlx5_irq *
>  irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
>  {
>  	struct irq_affinity_desc auto_desc = {};
> +	struct mlx5_irq *irq;
>  	u32 irq_index;
>  	int err;
>  
> @@ -64,9 +65,12 @@ irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_de
>  		else
>  			cpu_get(pool, cpumask_first(&af_desc->mask));
>  	}
> -	return mlx5_irq_alloc(pool, irq_index,
> -			      cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
> -			      NULL);
> +	irq = mlx5_irq_alloc(pool, irq_index,
> +			     cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
> +			     NULL);
> +	if (IS_ERR(irq))
> +		xa_erase(&pool->irqs, irq_index);
> +	return irq;
>  }
>  
>  /* Looking for the IRQ with the smallest refcount that fits req_mask.

