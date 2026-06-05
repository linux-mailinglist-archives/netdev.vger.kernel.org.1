Return-Path: <netdev+bounces-295925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cJBxBIgPI2q5hQEAu9opvQ
	(envelope-from <netdev+bounces-295925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:03:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9764A6BD
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:03:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WSpNQm1O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295925-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295925-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9356300914E
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7EC37DEAB;
	Fri,  5 Jun 2026 18:01:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182A383339
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:01:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682500; cv=fail; b=HEp9qHV3tSmZXjsiMxQS2fuqwn0i6KKC+oppFkD4xX++eNGqJFqCcVRx9jUzCAGgG4iDLpB4ypAU6Cy+cU9FCtYa7qqlYFQdqkDmB+6ejVuuR+Y2+ShkQpmKXH5vImdD759XWeJSxhTy/kNROdtY432rfGCjDbOQ6aNnbfsLGzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682500; c=relaxed/simple;
	bh=5wg9EmfUmkOeI4vCzMZJdd6LCriTT0ZqyER61HSru/Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ss5G/ZiXzuA47zh52vSMH2WFiOsNNXXKUZJfTtLAg5x2c9Doh3S9/6QbfHxEO14ciwojBPG1GTVawel8vTJF3WlLCd3EnnD9+xiqMu8kp+9QDcye9vnCqh/G9S4t0wwUYZsxjOU8f8msVHiQDxq9tCT6N1VjiuBQnr8ZS3MJHPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSpNQm1O; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780682498; x=1812218498;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5wg9EmfUmkOeI4vCzMZJdd6LCriTT0ZqyER61HSru/Y=;
  b=WSpNQm1Omg2WOpBCkjtKdQyGrkIDVUY/eT/StnspwDEHLUSxGp4nn2BM
   GDTs7eGA9fACWaxg1POLDoRMMUtfPZSxKIDeHjsoWacU+qj+g1ilw0yji
   QgHKTJ7jJvVFx4MVpYttp+VlSrRM0biWgyGHNORRLgd/Z69m+Afhd/wku
   hzbBa9HRAHJnqjrub8mm7ZlZ/yJvMYPNP+ijgiMzGkETxX6c2pLSlHD1M
   45ARRlJviVl9NwWPo91CYISuotmbFDCkZdnRwyvF7GRIrIduzyOm5PgQ1
   tu1Io85+CAYV9gGw1A3C597ny2wizwrkw31FOmYV+5ivDWZ+hO7giu7mn
   Q==;
X-CSE-ConnectionGUID: EqABQ00PTAGpS85e9nbnDA==
X-CSE-MsgGUID: 5Fu6kvRuSuGAhhQ1jjNMgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="80657956"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="80657956"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:01:38 -0700
X-CSE-ConnectionGUID: xX0uEl1eQ+SaVi7wI15P1w==
X-CSE-MsgGUID: yO9KSKHVR3+yZ8FBR1Nr3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="238558567"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:01:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 11:01:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 11:01:36 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 11:01:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEFTWdYGUguG76jDJ6CY14m4/Bv/XfopHW+ITvKoJKAftu2xouge5JI1fttVm+y0UNZps3sj7kHH2kX8qsfx7y4jJMg6mbjrR+aeKrXB/NoOzd3zZq2ka/bOtXy0lkxAT07t9GcVaIrVyy5GDcy+CIuyG8r3wMn7Z1ZBEP7IOHjbhmVpfbn0tH24CQYkKn8+MP5hvi34AbLHBAljcl4nNFZmp82BVvj0LDxWNvjPqnNcaJyYWg4H/j2y6JDoToLCWBzIa1MO7MsmEwWoJzYwkZrwXZQQJt4HimztOCHbpGHK06Znra2AfDPog6JkuKJWvnOJPb6FGC1R30PO4CS7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEYzXeWDPMgxXUutnPLKN6boQccE24z0d+XBlVjQYYY=;
 b=CxNd0GhYjJjT6aS5oT69+WfjSx7fmUtApUAj1DWuXKF4Gs9RPLJ+lDV1XcUvGFmHaSEprSnj6EBnLxCKfD9q9flBmWq+a+6WbPwQ3agtTnm6Zt2Mdoy7kfe4xlmoH+RH3zAEFM2phxbiytUZqQbHlUiAE9kObrLBbnRGdzEbtgztuibSCXdz3hJNY8jb+2e4+JdITx6YTKwWcVfmgWiVcoaDpZKK7b1zOI1R72mAvhdGEGGJbk/6z8EofMEuOO3awWMmTsNb6Ngh7TMJEgtylqr0OqFUXmz3ygbD/h4f3XVjhAxvw0uPxn/pC4CVZOLzbFbYUVujKkDQ8WV0VP8fCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:01:23 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 18:01:23 +0000
Message-ID: <25ca3a21-7d29-47e8-a0fb-5fbb7ddfea99@intel.com>
Date: Fri, 5 Jun 2026 11:01:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] i40e: keep q_vectors array in sync with channel
 count changes
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <poros@redhat.com>,
	<arkadiusz.kubalewski@intel.com>, <przemyslaw.kitszel@intel.com>,
	<horms@kernel.org>, <aleksandr.loktionov@intel.com>, <pmenzel@molgen.mpg.de>,
	<sx.rinitha@intel.com>
