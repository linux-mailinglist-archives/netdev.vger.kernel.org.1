Return-Path: <netdev+bounces-109810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D73929F92
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A6C287DE3
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A6F59147;
	Mon,  8 Jul 2024 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvHjk7ON"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B61D6A332;
	Mon,  8 Jul 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432327; cv=fail; b=FfhHLHVT92SGWb1LEG4LiywBfi3Bz2+XiZdmia4TuBE0jDdCC7t0SRjo/xyiMcMkL1/oAysF6NWyKz4eZi8e0cYK6kytDso10Tul6CVHsBKdy1z5la0jdcydla3NtXFGVw809f9nxDbZD/6nLo2NlIMy3hYPEgl6+3QZ02hs6SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432327; c=relaxed/simple;
	bh=ogOPzC73k2nyMUuO1lDdCtB3rV89xKw8daHRTnW4ibg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGmt+E3tdzniDpWhaAmPjGlj/xYYg33lCUq1d4xCU7DbFMxaeDbE5IW5bcWH2j6NKsvcTrkfc+so+iUauM56g1Dt/27urbx8zhe5tBfxv9OJ/u2nKo99biRndrhTyyuBeg3ggape1AxsQvGrErgz2goUL3uUWXFcZxlOqnHMwa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvHjk7ON; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720432326; x=1751968326;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ogOPzC73k2nyMUuO1lDdCtB3rV89xKw8daHRTnW4ibg=;
  b=JvHjk7ON5MwDTULqf0QJAOw8jav9fhp4VfySuA+8meeXcHAHal5LUTXm
   c7Pa0B1nVCd4wMDFdbLHC4h3DzVcjMFQzooghVJhLkiDZNAkRC9kOrx6L
   V8D0uW/0KqXFi+le6ckK8ghOsx+oX/8Y+PwJzkOV2WTtFilO9M3n+iNLF
   034/huqrnY4jsaRIs7+vxNYUCHhPAEIbXwN5aDGyt7daAbV/WNYcGl2ko
   2cjCYu34o3cP2BY+4OfcZR/+dLRiLcX7GB5HLgRs9oNIanQZ1sNSDQ3kj
   vfBb20uzbIUKDxv+c/8jGE3Qzz314NrjOpaNN8JCWFTmonfc3Ky+8pzVZ
   g==;
X-CSE-ConnectionGUID: N6ax2yDWT1ChERaMB8RltA==
X-CSE-MsgGUID: n+apIfU0THGIl84g0xrkKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="43046370"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="43046370"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 02:52:03 -0700
X-CSE-ConnectionGUID: qL1MUNFIQl2R0U4yo9+iGg==
X-CSE-MsgGUID: JHoHkgbCRai/FzDIGzyThA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="48119287"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 02:52:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 02:52:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 02:52:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 02:52:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 02:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie0NavUwSO/rLqOWpmoYHQnbw8foxwnN5nalHy0s5FlEmc17ZWWgRHAu1YasIPfq6NONlu0VGjzyZsQvEgjHb3jFaSxvw30nkBSMd1JcF0BB01t9DGIVg1p0TXD1JZS609O7aKO8pyhmz+5+G2mxF0W3M4vaSOkMohqs+r/drenUhPEx298RXxTqVePc4VaUQEYOBMtJlLtU3RC2EqTfLeODihLksc8e+XiDlcB996rLpUdGc0Q9bUgQQRuRQ1g5CBo2zVglC7AkOQ7lE/6MJG7oOVH5UV/CtuuSC1lERTcnq4BsQoUkP25/uI4ZTOxwkj2NWkArfEPXG8Oal1QLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkxittvGFnmLoprfENXbx/HqA/FuwYW2tVtUsqe6H40=;
 b=Y7nS+C3yGNH+wqX+/nSpPinHQipTZyCwVqle+FHSbVUJpiE1qDPydCuJVjxV9IKhEdG6dPLoVmufs0ruVXFzEm58Vuq30XlnYtc6s/Elr2wT4LHIkJzvcVem9mPI1D80q731Zf2kDJE9kapaBu/ILG+PcH69t9oGqefaOkERO2kQY92sQjzqrgFGFb/n7ujsvftX6Jo94nUV5m71VvlTEaRuZnq8Fcsmr5H2r6dopIGqVW1upqzcHbwmLOhR8OparQ1zqyWhqZqBJN8lI0yF49MzMwj+kTzwsutKnIcyk2ffOLEsWSwltn6sYpzJEf7YnBFau0SL9ADaPHNS7YNXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:51:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:51:53 +0000
