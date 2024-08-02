Return-Path: <netdev+bounces-115329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE1945DF8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE22C281BEE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B01E287E;
	Fri,  2 Aug 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsNwiewh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264121E213E
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602525; cv=fail; b=l7+34gURPr8SYd0mMzDlMIeQOrSMB0hECahBmefSF/uC3d20pHK1Udg5HGntiZjf9V+Z1zcIkyhya0wtaBB93eDS0S1+5O15nbVPrvy1vIKJX0txuGj/zv+eGvQPoHNHXZ34j1PrJb4Qjf9YaUArvJgYHVkF8mzPBptty48cAFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602525; c=relaxed/simple;
	bh=3Jjn+W9kysMEEDo0DYPSKacC2Hc/1NvH5AzJ/KpfvjI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rmCPXcNMIVyIGbrB1s5/KHuwdBQjH8iCu98dtmFMwoGk5vSwNpzedmPBmLJaqV/wKPiVgSiy06rn1XXroUKGz23zij0M2uHea03Nyhd97mP0RwO4Om0IRvEAYUCLyMj14vE4MvXDiYaBr2/M2LiUE4zB5Bped4I7b3kkJDp8ZMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsNwiewh; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602524; x=1754138524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Jjn+W9kysMEEDo0DYPSKacC2Hc/1NvH5AzJ/KpfvjI=;
  b=SsNwiewhl15iZ8JUJpWtqvwotDDLvif3DhJuImyOynt3TN0uw0SCIVv+
   9wdE5AnORdUZgXQCIVfXHuvrECHzVxaKG/xYlXbaE6drCpua0ICGR3/VB
   L7YGE7zCC8Y7+tfR954Qxf0cXnnaq2jM5LgjbSYVlmVOmflpaaCGFqx76
   qXp52T2JCSdAMnp9ksqf6gEvavLDwLqxv9yakVgVFfbDz8GRJWICzBvEM
   6DNlIMNgZ7MKboHzdSziRwr2Wyi/9KlkcSBN0ejqsfnAKaFAj18uG6eMZ
   JEEC2T62Ueoq62l6IKcNvNDNFDyh6cSCyNEqX4XR5mPzSS6TVtPBjag0u
   g==;
X-CSE-ConnectionGUID: xS14oBWoRXiWXBkbo6y6tA==
X-CSE-MsgGUID: 3LgZnyqXTS2nbk0xYW8gIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="38081205"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="38081205"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:42:03 -0700
X-CSE-ConnectionGUID: wRf1brAGRg21wYG5Blu+mg==
X-CSE-MsgGUID: 9AAq2h++RWizGin0ue48YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55628854"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 05:42:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 05:42:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 05:42:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 05:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf3rIbwrIdDrPqjjqmYuT+Z7bSIsLUmOqvPTfpiGeLMMD1W9RtutAxNKZmM3rTbBi3dz0SsvQB05P2PqrQkMu12zfD0bA5FC6+vDgnohOrugmlZdEn55u1JU2QKi0mH++lD2LYq2nA0la/8jTc4urK8xPaW6fkVHe4s7lzL3XO6tR2iVH9Mxp286Pd/L7x7i+B1/we/Wv4DtEpxCSvL9v7Qk5KeTr8ocyTUl+LgORTXO6ln7KMmARLu8eBkdQuD1reNqWMUTV0wVu+OoZrxwmQxOF/+8uhKGnYDSWO5/J6tDFjEBmaTQo9HoOUDmZpuay2l9mngyravNcT1JUOlGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsStXf+/xBTI5FQOd4GZsGSmLt5RKs1Y51ZKLYqiAko=;
 b=WXQGIj+s1MGgNFBu9NO1kO8+C9TVnAMTu7Ikz4ene27OQA8/UlobsI+jKuCogJCvlsGiS9NhCpf7X8B3QwbBHlkM7n0DjeAyaFv1MVKMDThmlcHVnvZaz1onrvpRBT2qP2iApb1icIGQxQEAXlTrAFp3QduQKjiOF+flcXHEUyoVWAr+o2eD4Od4ddbgQK22XgPS8ht0Dvt1yyEf3Tg6IO7H8k4Lqzj0P9ATZ0bWn+5dian+XWatps7wUCStrM7U3OWUNT+q78960cOg/oKLe4sLSUxvjxKpRlL992+TL7ChyVbWESZLpKcKJ49bzVee/ZMWr/EXgzhYAJBwRvMmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 12:42:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 12:42:00 +0000
