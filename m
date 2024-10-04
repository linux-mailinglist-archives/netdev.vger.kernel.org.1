Return-Path: <netdev+bounces-132287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98EC9912C9
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BA12846D6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150A614D430;
	Fri,  4 Oct 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPHQMekJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8E14D2B3
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083110; cv=fail; b=NOkCgx8SQHzJEwk2xVkQtO/BjKwWaXh+g4gvqgQSJqLdBm0CN/penf5Pnz3Z4dJOptua77PhU1BUiCPO/0vQBnVIY3FS+gYo9K5unJoEdBemi7zgaVt4+lJ+6g5HbPNCqG+lINyAcngCCG1EwpaV+SjwtnK+UOHL/eaoTxO/U3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083110; c=relaxed/simple;
	bh=GUSdzzNriaenRE69CVoTwav3DTSnBnYgx9RJjTRpBP8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FYiVXMEc+tZr1UpChweWqE3tX33I0zPaFWP/wgjTDT1lRUn1H0WKlymkKbTRppP3GPq9XFWmfPwP9hwx/P/eT7f8R7FFnFZHwQQeCgdN/R8zLvS/wWDIw9/0bzLwYEd0bnEqx6oIHRF2LiJXM7NZEXy4aw8gq00rkDC1AE3vMhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPHQMekJ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728083108; x=1759619108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GUSdzzNriaenRE69CVoTwav3DTSnBnYgx9RJjTRpBP8=;
  b=VPHQMekJPNp1mbIPKgcBVxZOI4Cpu6jlpcdrxOCFTpOhdlEUMwT6XLyK
   k//rWG3BeCai+FzqYYB6J0bq2yn8/P9mYGHNbq2V+mM7RlT6uWgPy7DwE
   hO4Ip7GmWQYBAt4kVp9yTIOPAaQsTbByQBvWYwfhYsC+MEB9r1/PZ6/v2
   XqBSkKX2Mqx76Rv6BjhjrdUA1bltXGaOT3ELfw7nudpbbxLjdJjU7gqhv
   VCeMvB2jZ/pH8wQOf1KUUZnL+q/B/BbJbtXK6t9CoM46ELdNSqJNkuaAD
   rYKr/lldPASAg3LmRP9VOEwabwXnjtyaod0jYZDhl7Ju97a5FBY1knkYg
   Q==;
