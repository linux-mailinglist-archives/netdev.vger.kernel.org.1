Return-Path: <netdev+bounces-211760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDECB1B838
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9251D18A168F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A828C11;
	Tue,  5 Aug 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gB52LFbM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A41F4192;
	Tue,  5 Aug 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410543; cv=fail; b=szblseaiGyie39O+hwgmtYsobMfpGxVb8bfM9rwvQjGOE2+M1fsBWsLU7BzFcq5qon/4LC/k/pQ8XJCq0OW7hjx3aYE3vCvGiy3rU5Li2beC4Mt6fT2EV7g2gp8eqcwWa7hFPP94V16oTOTMYxEIZ+EVZgrr6/UEQ3SGGE9i4qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410543; c=relaxed/simple;
	bh=MAvR3y9FrT9dVPac4oKYG3be7S9wc4Yon7xLrrOU0dQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=gU5g5ki4poKyLtGSwOZVYpWNgGOgaaLnOsZ2STQT2ZwC0mpSek1R+Rhn/q51uUp6Ch4YvxLCYp7so53AnevVPYJeb/QILKF4s5nGwmJQvHM9xYjdNtt9o+qJ4zRjKbr56rqYhGhYN21ohYrnZmxBe+uZ5Ne1GEQRhkCKczjLEFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gB52LFbM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754410541; x=1785946541;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=MAvR3y9FrT9dVPac4oKYG3be7S9wc4Yon7xLrrOU0dQ=;
  b=gB52LFbMJMliy2eUa7mKixqnJz1NhZLyqcT5JqJMhCsyc9bPwwcCK04Y
   9b45mDvXSBQQBVhhgyBYT5Z121M+WpyjnQFRooNvrcqLuYqtiOeJOANFg
   qD/YTcl3iPJEvWmHsVyYJX/YGgJxps73pwImzRw0F88b6qTzFME/3RpCo
   Cwp1lvOwrtrMQm4jU3Q/0QXtKWIEje9jGFHzZ1Vj1vwWDR9B5EFzqT3J6
   A6Zi21nE1w+CzCKR+XSWbvzq6Y/rkw8C8HNajFFoYD0oQFmM70vai/kkw
   OnuLPHANfk9Dyf7JfbQFEjV5fk/dBb/TP/z8YDpk3KhAyycNVth7d0N9+
   Q==;
