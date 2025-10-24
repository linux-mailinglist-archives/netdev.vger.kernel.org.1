Return-Path: <netdev+bounces-232309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33793C04016
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EFA1356DDF
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E83E73451;
	Fri, 24 Oct 2025 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mc+wBJIC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21821E552;
	Fri, 24 Oct 2025 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268581; cv=fail; b=XpSWSd6vArWC8p2CtIEq2Oim1iGMcgyOylcHLJJh7MsUDCyqkbubNw7UPmRvAzj5TW93c6+CoDCpDknMvMhpr8tvszb/lh0Lg5pDcVDjxN9LUHfyPW1rz3H5pa8Ykyr8AwvbpG097SuE6KZqjwC2uiKEaelKwaDgfmkQv051MbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268581; c=relaxed/simple;
	bh=gprlY+hpS2yWGrUD1B+EJ8x9aTovt5uOlhF0uxFUPKA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+rjJTTqlErNRtnihyGqCamRaAuh6ujqw2vk8mvtl6GI79ASS+u/pSp6y+RbASkdURvPdtbfpGaXIGbSpj1NX9drcBZ0NWVuApgEaAeiveuH7ubA12F0hubpzJVifzDKRE+wGusgANvDIysG2Ppl7huGm2OM4/QINifkpn+17Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mc+wBJIC; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761268580; x=1792804580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=gprlY+hpS2yWGrUD1B+EJ8x9aTovt5uOlhF0uxFUPKA=;
  b=mc+wBJICaCHghDEyDUcYi5f70XavT6sEeMORTxZT4uEioxCIXwj1IWnu
   pqfi9bmocHOuZ/SdVjqwpC53T9bo/bOIErII1XEXsU8WcboI43s9TQw72
   y6a+AjINDEDmJJGxGHP8ch6rhr/k1xgJf7s7aCLFbOHjMAKLUNJONOzWv
   V03go2N2woBMXvazhoY4LLIfoGL2h6jErBAq/4u/aljX/sEpMElx0btn0
   hIu3HIfyCfuSmuDzN1VPawf65H2lCkdo1nQ6Shs/m5pTGeYPAbYxz1U6j
   y2IN5vVu4SiA90AyTWn4vbqhaevs90OSgITJl1FnCzOAO9SLCnugIj0Jr
   w==;
X-CSE-ConnectionGUID: SFoVeF47R3eGWatBGlnOlg==
X-CSE-MsgGUID: 4MtKDqOfRj6ZXBSZqL2Wzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74889429"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="74889429"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 18:16:19 -0700
X-CSE-ConnectionGUID: IehCEPCrRwSeJlJEsCYaWA==
X-CSE-MsgGUID: VQ5LBGasT4yKZoc1G87aVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="215228993"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 18:16:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 18:16:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 18:16:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 18:16:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LflHj4ZOVAL1F/1hM6KL5Z3alMUdeJABxlhmX41+vqyj8p0SA8dG3sW6k60CF20z6m+pHbRsCLLtNPEawHoRQdmRFgUCiYWmOP6zhrKhNNkQr8m1dVN0LHptWfR63KnnSrhVHvHpL5uzcBQuE6+FrsnO6p4dqz/qHBSBvKru9WmxveQm6GZgciuvXhkbaH6WOrHj0ydmHcYbtV+VBs+a+TguO3dJ8SP7iFUNzx/R5tpLV8CoW6Qp00dc/AkMYQJx6/wxIhKQlfFcWAbmfZfEEdqd5ee6TFPIumr/N5Ywox33ozH9BaiHDybdEURD5OfvqP/D1gvN8SLJaRm2P4e8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCNF3SRN2jmd4uSPpkeXpfhXOi2SEs4FJQzvdlb5vY4=;
 b=lju11WZ5rDHkCqO5uAr6s/7OKWtSIKZ3/uV2l0wgqs8L+6K8c0xgC3JfkCrhDu6WWC7r0tvsFrsOwPqD8L4EJBC4bbQGAGeURqggXaUP8owaKKxgjY0dLDFN+CjXUY7RA5rvg4e2moa2gK/zWwdAgkM0N7N6+T4UkXUdYkRKK3arHxZKwduUUg7V49jiK2VIDFFdBrtn2R6HjXaDI2f7Ipvn+cunaEXviXZJIqQVZ1li//CyXuiCdnhU2eDYye1Mkcge6NWd1VW+yeSJvB24uylw9eunXMlFxmA6LdetIrPYg6/YucGBWsseSmQyDPLQ0F9o6E5SZqLy3ZsqlAW1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 01:15:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 01:15:58 +0000