X-CSE-ConnectionGUID: F1VBm2IeSQCUp3wk4UiXpA==
X-CSE-MsgGUID: a6libZDWQUiKeErxuMq+Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37922113"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="37922113"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 16:05:06 -0700
X-CSE-ConnectionGUID: eDNpTA/pQLK23mXwW7iQNA==
X-CSE-MsgGUID: WO6uwhODSnePmgcLZPc1Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="79674365"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 16:05:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 16:05:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 16:05:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 16:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJZRrDEJBlHQL6uV65rCRHVEMQefaS14ZALnyjVhSrPe/XnHSBBXQjPc3B+l9z457msnxNTMjrLDQfjd/CL712xVlO84hC37ShxpsJtMG7QIJ6l7jJGYYETFOkH1qQwJCLFav+URhjA7mBzZaNMdA5UQ7rM4yUyUvDwkLG42ewbDRNmHpoHD9c/dReiWcw2tNXNIaKovHVNjul41SkP5FmvLsyaONbXb+jIaNXM3OqCWEXEa1hQYWN2XNnkexXhLQ/RWX70UGuJEJsxh6DiWm6VbADfFJF8Xu78lYHjhyxiTKbML5/Jryr8XQhbV0iin+skWLUV+mDth/zD1iGw/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9v+mpF9ukiGP23LqDAiyFRKRBtyBHR+M51SkaK9WYM=;
 b=zBJ5r8ku9W2oYTddnt1FFLem+esfvM018EcAaXushvmqHzV7+KPLMpxpkvuX+O59C6n+p+xmHrWpq32yeugWow/GVnIaLmA9VIl3QY3Et3aBgoUnW+Ko5Al457IlY8x74Tf9b9BGqzuV4zSF2NDQyxBpcP87q/PSQoHxeG16zoAVPRmrnYQO/Z1X/Midezf6j9ABBOtG4jpw32WxNNmSY7izJJC8QnDkzU2P5PyQN3EdPgR8dl27HITxDKPg7lWalbTUsZfdVnUCoOxSjOXzsMq1pcLt9f4eb1lJueOVvZVmSIp/i1dZqyyy8/u8znPDZdKvbcy6MqgGCSy/07QE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ1PR11MB6154.namprd11.prod.outlook.com (2603:10b6:a03:45f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 23:05:02 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 23:05:02 +0000
Message-ID: <9513f032-de89-4a6b-8e16-d142316b2fc9@intel.com>
Date: Fri, 4 Oct 2024 16:05:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] eth: fbnic: add initial PHC support
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-3-vadfed@meta.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241003123933.2589036-3-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::49) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SJ1PR11MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 90705a3b-51c7-4259-894b-08dce4c8fa38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WW1ZQmZKMVVUK1pkeGw0Z2RQUHRzVUEwWS9BRktoSVZWbkN0LzZ0dmk3L21M?=
 =?utf-8?B?N2N4eStuakQ4OEd1VUs0SEE0dCtzdHovdEtrMWxBb1RxdWc5N2U4cktTb2J2?=
 =?utf-8?B?T1pCanZxSSt4WTBNRVNGNGRObjVYMUQvWndNVm40MlUvdE5BM3A1YWJ6OWV4?=
 =?utf-8?B?MXIvN01oRHlNdkhhL2RUd1U1V2lIZlAvcVN3RVNUNSs4MjhYY1VTdyt1L1ZD?=
 =?utf-8?B?bFdQWHNVbzN5aHFLMlN5cWNTb0JzK25kcW1jNTkva0dPeElPM08xZUptKy9Q?=
 =?utf-8?B?cDRoSU9UcGNuSVMrWXpwRzlycm9ZMjZMdW9ibEdTMmpiZmg1eEZNc2JybHFS?=
 =?utf-8?B?NEl4NHZvQWtwcjd5QUxlMVo0TzI4R2hKZ3V1Nm9XM3d3ZDd4VHk0SlRQS3l1?=
 =?utf-8?B?cUZwdEJOaHUwNFhPcTh3RkNyZFJFdUNnSHJpSkx3LytBOUZieFBVTEwwM05n?=
 =?utf-8?B?akJpWEcyb1lRbGdCZ1RSdm9HVFIzUDYyVFFJeWZpV1lBdXZibGs5VUVyckZT?=
 =?utf-8?B?ZTB3alFycHBUaXNvUnRTcUxESlBUZmxyZHAvc1pibTlzRVlOaEpub0IxNmEr?=
 =?utf-8?B?cnkzV3NNV3ZJazhLMXN2bjMxRGErTTZqckp6UGFsT1BHMk1YdFZadUFzU1pa?=
 =?utf-8?B?YS9KWnp5WDFwWmU4QzlsbkhCMGRxaEZoeEhITTBGTHJxTklVR1doV3lSNDJB?=
 =?utf-8?B?WmhUcjZ0dHJkb1V2bjkyeHBuTUpQQjNpTW8wdVZ2OHRrVjNpVUN6RlJGa1dh?=
 =?utf-8?B?ZWFXVkd6allUMlQ3MzlXM0lBRE5BUTJGY3R6SGwrS1F0NkJiKzNwekMrRjlq?=
 =?utf-8?B?SVZzYnNxZzFRcnk5bE0xVWhnMDFDb1h3c1hZRzhGMzZRREJGMEJ5ZTdDQXJL?=
 =?utf-8?B?SGRDTGpMK2RCMndBR1VoMlBLK2szTll0eEdNN3Jrc0VSY281ZlpBS2hKL1FM?=
 =?utf-8?B?NlV4bjg3QURmZHRsdlVIRVNCMXNrSXd1QlNrTThZNU1WZjJPRjRlbjRwckJE?=
 =?utf-8?B?cDZ2TWoyVTB3Yk5FU2F5Zm5jZG13NE5rYUV6RG5kWmx5emtPcHNKOUZVam94?=
 =?utf-8?B?enAzVnBNRVJ2NzZHNkRJQjdwc1BRT0MrTzZlQWd2TzAwM1VnZGowT0puM3Jv?=
 =?utf-8?B?Z0tqQzhENnYvaE83WGdWbVE1TU1GaFJvZzQ1L0w5MWdSdkRBMlFxVXF5SU0y?=
 =?utf-8?B?N0hjUklMajNSQkRHbHF0eThzVThJK1lyb1o4SGJjNDBPSmhkcXRUbjZVVDAw?=
 =?utf-8?B?WnJLUS9rTlMzWTZmZk1pNjBlU3pMTmhPbXpPWmN3U2xiS0xaZUoyUWI1ZUwv?=
 =?utf-8?B?QmhjaUlQOU9QMkJEQ1U1ZW9oa3E5anRGQjVlblFNdTcwcW9oUjluQVk2bjF2?=
 =?utf-8?B?OTIyZStBNDRHZXhHb01iaFMxMUVHRWRlaFhqMHdXd0lvRVJiMVAzeGM5aG1y?=
 =?utf-8?B?R1hDTGQybnROc0p6SVAwQXFTelBueDZtYk01ZDlHeW1lSlVLZnlaRGtCWWNT?=
 =?utf-8?B?eFhMM3V4azVCd3hsSHh1cmEyNGNxU0wwbk9aRE03enhrOUNESUFiMEs4Qjdp?=
 =?utf-8?B?dE9pMDdKS2FCMEpmSUtLTmhyRnpNeXdSZi9USEYwd0M3Zml3SDV4czJnTk0r?=
 =?utf-8?B?VVEweXlwMFVNWUtHTFgyem9KZEcxbmZ3NzZxbllKVWZHQ0hRWFcrenV2ME1o?=
 =?utf-8?B?KzRqc3NSMHRTQjNLSVpId3JWY0lMeVBTNENMcnVIT1lENWZxQ3psdHBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlRMMVpQaGpHYldtODZ4alRWN0FBU01wMWJtcGZ0aUQvbkxnWlIwRzl2a0RB?=
 =?utf-8?B?MXdINGlNTVUrb2p2eE5ib1VKd1VmTGVCM3hBUXF0WUFobkpLK2hKTWRUZ0tR?=
 =?utf-8?B?L2V6M0NsY0N2Sy9tSHNJdmhkRmNSZlN4Y202N284QitCWDIrenpvb2ZKNU5Z?=
 =?utf-8?B?aUo0Q2FvSDlEcExRWnB4bmZCcjRGNnhpdU41bmd0UDZlNFNKV2pjdmNUM0Iy?=
 =?utf-8?B?SWpGcXRSTnBKcW01RzdtL3RlQ0MxeDQvbVhOV0hWZ1lKNnZNZXNOTkpsTlZM?=
 =?utf-8?B?NW5rL3pTaTFEYkZ0emszZjc4OWxmREV5b0dXcWpxUTllbUdTZmY3L2VrZHpy?=
 =?utf-8?B?aE14em1SWWZPOGJjV1locGtJTFVjTGNkK3pBM3VyVG9Wdk5XL01MeVVtN1RY?=
 =?utf-8?B?dUFBQXVIajVqNGpDcGhVelhxSzVOU2lYTXNUeXcwaHRyVGpnYWNJbmJWd01o?=
 =?utf-8?B?bGRlWG1JQzNKcjJBQ1B3MGU5Rzc5VjVzOGs2SCtodVZTME42QklxYk95Y21W?=
 =?utf-8?B?YVJXbTc2WlIwNWNnWW5ONGdPQW1CbXZUZXZ6TTA3YzREbEdNZUdIbzlhNzdE?=
 =?utf-8?B?anlnTUc2aXlaZlBwNm90OGNMSUhtanI0dktjdlJHdHozYmdHTVFtRDhmUFd5?=
 =?utf-8?B?SUdQS1JmejhWd2ltTUM4RkRvVnBKRTBXUFEvZUtOVFhETFA5S3FJa1BRc2xF?=
 =?utf-8?B?Tkc3NjJRVm1GSEF5MXBpa2E5STZwUldROURIaEU1a211b1hQMVZqR1doWHNN?=
 =?utf-8?B?YUh4WW5ZeW9aZmljLzF4WG1SOWZUK3g0TjVhN3pYTW9VdVk5bWFBQ0M1Qlhs?=
 =?utf-8?B?Y2Y2UGx1amRjU09PSUlOQXFpdy9qMWw0N3FuUGZ2TEx2K0RzSVVoaTBhN2Vq?=
 =?utf-8?B?V0V5Sm9PSEtBb3pmaGtMQ3pUSFRMbE4xY200Smxmajdub2ZPTmVqQktxSXJm?=
 =?utf-8?B?NU5SZVNIZGtmL1E4a0lZYzFvY0VpS0dNNWZyNlRqSTNmdzI1MFJIK1pPdDVY?=
 =?utf-8?B?dWVhMHo4VTZmNDRHekN4bmQ2V0JLd2tNMUlOd2Rxckd5empwMm1yQ251R0RP?=
 =?utf-8?B?OU5jQWx1T0NEajlSaDhucXh4amxXQTlaUk01V1NqSEttVDRuRmtPR2htb3dR?=
 =?utf-8?B?Nno5SExpMmVFYW9kdVZJMG1HK0lvOTc3Y2tBU0o4QWlkYlhleCtuN1QxM0xG?=
 =?utf-8?B?WVQxandKZ1Uza1loTzVodXJFQW9MeW41R09relFvV0FuN1Z6aW4zY2wxYkoy?=
 =?utf-8?B?Q2ZNbjJ3bElLcmF2ZUNiQSt2cEVKaFBwc1VYVXJySmJjaFZyVDZHUHVlRGdj?=
 =?utf-8?B?bVBpWFI0TnI4eXpUR0dNbmdwVUNhY21wcEJjclBYRmlQZm8ydHp3WWRqcDZj?=
 =?utf-8?B?MFlaNXNqZStmZ1E3NGhDVFNzckQzaTArY2tPOE05dVdsd1kzbUZBeFZiRXZ5?=
 =?utf-8?B?ZUJEOTYyV2g1R1BnRURPR3hFM1pPc1g0SnR3SThFQ1o0RjExYTNtSzBkb2ZC?=
 =?utf-8?B?TFB1WWNxRGxjZTJIRG1QNkdRdGd3bUxxNUlFejRFSU5pRHljN1VxOElvQjdv?=
 =?utf-8?B?RHlJWlVWV0VpVXFvR1ZkenRjK0FOTTQ0NE5DUzhUZjd1RjFzOVUvTlNXWlhz?=
 =?utf-8?B?ekMvV0I4cWdDSmt4V1dDT0RzUVdwWXk0YlZtYlBSWVVyK3N4RXZzekpGUDJ6?=
 =?utf-8?B?cWpBd0dDNktVY0pMUzZTc0VlMUJjUU44YWJLY1V6eVBBUkFUalZIaVdHd1hu?=
 =?utf-8?B?YVQvR1VleVJCYU9RZXFrT1I1UlA1eEtQeHE1UE9NVjFYaU0xaC9zZHdMT3J1?=
 =?utf-8?B?bWFoa1Z0UHl1cExnOEt1OFdCdmFPSjB3UHE3ZVV3MGowc09qU21Id09vTGF4?=
 =?utf-8?B?cmpYNVk2OC9TSmViV2xuTTZzTjV4MkxIb0M2Q2djQVA4OElnU1R3THFyWTN4?=
 =?utf-8?B?cE0rZVJucExKSVVhb0JvSGdSeEtxT05VK2pJUWVsUjBtQ3lKeGh2VXcxQVc1?=
 =?utf-8?B?M1B4YXNITUxzMEN0YUdyNTJDa0pIN1ZxSjhsN2I2ZlBGN3Z6WlFEd2NmTnRO?=
 =?utf-8?B?eXFyQy91eEZ6K2o4aHpXUVJtK2Nzelg3TFVOUS9icnhwOE5jdy9RbFlsNzVh?=
 =?utf-8?B?SjlISTJBelF1TDZGeWpzSTM4U1c2eXk3TU9ZcWNUd2NTWUxnSkNiTmNpMCtV?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90705a3b-51c7-4259-894b-08dce4c8fa38
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 23:05:02.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRIYDXxid9SBUFpsrezdLY6ypNia9GszpM/jDUSp3jglDQnRI6TgEfQRYXawMkb9/7b0hMjjJrTfHHrL41bovJYDf55HKC6l6oYOaQ5O7kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6154
X-OriginatorOrg: intel.com



