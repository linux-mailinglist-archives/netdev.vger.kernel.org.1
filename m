Return-Path: <netdev+bounces-204140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD79AF92C5
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CC61C88648
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC502D9483;
	Fri,  4 Jul 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHjfOf5j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D532D8DB5;
	Fri,  4 Jul 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632505; cv=fail; b=Rjaa0xqZCAwzeVXLD7RR1cm/9nBV6lwo5pS7xfLL+rftoCHN9rqdFc6te7uQ5Tdx0GzlTsK4tNUEgSVWgdIc6FmlyBrvXoDSaCG5mHLrQcG6aR5hQMz8cS3d9KARmwz20HtXK9n9M+y3DIuq5NXDYXVMQJ485DUShXduWLUbk/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632505; c=relaxed/simple;
	bh=U1aptiLNfZqhKQll+wd+G19r4P2GHrja6ZWWiin37zQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fHQx8aM+l96cHAlsyezykw/kDAiW2TD6IT4seh7LcIRCkqavYvBaUlu0gNwLPkvtmloqJyLwTPEQPRSpcLCFrMV3h8alBubrLFgmiCh1mpXb/Mb/Eg+4t3omRFA0Sdc7RqpRZiIJhAFBy0JZciusKL6brTq1zw2HTcOaggOquqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHjfOf5j; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751632504; x=1783168504;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=U1aptiLNfZqhKQll+wd+G19r4P2GHrja6ZWWiin37zQ=;
  b=KHjfOf5jjXk9KaIvzF0AfhDLpmHxoUnpk/dfAnZ6DB2G4gUF+KOJpqP5
   jHV7DEr/OnCdw6O00MRLPPXHQi0Hfi1kRZsc7aH7vYBAz60VJLcKSOqqv
   y1A5VtWn3w0Z4SN+Hvk1NvFkT3o9mv48keg6Sbxa9Mpynp7PK9nhn/IfJ
   kuuwKWvsjBBv6uydadW0NrAyEI91xVHWlAgtEx5drwOu6nMv3Bh/PbAiW
   m14DEYBQnV5a6QYk7e7HqRoglh5rM2y2d1XN5dzDrZYa58kqgw1JNPjrM
   xtMhSOeKuG+iXz6RWAWLmDxuZzn8fHJ2l4ij53C4TwIpNOWR/nxp1fjg5
   Q==;
X-CSE-ConnectionGUID: iFvz1U+rTTeuQ9+W9Ierrw==
X-CSE-MsgGUID: BsAhnjOnSJ+c7T7L64IiCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64658938"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="64658938"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 05:35:03 -0700
X-CSE-ConnectionGUID: fher8P8zQAOoa0MC4dD7Yw==
X-CSE-MsgGUID: cR5N4cXFSsKb1gF3Iuk5FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154762811"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 05:35:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 05:35:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 4 Jul 2025 05:35:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.73)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 05:35:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKtX8CWtqo03h40QZ8CtMeFIpqqpr9xqJ+oGzB/V43mRIHWOpJHWU5wpvEPomlqMNIvnwjK9PtE2JG8SILhvj3uUu4FwJGRFsAqdVu0CDy09lWZ4o8XJVb47kTdoiuP5X47w+dvmGUiU0hVar3NsF/4cigoVvS8BSI3Cmx42s78t5PPoQZ4AUXJRzX+rrmPf7Q//LAGhd0bFrCxoAI3K8UZPbp/nXz5HCXpEoow1TNQyGyqyduqwv+0Vxln5umeG6+fOb6q9ffWlk0hpY7tCKVa5o8apCvA4BxHYdxXsTSHxGEN8/6uHtxF4IEIp5ZwsUej8lYYcwbRkJZhipC1AOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l8j46BGqb5aVqEp5d6C+SyDRnI70h9bnzHcsAhPIAE=;
 b=k+4YcygY6tc18cKzN4eo20Sssx5e2cGojOkGBtmFCmyvJUzp8bc//rBaNo7BXNW+rOVo6FINVITHRAq8YeKYqFNxF/09wadd9wBYgOSArOBs0pOKYY4mzq6PoMOqcSuO9ecDaTalJm5QCECuECU/Aq83HbhzqiKLsW/A3RwPB2ku340lQcvp3wDL68Hdfs//lDW+EyOoNxyKVvM+WY+l8Hax+nVp6qu+JSX6n/mMPJUpdn5FSXsXjHHReYopwW3w4SjDrDhc77BXuIzvainEbM6YkcsZO0E70kr5EWx8gjoTTrRIEa8bSEkp4GedySrEzd6zhsm6IIhiVWwYAYahww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 12:34:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 12:34:17 +0000
