Return-Path: <netdev+bounces-158829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB64A136BB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F6C3A6616
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54401DA100;
	Thu, 16 Jan 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wo9SEuum"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2B198A29;
	Thu, 16 Jan 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020226; cv=fail; b=t1WdfNSqQXxcWMnZqYp2dAXygrL244MY2ej5a40OggD89sIBsuo+RfVrQFJ2Vz6JCQEDrsr5CzmYTMGCINc8uHPvMOb+4jvx2r0aZXqfYmS4MOnME2MWrFE73QQ1LjHtZxwqXVTQNThi5Bv2/RPxOVNs6Isp6hllVi5Aaw5hmv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020226; c=relaxed/simple;
	bh=+CI801OrhAAkwdmXhfVVhaVAFTlUulakNft1+9XcKz4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pluEVhE0+sh4qXSRIlzNmjfAM10WtKMShVu5fCBIWZjlSN4kA0qXO9pKHG6133f1z5c22EDd0/J17Nbnxl8KcxgJJxAmZkF6FGuKVCxu8YY1IdpgGETeX1My2ZlpymGDevvMp8X8LVSsP5Ma6rgoNrRWisyxQe2Qw0dXS/TzYHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wo9SEuum; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737020224; x=1768556224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+CI801OrhAAkwdmXhfVVhaVAFTlUulakNft1+9XcKz4=;
  b=Wo9SEuumgYdNds+4H6rqNYbUCzQ8uy7pyM/q14MzevC2mfSjV+I1zGnO
   mFJH2D/na1zjUIH173+AF/jmLuvXGBCkrvdeXo6g7u23aZYO9moPKz5bz
   KCzyN0SBWWC6P5SpS/KCckFbRD5Ggcd36NXWQJSx2wTPianveJ2dOSMAD
   V9Wr3bV/LdjLJmOMzDNaqkJcs8n/EhcYxrLQpt54+bpC7p5IYvZ2JMkFs
   GLCA+HGsurZwaaA6KpRTJjoYaZmPzrO6/8QJ75joK4XpGKqYbnS+WVZLc
   yRJk2opghZ3OlpBuu0mrEuIBCshUJB7fTPO6vA3rJsa5En9bgKAIb1E+o
   g==;
X-CSE-ConnectionGUID: bWcj0aAFTWe1vpgew2QI8w==
X-CSE-MsgGUID: d+av/nX8Rl67dT6S/Lqa0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48053761"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48053761"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 01:37:02 -0800
X-CSE-ConnectionGUID: DGRNlyViRFuEJOhxba0ugQ==
X-CSE-MsgGUID: DBaC9BUXT5So9SXmv1dbZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109465714"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 01:36:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 01:36:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 01:36:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 01:36:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7ACT+ZJWBeLqdXOH2bOMbZU+iqsMm9Q5ZB3fGJxWcbX/vJVxsQKsh7yYBd1m/lNl/eTIOHVUjXWQrDXIyWHVoFecYC/cIoRFr50nsc4Qu8hl7XNybJI3UUOwA7mAG5TGjWZ66hmE8YGrs+jrkX2KmqQs10anUGC0l+Nj7N3V6eL8B9A0f6qiqDEpsfJYh0zk+aLPIWwkCvuyVUgMNEV9F0Fj0Xm9ux9HMqn+8r8UfNRzhDNHN2o5eXK1W5KK//30r6MeFQ3ASVEfWZV+hri7+vEB8KlmCIvpXuTqxOvptZez3dF4eI7kQP62HNbsddl2eIROzcH476Be0+kAWRaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+SXs4tozkyRrawxJHHNDO4Mxe3KbA2PiUSLIkJrqa0=;
 b=Bki46tPQMwrkNNG0Pr620oCQ8pQjmuk8x4htKPaLicC/EFPK0DlZ1NLjfog3OH+EfNpSaTlXWKP+u/I+cLjY4klJWCubTW9HEkXUI1CQwrHONHPxnlLBIV+qe7X+nExr96ZF+in3t+CeVqntMGLM0KJeWf5UrVzZ99Y2e6b/3Yvty0Cpsd6WKrgIk/XAglOdeD1wzGoPx9rYYBn3JGCrBRkX+81WFHjCqbPzw2eC3GskEC5/bZ/aGlHqsLv1eo5OJgwpalIG/DhyNA+wD52cp9jiIABVG6qmKnuGzoAABZDwQbYBFJHWFwBq7EAx31P3jAJbQVFYykeNwhYswEzHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 09:36:20 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 09:36:19 +0000
