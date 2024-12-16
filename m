Return-Path: <netdev+bounces-152128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B59F2CA8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC427188A700
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0950E20011D;
	Mon, 16 Dec 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkqzivQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683D6116;
	Mon, 16 Dec 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340544; cv=fail; b=EOizk/1WzmiuGGz3k6ycAjxRlMBvnq9DHElDt2EqQlzjrthGuI8WYgOU+RcbiEstFNmjESLd57JM7PU92jlgNc+ggE6WB05Ppy2JzbKLjqclrInVEaKHDnC2HdFw+kvxxjNMyypAPeFLt/0SNEuBMf52z1bA2gakXJ8D7UiihSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340544; c=relaxed/simple;
	bh=49NcVw4fZCOV6Cl7Zi/sSxp51zKw6F0A5vFajrvisFM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XpSOUX7+CNACUxZ7upEvnttnPhEGLJx4c24WoNrbzPY0WM4yhUbo91t3Fr7r1pgHUy9Ns6Qdiz1CE9oPLuAiCKBCfP7DiT/vgp0UjNIMA3niq+FWRZogAkjnkiWr3cHi2L2sk2diVfll5xiz/77YTfRc88VR2fIO2wh0AvYtZyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkqzivQ3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734340543; x=1765876543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=49NcVw4fZCOV6Cl7Zi/sSxp51zKw6F0A5vFajrvisFM=;
  b=XkqzivQ3pDlkATfEgRJ7f1h7Wwx2rVEhlzv000BNqC0JKM0AovF3+xZl
   j++UV7FVfbgqokIzfYENI4kE0ePXTNA0HJBXi2umDHaK5nvGYW8l45t7B
   gvnuhKJiKNtTGnBDeVEIsmPsSEJ7vZLXTZZs49kRcHtpdb8zaKMwWpvYI
   qOPvj7/Ku/OznrwPy38u6PV3gUeZHaUjGi2PPy9tutwrT8oAt9arPJa34
   +Ql2VZWCMug3n2GTe7PIVR12wDmUX4FVBkdYVSPM4TOn6GXCM4scb5DPJ
   z47TzofXLuJtWmLFbuu8tdN2G2ImZfWnPfl68s/+OI2H5SKHsex90eNB+
   g==;
