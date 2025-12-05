Return-Path: <netdev+bounces-243776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5440CA7D3A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 14:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E721C31D22A6
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2330F941;
	Fri,  5 Dec 2025 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6xLvEhA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933724A066
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764931018; cv=fail; b=GwgIUzk53Z6WuiVpRTHpxh5JAhQab7mRSkB961ZvAVqaxSQlzUCGwZcziR9gY1WpJJU1RUmJY1ZpImygmr67KPW5NJpw7g1z5jzopsn5C2htGz0TfaaxJs2UFkP5kcoH4Hoh9clo5KK2ErRCJ3GI11QsGnEbzrccOh8tFZEHs2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764931018; c=relaxed/simple;
	bh=YKyGNIeHd2OnzSE6iKKAockiicYi+Nca2UvaHw/YkEM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LmQ7vX3CXNkILHnF4bOEkoKWi7RBDA6LegH9wmFh3wiuJccRcWpidQFWgKQg3XQ0cpCNwRaoAc9cVFDJLphDInSf1fAf6eNgl/YjY6moU1S2+V9lip1yR0kfch/cXL9aaOXhuPdkxnvWMcMevSI1z51OT3o+8sysys9Q9ORxBBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6xLvEhA; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764931015; x=1796467015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YKyGNIeHd2OnzSE6iKKAockiicYi+Nca2UvaHw/YkEM=;
  b=l6xLvEhAPONABKiAmtsxE2yoeGZfGw6HfyJQix4WimYNV9nda/nNG4g3
   beqtA4qqXYZQx4jc5TOrPA3HZVrp2kJQEoJo1Q2FpU53Tl9aC6ANpWbg8
   3FY8DPKvskKEFv2eQiU7He4LUDOpCasC6I3K8KCtfRc3/eQ+eNyRfdry9
   +H82thNwGPbTH/xnxoc+cZjjeg57RO/H7dHuYUGRxudIrDTs3WcdTprGS
   TzN3FqVQlBLjrl3uXmzcSrC1Jni6+a7vgKZxirCQjG6jilhV9a3//gZIy
   cxmNsn4+SjnNj/bTA57LF/A/DTPmGphvXM/SKAUMQKCTP5iHME3Ngs1TG
   Q==;
X-CSE-ConnectionGUID: DINLASzLSr2LJLIaaCrXxg==
X-CSE-MsgGUID: Aor4ThjkQH+4SZKo8Xo7sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77649243"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="77649243"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 02:36:49 -0800
X-CSE-ConnectionGUID: oz82nmtCQD6woRSlxYFsfg==
X-CSE-MsgGUID: Ss05VbN5QDaydtZ6D5zBPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="200216492"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 02:36:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 02:36:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 02:36:48 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 02:36:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqjaRpy67VGibCx07h2HsuEajrSs0X04gUKPx63q9eIMjAyB8lqMNfbEspPkQ4o4TrXt17rKM9xHB2Qsc7xxau67OWqHslbwzT+TtLEcXuT1Rdv6EZGxnBz9ixunmfnAxXisEnhg0rIh2TUyZ7g4KfYYUqUzAoWu66HxLbRx16A6nRzmOCT51tM/PWFtdJ/cSFUwIiSoNYMkZ8iy5Aa4XQIgphtK054Jw7R2pyz8MFUeLtdUjkmnx+GjrX6kpV2ZCB72foA2Lyb32vEUrdZ8tBMWTNAtElwWploKihbnaddVURktxKrzLO1Cbx9T/E1zl61pSTFSGi7EBtlpeTMv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F8UVxtBlyTfIMWNhLxNvDYHxACGB64C3Kv98YF4RUg=;
 b=TM2xyKrEbTp4FX6vYaJJ9rsM8zP28V5OHkNL5pONUXFoUb2OvG6U6I1Y9bv0etMyKvxOMphE52NrSeKrsk5/cM72SsX2Bzky7hXqJDv6R/E7j+gNp4BYxFq5uAq/KGWG7tHGeAt1wXpiXa7rk5TX81+Di4lN8vfciuS2mSNij6PSYz+k5gD5NyHLfhnwHF8vw+YY0NP2UTuQFT22SsaiPIT4Qbo+JBuZChJmwQ6TRYh+fKoc7E2nl9iFM2TPPRwORdNnbIb1iKAieNdPQDsHUMj5YjImVaPI73yrfCbQCnhty3/f1UtNoTQoD0Qorz+z78mzzRxHlebV55hPWPPfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 10:36:39 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 10:36:39 +0000