References: <20260602225513.393338-2-anthony.l.nguyen@intel.com>
 <20260604012707.2843206-1-kuba@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260604012707.2843206-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:303:6a::33) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1f3351-826e-492a-bbd3-08dec32c73e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|11063799006|5023799004|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: VCZ01hNePCr3E7oj4BYae1tSGBu53LE3UaUMzKTAxiJThkLRxaF8sDJ9cqQT48RaEbUgMI55z+rWpfvDLVsLKlZKAPX2vjIHIrMxRnF0sv5Alz7ARPJH69t9JlwCInLc+m2kKBDKwxIuA4I2lXU/bTFeHwIqijeyMdlRAnOLyt7xNYCFluDMQTR36ykako8pcpUz12N0YlvC0z1PWhX6vgRUbjYgEgJdZ9fv7EqmovnD8GIUYmtBXorkQ2i2f2yrgSpks62ZVkSjj6r7NDSZI+MYeXmzVyLkyHi38zZe45GuryGUU71n8b5uy2ZVXTD4H6o6KJycNHjleYjRIECxN0ryuBV/CCGsUhETVSyDqSxKiS//F1f/wP3JOWAR3Zxba+tLnryUgfdtZi5HndRplVyiC6/NYCWuQHtmvud40p3FWIv8ytG9TJxwmpt+018oOEb0a1Nn1iIwDhPhCq94u2vHKNiS/slZ0fPOVbDghaYY0YgFgsOEoLFsW8+ZtWUAuhB1kE0FyRnBjYXRPXdMxI/qrKYHwhhzWeFMujotUfTMaGF+Li7K0H8aFeHgayTt133jwPwATP4dmHyUlrrgBjjDefD87KexvCBqFXWsqrM3m5G95ofRGxZTISQ2T+yYqJuy0YDKpEMoUDmrTSnugkfkuke2IFySnwpQNQw9FXwgtKBBEE2bwJ4H43PsiA4Qu5ODcHtxmYCTcCXuXVcuOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05qNEgxdjNQZGpnSE1VUm9ibUNmMG9XUW1MRzZ4SG4xcWhGb3ptTlpwcG5H?=
 =?utf-8?B?b0QwRkpKcFNyM2lheUFlMkVmM0pLd3o5dHp0VkNZcXJDWHY2SlJpbmxTeHJU?=
 =?utf-8?B?L3dXZXBPdGYvbk83NXVzZmdXaWJqZCs5WFdRMTN1VFdNenViRWRGN1dyMVU2?=
 =?utf-8?B?UDRyNFVkOUZHSHVpbDQrZXdrbTdXUDFCMnZNbFhYR0R4YjB2SnhaNy9uNVdl?=
 =?utf-8?B?SDNvTzRMa3ZGeitjd1VLKzNZTUU2R3BkZkM3Ym9xNFkvdmVoM2Rjd2lIKzdH?=
 =?utf-8?B?VzRLU3RybWYvbmdJdG1XWXVCNlZ0NXZLVjB6d2x4OVVsajdab1pzYzQwaGFY?=
 =?utf-8?B?ZFExR1R5SmVqbmY3enBsOWlRcEhpTVRCcXVkTklGL2t6K01WT2xJMVUrbHlo?=
 =?utf-8?B?ZzI3bGpmaUw2NEdTTnpJNTNBUmxOcHJ4QTQ5eGNuUjFqODgvSmFsN3BZU0FI?=
 =?utf-8?B?QndQUC9hSmFSOVkzZ3hMM0NqYjU2YWJiYS9SSlFSVkJkTy9vSCtvb2pYR0to?=
 =?utf-8?B?RmREZ25uelUzazhXMzJjc3dXVUZRZ1luSngwYjF4Y2ppU25RaTFtVXBneE1J?=
 =?utf-8?B?cFhvNGNIbi9LNVR5YWM2UWhuWXpVRlcvSjB0dEJncWxpOE1GMXVyZ1VpUDRL?=
 =?utf-8?B?SGlocGhPenlscHJ4SjhDdnU4WllGcGc1b1FJUUxicVRqNHZoSXUvUkg0cjlw?=
 =?utf-8?B?Z3FVUkxzUm5RZTNneHpKYTFYOFhYYWNzQ3ljRHRKaFA4RE9FZ1Q0VnJxLy8r?=
 =?utf-8?B?SEJoRVA0UktvNWtxSis3ZXZQejcyMnUvRDc2UC9oRERQOUljZktuZUJEOGhS?=
 =?utf-8?B?QkVXRnRwQUY5NkxxVXBDZVVLa3ZRWVFXdkhhdGpYS3hwT3FJaksxS1JnUGx0?=
 =?utf-8?B?Y3FoMnhmM2dYTEJoT0Rvekh1NVBxMHFFY1BaTlBoUVF3ZVNpRjBkLzBtRHR5?=
 =?utf-8?B?YkhvbXoyOVZ2OEJ0T0pKR2p2dGdYek5BQzFrbTFwRUp3VWhNL3FrUnVNaHY2?=
 =?utf-8?B?MDZ1SUZBSEtwcGhHMUJIVlZib0dzd0M0YVV0Yi9JWE1JRGpJRkQxOVF6cVNE?=
 =?utf-8?B?NGczeXVrMEFiRlRubm1yUFZ5Y3ovR29VS3BpVkhmQk5oM0tjNGZWT1Z1ejZN?=
 =?utf-8?B?OHVZNkZWN214Z1d6bFI0SnZrN2lzalQrRFg5TkY3MGtLQ2hiQm5tQ2lVK2JF?=
 =?utf-8?B?VHg3QklNTk9JemFlWGF1ajNxNjhuZjlvODd0K3A2UWRWOTVXSFFtSEFPb3JU?=
 =?utf-8?B?RzloQ2hGL2dVZmhOcVJRL1ExczFHQTVtWVo0SGViL050aUNqQzBJS3FIQk00?=
 =?utf-8?B?Qy9SaEFxNHczbG9XbHVYN3NJVTI5ZVpLMWtHN3hOZXEvZXl2bEd3akFnWmNj?=
 =?utf-8?B?U3l3QU1ieGRQbU5SUGtLMHh4ekh5L3RuMlpFbWxlNGpITUNRL0VweEFuUlBR?=
 =?utf-8?B?UnhnYTZoQzJyc3hrQ2hETUZYUytBejFtNDNXalV5Rkd5Uzk2bWdlMHd0Z3pF?=
 =?utf-8?B?bTI5YlVPM2Vrd0lydlhuZHhPZWRkQzZhbHVZdTJieEQ3ckpZK1o4YWRkQXl2?=
 =?utf-8?B?SGREbWRGK2g5b1ExQ1dGREVHYWFldGYzNnYxanRMQUZETm1VYWhUcEdzbkVs?=
 =?utf-8?B?V3UwTmhWUXlBcVc1OWFTTHJwQjh5ZkRDZk1qQmtlck1UVjZJTkRGUnh6WGFL?=
 =?utf-8?B?WUNMWXZLQmlxWFMyN3JXUXJSeWZiYUdyeHhBdXJFTjZZOVpwYUQ5QVZJZ012?=
 =?utf-8?B?UzNEbFRtdm4wQS85MnhrWG1jZmZMaVJYUHF1SHFzVXE0dDA1SVFuVHVrYm00?=
 =?utf-8?B?TExWQ0RKSExHaTYvaDl4TEExRHlCOHkrZk9PZktua0FKeGV2VEQyMEJEVmtw?=
 =?utf-8?B?RXNINUwvWHp5bkhMSEdPTGMzYmVlWWFpeWhVK2htZGg1WGF5SzU3MDhmQXll?=
 =?utf-8?B?amRSOW5rNUpVYWM0THVEeUlqdVNEa3piYXVncHF1QmdTbVROUFhvS0p2Y3dV?=
 =?utf-8?B?Vm9uTklybHdpZlFMWDJZTzliUmlZU3E1MkhCVTEvMWduVkJ5RmxDUUtOVGN1?=
 =?utf-8?B?M1NQRFNxa0svSWQrSnpSNkZ5SmtGRzE4aHBhMTkzOElTYk9yTFlTQ1d2WVpw?=
 =?utf-8?B?b0FqVWc4UnNIT2hVb1lRRU8xL2VYMWQ2NnVKbjJ1RGlmMU4yeG0vS2hMYWo4?=
 =?utf-8?B?L3hHV1VGWUp0WkZZeDNMV2Y2elcxYW9iaFBXdjJZWXdYQTJOUWtaN0VZNXMz?=
 =?utf-8?B?cGNpeC9NRytBM2JIMlMrckV6cHpoWXlsQTBXRWxZb1E1U2l6ZzV4V2lGSGZZ?=
 =?utf-8?B?czdZVmp6ZUtNbkQyRVA3SkhSa28xU09UZUVTeldiZkJrQmx2OGVQTk1hZTNG?=
 =?utf-8?Q?u27wk6xoBaj7UM3o=3D?=
