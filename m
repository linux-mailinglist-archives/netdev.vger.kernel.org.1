Return-Path: <netdev+bounces-100194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5D8D81CD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D87B1F2219B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138CE83A06;
	Mon,  3 Jun 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/b1iCU2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60010949;
	Mon,  3 Jun 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416074; cv=fail; b=j2cmbybzq3/Kgz4r6PxR1bW6qrKtfFDarCV1sU2H1O7UgWWIlzjcQYtZpb27NZnwfpmB2ZOkShQsRJbkaWRU6KSUDbbWirtwwNUNDntWMkNeXm2jLhVKlFMeUpKfhyqMiVR+7Ut6fEM2os2WHaC6Dek0yHpnVBjx5oqCFPjoft8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416074; c=relaxed/simple;
	bh=o7au7KmgNV0bK+kppLZDCKUW3M3qCjE7jgx02umizNk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2J/Cm/Js3Y0YYRw1BYsJwhymUMUezTRgJPGWZ+A0s5Z4I9cpSVp3wa8WI/CUF6PoJdjW+o/vev/ZWshTDDV2I2Cl5Sq1XB69oASzm7KJQ1Wqa809FCrDvL0ACMTQ5G0M2rr+SCPFGnf/PHJe4Vbxwcht8rc8kkEOFwwAouvaJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/b1iCU2; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717416072; x=1748952072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o7au7KmgNV0bK+kppLZDCKUW3M3qCjE7jgx02umizNk=;
  b=Q/b1iCU2vxXOFj9l1IHJuJLIgioGmojVJ5Vpa2pklnLAbVK08oMXGlG+
   /uRyRpT7k3duqCgbhnQJbi3hQpry7pst62qUxt2rIx0xD+u7MPgDrgBEh
   g2kKM0WyrEMqb7tCPYq9TWwdGiC52AFmoZ27+wstdRz2tIItMskHL0MWa
   2yJPH0yTUrTaFw23gd3ArMkT2rsJjrTvgBhoOJsAg5xKl2q7SpIauiZnV
   D6mF/depFD7a8q8LLKHq4VSsPDbbx4xVNZxIS2SobNZS5FrHfWdTnB6l0
   ZsR0OFQYO3FZuonmSm/HeoWtDaVoF5KkxnK+lffkZUNAiS71r7JJ+GVe2
   Q==;
X-CSE-ConnectionGUID: wvIXSQuATH6Gtfbs+Dp3nw==
X-CSE-MsgGUID: bBPgmFpzQ4OeaTON8CX4eA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="24556198"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="24556198"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 05:00:56 -0700
X-CSE-ConnectionGUID: pyS1Db86SGabHhpWVwKP9g==
X-CSE-MsgGUID: mPS8CLzaQ3ym2era0pzhkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="41397759"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 05:00:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 05:00:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 05:00:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 05:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOxFHI5zW46epGa4dytdCIL8bclgq2xfxUHBI7SiRoAWDrStBP957r9umCYvE2DRuC2MQBKzi6SQX7pItBxdry0BljfeNXbd5zfXwSOaBU9NLTHUDaiIpeMOvyE3GsoveFhangGdhl8f95Gyvyi7w/NFsLmEqVj7XoisRVD1eEAt7I7WUSI46IJEsaaJ5BWtworobVAtA1U8BOrZJEst4JtoXpCsDHcWCO79TMwa9iSYgUmVqmTUbVRNcDerQd/63W/lQP/lCuLYGteG36D1X+m77Km6cm+cECskNLTZOtziutK0RW25pmzVuRLH4TDV734IPbTF0p+3UZh07BkXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOrgaSKfJpnaKOMnOD33als1IyBjb5ujThSAw7orUcQ=;
 b=gMBOSGiOPNYrlKZq+lHQs77DQj8TOTOt3Gd+g4iJXRF5lLFTOnEkHPTIizHK3B8ZOHBN0Xq/1ENymEsuMZFddTAe+11a0l1nlTCWU+pOUEO/57cINtbImMk/fyo5676bZIcKZRy7yWDS8SbN4FvKXVWv5K6LzL5yxvL5bHLy+C4OqQV+V+pDi//YnGUs1fvJtJDShgltKHOFZg0bXX0L/c7hWD+vppDqdb20DoL9DBUX/D4jcUwgD3it0my6cBoIv4GEX9mMr2Irn5vz4lPYp2SV46nznEKcVjFj0SuKckpAJXqahgUt9fvpvIIqWIceVOjLB48F3479jEF1E0/0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 12:00:53 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 12:00:52 +0000