X-CSE-ConnectionGUID: YouFtkdzTLqfT12l2dIRWQ==
X-CSE-MsgGUID: UB8Wv3ZKS7W9M0EpKO8wLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="67415575"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67415575"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 09:15:20 -0700
X-CSE-ConnectionGUID: tTQb9aiQQ/W1RhIU+2nHfg==
X-CSE-MsgGUID: F0Y9GIPgRWqeb+N70CSiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="188213422"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 09:15:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 09:15:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 09:15:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 09:15:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTuCs3FW2H3XdEkIiMpMC2lQVPMrVIRPnbkA2Rm/2JcSljUm60zOwfz5QBp73bOzH7fp1EV/6pkLOUbw+LVlIfPuioDZoUxpOZyE3p6FJzqHKIP/VYpIcD7M5GVwrJWc11sKc6t1uoWjEDhbOtbRvtBmeU0mPDdPCQd+KlF9JQlwHXV62DpDo1nw4AyPn8eaS8kXkU18LnV91poQYlTcirrJym+OhVVEPHUpB8OneXgKO2wv3YCg5OJCf2Mib7bhDtRpzqmcG1DyIK38zH6X7WkvssKzF2NeRpbELbK1bRO8aVqQpBz1IkOSyYkgQslPGVsLzIGlXkMlaULMQeZL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ete5YxWaEtj7qQhV8+5TaxGqUwxbgfe4jycLvIY/Aw=;
 b=rQ1NommPcIimSelz0PVvL3dTS6BqaukF6n0QHbBoKp5x1Gk5dlFkxJa+ZkxR6XJYHYb46GaglooqhuiQ+S8FGk28L3swnuRQhHkA5KujCgYw7PXE7gq3bFQmoJL9oiVOhhpKN5HlRbHd9u377Yp0Rx2AEZMh8kzmbKZZHLQkVbMG549OFzce8WsHiyNm2txktjmA461OZvXnjwnK+1Om4g4XNYFZ3aeymJlTMGlTiB0NQ6Cn95SpUfzxIERuebVsMejiXdm3T5Jgr9u4ln+7MjZCpx0bNn7S1eR7Le/ddcCMm+HevIO/uclLA68Eh3D61zhRQjdrW8QAJjUyfzvuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 16:14:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 16:14:58 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 09:14:56 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Message-ID: <68922e004131f_cff991001e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-12-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-12-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9f0671-2db5-43d9-7880-08ddd43b38ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3BBc1hJWFdRNERIMUhDSHdVT205d0h0WjQzQlRBRFc0OU1MT2I5b1NnVURO?=
 =?utf-8?B?TmNHcXhzVTN0NXN4NGxOSmZuZXJ2QXRaVkFZVUtmdWtuRWdsS3RJQ0s0ZVlw?=
 =?utf-8?B?MGUyNU44ZE5jT3ZyODkrVFBqS1A1M3V3elVBRUJtM3VMbHd5UjljYTl1S243?=
 =?utf-8?B?cXd4cTJoVXpuSk1teHhReHZOdk40VlVjZTYyWEI2L1g4cUhSVWJJKzdpOC9C?=
 =?utf-8?B?TWFWaFcvZXN2VEM2bkxYQzRWQUJzaldYTGxhbVhYZUtSNXZHZXlSamFtWlRa?=
 =?utf-8?B?N3JZMlJzQ0l3T3k4NnVTc0FrVmU0anJvRXR0bU1FZEdiS1RyYUxEeDBsZWtE?=
 =?utf-8?B?RUVpM1YxeUJtRFpvalNmTlMrd0g5MTQrRXc5OSt0aWFEZE5TeTdGMkJoazNw?=
 =?utf-8?B?d2hjTnhYNzAzanJDRS8wQUxzZzNCdWJWa0dDd3I3M1lFS3h1VHlPem5FUlA0?=
 =?utf-8?B?WEJpYnFXQmpVY00vdzVMT3g1Y2Q3YWZiWUhFdFp3ZEZCNW5PT0JwckJSVGNo?=
 =?utf-8?B?bmt3ZXUvdnFJOFB4UU9oSWI3cEJmRGFyQ0NXSXNzZDJGUXRRdDA2cW1pQjdk?=
 =?utf-8?B?cmI5cTlodjRQZzJIMHBXZEZrczczZjY0cWxuTm5oTDZrQXJyaHJsRXVhTlVm?=
 =?utf-8?B?Q2Njcjk4MHJKNzNJQ2p6cm5va0w3ZTdMYU1pS25CN05LenlDS2M3dVpsS09l?=
 =?utf-8?B?UGNra0t3QTArQXQ4ZWl1VjdaS3NzTHpDYzlXY2Y5ZkRWT0owM3FvVFFhTFVx?=
 =?utf-8?B?Smdhd1FoZ3pTZnhBK215UWtXekFXR0czMXRESmMxL0c2NHNBSmpyc0ozV0lq?=
 =?utf-8?B?ZUI4M0lmai9yKzhUZVo0bTBtcFpvd0JTbDVWcnBmZ0RZT0F4MWhCT2pyQnBL?=
 =?utf-8?B?Q2tVNmNEa3B5TFplRm5KcXRPaTNuYkpFYUtRZHBrL0FLT3lvOTVHeTVYMGZx?=
 =?utf-8?B?Z2crMlc5VUVtMVVQcy9kcVhPMko3V0Fwait4TVZKQ3pQV3RNUks1czN4bHF2?=
 =?utf-8?B?Z1RuRFdNMlY5ZGMrRFp0Ry9ObUtBdnIvWjMwUVlWaUJHZWVldXBUaU96aHJr?=
 =?utf-8?B?dTdTSmI3cWE4R2lYb2JTNU15TDM2bVpqL04vWjJHbFhuc1UxSDVFR3dOdjVt?=
 =?utf-8?B?RXM2RmE5THVybnQ5dkFMSk5XMHRxQjU4UnQxRUtHUU9sRFYwbWtCeVZlZXF5?=
 =?utf-8?B?alNXTnlXWm41Q1ROa0VXcC80RENvajBoL3BCcy9SZGpkN0U4emxtK0VTV2RN?=
 =?utf-8?B?WEliTDZ2R29TTjF2dUlCaU5JNGdZRHgrSFBZN0hQaXFMSzdySS9aWW5DNDlI?=
 =?utf-8?B?a2g0SDd5a2Zoci85MTNObjhQWURXNUxtV21RUE9lamMzOFNSeHdRR2JYTGpa?=
 =?utf-8?B?cnMzeTVIMmdhK3UxSWYvS05TL0NBbUk4dHNhS3RFd0RJa0VjSnVQMWxmclhF?=
 =?utf-8?B?ZlFLWUNkejlycUNPcGtZVm1oTk82d3lCTVREdm9UM3NvYWtUOFdSYTBycjha?=
 =?utf-8?B?VENialhBTStyWkhudW5mVTJ3THNQeWJNNFR3ZUtMdXhmWTNwT0d2Y1NwRTFG?=
 =?utf-8?B?MWNZQ1NuZTNJQVhlcWpTc3lTOFJoakZBUGVscnQycU1jS0J3bFl6WjZscnBQ?=
 =?utf-8?B?cThHWnJZbkZ2VHNGc1Q1d0lWWnVya3kza3M5Rmc5VjBpaEhhODVMUGhOY2VK?=
 =?utf-8?B?S1N3VVBkMy84UjNaTGhzS2hqRStONWdpR1NMR1lsUjd6TFUzSmtNQXFlY2Z1?=
 =?utf-8?B?SmduQ29DbG1HQmgxUkpkUG1DZUNINXZ5d3dlenAzZ1BSN2psU1FzU3A0TFA2?=
 =?utf-8?B?TkhnQXlJM1psOXBBbTNXQ0crWmNNNHRQKzlhd2FGMjlzZGw1NXpKWXVkVHQw?=
 =?utf-8?B?dStYTW8zTGdkblk4V2RWc2c3cWRBanNYVDV0R1J5WXZPQlFkY0lzb2IyRG5r?=
 =?utf-8?B?bUw0U2d5U20rTWdYNUZsWXp5RWgxQWd3dE1MMWcvSGI5ZlNqVW1kTVRSSDM3?=
 =?utf-8?B?N3RVOVVZRFFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjRKR3BWMnBwZEZpZ2ZlSkN1bGEyT1U3SGNWY3lZZFNGemRhWFE3ZklxekE5?=
 =?utf-8?B?WUdZU3dqWnFqTUYyUnBiYkUybU02VTF3ZGIwYjB3RytTU3RLLytMaXRHL2V2?=
 =?utf-8?B?bEpHRVZlL1hFTjBpbFphc00rWDdUTUp0UEpFUW9sOURtWTU4UXpNeEhabTRI?=
 =?utf-8?B?VlYyTlhBcjRjY1dwcjI5OTdOTjNITnoya1M5UWJ6MnRJUGlzQjdyLzZ6bHhl?=
 =?utf-8?B?bkRqOUFIencrQ0FmazlPNHYwUkdCUnJPNDVBemFDenc0dUJaZk12K2pIcTFY?=
 =?utf-8?B?OHlvREswT0xDRTJLdzZ5RmtmV3E4VDlrNFVTbjhuaTc3bnA1NTRRSjJWaGVu?=
 =?utf-8?B?eEs5MEs5eHlwdndhVHd0NW1SUDZyd1B0UU9TcEYxR3ByQi9GMW5WVmZoY2JL?=
 =?utf-8?B?MXlRMVlsbmY5YkZLdUcyZTQxRkhCeGdHa0tYM0NvZWFVaGFrbm5IckowdTJa?=
 =?utf-8?B?MURYRlhXa3FKc3luVlBuWnhKOGJraWt4S1pBdG1oSDFDbnNWVUVvRTJvOEFx?=
 =?utf-8?B?ZUw5Nzh0dEhoYlpRWXRPUVd5NHJ0RlFCa3JoeTlhU1Z6ZkRVcUNBd0JwTXFE?=
 =?utf-8?B?WE9Dcm5JeHo4ZmtDZmR2WDdOOTlEa0QyT1N5ZzJaR3FRTGMvbzBVL2dwNnBE?=
 =?utf-8?B?UHQzMHl1dUpwekl3ZWZwc1ZlczdNY2lDZTlHN0Q0T1g1c2pPRmovWXZaMS9T?=
 =?utf-8?B?cUFYWDh4SFdsRVVOR3gzVzVNdUhvK3Rhd09DVFBYeG9Sd2d6elNCaXdJdHdN?=
 =?utf-8?B?c3o2K2YyZzRmTThteUJOMTlML21PVHZJZGV2ODd6NldsbFZZQXgveDQ0RHRu?=
 =?utf-8?B?L1Jidmh3SzJVVndiZUxTUlljYVQ0bFZTRlNVY1JWNE1lemJIS05DN29mVXFO?=
 =?utf-8?B?L1N1N2hZaG9FV0g4WURMamc2Z290ZnVYS0lHR3djTjh0NVZvVnUwYmN2bjlM?=
 =?utf-8?B?d09DVENack9MWmYvenNSTlVUY2I0ZVpwby9nZ0FuOUNzbGxUczVjY1oxeXRo?=
 =?utf-8?B?OW10TnNvRjV5OXE2dFF0bFZMYmozYjlmZUtCRDhEVWhHb0V0SDRtR0RDOVBL?=
 =?utf-8?B?dHpydmovVW9rWWRwY0dmRFE4ZGVTS1BKb29VNUF2Njg2UGlDSFphbU1XZXQx?=
 =?utf-8?B?bWRTQThoQmdLWm9zbHZiMWdUVGMvbnJwaGtHclIySEs4bHhJdEFyQnJWbWFO?=
 =?utf-8?B?VkRsRVdZRU5ZTnVDUzhkTjlka3BuMkJ0TFVCRkdzN2tBTXZtVFRCNm92TUp0?=
 =?utf-8?B?Y3N6YUZmUlg4blVWRXZtbk9uMzhER1VXNDljeFprVXU5Unp0cnFkeWNtVWtS?=
 =?utf-8?B?TDM0cGdqR0dLZFg5RGxGTWlpaXM2WThBWWtDdlZqZFJOTlN2L3ZWdUlnQzF1?=
 =?utf-8?B?K3lPU0txOWw5VUdIRk9nNGlLcVJLU3I3L05qZlNxTG8vOHIxWC95clNhTFNi?=
 =?utf-8?B?OUJXclMxbkJlU1JzT0hlalZUSUNFakxQYTQ3UnBYM0poM214emtCZ3pVTnJv?=
 =?utf-8?B?aVJqOENEY1VsWlMrNE5xdXVNZGN4UkE5TnZpbzVKaVBHOUZlWWQ0dTArbEhq?=
 =?utf-8?B?K0ZCR0lIMGErSHpzdGxVd2d6eWlaOEJmRXhwQ3BnL0l6RDVIS3k0MFlENzVk?=
 =?utf-8?B?UlZXRWRkL0NFblJnWGJiYmN3OFNCdk5BM2p6b3I0aXpqdW0xbmROejJwWjE3?=
 =?utf-8?B?UUhpT0oycDdTbW92dkV6eEhBUnlaOGhqNkhtWDhSYUFoK0NZRStxck5PaGVh?=
 =?utf-8?B?ZlV1TDB2UWgvTG5QdTM4aTRoU0U2TUtLSmFnT2hyNFBSTnZuMk9MdjUremJu?=
 =?utf-8?B?a2F4VHJMTWc4T1FrdXlJKzZVam5LR2lhalhKWGVoYVZkWThsanhrbVJvWGhL?=
 =?utf-8?B?S3pUdHlmb0p3b1hydHB2TE54QUltdFRZOE9CdUtnNWJ6NVNKaVlGUkI5Kyty?=
 =?utf-8?B?MDVNZGdCV29sczAvRnZrM3JLeHNIalZRZ05QRkFmcVlvdlN3TDRlbkprOHVB?=
 =?utf-8?B?NCtnM0l4WHNJN2JHZWpYR0FMb2lpdSt3R3lKKzlqL3FHZHpZUWxzSjBnU2cw?=
 =?utf-8?B?RU9WdDBzTEJkSmVDZkxOVHhjZVFPcTZWWlZ2TVJXMjJyeVJYZEJ4T25FRzJE?=
 =?utf-8?B?QTJDL1NjbnR0anRTTHRuV01FbS9WSFM4N1hoR21KcCtCMHp3N3RQcThSYVNh?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9f0671-2db5-43d9-7880-08ddd43b38ed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:14:58.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7j+XhOBIjQkh2frTyfOPpG9XEGE4qAapPQdoW3iO280yH1IPnebTU8TNk3u7Jm+4z5LOrygkc66Jn4q4DL+WCpLauW9vV1w/tIxrkyIFpCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 169 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |  11 +++
>  3 files changed, 183 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..03e058ab697e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -695,6 +695,175 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +
> +	/*
> +	 * Flags are single unsigned longs. As CXL_DECODER_F_MAX is less than
> +	 * 32 bits, the bitmap functions can be used.
> +	 */

Comments are supposed to explain the code, not repeat the code in
natural language.

> +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}

How is this easier to read than:

	if ((cxld->flags & ctx->flags) != ctx->flags)
		return 0;

?

> +
> +	for (int i = 0; i < ctx->interleave_ways; i++) {
> +		for (int j = 0; j < ctx->interleave_ways; j++) {
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev,
> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}

With the benefit of time to reflect, and looking at this again after all
this time it strikes me that it is simply duplicating
get_free_mem_region() and in a way that can still fail later.

Does it simplify the implementation if this just attempts to
allocate the capacity in each window that might support the mapping
constraints and then pass that allocation to the region construction
routine?

Otherwise, this completes a survey of the capacity that is not
guaranteed to be present when the region finally gets allocated.

