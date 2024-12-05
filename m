Return-Path: <netdev+bounces-149325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F89E5256
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA471882419
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27C31A8F90;
	Thu,  5 Dec 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gq0qstku"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533F194C6E;
	Thu,  5 Dec 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394744; cv=fail; b=T1EWj6XY6zzSRVbG8s52LMhGx9lU49Gbvv9T/O/haGYbxXu0lu6BCgNE9in83Cv7ZIcLaxD89u20VblVzIBKXM99MwtHBwt3Uz5Nj6CTx1+d8hBF0n/fOO9wi31QXDKbDCJP8tasBZukW10vTBqX14xMjan3e3+oxYhBjTAddw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394744; c=relaxed/simple;
	bh=YSwQXDtmzjPLfqkgjwZJJiRiLC7KBvOMpcQbfRQJ5lg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ApjgX4dDRETCQVJeLY9LzueyF2YwODq1m9h01qGgwHyATaJW64nj0nYUt9PR5KGlCkNlMPKtjlIAwobwWWWRhZDUELpK4KdU1zN7kZWIlxrQqwrpMS4VwXVEoxVuleXKNKWJdU+XeeKWnCujtS/soDzOJhtEPJre4sqK0m7XDyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gq0qstku; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733394743; x=1764930743;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YSwQXDtmzjPLfqkgjwZJJiRiLC7KBvOMpcQbfRQJ5lg=;
  b=Gq0qstkuqexXSm4EXr8mgG5E6HPka58Qg+yPFtp9ygWcCD5UwixBRR5Z
   Nz7j4QOR5wCwxu2da52OpMx6p+vk65JPQHhtM9hXGLKNCeBydy0263Cmk
   xQjYh7XGeCtd6XRGftkleBP4zV7mcTAnUqTp8g0lHd99v4/BC6tZiryPO
   vKN8Ga92KIyiR+Q6hpX/KFajxKZa3rr/9VFbuu5SkLwvMnI+HATRRcFo/
   h9c6EQwhaaVOPHiDuWlLx42JnhQePPBD0OsZ89t5DFQb0maMMl3C+D6ox
   O3e1R8abPRw9MzYPxhqt4AhIkVqFJ0D0f3FUpXmdFu5yrGZMPG4WqF3pN
   Q==;
X-CSE-ConnectionGUID: q2ObjYcRR+aow35F7xf4fg==
X-CSE-MsgGUID: n17KZhdNQTGFQtNnNh1uQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33835289"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33835289"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:32:22 -0800
X-CSE-ConnectionGUID: WMqG66f2QqSdfwmhpL+KoA==
X-CSE-MsgGUID: Rxi9eyX+Q263LLDihl9vuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="98504458"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 02:32:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 02:32:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 02:32:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 02:32:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0o7c1ZRQ79cZma5AVG9hins8v/UTtzAXqfPhQO6jsrxkLfXuPRiN9Ry+OnyEWF7kesXMZ0OB2abBJFsyah0h4Axd5/T2vkLspQ3W0Z+AldmauZVeJiS9yLSrgEJir87FbKnx0lvi4t4xk29slONfdxCquiWN4lIieO1YYZgMLqEMhHKBHPYyhctJHGOyZNaeCpJaFbkEJoZpXAGrfzXIAEp7dwnP43dcbhv9gG91jV7PoZ6xC5QeeN2L6/OOWUGWicNf84MtF8CDzchlT9DE79IBj8rDWX8ml8/sCrGM246ti4LCa7SfgtMg64zFBKzsIEwwYCRqk9ksMbm8q191A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h5jWFu0emFs7oFLcE6DCoaPxAd4Cwwbedn+Otzifq8=;
 b=yY2Y2u+kC9kBAIyJjpm4U5p00iUvC11dA0XaJ26tmkaikEis3l+IhKKN/kqyBR4/Vw3vknLwQ76QC77tKQrqgqVaDA4LWPpLAm7Iemypi5k35zT+ON3qqWWACe7OQeXktsIjBg3YbJd8TBp47pb03jPtrDaOcxzEbvlAuNuwiIvzUiKIZCeKr80mLw4sjjNsnE12ruZYsf1Ua/cY8qQTlVIWks3+a1OeIZ8HnlDFKzdO6/2sa3ilqMaH1NP4xMTmCLSjfcaQ+eMmUm2/yNvbhp/xFz6wSxCbU53hOPq0169ZFV0ZjDtbZPcDC3epuj0ecUO3AhzlGlTvGjZKJWa0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 10:32:17 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:32:16 +0000
