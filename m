Return-Path: <netdev+bounces-140284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525F9B5CBF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8208F1F235F2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 07:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BE81DE881;
	Wed, 30 Oct 2024 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKA/1vdS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9BF1D3578;
	Wed, 30 Oct 2024 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272777; cv=fail; b=jMOGdehtbU2sVIdvgj4pJvN0bAcdr1y/CJJga/06CeAovD74HFODm1tjj/SPBsMWeBYsAIHl2O+5netmqzU3vsu1a1Y/UO0N+XqhWz3/8s4ukrc9ll9L+Qa6qdGRzlviibgazKYyiReXlbqykms1nHxLoubNSPohpuhYhPfqyfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272777; c=relaxed/simple;
	bh=ca04b+LpmgcRQTCnkr2mnGpLk4rxUsRSQAqXLvTV+Ys=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JQHMl4X3HPdyOlP2cRvttzjMb/tVhGCmeYpHJ2+pp+wtNZXzwoPDvXmHBzritvnns/rxwNuUlv6un09FHmAHt3YXMIWxmRUhZp18taXLwBXGgIwlIiyP6L3tMQZdshIDmTq5f/Zo+r8b488pRXYxlNNVw0Binw8QcJiAdPVdhJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKA/1vdS; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730272775; x=1761808775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ca04b+LpmgcRQTCnkr2mnGpLk4rxUsRSQAqXLvTV+Ys=;
  b=hKA/1vdSt6RniLU1d9MCeelQDjMVcXYX4g8S7J6Bf/Zy40TYYjdCwkUG
   45kHs8Ys1NUjG3DcTfiiejk4cxkf192vB6YfCIq79V92W+acQ6Tvi3INS
   b2u0YNdEOKcUsAEflxP3zfkbT/S67Ko6PJbaew0TRKE/Ws1XM+nA+M8NF
   sC+A2olTdR4gw+xDFNNwNWbBnuu14Btxi04z9tSIr8pyyIKFvxBzKA1k2
   IXmhn/waJS88LSbIAwf8AV1fUX5w0FvegJxe4J2xedr4qsYOoy1rRtXKn
   8KzXs6HDF+KKJB3Dwg7b3FosOdeXw07jiiSAU1P6VjnBcwrFY67kAYaVT
   A==;
X-CSE-ConnectionGUID: CsqDL+A5SGuscBlOpxqDIg==
X-CSE-MsgGUID: QLfsHOB4QcqTjDwDA2R7Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40490567"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40490567"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 00:19:34 -0700
X-CSE-ConnectionGUID: 590tp578RJK+CDxL6ekVLA==
X-CSE-MsgGUID: rXyc6K//RFWXKqXzF8493w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82134427"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 00:19:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 00:19:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 00:19:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 00:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERNsoV/WFDaw7DYrsBMt/QlfTqQLy/N8QsnVZcTZUnqkOPADw8Ia6ZO5JF59teuNmGZecqzcFBXq67MgQ2EgaAkcJqT9uc9tF+2TCCru0he/K+VVdeU0/YFbZ4vublw9Blz/oAFpjxVrm6q+rNGR02BBytQWh3//4r/DjUH9pmDT6kg2Mis9+OnWMyo97coqSLZgclDdzbMwkTCY6tAg2HD/D/XWWDZkTasNhJwqbQZOa0tEKMRAjxE1ffzADIrnsttHm9vnrBH6kJM3GADodiIKyTjrvpPaiyHWmuS4Drfyu7HB6Q9K+yy3oeCa1KjsxkPT19Ew5eiqkV+lMNn35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvcjP3ZWVWxS5x0bBUAw1O5KMbk38yZAUDxsnKfJX1Q=;
 b=KpsSih6wtIhDIy0Si9OYfhCjIYQuhOKtS/cy0qRROO5NhYvt1SDjuEG4Azpmr2prm6D9VazdNuJDJ1cjVH+rldkBkiS0xUEp1miwptiiPaB3E5pX3xPQY3WDo0ZTFyBuWuK9XxfCGK7IbftyAihfX3eCJ4bR7neG+BJBpkQ+m1WafLU4gQ6sWnpXRdTmXYX1QBPoOicvLkx8cTCeoI7TKaP8cyWK0FnCk8zOyACWaUru+a3Pj3c8fkR8ZpssQvx8FOMjyaOjzIchVKCrXDYbCNZAH4sXhtf0rsLuX49GsdQAB46lycd+m+l/cTO5klrhHLChr3hSauxF0a+V7YfRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:19:26 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 07:19:26 +0000
