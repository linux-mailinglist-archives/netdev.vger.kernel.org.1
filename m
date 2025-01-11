Return-Path: <netdev+bounces-157329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E709A09FC3
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D954168ABE
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F55184E;
	Sat, 11 Jan 2025 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyPjD6fj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65B28371
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556696; cv=fail; b=tILBKW2e0mJv1/vKDkRoCGWNcGn8LPH8jeilJ7vnTixFvUbNEfb84hhH2o4NHPucq9YIhsLOb2ifUJpAARCrUlElfg4ES2lsBD/3QFctmdU8ZIgm3CVmbDR8s7QWj8GiPkEgCgrCe2/+i2wyJPmXeh1a9w3U6YEQIHANN8rhsCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556696; c=relaxed/simple;
	bh=eDe1Ae/StRtUGT+uFaoWLdatCKK0L+AC9A1phWSjwJo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gu+20loGR8SUS+guzqa/Poxu7s7PuubzFxjWsam3q7FMqjDJGt8L0Zl3hkbBenUX5ULUsy6lJJGYQYvekthfizKpuSJf6Cl80E2ErWz6cX2E4Zy5NuZwq0Lu9i9RYKoMHsYLygeBfTdUCZlxOunWieunnBL2jjuSUCKlzFuYXGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyPjD6fj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736556695; x=1768092695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eDe1Ae/StRtUGT+uFaoWLdatCKK0L+AC9A1phWSjwJo=;
  b=MyPjD6fjGFnun+LGpZ7qQmwv7XnRRANGbN8Ld5OftBgZDQzPJ9BYJehY
   u4h3n7oy2NHQIxuj6CF9JK48zdbO1aqJpCgfOIn02H4HaCis0u9E0SWke
   PrGxb7sAev5mD6FQoua6ipMDEOT9I8iAWptp7n4qVakNf7cCGS2/AvVZD
   xNlN77D5pLVZRVC5Xy0WlK7aPCUa6KwVJYjqxR4yn40iiP/Gjw/t4ywX+
   zDWSVNd+fycHk15ioVvU+CCJ7f34TtYL+kBowKnL3PraQXp2iHOOfh0MT
   OIEtVgcOfiXtu11NidyHTScdBk59W/lBCzpv8AZQiZMiqqEZGG0W0Dwr3
   Q==;
X-CSE-ConnectionGUID: vH2IGiJ3Q7SwjZhrd+r+dw==
X-CSE-MsgGUID: CfSatBvBSUe7Mz4SY+ksXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62238070"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="62238070"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 16:51:34 -0800
X-CSE-ConnectionGUID: DtBCmfvVR2aqtm8oTSpo4A==
X-CSE-MsgGUID: kM3MgI5GRMaZxdtsmgbJRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108917919"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 16:51:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 16:51:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 16:51:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 16:51:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1DwVqNkbi2C/a00REG5jzDNh+Muwk/IwYVQOhlcOrIRCj+zlaNHB1CtJZ9T7jpkEjPTH99l7+35UmGTP4Iv5ALCGEAX9i8aclZVKZKUb1z+Lu5UZGdGBy+MD+5IifLrHjM6JkzWzJ83KnMwlaB8329q1FXt43CENWk+aVvvEMZMMhetawzoIMYD86Ce/kUfWCi5pj0fAyYI4+3D/lKClDFhL65XaZ+k0SfdcbjHAbpR9e7B1sB7d8ftw8NsCBmAB9Z9xQoqgRms3PItm/dNpvYTpXA1gw19s73WiR8decZlTNoQLMsUIE4rSM3aD62pgDN08rK25zeIoG3HrObPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEoT6Ce6P9EDzWS8Keb+wjwdD3lBPKcPIROKWHJgmmA=;
 b=FwCNDZWNdYiH1X6DEeVNTM/x9MieLHGiw5+0JmaA3MOboh3A58TBdtsW//wgoXz1t7zw30yLdQaiOZCMkcRUgA9LlQbnxApth1D6Vyv1a2vPluDRsyiRWgCQF9VMTPIzAf73jr9tbtMcKyhkhhguRFZbwoo086vmywjjSBmiujiFFgAK1pka3ef58N+2xLrrWV3eWxlAK6fpWdRr138g5p0zpNar6BC86rtUc+vVHkGtQ6xxiBGDknZ2wD0WyOIrc5REOdyIl1RJXuqQsjheo+QIlafnSAiZ9z7k0ZWXmgvOwAvQETue/Lk4TpWPnnk0rYa+qgJdY3q/isW9ihcYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6689.namprd11.prod.outlook.com (2603:10b6:303:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Sat, 11 Jan
 2025 00:50:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Sat, 11 Jan 2025
 00:50:46 +0000
