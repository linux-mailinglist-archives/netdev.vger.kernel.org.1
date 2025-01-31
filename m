Return-Path: <netdev+bounces-161770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C0FA23E04
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 13:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930D4164734
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5751C174E;
	Fri, 31 Jan 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6opQLI+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A581DFF0;
	Fri, 31 Jan 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328172; cv=fail; b=jegjqq0LqbqFJAw6jFF3QKf6oQEqOLy54G4sULbeS3NiMTtZFg69jtQi5R0QJ3BBEasxAs3NSFmeCNgadHZweK6fFgNyD7y4DHULVcS7rwMUrEGrZEiowgnV+pq+svJtYY9iBHzEC9GFezhHyfchMWbnM2rltYdQhGfwgq5hWS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328172; c=relaxed/simple;
	bh=UM4pVhPJnDSkX9SyfVwsL0KnVAdL7o/ibzW3beAsEHs=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=ejIV3dd0oXqg0Qfjw1Db8ESolGdVgVnIerzKtcFtjzs+Gw/ZZnfF2AG8N6G1dwFRRh5fi4hRyIWCULGfkHGtm+i7yI+gzwsrqrJzAZ3KH+6HkF8CIENyYrzUtso+xxB3mMCjU0PE22VvKF92vuogNppMS2VH9qPNrOYZUK4GRFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6opQLI+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738328171; x=1769864171;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UM4pVhPJnDSkX9SyfVwsL0KnVAdL7o/ibzW3beAsEHs=;
  b=O6opQLI+pzwG4oFc2ls2JYJRQXAvMivJxMlGZ4Q/mFI7DVpkFOOtJZIE
   Wc+IwdnVz80tVHRlpWt4S+Cm3qqCQFZhYjMw6uiNnFQVU/UzgaiV6qvls
   fqDGDaZgRZrzpzf5a6xSmFyP9pN4G5OWPiWhBtdicwpbEcZB6I9PvslMt
   0m1wuRYAoYrZcWO8+7tTcKMqIohV0WHWq65R6UxjZjHbvrU6S+a0OvG06
   ob6Eg2sh4KqhuxWkZ43tJRwPjF3AlR4iwbnlnoVH+Jr2pDHE8kPeu1Id9
   HyotE71FZEzMMZ3EAoU0RL+ScQLRPKXYbnux2oj7Amt2FcLzisNJJal4Y
   Q==;
X-CSE-ConnectionGUID: vcqUAUZ/R7K1LtxUNr/TWA==
X-CSE-MsgGUID: fF3S58ilQqa8XlffIabTAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="41727853"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="41727853"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 04:56:10 -0800
X-CSE-ConnectionGUID: PqiO7ZoqTleaWzwNBuKAVw==
X-CSE-MsgGUID: cHm5sGRwT1qkvNGJYc08Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114772898"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2025 04:56:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 04:56:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 04:56:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 04:56:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNmt26AQDWTLnI6pWqvyMQfXb4iA0gbm+1v3Ytgpw2qDjFxzg6dJm2szeTIXmL5HvLzWJpWus7AgVWn3PUvz2t4UnJzrWxCTkB1tolwMV6ASguQa2w6xv15QfOoxLICxR87arB69SWegu+851lllWmsvo2gH/EeNlI2LPKjFWKnv/lzMoLsPExxObI850wumcGRBvWiyecEekUy1m6llM4eE2DahJH/XgAAkRrQYDfUGBY7wTYxhG7l+zw85xyT0MR4X5tSUJc/vdHwmLd7tPS9J0XuZhzYc2nd/YbvyMsOhBX5E7v8kRvjLntqRYnTNqidaD7QZNVuFRH6+YEsRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqfMMZAoghx9GoRC6oFyrQ3Rsb+KdD5acgz8/qmceMs=;
 b=peeixDj/Wge8ZYSpWafV8Kt+D0mwxlQs6WaggbwxcSYRzLHkSZbBeU3UVKkeiOiK5apNQ/gxrgjPP6xdkVzclnSlrXevIpw86T6s0/Z5WFN9vWCCKsA0GA7pzMyUqPN8XBEy2hfsag8Ftqs1YxfGROk4/UAw0Q2B7Mr2I2nhTmte4xk/bwgB6XZWWPb+Q3bjGn02lVZKg77NpmEwD612yP2oC+C/FFXZyIBoJCUGcgCkUQd6RBG1uNTmOqgdS1eC+ZJHvIf5NzIaYRTMQMIGlsRzBKlfzRT9NI2KbjjiKA8+6jPEBMJ8NQJBB+x1/8zi5oMeOiuU6XxthzrnHC7Gjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 12:56:07 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 12:56:07 +0000
