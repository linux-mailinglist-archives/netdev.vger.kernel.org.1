Return-Path: <netdev+bounces-174409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD17A5E7BD
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DEF3AC928
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EDB1F12EA;
	Wed, 12 Mar 2025 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4C62M8C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA371EE7D9;
	Wed, 12 Mar 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820274; cv=fail; b=Khkhox9qm2wEFwXI2jeNS/0PvrPX8Sr7FAjqvw7nFxLdpMX6phDwpxFtCYa9x1br9Kae1Z1uY6EF8Bip18SwvjMyvAPVOWahk0JbLEkYZpkQuPqoNIvmIxKDryxDMo6TPhDB69NGVAAhZQkLK0jmaMmE5FgKn8KgKKyYqCGUuIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820274; c=relaxed/simple;
	bh=nCMmD8VpP5OSZI4cG4jmW6+3jHza+ja8fpeaMRFczOo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iRH8YslAKUOGZ8z+tMIq6viJRyk0eFiwC6/+7Bm3pm87NfZU3oKfzCB+8JjrkWwtIp5DTT8Orws0nXeL1hKhNT912obZ22fDeX+dQsNCQLWiI4dn3SYRZatg2kzWrUXfXQ3G8EHSGjIz15CwQSROx4H7X6uPY6CBekqsEoLCtRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4C62M8C; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741820272; x=1773356272;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nCMmD8VpP5OSZI4cG4jmW6+3jHza+ja8fpeaMRFczOo=;
  b=g4C62M8C+NV7fVNT2VUipHD7M4m3Y+CFlT7V6TsxsSDkoQFi4RVU7kdm
   8cdkXHDqaElhpa1aC3JrrETrRxEEAuNiRf3r+zaszF1hOtfpZUqxEjbwn
   6sDBGstDJ6snLnwklPAmMen0q2RWHajJqhuvFjifJbqXspwp1N6bMLgNa
   QwsHvn20v4akZYU36EzyIeYOeNWhZ0kycapzXYjMRcMkNI69CEog48YzO
   tRbUlmEz50szrFYp1lsakXgi/oEeuZZrjhu6bmo9+y5EC8epvA1QYKH1w
   aNl7FzY5mebD93KJ7Ty4X3t6XWFMkCDVPFA/rP3LbBM75bOV+J6ytTXQu
   A==;
X-CSE-ConnectionGUID: XadmAVlxTm63LcAB85cBng==
X-CSE-MsgGUID: tugCuB2ORROPyi07/aGTJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60320410"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="60320410"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:57:51 -0700
X-CSE-ConnectionGUID: +oFyzt8rRwS2d1aqS5IepQ==
X-CSE-MsgGUID: Zk1MhlhTQaev/T1n3NV9Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="120819575"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:57:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 15:57:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 15:57:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 15:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6JfR3C+eOPJoFZA/9m0K4GkiLBe/NarYdmEA4FQ23RfrLLHUnwTiGOqBt6Kb9J3VPNvIvcVOrg+AkgYAptrcRCOBC9as3gKS9jmR1l7nTmUxKU+reGdq+WUEb9Cbxav/7/P0gZzA1+fVVXO7qOe+Gp+jGIxxAkV06uiAUxm3VKFn0gk1sFZHH/96DFTRJa+qnaBRNtATFxApmSfRMrCDlScREo1XGMLWFhrQDZhttuzKq8zovlPCtgDsAPjYzxbA0qm4oYNMj+cGSdDw8/Nh8VS/9W/EP3dua3mPcI9i0GJ0XhNLFUbkGfpO3wUwPkbHB5U4rGFkiBLWBArZLRj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IDk0UvuN2EL9MN/mc6ebXdAFuHgaFyEs4fbNOlR1QM=;
 b=sqsDrcGi8jKNHhqiycKdOz9VBe1kvNsjQmgx41pBvTmDHSHyYQQhGfWXS+2LSA43sw7kq1CbasFhLQHWvDJYmDpfD3vJLnHBAI+tQoaaanDq50Df2sMkHmbBQwJgEYBQrX9QYnH5c4q2ND/MgjP40VrYm+I6slSi5THWRnxIg5C1XEGZxHx+rpoUpYAGKQslLC41t8QrSUYK1vNSAedfGdVkldW3ZUDd0Y8JuYwt0k8VBM2lBEomSXaMiBvB6/+Lq6PotE7ZWESTZjPFG1hBJpQ/TgcpmHqCj4dTofRp64TG3zKiMPQkdZ2jsOAiC/1D7uCSibrdh3zbzb/Gi45ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 22:57:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:57:46 +0000
