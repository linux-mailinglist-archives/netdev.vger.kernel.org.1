Return-Path: <netdev+bounces-257906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Im6AKiRiWlz+wQAu9opvQ
	(envelope-from <netdev+bounces-257906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:50:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0DB10C9B1
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21FD53006B21
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DD330664;
	Mon,  9 Feb 2026 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6++EVjs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB291C2AA;
	Mon,  9 Feb 2026 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623382; cv=fail; b=gJ3lh30sMM8EJOexWBe+pyH6XSYY7vmayW/U0B8hxtD30ksiqusLMVxagDoAu2ElibAWU0SG636jgATK8Hx+wecbIYCCWxu0JoKv7POlgMg21qXEDrKKfHjCNJHlkH0akJkZVs81eKzaa2n+8iMyfU3msy8WdqfeYkWmTHxon7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623382; c=relaxed/simple;
	bh=PEhVmlSMytceMiyd9J6EQBf97lKiY5DtW9Buv1hw9i4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPqUt3nF+vK7SSbLaPryhiYJ/Z7tOiDeHpGo+PGX0y8MOjqSofzYCU+PxgDIoS74DmXeHV1EU2jrwSiEMgpe08dlaUppWy0ZWvd6H9f4hSh+L1mx68szcu4cCJ5fCrQ16LGmT+xqmsFWC9+F1+7U8kKkORDeMqxR0Fa07R1O4yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6++EVjs; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770623380; x=1802159380;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=PEhVmlSMytceMiyd9J6EQBf97lKiY5DtW9Buv1hw9i4=;
  b=R6++EVjstkFSwTBjCiLIjtZ02qi0ZwBia8FPH9sy9sm1PwnSODBJENbY
   FwBOFOVMitNLi00v2ppJG/jFHNJrHFYjXModpwavg/ziQaZo5GXa6XWeT
   aNIPjTPEuOEu+ZaOjEQ+lzVC8MMN4tHu5KFphcEEUIrJNEfhoc56bzrHh
   kkEJW/pfN4SiKdgmrXXhG7Myn07HyhmAU6IepdoMAv8K2CvWVIkCp7E1X
   aRj4Tk0V0pBCpxM/KVk5NwalxsiYUG5i1TEito1z4rH82D/EZkVYzLJyd
   xL7KA1um+IYuc4kf19NSsZBhrS9tiBpklu08p0KJp/z38BZTe/5dzeB+h
   A==;
X-CSE-ConnectionGUID: RAfh5FqBRYeGU5pNyWJ6Uw==
X-CSE-MsgGUID: jBuAH7w5TLGRH/03T9pEhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="94376174"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="94376174"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:49:40 -0800
X-CSE-ConnectionGUID: h19YQ8veQ/+YO5ifXpkD+A==
X-CSE-MsgGUID: ZRX7kVGlTVu8k7QQZcHmxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="242138271"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:49:40 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:49:39 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 23:49:39 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:49:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdEdbpJ7f23/r9Kfp7Xi5RrYqm8/g3dPWOzr9pVlbVowfdUOtpig578+0byikYGNlc8ZRUWwzPVGjxI2bKjO9iNzA13ZoXljiT9Ih32ww46gvDrdAx2+KJ43G61hSn2+BJTFGnbp1JoSo2YEecbMjR12D2xLobC9Xci4cIoQTP80gyzUqSr6NtQ9iJU9XPZUnj0tF0dCYS1Sk8cR3D5BwtyTezDT7PC3C+QgSyZdQFHESWpHcWmh0I/SMPkengB5dyy9Qh4MBo/7JTF079upQ4VOCVbR5W1A57rZpiPIDEglrQAEsI4Y6o8qb6cz5zbXj/0ShZZP5443CyspnqJHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il8PJxmbs0Z58Kz6f3PoMRUu5+w3SDOAgrBgeEEzFHQ=;
 b=u1VrXOKCOQN5/6iZY/QCmxQv8GJ0fUf5udNDE+vIyy6pnCN1/1t7P+B961eulotDY1Z7tiR8ijOF39ROSQBnKjEV6YKEwmHDJvn2AzaMy0sw88xX8OU5Dv0I7YU83QOEMnzvMr0z08wN1tpK5c0ItUhPZEcX0grNRABY31J9V7ypMn7nOAeqQi4fUWLJEH8bxocczHXX4Rj5Dssj8w4nCKQTiSumrxHXY9UTtj3wMQc0re/LmOTvVDLS0OT8kWmrs76KGGHmBX1CV9XC6fNZsFZtwAcCzOZCERN5FwiDevX26bds+elXO0dJfa1XuSJw0IhvstdESZtW5ysDcXii5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB8245.namprd11.prod.outlook.com (2603:10b6:208:448::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:49:37 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::1289:ce98:2865:68db]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::1289:ce98:2865:68db%2]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 07:49:37 +0000
