Return-Path: <netdev+bounces-217097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4784B37597
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C894D1B65E38
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E6D72633;
	Tue, 26 Aug 2025 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUGv8G/t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7827A11E
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251426; cv=fail; b=lwbytUoODbdNlGnsOwyOEphXmctKR+pKOTNm/8RCUQ0oX95O8Vg7A6Zt5PkA9+6DXOnuzsgb4PB6hb7bjPQf1Hag8M6HAnXwWC9/m3SOCz/gvHNB8qXirZg1m3qDj9AcIlX1HpdHpidhEx2numHYgx836ZaqfKe3xMp9r7taoFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251426; c=relaxed/simple;
	bh=EiQbRtUCj35xXDaYpmluGtZD4zVMCMUqZrVrCWBX84c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8zmXY2w9Jp2CPgvC8yW5Bf+hNdhKUHsBWq83ZEfHE7K0OE0b3XXCgtcMl/mlGsBX+pUItK3fgQf/V+dhgRQI5813d+3/VPbuf33etfD3b3B9CcQzUAp1wCqMP/CdwOH5hg9kvO4pKTT9+btGyIwDMJ4uNc4ajNQFKRQOAQOUoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUGv8G/t; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756251425; x=1787787425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=EiQbRtUCj35xXDaYpmluGtZD4zVMCMUqZrVrCWBX84c=;
  b=DUGv8G/tpNLCGCZhVSmyPv8SgPjsObZ8CK1LbjSTH8UtmygqOE+B3lA9
   m+wUdrI0iTiuGEu9dgFQ9SdaOGcyRWy8N0EghUoNag2T9FWqzs4c6kQzM
   0F2TcEu8vRkt/q7vKnyyNkJrdvjAf5/uiVM/sJoYPiWF5rkRzJvK3fOBb
   g+jPtz6iwDA4WXuquXUtTgo8EXqXLOb0z2KwgaxncUO2Yh1gD7eIpMf72
   43UiRfO+P4ijxAYQ3EgVHb0SM29vVLqGMqxfr6U7hbKj6LFEjx/De+NiY
   3K6GEZ1PxtBo+9UOdH8vFCy8BqiXTrLMQrct7JpMWa/h/jtEZ9YvcmUVw
   Q==;
X-CSE-ConnectionGUID: L9GaLyBYSiKnXLElnIJpfw==
X-CSE-MsgGUID: F0PhtzYfRDuTtC93+d/T9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58442696"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="58442696"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:37:04 -0700
X-CSE-ConnectionGUID: AvF4dkszSKypT7NhDJiVsg==
X-CSE-MsgGUID: GB87vqFrS06yypyVIsCwCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="174030019"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:37:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:37:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:37:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.58)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuC8l10NKCbHQyvFO2dtOmOo9SOj5ZntPdU91n6xR0oD5BK0Ez0Ozj6P0Y6indBO53LYJnMZOCP8mngpyg7ApCDnhR9g/faTJbKDBzdDAwD6QVY7lZr6U2LjhbEpirhIOsroFgim2p1ATl0GjUN0/wTjDZkQ2I0UF3ewT14G3co6HBs+5GTYfz1Hg2RUg+43nk3b1PsPmw3ZhyUQk4y91LO15SWUVeto3V0TAzFEqFnKCdMJFCW6LiTfpCxaswMvi/Lv8XcT8kvoWkF8wlrLIk5R2M7r1DfAimnbitpPXpDq62lTJEtNG36LMbQYAEGAwQcpOUclbGK0A8SFLkIBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU3410yHqzS0P8hV84aak1iNjT5ebOKNxCp6wd7JcTw=;
 b=xJnuhPzxrUEXE5nA4eeTXEzBQbIYWpNQcgA8vOcwLH93McYQA7wHlMH1OPzQ8V5eunb/7X8E6xnasuVpq7FhRKGBM00SAc9lWZx1MMxo0ehvTRkrQbpf+v/OaFhX+trfSYuSnTiU33tnzM+y+F3wBavTTG59B09fOTRPwf5FmXHOtJAGwi2lXrF0a1yD44yMPSir2BHiz/nU5EWSUJ5doN3lCdZMBYvuYmJlWrI/j+zMjiWfaW287ZwsGbs6gH9axFYETvsQCnsgqx1o5evrf2mPKhl7KULFsv69xfirWfJB5AS9n8GPkL8VyvKied9si04F92m0z/Z3tKL/Tqc2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 23:36:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:36:51 +0000
Message-ID: <01a53791-031b-441d-a10d-4402e2895547@intel.com>
Date: Tue, 26 Aug 2025 16:36:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/6] eth: fbnic: Add pause stats support
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <mohsin.bashr@gmail.com>,
	<vadim.fedorenko@linux.dev>
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-7-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250825200206.2357713-7-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------ccGkyW40WJdqSxkbnxCbiqnp"
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5257ae-c62b-4ef8-9b9b-08dde4f96eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2JuK2dZWlRhZHM4ekdNSVQvOWtvMWdWbjAveGl1VEQyeGZmMkhZbUhPUit5?=
 =?utf-8?B?K25pVkhYbytrKzhrM2dIcFo3bGdyM2xVeC80NllxZzdUSnlVZHA1ZmF0MTF4?=
 =?utf-8?B?RGdTNXdVL2ZSWGh0MlpDTS8yS3h3dUJDS21yODMyTEsxajRRSjYrRkdBWWdj?=
 =?utf-8?B?QnR4WU40RkVFMzYvR0tPTnd6WjJYR1o3VXRyeGZnK05GK0lyNERtUmprKzZS?=
 =?utf-8?B?S0Z6L3hLbU96cmNkVjJsVUp1WVFJbTdxMGl0bzdpU3FxNXEvTUNuM3o2TWt3?=
 =?utf-8?B?Szd2b2cvUHVWS0NaNGUvY0U4SHgrNGRVYys4YXVWMXRXeU55YnFhdHE4UVNY?=
 =?utf-8?B?RS84K2IzM2tLa2djZFZYWm5qRU93TGpYNWY0UnJab0lCV1N2K2lCZnlvRUYr?=
 =?utf-8?B?QmFEUUJvR28rRnJuQjBjQlF1dTI0QnhzV0F0NGxKa0RRdFd4ZmZFbXdUU0d0?=
 =?utf-8?B?TEgraVlranVpd1hQN2MwM0l2UDJ1Ty9TT0hzT0pocEkwQVFKUzZZcjJVS3hO?=
 =?utf-8?B?RGFwTVoxay9YdDBtSjJqNzNnRElELzhlMmlqOEZhOXpUTTkyRUFUbjl1Yzh5?=
 =?utf-8?B?NGlTeVVwRlkvZVZrRXpjVVZCQnFrVUhCT3h3Wk1UaUMweFZLYkVtczBYREpB?=
 =?utf-8?B?SmNEeFZ5SmZRYlR5YzZuczB4aU80OWVRa1BUeXJkaWxWNjNlZVlUMXAxSUdS?=
 =?utf-8?B?emdrSE9IQ3V2dGxTR3EzTjR6WmMzT2dsV2Z2OWhOMkllMmNUZzBHSGpTSTBD?=
 =?utf-8?B?LzhmUDVDWmpBM04wSVE4MW0xNmxTcUVWQlBVdlZuZWZmRUNVNmdxbHFuVWkx?=
 =?utf-8?B?ZTZ0OUwvS0RubldqWlBuWnFLeE5ONlFlTUZOY09yREJPVm1NOGZyeXdQZVdz?=
 =?utf-8?B?U3B2Yk1yN0Y1SE94Q1VuWmRPWUFFZC9NaDRrakx5dUlOcnZxeUhiRGdvSmFX?=
 =?utf-8?B?OWR5SVV2eWJNUVJ2YzVXdlZQYlRwODVScndJUjFkTVN6U2RlamE4eE0zcXdD?=
 =?utf-8?B?cUZnK1R5TU5ZRHpuZmpXUVJoOU9mU1pZemZZOFk1MFpYTk84SzBRTlUvNWVL?=
 =?utf-8?B?cnVBcElPNElRcElPSC94bEpJS0FBKzdveUNuRG1NemFrR1ZsdHh5N0FEUlZy?=
 =?utf-8?B?U3haeVNURzRqTGFNT25wZm9Dc21IakFZRnRqUmV5RFZ6a1FmRUk2eW5McGR0?=
 =?utf-8?B?RkRVcDd0ZkJVcWNBWmV4aHAwaGd1Yy82NWtKS1VWTm1FMExjbGU0WE8rTkxl?=
 =?utf-8?B?cmZKdHZKbXhSM2MxTGVUYmlmTk9rNFlGWk9qY0huVUtmbTYvM2I1Qk1PMm1Y?=
 =?utf-8?B?NzVKbVpVVjNDbWZPNDlhOFMzRVUrZWZ6aDkzY1hYU2RIbWhWRkg2N3BocTdv?=
 =?utf-8?B?R3QxdDlMLzRjM3JPdU93ckFDWC9JSFozRmNaYzRuNUVOODlGZHY2MUJVVll4?=
 =?utf-8?B?VnFlejlPeEd1MXZuTVFwaC9iVTVWWEt0NVBkVjVuWmRBTnhGdDdic1FpbGhX?=
 =?utf-8?B?MXRtRnlzTkMvaktURDREVVo4WDFUaWNXY2dGcmpNVmF0VFlrL3pCampnNW0r?=
 =?utf-8?B?K0phSWRpQVdzKzFIV1RsaUlDUVYvb043VkZVclVlRTU2Mkt0Tld3WS9LWlpO?=
 =?utf-8?B?eEY4NmU0U1Y4cHZWSjNFVWR2N2F4NC9BV2NOY3lSRkJLZ3o2VXZmaTBVNUx5?=
 =?utf-8?B?aEJ5aWRDSXVmOEZaSTJPdmFEWk95M1BpeTFDSlB5ZmtXN0dIOHNDVTdLVThK?=
 =?utf-8?B?Y0VjYlhVaGZEZ1VwcTQzb2dlMXFvWHZaYjdJdzZHQm9tZ2FYTEhlNEgvcHpm?=
 =?utf-8?B?bXRqTHhjcU1hTlczanB0TlNQRGFkRjVRZXBueEtTM0ZaamVjWkhNUGFvN3V1?=
 =?utf-8?B?cStDeWIzMHNFSGY0cm9qTUJadXkvbFF3SlJ6bzNENGNGempZdDFvU0plM3dT?=
 =?utf-8?Q?r7QuyJzQQQ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek1XRGtjbFBJS0Fja3dQNzRFaU9KaG1kVnRsQWVMYVVKNjVObEF0Um5tR1BK?=
 =?utf-8?B?cDBsS1hBZjgvL1RzRWpwQ1BVNVFTUWRPVHdtYjlPeXB5QjRINWFhVHRqUGs4?=
 =?utf-8?B?Y0RUTkRLbVJYTGVMak1ybkdDcTRGMDBhVFBNNE4xamNpOXpvbHRnNHRjQ2Ni?=
 =?utf-8?B?MUZBL3J1cXYvZkNqUllodkd6aXpEYXpPcVd4R2FzMmk5TVZjbWNwamhycDJs?=
 =?utf-8?B?MGxBQ0dEczZiSklNQzBDZzVSR0FIUjlENkQyRmxsL0tmUXVBNU9QWnZqT1Bs?=
 =?utf-8?B?aFI5d1F4NThna2VMV1pDVE9QSk03eTZFQUVVbXp3Y3o3YU5YYW8zQWFubHhh?=
 =?utf-8?B?MzdkL0lyKzlBdHptVnhHMm92TE5QWXZIOW4ySUZFeDZKekFCNkFCeUV1Ry8z?=
 =?utf-8?B?SUdTWWZUN253NVFhcm1HNS9McEczamRqditRdGprSVBxdWJHc3lUVjlLYjMv?=
 =?utf-8?B?M2RRenJkQWtXZysvZmhqZVBKa294Rkg4R0R0d1ZpYmlJcWJsb2g5M1h2b3Nq?=
 =?utf-8?B?TzczUUFPWjdwenNlZkViODg4VFBZZTZFQ3NEc1Z6SWdHS0o2bTMwQ3dubHEx?=
 =?utf-8?B?VlBsOFBvTEVBV2lBcVAreVoxMS90T1BmTEdUVW5za2dRVjlNTktzSzlyQW9C?=
 =?utf-8?B?encyRHJHSHlYZUxjNWdDd0FGQU9yVWlzSGduY3FZWU1kMnVUT0Q0aVdNMEdJ?=
 =?utf-8?B?MFEyWXJGZUtHUlBJVEpqOHZTMXNSeVBZMXVIT3JYZlB2ZWs1akxTT1BPWlB2?=
 =?utf-8?B?UE5kei91aVNqS0U0SlZoUlZDV0xEV29vajZpamg3QktHa2xtN00vWG9mQTlB?=
 =?utf-8?B?MUVaaEhKblhiWWFYc3kwNk9sd0ludm1nRkJuaUxQdVozZ21Qbk1ka1ZPVXVE?=
 =?utf-8?B?dFlKd2lSeWg5VXE3OUwvUjRTSFBOb1NQb2dtK0RaWjY1UXZTSjBscjhIRGFM?=
 =?utf-8?B?bWE4WGZEWEhNL01MRlNJL3R0V1FhbjAwRUc4dnIzNmRHMWFBejFsWisyeFNE?=
 =?utf-8?B?Sk1YNDlRRmhKN0VhWTB5WGJkcVJNTEYzOXdaVEtsSXQzVFVtcnFETjFwTUVo?=
 =?utf-8?B?VUphQkpCR0pQdDdNbmwxbXd4bDhHTVRRUmRNWXNnOWZxbXZ5SEVkNzJGbEJj?=
 =?utf-8?B?VFg0U2d4V2tMU0hDUGhpSTV2QnFrUWk1RjAySEtVMjV1Y2x3bnR0MUVVU1E5?=
 =?utf-8?B?cGJIMExXdWtIRlcwMFRJdmZJV2hRZ2ZTWWt5cVU0bHY2bEE2ZGVjSm9CMHBY?=
 =?utf-8?B?bk9qNHZ5Z0JyQVNEM3grMTgyYU10dFhJcVJpK2FOYmRvVEpEUWJ1VktRaWpr?=
 =?utf-8?B?V1FaQkhrYURoNEQwbHdZa05CdS80NXJnQ0lDZVlXbUVFdUs2dEdBdlJTVDZP?=
 =?utf-8?B?RVhXMC9KMC80V3FVTnZ1dlI0NXRobnFkenJWUUlHRnRCelZlamFxWmc3UThz?=
 =?utf-8?B?Vkl6c0RxYWk5WEdoVnNaZUNVSjZocmtBQ3lSZVpxbW15eS9Cc1g3THdaQWdS?=
 =?utf-8?B?aWxTZ2Z5VUxZc2puakYxd0dLNU9wT3ZTbEtqMlJISTZ1aklQYWVJR2llMDRk?=
 =?utf-8?B?QzVUbzB3UkZabGkxUGJ6cnNkU0cxNE1oOG1vZVpzaGt3UzZ2ZEZNSEJEYmp3?=
 =?utf-8?B?c0lNdGZpRHVVMmNpY0t1bzhCblhLdU91b1RVcjJGeXRMVFJ3WVB1M0NWQml3?=
 =?utf-8?B?SjA0emI1WUtKUHUwUEs5L0JXSmdydHh1eUtOU1VzTS9QMlZ1SElTNHJMR2hu?=
 =?utf-8?B?aHk1RGcxUFUwdXkzdk93ZTR3K3VWbmdPa1NBbm9yVG4wcHFaN0prYlNMc2Yw?=
 =?utf-8?B?SHdhR1NxaXRDdkE0d0hIRldqdUlqSTlIdElrZFVwVXQzNExlZWcrQUF3UVZn?=
 =?utf-8?B?bnliQU1ib1dLU1doamRFVU1YU2dSb1hJZ0NPUTBLbmpFbnhxeVE2dm0yWjht?=
 =?utf-8?B?OWlhZWh0YmU5amRzZVlLZkE4YUdZK1lTUmZ4bXVCOFhEVURiU3ZxUjBVUDhH?=
 =?utf-8?B?bWxadzFlVmZsUEs3SFVCeXF0WUlVQm43YlJPRG9IOVZBRVJIbWFOek5KVGt5?=
 =?utf-8?B?cXFhK2dycEpPaCtBOE9BUXlzMWdLTEkxU3JiYmMzRHJoaytxSXdjUEZSK3Jx?=
 =?utf-8?B?L0Y0cndKc28zZ01yMlRscGU2Q2JNeDA0QUpZSkJpNGNTbEg2cVdXL2lGM0du?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5257ae-c62b-4ef8-9b9b-08dde4f96eef
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:36:51.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BFpTiW78BREodeVFH50SdsArw897beDM0xSIM6DGM1OXdXy/dr9IGEvmiMsIm5UKdd5S915gxB7FccBKEbUu2IFeuJjRy1cSjds4UcdIFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
X-OriginatorOrg: intel.com

