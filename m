Return-Path: <netdev+bounces-212637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FFB21864
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19371A23579
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DA2E4246;
	Mon, 11 Aug 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbRqAATt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476621FF3C;
	Mon, 11 Aug 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951387; cv=fail; b=G+R7Qy7etXkBt6CvB0/dsJsjbzswnJ1BKH4VXOjwOFvnbIJlGOtFEFIXhaQRgZwyMYqXpQpQEkabgced1RWPG5U24PVBhUiic1xYmvO/q0uSprBUNFWncpHyRystJl2oi2rdbWyOjL/M87GbUSIdjMIOk65kmGm7uMtEa9HU8Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951387; c=relaxed/simple;
	bh=QafAb6qshe2HYfuySkE+9FF3NQOMgfqbclPKBSrXUYE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bR6m9BFT5nDjEvlwyK5bHoBCFSORMFYNg6o2PZCSHCy50Lw+0TxENbUke6s+xlvkwSr0VilnNVmUl7GNRfiDfsaGfhVd+WRGWhE4jhVXpfNL6+SKCfOofPzzzwJYV3/gwfB91EBRfDvNpiiFoOoIAtenR5AWdk4ZxSH6k8mgKUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbRqAATt; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754951386; x=1786487386;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QafAb6qshe2HYfuySkE+9FF3NQOMgfqbclPKBSrXUYE=;
  b=mbRqAATt2yu0F85nO8vSlb80RLxebUagNoSGYkCCwcFaeh+xxqhyT63F
   g5EDxWgaVG8fhLDWYZHvKrp1kaJuiV+hvSwIxDECBt2bEdnd0P3OETC0y
   93hDCgluETuwJMInn1GRfxB08RkjqWxiZU8xowJFxo1CkkDmlxTbUEvl0
   GEiLAFCgDeHxCHs8IAJVW40Cs5iyXcFsWS3UqFDdaOhdU9utuQH5gDruc
   yPNlXoa8WZ2P/kKnYJLr/uyDNc8aMsppw5F0ImkDQ/2/63GPEcaSfgdpY
   lGxpG8cAlOF0tPeFefkdlj7YEcsoXtk/XCV5LTOStkHF4gi55Z7zUB2SI
   w==;
X-CSE-ConnectionGUID: iSXJMiUWSOunrfOkTZbE9A==
X-CSE-MsgGUID: vOlQanjUTNquH2Ama1Gy4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="59827115"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="59827115"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 15:29:45 -0700
X-CSE-ConnectionGUID: DKdAiyOMRv+CM1/kW2v1nA==
X-CSE-MsgGUID: SIQpapS1SWCotkifYmtVig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170231986"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 15:29:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 15:29:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 15:29:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.59)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 15:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI7v/w40fiYrtmlzS0w/Knma3vs+GVgPhi0pXB5jCdffLCnceEe0JzCxjuCL5Z/b519SsMpWZGzMrXLIUmbc9knOe0f83fROoMFV42epmLX5IM9kvaKWGis2QZQOZFwQYFMdYUy4K4tSxUPdFdHs8KE8eUIMZYh6i7ILenDkmZc5Pa53VoNNbVroPcYZsK2WRHRqXe2GZFExD3MnoPwlDtqvVXMG+HoXU/D//4HS3hW1rkA/EDMp141IgN+S/GdHZFRgtpwr0cGXt/ouiLs5Bg+rf2M00g9EI5pp93sLClpsbPYB+ePIAJdbfNG47Myig79Xbe6v2VLgHPNXraBwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMA6Eez6mFAOrshFGAWqRgLBOli57/KnfKNZP8FEa8g=;
 b=TaHhJeoM9fHhIoh/Rwj+C6Hc1TBM1/AOR8g8GAoAnlSxtdoEwzGUkrjkpCAm1Fb3KoaMod7t8n0IO9KFzZq/+hvsRFqqEohABqkR15v8WV0VP1M69I/DLyiwlVmbqWtPkYKliwRm+NeJzwzFrAVDBUV6wjOkouupwh9OkplYn6qUP8f45PVRc6k9k6zqmNCsyc8aCnRWqfUoMc0bbT9SAvKgiKLw0Eim/xdHHZjzVGYuwv7GtinIqrb5OOSLLJOc2P/+eIxnihFwNxIe12wC6idfeA+93/88Mgw+R71tn0qNFtLSE8Tle95OQs9Kr5q7cZ2rTj+W7Lp8mtuO8WJURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 22:29:41 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 22:29:41 +0000
