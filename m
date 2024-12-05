Return-Path: <netdev+bounces-149259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B49E4ED3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AC3164BC0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F581B6D1F;
	Thu,  5 Dec 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQVKIohP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D91B4F1E;
	Thu,  5 Dec 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384728; cv=fail; b=L3RHnXJRM7methn0kidPsJ4qfuESGAayAwF1A1cC26LisUcrIkJfzOk1gevvE9dqgNKB5RIEBMjqCaVsr/kNVF2bqfs4NJrdt7vKqMPOQo1T+kh0pq2X6+DuaQJfILATd9hch8jyKuJ3BblQzmMoc/ndBr+fvF8MRPglIYKuhvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384728; c=relaxed/simple;
	bh=2/8FAPFdjtwDYLsCO4B7QqMem2cBNnI6ICLmFgkU24s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fh0OT/9fohmsRo0uBqLgmS8O3qFRkoKWg4bKDjZ+w+Ea9zipdgBIG9OaHugFLmb0EvrCnVqqizNIJAFLgSKBT99gIdPl9/hEJNEDjsArcNzpAO0KAk3P1PeaHvoFlawClyu8ybjKSWSvqnexnGf2Tkfz1odlizuM0mrk5llVp3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQVKIohP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733384727; x=1764920727;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/8FAPFdjtwDYLsCO4B7QqMem2cBNnI6ICLmFgkU24s=;
  b=BQVKIohPdSSnilKheeljPrtEYtq0OmJEFtWk19FCofDNwvNW63eMMrF1
   EfoDRmDruPe9/NMoUzvAjL1sQY5ba68YSrgZ9eBf8EbeqA1Mef5nULinX
   mBjdGUxZqgTCissuru4lZEhP59sB/ibjprXELmtvVWMhYts7rqjSBLk8p
   6MUgEX3IfJT5odyc6UDJDFU0XhUwsZifa5XB4yr4k8UTwJVaWHPevrqfT
   3kE600wZdFkYqc4HqnWQ2otffIozGnDCGYbFqfhtw7uJo14y7DbPLJFSx
   c0j2GAwzebuI4RcbH6yxZBXisD6kRRINLxYOM/1wsL11FY3kZCHXunM4M
   A==;
