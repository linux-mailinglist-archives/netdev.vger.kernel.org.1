Return-Path: <netdev+bounces-109518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF065928AC0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8FE1F21585
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B814B971;
	Fri,  5 Jul 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eypIHL5H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510F14AD2C
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190069; cv=fail; b=rPZOCUDyQrAYdL579oFd5Ud7vkWgjQglfLfdL5ai0t8H0Fo7ab/1tZYRHJ1DitF2QB8uUSLvwTkt/hEmAbn+ov3GAJ4ZGJSgHN+IsUdO+0eIW2+xnrnBgGzJFTpu+ldfYHaMQcYCjI05Q8c5copLds5lQvYytdvMxS9CgG4ibsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190069; c=relaxed/simple;
	bh=Wh8UjRkOwVnALsq9gu31sZz8TexHHHN9G8WjT0JL0Xo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yqx5YcJYOcf24X0k+NEJs55H1pTvljJ0bOmAXXWneAb0q3aJIQmmsweivGoEPkYDCy8kLOwlI9ZUhdHphr/sVQ5HhSEmaQWPGfRIKCp5KlQfK0Tu2D68TkH82yA8mD1s66zzeHcYV4hA19Sx6KW7dDRdYhOYXSWmiAPk6bw/rIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eypIHL5H; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720190067; x=1751726067;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wh8UjRkOwVnALsq9gu31sZz8TexHHHN9G8WjT0JL0Xo=;
  b=eypIHL5HaKQwpNGifGfElx8rh28mV9cHNi26olRBw9Dzs7EexH1aNrZM
   Hl+DtVHEf5TeJxWHsdkFgBb4tszylMdSQdmo3AA1W2RqBZooLSbIh71Xr
   rI2zr3ZLp1N6cSFvyahgsLX1wu9AByIXPV9fFd3dGfyvJGt34Y/UhfSuw
   e+hkxbXzmAa8eT60mCTm9dBg232LAQf/mM7jlbY4zgEvQafnyoEVDvmUV
   FysZBqhBSzh+F0KdlHnpb7VrpYd/IDw+vt9HABWJZVJfni6oWglWfbxcE
   aluRmdyMXo5gnYCYNPqOKDjFdJ/gl6BbPEg+go4Z7vApsAuy1YRojaQpZ
   g==;
X-CSE-ConnectionGUID: Ua7hVzNnRUqLj7UZUOqg8g==
X-CSE-MsgGUID: VcYCUFVGTV+1Hg9qwoZOJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21253773"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="21253773"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 07:34:10 -0700
X-CSE-ConnectionGUID: CP91320qQ3+58417pqMY/Q==
X-CSE-MsgGUID: pgnPWgUZQeuQD+vJfF2SuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="70093382"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 07:34:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 07:34:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 07:34:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 07:34:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 07:34:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbzNgCFK4YVIFpAE/1ZI6AK+JCUnPR7T2BqOVC1YY1s0Ob4G0x7WBm3gWmXapPzfdONIWkcjd1o8mTV4l8C+C5cmI9BzhcJ+PdB2O4NCZP/kKEonvMi9HSP0WPsEfxWrVFLFkvQ5XTHIuXNgxLV1XFrPGw61EOJhksoDGEf6HRFmaaYEVJIE/PP8YjWYlFo1HV7jwuq4g8gBNlH2PT6U6V4FylhSdULCln9JhB1VW4GG77b5KlFcM1Tse5oIAyMrZ+5smnjIJDV5ZHKBiOcTbjTXg68qMwPOKrVtLzgmqcj1JYDQlpTUu2/8ECwoxRYL1HRnktwKOO/w0eezMGeHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxZgOn4HWX/rEVI1UTcIE2dvxMbN3yA0+KkO8ddgTwk=;
 b=ETEQQKFgauaRLBYlisuofHsffCBZKz7MxN9tEV62j2Znb112RUiQ/44genRRg75yTtwXQchYhvvQ18261aDDrkj1hd7j5wkwePty/9jZCUykUIuri/fmv20JNM8VkLU8NOSjB1O58h+86e8YDbO96E5egYb7EGUADjH0Y14SAqfk/6lyebncaIriMusDklEkBx6o4jpHmcNnA/6i03Ikd7HbmIhXpv83WkISJxdbOj5RMOsQxO6RWee9saAii2PUuCEKpYR9LpvBqbhSskVZn6jfDGOs9B43K5IENCiAxRyXoPhWkmfrWLN1bFmk51nfq+yXRLQmGlQk5WmAnWruZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Fri, 5 Jul
 2024 14:34:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 14:34:05 +0000
