Return-Path: <netdev+bounces-296746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fYIzOB4/J2q8twIAu9opvQ
	(envelope-from <netdev+bounces-296746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:15:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C1965AEA2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:15:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CoToDqiS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296746-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296746-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD6ED300EC71
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB535F5F7;
	Mon,  8 Jun 2026 22:15:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC68333441
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:15:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956953; cv=fail; b=vCq3OmrW35e/AoAJChJgCQga2rNrx6xzv3uHHMYABgBVzOC9rGCIP6jcCNdsNqoeI7r8V//hcyZEA+IQqp6P8oPpMnwXShOvkdpHa9fSRnebvkxHVMy7I0wfP/VCasyZaX2P6qxpC095XVTgiLrZNil/8RN38NnFwL6CPi+n6r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956953; c=relaxed/simple;
	bh=CVeOgTQYkZXdVFr4nLrUFoHanXtdb/VIA78AMYSdp/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j/SnhETG5aBtNYVZhhAm6F5EdTDemf2KiQOt8LgD/s+0pshGQd1R4dEzBDohfkBGsL7mwLRQSY6xgjwm0ULx8iJPhz/l9VNpYN6z7p4qFJ7o9msoS3op73HiYcQbEibWN1W5jLAKQO73QE5fnTgZGKEn3j3+EXvR1PtI7P60eX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoToDqiS; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780956951; x=1812492951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CVeOgTQYkZXdVFr4nLrUFoHanXtdb/VIA78AMYSdp/E=;
  b=CoToDqiS7c1bHZsCQfBEZdCsafYfZi8wZmaXdq2adSow498wzWljn/Fu
   mR0e0Rrzsb0X7VvqwE86CX3+FRi8wvqg2DuoHMparjmHWIrBDvoojTgCW
   cOo0aSjcx+tHUBXFXE/7e+MbDoyxfKpxKD4QuxdkVhigEMv19Fo3bpPFg
   04F4bNOEWK6N6HYN7LYilSAGG8uey1sAfcEQ/g0UiOTF0Ek4cHD/UFnz9
   OAp/Sc5+Q7avgE+qGUswRKQ8ce7IqPdZEA9ctkRJ7DRzPbkFs4WiwSmWM
   ghU7QjQqbpJQi42H1jXapHSMoKxtHRolQKI0XXBRY95FBSNdzwe6BpEkb
   Q==;
X-CSE-ConnectionGUID: H/iKCaFtQiKPmgwClkvyAA==
X-CSE-MsgGUID: WIbjJngVRtW8umpVRRzATA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99124160"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="99124160"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:15:51 -0700
X-CSE-ConnectionGUID: nqlajjXiTBGEi6td44sGkA==
X-CSE-MsgGUID: XO6SrA99T1CVi14eKG3UUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="249956932"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:15:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:15:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 15:15:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:15:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJgOWPDaJNfiDH7gSPR6ClcQDODh3dv7hteRk/gxtW2MaZXXwHkSfnjaXUKHpad6V9UTnsiL/XLhMr0aNNbPkK4xl+YNj1AgfZ5hXAYR4gkWeGvKxnT7ZQAEXjloniLXfQNJqO3j/+QocAfYARfl4jZoHFBcMiY662cmcKsSbz85seYiCzJ1chLv7VWLnLpFgkYB15219TygSwKFqN7jVymT66+Z9MASf9IS1ytCRyxGmchtq3T5gTjNOt2AiBTTg/vaIDrs2gDon48ExL9YtRw93z1gdDj2UJ8FqVXSh+1DipEm5q5FBdzXKx1/AGV031BuotVnu7j/1Ym7c5NJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLPgXnqjMJG6q/8R/exeZJTCiMwj8xgS5o8gakwD4yQ=;
 b=bp+W3R2i/CkQRR+qBI4vnOvUv4CrNVBwx4Ky5rWNJwfRJ5ald8jRaKFxl+ttsrSlasugBFVZQOK5TYNS9XY/7YlwjRHG8bRHqsw/pPCOcucwX0nwriTuMk+yFxf0D/xjQvqWD90OYVOmwN4cM7MycoIMlc5z2dClQowA009bsf0n7kOMR4qwbNRfD3c+iH/GkiGoyVvUNbNR+0cg8TVOOIVNwDzPGyemu8sy6BQh07CpqeZQdo1fxL1HLCVIQ3ADsnzJ8mnmS/AOuEKYR0Dy6ZulcQlu5XOZCp80fxeYVcDzqOscX9nm5Cd5yFa5W/I+7TIBNKFdlHQlwdVJchgMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 22:15:48 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 22:15:48 +0000
Message-ID: <ce45017d-8caf-4b4c-b04a-44806bcf5e72@intel.com>
Date: Mon, 8 Jun 2026 15:15:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/12] net: ethtool: optionally skip rtnl_lock
 on Netlink path for SET ops
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <michael.chan@broadcom.com>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<joshwash@google.com>, <tariqt@nvidia.com>, <alexanderduyck@fb.com>,
	<willemb@google.com>, <kory.maincent@bootlin.com>, <sdf.kernel@gmail.com>,
	<jakub@cloudflare.com>, <nb@tipi-net.de>