Message-ID: <38770d64-1a9f-4f97-8e10-95dc16e1d9b9@intel.com>
Date: Wed, 30 Oct 2024 08:19:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] ice: use string choice helpers
To: R Sundar <prosunofficial@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <karol.kolacinski@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <jacob.e.keller@intel.com>, "kernel test
 robot" <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
References: <20241027141907.503946-1-prosunofficial@gmail.com>
 <ca4f7990-16c4-42ef-b0ae-12e64a100f5e@intel.com>
 <e9a89d87-d1a7-44cb-aab5-07a61d578c3c@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <e9a89d87-d1a7-44cb-aab5-07a61d578c3c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd67927-c7e9-4894-7aee-08dcf8b32f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aitUc3p3Q3ErSjZzbTg2OGlCNElzWWpidnh5Z29aOUYwR2hyRnRHdjk4Q3o4?=
 =?utf-8?B?ZWdCQ3dQQ0NjM21rb1gxWFA5dVhlelpiV29oSE0wcHc5SXZpc245NkJjTWpZ?=
 =?utf-8?B?cWRXK0RMRE9Fa0hpSi9kRURwaC9CY0pYRGVSREsvMWtFcFp2NDlrN0pOdzAw?=
 =?utf-8?B?U0IrWm5lMWxtQTgyL0Z5bG10cTJDbnRHdmFiZkQ5NDdjZ29pQWdkVWtsK0N6?=
 =?utf-8?B?L1hDRUN0WW9zK3I2ZHg4MStkS0ZIYm9uUjFTUUx5YzNtcTlKZXZ4dGhxMkRQ?=
 =?utf-8?B?SlV5bnQycG5USWxEOXFNVDBhQW9ocWpvbytCaUdtVHFaY2ovMFhTZ1hLdUI0?=
 =?utf-8?B?M1JrNUhYMnVHYVJOc2lRZTVoMHkrMmVLdnY4T2hqZ2dUKzRtbFF3bWJLS3ZI?=
 =?utf-8?B?TSthd0hTRkhZQVNQUndkYVoyMm5oU3NIOXFTYkU0NXg3SnVRaXBTSW9MWU5i?=
 =?utf-8?B?T2psTFczbk9HV3FVOXRjbHdaV3hwVnI2VFJaaWQzbGREL0NBQUhCK0RodWg3?=
 =?utf-8?B?Q0FmSXRldnNzZE16Q2U4cnJRUHVPNGpNVkMveGZyMFg5L0N1YWhvK1Y0M3JT?=
 =?utf-8?B?UkxhcVpPQktCWDBPZk5vakxwYndHRCtrR1BzK3QyVFZLd29hUkF6ZkNZVVVs?=
 =?utf-8?B?QTVIYmloS2ViditwU0pwSDF1bURXU2NudDlBRkM5UnpGSm1KbDBjUzdnRWhh?=
 =?utf-8?B?UVpDc080M1VKSlFTVWpVcE9uK0RBM3pjNlpxWVRjc1l1YjlWMVZsRnliblQr?=
 =?utf-8?B?NW1lSXNFMDRmTTJPKzh0WlhVQnQzNW5Xd2RlOUtndk1iZFhXNTJEMFAvdWhR?=
 =?utf-8?B?K3JLV1d3TWN4dDVKRC96cCtCLzNyNHVEZ2IvVU9NSlR5M1ArYUZlM2ZRdGtn?=
 =?utf-8?B?bHJzMm5SQXhnUVBrKzgrT3FDV2FXYkV0OEJDZGJZcnllaGZHdFVPdlIrQ0x4?=
 =?utf-8?B?amNicVdnNDFCQ3NTbUN2MUpMZ1NZMFpuM3ZDYWZhaWFmWkZldUNOb0RoNzFB?=
 =?utf-8?B?K1NaRTBQWG5EOG8vd096eVczUDRNNE4rUnh1VGU0YVVQcENXR3U4MGlvaTRl?=
 =?utf-8?B?V2lEZFUybkQ3Z2lpUEMxeGlXSzVkNzQ1TjZSODRUQjNrOFhaUXk1a2ptWWp2?=
 =?utf-8?B?Y1VCV1pjeFVxbXRRZGxNdFFYVWVMVlg3TDEyU05ianNtMlNxOFYwWmgwVTAr?=
 =?utf-8?B?TE01UndnbWZPVXFrb3Q4ck5FWkV4Z1lWeG5LQ2lRSkw5dkwxbGdYdkFaMmJv?=
 =?utf-8?B?SG1XRUxHVlREL0IvM3pTV1g5YkJoRG9TdWlmQ2NaV2tvU0NJeVRyeTBMVXpt?=
 =?utf-8?B?dGI4eWpDN0ZqcjNWU2tMU2tTa1h4eUQ1NDJXa1JwdVExZXZ5MGZkb0FuZUox?=
 =?utf-8?B?SnpMSzcxYkZDb2FKUWFSNUsxbzYzRE93aC9TV1NXdElEVU10ZU1OMTJGNG95?=
 =?utf-8?B?NG1PNkwyNjM0ZWtqUWFvK2JvK1V0ai94YkZTcGRTTFI1bUgwaUdxazRLV3Bj?=
 =?utf-8?B?clBzT1hXdzZ1VHZ1SUV4Ti94ejBwb05COWtaR3dsVU5UYUNsZG1jcStsZmpE?=
 =?utf-8?B?REpyZ2hRSkliT3lSZEZ1cmlSaHNiY3ZKQWVwTlNwbTFJN25zdVgvbHlFN2Qr?=
 =?utf-8?B?R0hkSmQ5aGdsa3NsUUE2Y0lJekpJWXFwY2hNdlBQaW4wMmx4VUNmTVQzVjRH?=
 =?utf-8?B?RXFnYjMwSDFjbU55UThHMW4yWXRLK1diWmtxT3NaRU9QdEZla08vUHozTnFD?=
 =?utf-8?Q?66k3Yekx7DybGJQIZ9SYoDpEHcTtjF2Vqg0Oofo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0Q2MGFZQWFiblIzM2FLZXBJQTdrL0JiSVhocUVyOTlxVHBDQkE5TlUvZHlu?=
 =?utf-8?B?RWN1a0gwbk5JVitOMG9mUG50OG9vK2RPUDRnd1hNeDVzTExQZGNxUzlwM0Fy?=
 =?utf-8?B?cWszVm9YZzBmTWhmcVpzQ0IyOGUweTlxSXVaSHAvejZRZFNFQ2xYcUdVZ1RG?=
 =?utf-8?B?OUNnMEhyVUZnVmQ5ancwd0JPdmxJbWlTZUEvS2dvL0NweWdMcmpTSnZzUkRV?=
 =?utf-8?B?VkdRZUh4SE5NckdlRHE0MElNNHJSajFEc0xabkdEcERsRzdUWm1QK3pDUzFB?=
 =?utf-8?B?RDd2UGxzcVhlSS9vaEVadXZCZWRQcG10WFdNaHBwUXpRN3BDK0xNNitZSHR0?=
 =?utf-8?B?a0hWbW1MZFYzYTQya3liTTFVTjdxSDg3T1dWeXB1Rnd1Q1NnaGw3eXpBczc4?=
 =?utf-8?B?ZFF6NWNkZ3BFM1hhR1pldEg3VEJ4ZnpKMVN0M1FxSm1BU3lLTVdscnpJd05Y?=
 =?utf-8?B?bXp0TmIydWJMMFVyQ1FWanp4NFVtNmthZXVuWDlxeW5YQm9zTlpldUFzQTZr?=
 =?utf-8?B?L3JZU3RaUjQvUTZXdWxiL2lVT0VndHZYQzh3K2ZnS3VLdnBDcDdaNk1DVUJa?=
 =?utf-8?B?MVp3QklSaHFDZ0lDRXJFTUxNUlFRL2xBemh6c0llUGpuSzdQbWRDdkQ4WDZH?=
 =?utf-8?B?M1M3bTAzKytnQUFKYzVxcStGd3JlZkFOU2pRL2dtQlA0VXBNSFZNc1lOOWdS?=
 =?utf-8?B?MmZ3dFBZK1pmUEdQTzZpY0FDU0tnODJTV3VISktIQUlPaFVLbUhnL3NMdmhu?=
 =?utf-8?B?RXZrZS9lTmtuYWFhaVJZWUxmd0hSM3FuOUgxZzZyNUtrb3RleTA0NzhCa3dJ?=
 =?utf-8?B?K3B1R1JhblU0dkgxQ2dFdDIxbGd2elNTTmdBanYybkNDMFBVV3pudUVtUHRz?=
 =?utf-8?B?RXFHUnVrdWlpMXNvaVh4dW9iSHhzTG9GeGY1c3N1V0cwOWtSTWdhcGNHTnlM?=
 =?utf-8?B?WVBvQmJzYXFZN0hBVEZFRDJ3VFU4OXllSXpEbDA1cTJsQUhRZnRuRkFqaC81?=
 =?utf-8?B?anRjWURZT2x4aVJpZmxOSFpTMXlycVkyUlMzMUJFb3FMVng2Snh0T0YzQmhJ?=
 =?utf-8?B?eGNKVkhWYUIvWHMyRjE1Vk05YnZoR2RkZkFzY1EzalRwUHZLYWhOWVdaUlYz?=
 =?utf-8?B?UU5QN0o4aTJFYmx2Ym1GNE5MQjdhT3I5VkVoSERvd0YzZ1IycThPcktwTStw?=
 =?utf-8?B?aUFaaDZoZHNZVUNWZGtzSEk5WUlvdkE1ZzBndzdGbWk4MTFQZDBaNW5ka1RG?=
 =?utf-8?B?SHpzQUs3dHh1cEhTTnZaYlpqblVmWHg0Z2hGWjdwbStURkxmU05LNEgwa2hj?=
 =?utf-8?B?c01CbS8wT09vUUVLYkdpaExwa2J0QzEzcGFHZjlaVDlHcExSTHJDTGxiVHRV?=
 =?utf-8?B?QURUdllVRWh0dlF2YlV1K2ZJSnRZLzY0M2JCZ0N4MTV5ZGk3ZGM5NnZaSHp0?=
 =?utf-8?B?c3FSZkRlUUtRTHk4ckRhdStYUWlGYmJnVTY0QUZ6OGxlODFPMUdlL3lCUkFT?=
 =?utf-8?B?dmhuYnB0ZENFajNmb0kvMFpCMWdUem41bjR2K0dQZlA2aWE3WVFNT0VGOTdN?=
 =?utf-8?B?OEtVcHdQTVR6QjZJa2R1S0k3VEUzQzlRc3ZwamNwaU91SG8rQnNyaXNENzQ0?=
 =?utf-8?B?NWg4SjZvN2xxcFFpY2RseW8xNUxkYytOVEcvOEY3REdJVlV4ZG9uTGxVK3p2?=
 =?utf-8?B?azZvbzJnbzlnZFZIKy9XamxYaUhEVHAxTmtYdHZsK1pJbVFkRFBHTE1GMnBQ?=
 =?utf-8?B?U1QyT0RWQWFWSjE5NVVaeklPUnRiMkdFdzBIdm5GM1RYQjVSZVE0ZzlEVnk3?=
 =?utf-8?B?aG0rZGVuTDFXZVlERTVvSEQ1UWtWWCt1YVArZDVoaXQvY3R3MDl2cHVaU2lj?=
 =?utf-8?B?RlZ6ZUx4T0dhUHNrZ1lWQTcxQWV1MGhQcTE4dk11VGMvUGl1cWsyL2FQc0Iy?=
 =?utf-8?B?UHVIbVlPdkRGYlBUbHM1UEtWNENzRnowWTY3aDRubTJCOEJZMTZqRERmcDM4?=
 =?utf-8?B?RGQwVFdyN0xodGpTSlBqTjZUTWxETjdLbk11cXovSkpxNkVvQ3hhWE1TUGdi?=
 =?utf-8?B?ZFVTNWwyeFN4SGFGZDlWNjZPRU9uTjlQcWdwZzNPamt5cmZReGxnbW9YZkJL?=
 =?utf-8?B?UE04Umc0ejU5YlNEdHZVdlVSS0xvYWZxZ0FUWGZFQm1rS3cvWElCT1FDTWJ0?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd67927-c7e9-4894-7aee-08dcf8b32f72
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 07:19:25.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsCR/+pRvCj0jJi6jN7e3fRFnJ+ip3zipDv1FZMilyG4lwCC55Igcu170G9phJKIRWqM204CfGcXwN2X/zJsyt98iLktTUYfaAebCvcbPs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com

