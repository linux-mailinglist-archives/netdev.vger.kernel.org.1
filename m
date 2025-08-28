Return-Path: <netdev+bounces-217608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA2FB39421
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C4F9821C1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DCD272E75;
	Thu, 28 Aug 2025 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGe/YsRr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429633985;
	Thu, 28 Aug 2025 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363634; cv=fail; b=IPOBY3UaGiYZf+B3ZoEsGvMhGNhYvJbksl1GgZ8wstJTZ81fV2JyN9mK3CfC3zMDnCmhZateH+UMXExUo9Dn8H/T45vrXhwBTw1cNscDpqW4oxcL1bAlKUe4XCldaLLNtAa5mahh7WKeL4veu00hVW0WteQP8c/IXwsNcyBRVfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363634; c=relaxed/simple;
	bh=ViIxQHt6cyMPPoNt0uX7Pc7dJNP5wRK757MtZ5K3skg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B7GS2/ERpVtnA2HENXHbVIlC24Xa95QwSJ8Nt+75tgs0HioI3v0Ib9AqPLCIr4V5ybiqJbBACrJlrp3EOsKRJaJnvg7lQa+yVJiI7etzUTmNhMD/2nLzWSA6PFFPIV88SmszQwg22qvzAh0b6/2gOayhnapB5FrzV2vCafvtmrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGe/YsRr; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756363632; x=1787899632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ViIxQHt6cyMPPoNt0uX7Pc7dJNP5wRK757MtZ5K3skg=;
  b=FGe/YsRrDWCZrNNE+c29aSbn8tnK9ZRRVdPW46ueyQyaHoULXEAen4MX
   myM1LnnazRLDd84G1bWKe8IFKnfV4xNwAVPgeFo7kA3DZed8U7faUPTxe
   13EDq96NFnH/WH9y67TJf4X72OlLPXEweJtEGhrMU6SSXBT50EZuYDTfS
   NiUy/TzG//4MSMlE0Z2W8J+Sr/PoLus9tS9CTAiovIpmCq2Q+KmdmRsd6
   mP8+ArxI238phwXkRji6MwAhX4e5kvQj4TvMDPYktPfu0pxqgM2KRC8Ab
   wH/xMuOOWnmXOJzpVt8i3JIvANP5qzQpjJUEer++0+AekImrUOiBsxHDt
   w==;
X-CSE-ConnectionGUID: vqne2f1uQTKbArybTOTzlg==
X-CSE-MsgGUID: AKWk89EJQa67gaW/0UNZkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58688637"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58688637"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:47:12 -0700
X-CSE-ConnectionGUID: aE/PI/8fRUuLexbaJMvoHg==
X-CSE-MsgGUID: nTmvrjG/SEWWaZlltmBq0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169629601"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:47:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 23:47:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 23:47:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.82) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 23:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGUqAZVzV10VMQeaYG+SnfvHHvlj9FJj1i7hZ+9xc303DYDoaTzXsS29t0Jym59t4JbWTKDqGLDrovFgzMtf0COX/IjAEhOhc4BkE2Q5zoUq0JPwBpL0/ZIsNMG60LJ+aXTghpnWzF/dr58jrw3V2BPCLL/1Ch31uri7z0Xq18y2c1BJdJ0TlN5/f5Az3asExeqb0Q9n0Y/YdmMFn8IDBkxUvHIicSZnkJIGJFLBOsdvsMhrFc9yRpoAbg7u75TiPeUe8mGpOmnfFpPdTzKf0sAyabO5sEsDK3N2FKDsLTyvgy97zAZpK+Sbl2YxpiCeUaqUBelODb2Ps+4z0yVk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv68e1rrhVSueGe0khc2v/VtT+ox2ezG/w9JIzVK0B0=;
 b=TGmG5LEREzDYIG/NnAYa1ppXQMjgo342m0UAizcrZzAa01dEa6eOAUORPxljhckx+00hynrP0r0JcZgkD2igrQSwPtxl8vOSpcqaOcmWN7VOBVC9bPfBv85bTsm29lSkDrFygW2LScwLSz/jdfrNL/xTU/4W2Ncu8pr9bEjBLZfcLsQnOzdkm3hoQXYP0pAA3WU7vse9AZDIBBopDVWjHS5iLDzShqqcIvbK6pzvHj3Gj9Al9V+rGKS4yYH6XzFcSQIeCBynSxSHCkG3qo/6f4SxfEH04qoRL0WzSptVSz295j6E0Z5eI99y17diwQlkB2xKsnpxAgKg2GQ2FNrN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 06:47:07 +0000