X-CSE-ConnectionGUID: Si1jbG7KTKaVSRM5glvtQQ==
X-CSE-MsgGUID: xgRSu10KSPqiUTmnyhKooQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44710352"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="44710352"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 23:45:26 -0800
X-CSE-ConnectionGUID: RaxrCoHMTbSdV7n/e5iJ7g==
X-CSE-MsgGUID: Jz37F3GHSQaGVZAvjEEhxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98825240"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 23:45:26 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 23:45:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 23:45:25 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 23:45:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfHWC1rHqm8CCJ6vX4UuyvUeEtSgrl6DqdsztzuPRTrIrNPRnGyD2tmxCvN0JhJTPL9iQnnqS2uQzfz7CGNxDJrKn+ZjK+O4qy745rQb1LBJj+L9KVyoe9hyeM97TlFxc7pfdRlkl4CO9EFzVuNlS1nrJj6xhcb4TwlPlMTEtTwEu4Qm982rtyeTJ6WuATIcwgtyjNT7kbZHGsVyUPPl/ASkXjN0krkv1Fesuyy2sBk5CJP1vpq2/70+XJrfKP//H7lotjP/d/lYq1by+PW7tgPzvl9ewdhHRPkFTmJXYfCTjIaHBc1olWeRiEbWlly/M/gaNOxmAr1HQYwLP7Xuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VgMEvAJQksmZsbIbFuJNXzBrLxziSe6f0P2MNMuQfs=;
 b=xLCZU/dRo3nP7zD4wayHYsa0ZlpSU0UQG8TihdF9j1xw1i0lAPjeOJhmguQ4Ffx/HtctBliCtHoudI2CjzVJtF3I9BCf+aKT0r39fmn39ukPU0nE8rsh0uieM+CQSFk1L26C6VZH7pJnq7VTV8YPIa06WJTCjqQQ9Y97u7uDAFD3+Bu4yoWdPG3Cby65zN9C83AxAWcGbI9K/8sJ9NldzDKkjYPAWGjqv0+omRiUIb+Wq57Xl4dVpRNCGdEgo1svWgMsc1LvBRCFj3sXvCgKGKF04u3ei5niUEwDf+Lfsxj9GHfA9WOYtR50xB/bBhZZvvi83TTPwbgGneoDoxkqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by IA1PR11MB6322.namprd11.prod.outlook.com (2603:10b6:208:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 07:45:22 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:45:22 +0000
Message-ID: <87926a26-3f9e-4094-b72a-d64ab9176cde@intel.com>
Date: Thu, 5 Dec 2024 08:45:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/7] net: ethtool: plumb PHY stats to PHY
 drivers
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	<linux-doc@vger.kernel.org>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-2-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241203075622.2452169-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|IA1PR11MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ea3de2-757b-4158-7d49-08dd1500c623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGtFZzZtOVZvU3hvdk9jQXRzOWNId2lrTDhYdVJuSERLMTRGbTV0OE1QaEJz?=
 =?utf-8?B?Uk14eVF4aHdwa1FaVHZtbDdJZGZUTmtRL0tlci9mYUJURGFsVWhXaGhyMC9J?=
 =?utf-8?B?Q3lHNTdxMisyM3EwcG54cFlUeHlpTFg0cms3WFpoYmVTNjlYODZLSTFsekx0?=
 =?utf-8?B?ak4wN0Z0R29yaENPMUhSRVhScytVbUNJV3Ayb0xCTGloYjJ6K0hScDdPazBu?=
 =?utf-8?B?SThOTDBaMG1EcVBVZG5wb2VZVHhqY1V5Q3VXTXBSQjU3SlpFb1FMUmVwbXc4?=
 =?utf-8?B?RG1mNDU5ZjE1N2xqd0VvOXdYejdtdzRoUkZnZXR3TkluZlg3NXRpUjlpT2pz?=
 =?utf-8?B?RW8ySnZueElQMzcvVERFL2dnSjZQbTV2eCs0ZzVJUnArZTNTQ0l6ZFFmd2Fa?=
 =?utf-8?B?UFh3alpDQnBiU0IrRnBncVhkdDVjb2cyc096RS9JMXZsSTczSlhUTXRwQ0cy?=
 =?utf-8?B?QTVrS2E3ajNVVGVlVjlGUEZTZzdZa0UvN3daNzB2Zzd0Um9MYXcyQnNsamFY?=
 =?utf-8?B?WGZsZ1Z5MWRhbDE0L1ZwcnJrUEk4UjcwS2I2TG9FVHpSTTZBc0tsYkh0Z28x?=
 =?utf-8?B?RC94VHRpREljRVRNUEsxd0RudVQya2dLNlUvZEUzMlF1T3QzeVQ4TEUyUGpz?=
 =?utf-8?B?M3dmOXNiVDZJOHNjd1ZjZGRaSGZKRzRWT0NqTTI4Um55MXh3K3cvajFCU001?=
 =?utf-8?B?UkhPdTZPMnViMy9tdDZjd1REY2x4Qy9MVlRZQUF4OE43TmkrbUM4U3Y4ZURS?=
 =?utf-8?B?ZWVQYTd4eHlad1RiT0FZVytHMzFKVGlkWGIvSUp6ME91bnhxK0hzMFVnb0Mr?=
 =?utf-8?B?NU45OUEzZ3RrU2lkcmJWWi9lUmYyZHhnQlNWckgzeXVPZExIRXZGUitwSDY4?=
 =?utf-8?B?elJ6ck9ycjlONjBEMXUxQVZkd1dDSHpqZFhWNGNBMVN5K1Q0dW1zWENKcjFR?=
 =?utf-8?B?TEpUZk9lYUZSYnIxaDVvMGlvMkJJNFVNRU1TNXhlRnVQSlJ5dHM4dVdqUDVF?=
 =?utf-8?B?cmhhWDBweUZ3OFFLMU1zS0lCZzZHemJlTERMTTBzR3haZDVtTURCRFBTam5D?=
 =?utf-8?B?YnBZcUpLcmxKc2R3cnpxQ3N3R1NGNG9XZFVLcktZYTIrWnZoTkpXQ3FDWHM0?=
 =?utf-8?B?ZVBIQVpEaEtQQTdCWjgrZUt3MmVSaXlvQTM0ODh6Sk0zeGJoMWo4ak9taVc1?=
 =?utf-8?B?TVJjaDFEanBGUlo2TmhFSGtDd0VBZ1Q2UkZ3dzFpQkpjOWpUaWpqVks1MXla?=
 =?utf-8?B?cjZ4Y2FGV2liNXBTaGhham1FTUE3aHc3WDdPNGlDVURNamJxZEJyTlFKRXA1?=
 =?utf-8?B?ZWEyV3Qwc0hwVXBGcDNoc3ZrNWh0N3BOSEU3VGNvWTB3ZTM1SlMzelNubEVY?=
 =?utf-8?B?V1NpNGlwWVhTQVRHcTJPcFJwUm55YVZKOU85LzEyUWhkRm5JdDIrL2lBTW10?=
 =?utf-8?B?Ulp4VFltUnB6M3hZKytMM1g1eS80WUcrWEQ0SG5aa0w0elNXVlJPMUZBb3JW?=
 =?utf-8?B?QWtnb2doQWRiSVdseU1wQ0szTUowelhCaVVzbk91ZVlXQ3hSZmZYZFVPaHJx?=
 =?utf-8?B?TlZjUzJldXI3bXp0OHJWcnNMaW82elAwVUZ6Vlh0M0cvZzFvdHhHWmswalYz?=
 =?utf-8?B?bUdpTTZVcUs4NHV0THpoNHZGbS9Cb3d5ZktkUzBCZ0NNa3FvTkhWTlR6amJ6?=
 =?utf-8?B?cUVWYXgxbU5sc0tlTE1RNi9DSkFVM3dHZXN3cURpbStENDQ3RU84ejVETWRO?=
 =?utf-8?B?SmZsV0NYaVpnYm0ySlNZaDJNeHlOR0tjQVVaT25oU1RTck1tZUpCOGJ6OEFk?=
 =?utf-8?B?eEtiNXVyM2VzMXhiWEdsZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhGdXNIZHhTNm4wZEMzbGU3UDIwd0kxM0pzRHdNY3EvaE0zWGc2V09vaEM5?=
 =?utf-8?B?VHRyVDhvRmMxVkRMQ3d1czlRaDI5ZEpuVzJaZFZYbzJVaHJvTlVwWmU1Skh1?=
 =?utf-8?B?VFk1VnhtcTFMbFFVVHpaZ1hzWFBOaUllOWZsSVZwZy9JNm5jN05aQTZKZ3BP?=
 =?utf-8?B?c3JsMnhPVUtFbnZJdFJzWGV5eEowUmZsZ3B2U2VQckJLRkRlQlcrWVBaZVNz?=
 =?utf-8?B?N25iUFhjejhJQjlqVkoybWhkTEt0Y01YczZaVkxVTlA5Vnh2OVNlR2NzWFhm?=
 =?utf-8?B?WVFOUEVtc1JNNDZDTTV6bVZlUWZxYU9memwwMDZyZ0tkTEtSTFdVTFRpTUZz?=
 =?utf-8?B?OFBvV0hKOUh4ZC9KSFgxOUFYMWFqdzZhV0VYeHJKUG80U2VjYnlma1kyajJ4?=
 =?utf-8?B?ZjhXNkVERGlWWXZFVzJ3TktlTUtFUmF3T0tOL21FeWNDbm1UOFE2TzVlSkhi?=
 =?utf-8?B?Tng1Yk1qU2tqdHlJbllDU1F6UHh3QkFBYU5tbFVnaFJ2am5NRzk5UXIvbzFy?=
 =?utf-8?B?VGRVTXNRdDZjQkpYcU9TcGpQTzRJYzJxZW9nUDhrYVpJazUxV24xSGFCUkV5?=
 =?utf-8?B?SHVjaDhkNndHaFhFMGFQUFdqaXJjUEJ2RW95czdSZFovWEc3YWtWaGJaZVBx?=
 =?utf-8?B?TXJJWXVRV1Y5YUtSdjY5UUgvNWVxU2hqbUtEQy9VMmNJaTBPdHFBZCtKMmpt?=
 =?utf-8?B?MlJ2bHpOQmpTM00vN21lcXZxdjJsUHZaRFdOMk14SUlWaUtCaVZlbU42aHc0?=
 =?utf-8?B?VUFDdnVMRkVaWjBiQ3ExSjFlTnBuWGtMN1JYQzVQdmhhK3gxazM3WjJ4NUlG?=
 =?utf-8?B?ZGlRK0x0bE02NjF2Y0hDN244QmNmZ1lrc3NaS2UvMExIYkJ0aUZBQWZEQmRS?=
 =?utf-8?B?ckUyaEs0TGp5N0FEbUxMcUhwWjlOQ1ZsbHNyVmFjQ0VRRUJtVXFUSGNYKzZW?=
 =?utf-8?B?bFFnd0NERUhxSjdaZ3F3SVpUM1ZTMlRWTmM3WFk3VHB1UnRrTS9udG9EbjRo?=
 =?utf-8?B?dzNKbEtWRkVNNHhXclN4OTUrK1FETkFtODE1YTRVdGtoTFExVlgwZ0RiZStF?=
 =?utf-8?B?MzIrdnZ2cW9SajFwRnZocHRLRkRpVW1qYStab2hWZWlQNUNMVXl1UW4rM1I0?=
 =?utf-8?B?cHlkRFNZdnBrWXBUWkNMbDQ2TUdEN2lpRzdpSEpmMnhwOG1yRllXOEc3dEVW?=
 =?utf-8?B?UmNaWjFBdzMrbnN3R25jUTM0aHMvekFEMVorbDJhU0Q1T3d2alBRa3lVWmdq?=
 =?utf-8?B?RmFvV0tMOXRPVUNQVmNOWVF3ZEQ4UnpjNjRQb09PM0lhd3lzNitUOE5reGZB?=
 =?utf-8?B?bG1IV0NIcGIzRUFZcTFEV09Sc2tTRitWUGdTVlN5NFZ2YjN4K3daTWNnTkNO?=
 =?utf-8?B?ZnppM1ZNdS9NbUtJb0F4OWVva29zMkhleHJkR2k5WVZXYlRjV0NxaDh5L1FE?=
 =?utf-8?B?WlgyMXRWTDVEemZXVjdDeFlMaWlyZlc5SXJJdytMMG1Na3pHbW1kTjVzWVNk?=
 =?utf-8?B?Z3F3ODFqQk44SUtjWGdjYWJZWGtBb2JLUjdyVVc1a1kyM2ZndmZmZ2xDem1h?=
 =?utf-8?B?d2NpY2RYb2F0MGJRZ0FXMEgxT2JxYmUzY3RsSzBLb3lVem1SQVRYUllmdGQw?=
 =?utf-8?B?SExuQkt0eE5UMzNtR1g1dVBlbW9ua0tDb1FhZ0xPWFFxZk1CdGx5TVBHVEhn?=
 =?utf-8?B?N3krMHpDc05MKy9rRkhBaDgvSlFNZmZDQ1FTNFpxcStDMjFFUjF5WGg1VWhx?=
 =?utf-8?B?aDZDVWFlRk1GZG1OR0NLMXdjcURUSzVFYzl3WWxJOHJsL2FSbVZUK28xVS9N?=
 =?utf-8?B?clNJVzhGaHRPM0U5S1lOZllYMGEyZFRndWMxQ3Y3TGh4d3NtdTlCeGV0L0hG?=
 =?utf-8?B?U2tadURSdXlJQ3JmVVVFK3ZlNjIzQ3U3TWIzSGdhSThWNFU3WkJVbUR4YnI4?=
 =?utf-8?B?SVRXY2VnSCtxNGkrWUVuOXdiSTQ0djhwMEY5ai81M0l5ZzhQM3VnMjgvVG1B?=
 =?utf-8?B?S3FjNUJkU2xFWW84R09FUFEwZks3R1p4M0FtRE1nc2xFcnV1SGdwTFBNNk9X?=
 =?utf-8?B?cFVhVGFtdStRY1ZnU2tjRTBsTHdQcTZEOWxMcmpiSzBKVXlzL3dNU0hQSVky?=
 =?utf-8?B?VnVYQXhSUnVEQk9yd1JxZC85NFRWZElSNStqVmRRNVlBRVRKWXcxc3NHZjhm?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ea3de2-757b-4158-7d49-08dd1500c623
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 07:45:22.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0mSvAnT/utxAa/O1gV+ocl0ME4OmO8AOBmDpa03zy+Uy9GsX0ZUClWjY2w3yNiIXnuF8skqWScK/ImMOUEaCXSwl78869XDtfe57MPceVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6322
X-OriginatorOrg: intel.com



On 12/3/2024 8:56 AM, Oleksij Rempel wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Feed the existing IEEE PHY counter struct (which currently
> only has one entry) and link stats into the PHY driver.
> The MAC driver can override the value if it somehow has a better
> idea of PHY stats. Since the stats are "undefined" at input
> the drivers can't += the values, so we should be safe from
> double-counting.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   include/linux/phy.h     | 10 ++++++++++
>   net/ethtool/linkstate.c | 25 ++++++++++++++++++++++---
>   net/ethtool/stats.c     | 19 +++++++++++++++++++
>   3 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 563c46205685..523195c724b5 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1090,6 +1090,16 @@ struct phy_driver {
>   	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
>   
>   	/* Get statistics from the PHY using ethtool */
> +	/**
> +	 * @get_phy_stats: Get well known statistics.
> +	 * @get_link_stats: Get well known link statistics.
> +	 * The input structure is not zero-initialized and the implementation
> +	 * must only set statistics which are actually collected by the device.
> +	 */
> +	void (*get_phy_stats)(struct phy_device *dev,
> +			      struct ethtool_eth_phy_stats *eth_stats);
> +	void (*get_link_stats)(struct phy_device *dev,
> +			       struct ethtool_link_ext_stats *link_stats);
>   	/** @get_sset_count: Number of statistic counters */
>   	int (*get_sset_count)(struct phy_device *dev);
>   	/** @get_strings: Names of the statistic counters */
> diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
> index 34d76e87847d..8d3a38cc3d48 100644
> --- a/net/ethtool/linkstate.c
> +++ b/net/ethtool/linkstate.c
> @@ -94,6 +94,27 @@ static int linkstate_get_link_ext_state(struct net_device *dev,
>   	return 0;
>   }
>   
> +static void
> +ethtool_get_phydev_stats(struct net_device *dev,
> +			 struct linkstate_reply_data *data)
> +{
> +	struct phy_device *phydev = dev->phydev;
> +
> +	if (!phydev)
> +		return;
> +
> +	if (dev->phydev)
> +		data->link_stats.link_down_events =
> +			READ_ONCE(dev->phydev->link_down_events);

Maybe silly questions but... Why to use dev->phydev when you created
*phydev pointer at the top of the function? Moreover, is that `if`
necessary? I understand that it will be always true as negative
scenario you handle in the first if? Or do I misunderstand something?

> +
> +	if (!phydev->drv || !phydev->drv->get_link_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_link_stats(phydev, &data->link_stats);
> +	mutex_unlock(&phydev->lock);
> +}
> +
>   static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
>   				  struct ethnl_reply_data *reply_base,
>   				  const struct genl_info *info)
> @@ -127,9 +148,7 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
>   			   sizeof(data->link_stats) / 8);
>   
>   	if (req_base->flags & ETHTOOL_FLAG_STATS) {
> -		if (dev->phydev)
> -			data->link_stats.link_down_events =
> -				READ_ONCE(dev->phydev->link_down_events);
> +		ethtool_get_phydev_stats(dev, data);
>   
>   		if (dev->ethtool_ops->get_link_ext_stats)
>   			dev->ethtool_ops->get_link_ext_stats(dev,
> diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
> index 912f0c4fff2f..cf802b1cda6f 100644
> --- a/net/ethtool/stats.c
> +++ b/net/ethtool/stats.c
> @@ -1,5 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   
> +#include <linux/phy.h>
> +
>   #include "netlink.h"
>   #include "common.h"
>   #include "bitset.h"
> @@ -112,6 +114,19 @@ static int stats_parse_request(struct ethnl_req_info *req_base,
>   	return 0;
>   }
>   
> +static void
> +ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
> +{

Nitpick, not big deal but you have the same function names in both
files. I see that they are static and there should not be conflict
but maybe is it worth to add `_phy_` or `_link_` in the name of
the function? Like:

ethtool_get_phydev_phy_stats
or
ethtool_get_phydev_link_stats

?

> +	struct phy_device *phydev = dev->phydev;
> +
> +	if (!phydev || !phydev->drv || !phydev->drv->get_phy_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_phy_stats(phydev, &data->phy_stats);
> +	mutex_unlock(&phydev->lock);
> +}
> +
>   static int stats_prepare_data(const struct ethnl_req_info *req_base,
>   			      struct ethnl_reply_data *reply_base,
>   			      const struct genl_info *info)
> @@ -145,6 +160,10 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
>   	data->ctrl_stats.src = src;
>   	data->rmon_stats.src = src;
>   
> +	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
> +	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		ethtool_get_phydev_stats(dev, data);
> +
>   	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
>   	    dev->ethtool_ops->get_eth_phy_stats)
>   		dev->ethtool_ops->get_eth_phy_stats(dev, &data->phy_stats);