Message-ID: <168315c3-48c2-40ca-be70-8967f65f1343@intel.com>
Date: Tue, 12 Aug 2025 00:29:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/5] dpll: zl3073x: Add low-level flash
 functions
To: Ivan Vecera <ivecera@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michal Schmidt <mschmidt@redhat.com>, "Petr
 Oros" <poros@redhat.com>
References: <20250811144009.2408337-1-ivecera@redhat.com>
 <20250811144009.2408337-3-ivecera@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250811144009.2408337-3-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0002.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: b0383196-a667-4575-ec80-08ddd9269068
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHlZVFlwRXQ1RXFSdW5DWG81U29QN3FCUVY5UU9xeGg1eFFmYXFReXVUN25x?=
 =?utf-8?B?bmFHUzRwaUFEaVk0c1lhY0NFTHA5eVhhNFRNRjZyeWV4RFRlZ1NqNTBUa2RV?=
 =?utf-8?B?S1dpSE1JaUFoaHZkSng5akNKNk9tUnM4MHJEc3d4NGcwayt2eGhsU2JZMzU0?=
 =?utf-8?B?SDM5VXcrc1RVL0F2UFkxamhKb0FMam5ta3JEdW52SmFiSzB1MEp2eTZJNlVt?=
 =?utf-8?B?K3FrSllPQXhSVjA4Nm1aVXBNMnU2YTNyeTZVeW9ONzk5d1dDNGd1dmxDanM2?=
 =?utf-8?B?SUlLd25heWNPaEhLYk95dXgzYnk0c29RTXNQRzlxbjdYcmxwUUdNTS9pblJS?=
 =?utf-8?B?VWxDR3F6R2s5aHBOUkVlazc0VHNkUmNqT1NvTWZjTEcwVkd5VjRFd2wyYlpM?=
 =?utf-8?B?TGVza29pNzRERmd4RkpBRE9vcmRuWldiajZndEJJcVRjRHFMTmUxM3RJc0F0?=
 =?utf-8?B?cUFKaUp2MXNIcERURUdra0RyandscVp1QSswWnZJcXlNanpPZHh4bGZTNjZN?=
 =?utf-8?B?UWQ4QkhqcDZ0cFpVSnhYa0FOQlhSQU00eG5FZ2IzYzU1bXV0bFJlNSttVGFY?=
 =?utf-8?B?SzZiWDhKVko0Wm5McnQrekFaM0YvVjZqUkt1NEtiQkZFVzZtcCtwbWZXN0cx?=
 =?utf-8?B?ZHhncXl0WGNXZDZsSnB5N1RWTDNteUQ3U3hyOVZuVjJTY3luYStaL1NPMlFa?=
 =?utf-8?B?MGgyQU9jdnhFUHNnUm81akRDOHNhT0hpcUxURTVPdlRWMFIwZW1HQit4Sk5Y?=
 =?utf-8?B?aS9pZU1TZExGVjVmL1lBeTEvWVBWUVBqWGQxVm9nWFZncG1DbzgrMG1Ccmlt?=
 =?utf-8?B?TFhKaDZ4dGJpKzRPT2JpQUZBaERqUjVkWmY1UmxmNTl5WThsdis1bGZ2NGha?=
 =?utf-8?B?TzBlTCtZSW5Ca3dieTkyVXNKOVZKYUR2U0JUT2FLazlMTmJHYVJPUFFjc3JN?=
 =?utf-8?B?eWtrRHIzVFZDVEh2dXdDSmpwUVJSNVJDc3prbUJYTEtwOEVQbTR6aDlSMFVH?=
 =?utf-8?B?VXFRajYxaE8vdTlsS3VWVkVBb0xKWTh2Y0ZWZDhrZWZNSUxqcEpXc0tJdUlN?=
 =?utf-8?B?Rm9yT3Q0TmpIaWlUaTVlZWlZVXJ5a0ZabCs3N3FRMnZDOWI0c2tiS3NsTEVU?=
 =?utf-8?B?WWZjU0lQZC9HWjlqTHZkUzkxRXJkVmFQdGRBaTlGdE9hY2pQT0xpQjFxOVUz?=
 =?utf-8?B?YXRLeWV1RDVpTHBmVDhnN3F2eDIwMjcwYktpek5KeWpBVGFpOHVtN0ExQ28z?=
 =?utf-8?B?dnByQnpEUklrRENENCtQck9mcVZ5R28vZThIOWcvRFYxK1Y4ZzNmWWwvZjRG?=
 =?utf-8?B?TlR3aVY4VmZLR01kU01mUmRNL0JyVXhxcVp6Y1E4R2JJRnprNWx5ZDUwdThK?=
 =?utf-8?B?OXhXWFlJNHBSODBLMWVEYkRXUE9nQ1dKd0xndjVOb3h6K0dMYTVlNmpRT0xp?=
 =?utf-8?B?Z0I1NEZEbDFpdUhkeG9TVTVJc2J0SHBiVGJzY1NZaW9GR3ZOWEtleXVHK2xL?=
 =?utf-8?B?Vm1qZmZKWWE4c2ltREJvQzljS1NWWlJqZUdTZERIUmpzbkhPQ1VuZGljVjQr?=
 =?utf-8?B?N0o3TXdUR04waHBjL0VYSEhGa0xOQkxaSnBGRFVaNng2TUdnK1IvTDRsR3Rq?=
 =?utf-8?B?MmRIZU5rVDhmZUJyekM1VTFnak5NTCswRGdKVTA4aTM1V2xYalN2ekQ0UkJW?=
 =?utf-8?B?Rzd6eS9ETUNscm1mUWpNd3VoNmFkVEMwdWpiSDVkSGR0K0JLSGRpdGtYRkI3?=
 =?utf-8?B?UytzeE5pWldVVFMvQnpjcEF2a2lBVnNyc2tQVFhzcHdwUEdJZjd4aUsrODd2?=
 =?utf-8?B?bEkzdXBkd25ZVWJFZFhyN0MzQ1p0YXhOeFZrZFhGL3J0MmY1MmhNVmxiWkMx?=
 =?utf-8?B?S09iU1NMa1NvNmlvbitBN3RLQTY2Q3p0WnZOZzA0M1RKcngvSDhtOXVwWGQx?=
 =?utf-8?Q?OrkCZeR3F10=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRJWXVmVkhOTG1USW5DQlZZa3hnNmRONXVBZXNmVFlUakxvVFlnQi9NbmR1?=
 =?utf-8?B?c1U2SG1TSnFNeWQwbTlLL0FlVjJWVG1ncXhQUVFQakhCbU1CSFBLb3BCT25L?=
 =?utf-8?B?a3NZdGlVOEdpWXJiM0x5NG5NQlpSbTU4YnJOYXRQVVlHRElMUVBzenRVZFVq?=
 =?utf-8?B?MTQ5cHlCc2RzOTdUM2s3aUFOc2xLWnFTdjUrakdhK01OZlhBKzRKYjR1WEw0?=
 =?utf-8?B?Zlc4K2x6VlJ3UjY3cnhSWEtCbVdyMlBQQ1Flckx3QUkrWHRzQkVjVUFxcG93?=
 =?utf-8?B?d0djdmltS1gwOUZHeUNGMG5zSFZNaU9seHRKYWhqcC92ekZhb25ORjYxSjJ1?=
 =?utf-8?B?RjlTdDRHSHdWNW5qSXpVa01wajZRVjE4UXR2SG13VnN3MDdIemtoVHpXckZB?=
 =?utf-8?B?OGxzcUlXV0k3YTJpK29iOGp5S1JneFkwMDJMWEJkcmY1bmtHL21zbStKcmQ5?=
 =?utf-8?B?dE1CdFdGbWpudEJ0SGpNZTJ3ZW9xcitsOWw3dlNFbTV1QmVlaWw3aGc3dHJk?=
 =?utf-8?B?U0R2TEd4Zit0VWV1K3ZwMjRZOWFvdzh0eXMxZkd3TDhSaG5yVi8vYzJkeGpx?=
 =?utf-8?B?RUZGQk1PSWl6QjROc1RFTUJuSnlBQUFLMml3WkRHaEhkSWpVRDVFNytGbjYw?=
 =?utf-8?B?UzdENUpzNjI2YlZsdVNSMUVGRTk1NTQrYTFlWTFqaG1TWllBODVYeU9VVGhB?=
 =?utf-8?B?V3NlOEx3Qmp3YjNxV2tVekVHK041TWk3dWpIOUwyTWRlaWgwOVlVVTJGQXhm?=
 =?utf-8?B?STlZQ1NZQUhDMFJncUFBZC9QTnFuWXZ4MWM5QlErendycFRUR1ZjWWlHWk5E?=
 =?utf-8?B?amtKKzYyYkpqZERyY2hPd1BYNFJTb2VlbVJXUVhxK0Z1UmRPVzNoVFA4b1k0?=
 =?utf-8?B?VllTVVRLVXZoRm55dTNjWjBqRVB5bDIxTk5UckJXZ1JRTHdJZjB5TGZneWN0?=
 =?utf-8?B?bmJMcHZMZGsrRkwwM1Z3anBXQklmNi9ncDRoUHR2eWUvcHBGQlJYbnJJbjhH?=
 =?utf-8?B?djhkK3hXN0N1WGxZWERheCtRRGI2MG81L0VOaEZLWjdabGMvNmtDb0doVXdW?=
 =?utf-8?B?eW1DdDRyRUxzZThmUjdaNHg0K3VzZ0MyZTNUWW1WMDUrUTVoUnczV0hXa3Jr?=
 =?utf-8?B?UmMwenVrd28wODFJNGpZaXlDakFpdXVSODBFT3Z3YTJVN0lNeW1TblFqM0NL?=
 =?utf-8?B?UW0yNGZEMmdtZmRpSlFFTDRHdWxvMmRDSmxBM0pOKzZPcnlZK0poY2RXY21I?=
 =?utf-8?B?ZmRXWmdkNEVqSjRoK0xva1F5L3R1NWhWT2F4alN1bWhSL0o4YjlPMHhZTUc0?=
 =?utf-8?B?MnRSSlJkbW8ydUJ4am1xS0JFQ1dKZnpsQ3N0RDZYeFVTNWgzNUE1Ymh0cXp5?=
 =?utf-8?B?MUhKT1pFUTU3UnJJTnY2UlBENmhSSnR2WTlqK2UzMEMyWmdHd3lQMEx1Qlpo?=
 =?utf-8?B?dmsxM3pkWW1iQ2ZnUnI2d0IzT1I1SWxubEZ5LzhxeEdaYkNHdUdQcUc0UGQv?=
 =?utf-8?B?VjhxN0wvNnRnM2FyT0t0RVhrTXJmMVM0SEQrMFdhMjUxdGs5ZW5aejdlODNi?=
 =?utf-8?B?THZqanQ5blJBUk5xZFVmS24rM2JRUGtyODFSNGVDZFk3aUY0ekYybktkakNF?=
 =?utf-8?B?RVgxNmsycjlvNGxWRmh6YUpyUmN6WHNNTDBBNWxaVHZySzhNRWxsZGxwT21V?=
 =?utf-8?B?Unh6aUtQUEhCdTJxMmpYS0tqNytQeGpHQTBSS1l1NE5XVDFpSC9iNk55U3lG?=
 =?utf-8?B?M2x2SzNEVGVRbFVQREJwUzZhbGZKS2d6KzN6citMOVNwV3VNZ0tlRkxUL3FB?=
 =?utf-8?B?Y1JFQjdLSExxek0ydlpyVFRVWThqWWUvallpbk1FYmFqempDOE41WUk2Z3Ra?=
 =?utf-8?B?Q2JjSjNLMHMzalVRRmdBNDQ4dy9taWZ1UGhoNlJiTjY2aW1qWlRnRlV5eW0x?=
 =?utf-8?B?dG4wWEwvcWhQTzhCTDlLYmMrQ2kzQ3UrK1ZwTi8rMnZUZjJGSkF5a25rVUtT?=
 =?utf-8?B?MGlKUy93UnRxY09Jd01YU3VzTG5kQkZPWjB2MTFqbmlxcy9oczhxZUtvcjl4?=
 =?utf-8?B?c3pwU1YvMFVxZ1B6aE9VSjZraTNLN1ZLbE4xcmIwRVRwcnl4K29WRm41K1FK?=
 =?utf-8?B?ckxRRDY4YUdRVUJNaUVwTzFWL1lSakw1VUhzRXF5YlNqYmFnejFUR3EvWHQr?=
 =?utf-8?Q?5UFepGEy0xov8VnMTQReAa0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0383196-a667-4575-ec80-08ddd9269068
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 22:29:41.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIZrFY7fgd6CQdRUeR+fkJobizmHAEN7v73wNp8DHEdBzbOOismkoVyNq+CFXrNnOXXekyTWjczn34uDVCZXb5awI92lm12l0s7mrwG+w04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
X-OriginatorOrg: intel.com