Received: from IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10]) by IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10%7]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 06:47:07 +0000
Message-ID: <9e86a642-629d-42e9-9b70-33ea5e04343a@intel.com>
Date: Thu, 28 Aug 2025 08:47:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: stmmac: fixes and new features
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cezary.rojewski@intel.com>, <sebastian.basierski@intel.com>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <e4cb25cb-2016-4bab-9cc2-333ea9ae9d3a@linux.dev>
Content-Language: en-US
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
In-Reply-To: <e4cb25cb-2016-4bab-9cc2-333ea9ae9d3a@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::33) To IA1PR11MB6443.namprd11.prod.outlook.com
 (2603:10b6:208:3a8::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6443:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3a10d5-2bad-4ee1-fd01-08dde5feb4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFZtSnA2OHkzbkdIUWd6ZUQvdmtGVVVObDRHSXRNeVNyQ0taRjNFWHRYeEtn?=
 =?utf-8?B?NEVwWnlNWEEzbmVCaFA2Z0IzT0QxVTFSOU9hR0ZqS0tQNVU2cWgyTE9SZnRr?=
 =?utf-8?B?dGd0WnMvTXBUZkJEY0MrTS91aXlnNnBqaG5TQnpaM1p1aGNrZVVyT1VBeXBV?=
 =?utf-8?B?L2VNWi9BRlhuRFNPWFd6MFU4Q2h5SUZwVjdVTkJUUWVYa1ZUZUR2cC8xRDVy?=
 =?utf-8?B?OVg2M1RvUmZLd2NvVFYwMXpMY2VpNkxiNFpNWjNjL0h6bW5zcTRjS28xMFZG?=
 =?utf-8?B?YlM4c1U2MGFXTGZPand6c2VnYnpueDVUeEM5OFlHUHcxTUwxRHQ3UCsxYlYv?=
 =?utf-8?B?M1J4N0dhcVFIcjdmTWhPSFF5OXBjU2lLb1hJc3o1MGRHOFlPaUhySmlKTTd5?=
 =?utf-8?B?Mi91MHNvUVhhL2FNbExqdHIyMThGUmlaeGhpSTcxdnhYc3BqblFYUUN3N2dq?=
 =?utf-8?B?S1U3VjhmVDBoUmJGandOVyt2TCtTZFpUb1ZlMmtGMkRnR3ByTU5PdURORUhO?=
 =?utf-8?B?aTVpTTBxRitVZ1dxdVRhL3lTVnZVcFRBajg3b1k0OUFPNTVyQTdWc2xITWR6?=
 =?utf-8?B?NXdIbjFuWWpKcXV4b1R2K2paOHk4R0UrbjRVbkhVQTdYZExLV3lTUUNlMTJH?=
 =?utf-8?B?enlhb0hlcFBOMThNNkE0c2dzU2ZPQ2VQalljMmZIVjlZNWhwV1ZMVDVpVzUr?=
 =?utf-8?B?TTJ3OUpQbWVZZ3B1WG1xZmRpOGVPOUMvUnhIU2ZVcHo5dkUxWHVJRVdEUDdu?=
 =?utf-8?B?aFVxQTJQc3cySVA1cVdwd2pZaVhiY0dEN1RyVHRlblk2OWVNcGs4Mml6anFF?=
 =?utf-8?B?L0plbnU1ZGhUTWp1YWptMnRoSEMwZ2JEcHhDL2dwNUlYVktpRWpjR0FRMHkr?=
 =?utf-8?B?MmVHN3JxZXBVUWZjUXRUaE1kU09TYXozczJRdk9VOWlRKzFPUlBSNWgzTnBL?=
 =?utf-8?B?UDVORjlMa3J4V2hUdFRHSkxEWTJrU05QSFBUSVlhcVpRTDR2dUNKMDh2Vmkx?=
 =?utf-8?B?VEJWaEIreTM4S0d3WWxsNVdNTUlOYnkzYlZNejlUUlUyZDJBVlkrMTlTdGJu?=
 =?utf-8?B?aDBrakFiRnBNOXNOSG5YMnNFdERIMzNtcXl4ZU0yK3E3bWNPTXZYNFFZOElD?=
 =?utf-8?B?QXFndVdDSmszMUJiOVZyV3JYKzI1eWEwaS93L09tNmFWNExOVnJMUS96djFn?=
 =?utf-8?B?cCtLMnlvdlpYazNCd2s1NVppcWZlMzIwazZGdmx6RnRwelpOZ2IzRithem9K?=
 =?utf-8?B?YkkzcEFlVVNEc2pHNVBKd0xlMFhxVThaVzBicWRzazkxYlFiWlBaWk95bWNn?=
 =?utf-8?B?SEc1ZTNOSDRLN1MxY0pMOEV4NnlTVldvTnZ2eGpEeFV6VENNdzYvOE9ZQitT?=
 =?utf-8?B?UTlIWDNlaFZnTDVFakJJL2pkY3pvNFE3Zjc4ZmVaMGdVRFN1b3pWRDRkbjRJ?=
 =?utf-8?B?Vk9MeEhucHhhaDdBa0ZlQWpLdWtGeFhuck9sYUVQOHZ0R0o4WHYwUHQyZnUr?=
 =?utf-8?B?V01Wc1g1Q2syTFNYNmNFYWJpU3JhZ05ETzZPeFM3UWhENzh6RHFWZkNZdXNI?=
 =?utf-8?B?T0lvUUlxaE9tOFZLd21hY3M0ME5meHBZWUlRZC80Rzh2TjJMRUFhcjkxUFl1?=
 =?utf-8?B?WTQ0ampKQ1luakxJNEcrTkg2OStUa01xaC9yY0ZWZTkxZ2doTVgweVdNVDMw?=
 =?utf-8?B?c3oxdjMzQXZLd3hmYlpvaTBNdWJFa2wvZER0M0ovUzVncVVLQmRiaUlrUlRh?=
 =?utf-8?B?R1VPSWpQeDdUK1dEd1NEOFFkcCtlcU1Ta3Vxc3ZZQzF0MHNlcm9nR2Y5L2Jj?=
 =?utf-8?B?SjFoaW5MUjBRekxRcHYzOFVpMnF1SjBJbWZJSC8zM1ZUVzFTTHpmYWx1c2J1?=
 =?utf-8?B?RW03akcrN0ttYWt4OEZRSkR5M2lwQzVEaTBCR2kyeTJ3S3dHWElIMTh2c1No?=
 =?utf-8?Q?79gqpWuYcVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6443.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpaZTJ6NWprUVRJMllxZXp4V0dKSloxWHJwUU5tR3J4Q0JCRGhKRkVKSFB3?=
 =?utf-8?B?K1kvdlhRMlZiTHZHUW1WSC9rc3R6Y1hoeUtQS29VZ0hybnZ3eUplNVZNVzFX?=
 =?utf-8?B?NkQxYkRzWXYrVUQ4bUU1bmhVN25TUGQxTnRrdkpkTGZydmhHVFJBQjBucGRF?=
 =?utf-8?B?Q0ZVRUFncVgxNDkwbVpPRnlQcEhUV0MvS3NEc1kxNUlTb2Q5RGZJTGNZNmYy?=
 =?utf-8?B?UnFkVmhxQ1FGVGJCeU5meVFuaXpHRHpSOVM1RmlvczFyd21uQ3pxODBuTGRK?=
 =?utf-8?B?T2VRUjZqTHQ4WUZHMlhEY2lZUmZ5a3ZuaC8yNTVQVXZxbFlZaUs5T3puWE53?=
 =?utf-8?B?ZHUrd0FKOGQwNUphakRoakVCc3hMWlMvNlRIRUpVcEFML05zVTUzeFo4L3V4?=
 =?utf-8?B?dkRaME9QZ0F4bzhUZy9WNXFZcTkrSkZmUk1qV0JpZlJoVFlvOG9uVDRrNHI5?=
 =?utf-8?B?bjE2S0Q4amJHc2FFb0JPSGNiZWo4dEJXTEpwRzQyNHRSbzl3L3NXWTVjR093?=
 =?utf-8?B?Z1kyNFlVNDBOTkh4N2JXdmRzSjYrWS9JZXdOaFNFVE94ck1SbTA0ZFZBK3Rr?=
 =?utf-8?B?ZWRjSXErNmkwUlhBbE1aYlBtL1hCeWp1eHJsMjFZM0FzWm41WVFFczFmaDVX?=
 =?utf-8?B?U3Zhc2JZZTA4VHcyNVBjRlV0ZWh6cHFyOHUreDZhdkh0RDF5SWdFUk8xM2N2?=
 =?utf-8?B?Z0c3S1hpL29vcDZ5a21uYTErbHE2WlkycTdsTmZsYTNGN1RoaURIMWFTNklV?=
 =?utf-8?B?UU82dWFlSWxVQi9kS0FTRFhBNDlqMFVnTXU0V29sci9sdzJzYzNVQWMwTS8v?=
 =?utf-8?B?MWdGZHpKcVJucnR5V3AyTHZsaC9XTHhsNUdkNnhBYnRjZVIxYTN0NU91UHNQ?=
 =?utf-8?B?MXRMRUJJSGV5dUZFTWppMVIrRWRNM1dKVXFzMTVrRUdnNW1iT0tVWEN2a0Y3?=
 =?utf-8?B?RVBPejUvUkZnSFRrK3p3NVVZL2plUjN0Qm44TTJ6RHpCam5uYmxiQzNTZEtJ?=
 =?utf-8?B?cGtGeWZaZFgxalNwdW9ZWUZkSDJiRjh1R3Y5WE1FNkMzUEovbTBLbndvc3po?=
 =?utf-8?B?OEFvclVmVGN6czZuNHdyYmJSRSt4M1cvY1FmV0ovdnNVSGEwcmFONCtBVks2?=
 =?utf-8?B?dUVycG5xOUora0N3WE1aNVprOS9obWN0NHR0Q3NQK2NlZ3RtUlBUTm9Wc05W?=
 =?utf-8?B?bURCdmpjUFIxMkNLV0RWbEQ2aFE1bkE0d2NTNmxnTDZBOVJrd1ZNOVdhWjY0?=
 =?utf-8?B?WlNmWDM5Qm0wQnVXNmFZeU84ZGUvc1lMcmxvNFZjaktldFdxUkZsR3ZzYk84?=
 =?utf-8?B?WjQyTnNZMGdWckduNDNnZms1ZW1oMm9FK25KYXZFSmZMU1lIekQvVVRaQWFK?=
 =?utf-8?B?eEZNelFXd0N2TGRpVUtMMVFmVzlHaFl3d1ZRNE1OYy9MWFpyL2lSdVZEcTU4?=
 =?utf-8?B?MURiWXNFcTdHTzBXeDZaZjcrOHMyR2N3cW1CQ2hFTDc5dFExZmxraTY1VFRR?=
 =?utf-8?B?VzdiYVdXdGZLci90QlFKVEQxYnJNekJXWVdDam5Yc095WVhySS9LQ0FKZGNj?=
 =?utf-8?B?aEZIUGhLNzMrNTA4NUg0ZUlXUGtMTFlZMFVDYTNhSE1Yb2UxVkxEajErN0pI?=
 =?utf-8?B?KzhDQnUvSjUwbkpFZ3hxZ2dWRFZCUUFKRU5BSXhEbVRyNUdxWXRYemxPdHJR?=
 =?utf-8?B?Y05TNjBRNWJqRHFVUXVPdERCOTU3a0RQa0hxdDNXc1JCNVVpZDJOeHBZUzZH?=
 =?utf-8?B?aGN2WVRIaHlJUGx0alg0S2tGT21VYnNRd1FoeVlEWjJIYUVvQWxMY3EwM1Yv?=
 =?utf-8?B?ODhnQTRPZjFmVEFFNXErRmpXa0U3cCtMUVN4Uks1R1VxTmZNME5ycEpGQ05q?=
 =?utf-8?B?TUVTY1E5dS9jOEFycXpZNHZwS2orQXRudk1NdUEvYWlFSVArMlJoSTdpeUht?=
 =?utf-8?B?ZmtXZk83cTBqUWJ6c0NUZHgycWFUZkdSV1JiNXErMFFqR3p4Y2xuT2xwdCtx?=
 =?utf-8?B?ZnhPcjNRcThYbUo1TmgyckVQajlLZWQrZG5YVmpEaU9FcUsxQXNXR1M5M1dT?=
 =?utf-8?B?bVZmdHJSMzdzdi9jWC83Y2xRSkFVdW50MWtQcmhZMjFNQWNtNU5WaHVhcWRE?=
 =?utf-8?B?ZVowbm0ySjVHa3ZIRlFINFpoK1I0YXVvNW9OTHVMcE5ES1JZZ3dRWldGeGIz?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3a10d5-2bad-4ee1-fd01-08dde5feb4ae
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6443.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:47:07.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByTlHaIKjZ7QOQmqutrHtE1UCN8iPQIiXzgQ2tvCMSctAgFk10hKKYOnpl5go9/68UyAqZwhq6ufVz9gVZQjEEr9y8oL4PljuWco6xd0gUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com


On 26-Aug-25 19:29, Vadim Fedorenko wrote:
> On 26/08/2025 12:32, Konrad Leszczynski wrote:
>> This series starts with three fixes addressing KASAN panic on ethtool
>> usage, Enhanced Descriptor printing and flow stop on TC block setup when
>> interface down.
>> Everything that follows adds new features such as ARP Offload support,
>> VLAN protocol detection and TC flower filter support.
>
> Well, mixing fixes and features in one patchset is not a great idea.
> Fixes patches should have Fixes: tags and go to -net tree while features
> should go to net-next. It's better to split series into 2 and provide
> proper tags for the "fixes" part

Hi Vadim,

Thanks for the review. I've specifically placed the fixes first and the 
features afterwards to not intertwine the patches. I can split them into 
two patchsets if you think that's the best way to go.


