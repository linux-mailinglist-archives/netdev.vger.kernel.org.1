Return-Path: <netdev+bounces-130121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA229886B1
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F2128428A
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1965D477;
	Fri, 27 Sep 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlXRSoVS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262324D8DA;
	Fri, 27 Sep 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446128; cv=fail; b=Zwtz3nVayI/aor2XwlbpDYbL33wBxgYmlm0GE2C7gEsNTWv5ouqyQ4dthGclOVpdmLxRvu7iMGOwuyQCosBRpYJmdobTqslr3xN7u3yNt+OGtORj4VG55Anu/pDr01GX8E8BQFqNUKlvSwxSlmkX0Kx6V9kVoWZl8RDzNmP7arg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446128; c=relaxed/simple;
	bh=hDwvj1W2VAkQFZjzfLXvNYfne674Fit8QB7xbxvMcgs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTY86SVQnlAwk7duMHEu6jb+Bb0ZI43p5GLGG/EAjAIyXLdgA6KtheOYKskcuBRgmRIIWuyzwBGea/1xqA8felCUSN1nyQY+y/dZ1lC8DIszB+vUbK4jlq9oHOwwL+4uq0HdHrAL66kkTtZimjvauK+wfySMs8DWRjrV9+CaAxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlXRSoVS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727446127; x=1758982127;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hDwvj1W2VAkQFZjzfLXvNYfne674Fit8QB7xbxvMcgs=;
  b=mlXRSoVS0QRCGSz5D3e+8A4SXfD9cVWTeq3IDTfpdmKwSl04jvV3ZPVR
   9YhuuR4BAUguSfnrvO4l87xhAejtMzknDJA0PEsmNiSxuEH4Cck5rfxjW
   7v/d2qjO+ofQQ0aWT480aK5PnzbsLGzs8VzYvtlUZ9JFvm9LFHdykAVFT
   Ou1I7QNtkfYJzvlDKxplM23T6GgoehtItC+/HVIWE5e4dqP+Fga8hWqLQ
   PNWJRzhzsvKaHcRgq1cC9+rWOoffOXxZZ3NxEgjXk5JkELgYPDEp1LdEK
   UTeccfclYntcGrhIWKOT2XFbf1XQd2c4JcTOPuklGDGpTXFaOhhLNjIib
   g==;
X-CSE-ConnectionGUID: VPLQMjuhQCCJq+t6/0rqXQ==
X-CSE-MsgGUID: gnWFTU/YQ8WcThNpZkruZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30481440"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="30481440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 07:08:46 -0700
X-CSE-ConnectionGUID: vnwP+8QHQamG+fNKgxpmHQ==
X-CSE-MsgGUID: KHnIJxEDRyuVYUDVY2sZsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="76919691"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 07:08:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 07:08:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 07:08:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 07:08:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 07:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVQkq4IOyYs0m0cHB4keGn9RCyibh6pi2ADWcny473iI+BTwSVndZDNVtio44okIdu1fvPVtiPloU5FxSjE9ooEd89aEE64lYcyOttP2LwDte9M17kWsJKMYJtwPPx988h1988emSllC89qFCF2PmT8r+TGSRiBcgMSTvwhN6e+zklvdtO4GHF4ruvZkh4XIbmdr/i5DR1kBOgOBPxxCh9ce0zrvdt56kHwOjRnMpf5hCzSWMvC+uDVF9q5ja49zg9z31lheoTlcwRucg4SSFezlWm7jCa30Sj1EFeVbnNLgC4gd5RmYW8eVqPbAQYvLy8/I4xMiGXycrowEgPsCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+UagoErfeKx4QSvK/bRPk3EoFt6oEyfMPKUJpKUQ6g=;
 b=e1Yli+iNFt7JKOIzCzk6ZKRE/gggapYPCeNHS5qckgsW2olDx+REzyLyExVc6z8a/6M5NFo1lk+nTKthoJEO/U6Mn6f8ul0gBCcxuN9QjqWs1J/Vx1TKNIkURiFk0cyW9x9orKYJp9NZPKMz1VdBlqKHQEhhxP9ShsKj6g9DyZ5vXFBBPKQHJCa5wLr21sqEIbadby+jb1aNZBrKiQTSFLznepqaNhQ6IqLYhPgaUC8dhPJISH51gGPjOoEKFn15BEtdSGXgPJXQ5kJ/URx7HCwGCZMmPsdq8zvnyZjoXJe2uTiC6clmlimrIc9DLVL12pBn6nbfXjC8Meg/nLd4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Fri, 27 Sep
 2024 14:08:35 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 14:08:35 +0000
