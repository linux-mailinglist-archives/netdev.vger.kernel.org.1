Return-Path: <netdev+bounces-84740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF68983BE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89351C2154B
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2F7352F;
	Thu,  4 Apr 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxalPTgM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5221E86F;
	Thu,  4 Apr 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221788; cv=fail; b=WaUGyPohVTX+S0vt2v9s7r4wudLwWzXEJC1NE9M/NPNL7Zl7IX6kvarAFX0YrB9C4FxPsY4v6McWI2tWhdB9XrFm0uoioCnTqOkJ2cpUte1HW8Q8Cw53DXnZvm1nNaYfy0ruOnJvYnj3NvrRioRqqXdSCyIoeCF5+w+eZLKAG/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221788; c=relaxed/simple;
	bh=s82c1Rr6FsaH3WUJNL/pPzipMLA+nknWENZ0SgOzq64=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n8BPHrk6i59Lah3xgpoM8X42vTsNAEyGt4mIHnK7J/U9pnO4j+EkVkvdlooh2uVLHlequbsaEQX7efc0lmdVIFs0yy2R2X6qkHreqab5uoxfRSmGIDiQaMFhRb0t3UXNUFk/Pfnv3+lIkA3POHmubg42YHiqHlAXZZslZsVNQSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxalPTgM; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712221785; x=1743757785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s82c1Rr6FsaH3WUJNL/pPzipMLA+nknWENZ0SgOzq64=;
  b=PxalPTgMZZmmvbkZIw4LmUGaVvRJQQ07fwFGHgiAuIU/VYqHsig/+vfZ
   hL6GKvuiu9P2hlj9upv8qyqs36QUkNRLO9lBbIXOc9m8ojFJsm0F590H9
   RP8WecbQT/QaFlQkZ8A/vqCUuM7JQ9ih4CYeDxD1qP1PdJ1IVKVHgbIoV
   xOIvznGFC5Zb/BIB8pxOCq0CrH4UI9iTvzbF7TUPxUOdrv8qB6Men3std
   dD/UW4d9ACK7rO4sInBN/dygqvIhIfQEExnWSN4ot+jIJzjw1OdUd2wwH
   vOLy+CBsNcz37JRlBjB/SXKHMsHysRHRdTAIYEt/XEOIkedfhlRtRpcJt
   A==;
X-CSE-ConnectionGUID: BsdDA4eqQyyOV0e/uHGmRg==
X-CSE-MsgGUID: z7ZP6cPnS7y4I3ay6l3AIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24948083"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="24948083"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:09:44 -0700
X-CSE-ConnectionGUID: /Z3iAKLkR/u0hoOsorBPAQ==
X-CSE-MsgGUID: 1BcNNrZAR3anXMxMEtYIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="41888071"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 02:09:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 02:09:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 02:09:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 02:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+urr8oMZWt7uQFCUmoBgUslEyDDo/40vAKdJC01mWmMp4hP0Bdje54IKwqS2Fj8QLQXWgyYoe1DQFATAfsSHAfocBplzJhkzUV1qERJ3IOTLHDYWFbpTvApXammtyY5v8fSbTQiun6YrtWNN9sSzXbWO774gCselOR3CmClBAByOJWBgjZb9zAPaYxi5/RIVobKMsu7HaSuBhjaGekKm48cwczaSSVfbiZyfbC2goduNuypSDBzr/BKS13UNdmQD7TcjQhFc/UHVWFr/8mwdiRjchBwxiSIMPDyC+fNV5ZDGjNUkTkmNR9aCwjbbtNYHl/JP1gJ4abf2fsmUuBpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVGmFdYaPKUxySzv1cIRiXVtor6PMcrV10ZYVc8cZpY=;
 b=U/CYjl33anMdLDQkPwzW3GetiY1nTsTQ+o59JYbX45ms6hEYH9y9BiEKScfNskMOT2xzCzYs+BNtRQfgZ5cWJTiAw1nXPUlOV3540BuahEmWY9UQE8J1gppdpH8RP1dxKDtZrGKrhsezoPES9seDRqhpNtBucuwRm2r0m5F+KVEcRSaxu4HgU8SnGsbzKtiy3VU/58Bgj9c0/hLu2DXqqQ3he/ENg8QygIx7JyIhaEXV2f36fifnzZayiiK0At5DBUWa5MwwjDZ7XERp2++q4rP4hOiwgC54qWg0BRkEEb88V5qNO2QFzJRMITrirsLijHIAau+wySIae4nYoXJ5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6453.namprd11.prod.outlook.com (2603:10b6:8:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 09:09:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 09:09:32 +0000
Message-ID: <2ac91d55-377a-4d07-8d13-b7fa9ee46302@intel.com>
Date: Thu, 4 Apr 2024 11:08:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] net: Register system page pool as an XDP
 memory model
