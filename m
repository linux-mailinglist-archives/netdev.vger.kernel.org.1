Return-Path: <netdev+bounces-304202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 56gRJ4VyRmrjVAsAu9opvQ
	(envelope-from <netdev+bounces-304202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:15:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2866F8C37
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:15:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=VLlR6Cvw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304202-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304202-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21E94300D72B
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11784C6EEF;
	Thu,  2 Jul 2026 14:09:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800D4C0437
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:09:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001386; cv=fail; b=NecFyTySAKodWSqplSYqYu28Iygi89nU4GGkwpdE+SDOawEsW5yLpy5FJ8OTc5WHVnpnQLdZoW15TNTDSAQHEO4jtkNigPJ6iHEAPuyi381/k5QOIphNjBsRgIm/VNkxqdLpgHVQBYU+iIuvVCm01W6IfJFjqZ0/8MUJ2K8qV/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001386; c=relaxed/simple;
	bh=kW9+m6grfUzJskBK2HLBhu/ucrY2rJ9YXA7WnLCXWVQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nPnEohpJRd9pGnA+uJ5htOu6ojMrzBxUH90VtfIJBYX4s34A1voBxbpwyKZaDFeICFI/J6zT3PQ/iNS1MP0iqUAOlAbqqwI0BxzguSXb64mCRuAuJuPo65f6bPVu8LNnp0KjL8J5YznCdmwRG5W/2n5rEQRKhZpdiHvwtd/Ypl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLlR6Cvw; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783001385; x=1814537385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kW9+m6grfUzJskBK2HLBhu/ucrY2rJ9YXA7WnLCXWVQ=;
  b=VLlR6CvwjUkOwTGpIk1FL91ea4EyhVeEewy1PmvELsSq8Em5SjgpuMSm
   qcnVqbQbPlwTYYWQqFCPUIppn0RWBBg7IdkoqREueQ9ju02qNUGTsct9n
   cNSxlmh8WO1Qd/yKpIxexAyLhpquRaImrra3oVomRZY4yClWgvz2jqquj
   r4fZerjlu4x7bJdjNJA7elBEGe2DZtFvnq+Emuy5gLg3XSfipDXat+Xyi
   i8/eJp8cJRlx1Td0k+g24gqdX4doNT3C0DwGXQkeknuyjS7Z/082jbL5/
   NCiKmDg8Qmgw3+KeOHTp3AggdnkeoilvyX5eMyqKWQSauYSnBWxdHLvg3
   Q==;
X-CSE-ConnectionGUID: zTK0eFSPS5WxMlzdGDJ9AQ==
X-CSE-MsgGUID: xGkwiK5DRLOSvjf//CYzww==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="109305878"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="109305878"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:09:45 -0700
X-CSE-ConnectionGUID: hCg0CXcTT/u/5po+GpRjvA==
X-CSE-MsgGUID: hFbFWcHSSdy8W6CX/4JHYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="249523697"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:09:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 07:09:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 07:09:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.61)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 07:09:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7FHhMV+Xhwp2d0AvYyXqYhlV1KXMA2y7Wwe1q16Zg9Mk5WNxIDb8D/pMg5wyemm0vZNRQ9Dnz+R7pUYRDrLzyoqpErMrs+w4fNpF+1Jix/fhTA7tLh4RBJUvvXuPSmaP6pbIXDjxqjzLehqkBN9SPlG6Od9boX1OVT29JD+ezlDNQCU+D07v3v4kR96VBX/xLJc6GvPHOeVG4+im4+eB0VQOoIjJJixndrdY7KzpldAkmM0yo7yuaA1sAa7Pwl/fxZQAOrWWClW5s6KEp37gNVzH6FWpCuvCMWaj+IyuOArKq8rMkCt8C7g1EyVwFVkLWEEEyEdyM5LvRSx4FvlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORYaRwCHgLgIuAKigiJNggJfGrTafulNDlye8ZO6FIg=;
 b=rA+BML1Bxhd2xANzouazXyU86yw+v8LeEOj2Y5Fz0ymh/MlOA7RroKuhELSLhoJth75qUi8BoXbO89rchrk8zU6AIFd+hKPGMPKu2qTDN89OLMEFw7xOrCJhL/b5K077BuTmeyAFxEHoctEHfr3FDGB90zRmZMSy8bNnxY706UiqZV+ODTbUGIDRpwiDEq6ny8sFSLhUziK+5vqa5WxrWNLK7PkfZtnZHu4A4DgDazKROnFH22lCo3o6tgdd8erWj9fLfptVcy27Ry3dRgXN7JmYrde86gYDXhCuyAPSQNSE2VcMOquu4xhBPNnKKC7al6Ryrm+hNnuA/EoeNuf0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SN4PR11MB9941.namprd11.prod.outlook.com (2603:10b6:806:4ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 14:09:41 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 14:09:41 +0000
Message-ID: <fb6b1528-058b-4bc5-b97a-ca2c844e0608@intel.com>
Date: Thu, 2 Jul 2026 16:12:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 2/2] ice: fix stats array overflow via proper
 realloc
