Return-Path: <netdev+bounces-159247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E132A14E8E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3FF1886385
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96C1FCCE1;
	Fri, 17 Jan 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/zKId4S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7AE1FCFCB
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113888; cv=fail; b=JxzFWNyF/WSTtOqzCbiK6bMJAO5sDrR5m84u1yfAEDcQsTgzty7gRDdB9pMfAyNko6wK7NSzZss6aetB3fXllHc41wDQpPq6ucI5ivvIpDT33VI03bJM10M4tdzi/KZDUQOSM74uz/aStv2bg4h+J8dP6JjRrom2XMGGXySfbeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113888; c=relaxed/simple;
	bh=Kx5HpTcr2Qk3uLBOmfdFq+T4MO6mbX1WQVqoT+Zugyw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SkBClic3TxCr3jOMVI0IIVk2SKhwEPiScsm5Y8V1WNXd7aT/3NgUHjjKXRvwxCheiswzmFLPbHUxjfH0bpC+MfFcTkDNdgPqRkABDlWHcuyAzUJYy3eSFCofv8+ds79BXqtTl7VgzaxGuR65K2FEs8iJQ9epQ9WVKFzeW8y9RJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/zKId4S; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737113888; x=1768649888;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kx5HpTcr2Qk3uLBOmfdFq+T4MO6mbX1WQVqoT+Zugyw=;
  b=F/zKId4ST01HKN52mk9LYnJQexdOOvCnOQdpHvB7DePb/oaUMvgoFW7i
   6Iz+1IxeZ65Verau8QeQskB9c3ZxhULEYAqENDDKMr1W6pUwMO7bMklFu
   TWV+GLi8UCqB64Y1Tpp73Q72R+a0OeKLUU/wUsKrrkbVItjHDbYxAvXIk
   uUCT0VdbJ43dEPNH2VNLmH3ghp4fooQxbMKE0Z3hY5tjYFkiwzMClJ5ct
   0QoL8jBAQSs7uWg466kz8Olu/8MbQ9VCVQ4CBRA8qucp1BxQiwVXxCYGS
   S+z5MFfwhy4b6CQt1zCPmXJ0UHUTO69B5jyNrOjH94jdeMeDSzn2k6r9C
   g==;
X-CSE-ConnectionGUID: KOWS3FJpRdqFDZgK+E8eHQ==
X-CSE-MsgGUID: O8s08AeiS/+tlOb3kt4Eog==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54953712"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="54953712"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 03:38:07 -0800
X-CSE-ConnectionGUID: SsqMPq5aTJaQ92udKyv6/Q==
X-CSE-MsgGUID: UMT9kpryTJu7+fmHbNkEhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143067466"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 03:38:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 03:38:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 03:38:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 03:38:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpWTofC9mn2Jc4u5jbXhjxn/bVgppe/GUVgqIRZ/wGdotmfcPjlpNV8rA2LCz75oSju9uENUQvWC5NbQpU/bJAIvRketeaxiZqCzkbYJiEWsCITkPfyfoZhownhEh+7d4GiOAQU2CBsT7f1nBj5BXDTjpzO/csdub0t2gohoL5Pq+Tn8sgT1FJ2uvOfkx85EJjcfERJ8lHG2uBlvnhmWgDtH/W0ncQv/FmElHGuYw7JwzG0WTFq164hBColyLpvu3dS71Dd0azqdH9ugJkb1ohVSbUy/jCu16Xqlv2l3icC598cYjKgYoCcY93LA/0d3T/vwUlUC4/aWjZIW4lImlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC4mGuCKzyYHWXCT+sakxumN5Hb5fgxFNp1OptPBDe0=;
 b=GFdco5+YB5AYXv5yoeY1AuG+VYMuQE/0uGe5IBHUjzo14SPdYdIg3bE+pKaLsav4Yx4EQQBvH1yrARwKPguI0tRWYT7Izdlv7lVsY8RLxYjxJi6w+ibeM+thEfNd8HiVQCanmAxzs0tCFxFj6DCGsszO0gclI1sKf2Mdx623XWYYVZ3CwpVFMr2ZJZLgCMnBxkQuf/11U7VIn9gaf0KrZfWiOyrNwiUbnlD5qzUe165Dz0OtZec0rpgSiKXwDHcROVGl59BdxgG5/IKY8UZnk+0Xj+y1N4SKTj/+FB4h8L2KltDD/Gb5qIrR3IZPnmcrG+LjFyr8ZF8FHJwqwgdLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 11:38:02 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 11:38:02 +0000
