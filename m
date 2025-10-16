Return-Path: <netdev+bounces-230016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9BBE3030
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEF8F4F95D5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209F304BB3;
	Thu, 16 Oct 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kc3Va44+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FC302CC9
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612890; cv=fail; b=DVsLOj4LHW3wHOyCWMniq42elMYH5dsubOxA1y4oGLKg31IaZGVKT+9Qa1lGG7QLu9792BWYELEZgrhLfA8jiD+vCPSWMO3U4uqMLQTvgrzfkt4tBib9kllJY8O0SuPgJUjPOQn4r+D8tAtRfjCvLH3RfMAwpmfGdfR6Fp1Ccd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612890; c=relaxed/simple;
	bh=7Ol7SJCAxrYicipXzQM8rpCNqVBFTHcEp+A5jEw8+/Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DaVpWE32Oq5V9pKTEvRjmgk0IrxEZzEChX88vj2ZVmVsFYWCvKLHS/VFJTJnCQyjNohtE1OMMWMvee1XssvwEGOrFFFtYSa0Oih/xziJe25bEhgkjeo6ihSPuWCVyahD2qzTxqlI/kaaWD57sH6sqQZA7lG1C09IXntPIxXDCPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kc3Va44+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760612888; x=1792148888;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Ol7SJCAxrYicipXzQM8rpCNqVBFTHcEp+A5jEw8+/Y=;
  b=Kc3Va44+x8M7DKowbvu1hK/zST+DeKlvgCNS8zdej4HTQnxUNFKh7S+N
   tiVzR7sboZQzDSd/cckdztJTgv4cqYmho8LRk4eUmu3ZL6C6JzMgB/ztu
   jKPwbnibSlTrv/sz6Hkc/qbwH3aaC6uSMXAj7H4jqoSMWSFzRX8Z1AsMV
   Kou00Em16p8CVs06qwrxcwwwstYYbGDggqYOT96x8IWlcXII0Na/WJnB8
   3tZDAk3eKsAc3m5DoD6QPuwqmMRjtfJYPIWZcspzWuS0dTpI5OjUsriBI
   fpybtgQdltb/4q4Gx2b0cIxome67wBPUYm549uKXavyGtpiqwHnxIf7vE
   w==;
X-CSE-ConnectionGUID: hVNu8LapQGGkTLG1y7Udsw==
X-CSE-MsgGUID: c8T1dF6jQxqhPENUTDX1VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62730844"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62730844"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 04:08:07 -0700
X-CSE-ConnectionGUID: u1t3xE9dTnG4TbZU+lw2Rw==
X-CSE-MsgGUID: deFO8bLeQhKa8pztfuGheA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 04:08:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 04:08:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 04:08:05 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 04:08:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLo5gAOYRKL5I1weOJAsWHXhv5TiMN1kEb0GBFMjwyY75F8p60LfDUen/ft1zeXhNx6L1K1nnI13pT7mDdiKdoEO2afeo9uk7zVQ9+upZsZA6gMqWj2xH87Od1AFK6zDY7QS4pBz186y4Or+qwVCFEoa28LFo6bbl9SsuWgm5uorIICp1J24wj53C2DkMzqSgG02+Q/eyl9Xbg2IVNWqzvalNghttJ8Oiekj1Ygl4ls6X4wmoiLk99r1eLkQuZDsprOSSpuO0ZGqsVqqgoHysqskifQgj4oxx8H4duXS1PmpDuuw0O95uMn1CMkJroBNIIx4esJFSMVnlXrW+wY8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoyuUq116OOIPdmYPyJPXhaO+GO1k+zpfmpAQZbyOXg=;
 b=RPSUuH4vcbnh5BfcLcV9Hy9grT0Pe82P2ZwcjVJRn3xaPr+3ibrzWl/iK56obF9leZxthA4HAjXE5Cg9Q3c2GKeaf+w8Pae9RatLM4AitN7bT3z+CYnisC183tgSY7iHZhPtnjnQ1v58yQe/gwiY6onR4TBBPHnKJ3kC6EVnl3ctiRPsHbA50R4d7v1SNAp3WN8DvWp+EHodO0s7KAxaGve6wDrJcxPqch3MZ1DTjjdd+aSCtJdnTYs6S5pP08JVW7m3figFlg8jC35vtJnFjiUkNN3RqNyHjjv/2Nl5Rkj/UxA+d6EC8ReWzalpDnIWR097y47hK0wEq+J2d5CoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 11:08:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 11:08:02 +0000
