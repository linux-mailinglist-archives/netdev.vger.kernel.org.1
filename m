Return-Path: <netdev+bounces-290007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFWNHnHqDWrM4gUAu9opvQ
	(envelope-from <netdev+bounces-290007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:08:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B03592F5D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4CB130A8E5D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA013502B8;
	Wed, 20 May 2026 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE6sEd+j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D934A3BF;
	Wed, 20 May 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293457; cv=fail; b=Nh3gnvk7kLaPwnhU2tQs6jppr2psLS2Q55gPJ/Gy6WPcXAPhCdECJI3EC89mNxz9VBN5F2g/hWUrDJNMckks0j+pL/HsPOmrN9KhC2m+6T7UK1n+5gMIDRTLytD7WJ4Sz9oyDCU+AZl1yv8/XN8u9/aDS5r8HI5tY/++QelNmcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293457; c=relaxed/simple;
	bh=9yRUXWzrPHtOlStjOMbmVkppnJwrTiNa+pUKf4MjEDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MvqHpD6OOT2ZY69ugyOnNfhDKLidvfGP7XqZ2JfC1QCNbqbfWWYCPA7Yne2szeI6fZuaFjDbrQGCa2sUT4PxqhODqOVKfslEmXaFZz+A5Fagu/PP7vG4JqZ1zpKAoTymF4TnV/1VDPWFSC4kJehWLz6IjwtnLyklONmx/yK/gGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE6sEd+j; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779293454; x=1810829454;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9yRUXWzrPHtOlStjOMbmVkppnJwrTiNa+pUKf4MjEDQ=;
  b=jE6sEd+jaUyREsz5VCgVWc8AnevhSyXyzIOj0xG5b77Tx7j8bakTNlk9
   E/8qVAYQA4EJaiVCVZJ6+bcjVbgZ3+mYv575EexTC9A5u7k5oc96Rk0N1
   E6M4Re8pnIiKW8VSybEID212cUXq3sz0vyJbO64o379hAyHx+ozWOtYIU
   6R+oBHFXSb5K3vpkpKJt8Qhh5TmUKrnUJioZnpTB0RpQfE7FsgBS3bD9C
   RftkBwd9LdEaguDszXBLzAgEq3p4fXXoT76n09zmaVN1Mx0MbDf7QQ1OA
   zwbxVOkj5fVHEfHGm+OVGzy5oqanUbd8CHMGBhT2h12LaW0GdejFJ+VF0
   Q==;
X-CSE-ConnectionGUID: J6BNR1uRRcygLCxuTrTpvA==
X-CSE-MsgGUID: 8HisirYTSD2QBGgSAcT4Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91304376"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="91304376"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 09:10:51 -0700
X-CSE-ConnectionGUID: x9io0VkxRdOxq+Bl4RRx8Q==
X-CSE-MsgGUID: b36yFi77Su2/jQzettC9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="278347959"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 09:10:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 09:10:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 09:10:50 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 09:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QN8XHND0JDGp32qagxr545MSlIrxacqCBMOEyk6z87AAZKLukB/yWeeZmQtbuAQXoFWY2ye7Wv7aqAFU5XDwO7igrVioWQrL8TRvEGUcZOtGV8KPJLlr1R8lZiZ6Ul6te5uU6jc+nNpFtyq+iCJN90BJQ9mllBgaH/BEld1vQovxVIL0zADfGv3O5999yBWDx/Z2lxeOxFboRh7wiMc26IsY8HxCjl8NWgAoXnRVdUJyPYTYS5d2bK0eh3IslDDQjkVaoB3gfzDmrjHUNq+DosR0+ueG/NapqTBuOsByVHFXe68shttgJTJy3hf/NFQFVHkXj1gMlP6Z7Nub3ldNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id75g3XVHKnH+aJUuz8kkGZM/s7TN0Jq9b7amWttZp4=;
 b=ZaWxxEqFUO9QgTZBVlusdp+Gl9PCuZMPUDktX6bGKbUfatswywMXRkEzG7HQvL2os/7RpBAJWDD5RKXHGHgeiQfs0F970EzjM44UdhzOJPPOA2fn7+202lvIFL26jf1/wNz5hBTv843KtFRkUvNTjTsc7msvbhzXPMsJQ8uxElJDwnnJza3a3CBpqmmh2WnXgU+mkjjcZpyghNpNKRY1JMvI/9ePlPEbpQWa/jje1NwtwcrZ0f4fvNXFlrh3shN7a7KdXASrewbUEAbCwY4OGEi+X2lpjkip5QcVY2uQnikyExkxTwgWTgyky8ZNH6vlJ9p2/TTICluT4vRJ1lnHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 16:10:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 16:10:43 +0000
Date: Wed, 20 May 2026 18:10:31 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Message-ID: <ag3c9/EF4h7DLQu3@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520004244.55663-4-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VE1PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: d10188e2-dc3a-4d58-69c0-08deb68a5836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: utozKVcCkcDJgOaZ06TI1ak68CCZ27JKfdgPPSAqYHBICU/mmQrRXJLFlx3JWdsLywKkjDRXuUlW2Ne/ctfw2PKAkmXHlD0BlB+lBzXywNJwDR/tuJ6EVHUoTLPKAZTijIdzV/0RslObw0wQ1Z0MM0xsk2n6T9gGNQcfTyS7L0qGfA3L0vYbu3Dxdd9tmiIjDpG4CrhpqkIOUoIyIOFyNSqvK4qCn0OTy0notzClMFjkgRSrAmSMrYIwqM8/aY1e5uWqrxdV6Jw/Yg/VW8KJ6XB0HFjyrvMu0z0N7pn8tmlXkw5CHkXEU6Ch+vhghMU3m5e1WEr2HVfAIECOP4bAR5t2ZhgZltSVmgLdQcYrvvqSuMFILz9q/Eg+9NiXasH4v92raG1oyUT66j0fI8jDMOfYS56PEENZNtnb8RtPodb2EKcSmVILWNHCHIcXSKEBhhKXQmYjZ3zvlfmxff9CfPSLGg3MKO2XA3pOd1A0Cwdp/VnBH1mKQjJsWQMWBbOL7xTk9IFe7RaeQxhmLFHjspsB4SZdV4f5on18OnVNrpVlnHHIH1eJ6RBZ3mozf7BSGoMsV6BjTZfS1qCL3t0zN2AjSIB89wADSB+MtZzJSGQyhVBNHf9FvBLJp5npwR1ISy76i0BACZp+VE6STHlsTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pabNJu5HDyjbidCePCu3Jvxjjci3aFA8TWTiGhzau8GNOmFb/8iQB059n5Et?=
 =?us-ascii?Q?aiksGTbgFEuJ0zUbK2I1R+ea2JuxxOKvGQxtznzznQacs29CaXXzPEluff/1?=
 =?us-ascii?Q?oUFz1rCaPzMetr+PcHBHWpC6oUGLEYQRTlFJ82dGWWEGhRXEC3Q+Y1MK6DHR?=
 =?us-ascii?Q?QcPhjgwUsAmTwuGmexUf2JC8PQxFqzQumS4ukvMxW6CofryKekBlPC5t/C9p?=
 =?us-ascii?Q?obEib4fmaSo+vKB1k51uW6m5MbHdTD/rC9x+AMPvRsybmLBDbJRLvD2aFDwC?=
 =?us-ascii?Q?VTJxLF0viDsyvQBretJyG1cPaIDb2mAWBjthhVKva1U/DNc7Yi56Lxaa25HC?=
 =?us-ascii?Q?FOBBtfQK0UQzYWaDapVczCHDgw9NUc0i1G81qvRGc13/GVTk2vsOB1JsWJ7U?=
 =?us-ascii?Q?ykOHc60qoRqU0RV4Z8TI33sp9xUjqpS7gypMZQVSJGmbe/oYZ1g8JbVjyXFx?=
 =?us-ascii?Q?rK0yx0hlUb0yByJ7skTpujC//YLEcwDp2+VmgFqIBcUK8i0F9U//PtlsrRD9?=
 =?us-ascii?Q?yCyaz1figEKqkueGvFYT/xVjKneko9/ReVAz3FcA9jonLwPKf5pEskadljtO?=
 =?us-ascii?Q?faTWGis9GjniyWET1WOLLGZFhBTpcBxigOs/TBb6Nw/WCU06ust5yG6WqqKi?=
 =?us-ascii?Q?nParc9U+DLEsPjYhVRgJ6XR3TwyRspS8X0zWplgOE3DR/LYxbb4rJeIn+BWV?=
 =?us-ascii?Q?KUWaSFhDkqJno6OPZVl19Tq981rJ5taEWq0Gw9MbEwJwvbR4WXtPlSoMgiIv?=
 =?us-ascii?Q?z3GEY3xprfrrBAGjSP9/KQ2J1Ix0acDWGgoEarFqoCixq3xDZk/tvAd/lSVk?=
 =?us-ascii?Q?fj/dLBbFHCgRXz/qEFW+7w+KrbKmisn71pOmHoyfKXEwjdu1FccT1cQdrOwZ?=
 =?us-ascii?Q?AqRZB2abtyb06GpU9OsGrILCOK1p9TLaecp0jcsAPkm8ijKsyHTnQSZcS8br?=
 =?us-ascii?Q?2wOeWuUePBFq5Gyik1O/9SHWgB4auVLPNSG5c/jUZsiboFsZhYAZ7bNYvskC?=
 =?us-ascii?Q?cU0EnTGLYj3rkB5DWZVMF3vNWqulC526w281LIlgXq/QsvCgsVW+B9fv6dRk?=
 =?us-ascii?Q?BEx2s788LHkB9u4IBW0kyrwv5o3N7H72H+DowaSaYVv9B4lH6AE8uNjZU++X?=
 =?us-ascii?Q?Y89Ah4CF4fubQOLruZ2OWD3D3ykfFGvKNa6ehDqVjuItZL5Atx5AaUWzp28m?=
 =?us-ascii?Q?FBQxvj9PraKu7mNYuHj/IjJXTnrn1khSRMvhIMua2zmFB+gIrcnxc/6ikxu5?=
 =?us-ascii?Q?wofozi0SlFEc9EWukOKU4VmZSkPXjth0VjHayvEAeROL62VrcAT63tjsOX9I?=
 =?us-ascii?Q?5qdhg136l24JfE4hwGE8ssY5ZxlJErujTvOwO2kxzdnAYFC9eLHYO0VJOmx5?=
 =?us-ascii?Q?+LZqUWVcZQkS+iqudK2cIuLq4YatBOTpC+M/G2BX7Hxzsp6X9Wxf1abEt8Mh?=
 =?us-ascii?Q?L4bktgC/7mjMHHgS1KkGAl2sPTO1Iv4Oev30R9T6S7WgaaXT0EUNTXeaaXcm?=
 =?us-ascii?Q?zGhPDzf66L27LRT9K5wkXkK/KQMZ8GavdFHH1DS5ulZLYXvfpbxlzxJ09Y1A?=
 =?us-ascii?Q?5zIO/X3UA9SDnnQ78xXLMB3tTir6TWX9pF67xBpQequE7ynn2e8y4mmFyplU?=
 =?us-ascii?Q?EZWmCyLPassGF//g0PlsPTKdSBFfqsxaPO6Bu51rp4XD0CPte+aOZOyiCMV/?=
 =?us-ascii?Q?xvHz0fypgn1CfItFkevqM/huy/fIYO6dAO2JoL9s6LTEdqSw523mPjglx9uy?=
 =?us-ascii?Q?qk8wqmXW+VYf+UQO5QqdSHws00gqulQ=3D?=
X-Exchange-RoutingPolicyChecked: RlRJHA7eGnHqD6sD27b7H5vviuzSJEKwFDvDCUVbXKb6mSRAdq1rHBj3ZNJjuiD0+0EPx05njPD5rkH5T/ZkQVAhxkePFirm/QGtjPZ1J0XQuXFWst9bOheu1M/kQhqSajo3qkbYoKYAtC2ZyBHBSURUTAyS2LAEx8aScSAqNgVQV3xp/FqZ1HN1Er8OmtEp6ODPHTJNmEcSKjPecRTfPIwSZBnYweX/ifHeyjm2Qg1uy1co6u9gcXox73rXBW05hBXLipE1J9q9e77JC68d5UrOOmtKHQSI8SNW5rQH/yZ3rFwBdn5kC/40kehyaNGj0BXQZOLhoRruC8vWdSOBOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d10188e2-dc3a-4d58-69c0-08deb68a5836
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:10:43.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Piybk5HO3M3V7fhgtD58KTTlIF1iEAbWSQnxR8F21ak/hVHuYICo44043a6CU5DSQPREVqNeHXJ3j3UMVwop0DFzFTUzkN2DmPI4vJu/aRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290007-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,tencent.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 07B03592F5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> only the current descriptor is released from the TX ring. The remaining
> continuation descriptors of the same packet stay in the ring. Since
> xs->skb is set to NULL after the drop, the TX loop picks up these
> leftover frags and misinterprets each one as the beginning of a new
> packet, corrupting the packet stream.
> 
> Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised,
> so we have a chance to examine and handle the potential remaining descs
> of this big overflow'ed skb.
> 
> When the last fragment (without XDP_PKT_CONTD) is processed, the flag
> is cleared and the loop continues to process subsequent descriptors
> with the remaining budget. This behavior follows how previous xmit path
> treats overflow packets.
> 
> Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/xdp_sock.h |  1 +
>  net/xdp/xsk.c          | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ebac60a3d8a1..8b51876efbed 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -80,6 +80,7 @@ struct xdp_sock {
>  	 * call of __xsk_generic_xmit().
>  	 */
>  	struct sk_buff *skb;
> +	bool drain_cont;
>  
>  	struct list_head map_list;
>  	/* Protects map_list */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 0a6203c42576..f4add7be8c93 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
>  
> +		if (unlikely(xs->drain_cont)) {

Hi Jason,

could we get away from introducing dedicated boolean to xdp_sock for
handling this rare case?

> +			unsigned long flags;
> +			u32 idx;
> +
> +			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> +			idx = xskq_get_prod(xs->pool->cq);
> +			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> +			xskq_prod_submit_n(xs->pool->cq, 1);
> +			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);

It feels a bit off to do this cleanup one-by-one.

I wonder if it could be covered by xsk_drop_skb() where you would walk the
tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_addr_locked() ?

OTOH, in theory the amount of frags after we hit the overflow case could
be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to cover
them.

> +
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			if (!xp_mb_desc(&desc))
> +				xs->drain_cont = false;
> +			continue;
> +		}
> +
>  		skb = xsk_build_skb(xs, &desc);
>  		if (IS_ERR(skb)) {
>  			err = PTR_ERR(skb);
>  			if (err != -EOVERFLOW)
>  				goto out;
> +			if (xp_mb_desc(&desc))
> +				xs->drain_cont = true;
>  			err = 0;
>  			continue;
>  		}
> -- 
> 2.43.7
> 

