Return-Path: <netdev+bounces-292773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAilIjR1GGo8kQgAu9opvQ
	(envelope-from <netdev+bounces-292773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:02:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E1D5F55A1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3869B3004F3F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340A93F8ED2;
	Thu, 28 May 2026 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYptIC5i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDD2E738D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987587; cv=fail; b=SWY+q1KIkZTVg+9Abs0lvRn6iCa1cr8damySBc6E3AWOiRwAuGzwybQRcdD15byVSKG4M6i0UuwzZKexjy5K+Xuq8t/usPbI1aFehE1sqYmeUbhMvDMWlGnhLUlMAVRMrnTMVju5l1hoakp51b+Bv1l1oNoUmc+d7qmY3D6Vp2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987587; c=relaxed/simple;
	bh=za/MBhVYaUASMQhbX7cWajANFv1EFnvpgg/XwlR4sZo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VGrIv1Us6ymhgwFaoCK/Io9Ss3TCVGWv9rpvz/diue9cHbX82BPpB8GjJyTe5y6iSujc/DYTyW8eNYkgu2jnZGvswQ/y8wHUyXrFRy7fTBHnlS/k7f3IxysYw+qdh0L4jJgY+5clx/LxtNVu85WDjrtf5+f9QgkP9kUpP06f1oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYptIC5i; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779987586; x=1811523586;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=za/MBhVYaUASMQhbX7cWajANFv1EFnvpgg/XwlR4sZo=;
  b=dYptIC5iDmnSNIelc3h6+tFPWwWPXR25Axb/WDpF2Bb+5vDiepuOr6wu
   jd+UgtrTHxLIsdstneR7QV9Qpbeo4OZodJKKsbpQqWDkjSarddLAqgcbF
   lj7j+nkSTb0d5V9eobgGF6TttZNOWk7HeP0kSU39VdqXkS4/falkPimPl
   6qOj3G8dSHOOeEss4EmBDNW5EjWmjlWe5zw5nnsUqwIzWMrL0xCowtLLt
   CX4KXeeeqj3DX2otIjMeIbwQzbBKIU6gRS3ydvAKbF61s7w9W+AuSwrpD
   NNRxh1cq3Lr9NMFiRyZx5g/dkEZw/k9NWeXcABmdllz1yKY62HQaU2ZSu
   w==;
X-CSE-ConnectionGUID: TBz3Rv08Tq6rl0tHh49JGA==
X-CSE-MsgGUID: neghGgfJS9+f+ti6S8WkJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106287196"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="106287196"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 09:59:45 -0700
X-CSE-ConnectionGUID: UggWHAGAShurEZqV4YJqVQ==
X-CSE-MsgGUID: n9kuIZbmSh2r3NiKLRLkMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="280717049"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 09:59:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 09:59:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 09:59:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 09:59:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyUfdmcKlksi9rvzxxI1X2Anh3Bp68ftEwzl0Z9bfz0lZGt8g75Q+rmuptIPMpWcyOcjH12it3INXLhsN+4xSTDlWtyFxGHFUDiRDNJ8390o3r+FScuTUQ9xtttxlzqvqoXJJgRazE2WaFx/rgoJ3FqqUZvmdcoI5dk2uwp6906cWA3UQT2eCv94+5dVaMcAAPWY3CUG76Ub+2b36tqFRjHIBj9yrpSt7yZtfpDmdUJ/TS/XPouLCystmCEB1VnAKuI7TLDKzswo8oZitGMJiPmdiyxZfLUgWkSmJNzJvkBMvveaDp/mUr4Qe/zGOiHzoP9SiR7XKJRoeel0Xl7koA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afqsWQIIeJStPdaOqHPLF8kJLlPJ+JA72VUZ4nSI2XE=;
 b=JF1T1ok1cpsDlPNXuQ1RsFcnDaA41Je6fQgmb9hZLlEsKhjtgujIYdp/knZcsHvC2zvW+yb5UOQHoJlG+afcuboGzSs6vruOFZMmvGsMwA1iFET3NxbQq6TW0bwVsjV4iaHDEZLRxJWwck2bCZW/7f6oX8IXH++oE5NpZspcDy/3aRXSWeHp0FQUSGxvKGVH6qdB8Zggp7bHZqyvcjSQiRRyW04Wq52gisKDbxYoYh40SrhCC2Q0E0nXpcJHK1ClOE6OY1M6JRUFEArrrLC5yPbspstxsztD2Jpxu4tanG0T094Q7T2BvkgwOcGCidiO+ikCRECVSOKONh2cVmPPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DM4PR11MB5229.namprd11.prod.outlook.com (2603:10b6:5:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 16:59:32 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%3]) with mapi id 15.21.0048.019; Thu, 28 May 2026
 16:59:32 +0000