Date: Fri, 4 Jul 2025 14:34:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <e.kubanski@partner.samsung.com>, Stanislav Fomichev
	<stfomichev@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "magnus.karlsson@intel.com"
	<magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>
Subject: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Message-ID: <aGfKRK2tcnf9WzNp@boxer>
References: <20250530103456.53564-1-e.kubanski@partner.samsung.com>
 <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p1>
 <aDnX3FVPZ3AIZDGg@mini-arch>
 <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
 <CAL+tcoAk3X2qM7gkeBw60hQ6VKd0Pv0jMtKaEB9uFw0DE=OY2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAk3X2qM7gkeBw60hQ6VKd0Pv0jMtKaEB9uFw0DE=OY2A@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0167.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 047d399d-d5f8-4463-cf08-08ddbaf717af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkNkVkdUa3FtOVJ2R1BFb0NvREZjOXVpTXZlSXl4aUQyR1VRU29KdjRKVUcz?=
 =?utf-8?B?b2lCYmVSKzZlYjFqYk5menVOQU1KZUljRStrUkdhK1hqZURyZlNlZHl3SW9S?=
 =?utf-8?B?UVJMNnJ6QmRvclF2UW5WUTZoL2piNVJKOGVZVmNBOS9kV0JOYi9ZRzlBVjZF?=
 =?utf-8?B?L3pEYXUydm1UTHoxUXdBazFCOW5XVnlLZzlKUXEzUnhVMVU5THoxZDJmSjMr?=
 =?utf-8?B?L0czaVg0V0YvUlZFYUoyNkdDYVdpYVhMK0czZWFIR3JqYmwvc3A3N0VHZnZ3?=
 =?utf-8?B?bW45SkU5OXl3UGljZ3ZjT3ZVbmFrMnpDQWF1b3hxdkZRZ3BuUVlURGUwQkpo?=
 =?utf-8?B?YWhOTEo2OTg2bHh0b2UrcFpNb2RXTEwrK0JMYUErcXdGRGYxQlNVNERVVSta?=
 =?utf-8?B?WllDRTV6Y3hWazFmNVdGbHUwdVlaRW1PdEFycnNvdVhNcnJlTXNlQmdqMVAx?=
 =?utf-8?B?Z1hiQUJKLzFDZ3U5REM4YzNocUlkK0hzZGNQVGludkN6SGxhYnNUeGtHNjNU?=
 =?utf-8?B?eUttdTFreW1XTEZpSXhTblloRTRaNXE2Z3NqemZUTmw1N1JWOHMwWFNNb2xT?=
 =?utf-8?B?Sk9nYnhGTHNBTFh2SExUVHdqUmw4Mk8xcDQvb0h3Sm5paVZnWW05L3JUbXJl?=
 =?utf-8?B?aGVtL3BvWUxQQUdQOVFibWVGT3UyTHJqWVJrZldXY3NNNjRCOGFVZWg1Vmlr?=
 =?utf-8?B?ODJYVnRHdlpQUXJvWEo5NzN0aTZVVUx3YXA0M0JpT091QzlnWUxMazRDYUxh?=
 =?utf-8?B?c21paXN5aFZqOHQvNVgwYmd1S0hPcHVjRUUyMWRQYWFYT01YQjArVENzSmNR?=
 =?utf-8?B?VGt4TWtGU3M0ZkJYeXBwZ252b2xOZHEwZ1Z3SjErRlJsbi90RlB3Tmd3a1NZ?=
 =?utf-8?B?QlV1NWNMb3NpSGxWNnBuMUNBSzdHS2NoOWU4a3dGdGlwRWExRG5jWlFEM0RG?=
 =?utf-8?B?OXhZcEpUNmE4QW5NcmZQcGVuUDE5RmlaVUNsVzZNcWhNUWY4eXVLOE9PRmRG?=
 =?utf-8?B?NW1pN2RFeUdrUXpXN0JMak11Sk9wSUoxN3dPbGx5Yi9rMCtmT1ZEaU80c0Q0?=
 =?utf-8?B?SkVWbEdUVXM3YXBaTXZzZG05NnJoTU8xUi9oTEhHWno5WE9ycldhRkNEaVZO?=
 =?utf-8?B?Qm8yN3hNRzdIRXhJaXBzNXNobkpwM1BIOUhsWmdZTzRKNzJHRVNVcmMrUUN5?=
 =?utf-8?B?dVpRcGNQcEJHZGpxc3RoZjRiUzJIVE5CQnFHOE85ZzRwZnpSS1VxOUFybzJF?=
 =?utf-8?B?N2RPNmtqdDJqTll2eVVadm5YUWc1WnJEUEdVaCtLWDBsa2NwZTBtV3c0Wnhz?=
 =?utf-8?B?ay92VHZFeTMxNGNQdEpjbldRNGk4eUllMUZKQk4wSktLc0dzSjlraW5PNzdq?=
 =?utf-8?B?QXpnWFN1VU9LSHFzZ2VsWXlFRnZOeVhmZ0FNWGJoVm5JOVpRUnRXWGdQSzdQ?=
 =?utf-8?B?K2FySzZmUnRINTNRaWtkK0tRdEw1OStTbWtvUlF6blZJbkRpU1E0Zm5DL0dp?=
 =?utf-8?B?Y2VOd1lnNFJITlVTajZYRXQ1Q1Bva0Z6NTBISFJoZ0dMR0g2dndJK1RVakMz?=
 =?utf-8?B?alpxYVJVeVRDZHp4MytKY3pELzlsc3RwdCs0Z3V0dk9MZitTRlBSTUFlUG4r?=
 =?utf-8?B?cFZoMDhDcHNHSnlZanRNL0RoTS9ydGFFYmw5SXZiVjdHVXFtdXBPSDdUUDRp?=
 =?utf-8?B?U0Z2QU80NmVFN1ZCSStMYUh0WDB3VUl2MHliMElteWxYRVBxdFdVQitxcklE?=
 =?utf-8?B?NldaaHk4WEdQc1NLdVJKV3FNVm1URWxEQzMvWUU2b2ZtL2hsUDB1WkNKU2Y3?=
 =?utf-8?B?Nkc5VVRZeGJjWksrZ1FzS3JodFUvMHkzV0xZemRkS0lwaFNpQ3hJVVN4TFBU?=
 =?utf-8?B?Tnl4alkxZzQrYlF0Z3VnbkVqK2wvRXEvSU5NS1Y1Vi81MWtQeW16eFQrZjlD?=
 =?utf-8?Q?wd8AF5yBb4g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk5SeUwwSnFrYjZYV1QvQVJoVE05TGNVcHQwMVJxZkZ6WHlaNm5KT2t0elFT?=
 =?utf-8?B?N2REeE9JY0tUeEEzeUlLY1hUU2tZOG5UVWFUU2FpdjhvZG1BS2w5M05ITEdY?=
 =?utf-8?B?cHJmYlR0QmExZlhIajNZUWVFVmtCL0loT1BvZjBIY2c3LzkwalFIb3hURjM3?=
 =?utf-8?B?VzZFdlVTTjhKVGU5RituQW1teURscmZxakppZGYvQUExOTF4Yi9xYXBXU0lW?=
 =?utf-8?B?dks1Z1BMRXhZbTN5TGJvT2pDQWlTeDJzS281aWRVMlQwTHBMdW1oV0x0Y3Rl?=
 =?utf-8?B?a2RCcjhqdHJWRGwxc2JUbC82OCtOSThvTXowUUYrN3hKN3BaNzJvSFVyby9q?=
 =?utf-8?B?cHl5ZkxvN3A0VG94c2xzMW80akdHNHp0YTJyN0NTa05VNVJjRnFWRWhoY3BB?=
 =?utf-8?B?aU14SVhqRFBVc2RQSFlOYi9YbDNlaVBIRGVRd0NRbnV6cm5nT3UrTEdLQnJw?=
 =?utf-8?B?NU1OajdLSU10ZmtXM0swSjRLK3BreHo1SW95RFZVTzhGREtQQ2xZSGtYVFUx?=
 =?utf-8?B?bWFtMW82Q2JLWmJ4aGVSbHpwK3FlK1ZnWEMyR3NpOUJHa1Y0SWcvM3p2WTVX?=
 =?utf-8?B?ZzQ2ZkxQUkgwQjdCdDdyR3hqaHpYREY4STRoVGdTeW1EZTV3Sko2bzZOMnQw?=
 =?utf-8?B?eWhmSE1sZTErbnFyRTAvZHgya1BTdjNzaGJIdUZ3T05HN3VHclNjOWxsYjRH?=
 =?utf-8?B?TTdzVzQyWUluSlVWUU05R2xxaER5Q2lGZlI2bUhPQ2hIa00zemovanVTQXBH?=
 =?utf-8?B?Z3JHRE8xU3lQNGUrRVNKTmlJY0YvU20waVFLWENUSHlRL0NWdFVqQVo3Z2l0?=
 =?utf-8?B?b0RyS2hseHVrUmpRQmNScTVBYitrSHB5QzRDM2FiWmQ0ZUJ3K1hMejlXaHNv?=
 =?utf-8?B?cnRwNjQxaEprK2hRbnNSSTZra0I5MlBlZG5vbWQxWW55bkFraDZpOHlHR3d5?=
 =?utf-8?B?SUxETDhjZmJSM0F2ZGh3dC9NQUx0Q3p1QnpQUVV6UUZBYnBTUWplamEwVjAr?=
 =?utf-8?B?ZkVLb0pkWk5iKzZtZ0xPamQrd0xFYnBndlBLSW1EZzMzSG01MUpiWEtkanNu?=
 =?utf-8?B?MERwZ2lXK3BYV0R2OElrZTdzMGV1cWtJcWNWRzFDTTJGb2Vzclg1SlhMUWdX?=
 =?utf-8?B?dmxwczErOEhSQURLSzBBSkZUWEpuajdrRndNUjRKWENrQTNGR1dsSjRTVjM1?=
 =?utf-8?B?TkswVXh2WkhuT3R4YW94dlNCTkF0Nmc1SnlBT3kyaFVneHdSUDh4dXZxQm9x?=
 =?utf-8?B?Mk44dHYwTWJ2NmRxU04wZHRYK0VFQlFpRGZOVElJSlhIdC9KK0RyTHJIcy8w?=
 =?utf-8?B?dGdHNzluZFUycVhNc20vazVSMzR0bjVPSlFjRTlHN1lnenExOVIyRFZnSE1W?=
 =?utf-8?B?UjZLUWVyQy92VWZXaWZqZ1d0K3k1d1puOVI2VTdoeURHbEJhT2tIVnRmdnBL?=
 =?utf-8?B?WUorQ0hvRnlKM3k5T3ZvcFppOC9jQ1NWMUg2NnNLS3Z5ZjlYeDFFKzRQQkQ1?=
 =?utf-8?B?Z1ZNbCtGOGxiSHJReHE5OGc0eFZ6QjVXNGhweU0rUTQzaC9WU2hHY2szbVgy?=
 =?utf-8?B?RXorb1o1Mk51eUhVWnhsWk56ZGtPS3Q4MElRUnZyVDl4VE1rMzRLdkRnWHZZ?=
 =?utf-8?B?aFErWXNhNHU4bzJhUE5Fb21odUpoTjVVSUxUWXhlMXZWYjNiTHp4QUgyMll3?=
 =?utf-8?B?UFNCd0Q3VzFJY0VQZklOdFluSUI0SmRPRTdHM0hSUWdnSm9YeFQyblBTekpV?=
 =?utf-8?B?ZkJVTys1T0EzekRkMHVWL1lpalR5Mnhob1JXSDJVakxZbDd6OURBcktOZ1dE?=
 =?utf-8?B?SCtmTjlvSlR4WTZOUHB0YXpBSlNOcmwzTWJvM0xmQWpqbU1KVWZ2LzYwVnFT?=
 =?utf-8?B?azVQNTlXVnFvVVZwSVBVeEo0U3pMOXgrMHl3WmZLR3pJUlFYaGpXNENNOE1p?=
 =?utf-8?B?WnQ1QWJLUEZFSWhrVjE2UjFFUU1Xck13N0Z3dnNJaFdhWlZZNjJ1ekY0cGpW?=
 =?utf-8?B?aHJDcUhUQktITFphazN3endyTUhjdzBlWnB2d2pOeWFYVDVaV3VKQW5ZUEFW?=
 =?utf-8?B?UUVzN0dJVjdPSnk3VjJQQ3VwSGRiOUt5NHFXYitib1Y5UGRkaEdBRUdoM3pa?=
 =?utf-8?B?WG1BajZnL0dRRHYva0xiZmFqSjlwM2l6YmRwUDU0TFBhTE5pRkpaeWkyNTJ0?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 047d399d-d5f8-4463-cf08-08ddbaf717af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:34:17.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqFEJ1UaJf/itkJJ0p78NSYKI0qV+5CpFnmFzEDElQmoNchNXX/eg6zlCBSY3zwTSLRX9KqKf+xmudVf1j++s1XOYQTaVi5uctmqLrXtRv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
