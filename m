Return-Path: <netdev+bounces-243487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C49CA2111
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 01:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04C1B300DB8C
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 00:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B918DB35;
	Thu,  4 Dec 2025 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKdMegf0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECA1514F8
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 00:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809447; cv=fail; b=KldY+4skfp8aeiHXX+vQHatyhNaoC0uJjAA3DneZScFgykF7VoXGZAwMSYUP0qTDx4fY44ExH8MHw/D9JahvbkinAZQlHsOy/liuq7d/gmGPagQCGNKVUyQCGkedwuBsjSNZDPdT162JwBpv4nMt225Jl9X95c3XOTc8Gj2ywug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809447; c=relaxed/simple;
	bh=ubfqZJLBAneOO/rp5I+T/oRvY9ehD12uak3d7GKC5OU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kKv3HR0HK31dq2+8hu07PdvfH+/9CNsiAPSMTDRV5ZnIgvwh4eenGvydGWTRWzLHURFBj+K0anNJK8LwAr0bCaEBc9EF8sKScd+2VCn4l7iPoEJMKEndIFKgqk9jDfgzFejZSBbUiz2OBEem7WPV1A6NHe0Q8mjPu36fCX6oBKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKdMegf0; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764809446; x=1796345446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=ubfqZJLBAneOO/rp5I+T/oRvY9ehD12uak3d7GKC5OU=;
  b=IKdMegf0WCZ3JNyF1NhD0usUp6lGUwTaaQc/AdEO9aqvLcFI/enkpF43
   Hy5OVZ9rpmBYgvxAVuDtKZWwfWE79gbfoidYlf7NZy2cIolNktVHPYQ1P
   0Qdb81KxI8MvQfVc2wT++ZIK02479QBXMs14MKYagml3mZkt6y4MfjGkC
   cOlYgUXb5seJJFegOhwg2fkJV/OK5NTOuFXmY0fIfT3x1/Oh5raqC4nFY
   +Xtz0bCubfKyVP9EOib6VBQ3H0CRB7+XNkxIpdMxGrUD+PHbwTuxyK88w
   EiwS97efZugvE2oezKxsMS844w/wUxgx1DounQ1s1Xa22kA4bsUZuAbwA
   A==;
