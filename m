Return-Path: <netdev+bounces-165561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE8A32831
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B09164DE5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63542101AF;
	Wed, 12 Feb 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPQeZ68D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CD210192
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369737; cv=fail; b=uadArv5FrGCKno/sjhws4o/AGT09Nq/20EN6F1FmUxOux1WpgDMhCjauFRip2rsf0AxIQcUbqPWdlc8WMOnRNbovegF+7mKONk8YkWyjcDI8Jg6QFR1OAa5CfPybVYO6pXD1XT5gKnDrWIQrqbnvJ3YARJFDMaCXwyfJyxp04tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369737; c=relaxed/simple;
	bh=FpNmL7iP78mEZjAZ7drM3U4jTiczhsQcKoKUEmzrOco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QLIEmiPXX/dGXlEOsrzEgMJkHhTDC6lx29kaq18elczwLzsnyvKXFRzWLDv2M7MGBDhQhVabJdekLk+4KIbA3oup4c48SfmjulYrFRybcENWfFUZqYK71bxuSvtwp7VfOAyimkqGEfStI3pjOGi6BnA6xMNTPB492ROfQKT2Uj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPQeZ68D; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739369735; x=1770905735;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FpNmL7iP78mEZjAZ7drM3U4jTiczhsQcKoKUEmzrOco=;
  b=FPQeZ68DSYfQVInNg5XQXxpHnBuP+A1vPyT3QtGzCXQH/LW0VOJARDNt
   LC7ebQsII1mdFJxozmxVWt/mNFLw/UA3knqG0ODJUAHxp/TJ7zwJJqg4B
   0l7ZS5M9EoDED0+fKXf4DMNiByZ/M6XhF2MQew513O6+ckG9y/dCx3/yV
   Mb+D6aR3NuXoAiTvm7+t57MdV7wzg6mNBS3rxvFD/n+NZ+gmA2VSPIYQJ
   xFJgSilQyCFuEpkkKg0zmji72lCITahGylmTCco0XE5fCIGevh8h2MzPx
   o3lYtMiWA6703qi0y/v+j9+WYHNwppkwNKvSKCuzEXzr9lbKoM3sV1HYe
   g==;
X-CSE-ConnectionGUID: LsOSV5gWRmS0XbAIdexUdw==
X-CSE-MsgGUID: yas59jJBT2KdJAfT34gsDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39948700"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="39948700"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:15:35 -0800
X-CSE-ConnectionGUID: /jdDIks4TDeLx754MBNLTA==
X-CSE-MsgGUID: ighoKLRwQlSXqvX7mnRmDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="117918290"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 06:15:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 06:15:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 06:15:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 06:15:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmvDq7L3id6uH5TyHVoVz++4Gz0kYJcKyPC39scTPjCd/RLaW94SfOxezxGznQJ4SHpflvo5MLhhnX5O5J6wAPjUOzKztJwglN1P+S6suEM3U++7Ws4M8LfPykdRESTPXQu5/qdJicvooi8OYJu2VOopywN9WboX/Ln8rINhsc0DyF05GVy1EzckzePosXTWPpJ0pQtd53o5kyZk2fQ5yNBXQ3gwss+ZHORaSqxFGNuqanBCrJqrzxmA4LNZESLnQom49HbTlIDaQrHFNeiPeU5iT3PMNVy7J6F6toXbRMfoyvNo3UOHrDAMPbpYcZx8u8Q3BrVutujBDH312JAnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POzK9yrMxHmhzaFGq9eSDiCtmQCSSN3tDVXkpXdONj4=;
 b=t9XwxTOFqpZklcgkcu+JWeY2nq0DUkdGyYMpnsuqv7jrhqEr8nL9xPlJt9EIy+9gLK9rPwpSjkrBeQzEb+vVphyGHBIOCkM/rtPJykuWeEX3+PRRlxw+LAI53obJe3Tf3KkWiQElLI9v1t7iVlPlI/yemo2JtAKd+9AwoMiIxC5h4vUuAoISp2/bKXV/p+Xbw8V8OgCWFUTIjtwhZWwKg/D1P2565yCJLdwf0/rNFS9h9ZDpvP6CATFD1IAyTDe2epTkSl4OlexsB9x36Hqz9LvtRCKUfcgjunifZ+9rb8+HrOWEkNjR9P0FG383H0notBapaObtUnCgnIK/n56KQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 14:14:49 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 14:14:49 +0000