X-OriginatorOrg: intel.com

On Fri, Jul 04, 2025 at 07:37:22AM +0800, Jason Xing wrote:
> On Mon, Jun 2, 2025 at 5:28 PM Eryk Kubanski
> <e.kubanski@partner.samsung.com> wrote:
> >
> > > I'm not sure I understand what's the issue here. If you're using the
> > > same XSK from different CPUs, you should take care of the ordering
> > > yourself on the userspace side?
> >
> > It's not a problem with user-space Completion Queue READER side.
> > Im talking exclusively about kernel-space Completion Queue WRITE side.
> >
> > This problem can occur when multiple sockets are bound to the same
> > umem, device, queue id. In this situation Completion Queue is shared.
> > This means it can be accessed by multiple threads on kernel-side.
> > Any use is indeed protected by spinlock, however any write sequence
> > (Acquire write slot as writer, write to slot, submit write slot to reader)
> > isn't atomic in any way and it's possible to submit not-yet-sent packet
> > descriptors back to user-space as TX completed.
> >
> > Up untill now, all write-back operations had two phases, each phase
> > locks the spinlock and unlocks it:
> > 1) Acquire slot + Write descriptor (increase cached-writer by N + write values)
> > 2) Submit slot to the reader (increase writer by N)
> >
> > Slot submission was solely based on the timing. Let's consider situation,
> > where two different threads issue a syscall for two different AF_XDP sockets
> > that are bound to the same umem, dev, queue-id.
> >
> > AF_XDP setup:
> >
> >                              kernel-space
> >
> >            Write   Read
> >             +--+   +--+
> >             |  |   |  |
> >             |  |   |  |
> >             |  |   |  |
> >  Completion |  |   |  | Fill
> >  Queue      |  |   |  | Queue
> >             |  |   |  |
> >             |  |   |  |
> >             |  |   |  |
> >             |  |   |  |
> >             +--+   +--+
> >             Read   Write
> >                              user-space
> >
> >
> >    +--------+         +--------+
> >    | AF_XDP |         | AF_XDP |
> >    +--------+         +--------+
> >
> >
> >
> >
> >
> > Possible out-of-order scenario:
> >
> >
> >                               writer         cached_writer1                      cached_writer2
> >                                  |                 |                                   |
> >                                  |                 |                                   |
> >                                  |                 |                                   |
> >                                  |                 |                                   |
> >                   +--------------|--------|--------|--------|--------|--------|--------|----------------------------------------------+
> >                   |              |        |        |        |        |        |        |                                              |
> >  Completion Queue |              |        |        |        |        |        |        |                                              |
> >                   |              |        |        |        |        |        |        |                                              |
> >                   +--------------|--------|--------|--------|--------|--------|--------|----------------------------------------------+
> >                                  |                 |                                   |
> >                                  |                 |                                   |
> >                                  |-----------------|                                   |
> >                                   A) T1 syscall    |                                   |
> >                                   writes 2         |                                   |
> >                                   descriptors      |-----------------------------------|
> >                                                     B) T2 syscall writes 4 descriptors
> >
> 
> Hi ALL,
> 
> Since Maciej posted a related patch to fix this issue, it took me a
> little while to trace back to this thread. So here we are.
> 
> >                  Notes:
> >                  1) T1 and T2 AF_XDP sockets are two different sockets,
> >                     __xsk_generic_xmit will obtain two different mutexes.
> >                  2) T1 and T2 can be executed simultaneously, there is no
> >                     critical section whatsoever between them.
> >                  3) T1 and T2 will obtain Completion Queue Lock for acquire + write,
> >                     only slot acquire + write are under lock.
> >                  4) T1 and T2 completion (skb destructor)
> >                     doesn't need to be the same order as A) and B).
> >                  5) What if T1 fails after T2 acquires slots?
> 
> What does it mean by 'fails'. Could you point out the accurate
> function you said?
> 
> >                     cached_writer will be decreased by 2, T2 will
> >                     submit failed descriptors of T1 (they shall be
> >                     retransmitted in next TX).
> >                     Submission of writer will move writer by 4 slots
> >                     2 of these slots have failed T1 values. Last two
> >                     slots of T2 will be missing, descriptor leak.
> 
> I wonder why the leak problem happens? IIUC, in the
> __xsk_generic_xmit() + copy mode, xsk only tries to send the
> descriptor from its own tx ring to the driver, like virtio_net as an
> example. As you said, there are two xsks running in parallel. Why
> could T2 send the descriptors that T1 puts into the completion queue?
> __dev_direct_xmit() only passes the @skb that is built based on the
> addr from per xsk tx ring.

 I admit it is non-trivial case.