On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
> +/* FBNIC timing & PTP implementation
> + * Datapath uses truncated 40b timestamps for scheduling and event reporting.
> + * We need to promote those to full 64b, hence we periodically cache the top
> + * 32bit of the HW time counter. Since this makes our time reporting non-atomic
> + * we leave the HW clock free running and adjust time offsets in SW as needed.
> + * Time offset is 64bit - we need a seq counter for 32bit machines.
> + * Time offset and the cache of top bits are independent so we don't need
> + * a coherent snapshot of both - READ_ONCE()/WRITE_ONCE() + writer side lock
> + * are enough.
> + */
> +

If you're going to implement adjustments only in software anyways, can
you use a timecounter+cyclecounter instead of re-implementing?

> +/* Period of refresh of top bits of timestamp, give ourselves a 8x margin.
> + * This should translate to once a minute.
> + * The use of nsecs_to_jiffies() should be safe for a <=40b nsec value.
> + */
> +#define FBNIC_TS_HIGH_REFRESH_JIF	nsecs_to_jiffies((1ULL << 40) / 16)
> +
> +static struct fbnic_dev *fbnic_from_ptp_info(struct ptp_clock_info *ptp)
> +{
> +	return container_of(ptp, struct fbnic_dev, ptp_info);
> +}
> +
> +/* This function is "slow" because we could try guessing which high part
> + * is correct based on low instead of re-reading, and skip reading @hi
> + * twice altogether if @lo is far enough from 0.
> + */
> +static u64 __fbnic_time_get_slow(struct fbnic_dev *fbd)
> +{
> +	u32 hi, lo;
> +
> +	lockdep_assert_held(&fbd->time_lock);
> +
> +	do {
> +		hi = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI);
> +		lo = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_LO);
> +	} while (hi != fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI));
> +

