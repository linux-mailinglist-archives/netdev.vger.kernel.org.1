Return-Path: <netdev+bounces-140536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F719B6DC0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0F01F221F5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375A1D318A;
	Wed, 30 Oct 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KARho1up"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886E1BD9EF;
	Wed, 30 Oct 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320499; cv=fail; b=BKY7Tz6I8BSE0lPC/pfKAvEIUm2hOdncRMuH9BAikS+4ylD6nq2sWFUjPI451xdV+vs9kt9Shx2x7pde/HgLVFWLpMzvkauK2JCwzHB/mCnK+ifMOkNVW57S9ogzPsGC+0G6mP+a6myhLurhmkcrfz6O6LKIX4bMAfyHWEoB7kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320499; c=relaxed/simple;
	bh=AsgvAKy41EwgHdE3viVafHi5t7h96oJP4Wy/6u0PxG0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZQnbP6WsqEHo7Q3CleOjVXh2u4A8VHmkCti9Cn8XCB1m09mghUS/Q8sg+fnpA+FUndZswZk107X8830oWgCAr6l2Z86whPR8vLh1u/IS9iXNWucZUxxC34BvxeCNjaAqoFowdxn/ydtpyBde5/lLBgjHNCazOhMzQNMa2YvqJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KARho1up; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730320498; x=1761856498;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AsgvAKy41EwgHdE3viVafHi5t7h96oJP4Wy/6u0PxG0=;
  b=KARho1upQbxqEHvrfkzIBmHsb5JA9PdzNvQKxnTl/LJtsohpb3qzEWcI
   W8bLUNK/i2RTD6KXRjm3HuG7hz2QgC9h18ZuYxXIy4X54msQGh2UcSnIJ
   ExLYhc0npnYEtkQGJTa23NiYTh54qWa0a0/LqAl1DRFAR//A4sUfjA4yN
   i9dhk3SfT2RjKWHVg/ScuTY0K99aTk2Hb1gsPz3S3lbjUk1yB/PeuOabz
   uhqmPQq2omZoaoD/W83tx7MbDsZROZvztl/Hekhptg0c+eU/sg2ElH5rL
   WvNqnPUTWambo3v3kCW7crXVhgfnS5ltX7M9ErywIwUrxM2ixMSh1Y7d6
   w==;
X-CSE-ConnectionGUID: x31Vy1m7ThqnS/1I6Befuw==
X-CSE-MsgGUID: 4WlZ5oXESXqu+DwuDgZ6Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41413231"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41413231"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 13:34:57 -0700
X-CSE-ConnectionGUID: 8o0WsmNHQ9mHpTfTWQv35w==
X-CSE-MsgGUID: pd2MVULySGKJ6sya3MVYvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82341859"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 13:34:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 13:34:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 13:34:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 13:34:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks8azwEYhG/ACSxtA9QRIkzJh3STlF1eQYiSsV55bfzH5KQXpio2XEJWoadveqSRmChmGIFlNxyfkKdJeDgdMKpug2zrqGVDDehO1E8oSg07XM5xeWVGtWruS/j1ZxBb4Aq2DjlfWZtTM/sFeD7YMkzfnOn5c1FabpvwMfKMBfn5K2j2stjPCGUBv3Q5Wj0EwVmDHm0ulBTDTUGXg7XxDTuLxV3i0k+RHEWwjWQNjCAYUbNh1zf0dJxIgcDv3/AuJ4iKsG9q+ATA01JzSMBJmdWjqQ9MbAzy9BbmaU8AKKYI24DfxBemh4zNsOcIxzumiF9GwCTKdEkOuqB9Dzf7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT2lo89W6Tt4QR+zfKPImissGXgbBHH0HsBAeUQr9wE=;
 b=XEPHiXYef+uwHG6iVRpSJt/yas+LqDxwTLB9qEEv9IXmzrGfjXlw6ES7PRKLB3wRFbOo++fHeTh9UqGiTtOkGUc5JqrGHOmOeedJ8S+X/Zo6chnc08spdqSQNjLjKR7niEIzNQ9EKLpsoyqIdTDa+XRmfVqhOWSpTvSvri++2dGXWeIXH0IpWI8rvJ8CspIFxP41Ov/e+RCY6QHxqRkMR6/FdoDffBni6ttzNCQfN+O9nMj8cD+PkWfsiF/ewCXxbgsciISmpoSvOnp9G4xHPYzo7/2IH1c4Z9iSMkZxOuYDxSvJZn6IbAqAXhhlUe7cf5wTyQyDhS9V0wbiK+PVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 20:34:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 20:34:49 +0000
