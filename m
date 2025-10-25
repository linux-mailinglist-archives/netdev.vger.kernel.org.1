Return-Path: <netdev+bounces-232736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DA5C08749
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 501954E42B3
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 00:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E31B0F19;
	Sat, 25 Oct 2025 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfLsPfKj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648215667D
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761352789; cv=fail; b=LUEjC//Jc0JwTbjlTTAth8pdiU6hr227rx1JZ4KbxUHP2rlC5M17/LNAv++P2fwyrOMraAUmnOw4icnips8ijSbo/AX3aKWjEu10/UVi5XXyejoIGtbTshi5mVqTNJAWnW/yrH3Aw0mGzM8iEzp8pPOIE6/9VUp+Om7ni1Ixtho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761352789; c=relaxed/simple;
	bh=DHHTyDkhhijrJn7i9fl0aez0VCIz3C4/vpCOCHGTMlU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UMtCYHERQQbuXx0qz1dH0sTnD3UZuUk5/tILmpja/hSaPCuX84vyiTTF6eWcH1Zo359UOrRMGrdV/zHegmopA4QYR6kCWL0CHkVhXsO6vXfL0NXQ8A476zETGBb/sXxddYl0UhqAQrlr/mlZE2CrRXLDxlAZp/IeIAzNgC14rjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfLsPfKj; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761352788; x=1792888788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=DHHTyDkhhijrJn7i9fl0aez0VCIz3C4/vpCOCHGTMlU=;
  b=SfLsPfKj8ZU/P/r4P+wrJ+33tfdIHRT9am+4DDrbxuNBvgyc4NxJzHqv
   IbIJ4G+wxcfxkQeuDL0pQL2VF3nNUizj1pzg3QAAj6OJrqswsvoiU7BGD
   Ey4ARgDFNf/dHtCxrgp7hTuvzOhnpZT1BpM09Dq4rB/cadE5JQd1BsdGk
   LiK8zQhpGCYTZrKEkcOXIqz5kJmw4iLIpu3FGf0CVrOYYkH/E86Wn8Qx1
   +sOk1k8gOWrkoaSYtNZHj5VTBfwmhUOi8mMwtIWBAWawELpo7HuFYqUFb
   mABSdxq2rz9l2sMvBZyDgI7XgcO3tQGZMmGRUMrAhK+pSh2V2AJgdoMYy
   A==;
X-CSE-ConnectionGUID: yCl5Fp1UTeencfofjYaF+w==
X-CSE-MsgGUID: z3XWruG1RSuZ77V8zR8rIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74210130"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="74210130"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:39:48 -0700
X-CSE-ConnectionGUID: +WMyaiceTFyfpi5H5BFgLg==
X-CSE-MsgGUID: avMW4XOOQt2ySqsVTM+yKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="189794153"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:39:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 17:39:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 17:39:47 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 17:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWfvEq23wXE/I1H+rNjB7wf0/NgeMQWuOTte3TOahMz+Omo2Q/LMMn8lSWqrY4m5YAUjWkJEG4HxY8Qn1ZePpQ4p/WrY7e2nPDVRC3u/QkZIG2I9+R3EAPzRGoFe9BfLROJHp8VkHkLde2hk+uHhGOVq9ilQ+SAJjKiTj9Jqg3oeG82hEa2Pp5sSn9fqT3bDy1/DTPMO/N9XWpcl2obAmNawq9oZmvcaYwNI4yItcRCrZnZJaO44xY+CsSCyNIhr5Gn+VpB9Jg+uLf+vLyRJ74cRV3SDAlLygWkjjyAhAWsUIdmoiDkZZGWMLb+nj5AhudtUtKSHTTom6E1B8hmDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHHTyDkhhijrJn7i9fl0aez0VCIz3C4/vpCOCHGTMlU=;
 b=oQcbe6T2W+lWNwzdojiyDhCSv5TSWTF0qisxsyEui1l2UnlsnegywR3k4hWpP4ffqXiMMPGjkP2q+Uc5oHceifED8C8DrXRknjq7SOzgd8Xwu6k68iOyV8Z7Fatod+xkgGix6hGZFa0fqzgNzNCaEDBrneMGiOLDJmPG7wS6+0+bKznX6zfSKIGotAa5I7t45p+dtFu25B7n9X7Oif93jBGRjGKv17u8zTD5rn9hTjeB2Q1Vt2craaU4/4/IndUzTkwLhr+HB1MP3i2GqMwliWyTY5rvHnIMcQ5eMHPIbXS/xL1GCfoIlP1SdI7jOUgzQH8dR8n7JPvYDc0bxjskbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 00:39:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 00:39:44 +0000