How long does it take hi to overflow? You may be able to get away
without looping.

I think another way to implement this is to read lo, then hi, then lo
again, and if lo2 is smaller than lo, you know hi overflowed and you can
re-read hi

> +static int fbnic_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	int scale = 16; /* scaled_ppm has 16 fractional places */
> +	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
> +	u64 scaled_delta, dclk_period;
> +	unsigned long flags;
> +	s64 delta;
> +	int sgn;
> +
> +	sgn = scaled_ppm >= 0 ? 1 : -1;
> +	scaled_ppm *= sgn;
> +
> +	/* d_clock is 600 MHz; which in Q16.32 fixed point ns is: */
> +	dclk_period = (((u64)1000000000) << 32) / FBNIC_CLOCK_FREQ;
> +
> +	while (scaled_ppm > U64_MAX / dclk_period) {
> +		scaled_ppm >>= 1;
> +		scale--;
> +	}
> +
> +	scaled_delta = (u64)scaled_ppm * dclk_period;
> +	delta = div_u64(scaled_delta, 1000 * 1000) >> scale;
> +	delta *= sgn;


Please use adjust_by_scaled_ppm or diff_by_scaled_ppm. It makes use of
mul_u64_u64_div_u64 where feasible to do the temporary multiplication
step as 128 bit arithmetic.

