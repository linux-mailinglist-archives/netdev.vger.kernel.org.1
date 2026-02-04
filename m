Return-Path: <netdev+bounces-256856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INn1ODfNg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:50:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346BED129
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF99B3011766
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20342314A82;
	Wed,  4 Feb 2026 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FH0ol7qL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEF18A6CF;
	Wed,  4 Feb 2026 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245429; cv=fail; b=a9LKaGpSre+5HN8Wy/fjx1k1I07AYVN0ocFfdsQWhdsd4zUCBW34RyxJ2qcmW6aAGwt2QXapRekVZVNFzpkjGflVTL9fI3TbXzifyoO5p2WCAB9qgwlTfT03gQU2hJkEWRQFRTCiE+r/JTJI9XwYGm/9Z9+Bpjy/shSfZgwHyS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245429; c=relaxed/simple;
	bh=fAqj9+iT9wLjsvF8wZfThylHqjA9lyyT+zxKrge1W0E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=szfe9nMJX3Mn/Vjh1JKHoNY6mFqZrUJui1JYMsaQSmu8k3D/qy+5/6XUBkvwxWC7xXArbz0r32dYcPmzVo6kh9f0BhvdeZGnJymBxbPNBJKp5kcp7GaDuEraOd+xr+32bzhZl3vpJDJPjV4BiJ/qI5qZothvQdPve3TdXCYSjI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FH0ol7qL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770245427; x=1801781427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fAqj9+iT9wLjsvF8wZfThylHqjA9lyyT+zxKrge1W0E=;
  b=FH0ol7qLmg0uozhuZDQlTCvyyEtmngjb2g5R77IWx0qW1EWivuHlnThw
   GouvrVrbnJWQ/bRtZuGWIpdn9A1dBP8fyYT8qIhKt8pKmMoui6NxKvmCs
   5v1DARqTSWyYxvkDU2uJ5H+fAGMWPqm8Ci6Q/cN6oRdEkJp6yVYVcLbOp
   VHpSx9n2G50YOX7WhZHRYcA6Gmj5LrgpGPz22XJnSzcKE0arAbJv6lSqM
   gvDFMc7EL/aOHDudM5IMJk47C1LYsD9beqUmhze6OOIUbxbFPa0uiyCkN
   YU2Wwu+Q7Q29LygmScAVT3PxfBJIJpFGVjE/2J4mn62dP5hN5+B/ePNZB
   w==;
