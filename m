Return-Path: <netdev+bounces-306696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AEbQH5hmUWolEAMAu9opvQ
	(envelope-from <netdev+bounces-306696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:39:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 279EB73F0CA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:39:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Yni7Fxji;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306696-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306696-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC6E300D164
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F543B27DB;
	Fri, 10 Jul 2026 21:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26372393DDB
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 21:37:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719432; cv=fail; b=frjfD1Dk9NyzdEZJVa0mKCiklYBI9RaIahQyJimJefmqL2nLJyFj7OD0s9oa3ww5zdfjBNWHw94nvr3Sn8iu406y9lRNxL06FR2+dBfwdmFI4tnxKG6qkw6NxY9rRtXZbZvN6j8IOrk2unAphRDIME5pzsfcZHYaUSeKpmMKNdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719432; c=relaxed/simple;
	bh=oin55BJBwAdVmMIWpZjxTPmPKp3NJTKiIBAx1fAa2hE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jxfMir3PM9lw4Wlf98bZY2rb8DsKqurrCHJhyD5F7xPlf49Y3U+V5A5KsArPZraY0nYf1WRpxGLJ/TVO2l6fKCWtEFs+M+HBKprvDDav7K2FtwEqHAORE7mttQ9V3IxT5MFz9jjgxlmcmZaaIvmiZXUtpNJpx4KQdLfwMuhyIGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yni7Fxji; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783719431; x=1815255431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oin55BJBwAdVmMIWpZjxTPmPKp3NJTKiIBAx1fAa2hE=;
  b=Yni7Fxji9PmSDTrAFrmJSRRn8G7Z9R/qZA05y0Ro62gcRB53GQcjfgFq
   VFcFAc7MbXMNeL38n0hc1nqTDjX4NmZUlqA/NAV6G0AhA4E+UJQLPm21z
   /vPPm7yUUnEeXmSfqGm6zN5v7tpDTyIpQY/+Pv/asJFbtkfRzO7Wy49q5
   GCWyTiKJPJZDQlonAr0Rx5M+eLS/rvY4VWDzTqZtb7xfZKLh3Sa2pmsH7
   2sXCURyBieujAeZQmJ0X3QS3zvnc66PM1gTMmpeTOHobHExn/b/bJVReR
   X8wEkv1XfA7UvBRRT3iHLDrvDdZXBB3Ip3tr22o134KxFwLlWw18x59kl
   w==;
X-CSE-ConnectionGUID: fGshXa+8QzOim56RwHViBA==
X-CSE-MsgGUID: uP0/YGlwTZahuh0mVp60mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88333107"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88333107"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:37:10 -0700
X-CSE-ConnectionGUID: FrMf8p2IShKELZ/bMEK0Jg==
X-CSE-MsgGUID: 2rxls+A8SoSZaGHN1nB0sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259881664"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:37:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 14:37:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 14:37:09 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 14:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCCktHOmyQJSRu1xZQrKzQHcPN/SgGXC8M96XFvBAnEhxxoJdneriyI5YXIr3qAVjuZGLKTu/es1TAQlUUcVxXqmNipgnJo0QdFu9I5jYcR81RqXiaN/IxLG5bnoiPZ8h0X6DUWIBGg5eHrzd0uEiTi0iO1BGYlp7x+B/aytedqVZjDdoY/At5SK+PM4CqbS3JyxzXOC4o7Ts65bDzUj9stui4IR5NVmSi4b2prt4Rkh9bpc0UsOpcUXwoK7ETJx5Pzqng8PqTEWxHx0cwakFVEoBUUhJ1+CukLiYYR4IpJLzEFmq2W5+tvdmAMJkIaTEcq0P2NZm+3x2HyqlGkZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=512HDbIRp90+yGrgHlgttBwYH99JRZvudCLFwejItaU=;
 b=CHn21IBQ/C026cDXjiAoSBCeb3YIyLSYeMc6UK8QrPQfj6s2NUBbZ7ScwH7dmanaD6FM9FG/8M21BKLolPIxDjFjLA5KbGm6PJIvbRErlZnitYJ/OwwtV/KDcWly8lx1h5Y0V4iOv0+ZJQAMOY9t30xWK+tiCloNiGS0r3GSLcTNW2KkyF+DV4/oASXipVNddJ7bpsQCn99vFv5hfXIiQMomMzz19CsEiVhkxj+tWgrCQu6gsvTqX/OAFrT9q7kkXvdqku81cArqVtCCv8ZgE9NtYhzeqKaUleWTYKoqaWYw2go9C3pJYrETpi7L8gXvJsyNTvg4wqZCn3HjmURq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 21:37:05 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%3]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 21:37:05 +0000