Message-ID: <55655440-71b4-49e0-9fc8-d8b1b4f77ab4@intel.com>
Date: Fri, 10 Jan 2025 16:50:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/13] ice: use rd32_poll_timeout_atomic in
 ice_read_phy_tstamp_ll_e810
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<anton.nadezhdin@intel.com>, <przemyslaw.kitszel@intel.com>,
	<milena.olech@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, Karol Kolacinski <karol.kolacinski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
 <20250108221753.2055987-9-anthony.l.nguyen@intel.com>
 <20250109182148.398f1cf1@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250109182148.398f1cf1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f59a23a-9f6a-4a67-efeb-08dd31d9fc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUJVYU9BcEVvM1BaK1czN2hVazVJQ2hmRlBLYVZqOHlpSjUxVmRWY2E3VHdR?=
 =?utf-8?B?MXBPc294Mk9FZzVPZUZvY245dGowd21mTmluRXE4UndqZTN0NUxiQ2laOEM1?=
 =?utf-8?B?RjljWExMRVpmVFdrK1YxRTIwUDNhVlg1MVpKQlg3RDQ1TC9wTmVxbnd4VmRi?=
 =?utf-8?B?SWlQa2U3Q1VZaVE5eE1rU21Vb01zK203eDlDM0t1TjR6K21TY0RSUE1McUZO?=
 =?utf-8?B?OXptKzVtZzRLNXVzWUFPanRleGlLQXJaNkJpT0kzbVZyeG1CQ1YwaTBqSm9U?=
 =?utf-8?B?clgrNGhwSkJEeE9yZkwwSG03dGRVRW5FdDF3ZjJ6aTNNZWlQd1JpdkZuMFlu?=
 =?utf-8?B?ZTZzN0Y0bzJLNkFsSHpsZDdEY3lqVm9ZakVkcXFYOWRPN0xVS05BZGFqcndM?=
 =?utf-8?B?STNrYzllRmV2Mzd2Um1PWkFDUlNsMXJZNE1uQVQrajhjcnFkQkhQTXh2YVJJ?=
 =?utf-8?B?QWg5OTlsbFlTbTJ1OWhVcEZtQVpkU0VxTW5hZ3ZrNnN2RDdpdERKWEgwRGVm?=
 =?utf-8?B?MjB2anRFRFZXUitNUXBwMGdyZHUzUXBKUkZXMGZxNlhuaS92Slc4TmI0MExj?=
 =?utf-8?B?dzFQTjdTem91RXAzYlFIb0t0MWFKTkszSFNpemhZMmRaOHdTVjVHalVkbVBs?=
 =?utf-8?B?MWhEeWRPd3pramY4RjJnb0pPVGpnaXFKSXgwcTFtQy9yRjh6VmIxYU12a091?=
 =?utf-8?B?T0twMW1zU1RoRzJ3enZtVy9rS09EMlhKVVUyN3RlL2RzQzFURTlnWWhxSWNJ?=
 =?utf-8?B?NmUxT3RveXRKTEdhWmF2RzNVclN5QVNWeGRmMW9PZU1OVFdlc25mbGZCWk15?=
 =?utf-8?B?NVJDcjRNRnpLMTg4S1ZTUmlhSFBHMHVZWUdvWUdXdnIvOXFSc2d6bE1UcWd4?=
 =?utf-8?B?cU1kMk83enZjWVE4dkluY21hejh0NjVsWU5PVWt6R0VYRHF4WVdFTGJRK04r?=
 =?utf-8?B?bDBoazFkQmxZNzRjdEZvN3dRVFM5ZDI1c2grN3NPUGRtaFdPbSs5MURyUGtv?=
 =?utf-8?B?SUVHUzJqZlY1QWM5dHhFQ3JKbDVBc2JGUmtGMitXL2wrcGRGMXNubG1OWHBN?=
 =?utf-8?B?c1I5SnZwMVYyejJocG5wSDh6WGlqM0szZ0pDcTNDYVpKWi9DeWd4R040WUxa?=
 =?utf-8?B?TUh0OHlmVzBhdFNZekZPbDh0MDBrT0h4QytuUys1Z2lKS0ZLY2xGRi9UNnp3?=
 =?utf-8?B?VDBrN2gyRTlJYS9NRkNscXhuMEJFUmFYcFdWc3BGOGRhWWpVVmg5MTArdlVm?=
 =?utf-8?B?RVdRUGMvbGVYNnp5SElLL1RwWk5aNm9rdVB3amlwUlBpYVJIZ3M4MThibXRO?=
 =?utf-8?B?QSs3YkFMWlVVZkxkYlo4Y3ZKVTBkM0NzaFNFUU1nTnFDYTd5V0w3Z1NUeGZa?=
 =?utf-8?B?YkhmaG1Nem9VOG5GMDdVd1lURkFyMk1rcjZ0TERsRGRHaHlPWk5YZ1FDc0lG?=
 =?utf-8?B?ditNWjZlZy96SVZzemU2MWRuRGxiUU1nQTRRNFA2bjMwVStPNkFKMFA2RG9H?=
 =?utf-8?B?Y1BQNUx5YW43aWpXNVJ0Q001NXQzazM5aTAwVStuNTViUCtsK1lSRDcycXJH?=
 =?utf-8?B?dDh2cHlJczFZbE5EeXl3dERJK2lSVmtCamo3cWFMUUpzQXhXMzN5bEZZZ2lj?=
 =?utf-8?B?QVZpMDI0aVh3aHcwWk9VeGtqWmdEZmxBKzRRWU1Rc0JwQXp2Y0JnR1J5M3JP?=
 =?utf-8?B?dm9ocHc3RXg4dTJDRlNIeVA3ZEZsekVZZ215UUJ4ZVlpYVVhMEJiWFJTL0lR?=
 =?utf-8?B?NXY2cVZsSjdUWnFTd09QNERiLzQ5ZHNiWjJpQk5rK05lZEJ4SFllTTRSNlhx?=
 =?utf-8?B?bWV6cCtTbCsycGlVYnpDWEtiMVZwRmZVVU9Yb0tlVGRTYjhCdGNOeUxaenQ2?=
 =?utf-8?Q?oSKHsGNKZWteo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJmb1EvbG00MjFxa28vZzl3N0VUOEhMckVZV3RTMVF2SHF6VExDaVd4cVVP?=
 =?utf-8?B?ZlFBRm9kbmp4MUVYOEFlQU12ZmozeXlTYk94dkJrZ0FMU0lxS202V0F1KzNX?=
 =?utf-8?B?MEJ5ZkxSZUgxbXpvRDVSM0U2azBGYXZZYWw3L1hyYlE1SkJINTZvREVIVW1Y?=
 =?utf-8?B?WGlZSnVoOFZGSnJ2ejRxSjFKL05NZE9CVldKeHE4K2tLblNlOEVOUUNBUmhM?=
 =?utf-8?B?Qyt0N2kxT2lnY0xGNE9kMWtiL0UrT3k4SVYxcGN0ZlJaTE1TYnRKNFl1dERE?=
 =?utf-8?B?K1RoSDZESmtVQWdkeTB3SzNERjJNR095dmF6OVhTVUw1MGZ0V1ZRVWpzVDhr?=
 =?utf-8?B?cWIyYVZpNXF1VkFnbWU4cHFIN1pJa3k5QjFhRXpqNXcxUkZob2plWXNucXVl?=
 =?utf-8?B?UDlkQXE0Qk5kb1N5aEFQK1NVejlOMklZUk5vQ2RqaExRTGN5NzMvaEh5Q3ll?=
 =?utf-8?B?aEsxNzB1NnpDRVlSVDJDaU1MZFRwMElzUTlwNFQzVklacnFNVkpTeXBmUXlC?=
 =?utf-8?B?U09OT3pnWkQ4Wmd4VXdKcU9xQnptWWRhcVUxRC9ZVC9sWlNSUldhb2tUVmky?=
 =?utf-8?B?RU1XQ1RFWFQvV3U5WEV2TjNvOVFoQllLYWlCREdtNDh4VEZxcEU5YTBHbUlI?=
 =?utf-8?B?SkZJcGZZOVB1Y0dIVndIcDlzZTltOW1odFNyQnZyb2t2Zzl2UVpvMy9DbzB4?=
 =?utf-8?B?Z3FqbUJObVBOSlB2bHdqRE5TMUxkdXVCZ0E1QVVjWGMrT0JhS0lhdWgzYmgy?=
 =?utf-8?B?cFV1cm5HMXRkeWxEaGVCNm10SnNxYm5QaGNaTE9QQXRCSWpWSEljOEtvbThw?=
 =?utf-8?B?Zk5wUWlKdXljUXBZMTBFTDVSbG9jeXVHN3dHNTIwUlVsT3R5dHBOZ1BIekRx?=
 =?utf-8?B?NVJ4eVFGcE5hWDU0YXdQNlFOMlhKNGt1UTZTQm9DRDg4TUtpWlNtSUN6TnJK?=
 =?utf-8?B?UWVPdVdBMGtZRlR3K3YrWU5LVnd2MDJ3TUZGTklHWWZFelpIUlBPV0F1ZEZv?=
 =?utf-8?B?citPUXFPT2x4ZnZRd25DTVo5cEJzb0l4eWswWTYxem9UVXJ4djBBNGhMR0hs?=
 =?utf-8?B?L1A3SXBqOFJkc2RPRnQybUNnWWYrckVMTnJMczJJYVhpQWxyVnoraDhpSTJo?=
 =?utf-8?B?RHlQaDM3S3o0aGx1dTR6Q040RWxITjNSYTJ4eWxJcXlIRzU1M214ajVpWFhR?=
 =?utf-8?B?ZHEzeVQxUkhRY0lzR1BNV1F6cnpQMnJKVWZ5ZkFzQzlub3VmN1AwNm1zbDN0?=
 =?utf-8?B?Sm15TGFITGhjTktXcmQ4Z0EvNXVvMUpCaHVpN1M0UW5wcWh2elZvb1lqMGkz?=
 =?utf-8?B?VnBKSWsxQ2hqZ0NHZXQ5a0c1dklua2tyaDJvK1FIUGJ4MU8xYUt1dUhjRWQ2?=
 =?utf-8?B?UFBKcit2U3FIN1J2N3gzMjJpQ3FjeEUzMDFITnhMMHIrKzJiMmpxQ0d4YjJ4?=
 =?utf-8?B?S1E4YURRUmxYWTQvcjFHejl5eEdkdEo5NWRveENNTHhrdGY4a2J5WENDemIz?=
 =?utf-8?B?cGI0S2ZvVGViYTJUZ3NNeHZxSWpDblJuK0Exa3MyMUJEdnVCRm43eUFXQ3Jy?=
 =?utf-8?B?VmRPSW0xMUhXN3Y5YVV6U2pPTzJnZU0vZmlLRHBMVzJsUXpyVjFmV1F6OXcy?=
 =?utf-8?B?YklLaXlQRTNvWmE2L3VHSUZwS21naUdzNnZPUVl6OEFaclg1bmxsWkIvUlNs?=
 =?utf-8?B?QXRIME5IaW5YVEJGZ043QlpsNCtKRUJGeVc1MDEzU0FXRWo5b2NXeWlLN3pu?=
 =?utf-8?B?M2dseTloUjFzWXNoOHpRS1Rhd0ZkZkVseDVHYkNpL00xR0t6cWk0aG5BN2Z3?=
 =?utf-8?B?MHlDdmg1RjRsMHJFd0NCQjAvTHUyMWJvb3hhQ2pVRWpNQXJGbGJvWFNzMmRH?=
 =?utf-8?B?S2gzNllEWldFLzA0cy9HN2xDRnlPVTE2TUFRamNBSUJCSFdIeldyWUlVNEhm?=
 =?utf-8?B?ay9FRHU3YzRaTzJFNzNWVlVCWFpBUHlORGQ0aHIzRmdVekNNQVFLM1JGM3lO?=
 =?utf-8?B?N2hRcjlyeTUwMU9TYTl5T1N0Uk5QSjBQUWNrVjhuR21FaXBjY0FuN1ljbDFI?=
 =?utf-8?B?Ty9vQnoyakY0N2hkZmJ5SlNJekl3Vkt6Ny8veXFXU3QrQWEzTVNpZWxYQktp?=
 =?utf-8?B?clZDWlBjL1BOSFBjQ2ZGMW9rZnczN1NSeDd2amN3UkV1a2ZkNXFrZDBuWkY2?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f59a23a-9f6a-4a67-efeb-08dd31d9fc0b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 00:50:46.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zwVrigPPKo/jnN+8ZF58aRdMO+27LivWx9Z4Ir2GmZuocPn7qbx/r9zjmDRp4J+RKvYI6Hc76t9vaDTYmLQkNU05UIHzq3Kc03UdbCJ3jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6689