On 8/11/25 16:40, Ivan Vecera wrote:
> To implement the devlink device flash functionality, the driver needs
> to access both the device memory and the internal flash memory. The flash
> memory is accessed using a device-specific program (called the flash
> utility). This flash utility must be downloaded by the driver into
> the device memory and then executed by the device CPU. Once running,
> the flash utility provides a flash API to access the flash memory itself.
> 
> During this operation, the normal functionality provided by the standard
> firmware is not available. Therefore, the driver must ensure that DPLL
> callbacks and monitoring functions are not executed during the flash
> operation.
> 
> Add all necessary functions for downloading the utility to device memory,
> entering and exiting flash mode, and performing flash operations.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v2:
> * extended 'comp_str' to 32 chars to avoid warnings related to snprintf
> * added additional includes
> ---
>   drivers/dpll/zl3073x/Makefile  |   2 +-
>   drivers/dpll/zl3073x/devlink.c |   9 +
>   drivers/dpll/zl3073x/devlink.h |   3 +
>   drivers/dpll/zl3073x/flash.c   | 684 +++++++++++++++++++++++++++++++++
>   drivers/dpll/zl3073x/flash.h   |  29 ++
>   drivers/dpll/zl3073x/regs.h    |  39 ++
>   6 files changed, 765 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/dpll/zl3073x/flash.c
>   create mode 100644 drivers/dpll/zl3073x/flash.h


