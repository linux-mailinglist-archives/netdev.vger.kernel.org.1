Return-Path: <netdev+bounces-273889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMQCI5OqzGnNVAYAu9opvQ
	(envelope-from <netdev+bounces-273889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:18:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC144374D76
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86EBD3011C67
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C81925BC;
	Wed,  1 Apr 2026 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMNJCAZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B81CA4E;
	Wed,  1 Apr 2026 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020688; cv=fail; b=eP/4Ub7UFrFRzzjyy8tKEjnyzW8Lq4Wrewc05pKpdJuobhcyUTXlOWp/MMkxE03eiU/RF8dIsqE7xPH72mQxk3Xb9xpY1sZiEZzuhVAqgPsPBl+Q6GOr2kBrKp3cCzPzpg46iXYBIPXetHp6slFS7pDuLwLScGAmDD/6JFeEQGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020688; c=relaxed/simple;
	bh=l/GoL7iHx/6E0EhKNVOwq2yB4JRwlMSn8dgyUQ6H+xs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=n5ajJI2PowWm+Jt3IP3NHb9Fd4fDL3wEauxdIWDY+I6D7yEFcIJSLhuKpCRoaRl/czxLx5ohmhbdgx6lM5lMVdoSkVtERmdyVyQ0otpa7k9OPV88dZVkAmXxJuumSpD0XeUHJx0R9S9bghgsuHoTKHFml5ps8Bqqs5DtGwuPpe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMNJCAZ6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775020685; x=1806556685;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=l/GoL7iHx/6E0EhKNVOwq2yB4JRwlMSn8dgyUQ6H+xs=;
  b=jMNJCAZ6vIv+HfXyLYHQndZ7I1XrLTdkgIqSC+k/lR3ZW9bCXGOWptfO
   /Cm8zViGQS3toLX8qACRfWG3X/hRKrBRxi9ZYz2Vs9lPN4xRiG5tD2br2
   wBibKuhQ+4YlANpERxcTJ399fe2Mo8QSK943HOM9EW/ayViSpiLlxaqxa
   AH7ZR+yctAUUr56uhmTPgQngnIMULZD/x5yOgUpexzTuMFyZK6GLGnu9x
   3Ol9Bp32QvAYY1eCY2RtOUVxJ7sTFM8hjo/BjVyJ8qYyESoC6cN3bvsBB
   Y7/r1pv28BWX43UiiM4POKq25hC8ChE0tjTbwlM6jY13McfNluCv9m0lY
   A==;
X-CSE-ConnectionGUID: PMs5WyZUQXCPmLDD5Zq50Q==
X-CSE-MsgGUID: dqE+1CftRGCirR9pBjRYUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76108534"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76108534"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:18:05 -0700
X-CSE-ConnectionGUID: qCw6V5XfQA6IvGkF5qhqWA==
X-CSE-MsgGUID: ttLpmAt4SYyEOlXe0ZAzDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249612765"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:18:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:18:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 22:18:04 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8Wwejt01op1B+FcpdkHxkx/7f1mSVc2zG3Xm+06RBJYueIzOTWpATXOvwGDDx0oqSlGTFoyZDGT6m1gaIvXdkqu6uXA2nxFkHD4oxpjl3euizqgFqnn5EW4ACjG6w+5K70NFhFYLlqUJQkRHFTxELGPZIHuqjCgI6ORzMIJftS6hEKHZ6paqLHpJIDAZ/Zg72+jetX80ERSGoofG/CRR1bV1mOqiqd6d8RSEqIEszbxFMqBJsqjQfFwi4/tp+rH8YG0M1P93/vdZ61pLQlOKgoIfRfTMx9L+xKEzNTfMyALfF5/WG/9IbYvv4SNoaElkR/CcGljDTyPbHWfnKnE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE5VA97PtUscBznvKWKCxbIpqgvzDHB+jIqJWbjddiU=;
 b=VImGroATh87pjHP3KSIOvZfN0/JGkw+TlU8ljr5yybLP7c54JvqTO+xxfdAKZgockdcAKOLnTVckklAtmN4YvltBYgMthcPOMP7hgWJTkRM+EhuWhjaslGB9bfrj742NbSglJQYpP4qsKG0+7x8vUovwOwNdk4kP/kzha/VeDInzd+c9yx19vMNY/DYHTHL17RQREym/aFgz95tDCudvorlVqXPp4hs6wg+S7y5dk57LiAu6tANYkncnIYFjGAgyjykApiFWDIcY5BcSWCYsPt4967bqCgqNnw6xt62a92/+HLaUmcXvmj4olKEv6NW5M4tS0DhRN8oSjP61TgFUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 05:17:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 05:17:59 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2026 22:17:56 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <69ccaa8448da1_1b0cc61009c@dwillia2-mobl4.notmuch>
In-Reply-To: <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v25 05/11] sfc: create type2 cxl memdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF5217261E0:EE_
X-MS-Office365-Filtering-Correlation-Id: c2117c18-eda9-4624-0f56-08de8fae0a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xt6UVT58TBOJIqBMwt5gZX9jCz20bs+8rkb4BgF3pEJnWGCRhmXZ7nw7yOAaVXC/q2goVY7W+8zKeV9iejNsEAENVaPdKQ/2+63dDRe1MlK63na/6kif5D0WRHmOGMz+8Gdlk8KkSHSguUmrrU6YDPP0+IeNFo2LycyA9fRIe/3puWFhSml96dSyUlMr+eijF+HowGtZ+Zapq6t+bFIi2ezAOO0KzxQcmYEK6KI473kIPDCIJ3IYn/oEnY5tzQnunDqjaB4aoO5vqP7uXzU48vkilsa3jAGHAJpDIHskIC+2Z+Nk8KmM52ixq1h3BrsNzGreal3nww1vehW6ZmppGYuoH4KK86t+X6XXthzqb4yEukW0fJKzpeipY+lvqeUz9g7b9ayhOj+MfxQIwv8CIk7Qf/gTavUGQymmmC5FfYfD2z6BTc1Z9XbqXX3rTFht0nOPoF+IivPuho0QEvlO75aURJZNfjfjtoJA4JX8LBJeYxSbGSQ73s6UDK0ialnH7I/RzZbxWdgJKbzBf78O/rukXZuz8k1eWGIYXupZDbJ5CL+c+ER3dGoi6+K07ZFyF2ukgAhYmZeojR5LlKVs2bcsvRY9zYOJ8NDtRwHYuJA/rwKN+uDhe8ieZvuniseIc1Uh8nI3HEIl522RbyLwPx9QykRidckN4meejryA3ZKLjMheEA290xAGEsgzGVdOFJK9O4ODDOiULWj9CI/qMGtmUk8KX034We9tASQslfoZU4rkmc99lCTEZxnxICxVI98QlygCJ3Y+lXksx6RKcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZLZWVOR2c2U3ZYRExSeTRPZkdvU2ZNSitLMFo1QVRGa0cyWVdoV1pSdk4w?=
 =?utf-8?B?cngzcUVDMzArMmdxN3laeWNHMVFpS0pCTzF1SzY3dTJHOVF2RUJNWHkzQTlN?=
 =?utf-8?B?VWJIL0I3WjEwQXpPNm43elV6SWc1THE2RnlmNWcvUSs0Zkp5V0pwcmRDaTRZ?=
 =?utf-8?B?TmZtSHBRKy9DZjRrYjdOeTc3djA3U2Z2Z0VjSmcrUG1FSW9rei9QNmRWUnY1?=
 =?utf-8?B?WWN0VzQ3VjlLYlAwbzh2YTlrSFh0REFwU0ZyZmJVZ1VlRVRQZ1BpOXExUHBv?=
 =?utf-8?B?TFlxaUJLSUxQUEpUN3J1OXNJOEcxVFhWbUordExFSXg2MUlaUUlaWGZyVTZp?=
 =?utf-8?B?K2hmZmJuWWhFMGNCYTNtTnhRL2UvcGFBVGZtOGZ4L0s0R01aU0FYOE54cGRh?=
 =?utf-8?B?WlR4WVRnQjN4T2JvUDBRMUNsVXdCbnBZRUNDekRSQTVsaERqZlIyWjA0b2Vz?=
 =?utf-8?B?SnVsYWRVVU4vMXdjM2szVWlnRmdYbitNeXVWTWliMHFicllZWVhoRm5OYTRz?=
 =?utf-8?B?aTluVUlxVmNkenAyalM2L21QN2dmMUxXaVhkSXV4OThZTE43WnlEVWFHaHgz?=
 =?utf-8?B?VDJRN250T2tPU2VCZHNBbHphTG0rSzBRRlV3TERqSjZCeDJxWkZmckgyNVNQ?=
 =?utf-8?B?c1EvRW5QdlEyTFExbjllT3JuUHBvT0lxUlNscUxpa3Q2a0VTTUFFR1VWdUw4?=
 =?utf-8?B?a3RtbWQ3ZWt6R2hXaXNRVDd6MVBFM050Vkk1UjcraS9UbThpV2xwQy9nMzVv?=
 =?utf-8?B?cUNBQ2pWaW9rNDdIODJaVTdUVXlYbVBoek1BNmxhMS92cTI4dmIrQ1V2OUdC?=
 =?utf-8?B?UVZNeGE0MnltRE41UFEyZzBRY3oxcGNFWkdXUWhob25pWmZaSU43SFRVZ1Fo?=
 =?utf-8?B?cEVvNmp1NEpmb1JUcUxPV25jdUdSN1h0Y1c0NUs0TWZwR1NVckJuQlQybHB4?=
 =?utf-8?B?amliaUwwTzl0Y1hCVFkydUtIdlBvZTE2ZXVGQnhrVWU4ejV4OGoyVTlMNnpj?=
 =?utf-8?B?NS9qYWxZd1YyTGV5WkNrWW9VcEV1Z09OQVhhWGNUUGN3RTQ0S2lCVjJXYUtJ?=
 =?utf-8?B?RWp0SEg1OUZIY0drVWszMWdMTGZkQ1dWZ0J3dXN0TXc4WTU2YjY5SXczYzdq?=
 =?utf-8?B?Qlh0V21qL1VVTVNRMUZGRGRKelBqWFhJazVBTTU3T254US8rdWE5U254a2FK?=
 =?utf-8?B?RGV5UG50ZHk0RzdVQlRPUG5mNWd1NnZuVVFVUXpiSzhiVys1eXRHYnhoVm53?=
 =?utf-8?B?R3ZqdmlmeDNjS0x4VXZXVHpwS0RkekU1YzdUUUNLekJpUFc5Z3FNV1lHLzVq?=
 =?utf-8?B?WFJldjhvN3hoMTdkK25KTDcxN0JPNUVidlUxV2VPcXh4VHlRV3Q0djNUY3Bt?=
 =?utf-8?B?K3ZTMDNiaVVtblJBV0liemFTa0wwdWZoZkpGam54V0lmZkUrSEcyanVCenlo?=
 =?utf-8?B?c3pPT0RTYUFxQ1Q5VU5hb05UQ0trbnRadWRUZktJTWpQdml2cGxTK0w2V2JG?=
 =?utf-8?B?OEFEZTgvOERNWjRVMGNCbC80YjZjUGlDY2p0UE5ZT3krcGVvZmVTL3MwaHZP?=
 =?utf-8?B?VmovRXBxVVYwYlpFVmgyS3Z4VmlqYnptWjRpZUhqaWRIcnJSOXl3Wm9rUFEw?=
 =?utf-8?B?T3A2MzJ4ZFllTlV5aU10Wi9lSkh1VFlLMjVXOUtVdWw2aTBDbk85cWtKcWVs?=
 =?utf-8?B?OHltY1AwbGZGblJOVlF2Y015SVV5N0VTdFB4dGc3dXlKUFNyWUp5KzBrTk9W?=
 =?utf-8?B?KzhPcTlQZlBwd0NhQUpBOG5QZE13eEc4ZEhncmJpdThOYnhEM20xQ2RMeXk2?=
 =?utf-8?B?Wm9WQUtHZzVRL0tqWUZ1NXJRTnl4Y0FSVThYSVU3VjVlemJxbWI0Q2ZNenlT?=
 =?utf-8?B?dXo0eW9EVGhra0Naay9aUUFoWWRiUXpMa0p1OGl0RTRvZUEyMDZXVVkyUTUv?=
 =?utf-8?B?VHFtSHlrbHFmUDhPYjFqd1k0RTFmeGdSb3JDNkNRQ2M2bERJQmxBTTdmYlB5?=
 =?utf-8?B?QkJYODNCRkpqZEdlSUE0VDVtMUh1RmdjZ3Vpa015UXRwRjYzZVhrTWhZdVY0?=
 =?utf-8?B?bXo1UmgvZ3FZazJGQ3N0NGlIb3dEQmpwQXpKY2tvTFBhQWI0VmU5WHA3ZUhr?=
 =?utf-8?B?RnhCaVUxeTE4dkZJUllXaXlqdTlwMUV2VnYvbzFkNURwcGNtaENBUTVSZFJa?=
 =?utf-8?B?VUEyMDE5UnlVT2x5cHNBZWdMQzJlb0F2ZDFiT2VTOTZPV01tOXRjNjBCenlT?=
 =?utf-8?B?aGhHeVdJd3c0WWNqaEs4bUIyc25HbTcwZURNNC9XSGFQMUcwVlc5ZkViTWpE?=
 =?utf-8?B?Zm90SHBZK0VYTXFYM0VaV1lKREx1VlJHV3Zsc1BxV2NpWGEwcWtiU2lsZFBv?=
 =?utf-8?Q?SAQ/Rer/CSCPP7mo=3D?=
