Return-Path: <netdev+bounces-140572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF19B70EB
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD31C20FF0
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6D360;
	Thu, 31 Oct 2024 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zmr3kFD+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862C2907
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333544; cv=fail; b=VUXFrG+f5ev5L4dMCKOXLx7Sv5hFjIT0+vMSSq3VM6wR9xNErITM/DKXGHIbyDjR621evwoLf5yB0RK8TMRNfCxYxYypxwNgr/n7C1aqeM8LaVj4jxdm+5bHy305wLJhj0qF//Sokizmzkqgzikgq5StM1yCVVZtIx4sb+sy7Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333544; c=relaxed/simple;
	bh=Pva9r6npZvLCeLvvWXHUVgnl4Ngo19PNypknTSaH04o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EVJFGhYr1TdhfsdV6jDLqpnYl+p09bfjOx1DhrVfaWpuy67TtoyafCcsgZv+BDJd6FZdhiJHv3n3A1viGhsc86Gc65Njjc2nXGGSIhYMW2pbGkMuc3LiNfhFelvDo7cFbpWYOlTnHudD7d7Iw8F+SCXO37FQ6IJ1uz3qdbJTNEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zmr3kFD+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730333543; x=1761869543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pva9r6npZvLCeLvvWXHUVgnl4Ngo19PNypknTSaH04o=;
  b=Zmr3kFD+WGgKs3QoWSQ4SIOLfT6nIVXyI6AoKxMiBYagbmAGJgawFpen
   aDN/2aVaW4L0ya9v+5ytDSMIiqpF5uwmqiHj2AZ+mT89dIwXJHE4y3NlX
   0iVX1J7HEd/nAtNLMT2pTWax/xn5tTfnt8iy/GwT+H34ME4kpbdy3VFnQ
   BZ3LXo3vWR5fuLt1E0sgjQE71htpzubOy6z3CmoeVU1DifBnpPOG+ps8m
   kzW1/imM0A9gNg9wtZEQvjnAUwQmpBCHgWIG3Rp4BjRH566AEIpHc97CJ
   ntxt2d2Qn8nLsDW0b9fAEKnRSRJwi2smL8TRR2+bh0h7k8XiyeqibdN/4
   Q==;
X-CSE-ConnectionGUID: ets+4w11RPCSyTJPzGGlnA==
X-CSE-MsgGUID: HTU2bhNoSqawF3YAg1QERw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30251718"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30251718"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 17:12:23 -0700
X-CSE-ConnectionGUID: QbvOIq/FTti72w+H4pZz7w==
X-CSE-MsgGUID: QmPkCMNWToC+viSn38DhCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82591777"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 17:12:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 17:12:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 17:12:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 17:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGshyxiaLrvZy0djpIF194P9sxQfGonaYlTcmzvPLnibMIdzoo6XQi1P7iz8n7fBnJyCC2LXIsviROXb3YSBfFai/3lpH4TROHtKrAhn0yxjQNtQ/9+seUKBdJi6RJ2EsVyms4mPB2/sPZB7Dgx9V81Zz2OQdV7Dvc4XQ8RTuTMDAuhgVdtrCToYoiwrsIoKB3uF5LCMbLpDZVsfk8EHuFbfEKfWNUD5k1w3ytnMlX66gxARo6IbyNWxwH4pmHdwdhEFWMJhf2IWhfePQ5MhSkG1l1Q2d1m9gSB72DIyR5u9S3F+Av8RF40qSyIrCU/6eBZXKYW0s+1vCjdKRQeB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e64Tva9Sl7YaucJHWpggyyVFnMTkCVPdjBBhq1aH5tM=;
 b=GK1iuirYGWDKDrAz4ch1/C97RdG3j3vB71/HVSM6T3b1yoI45zK7kr8ljM+HRJeeobRW+mB5Z53WQFFFQy2lMNy74CzSylom8L9l7x4Km0K70pc1EpUYNOjmaFx129NfpXoVfRpowRXi2k8ho42FzdjhjqP2D3TqqIc9VwzlDcTcL9yrp2YFm1Gko/IankiyxKcFFgW9+asek6S/+VZXVW7T72M/oRbHHS7mFgdt8QBNN4WVj2d6HnFx3BQOU1LzLpeZKsp/MXOORXTVmo/mEqwpHgF0CSOvET98cFYIiV8JOo9IxBzjv59o5fDeYNKE0Tk/zcFYWyhs0AeOrgtezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7821.namprd11.prod.outlook.com (2603:10b6:208:3f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 00:12:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 00:12:13 +0000
Message-ID: <506acb47-a273-4b57-8dee-2d231337ff48@intel.com>
Date: Wed, 30 Oct 2024 17:12:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/13] ice: enable FDIR filters from raw
 binary patterns for VFs
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Junfeng Guo <junfeng.guo@intel.com>, <ahmed.zaki@intel.com>,
	<madhu.chittim@intel.com>, <horms@kernel.org>, <hkelam@marvell.com>, "Marcin
 Szycik" <marcin.szycik@linux.intel.com>, Rafal Romanowski
	<rafal.romanowski@intel.com>
