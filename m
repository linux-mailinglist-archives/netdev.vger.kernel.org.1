Return-Path: <netdev+bounces-100098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D358B8D7DBD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B151B2377C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813286A032;
	Mon,  3 Jun 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I++ddak2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5DB824A4;
	Mon,  3 Jun 2024 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404369; cv=fail; b=FSxLcVPK67+xlyf61nz/Hy7XRE4X6QNNnafYEqJFgiK38z5EuitV6Aslt7A9RfbL1BPI045C/fbj4r2KcHHtn8A0Wl4S7wYZ8EhWpQytAeHDUZ/q1r93ixx4316VoxRYtQ3eo5sorvQNMNWY868ChZp6wKKayzjRKMZ1bHtfWQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404369; c=relaxed/simple;
	bh=+U1ECCKSICmUTcTd91hx6C7EQEkNv+tZnY6DYntAGos=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fu1bN9MOdxM9Gz8YKSw3HYVAh6iqeJBWXDO1nRNIsKjha+mrwuAvJVcrdGjzafWnjSAp9RAkb5guXUZSPtcW4708DJNr3NrkncRgw27NOWgkUEhOfMmeNp5J7tHPIJqrYNepREQzEh4JJHzmLMvEvrVMDbH05eQcw0zfVuNZRrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I++ddak2; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717404368; x=1748940368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+U1ECCKSICmUTcTd91hx6C7EQEkNv+tZnY6DYntAGos=;
  b=I++ddak2NqHoeASdh4AI4r4bOo+jCL6Bjs6WObUzHyCWnNIkPnJhLqom
   9QGTYM8r0PzHNhcdTtfzLBl9V2xK3yxBPsdu4+oJeX7L65TTMkoq6ltcD
   NrdLDkTrYRIv4VLaHy0m0Fuw+rv9ZPxdOsH7ZdJYylujwVTNnnvO1NSkL
   GyKiFugLmFSlsJ/F5ZWnYHe2lRamkl6ZoHJJK+lgUTv9h4PvziEs/M50K
   tz572wGXjbvFcIzedwmhb/QxWQvCbkM32djPHyxwtYkrlG49I/sZvKWVc
   GllBXl+hADyvOgRQqk1/nQ0/0LY4+NjOqnyhv6q/RMCeBaOrmhKF18p+w
   w==;
X-CSE-ConnectionGUID: pffBRIpwTSykgfEu5KwkQg==
X-CSE-MsgGUID: d7+MsQPdSauk49ixBlJsGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13753385"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13753385"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 01:46:06 -0700
X-CSE-ConnectionGUID: rETFIQwqRImUb7kqqCC9tA==
X-CSE-MsgGUID: RVV5bXdmRRu7R9o5JCGp4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36892016"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 01:46:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 01:46:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 01:46:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 01:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr1oagXm6hub/JSm3AGTcb5Q0b/Ya1fTBz7LvtX4iNiPAuY6r04wRZUblGE2Zd6Py42t6/fSpHy+I5cryIkAYlnmwZOR+OazVicShRMIMLm1gTtnSdNT4jDnvhN7m+zvZ4z6VBMCYXvINNme9m8E8CD4/RtbjJnac8KpMU7VSSYN81AUfjsI1A+DJtTSyZV1Aga9kE2Tm6FLFexrXBjXWvaa2qzKWDqJS+PpmErkGZM/NXiN5Pzc2AyRe8QfZjxqpxSONITeFfA2485+7VdgCGbD752YreeXKQBVjOrKjqeqFrAVjx9v3AdytqfG5JJ0fwZQpAx6xKGu/a6RGVSHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efqPFJTMht4B2sJJhYKzdhBsxxXU4bBJ0SaW8kwKcWM=;
 b=beDh83ZjXN8DT8BVjlQ6fv7CvmxH9aGXvbN+BPbWKzE4pfG1ABIyGVv9i6lwrnvuDYvO7fHJ3/HnaCqVylCbTDiAL64JVJ9/Ty0bvUVUDtC8AuOagrf8iGdMCSatbFVCyN0s9/62qrWDkM9nFjT707JT9hlRYWeaABDiV+Wv14INhLXziHPFcZTmbLPRtxAI7rrFtiduZJpIqaU9nNPLTtgbRagHUIohx64Adgx8EQf7RkcglM3u9+uL68GSh6mX1ry0omkgAkAca06lMW4QoLQV7JlSbZfXxC5dDduenlTqqvZtPR2qaQR9UUB/lziKsWXHs2YeaWVhda/G3+1Apg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 3 Jun
 2024 08:46:03 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 08:46:03 +0000
