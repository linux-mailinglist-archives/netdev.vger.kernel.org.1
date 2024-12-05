Return-Path: <netdev+bounces-149179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9019E4B12
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B4C1881231
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 00:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB836C;
	Thu,  5 Dec 2024 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EL9N+BVg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9CF4E2
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733358236; cv=fail; b=VCHScKfe4BoK00vAQowxxnfrLnZqWZU9Ib1fo4uZuY3fkDNeoNFTASE0xqT6grF/of7YEmfmZ+wrtbvbX+0wfKGUTQ8wz9O17RTnk2xlyVzvBYtIoIJzvHulbR4MrxQkA1k09o8uCk2Ec6+Joa03aIkogl2fJb1wXNXprEMRMG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733358236; c=relaxed/simple;
	bh=HaSStpaTuwGZo4se3FxKI9Cfq+2Yd7D6YRU2KY4qTaY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3zTgpzKDENhprzB0mojqHjmwuosCOsYubH3hOtPSH0lvBxOR9sj7tafXN3MkSQ8/6DPWz/G4vYqaB1/1uNoDG+TKIxSmZjPANzZUX7jKrAbM6KSuvReZ4blJ+TXDQPFzSzZFy9PNUmpwY1FKjJGu0I5IfbsVr6ATV3WMvcF750=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EL9N+BVg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733358234; x=1764894234;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HaSStpaTuwGZo4se3FxKI9Cfq+2Yd7D6YRU2KY4qTaY=;
  b=EL9N+BVgryZTonLAddGoOwkMqCFLbapuz2DmgqdgbvSMbpqlhQ9gTkEk
   l2zB2aTfN8nTgP2IKbPYkIPk5hzOdyOHXMrOKkn2da332tFBiiFsgyKWE
   mGFd9TsOqXUv7rGe8hjnVum08a0+MlcJMn8+xfIW2oa+ku/zORHLzZvcp
   igtrUJpT22wXmQWBsIkgR2NIhjuh6+Q1uB1HDl1qOO4c8tr6PqiDyacvu
   YIIkAGFE5IVdbfmauUMM+9dD1Gbh+gMucbZxBm0dkgFp9J2+BjQrcQ+lJ
   Th7aHFyJx8jB1T1VZcfRTRyJnPH8dQRKKT9ORC/UyNsoRIIfFtZK/kH5S
   w==;
X-CSE-ConnectionGUID: ejPnVUQ/QzeWJA5JyPW8vA==
X-CSE-MsgGUID: fIllKzxJQeO9FZo22OciPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="51189792"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="51189792"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 16:23:54 -0800
X-CSE-ConnectionGUID: vpALhnnwRv6tlbgGlG1Y+Q==
X-CSE-MsgGUID: Stv3mBc9S9GofRjcq7kHGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93821434"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 16:23:54 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 16:23:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 16:23:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 16:23:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onKI0hW9u6eDSNatr3K0UdrI5rvjJcl5cMD0pmY8qS6LvwLUDv509XzuMs+aYTYaAv9vzOwGAYIN5CSohzuxmSkHydb4Dr3OAgalGj3Vxm07D94+JHBLNpsOJidBuEVXlJ8Buy1ADsHhgyXv/9r9n7BR1ORTJwj3WBpXMIz4mxOc3u/m/8HhwErex9EFRXv1NZbzERffd74pCYao21xJZhXKZdKDtXLq84TH+mwyt2mB3fHcnX7uXLc72XJIkAONBx8ChXjlJdlDkNKT/VGtxVHpY/NVxHENd1QK24qm9O8D11XitelQf2JbFqVjOlmX1yMZFUKF0vfMo234Z7oQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fcq1c9se/A2C3qADtCHzKL+0qhRlOyEzU4UgunOoqs=;
 b=T7CvC77UqIhnY/fRQ7hzQBMMi3uFICxldQg7txei8Ax1nZR4pYJbsezWtspzqOPsgVK+WiErBH076LdDUHwukZS6Mkd8ljCLNj9KjGHKAsvZA6hOb1TgqWqJtc3IIDaMdVDz4ij1I/rNPmh8drM0Xn4RS3lvJd//1Wf7v7MMnQzr3uLgrGz5bXKVlPxBpeGgib785qh3IB1asQIU6aUo6CkZrooQX3tCmHlxCKF+S+qSO5ZKGacy0C9CY0BpPZyAdNU+UUebHp/CdAyWAOsMM3yuqvkbcH27P4RaHxSSBmcqcMbImEEq6Yxv7hT/IS2GzdbuHmDyBl4nZTPusRdV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 5 Dec
 2024 00:23:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:23:49 +0000
