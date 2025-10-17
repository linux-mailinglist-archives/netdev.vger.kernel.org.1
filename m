Return-Path: <netdev+bounces-230264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDA6BE5E58
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 02:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D981888F96
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C405947F77;
	Fri, 17 Oct 2025 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAtG5wzk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA3288D0;
	Fri, 17 Oct 2025 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661122; cv=fail; b=SrzRLCfj5auXLSDETjzLDWAe50KxPANthKSrWUHfUT/fTgQL9HCbJfS9R9zFo0Q81KMvXWxDUnj7/ZCUoKv0FHYlAbC+AtqFxPDV0l2qhf7JV0WWvXfccFMM8mgcME41RYx9jpeSaT/isyUI/PGZCsjvTGluP0SXPTFQCvSclMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661122; c=relaxed/simple;
	bh=AVDNi2RpszKQ0oU3+G5r4LTBip3FZ4nxnFI8WZ0b0Ps=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nt6rkEgNp3rCV5VSOyovTAU0KMlRce1EJE0diFJh1R2t5xiSw5TzmT7IJWb8Cj6ofOT+EXb4jStRTHSO+Wbq7eaMJaJCNLd4RXWdDhTO79PLEfYZOgBl+/CxQs/IUuVolFlfjb1AA7B3PvTNJ1H6hZlIt7otJ8Gy+2UDSB82a78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAtG5wzk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760661121; x=1792197121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=AVDNi2RpszKQ0oU3+G5r4LTBip3FZ4nxnFI8WZ0b0Ps=;
  b=NAtG5wzka4jFbl+ad6VTsuZ/Wce2zVrkyEj2w0lKUGyMPlsDClr/FmaJ
   EZqPTk2Xg0aibEgR3WgJc4+mMV4orFKDs79ewjkl1f3spP5Jis+SmlAQn
   J+f03vo5RFY9h/QHrajSjqxiPf2jicl+oymBleizTF7C5w2iK9HLzsCWj
   fB5Sl3d0tyPtwS2CBgQGmnhRhDCs3GSjmBHeVrZbeMHQTJMfSgSvPc/Jq
   GvPp/xNsZ61ZtIjTVUjpZbjcJiCu+WTeGH3NrZXbUYkEJvrjfnOsUpM8+
   K0ZeaYNEC0alAnwVL5HO9TiswSPqDAvpMU6GGs7ugi/rLSVjsiDoq5oSn
   w==;