Message-ID: <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>
Date: Fri, 27 Sep 2024 16:08:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<amadeuszx.slawinski@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f337d3-a130-4d42-3f48-08dcdefde078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFpxSXdycXlkYzNUT0NnV21XS2R2QlBlOEZOSUhDaUFUWG10V0Q3ZHhWU05C?=
 =?utf-8?B?MTA5dnNXaVJ1aGlsZ2M5eUd4bUZiZHQvOXlSNWZKV0N6RjBWd2JqbGdqUlJp?=
 =?utf-8?B?bjRvcXJLbHNDTnVYdXNQc041SXZmYVhmc2FNa2J0SmJWa1RuVmJuRGV3ZnRP?=
 =?utf-8?B?dm1uRHVIK1lwRktzU215MEIyTklncFFEZFVYUXlyby8xK1BJRzlsOWp4MjRw?=
 =?utf-8?B?OGhRT1dTWlZFYjhGay9mVDZIN3ZaOWxHU3g2WUZqQThJbm1lalVLUlh4ZW04?=
 =?utf-8?B?eDV1YXRaYjRVY3A0eGhwbWZydmd4VDlPTDNDdU1DV2l0QjRjREVDR2tXK2k4?=
 =?utf-8?B?Z05mN1dnSnZ0MXpqekM2aGFHL09nWGJmWDZzWVlnYVo2RlpCVUhCNGtSUXlj?=
 =?utf-8?B?NlZ4K2hlbzM5TzA1eHJ6YjY4Zjd5MHJBZElnaTVNSC91VEVRRkNFUy9GditK?=
 =?utf-8?B?ck1LSmc1MkQ3bVVkNG1lYlNPeDZvbHh2Y3NDanRIL1htdUQrNzZYNVp1ZWxY?=
 =?utf-8?B?VHNMZjRISGpTVUczK1Q0WjRNSU5DYjkwT1lSQk1pVHNiTy9iZUl1TlRBOEdE?=
 =?utf-8?B?YzU3WTFKeERQUXAyQUZIc0VnZHRFQW5BWmFERjh1Z2taOVhpZ0FPMW85RGYw?=
 =?utf-8?B?UHdFZ2tNbmppVExMME5uY0l0dGRXZ2NVTzRQVUMwQTFXM012RG9pR3hBSm1n?=
 =?utf-8?B?aXBjQjNOaENwSEJMZFQ0Zjd5Ym52OGtLWUR4NE95S0NsTXgySnZ1VTF4NzJ1?=
 =?utf-8?B?M3BiWWZidFNVTFdXNTR1Ujdjbk5OSitxalREK2psbEpLNjFwMmlNSndtTnFV?=
 =?utf-8?B?clpsOHRLdzlrRHorM2ltb3ZhZ1g0WWFPbkxwSUpRQzdxRDgrSER4NUFBVHVX?=
 =?utf-8?B?OWdYNmdMYTNQSXJiKy9pazJpSzR0dEk1SXJaWkVwV0VNbzN2N01RYUwvL3dz?=
 =?utf-8?B?Rm1nU2E0MUVXMEhNQVhYOHg3RGNyd3NXZDlsWjJQOHEvWjdwRmNCWHhsNVQv?=
 =?utf-8?B?TW1adEpybWdMS2ZNM3ViY0RJTFdubGM1a1pEMVljOXdwTkQwUkV0WHZqNWFz?=
 =?utf-8?B?Um0wVVpraHJuNFEzYmRqL1FCUmE2ZVpmSUg0K3pWY1hGV3EzSXhsMFNTa2t0?=
 =?utf-8?B?Zjgybjhrd3hham5mLzNtbnM4YlYxZ1VqNEFkQmFCNXBLdDVWT1BWWDhwdUNH?=
 =?utf-8?B?Qitlb1prR3c4YmhuZHZieHZiSlBCK0FyekN1ZmFwdmZveXpjM3V4SkhZdkc4?=
 =?utf-8?B?Tlo1dUhoS3Jueis1SDNrT2o5WEJiMHpDM3VCVU9ReFJzRThOTW5UKy9qNTVs?=
 =?utf-8?B?bWJYeER6MTRjb0lSQmNORjVwRmVYQ1RacmkrRlRlNjVJeGZBcHVWUnMrQVlz?=
 =?utf-8?B?d1VnY0NXY3Q2UlVyMkd6Rm45K3Irb2pYT3duK3REb2JSNDhBQnJ6ZitEWnVP?=
 =?utf-8?B?RnFkZW1HaHdIUXd0Um1pc3VLeWNTNXVTenFYc0NzcVZsVFZaSktBalJwZzZo?=
 =?utf-8?B?Z1VFREtlVnNvTm1MT25oS3V0NEtmSWNtSC9BeEc2K1VVKzlIT0l5TnRkSHBZ?=
 =?utf-8?B?cnV4ZE5PNklET0ZiOHZzOGlQT01zWStzNUJuZ2tPZGRzUGg2YUFzMzlhOVlu?=
 =?utf-8?B?YkpBc3M2aGNZUTJXTmNGcHRuMmJFclQ3c29BbnRjOTFQN2hpMi9rU0RzVk9I?=
 =?utf-8?B?SXp4a1VYV29MT2xTTjNnemczSGZZSWRvMlMzNzZSOXFNVEU1S3dNVk1xMC9t?=
 =?utf-8?B?V3dXVXFreHgzQy9kamQ4Q2NJbTVsSUdSWnh4QUZmdVB3aHFrZEg4dUk0L25o?=
 =?utf-8?B?cmdHMXAyK0M0dXUxd0x6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9MRGtMc0hzeHEyZlNHM1lDUzRaaE13bm02cnhOcmNjQ3NveTdqNzlwZXRL?=
 =?utf-8?B?amhuUmVjcy9GeW1wV2lQcEowaXF6RTBqSDlMYzdFREtEdWxqRGVkUXpOVm5q?=
 =?utf-8?B?bEl4Q2FpUGxtTldIZElaWUFDaXp4ZUE1dHVKZW1zNnZJVXFyOHp6YkpxbzQx?=
 =?utf-8?B?Ly9nUDFsSkcySjVLTjVpcW9xL2w4a1RTcjlTaUoyS29QSzZneXNCbkhPdU8x?=
 =?utf-8?B?YXZXOFlQWVp0bFl5UjQ0V1k0U3N0Rm1GcTQ5U1h2Yjg0c0d4a3lGNDJxWTcr?=
 =?utf-8?B?OS8vcVZTRU5pUHI2SnNPelZyRzJSTG15RVpqWU5ucXo1YzR2cjd2K05NQVZu?=
 =?utf-8?B?WnVFUVBhdWFkbmtHQXNaTUpJd3MrYmtXckMrbnpLL2V3VjdEMGFONWZXWTcv?=
 =?utf-8?B?Y0RYLzFOVUlxdHg0ZkdSem5hY1N1WVRJZnYyeTlyUWhtcTZDM1A3VDlLaEFG?=
 =?utf-8?B?M2VxTllad1JWd0pYZ3lCdUpZRXRIZlVxRFZ2UUpRdjNWQWdlYWRvOTBKUFJ6?=
 =?utf-8?B?OXNzRFBFeE9Gd3Axb2MyOG8wdDFKeE1HMlZ6TVNLOW5NemdsR1F3MnZJcDQ3?=
 =?utf-8?B?bm0zUnE4QzltS05BU2Q2K25ER3lQaGxVSDFLWEtHNjk0ZVg4YVVSYk90K1Q4?=
 =?utf-8?B?c2Fpek9wa0FBY3J5azE0QUJWd2dHMWtzNFlvWUZaR25XM2hma0pzZ0ZOeWli?=
 =?utf-8?B?aVgrRGx4YkJ3YVNrS2tXK0lNcFNIUjYxeUdseGQ1eVA0YlF6eXR4Y0JlY2F0?=
 =?utf-8?B?U2pLeGFFbnhrNmsvVy85SUpIWjlTU1FnUTlKWDBEUXlMQVFldW5lZHhJbkVV?=
 =?utf-8?B?dHRiN1VDT08rNldGUTRzTEZGOXlmUWdycHFZTStrcEt2a0hlQkhrUWJRU3U5?=
 =?utf-8?B?QU83WXBsT1dFS0tVRjJsOXpwOU9wZXBERUo4RTBkK1JQOHh0YS9wK1lzVFhZ?=
 =?utf-8?B?NjlDY3gzL0s5a0dXZVVud3Y5M2pYSk5Pa2lTUE9vT29EcC9CaUdjSWlIZXZR?=
 =?utf-8?B?bE1iQjFqSXJtT1YwV3p0QjNSRjNOcWs3NzNEZjV5aHd1dlpGdkhHL2Foc295?=
 =?utf-8?B?ME9UM25aUTczR1hSZDZWZGV1eXd1bU5zSnNDeW5icGQ2NGlEQkNaYkVBYUFK?=
 =?utf-8?B?cW1zRGpNOEN0NndYeHNZcy9tNlNMMHRHME1nUnh2NWFoSHZRWWZGTmdoTEU3?=
 =?utf-8?B?Y2F2MGg3U25kKzIzWXpvMC9tNlFyQWQ5WjcxR1lxWHNsOXVHZE80QnFYSWJp?=
 =?utf-8?B?ZTY2a1M4Y3NxcTNlWHV5bzA3NUIyTHFMaUJCR1NVbW5RODMxSVBuVzhkVW4z?=
 =?utf-8?B?Uk1sM1lCcDJ4anpBcHR5WFppUENQNy8wWlNBWFRGTWxrQUpVcHJ3SlcxTGhu?=
 =?utf-8?B?VStJbkYxTEpQRnllMFZ5ZHB2Ukw0QXZXc1Q3WThpQTd6L3A2M1BwUUtORnN2?=
 =?utf-8?B?UXdCcTIvWUxiWEJPR2FlMXFCcUlHTzZZK0JwWWlBdU1UVHdFa2JuOTNPK0pL?=
 =?utf-8?B?bGE3YlVSbzdhYko4K3JCaXBUY05uampvZ1EyN3k4WHJFZVNyYmxLSEdhUmdH?=
 =?utf-8?B?cXJkcmlGU0xjcnF5cml3bS81cko1MG5iRUl3bkNLZGs1VjNEOHJoRVM1UFVj?=
 =?utf-8?B?MXJWcnJhcWVESUtvanQzUHF5UDJLRzJIZk03TXFOYWlBRW10b0M4ZDRGcXJq?=
 =?utf-8?B?S0VYeEo1WmFoZjgvbjBQMUNDcFM4VklDWlFWSk9oa1hDcXBHSGwvd1ZLaTlv?=
 =?utf-8?B?WGxxUis1SXJhc2FUMlUrOEEzV0FIVXhJYUhrSDJ3dWZKdHJUTlNyMHZ2MURG?=
 =?utf-8?B?c0g5bUwxN2FUa2xleWtWZlpFVGx6RUNONTBMa2thQlRtb0Qwd3QvUFNyK0tn?=
 =?utf-8?B?UkNaK2FKWHpTTnRPOUpYUVV1N2ptM0ZxRTNma1Z3Mi94WWUzbFBld2JmUXVa?=
 =?utf-8?B?MUdvdGR0aTZQR0FMbHNLZU1zNnlRY0EzK3BuWHZFWE5SdkVNc0lGRGtPTXl4?=
 =?utf-8?B?VHZ0VzIxMG5qb3BZZmZmeEczSDNod0RnQlZtbVZacnBqbmdDSXVGTm0wbVZS?=
 =?utf-8?B?MlllZVJKVE43QzNUeWhzY2FDU1o5c3RDVzlSMEthS3NQSzBNVFJHc1RMekhR?=
 =?utf-8?B?SW93Rkc3MlRTdHQrYjJ1S3k3TnhxNUI5K3d2WVJMTWxKa043cUVsa1NFdVJx?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f337d3-a130-4d42-3f48-08dcdefde078
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:08:35.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICybvqClSwnlkWXGgPrl9WEskrxlyAMJML7mctkY5rXjDU253t30nR6i5Wnanv4rN4HPDFK6t+PJYQDB/kYexjUqgIwYO/NhUadIcS8ClOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
X-OriginatorOrg: intel.com