Message-ID: <1af7fa44-714d-4b0b-bcc8-1b92d966e603@intel.com>
Date: Wed, 12 Feb 2025 15:14:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ixgene-v2: prepare for phylib stop exporting
 phy_10_100_features_array
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
	<davem@davemloft.net>, Simon Horman <horms@kernel.org>, Iyappan Subramanian
	<iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <be356a21-5a1a-45b3-9407-3a97f3af4600@gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <be356a21-5a1a-45b3-9407-3a97f3af4600@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::10) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|CY8PR11MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: a2649ea7-eb61-49fe-1c2c-08dd4b6f9c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0wva09rLzBBbU1tSlZSOEYyV1BOMGxqNkxCcG1MRUJseXpmN0E1SkIrVWc0?=
 =?utf-8?B?VTc0QWRPUWhpSk5iSXBLeUhkUjFtVVFDRGdCNjhxNm92NG84aVA2ODA3bElt?=
 =?utf-8?B?YzB6d29FQWpXcmdwTU11L2tYbi9TR0NLTGY3NmhmZy9NVThwWkxEcEFzQTh3?=
 =?utf-8?B?MEtLRG13ZUNybUFGYU5ISnJjSTg4N0o4NzFMVUw1b3pneXExVUpva0VhMXRq?=
 =?utf-8?B?QjJmbzZHeEE3TFN6T1FYY3psVXB1UnkzWlJtcHV2Q2UxWmcraFlwb21sWHZX?=
 =?utf-8?B?clhKalFoRmM3RGZkSXVHUHdKeitrQnhQNzRwMzU4ZllaWXcrajErRnhFTG0z?=
 =?utf-8?B?b0x5R3craFhLTDJudHpua212N0RCVnY5RmVNZlJMbkk4Sm10U3BDOFN2dFBl?=
 =?utf-8?B?VVgzZ01oa0JuY0hnNlZucVlib0UvOGEvTUc1QTkwVG9GTmhLeEgwU2NReGhr?=
 =?utf-8?B?UGRrR2UxSUhxcEdhUmlETGNhMXU2dkJpVFlWMUFRam1OTndqU3pjc0RJc1Nu?=
 =?utf-8?B?di9DbVYyTS9tQjFqS1Z0UFIvQmdBdDl0RmxNSWtIMEYxankzU2hCOVFGQVRk?=
 =?utf-8?B?Zm1OanFzQkoxalEwdW9XcjRFRXVadGV0Wmw2V3R3REJOUWRYeFpleEFNMUJ2?=
 =?utf-8?B?MDdCV3Y5WXRQSWtDTlhxNmlKbXdSanpocXNiWGtaaWdReU1tcUcvS2hQcDUv?=
 =?utf-8?B?dmluUXNqRE5BM0tHSUhXdDJTUXdPZnFPOXVZN2NhZ3RSdHh4Uy9vbC9NS2Jo?=
 =?utf-8?B?SkRtUkxyRDlIczM1akZERDduaEhLSGsrNnp5MlFWalQzLzkxWllyNzlBeEUy?=
 =?utf-8?B?eTV2Q1ExbExVNUVzNGgycWZEV1NDb3UxMkZJajJnWjk1VzkwNXVrZWdra2sz?=
 =?utf-8?B?UWtEM0F3bUtENVZKRHhCenpTdjhnSVlld0xWQ2gwL1p3N3Z4QW5rRUdEaVlh?=
 =?utf-8?B?Unp2MXBQdXZsUzIycUdSMk9YclpjUFl4QUszc1MzNjRSWmtZR0NHSkhGOWx5?=
 =?utf-8?B?VlZZUG1vb0hqdFFZOG9HenlaWkhTb2ZFK3NiZ1hBbGRla0dHMW1pS0hVWFEv?=
 =?utf-8?B?cDBydjZSTVZkb3ZHL2N0bytBbE15WUVnSEVaWTJHOFZick9EcytmUDlpcklJ?=
 =?utf-8?B?TEg4bmV6NmJzV1VNQm4waXQvQkRGRW5pM3ZaMW1sTjJRN1Y5bnVMRnlNNGto?=
 =?utf-8?B?KzZ0SU1acEtXYVZEMFhhY05FYTBoWGIwQUhBUmtUMDhXeERCWWx6THVTZEF1?=
 =?utf-8?B?OG5WRkRhR1BiTTcvczFUT3FEVUFCdDdtaTNaTVhQWlN5UlUvZi8wclJFR2tE?=
 =?utf-8?B?SzVVaFAyaCtuQklKYnRZajRiNjJYZDZLTVNydzBraWIvSElmbnFkaklHZk1r?=
 =?utf-8?B?YnpUSithNXdzQzRoS0kwTHhoVXBVQW0vOEd2V0FxNDdQY2NydWZySTdXZkhR?=
 =?utf-8?B?UE1lWUpBVjgybkpTQ2hRbnB6dXZzNkZRSWQwdnB5SGl1bk9XakJ4SVZUUkZK?=
 =?utf-8?B?WGo1VDhHL25Sa1ZxTXVVaDdOVmJsMnF5UmRvMjU2Um9uZU1aeXp1dGIrSmRG?=
 =?utf-8?B?aTJJSUFldUpOMnp2MU9CbVhMcnpoY0I2cCs5dXY4c1hwRG51OE9LS2lDYlhU?=
 =?utf-8?B?UWlRdW1yTEZCVkk4VU5LZ0dSMUJNeTFSd20yTWQ2WWF2QVQzMVg1bS9vcExa?=
 =?utf-8?B?eHpQMHA0MUJRMmxPL2tVZkhzdzE3NWh4SXowbkRiVlM4ZTJOb3lQY0JrT3BQ?=
 =?utf-8?B?UldjWldNbFN2QmIrQUE0VkNTSEVNN1lSM252MWI1TkJqTHNUVnM1ZWN0THZR?=
 =?utf-8?B?eHJqZlNzY3NMUElDWmhiVXJRYlM5VHJGaXR3UTk3OEpCek9leXBRWmpwaDN5?=
 =?utf-8?Q?IOPb1y0w1b/Ge?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmwrcG5qM0txbm93c1A5SWdnYjF1LzFVdWh3VFpEaU56bFpEUGRpQWFpMHdu?=
 =?utf-8?B?TW5TamVXRFZyWkpVc2lZa1ZUQmJnN1JHN2lMVURlYkZIU0hEblNJbXlYb0Fq?=
 =?utf-8?B?YXJnZVYvV3ZLaVBxWS95a3ZKNGFHSWtiUWNoSlpYN0FFcWUyVElaVE9wWExz?=
 =?utf-8?B?M0J4YndLcUEzZFpHcjYzckRJcWdQNVc0MzlyUlpXbUNDZGc5aGd1eWxJUWtw?=
 =?utf-8?B?MTYyN1hMNXlyV05QQVhKZE5MRUx0MzFycHVjMC9mL1dpNXJQd2c4Rmx5K1dI?=
 =?utf-8?B?L1gxYnc4V2Z3cktzcjB2M2pKNW1LZkljMzJ0Ny9YK0d0YWVaRHdldUtIclBT?=
 =?utf-8?B?VHlHVllrRmNZS2tNWFo2Y0N4T0xYMjFieC9SZ1VkRUVPZ0pVd05HWjhtdlRB?=
 =?utf-8?B?MGtSUUVabTJ3K1JyWVlYZXdmWmh0aTJ0cHQyQmdhK2pybitNOTZITWdoTFBo?=
 =?utf-8?B?VFZ4dkJyWkU5eEtwcC8zcFNZdEN6M01qVHVocVdpRnU4cnV4L2hXSkxSaW14?=
 =?utf-8?B?dHFzSlRtWWp2UlJHeVhjbDVRMDNqME1JYUNQSjFvQXhqN3lrdnhacS9Gamt4?=
 =?utf-8?B?Sk1nS3B4MWdTcEpHbW5hVFFkUmJyMFpubDdHYlBrYW1mS1RSYmxlZmorajkx?=
 =?utf-8?B?Q2NyZXpJUEh2M0xnc3JibitlNG1aYmljMW5vTnhSVkZrYVgvV2VZbVZIZGtQ?=
 =?utf-8?B?a3BrNFN3V1FsMG1vWk5tbEVYdFJ5NDJkS3BpMEZvdzJQcytjOGRSUi8wcnZL?=
 =?utf-8?B?NUtvWG83eXVhYnMvUFNQZVRyQ1RXSm9QeTlwaFducXBXVWlhRmpOcXVjM3FM?=
 =?utf-8?B?UWVReVhob0Z4UW1OejFFTStTZjNHelpSOW5lNFFhcDlYRFRXdWtnZENjMmw0?=
 =?utf-8?B?Vk12SEw2UGxUelFSMjZXK0REUFJPYnRmblNNbzNWM2g3OVkvOVQvQ0Iyd3dO?=
 =?utf-8?B?bGhwTGVIM1pUekRCM0FRWXVqOUxPbGZDWXZMS2FhVlpOa0ljREN1M3N4Znhm?=
 =?utf-8?B?d3pVVXpQWlMwWC92ZVlGckNMNm5FOEFMaU1ldEFrcnFPVUlkK0VnM3F0UUxl?=
 =?utf-8?B?Qzd5ZHFFc2srSVA3Q3U3NFVnWWpHMThXQm1KRmZaRnlPU1MrVWlJY2ZMZ2sz?=
 =?utf-8?B?eHZjaXJUM1RKTXNya2RoUkt1M2lCQmI5bDFXYlBJZURLeG9IcFpOd1VoUjU4?=
 =?utf-8?B?c24rM1lVYXV6WC9OV0VUdExXK1N5VDAzTkpNalhIQjNtaHlCVGRlZkZJRVBY?=
 =?utf-8?B?am80MjhiR3JyNDZad2Mwb0lkeFdiYXlJZ1VZZnF0bTJOOGRFTDhDczBZSUtD?=
 =?utf-8?B?cTVqS0xBbkRib3FJbVhHcXRsYVFid2YzQzdSemw1TmZ2MkRpZHpDQVMwbXJM?=
 =?utf-8?B?ZXhBQzF0NzFtNU5Nb1VrTnFBaGVDZWtEWkMza2ZJRGN6VXRGRU9lME4zakt4?=
 =?utf-8?B?ZXgyMVk3WmhCYjhIcElXaVgxRWFxSFdyMU9hSnFvOHh0NFVWc0lpT0N1VHBy?=
 =?utf-8?B?OWVVY2R2Ky9nR2h1cEhtY0Qyc096cGVBdWs4S3JMU2sxb2xWVzJEeXExSHhy?=
 =?utf-8?B?TElPSEdmOXh3YkphNlMyZzdhZEhzb0k0czd3Q1ZaTFBXdnVnQ2dyeVFaaWlY?=
 =?utf-8?B?cGdSa1FBL0Q3SnM4eFplU05weHd3bGZmUjZVNGFFRXlzTG9nYjdGYWpKTTMw?=
 =?utf-8?B?cFpqOVgyWnMzUzEvekhXbU91bUNHMnhwc1pwcmh1SjRqV0o0dFdHMzg1aXdP?=
 =?utf-8?B?YVNJOHZmRXpaQjNCc3psS0pIMjN2bGlPRndWS1BYUmxnK3JVU2pnUk9CTWhS?=
 =?utf-8?B?M3RTQ0k0SXZoUStHZUE0QjRuZTFpSXczcStGeEdwRk1sTlM3Mis4OG1laHFu?=
 =?utf-8?B?VXFmME9sUjVBOVdwOU12THBBS0RrYlREUXVGblI5bnVDcVBrTFdZb2ordy9y?=
 =?utf-8?B?dDNzdEcxZlhJdGdOS29KOGRRK3doSlExcDl3dVh3TUowT2Z1Q29aY01SekVW?=
 =?utf-8?B?TWd5Z3pmTkd3bDFFalZTaWd4Q3czYUZCOUkvd2ExcEw2MHhrd1pQRXIyODN0?=
 =?utf-8?B?YXhtM0xrV1BITVk5SVVuemE3TllNMGJpdS9ubGtwOVRYbmNOWkpxTkpqR1Uz?=
 =?utf-8?B?OGdnU2UvSlU4dDRQSlNMNVJObG5QRmo4dnNsbi9yMTdtL2Qxb3FycGpsMWhJ?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2649ea7-eb61-49fe-1c2c-08dd4b6f9c4c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:14:49.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5+jmtNVMf2TBTwGF9/bmR3ikOiAj9kblnZKnDvnccpi7VuKgYFJ56E7ud8gF0Odvm/qdo4/Q2DOYB6guDwbNPLeRjEuAq5afqvpsXGOlm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7009
