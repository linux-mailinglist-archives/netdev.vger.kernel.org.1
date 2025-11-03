Return-Path: <netdev+bounces-235284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA983C2E76A
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013763BA2F1
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8FA2FE593;
	Mon,  3 Nov 2025 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqWtC104"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0C253B52;
	Mon,  3 Nov 2025 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213420; cv=fail; b=fpaMv7NA3K2k4A5fMhW+69C9ONzLMSYjmvo/RkmYft1gVbaDXSve/iSPYdAhneWP4WNEsm4dHGM/VJhMr0Jtjce6QSienm9gETECGwgqySJ8ClddS9YLf1JLTMhiCukU6KkpQUIZ3+ce+fWMl6mknj5KUpl2LuGb3MmLKh1tiww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213420; c=relaxed/simple;
	bh=qbrpyCiwgd2bJQMkov3gHxgtU+Ymuh5FV5pQyq0T4MU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=txRQo6H3IJ6iEtQP+qGoMdYEYo0VUYnCl0MTLpE36YSyZ09PB39pz21P+TZvf4vYEshZ53mKQaVjVxavsIHvc6yNs5lskJYGSVXR6Eh7etsJL9heDSx5aWrjWpQjnBkSUZ1UIZ2cj1Fj3jXN4RjXd9MHKtl1/JS/TeOcy8aTIhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqWtC104; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213419; x=1793749419;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=qbrpyCiwgd2bJQMkov3gHxgtU+Ymuh5FV5pQyq0T4MU=;
  b=KqWtC104WZpGtRFnf7xDHX0zvJbKsJUQo8jF+vKum2X85tlsRD8QNKHb
   EDqqDz6J/lAWAe6JzS0oYv+L71z5hu2upCyqMzDQiQtKSIRjrVPUPEdBa
   L5sfThIcUzcO+9p8pu7MCqaOBzPCekM9+V8pL2xQJLgqSgA/Ura3oCXCn
   ZbyV8Jz459gIi8PXMLpQCGNihlooSneUGB3X5mGNUNNvvdDKtrhjkP7j/
   Vp/2NV65l98GEcMsfJmWyZiLfTKKcmMJr42BdLIGXTEPfz8DhpQFZr4px
   E6c27BCzWfQUB/9txaWrqM0T4VKdkcVMS8xAAVuM85nMWmih3BwU3f9YS
   g==;
X-CSE-ConnectionGUID: hrxBiUw+Rc2K9Gwq3ld+LQ==
X-CSE-MsgGUID: WaXZUCe7R6CkqvKRWPWtAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63312305"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="63312305"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:43:39 -0800
X-CSE-ConnectionGUID: /P+HouplRGqRGeLO0FKLfA==
X-CSE-MsgGUID: MF0+jza0TLmRcGRIBbjFJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="210510200"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:43:38 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:43:38 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:43:38 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:43:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LovRL7RYAciaKApt7DsFWjEx2/B2KB767/QJJmFAOeQcIiYGIGfP+y31hhXGOZ4JkzCjg3x/wrIsgMQvdOV5QRn/ooQ0IiN6hdWGB3ZV8oB0LRZnizc/AHRoRdd5jpaFBHW8vie3eRQTZM48HQY0U7tnOEjtWuAtmszUVmNZAlPGCVtQ7je5WcRetMoe7CdjBvYhbsGiRLcdEzUczzdKNJ79ozzHavgM3ce/WTXljvhgJT34tVdqH2xfVvxFbAfA1xt16IdTSYDdiv425sRsUxO18GUfud8Fa6d6ZGY6AK9SWXtbRIySidZAYTqspUvBh1L79oRmzd704PPCL18vYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCrwpoGm6H6CQM+wwNTrJW+KcTobqlPy7zSYUs7abBo=;
 b=SYIRpfWdA6agy1gwaUJw7r97Rrm/3n0cRY0FrFHtGWDM4FtvgvrVArGznJUpGfwL9KTDFr0nLcDiSP8uoQSOv/jcEs6VAVP66L7zO65pzniiOgHpMRfq+wPbXduoA03M6x1XphEepwogTljVxQtsWKHqHGhde7znMzkW8kPLrz1mVb9tlX5zCFAQVX2nGW/SfGY7oh49TDNMEoEKh3pIMG1q+YCkl+05IGNau62+rrWGI2X20dx1MhrNHfTkZAEStOohk+k0k0Qu6z63/GMzt3C/z6z0qyv8Wj3gFuyDjCeF+RQu4A8scXT8c/2QFQvUA3xnUMtNxhPTXRj2/28edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:43:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:43:30 +0000
