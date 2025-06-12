Return-Path: <netdev+bounces-197120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6A5AD78D2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 19:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A353B5193
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04329C33E;
	Thu, 12 Jun 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xwk4EeuH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC229B8C3;
	Thu, 12 Jun 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748748; cv=fail; b=hQG3OFB5BT9HVwYONk1jjM+ivfRkC8WkJ6SJIuFJBok47dVdujeALoBEvn60A8qLyg6yY2Tnt3DaTcFCdvXHXktr7WFGXb5yqbaPJfrHYBhj0sCdWO+Cz5uFkYTNMSRnAXNzEVXQzm/+zgWKLTZ6eifKa70PcrU0UtouvyHS93A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748748; c=relaxed/simple;
	bh=MewSS7qOBKzC1+WhRMld5GGMskixxpluGIXqn07H0Hg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IG0SizwOQhn19di/Lj2uuGEhJ1OpBR468oX6sY69AAktRzCTYgdDuYRQ+qMpV+MPpzJ2dziGaRQPyy8AMNQ84YKmrEcf3BqaYDYntPP0DYvQPzPdP5qR9oFwglIVZspleC0O/LN/8bBECqhDRb6c9/ABaobfwMUO+wu1xXQfcqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xwk4EeuH; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749748746; x=1781284746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MewSS7qOBKzC1+WhRMld5GGMskixxpluGIXqn07H0Hg=;
  b=Xwk4EeuHAs9gQs4XQexibQZDkRT2O5PqwUVe//rCc9J14vflWCN3rSmR
   ZfXmiKpgys8v/xZBeRobRjwMWn8Htn+sNTudi1wR4aGr68yqcxZGerKGF
   OchMGQEKELsQ4fiAwVFhGFmS9/ib6g1HNW8agDFiHJDdM8zI8J702tww5
   4pMiXNkHAr/oC3PsgFuVAEOAR0wo9op9WJjH9585Z8JWzXRyfOJox8Bj/
   D4ZEmN43rKhDvbjuUPwPS6kEIrV7eII3wJaw7b5+XIk8ZEF7dr60vK74c
   LG6IZ/v2CWvTqTLgf9xuy8Pf4flALXJDfoeM59yh6vjqFntMIu0b8uDPJ
   Q==;
