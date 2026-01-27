Return-Path: <netdev+bounces-253973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA7EGCEDeWkdugEAu9opvQ
	(envelope-from <netdev+bounces-253973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:25:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC7298FD3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C60453055804
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0646326D44;
	Tue, 27 Jan 2026 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lfg8weKG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04C32695C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538317; cv=fail; b=PqsVHtJq1EmyGsj00XLB90N5SAIrzqsQHJzjMC7GEaeE+/ndn4RG8hlk5dq6DyLYRRcbPNELJ7c5FdDUp3M5ugyXE7GE3IJYX5Lcq8V2Pxnnl7Ues4Z1BdR75HhkXSTrW58dwoiTzWRqviioMIQUUYKr3cySNI0EK92dmqo6+Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538317; c=relaxed/simple;
	bh=72hN6svC27QsT6k62cN0AdBpAe/jhS0fydc1gdNJgns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zq//NIpR5w+UDsXgMuPhbe/YoDIeh0aQeey5txpOqvaoV8NDHtDWNSYaBPf+ijvkHO6XIjfvf4HAnFqD9YPM5jDAQjnBkrcXOKvI1Y11DgvihAKz29/ZN5REYg5p+DyjB8ByZS4wdSVq+YlRoLwtpR135u0JsiwxfungSyHothI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lfg8weKG; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769538315; x=1801074315;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=72hN6svC27QsT6k62cN0AdBpAe/jhS0fydc1gdNJgns=;
  b=Lfg8weKGGfi3IZul2xdJEu4ZA2lWsT1WsKamd0M5HpU2EMV0VruaAXFy
   6U8M8dSMqfsavWpO6oV0BC4aTv5ViZDEt2zkjXsTc5iKlY68u4XoDUD2O
   MTAuWN4MVWnHUhFxDLYGMSWci/0KSf1lPyWUYRIcMPY2+yUpzzVJQKQGL
   gScXhNP4ipAgmLqzhwa5Q8tB7AAhXKfWCRX2NZuegJpF6I60otKoOJk2Z
   L92szd6YvmLLSxaA9/TdFwpRYPmU1lTBzmTRbFf1JXgtvV3B+gXuZs42T
   BengQSKo9TCdutzf5/x9N691n/VCJGKFaBFSUSvbk90HlYkms5wUI86MV
   w==;
X-CSE-ConnectionGUID: ZcgbOeXuSYaNM5zvl+g7DA==
X-CSE-MsgGUID: Sg3C+Vw9SnyzHHCqZkvYtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70459499"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70459499"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 10:25:15 -0800
X-CSE-ConnectionGUID: n0gu3ZX0Qdy+EQxP8G9AIQ==
X-CSE-MsgGUID: YuEOP8lCQtmd3JeSuO/6qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208399997"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 10:25:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 10:25:14 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 10:25:14 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 10:25:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4YKcs2+YAE9ywdwV7DW1Azm47fnU+JieTYHVs+tQw+CiMRge2Ha9bYCfFlvEDxE4rH09mXe2KvkApSckeKrXhogdeiuQFoI7TXXUcXEdus1xFWlraQm6Paejsq/69vJIazyqRu9Vay2MixMi4N87t0M5DEG/bIbU2KIUrrI5RdQIp+JR0lnyFVwBBw5iU2xfy+biVTn9+eSGEePPTQe2s/nus3KRWRe+UAUMBSq616wOaBRvy9SvaMs28B7EbDZ5uMjcu/L2hRNkEoIVB6LP2uhGuviCHhH4ZMuEBp5WSsAugfphyUuoK65p9oZ8sQ8RLFmwPTr/EAhWVoG5MyO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhvJWa6xAGMSMhacmSwxj1RpClfr+bmcjjUHMI4qzyk=;
 b=P4odL/LhOGiPX7UXB2nrXRW+FZIUoNgeS7yx4ORcxfF4+TzLmIUMQajJx3GMqc+Nm3VNBD9iCBzkc5sJ7050oj6OxUa2qq+sYvrVk5HeiEzoOAGUUAJcho+ozQxQc5yym9RXOPakmugx4r9qZPFgUOZKxlT0NKupPqHwu9+g7lw8RZqWtn77M9o0sZEK6iHbdJLkfTs0VOTqn2eRfT3Bx3dF5Sudh9ajClyPFleN6wKadBt+SP/aibetHTsCba6yzr6QpMLj37WEoj1Yc90pLZjNxjdbvyF8ejaxW92MbiZwvPJnzuCD4aRGVf0wuQ/Ii6EupH29RpkOMikXRTOPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Tue, 27 Jan 2026 18:25:06 +0000
Received: from PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::383b:f937:dab2:be0f]) by PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::383b:f937:dab2:be0f%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 18:25:06 +0000
Message-ID: <0c198de5-f502-4d12-ba8f-d246b043bb21@intel.com>
Date: Tue, 27 Jan 2026 10:25:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v1] ice: stop counting UDP csum
 mismatch as rx_errors
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, IWL
	<intel-wired-lan@lists.osuosl.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251201233853.15579-1-jbrandeb@kernel.org>
 <IA3PR11MB8986697A94FB36E893C7E87FE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <d6dcd835-7564-481a-a854-25b187893e6c@cloudflare.com>
 <IA3PR11MB898654344D883B1CC06A7636E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <a2abd596-f8fb-4c2b-9181-7c2c9f0b9936@cloudflare.com>
 <17575378-0c3a-481d-ae8f-e0136509defb@intel.com>
 <CAB1XECXEQHuU29BaX4j0iMMsz_2SKkG_uV=4Py9FYVxfT0zeuQ@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CAB1XECXEQHuU29BaX4j0iMMsz_2SKkG_uV=4Py9FYVxfT0zeuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To PH7PR11MB6449.namprd11.prod.outlook.com
 (2603:10b6:510:1f7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6449:EE_|DS0PR11MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0ced8e-bf96-4f73-5c5c-08de5dd1655e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEMyZjVKRU9CZkxUcm5OeGlxVlVoMTd3N1p0VXAzQllvQmZQQmpUUGVXbk5H?=
 =?utf-8?B?NDhJRDZqbDhBbTJ0M0thVFhMNnN6c0ZWdSs5S1pWeXlEcVJLTE8vZXZodDNz?=
 =?utf-8?B?RDVDQitqNXYycC9lN1BndklEWnhwek9jOUZWZUtmYWFXcnJSTDcxZXJUcE1a?=
 =?utf-8?B?MlUvSkorcHpreFJuYmdrMVFZZXoyVmlKbkphbVQvcTMvVlNrdGVOa0Vrc1pt?=
 =?utf-8?B?ZmZUYmhYem9ubk03NTFMb3UxcTQ1RTJ6dTNFWUVVZ1lraDNGU0QwOWppZ2da?=
 =?utf-8?B?MTlMdVNGM3NVMzkwR293TDYzOStvcmpTV3llWEhTSFR4QjU5T0ZpRzYzY051?=
 =?utf-8?B?THBJV1NmUkQ4dnlWQVdjRjFBbTcvVTNyRU9kMU9JUVhiNmp4YTRRbFBmUUE4?=
 =?utf-8?B?UUcwaFM2blVJS0MxQmE3UC9YZWNFWTNBb0xwLzhRR2xMdjNSalE0VmY1V0JD?=
 =?utf-8?B?Sm5hSzBIRzU3ekpMRFNUVFpBUHY5NHJxajVYMzI5VUY0N0tqMVY5dFdEVVFO?=
 =?utf-8?B?MnJyNWZ3OEFmaTc1Yi9LMnJpRHF5c0dEbUJOSTRjVXllZ3BJUTVqUjhuWVB1?=
 =?utf-8?B?ZGcrcHhOZHUxek4wN09CV2xNc0ZYTCtVd3B0ZC9CZzNaOXFuODVQWmcxd2Mr?=
 =?utf-8?B?OTZBYTFnUG1WL25kSS9WcVFsaUZwS1lja3dyYkxLOCtzWi9WME1JUGFoTWhs?=
 =?utf-8?B?Y0hzSEJLWTk3WmV3RjB0bk40ejV1MkpIQktYZTA5NDBpMmFoL3Vmd3hJYkRI?=
 =?utf-8?B?Q1ZmWTUwdDg4dzRWbTRvMGh1R1FjL1NMbFlKSUM0N0hqQWNqY2d6ZldENE9N?=
 =?utf-8?B?QkdLZ0dPOFV4ZjAzVXoxcThZckpUQWoyQUFyYVlwZ0dGQmFYLytVU1pWSUVu?=
 =?utf-8?B?djVvSEFMSTRSbFl4RmhBMXozRWNmbnNaUjY0cjRkdzcwVFdPbzZPV3RjWFRU?=
 =?utf-8?B?dEJWbTAxQkhBQllXbE1lSzNoNXVMNzJvOCtmdE12eTRIdkN2UllDaFpxMDZh?=
 =?utf-8?B?RHAyMjMreVR5ZVhacktlb2lPV0IvT1hYVEQwcW5oMW9tL08xMWJqR0dsUHI3?=
 =?utf-8?B?bmptMWkralhleCtwZFlRajRxaFRkckZ1YlR0cWFUUEhZWmtCK2hoaDVpYVFn?=
 =?utf-8?B?eGdwUU0rWEFzUUVYUTNvNjMybnUzaTFhaE1oOEhqM1o1SGpOSEN6NnBGVEpK?=
 =?utf-8?B?TmtMbzgrOGs4WkZCcmRBUHlnc3dma2dtMG5NMHB5Ly9UUmFaNXlVMGhtWDJ6?=
 =?utf-8?B?Y1NIUmhGdnZDWjMreExlZ2pYajVXVDQvYVNkV3NBYm1BRitDT3pBOG9CK1pM?=
 =?utf-8?B?NkY4dHRtSmI2eVZ5T216Q1dzVzA3eE9yMTZlSHRpR2x4bVVYQjZ1QmdzYXRj?=
 =?utf-8?B?V3B6RCtnNUgzanMwRm5SUzhHRVg2SXZWZVBmaG9LaVVTeldzVmhsVWIrVmhJ?=
 =?utf-8?B?NjVpN3ZCV1gyZmpscjBZVnNIRnZPbDRzemM3cHFnQU82TzRtc09VclVTUTlB?=
 =?utf-8?B?TnlUTHBRQk0wRFFHR05Xa0FGTVV3d0pYczBEMi95aW1nbGgwaXZLV1R1TXBs?=
 =?utf-8?B?cFJqWnB4d0EyOHFiRyswbmRrS0htWVA5c09nNVNERkZ0VGpBOGV6YVpCanhi?=
 =?utf-8?B?YWRUTGlONkpLUjJWcDNVU2tJQ0MwQytWSHBkUXdaWXB4WndVeXk0eUZ3SmxM?=
 =?utf-8?B?akJCRnpVOHdnd1h6ZkU2YURFQnBGS3NVS2NyWm5peWNwRU0wQ3FKa0FUdUNS?=
 =?utf-8?B?d0FzS0orV1VWaVVYOTVzeko3YjNoVGE2bUliam5CL0NnbFlobENBaU5sd0ht?=
 =?utf-8?B?d2diWU9NWE5OZmt0bm02QnQ1T1N4NkJudGtCK1lFVFczcVhlcExqZWxZUENY?=
 =?utf-8?B?ZWRvWk9kOVZwWnErd2Z3Wmc3S3V3NDVtdnpRTjVKcXdOTlJVNXJ5RnNkcHJ2?=
 =?utf-8?B?bW9JMFV4ZUNpQ3VxRWorTjZBaHZIelNVbVFGRU5LUjB2dUluekNPYXN3Q004?=
 =?utf-8?B?dHNqWGtCUW03ZW8yM09HS2RlSXBZQXVTWnZ3NTJLaFRqYlNwTE1iYXpxSEJi?=
 =?utf-8?B?TDhIUlFvZzd1OGYzSE9wcXVVUFUzRkJDbENsV1pBSnVMZWxodkZlakRhNjJm?=
 =?utf-8?Q?/chE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6449.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJkbVV5czJVVW0yZ0VyV2FrM2VBcmc4RnRNMTQ0NGh5cTFpWjFEczhFandB?=
 =?utf-8?B?b1IvNTdkWllUdnhjQXRzQkttZFZicHhHeDhkYUlnSzRHTlFoNlVJZUNtQ0VO?=
 =?utf-8?B?UTVSM1QrR0h0OUs5ZW1lckhCVUc2cjROa2J2djgvRVJZYlBUeG9URnVIUzdh?=
 =?utf-8?B?MGxzNUI3bzhwQ1pKR2p1VmlYY3FIdlJwdERTWGtrNlFYUkZHeTU2aEtsUVR3?=
 =?utf-8?B?TE96OWhtQmFERE9jS0xCZE1BT3FDK1pLVHlZZ1d3YWsxV2lrRGwrMkh0RG1V?=
 =?utf-8?B?SHU5L29WVnlTdER3YVFWTjZxZ0hBR0txSm94MGMvbkhUUnp1bWY4eDc4V2o0?=
 =?utf-8?B?NFJJZ3g1YkJMMUhadW9vMXpHWk5GbDdZL3RWWUs4dVpISldrUklYVXlGVUpF?=
 =?utf-8?B?TVE0bGZNVTgwK2p5MjBXSTJuSEZHT0RXaGtCcGI0MHFRMTZaQW54WlZnVFJl?=
 =?utf-8?B?SCtzczRsSGlUSndpYjV3SkRLTXVYcWthUGx0VWJ6enQyMzhpZit5a1RZb3Jj?=
 =?utf-8?B?citTTXM4ZkRZVFV6Sm5jMGsvQjFDZHNtbk1IYXY4UFhnQ1FlMXNyTE1waGFT?=
 =?utf-8?B?TjlTZEZMays5TFhrYVNDZ2Jaamw5R3JxT2lDN1ozd2ZTeXNtNWhuQjhqTGo5?=
 =?utf-8?B?Z25vM1A4dVdZdVEzdGFsSVljSnZaWFp3dHdVSkMzeUU2MFF4ZVUxb3VxK0Ns?=
 =?utf-8?B?Q090S0hKMWlqdmxMcU5wUU10eHFzcW1PRGJNNjBPTDJBTDUrc09QT1NSa2oy?=
 =?utf-8?B?Q2VxUGNCOWwyVVBzTkJwR2hOMnBJc1gwTFhQS3E2MzdKcDZIWVNyMXdXUTJS?=
 =?utf-8?B?NklqQm9LQ1ZEcWhjaXJNUCtCWG1MY1RPYlc3ZjM2U0dJYVR6ZmdUMlBhb1Bx?=
 =?utf-8?B?SjZEdDFnNWN2WjA0UVIvVmxrTjVmOTlQUFdFOVVldldDMDFUY09MRXk3eVlh?=
 =?utf-8?B?TnBpTVRLMjZMVGdLb0FrQXNOemhpelViU0srTWlXeDdIOTJUakNldHV2MHJW?=
 =?utf-8?B?YTNuUU9GTXhpUFlZN3k3Mm52c0FoNjE3SUlzUWkxUndZU2VBVzFJelN6TGQy?=
 =?utf-8?B?ckJVRFhHM0xlV0IrVk9oVFdZaDM5eTNmSkMycUJQdnFYRm5TYWxYamFUYW5C?=
 =?utf-8?B?cXNhVENKWjhINUlwekx0ZXNlMnFYdDRQV2JMbnovS0QvZ2N2dzFaMnVrdlEr?=
 =?utf-8?B?M1FUMjJwK3gvWXZHOC9sb0dKRm5NZlllR05ybHlwdndVT21NM3F0MDNlRTVI?=
 =?utf-8?B?ZXZRSHo0OEJHWXBLc2xhbk9TcVova0dQR21CZ3kvYTFqNFpHbTc0a055MWNm?=
 =?utf-8?B?UWNqdTRUTTVUYUtmRU55cVJIalFFdzlhK0FSSU5Tbk96YnRPb2J2ZURLc1pU?=
 =?utf-8?B?UFVJM1dvNGVGK09mbGl5UGJMalFKNCtjTVZodTFGUHRLeWN4YnNrTERjSm9L?=
 =?utf-8?B?YkJJZG1aZkV4bTUxZVpZdkNkZlRFVGJKZmE5aVovM21qUGl2Rk1jMlFxMWFI?=
 =?utf-8?B?MkpEWnhoY1piTUtBbEFJQjRrbThuSlRkN0pDWjhhRTJ4T2JKbHhqOVRVYlN1?=
 =?utf-8?B?V0ZMeWxxWGdlUHgvS3R4enJqSmVRYVRQR2Q4dG0xekozUE8rKzJFWXB1Rjkw?=
 =?utf-8?B?WElQZHY2d3NGVE9DeGxzVTlhTWVpMVRhVTAxVHI0ZGtUTlVzWFF5eFhxaUpn?=
 =?utf-8?B?czhwMlZnbUpOOXZVQ2ZBc0owelFyY3JTcldnaWNZb2t1NEp6a0tSYi91TUMw?=
 =?utf-8?B?a2R0aEltSEJKZjgxNmg1VDloN1U0RmtBZnY0MFBaMXFFajlFZXZjTngzVElO?=
 =?utf-8?B?MUVIT3NPL1BlY29leVpFay8xS0ZLTURUcWFyd2U4Y1g4TzFkancrWEtpRi9K?=
 =?utf-8?B?UnBmbXVhbWs3Nm1WRmRtM3NwNlZMVlJXNGM4eEVFV3dXcEhXL1ZHb3V3d0hC?=
 =?utf-8?B?eWFmcjB5c042Ny81dDBYYUFSSWhPWUtPREJuaWtmbis3RjZtd3NWVnVYU3RX?=
 =?utf-8?B?dTJuL05HRHhuLzRFNE96aTNPb2d3d3BLV2Y1VXB0dkNjYXcxNWtDdUU4S1FI?=
 =?utf-8?B?MG5hTjRwUUU3TEx3T1Y2U3ZITTdEZVdPY3hqRjgza2lPUndZS2Z0U3ZKK2VW?=
 =?utf-8?B?cXZCMnZhV0Y0Q2hCTHltbXlHWG9zNTcyRTErZXJ1UEVoQXRiZUhaWGYrQ1RP?=
 =?utf-8?B?VWE5d3NCUXcwekt4ckNoOUFGTzRqNkt5R2crMEFMd1VEYVhkYXFSUkFic3pq?=
 =?utf-8?B?UTBzZjY2VmZlaE41OGpidUZFM0x4OUw1UE5UM3BZRjNxdVRZRHgycTZ0N1E1?=
 =?utf-8?B?UE9tMEh3dmdDLzdKWTVZbHdvTGxGajZna2NJOWFFTzRLeGxlNzMxdHBwR1BW?=
 =?utf-8?Q?t7t7WEZb5er5W7hY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0ced8e-bf96-4f73-5c5c-08de5dd1655e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6449.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:25:06.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Cr7t8khXNWbOroKOKrQ0uhNorNBPf2qsXFy0+tMFNS5eXbCk4isZ7mk9eEZ0DGWTS+G5wyILNL/oN7AQFeIsw/zPSzVEmKNcbPJN/n9aa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253973-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BAC7298FD3
X-Rspamd-Action: no action



On 1/27/2026 9:52 AM, Jesse Brandeburg wrote:
> On Mon, Dec 8, 2025 at 2:21 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>> Right. I agree with Jesse's proposed change. We still keep the stat for
>> the ethtool but we don't report it as a full error to the standard
>> statistics. This matches other drivers from our own products and other
>> vendors.
> 
> Hi Tony, can I please get an update on the status of this patch? it's
> been two months for a 1 liner "net" fix.

Hi Jesse, it's part of the PR that I'm working on now; it'll go out 
today. It's an isolated and straightforward change that I'm sending it on.

Thanks,
Tony