Message-ID: <e1c72812-ec53-4547-900e-9c9004098a4a@intel.com>
Date: Fri, 17 Jan 2025 12:37:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] mlxsw: Move Tx header handling to PCI driver
To: Petr Machata <petrm@nvidia.com>
CC: Richard Cochran <richardcochran@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <cover.1737044384.git.petrm@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1737044384.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0096.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN2PR11MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb1758f-3f2b-4905-4e15-08dd36eb669c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3dCRVptYlpoNEVtdlluMmx6eEJnSkFubEhNclJ4ZDl4c3NCdkxQTVpDcFh2?=
 =?utf-8?B?eTBqS0I5OWZBdE5kdEExcGlyQXNuZG1JQldzSW5IZ3pNclE2ZG9VWGZpR3pq?=
 =?utf-8?B?RVF0YzdmSWt1TjZjQnp4SlAySFRENHMzREtaNmZnRlYzODFIZ3F1STd2NXlI?=
 =?utf-8?B?N1FZS2hsMTNXaGZiTEtTaXhzKzQwd1ptUDdVVXJxcG45Qy9walN1QlU4WHRW?=
 =?utf-8?B?cHNLdjllMkh6Z0FMRDBEY1g1bzJueTJ3Zkt2NXhFUTRRK3hvbWFZRmZSck5G?=
 =?utf-8?B?VGJqYU5TTjdOUXNpL3Zjb0NaYjFZYlFBU2VsemVjcnJTVktlQ001MHFEM2ZL?=
 =?utf-8?B?VUFpWVlkY2MwSWFxbExqYXlDcUxRZU9ZeDRwU0dnc1hiNzVpZ1pFYnJreWt4?=
 =?utf-8?B?Z2dEZHdSM2xCK0F0ak5jcHpOOEdQSyszRUNoVXBlc2xQQnV4TlVEbmFERWQ2?=
 =?utf-8?B?TGh1QzVuTlg5UkYzQzA3YmZaMFZFTTNjanV6ZDZqMENldGpHeWRqRTBVNWVu?=
 =?utf-8?B?ZktiQVlpcjV4bzFhNGNVUWZFN2NWSUJ6RWo3ZjZQOTJiQzI3UXZLTEpJd3BT?=
 =?utf-8?B?bjVzWko4VU5yN1JUakk5aUlheEg5QkIrbXdLSjJ6WjJGaUhmdndRei9KWFZN?=
 =?utf-8?B?TDduUGgrTXpQcStvZDFLOTE1ZW00Q0JycFhBM3VGd24wSnk4TTd3WDRCK013?=
 =?utf-8?B?ZGJCMU9YTlNncG9JN3UvYnF0SEpHeHpGdHdCNlhvYXZGbVdva1pFcXFJRmlk?=
 =?utf-8?B?UHhyMUpncUlQZWNPWHBhYWNiRXpSUU1pSitWVlA2UTBtdVdEZWR6UVZUUVVH?=
 =?utf-8?B?Vk1EV3pNM3BlYzAvcHd1MHBzY2VRcjZrNFExMGc5RHhKL01DUlF5S0VTLzVQ?=
 =?utf-8?B?cjVCTWw1ZXFJcUl2dy9GMkdYVW9uSnJGWXZwZmhYUmZDOVRGWW83Qlp0U3BF?=
 =?utf-8?B?RXRwUWFsZ0FKdGtxcDR4by94eWxxblBueTFDVFN2Q0g3bEdSK2cvVnlCc1NH?=
 =?utf-8?B?c0EreXV2eFNJSEdud25rVXhCOVcxdTFRdVd2SkNRWE85NXN3dnVtb2YzS3NU?=
 =?utf-8?B?WnVqcXRsNC9KWTFVS1pQRHpxUTRWeUVKS2U4VExUSHNDNXhMSlZXaGM5Rldq?=
 =?utf-8?B?dE9OTnJOZkNITWZiZDZoV2xteHhYUkNJVUZkQWJ2WEY3YStrb0RlbSs4bmVN?=
 =?utf-8?B?dWpqZk9Pa2lkV2xXMmpCSEN4QWZFTTllVWwzN0tXNzBGRGZ4M1NTb1RJVjJm?=
 =?utf-8?B?dzR5YjI3NkRlSGlFZnBiRTlTVGFMclFmRElzTUliU0lkbExVU0NJYnI1M3NX?=
 =?utf-8?B?RkF5RTBuV0JoTy84RnNjK1IyK1dxZi9ycDlTendmZ3hZYko0cExRU1FTQmpp?=
 =?utf-8?B?RldPUlNHNUk4MDZNeTlEYmpuVEhzUkprN0x4OC80NFMxa0N4cHZ0SlRyNy9w?=
 =?utf-8?B?ckRJT2JWTzhqSDVXbzI5SU84b3hVQnVvb0FnT3JKd3V1bVNwcGtTVUx0Z28z?=
 =?utf-8?B?V2NlNnlmbWViUXFyQnZiL0cvVnByVkJDRU1nVU9MVEZrQUxzSVc3WUp5dFZH?=
 =?utf-8?B?Q3VWdzhvRG1JWG5EbFdzenQ1blFOL0dObEkzS3AyMGZ0ZmlwanJCYlpjNXdt?=
 =?utf-8?B?TFdnbnp5QXBWVTU5VDZDS0IrVVU2aVM4ZWZDdVYwK29jTVpKVWMwZEpCOTFp?=
 =?utf-8?B?eC8yZGZZQzlySE95SDVML0JBbHJ1NUFiOXkyS1dGdXlFTVdzalRKS1BZMHFu?=
 =?utf-8?B?U2NhVjV3d0ptN3BVZ2tMQzN2VnZVeGFxQmg5UjNmRG8rdzZSZXltYlkxOUpN?=
 =?utf-8?B?N2V3dFVVSm44cUNSSmNFcnNkSHhwa3ljdzA5MzZ0Mk9NRHJKeWVxTktCcDVH?=
 =?utf-8?Q?2F9TR1l1fzKHJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNMYzdZaG81dEhCUVo3eVJNamNNaG8xS3QzZmU1UGVpeHFSd1gxd0JOU091?=
 =?utf-8?B?QkhzZlR6WU1STVdTZUxOaVgzbERCakFYb0NtOUloOFV6eXFpMng1WVJZSUxU?=
 =?utf-8?B?ZXkwdllTMXRkVnVkZXVhc2U0Y2R4MFZCT0xFRElXN3VQbjJ5cU1QbmlCTys2?=
 =?utf-8?B?WUV4TWF6L2c5VUljcGdvdDZiQWZKa21XS0VRVTVycmI4d0hYOWYxNlVqMnk2?=
 =?utf-8?B?SWZJU1BTU216RWtsbUFibGt4bncxUUJwQlM4dVV1eEJCNWtIVU1NYnV4Y0ZE?=
 =?utf-8?B?d0piRVNKU0hhOHA0dE12ZlFoNWl2bWxzeHdYczl2TndUeDllazdUQVFEK1E1?=
 =?utf-8?B?VWZadGFKTDh1YTJlVlZ2U2Z5KzZvdUFHTkFWZlRUYnNDbVpHZDhDV3FQallj?=
 =?utf-8?B?WC9SaDBvbTJmNGoyMU5mMVRsVHVYR0s2bk9RUlpRY1hmb2RadXpjZ1RMRjZw?=
 =?utf-8?B?ZU9tWmhOVXVqUSt0bFNOY0VPNUNmamVBT0ZQMW84WG8xeTVoSWpCOWV4WWZt?=
 =?utf-8?B?N0UvUEVOcGNIVzg2SW9sTUZuQjF1aW9CU2JuSkRuUHcvTGIvR3FWTXBReE9H?=
 =?utf-8?B?RUZvcTdTRHJvZzNSNHFpTzB4OHR0bUlHSXBRenlRaVR3NmVmQVdTazNBM2JL?=
 =?utf-8?B?WEY5VkliY0pFRVBVeFhIanNrQTR5UVlBYi8ybjI5SlBTUy9kTDd3UnRuTWJx?=
 =?utf-8?B?KytJZ3VjQlFaejVIYWFOMDJyRnB2S0VRSWhoOXBPVW53d1RUOVVxRWRZRkI1?=
 =?utf-8?B?eTBDckg0cm1lcStQOXppSjJ5bGxaYk1nSEwzeGVEOG4rb0JSbkF3TGhBWjVX?=
 =?utf-8?B?MHAwU1V2RG9FdmNMYmdsS1ZlM3hxOWNVNmZoWS9WZzh0MG81ZE4ycDZ4blN1?=
 =?utf-8?B?WUtIbSt0Ri8zK1NnblJiUkoxV1BrbHVjbmY2a2NCL3ZEQWNkZ3p2eERzOENj?=
 =?utf-8?B?dStEc3V2UlF3VFRtTnhSOElUMVlmMG54VEZFUDN6YlpzM2dkaXRFZzhNdzlM?=
 =?utf-8?B?bWN6YlNNSnpRdUJ5QmpyYU13T2NHMlVqN1V2a1BBVVduVXlQM25hNWNLRStN?=
 =?utf-8?B?OE1EcWVMaEdTajRxUENLaWw1a0FkWlRidi8ycGxIbWhjcFMzWi9zRU5UeVpD?=
 =?utf-8?B?RWZQZ2NMeWwvemduYkVCWi9oQ0RRQ3g4STZGV0FzZTBEN2owVHRNckFzTXg5?=
 =?utf-8?B?cHloUWxFS3l4c3ZYZXgwWHZvWk1Bbkkxd2FzKzdVdlp4NHhnSHBleWN0bVN5?=
 =?utf-8?B?MGdSSVpLQU5mY2YzU0xFdll1d2ZTditZUC8rSG9Wdzd0c2RvMUc3OFNtcUtS?=
 =?utf-8?B?QnRDQjVidENCcnpiWXVRRHlKVkowdGhRNDJUN3g5UlJ6VkxZSGZlR0RSMkpR?=
 =?utf-8?B?aEtiTWl1cUV2aWhycXFuNEdZYTdzTTcyYzFzV0huMTBDRXZRellza3orV3Ns?=
 =?utf-8?B?YUVwYUN2K2RDVGR3TFp5Y29LZWZMNWg1VVhRbkJzMUxZVnhZaUF1TjNMaTNy?=
 =?utf-8?B?Ni85K0dCSlN4TnNHNnlWaGR0ZVNpS1RFRFgvb3BmeXRzc3FsT0Y4c2JtdlpZ?=
 =?utf-8?B?YUhHRDhSak1reTBINWM2U1ZwVTRCYnNaRDhCZGoyZDgwM1dUUldBZDFWZ1dm?=
 =?utf-8?B?b25IUUhKV09sYjBrOU9yaUQvS1d0Q3VFU0d1NWo2eGlJTml0ZFZhL0pXc2w1?=
 =?utf-8?B?R09Bd3N4MmRGMUZ5THVzUk15TkFBcnc1SXpkVWkybmlHRkd1eE0ySU5RWDcy?=
 =?utf-8?B?ZFcxV3JFc2hLc3VhYzFmeFVraE5EUWU0eUtRMTdIaFNNSUhzbW50cUp4UU5U?=
 =?utf-8?B?KytST1NFSDhFWE94bkY2MkpvaTh6M0FkcGFseWN1VTBON3IxNHhDRnNlTzFy?=
 =?utf-8?B?UmdOaVZoekwvQ215YVNQUGN5Zi8wdzZVRkxIMGRhSWVScUZMYXpDT2NVMGJj?=
 =?utf-8?B?MGhMQkkzcUtEUklOQmF4MGJSdm9NbW11ZUxDaFI3MXRIV2FsVkV2VE9QM2s3?=
 =?utf-8?B?cW5WcU1VY0dsdDFKa0Z5TW4rd05Fb3hNQnd6VTVOWGx1eXVrampSSjdwN3hm?=
 =?utf-8?B?aEc5S3VRR2phQlBKYUZRT2t3ZTZnTzRKenpnaU12RHlzdmpCWWtVb21mYkVQ?=
 =?utf-8?B?U2hnMG1TNlRuQ1Q5WTVkTmVadnRkdE5qVm1YQzdTbHBiKzBHMFVTVUQ3Q3o4?=
 =?utf-8?Q?kmYneUG1rE3M75m3wIlXqdc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb1758f-3f2b-4905-4e15-08dd36eb669c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:38:02.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTU/3y2rao3UCanEY00RZxvO3wtKrJilHtMPrQhKLmcJeUOMTsvgqDqthRn++xQu/CZrp1MG6oTSXHpoAlAUWWSGmZI7CcthysoEAnDCclc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com

