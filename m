Return-Path: <netdev+bounces-157732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7BA0B686
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC2A7A18CB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE822A4C6;
	Mon, 13 Jan 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZIWH351"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9122C339
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770525; cv=fail; b=an81UlhkLmziShBIUhQqwyB6W69YPCzBTWajNECTiTvwZneJ61klR90MmjzUVTvvkg28SFYHve+wJPIEmZh40T3Wswad6QmtglHSLghq0OT1JQBKV75UJ33RUT0us0xNTsoMZiNMt/9gFLcZks7oPQCp5/8x+o355Nu745/yNJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770525; c=relaxed/simple;
	bh=Q0LQtomphkA3oTVJTnr8wi0Tq3SINZKfRAntrUablIo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTt32qJA8FgaHtRr3bvhRGmz04in2GO5nZsbxcoY5VQORthGtGrDfvC80WBuTpqHtoo2FC+fhDHkehmrRlao9kD4tpjmg51n5Xw1hWTYrs+jh8IylyLUh7NLBMV6j+o3R2mTxS5KIT5VG1hC1a8Gvp3BxnGIBGOGehX1keFH0/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZIWH351; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736770524; x=1768306524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q0LQtomphkA3oTVJTnr8wi0Tq3SINZKfRAntrUablIo=;
  b=DZIWH351E7CT6az6QoTf1cLxXveGJn/zA3fpSb/emBe2TRp6f/PzZ7sJ
   bOwWwnon/WUtjpCLiiI81hAyCV5oVX76ae3kmS9bMgW1kkKsCKdx8o4LH
   o56k3yZ1Esp+/TlA/IU3hBrK1Z+bhlEu9QpPiGWJxeSQB0mknwQlGY4lY
   pZ49MXdtxEOG2d6rIJ6L3SA7Z58dtvCD2hLHrm3w3jiPuQDEUqXlIL2WZ
   qSVvo29TyZxUf4Rx2Tme2W90nVQT4Lj23sUNFkNaShcHCjdDQnODo4Q9U
   CWUdOU7h0pKBQQ+BFjuurZ/AUF4BwPb74A6JgqkX0yaXF4Pk8+/sMxUU0
   A==;
X-CSE-ConnectionGUID: TqGWLNQXSdWy02DeXgKgew==
X-CSE-MsgGUID: VoLIbSe/RQaj+TQ3o198ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40796156"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40796156"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:15:05 -0800
X-CSE-ConnectionGUID: Y4olR3Z+ROi2k/ZKIx5HUA==
X-CSE-MsgGUID: G7WGaEzNQYuOdD/sWZs4KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104973861"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 04:15:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 04:15:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 04:15:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 04:15:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBSuNFgwkLEeq4P9KTI6SOaI41jzwMm4hn3XzuC8bHnmkj0Ev337e1N2J45AbLaADmCoLjVCG0Po2CfKm8dddr+Rc81ssJd/4kHTmO1R45QUDYpV79zzrU2cf22a9H0usKdro9Owc1UUQr/LiYkXNJmX0gQwQAJ2zfIKlJ37bNFub3Uch+V+p8BHXb+jBOgy6Lz5ieRMqS2pC67eaiq7cre/bbo6mkZhDR1Eawf3tQ6gqVvp/vjZko5Ok6DPTiTq9D7FEEjtt14Q5aZP2JwbUwmVjRK11pE+MlErhh22Tdm0Z8I04rYOKJDY9PEkK2nscpqJDlYIpG/RIm6HU1mT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Izennxr4NeoPu+7wCzJm4P0ZxCAqOLDjfUBn1hbKMs=;
 b=u5xNWGNrKA8xYjqzdF3zNV3qtuOe5rSKSfNByWFmd08AEjdOzj2FTM/goMf+Gr49z/q7gKqX9tjT1Gbicl8BG8W7kpkwyt9gSnoGV3MzY7V0WfwhiuJXPzm6KqGjIhOBYKUr+EXANrrJrpsZrFHbFQu5CQ8hClEthsN9XrrU8rvpAjZ448wD7y2WaqPz1KZCc+SeM2wMnlu7R7N5kj6T4GI6ZmS2eb0EWESUsWDQ5UTX6nO7+CBvxi8WHvbyimrf4VorcU4oSM75buutAdd3uUJpmx7Iwd9AaQhxzOrIglzNh7cquTjCWVT6tXrjgE/385g8J6szM99/47gzdPFMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:14:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:14:20 +0000