X-OriginatorOrg: intel.com



On 1/9/2025 6:21 PM, Jakub Kicinski wrote:
> On Wed,  8 Jan 2025 14:17:45 -0800 Tony Nguyen wrote:
>> --- a/drivers/net/ethernet/intel/ice/ice_osdep.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
>> @@ -26,6 +26,9 @@
>>  
>>  #define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
>>  	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
>> +#define rd32_poll_timeout_atomic(a, addr, val, cond, delay_us, timeout_us) \
>> +	read_poll_timeout_atomic(rd32, val, cond, delay_us, timeout_us, false, \
>> +				 a, addr)
> 
> Could you deprecate the use of the osdep header? At the very least don't
> add new stuff here. Back in the day "no OS abstraction layers" was 
> a pretty hard and fast rule. I don't hear it as much these days, but 
> I think it's still valid since this just obfuscates the code for all
> readers outside your team.

I assume you are referring to the abstractions in general (rd32,
rd32_poll_timeout, etc) and not simply the name of the header (osdep.h)?

I do agree that the layering with the intent to create an OS abstraction
is not preferred and that its been pushed back against for years. We
have been working to move away from OS abstractions, including several
refactors to the ice driver. Use of "rd32_poll_timeout" is in fact one
of these refactors: there's no reason to re-implement read polling when
its provided by the kernel.

However, I also think there is some value in shorthands for commonly
used idioms like "readl(hw->hw_addr + reg_offset)" which make the intent
more legible at least to me.

These rd32_* implementations are built in line with the readl* variants
in <linux/iopoll.h>

I suppose it is more frustrating for someone on the opposite side who
must content with each drivers variation of a register access macro. We
could rip the rd32-etc out entirely and replace them with readl and
friends directly... But that again feels like a lot of churn.

My goal with these macros was to make it easier for ice developers to
use the read_poll_timeout bits within the existing framework, with an
attempt to minimize the thrash to existing code.

Glancing through driver/net/ethernet, it appears many drivers to use a
straight readl, while others use a rapper like sbus_readl, gem_readl,
Intel's rd32, etc.

