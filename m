Return-Path: <netdev+bounces-121084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0795B9DC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF1828604A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B6E2C87A;
	Thu, 22 Aug 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEbyI4mt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C017C8B
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339756; cv=fail; b=U4Aubbx5imoE7q98pCxJBeujW2eZ80pmdq4SiSaIv/mfejkvQf4nu/quUYyI2HOGpP0uJ1Vc7T8JUC9XgyPCQThaW4mfhcpQlgnXyM5imJdOHNhfU4XGfbzbOZ4obPxQDbY+W0CfdTNmbpAd7dB+ESKdL20RDjzWPMXJFAm0tMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339756; c=relaxed/simple;
	bh=cdfr9en71243SrRQ/GBFCTShqw/OxoDzIUrSiecOLrY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bOO31RR/bFZTvidv+lD68Oa3Z8MTIoq6B5VEs7ktaOZMfwT8QheNS4GSFrCP4brM7RH9AKqOKDpfPFDqf+IJEp7+FrdChak1avCbvNNOAmEIPdkXtn7pPGh4JwkbZPkaL+q8YnXQ3yyF2GNjuT6Zp5UeWHXPvDPBvZQ387BwsuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEbyI4mt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724339754; x=1755875754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cdfr9en71243SrRQ/GBFCTShqw/OxoDzIUrSiecOLrY=;
  b=IEbyI4mtOMc+yFlyd+AdRHaBXGBtMCW1mIGt5V3e0XROh1UzXBSgDkz2
   uEn8MqYxusm9gIdSLLVtvyrdvZgYX1woT+eR5kv6kZpo8XDbjxLuXP1gy
   Hx4/lp8zmVen2gpGYB4xWhBMnLIgINQWo70kRzCNjLrSEdPrb85jxW9cz
   cLqnCLiYSFCzsz4tckt61JwvoDZaQwehu38WAhMGlAdzGStJs7j/S52ly
   QrAhGPxr6+rrhoAUIBR0Pw71xV98A1pdCvNsNeN5mReWugYzjJAoYzrZa
   Xb6/HZNe4LWjxXf3d98W6mg43aQdWtwXxXivUQxOlDV/iQ9kFEOxkKJJV
   Q==;
X-CSE-ConnectionGUID: cPUrOm7wRp+umCBqCX/9oA==
X-CSE-MsgGUID: bxBIxoPHSr6aUspFdyCCpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22891094"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22891094"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:15:37 -0700
X-CSE-ConnectionGUID: RRuqEpBTTiysesX8YDPdtA==
X-CSE-MsgGUID: xR218iuWSPGmiFb3M0xKng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="92277194"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 08:15:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 08:15:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 08:15:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 08:15:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 08:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjswO47P7uD8pG6Ls3qe0EupoLLF3xyA8NPn7oddmmKabMJV4WMeHMm8bB4A7svw8q+2EoNqGx72YwAqKF/H1YVHPzjNJvy0K7r46RAXZoWZEa6Sejo/ccpWF0uETs7mARjLbQ58759FQEW/R7VsUB3xbpEQDhcfypFrOIZN/AHeWz4usjmC/DuNRJtCRVRd5lL/fvparF0xVQQM8AfqFU0xfyABMJusrTKcpYRD05sKronWcFCHEmLzjjhkkx4wU6l9d/yTX6tm+3bU0aAQDmQTf8Sbb74QQEijvqDzOIuy9TsP94MkH4l/jgnjN30UxLmTfVEHNb1mV8QELINXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R7cjP3ccAvlMVFfYGdWa29eA0OAYNs+JkxcYuBvAb4=;
 b=woPAOMHOdVdF5UhPWpU+OSM9/Hi+7RZsxo6UcEeRXIMs405tQ7+6HHkQyKDYVytZSk9IYV70vcLJxmjdGSBTNSBR2w3to601dIOVRMxBfuQd4eVHhwy+vD07WZFj4a2Q7syVKLIchzQ6CzO8/MiexAwHKk87XXYAkaA4pQtNGZCTfLZI/J0R2qYRWLAdOYvOK6ju62UoSwFU3ozofDVJuLLHPvjeZtaWBTgsVV7gDuaIJMDgHCzI/a/RVX7l8Pg5ee8G8lg3Z1VF4KOwaNLCSnSVUYLD5VOOtWBGcOnjKqWbr9siingN9pqYmAh/Z73idefgb5PXdj8mpQJxHFZBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 22 Aug
 2024 15:15:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 15:15:31 +0000