X-Exchange-RoutingPolicyChecked: EuHZOxX0KK9gnGUEzjY1GMWsW9vTkx4f1JqSP0WH/DOtd9VIvKBOseVL6dl+Q55t3cfuvBFkDhuSzNfFRRcIS4upQ5GCdiaZ04jqdAXg2q5gkk2NKZAHhyKV1Rhky7UEwODqVPI1NMkJHl34XWoZ3FOSddGTwRw6JZjjw+YD4+wIJ24a30TCURH3nP6N/iBzgQltKtJCSqmy+sQZAQzX4dQYjQbAw8SBoQnk2JFe0aoyu/N/bjygcg/o0afRGmv4mpvXNSxyXSBdS3tQMWOPHQpzxADab32/yi54V/XeNj9RZhBlWe7j2p3gnkl4pjapzS4nLgY7772m1VUz0l4ItQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1f3351-826e-492a-bbd3-08dec32c73e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:01:22.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aeJQHQIexojR3FMCml6GwtKbz4YjtlEoQXPrda6iWN4Q4ZIv9SrEU/leDdCRIH6WMLrSWaH3swXOpCohXKM+Dlhe0TM1yd4whEG2Iugd4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295925-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:poros@redhat.com,m:arkadiusz.kubalewski@intel.com,m:przemyslaw.kitszel@intel.com,m:horms@kernel.org,m:aleksandr.loktionov@intel.com,m:pmenzel@molgen.mpg.de,m:sx.rinitha@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:mid,intel.com:from_mime,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FE9764A6BD