References: <20260605002912.3456868-1-kuba@kernel.org>
 <20260605002912.3456868-6-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260605002912.3456868-6-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM6PR11MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af058fb-4e9a-4f89-46af-08dec5ab7e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iwNtNm8+zDu/CXwPEYvzbNm+ql99QT9lpu7MQHWNH1vu8oUyrgoVS5CNySJ5x9GgcqFXXUjw+bBLwjRZRJwawJXJs0aE22WKjcFGRGujOwHNGLD/Jz17bDAOW2EV83RthDmB31XYkYDh2tqfsffP/rnuLQAMFpUxNXH9c8nKDEx+WDW+EJxP9FIfzPR1x0PBhhp1XgYDaLQg1Ra4KBxPbxvnFXUEQNWN/OckIi53F0XFmTyVogy567tUj8fnqncaFPH7oprBrrbVLzghfG58H5UD06sZNbcrpaMvIl778e8pTWUD68Fk36HuKBrZzH6OOetmtC47riDfdQblnOdDlTg83zFElNRXH/b7YC7vUZX/Z3CM5SzfqEdU2ntJoOxiF1F3JAd90gfRuKBeTSntt26AZVjxDnkdmzPpgRL6vT3J7RHGpsa07aNEcLj+aYj8duzQOtRGHkN3S7bJQwUHLeej5m1SnA3craK0Ipi5H/2O5ezVCA45AjMj/EsKtQTOFNtjUO5DN3Aozx7PjSFSYbBRrVJW2ap3PD6XksYn4TXV7cGwQqskbNULHV3fTViN7JciWtm17x4lx8Oz258BBJPxqYvZ1nZK86JO/YMQN62HWN+DUbVMytL4AAWMernUFY/zWnzuAGV3Pgk6re3hBqu+g8ybQUiJgWDVrRhVEPU7tuBPKHS2+5d0sTPrJPpT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVI3RWVTa01JT2dvZDljeWV6aTRVYTZwamZBVzZSeDVucDdKbWhaaUFnTGM3?=
 =?utf-8?B?TE94UWdkNUlRb0VqMW1BWmdwNU1UTVUvRmpzdzZ5UXVUbDdGZWtFWDVRcXJS?=
 =?utf-8?B?M1U4TklEeTR4WTNtY0hadGxkOGVIUkFGNHg1d0NpWU5HbFQ4QVAxV0x1MG82?=
 =?utf-8?B?NEtmZC92eC9QNHl5WTJYVEZHejNldk1MNkhUMGtJV0U0Qlc0MFVXRlpnUjU0?=
 =?utf-8?B?NDdqYTcrK2NXWUFLV1Q3TXlSVzJncHFFQW1RNnJHemxvbEpsNzJneTVVR3Rl?=
 =?utf-8?B?NW00b2xOUFB6WGRZNzcrMHlJSHVia2pZcE5RVExoU05VajZIVkJuZVRvZ3Ba?=
 =?utf-8?B?NGlqNEY5Z3BsYmtweTl5d2orT0FsNC9MNHFIeGNJSFo5UHRyYkp1MEJnbHA0?=
 =?utf-8?B?dnNWWXE0MlhiYk5BZVRXOUNNeWNiWG5Zb1B6L09WM0c1bjFvNUdWbEwzdzBZ?=
 =?utf-8?B?cVp3WDVHQTEvL2VSLzk3Z0hjbXQ1VWJvZHBYZkhSSUdUTHRFTmYwQkhFem5x?=
 =?utf-8?B?UUVzdzhqUEVEYVgvbUlwTEJsMjNMeSszaFVpOVZiZkNpeTVDUzVOZm1XNEpq?=
 =?utf-8?B?V2pxNEYrWS83RkhJWGhQendwWFYwUGZFa0kzVjZaUDBSVXp5NVc0cDBjV2lZ?=
 =?utf-8?B?elRrVjlmK0Eya0xGS01UZVA3L0QrdkFOZzVxaDJ3bWh0bGdCOVJCYXBzWnJr?=
 =?utf-8?B?cmwvWTZlN1NtYVNsOUQzTkRoS28wRmQwTVlxQ25GUUZ2ZDBDTzc2NWtLVGNT?=
 =?utf-8?B?U3F1M3MzTDh2NHQrN2JVOTR5SDVnU0tNMHI5WFNqemtaRlhlYkR1V2wwMHlE?=
 =?utf-8?B?ZjdxcTRCNlFnK3lmMWE1dkczWHBUTnVGc04rNVN1M29tTkNRcE0xSUcxUlVh?=
 =?utf-8?B?SWJRbldLK3k5QXR1VkhwMGF0VTNkd0x0L2VxR3JKMjFSeDV3SHlDRy9sbWNi?=
 =?utf-8?B?ZWRxc3EwQjlQaFp0eFdlZlozeEwwU3EvOVZkSnpRNHA2VmtvYm5aTjNJWlZ6?=
 =?utf-8?B?RXQrOVRXc1hNUWVXZlBaM2NXaVB0NWxuclJPMHNKL1MyNGNIbllBV3hXZHli?=
 =?utf-8?B?bnVKQmRIeUUxb0J2d3lCNzFGdmxCTVV1L2FJdE52U295cW5tMnMvZ2lXSmNr?=
 =?utf-8?B?RkJxZnRRQzNQdXhoSzUrS1UrRkJaOU5JS0tIYUF3NENhNGEzK3hlUnhTL2x4?=
 =?utf-8?B?MlVKbWJ4MXBYaGdvVFp5c1d6SVNxMjRVVjMzM3ZEY0UvRmd4R0FJb2Nybmxt?=
 =?utf-8?B?YWRGYUpaTndpZkZvT2NjSXM5S1NDSDc0ZWtzS1RqTnQwNFI1d0Z0TkRvOElY?=
 =?utf-8?B?V0xHRmFTd1A0MTVUOGNNclN5dWZzcWMyMVRrUkpRRzg0NnpvaFdXU1RGK093?=
 =?utf-8?B?USs4NjBqbGd5ZWMyeHdvQk1FNHkvR0pzSFQ3ZzNYVmhSSkpnUjUwRUFkR1g2?=
 =?utf-8?B?aEZnOU1VYkVweDMzT2padm9kL2JqRUlkR01EQUF4bFhCRkFmSXFrUXhISEhn?=
 =?utf-8?B?dDlWbXBlOG1pOHZ0T1ovVjVqdnRsYzhScllrYzRnQUlDMmVmM2Vtd1NwS2FV?=
 =?utf-8?B?Y0V3Y3ZubUZDQkFnWUhCSEZ5a0NENzVTZWZkd2Ixa3oxeUZZVmhyWHpQNWFH?=
 =?utf-8?B?TTdaOTRFR3czYk9iNjg2NXhnR3lUQ1U4NUsrYjkzOVlzdjdDN29OdkFmQ0hx?=
 =?utf-8?B?Y3MweEdJODJ4YWpxaWZGc1Z0ekRSNWR6NFk2M0EyVGk5Z1kvT0E2WmNBL2h3?=
 =?utf-8?B?cC9JSTMzNTIvNC95eFl6QjZLU0ZIZURoV0VFbUlkK3BLdGR0QURFaXp0TGQ0?=
 =?utf-8?B?elUxWVp4Q1ZvUTJJaUtzWTVmZVJxQk1TVHpqNEhFTVRzcnphWnU3Ujh0QjJu?=
 =?utf-8?B?SFMxQ2hKM09oekhia1FSazQ1eVNyV1N4czJxR1k1ZVpJU0RPYW0wdGozOTFU?=
 =?utf-8?B?WHU4QzZxQW5RYmFVNVlsVDBlRlhmbElSWTNVZ2o5OVFHdWpWSWpEdUJUbVUw?=
 =?utf-8?B?Qi9xOU1JTXREWlY3Uk91SXRxYWh1bUZlNW02TGNCVk1zdjl1Wk9KVE9CM1pI?=
 =?utf-8?B?dnhDSCs4bEpUcUFDMWNlYitndFlUUWhYMHlrOHZManEzNG5XdjY4TzJrMkpl?=
 =?utf-8?B?L1hyYy93TFdxM3B2eTVQVVFQSzJsWFJTYjIyYVF2a24vTEpaMEMvczA0Vllh?=
 =?utf-8?B?WWhjODBBNEJaNUxieVhYRUlSbHNydzNNbXRib3A2d21MVFlHRFNkVlA3VE8x?=
 =?utf-8?B?Mm1SNmhiR2c5Nk45M1ZtVmpKWisxOFhid25mSm43TEZnVVJsaGZ3bXRZWEhG?=
 =?utf-8?B?TnB0bWNsaVhMOTFaSmhrb0JrL1dhWEpjY3h3cmZmU1BTTnl2ai9hQT09?=
