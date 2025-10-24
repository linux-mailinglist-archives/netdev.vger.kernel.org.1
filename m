Return-Path: <netdev+bounces-232304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E5CC03FD3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC30019A791D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BE156678;
	Fri, 24 Oct 2025 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxvpABKE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C78405C;
	Fri, 24 Oct 2025 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761267944; cv=fail; b=sMA4F0LskWkbZI4JYNbx3U/a8ShVFfB49SrgxuaU5Mj7je9bqCl489ToLOuMj9MK04R9vj2NJ/zTP8i2SSke2155nd6DN1/oAQy3Z/uERqom8bT9AqrvvB89d8mIGyV0M44+tIRrw5t1aeDuvTA9ceQtXXyzN8bvpk4HdpA8yaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761267944; c=relaxed/simple;
	bh=/MC6RGneJ/vewZaOOwgKwxD3meBU+4Zcn7B8hCetj+s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xjs6cDuon76pgr2EVVy3hUmmgS+vwD7nkmx8C0vVH4L9eZ9NHwAUW3hjRTc1RRbWjU4RJ2mFfzVXW5D17XZef1K6Ds8qrGgYPKVycl8z3NvHR6iMLOCFxf99sxw2U6L97Zs4D5Y9Y75e6LvfQqhvrTZ2Ez1UjIwdGlktc7LN8no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxvpABKE; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761267943; x=1792803943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=/MC6RGneJ/vewZaOOwgKwxD3meBU+4Zcn7B8hCetj+s=;
  b=QxvpABKExteg6AGue2zMnjf0Kj1xYtL7LPNO2PA5nFE0uvg8YnzmTGeK
   XIoOdQyq1IrySdYwsGVXqdbUYvZ7wmBWOB+HlKvbE/DhVQfI1cTZE5NJa
   7xCl8mSFQ7ZFm+zo4y81vBSMqCdK2+fX4Ws6funvT9zL1KpHaTlq96XjP
   pvOCLnTY/52LFLqj21Zfg0ZX8E/3oYWcVMeBeLoGavCu/eh1H5pEVX2In
   MS0Cy/0vT5DYUMoY0VcX+MEkMi4OcrFyA7lt1Xjo0z1BWwoCiuW6kAAYS
   8a+5aQZJm6uWoVmT3qHYbIPgFXfhIDX5AUlqzsPVwZjpUTh6FAH2Ucdw1
   Q==;
X-CSE-ConnectionGUID: 8UGV7KxFQlaR7/DF9x92eA==
X-CSE-MsgGUID: L7WT7NZqQf22c3wLoc8O7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67285551"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="67285551"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 18:05:42 -0700
X-CSE-ConnectionGUID: umQc+ZEoS5uX48PFjmc1ug==
X-CSE-MsgGUID: ses2IDErT+ul9THg09kGsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="188361759"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 18:05:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 18:05:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 18:05:41 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 18:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6IuG++4eh6YDUzdTDSXcIZARXefnsvz7gs3TBwPcKgnVvWybmC4oMFrPiYrdKBY7O+PhVHq94sh3MNbwQl91NyszfgycA35ZlMnW5nvul523LW2aOHhUb3CQsW0/6AqRpKfL+rrIKk+tSDzhdnNalX12JDZuM4dn2fEY/LdyqYuERox9CgSFWzXUncAml99EmeeIJerpLPbAQ876Q47XLZg/Yuax/pPz/ikRESW/GzuNxpqxtyBRBqMf3tlgoymE/rjMhSGR6JH8jUu/kEwxQr+yAxnVEB3sw4LOCUXkVO7S1NixUjfSyxoZtEuGEyjOW8pXNY60u0yIqXhdwDtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyBCO740qjfxLy+Khu2RUXWyEWHqF4GfmELovJie9Tg=;
 b=CGSU+iV/kq8iQtNe1XIsrFyaZm8GCc5Jz0L19EWXyWxnMCD9+1fqbxtltDy4BpkkhjWHE9WJVfPvILWDGjUap1OzoxLQrUfD/AS7HhxYgBjxNghoNKlvDLn9nJZ0YAyc9vpnxQNkUm1A/iuDjD2vDztzSH7PrGeUYL5MdFkZo1q9chtnf4uHcT6IHewitf8Y2hlcF1Ri7Yw70Dux2YDKiGGuwRJbZnN7++6pYCA77g9Z/BsRGNEEr6lDAK0NSIFIunfK31D+6+I2M65r9X1m9/kqdx3BIdq84Mrc4sofjoVTw48d2Zns2uMRiXD+jBAHbaxul03fkrw8daMLneG9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 01:05:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 01:05:16 +0000
