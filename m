Return-Path: <netdev+bounces-221997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C7AB52989
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168113B844E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E4238142;
	Thu, 11 Sep 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HU/xsnIu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4722068F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574284; cv=fail; b=bpkE5/03FNRDOJnTScUv0T/zgMqK8ZnzjEYbbyASeZKrxNidf4GV3gKlUu8bN3xPOg2e/tQ1wlzacha0ecHsddRDx6Ip9e5ZNifqKtyEdUqteXQt4ozMnKTkPA323L2MaqgmakB5vUYwQKmPbE9NJRaW+edthD98fIMpS2lk3bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574284; c=relaxed/simple;
	bh=fIG5Mw4OI66oZwGuz55fAzc3jsskQgBoes+lCF+SnRA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neFi3YN4VKJ70v+MxS1t55CzIj/tMyipWNR226ZUWoCfKipEz5nf6ccD0gmr5VASom9bfvqU1VL02nR5NVrN/QF4gDZJpsyDy2SZK2Og8iJ2/j11K8PL+orvTr4CW2A58u6Y9yfxGur9M6JUravIQeh4hSf+CddDol799GZ/MrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HU/xsnIu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757574283; x=1789110283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fIG5Mw4OI66oZwGuz55fAzc3jsskQgBoes+lCF+SnRA=;
  b=HU/xsnIuaii7m1FCAGSp2IpClm3NVan4ZOneFWNpaLUsbhlua3IeeWLd
   g7kRDhWRW2H5gpSy/Gce5EVsS7vnsR7wTB4skriqBN2ldZSz6ipRqpFfD
   87Jgz8y9NHCO6kzgMHdIYNefrAahoZmqDhnYL3fVI2ASib1cIvMovWySa
   SfNhhWVSG40S7TUMrIgCsJ6D0Ea0G3E97FKjbDoTnm0jWRGS5NZ9tujnY
   6qhBceALPxO73a16iWIaXs7oTXPPXMJHgsMNy3CxgVktzRz3KzYrEvbNr
   KtFX0RZjZo5J1FPJcF7m9/1NWOk72O5FJSQNhcKbDHQ9EZiplmNXSEkJs
   Q==;
X-CSE-ConnectionGUID: fehyjVRiSkGw+mE6CTL+AQ==
X-CSE-MsgGUID: HKrYSOGXSfSgAKc+Ppyadg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="71278220"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="71278220"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:04:42 -0700
X-CSE-ConnectionGUID: JbpIYAjNTZScaGG7ih0GIg==
X-CSE-MsgGUID: Gpx0+EWbRc+Msy1yObmG/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="173507227"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:04:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 00:04:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 00:04:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 00:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnQHgX/4b1nt0RKnOhW8S0T7S89rLS4/YOaqDM8cyeYOgrVt7meHOrOxbzmIxWIGXm3iF9zx8RvFd5WhrehaJ1AHMSxUq6P8UnXVIRvx2iHLdRXmfoyv24hm4XVHZviU8cRHkxk+n0cYGdgyKXIlMv+PLu4imG8SkTLtFsUpdZN/SbbKyKRDbUGmwjPik99Lj9NspAhYjSEPz6sFqF7TYVOeySYg2XHBnbQtsENItqEtka/mc53CW6IRKM11scdpj74YVWbNuOX12HW0BsLjbpTL509jENen4NvcTzTBD8yELtp7rbYAkamFHvR8/vLST9mU0FzeaeofSvIA008W1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UQk8FwbnjJTLW7LRIsKuHeqLN3cEFbXwpjRTnExp4o=;
 b=OKFXV1HU4FPk4G9JzAt9q7l7hqk2Tp7igNe76ZgYAO2yq/HV/Nl2Q7ikJ75b4PCUmUrFwTMPHqEq7BOBmsXS7FqBkBAcW0925UTtNoASJQRli7uo9qNA2eXqoOMucNt+8HJoOwY0eb0e+Ykaw7ZYY/MlL5i2AuKyT3REDcplG3dLYv9Mht7lF+Vi9s+Xt8UpSTlpAXk4xlUPq6lVmsks1AVFrdT4AaHtikvr4bEsdNorQ13fx03mrOVOn6t+txZcigzGJLqCkIGDuiyloThOt4xzSLnU5cZ2jgFn8S7P4AkwAyIW3yfjNbH4h4HAnzLKLu9a120kKgk6r2jjSaOIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36) by SA2PR11MB5100.namprd11.prod.outlook.com
 (2603:10b6:806:119::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:04:31 +0000
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::6cbb:604e:d0b9:97a]) by DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::6cbb:604e:d0b9:97a%8]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 07:04:31 +0000
Message-ID: <995b4ae2-2163-4618-84de-63548c7e2633@intel.com>
Date: Thu, 11 Sep 2025 10:04:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iwl-net] igc: don't fail igc_probe() on LED setup error
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Kohei Enju
	<enjuk@amazon.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, "kohei.enju@gmail.com" <kohei.enju@gmail.com>
