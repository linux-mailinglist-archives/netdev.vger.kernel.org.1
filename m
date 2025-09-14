Return-Path: <netdev+bounces-222852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F92B56AAE
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77014177F91
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282261B4141;
	Sun, 14 Sep 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1JNXbwD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BEE17C21B
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757868506; cv=fail; b=kJ+D3HrI10ZZcORgIU2Pgp5NWVW03smKY10PoAVMgsNm9d+oFqSlSY10ZznMq5CRO3V0NwOF/yhEtCewwbhbiVM4iTklS0C1o2r9B56i0u5yrB/Uyk+vyqKJuELw6rxIFbLZhH7BkxxbQcfNKOUp7/64vAxgDZmenn/hrn+6xBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757868506; c=relaxed/simple;
	bh=j7D4gBNLLMS8X3g9FopfJiR6GUC7ZE8qC9Lv8jr9yKk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fr1eAsVYcGRfQGCaHdNW6WrftdbHHguKsGTMn/k5PSX7j83fY8epxEZ+tm4IF8CMxRuAVjxFWI3GaDtC3XVNSOu133fcY09lZwuIXIjipLV8oBqxhdyY6zH0MTn5zJLqJ06oDFITdnKQe7DiMK5BlaFaRH2+G4BUMHpIE4hSrCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1JNXbwD; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757868504; x=1789404504;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j7D4gBNLLMS8X3g9FopfJiR6GUC7ZE8qC9Lv8jr9yKk=;
  b=V1JNXbwDSZNDsBbBFu13ssDA4+9jJG9jHEHSJVKZXzFMfEoWxdXUpKns
   cFUouRyhivkUoOZ65L1t/CDMDXwHLMrfBxGFfhKt2cNqJOCS2OrJpJV/Q
   msI2bBwir/jn729jgI+focpzapgSKHdT9TVlN3MvqKzyAvU6GPTsZuVJ/
   KYL5IzLOe1ujkFiCp3JdUCdu7yMI6q5TzEXQoiqGFJI0381Iqqv9BgCyH
   HNYq0f7bCe7565PrFbioTlNkTOdJCdExb3djTl8o+J6Evv6UDmvRw6Hw1
   kWUpah6HIwgkSvTypIWz6u20uIiR+DF1bhjR4LMajkNNj4PNq3JlFHkqB
   g==;
X-CSE-ConnectionGUID: CCqQt7bXRmODdeLV9IrB0A==
X-CSE-MsgGUID: HAH7IDOQSd20WSetHno8Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="63958085"
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="63958085"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 09:48:22 -0700
X-CSE-ConnectionGUID: eSonNlqbQ3Wmb1dxfEtEJA==
X-CSE-MsgGUID: lVk0GpXVT1abIAp8mbf43g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="173972318"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 09:48:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 09:48:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 14 Sep 2025 09:48:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.79)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 14 Sep 2025 09:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8aTLy/FDsaWUT1P86u3R/HWrVFRluJAtrrqlfEXrpRoBOXoJxY3lwGB7kusDr4p0gaNTF/OnQyjtLn+RkPMBkBzRQfRamksYAjAsEBMI9DMEhn4eVtOt9vSsHlw4U3HwrxdVbjKaJyOeIc+155hMqCYhszwjGbwdDkM7CWL5VjjKxJGHl7SnShGBtwPx+1fXHYRZBX2051yQSjX6zB+NeT7Ykc74/YnSnrrAjby4bMJse73OVLymdqtvNoKwDICmm3KS5gPvVfCsPzRStZD6uMK/cpt/xriCtix5EG7kHq0u55NT6RTBjDBbohGHQL91L3+Eer9zoP2IY4y7JIMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLANRIvwTcMfjb4fw2H+X/5vtJaiwLUFZvu9OVsTO7I=;
 b=i5fcXh0naE6VUugG0pwKptYfOvxT3WtHixLXSo1zKoRIojvrP8isM+f6KvZNPMcttALO8rqvjG6M/E9XilC/Fu1xb022vyaYi+RYQDm/5GRrxem9PYoBGc/uYT2UeRB93e06x7Y0hzsfYpJ8dIw/UTfVO2ks2gZj2YQkyWq4wxTEbizijx/hhhTESIp/hFKkkEYYqb2WXnxV8+9q6SjxSQvq8W1TFORuwl3KjxAhGQEfsUEetRQMFS7cCWTCXL/y8EmVfR3niZGXnu8qNKVzuLyLSyRhji1YHklUdlzbDOeOuu0GH8DZr9JQRewlwJABKtaqabV/AsYS+Zp0oNy7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by DS7PR11MB6270.namprd11.prod.outlook.com (2603:10b6:8:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sun, 14 Sep
 2025 16:48:18 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%4]) with mapi id 15.20.9115.020; Sun, 14 Sep 2025
 16:48:18 +0000
