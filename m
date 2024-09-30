Return-Path: <netdev+bounces-130313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF30A98A0C0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A8E1C261A2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB8718E344;
	Mon, 30 Sep 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6k8h/de"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6E47A5C;
	Mon, 30 Sep 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695871; cv=fail; b=Vj0/Bj2RjS5gDmNQkLhV0DSR1Bfg1X/x3bHcemklLIoDaU9EOrrEfQ+rgVzutjQyWB7SeCzW7tUyFbnASohIhqLNUChijX5mTVKMI+qIEinDylmhegMvz4Mqgp5XxrJ+RFPdABfVTjNmg0ZcIItKQS0RQc03DAkaEbL+fcm++0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695871; c=relaxed/simple;
	bh=NpM59PyyK1vYNAr72NXgxwpkHWoYBcCcbryDou5xrAs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TycH0uhjigzLLf9xLtu2HA9GTjOQVTzT3tUSWYpBPxoolutpl0EkxfC4NhtjWhjVFxHvwXruTJyv2V/g1w2KgaQuUnHNJTtMgAssOXoKUJcgWhG7Maw5cgQYWbrJ1JHQ87qlnExbrjQZN5uM8DSbqwWe/D0yNZlMBSRk7BxRGdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6k8h/de; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727695869; x=1759231869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NpM59PyyK1vYNAr72NXgxwpkHWoYBcCcbryDou5xrAs=;
  b=Y6k8h/deo8/ds18akDLOYQXhVi+/iqFqpOemePCK1ljpXQ5sloWsDD8A
   uQSWumA0KEwNnZQsa9PBuxFVCRC6QdRXURXptYcMQ7Fj6GVTvwTXMFObi
   BUGPfpEw6tg2+cSJvO+zzc1j07fgUGHYMVXZgKv+pd6Xj86y/BEbvyp3U
   95nDMvbsAdS+2WmSRskQSIewwvFhE0lDnYAGiQBCRD88jPuMqn07LdcNq
   1/2sXF4eW8kpP2K2IQ1n6AO+On/V5xel2AhMr/tYM4Z3mWvS0dHKJzGiA
   a4H4cA0t743eg/i3llfJtYzbGbhwk5v3dUPw+uqvw9hxpBEvPXV/TaMwr
   A==;
X-CSE-ConnectionGUID: wouVTzD4Ty6CCE7+l014Aw==
X-CSE-MsgGUID: jyZi0dyeScSmDbKt5XLmzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26732134"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26732134"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:31:08 -0700
X-CSE-ConnectionGUID: mWzh5eZiQa6YZDXO0vw4RQ==
X-CSE-MsgGUID: 0Rw5oS7dRAmTobkanGSvUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73394810"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 04:31:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 04:31:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 04:31:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 04:31:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 04:31:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dd7I+4JgrtMk3fK+9dvlpbuO7wjtdhMICWUgqyhZFLI7Qnjg/8H38Of/ts2+VBWgZC04NtmQenc9pyYwkZuWhaIuEkYirXeah8BqLb6E0AzdU6RwusFBsupJEuH74YMQfMOk+MopmOt1zQVm9HZLy0H9nUafL8ciqiWjBCIxnKr4N9t5NPxEBwzb6TrFhXk+Vozs3BThNHIvwxIyAMgHv9qumCg6IVx3d34m/q0CpYkvke8Ra2HAwKdSm7g5BY3mGuZWaGphETUhPExMqw1YlaEzROKfIgHVbl+YNJNHPt8YEZuk5wxurfPIzXjEJILW/QkN3645A+L5hvFMp2+qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOImsKs2faDb/1HcpPr9l7rGQ3GnnjL7NfYYL4tRu7M=;
 b=mNf7HyhHQGjLMH4HUyXJ7ucX95BOvLJxFFP3KDTn/tVrGa94zWSfKVVo6vzjYVFwkrfx6xXxfTwz2OeQdCRZkhrqK4OncSRE4+czmB8MI7AejCqqiX5MJAEyz/W/VWKu6w7t9rxf0lvW6Xn4dbxrSBIW+AQfinoSvDu2hew+owRb5hACup16x9aLiJAd10GD/k5q9CImtlRuD3nPljBlnqQjNlfg4yVQwqxfZNKaqqIaaL6OkMBX+ETAHZuW1CSxoNaytSEqdeJrpmO/Biqq1rDlrgnOjg70SbvOQgU3Uqt5PtGE1CRNKD/QQKizz8fy/9CitvjqQe03Y9lWctq5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 11:31:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 11:31:03 +0000
Message-ID: <e86748a9-6b72-4404-9042-c9b6308a9bc1@intel.com>
Date: Mon, 30 Sep 2024 13:30:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
To: Dan Carpenter <dan.carpenter@linaro.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<amadeuszx.slawinski@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
 <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>
 <faff2ffd-d36b-4655-80dc-35f772748a6c@stanley.mountain>
 <84f41bd3-2e98-4d69-9075-d808faece2ce@intel.com>
 <129309f3-93d6-4926-8af1-b8d5ea995d48@stanley.mountain>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <129309f3-93d6-4926-8af1-b8d5ea995d48@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9efde7-a75a-4e68-ffbe-08dce1435dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blRrUGhPUDJuU3B3cXg0VHYrOHYyYmYzS3haeE5qTkZ2YUZIZUtuYnYrQVdY?=
 =?utf-8?B?Mms5a09IRHV3UTc5MlR1WnY3ZlZWUG9rTGtaZXpMMzBWQ2Fic0hwNGo2QTF0?=
 =?utf-8?B?eWg0UmtaZmpWekJOWEVrUFhrQjhQYlA3YXhDTFpvakVxTCt0QlhzZDA4TXNH?=
 =?utf-8?B?TXlrcjBsaDk5NzlmRjN6d3R2Y0FyOEExWFUwMWxhSFJDT1VIK2k2TW8vc3pU?=
 =?utf-8?B?cmFMK3BEOFJEZGkwN3VMcTFwaTJueHV3b2JsVTlCVVRrSVBOSWJPZ1NwWWdB?=
 =?utf-8?B?ampmeFpjVXBjamwrUVUrQUdLbjBhMFh1dTVRajhicHkrQ1hwSUlGSG1PNnZR?=
 =?utf-8?B?eFA2eG5saWQvc3NTL1J0b1NwZVZVd08xcGZRN0FkZ0tIb2VuTHhVL1Z3eGtW?=
 =?utf-8?B?QjM1UUVwQkh0TnJqL2lWekpXZ25zUlJBT2pkbWxISWhjcm9EZU9uS1hUaVB0?=
 =?utf-8?B?bFNiSmhiT0xOdXNUVXloZWFONGJuU1hseW1PNTZPWkNjVGdiWVRyVlcxMkl3?=
 =?utf-8?B?WXdpOTdMd2hKZ2RqVW5Vc3lKRDVsbFdScTZHcG9udmpnOTc0bk42c2J1a2t1?=
 =?utf-8?B?WXRhUW4wMTFXSjg2RDJ1R1hHU21SdldHdDZJY1o5Y2hwOE1QTFZmR2cxMmtG?=
 =?utf-8?B?cWs0M2d3aWo5L0x0Mm4xc3Y5NUVUTWl3VTRMNENaNys1ZHBoZnBVWW5wSkpH?=
 =?utf-8?B?dVBUbUhBcm05a2d2K0Y5TVpPYjNkVnhDNURiUm5tcFAwTzc2dGZxd1FCMlVy?=
 =?utf-8?B?TVNZVWVCR0s2Q0MzZHkvTWJtbFU0WktkdjlBdUxVcDhWRjRxT1NxemR4SGxP?=
 =?utf-8?B?WktmcldGSTdNZzlmck44NUpoYmxtR3FodXQwWEJDTDJFMTlUWnNObmxadzFl?=
 =?utf-8?B?Vk1VQXZWc3Mvd25OMlQrdDJJQXA4dmdOTzlqMnpJWHR5ZDV4T3htQnpGRlVF?=
 =?utf-8?B?VzdhSVJEdlR3MUFxMkJPOW8vM0Nhc29kbG4zQVFHK0FaZE1ib0Z6TndQcnhj?=
 =?utf-8?B?OEdRbWsxTXhFa1psa3BkSkdtdHJNNHloUWUrOHlrQ2sxcWo4a29UQ29ZWW1q?=
 =?utf-8?B?V2kxNUdaRzBjT2lpR2lDYXRFblQvdkdrenFmcGZQaW81azQzTFQyT3RVM3hv?=
 =?utf-8?B?ekw5a1dQYVRzZDBtY0s3V2FGSm1iL0ZhcFRGSFM4UXcrVkhRSzNja05FZEd4?=
 =?utf-8?B?cmp6czJySEZsUTBhN21YQ2ozL3Vxa1JhNk5DVXRmUC8rR1RpUEpOZ0NYc0lz?=
 =?utf-8?B?d1BuUVFjendpamlrQldCWTY3UHp3ckIrS1JEUnloeHlYZzJCNCt1bzBxcHk5?=
 =?utf-8?B?dEtIMHNKQXg0ckcvZTZJYVg3Q3ErWUNLRmN5RDVDampSUDRRT05CbnVDM2JO?=
 =?utf-8?B?ZkpaN3NHazh4L3l2bG5Cc0M2VER2RThsMTg3M2xtUVI2a2VJNE95QU1RVElD?=
 =?utf-8?B?aTBuRFAwMEtRQkJ0K3h2RHNIYjRWL3JkS1dacHE3bERBMEVkQUtmQ2FjNlgr?=
 =?utf-8?B?VSt4VVAyVVZqbHp1cWF1c0JOOE9IOGdKV3F5Rys5TUczLy9JdDk4M1lKWldw?=
 =?utf-8?B?L0llRFRrUWRrYjlScTRCK1h4MHVnOWtJa2diTGdXNCtLRTdPNkZ1cUNoRmFB?=
 =?utf-8?B?Nmo0dWs5NmNwOUdHYjJiR2VPYk1VSTE1dFZlSWRYR2FPT2tQOUJZcGNQLzZQ?=
 =?utf-8?B?QXVkdXZoTGZac3pPM0U0SGxXRkpsZVRsR25UTDZDdkJnRVBMK2hkdmFWQXJ4?=
 =?utf-8?B?dCtXeTdrR1daMEJ4czYrTnZpOU50U2dGMUoyM2E1eC9IQzV2ZWlFdFNzWHRZ?=
 =?utf-8?B?SXo1UzhqNjhsTjU0dEkxZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9tQUpNZks1UGwxQ3NUSW94UU9Uc05kYWhOYTBxK0VDMWlUZVVHUENzVTRF?=
 =?utf-8?B?NVROMWZ5ZXBvcy8yYXdNajcrcmNzMDA0RmdZZWtqVUtlYmswcTF0M0JKNWk2?=
 =?utf-8?B?ZWo5WHpOVVJjWEZCM1pBWXhKZ0VSYVNXbDVLN0ZmL2FGalF1RnBHUkY1NE1l?=
 =?utf-8?B?ODVFRUNhY3hpSTJVRFNucFluL2pSd2RDVUJRM0VVY2JERCtEQVBTbjBXT2Fr?=
 =?utf-8?B?M21ZcERyVlNETytaV0hIdk16OUJ0d0JjV0xVZVNwQUZOYU53ZVQ5L0RzUDNr?=
 =?utf-8?B?Si9MeldUMzd5UVkvZ3QweCtUNEFYL3VKOEhmd2JKeEdjSmVPZ09aY3dFbzRQ?=
 =?utf-8?B?Y1hLZWZxeTZQU2U1RnVkQTQycnBXVC9oVVVLMUFZanJsaHIyV2pnNWJwOUt5?=
 =?utf-8?B?RzlxT3BXYVcwK1NGdXFPK3ZNNWJVRmw0bm8zS0pYK3ZPUkM4VHBlcVg2OXFO?=
 =?utf-8?B?OTZsZjZYY0Vsc2xoNzI1ZldrL3EzRGRKL1llZGdNT2l1bGt4czJsQlQxU1Fr?=
 =?utf-8?B?Y1RvV3lwc0IwUGZUWmpYMzNYZ282Z0tOYzVkdlNxdGJucEticWM4WG53bTFC?=
 =?utf-8?B?WDAxK3NEWkJVblRVNHBIbEM2bHo0MG5jVkNDYmVIcS9GN1Z3YUsyR01qaWFL?=
 =?utf-8?B?STJ4Qmg5S3BIa3JkMFk3ZFJ4Y3FEVEFwS21QMjJIT0pBTDkrMHJpc29WUUxV?=
 =?utf-8?B?OTlINmNnSzQ4citBVE1LSUFmZGlhQWRFaUVDbzFweWRyTDdQclNMcmhtbzE1?=
 =?utf-8?B?cHR0NUJlVG1lclh6ckdSK1NpcFgzbjJQcEFYUUF2ZVA0T2NhTk5IblBBNktW?=
 =?utf-8?B?RGk0V0ltZmphSklIR1VsbjFpM2d5dEJTL0ppK3l4VExVa1RLY2xzeFduYmkr?=
 =?utf-8?B?V01YRm53Y0lvSE42S0o3bGhTN2RhUmpONjNJS0RYcmx3NU5IbmN1alUxamlF?=
 =?utf-8?B?UXk5US93T2dPaFYrcnR1MGNsZlRtYlhBcGJTL1VDNVhkMjFXNHJSRjE2ajdz?=
 =?utf-8?B?V0hSc3FBc0dCM1lOdkp0dDBqZGtoMGl6R2c1RUJHbXdHeTlUTnBkblB4UHN2?=
 =?utf-8?B?dVAwK1BPTjA5OXVBRDV1L1dJajVlUTlUajhwMzc1TzFSRXF6MTE5ajRsZHM4?=
 =?utf-8?B?Zm1hZ0dUT2lDdEVMQkdhL2hTNWdlR256eXlYdzkyWEdaek44VXh6b1dWOUR0?=
 =?utf-8?B?NjBXQlY3djRkS1NuaCtYUXlxcVJtQ0M2ZmZIZTJrVkJpSkxIWFVNSU03eWd4?=
 =?utf-8?B?dGZyUTBYTjMyOGpyMmE2U1FmV0tMZXNZYWIzVzBuT0pjUXBvWlhHV05BNE5W?=
 =?utf-8?B?SFNyZDhFbCtQWXNlQ0tEOEtaWHU5WVBCVXhabk5TZGtFMlE1eEdxRnNJdmZD?=
 =?utf-8?B?bmh4Sk9zMWN6eS9EL21SWnlZQmN1QVF2dkFPRlk5TWZDdUs5M21IYmpVeWFp?=
 =?utf-8?B?S2ZPV3lJenM2WFo1a3ZtNUxlTmNUVkNuYmtKb2k1aXRab1ViT24xeSt5bzcz?=
 =?utf-8?B?TG9FSmNmRkdoSHRLVkNneGozSWtLZ0tuODRnOHhVSFF0QW9yR3VLVHhHM2lh?=
 =?utf-8?B?am94SGJpL2U2VS9LV0RJTnZEbjdyRkY2QnBNd1d3ajRBNUhtbzlQYlYvaGEw?=
 =?utf-8?B?MWM4bEVUcnAxK2FYWEQxcHcvQUxnK0c5akVTL0NzY3NDZXFraHRqVXEyQ21N?=
 =?utf-8?B?OEQ4YitEYVFNa0lPa2RDRktrZk0rcTQyd3o4OE0zUDJ0d21JcDhYN3d0SWxG?=
 =?utf-8?B?ZmtTaXU5cm56K1hQM0JYc0xwSXp4aGNXU24rWDFOL2dNQ1N6R095NUhXUDFX?=
 =?utf-8?B?bi9PQ1lWa2pUUVFueUJmSEY4WCtsdXh3ME5vNmQvalFkV3dHaDlZYVlSRVVL?=
 =?utf-8?B?UytFVlAwbUdQV3BrdllBRXZRc0ZZU2k1STBEZVZmQTdlQm5iQ0xqQWtBL29n?=
 =?utf-8?B?REFFL0pNeVVRcGFJc1oxRm5tbHFNc2RHcHRhR0FkWkNOdWFnYkF5eUZtb3Nv?=
 =?utf-8?B?MWpkQ1p5U3c5bUdoa0ErSm91V0JnSkxXVlRZZGt2Wkt4OVovbStDVWJjaDRQ?=
 =?utf-8?B?Vk5xc0haNjQxbG5DTjZ6WjZ0RzdqSmZZKzBTc3lVRkllUWxhTGhQK0hBMlpB?=
 =?utf-8?B?cmhvOERBaFE4b21SVm4zU2d1S3BwdUdWWityR3lROTZXT2JLSUt4RU9wcm1s?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9efde7-a75a-4e68-ffbe-08dce1435dd7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 11:31:03.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywtT9cpoX5AxZlAsvPeuk2rEWEf+3Mtfrt4fsB9+hetI2x5M5PP9HkIw31tug7E2CMmPcosOUdIqa9I+M2zbwdO7EkW5vgE0EdaUW6b5vQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com

