Return-Path: <netdev+bounces-279955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zZ+MIHW65mnX0AEAu9opvQ
	(envelope-from <netdev+bounces-279955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:44:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E4434ED9
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A188B30053DE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E23939CE;
	Mon, 20 Apr 2026 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUUJ+4MQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46052E413;
	Mon, 20 Apr 2026 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776728689; cv=fail; b=adERuEei+sshR14q3QsOhhZe85vvwLxqYNsH7CRe7TU99ynoz7mqsh/0OSnKRSdVPNC4R6EGqCwVZjqy5/rjQ/zBKzhbf7GYyRDiDJQ/2BeGIuEjX6D/YLelFC2RtVCJmQfrtl6yskaavVB0BU9lFnD+jrwOL44MAXqXI9obNyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776728689; c=relaxed/simple;
	bh=7/86dq+TUwZp4aQDaoYD7s1ooWB+lkeTRj3PQrXX9co=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lsvBzIJEGwABgFllMLQsjMsp3bWOk2XTejOyV4kbkx2/FWYMfGz3UHKPdwfslCRS3gthPAA2NWihpPTBnSQifY9i/tqiPS7XVNZa5QQs/fw1JGaqvaBv0X5SUbHclU4xW0/7VwcOMgmlT2fECN0zfyJJvd5wfAGPRw1ViVGKYrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUUJ+4MQ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776728688; x=1808264688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7/86dq+TUwZp4aQDaoYD7s1ooWB+lkeTRj3PQrXX9co=;
  b=cUUJ+4MQB9+OXIVlz4sgFcXCIZOUsxVGYFJtSrypu51UrLjYRrCdt3Qs
   pbBRw2FRpfIiqld7NHPILt3b0pIH3eXk2+hVDu3A044a/YX4ezaIlMCsf
   3Y+ARTeI3mK16zbx8L2YE1tuADZnO2CS8B6HK3CRZyXnybyVhFdbn5lfs
   LBmKlmLH9ccTijliOrkEARpseQUDAdGpO+fIhw8mW8Lwn6mT6wa+pewXg
   TKxe4XIohGIMh/rZ6NoJ1mCrluyZ8Ib2LoeHzwdwN4mkrhAX1tRs/Ehgw
   xGLGqGHGRvVyD7msG9FjeWRVCUkctzbzSWSAcD0qtUe6i0dQdiXAFxxfh
   g==;
X-CSE-ConnectionGUID: qzI4K4mMTsOCLVGZSXsQAQ==
X-CSE-MsgGUID: G5bc9eGxQEeTBOQydibXvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89124034"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="89124034"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 16:44:46 -0700
X-CSE-ConnectionGUID: wMbx63H6R8uA9OFezW78Kw==
X-CSE-MsgGUID: 53a5XD53SZKhHlnjy6ZdSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="231737429"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 16:44:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 16:44:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 16:44:45 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 16:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP67qtgKmRpDdnTTwQOZ6ecdZm75aF09AaIqGgkYBJ0yhqAJ6PneWZe8S5xyJiKRDhvgc9ZEjIS5ygDkw03BaJlAC1B/ZRk3FW2r75Wgx2owgeP+H6vkJm0fasYIR644OXzeNPGeDsVv16xIYSSP25BCeSPRdqPNP7Ev9E4fQq7INgm6u0EYKCFcqXsVVC7r/4VFtvmspTZB8IkJfm0yKx0Bh1S/Ouj3Q/drk9PY3aumGKtFaMtlLyErGjtLkGcqs1XsqR14L8Udz/pFwuVdy/xyK9x6NpbCMTdJeAP10NBBdkFl2yg6fT07N5bV4EMyRcZzM7nabDXlXx5Hl0Jj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn39R49cvvCQiee+nSTgKD5AhfYhQxX0XlPGn3GGFeY=;
 b=lOc05c2FJSfNwmolyVUEFK2A9aNhZTvsnMJTY2fEjc+WabUXFC2ZFIcVU7cDSiD1sctR8n+9u6OVKE39kwVJ+MIHjAuPSwPs6G4EOY1j/98eztTk2+bhCzlBBITcc3A2jtKAlGyy+5QICEB4SaxRjWjvybOTXp+aMJfEYQ9nKpiYE8wJhz1KsIztw5y+3tAz0HzoggPJHg9Dc1o4b51uSxyaU9wo8xZwe/mlxjjC3iJDQipNuKfwm4+x61RPz3lzQ4oQbIxRf4MclVNPBIRDLbuMpmmPrJto6DSLVyIE6kXextZfoO9ljKEXtO+h4cAFNoCPTdbL9uXEepcc/rMLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 23:44:40 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 23:44:40 +0000
Message-ID: <0119d579-f847-4c1c-bf4d-a31b352420ea@intel.com>
Date: Mon, 20 Apr 2026 16:44:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] idpf: do not perform flow ops when netdev is detached
To: Li Li <boolli@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Decotigny
	<decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, "Sridhar
 Samudrala" <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>,
	<emil.s.tantilov@intel.com>
