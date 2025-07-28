Return-Path: <netdev+bounces-210598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F4EB1404F
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6312618913AA
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E761E4AE;
	Mon, 28 Jul 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViS9WdE2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC01E9905;
	Mon, 28 Jul 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720241; cv=fail; b=a4L7rdmw9fEM46zLajUI/37CcZTG04907ktoZ+zE09jnlZIttoycI4dyFE/00aFY0wKm36pobCI9/41xNEvMgvMCRI7xe+2r2AmmBh9hVZ3gSRGXwyvh99Vpb/yMpFW4b8INxPxscw4u0DxkwAjIwmKKODFmXLKkTFoGuROJsvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720241; c=relaxed/simple;
	bh=kwQu9nCRwQJa7aJR/gPC6aTOTNSxhC0FMGUjnrTpuMc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HEWHXNfVH/c1xG11OhtsJJ+ggnSiSBDyxrviLBYnfDk+WFl590DTPD6nTxPGFQskv/qkzu+8D6YgsZJSRWgM/L56qDrORkbiMxDeUcrg0+VWRMNQbPknTQKSvfYyeKcUvO61JjNe78UdSbPCwywHfJZNqoTOrE0HK3cRylEpYGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViS9WdE2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753720240; x=1785256240;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=kwQu9nCRwQJa7aJR/gPC6aTOTNSxhC0FMGUjnrTpuMc=;
  b=ViS9WdE2gRw5G3KOa3ASQ8TmBEIqa0Exm3b2SPQHc6artu569OmBPNGh
   cE57WVr7vZisNArbao/bzt6rbo3p6iIV4N60BZszc36aiecbHWOCjVA3f
   p4qv8ZhVg1q8v2btSpYZUXoS4Veof08iihCx4RFD/IfISfsnvdD+KVUUL
   HBcW7AdeaTTaGeIGP39vKTY++Lam0p/BQdmL7+sUpZANX5ld0A+8Zkak0
   o4tdnJtTy/4xU3cYoW2Q+8MhAdHWW1b5LfNZi5/5YUySZSI02TV0Bd+/b
   f0HL91tZL6bxzeepi2X+rtCB7Ls6B6ZMNXyOLfsQ490buQDvfd8xeRTef
   A==;