Message-ID: <ca1b271d-47d6-46d9-a87b-bbfd4c9eb0a3@intel.com>
Date: Mon, 3 Nov 2025 15:43:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] veth: Fix a typo error in veth
To: Chu Guangqing <chuguangqing@inspur.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251103055351.3150-1-chuguangqing@inspur.com>
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
In-Reply-To: <20251103055351.3150-1-chuguangqing@inspur.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------RNU5ioekGfCSJHtMpzq056lq"
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: e3653ee3-6088-4e24-903c-08de1b32cb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzU3QUJwRDcwL2ltWnl2MWZPYVBwN1pZSTJIMzNRaTBybUhFSjlsb05uWVkv?=
 =?utf-8?B?SjVQSWIyTEg3MmI4S0xkN1lUZjF1b1gwWmg2Vno3OTVMOEhWV3lSNzBCYklH?=
 =?utf-8?B?SFNFUzZEeUFqMDRqNGxuQklqSTR1MHluVUszOEp2N2JsdTV2enBQdjBEN1A3?=
 =?utf-8?B?MGVjRVlZQWpFTDBuaXJuWEFlbGU3cDNxaFowOWJIbitrSW1EUFh4UW9jaDVS?=
 =?utf-8?B?VWI5ZlJ1dVJzcVZ6cVdrWStxM3BycHB1T2t0allBaFlibTI1Mko3Q1hkOHF0?=
 =?utf-8?B?ZmsvYW5uaWxTS3B3YUNwdjZ5SFpSYWxDOGIreHEwZXA0VWp3dkUrMlg1RlV5?=
 =?utf-8?B?QWFDeUtiSDJWenNueWlBT0xIZGdIS0l0WE5mMG80NzNWaDJiUlVxdWtGb0pQ?=
 =?utf-8?B?YUttNHZvU2lEOFlvUE0wNHRPc2FEMzlnL2VGcDhSaC9Xbmd1dVRIWXgzM2hu?=
 =?utf-8?B?WEg1dG9yeDNUYWo3K0lxbUlHWVJMdEgwbFNSbjlab0tva0VyS0tRRnJMRjlV?=
 =?utf-8?B?QlNWRnJxam16MExPMFpnZmJycSt5R1VXQ3V4aUdXZTBlWUMwbVJvT0RhZ2ZZ?=
 =?utf-8?B?eGsvc05wYnZVMHVLNmR3NlVzNFpaM2t6c2Z3bmtFZHFoY29FMklrUDlVY0tI?=
 =?utf-8?B?TmpPTEk5SGVpQi92RHFGRHNneURnMWRjN3FhSm01UlhWMEdsRkZwU2hFTDVy?=
 =?utf-8?B?R21pK281ZDlxNk1PcW9vbGdxTm0wbk9adk1WampEYTNoSTR4TnN5VldkZ3Yz?=
 =?utf-8?B?T1NRRmJ2WnpmbDhUTWp2ZkNnK2Ewc2ZRQzZEaXZHQ3ZoU0tPQlJtSmJ0a2FL?=
 =?utf-8?B?NGRqOTFBdnFyRlRLR0U0TjJwTUQ4eksweUREV2x3OWN6clJVbmZXWU5FOWh2?=
 =?utf-8?B?SktNUzhXQzRkdjNnQkxhbVRrL0NRZGxPY2xnUG0vZVU3U3h4cFcwb2VSaGcw?=
 =?utf-8?B?YUZpVXJBSkNkRnpzWTRTdVdoekF0UEpkMFNBdGFydVNCZGJUTFRKTjcxRm5G?=
 =?utf-8?B?dXhlTjFGNVBWb2YxZXlmYyttSFFwMStlNlFHckI4TkgvT2ozclgwR2srTXFX?=
 =?utf-8?B?L0tYUWI2L0JEbmxoaEdiZkJXNnNvMlNudE55eVlVKy9MbDg4eFZkZmpRMkh0?=
 =?utf-8?B?TXZWVC84S0FjdGpkZDNvQTdNNUlQOVFsWWNUcmJRRnRFUnZnclJjYTZIR0JR?=
 =?utf-8?B?cWNSTXFLYm9LcmZaN3c5RVhsNHZXUTZFbVBUUUl4N3RlNUxwdDJoeFFSdEdE?=
 =?utf-8?B?S1FVRkVJaCthUXdjekRpWU5TcTZVRGVzY09FdWRGY3JWK1JLTm5BOXEzbzQ3?=
 =?utf-8?B?aktiSnR0aWxwSUdTUWEralo2MnBjeVBSK3VzdWlqOThHbVRYcEpKRUQwSEdR?=
 =?utf-8?B?dEkwelhxL2duY2ozVkpUdjRsZmtrOEpDZVNVQjVzT1ZHMXpUT1N0NGVYWW85?=
 =?utf-8?B?ZHptS0tueWo0bnEwMGRuM05nQy9pRGJxNFphd0IxcThDYXNaTE42S1dyTlZP?=
 =?utf-8?B?dnplL0w1dk94Y2xuRFNGYk8yeG5KS3hXQ3JuVFNTUUozVklERDlLMVFEYUpY?=
 =?utf-8?B?eStEWG1vWHhuams4NzRoaUNXNFpkZDZENi9HNGE2SnNWK0sveHdkVGdLQzZM?=
 =?utf-8?B?elN2U0tsY2tKTmcva0lVTmNXVXRpY2JSdTJKUlRNd3lieG1Za09ycU9ITkZV?=
 =?utf-8?B?R0tPQWI3aUxsTS9BaVBIeHlxZ0R3dUlNRmE3SkQ4L1hYdysvcm9qUW82OTFL?=
 =?utf-8?B?M25XQVJsTEl4TFJMZ0VTM1hiRjhQTVlZazFwMTNIeGFYbUVkNFlWaEVjblpR?=
 =?utf-8?B?dy9WNW9odjJLRlpZSVNGNStoaWJEQmxBcVNUdkx3VC9kaFpuZS9vNkJxNkRp?=
 =?utf-8?B?eWFKUnJEQ0pnWi9SSWZNSlRmd1JsUTNpWnZsaERoZUdoaDFhY21oZXZCdlhW?=
 =?utf-8?Q?xBpjj18j8TZfDD73405FW5fU4xkMo6v0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzJHR280eFFKOWZjK1I2cHB3ZEtmT3RYQkNUR1Y2MUFFekJRaCs3TXc1YXRq?=
 =?utf-8?B?TDBURkMvNUdXd0R3b3lrK1MzSFM0dEZGd1ZqWUxFc3o0eEIyMW05bTVsTmVZ?=
 =?utf-8?B?Z3M2cC9uVFNleW14WnZVclNyK3N0bFNqT0pEaVI2SGR1SmNiN3dTYWF6YlRH?=
 =?utf-8?B?NllBQ2ZuNDllY2VvUTZkZUxCaWxYOUR3UzFVMm1WeVNFMm9jVFNlTnpWcUVR?=
 =?utf-8?B?MjA4dlJqSmxNTFJJem1TcGVBZjdnWXEyL0VRUXlSRGNqZEtHcHN2VmU3QXI1?=
 =?utf-8?B?b0hZZGF0ZjF5NXVlUE41UDhpQ2crSXVIM21Vd2FUdjlpbjVJNFBzQUsrK3Bk?=
 =?utf-8?B?TzhmS08zRldIRldlZkxKNW9UK2FhM21TUjdScWJ5ZzRhZThIc0hmaUplU0RT?=
 =?utf-8?B?UUUwcDgrUUM0Qkdlc2FQMU41UXB1SWhuaWZ6clpYVkhkQmYxNDhDT0VEYlF4?=
 =?utf-8?B?aGNoM0J3NlVWaVpnVXlidDhkMzlTTldtYml4YmMzWTlEUk5TeDJ3Z3E3Rnoy?=
 =?utf-8?B?RzdzS01QQ1AxNlY1S244ZWtRVC9pbG9Hbk54WHNkRHhwRThHUDdhT3k3UFJw?=
 =?utf-8?B?NEpPcGxvSDhpeUMrcERrTnB6YWM2WWg5WVFTams2WW5aOXN1UTNxVktZdVdZ?=
 =?utf-8?B?WDFvQkxoaDZtYW5vUHMveHZCU2tVS3pZa0g3aDlGdFcybXkzTXVjOUc5WDNr?=
 =?utf-8?B?alJobE95WGoxdVJvTmJPZ2JMckd0YlNna1Y0V1BISkx5eXdHYnEycnZlSW9y?=
 =?utf-8?B?T1RFbnBibDZ6YnhCQXBpcXNqTUl4bXJ3UW9lM3ZYUDM0M3lmcXhHVXZjRGpD?=
 =?utf-8?B?NWJzOEkrVHpIRXVMTlF2dEh4dFR3VlA1ZmFCOUlFQVB6MERkdGlQNURzK2Q3?=
 =?utf-8?B?amtDUmpiRUdBSEdnMlg0SWxrdXZDTzRDY0E0Z0Z2NDd5SHlUNkRobDdvMEln?=
 =?utf-8?B?VG5TcVpKMmlBZHBCNXFsakxFRXdqQjN6V01tbm01dnlUYVJMWXVKV2tkcytO?=
 =?utf-8?B?NFJDZ2N5ZUNFd29mM3dzUTU4Szc3OCtlSFZsWUpVZ25IbFpyTVB2andaeFpQ?=
 =?utf-8?B?dkNXQm1ldzVTQzZ3dTd3WE83dVpJQWdpdnFFZ24vMXRzVDM0ajhaMHRhc3Yy?=
 =?utf-8?B?Wk8yTkQ0Y3JUV1g4WWEzL3B3b1U0R3Q4Wkk5amtlSUM3WUl5U1djWExOb0Yz?=
 =?utf-8?B?MWNJWDJiSzJ6Q3N0b0d0U3pTdHo2cFlNWjdSTWlNOU5BVFUwYm1CWENwQWhp?=
 =?utf-8?B?K0h1SlFGc0VQdS9kbUdJVGpLVzlBUmJqUkRNT1Qwd21xOVg0OTBvVEwrNm96?=
 =?utf-8?B?MDlRRU9FN0FFZkFCUlg4eEpISFE1Y1dmcVB2bzJURGlkNy9DWDBsR2lHNUEr?=
 =?utf-8?B?dnBmR1NiNVlUT2VCclNZMngzN2NBcG1vMWxVbENob1N4b09pYlBBRmIzM0FB?=
 =?utf-8?B?TEtUUkxCRmEvN2pJSEJBcWQrU29IaWxKR3lMOFhpQWtDdmd5VnQrT2N3d214?=
 =?utf-8?B?WnFoNG43ZGliUmVYUThhaTNzRnVQaXNGYmE1dHZsUzlkNFNSajhzZWRxZzBo?=
 =?utf-8?B?N2JWTlpyeVFJQmJYdzFkY3hsYnViY0VXeFBYeGZNRGppdnRXVlpldWl4bm1m?=
 =?utf-8?B?RVpmYVZDTTNnRmU3TTFTblF3L3JZaTBxUWJwNGlqZUJYR09QK05Nd1JJTlow?=
 =?utf-8?B?QzdpRDljWVhHRXpvM01uOWVDQ09GTkR5bGJOaUR5U3QwMUlaaElBc1pjWjcr?=
 =?utf-8?B?ZGIyL1Zwb1lLRWF0N2ZDb2JmUlFmZm5oVENmQVdMQzJaK1NJR2VlTENPdGFl?=
 =?utf-8?B?K1R0dTF0THk2SmZFNFlOcHhpWE9rb1FQR1ZKWndaVzI1ZTZucmlwbVFtVm5o?=
 =?utf-8?B?RGdyTXlTekdYZldFMnZ1bXNJWVd6cm94dzJrS1Y4cVpXcERSL0l2QTlyY1Fv?=
 =?utf-8?B?bmFXUmpKczdmTENTVzBiNElMNnk3aGhIZEZ0bVNXekxBZHZjNEhxYStKY1JG?=
 =?utf-8?B?SmRrVHU5a1QrN2t1RklraFJuK3hpT2QydnVFQTZPWklZalIzeWlkQmlnaDVE?=
 =?utf-8?B?emo5a1ZmSktDN1pTc080ZHl5bmZqdFVYWDdHeUNZQUF3SFBZVkFPODFhQVpk?=
 =?utf-8?B?T3JSLzBIMDRldm5mdHdjZ0hCdWE0U0d0VUV4RjBidkRreittWHcvRGRyTHAz?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3653ee3-6088-4e24-903c-08de1b32cb33
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:43:30.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzXQni/3k/Kdad3FlGbMvs+iwNqqGqPe61QIDsplrO+w/rH+fEDf1cJnIZZD8U0rJ2bh4AjvO0iZ6EEZOAl9OtV6cmI6tyMCbCEdjZs95Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