Message-ID: <37e0f1cd-d6b4-4b7c-b386-7d31423ac7c8@intel.com>
Date: Mon, 3 Jun 2024 10:45:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net-next] devlink: Constify the 'table_ops' parameter
 of devl_dpipe_table_register()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
 <3d1deee6bb5a31ee1a41645223fa8b4df1eef7ba.1717337525.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <3d1deee6bb5a31ee1a41645223fa8b4df1eef7ba.1717337525.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0033.eurprd08.prod.outlook.com
 (2603:10a6:803:104::46) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 71021f48-ee23-4d6c-7f16-08dc83a9997e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWhxRyttaEM5R2NFQ1l1MDd3ZEQxWGtpWERkb2o3RWNYM1AwNGUzazJiYm0x?=
 =?utf-8?B?YWxHemVuNkJjU3M2YWM3dzNFUXg0cDNHL1gzb2VaRjZ5TUp0R3NqMTdFN3Jt?=
 =?utf-8?B?K1lDbEtZWVdLZHM1NUo5YXU5N3pLR2NZV2ZoQ1dEVTlralJhU0pkbUNXdWFZ?=
 =?utf-8?B?NVNaRFJiVVFaR1hNRFRObENtRlRiekVNai9JWmFaMk13ZDdZOVZyWGh5bkdZ?=
 =?utf-8?B?ZERxdEh0NGZ5ZlRCMTFtbXQzT1E0bHJHR3hxdGJCMTE2Y2RscjBZeklKS2ow?=
 =?utf-8?B?ZWNBdnVoVVRuK3VVSktnaUFwd0tIZlRzemVMUlorVWNTcDVCQkFNUG1BM3Zq?=
 =?utf-8?B?b2ZUdVpPeWYvWHJ1ZkFuZlQ2NHZtWTBWdTN0WUIrZHNadUdLcDBOY2hrS0hH?=
 =?utf-8?B?c0NpbXVHSFIrejlqUlRxdktEdzRRQ05wcndmTEo2SlEvMFNBdjRGNVgxWThV?=
 =?utf-8?B?REx0OWlEczRKdjdYQ2lScFIyR3hkUG9ScFpIaGRPYy9tZXg4cDAvazV1ZFpV?=
 =?utf-8?B?cHpDbmJLYVltQmh6TmFVbjR1NGJVSEJZSUtaUnFEb2xRSU1sNUVmelNIa2hY?=
 =?utf-8?B?SWJRSVRSQU5RSTdDSUg2OVAyS0xobk1pMXBiL3krVkhTbmNHVzZFb2FqTFlj?=
 =?utf-8?B?a0NnQnFITHVBS1NCYTNvRDg5QmlrY1psTngyVFNNZlBnc3QyWEphazRtbzd0?=
 =?utf-8?B?eGE2QTVZWmIrVEEzbUR6SDJ5R3ZLVTl3cm43WUtDcHV3S0FFNTRVS3VOb2dJ?=
 =?utf-8?B?VmVSc0JpYnJZdVlLYWNNdDAvVitKL09BdkVkblJ4dDBwTnE0QzM5d1NGa1lR?=
 =?utf-8?B?RENkdXRKK0dObjQwdkQ4U0Y1bnloVGV0RWIwblVNRkkwV1YvVkVoRlpFNHFE?=
 =?utf-8?B?TWE1a0d4eU5oU1RnNGlVNG9YWVZ5MDJLc1JoVEhqL1NvWHA5SFFMR0dLUVRu?=
 =?utf-8?B?NmtKY1Nza05xdVRJYzc5SmJ6Z1BJSUpFSVNCVWE0NkNJdFdvQUFEWDE2ZFBE?=
 =?utf-8?B?a3JTdTZSK2s2UWFaVkFkMDlJNEFQd2RKZG5UdEp5VFJyZkpzUGdzN05vK1Ba?=
 =?utf-8?B?eEliWThxb1JzWkcxYnpMOUpVRU9IWHYwTmdEemVnY0UxbUREN3ZONWtkS3J3?=
 =?utf-8?B?dkZoZzdEZXd0YnV4U2EyUk9EUFpScE5La0ZpUzQrSXdJaGF4TmVMdUhtOENo?=
 =?utf-8?B?M0RYUTFXcGRQVndnRkJmVUtlRk1vNDYzbE5sZ0hSai9sUGZQbnZoRzBTNzRT?=
 =?utf-8?B?SktDdGVxY2pvTHRYYXJxQkZhcThhZzA1eVgwWEdDRlBZZDVGQ25MVEQwczhQ?=
 =?utf-8?B?cHhpM3M0bkhhdVFUNFRtRTNIQlRQZGQ5cUFkK2Jkbi9uMlpJdmZvWG42WlJr?=
 =?utf-8?B?bm92SmxvaFZPZDZFYXZvSnQyVlI1L2hGbEN2N2dxaU9WeXVrMk0zaGpPdDVQ?=
 =?utf-8?B?Mm9ZSmRmTHM2TE9FR0VMUmxzUERDQnN2RWF0WDh5VVNFZENuZ29IOFVTdTZ4?=
 =?utf-8?B?THYvbXFxVklTWDJnWHJXZCtMM1FUSmxUb2FIOUsrZ3pINDRtTHh4aGp0ZnVl?=
 =?utf-8?B?NHp0c1Y4clFkL3pnMkNNeTdTdWxqenFRZjJlNFNacklvL2VzanJFbDBnSHk5?=
 =?utf-8?B?Tm14MHBNZzFRdXpISkZDeHVGQkNQSUtIRXRjNG81QjJWK2ZsZVIvc0Ryenh3?=
 =?utf-8?B?U3NucERPNlZnOWxFWlZBTk0wcGt0c0o1cEF0QVN0NWw5R0pDODFoTHpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2EvOUVkbmN2SDZYVFNhVmRjZ2hLbFkrbld1UWxabUdoWmNoRnhVVmZGY3Y4?=
 =?utf-8?B?U2ZZTGk4dG1uRkhTZjVRQzgzcVJoS3FXTE5qbk16QVhqcUp4SkxRWVRvbHVK?=
 =?utf-8?B?VkE3ZmM1WG1ISnJYZDk2bVVjSnpGSzZKcldGSnM5ZGhtTVpjK2oxSWtFOEFC?=
 =?utf-8?B?dDY2NDlqSERiS3A0aU5nZ01Bd09WdTN3dWVGUzByYzJYa2VPV1lyRHVyYWF2?=
 =?utf-8?B?cDNjT1BaSUJkdThJNGRYMnhVQnhHWWdZS2VGaEk1eDdrdm5IWWNNRzRXUU83?=
 =?utf-8?B?ZGpUNUJ3cmRkeU1oR0J6MjNhNitWT2Z6ajduLzVBWmtkSm9QeHBYcjc5c2NX?=
 =?utf-8?B?a095S2lGS1FaVC9ZL0UxblNaQzJJSzNOMnhISTlHOHZUUHQ2Wlp1NUVZQmc2?=
 =?utf-8?B?UlFicHdOQ1B1SkJXbzY3Njh3NkFZMHcvRkpzcGhLamRYV3RWS3dSVnV6QVBI?=
 =?utf-8?B?ZUxKN3ZGTEVuQzdDaVpTbjNOUllUOU1NRFNhU3h4VlNQM3oyaDY3NGYvQWps?=
 =?utf-8?B?ZE54Q0hPWWdoRURzc0pSU2c1d1ErdGpWNkx2MW9INTNUMUZ0NWNud2xqSXVG?=
 =?utf-8?B?Tmx6QlNDWEREaHdxVlZZQ0dsSzcxeG9FemlUMGNyNTAzaXBVenozUVBnNjdS?=
 =?utf-8?B?NWpIMGdmU1h3TW1Kc3lNZ1ZuTWZmTDBnd1lESEFGRkZoRTZoZmVjS2VsM3ZC?=
 =?utf-8?B?ZkNvMGJ5OWVqdEcxTmVSWFhBandjMFVGMXpPWDRyNkpwVUVSTDAvcm9saGZF?=
 =?utf-8?B?R1crRVpTNjd5Qyt4eEV2L0hFSnNGN1l4TzZkQzdzSVFQS0p3aWpBZ21aN3Bp?=
 =?utf-8?B?S0tweDdSN280ZWRsczJqOXpUYTdMNGVqRWk2MTJaZmtLajZCSi9nWXRhbkZM?=
 =?utf-8?B?NjhzZDkzVjlrdWUyeVgzZkp3cHZWcVlJOVZWdzNjdXc0eUp0YmFPSGtWc3FC?=
 =?utf-8?B?eU9RUEZkdEQ1bmYyWTlJM2Z0ZnBtaHN5dU10Sk1STlZxcng1NldkSTU5cTFS?=
 =?utf-8?B?RklZRkRoOUpCMWpNRldtK3NkT1dnejkwU3JlWUVyTDdCSU5rcU9LeFA5dmdZ?=
 =?utf-8?B?MytXdmxNbE9HemlPRTNTRU5hUGdGYkhsbWlrUmhwcmJOVlJ4cG91eDdLTWEw?=
 =?utf-8?B?bGNUZ1RFVlNPa2x5ejlJRi9iZHdyRTBlb2ZxdjdodDNXRENRNEh0bXAzQjZm?=
 =?utf-8?B?VE5JVFNJUk5CejUrT3ljemRYbUhVNzVKZjNYY2ZIR2luSjhpeFltREZab014?=
 =?utf-8?B?eGZIeGN6ZTh5TGlXSTA3L2lCU0hCcXU5NU5DT1poUi80dWNtZlFTS050OG9s?=
 =?utf-8?B?TzdXUFVLeVBKRndaMERPcWRpazhMTlgzaGN4YnpadStMQU5VRUVsWDFPMkh6?=
 =?utf-8?B?MlpvL0F3Z2dFRTU2MmpWclBaMmhULzlTVU1WUFZpaHRuMDc4emlrZ21vMzVh?=
 =?utf-8?B?WFl0VGRDRFFnSzNsM3ZZeW01dmdnS05XYmltZU9EZXNkMkZ5aWQ0cmdhdFBm?=
 =?utf-8?B?b3NyS0Vad0xCSDZXSTJGdndVUWZHYUlTWmdXZTJXZ21zbElwbFhKaTM1RmIr?=
 =?utf-8?B?OVJBMndHbnhDNnZZc0RIeGJWYjRnU1J6WnZXOExpbmphdC9iQmR2dExZMFZK?=
 =?utf-8?B?RW9Dck5mYkJCR3krek5rSU1vQWlpdzhzRVppWVhEYzh1dzVZR0hYRm5oMWhQ?=
 =?utf-8?B?dTlPbFFQUko3aDJ6Zm5kK3oxYyszbG5vbjgxeVV4TTNsUWx3Y2JXZVoxYnZZ?=
 =?utf-8?B?alowdUltS083aVZHY2pQTXI1cDhCbm05dHFNQ0ZOK1kzcll1Qmltalppd2hW?=
 =?utf-8?B?NjIzMzF0d2xrdXpYeFMwUDBXUjlvRlNzNldjcHhrM29XR093ek9uUHlzL1Rp?=
 =?utf-8?B?SExlVVBWcC9Ua1NpbHJtZkNpWWR3S2FSeERHbDZQbklnRUdsbkN2YjFoTksv?=
 =?utf-8?B?aUdGMit0R0wvTnJoajVTQlIwR1p6TEpidGZJSFZlcHZHN21PbjZaV2dQeXor?=
 =?utf-8?B?Z0wxcFBmcmdrRi82ZDdRdUtNK0srUHlKb3E1ako2cUFJVmx4eUtqSkFma0NR?=
 =?utf-8?B?ZFpmbHJubm9kR3lrank0Q3E5N1ROcXduM010b3FBQS9iRkd2UnB4UEV3UDZt?=
 =?utf-8?B?MHNkWlBmMTI4NkZEU2Qrc2lxSk9POEZ0NHhnZGoyRHY4SjkyQ3dOMVdyNHlo?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71021f48-ee23-4d6c-7f16-08dc83a9997e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:46:02.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86goQEOCAoWh5HjM8/zpcNn/qQf1uKscqon7PvxnlXc1YSo4KNyIr2kJQkk3xK1FhMZNcDRIkVMbPcEWFyr1ZkIoPuJlmQpbMRTeAr6aSPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-OriginatorOrg: intel.com