On 9/27/24 09:31, Dan Carpenter wrote:
> On Thu, Sep 26, 2024 at 03:41:38PM +0200, Przemek Kitszel wrote:
>> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
>> index d9e613803df1..6b568a8a7f9c 100644
>> --- a/include/linux/cleanup.h
>> +++ b/include/linux/cleanup.h
>> @@ -168,9 +168,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>>   
>>   #define __guard_ptr(_name) class_##_name##_lock_ptr
>>   
>> -#define scoped_guard(_name, args...)					\
>> -	for (CLASS(_name, scope)(args),					\
>> -	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
>> +#define scoped_guard(_name, args...)	\
>> +	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
>> +
>> +#define __scoped_guard_labeled(_label, _name, args...)	\
>> +	if (0)						\
>> +		_label: ;				\
>> +	else						\
>> +		for (CLASS(_name, scope)(args);		\
>> +		     __guard_ptr(_name)(&scope), 1;	\
>                                                 ^^^
>> +		     ({ goto _label; }))
>>   
> 
> Remove the ", 1".  The point of the __guard_ptr() condition is for try_locks
> but the ", 1" means they always succeed.  The only try lock I can find in

You are right that the __guard_ptr() is conditional for the benefit of
try_locks. But here we have unconditional lock. And removing ", 1" part
makes compiler complaining with the very same message:
error: control reaches end of non-void function [-Werror=return-type]

so ", 1" part is on purpose and must stay there to aid compiler.

> the current tree is tsc200x_esd_work().
> 
> regards,
> dan carpenter
> 
> 