Message-ID: <3bc8a815-96c3-46cd-ae87-b46b61648bca@intel.com>
Date: Thu, 16 Jan 2025 10:36:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v04 1/1] hinic3: module initialization and tx/rx
 logic
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Suman Ghosh <sumang@marvell.com>
References: <cover.1737013558.git.gur.stavi@huawei.com>
 <992e332acb3743df9898eebba05934c2775862b5.1737013558.git.gur.stavi@huawei.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <992e332acb3743df9898eebba05934c2775862b5.1737013558.git.gur.stavi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0066.eurprd02.prod.outlook.com
 (2603:10a6:802:14::37) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: a01179ce-0c6f-4089-b1de-08dd36113b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjdyTGRnZTZNRkxZYTZldkhzYVNYSlJ0NjYzYjZGblE2aUxJOUJKTzg4eEQv?=
 =?utf-8?B?YWFUMXQzMVZtUEpZREg0Mm5Tajd4bU1BYlZxM0JrbE5zd2huNmR0Z0RLUmtP?=
 =?utf-8?B?QlV1blVTVGFVbDVrTDZOTVFGSktFK2ljY2lVL3lqQ0oyaU95RTk2Y3gwQ0JY?=
 =?utf-8?B?RHNFUUJDNDdFTU9ZZ1NDK1RBU0VpdGFlWVU1VVN5K29KM0pEbURvajhocUJO?=
 =?utf-8?B?NlNINEZVcVQrTXhSVEtaMnhiTm1NWllTYVZDcE5RRFJOK282T3d1eTlRUzUw?=
 =?utf-8?B?UUJqN25mQVkyMnNqN1hzbzU2eEk1VDBxUkh0L2hFNUxuc1U1dDVqR1dGbmlY?=
 =?utf-8?B?cEdwTzZHVGdBbi9QOHhJMnFIeGZnQjZ4UkJtL2N3cndWbVBPM3NxdU1DdEQy?=
 =?utf-8?B?UEVVUUZGalhiMVZvMDUxenlBcGRmTXNyQ2Z5V3h4OEhJTG1ZKzFUN2lOUURp?=
 =?utf-8?B?cUtjY2FhMnFDUjdzWGxlMTJTbU8zN2huaU02WnpXOEpUVXdMSVkrL25VdVNk?=
 =?utf-8?B?eU80TTVSaW5TN0YrRHlGdis5eTluWlptNXE5bHZ2Q2V2M0hyWHRNUU5tSVhE?=
 =?utf-8?B?VEIzdEFrWlA4QmhVNDNwZjRiYUtqSDJFOTBiWUIydjgxZmJvTmdGK1p0ZlJ6?=
 =?utf-8?B?OEl0VUpORWRodFlVV0Uyd1VJRUIrbFBNTXFCeFlwVE5XVWVkbkY3azBqMHVy?=
 =?utf-8?B?bTAzR2RHU2FLOTQvTjJHd3FWeVo1VDdiVXpKSys0YWZnYnpwMkZuOUp1SmJG?=
 =?utf-8?B?akNraVlvYmpTaWNBd2xpQytBSEgrbjU5UnZhazBZZFB2N1U5MXQrUDFLUG5L?=
 =?utf-8?B?djYvSExwYTlSSFFrSENQY20yU2lkbjBHbjUyTmpVZ00rRU1JRFpoOS94NDgx?=
 =?utf-8?B?YmtndjJUUmVoL01yQjNmZFhLY3d4cktoaDFIY215QkhkdVM3U3lsWVU2enNM?=
 =?utf-8?B?NWJUNWtERXJZQitLTEZ1Q1UzbEdCYVQ4V3BGaEg3Rm5Xa25JS1lPYjM2cDRu?=
 =?utf-8?B?TkxtK2NDQXZjZDBvcjFKWmdWTm5QdGR4NUw2Y3ZoaHRjOFFSNi9lZXNBcDRZ?=
 =?utf-8?B?ZWpnMWJ5bzNEcjdWeWN4dzB1YlQ0NVZvYWpkaWVHZkh1TnFRTXZzZHRBbVo2?=
 =?utf-8?B?bE16dmdxcWlXVFdYTXFxVEx5OGlxNUswUFJJcUpCM2kzV1lpT094UncrUC9X?=
 =?utf-8?B?U1dHNEwvUU5iVVl1T01FaWVnWjU4Sk1PWUxGbVRkSU1qNnMyd3dUYTZkYm84?=
 =?utf-8?B?d2ZySlNVM3JEWmxjRmVOT3lMQ09TTmJoT0JJYjVNZ1RMWnhFQ3Rvc2ppbDhx?=
 =?utf-8?B?M1Fia2hFTlM0dHRxdXZDVWlNV2c5VXRoZnh6bmdPWVk1TXBZZUxzcCsrcGhz?=
 =?utf-8?B?WGlveGFRVUltSEI3Z0Q4VnQxaktaMzZnUVpoOTJvMFg5dlI3WHN5azZvall2?=
 =?utf-8?B?d2RaMEs1Tk9QZnNYcDlteDMwVGMraUhNSEN6K2h5ZnIrc1F0aHFUaFBtNk9a?=
 =?utf-8?B?RXB4MTc0K08zTkNuNS9wYVhXVmVRT251NjJGM3RxaVN0b21lbWxvSnpBL2tH?=
 =?utf-8?B?ZW9pTHgyd0hMOHJUSU5QL3FnUENncGdabmlmK1l4YXVFbDhwSnFSNklBLzU3?=
 =?utf-8?B?WUgxc0plUEdHVVNJSlg0REFReHUrWlpKbmt6OUJsSWlrMUVWYlhYdXR0QXZo?=
 =?utf-8?B?dXpVVWkxUW02dGsvRDkrY1NwSExmak1PZFFnUHRGcldMcGhEQmMxUktDRHFX?=
 =?utf-8?B?OEgvdlZpcVpzc0NON0luTVp4NmpiNW1IY0dMS1N3b21FZ2R5K2RmWlZLYysw?=
 =?utf-8?B?aGNkSTQwOCt3QTMya3h0N2J4eXl2SXVrRHNXZlJnNGU4NTAyUXJCazU3QTUz?=
 =?utf-8?Q?7eP/6BsszqM46?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZQK0htcHpBNmRsLzR2K1lhOUU2U2ROU2x3R0x1bXdXU1NyRlVHV1llOW1N?=
 =?utf-8?B?VXVINlo5dldrL3dEWWV4WW5YUFM4dUZ5b0ZodXZPemJUZmNZL3o0U0Y3VFNU?=
 =?utf-8?B?YUxtd0pSbHBCbFdzeUdNY2dDZXVzRjc5V3IyWWx2bVpVMDNDd003YWRUMkpl?=
 =?utf-8?B?MGpkeDNjcG1IdjFLQk5UWDdnbkJpUHQ5WDd2U1FUVFhpUDA1VFZhcWIzMUFa?=
 =?utf-8?B?TlEwdU9oOURnM0dlT0JFOUpZbTdSV25lNm5TUzhGeWhtelA3a3ArUXB6WVB1?=
 =?utf-8?B?c2FKWW5BaHl4ek90eVNnTGt4c3BLeWU5WVNuTWtCYjNkSklEd05EWXpiOGpK?=
 =?utf-8?B?MFptangxV3hRbnR5amFxcnJvbDNoelREQi9KenB3czRBdGlTdk9Vajk2TFh0?=
 =?utf-8?B?YWJGOE9KRGNrRU1pRHRFblU1LzUyN1RBSXlTVlFBai9COFlvTG1HdW5lL2xC?=
 =?utf-8?B?YXFVVUx1MEVNQ3RwVGlLQ2ZMdkZWMnZvNzhJZElQbnRZcHJoR1crQ2RFd1hX?=
 =?utf-8?B?OXJKOWhZQysvb1laTDl0MWVlVnhtNXJFd041N2xqYXF0ZnR4SlhHYWliaDNY?=
 =?utf-8?B?cjFhTTJHVWhlOTlnOGYyUC9DbllKZEFWNHc3SERGVE1wYVhMSmJEQ0lobGJn?=
 =?utf-8?B?WEJybDBRU0xTZkdqYjdlU3Z6UDUwUlk1NVhVMWQxaHNrQkFqM3NObzN2VHU3?=
 =?utf-8?B?dU1RNkllUkpLdHlSdld1bGUwR2p5NjZERks4a2U1YUJTaXo4Tnpmclh6QWs3?=
 =?utf-8?B?elc5MFlVcU1wbit5elRPSG5uVjE2MTgzQi9vQS9GNUoya2xyeGd0ZUs2S1JP?=
 =?utf-8?B?eElvVlZZUERyOUZJL0FvSlRvNnFIQU94Q0dhSTBUMzFhNWZhZWdqRTVnRFFN?=
 =?utf-8?B?VlFQd3E2MmF2Rys2U3dTU3F0RThkcDRadnhZei9pVVFpVjd4eXJkb1BITE8r?=
 =?utf-8?B?VGZpZUxueVZkaEY5YjF6WldjYmJHdFZTNFlqYkZtNUNvODFLZUQvd1JYRWwr?=
 =?utf-8?B?MDNWOHZjYTZCTTBpK1RzZ3N1VU9Fbm52VHVsQ2NjR3JSbDhPTU5oTmVSenZu?=
 =?utf-8?B?bng5Zitkb1lWSEl6VGEyL3hQbnd5MXJVaWYvZ0ZLc0F1MFdFUGJpOEFIc0lI?=
 =?utf-8?B?c2VOZXZYTnRqVVY3ZDUvYVlyRmh6bzlSU3paaXdqckt4d0JzcUcyOTVPbVI4?=
 =?utf-8?B?YVJldXU4bE96eGZMSHU5Q2E4dCs0enNJUy9JbnoxUWVXbElGbGE0VVg2eWVD?=
 =?utf-8?B?N2ZiYjNDaFFVNWJWVE5xZEpYeXFOT1E4TTJBU3lGTFZJVHcxZFFabEJQTXh6?=
 =?utf-8?B?WkNpNWQ3YStVMlU4T2hmeHhGUzB0bFJTWU4zK0ovblhUQks4Wk1aM2NQTUZK?=
 =?utf-8?B?ZnZXQTc4akdYcmRRRG9TZ2xqMFBSVlE2VDYvYW42S2FCYmFLaWpRb3k2WjZp?=
 =?utf-8?B?MXdtOWhDZDNIUDhoQUE1TnlyR3h1MGJXcGtuQnkrS283UkZYTUFqYnpRSmZT?=
 =?utf-8?B?WkIzeHFOY0RaSU1Id0cvL0lTU1pFeDdGaU5MdnlKcklmc0NJc0NLbmpkY083?=
 =?utf-8?B?VFkzcHNtZTFiUFkxbDJSUGpGY2dJaDYzTXFUYzV5RzEyNjErTDhMTUF2Z3NN?=
 =?utf-8?B?SE1UOHhNRnkzajRpV1ZzTWpuQ0FBalpyOVpaTHNPUUNMYWdnQVV2cGZSY3k1?=
 =?utf-8?B?ZmYvckdUUXdaOHJaQXdLSThNQUN1dU1ISnZEZmtBaENmR3VIZzU0U2I1aDZX?=
 =?utf-8?B?UkVXRFAwYXE4MFIwRkZHSjdKZ1p2Z0N6cUJQc0hsOStnNkQrWlBuSTlaV2dZ?=
 =?utf-8?B?RFlITzloRHVkbEVmTmRJSHIyN3lyTzh2R0pxTVJkbGVRd1pvTUZET2lqZ3ph?=
 =?utf-8?B?ek9EUGxPam5pYnZrQzYwRXFySHlra0lOa3dnZWxVby9JK1R5cGVFTkZVRk9w?=
 =?utf-8?B?aS85elpaK0pSTUo3R1V4QXhoMzNOMTg2azcwT3RKNFR0KzlyNnVTVXRpMWpY?=
 =?utf-8?B?NUJjTko4b1NsQk9ReVpzckVMc3dmYkl5amxwQk5DNGx3UG1jT2lFMzdjcW4x?=
 =?utf-8?B?NzZKMTFFdDZCSWl0RndkZ3AyVmFuSVlsb0h3TktzSFlMVHFJaCtnTHNCdm9z?=
 =?utf-8?B?d204THU5OEpLWVFXTEp5aW5KYkhDUG9hUDliUmFzMGszMWpLTmpDSFErejB6?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a01179ce-0c6f-4089-b1de-08dd36113b5a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 09:36:19.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW6xpRd6hnDYYC1UjuleN/3f32GwT6LaLT6yMZ9GM0Ffu7SkGDRmUsFXpt/rOQjZ57FAQtcXoSNZFcFiQNGm7NhOQVBSTkFjiw2TuvmUNzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com