Message-ID: <759b7628-76b2-4830-97b2-d3ef28830c08@intel.com>
Date: Thu, 23 Oct 2025 18:15:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: hibmcge: fix rx buf avl irq is not
 re-enabled in irq_handle issue
To: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-2-shaojijie@huawei.com>
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
In-Reply-To: <20251021140016.3020739-2-shaojijie@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------iqDSnuJCkLygxlfQhMTeMPui"
X-ClientProxiedBy: MW4PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:303:83::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed0f00a-b1cd-48b0-3f53-08de129ae32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2lzS2ZrWHdPVFlOOU5VbG51U3craENBckd3MkhWcmVJMjgvaFp6OHZqbjJx?=
 =?utf-8?B?Z29KNXJTT2V6bms0Q2VYWmdrbkwzSmxzaVVqU2UrVlR6cnpJdVd1RXFBVzdR?=
 =?utf-8?B?OXYxV1FTdWw3U1VlQjZZTmdrTzVZRHVYbEEyR1NjT2lScWZaSThqYVhnWDNW?=
 =?utf-8?B?bm5HWnJSSmFackRMUERQMEVjUnpqQW53VElPWUxmdTkwQ1Y5TVBhM1AycnF3?=
 =?utf-8?B?RUpkd2ExblRYaGl4MVdvWk01dTlFZEZPZlB5QUppNnVBUGlNVEhtdFk0eERk?=
 =?utf-8?B?VHV0RzhFR1h2ZlcyYVIyTDZyQ0IzWUpOLzgzeHAza25ZaG9uakcvYTFyU1V1?=
 =?utf-8?B?amUxNnF6aDhPaUl4TkFUaFljcmVFZm5tYXdBQ0tkWTRObkp1UDdUNjNNRDNY?=
 =?utf-8?B?TmNqNCtKZDFDY1lTZ2x1QzJSVEo0TlZUQkc4bXQ0YjQ3azVOR3NlN05jb0Z2?=
 =?utf-8?B?a3NwVTBCa3JrajdqSGRpMkVMNEg5U0dSWk1xbHVzTjVIRGhLQzhGTStoS0Zu?=
 =?utf-8?B?NElRNnhOWmM1QmRhSFBPZjBVd2VDUEZ2QXdiODY0WEsxK3h5VUxCVjl4VFY5?=
 =?utf-8?B?VWk3bUMvRDJLY3ZBL3o2WEhWVW83bjltNVNXeDVlTFE4UzZIeVZFOEZWVThq?=
 =?utf-8?B?bnpmNkJjMGJBNEhUdXJMTXhSOEN1NzZoQVhadEZzNlk4TGJqeVVsYldNQmxW?=
 =?utf-8?B?YlgycTh1REhsRTFvUHJhSXUrUmdUSjRjRENKNVR6eld5ZTE5NTBVM0NDaEVH?=
 =?utf-8?B?bmJWYU1ZT3piU0tocDdpR0o0U2tPMkRObm9RaWRSSnZPcVhKcGsybFFFcGsz?=
 =?utf-8?B?aTBrekNKSnZlM2JINElsaXhGdjJEYnhlSnozdFB6SlIyZ3hMT0VLOHFpc0h5?=
 =?utf-8?B?V3I5TkowMk82ZWxsT0dqcUFYRFZ1dVFrSG8wOHIrVGxNMU5wYjZ4Y1RJMG02?=
 =?utf-8?B?OFZ6TmlmRkl6c2prUTVxdCtpWVNGMlhyWkV0cmUyZzNNb3dMQWVnWUsyeDBS?=
 =?utf-8?B?ZzgzK3dQc3oxWHcvdUFpMUdTTHhnVm9wWTlnVUdhM2ZLQzFPV1o5WlRUdVp3?=
 =?utf-8?B?QkZrY0tsbjVqM243enJDa3MxbmtyS2Qzb2krRnRoNFhNMUdJWW5Wc3ZkSlJF?=
 =?utf-8?B?bklUb3A1RTJrNGhOeWQ5R0Y4SkhpNXM0Zi9DYXJmT051a3lXTUdZOXAvQkcr?=
 =?utf-8?B?T1NYYXF6Q3RIWitDaGJzU1NRSkV5TGZpK0FGV2pUMG9CUDBxTCtrRzVxRFMy?=
 =?utf-8?B?L1NxcWU5djNWUkJ1SThzSkdHdkxiTUl1Y3NEeG5ST2d6akpDUkQvR0NFSlNw?=
 =?utf-8?B?MTh4d3Z0ZldjdE5VdWRLNHhjTzMrQ3k1MmMwLzdBc2RLcERIdHc0RDVxWExC?=
 =?utf-8?B?VkI1MnhMMmcyQTZ5NzF1cnh1b0dIL1AzQmdKdnc0Q1Q5Tms5U1UvT0hpOTQy?=
 =?utf-8?B?ZFA4dllUN1pMcXBRL3NSSDJ6UlhZU2p2cUMzZzR0VHFidlpRVEtVQmdpeHRh?=
 =?utf-8?B?M29KVVJaUExLR0ZTUktPd0prejBXK25Va1JDenZEenRwTGt5cnZLZ09CWlhN?=
 =?utf-8?B?b2MrSGRVc3ptM1RNQnpUZS9YQnNjWXNHNi95V3FDMlp3QklmdUhmZE9jaVZo?=
 =?utf-8?B?WjFoQzFWWGpFZ0V3Si9abG94ZXZJM2h4R2ozSUZORUVjOTVYaDd4QjlPK0Fh?=
 =?utf-8?B?RUt4NVFLTndiVERFWFlFMGxhQ1hQUDRsZElKS0Z6R1lCWDNGU2xsY2gwMWYy?=
 =?utf-8?B?Zk5Va21Tc1NXZmZlelRYMEpWU1RSNEVlQ3V6NmtQQnlPT2RvekxBRXJOcW5X?=
 =?utf-8?B?V05aUlZqelJJTldrNW9tKzJGMGRIMTJ6MVA0Q01FRmZRVnRTOWJhcEJlUGtK?=
 =?utf-8?B?MzA1NS9HUkNqZWxEem5pdlRhVytWd1lxUm9xSlJPdkVqaTZ1VGRYaEo4T3VB?=
 =?utf-8?Q?4UtHeJ1bhrFymA08WCC2Qp+ou7fNn3lG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9CSHFWSGtLUFhGNEdFc3NuRXhYVVdFNW95Kzcvc3hTZ2g4R2ZFM255R1Ir?=
 =?utf-8?B?SDgvK2dNNERibTZ0a0FrbmRtN2lqa2RzOXN5TzlPL1ZZdzIvWkVkSUI4VnlW?=
 =?utf-8?B?T3RxNGIxQ2pGQUJuQXNaa29VVEwwdUZKZHJJUTBwR3A0aVJtL0MrODdqM05s?=
 =?utf-8?B?bG9iR0Y2YVAzSEtkZmFlSUl6dXdwREppeUxWY0hpTytSR0pnQUpjd1BSU0Ex?=
 =?utf-8?B?NG9QSjlhV3UwYTZZaWZwcFdXRmkvcWtRczd6eHppeDRUWGQ1ZXg2ZWFpdnhD?=
 =?utf-8?B?c1RGYW9YbVd3VXJJSnN6WVJjbXpKWmtVdGd5Nnlid2UxQS9BT0J0UWkzSmtl?=
 =?utf-8?B?MDVMWi96VERmZnpwbkdhN3ZCU1RteFVqUjc0R09laGFoLzlpTHNZVlFsVktV?=
 =?utf-8?B?YzA3MG9zYTAvR0h5Qlc2SlRKY01WS1VPU2hXVHRHVHpQcWZ1cE96clhrTys0?=
 =?utf-8?B?cDljLzJLa05VSSswVGFKaFE0K1pZSmdQVVQ4Y3dDL0p0UThCUVBjKzhrb2lW?=
 =?utf-8?B?ajdDSEdyc3ROUjJsQ2h6eG1ZNjB1d05nd2lvWEN6bzBVczRZL2xOdWJtdEVU?=
 =?utf-8?B?ZlMrVGtpWktYTXdPMWZuSGpOb0I3T1h3NEE0UEFIdFNQTWF2SkdkV1NDSHhP?=
 =?utf-8?B?aDQ1aXNFZjdHeUlETlgrOE9YK1REdEw2RzB1UE5EWXR5RGc5eWoxcUhBdFht?=
 =?utf-8?B?Tk9nbkVYZTl1V2tFd0VCYjM3UXVhVHpueUMrcGNZZC9aemxPZWkrZGN4VUFQ?=
 =?utf-8?B?ci9NdFBBbVFWMStNb3R3RTBrU1JSSldqMWRCa09IWXYva3VTVTJHTkIzdlBW?=
 =?utf-8?B?R0pTRnFVZ2xXOW52Q09JU09GYjhCZGwzT2ZSbDN3SHFydEJVUWZYT1R0K2Zi?=
 =?utf-8?B?aWhaYlRCTEorbDlCM1RaQ1N1L1FPOHBxbVoweERneG1zdkZ2QS9mcTVNT282?=
 =?utf-8?B?dFBPWldJWDRMK3B6WTFJTGxZSXRRc2c3a201MnIxSmIvc1k1d2hVaGJBZk1j?=
 =?utf-8?B?QUc5UUZOTWtSU2FWWjlrRlU3a1VyTHVFSHJBaWQ0N3d2b3UwYzFUVEhjam5C?=
 =?utf-8?B?czh6b25aSjN1dlJIVlBjNm1aeEh6RUVGSFh4bk40d09GUkdJWWNPR2tqTHov?=
 =?utf-8?B?emdlRnQxakdPS3BxUnVxU2Q0dGhMSFVnQ3NWbU5wV2I2VFcycHZ5ZjBkZVcv?=
 =?utf-8?B?UHkvemg1cnQybWFUL0xxTmVva2hST0pZMUVZOUF0a3ZudE4vK3daaXhwRHNL?=
 =?utf-8?B?RU1lNTdnZFNTbHEvV0JtbDJWdFhwWUhNREN1QzRyUmRFSHQyQzZEbU1QRmxI?=
 =?utf-8?B?Y0kzRlpYQjhzZFJPVlZrT2I5ejNiU0tROEoydG5kTmJTQW44dkYrSHo5bG1Y?=
 =?utf-8?B?cUhseFZDSnh4ejlZclIwa3VCTTgwa1FzZjh4QmxUQWRZVFhTRmZFL3BsdEt1?=
 =?utf-8?B?d216WkFRc3NrK2hnS2htSTNLSWFxMzhlTThpM042Y2R2bkdXVGJOU2xVb09M?=
 =?utf-8?B?RDZFZXZEUFZWSVJUeW5sdTRQYVhCWlN3bWk4STFFcTdESm9ENnNmMmY0ZkJz?=
 =?utf-8?B?T2pYSkdsZ1RaSVdlZk9NQS9NZ28zV2FPTzY4WjB6UFd6N3hiakY0M2ZIaE9n?=
 =?utf-8?B?TXpLVlhDR0Z4RWJXMU8wT2pqejZBcURpNTBDc2FjVXRRdldUNnNlM3ZQUXRE?=
 =?utf-8?B?Tis1TG5xTENTbDA5b1NyeHBTR2JnYnZTMmlWcFN4THIrN1o4R2dIUHh6REYy?=
 =?utf-8?B?aExmYmR2RzlneklXSlUzOG5QTGRLdGphb1lmL1IrRld5NVVrOVpLNW5VZ1Yx?=
 =?utf-8?B?V1VEcm9ENS9JTG5FSEtweW8vM2ZOZzBGYXMzTXFPaU12c0t5VHhoZkNSaTV1?=
 =?utf-8?B?U0ZVTlBCUnBxRjhxZWcwTWVZQlRsV2ordDZmUTRwRmNqTHJkekJENXRLWlRy?=
 =?utf-8?B?d2pZOWlFMXVBTEdKSng5c1dXYm40aStVOHB3L1F2bjJLQ2hUK1hYdGUxWnU4?=
 =?utf-8?B?WmJzNlgxZlBTenUrTkFqcTM1a3VYc2E1TFZLZ2M2ZjRiRUNqbVhlWjVsTnFO?=
 =?utf-8?B?SmRjS0FianVHbHhkQWVpZTBLM1pHZWNjV1JYODZaRmNIZENxMS9QK1EzazFX?=
 =?utf-8?B?azROOVV0YXltTW1QOW5rOEJjbTFSZmtLVlpBRnpsVmhuVmRmQUhncVpkOU5s?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed0f00a-b1cd-48b0-3f53-08de129ae32a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 01:15:57.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9oVAbLzD3HEsee2IvueZF9SqXc29qm5ryjKRM8zvgzjUi0sRtRqBu+NMT+bFzQCNuoF7uoVX1INV5UT7KgqQV/ycTBbn0gDSAETTmNh6aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com

