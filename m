Return-Path: <netdev+bounces-167930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3813A3CDDA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A9B166B0C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0525C708;
	Wed, 19 Feb 2025 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4KebqJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAC1DED5A;
	Wed, 19 Feb 2025 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009088; cv=fail; b=ZKvnKTn/2YycTJvSQXfZgZfFH9/0t3Npl1zlHnsyyMQXylvBaDsT7J+USKk3bkAZIPbKg5uSeGvNGjVK+Kk/kJ5igfW9J2aj8DJpJDfLELMDHdu1hawl9yrDc/uaVmnWkRQ/pL6IEfKNacGn0BBcVnb6YPUfCkVqpk0AYNGQaf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009088; c=relaxed/simple;
	bh=ZPTJ2GUH/BllqIfzVnqjgb55qYw1F8zqWzlxqzvKi60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jp3TyabnKEkfqEZSDqeFNbmo0pM6RaAIXvP4DCaOtOr69pYY5Uv2j/NLulkJHs1slTz6vwgZ2x0koyhulvmv58Ghq0QFoW1Mhj0RIOs+4rBB+wzszbwVCWqAlFLAqi4gqRGRm2GydgT9S4ECdc5e3HejB2DDAPCpBBdu36+l5U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4KebqJZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740009087; x=1771545087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZPTJ2GUH/BllqIfzVnqjgb55qYw1F8zqWzlxqzvKi60=;
  b=k4KebqJZIeIHJN16fHYd4b013rEJBTCeons7EQ3Q0RjCokFJzHSp1Uu6
   VWBxFw47abp7ZTzuTN7d3VdW99sznzV3ib/HFOkENxzYQcZXMNYsQuIsA
   LkddVzbhNiuOUfVGHbRzzcx0J2DONW2X4SKKwKUPX0Qv73aCn2Xw0i2QK
   uhdZXLYM0Ey86R03OpCAiowSGByXK+eTdIubRz6XCvfYCANWusHRHU9fF
   ZyaD3sXzE41+G7+IJANBVkbamE+tH3sqfC7keqrws1sVQwzjE9WTb4T86
   Bd6uBCTOugQNq1mzZ2Tet5e/ZDTjgJLk/KYUGp5BzP9xxwJBjLD4HPiyV
   w==;