> +static int
> +zl3073x_flash_download(struct zl3073x_dev *zldev, const char *component,
> +		       u32 addr, const void *data, size_t size,
> +		       struct netlink_ext_ack *extack)
> +{
> +#define CHECK_DELAY	5000 /* Check for interrupt each 5 seconds */

nit: please add ZL_ prefix

> +	unsigned long timeout;
> +	const void *ptr, *end;
> +	int rc = 0;
> +
> +	dev_dbg(zldev->dev, "Downloading %zu bytes to device memory at 0x%0x\n",
> +		size, addr);
> +
> +	timeout = jiffies + msecs_to_jiffies(CHECK_DELAY);
> +
> +	for (ptr = data, end = data + size; ptr < end; ptr += 4, addr += 4) {
> +		/* Write current word to HW memory */
> +		rc = zl3073x_write_hwreg(zldev, addr, *(const u32 *)ptr);
> +		if (rc) {
> +			ZL_FLASH_ERR_MSG(zldev, extack,
> +					 "failed to write to memory at 0x%0x",
> +					 addr);
> +			return rc;
> +		}
> +
> +		/* Check for pending interrupt each 5 seconds */

nit: comment seems too trivial (and ~repeats the above one)

> +		if (time_after(jiffies, timeout)) {
> +			if (signal_pending(current)) {
> +				ZL_FLASH_ERR_MSG(zldev, extack,
> +						 "Flashing interrupted");
> +				return -EINTR;
> +			}
> +
> +			timeout = jiffies + msecs_to_jiffies(CHECK_DELAY);
> +		}
> +
> +		/* Report status each 1 kB block */
> +		if ((ptr - data) % 1024 == 0)
> +			zl3073x_devlink_flash_notify(zldev, "Downloading image",
> +						     component, ptr - data,
> +						     size);
> +	}
> +
> +	zl3073x_devlink_flash_notify(zldev, "Downloading image", component,
> +				     ptr - data, size);
> +
> +	dev_dbg(zldev->dev, "%zu bytes downloaded to device memory\n", size);
> +
> +	return rc;
> +}
> +