> +
> +	spin_lock_irqsave(&fbd->time_lock, flags);
> +	__fbnic_time_set_addend(fbd, dclk_period + delta);
> +	fbnic_wr32(fbd, FBNIC_PTP_ADJUST, FBNIC_PTP_ADJUST_ADDEND_SET);
> +
> +	/* Flush, make sure FBNIC_PTP_ADD_VAL_* is stable for at least 4 clks */
> +	fbnic_rd32(fbd, FBNIC_PTP_SPARE);
> +	spin_unlock_irqrestore(&fbd->time_lock, flags);
> +
> +	return fbnic_present(fbd) ? 0 : -EIO;
> +}
> +
> +static int fbnic_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
> +	struct fbnic_net *fbn;
> +	unsigned long flags;
> +
> +	fbn = netdev_priv(fbd->netdev);
> +
> +	spin_lock_irqsave(&fbd->time_lock, flags);
> +	u64_stats_update_begin(&fbn->time_seq);
> +	WRITE_ONCE(fbn->time_offset, READ_ONCE(fbn->time_offset) + delta);
> +	u64_stats_update_end(&fbn->time_seq);
> +	spin_unlock_irqrestore(&fbd->time_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int
> +fbnic_ptp_gettimex64(struct ptp_clock_info *ptp, struct timespec64 *ts,
> +		     struct ptp_system_timestamp *sts)
> +{
> +	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
> +	struct fbnic_net *fbn;
> +	unsigned long flags;
> +	u64 time_ns;
> +	u32 hi, lo;
> +
> +	fbn = netdev_priv(fbd->netdev);
> +
> +	spin_lock_irqsave(&fbd->time_lock, flags);
> +
> +	do {
> +		hi = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI);
> +		ptp_read_system_prets(sts);
> +		lo = fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_LO);
> +		ptp_read_system_postts(sts);
> +		/* Similarly to comment above __fbnic_time_get_slow()
> +		 * - this can be optimized if needed.
> +		 */
> +	} while (hi != fbnic_rd32(fbd, FBNIC_PTP_CTR_VAL_HI));
> +
> +	time_ns = ((u64)hi << 32 | lo) + fbn->time_offset;
> +	spin_unlock_irqrestore(&fbd->time_lock, flags);
> +
> +	if (!fbnic_present(fbd))
> +		return -EIO;
> +
> +	*ts = ns_to_timespec64(time_ns);
> +
> +	return 0;
> +}
> +
> +static int
> +fbnic_ptp_settime64(struct ptp_clock_info *ptp, const struct timespec64 *ts)
> +{
> +	struct fbnic_dev *fbd = fbnic_from_ptp_info(ptp);
> +	struct fbnic_net *fbn;
> +	unsigned long flags;
> +	u64 dev_ns, host_ns;
> +	int ret;
> +
> +	fbn = netdev_priv(fbd->netdev);
> +
> +	host_ns = timespec64_to_ns(ts);
> +
> +	spin_lock_irqsave(&fbd->time_lock, flags);
> +
> +	dev_ns = __fbnic_time_get_slow(fbd);
> +
> +	if (fbnic_present(fbd)) {
> +		u64_stats_update_begin(&fbn->time_seq);
> +		WRITE_ONCE(fbn->time_offset, host_ns - dev_ns);
> +		u64_stats_update_end(&fbn->time_seq);
> +		ret = 0;
> +	} else {
> +		ret = -EIO;
> +	}
> +	spin_unlock_irqrestore(&fbd->time_lock, flags);
> +
> +	return ret;
> +}
> +

