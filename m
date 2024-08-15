Return-Path: <netdev+bounces-118981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB736953C6E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD441F22DC2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BE81AC8;
	Thu, 15 Aug 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2JWZgGt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9611149C7D
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756588; cv=fail; b=a1npyTXpgwz0EAGOaygko4cyZ2kpbOe4KCjKkF+NPiXY4KMbx7d8/jeIoEXpIsMfmZ5YvsePaAoziSJeE0bfx6jfM+YnqXmojegDJquRwEKlQzc0i003kIky4N5IaSbLLMh8RBZGjaM8npQcPlIys+QjY1YP6DTuZTHcHb8FY9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756588; c=relaxed/simple;
	bh=9T4tklw4dMQI2D2HHVMY16BN+wN245u49IJA5sGSt3A=;
	h=Message-ID:Date:To:CC:From:Subject:Content-Type:MIME-Version; b=jyGOeJUaRYnU056swZ2H4u0Kz3cDU8o6ZV/GIHvMv8soA1TwlkXh5nY8lpdnj23VLcl65bpX4vSnkCG/ZLpoghERoRUhxgcBSd/Ol489r6OPMTv3dxX02lRjy1dJphBCky0PVG4nFAVG6J/dgBYO9Hg5GLs415HxnmFnmJ9mXHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2JWZgGt; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723756587; x=1755292587;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=9T4tklw4dMQI2D2HHVMY16BN+wN245u49IJA5sGSt3A=;
  b=S2JWZgGtbTV9YkbgY+JkvfHTynMykHmEI2tqR5NaEGTfY9lOSgy4hrqd
   1quZXWDa65Ko+EfPrqAhukBsrNz3DHcVnpO2Zv4xAtz6fncDu6gnDqWtb
   81i0lUBM+wsuE1g3N3gH2Oi2ZCpFdKMelSibDRwxS7K4+xG/HcDuyueyU
   RtRgf1Ohf028j5wB7+AfJAXrZYGAMKHZCJuQWZaDzuYiS+VqnJ1w1aHX+
   wCJfGTESgyNQ9VOQHAJW2+pgU/SKYX0+ShuirQTs33/17bbDTC4iEs3E5
   GRZ7GsN6CDmz2aG/QazC5uYNMuvw602/6FmXrsYnrdCAln24i4EQJHoFe
   g==;
X-CSE-ConnectionGUID: yKhxSy1LS/K25x7pGOpnOA==
X-CSE-MsgGUID: k//0cqjKRkitZknhdOHSVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33429334"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="33429334"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 14:16:26 -0700
X-CSE-ConnectionGUID: FDDdIelPS+2h2xq2Ss0hhg==
X-CSE-MsgGUID: ylF+WSGrSFuQlsx3J5DzJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="63880344"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 14:16:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 14:16:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 14:16:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 14:16:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOs21iPS8tRz3HAEYfEWdolWjP7rAim1tdUV3Ub1S1oaVBPFY5fLaJhxe+19VFC0NCtXBKdyVylYR83Igx3VpRC2HoKiO6zwrfcVvdl1bve7E1Ra2ULzkUB9RBVvm1+L6J/KAqQp/hJoRlSsmmOWGMkWJM2W6jbS36+TN89a4n1DzZGJx3EOxbMoGsafiA/ohC2iN5N2Ae8uhjePIi9vcIGiuvA1xxmpGb8fDQKZjwtSXz6JVy1MnSH/6ABxirtXUY79oWCYsUSvb2tiBw/ulAqZB3pYethB6ygi/Apb08XqOuC6AOW2PC7/LmQuyslUvsTzdHgzNyxOcL0s3BWZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T4tklw4dMQI2D2HHVMY16BN+wN245u49IJA5sGSt3A=;
 b=UNITja64yhvmyry4zGDdDGb7D3hIhPGp3+mxFxOUpizHWwVulDj+bofv/UvIN/ea5g86GWNGbz3kxhJFyYP9ttiduBMgdit3tSQ6qezfXLhI9hIim/fizvSxcJUcgysqrAxJpgYojiRhn/0+GTFvtr6v0nEPFcWt5MH4CrTZxuIOzbgFFe9xnn1DCveHuWDtSqMo6tnjeEzi3iTXZ1J6vaO/acku1XbGa1W/F5uSmZNp+p+bp/JurkRfEaoglFWlV00a989dGk6LPfZhTopLz3TTl7mlZCpzzYdUdTvrv4SXpUpgyUTnv9hHnNV5Bfywz/nsixLu9psLv+DEGqqpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 21:16:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 21:16:16 +0000
