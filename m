Return-Path: <netdev+bounces-186346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA9EA9E8BA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 09:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E66A3AF4A6
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED31C9EB1;
	Mon, 28 Apr 2025 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQ4AvLXS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6C3C3C;
	Mon, 28 Apr 2025 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823709; cv=fail; b=pBPaq1d+1rKyaXPssZx2vE9QbHU9hFlFFGFtD6wgWIrCX9msrt4MNSUHMhGQ5fcVEp8bOV0/LLQ37Fv6Ys0A3YzckEXl0/LWK91inu6CeQBSCgBiSUYuqEWFiF9W2AB7bIwWJiYIwePLp4zxKUzSkHh1pfd2lu4tCGUAAg0EVC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823709; c=relaxed/simple;
	bh=GjsXaE0TfBoD0iiOCj9duLZpgZlC2KvdcrN5xAOaEAQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWGL1R2kerzx1iiO10un/msW/fvNQF0hQ4cMJgQxbZdK2oqcwR6REnsJIc7yP9hKz00XGj4mWNc5Thh62v4W+iDVPwTPwlzK34lUUeaC6F3OE69Cgx/yUxxARyPX/ahu0F0m453urnmz5VdB2WH4KC9/nkVzFdis7xp8AntjfBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQ4AvLXS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745823707; x=1777359707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GjsXaE0TfBoD0iiOCj9duLZpgZlC2KvdcrN5xAOaEAQ=;
  b=OQ4AvLXSuoouH88NODXPnUDnllzKHzvi9seb9q9dm5dha37R15ABUEQC
   nTGL8D2cca+dn42CNQCOLQgxrTtxNx+7DXVbMPluzgZrKk9wBFZdWDqIT
   qTZw/kgFL35VmZHdmPlVaBcF6zGuszUMou/MGtN3wBLVRv0IIJzMsvxl+
   Bpoytzwx83nlSBaZ9qjSmLzX6Ob1UvbPkK1rw+os+dzPNGJI2sWdpIpzU
   BxbvPdWttAQCy/FCTXP6cfXI9txrAFC6AQIh5hv2W7A4IawzqzYnwdswI
   uBDEMyMQ5j/1qVwmEiDaMJ7SXvQ+dOBEEA9DN35+J9GmaKck3KvQzCtu7
   Q==;
X-CSE-ConnectionGUID: Lxb3Ic2eQwG155L34B2LTw==
X-CSE-MsgGUID: fXh0dX57Sqi+rAEwhyaayQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="72774735"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="72774735"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 00:01:46 -0700
X-CSE-ConnectionGUID: n2sFZffVSUuVnBwVIpyF9Q==
X-CSE-MsgGUID: Q2TVBg1IT0Gzoib9I9O9qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133742554"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 00:01:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 00:01:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 00:01:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 00:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaFR86ZiZPT+OhBv1p432qQDFjn3+fpJGPRn9psu0gLj+jkUPOT2El+Lz2lkXk4AHiJuElzG4BcFxJNLkMv3ePwlJNEU0+f64Z/PC22lC5SY1Ye8mK+8cKQmamUEH8aH+D7WgaAlRidlje4XCvCjyrJruSgkfF/OmeQ6f1HitIFLzF/lZAAYxRt4Z//Qzk2FWaBTbo9kWYx/Uo7kTKvfndXrWkSKXI32l2yKYEeBtuJ+/NoxRK0X5nTaa8eSRPdnsQDZC/i4pEEggIGH/4tYjlIpVzVouyysxWngmiffhnPNqf6OdxVfzhVA1t3CEHXODadtsOpSzxKSdGvygUfo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOQ6DNMXNhs5bBeQSxLuuoiiNhdTyR35Guhv57vAOFE=;
 b=SWwofgaieh8OlpFyvpqjpVjvK2+i3TKSOrks4nmwoFQqj0bm/G4ZbP7xCrRbXw3H2CZsSd3xECeQnuA7glu/D8CBPtAck57WqfDQPu+QaIQJ8HmgK5pTE9wVM5e4Fn//37k15cll3TpCT3OmP+8hoAheWo9sTnGLxkbwS0Dsrf3SkMqUoGZicWijTzzwWY6kXWmcHwdr42C4kjOQ8xFbdrOnR90VAw4wPCN0LGT6x9uJg3HUUrUzmWuLtPe0ZSaO/HLQ8hngRN3ZXczu2ny5pJScPpXPdYh1c9ftiUGjCOomDWQw6zayC8CyVgiTIx7mL3DCQhQSM6trIuUM4HPI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 07:01:15 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::3f63:c727:6606:c089]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::3f63:c727:6606:c089%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:01:15 +0000
