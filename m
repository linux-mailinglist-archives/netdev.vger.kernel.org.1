Return-Path: <netdev+bounces-159503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EFEA15A69
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8BB18877D1
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 00:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948B8837;
	Sat, 18 Jan 2025 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xfb4YesZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61312F24;
	Sat, 18 Jan 2025 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737160913; cv=fail; b=q1v8XGVhoQlsjP5dKckX51NIlclR4Qje/3uFdXgSm4MaygaqKSJ6bgJ97296dOLE1xMeAozJ4AHRaZ0iJzONkgRAQROAt6U870Vgcp7/lboV3tROeAVerwLso31g13TYmZv3N72F7YrwmEybnytQG6DIlaiAuJpBILO4i6/+7HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737160913; c=relaxed/simple;
	bh=bA+EGKSS4a4Y9H2/3dzgpsXupeHqojMEikrP/SXUd0M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B+6zOHqRyL05deeq2PvN0w2OIW9ClHBZmAQ490RwxgLuEgIaSmPRv8HZg1sOmuzB9jhBB077NECA/t+ZBnz7tb7nJ9LrEIWuPZEDoGNCZ/kBbITkagSMdqszDCR/1rhRt9Jx3EJC5O+fESDBQlTTbeX2z0MSh/FRfmR7/9ZLGj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xfb4YesZ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737160911; x=1768696911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bA+EGKSS4a4Y9H2/3dzgpsXupeHqojMEikrP/SXUd0M=;
  b=Xfb4YesZ6VtgbFBMPs+AYcrPfCIRVlA+eMRSlzu8mbwIor4oaYuH8Xu0
   FWLrN863Se4+bmaQwjndR/nI9mmqUVUAa7M5J2CFoPue6kAyOEfIcnbIp
   VIvnwZOYGE+NGcybfKcLLE67jw++WaUMfemcMOimyWa6n7Ci5eDOJA78s
   WQStfC/AZ/E9z3FHV+DR3xaBVZWDO1LvJsRc2nprwiKubXjVfn1sQCWeB
   yUdtYQMSRsJs4w3UF9frDuqfEnzmTuOfk4xUQZwFLTzd2BNfED5tHkffJ
   tkecIL0pB2sOOe3bNWeKb/qsWw1OmcHgXdpj3Cu8r59yzfP/jzw3ZepwU
   g==;