Per my understanding before, based on Eryk's example, if T1 failed xmit
and reduced the cached_prod, T2 in its skb destructor would release two T1
umem addresses and two T2 addrs instead of 4 T2 addrs.

Putting this aside though, we had *correct* behavior before xsk
multi-buffer support, we should not let that change make it into kernel in
the first place. Hence my motivation to restore it.$

> 
> Here are some maps related to the process you talked about:
> case 1)
> // T1 writes 2 descs in cq
> [--1--][--2--][-null-][-null-][-null-][-null-][-null-]
>                       |
>                       cached_prod
> 
> // T1 fails because of NETDEV_TX_BUSY, and cq.cached_prod is decreased by 2.
> [-null-][-null-][-null-][-null-][-null-][-null-][-null-]
>      |
>      cached_prod
> 
> // T2 starts to write at the first unused descs
> [--1--][--2--][--3--][--4--][-null-][-null-][-null-]
>                                         |
>                                         cached_prod
> So why can T2 send out the descs belonging to T1? In
> __xsk_generic_xmit(), xsk_cq_reserve_addr_locked() initialises the
> addr of acquired desc so it overwrites the invalid one previously
> owned by T1. The addr is from per xsk tx ring... I'm lost. Could you
> please share the detailed/key functions to shed more lights on this?
> Thanks in advance.

