Return-Path: <netdev+bounces-157853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B99DA0C0E6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264031887622
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDFB1C54B2;
	Mon, 13 Jan 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xo6a3VKi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F01C5D49
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794746; cv=fail; b=C16h8zkPD6Ubzr15WXsBkomRGbTkZqUlQ9hkSEGzaOSf9mKdSMrzyRG2lD/8B75ouIHEIDJhUov2w2KuhAZ8GLqiFWoOb4vOtHVk/7VYBWazayujulfMI0IgbytQV//jpqsQQZdnKZkcw7AhEjFNjHqG0QvLEAItXc5rqtS55DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794746; c=relaxed/simple;
	bh=RHsp69SPnPJ5RMdau5s1JLruKRe7QffhREQgUpR+gyE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t83oy4ANDfBDlePpSYji4Gr/h37+yAv6+D1o0YxW1HQh7fqGS3LJ0PZpAN6SZduH3xJuTKV+BopcUWLAFzrgnd88T4Zw9If85/9pmXyQFOQ8t2tsfw7lbQLm47DdCB62pIPN/14woSxK6A/H9Zlr4n/c7ybISsFlNwKVlhGyMXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xo6a3VKi; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736794742; x=1768330742;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RHsp69SPnPJ5RMdau5s1JLruKRe7QffhREQgUpR+gyE=;
  b=Xo6a3VKi74GPIiPP875jV49S11ohwAF8Fbug5AziEspXdeFhFx4w7sEa
   +HB3wlr7Fdv7FLusEf48YcgM/K/rZ5q1r7B2TttOrUrK8/ewi29yXjIWQ
   +BYlNVvf7d3Wd7YO9pYxckip+p/GzMxAXcCBzBU2ldBJqdSd13Q95L/OM
   fDpH5RP4noaJKN443BzCSRJzZMX++UDejc36Hg4+YA29br4erTchLm+ro
   0UMKZFGfwYEbOScXVwvFoKasQZDVJ3dY1GjZmIWP5/UAN68LeBE7KXtax
   rmMOgy8E3dxXK/P5ZRBGZa5AAokrVHdTU46MH3FBjgxd7fzHYHl36mbnM
   g==;
X-CSE-ConnectionGUID: S4tW1ncTR5uNkmtYaW3ulw==
X-CSE-MsgGUID: ePlwzsyUR52y7ttbImOr2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40750566"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="40750566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:59:01 -0800
X-CSE-ConnectionGUID: OKlCVjAjQXKY+Fd81auehQ==
X-CSE-MsgGUID: G8d34C7ZS0GV4qbb5nUx0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="109501362"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 10:59:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 10:59:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 10:59:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 10:58:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ2TSzUtMahwDXP7Z22XlK+QQjlo15+cgFE+t+bunFwrSWAVNTUVC8DevDro6+T71qCaP7DyYI6rhtaRJ2CplS31ehAEgmEONsAdMq9x4TAkkJmGMI9cTVRacMLph2qtyBD3yXY4BOg41N+TU2wbpIhGF1kYrAioFc1ZpQTrtK3d83btj4u6pV5NqIGb6cn+R1nWeeK8J6qJFHqBWIUX/aejPyX7DDlG70rNmv0Iwf3E4P4vIP0opxEpiuSra7mxstuYmvSYoRGZD2ZSnruDx7DqixxMNr29Id9GU0KnI0mepFhiPGXp82PjfTvxQJJSwZxnekQOJ7g1m8g3uKtJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO6s/FzpY6FWl/Xv2elRt9KYFLE72HCNNbC4yxhxDAM=;
 b=R1k0g3vNpf8vnM20ctxOaavOjxS5P3d9i0EythP7ns/GkEdQKAoGkEc2e0It9NOVqOz8QXs85Nnlbujw+mty4JKIhAa3jAr6C48tXcNlMw2RywTn4PD3368hRfBHIT4TXCSaMxeEbyHcBP4v4HXhWemW8DQFvQLWzp4bIm9xxL70ff6kUsX6Ti8ZuLGQk1SX6ridyF22BfUmkgwq7WF098M5PaGVVmVAZLTQbUkpVXRvIqCZs4Ocwpos7rlwWeqCkF4Za/lh3PsvsXBaaayL41embCs1oC9wf4eVMuoURlGDkgSFCZSAKZPnZ39M17BXEQIqwR70h6G57RE0m4DB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 18:58:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 18:58:29 +0000