Message-ID: <769c50c5-51ac-42d1-9c8e-97783a621a0e@intel.com>
Date: Fri, 31 Jan 2025 13:56:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2] tg3: Disable tg3 PCIe AER on system reboot
To: Lenny Szubowicz <lszubowi@redhat.com>, <pavan.chebbi@broadcom.com>,
	<mchan@broadcom.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<george.shuklin@gmail.com>, <andrea.fois@eventsense.it>
References: <20241129203640.54492-1-lszubowi@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yue Zhao
	<yue.zhao@shopee.com>, <chunguang.xu@shopee.com>, <haifeng.xu@shopee.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20241129203640.54492-1-lszubowi@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0092.eurprd04.prod.outlook.com
 (2603:10a6:803:64::27) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b936347-ca81-4ddd-186b-08dd41f6a0b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTlnWXNXYjEwSjBjRlA0QnppUTFET05TL1hINWpWYmo3RG9QV25aMkg5UXFO?=
 =?utf-8?B?eUtZdGhDOGpWemp3ZHlScHVCaSt3YWdxUkFEcWFyK3pMeUR5aFdJNXptcHBs?=
 =?utf-8?B?OEZ2S2JmY2lNUUk4TGVyNzJoa0xtVlpaTWJXUkJqTEFycVN0bmRDK09iMmNR?=
 =?utf-8?B?ZzZDUVBaUWNGSDVtMC9wUDVFN3BWOEV5czJYR2I0aENncjMvRHZBUjVnS0g2?=
 =?utf-8?B?U1VoaWRQZkYreGZYbHBqeng4eWV1bGhvUVlaMDFlSDRPUzZVMGpNRFdtbDdx?=
 =?utf-8?B?ZFlmenFLV20zYzk2VnphTzEvMEhsV25DUDF0US9ZU3pXWklLMlN4bGpsUU9s?=
 =?utf-8?B?WWc0N2xnR1cyNjFCOXBtbjAzeWdkRjNuWDgxWjQyUmNubVpKY1c2cHNFWmp0?=
 =?utf-8?B?Snc4TXZaVVR1cFlUdlJPSmpFYkNZaHFWT0lYdnAzM2dOMEZGOUloSlZKSjJq?=
 =?utf-8?B?VXRmVFhzUklpUmRvdUQ2WFZMNTltQkRKeXd3UmpySVNYc3JwNHdkZlFBM0Na?=
 =?utf-8?B?MTlxMjhCMHhDdlorWmY3ZjY1NEpUQTFEUEY0blVMempZOU1rRnFhcVdXV05h?=
 =?utf-8?B?UlpnK2VGWlgvMldBQlpTVmViM3ZRUnNXblRwMFEzTjFXZ1NWMnczWkV6bFBE?=
 =?utf-8?B?NDFPTDBqTlNCdmZPditIYU93YTEzcjdlRFlpQzJ4U1BieklpemV4NndPeTQx?=
 =?utf-8?B?VTFQWEhkSmlDbnNKazZ1d0hPa2FVTDkvRzdaTmhTQndscU1IVW05Q2NJd09I?=
 =?utf-8?B?Mnh5d3hFb1BGRVlDZXkyM0RMaDBtR093cjk2ZTZuNzd6eHRMOVNiR1JMcC9I?=
 =?utf-8?B?bnZNWDBHbXV5aUtwdG5CWFIzZ09RbDdtOFV5dStGK1JVOE9JaVZsQjI0L3V0?=
 =?utf-8?B?Q2p0YTNFOVYwcFprOVc2eHRaaFZFaEU3NjdFK0YvOFcvZHJQd2cwbDNYbkpu?=
 =?utf-8?B?RmxNcmFQWWVHeUNxbkd2WTdyNVUrdW5RNER0MHNXRHpHNkNlcG9sa0xxM0Ji?=
 =?utf-8?B?WWJMQlFKd0VIM0Q2UklRWTJjVHRvVTVCQVNyeEZHUHlaZU94Q0djTVNDWmQ1?=
 =?utf-8?B?cTg4c1E5YzlHcld0ZVZMaUd4UDc0bXlnUFF5eWxXY0pOeURjOVcvTndDQmx6?=
 =?utf-8?B?QzgyMDJtQ0FCYjcwdTNpMG56RGdWM3JvZTJjeVZESXFoYnJlZWJqWU9KeDNu?=
 =?utf-8?B?SXZWcnZMUjMxeHhiMWplL0c5TURyVUt3Y2FiL2czK0NhY0JHRE5kMHV5dHRM?=
 =?utf-8?B?azQrUUNJYWxSUVF5aVRTQVZCRlhLN0Jybk8vZUFwTTh3NHJqUktIeUtlUG5Z?=
 =?utf-8?B?YU1tQVZ5Y3ZsQ1dBVHByUDVub3lNbmY4dGJYOFNVOWVldFdYcitxaW5ZcFNs?=
 =?utf-8?B?SWt1TUZoaW0wdzdFdFF5Wk5ML203RVdDTzdJNDN4a1M3MzVLUEtCNzlnYi9W?=
 =?utf-8?B?Z29yYzZCelFpSFhmSXJLY0hGZGg2WGdOb1JGRjhzWG5OcUNSUGMzVEVsU2ZO?=
 =?utf-8?B?TTdHeHd0MWVpdlpVTGJEcWx0VWZUS2xVYUpYS0lhRGppMlhienR1VTB6a2pn?=
 =?utf-8?B?eWVvWDZteGlISzJib3FyUTNYc1JiWE5DcUdrNDBqcnZLL08wV3k1TDZDVkhi?=
 =?utf-8?B?ZWx3L3IzSW9RTndQWnFWMXZOWWtrYXhIeWs5bG11TjJLeEc5emFGcWZSa2lj?=
 =?utf-8?B?Qm82eWNkSEMxYk93aTBCbk1aemc1OEVBMjQzWWVPZkhldWJyRXVMc2ZPOXBy?=
 =?utf-8?B?Y3NxbnRJbjlucU1NaFJ1blJLcEM1cEVPeW1QUVcvWVRBT1h2MGdycGNSR0Yy?=
 =?utf-8?B?cEFkM1ordW5RaTVSWDNKTWtkSHBrZjl1WURkWVQ4eUFnOGJDemdUYldzem1Z?=
 =?utf-8?Q?Z/u3c71VQlqEc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1VETmJwVnJ1Q1RYSVpjZkcvcWlUMVZBbTc1dkFEdHVLZVEwcVpnQ2M4L2U2?=
 =?utf-8?B?ZHd6eXUwanY1aUcrVTZjYXJxUzJyemVYSlVUeFc4WWVjSDlEWVlrdmo4cmNl?=
 =?utf-8?B?UWk0QXRPc3NCQk04TXcvcGhSd2RWVFVsQXh1WVNBWHZDL25rWG5MaEVuN1dH?=
 =?utf-8?B?NWQvVllhYi92WFJwNVpIeitiN040TE1hV3BCcUFLZTY5VjNWRWJVRDBlY2JR?=
 =?utf-8?B?TS9UQ2pXdm1Qa0t1amdxVGlFTWN0WTFKM2ZiQWNOZis0cnZOaW1jUytqUEhC?=
 =?utf-8?B?bmh1VER0YTN5bU81bFgySzU0aHpjdkM0ZUtDNks5dThqT0tvQ3JzbTlsM2dk?=
 =?utf-8?B?cTdrMkJ4Qi8rVEFRUERObUkrSkZBaEgwY0hxVXdvU1ZuREFnSGkwMmR5WVRw?=
 =?utf-8?B?RnBvd1VOR01QUUN4NGhTRTdYVUdHd3BoT05OSUt0QTVMVXpENW1IbXVCTDNO?=
 =?utf-8?B?N2l1N01SdkJ3VHNaeG01YkZDa1NJZStKYXppUmlHSXVqWVV0WGxFbDYzaXhp?=
 =?utf-8?B?SytIVDRRV1ozdjh3UHRKNGtGdUo1RXNWVVNkYnl4UXE1VEZRZjBLUW5aQXdM?=
 =?utf-8?B?akMvY1NnZ0IvYnRXZ1l4L2RmT291Z2xTN2VvSVplWlBFQzJvMkFrZDVEZ09u?=
 =?utf-8?B?ZEdFbW83MWE3NlRXRHpad2NrMUVHV1RWbDg3bG9zb1J2ODk4Yi9HR0hiRDVi?=
 =?utf-8?B?a0F3M1dVZTBrckFhMFNPc3UyNmtlWUt0N0t1KzUzYmNKRkZtRmJ4MUEzZGFV?=
 =?utf-8?B?bmhIbnRwVjVqeHYvVzdGNFA0Tkh6SDY2N2llOExaclI0Y0VCWnNhb0pJamph?=
 =?utf-8?B?U2UxV0xWcjFpNkpTT3NuWTdpVUJLbk52bFJlbHlnYzZleTFFbVoxZVR2ajVu?=
 =?utf-8?B?MkphV1RsRUQwMDdpa0pLMk80VG9IVVloWnJjRUhYcy8wbjFnbUQvLzd2c2VN?=
 =?utf-8?B?OXBzYlJQOFlFcGt6QVdQY0V1MlB5bit2cGJFTWthQ2x2MFlzOGlIRmFuWlVr?=
 =?utf-8?B?Q0lYVEtPNSs0WmoyeVlxdDkwUU9LcGFTVFRSVlBweXdpUTNKaEcxWFNPN3ZT?=
 =?utf-8?B?cWxEdGYvRjd1R3pxMG0xTGM1QXFNOHBLb09EalM3V0VzQ2NrdFJvQXJ1QUZo?=
 =?utf-8?B?cjdQTUx5S1pFS1A2RVhiU1FPY2dkVkl6a0Z4YTNRTWNzYjB1V0NPekNpbGV3?=
 =?utf-8?B?RVo1WFFwUHZ0L2NQQ01sRDVVb29yY25wME83cjRra3VESGNhRlArL2tvalRE?=
 =?utf-8?B?T0ZvaVVtNHdlc0xvd1B1TjIyNVFNdlVTSkFGSmxabDYrM1ExWUhoVlIvUGZq?=
 =?utf-8?B?L0ZZbTJnVVZybEo5U0QyNXhzY3crTFkyTHlOcU1rSnBuWTVCRnR2NVR2NEJ1?=
 =?utf-8?B?a3lpTDhwS1Zldkh3cjJVdU14Qmh2R3dIV0I1QWJXVlV5TFZkU2VNN2puTXJH?=
 =?utf-8?B?SWtTTmdiai9LcjFkaVM3Mm1aaXZPZHRJUXpZck5wM1BSbXYxaUJkL0RoM2d3?=
 =?utf-8?B?OTBQT0NzVjhGd2NnVlFSRmpjczNCYUhhTHpqUFBlemNpMEtsTkp0b25pMGs3?=
 =?utf-8?B?VityQ09UTnFHMFdqQjhPcHgzZCtFZkoyL3F0Nkk4dzJaSTlSSUthSDlGVXgz?=
 =?utf-8?B?Z1VNSVFsSjFvSjhxWDkzVWJ6YW54amdCM2JxeHBhVDZOTWlwcWo3ek9wSEw5?=
 =?utf-8?B?WVF1R2hXR2Z0ODFCajF4L2dKWDRuUkorM0kxbzVJVm1CS0JRSVlrK2VkVFJR?=
 =?utf-8?B?eDdTa2ZSMDhZR1h1Z1pjOW1JNWZ4K0NWMXgxUHFVcks3dGdmcHgrbC9SbmRB?=
 =?utf-8?B?OUk5RkhuYlVVSXFGNHhGYTBWMHExbGxjS3NlMEkrbmJyaGFEUVgwVE1jazRt?=
 =?utf-8?B?dnpOaXpaMXh6bE1NR2RuQ1NtZysyYXlsSDlOa0QwVHdpR2VQS28xRk1uVnQx?=
 =?utf-8?B?UHhXN1k0ck1hZVJ1VTl6NGRFSzdtOTN3bmpncTVGWUlQUWxqZFNSaDRTODhU?=
 =?utf-8?B?ZU5EdHc2NlFiKy9ZSUhNVU9DRUwwcjRMSGt4VW5VVThQS1Y3WC8xb0h2SXBu?=
 =?utf-8?B?VFU3Zmo5ZXBxdUtINHppTGlPaC9ybTlvbjlucnlQYXRaU2ZhY0s0VWQvM3dO?=
 =?utf-8?B?VWd6U05QbjUyV2VYL2Z6VHdqcWJGQnA2d1NHSVlCOVZNMFFpZkxZZzZhU2Uw?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b936347-ca81-4ddd-186b-08dd41f6a0b1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 12:56:07.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtS8BIk9VctKf+QjLDJUFWaBdgP0Ez13xD5UA3Y3xOZnpl2ArZH7upvWW32NKeZaGejcAgvuDnlVUGBjyoBNP+LxMu5iDYSsnbShzHWrecQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7592
