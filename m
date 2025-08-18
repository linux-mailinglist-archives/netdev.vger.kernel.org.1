Return-Path: <netdev+bounces-214508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0628AB29F20
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E1F4E83FE
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308E2C2366;
	Mon, 18 Aug 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbufBvNj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92FE2C235F
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512886; cv=fail; b=UZSB50y48IP7AS0hcURH/PpRIejBH3n/1/YRZhsFAI8KtzvDlvMWHNKKbYlop+GVNJxTkbz7x8L7HMC+7i0sKGRTWA2RF4X6k5wdrdlesNYm0O7I2tgn79BHmCnHzUPdUOLtct2W5ZKtqrpVvfoVjyKxOzQZs/ZJNOfUmXdS3fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512886; c=relaxed/simple;
	bh=W7Kn1SwjuqVSBh+nAmWGMPFSNx+Qi13CsuSDs2/SqiQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FUN00rxUp16FlKO8OpMcIgH9qPD+h+bLvvL/qxEyr+asizbvvV4PQubCf1PF7lUWDZMRnaNQL2zI9ki8fZqW3Rm2YN8eTEp1KNeoUYfPWvKSGVka154P7gXyzqZteBk9BtTt3Vw8pX1aL9D8JuxKLNoQkkrmM03W8eita9Q4ruM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbufBvNj; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755512885; x=1787048885;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W7Kn1SwjuqVSBh+nAmWGMPFSNx+Qi13CsuSDs2/SqiQ=;
  b=jbufBvNjUoRA2k6DhCdlEmCn5dWSOWieA9Jni5XMsupQxuAm20q2MydS
   bEgkpBpjDpV18cAthLzIkWTSkhoWzjMxmTZwIqL8dLNeRYgvwTWMTtngt
   HrrKr9y/SwcfKpvkQS+xwD1vMwMzUNIy1HGeyxi4DQ8wcjmbptEJv3tJv
   jp5cCUP6zm/tsUmqKwFzWQVO4oqjY99QHTYCNcvPDQcjITS4X2XzOKmOQ
   t1967Uo+JRbVA67XpYcqCXoCbTfNGPzFeQneRXN9Qfq9JUz2+A8Nokxmq
   7Xm+peXBPwTX271ZHQ2ZK7T1f3KtJJqf/jZcKymT28Fh9eXyAGEouoq0f
   A==;
X-CSE-ConnectionGUID: gfn/OXsdQZSkbXrYm9K4+g==
X-CSE-MsgGUID: HBX5Yb0OS+OIWK/PzuzxfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="56761994"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="56761994"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 03:28:04 -0700
X-CSE-ConnectionGUID: 6E2I1EjqS8yG3/KGeuPdBw==
X-CSE-MsgGUID: o/joFuYgSZ6LBQGnlJ1haA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171782376"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 03:28:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 03:28:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 03:28:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.86)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 03:28:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMtuUeqJ8peSP9SiltjJzKAYOhfhFKthgCzcGiC4fhNn4WUb3UWcpQg2AuBXI3nrzu7Y99m2K8DfdaVLqPr6XL2sgqQrdQ05Wq+tAa23ZW9gPo5uK7NdzCfU8ut+R2VQTudY3IL8Ly6l0Fk9mJSFYWigdUnCsq+A+e5AAVJjiMwTtijSpzdeywkxmVaPMF4cYIAzxOu5d7VulgJx8Fe63ckcxFk94nSPVyXEMjYXX3s2HK7S0AdTX0yhqGeBpdPzZqvsQt3z7HHR2Fis5DNuwD1Fxezf6hqiTe3UDW1DRMy3bjJGZkWZNNqw2R3kUjb+l/O7S28hFitOKiHo5anlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M6ju4yMKQOj9IKnDlXd5Y1vxATdxROEnQ3lPZhhgpM=;
 b=IoBndS88bm4rUuulcWQ2pDhFGQ+OR/KInI0lSB9AWvoIzkkHZJAlEsbK8KEf8swttOetYjuYiso+K8Dy70mIqrApwSnozdS3kv+OfkiPhWGBDwjfp3+yx7IBb3OJ/46zVdMf1tBLvmXdWyb6gieV/Sp6xPz4FTaKE1LimtaaKqozfprt9nZLNMAwE40UZhJ7TucI/xh0Dj/F6FRkN4i+z5pOOnWGiuL2H5iprylBeF9a8luAytXTC/4jVhfLYLg+hIUWxeHgp3POs3lLPMtNJm83R/7A9RJSCDAu3hlXIvPEjeeFLFU8PvfBkj4cvI0odcMCEQrz71Wqr2Iaxy4w9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB7362.namprd11.prod.outlook.com (2603:10b6:930:85::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:28:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 10:28:00 +0000
Message-ID: <7f767a82-b70e-4520-a9cd-360949961373@intel.com>
Date: Mon, 18 Aug 2025 12:27:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] ice: fix double-call to ice_deinit_hw()
 during probe failure
