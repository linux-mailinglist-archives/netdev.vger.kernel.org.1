Return-Path: <netdev+bounces-284482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFQjNsoS+mkWJAMAu9opvQ
	(envelope-from <netdev+bounces-284482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:54:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F74D0AE3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 613CE303A6FF
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F448A2B5;
	Tue,  5 May 2026 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1/yvVRP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE008370D4A;
	Tue,  5 May 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995917; cv=fail; b=pU8N/G+Z8pBQR5wj5lcE8F9InXgsZjbGPcr4vYbVvm9lj2SSXhnXvy+zRAE9L0mpa60kZ04NNSNWrj6m5532z3p0lzSFQ21SJPNt1Qg67St184Os5SXoQYh9SijePkuxcBQRTxhKbQX4BOIFz+6XdgSHfFBFf/nFJcV4W+Q53NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995917; c=relaxed/simple;
	bh=zCpf/XfUlBj3ngaMrO8qRIc5gwtd4igYdGfESKpQwnw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AOJjE7YGSDiwL78x/w03udwhiJiC1jytbDlGniQMh459k8PUwmPB58u1bHkrcmh1q8G213sZztmSRA22m1DutfMBxt4c73fqjqQqonbPJ3bhYX2aEiZ+ZFFMhcU4SXH0/GS3HSdO8CVCYXWVyjoVYRazJD8AEInA0Rkq6L12kdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1/yvVRP; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777995916; x=1809531916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zCpf/XfUlBj3ngaMrO8qRIc5gwtd4igYdGfESKpQwnw=;
  b=F1/yvVRP38ydN2XlkXeH1bp5APjFOB3xHPZ9mtIFxggZdIFFE9IzO4gK
   h2tV1bFIWOthrYqgtkMylzU87/C0VVm/mhzu7jwK7Z3JI4RfBTxCX9Ktq
   9GyQrxXI3BQY5PcTWUBhguV/cRG193hWdwzEDT/qEp2neIn6XH73/O3s6
   SQVuczqxLtWOP/Mh3oAnQDX+sRXOGrl1YK2+QHDTcTI3dPHZX00fA2Lf+
   MVu/A3DMh+LcBLOJGjoGFISUKdwMiu6bxAwFT8yQLOQweHblBUAf2NGwY
   agzPowe5JIhT1FPTkNvrXLx3ph71oBqSl+r/D7LTVFUy4auAXHKnyMAF2
   g==;
X-CSE-ConnectionGUID: v0uSyz0oQrSTT/YJf86k/g==
X-CSE-MsgGUID: SR6dZ61bRO+NKwUGmlYdkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89175385"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89175385"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:45:15 -0700
X-CSE-ConnectionGUID: zyCS8SvbSdC0QcZHtlR+JQ==
X-CSE-MsgGUID: rL4Nk+BkT3G8k8A2un0d2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="239836646"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:45:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:45:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 08:45:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3iJKUgxizKbqQ2qUmqSWYVj57Nkqcnu39bq8mhxHY4sVGlaubzQhp/4+lnmjIyQddmNO/dWy2Nvep8HrdkH+m5xgPqLbvEFeL572gjM5pVckbn/Q7Sqt6wCzFaadJnpBNpyppzWpP4zP/8Mra5Iuh55/NsQYObbOB92MC0LEeaXKa/h3jdBnaL04KtYi95Rhi+Uc0DdMtFqLK+RgdmeIFafGIndSG26vXrJ7dC4NUdD2IXjKsFXlvHcmFyfiVqJUWWAYq15dLiWicW3AEHUWh9j3pO/ijGkgwRSRes8aspge4owoWyanXzXSWUIBtM3sFLCkWBjVNnF0YyVWdVJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks5U6FrGCtuD6FwyBlM+RvXM0YzW3S/akt87kT5iF1M=;
 b=KlIcmd9he0Xe2YBoD+t0fFWcKB4v03actVguMDX8v2bftE2ukF+G1mLO1hKbCShQcV+x+gSCj1VUvOcNh3gxuBC8Lb627kpsogN3LiiNQBCxI9B+lCjckstSmDCBjwXbZjdfH7PDaXGaasvu6GH8uc6KIgw4EgM9elywjqJGzj96eOyHohBoe869xpsIk3l1nmm4A9ci+FoZlXifezW7Y1SGqcp5xkTPGJQVp1NGCrNn9jgv23ivjlCngG6w9JMTBUgFhQUsuZ2WOZMG6tNB76ptHfxeTWANON8bloT3gI+AVWlnKmeeZrSTMj3dDJy/yy76hULx+tXISXObOZYSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV8PR11MB8535.namprd11.prod.outlook.com (2603:10b6:408:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:45:06 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9891.008; Tue, 5 May 2026
 15:45:05 +0000
Message-ID: <7418a37b-1aff-4b48-80b9-012830e5f9aa@intel.com>
Date: Tue, 5 May 2026 17:44:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/8] xsk: fix bugs around xsk skb allocation
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	Jason Xing <kernelxing@tencent.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0078.eurprd02.prod.outlook.com
 (2603:10a6:802:14::49) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV8PR11MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d982f74-4ec0-4fde-e694-08deaabd4754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I5OPu8KTU6tK3Pqo7q7c8cM7bjFchtKAo5ftvEe2xOCvWhHR2T21nK7YTdlNC2VJTgxNcMQIvpNIBygWiAnwShESRJ4sKc0zqkCIqfrbIBU5OcvmAVZ/Vk1RFcVbOsp9Y2CcjHmFa+/Lu3flHnVUbtBkOTLCuFqJ9+E3vkGBhdjDzq0Sg5MnSReFPKiE1ApPZ4OqhYV3hR0EdEUIQErqiUmaevbzumWS5tSuaGZpMgdy/HaONAODc9wd1sfoiAb1bcRlzyjZaVhPZqNVHWCPpQrmJbxoaD57qOgVGcSsP7nzTRU9i8zQdLVzKON71seQbqwEfr55KvuL4d1VF1mKJ0FZhgkwuRpkHt2F6jkrqLLYniQP67ihZGYzlqIpKL+XEKMp+Qt2ZhM5mUPipnt8sfilYcxAnZE5sxBw1RjB64JvZfVTnXoGc6aDEEBRXA/TWusQ/28XfYix/MOnvkgsY9Hw61EYfDUn4Cl+yRvQPfhkav2RisrKIlhULP7PDO4U9qlOWg4CX1b+Zj70gyZLFBshII1UuAq+XnI2hFtJnBMFZF7epctsGkCooQ8Ji350LgibD3JQuVb5xgQ2lT2otsF6RpOX+lRNHxh/MX/f0qJnT41h+0XAPyWatZhMOHPL+KUKPxot2u5qRzh1qNUpl2jfFTwf8q/qfhG1sjyiur9iMuvDyluvpFvSroG+rq/h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU8zTmRYL0lMSS9RQjZRdC9FRjR5VmIxa1pZeFNpdXg2MGRyN1cybDd3bUxo?=
 =?utf-8?B?aGN1c2tteU9zNWRtMHJkS1lRVTNnVTMveW9xZSs4VmRjWE10NWNucnVURXhW?=
 =?utf-8?B?ckd3RFVFU0tCSkJHMGF5cG84aHhyZEJYQ2JXR3FtczFIMU5jL1ZjSlRDbVoy?=
 =?utf-8?B?elA1d3k3K3dmcVZ0THdjcy9XR1BUcnd0NWw3cjZuUnBTZ1pUNTVFWS9hMXhj?=
 =?utf-8?B?QnMzNktEVTRCVWh0elY0ZXFHdG9GM3VmZGtOU25WWUo4c1kxYTdMSGxXSnpj?=
 =?utf-8?B?MjAzQ3JlZ0pTNVREYXU0M0FqelE0eW5oRlJUYUxNS05uR0FPZlJWa1BFcEwx?=
 =?utf-8?B?RmlZKzFTdWV5dWlMU0l1SjN4N0k4QkF1ejg2WWkvV3RUKzZtNWpuZk5jNUlD?=
 =?utf-8?B?eHRlVUlGUGlnRTNLenRJdVdPVW1PMCtJRGxnNkhtR3NucEJqWENYd2lFUUJZ?=
 =?utf-8?B?bldvNHJYWGhrS09mVDVXa1U5OVNmbWtvY0llMHZ6dmZTTzh0ZEQyVVZUaE00?=
 =?utf-8?B?OGhaVHVLNE5JRkthczV1b2FNZEUvckN0RW0rcjBKZ1VBM1BXb3NaUTdRQ2p4?=
 =?utf-8?B?anRUY1VNM0pyU3NCSDNZOXFWenFwbHEzenovZ2FuZVZsb1d1UVNHTzlJa0pm?=
 =?utf-8?B?TEVaVnVGLzdhU0dPWHdZZW5YbGovK1BPQ3RvV09CSktDRHJha3Z6bTJyNExo?=
 =?utf-8?B?cXVydHh6VmlsdVhJNUM1OHRRazNMM3B3SUJxbGJYemJyRnZ6Y1V2VnpFaXZn?=
 =?utf-8?B?a3d5UFpyeHFzMERoY1VhNjQzbEplVjZPSmU1WlRYbjRaeldXdkVZcVBrazVK?=
 =?utf-8?B?TStibnZJVUdqcW5tUEwvb09xdnROd1liNVJJTEI2TXd5T1RTelVNdFhoSEMr?=
 =?utf-8?B?ZjBLYVNNU0tMcVU0V1REcXdENDhTazRyTlR4a0phSENVTUVPNFU4QzZzKytB?=
 =?utf-8?B?eXR6MjV5U2Y2Vm9pSmhXU3loczJpdUxmbThhcGkrNzdKNEV0SW5sNlJ6dUpZ?=
 =?utf-8?B?RWEzT2h1Y2hqb0xxSEQ1bUFhT3dRbWZ0THpDYlBnUHpMSWs0aWYxcjNIUEVw?=
 =?utf-8?B?Ym04OGROaDlDWFQyOFAxc0lldFV6anIwdE9OL05SbU1vWWFCSVV3MTNCYklS?=
 =?utf-8?B?eUQxR2E0dW0wY0NpTHVzSjd5dDRPd3V2Q1I4S0xrdUgwaWVYNzMrUld2RUEy?=
 =?utf-8?B?ZHB6UHdCQkpFb2VTaXU2SjcrK0tPQzBDR3ZZbDBYaDc1VFI1d3Ixa3NvOVJa?=
 =?utf-8?B?bVR1QjdqMXoxRlQ3TWFLUS9IQ1I2YUVseTZqT1dsazBSekZPRGpSeTM4dE5I?=
 =?utf-8?B?YTBBK0RKTTFlVC80b3dFaHRic25tSlNnMXVWTURVTjVibnVkY0NuSjJiMWMy?=
 =?utf-8?B?NWVjZEU4N3JaK0xDS3h4dHpaZy9tcnlEMUpOaU1vSDFQWEVlMjBoUWN6Q0o4?=
 =?utf-8?B?ekN5MWdLNTlvZXVXODhidzZPeVdLendnV2hoU3RDeHZjMFJzUVF4V1FRVXFm?=
 =?utf-8?B?aFlyTW1VcnBNbm10cU9hQUxrMDJnVkdPZHl2bkV3MDN3NnlhbzR3Z2UybkxW?=
 =?utf-8?B?cVlaaGg4WENrODFOZ1BUN2UzNndYbjg4Q1FEd3pBUUd5K3d2YWNadW9VQ05E?=
 =?utf-8?B?MFFSQURnaEcwUDdMZWw2NTBxOFFmeFlRRDl5NDZqaEFrcVcxcFpCdFpmQUFk?=
 =?utf-8?B?aEwyMUxQREF2TWs4U3ZrSlRBNlNRb0l3UFRzcG1Ndk1vakVSZ0xLalpzb3NK?=
 =?utf-8?B?cERjaUtGQVhwaCsxZlVob0VVOE9KcUJlYVZobFVPSDBnUDB3RTdxZnhidllI?=
 =?utf-8?B?MXNKRTRNeDFuRTZuQXlYVEw2NkNlakdPSjRKQm5XVUp4L1BscS9Zdlp3aW1z?=
 =?utf-8?B?VVpRQWNITUpnSGtGVGEyZ2FTNmtPMFMvbWt4OSs5UWlLRmJTbDdwZWVHcVRp?=
 =?utf-8?B?OFpZeWhlNG9FL2Vzd2xHQXNwbjlyN25tRzRkQ2liUktWeEVudXo2YkwrVDZB?=
 =?utf-8?B?SFYrY0xicjdFVE5OMjRKbzRVa1p2RkNDSUpWYXNpVkJwSkZNalhoMkw1TVFC?=
 =?utf-8?B?a3hGN3ExR2tFUG5XMkR1b3VuaEd4Z0xaSExmVjNmRzVmaysyM05LdnhKM2pX?=
 =?utf-8?B?bzhXTW9rSnhwcHdISlF2NktoT0tSYk9CRGROMS9EMUV2dUlZVGFtck1MbWxJ?=
 =?utf-8?B?clRwUTU3K3RqYzVGOUJLbU53blZQNlVWUHdmYUZrMFFhbWZ0dXdhUFU1SC96?=
 =?utf-8?B?Z2c0YktJL09LbFNyeitrRmwxRTBuY0ZvV1hpNUU2eFBSbzhwVncyanA1VUVz?=
 =?utf-8?B?QXY0Y2sxTFVKMDU0aDVQVnY3TmY4cmMweW9LeXVCTkY4L3pQUkFlRjBQRmdK?=
 =?utf-8?Q?QCLnRb95dTwwmbuY=3D?=
X-Exchange-RoutingPolicyChecked: QMC/u7dfeTj2OD8RlQm2DH6o6mPa3S88fuReaDzrWFOSjXB2wLSsRQIR96jYN2S8r/3CpEul76y71GRYATNEgUal/2B9VMf4SZ6Vahf4eG/A7AeyD7Bz1F27L6xS5wazqAkqeVPmXaynP9kN5eoF0R1mpBZ15kHVvyEkkfOvb8+UxwRoTMzyeWWO2wF99JXzio8AcbeOKlP/p+NXuSXX6dL7fvI4x8xkE5mc3CWkFOeqiAtvpzMdJwxuGheqLkt8Nl1GD7WzP2Z1nSnoYvQoktglYyvEcI9lY9uYgpIemoYX0C6E1UflxHbVrM6V/kObCeJb+Gr9eNs9l+kXYEImoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d982f74-4ec0-4fde-e694-08deaabd4754
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:45:05.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUTUJn8pngSzsPWUUF1wRZFK/oSHMPopIK8n9fZ5gjaWWAO78DgSsvC+GAQZlyKIIH/AtPjNb4kHBeLMIZWNGiJS56VZQYerJV5MZitDyOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8535
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B06F74D0AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284482-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,tencent.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat,  2 May 2026 23:07:14 +0300

> From: Jason Xing <kernelxing@tencent.com>
> 
> There are rare issues around xsk_build_skb(). Some of them
> were founded by Sashiko[1][2].

For the series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Just don't forget to look at Sashiko's replies, I haven't looked deep
into them, so can't say whether anything there makes sense.

> 
> [1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/
> [2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/
> 
> ---
> v5
> Link: https://lore.kernel.org/all/20260424053816.27965-1-kerneljasonxing@gmail.com/
> 1. reword patch 3
> 2. adjust the order of patch 6 that is now moved up to be patch 2)
> 3. use helper in patch (Stan)
> 
> v4
> Link: https://lore.kernel.org/all/20260422033650.68457-1-kerneljasonxing@gmail.com/
> 1. fix 32-bit arch issue in patch 8 (Alexander && Maciej)
> 2. add acked-by tags (Stan)
> 
> v3
> Link: https://lore.kernel.org/all/20260420082805.14844-1-kerneljasonxing@gmail.com/
> 1. use !xs->skb as the indicator of first frag in patch 3 (Stan)
> 2. move init skb after it's allocated successfully, so patch 4,5,6 have
>    been adjusted accordingly (Stan)
> 3. do not support 32-bit arch (Stan)
> 4. add acked-by tags (Stan)
> 
> v2
> Link: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/#t
> 1. add four patches spotted by sashiko to fix buggy pre-existing
> behavior
> 2. adjust the order of 8 patches.
> 
> 
> 
> Jason Xing (8):
>   xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
>   xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
>   xsk: handle NULL dereference of the skb without frags issue
>   xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
>   xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
>   xsk: avoid skb leak in XDP_TX_METADATA case
>   xsk: fix xsk_addrs slab leak on multi-buffer error path
>   xsk: fix u64 descriptor address truncation on 32-bit architectures
> 
>  net/xdp/xsk.c           | 115 ++++++++++++++++++++++++++--------------
>  net/xdp/xsk_buff_pool.c |   3 ++
>  2 files changed, 77 insertions(+), 41 deletions(-)

Thanks,
Olek