On 1/16/25 08:51, Gur Stavi wrote:
> From: gongfan <gongfan1@huawei.com>
> 
> This is [1/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 is a valid kernel module but non-functional
> driver.

not very impressive for 3.8k new lines

please split it into more patches, say it should take at most an hour
to read a single patch

You should also explain (in the cover letter) how different is this
device from your previous generations, and in general you should strive
to deduplicate the code.

> 
> The driver parts contained in this patch:
> Module initialization.
> PCI driver registration but with empty id_table.

you have PCI IDs in the doc, why to not put them in the actual
code? This driver should be loaded by you on your "pre market" HW.

> Auxiliary driver registration.
> Net device_ops registration but open/stop are empty stubs.
> tx/rx logic.

Take care for spelling: Tx/Rx; HW (just below).

> 
> All major data structures of the driver are fully introduced with the
> code that uses them but without their initialization code that requires
> management interface with the hw.
> 
> Submitted-by: Gur Stavi <gur.stavi@huawei.com>

this tag is not needed

> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>

your tag should be last

> Signed-off-by: Xin Guo <guoxin09@huawei.com>

no idea what Xin did, if you want to give credit to someone
you could use Co-developed-by: tag (put it just above the SoB)

> Signed-off-by: gongfan <gongfan1@huawei.com>

It would be much appricieated if you will spell the full name
for gongfan, at least two parts (like you did for the rest),
especially for someone you put into the MAINTAINERS file.
OTOH, please keep in mind that maintainer should be active
on the mailing list (regarding this driver).

> ---
>   .../device_drivers/ethernet/huawei/hinic3.rst | 137 ++++
>   MAINTAINERS                                   |   7 +
>   drivers/net/ethernet/huawei/Kconfig           |   1 +
>   drivers/net/ethernet/huawei/Makefile          |   1 +
>   drivers/net/ethernet/huawei/hinic3/Kconfig    |  18 +
>   drivers/net/ethernet/huawei/hinic3/Makefile   |  21 +
>   .../ethernet/huawei/hinic3/hinic3_common.c    |  53 ++
>   .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
>   .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  30 +
>   .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  58 ++
>   .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  37 +
>   .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
>   .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  88 +++
>   .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  24 +
>   .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  82 +++
>   .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  15 +
>   .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  50 ++
>   .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 416 +++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_lld.h   |  21 +
>   .../net/ethernet/huawei/hinic3/hinic3_main.c  | 418 +++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  17 +
>   .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  16 +
>   .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  13 +
>   .../huawei/hinic3/hinic3_mgmt_interface.h     | 111 +++
>   .../huawei/hinic3/hinic3_netdev_ops.c         |  77 ++
>   .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 254 +++++++
>   .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  45 ++
>   .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 100 +++
>   .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  21 +
>   .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 117 +++
>   .../huawei/hinic3/hinic3_queue_common.c       |  65 ++
>   .../huawei/hinic3/hinic3_queue_common.h       |  51 ++
>   .../net/ethernet/huawei/hinic3/hinic3_rss.c   |  24 +
>   .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  12 +
>   .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 401 ++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  91 +++
>   .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 692 ++++++++++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 129 ++++
>   .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  29 +
>   .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  75 ++
>   40 files changed, 3857 insertions(+)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
> new file mode 100644
> index 000000000000..fe4bd0aed85c
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
> @@ -0,0 +1,137 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================================================
> +Linux kernel driver for Huawei Ethernet Device Driver (hinic3) family
> +=====================================================================
> +
> +Overview
> +========
> +
> +The hinic3 is a network interface card (NIC) for Data Center. It supports
> +a range of link-speed devices (10GE, 25GE, 100GE, etc.). The hinic3
> +devices can have multiple physical forms (LOM NIC, PCIe standard NIC,
> +OCP NIC etc.).

please spell OCP out

> +
> +The hinic3 driver supports the following features:
> +- IPv4/IPv6 TCP/UDP checksum offload
> +- TSO (TCP Segmentation Offload), LRO (Large Receive Offload)
> +- RSS (Receive Side Scaling)
> +- MSI-X interrupt aggregation configuration and interrupt adaptation.
> +- SR-IOV (Single Root I/O Virtualization).
> +
> +Content
> +=======
> +
> +- Supported PCI vendor ID/device IDs
> +- Source Code Structure of Hinic3 Driver
> +- Management Interface
> +
> +Supported PCI vendor ID/device IDs
> +==================================
> +
> +19e5:0222 - hinic3 PF/PPF
> +19e5:375F - hinic3 VF
> +
> +Prime Physical Function (PPF) is responsible for the management of the
> +whole NIC card. For example, clock synchronization between the NIC and
> +the host. Any PF may serve as a PPF. The PPF is selected dynamically.
> +
> +Source Code Structure of Hinic3 Driver
> +======================================
> +
> +========================  ================================================
> +hinic3_pci_id_tbl.h       Supported device IDs
> +hinic3_hw_intf.h          Interface between HW and driver
> +hinic3_queue_common.[ch]  Common structures and methods for NIC queues
> +hinic3_common.[ch]        Encapsulation of memory operations in Linux
> +hinic3_csr.h              Register definitions in the BAR
> +hinic3_hwif.[ch]          Interface for BAR
> +hinic3_eqs.[ch]           Interface for AEQs and CEQs
> +hinic3_mbox.[ch]          Interface for mailbox
> +hinic3_mgmt.[ch]          Management interface based on mailbox and AEQ
> +hinic3_wq.[ch]            Work queue data structures and interface
> +hinic3_cmdq.[ch]          Command queue is used to post command to HW
> +hinic3_hwdev.[ch]         HW structures and methods abstractions
> +hinic3_lld.[ch]           Auxiliary driver adaptation layer
> +hinic3_hw_comm.[ch]       Interface for common HW operations
> +hinic3_mgmt_interface.h   Interface between firmware and driver
> +hinic3_hw_cfg.[ch]        Interface for HW configuration
> +hinic3_irq.c              Interrupt request
> +hinic3_netdev_ops.c       Operations registered to Linux kernel stack
> +hinic3_nic_dev.h          NIC structures and methods abstractions
> +hinic3_main.c             Main Linux kernel driver
> +hinic3_nic_cfg.[ch]       NIC service configuration
> +hinic3_nic_io.[ch]        Management plane interface for TX and RX
> +hinic3_rss.[ch]           Interface for Receive Side Scaling (RSS)
> +hinic3_rx.[ch]            Interface for transmit
> +hinic3_tx.[ch]            Interface for receive
> +hinic3_ethtool.c          Interface for ethtool operations (ops)
> +hinic3_filter.c           Interface for MAC address
> +========================  ================================================
> +
> +Management Interface
> +====================
> +
> +Asynchronous Event Queue (AEQ)
> +------------------------------
> +
> +AEQ receives high priority events from the HW over a descriptor queue.
> +Every descriptor is a fixed size of 64 bytes. AEQ can receive solicited or
> +unsolicited events. Every device, VF or PF, can have up to 4 AEQs.
> +Every AEQ is associated to a dedicated IRQ. AEQ can receive multiple types
> +of events, but in practice the hinic3 driver ignores all events except for
> +2 mailbox related events.
> +
> +Mailbox
> +-------
> +
> +Mailbox is a communication mechanism between the hinic3 driver and the HW.
> +Each device has an independent mailbox. Driver can use the mailbox to send
> +requests to management. Driver receives mailbox messages, such as responses
> +to requests, over the AEQ (using event HINIC3_AEQ_FOR_MBOX). Due to the
> +limited size of mailbox data register, mailbox messages are sent
> +segment-by-segment.
> +
> +Every device can use its mailbox to post request to firmware. The mailbox
> +can also be used to post requests and responses between the PF and its VFs.
> +
> +Completion Event Queue (CEQ)
> +--------------------------
> +
> +The implementation of CEQ is the same as AEQ. It receives completion events
> +from HW over a fixed size descriptor of 32 bits. Every device can have up
> +to 32 CEQs. Every CEQ has a dedicated IRQ. CEQ only receives solicited
> +events that are responses to requests from the driver. CEQ can receive
> +multiple types of events, but in practice the hinic3 driver ignores all
> +events except for HINIC3_CMDQ that represents completion of previously
> +posted commands on a cmdq.
> +
> +Command Queue (cmdq)
> +--------------------
> +
> +Every cmdq has a dedicated work queue on which commands are posted.
> +Commands on the work queue are fixed size descriptor of size 64 bytes.
> +Completion of a command will be indicated using ctrl bits in the
> +descriptor that carried the command. Notification of command completions
> +will also be provided via event on CEQ. Every device has 4 command queues
> +that are initialized as a set (called cmdqs), each with its own type.
> +Hinic3 driver only uses type HINIC3_CMDQ_SYNC.
> +
> +Work Queues(WQ)
> +---------------
> +

in kernel "work queues" are already a thing, would be good to avoid the
name clash

> +Work queues are logical arrays of fixed size WQEs. The array may be spread
> +over multiple non-contiguous pages using indirection table. Work queues are
> +used by I/O queues and command queues.
> +
> +Global function ID
> +------------------
> +
> +Every function, PF or VF, has a unique ordinal identification within the device.
> +Many commands to management (mbox or cmdq) contain this ID so HW can apply the

s/commands to management/management commands/

> +command effect to the right function.
> +
> +PF is allowed to post management commands to a subordinate VF by specifying the
> +VFs ID. A VF must provide its own ID. Anti-spoofing in the HW will cause
> +command from a VF to fail if it contains the wrong ID.
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a05cdb41d70..2d1aab4d6abd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10600,6 +10600,13 @@ S:	Maintained
>   F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
>   F:	drivers/net/ethernet/huawei/hinic/
>   
> +HUAWEI 3RD GEN ETHERNET DRIVER
> +M:	gongfan <gongfan1@huawei.com>

again, must be a real person, that participates on the list wrt the
driver, with a full name spelled out

> +L:	netdev@vger.kernel.org
> +S:	Supported

there is a (relatively new) requirement that the device needs to report
to the netdev CI to have an "S" here, so for now you should use "M"

> +F:	Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
> +F:	drivers/net/ethernet/huawei/hinic3/
> +
>   HUGETLB SUBSYSTEM
>   M:	Muchun Song <muchun.song@linux.dev>
>   L:	linux-mm@kvack.org
> diff --git a/drivers/net/ethernet/huawei/Kconfig b/drivers/net/ethernet/huawei/Kconfig
> index c05fce15eb51..7d0feb1da158 100644
> --- a/drivers/net/ethernet/huawei/Kconfig
> +++ b/drivers/net/ethernet/huawei/Kconfig
> @@ -16,5 +16,6 @@ config NET_VENDOR_HUAWEI
>   if NET_VENDOR_HUAWEI
>   
>   source "drivers/net/ethernet/huawei/hinic/Kconfig"
> +source "drivers/net/ethernet/huawei/hinic3/Kconfig"
>   
>   endif # NET_VENDOR_HUAWEI
> diff --git a/drivers/net/ethernet/huawei/Makefile b/drivers/net/ethernet/huawei/Makefile
> index 2549ad5afe6d..59865b882879 100644
> --- a/drivers/net/ethernet/huawei/Makefile
> +++ b/drivers/net/ethernet/huawei/Makefile
> @@ -4,3 +4,4 @@
>   #
>   
>   obj-$(CONFIG_HINIC) += hinic/
> +obj-$(CONFIG_HINIC3) += hinic3/
> diff --git a/drivers/net/ethernet/huawei/hinic3/Kconfig b/drivers/net/ethernet/huawei/hinic3/Kconfig
> new file mode 100644
> index 000000000000..274d161a6765
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Huawei driver configuration
> +#
> +
> +config HINIC3
> +	tristate "Huawei Intelligent Network Interface Card 3rd"

what do you mean by Intelligent?

> +	# Fields of HW and management structures are little endian and are
> +	# currently not converted
> +	depends on !CPU_BIG_ENDIAN
> +	depends on X86 || ARM64 || COMPILE_TEST
> +	depends on PCI_MSI && 64BIT
> +	select AUXILIARY_BUS
> +	help
> +	  This driver supports HiNIC PCIE Ethernet cards.
> +	  To compile this driver as part of the kernel, choose Y here.
> +	  If unsure, choose N.
> +	  The default is N.

the last 3 lines are very much obvious/redundant

> diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
> new file mode 100644
> index 000000000000..02656853f629
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.

too late

> +
> +obj-$(CONFIG_HINIC3) += hinic3.o
> +
> +hinic3-objs := hinic3_hwdev.o \
> +	       hinic3_lld.o \
> +	       hinic3_common.o \
> +	       hinic3_hwif.o \
> +	       hinic3_hw_cfg.o \
> +	       hinic3_queue_common.o \
> +	       hinic3_mbox.o \
> +	       hinic3_hw_comm.o \
> +	       hinic3_wq.o \
> +	       hinic3_nic_io.o \
> +	       hinic3_nic_cfg.o \
> +	       hinic3_tx.o \
> +	       hinic3_rx.o \
> +	       hinic3_netdev_ops.o \
> +	       hinic3_rss.o \
> +	       hinic3_main.o

in general, any list of random things could be sorted (to ease out git
merges in the future)

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
> new file mode 100644
> index 000000000000..d416a6a00a8b
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +
> +#include "hinic3_common.h"
> +
> +int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
> +				     gfp_t flag,
> +				     struct hinic3_dma_addr_align *mem_align)
> +{
> +	dma_addr_t paddr, align_paddr;
> +	void *vaddr, *align_vaddr;
> +	u32 real_size = size;
> +
> +	vaddr = dma_alloc_coherent(dev, real_size, &paddr, flag);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> +	align_paddr = ALIGN(paddr, align);
> +	if (align_paddr == paddr) {
> +		align_vaddr = vaddr;
> +		goto out;
> +	}
> +
> +	dma_free_coherent(dev, real_size, vaddr, paddr);
> +
> +	/* realloc memory for align */
> +	real_size = size + align;
> +	vaddr = dma_alloc_coherent(dev, real_size, &paddr, flag);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> +	align_paddr = ALIGN(paddr, align);
> +	align_vaddr = vaddr + (align_paddr - paddr);
> +
> +out:
> +	mem_align->real_size = real_size;
> +	mem_align->ori_vaddr = vaddr;
> +	mem_align->ori_paddr = paddr;
> +	mem_align->align_vaddr = align_vaddr;
> +	mem_align->align_paddr = align_paddr;
> +
> +	return 0;
> +}
> +
> +void hinic3_dma_free_coherent_align(struct device *dev,
> +				    struct hinic3_dma_addr_align *mem_align)
> +{
> +	dma_free_coherent(dev, mem_align->real_size,
> +			  mem_align->ori_vaddr, mem_align->ori_paddr);
> +}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
> new file mode 100644
> index 000000000000..f8ff768c20ca
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
> +
> +#ifndef HINIC3_COMMON_H
> +#define HINIC3_COMMON_H
> +
> +#include <linux/device.h>
> +
> +#define HINIC3_MIN_PAGE_SIZE  0x1000
> +
> +struct hinic3_dma_addr_align {
> +	u32        real_size;
> +
> +	void       *ori_vaddr;
> +	dma_addr_t ori_paddr;
> +
> +	void       *align_vaddr;
> +	dma_addr_t align_paddr;
> +};
> +
> +int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
> +				     gfp_t flag,
> +				     struct hinic3_dma_addr_align *mem_align);
> +void hinic3_dma_free_coherent_align(struct device *dev,
> +				    struct hinic3_dma_addr_align *mem_align);
> +
> +#endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
> new file mode 100644
> index 000000000000..ace2ad5c3b6b
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
> +
> +#include <linux/device.h>
> +
> +#include "hinic3_hw_cfg.h"
> +#include "hinic3_hwdev.h"
> +#include "hinic3_mbox.h"
> +#include "hinic3_hwif.h"
> +
> +#define IS_NIC_TYPE(hwdev) \

