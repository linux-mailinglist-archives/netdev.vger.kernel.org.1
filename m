Return-Path: <netdev+bounces-245327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D019ACCB7DD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46E4E3035E77
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB8322DC0;
	Thu, 18 Dec 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijZ3k7Ay"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF52652B7
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055099; cv=fail; b=gS0+LOsPtM+HpKo1r/bkM0foWBbi0DK5z1MK/CAqN7T5M2gRhdEEX2BAXES/nfEfg3DTsXALqc6NEomiCTJ5OQiNWVtgAjBI+duv6gkI+3QOjtXlnYYjbLaXQv4hd3U1/bIdG2C/NGc98mabaGXDIAnTPGjcbpFrLTxqofP4bo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055099; c=relaxed/simple;
	bh=UCFa8nD8rYlfuvrhxc1bxMeDhTglqHE4TK3AhMvSemg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIHeq0K953kLaWHVxUBqmv8F+sDJOh92lA2DNrD4d/laoS9SwP9X0pwktkFj6ZUTD2dqNAKgH8drT3trRKEcI89Gj8OypFXYaGIgg8TswEceX0lze3Uo64UDe/SIw/78LeqWLRD2R/Tm2cpD7wqc1EmUriQc/3b+3X2H6SnO8QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijZ3k7Ay; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766055097; x=1797591097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UCFa8nD8rYlfuvrhxc1bxMeDhTglqHE4TK3AhMvSemg=;
  b=ijZ3k7Aytd+0sDu8aoYKN9MCCFfbBgdXVJWww5QZO+lZREVNw3itv/v5
   uy++l+jBs6g+xmuGxDnxuShw6wUoUzyVtEvzNyy0jn6f4+gfjq4QXGJ3o
   vK9/wy0dS0nI6rgDXFhOqBoZfATStoZ+/u6eEzqQ9cgKutfKSllc3MIe2
   Euv4aIi0Nq9lQm3cC8on9rOk+iTyoxr4I2L+WOD08GVZfcKM/lS0XV427
   +HB4KMnS+ta+Iqg2WE4tYDTdq5Mylc2fb2NJ+WzmIEu97fLNObkoWPUiu
   tZRVHuj3r6WoJQkBky/VUfVdGnXd/4OiS+MHu53RgOUjzs7UAx+tQaXnJ
   Q==;
X-CSE-ConnectionGUID: IMS9eF3UStuYukW9epBX5w==
X-CSE-MsgGUID: 1ou0vv8OQoOqj9GjkzStpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="85591323"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="85591323"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 02:51:37 -0800
X-CSE-ConnectionGUID: bx6EgifPSXapUMGxp99voA==
X-CSE-MsgGUID: GwJTwntcS7SrNMeiHSTZlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="221961479"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 02:51:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 02:51:36 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 02:51:36 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 02:51:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdbxi6hfhJQ/81oBwyQSUqmbz9KMAZChD+Wg5X8GOGFm7pSKifE9iQQX37bKXWIzXOLDkrD0la/yDHtFw4D3Zk0ZDs6ZNfhDlNi+rn9OZ1tq3r2PnMBnfadVL0IIxw8EMDfb6MT+xF8TWI1qj+cq1P7FHrXuBOj+OB/u9h09xDxgx8q0SlQu3fQs1AOfuoxJz43yLTASseAHyB1lZhne70ZvEqCAJYa0B5GL3nNx0h9soyTg137bLuejw9qXiuhjsIKuDsx4slbtpl3zDoaFVZFjX5iHi6lwYTr2q0AdPWFl88c+dU2fHq1H+OGTfQ11CvmopsNeZHdJ6bnQrxGQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCFa8nD8rYlfuvrhxc1bxMeDhTglqHE4TK3AhMvSemg=;
 b=Ojk+aW0Hr7ZLFvmHPdD0BoVo21xW7s/xtJGtyrQUAoVaK2/Ff6ecGb29twcpt6clKkwFc478T1J7WP2jyON2kVo9RShvGjqNYw1vKbFUP34+OP5Ub2qQzL7P8U4tw/EeVS3bKpSBLfXXgynjGw91I8HYgwkTjrqiTV2uHfPJVxLvzIrILci5+SVJuoL0PeRsJ1sCv+E8SoINFp3TGFCxXkGXw2OjMwWSvAR01qzjdTxQZ/xKqbhmsq4XY264VByC+sciPe4/CjW9nOTGl0ALk5PTckSZfqWdGdHd3xcfB+7gphAE6J3cH0tkdUpFSJXRVgN6u2+iJml5GFGLzqL7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA1PR11MB6196.namprd11.prod.outlook.com (2603:10b6:208:3e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 10:51:34 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:51:34 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Simon Horman <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 6/6] ice: convert all ring
 stats to u64_stats_t
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 6/6] ice: convert all ring
 stats to u64_stats_t
