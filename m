Return-Path: <netdev+bounces-243484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D5CA20C6
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 01:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD48630090B6
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 00:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5765F16DC28;
	Thu,  4 Dec 2025 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUAy9F9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1DF824BD;
	Thu,  4 Dec 2025 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764808660; cv=fail; b=uX2IGaZ6ctXGOVRa6nIN72OssCV7Bd0ZYsqfS2LvorOgvyzUWlzkmADjfXdD68vs+uIh1i15Ux456gvxOwGhzR7goT0ybiNkUotVhQiFaFs1kK/zBWgWBICx4mJf0b5VHYyQ+WGpx3fGfAXxyfrmFGfP6Vq5fPNNIa0t9ow7GJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764808660; c=relaxed/simple;
	bh=0oZ91Rz5d1KzMhaum/d2hn8QptlqGbc0Q+4HBCrzFYk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lGkIlu+Hs3GMXTaTMXgxq32ItIPHBk0pBmSAIRg2d9xwO8lX8q7jRIwnbmipoQ9uINlX4R1SRWZraD4tKcpW6YY4zwe46iLCCdzQzwK3r8ctvGUhj8jEMHjxsZsdm/t/Z1qm2TY5gKylugWTxfJAi2rToGky+vDyNjhJg9NGOIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUAy9F9Q; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764808658; x=1796344658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=0oZ91Rz5d1KzMhaum/d2hn8QptlqGbc0Q+4HBCrzFYk=;
  b=NUAy9F9QmTbjncxBNIpNGNJFzTwrbI6XuAVlq1nXgqESuxrdt7jyVprs
   hIPFmxxitlJYYvGDXOnC+SSpbMw4+V2ECwWMW98ZXiUDCT7wgpQS6mtSz
   SjzaCpvFGGAKMKXV9pp+8i43vaM4NtlasQYS2podYhkbqvmeimjqorJhW
   QgN7ltRCY5VSBNBRdevEVKYhNXKWJhshIJN6k0yX1RHrLnsjSKtZYIq1A
   HThIKPnhBFj+mxKmb7xDeMDi82Xoy5BLf28mEZGW9YopQwdIJYRRTQjFk
   Kz1Bmd6vTTvgkLqr0M6PG810MGu31VG6PGxpt20Ftwfxh1LfRQfBHdtyG
   A==;
X-CSE-ConnectionGUID: SyY+AtGPQWmPRiA0AaTJLg==
X-CSE-MsgGUID: wtcZWVj7QVK6+fJA98ZDNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77926526"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="77926526"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:37:37 -0800
X-CSE-ConnectionGUID: ZnWDrtHNSxycdig5QAFT0Q==
X-CSE-MsgGUID: rUGTN7u1RYeeVRz8wMTNSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="195633004"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 16:37:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:37:35 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 16:37:35 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 16:37:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uzb8rVgxaNMDqGEmuW3faFmBj6tNkG6s62oTp9p92g1iMJM2FG7kk7+NjQxgSh8lC8SHFDS1f7xnq1M+CeN6Rq2/7lKu1nAMmeVoYBRzrUx66g2tVQBcmvlLK6G3z7dU5ECBcSr1R/Y/sff1yLAXaQBSjo+Lzdi+yeszmctBd4PKnzh0TOe0QtgqvsfbzVc+KiPIRG9UxlTWVC+oFXqCdN7fT/iwnZDReAi2kDSX2d0GMAUoTz7VOYc25LUEfoMVuGfGuBb7aZ4ACGFtVDNj3lA9d40i35RbkiQ/gt4uSKBuShTHTrkdCS3lmJhXVfVdRhC26bLa/4fepZ7yaM5nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkDTpcGRlXRKUxbaMIBdq4PYUyweS694voybiBbA7gs=;
 b=PH13uSAYYMIoXAHoy2PEDcsiiSr9UQRGQvGl/ypF6iLYivn1QsDQezziz0SlthJ4vwOSBD1nGiygaaTPKiFbgKKdWQaiL0OA6dFA206QixOcn6Men+J4MD0T81M5mQziVacfGW53diSuS9c52i5HC+hSwPV4n2QSza8LY0XbzcfaOZLPSQG7dLe2TrRCRKOeb/owyWsH2B1gyieo1VjiYlUKgTBZ6FOdxOz8gPO3j3wIUpnBigeWvTn5sxgTTDGiw4jCJLZcvijcPbw74TEiVl4KF3nR7Z5jv2ngeRgxarlFMCoWyrTtSxzBCuqTX7vKrZ+nLf9NL20JR+Rs1DuajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 00:37:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 00:37:28 +0000
