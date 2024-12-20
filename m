Return-Path: <netdev+bounces-153714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E879F9507
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 16:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0380188C4CE
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252E3B784;
	Fri, 20 Dec 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGnphl9B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C917BD3
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706967; cv=fail; b=iAFq8KvhVolzg/eFUSN5esaN98oNMuj+GCbmoZ7WXshoR5zVFzgV4QBwAqp/3SY08soi3/kHk+l27PklVLrB6tJgXL619YhFMp4RpJm2WlBHzZOM6mhIqpE2kBJ+PdXjYIYYfdpX15JCHL0nm6PDcvcXijrlVTgOg2HMW18XyFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706967; c=relaxed/simple;
	bh=+VazVP1P3NrtP8gjQxb0QCqkprQKEg6kL0U9Qq8s81E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u7iTttF2Mrp7Z6vX4QTkRlbeZCCHEoa0Rif03eJ31tmKNZXTTKOxPeQe9O1BmfSgXqjIyGePOGxlQCjOLnpbOW+gHgv4TGEsXR9KfiJezRD1zMxHXCFInrXRZEanvgeNdjjf/A19eNRGfeDWGvMAmU5SODVIb6GX68emXOv2XNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGnphl9B; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734706966; x=1766242966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+VazVP1P3NrtP8gjQxb0QCqkprQKEg6kL0U9Qq8s81E=;
  b=dGnphl9Bc+ddjzoVCX6MT2iKjXj21YyJMZErqOon1SCVfIAyuy8okA1K
   iVUbFs5xr8rZujPMLlts4m3h0evUcpe1xiMsJeegR1047iCJGnwHaIaFr
   3POGRD8C9nvWKuLxfDkEuwgg1vkNvmNQ0Rmo57kqRTpOkkxlJiwGWrjPg
   z8ITmT9r5cxfg/CfKBso6MHpMz688btWPAxHjpltesGZuDO73VSBiJO3q
   wxLThaUeMsisriv4pvD35sNN+vOxjqrOXs7Fu/y41ieiRYX9Ks6376/Mf
   0r1fkUiOK8E4/8Y7BpE00FK+Cjo8PKoefB/HnIUsl30sBwk1fzCDgI6oU
   w==;
X-CSE-ConnectionGUID: N0Ea0nkLRKq/g/UP/Tm5gg==
X-CSE-MsgGUID: jGgq2D1ySXeSPbuJN1sZ+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35475540"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35475540"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 07:02:45 -0800
X-CSE-ConnectionGUID: ENw7x0utTBCVSx+37/z8tQ==
X-CSE-MsgGUID: VlySx0l3RVGplRmn6oPHjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="129346089"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 07:02:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 07:02:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 07:02:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 07:02:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIupsH5Qts/ByUv1ZZfXTd5KZWC1XICjMNT/dYnTVCszpCf6XliaGOiPEGN/WWdmYnvn52VMFos3SD7RgdE6qe/hjQWlXwB8Y76TznxeP71e8DwbigSNtWiP9d3O3TEyuhbdfAcazruYHcyjjOw+Dbri8SEbL7H8FYpX9cPu7D/MlS07ptrZOOTwUzCTefLjEQxrFFMBvbKjfuFhFFNR2uCIyxO9w5O/EbPoY9IRg4aBMz9CA0cjA1SLTKjOD5ORuLfoqkqE+QkhOxfUfoVT1BVp7iAV9fayzokRQhJzDLKvNWhuobW2erf9EdI/3q2qeW9ulMO65YRj8Xz3pgWc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWrbBpd6sCqfAIBgTxJ9kT+SSnx2Rz+eDdGJZiBaAdM=;
 b=HW42ybIrCKG2xO+GSUu5CQ+GreHTtiAKF4Zjdx65lQOMWSkf/LJ9RFW259pOqkzufn0xVR3OPrcDbwK+kURIng5BhjOrLASNGikmJ7hZPqr5qWk9FVGz6QRXl0y4RIoqGcbulQZvr6+iHv1RcXzpaeshyapJZ8IUG4h3ZDTIGDLCFW0cNYHDPvmK7dOEpqthne9qlWSLaGEpMHuWIiwwC9BETGWjndmOAlsZYOYUlwkvgBNqAMVrt9gGCSvBHgjuLY2gZbyI8qmdBIiQRGCSR49RN+VGBI8koWhsw4bGT9Uo5qVVampTfQtVunhiyQ//8Ih6XpZdeAyVdwK2nI7cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:02:37 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 15:02:37 +0000
