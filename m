Return-Path: <netdev+bounces-171678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9FA4E23B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA56883E9A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D073253F2A;
	Tue,  4 Mar 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngACkfLc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7462376E4;
	Tue,  4 Mar 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099581; cv=fail; b=l5njJT41h8G9xG80U5Lqmuz3ZHLe9GZUNqNx/1UC8gEL8cWeI4wA9S9Ipkzmn61+o6/2bRgNGVPDL4zdNfO90BCZHbXzmdMYO9R9ZtiowzTGTuzocshclMVX6tx3pZZLm9kbLC+2zvMhvkqQxgFZmInHGQTKtWQgi2RE5cwooVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099581; c=relaxed/simple;
	bh=zf2zkjPMafePLOsy3+xVmDqQaOgrKrtxU5iRonzIXRk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dStrutDpi8RH9Nx1X9iejjbT2HieyIGG3WaZhB24FLSRfdpljNudJO+cWSzFsKUJZCB5y0jAwKGfff4jwoNN5Gr1jDqHJS82jTa23yrzO2AWKhiKL9rdYpKO3P909F8hdfKODDTjcpno6dW2LHvitZCptaIg0+fDoI80yVxmN9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngACkfLc; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741099580; x=1772635580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zf2zkjPMafePLOsy3+xVmDqQaOgrKrtxU5iRonzIXRk=;
  b=ngACkfLcLNGy41xf+Ls0bcUsmd95VBEbd5IynyYf05KChNnKPCNtpPGe
   lGjvSDea0o1YlFMEfDSwdfHL9fiFyeILKbITb4Mv38wByDDOp8dL6JAoJ
   TsHWRsAirrhjedB1D1lh5Bm2ubZSC0RQYEQX0D9uBTROLgF+35U6fH9dE
   yaPkIbLpPU7aFiItRWe3nFT4hEvQ5kIUHOVlE0nmfTWDcjkSg9BozZZz+
   f+H/308Cg2AGj6qCbGvzphFCOdPefMAvMo6kw2o3gT3nOzz4VQBTK2Lq9
   Re+VV6OTTMt2xspFce0mG/ATcEvMZKB+QT9HjP9k1O9QtLoeBcMkajBfy
   Q==;
X-CSE-ConnectionGUID: a/d6lFgqSFG3FRYbYB39/w==
X-CSE-MsgGUID: C++jY/aMRK67yylT/oFaiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53414148"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53414148"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:46:19 -0800
X-CSE-ConnectionGUID: /mOqnWiOTSO4HB0dmBKrcg==
X-CSE-MsgGUID: berR0WHrToKp96mP1GHoeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="119073515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 06:46:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 06:46:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 06:46:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 06:46:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUqKVtSBkanb6Je+ANP6DNOJYOelQS/WlZlndDc5yDrhZMv8521j7QkQNu1B8oOOEw3JUmPcDyR8WzU66jcI1YVi0t5hg0RLQeYvxeO8DrSBfANNfDikvaFLIcL+nXi8A7kg3PZ0ZWnQDcj/SomMjQrEA8v4nETSu51X2iEbUG1n2j9gfN9UY5pime0bFEYAV6P0NxKPXBpqugxwd802gPeaY05zlGG3nr0ivtZKSBRY/6iemRhl6j5dXmmDyObf9pPKO6GOBrrIEJ70xYs/aZwjVoA+9PAgtxCkF8wBK1MCWMv+R/nZuY7s1H4MWzwAEB/zPQKGj1Y+oEFl5AArkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fT4C3iOSYykc4ga9NUgo1nH2Eme3JaGDXpMJKH4G3s=;
 b=jJAcwolnNeCCX4d07oI3iU0bq9vuu6b0l6YQ0SCks17pQPKo6WYBNmMOw5pKOYgo0oVJb9P2ELhdXsqPZFVm27Sorbi++2nogNjO1OH0qGB56NwF5jkDgD9jDND4EXr7SLahX8oXchx2Le0lVfw83d/0Mv75E8S6HYCX/n7BnR6m5IGp9Mq7gk3LY6fMaDkDUnsUcGxAMHKHQkBgFk+Wabm6DKNW74SW9aSxKE0Jtn4qMyQOmqhu6ZhvoPm2zF5XGt9b4IMdz3wx97k9UgaKVjuqLbQJgDBkSgCYGFAgVzieHu1Ng8/ugGgqGWxz/hRDRHZ4Q3xyenJzx9Px7I+58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 14:46:14 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 14:46:14 +0000