Message-ID: <5ff708b8-1c6e-4d53-ad64-d370c081121a@intel.com>
Date: Wed, 30 Oct 2024 13:34:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Daniel Machon <daniel.machon@microchip.com>, Vladimir Oltean
	<olteanv@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>
 <20241029145011.4obrgprcaksworlq@DEN-DL-M70577>
 <8e1a742c-380c-4faf-a6c2-3fa67689c57e@intel.com>
 <62387bab-f42a-4981-9664-76c439e2aadb@intel.com>
 <bda38b6e-73df-4ca5-8606-b4701a4db482@stanley.mountain>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <bda38b6e-73df-4ca5-8606-b4701a4db482@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY5PR11MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb6a391-f591-4ccd-994e-08dcf9224c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2RFb1VXeEdYdDFCSEZGQitCOWJZaVJDZlRsUjQyd2ZQK2RTODQ4MWZ5djlO?=
 =?utf-8?B?VVdVcStncld6RnMweHE3eUt2LzJQajl2ZVQvT3c3dVJmZE9UWHV0ZE0zY29v?=
 =?utf-8?B?KzRObGV3Y29yNG14NlZtWEc2SmFOTGV1dEdwaTlaN0I5STlLckQxQmlEMW8r?=
 =?utf-8?B?Znl4dnlBSktuMjVzb0ZYVVlKNlQxajVOU0lkVUhNekdBRjdzZmJtRm5LTUtx?=
 =?utf-8?B?RFloT1Q3bnU4L00wcktNc3VmRVdPdHRSYlU4S2R5WWVteVQ4d25oc3N2Zmwx?=
 =?utf-8?B?dDllUTdHRWVicXlUclVBUVFONmQ2UEtrbkN5eGpPZFFidk9IbWQ3cCt4NlhK?=
 =?utf-8?B?d2xoNE16UFYyTWJVenJRdHlxT0FSczB4dWhmNnhwREpMY3FJVGZsUWZ6TGRG?=
 =?utf-8?B?WU5FSW5iRGhwNFdEUGRVTWJzTVgvM0xubTFYV2t2dUFKQ3VwNnM4Y0tTZ2JJ?=
 =?utf-8?B?bm9tSS9IcXY2YTZxdU1IMW5VUnVkVTRvdWZ5YzNQTFBXN3U5dGxaNHNVT2xx?=
 =?utf-8?B?SEVKaTFrYjJHWTBBbWs1ZU1MeGpKR0Q3ODFuc2FjeU1ObUgxTDV4OTV0ZHZJ?=
 =?utf-8?B?YjB0eTJ1RDVBeHpsMXlqUnZlelZKSjVNZ3JvT1BqY1doYmkzblFCTUx1d0NL?=
 =?utf-8?B?VDRhNXhLM3hZU09jMHVpT1hiTjVxb2x3YmlDQ2pTTFhEUkZCUUlnbUxGTzA0?=
 =?utf-8?B?TThFT0Zrcy90Qm11Y3ovV2Rkb2JTSmdBNElqZU40TVdvM3lNc3lId0RITThQ?=
 =?utf-8?B?bWg3WEIzdWhoTkVVRW5mMTFpR2hxY1padkRxSzMrODBJdVBxMDJ1bTlsaHk1?=
 =?utf-8?B?Mkc3VnFTSWh1SDQrdGNvTnF0S3poK0hGRnhkZTAxcENSUUhvRHRYYWNEeE9Q?=
 =?utf-8?B?biswdHJwb1pCaHNHTEFOakRvcFpKTjJKYXhpZjRPWmx4ZVdiSmEreEZ3UFV1?=
 =?utf-8?B?Wmk1MnIrcDk5a1U1M2p2NXROMlp2U1Jya21HUlE1REozOXMwbHlSSWdLanVW?=
 =?utf-8?B?NGFrVUZKNEdBcGVQOHdFdlRocU10alpTUzM3SGJDY1hoSkxXdTdRNElNWC93?=
 =?utf-8?B?M3hpUElGRm9vZGl1QWErWkg1aHpZTnJLbEoyMDUvTUlRcVBaeUc3dGtNczA5?=
 =?utf-8?B?YVNFZjBLZEU5TVdmSnJmd1p5Rk9IRjNud1ZhSHVsMzlFTU5lUWFqbkNIOVFl?=
 =?utf-8?B?ZTJFMHFBTjVoTVB0Z3VFeVJMeXNVNFVLc3RLOHBWeDlpajR4cTV0dFp1THNu?=
 =?utf-8?B?VnlYKzh3YUJzRUFkcC9WNU50bXp3RFJud0x3NHZFUUVVSndGVmRNTVp3ZXhT?=
 =?utf-8?B?ZFB2TTI5WTgxVi96b2R0RmpjZXVTZVg4SWtIbGVyWDVvTHByQk9uZ2dGQnYz?=
 =?utf-8?B?bWNvREZIK09YWERKM09MUTlBMnZyV1hZWkFTcW42MjRheUVVYlJjSWJuNHRs?=
 =?utf-8?B?MG9sMEp3TTk3VzUxcEdNN3hxNTh3c1NXdER3aHA2OHgwbVoreUM5czI4QlA1?=
 =?utf-8?B?VFp4dVlyWDlEY1I5Q2pURUhRcUNUS2llcGV5aTcyeVM1V3JnN1JWN2NCVkZa?=
 =?utf-8?B?OVRqWWlQZ2RZaWo3Wm5WQlBEYWhWTEhGdjduRWxTVnl2MU94WjJZNUtEMkNm?=
 =?utf-8?B?Q0llWFk0b3EyT1N3eTR2K2MyR0w3ODJoSkRCcVZFSXl3dXJyMDAzaDl3Z0Mr?=
 =?utf-8?B?azA1T1dleU1Rb3NWWlBaZFIyUXRDVGFaOVcvaWlsWFU3VjZMMWdyR3VwTGdn?=
 =?utf-8?Q?i979QOA92nkddfPzUwEquIgfxAWfsXPRFaLsN7d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZNb0srVjVrZWNaT0ErUlAzZEdpQ0ZyQXl4UzJyOXlGNGVCOE9mYmduZ1Nh?=
 =?utf-8?B?Mmw2QmtuN0dHSmtuOWFUNDZIRGRCcTZhc2N4YjdQTWQwKzh0TEtjRUVON0Zp?=
 =?utf-8?B?bTQyVTdCTzRWSlhhaDhacEdlclZ3d3pERmVFaXg0cVJFeW53TTA3d1k0bzJZ?=
 =?utf-8?B?MmljTDN4amkrMkdCSVBEYVNDamliUnNFQ1R3c1QrTVZESVByaDlKUWlyWU9o?=
 =?utf-8?B?Zm1FMmg4S3ZCZ0J0Ly9lTCtDZTdGSWZIZjNDNm1nZUJ3WVhIUXl4OU1HY0xY?=
 =?utf-8?B?MjBHMU10aDBGY1RMa1NMS1VCZkEyZVZKRS91RlFPMDM1TXF5OXpmWFQ4Sm9q?=
 =?utf-8?B?enlGUWFhb3hwS1NEbzhkbCtBSlo4amg4WktzSW5kQXdFbEs5c3dGTTdUdWdY?=
 =?utf-8?B?R3Z0RG1uTFdjTml6NkVRSldPa1JvWURnK2JFekhqenB0ZGF5Rk1xVWdtenFp?=
 =?utf-8?B?SS9zVW01cnFiQW1GeDQ1cGJCajYvZmRNMU1XQVRrTnpIMGFrSHlBOGpOZHVL?=
 =?utf-8?B?RlFhT2syOVJ6YmJ6WFYrMVRGTmVqYTFPM3ZYVHE4aGdZVzlTNWlFYVVzWVV1?=
 =?utf-8?B?ZVlpUjMzYVNwaGVxeDg4ZDdoM0F4NW00Q0Zlbkc0MFBHdTRmZ0dkbDRRZ1NL?=
 =?utf-8?B?M204NCt3eGNIaDJQUXdqYlBKYjg1MjBHTUtzQnB1MVBZRnhMN295M1RSVVJm?=
 =?utf-8?B?Tlg1S2pKTmxHaHV2dGJRaCtzbUVNSzR4Y2owSDZ6NjZKcHNGMlVHS3l5bEFK?=
 =?utf-8?B?allqVU1EYkFEa0NjaEhHcGJSODNZeXRxc0EzSzQ1SWJsVXoyUnBFMElGU1Js?=
 =?utf-8?B?cWkyVUp4bExrbW0yNE9yck5MTWJmYWJCcjY0UzFXWkFOU0RSZHRBOUMrUHo4?=
 =?utf-8?B?a1czLytBczd1eTlkN0FxMVMxUG9iSy84aEk2VzBCTjJ3QlhUYmdraEh4VVFZ?=
 =?utf-8?B?am1veEpWRDVjdmhpbExpaE5tZHhjYXVnOTB0UW9QdTB5eGtrK01zVUZYYXdY?=
 =?utf-8?B?eXZQbUU3Tkgwa2xJTng4aERLc0JQdFBST1lyZzNvVWRIU0dhTkR4aXlEODNk?=
 =?utf-8?B?TENlZVd4Q3p5Q0hTZE9MTFVRZUdqR0poNTRJQ2RyQzdMRVFBZnljdVB2YlAv?=
 =?utf-8?B?MHgvOWtTb2tqS1B4cDUrQjFnZUVtYlREeG9Ob21odDloY3lQTDR0Y3prUTNq?=
 =?utf-8?B?TjJYQVV2Z1BkZnJtSElaY3AxN21jREVTSHova1hmek1NSHYvOWtnckl3c0lD?=
 =?utf-8?B?Y0REU2JzcC9pOFNWVi9MRUxTbldoWnN6c0F0RnA1cmhHS1g3QnFZM0dNRVJT?=
 =?utf-8?B?ek15dHpzMEtCQmRqOUxEMytJWm84NmlGL0k2Q1kxL3gvTGVqREUrQk9EejMw?=
 =?utf-8?B?WCtoRXcwclRwVFJGeHNsY0w3amo4aXhLT0VZZnpvTFdaNm5jTFJNV1N0RVRS?=
 =?utf-8?B?ZzRvbkoyRlZHc2hmLzhTTWdBUSs0WjFmdlU1U2pWVVdVMXZYVlRLMmxuYUl2?=
 =?utf-8?B?cmJYQ05oN2hMdGZDcHJPdUxGWDdJdXNqQmpkWVZQN2JEV0x3WlQ1QlgrSFk0?=
 =?utf-8?B?Qjd4TnhyYzBRVFZvOXU5TUpudWpES3RIbFJKVzRHMDAvcFhWTjZaUGtlZm1p?=
 =?utf-8?B?aUsxa2VtL254RWhXQjY4QXBicXRGNkhQUEJKdmFGb0c2dHVIWTloY2lsSlVU?=
 =?utf-8?B?eHdnVWRPenJuV3h1QUJ3dHNPZ1FWWmloemorbnU5LzU1b056QjJONm1uMGdv?=
 =?utf-8?B?NEw1RWgzMVJQL2huYWpTNlY3NjVWd21nZXlZQTlBYUhKc2VNUTJudGdTZTBl?=
 =?utf-8?B?cFJoZE14VG1XU2s4cmlPcmlSOXRyNEJVblBuV0M1SmRudEtiMW1hcTVYL1ox?=
 =?utf-8?B?cmVuVEF5UERHaHBSTUU4OTFoOTNsbUdvYzFuT0NramxYTGhDdDMxbS9wanhh?=
 =?utf-8?B?RkF6QzZ1ckNZc3F0UjJjSzVJNmlIc2VTZXNTQmRmUThWVXBLRFpMd21Hd01P?=
 =?utf-8?B?UkdGcE1RZ0xtaTFNQ1BCQTRUak5XalIrY2hRc3ZuaFZqenFUbG1rZWxhZ1do?=
 =?utf-8?B?YThkODBXYWtLa1pSYy9Zak1PQ3VhQ0RDS2prMlY2dVBNN1JwNVNabGQ1M2Nt?=
 =?utf-8?B?WjgraHVmWnY1TzR5S084RWlaN1M1S2o0TEZETkpQN2FPUG1wUkRDUC9GK1hT?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb6a391-f591-4ccd-994e-08dcf9224c7f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 20:34:49.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCPTyBKakU7rdh26r6zP41+wXcuFo0iqWBciBkmfoI7C/SMU8V4f5AP2bDbogiMPqrza5B1elmEtGv1rAtj9r9/5nwcorVTAM5yau80hXz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-OriginatorOrg: intel.com



On 10/30/2024 4:19 AM, Dan Carpenter wrote:
> Always just ignore the tool when it if it's not useful.
> 
> CHECK_PACKED_FIELDS_ macros are just build time asserts, right?  I can easily
> just hard code Smatch to ignore CHECK_PACKED_FIELDS_* macros.  I'm just going to
> go ahead an do that in the ugliest way possible.  If we have a lot of these then
> I'll do it properly.
> 

We have 2 for ice, and likely a handful for some of the drivers Vladimir
is working on. More may happen in the future, but the number is likely
to unlikely to grow quickly.

I was thinking of making them empty definitions if __CHECKER__, but
ignoring them in smatch would be easier on my end :D

> regards,
> dan carpenter
> 
Looking at how smatch works, it actually seems like we could implement
the desired sanity checks in smatch, though I wasn't quite able to
figure out how to hook into struct/array assignments to do that yet.