X-CSE-ConnectionGUID: +Rj6lcw5SMq8gD1T+ntsVg==
X-CSE-MsgGUID: xoTx/p5YTiqEkQ5WROOfXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66707136"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="66707136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:50:45 -0800
X-CSE-ConnectionGUID: cdlxLxtFQlWSO75aXzlg9g==
X-CSE-MsgGUID: dbg9bIzOT5+NOf4Ewa9lww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="225780947"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:50:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:50:43 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 16:50:43 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:50:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfwV9sM+KcarP8pYdqneUwuJ6+wzML10yuTI7nJokKxlrR7cWgVd2m7woPryCKpiP5WB1OMxiTs6hE3nn9ghmus7c6M7ULjC4xII9AoJYNBAiPNM3XlhOjbsDk2CUkp8QDCo/eprcVQ/mRdzIaxO3Kye0KAh+Ic+xnmMQRU/vksHCEfxlnTJUCPmzncKEFxvalzWADjziAw/dZ9CxkGU5XGAiO26MNjrUG0+jqfWPeTeSOYw7BpqHwxKH+Q93RgX42qbRv6YoLwvrsncDJ1WI32GFeWTNB+C1KdWI1lugP60MxrXOiCQWOM4QNGasTzLEKmp6lULbxCcGNwJVJJZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubfqZJLBAneOO/rp5I+T/oRvY9ehD12uak3d7GKC5OU=;
 b=iGkq6unR6paus/5PKI1q4D8B96j6hJ8LqIlgu7DhKQZ4IykVoEtcuQ1YRgMUzYuSIGuh7bdrqTweYy1itnVtQQL8xy4JPVij6EYoLMUNet+pjdcxbANRnTOpnCPLb1E32fPQqFB+c+oErh1J7vMLUrD66g/c8uBKSxwQtJqb9U4QTjY+DIqWPwPzjxr76pIwO4U6kz42sW7q+1rwuINyZgUKtxqXuAzikux8a0bRIllII+AsO/5JcO0wHvlFg6weoJ7xKL7GfAM2lEvyycPC5SObJBjiVuTFCQ/bdwZXl8IedJWXjcVCJ5Dj7Y/Qtn583mGz48wmFedc8xuviN7kiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5308.namprd11.prod.outlook.com (2603:10b6:408:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 00:50:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 00:50:41 +0000
Message-ID: <53d0efe0-f970-49ed-939b-d3a53dc7db86@intel.com>
Date: Wed, 3 Dec 2025 16:50:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/15] net: stmmac: rk: cleanups galore
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Heiko
 Stuebner" <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
 <05db9d3e-88fa-42db-8731-b77039c60efa@lunn.ch>
 <aS3EfuypsaGK6Ww_@shell.armlinux.org.uk>
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
In-Reply-To: <aS3EfuypsaGK6Ww_@shell.armlinux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------28OMtDKPcWLF7vtcJlGlzfXI"
X-ClientProxiedBy: SCZP152CA0027.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:300:52::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 8220beea-af4f-4f7c-4898-08de32cf265b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3cxd0dMOHV0cXUwQVVid1hYeHU1YTRMemRMZVJ0dFcyNzhxMU1xTjBWT3VW?=
 =?utf-8?B?bHVncjR1Zzc1TEt5SHh6eGo4cS9vb3Jxb3o2aWFBUVJzZzhpQmtRTEJTalp3?=
 =?utf-8?B?WCtYbllyQnBNWTFOYXBIMEhSd3ZoUlBuRkE2UGd6QzlYOEIzdkVVYnJwZndq?=
 =?utf-8?B?eU5kNy9UYUlNemN6ZDVtSGRxS0t4cU5CWW5jVmxsZ2s1MG9yY1FYVU0xcllW?=
 =?utf-8?B?aTdydlNVTzRpNEsyL3FKMUdsdFUvNHE0NmFHUFUvekRwWEo5eEdueUc0Q1Iz?=
 =?utf-8?B?Zk5pZDZHWThwRkR5WFl3UVZHT0hadXRaTGtoRjdYUm1CVzRPN0NZdTN2aTNL?=
 =?utf-8?B?eUErSktKUnFON2poZG1iV1VkRHIvQjNXdENjL1NuS3JGNExzcGpMTlBtMllG?=
 =?utf-8?B?R2tmM0twOFluck5IUVV3WUN1TldBU0IwOW9rUThGL2kySXBzOHVmVVprU1N5?=
 =?utf-8?B?Z2E2VE1vdWFmN3dUSVJDaVZSTGh2RmtKVWVHWTJsNUtTNXdWVVo1WTUrcXgr?=
 =?utf-8?B?MlcrQ3BnYTM5WER5QmNmTkRYK2JXZnZZSThxSDRRdUp5Z0RGdU1DQ0JScEo0?=
 =?utf-8?B?TVZ5SzVRNG5oVmRiUEFrbXhMTXlEUkxSUWUwZkFqaHNWWmE4bFNEbnBZWnlk?=
 =?utf-8?B?UkJVaDVJb0JML2ZrWFpET3JWWjRLbVdWNVlubXlwOFlzTlRUaFNOcWljOXB4?=
 =?utf-8?B?dXV3T20ycnBPeEtIZVBnRkEvN29VSWNwdEx2S2JvN3JKbnhpUFRjaDVESllj?=
 =?utf-8?B?R1NhaG4yWEJDU1MyQW90M2xtM2ErRnUxUnNPZHN1ZXV0Zkt0VVZsNFh1OFlS?=
 =?utf-8?B?cUhwT09MSWhxTUNEM0tSVVlSbVUzVUhHNlFTSDdXdjhTMm5CZUdCS1VBdzBZ?=
 =?utf-8?B?OGNCT0xhWkpKbUdXQkpPK2lVZDFwa0NxZmxWL1JxQjdEN1dTT1lUaXBLcThW?=
 =?utf-8?B?eC9ZSkRIMkVrSDUyMXIyUEU5R213bU5nZlFkN01nUmh2N3daS2xXb3B0RDc1?=
 =?utf-8?B?dFgzWFBhc0pDU1pnQkFaVzFzM2hlNEorL2lHZnZOYithY0F1cnpERkNSY2xt?=
 =?utf-8?B?cUlUc2JqMUtKbmNDU0E5MmF3U2xiaUNhUlRXcm5ZcVY0LzFlbEQ4bmtMZk02?=
 =?utf-8?B?UE5YdDQ1NllmNGM5NFRWdWFtRGR4dGcwZW1ZZkkybWE0NlYrdXcrb0dySk9O?=
 =?utf-8?B?ZURkaWZCN1RuakRKRGEwUTBaVkNraitZTVRkRkVHMzAraXBublh6TG12YXJJ?=
 =?utf-8?B?L2xOYmhmcm56YXliNld3MDJKMXl4ZU01RmlIOEFjQ3g0MHBqT3dUaWRBWXVE?=
 =?utf-8?B?V3VUenhnNlh2aWU3ZWQyS1VoRkw5YUlZcFlqVjZlM0lBdmV4Rk12NUQ4YTJW?=
 =?utf-8?B?UGJZenBja012aEJsa0dtbGVGYkF1NGNKWm5vNllYenhDdE9kenA2SW9ndjFY?=
 =?utf-8?B?YU85TWxPREU5eWtVSTJLTjJnbkMzL0VCRlZWUlBYT0Y5SDVwMzE2YXYrYlhO?=
 =?utf-8?B?dWpDUEE0UHBPSmdwZU9jekFMUlh0VHFicTFPbCtBOHpTR2U1RmhpUzYyMFZZ?=
 =?utf-8?B?bldjV3ViRmU5Nm9KVkZxRThFamxrc3Z2Z3lpTTBHZXRFbXNvdHF4WUZEMGhO?=
 =?utf-8?B?V0xLUXVaT2dncmVyRnlFb2tCREFTMWxhUmIxQ2EyWEVtYkVyd2FSSThIUFVj?=
 =?utf-8?B?U3BrOHVGRHhEbTRpcFZlWjJpc1JmUTd5LzdxNmIxU3I3VHFqUjg3VTRYeGky?=
 =?utf-8?B?QlRORmhDcE1SOTlMTFRBdjZFQzEvdFlubVZ0ZG5nem42dEc3Rm9mY1lVU3Ft?=
 =?utf-8?B?K24vdCtNOFRyaWlUU0Y4eDRjNHo0cUprQUovbTdEWGMvSUt5ZklyK09BYjNV?=
 =?utf-8?B?akNWNXFFWDZLbGZFWkhaVjNoVGhaZjhBZXJKYm5QSkpmbk8yZDVPaVR0OXhp?=
 =?utf-8?Q?GPQOY0OwzCTnc+gTs45+bvotwx1N6hHg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUtYUUgxU1daOUpoaWFSaG0zYzU3dE03VEJKSUg5ZDdJaThlV2RUOXRBUCt6?=
 =?utf-8?B?NE9NYVJWODU0eUp5NEVaMU15VlAxUUl2Y3Y3TFEyRWJRbXRhdjZ0WnV0dWRI?=
 =?utf-8?B?NDB2cnMySHNHQUVvREV2Ky9sdG9uWGhEVVc4WVJmcnFrSUkrVzMyQkZ0QUZZ?=
 =?utf-8?B?UmhqWWMwa2tINXRPVjYxcUhpcVAzcDQvUUdLcDYrYnlUL1NsU2FndGc5Z2x6?=
 =?utf-8?B?dWtVODR0TkNLNGh6bExjWVJSTVhqTm90MHdxSkZxSlZQZldoMlhwdysySjZy?=
 =?utf-8?B?dG9VemN1aFhNZ1piZU5iVzVMNXlWU2pGd0Q0K1JYejMydm9IRUlIcU1JaHJZ?=
 =?utf-8?B?ZFdGeXhoVzlVOHBwWUNvZGNmSnlXWnF0cDB3NWs1dlRYdVVtVVc5ai9xbW5Q?=
 =?utf-8?B?K040c1F5UDgyRXd1cFVwemlwMFpnMGMzUXF1YXN5OHRGaDFiZnZtMkQwOE5G?=
 =?utf-8?B?VElKUmRIWk9hZk5HSmRaT3JMYVZqSTdCTVhmeC8zYVRkd1BFSU1nMVcvZklV?=
 =?utf-8?B?QzBLeldBQi8wUGRteWpRSVhLRVRDdFVvTUVkVXlJZE5JdHNkUTA4eUtGci9l?=
 =?utf-8?B?MTlwenhUWEZVWnlXUUhqbTI1RGQ3OW5XR2M4TmR1RkVzWk9oYXNyTXBGK2RY?=
 =?utf-8?B?aDI3cERhdHdDMkVzamxWOXJURElaUnFWQ2RLYUh0QmVCajBScU1IS0NxalVW?=
 =?utf-8?B?Wlk3Q0pUUEtYNm9YVWpGU0t0eXhBcHJKemQvWVY0R0lQQlhMaDZHcy9oN21R?=
 =?utf-8?B?NEZSL1d1NjdGWkdweDJsT3I0UzZzckh2ZW9GU3lvZ0FlakI0V2Z4ZGhSRDNh?=
 =?utf-8?B?dXJTLzl0MVhYYWpHZk56UU5NOURGcU9oKzl5Y3NhOGVMRHZFUmUvcnRQaVlC?=
 =?utf-8?B?c2NjSi9XSExkWURhRXFwVzhNQTJmT2I2QVdRZ2pEbzhEQmt1ZWV6RGNGZHRz?=
 =?utf-8?B?RG5kc21rK2RrYUFJREpnR1NlSUFDVTRNNmVMWTRFUVhHQmRTaWFSeDJ1MEF4?=
 =?utf-8?B?RllPSENJVC9IMm44N3Q5S2lNZ1ZYZ2xEVndLTGxoSmlSNU9sanJ3cGdmOEdr?=
 =?utf-8?B?RHVLYkhNbW95ZGU1RWF3QVRBeW9sMCt3RGxodmVjZ1NVNnBWSHZNaE5CaXVG?=
 =?utf-8?B?QytsMmdGekdRaE80NVQwb2ZISkpSL1VHb1VkOXh2RW5KSkkyNWxWL0p3aGp4?=
 =?utf-8?B?OXdtYzErMG1lU2hmcHZMcUNMM1ZJa3A2TXU1YkxhWW9XWFM0cHVlbkk5eUcz?=
 =?utf-8?B?MnlXVnh0SWIwVXhFWjBnd0ZKYmxtcUhQbktmQkVPUDVtczhsWkowR0c3SzE5?=
 =?utf-8?B?akxKQTZTelQzK3I1WFV6ZmxDOHlRd01zQ2s4c2tBS1VpNjRqN2dYZG9mSEFU?=
 =?utf-8?B?ZEIvdS9sZEhnNEJybklYOFAvK0NGZ250RlpndGtaWTZHY2c0UlJzTCtTdmRj?=
 =?utf-8?B?dC9RaG5wNWp3QzVNbTUwbkN1UU5TNEZqcVZCcHk5ckUyQStvK1VEVHhyVVZs?=
 =?utf-8?B?MytXZUJjYmRBcm1lR3RzbTZkTEJBMXN2K212WlpYWExsRkZ3VmtDRWY2amFU?=
 =?utf-8?B?QlV2WWNZbVVJYUVKVjB5bXdjdlpBbFF1R3AwWVFlTUNaYW9JWlVSSTZRdVFC?=
 =?utf-8?B?WGVXMUlHdnlSM0NpZ2dhbDFLWFoxYWNhNGVEYUVVTjRBRU9yL1kxMXlWWnNl?=
 =?utf-8?B?UHo5Y1pJWEtpalFKVDdkK0NVeE1LWElhY29lZWQ2Wk9vMUZ1MmI1QnZhekxM?=
 =?utf-8?B?WmhqcURZaGsrR2pvbzRwa2hVL3E1TXJPc2g2NGlxMWw0S1ZvUjFocTkxeE9w?=
 =?utf-8?B?dXBpWHRCNEhUTlo2Qkp0VDJ2VmhGU1BFLzVTZFkrZWUyYnFVcHpYcDlRY1p1?=
 =?utf-8?B?VnpBSWFzV2YyRUVBdUNUdUhiSnN4ekZoNk5xdThzbWRKSCtxZ2g5L1lQalh4?=
 =?utf-8?B?aWFwOExhb2FMZ3lHeFIvMkdxYWdqaWIyVXZKU1VDeWlQUzE1dHFRdWM4aXVZ?=
 =?utf-8?B?MDZwWG0wOVpiZ0xTKzB1STRLcUp0VHJLaGJhUUJxQkFmTUp1ZmRybmdmVVZ3?=
 =?utf-8?B?VWQ2R2NhRDRqdll6Nnl2dzA0UFBiRXU5eEZJWlAwYTk0ejE4MTRqVzd6VUpx?=
 =?utf-8?B?b2ZuVmpaTkxSRUNleG54NzZUNWJQWUxQVmRFZHZad3BmRW5QVGw5NTErMlF3?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8220beea-af4f-4f7c-4898-08de32cf265b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 00:50:41.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/9NlX0pKd691WmLnzGK6IHDc/Vt8wgbNLVA+oBEa+a93+fbGNdhyZfB0V7F6ZEIM12ntGBLEwOtNso0eKn0KrkOcDW4uOMu2ZgROtwUK0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5308