To: Jacob Keller <jacob.e.keller@intel.com>, Anthony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <vgrinber@redhat.com>, <netdev@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, Simon Horman <horms@kernel.org>, "Marcin
 Szycik" <marcin.szycik@linux.intel.com>
References: <20250717-jk-ddp-safe-mode-issue-v1-0-e113b2baed79@intel.com>
 <20250717-jk-ddp-safe-mode-issue-v1-1-e113b2baed79@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250717-jk-ddp-safe-mode-issue-v1-1-e113b2baed79@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0048.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: cecf99c1-d820-4706-a6ac-08ddde41e801
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0tBRWVidXloN3loV1ZQcU9mQ2hGb3paMnU3R1JsSGw1UlltdGdNL3V3cTlp?=
 =?utf-8?B?bWxENHNNM3JUc3pZVjRtYWMxN2ludTJkWisxbTZqaGF2cUswY2JWL2Y0ZGU0?=
 =?utf-8?B?SDZEZm1lemJaTG42RWNWWi9zUE5oeWlWUEN5WFhVd0hJL3RjRnMraTNnaW4w?=
 =?utf-8?B?U1lwdEF6Z2VYZXcyTDZaeHFHRDJ5RGhhSjk2V2FmcjMyeHVKZzJ1UWR2MUVi?=
 =?utf-8?B?eUU3WUMxOStybWlHeFNla1d0SDhQWFA2alNzVm16UnorOEpTdFFhL0Zqa2dC?=
 =?utf-8?B?czF2MTRIand4ZElDSm9heG9ialpIc2h1bG94ekZoMmlwZGh6dHBSREtDYjNv?=
 =?utf-8?B?b2h3S0RvV09yZy9TRnlwVEhVL2hvVjN1OEcyYU81eEFvM21EemdKRzVuVEN4?=
 =?utf-8?B?dFh5cTB2dms4dHRVb29DOGxMQ09qQmJ2d2xMNDhTbjVzUTRiZG52MEpWcDBj?=
 =?utf-8?B?eWYwOCtScG4yRnRtQjNjdjF3ZnFLQU9oVTNsYmIwOW1TYVJXSmN1RWJSYTJx?=
 =?utf-8?B?VndsYlBPOUtQUWRVYWRjeW5UMFBja0tscjJaY3Ewbk41RytSaTd3MEtmbm5j?=
 =?utf-8?B?aDZTamlYb3B0NjlObVR5WmV0YUJoZjJ4NjhhRzRST0RuUkE2UkcwVlB0dzgw?=
 =?utf-8?B?eDh0aStCM29rN05TeTYzNDFQWFBSelpOMG80VERJdWY2amNLUUczb1Bhd1lm?=
 =?utf-8?B?bUM5UHlnQzFNaEhQdkNCbCsrSW1HQnM4cEpkaUZYNEZPZTl2MWNwbG1DclJR?=
 =?utf-8?B?NFNHNTRmYWxXQnhPbXNzMjJVdXZBeGdEdWxsb1dMSWpYNUhoWmdSM1hVODBU?=
 =?utf-8?B?Y0xidVBXWWh1MUYxV01PM2U4T092dG9aTVJCbjFtU2dTRzVreEF3akkxRDNU?=
 =?utf-8?B?UEZhTGlKaXpLem85TXRiL0IyNDlFa0pFd0xMV0JWQ3Q4REtnaDFvZXdQM3Bs?=
 =?utf-8?B?dmhCYndyM3ZYTytKR2lmS1ZlZWZHcEYrZ0NrTzJpWjF5T3ppZGhMVTFGSWJ1?=
 =?utf-8?B?VzBxT0gyVE5iQjIra1VyY2lHVjhXbDF1U2UxRHNPQnY1djN6aTlONExQdWV1?=
 =?utf-8?B?Tjl0a2VoUk1FZ0ZYbWZXZkVmUFowTzFvUjc4d1owWGgxMGdIZ1pFaUlkWEg4?=
 =?utf-8?B?bUJCNklocThGWGF0WEk0MG11aEdYbVRKNzM2UkZDRzRqMXZvUnZnMUtlVEJ0?=
 =?utf-8?B?NnlOWXpEWk94dURPdXYwenB5OGNLQTZza1kwMmg4RUlUQ0hQUnJobFZSYzFs?=
 =?utf-8?B?a0hPKzRrN1RONHlsWW9EWmJscEFZNEhpNVVxWDI0WUJJQ3dWdjZ4eXVIUXk0?=
 =?utf-8?B?NU0vNy83dUhVazBBdUhRMkdJRUJudzNvaGpuSkR2OFVpY01jUG1MZWlGejVr?=
 =?utf-8?B?MytUc1I3RTdoZWVZWFl3Vis1cjFmSCtRSEhuaFhyd2NkOTZzSTBrYkFNZnVj?=
 =?utf-8?B?aExJbTlleWxodHhkdHl3Z1ovREI5R1Z1ckhMUFI2Qjk0bnBQQTB4elQrMldD?=
 =?utf-8?B?aVFRZkpRL0Z2eVRMRzhGZXhjTjNUKzZNLzVRRHROTnQwTG43Um1QWXJoLzR6?=
 =?utf-8?B?YlQzajdFb1RQM1lCUTJKQ2kyOXhuc1hWc0N6bS9TK1RUam5IVlViUWtIL1pn?=
 =?utf-8?B?aUc3Wm9SemIzMGs0KzluOXI3SEZsMEVXR3BoUnJMNThyc1NoQWFVeDhmeEJB?=
 =?utf-8?B?cFJWRnRsQVdkZ1A2VTRPSW5ZOEJtYXNHVXlDOVJkL0NUdERkc1FBQ2dDSHlV?=
 =?utf-8?B?dXdYS2hrTkZlZzNPVjZmdUQ1clBLSVM4RlFrQnRWR0oxaWlsdnF2WDF6WTlO?=
 =?utf-8?B?RlM2aVBreGlqV1Z0UGcwRTYra0lVZEpIOEFJYjF6WDlEM1NERHhhcFk5VWZq?=
 =?utf-8?B?OUNjS0Rsc1F5ampuODEwVzJxTW1KUFRGQTJDZXZzMXZRdW1QV3ZQRDdGMmdo?=
 =?utf-8?Q?MZr1dlXvfQo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0JIZ3paWjV1OHpEN0llZXFJbTVmTmFuQzNLS3pZNHluR3dtaDlGVWVCNkha?=
 =?utf-8?B?YUd2c3B1cDFFVDgrdGw3YzQrcGpJS1FZT3FTM0hPcmxkaGFWV3NnTytxV2FV?=
 =?utf-8?B?OEViMkM2bzZ2ZmNzN1psc2x0QnIxekgxcUtTZkhMMkNhakNrRDltQkZNTmsy?=
 =?utf-8?B?WTZvZVBreVBSVDM3am92dk9zb3ZncWxkTVFHV21qaDM4NW1ZWEdPR1NoUWJk?=
 =?utf-8?B?QmtJaStpUmZqZ1h2YVNzRnRuUURwQS9FMTZpamppcTZNdWg3ZTh1ZDVQeEtD?=
 =?utf-8?B?K1c1V1RCc1hwQWNPbkYrdzU5Q3NaaGdYaVBRZlR4Y2w0anUwL0FPVklQZ3VR?=
 =?utf-8?B?ZEVJOHMyYVhNZHE4c3A4SmZrRjQ5SkN4WTlzeG5OV0hFMjUwK2E0VllvZVJU?=
 =?utf-8?B?MFplZEJmMkVZdjVQTmRsbXpJakppTHRNMGRLQStFT2kxTG8wQlZDMmo2TnlR?=
 =?utf-8?B?NmxraTRSODVyVUdWa1N5MEpaamwzS1RaKzJUNnFFdnNEZmZjcFZ1OUFYMVRw?=
 =?utf-8?B?RDlGN0ptQXJuMnJTMjFpUEZEd1h6ZDJRcWJlclNBSjhmQ0pTV0lsUEl0Unli?=
 =?utf-8?B?VkEvSU0yTVpPT3g3V0c2VVYxS0hLblpCejBqa2prWW9NNTBrMTNEemgrQkpM?=
 =?utf-8?B?cnVXUmNZQUpGUjNVbStZRkcrNWJoZWMzMkVBTTZpbmx6NFVUZDZoSDFXdXJV?=
 =?utf-8?B?Z05jSUUxTG81Nm5CbU0yNFVsMER4QVFQd2x4dm5BSC9XVEh3RnhrVHQvVjI3?=
 =?utf-8?B?dHZKSEV5NlEzZDFXN2hkRURFRTZ6NUlVSlcvS21JOUUraFpEeEcrb29hT013?=
 =?utf-8?B?VExPMlhuTjA3MnphOUpiVlNzaUx1aHZhYUhHVSt0QjVvWlpCcng5UlRjSnQ1?=
 =?utf-8?B?QVBDem1tRXN6Z01hZXUraXVlK3FRL3JXZkpFS2VsNHpmQlNRNHc1VjZQL3VG?=
 =?utf-8?B?WlpicXR1T1hSM3dlMEFKZlJsTkJwOXltVlhLYjgxSFc1SDZnUkRpNFB1cE9P?=
 =?utf-8?B?NWZiVnlhS1hoMFI1c3RQczV1eXNaZ3Q4VVo2TFhvbWxSYTIzOFJhR0RzL2hX?=
 =?utf-8?B?VTRUNnhvblFwTDhqWHNOZUltdnE3ck9pOUUzSTdLMHFrSEJ6UkJoU1E4NmJo?=
 =?utf-8?B?M0twVG5Wam55YUtZNDFCTTlYM1Yyb3hBYnd3bm5mUnlOWElxbXdWZU0zYVdz?=
 =?utf-8?B?NW9wVUp6RFJPZ3U4bkF1OHJ6UVl4RUVwQXhYd1Q2Qy83aGxpMWNpSVl0UFFl?=
 =?utf-8?B?d0hxVEowR3Z1SzhYeHlJSGVsQ0RRd2JaMW8zZ2NURWpTL3lNWXEwY01wWVNG?=
 =?utf-8?B?eVJZcEN5WmkzNEkyVWczNUpWVjZlU2hHNDZHMEhpMzRUemRTaVJrUWRLVlQ0?=
 =?utf-8?B?RVYrTkhpbTUvRTZYL2ZkYjFPbHlnT2lhaGkveUErV3V5bDZ0WkxOdUlMZUkz?=
 =?utf-8?B?bnBabTB1TTUrNDRmTDdKaDk0NzN2cjZGMjI2cjBNaXYySVJjV1RZTyt1RmlE?=
 =?utf-8?B?dE55MmhSWXhHY2IrSENRQnJ0L3ByRnJIMzNHdm5Da2RRM3B5UjRHbXYvZmJN?=
 =?utf-8?B?Rmk4OGo1NnorYXQvNEpDMUJDMEw4bG54Y2tCbElyTVhFOVRMYzNmVy9aRFJa?=
 =?utf-8?B?U3NMWC82dFEvVHlpOElqT20xRzMzdEJNWmlyREhFUGUzeit0eXRBRnhPcUJP?=
 =?utf-8?B?VUJsWFhuczVDVlhoem9Pdzl0ZTcxYTFId0MxUk1JN1JSd3o0bmw5VGhjU214?=
 =?utf-8?B?RUl1TUNXMzFmWmxWM0NXY2Y0d3hHaTA2NW9PMmZ1MVFlaVFWa0dLSXo1djV4?=
 =?utf-8?B?SHQ2SmVVY2hWWUFCRnhsMkd1aVVJS3VkcHRaSzhONEswTFRaTEduazlPczhH?=
 =?utf-8?B?aTlSTU81TzlrektpNWVDdCtQZWJCOVFVQndyTGhJcUFLOUJsUkgyNXR6UG5i?=
 =?utf-8?B?VG9kZ25lcndzWUVqbjdTUmo1OUpsQ0xtclVkM0pJRXVoWC9yOFd1ZHdCWm9D?=
 =?utf-8?B?ekhsWDBYazhaRlpTNDUzWnpXMndXbkRzdXlqY0JFYThQVGJhUzhMTlM0bVZj?=
 =?utf-8?B?cjRQZU5PVkZsTC81eTlDcGZmdTYvbXBEZndiMWxoOHd2aWllUnNhMW5lYlFU?=
 =?utf-8?B?R2RiWEV2bTlsZGhqUDAxNHViTkJmWCtyKzhjeUJ4clZwUlhJd0NpRFlqYkVj?=
 =?utf-8?Q?PiLwbwhDbXdxIDd89CNeIPo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cecf99c1-d820-4706-a6ac-08ddde41e801
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:28:00.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxSlQV9CIg4LA2fwNdBTym/ai50EMI6/ff63mq4WWJjD5rMP+lVvT7RiVTUXuGWHjW7hxcNm8n1JyRE3BJ+qegs0sUDz8OKI54TK8YLAnsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7362
X-OriginatorOrg: intel.com