References: <20260419192555.3631327-1-boolli@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260419192555.3631327-1-boolli@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0337.namprd04.prod.outlook.com
 (2603:10b6:303:8a::12) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA2PR11MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ed8fd1-a39a-438b-d06d-08de9f36ca09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: cjLMZJrJ2BsSjTdWY/8WGJM4YI3CsEW02YHCZHPeWoE4rObEmYTqyJ4aVoVhGR34VeH5VHr95z1BzaJ+1vB9gGfHOlJ3yLA5x0EyqnRYtOSoUzrX4R6JQkGR8h/anHQ81cwz3Cm3wfulKtTNSZrclFGPS0RsBX9s7hAeGuEVtxzjOQJxcitLO89YmgAaNoj9VRzH5QElOUf0vLc7ZEckD1as8+A6jFKQA2uF8cLAq5lIHh7OSpZLrc+19A+0aSk5zkh4LWKV2YDpLNAVg/sgNzFkEBwY/bxBC2tAPV0i8E5eZ7/Fx7I32685e81xODCATQnmsq4CLSX11mFaxeY377PNVCDoID6s6BaWfZzONyv01ivlmF5Uhus/TnxpQxQ9w6DZPbU+SnKb3OZHxoj76mMmEWq7y0tPn4qNrRvQo3tvi6PT6kGmmxfog8WVSGIfHb2TxgieWlzaUuzRHgiWzwqfZKLLcJlXP4gpJBsf9RHWJ/A+i3c9xxGibFRYOSd0ELv8ReT9seZMFV/L5AiFco/r+LiHGQrW0mS0ZsQ6R6tqMY9zioszepgPw1ncKNeM4nfxNGwhCi9Y5IDTBx5WTTjgMHExtViJrkiDIkQfnmuiNfkPCjOmgeOOGCOisOSvZzWQT6txJ2fCu7pI55oMWD+HqM+eTrKG6rggzHjNFmuavBg6vRTRwAcdvckd2Sojk8BoiC3BRzBepEq24iSiCEHyiJzbE9qLL+kAA/5YKqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFVTSk1ZKzlGK01XOHVnWko1R2lIS015cG5ZL1JEWW40SFNPakRsRzZPNmcy?=
 =?utf-8?B?YW1wT29CS3UwY2s0UVROWGR5MnRKdml0S3pIWVlDZVZIU0xUTnJDZEVQYlB5?=
 =?utf-8?B?VFVVaFB2ZkRTblVtQ3JpOGdzeE5YLzdtZ210dnZjeGZKUXlBbmpFU1dCSUdC?=
 =?utf-8?B?bGs3d3hHMzdpZGxQRW8vNWYzSTVERG1ITXY2eE5tcWdJVUZNeThpOWY3TE9D?=
 =?utf-8?B?RUJrZ1pMbUdQc0YwM0dmcTlxbkVTYlZBVVhCazI2emNwTDVYZDBScHNYR3Ay?=
 =?utf-8?B?RmRIaUc3Kys1R0ZGVVl4NGw0WEhLRkRqS28ycnkycFQrc3d5UzlsM0w1Vjdv?=
 =?utf-8?B?emtTRTl2aWF0a1RrMzRHK1pISDRWUllQYUJjZVpud292Rmx1UXpCSWIzdThR?=
 =?utf-8?B?TCtaS0VsZkdlWXcxSzVuR1JNQW5heHlXcFA4d29IMzdDYVdvaFNIa3hzeUhV?=
 =?utf-8?B?Yy9jcE14Y3BUN3ByVjVtdGFZeVZxRm5tM3M3Tk9YWTF0TTlrczlWcXpjRXZh?=
 =?utf-8?B?WlErYVpXZ2lpdkRkK2V3V3NleTFvMXd1OUp3L3pHaERCUlowTWZpWCtkclU2?=
 =?utf-8?B?aUdJNXNzSi9FV25UTHcydU4vVUdBNzJmUi9rMUNHT1VhN09BV3FzTkdHTDBk?=
 =?utf-8?B?TWNSb0t0UmdWSVV6RHJEZGF0NEdQUEh6WjFWNDZYOWdMZG1ORjVCRnFEanhP?=
 =?utf-8?B?dnJyZ29HNkFWdk1FaWM0MG4yNldDRkt4bVBudnEvNFJuZzYzRngvcVppNmc3?=
 =?utf-8?B?NUNDU0p0TVY0ZXhWVVRvZ0hXd0xlbTNjRjJHZ0tWMXhyMTR2ck53WFgxZXZn?=
 =?utf-8?B?TldDUk13endXRmV1Z2NiNzBaaFlpYzJHOUQ4REpNWEd1VGNqbzJPUk1EZlpv?=
 =?utf-8?B?QUQ3b25Jc0VBWDRxWDJlS0ZldVVuaEZ3NDdnZ3ZDWmsrWlMwdk5mUmtsRllq?=
 =?utf-8?B?cDFKMDg4QWdUNys5U3dJeUxleUpLK1ljWjFSMUZaUDg3aHRQWERvNFM1NUJp?=
 =?utf-8?B?a2p6amwzMkwwM09rNGJtVWpZL05pb1pNMUc1ZVU5Q3hNSHovd1h2SE40SE9s?=
 =?utf-8?B?M2JYbDBNK3JLYlBzaHNJUEI0OWI0OVhJNTFDT3Q4clZEangvZGdISko0MGFF?=
 =?utf-8?B?a1YvK2JsUkxPNlh0ZklPeWRZV0VwRnd3M3Q2a2Erb3o3cXB6WmFlV1ZOVEZn?=
 =?utf-8?B?YnU0b2FoUlVDbzhJWllGUzJTb1E2NUU3ZUxoQ1JIVEd5VG9WRUIzUlRtMnhQ?=
 =?utf-8?B?QXJKd1lFWWZHcCtib2x5aDZEUm92eE9YUHJKdDMrZTRZdERreEo4UHZEclZm?=
 =?utf-8?B?MS82cWkra2R3WThEMEFBZzl2VVlGcHBkTTNaVmtsNE1TSGJWS3dpUWFWTmRO?=
 =?utf-8?B?UmJHbEtaWkdYdkd0UmIvNiswd2UrcWpRdGpHUVhBWmdadUZQOHY2K2ZSenVP?=
 =?utf-8?B?RElWQkNrZXdNckVtNUlLb3ZKc1NBZ2VydUZ6a0JlMng1RnVRUlFxeno0Qk9t?=
 =?utf-8?B?WGxWN1JSSzh4RC9PQndva2lURnF5Z084TG5sSzFpU3lJRmV6L2E0eVA1N0tn?=
 =?utf-8?B?ZjI3LzM1WTltRVRqcnBtN3FDMW1iYjV1dnZyak51a1g3djNiMHlKaVVEeHdl?=
 =?utf-8?B?Z3Y5Y3JxcExWU3UyVXBkM2ozdjE1TXR0UGRueHpPblNTTHpTL3hpNmdOMWkx?=
 =?utf-8?B?eHAzTjluYktoLzFCUWpzYmkxZllQWDFzUXoyN1B5Q3N2TUZMbDVkK3JWdG04?=
 =?utf-8?B?VFVEVnVOZnhZWDNpUVZUdVVkbEd5UzNtL2NycE1IcVpvMTJuNTBGWVhKR0dY?=
 =?utf-8?B?djh4VlIxemxKTmpFOCsvenpwOXEveDFpOFNSOHhwZERxZUNmeko3c3ZHSjQ4?=
 =?utf-8?B?RmVnY00zdUhhanpsUmpMU096Z211Q05xelBqc3NqbTI2UEwwcjRSSSsweVFT?=
 =?utf-8?B?NlhLQStTQW1iN2N3UXB5RGsrTmFCa043L04rMXRFalZ6bHVOamlqNFRPemtZ?=
 =?utf-8?B?K1hEaVEyL2VBUU91eVVPeEpYbVpJTkdWYjh3elFrT1RwTk9ZUjFSbU1yY25m?=
 =?utf-8?B?NDd1cVFDN1JHdFZPSmYwL0tQZlU3d0k3WG9xMm85V2tpSnBJOThzSzJzSE9S?=
 =?utf-8?B?RmJ1ditXMDJEbUNyY2RwU1ZrUDlhbER2NldIUUVLNTNNYWljY29KVGk0Mmty?=
 =?utf-8?B?MC9PV3I0RS9TWGNUUlBLSUgrckV6ZVBoVlNBbHB3WTZGMWFJNnlqMVVDQ003?=
 =?utf-8?B?a0hJM21NTlVpVVJyR1ZjZVR2UmgzN2JvNy8zTHMya2U3YUZaaFdQR28yTm50?=
 =?utf-8?B?ekdCUG5QVWtLSEdvcEFOZHZHRTRweGJjbjNwa0IvWjlBSmFxcXBFQT09?=
