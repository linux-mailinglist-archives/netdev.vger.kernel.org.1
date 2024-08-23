Return-Path: <netdev+bounces-121342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235FF95CD14
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E21F21605
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121A185B65;
	Fri, 23 Aug 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajKizVxT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB55185B55
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417968; cv=fail; b=Zr8L8Y9r3pg9KzH8v6+DEWBlZwSO9V9diIDzdzzqRAK5D6S33gDeJGTcZmn3XKToLwM080Y4KJNJscgGqj+20rFvNeMKjJ0P+Yn0u5/mH9YpX8kDD65dsDMyDO4uCmu29C56BFGlBiJKry+CxlDVaVNIiZZInuMM0iD5EUjp4vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417968; c=relaxed/simple;
	bh=9RPnrLeeGnqxBfAC05hownqgh1SFkuJmFSea3mGsfeA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=twzpeqXcQXqfahwQL6C0likmxfwPTImwVOwyUS29dh3f3+weqaQymnHPWGkD+/X1UU4LCCxAWRLAT/WE7SirKG4H2Hz2gh+f5ac1V+CNLXiyZMcDGpk3VnO9eNpAxbwPrLPUnkRQH0kCErkg/fK7X2FBEcvTvL5f3gxQrUDn/Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajKizVxT; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724417967; x=1755953967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9RPnrLeeGnqxBfAC05hownqgh1SFkuJmFSea3mGsfeA=;
  b=ajKizVxT+w6ujiFkz/esICYhJMuv7RML7shBBy1nZr7XTkCbnbnzxFOF
   UGDSIL9/kxQKJoTpXZEVOH/a61RSSGXVxJNNOQATG8TMVV32iIBsoyjUg
   +61sKI2GvlP5frS0tEI3uF1T8jRqxDqVoFF1gC5COjlCWKFD/SDQCAH42
   17vQj746GtUndzEc7bs/VvPd8k7vXZC4uT11sXPWAVJXEKWVhV5MogF3u
   yAyHyihLrLHH0FLOeDeQNHAiZqktbSFKD5lO+MmXpldXZwrYaDE4eBQBL
   oLAyWHAs2VDXEA4WPQUItFufucBqtOMeA7N92sDHBN+7lcnAts+Gr4vI7
   A==;
X-CSE-ConnectionGUID: iBoIVvYaSmap8pe+66KwMA==
X-CSE-MsgGUID: vdze9LlhQAKCJXjHHdcrOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22850499"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="22850499"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:59:26 -0700
X-CSE-ConnectionGUID: mDYYtj2xRm+gTuNWBfQWQw==
X-CSE-MsgGUID: vX9aXuhyRoq1KSPh4M6lOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="62308228"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 05:59:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 05:59:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 05:59:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 05:59:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 05:59:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVLt3AY3ocMnhJmxyft4bEJUiZxfXsTWUxYv2R8UEs5NZ+pgbQjggQ8//TbleLIdS1Clpl/oXuQGKSt4yoW6Y585W9B099P2ao+LinB4NXG+aRpFz1JWvbtOnOh3cZxbdM3K7HQL61wdGbeEuVDPHWnU6X37DavfcjcXmGzCQNJdjf5mimr3hI6rjI1hz9ByjhDTxns41BFOxPz8xpPi4z2ytB1XhOU/qF/XHb6Yo2wG91ZHgsJxQEaW6XmkxxIa/UUizGcACyqT4Xl57a+YWuoaGp3zZCSkBPCKQ2G66mcaVc78Rb6650dwctzRuyg+ukSUP0afrQHeRRHfgzWiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn7uTeBswG4x9cO2X6HWbTtsxikubrdO+xoq8EZiUvw=;
 b=I8w++7ZjmS16oBV3uxk84fEYej+4yMrTF6tlKc56hKSxRKVrodGpaQ7bla7WDKCdbUK7DQaIZxWl1VInNlnM8eE+Pg631o1MtuW+CD+OwFnaI7K0S35ewDkrZoyJMRYqpu4a1e4wSSOwyjJs0Md8Z+lfqhcWgC6aKjcwoJmcMrVrLt9EExRdzUr/lolbhVBfMhaOwH9rJLRHS+y828u/vFGbenmp5NBOqpdkWnNJKOawKI/RrlbPGK2u4zC4PMyrGdsYh0avLs+78koVY4EXXNnIccNqgLN1lvlXvs87KnNBvGKob5aLOFn6EWmmpb4uVLzsLWdLAmLHVOthIPid3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 12:59:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 12:59:22 +0000
