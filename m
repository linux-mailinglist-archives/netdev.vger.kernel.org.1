Return-Path: <netdev+bounces-236068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1CDC3835F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F7284E11B7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31132DAFA2;
	Wed,  5 Nov 2025 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgdirQkj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18893296BB3;
	Wed,  5 Nov 2025 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382330; cv=fail; b=MWoDfKy0GmQ+GKX+jw2IC0yCVD9DluURrc0vTxvrrIQPW9kNI+oppqJ7cWP92nL02Pn0eIYoVjgUDkoZGeGD9IFnRugIoi8+D7dLCsdq2ULWhkxBmwryd6DV94kelf9eQGIFx+GjiC82yyn8XpnwKWKybhg1xoAZT5sWjXnLwpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382330; c=relaxed/simple;
	bh=F0pbTxoeKBiS8qqMu21ahuON5GofvQKHMjBPjhUQKGo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GkjfGFxTAk8LuCeoZ39UHUubjdKAPC0eXHptOPaBZJauhWvhSUJNXg8X6bRMppcS3/GTHe5fXgKE620Nel5vcS44b378MVqbVldplQsQX3bLCdANM4eBBlp4HL7tp8Lvr9xGPVK3NIEM9z2oR8MyVGaQINmZMZwUZh8BUYBLavY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgdirQkj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762382329; x=1793918329;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=F0pbTxoeKBiS8qqMu21ahuON5GofvQKHMjBPjhUQKGo=;
  b=TgdirQkjQlp8SB+jYYHPAW5gk8aJGUnkWY28ICY4e7m/Hv6D15cPP4uy
   lBwMABfXS6EVoFaClpm+TsePKt2bkaTyEmARpUZmXCAaISUK7kCdOL36b
   9Ogd7Byu/TFmWp9y16XR3gRZEfUHYhK5jceBBJzkHsimzbKco4ICwsWuj
   ltmajNNvTc63rTnSZjn1B+m/sRWp2Gfe39H18kJ12R4rGX//zEvKqyG3t
   mJWx73Fbymjuxx7s+R1toWybJ2HwLO3FLTNDSQE7SHhUxSgedC+BIHQio
   /v8pApXOH069l2fijAWgPGyuGROluaKONSrZAcrZ6AyfVn3voME5/oP4C
   g==;
