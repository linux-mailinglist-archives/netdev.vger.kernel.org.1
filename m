Return-Path: <netdev+bounces-185295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049BA99B46
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD443A38BE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D01EBA08;
	Wed, 23 Apr 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxT/FGJz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E9149C7D;
	Wed, 23 Apr 2025 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446316; cv=fail; b=GZ05CdTCsNExmsRT5UxxmmMJsvHeI2hDgIL13ktGBwjRTuUNlUGHDS/S+4pUNHyt5v5h40ZwWbsvXd5TcQrr1Cz4CJLKxt9K9+0xOMKHGcs213qx5Gkv9N9xLLZATNF59s8vGw9lZKH/ErdZNnm1ka4x/fNOMYHXQ55WNqmRfVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446316; c=relaxed/simple;
	bh=A/aKXDShR/deKR6ytOuOm86FEjLgiESxgY82dLLqsHc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vv9imARRe/4jUn5rd9df8tA1gjc14spn7s/TLzCHonmE7QAWxCBo580Fmh7dToL2QqKj69pT0g8RzTC1GIBngVa2g3jnEjEV+PYlTU1J75j9k6yqwXYs6MW1dDqx4XuH2FAsd5hjYMl4rX+LLrVf5JQnxc49zJuzaF8yPIU33rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxT/FGJz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745446314; x=1776982314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A/aKXDShR/deKR6ytOuOm86FEjLgiESxgY82dLLqsHc=;
  b=dxT/FGJz4uiKGo7KdgPw8E7fVFOZMfBb2P4PKzrym6bke5mlb1Nb33io
   n/BKYS7/pG6i7tf3Drgr+2ak2MCe668I30lOAtba3or4w4/0z2lVhCnmY
   UXUZb7bJGVI4hxAcHrc5k33evGpOQVHDiH3KY9n+ZFGkPCKuoQB9qUgww
   H4r6uQ0llQp/VIzqQcSyhNig61GIedP5S9PUkL9OrJ1/fPnCHaNJlDoOb
   xa7r/QXFGFkfsgobQj1ryt+jxYSWRsQyJFbjHhKviXSfB3BjSM8Tn7sFm
   rAvtNnNRdM/p0aK+jKte3vfq4CotvBTF2/O96Eo93NE5hv2Md+jGYOBY6
   A==;
X-CSE-ConnectionGUID: 6fgg3cP4SGGD5iuymufGBQ==
X-CSE-MsgGUID: hlwNWBLBTK6JSXI37ZFGww==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58052429"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="58052429"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:11:54 -0700
X-CSE-ConnectionGUID: LlxF2jNlS9m9TGsoSjLIhA==
X-CSE-MsgGUID: NR3xvqcLQiqizIC+hfHDHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137522520"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 15:11:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 15:11:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 15:11:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 15:11:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCdj1te2wdgdkWp7mC4AmRMC717TnAzpw3dxQ0KBQ8AD2af0DjONCdomCUl5i/gq1xPyQ55avIcjfZaEGD9g9v7pFT8BgdUiVvwREGl9UA170PELZTAv/TKSwcs1IsZqv6vG7MPcRYXQNejLQKDE1QFgfDxPnYHHdBB9A/ZxJzf7dD8wcVL6RBw3Vao29aOMR6yzSIROd/h4u8Y48B2NO5FVW2P7yxvIoWqs3JM4ZphLtrtMO0KeEGqsTPIfFuTDhYjgK0SWdT3uo7+HDfpd39gCx8GHUU1j245pWEZfvRjjbmikqkfoerm+yLY78r4ywlUcct6rRXQj3Pm5OKCylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwvLJafU8h1aikXEZx245ZoSn9J5lG1YwFUf5K1Vf+8=;
 b=kFakzNGoFF/k0yU8PNAbgZHdWc3k4Yme9MPp/HL+oB0SOHUu2XkHg3JAdXkWE6x4IQ8mIHrTH0zD3rHDwWmiIyKUp/ktCmirJGHBCK9ysvxhdQrr05j/+KnBDGCspGGQwDL5snz0iEoqynLkLYPhg/YRH/2uXnAYbQgQWjCz8gYbJAPT8dkbOmsUHSe6OfeOp0QduCaUr+4cZEJ7wydSxMwpJXkqsW+DfCBJlZRLiN8wBeYCFnJT0ezCDMEh1xBWf3oBODcClcsk6t0DeE86ereDVHjfOG5IhdqCMYn9QAYyAvtY9akO2lXbFzQ85laYyVgNvY/NjfXf+JMCTUcMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 22:11:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Wed, 23 Apr 2025
 22:11:07 +0000
