Return-Path: <netdev+bounces-130976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9A98C4F4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E6AB23C71
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB401CC15D;
	Tue,  1 Oct 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kExU8Mg4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB21CB528;
	Tue,  1 Oct 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805519; cv=fail; b=ALHStWW/FGgETyGrvzcN+Gho4rFBlJrtroRwFmLMvjqG2KqtSQOi/sdMgaoSNZwmVrO2auayXYPwVHMTdZwRFAirCe6IUENWR8SNvhz3IGchLzdNTUJU59ROd+k2VcB7fsnyLmB6mH63GtdVtVfTqhlqeuwGk++3ypMn/JlGbaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805519; c=relaxed/simple;
	bh=QqHGsAS56x+UtQfdhsfLVbTNvssowaqL+FYEsre5+Yo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vh5r4dMNibRkHGHquNb2eYWFRS0rGGmqYtjtv3oRo/NyQV3eiphJdtjLrSWHDwKJD9ClYoUaf4vemgyclv88HCbaM3MByhVV2kDR36jlY+tbsMw5uF5QSRQCA/66QNJm1awdHM78421BqNAPusRTErLmquNOzsqMAfMAWQCR498=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kExU8Mg4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727805518; x=1759341518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QqHGsAS56x+UtQfdhsfLVbTNvssowaqL+FYEsre5+Yo=;
  b=kExU8Mg4ZQzB+e8uNmS9cg7QHXN9RXs+G32IoAIQEeX2NCmg/i+Y7T7b
   FiZ7sZKVjCgt4rvdGdq17VcLfDNT7/UeBdnQh+m5JJ+c9sF7r63bYXkMd
   Lv/X1jwkC6Od++jS/6ryxo6JedFb/5dIkcfe3mmMDbc8BKdfI8OHy7dfM
   QNnCQbU0utAu/ZbkY0fJonxUbBIsMonN0z9+7QQfsP1T7u12o1giskYYE
   t5xj9Zcd/swXkX6SE9DBz68/DIxJp0rFnPNyBMp3ZFxFwdadMBrcT8D4Y
   q21eFB+sxWsQm5fTnL6MkZl29xNFiDGonQT5ON185nmZGc82k277ZVEW1
   Q==;
X-CSE-ConnectionGUID: /5xaUPpeSwu7MJcPkh+Q/g==
X-CSE-MsgGUID: l6wskpqPStKsdQUB3nUnnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44482060"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="44482060"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:58:37 -0700
X-CSE-ConnectionGUID: PZ+XZsoTRxusDtIO6KV98A==
X-CSE-MsgGUID: BjPH4LHgR2umYc3lyIc+8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73412562"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:58:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:58:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:58:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:58:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5R++sM2JLIIqE5UbRU/aMWqo7kQU4YyK9WCKEBjh5D82EBWvZV45t5+IG7sHv/uPXGcX5eJtcCP15fHtpNzuTfb6PVvJ4XZogOngU24ym11jwPb5LM8Em0gsYDl/nD22n7IhdDZRMV25ho0DHFwT1tG/AhgRHdd9+zhbHBTxkWL6gByxefnhB2AhxtC6wuYtqZcNrd+v1moSUI3kd7FjB3/2crcERsI2NDeN1ViFErVcGh6wRCX+lCUKJ9BHESqkR5ujuNZTcPPE30LCPfg+GD0VevkBgXq1pSH0YBFKLBXqdEgCkbIi5UctF6ZPP9ub88QfjpQyrD0+2eGYhproQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuJc7Gt71CrVqPWXO0CCXh5MSjiiLLgmX4fMCfoFhYk=;
 b=w68xfcXFZQX78LiB7HiZweHhry5XlWi1uzzZNoErg33O9byprXlnUA2g6aVHr9t6Jf4gIASpcdkztI4F9N/NeQliF0Ym2LOz6lmaeDiJR15qCBbJSuKH+z+0QSos22tJzvBH5bRGBhBCFeBzvn1ttdvcJ0q2BwVIHLBxdgFCVC04f1IfLswYUwQ/ALrTVb+lDYBf8gD9vRu5zeO67Vg2u9miFrF72hy02zFge3tWvGWkiBIxI1dL3g+vl/YtZP5qO8J8NtD7lYAzcA+gnoLzFy/BDyBh81AkJ0HYV9i7Po20Kxy2xy1sdpQFNgPSoE6/UqhAl1YHWXgyWOWSs3oNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 17:58:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:58:33 +0000