Message-ID: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
Date: Thu, 15 Aug 2024 14:16:13 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: lib/packing.c behaving weird if buffer length is not multiple of 4
 with QUIRK_LSW32_IS_FIRST
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:303:b4::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4646:EE_
X-MS-Office365-Filtering-Correlation-Id: 11809be5-25a1-45f0-5b6a-08dcbd6f7f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZE1peS96MVRjbnFCSng4ajJHdXRSTkduTzR6TUhuT3BueEhxb1RSZjluM1Jk?=
 =?utf-8?B?SnpXOFV5L0I5dkJOWWlESitUZG5BamllWEQ1Mk5DVDRwWWVvbnhFUWxZSUFy?=
 =?utf-8?B?Q2xyNHArNEFoZUQxUVU3YmwvRFVUdmY4Y291enJ0U1p6d01KVGdDYU1KczVh?=
 =?utf-8?B?MGtrdUM5SFBCTjN1bkZoN3VLbUp0S0hxS2c4OTVLOE5peTVpTHYwU2hQTzUv?=
 =?utf-8?B?cXYwaUo1cmNUbEJySE5RSFpEcCs1dnVCRmU3WDRPdGc2SFRHODRuZVdPUlcr?=
 =?utf-8?B?MkU5ajd2QjNubkJvdWRJZm1GQS83SmV2M2prOFNjckZ3RktleVVMN0J4Ymg0?=
 =?utf-8?B?ZHNVbFgxdmIwUFBaVFltU3hRVmFSdkhBNVpsT1hCWTRGM0tkVUF6bVNtNEU3?=
 =?utf-8?B?cnBYdVBybzg3QU1XZ3B2aHJFUGpQK2JOS1RxOGxHeStBV2lBVWpLMTF4ckFG?=
 =?utf-8?B?K3BFVzBWUEEybjEvQ0pVNmlaOTBwYW1SUFRmcVhqbzc2ZGdIT3MrMXorU2RF?=
 =?utf-8?B?U0ljaDQvUkN1MEtteGdyWVNvL3NwT3ZscHpQYS9vSXYyUlhFTzIvZzdmTGs4?=
 =?utf-8?B?bEp0emVFNlFjRENjRVVGemVkZXJhaXVSQlkvaUhsdkNjNnJ5ZnJyaWo4S2hh?=
 =?utf-8?B?NnBBT1lpbU51cElQd0ZWU2JoU0drOUdpRUE0Z2VMajAyQllZcUU3ckg4Q280?=
 =?utf-8?B?Vy92NEVNbmRYUjJLR2JXWFRNUGJJWlFyVjJlRnlMSFBldGhPSVg0Qy84SFJ0?=
 =?utf-8?B?TDF0ZHJPV29qQ24rVmkrWkZybjBtdHp3aHlUTWFxcFBJSW5KR0o3d3c4WCty?=
 =?utf-8?B?R1o2Z3JLVG5nVzNOTHJtOUhrckl2S3lKU2lONklVSU81dUZhRDF2Z0hIQ3Ji?=
 =?utf-8?B?cmpGeDNXUlhtK3pTbXMvaDRsUUc3MEw4SVFmMVNvOUFxaDhSMkV1VDAxUU1v?=
 =?utf-8?B?a0xMTDQ0c3AyK2pIeG9wSVZRTEs3MkNCMzh4UE5Wd2JRY3UyOFhCMklraCtx?=
 =?utf-8?B?cXBkTk5FQnZ2NFNNZ3RIWUs4aTJzUVFGQkVQL01rdzdCc3hJSlRoU21DaG5r?=
 =?utf-8?B?M2czK0l2L3NFVzdmWmg2OWtkWmtaSVZEOFB5bHlET3NGem94RlhWVEY3RXE4?=
 =?utf-8?B?RDZVSW1KaFQ1TDdSS01hSEE1cTFXZGd4VlBjVVh2Ym41QmVId0NUQ3FTd0ZK?=
 =?utf-8?B?bmEycUx1YWVaZTBUR1ZhZWhyMCtkMGNyTDlaOUVxRno4cXA3aFhYQWZrNXpm?=
 =?utf-8?B?UFg5RURqM0dVOG5uZTY1eEx2c0loclBvSllYRy9xQVlPcW4wdEo3WVJ1Vm1O?=
 =?utf-8?B?WTlPczRqNjRlL2tPTWs0cy9ndmdFQUN5dVZvUEV5SCt3RmwrelRyZmZleG9x?=
 =?utf-8?B?WUNQZEhwcTE5OTNoTDl0OUJUbVp5L0I4R1JsSzRPaW9WYWlsSzdhQis5MHUy?=
 =?utf-8?B?Q1htd01qc3VxYmhNMFlLN25ZTStRbVR3cjlKeHpMOFUrQnNsSDlUMzlMWCtz?=
 =?utf-8?B?RnU2cW8yRnZ2UHNCWWI1SGhtVnFERXA0TWJ1YVhWOWx2cm9LN1VnRVZZTkUr?=
 =?utf-8?B?UnVvc3lZVFVFdXZzd3RJZFZlaUJXNG5pUzFVbmtjQ0FJMGM5dmNkdEMrNE1M?=
 =?utf-8?B?KzBjUkdwM0RMNERwTTNDdmUvenlDU0cxa0IzNy9TQUMrQlQzTHM1NDdmdWJs?=
 =?utf-8?B?TWdHSDgyU0Z0alNhNGxDUVJNMGhoREJ1NVV0YktESFdabXd3S0ZNNUhTT013?=
 =?utf-8?B?RENFd2lITSsxK253ZjcrcWhxV285TXNPRmpuVXhDU0VGczVpd05wNTBoNEp3?=
 =?utf-8?B?YkFpR3JzZk1GbzJhMnhUdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjdQT2JTUUFYaHg5Qml4bFJKK3YzN0JNOFZ2QlpJUVpsb0g3dE5ScEZ5cU5X?=
 =?utf-8?B?c0pPTlExdUhpRjl5WkJ4RjFwZHpGdGpjTm04aURnRmtRandMa1NsOXRUVFhl?=
 =?utf-8?B?Z1VRYWRuNzVFbFBlbFA4cGtXTy9oOEdyNk4zalI0RURDN1lUYkVSbUY3OE9P?=
 =?utf-8?B?VVJuK3hEeE5yWlNBeitibVBtMjZ1NitRU2M3aVZ5ajBtTlJCUEMvRFB5QTNZ?=
 =?utf-8?B?MDQ1TUlKSkQ0TmJKNVp0TFh1MkgreTVKSHg4anB6ZjhMOVVMaTZ3aGxtYUUy?=
 =?utf-8?B?TlBnSlJYR0x5SldUQ0ZVVnJDNFliUDdueEpyVXRNeUhCQ3VTQjd2TEEyUUFC?=
 =?utf-8?B?VHFWUlBCeXgwRVJoZDlMZGZ1Uzc3TWxwbk9wUGhQTyt5OFd5cGg4c01WcVdL?=
 =?utf-8?B?dHBGaHlpbGhkYXh5ME5NeFNBcnJ6Rm9zd1E1eVZuY2tBaDJYYW9iK08rQzJ6?=
 =?utf-8?B?OHpHcXE0S2cvbDFkZ1pISUZIcXR6UDJidW9LRkUraVhSMWdFSHllbmlhcnU4?=
 =?utf-8?B?a1ZPaHpxTTY1YXhlbTA4YmpBN1BDL2wrWjgveHhSMDdlS1NlNU5zN1d4L3dr?=
 =?utf-8?B?TnhoZUdEWWFva1RYeUU0a2FlOWxXM1UwZFhqdXM2b3NTRllNdlRFWFE2SkEy?=
 =?utf-8?B?eUlkV2lZWkZOWVczQW5uaEJsVExXQVNrV1piYWo2SXBmbzVqTXMvUER6VXAx?=
 =?utf-8?B?WXR5c3ZHTXFQcmVBSS80MXRMM2FvUmNtNmY5NkZoaXJ1U0VzTURmTmt6UCsr?=
 =?utf-8?B?U2pyWjluRmYxSHdZTkYxbHNkRWIzYkVjaHowQWtuMVl1VzdrdFUzSGNpSmFN?=
 =?utf-8?B?L3lOMWRGeGlDYnNaQTJDQ2Y2YUQ2V2Npcm9ia2JBYTNRMzl2SjlzM3pRRVdl?=
 =?utf-8?B?ejRTZndRZXNhZ21CMzRJSng2RFBPb0ppeTd3aHhpYTFoTCs2RzFIWGEyeEgw?=
 =?utf-8?B?OENkTGpNcTlaRmxQZzllMUVTMEF0czZuZ0lxMmRHRGoxVmc2eGxvM0p4SG5w?=
 =?utf-8?B?Z0FKTDB3T2g2aE1ldWNiL1dIK0RySmFFVE5abjduKzJOb1JGNXlFVVlFQ0ds?=
 =?utf-8?B?SDc5WUIzeHA2c3B3Z0tjT1E5TnBXK1B4elZCK0F6SnJSQXdXME85Y040UXJ0?=
 =?utf-8?B?YnJVaWZ3Z2EwUVhXVDFac3o3MXJKZUt1NEc3bXp5QVFQTlFFVGllRGNJdTgz?=
 =?utf-8?B?UXVPNk1SRXBvZEp0MmNZTGMyRXNrUUd0bm96dzZOdUNwTFZxY3lRN0VNQnRj?=
 =?utf-8?B?d3ZRM2JVd1EyaWprSnpNeDRkcnJwSzNFaTZsSzEzOC80VHV2UXZ2L3lVRGxK?=
 =?utf-8?B?bkxiT01zTk8yM1hWbTl3ZHUvMnhSUzVUSHQ4ZCtaTDIvbXVDSis3dDhaaEhv?=
 =?utf-8?B?KzFHSHFEaWRodTZXdVRpU2EyKzRqL0RDNm93ZFkxSDluanlUWExHeFdNNUZi?=
 =?utf-8?B?OWRkN1U3djZEUUNhNnk5UFBwUmxHV1hxNWYwMnZ6V1dUQVRUQ25zL3pSU1Ux?=
 =?utf-8?B?dHpGQUxTL0hOV3RTOUR6ODdrZlVTd3BVM1ZNMndpRzNNZ1FkU2pmNVRCSnZO?=
 =?utf-8?B?RzhwTC8wNWxnRU9tenlFd1NnMGJ0OUdJM1VFN2huaEwvand6OGVPN25adFZM?=
 =?utf-8?B?UDVMcGt4cTlJYWhkbDg4K1U4dzA0a2lTektJNzdqUUVTTXVsOXVBWVpUTVpR?=
 =?utf-8?B?Z01lK1ZwYnl5QkhkcjNMa1RvaE1scWJXY24wSE1GdmY4NjVSa1BzSzRxcytZ?=
 =?utf-8?B?RFMyd2JTM3Zhb3l6L25WanFSeWhnYW1HalFINjJsWFRiRC9Jdk4zVjQxL3NL?=
 =?utf-8?B?U2phODE2K242N1ZSMWlldzFaREVwbTBtUllEM3JEc21QRDJnMFZrVWRlcTZD?=
 =?utf-8?B?RSsxZlBTVEo3MTNMWVl3WmhrTG1DY2xKTG90SDR5WHdtTmtYS1lzc1h2R3Nj?=
 =?utf-8?B?N1poV3ZtaTJweFl3ZWdRanBWdFlRRVZYZFFRUEZhdEVsT1ZBUmliUzMxdkVE?=
 =?utf-8?B?NzdLRkt2MWNuWkJJM3RuRlc1VE52NXBEWW9JSDJ6SjJJK1J3WHNUamY5QW9v?=
 =?utf-8?B?ZE9UOVBzNmt0bmRmUlYxMkZ3Sy8veXZtV1Vyd1RoR28vc2MyQytNY2lobEY3?=
 =?utf-8?Q?HVbKiajqPNblu1Y7LDFwCyB0e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11809be5-25a1-45f0-5b6a-08dcbd6f7f3a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 21:16:16.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUINl3jl9YZMidNnkwoBj6LW9jiMKFjds8dYMarBE5KOdbStTlA7bnfo/j59w4L4m5vywFmvcNvBbuJoVqu4EMC79IygRLo0qD46lsJzL9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com