X-Exchange-RoutingPolicyChecked: bkOPK2m/wuvSmpqrv8oIqliAqEOnU1mB1OQgx1/joQFt3PclzmBRQImhQlYRyrw1AmfI2ba1NOV0xMHoe8JLRYzlmT04aJeWtNjS5rdG4aI+MCodczduoyjV7O3Nfo66ezyKIkZDfgnhoelWVZlhbo+HronoxbdqOgS6/mawhrrcFjCOQ/1dbqhD1nTvzHiQkXuJUU2Xpvp5Bb8DgZStmlZnW8/KJe3nStND2vDEwmFtMXNYsp3e6CcJQK+K0c/ffHnMx23WgrogxgJ012IRO/xIiUBwy/a/H/4JlgTtpIH2NUKGnHHXTKIkyUXLUsBNUn6MfdWHny5LSkNjAWqzHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2117c18-eda9-4624-0f56-08de8fae0a23
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:17:59.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3/1kCVqR9vn2+8W/0ownjVpUpCY69R16P/CCghn2PT3U8v3jaLKbZZIPzRDyyD8iqDAgYOqgkzFkHwhLaQXalrm4Ul1DnF3bmcSb/eiE7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-273889-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,samsung.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,huawei.com:email,amd.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DC144374D76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl API for creating a cxl memory device using the type2
> cxl_dev_state struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 6619084a77d8..63e6f277ae9f 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -75,6 +75,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENODEV;
>  	}
>  
> +	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);

