Return-Path: <netdev+bounces-232679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E943C080BF
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620C01C24ACD
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226C2F0C67;
	Fri, 24 Oct 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKAAo27z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B01F5846;
	Fri, 24 Oct 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337492; cv=fail; b=tjoJZ5/a4KgpiymSvy1ITyub+WnBhM2rtHednl6Q2Eo133p77YlXWyDS9gO0qoHDaKAX2MAx+BdJllKZBg37+/GovJ/JvPn18Eg7YM29EYDH4iw3QYcl9foEWtsr649xGswdExKtlEDLaaUG3eNdqN2Da2yEF/WREUT1WxXLdSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337492; c=relaxed/simple;
	bh=GJLF773BgWzDng45SwmbVqq2wpIStmXSBgyKZ4YREkY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V59D2PNFx13gGnAoDzLtpcjeFla2BVwJBiSUEeo7GmHPOnhSIswKMa3d3+iPWLb9s4IGNJ9do9Uc9U+rRkoEpDB4WqNtnS//KExPTAbunrI1kmk8UQdGJvXUk/OnFl3B4WDZyYpfGw754blv6O+8BmsGIlVnpzNd6TxOs+o/FFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKAAo27z; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761337491; x=1792873491;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=GJLF773BgWzDng45SwmbVqq2wpIStmXSBgyKZ4YREkY=;
  b=TKAAo27zGA2a1CLBGnKUSL/SdbxmFVnTocz5agYJXOcL2uuoboxRbto+
   csSofDVPMzTG+4q+udKf8mb/whexagfporMfyTncJXZw/KvA6WK1rC6Ws
   3exZFeD9D8NAnQcRrd2mHIgM6B/kboXmAFswd+LVuKya2IL40oG1SWpyQ
   t335QPG9+o8rMKHRWCNCPqbaqPvU5fQAA5BCx7ooi8f8bwB3WloOc+wRH
   QC5cILb9nQF65SzoeuCDOEffPflhs3OLPXIko7ctoAOACfDWFcUhD8kbo
   09De6Snn36IN7X8neMiOg+gUCMroeaiHX1MUAnCwa9YBz+UrxJt/NGe2V
   w==;
X-CSE-ConnectionGUID: UbvYHwPcTv+GvLVBc7STnA==
X-CSE-MsgGUID: KfN7D1xES5u03tIxL//T2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86154177"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="86154177"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:24:51 -0700
X-CSE-ConnectionGUID: t1zVzM5iQjSBPUkPUkNeeA==
X-CSE-MsgGUID: d5+kDN8wRJGLgvkJXpfRzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="188904420"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:24:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 13:24:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 13:24:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 13:24:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywi85kQ5DVSnupH0y0Cm+Z4cBYsFMbegZNnLrXX9KVCLF/fnQS+5j1nhYtNGr7+ubh7wD6s3k1geB/Y5oCJ4eolGnnD/yJdgDFzMSPg73afO+7F4hB0IqPNrZYtHCnvQBwzFKa6Yh9FF5ODffzzVYSopD7tWVEbMxuW8Din3rnrJEWyeCdJSTSx4kDkc3KDF+2kBK8pcHYk5NUKkbfd2cLrJsvWw4cs4V8ba1xamIBIu6ms8erl4Nw0GNMXGqqp3irh85XsCB4HlqRGmblmjPcJW26w5LSHQeBukcJVJ7dVnvEMoSBG9ogNJjb8pl/A3hTWzoYdhdrfRypqNqpJHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgR/WklEMctmpqxQdRUeZqMA93Gmz+KAGjd49wsqweE=;
 b=L8WucwSuPLVbCN86P65xK6+B0SqpxUXeG/k9pMadsht6VK3RRxrvGsD950f2wA25oapR6+S+DlyMDictnkffBVS+vvTYSnr/CAKU6x8/zi6Ui8Eg1g/meBE+7hX1qm6ao3RePNanhKo7Iq4zgXM1hMOAEDPGe8l6cgO39CZClVanOpp7GhXUwYPOLt38ZrDCJaZTtVeVp/1J+aEmVcr4PIj8KELowAvKwpNZLfFCSj3DZTlk0b07uwJeK8iq9Oxb8BGzIO8ICDLfdAK0s/by86FlLJ51y5Dgnz2wfBThzq6KrA3cpuW+9A0QqOTH7tANj7lpKWOj8ZX8Et8HVX/DAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 20:24:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:24:45 +0000
