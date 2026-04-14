Return-Path: <netdev+bounces-278579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IuENaSn3mlTHAAAu9opvQ
	(envelope-from <netdev+bounces-278579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 22:46:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D963FE705
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CFDF3015D1D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29726372663;
	Tue, 14 Apr 2026 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuSga5P8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC52820A9;
	Tue, 14 Apr 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199583; cv=fail; b=XkGqpnJU0Qz7VsFthdFFv0n6hAXYlz8ZZ18nLHNzpnq0VXKm5VRP7NHEM++cd8vF0ygz7cT0mAsjj1lcNVFaDjejwbR4GmcKlm/aUFkhF1O/DlkVs5LMtzCvAQNFI+AKKkvcyyFvpEc9FLAxOpg4RvxGBybf+yvmT+cbDs1e8F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199583; c=relaxed/simple;
	bh=LzX7mmsCNQtir5HJFbHFi0AbSXh+RnuZEINYqKfdm0U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uhfey/++fsU+trI2TRNq6pEo7KthqhjbDf0QqHyjb6T6yzd0uGYxCp6rhZSsO03fVqoWenPUbweRY02rW/m96TXcPMdtFLgGRu7RmlGBCDr7pFJ6uS532g0XF1b4Y9RDZB9SKOy1w4F7mLQh099eHXOGcX/ZenTbcsCGJGkUMO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuSga5P8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776199581; x=1807735581;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LzX7mmsCNQtir5HJFbHFi0AbSXh+RnuZEINYqKfdm0U=;
  b=TuSga5P8nLREQfWrrgU+eT/lRgSDHxB+zEScz21gjh2F5r+SSLd0bGVh
   cO9PHEUjV+cb4OH9FlyhWqWsULpvUnCioEAf9P94Dh4++wJpPCgAdIc/h
   O7fgL1O8po+30QIhxfWjQmBX1Cw5CzrZdGasd0cVxuQC41UTix1ejWIkU
   VL80A0eLtc8grlRSZUJYqM1fRL0CHTV4Rclak6MasFfOqq/eYv4nx3dxV
   nL75RA+2WSyeaEam9J+pYaj45WNZhxIS5D8HjoWb0jVAg8GFZwSID0Qcw
   KbPH08VGDzO0B9sA0ds1cVq32/sc5iq16FMq5CRL+HumMksnDbDU1zrGI
   w==;
X-CSE-ConnectionGUID: qfYYSHTiSCiXnCcJcoCnZA==
X-CSE-MsgGUID: DaG6OK9fSPSLVhJJVTaLXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77074435"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77074435"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 13:46:15 -0700
X-CSE-ConnectionGUID: /NKOy6liRo+9kLQQW5myfQ==
X-CSE-MsgGUID: 0kyjLQp3Skub+ksuBwGHZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227025740"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 13:46:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 13:46:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 13:46:15 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 13:46:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+TzzA4VGuOVT8deEYRZBcC9hgRkYYAFDZLMQwIsFZhSwI2bNfYEOAODJ9ng8yc3QMNJ93Yf2zaqZaEQwolvWutI+6OB5QLayDz1FvYc7OLdyvGDqlkjStcgsthCwEA9TK2PrXRyghStlQ6wpjJxIdWne3s03X/VO1ObOuhBwYpjrsyaEA96xdqNQDAAs8XNL56RAp5SoS5Mv+8ec1Q/Y2nHEIr9N3vUugg4O+fppAnrgmvQRt8B3hDD8xF3lXbQc8BqqpCnn0lxTAzNdxv8m2BOB6rPEt5mDDBeQ37fTqcGZ8077WIbPegMFKjEzm5KD2IZ9V/nHgBrmXLFPAvIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpq1arfm4KBKX7kDiy9g7I1z+dDrHLXBiUlgRPj3HEQ=;
 b=GfSnDI/n34zQ+/Fm2NzFVQxxVm5tYt7w6f+uY6PZF4SHzxnOtmMwCfo5ED0SG1jhnUcGtHO+nyZWHkwHaMtnPMmqbOzNNaCnl0K5B+ymrdXrtm2h7rDJscHBFDYWxrLPD/V49nWw4SCcUxXHk3XWxTxVg4Uw4y6t77laAa+Q4AzLYAdZ2Zvhe8aOtTlwiXzlEzPRof96ukIR6a2wqjBdT3rvUj5LxU3m0EhogeSlGJTvI6v/H4KhhxFpdINqnJsuRwM+x+QzmS8Ii5c8Y9uloo6xYx3Tr0g8P/mhKXdn8GfbpdpN3J3hRM4wchEbn9NIgWN5cPn+OTM1msU/P34s7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 DS7PR11MB8826.namprd11.prod.outlook.com (2603:10b6:8:256::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Tue, 14 Apr 2026 20:46:12 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9818.014; Tue, 14 Apr 2026
 20:46:12 +0000
Message-ID: <b40362c7-a749-4915-93a9-08243ab09cb8@intel.com>
Date: Tue, 14 Apr 2026 13:46:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] ice: fix missing dpll
 notifications for SW pins
To: Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20260409102501.1447628-1-poros@redhat.com>
 <68b5cc9d-81d2-4ff5-9d3e-a6d6746dcb3e@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <68b5cc9d-81d2-4ff5-9d3e-a6d6746dcb3e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|DS7PR11MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b78c89-a495-40b1-ca66-08de9a66dcf4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0zp7j4oVMzZsKbwu02KoLCTGaLVJXvf8nUMUiDLPiLWaX+mzTXS67MXRyUvQ4mJX93WyerFm+AtD0OVYKPITqhXP9JvIGrnY4ehAHt9kxoFzGQVtuC6zvaEwxPBrPiKizCS2HU/jeyodXMb0Fsboea/Q8UduXhYg1BqvcgtPdtBkXoGDrQL0LdIdjtGoQ6nb/qaQPTYyC7CC4qdVAbl5HpuEczkdrapL5e0DvPxLjoeDXEDCqBT7ICI9veAxn6NicDwibYQBrTcRcmhCmaoZ3OaPHJ5OnK1RRuzhsyZCEsOUWey/XxX72Q1+jHVTP+bDoIg3PrqyVENzygEGrGDeNOcstQWfLZkxnPYJGM7mHqunjONBndqKaGEOPKOW8BnxhPGORRws6rq8Gp3RZ/TDFP6+AwmJv/R2GbLnIPbAEOBT/OPepkRmuo1bsZf1DWarWhi6fp5Q48vdZmhMMgnOZZ18KUPavz1t6ZaLZ5RlMv7UxrX3DHzEM7+u7OImtkwX7m1YkGNogrvIpGddv7cA80jAyVay2zPhoZ1MWmCXWDqPVFUxgA8m6UdKpsoxRuZemjxbJYs/3k+xKICD1t+9KScR0yF8yMIMhLHcdshZPp2tKp7j7lzAusdqoLlSgG3c2FVLxgxoXqMgA79n5qpsVMG3M13MPqN1U7W10mmUj0Es3fCKkxvgTgIHcj0z2xffVUmXUMt6bnDxsKjmgZnCiseKyCtuQxh6OSJLnUIpVks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVkTlRPdUt4emFLYlNaRmtvVWlJejJXUjJwM0xGK294bW1GcnVqK3dCTUx2?=
 =?utf-8?B?S2w3eWNYa0NtdTUybkZwU0N1SEc4QTV3ak5yK2xnU2ZacEYvUVBZWXFzbUR2?=
 =?utf-8?B?cDRZa0FrUXFmamJpcGIvMXFLWmlwalI3bHJmN3hXYnRXNHFZSk01eFdTRmdQ?=
 =?utf-8?B?aEw1OEV6ZVJVM3pxallCL0RRaGJxWFdBMEF2REJmRURoVVZJTmUwbFdPcU96?=
 =?utf-8?B?MXk1QU8vQXVyZUp4WjFDbzZYM2YwRmRncklwcm9uRFlFTmdBaWR4QWgzS2Fu?=
 =?utf-8?B?M0kxNEU4ZnMySFNmQ01DTFY3YnY0enFLUUhVaFZtVnl1RWNGRjl1VUtUMWw0?=
 =?utf-8?B?TVZCVFZ4Q0lFczlrb2VRQUJaRlYvQVMvQ01IZ09QNFVWSEhkZE9Wb1MvTnBo?=
 =?utf-8?B?ZHQrRVNFRTE1NzhmQjUrY0p1Sk5PNFNGMCtjVWs4aEI4ZzVTVFRrdGNaRlM5?=
 =?utf-8?B?K0J6K2RTdEFodXZCc1dLUWV6ME42ZTZMMkFWQS9kTWVoaDV6a05GMjFHMzZB?=
 =?utf-8?B?clM2K0k1OUhjcDJzTUxOMWM2d3pIdFVXTE0vQXMyZmV4bzI3Y210TThRQ2Vo?=
 =?utf-8?B?MFcyMW5lb1Urd0tnZHFYSGZVZlo1cUNBZFNYNFJacnV6Vjk0bmpMejJJMmVG?=
 =?utf-8?B?VU9yUnZKNGxqWjY2Y0FTanoyZXpoRHhZR0h0WjFoVno3SG1CS25zUHk3eUZU?=
 =?utf-8?B?WVNydXQ0UUg5dy9WYllGOERCREhoelo4cXV4eE4rZTZvKzBIazE1NVV4d2R5?=
 =?utf-8?B?MDdHN1cxeWVZQ3FUUDVWV1EraTRSV1JpeWJLbU5YT0Z3VjlxNE5FNVhnVUlM?=
 =?utf-8?B?ak9BMUxqbklyUEZrcGdrbVROeFJFTnFjSk1RcFVCdWluUWFEbGVzeEthZWZD?=
 =?utf-8?B?ank4bVRnaVBhd243ZDFRKzJ5WStaR3M4R2NxenJPdmFQb0ZMQlBuZTk3d2th?=
 =?utf-8?B?S2x2QXFRK1d0Mng4SzJKMzg1U2dzMllUbGE3Z3Z5bkREdkt6M2dDUWFINStN?=
 =?utf-8?B?NU8vY0dFVUttcysvVWNxdXZLZXZ5OWFFZmE2K1krTjk1MGdad1RJbVhXTFll?=
 =?utf-8?B?Wmo5dUdUUzlsYlphdVA3L3JURjlNOW9pdDhLWWgrVzc0VlN0YXlIZm5CSVVI?=
 =?utf-8?B?T2doRkx2c3B1cTAxeEN0dTZhbmZWTmxuVDY5NndWYWY3a2djRlpqYzBIaWR2?=
 =?utf-8?B?OUpyejdNcU44U3BOWjFDUHdFbjh6R0tlNlZzMkw1M2d5ZXY0SWt5ZlVubFg5?=
 =?utf-8?B?dFZsZUxxcHY3cVFsa1ZBdm9SdHdKRUtLdU44dlRtM0RjOTJwN0JLdlFKV1R6?=
 =?utf-8?B?Wm45Kzg0aTRMUHl6UldlOXMzTmFFR0FYMGovVCtVa3JXVVlyMGJSYUcvQ0FP?=
 =?utf-8?B?eGZRN0RkRVN6SlpId1pFRHpIOE9FZkNIMEowektjRWVJTjlqcUhiV29hL1gv?=
 =?utf-8?B?Z0hpVFRYK1lxSktIaFpVRmJncWR5RVphaGtMajROWFVFU2gvODB5RTh1cHFW?=
 =?utf-8?B?ZExaK1RIQ056QWZ1WTZwRHFscjQzU3p6ay9MbVB5KzI1MTZFRzM2WU9xNytV?=
 =?utf-8?B?M3hrL0U5OURCNllxVFNOYU0rdnY2ZnlGSjBaTThOTjI2cjYvTFdRdHBNakFI?=
 =?utf-8?B?RWRFQngxQUZUU0hWRmt3eHl6NWpNdFZVclErQ1VvUUltOHB1K0Y2ZmF3Qmp4?=
 =?utf-8?B?bzRTdmdoOHlVSnBUNE5KazZId3JHWi9CTHZSZmwyakhpQkMxd0tWWXp4cDhR?=
 =?utf-8?B?dDR1T3pma09DS3g1MWNhT0dGUlMxY2kwZzVBalppMjcreGZvVmRDRFJxcWs4?=
 =?utf-8?B?RW1heTR6OWpQalVQNE42aFhEWVNFVnl1RXFmR1lhNTQxMVE5ZHVudjMraG14?=
 =?utf-8?B?QllUUUVXajVkNm1kYnM2OEZkWXBwOS9icWJyc0s1UEhVZytkL01RSWozTHpx?=
 =?utf-8?B?Mk9rNG1hbUo5eFJrczBtc3gyc09mbUZmclVyTGRVeTJTQ1dMb0E5MWtEUS9I?=
 =?utf-8?B?ak83RHhiS3ZoRG52aUIyLzdqR0J3Y3RMSVVXOUtkeE1CQ1o4YitmMHcrWXVs?=
 =?utf-8?B?d1JNaFhNYVJZbHA3L2ZmQ3pCMW9hcDFrL1FzbDdxOXJkT0NWVTdJcDFjdmFD?=
 =?utf-8?B?WjhFbzZXRk1xcmJIa1pMOHJrTGJLUnQxREVUTXZzdTd4ejVYT0JtQ1UrT09k?=
 =?utf-8?B?cDE4N2V5TjRJb21zNTZNcEUzdnZ1WXBzVngydkpRZDkzQjI1SFNyR1lnZXI2?=
 =?utf-8?B?akhiNzErWnBGc0VOa3N0bSsxUlhwYktaK3IrNW9oQWNUSzBqeFlrazU3cFpu?=
 =?utf-8?B?TUNVaHNwMjY5ZEJHVFAzK3hsL1ovdWwyU3VscGgwSnJjSVBSN0VwdVhNRjZh?=
 =?utf-8?Q?4WeJ/U3ZuORJHrNk=3D?=
X-Exchange-RoutingPolicyChecked: DYQy7XxNMc6FMAEo9K5Olhr9myyr6JttO23CKyC0zGNZPHKdmjJFHlyB1LUfagu1YoFmUNs7RwQfg8JC+sMpEcnyzbVEYGOj8z5TzyAIAY/mOqzuCk9ISNtDT+buyLlAAbduRo2viO6kU8sUMJou2IPV/UkW8CqlgG55DUKvcaq7Gp/oLdWcLAoRxSKa/rk2xKjHCUGstrw4r4+84p7y0MIPxpOAxl8MYS7nucSCg4BEmnb3cEYdw/EsqAHvZPpYxcL6doWpak2qjJt3QbnYMle4c4XM6X1f4/qr5HotJZd3IYldaqPIdwXg83rp0aSmKyudANwiI5cdlFRvVZipSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b78c89-a495-40b1-ca66-08de9a66dcf4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 20:46:11.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1g2g9UzKxcznxQzkIMy8t+Qg/2eot7p2XfRsickxmDiOItvcxI9R30bV32G3LM2na4fCxgCa5tmBCIwuCO0YXh0s29zbaVGLpa/vDn6qQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8826
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-278579-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 18D963FE705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/2026 12:16 PM, Michal Schmidt wrote:
> On 4/9/26 12:25, Petr Oros wrote:
>> ---
>>   drivers/net/ethernet/intel/ice/ice_dpll.c | 74 +++++++++++++++++++----
>>   1 file changed, 63 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/
>> ethernet/intel/ice/ice_dpll.c
>> index 3f8cd5b8298b57..d817f17dcf1951 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>> @@ -1154,6 +1154,30 @@ ice_dpll_input_state_get(const struct dpll_pin
>> *pin, void *pin_priv,
>>                         extack, ICE_DPLL_PIN_TYPE_INPUT);
>>   }
>>   +/**
>> + * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a
>> state change
>> + * @d: pointer to dplls struct
>> + * @changed: the SW pin that was explicitly changed (already notified
>> by dpll core)
>> + *
>> + * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1
>> and
>> + * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
>> + * expander, the paired pin's state may also change.  Send a change
>> + * notification for the peer pin so userspace consumers monitoring the
>> + * peer via dpll netlink learn about the update.
>> + *
>> + * Context: Can be called under pf->dplls.lock, dpll_pin_change_ntf()
>> is safe.
>> + */
>> +static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
>> +                    struct ice_dpll_pin *changed)
>> +{
>> +    struct ice_dpll_pin *peer;
>> +
>> +    peer = (changed >= d->sma && changed < d->sma +
>> ICE_DPLL_PIN_SW_NUM) ?
>> +        &d->ufl[changed->idx] : &d->sma[changed->idx];
>> +    if (peer->pin)
>> +        dpll_pin_change_ntf(peer->pin);
>> +}
>> +
>>   /**
>>    * ice_dpll_sma_direction_set - set direction of SMA pin
>>    * @p: pointer to a pin
>> @@ -1233,6 +1257,8 @@ static int ice_dpll_sma_direction_set(struct
>> ice_dpll_pin *p,
>>               ret = ice_dpll_pin_state_update(p->pf, target,
>>                               type, extack);
>>       }
>> +    if (!ret)
>> +        ice_dpll_sw_pin_notify_peer(d, p);
>>         return ret;
>>   }
> 
> ice_dpll_sma_direction_set() runs to process a DPLL_CMD_PIN_SET command
> from userspace. It runs with dpll_lock held - taken in dpll_pin_pre_doit().
> ice_dpll_sw_pin_notify_peer() -> dpll_pin_change_ntf() will take
> dpll_lock again and deadlock.
> 

Yep. I think you could use __dpll_pin_change_ntf() which is the version
that assumes the lock is held.. but that function is not exported
outside of drivers/dpll.

Either way, this needs to be fixed somehow before I can apply it.

Thanks,
Jake

> Michal
> 