X-OriginatorOrg: intel.com

On 11/29/24 21:36, Lenny Szubowicz wrote:
> Disable PCIe AER on the tg3 device on system reboot on a limited
> list of Dell PowerEdge systems. This prevents a fatal PCIe AER event
> on the tg3 device during the ACPI _PTS (prepare to sleep) method for
> S5 on those systems. The _PTS is invoked by acpi_enter_sleep_state_prep()
> as part of the kernel's reboot sequence as a result of commit
> 38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot").
> 
> There was an earlier fix for this problem by commit 2ca1c94ce0b6
> ("tg3: Disable tg3 device on system reboot to avoid triggering AER").
> But it was discovered that this earlier fix caused a reboot hang
> when some Dell PowerEdge servers were booted via ipxe. To address
> this reboot hang, the earlier fix was essentially reverted by commit
> 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF").
> This re-exposed the tg3 PCIe AER on reboot problem.
> 
> This fix is not an ideal solution because the root cause of the AER
> is in system firmware. Instead, it's a targeted work-around in the
> tg3 driver.
> 
> Note also that the PCIe AER must be disabled on the tg3 device even
> if the system is configured to use "firmware first" error handling.
> 
> Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>

the bug occurs also on Intel drivers, we even got the ~very same fix
proposed:
https://lore.kernel.org/netdev/20241227035459.90602-1-yue.zhao@shopee.com/T/

I believe that such fix should be centralized, instead of repeating for
each driver. Especially that the list of platforms is likely to be
extended in the future.

It's sad that we don't have Dell cced here, I'm trying to get some
relevant contacts, but without success so far.