Message-ID: <acbfcb58-cf74-4a2d-8002-4d8049e2dc53@intel.com>
Date: Thu, 28 May 2026 09:59:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix PTP hang for E825C devices
To: Ivan Vecera <ivecera@redhat.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	"Grzegorz Nitka" <grzegorz.nitka@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-4-aleksandr.loktionov@intel.com>
 <e112de51-687b-48de-a0d9-eebbfd5b32f4@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <e112de51-687b-48de-a0d9-eebbfd5b32f4@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DM4PR11MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: e375a6f2-83d2-4288-e455-08debcda7d2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: OV1YYU0N71TzTulP9sYKh3Vx6nilMLbGoQUIrh4tUYB3+aB1Hn1zR0yLSNe6O6QYjZoZ421FDisoD6ETVyN0dz/mYzccCgJvLVBbBL13ydrSkErD1yUye+VHs9Ti9LaJPW74nu4otaQu/28ETfkiJ6p/sET3R0ad0ntLcdhL9u1AIUOFUOQwwRVvOV3tqAqUFgTxAoQ7X5DvR/p3x8MYApxWBeQadcGm7eVO+FIPUKPIfksDLAvSyajhlfYwFs+tmYojPoUA3/uo9cmGZJQKDVK9vG4ySKIN+/C/zE935haDneeLsxVc+H3hv6QRpGd/dleyvgB4A/rYerg82Q6XJvotUBa5z1Nador5i+1pIVUDgYrkeEd3dEii6akT1pDQwnfSylEVrw/lAQ7rL8npRYW9nDm0Q1rx+yg6wAQbL72X4ghuv8KQsePFf483Y7yMqF9JraHCuzIILK9tibSJj0c7YPmA051hQd1D2UY2xW6zidlYMTV0MdT4d4upb3kZ574DgsRLMOfi5Y8b7QYnaKATTXmbHcl80PKM139uXCj2LzQvPB/tmathuMKPWfHA+uHtoTdpvN/HyVzh3Zx7/+wyFQ4P86gASESXAGuhp0GnM9DKgwUC30D3RaQkWXKYizaksrZPSN+66yx6wDSByOhwv2yYXaVshmt10Pg2OrHqQksDk3wBMoJM6rHt5mkxbQApdQcchfrmNeGp2hTL0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXVxVlY3ck1WZzQ0dE45b3J6dnAvZkV5TncrYTFLOVgxaXhEaDdOb3R4YmZN?=
 =?utf-8?B?Z0IvSmtWSkhjV3phNmpFTGVIbGcxVmo2dTJQc1NIY29QTVQwMG5yMVh5ODQz?=
 =?utf-8?B?bVNvNHZybk15WGpSRHYrUjM5OUwvVk5wZ2xXNW0rRzl3VUFMaHdINitScUEy?=
 =?utf-8?B?Z1l1K2R6Qnd5eWZxVzRDTExNUUN3ekNkNTBkUHFITzhCcUN6UEczdnVnU203?=
 =?utf-8?B?NHN2ODBoeUhqazFicW5OUFhMZUszZmxaYy9zMENpb2FIVkU5UEc2bDdrQWFM?=
 =?utf-8?B?ekExYUFvazR5YnNLci85ZnM2WlkzcDRacDdzWSs2elNIb094ZVFuRXhna2dV?=
 =?utf-8?B?WFVaYjVnUUJFR2lLa0VxSHpCeVpIZUJLTnlvOVlnS0RIZjFIQ3Y1eU5lanQ5?=
 =?utf-8?B?RngwTnNkZFFHKzB2S3EzSVM3WjlDU1duWnJmVEh4Vnord21pa2c1WEdwK3pT?=
 =?utf-8?B?Sm8wMkNMZmxrb3ZXdzZod2xsaGN3MTFsUE93K1FHQXROZ0tFTktyNHkreklu?=
 =?utf-8?B?ZEJCN29mQVUvNE5MRno0eVdHV1VwQTRrS3hvdWVQTXp2SlZnd1Jod0ZXYlBQ?=
 =?utf-8?B?R3JkcE03cXRUZGphWnF1VTRTTW9CaWo2UU0xZitFdG9uUSswY3B4bU1FQVph?=
 =?utf-8?B?aHJFYmc3NWErSlMzV0pnMmpYeHdxeGtPTFZrTXVia3hFVGdDSjAweXNoWGsx?=
 =?utf-8?B?QldaVzBWZTJKRmR6cUlLNHV3WXViTURKUjJrZDRtSGxob2hoSldFYkNsaFQr?=
 =?utf-8?B?NU9mS3RYZzhiK0R0Q2xKaC90azJNVXAyYlJ6OVQwYzUwTlNLSVV3ZVRsZVpU?=
 =?utf-8?B?SFJna08yZGs2NFFGdEl1R3dvMFNzN1EzZFJRdHVpTTFJVDZHOUVscmlONUxn?=
 =?utf-8?B?NXlWVitCMUwzODVLSnlUYTJxZUVuaFdHOG54M2habFdVMEVsYmM1ZitrL1pw?=
 =?utf-8?B?R1hqZFBYczFlZzBGMjVlMHZJL2NuZnREVkdBWlQxQ0hmNDB3S3FNdGxjYUF4?=
 =?utf-8?B?bnFUYXM1b1E5VTVNRWY1ZjhDL1QyczliL2lTbHE2U1lWcG4zcTI4MnFydnE2?=
 =?utf-8?B?RmZjcU1VRFNrZUl1NUhVTk05ekxXTnlMTjhWdGVQSGo2OHlpYUEwM2dDbFJ0?=
 =?utf-8?B?azNORnJaYjBBY3haakovdWg5eThic1gxdlhiNDhlWFB3M3F5bnVEbzVvY1RH?=
 =?utf-8?B?dENETnB3bGxOUm1DUC9DaHIxQ2VsUk96aWdwZWNNOXFGQ1dkMzdLb0JHcysr?=
 =?utf-8?B?TVV3MlhWQzVtdWY3VFVNZlhMQjE5eUsrdVBUMG1ERUNEeDVtd05RcEtsdVJK?=
 =?utf-8?B?SWRPTHZKK1NjMnhqSE5TcmtRKzQwamZLenB5ZTAybExRbXJCemhjZ1F3YXZF?=
 =?utf-8?B?dURjVzAza1V5eGtncVpqcHA4QXN4Q0xST2NGSGhtWjBYUXUyWGlpem1ia1hU?=
 =?utf-8?B?RUVtMzhMQ0ZpUkRsOVVXVWdBMTRmREhmektTbmZON0F0UXNsa3FlTHJZTlFu?=
 =?utf-8?B?QklkL01mN3JBY3hqM1VFbDFGZlIwTjQ5bkdlL0FvOTdlMkZzTnJjY3hRYUZX?=
 =?utf-8?B?Z2g1MlQ3dFF5WUdPT1BPclN3SzBqcUZTVkVmbmIvTUQwZnd1bmF1U1g5MU1x?=
 =?utf-8?B?SUNteXF2OW5HVWh5T3pnV0x6Z29qbGR4S1l6ZUlRWlo2NjVMOE5LcjhseGFa?=
 =?utf-8?B?K29aaThhVDgwRExiWHFkSWxQaDJkTWhFUW9DNm5uSWhGVGY5Y2VsaENabWEy?=
 =?utf-8?B?TjBqOWJEbWNEUVQyRFVDem5zZEIyZnpsZWFVKzc4Zlg2dWxtMFUzZzFjVmlt?=
 =?utf-8?B?aEduZ3JFV2E5M1RuZHh0WU05SkI4RW92QWgwYUNrVVM2a0FQREhUY1c5TEx5?=
 =?utf-8?B?NmhzalF2Umd2TUUwV0EzUWMrb1B4ZG1iWjhMSHBKbmJIWkViMXM4RC9ZbEhw?=
 =?utf-8?B?MG5yWkpwUUJDRGk0RWpJeU5MbFZSMHYxOGY3OVIrMVFyVllwZysyYzVhbFVY?=
 =?utf-8?B?UUh0SXVHdXNsSjdZS0FJMU45Y2hzZXRHeG9RZFdFbmlpNTIrUS9DUnNWK1NV?=
 =?utf-8?B?ZEFDdjNOSjk4TzR6Z09VdUpMTlVwSkdYSkZtU3RJWEoyNkNPSnFwSVhnN3I5?=
 =?utf-8?B?Z0N4RDJwM1JFNGZLU1RXcUJsczJrWndzaGNLaWZoQ2VjdzA5aHFTTFpTaWZP?=
 =?utf-8?B?RjJMVGtham9oSlNzMmtMbUdQeWdOeE8xTHFxZG1QZ1gxNWI2OXJ2a0Yvb2NT?=
 =?utf-8?B?b1pVZlFibFpFazQ5ZU44bGpqL0hYbGRaMlMyeW5ZdytDTlpybEN5ZFlSWU1j?=
 =?utf-8?B?OTMzYUE3Y3I2TTN2UHNhME8rR3AxeFhLWlVYUmJtWU5aWG1aZHowYmk5MXlp?=
 =?utf-8?Q?YvxKrSjpghwvJ7Zc=3D?=