Message-ID: <cabea2f2-49f7-40f8-a305-2c102ceb4012@intel.com>
Date: Mon, 28 Apr 2025 10:01:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/8] igc: move
 IGC_TXDCTL_QUEUE_ENABLE and IGC_TXDCTL_SWFLUSH
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chwee-Lin Choong <chwee.lin.choong@intel.com>
References: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
 <20250428060225.1306986-2-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20250428060225.1306986-2-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To MN0PR11MB6280.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6280:EE_|SJ2PR11MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e3de8e-4c9c-4071-5b93-08dd8622777d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEhLV09lZTJTSnBlZEFDRW5CUUV3OFUrUzNrOFp6cVJCMENidk9zdmxDa0M2?=
 =?utf-8?B?bjFjK1B5RUFSa1hXdFlBOTVDM1ZMbkVpblo1cFhpOUFmNjBMbThMTHprUFky?=
 =?utf-8?B?K0ZaYUJ5OTFUT3hLUkRMMlhXMnI0KzNha3ZtK1pLd3EyVjVpUlpRaC9xeXU2?=
 =?utf-8?B?b0cwdnZWKy9GY1orbXdPSDFnY3R0S2JnMTlRUnRlVXU0bW1NdWNjN3B5VVVa?=
 =?utf-8?B?blRScGtuN2lGTW4xTC9Odm5LdlcwMXROWTZ0ZWI0WEhaM3hqaUx0Z2Q3eDJI?=
 =?utf-8?B?MjhGejRmcW9weWh4UEFldDM4My9FVnBxZEpxYk96Ykt5aU9rSHNKSWxvSGpi?=
 =?utf-8?B?UEdhSnZvU1Jlc2xoZ1Z4NFRqd2pZUHFHbW9MTEhIajNiOXlQaXRzVVZuNFI0?=
 =?utf-8?B?dGhUQ093QzQxOW1WUkU4TmRoMGp0SzMxRlpjNU5KTmdzcTZXTHJFQjZ0elAy?=
 =?utf-8?B?Slo4TkVaaVVzKzB4U0JlQ2YwRi91ekozaVE0TnBISjYxbUc0YVgvaXI0SlVS?=
 =?utf-8?B?STM2Y1FtQkhMRWNwN3pIOW9rZC9wYVFTRVhWZFNheE1LR0s5Y2t6Mkl0cEx1?=
 =?utf-8?B?SHZESTk5WldLWHduREtOZkVXdWYzVysvaUgzZ0xnN3lBQzliOXlKeExhY2ds?=
 =?utf-8?B?aWF2R1IvdnFqMVAzR1JvaE4zOTZITk5uajRHNCt2aFVYeEtaQWJ3bDBGZ2R3?=
 =?utf-8?B?MjJ2SXk2S2dRaDBPNVZPaWhrcm9UeVdVa3A0V2Q2ZFRFSXhRREdhdzFtWUdj?=
 =?utf-8?B?ZUJJbzF1cFJTK2EwOFBoVE56cVQxTHdBUm0xVGlXV0pwdHdEOTJUZUY1S0dh?=
 =?utf-8?B?YlpOM1BvaVhVOXNjZy8wUkdXSWVoVW5mdHZzczZyWlNOMTFZTk9yeGxvczhh?=
 =?utf-8?B?SmgwbzdSSENTUzNhV2NOQXo1UVE1Ymc4MjJZYmZ1SnFKTFlET3VnTHBuOEJE?=
 =?utf-8?B?Z0kySHVtaDJHUW03SUZiMVFoYlJCbGthcVlhZmgxSTRPUDFleE8ydUtIL0l3?=
 =?utf-8?B?RGoxYkxUaWNiUGVHc0tlaWFqWWVZSXd5QjRmek1OQmZLUGJ1MkoyMUwxUklG?=
 =?utf-8?B?NDgzdVNhcUFGTFoyRWZQUTVaeXRJVEJjUEhvNXE2UjhXN1lsYUlhUGprTnhr?=
 =?utf-8?B?OUIvenM1cDB6U2wwZ282K3k0dXpZODJ1U2pxWlNnVk5LZ2tOSXZLOWp3R1dq?=
 =?utf-8?B?ejNVUzlZSmk3S0JiZHN1S1JUSytwczZDSWZUNkQySitQMFRKVXAxT1hkVDdV?=
 =?utf-8?B?OFVsVEYvcGJBeTkrVGgwUGpHcFpPc1lyM293M292K0VydnkwRDBKUkVSMFlH?=
 =?utf-8?B?RmdyZWhyS1pVT1NocnZHNVFlYUJOZW5ZWE5DVDR0R1dRSzJSMnZtRnc5Mjlw?=
 =?utf-8?B?d3ZRQ21PN3pDOXNXVHhxeDdsK0VTV09VWGVZY3JMaHBWQUhzKzZwL3dMUi9l?=
 =?utf-8?B?WHRDUVppa2czdTVTNDhMNDJaYmpXd3R4Z0ptS3hBYno0UVk3RElaSGtKdVNV?=
 =?utf-8?B?TlFPRm1PM1FrUURieDNzS2psSkRSeTZ0TlVUS2FzU29JS0Z0aHJNRzZ6ZW1i?=
 =?utf-8?B?cDhLT2xtNUptUFBEcldrbUphOFJxVUhrM2tRV2dXcXNUbG8vd2tWb0FGNlJp?=
 =?utf-8?B?S0c2TFNxZXJFUEpxRkFsYndaL29qaGlyY0ZFa09WNzBQd3IwZ3BCanNPaVU1?=
 =?utf-8?B?N1FpR3pabzdZODc1MmtERTB2WDBoTkp4MHRmbmZTS3Y0UnF0RDk3K0JnOS9W?=
 =?utf-8?B?UmFINDd1RkxhWG9XcmFuUzdNSDlsN0xBNDlyL0kyZkFIemZDdjRIeHRKZ1lX?=
 =?utf-8?B?dW9HVFhVRzhSSllrUTU0ZWE5Rk1sQzQ5ci9iMEZlYXVnUi9DamlZL0t2bUVK?=
 =?utf-8?B?RUx6bWVnMGZSNUJoTlhjOEdWVDNJNUdaMGgydGptUW8rVjhQWFZCdlBlb0Ru?=
 =?utf-8?Q?eC2CZEVs4Wc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6280.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU9PNzFEWXcya0Z0NVUrcFRWWVFzYWFKZXlMU2lRVUkwK0xQRktWR1lNRHdY?=
 =?utf-8?B?NENUSGhuZjNVdmNpNllRMzlFMkZVV2dpL2pUNUN3MDdzU3ZzR3pqdy9iWXQy?=
 =?utf-8?B?VUFMdEcyZXpFVm1HZGk5V1FQd2dzbWtiNTRHdU0wNlJnR210MEYwaDBsT0xi?=
 =?utf-8?B?b2hBTkU1L1pJOTd5SDRaZlNpTkw5d1RxM0VrUjljMjNhNE1QdGI0NHl6ZWR4?=
 =?utf-8?B?VjAvbVJiRkJnQVR3aUloaVBxMjczRmwzSkNNVno5Unl2TDYvUE81d1p6NEpH?=
 =?utf-8?B?MElndUpEMXdKT2pkU2d2dmErYS9SRENtNDdFQUR5cUxYL0NpamZHL1dvb2V0?=
 =?utf-8?B?cHdnNkhHbld4R09vSVVvTHZhRERXWWMxL0ZhZFlNNXlRS25YMDQ3c1c5SXhG?=
 =?utf-8?B?enptSGw5eWNPWUFGQk5QRE55MkJsRTl1OXhmZE9hcXZSSE9aQ0pRcXZxVjRW?=
 =?utf-8?B?T3N0Y3YwNzk0bTlvcVY1dytoUG5BK3BwRktoN3paNnZVN0J0aUNqa2dibHdE?=
 =?utf-8?B?R2Y0YlV1cEsrSnpvWkxrb1J3N3pYVzc4QjVlcG1DRXkzQVZQZzdKam5wSGJF?=
 =?utf-8?B?dGRWdVZoWDk0cWY5SFU2QjZuMXM3azBRRFkwSmZtekoza1hMazdib0hLTENm?=
 =?utf-8?B?eXZrY2ZQUzZZYkJyNjFiaXBhbEhFS0s0eVhXNjl2NFJlcmlicmtwMWxJWVRL?=
 =?utf-8?B?WStndXpneTZOSUM3QS9zMW0vWmNGOFplVlg1NEhsZ21VVkt0dUVnK3hab2Va?=
 =?utf-8?B?NUlEV3J0MlNQUHFXM25OVTE1WG5NdStTYVFZa01wdlBsbEVucXNZMWJ2bDli?=
 =?utf-8?B?cXNPVk5xS0swaTI1Q2RRM3RZVmZWSkIvVlV0NnZNcy82N2k0RVNNS0NueTIw?=
 =?utf-8?B?ZnBnZG4xUzVjNTNBK25JU3lOdDVUVFhRY2t4UmJyMFk5b0NIQ0h6Ny9PNHJJ?=
 =?utf-8?B?ZHN1SFVNWTJ1QlBwNzVTMWwveEtXR3hVQXY4UElNanJteVpxQWV6TWU3MnY5?=
 =?utf-8?B?Q0xVdWVSL0JFZEt0YkkvTkp3VWhqenJSUTFRMXVzTy9SemZzWWRST3V3Q2Vp?=
 =?utf-8?B?MmtlUnpTU3ZkcWhXSHlGb1RVc3k5RTcrdUVkQ25TcFE5OWQzTzlrOW0xdzc3?=
 =?utf-8?B?QzFPNUhBZ21hMHpocDJSZTJPS3psVDg2TlV2R0dXY0dEc2dlcUVKQmNTMERL?=
 =?utf-8?B?RFcwWGFBREZoc29zaTk0ejlZZkFmZUVTbFR2NURrYVA4UmViN0w0UFl3cUp4?=
 =?utf-8?B?aGUwZ3R2Z09vV2JDbjR5MjlldEdJeWpRSXVHZXlwK2NQSC90NXZKL2txR2hi?=
 =?utf-8?B?VUwwTnBockVCSHpyOWRyZHNqZVo4SlByRWlJRUEyZEcvdGF6ZTZLWWs0SGVZ?=
 =?utf-8?B?RG1MM3F2U3lZMnlINVdEaWIvVnVoRmJsRlE5OStER3p0SjE5d1RITFdHNlZK?=
 =?utf-8?B?bk5YeUFnK0kreVdqN1AvdDRSdmdtZm9kZ1ZveWNPNkg3cEJtTHA4TGlENHlz?=
 =?utf-8?B?NU96R3Q2bWF3WjUzMkxJa2dvRGJpVXJ6Ti9DUW1VTVY0UCtRdDRoOVl4WnJs?=
 =?utf-8?B?QUNsZFBvRzZRZ1RPOEZkRkJhdnIwME0rczJBZzUwazgyaDlaN3NQa3V6dnAw?=
 =?utf-8?B?TGpVTjJJL3F3NU45bmRaWndraGN5VkgySlBqMzZ4Nkk5NFlnMU5yRzRSbVkw?=
 =?utf-8?B?ckJOakVPWEcxS3RJZVpxWkN1MGpIYkRWSUxYaEZDcUJjWTVISXUySkVOT3Jk?=
 =?utf-8?B?VWFEQXJIdzcwRlBrcFhrTDJGTkdia1hCN2VxUHV3SHJRSGRrVFdZaTJzdmhL?=
 =?utf-8?B?MG5DQWV5Z0pKaXRmSkpyRHk5WUFTZUl2Mlp1cXRsVVlFcDUzMDNaQXRabTRE?=
 =?utf-8?B?T1V3TnlBR2R1QzBSeGVFN1NvRHgyZEhLUVVXbk8yVzdBVnpBTHZZNm9mOTlX?=
 =?utf-8?B?R3BlY0R1V2FRcWZ5eDhtcUxyajRVNnNRRzRoMmxGcGtKQmZ5N2pzWDJHNFJs?=
 =?utf-8?B?MFlMTHBVMjBoZE90cWRmN0syS0Uzdi96KzZiczMweVdMa2Z2M3laN04vY3Q0?=
 =?utf-8?B?UGdjZThpK2VuZThVS0FoZUd0akh4R3duNHpCMVBXdDR0dTBlUTc4Y0o2Nis2?=
 =?utf-8?B?UkRBZDFvRU11dVhSRGxTSU5wN01LTmY2ZVpjTUlKN09GTHFkTUo4eEhGZkNx?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e3de8e-4c9c-4071-5b93-08dd8622777d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 07:01:15.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNY99ZCP+58iX5TPlxKfdYwjvjHDg6xxvavsIz8nRT9bzUWw+0BDdyMZxTNnAhW+lvV628NvUGnlMhqWVW7omw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com