X-CSE-ConnectionGUID: kqmg796/Rv+kiPF9yEl6dg==
X-CSE-MsgGUID: z/td00Z6QoiiOhj8tPPxbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34945206"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34945206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 01:15:43 -0800
X-CSE-ConnectionGUID: BbvRTucVT0C84vtCJdUHqQ==
X-CSE-MsgGUID: plfwrfe/RJm/pptYltoaEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101288492"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 01:15:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 01:15:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 01:15:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 01:15:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5LFjYBN3TJkJpQv1hbCJvc/ERj+2FaoFqAmxHfUw3Vctz0UjWtZ+YvNn+ooQmPu30EYl45xAmxteOnTXGrU7QAI87Ze1RXzVv0zQyk0Ni/GY5KWqLCK8j0HTPeC3NoF/bJzajnplFUBU/fuKvc29wDRTO7J/xN+GIA3FXWdkTLx+Kp5yEB1iZbgfbEWFfgrPVH2+fznGOv+mG8bW6+YW/kv9bM7RVBuvwxhQIxhBDwcEh0U6TYa3lSuzh15wsTagTSM+q8rei9OjZ9ium6dFvCTSu7DkNCLEM71JCLQqUbc/9rYE06S4tifKZC8upoIU6y0mf5o/KCVPjnIpNg8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnGlQPeBc1tUUrE9iW+ugzP0BQiKG1uzbpO1AlZwGao=;
 b=PGxbHc32EG2py1Wuz0ZnktkSVS6dV6Q9OChZvoZqn8QhWgBkk6Hw9v8JuwPNmpY0dmPmN0neQKbMTDNxHE11iKO7Do7QuLL0TU8Pa3/N4JBNLzF/EkGLvF0FXvlQY0v4l6ukdp6F0IUm6UB4tq4D+n1RbEoyEeTt6GrR1TIhoEv68+pXQ0aNp63RtfdTqUZpKR8bC8q3tHTUJhm74p0gCFBpV51STNvKP07ffWgCvhwEU1ZfDvc1aUVx/XtH4I5Rdhm2+WSaAGfAUqDdKo4gpNLSBncca4kjSIjl7t7uq7dMqtd13zDv0Kb+7OSgTO4JbtTAQeF543tUPjC/cUagsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH0PR11MB8190.namprd11.prod.outlook.com (2603:10b6:610:188::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 09:15:26 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:15:26 +0000
Message-ID: <4f79e5e4-8581-4a67-9016-72131336264c@intel.com>
Date: Mon, 16 Dec 2024 10:15:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/2] octeontx2-pf: fix netdev memory leak in
 rvu_rep_create()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC: <dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>,
	<error27@gmail.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
	<hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241216070516.4036749-1-harshit.m.mogalapalli@oracle.com>
 <74d65f76-5e3a-44b6-b857-42b6c8cf7789@intel.com>
 <b97b401b-e318-412b-8344-a856c6e10eca@oracle.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <b97b401b-e318-412b-8344-a856c6e10eca@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::22) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH0PR11MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 701676f9-ea1e-4646-198f-08dd1db22d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0J2cWdNUTdLQnZ6QXhFSEdYTzZoV1QwWnpVS3p2d215d1hSalBITG1mQWFO?=
 =?utf-8?B?S0g3R1Y4VFQ4cExWWXhWcEJGOHpwTlRIaVQ1SXZJUUlrQ3VYRTkvVEhrcVRa?=
 =?utf-8?B?cnJCdVc3T1htV09zcUNjNzZWdlJ4ZnBXT0RCTHV4SHRJRHhJbEw4VVBrUVhm?=
 =?utf-8?B?SXduN1lRR2ZSSDc4dWFCYnF2L1JTeDB5ZTNhbi9jQnYxb2lCdVpzWFdXb3hP?=
 =?utf-8?B?VFN4dUVETTdyc3NsN2R1VGNHZ0VlemRXdFdlS2Y0cHYzNERVa0dBeU9vTlYv?=
 =?utf-8?B?SkVtMWsrTVl6Z1d2N0lhaGJOUnl6OVh3bWdQSmtmWElBVkFRK2s1bVQvZllr?=
 =?utf-8?B?ZDVaUktTcW5PeVgzQ3RvUTRPOHVNR014cXkySko4cEx5dEkvNW5DTWhNeUtO?=
 =?utf-8?B?aTl4ZnJaLzRCTm9Oak1lYXV3c0gyT294MTJJb01DTENVa2IrSksrLytvM0hk?=
 =?utf-8?B?QUhpR2RRZWVqTFJobGFwbE9MZExsSFdQZlE1dFJNM3Jobkxrc3VOMVdUaEVi?=
 =?utf-8?B?RXRBY0Uza01KcE1wdWtYV3l5cHZiSmpHdXpBVEgwY3VFMElBdzRnQ2RDcUFa?=
 =?utf-8?B?TzdEN2xIbk90VGxWRkZiWVQzK2xkS2VMcjNCMm9reXMvY2I1UWVwRE1SNW9u?=
 =?utf-8?B?RHc5SzRLY080MGJpSm1qRnR2R2ZLY1BFb3h1T3M5ZERwSDRZRXRoalhjTHhN?=
 =?utf-8?B?aWdkd0xFNERiRFFLdEpqOEZ3Rm5STmM1N2JlZmtKelZ5Y2xDcWdXRy82ZUN3?=
 =?utf-8?B?cTlkM2dJUUtGMTZ3enE2U3JhWWptOXYzTXhTRkxCMVhVTFRuUWxJaGtYa2xY?=
 =?utf-8?B?dkhpRmxVemRoOGVScGdjUUxucGF3a3I1dmxZM2d5Z1RkKytJTG9JSzhLYkFl?=
 =?utf-8?B?V2pOcDFURWlvVWdLSUxVMUQ1UXFHc0RMVWFpcWc0VFB1czEyTFNvNnRUVmli?=
 =?utf-8?B?aS9KR0NoYmJVK1h5eGtrTldVYmlDcnhPaEpsczhaTjBzaDY4MlhxdUxLVjJY?=
 =?utf-8?B?aUFnL3FtS1ltVWFhVlk1ZUxqSmZqY3pjOUlibC9OUXIvdUJzcWVRR2QvUWll?=
 =?utf-8?B?ZEZWQzZFU0ZjNVlMYmN1eWFrdWxGUlp1bGQzVk1wRkNSemxwcUl3OXBlTXJz?=
 =?utf-8?B?c3I0aGgvMnRJeGtZUU9kbmY2U09Bd09wOUMwZ3dPUUljblBLSm9XeWVTSlpT?=
 =?utf-8?B?NVBUZVR6bEFla1ZpMmRhRkdkNm5CcDZCMGtQUEk1SWVMRVdtVGlzQUd4UkJy?=
 =?utf-8?B?ZERENnR6Sm1ZYTJaNEZYRWFXUTFraVFMQXZ0My9jWnVRYW9zMnR0b2NUSFdN?=
 =?utf-8?B?RXFURDJGZTlTRHFCZDNKZExMelowYitBelMrWmxVanJzQmZSVXpzR3NEU1o0?=
 =?utf-8?B?U0RkWVRJZDVuaXA2aGhZMktiZU1zZFhNM2dBV2dFMmRmMHNxU1BWcC9xMlpj?=
 =?utf-8?B?ZjFpVUxSRmFBVWFiaUQzc3Z6R2NZRUpHM2twMllIRkdqSzRaRmYvb2RnZ1pt?=
 =?utf-8?B?NUJ4N25tTXJ3SjJuV2RVOStFa2xWSW4xMVpoY0dDTXhaZCtUK0EvRHkwUzB3?=
 =?utf-8?B?UnNJTFdSREpCbFFSNndFbGg4WjJrUFdsU1NPWlZobnBDY0tmcGJ0MXBhYWd4?=
 =?utf-8?B?OHF4UG9XN052TXdIYnRFVHkwOGxyVGdGU3oxM21LOTV3RGtmeVh1c0RVNXR1?=
 =?utf-8?B?WVJyL1Vjbm10L1JwZnEyTUhtTGVxOUVwNXh1MThLcFVHQ1RuR1Y0eUdaSXYr?=
 =?utf-8?B?QzNQT2VoTkZZNnBiY1J4S0NIeVczT2p2cGNJdTIzS2tVdytDRnQ4bFVyY1FZ?=
 =?utf-8?B?REdRNUp3YnRRVDJEeVlaMEpQditrVCszeGtJVlBDZjNVTVdNU1U3MjRPOWQv?=
 =?utf-8?Q?mhGAmE5JqyRpO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkx5b3d5UlpRMTJKOC9lZVpYL083SXRxUk8vcm1LdEsrNTBFWEwyeVowZytB?=
 =?utf-8?B?OWU4cWhsWFQwd2FSeXZmTk83bERtelhKT0tDazNHQWErRHVmQ1pSbDNURFQx?=
 =?utf-8?B?S3N4cFRPNnlSL1dMU3BoZGU1VG5zeUZyS01ibUNKL1VscFZjK0dva3Vtb3F6?=
 =?utf-8?B?aWFFeEo0djkxUE5BWE5jZ2dxWUkxZ2lrWWtrWEZJK2FEY1NDcVlxU09FaUNm?=
 =?utf-8?B?OFBjTnRYTXdOcnhZbVlvb2pLWlo5Qjg5VUZGY2FDcXlwTURlUDBkNGhidkk4?=
 =?utf-8?B?ekZTWkhmQmV1MEdiV0Y2NEVJeVJnSmcrbHU2UGtUZkZLUE5ReVZTVDIrY2g2?=
 =?utf-8?B?UzdPMFFiZHphRnRpdEFKZU52NS9qZjBzc1grTzVIQXlLb1VoUkZpSC9ENzUz?=
 =?utf-8?B?S0tCTk1BWTRoWDN1RzVsSkZhMEQvWC9ubzFkWXdydmUrSkNORkd0c2lIVkhs?=
 =?utf-8?B?RUVBazVTTXlHNENjaG43L1g5QzI4dzl1L1BUNG9obnRYdGh0bnB5ZXUydnNI?=
 =?utf-8?B?VDY0T09za2h3bEsvdERkNm5BSk1RSVR2RHJQakpyanR6YTVEWlBwRFNxakJl?=
 =?utf-8?B?eFpxbm5vQ3BnRkRENWFXQWFMVktDYTR2SkEybFIxa29PaW10RnBiendiT2lt?=
 =?utf-8?B?MEtibmNNQ2JoMmV3akhzVEdGMGFSV0FjaU1tM0NNei83UituTFF2VWV4Y0tR?=
 =?utf-8?B?WVNndUc4RDBMQm9lK2dJTGFENFUvWllIYUVqRDhoZ3ArSnJNdnBuOXI2RnUz?=
 =?utf-8?B?VUFTbDRmOUNzODFpOUxyL04raHNrOXk1QW1zYkxoWVIwc1hWM1VVK2Z4UXc3?=
 =?utf-8?B?dFZFQmdxVHEwbitZWHlTSTFnTlNjUzkzQThiMU93eURCV1NBdTJJV0sxd2dX?=
 =?utf-8?B?ZmhiWkY4WVlQSHVmUU9qV1JVN1lzNUJ2bDV0MjBNNFhzdHhWL1FHaEc4MmxY?=
 =?utf-8?B?elVRcXZjZkhDV0IxWXBUdkpHdHlQMFFiUFhSais1eU1jUDlQRlRVMFF6eGM5?=
 =?utf-8?B?YlpRZEJmVTRLL2ZtSVNta3cyY1V5Mmt2bVBDTEIyY0VzWDJ5aXVHUkFPWjBv?=
 =?utf-8?B?ODhOczJCUElEdUkxNEJsVEZ4aWZjQUJKb0NjaWxNS01oZlBBVE0vbUs5Q3J5?=
 =?utf-8?B?alBOUGFYV2pFV1Y4MzROL2RqK2gxUDBZdXE2YjFzOGhQM1V0blZ0akx2NU94?=
 =?utf-8?B?cmRTTGJzdloyL2pGSmVRNU84b2wvSGIxN1E5TDNFQkxzWlRTbUljU29lVmJa?=
 =?utf-8?B?NjBIVlplRzlLaVVvSlNrVXFHWHlJZEV2QXRPTU1YQ2tLUnlvWDJ3WUpQR1Fz?=
 =?utf-8?B?cjFFRForQUkxdlBnUGxjWDBIQ01VeC8wYW9LSDhWTWJpZ2xXN2g3QXJzRFlz?=
 =?utf-8?B?M3ZZWWplazJMSjZkOUd3UFBwRWd6NmNXTHNuSXN6dzZScXQ3aFUydUdBNHY2?=
 =?utf-8?B?UzU0ek13clM3aG1YckRYbW8vN3l5UGdMYnBXQTJNU3diRXVucEI0Q3BuajBD?=
 =?utf-8?B?RjFlSm5UTDRieVF1Q1J3YjRCRDNuejJRTWpBMVQydWtBRHNLRlhwbktwNE9P?=
 =?utf-8?B?QWg5TmJNL1RxeWhrZzg3MDljRHRvSVozTnE1YjJBT2ZtcUxIUjRHYVN3OGFL?=
 =?utf-8?B?WkJZL3IyS2FIclVmMVQ4SnlXQm9LNjVNS2c3ZVZvM0JKUkkvV2szQXo0Nzd1?=
 =?utf-8?B?QVJ1UVpMU0VoaU1LbEhoYkx4QkRjMEJ2c000YnhId3BZOHFUQk9kUHNPK3RV?=
 =?utf-8?B?ZTdFZWtpdjFCZXE3RWplU0xBYUhGRWhpN3ZhRG5pbUF4bWRLMHJIS0VNYnBu?=
 =?utf-8?B?UThPMDFDN1daZTRYVStFTlE3WHNpN2IxUmRiWFNLREFZVzgwMVhpRmZCNG9Y?=
 =?utf-8?B?cGprK204UTRXK3RhYURQUEsxM1VhQ005YXVqUTJLRHJwdXpGM25TemxuYUwr?=
 =?utf-8?B?VXkwQ1EwVGtTTG1mcGg3ZnRrTnlXSVVaRnhMWGgxMzZVNzZYU3dZSlVXRzdm?=
 =?utf-8?B?Q09iQ2Z6bDliaW9Hc01OZ2tMcndxMkZjZ3Q5WWhhV21UeXdhdmZIL1IxS3FG?=
 =?utf-8?B?dEZNSG1OVDFTZFZudGMyc09PLzM2VnNkditGR3FEL2EzN0lKQ1p0aDVzNXhJ?=
 =?utf-8?B?a2RrVzZQUkZlanYxZVRodUhNbWdMQjBiZDN3WFQwcWEranQwTG1DeHFjVUMz?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 701676f9-ea1e-4646-198f-08dd1db22d56
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:15:26.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuXkwb+qiO/jNCz5rNPU1QwJEN0K76JO7pf3niU6gu2Ud2u12sPnDd9gYTuAFApPX3ZN0kBjToV+CKNffTBmGN+iE8vSa0LaXv9ItAZuX0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8190
X-OriginatorOrg: intel.com

On 12/16/24 10:05, Harshit Mogalapalli wrote:
> Hi,
> 
> On 16/12/24 13:39, Przemek Kitszel wrote:
>> On 12/16/24 08:05, Harshit Mogalapalli wrote:
>>> When rvu_rep_devlink_port_register() fails, free_netdev(ndev) for this
>>> incomplete iteration before going to "exit:" label.
>>>
>>> Fixes: 3937b7308d4f ("octeontx2-pf: Create representor netdev")
>>
> 
> Thanks for the review.
>> I would say that you are fixing:
>> Fixes: 9ed0343f561e ("octeontx2-pf: Add devlink port support")
>>
> Oh right, thank you for catching that. Will fix in V2.
>> this is also a -net material
> 
> So while sending a V2 I will include [PATCH net-next], that sounds good ?

Just [PATCH net v2].

Please add my Reviewed-by tags to both patches.
Please wait also one day, to don't send same series twice within 24h.

> 
> Thanks,
> Harshit


