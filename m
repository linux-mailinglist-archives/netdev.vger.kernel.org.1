Return-Path: <netdev+bounces-258597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLZUGOn+jmmOGwEAu9opvQ
	(envelope-from <netdev+bounces-258597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:37:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE7135251
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 187AF300BBB3
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB7034D4F3;
	Fri, 13 Feb 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ek8DhHs6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F92DF146
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979041; cv=fail; b=n+lUzCefXgPA6PkimVgTmyuko5VX1lHOKlCu0Djm0M5fpCLwXsLBPtGvTQb6r/SB21dCIBD5uXSe6gXeRwix3yuipLeGd7SIUCP643/67bDexKtSch4u0JRUXd+hY3RJsFb1jDnao7j11yiLi4S13853/trLVyl0ZMrbsJZN6Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979041; c=relaxed/simple;
	bh=ZVNuy3aLHlbeXFlXJITiQKBF/HSTplJDGHXPNZCIRMU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OalFEkg6euIoWjQbYtUguQDE6TxRue6tYEA+HAcbzmosl9+lB3ps2EjSJs4rBInv36sdZnMrSvrhi61Pr/TMRH9/yomHPPpnTir79slEc+X0RJRmJpOIEfyM97qC91f98msIKooAzcJ+P6HhgjSeRNv8lqQBs5s3lOpDXz0SsRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ek8DhHs6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770979039; x=1802515039;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZVNuy3aLHlbeXFlXJITiQKBF/HSTplJDGHXPNZCIRMU=;
  b=ek8DhHs6T/ne3EoE9oQuup/sE6sObx1mcsr7KqW7foSMJZH0jJ5O8eSZ
   6qLeIRNmvXtksejK2w5xlxl0M6AabDB63JCCZwNvjqSJU4ywbQtdb9Ywc
   mFFh4fqew6OvHweid9mKdgL15MDh+TD8flmcEzcfy0CLUZTO7VE8F2E0H
   z2WRErQ6JydSh1kz01yPddEdpmZ7j04WTuvTcLyMECSMBBOPN6EL0yjnj
   Nw0xcUu+4DPrEECMIi2e2g2fR3Ka9X6Lwp3Pmc1tSfTQDF2e5k3WQae08
   MH3E8vBrVZtPHtZRlZ8iE74C2oxiSSv0DxF4HCQCTr+wC8GqML7HQsNkm
   A==;
X-CSE-ConnectionGUID: S53FeEh4Q366lmt+2jlvEQ==
X-CSE-MsgGUID: P3/lFNqQQ+6jIR5dUXbkGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83530590"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="83530590"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 02:37:18 -0800
X-CSE-ConnectionGUID: 93faTHNgQuedvx3o1VMdhA==
X-CSE-MsgGUID: 6fWfH13eTBqvi5e8ARm2tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="212922130"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 02:37:18 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:37:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 02:37:18 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:37:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQIYXQunIdOMjclOhUVUV4D5Xok/ZduI2QwpldHArHiv3ahDq8FF/qoHwqZ8QNxiJeJ5m8CsyCq9V/Eh7rvncjXiL/H+ASl5L0cgOYfxzfYF+fJYI8rAjBM6Rt+FadUb10d2v5uKHfGVVB5wNz4jqUfrbHfKF2ot9u1aCq7ltNOMvmEclJwdbB1WRxTlm1QZCuAZf3uik0f5cNnbcFtBUDiQTwfKDi3mm4a6tQkTj3HAWPZNfp3nGWmI3Zq/aD2SW7M+d4pSFdr4vxFzhq7Czwon3nwFBPAWQUWnJ9ZdbpDLYRk41ZdvEJSXClX5MS+fdru4Lj5gbpYwh/Toja9NAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z23tbtL/TDN3prpwpaNHzbHqZdLlrCQRUNOngRScMW4=;
 b=QmlsgjdltJZaMTtWP+rOfGY+zwrU9eHN3/q9YbvTyTy92qDLmZrGCmG1YLoCK3o0on9TQ1iz8koqzUp2/gUYbkdf2NjXuhDb904Y48RslahmT7CNmswnz/Zft8/5GwM3LbflsRslrdNZtcV9ing71tAZadMUg11+29CdmmO8xN3cajmAISxtBa8O15x6Y4KY/EOtFedbctt4S6ITlWegnKDU+Y2Y96OudgD7xKghU05LbKh1hM9xj0LCFbXTOZM1K3w2IAIXlFXfhvCCfoDq5AEJa3zmOkH7TFgt/SjVoLpHdo++d2oCkUTkeqKbN2JRUehph8d6VVIWtxEH1dn2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH3PPF2CAD058EC.namprd11.prod.outlook.com (2603:10b6:518:1::d12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 13 Feb
 2026 10:37:10 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:37:10 +0000
Message-ID: <c2577324-d1be-4d4b-84a6-9964a63d3097@intel.com>
Date: Fri, 13 Feb 2026 11:37:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] drivers: net: ice: fix devlink parameters get without
 irdma
To: Nikolay Aleksandrov <nikolay@nvidia.com>, <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Paul Greenwalt <paul.greenwalt@intel.com>,
	Daniel Zahka <daniel.zahka@gmail.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Dave Ertman <david.m.ertman@intel.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>, Shiraz Saleem
	<shiraz.saleem@intel.com>, Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
References: <20260213084841.1406442-1-nikolay@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260213084841.1406442-1-nikolay@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0152.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH3PPF2CAD058EC:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc22083-d46a-41ed-f554-08de6aebd7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0JBa2M5VHZmdC9HQ0U2YjJkZnlWTHEycDdQL1hOdVcrMjJPUFlsNWo1aTRl?=
 =?utf-8?B?MTRhSG1DTDA4T2dMSzBacm5yS1dIOTNYTWN3dnNOVzc1ZkkwYUV2RVE0MGRC?=
 =?utf-8?B?TGZCOW8wdTVNL3QrSTVBVlQvR1ZGM3ZQYTliTzUzeUFrV3JIZlg2Z2tsK1BX?=
 =?utf-8?B?Mk1uRFN5VmY4cUl0Yk9NRDA1RW51N1J5Q2hXV0UyeHFJa3lDMkFMMjQrQ0tV?=
 =?utf-8?B?RzgxVFl3Z1VoT1lhVitYcDV6YkFhK2xKOFE1dW0xQXdIQVlrTXVnSkQ4cHJY?=
 =?utf-8?B?S29oR1pmUllseFA3RkdsS0xrNVg5NXZST0VwK0FvTjZBd0l2Q1krcks1NGlj?=
 =?utf-8?B?NzFiclhSdzdEUFdlanJkZCtudFd6dzMvNzhsQkEvSUtyaVcrMktBZzlyN0Uz?=
 =?utf-8?B?d3dYaDVndTkvbEdXTWNJM3dPaWM1a21BSHZIcFVod2ZuVW9NTGI0MUJnR3Y2?=
 =?utf-8?B?Wi93RGgrNmNQcTFPckE2ZlA5QWJuMjJuMVpSUk9nK1EyWlFDVmRrOFM5VENY?=
 =?utf-8?B?N1J4QU05KzBPSTVwRU8yanA4U3cwMkFsVGpKSU1zRm1xWUt4dUxKVXhDdjFZ?=
 =?utf-8?B?VktTOUxBUk9qdEhxT01SdC9SbnNFNFE3NXFER1VyOFJVdVFvVkRFWlhJZHZt?=
 =?utf-8?B?L25mUGZpTk1DWnd3RlE1YlhvcitFM0M5RnZieFFMME0ySkRnUGRuY2FUaTh3?=
 =?utf-8?B?ZTNaRHplNFZPTjhTMHI2Nkt3YUNvRCtha3I1TzhKNzA1WXQwYlZ1NG1DK2VC?=
 =?utf-8?B?Z1FJbCtEZkdmWHpwanlvazF5OUpnNmJiSzMzVmpsT0hVRTYrQ1E5cHc2bUdU?=
 =?utf-8?B?L0hPZ1ArL1NaYWdBTjM1WEFkR3pxWTVWTE15VlVYYUlwanlJNE5aczRKZm5O?=
 =?utf-8?B?bDZ2b3hucU5ETWxnUG85dTlwcmRRTnZodFIyaHIweTQ2Zm0wOG5YQ3N3YStZ?=
 =?utf-8?B?OFRQQVI0QlVSczVra3VkY0ZrSVZJdWV3QlZsTmtiWlF0c1l6QUNrdUR2d2tm?=
 =?utf-8?B?VUxwcjRJblBBN2poQ205bld3L1FEWUlwY3YvVjhnUGkvQ0VFN2V5VEFBVS9D?=
 =?utf-8?B?TG8zS0UvSVBrUUVtcW9kcitibktoNkdUTVlTNERrSXhOZkdPK0t2TkxlN2NV?=
 =?utf-8?B?Z1BNUnlSbHpMclRxbDJPZjVlZG5NNW5mVDhvcXlRWEV1MWJueGorT3FNUmls?=
 =?utf-8?B?cFFKWWovdHlaa0hpZHVUYURKY013WTVob21EN3h0MHpaT0Uvd3lQWndyN0c5?=
 =?utf-8?B?eVVOVjZWWnF3bExBeXNuSjliSStYWmMvZnF1RzZPMVJZRVdmby9xK0VZM2oy?=
 =?utf-8?B?ejRQVm8xMzdiNnFsTThhZEplNGVhRHI4WElsRDBrbmJKU0VKdUhYNkNTSmZy?=
 =?utf-8?B?dlYwTlQvM3BaNEpTc1RwSzQrNHptQkZlMStEREhHdzdWQjNPRkRnbnduWjBN?=
 =?utf-8?B?OW16S0xyaWZ4d1BTQkpwWkU1eVdIOUNIQXBhOUhVTHNhazlqQVVXNDZRYmZS?=
 =?utf-8?B?RHF0ZlVOaU8yNFVXZmFpemVrbHNVUGxoYUFieS83bllyNWZHL1FTQ29ybEc1?=
 =?utf-8?B?am8wRlkvZ3NRd2d3Um5GUWdidm5uWnRRVHBSeVUvOTRLQzZhbEFVQlNma0RT?=
 =?utf-8?B?ViszTEpQWGJaM29NdnVZVkxOSklOYlp0MEJBMjdpdVpJMnFCOGVKRy9hNjA2?=
 =?utf-8?B?RFZPRkNITkZvTHdNcWxxUjVST3RUZ1M0UTFwSlJucXRxcTFnWlhLOVU5V29u?=
 =?utf-8?B?UDYzUW0xQnU5KzBPVDZCV0wxTGlPaWVpMEJGV1lzYndGZ3V2V1dKc0orb3JB?=
 =?utf-8?B?OExrWjFqOG1TODkyRDdGcjNmWi9DNXlyZjUxb29LbzVHVmM2OUgyMzR6Rkps?=
 =?utf-8?B?ZGhITlVheFJ2bXhxSjEyNTV6UnFlNGo2NmluVkplWlY5cU5Zcno0SlA4MnNm?=
 =?utf-8?B?MEJESVR1RlhsMWp2dGFtb3k1cFpPNkpPOXRjU2c0b2drM2RmUTRzd3hkZk1R?=
 =?utf-8?B?QjNHaFRjSlVkVkpHMXlCSlJ1M0c0ckJhMExnYUE1bVMvbFhZbjhUOG1SREY2?=
 =?utf-8?B?RXhHMTNrQTlFY0ZIK0pWaWMvUFNXcndQTmZRWDMzOUhBZEdDWFJVUWo5ZUsw?=
 =?utf-8?Q?tr0U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lpQzJseHNCdHg4UEVUK0MvOHcvQlBVY3NuTjBhNWx6WWh1M1h0a1BMN1hW?=
 =?utf-8?B?V0Q1UkN6TFNyaFA4YjhQVlQ1OEo2QjhSQkh0SVNkSHdwZWtXUHRYTUNacG01?=
 =?utf-8?B?ajVEVDNIa2tYRVM5cURUYzRXYWw3V25LS2M2SXc2WDlTV2xDRXV4ZXRqZFRt?=
 =?utf-8?B?Q3VtWm16bWk4RGZCRkc4bXpmRVJndkJqakMrNXFad2pyRFRKaUg3RWx3Tm96?=
 =?utf-8?B?WUVOSWtHM3czRGVnYTI2WXNrZTNGVks1bzlPT2tyNTBzNnRZcXZ1em1WRjND?=
 =?utf-8?B?cTdWcG8xd2h6Q1RtNWdIVm1JaWkzVG1PMHRGSnk2eERlY0dYUHhtK2ZJSlhn?=
 =?utf-8?B?ZTdQM2xPU0pZTUhvcEYvdHdISGI3ZUh1RWdpY29aMGdwZmZYOTZZWmpvWElL?=
 =?utf-8?B?MTVWajFockVNNm5SSFlna2h1cExrUWYzcHBIeXpaUXFsaE5vMExkTHpBMm91?=
 =?utf-8?B?U0N4WnJ2cGF4MGpuMEFnMW9KSUtBSGJBb1BxRDRoQ0JhMFdTQVh3QVpybGQz?=
 =?utf-8?B?Z1kweTJiUk9MeUFUc0s1V210NVh3eHJhSjNqdW1qb3RjQmMyenpuYmtQdnYy?=
 =?utf-8?B?NzdmVjhtREZHT2pESWZCKy8zR3FjclJDRWpES2wydCs2ODdIbGhRQjBRN0xk?=
 =?utf-8?B?Y3NSQzcrZ2VSYU1JMS9xNzV5VXVDNjNRMVR5MCtRU3kzV1NFOXlKT1h6bVEx?=
 =?utf-8?B?cDUwMFJmVWFSaStCT3ZmSy9mSWZFWTJtZUNrUTBLbUp1czQzWVM4R3FhY01E?=
 =?utf-8?B?WUlkUW9wS3FvSGVGYnZuOGhSMHBvZEpjbVc3OXBadDhDQkhaOWVWTC9FVzJ3?=
 =?utf-8?B?eHlSNm9PY1ZuTHBLeWxNTERGQ3YvRmRiOUtRNjRoOXFJNWc2alI0TzJRb0ht?=
 =?utf-8?B?RklCKzROTTFVMm1IWFB6aTFVaHFrZGxMMHM0VWpGM0dMRmdxd3YzU05UL29i?=
 =?utf-8?B?OTdsSEFLZlRsNGRiUEJxc2Z2dnRUSndUM3NKS1dyditPNWpNV2pXZ3Z4b1Fm?=
 =?utf-8?B?Z3BJUXNyaXpnT05ySUpad3NCTE4rbHdDY1o0c1J5OFNOYVRtVHY2WnFpWVhL?=
 =?utf-8?B?Mk9nbGlxUi8vVTFzYkdMK0dScllpMExKcnVHSG5CNVY1eXora3RLM3VSOEFj?=
 =?utf-8?B?TWNNNWdFSmg2am5ZWWZoQ1BnL1NsTU9qdHltYm9Bd0EzSUVqVFNJTWtSOFN2?=
 =?utf-8?B?NUtjYzFEMkovYmVVMTJDV25rbnpSU0VYMzVYbUErMlFqL29RYmtOTkVCd2V1?=
 =?utf-8?B?a3lmMkRrWE5RR0dLUTdtaGhwUS9SVDV4SHRKOTA2ZHY2ZFhyU0JleGl3TFVU?=
 =?utf-8?B?SGkwUGwvZlIzeDNnMHpvVXJiUXVabUJTTnJMTWZvbVBPaUVQL0wwcVMrWmxn?=
 =?utf-8?B?UzNudjkrY3lQZFNPR21xTi9iZjYxdFFHd3orVGFGRXRLTjdrcmo0cDYyVkFP?=
 =?utf-8?B?MWtRTTUwTGY1Z1NHbE1sVnpDK1RqRUFuY2t4OG5FUmYwS2ZlZGFWaXhDWXdm?=
 =?utf-8?B?ZjVIU01VdC9XMm9sRjBBTS9HVTZHL21YY1F1UnpRdWhzYnYxQWliWHQ0REdW?=
 =?utf-8?B?NGxGeG9qQ3VNOURycjNLSkxBSCtOYld3KzVtT2NsbEpqN254Nk5WVEFhbHFh?=
 =?utf-8?B?SDljZGxTZHpHU05ybUUrOW1TRXB4dHpvSmVkSDVKcDMvNForNVlSY3V0VjBJ?=
 =?utf-8?B?VC9VcWZMQ0ZuazVZSXg3YnduUkJsVC9kRWVFTWdRVlZIOUJvcU55aFN6STJW?=
 =?utf-8?B?REExOGJ2VkZucnhWV3hhZnpNeHVYU3VIUTRKKzBtMmxCcWxLYkRLUkNuaWpa?=
 =?utf-8?B?d2ZwUm5VNGxTY2FoMVR4amJEU1I1cVplTHllTEc2eFJTWTBtdG1Yc0VCTUtN?=
 =?utf-8?B?ZzE5TWZRUS96L3lzWmlFSUl1dmx5QXlIOUtnY1U2VENyblVRUUVDeEw0a28y?=
 =?utf-8?B?TlNWak51UW9GOGdQSDNoL3NtaCs4QVZock1OdG9mQnBIZlFWYlA4ZkQyaXFh?=
 =?utf-8?B?NXdLMGwveGFCYmlLQXZmSUl3WnJHN3prTXhuQVRNTFVaK2xPOFpucFAwWlUr?=
 =?utf-8?B?S3FlOGFQWWJaVXVTclBXZkN1TGY5UmNqc0VzNTgxK3hBa1M4REN0L0VvMVBq?=
 =?utf-8?B?aXdQZTQweXJZdkZKcTRFWHFSdWZKeWJ2TjQxTEd0WjE2Wmt0TWlvd3Z5YVgv?=
 =?utf-8?B?NlVaMml3bEVmMmF3L2ZIMHpkNVVQa05acUU2NDRpalhua1B2OXdWOXltaU9U?=
 =?utf-8?B?NWJXUlkzcGVSVkdRSmk3NEgzcHhMV2wzamp4VDNmM3NJV1V4M1JmZkgyM1Zk?=
 =?utf-8?B?c3dseWRSYTJ3MGRLZjBrbXVab1lzOThUV0dLTGVtUDhpaXNtV2pjK3p3S1NL?=
 =?utf-8?Q?MHJHLsezmphJPlRU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc22083-d46a-41ed-f554-08de6aebd7a0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:37:10.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+9v+o5WGJ6XrPAHk1g9H+t39oMEpsux8B2XATq57pkgTTIML0iAcDdUtaFoazCl6I58QfNBkGHAl7F1rSYCL+P84ulxxpza5amxVxFIroc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2CAD058EC
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258597-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,linux.intel.com,lists.osuosl.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 40FE7135251
X-Rspamd-Action: no action

On 2/13/26 09:48, Nikolay Aleksandrov wrote:
> If CONFIG_IRDMA isn't enabled but there are ice NICs in the system, the
> driver will prevent full devlink dev param show dump because its rdma get
> callbacks return ENODEV and stop the dump. For example:
>   $ devlink dev param show
>   pci/0000:82:00.0:
>     name msix_vec_per_pf_max type generic
>       values:
>         cmode driverinit value 2
>     name msix_vec_per_pf_min type generic
>       values:
>         cmode driverinit value 2
>   kernel answers: No such device

this issue reproduces even with CONFIG_IRDMA enabled,
but just when there is no irdma in use, so the fix helps
a lot

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> Returning EOPNOTSUPP allows the dump to continue so we can see all devices'
> devlink parameters.
> 
> Fixes: c24a65b6a27c ("iidc/ice/irdma: Update IDC to support multiple consumers")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
>   drivers/net/ethernet/intel/ice/devlink/devlink.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 2ef39cc70c21..7de749d3f047 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1360,7 +1360,7 @@ ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
>   
>   	cdev = pf->cdev_info;
>   	if (!cdev)
> -		return -ENODEV;
> +		return -EOPNOTSUPP;
>   
>   	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_ROCEV2);
>   
> @@ -1427,7 +1427,7 @@ ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
>   
>   	cdev = pf->cdev_info;
>   	if (!cdev)
> -		return -ENODEV;
> +		return -EOPNOTSUPP;
>   
>   	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_IWARP);
>   