--------------iqDSnuJCkLygxlfQhMTeMPui
Content-Type: multipart/mixed; boundary="------------uAwaiNYuI0jXxsmnghcnTPFK";
 protected-headers="v1"
Message-ID: <759b7628-76b2-4830-97b2-d3ef28830c08@intel.com>
Date: Thu, 23 Oct 2025 18:15:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: hibmcge: fix rx buf avl irq is not
 re-enabled in irq_handle issue
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-2-shaojijie@huawei.com>
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
In-Reply-To: <20251021140016.3020739-2-shaojijie@huawei.com>

--------------uAwaiNYuI0jXxsmnghcnTPFK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/21/2025 7:00 AM, Jijie Shao wrote:
> irq initialized with the macro HBG_ERR_IRQ_I will automatically
> be re-enabled, whereas those initialized with the macro HBG_IRQ_I
> will not be re-enabled.
>=20
> Since the rx buf avl irq is initialized using the macro HBG_IRQ_I,
> it needs to be actively re-enabled.
>=20

This seems like it would be quite a severe issue. Do you have
reproduction or example of what the failure state looks like?

=46rom the fixed commit, the RX_BUF_AVL used to be HBG_ERR_IRQ_I but now
it uses HBG_IRQ_I so that it can have its own custom handler.. but
HBG_IRQ_I doesn't set re_enable to true...