Message-ID: <843bdcd0-2284-43c0-81a1-feb4d1f910ea@intel.com>
Date: Wed, 4 Dec 2024 16:23:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
 <20241204171215.hb5v74kebekwhca4@skbuf>
 <998519c0-a03f-4190-a090-f8ada78ea376@intel.com>
 <20241204235209.v4xjweehhp5knbew@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241204235209.v4xjweehhp5knbew@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 1078958e-025d-4595-0282-08dd14c316fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXdESWpCZFE1Y1NIMXhVZFNQbnJzQzJRTzNadHhWTGpGaTRpTEhmSitPQVRN?=
 =?utf-8?B?S3g0VDM3elpQeEl3RTM3dWlvU05UY00zemQxZFVXZVR1WEFVaVVBb0tHaW9X?=
 =?utf-8?B?OXdBTEtwMHlqNVlsZjQwQ3hYOEtXc1ROOUR5T0JiK2E1VGl6NGNiMTJaUHp4?=
 =?utf-8?B?blplVEtnVWM5dTVXMmhsQUxPQWMrREI5MUt6L0hHZmRNdWpiQkRKQWUrZmVh?=
 =?utf-8?B?OG1BZk1yTHlMM2JhY2k2MlBaOVJEc2NCN3VKTXdCTy9NT1V0M0Zrc3JuVHNj?=
 =?utf-8?B?Y05kc0cvY2RhTzJTN041SFFNTHVVWVJ6SjdZejA3TzRwUUZRc2RibE9jZXlu?=
 =?utf-8?B?c3QyeWVvNXI5NmhZM3pIcFVEa2E0Y1hIS0Nyd0U2RjVXMFJHTGdIMWJ3QS9i?=
 =?utf-8?B?b2lxRGI3SWxPOVdwRWR6Y2dIYVpXUVFLOW9GWEYwWWs5ZnI4TWltUkhBQ29Z?=
 =?utf-8?B?T0o5SmlYUHpEdEJ4S1kvZ25kYUZDaVUwakNYVUFJeWw0S29hZ3RUSUdPeUJo?=
 =?utf-8?B?YUtqZkpYUVh0eEpiZU9HRkdCbnhnNTRieXRxblJkd0xZWWQ4NWVla25jVlJ6?=
 =?utf-8?B?MitMbXBobEJITEtpWXBXazAxRzJCWUw1c1B6dDI4RWZRQ3NCYnY3NzR0SU41?=
 =?utf-8?B?L2hBQjNVZUF4Tm1qeEx3N2J1V3JQQmRRNlFSdHVScEFabGVLTnpQaUZ2dEdo?=
 =?utf-8?B?U3k5MnMxQTV2RmJuYmNoNjZja2lmUWRQb1hGTGh3dEg3dTd5akVmd25VbFo2?=
 =?utf-8?B?YUkrSDJXR1BIUXF2T1RQY3BMTVNaQlZaQS9yQlYxYTc3bnFuR3NidVpSejVU?=
 =?utf-8?B?SzI5bXg5SU5mNWljZnpDWDNQZzdXWlZvVHYwaUo1RGNyRmZKK1ZubDJWWHZw?=
 =?utf-8?B?TkxEcUFiM3NmTFN6SWtKNk5qMnFwMklMdDdBRmFVbmp2Z0VEd2VjUG1uc3l6?=
 =?utf-8?B?Q1B3U0k4V1RZd3VMa1lkYWpDKzVTV1RJQTRaM2dlVVVpZzkxYXh3VlhaZ0dN?=
 =?utf-8?B?aHJYbUFXYUxOa1hzTFNDWlhndUEwTmZrQjh2bkM4U3FlT3licGVLby93TmtB?=
 =?utf-8?B?ZktGV1B6ZHV3UG1lTjQvZmtOaXpsVzdMM1NodmdFMTBQNnRla3FwN0hzRmpP?=
 =?utf-8?B?cHQxeGZpelh2aFlQK3Q0Mnk2eko4VnBybWNlYjhvWDZtWmJVQlJ2SHl0Mmh4?=
 =?utf-8?B?M3VuSEE3YStIRnNlMWpTeVVidjZpVzFmNzhISWozQXM2N2dhbnlXek5pSER2?=
 =?utf-8?B?U2FCY2E3aUs3NTdXcHJPUnlXdHo4U1FkcFhoNU1TVFVlNm1IRnVoN0FOKzVD?=
 =?utf-8?B?TXRtcVNTQmovSFdTSmNlRGRVbE02RlBIN3QxUjBnR3NhbEV4cy8rK3gzeCtZ?=
 =?utf-8?B?ZXRNdlhBNnNBZzRGdUtENGhOM1AxMUx5eGZCN1lmOXY3UU5QZSt5THZSNGpB?=
 =?utf-8?B?VzJUWE1FeXp3TVZIZ2cySUlEbXFheU5KcVdDcFk4S0RZVWVHSU5rUCtLQWFr?=
 =?utf-8?B?WFc4S3VtNlZvb1hXckFMOEpPTEVIWlgvZWZqZkVNSmsrempBOGVJemZ1WlVE?=
 =?utf-8?B?S3M3Yms1STJHS0d5eHZQdlpCRnAxRDBlRm5vV2tFZUpkOUNYMEdxK1VtN3hm?=
 =?utf-8?B?bFMvVnl2SlE3L0VLNmxtOEozN00rKzcxaXg4am5PN3lNYVFFNm5yQ3NvY1RE?=
 =?utf-8?B?QWRmOXBuRnpBb2FPdFUwaTVkazN1MGFQeWVxdE4yZlFuK0t4d1FPTk9IT2g0?=
 =?utf-8?B?dWI3bGVFaWUvQ2hKWTF6SFJPWGsxZGpwOFFRU2NpUC9PWkgwUlFKMmlOVWdZ?=
 =?utf-8?B?blhrMUNzVEtFUEFMdDJQUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZ3YjNBU2RKQkV4Qkk5T1JMSW5FaGdsTm9mcE43ODhXTlh0OXN0MitkUVJB?=
 =?utf-8?B?RXBLS1hud0hJNVlBa3c1T0o2ZGI4cTdpYW1SVzBqTmhpNmdJYnN2dXZTRXJO?=
 =?utf-8?B?TnU1QnY0eWhYc3djWW1weEkwMHhPcGZRRkxndkNuSW5UOEhBc1B0Z1ExQ2hC?=
 =?utf-8?B?TEdhdHc3d1JxakdiRFdlMU1JalhGTXZiV1RmRUd1enUyZVhodUpVT2lOT2Nm?=
 =?utf-8?B?T1UyMmtDQ0NTWEJGVUJEempTV08wekQwOFVuWWxFbUdQMmtEV1pHNFkrRVB2?=
 =?utf-8?B?Y1VGYTFCMzBiSjY0ejE3V3NYOVpYOW1BUXhNRXlVeTVUQy9VWkZOYkt1U0NL?=
 =?utf-8?B?Y3BFSDFGYzFscFgrUUVsdUlUZTY1ZGMzY1FUQThxemUwdHVjbXUva213Nk5M?=
 =?utf-8?B?U1g1VDhvUzR6bGd4MVI3UDlwN0ROTXRGZlQ1OXQ2N3g2aUMvTXdGbXFrYzZk?=
 =?utf-8?B?Z0lPYklHZlpRSVJaVXJ5cTdEdmF3NllORS9rRk5DUE5EWCs5U2pDUFVtbjRW?=
 =?utf-8?B?NVJlbTJYSGdrRW5FVXZ4V0xMMzJjN2owYmsxWUJaM09pSytzbFZYWHVDY0lp?=
 =?utf-8?B?RXhEeVJBTFc0ZjRSSFZjS3pMdkVDSkhzUWZZczBJc1FhK0pIby9Qd1pSZDZp?=
 =?utf-8?B?RkVBYVZ2QWV4VUJQcVVwaTRoSjhGWWZRbkRqeWpncDNnU2xINzBRNFlHODZk?=
 =?utf-8?B?UTk5VnpReTBrNHpiK2JnRTZiaWppMklFa2pveEFlcGpCS3dxc2FJRUFUUEF2?=
 =?utf-8?B?NVVpblIwcnBvVXlkdWw4SGkyd2FqN2tEaHJjWml6NmJiajJHbm5Wd2F5RnVN?=
 =?utf-8?B?N0U0ZnRCdldqbFRkS2dPYTdLZmJnODJYdnJCNmlYdUJSSU9yV2VqZmJFRDNh?=
 =?utf-8?B?c2ZBU29IQW5KSzROUytUTjl2VXlldHk4ZnNrS3ZCREE5UkJQZzhGWjFQZGlu?=
 =?utf-8?B?YU1ncEhidTVCL3c4Y1pEOGllMUNiZG1jNWVhZzlMbUNhbzk5b25HdHExUW1i?=
 =?utf-8?B?NExBR095cm83T3FXVkxzY21NNmRxY1BoSFF5K2dBRlBwT3RrUTVjclNuTGRI?=
 =?utf-8?B?WjJMekx4UG14VDNRK2c2KzZyY09UbGlQRVFCV1pqbEs5VnIrbjRHRUFEL3lp?=
 =?utf-8?B?UlllNUZhT0NRMG1ITjJVNTFUb3ZlSGo3MlUyZzJUOCszdVNDRVNsdnJkZito?=
 =?utf-8?B?NkdaRSthck9GTVptYnhNTEhvSDkvQ2c5NmtKaS9sTkV2ckNsNlVTSW80Uzd5?=
 =?utf-8?B?S0pMazU3UVJzRHRzVE5BWXhxWEdTQk1rYXRORmM2OHhwL3AvWVlXRTRFWnVR?=
 =?utf-8?B?T2FnN2w1b05OWnhMaHdJaEpkUStWbldKYlFZUEE5VFBtSlBRZXNLR0VvSy9P?=
 =?utf-8?B?ZTdGUy85djk2Nko0L1EycFpQT0FyQTM4MExkbDI1U0ZZeEJaQzI4VEc1aE5J?=
 =?utf-8?B?Tnpka1R2N2MveU5xRFlzWUhrRnlGcHdaaEh0M2lWRExMbXlVS2daMGJwRmVN?=
 =?utf-8?B?eko3USs4SzhMQXVEZTQrd2VXUVkrYjJUbjBITm03bFJMT1JSa2JLcW5yd2hT?=
 =?utf-8?B?c05iS2RzMjlDdDJzenpHcitJVjREM3k2MlhnRi8yMWg3clBMbjcxNE5nY3Yy?=
 =?utf-8?B?LzZ5ZWVnUkFNbE5SeFc0Qzl0dk0zRURhbSt6d1R0VjhtU0hTUm9LSTdlaGZy?=
 =?utf-8?B?NmppMG1Tc2dKSlNYbjY2OW1Jd2orODdGTUtVNjRJN2NrRDhZTG1Ja3JVUVMw?=
 =?utf-8?B?bFNsaWEyTzNFWGZkMVppTmozbG93N1VrTFo1RzVMOFo3UkZBSkxhUE1nLzVW?=
 =?utf-8?B?Kzl4aTFkOThONW0vZHJxNXdtYUwzT051Q3JiUWlXNy9mSm1UWC9sUWZBbzhR?=
 =?utf-8?B?VnRRRStxdzVydk50dUNZcjV2dXA5Vi9yRUNZeW1SWWM3ZHhja041UzhWS3U4?=
 =?utf-8?B?Nmw0NTNrRmFneEJZazkzV0w0Z3QyYzJsRFdsMjFmTWtmRW5jdHIyMVhPdWk5?=
 =?utf-8?B?RjhKeUpIOFExK1oxM09sRWROSHJ2ZWlpL250aHl3NUdFL29QYXgyZWY2akRs?=
 =?utf-8?B?UUhUKzVFbXlDTER5QWtEUVhzT0dLekNHNTdqc2lQbkRTSit1cGk1azNpYWJH?=
 =?utf-8?B?T20rWXNGK1FLRGl4b2p4WjdJeS9KeVJQZm54SVBZaEpaQ1F6WUNZanJqWmFY?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1078958e-025d-4595-0282-08dd14c316fa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:23:49.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8ujYPW/QET2zSFrrqEWUbIkr1rncWo+AGwYKLRAqC0gIn/cuXT0VC64w8VvJPYgtS17gaevm/eGG1vHqJ1uTCnP72WEbmrR82O0qdC4t7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com



