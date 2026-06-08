Return-Path: <netdev+bounces-296743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0DEsHm09J2qAtwIAu9opvQ
	(envelope-from <netdev+bounces-296743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:08:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8B565AE33
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:08:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OC8nDDaB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296743-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296743-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E53E6303ADD3
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEBF3B14A0;
	Mon,  8 Jun 2026 22:04:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B6397E9A
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:04:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956249; cv=fail; b=KyHi3qJbQfxI8L+jTELVR4+Sghz+Q/8gjVlcKRjklmjAWTNt+qf1x7XS2Bhe8YGou7AwmINI2NNBFp1ahi5bZzNtlIrcLDwPAB12/DcQX8khOS4Gl46+18qYucoUDcOFq0oRrq+hKuPnXq/fb1qAM7jqj8wt/PmnNBoUzpIHHaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956249; c=relaxed/simple;
	bh=zJYarqWlFQTtsSlAj/BqK+8dErPhIcRLGKnJcALSXeo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jeG3+1awJaHUeA8OV6nLtE8RV4v/ez0DTNLDBn6mphKAro0TxEhs73ViOSLONW1rOyjCYlKfky82mOvK1+3+q9Rxmu8cER1bKHpE1Us48YxvHX5kRS16YBKQNLUzqzV22oGasnHKer+LZh9WCTQzFqmgQGpPJBnI7aGhQ1arseY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OC8nDDaB; arc=fail smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780956248; x=1812492248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zJYarqWlFQTtsSlAj/BqK+8dErPhIcRLGKnJcALSXeo=;
  b=OC8nDDaBrFsyMqu5u890+4nupDEpVj2tCvpWd70BsGHaggNZOLcf+aBj
   w21tCTyVUaxH7xgrJ5ENBoiNUzHqB71pIllpoG9WvRP3J0F9x7HMRbAWy
   lJgM8NO0JJBjeLQk15XZr/tGLZwnp5mDxWhB0c0yUckbfabBvJbwmmK5W
   cqbRTuQeOMrN6ffsfBSPLwvbAmCkG25S7L8W8iovaVqMI1x/aKIHkhjQE
   lHOu0pBuQabt1Xh40rTKfUCGh47aYBNiaXzMDDIWVS3coIxLrtV7QwABe
   NO7hBJK5khhtvdTE2kj8wgmB4gWU/icumdrlOQYsrmv4zCW7ISDF7Oj+u
   w==;
X-CSE-ConnectionGUID: HevEOk3PR5K3K2rHKYiThQ==
X-CSE-MsgGUID: tbRAGXnYQmmQv5lJ+ZWmLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81559115"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81559115"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:04:07 -0700
X-CSE-ConnectionGUID: 1zv+iW59SIShTL2nIEcrsw==
X-CSE-MsgGUID: zVsi6QMtRBCR3se95c4UFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="241504949"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:04:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:04:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 15:04:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:04:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIHJvVL8jkq/114kE32Dyad4Dy2DKq5jT7YykkKIqVoH4TghRNPPd+tZSJv4kgO/HEt9/bb431BmZsIobfLCIoMgQkTeJfYK1MKhPhsv8DMcenNiWuUKIfgty1B7W21PxBGoxWGznLdsu/HgkYzQiLGyPYrLBjl00IRwwlhioBrFjqgEpq9Qs+9hm31YfNnxe5nR4TNsi391JI8D638S5x5gnf3bcOxMxLerb1pPsoftC+WEp9EyuEZfvGXCqks2wg3dZvk0tKVEt04U9E+evJLGDjdD62zaXNFs0yNvT4j/myfW1IFTh4u4fcyDjb8Jeod7nU4hdv+0OgebMg7hmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wVoAHMh1INrLp06WrB1pLxbkkP1satzSuAtl2bsnt4=;
 b=vchYa+DQnTW3RX79XXzLlFCRZMQ3xwPSkvq7lIf02jvpige1ofxYckKGY4tLpR/P2yUiwVek+Dm0UslSLDhi5KKVKQIssGirlPPbTcZX+jlB8IMNrIPbiCrPSKYOsUnxtTUn7woENIaE3tXXyuAyKBGsG9M/fSbCPEmO+B4caKswae3ZDYjNqQXxZVBMfjdQLfIyiF/krHdk6EdIqxKefv/eUGRAyqZDkyJ6YwBc+nJX57qCD5tXWhI7Nwp7CMxXeb4qxeYJb3fIcOhiR31rETfN4QMSfqZB2Piau395TtfiIWAY1jA2BRcwnVnU+3er6iPvoNKW4ZiHYUwCVMeK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 22:04:02 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 22:04:02 +0000
Message-ID: <d0efe754-785a-45be-8394-bcb027ae1a2d@intel.com>
Date: Mon, 8 Jun 2026 15:04:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
To: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev
	<sdf.kernel@gmail.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<michael.chan@broadcom.com>, <hkallweit1@gmail.com>,
	<maxime.chevallier@bootlin.com>, <joshwash@google.com>, <tariqt@nvidia.com>,
	<alexanderduyck@fb.com>, <willemb@google.com>, <kory.maincent@bootlin.com>,
	<jakub@cloudflare.com>, <nb@tipi-net.de>
References: <20260605002912.3456868-1-kuba@kernel.org>
 <aiNR_GaST-NnkZie@devvm7509.cco0.facebook.com>
 <20260605170952.52c00c2e@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260605170952.52c00c2e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f56b08-f47a-4a74-9a86-08dec5a9d9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vV75eYv03c9AunaUnUltfcRyfNSWy3c8HFsuuatYOs82YWEF0u+jpXzu806xkwzkXLLNP7sfzjnpsHUPpRwCavRKF87KpgZjKBJRSQbCPTyHQDh30eJHg4q05eH0TwSWae/asCZDM45RYCQ2Ub+Jja3RSlOmbAufk063eggsdpYVxk7l27gbYqSXpAZAJdiARyrkUj1WjObYYpSY7I2Fe3yEWPYa43YI5l36rq0QIfW2cDmylyNCDQotxL8EQhMNMiisdPjvMAnlCGFl0nkluut8AR7J8NaEMqsKEKjintYbsvvVfUk43w+5Dr2++hgIXLdcJkc5/ItA9ZJKORJ/4z29JTsrly3qmUei11t9HLuYOQvVXK0yrfjuFf7+/38hHXEBS5MMT6ySzB19oK/4OMmrM7pckyFuhfqykLMaa3ReJVSd+0E0lEf1DcW778BTvG/ibxKxr1WJHxI6XyweitW8pv8dHZED/hoXn+DZwxh8AKpt+gV+IZkZBWGOVjNICHegyp7lG+PBT2XfXrw2m6DpNTnCXH7DyyelXUBZeA0D50vslhRJrUtx3TNuh7wVSx0wQC+ycCpTzbW5vupJboH2QBSHqQWu+QliJ+iewhFFQjUcLcBjXX47uKhGBhiu1bbvpLeyR3YfDlzmGMjKFx3twrOh6R6K0ebbGvUJkglzvJIWKUHdRP7zc4ltiwNw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1UK2NrMFBqU2FFSDFpOTVnRHVaWGU0bFBnVHMyYjkwUDh6cko1Yk5lSVI1?=
 =?utf-8?B?eHNiOHcwbDJPRk44eVFuanRrOHFYTFZzQVZTeEFCeTFOb2VQdkhFenJlRFZU?=
 =?utf-8?B?cWY1UXd2QlUwKzVvcU1rR3haUVE4SEVteW55TXZEck10RmxNL05FdExMQ3hx?=
 =?utf-8?B?cDFMZ2NpeE5FUldCcXpNS2hnajZXNGRNVE41U0lWcVYxZ2NXdUlZQnJpdkZk?=
 =?utf-8?B?MkhsUDQ2ZSt6eStnb2MxTmNvc0hlSnk1SXE1SFJ2R0dLTG5UMUlMMytYVE1G?=
 =?utf-8?B?T0ZaaXJxazhUWW9FUXFXV0J5dVY4UWpTVWo5WS9ZWVBvMVZjUnkxK3hsYmdC?=
 =?utf-8?B?Y1d5L1dLaUxRZ1gybGdTNm15RmVZc1Q2MDFCMGV4dDNqNjJYUXNLd0NWclNC?=
 =?utf-8?B?Sk9aZm1zbS9tUys4RzhPOWN2aDNHT3BTQTFvdm0xRlloWTl4RE00S2lQdVg2?=
 =?utf-8?B?VXJzZENqQU5kS0ErRTNPdHdnblZPKzJQYWtsV005MFNnaW1mUy9SK0JHMk1j?=
 =?utf-8?B?YVhnbGtaZWM2dm5hTnRyZUQ1bzBSVHo5WjM1cTIwazhPME15aHNEWE43SGJK?=
 =?utf-8?B?SHo1V1FEb0N5Y1MvL21lMmVhQnhLS2NUaVRNMmcxMWdXUDJmQkR1cVlHUUJt?=
 =?utf-8?B?WXgvcDdDQS90TVZhVWFMdlJyeGxGcDViTnVyMWtUaGo2RnphQzdLT0VocUwy?=
 =?utf-8?B?YitqQnFDaTk4RlV1MjNCMDVRdUwvYmMrdzJpTncyZHZvZ2c5K1Baa0tqd3lT?=
 =?utf-8?B?eHBvOUNISkZHZzFRd2hBWEIvaC9DdnBBczhncHlvWTNOcndKVjQvQU4wTldv?=
 =?utf-8?B?azNCUUFlMU1LdGkybmdvSFZObDdXUkNqRG90enpYSEk2S21OMzVVRDJnQ1hD?=
 =?utf-8?B?STRuTlN6SUFtTFUrem1ScHc1Q2h0NDYvMUxPc1VTVmlyeWdITmg2QTRhVkZy?=
 =?utf-8?B?L0I5RTQwcUxSckg3RWxRaUdqeTNXQ2JQdUlOMHBiZnpWYklGTXJ1MmZnVmpI?=
 =?utf-8?B?SkZBcWpSNEVhaE8zU1ZDamVzS3J6YXVBS0VGWG5ieTNyL05NK2FqZlJLbVZz?=
 =?utf-8?B?NEQ1ZmIrSmR0anR3dkpIQXU4NUNDa3VkYVR6eGZBUnhkT1l4NHJoV1ZmQ1RR?=
 =?utf-8?B?bHduelZLc3NHTysvMEpzdUNlWHhIMjgvcTN4YktTMjEzNWZOL3V2TlF0eXl2?=
 =?utf-8?B?aWxZbmFBYjlMbWJXY01KYk5XendMTG9ReGdac2drYWx0UTU4NExvMC93ckg1?=
 =?utf-8?B?WTRPOWxwQzFwcXphT202U0JUR0lrRjBvKy9pMjg4V0RMNUxNeUFTY1QxWUZQ?=
 =?utf-8?B?V2J6aDVjRUpYNFBPYXkzcG41a0JJUUVpYTc4bDZmYUxMamJVVTJtdTFTRHNn?=
 =?utf-8?B?dkNpWlpyYnBTR0NVSXY5NHRoUllwZWwyMTArOEZNRUxVTTIzNldKQjk3M2t1?=
 =?utf-8?B?K083djlVRkZXTzJIcnVjUUJpNkM1b21oWG0yclJIR1NVNWdDeE54V0JUQlg3?=
 =?utf-8?B?N2VVaytrbWM2LzBzNUhlM0N5RzdTTUpQK0trSFlTZFdCdEdqS0xpcUhXMW94?=
 =?utf-8?B?YmtKVXhRSWhLczExbWl6YkRFQWhQbVBZYi9yamUyVW8wZXUrRVptQUV0WXN4?=
 =?utf-8?B?bThXeHVoR210MUlOZWtaUEFTMUMvM2liWGphTFZNUlhOWmU5aGV2R0M5dktN?=
 =?utf-8?B?a2l6cExzemd6WXRFd0F0TGthcFNOUzczRW5vWnJncGNBelRTTzBMWjVraDhn?=
 =?utf-8?B?b3dqeWRockxMUVAvWmRyeGdSZE93U0NNcjhlSEN1akpIK3NPcFlCLy9ndlFB?=
 =?utf-8?B?ZHBvRU9CeG5ENm1UNDQwQWtkUVNFYTBsL0RxRXJESzZTanJPMVo4c3hSZnE0?=
 =?utf-8?B?L3NmT3VrQ21FUURXR1c5b3hzYVFTKzhnZUl0b3B3elFXY2xzUnpaWWppMEFO?=
 =?utf-8?B?QzVzWTRBbTF4NjY3QTBwa1lHSUNyb2xrYkFnRXZCbzc0TUFtRjgrRVIxODBM?=
 =?utf-8?B?SnY0N1NZZkhpUnJqTUhxMkNPck9YRlR3azMzUW01cDN4UXlwQ0NXVTRqd2R6?=
 =?utf-8?B?RC9CNmlzR3c2U015NGcvSEZBR1lIQWtjaStKVHZmTXVsRCtQNWw3dDJQaVNH?=
 =?utf-8?B?bXVQYU0vTVVoS1UwUVhRemZRWXp6MjdJYjZiSGtNV1BkNmZnT3VEQXl2QVNz?=
 =?utf-8?B?MUtqaTl6ZU5CSm9sRG1DL2FuZmo2dXJYSnhEc040aUc5ek03a1NQZ0p6eVF0?=
 =?utf-8?B?ODhJek9qMStCKzd4cnBqMlBUT3FieDZpb0FjTHorK0JCcFZ6c2FNN0N2SXpV?=
 =?utf-8?B?SmduT0RRNGM2NzNhOXlSU2dYS0FmZkU3TTkvVG1mZ3RieXFSMDNDQT09?=
X-Exchange-RoutingPolicyChecked: n2wKLFGMkCRoXxCMbECR2nkv9e31G30lMfWBG8UAP1P8P1Mr5U6JglHYXoFhsKDbIoiX4DlrVSTKGISnOk1CWdyxmW55qV8jFU2+nDqMQsGDdqAhG39rne2Mmt1OgH/1NuNVvImJGHO0dtHmodmMoCsJrUkFb3SyWvmNsugbQ9TB5LBXxb3kRAfvj5xjQaOFJ6kZ0ssgxfOIoLe/9wZCdbpEd6sFedmHiTRf7LY0jvkiglIMafPaKx2BUMFjaQjGQQ0VU/RRyKyYutrDTG2ByVfRsgrkXHMxPPSsO0fuHXYGUeGL7EiKhmjUBr+7E1MWss5AJ5PTlnN0P5EYtmpTqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f56b08-f47a-4a74-9a86-08dec5a9d9af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:04:02.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J3YOvbk6ljdinIeZ9lbIBt51ODZnscCjj2sLyaxXZZlDDJYA9i9H/GpNR+UpB5LLYzRxdz5ErBH8AW44B6uk8B52dpZoUbnA2fdebmrndQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296743-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:sdf.kernel@gmail.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:kory.maincent@bootlin.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:sdfkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,cloudflare.com,tipi-net.de];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF8B565AE33

On 6/5/2026 5:09 PM, Jakub Kicinski wrote:
> On Fri, 5 Jun 2026 15:48:48 -0700 Stanislav Fomichev wrote:
>> netdev_ops_lock_dereference name trips me a bit (_compat suffix would've been
>> more obvious), but I do agree with the reasoning about needing 'a' lock..
> 
> Guess I hate long lines more than I hate inconsistencies.
> 
> This:
> 
> 	something = netdev_lock_ops_compat_dereference(&dev->something, dev);
> 
> is uncomfortably close to 80 columns for me.
> 
> I think the existing naming is as good as we'll get..
> If y'all disagree I can respin. I'll be sad but I'll respin :)

I'm still working my way through the sseries, but I agree adding compat
here might avoid some confusion, but its extremely long and it forces
"something" to be pretty short. I think its already long and descriptive
enough.

