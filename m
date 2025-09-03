Return-Path: <netdev+bounces-219608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A9B42484
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2671E68100E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0618031576D;
	Wed,  3 Sep 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOOjjuir"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED931A071
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912199; cv=fail; b=sgKxEpUy6+auITeIXX33JBaeZt0kRNoA7HARurgFezIUzdmqpA3ygZRbZuxdWC3GUU/9pcQeOIvGKG0vHMn2zOwjCuU4nbCSISoFBaEfANEqGAlPPA1JrB5TwXnscoBmr4YcfpDLQo8m69HgEUWo3kvnDgi5h+As4MwDZG4oft0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912199; c=relaxed/simple;
	bh=96IhnSyhmZe1Htjh8WE30qj98uT+vhpFnDdU/og9J/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bMX6WREHC8LcghAUFHsg2DagkMQr/1JuoKYy38/uId5OIsc43XVmQ3LNNurIlRFAVZdG/ySqUwPkarJIdtPYoU0rB7v/efSwO9O6FYLQaH3NXQ0eCAKvh9iIjOnE/8xl7enx7oJmxT98reP38isV1GxBDnV62M/qZG3DzG0lrvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOOjjuir; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756912198; x=1788448198;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=96IhnSyhmZe1Htjh8WE30qj98uT+vhpFnDdU/og9J/A=;
  b=lOOjjuirtP+fmczo4NnGemT1cv407yrMKfDcD4EicVsrzv35rn5OaJDu
   E+4sjM9g0rpSw//jGK8d2ds4i026w5iig91GdHyUUGpMKqlmUkZH9EYSP
   /r1lZ+eOYbZfRcusAJvL5JhTEi64yUac2mJRXtSUtjjjLGMRbdHDStXM4
   zVtq4bEg22CYKMaCZPa4Bdu8nnVpRdO54bjEVilnIkwfSwRpzjQZDcCk5
   3wAS0GMhL/VrmsOYfHHT9ZokqZ6vL9AFNLw1FdHSvMTnPlTAW6YdPMYJQ
   u/sD0AaFrngRErkcTCgN/03BeKbsxu1epVa+maSg6dq+X/WT/vDUW0/B+
   g==;
X-CSE-ConnectionGUID: f/BGvMsqQ6Kjvc4OYYokyw==
X-CSE-MsgGUID: 23+RvjSwQFutg1BmLTLOTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="76832382"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="76832382"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 08:09:57 -0700
X-CSE-ConnectionGUID: B8nu63+lSgO0F0m/as1Kbw==
X-CSE-MsgGUID: fVqAr6Z8QXK9NBVBbCOO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171180112"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 08:09:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 08:09:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 08:09:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.74)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 08:09:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUm9wZH60MRyPvwMbaXBZxdipZ8a5WaKuYRttdWToO6olhUKCJkLbfV1k4zng/LvOra85O0C3sgcTg+qB0OKq7Wp8vGE+306TNylxssMVDB/AP0+auJVwAlfDLxj876QM5/yNOBNdDgbn9m/oTzW5KJEY1k0TArkI8I0fregChYRicS6G23ZsYUP6HATrSFOHu30O/eKnxauzpxn1/PD6W3gWd/qUjUquDfgDzAoP0I/2O4b5vtS5W8ENi9RWZ9HSeeL9fEhcagrbLBjj/P0l/GwSScfl0jxQk63uJwO2QS7fP5K+ZOcyyB4geRdyDfv2L/XgpNaEtFR6wLgJoZHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96IhnSyhmZe1Htjh8WE30qj98uT+vhpFnDdU/og9J/A=;
 b=kLfULdKsVhl4yJwU6eKj/7xCH2cz8UZPq2jo2FnuUvEuZtHNBnHTG46gCViJzGrGZDBRAvU/9aRQ8ChkHZl2GDk/KEaPKxgTsdEctCJFHT1yzyV9uVIZRO0H9s18N0TV30/Z5M1J9Dlg3+vMdcNSe6OLUabKOmDxZvYGc+LYqGprh1hAEuZUsOS0Mp3xCmfKhaBhwZkcAI8WoBziBiqDwrpNdwZdefDypgPScKbt3t4bsWRfsWyClup59cBmpy9LR4hGORoIrWQJKjVeCPrSWxWhyZryUzS3O9RS+ZzFP1Bkfww37I+okg9Yr6gPM+xHk1eO6u9J9BnC1H5xwTJcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:09:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 15:09:46 +0000
Message-ID: <644cab8d-948d-4a32-a5b9-d47b3441eb97@intel.com>
Date: Wed, 3 Sep 2025 17:09:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 1/3] ice: remove legacy Rx and construct SKB
To: Michal Kubiak <michal.kubiak@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <maciej.fijalkowski@intel.com>,
	<jacob.e.keller@intel.com>, <larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<pmenzel@molgen.mpg.de>, <anthony.l.nguyen@intel.com>
References: <20250808155659.1053560-1-michal.kubiak@intel.com>
 <20250808155659.1053560-2-michal.kubiak@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250808155659.1053560-2-michal.kubiak@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b695369-4535-4c7f-8206-08ddeafbeb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azBVVFYwaVp5cWlkbnJkRDc0dGFvb0xycGVVUGFqSnQxNDVpc2NIdk0yamdQ?=
 =?utf-8?B?Q2ZwL2phbGxBYWJDd2ZVVy9rMlZCdzVXd0dYWXVRc0hKU1FWS2xFczlnZDAv?=
 =?utf-8?B?ZkJ6K3FDei9wTDZVazk3NlFscjdrTFJsdVdyUkFuMHRJK0ZiZVU1TmNzLzZl?=
 =?utf-8?B?VnlpSGNuSTlKdEZBbnJRRjNtMXhVcngyMzdRcWtQQ21JREJ6MEFOT3lLWlI5?=
 =?utf-8?B?YTBTdVZoNUNDSHg5ZFNKZlJOZ1lFMUI4ZUFFeSs2dzJKN0hTckVwR1hzT3JY?=
 =?utf-8?B?cWRkaXFqejc4V3IrYXVyajFQbmtkNUhHVmpHSmZpZERDRVp0bU0yS2RzWWly?=
 =?utf-8?B?RHZ3UmdPandQZUlIUlNPeUZvdXFlQXRuYUI1cDBuZ0R5QmZMY3h3Q3JmWGVG?=
 =?utf-8?B?aEJSeVlsQmQ3SmxJMjF5WW05Ni9odjE5MERYZnFWWmNHNUptUGFaSHF1K0E0?=
 =?utf-8?B?RXEvL2JJMkVWdGtkTWdDYkhwSU9YQllMZ0IzVk04cEhrVTY2VFpoemlTVENw?=
 =?utf-8?B?cHhyV0MrQjZYOE9VWFZGRng4UE5IRzRIRENvUGphYXpJeFJ6QU1nSGlmL0pV?=
 =?utf-8?B?WWJLa3JjWW5IMU9lSE84cFg4OVk2YzZSWHhNTWtVVitPbm93VTMvNzlQdWNX?=
 =?utf-8?B?L0IySENaTG5VRDgrZUZBRmN5c09DU203TktZYVZXd09JWW5qZVQvdUZuNVNl?=
 =?utf-8?B?K1M4L3lvUG8wbU1QYldCOFQ4bFQ3Nmk3eDMrWGdCT1JPaWFkSGF0a1grcUoy?=
 =?utf-8?B?SmgvQ2E2Qi9ZMCtUQ0RIVWpzQ0JDNGhUTWxsNllJL2twV0IwNXo4anprd1d6?=
 =?utf-8?B?dk1PVVVBQVBuN2I4VWR4clptalNJT00zaUEwVWtlN2VYb2kvTVVVb0lwejBv?=
 =?utf-8?B?RXM2SDA0TkpCeTFhVVpRc0gyUHlDNkF6SElwVFpzR3JkbjUxQmFjdUNSaDUr?=
 =?utf-8?B?L1N4bUlRU0szREZ6bURxdHFqaTdKUWU1MEFUM0lDSERjN2tXOXNtOUFrVjVH?=
 =?utf-8?B?bGt6Q01jRTVROTdaM1g5N1h5a01YTU4xd3M4ei8zVUVWSEkxUDMvSGtpOUFN?=
 =?utf-8?B?SGw2SkprTU1ETjlsTm9SUnN1RXYraHozcjMyQVdXK3duSGpFQ0k5bDhrZG5J?=
 =?utf-8?B?WEN4UmoreU04OVdaZmFGRGpZY1VWT2VQeFFUNm9iaUgyc0gvZGNkSEdZWkdq?=
 =?utf-8?B?K1NoVHBITjEvSXlWTXdkMmdHK2o2ZzZLdzlYdEl4UDdHMjZZU3BLdjR4Vk1O?=
 =?utf-8?B?cnE1c08zTFJWR0pFYkw4Vm55bTg0Z1JCMDlDREcxWGdxakZaOHZoUmhpZUpS?=
 =?utf-8?B?QlZmaU5FWC9ZZVgwM2wzbUxlVnRqWUZ0aG4wZUt6RHJOQ0lEWDNVRlV3UHox?=
 =?utf-8?B?MlVqdHhodmJsei9lY3dndUtUOUNLVE1LWlljYjRIR3JMeEMyMzRGclpPa2Ix?=
 =?utf-8?B?cnJ2dk56amw5N010V2crNmVRSmdTR0lXZU4xR0F6c1JVTzRDeG8vOWF3RXZO?=
 =?utf-8?B?d1dneVkrUU9TRDg1NzhUbzRWaFd3WGNIYTJ4a2hJQ21ZQ3NMckZYYXEvWkR0?=
 =?utf-8?B?NnMzNHNYckZldUVRSDVkVlFTK0gvY1dJUDVHZTFGQmpPTUxtQ0RNZE41TzNY?=
 =?utf-8?B?NTg0VVVBcTl0Y0lXbk9KS1gySDNhNlJFN3RIcjVUSDRFVTRFOTllM2JuUVhL?=
 =?utf-8?B?d2hMNWZQK0UyZDlZOEt2T1ordS9WaVhpVFFaeTVhWEJWZVdENW5tSUMzL0pO?=
 =?utf-8?B?V2lYVm14TkNmUFVrY0hISWpESDNtbFltdDFLYU1raTRqWmFPd0JLN0dhMDZ4?=
 =?utf-8?B?bE1tdjJwVzhXRkh0dEh3S1J1ZEVpUEhyNENKcTRyZVlsQi93Unp0bURpR25i?=
 =?utf-8?B?WUpCSGVqR25uUGtHQ2NHdkxLTkt0WkQxUm45dVBQbytZcGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVAzT3FCaVZYeHlGSThUTTRwb3BVdTlNYlI4Q2llbjRPMjVWaTJCaWgxY1Va?=
 =?utf-8?B?c0JCN1pTckN0cEJGTEdsZjJ1aEdvK2lxTmpQL0F0RmlYNTJsUVJFZXRmTkNH?=
 =?utf-8?B?aXFXOFRWSHlEdGY2eUN6Z3Z2Qy9qV1BFbjNBUkxpWmpyKzlpQndsWGVpVE9l?=
 =?utf-8?B?QjJZa1JtZlEyTzhLNnBHRktFZkoyQXplRWhqUHV3ME1aR20vdXI1NzZOOWJt?=
 =?utf-8?B?WnQ4aXVPVXJRbUFGdzgwakhCZTNsNW55QUtZbXpzdVJHcHI3Y09wMmlHTzBh?=
 =?utf-8?B?Y3c4NkxRelYvcG5aUjd6RzlRQ2xIRG53NnJIQjRETHhibGZNUmxDSmN5R09G?=
 =?utf-8?B?NmYxQzk5TGpDb3RwdXRObmw2K3VucjllZmk4L0EySjk4OWlEQ3dPRlZRdEgx?=
 =?utf-8?B?aDVqN1crTVlsbjVhS0x5bnNhWFhmTnRQbm9WNEhFRVJGWlhjaDVUVVN2dlBH?=
 =?utf-8?B?NUZCZFoyaHVBQnVMTGNpVmtIMXVKQWdpT2RPODZLTm9uVDY0b2NZdTQ1amNZ?=
 =?utf-8?B?d3J6NHZSNW95YXhsVHd4ZHV3RUo4dGdMY1RhOTJUZXQ0OHFtRHorYVdIYmNR?=
 =?utf-8?B?R2JOcGY2c3Z1Y0Rua3h3T1A4US9KK2hzK3ZCUEM1Z3VJZ3JTeTVoak53K1dw?=
 =?utf-8?B?TDhmd2wra2RML2tOOWZYV2R0TGlyQkFJTndIcFREVWlTL0lJOEFPQ0tqSkJ6?=
 =?utf-8?B?cTNidDVvTmszNGNEWGdrSUc1ampQSEtjTG82em5KZU1OdVliWDVNdU5sWTNJ?=
 =?utf-8?B?SU0wcTBwMnpIby9lYkZNM3ZhQkRkZ2RWT0g5YjRPL3lTcVlBSnZTQUZPbFFw?=
 =?utf-8?B?TXBGN3hERFhzM3VsbkJIcFh1WGY3c25mM2xMalR2MHpWVW50emt6K3BibVRY?=
 =?utf-8?B?Zis4OVpjdWRFOE1nV3Vka3NnNkhtaGtKV3g4SFJoN1ErTHVKQnZxcDVCQlU5?=
 =?utf-8?B?blF5alZjUUxWL3k0YXVramttV004MDUrekpEUjE0TUtTOGkzTGlmYjAzV3pR?=
 =?utf-8?B?RXNpRE5nQmN4aENLa1lLWHpWTEphZXh5RFY5U2lDWmZETXNUYlpjc2c4dzho?=
 =?utf-8?B?akc1eTVubGh1ck5ZNElIT2JnNDRmN3g0Z29WaU5ZUGd6bTNWTFdCUWpwZS9V?=
 =?utf-8?B?NzQ2bU44QjZHblBWSXprNEdscnc0USs1d2pYZTF2Y0U5TVNRbVJvOTJpL0Fz?=
 =?utf-8?B?ME9mdkd5RDRYTW5mVzNpc2NITTlBSnlUa2JrZmRmcWpVUVZFOGxUaFE3N0J2?=
 =?utf-8?B?ajZ2YkdxTU5lTkNQRjJxdEFES3JrRTlmSG52NkpSTnZldmc0WHJrVUlXUzR6?=
 =?utf-8?B?d3hVNjJ2OXNGcXVYa2NZQXZXMHNQaFY4QVBpMTlsSENiUFBTY1ByUzFlY1kz?=
 =?utf-8?B?aEF2d0thbFc3L3d5SUtIOE51KzBZZlBlTzVKSnpZU0MrSjRSMTNjTHBMTlFv?=
 =?utf-8?B?ZkQzbFZxdmFwRXJTaVk5TkZac0NEbXo0V3Byelh5bGpmQ05UTUV5WXE0NVc3?=
 =?utf-8?B?bHVuVHI2WW5pdmxXVGNQdGRYM3pvZ1hWTjkyY1UreEpYQ0JSUWFTVjRtSHBI?=
 =?utf-8?B?UTlVNWFHUXFsa1loS3h2T2VTdlQ5Uk5hMkRMYUVwY3NVcXBDeWl0N3VQVGM5?=
 =?utf-8?B?NEtKVXgzMGtrcUFkaVFTSlZhUzJGQ2oweG91WDM0K29SSW5taldmNzBIZm5B?=
 =?utf-8?B?UmtkQ1c0UHk2dnNLVVRDODg0alRVREZGNlFrWXhkbDRIbGpkV2h0d2Fxa3V1?=
 =?utf-8?B?T1puVXNpeXYxRFpYOHlqYzF0L3hhZXM3Z1hUd1dna0xoSjhzRmsrWGNpdDR4?=
 =?utf-8?B?ZzEzUEdQa2xjNGxCMytHbzNqT0JRbVpPUTdUa3Z5bms0NityNHJSUGt0NjV3?=
 =?utf-8?B?ZCtocy91dzMxWnV3T3hleWJ0U0RDbHp3M2NtS25lVEliUkp4TmVWbGR6UlVL?=
 =?utf-8?B?ckhwQXJkQjB1S2xpWE1CS2ZBUkcwbjBLdW82aVIwYkQ5a2YrN3MvZEZsQnNB?=
 =?utf-8?B?a1R3SmE2bFl4VHp2UldaOTQ3WjRDaEdOS0lXeDRWeUhWYlljSkFJMjZlNUla?=
 =?utf-8?B?N2tqMEVmZVo5VTl2amhCQXpNaTQ0R0NzM3BUWThrM1lQQUZIdjUvWmpoVzBu?=
 =?utf-8?B?eENWa1R5U0twOGE2dHU4T294UE5HUGtsYm04S2JlSW9nakxwKyt5MkNmdGtQ?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b695369-4535-4c7f-8206-08ddeafbeb73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:09:46.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kfAjreneKOkcb4/eSwb+Ye8bxCgytIfD6vRgnQ6g8nEaUMUVD8RfZBgPuE6XO635UxmmumbOnVsB+tLYIH9rZZdyXC2D4NjifiIsbr/iYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-OriginatorOrg: intel.com

From: Michal Kubiak <michal.kubiak@intel.com>
Date: Fri, 8 Aug 2025 17:56:57 +0200

> The commit 53844673d555 ("iavf: kill 'legacy-rx' for good") removed
> the legacy Rx path in the iavf driver. This change applies the same
> rationale to the ice driver.

BTW you forgot to remove `ICE_RX_FLAGS_RING_BUILD_SKB` from ice_txrx.h
and the corresponding inlines (now unused).

Thanks,
Olek