Hi Vladimir!

I am recently attempting to refactor some bespoke code for packing data
in the ice networking driver into a bit packed hardware array, using the
<linux/packing.h> and lib/packing.c infrastructure.

My hardware packed buffer needs QUIRK_LITTLE_ENDIAN and
QUIRK_LSW32_IS_FIRST, as the entire buffer is packed as little endian,
and the lower words come first in the buffer.

Everything was working ok in initial testing, until I tried packing a
buffer that was 22 bytes long. Everything seemed to shift by 2 bytes:

Here, I print the initial details such as offset, lsb, width, then the
hex dump of the u64 value I'm trying to insert.

I do the call to packing() with the appropriate quirks set, and then hex
dump the 22-byte buffer after.

> kernel: offset=0, size=8, lsb=0, width=57
> kernel: value: 60 9b fe 01 00 00 00 00
> kernel: 0x0000000001fe9b60 -> 000-056: fe 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> kernel: 0x0000000001fe9b60 -> 000-056: 00 00 00 00 00 00

It seems to have failed to copy the first two bytes in to the buffer.

I discovered that if I pretend the buffer is 24 bytes (a multiple of 4
bytes, i.e. a word size), then everything works as expected:

> kernel: offset=0, size=8, lsb=0, width=57
> kernel: value: 60 fc fe 01 00 00 00 00
> kernel: 0x0000000001fefc60 -> 000-056: 60 fc fe 01 00 00 00 00 00 00 00 00 00 00 00 00
> kernel: 0x0000000001fefc60 -> 000-056: 00 00 00 00 00 00 00 00

It seems like this is either a misunderstanding of a fundamental
requirement of the packing() infrastructure, a bug in the
QUIRK_LSW32_IS_FIRST, or I need a new quirk for the packing infrastructure?

Essentially, I think the problem is that it uses the length of the
buffer to find the word, but when the length is not a multiple of 2, the
word offset picked is incorrect.

Using a larger length than the size of the buffer "works" as long as I
never use a bit offset thats larger than the *actual* buffer.. but that
seems like a poor solution.

Essentially, it seems like the default indexing for big endian is
searching for each byte from the end of the array and then using the
quirks to swap back to the inverse ending.

I think the fix is probably just to do a round-up division on the len/4
check in get_reverse_lsw32_offset, since its calculating the total
number of words in the length, and effectively rounds down for lengths
that aren't multiples of 4.

Does this seem like the correct analysis to you?

Thanks,
Jake