Did this forget about:

29317f8dc6ed cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation

?

tl;dr: see the replacement patch below for this and the next several
patches. Untested! I will write a cxl_test for it tomorrow. For now,
take it as a "something like this".

---
...longer story.

The difference between general memory expansion and other CXL memory is
that the driver has a use case for the memory. For general memory
expansion the memdev *is* the use case. A NULL attach parameter means
there is value in continuing if the memdev is not attached to the CXL
domain or not mapped in any region.

A non-NULL @attach addresses all the caller's requirements at attach
time. It also arranges by default to trigger ->remove() if anything in
the CXL topology is disturbed while the region is in use. Anything from
hotplug, to modprobe -r cxl_acpi, or cxl disable-port.

For efx a finer grained failure mode can be built on top of this by
adding a remove action that something like efx_tx_may_pio() could use to
dynamically fallback away from CXL if something goes wrong.

Until then though the CXL subsystem, because CXL allows for dynamic
memory reassignment, goes to great lengths to ensure that it can all be
dynamically torn down. So consumers that register relative to a cxl_port
topology need to be prepared for that port hierarchy to be torn down and
evacuate their usage of any regions.

The rest of the patches in this set are racy because none of the results
are stable (locks dropped on return) and any teardown is silent (no
notification of teardown).