Message-ID: <4e86865a-a152-46ef-9f0b-74dd42b7cf66@intel.com>
Date: Fri, 10 Jul 2026 14:37:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] idpf: support pacing offload
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew@lunn.ch>, Willem de Bruijn
	<willemb@google.com>, Joshua A Hay <joshua.a.hay@intel.com>
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
 <20260706133433.3142805-4-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260706133433.3142805-4-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e77e83-32d1-491e-11be-08dedecb62fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 4jehKbDgVXOGOB/RjJkmt4y3VqrUIBFLQWvvwfKeG2c3eVOfH2AyAnRv4xmSvSq3I6swRLiO0iLKZ8VVs7Oqw1K3azdWd6mpHQs1sRvzQEge8b7hVrVLHnwxyNNhWDYX4Mib0oveBrkSl2J401BEOoHlZXHJnJ1M59SJvKdA6JVXhcEJRfiUixbZFe458SIo4gxMV3c5nXXXuuQqfq2iEqjr0EvISUj1u9BaYD1CgaXn5iqTDefbLN7j+JZQ6jOtXDkvr9m/HGHHw/sRSPtj6h7sI2gHeq/60hWv/yjT0Y6j2xjmgzpvWfZ+T2Y+0PFlBEFyNI9Y9WQsQ5yBXOCQ0Of20vTfHBIdIVGaqcG5m0BVtvyp1sdKiBv4aSklEnrxAf1AGKoiH99q2uZ63g6+b38qLr2neRcidWBPiHtAqHjmoZjAd58fNyv4vb+lcpeiqTLiD6wy9D2y/i0ySLkdhIgc/TngewdaQH/scSm4RA01eLnLj/okrx6heQ9K/D+n1sF51ufI/eyriy+WtwbwJo0OkLvyLKPfIpsWCCj2wATmNf6B8XieSg8K2NQNyQV0DAZG6A2ExR+aRE+QD4IytTfdKpZ2Vt1Q/8t8PMXBA+x5DiFA4i9/bBeNw7jIVc8aF1tIdDW6/F8YATL0tXDp5V2ROZRLi2Tj2hq2I1cnKV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStyUjZCQjJZTFNuWEhSQXhOR3pYcE1kQ2RpUnZGN0xrOGkvRHgzdGFNOXoy?=
 =?utf-8?B?R3E0SlQxbGNhbm0yK0RxNUFKWlpZSFlaTUpGUEk3ekErbzNHcUdCNmRsM2Z2?=
 =?utf-8?B?OGZ5c2RTMjhWZFlERU5RUzJqVFMrMG5QdHZTQUVGT25DM3A2RXlhaVlyOVZ6?=
 =?utf-8?B?VytWSkhYZ2ZQdjdxR3ZNMDMxRjlwVzdtMit3Q0UvWUJMK3BDRzFSQm9BQ0dT?=
 =?utf-8?B?bk1FLzdBbktFSFJoM3NDSjg4RllPNGpmWmZTWkFFUUpTOGVuQVBKQWNDbG9i?=
 =?utf-8?B?a1RDQmVpMm82QjBKbnZ4MjVOVzMwbVNzVGJoTEV3VnhidVZZSTROMjQxNmpP?=
 =?utf-8?B?VWFZVzd3MjJjcmJwOHFXZVFNZGVLa1k2ZGQ5TUltcGxtazBmMFh3dzYrRFdH?=
 =?utf-8?B?TEdaSElKYWtST3BvS3k2TEhYMEt4cnZnTzEwQUtyU1Z2WW95aDBNdVI3Nitw?=
 =?utf-8?B?SHo4UFNLUDhsR2UwcWliaUZ3L1p3cEllUmtCOEJpZ1BGOGl3R2xWaUp1bWlv?=
 =?utf-8?B?VVYyTUNiYWdYeW5lSEpoQjI1S0o1MXNFMktYOUJKaDBZelQvR1duTmZ1TlQw?=
 =?utf-8?B?dXM0ZzNkeVhZM2sxd3NuQjUzcFdNMDBUVjU3azNrYlNTOHgrOStPL3Y2dHpk?=
 =?utf-8?B?UnN2ZWZvQ05QdmZKZ0c1R2FOZDZRd1RmdUlzV1ArMmh6eU1DWjYzcFRqbjFS?=
 =?utf-8?B?Q1VRbkM2QThFKzhTQnFwc2ZkWmp3Njd1T1hKaXA1VUdtTVFzSnVLU2JFOEJl?=
 =?utf-8?B?VmlhWFdTQmpoWDBvUWp3SXlBNFgyUjMyalpWVGtBU1Q3dEJqM0RmM2tKZnkv?=
 =?utf-8?B?aXdxTEFMOC85aTNHcDJEZTZISmJFYjRiMk5kTTI2MWY1dHJlYVBZWG1uTjNQ?=
 =?utf-8?B?WUpXOXNqZjk4bzUvaHlXakk2bi8rbERaVEIzZ1RDYVdvWjVpdkYxeTd6emVQ?=
 =?utf-8?B?aW5ISlhrVGVEbTdxTEd0ZmdTYnRrUUgrWmRCbit6cE9OSXJMSFNteHErcFdD?=
 =?utf-8?B?SGo2OXJxR28ybmVvcWIzTS96QmlRV2pyYjRMSVNCSlpFTDJySnZod1Y2c0ds?=
 =?utf-8?B?UGkwblNnQUhSbDZIeTJUWlZPdHZUa2hCQytSMEFkdlZZSmlRVnNmc201Tk9x?=
 =?utf-8?B?YU16V3MvSXJYQmZHV2dmakRmMkQ5NkFsVmVndkNvRHI4WS8xUnUvQ1lZOEJk?=
 =?utf-8?B?QlFFNXlEdDJ4SzRvQ2JHeGFlV1AyeHVHaUp5UGsyOVMzTXh3STEyWmxET2Fu?=
 =?utf-8?B?YitFRGZiTFpRSU1NTjJIMlU1S2w3M1FoRzIvS0NsQi9RS2tHS3NET0t2Z2N1?=
 =?utf-8?B?cXArOWl1N05sSUcvRDJiZGNKY1orMCt3cmt2ODBQakhGYVEwaUZzVG5nMlZx?=
 =?utf-8?B?bTdGY2MrYUVpbzJTKzlISkFmcGpoRXdGUjYxRkRBeWZZUGgxMm9LMzJrSjlw?=
 =?utf-8?B?dFMvZWtvWUN3THNGYnlIbmlxYnp1N1orZmplNGJyL291ZENmRGUyVjFCd0Jw?=
 =?utf-8?B?QXhHTlhJdUJ3cHNqQzlCeW00a2sxK1B3T3E5UnZCNXc3U3RwUEFuZlNaMW52?=
 =?utf-8?B?RVhNK1NMcEJrT3hoMVpoY3pyRXVxQ3k2OVFwbEFKYWpVNjVJajlKWGhoS2c4?=
 =?utf-8?B?cHJnUjBiYmNPaWhDeHA1ajJVRVE4RTkzVXpVMHRJMm1Jc2lybngxbzFtRVg5?=
 =?utf-8?B?cDN3K2s5dFQ3bG43cGVWV1I2cm5GR2Y5V2kxajh2NkVvWXNJMWFTeStqbE80?=
 =?utf-8?B?TW9VZEQza1JqblhIWGhZTU91dmp2QjdZZks4MitCNzRQMW9acjVDbC9nbERB?=
 =?utf-8?B?UVQrbXdzK003VTVwNUtKVkRmOUt3dkRmMFFKOVhjL09OeW1BUUErM2JuSWo1?=
 =?utf-8?B?c0Z1bVpOZDJybWp4TmNDcWR6S1B6TERrWmI3dlp5ZEhOVzUxSGxnMjF2Nk1V?=
 =?utf-8?B?b1Znbm5MZnFtZndPVjNYMzE2SXBoeEcxVEl5SHpieXJJRWZ5dEFaazdVazcz?=
 =?utf-8?B?MmFsWG10S0QxZDJJZHNjek9BeVFsN0djNUVTS3U2ZDhiRmxnSWJUaC9rQ1F2?=
 =?utf-8?B?dkNVSHNOMGg3YTNwK0xWOFpQcFRJZ2xpZEw0TzNpeTk4VEdhZVBoeGxnZkN4?=
 =?utf-8?B?YXhBSWl0NkJLR3Y0S3JsYXFQT2V0YzNmbm9EdUhYS3NYY1hoUDVrR2tEZHhk?=
 =?utf-8?B?akRhQWFHVU5ndWtDODNoaDc1WnlzK05tV01VeDJYQWtzYnVrbW5mekpORE5W?=
 =?utf-8?B?M05HRXNNa1Awa2ZFOHpDQWZwdnFiTkVPTUw3bkJoQXdweG9sWmxzR2oydTAy?=
 =?utf-8?B?UjF5Z2NlYVY0YkwxWHQ5U3FQSlpOUnlxRGhZZXFkTFFLTWVDU3VxWjROd0xw?=
 =?utf-8?Q?Qz7EhzC1RmsFLu70=3D?=