--------------RNU5ioekGfCSJHtMpzq056lq
Content-Type: multipart/mixed; boundary="------------eoSJBg1XBDKUWC8maPglISU8";
 protected-headers="v1"
Message-ID: <ca1b271d-47d6-46d9-a87b-bbfd4c9eb0a3@intel.com>
Date: Mon, 3 Nov 2025 15:43:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] veth: Fix a typo error in veth
To: Chu Guangqing <chuguangqing@inspur.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251103055351.3150-1-chuguangqing@inspur.com>
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
In-Reply-To: <20251103055351.3150-1-chuguangqing@inspur.com>

--------------eoSJBg1XBDKUWC8maPglISU8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/2/2025 9:53 PM, Chu Guangqing wrote:
> Fix a spellling error for resources
>=20
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>

Typically the tags should include the target tree. Since this doesn't
impact the functionality, net-next makes the most sense to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  drivers/net/veth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a3046142cb8e..87a63c4bee77 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1323,7 +1323,7 @@ static int veth_set_channels(struct net_device *d=
ev,
>  		if (peer)
>  			netif_carrier_off(peer);
> =20
> -		/* try to allocate new resurces, as needed*/
> +		/* try to allocate new resources, as needed*/
>  		err =3D veth_enable_range_safe(dev, old_rx_count, new_rx_count);
>  		if (err)
>  			goto out;


--------------eoSJBg1XBDKUWC8maPglISU8--

--------------RNU5ioekGfCSJHtMpzq056lq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQk+IAUDAAAAAAAKCRBqll0+bw8o6LIS
AQD2oH+9V8hLZ2/8gJVPZqCB/VxuXPO3BBZy2Ufs9omMEQD9HIoU2Hz+033EUgNEonsYtwG5tw0x
I1xv4EeEHNkbYwY=
=uCAu
-----END PGP SIGNATURE-----

--------------RNU5ioekGfCSJHtMpzq056lq--