To: <intel-wired-lan@lists.osuosl.org>, Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Piotr Kwapulinski
	<piotr.kwapulinski@intel.com>
References: <20260701104141.9740-1-przemyslaw.kitszel@intel.com>
 <20260701104141.9740-2-przemyslaw.kitszel@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260701104141.9740-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0088.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::12) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SN4PR11MB9941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0255fe1d-b71e-4ec4-2710-08ded8438f5c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: kvRxprSkb0O7yqcoaZDHCE4aAxVZ7zKWE+UHkNZJc977L/tYaiMCCDuaQPPWNi6bei5gcQpMqtD5vCKGqM+5PztuJ/vkdGJUFqRr07pRTFkWGv7JRcyG+n8GBbW7DZ1hpwmpc3CY1vKdmFc2cx2QGw3Y6BcXgTLAeR3K9ZawOPpFvz/xOrm/WZzLYSkr/M4+lax6rmUFNt+QHeDR4u2xlc0BQFFdwIJ6hvFNLhlhxGGCtwZhCuEYRi/r4PmGQ2JEth7fHw1Cm2kQJKFme3h+VPJmaEhgFvocQVXu0EIbglDlrhGsZC1zP1UfrRh0WzmNH7WHz5FMlYq3LTQqRWLtVcxNOG4mPFpw0+AshZwPt90yhBY4zrTcBcCakEMv7viFVTWKveMFOPCVD4T58IHISunUGdbgqQq6+8QqyupiOrJ5araibMw5RE0tJ21MxLkU2CepP4OuvHuNKq7sLddgZSC5G4/lLt0ZMtW8hLN/1/qq4Pol7QzAQBlCo4x35bAmsBvBqfjhMIPuwdzJYg8+O+Tj3sBd82UUQDjsjGWFqjmT6QsmY6/wLE6Wd0+9f407pmo9qsN1/08hcc/newdPYrgbVdvpg9AWoxo9j/46jnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEpqcFZZTzd4Y2J3MmtFbERqcmZkYnJib0pXUUlSM3B6OUg3NytxQVRZT2c0?=
 =?utf-8?B?OWxGRjJRVkg1OWhqc1RobFF3OXhGaTR6d0NmeFBRMVNMbjlNUTF1TC9UU3Yx?=
 =?utf-8?B?VS80OHovdnJCdnRaVWQ0bjgxMFE0TlNyaCt3NnhIeVgyTVp4bEszK21LNmVz?=
 =?utf-8?B?b0UvRXJBeG9BZXJzdjRUUVlZVVM0cDZYWFRJbUJLUDk0N3ptaGh3WXdaNDNY?=
 =?utf-8?B?anYxSXpJc0x2MTJkVnJleFlyazhnN0RNTzRoc0xvVGJhOEV3c2RRQ0l4TWM1?=
 =?utf-8?B?QVlwYTNyNXp6ZUFEbFlCaUdpT1hJSXl4eWNnTGtkYTNzZzZMZDFqak1WdXJY?=
 =?utf-8?B?Ynp2bXZaNWlJMFBldjhRQ2p1bjhnZEZPQ29LdWZLU2g4MWNyakFSVlJ2c2hM?=
 =?utf-8?B?M2hOS0EydHVpREJrOUdET1A3WkU1S29uV1NBNjh3d0RmMTlRalJ3c1hPS29Z?=
 =?utf-8?B?dXFCSXY4Qzh6UEQvSUx2ZVRMMGNVOEZjNC9XS253T0F0OFBKdXlwN2ZwS2N0?=
 =?utf-8?B?ZkZBUzlDcmdsVmJPSFloZURqcDJ4Nk9NOCtxeWxHUVVZWEZHRGFRdzFWaE5M?=
 =?utf-8?B?ZnI5dHhjMlFid3N3NG5iZWRmUWduQ0M3NVlKbzFEa3J1NW9PbjVLTWZTTWx4?=
 =?utf-8?B?M3kwdlNRMDVBN21yTUc4MXhxSkhTU203eUk5ZS9jTlc1bG9oczFEY0RhZiti?=
 =?utf-8?B?RnlMQmhoNUsrVm84YmxiM2lpNUVYYnIvNUt2amF1RFJxVG1pMDNMUkZHbGMx?=
 =?utf-8?B?eHNSdWtHYUFSQ2t6QlR1dnc2R3kreXRNdCtESlVrRm5sSHdZWUxjQU44bkNK?=
 =?utf-8?B?eHQ5T0VsN2JPTG5TMFpsaWE5UGovUS9HRzFhUEx1RkpTT2VNOWFqUkhFVEVj?=
 =?utf-8?B?QUgxWkZGbysvdHVFejZLWUY0R1lTZ0JVTFozK0lBYmxVT1BmaFZ3VGZmYU5o?=
 =?utf-8?B?YzZKK1hMTndaUkxoRjlFN2YyRUpvaXhQNk5RWUQ5d09XQjY5ZWNGK09oYlZ3?=
 =?utf-8?B?Ym9sVStVM2JnLzl5aTdOVnRnMTdqK2lzZ3R1VnQ3VTdGRnpDanRkTVF4eHRa?=
 =?utf-8?B?cDBPQlEvb0E1VEE4VS9TSlVqem81QzQrbGV4OVNhdlcrUyt6aGpLdmlrSklk?=
 =?utf-8?B?OFBOcEJ5OUVuL2lYdEpLcG5mZDlEc1ZPY1phTkhFQjFkdmI4NE5BSXhWQVdS?=
 =?utf-8?B?TFNkbjVpR1lNcjVtNWhROEFadFAxYUduZnNkQzdURDZGV2xRd1ZNTzhZZTNv?=
 =?utf-8?B?R2w1YTRtdkl4cmhTbVVzWnZnU3M2TnlnbVJrb1VTQkRXdVF4N2ttMDRoMEJS?=
 =?utf-8?B?cHJKUklvcUUvLzY1Sk1IcTlLVElYbzlTeXhydU9OZG5FaVl0eDVBang3UUhC?=
 =?utf-8?B?Y05XT1NoV1lmemk5SU1WK3FtdzczY0dsaFZBNnNCdHR1WnY0eUFQQkY0YThz?=
 =?utf-8?B?alVKSVhlVzBaOGtsVlJOaEllMWFlb0NySkdhVzV1eXd4TDhmRVFzWWtIVVlS?=
 =?utf-8?B?VG9XZVVUNityRXlqd01jT0xSOVVFeTBjUDluOE5pVkIyRmdRa2JweTlxd0tN?=
 =?utf-8?B?akt3REUwTXpCNGNWNnczL2VlTS95T0NhTUNvNGJpY0tmT3NqRFlYU0dYRkd0?=
 =?utf-8?B?OCtQVXVGRExFZnZaRzdxN1k0K3lab204N3RyNGZRR3NEV2IxWVRDcE9PV0Jm?=
 =?utf-8?B?cnVaTzlVaFd4NmRMZy9uMEVSZ2RqdVZiMEVPVUFlMmxDR1kvYVJiRitUeXU5?=
 =?utf-8?B?R0VPSTJCVTFzK2ZMWWNLajVEWUxjQU9TNEFNSGlkRXN6anhwMEJqazYwdU83?=
 =?utf-8?B?YlZsRk90aDVVcDZJYmIxelV5MzlMMWtxSUdoeDdIdThVaHJlUndHZWpCamVD?=
 =?utf-8?B?aHlBdENxVW9HWHd3eFlSdE4zUVlWVkpkYldNVnpmcm9kYkFOZU5UYlA0R29I?=
 =?utf-8?B?Z2toNWx0bHZUc1RTRElkcGJLQ0pyUGxNSlpkUU5yODdUODNVQ3BCK3B2T28y?=
 =?utf-8?B?ZlBneEtVNGgwZnZzZlNaWE9rN2VnNkpOZ0Z2WmpFT2JYZUhIbWdWZkx6NHdD?=
 =?utf-8?B?eUpJUFVlVHlPUGp3RFRRSDhNcncvUFJTa3ZneFdQK2dQREpvMGVUVGpvelpT?=
 =?utf-8?B?RS9hdU9NUHIvdmx0RnZyM3daYVptR3UrYzc5ekt2NkdFUHpZN0diQS9VNjlY?=
 =?utf-8?B?K0M1dllLbDhRVnhnS3ZtcU9kcEgwQnQ2U2xDVCthbFVmNE9ZRFZQQlpucEpC?=
 =?utf-8?B?dFg1aDBETGNBTjNsdlp1S2NITExYSnVSMmpQaXNUOEQ2dllHK0YrbUdRcHN4?=
 =?utf-8?B?UVZTVWpKc3hFeVpyYzdkOHZtdkFFa1FiUExqZEtTTmozQ25iSzl5dU1tdjVZ?=
 =?utf-8?Q?TRXx97uZAOJsA4hQ=3D?=