X-OriginatorOrg: intel.com



On 2/12/2025 7:32 AM, Heiner Kallweit wrote:
> As part of phylib cleanup we plan to stop exporting the feature arrays.
> So explicitly remove the modes not supported by the MAC. The media type
> bits don't have any impact on kernel behavior, so don't touch them.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - use phy_remove_link_mode()
> ---
>   drivers/net/ethernet/apm/xgene-v2/mdio.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/apm/xgene-v2/mdio.c b/drivers/net/ethernet/apm/xgene-v2/mdio.c
> index eba06831a..6a17045a5 100644
> --- a/drivers/net/ethernet/apm/xgene-v2/mdio.c
> +++ b/drivers/net/ethernet/apm/xgene-v2/mdio.c
> @@ -97,7 +97,6 @@ void xge_mdio_remove(struct net_device *ndev)
>   
>   int xge_mdio_config(struct net_device *ndev)
>   {
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
>   	struct xge_pdata *pdata = netdev_priv(ndev);
>   	struct device *dev = &pdata->pdev->dev;
>   	struct mii_bus *mdio_bus;
> @@ -137,17 +136,12 @@ int xge_mdio_config(struct net_device *ndev)
>   		goto err;
>   	}
>   
> -	linkmode_set_bit_array(phy_10_100_features_array,
> -			       ARRAY_SIZE(phy_10_100_features_array),
> -			       mask);
> -	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, mask);
> -	linkmode_set_bit(ETHTOOL_LINK_MODE_AUI_BIT, mask);
> -	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT, mask);
> -	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, mask);
> -	linkmode_set_bit(ETHTOOL_LINK_MODE_BNC_BIT, mask);
> -
> -	linkmode_andnot(phydev->supported, phydev->supported, mask);
> -	linkmode_copy(phydev->advertising, phydev->supported);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Full_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
> +
>   	pdata->phy_speed = SPEED_UNKNOWN;
>   
>   	return 0;

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