Message-ID: <83c44cd3-58d4-4232-be7f-751d2798a059@intel.com>
Date: Fri, 24 Oct 2025 17:39:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: txgbe: support RSC offload
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
 <20251023014538.12644-4-jiawenwu@trustnetic.com>
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
In-Reply-To: <20251023014538.12644-4-jiawenwu@trustnetic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------UBIpQgfAH1N3TdMom1BfZYno"
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da87164-e5dd-435a-6633-08de135efe3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2sxTmtnVnR0YSt4LzVOQ1hOVzdudUN2KzR0SFYyY2c5SERaSEdlZEE3bHUy?=
 =?utf-8?B?MkxaM0tEZmVPVlNjUGlrQU81NXBYY0IyUUF3QUdpUFlSbFFRaDZIQ1V6Q3FT?=
 =?utf-8?B?aEdjMnRMMjUwbUZHQnQ4N25Uemp5cEJoMDFoVGhnMHc1T3RBMVh6SHE5OHZv?=
 =?utf-8?B?TmFWUUxSMko1M3NIbVRQRDc3ZjliWnBDUkJGaWdHaGdYdkcyRzU5cm04d0h5?=
 =?utf-8?B?KytEY3FNZ2FnQ1JvR01Vek9wN0pUdkFLaTlBN250SlY5VE9oN0lPZXNxOUJH?=
 =?utf-8?B?bjhoY2p3U3JvK2M1aSs5Rzk3SnhPREgzZHpxUS9yMHNIZWM2Zll1aVJMQmZa?=
 =?utf-8?B?UWtKOFd3dU5XNVBTVkw3MFJjaUdaMVZBNmt0M3gxL0JjNHJIMXhGbWI3NFJj?=
 =?utf-8?B?eTA1VmJkeEcxTnFkbUhzSHlyMFArVHA3QmhDR08xQk9KWjhwczBYYWdxemww?=
 =?utf-8?B?U2oyTm1RVVgrb2Ric2VjQ3FEc0RzUmdiUE8wSk9rN2pOTzVpaVlNMkVKUXVa?=
 =?utf-8?B?d2ZZUUExYmlZQmUzTTFkdTlTQzQwTVBJUWhaVzZnK3RXTVFWelNNWEJyZnVE?=
 =?utf-8?B?UVdFelBCSzczVVJpU1h6NE56cFN1VG5UQlNEUi9ObzlPTGNPNnJvWUVzdFcz?=
 =?utf-8?B?ZXZSTml1T1FwSTl2Z1ZhNVJyRHdIek1kQ1FPMHZ3NzdGeGg5Ry8rNnVlZGlv?=
 =?utf-8?B?ZWhLWFVvSFNwOGhxWGpRS1dRL0ZjTVZKYVpFQ0ZSUWczb00rOERGcXlYQ21B?=
 =?utf-8?B?Wi8yL3FwSW9jam9GNCtpYVVsV0Vrc2k0cVRoSHRydStuajJucDB1R0pWQStz?=
 =?utf-8?B?b0tMNE9UM090MHdsR1JhYXVTMDZGMCtEaHJWbmdBK3JIbDg0MTNna1JxdTly?=
 =?utf-8?B?b0d0WGs1LytlcXMvcThPQzI1cndJRVEwZVZiNk90VW1oUllxSzdPcnZ0Lzlw?=
 =?utf-8?B?enJMMEFybFBPMW1MM1VXU2tJc1FpdVNxaHlIUzFxK2RXVVJTT3IybmJuUEZt?=
 =?utf-8?B?M2VoRVliUi9wZU9yczJWSFFmWHU4blFOVDJVTzJhNEgvby9QMnQybExrUGtR?=
 =?utf-8?B?K0FVNWVrNGtHWEV5WHlDTmt0Sk1OTklrK2VKdmI4ZmQrL1UyZW01WjY4dWlQ?=
 =?utf-8?B?TGl3YUhTSkM2T1lCUDlpQ0tMUS8vVGN6N3UwVERhZGJlYmxOTEZ0STdzNUt6?=
 =?utf-8?B?V0s0eElKTUVaT0pvTjBYL1pOTjhjV2w3YUNuRzVndTVlN2ZqU0habUdNajAx?=
 =?utf-8?B?NzlRdFExcWNGNFJjd0RTTEc1ZnYwUjJLTkVYOS9DSG52czlCenFtZGpyQUd2?=
 =?utf-8?B?YXhSbnBNZHJRajNTbUhTamNmei9tODhGQm1NRUVlZEM2WGlEUi9YaGFJL2lR?=
 =?utf-8?B?YUNzc0tmUGJpSFZjQnRyVm8yWTBBQjYzK1NYbDRvSnp0SEpZM3VZbUV2NlNq?=
 =?utf-8?B?L1JkQ2lSbzFKb2pIanYvNnAvZ0d5YkF4b3c0cFNvOHViRGZhcXlnSWs1aG1i?=
 =?utf-8?B?cDhGN3UxdllZL2xnR1hsQnpBREcyTGV3TVVSVjNMMG9XR2Z5UzBkRzBvem9I?=
 =?utf-8?B?bUNSY296WlM0T0tpYjlrY0EyZHdXNWZ6dzhWQlF3YnVuZjIvNTE3Vi9hYjRn?=
 =?utf-8?B?RTM3VGgrdnRkS2ZIb3FNVnNqUlpobllZYXI3TXNISHUwUmVpT1ZHNnlRclJO?=
 =?utf-8?B?T1ljR1ZLM1hyLzJnd2s0YnUzVlJKNVJXR1FzTTRqcVBSRzVEdTBwWWF6OHhL?=
 =?utf-8?B?cUNXcHh6QjNISUZHY2tscDJYc0pXZVp3blU5WmlvRGdJRGNERC9JZ3V4eXZm?=
 =?utf-8?B?UGduMnM2Vk81TlZQZGl2NFpKaGp5Mzh2YkpIQ1I3RVpsOFAxcEx5ZllJQjNI?=
 =?utf-8?B?eHRCbGFhUjZKNmNvYU1YZXkxRkp5YlBVclFaQWlIbjhkUFhsTURzb3c2a1ha?=
 =?utf-8?Q?qR3p91yX+sytL4nPlfSwhsngk245Ktlz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzkveTRYZkg3Z1hJdlZFNU9YaGN1UE9ZNlBZVjVidlF4NjQzTlJxcUYwakVV?=
 =?utf-8?B?YjJxRU5YSUNRb3czb2J4b09IM25kR1dRb3FZTmx0TTdNell5VUR1azFxNlBv?=
 =?utf-8?B?L2VHV21oTU1FblJ1b0VhNHpZNEhPSVpEanRFWnV0MXdTN05IeG9DR2o0SUl1?=
 =?utf-8?B?Zy9CeW54QWxJV1IzRlF2bVZkdEdJSjN3ZVdLaXh1bzVMZUxKcFdBWkUvbEhT?=
 =?utf-8?B?eE1uY2pEOG95UkkzeG9KOWh5Smp4cWlqT2VNUkIrMStidGJzaWtwMVp3N05o?=
 =?utf-8?B?NUNRSEs0OFVZcXJTWGVkdVU1VXZ3Wm5jWHNhQldna3FvTjQyTkhjRXpIRXNj?=
 =?utf-8?B?ZkdOQzZNTG8xOGJvMFphQk5Pa0oxZXFadi9pNC80QjRnWGpmS2d6RDNTZnJM?=
 =?utf-8?B?RFBuOW9TbWwweEkzZnZWOW9lam1mQk1zNkdGUEV3MFZRTEswSitsbVJXZWMv?=
 =?utf-8?B?TzM4SGJQTEJYZXNKN090MURYRmN6eVlTbzFVeVBqNXFmZGpqazRtWElFQW42?=
 =?utf-8?B?bW1BcysxREM2T3pqZ2F0UFhNaG41NVdsdnpTUERyWXRETVd0N1FnOW5VdDNq?=
 =?utf-8?B?aE5rZ1Y5eGNHM3ZFT3lYTktTbWl2S1hVU1BjV2I1YlpqSjJEcUlUVGxxNGxo?=
 =?utf-8?B?M2JZWmtHVFA3REZWSFBkbHQ2cXp5dUVWcWdvMW1Hc1laUUwzVFdTSVhreDdG?=
 =?utf-8?B?TXpMTGtWVXRScjZ0ZisvQjhuVFRnQjRXMExDcXFiU3RPdExwMElDNndhUG95?=
 =?utf-8?B?cWFTcWZySEhxTmVmVjNETGROeGYrS0hyRUtjTC9HRGJhaXdCZFprTS9PMlp5?=
 =?utf-8?B?eVBYLzQ0b2hYTXVBaTYyTkRORkFRbW9NazFwMXdoK000V0h6UXpUREhkYTI2?=
 =?utf-8?B?bEpIeE1PUE1DTXlZZmpCcHFKd21LR01GK2czMzRIUmFyV0pMNzdNSTVYVXl5?=
 =?utf-8?B?NTBsZHgzU29YMU9sUWl3dmcybDl0b2ZNTHd2MElkaEdsWk5NTVZUVnVEaW9B?=
 =?utf-8?B?dnE5N0F1ZHdMT01HZ1lHRUMrNngyZzlhMTNRa2pOUThLSUVRMVZNMWw0WmEr?=
 =?utf-8?B?V1ZxV0tXMVlsalhlK2J2bGdFVkNLOTRyU1k3UENLRGtpeFNwWDlEeWJua21G?=
 =?utf-8?B?b1F4UE1KQThrWWY2bkxvT1Y5M0wxR29acmJwZGRoWkFzdWhqcXhGY2tZeVZB?=
 =?utf-8?B?dVZWNGhOclg5R2N6MFpYMXZpYWNPMmhwcHRCVldxWllZSkphWVlYbmMxWnUz?=
 =?utf-8?B?V0V4N1N3VVh5WHozTXpteS9OYk5KNXo3Nll0TWxRdDRuV1FRWjVBZkZkQ0xv?=
 =?utf-8?B?WkxWMUNDbUQ5dHZGOUhRWi9PVlJ3VDBUcEc4d3VTMmcxSnVyVXdOdWpqWTZp?=
 =?utf-8?B?bmJ3MFZBRUNLcUtyRndpTVRYdGhUdjJEYmVWd1grNkkzWXFIdTd4ODFjOHZ0?=
 =?utf-8?B?VzFSNlRhQkRiWHdLWDg0dnNsdVNDaVlXNDIyVTZ6YXUxWVl4V0plbUVMUVNh?=
 =?utf-8?B?a0t0b3Raak1LSnJYcG1FT0JBSWtvUjZhdXZaQUJCOXU4YWNOU2YzRkp1UTVE?=
 =?utf-8?B?aFJaSmlXR2xVb3ZpQk5aZmJWN1Bxci9pTnRPdnkxZXJnZk03Y1BPQ3RJd2gz?=
 =?utf-8?B?NjJSdTdtNFg5c0ViQ0kwbnkrb3IrN0V6RXN3R0NDVmZ0K1hTVmxZeFhteEpt?=
 =?utf-8?B?SDBZckdZV3FhUTY5YzIzekU4QnU3SW1pSFJuZkpZTkpPaC9HY1ZhTXRteUo2?=
 =?utf-8?B?aFlPakZ0QkxNWXBQek4vVlUxS1g4WDFDMlpGc1VsYklwVTNIUWlXQmR1THI5?=
 =?utf-8?B?bVZLT2FHMUpRbmM5NiswMmhEUnNUL3ZlQmxuMUJKNllMR1hMVUxCNWZoaFNL?=
 =?utf-8?B?eUpFMmJQd3ArV2xJMXA4THE5Q2dRdTF1MkM3aTRETkFJY01jeVlvYVRITEpF?=
 =?utf-8?B?cnpvVGE5M1BYOWdpczdBUlpacHZRWEhYVS8vTFdCcHFESXZiN1AvNHVqOXVh?=
 =?utf-8?B?dHVzVFFJZTQrTGhEb1RDNmltTUJXQ3AxaFhFOHhJT0Rub1dwNWxua1Q4ZW9Y?=
 =?utf-8?B?NFFlRU44WEtodks0RDh2aDJURndHeFNrSTJSdVVVT3NWZ3dML2xlZ2xmWWZV?=
 =?utf-8?B?WVBldjExZUEwZmFMNWlteDFZSE1BZVFOdlExaHI4WWZhSWIvUkFsNGw4TWJJ?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da87164-e5dd-435a-6633-08de135efe3d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 00:39:44.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJuRdqe4yURyiSMY5ZRRMJV1GuuF2yQt8zepnnh4EeR8jw++jCI5F5EFwImbClNeCnd3yTRB0nzOKx0z9jrffee+YsIwPm2cpcmkgC1zX/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