Thread-Index: AQHcWltPk6ZS4KolfE2IKiPNzfUc/7UnLJbw
Date: Thu, 18 Dec 2025 10:51:34 +0000
Message-ID: <IA1PR11MB624158AA7D14FBC4CFB2AC5A8BA8A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-6-6e8b0cea75cc@intel.com>
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-6-6e8b0cea75cc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA1PR11MB6196:EE_
x-ms-office365-filtering-correlation-id: e952a96a-18b8-4b75-aa43-08de3e236938
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aDZxZVpoWUhUSFQ2U2t3TC8yMEJ4TDMzdmNFb3lrUHJTOHJ2MC92Z285WWJl?=
 =?utf-8?B?bnNxYmp4UHJUZjl6aWNjdlMxMHZOTHhMZDVoUm9lMGI0QWZydzBQMWEwOSto?=
 =?utf-8?B?ZUh1V1M1a0NRY2FYRExjUE9vT1pXc3J1RWljTkZqTFVWaGV1TEswaUFOeERG?=
 =?utf-8?B?S0xmSDUwKzdsRXd3bHhFUG8vdktveVBGOTN6U2lPUHBkUkQ4OGh3SWZwemh0?=
 =?utf-8?B?REY3a3FpOUJaVy9GTy85NFJrU0F3KzNIMFhXU3ZRY0RNTStINGltUDBFTTFP?=
 =?utf-8?B?bWNiOFFXR05XcytxRnZzTGtCQ1FDK0tEUXYxR09TM3ZyTUNyTDJVOSsxdHRv?=
 =?utf-8?B?YWRhZTNHUEQ4T25Ccm1aVzEzQTh3UXRmckZWL2pHVjBQc01KOHZ2S0t2am5D?=
 =?utf-8?B?Z0lYWVZMbmJNbU9IQytTSmNubGdrVmxkdU9ORWZqRHorcEVkL25yTjl0SVhQ?=
 =?utf-8?B?UFE1aC8yNEtTbS8yWDliR2I3SGpzOUh1SkxJcENKejgwbE43ZUlEUk1LM2o0?=
 =?utf-8?B?Q0NDQW1VcURlNzYybTltVU10YVJvcElSWVBVWEhEaTFGTjFOOFNKbk9WRjFM?=
 =?utf-8?B?RU5xc21HUk9wWmxXV1lNVTVLMHJoL0VKZzVrZ0l2c1h2OElXa2VVSGtCL1FF?=
 =?utf-8?B?dkgveUxqdnhzd2VyZnUwRlc3V0xPWTVUS05TQ0ZNcEVRSFVwekRMZFkrTlhM?=
 =?utf-8?B?djIxNDlXMFpDOVRxUmFDbHZHZzV5T0g4aHRHYUJGRHh5bjMwWWVHV1VnYzhu?=
 =?utf-8?B?UXA1NFp2VWNMN1dHSXhPd2E3Q0tGWnQyZDdpOFhqSExJaFRIUTh0YkxyWkJ0?=
 =?utf-8?B?dXZYZ0sveEdVTklyNFc1eC90a0hFMk9HWUQ4elFWc0IxbWFIbVFHOWVpSVR1?=
 =?utf-8?B?aDhXaWZ5ZTcwYy9yTHZlMnM0S3cxTkkzQmJJQVdEUUg0b2Rob2R2T2hTa0JT?=
 =?utf-8?B?UlZTZ3ZEdGtoV3o3clFKVEdsMkNNTXhBck02bStFRnlRTWJ2Vk5pTUkvb3dp?=
 =?utf-8?B?SWM1ZHNUbVNqVUcyVk4yV3FRQ0FNOTMwQThHNzRiVk5ReDZNalEwV0szZmtP?=
 =?utf-8?B?YXprVTlNcVpRcWhmYzVBLzFCbTBTVlJvZi8wWllYdUZCQUloTXhsNTk3WVpB?=
 =?utf-8?B?RDJZbXNvdncxTU1oYmJqUkRzNHhhYzdSOTVHd25yNGFETy9rVDRXeVZSOGtD?=
 =?utf-8?B?YUpPWEx4V2w5Mkw3Mit1QkMvTjVlR2liZVU1am1GNUJSNXFwOVZsamtOaGJp?=
 =?utf-8?B?RTdlTzFteVFUdWRUb09mLzhPcURHUDFaQkZoa01YcTRtVEdtZGhndVN1dkdP?=
 =?utf-8?B?dEpTRUZkeTBGd2s4UGI5eHFJZkM0Qkwwem13YUppS2ZIYWxIaWJFSkNGYjd2?=
 =?utf-8?B?RnBoblhiWEV5eUd0Y0paQ2JGR1p3akZQSklGRi9NYjlIUThpVzNOai8vMTIz?=
 =?utf-8?B?aVMva0RSVEVaTEhLdmh5T1EwbmdMVWpuU0tWM3Y0dUNqMS8wcEFpYXQ1bUhP?=
 =?utf-8?B?Q3UvVFdoREFHQVlyaXcrTlBaNEpTN0pjTWZFWU54Z3Q3ZGplaUpYblFEUlNQ?=
 =?utf-8?B?S1oxT0ZibjlkQ2txK1dZbThhcy9ZZXBGT0dYak84aEVrS2p4SEpTQnhzLzkr?=
 =?utf-8?B?UkwyaTFZT0J6eUJ3cHVLVzNWQkl0RFBVREwzbUttc2h5TFdNNU44cldMQzd6?=
 =?utf-8?B?ZGY1RUdCaWFLTkoyQTBJV2IzRTJ5Q3NBajN4WUxhSUFsR2xkcmkva2dFS0pY?=
 =?utf-8?B?ekJrci80b1g5bkhSQzhIclV0THVOR3hyYy9CdEtJd29JZmFRTzMvOUZyaEdM?=
 =?utf-8?B?RlBwdC91aVdwWFptRlFOQ1dGT01OTHowU2dHaWM3Tk8rQnVoQkxMWVVIenc1?=
 =?utf-8?B?bTFUNGkxRWxxSTBzL0lpR3hINlVKSjhtVjJSR2pUdkIyRGt4RDVTdktHMGM5?=
 =?utf-8?B?aC9wNkp5UFlndm1ER3J3TEQ1T3ZkeEdrZXlzYm1BZUt0SmNUeE1VbU1UR0N5?=
 =?utf-8?B?eW1HN1FEQUNCUU4rMXMyeFlxV2dLNEFzeWtrMjJKTW5pTm5LK1FhTDR6U1dN?=
 =?utf-8?B?Zm9ZQm5jTFZuU0VTZFpFSDRrTXJWQS9BZ1FLZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnJGVHEzU3ZhTTlJQnhIMFhxeENkbUM3bmxlTGlKaHMvaHJpVkV6UjlCdmJN?=
 =?utf-8?B?d0ZzbG9xRWthV1N6K21YanEvUzY2T2kzVENvb3RnVnk3NW5RK0d3V2RRWUZt?=
 =?utf-8?B?aFFZeWtndjQ0blMxVGRHY2ZFNjRBcHF4ZjdWSzFuOWpqbytUVkZuanF3M3pr?=
 =?utf-8?B?bDVWSWJpclFEWFMwalpwKy9Td3hEcWdqMUFDbXVCR1NldnNiOFhoVWIwdmF3?=
 =?utf-8?B?QUMweW1DOUFoc2pxWWdYa1lVTit4QjNJcUhYd2xtOUd1SWF3SkxITjlWYWxq?=
 =?utf-8?B?bm1qRDdQaU03YUJ4ME5CVUxTMjJjSGtXUTlsZCtBSGh5eGlXbU1EeGdRWXJ3?=
 =?utf-8?B?TVYxclcwSlZJL1BtNFZGWW1VSWVXdGZUQ2J5UHROU252ZjFDd1NwUmdjVStV?=
 =?utf-8?B?aENsUWtzclpMUHdURi9Fdi90SEtBTFZmN0IvTnQ4UUNkb0xXSmpPa2xTaWtz?=
 =?utf-8?B?alZNV1plZm5vT1NGL3d4ajFsVTh2M2ZFQ3ZteVBLUWxvNXc1T3Y3YUJCczdR?=
 =?utf-8?B?OUVUWXdEYjBrUmx6bDllaTE3YWg2QlNwYW5LVzhhV2duS241UWllWFhxbGZR?=
 =?utf-8?B?NDlOSFNhMGw5VXJLU2xrc0VrNU9zZU1zckZ3ZUg3ZzBuWEVISnIzTzZFTjl4?=
 =?utf-8?B?TTZydUFCaEJMcjUvSDE3bFZSN1BPbHMvTVJLSDJNQmN0Ry9ESXBQT01SYm82?=
 =?utf-8?B?NWlPTWhFZ1VOUFNyb0wyTzJOeXVRN21rOWN1NldqSURPQXhXazdyNkIzZnBu?=
 =?utf-8?B?TVRlTForR1E3UnNuTlNsTUtXaEcrMmxNaThQNTJGZ2pra0czU2M5Tmg2VjFK?=
 =?utf-8?B?SVd2ME9qb25LOHBpbW9jek5KcGpRbmV1UmUzdTVQYkR1aFVNTHFTOTd1V3h2?=
 =?utf-8?B?SW5VZG1JZHBXSnRMbGUxaktmdjFqUVRNbmJOaWZNTndDYkZhQmljT09acTFB?=
 =?utf-8?B?cE04TXo0MjNEZm90T25ocmczUnhTM1dUUk5LNlZTY0pUaXVEVmNJSE1EQktl?=
 =?utf-8?B?SXlIWFFKcHBJYTZBSlNtc0NzSnBMeithemg1Rk1sWER1b2l6bUNrS05tZy9U?=
 =?utf-8?B?b3l4WkNaVnRRa3ZLN2xDeDB2dHNTcmhOWnR4T20wbzA0L3EwNkJCbW1VYUh2?=
 =?utf-8?B?QnBTQmFrUGZyMTVKK3hDV2wxYVk1bVBqQ3lHZDY4bmVES3VsWERtS094UFNK?=
 =?utf-8?B?RXpUSkNKeFZxaXhEVDF6ZVFlWkNaRDB1RGtNQXZLbGo0N1pWR2Y4VUVWaDc5?=
 =?utf-8?B?Ri9XeHlaRGFBUXhCWm00OXRiYXN0Yi9RZ3NGRGE2TGNPMGRVVXkvRVBRdGdF?=
 =?utf-8?B?dkhKMEZMQytLdFdhNGlvMzJoREI4amduSGlHVlVXdFFYZXB2czM2by9oVWZr?=
 =?utf-8?B?c082NWZDdkp1Q0czUTkwRm02NGZOZmdaVk5Md3NtY2FEazg5MkFyQXpHZ0RO?=
 =?utf-8?B?c1VJSG1hTGdxOFlqa3BRY3JQYzNsU1dSSXl4SFlQbTdpMS9WNDhtWFZZYTdN?=
 =?utf-8?B?TFczYUk5dEJsUHBZLzhkeFVhM2p2NVNxV3RkaFdVRnY1R1RzaDVHZEJXOVV4?=
 =?utf-8?B?OEV1UmZaSDhySkRlKzJScENFOEFJTEhlbmVxY0RuKzl4Y0VNN0l1MlYxWkcy?=
 =?utf-8?B?VXFqaXJqcnNsdE5rTGx3WlhzbGhMaS9WVDZWUDU2TWJIb29EY0p0SENGNUlM?=
 =?utf-8?B?cTdZQWFnclZYYmJKcWN4MHh3Rng1U0xhbjg3eWtDWW5HcVhkNVBlUVFLNEhR?=
 =?utf-8?B?VlVlNlRyNkVJNUhqakV4eURWQ3M1aEk1T090RUY4bFd1OEplQlBRUTdQVFFN?=
 =?utf-8?B?TmhyUTBHZTRxVXA0cnFzUEVLRTB2M1kzUjNnSEhDTmdHNzRmVGVMMlh5ZUNm?=
 =?utf-8?B?WW95Y1l4UWhkS1lDMFR1SXhvU2FuUTJ2UTJHZWw5M2lQaURTSmlXT1ltYmla?=
 =?utf-8?B?RUZUYnU1S3hxOSsycTVrWVlEK1hpVEFLZmRMY212ZUlHbDJMWFc5cFVMR2tB?=
 =?utf-8?B?K0s3UFk1ZUp4Nis4d2g3U0tna2F4WDZ6QlZTN29DTjBRNm5jK2dYRGkwZndx?=
 =?utf-8?B?REFadm9nbTZ6ZXBsMmxRcDhyeDAwa25SSVJSY0tQUVNKUmJZSmRidHZRWkxF?=
 =?utf-8?Q?KLXtB8x3nFWcK9ZFgxbqbh14/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e952a96a-18b8-4b75-aa43-08de3e236938
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 10:51:34.2997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9FJQG962Dqtclqt+p9bw1wFrrFnsHOgqbCSZB//iXMyuaCa6dYWoa2g7JOUAOUFmnMypm9c3NyILOjbOmbeQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6196
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMjEgTm92ZW1iZXIgMjAyNSAwMTo1MQ0KPiBUbzogTG9rdGlvbm92LCBBbGVr
c2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPjsgTG9iYWtpbiwgQWxla3NhbmRl
ciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMIDxhbnRo
b255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcu
a2l0c3plbEBpbnRlbC5jb20+DQo+IENjOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+
OyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBMb2t0aW9ub3Ys
IEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtJ
bnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2NCA2LzZdIGljZTogY29udmVydCBhbGwg
cmluZyBzdGF0cyB0byB1NjRfc3RhdHNfdA0KPg0KPiBBZnRlciBzZXZlcmFsIGNsZWFudXBzLCB0
aGUgaWNlIGRyaXZlciBpcyBub3cgZmluYWxseSByZWFkeSB0byBjb252ZXJ0IGFsbCBUeCBhbmQg
UnggcmluZyBzdGF0cyB0byB0aGUgdTY0X3N0YXRzX3QgYW5kIHByb3BlciB1c2Ugb2YgdGhlIHU2
NCBzdGF0cyBBUElzLg0KPg0KPiBUaGUgZmluYWwgcmVtYWluaW5nIHBhcnQgdG8gY2xlYW51cCBp
cyB0aGUgVlNJIHN0YXRzIGFjY3VtdWxhdGlvbiBsb2dpYyBpbiBpY2VfdXBkYXRlX3ZzaV9yaW5n
X3N0YXRzKCkuDQo+DQo+IFJlZmFjdG9yIHRoZSBmdW5jdGlvbiBhbmQgaXRzIGhlbHBlcnMgc28g
dGhhdCBhbGwgc3RhdCB2YWx1ZXMgKGFuZCBub3QganVzdCBwa3RzIGFuZCBieXRlcykgdXNlIHRo
ZSB1NjRfc3RhdHMgQVBJcy4gVGhlIGljZV9mZXRjaF91NjRfKHR4fHJ4KV9zdGF0cyBmdW5jdGlv
bnMgcmVhZCB0aGUgc3RhdCB2YWx1ZXMgdXNpbmcgdTY0X3N0YXRzX3JlYWQgYW5kIHRoZW4gY29w
eSB0aGVtIGludG8gbG9jYWwgaWNlX3ZzaV8odHh8cngpX3N0YXRzIHN0cnVjdHVyZXMuIFRoaXMg
ZG9lcyByZXF1aXJlIG1ha2luZyBhIG5ldyBzdHJ1Y3Qgd2l0aCB0aGUgc3RhdCBmaWVsZHMgYXMg
dTY0Lg0KPg0KPiBUaGUgaWNlX3VwZGF0ZV92c2lfKHR4fHJ4KV9yaW5nX3N0YXRzIGZ1bmN0aW9u
cyBjYWxsIHRoZSBmZXRjaCBmdW5jdGlvbnMgcGVyIHJpbmcgYW5kIGFjY3VtdWxhdGUgdGhlIHJl
c3VsdCBpbnRvIG9uZSBjb3B5IG9mIHRoZSBzdHJ1Y3QuIFRoaXMgYWNjdW11bGF0ZWQgdG90YWwg
aXMgdGhlbiB1c2VkIHRvIHVwZGF0ZSB0aGUgcmVsZXZhbnQgVlNJIGZpZWxkcy4NCj4NCj4gU2lu
Y2UgdGhlc2UgYXJlIHJlbGF0aXZlbHkgc21hbGwsIHRoZSBjb250ZW50cyBhcmUgYWxsIHN0b3Jl
ZCBvbiB0aGUgc3RhY2sgcmF0aGVyIHRoYW4gYWxsb2NhdGluZyBhbmQgZnJlZWluZyBtZW1vcnku
DQo+DQo+IE9uY2UgdGhlIGFjY3VtdWxhdG9yIHNpZGUgaXMgdXBkYXRlZCwgdGhlIGhlbHBlciBp
Y2Vfc3RhdHNfcmVhZCBhbmQgaWNlX3N0YXRzX2luYyBhbmQgb3RoZXIgcmVsYXRlZCBoZWxwZXIg
ZnVuY3Rpb25zIGFsbCBlYXNpbHkgdHJhbnNsYXRlIHRvIHVzZSBvZiB1NjRfc3RhdHNfcmVhZCBh
bmQgdTY0X3N0YXRzX2luYy4gVGhpcyBjb21wbGV0ZXMgdGhlIHJlZmFjdG9yIGFuZCBlbnN1cmVz
IHRoYXQgYWxsIHN0YXRzIGFjY2Vzc2VzIG5vdyBtYWtlIHByb3BlciB1c2Ugb2YgdGhlIEFQSS4N
Cj4NCj4gUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9u
b3ZAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2Vs
bGVyQGludGVsLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9p
Y2VfdHhyeC5oIHwgIDI4ICsrKy0tICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X2xpYi5jICB8ICAyOSArKy0tLSAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9t
YWluLmMgfCAxODAgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+IDMgZmlsZXMgY2hh
bmdlZCwgMTQ3IGluc2VydGlvbnMoKyksIDkwIGRlbGV0aW9ucygtKQ0KPg0KDQpUZXN0ZWQtYnk6
IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29ya2VyIGF0
IEludGVsKQ0K