Message-ID: <b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
Date: Fri, 23 Aug 2024 14:59:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
 <20240819223442.48013-3-anthony.l.nguyen@intel.com>
 <20240820181757.02d83f15@kernel.org>
 <613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
 <20240822161718.22a1840e@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240822161718.22a1840e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e396d67-a3cb-44b5-09c2-08dcc37368c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnM1VmxNVy9yQkNNZnRQQ1RQSmZhOVhOOHdxbW8vdVhBRHFnOC9xUWJDK2Vw?=
 =?utf-8?B?Y29HbVRtbFFhMmp0dE5UZDJEK3RJRHBISmpHdExLRzRzbU9MeTdBdTNxSXB2?=
 =?utf-8?B?ZE1RRVliZUpldUY4UkNweDFGTUliQkhIUUxSYlNHUTcyNitldGp0OG8zZ2lX?=
 =?utf-8?B?YzFRNUczY2ZaMUdLY1JwRm5pUHZtTWc1WlE2RjY3NndLaDA1dHhjWXZVMFha?=
 =?utf-8?B?K2h0YzZzR25vbXc5MERwZ2s5OEJqYm5qSGVrVVdmWUlscnJRSk5uMUppRXdB?=
 =?utf-8?B?MURtQzE5OUZRSG83QUxRTm1icWtCL1B4ZnBKbzFwVUdzbzFocndrZy90amU5?=
 =?utf-8?B?TFd1djhmWXBPT29ORTRobjFGeHpBOFFOWWJKTzdmbmpWSHhIdG9NbkN6RmFm?=
 =?utf-8?B?WDJWRXRua1lxaGs3VUlJRkpEcVJkT3p5UlRlUTU2UUM2T2NHREhSU2FaQUNr?=
 =?utf-8?B?Ny81RlZYR2UybWJYcG4rcVpqVHZWSHNibW8vMFdhRjRMZXo5MXNSdVc2WHc5?=
 =?utf-8?B?clZzK1pXbUYrOEx6L05DbTZ2OG9MbUJyeUFIUjVOb1B2UURsdEl5NHI0K1gr?=
 =?utf-8?B?NE00N0FpUTUxRGdtSEpqS0lyRjkwYmVBcmxRaHVnaURvaXUxREgzQmJoQXYz?=
 =?utf-8?B?NERCblBEY3VSWWw2aXZhTHQxTXJITDlNWXVUUmc5Ry9RSXB6dGd2dlYwYkph?=
 =?utf-8?B?NTJWNmdzL0NqK3dIWmRXZVYvemJwbTVnSFpsTzg1RXhCeC9qS2Y5YjY0Y01O?=
 =?utf-8?B?S201VWkxVHQ5MkZhdnJlSDdVRFNaUzdra2krOTcwVisva3JZQ1NMVDRpQW80?=
 =?utf-8?B?emFvUW1yek5odzRLM0d0VkVRWmFEcXhUMEZYMXRYTjVrK3lKbjZKZk9ESkVG?=
 =?utf-8?B?ZWY5eWs5NmhwYmxpVkdOSGNhZEJoRm5jcXE1SmNNaHV1Y011Q1ByUTFMVFdx?=
 =?utf-8?B?TWkyM1lOTjZ1dlNBZGFhbStuWnJyTmRVOEJhRTBiRWdDZEo5SU53dDR5QURI?=
 =?utf-8?B?c2k3M2I5LzJ1bDErd1F2c2FQd2hNTDR4Tk9aS0grOGN4UkdUYzM1U2szTzdZ?=
 =?utf-8?B?Si96MVFQcVFwbmVsZDIva2VFcDdoOHAvQnd5ZHBSR01NU1lqT2FsaGtlLzJp?=
 =?utf-8?B?RjhUN1VMdE1aek1ISHR6ZXdFaDFMVEc5VXUxejV4RHczb1BtSXJuRU01RXRH?=
 =?utf-8?B?TGdhZlhkMFV2M2Vwd01Xb3hNQzZKTHRad1RrZDJtdllyV2ZXV2I2V3ZtTmUx?=
 =?utf-8?B?elk1TVNqWFRzVVhMQnVYUmg2ZlhMbFhMb3RMMjNvVk81eVRZb1QwVGVQUU9F?=
 =?utf-8?B?cEhiMmIrZ0VpKzMvZDZwdUVsTE9FY2RpOTNYK21CWjF6UkY3Tkswa3NreXVM?=
 =?utf-8?B?M1d2ZjArUUxmWXdhMVRXQU11bnFVbnJ5ZWhRSkdjaDJVR1NnNDRyeUlwaXM4?=
 =?utf-8?B?S1F0S0I1ZXZnWi9kMGdlOE5CWndJR0UwVzZnUDhZYVBQQ3oxOWU2UVhMQ0J4?=
 =?utf-8?B?Zkk3SVlwZ3NSSnBNRlVxNHR3ckxESm5FYmhhSFNpOE1pOHp5SzAzdDlUMjM1?=
 =?utf-8?B?MkxpU2Fab1ZZVnBiaEdMbzlDRzE4L200RkIwRWxpV3E5bm43bnVDWGNlOTM0?=
 =?utf-8?B?QlpJZVZhWDYyaDNxYVdDRENyMWYyaEVqSDJIeFhTYWpvd2FrTXkxMWgzRUla?=
 =?utf-8?B?cFBYaFBpSWpWR2FQVDFtYU81a2FkNm1UeHJ5cXJ0TVV0RTF0QTdQYW5XOFBP?=
 =?utf-8?B?V2ZPSzdDSzB2d3d3bmVYMjRiVnZxMnVaZWs3UW14UE5ZSmNwVTlyU3JWVjZD?=
 =?utf-8?B?SElWdUtGZm5PcWZ1a1gwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b042cTA3SzF6L1Q1b1h3bUIyN1lhSDBVSGVSejFPSU1zU3lUbVFtRnVoRUhi?=
 =?utf-8?B?eGJBczM0cURGSm8xOGpPRXFUZ1FYcmhBR2liTnlsYmlPQmFpT292d0ZJdGM0?=
 =?utf-8?B?NVRuam9oaFR1RXNJWURDRzN2TFI1SVArYUsrQVE2YWVGaVQxdmwzdCtoSEY3?=
 =?utf-8?B?emQwWVJpc3RCRXZtWGpEV2xrNmpUamJBRld3WkpUTGRweGNpRE1pWjFNb05P?=
 =?utf-8?B?c2Ywdm02cEVmVTRmTUlKZGRsaGFEM3ROTloxNDBZY2YyaE53OHhmK2kxU3hC?=
 =?utf-8?B?YXBaQVhTWWV4Y042Y3FQT1pwK1luVUIrU2l2RVdUMVowd2lFcUdsSlNkMEFV?=
 =?utf-8?B?VG5sZm1pNmYrZmQwbWhWbXlXQXY1ZEZCRjRtUjNaUXdMc01iNFZkUzlHbjVq?=
 =?utf-8?B?eUY0c1FrR0M0dDRyRnlnNGdrYTdBWjNsM3hYQUs3T2hmYzM5dUJ6Wm9HNHhH?=
 =?utf-8?B?N0VlRmp6dUlJL3FVK3Z3YWtYOUQ0aXZKQ0QxL3lhOFZ3V2FwK3o1bnU4Tjly?=
 =?utf-8?B?d21ESEdEb2Z5QkFtdjg2VEp2ejdnSkNnSGpCTHpiOCtrcnpDdHM0ZXpmTnI0?=
 =?utf-8?B?dzNBQU41cHJKSjlDL1VrZUllazNkZDYyMDlqYWU3b2JZTEFUQXEzNk1vWHZy?=
 =?utf-8?B?amlHSGo3WXhBSGtrZ0ZSdnl1aC9Ya2VCZDVpUWZjU2plT2xnUGlnNGQ2dVAy?=
 =?utf-8?B?dCtteXZmMlA0QUpvWmpIMGp4U0FCc1hDMHBxbFVodkhON1Fnb0tMR0NjcExr?=
 =?utf-8?B?bWhUOU5Hbnk0K1EwT0dzbHNCOC9JMEZFVmhTaHk4UjdLMVhleGdFSGxaRzNn?=
 =?utf-8?B?Qk9qalNMYnFqL29DMFRYWjBpZG8yYmFGQytiNk4zOHpwcVFDbVFuVFF5dW5H?=
 =?utf-8?B?b1laSkdaeVAxcnZreEtSZlRYdnFrM05FVkNsOTlIRHVRQ3lyR2xBemtDMjR5?=
 =?utf-8?B?RFFwbFhMc2xlTmhYYUowaWQ5cTFSeWNFNWpRUW0zUGFHU003b09jcHc4bGo5?=
 =?utf-8?B?dVZtdzRFQnVrTUdtVlczZWlxQTJQZUlzRElCNlJKdHE2SGJBbVloWEV5QUIy?=
 =?utf-8?B?WEVUSzFROXlQYTZmT3grRURNeFJweDA5cWVCS3N1NFR5UzhZeXZWZFJlRTlw?=
 =?utf-8?B?MFZubTIrQnliMEpIbmE0Wk5WRHFocXBaMGZuMHR3ZEdXcVg1NUlORnl2SWRT?=
 =?utf-8?B?K0dEcTRrdlgxWUtTMVErdUdWMUxUd25IendlVDQraUJyRDRsU1ZZVDlhdlJQ?=
 =?utf-8?B?MUZKeVptd09tSEtRU2pHdndaNHhBSEg4djc5TDRFRldMM2V4K3QvSDhmZWV4?=
 =?utf-8?B?QmtwSkwrL0hxbUMrWDIrZkNmMDhKVGhLbk1rYmFyRVJIN1BmajJxejg1NkRr?=
 =?utf-8?B?eVpVa01tYXcxQThDR0d1amRhQTFITDh6SDl1Zm1vdjJyTERSbmdoZFdZUjhS?=
 =?utf-8?B?VmJNRktheEEwVnNySFo5SjBIM0Q0RDhDYnBqSnB5b0NWeUk2Z3poS0xUOWVL?=
 =?utf-8?B?V0xzbGNVUXg4eEFxY2tDUWdIenVYbkVicndZUFMvTDU5OGRCYTNYRzFKU3hJ?=
 =?utf-8?B?dkFUMVBQbUZEdWNMQnFxYlhRRXZxd2FEWnpTZWhuaWVQbXdWVnNha2F5dFpi?=
 =?utf-8?B?bE1EWXZ4YnFaam9PS3VidEQrc0NrUkdva0hPL1NxVTFIQ3ExODhHeFBETmtJ?=
 =?utf-8?B?TjAva0lpOWlIYkc2T3VsVndaTC80QnlqdE5OWDduM1U2V2RrN09yeU5IcVJM?=
 =?utf-8?B?SEd6eWNNUGwxMVd6TUlubG9YeU0wT1B5UjQ3ZXBTUkIwcWdIUFE0bkhuS1JS?=
 =?utf-8?B?Q0w2SlhKbW5RejZBOEx0dEpaOTkveVhlNkErcU82QXQydldRZWYybzA3NUp4?=
 =?utf-8?B?dlBHZGdabE4zU045KzF6cWJBeVV4NjFVQ0pCejZ6Ry9MUzgwR2VRSTZmTzAw?=
 =?utf-8?B?NFE2d3JHeVF0bk1EYXFYajV3bVQ2dFBMeGxMR2ZsaU9OWkVEMG9jKzRRUkxD?=
 =?utf-8?B?MFVGUDY5a2s5VHAvcHI4SWRtVmd1RlArcitIb0ZvNkVXSlRaR2Z3SHdpUUN3?=
 =?utf-8?B?YVhCSUNvbDRyYXRpNm5LbTVYemJjTDJMd2dQNU5WWnpOSnRWamdWYmE1STI0?=
 =?utf-8?B?QXRSOGc5SnZmU3Z0K1R3aFpzT3ZIYnY3MHJsUHREQXZCbnUxbTdvRUhxTW9L?=
 =?utf-8?Q?hNVvqIXI9OsxZgZqpxtsOKU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e396d67-a3cb-44b5-09c2-08dcc37368c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:59:22.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wdwHGPo8v/gjRvdw40dGq8LtLAVExIq/jhErROOYxLE6L1hU0/La77BehWoc8lbuuL1Sx0opLszb78pf36xPP4KQHpJK9dLRlbuL0GAW3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 22 Aug 2024 16:17:18 -0700