On 7/17/25 18:57, Jacob Keller wrote:
> The following (and similar) KFENCE bugs have recently been found occurring
> during certain error flows of the ice_probe() function:
> 
> kernel: ==================================================================
> kernel: BUG: KFENCE: use-after-free read in ice_cleanup_fltr_mgmt_struct+0x1d
> kernel: Use-after-free read at 0x00000000e72fe5ed (in kfence-#223):
> kernel:  ice_cleanup_fltr_mgmt_struct+0x1d/0x200 [ice]
> kernel:  ice_deinit_hw+0x1e/0x60 [ice]
> kernel:  ice_probe+0x245/0x2e0 [ice]
> kernel:
> kernel: kfence-#223: <..snip..>
> kernel: allocated by task 7553 on cpu 0 at 2243.527621s (198.108303s ago):
> kernel:  devm_kmalloc+0x57/0x120
> kernel:  ice_init_hw+0x491/0x8e0 [ice]
> kernel:  ice_probe+0x203/0x2e0 [ice]
> kernel:
> kernel: freed by task 7553 on cpu 0 at 2441.509158s (0.175707s ago):
> kernel:  ice_deinit_hw+0x1e/0x60 [ice]
> kernel:  ice_init+0x1ad/0x570 [ice]
> kernel:  ice_probe+0x22b/0x2e0 [ice]
> kernel:
> kernel: ==================================================================
> 
> These occur as the result of a double-call to ice_deinit_hw(). This double
> call happens if ice_init() fails at any point after calling
> ice_init_dev().
> 
> Upon errors, ice_init() calls ice_deinit_dev(), which is supposed to be the
> inverse of ice_init_dev(). However, currently ice_init_dev() does not call
> ice_init_hw(). Instead, ice_init_hw() is called by ice_probe(). Thus,
> ice_probe() itself calls ice_deinit_hw() as part of its error cleanup
> logic.
> 
> This results in two calls to ice_deinit_hw() which results in straight
> forward use-after-free violations due to double calling kfree and other
> cleanup functions.
> 
> To avoid this double call, move the call to ice_init_hw() into
> ice_init_dev(), and remove the now logically unnecessary cleanup from
> ice_probe(). This is simpler than the alternative of moving ice_deinit_hw()
> *out* of ice_deinit_dev().

[1]

> 
> Moving the calls to ice_deinit_hw() requires validating all cleanup paths,
> and changing significantly more code. Moving the calls of ice_init_hw()
> requires only validating that the new placement is still prior to all HW
> structure accesses.
> 
> For ice_probe(), this now delays ice_init_hw() from before
> ice_adapter_get() to just after it. This is safe, as ice_adapter_get() does
> not rely on the HW structure.

I introduced the order change by
commit fb59a520bbb1 ("ice: ice_probe: init ice_adapter after HW init").
You are right that current driver does not yet utilizes that, but it
will in the future.

> 
> For ice_devlink_reinit_up(), the ice_init_hw() is now called after
> ice_set_min_max_msix(). This is also safe as that function does not access
> the HW structure either.
> 
> This flow makes more logical sense, as ice_init_dev() is mirrored by
> ice_deinit_dev(), so it reasonably should be the caller of ice_init_hw().
> It also reduces one extra call to ice_init_hw() since both ice_probe() and
> ice_devlink_reinit_up() call ice_init_dev().
> 
> This resolves the double-free and avoids memory corruption and other
> invalid memory accesses in the event of a failed probe.
> 
> Fixes: 5b246e533d01 ("ice: split probe into smaller functions")

The blame should be on me here. But instead of fixing current bug in
a way that I would need to invert later, it would be better to fix w/o
order change. (If unwilling to wait, simple revert would be also better)

I would like to do [1] above, either by my or Jake hands (will sync).

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/devlink/devlink.c | 10 +---------
>   drivers/net/ethernet/intel/ice/ice_main.c        | 24 +++++++++++-------------
>   2 files changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 4af60e2f37df..ef49da0590b3 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1233,18 +1233,12 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
>   	struct ice_vsi *vsi = ice_get_main_vsi(pf);
>   	int err;
>   
> -	err = ice_init_hw(&pf->hw);
> -	if (err) {
> -		dev_err(ice_pf_to_dev(pf), "ice_init_hw failed: %d\n", err);
> -		return err;
> -	}
> -
>   	/* load MSI-X values */
>   	ice_set_min_max_msix(pf);
>   
>   	err = ice_init_dev(pf);
>   	if (err)
> -		goto unroll_hw_init;
> +		return err;
>   
>   	vsi->flags = ICE_VSI_FLAG_INIT;
>   
> @@ -1267,8 +1261,6 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
>   	rtnl_unlock();
>   err_vsi_cfg:
>   	ice_deinit_dev(pf);
> -unroll_hw_init:
> -	ice_deinit_hw(&pf->hw);
>   	return err;
>   }
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 0a11b4281092..c44bb8153ad0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4739,6 +4739,12 @@ int ice_init_dev(struct ice_pf *pf)
>   	struct ice_hw *hw = &pf->hw;
>   	int err;
>   
> +	err = ice_init_hw(hw);
> +	if (err) {
> +		dev_err(dev, "ice_init_hw failed: %d\n", err);
> +		return err;
> +	}
> +
>   	ice_init_feature_support(pf);
>   
>   	err = ice_init_ddp_config(hw, pf);
> @@ -4759,7 +4765,7 @@ int ice_init_dev(struct ice_pf *pf)
>   	err = ice_init_pf(pf);
>   	if (err) {
>   		dev_err(dev, "ice_init_pf failed: %d\n", err);
> -		return err;
> +		goto unroll_hw_init;
>   	}
>   
>   	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
> @@ -4803,6 +4809,8 @@ int ice_init_dev(struct ice_pf *pf)
>   	ice_clear_interrupt_scheme(pf);
>   unroll_pf_init:
>   	ice_deinit_pf(pf);
> +unroll_hw_init:
> +	ice_deinit_hw(hw);
>   	return err;
>   }
>   
> @@ -5330,17 +5338,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>   	if (ice_is_recovery_mode(hw))
>   		return ice_probe_recovery_mode(pf);
>   
> -	err = ice_init_hw(hw);
> -	if (err) {
> -		dev_err(dev, "ice_init_hw failed: %d\n", err);
> -		return err;
> -	}
> -
>   	adapter = ice_adapter_get(pdev);
> -	if (IS_ERR(adapter)) {
> -		err = PTR_ERR(adapter);
> -		goto unroll_hw_init;
> -	}
> +	if (IS_ERR(adapter))
> +		return PTR_ERR(adapter);
>   	pf->adapter = adapter;
>   
>   	err = ice_init(pf);
> @@ -5366,8 +5366,6 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>   	ice_deinit(pf);
>   unroll_adapter:
>   	ice_adapter_put(pdev);
> -unroll_hw_init:
> -	ice_deinit_hw(hw);
>   	return err;
>   }
>   
> 