> +/**
> + * zl3073x_flash_wait_ready - Check or wait for utility to be ready to flash
> + * @zldev: zl3073x device structure
> + * @timeout_ms: timeout for the waiting
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_flash_wait_ready(struct zl3073x_dev *zldev, unsigned int timeout_ms)
> +{
> +#define ZL_FLASH_POLL_DELAY_MS	100
> +	unsigned long timeout;
> +	int rc, i;
> +
> +	dev_dbg(zldev->dev, "Waiting for flashing to be ready\n");
> +
> +	timeout = jiffies + msecs_to_jiffies(timeout_ms);

this is duplicated in the loop init below

> +
> +	for (i = 0, timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	     time_before(jiffies, timeout);
> +	     i++) {
> +		u8 value;
> +
> +		/* Check for interrupt each 1s */
> +		if (i > 9) {
> +			if (signal_pending(current))
> +				return -EINTR;
> +			i = 0;
> +		}
> +
> +		/* Read write_flash register value */
> +		rc = zl3073x_read_u8(zldev, ZL_REG_WRITE_FLASH, &value);
> +		if (rc)
> +			return rc;
> +
> +		value = FIELD_GET(ZL_WRITE_FLASH_OP, value);
> +
> +		/* Check if the current operation was done */
> +		if (value == ZL_WRITE_FLASH_OP_DONE)
> +			return 0; /* Operation was successfully done */
> +
> +		msleep(ZL_FLASH_POLL_DELAY_MS);

