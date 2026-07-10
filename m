Return-Path: <netdev+bounces-306493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9zeON0rAUGon4gIAu9opvQ
	(envelope-from <netdev+bounces-306493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:50:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F00739410
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:50:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NZLovYQ1;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306493-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306493-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4106130031CA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990B3F8706;
	Fri, 10 Jul 2026 09:49:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E43F9294
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:49:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676963; cv=fail; b=e5pyFX063nY9hQJZON1fdeou2x5hKTR0HofzCysFyOdK1dgDz8zTM1m+5bdPLwNsnW2sya9ebgoAXSVm2oDiQkn140iXjP+PxWwRZbRJy7hygn7xXx2mTmgcXpAgS2RUmMmmAz8q282nEYsTq5IToybwYgRg9Z5Ep0tXzw/c2cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676963; c=relaxed/simple;
	bh=vS604qOZjGOSKj+gdySwUcB7XVx8my/CbQ5hbGOYYGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bxBe+ihoKyT9KEcBOL3GizjLTa/fJIe2skPImB7Eol0yKP7hgg0HRXaq6iK84EuEoA/0Rwz6V1th7VEApoJT0UmduWw3lJtvYynYjT0KFSCPRJh/YFkDXyC51cSg5UDGWqPPb69kiE7mTzdIFHj8FyKbs0idCfV6DSii5W8xvD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZLovYQ1; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783676962; x=1815212962;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vS604qOZjGOSKj+gdySwUcB7XVx8my/CbQ5hbGOYYGk=;
  b=NZLovYQ1Wlg9fiwcmF3ONeqqOkHXBEoil0A3IFs2sFau4qJGeLBD7iNY
   SrtWcTXaMSuDwgYiGhvXau2iYsvhh8wHsSeTgM8ZgWHYhkm74dktl1DQO
   ogUEgC2Qaaiwaz3y0dv5cI3ndTPlOdj6P3Dk/QyJy223rWFNkmdY7YDEM
   ghLnT9szpIF5Ci5PED8AB+/HDsgjXrrGh+qjLzLa0pPvv2qtvU0vd4r2J
   rtBsVbVQzA8sQ8MDm2Sx5C1+j0RQ5Ok4M3g+eoSb6Xx/FWBQzoDVvkTna
   00EKxGoYd+xK5SLQboXXFbIhRc3pBFUFKLn8rSLVBLoY79JD4AeNz1ZYk
   g==;
X-CSE-ConnectionGUID: 8Y/Kpp4PSWmt/RNAjYJ2+A==
X-CSE-MsgGUID: BWEP80nRS5OFbWZvvJPbZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84395380"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84395380"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:49:22 -0700
X-CSE-ConnectionGUID: Eh7bIvDgSCeIEv2TMNVAWw==
X-CSE-MsgGUID: ACPSqFAsThqrLT7S3DwP6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253726307"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:49:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:49:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 02:49:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:49:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9/PP00tJN1IUkQmmG8LilKHRRGV6Dw85CG3Dy6l7ZEB+oNiyCnLyln5Utw9sJe5ZyytxLPodJuZ51Tocmu2dfsVTvmzyhMgazyudLirADLx3lWsBySif4O9fZOQZK3KY2oPEafvIYFNVDlrHbXfZv6fb0dG/ynTZh3FGIgrjcyiQ9FVy3alnZWC6rN8e6Ph18VCZbbdhgCQfexjvbibmVqPT7en0IxrcamxcP/GSEtpO5mqFlsoj4i/XgGAgebPTSJ7hXmJGFY81vSTPlOL7TmBZE8bFyGWAqiu/WHYNDxiQmXz6RaEaDez/K3tI7v37Go23pgT1jU+7QZ8PPnLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfzzZmgEG8rDcN4g/THYPitgEzGkDfPsE4SIX7UNaAw=;
 b=mW8K1xRUfVju9Vq+FFniTe6wtZqkExJMfsWCusVVrcgsh2F1K1uVgtIwLtkI26E6heRW9FOlDV6FqeEwmtRNMCm1AZNDQb/RJen3y0VRCk3bHcjHjspAxofFVCf6V0EbjeWl5GKcU48ha4lGDNWsB777ZbGmiqhl7aBIKp9fRmOxhJ7Q1Ly4rC/yafvhoIisQmNhUWiiJ+vPpKZPvFGAdy+ukLZiRasIJFDGAIlHwmVZ/RJjNkS6yPtRAtp5cEP9Ezfd/2Im6C24uUT0xXFLWyO2+io5xuOGYb9UPK3IMYnS7MGim29ook4z4rwtE2D/vsaJ4XqHl8ohFc+XAEx4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 09:49:18 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 09:49:18 +0000
Message-ID: <f0be57b5-8574-4107-bb31-e1658b73267f@intel.com>
Date: Fri, 10 Jul 2026 11:49:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: libwx: disable TX VLAN offload for packets
 with >2 VLAN tags
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: Duanqiang Wen <duanqiangwen@net-swift.com>, <netdev@vger.kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>
References: <C1BF77C0E073A40C+20260710071831.210196-1-jiawenwu@trustnetic.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <C1BF77C0E073A40C+20260710071831.210196-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0290.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::28) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SJ2PR11MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: b84bb910-4c00-4e6e-f742-08dede68827d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|23010399003|376014|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: i2qXKgJCovF/ijh95VWZsxQefGeLrsSJPqRJ79cZwTV4s/4Ydlxrs9pE42tfL5mFtoFScP4nVA1c3t2tngxcgbzmZRlzwDpXU8x5A9hMjSxbLKkeG9O3vwvYYJ+mzjzDxxlei8Wz1153nCBfZLqpsxPU90URgdJ/gSmBKAp0bEeCubSFmZNp/8imYmY7MNwCSikisllGT1vER5T20XUttrPumP92CWbbHnYsShEMjIc68s2bcPC27UhjjnwYZEXDyZmA1LQs8/yGjaZTaP0DJoEKOYaCsuE5ksiXeH363EP8GE99JPyeyTjWSYKyKPOI6NF4sci0lfeSYJWLyYNNTbfG1kTYolIS8VDvdzdBvZBZxjHBPYEk0KGNJGcc5fa4gdJkdZXLKMcJ0lJajIU8kLz87ca796//etLNw+j0V8KKZOZXDco43AbzkK/XQCxRED2kDBKeOVlU5N5dGRXyWAD9/ZMFe+d1Dued7OF1qZ621jFkJ+w38szR2acZkEvnp7duNDlU+PkmDpJC2BtmYG2/DDsDSHaZGLpfgXBViKMCj6fSMcyyd7/MQ8w9y+FP2Do4M9NRB+sAsD+Khkw7jaPbIZpHM/JCZjLnJVFbgvjyFLoKFas6hjFzLifgnBU4DSS/truW1KbRKIEdihP/w6ikS3zApbeRYClvH4/fK1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RURjMXl1YXdIOGNBK2s3MXZKRkNYbVZxRm0zNjZKOGk4ZGttVmlGVlQyenZZ?=
 =?utf-8?B?N0FIdWtCdERjbHNFSzdnQ0srbkl5bEpLYXdtMjU4encxSTZmdm5MTWtVVGZy?=
 =?utf-8?B?bDV6Ykl5cElaYmhIMUc4bU1CMVM5elVuZHdGTGlGaE9jem0rVUhyZytWbVps?=
 =?utf-8?B?T0V6OFk2MEVzQWlVOGhMTDJNMTBlTGtibXRKRklrU2dKL29xYzZFbDFvZW91?=
 =?utf-8?B?dzFGRndyNTRacXJnZjdFSnlsR3dKVVBlZVRxTC9TMXRYb3hLZlJlSHRvK2pN?=
 =?utf-8?B?ek4rWTB2VllQS3BzbEwzbHZ4RVJ4NFlid0swaEJXNWUzTHVMUGFnSGlMeWRa?=
 =?utf-8?B?VWIwYkFIL1VsTVR5d21WM0hYcG9nNGtLZ1pvNWV3Z2VBdUU2MENqZkJwcnBi?=
 =?utf-8?B?T1VKcFRhcGc5TzRaSmRNVW5ka0FUUU15UDgxbG1FOWpXOFhFWXRGdEdLQWtp?=
 =?utf-8?B?YXRlT1JzaFpsRXVCb2F0aG5rWHJqVE9WZmhtMmxqNytmT0V2Q0plc3gxM1R4?=
 =?utf-8?B?bWNtVUQ2UzdqbkIwemdsUGtKY0xTajI1ZDJpNTVSVWhJc0V2NVpKa0NrQkUx?=
 =?utf-8?B?WktjYmtWMmhYTGJnUEhsZ1kzcUswRmpuYmowYy9uTUZRb0VNSzBJMUxCcUZj?=
 =?utf-8?B?MnJja052NmNQNC80WHZ6Zy9ONnlxd2VOSGNhdzhyMzk0SVJYTlJ3MUhjaU5l?=
 =?utf-8?B?VnZsZGk5eXJrY09LNHAvVE5mbHZsYUIwQ3hubE55dXlrWTZvbjNCd1Z2c0ND?=
 =?utf-8?B?RE1vYXNGOXRZVkRqSDhncEx5VktiZm9EZTRZdE53NWljRk5rVk0yQ3hOR052?=
 =?utf-8?B?dlF6QUs0eHM4eVEyai9aOWx2SzVGQjBCeHBxNmZMbG53V0tvYWtWWklmS1pt?=
 =?utf-8?B?U1NKVzNCMkx2ZndlKytCWTgrN2k0bVovNmhLaWdvSHZXNmtxSjNweVErMzBt?=
 =?utf-8?B?RGEwN0NCNmROVUZKUnRtbWd0S3hhNGlmK0J6K1d6dkVtRTIzcHBJZVpFUU1o?=
 =?utf-8?B?VDRlTzJzYmFmT0l5RmllVjNQYzlaWUZsY210NnJVU2xJcERZLy9hamFVZHZP?=
 =?utf-8?B?cmRLQnN3U3NZS0NCc1ZqT1FxWTZvYmdGUjB6OWs2RmxibTgxSktmLytwY21q?=
 =?utf-8?B?dmlta2paclRaOU9jdG54a3B6SEtJYm0xMTgzYWZPdzFibldyeDNpamtUeE1k?=
 =?utf-8?B?OUZHVk1qbHlack04QkZwQnB2RFZJRW1BTDhqZTdtL1hNYnBJZkFzRDFJRkQ3?=
 =?utf-8?B?Vk5CVXNER3lLOWFNQWV4ZjFzTGYzeldQZnM1QjY2RWRsUGIzVWhYcE9XYjE2?=
 =?utf-8?B?Sjdqd1NqWUNsN25FZ2k5MXlvbG5sYlNITlZXK1NQeTIwNm5RSUVSU3NvK1c3?=
 =?utf-8?B?bGZ2RU8yTTVjVTBSeWlmak04ZCtzUnJmbTdyR0twZzVuVnZHTmhuZTExODds?=
 =?utf-8?B?Mm01b2lrOXJQR3hiMVVCVXRTY0J3ckRpK2t1Szgzd2ZHSEZqc0srZklRendQ?=
 =?utf-8?B?dDRSUXZXSFRBNk1kMUJXRittN3lBNXZKOHN3TWJiN0RmcVhzWkM5VkNKOG9v?=
 =?utf-8?B?cjBQVTM3cURBMTdsSWNEdVVuY1Rqd2xZMmJZRVJNdFdlTnVGQlBoV0p5WURF?=
 =?utf-8?B?UFl2bFVUK2lrR0F3RkppR0JjOHlEWW10c05kbFF0VzE0K3ZOVGhhQjBUdXNw?=
 =?utf-8?B?K1ZTVXcwUkxsVThwVEs1WXRxRVhDdUNYZUZBd0RoaEpGSHFUVm5LUDQzNHVa?=
 =?utf-8?B?K291ZDRudWVKWDBlWW1Fd2t1UEdwVVpQdjBnNDZWeE9nTiszeXdjV210eUtq?=
 =?utf-8?B?YzlOdlZxNVAyTG9HQ05rNGhRbnp6S09qZDQzWVhKMmx6V0g4WmNxZlpwR3JH?=
 =?utf-8?B?ZDViOGY2cEQraEVVRXltUXpPcXJYWk5pM29jdmtYYVJyY3ZJTWlBWW5SNE41?=
 =?utf-8?B?VXlMcDVpcUtFV045RDczT3l5TnFmZW9xWERpV051OWRoKytONE4rK1U3dXFW?=
 =?utf-8?B?b1RVeEtBVlBRUlliODZOMGdTMmFZQmFYSDg2dTljYm5VTVF3SmozSURDZU9u?=
 =?utf-8?B?bk5LQVJPK1FTcktSb1JHY2Q2ZTMxSHEra1RTeWtmYzRNY3BXS09CMXY1T2xB?=
 =?utf-8?B?ZVd4bE5OTEFPNDUvb3pIemRrNzYzdzdZU3BWUTUzcFk3Y2F4eWo5UG9kUW14?=
 =?utf-8?B?YzdrOGdaWllkazRPcUk4VmczSDBJZmVxR2piVENzQlNBYTdGeXFRNkkwdDRt?=
 =?utf-8?B?ME9yeDhmcm1qQ0VkTWVpWUpmY0tlZUxEelp0dm00cFNMYUJCVmJUL21XZVZw?=
 =?utf-8?B?MXhRZldHeVhQY3pIdzIyNmEwWENiT0d4bVdWUG5tZnF5b2xPaVZtSmVEeUVk?=
 =?utf-8?Q?aYEooRjHN+2IsOYM=3D?=
