Return-Path: <netdev+bounces-258351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP4cF47YjGn8twAAu9opvQ
	(envelope-from <netdev+bounces-258351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:29:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E487D12729B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50DC03004D31
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49BC348898;
	Wed, 11 Feb 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GF9IcS3f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CA27FB0E;
	Wed, 11 Feb 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838153; cv=fail; b=iqxsQVY2wAfd3ewgP9FvBkshG+Gdq18pA3I7vYv+xmRDfZgydCQjso+PaCMvoqZLOJwjNmYs+pRPlAZ3QqzTjwg0B4EmkIwnqF/jpNdOOBlCpfzFZcDcalQb1X+V8upnuQmYzH8AeJBVR4tsUfuvpM3VOhkYsB0Ov7acZsnqQs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838153; c=relaxed/simple;
	bh=UlzDpM4jJbREsQFvXMzg6zjNa9Bt6WVXkMh4YpRcxIM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=elScDSZXXVYfRye7ql7jv6bm1THOkikKAIFeg6Q+VLr7YfUbH/XNh7hsH2R62Qe8ucsGaxAc08N0dbzDf/ceYhTrIWmND4uR8IDuHcLviWFYMUJTtAWQPhvZLmywuqFvjjveipyA5zNeqMisOjU9E7mTl7Nek/Oj2i31e1pu8Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GF9IcS3f; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770838152; x=1802374152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UlzDpM4jJbREsQFvXMzg6zjNa9Bt6WVXkMh4YpRcxIM=;
  b=GF9IcS3fQVoyC9sMGm5DeaxJFym/EyUUFV3UN3ZBpM43rzHW3SMXaZKs
   Gvx4drpo+RN5i6eUZlZQP9sd1X621ZQFNY4xTIO39z69eBcsSxwGieYN9
   GfluxR5oegnp+flZwkKSYxBNps+pZP4sGhoW9uCJLdHzgNMlvxHmleJN3
   AG6zP8T/ko6rH9w38AMOE1rQvRIgDuVP5Vq5Nk7gVceJgh0P2PjAWlYxQ
   spUZ/maDbZt0BCKD7YLtp7ro/1N2v9J+JJEqdsDZY4qhkvju4tIXP49oD
   scDaJoLbTzrPeR5DdqgXHaBesyAp2bJoYr9gSNh39SaL5e6l92XvjUaAJ
   w==;
X-CSE-ConnectionGUID: 57pe87tLRyuUMdjVQ0AuDQ==
X-CSE-MsgGUID: i0shZkgQRretl+FmPYKJAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="97454000"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="97454000"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 11:29:10 -0800
X-CSE-ConnectionGUID: kDJC9SPwR0CrvTaqqtCbsQ==
X-CSE-MsgGUID: IOYeuzUYS02UbgtdEKFBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="211922547"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 11:29:10 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 11:29:09 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 11:29:09 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 11:29:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yd9xhRJFjcZnUHB2GjeAxASZev1oTWIVwrwtDhAJYmCo9COroqt7ZpvG2MF/gWZAXrmEoq5jELUYduNFhr+mSJ5yHTVFDnK1El6opsLz+EK7UFDTWyN4AOjqW5CPXyhipIqBoNDQaal1L+fcm99E+7m0eyu6/RLAwLjl0xWd6L8dyEDed9pFAaI5dl/zD3g+SwVU9I2wZxF6zN0iT/zPdst8VKMQiNBV27xdNtEs6LOMG0xdb5HuxU8zWQZjmaHfdqxSRBGFzXhWYIztVIREb6BDBx4g1HTyNobQ/l1jrUvzdo5zUDarexnKUSmBgDsZdP7iGUfYDscDakFwO4mQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOLLdQBdQTTaAKEzha6l10MREepWzG+6tBk+QdWq7bs=;
 b=UZdEfC035I7cBzn2QgBeUbyK0brusOnPN93C/8QwbxZOmlDby+a6gu2W70imUimdMpxdMBkzy2v8e3EKWsLXVUNQ6pcNSHJGzyW9nl5oVYd15lXeI4Q8PwoysLNOOKQVP3UTuS8hduUs+U4paO900otmohvYZiv+415rcrsg1wSIaEodITfV+SSyLfsnYIteZ0MzhHbHvONh9TtM7Y9Q2kUbj9WrkxTO40PP5l41bCVsJLoK1B8hvecfnKTG6Jr6zQrmVNSSVrRGdIcHQBueZdR/7dIF8qqJ8MGQIXhpxaqr53jjhQxM8fWx0+Wbkk4LPQpzqOAmtlhlEm3geVdIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Wed, 11 Feb 2026 19:29:06 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 19:29:06 +0000
Message-ID: <12520aac-c69a-41a0-9710-497392bc18f6@intel.com>
Date: Wed, 11 Feb 2026 11:29:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
To: Kurt Kanzenbach <kurt@linutronix.de>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn
	<willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Gomes,
 Vinicius" <vinicius.gomes@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
References: <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com> <87qzqr5vos.fsf@jax.kurt.home>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <87qzqr5vos.fsf@jax.kurt.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA1PR11MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 143cefcd-a83d-454a-3e7e-08de69a3d229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVRBSks4aUJOcjhjYmJUNkd3WG9pZzBITERuZmZ0Z0JScW9vOUl5OTBabXEr?=
 =?utf-8?B?SVdrWEpENkM0QWVpU2I4c1p4am1lMStsZzUxT2VINHBHUDdESy9jb2tRUERj?=
 =?utf-8?B?a240MUk4clFGS29OWGNTL2FKL1dmczJ5ajJLbDNrTjhZcFIrZVpydjNwbnlo?=
 =?utf-8?B?aXVyM2M4TURDWmo4eEpsYTJGQ3ZkUjlHeFNabHFGeEFSSmhVQTFIZkgyYm44?=
 =?utf-8?B?dkd2VFhVWFYzNkZUNkkvTUZheE5tTVlUd25sdlZqU1Z2Ymhxd3BFR3ZSbmhY?=
 =?utf-8?B?TU1pMy9HQ1BpSS9PdWVaR00vNW92WUpteXIxcHl5MVc2QUlOKzZWbTFRK3JH?=
 =?utf-8?B?M3VsbHorWGZvT0N2Rm4xYTVLRmhKRnhZQVMxWUpRbHQ0Tkl1Z2syNm8xRng3?=
 =?utf-8?B?Y1lLYTd1SWpFOHZ5bjVvNk04MGc5MkllK0h4ajhQRUN0aXlleEFMSnYwa0w3?=
 =?utf-8?B?REx5S3B4VHJIQ082OTBXNjY0eXVtcVQ5aXNMRHdGL2QzZGdBS1lFbitDWjBE?=
 =?utf-8?B?NEJLN3QrczE1Q1dTN0pxVXlpVmtYUm5YWDBnU2RXL25tNDdIL1ZOcmtxWStu?=
 =?utf-8?B?OFNHRkN4eG9selVSUnlFNFFPeTBPZFY3WkE4bHBTR2diVU5najRqWmovVU5o?=
 =?utf-8?B?dTZkamRxalhmZHk2QmdsdDk3dW53bGduYUlXVER4eFJNLzNFOWxTaVBBcWpt?=
 =?utf-8?B?OUhadFRjZ2x3eXM5OU9Hck5zOEZDYVh5ZFVzTm9WNmpvZTBRTks4ZGgveGp3?=
 =?utf-8?B?ZnA0V2hnMmNKcTI4MWl6SC9HUWtVemRyZ3BIS2ordVAweDMySUJyQTZPd2hS?=
 =?utf-8?B?SXc4a2FSWk5BKy92MGpJNlJvWk1wdmtOaUZNdXJSRjlndmJrSUtHTDhzK2Vs?=
 =?utf-8?B?am5xdVNPTENkc0pRcTFkcExPK25JMUE4Mk94amczUnVlU0pCUTF3YUdjempz?=
 =?utf-8?B?dW9pL21GUFZ3OHhCOFpDbTQwVEp6R3hYMnY1bnRQc21ZMEt1Z1R4c0h1OUdG?=
 =?utf-8?B?aVM2NXpiSy9PLzFVYzF2QUlaaHBLY3R1U0F5TXdHNDFTcGJwT2hmWlRKTzdM?=
 =?utf-8?B?bllXdytLWXFvdE1XVWI0UTE5dktYUEY4a1phcTRrOHVaaWJpcG9OckVsQXdm?=
 =?utf-8?B?dEdDcVd5NHRPKzAwdUF2aURNNUhmSDhKcjFXK3Ivam9TdXgvWmpTM25GcSt1?=
 =?utf-8?B?Zkg5NllWcldUL3YzWEtUN2xpVU8rcW9mRmprcTUrM3FsWkNQM2kwVlhxeFZM?=
 =?utf-8?B?cUxrNk9nY0NTOTk1aU0zODJsQkFrWXdKUnc5bHd6aVZscFdBZlNiblFuaEsy?=
 =?utf-8?B?TWdRbHpLUXczY0M3MDJTbXJzeEN1cFhPT1RwOWQvdWY0dVNieks3bWVCVDNw?=
 =?utf-8?B?aS92NU1ZSXhDWjRmUnpodzV3WWh6NlhsS1dBU1R5OXhLbE9oazhONktEU20z?=
 =?utf-8?B?TWJYOWF0ZzB0UkRra2JvQ1A4OHdQR3lVempGVVliYytyVHhHZ0dyQVhCVVlh?=
 =?utf-8?B?cHBiLzVOUXJiNnZlR3dEcUVNWGd6akZxbkE5RVlpZWhubDgvUkdqbTJRMnVI?=
 =?utf-8?B?bVVsWW9GOHRTMGpLeXk3dXNZQktHa3ViWllWeHJ3YktGWGpjOUF1RVNCemUx?=
 =?utf-8?B?cHF5TU12VDVyZ1BvWStDQkZSekE4Vzk3UHNpV3Qrejg2djZkOEd6ems0elJq?=
 =?utf-8?B?UjRaVk5ZbGlQVFEwa3pKdlFqdzQ5am1CbmdxUXhGYXRLeENsOVNSUml1NEt1?=
 =?utf-8?B?YVAxYU5JbU41THc1TERhN0o1OHYwWFdpMFlCOU1JOCt3T1ByNTBYd1NWY3h6?=
 =?utf-8?B?SHhldTFHVWdmZzRydGhQeVhld3Q5eFhOMkUzZGhOTkZGVTRwYmhVeXVxd216?=
 =?utf-8?B?ckNXZUpUK2ZBWjAza2JCQVlZeTg4L2hBL040ZENJelVEQkRKTmFqMGppcFkv?=
 =?utf-8?B?bE10My9FM1M1bmdMTFgrSnFuR1kyTXFBZm4zMDlYLytSNEZBSHErbFJvNnlI?=
 =?utf-8?B?U3p5U294ckR0N2hDN0pXZFh4L0dENHdXbTh6R3V1cHFTWjhLS3VFd0lpMlNu?=
 =?utf-8?B?N21KVWxLeHJQMVZIbGJ4VGI1WWdnM1Vid2ZFVnJvTDZ2U0xzdktBSGFORXlB?=
 =?utf-8?Q?QqbE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzBWemR1NDVMNW1wcEF3OHBXQU85d0FYOEh3V1dXWG5FMDBpVUI5L2ZvU29s?=
 =?utf-8?B?UkpxRVlGNDZHQW9qdFZ6WmdqaEdqQTQyNzVvVTV5ZjJJdU16ZW9JUGZoWlEr?=
 =?utf-8?B?NUE4UUdOY3hhQ2xOR3huUzZFeWdPTXY0UjJpbzhmQUxTMEVzc1NOT2k1azQx?=
 =?utf-8?B?NWRrNzhIQzJRcXc2QTJDK09Lbkp2NVR0UEM3alZ5T1MwVk41QlpGazhic3hK?=
 =?utf-8?B?VGhvcjVZYjVzMWcrVkFqRU5LU0c4UXFjanprRmdNQjI3UUpDRmNmQTNWM3pz?=
 =?utf-8?B?dUdzWFBKZnA0NmRQQmxpNTM3a0wrMFhDN0srWXRLT2dhYUk1eTZ2Z3NlWHB6?=
 =?utf-8?B?UUNYd3VXcWZYcWZDZE5xZGhsWVZka1B2SXpXa0F5MTE1NkpsQzdaSHdvT0Zr?=
 =?utf-8?B?TUJGcVE1R0svc2laL0RqMC81YlZCNFhyRFhUQ2VPL0tQQW1KeWVSUld2ZEtM?=
 =?utf-8?B?eWs0S0pYUGdWM0lKeTdrNVhPcVFsVEdSL0V3WGc3UWRPZGcvYndYQ2xsYmw4?=
 =?utf-8?B?eGxsaE94eUFpV1JGOEFZbFl0TGNQL0I2czRJNldiclgrQWlVbnJhekR1UGI5?=
 =?utf-8?B?SXdHVXJjTm1kVlRWMDh6VGVxRzRIWHl4VFZINHpDcW9Ed3hZd09jQnZtMW5E?=
 =?utf-8?B?QXB4YXFmOUhWQmRoS1Y5ZE9kQUpaUnU3d3VyeXBxNlVBTnp3R0NjUXgzRm9S?=
 =?utf-8?B?RjJ3RFFSRWhiU0U0WVI2WGs3c3FsakVXQnBaMitFelNJcWJqRTcyaFpEQjJT?=
 =?utf-8?B?T2xyY3EvRlFsN1pPbVJpU3lyNk9WajRsQitLdVNrOG1NNnJrME9hS2pKRkRZ?=
 =?utf-8?B?bzdIVndDZitTN1g5dG9xTzZYa0o1dURKR2tNZDlZd3ZaWlVuQko4T3ZtUWdO?=
 =?utf-8?B?S1VvaDNhWDIzcUdpeFRGMlZIeHNkU3ZhY0hqcThPdUZTTEc3UnFVOVBxanlk?=
 =?utf-8?B?UFpVUncvaFBzaGlqRzBSTXBxWVV6aDl0dXFPSWZDanZ5Y3RZQjltTkc3SkE1?=
 =?utf-8?B?WUFIVUpSbjcrWk1kbEhVSVNVanpJK2R4M0V2MHRkcFludERoM0draDNMVXNC?=
 =?utf-8?B?ZXJabTJVb3pyUDErT2tnMXpTSlJMem9rSjZXR3BXaWNjYXI3TjZRN0haTitR?=
 =?utf-8?B?bEs0OExoVzJMMVAwZEdlWC92a2U4eEt3ZDNJTVFBOFRZMUUxWE1nb1VZMG1p?=
 =?utf-8?B?MTZhaTZNUTRKWXEzNGRxcE9NQmNGVWp1eW1YcVBuNGZ6UTJCeFlud1luMGc3?=
 =?utf-8?B?cXdhSDJGczlOdlJJNGFMZXZyQlU2bjROdE80azNRa3FlZDM5NzAvOExVS1lI?=
 =?utf-8?B?N0kwVjBVQWRxNlVCNUxDNHVtM2d4ZkR5U1lPYUh0Nno2RXMvTmdhVmlPbldu?=
 =?utf-8?B?U05FaVFpNTdveWIvcGNkT3JXaDJrcVpKVFFtbXZvdnlZNEpuUmdwQVRwR28r?=
 =?utf-8?B?YXhuOSs0bEh5em5BNm42MzVRblBkUVlUUlEvdW9mTFBINUdWU016RDV5RmF4?=
 =?utf-8?B?Qm1aK2llaW9WSElyUGY1MGZDNjg2UENrdjlrNWhBQm1xbC9BTWFscy9mVWlu?=
 =?utf-8?B?WUZFL2RXTHNTMFI5UDg3UVRzc000VFBZV2RTLzJLQXVsRG9YeXpPTGcxUE1H?=
 =?utf-8?B?UU1zOS84TzhsanRWTmUvVlkwTkN1dFRuRkFEYVgyVzhvcCtNWkhtYlA1cnYy?=
 =?utf-8?B?Qzd0WmF0Vng5eXBPTlFWNEhQNDJuV0ZEMHRLRTM1Y1V5dThSdXNNK2dmczFl?=
 =?utf-8?B?WFdZZnBVcWZkdGRUbjVZSWlPUmJGVlpzbzFXVFdMdlhFRnREMmpGdC9CWDlG?=
 =?utf-8?B?OEwxNDNnZFliUXYxTUk4WXZTOHRzQlNGelZyd05wUkVDWHdKVzZKNlRqVVov?=
 =?utf-8?B?OW1WU1JOTUo1YXJHdGdoQjBkb2tZanFGNWN1bXk3ZlFiRjlzVE16YXJBTWdX?=
 =?utf-8?B?Y3JBWmhYTG02Y2FGcGk0Sk45dE81aDNuQ0JXUC9TcWppTVhDSnJndkR2MCtD?=
 =?utf-8?B?WXdnbFNoYlBzSjBFTFg4Y0hpY1dKdG1YOTNjaEp6SVMyUkh5MktGMTNQdStZ?=
 =?utf-8?B?MWh2TUQ2ampHOEx1bWxpaE5FY09kSm9WaE05TVFZYmRVVDd4MWZkVVNtVXVW?=
 =?utf-8?B?RVlpLzFNa0Z4NkhEMEp3Mmh3eERXaE9UVzFEMDhGRFJYMlNxbDJxVlo3SEJN?=
 =?utf-8?B?U2YrOVlNU2x3b0NyblRNYWRxOWRibkdSRFRKTEhCNEdhVlZzb1ZNS1NDWlhF?=
 =?utf-8?B?SUZLOVdhbWd1d1lhKzVBMkF6SU5Ram1aYnlFbEoxLzlpcndjREpER1huaEgz?=
 =?utf-8?B?aVlTem00WDcydkd6NkdXc3B4ZDNURzBxOGRFbjhUNUdZZmRDMWtycEcyRzF4?=
 =?utf-8?Q?Ezw+bhM0RR8nukIQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 143cefcd-a83d-454a-3e7e-08de69a3d229
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 19:29:06.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7fiKwIlouZLiBcFn3V47Y8Wuj6r1HVSSZgYpD4CIklhKeKH+cygCVFrIOuV6bS3fWoQ3DDSdSndamn8I0hQcNUIMAp8RBFCDEFFtffak9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258351-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,google.com,kernel.org,redhat.com,davemloft.net,intel.com,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E487D12729B
X-Rspamd-Action: no action



On 2/11/2026 4:08 AM, Kurt Kanzenbach wrote:
> On Tue Feb 10 2026, Willem de Bruijn wrote:
>> The core issue seems to be that the ptp_tx_work is not scheduled
>> quickly enough. I wonder if that is the issue to be fixed. When/why
>> is this too slow?
> 
> The igb driver uses schedule_work() for the Tx timestamp retrieval. That
> means the ptp_tx_work item is queued to the kernel-global workqueue. In
> case there is load on the system, the kworker which handles ptp_tx_work
> might be delayed too much, which results in ptp4l timeouts.
> 

Right. Old versions of ptp4l wait for ~1 millisecond by default, and 
newer ones default to ~10 milliseconds.. but latency here can have 
negative impacts on sync capability especially on profiles with higher 
sync rates.

> Easy solution would be to tune the priority/affinity of the
> kworker. However, we have to figure which kworker it is. Furthermore,
> this kworker might handle other things as well, which are not related to
> igb timestamping at all. Therefore, tuning the priority of the kworker
> is not practical.
> 

I don't think it is even guaranteed that you would get the same kworker 
every time, so I would consider such tuning not just impractical but 
impossible.

> Moving the timestamping in IRQ looked like a good solution, because the
> device already signals that the Tx timestamp is available now. No need
> to schedule any worker/work at all. So, it'd be very nice if
> skb_tstamp_tx() could be called from IRQ context. BTW other drivers like
> igc call this function in IRQ context as well.
> 

Right. Reporting the timestamp from the interrupt is the simplest and 
lowest latency method. I know Miroslav had some situations and devices 
where it apparently caused more problems than it helped, though I don't 
believe anyone else has reproduced those?

> Alternative solution for igb is to move from schedule_work() to PTP AUX
> worker. That is a dedicated PTP worker thread called ptpX, which could
> handle the timestamping. This can be easily tuned with taskset and
> chrt. However, there's one difference to the kworker approach: The
> kworker always runs on the same CPU, where the IRQ triggered, the AUX
> worker not necessarily. This means, Miroslav needs to be aware of this
> and tune the AUX worker for his NTP use cases.

This should be the standard at minimum for all new drivers, when it is 
not possible to report the timestamp directly in the interrupt handler.

> 
> I hope, that makes the motivation for this patch and discussion clear.
> 
> Thanks,
> Kurt