nit: needless sleep in the very last iteration step
(a very minor issue with timeouts in range of minutes ;P)

> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +/**
> + * zl3073x_flash_cmd_wait - Perform flash operation and wait for finish
> + * @zldev: zl3073x device structure
> + * @operation: operation to perform
> + * @extack: netlink extack pointer to report errors
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_flash_cmd_wait(struct zl3073x_dev *zldev, u32 operation,
> +		       struct netlink_ext_ack *extack)
> +{
> +#define FLASH_PHASE1_TIMEOUT_MS 60000	/* up to 1 minute */
> +#define FLASH_PHASE2_TIMEOUT_MS 120000	/* up to 2 minutes */

nit: missing prefixes

> +	u8 value;
> +	int rc;
> +
> +	dev_dbg(zldev->dev, "Sending flash command: 0x%x\n", operation);
> +
> +	/* Wait for access */
> +	rc = zl3073x_flash_wait_ready(zldev, FLASH_PHASE1_TIMEOUT_MS);
> +	if (rc)
> +		return rc;
> +
> +	/* Issue the requested operation */
> +	rc = zl3073x_read_u8(zldev, ZL_REG_WRITE_FLASH, &value);
> +	if (rc)
> +		return rc;
> +
> +	value &= ~ZL_WRITE_FLASH_OP;
> +	value |= FIELD_PREP(ZL_WRITE_FLASH_OP, operation);
> +
> +	rc = zl3073x_write_u8(zldev, ZL_REG_WRITE_FLASH, value);
> +	if (rc)
> +		return rc;
> +
> +	/* Wait for command completion */
> +	rc = zl3073x_flash_wait_ready(zldev, FLASH_PHASE2_TIMEOUT_MS);
> +	if (rc)
> +		return rc;
> +
> +	/* Check for utility errors */
> +	return zl3073x_flash_error_check(zldev, extack);
> +}
> +
> +/**
> + * zl3073x_flash_get_sector_size - Get flash sector size
> + * @zldev: zl3073x device structure
> + * @sector_size: sector size returned by the function
> + *
> + * The function reads the flash sector size detected by flash utility and
> + * stores it into @sector_size.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_flash_get_sector_size(struct zl3073x_dev *zldev, size_t *sector_size)
> +{
> +	u8 flash_info;
> +	int rc;
> +
> +	rc = zl3073x_read_u8(zldev, ZL_REG_FLASH_INFO, &flash_info);
> +	if (rc)
> +		return rc;
> +
> +	switch (FIELD_GET(ZL_FLASH_INFO_SECTOR_SIZE, flash_info)) {
> +	case ZL_FLASH_INFO_SECTOR_4K:
> +		*sector_size = 0x1000;
> +		break;
> +	case ZL_FLASH_INFO_SECTOR_64K:
> +		*sector_size = 0x10000;

nit: up to you, but I would like to see SZ_64K instead
(and don't count zeroes), if so, SZ_4K for the above too

> +		break;
> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * zl3073x_flash_sectors - Flash sectors
> + * @zldev: zl3073x device structure
> + * @component: component name
> + * @page: destination flash page
> + * @addr: device memory address to load data
> + * @data: pointer to data to be flashed
> + * @size: size of data
> + * @extack: netlink extack pointer to report errors
> + *
> + * The function flashes given @data with size of @size to the internal flash
> + * memory block starting from page @page. The function uses sector flash
> + * method and has to take into account the flash sector size reported by
> + * flashing utility. Input data are spliced into blocks according this
> + * sector size and each block is flashed separately.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_flash_sectors(struct zl3073x_dev *zldev, const char *component,
> +			  u32 page, u32 addr, const void *data, size_t size,
> +			  struct netlink_ext_ack *extack)
> +{
> +#define ZL_FLASH_MAX_BLOCK_SIZE	0x0001E000
> +#define ZL_FLASH_PAGE_SIZE	256
> +	size_t max_block_size, block_size, sector_size;
> +	const void *ptr, *end;
> +	int rc;
> +
> +	/* Get flash sector size */
> +	rc = zl3073x_flash_get_sector_size(zldev, &sector_size);
> +	if (rc) {
> +		ZL_FLASH_ERR_MSG(zldev, extack,
> +				 "Failed to get flash sector size");
> +		return rc;
> +	}
> +
> +	/* Determine max block size depending on sector size */
> +	max_block_size = ALIGN_DOWN(ZL_FLASH_MAX_BLOCK_SIZE, sector_size);
> +
> +	for (ptr = data, end = data + size; ptr < end; ptr += block_size) {

block_size is uninitialized on the first loop iteration

> +		char comp_str[32];
> +
> +		block_size = min_t(size_t, max_block_size, end - ptr);
> +
> +		/* Add suffix '-partN' if the requested component size is
> +		 * greater than max_block_size.
> +		 */
> +		if (max_block_size < size)
> +			snprintf(comp_str, sizeof(comp_str), "%s-part%zu",
> +				 component, (ptr - data) / max_block_size + 1);
> +		else
> +			strscpy(comp_str, component);
> +
> +		/* Download block to device memory */
> +		rc = zl3073x_flash_download(zldev, comp_str, addr, ptr,
> +					    block_size, extack);
> +		if (rc)
> +			goto finish;
> +
> +		/* Set address to flash from */
> +		rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_START_ADDR, addr);
> +		if (rc)
> +			goto finish;
> +
> +		/* Set size of block to flash */
> +		rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_SIZE, block_size);
> +		if (rc)
> +			goto finish;
> +
> +		/* Set destination page to flash */
> +		rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, page);
> +		if (rc)
> +			goto finish;
> +
> +		/* Set filling pattern */
> +		rc = zl3073x_write_u32(zldev, ZL_REG_FILL_PATTERN, U32_MAX);
> +		if (rc)
> +			goto finish;
> +
> +		zl3073x_devlink_flash_notify(zldev, "Flashing image", comp_str,
> +					     0, 0);
> +
> +		dev_dbg(zldev->dev, "Flashing %zu bytes to page %u\n",
> +			block_size, page);
> +
> +		/* Execute sectors flash operation */
> +		rc = zl3073x_flash_cmd_wait(zldev, ZL_WRITE_FLASH_OP_SECTORS,
> +					    extack);
> +		if (rc)
> +			goto finish;
> +
> +		/* Move to next page */
> +		page += block_size / ZL_FLASH_PAGE_SIZE;
> +	}
> +
> +finish:
> +	zl3073x_devlink_flash_notify(zldev,
> +				     rc ?  "Flashing failed" : "Flashing done",
> +				     component, 0, 0);
> +
> +	return rc;
> +}
> +
> +/**
> + * zl3073x_flash_page - Flash page
> + * @zldev: zl3073x device structure
> + * @component: component name
> + * @page: destination flash page
> + * @addr: device memory address to load data
> + * @data: pointer to data to be flashed
> + * @size: size of data
> + * @extack: netlink extack pointer to report errors
> + *
> + * The function flashes given @data with size of @size to the internal flash
> + * memory block starting with page @page.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_flash_page(struct zl3073x_dev *zldev, const char *component,
> +		       u32 page, u32 addr, const void *data, size_t size,
> +		       struct netlink_ext_ack *extack)
> +{

looks like a canditate to use zl3073x_flash_sectors(), or make
a higher-level helper that will do heavy-lifting for
zl3073x_flash_sectors() and zl3073x_flash_page()
(especially that you did such great job with low-level helpers)

> +	int rc;
> +
> +	/* Download component to device memory */
> +	rc = zl3073x_flash_download(zldev, component, addr, data, size, extack);
> +	if (rc)
> +		goto finish;
> +
> +	/* Set address to flash from */
> +	rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_START_ADDR, addr);
> +	if (rc)
> +		goto finish;
> +
> +	/* Set size of block to flash */
> +	rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_SIZE, size);
> +	if (rc)
> +		goto finish;
> +
> +	/* Set destination page to flash */
> +	rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, page);
> +	if (rc)
> +		goto finish;
> +
> +	/* Set filling pattern */
> +	rc = zl3073x_write_u32(zldev, ZL_REG_FILL_PATTERN, U32_MAX);
> +	if (rc)
> +		goto finish;
> +
> +	zl3073x_devlink_flash_notify(zldev, "Flashing image", component, 0,
> +				     size);
> +
> +	/* Execute sectors flash operation */
> +	rc = zl3073x_flash_cmd_wait(zldev, ZL_WRITE_FLASH_OP_PAGE, extack);
> +	if (rc)
> +		goto finish;
> +
> +	zl3073x_devlink_flash_notify(zldev, "Flashing image", component, size,
> +				     size);
> +
> +finish:
> +	zl3073x_devlink_flash_notify(zldev,
> +				     rc ?  "Flashing failed" : "Flashing done",
> +				     component, 0, 0);
> +
> +	return rc;
> +}