Message-ID: <a146a6cb-9828-4c2e-a5ca-ccd6af8af040@intel.com>
Date: Fri, 2 Aug 2024 14:41:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next v2 0/7] ice: managing MSI-X in driver
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: <netdev@vger.kernel.org>, <pawel.chmielewski@intel.com>,
	<sridhar.samudrala@intel.com>, <jacob.e.keller@intel.com>,
	<pio.raczynski@gmail.com>, <konrad.knitter@intel.com>,
	<marcin.szycik@intel.com>, <wojciech.drewek@intel.com>,
	<nex.sw.ncis.nat.hpm.dev@intel.com>, <jiri@resnulli.us>,
	<intel-wired-lan@lists.osuosl.org>
References: <20240801093115.8553-1-michal.swiatkowski@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240801093115.8553-1-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV3PR11MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 55470c49-1af8-4035-f965-08dcb2f080cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHYvWFVEWWxnby9xdnEzMmd5THh6V0duQXl4UGJENWFlRXJsTyt2K3BTZGM1?=
 =?utf-8?B?QkZKenhjUGpzc2F3bGxGQS9CL2NkcE9iZzcwaE9UVVVXSW81SVU5WkxKNUs3?=
 =?utf-8?B?bUxMZ01MSFJHc0JQbXIzWU9yVUFpU1crOXhNUXBuQjEwc2RQM3NCSHcxSHc0?=
 =?utf-8?B?ck5SL1J2bk40UXQyR2FtSkNVaHAwSVM3RncxcnBrVWluTTl0amxqcDZ2aGZC?=
 =?utf-8?B?NnIvWjJPanZxTTRMdDdXNDh4S2lBaUtYa3VUdy9kQ0diNUxMZiswYWRGVVdj?=
 =?utf-8?B?dlowOFJ1SFV1N0VFaDVGUXU3c0w2VlJtdHZzcW52TTJsUjgweDhQekQ1S2RI?=
 =?utf-8?B?aFFBalRJS3BVRkc4ZFhMTHVWaUhEK01zNk0xRUgzd0NWL0ovdXRzOXk0eUtt?=
 =?utf-8?B?TUR6UkVwbzVUTUo5SWFtdnJuSzk1R1RsdGtXeCtGTzhWTUcwV1M5a25DL29J?=
 =?utf-8?B?QmFNdmRmbSs3eHVCaGdyTEJpWTRVUXJjRkZ0VC9rVElIUGVMSGVRR3FocENG?=
 =?utf-8?B?UHZyVTVoSWM3bmtjM1hLY3Y2eElsVEFjRzREaDc0cTZKdnQvd1hpR0gyS1hZ?=
 =?utf-8?B?M2VnYmdDK2JUOU9nWUV0WCsxYjRKTjZ1aDVSWFB1ZGdCOUU0V3U5ZCt6eVF1?=
 =?utf-8?B?RmlpckprRk16OFA0N3RRZHdtK0lSZXAwK2VUTjl2azk3MEFuT1FYczZSOEpB?=
 =?utf-8?B?U05Sc2NHUm9ORXhhTzRyeWxUMmMyTXVJWjFnMzdUWmtYUjJqOHl0QnRZWkpP?=
 =?utf-8?B?L1ZBdUdyOU1URmdleHNPejBnY0hhVUM1RUUvZFQ0UlArMEQvWjFNWUxxb1A1?=
 =?utf-8?B?WmhrenR1L1BiVVdDNFRoZ1FibkVuckVlUTQvMDJKcmlyWVU4Q0VQZytpNHBz?=
 =?utf-8?B?OHhKWVdsdGdNUTV0RUJKSGM2NEgzRUdjTDNvZFJKTEE3bUw2cXRtTlg3Y2VU?=
 =?utf-8?B?SWJ0ZGFtWnR2RTQreWlPMldRK2RzZHFmR3A4akNIdzBSTEpmTnJyQ25IR3VD?=
 =?utf-8?B?cEhUUEE5YmM3MXRhcFJqZlVVaHJzWUFCa1MreTFnU0xDeHpGSmtGSTlIVytF?=
 =?utf-8?B?UnAwenFnNmFGZUhSQURqa3BHQ1hrZ2ZEQzg1b3NnTGt5N2x6b2wralg5SE91?=
 =?utf-8?B?UGNRREhaeEJxWmxrcU0yd2pMN0xBWGdoK2VSVmROQzlJVG1XSkhrc0c4SVAr?=
 =?utf-8?B?OVYzZEhaTnFUVDBpNG1xZ0ptQ24xcmNycm5pSEUyclQwS25LRzE5cCtKd1ly?=
 =?utf-8?B?dWRKOW05Q0NsNUN0VTkxNHhRM0t5eXR3N1ltcUdYeEpwUFdUZEFSMjRQVlg1?=
 =?utf-8?B?R3M1YTZ1c1pIUlBiSlJRZ21vS3VoZGR3SWdSV3MyN1d0cW9JTHZHeUd0T3dH?=
 =?utf-8?B?d3hTQjhhUVFDbEtySnoyQXZQNjN4OElGWXZILy8weFhKSHpnNkZWOFJBV2Yw?=
 =?utf-8?B?NmFRU3VIanNxeGxQTkdaSldHdXQ3TVV3TnpRR1ZTbG5yckErazRaSXdPSEhG?=
 =?utf-8?B?dDVKcjNrS1FneXFpdUNVcHhFTXJISXJaTHVZaFRnZG8xRTZra05MdHRFRm14?=
 =?utf-8?B?OEV2M0t0NVNxWmtnOEtnbGdkdGloVktwV3A1WTlKQW9INE5BcGo3Qk9QdUky?=
 =?utf-8?B?ekMyOVVFRjQyUE5LSGJXUDN0SjN1Nm5sV3RJRTByV0JhR09YVGNWakJ6NjEw?=
 =?utf-8?B?Ym9WN0VIQ1VhZEwxcTlsOXNMWE16U2NidVZ6OWJOSlo1OGZqRXRjN09DdHNW?=
 =?utf-8?Q?kUnHkjPV0ljr/NEoDA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdBcHRDZ0hNVUVPMGNib0xzQnRoSlNHR2trcExEVWNzVnBEVG1NQ1RXSkxz?=
 =?utf-8?B?U3VXRGRhSTFrN1BiTmp4MENQQTJ5RDJLYTUyTXJKU2VFQ0dvRFJLcVpyQ2xS?=
 =?utf-8?B?a2hJZ3BQZEJaZ0xNTWJIdjBjdThjaS85MS9KK3NoQXVSamZMOFhkWXhsZzJy?=
 =?utf-8?B?REJyc2hQN3dQcWlDak1LWTR4aWlOM1lpWXZpWVFLY3NBVlZUN1A3YjZwUHBa?=
 =?utf-8?B?dmpxNFUrK2FqamxwZTJvT1BxYWpEQzhaOGlXNUIzMzd2M1MzQ1V0SG1ER0Ir?=
 =?utf-8?B?Qlc5STI4alQ1WTdzV09MalozYm55dXhZYmJoL1l1ZkZsUGtpb1NMNkVYclNB?=
 =?utf-8?B?amZOVHhPT29RTkkvaXJyMEwvWmlNU0s2RjVnamFvR25TMVFnazIrTkZBRFdB?=
 =?utf-8?B?ejdEeDQyejhkOUtpWDZHSVlqVTEvMHBndWJXSFNsVHVxQ1FURHA4bUowZUZT?=
 =?utf-8?B?RXZIRU83TDNWampkY3Bid21IRFdUVHF5Z3Jnb0pXQ2ZiVFdrVytVNzVwN2FO?=
 =?utf-8?B?T05INmY5UVlncy83N0J2TVJGbjRLeXJzVVlKQVFoQ3lIZEgzcmptT3ZxTGlD?=
 =?utf-8?B?QzRvVUtvOGNRLzJ2MUJWRlE0MEw5TkcremVPRjNKc0trelkrYnBkdnZ3WjdZ?=
 =?utf-8?B?SyticmJhYUtBaHM5SmhXME9ZT3JoU3RqT1o2d2tHR1czd09EcHpBMjRwazJn?=
 =?utf-8?B?R0VMWk9EdjRmQnl2dmtnM0hKNDQwN2dWZkVmNmRYTSthWnNPeGkwWU0zZlhY?=
 =?utf-8?B?V2J0TG1oUzRUMTNUMVB5VHcxekRQRDZIQzdSY2tDZThQUXdiUGI4Z3lNSGg0?=
 =?utf-8?B?MjJDNkFJemZhQXFrV2JDNk8vQndlMGVqWEQ4aTc1Wm0wUkNVOGtSdTkxNzlj?=
 =?utf-8?B?UXg0MCtrTGtnV2NoYWQ2aGQ3NElqWXkvUGZXVWthbzdYcWpZNjdXTjVkS2RF?=
 =?utf-8?B?RFBxbUNObjlIWXJIYnBmT1hjWHRtbHlraHJLTE9kM1ExSFRENjNONU5ycDND?=
 =?utf-8?B?K2txcFNpWGpXdmlFMnlvazBCZXFDa0gyc0wvVWVaSjJGYkJ3b2hCdjZPZDdp?=
 =?utf-8?B?QmlleVJzQ09yVWtrYUhsVEtUcXlJelkyWHFqamJtd2UxTHhtSDZKbS9sVUFp?=
 =?utf-8?B?UGI3QW5ObzVyTForSDY0RmljT0F6dW04bzI3VThlS3NrSW0vamdlczFQRGlH?=
 =?utf-8?B?M3BrTUtWVm5EcTVQOEVjSTRqS3lNd0Q5T1plVWZMVVFkVnBSRGVRUGpXYnEr?=
 =?utf-8?B?eHRwbW5OcVhUQ3FkNUtuanF0cnJnSzRkMEo3K1pXM0NaNDZoRWxxZHRydWp3?=
 =?utf-8?B?VDNuMklYR1JUc0ZianptTWErL2kyc3g0bk8yb1pXbkNXSFR2VHIzN1ZyaHRP?=
 =?utf-8?B?Y3JQWExlc2k1NHBvcHRLVEk1Z0Zvd24vNVY3ZVBHbHp6WTRmOUdlVzVubU1j?=
 =?utf-8?B?Ymk2cklKc2xnNEZKMFRtSHAyNG5yc0dzS3lWTzd2T1lndzZ4OEwrd1ZwQjZo?=
 =?utf-8?B?clBRQ2M2WFl3SGFuSnJUZ0N2VVFIVGJZZWdSL1RaOU1NMnp0VmkrRU5kbnRq?=
 =?utf-8?B?U293TlBXY2JPd0xjWTUxbHBEZ00xQmFaZjVOT05KMW8zT0M2ZGNqT2dXWFVV?=
 =?utf-8?B?ZGZsc0FWd2x6RGJFVEFXN0ZtdnlqbmVGN3lNQlJlTzNEdjA0bnhpR1h0a01M?=
 =?utf-8?B?dTh3WHN4V3NnT1VHMTF4S0pKVWttSmZnRXZJM1RuOUtkRXJST1NVWEFNTVgw?=
 =?utf-8?B?RXZRUmpKR1JSZTQ3MkFUOTdBWFVLSEFvREJLRDRWajBReUh2QTNEYVpEQlh4?=
 =?utf-8?B?R0Y2eEovY2k2Rkgwd3JWSUttVEYyRHV6R0pMZVE0MUdSRFJaZ0VpOU9iQ3RG?=
 =?utf-8?B?SVF0dGRoWk5ZRWc3WitRaXViNklzMzBHN2taOFZhNkU4NWoybGt6UndzMVQw?=
 =?utf-8?B?WkpHekVOWmtIN01WOXFTb09pQmZZOEpJNXRheXhjSmhSOHlJOWk3bGE3dVVw?=
 =?utf-8?B?dlpIMDUxdWMyYzFweXMxTGRiTTQ5bmVHMGRMeTRvcXBib1NTK2FFYlJHSXAz?=
 =?utf-8?B?WkVYNUxzd2JvVk9TYXExUHV3aGEyZCtlL0lHMkpHc2c0d3IyMkIzZzIyY3dn?=
 =?utf-8?B?dXdIamRiaTRoWEpzamhhcWl6dlFlK3Uwek1pRU5uTG04RmdicnA1TDQwWldE?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55470c49-1af8-4035-f965-08dcb2f080cb
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 12:42:00.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTgY0t6Es02CLAJ44NccxyXGLrYha9g99zaOV4C5PHr90cCTbvB5FfyQPPjSe8O491SdJthsLvxZH1q8FEkmfBN26yoyKztGNBe5w//pLIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com