References: <20250910134745.17124-1-enjuk@amazon.com>
 <IA3PR11MB8986D670D2CD4C1543515308E509A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <IA3PR11MB8986D670D2CD4C1543515308E509A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF814058951:EE_|SA2PR11MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad3e052-1a81-4775-ad82-08ddf101747f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzRrZUZZek1Ia2REVXF1Z2p5YzZURHhiVHM4TDlzR1FBcGRRZzZyeDRxYmVB?=
 =?utf-8?B?Q2E2V0ZrSlBOUVREdlVyVk0vK29jdGNzZnlzZ2NFQVY5UUFTSmtHWGdBdldn?=
 =?utf-8?B?VGZUNXIxOWZqQVh3L0xXOVdCLzFNU21PZjE0V3FoYlpzWXlQT1RQck1vRy9G?=
 =?utf-8?B?WTFiNjhYRHN4ZENWM0tNeGJBSXk3ZDk3SDIyaHlOMlEyVmhMcFF4KytzcDJa?=
 =?utf-8?B?NzVNRmZVOVF5Z0xIVjBMRERIVWMzVzVvRFBvS2MvcHBISXhUd0g4WnVTclNM?=
 =?utf-8?B?T1lwTXlsQXM4V05qeDJaZ1lWZ2krR3k5MXZFVE11L2dTcVJXSXZKVU1UR01r?=
 =?utf-8?B?L2lTdTZBRWhaT2Job0xESFZPaVE0bFk5RmhTRmh3QkkwdjIyV1dsMXIvTkVN?=
 =?utf-8?B?MG5TbzAwbzFrYVVIOG5vb2JGN01FK1d1ZzI2ZHFwV0RlWi8wSmVDbmJWV3h0?=
 =?utf-8?B?Y1RsVHNCL0V0ZmZEbkpSRGt1cHZabkwvbVJCaXU3ejhkU2NIRC9ZeHJmT2Nx?=
 =?utf-8?B?M0JEL1lhb1V1MnltbUowWjJFNXVkeTlQUFpURkpHWHJNVlJhaitFeU5kWTMz?=
 =?utf-8?B?VDVTNmZYUDNaaENkdDFlQ2pUSFFLTjdORmhzV2hPRkNNMU44OHNmcFo0YWdk?=
 =?utf-8?B?TW5uME9BSFFXN215ZmFMakptNjFXYXZ0VFlScjYwM1g2bk85bVdUdGVxODNs?=
 =?utf-8?B?cDJ5c0R2UjFmcmpIVVN1RUU1dnI1R1BrcEp4S2ZUVlRuWm4rQndkWFJ2NUZu?=
 =?utf-8?B?cVZ2UU55TXZ6NGpzUVhUbmtaZWNHaHpGZVk1ZXpoR1BXMXpUeTNNWUhvQ3Uy?=
 =?utf-8?B?T3lXUWFpVmh6RTdXZFNOWjBwTG5yRnJVRWw5T3NjTElRRUV1VHEvWUExQmR6?=
 =?utf-8?B?Rk1JaXBnVEg1NHhXdUtjZ0c0R2VZd0JHTmsxa1J5VUhMazBpcytHd09rM2FE?=
 =?utf-8?B?SmFVdjljamw0bk5RdkVxR05wZ1NZRnBJSGo5cm1KOEErRC8wZ0xXNXgzUm9J?=
 =?utf-8?B?cUs4REpYUytDcGNORG5rYkE0dGxvNTBqS2pjTVlGWHVaQnpEZzB3WXY1SWdY?=
 =?utf-8?B?N1k4VFZBZG15WXV3NVk4NUY5UzZYaXNXS2ozUkdNN0NEekRqUnM2QkdVaDYz?=
 =?utf-8?B?R0dhTFh6b1MyTjF2VVRRQ25MTC8vQ2NwTHo0YkNjc0hSKzdJejM1UFFSNERj?=
 =?utf-8?B?YVQrU0xLbHVlcUVVdmxUMDg3bTRNdFpKUWZCZ2lNV2xuWUh1S2xuaDVvSUs4?=
 =?utf-8?B?Zm1ubnJtNUhEY1VjcFFLM2c4YWpKQVZIeWdrYk9MdWpsUjREaENzMFduR3gz?=
 =?utf-8?B?eWZVMDRvS1I5S0NZR1FRTU15dm9PdmtiUmhNQ0RQNHR1RVcrcDZ0c0hZVFJF?=
 =?utf-8?B?eS9iZGhQQnRoUEZiNkRGeVJiMk5TSjRxVVl1K2pGOFIyNE1sOE1udC9FQXhr?=
 =?utf-8?B?ZFZZUzZtenQ1WWRDelFTTXhqOEw1MmtsU3pmK1RVU1hHUm9PVkhUSk9mWi9Q?=
 =?utf-8?B?QWtkRXhZQWxGUnQwR3pYZmRkQTZycHNWaGtzU3diQVRGV0pRNlR2Nktlc3l5?=
 =?utf-8?B?MnJOWHlnaTd3ejVzWFFLek9UcTFYWFc3WktzaXFQc2UzU2MyWEd2aEZrVzRW?=
 =?utf-8?B?bC9UN1l2aDVkVmdzQ25nOG90Y1ltaWxZcHEzQzY5a3JZOXMxMDBXc2Z1bzhM?=
 =?utf-8?B?YVBYWTNiQXRsOEpBTEpGU3dyZExZbmNUT1l6aG5iNllTbEx0UWZrazN5Ukxl?=
 =?utf-8?B?K1VaNFJrWCtZdStlRUNzQ1pueXhjRnZjQmdvMVJhTFprcnBlQWdkR1ZqM2cr?=
 =?utf-8?B?VGRmZ0llZEh1MXlDRzhkTDR4ejB6a0YvR1RZWktKWldIU0xqL1BMYkRmVEUy?=
 =?utf-8?Q?XuWle+IzNA0D9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF814058951.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2gxQmM5dE5MK3hDbUlPb0V3ek1Hd05VTktjQ0VlN2RBMWprNVRFclNHVUd4?=
 =?utf-8?B?dys0THlEaEdhdVlFSEdvMlFCSmNRME85YU42QUFzUjk2WTFDb1cycXlJbFZl?=
 =?utf-8?B?ODNlOEVseGh0T1VaQUYrWHErcGsxOXkyOFQraW9LTGpMblhTRVkwWjcxb3dR?=
 =?utf-8?B?ZzcrTG51bWtzKzh5VzNra2N2cDl3TXp5ZCsxRlE2d2Q2ekhyUFN5M0FMbTRX?=
 =?utf-8?B?blYwZzlPUXVGTW5PNXpwS2htandGNmljTW93TTkyTFh0dWpOL3B3MmRXaXFh?=
 =?utf-8?B?ek9ZRGFTZkZyUEcyT0oxN3dLcmpKWkxuNkFreG82NG0weFlrRnFWMjlHTElB?=
 =?utf-8?B?SzZnaDdDMnBtQ2F3TDBTdDFhaVhNZTlxdkprZk9UaGZaMGJ6b2gxM0lUUWlz?=
 =?utf-8?B?M2pOR241V0EwekJ6eUJnQjhKaDhjRzRjbDlXS0ZLTUUvT21LbFlSbm80NFM1?=
 =?utf-8?B?UnFOOGFVNzhLRWIveHl5UWZ0cjYzQlYrQ0NXaTZUdS9oeDJZSndudHdKdVdj?=
 =?utf-8?B?THM5RWNJYm42eDNUdWlzVzF3YzVaNGpaRnczNzcxR0loMitaYVZKNmYxcWJq?=
 =?utf-8?B?U1FaNVFQdXlMdVpRODY0OEo5VlJ6SzVlaERpeGx0WEtFTFNxOTMrNXJDZmN4?=
 =?utf-8?B?aWd5R0VOQXpGUXI1S2h6VmZrOEYwN25ydzBNM2ROdytHeWZzSjI2U293WW8r?=
 =?utf-8?B?SFN1bTY0aHhjS2NrQ3A5bXBMMmFZakFWVDl6ZUZjSXNjcDdPVnptdUpZM1hU?=
 =?utf-8?B?djRMa2RhSlVoa1ZmUkx0N1NRRWtLNHRVb2RRSElmZWdXaWlIK2pBdERWMlZG?=
 =?utf-8?B?UHpXdDRtdDNWbS9vVmRFdk1BVzhNdnNackJGOGFseUtKdnRsNjUxUUpWY0x3?=
 =?utf-8?B?ZE9pTWtpT1gxZVhobmdDWWlnbkU1SzZhbGZuVVBKeHJwUStVTCtUczJTbGtI?=
 =?utf-8?B?MXFZdmdaUXpwekFERDYxNEZBMHpVM3k3cXl3dWVocnJ1WHZScXV3UmM1ZkZF?=
 =?utf-8?B?bVhrSUQvRHRaR0RYdlRuckh4MnZEeTlFYlJOaGhpMDJQa0xySWhXMjdTNGlz?=
 =?utf-8?B?NFpEL0JSWjRqL3RTcVNFeFgxYUJaZnU4U0hGUi9OQzBYNi9ZZjB5OUU4R09P?=
 =?utf-8?B?OEJWL0JGVnI4VVBOY3Z4SzY1TlZ1bzdxSzdxb1NkUjVHM2RZaEMycElEbkNG?=
 =?utf-8?B?eTY1NU9OazcwVUdGbnZJOE1oTzBwNVM3cDF3RDRQdFlpSUlUVFF5RjcyL3hG?=
 =?utf-8?B?MnlweWlONXNTWHU2dW0xdms3V01GVVY2VkFSNXVyWkNiTDVYMmUzdDhWeWR5?=
 =?utf-8?B?UmVqMWlZcXFuMzZZZ0w3Zk9MUU8zYVZ1Yk05YXlqM3E0OElUTUdGR1FVVGZJ?=
 =?utf-8?B?aSs0MXdTYkZjK3ZrZVk1QVBWSHZ3NDVlSkVaaGYzRGE1S3RwR3dZdW9XUVU3?=
 =?utf-8?B?a0pmRGJTNHhralp0QnJ3bUZDckxVbmJUc0F1V0FaaVIzOXFsUDdhalpDN2pW?=
 =?utf-8?B?cDcwbzhTUlhlYXhicWNXcmR0N0F1djVqRkc1ZUQrSXpSdTdzcGZlZmREa2M4?=
 =?utf-8?B?SEFVT1lMbWVrZXErY0JtT3lyMnJjMjk0ZS9rYWdRWEVBYTBlVU5VaFFqOTR2?=
 =?utf-8?B?Q2hVOFBtZm1waVBvTUFPYU9ST3hDd0ZBb3psRGhwaFY2SExSWXhiM3B2L09V?=
 =?utf-8?B?dHpJejErekIxcEpMOHBpZU8vcFo1bDQ5WU5KVDN0S2grVWJ0V2pGL3JPaFJh?=
 =?utf-8?B?SkRTbHVKRUlLVzhWVnhFeUVBRUw3NndNVy9CZ0RoL1l6elV1K3FjZGFZaVNZ?=
 =?utf-8?B?blZDcHg3enBxcUF5UmF5QVJsaFdiM2taT3cvRFpGQUNvQWZCL3N3Z2VHTjJ0?=
 =?utf-8?B?bER1TjJvU1ZmdWJkVnVZdy9FaDFaUERacWoxamw5UThLb0owNGI2UUoySFRr?=
 =?utf-8?B?ajNNTWxKR053OE00TCsrRDhoYTJKcFNFc3dKM0hDNnFPRUF0K2xDcVlCQkJE?=
 =?utf-8?B?RGs2UGFmUHVYRDB3a1BJTkFBT3Z3SGJpbmNGNityMDNMeXhsVkFrRjcxLzdZ?=
 =?utf-8?B?ejd1U2drdzdReXJwUjdtN1NLUW01VUhtU05oRWE4ZVVlam1wTkJZTmxRWmVO?=
 =?utf-8?B?cDJDdDBiQlczdGJncmp4NWhQRmE0dGprajVPNWhDS1h2Mlp2empFN1RaZTVh?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad3e052-1a81-4775-ad82-08ddf101747f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF814058951.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:04:31.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UL3ONJrinC5cQ1ke58eFYpEPyRmFZxX/iW+W48V9/luOM8CLf8wvCSAxRF/EXXcEGvVhTsJ28BXuxP2GchZEPDSTTGsYOfLVdhsvNFlv/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com