X-CSE-ConnectionGUID: Z7ktXGmEQASC1AWyTEps6Q==
X-CSE-MsgGUID: DThe0Cd8ShiC21cE0wR4qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="56126123"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56126123"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:30:23 -0700
X-CSE-ConnectionGUID: CrJZoh0pRWyK3CK8sO242w==
X-CSE-MsgGUID: 3ST0i0NvQ3KcCaowemnIjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162811431"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:30:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 09:30:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 09:30:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 09:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RV4nzNSvOGpocJPjhDCoAR8eFGvaZItrPmw5vLuFNpNq/5qytS6xmgy1s75pVPVnPyuouAd3VdV1IhG0V3MuCssst/QGyxsYlJPTK/x38HghoAwliGjSM5PN1Mz88i90/QRVlhFk8BK53RrfspLBmSn2xmIhKX++xdu5d/TGPGDwrwQ9rI8Wc+dT5hxWtXFTao4vXbgtpQ6b911x/YPqgAHXUAg+fgMjxrCDhfe2QqaHQBLit2rqkJDAHQD6ldSC3PHWZY4Lo2B/v2aXsIBvvfW45aiHdeda9JD6kDHh/HdyYTBBo5SYFWacx6MADZkEFI7ll3KxrHkLlFfGsRQd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXOBbTUEl7dY/3vddMM0+CtSTJWKzqiTWHZwBYjYzmo=;
 b=AZRxlyF76Os9jzDd6x3MfR6Vc9cVzExWJzL46PeAb5rzUsmfRrypXqXUiNA6rr0Ep6dSno0SxqWS0lkzJ0rJxAxHcsuyKccxGJfKRg5RmCdkWWMIimJFuddOm90q8TpA3FXWsZQuCgYkwONMEBTDChgvRtc4Giar9OJYHo0szNoXHF6CAv/nKq8qQWj4tU5pK+McNL1Yss9Z6dAieVhj/aAXtdaqSuThR0k56ch1N1Z+RugnghSBFL/XKoknQvloxT60EpWaTPGhboVPgO1Jd4/eUEN4VOyNFSDVfBkZDYA3QkyadkSxfu1GXEv66tJYZdj5WS9EI1kK5aYhI4w8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5027.namprd11.prod.outlook.com (2603:10b6:303:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 16:30:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 16:30:15 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 28 Jul 2025 09:30:13 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Message-ID: <6887a5956dc2d_1196810015@dwillia2-mobl4.notmuch>
In-Reply-To: <20250624141355.269056-13-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-13-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 12/22] sfc: get endpoint decoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 118ee112-98f8-49cd-844c-08ddcdf4084b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1lYNVVUcDA3MUp5cFZBV3U0VGVjLzEvcHBaVjh0bkhod1A3U2wwalZZNXpU?=
 =?utf-8?B?K05Hb0tlSUJBZTNwOHZ2UTl5UnVMb0R6bEgyV2o2NEdBcEgrcXFsZlRkL00r?=
 =?utf-8?B?bGI2Y3FCbGNFWnczZXpSdlZ4QVdFeU4wK295VkVPVUVJQmFKZ1BDUnJkVDFV?=
 =?utf-8?B?RTlNWXNZYTJ0cEJJbStpWmhLcjkyUVRBVE5HUjZBR1RFdnd2Q0N0bGYwZWF0?=
 =?utf-8?B?WVBmK091ZExCWnlGcUJlK2FzZlhPeTNzVnJuazlPNGh5MlB6Sy9vRE5JZzRM?=
 =?utf-8?B?em1LMjZ2RVdLTWgvRFlneWhEZGY0VnBIby9vQVlVUGZINmlSZGZmUnM2c1kr?=
 =?utf-8?B?OHFnT0NuTE5NcFVOWG52dXpvOHh3WGNONFdUejV5SVJRaHA2SThuQjgwRDEx?=
 =?utf-8?B?OU5YeEU4S1JsNURsSjRNQXdncU4rK3hNNXRYaUVPUHRiMjlFbS9MeFNOcXZn?=
 =?utf-8?B?Z0VZSVVTejgxSHhIOGNtVHB5RVRNQ0VsWi9JVUdwUUhCdk1OZldrdCs2dlUv?=
 =?utf-8?B?VG44UUl2RERKcmRYWkJUYmhKckcxQjFZQU53WHVyckZWUldQaTRiZmNVNHlU?=
 =?utf-8?B?clRjanRmbEtmY2FXVURkS3FZNjE3cHNDZU5pYTkzajZ0TU1jYU0wbUdzbXhY?=
 =?utf-8?B?MGorL1MvUEYwZnVkeU1UR2x2TWFIUUl2SVpYUTllQjdxa3l5RldyVnhVTE5w?=
 =?utf-8?B?QSttNm9tN012d3NBZ3NyVjhpcTVrNWZFNlRJQWw5NndjbnYrZEFycFJqc0tR?=
 =?utf-8?B?Wk1GT0c3eVE0Vm40L0tTK3gxRmRuOFRNbXBaTVBZQzljamlSbWNDZzU4UEp3?=
 =?utf-8?B?OWRBcHllT01WUVNGMG5HRmFwNU4xL0hqcjJBWGZQc1ZUekIwaXMyNkZRL1kv?=
 =?utf-8?B?UzFjMFdXQXJqR2dUdE9DZG9zUlRUUzRYcHlGVE04bGxlWGVtRjVwL0hHc3NT?=
 =?utf-8?B?bkViU1g3QVZ4OW5Tdk1LK1JBRjE0VWl4QytJZ1lwUXoxbjJta0o1TlNnb0d2?=
 =?utf-8?B?ZjFlMjNDQkpqd0NxdUNTekxKMjk5VHZxNWF3dUs2dGpKZ0tUSG9XWlNqVHQ1?=
 =?utf-8?B?OE1Qa1JpYU9Vdnp1enlGMGdEV0NJL0lJUkNDWlBIQ01KcG43TXJmY2lWSEdn?=
 =?utf-8?B?bHZ6SHg2OHF6WGV6WlNlMnpJZ3NieW5xcldsL1ZpNVZUOXM4ZHJxTXJaVjNk?=
 =?utf-8?B?bFVvVGJ0OXM2SHlWOC9QSWtWNmI4SituNURXNnJ1cCtDV0pTYVUzc3hzY2NB?=
 =?utf-8?B?VGwvc2syYmNiQUppK0dRbXcrc2UvVDRSSU0zT2p6VXp6d2xab2locENLT3J5?=
 =?utf-8?B?aWF0cXNUUnlpeGdBOTdkTTJMSEZTb2pwZG8wSjk0aHk3SW1XSEliaXE2VS9C?=
 =?utf-8?B?THpFM1Bvdjg1YmdMOXplMmQ2ZHNidWFhelRBaXFlTW5OWlp3ZEkwR3A2SGtQ?=
 =?utf-8?B?bmlXemppRHJvTTVHMnBGeUwrcDVVSHBwRkwwUHNadDVwc1gvajkwRjR2aFMv?=
 =?utf-8?B?R3VCd1FBL2hncG9VVGJyc2NHc2lWY1gra01EQ0dFRFZKUWROZTZocWJOeUs3?=
 =?utf-8?B?VWVyOERWRVMwSTE0WDRKRUthNkJxaW1mQ3FSOHpoSFJneHA1SFdseVJBdkF2?=
 =?utf-8?B?MFlUS21qV0hkS0lYbE5oMzhyREF6bldKWkdFT2crdGpXZE5GMDFWVFhyRzhk?=
 =?utf-8?B?L2RNZ0Rkc0pNZlFZdmxsRFFwc3JYMmkwZS9qMGM2aVR0QlJNc3p2OUh3akZ5?=
 =?utf-8?B?dTVrYTBTRzBkZHdMVWRxOThySFZ3VVlxaHU1V0V0eC9mSEozYjVPTG8wOWdn?=
 =?utf-8?B?VWNuOHhRZk9JTjdUeWxVVmJrNEtYVDQzbVQwelpUamRyUkpBclJTMGdLa1FV?=
 =?utf-8?B?NmlFNE5DVDBkdkd1MldGeXRNMGR3ZHlRNVM0MFljVXkzRDhNdmY0bGFuaEMv?=
 =?utf-8?B?ZXpRS1puWld6bWgwZkFFTHB3RjY5ZjZ1ZFgyUm1LS1JWT1UvSHpDU2lMQ3FI?=
 =?utf-8?B?T05Wb2xkdkhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktNNnVVSnpmTXVjM1A2MzNjK0pIeWZOUW80ZjZNQkVkNmlqZjR6MjMxQVlM?=
 =?utf-8?B?cEtkeml5VUF1WllPWndITnJjN0FjMGluaHdoVDR1OE56d2RZYUlXNldUTGxB?=
 =?utf-8?B?QlFLYzdrOVpheUNRZlBZSVFaZFhpZE9yMW1TZmJ6QzZzR2N4YXgrekl4THh6?=
 =?utf-8?B?cDBYbnV6alQvUFJvUitGUnVBTHN0ZWxKRCtxK1JVRWtIK1AvNzNuTHpTRHJm?=
 =?utf-8?B?V1oxTnBqcEdKNGJlb1Z0cGdRTzZTTEJ6dFBFWGtBeHQ4OXpkb2F2U05venBN?=
 =?utf-8?B?OGJ3dlVPdkZVd1FES282QnZaR2RpNi9NWFRKUUdyN1ltQTdURVplSUkyb3FK?=
 =?utf-8?B?V2V1VEkwYWpJZFl0MnVCaE9MeVQrRzdNMnVVZWZCb0w1cTZjTXZJYjRuUkhI?=
 =?utf-8?B?ZFFtRkwyRUNUeUI3NjBqbnZFTSt4TVRJZ3JDYUhPY3B4Y280Vlk5aWVEcUNL?=
 =?utf-8?B?QmdxemNzRmRQbjlNTTE5OExPNXJiWGg5T0lLeW5oQkJxeWREVS9mMUxDZ0ts?=
 =?utf-8?B?enhxUkpONmFDU0M2S01zZTh3bHROcWJYRlVObmFFOTJGY0VWZkxxRG50UHh0?=
 =?utf-8?B?R05kLzhxcGJYNkx4cGFjSGRiZStkNHJERm1aaEJvZjViN2pJRXREVHNOVWhy?=
 =?utf-8?B?R2FVU3hHS2MrNlVQYWVwL2VlNE4xL1dvRGxKdjFFaVh6VUQ1a2xIQnBOWk55?=
 =?utf-8?B?cWNaUm52ZGh2bnVuVGNHaVEvMVNjMjNTZitqMUtsOFRRa2RlWmw0SWNtaUpi?=
 =?utf-8?B?REs5QlVOdkhuRnZtbkh0NTJWb0I0cG80K3cxOEJ3TWthMkY2Q0VuUGo5NjFS?=
 =?utf-8?B?a2tUMTRmT3JuU2drNXJ5dTlkNTFYNk1qSkZzSWRhcUxSQ2RtZXNoZEdsQUF2?=
 =?utf-8?B?R09wTi80dnJrNW5wMnVxNk5OSHJCbE1zVCtYbUlxalZ6alZZMDBSWGdkbEZW?=
 =?utf-8?B?Z1RIUXFkRU1sY1huRldXQU9ZL1k3U1JRZ20xVjAxcGVaY3ZIM1M2WW92VFZa?=
 =?utf-8?B?VnA5ckhBaVM4UXE4ZnNFTDAyQ2dQSGFxdHNkZElCUGJzMlhlU2pBeW5Qdk0x?=
 =?utf-8?B?b2czOTR3UlBEOStiQWNjeHA1VmNLWEZMeVkwV1ZEOFJIZXpoN0hGMTlGbUZQ?=
 =?utf-8?B?OTd6OTM2UExSQmp6RWYzMWZUY0lEbHNvMmd2UjV4QlI5NzdlUDUyNTJTT0Yv?=
 =?utf-8?B?cTJ4b3NTY0l2aFhiRWMybmlPQjg4NU56WUQra1o3SGJVdGswOTlZcUUxbXlu?=
 =?utf-8?B?clpkbHF1WDhMZXNkRDdzSXJseHYxdjV6THF0SG9VOU94RVlhWE1YNDRWZHVN?=
 =?utf-8?B?QWhiR0tQbG9sZzVKWEF4WEMxMVlUSGhQV1EvWHhUL0Z5TWxJbmlIbFNOQjJm?=
 =?utf-8?B?OUJ2aTZBM1JiT2lZOW95U0JoZHpFemw1eHBnUWNEMjJyQ2FHaFNVQkdPL1kz?=
 =?utf-8?B?dTk1dnRZdkxpNDJJNS9CM1VGQ3JSMHFmTC9TM1ArckJTTXJrUlhKQmJWMDRV?=
 =?utf-8?B?cnFPcDFoT0xoRjdkallaZ2s1Mk9ZQnUvaDZhTDZoOCtzNlVRdDQ1SlBSdHZ1?=
 =?utf-8?B?eHU3N2RoRGxxeE16eGtwVWlmaEE0SWR6Ym5jUlVyODkxK3FHYTRsa2hLWHE2?=
 =?utf-8?B?R2RkSHhqVVNtai9Fc0dhTjg0VElNRzYydWtlWHBSaXJGL1Z3R2tqdEFkQjMr?=
 =?utf-8?B?UXVQd0JqSUlxWUg3SkJ3SEJGZ3FTZ1Q2K0pvcHkvNkVUSU1DNDJ4N1VieTQ4?=
 =?utf-8?B?TzVEZUR5RnVSWDZGK1NuR2pUbFpIaytCV0VSbnJLYTRtYmd0QXU0NTFLZWRW?=
 =?utf-8?B?Y3lYODVtVjB3OUwvYkh4MXVkV2ZzeDRRTElRbm5rWVNmcFB0dTN6Qlp6cGZZ?=
 =?utf-8?B?bHp6RkdwWlVJRnlXbEl4UjU5ZkNuNWRZMk5UUWVYSUhldDJYZmx4M0pLc0hN?=
 =?utf-8?B?ME9iZ1BaUDZPa2Q4NUhpaENHeDRSSms2U2pxaUwrS0JLWlVvd2VxM0piaURp?=
 =?utf-8?B?VnF2R0w0a2RIOGN4VmZ6VnNUaXZkUmV3dlFnMlhoWUpRbFM2R3RsOUlZS284?=
 =?utf-8?B?TWxCR1E0TnVIZXNkb1pmREJLRWRmNklmY1VGMVRhZkVaSHJVak9nMklaa3Zs?=
 =?utf-8?B?UnlTK0g0ZmoyaHBoZFIzdC9xZ2lzczlsTy9PRHZxN0Zmc0NidXltL2x1MU5y?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 118ee112-98f8-49cd-844c-08ddcdf4084b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 16:30:15.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBVmI571qAa7FN3B2awpTEDgu4PKwL9vQiUyvwgHxuiOhxG1oz7tm4yXI4TsQwvJvf1G9I7vTK3NCrokDQdgeyYSzMPIInUHTYrmom7XRfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5027
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig   |  1 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 32 +++++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 979f2801e2a8..e959d9b4f4ce 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
>  config SFC_CXL
>  	bool "Solarflare SFC9100-family CXL support"
>  	depends on SFC && CXL_BUS >= SFC
> +	depends on CXL_REGION
>  	default SFC
>  	help
>  	  This enables SFC CXL support if the kernel is configuring CXL for
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index e2d52ed49535..c0adfd99cc78 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -22,6 +22,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	resource_size_t max_size;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -86,13 +87,42 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
> +	if (IS_ERR(cxl->endpoint))
> +		return PTR_ERR(cxl->endpoint);

Between Terry's set, the soft reserve set, and now this, it is become
clearer that the cxl_core needs a centralized solution to the questions
of:

- Does the platform have CXL and if so might a device ever successfully
  complete cxl_mem_probe() for a cxl_memdev that it registered?

- When can a driver assume that no cxl_port topology is going to arrive?
  I.e. when to give up on probe deferral.

It is also clear that a class of CXL accelerator drivers would be
served by a simple shared routine to autocreate a region.

I am going to take a stab at refactoring the current classmem case into
a scheme that resolves automatic region assembly at
devm_cxl_add_memdev() time in a way that can be reused to solve this
automatic region creation problem.