It seems like a better fix would be having an HBG_ERR_IRQ_I variant that
lets you pass your own function instead of making the handler have to do
the hbg_hw_irq_enable call in its handler?

> Fixes: fd394a334b1c ("net: hibmcge: Add support for abnormal irq handli=
ng feature")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers=
/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> index 8af0bc4cca21..ae4cb35186d8 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> @@ -32,6 +32,7 @@ static void hbg_irq_handle_rx_buf_val(struct hbg_priv=
 *priv,
>  				      const struct hbg_irq_info *irq_info)
>  {
>  	priv->stats.rx_fifo_less_empty_thrsld_cnt++;
> +	hbg_hw_irq_enable(priv, irq_info->mask, true);
>  }
> =20
>  #define HBG_IRQ_I(name, handle) \


--------------uAwaiNYuI0jXxsmnghcnTPFK--

--------------iqDSnuJCkLygxlfQhMTeMPui
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPrTTAUDAAAAAAAKCRBqll0+bw8o6FeR
AQCKzbFw4HoYkN0BJfpi46i8+uXdvuCFJbdkKzAEAZeBYgD/X4dVnM5Kaj0EsBBC3zNTgmgb2nuW
1an7N0RlN220mw4=
=8Gba
-----END PGP SIGNATURE-----

--------------iqDSnuJCkLygxlfQhMTeMPui--

