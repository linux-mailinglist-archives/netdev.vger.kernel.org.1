Return-Path: <netdev+bounces-258324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIblCf64jGnlsQAAu9opvQ
	(envelope-from <netdev+bounces-258324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:14:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ACB12682C
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5784301D4CC
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565A34A799;
	Wed, 11 Feb 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giJLpMbb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD932FFFA5;
	Wed, 11 Feb 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830059; cv=fail; b=I1SEzlkLC1gWfadd2lCIjhm7NtGjNAQTeGsYSIOP/QLIu4UFLEc8BK4SXr63xgJ4gNN2caZzH+mAPxkrXSL/1j9yNJxjI8g4DB1PQUFl7CAoxzGuggY6d6Fzh7/zfGXXwDQwCxERHyuuLGr3ofMBFemFkzrpfoaJeBXNoTsPgcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830059; c=relaxed/simple;
	bh=7+oPKR+f83rHm3bLLQt+/RgMbqnfatl0axYa4ne0OJs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOle6sJ0QNjMQq/zWnW9A+AHi+aJwNAte/Ax4Byo4IPwVLg4IULxUIHuM25CWwb8xqPFviCtoApEcS/zLBKQXfovPS0DuT1EaitE/oycWxckpyicr/5Im4khh4Kv8LuaCQK2/WELv5DhYb5SFoX0u1YYCBpscIx5V5MH7VodpZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giJLpMbb; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770830058; x=1802366058;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7+oPKR+f83rHm3bLLQt+/RgMbqnfatl0axYa4ne0OJs=;
  b=giJLpMbb84m3/9a6i6UHHq55RAHeAPfN9yUx7PznoG5nw9tRN9TXRKS8
   1HxK6rK9K2J7AB0YNxmzXTpYhYfoQXFyysBJzfw3vH+FpzqvwztAdyZe1
   2M7sOSOACqyVE6r1OYarHsOrrbkaGXgbFdaViSzCdXAWzS+vwXb5cz3i4
   g5rzRbjIv06FC+5L2i4iHlpdQxjGzsV/zlK3heyIKwqFE0b5V3oMMVgHj
   5mI54GOk2clOCGhMCEXbsxrjGCL8BVCfPTP2nffvQsGERPoa9PhDqTc33
   yMIkq9viNWFGOhemZEyejWnXznGG2S8gSup3oj7liN6NPWsrrKjlv4gJ/
   Q==;
X-CSE-ConnectionGUID: H5jEmpyyQkqz+L6ST+sIcQ==
X-CSE-MsgGUID: enTRGhULRHuFjZ2KKYSNZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75831376"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="75831376"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 09:14:17 -0800
X-CSE-ConnectionGUID: fsfO8NGTQfeIBz/XZIdpUQ==
X-CSE-MsgGUID: 6IYvF6++SvSvC2lZq50f9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="235294937"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 09:14:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 09:14:16 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 09:14:16 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 09:14:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfuuhQ4AWoKlu1rcybZKKQl2OSQ7Ke97CIT+9/T51jPLVizJ8M+rel/4Tt82fFr12Zb79Msxm0dcn35BoBAUA0RpJMEiz462lSvTCXto3yKJfNSuCaBVczX387Ps6GW2IgmMLG2tH1y24DJFPXlNGl7E5TZNtUdBQfFinYt01q2l+IOUUzvqO1UzJs0/JWG2kW1z6e+ZV7v0Dx1+D5oISJf2JuuwTl3rdxu3eYupPDEysWWVlS+8PTUv9xZLX2k/dRZOD2BlfA0WPS2bxY85nQPi1PGYYQhQAeDNPIm4WtTiSTz9A0Zqq366iMG2wThwLeMSZDFMB0TZPpE2nLtQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k+FMQwggJVpnJ1l20CvkJsBfY0X84EGvpaeDOv6lhY=;
 b=c1g6q+pMMz7/ih+0YFg7A8AsmSozb9SHOb/LpvBtUGJ91P8svs+cje22xc7PilcGJFNKS2fhMcI4w/IIGIvG604+k2IiNGovE5WOkp/apWHR4XOVUUP9GSR8/2IV/eou+1BiJT1ZJF3vs9ZDDzvHa+C2EfWtEZJ3HUVekYfBxcx7qL2EteIgNYxl3eNcdM1NxQYKkIos6AhXj2tXz0FKY1YauD18lIBEp4LqxVZ2V/WObUdtQFjtmWsJnPazAtqdTmbTCRyN4OS9cM8mGd2i6iwdsbIxTSfsLZwMPujwaKWqrZrahKZ1hzPgQJmIrSbgSjb//MyCgrmzNDLuGu/JQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 17:14:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 17:14:12 +0000
Message-ID: <3b134d22-30ec-4532-9b89-f96761d3abc9@intel.com>
Date: Wed, 11 Feb 2026 18:13:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,3/9] ice: migrate to netdev ops lock
To: Jakub Kicinski <kuba@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, <sdf@fomichev.me>,
	<andrew+netdev@lunn.ch>, <ast@kernel.org>, <sx.rinitha@intel.com>,
	<horms@kernel.org>, <yury.norov@gmail.com>, <john.fastabend@gmail.com>,
	<kohei@enjuk.jp>, <przemyslaw.kitszel@intel.com>, <richardcochran@gmail.com>,
	<alexander.nowlin@intel.com>, <daniel@iogearbox.net>,
	<maciej.fijalkowski@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<edumazet@google.com>, <aleksandr.loktionov@intel.com>,
	<marcin.szycik@linux.intel.com>, <hawk@kernel.org>,
	<jacob.e.keller@intel.com>, <magnus.karlsson@intel.com>,
	<pmenzel@molgen.mpg.de>, <pabeni@redhat.com>, <bpf@vger.kernel.org>,
	<davem@davemloft.net>, <andriy.shevchenko@linux.intel.com>
