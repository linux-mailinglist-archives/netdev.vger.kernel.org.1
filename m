Return-Path: <netdev+bounces-188447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26038AACD8F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838C59831EA
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358C26FA5F;
	Tue,  6 May 2025 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FI6+xkf5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AC2868BA
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557723; cv=fail; b=AIqrdIOKNO4ral7Sc2kX3oDREXauFACmdeJgZHqPp6W4oFipOOGQpi0HIQd6RftMzB3G52x+gEgvUns5DocHJqH7L646/J0WVm6SBmhdGJu5VRk+zawskuzw1PI21Bu3EJo0kss0ecD3BTezmb20fJBtONuUYF2kWRUw+xApqZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557723; c=relaxed/simple;
	bh=wtAA3V7rhjHKGzDHLDgTd6mB1CS0XLEOzKCBU8+hgsM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0M2XVEpwT+yfOypJOykCBKrjounX034FkB3hJaqyuwQU9T+kbC84rQa/tIAExKRjKd6/1BqMJ7hUfiYcsvkUfiGOBuvlVc1RJlQVK71YSgV4i8xwPjeW2iUvKhEHgMP7paCg3B5zESBCcoajcvtTy5UWexIdinNRTaFknQuaQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FI6+xkf5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557722; x=1778093722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wtAA3V7rhjHKGzDHLDgTd6mB1CS0XLEOzKCBU8+hgsM=;
  b=FI6+xkf5zWO4vQ8f+1Ip5jRT7JcAKcvzCkQEs7ZDXJUxWqAPCrXWNX9g
   jzMyVTS1LDeCkzrX8gRkhFvVIDhs5P67LgYTjcKhcye6gGdyi5F3PISsf
   UoKv9L12mb0dsokPYY7jWpuc5zQ9+DMjP4Thbbxyrx9vkNyOd4Z6wcQIi
   2hEEa1xAtjHqvrVjTyRA4xTpJ+NY9ELPMCL1CTqvNNHIM14qFSCXDIroV
   5W6Xy5rQIknnNc7ip4Hkg+feTPz2vPdjIA24qh0sxRY/ltt5clA8F7yRi
   iTh9QYyajjXtQM78xra4juJds8h9mKyD2WDHEqSuykyhNXpF7RiTKaPFo
   w==;
X-CSE-ConnectionGUID: pnFXBXMRSM2yb84ZZi2zpA==
X-CSE-MsgGUID: i/Znvl/fT/GI3IKDlDYJsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52068208"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="52068208"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:55:21 -0700
X-CSE-ConnectionGUID: Y2EbUwzxRn2ntP75PwRPyQ==
X-CSE-MsgGUID: dj5r1vV7Rl+W4uZ3nrr+rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="159005697"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:55:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:55:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:55:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:55:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw9NKRD/HeXkV/xcz+mZgt/RTbO/yBwnSrXonupETZGBLdPoS90+P0HRfS5bH8KBVUDDwyEchg/ftNnAYIVUdxl4rTUkLTXq6UTbawF0Q+A4ueE05kEMKxBPEUoeTLCXR5wqpnkQcd3Ed6FPzkEVW7/hQEosqHsh+otViLMfCInMZ01T8UA8rLjU622AHM9yWQFYImf1GalKYkrxosfB5KuYukmYX/XK8AOTxePSZK9jMbS3QHn4aA/Gll4xC7lxfCek15j454BLdkgZA96hNYzR6zUqk3ahEpPm7CW4c7BcZWozYfwEblIpg2/X1CHB2VDX/U1YJD73dKXMREDlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ8pI0OsB5NwryOfBAb5Z+e97pGHlqumXJNkEfhdZYA=;
 b=kEWlZ/W7SX2Vk5AFTsms2unLuXfK1XgUmyadmaCY6A/3H6T6uLvOekp4X/biba9/q2Cpzm+GV7MB0gZUOKxOE4YRxAR5LTinx0bG1dX36vhE62FPHu4XDAbanhDqUHBaU0fMQxdRRpBWQt2uLgMYf+8dy1r079OhZ/gkk42ob88zeuDsG6BFvGiYG/2uKIq+/qgD0fjDHVhIdGlDUP+rJ9E6QksuYyqp1sqYhYPREM+h130XBlEzGW9C7mioJ+S+5cSmYrTFFSQDuOgPw+DspOMIhZF/zoFcj2HLscXPRsYdrg+qvMh1skmhyAP+JvWCjkmiMjkB0qWpYQG8GREYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 6 May
 2025 18:54:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:54:31 +0000
Message-ID: <26002a53-0ae1-4c8f-830f-77ad018390c1@intel.com>
Date: Tue, 6 May 2025 11:54:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 6/8] fbnic: Improve responsiveness of
 fbnic_mbx_poll_tx_ready
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654721224.499179.2698616208976624755.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <174654721224.499179.2698616208976624755.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: c64664b3-e7a0-4a44-6d3a-08dd8ccf6f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1M5TUJKRVAyaTBIalEwZTMrUVF5ZkpyZlZsUVlPWkFsUU5SKzAybTFoRWMy?=
 =?utf-8?B?N3BscmlVTE5NWXZMOEpvVE1MQTdDYVNERWM1OHd4aEovb2FSOWtLT0JJYS8x?=
 =?utf-8?B?b2R3TkhIZlgwOTFLNGJ3bTFCQWxaeEU0bElTejNnTkVzOGg1cGFQZnBEMTc2?=
 =?utf-8?B?RS9zZlNOaE9JYjA3V25XNlVyQW45N2dpc3h3TzMvSmFBWm5FVklrekt5aHR5?=
 =?utf-8?B?Qzk4VTYzWmdIbWQ4QW1wdldWdVZjaHR4LzhlSjdCZ0NjNkZ0V1JkR2pEMzIx?=
 =?utf-8?B?bzBDQVZ3VVhwNlA1blNPRGNDY2dpYnJYcm5BZ3d3Z3dyY2FlNm9WaWFTR1c2?=
 =?utf-8?B?M25LeWE5OUtEOUVJcFlUeFdVZmNtaWZIT240QjNKMFUvNTBTWjZVSzRTa0o2?=
 =?utf-8?B?czlDS0owbnovYUdPRkd1L2xkT05RS1JkQlk0Q3FSbkVjcXFiaG5MbmxKVEdn?=
 =?utf-8?B?RmFENDgzMTB6aTJxSm1FT0s2R0tZejN6ZjI0RCtYM3ZKYUwxbTYyb2U0RXc1?=
 =?utf-8?B?Nnl3R2x5UFFkUDc2MncxR3NQcUhjaUpxUExSRVBJaEl3VkN6dUdLd2d1ME12?=
 =?utf-8?B?REJHVWVIdzRQTzhXU0J4ak9mTW5lcS8vYTdqR0Z1MnRGRm9FMUQxRTE4eHRF?=
 =?utf-8?B?WU1FbXpHSHlEUnRod0Rjb21yOTlKcTFXWVZSVDF4dHAzTEZHU2ZrVzJ1eWZO?=
 =?utf-8?B?elFmOUVTbmtVZVMxZkdjLzhRb1pNSm4wVmw4d0RxRUMyR24zOG5EZHc3Y3NF?=
 =?utf-8?B?NnVQNlVHbFBVNVhYK0c4NVNTbnU4YXVKdkFvcmc0R05UcnR0aGlQdU5heDFJ?=
 =?utf-8?B?MXNWdmM2dHZ5c016SzB0ZHU5R0FrdHhNdmdtenJzZW9QYTZWRE1oZ2k3c1d6?=
 =?utf-8?B?QzdMdWpWY0UwdWlMMmJJN3lWZ1JjS2s4emViQmZ6WmJoZkZmR0RjQURtSkxp?=
 =?utf-8?B?L3pEZVV1VHZ0VExqTWpQRlVNRGVFSjMwRDArVDgwSFZGMDlyaEs0SEJvcEo3?=
 =?utf-8?B?Ky82aGYvWVVBNGFxWG1ZMlRwT3pXRDkzbkVYTE50VWpmTFFPUnlLN0pHSUFs?=
 =?utf-8?B?blZ6NTR4d0tFYTFTeHpDUVIwZWZSbkFqVnFZRXlqc1JZQWU5b2hpWFNQUnc4?=
 =?utf-8?B?VVpSQnlOSTJMQW1YdWJFb3B1cGZDMTVWN1VTQWg0dmZCcC83MGwzbnpzU0Yz?=
 =?utf-8?B?Nmh3cmRQYjVxVDlZWEFCOVM4eHJ4V3V1U1MxejZpdnlaRVk3L2pkK2x2b2JL?=
 =?utf-8?B?Nk5hZ1FDTXEvMEI0WjdwaXhlY2VJVGV0T2cxY3lRSUdPSUlOejUxejc4amps?=
 =?utf-8?B?VzZjamlNeUxaVEM3N0VkUnBvZHdpWnRzd1hZRXZVaUN0UlFxdm1RQ0pELzRj?=
 =?utf-8?B?UFF2bUV6TmVBVlJ3TGxCMzVYY2tjekR6ayt3QWZ4WVM1ZjZRSm5NYkREdk5t?=
 =?utf-8?B?NjRlcnVJVEwvWFlMVGxZcXFvTDk0R0I4aGtkY2gvM2twY1lvSlhEZnF0Z0ll?=
 =?utf-8?B?TWVncE0xMHZHcE9YY0VSdjR3U3ZVVTZjUHlMdDRBZEsvaVMzdjNaUEcvSHRG?=
 =?utf-8?B?RkpGN01jOThtSERiYk9lclY3bmVDVG1zS0VDY0dZUHdTMTZ3RGlpK0cyc0dZ?=
 =?utf-8?B?eWx3Q1h3NnprWUN1TlI4UFVuemRjVENzcUpaQjNDR21jUTZ5ZGYza1dYZTFu?=
 =?utf-8?B?NktST1JyVUQwYVhPeHhIamFjUHRDRXhWcFZhTTg1TVROamlVNXdncmdwaitL?=
 =?utf-8?B?MGhHMUowWHNmK3ZMc3N1Y1pzUW02Zm91NzcvdU5TbUZraGNUS0pDdXpva0Fy?=
 =?utf-8?B?L3FkZk5Qem1VRlp5M1BNWEYxdVdNV3NOSHhvc2NJVDNTcHZCbUZIMFVudVMr?=
 =?utf-8?B?M3BBeFhIdkhLYWpwdzhZUVpPNFVPMzdMZmcrWU40M1VsNlJVNUxXV2hIVU41?=
 =?utf-8?Q?x114HcUsLwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVkRXFqcDFkckFadHR2SEdBSktCNDNXaWM4ek9EbUM5VTdNajFDNzZxTmhK?=
 =?utf-8?B?WmRybUtYTU5hN1loVTRVQXU4TXYvRkYzWG90Q1NqcTluQWRPd0ZYditPR0U5?=
 =?utf-8?B?SzdaM3QvTHJRaHY5Y25aRERtTDZQVnNTRjFaZXBCRkJleHdTT1FuU3BITkRv?=
 =?utf-8?B?SlFkT3k0YXE4MWZQU1hhdlBHVFZybHFuenhVOU5qTGVxNVZCQUVuanp3ejFI?=
 =?utf-8?B?NkFjbVNlWDhOVzZsbmtDVmdjUHBYVWpOaW4zWmxVS2NUVWdDWVJXd2ZySVV1?=
 =?utf-8?B?TU5QMDc1b09nZWZpYmFhc2Zvc1Brd09KU1lDa1IyM0tWa3A5bHpOWnRTYTdY?=
 =?utf-8?B?ZjlVcWNUZjdkRFZJNDRIMjYvZHY2dlRobE1KWjhqZmtXR2NOdWZYb0NjOU5Z?=
 =?utf-8?B?d2UrQ3V4d1l1TDZkdFZOMkRaR0tRK3gwMXpwN2szVFdDU2IrbjdHempiL2VT?=
 =?utf-8?B?RGRlbm12WDNJR2Z3a2w5aVBLWmdyRGZ4dHl1eVMwSHhxOVh3b08vLys1ZVdo?=
 =?utf-8?B?cGN1cFJpM25CSFBESGQ2bUF4am82eUp6Y2hBQ0h4MzkrU3BZK2FjRGZJUkFn?=
 =?utf-8?B?QjN4K2FESnBocXNEbFg1R0JHaENNWGFmMVNuY3ErVE5RY0JzelIzZlRFVFJq?=
 =?utf-8?B?UnpmRFZOTkozalZUMGdobEUzYTlXanNJNDFDWkRJWG5nZEZPZFZVVlBkbnV4?=
 =?utf-8?B?R29mMHIzeXNOcG1pYUNkRGRDeTVETEFIYmJadDRvQ1BxcFBzMzJ5YWNLZFRy?=
 =?utf-8?B?TXBDeUNPVGFTRWwxeDEwYXYraUdLd3ZOdGtnKzZzaGFPVWdGU2xWOVJPNFBM?=
 =?utf-8?B?dmxxRlFHUVBsOXZqeitOa1dQRzRqRXhYYWdqem0rb3FsWHM4RzN2YjBTdFJN?=
 =?utf-8?B?R21uR1A4UE5XQXZtODkzSUNhMGNpSjM0UFF6UlZjdmdGdGljbW40Zk5jay9V?=
 =?utf-8?B?L0tHcGFPYis3VXhSSzhtamZFbTYyR3RqaWMzNlVnT2t0S090Z1pKNGdsbTR1?=
 =?utf-8?B?TUY5czAzN0x3dStoMjgvL2lESGhtY0x2eHNvcjMrZlE2V2lVM2ZUWG94aE1m?=
 =?utf-8?B?N0x5cndPUFBseE1UektxcVVOYnhCbXBUSjIvNk1GUWRJaml5SHhHdzlrQ3gw?=
 =?utf-8?B?b3FudFZoZFBuR29zZDdFWm0vWDVQUUhVTDlCNXUzZkUwN1VvV3hqRnVNTGZY?=
 =?utf-8?B?aXk5Z3V1eUw1bS9YWXRndU5JT2kwbnBaVmxmNHFxTnZPWmRFV0ZKc1pRV3Rt?=
 =?utf-8?B?Uk9qa2NUMWxwWmF5REZSM001eFlGZXVTUUFjUkxwVUdZeVVMS3lpQ25vUEtk?=
 =?utf-8?B?Q1cvUjRTUk85UlJBRXlab1MrdXd2b0xza2FBbVNEcE1TSEUzR0xnS2lxSmZG?=
 =?utf-8?B?a2UwQTNTOGg3RllxajN2U1NMY1BxUVdTWWkrLzhDRVRhck9pUStXbU1abHhM?=
 =?utf-8?B?clVoU3JTK1U4Y2hxeHIxNjBmQlpNZjBaN2J4T3lQWEdlMWF0UXpKZjk0Vm8x?=
 =?utf-8?B?SXV3QVBmSzZDaGxITVhPL2g0NklJaFgwbHlLQzVIUklER0JDWlB6cUtRM1do?=
 =?utf-8?B?RTlOaVdkNVZjVGt5RW55WHFPMzJaVDh4UmVXb3lxY2hPUGgwcm4vMTh4OEhR?=
 =?utf-8?B?MWZoTVRNbTJwdnBObTZ5a2d1V3NLU0poRVBkT0RuM3JFQmw1KzhMcmtIN2hQ?=
 =?utf-8?B?RGNmSWFnbnFxa2h2OGJwSEErUXZWZmNGZkh5Mys3Vi9oSGdUVmZyZTB4Z0s5?=
 =?utf-8?B?Nk5pRjJsd1kyTnBJcXhBSk9XRzF6blNOVmNzQnZ0VDRtMzlOZXNNRmFvUW15?=
 =?utf-8?B?WElpZ0xZT0pJYUh3MllmMWhLRHhVMFZtWFZRSUNiTWRqWExXWDZSWUxuNzBB?=
 =?utf-8?B?cXBvZElqY3cwbTg5M2ZyMEVMTmtjVmtmdjNZaEhlRFVSMmhqR1ZoNkZ6VVJk?=
 =?utf-8?B?OHB6aDNHM0NzQ0gvai9mVXl4N1VVWUtMTjVYQno3QWVDRE1sUjdCZ2dLbXRN?=
 =?utf-8?B?OXlMNS9QOGQzMkh6SFh0V3g0cGhEZU9yMEFaUktGWER5UzdsNE1aUEUwUDFG?=
 =?utf-8?B?WURFNnlnWWhxYjA5U2ZuOVpOWmJ2dnl0OHpodVNncGNBR0J5THNXaWpQRGRK?=
 =?utf-8?B?L0laVjR6d0RYUldjVXAvVGIrNHo2b2JPZ2RRSmZmcWRvcWFkVFNxNlBNK1Ix?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c64664b3-e7a0-4a44-6d3a-08dd8ccf6f6c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:54:31.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FpFVggLlB0sW6f8eO5ZJJ5ypnYe8UruBMzXEnK9jlQT0VSfbNHmsUQk+5LqDa8i/2gPZ5Mr+VpRXCc5pl7g2lmLU+EXWi2SMP44tOuzvko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-OriginatorOrg: intel.com



On 5/6/2025 9:00 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> There were a couple different issues found in fbnic_mbx_poll_tx_ready.
> Among them were the fact that we were sleeping much longer than we actually
> needed to as the actual FW could respond in under 20ms. The other issue was
> that we would just keep polling the mailbox even if the device itself had
> gone away.
> 
> To address the responsiveness issues we can decrease the sleeps to 20ms and
> use a jiffies based timeout value rather than just counting the number of
> times we slept and then polled.
> 
> To address the hardware going away we can move the check for the firmware
> BAR being present from where it was and place it inside the loop after the
> mailbox descriptor ring is initialized and before we sleep so that we just
> abort and return an error if the device went away during initialization.
> 
> With these two changes we see a significant improvement in boot times for
> the driver.
> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

