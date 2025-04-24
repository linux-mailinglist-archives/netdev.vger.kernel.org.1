Return-Path: <netdev+bounces-185641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5665A9B307
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1528162646
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4E27FD6B;
	Thu, 24 Apr 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6E5Qbc2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7727FD68
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509893; cv=fail; b=P5EHRD/7XL9IiqvzoFWWuKHmMmCgVWcTV5+BtpYyNXKAIWOhqToVj+ysRbEMwBM22/uNfnIZ+bdcXElC19Ed+Zl8ZnbUxtSa9yA1CKlD2HMeKd+CSSY+JAjUTW5A3VouaHidLVQoJnL1CJ3nAEvZyZtqgf52fSKIQGQOyDPr/DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509893; c=relaxed/simple;
	bh=iK7mzbCeBNm3Vj/RWyZRUAuYbyg8k7VBSKRUC0uVrJM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WPgFKXS7TjysO9vkNacop2ECWeJTUpaiw7l/jiOrdcBmN1v64WBkWMu7/feZPXXbSCOESD/dHWsGAx1rSyOsWQww07v+PTxVh7qtcRC4P1AewKsZe/HM6KEn8d7HTsgg3BgPhl4HDUPsHe8UXXuRVjKlI8MDyoBr2B2y5Lpvy+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6E5Qbc2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745509892; x=1777045892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iK7mzbCeBNm3Vj/RWyZRUAuYbyg8k7VBSKRUC0uVrJM=;
  b=g6E5Qbc25poTVl3DSukLfOVW94UwQj11itAPHFVxeN9yWwl2lxHnTa3Z
   1TjYnKKULES7xaB95XxQsE5eQlprL/0p7JRW30GwiC1vPlSRwSk5LWC8f
   DxtgL+XGhrh88+rQKraunbNtj3rVAfzTVUyJWdAjrZulGFYe3NaPXY+dF
   nAvnFkVdX4HU1EB8drpVj3uEdEF07kI5D14wio26zn1q+f7r5jvTyzbwl
   GUODL5FXVK6YS+rY2+VBsNyLKkB3pbdZ2Z8DYcxaXO2FpJZNECTXJo+Hi
   SDFyqn1gKqatKwwz5BK2xvc1XYl9aTJk39B1462Vz7srt6Jkp0vzM4S+m
   Q==;
X-CSE-ConnectionGUID: 2O9wqPY+RBeFFONH9X92XQ==
X-CSE-MsgGUID: 7F8fQtSpRMe6hjFQNkWitA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="50974283"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="50974283"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:51:32 -0700
X-CSE-ConnectionGUID: qfMe5SwcTQmSyQ/nv2gSig==
X-CSE-MsgGUID: 0r6ab33DRoiFXpjpVDCdqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132962781"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:51:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:51:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:51:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGMo21X5s0Oui/UHh0UtiRA+M5pcOk66Z8gq08SdkHoRLvG8Ke9W2y15dhlVBuJnvRtLiyAVuRERB2Fuk7A2QXLS3WMBwHZXleyinUwnKUM8ChM5Pyae4L8hDcY+XvGkzzfXvgjVP8NRHZHqVHRNP1bZy4EbeGUZ/3hPjtdZEldI0Ri4UJZiDLfCACCoHf3s9F1emjesGEys23s2ci1+VJ0ToqSdNlsbn4Ice4vQF7JmlIqUs932SkWxmoan5PErT7dSL9NrnVyti+sX3CT/HK0RyjIIZDoOS/KRsFdhzYfDd9VNwnWiBDin2rVSTNzDC39WQ7iPInqIS9F+/NvSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCANfv7BU+CHGWHg39fOWWXfS7zIRe4hdQY6fbummX0=;
 b=K/UiCZdLhrQkFq1GBvw7odR6uzcdxD4cno9asBtC1pT9D7fM8jjUbtKv099l9857wybAiahzdZaX09OyxOrONu10ORWrmB6hIFBD6WcKWnh2xCWhsjMU4Zbxng3+BzUMKcUZtlUUJnwqBBi5VM4igySfkbynB8axNIoEOm0Ki1t/lpbURRZ/SXwRhRahftsalpAeHdtJVMRWFH1Af69Ou27tbxsDEOvb92Epx6EwHWnaUaC/YGZ0fs9hNj6F4n1lMSUOH00TVDdbORtbD9+JdNTfp6wDtTv+KQIGwMuHXaFSNE1rUJ9xm64KOrcAGg5SCjQIc2QH1xtagOAcu+MqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:51:27 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:51:26 +0000