Since all your operations are using a software offset and leaving the
timer free-running, I think this really would make more sense using a
timecounter and cyclecounter.

> +static const struct ptp_clock_info fbnic_ptp_info = {
> +	.owner			= THIS_MODULE,
> +	/* 1,000,000,000 - 1 PPB to ensure increment is positive
> +	 * after max negative adjustment.
> +	 */
> +	.max_adj		= 999999999,
> +	.do_aux_work		= fbnic_ptp_do_aux_work,
> +	.adjfine		= fbnic_ptp_adjfine,
> +	.adjtime		= fbnic_ptp_adjtime,
> +	.gettimex64		= fbnic_ptp_gettimex64,
> +	.settime64		= fbnic_ptp_settime64,
> +};
> +
> +static void fbnic_ptp_reset(struct fbnic_dev *fbd)
> +{
> +	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
> +	u64 dclk_period;
> +
> +	fbnic_wr32(fbd, FBNIC_PTP_CTRL,
> +		   FBNIC_PTP_CTRL_EN |
> +		   FIELD_PREP(FBNIC_PTP_CTRL_TICK_IVAL, 1));
> +
> +	/* d_clock is 600 MHz; which in Q16.32 fixed point ns is: */
> +	dclk_period = (((u64)1000000000) << 32) / FBNIC_CLOCK_FREQ;
> +
> +	__fbnic_time_set_addend(fbd, dclk_period);
> +
> +	fbnic_wr32(fbd, FBNIC_PTP_INIT_HI, 0);
> +	fbnic_wr32(fbd, FBNIC_PTP_INIT_LO, 0);
> +
> +	fbnic_wr32(fbd, FBNIC_PTP_ADJUST, FBNIC_PTP_ADJUST_INIT);
> +
> +	fbnic_wr32(fbd, FBNIC_PTP_CTRL,
> +		   FBNIC_PTP_CTRL_EN |
> +		   FBNIC_PTP_CTRL_TQS_OUT_EN |
> +		   FIELD_PREP(FBNIC_PTP_CTRL_MAC_OUT_IVAL, 3) |
> +		   FIELD_PREP(FBNIC_PTP_CTRL_TICK_IVAL, 1));
> +
> +	fbnic_rd32(fbd, FBNIC_PTP_SPARE);
> +
> +	fbn->time_offset = 0;
> +	fbn->time_high = 0;

Not entirely sure how it works for you, but we found that most users
expect to minimize the time loss or changes due to a reset, and we
re-apply the last known configuration during a reset instead of letting
the clock reset back to base state.