X-CSE-ConnectionGUID: m6cHRIyKST2Z7KX9eP+hSA==
X-CSE-MsgGUID: 3S5Pog3KQICoFnMS4QWqcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44688332"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="44688332"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:51:26 -0800
X-CSE-ConnectionGUID: UYf6+norR7qmH51LYH0sGw==
X-CSE-MsgGUID: VXOT6rfVQjOh7BUB/yCefA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="138065218"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:51:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 15:51:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:51:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:51:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkF0B0Kwmg5dtZk/6Jeqgm5S/zVzW+hH3pdf8WEa2eu1Cxh1VCXoPbuVx2Y1ioVWVytIJxTC0d3hHCfhBdE2M3OWrxRN2zrMAaSLmY4zdNlg7k7vF1MVOCMy64iE2QX1dDu2jRYNnm2xfZyimK7wCqs466RDmi6l+R9FKd+jrujcUOhbirEyfGWPHKaBGJ84pIQ5MI5tFz7+kbJcmdFyktM+04xOa3WlTvvinAwBuIgfT267bEw8aXcbteyoQkLfTCZQjxz6RF01wUJNnymEanN8BlfGuBdImpN9xYm7nQvpdl6JR6jsleJw8Yjtwfyk2LGr4s/d6vCYuPbjSkNjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNahEweDkvFPPPyprea14l7RyRdOfQ/PuQ+KtY+0KfU=;
 b=Rhtg8/SuKwvZey6PffbZb1SlPlr+EWbukNSbCdl9cmJVHrg+U3ns3KzSHSc+/eSGq35wqwtVPEpsdzsy3sM0kw9Iq6N2ys+K6MAAIXbY/awzRpSpeKNKloUdAXGre1A822mMpEL6XeHA7GgTp16gYDWtt/KP6VWY7ZdvkFRAM4r1qGz5NvgV5mQIiS8UUmM67PtExRiOvetnjlQfAcUCP1C8LPRcMVVBCo5fOgtJP+IRueKYvJnOUGq0UjZAWV7csNzFjn0mD4So9TS6/gOpbRLeOsh7J8m29wgtLXOD2cXa4f3b7UJ6Z44/UJqhG9F8GwcT+dAY78x+LJyrrzmHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6746.namprd11.prod.outlook.com (2603:10b6:510:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 23:51:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 23:51:07 +0000
Message-ID: <4dc8e91e-6e49-48bc-bda1-1e32b5746648@intel.com>
Date: Wed, 19 Feb 2025 15:51:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: fix dwmac-s32 entry
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Jan Petrous (OSS)"
	<jan.petrous@oss.nxp.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni
	<pabeni@redhat.com>
References: <E1tkihy-004TEP-0O@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <E1tkihy-004TEP-0O@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:303:b5::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fae5f9-a463-451c-3a25-08dd51404736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlZwcitmRHlvRG1zY3EwNUdPWEI4bkRzZjYzL3locXIwZ3JVY1F4eFNSbll4?=
 =?utf-8?B?eG5Qd3V0eHlKTk5kODFUWWNURllrU2N3cFZwTDhpV0pCTlFxbnhzK21WK1BR?=
 =?utf-8?B?eDROQ3c3U2J6OVpDVkRFR1k1cjEzd2s1OUhkbHFJSjZ5MFlHREJZbHVzeWdw?=
 =?utf-8?B?bkk3YUxwbzRZZC8xVXJhYjd3SDA1dGcvNXNIUEVJQUMxVFdua0kxVVBtVFZ6?=
 =?utf-8?B?S0pmeTRMTFEvU2ErVFdzODhPUWYwTy94OFhiUmRlMDEvYVoxbk1qb1V5a3dX?=
 =?utf-8?B?MUhJUFlmYzNWZGV1blFlR0dMTm11alhyZEtGNDlLQUswdHJRVEd0dkM2NjVq?=
 =?utf-8?B?RDFKZFhXaEloZWJrYndkRlNnNGNGQ1BQZCtVL3N0dXdtenRENmV6M3JqNmtR?=
 =?utf-8?B?cUsyWDNhcFBaOUNaS3dqS0xBMjdHM2dJaHZ2Nlo3RzdCMjZBb090V1pLQUtr?=
 =?utf-8?B?Sm5FeitldEhFWDVLNW5lTllIa2ZEbUdLVzAxc3hUOEh0SmV2K0dOaFhseXgy?=
 =?utf-8?B?SzlGVTFSZWh4UXVXMThIWTBkRjNxbm5zTVcvM2NNUlFYZmtVMCtRRDBQeGpq?=
 =?utf-8?B?Q0F4eTg5M2ZTYldUNTJwQ2ViZUFXNHdTb0tMcnNJRnhiaVdRYmJEUmJvc3gw?=
 =?utf-8?B?S1FBbGdIeFJxRldpVFNIZDUrdmJqVExGVTlXK21SUk9vZ0N4VXNwdmovTkVu?=
 =?utf-8?B?RXpPZXk0Z1FuTXpNbzFPSWo4NkxJZVIveHliUEhEd01qNnBZYXB1a2cwS1h3?=
 =?utf-8?B?WE4rMURETGQrSE81WC9PQ28vc0oxZys3MzFJYnBJbG5pYVU4MkJ6Z0h3amh3?=
 =?utf-8?B?T0lGM29xUWVEWmZaaWoxU0toNEpSUFVMNTFsQUhEUlI2dVdXajRZUUJ1dGhw?=
 =?utf-8?B?NG9JUnJNelNIbytFNFRNR09VT2JWeno3WFlEWGRJR0tWS1ZYZ0hKbWpybFVW?=
 =?utf-8?B?NGR6dCs5MGlTa1RWK1JRY3lxMlVlVVQ3cDU5SHVrS0ZZQjVzVlJWVEVhMWdW?=
 =?utf-8?B?elVTVDVHS0pEVWIrT0pwVkx5RmYxb0dtQkpDREpXaWV3OEVteG9IcXFPYlZU?=
 =?utf-8?B?VmwzV05HUnpmQUpPaGFTekMrd2VWL0ZRbTlFUHpuRDQzSHp3Vm5uendoQzJ5?=
 =?utf-8?B?Tk9vU0c2VHl1SmpuMFZ5OW1LS0VjMnNDUllYQjJyMWRzUU1xU1M0dUtRWW8v?=
 =?utf-8?B?bWhQRkJ5S0M1TGJHS2FLK04rRk9rZVdXb2FZb3FqMkovWUpDQnhXYnFTSGQr?=
 =?utf-8?B?b3IvUm9hTzQwc2FGMlFQb2pFemFMTG1QNTJmN2h2Wmo0Wjl1Z0IrUEZtbjZD?=
 =?utf-8?B?a216KzNid2VYMUlvSDFQbHBrdHNvTVBZKzkzd2MvbHJpTUhSbnFxM1FqaE0w?=
 =?utf-8?B?eUptOTVrbGQ2aHh0cXBmNFBoay9sampBaFBYTDVVOGpHSDlySk5lbmhUbFN1?=
 =?utf-8?B?R1VsalZ1L2dPOTRCT1p1c3R4Mkd3YnhMKzBndlV3ZXNMOXVXbWFwZzJpTzJE?=
 =?utf-8?B?YllQVy90QjRwdUNZWDN6QTkvc1RpTHhKei9OOGVVS3ZHSmlOeVFYdDROKzI0?=
 =?utf-8?B?aEh6THU5V3BnWFYyb2NRaFJ5WDN3L0xmWVdBRUZaQTdtYTRtQTMyN1VDcmJl?=
 =?utf-8?B?Qkk4cXVwOUMxTms2ZTducVM3ZDJBdnV5VVUrT1l3QlU0YW9oMGR4SVNJQklT?=
 =?utf-8?B?ZVphOTRGcGVuUGV1aU53ZkZKWFZHMkRGdUdSaXlic2tPdHlEUUFHZTNTcTQw?=
 =?utf-8?B?eU82REJuZWd0a29ubmMrY3lMR2p0blhjOGRsTXIxcU5ZMllrQWUxK0J1OGI4?=
 =?utf-8?B?TmNDQkQrUHNxRzd0Ukg1SzVHM2wvOUg5RnJWVmlRd1g1N3RwTHl4QjhWZzRY?=
 =?utf-8?Q?vaN4z453Xk0GH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdLOStwZnZCRzlIWUtyZ2xPTk0wYXg4ZUVSclBoNW9uWEtxS25MemRocXk2?=
 =?utf-8?B?N3Nzb29lRC93SnRZUEpJeFhrYTNjTnZSZlZuNStKUjhmOFJsOUxwWHUzdGVI?=
 =?utf-8?B?bW9iVnFna3llODFvOFl3VTVwU1RzWUNtcmh6M2gwZ3BMc0VBNXBtVnhsNXM3?=
 =?utf-8?B?OHZwZ0ZDTWlpRDJGZ1lwYlhVRGI5VHV5Z0N3SUNHLzY4N2xNbnhTaWdoc1ox?=
 =?utf-8?B?TXJwSGM1cU4wRmNMTHI3eGY2dkJzRFFtY2tWTVBRcDRKb2xrcVNuQ2hDUnQ5?=
 =?utf-8?B?dzE5b0U4NWkvSU1hay9TZWl3QUpSMVl1SHJhVGlXeEJaZlJYMis1T0greXNV?=
 =?utf-8?B?eHJnUDZKbXVacjczbWFGSWdRUFlIaFhsOTJYN2hBNDl0OWc1cnRDNzQ0K3V4?=
 =?utf-8?B?WFZibDRMdVBUMlN1VnZBT2kraVNSbEZ5ZTJxb2Q1V2dYRVJidkM1bWtXQnVQ?=
 =?utf-8?B?QjFEaHovNE9CQWU0SzhDTk9BbEphT0duemFiYTJGVmpFTGlKVWFGcE80S3Qx?=
 =?utf-8?B?dVpheXBkbUUrb0MrZmR3QXdOOWpabTJNSFhRWmkrYytnTjZTc0YxYUo0Y2dS?=
 =?utf-8?B?eFRRZWdjalVrdVliOGlBR29zRVc5RmN4SWdrWXoxV24yc2RIMkxobmg1Zm84?=
 =?utf-8?B?M3h2M0p2S3hyRy9hK1BlbjVQZU9lQjJ0eFAzSlpreUc2b1k0dlVHNjZvaGVv?=
 =?utf-8?B?M00xODVvaFZKaHFPaEJwaExOZjBKeWZJZG8vYTZKNXVjOXk5R0d1aWFPWkxR?=
 =?utf-8?B?MitZbE4zbnFuMTViRnZHbElIUG1ha3BEeWk4Z3BJTWVoZWg0SVQ0aDVkZDFj?=
 =?utf-8?B?SU04YTRGeXNmQmdKajBQZzZZcU5Rbyt2ZzdqRUNEQnltSE5tOGdDN2g0TnZn?=
 =?utf-8?B?SkJabm1mQ1lOZ0MxazN6SFc2YlZpcE8zVFRyK2RBK0tTT0taYkFuS1BVZ203?=
 =?utf-8?B?WW5yOE5tYnlaUFMwRk5xR1U4eVM0cDNaenJsR0lic2l4ZVF1NG82dnlMaXRP?=
 =?utf-8?B?dE1OV2NaUm1qc1VhdExCZDF2cUNiMm5acnBDSzE3cHh1UnJaNURrVWQxK2tr?=
 =?utf-8?B?L041L2pCMWdoSVpuOHZxWkJsUFBLSjdMbnNGQWRSdGpyNHJsSFEyZ3p0OVVP?=
 =?utf-8?B?bU9jeGp2TnZ2UUxGSU5HNXZROENhSFZ4UDNSTllFVlVjZU1ndWsvN3RBdVJj?=
 =?utf-8?B?VzdHUkNmdTNUSWI4c0duNXlmdldDeC9ESlEvZzRwaTFSUXBERTlUR0sxVHlO?=
 =?utf-8?B?KzNDY2Q1Qmk4bEdIRFB0TWhId25EUkJCZno4NDZLNDRFQmFENkxVekRDM2lx?=
 =?utf-8?B?LzNQRlBma3JQYTE5cHNVNVRrOFNpN1BKaVhKK2QyeUVSb3g4WGRRTkhDN0lY?=
 =?utf-8?B?Z3c4SzA1T0FtM2dPWHZWdHFoYmI0ZlAzNGt2NWdHZDFKNzRCU3QxN1ZlamNR?=
 =?utf-8?B?UnU3T1Y5a2wzSGFYbVVoejlkSWFwMm5zVlk4YW1iWExqSFVQNkYzaGxWWDZi?=
 =?utf-8?B?SDhEOWJJS2UwM2Q3bzdUS2pic3lkc0loakVmSU9BTVBPU1gvb2xRTmlYc3JE?=
 =?utf-8?B?R0ZkaStqM0tKTzN5MVNSV1JTN0lVdTBCZVBSa0JZVXpXRm1QemdSaSthOVMx?=
 =?utf-8?B?KzEvQ0NzREJ4MXIvbGk4RzNCRmcwTXpCVmpVSVk0MWkveEgzZWVsRE9rY05U?=
 =?utf-8?B?MVMvVWxPRWNtWXZJR04rT0ppcWlBVWJhdnNBeFlzY21IR0thd1NZM2VmV1l3?=
 =?utf-8?B?TGtMRmtIeWVUS3hlK3UwNFlEYWcrV3FkR0JYMzdzL3V1QUs4WXhiayszdFBB?=
 =?utf-8?B?R0FSMzZiL1pId0FNVUVPZEhHangxYllQeFNvenVwR1cxbno3UklSSUozajJL?=
 =?utf-8?B?NzhjM1FaZTRBSk1qRFozOWQ2ckNvTG1VY05CUzhQM3NicXl4enEwRjBJd0Jx?=
 =?utf-8?B?UUpxeFh1ZFFDa0dXbG1hckp3aE0vaDBwTzJCVml5NW45bDZKWVJaTXJ4WHBO?=
 =?utf-8?B?d2hjdzkxZ3V4U2huU1BuK2tRKzBFN05HUkhwR2UwQnMxWDVBeFcvemZtV1VJ?=
 =?utf-8?B?TXhEZzhML3hIdmtucXdCblUyNTh3RkFDUFd3QVNmblpvam0rWENsVkVJK2xs?=
 =?utf-8?B?RHJ0ZWFBTzlKNGtDR1BiaEEwaWtFTmNRQVhwMGVlNEViZ0hNM3hFanFJRFNU?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fae5f9-a463-451c-3a25-08dd51404736
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:51:07.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I7eWB3JaS2Sygn2DEkMthOVcs44ayJ3sG52l+ii+nVfYxVsK6BIXs1KIGfUpZQUnFVBOJo4D7aJ76pCV14lH1CNjoNzcVPtWp7O+t/wd14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6746
X-OriginatorOrg: intel.com



On 2/19/2025 3:57 AM, Russell King (Oracle) wrote:
> Using L: with more than a bare email address causes getmaintainer.pl
> to be unable to parse the entry. Fix this by doing as other entries
> that use this email address and convert it to an R: entry.
> 

L is for mailing lists and R is for reviewers. Seems surprising that L
doesn't accept names, but I suppose that is reasonable restriction, as
many lists wouldn't have a relevant name beyond their address.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Fixes: 6bc6234cbd5e ("MAINTAINERS: Add Jan Petrous as the NXP S32G/R DWMAC driver maintainer")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bfcbe6a74ea..4795b6209711 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2877,7 +2877,7 @@ F:	drivers/pinctrl/nxp/
>  
>  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
>  M:	Jan Petrous <jan.petrous@oss.nxp.com>
> -L:	NXP S32 Linux Team <s32@nxp.com>
> +R:	NXP S32 Linux Team <s32@nxp.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c