you have to prefix names of all of your types, macros, functions with
your driver

> +	(((u32)(hwdev)->cfg_mgmt->svc_cap.chip_svc_type) & BIT(HINIC3_SERVICE_T_NIC))
> +
> +bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
> +{
> +	if (!IS_NIC_TYPE(hwdev))
> +		return false;
> +
> +	return true;

this is just:
	return IS_NIC_TYPE(hwdev);

> +}
> +
> +u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev)
> +{
> +	return hwdev->cfg_mgmt->svc_cap.nic_cap.max_sqs;
> +}
> +
> +u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev)
> +{
> +	return hwdev->cfg_mgmt->svc_cap.port_id;
> +}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
> new file mode 100644
> index 000000000000..cef311b8f642
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
> +
> +#ifndef HINIC3_HW_CFG_H
> +#define HINIC3_HW_CFG_H
> +
> +#include <linux/mutex.h>
> +
> +struct hinic3_hwdev;
> +
> +struct irq_info {
> +	u16 msix_entry_idx;
> +	/* provided by OS */
> +	u32 irq_id;
> +};
> +
> +struct cfg_irq_alloc_info {
> +	bool                     allocated;

in general it is a good practice to don't introduce
holes into your structs when there is no reason to do so
(and reminder for the prefix in the struct names)

> +	struct irq_info          info;
> +};
> +
> +struct cfg_irq_info {
> +	struct cfg_irq_alloc_info *alloc_info;
> +	u16                       num_irq;
> +	/* device max irq number */
> +	u16                       num_irq_hw;
> +	/* protect irq alloc and free */
> +	struct mutex              irq_mutex;
> +};
> +
> +struct nic_service_cap {
> +	u16 max_sqs;
> +};
> +
> +/* device capability */
> +struct service_cap {
> +	/* HW supported service type, reference to service_bit_define */
> +	u16                    chip_svc_type;
> +	/* physical port */
> +	u8                     port_id;
> +	/* NIC capability */
> +	struct nic_service_cap nic_cap;
> +};
> +
> +struct cfg_mgmt_info {
> +	struct cfg_irq_info irq_info;
> +	struct service_cap  svc_cap;
> +};
> +
> +int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
> +		      struct irq_info *alloc_arr, u16 *act_num);
> +void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);
> +
> +bool hinic3_support_nic(struct hinic3_hwdev *hwdev);
> +u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev);
> +u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev);
> +
> +#endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> new file mode 100644
> index 000000000000..fc2efcfd22a1
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
> +
> +#include <linux/delay.h>
> +
> +#include "hinic3_hw_comm.h"
> +#include "hinic3_hwdev.h"
> +#include "hinic3_mbox.h"
> +#include "hinic3_hwif.h"
> +
> +static int comm_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd, const void *buf_in,
> +				 u32 in_size, void *buf_out, u32 *out_size)
> +{
> +	return hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_COMM, cmd, buf_in,
> +					in_size, buf_out, out_size, 0);
> +}
> +
> +int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
> +{
> +	struct comm_cmd_func_reset func_reset;

  = {}

> +	u32 out_size = sizeof(func_reset);
> +	int err;
> +
> +	memset(&func_reset, 0, sizeof(func_reset));

with "= {}" above, memset() could be eliminated

> +	func_reset.func_id = func_id;
> +	func_reset.reset_flag = reset_flag;

alternative would be
	struct comm_cmd_func_reset func_reset = {
		.func_id = func_id,
		.reset_flag = reset_flag,
	};

> +	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_FUNC_RESET,
> +				    &func_reset, sizeof(func_reset),
> +				    &func_reset, &out_size);

it's not typical to have a function that gets given pointer twice

> +	if (err || !out_size || func_reset.head.status) {
> +		dev_err(hwdev->dev, "Failed to reset func resources, reset_flag 0x%llx, err: %d, status: 0x%x, out_size: 0x%x\n",
> +			reset_flag, err, func_reset.head.status, out_size);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> new file mode 100644
> index 000000000000..cb60d7d7826d
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
> +
> +#ifndef HINIC3_HW_COMM_H
> +#define HINIC3_HW_COMM_H
> +
> +#include "hinic3_hw_intf.h"
> +
> +struct hinic3_hwdev;
> +
> +int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
> +
> +#endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
> new file mode 100644
> index 000000000000..8d5d55ab8365
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
> +
> +#ifndef HINIC3_HW_INTF_H

please add two underscores to the header guards

> +#define HINIC3_HW_INTF_H
> +
> +#include <linux/types.h>
> +#include <linux/bits.h>
> +

please sort the headers
please adhere to IWYU


> +
> +int hinic3_init_hwdev(struct pci_dev *pdev)
> +{
> +	/* Completed by later submission due to LoC limit. */
> +	return -EFAULT;

please split series into proper patches, and fill this out,
the driver should be able to tx/rx with the series applied