X-OriginatorOrg: intel.com

--------------28OMtDKPcWLF7vtcJlGlzfXI
Content-Type: multipart/mixed; boundary="------------fYCEyaI5qhBWV5cR0sWRCihS";
 protected-headers="v1"
Message-ID: <53d0efe0-f970-49ed-939b-d3a53dc7db86@intel.com>
Date: Wed, 3 Dec 2025 16:50:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/15] net: stmmac: rk: cleanups galore
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
 <05db9d3e-88fa-42db-8731-b77039c60efa@lunn.ch>
 <aS3EfuypsaGK6Ww_@shell.armlinux.org.uk>
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
In-Reply-To: <aS3EfuypsaGK6Ww_@shell.armlinux.org.uk>

--------------fYCEyaI5qhBWV5cR0sWRCihS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 12/1/2025 8:38 AM, Russell King (Oracle) wrote:
> So, in future, I'm going to take the attitude that I will NAK
> contributions if I think there's a side issue that the contributor
> should also be addressing until that side issue is addressed.
>=20
> This shouldn't be necessary, I wish this weren't necessary, and I wish
> people could be relied upon to do the right thing, but apparently it is=

> going to take a stick (not merging their patches) to get them to co-
> operate. More fool me for trusting someone to do something.
>=20

Yep this is unfortunately a reality of dealing with many contributors.
While its frustrating to require this.. If you don't, and end up never
getting things fixed the end result is worse.

As a maintainer, sometimes the only leverage you have is when someone
wants a contribution to merge. Balancing so that relevant improvements
and work get done while not being so harsh that contributors stop
returning is a difficult problem.

> I now have a couple of extra patches addressing my point raised in
> that email... which I myself shouldn't have had to write.
>=20

:(

--------------fYCEyaI5qhBWV5cR0sWRCihS--

--------------28OMtDKPcWLF7vtcJlGlzfXI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTDa1wUDAAAAAAAKCRBqll0+bw8o6BGo
AP0UsGaoTWdSquxkvhtnal+z6c4Lg8vPUEAmmUO4NZ1FWgEAxLf4FNXkb7O7ZN30h/BKEyi5PNJh
VcqsfYXkzhr6bQc=
=ETAR
-----END PGP SIGNATURE-----

--------------28OMtDKPcWLF7vtcJlGlzfXI--

