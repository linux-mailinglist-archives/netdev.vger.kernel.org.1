Return-Path: <netdev+bounces-275225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x3jUM5Qu0GnJ4QYAu9opvQ
	(envelope-from <netdev+bounces-275225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:18:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAD639865D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C49A300617E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7F315D5D;
	Fri,  3 Apr 2026 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvxbpQlM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0BB1C3BEB;
	Fri,  3 Apr 2026 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775251088; cv=fail; b=SnfmcOeBCpxViN2zU11+kiJEgD11I09QYQsja7M14/HKfVG4gC2cmV9crURz8GLCqddjas5UfMAtFE+H6qf58vSwtECh5SkEL1GU5GLz/5M+9aIgGi7XHKfjyyqj/Hw7FWoSYh0nDbWlcg90259c/8Kn2rZNH1cfhTv0xAjD1ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775251088; c=relaxed/simple;
	bh=mZny/oX3wkLhj0Q3cJyYqEz/T7kMUqxL7J2H7gIGZgs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BoC2W+MlLMOTIDgOQ8A9evA3Zl7jkAmkeMpsBtGDaa5wOKo8AZ7nXWgR3FajjOcwyts0G4lxJA/9cMKKvZ5LWxBJSypb+80k0lCTSr+51DGtALkqmdO3ci7qb7Z/3T8WmGSR4mSAzqlIqvAngUDZP/STksmFuiCZJtivdCTwCmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvxbpQlM; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775251087; x=1806787087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mZny/oX3wkLhj0Q3cJyYqEz/T7kMUqxL7J2H7gIGZgs=;
  b=EvxbpQlMjYog6J6K2uVwlNEUWJB75t3/VwFNQ/zuqCbgcBh+m6let1DP
   h0kFk7klQiy2Nk0EZWuUTbJzYCgUxZI+GgdRgNTp7zweZVT2Zl2Oc2lxc
   spoNUxdrsLKu5z5OhpNSlWNAnP1DII4rrFGbxVGXraGJJkxnXPkLRlJTs
   cgRQdzI7lnuL3xrQml9wNMTLYQk0sGsuZxn4v34l8XDUl6Js7v3JwgyTn
   9Aqji9ethomirSyRPg0JYMltR09vdgMVCg/VKq2cJdXlMNC1DfN5OqMDK
   bQw3nglA00JygxPKK10aXckyB1qtaBc4BlMDS8uvCM9jlcmdboAEm1Ylh
   g==;
X-CSE-ConnectionGUID: lipWDR0DQa+elVDtNZrOjA==
X-CSE-MsgGUID: SsmvCuMFQzafD33+cMVGIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76282702"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76282702"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 14:18:07 -0700
X-CSE-ConnectionGUID: WXoV+3AmQZ6982WykDgQ/g==
X-CSE-MsgGUID: MKCErfx3TbaVJrQuZINNQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="231735794"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 14:18:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 14:18:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 14:18:05 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 14:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVYqj9ISdHppp6uGZQJmZviIBKL7f3LeV6yEYTan0nNDKrkTO/x8Q3hLxZxJ5q/VicYf8AJLFvbMdrKvHrWt+V+p3SlyamKfZsQrvQQt4hwbX6BF9ablD24S93kKyfw7M/dQejpexVFWtPrAipBdRLrRJ3BRHs55hFOIhyXHzZp/Va2qX/js/Memu9TxpFTfqgJXghz6aeyGHVf/Y8V8jWQ231hT96we0ucq2WStcjxEsIFE+bTWhXiozT7ji2arwNcrL6Pfr+CbbGxhMVZfdgiEsR+ONLgjGs/aG1niKo2ngfqwLjzHCCnFNWx4yVYJAEXeF8d3sHMDxcm3a2IwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewlp9TD5xUVLbUHts6CznEuDeJH4wCaCNYIDJunl7u0=;
 b=QTEq0xlBHUEF2FuRXjABE0rYgwfwRaEGK6sbTfpqllROpDv5/x0uBB1vbsmGF1fP6gIt35W8WXt+AQFcjrgKrPA4AoX+qYsHVb2zimge+FvjU3IpHQFDegWfyv7EHYTliz9/Vgwz/uc9wlKVD2U8fL+Xfg6NWGfWJe5CIUPG4qC3pC2wT5SorhH2hsQYpkV6Ic7LnKvEd7WvyM7ZFwmzdlQ6250hgD4HALN10mm1cpKAJ9iYmrlG+umV9vJyIPy9V1Uo1hm6i4bBsEHxT2CNlIuF+8sP7CqtgtmNSyWWTpXnwlvqy/QxqLhRm7U9ITjRl2kZrSjKPHy80Ga5GqgJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 IA4PR11MB9230.namprd11.prod.outlook.com (2603:10b6:208:567::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 3 Apr
 2026 21:18:02 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9769.020; Fri, 3 Apr 2026
 21:18:02 +0000
Message-ID: <d02145e3-8ac4-4057-a888-3ce074a295ea@intel.com>
Date: Fri, 3 Apr 2026 14:17:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] gve: implement PTP gettimex64
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <willemb@google.com>, <nktgrg@google.com>,
	<jfraker@google.com>, <ziweixiao@google.com>, <maolson@google.com>,
	<thostet@google.com>, <jordanrhee@google.com>, <jefrogers@google.com>,
	<alok.a.tiwari@oracle.com>, <yyd@google.com>, <linux-kernel@vger.kernel.org>,
	Naman Gulati <namangulati@google.com>
References: <20260403194427.1830609-1-hramamurthy@google.com>
 <20260403194427.1830609-4-hramamurthy@google.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260403194427.1830609-4-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|IA4PR11MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fde024-4e44-494a-8bf3-08de91c67d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: A6AJC1f+mbOH6E0KKcyywgXNw0fc/ri/qolExpAEyf4iihk36FNO+QNsew9PpayHzXVpgOUzVH/aW8+vk0X1+rmIjhFhG8YkRyfIEvwIoLEyF/3NWCg+iIYCE3Ag7gLnNX8HOg+7+e3G7D1woo3RI8Z2ioEVD7+nXnTNA/NpBfZdH1BFVe0GpZ8W+8mC3BCpsZmBSvvsfyjp4RUbskBKg/MCZcAWYK0nm88JMFuAuhimC7SJRqOlyKyiRpeD5CvQ0eIuEyFZNoFcgwdIz3ziwxZnipHv6IRxuBvxVStU1461CdZ01uamtT+RIPD1zULSgMbETOZrKTCOoLoS12wWyjbG+D4/pcaPUxSNPZ4+1JMYu3SRbQcYyCDrmnInzA0t/MFpE67R6OB7EoZX+aOUGJdFrg9bN2r/3AWC0nHb00mBvXG3g7u+biZPY1wbi1WamAxZghilMVX42phIV+X4uIpqvD1jG/grYgE0lHPkU42420OyUAI8lzs18H5YP5BgJ3dTArgGYWmTDQ+ZF2slBXGG+fCaUgAjkG1Z5bLkhBulPPlwg/HCRfMiWQHvE9gws3dgYXd82wNrlSwc/hrmf4sIrZktTDXZZCdkLjDRiwImi4hqLIBxBoFxy0Pt/pB4XcqbSv059Nm22g96pypm6FqaPiEBHrtoaY4pFc1/y8IHzucVpeuSX9zGp41OBUjVeGHOf8+629vSfcib/q1TyNCwiJ4M/mfIhbtrKZNeDmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXgzVjgzaDNVa01uZ082MDhwNGFPSFRmZE1hYTVvYXVxU3JkOTA1SGdpekdo?=
 =?utf-8?B?akE1K3pZN0lFa01obExaMlM4UVlOUjV1ZDRiQmwrcndPandtbTJNb2JRRGZR?=
 =?utf-8?B?RUFNTVU4UHgyQjRWTW5oRkx2aFdaTzBVYUxzdDdMWVZvNGFqcFN3S2JCcmFy?=
 =?utf-8?B?L3NZREplQWFaNVpHcHY4N2paRWZYTE9vNDhtZ0NXSlpkOWZFdDdNOUFUVG9D?=
 =?utf-8?B?aC9VWFZtaGhTSXpwSHowMk9aNjhjdEZZWG5kVTYyQVNnTGNmalptVEZ4N2lz?=
 =?utf-8?B?aGtNWUxvZFVNQXY3SUZjbDZDYlFCTDFmRDNSemtNSUJOZk5IQjlabTJ5TDFK?=
 =?utf-8?B?a09LRmduTitYZW5zemx4TmpvdG1pU3VMRTlNbFlPQXFMU2FWblhzOUVTNitE?=
 =?utf-8?B?ZW1ndEdJeForeC9QeGpXVExBRFNwNFNaUERrTVNaaW1rYXd5ZS9zQ29BTFRr?=
 =?utf-8?B?RlpWZ1BiUDR1QUhIcWY2c0pvWGNiUkZiclk4aHg1SENJYmYvRDRXc2hRSnhs?=
 =?utf-8?B?NWVZN3hzZXRJUlZsWTU0blZYWXBBNEg1blVpSnFRbm5uMmNkYVJJMW85ems4?=
 =?utf-8?B?enl1cVdoWFhVY25QYnJ5MzZOMzYrdHFBZWF6L2IwK2pqK0xaTSt5UlkzSHRP?=
 =?utf-8?B?RDBzWW0xSGNrT3Uvem9ZNEswOXV0bmpwQ09IRFhBS09zdDdkLzk3bmgvT0ZB?=
 =?utf-8?B?S0Z3OG9iaTJMTExZcWJuVE9lSHhTZTZKNnpLdGgwbGZ6RUFRc1JacWUwWjNj?=
 =?utf-8?B?VXYycGx5ZmNZd1NwY0N3VXNwcXJoYUNPdEgrcXVRSVg5SzJWdWE5OUlldnl2?=
 =?utf-8?B?UnA2UkRCR09WZnVyWkJVT0Fmbk1TdWY4aUVzbXEvOVhPOW5Ta2gxcVpDSTRt?=
 =?utf-8?B?cEtIdTZpaUZYMlJkMG5PZ0tZTlpBaGZQWEVac05FRGxkOU5DT3k2WGZ2TXNs?=
 =?utf-8?B?VnZ1Vk5CdUd6Z2dwZ2VQdnBUOHhQQXhqZ25kRHlOcWt5YU1uOGFLUURXTDk2?=
 =?utf-8?B?WTJTTEI1Um5MeGhIc09NSXEvb3J6UXhVa0h6d1V6ZHZNZmcwNHNDZk9DLzl3?=
 =?utf-8?B?dGZyT3lnNnpubkVzdXpFS2NjK3FqK2QyNGE0eWdkd082Qzh6WXRNYnBETXdS?=
 =?utf-8?B?M3EwZ1hqTWJIaXI4WXRQSGxuN0phRVVWcnFLZHV5WFZoa2s4akpPYnZoemhu?=
 =?utf-8?B?UUoxWjlvODh2WUUydElyOGZ2MXNET3E1QTR5dG9sRThpKzh6ZEJqZ3lZRGhG?=
 =?utf-8?B?a1VqSlRpRXpVZTJoMzhjMytGK0EwWDNRWDhVcWp3bTJiMWEvcytCMGdHbkV3?=
 =?utf-8?B?RVAxZ1VicDk0YW5pbDd3WlB1M3NDSGpPYXRsYmtpWThMZWpnN0R1L2lPWUx3?=
 =?utf-8?B?bytzKzZ3TTJ3NFBVNHJzSk50QytDbXVWL21VbE9GeWVqVFo0NEF3OWovWll6?=
 =?utf-8?B?b1R4TnZnU3Rrdkd4UUFHWnJvYlI1YkZpK2MzWEZiWDc5T1RjWDZ4T1V0Yk5h?=
 =?utf-8?B?YytiTFcyMHJrVHlxS2kveWNVWVQwNEZNN0VvV1RyQUwvcFE5VUdETmZaVVV4?=
 =?utf-8?B?bGN2SnJWTEt3NWpJNmtVaVgwUVlLQkRQZnRqVmNIbFdOdEdOU2NSNFFxT1lL?=
 =?utf-8?B?a0RudU9MZnFrVUplZnVxeVBGVHZXKzZnRGd2MzFURWsveldiOHZMSk9FSExR?=
 =?utf-8?B?cE8wd1lwKzVPMEtBS1RDK2ZOc1kxY3FnVHVxVjBiUVV4VFlXZmpMRllsaHFk?=
 =?utf-8?B?MzlKWkt4cWIweEVPcnc2UytyUHBTaGFOUjFjbGRxek1GQkhvM0x6bndLT2hF?=
 =?utf-8?B?SDVIS2JQYTJnTWZpeVBHVW5MR2VoeGhIbmZzekxKWmhQamgrM2gvMjhLSkx1?=
 =?utf-8?B?MmQ4SmpnZUdmTVA1VmQwWUN6U2k0WGI1UDlNUWZIR25UbnorVk1YbCsrbWRD?=
 =?utf-8?B?a3VFQVRvbkxTRW5Ic2czQmtsOTFMWDRSZDFZemNqWnRSL2F2bzFmOUp6MEUv?=
 =?utf-8?B?QVFBNWVoS2F6NHBweGdwc1JVVnhYMTROQ09FdUhZNGlqNEZSUU9WSkN4azUz?=
 =?utf-8?B?cHorU1VZMWxuLzc4alVoeE9vRVhMUnpMYm9oZGgreERibkxuRjlldHZkOUVE?=
 =?utf-8?B?c254WE1idVlwMWt4akRxa2lDK3NyaWdVWEx6R3pJZmZyTGh6S3pnTWRnNVF5?=
 =?utf-8?B?VisrMGExUzFXLzMyaTdIK1k4NkEyd2FWR1kyV3d5c1Z0RkVESEFpQlAyMlV0?=
 =?utf-8?B?aWxsMG5rUGI4dHorN0pFKzE4QnlsSXlFeGduNXg0Zzhqb1NMdGVCMzZWamdW?=
 =?utf-8?B?UWFwcW1Ib1dhZE5jYlBpZnhicXdGblFGYkR0ZS8zNTdNbXZucnZyK2d1VkFL?=
 =?utf-8?Q?Yacgua7N9g9hw/jc=3D?=
X-Exchange-RoutingPolicyChecked: u3o+mhIHxvmBOfKqRSwqOSG3Nw8tcW7n6tbnmSaD7VeKnUXyVCIf99pt9gWmVBBhB9JzoufCgdZp3jKvXJDKkEJz663HfUiu3d5nRwY643ovPm3YhZcVKYg8Gn7KTuJjc5xGlySmJP/4tJB0a5bI+BUyBmxsVmerd5OSOIZlSKzxfGkkyFXYw4LQ+6qcGvIl9yeAe3aJN3xZWO78sOECwidimwGrRfY9WSK/YzhxQ4Q1GRC0hvk8A8d1wbLoxL16O6EcrnDqF1+iCZw8D5ER+OpMFzh7NOqHrSpYlM7uo6DvBRZk5tjEATzMMFpmcbEH9KNn4mHAuRjWtwh9alhJzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fde024-4e44-494a-8bf3-08de91c67d29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 21:18:02.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAv5d9d1RQVMgcBKUFR3RrzQeGq+SKWHL4couy/q3Vp7k/jTgPAM6snD4nn+vCY4ovBTVg4Sh7rW/i5Nzi0kDOgveAsmq4Eqw74F671pd7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9230
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275225-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0AAD639865D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/2026 12:44 PM, Harshitha Ramamurthy wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> Enable chrony and phc2sys to synchronize system clock to NIC clock.
> 
> The system cycle counters are sampled by the device to minimize the
> uncertainty window. If the system times are sampled in the host, the
> delta between pre and post readings is 100us or more due to AQ command
> latency. The system times returned by the device have a delta of ~1us,
> which enables significantly more accurate clock synchronization.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Kevin Yang <yyd@google.com>
> Reviewed-by: Naman Gulati <namangulati@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---

> +/*
> + * Convert a raw cycle count (e.g. from get_cycles()) to the system clock
> + * type specified by clockid. The system_time_snapshot must be taken before
> + * the cycle counter is sampled.
> + */
> +static int gve_cycles_to_timespec64(struct gve_priv *priv, clockid_t clockid,
> +				    struct system_time_snapshot *snap,
> +				    u64 cycles, struct timespec64 *ts)
> +{
> +	struct gve_cycles_to_clock_callback_ctx ctx = {0};
> +	struct system_device_crosststamp xtstamp;
> +	int err;
> +
> +	ctx.cycles = cycles;
> +	err = get_device_system_crosststamp(gve_cycles_to_clock_fn, &ctx, snap,
> +					    &xtstamp);
> +	if (err) {
> +		dev_err_ratelimited(&priv->pdev->dev,
> +				    "get_device_system_crosststamp() failed to convert %lld cycles to system time: %d\n",
> +				    cycles,
> +				    err);
> +		return err;
> +	}
> + 

This looks a lot like a cross timestamp (i.e. something like PCIe PTM)
Why not just implement the .crosstimestamp and PTP_SYS_OFF_PRECISE? Does
that not work properly? Or is this not really a cross timestamp despite
use of the get_device_system_crosststamp handler? :D

Thanks,
Jake

> +	switch (clockid) {
> +	case CLOCK_REALTIME:
> +		*ts = ktime_to_timespec64(xtstamp.sys_realtime);
> +		break;
> +	case CLOCK_MONOTONIC_RAW:
> +		*ts = ktime_to_timespec64(xtstamp.sys_monoraw);
> +		break;
> +	default:
> +		dev_err_ratelimited(&priv->pdev->dev,
> +				    "Cycle count conversion to clockid %d not supported\n",
> +				    clockid);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +

