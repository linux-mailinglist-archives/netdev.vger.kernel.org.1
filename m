Return-Path: <netdev+bounces-119026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF29953DF9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694141F21FD0
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E81155C88;
	Thu, 15 Aug 2024 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOsr70Or"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82E1AC88F
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765068; cv=fail; b=DDI+MFgg+PjiTnPKDvuE+24Laynv2gTezkS3vQmorGH8UynWLabT6iKAjGWULEPFSro6vjbXLXSaomBjl8788KQ6Ev+luSCgHr/n5cClMgSUMf9roRWhGI8KUbzTdU0D2ceRupPG3JlREyheh4NZIYl43CHKUY0jTId+bOC1npE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765068; c=relaxed/simple;
	bh=KfOsfHWhl4DZ2y0mHfK16Lw4by4EtWCTItcesCx44QM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbYkhqjmGp+H2uf8ZmdTL1iS0nuxe0it0mIi+r55OBNH8crnlsfrPDoSpqOt7rEPWZnozM7RSx17GWFQgk8AjgsSs4aNOJSYETaL9bLspXTaQfSAnMKOUN5RwJb/53rbCmghoVM8qRHBgys0fKgaPhfoMacwoDMwapvVW9ku/qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOsr70Or; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723765066; x=1755301066;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KfOsfHWhl4DZ2y0mHfK16Lw4by4EtWCTItcesCx44QM=;
  b=TOsr70OrL27rf7WdfQzeNNGtMX/zwDd3IWsIu4G/o1GnEjb1GI/HHbaJ
   w0K42rB3jG6ArO+iKsE6AWlOxWkwLSomQNPrQ/3KZeK5P5GKmTRXwEXku
   M+xtVgCoGPBPU5XcthGwe5fTA/GnnHN5J7mGcy/BdN31g46gzlYR5hN2P
   ane4sel27+l10lN+2BD1RzsEQHd6gjo5j92bY389xAk9l06ypFze+7PYz
   Ke789fbUEIpBETC2QVzDolyvX3skZjvdsDWx5cvS6AprGih+AmhTCYP3x
   2IarfOYhOCwlh89efIAfbsCaaKz1rpxM7Rd5S8ee0BdLa+IeZT1R7MGTk
   A==;
X-CSE-ConnectionGUID: IUqk3NWwSXaSmwcxvds68g==
X-CSE-MsgGUID: dPMxqdHWTTy/XOfoBO2HTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39504622"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39504622"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 16:37:45 -0700
X-CSE-ConnectionGUID: qBfNS31pTpCxrd59mnt+Ew==
X-CSE-MsgGUID: 95iAxDdfSOOvXmm60O8Nyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="63911819"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 16:37:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:37:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:37:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 16:37:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 16:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odvQlssP5fmJ5d75r12v1bYVgxYUqCnAUr9jVP402CMWZhxZE8vmq5EMTsKH9tonN+eI3WZLd1kxYv/nr6dnMay+5YRlBdidMUl9GQa43aVvp9YJNASyPScDdHMLT1ApvlK3xKOfEn3Vx12L0oFySGtzJz+XwBRJkSXY7kqpndhzfui6dwJkuvWTQE0Czv8L54fUKLbCqZBTuvzEz6t7o4B2UGyecWolcrIPMket3utleGUSoJGPSGoT88Sb0C3vEYmLp9WbYF8JMITdn0EKH/pNs6WWcTMctDIpZ8ZqcifHyo95uNnzvIDAgUh7Y5dCzxPvcF/HPmdayOetS+KUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CneNjFqtLTjkdW+hWZ8lsWT0EgyEVUf0qjgkBFiNrlk=;
 b=ETEs7niBRvE1AnmQvSd9+3ZCaO5v6cmdf2dCVmFyVtA3elulGyCZCga+wGtbrFGOrbx2Uz8lIvzI9gjnqus87Z3Zw90Tm7xv/70z8ZSdtraizxbSdINGkhFrvgNzF3v8YueF83nmYMLJv0BC8tcGByv7QFjrBzHWPPcxehQDHAZSJNKPiu/AAG/FBCpIZgHSlxdikxVGlEsO7xz0yMffc/SC6CBmwjm+0SWSHbUx2lKhdA7mb2z7tgysNMjXfTTHr6s7B+m8zmG1ui6Bd2gWInxMfDLTV5kkyBkfHN9NTHkxMBnz2UNAW+pQIvyTRQ9/T2z/S+G7tIwVNOKWkV/ziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.17; Thu, 15 Aug 2024 23:37:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 23:37:39 +0000
Message-ID: <0ffca24d-4a7d-449e-8f48-c091af91c96d@intel.com>
Date: Thu, 15 Aug 2024 16:37:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Strange behavior of command ip
To: Freek de Kruijf <f.de.kruijf@gmail.com>, <netdev@vger.kernel.org>
References: <3605451.dWV9SEqChM@eiktum>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <3605451.dWV9SEqChM@eiktum>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4065c1-0d7f-4588-c46a-08dcbd83401d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0VYZmIvTXRkSFFjRE54NUpqT2NDQ3ZuRGM4ZmdabHZLUFhlSXRURDN2SXFh?=
 =?utf-8?B?bVp1VjczNGNzYnhPbUlJTHg5c3pQcEE3cXpmd0JQWHlYQmhrMTBVY1N5Z0Ft?=
 =?utf-8?B?UVB5SXFwN1pMalZpcm90Tm5jMkY0SklKNFpCRlRDamhONVI1eklMeUdtQThY?=
 =?utf-8?B?ZHd3Rm1hdndIbjFzQ1N5K3RneXA1TjB2dU5JeWpvK1FYY1d4ZDg1dGFQZjlM?=
 =?utf-8?B?OG9IWGJTTVpvRC9UWi93VmdFWGhOY2lXVXNaa1AzWVVCMU5kbk5zUG81cEtm?=
 =?utf-8?B?azNNVGEzRHRHVnFRWkhvS0FuY0NkWUV4aDUwNEprTXVwSkpZYWtUd1h6WFhG?=
 =?utf-8?B?UGxvenlkdmJseUhOeFUySnhrVS9qRXh4d0RnbWRCbnpoRlAvaTZoenhZdERs?=
 =?utf-8?B?dWtNV2lVb3pwSUZPV0NxUmUrbmhHT2RabUFhUEdtL1NaVHpLYzVvalRrOC9z?=
 =?utf-8?B?bWJzNkNUT0RoMkdIemJjRmlmc0oyVkdhVWxXWjRiNS9nclprbCtZaUFhRW5w?=
 =?utf-8?B?RWhKeFBLRFZPSkUvMWdoSFA0Tm5RTkYrU1U3RTRyRllBSkNwRWFpcGhWWmY0?=
 =?utf-8?B?NHRiTkRSa203WmNXazI0MFlCQW0yTDZYeDNyRlhLbm9CQ0c2cEFzRTIvQVQ2?=
 =?utf-8?B?N1lCZ1MzcmRzb2hlNDdqcnIvclZTa1l4MFZOcTNBanFFUjBFQ3NwSGtIR2pO?=
 =?utf-8?B?RjZIYjk3ZFZTTExaU0ZqQjhtMkVWWlhqUjcxaDZIT1hmd0VUTWUrRlFhZ0Mw?=
 =?utf-8?B?bmNqTjJqTjhVVlR2SFVZUW5CbEpTWUxnZXdKTTlBOStPODBLUGlERUc5Q1Rx?=
 =?utf-8?B?S0hTR1NwaEtnL08vaVZRWDZyZUtObTZNdWZEam5OVjNEOEx0NWhkK1l3VFZM?=
 =?utf-8?B?ckgzTVR3TFNEeUJSaW5Dc096NUdNRlAyb0E0dmxvWXBEcDJXQmhhT0hNWng1?=
 =?utf-8?B?VGxHcWxFeUFQOTdQOVIreGVMZFVncllEa1I4YkZERFk0WG9FdnZDMlBpUzl4?=
 =?utf-8?B?RVk3dVc4ZUF1YXVUeVJad21maGc4a28yQkpmQVgzNDFkT01LZFA1ampGNHZS?=
 =?utf-8?B?VC8yektWWFVqLzMyL29OT0E3czVlZndnTlFvMWo4NHNndFdlclJnVGtsbWY4?=
 =?utf-8?B?Y09NKzBNVDFFYlMvNittaldMcWhia2s0bXpvcWx5RFFkKzU5ZWcwaWk1TXlE?=
 =?utf-8?B?V0I5aXVIamo2RUt1V2w0bEwzaW5VdVM2ekxmWWNKRDJKV0w4dkZHVHo4Mko3?=
 =?utf-8?B?SUZxd0tBNVFZV0FFWGxWT1drMUNVVElPUWVNOXlOeHN4TWdOdGg0Mkx3NlNN?=
 =?utf-8?B?TzdrcDAyV0FINDV2bmpYV0hWbHliUTR5K0NYOFg5bTRKYllYNnYxSkhjbXVT?=
 =?utf-8?B?TDRoeHdVWjR1bXpOcnhLMldweElxZU9HTzBKK3JkbTFHeGlMZjJSNmkxcHFW?=
 =?utf-8?B?NEdnZ2dWc1lNUUhwam1hUmloSGJWVXVZNGpQUk1CUlk3ZTduNVZIaGs5WnUr?=
 =?utf-8?B?TUd4dlIrQnc3K1llSGVMaUUwMElCSW9YbHIvaTRIQllUTWhydkQxbm1yT0Fp?=
 =?utf-8?B?TGxQSCswLzViRzBvTmQyZW1DaWdWUkRyZ0dlQkZJaW8wMjdUV212K2VSdFFm?=
 =?utf-8?B?UzFuR2ZkWXJFRSs2RmlzZGdjS0crcjZaWVJ6MklvYTk0ZStSdUpRMTNRSVNm?=
 =?utf-8?B?WTQ3UG1CNUVZdjVxT09MU0JuWnJ3Wk8wWitlZUVOM1RidXJvV0pLZ093aTIv?=
 =?utf-8?B?cVZKS3VySmM1cUM3a0NjcTRnSStHdVFUSTQ1ejMrMW1mYXFyK0hIUW5qUmlY?=
 =?utf-8?B?ZXpuSHRmS20wZFBGQXZmdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJ3S0lyakdUdjdZQmE4UnB4b0FNV3U0emZkcGxGbmc5WXJTdklUellLR0po?=
 =?utf-8?B?WS9TMTE5MVd5eWdNTlE0ekFvRVVoajlWNWxNSmJqV0tXL3hEMTFQOE5yY0lU?=
 =?utf-8?B?a0UyQWFzZVN5TXY3TkR4OUFsNS81UlduR2xnLyt2N1pLbnE2emdSa2NHaEJN?=
 =?utf-8?B?ZjVYVS9CaFhBVXBjS3pST3NFMHdzSHpUTUtaWVdwbUxpcDM3Q3RvajJVazFa?=
 =?utf-8?B?RCt6a0RDRHl0Qk9IMXJVU0hvRXV4aUlGR2NiS3VmNEJJTkhFZGxQdXFlUnkv?=
 =?utf-8?B?TURvRUczQUpiM1dsbnBxNHZuanZHYzhyM0pTeW9keFZXUklNVlYvalJhblhI?=
 =?utf-8?B?clFsM2s3U1YzcFoxZkkxcEI1SjhVKzlaM2RlSTcrZG4ySENlOVV1Wkd2STdx?=
 =?utf-8?B?M0M1NG1PUVgzS2VjZ3lZWmgyVlBWM2ZoQzN3bWpJY1kwbEVoYjFqOXhCdGdW?=
 =?utf-8?B?TE1XeTlMQ1l5ZDVxV1h3VmJ6U3VQM2U2SWFGTGtETTVKeXgvTUg1VlRmRXNt?=
 =?utf-8?B?RysxK3hqY042M3pkUTR3Tng2VkxCTlRIWi85QUhFMkdzVFI4azA4Wm9Da2ZQ?=
 =?utf-8?B?Q0JXcjUzT2JJTWdNb3pnalVKQWYxTDNTbkRwV1Rna3VCVXFwN2M1UGhBTUFv?=
 =?utf-8?B?WE1zWU1BNHFEWHZiUmNqRzZJa2U5Vk4xd210NGxicUdRNmFKa1pESFlIeFpU?=
 =?utf-8?B?VTg5aWdLN0lweCt6T3RtM1FrTDJlTk5WdzJpbllVR0k4YlFsd3laUDJmL1o5?=
 =?utf-8?B?cGJacFJQT3dqb0NYTzVLVEV6VldsZHZMeHdvcGF4MHFOemxKVVIxMWx0cWZa?=
 =?utf-8?B?YWgxeHlzWkxRMkNUeEJJbkNWNTNieXM2WFMxNitIcThsMjJNYk9SQlU3elFB?=
 =?utf-8?B?SWdxMTFhVFdobTYwK2pqT2NPWmRuN25oZmlYaUFpeVNoTzcybmk1MEFGVjh1?=
 =?utf-8?B?enlWcXFhR3JrUk45ZGkrbG1KaE9VVkdjS21mQ0tMVzNIZkRVTVllSk4yTzJw?=
 =?utf-8?B?TEFCVXZRTEh3M3BYTHB4TVA1UERiNndIUGtJVDhNY1B3YWhIUHYzWXZ4T1dX?=
 =?utf-8?B?MFFQbDRBY2tTQzJYUmVIOURFYk9xd2RIb0tsVGx3RzZEcUVwZDVOd2xBWGNz?=
 =?utf-8?B?Njl0ZlNvMUR1OEJDd05Jd0tsSm8yTDZPRXFjRVJqRHNrNVlDdEMwYUUvMUdB?=
 =?utf-8?B?TzdTMll5UU5KVnIvUlp5REgxUHFNcjBRR0VPNGZLTjhweVg3M3hSUFhLSHcv?=
 =?utf-8?B?aXRtVkgvMGMvT3QzVmxiUmNxdkxlUUVqQjhVWEsxTnlvZkpkVmVMeTFhQVl0?=
 =?utf-8?B?RmdsTUdNQ0l3OTE3bGVrRmhIaUprUWNhWHFVRzQwUjcyM0JTSk0zbXBxczdm?=
 =?utf-8?B?QXAzT05KUC82TWR6b1lMZUdIZWRjc3VTY21pbVMzWVFGTmJwY1JLWUUrYmRw?=
 =?utf-8?B?LzdHSEJwZDVTZjJmcTRvRlNtY2hQb3c4OXVHRW9UOXcxUDdjUGJteDgxa21J?=
 =?utf-8?B?bU1UTEdFeCtkVk1oaU5OZXBhdXhnZFlQWXV5OFpwMFh3Yk1vL0JLRzNtS1R0?=
 =?utf-8?B?NWh4ODJTQXZzanNjckxBbzRsUCtiSi9HMUx6UjY5MnhDSjdFNEhWVU5JdlI4?=
 =?utf-8?B?OEQrM0NqRUJsQURCN0NrcVVOOWtFTExuaDB0UUs0cnNYYXhwa3dGS29FMmpl?=
 =?utf-8?B?K2NjUFJqTVp6KzVGSnA5ejNGU3ZtVUo4bUVreGt6TGlqUUdsemZ4Q1FHTzZr?=
 =?utf-8?B?emVGR29LZE1LN3k0K1FlSFFrdGRGTUROYldVeHoyVkZtMjFhU2xtZXl0WkZV?=
 =?utf-8?B?SnkxTDViaTY3LzNKUjBWR0hKVUg4MjJPdm94SFBkU2I1UVdYWDJtZWNsNHlP?=
 =?utf-8?B?TWduMmFJTEJSaUEvdVpBZDhUWUxaRWx6cFdiRHBFTjZYeTFVZUR5MlVmb3dJ?=
 =?utf-8?B?OElodVR4eVR1bk4xcGJpNUZmRDFDVDFDcTFGbDExNmVHZU55djJNM3gzeE11?=
 =?utf-8?B?NUhpWFJpbU10eU1nNGhpYTNTd2g3RHkrYjJXT1ExNlM4bWYrWWs2cjU4TzZz?=
 =?utf-8?B?ZU1GTy9la0ErQmIzZUlRWXJhandkWUxmR1UrOUtINUlMTG5DdzlpR2xBTkJJ?=
 =?utf-8?Q?2pZKtIuBGZgMjCqKacPLdW/xc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4065c1-0d7f-4588-c46a-08dcbd83401d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:37:39.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU2cyQm58JCKU6YQ2YUr+qnaucCwjxEMtoSZncYbzhrIu6NGlMK4Lt5AwOS4pAIjm+fOBBm0yEwA7CtUHH+qiu7s6/nrLXk6zISDOFMVeJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
X-OriginatorOrg: intel.com



On 8/15/2024 3:16 PM, Freek de Kruijf wrote:
> I have the following bash script:
> 
> #!/bin/bash
> getipv6() {
> nmcli con modify "Wired connection 1" ipv6.addr-gen-mode eui64
> nmcli con down "Wired connection 1"
> nmcli con up "Wired connection 1"
> /usr/bin/ip -6 a
> }
> getipv6
> 
> When I run the script the output is:
> 
> Connection 'Wired connection 1' successfully deactivated (D-Bus active path: /
> org/freedesktop/NetworkManager/ActiveConnection/23)
> Connection successfully activated (D-Bus active path: /org/freedesktop/
> NetworkManager/ActiveConnection/24)
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
>     inet6 ::1/128 scope host noprefixroute 
>        valid_lft forever preferred_lft forever
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
>     inet6 fe80::dea6:32ff:fe55:12be/64 scope link tentative noprefixroute 
>        valid_lft forever preferred_lft forever
> 
> When I run the command "/usr/bin/ip -6 a" the output is:
> 
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN qlen 1000
>     inet6 ::1/128 scope host noprefixroute 
>        valid_lft forever preferred_lft forever
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
>     inet6 2001:4c3c:702:b700:dea6:32ff:fe55:12be/64 scope global dynamic 
> noprefixroute 
>        valid_lft 4126sec preferred_lft 3466sec
>     inet6 fe80::dea6:32ff:fe55:12be/64 scope link noprefixroute 
>        valid_lft forever preferred_lft forever
> 
> Now the global IPv6 of eth0 is shown.
> 

Most probably nmcli takes time to actually configure the interface and
assign an ipv6 address. I do not know if nmcli waits for this to complete.

You could see if adding a delay between the nmcli and ip invocation in
the script?

According to nmcli the default wait time for nmcli con up is 90 seconds.
However, it is unclear to me what "up" means, and it is quite possible
that it does not include the assignment of the ipv6 address.

Thanks,
Jake