X-CSE-ConnectionGUID: Q7u/QqiXSMGam0/DBrxUsA==
X-CSE-MsgGUID: tdU3zsg0T8+cc0biO9MQSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88864849"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="88864849"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 14:50:26 -0800
X-CSE-ConnectionGUID: qEYTMG2kRByex7HgzwB0YQ==
X-CSE-MsgGUID: oJdTaUNhTw+emwukp1hUAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="209597131"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 14:50:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 14:50:25 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 14:50:25 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 14:50:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHKxp08e0SwGxKyZfL62GP37La3twLdpyzB6eG3yGydTb8ZwoJvBjy7v1O3KfNTpM7WXPJXxzFg5B/IyrxYVw8ywoJJkDRb8VaIKHK5A3nxOibbMIABh2oWiXWJ7o42Hk7gk9FCSBZkoW0xTWWEdbTWOVySHjcHlqstobg94ibHw5oyQnemaYiUv2CdzvzFHhsJBLGFJux2IHbC+K2IhUiDs0OgRK3w7Z85cojzOMrjwjOvfaLhK+zEk2G6vb1OMJYUtcmEQD4/l8Uy1eLiwhTwAE4WYWSGfG7WEtxKl96VoJsGu+F6T73Zk5oMGjnUQ/jQ90qLa7MoB7uy3hs4jRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItU2p3NwiRB4iqMyb9OKRwwC6kcCGFEpO0n75waLY+g=;
 b=G5YkYidvhzhM56woP1G3wmrOscJCTMZTA2xMaUpeKWg9PxRKAEy1MYmjDl7J/cM5ql39ZCZ1JNWr+eNawVwd8XtgBPyYd41h+pElMnbaxfnA9qSHloRGMGc2YTo6WCjZDUBp2jdOleLjPQMqH6vFwyrDOMBO8tUF66lfoRlxdmfWzAbFlv5fbQAV/nyHANPKEQmwvtXV1P5e9BUb4v6aIJpbi8JcFhAUSRLJ3GcBAGdwjqCPvbgNDGB+rv8qRkUyKHluYLCEoplTDSmKHhO9aIN8LSBnTGpfooMlo27+eMn2prbQup70W1IV2Zr7+FGH9d8ovUYUqODs4SdlIGUbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA1PR11MB7111.namprd11.prod.outlook.com (2603:10b6:806:2b5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Wed, 4 Feb 2026 22:50:18 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 22:50:18 +0000
Message-ID: <46190ba0-9cb3-4488-abdb-977fd8fda381@intel.com>
Date: Wed, 4 Feb 2026 14:50:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: stmmac: Disable queues before tx_disable
To: <muhammad.nazim.amirul.nazle.asmade@altera.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260204021558.24592-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260204021558.24592-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:303:8d::7) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA1PR11MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2290e917-1f7e-40c9-3a69-08de643fc4c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3BCUkQrTitUOGV2cmZwR21QWkJzbkp5QnJCRzVqc2o1ODNpN0tLbmNXUG5m?=
 =?utf-8?B?VzE0b3lPQWU0b3pEaEE4VW9FZmQyM2ZvQXNDcXltd3VzbVRwUlAvTnFRSVZz?=
 =?utf-8?B?QUZCSnh3K2s4YURKcU53bTF0RGRZRWNzWVBjZWJqN0ZyT1dtWXJVemRleWtt?=
 =?utf-8?B?TkIydkIwb0lhUEp2UDQyZUVod1R0Z2lEVWpDSWZrc0ZkWkJDYTNlSm5oUnd3?=
 =?utf-8?B?d3hCS2o4WUdWY3A4OEpWbjR1WGdhTEtjVEx0MWp4eEszcDNwSE5LeVFybVk2?=
 =?utf-8?B?RjRUSWNaekxSUC92STliYXluQUZpNEZaa3l2QXlZTERDdmtlUEZVV3hXVU1p?=
 =?utf-8?B?UmI1SDRTeDg2QmVkR2xmNXFPR2tBYVB5anlxRVArQndKblplajJwRm01elBF?=
 =?utf-8?B?ZVF0Tk5IVUxZTmc2cVJ0VVhLZGVMQU53TENLb2dFcVQ4VUNQc0lvMWhEQzRE?=
 =?utf-8?B?Q2l2YkpHeWgyV2Qyd0gzSVpZQ3B0QytXSm54UkNBZHFFdnFVSG9Tai9xZEJL?=
 =?utf-8?B?eTJkRnZuNHBVUEVkRkpxaG0rWlNieVdyNWIrSGw2TVVrOWY3M3cxZS9WL2pj?=
 =?utf-8?B?SDUvdEV4NHZ0ZTJnczk1NW5DcnI2UnNBYVBPWklndWw5VVRSNEg4SVJvUElq?=
 =?utf-8?B?OUUyWEh0VkNXbVluT09lNmhCYWMvMkJHOTZBdDRlMTJISmpGRnFFRDQ5cVVa?=
 =?utf-8?B?d3c4UGZNMXNBYzhvb3pLZDB5SFdCbTJ6NzV1Z3BGOTBBWGw1NDFLY2JvdjdQ?=
 =?utf-8?B?Q01Vem8yeXgyYjQwdHR6SzBSbFVYbG5SckpIU3VXQURoSU52YWtkdjh6OERk?=
 =?utf-8?B?Vkt0UmVFVlpNTFZUeFkvQ21UVFBDSHlhZitxbXgyUjJHSnQvMTRaMEZOaEZN?=
 =?utf-8?B?NWFCTEpvdzhhSlZhb0FTYy9WUXo5aWhQSDIva0RZM2ZrOU54NHNOdjlZSFho?=
 =?utf-8?B?VjBmOXRZZWZEKzBqZHVKVGRZYi9yMUJBZFBHZ00yMFdVM2lBY2lTSXBkdzRs?=
 =?utf-8?B?OVdhR1UxYStPd2pVTGg5TFRVZjU4TEFwMWxtMFp4ZnlyTDJSSHB5WlBpWDVp?=
 =?utf-8?B?TWZJellhV3FHMWprRFNaYUtnVnNKVlFCRzkzdldaVU9PSWZ1aFF0ejhjZy9T?=
 =?utf-8?B?MFVpdldjZkZRTUJJcE1DNVh3OEJZTHJsTnBRMnc0TDRUMGFkU1JNWWRYYXIx?=
 =?utf-8?B?UmV0ZTlZbUJTNTVHNUc5NmpDRThxQnFtNWVpRnpseStGdDMxOXBaSmJQZm5Q?=
 =?utf-8?B?MFpVaW1yazNYRy9Rakwxa25EanRZNzE4Z0xnQ3RRSEdZeXlSRnIycEFnQ3ll?=
 =?utf-8?B?NXNEWEo3TTJNVnplTzRwVm5ydmV5MVJXSVRYbnJNaUtFRVplQjVhdmhqUUNu?=
 =?utf-8?B?UjZ6Q3FRSm14dDliQlFtZnBhR2ZTRHJnRStEeS8wa2F5V3ZHOVdhVDBMaktL?=
 =?utf-8?B?WkU2LzRQSXpTUmF5MzBvcUFaQmtLNVFHSmFycC8rWnE1NzI4RjhGckx5QWJG?=
 =?utf-8?B?Mk10dWI4NWY0UjBjRHRQQzdjQW1tMG9pNGdXcGxYZDBoaWJQazRQbzRMOU8z?=
 =?utf-8?B?eDR4RGxsVjdHZ2E0YzZpeUg0clh1SThVZlZDZ1dkeWRsbnlKLy9KaTB1ZlBM?=
 =?utf-8?B?Y09JYm9FZlpkVFRxRmZzNXBtaEFHKzN3bE82dzg0OWMzbFhacm9lSDdnbU5X?=
 =?utf-8?B?cHNyOGpGZHpsQ1dVTis0YXN3a1lMQ3JObVU0c2Q4bDEwcXNpWWxXQWhXWDBP?=
 =?utf-8?B?MkhpeXpkVDVVai9ya1N3OVowZm1uWk9ObFZBS1h6MjZIc25Eclh4U3JaVzZQ?=
 =?utf-8?B?UjRVc3dYVzE0T002KzlhQ0o2NFpjS0drL05ETFUrTnVQRTExTVJVeXRaL0hx?=
 =?utf-8?B?L0ZJOXY3N01sV3lrTk44QkpUU0N4bkM4cGJTR1FRcUMzaEJEaUJUQWY5cG5P?=
 =?utf-8?B?UzJzSEdKc0NlaGlQY0hvRW51RWQxL2ZtSjlFd3pDeEtRUXVOSHA1bFlqWWN4?=
 =?utf-8?B?R25keDdrU1RMNXpKWFFNYi9HTHZuVFRwMitaYm9Xa05GU3hHc2VweGhhMkI4?=
 =?utf-8?B?dWVPNlRHcUhYOFNYODZSWGpiZDBTV3pOOGRMbHFzOHYxbjVIckcvcUtXK01R?=
 =?utf-8?Q?rUu4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01WMlF2eTc2Z0p5bElVNm9hVm9wN3N4b1NFcEUzYXZCNTN5SzZHczBJYXJu?=
 =?utf-8?B?ckc0RjNKTStLS1FjRE1YTEJhTDJJRXhlcjlPcWxHYWRMcUcwUjZIZTdvWVZ5?=
 =?utf-8?B?QzA3R2NiVFdLd1IyQklaZERha0ZQSTdoVHpTUkNYOVgwSUpoSlFnQlFCby9J?=
 =?utf-8?B?ZkpIcGpUN3VWU1Q5SkRnbUlXOG03dFRHbXFvVGMzaGlRaTg5cXpLZ05nbjNJ?=
 =?utf-8?B?NTduVFZkYzROQmdxTkowUjhCaDNidUJWd0JyTGpIN2NoZXR3ZXFZRzFGTk5L?=
 =?utf-8?B?cUprSHhCZ0hhdVVFeTNhQ3FqL2kzc2NrWVpVRDQwZ1V6dWVaYnNyeTl4eXdu?=
 =?utf-8?B?R0VjN1RWU0hGbG54WFh1NUFqMy9sSlFLVElHWGRwSlN5YSttZlpudjRaVVM1?=
 =?utf-8?B?cmRNdzNiK1pRTzhvMGRHU0ZIMUgxdlkzN3QyTENVT1d4aDE5R1RiSXdYeHoz?=
 =?utf-8?B?Yi9OMWV6a2t0SldweUlKUExtTjQwMWRFbERlTnVOc1djSTQ3Y2xWM1l3Mm9B?=
 =?utf-8?B?QUhJYVpTcEVUdlV3Nm9tNVNMeThXZy9NSEpoNWdWRmVTRlh6OHNLOGV4VnR5?=
 =?utf-8?B?bjBPSXNRSFVpU2h6anJKZDN1c2Nxa2FVVk42RThxYVZidzJ1ZVBydzVMeTZI?=
 =?utf-8?B?NjA3eHVnOER2U2lrTGhaNDdRaVB4TWpETXpkUFBOYzFhbDdZMnUxUGx5cTkv?=
 =?utf-8?B?UmFpL0dpOUtpN1BySVN5Tkdpck5XSUxibzlPRTRrSEZ1a0tFdTRRTUo1aHYw?=
 =?utf-8?B?NTI2WmVMWlc5YVZkMVVoenN1bHQ3SkdyMEFWS1I5TnJwcWhLS3IxR0grRi8w?=
 =?utf-8?B?T3BkV3BYQWVQNU5IVFVTUHM3UnVlSExyTC9QQ3dITTRHY0ZucmFRU1N3NTd6?=
 =?utf-8?B?N0hpRjIwZ1hJTFAzcnduQzkxUjEweStEaUlXRWFMWUxRWUQybUxnOHBaZkpj?=
 =?utf-8?B?Qm83cEkzeVJwSjJxdWg2eWNHZ0FiZnl0dVhpc1dLU1pyencxU0FRa0JXZjAw?=
 =?utf-8?B?M0lHbk04YTJycG8wUUN0SjRuNUhrdlI5clJzRS9uNytqdm5pQXVHTEQySFZm?=
 =?utf-8?B?NDBwL0ZNSXYyR0M5d0ozMURkSUdzVG5SU013MHdZbXQxWnpOeE1UNUl0dEJ0?=
 =?utf-8?B?djBvVVlUc2tLWWpGSE8rYTBndXVWaURsc0ozS2VKejBZVS9OS204aTV2UlBs?=
 =?utf-8?B?ek9mYmc4dU1Ea3FNY2NPSnhieFdZY1VSOFRwNTdJRWNIelhDVEc2bXRrTEF0?=
 =?utf-8?B?blQ4NUduS1o5QnFqaG44Y08xcFZpVVYrTkREVndWRzd2emlhVUlvT3hiMUVG?=
 =?utf-8?B?K0ZmU040bU9GSHlxck90akpkdG15NlZaa1RNVXF1Q2QyMUxaa1h5Z1RnTXpO?=
 =?utf-8?B?T1BqOVZRcXVHQlNHcURPUDc3SHZ3SStXaWtrL3dYQ251RnlqeUZNeTdxVDdz?=
 =?utf-8?B?djVIVTBpZitDcDVobW1zVU9kbko2TUpEcXV0ZysyeGtSa2hMa2tTRjh3a3Q5?=
 =?utf-8?B?S2l5YzhkanN0MGhJWHJpa2FwMmdkU0JrUElPWWJYYTVMWC94QkFzczllWG5x?=
 =?utf-8?B?WEdlN0xlaVRBSndPUGdOdGZjOWNsVjJ2RGNjYkpKTlVhdXZYM2N0SXAxY2RG?=
 =?utf-8?B?U29XMnJJaUwwcW0xSjdUaE5QOGZuMkt5eWtOSVlaNCtiYjVVTXNFb21xK3Ev?=
 =?utf-8?B?WnJ4aFM5UjZIVVNhV0JtMkFYaEtRVHZRdEs2SlA2NWM4dEFjNDJFQWNaZlc2?=
 =?utf-8?B?TncwZ281VHlzY1Vhc01RakZYL1hOL2VFSk1ET1I4RXh6U25GSktuajRDM2pN?=
 =?utf-8?B?ZmdSN1VyOWsxcUZJc2RRTEpXemxBdUo4UExRRE44RTVYcTFMajZyUzdLMmto?=
 =?utf-8?B?eWJ3M215K1YwZHBKRkN3Qmw1S1g4UC9RU0MvTjZVbnU0UnlwUHV4NjlORUFV?=
 =?utf-8?B?SW5VR1JjMThjWTBicndLRHZQQm9hbUVlNUZCOWJ3U3RwNmxkWnprZWxMTDQ3?=
 =?utf-8?B?c0hKekdSSjREN25PWWtPRm9jdjhCYWpocUNxdTN0djdETy9WTWlOV0dseUgv?=
 =?utf-8?B?MThESkhDQkJ5SEIzajZNSXF3RmlXa0pCU0lDNGdxc2J0MXlvUEFjNS9VQ1NP?=
 =?utf-8?B?ejVFcmZXcHlJR1pIMWRYVHV3Qnk4SmsvaklZbFk2NFJhNStxS2tYZ091TmUx?=
 =?utf-8?B?cDVoUHZJRWNHVzQ4bThuUXA1Z0tQdE1vd1h2TWxPcUxtTjR3MDJBejFtbXdk?=
 =?utf-8?B?UDl5YXBqczRDNUs3K05BdzYvRUNLQXlQNk5NSzUzUWZ2S2E4RWR4ZkJmR1BO?=
 =?utf-8?B?K1ZSZUdUK2szR3J0dDNIQXNIZEI1M2VISEgwRTl2M2VEY2I2bjZLUGVtNkZK?=
 =?utf-8?Q?1z5MKiZvu9LdB5Cc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2290e917-1f7e-40c9-3a69-08de643fc4c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:50:18.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWkTk+mTS3uQrLmTKFlcOrDZht7r7z7C8ynngnpQ20LuK7wdAGQU6kctdhf8iGU+CWdyaO9n5X4FJzQX2Q6b1fX3CcuwSTGTljtwDO7hY54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7111
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256856-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4346BED129
X-Rspamd-Action: no action



