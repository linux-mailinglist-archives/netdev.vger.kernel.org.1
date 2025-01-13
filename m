Return-Path: <netdev+bounces-157729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A2A0B643
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408967A02F2
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080191CAA89;
	Mon, 13 Jan 2025 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xpe+CfZP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5C1C07D6;
	Mon, 13 Jan 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769814; cv=fail; b=MAIQlFB8dStWVnzaMDm9StbfCuntg+ohfcnqzQ7ff1zwYBdvSo5fUmRrv5NeoDfFM1HKOP3395PoUJUEbMlnBThD9Ep1CG/CRI0wZz7ZK4KyJ+a675JEsSUs9589yNLwazeZTuPvrewO9S/rlC5+uF2yQfqNgvrUjC4nMFMa7pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769814; c=relaxed/simple;
	bh=Ai5qOlATFOPAxxDn6pSDhIZyrtCsb7wvx5CoCLlrLMw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GkzNSeChMsqbyrP63p0LD9LqES0YDIWYyNy0Nz94f5clZx8lW85YnZHmjX9taalqKc7D1Kz3aZlvcUTWZAfY4yD7jDOxiMnlhDM14eeCBXUJdecvNHb2babSX0tuDq8kfyug6uUTTNPhh/zW5+pLkCKzoS76bE1J1KcRlrBHUAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xpe+CfZP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736769812; x=1768305812;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ai5qOlATFOPAxxDn6pSDhIZyrtCsb7wvx5CoCLlrLMw=;
  b=Xpe+CfZPso8gwe3IA4kRZiF4c7TtCL0DA0pSNr8pVm9iFkqfufv5FQhe
   9UYWWXujuRNMCKY94htQXC+TaMzqqxauiaQYUM0cLojdrlnLeLn5j48UN
   4c4t66RVW8/JdNCJ0SzpatNF7TxN3TUh6ZGokk2ixbKLeiYw74DqlXuaN
   996iFvKnk3g4dIpMwMD0o4A2gULxZExgduUP7eQZ/JI8hBPnnK1EecvJB
   pp9BEjvsh/NMaJyGJvepC7Skce10TlOppArZkCzIUC2CSahLS92J0umNo
   PGX5+h/Lo4l/IyhpWc4uStSe9j0FNRJLUv8FFLZa3vmPHibsMTC84lEYC
   Q==;
X-CSE-ConnectionGUID: uTYsYctCRu+6/9m4WBrz6A==
X-CSE-MsgGUID: SjqAXI3MSmyWaYedPla7fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47693532"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47693532"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:03:31 -0800
X-CSE-ConnectionGUID: HQ+cL42pTkqfjgXaEJeHDw==
X-CSE-MsgGUID: 5X3DBsCUSXqC0EQ6ZGoV+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="135273710"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 04:03:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 04:03:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 04:03:30 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 04:03:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm2yf3cbZQArk9DdORARaILFk+rLuMljJu9DEWpx+Xy+s2sWAJW9uvysIygqv1Xi64XlfXXlB/SAKYbDzmGMnoUMU7LxKmLtPP8CwfLBNPW3pSmJnjgnFqe5sScPLcRf69Uluvz35ABEgs4Scn2S7/3QwPlp/9rqkP/amKAiswbMlL098Wxy3evZZQRNHnOiYTBVrCLu/jwMlkj/uWOsEQb2LEOlengI8+zYabVQtJK8oE5qpjfzbbaeRl32hv4RLbxgqrHprsYfvOXUTon4y8QTrVBe0C8HodVGrBjV9+/pRQpei6/6DOs+aKoVcZA8uEcU+B5vi0f9XqynGzMBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFcviSFsewhZfpRuSzhj443Lzr5itag4HVGnSd2jT68=;
 b=kP6WcmqetxSxx66DsGBOPw6r88lBOVUl04yGBt4rpYS4CLiK1AaD6Il+k2r6/U5KYgnSj1uiXcAH1HlGwqySFqnN4TJNCvr4wJ03PQuKz8eo69FqRHyCJKyy/3msoWRFJtkh7gHSy1fft49ohxV+s8Zli9sTrg8sFfAHgw5lO/XwWs+U8ozXivjhCveIqtF59u47x1wjU23na19YbdYIc2CNI0GbHnwOlIX/mpRPDnOaPKYGVEeaIgzRG+R6mvgOeGyUnQqzDsJygcAc62mXILCgPNMXsQL6VDf8c6X9cDIerExgmfXCh0iNGJI6O3yyOrBOLrMKeVSddP87Jy9Aqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:03:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:03:08 +0000
Message-ID: <054ae4bf-37a8-4e4e-8631-dedded8f30f1@intel.com>
Date: Mon, 13 Jan 2025 13:03:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/3] net: stmmac: Switch to zero-copy in
 non-XDP RX path
To: Yanteng Si <si.yanteng@linux.dev>
CC: Furong Xu <0x1207@gmail.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	<xfr@outlook.com>
References: <cover.1736500685.git.0x1207@gmail.com>
 <600c76e88b6510f6a4635401ec1e224b3bbb76ec.1736500685.git.0x1207@gmail.com>
 <f1062d1c-f39d-4c9e-9b50-f6ae0bcf27d5@linux.dev>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <f1062d1c-f39d-4c9e-9b50-f6ae0bcf27d5@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0075.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f74640-cf59-4fc2-f2ad-08dd33ca3e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEJHeU41R1ptOHJIRFU1OEdtZ29HV1ROckM2K1hIaEhnMmNjS3dnM1VHZGJr?=
 =?utf-8?B?UjBwMnR0R2Y4MUJWTEkyY1RldnlqL2ZrVEh0S0g2bWU0cEFoazNqTXZKQUcy?=
 =?utf-8?B?ekt5aUpPeXJPS2V1Snl0UllqWU4yZkhqdHhhYkRmTzFHeE8rSGxMUDdVMzRX?=
 =?utf-8?B?Qy9SUWRHaFVUQyttb0E1YUgzKy9PbTRtNVprTWJMR01mRlVxODVSMDUrL3RX?=
 =?utf-8?B?MkhnaU0rVXZkUnF5Qm5LTlVBdDVYNVovTUYxTENhQmV6T1hkOFlQZ2VkZUxj?=
 =?utf-8?B?cnBmVTZsMW1mVjNXbE81Yy9kNk16d2ZxMFp3ZEJGMEtUa2Q3bHpPY1lKUVJC?=
 =?utf-8?B?YW1qdG4zZnE3ZTJXVURmNU0xaERmVWNJMjFHZVVJYjhFRlo2QWVtYWNETE9h?=
 =?utf-8?B?K1ZiR2pLclpjeElDV2NGdHArMDZ0YjRtMTBEQVlNTHlBN2JPcE5pZ0ZHQlBM?=
 =?utf-8?B?SFF0L1RwUXhiOXl6OVhjUEFKcCtHUll6MnpSYkdIbTFrRm1VOUFlTldCMTFI?=
 =?utf-8?B?eFovSVIwT1JLQ0lVSEFiUlBreUgrVTViRlJNR2RrTVRXME45c0Nwb3JhTGxJ?=
 =?utf-8?B?L2ZrY3IvTGhhM3NmS3QzLzV3OVVEU1pUdDFpTVhaV2VubU1RYVpyMTlmZ2VC?=
 =?utf-8?B?UmowVU83RkE2aWlRTk90MUpDUzVwTDVmUnhhZUsyYVpjWDIza01HS09iNXlM?=
 =?utf-8?B?dTlzdytXRFZsSzVFa3VYVWxPY3plRkUreGdoL21vWWVBRzN3K3RxcVRJNGpL?=
 =?utf-8?B?NjFLNVkwT1B6Rk5pTVNYcnFBSHZYdUloR1drNy9PWFRCMnlhWEZid1VacWho?=
 =?utf-8?B?WGxXc25xTU4xaVUyTzVyVkoyU2xic0RpYVVGZEFPSjdlK2x4SGpRbEpOZG9n?=
 =?utf-8?B?aVB6cUlBTEcvSGpjUC9zWjZ1OVAzd0d6WnJhM3l4elZaRGYybjYrdWVaTUF4?=
 =?utf-8?B?MDExdWROZkFxdTJnM3VObHRyMHN4ZHAwTkF0cjRUM0IvdkhmK2F4TEU3ZmFY?=
 =?utf-8?B?RjJ0UmVFQ3V6bkhvV0tYSnNNUVM2YVVmdXpKQW1kOW9sTHZad1J0aTRoY2ds?=
 =?utf-8?B?STBObytxRmNIeTBqa011ajVEOG1hZ0txdnh0THEwcS9JMldWU0Y1ZWNLSkV6?=
 =?utf-8?B?cUtWdFZ5bjBvQ3JqZC9VL2VEdGxkd21zTlZXeDg4bVBxbU5iR0pnWVRTdnlV?=
 =?utf-8?B?VlAzNlEyZDI4cS9KN2Nnam9hSCtnSVlMVFZGeDhBZG4yTzhmeDVWM3hUZ3R6?=
 =?utf-8?B?MlNYQ0I1L0lHY2VvNUNTdHBTSG8wcmR6RENhaEVob0tYRkxIeXRld3lCSWQ5?=
 =?utf-8?B?Y05tVk9RTm1aOVZvZlZraUxNZWtOWXJmL3FSSHB6VzBsU1pmWTdUS01YQ0Qw?=
 =?utf-8?B?UFMzUS83a01SQ1piSms1Mm9FOXpBNmt1a3BtRVRvZGtub1kvQ3RSbk5LaGM5?=
 =?utf-8?B?UW51eFpBQ2RBZ0doWDBsUDA5THBmZDJ5ejNVVGI0YWtJU05yWURxWHFZZWpi?=
 =?utf-8?B?MDduU3NlOXY0dkhjempFVXo4dittRGhGVzgxd1grUkYyYVl5VWhRQWRTUVlG?=
 =?utf-8?B?KzF3S1BFazFsVDUvSFFRaHlWM3E0WnBsYU9sRisyVUxVSy9EZkQzVk90OUw0?=
 =?utf-8?B?UFRmOVpYT2ZDcXdlZDNIdjk2UU5jREtsOW02UFlrRDVoSnFDSHVxSHZnWXJP?=
 =?utf-8?B?OWJMZmVOUVpDalVVOFk3YWRCMk1Galo0eFNhL2gxVENrWVdERTVYRUpuWEIy?=
 =?utf-8?B?UGJsazdRWTRnYndLWHNLS2MrcmwxRmp1OGx5Q2RKR1FwYkdoeUNMRGZkV2tN?=
 =?utf-8?B?dXMzeWo2emg2bFB0QmNwVndSRWNjc0RtOHlPNGNxcFlHREJWN01SalFmR0l6?=
 =?utf-8?Q?2Xg6UmVaQmD+p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWc4TGFLNWh2Y1JNRXZpOWwwY1dGYytqWkJKZ2tKN1htaVZOVXgzMUdCMjRZ?=
 =?utf-8?B?bDlQdE44UDJHa1BTKzlScUxOQVBoeU5tUkNCVmlrSmFvN21PNU5JaHNLZkl4?=
 =?utf-8?B?NWlLVmlXMnFlN2J1MVFTcFA2dkUvRmd2VCtZOXRFdGQ2amRLTTVpQWRWM2tC?=
 =?utf-8?B?UUZmWHZTTHptU2NTUHBFdEJmczB2WEd1Z3B0Y3N2QlhCQmVGeUZQV2FucGJx?=
 =?utf-8?B?M0plRlNaTDdsWVh4aHdsSlZibHM0ZTFoWjZVSEZuWlZtL3hZMDhGcm1VR0NZ?=
 =?utf-8?B?TDFOTzdsTTFpTHB4ck41TndEMUNJVlRicVpHYTVlUXB0UXNXUWlsdHNlS0w3?=
 =?utf-8?B?OTA4RmQ3QjhaVGNVbm9IR0IzWlp2V0VwbHNCdTFCdjZnL21Jc1dHdXRUVGhD?=
 =?utf-8?B?UGwrNnZpa1JLMzUyNU1IdEFPeWF2ZGxMQUZtalVFQVltNW5jdWEySVpuOEZP?=
 =?utf-8?B?WTlpZ3ZjL2VqYjdlT1hWRUg1NnNobWwweEN5cWRwNEJwZFBxdiswSEZoMTFo?=
 =?utf-8?B?eVY1dmY0ZHFiOTAzYzF6TDZ4Zzd4VXNJSzA5YVhoNTE4K0NxSFVuM0tTYVN5?=
 =?utf-8?B?Rys5WlkwZ1FZTmMrSGNIVnhYZlZ6N1VDODhHckczL1JkTEFWaTZLV005NGFT?=
 =?utf-8?B?WHk4KzMzRVFFdm5SNFA5VTFXbVJRYVUveGc0T01Sc1ZZdnU0NHV5ZklFa2pz?=
 =?utf-8?B?T3FRYzh3SzI5ZTBWRlVQcHBIV2luRzg5N21DTTBIdnlyYk93UWJIVkwyMTF0?=
 =?utf-8?B?ZkdpRG9PekxVSkhTcEJYTVFha2g4SzNEdDZnM3BGMjBZMmZCdFBsSjJlaXND?=
 =?utf-8?B?ZzVMY1lCZzlFRlBFbnRXcGM1cGh4dCtFcHJ3eEFNSnc5OXNpMHFIOEMyZUx3?=
 =?utf-8?B?RnhucHRmcWlNZzVmcUs0eXRvZUQzdHh0NlVncUs2K2gzTlBObXRvRzMwYTgr?=
 =?utf-8?B?RThjWlVnSkVDZ3JKMEpaNjVOT0pWWkh1dnpLWkdyOTFMWTVLQnhDTzFzcklV?=
 =?utf-8?B?M1hsdGFnTzByTHI3bTVkU3RXL3JxRGlrY3ZmL0VvSUR4Y2VDNCtQellLaFcr?=
 =?utf-8?B?N0dVTVFwZnpKWnhZR2J5OW9RS3FHMUhFMU1KSnh2SEoySDhhWFhSd0ZWTGQ1?=
 =?utf-8?B?UDZic3V5b00rUm5KbnRvSWtveEJJUWVxb3VPcEIxR2JGRFRFbmxRUTdFTDZy?=
 =?utf-8?B?MHk3ZGNDMGk1T2tBbDFEdlNBbXJ1TGMxbWUwQTlHUTk3TzcrTys0dXFjMWZp?=
 =?utf-8?B?VUtEU0d0VWt3dE84Z2Q4aThZeEN6UUpTbEUzL3ZmYTIvdkZaRTBBRStKaHF4?=
 =?utf-8?B?VDV4aFlIc3dUTmlNdnA0bU5ycUhDVzdVc29WYko0eE9lZndRbld6UDNYY2M5?=
 =?utf-8?B?eGRGbjdhYi96MWp5Q3grN0xpL2NuYWFDUER6SmRjdWVJT0xQRHZpUm0zZGNS?=
 =?utf-8?B?M3IwL3Nmdk5FU0piMnArZ0h3WWdIRHFCa3MzR1BVYnpqTUorbE1aZ1I0VWhS?=
 =?utf-8?B?K1E3Y1dpbFZNNXBEWVQ4Sml1eDNwbVVMSTNJR1V5NDEwZXNKVzlPWkZ5SFJp?=
 =?utf-8?B?OU5LbmdFY1R0eEtSdWJ0ZXd6cGJKY3U2SWN2WWFsNWNjVkJSOStnZUczdnll?=
 =?utf-8?B?UUJKdDBGcGhYYnMwUnhKdG9obHg3bFM3SnRhTE9kTlNjS0Y3cjRPaWxvK255?=
 =?utf-8?B?RVRML3I4bmFBZ2EyTW9Xd3Uyd2wrNWdxSHppd1pWTUxmUkJJdTkyZjF6UG5Z?=
 =?utf-8?B?VEN5emt5Rjlwa3RKbWhVMEpOYWh3aFJpUnFtb2dhRDV1ODA1K04xK3NBM0s5?=
 =?utf-8?B?WE85YlpLeXI3RUMzZU1LdVZUZmNvSHY1OTdhd0xmK294SWZ0VHNQSU5aaW42?=
 =?utf-8?B?VERaVXFselJ5dGtsbnBmVFk1aEtCNENCTG9mVW9Od2VwSUsyWElLWnhnbHNa?=
 =?utf-8?B?YmxrRWxaWllhQTVlK3JlMmVmQmsyVEMyRHhSOUJHSml4a0twNG5Zall2ZGlt?=
 =?utf-8?B?UlFTaGEybVRYY3hZeGpKVjIvK2VtcEk3MHc1TU84VUQ0OUpCVHMzMVR4cHlI?=
 =?utf-8?B?MkxNWTd6b1czY1hwOHZSZmFSUUcrWGp3eUhtUE9GV2NsMUVORFdQNVR1QllS?=
 =?utf-8?B?NGl2dVR5SHZQVExuY1A0cjNrVEp2WGNWR3ZDVkRyZ2p3RVVoUFRXb1FVYVpB?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f74640-cf59-4fc2-f2ad-08dd33ca3e52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:03:08.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1NqRzoBLNrkO0hBz+40/U0YxuxOfIFmExinjBnHwU77kDecdcpPDTGx8gb53YFyPwkrLOBxrUlCVbqj/+yaWCFyOfEOdUOwigB11dljgC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com