Message-ID: <9bae97d0-814f-4dae-b3e7-b9fab24093b9@intel.com>
Date: Thu, 5 Dec 2024 11:32:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 6/7] phy: dp83td510: add statistics support
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <kernel@pengutronix.de>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Simon Horman <horms@kernel.org>, "Russell
 King" <linux@armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-7-o.rempel@pengutronix.de>
 <57a7b3bf-02fa-4b18-bb4b-b11245d3ebfb@intel.com>
 <20241205-satisfied-gerbil-of-cookies-471293-mkl@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241205-satisfied-gerbil-of-cookies-471293-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SJ0PR11MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0ec5af-3d11-4af6-bdab-08dd151816c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amlqWkYyVGZISnV4bWJ2YlVQa2ZXaG1SdzhlTjZ5WTllUUhmSVdNM0xCd0tE?=
 =?utf-8?B?a2JXZWVHaGhHcG50dVNmVEtHaTZ3dTdUZDJiQTRiSXlTaG4wSWQrbWlCcXZB?=
 =?utf-8?B?alNCMnhZenkvWXhYVmp2OS9DL2R6T2d0L1VoTy84MjRVRm1qdXFLQjRaUWI3?=
 =?utf-8?B?RmZaWlZsMzYvRVJWUGNSc3RyWXJMd2g1T1NXMU1aU1JDTkpLYU8yS0dzMWFi?=
 =?utf-8?B?NStNNGlMek5OOGFCK0RiN0F1OVV4TUJ5NjBnSHk1cmRVeGxKV3FPUnF5OTA0?=
 =?utf-8?B?MUIvREdTVlBJQkZTNGwrTXhXS0NLRHJ1MnN3RkpIUHNqbkJDNG12V1JQSzB1?=
 =?utf-8?B?a0lBaXI4UDBLRUFzVTg1T2JTTE9YR1F5OTE0Vk0vZ3Roc0NXSnVZbDZsbm1Y?=
 =?utf-8?B?V1FSYUxHYzkwZXpZN1h3L1c5aXc5TWhVMWNNeExkUUR2dlZha3cvN2ora2Ey?=
 =?utf-8?B?WnI5dGM0TWEvSHhvSlJCakVlV3J6UDNJV0xaWlA4Q1RIZXhqck1zQ21EM0tU?=
 =?utf-8?B?c0lXdHltL1pscjVPTldmdTdMVkRvMVdSeEgxb2Y3TmRPbWx6bFBxNFFlK1Ur?=
 =?utf-8?B?c2ZvTmpNa3NaWWY1V3BTL3Y5Z0diaFBqSmVyOGxkNy9tSGIxaDJ0K3FTT1FQ?=
 =?utf-8?B?OXpaYjhlVE9QYTRqaFpSbUVnMEFlZUFvaWpiVndwZk9FZFdLMG1sL29LMUV0?=
 =?utf-8?B?amNxNXk0YTRWZklhdWhEc0ppbWo0YlhiU0VIRkpMR0xLaXl6eUYxc0xkTUVU?=
 =?utf-8?B?ajFwWWZEcTRvMkxRWGNqUXBwV2h2bFVCdFBFdmM4TU9FcWZLZU1xNkpqVXV4?=
 =?utf-8?B?RW91UlpHMUQxaW5TMDBGMm5XSnFEUW9jbU1tckxrd2NMbXRIMkN0NGZZcjl6?=
 =?utf-8?B?eFM5VlovS1lLTVNPZUg5SjJtZXBCOElBeFdXTE0wNjFwQWF3dTBQckZFN2lo?=
 =?utf-8?B?L0d4dEJmMkZrRUJyZHhISVRxa2MyQWtWNWprRExVOUMvbWV3SWFvdmlMbjFt?=
 =?utf-8?B?WEVHS1NUN3NvVDB3bVUvUndkM1pnS2dDTTNpazA4MzExaGtyaWtIYnI2QjVL?=
 =?utf-8?B?SEVWNEVQY0U2T1A2Qk1udDhuM0RjU0paQ1I2Wk12MDVJcS9TM0RoY2kwTUda?=
 =?utf-8?B?OWhsc2k3VTJmd0d6a1QxVXZTOU1hcGxqZEkyYWYwa1JGQll4bTEwMlpoU3px?=
 =?utf-8?B?MVdVcll5c0JiVUgxdTUxajlNejBiTUJmdFJhVzlUa0ZRVndiZGxoaThrSk9L?=
 =?utf-8?B?cmtXMW1HMUtvZEM3bll6aEQybkpJbjcrb2ZBRnBVdW5VRHd1MWljVktmeWMx?=
 =?utf-8?B?UHYyM3loRHdzUWtMRXNkVFd1KzFIa3JFaWJzNWFDY3pTZGNLK2RxeDJleE1T?=
 =?utf-8?B?M0FPYkwxL21ya0FZaTVWaCtXaUdJcE5OSm9KQUdtWXBLRm5ZQjE4MWVLdFVm?=
 =?utf-8?B?eEo2cnhyd3U0OFk1eWhTL0wveEJyVWdoYllFZTFQZjlsbjIyVG1NQjRZcEpx?=
 =?utf-8?B?cUZlMmNScXFQZWNKWW5RUHR3UXgwbGFqNFhabUJNQlZxcGJMQkRsV2xjSXpp?=
 =?utf-8?B?MHU3QkhPeVlhemRINzMyRVZLUEdQNkY3U2ZVOWs0NDdvLzJJbDRsaEd6ZnVT?=
 =?utf-8?B?R3lZS2NFTGtxNXp2ZWRPUk1YaC9aNzdEM0ZyV1cxZ0lrMXlheWp2YlA0K0VQ?=
 =?utf-8?B?aUtFd1Faa0thTCtTWXgwZnI2eHdEais4RjhjMHBTMmFiRmIyVEMrY2dPUXR1?=
 =?utf-8?B?RlZhN0svZ3RhQjF6WXhZVk9BUkhNTnVFcXRnN3Z2NGE4Mldud3JDM2lGYUlJ?=
 =?utf-8?B?YUpwTXJyMmQ5U1V5b3hyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVrR3UwV2djdW5XU3pUR052YVh5WGdZN2VoaStpQ0t0VFF5amlrQ1VhRWEr?=
 =?utf-8?B?eXIwS2V2dEFXd0Fxak5iQm96K1BVeXlqaEpsNDVoSnhoY1lodTAzQXh0U0xv?=
 =?utf-8?B?bnNJNVVxekl1ZlRBRWdCVWg2SWIxcVFFQmVUNCtQT0lOVDkwMmNOSzNGRFFx?=
 =?utf-8?B?dTRtVEg4Z2pUT2llSE9nK2hKdXNnamxlL2U1Qm9TTlBFbXpvdkpvZzlIV3N6?=
 =?utf-8?B?Q2NYL3pzbkRQZGhiNmRxMnJCb3hySDJPLzMzWERlTytzZDlnNTZ0eHRodktJ?=
 =?utf-8?B?dUlmVlBpeDVDaGdBaDQ1ZFhvNWRNOUZxMG9icXoxaHhsdU44a2gyaXQxSWxx?=
 =?utf-8?B?ZXdvQzR0Ym9YTkhCS1RVakJQQ1ZLM1Yyam12T1hPSVJHS28wN3dWMmljV2Ja?=
 =?utf-8?B?d2luS3o4Z0g1eXduOVk4TVZ4bEZZN2V5bm9XTUk2NndSVkNtVGZSUzFQaTFP?=
 =?utf-8?B?UE1GbFBCbFd4eFNjT29XMXV6aFZKNGpKbjV4bXZueW00dmNrUnh1UzluNjJq?=
 =?utf-8?B?NXpqS3V1UzVNT2liNnZLRkMwTkpKUkJSR0Fjenp3OG9QQkJqTnlUNUQ5ZUZD?=
 =?utf-8?B?NzZTcFZGaU9iTUlZNk9WUUZSQzVPVXRKT1RPUWhPazRaWGVwNHJyV0poK1Ja?=
 =?utf-8?B?dHY3V1Y5KzFyMHFCSmU0cVRGa29DN2JTU2FPeHRrK2p3b055RFlkcCtYT1A3?=
 =?utf-8?B?Z1N1YUtOOHFzYmlMSS9yNGhmcnNWMlB1bGNBQzdseFAzaUxyZEJ4VWZEWGd2?=
 =?utf-8?B?S25YMDdLcE5ON2I1UXp2RUZ1OTlBNjlVRVVjWTdhaE4zYjBEN3QwbDdha2ly?=
 =?utf-8?B?NkpEc0ZZM0NSRTVmQ1hQR1B1SzN0WkYxaGhIWHdiYnhOVXVoWXdSd1dqR3VL?=
 =?utf-8?B?Vm1WTlZMbWNadDg5YWxvM3c4MU5QYzlJUzdyZ2tpd1UzUzlJbDlyNHVxVS9z?=
 =?utf-8?B?amE2Rkg0VGk1NTRSNkNKS1pjS1dROEhsU3doc0N4bUM3SWcwSW9FcEsrOEEr?=
 =?utf-8?B?NDcxa2RxWXFsSlBVSk05TU0xK2g3dERpbUpnQU83TnhFWXNORERJSTZOSFZO?=
 =?utf-8?B?MWllVVZFQ2dybXd3cDZEYnJqQjNJVHJmcjFrZTFBd2p0RGwvMENZUENabVpG?=
 =?utf-8?B?OS95WGZWZVRISURxVXF4VzVLS05ReEh6ZnVYZmZmNWhldEtpTlFDNzdyd0tN?=
 =?utf-8?B?b1d1TVFybGtQcy94cndqTGVFUldmWVhRZUIrdmZYdXRmQm9iS0dGWjRjbjl0?=
 =?utf-8?B?UFRpdGVHSVNKRVc0d0NtRlpJdHZjenpmdlk3TW9rYzJNVUoxbnRTL2RBdkdv?=
 =?utf-8?B?d3dUUW5OKzhmR3M2eTd1L1hMc1ZRVU10OHA2MzEveDVmTURudVVZR05mOGN0?=
 =?utf-8?B?N3F5emxhWEZjTXBOdXE3T3VKcXFrOXRnb1BnbG53S3JiTkthdmZUQis3bjg4?=
 =?utf-8?B?VGZFK0VoY1NySHE2VUJSdXNzdWdKSWFvdWdHMUtkTU9WNTM0MXkrUUtEWjQy?=
 =?utf-8?B?dVZCK0oybE90TmNXbG9DWFgyaFFibytSRlp2c1F4ZlhIOUZWMS9jYzhFR3V5?=
 =?utf-8?B?NEV2SGxlTm5RT2QyczlkQUVvVmtHVFpKcjRWTWZhMUpieENTRVJ4MkRmL1JD?=
 =?utf-8?B?N0c5V1Fwd2dWV3BmVEY0TDhXWDVaUHkyMkdEUVI2a0ZuR0R4ZEJKd2creXZa?=
 =?utf-8?B?cXpyNlJNRVhXMWJyd3VGcnB0OXZ1N1JlRUsrV0NZVUZMVGQrRWFpN1hNY1dr?=
 =?utf-8?B?dEtBOEs0UXVER1hkcEVYZHpxMUJFaWF6dzdCYklIOFRlZm00MDdsSXVmRyt5?=
 =?utf-8?B?c1kyWFdPMW01TzIrNkN0NDdZSThLcXNBOEZ1Y0R6elE4aWJ2OTFEZXdlRDJE?=
 =?utf-8?B?SnJmVDRaL3dGL1g0aDBRbWxJamxtNm54S3Mrc2NjZGNCY3N4S1ptZVgwU2kw?=
 =?utf-8?B?SDdWdFdqZ3BaZVdZSzBrQnROU1N3NTN0ZENESzFIdjVyK0Q1NnYwK2ZJbDdT?=
 =?utf-8?B?OGU5VkVaZXlJVnBZYncwdTQ0eE42SC9ETEJmeUw3RlVabWM4anl1dDliMFZQ?=
 =?utf-8?B?REhDa3BTQlArd1Nsay90TGFpNy83Um5DS1I2dnh5UElXRVQ4MklXMmVjUXd3?=
 =?utf-8?B?bXVrQzBCTU82ZlVJZVZMZEgxaWRIcHpDd24zWFFFR1pERzJzSC92aWRYdnZo?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0ec5af-3d11-4af6-bdab-08dd151816c2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:32:16.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu/44NRa6dYdIs/r6PD1E06Hzfzhd/ammoIIL/ugbj0p3ePDBqPMUDgTgOjS4aaHkBpwE2TpijCx1c35O1bed5m946k9CRYLVyKul9kUz9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com