X-Exchange-RoutingPolicyChecked: Ddx+gjdpxYoqVmCOKF40W8OKifcdK+gHcqYJq9Vz8sp6Ua06wmuddIOVDMW9LyQoCUmlm5EjaVuzs0dmBZC4UcDWMg8T5TeTLZ+By3uV4s/zDJUwCw0NkAydD+Ckne2qhm8MxjEGdzAwRkUFVDPTmTZETACLQsYnj5oaJ5/RqvhHvlM/5IaPr6e565vH/CourvXH2bLiFnWVvOcwMq6xx+Rp5tSBo5/19wTGUOJa/z3xDxtfo8+ZSo+c2827EKa56CClWjEZlr5EHjOzYuIfvvJ/YpVSlemVBLLX/AWj/1y8PvqHi0zAcfeq0TGpmcQ5EnSNZjP3rWZVX7IYOrVWXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b84bb910-4c00-4e6e-f742-08dede68827d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:49:18.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnkQLqs/80Mh5O05twqYJ5BNAs4IioMEbCK3rgkedoj8tumTb+n3CJ9Ka963eR2zOcYUsdlW+m7Qp6FWgdHtse3gN87HXEBehmMWfYRsBuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306493-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:kees@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44F00739410

On 7/10/26 09:18, Jiawen Wu wrote:
> The current hardware does not support TX VLAN offload for packets with
> three or more VLAN tags. When such packets are transmitted with hardware
> VLAN offload enabled, the hardware may malfunction or produce corrupted
> frames.
> 
> Add a check in wx_features_check() to parse the VLAN depth of the
> skb. If more than two VLAN tags are detected (including both the
> hardware tag and in-band tags), strip NETIF_F_HW_VLAN_CTAG_TX and
> NETIF_F_HW_VLAN_STAG_TX from the feature set. This forces the
> kernel networking stack to handle VLAN insertion in software for
> these specific packets, ensuring correct transmission.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c | 25 +++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 814d88d2aee4..65dab6bd8a39 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -3223,12 +3223,37 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
>   EXPORT_SYMBOL(wx_fix_features);
>   
>   #define WX_MAX_TUNNEL_HDR_LEN	80
> +#define WX_VLAN_MAX_DEPTH	8
>   netdev_features_t wx_features_check(struct sk_buff *skb,
>   				    struct net_device *netdev,
>   				    netdev_features_t features)
>   {
>   	struct wx *wx = netdev_priv(netdev);
> +	u16 parse_depth = WX_VLAN_MAX_DEPTH;
> +	__be16 type = skb->protocol;
> +	u16 vlan_depth = ETH_HLEN;
> +	u32 vlan_num = 0;
>   
> +	if (!skb_vlan_tag_present(skb))

this if jumping over the loop with essentially the same condition
does not help much, I would just remove

> +		goto tunnel_check;
> +
> +	vlan_num++;
> +	while (eth_type_vlan(type) && --parse_depth) {
> +		struct vlan_hdr vhdr, *vh;
> +
> +		vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
> +		if (unlikely(!vh))
> +			break;
> +
> +		type = vh->h_vlan_encapsulated_proto;
> +		vlan_depth += VLAN_HLEN;
> +		vlan_num++;

parse depth of 8 does not make sense if you are detecting
"are the three first protocols a VLAN"

> +	}
> +
> +	if (vlan_num > 2)
> +		features &= ~(NETIF_F_HW_VLAN_CTAG_TX |
> +			      NETIF_F_HW_VLAN_STAG_TX);

you could move this if condition inside a loop with an added "break"

> +tunnel_check:
>   	if (!skb->encapsulation)
>   		return features;
>   