--------------ccGkyW40WJdqSxkbnxCbiqnp
Content-Type: multipart/mixed; boundary="------------suCX83lrH600ntHjwCWgMeh2";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mohsin.bashr@gmail.com,
 vadim.fedorenko@linux.dev
Message-ID: <01a53791-031b-441d-a10d-4402e2895547@intel.com>
Subject: Re: [PATCH net-next v2 6/6] eth: fbnic: Add pause stats support
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-7-kuba@kernel.org>
In-Reply-To: <20250825200206.2357713-7-kuba@kernel.org>

--------------suCX83lrH600ntHjwCWgMeh2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/25/2025 1:02 PM, Jakub Kicinski wrote:
> From: Mohsin Bashir <mohsin.bashr@gmail.com>
>=20
> Add support to read pause stats for fbnic. Unlike FEC and PCS stats,
> pause stats won't wrap, do not fetch them under the service task. Since=
,
> they are exclusively accessed via the ethtool API, don't include them i=
n
> fbnic_get_hw_stats().
>=20
> ]# ethtool -I -a eth0
> Pause parameters for eth0:
> Autonegotiate:	on
> RX:		off
> TX:		off
> Statistics:
>   tx_pause_frames: 0
>   rx_pause_frames: 0
>=20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

--------------suCX83lrH600ntHjwCWgMeh2--

--------------ccGkyW40WJdqSxkbnxCbiqnp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK5FEgUDAAAAAAAKCRBqll0+bw8o6Pq1
AQDxE7Tw+SYvikjEL4YVWfVKGoMRRGTHIA6higz3PdCtqQD/Z/4sMiw64k5X3XDoc7V3KdQfZeoV
MQWbzdteOhqZYQ8=
=6/c6
-----END PGP SIGNATURE-----

--------------ccGkyW40WJdqSxkbnxCbiqnp--