All of this wants to stay local to the cxl_core and should not be
anything that accelerator drivers need to worry about. Accelerator
drivers just register, get a physical address range to map, and off they
go.

The meat of this patch is cxl_memdev_attach_region(). The rest of is
protection against userspace messing up the region configuration.

---
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
index 961639cef692..bfd8633a1e01 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.h
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -24,10 +24,7 @@ struct efx_probe_data;
 struct efx_cxl {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
-	struct cxl_root_decoder *cxlrd;
-	struct cxl_port *endpoint;
-	struct cxl_endpoint_decoder *cxled;
-	struct cxl_region *efx_region;
+	struct cxl_attach_region attach;
 	void __iomem *ctpio_cxl;
 };
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 10a9b8fa2f6b..1698d15ec1ca 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,22 @@ struct cxl_memdev_attach {
 	int (*probe)(struct cxl_memdev *cxlmd);
 };
 
+/**
+ * struct cxl_attach_region - coordinate mapping a region at memdev registration
+ * @attach: common core attachment descriptor
+ * @region: physical address range of the region
+ *
+ * For the common simple case of a CXL device with private (non-general purpose
+ * / "accelerator") memory, enumerate firmware instantiated region, or
+ * instantiate a region for the device's capacity. Destroy the region on detach.
+ */
+struct cxl_attach_region {
+	struct cxl_memdev_attach attach;
+	struct range region;
+};
+
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
+
 /**
  * struct cxl_dev_state - The driver device state
  *
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3edb5703d6de..5d60e6c0a89e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -406,6 +406,40 @@ static int __commit(struct cxl_region *cxlr)
 	return 0;
 }
 
+/*
+ * When a region's memdevs specify an @attach method the attach provider is
+ * responsible for dispositioning the region for both probe and userspace
+ * management
+ */
+static bool cxl_region_has_memdev_attach(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		if (cxlmd->attach)
+			return true;
+	}
+
+	return false;
+}
+
+static int check_region_mutable(struct cxl_region *cxlr)
+{
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return rc;
+
+	if (cxl_region_has_memdev_attach(cxlr))
+		return -EBUSY;
+
+	return 0;
+}
+
 static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
