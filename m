Return-Path: <netdev+bounces-281282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL4uFQ4w72mb8wAAu9opvQ
	(envelope-from <netdev+bounces-281282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:44:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA559470166
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3ADB30071FA
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9A3B27D7;
	Mon, 27 Apr 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jG/wrDuU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288782701CB;
	Mon, 27 Apr 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282915; cv=fail; b=ERmDgqp/3KxDkBd0fgX0ZStIdPCs9yClmFzbvY2Ii26qub4ERAHKdVlH5rGz5Re3pH6339memstnK/cCmSP4C5NzKENInttuRO663pnzIZW7gNz1H420Rn1EV70hzr56Hnpeiho2FS3LFPPt77O6d/CcSpx1ehLQBEuLDrw0WSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282915; c=relaxed/simple;
	bh=GAzpzT+g/bdeid4JxQu+IKqhRcmR4SMX6NELPx7APc0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcI9IFuQtVbQuDHU3xZRu6gJe/NCxJUKh4iO5/TqvTGLpmfp8zpl3zpZV95cefs9vOTBVqQBtPTZ6cEB+IV+W+nKOZMRKTVX6ZJJctwxXBQ9qmq2c2g2Q69MNZb46E5JRH6yuby6fwdbLANjd4s73sF+Oztqr/0FPR2wbT5uOQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jG/wrDuU; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777282914; x=1808818914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GAzpzT+g/bdeid4JxQu+IKqhRcmR4SMX6NELPx7APc0=;
  b=jG/wrDuULI7YGAwdHQu63eSrEP7cejkdvhi4XRIiHJwmILiQZmQWiW4O
   NrXFDmRqNqzxp6hXTy46HifY4LWTiwDu48X5ytLlF3MaNkji5Cv5dOw+e
   nYtOsD9GiWmlmHa634u+1vxc31WTavO2IjL6qxKBxMBnnKCi6lAJBedx5
   /eh0ZAzyVt+wj4NH3D5b3+lEnvGFmr9S2i/FfjAEMt2Ptp1VidL02AR1E
   Txud39LhOftFPPu7nwroVNNtlutqour89afi4yAeEKhcN08lXRzz8sg3Z
   Eo2Somg0FYh3OTT1AmHclIpxVchKJEpTnl+R8uqLO6Zsh+jAIg0LjLFVs
   Q==;
X-CSE-ConnectionGUID: 314F5hunQHyofcWscRDXqQ==
X-CSE-MsgGUID: ZD4sYQqmSLmj9B4DbFOM3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78354877"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78354877"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:41:54 -0700
X-CSE-ConnectionGUID: zmzjJ+Q7QtqgYytT2QlJSw==
X-CSE-MsgGUID: Hc+kziF/QK2fgywxU2x4zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="232710344"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:41:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 02:41:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 02:41:52 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 02:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAAcFwP4MgVCgZpeHIgXrOjXbx5/aCt2y4UMht8nx0r89UY7IBpHAOffnnJ5gVMC89DXJRVQbdc13hqc/L6h48G4y9KoNHpV4f6M3zrB8iygdh8pEvPk4s/E1hmtdO9s2sZG/d8l0jxU6NB6xIp75DfZKDn1u3zYCxHBuYvrTTeBIpq/Y0ik6Sr/OPuqMmLeN/sFkI6NvuPuXokusCbWDBy5kCD+hCoAabIiI28v58iT2Q9jil0tpS7IDh1FgNYhfnGTzjePdKkCOXqSTps6cUYqryzU1FpWIFfyoz/+E3nVjEAwc+pgvf6GyvpzmPYxeoldGq+8sfVWJcIjbkJv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAnbBptgKVsQcey8Gdf9t/VAyH9hjmwD7npOli57J3U=;
 b=azEWDKsB09SYK+97B7SWcu7infWkPVZcRb3ui+X6+GCvW+ispvRAfp8R3OblY7BLvCmysnhlmBAuNlv/lKS0ecE2r2xgEuFIaNQsagytYKb97DRPXCVNijUZSFMygNOzT1ktD5FmRJoBTPmdPjahbXET6d1hivQN+XwCtXDx5Jjg2Bi56xTlTiBEmfsAquG9KdNOKiGqME1ukA4h0fwCNHqQQf4zFCA8AcICzw98on2N9oFJKPi5pC5H3xHtgF81GVYJ4/MeQbTvLSB0Bpc0T3XMLQ9MFGrB10vV1pQfuEnK+AJ+EfvJANnzlOHBWEOCJ099kKjkmPJ7G0KKB5vPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 09:41:50 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 09:41:50 +0000
Message-ID: <b2d17381-93f1-40e7-8fdd-fe1c83089a31@intel.com>
Date: Mon, 27 Apr 2026 11:41:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in
 ice_resume()
To: Aaron Ma <aaron.ma@canonical.com>
CC: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Kohei Enju <kohei@enjuk.jp>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260424030345.1140665-1-aaron.ma@canonical.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260424030345.1140665-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0117.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY5PR11MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a67844b-7635-4961-6484-08dea44134bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bIIrprOmxSdVXMaEqEknEicdPrietj9n886VSJoB6aNCVEZg8Fzma5S2OpCmo6yQYGotU35Wx4dk4DQLn18A70bwagxRIwGAmmYoYUBegnvG/UGIQcGSadkNTMssj07CyYbWz5fp1IwmAbR2AETx1nmmmC7TZORug9raOJ6S4zD6swYHtHyAEPfau1js6P74FdEWdmK17h9vj3+beLC8TUNscWGGcnP6d9q9nf4JbaI8HHUhal1PdTCUwmULT8YAIMHgLSwmhzLxsTVRXhJ4ryZlsVVyPsFOCbEki981B8W2cZt/3PWRbShEk9C+gKrAIwr4WDC+BTh83xTRW6vbFYivczsVPZ6JMfZIndXMVsW1e8nRk0GkOAJlgP5Os5aaNWdNuhR2lQMHGbg9F3T008iEYyfXmgXXzGI+uIXP/cvDk+cr3L0m47BgZQxiT1Kd62bTOsEL6DKvFLkiH3DSpBfi5/RBEhnVQUaqa1pJatc8Q8HOMtSG8uZNfK/xZAvZrQ4KK2hKoVtOS28XT6yEmGPH1RemaTfQvTtPhqrKNVBbNH36Vwnmv84fEjrvA5dlzl5xvwNIQg8DlHK6NHm5M5oXiobAPN26TBT5wI09kEWhVzDdjSKZTAP8cCKlHxluNr7goAFGJde8DvPou/wg1Gy78BTUaG03bjbCfyvsGwy2dU8rFfH9uaYUkyrSQs9t/Ak6AaFtj8PsTGcFoC9Q82cS3zoJpMVT/NBymu0P5n0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2wvZmZpRm83UkVlcEphQU93b1RSZ09mMmY0M2lLZnh2czJLcHhCK0drR0FM?=
 =?utf-8?B?YXo1MVFyNlB2MlNUZU1aRUFNTFkvWDVtTmYyUHhQRXZ0eWRiRG9rRmVMZklM?=
 =?utf-8?B?ZlpqU25mRW8zUCtvRnpWWjZjNkVDMk1FdW90SE83WDdINThKT3ArZkpyc1dZ?=
 =?utf-8?B?TUJRcVZFSVJ4ajgvd0xkaUtMamdhdkluM2lrOGJ1bjhKeklBTjZZdmZaczNX?=
 =?utf-8?B?TFdvNWRrSVVjcDg1eld0N3JpMEV2UnJSNnRhWmdBditLT2ovL1FSRnJNcUc4?=
 =?utf-8?B?dzBJNDZRSFpteGhDelJ1Wml0bVRGS0VIMlkrYUw5SHRqMXlnSUhiYkwrVHpI?=
 =?utf-8?B?MWJIYWR6Tk1GK01TOXFYUnNlbSs5bk80NHQ3dlRROUNSL2x0WFZsODdYNkNM?=
 =?utf-8?B?VHVvQXF3eHljejhIejhrNG0xQ1VZdHFsUTVHaURBeDl6cTF6RFEvK3NabnBv?=
 =?utf-8?B?WldHYnpJUkxtcW5HL0tBeU5nTmV6eWVFczZFeU9WYnNkTDVXa1RSb3pwZmts?=
 =?utf-8?B?cmp1ODNVZy9yeFJzMmlDbm1UTUZrYitMK0s5bGRtRVJDdDVwMDJPMHdUUDl3?=
 =?utf-8?B?aHdPWE1kd3dpaXBGaHUvY0RQb2ZpbWoxaDZBUkZYaEN6N1Z3Z1g1K3lDVjdI?=
 =?utf-8?B?dU1EakNYUzNrOUR4TWRMSTJEMmVGZkNDL3ZsLzRIMGpMM1V6dFRuZUh5Q0lL?=
 =?utf-8?B?blI1dmZySGdsdnRKeVVoTkw4WHVYSDhzSDRBbW5LcHlEdktNRXBoNHJQc3Yr?=
 =?utf-8?B?TlhRWFIrcndBVnV1bzZZVm1WVVFkNm9iN0FLdzFrRU91YkcyM2d6ajV6NDMr?=
 =?utf-8?B?Y0krek92YndYckNLa1R3dGFxeXJqRHhvY0ZxcXhOZERpTlFNVm9kTFV5L05R?=
 =?utf-8?B?aEhRS0k1cHRORmMveFJhMGhGUTkzNklXZks5eFJySSs4bHVqMDNNQmRSbURX?=
 =?utf-8?B?SWNUcUorMW9oYnhBdlc1Qzg2MWpreXVRc0xyYVcrdFBCcnBvWFN0eVFBWERv?=
 =?utf-8?B?cDBqMmJ5UVVRNnU5ZkRlSkJmVUpzUllDSUYxSWVhWHczTXRsME1RcnhiTE91?=
 =?utf-8?B?ZU41aVZOYlNaWXBJdGVvZ0hXRm42VmpYUkQ1VTNIQ1YrVGphWUxpcXF5Smpi?=
 =?utf-8?B?cFROQWxWVUNyNHRYTUg0SlZKcFJhTnl1UGozMjJMNlBoK1JtM0NGV1lneHVF?=
 =?utf-8?B?MXlmbU9ucG1KSWtWMUJXNFB4aEZDc01tVlVscEcyV3NPYmJDaVo2NmFnUTBP?=
 =?utf-8?B?bmxDRTlXTGl3bTFhbjhVTUYzQmVQNkNORXFabHB5aUJWTWpUTDUrajllak8z?=
 =?utf-8?B?bHd3dWZubTBjQ2UxeGRBeHZKTG95elNSeDJNL1lvQTN1akNtRDdYUngvbVUv?=
 =?utf-8?B?RUpqK1YwcjdjQ21pSFhiK3VlaTc0bmZVUFdTMGF5amFKNjQ1Q0N6Y0szdmtp?=
 =?utf-8?B?cTJQYVZYRnZlbVFhOExVenhqeU94eEdFazgvS3NYYzQ1Z1UvNlRoQXpWaUpu?=
 =?utf-8?B?SzZOT1Fvdk5uckd4akJWK3A2dTZsM0J4cml5R2lmV210c2pHVTJkT3FFYUhK?=
 =?utf-8?B?T3Bwdk0xVUd1dmx0a1FhaEp4Qy9ydHU0Z1dyZ0IyNXNWdmhaTnJNVFRNUXQ4?=
 =?utf-8?B?VDhKL3gyQ2RnaHNQNlFJQWUzd2NldEpZOEFtOG5kdGZEWlJkWTJOY0QwemJ6?=
 =?utf-8?B?cEJPdGIyNC9tbUlpc0hqWHJ6RUk4d1RjUlR2alhLaHZIZVErbVd0OGFxcTZ0?=
 =?utf-8?B?N2hndDlkUDQ0QnlmT2xueHE0VExaTDh3VnRmLzFUZW1naS9VSGtoTGJXUTdv?=
 =?utf-8?B?QUZPVEw4eUhCYnFJMWFkaS8zT0lwQkFZOHR4TGNiYmN1QVBrWW94cU9WNFZs?=
 =?utf-8?B?MkJ1bHZoZ3lpaitSQ1FLSVBrUlZTSWx6eGl2ZHQvbXN5dzhMLzFCRGNSTGIx?=
 =?utf-8?B?N0tuWjRBMnhLMlErdWUxbE1zbnE1eTBmRlhYK3JrcXlYQUVaU2JzU0p6cFRa?=
 =?utf-8?B?MjJzNjYyNVNJQUZ0YVByeEM4dE1yWGxNT0tyWjdyTER3RkppUXBVY2JZbDdl?=
 =?utf-8?B?ZE1hcWVGUlovWGlrZ0FRRURKeThKaXAwVTNKeTdCT2JDY2g0Y3RidUlFQkQy?=
 =?utf-8?B?QS9tNGxwOFJLTjA2UkV4ZjRtUlJ1UHZzRTVwNGlFK2ROTFcyUWpCMkJKSXJD?=
 =?utf-8?B?dm5CNlpFb2tWVWwvZ3BNMUxjZVFzbXVTTGNUWnpIVzFKNXV5NTF4NHNZRWNv?=
 =?utf-8?B?SFFub1M3Wk9BQkZmVlBRRTZzTFVaRXkyeFJxSjJLSFhoeUdkd0dSbHBlZ09j?=
 =?utf-8?B?b3N3WUZPL050RlBOQ0xSSzJsdVJuSjFnU0hSbzkxc3RaeGpIQ2ZuakUrN1ky?=
 =?utf-8?Q?7EPeDcxkg/d9OTe0=3D?=
X-Exchange-RoutingPolicyChecked: BC8XVrywryV+E51i7dwoS4C4KLMZcoHnmldcYKhhJCRIlVgkgvV22LyAUMeueEiGPOjjoNcq5D5ngbBxgTiEYWu1aIG4J9EXO+vUyLByYx63RwR17yhFXjqXUBUk0KIEPk2FVw/1sSso+WTRWnVU9lBuuXS0EqVKX8/Wjy5NCRU26SJC+ezcnWs/yiai5o090H2dpOGuaeN9ypcevtKtpMZNomgb61KwSHnKNamIvcDFV4W0+oMO38OJ1oM9d83JiDyDgzwBgo/CVgjCzLkwTC+BUuw5WlG0Z5NbehWxlGBERkcqdBg/omDGFt5LaZLJEOzPtAsiNplTsEUW4vCPkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a67844b-7635-4961-6484-08dea44134bc
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 09:41:50.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nD6sa8G+G/Jm+OcXzkGo5IdV0khvvMaDIgDQf6mudxwA6svr67tWqAJOoxYlAMTcGQnPVXHg1om3pTCdjOLAIlI8eyjcsmNW3vuomYlMTHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AA559470166
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-281282-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,canonical.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/24/26 05:03, Aaron Ma via Intel-wired-lan wrote:
> ice_resume() schedules an asynchronous PF reset and returns
> immediately. The reset runs later in ice_service_task(). If
> userspace tries to bring up the net device before the reset
> finishes, ice_open() fails with -EBUSY:
> 
>    ice_resume()
>      ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>    ...
>    ice_open()
>      ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>    ...
>    ice_service_task()
>      ice_do_reset()
>        ice_rebuild()               # clears ICE_PFR_REQ, too late
> 
> Reproduced on E800 series NICs during suspend/resume with irdma
> enabled, where the aux device probe widens the race window.
> 
> Wait for the reset to complete before returning from ice_resume().
> 
> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
> v2: reword comment to clarify best-effort semantics (Kohei Enju)
> 
>   drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 5f92377d4dfc2..a81eb21ea87c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
>   	/* Restart the service task */
>   	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
>   
> +	/* Best-effort wait for the scheduled reset to finish so that the
> +	 * device is operational before returning. Without this, userspace
> +	 * (e.g. NetworkManager) may try to open the net device while the
> +	 * asynchronous reset is still in progress, hitting -EBUSY.
> +	 */
> +	ret = ice_wait_for_reset(pf, 10 * HZ);
> +	if (ret)
> +		dev_err(dev, "Wait for reset failed during resume: %d\n", ret);
> +
>   	return 0;
>   }
>   