> +
> +static int
> +zl3073x_flash_host_ctrl_enable(struct zl3073x_dev *zldev)
> +{
> +	u8 host_ctrl;
> +	int rc;
> +
> +	/* Read host control register */
> +	rc = zl3073x_read_u8(zldev, ZL_REG_HOST_CONTROL, &host_ctrl);
> +	if (rc)
> +		return rc;
> +
> +	/* Enable host control */
> +	host_ctrl &= ~ZL_HOST_CONTROL_ENABLE;

suspicious, as this line does nothing (in the context of the next one)

> +	host_ctrl |= ZL_HOST_CONTROL_ENABLE;
> +
> +	/* Update host control register */
> +	return zl3073x_write_u8(zldev, ZL_REG_HOST_CONTROL, host_ctrl);
> +}
> +
> +/**
> + * zl3073x_flash_mode_enter - Switch the device to flash mode
> + * @zldev: zl3073x device structure
> + * @util_ptr: buffer with flash utility
> + * @util_size: size of buffer with flash utility
> + * @extack: netlink extack pointer to report errors
> + *
> + * The function prepares and switches the device into flash mode.
> + *
> + * The procedure:
> + * 1) Stop device CPU by specific HW register sequence
> + * 2) Download flash utility to device memory
> + * 3) Resume device CPU by specific HW register sequence
> + * 4) Check communication with flash utility
> + * 5) Enable host control necessary to access flash API
> + * 6) Check for potential error detected by the utility
> + *
> + * The API provided by normal firmware is not available in flash mode
> + * so the caller has to ensure that this API is not used in this mode.
> + *
> + * After performing flash operation the caller should call
> + * @zl3073x_flash_mode_leave to return back to normal operation.
> + *
> + * Return: 0 on success, <0 on error.
> + */
> +int zl3073x_flash_mode_enter(struct zl3073x_dev *zldev, const void *util_ptr,
> +			     size_t util_size, struct netlink_ext_ack *extack)
> +{
> +	/* Sequence to be written prior utility download */
> +	static const struct zl3073x_hwreg_seq_item pre_seq[] = {
> +		HWREG_SEQ_ITEM(0x80000400, 1, BIT(0), 0),
> +		HWREG_SEQ_ITEM(0x80206340, 1, BIT(4), 0),
> +		HWREG_SEQ_ITEM(0x10000000, 1, BIT(2), 0),
> +		HWREG_SEQ_ITEM(0x10000024, 0x00000001, U32_MAX, 0),
> +		HWREG_SEQ_ITEM(0x10000020, 0x00000001, U32_MAX, 0),
> +		HWREG_SEQ_ITEM(0x10000000, 1, BIT(10), 1000),
> +	};
> +	/* Sequence to be written after utility download */
> +	static const struct zl3073x_hwreg_seq_item post_seq[] = {
> +		HWREG_SEQ_ITEM(0x10400004, 0x000000C0, U32_MAX, 0),
> +		HWREG_SEQ_ITEM(0x10400008, 0x00000000, U32_MAX, 0),
> +		HWREG_SEQ_ITEM(0x10400010, 0x20000000, U32_MAX, 0),
> +		HWREG_SEQ_ITEM(0x10400014, 0x20000004, U32_MAX, 0),
> +		HWREG_SEQ_ITEM(0x10000000, 1, GENMASK(10, 9), 0),
> +		HWREG_SEQ_ITEM(0x10000020, 0x00000000, U32_MAX, 0),
> +		HWREG_SEQ_ITEM(0x10000000, 0, BIT(0), 1000),
> +	};
very nice code