> On Thu, 22 Aug 2024 17:13:57 +0200 Alexander Lobakin wrote:
>>> BTW for Intel? Or you want this to be part of the core?
>>> I thought Intel, but you should tell us if you have broader plans.  
>>
>> For now it's done as a lib inside Intel folder, BUT if any other vendor
>> would like to use this, that would be great and then we could move it
>> level up or some of these APIs can go into the core.
>> IOW depends on users.
>>
>> libie in contrary contains HW-specific code and will always be
>> Intel-specific.
> 
> Seems like an odd middle ground. If you believe it's generic finding
> another driver shouldn't be hard.

But it's up to the vendors right, I can't force them to use this code or
just switch their driver to use it :D

[...]

>> So you mean just open-code reads/writes per each field than to compress
>> it that way?
> 
> Yes. <rant> I don't understand why people try to be clever and
> complicate stats reading for minor LoC saving (almost everyone,
> including those working on fbnic). Just type the code in -- it 
> makes maintaining it, grepping and adding a new stat without
> remembering all the details soo much easier. </rant>

In some cases, not this one, iterating over an array means way less
object code than open-coded per-field assignment. Just try do that for
50 fields and you'll see.

> 
>> Sure, that would be no problem. Object code doesn't even
>> change (my first approach was per-field).
>>
>>>> +									      \
>>>> +static void								      \
>>>> +libeth_get_##pfx##_base_stats(const struct net_device *dev,		      \
>>>> +			      struct netdev_queue_stats_##gpfx *stats)	      \
>>>> +{									      \
>>>> +	const struct libeth_netdev_priv *priv = netdev_priv(dev);	      \
>>>> +	u64 *raw = (u64 *)stats;					      \
>>>> +									      \
>>>> +	memset(stats, 0, sizeof(*(stats)));				      \  
>>>
>>> Have you read the docs for any of the recent stats APIs?  
>>
>> You mean to leave 0xffs for unsupported fields?
> 
> Kinda of. But also I do mean to call out that you haven't read the doc
> for the interface over which you're building an abstraction 😵‍💫️

But I have...

> 
>>> Nack. Just implement the APIs in the driver, this does not seem like 
>>> a sane starting point _at all_. You're going to waste more time coming
>>> up with such abstraction than you'd save implementing it for 10 drivers.  
>>
>> I believe this nack is for generic Netlink stats, not the whole, right?
>> In general, I wasn't sure about whether it would be better to leave
>> Netlink stats per driver or write it in libeth, so I wanted to see
>> opinions of others. I'm fine with either way.
> 
> We (I?) keep pushing more and more stats into the generic definitions,
> mostly as I find clear need for them in Meta's monitoring system.
> My main concern is that if you hide the stats collecting in a library
> it will make ensuring the consistency of the definition much harder,
> and it will propagate the use of old APIs (dreaded ethtool -S) into new
> drivers.

But why should it propagate? People who want to use these generic stats
will read the code and see which fields are collected and exported, so
that they realize that, for example, packets, bytes and all that stuff
are already exported and and they need to export only driver-specific
ones...

Or do you mean the thing that this code exports stuff like packets/bytes
to ethtool -S apart from the NL stats as well? I'll be happy to remove
that for basic Rx/Tx queues (and leave only those which don't exist yet
in the NL stats) and when you introduce more fields to NL stats,
removing more from ethtool -S in this library will be easy.
But let's say what should we do with XDP Tx queues? They're invisible to
rtnl as they are past real_num_tx_queues.

> 
> If you have useful helpers that can be broadly applicable that's great.
> This library as it stands will need a lot of work and a lot of
> convincing to go in.

Be more precise and I'll rework the stuff you find bad/confusing/etc,
excluding the points we discuss above* as I already noted them. Just
saying "need a lot of work and a lot of convincing" doesn't help much.
You can take a driver as an example (fbnic?) and elaborate why you
wouldn't use this lib to implement the stats there.

* implementing NL stats in drivers, not here; not exporting NL stats to
  ethtool -S

A driver wants to export a field which is missing in the lib? It's a
couple lines to add it. Another driver doesn't support this field and
you want it to still be 0xff there? Already noted and I'm already
implementing a different model.

Thanks,
Olek