X-CSE-ConnectionGUID: Hwuxx742T3CSBK9BWqFmwg==
X-CSE-MsgGUID: 5QwnQRITSGycFTJdSSZokw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62958747"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="62958747"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 17:32:00 -0700
X-CSE-ConnectionGUID: LFdfWizDTBa/l8w75r+JFQ==
X-CSE-MsgGUID: DKpd1URuRF6c+t5Z0sLvAA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 17:32:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 17:31:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 17:31:59 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 17:31:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvJ8/IEWiB9bDpyt73e22lzpZPH/2hmjWUO+3stN+OMYJV9ZKazT0CHnAruThOfAaPPVPLT+RmQYA8yrhPK0Hi/3bYfaDxv449lx93jFEBFzo16tOo3cXmTuiHsn8VD25QbQJjSkf+/lZOGyrBNeCSZVRURnXTFuSWyfsBoUhZK8sYwFBZXgP/Byf78ohfdOZ22C4BeFHQUplN5NljT/TEQW7yzEzu1Nd/VbTBJ2jnKNYR1wewrZOtVQ4grFruCy5ILYMyTz5/6wl27WRP9Qi/CIQPNSs6Z+UBhfw/lLEkTpK+6cl67KTaWvD8YG47ccXODB9NgwOFXYsz0o50oXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVDNi2RpszKQ0oU3+G5r4LTBip3FZ4nxnFI8WZ0b0Ps=;
 b=f/kEIMGtaPPbY0Q+VJceaN/Rl4WLL3WDGotqvjPDVBykRo9Z0TtguLGZ7ZyTGY20W/bYVsTEZuGbiI2iKsg/GyvrzcteP54M2RSv6Rp/uVoKLh7r99n15UnvSVcvvq7Scv3sSV3o8RSHHMIuVGFKt2taXZbzM2aTBl/5m1659fWUaq51FDfa0SKRtenRzOssDY6SG8o0Z62dt36TokQmroQqERh41sSNrUXW78kT+0YdbYx3uhHPOKSYlpGmWT4tFykrMndg5LdcywKBsAxeTsPfZdr1LzrSPUZ4Qslvb+ZsxR/I4KwWhHooFdU6jx01NbIMAXKB+RuFq/qzppd3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB5922.namprd11.prod.outlook.com (2603:10b6:806:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 00:31:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 00:31:51 +0000
Message-ID: <4ae9d5d8-2d88-43d0-95be-ae75f0506548@intel.com>
Date: Thu, 16 Oct 2025 17:31:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
To: Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Nowlin
	<dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, Jie Wang
	<jie1x.wang@intel.com>, Junfeng Guo <junfeng.guo@intel.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Rafal Romanowski
	<rafal.romanowski@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
 <aPDjUeXzS1lA2owf@horms.kernel.org>
 <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
 <aPFBazc43ZYNvrz7@horms.kernel.org>
 <902dab41-51f0-4e01-8149-921fb80db23d@intel.com>
 <20251016165648.2f53e1fc@kernel.org>
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
In-Reply-To: <20251016165648.2f53e1fc@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Rv5A0aXRuOSXz0TPcY73yllj"
X-ClientProxiedBy: MW2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:907::21)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 4896f2c9-51cc-4904-4289-08de0d1490ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clBDZnJxVk9iS0JBUWZCWWtWN1k0Z005MVc1MVJlOUhZZWp5Z08rZ2Z4MWx2?=
 =?utf-8?B?cmVxRTM0em81V3JDVHVWUlExUnRBWlZxUTkxVXlOTHlMckl0eHVBWWwzM1ZX?=
 =?utf-8?B?aFNnY2IvNEZQWFNDdmRtRHQ1T3FySUxVeFBKUERKSXdmZWhDanNRYXdRTzFr?=
 =?utf-8?B?NXhkUWNRYW1uTHJlSFFqMHJnTk1QVmdCWEVmdGprQTFpNm9lWHZodWd6YkQ3?=
 =?utf-8?B?THl2dmJWM1hLV3dtOExSWnZXV2dXYi90Y3V4c01qVHIvOXFuZ0oxWTd0ODFX?=
 =?utf-8?B?ci9LUzF3ekdieWV1Tmk0TWVWbUtkbE80MkM3Sis0YkdHNGk4bncwL2swZEtm?=
 =?utf-8?B?eXJKZmRSd2haRFN6SHI1a0pGK1hha2RaZzBHUjJ5UlUwZUdnSkM0bDZJRDJh?=
 =?utf-8?B?aFVSL2xMd0p5cVZDMzBpTHN2RmVEQVF5eDJlNUpUZ3VUS1E1dlZZQWsvd1Vj?=
 =?utf-8?B?dVVxMG94M1dPdnRtWkkzRTF3NXpMamt3aWNLQ0hYZ1Ixa0lCWUxGendQWDB1?=
 =?utf-8?B?MndFamg0dldnZjJQT3RLeGZFemY2dHppMzlxZEpyYTNtbEpvTVVKVHdibVhT?=
 =?utf-8?B?NHFqZEZZb2hIRWFZWG45KzRyQXFibFpxK2FOVFRSNTROc3dqaWdoaUlUNEZn?=
 =?utf-8?B?aGR0Ykpxc3RhRzk5OFE5aUhsQjBqeitBUjRNZ1NDQ0xrQlRoMzJKdHNKK3F6?=
 =?utf-8?B?MnJDcUZOZVFXMHBxNk5RZURnbDV0Mk1QcTBmaWV1QlVSMlFleUFrak91OElL?=
 =?utf-8?B?MUptL3h0S0s1cWtXTHFaM0hCZ0dxOGJHYjFNTlh3TGlteWg3a1VFV0ZSdTRC?=
 =?utf-8?B?Y2hWdU1yS1JwSm9yYmRkV2JFNnNoMmloeU1qcHU1T2pNYUZTbnFoOWJuWUZ2?=
 =?utf-8?B?dnpaeTZxZFM0S3BreGFYSTBabGtuQytpcUdLRVdmNmdOc3EvU280eUh5bzNj?=
 =?utf-8?B?cExtenJKTnY1UmVBYTl5aVJzSHNhQ08yM0lGeHpPK3FjUDJMMVpPY0ZkcEFn?=
 =?utf-8?B?dFc0LzRnSnE2djBpTitXMVg3NlBLcCtjQUl6OStoTzc4SkdOUVc2RHdGYnNy?=
 =?utf-8?B?ZXBhVHJwQmR1N3BOUGZjNmcwL29TL3Nleis3ZUxGN2ZQZFgxTlRtTEFlMWJr?=
 =?utf-8?B?ZmMvR3RvTW91WTRqZGtrTjFTRjdvUzNHSXJkQ1NwbnU5ZHpGYWF4dEYxQVFm?=
 =?utf-8?B?d1VVNWxaSnhRNG1FaW91dEJVMXFodmF2VmM4V3o2d2M4aXJIVXA0U1JGa1Ra?=
 =?utf-8?B?Z09iZTBXdTZyaHo0OUQ3eUFYck9HRmNrSmZrWEFPZ3V6citkbjR0eUZRRFNr?=
 =?utf-8?B?UzNUUElpVEt0ZEd4N2RqY1B3L0cxT1MrRk40dFNYOCt0WjliZ0U2RmU2NDlR?=
 =?utf-8?B?cHMvV3VHWXBReFdRMEJVcVRGSkZ2UkZNbW1BNFdiTXEwVzB0enVvTWo3bjY4?=
 =?utf-8?B?aFZERUlOOU1QRkdIVjJSdVptQzFBc2NieXpkelErcldyWGxwT3ByMG42bURZ?=
 =?utf-8?B?Q3ozVEhZVG5uNEI1WitlRlZOdDB1b2lTaUhmb0hEaC9TUzc2U25ybGFwa1VW?=
 =?utf-8?B?Vjd6bGp0RUhIdGxDMFpEQ2d4YTI5Y25WakZlWktYeFFkZnFtdW9JYjVyQ1dN?=
 =?utf-8?B?bHlRUXUyVy9uSVdPMERVbGtnZUIwYzlvRWhEMWZSeElRM2VjZFVZeVBJTXM0?=
 =?utf-8?B?UDJmUURMa0ZKS2gzVDY5MnRLZ2lUMlFSOVF1aVp4WXJKQTR0bFQ0Zk8yQk1p?=
 =?utf-8?B?dDFOSHZ2KzVmMDR5dENVOG9iTytyQ01jenJhREd5eHVqQ1RaOTNFODZ1Smtp?=
 =?utf-8?B?L0JONktob09zV2dBT0FnSlZhSG9Kc3NFTEtpbU9qV1ZOMFFrYTcwdU00WndN?=
 =?utf-8?B?bXVCVktjOG83SFlvL2FvRkdmNE5rVDJMU2d5N3ZkaXhXd0tmUFFDTmtrOTZQ?=
 =?utf-8?Q?ioZZiiueQqw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHAyQ2ZkdnY5bG56bG8rWE53RHdJTEhqSXZ0Q09yN0RpNElaakVlUG93ckVT?=
 =?utf-8?B?SE9lTmp1UlZWRVAwTWg0eVRodXgwNEVrc0x5Y3h5VUhzWnlRS1Rydmt6NUV0?=
 =?utf-8?B?Y09HTjlMbU1aUG1hMllHRW5OaWRycmdjVVJvNkZYbEsyYTA0eGR6djZqVS9u?=
 =?utf-8?B?dFdKRS9KZ2xxUXJnQnpHUnVXeUZZcHpjb2dGN2RuakJnc01YNEtGZjNoelNZ?=
 =?utf-8?B?SW5NMVdrM25vekl4bm5rWVNOL1ZZSkFtVFh4ZUJSUFY5YndmUEJDUFJGZCtJ?=
 =?utf-8?B?MXhzaVVVVkZPZkdjQjRhTVg5N2JqUXM4QTJQTE8rQXluTUV5TXBVaGF5L1RH?=
 =?utf-8?B?djhvbE9HYU5ad3RZWFQ0eXAxL0dkemhOWHZlODJDRGx5UnlmV0pnMmRJSFRB?=
 =?utf-8?B?SFlDc1lPZTluVVN0MThxMU9Vb2JWLzhnOEpMUk1oT2xpdUJaN0V6NFFUWGE4?=
 =?utf-8?B?TGFVcDhoQjQwUWE3Zm1VbUc1Tm9TTUxJU1h0MXZlL3IrVFQ1RGtNdHBoaW81?=
 =?utf-8?B?ZVR3SW02emFYanVlRUhUSzhsQWg4N0JxLzdLaVptOXRzdEtZOVg5L3FJOFZz?=
 =?utf-8?B?MlE4b0owNGdjMUthOXF6WDlIcXdCN0JmU0JqVlV6c3RyTVZrSzBqK1VzWjJE?=
 =?utf-8?B?Q0YycHFiZU9mQmxVUzZqdGFiQTZ0Q3ZUMUdWZ05QNXhjbm4yNHM2cjRpM05W?=
 =?utf-8?B?UEJtZGxFUXp0SGFFdndNdTA0d1hublI2bWhFZk5qYzR5RTRtOW0zWlliT2do?=
 =?utf-8?B?TUd4QjFTMTBvOE4wTEhHODA2dGxnZlRZcUlNYjZ2TThxOGZ0M1Z3WjcwcTdD?=
 =?utf-8?B?dG5kdXplanlCVU56ek5Pc1V5SCtXcVdoMFNaem45ZHR4U0FOT3BDd3E5Qmsz?=
 =?utf-8?B?QjNCZ3psOG9lTFZSeS9BSFVRdlpzY0syQjlIREx2TXdMV2xnaEFGMitHdWl5?=
 =?utf-8?B?VklGeVNEdFdMRkpDWTl2c2MzaDZFRFNZYjV3cEdmaTNLTEV3UFRtRXVNVkY0?=
 =?utf-8?B?WFpGd0JKeEJ2UWtURzR3UjU5dTJGREpDRzFiSjBpcm0wMFVhTWdEaFNaM1Jh?=
 =?utf-8?B?Z0VxRldZQ1B6dERJRFp6cWpPVVhYM3ExNVlUY0F5Rk5UaW9tSkhubktlT1V0?=
 =?utf-8?B?NlBVOTFqc3l0Lys5cWxVTnZONEVHVFBRN2daeXg4TmtWVDBBSlZQYzJZSllj?=
 =?utf-8?B?dTJDbnlLaWs0M08wSlE0M0VFamhjMHVReUFIRW5kbHBUaU8rVWxvY1g0cVNh?=
 =?utf-8?B?dkkrck1vOUFBZWEzMlEzaWRGRlY3b01vMGNuaG95Ukx5K1JCNHBPNjB5OTEr?=
 =?utf-8?B?V29wVnpxc05oT1dWYWRuZUtPY1k2SGh0OFRLRVdncEhRbTFaNXlPdUtwRFVY?=
 =?utf-8?B?WUM5N29mTm1kc3dseTZGcmtSMFdueCtkd1E1YlU2LzMyYmQwNzl0STF5RHhJ?=
 =?utf-8?B?VU05aDg0MUpNczYwMElwanJkUHh5THE0bTluT2k0U090dTI1bWlQL0o3eGZk?=
 =?utf-8?B?bWxuaUtDR2xQU0lQdjYwdDhLV3hJcWFicVd5N05EWWExcTdDZUxPRTAxSFJ0?=
 =?utf-8?B?aDZsdTFob2d6dXVTeHg0b1AvZUY1VXc1M0RlQnMxNzBhdnY3ZmZuZlFIYm1J?=
 =?utf-8?B?YlhZQkRNeUdwZjJqelE3UWdwSU1pcjlGRjVLa0FuTy9lTWcyWU1zalNsbFF3?=
 =?utf-8?B?NDRhRm9qdmk1MWdzcGxuOUp0eVdyV2pKZ1VHeGY3aE5XMGovb3NNcWswOWN6?=
 =?utf-8?B?RDk0bitOeFFxQnExbHlDbnlLZUxWTUZkb3MvMjFHM1V6V0lpaG44QmhRbHV2?=
 =?utf-8?B?eE9uSFFpLzBpM0EyUXNFK2hqWE44ZUJ6anh0Nk5TNmI0U2MzaVY2Y0JrVzBj?=
 =?utf-8?B?eVNVRXpCbVllcElJSkt5ZEg2aWpRYStJbG12bHN3V2ZIUGYrWDkrOHZWS0l0?=
 =?utf-8?B?WEh0bklzcVRJbUxWQVNlMURMWE56bHR1S28vUGltOERVOTVRVXRuaWl2M0s2?=
 =?utf-8?B?blpYUzRmT0tJRXJ3V0NyVzZBUk0wVDhrd28wQ3VxNk9EZDZ4aU03RzVPN25K?=
 =?utf-8?B?QlFEeGdjdTMraEdzRVVIT3grV0kvSDZ4cmZIQWpkOFRuNlRZSW5rdnNhSUlu?=
 =?utf-8?B?WmFtS2dxckYxbVV3eHJGeDNKZWxpRFJhVVY5QjBCRWo3emNUSHIrak9BVXFs?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4896f2c9-51cc-4904-4289-08de0d1490ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 00:31:51.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5qzGyNFTlNhB7yfYhL8xen1e6jaPHgUaUDmiRuFnsdVzaYqi0/uei499t4bICYBLQOmfZRsP/kE8R12p2PVsEk2L0TQ9pAOyJKtbMMwKuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5922