Message-ID: <d554487a-a328-42af-8dc3-16dcac127663@intel.com>
Date: Wed, 23 Apr 2025 15:10:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code
To: Michael Chan <michael.chan@broadcom.com>, Arnd Bergmann <arnd@kernel.org>
CC: Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, "Andy
 Gospodarek" <andrew.gospodarek@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
	Somnath Kotur <somnath.kotur@broadcom.com>, Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250423162827.2189658-1-arnd@kernel.org>
 <CACKFLimF7defCWyxtRs1x+jtSD7O-+nBq+tQHUMpQ8GK=48tWA@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CACKFLimF7defCWyxtRs1x+jtSD7O-+nBq+tQHUMpQ8GK=48tWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 48adb211-6062-478d-4025-08dd82b3bf02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDhHZkcwWFY4UFFIQ21nbDV6NkFnZVNMNzNYNHAyN1dIem1ObG9NNDNPVkpr?=
 =?utf-8?B?YVFaNTMzckxLb3ZLbDN6Z3R5WEFqNUJHY0orZHZUUWg0Z3RqOWxzODRzQmVI?=
 =?utf-8?B?RDlmYXBYSE1Fd0JJS0E4Wk5qZ3VPQ2RXQ2QzREg2L2gwZ2FzVUM0U1RVV2xX?=
 =?utf-8?B?TFllMFgrSTN4b25LU0xBaU1aTTQwdldHTHlWUkZJVFFDcHF5UTlyME1vTVRa?=
 =?utf-8?B?NG5nVHMvNTV2ZW1Ydm1DM2h5eHU2b1pMeXBoRU9sVDE5NXRIR283cUM5ZFBJ?=
 =?utf-8?B?MGRaUElvNmp5TVlkSERYU1ZQUS83THIyZjhNc21kYVY0KzcrL0F6RFEyeVJJ?=
 =?utf-8?B?TE9wNXRDZjBMRGErdC9hVHNvRk5sOTRrcENReXZkRjc2MXpZRGhUd2lqWEFn?=
 =?utf-8?B?S3NLbCs5dzl0UWo1UzNJSnVDOEx4MlNFT1hlQTY5dTVMWDgwZklwY201amN1?=
 =?utf-8?B?NUpRN0czTGp1V21MakJmTk5XMTdpRU9aOGJSa3BaM3MyRWhiTjgxQ2c0U2M2?=
 =?utf-8?B?QWFqQXRUbDlDQ0xGUzY5cFFvYldiU0VlMjJYN1V1OENCMGZHRVEzVmFOcUFI?=
 =?utf-8?B?aVpORm96emcvRllMVEtPbUs0R3p6NUJsMDR2T090UnZ2OHdLRU96MU0yWjVD?=
 =?utf-8?B?NEcrbzJYMGFFdVlLbG1XazNUbTQwZmV4V244ZFlid0liWlh0YkdlQ3pXdXpx?=
 =?utf-8?B?Zlp1U096VGt4YU5iOHpSaEd1RmZraGZhNHllcWlPZkhkSElndlZNQVRQRTV2?=
 =?utf-8?B?RFUrY09mdEJQdzNQRnZxbkdHK0dnUHMvbzdZdCtlKzg3N3l6cVcrZ29IaFhP?=
 =?utf-8?B?MjAvaVp0ZXk1b3Qzd24zb0w0TkgxNUI3eFh3cXlvck9sQy9vQVI1c0lJd2lz?=
 =?utf-8?B?R29VRE1aMjdRL2Z0ek5PcWZpRHUzajhpc0VxN2dCUWhyeDVPc0tMSFhOQlps?=
 =?utf-8?B?NXpHSDhBYVNMMzNyMFhlVnk1SWpVVnBjSW5hcENSeVU1aVVNWEhSTTZsZk0w?=
 =?utf-8?B?UlFscWU3OWx0WUg2TmRHU3FCcHpDMjdPVjEzZTM2UFk4Q1M3bzJmZUwrT09R?=
 =?utf-8?B?dUtYdEs3MTdaS2paSmpoUU9tNDNQTHRubDRmSmdhY3VEbDhkcUVOWE1xSU1E?=
 =?utf-8?B?aXFIUW5MVzVLeEZ6V3lmZWFVdy9zdmZqK0pRdHNVVVdRRkh6R0d5VW5CT0dY?=
 =?utf-8?B?RVgwMzNJZGZ1RU44L1hpTWE1MlZKNUJ5N1VlSDI3a2UyWkQyZmpqUWJRV1JL?=
 =?utf-8?B?cnpTR2xGRXdlSUtLZVY4MHU4RWpNWFJiY2JwYi81RHQ0S3R0bEJzRkFmUXF2?=
 =?utf-8?B?M3FuSzk0TVBETFc1T1kwbFFwbkhYLy9TRGZhS1U3WVJralQzSGppb25nUHNV?=
 =?utf-8?B?UHNkQ1JFMVErMHFBYmtOZGg5cndYQ0l3ZkxlOGx4RzByRzRNdnNyUWkvNGJJ?=
 =?utf-8?B?VC8vdWRJbFBVYk16VG8xTktHYm1sSmlLS3N5RmJhVldNaldibSsvZjhoWjA3?=
 =?utf-8?B?bmpPQjRRMzVEWmc3dC9WS0hCYnlQQ1AzSTFqSUlDd0g4eGdCSlc1MGZPMm1M?=
 =?utf-8?B?azg0NVJSWFZZL3RKZCs5Q3Q0TXpNeGthTTM4RTFKemxBL2NBSFNsSmJCeTZw?=
 =?utf-8?B?dXA2d3BCTVFHZzIrUytnL1dNTmFPK1Z0djhTbkFEWFFOVU1XOTFiUnA2d3Nm?=
 =?utf-8?B?a3cxMUdTTklkb2o3eStwaUVac2dObUJGdmhKWURhT2ltQlhxME5GaHN4Witr?=
 =?utf-8?B?VzluMGM4MmpCU1hkNEhhK3JYazE5d3pxVHdhTHBUQWw5TUVVZDVYbWpSRzZh?=
 =?utf-8?B?VkZnSW9mRDg1Y0w2K1h1Wks1QU9CQlpEWmVzYjhxL1hZUGpXTEROR2x5b1JB?=
 =?utf-8?B?MngwZXVhcEZlZjRUaGZTei82elhiZXJyelQyL25KRUlEZTJGS2o0bU00VUtS?=
 =?utf-8?Q?ukBY2quLvXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlIZmEwMkNkTGJaYW1yRFFFamZUOGZvaUttbEFxclIrWHVuemdrMHdFSHBV?=
 =?utf-8?B?aHhBc0dETW1WUjZOelBqZmdlTW1sTWNyZWhzWHErWHB4U21ZTFNmSzU1aUNm?=
 =?utf-8?B?b2ZvN0lYanBTTGtXMjZISUhIV1NSNitWMU42Ty9nYzUrSEhxWCsvRHYyZVp4?=
 =?utf-8?B?dnEyUkJuSHp6MVUxYnRVdEJYYWNpUXEvQkZxbTYwa0g0c1IrZTQ2U0U5R0Vs?=
 =?utf-8?B?UnczT0pGVjYrTmlhUkFtNjdIUVJ4NGZsT2pkdGlJOXRJM3NmdXZEK3BzblBV?=
 =?utf-8?B?UGJTOWw0WVpzTVg5YWlaMWsxU0NGcVZuNXdYUGlTZ3NPdStyYTB0cGN3ODN5?=
 =?utf-8?B?ZUdIWis5M21BOGR0TXB0ekJVbVYxakxIQlY2d0dUTWx0cUIvM3BuTEdEVjRT?=
 =?utf-8?B?Ym13OTFYaWduY3UvRGNjdExZL250K3RpN3NETGJ0cEh5K2ZaRkl6bWZrdzEz?=
 =?utf-8?B?eHhzdm9mODdRTnQ1K2NKOGhEK1R5cWVLU3FBalBJb3FkY2hlUTYvOWV5b0h0?=
 =?utf-8?B?UXdBMWRpUmkvandrMWk1c0czLzl0bFdjT1JqZWhkQWpPZmZ4amlUQU5qZ3Fx?=
 =?utf-8?B?ZzJlNXlaUTZUVjhvdjhKTUo5Qmd0Zm5PUzMzVmRsMy85YVJNRytadis2U1dL?=
 =?utf-8?B?WGdlNmRPM29ad0xvY25mdnVFYlZXWUVXdlZ4N1pUbENaSkpJaVcxakRjTkJK?=
 =?utf-8?B?ckJzc2V2bTZad3pyM3R4Mm9aVlY5Mlg0WUJhQjRaOXNwYXhBUEp6c2lkSFlZ?=
 =?utf-8?B?RGdIYmhONTBEWitVYW41Y3FZWlNQZm04REpVbEZyQ01seTRtbTcrZFA2OFda?=
 =?utf-8?B?d1gzRi96dy9ZUlNWN1FZTDFoSk4yaG5odjBDYkhyOS9vTG1OSW0zdDFnR1hT?=
 =?utf-8?B?K3o1bUZNS0J1YXVIS2F0ei9IYTVHQzBoRHZaNlNhVWovR1Z4VWtnTUZKT1NC?=
 =?utf-8?B?djlRQW9mZ1hvSEk3RGlFK3Z0VWhyMU1qUmtQeXhOaXlaN2Z2VGtzcFloNU8r?=
 =?utf-8?B?V2pWbDRzUHFjKytUOXJYM1MrMGhkMTN1Mm5Na2tBSmkwVlY0eGhISnpodDFX?=
 =?utf-8?B?T2pXMFUxZFE1TDNyTXBNTlZyc3dqTnMzUUNpbGg4ZGswMEdBM214OGQzUzBo?=
 =?utf-8?B?dFRjaXAycUZoVWROSWhjNEdLa0NyY2VkclVuV25FZm8xREVHMGc3YmpBazhs?=
 =?utf-8?B?U3lwOC9WM3UxOEp4U3BOZnVvbUJ3UGg2OS9lNnNxdXJKL3pFYlZmTlZiTENN?=
 =?utf-8?B?b29lT1IwUzVTcVByRHlmaWN0djc3Z2Rlb0VRUnVGK3EzRWlyUGpmSkpkT2d0?=
 =?utf-8?B?K0EzeXgyTGNuRStXRVF4RmpCZUFraXFyZXdvK0ZYYmRKelZjeElhK1NRM0Ry?=
 =?utf-8?B?YzRUQlVXdnk2RVZ2Vm5QOFhyZndpNVAwRDBickVVaDcvQzVzRm80TU9QRWFt?=
 =?utf-8?B?REFiYkh6RGVVQVg2SGViMXpKNTZ2VVJuODdTVkl5R1Q4MG9MNmtnVXVvTk43?=
 =?utf-8?B?SDJ6WVplRHYwNUdha3R5OVNjVThaVnFxQU1SSU9YT3IrTENaNUFubWhBN0Y1?=
 =?utf-8?B?dXNzcXJSQmJmZ1RrdVBFTVZJazRDdHZPWnh0Vk96dlRBVEZDaXl6dlhGZTlz?=
 =?utf-8?B?NXozTG4wdWpVR0lxUU1OVm4xZUM5d2Z6ZW5XUmlOa3J0SmMrMk53bG1Wempo?=
 =?utf-8?B?VVpWT2JOQUpKbnM2UGJ5VDBLQXBLNXN3WTVzRlhrVGFTcURkNHRLOG9HYldI?=
 =?utf-8?B?amthU1FnZXYvanNQeE5WMjBtOFRtNmE1aGJJR00ra1YwZmRZODJROEZEQ0px?=
 =?utf-8?B?S20rd3E1UlY0TllYS3gvcDNzdEUrK05jQ2FZcHd3VFBSd1ZZek0xeXdzbDVz?=
 =?utf-8?B?MzRWWUErKzVGR3FVbjg0WFdONUJxVVlyVTZManBFVXFHcVJ0UzhSQnVBMFlC?=
 =?utf-8?B?aXVlYjFXUTJ2RGpWejMzV3ZwVXdMcURFQThmUlBsSE9heTBRUElwKzJvUWV1?=
 =?utf-8?B?S0ZWd3hkMUFGK3NqQ3FHQlBFUm9MSVdNR3VkNE1rWXNtRXRwdTlkZGNLMXdi?=
 =?utf-8?B?RWRGY08ydVZHVjZKYkVjNllid2Mxam8xT1FWak5oUWtRR1lkK1FPbUorUWQ4?=
 =?utf-8?B?Uy9pZ1d0MVpBUjhwWGNaU0pxWG5kQytUZE8rMjBtUEM2cWVabDRDWnd0bEhJ?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48adb211-6062-478d-4025-08dd82b3bf02
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 22:11:07.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+6REk2aCAHl3YmebAobWhXZuCoWUQHG4qKkch71YxfF7vgPd6z3X5OlnDEhmzTCuH9EkzPz3TD489+qRbDYijnHijNfblLglAR4HbSW9oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com



On 4/23/2025 10:28 AM, Michael Chan wrote:
> On Wed, Apr 23, 2025 at 9:28 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The CONFIG_DEFAULT_HUNG_TASK_TIMEOUT setting is only available when the
>> hung task detection is enabled, otherwise the code now produces a build
>> failure:
>>
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10188:21: error: use of undeclared identifier 'CONFIG_DEFAULT_HUNG_TASK_TIMEOUT'
>>  10188 |             max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {
>>
>> Enclose this warning logic in an #ifdef to ensure this builds.
>>
>> Fixes: 0fcad44a86bd ("bnxt_en: Change FW message timeout warning")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I also cannot think of a better way, so this looks fine to me.  Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

I ran into this just now, and this fixed compilation for me.

Tested-by: Jacob Keller <jacob.e.keller@intel.com>