Message-ID: <8d2dddb6-483f-4a25-bfd8-7f010e369e8c@intel.com>
Date: Mon, 13 Jan 2025 13:14:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: remove init_dummy_netdev()
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<matttbe@kernel.org>, <martineau@kernel.org>, <geliang@kernel.org>,
	<steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<mptcp@lists.linux.dev>
References: <20250113003456.3904110-1-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250113003456.3904110-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c321351-1bd3-4257-e663-08dd33cbcf3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXMzQUZnakt0dUlpYTVDd0VoWnE3QnR1NnprVVJPQUtWTVhBN1pYVE1xMGdj?=
 =?utf-8?B?RXpYTStCa2xmblFaaFRZYXNWQjdTWDdlbG1NZlFXSWJaaEthbm5USmU1eklw?=
 =?utf-8?B?ZVlRclFLT2QrU256UXJrckJkVE5xSEZnVzBFWTRPVXFteDRrZ2RFeEpFOEhw?=
 =?utf-8?B?MmtGbjhSS2ZoYmVNMy9YbkM5OXJKMTdKUVFSbHVrWmozYWZJeXVIS3ArdWFi?=
 =?utf-8?B?VXJzTWNOL3FUdmlOcEprMlRidm5wSmt6aGlJV2ZoL3U5UUF3aHR4NDNZOUs5?=
 =?utf-8?B?dGE2djEyZElTVEdCY2VIc293dkxybURvbUZvZ3o0S2N1UDVWRHcrU2tId1lq?=
 =?utf-8?B?QUYxeXY1Qmw4bUo1amExTEdKdjVVVVRtdFNCT1VwUXdFNUppSmtSa09VbzJR?=
 =?utf-8?B?RkhGcDJDSDM0THhGbGJlWUZYUll1OCsrSHpZSWFNaGQyRUtlMFNZZHFWaWRi?=
 =?utf-8?B?WEVqWjQ1blpLMXE3Sk5TWXhieVZ2RU90L3UzYXVkZUNLQU9yY1B2Z1NGWUdV?=
 =?utf-8?B?WUt4M1VmSGJrM3k3bEswRk1lOURHck1IdGt0VWRFVjRrcnU2d3lSY1h3QUhU?=
 =?utf-8?B?U3lhVXkwN0NLRHRHMTNmWWFUVEI2eFEzL2wvSjdiUEhnNHByMmRFK3ZOUGVR?=
 =?utf-8?B?dklwc3AvYnRoVkNOTHQ0S3lOb0xEa0dIMmZvREtOWGhSWmVCNU5CbEZ3ZmhN?=
 =?utf-8?B?ZW14aUErWWlIOWRUY0Z2WVVROWh5R1g2Z3NxV2RtTDExY0toVG9XeGk1NnJ0?=
 =?utf-8?B?UDNKRWZ5dUZiektOYU40YU1yS0puV1poenZVYkdpT1pDVERVVGsvYS9FRjNK?=
 =?utf-8?B?c21SaWpRUzQwcXoxNDNEWDJhcjduT2JoS1NvaGFkVHRrWkhPcG8rbjNsbDRN?=
 =?utf-8?B?OHdUZDlJaWY1ZmN4QU5OMkthSjVBbTFKMWU2Q0NmU2dYYVQ0SU80WkRxc2Nh?=
 =?utf-8?B?Mi9tVFhnMEl5bEw2ZGkwTmNLUGhqM0ZaeERuSFRBNnkzZTI3NGQwQWt4SkND?=
 =?utf-8?B?S2dEM1UvNXY3dWIwMzFzU0lKWWxCWWhCaWdmZTNDSlpSeXd5MVducS9OWldl?=
 =?utf-8?B?UjhpTXJLcjgvZEhEdEp0RnlWcERVV1BTTkg0T2Z0TVZKbXlTaEhJVzBrM2FL?=
 =?utf-8?B?YVREeFQ3OEJjL1VSSmVuekErRlZCcXA4S3RyTmRXbXMvMDMwQnV0cyt3WGh0?=
 =?utf-8?B?ZkE2alkydk51VitJeVFvTVZ6VDR5cHo5OFZMM0xoOW9VWXpReGpYMjJvVlRo?=
 =?utf-8?B?cVRjWW53R01ya2hlOXhKZVI3N2RlS3g4MVV0ZVJHS3JuY0FVR2ZoOTFkVHRH?=
 =?utf-8?B?OElVKzRMbTFhS1hPVTE1WHF3MHA5d1U4QXloSlRmUFVTUzFxRE1HN28rZ1B5?=
 =?utf-8?B?S0w3cEc3Qi9WNVNadVdFUVBVb0huTHpjMlB0N0dXelVJRzZnSEJYN05oTWpt?=
 =?utf-8?B?WFJNNGMyNW40YW9kcmtBSVRpMjVuSzM2YTJUTHNDVnQ3STdPdHluNzQycGUw?=
 =?utf-8?B?djhQeEgzRVBrV1F5RW5Ta0ZOQ013ZGR4RFlUZU9jRS9GYWg2QXJRbnRjRlBs?=
 =?utf-8?B?VlNKdUFkajdkZ3ArT2k0MVNid3RpVnJmczdCbzhHQnpHQ3dNTVZJWlh2OGV2?=
 =?utf-8?B?aStMY0lwWlpCQk1LUW5JamtuOHc4Y25ob2lDVFlJSmRsWVlmUFVGWDZucWEw?=
 =?utf-8?B?SjUrSmc1QmFMeEhzdHZodWtEdXFFTEwxbnhzaWt4NXFJRVFsSTNjaXNCQU1j?=
 =?utf-8?B?eklWMlR4am5JQTZBT2EvRnV1S2E4cUZZblcwYUlqMCs5UXErdytobWZ5UFNL?=
 =?utf-8?B?dWZJV3JWU29qV0ZuRHJhZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW16VGRQTHplSjZLQ2hjUEI0c2NDRUdPNHRWRGM0Z3dRZ3M1QUxzVUdEelBn?=
 =?utf-8?B?QmlVQTY4djVsUlE3L3dUWUhrcHlFc1lObkIvN2ZzYnhvSWVDUXB0WTRDMU5E?=
 =?utf-8?B?S0JpdVdmNmpwd20rMFZUY0dBZmFpMDFwcXFZVnVXOHZMQ3dWUnpkR3ZROTVW?=
 =?utf-8?B?bzFhYlNyNWRQWG52R2doUUNrRHJseE55NmhJa3lOR3lqN1ZoYnVWL3dtTmcr?=
 =?utf-8?B?ZjRTakVDdVNvZ1NZQWdlYjBMOThWa0I2NVliRUx6SGVQRzlNUmpHR25pU0hn?=
 =?utf-8?B?aUZTNW1KSTRTcVk3L1VDQzEzSEUxd040dUUyUTgxV0I0K0xRRnROVXBZZTE0?=
 =?utf-8?B?bnp4WDZuSm5MNnZVb2hyMXdVSFFNTC9qQkZzODQwSkpvUzZSTGZyODNEbzNU?=
 =?utf-8?B?Rkt6N1IyRU5NYm4ySzA0aWZLSEFIanhWWXlRanQ5ZUlPRHc2cjYxdjQwVmti?=
 =?utf-8?B?Vm1pZUJwTGZxRGxqeGtRNk9KYVZFRDJVcFoxaGU5QmpjSzlHNjJaQTUyUGo4?=
 =?utf-8?B?UjhITURESi8wUjEyNW9aUDB3dHF4QVRsQmlFVlJLK05jbVBzcUpyYzZFWkt3?=
 =?utf-8?B?WndybDAxWEtJZFZnR1k3aFVpaTF3R3ZYT3M3ajlVM0o4RTBqMHZkSkNRc2Qw?=
 =?utf-8?B?YXJrRkpNbmwrZW1XRUlBNk1xMzlTVEpwL1lRWHR6V20veEZEQkhyTEZEbmJM?=
 =?utf-8?B?WmYzaTd3YnNTVnI5M3V6N1c1bnZDbDlqRmJYcEpPdnRjY2I2SVJ6dE1NNE5D?=
 =?utf-8?B?YWhKdVpkZVRxRlBEbisrL2g0M3VmYjRkU1RKQXovU1BMYzY5d0xKTC8xaGNn?=
 =?utf-8?B?aGhLL1cxRXRnRTVPc2wraVVsa0lJb0JqbDhQWDhvQ1JaVHBBNytoT3hpTFZ5?=
 =?utf-8?B?alk5TGdlTVdEL0NMNmhTUk9GU2VZNXpMVGhJVjJhekk1Y1E3bUtsUnpXNFFn?=
 =?utf-8?B?U2oyRHFscUk5ejNuZ2ttQjFWcmw2dGlMWmYveTdvcXpjQ2JjUnNnQkV6UStF?=
 =?utf-8?B?RllmWUFLZXFqTTNneHJrbkNTdERtWWoySktBUTVBUEdRdXpWbTdvSmdIdTVh?=
 =?utf-8?B?ck1CYVJaVEhNZWFFM0ExSUZOOWVIb3JGTnB6bzRQb1VWWDZhS3lIb2hDQlBi?=
 =?utf-8?B?ZzBZbXNKbXdHV3Z3ekkvUTYwTCthdHQvUEtINC93NDlOYW4zMkR4ZGx0MFIy?=
 =?utf-8?B?dlhTZjFvclJ6MUNWYm9HV0M4STh6bWNpRytNNDFBeWYwaWt4OFNnWTZDWG1L?=
 =?utf-8?B?NXZNVnZiY0dlVkxXcnhCajJRS2JTZlowL1FxWWRsc3d2WHJiQllPZEJBaE5W?=
 =?utf-8?B?N0tFVWxSbFg5V3doNWFKT3c4Y21pcDBDNGh6RklsK1doK3pMOHZCSEhZaFR6?=
 =?utf-8?B?a1J2Y2NQVmQyZnFDOUFCZVkwT1ZOaW1WVGYxNERZRWtEczZmMjBJcEtycGFP?=
 =?utf-8?B?SkxIdU4rSWhMa0hzcjlKcUd4MDNxUlZGV3NhSU9wTDM4cWxOU2dWeXp1c0Zs?=
 =?utf-8?B?TjJpL3dnRHZ0WFVkSHBJVGdlNk1UNkZ2YXNmTUNBM3MvTmxqRjF6VUYyQU4v?=
 =?utf-8?B?NVpIZ2hnQ2NpV3QzV1hZeHgzeTlsOXFZS2d5MmNLdHEvRDA5dHRhQTZ2N0FN?=
 =?utf-8?B?aU1hOEJsMU1YU09JczlNWWJUMU9RbDEvTWI0ajUxL3N6cnJKcnJzN2JuTzNY?=
 =?utf-8?B?WGt1eHh4cy90Y1cwb0dLeFR4Z1k1eXZYUjZMMEc1V3JPNjRET2hGUzN3UDYx?=
 =?utf-8?B?akdGNUlnK2JUSmFJVEZ2Y2tEQ0NNMkdtRUpwZWM1TS9RMlh4VEd2Y3h0a0JT?=
 =?utf-8?B?eGFiVjhPLzkyUHJTNHhuWStUYUMvYUZkakF6THN1NzJBdmZaZXJjaU5MT3Ro?=
 =?utf-8?B?VHpHYWpnNFcxMjJkRFZEUDVQSlRWeS9UNkZtU1JkaUFwS0NvYU5wMlNMTWlX?=
 =?utf-8?B?bXI2L1Q5ekhzNEZqUDJKajFtTjZMSmt3b2hDQVdvQThPdmhCT1ZPLys5UVMr?=
 =?utf-8?B?SGtHeTYyZ2VQM1BoN1FRR3BFVTJ5TDVyd3VGQlB1Smw4REE3ZmlXLytpcTRK?=
 =?utf-8?B?WjhaWUUweWJxMjMyempWUlVWVS9GTFBzbkdKUlFzeFlpK21wRXFFOFg0ZXNq?=
 =?utf-8?B?YUFqZi8yam1UZWVsV2NDTU9yaGxpZWo5V2ZSR2xnNSszRHRwa1dOeHlpQUQ0?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c321351-1bd3-4257-e663-08dd33cbcf3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:14:20.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8RkAJiCBSKx2B8PBpEavST8nJ5yIqGbVDaYkI+ex1L9tR9Yp7aPcPYH3JSz5uHMgMLDD/fNjm086CaPk4KJYcjP1bwVgZO+7f+CTyVJ8LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Sun, 12 Jan 2025 16:34:55 -0800

> init_dummy_netdev() can initialize statically declared or embedded
> net_devices. Such netdevs did not come from alloc_netdev_mqs().
> After recent work by Breno, there are the only two cases where
> we have do that.
> 
> Switch those cases to alloc_netdev_mqs() and delete init_dummy_netdev().
> Dealing with static netdevs is not worth the maintenance burden.

Series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: change of plan, delete init_dummy_netdev() completely
> v1: https://lore.kernel.org/20250111065955.3698801-1-kuba@kernel.org

Thanks,
Olek