X-CSE-ConnectionGUID: XPFBnPTVSsS6xReAWN5bPQ==
X-CSE-MsgGUID: WwK/SaOUTUOAipJefvUEWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="82139986"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="asc'?scan'208";a="82139986"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 14:38:48 -0800
X-CSE-ConnectionGUID: ZfzqzoEJRwyrECwlePPY0A==
X-CSE-MsgGUID: dtSn7BeBT5KEGwKdib6CLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="asc'?scan'208";a="186833877"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 14:38:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 14:38:47 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 14:38:47 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 14:38:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Td2O3bVMA9TGv9bLc0z5acvuEdtrPF5GlJLKA0CRuSfdrKJ2wurxK6CMoQ+2e5Oc+xCwPPQKveGm2f5owhDvCfNTFihDsNtwAqSUviKgdHOCCuwLQMur+2Ep55zW+AfrGjEl83JraDvnqtQu9UNJkwH7GkaUnZmFbYrev9MgdEWiUUIg7/+CNRzTZxH5Cs5L31D2XIhAXbLDDD5RrlHJzXg4KTHBPvHqdO084xLaTMxz8AxkmBpz/gPxqf9zRhllPxPtcUYR9EbRDemFfCZX/7hnuBZq3kScV0qCIcnLOj4+bj2QGHR0wBDQR4EpduXzPyYRQMpiuMWubrAJI8xdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wIyTX4+Bl3BT5d/V4mTXLDRefXkjX/HWnKRRqJUZS4=;
 b=oY0HVajZLt6ImYcAkW2cOIhgYjZA3KtHLdjm72kX51Ky9qpH872ywCelgLHzExBAcbU5G984d8UIVCgJp/45R4fJtWHF7j3/NM0rEdIF+97ix+Kk/ZWuAxry9rSNJ6/GkB5o+nHtrXALMOJedny6Tzz3Udff1CBylb7CUVmj7tB9KWhUPji3aol+luNBawP4WHpP+k1GodC0Hs2FiJ1lTIFsXOX1vv1hYbtY6Oq/A8isqdhuGU8slrnQJVv04IAafJbJAKHKj3MJpm7HMAa5FB+DkfoodE1tKLZrJ64jb4qD88e77c0odSmtHb8p+SRwJ5TWGts4fJcV3E+E2wk8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5194.namprd11.prod.outlook.com (2603:10b6:806:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 22:38:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 22:38:43 +0000
Message-ID: <a9d52718-0d4d-4d57-a00d-82b3e66e158a@intel.com>
Date: Wed, 5 Nov 2025 14:38:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] lan966x: Fix sleeping in atomic context
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251105074955.1766792-1-horatiu.vultur@microchip.com>
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
In-Reply-To: <20251105074955.1766792-1-horatiu.vultur@microchip.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------HZIlpLFan9Z5n0hqqfzGZv80"
X-ClientProxiedBy: MW4PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:303:8e::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: ab562987-7ced-4323-9f6e-08de1cbc1336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWtuT0g1NExKa0ZLK2x6bEZwY1VyN3JXbkRyQU9PaFFheGNkUUs4TTlSMnUz?=
 =?utf-8?B?T01yL1o5cU9sVWFSRFZvWGlGa0pWazM4UytMbDg1aUN1OS95ajVmcUphd3ht?=
 =?utf-8?B?QkdVN01VbnBmc3JpY0dYMFBUNHB3MGxVakdxRE10ajZFNHJBaU1uM1pLWGFl?=
 =?utf-8?B?bjZhdUk2TUhNWUtqa3Q2UWVaeXBpNHFkczJnMC9vcjVNOUlUU08wWnFDWkUx?=
 =?utf-8?B?YlZaa0xzQkRGM28yblJIQzNRTHJ3STFaYWhhTEQ5aFVkejE3R1QwNTArcE9U?=
 =?utf-8?B?VWowY3BKRkxLTW5oVFczaUIxaUlSRk0vaTNuTUx5TjlTYXNkQVZ1ank0dXlK?=
 =?utf-8?B?VXNlazVYUzdoc0wzVTNPcVlna1dqb011Z05NdlhKcC9QenhNK3dCbGlSY1NI?=
 =?utf-8?B?Z0doejJ0MXhGaldUdXNjWFZYYml6WTdWelpHRktzTXdsTWtrNnpuaWpsbWxJ?=
 =?utf-8?B?SjZVZ3UyR3RaREI4TVpzTE53NndFendFSFVqaTZxSWwzSXFaYU5SdjJLcWYz?=
 =?utf-8?B?cU1Kc0x0VlJLemlWbFVlL290ekxqNUpJZDJHUHRPbGNHeTFSOTJoWHNGd3ZD?=
 =?utf-8?B?YXNuQ2xDdXdBblpoMlVxNTNzQ1c5bktSVEt6S2wrdWhENmU5Q1R3L0phVVR6?=
 =?utf-8?B?N3J2UndiNjRtNU91WnZIeTYwVTZJSk5FdU03ZmVKNGUzWFhnVWZlWXN5VGlX?=
 =?utf-8?B?WTBaM1MvSGhRWGljTEd1L2tYdFdkYVhwSG43MzF0SDhoNkpibCtDb0J1UjJ6?=
 =?utf-8?B?QVpleWhxVHkvL3h2MDhtU2xWKzJPTXdlb2pRcHRORmpuQ0dxWjFpLzl1a3hO?=
 =?utf-8?B?UkVuV0gvRytyZmFqeGc5T3lLVnJPRnlsNU9NeDExRVlXdUJJdzhteE9sK01Q?=
 =?utf-8?B?VGRxYmkzUlFway8wdE9iTm04QjVldnBvK05US05USkdHSFY5V3M3WU9wWjYv?=
 =?utf-8?B?cUh3ZFBmVnpWWHgvdlVYNTlLYzlPS3NGcEU5NzErTWczMi9wYXZMcCtZTm5w?=
 =?utf-8?B?SmU1bExPZGhhOWpkT3EremNFMzA2UDJkY0oxU0VmZmp4S3hydS92L1B2eG1t?=
 =?utf-8?B?MkJIMk1yc002NnlWei9zcC8rdEZnc2ZZMlJjREFyUXdsckQ2eDR6Yk5hcUY3?=
 =?utf-8?B?amlxS1g0UHZZMHBuYnNjSVJuMllhUHZ3NUVEOTZqQTRmMGdZaEJubW1RY2VD?=
 =?utf-8?B?TVVzMUJZalJKbCt4SFhTdEtBVkRkVFVScmM1TUZpSGhTaUNScFp5ekh3dHV0?=
 =?utf-8?B?TXFHWDM3UHRIQTdISnRWVE1QMXVlRW8vZjhkbHNRUzA0Sk42dmt2U1BqNzdS?=
 =?utf-8?B?eGNybXhMWWNMY2JXTlRZWThmd0JpSHEzTWdHS2V4RDE1eVpjUTZ6U2QwUHBB?=
 =?utf-8?B?Qnk3YytZZjI3aDNPbnEvMUMwRVZwZHBJMDdlS3dJakx1SXVSOVBOeWdJUENv?=
 =?utf-8?B?ZXJna0tpR3Y3ckl5VXdpTTBldlF6VjNvYStzakI4cStjaE51TlorTkRNWkFM?=
 =?utf-8?B?WkwzS0t4L0J3RkNUdnZJZWY3QU9oamJIdWtRM2lVK2J5STJtY3E4QXc5eUVV?=
 =?utf-8?B?VVRCdDBmMmY1UG40bjFUVkgvVjVaTk01YjBldW8xWFllZXozNWdzczRiOEZM?=
 =?utf-8?B?RW8vcytRMUxiSDkxNUR5SG01VEl0RVVqdERqSmY1UFlmT0x0SytiWGRURS9s?=
 =?utf-8?B?VkFUbFVqcjVCcVcydUs0OGl2ZElhYXpGaDVPTlVnbDRPenVxOHhRM0JzMEFh?=
 =?utf-8?B?VC9ZQnFqcEhLNklYTk9seUdwMjMvQW9CY3RNd2cycGlEY080bXpqeUhjS0pE?=
 =?utf-8?B?UEY0N0V2UktuK3ZDdklUM01VOEl4UlM1ZVBpMUpaZkQ3TExBTmtxTThyN0hZ?=
 =?utf-8?B?cHFRVkJ4eG15Qnk5bHc1bGRKcGx4TWhUdnlhYklPMmxFY1YxYXVGYi9jSERS?=
 =?utf-8?Q?3euCqeE+7i7135MB6XWv/fxtURABxL30?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNyM2p6UjJUTWltZ3dXcmlJRzVaa0ZrZUp5QnJHT1kzQkZxZmNYbGlJZGV4?=
 =?utf-8?B?U0JzNkVyamxDdSszbmRJeENscEhReW9CMy9Dd3dUOVprY3pkckg5OFZzR0FS?=
 =?utf-8?B?cngxWmdGZHlsNUtOUXpJTVdFTkFsdGp4MmwwTjUzT0ljN2lNUUpwaCsyb2hB?=
 =?utf-8?B?TkRGeVJnRmJNcmNFT1BtQnprM1I5NXRSQ2pnNHJUZkgxbzhxZCtwQXR0Z3RJ?=
 =?utf-8?B?NjJ3VldEMU10L1JkMjlZVkV2ZC93NHNpcVVPMFFlWlllV2drTlFQQzRwbmE0?=
 =?utf-8?B?V0lrYnVSL1dMc1NwZXc3VXRyODZ2RXlObnlGM2NKZUN3SnE0VjkzSjU4RHJ4?=
 =?utf-8?B?SHdCWlUxRHBuZjl0eU9rdk5tT1VCRVZBY0hGaUtjZnZwbGUwdVBlb0tJMEVV?=
 =?utf-8?B?d3NjZVJzU0NnTXFqS0U3UGd2Q2NaNENTck5FWHhteGxrYWNKM3djUmNySUQ5?=
 =?utf-8?B?alZPSG5zUjByOC9kN0oyYTE3a3ZWU3JZU0dSN1k5ZFVoODhPekduTXdQNjdF?=
 =?utf-8?B?cEJuZS8zOG9VS3R2WlRkeEFBeUFOa2hvY1V1M3NodEtOSHJmOUp3NjlmTGUy?=
 =?utf-8?B?Rm1TUU1KejFqTVd6RnNNUGcvb3NLb1VKUFBuNExDRlBFNHArYk5SNjRiVlUw?=
 =?utf-8?B?aGpoQzRMbGxTUGk3OVF0cmtHOHRxeHM2UUtIMjdmSFhFUm4wdnJSV2NyRFFO?=
 =?utf-8?B?REdiRTNQcHZjRE1XdmpiVDlsbDNMUy9Wclp0T0dyQmZlUU1YSjkrS2V4OHM4?=
 =?utf-8?B?dVQwVEtPT1RnWFhJbHc4aGNqUm1CWFZQRi9FWE5uM3gyV2psbXN1YVZCYzUy?=
 =?utf-8?B?enkzN1FFK0JPY3ZpV3Yya1RHTThYenZ2L3crbFVMcXJwTWNzeEpZbEVrazFY?=
 =?utf-8?B?bDZRU25KcklYQ2Y1RnRpblNzemtuMzluRHB1SFg5SHFoWmgwNEFEa0dKTkVX?=
 =?utf-8?B?c0VudmhERG53Z1ZlR0pudHBBcFlkZlFLMTZYbC9mYzJYK25JT3MyZ3Y0NUNG?=
 =?utf-8?B?Yml2UjB3L1pjWm9udWxHNENsVC9HaVptWTh1U3p5NnM0bWVLV0lZbURzTWZM?=
 =?utf-8?B?cC9oZkNDcmlncERsaVQybU9EckFSWEFSaXkzdXVDTlhGUHh5amtwZXYvU1hF?=
 =?utf-8?B?ZEM0TmZ4VithUVJ2L1VSWC9iRnVJSU9WeHdOUFNVQkJYMU9VZEwyZ3VmZkxC?=
 =?utf-8?B?ZjFMbzNKSzBlU0RGU1k1TDRYRlFFcm9ZZG1VSTg5VDJaLzdyeGxnb3pMM3FO?=
 =?utf-8?B?Q1lObnE3cUxoZWRySi9RZmo3b0NxNm9Fdnc2MXdmNWZOY2hJODlUTVZROG82?=
 =?utf-8?B?TmhVaHcrMGdWL1FmOXFwMDdvT1dodUhPRFc3cmVKZ3lFSnU5SjdnSlJoUHZm?=
 =?utf-8?B?T2JMMTVJUWVLU0hVQ294c0xHZ3pxMlhTZW02ZkV4WXhYcWxsWjVhMjY4Z0tO?=
 =?utf-8?B?MFVjc3VVZjJGTkpoZFE1cVdSYzBVZlR0elRQN3YzVm8vbjI4Ky9vV2dhSjV3?=
 =?utf-8?B?QTBLNHlLK2xVbG9HY1N1Ukw0UG44VTYxOHBJZzR6bVR3SW1jRGl3blY2U0Ju?=
 =?utf-8?B?Y1NiR1I3d3BUTzFvSC94WDlnOWZCR1BsT2oyRG9Yd1NQNEdyNVRaWlMrTmFR?=
 =?utf-8?B?ZUtpTTVqRVdxWVdMd2RJMEVSSUt6NE1iNFRwVWNiK3NZWnJMcGE2Wit6cnk3?=
 =?utf-8?B?NEFyQlNnMjdlNG5XeFNMM202eE1TcCtwbFZpYVJhbWx4cW1PV2Izb3lyYUZi?=
 =?utf-8?B?WFIwSkxoOEpINkE5RllDNEZtWXBwQ3JDNEcvSzVSaWFBSDRRbWJSWElqdkFT?=
 =?utf-8?B?M1Fsbmdla3gwbDMwTVR6MytUb1JJYUt5TUpHZUVDMmpkMWdTSXk0dTJQT0pq?=
 =?utf-8?B?TE55UXhLdlZ3bHF2TnlmR3hxS1VmNGlxQW5WVkttOWJWd0hwQkpRWkE2cmk2?=
 =?utf-8?B?ZktZRzFIUFluVzNQUWR1N1hEeVZ4YkF0MkpmTUlPSmZnc1FOZTVpQVp0aTU3?=
 =?utf-8?B?UHNwcUVVTUwxV3JFelU5Y0lPWit2cVJzcG1xS3lrTVlXbVdoTlY4ZzFzcGdi?=
 =?utf-8?B?QU1NT0hyRlY3WmpsMWhpSTJKeW1vNUEzenQ5Zjc1ck1DMW1LK1daWlo4MTBW?=
 =?utf-8?B?K1p5UjN5SWFVaFJ4SDB1WGpmVGU3UzI5WjAzTUpzMTFLbmtNYzRBcHdTUUNK?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab562987-7ced-4323-9f6e-08de1cbc1336
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:38:43.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFZ7KNqVkRdXPvhME9e9Bamr0sPoUs1WzoXK9cITGcn9t4BujcM0LZOK3QGstd791SKdqPHLfAIaqc43Y9lMSEI2/C3II+TWlt29AiNKYCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5194
X-OriginatorOrg: intel.com