To: John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-2-toke@redhat.com>
 <660dba106f0ed_1cf6b208ad@john.notmuch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <660dba106f0ed_1cf6b208ad@john.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6453:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqAow0C11jA7o6or9j2nzFpuOWwvye80R/1M5/2GPHRCLynOeZ470W3YanM4BIHHtPbvKgPUOwXVrNNhcBNYFFNjiibJAibuKEZJnzSP86L+OkIjPYG+dsXyYd11Jy0qCwnLJLauHA/YoNqT2uXO8ZBXXe/sv5MzH4jHdXnvQm6C80L2giIQFFwtZf77wSOgTSJpvYz5WhIEntUjJntruSWiqEupj1jEgPkKpT38bcYTPdG8cQdKk+jbhhSIg9UhtT/c18zF7YNmSgK3YKmQMvO3XFe/AKEGVC96CN4PkZu0wcTzHPtEJTREC12M262fWhr5CeAYkqN8qIYyI5bTMezXm9uUS9LEFuvONjtpmdcwOW1ekbbv32OsQvHoXBZz8CwkKVYW6tIYRfYgNJuO4pMc0lNQBL/lYT5J1516p7hpTXMfGR9iOm7yhwCOxvDOD3LJb3I4hm005OhSM5YOYHBRcdloKZ9imznXOq5li0Df0srY0UkzpR1rXiYw40KnEq68v3659fCizBWQuCjidqLkE9z3TJ5hp5U610r+IymLfi+VGGXHsbZuLB+cPSq+1rVNJ6FwPpHwbSykGL4/noWLmTZLvGvxLbfxdl7lAVk09OdG71ivndAeWyrB94zhVXUc/JqAEq4ME8G/kwnatIt3exfyOsgtYfcHg+V/DW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNYM0ExL0poYkQvQWN0S1d6Tk9pNFBwanNVbDBCOGxzYXhXbTZhY3BJVlVu?=
 =?utf-8?B?U2MyaFhXY3NiOXpsZWFoczV2ZGNlWi9ibmpMRU14MWpKR3I4Z2NkVmFNREV3?=
 =?utf-8?B?QlRDem4vbkVLcGFxTmxpcGdhRnFyTzRIRUdwdVQxVVZLRHIvQ3ZGQTl5azJn?=
 =?utf-8?B?TThuQ1RNdzdJVDBZMUdsb1lWOVM0VUxPUDRZRWVPZFUyWVY0a2Y1dXlMUTE4?=
 =?utf-8?B?eGE5ZlR1OU50OExEVzU1d0drcXBaMEVFU3dtSE5FWDRxclZ4aEFNRW55WUdM?=
 =?utf-8?B?aWRBQXNyV0JPV1lwNFhicHkyZzRnY3BzYk5tSUwweVAvMGt1OUcwUnlJS0pY?=
 =?utf-8?B?T3Nac0hLU0hqY1BpejJrcEVpWEFHL3o4VjFOTGVJZG9LbVZmeW9TVkR0dnJC?=
 =?utf-8?B?QW5sSkhSZEErRFJsV2E0ekZxcFlkUk5EekNNeDhrc1drNnh2Uk9EUWRTQWNz?=
 =?utf-8?B?ZWpyeGtuSndVREFrWGVoM1MveTJ4Y1ZKMncyd1VmVmp1WloyZGZtUEYyL29R?=
 =?utf-8?B?MXVqS2ZGQ2JEYUE2TlpYWmFCam9rcVBMRkJCU0Nmd3BCSGdMTTNEQjlOSUl0?=
 =?utf-8?B?Znk0OUVLSDc2T3Z3SU5aYWVNRlcrUXhsS1psRitkNVBMSG5RS1R5RFZLbmNy?=
 =?utf-8?B?MEUxczhkRWl6a09jZ01hUDBOZTc1aFBJWUhzdUNramZhOTgwVGJuWmFKYThE?=
 =?utf-8?B?ZkFmRlpnR1pBWEY5dlh0bS9vWmdiYWc3SWNVTDlWblMzMnkycHptbmpKaTVR?=
 =?utf-8?B?Smg2SkdCV3NqTVdXcjh4UXNRS2tZSHUyMmlZZXZPcDhQTmV2VHNNcWI0akVK?=
 =?utf-8?B?SHd6ZTZjNEhxVThSZjJkUGtpd3dtQllwYk1mdmgyNElEaTVMUTV1bGhCS1cx?=
 =?utf-8?B?b3BBSUtxb25JTFFWM1dmbldEREZFakE1c0NsakFaNWZ4MUJtdWl5d0E2Zmxu?=
 =?utf-8?B?akVveVNtQTVOWVNOQS9CVGorV0tLd2s2OUhnUk1XMXlPU1RnOVEya3JwK1Ew?=
 =?utf-8?B?L2V3Z1I2SjV4K1p2TlcxSk5uaGhvUENQdHdESGdSTEppTDlCVGErSlFseU5D?=
 =?utf-8?B?UmpNOWNtSU1sY0Zjc1F3d1hCUXpNaGdqbDZzK0pUVXRaK1dqMzJxU3FJYXZH?=
 =?utf-8?B?Q2wyYXVBdmoydzRkU1cyVURXNlh6NmhsZUcrMDBJY244Qktka29CdWdoNUlp?=
 =?utf-8?B?aS92M2puNWsvN3VSUWV2R1ErY29RcWl2YWRHc0x4OGNMYXNRRWtQVDJCQjV3?=
 =?utf-8?B?WFdVb3NsamhQTzd1cWswVyt0dURCdFNjMHZtY0FjK0NlckJUMFFrTXVoNDNV?=
 =?utf-8?B?RG5JNzBFanM5TFN5T2VyWmpxa0MyMFlLUEhla2VQWjlNbThCM0dlNVZodnU0?=
 =?utf-8?B?ZzdGTG1YNkUyc20vUlVidTk3UXEzemlFbEtxVHpLWnhVdTRwVDQ0ZTlPSHBk?=
 =?utf-8?B?czIvT29qQmJoTXd4RFFIUktHNVowenZ4Q2hOcVhNeEoxMFFldVd0dzlqNGNa?=
 =?utf-8?B?SEJjN0RMcFFMd1dSK0J6NmdLKzY0Y0E2TkFhWFBWMEVRanFURG1vNlFzL0FP?=
 =?utf-8?B?REsyUkU2eW9aYnM0Z3RrcXA0bXp0NVI4TGI4V1I0T050L1Q3YVdQUG0zVWl0?=
 =?utf-8?B?MFpDdHVhZXpOdFNOY3NPQ01RODVYMzF1MjFzMzMvR0V1QXBFU3hWcUQ0SVpx?=
 =?utf-8?B?d3NkTWR2VDhrcE1qL05tb2pDMTdrNHErYnpxRnFmRS9IV2tTUWh5OEptK05h?=
 =?utf-8?B?OE1FK3ZGc2swTUtqWHRiZVZUZENWNVVxbHROdStZNnl3bTNFd2J2ejdmdHlS?=
 =?utf-8?B?T05kRHMyMGl1Yk5xRUYzT0h4ZTJFZzdaUHJkT3F5MFBkYVZ4a0xubW0wd1R4?=
 =?utf-8?B?NXVJUFcvQ25hajVuOHZMMkY5dHdmbEFwcVJmZ2N6VmFSTXRsc05HUm5wSkJx?=
 =?utf-8?B?YjZjSXhHM01oZm4wQ0wyWXJBKzhWRzd6NmZpakdkcGtDakxqUFEvRUNvUkJH?=
 =?utf-8?B?Y0xwdmtkbUpZTlcrSXFRaldNdHlHYmtweFZ3RTlRZ0FqUlBZTURCcDlDT01K?=
 =?utf-8?B?VWxDTHorSUNUMkdSbmpqTzdTdFpYWGN0dWQxU2tTMlhXSko3VlNBOUkrYmtO?=
 =?utf-8?B?Z3ZFd1NPOGhnWkhjRm92cFdlejFvVkxlTUZRWUpSU0o5UUw2bnA3Z2pDSHhQ?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16447348-baeb-44fd-6a9f-08dc5486f115
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 09:09:32.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cx7WmWONx+gSH9kcyCrZjCxTurLrMlMUO3TlQzX5qRbmocI/8VujbDnpPqg5H1ePvRLnJ4mibYaH9xiAMbo5+URs/59rY0/tunKYzBHeZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6453
X-OriginatorOrg: intel.com