Message-ID: <76ba2536-8137-4665-a8b5-46b74899bb22@intel.com>
Date: Wed, 12 Mar 2025 15:57:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: macb: Add __nonstring annotations for
 unterminated strings
To: Kees Cook <kees@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250312200700.make.521-kees@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250312200700.make.521-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: a950cfec-14f2-4d2e-2a2b-08dd61b94e55
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC8ySWhYRmZmNTFsWTJxc0o4TXFobHo0YjdCdGhHUVFXc3BzYXFoeFp4Mi85?=
 =?utf-8?B?dzEvaXhSRDVweEF2R0RRWENnc0tYVlNzU09XSkJVcUZHTU50THU5MjhhWnVk?=
 =?utf-8?B?WVloaHpIRTNoZUdKY1gxTy85TGE2dzhKSm8vei9tck4wZHRrMHVvVWVJYnZG?=
 =?utf-8?B?dUJCK3hlVXh2cmk1d2ZURXMza3VpVUY3UUtvek8zNnFoTWFVeVFVOFl4b1ln?=
 =?utf-8?B?a1FMUlZZd0xWSTBxOExKNnZsMGhrM012NmZkTWJ4Q3drREVMUEhKZWh1Qm5j?=
 =?utf-8?B?akxJVGNyWlhUTFpVUXhacmpPN0RCMWpMM1dqUTVJUXVxbmRHV0FmRWRIUDVL?=
 =?utf-8?B?OE42UCtGNDdIcmxSTXFhdlZKU1ZweE53YmlzOWM1NnlQd3Y0UlNyMG82WW9C?=
 =?utf-8?B?U29YL29xTnh4OVArd0gzZVVOQXZCMlNHeStKU3UwL2IwcHBMcitNKzFIUWdV?=
 =?utf-8?B?OHFmcFp2N3FKUDROOEp1QXhJWm9BczU0TjJTdFMrQSsvQWltdGwzUmR1YkFF?=
 =?utf-8?B?MDZKNStxRitHTkFoTXNVU1crY1Nqb0lwSmVNMVI3ZGlVNVRRRU9PSnp0MVp2?=
 =?utf-8?B?ZlAySHN4Tk01bWlNQ0xLaDh0Z0lGVWhxZGZoSXZFeE5zVXVMR2ZEVTJTWmZr?=
 =?utf-8?B?dHRGYnVrZWxRWFVCYXRLdXdsc256MHFMbTdYdngwU0wydy9XTThoMHg5dWtN?=
 =?utf-8?B?YWNtMi9LWE5tV0s3bVQ2ZWUvcFgveXVPbXowR1B1RS80d1h3ckc0MDZJbjJr?=
 =?utf-8?B?V0JUbGVrdi9jbnQwSmNyeHlTRTZZWVU1elIrZitsNG9OdXRaSjE1TmZCZFBp?=
 =?utf-8?B?S21Rd2lJVFVWZ1JKdVBPVU5QNklBRHVsZ1VrbjJlTVl4SWNzclloa3FYK2tV?=
 =?utf-8?B?TzZSaDVpb1N3cDFyVDhDQkMvVzBzUkkwaW9HOE5qZTJDbVNrSXN4MFlVQndq?=
 =?utf-8?B?UFgxQmc2UXNSc25WcTQrVXExMER4RXBCVXN1b0NzWE5naSs3VFlmZkxEdUUw?=
 =?utf-8?B?OWNGK3NJTldveGFTWGIybDR2RmNCL2Fwcng1YytnN1ZyMlB4bXhQUlF2NWQv?=
 =?utf-8?B?VHp1cW9mNUlSSlJKVXR5TERTNUZJTmExT2JsV0lvaklMcFZ6RDlONnpwK1B6?=
 =?utf-8?B?aXdGcHZNTi9YVkxMZWozZllZZE0zNDZBUlRNUk1uck94TzBaVEZHVnZpV2d0?=
 =?utf-8?B?TytGcVlqN1lVcVFSL1dqUTRSNzh4ZjFGMVFBT2RnbDhmdjY0eWJWZ1NiMHZu?=
 =?utf-8?B?dURsSlhXMnZpTlo1UnRrd0NQTTdYbG9NRVdWSE1VSGsvU2RFL3FyVE13WUFH?=
 =?utf-8?B?NG83dU02VzdyOWRXL3JMNDVVR0F5bXU2bXZheCsrQUtiYjNCbXo2Qk1FSjRJ?=
 =?utf-8?B?bnRCaGk3TjZIemZOVnlKWndtNWVlV041V0xpWUhrQXp0dDdCU0FqNlZKbmVR?=
 =?utf-8?B?SGlPRGw4UGR3dFdYQUZ1ZzZJUnNMSHRiTTU2UVhHYnh4SlFDYlRKdnlmdHdV?=
 =?utf-8?B?Vm1mZHVkMFVaV0VqNEVyZ3NCV3JHU1JIUnU2QTBNZDFsVzMrTDBTMDBXWXd4?=
 =?utf-8?B?bXFyaVJyVmhvMHZZVUhlS3pvR2lBTFRVckpybU1EelFOSmhpWVQzMG8wODhC?=
 =?utf-8?B?ZkNvZS9HZ0pUeTBGcGtHU0hVRkpramZjNEtWK0lqRUlxTllzRHFZWnZQcStC?=
 =?utf-8?B?NUx2dXBmcmtqVDA4aVdnVWt4VTNHbTl0WUZBUXJVQUg5R01abXA4TGhhbnlo?=
 =?utf-8?B?UW91Q3FRSlN3dmxtZFFyajFkS1NIQ0tmbGp0R3FVemhRQmpZUzBUNXRYbFRE?=
 =?utf-8?B?VzZOVGRWMjk4QkFSRGJ2THJ0SnQ5Z0s3SFY3Wk5PZFlEYlZCZjdVdkQzNFpW?=
 =?utf-8?B?QmFJbjFCNFdRY280RHlEWlBaa05DaXIwaGUxQ2hHZHBrWnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9CYWhZcm56Zk1MeDgwM2I2eThxdWJ1MFVXbG1XaWVPazlLL1d2TUpsR1Mz?=
 =?utf-8?B?cVFPb2lTcDgxSHZseDV0Nkp3L2xvTXRMU2FFL1RhandiRFNWTEF5d0FzaFVN?=
 =?utf-8?B?djZDVS80VTErczd6RjM5VDB4aVVvMk1YWGNBYXRDYkx6NGZOM1I5eTk4OVV2?=
 =?utf-8?B?RWdPVzJkaTFjekdWL2w4UnBkaE10cyt2U3FKZENhZDA2eWVSYTVvUFVNTTVM?=
 =?utf-8?B?TFpFTEMwRi9rS0U1WnBRek9Tbm8wbWxFMUsxa0RoZHRaU1lNNDNDNHBreEFi?=
 =?utf-8?B?enY5VEdpVU15TDY2eEJvOVEvWXpCanhoUXZUS2RtL2EyUm40NUZkMHdCQ1Zr?=
 =?utf-8?B?U0FST25PZWNsWE9adFpzM0xlNHArL29hZy9taDdMWFV1c1RiTnU0Q3psS2Yr?=
 =?utf-8?B?alhINGJ2TW1ZNlIrRmxkbU9XUU9xOS81ck4zS1BDZWFzajNLODNBQkszbHVK?=
 =?utf-8?B?WG5UWDY3em4xbjM3SENlK1craFNHSEZNOTdkQnVpeExMZHF6ME5DUXU1eXU5?=
 =?utf-8?B?TVlVZE1lOW9EcXVWTTF4MzJFUS9QNlJnWnRLaVQ5MzVsT2lpamQyVFF2UTBT?=
 =?utf-8?B?VVJwRUpldkJHOGlxeGZXMVlPYy9nTmxkcG41SzFvQTZJNEdFZEwzUXdLbUc2?=
 =?utf-8?B?ODVQcGNkUFplaHRoSitHNTRxQVRST0swaWRtOW52N01VQmZpREM4aVcvNFNO?=
 =?utf-8?B?cDVLbWVhbWxzMEQ4UWdLQUk5R29yb2F0NUNhSTh4TEluV3piZjBySUNSR085?=
 =?utf-8?B?bmtXcU5tOUNEdm9WU1dvdUVnbTJnU0IzQ2hrek9INXhyNjNYWnBrY1BiV2Js?=
 =?utf-8?B?VXRRNENPT0RkOVZVS0c2Rkt6SFBKYUtSem5RUURoR1NNejlqMkhuYmhlS2Zv?=
 =?utf-8?B?OU5IRlBRZys1NjZFZktiVHFFcHNVTGNpWktqZG1WNnZjekdVL0NoaHlZNEZi?=
 =?utf-8?B?OFdoeXFDbUZ6WUtEcWp0b0RaamxrSVhxRjBtL3BPcWgzeVhLQXZXNmFGV01q?=
 =?utf-8?B?OWc4SVJzNG9raUZ2KzdWMzhCdkJUYXo0c1o5WWgveW5RZnRSZm1lWi9ubk00?=
 =?utf-8?B?WjJZUk5YRzF6U0oxUXVlaW5lWmhaYTJCNVFhdWU1YXFDVEduUy9ZbzYyMnBY?=
 =?utf-8?B?c3hFRDNiZjg3Vy9YaEdSVThuenlRU2RyTlFrM1h6Q2FIYndrcFBIc0c3NjlI?=
 =?utf-8?B?dmhJSGZxYUJNNHZZYjZkSFZPNExrWklxMVk3R3pCTXFiWUgzU1JCRXl6Zzh3?=
 =?utf-8?B?S25aMEZXSzBNUzVCRWhiSnBTTmZtWkFGdHhBdnE5WWkyL2FVM2lOYmhnc0VM?=
 =?utf-8?B?cTJTS1QyekVkbFFidUdtZjdsSDBhWnlJWThuUG9KZm50Q1Z6dFMzaVpxNTVS?=
 =?utf-8?B?YmEyczI5a0tFbksrK1htTFBPQU9IQ29pZWxTdXg3QytDZ1Y4VS9WS1huUkx3?=
 =?utf-8?B?NCtyeS9GejJYT2xrUW9iNElOemo0Y2l0RXFzRWdNcHpYTERYR0F1bE1XKzYv?=
 =?utf-8?B?QWhRc0RmSmlRSllxakdKbGxjVWZvRjRZU2JKLzlVeG8xKythNEVMazdZaUlQ?=
 =?utf-8?B?VmRqWE9ocGpNWGI3VzJERjMyMmFLV1JLUm1XNGxlTEN6OTdMSlo5MlFJaHZk?=
 =?utf-8?B?UTdLeWV1NG1nMHpuWkNFUGtLNkdSMHNVWTkzQ0taS2R6SW5hd0RYSmd5eDc3?=
 =?utf-8?B?eFhHREZEcTV0VStHcGYwZDZZWUtYMWZGcTJCVDJnK3VCdjNLS1kvb2lrN0F3?=
 =?utf-8?B?cWsxeUc4MTRTK3MrWVR2alZEZVRyL1RTeWx5bGY4RWZnRlBabTNDaGNuWEZT?=
 =?utf-8?B?R3k3YTkxdUZWOXRNbk51STQ0djR2dHNNSTE2c211ZkNYN1ZIdzVzTjZQUFlB?=
 =?utf-8?B?T0Z5V3BnUVFXbEJ4RnVmTENEUmhEMjNIei9oZndFdko2czN1M3htTnlIT2Vr?=
 =?utf-8?B?TFgxTDBKS0lFek01Q3RoYUVRS1ZDdUZva2JtTjFDaDdQWjRZMmVVbHZFd3JX?=
 =?utf-8?B?bTVGNlNGRjV0dENsdHNlVlN3WTZXTVFMOG9idi9LZmJONWVwMTdIM3dPN2Rz?=
 =?utf-8?B?S241Y1VORTMzQk9ZM3JYMkRJTDJicWxqMGV2Nk5sQ0FQVEJySERpTmR6dU1Y?=
 =?utf-8?B?NGpJczViZHM0eE9TdjRnYjRZMkJyZTNYN3NaVVQ2YjNIMGpDcU8vSkNSdlRv?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a950cfec-14f2-4d2e-2a2b-08dd61b94e55
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:57:46.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVZLE7+fgUZDr4GXjF5MqEyAot+r9B+D+OnzP0B+rijjf1HdgBOFoi5vjHVbbPQbi4gevzpUuz1DcV9v35EyWe3U7+e5wYKMX7iwRjRcTGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com