References: <20260206174910.4066255-4-anthony.l.nguyen@intel.com>
 <20260211042458.555701-1-kuba@kernel.org>
 <2a300bf0-3975-4f79-a3e0-5cb9b8159d62@intel.com>
 <20260211085514.428236b7@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260211085514.428236b7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::36) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca0e810-bf21-49ea-9bbc-08de6990f9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clRpeWdJdXJ1MHNHUXpqSEhHaU5iSnBlYk5zd3B1aDhqZGZjaDZZMzNkWmZY?=
 =?utf-8?B?Zm5VRndva0lNSjk0ZFdUbjc5UmxYa1VTSDdoK2lZWEtmSFBBRUs3U2dPMU1i?=
 =?utf-8?B?dTdmNGdHeHp4b2lucTNHd3FObHlCVHRjKy9ORWw3b3Z1YURtLzdJNUJwSEZl?=
 =?utf-8?B?WHRBZFIyWk1mNDRoalRXMEJxRHZuVnVGWlRGSm55ajcvaDluU3F5eEFZRmdR?=
 =?utf-8?B?ZDdsUlI4dHoydGlmVEZVbExTbzdFREZjcGV2bllmSDJ4emtSL2FSZC8vOTFx?=
 =?utf-8?B?V1RkQ1BVbVFlLzE5TmlxclV6ZVN5MUlsdDFMK3BGWHVkNCt6OUkwd28vem54?=
 =?utf-8?B?V2pwb21UUDgrUU5UaFBEcUNlQlVPQW94Q0dvU01pOEZpb052dmhHQXpRZGRp?=
 =?utf-8?B?UEVPdGk5ZE16TUVVbEpxMWdGVndaOUFXOWhsbjJyOFIraWdDYlhWNHJ4bTFL?=
 =?utf-8?B?ZXRqeGt2bFNvOTBPLzZJd1M1MmhtckhzaXI5Q2hmMm80K3FHakFNQVAxQWNa?=
 =?utf-8?B?cE5qYmpGWEs2ejBLVjFIN0ZzZ2MrVTM2Mzh2dTdVYkJFajFFNXJVNXc2VGlt?=
 =?utf-8?B?UHJtVERmRzNHQXUxTFBDSlZHZVdDcGZRN2ZXUWM5dlQ0aG1QVUMrMC9BZGFT?=
 =?utf-8?B?Mzd1SHRaa1M3TlNIUzBsbml4V0hzNzUzZklkQXdzdWNTVzdpcDB5SGJvZ2ZH?=
 =?utf-8?B?d1d5cEtRbzJaNmFjTVE5Z3R2VUJ3RGxGV1k4K2FVc1gzL2piOW9NbWVMYWw5?=
 =?utf-8?B?OGErczk1UTRraGxjcXRwZkpMRE5FUWRtWjZGb1F6SkoyaVRhbFNkR3FtajVQ?=
 =?utf-8?B?aDFQWXFHQUNzMGtvL3hQc2orMWpTYm8zRFFqaWFJL25GWndhVy9zSDVtcFd1?=
 =?utf-8?B?cytsdmFlQ0xEMnNHeVBuLzEzK2lUK0hrdXhQUFhNSTk4dldhNFhTRTFub0U0?=
 =?utf-8?B?OWNFQVJQZEh0eHFobjJscHcyWitIZFNOVU5FRXg4Zml3ZzFpd0t0RElsamJ4?=
 =?utf-8?B?bzlzbUhpRjRqbE9aWG9CSHVZVE52NFlCNi96RTV2MlJaM3VEdm1hT0pjMXJm?=
 =?utf-8?B?TnozV0pUYlBLVUNsNy8wMmtUNlFMMzdHTDBqT1ZTNFdQNEU0bXNvNFlZVEd4?=
 =?utf-8?B?cVBYN1grK0l3amw5bzdiYVR3aFdGK0lhcVoxZDVaQlRBUEhXdUN3YWRvUHFv?=
 =?utf-8?B?REhGc0F4dHNGaUVuUTlnUHZVRmEzWVZGN093ZTk3cEdQRmF5VmxaU2h1Tzl2?=
 =?utf-8?B?VmswRkdBVWtrN2RydzUvRmVkQUZ1UEFLTUROT2tSME91cm14UHRFcTV2MDRl?=
 =?utf-8?B?b0VNVjMyaDFBMWpFY1ZYa1ZhdTQreGZvQU94czdDVjEzd1lrZmN5eDdsdG40?=
 =?utf-8?B?MFJWRWE4WjFuYU85TDZyWVZRQ2h6cy9YbCs3ekFseG1MVThQNm5mdG1pakpN?=
 =?utf-8?B?SVROT1VpVE5MQVZYNDR3bFJSeVpVTForclZESHEzLzBycjBxZzdBYUkyOWFE?=
 =?utf-8?B?LytaY3A3SlliRXIvaFozT0xDZS9mbW9hWHhZTWRpR1J4QVgxYURrZ3ZwQm5o?=
 =?utf-8?B?a1I5REN4SVB1WVEveGJSaS85ZmVlSU5qWWRucy83eUk0NC92M2gwZGRCWmRj?=
 =?utf-8?B?YlN1Uk5WNDV0dUZuNit6UXowMXBjZXZ2WEU4OG5FNVhzTTdMM1JhcDhpM3hR?=
 =?utf-8?B?NEo3Y3ZYcnVSdnV6dkt2NUUzM2h5emMwcmhNRTc3VzZJckE1NEJmQ0FHbkNQ?=
 =?utf-8?B?RkxrQnptcEtXLzhFSVV3ZitCV2ZoYi9rcGRZaUNPTVVqdnQ3NzVzTGl6b2Rz?=
 =?utf-8?B?ay9jVDNFUXFlcFI1WkIxSWpJZjM5QnRVcTN2c05BVnJuRm4xcit2ODlBeTRs?=
 =?utf-8?B?UnA0L213WTZNMXIzVDl2dDlrUUJpUU5oRTQyYzhwUXFYSXZZdW5OZTAzOFZa?=
 =?utf-8?B?VTh0T1lnUDdBU3JpQXJBZDF2SnFERmpNenppUVNFMEQ4dzlneXRWNGxLQ0hD?=
 =?utf-8?B?SWV2QWwvSEhlcm9weENDQnR2WTFoQTJxZzVWWUplbFJIQUdVL1l4SWZOUzFH?=
 =?utf-8?B?NXdKY3ExQmN0RFY4TDJoVnJzY1ljNE4zejZKWmorTlF0Ylo0V2ZSYTQ5RkFS?=
 =?utf-8?Q?1wPk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNXK25qd0ZzR2t3bEY5d21KL0wyUWZLUDlwZy9mbUY1d01OQUowamNCOGFT?=
 =?utf-8?B?RVRwSFAvempmcVlEY2NqVy9YZzlKVW5rNVJpSkNLUVpCdStHZ2ZVaVd6WHNG?=
 =?utf-8?B?Qmx3NnF1YXl1RFp2TGxzMzl0aWxRMTJuS2VyREhWMFdsQjVPQ3hsaUhmR0Ni?=
 =?utf-8?B?Z1QxMGdjbllBNm9kZkI0SnJ2MU1Kb0NDM1Q3YXVaeVBtS1NpRmVuellyWUsz?=
 =?utf-8?B?YW14eDhSOEZMQWliL1psckpUQzdzd0Z4UGdsTks4ZmdhT3FLSkswWE5NaVBY?=
 =?utf-8?B?ODVKaEFGT2V5Uyt1OGhyRUNWNC83RlE1RlFFUmdPR0RRblpQSjFaZzVsOFgw?=
 =?utf-8?B?KytCeDYwYkxDVDVWNjRlS1ZWVWp6ZHpiVjdtTTY2K1RkTzMrZjk5TjBkbGVa?=
 =?utf-8?B?VmQyTlJWN0NVbWdYQXA1NVdvTnMwcG55VHBlRVZjY1NtakNQeUVKd3FFZ1JO?=
 =?utf-8?B?ZkpZcHZtVmNYbWNVTzNHNnJLR21GdDhtV1Y1SGNYdTVsKy9SYk53VkhnWGdi?=
 =?utf-8?B?WjhSUTM3UnNuMjVlYXFDTUh4ZXR0TGVBMFFvODBja3R4bkJONitBZWJHaDhO?=
 =?utf-8?B?dmg3YUlZejA1R3I3SHVpbHlEN0tnYmV4citVbGN0MDkxZGNvNHEreDhmN2ZY?=
 =?utf-8?B?clFvNHF2cGYxQllCeUJtUzdlYWxKV3FzOXNsS0dUU3pidFRaM013blpXU01Z?=
 =?utf-8?B?UkRScCtad3VYUnlVWVJEZlJ2Z2gxclJJSGs0NFRERTd2WWxHeERObWJab2NP?=
 =?utf-8?B?SmFNRTI2TjBKNk1sT0FwRkc5dXlMc09Uc0taZ0VWTDZ5bW1uVVpyMXpsWFhS?=
 =?utf-8?B?NHVwZUVQdkRib2Jtajl6bnNXZURGTEtkWUN3NDNVQmZDOW9ITklucjJrakxO?=
 =?utf-8?B?ZEMvQXBMM2REUjlubVhCSUo0cTJlcWF3NTV6ZnNlcExCTXlyMjlUS0dUNTlN?=
 =?utf-8?B?UnBEZk5nN0F1Y05pV0xSa2xYRUF1bTNUWHk2WEtybmhFUWxMY01hMWQwdGgv?=
 =?utf-8?B?TGx5UWRxZVA3V3BVa0JoemZTc2orTEdGbUsyTTZOcml1WmZkY1RVYXBsNUJB?=
 =?utf-8?B?VVU1ZFZobW9vRVhXMUs1TXdrdjRlVXp3K1k0V0hsVnF5MXF1czNGQlhPUWl3?=
 =?utf-8?B?UlloUDBtdnh5a2xvQVIzUEVZSU1SR2pmcXA3MlVIenZXTm5qZUtBYnpBUXht?=
 =?utf-8?B?SXd6L09lK3hBMEZlYnluY21qekptN0ozZzhVT2JZVUJnL2U3MWJMNFBSclJo?=
 =?utf-8?B?aFg5V3hobC9WUzI4MlEyU21Fd01NR1FkVWt0ZWVCTnZuT3lYZVRlOVp2Mk43?=
 =?utf-8?B?aEpoQnNubnh3Tk93dkFjR0c3ZWdwVHR4MHIwbUJ1NmZtdGwxbHg2Z2htMlFS?=
 =?utf-8?B?Um5hOFNONzNNRFhJY0I5cFFIRVUzbDVlTTAwTWE4OGVxSWREWU4rRWZqeit2?=
 =?utf-8?B?SVZaNmRqa3JGeXFxdDdTMkh1QlI4bUFUTkNXcUpDaTRvM1ROYjh0MVVsZ3ZH?=
 =?utf-8?B?RVpsUEg0THBLZm52R09UWmY3eDd4eWxoajdtZDI3eXdkdzFPWUZqZ242K0Y1?=
 =?utf-8?B?WjBpNkFQeG51QmgzVDhiWXVSVkZ6aUhYeTFsQTduaktaQ3JHTXlNZmc2Ykda?=
 =?utf-8?B?Mm4vbGNVRkE4QVA5TXZUOS9CVGM3c3lBU3FlWEdmZ2tueWlnRkVCVEM0eUdY?=
 =?utf-8?B?R2piT1RJZ3NtaGpJSzJPbG14NmpZS1FjVGx6UDFSeHlUdzBtY2J5aUhpWm5N?=
 =?utf-8?B?ejdIMG9VNVM3T0FPTkVGaWM0WVhjUmV2S0N6aVhCejJqWndyMVJ0eElIRVkz?=
 =?utf-8?B?YjhYOTg2Y2tFeTh3YmplaTUvYkFobTQ0RnpUc0pnb0VkeHdGOHZhOHNrcVRk?=
 =?utf-8?B?N0Rjc2luQTJ3UncwY1FRZjJTOUQzYmx5UnBraEpVNGk5L1lzTzloS3RkMkp4?=
 =?utf-8?B?WXNZdUVMcit2T3YxaUZjVFpFTEwxZzI4LzQrYzZJbEk4dVpOdVdmbDZ1RFg3?=
 =?utf-8?B?YWxBb2tKRXVIdWNOSkQveUtvK0E1ZmNoOGhXeVZxRWdjMUdvaXAyVklzazVT?=
 =?utf-8?B?eDRMeDlFbkc0ekRwelpCYzZ2MC9WSE9hMlh5ZVhlWG5qVlA3QktmT2poQUlH?=
 =?utf-8?B?MDNRUjVGdlJmODhNaDdNL0dwTTU1QjlHNStvYUcySUs1OW10bUZvWVVqWUxR?=
 =?utf-8?B?dHduTnM1aDRXOHRRNkFoN0NYVGV4ZW0xTVl6MGVUMHF2RWRpWFZBYzEzMkds?=
 =?utf-8?B?WHhaMFlTMmFCTCt1bzk0aHFLTEFsajF6NW85V0llWlNDZWVOMkNVd0IxZEEv?=
 =?utf-8?B?ajBrbDhZNEhPTzhpQ1gvSnBwUDdOU3NSRUFoTUkwTDBHQ3NidzJKMko3cGlh?=
 =?utf-8?Q?RfLCaI5MJMprF3mQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca0e810-bf21-49ea-9bbc-08de6990f9f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:14:12.5800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRWsZ4YUcfck4cdsIV2RLX1PXf2punLf1GRiczMuvypxFex/Xh3bCmAOujEe9ZPVptzEtEaN+fVwjLouMEeilBRF2I07SfhFlbAXZE4DP+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258324-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,lunn.ch,kernel.org,gmail.com,enjuk.jp,iogearbox.net,google.com,linux.intel.com,molgen.mpg.de,redhat.com,davemloft.net];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 91ACB12682C