Message-ID: <e53db011-fe6a-4e63-b740-a7d2ff33dfa9@intel.com>
Date: Mon, 8 Jul 2024 11:51:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] netdev_features: convert NETIF_F_LLTX to
 dev->lltx
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
 <20240703150342.1435976-4-aleksander.lobakin@intel.com>
 <668946c1ddef_12869e29412@willemb.c.googlers.com.notmuch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <668946c1ddef_12869e29412@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: ae660f92-87ad-4751-1476-08dc9f3398d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXFIZnN5dSsrNGV3QktTVWY3Sk54Tld3S2MrcTRhY1QrOHJTNDhDL3kxb25r?=
 =?utf-8?B?Yk5ia2E5SElmcmV2VklmTXFtaW43RUF2V1dsL2ZVdGx3TEROemMvMFhFajFp?=
 =?utf-8?B?TkJwaEhrdmdOWW1qR0dWaHFMSmIxd2sxQWRPODY2eTdpRDVaSTZjMk4wYWxK?=
 =?utf-8?B?RmQ5dktxNDBJRUFkQjFGZnVGS21RNk9Vd1VLVnFiTEZPZFFlMDEyRFgrWFk0?=
 =?utf-8?B?UW0xSGpvU1ZPc0dUS2hZVHZaa0tqd1V1N1c1NnE1N1JJMlJmc1poL0RobFY0?=
 =?utf-8?B?WTQ2MDBzbVhNeVBITGdsd3M3dnU1ejNqWEV0MEZydnJVcXY1d3ZMKzliWVhj?=
 =?utf-8?B?Tm91c2VxdXYvNFF5c29wSlZlYXNBSEFqTDgwd051WVkwSjFqcHpmcVNNU1lC?=
 =?utf-8?B?L0prMFVQQ0RzUHlrOUpZMEY4SEd2cC8wNmYrdDl3OU8zMUlEMVF6MmdyNUpC?=
 =?utf-8?B?bWtzZ1psMjk1ajhyaG5TSlN1RmN6TnBYSGIwZUVPdkZmWkVHa0RmK2JWU3pr?=
 =?utf-8?B?d3BjVTJIWHVOek0zZTBUeWo1TXRGenA0OCt2WkN5SHZ4dzNoUzlIRUpEbnlY?=
 =?utf-8?B?eUFTeGVuTFFua1E1QytwanB0NVNlOXA0RUR0eXI5M1lsTXN6YXV6WXdJblhV?=
 =?utf-8?B?QVRJWlRWZHpON0ZwVzhrc0xqNzdMazRRampNblRRcDgza0dYUy85bmZ2Z0Iw?=
 =?utf-8?B?TzlkeEdvNzRmSFprY3FaK2NpUUhMV0t3QmNTVktGc2xjK2V4c1psajlEYXhq?=
 =?utf-8?B?dGxWWEtoQU9nbmxvT2pjOThPbThpRENicGp0djd1VnVkOXVwWVdTSXdoMVgx?=
 =?utf-8?B?TGtTbm9zUFFud05BdU42N2hNZ0M4ZDJ6TW4vQU5LVFdoWUExZXU0YVAvd2pL?=
 =?utf-8?B?ODhaQ0psdmwzdFdoMjlESXRyeXdqckVhL01yc0tNK09zZkFwSmcvdEUvQkN4?=
 =?utf-8?B?dm9vQUV0VWJUclRKNnJWYll0WjhWaWM2WDdxdlUwbWh5QTZhSFprcHFuTnZM?=
 =?utf-8?B?TEFJLzJoK3BkWFBiVUMyK3E5a05BUzFWaGNxT0lER0pVNlg4NlQ1eFQrbVRy?=
 =?utf-8?B?M2djdjlVblFnVnQ4Nmhxbk1xbFFkS2VMbmF6OGU0amhPN0JjKzljOVpBRTZZ?=
 =?utf-8?B?eHJGRk04UmphaFZWVURSREMzbGR3UkZoRnpscnRNU0ZiK0I3V3NXOXdhRlJq?=
 =?utf-8?B?RFV3SmhlaHVaM0JyTitpOGZBOUpUc0JvNHRtcmp5RzM3eVVIWGJIV3VSeEJm?=
 =?utf-8?B?dElVbTh1ODhPdFpMcW1ZUUROaWZwbGJFUDRMd2ZwNnY5VzhPcEpvUzk5blcv?=
 =?utf-8?B?NE9aQjFVdm1kcFQ2Z3BvR3E1ZEJmdk1ybGVzU3JzK3IybzIyOTRMOWdWb3Jo?=
 =?utf-8?B?NjM1UkcvcnJLTnE5SUthMnQ0UnVRdTFVUU8rUnVqNG9IVHpja0pjZFRMbE5u?=
 =?utf-8?B?NFNLYSthYm9mTERaWGt6ZURmbWE0NTJ3Q0tmRzhLK2RISk5uamhRLzVORnY1?=
 =?utf-8?B?Q2NSZXdwVDFoeGd6S0h0Zm1ERWxUWE81WGVicTNPUGJIakpsd1RRT1RVb3Z4?=
 =?utf-8?B?VWRUTHgyWXJZS0k2YUxHQkUrdVh3bTdQRDF0S0VIa09qcFhyODhYU0JHTE9m?=
 =?utf-8?B?MzVHZ1JxK3hha2Nhc3M5S3lRdndBSGExeWVIRHdUNm1KR1VBNmtQOG1sTHpt?=
 =?utf-8?B?NmsvNEJhRngwQ0hNcHJUdGxKRFNiYmpoeWJqMjZWQ2h2ZjRoQ3NWckdTeW9K?=
 =?utf-8?B?VE9rYm9uYzhweWF3M2tFQllhT0VKYWNpNDNzMURhWFJYQjZGRFZzaTR0Z0Er?=
 =?utf-8?B?aGtxS2xIL3JMRk83WXQ2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpIeDZydEN1T1NMR3BkR1hMaXl3MnJWQWQ4UUtWMndIUTZxTElWWDBnZEVL?=
 =?utf-8?B?ZkwwZlhSR1g0OFFQS3R1amYwZXFxNTBrUTFCSFM1NWtrOU9vOEFIMk10dUs0?=
 =?utf-8?B?QjU2a3Naa1N2RGhRQ09IUlIzS1d0cjIvbkZ3TkJwUWthdnJWQjFIR0pBYnR4?=
 =?utf-8?B?Ukk0QXpKcGlaQzV1cnBwOWdrN25OWTlBb3creGFMcnlIRzNDUDZLMW5DTk5I?=
 =?utf-8?B?OGtkZ3pxRk9KSHVFTGRHUnM1d29lMGxRa29rRFlmOGFkK05VS0swUEpkc1JB?=
 =?utf-8?B?VzBvd1NIUFZVcDFJVk92Mi9FNytHU0xrVGdZRElUYnBRdFVoVDFZSktuMzgz?=
 =?utf-8?B?SnlsbkZKZnBURzRkTUs2eG9SbFlQNE4rdGZTcHRHcVBFSzQrTmFpeE9QOG14?=
 =?utf-8?B?MFd3ZDNXOWJHaW1DcW1NbWNGaVFhRDM3WmgzYm5EMTBjVWR4OXZIMGFMV2Fj?=
 =?utf-8?B?ZTVleGd3Tlc4R0QwN2F1Myt5K2RENGtjcVZjOTgwSktnVjhjWHlBWDhJNEM4?=
 =?utf-8?B?SHVTMWFSQTVXRlR1OENRcEc0NEdVeXZoWC9udUJoZUNwV1AwMFRuWlllSEQ1?=
 =?utf-8?B?QkMwQU9Gb2YwZzNRMzlQNEwvOWxWazUyRHNNb250MktJWGdXTHlZd0NzejhX?=
 =?utf-8?B?MnlLb0R0QlZ2UTVJa1BIbk4vQ2FsSzl4SlRLOVprZ3lJendDU1ZUL0U5c0hW?=
 =?utf-8?B?cjErNlcyRzQ5QW9oQ1J0RjNWaWxmeTA0S3ZnU1V6Q0Q1YmFBUnlxOThzMnBZ?=
 =?utf-8?B?WnRQRnlFRVNlZWVtOTU2aWZmWFRFMVU5REdyTFVnS3pDZlZ1dUc0MkJEaThD?=
 =?utf-8?B?RTNyazNXVHd5RXhQcmpSZHJ2UmZnaUFTMm1aaG4zVFFFbTQ5aTNrOGY1YWww?=
 =?utf-8?B?UmMzS2NUa0NpVVFVcERMRWlDc1V2MFZHRkk4eWlyK3FhT3NIRXpTU2QvME55?=
 =?utf-8?B?ZnpNU1lvem82UGJqVGNwL0d3cUZjR3R6N3A5Vkw4L2hqSkhBWG1kYlc4ZVJM?=
 =?utf-8?B?b1dyUUg0QXhTclorRllFZVBDUjRjU0tDRXpZSHlDRWNhQ0QxWWhSbWhwVlF1?=
 =?utf-8?B?VmdkN1hsSTEwcTlQdEZHSDZhc1lTRTFnZFUvNVBGRzU1TlZKdW0zVjBtNEI1?=
 =?utf-8?B?djI0MzNZaUxNTU5Dd3E3RFhPYVVEc3ZxQXAzdUtVeEJQSEx6eXdUL0ZDclB0?=
 =?utf-8?B?bnpJU1VGcERaczR4YWZEM1FLbkltSEtaRFpoM3JkbEVRKysvbXlNTGlIU1NC?=
 =?utf-8?B?OFo0NTZsVWdaZmlPdCsxTjFQajdlM2ZvVTljcFVMNm9xdURXdVJQTzhVaEp5?=
 =?utf-8?B?elRyb3BqWUdoL2ozcU9BQlJGVlZqTGs0MCtaemVqZWhQOFJ4ZVh3ZmcyTi8w?=
 =?utf-8?B?SDdkK0FFQTliQWhERGZIaVVkV2dRaWhXYnFxbkExL2E4UjB3UktWK0Z0cldr?=
 =?utf-8?B?dHZ3TFpxaTB6c1ltRXV2bHBTbG5NSXBIVnREckVxa0tDRWEvOTRjSmlzUXI0?=
 =?utf-8?B?SmN2ektVcVVVT0hLck92UVhuclNyZFVYdzJ6NjZuVURSeThMNWRPYWwyb3JT?=
 =?utf-8?B?VHhQcGhVb0Q3cHByNzAyczZ6aVFLMEN0MENrOVZCUmNpMkVLVU5jWXowWnNY?=
 =?utf-8?B?TjlhMkRqTkljS2t0Y0FDdmlyNk9hTTV0c1pHMjlJTmZZbUdLL2Ewa3YrY1Nv?=
 =?utf-8?B?OTg1dVBjYlRoODliVkMvVlRISUZEOTkxbEE1eXNNZ1VxV1J0TVhKRHRRaUtJ?=
 =?utf-8?B?bmI4WnNOaUJqOXdDOWtQa0pkSFRjWEhvclVUcUtBM3VjVHJxV29pUnc0UlFW?=
 =?utf-8?B?STBoUUJMQ1VFWFdwQVZqaGtYa1FQV05lTlByMUhyZks0UzY4ejV1dEdRVlA1?=
 =?utf-8?B?Z0wrZHltNUU3YWRJUUFPMmsrTWZIbW1ac1JYZEU3RXA3NjNQV3N0YVRNc2dY?=
 =?utf-8?B?RkdFWWpidjFJNG1HSWNZTFdRbEM4eUcreHcvMWg3czNEZGpDSS9HSVRid1cy?=
 =?utf-8?B?cG5LTm1vaFI2eldPaytPMno4QktPS0VkZCtIRjJsbDB6SkZwZHlUSXY4ZTZp?=
 =?utf-8?B?K1lxUXU0YVZTNFQyQ2pBamU0R09nOS9qQ3VnUXVNRHVndWRiMVpaZjNNM0gw?=
 =?utf-8?B?aXl0ODVwZktLYktaTUFiNkY0NHNZQUZlZjlrZ1N4eVhXd3hDMGNKNmlReCts?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae660f92-87ad-4751-1476-08dc9f3398d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:51:53.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5wVjDSmMhvhfQRBj37RI497JSCelW7xvCzXoqo2IHAr8Y78S5lRaMn+gPo8nSJq+5sEAXFfU63v+eamJAIuSCAVnSmTz0vLtghlKsBBI+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