Message-ID: <0dd3d9d5-2e44-4a6b-a8f6-d997a979e128@intel.com>
Date: Fri, 5 Dec 2025 11:36:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/1] ice: Fix persistent failure in ice_get_rxfh
To: Cody Haas <chaas@riotgames.com>
CC: <anthony.l.nguyen@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>
References: <20251203184909.422955-1-chaas@riotgames.com>
 <20251203184909.422955-2-chaas@riotgames.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20251203184909.422955-2-chaas@riotgames.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::28)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d007385-cf58-459d-ab8e-08de33ea2c32
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ni9LTEhNbmtDOFNuam9YWXoyeEUwYnNDb3JmQW9KN0dKd3hlOC9DalJibnI3?=
 =?utf-8?B?dlhtaFZBRUJsR0ZOMFBYSnF6WjVMc2MyVWFaU1p0NEVuZ3BWVzZvZFdSVHM4?=
 =?utf-8?B?TW5jWVVZSzlLcnlWbUU1OXpYbXhMMHJ0WXBVWWswSXRHOWxCbC85QThZdkZr?=
 =?utf-8?B?WVJibng4Z3NrenRCa1Uzcy8vWEo3Qmp3Wm1WRFA2elZlT25QczZ0MWFuMUtV?=
 =?utf-8?B?VUswWnpUWnNlV3k3eDNPS2kxaEN4aDVtZlpySm5odElzSlEvR0lXVXBsc0Vz?=
 =?utf-8?B?TmdxWUY4b1lGUjZKMVNaYW9rMEI2aStIZm9oZTB5Q1l0Tk9DRmdkdlJxRTZq?=
 =?utf-8?B?aFZvL1FMNmthVlIvK0NrVTAzeG9ZL2FlYzVESEpFcGVVZTlINXJHTThZRDRR?=
 =?utf-8?B?ZjhTMGlPT3pMMVdtcXEwcGhNNEtrNEluOWFZOVhjS1VrKzQrN01DTzZObEV4?=
 =?utf-8?B?REpZYW5QM1F5Ym9WWER0WCtYM2hCdEY5Ylg1UXlQSzhBbTNwMHhjVElZdVNI?=
 =?utf-8?B?L3ZwN3VINlJwR3M1SVpBbW1LYm4vRUF2TlcwQ1FWN0xDQklKeis0TkNtcmN5?=
 =?utf-8?B?bWY1TWlOMWs5bnkwR2trVHhtS1hUU1FCdCtVZ0RlN0hxbXJYZS9wVGEvZzlt?=
 =?utf-8?B?RjZVY3pOSEpOQml4elAzS0x6SkYxRWwvaDArWjRNNnBWeVZ2ZGYwU1laajJJ?=
 =?utf-8?B?bUZOVkxWcDcrbWxxWFNEU1d0akxJNUlzUkNSZlhnR3RmYTd5ODJQS3R2TFBK?=
 =?utf-8?B?bnExZnVhWXpsMmc2Ly9hZU5lZ3lwRlZuVlFHV1N6T0lRWGc3NWxHUGhJV2Nm?=
 =?utf-8?B?TEhyV3dBYWI2bFBNdWxsUjFrSmxkbCtvWkFuWWpzMHBnVmlMYUxScjhlWlFz?=
 =?utf-8?B?MjVEelNXNDlHb3pvczZ1L1hudS84QVA1Vm5EZ1RtLzdSbTZvL3VwaFdGMldh?=
 =?utf-8?B?eWhaVnBydU56K1dvTCtyTUs1dFUwWjhVZThnQ21yaHJab0Ywby9tQXByS0ZR?=
 =?utf-8?B?QmoreDlQZFJleCt1TG54N25tT1gwVXlNdm5QakY1cWVGRHRLRmFxTmpRckRk?=
 =?utf-8?B?Mm9IWjJITW1ETENtZDRGVUp6blFzNXlPUGM2YUNUa2tVMlFJdU1sQmt0WkU0?=
 =?utf-8?B?b1Bqd1AvRzJzNTdqWFRzREVTU2ZqVC81ZHFOZGc4VjVQaTUrd1l3djIwRzdx?=
 =?utf-8?B?UnNMVTVFZ0tuWUhYelRobXlTMjZLYVhBRWJoaWx1Y0N3dmxxcGhyZU5SOXVD?=
 =?utf-8?B?N2o3MWUyL0Q0d3ZkWm11UUNPb21hMFpnQWhmb3djOXVLT1Q0aHBaa0lqejJl?=
 =?utf-8?B?dUdyNUV2K3lTT3JWazc5ek5VTENuMEtLM29MYWN4eXFxQ2ROZUtyQWw3ZlEx?=
 =?utf-8?B?ZFpSbjBYdDBmL0x3VTV6enRoYTdSOXllVmZGNTV3QVpYcGRubnR0NTNkeEc2?=
 =?utf-8?B?QWJZQzM4bi9GREhmVzNrUjdBbjM0dnorVDJtS0JpZGpndVl5ZVlLbmJlWkhO?=
 =?utf-8?B?VmtDUFpqRWN5VEZ0dmpWS2FFWEtQbjR6bml2SUVUOVJsTU9FMGVCUU84MVA4?=
 =?utf-8?B?ZERFVm43Q1FRbGRXRzE0UFRUODNXM1ZDNkpFUGhWZ3VsWDRGVW1FL0g2MDdT?=
 =?utf-8?B?T3ZBVWFEdlpGQWRYU2hUdEFjS0lZbXBtQWp5THcvNGhsc1RRZ21OdXVsYVBp?=
 =?utf-8?B?TkpwcVBPNUp0bWx3VXc5VzR5blM4MXplWUxOQzhsM2VnRzhDcmhwNTcvUWxl?=
 =?utf-8?B?VEZlLzhkK0pFUEhjQSsyYy9ubXJsMTk4bEs4VndvbGl4QkpmSWszTUlOTHRr?=
 =?utf-8?B?TUdwWGo0NHkwejZjSnlSbFVOVkFuUGRYaGtEUWhjVHhuZTVDQ2MrOHpTTDRx?=
 =?utf-8?B?QW9FTE5ORnBkeGsvK2NpbzZZZEN2UWxva0pCcVdPdG5EM2RRK3ZNK3BlNjVk?=
 =?utf-8?B?dUl0RnNvNXRudWowN1dqTzlLZGJ4aXV0M0dic0UvaEdmM3V3K2trTDFZc3dM?=
 =?utf-8?B?dndSUzFhamR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri9vcERjdkpYZllWNzRjWTdsVzJCemdpM0J0R2o5enZnNVVqZ0RoK1kvbFpH?=
 =?utf-8?B?MmI0Z05Ma1dYNXdPbGlFaUQ4enEvemdwWjcwM2F5d3pxeFQ1eC8yaWRkcWYw?=
 =?utf-8?B?YWRzV0V0enNLNXArUmZwU1NYZkhKQjhvUGVxRFY3aDErL0xFZWdxNHJOeGdh?=
 =?utf-8?B?ZEY3MDBNUWxUQW0xYmZQdzR0YUNvcmVUNUhDWkxWOXhybGVWRnFHYzRmQWFI?=
 =?utf-8?B?djNKV05mMEdNVkxBRDliWk5HbTJxWitySHNJSzhqL05QTStsT2xNRHBpNkxS?=
 =?utf-8?B?VlE3cS9TTVMzd3czSUhsaFBKTmNIa0xRb2pnVEJkQWtOOWUzbVU3ZDFLM0ly?=
 =?utf-8?B?a2lSNW1CbmJwaGNPd0E5VGJNdTR0YVJrL2JrRFJnL3BNS1F0UWw4UkhQTEdI?=
 =?utf-8?B?NitNekN4dFZtVGk3dnZReG9wMFFmRUJBZ2lmRklvM2VydEFxZ3RMb0R6aVA3?=
 =?utf-8?B?SlpjVFBMWS9sYWtLWjNIQThHVUo4NDJFcUJCWitha1VudHcyVXpNVSs0MVk4?=
 =?utf-8?B?WjBBdjdUZjJ5ZDRYUUl1bWNzOVFRRFBvSGs0N1o4RnR1SGRya0RsNE5QRXFm?=
 =?utf-8?B?bHFaUUEvZnFrRUNaU3kvTVNhcEo3L0xnSmNOYWFEQlpQU091YU5obGFRVjFQ?=
 =?utf-8?B?bHYvV1J4QVowZmVYVUJDRk83NFRzL3dsR1NoVStncHdqazBvR2tuUVB2aFpB?=
 =?utf-8?B?SHhsdU5mUEhtVUNmM1JNMUxvM3ZzWnczeE5jZDVucVZleGRxNU81RnljL1Vq?=
 =?utf-8?B?TWc2cWFYVk12YndFNGtXRDFmT2JreFdycFI2UTB1U3h3Zm9nQTE3Tld5RDNj?=
 =?utf-8?B?TEhCWTZPSGY5TTFJWmdnbGJ0K0JGYWdZU2I5OWdhamZQalhaYXZhdmdsWk5n?=
 =?utf-8?B?YTdueE1sSFVscThhelgraTZOL0pRYndBSDVxLzRiT1NSWis5bVIxaG5KZW01?=
 =?utf-8?B?ejVTWVE3VUFrZHhtZzQ3RzJ6UU95RjN4WHdxd0lvQWN2dVZlUnpvTU1QUWJT?=
 =?utf-8?B?ZGFVQVNaZlB3bmo0OE50VGxVTkhZYm5BR2pHRnE1blA0QlQ5Rk1IM3ZIdERr?=
 =?utf-8?B?bWljcTQyZUxubi9KaGMwSVFtMmRNS3M1akxCdk5TUFFBVU9vMW9VOCtzYk9z?=
 =?utf-8?B?SWpnWmhwMWVTNHF5Vkp2WWZHODhzWHRmaW5kY2FVOVh4QXNoK3ZFQnBGQm9m?=
 =?utf-8?B?aTNRRVJXbXl0UUloM25JdDY4aDJJYkY2OUxhbGR1Tm40OXFJT1ZMeHpVTFU2?=
 =?utf-8?B?bmgyeGJDTk5Ucm5ONGdxYTR5N05NL1FKejAwcVFGSHkyWG9US25BRGZmeVZG?=
 =?utf-8?B?SHdWMXg4NUFFN1YwTCs0RUpMQ2s5WjhtcjkyYmN0U2toNG5OVG9Hc2tLOVJq?=
 =?utf-8?B?cUhlNFVLazlIMXJzYld2c3AxcUxraGsxRmNmZkQ5R3FJbnVwSUlud0dGeXkw?=
 =?utf-8?B?T0p2bGdWNDJGL00xYUgxWkdnUFlUZ0Y0K2h5U0kzTWE5NHZCVHRKV3ZHWFBT?=
 =?utf-8?B?c1ZCT2EzNDZ3cnhSU1VIc3I5d2ZBdHNNTlNyQ0twbEJ4dUJ2TVBacTV4UEgr?=
 =?utf-8?B?Um9RNSswR0kxdEtyak9hbzd0NVZLZlFRY0lvVDZERmNqbU9tRUpxdlBWTS80?=
 =?utf-8?B?QThXS29taFY1Y0RvWWpOdTdVYjk5M1pQNE1HNnU3ekRaVXdrSHRDOGJHdmRF?=
 =?utf-8?B?b3BPT3RjZ0NaUCtZZ29WbjY4bmlUWlkrVzVad3Ewd2ZBdVBkNWtHcHliS3RL?=
 =?utf-8?B?VnF4VGRmUVVLbHFEdlp5ZEFrUmFOcTFwN2d3V2dnWmJKRWpXUnZYMlJCNyts?=
 =?utf-8?B?OTNJUG1PTU95c25NQ3I0NzRCYTgweldSZDlCdmtXSlBGMDdlYmhyeG5RbXYy?=
 =?utf-8?B?M05kMGZlekZrMWpRMHRHdXpqRUw2QzNXbnpzOHBVTnczVWhCZ256YVFwUHBD?=
 =?utf-8?B?TUplOGZtc3llNklLdU1NT05IRCtMVjUrZjVBU01kR21IWmJQODBTZERWS2ZK?=
 =?utf-8?B?d2hKbHh0WllxOVNiVnBQb29WSUpCNW5xZUhTY2ZLTktYaitSRUJDb2pBck9Q?=
 =?utf-8?B?aTk2OWwrVVcwZGM3RERZZkZRWWFDKzRqcm9UL1J1WGR0bHd0Sno3bzJSVXRD?=
 =?utf-8?B?TGJLajJwdGNPOGhsaDM5dDg3SkdzWklWNlQ0UVpXTWVXVFZaUjJTUmUyN2ln?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d007385-cf58-459d-ab8e-08de33ea2c32
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 10:36:39.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTyIoNeKdoIC/G1PeHC6TN/GXlrARxLd9/wEcWnOhk2opypLSyj2NUVDY7piVX4qBMSQf2nw9A3WEdGzCBwHvyOdfYoHsIYw+VSPo9Qomdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com