On 10/29/24 17:37, R Sundar wrote:
> On 28/10/24 15:24, Przemek Kitszel wrote:
>> On 10/27/24 15:19, R Sundar wrote:
>>> Use string choice helpers for better readability.

>>>             bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
>>
>> perhaps locked/unlocked could be added into string_choices.h
>>
> 
> Sure, Can I add locked/unlocked changes in linux-next repository and use 
> suggested-by Tag?

sure, that's way to go
but please first check if there are any other users (despite this
driver)

> 
> 
>>> @@ -471,7 +471,7 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
>>>       /* Log the current clock configuration */
>>>       ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, 
>>> clk_src %s, clk_freq %s, PLL %s\n",
>>> -          dw24.ts_pll_enable ? "enabled" : "disabled",
>>> +          str_enabled_disabled(dw24.ts_pll_enable),
>>>             ice_clk_src_str(dw24.time_ref_sel),
>>>             ice_clk_freq_str(dw9.time_ref_freq_sel),
>>>             bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
>>> @@ -548,7 +548,7 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
>>>       /* Log the current clock configuration */
>>>       ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, 
>>> clk_src %s, clk_freq %s, PLL %s\n",
>>> -          dw24.ts_pll_enable ? "enabled" : "disabled",
>>> +          str_enabled_disabled(dw24.ts_pll_enable),
>>>             ice_clk_src_str(dw23.time_ref_sel),
>>>             ice_clk_freq_str(dw9.time_ref_freq_sel),
>>>             ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
>>> @@ -653,7 +653,7 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
>>>       /* Log the current clock configuration */
>>>       ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, 
>>> clk_src %s, clk_freq %s, PLL %s\n",
>>> -          dw24.ts_pll_enable ? "enabled" : "disabled",
>>> +          str_enabled_disabled(dw24.ts_pll_enable),
>>>             ice_clk_src_str(dw23.time_ref_sel),
>>>             ice_clk_freq_str(dw9.time_ref_freq_sel),
>>>             ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
>>
> 