On 2/3/2026 6:15 PM, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Disable all queues and disconnect before tx_disable in stmmac_xdp_release
> to prevent a corner case where packet may be still queued at the same time
> tx_disable is called resulting in kernel panic if some packet still has to
> be processed.
> 

It is helpful to include a (trimmed) copy of the panic if you have one.

> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This is a net fix which should have the net tag in the subject and a 
Fixes commit. If it is a regression you should tag as the commit which 
introduced it. Otherwise, indicate the first commit which added 
stmmac_xdp_release().

I saw that there is also __sttmac_release which calls 
stmmac_disable_all_queues() first before calling netif_tx_disable(), so 
this aligns the XDP case with the non-XDP case, so this seems like the 
right approach.

The stmmac_disable_all_queue essentially just calls napi_disable on all 
of the appropriate queues. The netif_tx_disable() calls 
netif_tx_stop_queue() on each queue....


I don't actually know the proper sequencing here. I see several other 
drivers seem to have their napi_disable happening after the call to 
netif_tx_disable. It seems to me like the existing code should be safe, 
at least based on many other driver examples.

I think we need to see the supposed panic to understand the problem and 
whether this fix is correct.

> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index da206b24aaed..7f5a6f30c231 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6967,15 +6967,15 @@ void stmmac_xdp_release(struct net_device *dev)
>   	struct stmmac_priv *priv = netdev_priv(dev);
>   	u32 chan;
>   
> -	/* Ensure tx function is not running */
> -	netif_tx_disable(dev);
> -
>   	/* Disable NAPI process */
>   	stmmac_disable_all_queues(priv);
>   
>   	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>   		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>   

The only other action here is to cancel some tx_queue hrtimer? Could 
this have an impact?

> +	/* Ensure tx function is not running */
> +	netif_tx_disable(dev);
> +
>   	/* Free the IRQ lines */
>   	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>   