On 12/5/2024 10:01 AM, Marc Kleine-Budde wrote:
> On 05.12.2024 09:43:34, Mateusz Polchlopek wrote:
>>
>>
>> On 12/3/2024 8:56 AM, Oleksij Rempel wrote:
>>> Add support for reporting PHY statistics in the DP83TD510 driver. This
>>> includes cumulative tracking of transmit/receive packet counts, and
>>> error counts. Implemented functions to update and provide statistics via
>>> ethtool, with optional polling support enabled through `PHY_POLL_STATS`.
>>>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>> ---
>>>    drivers/net/phy/dp83td510.c | 98 ++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 97 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
>>> index 92aa3a2b9744..08d61a6a8c61 100644
>>> --- a/drivers/net/phy/dp83td510.c
>>> +++ b/drivers/net/phy/dp83td510.c
>>> @@ -34,6 +34,24 @@
>>>    #define DP83TD510E_CTRL_HW_RESET		BIT(15)
>>>    #define DP83TD510E_CTRL_SW_RESET		BIT(14)
>>> +#define DP83TD510E_PKT_STAT_1			0x12b
>>> +#define DP83TD510E_TX_PKT_CNT_15_0_MASK		GENMASK(15, 0)
>>> +
>>> +#define DP83TD510E_PKT_STAT_2			0x12c
>>> +#define DP83TD510E_TX_PKT_CNT_31_16_MASK	GENMASK(15, 0)
>>
>> Shouldn't it be GENMASK(31, 16) ? If not then I think that macro
>> name is a little bit misleading
> 
> Yes, the name may be a bit misleading...
> 
> [...]
> 
>>> + */
>>> +static int dp83td510_update_stats(struct phy_device *phydev)
>>> +{
>>> +	struct dp83td510_priv *priv = phydev->priv;
>>> +	u64 count;
>>> +	int ret;
>>> +
>>> +	/* DP83TD510E_PKT_STAT_1 to DP83TD510E_PKT_STAT_6 registers are cleared
>>> +	 * after reading them in a sequence. A reading of this register not in
>>> +	 * sequence will prevent them from being cleared.
>>> +	 */
>>> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_1);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	count = FIELD_GET(DP83TD510E_TX_PKT_CNT_15_0_MASK, ret);
>>> +
>>> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PKT_STAT_2);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	count |= (u64)FIELD_GET(DP83TD510E_TX_PKT_CNT_31_16_MASK, ret) << 16;
>>
>> Ah... here you do shift. I think it would be better to just define
>>
>> #define DP83TD510E_TX_PKT_CNT_31_16_MASK	GENMASK(31, 16)
> 
> No. This would not be the same.
> 
> The current code takes the lower 16 bit of "ret" and shifts it left 16
> bits.
> 
> As far as I understand the code DP83TD510E_PKT_STAT_1 contain the lower
> 16 bits, while DP83TD510E_PKT_STAT_2 contain the upper 16 bits.
> 
> DP83TD510E_PKT_STAT_1 gives 0x????aaaa
> DP83TD510E_PKT_STAT_2 gives 0x????bbbb
> 
> count will be 0xbbbbaaaa
> 
> This raises another question: Are these values latched?
> 
> If not you can get funny results if DP83TD510E_PKT_STAT_1 rolls over. On
> unlatched MMIO busses you first read the upper part, then the lower,
> then the upper again and loop if the value of the upper part changed in
> between. Not sure how much overhead this means for the slow busses.
> 
> Consult the doc of the chip if you can read both in one go and if the
> chip latches these values for that access mode.
> 
>> instead of shifting, what do you think ?
> 
> nope - If you don't want to shift, you can use a combination of
> FIELD_GET() (to extract the relevant 16 bits) and FIELD_PREP() to shift.
> 
> regards,
> Marc
> 

Okay, thanks Marc for an explanation! Now I understand it better