Message-ID: <808db8a8-6f4f-427e-b8c6-e4e34e2e30d8@intel.com>
Date: Sun, 14 Sep 2025 19:48:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net] igc: don't fail igc_probe()
 on LED setup error
To: Kohei Enju <enjuk@amazon.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>, <kohei.enju@gmail.com>
References: <20250910134745.17124-1-enjuk@amazon.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250910134745.17124-1-enjuk@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|DS7PR11MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1cf091-e920-481e-8e58-08ddf3ae8188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amE5cy9lNE92OFBjK3RvM3JKQURmeXUxckhQV1VzMSs0cU9SOTNYOUhzaHU5?=
 =?utf-8?B?eTRkM2FtVkdISXROZkV3K0ZyYkVnekNPUFdyRFRBWnl6VU1ja2JlT3pVTko1?=
 =?utf-8?B?Y3drV0thWnJiWVFYR2NuakR5N3BpUTdJaGdWYVc0VkdWNkdrUHY5dmtRYmd3?=
 =?utf-8?B?Si9SajdTOWUybmdOOXBDNjdFNHkwQTBlK2xrNDNwNXh1eFVQQjBCbFMwb0VD?=
 =?utf-8?B?RXcyV2Q1RkRVeGx6enJJaDFyNStmems0cGdsSjJmRnRjVVhmTGVCVlN3U3lP?=
 =?utf-8?B?U1NnaVJSNjg5VG1rY0kxa293czRUeEZ0TDFCUGlBWjFEaWxqU2RWakRyR1Ro?=
 =?utf-8?B?VGhXaUUzTStZdEl5bTdvT1Z4b2tqa1pNRHlNdGNZWXBXSnVBMXhOd0JyTzkr?=
 =?utf-8?B?QnEyVGdkeFRaUCtXV2FLeHBCM1NCTGtSaHhCV0dCeFJoMEhVWFJobmlIYmlL?=
 =?utf-8?B?SlduTGthWGZaKzJLVGRoQm84OWhsUUtRdDlhVWdJWW0wZGdzekd2Q3lxWE9r?=
 =?utf-8?B?SUdUNjBUeTROUkhNVHpGbWlVSWdoeHlKZDBOM1B2eUIwcEgrWVk5MDNhMUh1?=
 =?utf-8?B?TEZvQWZkbTFwamw5SzU1b3V3ZjN2SXN6bFpEaUFiZVJzN0JzNDlsVERSTVU3?=
 =?utf-8?B?RDlESENDZm5oMXBtakVmbnhOMG5oc0JVUVYwVk4wSllSWi9RZzM1QkJPazh1?=
 =?utf-8?B?eTdTdVMxQzYxWmJYMG5yVjBnVzNNY1RlNFVWZUhkbVZxMU9BZ21kRnBEODBC?=
 =?utf-8?B?MWkva1gySHpIdjlVcGpySEd1MWVKYU9UaWlONWtTTEtyMXN2MmdZMWV6OThT?=
 =?utf-8?B?TjJXMjZDcHFrS1d6TlU3MjEveURpNGJYdU9TUlE3MVVqZG0zKy82ZFVaaXA2?=
 =?utf-8?B?TzF2TWpIVnVjUWJSY0lFQ29iQ3NwM3lLbmlFemsvR0N5cmJEWlp4QU5LZnIz?=
 =?utf-8?B?ajZHTC9lM0IwZWhERmEzRlp5R1hUdGRBbTlNWkQxU2F6TXppeCtNeGdBUE9Q?=
 =?utf-8?B?SEIzL0ttbWZ3b0l2ZVNsWWZpZVlTQVdIYXNObkwrb3RPd00xMkthYnpJMy82?=
 =?utf-8?B?TGwvZ3c0ejI0MFRpMDVkMEFBL0dNalV0M2lyUG5NOVdjeFM1ZUhmeURseDNi?=
 =?utf-8?B?QWI3U1dBQWFnOE1TSXpzVXE0UU5tVmpsMGFKa1RCdTYrMjBCekJ0b3Q0WDlM?=
 =?utf-8?B?OVlVK0tFRXcwR290MDNvbEFRY2d4WFRVR0pMYnBCWitITmVLS1JvREpwRnJT?=
 =?utf-8?B?MWhkbFc5aCtuQnJaZDRRWmphRmpOVGFUcnNOdGxOdXdvc29jMVdKN3I1Mko2?=
 =?utf-8?B?U3B0ZVpMa1RSNFFnQ2Z5dFp6Z1V1R29XZERVS0JkZ1lVTEpjcVhZWm8vMUtE?=
 =?utf-8?B?N0lmanJxaExLS1pZR09GK1VaaE8rVjNrOEptWXc5WWlzV0ZVUWlSVWFvOSs2?=
 =?utf-8?B?RkJYT0xzd3NmZXUyR2orRzVzMUVhVTk3eWxGdlpSd2hNaW1NdWUvLzNjSXFr?=
 =?utf-8?B?SVUwQTkyL1JWNmRmb1h5cGtTSEh0QnUwMm1sT1BtSjl3dWhBNTlLWlFPdjg2?=
 =?utf-8?B?MSt0c0VNb3A2NGx4Vlo4ekk2QlFGY2gvYi96TkVmUmFMNmFEOEJTU3puRzlx?=
 =?utf-8?B?K1ZKTXVXeGhtTTRFTVFVTTdkY25aMG1kUVA2WGFaK3VmRkdLbkFDWWVQSFNV?=
 =?utf-8?B?YkQwMG12Q2gwTDcrcm9nL3MwOGd4NFR0UTR5N0o4djZJaFQzWkMwUkFtajAr?=
 =?utf-8?B?SjJpMytrUGdDZk82TEJKYXVKeHVINkpVTkJ2aXh3Qk9laXdsQ09yWk1MN2hh?=
 =?utf-8?B?b1ExMzBkWWZkMTdCbjVSNVUyendKWVhzSTdjVE02cUdMc3hESk1KamQ5enZW?=
 =?utf-8?B?UllLZFlVUGs1UDZZNUhYYWMyUkIwSnVuMDdGaFZLUVZBc3JHSjUzNkprV0Fj?=
 =?utf-8?Q?5MqB1Dla18g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3BLOEh3TmVSMEZOZENVQmt6MkxqZFpwdERnclpkdVg4alI5UXFTZEVlaDIw?=
 =?utf-8?B?TVYxYXFqYW55ZXIvVGx6Tm1IRTlIQm1XVU1ZSVJTQjBWTGIrTmdMaitRZFRG?=
 =?utf-8?B?RHc4WXFFc2tJeThWUGpWckdlQU9pdG9ob2huVlAycXpNdTlKemdaWEtGTEdM?=
 =?utf-8?B?V2JnbTIrMGNBaEtZb094aUR0SlJrWWpWckhQbjRHWVVDSVhLYTM2aEdVRFNV?=
 =?utf-8?B?MituZzZXaEVHSzlkdGYzbUNJeEhCYTU1NmQrUU1vc3JJR0gyTlBSaVRXemw2?=
 =?utf-8?B?VW41ZGZEL0YrT3lzQ3hrZXNwRW9QaVdzcUc5bzlmWkRTcFN3SzQwcDh2NWR3?=
 =?utf-8?B?enRJN0JTSlJDV05xT3psZXdUdTJDWFdTOHZJNDhRaG1pNmR2WG9lMTg5b0dt?=
 =?utf-8?B?ZlM0eDRhNFloMHpTblJSSU5jNzdvZytnUEUxVWhXUTJrQmRkdGlvblpjQ2Rx?=
 =?utf-8?B?N24ybFZnT3o1R2VmTHhWTjNFOUdsOTJldm9QMWJGd2Z3MUx0S0FxVG8xbDRq?=
 =?utf-8?B?dFFPZ1pRMGw0enpxS0phcEtBK2g2WVRlMWdQaEI1NFdHZHhDSjUrOSt3RE1I?=
 =?utf-8?B?UkdqOU5JMTN1ci8rQ0RQbm0wbEwwKzc4bVJ4UjhUZ3RLaENBeTlMamdFRDU0?=
 =?utf-8?B?dFg2TExpdnl5aFdnQWpMQndKVzFldDZkN0J6YVVSdGg0bEdWS0VnTndIZzBh?=
 =?utf-8?B?cW55NE5zdWFNWkNYVk1KUCtwZUkxWlZYZjA5Rnh5RUMwdW0zajJMb043OCsz?=
 =?utf-8?B?ZmtEYmI2WlE0ckZNTm9YL0o0b0JUSm80cGRiUjJMSSswaVJvR05iRWowdmJM?=
 =?utf-8?B?ZC9UMlVzbUJFZFRaVWxndnlQY3ZQa09GYU5qdzZlVFMzb1ZndDlOZzRhaENa?=
 =?utf-8?B?TlgvUThlazk0UDh3QUNkUkVPbG9yRWd5SEFZQTJ2RzVyYWc1L2VZY2xxV0Qz?=
 =?utf-8?B?RWRsT0MxeEZOYjB6NlRzZWFRRmtxREFsODFqZmpxekhHUnZmTnVCZFFnNzBU?=
 =?utf-8?B?bXNWZSs2cE1KZEk5ajNIRVlVVEg1S2VBR1pBQUlMRXd2eDhXcnVoNGhKSU92?=
 =?utf-8?B?TDl3TE5GUGZpaEhta3kvUngyZmtMVk1GQkQ0cHhFd2VSeG5yQmZ6YmlXbVh2?=
 =?utf-8?B?N28rTVp4UEtXVStJQ1lubG9CN3R6SVRNd2UxNmRMMGVpeU1KSnRRVlJUMG1a?=
 =?utf-8?B?N0dvLzNuMzRoQ29sQmhsaklsbXgxS1FwS1NlS1djMXZzMlo1SXc5NDFHemw0?=
 =?utf-8?B?SFRsM0FzNlViYzBDMlRZTk5mRXFveDhUeWF1eVBycFJSajZyd3RZZ21POFBh?=
 =?utf-8?B?UnRIR2h4dCtJVTBlUU1OcnYyUUJTeW84Y1BEUHFEdFNrNHVyV3JiVEpUS2xi?=
 =?utf-8?B?OEhyMmVOajkyV1ljYUlqYmJ3VkhubVltTXF0MkxKRTZ6VldHZmZRUk9LZFpv?=
 =?utf-8?B?NTlldENIVVk4NzE4N0luRlFzdTZZMENEMld5ZHB3dkhKYWFpTXRPZnZnZTl3?=
 =?utf-8?B?UzU2MUdBWDVaczZma2l6Rk51K1F1ZnVPdGxRSmhFSmVzMXM2VmdnSjJ0WVNS?=
 =?utf-8?B?Q1BiTm5xOTYvTlA0QTRxVjJRL1hUSFhneGxtV2VBSlMraXh3N0FNQk1MbW9s?=
 =?utf-8?B?T3Q5bFdmSjdPOVpvT0ZOdnNUclY4TEVBWjBwWXloYk1IS1k0bGkwaGVsWnJW?=
 =?utf-8?B?cVF2amp0a3dSU0NsN285TnF6Q01wWUc2MnVLMHNlSytuYUdqU3BvK1RoTEQv?=
 =?utf-8?B?cVlvTG1tdFg5NmtBYWZyQnpVdUlGbEgydE9Dc2xCUVlGdUJ2RVJtc3hmc0g1?=
 =?utf-8?B?RitPRmg1QUgvaDJQK0d5ZzBBRDV5RU11N2MzdjZlUVcxQStxVnV2QURmazJj?=
 =?utf-8?B?QkhER0pVaG1sT1FScVRYallIMWhvSWlxTDRHbjVpSkQ3Y0VyT2hGVnhoMlk1?=
 =?utf-8?B?cWw3ZUFRdWF6YmFjMWdWTXd0WkxoMjgvOGNMc3lqTFY5L1BTUGxraTJtdS85?=
 =?utf-8?B?ajRzNEFyREUvM3BpK2d2MzJFVHJ0aDlXL3hKNk4xaWd2QmtKVEdDT1JwcTRz?=
 =?utf-8?B?K0FaZWw1TDZ4QWt1ZWpVN0VmL1ZEMmxPanpFWTNWTjdIV2ZTNGxDTmtaZmZQ?=
 =?utf-8?B?Q1hGVXI1R3hPTTdrSU5JN3BNcnZBNVVUa3Z5Ym5tMFpBelI0U3JubktTT2RX?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1cf091-e920-481e-8e58-08ddf3ae8188
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 16:48:18.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs44LHb4cuxGeeh4I+RzaX667OiXdMdFlMAttanR3hF72FTX79Vrt82qGxpZ+mEusuW98NlRYi1/feEZdqM3HBEVSpvwqpijtI/wn2Oh2Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6270
X-OriginatorOrg: intel.com