X-OriginatorOrg: intel.com

--------------Rv5A0aXRuOSXz0TPcY73yllj
Content-Type: multipart/mixed; boundary="------------r87B772jULzg5N34jB7KlZ6E";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Nowlin <dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Jie Wang <jie1x.wang@intel.com>, Junfeng Guo <junfeng.guo@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
Message-ID: <4ae9d5d8-2d88-43d0-95be-ae75f0506548@intel.com>
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
 <aPDjUeXzS1lA2owf@horms.kernel.org>
 <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
 <aPFBazc43ZYNvrz7@horms.kernel.org>
 <902dab41-51f0-4e01-8149-921fb80db23d@intel.com>
 <20251016165648.2f53e1fc@kernel.org>
In-Reply-To: <20251016165648.2f53e1fc@kernel.org>

--------------r87B772jULzg5N34jB7KlZ6E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/16/2025 4:56 PM, Jakub Kicinski wrote:
> On Thu, 16 Oct 2025 14:37:53 -0700 Jacob Keller wrote:
>> What version of git are you using? I'm using git v2.51.0 Perhaps this
>> isn't a b4 or git issue but some other tooling that is causing an issu=
e
>> (patchwork?).
>=20
> Looks like patchwork, it serves us:
> https://patchwork.kernel.org/project/netdevbpf/patch/20251015-jk-iwl-ne=
xt-2025-10-15-v1-6-79c70b9ddab8@intel.com/mbox
> which has the -- "corrected" to ---
>=20

That seems like a patchwork issue which should be corrected, in the
event that someone accidentally or intentionally uses '--' in their
commit message.

> Doesn't matter all that much cause there are also kdoc issues on
> patches 4 and 5. Obligatory advertisement:
> https://github.com/linux-netdev/nipa?tab=3Dreadme-ov-file#running-local=
ly

=2E_. yep. Turns out our NIPA automation was down while Tony was out and =
I
didn't get emails, but didn't think to double check that I got passing
results either... Hooray.

--------------r87B772jULzg5N34jB7KlZ6E--

--------------Rv5A0aXRuOSXz0TPcY73yllj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPGOdgUDAAAAAAAKCRBqll0+bw8o6G/U
AQC8+AlLOs6IiJSokr9ruDIw9xCIltDWiTzDfAouXjQkKAD/adOax7hyuR6VCnaTTRk+JLoKY3Q9
NLtexRWjjEdPXAg=
=C9Ov
-----END PGP SIGNATURE-----

--------------Rv5A0aXRuOSXz0TPcY73yllj--