X-CSE-ConnectionGUID: xq3YNdhGTZmt5EsEslRv3Q==
X-CSE-MsgGUID: SBLiRC/ISJqFao1ffdhzuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="62596155"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="62596155"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 10:18:59 -0700
X-CSE-ConnectionGUID: Vu+4aolwTiSVFFIg4CZ8Wg==
X-CSE-MsgGUID: YK5hGD0pSqS7Y9WZvY4sbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="184827129"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 10:18:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 10:18:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 10:18:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 10:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZOCSr6pLR8XEUK6XH3dYP5hwXKWg7lOJtrcsT9GDtBNootpskt0xiuCeoC4v0QnV463WQ9jQEX7vGqDt6GbDVKn/EYIRHSADMx+x5EyvFzuQwsLQUBx0RkGVddbaT6aEt/iX9xWuWbEpGfotiimnSKUvO0FgZqfTL94XqLZc8MQ31znOcEth9De+IZ4YiyzWysNmts5fXCieQzGFVt9WbXbu0uX1E62ozmMm8K08VETMuu9b/CmwnqwV7Xy70B/3RTQ5Tb32MDK7BiZF8+yNH6hVNtIl/9aPx/ee9n+ETWwXABuq6GTrMKWCNRIGpxipA/Nu56EX63RKkfezgby0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40L13ZwBR4ZZSL29Czvw4rb1mboMdIp4uznbpbVvsWI=;
 b=OuR4LtYU7YJxYELTC454H4dYh0Sa1AQzgghG0d8MLAtWSbVdrlAszjrzZ3ISbtU4QautwSN4sQqe84c2AmBlKPDIAbCTtILO12lawdeAgOTis7IzEEbttzas8Vp5VdbLUOxO/L5qU7TDTatNehJcWE3DzKwCU8IkZKrLU2L3mQ0vEiKp8ahXEDN1S4gZGJk+lb2vNKnCNza77GhXj7zroRj4SYuzP/uj2LQOFmn0+hU/H5tzlBazum9BTMLAUvC2cQnwPQ1JEIothK97RukYo70vHY89y4N/Kqr7U8ouNPhblBnEahUd91bhPAopd8FEN6wb1AK9KE/Ez13bNmqyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA1PR11MB8426.namprd11.prod.outlook.com (2603:10b6:806:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 17:18:51 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 17:18:50 +0000
Message-ID: <ede97506-e6ce-4af0-8c2f-19cd1987ec97@intel.com>
Date: Thu, 12 Jun 2025 10:18:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: net: sysctl documentation cleanup
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <corbet@lwn.net>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.com>,
	<linux-kernel-mentees@lists.linux.dev>
References: <20250612162954.55843-1-abdelrahmanfekry375@gmail.com>
 <20250612162954.55843-2-abdelrahmanfekry375@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250612162954.55843-2-abdelrahmanfekry375@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SA1PR11MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: a04e8093-4ba3-4370-0cb0-08dda9d532f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blNCMldJNGdJSmU2WU1LR3RjaFE4b3pLRU9OTDU3amYvT0hrR1k3SjdpM1Bv?=
 =?utf-8?B?M0RkUmU3UzlXRUJPMjNKa1BRanVrZlRUSFNxNTAvcGI0L3V5ZDNGNXBTRUR1?=
 =?utf-8?B?M3ZNN3RTYnk4ZGl3TDI3NnVWU0lEK25UU3gvRURjdmJ5VHlhdXF6dmtqRlRp?=
 =?utf-8?B?QUVtNHdTek0xdXYycHcyK0dITCs2azJqeEF5NElZalFTbGJXbmVoZHJDdnk4?=
 =?utf-8?B?bmZaa3YxN3BkWk5iRXNrVmNKMWM0T255MGVnWmV4MCtVOTNBbE90QnRjdzB2?=
 =?utf-8?B?U1k5blE3SElMQi8zZXJhRGxFRkFFaXpuN2Q5TGt4NVR3MkhOUnkzRWZRMWJ1?=
 =?utf-8?B?SzNBNGhRMk5odXUybkVLUlNvWVhZSGdTejdpZHRXek0vYVJ0Q2pWMDFlQSts?=
 =?utf-8?B?M2JneEpKaHk0RmpGS29sVzZsdmQwV3E5K2ZjZTRyN0tST1pEaVRGSU5ybS9T?=
 =?utf-8?B?V1BEcXNOV1dxMjY5NVM2Vng5M2loeGp6TTVXZkE0K05SNUVzOGVIU0I0ZVhx?=
 =?utf-8?B?c2JTZk9MWHJhc2ZhODVYMmVORHFXTjM5RzliNGhGK1BwcEk3cGRmN0RPbEJQ?=
 =?utf-8?B?eVlGeWV6UUptQmRWcHJSS283SFluT3RaTFk1UnZ3c0loTDlxL3ZQL3dNK0pP?=
 =?utf-8?B?REFOOW9OTXVhNS9ZTHFvYWEyb2RDM3Z3dko5UFNndTIyRXBybnJXOTNSOEEv?=
 =?utf-8?B?ZjgrRTVjanlGRlEvZHJaN21rb0hTVmxkQ1NiSTBjblNoV2hzZXZCdS9aZFFO?=
 =?utf-8?B?UWZJNjJicmlkbTAzTERrNFpZUXhmdnMxYjZKRlRLbElwSlp6dStHd3dYT2dF?=
 =?utf-8?B?R1ZubGhqdnpiUWpoUk12L3ZBcW9tNldVbWx4bUZyYk5RQUFhYm85TzVuWlNy?=
 =?utf-8?B?dlQrRnRjOEl2WWZhQndKbmlQb2dwTUs5S2tDcTBMZTlwZXJQNVNYcHZIa1ZV?=
 =?utf-8?B?aGR0RWEzY1NJVTQ5dGk1K0FoUVNJK2U2bURBNFRFRVBsYU1zcHg2UDZyUzMr?=
 =?utf-8?B?Y2tMYU9iei9HbkdlVjdLOFRtQk9VZ2RVbHZXOUoxckRiSUhGWmIxY1h3Y012?=
 =?utf-8?B?bzkweHVRREhrL0JXaS9PQ3Ayb0NneFdCMm44dXVJMXVQOHREVjNUbWZMam1t?=
 =?utf-8?B?VS8wRER5bW9VZGJ5YmxiQ204YjduMXB4WG9MdUdyNGVET2lQcXg2dnUxZm5Q?=
 =?utf-8?B?STNlbGJOSkJNdklJaEVVc3EwUDRtUDRLQlV5RXNSV3RLbUoxVFI2MTZWVTFn?=
 =?utf-8?B?WUNYSmxiTjRzbjBYR3dnK2VuTUduYTdpSXlrd1VQTEpDaUtTNXJlNGRmVWk0?=
 =?utf-8?B?MnhZdEVOcHlXQnZKZzVkNlZibFBJU3BWZFM3bWo5VXZyZGNmODY3YVdoK0hO?=
 =?utf-8?B?OGpPRktoMWV4dmcyb2Z5cnVpaXd1TEpOUm1FL1BNckQ3N0k2YUUvTnVqVUJX?=
 =?utf-8?B?Ri9WcFFFN2JLeTg0RzloU3hsUmFWZlJxNjd4V3VRNUs2TkNwdHpKZ0E2MXM0?=
 =?utf-8?B?bnlCOVpjM1MwK0ZuQkRjR1Bic052YklERVd0ZHZGL05KS2FRMHhoL2N5dFdR?=
 =?utf-8?B?MEN6em81NDltVVhpYjlSMTdvZkdYSU1rQ3FSbnR3RUE1bEtucVliclkrN29v?=
 =?utf-8?B?MDdQNFlMclVzb2dmNW1WdDJMSGRxY2ZJWkxadmFTc09wbkRVTG56ZkVKbmRJ?=
 =?utf-8?B?OVJaOTRaUTVFRmljK05paTZQaHg0cUhocVRGTklYR2l2Z011R0RCNkVCTEFz?=
 =?utf-8?B?ZUdxaUxCL3NnYzRSaENpWjJML2VSUkhuRDM0T3p2b0dNZ29sQ2VudFFBc2tJ?=
 =?utf-8?B?V25oSDRvQTJhTTdMYzhvdHJKYzltWGZCenIrMitFNkZINkRxYUN3UlpYYUtr?=
 =?utf-8?B?alk3d3FpZndsT2VrTVU5ZjdjVDZXZDB1VCs0RDl5N0VxdC9jc3Y5ZStXYi95?=
 =?utf-8?Q?ObX1C5+fKSM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGV6YmtrWG4wWGFMVHNBei83WHdyLzlaaHR6aVNMdmhEaG5qck9nUTBYSWNW?=
 =?utf-8?B?ZDQzT0ZGbGlwNGRPMEJieG5pNzB2eFFFYWIwR2NNWWExMTZ2aGkrdEkwd1Rp?=
 =?utf-8?B?UG1XRDA0NjQ2K2Rxd2cvWjBkdEFVYVZCZk1NY3NvNEFKOFQ2K2I5SzdlR282?=
 =?utf-8?B?MTdkZWJleVVZZFFHVGV1ODlaU0doL0tIOVVyWmZnYmNjanF3SjBBUG11TXJX?=
 =?utf-8?B?L3Q4OTYvamFkekNHaE9XV3M1Rms3SmxvSVhTUThhZENzVzZEUDZ6Z0RML09X?=
 =?utf-8?B?S0ZNeHJwWDltTmM2a2gvcGw1SzFRMytXdHd3dnB2THVKMjlNQVhjMEUwTFJz?=
 =?utf-8?B?c3ZGMmhKVHQ4VmxKWTlTeWtOeTc5R2ZLaTVsTkVvV0tGM2UvUmdTSHowbUpr?=
 =?utf-8?B?VUpFdll6QitlcXA5eHFGTU5hTXBuMzE1ZmNrWFBleUpPbUUwSEZKRTdHVXJX?=
 =?utf-8?B?a0tibW9tbmN2dHNKa3EwaFRHZk5aTWZ3Ukg0SE11dnQwY011c1J3Z1NZMGN6?=
 =?utf-8?B?eEZmU1dpdllDUWZrUlFVcU5PNUlCSFV3eGM5RHdFcFlvWTFYajNmSHV3Q0lH?=
 =?utf-8?B?Rk4vcEljcjVkS2NvNFcrbGZhcFRuaUl3bDl5RktHZFBvRkFBUDkybXhOaHl4?=
 =?utf-8?B?WXZ6ZFlmT2RTeFRNb3orajRFQVNpdVdQVUp4TU84Qk01T2pGbWZtQXVweDIz?=
 =?utf-8?B?YnZqaU5SRzV5RGdNdGVSbWlNWHRheko3TnRNOUJ1c1JNNXk0Uk03N09QRXd3?=
 =?utf-8?B?TVc2eTNrV0JGbC96WXpGNHZQOEFtMXBCQ1dOWlNZOGcza3phR1luQkRwMjc1?=
 =?utf-8?B?cWlPNGNqWEZLbkJiZlhTRnBndDBnYzQ4aGZKaXZQcGJUdUxZZW50aGQ1aWl6?=
 =?utf-8?B?N0oyZG84Sjl3eC9LT3pTcml3RGdJOWVpT1dmbGhoMEhjMVB5dUV6ZHp2Smwx?=
 =?utf-8?B?elVHbVBkelFmQkhOQm1kZHU1eXgxaTlmOUorK3p4VXNINFB2RkorelVFVHlx?=
 =?utf-8?B?UDlISHF6b0owZ2N2THU5Ym41cXcwY0MweXNEaTNvZlU2cmVWUTJRcE9ua0Vm?=
 =?utf-8?B?NWVJSEJqZnpScmQvc2lDRGZ2MVlCbWpuWlVQcndnMjZ2VVVTT1hMaHBpVDU0?=
 =?utf-8?B?WDlVMFlMY3hzdCsxd2dtL1pBNzFhWVhxb0hFbDYwYlNoSUxXYXo5ajZLc1N0?=
 =?utf-8?B?dFArTGdoSkJ4cGRQeGJzM3MzZk9Wd3d5VVVQOGNITzAxd2NGYjN4NWRFcDZq?=
 =?utf-8?B?dlhUVHd5cnRmaGJhM3lFQVpUQStDM2hQYmdvYWllc0FXZk8wOTlpM1o4WXRs?=
 =?utf-8?B?b2JwUlJqUjZjZTVZd3lURGNaNHZRTUwrWUZaK1MrQTZ2cis5VG16WU9hZXB6?=
 =?utf-8?B?MnB1d0xjb3hQbnlIUFlsMkgwUktvQUsxWG50QUxVekIxdStRUlkyYURKRGZR?=
 =?utf-8?B?MjBiVWtKTFhKR1dEWUp3bGZldzZwZ3JjNjBxOHl3MGlsYVFYcUZwZDA2eGN3?=
 =?utf-8?B?NHI1dUx3clY3c0VWV2xTbW5uL0FJdWRRWVJCcVltSE5GNTFuVFVwbk1udVV1?=
 =?utf-8?B?U0QrTHNJdDFkUkhwRzR5Nk5kRjJJcmFtL3EvQU5VaVNkMm5ZbmlWdXUwQWYr?=
 =?utf-8?B?Q1NoMFJoVGtOK0hNck9GSHh6RkJZUjRSbm5jWVhFNGc4STlwdFF4eGIvWjN3?=
 =?utf-8?B?MS9aL29WekI2UXo2K1h5Z3pzaFZWUTIvdWhkM3Vza0RjS1Nxam02M3ozR0VH?=
 =?utf-8?B?T1d5ZkMrWmRieWxJWHRZdHVZUzR4T2VuOWNBRU9VQ0c5OGZCaVUrWXRQMWtQ?=
 =?utf-8?B?ak1yUWJpOGMxZVNtNTdHYjhlU2Y4YjNyaHEzS21wOVQ5V0N6azR4U2lSdzZL?=
 =?utf-8?B?QU9VYzk5eGgzL1lJdER4bjVjK1FzaVBMcUt3d0JONHJVT3J5QlFKT1Vxb0Uw?=
 =?utf-8?B?OElGL3JmcDdTeHZWNFEvY2ovLzdPbHpQVEpjMk5JWFAvMGxDMks2bVpUZzRN?=
 =?utf-8?B?ejlOSWd0MEo4TkFId0hzc29IaldTT0wrNlhuMHhNa0NYYmwxRjI0S2FkRDRS?=
 =?utf-8?B?VlRpSFBZVzB4SjI4U3FFUURkSlNPNlIrMnh3ZjAyWmNyaVdGNzZuUkE1bzFS?=
 =?utf-8?B?VjhjN05QaXVEMTZLTXE2bG42WnJaR1RPL3FSaDZYQlgrZlljRkdCbnd6clJl?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a04e8093-4ba3-4370-0cb0-08dda9d532f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 17:18:50.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svRxdfCBC0mrRFbLIcvB3xDtZSs9s9KAq+7jQDitBOtrTwpOFw8lllaDNIWXay/b3O18o1BAp1G+rRu+ecyVbvc9BXKaAbDK5mk5H/7x7Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8426
X-OriginatorOrg: intel.com



On 6/12/2025 9:29 AM, Abdelrahman Fekry wrote:
> I noticed that some boolean parameters have missing default values
> (enabled/disabled) in the documentation so i checked the initialization
> functions to get their default values, also there was some inconsistency
> in the representation. During the process , i stumbled upon a typo in
> cipso_rbm_struct_valid instead of cipso_rbm_struct_valid. 
> 
> - Fixed typo in cipso_rbm_struct_valid
> - Added missing default value declarations
> - Standardized boolean representation (0/1 with enabled/disabled)
> 
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---

Thank you for the documentation improvements! I do think its a bit more
clear to include the "(enabled)" or "(disabled)".

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  Documentation/networking/ip-sysctl.rst | 37 +++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 0f1251cce314..f7ff8c53f412 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -407,6 +407,12 @@ tcp_congestion_control - STRING
>  
>  tcp_dsack - BOOLEAN
>  	Allows TCP to send "duplicate" SACKs.
> +	Possible values:
> +		- 0 disabled
> +		- 1 enabled
> +
> +	Default: 1 (enabled)
>  

Would it make sense to use "0 (disabled)" and "1 (enabled)" with
parenthesis for consistency with the default value?