Message-ID: <02692f16-b238-49d7-a618-150a03cb1674@intel.com>
Date: Thu, 23 Oct 2025 18:05:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: hibmcge: fix the inappropriate
 netif_device_detach()
To: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-4-shaojijie@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251021140016.3020739-4-shaojijie@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------9Ls4bzJpeIT9NLY85mByJTVK"
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: acff3808-7d26-4894-5f28-08de129964c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0FLd1c1WUQ5N3NHOHVncnU2c2xWdk5VbTNQMkY2dnB1ZDhpNWY5ZFZiRmpH?=
 =?utf-8?B?Y2l0eDRrU20vOEFaellmRUZSQ3hWeUdvNGFXNndiUE1RUUlQSmJQUTZIMnRi?=
 =?utf-8?B?SDZ2TGdWL3hBdEtua0IwOTJaTU5YeDBqWVMxYVJzbTNkdmIzS1VyN1lJRmVZ?=
 =?utf-8?B?NGZtemczY2x4YU5yRklQZ0RtV1M1bjk2VkZERFN3ZkU3clpFNUN0aDJBb25H?=
 =?utf-8?B?bitpKytIelh0OSswTzR3bEZmRFNwMmNQbi9EbjBoUmR3ZGhPUUh0ZHpoZisw?=
 =?utf-8?B?cUdRZCtQQ1hna2NSREg2Q0lqSFhzQjN2UDdtVkxWZ2RQK0RHWEo5aUR0RWd4?=
 =?utf-8?B?RVg2OGVhYTJTV00wTFJFUHNRbXZocWluVUtVZG5SWVpLYVFDNWt4MUMwTkxv?=
 =?utf-8?B?MlZMYlNoMnVOeFk2QzVmOEdaM2JaZFZSOVV3emNqSlhVazdMdGw5SGRUTUVR?=
 =?utf-8?B?bTlIU05jZ3FLRE5yekp5TkRnbWhReDVDTlowbzY3dUFsWDJSSlRpbEFRQmxH?=
 =?utf-8?B?eDlKMUNWTXEwVTdjK1UzZmJyNVlFZyt4djJQMVNkQUpkbmxNWTVkVG1oLzBZ?=
 =?utf-8?B?RVI2UUdSQUhYTWdDQ29mUWNBZ2NXYTZvWnYwWWJpV2N4anVwcXB5VmlDS1BF?=
 =?utf-8?B?UEMwRUJRZzFpQXhCUjBnMjVLbTArZU04djVqOVN4TE9SYzBBM0dPTjNNaGhC?=
 =?utf-8?B?bG9jMTNwNExYeUE5WGR1UEkvb3IxSmRBQ2NSb2o3UEdPZWpMTElKQ0pzMWhM?=
 =?utf-8?B?cG1zUVYxa3JJL1psRlVQbDBDd0loWlhnbVhwTmQrejlzUGcrcXBjRWF4S0tN?=
 =?utf-8?B?TnZ5OXpISk0zaGdVMkEzdkNvM1lJZTEzSGpqVlBQa0tuQ1pkSE8yWUpmVGt1?=
 =?utf-8?B?TGhYQWZFcU1uaDJKenZCemRDOCsyUU9HdUszZ0VXQ3VSeENUTWxBdXVOUThl?=
 =?utf-8?B?bXNScHJ3cDhvV0FQZys4NkFkVDBEUjZYd3pmRTVCTWMwM3hYUXBtRVkvSFpS?=
 =?utf-8?B?UGw1MGkzWGhqcGxVWk04VDFVNXd2RzFqVi82K2l0SVlOWW50b0FUZVRRY0ZQ?=
 =?utf-8?B?QXhOeDVaZFdDSy9uSzBjZ3JnaDVsdUxpQ1ZjOHJ5Y083Vm9kZGJLS0tyUk5y?=
 =?utf-8?B?Um0xak1sNlZlellwTUdWQmlYQ2Q0UVBMQUlNYmtmTUpYeW9ES0g3Vkd3M1N1?=
 =?utf-8?B?R1RRbUxIcmZHQWxIRlMvZ2s2MytsczBCbGg2aitFSUZIa1B1RW9Cd0tUdk9R?=
 =?utf-8?B?aEVSVlRYWFhwa2g2Zk5jS1dGSXh0Z3FwWEZObzVKVnJsTlZpcVpNUTU4Zk1B?=
 =?utf-8?B?VWQvSUpmNEh1VWNhck5nVVQyTytVQnEzR1dNSXZ3S0g5VTVZRURncTdFeXZ6?=
 =?utf-8?B?SWdpRmVtMVdyd2RJaWJYeVdIYlJVSDlpWVdsWWxQRC9LcFdsaVRlRm9KcWYz?=
 =?utf-8?B?S3VWV1VGT0drQ2J6a3p4N3grMVhlTVU3UzFWblZqMWg5WnZEbHErcUJCTnBK?=
 =?utf-8?B?N0g5eC9pRWdSRXZKaWpIUVVHTVp1eTV0ZEVuS3Fpak10a0h3bFNBNUR2cmhI?=
 =?utf-8?B?K24wWDd3SGRJR3VXSDdJdkZNUUNETlRPT1dpQnpmWCtXQzdzS1RZOUhLYUxn?=
 =?utf-8?B?YjdvbTF6dlJPTkI4WkRrS3dIYjRQR201UTNkQUhDNzJLcm9qZFYwSXRMdWtU?=
 =?utf-8?B?aXBwWDF3WE9uWTBzV09hR1dMNVpjOWdkYU1DZjJUYnB0UlBsaHhFQ2NXbXk5?=
 =?utf-8?B?STRwQjhoYUNIT2NTSzAyM2VtM1l5aUtmY2hycVhyYWx1dzlNNHc1clQzU2ZL?=
 =?utf-8?B?c2VLVk9tQVBGK3lxbkNrbHo4Z0VPN0JZa1ZYSFVpdnBOb0R1WjhPWXN3QUpW?=
 =?utf-8?B?endaaytoTU5rdWR4cEFkSURlQ0s0WWRFd1c0dXEvMGpONW8zYXoyaEdIcDJI?=
 =?utf-8?Q?s5i4oMX1CAUHm0PYmDa3hy5MiaRAbbdi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellHdzFjRGJmVCswOUdwZGVNN3ZjSndWL1NkU0hianY2RnNYS1VoSW5VS2Fi?=
 =?utf-8?B?dnUvN2FINFVhSGxuRCtMbWdtNXZEK1JDUnYzbWE2MVZpcHRwYmxHNm5wcE5W?=
 =?utf-8?B?QWtMYm1oWUpmZlZGQ3RyK2pLamQ0UEF6TUdzSExyTUpsU0RXNlJpWnNZZzBY?=
 =?utf-8?B?dmxpbktTa1c2UnlZbElBekFmWmNUTTlkMVZoa0FhdXlyYXhpTzRtc2RrWG5w?=
 =?utf-8?B?K1hyaDVnUzRtc0dyd1pjK3hveUpaZi8vK0ZCYW9oaW5GMmF2VDFZUkE2NGVX?=
 =?utf-8?B?NVF0RmFNUERETStoR0g1ZmlTemdiSkwxelVqcVRiK1ZObDJseENNS1VEUTVs?=
 =?utf-8?B?VENiMlliUm1pdE9pa2h1cDM2RVdPZk5rb3hBdXJtOXcwbjV2OUtQL1VrL29C?=
 =?utf-8?B?OGxlWTUzbVVtS05uenlBT1JLMzdqWkQ2dWU5dU5SOTUxK1NvWEtOQUEzaDB0?=
 =?utf-8?B?Z0Y4M1c1elBwMmVHcHVOWGNBaTVUenJWNVVBUVVYMFBpVWVyclBXVmFoRDRW?=
 =?utf-8?B?UnVUOVd0M2RNS0hiVTcybElXRG1zdXNYZlo4RlgrVE11cjZDd0hLV1lZMUJj?=
 =?utf-8?B?UUVlK3FyazYwU3hDRmoxZU04SS9vWnZxK1doZnpGbVNOSnFNNVV5M0pwOW5l?=
 =?utf-8?B?eDd6ZndEWFV5N05xVFVrV1pYQ3RCem9QeDdCeTBrOGhUOC9FMnYrYVc5T1pH?=
 =?utf-8?B?MCs4aG5Vb1RGM0lvT0d6aUFLOGNuSjlTWnEwOENSMTYzZzg5WW5pazNTWjhZ?=
 =?utf-8?B?U1lCeXloZlhndHR1WkVLM0MrZ241U0lLL1NBQWszMjNseXpoNUpxcEhSNkpQ?=
 =?utf-8?B?N0phMlhnS3NwUWdTZjV1ODNQNHVVMjd6aDVONnNVNnc0b0JaL3FPQnozcHEv?=
 =?utf-8?B?YnJZdjhkZ0tVMDlKeks2bDRzb3R1WVdoRGlGd0hPUEZlamRpSDRCbHJRME5r?=
 =?utf-8?B?SW1nZUN5MW9FTE1id2ozSi9QYUp4ZFkrL0ZsRTMrZ09qRVc0N1JPMjVtWmZJ?=
 =?utf-8?B?VFJlWVEzNjdSdWRvOUwrZG5PZSs3Mm9vRndnb2FxcHorZ0VYc2M3eVQ1UDJa?=
 =?utf-8?B?QUVXV1hyLzRVU09jVTZObkt5U042VngyczlIaUJwY1E2czREWS9IZVhnc1Jr?=
 =?utf-8?B?R29mU3pnOUx0QngrWEN5MFZzRVVWOU5WY2crc1BZTVRNeGwrNG83YUprUkJD?=
 =?utf-8?B?UloxWjhhT3RqYVd2ekgzOVRlMzMvalpLYlIwWXZhWXkwczR4dzBHTThvSEk1?=
 =?utf-8?B?NDBWSVRSYmlkN0phTGVaOHV4VXd0b3d4bUJoREhjbHhyZ25VTmhKSVA1aDNK?=
 =?utf-8?B?SVJVOWZmYjN5cit0NkdUUHkzK2xhaGdMZG9QRys1TTd0TVJtSm15L2ljOWNR?=
 =?utf-8?B?YkFzYkVFSnZFeE55RnI4enRjTE1aWVlYWmxPNGZ5K3lrSU9PcW50aXNOZ1lV?=
 =?utf-8?B?aS80QlFlZG1ucURyK2dHRm1XNzJyT3YyMWhBRU1pZFBpWGlBQkZOMWN5dWgz?=
 =?utf-8?B?RHZJZ0tPV0xOYWVvdWNzbURxbHhBNStCbFQ1WC9vNFhyMjUzWDMrdFFXMDNZ?=
 =?utf-8?B?V0NXOVZGaUdZY0lxaG8zLzN4NUxNLzVYNEJaUUkxUElGZGtuSDlrd0hqaE9I?=
 =?utf-8?B?TVpXQ3NKVkluYytkcTBkRTNsRHZ5eGwwbGRMODdHSy85OVpLRmpES0V0RWtG?=
 =?utf-8?B?NkRhcmhsa3pScEZEdHg0dEZPTy91R1N0VTIvRSs3NWlLRFlvZG9qcDR1bDhU?=
 =?utf-8?B?NEdXYk9UbUVWRjIzK1lUR3dXb0tHcHd5dlFVUGViZ1JuUU1HM1hSZ2FWSmNQ?=
 =?utf-8?B?NjZVVzVoYjlRQ3B3dnUwcnVuWTY2WWppRWR0SXNST2syeCtWS0NnNzJrcUhp?=
 =?utf-8?B?a1VDUUVpcEM3UFdwMUh0WlhhUHVsemlweGEwUVRzT3RvaStySTRMOUhtR3ln?=
 =?utf-8?B?c2lRRFY1T3lEOTJkOTg3RlRQclVBNDF3M2l3SVRmSXZUc0ZzcEVZR3Z1K0lw?=
 =?utf-8?B?TEZiYXZMOE9LWUZ1V1gvS3cwSTEvWnNmOHY4ekZYbVljQjJ2R3Y1ckFhRXZ2?=
 =?utf-8?B?SEFRZ2VFUE5GY0xEaE96aUtpQnYrOVBLY0tmdzFxS3ByUU9iblhzNjByZTNZ?=
 =?utf-8?B?cit0cG8yOVBobjV3cU1OVjBnSmhzOVdTY2hURVFjTzdsOE9aSW1sOXMrd3h6?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acff3808-7d26-4894-5f28-08de129964c9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 01:05:16.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbBe0bQPq9Xva0erhzITeDzlFQzseehnFIm1yileVS8lNH9sy4y/XRdfn8eiN2mG3PimbvPcIiyHbxWfoLjFdW1BYCATItjUKgWA906yjww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