On 6/3/2026 6:27 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> i40e: keep q_vectors array in sync with channel count changes
> 
> This patch makes the main VSI's num_q_vectors track the effective
> requested channel count and rebuilds q_vectors during VSI reinit so the
> vector topology is refreshed together with the ring arrays. It also
> switches to netif_napi_add_config() so NAPI identity survives q_vector
> reallocation across channel-count changes.
> 
> Link: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
> 
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index 6d4f9218dc68..c3fbe14ff2d3 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> 
> [ ... ]
> 
>> @@ -14264,12 +14264,26 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>>   
>>   	pf = vsi->back;
>>   
>> +	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
>> +		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
>> +		vsi->base_vector = 0;
>> +	}
>> +
>>   	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
>> +	i40e_vsi_free_q_vectors(vsi);
>>   	i40e_vsi_clear_rings(vsi);
>> +	i40e_vsi_free_arrays(vsi);
>>   
>> -	i40e_vsi_free_arrays(vsi, false);
>>   	i40e_set_num_rings_in_vsi(vsi);
>> -	ret = i40e_vsi_alloc_arrays(vsi, false);
>> +	ret = i40e_vsi_alloc_arrays(vsi);
>> +	if (ret)
>> +		goto err_vsi;
>> +
>> +	/* Rebuild q_vectors during VSI reinit because the effective channel
>> +	 * count may change num_q_vectors. Keep vector topology aligned with the
>> +	 * queue configuration after ethtool's .set_channels() callback.
>> +	 */
>> +	ret = i40e_vsi_setup_vectors(vsi);
>>   	if (ret)
>>   		goto err_vsi;
> 
> [High]
> Can the err_vsi path here cause a use-after-free of vsi via netdev_priv?
> 
> Reinit is invoked from i40e_rebuild() -> i40e_setup_pf_switch(pf, true,
> ...) on an already-registered netdev (vsi->netdev_registered == true),
> and struct i40e_netdev_priv keeps a pointer at the vsi. The err_vsi
> label only calls i40e_vsi_clear() which kfrees the vsi without
> unregistering vsi->netdev, destroying the devlink port, or deleting
> the FW VSI element:
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_vsi_clear() {
>      ...
>      i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
>      i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
> 
>      bitmap_free(vsi->af_xdp_zc_qps);
>      i40e_vsi_free_arrays(vsi);
>      i40e_clear_rss_config_user(vsi);
>      ...
>      kfree(vsi);
>      ...
> }
> 
> If i40e_vsi_alloc_arrays() or the newly added i40e_vsi_setup_vectors()
> fails (e.g. kzalloc of q_vectors, kzalloc of an individual q_vector,
> or i40e_get_lump(irq_pile)), would a subsequent ndo_* callback on the
> still-registered netdev dereference the freed vsi through
> netdev_priv()?
> 
> Two new failure points the patch routes into err_vsi were not reachable
> before: the unconditional q_vectors kzalloc in i40e_vsi_alloc_arrays()
> and the entire i40e_vsi_setup_vectors() call.
> 
>> @@ -14281,7 +14295,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>>   		dev_info(&pf->pdev->dev,
>>   			 "failed to get tracking for %d queues for VSI %d err %d\n",
>>   			 alloc_queue_pairs, vsi->seid, ret);
>> -		goto err_vsi;
>> +		goto err_lump;
>>   	}
>>   	vsi->base_queue = ret;
>>   
>> @@ -14305,7 +14319,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>>   	return vsi;
>>   
>>   err_rings:
>> -	i40e_vsi_free_q_vectors(vsi);
>>   	if (vsi->netdev_registered) {
>>   		vsi->netdev_registered = false;
>>   		unregister_netdev(vsi->netdev);
>> @@ -14315,6 +14328,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>>   	if (vsi->type == I40E_VSI_MAIN)
>>   		i40e_devlink_destroy_port(pf);
>>   	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
>> +err_lump:
>> +	i40e_vsi_free_q_vectors(vsi);
>>   err_vsi:
>>   	i40e_vsi_clear(vsi);
>>   	return NULL;
> 
> Should the new err_lump label, and the existing err_vsi exits from the
> two allocation steps above, instead unwind through the err_rings block
> (unregister_netdev / free_netdev / i40e_devlink_destroy_port /
> i40e_aq_delete_element) the way i40e_vsi_setup()'s err_msix path does?
> 
> The pre-patch code had the same defective err_vsi target for the
> qp_pile and arrays paths, but the patch adds two new failure points
> (the unconditional q_vectors kzalloc and the new
> i40e_vsi_setup_vectors() call) that route into it during reset
> rebuild, where vsi->netdev is already registered.

Hi Jakub,

This does seem valid, but as mentioned by Sashiko the pre-patch code has 
the same target/issue. There's a recent submission [1], with changes 
requested, that should cover this. Did you want to take this now or wait 
and have it sent with this other one?

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com/