References: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
 <20240813222249.3708070-12-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240813222249.3708070-12-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:303:2a::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a15f080-e61e-4edb-bd87-08dcf940ab7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFVPYWtQZzRXSTFRNWJvSkJ0UzJHRVVQL0VRblVDdXFNVFh2ZHVqcHNOSVBK?=
 =?utf-8?B?TWdhV1pnMmJYTmJPZXd0aExRd3RyTnIxUUVVc3ZjOFVxam9QZ09DU2M2bHNh?=
 =?utf-8?B?eHVRSUJjckQ4YXpGdllxd0EweUNDYnNEcy9qV0FKZjZWbURWRitBc25Wb1ZB?=
 =?utf-8?B?Rjc2Zmh0WUwyc1BPSjhMK0ZtMS8wZncxQ0dXR0Nvc2RrZ1Y0NElNbzBXSzRJ?=
 =?utf-8?B?RUFTdTNMSEk5aW5LNVAwNDBDM2lyUVFGQlBiZVk1ZlNuVkZyNENmUXpmbmxJ?=
 =?utf-8?B?bUdYeE1NN0RoWXJXRUVSQ0dzNFhIRWQxSTBCWElBS2VXMU83dFhEVzBmZFkr?=
 =?utf-8?B?Ykg4MHp2ZW9Rdjg3dEo0NDhGWGswSURpN251ZExrWkt0YUxTVHlHVzV3SnhL?=
 =?utf-8?B?OVdkY3FWeG5INDVEQVJXYy80RWd4RERLY1Jla0t0NnM5MDBFVVlrVGNKcjRv?=
 =?utf-8?B?T05wM081UEFhUzFjUFlyYmhnTnI5R1lacTZVZEk3VjBka05HTnRNTnNIYkky?=
 =?utf-8?B?N09SRUJEcVlpVWxBSlAwMjkwdTRpOFZPYXdEUXFTSG0wZ0VTd2U1WGFtYWZE?=
 =?utf-8?B?b2FBMkpJbGlmU2RFdTF6bmJPeEZHcjlhNDZSTzdLWDBmNDcvTU91d01sT3Rs?=
 =?utf-8?B?eXRRQThvM1FUWDlPSXBkZHhRS09xVGo3Z2FHU1NzbFhkWnlyeFRsOUtCWmcr?=
 =?utf-8?B?S0NRdlVWYkUrYzZpMytuNld3Qjc2YlV2b3Z2b3YyLzczejRHREVNRHFseTNo?=
 =?utf-8?B?WnlVbTRwWm4vUDJnS2dkQ1lKVFp0M0pZWDJqcmZtK01JY1YyQVRBT2RDS1BF?=
 =?utf-8?B?c1hkTm5iSkE4NWEzdWs5QnZZQWk5My9BUDRRcUZ0Vml3ZUxxOUVadnM0Undn?=
 =?utf-8?B?czVGeFhrYVBXRkozbVdJcytpcVdxUmttcDZDdC9OMkY2TEpSSWk1Y0FtWG9Q?=
 =?utf-8?B?Tm9qbjNzVnl5U3FDQlFwNkVpby9GeDB6cUE2QnQ2ODZWV3YwZVlXNXhHL2hG?=
 =?utf-8?B?SWZtQUcrUE4vZFJhUEp0c0ZIUG5SZDcrZ3lVQ1l1TW9GWDdvSTVLK2pSbkIz?=
 =?utf-8?B?VkdWaW5RY0xOejI1QmVLaUdBYkVRd3ZCUzJVeXZQNHRCSENBWmV5Rk9KN2lj?=
 =?utf-8?B?bS9tckRkZzZRc3hrZmQvZURTaklPN2o3YXV6VThTZkhRUStRd2luY2JrU3NC?=
 =?utf-8?B?K3RkdFhVU29BNVhmdU4za0JtODFaRmpzVVk4eVZKZ1VOWHdBYnF2WFlsZ3pW?=
 =?utf-8?B?QzAzYXgvUkdLa0lWUjcvNFE5dWtjUk1PVWRCS29WblcxTHFaNFVJSkR2YS9I?=
 =?utf-8?B?a0FMU000V0JMNUdNenVMdmp6WDZzd3BrSHorRC9pMzFQdWVQeENVRWdWNERy?=
 =?utf-8?B?cmNiTktESW5hTXBubzh5RUlYd1BTc1gzbWhrOHVFNytqbnFaY0IwempUL0Nt?=
 =?utf-8?B?M3lDNXNYVklWYkUwSVRkWm0wbWFCR1VnMlhqT0RZR0Yxa2k4UFk5cFVYNmIx?=
 =?utf-8?B?a092SUhLZjBBeXQ5YlVZNTNMM3hIMEN6UjhORGQvUGZaWWhSckN1NlFaallI?=
 =?utf-8?B?UU9RZEwvSkkwWGRqZFVFZFVVQlFpOVAzWXprQ3VyZ3JxOFhSY21PRWtSQ2Rz?=
 =?utf-8?B?eTlDbjBQaThGVW5tRXRmQzliQ0lsN242aWhZR1NhaG1MVlpJMG1uZk9BRHJX?=
 =?utf-8?B?OEQwYjduUCtHOGdyV0tyUDhybE83SVNVREFHMk9aTWo4OEtwWmhac0ttUk9s?=
 =?utf-8?Q?ts5pAyOgc86FbsCCRxua2vKOdc4FAdB1XlmYtF/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnRXNE90OTd5T0dDcUtxMkExTjF2bGIvS1R0Vnk4TXBDRTlPekV3eFFWbXlD?=
 =?utf-8?B?dktxK0M0ZU1EaHZDbUI2Q3VLQnkyNDJkZG1zZ1dmTkRXSmF0bW1NZWowbDNm?=
 =?utf-8?B?K3lkZjllQkpMKzFZSTBvbGNaL0pmY2c4dVhYQU11TDdnN3lxQTlhWnk3Wjkz?=
 =?utf-8?B?aTM0TnNXeUdWU3pLVy9zWG5KTG5FS1A4NXQrNlB3TmJkZEpJMlg5dEd3bjRE?=
 =?utf-8?B?clJFd05ieCtMbzhiSHhjeHQ1MUk1S3cxTCtrRUowWmk2eXN4eGg0QU1zTnJN?=
 =?utf-8?B?SWtiWm9ORVZwWEJIRjFHSmFMemRGTFVRRm83K3VEUkFxMG1pUmJJM3Y0MGpv?=
 =?utf-8?B?NDZXeVhQcVFRWTBGUG44bURZSEs0MkpxVXNOR3NVdVhwU3p4S01kdGd5V2c0?=
 =?utf-8?B?Y3ZZeEU3QVAreFdjYjZGOUgyWTFhN0swL00ydllBMUZYWU80Q2lPb2Z2MjJS?=
 =?utf-8?B?MGNVcUR5WFhjYzFPMjNQVmphNy9pT2FabUl3emwzYzg4VVRPVUxkMlRGaUYx?=
 =?utf-8?B?QlR6ajlwUWdjZXR3NDRmRXkxMkF6T0xHU3dxdk1nMDBSV2NIWitsSXE4bm5I?=
 =?utf-8?B?S01JaUNmcDArNzE5UEFzSytNdTF6TFVaWmE3OWxseE1PVHJsdXdPcHNGakd5?=
 =?utf-8?B?ZGRQemlyOEE3UEdManlteWkwOGtCYWtCai9uYnBXeTVia0pDVXZNV2s3em11?=
 =?utf-8?B?TDBXVkhFZDhmc0FGVWkvSjcyUjZNd09oeFlOOFdCT05VYk9SRnZyNWt0eDRL?=
 =?utf-8?B?QXVMbFBVL0h3MmJtV2pWaGZ4cVZXNFdORmRrNjExVlZ5QU02b1dKNlRQY01o?=
 =?utf-8?B?cWdyejZ3WXFkMUJDS2d6TEVFN0VPZmdDUFpHS2tsU0pDSWJwaGlYZDdmdE1v?=
 =?utf-8?B?M09NZEJIWENTUGdkYTRaWnVvTEgvUy9RTFhWRU9QdWh6dnhoMXFwdjZGMXU3?=
 =?utf-8?B?TlZjNlVqQ3RpaE1mZUtwbVFBREI2MUN6N0UzQldvanJiL1dxY29TU2NWMjRy?=
 =?utf-8?B?NisvVUcxRnZNZVF5UW5waUVlVDNOM3B2eEcrc2xGTUk4c0Jtd0tHb0dJSDV3?=
 =?utf-8?B?cVFaclN0ODB4MjRPTHphSVl4K1l3cDB5TGhTUi9QaVF6bUtrS0VvbVd5WmpN?=
 =?utf-8?B?Tm82Q0tMZ09xSWZGUjJZcHF3TENYaDNpczFZb0RsK2FjSXVTeUtDRkZEVDV2?=
 =?utf-8?B?RDI1TDFnOCtwUkZHdXpkb3BBS1FHaW1pdkt2MENHZVVoMHpIZURJMnQvelhH?=
 =?utf-8?B?MmhYd0hwLzFNVVlyU1lBMHh5ay9lejJQMFoyNVZPbzVpbEx2WDkreXRVeFd1?=
 =?utf-8?B?T3RSZVI2QkkvTXhXS05udXBtMnlRdXFjYkhpQ01NRlpkSzdhY2d2WnFabzVI?=
 =?utf-8?B?NFdtSEtWY0NiclhpaWpUTzNjRjE2aXo0cXZQMjBEcG5YTmpMMTg3M3hBZEl0?=
 =?utf-8?B?c1lnd1NFSStGWWdRQjhkV2paQWE4WHc1R1JmLzVGMlNraHZjYlRTK0c1SFRC?=
 =?utf-8?B?WlErMlJqOGJSWTc3UXB0bmthTnNnc2swL2hTZ1phOUt1SHNPWWhBZkJBSHQr?=
 =?utf-8?B?VlFmbXJ1SjN0RDBUL0Y1dFR0VjVaSnU2QzEwQVRRTWdZQW9Dck9MQXc2cElW?=
 =?utf-8?B?UkRnQWMrZFQxRmNLbXNuMjJWT0s1aFhXUTF4Vnk1NnRoQkJrSjlQYm9BaGFz?=
 =?utf-8?B?ZGZZYy9rSG5MaW56ZWZyL3dxQjV3ajdqQXMzTEwrUEtpZGdqSTN1NVdrVUxw?=
 =?utf-8?B?VmsrR1NGWjBzdGZ4b0RUTlVTeTJ2OUhvdEpnSlI3cHNMc0tCWDNvOTg4SnMy?=
 =?utf-8?B?eDZDRmVXUStyZ2k2bjd6LytYcHZDNnpiaGpPQ0FoUGlrcG1oQ2MrZ2FrVDd5?=
 =?utf-8?B?SnNFSVRPMk9qanY0TW5kZGJFckYzQ2dpYU81alJKbUVkQ1greWlFUU00NHRr?=
 =?utf-8?B?TzlFMTFRY2lJMDdmVjBDZ1FudDZySHBOZG1Tc3hMKzJVYUR0RmVVVlhYcDNW?=
 =?utf-8?B?NWl6TWVRSkcwVnNpbm52NWVWRnBIZDkwck96dFBaRHpUQ25sNDlmNEZSR3Qv?=
 =?utf-8?B?SGJvOXFUdTZuckJ0OE02akViL2d2VkhVKyt2cE5TU2JmSkM3WUZrZE9hSndO?=
 =?utf-8?B?N3RTZnhjRDdkUkI0aTIvSWxzWXhUdVFtdU5NMjI2UXVtRElWckRWV3JJdUV5?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a15f080-e61e-4edb-bd87-08dcf940ab7f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 00:12:13.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LH/Rm3VGQmDqwFepz/qtDwmHnSFhOEg04yUd+tEArFl6X08sI+MwHby/GlEgLjtek+6hp8oheYgEwRmDaFC5y4AxVUfGUd4B0ygBr+o8E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7821