Message-ID: <b2e9c835-a634-43a0-8fd1-f2b946164c92@intel.com>
Date: Thu, 24 Apr 2025 08:51:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/12] tools: ynl-gen: support using dump types
 for ntf
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-6-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-6-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abdbcac-ee2d-46d5-655e-08dd8347df27
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHR6cGQzbVpmQ1luSjNJZm51RkJOL05JVVY4V0RxRUU3UTZGOUw5RUJ1N1A3?=
 =?utf-8?B?dGRMZTg4SS93L0Yzd0NmODNNcVZBRUxuTEgrK0pybi9mdmdkVmliTmRSa3hn?=
 =?utf-8?B?a2dCQ2V1ZjN6MUZxcHhYdjVnbk5BYkdwYnplTVFiOXgvcTJRS29wWU9xeWJO?=
 =?utf-8?B?Ulh4UmVYWlRkZy9NeU9xeHc1ZnVWOHpMdEFOWFNScjNuV0VyZDF4cHhMMldq?=
 =?utf-8?B?RExMckRTTHp6T05PZGt6TDkyZGZsUHBVbm5VWGkvOUVIT1psM0xSb2tvajVB?=
 =?utf-8?B?MWVmQThJT1Q5OWxHK09jR1NPMVFFc0lNa2VvR0NuajcwZGx0eHg4RUQvZjlG?=
 =?utf-8?B?MFczeXlhb05KOS9ubDRoQ29STGdrcG9NMVRKQlJUNUU4Qjg3cXRpN1FEcmFM?=
 =?utf-8?B?MUF4bzlNVjRWNjZaSTRDY0FieTJIZW1ERFNWT2ZzeTY2LzlYdGVEeFRadGtI?=
 =?utf-8?B?aVFQNlBLNVhLZmxFYmxGdVBLYmh0U2RkVGx5c29TdnM3K3p3Z3RjK29IVHdk?=
 =?utf-8?B?eTlpaEFFekNuS3dXYjk1RTI4RnVYOUp5ZlB6cEtza21XODZHVWVWekxZL3JI?=
 =?utf-8?B?Z2J4YTV0aFEvQ1A3NE9uMnJYNXFtcTBqRk5WRTdKajhPRGJYY2tqaklCc0pQ?=
 =?utf-8?B?bmk2L2N0d0I4Z1lmWVptaUNRdnFKVWowN2VBMW56eXdDQWduNWFtaDJNMUN4?=
 =?utf-8?B?SWlOb1c1dE1jY3h6MGxtRXVIRFlmRkFBWGpaRHBjYVBBZlpoa3doMklHNUlw?=
 =?utf-8?B?L2pHK3ZyWGZ0ZHBXUkNBdEVpbTFxUFdJK3cza1dhcVhjRWpGYjdXWDYxWEY1?=
 =?utf-8?B?WlV4a3BBZ3dRUGcyKzhEQUxoNG92bGlVMnhYVzBoL3dTU2gxTVhIZDhRSmd2?=
 =?utf-8?B?Mkc3dm9hVEVReXp1Z2k3Zmh6YVdicExST3BqOEMxd2F3VXYvQUs5S1NGWmt5?=
 =?utf-8?B?Y0JLUUNSNXdVYm1VMFE1Mmhkd1M2QXlVK0RzdjN3RDhOSm1Ta2g1eDlGamha?=
 =?utf-8?B?dmVwS01DMmpUSzFnN3p1S1hZaFM1U1N5c01PR08zUjY1NFNHbUNUaTFwbDJP?=
 =?utf-8?B?eXhTaTZWSVp3dDYzbkpDTDJoK09kd3BYUWhoNUZ6K0JiQUppSlU3ekZVZVVq?=
 =?utf-8?B?T0RuWXRqbWNmbFZUaXBxMGVBRkljbDQrMzh1SElOQ2tGSG5Qd1dpS2srdjlZ?=
 =?utf-8?B?MkxRQXZlc2gzcUlMQ1EzZ2x1bTBOK0Nycm9maHVaVjdsWE9TZnVnUWZHL1k5?=
 =?utf-8?B?Y1doa3oxRitsdFc2Q090blJYUG5WWmRpWEVvVFhuY0VYTjBmczhETERnT29t?=
 =?utf-8?B?ZDZ6T3lhcHV5MlRFclV6RDl3YndWeG8zVWVHZHovVDJDMTUzNjA5WW1CYzFo?=
 =?utf-8?B?S3JzT01WWk1jN0ppUVpXMTNtcnVQNmlIT0xEOFUyK3cvalJiTkdKTjA2VVNI?=
 =?utf-8?B?bkFISzRCenNBOXpCNmljMVlDNERtZ1lhZTlMYkc3REx3QVYzeFRiYmtyNkxx?=
 =?utf-8?B?THMxYjErRkc3UWZYM0x0cGhwek0ydFU5SURnSXN4QmRqQzFvSlh2UGVPMmNR?=
 =?utf-8?B?NlFqK3dTc2NkcFFHMzFEdk8xak40NjQ0bmFxOTV6WHlSbUNLcFNuSmhQZkM1?=
 =?utf-8?B?bkc1d2w2MnkwVEg4U2g1b1pXQkJ5US9RSkwzR1BGcmJZdjRDcCt3bzNCTDZ0?=
 =?utf-8?B?YWtmUTFLVVZYYkRCVVRjTHhPcUUzZmFNakEyVlVpczdRTlY2TWZ6dzN6MmRP?=
 =?utf-8?B?NlVhUXNKcUEwS3kvWGM2dGhiS0xuSWJRMTJ1VnhPekg1cmNUZ1BpdndiS2d6?=
 =?utf-8?B?YWxEdTkrNG5hZjU1WVZqdWIzQkdBaGZrWTJoV3B3b0xJemt1VTFNVnVsUjZr?=
 =?utf-8?B?WnplaDV5TG1aM3Y5dGJXYlVHTGJIV1NvMHhYQXdXaXdGQk93Q05DSktkTmZL?=
 =?utf-8?Q?gRECj5lC7r4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNDN09NQkQxbmdJMk9hckFlU0pFOGl4NlJVZlZyeUcrZloySm1ESjVDRDdu?=
 =?utf-8?B?c1NGZ01pKzRiMHJxWU1xb0hpYkNraEVmd0kwYmFPL3o2S0xIaUxLR0ZwU3o2?=
 =?utf-8?B?dFhTUXIwMm9vakZIeDhUaHJCNDdBWWw4S0xHVCtDSWZJUDFtWVl2UnZyYjhW?=
 =?utf-8?B?b2lCbCswNlR2MEJMQ29UTXI2QmZBSDkxTlpQZnowL2xKcDdheHhVQkt4ZHhG?=
 =?utf-8?B?KzVxYkQrTjJYbzBSUkhBdWhxdlBiSFBSOW54VGlvR2ZvQm5lMGQ0VTlwWncv?=
 =?utf-8?B?RDFOUk5ZbWhWeEdzSmxZdkdtSUNzak1MUG95T0EvT1hRaXp3SEgvV3owaG1K?=
 =?utf-8?B?TjBDbDR6cUl2WXI3eEk5WFlUWUQyNURlR2VoYjVYWDVzMnp0eDVtZkpkT0F0?=
 =?utf-8?B?QytuUHRHdUsxZDhmRnRMVHR6RTh6ZHhxQ1FFU1ZnNnZwdUVZWi9EQmkxSmhj?=
 =?utf-8?B?QXJhQ0JYZVNTUWNGM3RybDNKdWh4K281NjZudWlhTEw4UmtFcEJ5eFp3VUJB?=
 =?utf-8?B?Q2JaMnJKUGYvYWRWVWxpOGZ1WFVkRE03a2xrRm9acm9reVBJUkRPRlA0TFhv?=
 =?utf-8?B?MmxFTUF5b3FGa3oyMjlLMkl0S3hDc3RFNTVrN08rMk80OTYzT3RrTTh6TDZl?=
 =?utf-8?B?azF6QmFXaXZ2VkdJZDdIRGo2MnFpdHJ6eEdjd29FRk9mU1AycjAzUGJ4dWtP?=
 =?utf-8?B?YlVPc0F6dXJkRFJ1ZUliUnNJRUhEeFg5TVlhdGFXV1RUQlJMMUt4VE55WnNF?=
 =?utf-8?B?QTN5R1oveDlXUUlxQnJ6REdEQU9XM0dnV2ZKVFQzVm9OQmo1Wmx5MlkvUE01?=
 =?utf-8?B?blcwQTR0djhvMUN0eXB3WU9Tb2d5Yms5UDlTb09rdlNsV2NqTVp3RFdwZkQ2?=
 =?utf-8?B?VE9tL1l1TFhrU1FYNlFSOWMxMmtGbitUMzA3ZVJWM0JybzZmMGcvZjBmeGND?=
 =?utf-8?B?V3RVSkRBQnJYVVRkMlh0TWY1ZkJsRlc2WUhydXR6cENtWWxublg2M20veTVS?=
 =?utf-8?B?U3lqaThKUlpLVyszWWJtZGN5d1Q4WnN4TlFEcWNweC9SbStZVjJvc2R6WVpS?=
 =?utf-8?B?L2liUW04MU80OFAwQ1JUakpLTDNzUmFaa1VhNzg0WVVqMjZ2OGdPQW9Ba1VC?=
 =?utf-8?B?OFNxK2ZFWDlYRTdkMmFDOXdpODNSREhQTVBMZWhQVHdsc0x3MDdVN01YYStq?=
 =?utf-8?B?bUxQL2REajg2ZVF0YVZUVWsrd2Z6WXZXWGk0bktDbkx3OEFKem5FaXNiOWhB?=
 =?utf-8?B?WHRQS1hBQTNwcVU5cEFiMnpoRk1ORnhJNHVvcUNaOFdkSTZTaGFyMnVqQjR6?=
 =?utf-8?B?SUVHOHVybStzVytoK2hMeUFtWFRhKzBGVmlFZWhUSC9Wa0kvRzlxQmFLaDMv?=
 =?utf-8?B?amlMTDN2VGIwRkhXRkpUWFBYaVk1YWVDZVo3a2NncXNtcUZHVEMwRzFHcFRX?=
 =?utf-8?B?WVcyTGc2UkFQUkVVTDhNM24wcC9TUk5uaXN6M1UxdUdkT2ZJay9neUk4eExh?=
 =?utf-8?B?RklHcmZYN0kyeDI5aktYbnZmTU4yYURycnd4cGxDQ3Juams4MmJsY1RFSXVn?=
 =?utf-8?B?MHBDM1VKT0pMc3ZQTmdBQ0hmc2svOGFsMEJhNWRhNlZMc254Zkp6MnBBRUlj?=
 =?utf-8?B?RTl6R3ZQdHJsODA2azZ0VDZxbmVUdnFEK0FjUmR3cXlyREZvSjJtSlBkZER5?=
 =?utf-8?B?c3A2RGdRcUFvYldRcUtkMUFhWVE0b245SVdzUW93L0pGMzQydkp2Z3dVckE1?=
 =?utf-8?B?U2R1UmZYdlF3LzJlMi9PWE1kbzR3akp0ckZTZkxsU24zK2lLTVgvbHhvMDR2?=
 =?utf-8?B?UjhSYVFnbGZucC9jTXBGMWpneEJWZmg1OGlhaFplVXdrcDBwNWNINnBUS0Nw?=
 =?utf-8?B?dzE3ZE5PdkNwd05wYnlCZEdhYXE0ZW92d3NlYmcxU3hieFdUNVJvUXRVYksv?=
 =?utf-8?B?b2FFQUV6bWFiNlhIbHIxLzVrbEZqYWlUVVhJRnZTWFBUaG01OVBOQVhGdk1H?=
 =?utf-8?B?UUNONHJNM0JrK2hMeEs0QVFuUVhEU1R3aWdXVFFHcThRb1ArZE5QN05MOW1F?=
 =?utf-8?B?aWt3NCsrRldXclhKaXpoeHlUSFlsVXJncWdnenVNVTVGOEVXdmx0UHg2Vlli?=
 =?utf-8?B?Y0V2NU1WY2UvMEtxRzlkSmVNS3FiVXdtR3hKN1QxMFJSNmFhU3g2S1NWd1M4?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abdbcac-ee2d-46d5-655e-08dd8347df27
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:51:26.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHKxx6xHHao91pmwPrJ0uFxMIreoNNPLU1L57GpcBfEuSU8uJ0mzPi7kZzs60xetW+fPnr61YMvKInG+H3MMu5sj5VQ2uuh90n7rQisuZIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com



On 4/23/2025 7:12 PM, Jakub Kicinski wrote:
> Classic Netlink has GET callbacks with no doit support, just dumps.
> Support using their responses in notifications. If notification points
> at a type which only has a dump - use the dump's type.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 35a7e3ba0725..2999a2953595 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -1283,7 +1283,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>  
>          self.struct = dict()
>          if op_mode == 'notify':
> -            op_mode = 'do'
> +            op_mode = 'do' if 'do' in op else 'dump'
>          for op_dir in ['request', 'reply']:
>              if op:
>                  type_list = []