--------------HZIlpLFan9Z5n0hqqfzGZv80
Content-Type: multipart/mixed; boundary="------------OALImQ4onQWE3GuFz0rNzHWr";
 protected-headers="v1"
Message-ID: <a9d52718-0d4d-4d57-a00d-82b3e66e158a@intel.com>
Date: Wed, 5 Nov 2025 14:38:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] lan966x: Fix sleeping in atomic context
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251105074955.1766792-1-horatiu.vultur@microchip.com>
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
In-Reply-To: <20251105074955.1766792-1-horatiu.vultur@microchip.com>

--------------OALImQ4onQWE3GuFz0rNzHWr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/4/2025 11:49 PM, Horatiu Vultur wrote:
> The following warning was seen when we try to connect using ssh to the =
device.
>=20
> BUG: sleeping function called from invalid context at kernel/locking/mu=
tex.c:575
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 104, name: dropb=
ear
> preempt_count: 1, expected: 0
> INFO: lockdep is turned off.
> CPU: 0 UID: 0 PID: 104 Comm: dropbear Tainted: G        W           6.1=
8.0-rc2-00399-g6f1ab1b109b9-dirty #530 NONE
> Tainted: [W]=3DWARN
> Hardware name: Generic DT based system
> Call trace:
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x7c/0xac
>  dump_stack_lvl from __might_resched+0x16c/0x2b0
>  __might_resched from __mutex_lock+0x64/0xd34
>  __mutex_lock from mutex_lock_nested+0x1c/0x24
>  mutex_lock_nested from lan966x_stats_get+0x5c/0x558
>  lan966x_stats_get from dev_get_stats+0x40/0x43c
>  dev_get_stats from dev_seq_printf_stats+0x3c/0x184
>  dev_seq_printf_stats from dev_seq_show+0x10/0x30
>  dev_seq_show from seq_read_iter+0x350/0x4ec
>  seq_read_iter from seq_read+0xfc/0x194
>  seq_read from proc_reg_read+0xac/0x100
>  proc_reg_read from vfs_read+0xb0/0x2b0
>  vfs_read from ksys_read+0x6c/0xec
>  ksys_read from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf0b11fa8 to 0xf0b11ff0)
> 1fa0:                   00000001 00001000 00000008 be9048d8 00001000 00=
000001
> 1fc0: 00000001 00001000 00000008 00000003 be905920 0000001e 00000000 00=
000001
> 1fe0: 0005404c be9048c0 00018684 b6ec2cd8
>=20
> It seems that we are using a mutex in a atomic context which is wrong.
> Change the mutex with a spinlock.
>=20

Its a bit hard from just the diff context to confirm that a spinlock is
ok. I checked all the uses of stats_lock and they appear to be covering
only simple register reads and counter accumulations. None of the blocks
looked terribly lock, so a spin lock is probably fine.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------OALImQ4onQWE3GuFz0rNzHWr--

--------------HZIlpLFan9Z5n0hqqfzGZv80
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQvR8gUDAAAAAAAKCRBqll0+bw8o6GcT
AP900MI8486AU+7/lTprjvTQ8V3jJTNAhhr/BIRMiaSiOAD+M3ii4NJ3onOpc1LuI9iXmPgMj3RV
fR0KTbLQN608gA8=
=1pNh
-----END PGP SIGNATURE-----

--------------HZIlpLFan9Z5n0hqqfzGZv80--