--------------UBIpQgfAH1N3TdMom1BfZYno
Content-Type: multipart/mixed; boundary="------------X0YIloQh15GGxM7yRXaIOKfE";
 protected-headers="v1"
Message-ID: <83c44cd3-58d4-4232-be7f-751d2798a059@intel.com>
Date: Fri, 24 Oct 2025 17:39:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: txgbe: support RSC offload
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
 <20251023014538.12644-4-jiawenwu@trustnetic.com>
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
In-Reply-To: <20251023014538.12644-4-jiawenwu@trustnetic.com>

--------------X0YIloQh15GGxM7yRXaIOKfE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/22/2025 6:45 PM, Jiawen Wu wrote:
> Support to enable and disable RSC for txgbe devices.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------X0YIloQh15GGxM7yRXaIOKfE--

--------------UBIpQgfAH1N3TdMom1BfZYno
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPwcTwUDAAAAAAAKCRBqll0+bw8o6MLP
AP4pF5qV0JrrAfulVOs2The6KG5M7RhTX8/vc7Hn4GTmZwD+IkIYY00MG1LczGxv9+8EQrBAX2t5
PTQ/Jw0WITi2/wA=
=KwsT
-----END PGP SIGNATURE-----

--------------UBIpQgfAH1N3TdMom1BfZYno--