On 9/30/24 13:08, Dan Carpenter wrote:
> On Mon, Sep 30, 2024 at 12:21:44PM +0200, Przemek Kitszel wrote:
>>
>> Most of the time it is just easier to bend your driver than change or
>> extend the core of the kernel.
>>
>> There is actually scoped_cond_guard() which is a trylock variant.
>>
>> scoped_guard(mutex_try, &ts->mutex) you have found is semantically
>> wrong and must be fixed.
> 
> What?  I'm so puzzled by this conversation.

there are two variants of scoped_guard() and you have found a place
where the wrong one is used

> 
> Anyway, I don't have a problem with your goal, but your macro is wrong and will
> need to be re-written.  You will need to update any drivers which use the
> scoped_guard() for try locks.  I don't care how you do that.  Use
> scoped_cond_guard() if you want or invent a new macro.  But that work always
> falls on the person changing the API.  Plus, it's only the one tsc200x-core.c
> driver so I don't understand why you're making a big deal about it.

apologies for upsetting you
I will send next iteration of this series with additional patches fixing
current code (thanks you for finding it for me in this case!)

I didn't said so in prev mail to leave you an option to send the fix for
the usage bug you have reported, just confirmed it. But by all means I'm
happy to fix current code myself.

> but your macro is wrong and will need to be re-written

could you please elaborate here?