Message-ID: <73aeafc5-75eb-42dc-8f26-ca54dc7506da@intel.com>
Date: Thu, 16 Oct 2025 13:07:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251015233801.2977044-1-edumazet@google.com>
 <e3ecac24-c216-47ac-92a6-657595031bee@intel.com>
 <CANn89i+birOC7FA9sVtGQNxqQvOGgrY3ychNns7g-uEdOu5p5w@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89i+birOC7FA9sVtGQNxqQvOGgrY3ychNns7g-uEdOu5p5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0392.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BN9PR11MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaa2662-5c98-48b4-2a2b-08de0ca4461d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTdsVmFHUFBUcC9HbnhvbEhHSE5iVDFqWGJ5SFFFU2JQNmkyL2NFcmpuaXVn?=
 =?utf-8?B?ak9aQnE2d1VwWCtUeG9MN080cmdFUTBJdERKcDRMa0dlSzV1amgzMmdUY01t?=
 =?utf-8?B?dXNMRDlKVHFXUWhXYXJvaXAyeEx3RWJuMU0ySDJJTTEyT0Y5a3VQTDNzc1pn?=
 =?utf-8?B?WU9XZWxnS2thbFNaVlA5U3ViN2xDM28ya1NKbW1mdEJ1bGFnaWlMVGxkMzdq?=
 =?utf-8?B?NjBNNE5mSXFiNjFDVWJWZUxWVy9IWnVQOVVITzgwYlJpYjY3YkgwakJZVFRH?=
 =?utf-8?B?ZG8zelM2RWZBNEZYL2t6RGJGSlJHUEFoeGFPWmc4ZGlvc1UzYW9jdVB5RnRk?=
 =?utf-8?B?aHVzeWRSbXNGTThMc3MvMlUwQWQ2czdudXBwclRFN0ZuT2VpVko2eXBoYjFq?=
 =?utf-8?B?dDRQWko2T1VGcDFzNm1VMUtEWE0vQm5zK0djaUZnSjRZZURFZmNFSHdjbm9t?=
 =?utf-8?B?RXdudUIxMDRyZTdFd2dYZGlTTHhrN1F6UGo2dGJFU1lNMHVTSkQ3SWpUQ2ty?=
 =?utf-8?B?bUhUTkJGaE91RjhaYTFiTmcxSGNOSklnMlpUcGVhd0F1alB6bWl4dVJSZk1h?=
 =?utf-8?B?bzVKanRWOU9LVnZvT21rVndGWjBBWHRaVVJsd25NbS9xbjNDdTB5dlhnVE05?=
 =?utf-8?B?UktLRnZiWjJ3WSt2c0tvMFdiSjlRb1ZxMmgvbVU5dzVyT3JXNzlRWFpFOHJi?=
 =?utf-8?B?SlJ4eUxEY0NCNWs5NXozYks4cTEzKzhSNWpSdlNDMlVWVGl3dmFxcUd2TitL?=
 =?utf-8?B?RjZ5VnEwQW50Y3Jld28vZEdNb1pwSURpb1pzTVl3SXlJb3F0VmM4WmRmK25E?=
 =?utf-8?B?Sk1pY2hUNVdERjhnVWU3Rm1hZUlIVTVZZ25YMEFnU2Y5T2gvbm5zRnZiY2Nk?=
 =?utf-8?B?U0U0ZTNBeDA1NXlRVkR3UWlsaW95TXo5L2Q1eEtITUNOYjRGS1UvVVgvNXdQ?=
 =?utf-8?B?UlR5UnJ4bkNZNFB3OWxGTXQzK1hURk5NVitSQmJKalRrNzlZNENNNTYzT1Bv?=
 =?utf-8?B?ZzlOOHFpOE9TWnlqazdUeHhIUmJHZWU5UlJyQ1I1REliSEhBTWJ6emYrOTFR?=
 =?utf-8?B?ekJ2OElubFJweUJKbEN4cWlyaCtGVHQzajI5M3VEWVJsUm1hTmc2M1g2QWRy?=
 =?utf-8?B?b2lZUlVENkwxOGFRN0dSQ2xPamRKNlVnQUY2LzM5ZFZHS1AwK3MyUThZRUth?=
 =?utf-8?B?MFBVcko0aUJjRThuOGUwb2pkZzJJcjhJa3lwUWthYVdCSVBsaThFQVVQRDYx?=
 =?utf-8?B?WkNRcDZXZUFHbERZcmdZNnMwTTFtS0NGblNVOThwSzV4UUxhZlVJMXlob1hU?=
 =?utf-8?B?ZU5xa1VSWGR3N05EWEJ3T2FOZEZNM3YxQSt6QWhFSE5CL3NvTVVCK2VoM3FX?=
 =?utf-8?B?VE91TDZVbzh4cWhmNjNxZlRnTm42S25zMkZ6WmJDODEyQkdSaG1abmRQZDIv?=
 =?utf-8?B?L1dtaDB3WXE4bzBlZm5sY0lFTEFWVDFkN3ZnSEFZOHprejlrY25lU1BEOVQ4?=
 =?utf-8?B?TzBPT3JhWndMMTFxelE1Ymc0bDR3MHVYbVN6Vno2UjA1ODBWZ0lJb0F6VE5z?=
 =?utf-8?B?SUYwVU5kaUZ4ZGhHQTNRVFlRQWlDajVneFJVdG4zQmtVcTVyeW9zK2YvV2RN?=
 =?utf-8?B?VTF4RXFHR1l4TDE3aTVmd0diUXBwcHIwR0tBamJORFRGTEM3SWVVdDF5TWFz?=
 =?utf-8?B?WHBhL01MU2Z5UDNIYlFWL1RNQmRhWlIrSThic2Yxa1lidElvSUVURkpNYTlH?=
 =?utf-8?B?QzE3bmlrOHZhRExOTFZTcXZKRlFGZjVuUVlETVo1eWxHOFJYVEMwbytQNmwx?=
 =?utf-8?B?Nm9obHBnSEl1ektzdXVPOG1XbGVqL3JjWDdsR2lkWEhwTk11YTFGYk90WHRn?=
 =?utf-8?B?ZVhMUytPc1NTRGtkenkxMk90S1RkVi9wMGppeU5oWDJ4eTNjQld2cUh5ZnBB?=
 =?utf-8?Q?uwez9mTq4/yw+ahsjmalviLy0/KEgdq/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEIyNDZ5TVFPR285VmxtY3BrajZ5dUx5M085NG91MFdoMlRoUEhWcStvdHZn?=
 =?utf-8?B?YWM4R2V5QTB1b0NSaVB1QzNtNCt4cFcreWZyQTVlWnlOR1liK1NiVldiemFx?=
 =?utf-8?B?YmhBRlhFbzlMRkVLTGRQMTRaajhZV3ZMSkttZ2o5SzRkNkFOUmRoQ2lTWUox?=
 =?utf-8?B?RWtvV1lWMGx2U05FVjJsSHFyenIxdkJlNWtSVXFDOS9uUWdLNTdXdmFaVmcx?=
 =?utf-8?B?c0x5dDdDVGFLcFFKYnpqMDJQWnA1ZC9GR0Zva3cvQkhFQkdROXlmbUo0UVFj?=
 =?utf-8?B?ckkydW5LN0hGZEFSaHJyZWlRWFJ2QUJPQ1JERTJKRy9oT2I2bkxzUDY2R091?=
 =?utf-8?B?clN5YlE3clNiZ3Y1SU5lTkVoZEtKQUhvWDl0VXlKT2RvTm95UDhYQ282K1lM?=
 =?utf-8?B?YldCLzdGTGV0UExqYUNKYnhSM3ZxcU9FdEF4enBMWU9vZ3E2djZJRVUwM1dW?=
 =?utf-8?B?VUVZSmRDVkxXdWlzNXpvb0pRYUVxNmlxMlZRQzBEbEVYbERRc29jaDE4dTBR?=
 =?utf-8?B?VnVXOXBmMFhpeXB6WkFSWDRPZ2p2UHp2ZlduM2FEQ3h3S3l6Nk5pSmp6WlIx?=
 =?utf-8?B?NGVQc01FNDIxQ1ZjNllncENiZUZwdndsZXVhUSt6d2p6Y2xqY1cySUpWK1M0?=
 =?utf-8?B?dXlYNnhRMDBKTEw3OUsyM3Eydkxnc3NQYzVvNk43V0VySXBMWE5mWE9tRDVX?=
 =?utf-8?B?dWd1TU56WG5xdktjcHc0MXVIVDUwYkZVUERHbmFybFpRTE9kbmpIeC9tQUFE?=
 =?utf-8?B?U0dTSm5oNEIzc2UvTDFGYUpZZDN1N2M0ZlFzWFlEWHVaWitSa1lpRGJjelNZ?=
 =?utf-8?B?V3VWeG5DcC9LTEFvZkdDS3B4OGZIMXNYbHlyNC83VUZJSjc5ZWUxWXUyNG1n?=
 =?utf-8?B?YTlhQ1ZueC9iK2ErTHVneG9teUVqOGxtendyY3diRWM4bktLWEltU0ZGWHQr?=
 =?utf-8?B?aTFEbjY2YnRLb051QXM5N2FvNWhNdXJZRzZlQzdDcEFaK3c0QzF4YjJZazI5?=
 =?utf-8?B?citYanFmM1NzTklvTmR1OVArQThRa3NzRk5pN290ZUgzTVhYT0xHcVRSWDBM?=
 =?utf-8?B?V0l0MFJnV2hoTnN0eGFhbU1DTFhzTy95ME1NUGhleE5haGorck5sSjdQNjBG?=
 =?utf-8?B?OS9TWVdUR0tsRzhVQTRLRC9MdWRqY2pCZjBJVlg4R1RYb1d6T0RhVXdoY0Qx?=
 =?utf-8?B?c3E1aVFHTGJnVFN0MUtUdm00ZFZrR1U5b295SGU4K2NYYllXbnB4VmQ3eWFF?=
 =?utf-8?B?a29iNDBaUGtXOXRIUnVGKzg1TitGZUxScXhmZ2c3YzVxUnRkNnpqYVprZGQw?=
 =?utf-8?B?TCtLdmVYYkREejJmbDRwa0xkK1g5UHo0YnNodklZNzdmdmh4WS92aFJaTDdn?=
 =?utf-8?B?TjVrMkFSQmVNOGhOTVViVDVUMEtYamlDaWs5RGkzNHppUXJkQWZFWnJEZVdQ?=
 =?utf-8?B?cGVOVlROM3B2d1VSdGJGc0ZIUW5oR0pCc0dzNXJYMk5INjFYbzNJcGhZV1Jk?=
 =?utf-8?B?MmNkbUMwRCtWSXRka3hpakpLY3BET2t3MUI4anZiUlJEakRPOTNhNUI1OUEy?=
 =?utf-8?B?L2hyc1NITzl5TnF6QXg1WlVRd0Y2Y1BxYlgzUlJLUjRGRFhla3pGQjdsN3hq?=
 =?utf-8?B?TnlhUW9xRDEySXZKT0E2cEtzdythQTl2QnRRa3Q0T1dDcVZ6ZlV0UEp4WmNv?=
 =?utf-8?B?YThNWk9XYWlYTjNxYWZQZml6ajRJOTVNSkJ0WjNxOTVSei82UGk2VnBiOGpn?=
 =?utf-8?B?TGVycytDRXM0LzN6NXY5WjdmWGdtOFpmZHN2ZUJoTnFxSEZKckMzaXFsV1JX?=
 =?utf-8?B?a1ByUEJZTW5tZGpBcHRZazhKMWdxclFmZFNFZER4NjJBcVpMS3dSclJpUzd5?=
 =?utf-8?B?RUs0UXNabmJoRmVTNWJCOGJjei9UbVU2N2l1RHpVVDJtY0trWkRYSDk5T3dQ?=
 =?utf-8?B?UVMyUW9FVjlqKzBHNC9vQ09KWVBHM0pBSGwzWExkNGR6TitENzI5anlJZDVC?=
 =?utf-8?B?RnVMVTQ2eUZpNlp5YyswallvZEFITkltalpKN0EzREIvY3VCNExpNDdrbjk2?=
 =?utf-8?B?LzV5QlpnZmYyNFJhSzYzd0p5TERLR21kandZRnZLUHFhSTJYUmd2VjQ1NWJv?=
 =?utf-8?B?eUZZRm1pa1V5TEEybDRadzJUVnJ1eUp1TFdWMXF2cVRkOEY5MDQ0QXlqL09B?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaa2662-5c98-48b4-2a2b-08de0ca4461d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 11:08:02.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E71Cp6H1kmJRpiznJSOqFOBMFd3CSZ7OgnR3CmoWhVEjAcfMOgiEsw3ydsgtjtvt0ymCloUWAXLGyOHRrzg5L/qGmy9VTtUD4u+uqoUy9Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 03:31:37 -0700