On 02.06.2024 16:18, Christophe JAILLET wrote:
> "struct devlink_dpipe_table_ops" only contains some function pointers.
> 
> Update "struct devlink_dpipe_table" and the 'table_ops' parameter of
> devl_dpipe_table_register() so that structures in drivers can be
> constified.
> 
> Constifying these structures will move some data to a read-only section, so
> increase overall security.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  include/net/devlink.h | 4 ++--
>  net/devlink/dpipe.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 35eb0f884386..db5eff6cb60f 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -352,7 +352,7 @@ struct devlink_dpipe_table {
>  	bool resource_valid;
>  	u64 resource_id;
>  	u64 resource_units;
> -	struct devlink_dpipe_table_ops *table_ops;
> +	const struct devlink_dpipe_table_ops *table_ops;
>  	struct rcu_head rcu;
>  };
>  
> @@ -1751,7 +1751,7 @@ void devl_sb_unregister(struct devlink *devlink, unsigned int sb_index);
>  void devlink_sb_unregister(struct devlink *devlink, unsigned int sb_index);
>  int devl_dpipe_table_register(struct devlink *devlink,
>  			      const char *table_name,
> -			      struct devlink_dpipe_table_ops *table_ops,
> +			      const struct devlink_dpipe_table_ops *table_ops,
>  			      void *priv, bool counter_control_extern);
>  void devl_dpipe_table_unregister(struct devlink *devlink,
>  				 const char *table_name);
> diff --git a/net/devlink/dpipe.c b/net/devlink/dpipe.c
> index a72a9292efc5..55009b377447 100644
> --- a/net/devlink/dpipe.c
> +++ b/net/devlink/dpipe.c
> @@ -839,7 +839,7 @@ EXPORT_SYMBOL_GPL(devlink_dpipe_table_counter_enabled);
>   */
>  int devl_dpipe_table_register(struct devlink *devlink,
>  			      const char *table_name,
> -			      struct devlink_dpipe_table_ops *table_ops,
> +			      const struct devlink_dpipe_table_ops *table_ops,
>  			      void *priv, bool counter_control_extern)
>  {
>  	struct devlink_dpipe_table *table;