Message-ID: <ac0226c9-c3a4-4cc5-9323-850f79b7718a@intel.com>
Date: Mon, 3 Jun 2024 14:00:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3] octeontx2-af: Add debugfs support to dump NIX
 TM topology
To: Anshumali Gaur <agaur@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240603112249.6403-1-agaur@marvell.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240603112249.6403-1-agaur@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0274.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::41) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MN2PR11MB4677:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f57bf16-5669-4b11-90ef-08dc83c4d125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFROZlJQOWJreWcvME9HN01IRy9xSlc5NGx5M3VtT0JoRURZZ3JXT2c2SVBu?=
 =?utf-8?B?QWpuSC95dFVHRVNUSFpjUDJuMkpOMlRtcU12Q1hJMFhDbU5Od1YyaDlBeGxs?=
 =?utf-8?B?N0toeVNoaEdUdDRTTlIwTkFPc0RtcHZ0MWRRRzkyamZVM1k4QkthTWRtTGcx?=
 =?utf-8?B?aGpkY3ExOFlpazRYSVV4bFpoRDhpdDMxcWhxQXYwMXB2RXY3L3AvQTVRdm1V?=
 =?utf-8?B?SkEvNjdLT1hVSVIxMHg1cGRqQ0djdi9vK3pNYXg1eGlyTGZ0UHVXVzkvamEx?=
 =?utf-8?B?VFNJdUJ6dkpzSTFiNXhjb2VWWFJvdnlTS3JlbE5UeFZuSUgxNE45Z3Z0bFFn?=
 =?utf-8?B?c2pEUU9lMlc2YXR5Y1JvVzUwS0dxS3d3SG15SWM2S0pzb0NOOTBya000a2xt?=
 =?utf-8?B?eVF4c0JGZi9NdSsremNJczBLeDhYQkg1STNnL0lIbzRrNmJrMlZKQTR2T3Vm?=
 =?utf-8?B?c1lzQmU2VnVvY0JnVkhpSUpaVVNqZStFWDlWNU9obTJCNGUxK21yV2dyMFJD?=
 =?utf-8?B?NkxRY3FPbkM5eFVTT2syeDVMYmY4MFc0dkx5d3d1akpCZkpXSjd6YzdTQXR4?=
 =?utf-8?B?NGx2dU13QW1zYTZEYzZZc0FuSUZycENxUlducks0U2k1NmdSWXQvVU5JczJY?=
 =?utf-8?B?ZERWWmlpOVFXQnFFdlRIbjhrbko0U3U1NzlEU09pSWNOSG9HTjdWUGk4VlJG?=
 =?utf-8?B?TkhmenRtOUVEZ3R3cExCSVAyYVZkc0ttb2xGU0FteVFNWFBnOG5xYXgvZWFh?=
 =?utf-8?B?dVFGcGs2OUIxNmdTLzJPdEFnUHJDdUJHYjVLcEQ2MysrcDcrT2JLVm1qYjNS?=
 =?utf-8?B?aDNWYWFHUytUTUlLYSt6VTdVY01kUjQxZit1N1BpK0dXTWxyUS9qZUFEc0tW?=
 =?utf-8?B?Y0RKYk96RGtTV0N6VVpSZHFxVE9kU0xjSTlyNGJ6ZHJmMlJXTmJYSVM2QjBD?=
 =?utf-8?B?Zk5JM1FKdDAyRXpsUWhBQitEakN3bkI4RUVXMTQwN0phUjlPQTZkcVRWQU5W?=
 =?utf-8?B?SEs2c1UwS0gxWkFxbmtUTmdQUkFaeFhReWEvTmtiQ1lJZXlKWDh4ZWFLU1Jh?=
 =?utf-8?B?NFQ5UDFZK3dZWnVEdFFyWUR6RlNDOEJnaGszOWhIblZScTRFanpRay9OS1Nt?=
 =?utf-8?B?K0I5ZC92cENwMkJKN3FybkNuWERkb2VzL0VFSTZtb3greVpaSW9RT3IvSmRP?=
 =?utf-8?B?M1g0RjY3dTFTZTBLZ2g1YTlmM203ekhpQmlWdk0xdnRWbndNN1k0RCtTOHB4?=
 =?utf-8?B?RURpWDQ5Rnp4a1BiNjB1WmFQS0ZUQU0xRitPN05oZm5iQ0F6OWZUL2d6UStt?=
 =?utf-8?B?dURJd3FWc1U1YlM2NjNPQUJLKzU2dUdVMVo5ZHM5ZjZzSzBQMksrQldIUnBa?=
 =?utf-8?B?bzlGY2FBV3dkMlBmTjAzUElXNUJzZE80OEU4ZEZoQTZ0RWdxVFBkYmM5cmhX?=
 =?utf-8?B?K0xKL3pEWFVkR29XblRWNnc1alJKUzk3UjdJc1ZvLzRKeEtjbzcvbUtocVcy?=
 =?utf-8?B?TEMzRW9NTXBGMFFwTkFhS2pOUmk0NnJZaWtqbFI5SWNWeWVra0Q4K2U5eWlR?=
 =?utf-8?B?QW1mRkxrUVFYaTR2N0xYbHlVWDVxbnE5N1ZJTUdpaThsUW94ZndJNVJjbkZK?=
 =?utf-8?B?S2c5UXgyanJ2cVdQZkp1dW1KODFGa3l6dzZCWFU2bjRFTWw1RUN1czZ1MEsz?=
 =?utf-8?B?Sm9NQkdaeHdHcGJkNlQvcjZic0g1MEo3LzExMnlwYXZIOTFkMEhoUHlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGR0dVZieXJtcFNsaHl1Q2RzZS80QmN0SGtMWWNLMmd1UEVWemtTR09BcGto?=
 =?utf-8?B?eSs4Mk5jREgvYUFXWHNEbWY5ZTlPekgwT3ZxUW4xMklTamZiUU9kYUtGdTNP?=
 =?utf-8?B?dG0zVStUWjhabUpYY0dZVlZvcWx0SEZva0pIN2JUSkJDd0VIT0hqVXVYajNx?=
 =?utf-8?B?NDN1Uk45TEVWdWxTMUU2Q0g1SGIzQ0gwT3Jld3p2WkpPaWp1anMrT2ZYUk9w?=
 =?utf-8?B?WUlack8waXpBOWFLZ0RBWThuQ0pyWFlRdWo2cTJaMlNPSWl3WEFMajRxdXBx?=
 =?utf-8?B?bXlqR1dGWXhkTWk0bU1ocGVCcHZuUVpwU0JjaGh5dTNOK2w4WlJBOU9JbnJn?=
 =?utf-8?B?STZmZHNWdlVlNFNLL3RQRVphdDJQdHc4N2ErS0RadHQxcjMvUC9VTEpQWHJR?=
 =?utf-8?B?d1J5RGlGeHQ5MW9QTENJWThIRklCaGVrSWRBY2h6MEp5KzUwaVFJN3VVS3NN?=
 =?utf-8?B?WWZKQ0RZY291RGkxOHZGVmNvcXE4WmYvaXMyU2R5YTUxNTQrUEJMNkp3RUVX?=
 =?utf-8?B?T0xCTkE2UlljTFNkbWRheGs2Qjh5eVVHTGNaMXlQem5rbFhkZTIzZXVpTW5M?=
 =?utf-8?B?U3VPbHlJaEpIYmJBUXJuQlJyTlo2bmdUUDFLMnVORHVsMmpYdmVEbEZkUEVY?=
 =?utf-8?B?R2hjUDlqOVd4a2l5dFN0NldRUzBWSlorY3JXa1lWUWd0QWhnZmJ0THdLY29q?=
 =?utf-8?B?S2RrVUE5YTYvRmc2S3JOazZYOG9VUWdlQXJqS2lEeVAwU3d0U3FPaml1L1NY?=
 =?utf-8?B?UnVYTmllbXZ4bVB5Q3VZVnM2aFFFejdOQmdXZ1FJaGhBK0lrcElUVmxTSzN5?=
 =?utf-8?B?Q1F2dTNieGpFWDduT2k0NzRXSTE0YXJFdXBEeXVCRGduVHd6YUkrRjRLS2xa?=
 =?utf-8?B?dkNDMjg5dmNHa3E5RGhzbE9URWY4Ykt6Z09jdnArbHlSdEhSY2ZHNkVKcnNW?=
 =?utf-8?B?UlZidFlLS0hVZ3JEL2NWcDU1SVZjcFRWNGx6SElLMnZuSmg5a1JQRXAvMnRm?=
 =?utf-8?B?TFZESEZkSThsSkc3MGRVWWZsMkZhRWIrNGMyNk5zQjhyUEFwZi9pSTRlRFNi?=
 =?utf-8?B?cVcvMzJyWlV5L3dOSUlhNDN0bndRMGgyZm9ZeXRPb3g2SVUzT2JmOEwyeUZy?=
 =?utf-8?B?bGRVSEp6R1dqMDlWTW9NSkowL1dQZHdubGNBNlpLODdOSmxsUkxQSnN3elBL?=
 =?utf-8?B?dWRVN0lxQlovWWZSMlRSZzNxczExN3AzWTJPeHV2MFNRNGFoMlVwWW8vZG56?=
 =?utf-8?B?UVFIOXp4bGwyRk83YUE4WEJFZkVabDdBODZFK1NITWxPa0Qya1Y4eFVibkpK?=
 =?utf-8?B?M2FsM2Iyamo5dXpha1pTMDAwQzJSQ0xkWGtySlNEODZwSHozY1cvQmpzdkxR?=
 =?utf-8?B?N0tTeHdIdyt4cDVvaHk2QmNabzhnUWJxRXNtL2JSR0pqdnFRYUJ4TXd5a2pE?=
 =?utf-8?B?WUVjcUtJTmMxSVpZRDNUemM4M05RSWlTeEJ5VHZFRWJkbW1leGI2bXh6L0tE?=
 =?utf-8?B?U0hSQlluV0IzcEJ6MEprYWxsc2p3Q3V6YlVoZWpqTnB2N1BSekNjT2lYWWU5?=
 =?utf-8?B?b2ZMUVpOeHYrWVNnaWZ2RU9SUVMwM1FtVVg4V3Fiemt5bHdaU2VMQVpHaW45?=
 =?utf-8?B?MitITFVBNjd6QnRFdTF5UDR4RDRJdmkzYjVKbnlPZzhaa1VYNmRHeTlUYWdQ?=
 =?utf-8?B?azRpYUNwb3ZSa0xNK1h6bzV5WnJwZGRuaVQrUGVTeGFCaGdkWXNUQXY0WTNQ?=
 =?utf-8?B?ZHlVYzYxRzdtM04xMjFDTXNQaUJIUmo4UDNtZGJkeWI2a0FiTmFibzZ3ZWFD?=
 =?utf-8?B?bmFEUFBqcDlpa3p4cDBsa0lRQyt2eG8xSTJuWVJvWlZvRFo3U3ZjbHdiNHVz?=
 =?utf-8?B?MjRTb3ZjajEzMXR3dmx0U1pWUkl2ZGtldThDS3FyVEpMa2x4SVFNMHgvNGhq?=
 =?utf-8?B?SW9wTjZzM3YrREt2QUM1T20zTjVlZHRxN0pwU3F3TnhRZFliaHFVNjBjUGti?=
 =?utf-8?B?TUhNRngxY2JBc3A5aW1VWG5BNzRtVmtlUXZIay9oVHhSMnF1NktMcEdIcVZI?=
 =?utf-8?B?YkRXTTdMSHdJT3VJdjNPYloydUNaS2I4SVZ3Zy8vUnROVnQ0M0pNODBFR2xW?=
 =?utf-8?B?MGlRRFlCbnU4T1doVXFEblB4SjRrV2pPdlk3VEhuaWtjdHJWNTJvVzZreFpS?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f57bf16-5669-4b11-90ef-08dc83c4d125
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 12:00:52.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YL6owSLZ469TM14RXd+2nPqXZbBz/TJ3U6ivRbNJWN+gt3PdM3lGZNjT4lxVXuKc0rj+MBCqwOxg+pLb6z8tSOmQW0kQ7ni4nQdHxW79Y1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-OriginatorOrg: intel.com