From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 03 Apr 2024 13:20:32 -0700

> Toke Høiland-Jørgensen wrote:
>> To make the system page pool usable as a source for allocating XDP
>> frames, we need to register it with xdp_reg_mem_model(), so that page
>> return works correctly. This is done in preparation for using the system
>> page pool for the XDP live frame mode in BPF_TEST_RUN; for the same
>> reason, make the per-cpu variable non-static so we can access it from
>> the test_run code as well.
>>
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>  include/linux/netdevice.h |  1 +
>>  net/core/dev.c            | 13 ++++++++++++-
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index c541550b0e6e..e1dfdf0c4075 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -3345,6 +3345,7 @@ static inline void input_queue_tail_incr_save(struct softnet_data *sd,
>>  }
>>  
>>  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
>> +DECLARE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
>>  
>>  static inline int dev_recursion_level(void)
>>  {
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index d8dd293a7a27..cdb916a647e7 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -428,7 +428,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>>   * PP consumers must pay attention to run APIs in the appropriate context
>>   * (e.g. NAPI context).
>>   */
>> -static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
>> +DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
>>  
>>  #ifdef CONFIG_LOCKDEP
>>  /*
>> @@ -11739,12 +11739,20 @@ static int net_page_pool_create(int cpuid)
>>  		.pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
>>  		.nid = NUMA_NO_NODE,
>>  	};
>> +	struct xdp_mem_info info;
>>  	struct page_pool *pp_ptr;
>> +	int err;
>>  
>>  	pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
>>  	if (IS_ERR(pp_ptr))
>>  		return -ENOMEM;
>>  
>> +	err = xdp_reg_mem_model(&info, MEM_TYPE_PAGE_POOL, pp_ptr);
>> +	if (err) {
>> +		page_pool_destroy(pp_ptr);
>> +		return err;
>> +	}
>> +
>>  	per_cpu(system_page_pool, cpuid) = pp_ptr;
>>  #endif
>>  	return 0;
>> @@ -11834,12 +11842,15 @@ static int __init net_dev_init(void)
>>  out:
>>  	if (rc < 0) {
>>  		for_each_possible_cpu(i) {
>> +			struct xdp_mem_info mem = { .type = MEM_TYPE_PAGE_POOL };
>>  			struct page_pool *pp_ptr;
>>  
>>  			pp_ptr = per_cpu(system_page_pool, i);
>>  			if (!pp_ptr)
>>  				continue;
>>  
>> +			mem.id = pp_ptr->xdp_mem_id;
>> +			xdp_unreg_mem_model(&mem);
> 
> Take it or leave it, a net_page_pool_destroy(int cpuid) would be
> symmetric here.
> 
>>  			page_pool_destroy(pp_ptr);

I believe it's better to remove this page_pool_destroy() and let
xdp_unreg_mem_model() destroy it.

>>  			per_cpu(system_page_pool, i) = NULL;
>>  		}
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Thanks,
Olek