Message-ID: <98fe3c75-6916-4f93-ae7e-be80e60afebf@intel.com>
Date: Fri, 5 Jul 2024 16:33:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
To: Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
 <7eab05e6-4192-4888-9b6a-6427dc709623@lunn.ch>
 <09edde00d5d44505b7a41efdfb26cb16d0cbdc59.camel@sipsolutions.net>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <09edde00d5d44505b7a41efdfb26cb16d0cbdc59.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::22) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fce48b-9301-42b7-e209-08dc9cff85d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE91TElqZWlGYUoxd3k5akJKVUNwU3lSTk95V21ibjNnWVE2YWFZVml2QWRw?=
 =?utf-8?B?bVVJY3RpNnVTQzBzWGRMdTJKS3p4L1JVMnAxZG9XQlRLMTlsazRkWkVUbGZm?=
 =?utf-8?B?Z3I1NEVxSk9tcHdTT1YyRnk2NDdVUVhVMDlGMFU3Qm9yYjdRLy9ydnBZc2lo?=
 =?utf-8?B?dUlGY0NDOVRWY0RFNjZDRUUzamphbHd4dUlLcUUxSlBRMXkzNmM0emRsNDBM?=
 =?utf-8?B?Z0xMNHMxOFptdEpmRmp6OE4rRExjTmRqRmc1cWU3NXpjS3k4UXFGNWZzTjkv?=
 =?utf-8?B?bUhZWTFXcWdIbnlhU1AxblBocDVNWEo2Um14MHJBOUJkMTVlbm9zYTROMzhQ?=
 =?utf-8?B?MGlnQUNvR1BEUk0xa0VIajFuNmlEbUxDQlFUWms1V0Fhcm5PVkplQ1FESXNF?=
 =?utf-8?B?U2tqY1ROWjNJeDVSNzJyNEpUdzkvWU1OWU1TV1c3dkE0VDR0eGdFbE1HUHFl?=
 =?utf-8?B?Z3lYa2llVC9TZ2hpQUZ6V0NoRjkrY0pHbU1NcXJ5cEFNUjdnc1JKQjdnNkYw?=
 =?utf-8?B?dTcxeXJncklIc216OTVIZWVHYkdJcEczMDBIWUhBdjNqNTJYNWdFaUl1SzV2?=
 =?utf-8?B?cmtiUDJSekQyT0ozQnFsaUVGRC9lNitHNGkzekRjUzZUZXkrVXNFc2lPdDRS?=
 =?utf-8?B?bnNseldkOTJDYkE5THF6RE5zK0Q0VDJSZVpya3BleEVvdFB3SFZQWDA3S1dr?=
 =?utf-8?B?R3pMaHcwak1ZMWVmQ0wvbnRsVGg3Z1haMkNSMytiNTU3bnhxR3pVcTVmVUNU?=
 =?utf-8?B?NWthUFF2SU5mQm81MHhLamFHdUQwUE1MVEFxRmt2ZVBQTXNJOURmaDJKSWJQ?=
 =?utf-8?B?Ni93YXp1ZzRRR2xQVmVYQ2w1RmRWci93OEtqU3o5MUZoL3Q5ZWlyQjN3L291?=
 =?utf-8?B?NW5TcitPMVZLcllBenZQYjVzL3JucGlUUUk4WEJnZGQvUDJSZmFackIvS2dq?=
 =?utf-8?B?eFpYb25CS1dLblZ2dm1xNndvbCtOM0ZrVnpybXJJcmRVVEkzSldDZjBZNWtN?=
 =?utf-8?B?eHBWYVh4WGd3Q2crVi9oVlV6dE9FUFh5eTRtdnVjbDdKUXNmejlYcndjVmhh?=
 =?utf-8?B?TWZiMFdpbXRVSkU1S0MrWjN0ZG1DUDhpcVRQTHhLQnNWSFZ1MHdnVHBXb0RC?=
 =?utf-8?B?MHNBUHZEVHZDcXZiSDJteno1Z0F0ZWp2WTM0b09TK25zelhVVXF6UVhBOEVk?=
 =?utf-8?B?ZnpQSEhTaVRYTGRxTVFVVUh6ZVFoTktEWTdOZU9IT2hudkNOR3F0elJxQk1F?=
 =?utf-8?B?eEwxcHhjZFBKVXA4VXRSTHlxY0ppQ0RlamErRHJGWnZ0OGc1V3plM1FWYXhi?=
 =?utf-8?B?U3B5a2VKZFduTWp1NWdydnkrNHJkUjJ5UFVVbVFLSUhDK1l0Nk5EQ2wyWThp?=
 =?utf-8?B?MWNDMjNGZjNlTmF0SkExTy9CWThMWmIxWWd1T1JiblVYSFZza0kxWEszbDQx?=
 =?utf-8?B?bDN2K05JZVd6QTNDMVd2NFc4RHROWjBwejlQempmc3FwcVd1Q3pPRm93NjJL?=
 =?utf-8?B?ZzMwZXBLU0hNL1dMUzl2Z1oycklCZyttb2NjWjdIVmVwQTdqOTRGZ1I3OVF5?=
 =?utf-8?B?TVl4K1FqMi9UT1hYdnBxTGdqd3p6ZXU3cnpvdXNTRi9FRTl6SDJwNVF2SVBW?=
 =?utf-8?B?TS9ESFY4UENmSGVoeU5nSE1MUDRzT0hFUzdxNldudDdHbVp6VC93ZzNBRlJz?=
 =?utf-8?B?SE41TXZwM3RMNkZuWHArZE1qM1MyMHRybS9hek5NTFE3azMrK2ZoTi9PRmwv?=
 =?utf-8?Q?ZRek1XO9apxLuuofY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk5GeFBuR2tsTTlDdTBoTDIwTCtHbElWdlg2VldVMUpQUVdHNDd5MVR0OWhq?=
 =?utf-8?B?WjFWazl6RGV5NnRFWU9zQTBBWUt3VWxYc0lNeEFSQ0Zpb09SWGlqRFUrTU5E?=
 =?utf-8?B?N2J1S0swRkN0VFhEMmtja1dOOHV2a3RUaFJ2RUpQZGlHaDR5TlBad3owcEQ2?=
 =?utf-8?B?VHhLTVJ5RzhzT0dNOGpQT1FoWWtrRzdEa0cyK0g5NlpsSVZka3JwdzkzenVo?=
 =?utf-8?B?ejB2T25lV1owd2VlcFZqUkhHVS9iM0UvMkFsam43aDc0eVc5d08xMmFPVlgr?=
 =?utf-8?B?UTZSVEorMGJYV081aGx3ZUF0cU5pQkswQmxBQUxtN0xjS2NRL0NqTHBJNDVO?=
 =?utf-8?B?REg4a1ZyMGp6VDdPQjhmby8wcXp1eEtqSXYzcXdzYXorYU9HZG9vTml3L014?=
 =?utf-8?B?NXc2d2NjTDk2YVlmNFROV3BlRktIamFQMXVUakRiZ1JJd3VUKzF2aSt4THkv?=
 =?utf-8?B?NzBJKzlYaFg3NzB0clJXZkxhNEFNMTBFa2s5Q0Q1WGVaQm5vRUtVZldOSkNU?=
 =?utf-8?B?Nk9MekY0YSt3WFI2U2dmYmhmN1ZKQS9nLzNFeU5mak52c2V6U0Z0Sm8reEpz?=
 =?utf-8?B?U3VKcXdkMy9HWkpucFFSTHl4djdTQkdSdVhmdi9lTXU0OFMwSTNJWUpXQ3pH?=
 =?utf-8?B?aFJVTTJiUy9ITmdHUURzZVpFRGtGaDJRalFFQ3RKempxZEtsWkFFc0wzQ3JU?=
 =?utf-8?B?bERBUUN4SnkrUlk3MXVOVVpsRDN3eGZVVTlLVDg1MktQSUpqa2JuSnBsWStp?=
 =?utf-8?B?K1ZPSjZkN25tc3E4bVBaK2ROblM4RWlnMHBDalV6aFM4VmN3MlhMT0JqZzR0?=
 =?utf-8?B?bVBnUVErNWJMdDRIanVWeS9XWlNyVFhrcHFtMWM0KzBZaUg1YjEwRCtHS01i?=
 =?utf-8?B?dzFXdThLZ1pVOVFia3p0dnk3YzR3bUtzUmRvTmo1TDlrMjdYZ0hKeU9IdHE5?=
 =?utf-8?B?aDVhckJwQ2JTU0ZTd0ZwMnVadlRGNkxRUDdsb0tMdDJ2ZVF3MWpWaUJkcDRC?=
 =?utf-8?B?UlJDMFIrNi9KUjYrUVVhRkdTdjNHMTlSdWNrZ0owbnRJSmcyMHpzYUltUHEw?=
 =?utf-8?B?UVNSY2ZoTlAvWUxCRUpBSm5pQWdLNk4yNmM3UU9ZcDg4Mk5xNXZhM1FBMjFn?=
 =?utf-8?B?V3M3VDFxYkFNTHFmWm1hY1J6c295K1FPeXcrb0o4ay8xdnZpWDViRVBidWxK?=
 =?utf-8?B?UEg1cklUUUFaM3RzeWczbnRrR1dQZEp3T1lnMjlPR3dPZHl2ZC9mTmxxVTBW?=
 =?utf-8?B?VGpxa0R5anZScEsvVGZoa1FwayszcFhDZGpPL1NWUThXZHNHUi93VkRFWGVH?=
 =?utf-8?B?ZVNmZ1lFQlVmL2w4ekpicGtTTXU2R09UL3VOVklNR0JRbEgzQmpRK2J3R2xj?=
 =?utf-8?B?Mm42QXptNm02NHpaenJRU3VYSDVUdERaVENhaDRDQXg5Q1VRdno3TEs2MWFU?=
 =?utf-8?B?S1M1MUNpL3E0SlJOOS9MZmlBWG0wanFoamZieWRNSjBxZzBrRGNuVWYwWG4x?=
 =?utf-8?B?bDVuTWpzUFBVNWFZSVF4VExSZjU4R3FXTVRZT1pzWXY5cU1Lak9YbWd5dFhH?=
 =?utf-8?B?K2JHcXd4cUtRQy9mRHBZUmptZzFYWGhhNVh0TkFRZHBHUjNxbkpySGJ3OFV0?=
 =?utf-8?B?M2YwSmJsblFtV2dOeWtFb09ZYmZ6ZSs1ek4xb09oN0tJWGlnZy9Wc2NEQ0Vw?=
 =?utf-8?B?dzNjTDZWQ0UvUHhNRUp4cFhreHFLTFAvQUs3NlBEanZVbzFnUUo4Ym00Sytk?=
 =?utf-8?B?MFFwM3RBSWRuODVWVjF1aWZDY2hjT0pXTXZmQjc0UmJ5WHJBY3A4YitCaklq?=
 =?utf-8?B?VTJ0OUtldWIzWWlvTW0yZStjOW9zNUZtTHUveEJqaGVRZEdONEJQMGVmdlJj?=
 =?utf-8?B?Umg1SmVUeDUvMXlFbDB6bVo2KzBKdkllWldXeS8vRzZXRnM1Z2sxcDU4eDZG?=
 =?utf-8?B?aWhxOWowZXlWL05oUlVIbFpCRFR2cVZtUDZldERLOFRtOWQyZHZTYXFmMlho?=
 =?utf-8?B?SGFsNWdaYkk2TStqeVdJSHdUc3Jka1VPbWd4dnE4TWlkcDhyd1F1blgvQVZa?=
 =?utf-8?B?QktudFhzaklwamMxeEdUT2FMME9tbmxZTnpNeDNDM28rd3gxWDUxNklRdS9j?=
 =?utf-8?B?QlhxK2s1ajhxeW01UVBFTHNHMjg3enZQcW41U0RSUWNhTEljajA2VG43MU9k?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fce48b-9301-42b7-e209-08dc9cff85d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:34:05.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeR7qiN3MUHznIaEyyaTYVloEdu5knoGXKzdGUm5etJEwlIUKu6fnDrIaz9jCT27lAQkZUbpTiQw8+jKNAuwbGdjIMk+PtOllw8O0rcDac8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-OriginatorOrg: intel.com

From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 05 Jul 2024 16:23:43 +0200

> On Fri, 2024-07-05 at 16:19 +0200, Andrew Lunn wrote:
>> On Fri, Jul 05, 2024 at 02:33:31PM +0200, Johannes Berg wrote:
>>> On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
>>>> From: Johannes Berg <johannes@sipsolutions.net>
>>>> Date: Fri,  5 Jul 2024 13:42:06 +0200
>>>>
>>>>> From: Johannes Berg <johannes.berg@intel.com>
>>>>>
>>>>> WARN_ON_ONCE("string") doesn't really do what appears to
>>>>> be intended, so fix that.
>>>>>
>>>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>>>
>>>> "Fixes:" tag?
>>>
>>> There keep being discussions around this so I have no idea what's the
>>> guideline-du-jour ... It changes the code but it's not really an issue?
>>
>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> And ... by referring to that you just made a guideline(-du-jour!) that
> "Fixes" tag must be accompanied by "Cc: stable@" (because Fixes
> _doesn't_ imply stable backport!), and then you apply the stable rules

The netdev ML is an exception, IIRC we never add "Cc: stable@" and then
after hitting Linus' tree at least some commits with "Fixes:" appears
magically in the stable trees :D

> to that.

Thanks,
Olek