X-OriginatorOrg: intel.com

From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 06 Jul 2024 09:29:37 -0400

> Alexander Lobakin wrote:
>> NETIF_F_LLTX can't be changed via Ethtool and is not a feature,
>> rather an attribute, very similar to IFF_NO_QUEUE (and hot).
>> Free one netdev_features_t bit and make it a "hot" private flag.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

[...]

>> @@ -23,8 +23,6 @@ enum {
>>  	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
>>  	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
>>  	NETIF_F_GSO_BIT,		/* Enable software GSO. */
>> -	NETIF_F_LLTX_BIT,		/* LockLess TX - deprecated. Please */
>> -					/* do not use LLTX in new drivers */
>>  	NETIF_F_NETNS_LOCAL_BIT,	/* Does not change network namespaces */
>>  	NETIF_F_GRO_BIT,		/* Generic receive offload */
>>  	NETIF_F_LRO_BIT,		/* large receive offload */
> 
>> @@ -1749,6 +1749,8 @@ enum netdev_reg_state {
>>   *			booleans combined, only to assert cacheline placement
>>   *	@priv_flags:	flags invisible to userspace defined as bits, see
>>   *			enum netdev_priv_flags for the definitions
>> + *	@lltx:		device supports lockless Tx. Mainly used by logical
>> + *			interfaces, such as tunnels
> 
> This loses some of the explanation in the NETIF_F_LLTX documentation.
> 
> lltx is not deprecated, for software devices, existing documentation
> is imprecise on that point. But don't use it for new hardware drivers
> should remain clear.

It's still written in netdevices.rst. I rephrased that part as
"deprecated" is not true.
If you really think this may harm, I can adjust this one.

> 
>>   *
>>   *	@name:	This is the first field of the "visible" part of this structure
>>   *		(i.e. as seen by users in the "Space.c" file).  It is the name
> 
>> @@ -3098,7 +3098,7 @@ static void amt_link_setup(struct net_device *dev)
>>  	dev->hard_header_len	= 0;
>>  	dev->addr_len		= 0;
>>  	dev->priv_flags		|= IFF_NO_QUEUE;
>> -	dev->features		|= NETIF_F_LLTX;
>> +	dev->lltx		= true;
>>  	dev->features		|= NETIF_F_GSO_SOFTWARE;
>>  	dev->features		|= NETIF_F_NETNS_LOCAL;
>>  	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
> 
> Since this is an integer type, use 1 instead of true?

I used integer type only to avoid reading new private flags byte by byte
(bool is always 1 byte) instead of 4 bytes when applicable.
true/false looks more elegant for on/off values than 1/0.

> 
> Type conversion will convert true to 1. But especially when these are
> integer bitfields, relying on conversion is a minor unnecessary risk.

Any examples when/where true can be non-1, but something else, e.g. 0?
Especially given that include/linux/stddef.h says this:

enum {
	false	= 0,
	true	= 1
};

No risk here. Thinking that way (really sounds like "are you sure NULL
is always 0?") would force us to lose lots of stuff in the kernel for no
good.

> 
>>  int dsa_user_suspend(struct net_device *user_dev)
>> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>> index 6b2a360dcdf0..44199d1780d5 100644
>> --- a/net/ethtool/common.c
>> +++ b/net/ethtool/common.c
>> @@ -24,7 +24,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
>>  	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
>>  	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
>>  	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
>> -	[NETIF_F_LLTX_BIT] =             "tx-lockless",
>>  	[NETIF_F_NETNS_LOCAL_BIT] =      "netns-local",
>>  	[NETIF_F_GRO_BIT] =              "rx-gro",
>>  	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",
> 
> Is tx-lockless no longer reported after this?
> 
> These features should ideally still be reported, even if not part of

Why do anyone need tx-lockless in the output? What does this give to the
users? I don't believe this carries any sensible/important info.

> the features bitmap in the kernel implementation.
> 
> This removal is what you hint at in the cover letter with
> 
>   Even shell scripts won't most likely break since the removed bits
>   were always read-only, meaning nobody would try touching them from
>   a script.
> 
> It is a risk. And an avoidable one?

What risk are you talking about? Are you aware of any scripts or
applications that want to see this bit in Ethtool output? I'm not.

Thanks,
Olek