Message-ID: <ea04dcab-e399-4c96-a5cd-db921a1bbb42@intel.com>
Date: Tue, 4 Mar 2025 07:46:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: Silence use after free static checker
 warning
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <Z8alMHz89jH3uPJ9@stanley.mountain>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <Z8alMHz89jH3uPJ9@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::33) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|PH7PR11MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: e034b915-1de8-466b-d678-08dd5b2b502c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dy8xV0xBbHBWK3phZ0FJUUJQYVFxcjNPMXNpTnV3U2ZIM0JvbW41eHBsUmhw?=
 =?utf-8?B?ektMajhsNEJNVFdZazRhaFBOSW00MHM1QkZBY0xyNGlsSzFVQ1VrUmhjUFRM?=
 =?utf-8?B?WSt5WnpSOExJa1dkNFFtWVR2eUUwZFFUY25RYkMzZElZcmpyVFdyZmx3UXFH?=
 =?utf-8?B?dkoyVmNzbkRoM3JoV0tDc21LVm9oZjEranBkL3RJTGdzSlZPN0V3dHhyQjlC?=
 =?utf-8?B?U2FjdkhsN0tjaFcyVzVnTUh4akk4akJIWC9VTVZoT3FGdVllVHFrcllGa2xC?=
 =?utf-8?B?V0VYenhncTVkSklQVS9XTGZFU2cvR0lhQTh1S21MaHlEMmJVUnFQaUp4Wktv?=
 =?utf-8?B?SEtxak1tVG1PUFV3NXZUVFBZVElaSkoxTlVESUxUM2o0TG91VFh2RUhUWFF2?=
 =?utf-8?B?U0J1KzE4MlJaSW0vNEU0MkJrRW5Yc2s2K2FNK3hGYytYZUF1aUZqMTNOeTZK?=
 =?utf-8?B?MFJLVzYzTjhPa3lHUkJ2Z3pGVmhUUEZwUTlmeUJrMlBUbWcyS2p1Z2VpdzNT?=
 =?utf-8?B?a3ZHaFlMQ0wxYUtwMkk5R1BLY1M1NmQ4NzlUeVIrRHBqVG1uSThPZ2MzcFBL?=
 =?utf-8?B?MFhwRGZSYmNsWGdZUXdycmE1V3FHQ0cyZnBpVlIvQTVjckREdTdhMkF5dGJ4?=
 =?utf-8?B?V1d6Rlg1clZQTFpWOGpzWVB0QzBuMkVwVGtUQVB5bTBGcUNvM2Q0cktnMElr?=
 =?utf-8?B?TWd6c3RtVDRrMWlHaFFIREduS0dCNktRSWwySXlsWlFjSTFnOW1hTGFaR0oy?=
 =?utf-8?B?ajEvaGJzQmpHNnZ5UllxT2V1azFnWE0xeXBkd2JlNHFSejFHeDk4TjZSSXh1?=
 =?utf-8?B?aGdEQXBxVEtMSXhaWU5TYWZsNHJYWXFYdkxHYWFVNi8vcVlhU2VNMnBmZENM?=
 =?utf-8?B?ZExDam9BRGdKdkJXZHNHNnBadlBiRHRad3RvOVBBTmpoZnFoZjltc2FZYUc1?=
 =?utf-8?B?elhaUWM1Wlk1Wkl3dysxaFZZWFI2L3ZxTTAxSXlYbjFTNWdRaXNHU3VDTnVq?=
 =?utf-8?B?MDFoanNWTCtUMDRuK2tNZU1yZDJXeTRyYTR0Sm15NGc5S2d2TEk3SGhLUE1P?=
 =?utf-8?B?TmowZGNaY2JuVjJxdnlGSkgxbFp3Y2xFV1haNHd5OEtZODFnNEFyMlZMeENR?=
 =?utf-8?B?QVBveWhUMVZkOVF0TzBIdnFjZ3FKSWkxc3dNSmhzYlpTbkxVZEh0ek1Jbllk?=
 =?utf-8?B?L1pOdHdUemNWc3dYS1AvNmhyNTUvLzR1ZmkvRG5DNW5EV2N6ZCtNcGZucDdN?=
 =?utf-8?B?YnBaSTVWTzFCcEh3Q25LMUk4ZnV0ZGVwa2wwcDJjQ1JZTGNEaE5jYjZKSFlm?=
 =?utf-8?B?RDlKYWY2Zng3VWJxb3dXdUJiTjY0Yk13QmdFUjhGdWN6SzZNZ3JPOUpCSE5w?=
 =?utf-8?B?TlFZZnJDRGxObmFtS2hmTjM1N0xwMS9oLzJucDM1clRqWFJiRHdZUHRXWm1G?=
 =?utf-8?B?bnNEcHNpV1MzTGVQTGlrcUVmSlNRSmQwSUV6SDVON25jT3Z3eWhLUzVqdUpv?=
 =?utf-8?B?ZWlZYng1UFEvWjdERWY0YllTOU5BajFxQ2t5K2ptbkc0L3l4bkh6OXFENlpC?=
 =?utf-8?B?M1VKMlV6SmhlaE50ZlQvcCtXejBqK3BicXlFM3h3T0Z4WVNkUTZsTnFqdXFz?=
 =?utf-8?B?RnVDZ1ZVa1ZWT0ZWaTZGUTkwbWZDOUozcHdMN1FYMXVaMHU3RXNJSkp0MEZE?=
 =?utf-8?B?bkVJekFUVnVjaUdYYnJ3VWx4Q2o0bWViYUltMDRkbDJLOUs4L1YwYUZZSEZk?=
 =?utf-8?B?R3NMaGtLVmZLZHJ3YXZUOHdpQVR0YVJWSzJiMm1lY0ZaNFlTSkFCZGlQQkox?=
 =?utf-8?B?K0pGNjVvM3lPYkJQbnR0RVZqMWxqUFk1czVLRG4yZ2xLNXZSSm5mVFc3N013?=
 =?utf-8?Q?fxWf/r4tssnJO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWVMLzVJekM0TU90N1FxaXZSZUVOYXA5NXBYTU9KNitmUzRkVERzZzFpc3lS?=
 =?utf-8?B?NmtzMmsyTlZyN1FHRXNqeXF0b3daSzNzaXFmTVBaN3ovTGI1Rjd4dDBuRDRk?=
 =?utf-8?B?M0JnRWdyMzVTRVdsUHdZNjFlbUdmRENLYXc0cC8wWm1PNFVISUFSQVoyVjdp?=
 =?utf-8?B?aytSZUxBUjR0SjlKUC9YYmZpMFhwcGc5UnQ3Wm1Oa0FHQ0c0dGdINWlZUXRV?=
 =?utf-8?B?VkgxSGVmcUg3dThxbDFIVXVDcENlMXIwRXVoVVB1aGJzV0hFT1h2UHBEcWhx?=
 =?utf-8?B?Zmpmc3NBSklFQ0pPZDBIZjV5SC9WVW9VbkozYzNqZHpFWGxRSFo1dmhmZHJm?=
 =?utf-8?B?d3ZiOERCL1JhMlZWU29rZzkweEU2K1p5QXo5QWdiLytXMk5CeHdPQW1tSDVz?=
 =?utf-8?B?cVJxeHYram9VbVdSbVJtV0l1b3pBd1ovbStRNlMyWDluSkl1ZjNzTlBvalVL?=
 =?utf-8?B?ZGE0SCtCa0wzZjRobldJdWszcGZxd0Vic2wxOWw5a1ZNSVpJaVpuaXJER2d3?=
 =?utf-8?B?ak5vaVNwRUI5M1pJWFFib0xER08vc2IwZ3FIK3dRWFc3RXI0czUyeXAvUmla?=
 =?utf-8?B?RjVhRksvZExudXNjQkl6Z0pvVzdWVCsyTWh3SDdaeTZXSzRkZmhKSThTMmZI?=
 =?utf-8?B?aGppMnh1bHlTdW8zbUNrNFY2NENhOERUUzZKRDRVSDhJOUt2R0dqRXROeENt?=
 =?utf-8?B?OVdRQVRjTlgveVp2dG4rTndTQk84YmdDN1JKOUNZMlVnR0RHS1ZSUmFKOFRB?=
 =?utf-8?B?OVBwMkUybE9SV2VYMlVCS0pZL01iVzdBNTJ5ZlJJY3NtcWs1ZGNTQzVXaG5h?=
 =?utf-8?B?UjVKVkRhcFp6UkEyVkdhMzdsSUxkYjBLWU83L2VhVjc0WVFITmxGYXY4Sy94?=
 =?utf-8?B?VEZoRHRRbUJveGRTcFU3clA4UEpsaHEybFhINTlydW9vSHRWNkVGVjRkZHR1?=
 =?utf-8?B?R2IxNUl2OHJzMENsZzdqeDdKZlBRQkFXSkNWc0E1T040NFJGYjBCUWRTY3ZS?=
 =?utf-8?B?UFBoOGFRa0Z6NnExK1ZmTTRteStHbnZUQnNoeW9sNkg5Y3lnbWZaYlBxSmlF?=
 =?utf-8?B?dGVjTUNmbEVOSkJjLzZqL1BkbjBGRkRTVDlTNGZMb3dsZ3ZLWFoxdmxwakkv?=
 =?utf-8?B?RFBuQjBxcy9GWG9IZ0dXRW9HWUpzQkVhUksxV1V1eTFzRFhWZG1neXQvUjM4?=
 =?utf-8?B?dEs5QndtdTlTZ01ENENmd25sY1M4bUNRRmtjVGhvZ1QxSUVYQXZOY2RmQUNZ?=
 =?utf-8?B?MlRUYlpjQklyUmk3UXNBcWljUEZTcXEvQVRMdDA3QXkzMDdOWW9yK215M213?=
 =?utf-8?B?Wm9URmNaZmQxZ3Byc2F4N2xyN0dOdDNqbWxFeHd4VXhtSUFlaHZFWWFXQUtn?=
 =?utf-8?B?OGIvZDdRMGNoL2M5MmEyamdUODl4TS8vd0ZjZldSN3hWWkpHRXAzNnJ6dzlv?=
 =?utf-8?B?Mm5jUkVPcThIUEhuMlRBNVdyZGJ1bDhFa1lDYlNnYzNJeTh5QU9TVjFUVnNj?=
 =?utf-8?B?cGpyUlZEOGlQelhBVHFxT2p3azQ1UE0yb1BWd0taclJMQ1Y0d1lIb1E3Yk0z?=
 =?utf-8?B?MEpnclQzdFFTMk5WVyttZmYzOTJyOCtabXRuS09FUzlQYjlhUHorby9rQVZk?=
 =?utf-8?B?M1FtZ1hkRE9GK0cyeEx0VVE1MCtzQk5JTFNuMytrUHluMmV4USt0NnhQbEdn?=
 =?utf-8?B?WTFERklENTE0TzE2Kzh2cHdnbVFZRkh1VDZWZE44dllPUE9iZHNuWXN0RDNv?=
 =?utf-8?B?QnV4RVFjMGMxMEh3K0dlVklTRTVET0JaZ2w0bWFqcFhtK0dKQmZQOEc4UDdH?=
 =?utf-8?B?Z2YyWENPL1E1Ti8zbWhaT05EQTMxbFlZUFR0RkhabmkyWTU0cVNhRE1SKzhV?=
 =?utf-8?B?TnEvbGNoOFdLeFJCaFZDYnI1Y283MDg0UEptWnF6UkVtMzBLUXAwcWp2RUFJ?=
 =?utf-8?B?Q1NxeUJoMEMxcWprRi9OYUFZdlJnY0tkaDVhZmE3Wm1rMEc1aDZUNENmUlJB?=
 =?utf-8?B?U0liYnB3WmhOcDJ2NWQyMmYxajFyUXJCNGdzNVkwRWVFZ0FZeWhvVlF1L1BO?=
 =?utf-8?B?QlgySDhVbHVsOW5SRnJMNFQxNzFsNGV0M2x6bitoVGdsTVZabnVlbkp4WGhv?=
 =?utf-8?Q?upaeWjWrsxRU1HERhWfFXAAA2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e034b915-1de8-466b-d678-08dd5b2b502c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:46:14.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyGe4+kGuof5SVzJCx+1BOyMASlXCB7tbrf6S25Ag5PGlJlRo+jVv7AgeKAn9/0x8OO15G9VgCa7d2UygV83Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com



On 2025-03-04 12:01 a.m., Dan Carpenter wrote:
> The cpu_rmap_put() will call kfree() when the last reference is dropped.
> 
> Fortunately, this is not the the last reference so it won't free it
> here.  Unfortunately, static checkers are not clever enough and they
> still warn that this could lead to a use after free on the next line.
> Flip these two statements around to silence the static checker false
> positve.

nit: *positive.

Beside that:

Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>

Thanks.



> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   net/core/dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9189c4a048d7..c102349e04ee 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -7072,8 +7072,8 @@ void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
>   put_rmap:
>   #ifdef CONFIG_RFS_ACCEL
>   	if (napi->dev->rx_cpu_rmap_auto) {
> -		cpu_rmap_put(napi->dev->rx_cpu_rmap);
>   		napi->dev->rx_cpu_rmap->obj[napi->napi_rmap_idx] = NULL;
> +		cpu_rmap_put(napi->dev->rx_cpu_rmap);
>   		napi->napi_rmap_idx = -1;
>   	}
>   #endif