On 12/4/2024 3:52 PM, Vladimir Oltean wrote:
> On Wed, Dec 04, 2024 at 03:24:59PM -0800, Jacob Keller wrote:
>> On 12/4/2024 9:12 AM, Vladimir Oltean wrote:
>> Thus, all the array definitions are off-by-one, leading to the last one
>> being out-of-bounds.
> 
> ah :-/
> 
> I should have paid more attention, sorry.
> 

It happens to the best of us. As they say, in programming there are 3
hard problems: naming things, and off-by-one errors.

>>>  		printf("})\n\n");
>>>  	}
>>>  
>>>
>>> The problem is that, for some reason, it introduces this sparse warning:
>>>
>>> ../lib/packing_test.c:436:9: warning: invalid access past the end of 'test_fields' (24 24)
>>> ../lib/packing_test.c:448:9: warning: invalid access past the end of 'test_fields' (24 24)
>>>
>>> Nobody accesses past element 6 (ARRAY_SIZE) of test_fields[]. I ran the
>>
>> The array size is 6, but we try to access element 6 which is one past
>> the array... good old off-by-one error :)
>>
>> There is one further complication which is that the nested statement
>> expressions ({ ... }) for each CHECK_PACKED_FIELD_N eventually make GCC
>> confused, as it doesn't seem to keep track of the types very well.
> 
> I only tested with clang which didn't complain, sorry.
> 