X-Rspamd-Action: no action

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 11 Feb 2026 08:55:14 -0800

> On Wed, 11 Feb 2026 14:51:56 +0100 Alexander Lobakin wrote:
>>>> +free_coalesce:
>>>> +	kfree(coalesce);
>>>> +decfg:
>>>> +	if (ret)
>>>> +		ice_vsi_decfg(vsi);  
>>>
>>> Should this be ice_vsi_decfg_locked(vsi)?
>>>
>>> ice_vsi_rebuild_locked() is called with the netdev lock already held
>>> (either by the ice_vsi_rebuild() wrapper or by callers like
>>> ice_vsi_recfg_qs()). The error path at label 'decfg:' calls ice_vsi_decfg()
>>> which tries to acquire the lock again:
>>>
>>> ice_vsi_rebuild_locked() [netdev lock held]  
>>>   -> ice_vsi_decfg()
>>>      -> netdev_lock(dev)  /* deadlock - already held */  
>>>
>>> This would deadlock when an error occurs after ice_vsi_cfg_def_locked()
>>> succeeds but a later operation fails.  
>>
>> Tony also fed the series to AI, two times, and each time he got a
>> different answer.
>> The series was on iwl-next for 1.5 months and only one bug was reported,
>> which I fixed immediately.
>>
>> I can take a look into this, but wouldn't be better if we take the
>> series now and then have 2 months to fix bugs if any appears?
> 
> I understand the frustration, but unless the review is a false positive
> I don't see how we can ignore it.
> 
> Looking at the PR rate from Intel I suspect you may be better off
> pointing your frustration at the internal process? There seems to 
> be a net-next PR every 2 weeks in 2026. It's not like the 1.5 mo 
> was spent waiting on upstream?

I'm not frustrated at all :> I mentioned those 1.5 months only to say
that during that time, none of the users of our tree faced any bugs,
except one case which was fixed a long ago.

Anyway, this last PR was just a try to squeeze in at the end of the
window to compensate that it took a bit too long for the val to test
the series. It's not a problem at all if it won't.
Maybe I'll even add support for zcrx large buffers in meantime instead
of sending a followup later.

I can't say it's a false positive, but I can't confirm the AI is
absolutely correct here. At least a couple places mentioned that
"shouldn't work" in fact works. It's not just me being Sarah Connor when
it comes to AI, I just don't want people to trust it too much or authors
to waste time proving that AI is wrong.

Your call whether to drop it or take (this PR also contains several
patches not related to netmem, I think they shouldn't be dropped?).

Thanks,
Olek