On 8/1/24 11:31, Michal Swiatkowski wrote:
> Hi,
> 
> It is another try to allow user to manage amount of MSI-X used for each
> feature in ice. First was via devlink resources API, it wasn't accepted
> in upstream. Also static MSI-X allocation using devlink resources isn't
> really user friendly.
> 
> This try is using more dynamic way. "Dynamic" across whole kernel when
> platform supports it and "dynamic" across the driver when not.
> 
> To achieve that reuse global devlink parameter pf_msix_max and
> pf_msix_min. It fits how ice hardware counts MSI-X. In case of ice amount
> of MSI-X reported on PCI is a whole MSI-X for the card (with MSI-X for
> VFs also). Having pf_msix_max allow user to statically set how many
> MSI-X he wants on PF and how many should be reserved for VFs.
> 
> pf_msix_min is used to set minimum number of MSI-X with which ice driver
> should probe correctly.
> 
> Meaning of this field in case of dynamic vs static allocation:
> - on system with dynamic MSI-X allocation support
>   * alloc pf_msix_min as static, rest will be allocated dynamically
> - on system without dynamic MSI-X allocation support
>   * try alloc pf_msix_max as static, minimum acceptable result is
>   pf_msix_min
> 
> As Jesse and Piotr suggested pf_msix_max and pf_msix_min can (an
> probably should) be stored in NVM. This patchset isn't implementing
> that.
> 
> Dynamic (kernel or driver) way means that splitting MSI-X across the
> RDMA and eth in case there is a MSI-X shortage isn't correct. Can work
> when dynamic is only on driver site, but can't when dynamic is on kernel
> site.
> 
> Let's remove this code and move to MSI-X allocation feature by feature.
> If there is no more MSI-X for a feature, a feature is working with less
> MSI-X or it is turned off.
> 
> There is a regression here. With MSI-X splitting user can run RDMA and
> eth even on system with not enough MSI-X. Now only eth will work. RDMA
> can be turned on by changing number of PF queues (lowering) and reprobe
> RDMA driver.
> 
> Example:
> 72 CPU number, eth, RDMA and flow director (1 MSI-X), 1 MSI-X for OICR
> on PF, and 1 more for RDMA. Card is using 1 + 72 + 1 + 72 + 1 = 147.
> 
> We set pf_msix_min = 2, pf_msix_max = 128
> 
> OICR: 1
> eth: 72
> RDMA: 128 - 73 = 55
> flow director: turned off not enough MSI-X
> 
> We can change number of queues on pf to 36 and do devlink reinit
> 
> OICR: 1
> eth: 36
> RDMA: 73
> flow director: 1
> 
> We can also (implemented in "ice: enable_rdma devlink param") turned
> RDMA off.
> 
> OICR: 1
> eth: 72
> RDMA: 0 (turned off)
> flow director: 1
> 
> Maybe flow director should have higher priority than RDMA? It needs only
> 1 MSI-X, so it seems more logic to lower RDMA by one then maxing MSI-X
> on RDMA and turning off flow director (as default).