X-OriginatorOrg: intel.com

Hi Junfeng Guo,

I realize this is a bit late since this code already merged, but I was
looking at the ice_vf structure and found it was extremely large now,
and traced it back to this change:

On 8/13/2024 3:22 PM, Tony Nguyen wrote:
> +/* Structure to store fdir fv entry */
> +struct ice_fdir_prof_info {
> +	struct ice_parser_profile prof;
> +	u64 fdir_active_cnt;
> +};
> +
>  /* VF operations */
>  struct ice_vf_ops {
>  	enum ice_disq_rst_src reset_type;
> @@ -91,6 +98,7 @@ struct ice_vf {
>  	u16 lan_vsi_idx;		/* index into PF struct */
>  	u16 ctrl_vsi_idx;
>  	struct ice_vf_fdir fdir;
> +	struct ice_fdir_prof_info fdir_prof_info[ICE_MAX_PTGS];
>  	/* first vector index of this VF in the PF space */
>  	int first_vector_idx;
>  	struct ice_sw *vf_sw_id;	/* switch ID the VF VSIs connect to */
This adds 135,168 bytes to every single VF structure.

Is there no reason we can't convert this into some sort of linked list
so we don't have to store every possible ice_fdir_prof_info even if its
not used??

It seems like even if we need to store all 256 entries, we could
allocate them as a list, xarray, or something which would prevent
needing to allocate them in an entire chunk like we do with a VF
structure. We could also theoretically allocate it on demand only when
these raw patterns are used?

Forcing the driver to consume 132KB of memory for every VF seems rather
overkill. If we create 128 VFs, this consumes 16.5 MB of memory.

Thanks,
Jake