From: Yanteng Si <si.yanteng@linux.dev>
Date: Mon, 13 Jan 2025 17:41:41 +0800

> 在 2025/1/10 17:53, Furong Xu 写道:
>> Avoid memcpy in non-XDP RX path by marking all allocated SKBs to
>> be recycled in the upper network stack.
>>
>> This patch brings ~11.5% driver performance improvement in a TCP RX
>> throughput test with iPerf tool on a single isolated Cortex-A65 CPU
>> core, from 2.18 Gbits/sec increased to 2.43 Gbits/sec.
>>
>> Signed-off-by: Furong Xu <0x1207@gmail.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +++++++++++--------
>>   2 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/
>> net/ethernet/stmicro/stmmac/stmmac.h
>> index 548b28fed9b6..5c39292313de 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> @@ -126,6 +126,7 @@ struct stmmac_rx_queue {
>>       unsigned int cur_rx;
>>       unsigned int dirty_rx;
>>       unsigned int buf_alloc_num;
>> +    unsigned int napi_skb_frag_size;
>>       dma_addr_t dma_rx_phy;
>>       u32 rx_tail_addr;
>>       unsigned int state_saved;
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 038df1b2bb58..43125a6f8f6b 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -1320,7 +1320,7 @@ static unsigned int stmmac_rx_offset(struct
>> stmmac_priv *priv)
>>       if (stmmac_xdp_is_enabled(priv))
>>           return XDP_PACKET_HEADROOM;
>>   -    return 0;
>> +    return NET_SKB_PAD;
>>   }
>>     static int stmmac_set_bfsize(int mtu, int bufsize)
>> @@ -2019,17 +2019,21 @@ static int
>> __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>>       struct stmmac_channel *ch = &priv->channel[queue];
>>       bool xdp_prog = stmmac_xdp_is_enabled(priv);
>>       struct page_pool_params pp_params = { 0 };
>> -    unsigned int num_pages;
>> +    unsigned int dma_buf_sz_pad, num_pages;
>>       unsigned int napi_id;
>>       int ret;
>>   +    dma_buf_sz_pad = stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
>> +             SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> +    num_pages = DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
>> +
>>       rx_q->queue_index = queue;
>>       rx_q->priv_data = priv;
>> +    rx_q->napi_skb_frag_size = num_pages * PAGE_SIZE;
>>         pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>>       pp_params.pool_size = dma_conf->dma_rx_size;
>> -    num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
>> -    pp_params.order = ilog2(num_pages);
>> +    pp_params.order = order_base_2(num_pages);
>>       pp_params.nid = dev_to_node(priv->device);
>>       pp_params.dev = priv->device;
>>       pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
>> @@ -5574,19 +5578,20 @@ static int stmmac_rx(struct stmmac_priv *priv,
>> int limit, u32 queue)
>>               /* XDP program may expand or reduce tail */
>>               buf1_len = ctx.xdp.data_end - ctx.xdp.data;
>>   -            skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
>> +            skb = napi_build_skb(page_address(buf->page),
>> +                         rx_q->napi_skb_frag_size);
>>               if (!skb) {
>> +                page_pool_recycle_direct(rx_q->page_pool,
>> +                             buf->page);
>>                   rx_dropped++;
>>                   count++;
>>                   goto drain_data;
>>               }
>>                 /* XDP program may adjust header */
>> -            skb_copy_to_linear_data(skb, ctx.xdp.data, buf1_len);
>> +            skb_reserve(skb, ctx.xdp.data - ctx.xdp.data_hard_start);
> The network subsystem still requires that the length
> of each line of code should not exceed 80 characters.
> So let's silence the warning:
> 
> WARNING: line length of 81 exceeds 80 columns
> #87: FILE: drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5592:
> +            skb_reserve(skb, ctx.xdp.data - ctx.xdp.data_hard_start);

I agree that &ctx.xdp could be made an onstack pointer to shorten these
lines, but please don't spam with the checkpatch output.

1. It's author's responsibility to read netdev CI output on Patchwork,
   reviewers shouldn't copy its logs.
2. The only alternative without making a shortcut for &ctx.xdp is

			skb_reserve(skb,
				    ctx.xdp.data - ctx.xdp.data_hard_start);

This looks really ugly and does more harm than good.

If you really want to help, pls come with good propositions how to avoid
such warnings in an elegant way.

> 
> Thanks,
> Yanteng

Thanks,
Olek