X-Exchange-RoutingPolicyChecked: EbFZUQ+hWUZymx9DIePtDhTYyWEfzUDKGp2MMhs5NB6TFu+RI+BOisdA2hfA0x+Fm1+7/AyftD12RxJdKlE0YtkAqRXbroNxsf+dtSdvKrKCcniGaufj/Ar7q+fwBXcUBfufSrtBOh1lT7I2yvk8g+mDng2st0Rv2GNYfxTmEBQMfY8aqKgpxpvuMwzn05feq+/SplhvPEsfW82qeLAmwyXt8pKph/84wG/NdLJoXU1IxqleBMMbgmEAG9mGGOxG1F3f/QIHR4C7Y42Y4hFVuoUr+b0dl/3sVlE4Ef2wDIzhQg4wNiW9Uho5+PSnxbZ9GpCcLmjEeU0VHDdwV6rULw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed8fd1-a39a-438b-d06d-08de9f36ca09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 23:44:40.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIhYMNeuDQmYI1+CsM7ae9QT2w3kWDv5+HSYi9jSehIPaGH0tvDmedZ6PC5p4evGfooQOb/u4pGHvWnT6xnRyWKyo4SVG//u546b2qXsNTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B70E4434ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/2026 12:25 PM, Li Li wrote:
> Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
> handling a reset") prevents ethtool -N/-n operations to operate on
> detached netdevs, we found that out-of-tree workflows like OpenOnload
> can bypass ethtool core locks and call idpf_set_rxnfc directly during
> an idpf HW reset. When this happens, we could get kernel crashes like
> the following:
> 
> [ 4045.787439] BUG: kernel NULL pointer dereference, address: 0000000000000070
> [ 4045.794420] #PF: supervisor read access in kernel mode
> [ 4045.799580] #PF: error_code(0x0000) - not-present page
> [ 4045.804739] PGD 0
> [ 4045.806772] Oops: Oops: 0000 [#1] SMP NOPTI
> ...
> [ 4045.836425] Workqueue: onload-wqueue oof_do_deferred_work_fn [onload]
> [ 4045.842926] RIP: 0010:idpf_del_flow_steer+0x24/0x170 [idpf]
> ...
> [ 4045.946323] Call Trace:
> [ 4045.948796]  <TASK>
> [ 4045.950915]  ? show_trace_log_lvl+0x1b0/0x2f0
> [ 4045.955293]  ? show_trace_log_lvl+0x1b0/0x2f0
> [ 4045.959672]  ? idpf_set_rxnfc+0x6f/0x80 [idpf]
> [ 4045.964142]  ? __die_body.cold+0x8/0x12
> [ 4045.968000]  ? page_fault_oops+0x148/0x160
> [ 4045.972117]  ? exc_page_fault+0x6f/0x160
> [ 4045.976060]  ? asm_exc_page_fault+0x22/0x30
> [ 4045.980262]  ? idpf_del_flow_steer+0x24/0x170 [idpf]
> [ 4045.985245]  idpf_set_rxnfc+0x6f/0x80 [idpf]
> [ 4045.989535]  af_xdp_filter_remove+0x7c/0xb0 [sfc_resource]
> [ 4045.995069]  oo_hw_filter_clear_hwports+0x6f/0xa0 [onload]
> [ 4046.000589]  oo_hw_filter_update+0x65/0x210 [onload]
> [ 4046.005587]  oof_hw_filter_update.constprop.0+0xe7/0x140 [onload]
> [ 4046.011716]  oof_manager_update_all_filters+0xad/0x270 [onload]
> [ 4046.017671]  __oof_do_deferred_work+0x15e/0x190 [onload]
> [ 4046.023014]  oof_do_deferred_work+0x2c/0x40 [onload]
> [ 4046.028018]  oof_do_deferred_work_fn+0x12/0x30 [onload]
> [ 4046.033277]  process_one_work+0x174/0x330
> [ 4046.037304]  worker_thread+0x246/0x390
> [ 4046.041074]  ? __pfx_worker_thread+0x10/0x10
> [ 4046.045364]  kthread+0xf6/0x240
> [ 4046.048530]  ? __pfx_kthread+0x10/0x10
> [ 4046.052297]  ret_from_fork+0x2d/0x50
> [ 4046.055896]  ? __pfx_kthread+0x10/0x10
> [ 4046.059664]  ret_from_fork_asm+0x1a/0x30
> [ 4046.063613]  </TASK>
> 
> To prevent this, we need to add checks in idpf_set_rxnfc and
> idpf_get_rxnfc to error out if the netdev is already detached.
> 
> Tested: implemented the following patch to synthetically force idpf into
> a HW reset:
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 4fc0bb14c5b1..27476d57bcf0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -10,6 +10,9 @@
>  #define idpf_tx_buf_next(buf)		(*(u32 *)&(buf)->priv)
>  LIBETH_SQE_CHECK_PRIV(u32);
> 

Patchwork, and likely other git tools based around plain text mail do
not work kindly with an embedded diff inside the commit message. Could
you please resubmit with an updated commit message that doesn't simply
insert the raw diff? Perhaps you could indent the diff by a few spaces,
or simply describe what modifications were required to force the failure.

Also you didn't mention the target tree, which I think should be iwl-net.

Thanks,
Jake

> +static bool SIMULATE_TX_TIMEOUT;
> +module_param(SIMULATE_TX_TIMEOUT, bool, 0644);
> +
>  /**
>   * idpf_chk_linearize - Check if skb exceeds max descriptors per packet
>   * @skb: send buffer
> @@ -46,6 +49,8 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> 
>  	adapter->tx_timeout_count++;
> 
> +	SIMULATE_TX_TIMEOUT = false;
> +
>  	netdev_err(netdev, "Detected Tx timeout: Count %d, Queue %d\n",
>  		   adapter->tx_timeout_count, txqueue);
>  	if (!idpf_is_reset_in_prog(adapter)) {
> @@ -2225,6 +2230,8 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
>  			goto fetch_next_desc;
>  		}
>  		tx_q = complq->txq_grp->txqs[rel_tx_qid];
> +		if (unlikely(SIMULATE_TX_TIMEOUT && (tx_q->idx % 2 == 1)))
> +			goto fetch_next_desc;
> 
>  		/* Determine completion type */
>  		ctype = le16_get_bits(tx_desc->common.qid_comptype_gen,
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index be66f9b2e101..ba5da2a86c15 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -8,6 +8,9 @@
>  #include "idpf_virtchnl.h"
>  #include "idpf_ptp.h"
> 
> +static bool VIRTCHNL_FAILED;
> +module_param(VIRTCHNL_FAILED, bool, 0644);
> +
>  /**
>   * struct idpf_vc_xn_manager - Manager for tracking transactions
>   * @ring: backing and lookup for transactions
> @@ -3496,6 +3499,11 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>  		switch (adapter->state) {
>  		case __IDPF_VER_CHECK:
>  			err = idpf_send_ver_msg(adapter);
> +
> +			if (unlikely(VIRTCHNL_FAILED)) {
> +				err = -EIO;
> +			}
> +
>  			switch (err) {
>  			case 0:
>  				/* success, move state machine forward */
> 
> And tested by writing 1 to /sys/module/idpf/parameters/VIRTCHNL_FAILED
> and /sys/module/idpf/parameters/SIMULATE_TX_TIMEOUT, and running
> idpf_get_rxnfc() right after the HW reset.
> 
> Without the patch: encountered NULL pointer and kernel crash.
> 
> With the patch: no crashes.
> 
> Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
> Signed-off-by: Li Li <boolli@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index bb99d9e7c65d..8368a7e6a754 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -43,6 +43,9 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>  	unsigned int cnt = 0;
>  	int err = 0;
>  
> +	if (!netdev || !netif_device_present(netdev))
> +		return -ENODEV;
> +
>  	idpf_vport_ctrl_lock(netdev);
>  	vport = idpf_netdev_to_vport(netdev);
>  	vport_config = np->adapter->vport_config[np->vport_idx];
> @@ -349,6 +352,9 @@ static int idpf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
>  {
>  	int ret = -EOPNOTSUPP;
>  
> +	if (!netdev || !netif_device_present(netdev))
> +		return -ENODEV;
> +
>  	idpf_vport_ctrl_lock(netdev);
>  	switch (cmd->cmd) {
>  	case ETHTOOL_SRXCLSRLINS:


