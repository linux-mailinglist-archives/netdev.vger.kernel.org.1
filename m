Return-Path: <netdev+bounces-292446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CtJA85aF2oPBQgAu9opvQ
	(envelope-from <netdev+bounces-292446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:57:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9AB5EA482
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B643F312791B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C133B5F50;
	Wed, 27 May 2026 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1yYhSne"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7E3B19BB;
	Wed, 27 May 2026 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915131; cv=fail; b=UUrYKTZ5xtqKZNQWJw4qsN19zdLW7z93c975+MZ+JKDKHnejvuto9PT6wU0boy4p5xJNtTXNeMwIRF4GLcThbkzu8Tke5co0ll/6n56/hQpt59lX9Mjncln5NjZ3/xaDPyMJXMYP7xGUopMFrhsBtkNNjQ0UBme00A0s6K3bd08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915131; c=relaxed/simple;
	bh=sWW5Yy7yby/Evbo+sBZfgJH74jerPPvCe004ivc9NMQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uRhZD9CStGZOlSF4ZdnpzOzE9gsN3hfeDmn8d0a77rh4vcxBJyLfFop9QaUgcAA3rjmGRvVJdwCnUhDgKcCYYdNFOJDRbpxBoGcR6eRkU7h8/Q2HF4jW2fziPMs6MgkEol/HDEOYWL2tfMo+O9RYoDzvr/Ug4GWfrBGOq+4ot1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1yYhSne; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779915130; x=1811451130;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sWW5Yy7yby/Evbo+sBZfgJH74jerPPvCe004ivc9NMQ=;
  b=L1yYhSne7KjZU7Sns8PogXtZJH+0Kii4lTnRGeUpWWtZhGAw4qeXwkE0
   +LgY8rH7yPANUrvbSQjaDuNCk/wqwgeToTfaaTYqAzv9xWtb0XiboHWjj
   ypCMVvi1iDMwwStyNAY94LjHHBY6OWWiIqdQ5Gg2wq72vbPAEnERLVYD7
   xCEDgARyBIo6pAGmARhsGKcFpWjfMvZuZZaw8wcK99DnllxNpQf0C41Uh
   65/uUDShz/deYMuNBq0rOYJ348YEkrQuQG9wnKASqkC8UiYyd72Yk0pM1
   j/UWHOasXPYNfPU+++ZSdVTM22ZfjWlNriWKTi5uljfSR+t83kyIfwegM
   Q==;
X-CSE-ConnectionGUID: qzO+r08mTG2I+OERUveE7A==
X-CSE-MsgGUID: gqMgFfHWSYmn7k/8Imzsig==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80610069"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80610069"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:52:09 -0700
X-CSE-ConnectionGUID: M8KOiLJuRnCjwwX9z53bHw==
X-CSE-MsgGUID: ixszWVkFRoyZtbMYDNyZMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247299567"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:52:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 13:52:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 13:52:07 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 13:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SA2H5d8q6vd5uL+Xu1z5o6UKAnKdIJ+aMNSK1/8TU5DZGFQgMYwBFC4j/VXK79qZFY57gHgWlPVwqd+I4AV6oj/W7a+WJOLb/TAMSlGXDwcmMGhyKkfZORvxvuF6aIINp1CD2koAicaR9Vm1vI8kD7Wm5RCVudgFRTdBNhogdbOtimY1hxPJQEbRB2a/oCuAL87Vxbgk7yHWx302UhSZINFkB4CmB5VmaP6zs30RUl87VXu3JfP0crYYc3m16D4M2llSZYpeIMQ5XUuXFj/ppY88SNImUMiTTG5/xnChsrqGxyZEbhe/TkL8hf0qO4dq6rzVuE+zORKDBMdUw6WpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhWTrObAM1xou6YPwQqyVLwYNOpGNhWhTpUZ+6VP3iQ=;
 b=DzgVwaF+QNwTCjGow5XL0SF3V7g6G/sB0Nf6lUaWy+tizbuzwhIRHUrbOixRsHTILDIOe4R1JQX3KpvN+fANui0/yfhgmgNX0Wg+1gHQQkp/9kTAPBFEZpbtOqJxqm98/1pScHocPUd6QLBk4h92srDSHXwKwam/P6ODmq7eC8tV5UBPnCdg3xE5YJqnATxp5eY7arGsp6HA4stgo5hxT/oK7XnxwCDEwD+b6WxyeMpAMiNd+mWLkaqKEN1joi+B1sdQ8OZAzE1C3fb4M9FyZ/SRjm9lYJZUK27QeIiSX6JORBOkh0O29V5lnzepQoN6LC5dgVrw8Xgqrcol0DMZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 20:52:04 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 20:52:04 +0000
Message-ID: <34d7edf8-1713-455f-ab24-b66f7355e1c7@intel.com>
Date: Wed, 27 May 2026 13:52:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: tg3: guard napi_disable and
 pci_disable_device calls
To: Yury Murashka <yurypm@arista.com>, <pavan.chebbi@broadcom.com>,
	<mchan@broadcom.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260527115535.1686932-1-yurypm@arista.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260527115535.1686932-1-yurypm@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA2PR11MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d740e92-c640-49a2-6392-08debc31cee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: cwu0F40NNxYlpUO2JA7Ejjn4vH74PEkY8URgunztM8434Og50HP2Xryin9YoJd7kB/75Z6Aub+1tr9tdo3ERjjjIZ+sKVy599szarFCQE3IS1lO8ugkvXMTZuZNZHgBHXkHucdocmGZ8CgjcQ6yNUbOrjRSvEKudPxSbZUnseRdC0PKrUuwURtZiXh7nhyH4PtsNcNiGwhGYj0+wVYXhI3oRA4aE3hyeeKfSc17XNIrlbp6gWOtPLrLn6c6qRcdkiGbe2pR8yV0RKgzbZAgl/71/g78Hj+zKSEUiXAsLbX28hS1Azf/oxoaYHl2iERVPWQnjOaXcvL20fKJRNUFI5ps3a58vUjO8y+amewJaK/55NOHsWtbmC4/Bbe+aut2WVxrU4ktmexzNpixBwyRLwPUFNVz2a9UgYcgbuh6RNPj4zn3AJYXsR4BwXh0HWxU88uQMl6EupyYtl0Va1jYsjnrK8tJcEkPxuCNDWLQ2oiTBj4v7tN5dovCqwjo+CERDw43XPzqzuRbQx5tdBKH1ACOhe0w62vcM7kXXRLhVEIJQW1yMKUJFUAJiklrnKdCX8Swfsq6dseyHNG4tQwlZVCLSPHk1VQaEqd8dsQaCGqYsrmr6Cy81ygl9tg8Hkuln9cXn4PoVcBqV2JHOhFbYyMe9U8bE4aqeCZZeuonR0SUoJrDXo72PPW5/zTiQ7Ymq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3FuMStlTG5hV1RGQUQ4NFg1UW01dXRQaFYycGZOc2xCZ1hvUmxWQUFLdDdX?=
 =?utf-8?B?MEtoOU9GQ3A5WE54Szl0SFVJN01wblU5aDNhTmlhSGplR3picTlMSDVQYjQv?=
 =?utf-8?B?cVRrSkk3Z3BlWWJTN0o4U0dhOW5QL2JVSDAxYUdJM2ZWTzVzY3BDeGhmRWNr?=
 =?utf-8?B?eThJYXpBbnhsUkJCU3hUMzRFOWJ3WElZUHQwNzF5ZFNRMG1JcDJGNmU5VVNJ?=
 =?utf-8?B?RFF1ZjVaU252dkZZTllJNm9UQzljU0tPd0FPWUppTmpEMEtFYmVVcjFGTk1J?=
 =?utf-8?B?OUhRajZiWHRwREtLNmZuQW0veVQyUG9ITk94Uk40eVptNEc3UE9yZHpjRUNY?=
 =?utf-8?B?UkprUzFrVTZyL1QvRGw2QldTMG9GRFVrM2Y3MUFPUmp2em1KVGZRMXhmY0RE?=
 =?utf-8?B?ZFBac2wwYVZTc0I4dmx6YldJcnQ2Ty8rMGNNNXpXcjFCOEhreW1OY2hjcGhs?=
 =?utf-8?B?Yk9vVzFrRWhBaXg4bHVpeDk1aUJFNGE1UnJ4SGN6aUZmUUNDUE1TOEJOMXho?=
 =?utf-8?B?K2c5TVN0amRoYlF0ZlIyTmVnakwvMDlONkltTUlXTzA0WjZDMW9zaFpTYVFk?=
 =?utf-8?B?Tys3V242blJSZ1NWdEFqbDRiaUtzWGVOYnFyeGpyQWZIOWdrV1R0L0RtZExa?=
 =?utf-8?B?STQ4Mk9sK284ZkZkakFZZ3BMMmp0Q3g0bFBHSFNjcXg0MDlDTldMWHA2TzVr?=
 =?utf-8?B?VlhMeWxoaVRQb0kzNmVybkVDeHdxKy9ldU1rL0pEaXRkS0dSOFNoQWxZWjVG?=
 =?utf-8?B?SXkyV20waTM1WHgwSGJ0a3daVzJqWHNqekh1bEhnNzRLRytGYUxXU0lMTDJN?=
 =?utf-8?B?bHUvYmF3c3FqaDNCRW1sd1NlTlVmdEdHeDFFdzNQQ3lFL1E5UU5vMFlhRUJG?=
 =?utf-8?B?UDIvUUp3ZGdWV253VlplNDVrdElVZmI2S3BmL3NrL0ZqMVVMUVRkUGJuakZj?=
 =?utf-8?B?d2F1VzB3M3NoWmxDbzVIOU5FOTZmMndPelBvdllXYVdLdFRFelRaaldmWW85?=
 =?utf-8?B?Y0tJVjVFUG9RbWcvNmVoVXF2ai9aQnovdTVHa1Y5OXVoUExsYkFYVlpNb1k0?=
 =?utf-8?B?RHp3NXJyVEMzUjBEeXdzaUNFOWFhTlo2UC9tTG5PaXZ4bWh1VUg0VjJWZW9i?=
 =?utf-8?B?amtOVi9aZ3pJK3JmM0Era01SWFhOUGR6L0I3T2MzNS8ybkVLV1NldGkreHNY?=
 =?utf-8?B?QURuMnZQUG1aeUNNS1FLeVZDRnhPMUgwM2w3ZWhFazU2dzQzcW5nUm9IUVNP?=
 =?utf-8?B?UHFaeXIyN2lPeGRpOGlVTWJrNjQxWVNoOXZtajNBaDZyM0ZTYk1TNGtDYnpW?=
 =?utf-8?B?aWJxTDRkQVpta1VobnNBaHhiWk5OYjA0cEJmQlpFTGZPQ3JaMDM3RzV4dWxO?=
 =?utf-8?B?UFR3WTNhODVTZSs0MTlvak9GNHQrSlk2VUFSMVd4VVJkbllrcXRITFJKOXha?=
 =?utf-8?B?QTlEb0RSNDRTRXRvSFlraG9YSFRnVGxGaE9jMmtFRlZYN1djSnQ3WG5tQ2hp?=
 =?utf-8?B?TEdzOW1NWW5SeXhkMElsbkt3dnpIM3VHTXdlWGRhNEUzR1FSbCs0UGlyM29o?=
 =?utf-8?B?MHgyd0tQMHd2bTdHZENCWG9HYWZidml4SjY1RnNDVUNXdFluWHpUaS82T21W?=
 =?utf-8?B?QlRpOUtzMXBoVXZvZk1wT211WEY5eDVtR3lwRHZ4NWlDTXFVRk9kdjhTNzM1?=
 =?utf-8?B?ZjNXNTY3TGt0MkRkQkNCZ1hramN3UTdMT1haMElCM3FsL0YreHlSU0lsNmVo?=
 =?utf-8?B?OSsrZFI0SmZYNCthanA2Z1JsRklPaFBWYUZnbFdSSW9oQVZFL002emc0Tjl3?=
 =?utf-8?B?Zk9ubWVxYm9CSVFLL3JlakZlUVBMZWI5bk1BTDVJQUhNcnJpbjhBcWxVU3pD?=
 =?utf-8?B?RmVkSTI2TTlXaHRUak1Eai9pS20wV1BjVUo3dnRtWU9VYkd1alNzb0lYY2Er?=
 =?utf-8?B?d2N3V3QxQ0hPVHExVU43MGxJaUZjTVNDbTZUd1EyZ2cxUFRYVW5jY2FNTTMr?=
 =?utf-8?B?OS9zeFFkb3VvekZWMDFxRnR1MnordWRXTkFtYTcyNloxZ2s0cHlvUE5pM3N0?=
 =?utf-8?B?eVI1ZU0ybHIrUi91NmNYRW9WZEg5Y05BV29MekJPZTBmV1FyUXZ2TlVvSWov?=
 =?utf-8?B?Z1c5dWc4QlZCNU9ULzZJR2gwV1BOMVpFQjFMVVZoaUMwRUZCQis3UXh3Z25H?=
 =?utf-8?B?aUFaWnQwMU5UUk9DT2kwK2xKQW5wS0MvZHJqY3FVRmRZVkdkaW9uajhaM2ZP?=
 =?utf-8?B?YThHQmVIeE1IdW5PN3N2N2VZVTh4Yi9EeGVJTENZWXhNOWd3NWxVMVhmckNl?=
 =?utf-8?B?RzBldHJON29jQzNiUVhTUlFJMGxLdGw1TStlOXhsUDIzZUtlOWZzUT09?=
X-Exchange-RoutingPolicyChecked: fnlfwCPDBNXsrLGexq+looFRvafIg3w2+BnTvKazk43gurmowEMLuLzQ97FXJnvZUl+6FUE5TjmAYKV9bORlRDbSTnbgxfPr4kaiA6VgmwU29jpQkTeSqgjHapSePNlJ8Ey3rwxoOdsENvOxIkqvu38tuT+/0KBydxYeHbwVz/6jjCSi4uoTtYSuHv3PzGdT7Qm/Zw5d6XLXsuAy/TTDxhvTpmu8xK7uNt9x5gbTgpBUBmxCuKG0unbp0H3IzGNIPxPZDW3cgkit6Hmzsd51Z/TvDW0ZJoJoH7+jO6qLtbQXb8rOpXajeoaMUJMDUtoxDJrX154LBUchsQgdtrIqjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d740e92-c640-49a2-6392-08debc31cee0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:52:04.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq3u10rrqLAmZnKI5tNye15WToltdtZGFUJL73jRKwGZe/f9JMNkFeVmTWUyRbcvjfZwOAMIYvTZn+sBrhoGsklPR6fPnBMfdUkpqMesVm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292446-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5A9AB5EA482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/2026 4:55 AM, Yury Murashka wrote:
> During PCIe hot-plug events, uncorrectable errors can be reported and
> AER recovery for the tg3 device is initiated by the AER kernel driver.
> The tg3_io_error_detected function is the AER error recovery handler.
> 
> From tg3_io_error_detected, we call tg3_netif_stop->tg3_napi_disable->
> napi_disable and return PCI_ERS_RESULT_NEED_RESET on non-fatal error.
> We expect that during AER recovery tg3_io_slot_reset and tg3_io_resume
> will be called. But AER error recovery can fail. For example, when one
> of PCIe devices on the same bus reports PCI_ERS_RESULT_NO_AER_DRIVER.
> As a result, tg3_io_slot_reset and tg3_io_resume are not called, PCIe
> device is disabled and NAPI is disabled (pci_disable_device and
> napi_disable are called from tg3_io_error_detected). Then we can try to
> disable PCIe link and napi_disable will be called again:
> 
>   napi_disable+0x1b/0x1b0
>   tg3_napi_disable+0x89/0xa0 [tg3]
>   tg3_netif_stop+0x37/0xe3 [tg3]
>   tg3_stop+0x30/0x160 [tg3]
>   tg3_close+0x2a/0x60 [tg3]
>   __dev_close_many+0xad/0x130
>   dev_close_many+0xb2/0x190
>   unregister_netdevice_many_notify+0x19d/0xa00
>   unregister_netdevice_queue+0xf8/0x140
>   unregister_netdev+0x1c/0x30
>   tg3_remove_one+0xaa/0x150 [tg3]
>   pci_device_remove+0x42/0xb0
>   device_release_driver_internal+0x19c/0x200
>   pci_stop_bus_device+0x85/0xb0
>   pci_stop_bus_device+0x2c/0xb0
>   pci_stop_bus_device+0x2c/0xb0
>   pci_stop_and_remove_bus_device+0x12/0x20
>   pciehp_unconfigure_device+0x9f/0x160
>   pciehp_disable_slot+0x67/0x100
>   pciehp_handle_presence_or_link_change+0x77/0x350
> 
> This is not expected by napi_disable and a thread can be locked in
> napi_disable forever. We have pcierr_recovery to cover a similar issue,
> but for fatal errors. We cannot reuse this flag because it is reset in
> tg3_io_resume, but it is not called when AER recovery fails.
> 
> Similarly, if an AER error is reported and tg3_io_error_detected calls
> pci_disable_device, a subsequent device removal via tg3_remove_one or
> tg3_shutdown will call pci_disable_device again for the already-disabled
> device.
> 
> Add a napi_enabled flag to struct tg3 to track whether napi_enable has
> been called. Guard tg3_napi_disable() so it returns early if NAPI was
> not previously enabled. Also guard pci_disable_device() calls in
> tg3_remove_one() and tg3_shutdown() with pci_is_enabled() to avoid
> disabling an already-disabled device.
> 
> Fixes: b45aa2f6192e ("tg3: Add EEH support")
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> ---
> v4:
>  - Rebased on the latest net tree and fixed indentation
> v3:
>  - Removed netdev_err() log from tg3_napi_disable() guard; silently
>    return instead
> v2:
>  - Rewrote commit message with full problem description and call trace
>  - Added Fixes tag
>  - Added "net" tree prefix to subject
> 
>  drivers/net/ethernet/broadcom/tg3.c | 14 ++++++++++++--
>  drivers/net/ethernet/broadcom/tg3.h |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 73a4b569b..86995e689 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -7398,6 +7398,11 @@ static void tg3_napi_disable(struct tg3 *tp)
>  	struct tg3_napi *tnapi;
>  	int i;
>  
> +	if (!tp->napi_enabled)
> +		return;
> +
> +	tp->napi_enabled = false;
> +
>  	for (i = tp->irq_cnt - 1; i >= 0; i--) {
>  		tnapi = &tp->napi[i];
>  		if (tnapi->tx_buffers) {
> @@ -7420,6 +7425,8 @@ static void tg3_napi_enable(struct tg3 *tp)
>  	struct tg3_napi *tnapi;
>  	int i;
>  
> +	tp->napi_enabled = true;
> +
>  	for (i = 0; i < tp->irq_cnt; i++) {
>  		tnapi = &tp->napi[i];
>  		napi_enable_locked(&tnapi->napi);
> @@ -17718,6 +17725,7 @@ static int tg3_init_one(struct pci_dev *pdev,
>  	tp->tx_mode = TG3_DEF_TX_MODE;
>  	tp->irq_sync = 1;
>  	tp->pcierr_recovery = false;
> +	tp->napi_enabled = false;
>  
>  	if (tg3_debug > 0)
>  		tp->msg_enable = tg3_debug;
> @@ -18099,7 +18107,8 @@ static void tg3_remove_one(struct pci_dev *pdev)
>  		}
>  		free_netdev(dev);
>  		pci_release_regions(pdev);
> -		pci_disable_device(pdev);
> +		if (pci_is_enabled(pdev))
> +			pci_disable_device(pdev);

Using pci_is_enabled() is ok, because we increment the ref counter when
we call pci_enable_device, so we know that the driver holds a ref unless
the io error path happened in which case we need to skip. Thus this
can't "lose" a pci_disable_device call because in that cause
pci_is_enabled would be true. Ok.

I was wondering if there was some existing function that folded the
pci_is_enabled check in, but there doesn't appear to be one. There is
"pci_disable_enabled_device()" but that skips the refcount and forcibly
disables the device. It's part of the power management code, not
intended for drivers to use directly.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