@@ -418,6 +452,10 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
+	rc = check_region_mutable(cxlr);
+	if (rc)
+		return rc;
+
 	if (commit) {
 		rc = __commit(cxlr);
 		if (rc)
@@ -2768,17 +2806,23 @@ static ssize_t delete_region_store(struct device *dev,
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
-	struct cxl_region *cxlr;
+	int rc;
 
-	cxlr = cxl_find_region_by_name(cxlrd, buf);
+	struct cxl_region *cxlr __free(put_cxl_region) =
+		cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
+	rc = check_region_mutable(cxlr);
+	if (rc)
+		return rc;
+
 	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	put_device(&cxlr->dev);
 
 	return len;
 }
+
+
 DEVICE_ATTR_WO(delete_region);
 
 static void cxl_pmem_region_release(struct device *dev)
@@ -4223,6 +4267,88 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
 	return 0;
 }
 
+static int first_mapped_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (cxled->cxld.region)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * As this is running in endpoint port remove context it does not race cxl_root
+ * destruction since port topologies are always removed depth first.
+ */
+static void cxl_endpoint_region_autoremove(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
+/*
+ * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
+ * simple case of single mapped decoder per memdev.
+ */
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+{
+	struct cxl_attach_region *attach =
+		container_of(cxlmd->attach, typeof(*attach), attach);
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
+	int rc;
+
+	/* hold endpoint lock to setup autoremove of the region */
+	guard(device)(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		return -ENXIO;
+	guard(rwsem_read)(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	/*
+	 * TODO auto-instantiate a region, for now assume this will find an
+	 * auto-region
+	 */
+	struct device *dev __free(put_device) =
+		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
+
+	if (!dev) {
+		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
+			dev_name(&cxlmd->dev));
+		return -ENXIO;
+	}
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxlr = cxled->cxld.region;
+	rc = devm_add_action_or_reset(&endpoint->dev,
+				      cxl_endpoint_region_autoremove, cxlr);
+	if (rc)
+		return rc;
+
+	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
+		dev_dbg(cxlmd->cxlds->dev,
+			"region %s not committed for memdev %s\n",
+			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
+		return -ENXIO;
+	}
+
+	attach->region = (struct range) {
+		.start = cxlr->params.res->start,
+		.end = cxlr->params.res->end,
+	};
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_attach_region, "CXL");
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -4254,6 +4380,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (cxl_region_has_memdev_attach(cxlr))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		rc = devm_cxl_region_edac_register(cxlr);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 6619084a77d8..a388f3120dd4 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -75,6 +75,25 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->attach = (struct cxl_attach_region) {
+		.attach = {
+			.probe = cxl_memdev_attach_region,
+		},
+	};
+	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, &cxl->attach.attach);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
+	cxl->ctpio_cxl = ioremap(cxl->attach.region.start,
+				 range_len(&cxl->attach.region));
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
+		return -ENOMEM;
+	}
+
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -82,6 +101,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (!probe_data->cxl)
+		return;
+
+	iounmap(probe_data->cxl->ctpio_cxl);
 }
 
 MODULE_IMPORT_NS("CXL");