On 03.06.2024 13:22, Anshumali Gaur wrote:
> This patch adds support to dump NIX transmit queue topology.
> There are multiple levels of scheduling/shaping supported by
> NIX and a packet traverses through multiple levels before sending
> the packet out. At each level, there are set of scheduling/shaping
> rules applied to a packet flow.
> 
> Each packet traverses through multiple levels
> SQ->SMQ->TL4->TL3->TL2->TL1 and these levels are mapped in a parent-child
> relationship.
> 
> This patch dumps the debug information related to all TM Levels in
> the following way.
> 
> Example:
> $ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_tree
> $ cat /sys/kernel/debug/octeontx2/nix/tm_tree
> 
> A more desriptive set of registers at each level can be dumped
> in the following way.
> 
> Example:
> $ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_topo
> $ cat /sys/kernel/debug/octeontx2/nix/tm_topo
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> ---

Thx,
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> v3:
>     - Addressed review comments given by Wojciech Drewek
> 	1. Removed unnecessary goto statement
> 	2. Moved valid SQ check before AF mbox
> v2:
>     - Addressed review comments given by Simon Horman
> 	1. Resolved indentation issues
> 
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 365 ++++++++++++++++++
>  .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   7 +
>  3 files changed, 373 insertions(+)
> 

<...>