X-Exchange-RoutingPolicyChecked: VkmLF+EZ5K0xbKODriG8vkfAgr82OEUOr3sYkqtf0hMn+a/FBRG3EyuCRBGNyN5bDIn0G/cHd5pFGifjqW4gggm6eP+FlnmRqEcok6ePG6TeN0NLB2m3uHjbD02B5kRBBEs/ds/l+5khNYYKFTm6kyY/yRcMbMR3pOxpRFO3Dha29Qlk4rgqOMJC/LfpSs8yO8X789HZPkxw8KKtudInD+Ac1gBvqFnaeX+zINLT7DSTBSLU53XVkzDu7eCEH7mt6k2ma1K7FRUKjsFRq8AVmuztoIX4m0vzKDTR9mLbLndhQiOgZtkALCsHjV1JYDll0Qb8umhPnaknVcLcDiVSig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af058fb-4e9a-4f89-46af-08dec5ab7e4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:15:48.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3sVfloZx9jAlcRj6TsXjhroBPn62LYE4WK7l87jRel8io6/DLvIwkBG9yEy5gPOcNew8omns3KJw0JINre3ZIJGbl4jdu+45TrJ/3LQYsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4596
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296746-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0C1965AEA2

On 6/4/2026 5:29 PM, Jakub Kicinski wrote:
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 1da49161d36f..74c8109b0cf3 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -935,7 +935,13 @@ struct kernel_ethtool_ts_info {
>   * these bits separate, per GET and SET. GET is much easier to "unlock".
>   */
>  #define ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS	BIT(0)
> -#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(1)
> +#define ETHTOOL_OP_NEEDS_RTNL_SPFLAGS		BIT(1)
> +#define ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM	BIT(2)
> +#define ETHTOOL_OP_NEEDS_RTNL_SCHANNELS		BIT(3)
> +#define ETHTOOL_OP_NEEDS_RTNL_SCOALESCE		BIT(4)
> +#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(5)
> +#define ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM	BIT(6)
> +#define ETHTOOL_OP_NEEDS_RTNL_RSS		BIT(7)

Whats the reasoning for changing order here? Is this sorted somehow?
Would it make more sense to use an enum to define the bits instead so
that patches don't have to do a -/+ of the same NAME?

IMO not really worth re-rolling the series over, it just made it a bit
more work to read the patch as I was reviewing.