On 1/16/25 17:38, Petr Machata wrote:
> Amit Cohen writes:
> 
> Tx header should be added to all packets transmitted from the CPU to
> Spectrum ASICs. Historically, handling this header was added as a driver
> function, as Tx header is different between Spectrum and Switch-X.
> 
>  From May 2021, there is no support for SwitchX-2 ASIC, and all the relevant
> code was removed.
> 
> For now, there is no justification to handle Tx header as part of
> spectrum.c, we can handle this as part of PCI, in skb_transmit().
> 
> This change will also be useful when XDP support will be added to mlxsw,
> as for XDP_TX and XDP_REDIRECT actions, Tx header should be added before
> transmitting the packet.
> 
> Patch set overview:
> Patches #1-#2 add structure to store Tx header info and initialize it
> Patch #3 moves definitions of Tx header fields to txheader.h
> Patch #4 moves Tx header handling to PCI driver
> Patch #5 removes unnecessary attribute
> 
> Amit Cohen (5):
>    mlxsw: Add mlxsw_txhdr_info structure
>    mlxsw: Initialize txhdr_info according to PTP operations
>    mlxsw: Define Tx header fields in txheader.h
>    mlxsw: Move Tx header handling to PCI driver
>    mlxsw: Do not store Tx header length as driver parameter
> 
>   drivers/net/ethernet/mellanox/mlxsw/core.c    |  21 +-
>   drivers/net/ethernet/mellanox/mlxsw/core.h    |  13 +-
>   drivers/net/ethernet/mellanox/mlxsw/i2c.c     |   2 +-
>   drivers/net/ethernet/mellanox/mlxsw/pci.c     |  44 +++-
>   .../net/ethernet/mellanox/mlxsw/spectrum.c    | 209 ++++--------------
>   .../net/ethernet/mellanox/mlxsw/spectrum.h    |  11 +-
>   .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  44 +---
>   .../ethernet/mellanox/mlxsw/spectrum_ptp.h    |  28 ---
>   .../net/ethernet/mellanox/mlxsw/txheader.h    |  63 ++++++
>   9 files changed, 176 insertions(+), 259 deletions(-)
> 

Thank you for cleaning this, nice series!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