--------------9Ls4bzJpeIT9NLY85mByJTVK
Content-Type: multipart/mixed; boundary="------------ZYawA1c5wiYQJZKx76KgJ6FP";
 protected-headers="v1"
Message-ID: <02692f16-b238-49d7-a618-150a03cb1674@intel.com>
Date: Thu, 23 Oct 2025 18:05:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: hibmcge: fix the inappropriate
 netif_device_detach()
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-4-shaojijie@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251021140016.3020739-4-shaojijie@huawei.com>

--------------ZYawA1c5wiYQJZKx76KgJ6FP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/21/2025 7:00 AM, Jijie Shao wrote:
> current, driver will call netif_device_detach() in
> pci_error_handlers.error_detected() and do reset in
> pci_error_handlers.slot_reset().
> However, if pci_error_handlers.slot_reset() is not called
> after pci_error_handlers.error_detected(),
> driver will be detached and unable to recover.
>=20
> drivers/pci/pcie/err.c/report_error_detected() says:
>   If any device in the subtree does not have an error_detected
>   callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent
>   error callbacks of any device in the subtree, and will
>   exit in the disconnected error state.
>=20
> Therefore, when the hibmcge device and other devices that do not
> support the error_detected callback are under the same subtree,
> hibmcge will be unable to do slot_reset.
>=20

