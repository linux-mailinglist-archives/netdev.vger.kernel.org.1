Return-Path: <netdev+bounces-263283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI1WA3YAp2k7bgAAu9opvQ
	(envelope-from <netdev+bounces-263283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:38:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A285F1F2C97
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D142307B56D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937AB49251C;
	Tue,  3 Mar 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/Kz0H5L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BF48C8C9;
	Tue,  3 Mar 2026 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552039; cv=fail; b=XKiK6wdiGqy9rlQQ1aVArtL6L7cSVMPz8MFxsCA/dVdA91tthDAow38HPa/zwGqfE1/ogdG1/BzhhayBj+MXLXufXY0cPwMQSr87a/F7DakNdbq1VVNXO9mHieTEYXa6TMjqNpGbQtcNSU5DXAnHlceU3EnxMVPmLcZcE7aEUOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552039; c=relaxed/simple;
	bh=IQHMJDhdCwKffDVjHhfTAgfVDATmiq2es6aYANuRauw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WOEZsNQ5dtsO2WRHLNA9sW7IZoRMZciKXYIA0FqFdx2EgqWw8IKqHcq3qTgP497ELnibEbzkmV/Y4ncE7/ks7bW6wfKC6GAu3RTwV0ZFFvDkFPp2kxMpnF4GPLTbkz42Kg3WCxnWDPF/HHGMi2QiBGufej3sYcaGGpoJbHPsF1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/Kz0H5L; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772552037; x=1804088037;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IQHMJDhdCwKffDVjHhfTAgfVDATmiq2es6aYANuRauw=;
  b=I/Kz0H5Lea2H3LvYJCvyj5IOzL2jYwvJ6t/DPupD/xIDlYjxvhUq2dre
   YpVbGymkI4hZD2RnyO/gWnZ3sZW5N2QVPiVUg/fMElL6+4WiD0mBNaoYO
   ny+Bjgo8hEc9LH1fO6Y7zAwx7crryDUvddtJEpV6gGBbq9KRoWKgrZ8RT
   3pPtwYWeZgLubdBj8aCJdS04rKX6bZoBnCR5c2ovCcWXVR9+z6goSDiRV
   9XjdDDM1+8982UGsABBD2qfTXvn9NBcK4OgeS8JI20riQ8hSCajyB2t0C
   Fmup6kKR6in30IZDKZUwUPYF9I1hYAFRSpK6qE9pfJTPjZPgFIOaNfLqM
   w==;
X-CSE-ConnectionGUID: 7jgKdaTyRLeCA2YjGfXtJQ==
X-CSE-MsgGUID: NC8Dmlr+TNCC9gGIJuKFbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="85060916"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="85060916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:33:56 -0800
X-CSE-ConnectionGUID: xI0+nEpETDWTsho+Z79V0A==
X-CSE-MsgGUID: /rHU7s/4SvO2dPNfrpY7iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="222515398"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:33:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:33:55 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 07:33:55 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E533ndHIC/hX3/cZNuMQ+QJ5zNgkrFMAAGHz6x4o+zLAIpAZRvw9QrFO8Xj3ENOswkU3Re7MfU5+OU6sa+xyia1Qaq6ijQS5iLGNGYWgCZslSoKAY1qPVUCj6B9kZjgdDm5a2lPllh9oMhG0/RSm94ebS6Jupay42ujy99VbfpGWW5C/FQ7TXrDCX77qo2hezK6xYGsF/RFkOqi7MFXmwQLrH2eeSlGBs+O/QeD8s24TvPmVeesx7GG8u2pB2KX31WVcjp0rIgnrQUReKgMr6hp5R6QO0TOwSE3LiHb8NLwkS3F3FmMOKhDY62sq/O1s9apTxNzVI3rzWgRkApUacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeVGp7SRAR266s0Bcb2L3/uKtupEctv88kmJtFkppLI=;
 b=urvEKkqxJQvfKticoUYankSny/u3f0GGr5H386Jpg/++qdlEeqPAcdsh9+eiHXobGhxxqvx5qJpB02NDHpeWmWrUuYd4YOF85DJNtjAFHft9A6OyGtem7mDfWNC+DYeP/wq+T5ooregKI4kkEBZB/Uy70YZfsa5A0HWOBQi1VLmuKEAQyLrzs72MBznl5MM0UWyZ3O68KRJ20VaNDcclaXEUAnri3WYu0rOLEDf/KDimWu0eI417qo3M8bydGZuplYM7uEUTJ1tY/eze1CyJpEIUzQQVMT1ukh1aNoGWyd8xVzf4trbnrxuJwQLxuvz/XF2qm5/dZ6UvM+XewI601Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:33:52 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:33:52 +0000
Message-ID: <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
Date: Tue, 3 Mar 2026 16:31:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB
 enabled
To: Steve Rutherford <srutherford@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Decotigny
	<decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, "Sridhar
 Samudrala" <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>,
	Li Li <boolli@google.com>, <emil.s.tantilov@intel.com>
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260227203457.558196-2-srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: d57193c1-065d-4483-336f-08de793a4624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: gICs1pPXiCbNbQMzJ7ziRs/J5/vByckN4IVlw3LPP2W+7EkZsa00xjA7xi6Zj5TDnx3Nw0RF/S6DGnm5hzUh/7Pg21IxcLnJ8cvRUTm2cmrtuovouLaRjMhGcHkrxdCcqyeQbTHPS+2arBeDhaWVraT+irNz6v1A2U6sPGD8ZdkOlYhvdFpSyWVwyzGE6QBQDRt1XlLqEd3UCgL491ZVW6Oeu4dSbtNa8viaxBTcTQOf8oI4AXfuwi/TLoomcTHbCiznJUmYJgfANaI33120KIxGvZ4/U9/Hedxqc25XBOJ8MTxJ1wvynR5VZTpo0zQV50YGyOSeOe3HGS6oKtSoqC2o6fUWgu8d1uZ4OV0QADYAiKc140wr/Nvjy/eRGqiMgXCaoCdRxvcGlT3PHuUUfpNPXAZ1bqK/630Im7ZD5dGEmJo1ZeVQj+gJWsagyH+z9S9ney0qAyakgQL3KV6go8lpCxYaaJt+cS2GmtPhP2m/yBnmn4f7vUbzLEQsPkVlyF6i2I+CUPGyvXeNX/jlKGD79sdMhJzw/Zhd93WvLSXk+mOCNI2uXPqzZmBuQOAEhZiauc3+KP/LdP3sisezMMKN/CJyLdnUTdoRMCP7488+RFD+W+uZATppul4heVZ3XtYezgHXtgDYz/9fQU8u2rxDKWcY+gNf4QT5c/CJEITErximE11i5wR5De32tN7N+0tA92JmI5Ij8K6M0VqaN+Szk+Ar5JJt1qn4MJpEByc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJ0eUZpQ1JKbEhGN1N2TzU5dFJwL1dVbG5HNWZLU1VIb0RUcVNkdkJ6Kyt6?=
 =?utf-8?B?SVMrQW1sMTdPODRBRVBwUWw2VExLcnFRVUFwNXY5dVFaM1JxMXJ1NjRScVQ3?=
 =?utf-8?B?Y2hzYXExU013LzcvQ2hZWC9aSmtJN1NGVy9tMERITmFYZjJzclo1NnJSbnRO?=
 =?utf-8?B?TlVBZEMreUxFcHlkRjNqbVQ4MU5FRXF3b0RtbVFjU3VRdEtoMzdDUUk0eFdL?=
 =?utf-8?B?KytLLzFUVjYzUW4wdW55S2VHdFMvT2F6RVpOdHF2aG9uTUp5OXRlNXF0TkxY?=
 =?utf-8?B?V0xIZGhqR3hQT0VFSlUzT3JTSmcxQlRidTFMcDFRME5SZURTK3F0RWkwOFZH?=
 =?utf-8?B?K3NJdTNaZGoyaFJCMUpBbzJPUGY2YTF0akU3SnJlbGo4TE1SMmhST2lvUmdL?=
 =?utf-8?B?UWF2Z2lhbHc4cGMrZ3plOC82OTRQb0gzeEhXc0V0QjFrN0l1Y09VWmxNeHBw?=
 =?utf-8?B?T3ZVNnJsSzVlSVhjTkJ2VTMvaS82VEQrM3ZPNndyVnliWm5RTi9jN3hRUVZm?=
 =?utf-8?B?Z3NIT2c1L0x1SzB6b3RzOWlXa1VLYVkzbzMrQ2VQZWFaSC80Y1p4bFhlYkJQ?=
 =?utf-8?B?Q1JvT0hxWnh3emhCUTZvU0VOMmN4TDVIeFZFVlRRZDNrYzdBaHFJbk9KT3pa?=
 =?utf-8?B?emczNFdGc1QxSUlubE9pQnplZ0pDRmZpQlVyOVpTbTk5bTQ2Umt5aUE0ZCta?=
 =?utf-8?B?TlM5anFaMVRwL2RpTk9QZmhwMEVjNWc3dU9WRUt5a0RiUmFaanBTeTM5RXp2?=
 =?utf-8?B?WXU3TnMvYlpOM3Vua29uUkp5dmw0WUZpblVOYUZIZzJ3eGMydTRTTS9UM3A1?=
 =?utf-8?B?dDZha3hkVS9uV09VUjNxQTNhM2wreVJBeU5Yem4ybW84a0tzbFhtbU1obUFU?=
 =?utf-8?B?MHhLVVhMSmRnZGhtWVJ0ZE1jYWpSZXlnVHhBMDQzbkowNjE4bmdBTDh6RmNX?=
 =?utf-8?B?V1NGOW9qVGM0R0t5TEsyeGpxRDU0YUVmcUlrdFcwRE42dHpvczUzMktTU2Y1?=
 =?utf-8?B?SEY0Uk5xU21BWjBndmVNbWVBTUw2bG5hL3l2MitLMkkxL1kxaFBkU3RUQitD?=
 =?utf-8?B?dk1nc2ZtaUswa21va3NaQ0thMEx1eXVqYmxmZnFUQWY2dExDZUNsNzV4Z05s?=
 =?utf-8?B?VHZwOVk3QXlvTWlVcnRtRHdDOHlzMFVvQWYzay92SmltK3ovVXpUNWREUFVY?=
 =?utf-8?B?bThINzBTalQyTkxhYW1ZRFlSL0QrblNKMnMxMmZ4ck4vVEtra3BGYm43SS9G?=
 =?utf-8?B?aGlZK2hybHVnSi9uaG1tcVdmVVNoaXVKaS9tWmtSNzROQThqb1VCMjBXWG0x?=
 =?utf-8?B?YjlsaGk0UDRRTVdaOUdiMG5FWFA4Z2hXVVYwdSsrZTNFSEdQOU1RZHI3TmhR?=
 =?utf-8?B?TnBuQVpFTlQxQXlnRVpQVjVtbmhTYlNLanE4R0RKd3NCRUdJVWxod1ZWVFRa?=
 =?utf-8?B?WmZuOFcrSS9jYXpieEdPM1p3RGhCQnZwejlJcG9NalZWMEx1MEtNOFpYcVEw?=
 =?utf-8?B?Tk0xODBBZWx5LzJiN1FGeDdoSjdRYk5CQVlHTUVYdnFBb2s0VXNXbHRRbHJB?=
 =?utf-8?B?d2t1eDkvSy9VSDM4RU5kMXA0K2YxYXgxc0NwODdrN1hab090NVdydzVGelVQ?=
 =?utf-8?B?bm8yTG1CN2pVTkxXR1E1RWFGRlBoNmxyejBmZGFZYUx3QmFIMkprUDVnNzlm?=
 =?utf-8?B?VStrM0NVdU1LS2I3dlh0V3kzZnBCVGtmMVNlbHEvcmJmYVVsdDNKUmhrTTJO?=
 =?utf-8?B?RFJaMGtaUGpVR3BybG0vNnJJQlRwektlWklTaGVHcnl0c3JYY3dveGFHUExx?=
 =?utf-8?B?eUE1Wk1CWVdjdUFzRHBadGxWcmhXNU1IOU14SnV0KzBObEhnR0daWStiSkQr?=
 =?utf-8?B?eWJURkxTKzg1LytpSHNpMFZGWE1jZXRBRzdEcTF3Vkt4YzlCS2FVUFkzbDZI?=
 =?utf-8?B?eGFUenlsYlVNUGJTY0FtNkV3cklpUFZSandCZFVIQWdHNEdESjd5czIyVEhj?=
 =?utf-8?B?TlZ5bUIrZlhuaWt4akUzR1l3MGt2aElINmJXOTFSZFBoZCtLUjJDaVVTMlZi?=
 =?utf-8?B?dEFoQzk5bjJ0TkljNEhHaHUyMUZNOEsvU1JXN25OUnoybVFncFI2ZUFacE0y?=
 =?utf-8?B?RVdLVFZueTRuMjRnamV5OCtQR0dRQ3ZlVHVSWjN0WXBzQkozNmxKNWQxNUFn?=
 =?utf-8?B?anVqTE1RYVQ2UEs5MDc4MjBDWi9sRXJZMkUrVjZLN1ZlRHUxZThjTHFUeWdQ?=
 =?utf-8?B?MjBxR3A1UlBrOFkxU0VTeTdpZDliMjNTZkdqQ0VMTTArY0N2Ky9ZajlqUUhT?=
 =?utf-8?B?cHl2cXpoMG5EV0dQancyM0ZHRmNkTFpmOTZ5UHM3M0VKUHBYOXRUSEcxb0FN?=
 =?utf-8?Q?BycsIXlxcTmoRVx0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d57193c1-065d-4483-336f-08de793a4624
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:33:52.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcfAqRUBuYTHBUp5tmWEzMUmDFFYuRepLXXCBUCAZJ3DWc62xedxyT9OXvWIpbRXHpBFTLMoYf1KNRSYu3fX17kk7bMoO0wNb/6jLYzxv7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A285F1F2C97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263283-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Steve Rutherford <srutherford@google.com>
Date: Fri, 27 Feb 2026 20:34:57 +0000

> When SWIOTLB and header split are enabled, IDPF sees empty packets in the
> rx queue.
> 
> This is caused by libeth_rx_sync_for_cpu clobbering the synthesized header
> in the workaround (i.e. overflow) path. After the header is synthesized by
> idpf_rx_hsplit_wa, the sync call pulls from the empty SWIOTLB buffer,
> effectively zeroing out the buffer.
> 
> This skips the extra sync in the workaround path in most cases. The one
> exception is that it calls sync to trigger a recycle the header buffer when
> it fails to find a header in the payload.
> 
> Fixes: 90912f9f4f2d1 ("idpf: convert header split mode to libeth + napi_build_skb()")
> Signed-off-by: Steve Rutherford <srutherford@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 3ddf7b1e85ef..946203a6bd86 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3007,9 +3007,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  			u64_stats_update_begin(&rxq->stats_sync);
>  			u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
>  			u64_stats_update_end(&rxq->stats_sync);
> -		}
>  
> -		if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
> +			/* Recycle the hdr buffer if unused.*/
> +			if (!hdr_len)
> +				libeth_rx_sync_for_cpu(hdr, 0);
> +		} else if (!libeth_rx_sync_for_cpu(hdr, hdr_len))
> +			hdr_len = 0;
> +
> +		if (hdr_len) {

This is for a very old tree I believe? We now have
libeth_xdp_process_buff() there for quite some time already.

>  			skb = idpf_rx_build_skb(hdr, hdr_len);
>  			if (!skb)
>  				break;

Thanks,
Olek