Message-ID: <66b571dc-19de-43ab-a10d-13cffdd82822@intel.com>
Date: Thu, 22 Aug 2024 17:15:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/9] unroll: add generic loop unroll helpers
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
 <20240819223442.48013-2-anthony.l.nguyen@intel.com>
 <20240820175539.6b1cec2b@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240820175539.6b1cec2b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL3PR11MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff3816b-2029-4c72-7134-08dcc2bd434c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE5ReXdlOEdTRUlDei9YVGxsaUpSYzljNnJ5SHZNVkw2L2c3WDI3VFpHRFJp?=
 =?utf-8?B?RkhQR3kzdGVuTVFrVExmbDhlcEg3RjRlVnRDRGhScHZ6aXY5cHkzSzFCVkFF?=
 =?utf-8?B?VDBLNmk1YXcyUjkrOWg3NkZlSUptNWhIczJwaUcwSnhodVB4QVRKckhLby9k?=
 =?utf-8?B?dTRPQmxKWUFnVHl3L0x6ZDdSWU12TEJuTCs0MFYwa1JIRE52eEtUdUtBUjNJ?=
 =?utf-8?B?UldiUk9rOXc2Q2RWQnpHdGZFaEg4dHNDK2Q1a1JDR0RBeElPa1JGZEZpUURM?=
 =?utf-8?B?ZzRMa2MzRkFrSVMzckJoSmVXd2NJeGxlVW4wd2puT1hmWk9WVTJRMncvWkNx?=
 =?utf-8?B?MStaSVBzZ2haOUZBYUFYeFgvODNsTG1mYTZmRE5MRjlmK2NiaThDMk90Ky93?=
 =?utf-8?B?ZjZKOUxDRTVRQUprWlRxaDdxUUgxdjFkM0kxa0k4OE9ibjhTNEF2Zjh5TTh2?=
 =?utf-8?B?Y1JLT01aTEVob1pySlI5NW5TcTlNQ3ZoRk1KcVpUdVE2QnFrWkpMamRmUEoy?=
 =?utf-8?B?Zll3NC9hMjk3ditHQjhJSHJOQnk1UTJJZUdJQ1cvRHNHaHdTVFNtM0V1MVBF?=
 =?utf-8?B?V1hzeWs2eE12cS9va3QxbEtxeXR5akFzTjF0Y3FURlRRVkI5UkJTdXFGYjBG?=
 =?utf-8?B?NzduWk9POW1BYml0WlF5d2w2SFVNaWxJZFlPdFl4d0EzWS9vZ3VNczlWL1c4?=
 =?utf-8?B?eURIMnFZNFpCL1lTV1Fnc3dhU2hYZnlCcHNCdFdCQURvcTdZUXI2NnhiY2FL?=
 =?utf-8?B?N04xbExQRVd4NFpwY1FxYWZaaEJZM2w2cE13S0p0Y3V6MHQ5Zk8zNGUzR1Rz?=
 =?utf-8?B?NW5uRUhTZDR0QlJROHAvYVRjSzVkZnJjZlJzcjBNb2ZwV2VVV1BlVCtWN1ZE?=
 =?utf-8?B?ajQ3bi9JS0Q5K0JPTStmVm5Ub1lIN0JsNVVWOFpnVlJNL0x1a2w0elZoQnhP?=
 =?utf-8?B?aDV4aWpPckRza1pCMlk0bjM1NXZmR0hGNVU4cDBOeStPY21YT2xUb3JydlNv?=
 =?utf-8?B?czR5WW5RSGZkZEZNZFJsa0FmeHNtWHpxR3Qrb2gycG5nazRsdEpMNmRJSlFC?=
 =?utf-8?B?SElYU2RVek9yQ0N5NFkyeUtsODI5T1gzYVZaUXpMd3JGNEUvQ2VJSmV6TFgw?=
 =?utf-8?B?dzUvc3hsR0FlU2ZWUmFxd0xTK0JNeUZnb3pqeVFFd2xGQzVMV3JxaFpOV2tS?=
 =?utf-8?B?dDRsRlQ1TCtuS1dVMXlPaEx3WUxpR2EvZVFZSWVBaVhFSWI4WDlqTEpsSmxw?=
 =?utf-8?B?Z0E0UlRTazNOVkdvOGhJalo3b3ZDUU9iN05NSnk5TVhwdmlkVitxa3N4ZzRR?=
 =?utf-8?B?TGZNM3FwT2tRYzQ0eWpMdnlwa1Y5Q0tVYTdOc0h2RFMzMml2alg2RzUxYWdL?=
 =?utf-8?B?R3JWaVVjK25vNnR1OU5EL0RkZGxRUHpjZ0tPelFPS2YxU09uaG1SOTRPanYw?=
 =?utf-8?B?NHhQMTRVLzJYNExUdnFxQW5YSkJQQmwza3pFbitXdDF2REM4VTVKMlFRQUhO?=
 =?utf-8?B?YmxUcWVEMGM4U0VSckE1SHJMT1dwQzdGOVFSVUhRWmluUVE5RFpiUUEzczNE?=
 =?utf-8?B?dDNaUjBSR3ZhZk1kOXJ4NUZUTDJoanRVTW5QYlNRL2VxYXpBYUxyVzBycXNy?=
 =?utf-8?B?U0kzSU8vVVlMUXdVcVMzMy9mcFNWdDBHeE00TDB5V09mcGtlcEZBTk8rUklk?=
 =?utf-8?B?YmZaZUxwbVZDSS8waVM5cnUvYTE4VFZ6YnZHM3hVYTRHa1R2MEcrZWYxMGVs?=
 =?utf-8?B?VjlKWWhYaWo3bys2YVhjNmMrZlI3eFpjMEN6WC93Z2oxU3lQaFRvdzJxVVNZ?=
 =?utf-8?B?elVESEU1ajU3bmlHRzRIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzkxSlNUTFpiZWkzckp5bXk1NGovUlRKWU4wanBvNDIwNE56RTFOblpkaVhT?=
 =?utf-8?B?ZGxkUk1MTG1FNU1aQVVvZGR6U3lYc3YxdXpJbDhhNGhqb3p2TnhEcXFMcVRo?=
 =?utf-8?B?TGRHUlFlRWo2anhPTGNXV00wUlY2bEtqT1Y5KzdVenRxNjF6UDMwN1ZYdFJr?=
 =?utf-8?B?REtjeSs0T3RyL0laNkNkQlh4aTdwczBGTGF3cVZEaWFNSFhFU1R3RVY5Tk91?=
 =?utf-8?B?TFk0VmNXQlY4MU9wdkt3T2VFbmp0dGJYclh6MThJY09zWEdsVWQ2OE1VWVNQ?=
 =?utf-8?B?Mml6Rm91R0gwTkVoK20vMnU2MlhsOHpyOXc0bVhTaVBoaGpvMFJDVXIvalBw?=
 =?utf-8?B?ZUtKdkZDQjRLZFZ5djlvYktBY1l4elc0bjdPalYxclNIeXpFZzFOQUV3TTZ5?=
 =?utf-8?B?V0RoNGpJaFBudkh1bUhmbCtzNWl5UmJYOE5yOFUyeGp6TURQdGZod0FiZFNh?=
 =?utf-8?B?Mlh0Q21BTElCOWhiVHBvbTViUVhWU0xWRzFNblNjOVB4bFRZZ05jNnNJWkhH?=
 =?utf-8?B?WGN4T01yV09RSG1wdFo0TkNVSzQzNjM4T1pVQ3F3QVQwT01QNGNpVGRPb0dT?=
 =?utf-8?B?M0VpTVhKbGgzWnBiRnoxN1N3TzQvTmpQUVZQcElzVDlIVHRWZlVaa3B5MnhW?=
 =?utf-8?B?bUlmN1VrZElFME10QVQ3YWhuaFAzMmZyRCtRNDhqL2p4M2NsQnp2ZFpzYU5M?=
 =?utf-8?B?dFkxQnZpM1haOEVsN1Rvc0lCbG1GTmhnMUQyYldLU0RwUjFEMW1LNHIvTUFr?=
 =?utf-8?B?bTRGZ3UxeFd0N0E2UmN5dWU0Z0ZDZTZ4MTRqVE0wY2xERFhMU2tOcGNsbWJT?=
 =?utf-8?B?NmJnY3JkWUV0VkFzTVBIOUQ5TlFYTDQ4cEJrcUZSaUkyc2EzbHJDbnp5NC9k?=
 =?utf-8?B?OGVsNFhxY1gwb3BpdzUxaGd3b3RKaHZKd0lXb0pzY1ppczZ1RWsrTVJDVTJV?=
 =?utf-8?B?Ti9zNVEyM1N5Vi9XV0I3b1BiTFczUWlpRFFJRHJ2ZC9SVkJid0FJRVJSVmVL?=
 =?utf-8?B?bUpnd3ZxTktROWZwN0Q5UEUzYVNGNEpGQVpTbDNJVE5BYnVXV3lsbHFtQzBp?=
 =?utf-8?B?TjlqSFUyK1pKSFFWb21GSHc3SW1Tbkkxdjc4ejJuQzk0UlF1VFVNM2ZERnp0?=
 =?utf-8?B?NjBTUC93ckltUE05elBLN29sdk53SnBUM1V5V215QXgrSytrMG52RlowYjZX?=
 =?utf-8?B?blhhUGpPQ1JUU0d4aktTZ3ZraS9OUmtMNS91d1FkYkJIbnQ5ZkVscHdSREg5?=
 =?utf-8?B?MUVGaHQ3Tk4zaEdNcGJJVjIxSitlWit6SUs4N2kyY1VqdmsyRllSRnR1QWF4?=
 =?utf-8?B?RVVaTXBoZFZoZVkzTFBhM1hhblZwc1Z0b3pCeHhwTnhUY05YSEdKaEduWkkx?=
 =?utf-8?B?NFIzbmo3eEtOaHpwaDZlVnY0Y3loN1Y0UmNLOURhZk5SZDF4azZNeEtxbmpS?=
 =?utf-8?B?WWg5aW0yUTVtQzU5VWZSWngrakFXME9wZ2JTSnUrQ1RkMGlscklkMm1VYW92?=
 =?utf-8?B?alBCM3NBejdEU2llaE9Xakx6eGcxczJwK2RGU2JzYnZCT1ZncUdwZUo4UFcz?=
 =?utf-8?B?L1VkQ01tVWRjUXNYbDJMc1hKNU90cGoydEZsQkVWMEFqb0ZJQjR0Vk1odFhY?=
 =?utf-8?B?V1h5YXNxNytObERQMFFyQ1FTL1RuamZ6OG52QTJNVkQxdG5OK0kweXFlQkha?=
 =?utf-8?B?NkttTms5UUlIZUI4SVc4ZVZZNTFPR1BtdDVwTDBaVEZmem1xR0hlVytqUSty?=
 =?utf-8?B?eG9KQ3JuTFEzbno1ZFBPcnF3VUtjZzR5MzZORlFYUzlCcHZDYnNNbTNQODcy?=
 =?utf-8?B?NDc3d0dnRlJHSjVyZTkzRVdUZk5OWDIzMVMxc2JQN3oxanV0U3VFZEhiQjZ3?=
 =?utf-8?B?TUpteCt3dXYxUThKMGdrVE9HbXdOd0liamFNUFl2NWJQaG41QkpvbEd2SlBn?=
 =?utf-8?B?VnFuMDJTYTF2NkV3b2FqTDlhaGx1K0lUZWdCbndhc3N2YU14WEJ4bnBUUjlV?=
 =?utf-8?B?WjRsTUptTmJKUVY5SnpuN2loUGpXbGFJY2ZHZmhacDEzSzliN3MxMWNid2Rq?=
 =?utf-8?B?djhuYlgrSkZwakFCRmRxbGlQQzYxbTB3TVR6R0E2NnFJRURDdXNPc0lzdDBs?=
 =?utf-8?B?RVVycHBreUVXTzNtWlU3cUR5ZmNraHU1RUZiaGthNXNYamwwT0lQQkNjNlQ0?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff3816b-2029-4c72-7134-08dcc2bd434c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:15:31.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGav58mUlrND3ykavnDwJRFE0DelMyTwSEIgZRU64NAJvyzM+p93ZPinf/2EK0YfhIBWrGGGVx6lmbj3cgrrGCHYqZSY8sCcMADsX1nAD/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 20 Aug 2024 17:55:39 -0700

> On Mon, 19 Aug 2024 15:34:33 -0700 Tony Nguyen wrote:
>> There are cases when we need to explicitly unroll loops. For example,
>> cache operations, filling DMA descriptors on very high speeds etc.
>> Add compiler-specific attribute macros to give the compiler a hint
>> that we'd like to unroll a loop.
>> Example usage:
>>
>>  #define UNROLL_BATCH 8
>>
>> 	unrolled_count(UNROLL_BATCH)
>> 	for (u32 i = 0; i < UNROLL_BATCH; i++)
>> 		op(priv, i);
>>
>> Note that sometimes the compilers won't unroll loops if they think this
>> would have worse optimization and perf than without unrolling, and that
>> unroll attributes are available only starting GCC 8. For older compiler
>> versions, no hints/attributes will be applied.
>> For better unrolling/parallelization, don't have any variables that
>> interfere between iterations except for the iterator itself.
> 
> Please run the submissions thru get_maintainers

I always do that. get_maintainers.pl gives nobody for linux/unroll.h.

Thanks,
Olek