On 9/11/2025 9:36 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Kohei Enju <enjuk@amazon.com>
>> Sent: Wednesday, September 10, 2025 3:47 PM
>> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
>> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; Kurt Kanzenbach <kurt@linutronix.de>;
>> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Lifshits, Vitaly
>> <vitaly.lifshits@intel.com>; kohei.enju@gmail.com; Kohei Enju
>> <enjuk@amazon.com>
>> Subject: [PATCH v2 iwl-net] igc: don't fail igc_probe() on LED setup
>> error
>>
> 
> ...
> 
>>
>>   FAILSLAB_PATH=/sys/kernel/debug/failslab/
>>   DEVICE=0000:00:05.0
>>   START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
>>           | awk '{printf("0x%s", $1)}')
>>   END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))
>>
>>   echo $START_ADDR > $FAILSLAB_PATH/require-start
>>   echo $END_ADDR > $FAILSLAB_PATH/require-end
>>   echo 1 > $FAILSLAB_PATH/times
>>   echo 100 > $FAILSLAB_PATH/probability
>>   echo N > $FAILSLAB_PATH/ignore-gfp-wait
>>
>>   echo $DEVICE > /sys/bus/pci/drivers/igc/bind
>>
> Using fault-injection test using failslab - excellent!
> 
>> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
>> ---
>> Changes:
>>    v1->v2:
>>      - don't fail probe when led setup fails
>>      - rephrase subject and commit message
>>    v1: https://lore.kernel.org/intel-wired-lan/20250906055239.29396-1-
>> enjuk@amazon.com/
>> ---
> 
> ...
> 
>   
>>   	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
>> --
>> 2.48.1
> 
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