Message-ID: <abd0513a-53e0-4ad8-b64c-005db84ae94b@intel.com>
Date: Fri, 20 Dec 2024 16:02:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] eth: fbnic: support ring channel set while
 up
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<davem@davemloft.net>
References: <20241220025241.1522781-1-kuba@kernel.org>
 <20241220025241.1522781-11-kuba@kernel.org>
 <6c788136-514a-429b-8a0c-db37849601a1@intel.com>
 <20241220061010.2771d19e@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241220061010.2771d19e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0078.eurprd02.prod.outlook.com
 (2603:10a6:802:14::49) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: c5758206-8e2f-42de-bef5-08dd21075785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TENRcG9mK0Q4TVBtRmRremJsM3RCU0JCaXNsdTJpRVAvWDQxMm54dHJqK2Vi?=
 =?utf-8?B?dCtDRlZEVkVmRk9IRGphWExaMEtvVzh5SlNndDRkOVJWL3RGcVlLVTlCc01h?=
 =?utf-8?B?eGFaaXRXSmNoZEFqVTdoSTZtSEpCNysyaUtmV012NFYyLzZxZ1ZxYVNJSDEx?=
 =?utf-8?B?WDFISmtwaGo4LzRGQjNSRGU0UHJNYlhEbC81R2VjUUtlSTFLT2hGRUlrYkov?=
 =?utf-8?B?ZFRueTk2OTVuNDkvMHFTMVY0VVF1RmVIOERFWXRKYm0xbHVtVFVpRk12Vm9r?=
 =?utf-8?B?MUN4YnhObGkxZHZmdmRLWWxVQVlRRjF5RmlPNUJuT1IvYnZDVThwOXlXNjNz?=
 =?utf-8?B?MnlsT0NyTU13bnBjZEJPeFl1cVZDMno1dG1sdm1qMHFGRnRIajhHNDIxb3hB?=
 =?utf-8?B?K043MjQzTUhPbHJKTlBscTlhYzVNOG44aVc2MmpFbU0rK21zUTk1b2QrTFhP?=
 =?utf-8?B?dDBlTHRld1RZbmhiQkVrSVdtUWZmaE1abG52dGF5b0gzdHRjaHRJbTlnZXpl?=
 =?utf-8?B?OC9vbHNKeVVSSWVqSVg1Mm5ieGU1anhLSTNoaDNNbHBNV0ErNHUzSG14SlQy?=
 =?utf-8?B?TnpGTEFPN0xkdmRqK0FiUEN5S3ZmcHY2ZFZ3TjYyWjRDRWFQdDkxeE91WlVs?=
 =?utf-8?B?ckQwYzZNZDNPL0RXM2dpMUV1cXJ0WEdXV1ZrK0pwSmdoVk5LUDJNc1RQaU5M?=
 =?utf-8?B?ZG91UFRrN1JsMWZyYjJwZjU2WFRrRWk3ZU9xelRqUjJxYU4rQjdIUkhjaUEx?=
 =?utf-8?B?bnNvZCsyd0lpalBrci9FeU03NCtoSXpJclhWSi9ZUzZNc0lZQXRTQVkzTmsr?=
 =?utf-8?B?N0RSdVdFeDRQWUtwT1VnZDl4cW92SGFPK1Q5N01nSkROWmV3MS94UzVtT0pY?=
 =?utf-8?B?eHhsMlpJR0tCNnpLK0hnemRWbmdZSllybnV2WitnclE0dzk5UThLZGlOVldm?=
 =?utf-8?B?SUlCa2NEY3FoZmxHMENQb3NVckRibGp1aGVhTWpJaDJvWmU3NTgyNnF5U2FZ?=
 =?utf-8?B?bEFkV3BzTm41Y053TjVmUEFzUkFTKy9aTkJaai9MM0hUUW9aTStHMlNMdCsx?=
 =?utf-8?B?d1d2NTEvT2NQbWxqVm42eUJXZjJDUjJRb2JVQ0JNRzc4K2xmYktKdUo2Sy91?=
 =?utf-8?B?US9pWXA0WFNnMjF4VzVUYjY1eWl0cFY2U0xra0pVanlTc3ZNT3RTRWRFSlhv?=
 =?utf-8?B?RlF4NU9YMXdJSTJhMVc3QW9vbUJYK2o2MDZqT0QxVXc0VGNpTFlUbVBicUZP?=
 =?utf-8?B?ZDdlQmN6TnN1YTlpR1lTaEVIaURIeGFFNTFTeGsvSHV4c3VFU0hXVEVoL1VT?=
 =?utf-8?B?bGp0UTVxQWtCdGlYUXpJSkFrVzQxM3RtV2tmMHdsWWRwVGVKcnl2Z2V4VU04?=
 =?utf-8?B?T2JwUERtUXBNMXlhMllOajk4ZlRzWGxGb3lWWktHalBWSWczUmZzTzFDMmQ5?=
 =?utf-8?B?NHZVV3BUNEdQRWdoTjlSaUhIZFZWK3N6djdRbkorSjlRL0lHOUkxM1YzY0p1?=
 =?utf-8?B?bUxmUm1EWG1TMmpRb2lLNFhoYzVIejc0QXovUVUwTmh2Z05GRDhSTmlDWTBo?=
 =?utf-8?B?MXRqdE1uUEVpbkp3dUJzYXh5YTRZL0RQWkNsYUpvcXpTbThvdWRmeEkxZEpr?=
 =?utf-8?B?VzhOZ0NKR0RTRmQyeW1NdXpkMmprU1IvTjVpdG1hRW9yWXE2Rlc5Vm5aS0Qw?=
 =?utf-8?B?NEtYRW5pRm51VGlyRkFkQmRpUDAwVjRYMlBuaEViOTNqbFkwWVB3aGJYNGo2?=
 =?utf-8?B?OXFvRlU2M2NVZjc0TmJwbWFYRXhubk0xdGVRa2FQZEFyYWloRDd6NU9BNlJo?=
 =?utf-8?B?VldqcFBFSjU5U24xOTRRVmIxdlV4RW5oNHEzZEIxR2d0ekVXd2EvMEV1ZTFT?=
 =?utf-8?Q?f4jeG4dxsNHlp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHBVb0NmWHNEdGFycGpIVXJrdE5tZURoYkpvanBtSC9uVDI4SCtDWjRDbTVo?=
 =?utf-8?B?MkRQbmFqbVNMR29xZ0RvTm1EY3JMbEtlT2RWNlJIL0tlV2ZNN2Q5S3NRbUtC?=
 =?utf-8?B?UnVYYmw0WVMxOVYvU28wSW90TTBWWDFkZ2tIUFhrNTN3dksvdExnb2R1VzBv?=
 =?utf-8?B?OWpDZTRKYmh6VXBOUTBRR1BxYnlSQ1RDMTZKRWFLeUlneFpWcDlGZFI3eFQz?=
 =?utf-8?B?Q3pqVXVoN0xYUGJoYXp6Z3BmRklJU2FFS21CN0JlUjZyL3N4SEVqWVRXTzZu?=
 =?utf-8?B?WS9oTms5eU0yZjVYZDBiR0o5allWMUlWM21mRGwwdkJJZnN3L2N1clduZTkz?=
 =?utf-8?B?N3JRTHFFYWxSZFBFcUIzT0tpZU01L3JLVmJZelB3dFI2NkRZMExHYXJlZ1Rp?=
 =?utf-8?B?c3hYQVdCTWxzb1FiTk5jd0llSVVubzBJUkRjWEsvTTg4Si9HRUI3RDJuVTJL?=
 =?utf-8?B?RFRRQkhMVUxYbjl6enk4cC94cisvK1RCTzZqUUdCajlnV0JpUTVCYlF1T3NW?=
 =?utf-8?B?UlpVeUpZNFZmcmVQWVFKVUpBWWNHKzVQS1V3eXNhN0dOQUd2anRDOUdtQ0Vq?=
 =?utf-8?B?WkNzYTBsTC83elJ6dTEvbWRVaVc0dlZ4TVU4SUY4ZHpja2RMRytzbXBBaTQw?=
 =?utf-8?B?QmExODV0aFdONTlWRGJtYURXZm95a05mOGJBSUQ3RVNTc01uVWY3Rjk1aEhC?=
 =?utf-8?B?anpicFdYSjY0Q1dqYklUSXVxWTRLTWFiU3N0MGhSSFpRbGlEZFJkS2lpRTdU?=
 =?utf-8?B?ZGpkVC9xTS9wWERQa3E2Ky9qNGFseEJLbHk3RWVxWWhhWDl4K2xhditvUHVi?=
 =?utf-8?B?enNsVDFUVzFoSG5JSUVwMW9GQlAvVXNCV0dXR0V0SlZGVlJSV09lYVlNUWZn?=
 =?utf-8?B?Wm0rMnVuOCtaVVlXMVdRaEdLcjlzRmRGYmQ2eGl2M1BabEdaOW9GREZtdTA1?=
 =?utf-8?B?MHhjWlpNenlEZ0ZaZS9NNzI2NWx2TDdGN04zemlTWHFySmROcE9tODNYNnYv?=
 =?utf-8?B?bklNSkxEOHFsWHN2Q3FsY0M4Nkx4RVo3U2lSQnQwcjhPWHFTN0NsNi96TjM4?=
 =?utf-8?B?OW9iYTBsTkpKYjRIamNVQWRNbTNjRDhiNkhET3JSM01zQ1JlZHFYQlB4cGtF?=
 =?utf-8?B?SzhWSVpvQUwvV1c2QUFHK3JHRmp3aWI4dGQrenNLRjlxSmVva2RjZDBXVlFF?=
 =?utf-8?B?UjJjbXJFTGpzT25EZCs3ME9BdGdFa0Nrc0RtVm8yUzB4dk1SNVptK25KZFY1?=
 =?utf-8?B?b3Fkb2RseElZeWJJTmtmVTlWaVQ5VGpMN2xybFltaHJReEs2VnlXR1FPTkR1?=
 =?utf-8?B?akppY1BOZnd3YU1DVWc4QWtRc3hTNlVYTy9MQWJlNGNldnZ0NWpHdlJpNFpV?=
 =?utf-8?B?R0c1VkhOMGxMcXkzSk1ETXJrWXZiMllNVFBzb3dnakYxV0Vlei9kUURYTVd6?=
 =?utf-8?B?azRNcGgvTWlsMDR1cHBrNGNRMDEzUGdaMmxGS1M0QVY4eVZFa2xqcGN4U0lK?=
 =?utf-8?B?QzByWVhpMTFKcUZEWXU0b2IvQlNOU3F1VUYxRlpYYTdwRTdWbHI3RmQ0TDJM?=
 =?utf-8?B?VkJML25tb1RmZmRHZERWTlp6VnRNeTJKNGorVy9sM3psbHRUN2dtN3dNcFRW?=
 =?utf-8?B?SHVaaGdEYUo5QVpUZGE0cFBhbjJJVWZLaXFhbVFXRzJMU3NrN0NVaFEySG1V?=
 =?utf-8?B?SmtkMDRqQ2VXRUxzbFcrRk1ncW0xWStrQXhtak5CMGU2cldObWUvMWo2WDI0?=
 =?utf-8?B?UTlpUGRrbkdsREpyTGVvaVBnaTlyUnBoeDF1YXVjamtSS0Y3OUNsYktGbDNI?=
 =?utf-8?B?SDlYQlVyMHlNTFFKazVJL0JsUjc0NmxIdC9kcExGRDdCbTVKUHJ2VnJlL2hM?=
 =?utf-8?B?ekJmbVVCcXgrRzRnK2NFbjBtVU4vMlpLVW5LZjJya1R3aG1kQzZlenpCajZC?=
 =?utf-8?B?ak9pRjJrRzZoaDVMcmM5ZnZhUEJsUW1Qc05GeWNVeXFYMk9ZUjBBbW91NmIv?=
 =?utf-8?B?Q3c2azAvUTFpTXVRaEZmSUZVNXVwRW9KZW44T1o1RnNJaEVPMDZQcmFvOFpD?=
 =?utf-8?B?MlZ3cWl1K003MmpQeUFWMTE4RDloUURwdzA3S211UXJnZVRENVExUUhGNTZQ?=
 =?utf-8?B?WWMwQ2MwRTZ5VmpFQ3pXL2RtTExtNEdUNjFreWJsMmJMQ0hrZEEwMjlBQXpJ?=
 =?utf-8?Q?dDORqcndYr5mzNQN5MxwjJ4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5758206-8e2f-42de-bef5-08dd21075785
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:02:37.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDtOgMzXhM9/xvr2oa14PbUSTH34UhWegjHpY+PacTEaue8/CLy/pMyf6klTRnhkIs9JKmrauZVwJhkj2tdal9WD9tbiI+cfROdn959D/G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-OriginatorOrg: intel.com

On 12/20/24 15:10, Jakub Kicinski wrote:
> On Fri, 20 Dec 2024 14:49:02 +0100 Przemek Kitszel wrote:
>>> +	fbnic_clone_swap_cfg(orig, clone);
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(orig->napi); i++)
>>> +		swap(clone->napi[i], orig->napi[i]);
>>> +	for (i = 0; i < ARRAY_SIZE(orig->tx); i++)
>>> +		swap(clone->tx[i], orig->tx[i]);
>>> +	for (i = 0; i < ARRAY_SIZE(orig->rx); i++)
>>> +		swap(clone->rx[i], orig->rx[i]);
>>
>> I would perhaps move the above 6 lines to fbnic_clone_swap_cfg()
> 
> Hm, it's here because of how we implemented ringparam changes.
> They reuse some of the clone stuff but not all. Can we revisit
> once that's sent?

This could stay as is here, it's in the fbnic_clone_swap() so does also
belong.
The "would+perhaps" + my RB tag meant that I'm fine as-is with this :)