> On Thu, Oct 16, 2025 at 3:20 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Wed, 15 Oct 2025 23:38:01 +0000
>>
>>> Following loop in napi_skb_cache_put() is unrolled by the compiler
>>> even if CONFIG_KASAN is not enabled:
>>>
>>> for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
>>>       kasan_mempool_unpoison_object(nc->skb_cache[i],
>>>                               kmem_cache_size(net_hotdata.skbuff_cache));
>>>
>>> We have 32 times this sequence, for a total of 384 bytes.
>>>
>>>       48 8b 3d 00 00 00 00    net_hotdata.skbuff_cache,%rdi
>>>       e8 00 00 00 00          call   kmem_cache_size
>>>
>>> This is because kmem_cache_size() is an extern function,
>>> and kasan_unpoison_object_data() is an inline function.
>>>
>>> Cache kmem_cache_size() result in a temporary variable, and
>>> make the loop conditional to CONFIG_KASAN.
>>>
>>> After this patch, napi_skb_cache_put() is inlined in its callers.
>>>
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> ---
>>>  net/core/skbuff.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>> index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..5a8b48b201843f94b5fdaab3241801f642fbd1f0 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -1426,10 +1426,13 @@ static void napi_skb_cache_put(struct sk_buff *skb)
>>>       nc->skb_cache[nc->skb_count++] = skb;
>>>
>>>       if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
>>> -             for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
>>> -                     kasan_mempool_unpoison_object(nc->skb_cache[i],
>>> -                                             kmem_cache_size(net_hotdata.skbuff_cache));
>>> +             if (IS_ENABLED(CONFIG_KASAN)) {
>>> +                     u32 size = kmem_cache_size(net_hotdata.skbuff_cache);
>>>
>>> +                     for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
>>> +                             kasan_mempool_unpoison_object(nc->skb_cache[i],
>>> +                                                           size);
>>> +             }
>>
>> Very interesting; back when implementing napi_skb_cache*() family and
>> someone (most likely Jakub) asked me to add KASAN-related checks here,
>> I was comparing the object code and stopped on the current variant, as
>> without KASAN, the entire loop got optimized away (but only when
>> kmem_cache_size() is *not* a temporary variable).
>>
>> Or does this patch addresses KASAN-enabled kernels? Either way, if this
>> patch really optimizes things:
> 
> No, this is when CONFIG_KASAN is _not_ enabled.
> 
> (I have not checked when it is enabled, I do not care about the cost
> of KASAN as long as it is not too expensive)
> 
> Compiler does not know anything about kmem_cache_size()
> It could contain some memory cloberring, memory freeing, some kind of
> destructive action.
> 
> So it has to call it 32 times.
> 
> And reload net_hotdata.skbuff_cache 32 times, because the value could
> have been changed
> by kmem_cache_size() (if kmem_cache_size() wanted to)
> 
> Not sure if kmem_cache_size() could be inlined.

BTW doesn't napi_skb_cache_get() (inc. get_bulk()) suffer the same way?

> 
> Its use has been discouraged so I guess nobody cared.
> 
>>
>> Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>>>               kmem_cache_free_bulk(net_hotdata.skbuff_cache, NAPI_SKB_CACHE_HALF,
>>>                                    nc->skb_cache + NAPI_SKB_CACHE_HALF);
>>>               nc->skb_count = NAPI_SKB_CACHE_HALF;
Thanks,
Olek