X-Exchange-RoutingPolicyChecked: VGGjm9Q6YTjcIZ+0hFbVIyvfx8BSi8mDprY3XMzEUu7HQhR+QBjlYQgrvIXSWqq0nfjgVM5upELGohsywCFMLgU1C7GWIRgWSEuIM4HpX206U4rL68DtPJjMVwrnH5UjUcdfERVdCvmdw1qxjLiCptNlzJSA6hPmJkgL7dtElOYfoTIQNvkB5kWULhDbep9OeiLm8SWVKNUfcLLFvK8AGLrWsMgmOL/Hu2IFxxmuVBrEXnjzhkil4Dgjyybd39CUNv6NCqJ5/rQOHcKrp8xbd23x+pzf0fHKu4wpxoQGfjZQ3G3pd0EWkp1NYgv18oVpdpillOH9ldGF/V/RPGCsoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e375a6f2-83d2-4288-e455-08debcda7d2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 16:59:32.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXNz5zdPxcKmxR98Y2gpxTQO0nJ2LS0VosTV2vjTaQeSMVfvmlPLOVeNHMXnbxM/JI6JscSBOXBmK79TxLCUaxExOc+f+cXj6spFtfslpI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5229
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F3E1D5F55A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/28/2026 7:31 AM, Ivan Vecera wrote:
> On 3/27/26 8:23 AM, Aleksandr Loktionov wrote:
>> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>>
>> Change the order of PTP reconfiguration when port goes down or up
>> (ice_down and ice_up calls) to be more graceful and consistent from
>> timestamp interrupts processing perspective.
>>
>> For both calls (ice_up and ice_down), accompanying ice_ptp_link_change
>> is called which starts/stops PTP timer. This patch changes the order:
>> - while link goes down: disable net device Tx first (netif_carrier_off,
>>    netif_tx_disable), then call ice_ptp_link_change
>> - while link goes up: ice_ptp_link_change called first, then re-enable
>>    net device Tx (netif_tx_start_all_queues)
>>
>> Otherwise, there is a narrow window in which PTP timestamp request has
>> been triggered and timestamp processing occurs when PTP timer is not
>> enabled yet (up case) or already disabled (down case). This may lead to
>> undefined behavior and receiving invalid timestamps. This case was
>> observed on E825C devices only.
>>
>> Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it 
>> void")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> ---
>>
>>   drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ 
>> ethernet/intel/ice/ice_main.c
>> index e7308e3..8896805 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -6797,10 +6797,10 @@ static int ice_up_complete(struct ice_vsi *vsi)
>>           (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
>>           ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
>>                     vsi->type == ICE_VSI_SF)))) {
>> +        ice_ptp_link_change(pf, true);
>>           ice_print_link_msg(vsi, true);
>>           netif_tx_start_all_queues(vsi->netdev);
>>           netif_carrier_on(vsi->netdev);
>> -        ice_ptp_link_change(pf, true);
>>       }
>>       /* Perform an initial read of the statistics registers now to
>> @@ -7328,9 +7328,9 @@ int ice_down(struct ice_vsi *vsi)
>>       if (vsi->netdev) {
>>           vlan_err = ice_vsi_del_vlan_zero(vsi);
>> -        ice_ptp_link_change(vsi->back, false);
>>           netif_carrier_off(vsi->netdev);
>>           netif_tx_disable(vsi->netdev);
>> +        ice_ptp_link_change(vsi->back, false);
>>       }
>>       ice_vsi_dis_irq(vsi);
> 
> I cannot find this patch applied anywhere... IWL patchwork indicates 
> Changes Requested... I don't know why...

Hi Ivan,

The send to netdev had a couple things flagged by Sashiko:

https://lore.kernel.org/netdev/0558de37-fb75-428f-98d9-13b9594c4efe@intel.com/#t

We are looking to make the change that Jake mentioned "separating the 
PTP link state from the admin up/down state entirely."

Thanks,
Tony