On 10/09/2025 16:47, Kohei Enju wrote:
> When igc_led_setup() fails, igc_probe() fails and triggers kernel panic
> in free_netdev() since unregister_netdev() is not called. [1]
> This behavior can be tested using fault-injection framework, especially
> the failslab feature. [2]
> 
> Since LED support is not mandatory, treat LED setup failures as
> non-fatal and continue probe with a warning message, consequently
> avoiding the kernel panic.
> 
> [1]
>   kernel BUG at net/core/dev.c:12047!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   RIP: 0010:free_netdev+0x278/0x2b0
>   [...]
>   Call Trace:
>    <TASK>
>    igc_probe+0x370/0x910
>    local_pci_probe+0x3a/0x80
>    pci_device_probe+0xd1/0x200
>   [...]
> 
> [2]
>   #!/bin/bash -ex
> 
>   FAILSLAB_PATH=/sys/kernel/debug/failslab/
>   DEVICE=0000:00:05.0
>   START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
>           | awk '{printf("0x%s", $1)}')
>   END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))
> 
>   echo $START_ADDR > $FAILSLAB_PATH/require-start
>   echo $END_ADDR > $FAILSLAB_PATH/require-end
>   echo 1 > $FAILSLAB_PATH/times
>   echo 100 > $FAILSLAB_PATH/probability
>   echo N > $FAILSLAB_PATH/ignore-gfp-wait
> 
>   echo $DEVICE > /sys/bus/pci/drivers/igc/bind
> 
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes:
>    v1->v2:
>      - don't fail probe when led setup fails
>      - rephrase subject and commit message
>    v1: https://lore.kernel.org/intel-wired-lan/20250906055239.29396-1-enjuk@amazon.com/
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  1 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