On 12/3/25 19:49, Cody Haas wrote:
> Several ioctl functions have the ability to call ice_get_rxfh, however
> all of these iotctl functions do not provide all of the expected
> information in ethtool_rxfh_param. For example,ethtool_get_rxfh_indir does
> not provide an rss_key. Previously, caused ethtool_get_rxfh_indir to
> always fail with an -EINVAL.
> 
> This change draws inspiration from i40e_get_rss to handle this
> situation, by only calling the appropriate rss helpers when the
> necessary information has been provided via ethtool_rxfh_param.
> 
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Closes: https://lore.kernel.org/intel-wired-lan/CAH7f-UKkJV8MLY7zCdgCrGE55whRhbGAXvgkDnwgiZ9gUZT7_w@mail.gmail.com/

thank you again for the report, and thank you for the fix, it looks good
just some little nitpicks from me:

1. this is a bugfix, so you should add a Fixes: tag with the commit that
added the regression (I remember you have a "slow to rebuild" platform,
so just let me know how far you have reached with bisection/looking for
the root cause)
2. bugfixes should have [PATCH iwl-net] in the Subject
3. you should CC netdev mailing list on IWL submissions too:
	netdev@vger.kernel.org
4. minor thing in the code, see below

> 
> ---
>   drivers/net/ethernet/intel/ice/ice.h         |  1 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 +----
>   drivers/net/ethernet/intel/ice/ice_main.c    | 28 ++++++++++++++++++++
>   3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index c9104b13e1d2..87f4098324ed 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -953,6 +953,7 @@ void ice_map_xdp_rings(struct ice_vsi *vsi);
>   int
>   ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   	     u32 flags);
> +int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
>   int ice_set_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
>   int ice_get_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
>   int ice_set_rss_key(struct ice_vsi *vsi, u8 *seed);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index b0805704834d..a5c139cc536d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3649,11 +3649,7 @@ ice_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
>   	if (!lut)
>   		return -ENOMEM;
>   
> -	err = ice_get_rss_key(vsi, rxfh->key);
> -	if (err)
> -		goto out;
> -
> -	err = ice_get_rss_lut(vsi, lut, vsi->rss_table_size);
> +	err = ice_get_rss(vsi, rxfh->key, lut, vsi->rss_table_size);
>   	if (err)
>   		goto out;
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index b084839eb811..7b409b9fca5c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -8072,6 +8072,34 @@ int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed)
>   	return status;
>   }
>   
> +/**
> + * ice_get_rss - Get RSS LUT and/or key
> + * @vsi: Pointer to VSI structure
> + * @seed: Buffer to store the key in
> + * @lut: Buffer to store the lookup table entries
> + * @lut_size: Size of buffer to store the lookup table entries
> + *
> + * Returns 0 on success, negative on failure
> + */
> +int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
> +{
> +	int status = 0;
> +
> +	if (lut) {
> +		status = ice_get_rss_lut(vsi, lut, lut_size);
> +		if (status)
> +			return status;
> +	}
> +
> +	if (seed) {
> +		status = ice_get_rss_key(vsi, seed);
> +		if (status)
> +			return status;
> +	}
> +
> +	return status;

nit: you could simply "return 0" here
then the status variable initialization during declaration could be
removed

yet another thing: for new code I would name such variable "err"


> +}
> +
>   /**
>    * ice_set_rss_hfunc - Set RSS HASH function
>    * @vsi: Pointer to VSI structure