X-CSE-ConnectionGUID: HVYIiPDERWSXz1IfJZ3ySg==
X-CSE-MsgGUID: WRZlFFPLSnqcTOuKdHE9ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="55016552"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="55016552"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 16:41:51 -0800
X-CSE-ConnectionGUID: Cf+f+EsOT8CkSLBYWfBYdw==
X-CSE-MsgGUID: LyOJlLmdRnq/183FEAVm4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="106127688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 16:41:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 16:41:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 16:41:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 16:41:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVzKptfg2GHcdV0+VWdIZWxkbsIRcoPnSycSaus2aeHQ3afWcpRuXV2M1Lq36Rj6mOJGA7o5AsSqbxbhzB8oFr8LcyHBtgjpLUwYh62gVEbAIerZ1k3TLh/VqB2oNtIuJHvTDE0sxgGi7ZyXpZ+ysjOfu3TlPGLHvlqkfsBnCmG9cNY34b/aa1aElGO32H8p8oFQ8uYw0VX4+ftts5xg+VBydXJ/inFKtsbUw2Adpzu4BYv72MryY+zu9wMN0bYTPaIIfZh7WFepF7kXr1wcmQUzvPsM8qV7kOO8z9WCVmpZ+XFdW0dbQs2wheQWbwZqZECI4czd6pc6wnvzACbWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EafXRumrCgP/mumVuHrW9nX9FB36yPkEe8MBUSuwdAM=;
 b=c3eCLI0oaxLD4H9DlZ5flZ58h7m8irFlxO+mUMQ1r9WwTYH0Ksnh0fiptDtO6iygNSP4xaPGAGO4JR6Wnm8LF9Zk9svIMRbjk8GvqaKk+KpT7X/RaPYFxjPBV/tQkmIB+CcO/qrvMKHQN1c8Wa1mQ7v6hfhIxKLq4dPN4k8ZRretyn/Rzlawb6HPpAwMV6qWqpJxRJhF8cVaCWbPmsnB8LRvUbfGqYXwhavqM4IIR9F3YR3C7hT4KF08bSpipwAs2gLi+lX90T5LzVYBG7o7sGsVygHGEFSOdRhS7MwDnZd9qU5CqfjrrGczI9o1LYZjEoTkVenCJXvDNU1QQPJnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8439.namprd11.prod.outlook.com (2603:10b6:303:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Sat, 18 Jan
 2025 00:40:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 00:40:51 +0000
Message-ID: <2d6de2f0-09a7-4d1a-9288-6a9786256b12@intel.com>
Date: Fri, 17 Jan 2025 16:40:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
To: Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Grygorii
 Strashko" <grygorii.strashko@ti.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: <srk@ti.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
References: <20250116-am65-cpsw-fix-tx-irq-free-v2-1-ada49409a45f@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250116-am65-cpsw-fix-tx-irq-free-v2-1-ada49409a45f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0208b0-6672-41b6-3aeb-08dd3758c26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2YxaWtQeGwydEtKeEpVMitxY1dxYzA4NU0zckZoZU93dDlZYzhoWHUzZ3N0?=
 =?utf-8?B?ZTJKcW1BUDJNa2RTWHJ2NXI2THBEalE3TUdqOUk2MDdIMkVxc3BWTFV1SWtu?=
 =?utf-8?B?Y3JwNnZZemFjR092TnpiTGNtOXJBd1VYSjhjbUhwSVNwV0hkT0FVWDVlUG9S?=
 =?utf-8?B?c0hTNklhbDhVaEtJdHVGVmhqaU1lZWhpSEJtL3Z4SW5TSzFIVEF2VlJXSWhy?=
 =?utf-8?B?WXdHWFVKaHpIYmlLd09Yb2lpV05XZ3ljL2pCek4zQmUwUlBYeldZYVhTTkxr?=
 =?utf-8?B?ZjIzOHkrT3lzR0NNREhjclBnQ21qYS8yblpxKy85UDJkeENnbi9Gem9ORVJl?=
 =?utf-8?B?Yi8zUVpUM05FaFd6U3JVei9KSzVORVAzQ0FxY1NFWWpLb01BVzhSRCtkYk1T?=
 =?utf-8?B?MlppQzlNZFhFWjJzbnBwUEUvbnhyaTV6WU9sa1VZQWh1UjBIanhYUDlucTU4?=
 =?utf-8?B?TXBMQXBncnVKbW50RHBPeG9nZmFuNW0yV0lnVkdBeEpubXIwU0dtREJRbG1H?=
 =?utf-8?B?bnZHMm04OXAxMUc3UGpxbFhPaW4yRjN6ZFRCZ0NSVlBQTzVtVVZ0d0VBbnF1?=
 =?utf-8?B?bnNNb2FyQnhIRG54RG9wNzJyaS9PNnNpUld0UGlBTmhjeHM1SkZZWGVsODRQ?=
 =?utf-8?B?aWJXTENGdmdnQlBvUDVmaEl6NXh0bmFjcHlhSlVVdVFablgzK1lvMUthSVpa?=
 =?utf-8?B?VWR6K0xORzVxaTlqTWNKNVpzWklvQTBocDNGYU5PQjhCQWs3Rmo2eHdNWFlx?=
 =?utf-8?B?eG5xK0RTWlFXUUtCRXBBRVcrWWdDWnJwYlBaN1FHTXdhSEI1cXRJZ3NnWDA3?=
 =?utf-8?B?a0VvK0RvamQ2bVVic0o2ak1GTWJDcEdYbSszQlFET0VyODg3UXhUc1VxcmQ4?=
 =?utf-8?B?eFU1alAyNllNOVQrMlZDOFFkVVY0ZnFCV21UNHhWOCs4eStwTHlzd05HRW1R?=
 =?utf-8?B?MXF5d0hjUzNRNXYyVy9UVXJXZ2JhbGtEaFpBZy93SmVlU1lPRldHempGRjht?=
 =?utf-8?B?YUtkRm44S1hYY2RpKzg1dG5aZGd2RmpsS0x1WnhrRjJOUThVNy9MaW81Y21u?=
 =?utf-8?B?Sk5yNE5HVXFSQ3MrT1FVTE9GSnFvS3hmN1FFQmp0WHpJTlhyVjRqU1JOVU82?=
 =?utf-8?B?WTcxVG1jeW5NbERaOHpzVVIrdnIxaXA0VGFnR0dlaStUTnBLZGt5NU9uN0px?=
 =?utf-8?B?ZkhHZkY1UVJDZjl0NmRkQUJGSi85RUNKa3VidXcydnVscnE5bENrazVTTnJL?=
 =?utf-8?B?L2R0dmVaUmJnN3k4VC9IaUtqQmdHQUk2aWlWTG9uQzJ2QytlUG5CNjJrQjVS?=
 =?utf-8?B?djZ2ZUpzTWhJY0lQZDk5ZWVyTFNDQmRyT0pqdFhkZnZMa2YzeTF1dFlGUi9X?=
 =?utf-8?B?RHlEcHJXNW5GZDBsQVhId3hqQzFIOEhuT3JQZmNaYW50cVhMNHBsVUNjUThH?=
 =?utf-8?B?NVBhdDdDOHlZKy93Z0o5SlpqOU9uaW43QmQ1UnU4bi93Q0dJMWNveVZvWFhk?=
 =?utf-8?B?aFFzUDhoWW1BYit3cVRyN085bm1DK3czWkFHcm9YLzFBUExVT2xjdWxuRm01?=
 =?utf-8?B?OXViN09XUlNpZlNDYytscjNuNVJFNzMvR3NlaGdIazgvQ1N1bUdRZzRIYnJz?=
 =?utf-8?B?bFc0ZU1OZDIyaFpnUGdMaUhJQlVUWG1KUE10YUtuS3RacHBzTkY5RFEvS09q?=
 =?utf-8?B?a01yRnkxT09MY2hhNzFPQWJzS1NCdUk0Q2pKVm1rcTk0NlNwN3ZUMGtTM2dz?=
 =?utf-8?B?UW90Y053aHE1WmhIVUNvdytoclFkMHIrZ3BiVTR2NEd1MU5CUE5XaDZ3c3lI?=
 =?utf-8?B?VHVqTHU4QkNaeTZHY0lKZXBKdHNFbmM5cGdKQzFwK1plMDVaTXVzT0tpS2Jn?=
 =?utf-8?Q?wuOAvvX1SN5Ce?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFhmbURyUVEyQzlPcDd0UFJsYjVCSlVSM2xCb1Y0SERZN25LeWJPZUtBUm5o?=
 =?utf-8?B?bEIraHNCMVV4VzF3NmRYdlY4RkRXMm0vRkNnbkhBV3hpOWpyRVFCb1podkww?=
 =?utf-8?B?VEw3M2NsZ2NuUXh5Y1pTU2hqOXV2bkZYUDJJbU54UWZ1cDFFMXBzTHJONFJP?=
 =?utf-8?B?RXhycVR6UEZZQmFPNTRnWjdmY1dwMllaWUQ1am9jUEhUQU11Q1laL2VReXFt?=
 =?utf-8?B?eE5IeFZtcWc1U3N3MmR4V1piT3pwK21SUXhFaGZnTzJiVm1nc2s3UzFEZ3VK?=
 =?utf-8?B?Sk10a2NWLzArdFhRVmtRMDBGR080eXFEdUd6Zk5mZzRvd2Z3T2g0ZStZdDZQ?=
 =?utf-8?B?TnVCdHFHcTlVQU9mZm1GRkwzbXlieUxmL1FvRlZIeVI4S2cxYXJXMTBrMzNm?=
 =?utf-8?B?SjBoKzdOVHY3K2I3Mk5vUXJ0emRnd0lza3JiNjhTc3FnWEpXZ2xub01KSXhG?=
 =?utf-8?B?RE8ra3ZIeGsvZXVKaEJ2NkpGeGgrUCtjRzZYZjZHU3JNbWRjLzJHZVVJWjAw?=
 =?utf-8?B?K05pdmV2ZzVLZ0FsemRRenBEOGUwSHJSTmEyTjA2TlM5WVgvTGwyeC8wRXha?=
 =?utf-8?B?NEFFYUcxdHBHektlOUtLTm5GN1h3eGNyL0lFQ3NaTi91dHIvRjV3M2lkU3cv?=
 =?utf-8?B?YU01dldJL24vODE4QWNHR003T3RVeTFOMXFqbnhNTnJWTEJJMWlhWHo3ZXBi?=
 =?utf-8?B?V1hGbkt3WDZVMkRLVk1XZHM0MFlSd2E3bmdlVU1vekxDNWFWTWJieDdLaHVz?=
 =?utf-8?B?VjhjTFhYLzZzM0pYL3ZlT2lRV01ZdmlHZ2htZnpzY1IzdDhmd045T2V4cUpT?=
 =?utf-8?B?aFJhUlVXdVduUlJSdUQyUTIxWWFEWE9nOUxTVFFzZ1B2ZE5HV0lEYXVTR1Vh?=
 =?utf-8?B?eVNCQlpxQkxvd0YrYzNjZGcwV2MyNXJ0dE42Ky9WSWI3RU8rRzVBdkZiZFMy?=
 =?utf-8?B?Z0gvNWdFWlRwaElkNkNzbHNGLytzNGJiOVRNYjVwMGlPazF2N1RpV2huRU5m?=
 =?utf-8?B?SWVMWUlOVkxwK0hIcVZwOHp1VXpDV0xMYVVGTU03OHNCaU9LZWdJQ1cweVVj?=
 =?utf-8?B?Qm12Rnl5TVd5eWhlbWZYVFEydHNxUWxVam9LS2NyRGtWUUdFeXIrbDBrbnQ1?=
 =?utf-8?B?WVhiSXdXd2pHTGZIQVBjejZrYUoyZWhkNmhveHQwYWpFdUcyc05OeUN0QWRq?=
 =?utf-8?B?OGc0dkpJN2M3Y3IvSlZoMHplWmlyc2ZxOW84NkZva0c0ZzhuaVlXeS8rZmYw?=
 =?utf-8?B?R3NZU2l1cTFiUndMb3krQXNTNlU0VVp4UWY4dUNhNzd4ZDM0UDQyeXN0QmFx?=
 =?utf-8?B?SlNyL0Q0QVFhQ01SSDJVZ3RRL0EzdU1WQXhTaXhXM3hGYWM3ZVFSc00vY0w4?=
 =?utf-8?B?N0YzeWtoN3RDQ3B2bmhyd2RGQUdRaCtwZkFQSWR4ME1NNTlBTkt3c1ozZmpk?=
 =?utf-8?B?U3JSV0ZFbTQzeFhISzBrUzdaZXZKUEYrS1RmbEdIL2JoekgzcXVOTmZBN3k3?=
 =?utf-8?B?SnVXYVpzMm9OQlppL0djaFlqaFhJVkF0bW1zekZadWM4alRLaFFJOHJPVVVG?=
 =?utf-8?B?RkJpdUVpUmdxTGw2Y1hBeFlUUEZDc3RONHVmRUNJckl5MEpMUzFlQVc0Znhw?=
 =?utf-8?B?RnZYYW92aE9FNWIzTzVWc1V5UVhWaHp5T2g3NUZyU2ZXWlljZHVQZmNFM3Rk?=
 =?utf-8?B?RWNRYm5rWVpvWWc0bFJmYk91TTgvNmpadHlZTFNobWxnaSsrd1QzYzBIUFBJ?=
 =?utf-8?B?OFdXcVI0SW5sMkVSd3VxNENLWXhiQjhGUVdrWnlTanQrN3VaSHVYWUdOSnp5?=
 =?utf-8?B?OFprdmhsWkE3RWNIL3Y1VEhZZzBjeW9FTWpKdDBTOWlFeGhoeW5PUkdacUx5?=
 =?utf-8?B?Vmh6cXJocXBCMTZ2VFJmd3VyTkJGdVRVQ2RWZU9jL0FSMG0yd296UFZxdDJ0?=
 =?utf-8?B?TkJyaUJJU3lFM1lMNzdXSGh6TGJXd2E1dUxyWXR3US94RDIrUXg1VHJKdyth?=
 =?utf-8?B?WUtNaHVmWXN6V2ZCZUtwSzRxdTYxZGQvQS92NXMwenRKc0hNZ3VkUHVKVW55?=
 =?utf-8?B?UUphMFVTVS9wVlk2S3pJd3g0dGlEZU1JTFdTRjVielhjT1QrWUE3WGxMZXVT?=
 =?utf-8?B?OU1DcEpWVHlQZjJOeG92STY4L2tGd0QweGZNeHpSSWZRWkFKTGoxbFNUYkZX?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0208b0-6672-41b6-3aeb-08dd3758c26e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 00:40:51.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pt9yI+3IPuUZiIsOESMcvX8hJf1bu8l7nnWMQ4VBQfRS/B0hl+xeHlMAGsKxvmPU14WGVT2hkiSmDGD/FGmfvHUlkE7yTkmq2eTfX8FJ84Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8439
X-OriginatorOrg: intel.com



On 1/16/2025 5:54 AM, Roger Quadros wrote:
> When getting the IRQ we use k3_udma_glue_tx_get_irq() which returns
> negative error value on error. So not NULL check is not sufficient
> to deteremine if IRQ is valid. Check that IRQ is greater then zero
> to ensure it is valid.
> 

Using the phrase "NULL check" is a bit odd since the value returned
isn't a pointer. It is correct that checking for 0 is not sufficient
since it could be a negative error value. Given that IRQ numbers are
typically considered like an opaque object, perhaps thinking in terms of
pointers and NULL is common place. Either way, its not worth re-rolling
for a minor phrasing change like this.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> There is no issue at probe time but at runtime user can invoke
> .set_channels which results in the following call chain.
> am65_cpsw_set_channels()
>  am65_cpsw_nuss_update_tx_rx_chns()
>   am65_cpsw_nuss_remove_tx_chns()
>   am65_cpsw_nuss_init_tx_chns()
> 
> At this point if am65_cpsw_nuss_init_tx_chns() fails due to
> k3_udma_glue_tx_get_irq() then tx_chn->irq will be set to a
> negative value.
> 
> Then, at subsequent .set_channels with higher channel count we
> will attempt to free an invalid IRQ in am65_cpsw_nuss_remove_tx_chns()
> leading to a kernel warning.
> 
> The issue is present in the original commit that introduced this driver,
> although there, am65_cpsw_nuss_update_tx_rx_chns() existed as
> am65_cpsw_nuss_update_tx_chns().
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Changes in v2:
> - Fixed typo in commit log k3_udma_glue_rx_get_irq->k3_udma_glue_tx_get_irq
> - Added more details to commit log
> - Added Reviewed-by tags
> - Link to v1: https://lore.kernel.org/r/20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 5465bf872734..e1de45fb18ae 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2248,7 +2248,7 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
>  	for (i = 0; i < common->tx_ch_num; i++) {
>  		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
>  
> -		if (tx_chn->irq)
> +		if (tx_chn->irq > 0)
>  			devm_free_irq(dev, tx_chn->irq, tx_chn);
>  
>  		netif_napi_del(&tx_chn->napi_tx);
> 
> ---
> base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
> change-id: 20250114-am65-cpsw-fix-tx-irq-free-846ac55ee6e1
> 
> Best regards,