X-Exchange-RoutingPolicyChecked: KI9R0BIxCwi72yIktRE1lyWw5CD17GwUcPaIITaMnSK1X/Yu81e7hDtMVWuxciZR9Azh4UC0eJ+/Rtde6idhqgdf2KoHgyEMckJ+TB9f1g9gALTL1MVmH+Z0z0LElem0adpD7fhawfFQY8mbHx+dB/xV1UFNoYYLeU/HM1W7wSMMRnzCeGc2f7t9bkXO5r/xw8+i2rKto3yhMIrPrkGdryuHfHonK5tqS31jIr1tWb2ykW165lXn9PHid/ydlFmzhf257V3fN2RXEUxA14hnJzuFASl9DdK/d/s8aIpY3zA4k8wXp6RsWXG4yVkV5hVrfUmv+a4YH6qZSKsUBhWtYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e77e83-32d1-491e-11be-08dedecb62fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 21:37:05.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDnk8Xt1iqcXmo2xXKVtldJgKizJVN05AS0au44SGWnQNw8CyzmKOTfg/R5QZBDHZaORkxUiUlcgJvz+QjUt70Ee1E8RqSYeHY0riOUXzlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306696-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,m:joshua.a.hay@intel.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 279EB73F0CA



On 7/6/2026 6:34 AM, Willem de Bruijn wrote:

...
> +static void idpf_tx_splitq_set_txtime(const struct idpf_tx_queue *tx_q,
> +				      const struct sk_buff *skb,
> +				      struct idpf_tx_splitq_params *tx_params)
> +{
> +	const int ts_gran_pow2 = 9;
> +	u64 ts, now;
> +
> +	/* Skip if netpoll: not needed and not safe to call ktime helpers */
> +	if (netpoll_tx_running(skb->dev))
> +		return;
> +
> +	switch (skb->tstamp_type) {
> +	case SKB_CLOCK_REALTIME:
> +		ts = ktime_to_ns(ktime_add(skb->tstamp,
> +					   ktime_mono_to_any(0, TK_OFFS_TAI) -
> +					   ktime_mono_to_any(0, TK_OFFS_REAL)));
> +		break;
> +	case SKB_CLOCK_MONOTONIC:
> +		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
> +		break;
> +	case SKB_CLOCK_TAI:
> +		ts = ktime_to_ns(skb->tstamp);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
> +	now = ktime_get_clocktai_ns();
> +	if (ts < now)
> +		return;
> +
> +	/* beyond offload horizon? set overflow bit only */
> +	if (ts > now + ((u64)skb->dev->pacing_offload_horizon * NSEC_PER_USEC)) {
> +		tx_params->offload.desc_ts[2] = 1 << 7;
> +		return;
> +	}
> +
> +	ts >>= ts_gran_pow2;
> +
> +	tx_params->offload.desc_ts[0] = ts & 0xff;
> +	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
> +	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
> +
> +	/* 0 is valid 24b timestamp, but also means field unset.
> +	 * Add 512 ns (ts_gran_pow2) to avoid this case
> +	 */
> +	if ((ts & 0x7fffff) == 0)
> +		tx_params->offload.desc_ts[0] = 1;
> +}

Slight nit but seems like this check can be moved before the assignments 
(and then return) as we don't need to assign the other 2 bytes in this 
situation?

Thanks,
Tony


