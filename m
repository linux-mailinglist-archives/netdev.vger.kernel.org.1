Return-Path: <netdev+bounces-301396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ExbgHxyfOmqwBwgAu9opvQ
	(envelope-from <netdev+bounces-301396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:58:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAEE6B81BE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:58:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MYgXKzQk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301396-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301396-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C5FF303C8C4
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2293D6487;
	Tue, 23 Jun 2026 14:58:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD263D6475;
	Tue, 23 Jun 2026 14:58:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226713; cv=fail; b=DTweKywmhbKiW99N6dpJ1GgYDhuqXJbUJBDgBWagzvnt6Hovg2rUfPgPfYMCr1+WcER5QmxULl+dbLfCg3fAoytOxmB4HpKEKmFISDT2gKY3pHrUZxoBJ2C/Vpx6+M4YOXwvb0X+sKyL8d1MMieklkkZQbjuuhVgY07gUrdJKKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226713; c=relaxed/simple;
	bh=CRJfAz4h9iOQF8k8FLkW9jzFYogfpPkTZzEJwoyqFdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SF0j4lFn5Lh/Qe93ka3Ut98/+e8Pwz2sUmWx/nztVOjlMjQGFpOLDZnWoAQMpXBkSaUxwiUsm15tiG6spaJK02ohbZNy7LRBoT4fE8OXvhzelPibmCX5968L+tXlLFcXunA4H741REO1ePJow09qKrQWR8T3hiDD9xhg4tqo388=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYgXKzQk; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782226711; x=1813762711;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CRJfAz4h9iOQF8k8FLkW9jzFYogfpPkTZzEJwoyqFdw=;
  b=MYgXKzQkNc1AL4HK6BQn7kkHEYRLtVGCnm0mdwNdEVnSqamQrcFyNrZ7
   5k1XMOwDqhGanenXFHcmGa1RxuZXQaaiqkYKDyGaAKs6Q82AiHv92HqS3
   HjG9fu6FGKOL4pgmx2qpvNHMRZWTR859B/VhYCRFPLmJ3a9Y33uDg8UWp
   DWKIsrhzNDbuf0H4HgTgGJ/qkbMEEJAaNFxHyo8OpGeqoX1tQE1gSEqVh
   xTzkLScRI6DhtSrLdh4jXuDVHaZ7s/7CATYHj38JuHWy27ItB8Nm01S0Y
   jrgKOfCRtGXxjO0RqY/QWc6Ez9nmPzb0GFrE8FhqXaXJkB5S3upO0GmpJ
   Q==;
X-CSE-ConnectionGUID: H3p6Ub7vQeqCl6ZrvHroEQ==
X-CSE-MsgGUID: 4PkxMKENQheW7M+Ny9WTZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93560612"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="93560612"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:58:30 -0700
X-CSE-ConnectionGUID: +DaKcmcES2ifof+tKY0JlQ==
X-CSE-MsgGUID: VVCMJTKHRBOepvEhkdQvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245404400"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:58:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 07:58:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 07:58:29 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 07:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjKo9GWpOOtLGirdikvquHAvjrsEPg7cYGwwsdt4ERYJiHli8IrAHo4flHjks1/toJIGFnBgKD147X3WI5SE99Zayc5gKOiZZJt+K8C2o0WWmM5pk0b1SiGe7Oiv+Yn3dXrk5U8Z/Pdsvd6G2cd2CRLH/RPpnnIHR6VNhKrWlr0Ape74iIXLWQ18/sOBV7wxAFxJRJQls3EidfyElDQFtP1jvcniiVYIbNiGlYYz4KCyPmpU8FFDQO00ccm2KmHsx6FgykuHAasVrN58cI2fwNG7V5Y9r1okZEJVsenOU3uLnrNyD/ayz4nXMtRAx0SBNxTRylKaZJ7DLFkOvDP1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDaKncsvUGq+r8tqj/+Qgx53nbc/GKHXNvTdo5qp7K4=;
 b=WvK3xgy55JQxzc5+yKtdtsMfxt1116Wfu4aKJ8S5uAhIW6FEACSmqOPlqd+wKoroBdjZ5lhefmljrThButqHMeW+fgmx3teCNeNsTEMj+lfiY2vzV7VWmwBXYystVZNV9PsmNtPtBqwk9WEEXEmsPkurNB1heuZwUZdsBrAPJiwjlBMo1wAtiFi4XT+VlROdm8QR0UCfCh5YCkW+E7vEPeySYjl7Ib0HIPbGq5uw8EoL4Sjbl462rFHnJDgzZ3tJs+bEZAWWby9ymPiHm+hyB1JEOu3eghsKOsdNV1RVCuwAPG5yKvknQtaSTOxowDzpL2s+SB/5+FJfuw1M+tNXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH3PPF1AF044E07.namprd11.prod.outlook.com (2603:10b6:518:1::d0c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 14:58:27 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 14:58:27 +0000
Date: Tue, 23 Jun 2026 16:58:21 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jason Xing <kerneljasonxing@gmail.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<kernelxing@tencent.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test
 behavior
Message-ID: <ajqfDYznpCU18C2P@boxer>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
 <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
 <ajJsMj0QMOF5I8qq@boxer>
 <20260622160706.0b4a27bf@kernel.org>
 <ajpLuDNCu2PHS78l@boxer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajpLuDNCu2PHS78l@boxer>
X-ClientProxiedBy: DB8PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:10:110::32) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH3PPF1AF044E07:EE_
X-MS-Office365-Filtering-Correlation-Id: e55aef15-9120-4e8f-040f-08ded137e1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|4143699003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bnZ8BbUQ4RZ5xEdgnbYZL51dDsk29yZK/pVnbmBS+m4AQ12bkJ/TGroc0JHqIZf8vYgp/pMwzCMwQCHxDYvMlaPV8tpI/pRo6XIT4fooH+DIIjWNat896WSDX+TPyl4yvlbRcLz6weLcvE7AeMg55vCD+9wCgBJDdxrYTA6X6148RxulzNAAqkdctrB0fls4GMb9NyJ4a5DllhEf10vTYHBnI5EcncSTSEyHLVHLCl6DQr4cYlbUSWxBvDAVUgJyLnBK6DPDLhJNVUKs2JnBd5ayvjytCDqd7wwyCZiK7S9qsZwZDtuaYFkM0PrckXSX+lZSJHuRpSmtLrAVUJhBrBKK75bqBE9zcEn4vOs0aL23pO9EL3mX1fkmYH5Gw9U3uel1ALx1s+hd8IQWU6ZmAHuRiNC7fYXZywa4hZiIJyod1o1/RhHktwan+HWKLIWfV/d1DrLuJIZ9RGl4H8p425giBvM3fsrv8LpfydVMJ+fOlXMDVrWNVkFgZ0rJP0ovrCEXid9AnH0rLPGdz8BFURRHlk4/0xE+tDlSIW6kuIpNVbUrKW+qgtYc7kQr0FBFtCIU0AIOIg1y0oaANJ8dlfcaLuQyJI8p+bZvX85GvFpe1DE5Rgv2LdrvPNYtJ+2HNHiozF+OmP5PS8mI3OkB0QhaN2GXCUmSpUqKNTnagP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(4143699003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clAvSDVhZHgrR0lpRlZiMVBvRnhuMVg2YnBSejk0MnFVVHg0WWFZVTJRaGlG?=
 =?utf-8?B?OXh3Rk5sV1ZqbkZtSVBsZ2sxWlloc2tjbUs1Ylloc29lVzBscnB1S0Exd1Y3?=
 =?utf-8?B?MmpBYWJKMFhSTDM2SnNRd0V5RTB5OWxYMit2RmhtNmpoU1BhaTZSM1FvRVdu?=
 =?utf-8?B?dkx1anMxeEFmMmNIM0ZscjFpcDJWRlBBcFlSRHR0dWxEclM5alNGcTJmRmh3?=
 =?utf-8?B?a2pwR1Ryaks2VkQ3ZlMrdlRwRkI0YlVYdzMxZUx6TTJaTzhtNjZlM0VDY3dU?=
 =?utf-8?B?Rk5nMDlrendxeGpMRzd0M3dDRklCRGVITHRDZ292R2djLytNV01RdmhkZ0NK?=
 =?utf-8?B?QWJjK2J2emhaaTBaZWVvam5ZejE3bEozRVVoU3o4UVAwWEF2ZmE1RmtiTUUy?=
 =?utf-8?B?a05WR0dDY1l4OTZjRHpQQW9hbkRhblVnYVF0SmhOVjN3amRXYmNPd3JRTGF1?=
 =?utf-8?B?cUdoNXF2ZGhGMklVRWFwOFFjZ1hCcXY5MlQ4aERhUEdLMVZMai9vcVppSng4?=
 =?utf-8?B?L1BHQzUzR09ZYVoxL0Y3ME5PaFVJNkxubHh6NXArQmtjaHBKekJ0VG5XWGk3?=
 =?utf-8?B?QjVkSDFoRzk3TUZQMUhLd0lkWFNVOWV3QjJKeGVmdlFMNEtOWFVpOVBrOG83?=
 =?utf-8?B?V0FvOUJlWEE5ZW03cElmajRJS0VVRHBtbmJWSlZQZ21Pb1I5aEVPSmYvbWth?=
 =?utf-8?B?TnhvUml2VEhrM1NlY1ZlY1VMRHdLTWkrVm1sd3dOOElaallHeWRtWWw1dUcy?=
 =?utf-8?B?Ym55c0FwMG1uM0RxenUvc1gycHEvMEJkMVF2TzJjRllPTy92S0w3YmcrTzNl?=
 =?utf-8?B?ZDN3c2djc1JycXZzcS9ZajR5c2JleEVwN3JwZVNrS29RQ3lBYjlBSGs5ak9p?=
 =?utf-8?B?ZHc2SVRRMDkzMXdSK2VTUVlDN2FETEVwVXNNTzByQ1NLWFUyT25vVUgrU3lQ?=
 =?utf-8?B?OC81WkljbHltWnNCclJsd295eWduajhDQTV0cHhZUlQ4T3RpWnVWL0EvYjRU?=
 =?utf-8?B?REFyamdVU0FnMUhFb1lVKy9IQStrZzNvWlQxUXN2eXFQZ0VObHlSMEtDR0lP?=
 =?utf-8?B?TndmTzc2WWdycEpCWUJYWEx3aTJ0WkFNelcrUEZFclJmZk5sRGRIWUtJUkJX?=
 =?utf-8?B?RmpZU1c1anFhNC9HczYzcVROOFh4MjIyUU5mNVhzNW10QXF4QUpZUkpOU3Na?=
 =?utf-8?B?azBMYXkyajdpaGRYSWtLZEY1RVBpQUdPL0ttK25yWERneE5qT3Z4aWhKWlRN?=
 =?utf-8?B?N2FqM24xWXN4b3lFY0lWK0I2bFN0NmpaZnBoM2N3WWRXSDVOL1NkdmtCTmg1?=
 =?utf-8?B?OUh2UU1aaW4yMU4wZFJwVGxMUWlUY2hZSG90T1FobTVIOEdhYUdnWVg5L1Ny?=
 =?utf-8?B?THV2cEFaVUNvVm03MGVNSlRPem53MUlpeE1RNTN6MUdIb2xSQm5EcDg2akNk?=
 =?utf-8?B?MWM2WmI5NW1qUUU1TS9UeW5JK0c1VEo1TGhGaHNQa2VNOC80RjBjTzVxN1RH?=
 =?utf-8?B?alRmMm0vNlBwUDhVVnBNditoejZKelFZL2laZXZ2NWJDZUJYK3VRZ3pJNDQx?=
 =?utf-8?B?YnowV0hyMVIwdDFJQmhiVzJSSXZIeGtuTGREbEJvYUhnQzBTWEtpbVRuTm1I?=
 =?utf-8?B?NXZhdCtOb0lWdFp4ODJ4cS9STzBwb3ZlNUdNMFM4L3V2WWFCNEpQYmRjZzNs?=
 =?utf-8?B?Q08zRmE4YWlzMFZHY2lWbXdiR21ua2cyaUt1TG9mZlB5b2RCRG1QY09XZVNy?=
 =?utf-8?B?a0UrbnoydGU0ZnpINm1oV3pNREZMNlZTellWbVdtUm4rU2xUdndjTHNBUXJv?=
 =?utf-8?B?dTFOVGdYa2hvZWg5QWdDdjZ4ZnhVZStwYXZNZUo1Mzl0Zm5EZDJaL0VEbGV1?=
 =?utf-8?B?Yk0zU3luaHVrUjkwNE9mT1FHR1hxbVV2OW9mYy8rMUxuN2VielJhSDQ3N0li?=
 =?utf-8?B?bzczY1BhZ21DQmhoeXVxei9Lbm9jZ0hjc3FSVTgwTFJCSWgxcC9KcmdSVGQ1?=
 =?utf-8?B?MHdyNFJQUkF1SThBUndrSzdCMXpVdFpSL3F5RldRZGtHNnBGZXg1dEJXVHA2?=
 =?utf-8?B?b2dRdGw0ZE8xdlYxWnM1MTV5YkJ4YUJYREZ5dFBHcW1WR1FvN29jVk11OHNT?=
 =?utf-8?B?bE9EQVRBdHowdlB0K2xVQ2ltZXhzbndKRzhoYkYrdTEyOXArS3lKRG9JN1NR?=
 =?utf-8?B?Vklid3BiS3VNMG5hTlcyRS9WaGVibndEd1hidnNZV1pST2Fod2dsN0NSblpI?=
 =?utf-8?B?WEQ0a2VJcm1MZDRGTEFtRDRHUkhxVWJ1QjRzN3FKNkJpT3kzck1nWWtGMjlB?=
 =?utf-8?B?eHoyRFpBbkN4K1B1UCtmQTluMVFucU5Fa01ENU5wak41MEZnUFR2bDdKTFIx?=
 =?utf-8?Q?Xfa1HaK/6ZCaHISg=3D?=
X-Exchange-RoutingPolicyChecked: T17C237FRVpHlX2gyxDGjIgGLIURw2kOK6gqyq0VfSm5G1OrrCtqRzLthJt+IbyYLAIGmiYNQM43aQbBAm8eGeI0pen4I9oH8mNPrsyCcBZS6dHJ02b212Atfsf7cs4ThWtZn+lzVFr220GWwv3VPGJzxb/dOykJSJ4QUZmYAIGoASBGSyl4EGwBRlB3MFSOrwU0QLmDWd3RJf1kpmiR/wZKbTsznapfvnNZcEzBVHC7xqzxmYruBFWv3IxDyuFKQvVziuLzde0VeM+yNHBEFspz6o/mFz1EmZWKW3OCHiVDRddel2DnOnecfS0nhE13jAQsGRj48ac0LY/ozjEltQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e55aef15-9120-4e8f-040f-08ded137e1cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:58:27.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iugyHLG4r9dZGOKA7J4qKj+u4BmtOME3lMSPwqmRjOtSelk3p/E7aXSBg3p0H+NmsbgxjTBYalMv6bRn+uEw5EzTlzYB6dbJKz+Eq034Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1AF044E07
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301396-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kerneljasonxing@gmail.com,m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,vger.kernel.org,tencent.com,davemloft.net,redhat.com,kernel.org,iogearbox.net];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CAEE6B81BE

On Tue, Jun 23, 2026 at 11:02:48AM +0200, Maciej Fijalkowski wrote:
> On Mon, Jun 22, 2026 at 04:07:06PM -0700, Jakub Kicinski wrote:
> > On Wed, 17 Jun 2026 11:43:14 +0200 Maciej Fijalkowski wrote:
> > > > On Tue, Jun 16, 2026 at 11:50 PM Tushar Vyavahare
> > > > <tushar.vyavahare@intel.com> wrote:  
> > > > >
> > > > > This series improves AF_XDP selftests by making timeout handling
> > > > > explicit and fixing sources of non-determinism in xsk timeout tests.
> > > > >
> > > > > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > > > > dependence on RX UMEM setup state for timeout behavior.
> > > > >
> > > > > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > > > > before worker startup, removing signal-based termination, and using
> > > > > barrier synchronization only for dual-thread runs.
> > > > >
> > > > > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > > > > configuration does not leak into subsequent cases on shared-netdev
> > > > > runs.
> > > > >
> > > > > Together these changes make timeout handling easier to follow and
> > > > > improve selftest stability, especially on real NIC runs.  
> > > > 
> > > > net-next is closed, but in the meantime I'll review the series ASAP.
> > > > 
> > > > BTW, another thing about selftests I had in my mind is that are you
> > > > planning to work on this [1]?  
> > > 
> > > This one is on me. I took your changes Jason and aligned ZC batching side
> > > to this behavior, followed by xskxceiver adjustment. I am planning to send
> > > this today EOD, however let's see how badly internal Sashiko will kick my
> > > ass.
> > 
> > Hi Maciej, do you want these applied? If they help make the tests less
> > flaky I think that it's fine to take them during the merge window.
> 
> Hi Jakub,
> 
> last refactor from Tushar broke BIDIRECTIONAL test case when HW is test
> target, but not on veth, so let me test these changes locally and then get
> back to you.
> 
> BPF CI runs xskxceiver on veth so this has not been caught. Seems my/our
> focus should be to enable xskxceiver HW tests on any kind of
> environment/infrastructure.
> 
> Gonna get back to you by the EOD.
> Maciej

Ah I replied on other thread I guess, so let me repeat:

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