Message-ID: <fe6cb2bf-109b-4cf5-998a-ebb530cad0f0@intel.com>
Date: Tue, 1 Oct 2024 10:58:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] net: sparx5: use SPX5_CONST for constants
 which already have a symbol
To: Daniel Machon <daniel.machon@microchip.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	<horms@kernel.org>, <justinstitt@google.com>, <gal@nvidia.com>,
	<aakash.r.menon@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-7-8c6896fdce66@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-7-8c6896fdce66@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b0abc7-3395-4ea9-3e8c-08dce242aa48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWtqeXByZmlRSEM0NHRsbWdJb1JkR0xhc0xwU2cwM2pJU3dHSk9YazRqQ3dm?=
 =?utf-8?B?cFY3dEdiQkR4Vlhjc0ViVkFZNFdlZG5RazFqMHFiaW40bEh5Yk52OGpodUxx?=
 =?utf-8?B?Tnp5Y2VtcCtxMjBFQXVlTEVsNkRnNkhVWThxRXBzd0s0Znl3U24yai9XSkJU?=
 =?utf-8?B?cEsxbmNNb2YzUVlTZUFpcUxVYytxZlRGRVptL0ptTlltR25FK0pBUytTandr?=
 =?utf-8?B?RWhiUnZuQVNQV1RKeHUwdVh0OTl3UVdISnQwaURFbjFrOHIzQ2tXVmNOMnNY?=
 =?utf-8?B?R0U1Wk1oc2NEa1ltWTJiQ3MyMmlZYnhGODkwZmNXOUJvSEo3bXVOSUYvbytq?=
 =?utf-8?B?V1ZTNUdFOTJNdlNMM2lzZjgxMEwrODFBc3VTSG90YklvYm54S0UzWEZ2Zjla?=
 =?utf-8?B?eHEwamRvendhZDNVZ1FNTGpMdWEzc3c3SWl4d0tSZEs4c1lYSXZJWmdKZkx5?=
 =?utf-8?B?N2Z6dGovYXFLMGN4MkJZL3NkS2V6ejhNZ29oYlJwL1BGVUNoMHUwbFh5cWgy?=
 =?utf-8?B?eDdIdVdORWw0ZVFhd0tkK0l5WDU1QmY1TE9Mam5QRXpTYm94S2J6UE9BQlUy?=
 =?utf-8?B?OG44bXVZTVN4dnlYVm45bGR6cHloKzhlQUlnK01BMGR0aldMMm9vRm55bVJM?=
 =?utf-8?B?Zm9hUXRkdE9pUFYrUysvLzdscDNBM1Q1QnRMLzZ4dFR1bVhLSGpick5Udzg3?=
 =?utf-8?B?eXdhd2VZd09DQXNhSk8zTml1UXFCTHYrVkE5QVcvSWp5QWpwR0lVQ25IYXNs?=
 =?utf-8?B?WjlnQTJuRWFXaUFSTUhmRnRPbjRrdlpiblhtcnRLeXM1OHk3amZRMkpsZUJa?=
 =?utf-8?B?b2l6eVptSGxoKyt6NitwYmxMOWdQeXlCbHF4QzJHY0xsNHRaSzl2aE84UlFV?=
 =?utf-8?B?RDl3TzU4L2x0eVpaeDBIeEJoOE1zbWh1Sjg4Nnh3aDF2WUZXclo0azZiRTZj?=
 =?utf-8?B?RFgvSjhtS0Jid3Q3TldQRG1GU0p3endqU1h4a3JFa093cjBVSmo4dnNtVkl4?=
 =?utf-8?B?WVVWa2VHWCsycUtETFY1L0pEaUgvZXpYUFd5SkRybkw3L084MTFabDlxWDVN?=
 =?utf-8?B?WW1uWFJFWmxQMDlVQkNLQ1d0VnJCbFBYMStrbXJ4VTZadC82c1plMlErWnc3?=
 =?utf-8?B?cDhMMnJCT0pEYlhVMVNXbnBLSng5aW9oNnNPQVFlc0xDOXFXZWhZRGNKNTNW?=
 =?utf-8?B?SkFlL041d2sxSTdxMlhuVGhTMmp3SzVTeVRPZDhRMUlJVDhONE0xQ0c3Mjd5?=
 =?utf-8?B?WURzQkFjYmp1ZVBCQmRXUGxKRFU0dkN4UFpNUmV3YnIvU1JabVRMOTVIT2pJ?=
 =?utf-8?B?NEJJNHFtT0hFaHlZelhJbm1TVVRDd3VGaE02dkdpYnVoNjl1TkJPY2xzMENL?=
 =?utf-8?B?ckQraGZnaGI3K09nRFh6WEdha1c0eDdhcFhoYUpYYVFOVmdUd2RtS3JPKzJ2?=
 =?utf-8?B?K3dsUStKME96ZkpwY0d0dm5FTWFOemNxVzdaZER0K3dRRVF5SWJOaVFRTHVW?=
 =?utf-8?B?WnhkSGc3aEd0em0weUxpcXI0dDkza3pXVHQyRVF6eDhCYTFQZjd6SE5Ob0hC?=
 =?utf-8?B?WnJDMDdpS2NsczdhdjNFdTlabGN5eUl5bGdyWURPaG9scGRGYmhqcnpzcXBj?=
 =?utf-8?B?VVF5UStyelhZY2Z0cWFjdzVSL1VVZytwWlFiMXVCQWFaZ29UWWhzQkt0djZQ?=
 =?utf-8?B?K0ZPQ1VBYjNma0pPZDJTZGE2YWNuRzM2N0JVcDdEb2VJWkF2MjFPU05IdDAx?=
 =?utf-8?Q?/OX/74M7llPRyQkfZZyhQX+g0m35jiU8LfbmT+n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzU2ck1UekJLTkYxcXM2ZmlPd3loejJqaWN4S016T3pHcUx1OTJjejhDRnFw?=
 =?utf-8?B?ejREcEYxRTV2SjJRSUZMaE05L3N0RUlSMXYvYi9DejF6SDArb0NONG4vUUF1?=
 =?utf-8?B?NDdCK29YY0dhU0NJVmZmbGk2SFZ2Slh1NG1pUG84aVBJNzl1WlRiMFVnbTZn?=
 =?utf-8?B?RVZzOWVVd0VyUW9MSXhZdFhmSGl6eU5wT21YUkFqZklPUmFMWGtxeVp5L1ZR?=
 =?utf-8?B?dFFCUzMyRklIVlpXRlNndGxROGRQZFI5MEduQUkremcvTkRGRGRSK0I5UWxl?=
 =?utf-8?B?akJUaHNxMDZGdjhLS3ZmcCs2UW5hSHM0OFhZK3E1N09NQWJPNWdFVXJNNmJM?=
 =?utf-8?B?SldCT1FMMitCdUhnZVY0UkR3a3BmZ1hZaHpzU0xna1l1SjlIM3VCWms4Yjdy?=
 =?utf-8?B?Y3pVZzFxUy8yOC9oU0piUFRTRjRRdWNHMFdDd0R2NTlsZTJOYlErODBuT05v?=
 =?utf-8?B?NGN2bHVDOEkrK3dQU1BQeWVZUUVibTdSekRMK2ZEZ0dsUXhvdHJQdjc5MTBM?=
 =?utf-8?B?cDRGcnIyWkdzRmNWNUZWdVNLRVo4UXloN2VGUFZBbHV5ZStock5TeFJiL0RI?=
 =?utf-8?B?SkZjK0pKQ0ZRZVJUWldwZnhTVWdNbThrVG9yUHNIaXg3bWI4UUdxY2kvcE5O?=
 =?utf-8?B?Ri8zQXQ2RVRyM3VyUzBtSGFCVVF1ZFJ1TngxRjhmdytEam52S3Q4SlRETmFI?=
 =?utf-8?B?bkhqRUhFYlVTcmgwNHZZZElISU8zcURTMVEzK2ZZVElIb0MzVjdSWHhPcVVv?=
 =?utf-8?B?YmgxRTU2UUdROXdhWlpoTUtueDdBVTJ4Mk9hcTlEK2RnSFgweHlNcW94cEc4?=
 =?utf-8?B?aTYrUHdTOWxoZkx3NXFaNUladlVWejU4aEdnZDZjMFl1ZXZQbTNvUm11VVZ1?=
 =?utf-8?B?dkhtVzhYMlh2Y09NRDRmTTFRMytBc3lQeWZjTS9nMTllNmhNVzZJaTFBOVV6?=
 =?utf-8?B?UkZQYjRWSnNsN3ltMy9TeFl3ZlQrSHkwbXExemxjcTNzK3UrSjk0MFp6Ykhv?=
 =?utf-8?B?NExERWxkZkZDeFJBM3o5TVFOU0hYVGNaNW5sTFh2bVYxK2t5SUNOOFZZVTVB?=
 =?utf-8?B?VnNabFdIU0VCd0NNQWJEWTNIVk5ndVJqcE5VRDZRTjlYNG9KUklIeDFOVk4z?=
 =?utf-8?B?cWJhN2tDY2lnMXIxUEJsMU9KN0gydHl4d1B0MzJUU25nVG9jRm93aENQVDM1?=
 =?utf-8?B?QytEK3gzZWdLbEhZMkk2K0NWNVBBTzdDNjlkemVDS0FhMG5QNWMzOWtCMG95?=
 =?utf-8?B?bFVxeWswbFRKQ292NUFmWFJnaDg4SDN5bE5kaEtENWtGbk1XcVFoY1d4dWlC?=
 =?utf-8?B?NURXOTJaSGxnTFJRbmQxSVdYdWFXd1NYc3RwOUF1bXN4MTFIczRsZHhtcDRC?=
 =?utf-8?B?Z0tCYVBrY2cxWmNnSUFaOTI2QWNhSlR4Y0syUTFyQ2t3bStzalkxa1BLQ0Jm?=
 =?utf-8?B?SW45OFZMNjVQdmRlbFY5TmxESWxFQldUWjhzRExZVDZjZDdqT1JJa1FzakIz?=
 =?utf-8?B?dnM0aTRyQjNmYTFpRmRVemMrWU5VRXlCTkhNcTZJcUExYVd1OVh1M2FMZ2tR?=
 =?utf-8?B?cnNmc2NCUVh0anlaMFZIK3RRUmxkK090VzdwL3ZpUmdvN3poQ1JHVVk5enp4?=
 =?utf-8?B?TWNHci9wTEcvMXB6Y1cvcUxDRS8xNzZvSnU0bU5YK29HZVpKSS9uYjBxYXFZ?=
 =?utf-8?B?eVhyNFVnSHczMk5CUkFkS0lCenRHM3VNdDFHU09sRzFvSEJZTTd2a1lBZHFG?=
 =?utf-8?B?RExPSEp4Z2RQL1kvbFZoNGdLMENSU3JlRmQxYjB5SEZucE4waGtZckd0M2ZD?=
 =?utf-8?B?Vld4OGx6S2VkNkdKeUV3enVMR01xZFZNTzhDZ1R4dkFkbHlVaDdEYkRYaHYw?=
 =?utf-8?B?ZzF2VEQxTVBRZVpJSVlvRGU5cDJqeTE0VTUycFZ4TTlBaEMwQmRhLzcyTGVP?=
 =?utf-8?B?b3d4TjFicEhOaDU5TklCbkNJUWQvQXdVNFA5T2dnaWJMOVpiRk9xOGZPMHpw?=
 =?utf-8?B?aU5Za00xU2dYQzl0YllYK2JqOVZyVyt6TXYxTTFLbmZxckUyTlY3QStENUla?=
 =?utf-8?B?NTlHUHg3Vm5QOVAvdEVDMEplaXF5R3hNSWZMM0ZnZXkrVkMzYWczUnFYWkZM?=
 =?utf-8?B?QjhqSU42a09ZUG5VVmYyaFhRaHV4VDk2bGFpV0ZtUk5jeVFpZGZvdWZtUDgw?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b0abc7-3395-4ea9-3e8c-08dce242aa48
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:58:33.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+WfO1XzG3u+Mo5ClSE89sMmKLTlz4UKYAA4NQvRdHl0OPdQVQ3zLN+9ruQXWQeFS+8OIJbw0RQboMQ2t4jt26RYJcQ469K4hlJCe9k/6go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
X-OriginatorOrg: intel.com



On 10/1/2024 6:50 AM, Daniel Machon wrote:
> Now that we have indentified all the chip constants, update the use of
> them where a symbol is already defined for the constant.
> 
> Constants are accessed using the SPX5_CONSTS macro. Note that this macro
> might hide the use of the *sparx5 context pointer. In such case, a
> comment is added.
> 

I guess its shorter than doing something like 'SPX5_CONST(sparx5,
<constant>)'? Is that really worth it over the additional burden of
tracking that this macro accesses the struct?

> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