Date: Mon, 9 Feb 2026 08:49:21 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?=
	<rbm@suse.com>, Jason Xing <kernelxing@tencent.com>, Magnus Karlsson
	<magnus.karlsson@intel.com>, "open list:KERNEL SELFTEST FRAMEWORK"
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf 0/2] Fix some corner cases in xskxceiver
Message-ID: <aYmRgUywMBnkGS2O@soc-5CG4396X81.clients.intel.com>
References: <20260203155103.2305816-1-larysa.zaremba@intel.com>
 <CAADnVQLszbJ=dMjmAVkj1zGBPhhopU7XHH6bc1UHEemXwbgxzQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLszbJ=dMjmAVkj1zGBPhhopU7XHH6bc1UHEemXwbgxzQ@mail.gmail.com>
X-ClientProxiedBy: VI1P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: e7159241-32fb-4496-0d87-08de67afc557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akd2amtGMmoxY1ppLzVzRzlDdTJPTHhMZVMvUDRPL0NZOVZ3Z2hpajdwcmx2?=
 =?utf-8?B?YnJqclVBRVI5OWFxSzUwMlNTMUdObmdUUGtuWlpadnQyYXZiQklKcjBJUU11?=
 =?utf-8?B?OWo1ZEZhZ0trRWtyS2xZNVBtUHhYU2RkdzI1bUFYN1liakMzTFIzeHlzWXBu?=
 =?utf-8?B?NVZ2d3pGWEF2LzZnRGo2NjJqb3MzZWVRQVdpYTRuZWFPU1FtRmRSMWpmNFVp?=
 =?utf-8?B?ZDkxYktmdTE5dDdITXEwZ3ozWXZjK3doemZJTmtqbzhlV3FvZHZiT0o5b2ZD?=
 =?utf-8?B?TXVJM0MwRy8xeHcyNWY2dFJoT1FQYWdvWkpXKzV6MXhXUHFJWXN1MC9sT05x?=
 =?utf-8?B?aFJKNWVhQzBZSG9TZ2h5ZHJWU00wazdMUkVwQmVTK3NQZm5jNlJpeUhKQVhZ?=
 =?utf-8?B?TFU5M2VsTTY2UkRaTkpMMGJVN3dMQXAxZERNSnRvRzV4RjJRMVpXREJlSHgw?=
 =?utf-8?B?WHFJblN3RkZydGFkdldneGRtS01sQVpZbXdiRmk5UUk4WWhWazBES0Roelo3?=
 =?utf-8?B?SjZGYnpaZzk5a3h2TDJjVkJuRkdHK01kaWxDSTFQV0IwSCszSlB2T0hyZUhh?=
 =?utf-8?B?UWtaeU5BRFJpbTdjVHUrcURhQ2puUXp2RUtITXBLRVQyVkR5N0dCWWJKSDZ1?=
 =?utf-8?B?ajdncVRCV0tQd0ZCakRON29SaU5pOTRnYmsybW52ODgzbU5qOTM0WWN0cmRh?=
 =?utf-8?B?Slk1VWNiMFEzTDcrVC9VaWJRZ0prdC9oME9hQXovRlc0bFhBR2tJR1krdFpH?=
 =?utf-8?B?M3BFNzFoVHFpb1JJWVJudXQ5ZE5ERU9lcG1uRHc1eXRhLzBRcEEzc1p3bTFQ?=
 =?utf-8?B?WmI3eDh1NEl1aS80d1RzaFNhVlZtS0cvUnlHRStEZWtRZkJLL3Y0YUFLcHFT?=
 =?utf-8?B?M0pEUUFzdkFjY01sc1gwTkZxeThZczRJbHlndFl5RHV2ZmxBeFcwbU4vZUdO?=
 =?utf-8?B?U29VOGNpdVhRNzZkUTVWamJqMTNqcHFFRGZHaFVGcXdTNTl5L3NRMzByZnUr?=
 =?utf-8?B?UDNDSVprSVNwOUQ1elBGNElETS9pRWVUWE9oZlFNTDV3NnlKYnJ2c20xOTBL?=
 =?utf-8?B?ZXZOeGFBczJ3VndBQ2ZGNzE4ZVJHQVd3Y2ExQkFoZWFiTER6Rk85bmlqSmta?=
 =?utf-8?B?NmZkeXYwZlVQQ04vUWNrZ2JrQkF1bEMwZm1Zc1U3OE5NZHhDTGlQcmFrL25j?=
 =?utf-8?B?MmdIekw3RGNqV0lJYjJidHdtSEVUT0FZQ29La2RtU3RpcjVjV29sdytiZ1I1?=
 =?utf-8?B?dnh5VzJiQlphcVRkbTVwVDdqc3BjMldBdTBWcXVHTk4zMWpEKzdwdC9TQllW?=
 =?utf-8?B?aXJocEg0RkY3SHJJeVJncjZFTXVMYStCeGdrZ3A4bExacXVMbEluYUZkN2RE?=
 =?utf-8?B?cHZnblN2clBIcDFyZ0hCa3k2bHpiYW5RcStCYVhmODV1OVVoY3k4b041OUJT?=
 =?utf-8?B?QzVYMEZkSFhuaFl2RVpOeVN2Z2gyQ05CaHlqQVoxWGJDbHc3eUhvQW1ub2ov?=
 =?utf-8?B?dkhWYllZM2J1RjhudFdRcjRwKzhFbitkVmwrVG5qRVVnbkVQS29KWlRMTElY?=
 =?utf-8?B?SHJjbVVVV1ZMR2kyaDNHY3VSZENlV0YwbVdvdGhqaGpEZm5nMVhwajkzV2NM?=
 =?utf-8?B?aHpkNkF0NDc2am55dFFEVHp0UFVoNWJIYlY5OTh4VTM4SzVuZ2tYei9xNFdG?=
 =?utf-8?B?ZFBkVlJhTzdreXpMWnlFY3puRXNRMVNUZEhxdGthUXEzWGdTMWZYYjA5dHdH?=
 =?utf-8?B?V3RNaENiZ3Z0QzkxMVcvU1RQaFJXSUcySGJaRG5vZ3g2bFJlZlozUVp1R2Y3?=
 =?utf-8?B?L1NrMzl6NUovRUxQNFBUbUNBZVRPTDRGVEhhMVdUVWlDZStuN0JuUkpBaDJT?=
 =?utf-8?B?eUVXVXBraDlkU1pJSEY5RzEzaFpJc29YRWR0eTNmNGtJVnVpR2pUSGdNekNY?=
 =?utf-8?B?WjZvMjRwbUlJbk1BSFFkV0IxbmRybUpUMnU4WFhqZ0dCajJGS3UveU9CRHdD?=
 =?utf-8?B?ejZtOFIxaVQ0SUZuT0hzeEJlVU81WlFlTXVGaTUyeU9XWkJldWtydHlXU3V5?=
 =?utf-8?B?cWU4MmxSdUVuUHBjZk82MThBWkZpUmhUczRsNlUwWmNUY1hJYlFGT21zeWhz?=
 =?utf-8?Q?yomsbaEtQgvkIBhU5Bn6TX+0u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBjdk13cWl3S2gvcC9zK25vQ0xQVE1SbkIycHlET01tT0xkQktVRlcrWCtv?=
 =?utf-8?B?amRsZ0tEODI4Qm5kallpRzkrelRNMUNoanFDS1l2QWw4cVBNU2Y0ejFjTTRN?=
 =?utf-8?B?aEZTSVF5QlVQVUJINFp1NFByQk5YOXRlandyMXhoTWYzM2tpNS9EUU5RTFph?=
 =?utf-8?B?VDd2TWRMeFV5Y05OeVdSK0RXdkhydHZoTFozL3orTytwOCswUU4wZHBWRlJ2?=
 =?utf-8?B?RncyTUdGeUNONTdQZjVoeENKWWZZRWJqT3lwaW9QZFlTQ2ttUFVybU1PcE95?=
 =?utf-8?B?eXVPTzlPZUhtdXdmdGYwTnlDRm05bFBSTUlHV2EwbGY1dEpCQTBDRzQ1dmlz?=
 =?utf-8?B?WHVIeWhxeVhIcXNFaHFUQ0NKc2FuRURZN2htLzluSFdhcGVXeEk4T2x5Tkdy?=
 =?utf-8?B?Ni9BUXhXN3lrTWI3NzlhT1h1aStYUSs2QnFCbktnZkpsSkRia0VoRytIMlJ2?=
 =?utf-8?B?VXhWUTRQU0NvYTRJOTdxUkhOTmlwa2lQNEJ3aTdzbmZWRjFlcnlwZnlCMlRu?=
 =?utf-8?B?NXY0eGFJNkl0UWYvK1c3NGVCMllWTDJUaWQ4OW1yN1VJaTh5ZFZNZUw0cHlh?=
 =?utf-8?B?WWdGdmI0eU5uRm5XOHF4QUhmRkRkSm56WGxPOTZFREVRY0d4dVhXZlZKanYy?=
 =?utf-8?B?cW9LQ1FiZmYwOEFnNHIyeXYxYjFYcCt4NzdUaGlQbWkzWFNtZFVwS0ozMktG?=
 =?utf-8?B?OWxNQWJzNFBHUlN6QlNkVm1TY3NPYnYzYUVaTy81NUNZNzVjS2FwSVVHMlVM?=
 =?utf-8?B?Y1VPZ1dNWmQ3Nms3TXpoK3hjb0E1M2V6Vm1RbVhucXAyNWsvcGNYUEJuNWpB?=
 =?utf-8?B?WDFrMUtkL2l4OTFqa3l1NVF4SnYwV01kcTFEWXpTNld0M0Y1U1o5OVpXZW5s?=
 =?utf-8?B?a1BwY2pEMXFseFdyOXhHQVJNQjlFZ1NUV1ozQm9FN0dLV3hTYTN5bmVQamY4?=
 =?utf-8?B?UHAxTVZmY1RMWGVkYkRETm1seWlaT013YTN0cU5kZkdRaDdzQWQwL0hCUGdN?=
 =?utf-8?B?R1NsVkpzOTZXeEJFdENOdVZVVXV0QjBRQzFSSjFKRUpla3VTMFl0SWFWQ2VY?=
 =?utf-8?B?YTgwM21FQTVMbHhxZGJoL1JKdVpjS2hlcUlhZUlhblpUWFB3T2g3UkZ5eTVB?=
 =?utf-8?B?VzZlcVpoU284NndYbEhDUmo4VXhkb2QrSEFFY2NDbGtWRjJBamdQL3doNTJo?=
 =?utf-8?B?VVJHT2ZwRzNxM3hIeE5vK05OSUJyZzNHRUp5VTRBT1JoaUhnT0xsM3ZQNWxx?=
 =?utf-8?B?cHBYQUhUWFBVdnhuQmJibUplT1RlOStDN0NEVGlyaXpXbmRCYVpjeXdXRDhr?=
 =?utf-8?B?U0dsQnFQU2FMMWFEZkhDQm12RUpkSmtaME1uOEg3MzNzelIvZTFvT0Fyc28v?=
 =?utf-8?B?UGpVZWdJbUlCdnlzcGx3ek1HSVRocjdyb2VoSUJybjAxL0hjK1Y1Qk5QcEU2?=
 =?utf-8?B?MkFJUEJKWW5FNGpBZjlpU0YyT1QvSkNTcjB2VlkySGVuR1NMRllYY01FVnNv?=
 =?utf-8?B?NjBHVUZTcFlLUElJeHhIdENMdzRUb2dKWlJJdEJ6R2ZreXBwc0w4V2h2VWFm?=
 =?utf-8?B?Vk5VTXBhNTI1SUVpdHlGWFlnQVJ2RU9HbnVjVzlRKzdubmVIZ2tINFpFaTc2?=
 =?utf-8?B?TGN4eVV3VWJiTC9ZY3dmUno5azNzR1BRY1pGTXlTOEdpcFBDdkp3RHpmbDdB?=
 =?utf-8?B?dUNSSzJITGZObndRencrR2RIRmd5czdtVjN3TzJDbHdycjY0d29IYnArVE42?=
 =?utf-8?B?WGFrZzhMU1J6RjVEYnNIS0xrOVhxQkpoUS9vQS92UVExSWZhalBHczJiUzFS?=
 =?utf-8?B?NC85VSt4YUJtUmh4bDJ5c2RWZVlZYXIzZWJpam9qSDVKcGZpKzlWck4rRXF6?=
 =?utf-8?B?TkhzeU9SQ2xoNkh0NG9CZHJkSWRzS0JzOGdPd0xFSGRHUm16VzF3MWJrd3Q5?=
 =?utf-8?B?eWdaWXZsbTUvNmh1aXRmV3E0ek1abUJMTkdUd1p4SWFsWmRkNzcyZi9xZVd6?=
 =?utf-8?B?ZDYwc2F4K1c5NllFRXNScjhMSDFGaEd2WWgrTytrTzVVVGV6QXpobWtEOU5H?=
 =?utf-8?B?Y29qbEZaNmRQK1BoYU9Mb1VGUjhscDRhNnl2dXlFSWFMWGJLNlU5Zk10U29v?=
 =?utf-8?B?T252VXJOUXJIaFkyRlJQeFlwMnBIcDByendqbzlMajlJS2ZlaDJBYnNvemFj?=
 =?utf-8?B?Q244SG9UeWlJNHN3R3JUeEtmeHhGeTJJbjR2NHZhaGt3ckhROUIybDNFY2lN?=
 =?utf-8?B?T3RhdlhmTFNkVXROcmVqZWZnTytTLzdqTkZINE5UMmt6RHdBcmMzQjBlZk5z?=
 =?utf-8?B?YVR6WlRXdlgrZGlkeFIyRWpUOXNXbC9pM0plSDNyak5ySmJKT29oR1Vpeko4?=
 =?utf-8?Q?OcPtU3fwuQ1iAg+t8NEsxz7PIjZXreG++PkKffuf7clnZ?=
X-MS-Exchange-AntiSpam-MessageData-1: 033jBdLKq6srxRELub8fG7ZdOqsz0fxdQ10=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7159241-32fb-4496-0d87-08de67afc557
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 07:49:37.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyRGKBxQ5eAskD2DgPyegtjuEcKyAXv30pMLhttTii3UmG/ZqQVg6tHts8Fbug5Qeq/8+k+1y9uYEfOzolwQmOF91xpJ/N7oBVJHIR8ArtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8245
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257906-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,google.com,davemloft.net,intel.com,bootlin.com,suse.com,tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9D0DB10C9B1
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 09:39:16AM -0800, Alexei Starovoitov wrote:
> On Tue, Feb 3, 2026 at 8:18 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > While working on XDP and AF_XDP support for ixgbevf driver,
> > I came across two distinct problems that caused tests to fail
> > when they shouldn't have.
> 
> Applied.
> 
> What is the status of kernel side fixes?
> 
> Running test_xsk.sh I see plenty of
> 
> [   93.609026] BUG: Bad page state in process xskxceiver  pfn:115920
> ...
> [   93.633927]  bad_page.cold+0xd0/0x140
> [   93.633929]  __free_frozen_pages+0x85a/0x1150
> [   93.633935]  bpf_xdp_adjust_tail+0x808/0x1120


I believe the call trace that you see when running test_xsk.sh is due to test 
24: XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF. I have this call trace too, when running 
automated veth test and when running xskxceiver in skb mode on a page-pool-using 
driver (WiP ixgbevf). The problem is specifically in the skb mode.

The patchset I have recently submitted fixes tail-growing in multi-buffer 
packets, veth is not affected. Those issues are weirdly not related in any way.

Maciej has submitted a patchset that fixes the skb mode some time ago [0], I can 
confirm it gets rid of the call traces.

[0] 
https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/#t