Hmm.

In the example case, the slot_reset never happens, but the PCI device is
still in an error state, which means that the device is not functional..

In that case detaching the netdev and remaining detached seems like an
expected outcome?

I guess I don't fully understand the setup in this scenario.

> This path move netif_device_detach from error_detected to slot_reset,
> ensuring that detach and reset are always executed together.
>=20
> Fixes: fd394a334b1c ("net: hibmcge: Add support for abnormal irq handli=
ng feature")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers=
/net/ethernet/hisilicon/hibmcge/hbg_err.c
> index 83cf75bf7a17..e11495b7ee98 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
> @@ -136,12 +136,11 @@ static pci_ers_result_t hbg_pci_err_detected(stru=
ct pci_dev *pdev,
>  {
>  	struct net_device *netdev =3D pci_get_drvdata(pdev);
> =20
> -	netif_device_detach(netdev);
> -
> -	if (state =3D=3D pci_channel_io_perm_failure)
> +	if (state =3D=3D pci_channel_io_perm_failure) {
> +		netif_device_detach(netdev);
>  		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> =20
> -	pci_disable_device(pdev);
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
> =20
> @@ -150,6 +149,9 @@ static pci_ers_result_t hbg_pci_err_slot_reset(stru=
ct pci_dev *pdev)
>  	struct net_device *netdev =3D pci_get_drvdata(pdev);
>  	struct hbg_priv *priv =3D netdev_priv(netdev);
> =20
> +	netif_device_detach(netdev);
> +	pci_disable_device(pdev);
> +
>  	if (pci_enable_device(pdev)) {
>  		dev_err(&pdev->dev,
>  			"failed to re-enable PCI device after reset\n");

Here, we disable the device only to immediately attempt to re-enable it?


--------------ZYawA1c5wiYQJZKx76KgJ6FP--

--------------9Ls4bzJpeIT9NLY85mByJTVK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPrQywUDAAAAAAAKCRBqll0+bw8o6DYw
AQDmI7+zcBmWNL9sXFevgrQ0JqWST29VXWJ3+b92yGuM+gD9F+8ip4e3FFPAJuQxhiRP3HLpF0wR
8chZ+PLyHEqUTgw=
=QNv5
-----END PGP SIGNATURE-----

--------------9Ls4bzJpeIT9NLY85mByJTVK--