Message-ID: <f4bc1bfd-11b1-4b7c-8139-4a2c4b155ef0@intel.com>
Date: Mon, 13 Jan 2025 10:58:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/8] net/mlx5: Fix RDMA TX steering prio
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-2-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113154055.1927008-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0b7e64-9532-4fcb-6a54-08dd3404445d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L01rR3dqZ1ZkYWJ3Y1pzSkhtVG5KdlVmK2s4TUtNNXE1L0tnUzN5YVlwU1lJ?=
 =?utf-8?B?OW0zNWJzMmVMSlRpc2hNbXdGUWwwSGIwSSthMzNBNWViNzJ0cWYya0JVNFNQ?=
 =?utf-8?B?Z3JJeWtwQ0JnUnk0R05sbldad0wzNW81dmJBWCtqYmNFYUl2Skx1RVdCZElS?=
 =?utf-8?B?MzhlK2diY2FzVElONFZBSUhTaXR2OXlUY1ZERDMxUHdTbVVDMXgvc3c4YnlC?=
 =?utf-8?B?WndEN0JtUHpEb2FHMWVHdlZBT3dCdEdaTVNZb3gvYmpDQk9xbTRlMWhrckwr?=
 =?utf-8?B?L0ZZdi9wcnFpYmR1SG0reVVYeENpMlROM1o3VXp2a3F3eVZsTXU2dzZtWktE?=
 =?utf-8?B?cjhrOGtCRVN0L3M3UVVGSVZwMm4xUW9HQnUycGkrNUJnRkgxZ1lTZjZsd0V3?=
 =?utf-8?B?KzI0WVJ6dGRNOElwN0lrN1pxN3RERzR5NVpOOVBQdGxYbmdma29MUjlVNEF2?=
 =?utf-8?B?VllOVENjRU5pTnRzLzFwR0g2QitpN3NlcTU3dWJQWTU3b3Nqa0k0VzNYTmJL?=
 =?utf-8?B?RjBId1NKQ0dON08vVXplYThSNC9qTE4xTXlVaG9PdEttejVldTVzNlNrcElh?=
 =?utf-8?B?NGtBNlZyTFZacE5aUHh1aHRCNVRJTWdwT0lCcy9obXBwUFllZlNMN29PVmRZ?=
 =?utf-8?B?RW9ZVEYwWUg1My9WMW80MFV1UUwveTBPcXBoaVJJR1NEU0VabUkrVm9DNzBy?=
 =?utf-8?B?SC94UStJREV0dXNCM2ZUSlNwSVQwR3I1U0ZtMWgzdTZLazZkZTI2OTZKZ1Vt?=
 =?utf-8?B?b1QvZUVQMncveWRYSVViMlk5dkFFeFNmbExpbmdaRHp1M2NzMm5jazI5bTgw?=
 =?utf-8?B?ZkVZZEVsd2tJc0tPcmtwLzF4RnZFQ3RjSktaSEdOYXY0TzFEQVlvOStsemli?=
 =?utf-8?B?V2RtSmlHNzdNS2dFUkNUNWNYSnBYRTFyMjF2VkxMN0ZVaG9ETWdBNEIvQ0h1?=
 =?utf-8?B?MkUwR2ZVbHp1bk44bGtDV01oYzJwd2lxZElnTlhvZFMxbmhZZUR5UWp4ZHps?=
 =?utf-8?B?dEt6ZitvbVNIOFoyMkdsS1YxYTBaU0pBbUE4cUZVQ2FTbnNxSFlVRkVGWVRq?=
 =?utf-8?B?QWM4VHU5UndidnoweUdTL3dxZXpwb3B2TFJUWTFhM1pnbnZPSnBnekpWY3Rz?=
 =?utf-8?B?emptZlp2SVhLV2gxZ1dmWC9sd3piTzFRYk02V2pnaWdFeFRPVGJPaVpCK3U4?=
 =?utf-8?B?VzlZSTlVak85d2tkR0J3RDRPOEVvUTIrMDJNUlQzb28zMXc4dGNXV08rMkNu?=
 =?utf-8?B?djFUY1VKUDJHKzZKZzRPb2hReitSbndGM1c4Y3ZPZ2lTYi9XTmpaaytsbXVz?=
 =?utf-8?B?Mi9ZWVZrL1I3Wk56NXlOTzVhOHl6Qk1lc3drclRiK0QycE5FOXlrVFBMSjJH?=
 =?utf-8?B?OGIvM2haMENsWnFDalZuSXFRYUtxY0hubHUrTWN4Ylh6MEtBLzJ5MW9lMnJV?=
 =?utf-8?B?WVBEYmtGeWRlMjVSRTUyUFArN3hlRWdSeDQ0RkRjdWg5TmNNcmlscDgySWlr?=
 =?utf-8?B?SVNNNndod1Evc1k0ZmROVXI2bEF1M0pSb2xWblBGOFovem5hRU02VXhkamQw?=
 =?utf-8?B?QVZMKzVQMVZRMndQdUxQdTZrWnV3Rkp5VXRTRlFtVXlzVzBpS1o5YnpnbXNW?=
 =?utf-8?B?YXZVbjJNU0lOSFh1cFJ6cXZMa2JhMUV3enJxSE5rODZyeDdJdjVyYThXQzBp?=
 =?utf-8?B?eEpKUmZaOU4xT3ErT1hPWTZycGd6M2haNysxVnNGc3cxVHIxUFI5dzR3YjU3?=
 =?utf-8?B?eVJBVlZ5S0pWYjNmUFZxRmJnV3dsVUlGQTVoT2E3cy8yRlZuYU9VNElWRGJF?=
 =?utf-8?B?Mm0ycGtIdFUxM01mZXNlanh5aWtXdVlpdjhTQlQ3ZTFKWHM0YkpjWU1ua0JZ?=
 =?utf-8?Q?op8VaJ8UkEEeJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRvNUIydFJOYXFEMkZFM1IrUDFzWTU2T1lFREI5cWw3VjNKYXhEVDJNbzZ2?=
 =?utf-8?B?SkpvYVhNa3pBZ1BCS2FzQ2FzSlFlV2ZzODExb0tNeHRmVGFnTjE1L2l0QWpJ?=
 =?utf-8?B?ejFvZ0lKTktDdVlUTldQdW02Mm5WUzZ2S0ZIUHBaNmxaSzRpcTVETlluM09m?=
 =?utf-8?B?bUhaWEtqUXlwQ0FBZ3pjRzFmSjA5THNTNjArOE5KZTJwK21qRlBwc2Fva1Ja?=
 =?utf-8?B?OVMwYWNZQlJoN3hYcGNmdi9aVHRMTlJBQWZtTklKelg1TC9yK0FOUEZQSVpV?=
 =?utf-8?B?MTl1V0Q3c0tjNWl1K3RZNml4VXBQYnlXL1BReEUyeE9LMjBWbmJaRm5ZZ3hN?=
 =?utf-8?B?aEY4bitqTUVUMjliT1FQaHRJTUF3VWduVWd0V0JRTXRuK1E5NFg3b3M4UEhi?=
 =?utf-8?B?cm84alZJTWczS0NoRXh6U1JGTFA3MXVuU1didWFVRGVqVVpoRXFtRXMwVHVS?=
 =?utf-8?B?ak5aditQVkJ0dXN4YnpLNU1TYmp5ZVMxb3pnVGllZjMvMXBWc3I2UGVPOEJP?=
 =?utf-8?B?c1dnSDRFai9FV3JwWEwvQ3k2aG1CMm1mRnM2Smo0VzZYdDA4QmpMQU4xeDFV?=
 =?utf-8?B?SjVjLy9QY0pndUc5c0J6dFlCbEVHT2R5YUxrOStyTFNvZGc1QUxNNVIwSmJG?=
 =?utf-8?B?WlR6SjdZbHVIR05RSSs1cGxBU3BCYVBnM0tPMVI1MmNXcVk0eVdsbFNHSlJx?=
 =?utf-8?B?NDUyYVh0eGtHUkF3d0d5VE93K1p2aEtmaVkrSERrYXlhYnROdzUwTjdNMmk2?=
 =?utf-8?B?bmZHMTE5b29WNXovdVhaZ1NuTHpXOHBmb0Z1VzFDWFM5UEF0cWVldG1XbG1D?=
 =?utf-8?B?UndzdHFzN3dBeVRBaWs0bzNRTWZibWxkMFhpZklJTzJxYmhTYkwyV3dSN250?=
 =?utf-8?B?UmJlUTRCMExDYUtHZlNOclIzVUw2LzZ3MTlYNmpacmxTTlFSQUg5SWx0bDd5?=
 =?utf-8?B?Z1J6UVpjSVZJMFFCK1dWT2t2cG0xSERvTVQ2ZTBhZzlnVG9GRzdHYi9nUnFQ?=
 =?utf-8?B?TUErOUVhOFBvLzFQalhrK3VvT09IcERNZmRMdzlXQjJpRGNTQjgvZmhQSG4z?=
 =?utf-8?B?SUtlNUJBWGp0S0pNUitWcDR5T3hyVCtjWTMrMURjczMzM0Y5YXhpNDdiWDli?=
 =?utf-8?B?bmZadGhCRDhVcFF6VFlDMjFzMlY0eEw1SElBWG4yODRlV3F1bTZOL1Q2RjRJ?=
 =?utf-8?B?ODU2WjRXSGEvS0UzWXJMMllvOXdsM1JLNGdXLzZSNFo3WDNNeEo2R2pNY1ov?=
 =?utf-8?B?dmxaYnlrcHc4bmxtTU9LdG5rTERiVm4zaHlLMzcvTFRKL2J6SUFoZ05VbE1o?=
 =?utf-8?B?a0p1SUFyMTI1QlJWM3RDUHh2Yk9RazByaW1jM2ZzVlRpeTJKbFZGYm54YjNL?=
 =?utf-8?B?YVpDZnpHT2JPQ3c1M0U1d0VsWjFta2JSdElTQjZsanRDOEZCUHpZVXhPWko3?=
 =?utf-8?B?cE56c2lsdmk4K3NUSVVyK1lEOFloZjZ4ZlExc0Y3S09NbE4xZnRsUnc0TlVU?=
 =?utf-8?B?U2YxKzNDMFRLR3MyRC9mUVlHdllKVzhnenlDYTVybkw1V1VDVTlmVFRTSWZz?=
 =?utf-8?B?R1Ziek1PeGN5WVF2VzRtUjhPTzdIanUzYzI5aXk4RUgrMEFvb0VqR0pVQ3VJ?=
 =?utf-8?B?WFE0SnVFZTJ2VlQ3UlJMQURMMUtsa1FLbndnK1UrT1EwbjBjcXI5NlMrZmln?=
 =?utf-8?B?U0hNMjdCWEJ5QVdnSGFyOWdHZmt1YmMxam9CK3gvaDNkWEV4RzVjL1Awd0ZB?=
 =?utf-8?B?ajdhK1VRdGFVZE1YVkRydEs3YnpBYzVBTUZIUnloSkp1WjFkd2hRelk3QjF2?=
 =?utf-8?B?T1FWaTFjZXlyZTVSS1N5NVlVUE80bCtUKzNRRVEvM2ZsVzZEWnJON3V1d2d5?=
 =?utf-8?B?NVROMjFqTmx5YkM5eFdiY0hLclJ0cWhxSEdUZU9aaGlOSkg5emJhRmdwWktC?=
 =?utf-8?B?SCs2UXhITkZuYUcrNnNrbkw0UUVOOU9wNVVGOFhMSkdlMkU0QXI1dzVQeVAr?=
 =?utf-8?B?M1l4U2VpcWRUUFlXUHk2b1RyS3NSUHJxWmIwWml1MUhwVjFwRGk5OWlXQXVG?=
 =?utf-8?B?V09hZWRsTUExVEE4K2VDbkNDeTBRWld0bzBtbm1NSXRKamFuNEd3VVRsRmNs?=
 =?utf-8?Q?1RJieWJdGMRv6AJ1sZWIA4tLD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0b7e64-9532-4fcb-6a54-08dd3404445d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 18:58:28.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAxWPedt7GCBT5O4Qx7LrHVTP3R97alTCOswM0S16QkKne085K29NHQRJELPZmvLeXZy95mEexBHaWhri4X4+HouEPNG+ET0gy54BhhF+pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8508
X-OriginatorOrg: intel.com



On 1/13/2025 7:40 AM, Tariq Toukan wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> User added steering rules at RDMA_TX were being added to the first prio,
> which is the counters prio.
> Fix that so that they are correctly added to the BYPASS_PRIO instead.
> 
> Fixes: 24670b1a3166 ("net/mlx5: Add support for RDMA TX steering")
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> index 2eabfcc247c6..0ce999706d41 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> @@ -2709,6 +2709,7 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
>  		break;
>  	case MLX5_FLOW_NAMESPACE_RDMA_TX:
>  		root_ns = steering->rdma_tx_root_ns;
> +		prio = RDMA_TX_BYPASS_PRIO;
>  		break;
>  	case MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS:
>  		root_ns = steering->rdma_rx_root_ns;