Take another look at Eryk's example. The case he was providing was when t1
produced smaller amount of addrs followed by t2 with bigger count. Then
due to t1 failure, t2 was providing addrs produced by t1.

Your example talks about immediate failure of t1 whereas Eryk talked
about:
1. t1 produces addrs to cq
2. t2 produces addrs to cq
3. t2 starts xmit
4. t1 fails for some reason down in __xsk_generic_xmit()
4a. t1 reduces cached_prod
5. t2 completes, updates global state of cq's producer and exposing addrs
   produced by t1 and misses part of addrs produced by t2

> 
> I know you're not running on the (virtual) nic actually, but I still
> want to know the possibility of the issue with normal end-to-end
> transmission. In the virtio_net driver, __dev_direct_xmit() returns
> BUSY only if the BQL takes effect, so your case might not happen here?
> The reason why I asked is that I have a similar use case with
> virtio_net and I am trying to understand whether it can happen in the
> future.
> 
> Thanks,
> Jason
> 
> 
> >                  6) What if T2 completes before T1? writer will be
> >                     moved by 4 slots. 2 of them are slots filled by T1.
> >                     T2 will complete 2 own slots and 2 slots of T1, It's bad.
> >                     T1 will complete last 2 slots of T2, also bad.
> >
> > This out-of-order completion can effectively cause User-space <-> Kernel-space
> > data race. This patch solves that, by only acquiring cached_writer first and
> > do the completion (sumission (write + increase writer)) after. This is the only
> > way to make that bulletproof for multithreaded access, failures and
> > out-of-order skb completions.
> >
> > > This is definitely a no-go (sk_buff and skb_shared_info space is
> > > precious).
> >
> > Okay so where should I store It? Can you give me some advice?
> >
> > I left that there, because there is every information related to
> > skb desctruction. Additionally this is the only place in skb related
> > code that defines anything related to xsk: metadata, number of descriptors.
> > SKBUFF doesn't. I need to hold this information somewhere, and skbuff or
> > skb_shared_info are the only place I can store it. This need to be invariant
> > across all skb fragments, and be released after skb completes.
> >