Message-ID: <6bc62c85-00f7-422e-8c9d-e7dcd1ab7311@intel.com>
Date: Fri, 24 Oct 2025 13:24:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: hibmcge: fix the inappropriate
 netif_device_detach()
To: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-4-shaojijie@huawei.com>
 <02692f16-b238-49d7-a618-150a03cb1674@intel.com>
 <1a685858-833a-4ccf-93b2-d878eee25722@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <1a685858-833a-4ccf-93b2-d878eee25722@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------TpFjTvsZMEdyt0na5WoFFvGn"
X-ClientProxiedBy: MW4PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:303:84::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: e87fe4b8-7e28-4640-fc6f-08de133b5f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWthNXVmZVZrQ3JkRmtQeDhyYkdGeWhwOUFKcEFRLzVrQjYyK1lFRnp3MjFN?=
 =?utf-8?B?UFdBWW1lcXRlNmEybHBLV0RGcmpsakZwYjBBT1hTamo2Rm5Id0huU1ZDYldn?=
 =?utf-8?B?dzIraVl2RmVNN0NOWllUOG9PV3Z6REZHN0k5Zm16c0p0RU9JM2Y3YkUwM3pB?=
 =?utf-8?B?dDNLYkNuMUlWU0k3TmlNQ1lmaUtwMTQrMHdVU2VDeGdWa2taZDQyWkx1eGRw?=
 =?utf-8?B?NUg5OVB5V3NTdTNwUmJRMUdrWUY0cDF0YmdUdCtwRmZDU3VkaEtjODBnTk4w?=
 =?utf-8?B?ZlJiOFc1dUo4LzZhOHdkMVFFL3JDQ2lLQm92UzJtUFQwNnp1ZE1SZ1VlS2tm?=
 =?utf-8?B?L0tROEpIMi93dFhKM3JmNC82dGxsTDRxb0gwWU8wVTN6VDlmNFhjQldUWXp3?=
 =?utf-8?B?cDBWVkN0alZzVlUwc3ZXRDBCMU5CWVFYa0tvYm9mQndqbFF0L29mUjRLVndR?=
 =?utf-8?B?Ni83dStuQWl3QldITSttNFVsamdlRDN3Vmp4TUIvTG5aT28yTmZDV1FFYURo?=
 =?utf-8?B?S2V0SXlGbTVXQ1FTY2dSTXJIZGFTZ1NSQ28yZVc3akR5d1oyUHoyVXJhY3Zk?=
 =?utf-8?B?ckxGNVpvN3RwdW9hUVBWRXlXdktrUkRvU0V0QWVjWDFlelJqNEZYM2lkMUZL?=
 =?utf-8?B?OEpUNi9VRWJrMml6dlVHVlZYYkVOaVhmUGoxRTZwZWx6dmVmTGdJcitUeG9x?=
 =?utf-8?B?YWsvbGNxMlZXV0d2ZjVQY2NsVU5DMFp1Rm9YRTRUT1BYRHRBSktRVUxkbU1C?=
 =?utf-8?B?TmN6cmhCbHE1OXZ4ekk3cUFhWkhNL0tFU2VZZUdTMEdGS3A0WHR5Y2Fqd1Uz?=
 =?utf-8?B?OVpyeHF4S0lhNkRVMjRDSVR1b1FpWlhrMUFCTHhTOUhJRFI5UlBhbkNXTWta?=
 =?utf-8?B?endPcDlMcTk5L1BhWXVxbjlTT0prVU5BbCthKzV5T3RPa1EzL1VjdUdSZGZB?=
 =?utf-8?B?QVlKNFl5SzF0c3VMRklUb2x5dnlaNmg5dUFvcDZodmFyQXhEaFh1Z2tiUWRC?=
 =?utf-8?B?aGgvZ3VsK21VWVdTSVVTSzFaamUvMlhGWE5QZ3ByUklLYmhRZ0Z3U0dyWVh3?=
 =?utf-8?B?bVlUM2JWK3Jldk4zV0o4QllNdXA1RnRjN2tPd2x4SUpmWGZjSWFrT0ZyNjhX?=
 =?utf-8?B?UmRiVTFYNUdJVGM0V2h1dGlHelNhcWd4R1hNcW5DYTJjM2lVVTRpZmxnRmxw?=
 =?utf-8?B?VGQwcHJQRjRkR0RYWWZrVnF1eUNDcEtNTGxHdDlOU1JSQXNaVGU0cVVnRmh3?=
 =?utf-8?B?cW9tNENlVm9OMURmcW5nNFBNSUxGVk1wWThXMlNqaVNhYnZ6c2ZnU1MrUkRU?=
 =?utf-8?B?amNzaUhsNEdoT1BNZ1dYekc1RTB6cUhxdmtaRm9iQkZYZzZpTUk3eW9Jdi9J?=
 =?utf-8?B?ZDV2TXBFQXEwQTY0clkrdXE2Q1lUUUdzUzc0QWNaWXhLN2ZjSnpndkV0MzFI?=
 =?utf-8?B?V3RiYVZGNzdqOE1NeDlVUVhWMmpTT0xPM1lBelVFczNTckZaL0thTGJWOWNj?=
 =?utf-8?B?WWpOUEtEODJGQWZiaXR5RTdSL25qcU5nd0Jia0k0Y0szWXdGQWhRaWhFWTFm?=
 =?utf-8?B?UUorNGFiRjRBMXlUNXZ1MnhaS0pIWVBCN0ZlK0hIa2lpdW9NT3E2M3hUUHFy?=
 =?utf-8?B?QlExT2VaaTRJbjVWRmxzeU5FQWhDeWgrbWw5QStEYWIxb09KUXpHR1p0L0d1?=
 =?utf-8?B?dVNIeVc0bGdhQ1dKTUdpZnI0cTNraWpyOTR0K2xHZC9IdXlHUURkTzc0eUFn?=
 =?utf-8?B?ekM2QkdUOXpQd2NjUXFSZHJtNGsyeUFmMSsyQ2Nud0ZBSGZNRHdlT202Tnkw?=
 =?utf-8?B?S1VkeVpjcURVTUo2cTVsSjhBdTllOU1nVHZhSW5YU2xvQm1LNytRRGVLVU9s?=
 =?utf-8?B?bVBCT1gvWHQ3K0tVVUtLU2t6MlMwK0FuM3hYT1phNUFTeTdaZ3pEdnRQU05H?=
 =?utf-8?Q?eXRJPciBsvN/rJ8QDNFSOS5jv8hIQpwD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHpOb3FnR2k0SFp4V29WSzVvQjlBdmlpamRRZjd6YkFoOGF6ZUtIVG4xSXVo?=
 =?utf-8?B?TnNCVXlSU1d6bzArM1RnV2tEc2pxbUwrOEozNkJJTDZJQUtjS01iR2tVMzRt?=
 =?utf-8?B?eXE5T2hCN1RIQW5ObTFjVHhGdGNkVFBGRVZXUW5TS2JUUnFCalExV1Z1dG5q?=
 =?utf-8?B?SUlueGttRXdReWc2cTRPTXdIZC9iR2ltendLbm0xWUw3Q3h2WjhVMnl1eC9I?=
 =?utf-8?B?LzFTQVVDcjJwc3ZRdG9heE5VV1hWZzdQMzBFOUhLT1JXWHgzcHMydW82Z1lZ?=
 =?utf-8?B?WmY5YndBNDh0Rk5OUXNzZEJkbmRTZm4yNlVqN2Jpa3VobUNGODkvck15N2NG?=
 =?utf-8?B?bytUT3JrWnQ0ZFJaYitEcnVwZUtCL0c4RW5hM05hRDJEZGEvNzdsV0lnMnFH?=
 =?utf-8?B?TEpPeFBFMzBVT1dhK2dRY3RSN2dUdkExY1pMNXVzbWZKWWFuK1pDKy9DS3d6?=
 =?utf-8?B?eUpHOW95QVFRWWlsVjdETGlMVzJBRFZqOGpXeHc3akFMTWxpYjRPNjFLTlZa?=
 =?utf-8?B?c1RPUFl5YWZoaEUyMVU4elh5cDFOSlpxbzlyKy9DL0kvMjFYVDllWS9DMGRw?=
 =?utf-8?B?UDZ4ejYzcS9IczlSSXVyaTdtazYvZU1FT1BoZ0NSRytkQmFFQ3U5ZXp5eGlu?=
 =?utf-8?B?VUp0WmZ5QWxWbnhET3phQzNCWnBZNmJDbTVISWtJZW9waXhlaHFmR3piQTlR?=
 =?utf-8?B?UHg5ZmVBZWU1N1gzOC9MRlFSMlVEaEt0bFBNOGFISVRhY3lDeXhLTmNjNDhF?=
 =?utf-8?B?aWg4TUkzRGowYjd5cWE3d2E2WUVyY2s2blltcUJGTy9JSHdFVjMvUG5NWWhT?=
 =?utf-8?B?eEtMeDdaeVMwd0lsdXB1K0dSamhvSXIwKzNUNHI4VEJDSDUvOE1NNUtLalRp?=
 =?utf-8?B?QmJsN3lQcTExSUIvalNoNlJqbGdvSUhwRmpsWFV3cFExR0hrdnh1bHZGS0E4?=
 =?utf-8?B?WDJHQ1JsTURPM2hqcmdDd2JkT280VVhjSXQ5dFlrZnpPR2kvWjdLaXV4WTRr?=
 =?utf-8?B?SXpIN2UycEtYajgveDJzUTRqRHcxenQyRFhVRjRLcVZuTDZDN1dRMmV1U3l5?=
 =?utf-8?B?NkhsQ0JWKzljTDVDRDNIUm8vbzBrSmJoczZELzJURkpmRFlMZ2gwZ0VWbzQx?=
 =?utf-8?B?a290TjduWC9KdXlNM3gyOEF1QUNpMzJXN2ZsMThhWGNjK2NBVUJQRWVGSGJv?=
 =?utf-8?B?M2p0Y2t4R0dEbTJ6UUYyckJHM0Rsc3cvTFc2T1N6YjArRnlyT0JGUjNJNXhs?=
 =?utf-8?B?dzF3NEFmR2NBVTdlbzF1dFNlZ2JhWDRldnhLeWpjNElLOXFWelhka0pIc1Ni?=
 =?utf-8?B?SXlDSXF1T3VwWTRZa1pJWGVmREtFcDZlaW03azMvVWkzWUFPbWJnT1V1amcv?=
 =?utf-8?B?MFNTN3B4V0wrRDkrbnB1d1RLUDh6SStGRFUydjI2dlQ1RVBkS2NNQUtGVkVT?=
 =?utf-8?B?L1ZMK29GcG91a043R3ArNTlnMlMwZzhUUGVxSFF4WnNQbWdiN0llU2g5dGZX?=
 =?utf-8?B?c2RCNEtNaGFFbC9nMkZEUzlrYWFmYXYzaXhaK3AyQ3A3ekliTjZvK0dkM0lp?=
 =?utf-8?B?RE5ESDBlM2YxRmhrY1lXcDRpdWtmS1VhNW9Ud3NiUjdaUUlzU3VNS25MYkp5?=
 =?utf-8?B?VzBNS2FzRGJQcllCN1V1bE41MjJQZlhiNDBEMFVVeURIQ2wzcWlFUEVzUzFU?=
 =?utf-8?B?ZlcxOHVHMUpPRUNVOW9PSVNDdUV4Z0hUSzhhd2NjR3ZzcVhyWWlXMUZqc0wy?=
 =?utf-8?B?UTVPZWdlTmEzeFZib1Via1BIbVZPNkJyeW9OK0IzU2ppb2V5S3ZGZXdaNmkz?=
 =?utf-8?B?bEt1NkZNVUhSNTJzN25pN25wRXNnL0FXQXA5OW80QVRzcXdjZEFhdEVZY1pP?=
 =?utf-8?B?eXI3TWVCdTFtaWFrRHVKMnhwckxGbEZoWDY2MXR1NDZHcndMeUZJeG5DdXJv?=
 =?utf-8?B?UW5peWRZa2xTTzZOdmc5dG14c1VVRDhZR2VIMlFFVTZ6L21XVDBXdXNhUTkw?=
 =?utf-8?B?Zmp4UXpJdWd4a3NVRjJaOHduVFlMUFZhM2tIR0Y5dndYd3lKSTJvSjFuWW5z?=
 =?utf-8?B?THNkTzhLL1d1b0psemJLdkF5NWwzNUhEWWRIS0VsTzFkd0F5bHprTnBnTncw?=
 =?utf-8?B?b3dKZGJOeVNyNkw0VGZSakR4ZHFBMzIxWWJ3VXlsclFFamxCT3J1QnJ6Ky9G?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e87fe4b8-7e28-4640-fc6f-08de133b5f16
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:24:45.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFIH9eib3g4iCOpfFywfIF+JDv4htU5l3z8GK1joGLhBZ+TkLDM9xewbB1Itiw8r1r+GoIjqBvKIhfVvUmuS2uJEpo4Phtwx1LB+LNnTGLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
X-OriginatorOrg: intel.com