Message-ID: <662d0fc5-7071-4190-903b-cf37f5a91adc@intel.com>
Date: Wed, 3 Dec 2025 16:37:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: fix oops when split header is enabled
To: Jie Zhang <jzhang918@gmail.com>, <netdev@vger.kernel.org>
CC: Jie Zhang <jie.zhang@analog.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251202025421.4560-1-jie.zhang@analog.com>
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
In-Reply-To: <20251202025421.4560-1-jie.zhang@analog.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------LfCqUjqpO4MfghZKfAJsQ5cX"
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbf2280-bd12-4e87-c9e5-08de32cd4cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGJQRExqVGNhczdQU0ZWVHdxSFJaN2JXTjFtYnhzcGtSSjRnRE05T0dGdm45?=
 =?utf-8?B?UnVEZlJ4dm1aNXh4Z0hjSmNBS0ZYVlRrRjZZeERoZlM3UUlEcnluNExEYnFN?=
 =?utf-8?B?RVkzWVkrUUpIUnhVMzNvWmFXc2J0ckxrYTY2Z0F5ck5rVDVHUXNSaXhYRURS?=
 =?utf-8?B?YTM1TUZTU3RTTGJ3cVFDM2FoWnF6ZlZ1UkVnK0U0NFhJbHRndGlyZ2crTmlS?=
 =?utf-8?B?cUx4VmhuVnU4MndaWnE0cGpHaEJkb1IxdWd1aFZKcVJ4NmFqbXk4NnVDRm9L?=
 =?utf-8?B?UXpnU2phOWFYMHFXQzZQZm9yM3JOZnUxY1czNDlBTHphUHB2TVkybEZtTFp4?=
 =?utf-8?B?enFXdnhFNDh5ajBtNDQ5Zm1VemdadWFIb1M2TGc0d0FHRmxNbVd4d25ZU0pE?=
 =?utf-8?B?Z3N3bHRoWVBKTGpVRjRxeXNELzRsa1B4Ylpnc3hFN1J3REplV3NJQjJyNEIv?=
 =?utf-8?B?VWF1S1ZoOVJjek9WTmVkdzl4UW1KSkZWcUNSOWpwZmtFZnZESHo4QUVBOE50?=
 =?utf-8?B?TVhlV1N2aTZVQkxrNzBDb0k2NWVBN3dNbFdaV3NraUtoSHZIc1JWSjlZTGpF?=
 =?utf-8?B?V1VxbUU4dkdCYnpzVVRLWGtlR1NrOGtydXlhUjl6aFBrRjVXcEUxWm5kKzNi?=
 =?utf-8?B?UDEwdzZWdER6ampMeTJmeVljdVZ5SktzcmI3dDZsbXV2MXFLNWdVQTJjbjND?=
 =?utf-8?B?c0lXdWZJRmk3VVpCREhUVWg4aTFIWnd3OUJkYjZmMllWY0RRN3VhWVlFMGZD?=
 =?utf-8?B?TFNsYStaZXNyNitwN1dlbGNHd0R3MnlOTndzMUJtMy9NcitGZ3lyNE5sYU5W?=
 =?utf-8?B?VFI3Ty9ucjV1TDZqYlVtdkhmeko1TGlKeGFtckRJck9CUlkwTm5PWXpNWm9P?=
 =?utf-8?B?c2tISElYWmxYdndQejZzamVUcjRZOWJnWHlGcEdsaHp6UmVQVUFHNDhQWUl4?=
 =?utf-8?B?aHRQNG1hQmlvRWM1bE9UVk12c09DSS8zNi9DUWVQOHl4Q1ErZlVmeTRFUitI?=
 =?utf-8?B?MVJXMVJwZ2s2TmJuKzhsTXF2dklHdmVxRlBhakptalN0SkhjV3BYdENCdG5t?=
 =?utf-8?B?a2pDV1RjbS81bjZMekV1c3AvejYzVGFMazVwSXVrZHVkMGVwRW5RY1Z4Z0Jq?=
 =?utf-8?B?VEc1TWVvWGJFTWw0b2dCL0hRTFlzKzN0aWw5VVJCZSs5aEY2U3pvOHVQMVZL?=
 =?utf-8?B?NzJuSzBMZzd0V2dKRjJkdWRaRDZJODRSb3hxUStLaUE0a3VSamNERUVGcmJW?=
 =?utf-8?B?Y2d5ekFwZUdMMGRESlk4bk1MNkJhR2JwSERmSExGdkthWHJlSFdtQzdGdDhB?=
 =?utf-8?B?aFAzRmJxenRlMWZKRVYrNXNBQmY3aEd3N0NNaEsyeG1KYnVLUGhmeVFRTjIy?=
 =?utf-8?B?YVZTbllSc21nWHp3T054WDl5eUp6bmRPNUhsZE1WS1BPc0cyRmNkbWVIeU04?=
 =?utf-8?B?NWN0ZmMvU3A4bjNvdFZOTzhNS1VlMlB4R3lXSmpOQzJzWmpLcVpjcmE3TlZI?=
 =?utf-8?B?Nkp0Y01EZzkvVll2Qk84Q1ZDeEVuUFZ0cXE0UXNSR0RoYktPQU9LZTdTZS83?=
 =?utf-8?B?YTFJTlRmRXFpOTI2WkZGdzlnVFRleG5tZmZjR1ZuRHBZSFFlSkJ2MDJTbjMz?=
 =?utf-8?B?Ylp5RmkwL3cyRlFvQVFTQmV5WEZEeTV1NnBoTVdxN3ZnNmdvazVCTDRuSENr?=
 =?utf-8?B?bEVLMkoyWXV3YXdpRFJ3eU56dVlQaUpkZHhBRWVBVXhhdnFmYWNyY0R6dExT?=
 =?utf-8?B?cTVlQTVKemx0VFErUDIrOHoramZCL05XREE2azJyajVxZm9Uei9uQ1A2Qi9t?=
 =?utf-8?B?ZnZrbW5Pa2RpYWVvaEhibDczUmhlQTJSaU1vbFk1RTVkMEttT1lFdGFsZHdo?=
 =?utf-8?B?TVg4RWVNWWNOaDVLRWhUUmpONUY3NnN0TmIvRDlFMUx2SnhjekdsRzQzWjlt?=
 =?utf-8?Q?hrV3BRU9gj9AX+gpEr6XrNulesKRXipx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWV5aUhYbXN4TUd1eTBFUm05bXg2SlN2NGgwcWxvQlMxQk40SXN1N1pxR1gy?=
 =?utf-8?B?TTFOdDc0bGZnQUlwN0QwbVcrdU9UWFYwSUxjNHhRWit6dlYwOHRDTGV1bXRk?=
 =?utf-8?B?WEltcFVjb1VWYk5GYXY5eHpiQ002SmQzbFpWTHFlL0prci9XUkUyYi9udmFn?=
 =?utf-8?B?K0R6WnNxSFA4TG9vZTBzZ2tTSFdaSmIzV1NrQW9QV0d5VTE1Mnk5Z2kzdTlC?=
 =?utf-8?B?R2pGRlprbkZqcDlDdWZHK3p2WE41eFUrbGM4V2JEaUhsMVh3L3pHR0F5VVFH?=
 =?utf-8?B?L3Q3RVFSc2ZFZ3BDaStHVnA0ZWl0YXcvT2s0RG9VSVJ2dmh0a3ovMHJONWNM?=
 =?utf-8?B?U2EwT2t4aEpqcVRwY2NSbll4Z1hseU1LM1AxeUl6Tnd2VEZYcnNaMVRwU3A1?=
 =?utf-8?B?d0FEL2F0V2RMeWNkSzRhUXBidjZNTENJNHdCRm9mUnRzR1R3QUE0cXpQZ1RP?=
 =?utf-8?B?T2tQVk44bmdSMlhHSlZLSHhZTU56RkVhTk4wYWc2cDBuZEtJWkJmRXVzWTZ1?=
 =?utf-8?B?cGZQTEp0cmM2aFVMWlUvMXNlOU85bEQzT01PK2dSYUpRQ2dWN2NxVnhXYTc0?=
 =?utf-8?B?MGh4dUhiVkRyYkJwTGtTa0x5OUZ4am5zQXVwTGkyaHpFWHg0Wi9GeS84cUF0?=
 =?utf-8?B?MlZQOUdhL2V2Q3kvcFpTRDlZR1N0di94RVhLZGI3OE0rWEZRMEpKcFpBTnBC?=
 =?utf-8?B?UXJTNVR1ZFFqemZBcTA5UHF2Y0JCclFoVllIYlgzSDNIb3lpY1BxWkhkMXJL?=
 =?utf-8?B?MS9IS0FhQVV6UzVlVGw4MWYvUlNIak55bzBoa285Z0hPaXVjTmhCaHJjWWQz?=
 =?utf-8?B?RDBkRDlPVUZ5LzUwck1lTERNK0dSWGJja2ZQTENUUS9OLy80MXV6ZVZhU0t0?=
 =?utf-8?B?bmhERW9JTzJieE5sYkNUTjhMUVhHSDdiLzJ1eHRFV0hOMi9nV2dUeDhqVmtt?=
 =?utf-8?B?VG1XVFhocGozY2dJYzZzVHhsRmk2MTNNN2UvQzkxNDNnVEdsdngvdnVPaVFH?=
 =?utf-8?B?emlLS3FtMllOZXN2SkFlYTVyUmtCWWlsbEpQVWFDRGxxRkNjSVNveHg2cWJR?=
 =?utf-8?B?cEMvWUlEUkJnL1ZrWFNweUVJZGsvMUhEZzZMMldmSGFVaXIxcWlVVkN2amIy?=
 =?utf-8?B?MGFBWjBkZDBTYytZbXAzclA1ZDNEOVJzV0ZTRm9EdXUvaDI1QkxUY01qVGlQ?=
 =?utf-8?B?THdxS3ZtMnFXdUVsdFpVT1BjbnU1aEMvV0xOT21iZHFvQ2YxR2o0QkFabVF5?=
 =?utf-8?B?cnhwb1l4eFE3NEpCVGd1OUU2SE9vbE5MTUtjT3lBaVFzVTJpNTZUWVk2SDZU?=
 =?utf-8?B?VVI1YkRyemJVNERQelhDQnNVS0JkQnQ5a0ZWRUxTQ2NES3I0UjlieU1qbDZs?=
 =?utf-8?B?Z2hTUlRPYU1nSXZ6ckpUZ0hkOTdteVNsWDFoVXVWUndaWTliajRBZXpOVDFD?=
 =?utf-8?B?RVloY2FJNGhxaGJ6UzZLdTNxTG1MbWVEOU4rRlViMi9iVjRwRjJ2RStxT2pt?=
 =?utf-8?B?ZXRUUlEwcXk2S2cvTWZZdFpkaDRnbC9yMExiQzU2aG9vSkxRdlV2OWZUKyty?=
 =?utf-8?B?Rm5Ndzd2SXExdUJadXU1bVJ0UEdLY2UyN2tIcFdXSXZMUzRjMzl3QmpLYTU1?=
 =?utf-8?B?MXMrTEFQZTlMZlNvenk5SUxWUmNQb0ZYU2J5Q3QzWTRkWmR4VTZhR3lWY1Fp?=
 =?utf-8?B?bVVRcWltWWRtS2NvOXV0Q0dPM3VWK3BpQ1Q0SXFSUmtRRUdIOWlKdExTWklv?=
 =?utf-8?B?bG5JR3k1K0ozekNhNWhnR3huUTY1R1doTEZudDhpYkd6NWpGQ09IZmR6aGhn?=
 =?utf-8?B?TWtIY0R1cUMzMGRqZXVYYWo1cEorK0ZXVndiT1hGOWp3czQ4c1NKLzlsQll3?=
 =?utf-8?B?dUVIN000d2swQU1laGpvUTN6Z1hpNXAxR2hnQXdJd2c0WDB2T0RxNjZQQndD?=
 =?utf-8?B?RkVhWXpkcWdPdGJlcDVLNlVLS0piRHliMXVMZldOVUFqWWpBWWE1L0JhSFJV?=
 =?utf-8?B?eXJ2V1lLY1VKaXlOTVpyL1hqUWJrQ3BmUnB1L2NZMlY5NEhXcHhBMzdSUi9l?=
 =?utf-8?B?K2Rwb09TSFlrUnNFSjlHZHY3OEhhOWYrUW84M0dsZGIyUXk3VmxaSCtmSTBQ?=
 =?utf-8?B?dzVyd01uTk9wY0pXMTg4WTNXMTc2MTY3MkNtYTRBU0doU2NTVjZFY2poNGNr?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbf2280-bd12-4e87-c9e5-08de32cd4cb7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 00:37:28.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yy9gGzjh30uCdcfUqKwObx0F3lqxZ8FomM7q9Djen3y39vlQWCpKZi7tM9lv4VVBPPbz/7CvK56o0umc6x33UfXBkQp+bvQ9dFz5QdzP4Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
X-OriginatorOrg: intel.com

--------------LfCqUjqpO4MfghZKfAJsQ5cX
Content-Type: multipart/mixed; boundary="------------0osqPRcTEgWJKAvKf204m4Wh";
 protected-headers="v1"
Message-ID: <662d0fc5-7071-4190-903b-cf37f5a91adc@intel.com>
Date: Wed, 3 Dec 2025 16:37:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: fix oops when split header is enabled
To: Jie Zhang <jzhang918@gmail.com>, netdev@vger.kernel.org
Cc: Jie Zhang <jie.zhang@analog.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Furong Xu <0x1207@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251202025421.4560-1-jie.zhang@analog.com>
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
In-Reply-To: <20251202025421.4560-1-jie.zhang@analog.com>

--------------0osqPRcTEgWJKAvKf204m4Wh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 12/1/2025 6:54 PM, Jie Zhang wrote:
> For GMAC4, when split header is enabled, in some rare cases, the
> hardware does not fill buf2 of the first descriptor with payload.
> Thus we cannot assume buf2 is always fully filled if it is not
> the last descriptor. Otherwise, the length of buf2 of the second
> descriptor will be calculated wrong and cause an oops:
>=20
> Unable to handle kernel paging request at virtual address ffff00019246b=
fc0
> Mem abort info:
>   ESR =3D 0x0000000096000145
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x05: level 1 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000145, ISS2 =3D 0x00000000
>   CM =3D 1, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000090d8b000
> [ffff00019246bfc0] pgd=3D180000009dfff403, p4d=3D180000009dfff403, pud=3D=
0000000000000000
> Internal error: Oops: 0000000096000145 [#1]  SMP
> Modules linked in:
> CPU: 0 UID: 0 PID: 157 Comm: iperf3 Not tainted 6.18.0-rc6 #1 PREEMPT
> Hardware name: ADI 64-bit SC598 SOM EZ Kit (DT)
> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : dcache_inval_poc+0x28/0x58
> lr : arch_sync_dma_for_cpu+0x28/0x34
> sp : ffff800080dcbc40
> x29: ffff800080dcbc40 x28: 0000000000000008 x27: ffff000091c50980
> x26: ffff000091c50980 x25: 0000000000000000 x24: ffff000092a5fb00
> x23: ffff000092768f28 x22: 000000009246c000 x21: 0000000000000002
> x20: 00000000ffffffdc x19: ffff000091844c10 x18: 0000000000000000
> x17: ffff80001d308000 x16: ffff800080dc8000 x15: ffff0000929fb034
> x14: 70f709157374dd21 x13: ffff000092812ec0 x12: 0000000000000000
> x11: 000000000000dd86 x10: 0000000000000040 x9 : 0000000000000600
> x8 : ffff000092a5fbac x7 : 0000000000000001 x6 : 0000000000004240
> x5 : 000000009246c000 x4 : ffff000091844c10 x3 : 000000000000003f
> x2 : 0000000000000040 x1 : ffff00019246bfc0 x0 : ffff00009246c000
> Call trace:
>  dcache_inval_poc+0x28/0x58 (P)
>  dma_direct_sync_single_for_cpu+0x38/0x6c
>  __dma_sync_single_for_cpu+0x34/0x6c
>  stmmac_napi_poll_rx+0x8f0/0xb60
>  __napi_poll.constprop.0+0x30/0x144
>  net_rx_action+0x160/0x274
>  handle_softirqs+0x1b8/0x1fc
>  __do_softirq+0x10/0x18
>  ____do_softirq+0xc/0x14
>  call_on_irq_stack+0x30/0x48
>  do_softirq_own_stack+0x18/0x20
>  __irq_exit_rcu+0x64/0xe8
>  irq_exit_rcu+0xc/0x14
>  el1_interrupt+0x3c/0x58
>  el1h_64_irq_handler+0x14/0x1c
>  el1h_64_irq+0x6c/0x70
>  __arch_copy_to_user+0xbc/0x240 (P)
>  simple_copy_to_iter+0x28/0x30
>  __skb_datagram_iter+0x1bc/0x268
>  skb_copy_datagram_iter+0x1c/0x24
>  tcp_recvmsg_locked+0x3ec/0x778
>  tcp_recvmsg+0x10c/0x194
>  inet_recvmsg+0x64/0xa0
>  sock_recvmsg_nosec+0x1c/0x24
>  sock_read_iter+0x8c/0xdc
>  vfs_read+0x144/0x1a0
>  ksys_read+0x74/0xdc
>  __arm64_sys_read+0x14/0x1c
>  invoke_syscall+0x60/0xe4
>  el0_svc_common.constprop.0+0xb0/0xcc
>  do_el0_svc+0x18/0x20
>  el0_svc+0x80/0xc8
>  el0t_64_sync_handler+0x58/0x134
>  el0t_64_sync+0x170/0x174
> Code: d1000443 ea03003f 8a230021 54000040 (d50b7e21)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception in interrupt
> Kernel Offset: disabled
> CPU features: 0x080000,00008000,08006281,0400520b
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt=
 ]---
>=20

You could probably minify the crash here a bit since much of this
information isn't that helpful in showing the crash. Not too big a deal
overall.

> To fix this, the PL bit-field in RDES3 register is used for all
> descriptors, whether it is the last descriptor or not.
>=20
> Signed-off-by: Jie Zhang <jie.zhang@analog.com>


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------0osqPRcTEgWJKAvKf204m4Wh--

--------------LfCqUjqpO4MfghZKfAJsQ5cX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTDXtwUDAAAAAAAKCRBqll0+bw8o6OjA
AP91xBjSKddftWHvRiOgNtwI/jo6/5sPs/jIqPi4VJBBRAD/d4QR0CSF53EZIvPRSf1Q0j4fEeSb
TR0mmkM0o0R1SQ4=
=KyAU
-----END PGP SIGNATURE-----

--------------LfCqUjqpO4MfghZKfAJsQ5cX--