X-Exchange-RoutingPolicyChecked: FRHSb1At3I7uHzSuUoGZdM0FsKf5TDrDpZjd10LQnoHx1YEiESJlSnvNr2FB7aohqwTVF6W+/hloWbBAzw/j04j4HQO4XXtotpVlQKfIvdlkO+d4OxmDGLIFDD09TR+1aKk91imMFj31c0owBQyFP++2SLt2thIWgGyeIFPa9Ww5SEULVt3Oi5lXVX5FscMgvWZsefGjDcms/vryVO1kiT4GcJ+T+7RrVIvLPSuuulDDxaVFbq9ud4MQHhF28+SpABs4UON4+Q298n8YjW6DhiYQz4riyd+rgWmxYxsf3W+GGi2rJCI72O/JCdDbd4V+FhL46UG5PPi9tOR8QHfxQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0255fe1d-b71e-4ec4-2710-08ded8438f5c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:09:41.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn17s89LUJC4UAlhOy0tVtCjafwdZXn7jKwz/Tqhk1xHS5gFwixmbrB05CpZZliIYK/VuraQoSg0W+WEOY2U2+0k05M3JtlmHT62VHjltQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR11MB9941
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304202-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:mschmidt@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jedrzej.jagielski@intel.com,m:piotr.kwapulinski@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D2866F8C37


>   /**
>    * ice_vsi_alloc_def - set default values for already allocated VSI
>    * @vsi: ptr to VSI
> @@ -2319,7 +2274,17 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>   	u16 prev_txq = vsi->alloc_txq;
>   	u16 prev_rxq = vsi->alloc_rxq;
>   
> +	if (vsi->type == ICE_VSI_CHNL)
> +		return 0;
> +
>   	vsi_stat = pf->vsi_stats[vsi->idx];
> +	if (!vsi_stat) {
> +		vsi_stat = kzalloc_obj(*vsi_stat);
> +		if (!vsi_stat)
> +			return -ENOMEM;
> +
> +		pf->vsi_stats[vsi->idx] = vsi_stat;
> +	}

sashiko [1] points out that if there will be allocation error
later we will end up with, say, vsi_stat->tx_ring_stats == NULL,
but ice_vsi_free_stats() will try to dereference it

will post v2 with a fix

[1] 
https://sashiko.dev/#/patchset/20260701104141.9740-1-przemyslaw.kitszel%40intel.com

>   
>   	if (req_txq < prev_txq) {
>   		for (int i = req_txq; i < prev_txq; i++) {