sounds better, less surprising, with only RDMA being affected by this
series as "regression"

> 
> After this changes we have a static base vector for SRIOV (SIOV probably
> in the feature). Last patch from this series is simplifying managing VF
> MSI-X code based on static vector.
> 
> Now changing queues using ethtool is also changing MSI-X. If there is
> enough MSI-X it is always one to one. When there is not enough there
> will be more queues than MSI-X. There is a lack of ability to set how
> many queues should be used per MSI-X. Maybe we should introduce another
> ethtool param for it? Sth like queues_per_vector?

Our 1:1 mapping was too rigid solution (but performant), I like MSI-Xes
being kept as a detail and [setting of them] decoupled from being
mandatory on [at least some] flows. Tuning the mapping could be useful,
esp in heterotelic scenarios (like keeping XDP stuff separate). Could be
left for the future.

What happens when user decreases number of MSI-X, queues will just get
remapped to other?

> 
> v1 --> v2: [1]
>   * change permanent MSI-X cmode parameters to driverinit
>   * remove locking during devlink parameter registration (it is now
>     locked for whole init/deinit part)
> 
> [1] https://lore.kernel.org/netdev/20240213073509.77622-1-michal.swiatkowski@linux.intel.com/
> 
> Michal Swiatkowski (7):
>    ice: devlink PF MSI-X max and min parameter
>    ice: remove splitting MSI-X between features
>    ice: get rid of num_lan_msix field
>    ice, irdma: move interrupts code to irdma
>    ice: treat dyn_allowed only as suggestion
>    ice: enable_rdma devlink param
>    ice: simplify VF MSI-X managing
> 
>   drivers/infiniband/hw/irdma/hw.c              |   2 -
>   drivers/infiniband/hw/irdma/main.c            |  46 ++-
>   drivers/infiniband/hw/irdma/main.h            |   3 +
>   .../net/ethernet/intel/ice/devlink/devlink.c  |  75 ++++-
>   drivers/net/ethernet/intel/ice/ice.h          |  21 +-
>   drivers/net/ethernet/intel/ice/ice_base.c     |  10 +-
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
>   drivers/net/ethernet/intel/ice/ice_idc.c      |  64 +---
>   drivers/net/ethernet/intel/ice/ice_irq.c      | 277 ++++++------------
>   drivers/net/ethernet/intel/ice/ice_irq.h      |  13 +-
>   drivers/net/ethernet/intel/ice/ice_lib.c      |  36 ++-
>   drivers/net/ethernet/intel/ice/ice_sriov.c    | 153 +---------
>   include/linux/net/intel/iidc.h                |   2 +
>   13 files changed, 287 insertions(+), 423 deletions(-)
> 