On 28/04/2025 9:02, Faizal Rahim wrote:
> Consolidate TXDCTL-related macros for better organization and readability.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      | 6 ++++++
>   drivers/net/ethernet/intel/igc/igc_base.h | 4 ----
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 859a15e4ccba..e9d180eac015 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -492,6 +492,12 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
>   #define IGC_RX_WTHRESH			4
>   #define IGC_TX_WTHRESH			16
>   
> +/* Additional Transmit Descriptor Control definitions */
> +/* Ena specific Tx Queue */
> +#define IGC_TXDCTL_QUEUE_ENABLE	0x02000000
> +/* Transmit Software Flush */
> +#define IGC_TXDCTL_SWFLUSH	0x04000000
> +
>   #define IGC_RX_DMA_ATTR \
>   	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
>   
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
> index 6320eabb72fe..4a56c634977b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.h
> +++ b/drivers/net/ethernet/intel/igc/igc_base.h
> @@ -86,10 +86,6 @@ union igc_adv_rx_desc {
>   	} wb;  /* writeback */
>   };
>   
> -/* Additional Transmit Descriptor Control definitions */
> -#define IGC_TXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Tx Queue */
> -#define IGC_TXDCTL_SWFLUSH	0x04000000 /* Transmit Software Flush */
> -
>   /* Additional Receive Descriptor Control definitions */
>   #define IGC_RXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Rx Queue */
>   #define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */

Is there an intrinsic value for moving these definitions from one H file 
to another? And if so, why move the Tx defs and leave the Rx defs where 
they are?