--------------TpFjTvsZMEdyt0na5WoFFvGn
Content-Type: multipart/mixed; boundary="------------cu09RpFDkm6pY2R8Wj0Au02l";
 protected-headers="v1"
Message-ID: <6bc62c85-00f7-422e-8c9d-e7dcd1ab7311@intel.com>
Date: Fri, 24 Oct 2025 13:24:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: hibmcge: fix the inappropriate
 netif_device_detach()
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-4-shaojijie@huawei.com>
 <02692f16-b238-49d7-a618-150a03cb1674@intel.com>
 <1a685858-833a-4ccf-93b2-d878eee25722@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <1a685858-833a-4ccf-93b2-d878eee25722@huawei.com>

--------------cu09RpFDkm6pY2R8Wj0Au02l
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/24/2025 12:21 AM, Jijie Shao wrote:
>=20
> on 2025/10/24 9:05, Jacob Keller wrote:
>>
>> On 10/21/2025 7:00 AM, Jijie Shao wrote:
>>> current, driver will call netif_device_detach() in
>>> pci_error_handlers.error_detected() and do reset in
>>> pci_error_handlers.slot_reset().
>>> However, if pci_error_handlers.slot_reset() is not called
>>> after pci_error_handlers.error_detected(),
>>> driver will be detached and unable to recover.
>>>
>>> drivers/pci/pcie/err.c/report_error_detected() says:
>>>    If any device in the subtree does not have an error_detected
>>>    callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent
>>>    error callbacks of any device in the subtree, and will
>>>    exit in the disconnected error state.
>>>
>>> Therefore, when the hibmcge device and other devices that do not
>>> support the error_detected callback are under the same subtree,
>>> hibmcge will be unable to do slot_reset.
>>>
>> Hmm.
>>
>> In the example case, the slot_reset never happens, but the PCI device =
is
>> still in an error state, which means that the device is not functional=
=2E.
>>
>> In that case detaching the netdev and remaining detached seems like an=

>> expected outcome?
>>
>> I guess I don't fully understand the setup in this scenario.
>=20
> We have encountered some non-fatal errors, such as the SMMU event 0x10,=

> which triggered the PCIe RAS and caused the network port to become unus=
able.
>=20

Right. I forgot the same function is called even for non-fatal errors.

--------------cu09RpFDkm6pY2R8Wj0Au02l--

--------------TpFjTvsZMEdyt0na5WoFFvGn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPvgjAUDAAAAAAAKCRBqll0+bw8o6C3g
AP93xsUsp4BIv383lV2g+1yr177SGBE1KKPT6LXGFh3vaQEA/SfVodDldtZbTbRzd5oL+RCFu5mX
DU01FCjlqmt1ews=
=VDPQ
-----END PGP SIGNATURE-----

--------------TpFjTvsZMEdyt0na5WoFFvGn--