Yea, I have had mixed luck between compilers. Masahiro had suggested a
for-loop which clang handles just fine, but GCC doesn't bother parsing.
I don't like only having the checks on some compilers.

>> I fixed that by changing the individual CHECK_PACKED_FIELD_N to be
>> non-statement expressions, and then wrapping their calls in the
>> builtin_choose_expr() with ({ ... }), which prevents us from creating
>> too many expression layers for GCC. It actually results in identical
>> code being evaluated as with the old version but now with a constant
>> scaling of the text size: 2 lines per additional check.
> 
> Yeah, I think that was the logical next development step. By doing this now,
> I think you just saved an extra patch iteration, thanks.
> 
>> Of course the complexity scales linearly, but that means our text size
>> no longer scales with O(n*log(n)) but just as O(N).
> 
> Well, technically, the number of lines of code required, in "naive" form,
> for overlap checking of arrays up to length N should be N*(N+1)/2, which
> "grows quicker" than N*log(N).
> 

Right. I was thinking of with this ordered check, you have O(N) scaling
for the number of checks, but that means that we have O(N^2) number of
lines as we scale the number of checks up. Each macro required ~N lines,
but we have N macros, so we get N^2 number of lines.

> But I don't think we can talk about algorithmic complexity here (big O
> notation), which stays the same (linear) in both ways of expressing the
> same thing.
>

Right. The computation stays the same. But now, we only need 4 lines per
check, because each check is built on top of the previous ones recursively.

>> Its fantastic improvement, thanks for the suggestion. I'll have v9 out
>> with these improvements soon.
> 
> And thanks for staying online with this effort for more than an entire
> kernel development cycle! Looking forward to v9.

Yea. This has certainly taken longer than I would have liked, but I'm
happy with the end result. We got something much better, even if it took
fiddling around in the wrong areas for longer than I would have liked. I
think these changes are great for ice, and also make packing much easier
to use for others on the long run. Hopefully we can see more adoption now.

