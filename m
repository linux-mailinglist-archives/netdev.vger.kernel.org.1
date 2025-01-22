Return-Path: <netdev+bounces-160302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A10A19309
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD921610DA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE0213E60;
	Wed, 22 Jan 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZH1tI/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B1212D82;
	Wed, 22 Jan 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553997; cv=fail; b=BI62Pxkt+8e45Jn116EuVb2ZcnLZ3OVenwKCToPaHMT+3/TolpFKudJjPehWweDZhtNYR0Hbk7K1He92cCPz7z4JG19BYBsWW81DgK6I5Abiix1vT2FGLdlZgQFQaGu4o4O0N5v9V2qQE6N8Kf5jnLwfB+d49UhcgKLUssp6lfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553997; c=relaxed/simple;
	bh=KcElT3krKJjb0ue4Oic+Spb3EAQlzbLb4Ce7VOEY7m0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p86QTiJYGSk2HumJsVnuohXD0IfDoh9E2IyZQS0wFufUd9n8Awjl2378FLNCgnno9GS2Gq8/EWwXbHsWjM35d74ASEtsajh1TtjId92u3GALc2K3OeugF3JY7wgmnlACORu368lBTaFIX855R/6T4z4RlO5L1WDDmWSsMYR27cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZH1tI/Q; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737553997; x=1769089997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KcElT3krKJjb0ue4Oic+Spb3EAQlzbLb4Ce7VOEY7m0=;
  b=fZH1tI/QyT1dCqr+s2lWrMxS9KR7Hx7fT7+gvVil4MkkmDl85IPjh3BM
   DvCbPkhJpPHjzwYnxqFvdYuibULqg0QjUh+XWzEV+AC16Du4OYd2AQLxW
   dnqG7zcZCNZh2nziRbxWt4fsbuKTKI7+0pCnlFQMOMjepeuT5DSrPWsYP
   oa+H3jOyAuNDlQ1UL38Li77p+lFx17qeKMAZKKU6M1sx6Hm/5soK03crf
   b+R8ztrFB8qLfufcqihdtkriJcicFWKNSo4HIC5gDblrAlKQBMbQbOOJK
   1rbaLWMYYZgNmShOsr6dBpf/92mL0ZX/46+VQ1CeyrYU2Xmpe/1xliwAK
   A==;
X-CSE-ConnectionGUID: aHjzQh+9Qci9++euWkHqKw==
X-CSE-MsgGUID: /e+SoAbcTCegKFgnOSphqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="41767788"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="41767788"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 05:53:15 -0800
X-CSE-ConnectionGUID: gXCQkJZBSauLB6O+bxQFyw==
X-CSE-MsgGUID: zsAGd+G4SqipMAE5wun9cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="107064459"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 05:53:14 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 05:53:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 05:53:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 05:53:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjPITllilDJMk9F4U/5sNhJMOgt4WiEnE1O/jF05i4oBje8Epa2/b/f0bdCXTIGdq93q8ZCiWZLOzceUXLzJWvvXVN0xhJ+tFO0UOgu9BYPy+lNLCbKA3Lga3TS1FC1CVp8TBIJI11iFw3ALmIR/Iqngu007LPsBmkTibI37oMNIPdzFArcd3EpAyHJ9c/Ng7tpMa5H3Bv5kmv+Fuy99zlDIoyEFdimYsmCeS0ufqG8n3nS9WhdBuEKLu6VnemGZCgNqOXoW5Hb4WsIQYVgxj8FgeC1hX5UIc81e+aajdlVrbHxxBBW+z01dQoDrs0OJgOhI82GMvwmoM+mjj+w4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZiOAReIMVSPEFMkhVOSiZnUb+eB0YmxRcMQ9TrFC8U=;
 b=PujiBZFQOwpCxqkvRXm51/umIIKA0q347uj5zY+aBULx7kizniejaab6gBVcajHa8LvzfAaiguEeUDbJVSX2XsyobMBU2jxztVjsbJYhbh+6mWPLLHUSuOK9IUYcczDVls60Fjmm9JlqhU9D1qhbRbm10vVnUupuSMnErdUnLtU6Z2gN1tXNMERMy4Y5zeOV+3Fyn4QhPbxPqOPIPWfkeTZyHwBxSAr/lmS/ubNv6cPry404Ra2aryfAX1R29vn40q2u8cE56cAUOuBsmW3UEyEssVJL/cb44siRjlvsa0z6825PofySXX4jcgEllvZt0Nc5rN//2otBpRr2tzr8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL1PR11MB5286.namprd11.prod.outlook.com (2603:10b6:208:312::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 13:52:45 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 13:52:45 +0000