On 3/12/2025 1:07 PM, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to correctly identify the char array as "not a C string"
> and thereby eliminate the warning:
> 
> In file included from ../drivers/net/ethernet/cadence/macb_main.c:42:
> ../drivers/net/ethernet/cadence/macb.h:1070:35: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
>  1070 |         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/ethernet/cadence/macb.h:1050:24: note: in definition of macro 'GEM_STAT_TITLE_BITS'
>  1050 |         .stat_string = title,                           \
>       |                        ^~~~~
> ../drivers/net/ethernet/cadence/macb.h:1070:9: note: in expansion of macro 'GEM_STAT_TITLE'
>  1070 |         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
>       |         ^~~~~~~~~~~~~~
> ../drivers/net/ethernet/cadence/macb.h:1097:35: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
>  1097 |         GEM_STAT_TITLE(RX1519CNT, "rx_greater_than_1518_byte_frames"),
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/ethernet/cadence/macb.h:1050:24: note: in definition of macro 'GEM_STAT_TITLE_BITS'
>  1050 |         .stat_string = title,                           \
>       |                        ^~~~~
> ../drivers/net/ethernet/cadence/macb.h:1097:9: note: in expansion of macro 'GEM_STAT_TITLE'
>  1097 |         GEM_STAT_TITLE(RX1519CNT, "rx_greater_than_1518_byte_frames"),
>       |         ^~~~~~~~~~~~~~
> 
> Since these strings are copied with memcpy() they do not need to be
> NUL terminated, and can use __nonstring:
> 
>                         memcpy(p, gem_statistics[i].stat_string,
>                                ETH_GSTRING_LEN);
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  v3: improve commit message (Bill), drop whitespace change (Bill)
>  v2: https://lore.kernel.org/lkml/20250311224412.it.153-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20250310222415.work.815-kees@kernel.org/
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/cadence/macb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 2847278d9cd4..d2a4c180d6a6 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1027,7 +1027,7 @@ struct gem_stats {
>   * this register should contribute to.
>   */
>  struct gem_statistic {
> -	char stat_string[ETH_GSTRING_LEN];
> +	char stat_string[ETH_GSTRING_LEN] __nonstring;
>  	int offset;
>  	u32 stat_bits;
>  };