Message-ID: <62af8b0f-7361-4099-ae20-f5a55e9cffb5@intel.com>
Date: Wed, 22 Jan 2025 14:52:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: netlink: prevent potential integer overflow in
 nlmsg_new()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "David S. Miller" <davem@davemloft.net>, Thomas Graf <tgraf@suug.ch>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <58023f9e-555e-48db-9822-283c2c1f6d0e@stanley.mountain>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <58023f9e-555e-48db-9822-283c2c1f6d0e@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0022.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::34) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL1PR11MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: 683d8a65-815a-49c2-c8bf-08dd3aec0c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDRmU3d4WjNWYWZTYVpoWUU0VFVHdHFQcTVuSjFVblM5ZDhNdUdKeHFPRS9D?=
 =?utf-8?B?Mk81QlhoY2ZmVjdoUUpNVWpMc0tnZitjWlBhMUtWeEJtNWsxekdYbGlSc3V4?=
 =?utf-8?B?eHBFWXVjd3JWaXpzN2wycmdibVp5QkJLOFlIWXJrYk5ZbGE5WUcySlQzbE1M?=
 =?utf-8?B?SmVsWXRQYXJwMDZHRllqbzdMbFQ3cHc3QjdwUHNvYk1EbUV1dklXV0laYkFX?=
 =?utf-8?B?RGlCV01FNGxRdTVUMjhCcjJuQzJUVmdiU0t3Mi9qaktVRkhMNWtlNWI2NWkz?=
 =?utf-8?B?VzF4VTlFMHhsMmhmM2VxVERkMTNaaklhS252L2xnbHRWTkJpY1FIZXhpQjg2?=
 =?utf-8?B?YVk0VmZleXZlamxhcUN5eURETFFSZGFWYmE3a3l0NFI2dGE2TGdrazh2NzVq?=
 =?utf-8?B?NklKOStwMjhHVU81QjZaRDZiZFRjL0FoK2YzSGp6S1lhMHJLUS8zK1VkT1Qw?=
 =?utf-8?B?TEZ6aDI0dlVNREczYnkzcCtrNitaY2FrWHRMRjR3NnNIYkQrZ2hUeE9yYThu?=
 =?utf-8?B?RzFwYjIveUZzeXorK2NvbEt5R1FMTWVLSFc4TE5HR0ZUdzFOK3ltdER0bHVt?=
 =?utf-8?B?ZHY4TWxaY1MzeUxsa2JEdzUrWndDR1M3alRMdGxQVU9kNlFHT2I0TzVvVXN3?=
 =?utf-8?B?bGRHdW5yTnVZVzA3V0VUaXVyUGVtSmhYSko2SWorRHhwd3RsbVZjeVU4ZE84?=
 =?utf-8?B?c2tLeCt5Z1VWUlRIYXBiUEtNUFlERGtTQWRlcnpEQjJCYmNiVmxnU3RyWVVl?=
 =?utf-8?B?M0VzMSt5UzJPUEh4TFprajZ0NUxnbExEajJNREVJZmtsVENlL0xBS0pYeDhS?=
 =?utf-8?B?Q2pmS2UyQzNGMUdOYmR6OGVOWGdvdTY0N1ZsTGwvSzg1alQ3Zmwxcm1uTW5J?=
 =?utf-8?B?am9Kc2JVVkV0aUtacUF0L2FabnAvQXlEMUN2WFpWbWQ4aHFObUZ3U0FqbEo2?=
 =?utf-8?B?aUx3UTUyN0NNNThMTnRyRk9nc1VjaFNhMzVkTHhiRk9uTHFiclNLc0FWNXAw?=
 =?utf-8?B?VzRGR2Vva01qMzJRbkZhMXh4cG5ON1RraG5RbkE2OGN6S2twTExWQ3RoVWo0?=
 =?utf-8?B?QURyMFB4V0w5a05xaWtCb25YdFlhTmZhQ2xyU2ptZDNZQm1odFgxSnNxbjg0?=
 =?utf-8?B?YjRsN0p4dFRLMjNUZTJaQXhaejBvWE9zb3RZUWZnNE1GL0hwZXg4cmZMYVpP?=
 =?utf-8?B?WUo3RE9ITVhCbC8vSENEakpjZFVhNkI2VUdJcmNvUzRKejBjbThiUzVjcXJC?=
 =?utf-8?B?YmZzNU83T2ZXOXRxRVdRM0RMSVJGM1NYVE9vRjlCUmR5cXBLUG5IN1hqZ0F1?=
 =?utf-8?B?NTV1VWJYbWJobERGckF1UnhaM1l1SURTZmZ3TUVqZ3crM28ycDJaNXMrNGo3?=
 =?utf-8?B?dDR4UDZDbGNiZEtmTTZYQUNCYVc2QnRzeldkbUdFYWk5OEowekkwdWZvNzJD?=
 =?utf-8?B?SnU0SVlvTGRWS2JlK2kxRnN0NWJ3NGN4NFdKK0REbGtJNzNtWmJHam1EaGph?=
 =?utf-8?B?OVBBcXd5L09CUlUxcDFoc2dHOXVoZVBaaTh0cFdjWU41TWp1RFdMNU4xNG5Q?=
 =?utf-8?B?Y2Z1YWhkeGpHTVdRV3RwN2srU0hrYVZmdU8vaFg3eW1jbUoyekc2WVhEY0Ux?=
 =?utf-8?B?WVJHT3FUWkhTZDJIWXNUa050NEZWVDVyMkNmZXRUSml2Nlc1Z3I1T21IZktt?=
 =?utf-8?B?RUxieFc1RkV1QUl5OTRPOEl4d3NJbEpvUWNlMGRvcUpjZXFOaE1hSGFldDdF?=
 =?utf-8?B?TEQyTlZVUnhTazhWS3Q0dGhwZ0VmK0lxendlR1hiWk5pK1Y4QllSbGcxMXdZ?=
 =?utf-8?B?bHJQa2tlVE41ellFV0VzYStTVnJwR1N1YVllV0hTUTZaWjJhWk8vUWhoNzBR?=
 =?utf-8?Q?phxijFNkRRu2l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0RUa0lwblZ2bCtUMit3UXlrZGhGZ0JnSXJmSFR2anZnS0lDOFBTZXd2WWdW?=
 =?utf-8?B?OHRBakRWWFp4NTd1WlJQSTdPdjBmWHZKTWIyMGt4VXQ2a3FqOW85YU1oRXV0?=
 =?utf-8?B?aW1HU1Rna0pKeTE0WXdYOVI0M2VxUms0UUJRSFNSYjBkVmFGcFczcmEwWWRu?=
 =?utf-8?B?SUkzNHNseFF2VjZnK0RCWjI1R0dKTk1qVXdLTzlHNG1UUU9HSTBraURFanJh?=
 =?utf-8?B?Ym5VcWRyUU1KK2dnSis2SDBnNkpsQXlnYnFOa3FPdEs4RlR2dzlLSXVNSU9J?=
 =?utf-8?B?R2R5ZUVuMHRhb1VpUC9PRkd5eWYyVUNxcnByaFIzZ08yR01mL25mN3ZEYXdQ?=
 =?utf-8?B?amN6WEhLVzEvQnJaelNRNElOSlZKeTVDVDFETlRZOFZ5cUNXMXM4MWdob0ZW?=
 =?utf-8?B?bnJmeENHWk1HcFdDaHVuVTVSb1lsSVhENCs1RGtscEloczM5YVd6U3FKSnl4?=
 =?utf-8?B?U2VuK0REdlcrUHZDWHRaNVFHMElHbUVNNVNyenBvc0kvTjNBYW9sQ29TelI5?=
 =?utf-8?B?MnlnY01BUVdpd3VYb1RmaCtGL2QwSWI0SVJhWXZYcm1zUHIvNVBVbUdXZDdO?=
 =?utf-8?B?clB1TGdLN0RiNlMvZEszdkhnNC9QaCtHeHVzQm8yY0Q3YlpRVU9oYzhxTmR0?=
 =?utf-8?B?SXhrRSt6bjM4azc0UHRjSjk5MGJQZHNIZ2RiT3V1MVlEd1BKb3ZsUkFhV0U4?=
 =?utf-8?B?bkdjcFBadjhhLy8xOThxVmp2QW9PUDI5cVVIeVdYMkRrcWZsT0t0T3lwWWF3?=
 =?utf-8?B?UU1DYU95ditIK1FjeU9QY3BMNVBMQUlEZkNDVG8vNDR0TWlwazFFbnlqRkZa?=
 =?utf-8?B?VUNKdGh2VXVJdzFHWEoyVEc3T3IzQm40TDdRZmh6SE1haXp2dTJqYTZkYU5L?=
 =?utf-8?B?emZNRmF6U2xhbUppZDVrRnRRS0pOTzJ4RHlXNkpEcGdmVjVDak9Zc2tYcGl0?=
 =?utf-8?B?ekFqREFtMVI4MVBQRU11Q29RWFhCYklBQ3FTS0VUZjhJbzJseUVMdkE3dVJW?=
 =?utf-8?B?NmZ1ZzFtZE1VSzhsNEtNR3lEM0hJc3BNQXB4aW1MQy9hdHZ3K0h4Yk9yNDVa?=
 =?utf-8?B?RXNRRW1OYmxYVFBIckt2Q3hRSFJtZi9zalJhdFdvQW9lekNKclh5YmwzSlJ2?=
 =?utf-8?B?VHNDR0hoRjNHeklIVGNuQ0FkT1paT01NU09kUFpFR1dhemdSOC9UTmpzejFT?=
 =?utf-8?B?MXd1S3F2OVhGM0hoZDhtU2lxRUVLaDV2NFpqZUpMMW5nSGl6Zmt1VFhrbXBj?=
 =?utf-8?B?WUsva0FaV1Q2Rlh6SC9CNkcwRWtIcDloWSt6anBkZ3BSYWVQd2Y1bjJ3a0l0?=
 =?utf-8?B?eVFCZENVNFhReEVieWtzVEpadkhaeUVmSStzdWJ4dGxmc05yUW9XVEFsQlg3?=
 =?utf-8?B?VGtXdXZsQ0hCciszcGtQamtnNDhwaTNpY0RqQ1RFRmV0Y3dvL2lNdmxGdGM0?=
 =?utf-8?B?Tlh6bkwvSGJBdXQzOVI4NzV2VGYzd3pnUU9IWFp4QWVWd3V4dEg3MkU3Q283?=
 =?utf-8?B?aDdOMWlWNFozN3pJQlcxMVVuM3ZZTUJmM0hPYVkxL1VKRU90QWdESmJBUUEy?=
 =?utf-8?B?cHBzdHJsMDBCQ084RWJGckdlL3ZBZWFqVlFpL0dQY1BWa1hTVGxNWkZjREp0?=
 =?utf-8?B?d3U1YktnMkorYWxFdGxXUGFTY3A1OU1rb09RaXFIai9ydkZXVi9rY2tYTDlU?=
 =?utf-8?B?NzlBMzd3QkNnWnFkRjZXdGtBWmkwZnlpVFVpTWYwa3E4ZkwyVlE3ckpYNUsz?=
 =?utf-8?B?a0kyL3JNTmlwWWhxOTBxaEFSK0dWRmt2WDFDYXFhQUE0SEVOYUUxMGRMUFE4?=
 =?utf-8?B?Ym5ueldMTHBQcVJFTURUY1lreDEvdUtlQll4ZXk0T1JmV2N5WHA0QlVUUUlY?=
 =?utf-8?B?T0ZCSE5ETVY2bGNuVzlWZUhkclVINlU1K09OeVpLYWR0RlhsS0lmY1RPazgv?=
 =?utf-8?B?bmRET3FUZWljQkpBNnViOCtRN3lzUVhyNnhMZGVzbFo4RUxxTTNMaGpEOUlt?=
 =?utf-8?B?UUhQWmZFS2FHbWw4SG8xMDVtWXBuTE1NaFVZNzZ4TzRYOXRJL2cyVW9nTTRZ?=
 =?utf-8?B?ZjRqU2d5aG9hQms4bXF2MG5mREFhODZ6Y2JZQldxYXd4cjVaVWg3MENQbThU?=
 =?utf-8?B?YXQ3d0J4NG0yME9KemJwaGs5SUloM0NiWGl4bEV0cjM4RVFId2dIcWVncVZv?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 683d8a65-815a-49c2-c8bf-08dd3aec0c35
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:52:44.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYTh1KIgD2c56tvpLSZ5hTaSshSFji4TxD1TARtuVpFENV4dTusarB/Uy523907kLICXVPdd5f3f5trrH/UfyLEX4xMasWIu25nXCYOZ+8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5286
X-OriginatorOrg: intel.com

On 1/22/25 14:49, Dan Carpenter wrote:
> The "payload" variable is type size_t, however the nlmsg_total_size()
> function will a few bytes to it and then truncate the result to type
> int.  That means that if "payload" is more than UINT_MAX the alloc_skb()

In the code it's INT_MAX, would be best to have the same used in both
places (or explain it so it's obvious)

> function might allocate a buffer which is smaller than intended.
> 
> Cc: stable@vger.kernel.org
> Fixes: bfa83a9e03cf ("[NETLINK]: Type-safe netlink messages/attributes interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   include/net/netlink.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index e015ffbed819..ca7a8152e6d4 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1015,6 +1015,8 @@ static inline struct nlmsghdr *nlmsg_put_answer(struct sk_buff *skb,
>    */
>   static inline struct sk_buff *nlmsg_new(size_t payload, gfp_t flags)
>   {
> +	if (payload > INT_MAX)
> +		return NULL;
>   	return alloc_skb(nlmsg_total_size(payload), flags);
>   }
>   


