Return-Path: <netdev+bounces-156178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC6CA0550E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F90D161D51
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731A1B4231;
	Wed,  8 Jan 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGXiohTa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588A1B21BF
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323948; cv=fail; b=pUXfAEmLR+cQEL9qVAP4eWZ0n5BMrGI4Q5smpPeJ/Xmv0BIvbqWHSzTXzrX/iRTJLqMNvrDl3LRr0TDpjUJo2KQMQchCxl2pvgqtbrdkGgX3muJHfL0BDONJjK0yJYgl+1oep/xZkiC+dMLKIti64X3/PC6dWGmsw2leiH10U0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323948; c=relaxed/simple;
	bh=dX4eIeylCdj9Ey1wtEiKp1g6Uv2XrRwFD7q1jC0X4+o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FccXdcav1+ivPVMsdrja4DRN3F7kaJHJ5jcxpWmgvs9HlmfE7E8CXEClcmUVDvd51OOAEl/ui9ZkdNSd3yqrHfEBmE/fv0M22ydHCS45TF4/6nkBHVb6mhGGF3df/kmUspSZK5adHfX+QUdidEHEIuGPqMVmDZtUePpo3T6eF/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGXiohTa; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736323938; x=1767859938;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dX4eIeylCdj9Ey1wtEiKp1g6Uv2XrRwFD7q1jC0X4+o=;
  b=ZGXiohTa9B9lTqvZtoX/Mxas68t9PT5SYCLjpH4kylqaYluXO1+iuJX8
   5BYo1UygJrQxkYttb5sEezVKJaT10BB3+HNye8mOTVKlE0kiWf//FpuTR
   G5y5r8yQtR2Qd/zyJPUbRwZ5/IQMPQOTCAj6ecsV5zTrJJgmwU0nPzCZI
   y21hm52dlolqjmAsYVO5FJyuYEjufgfEiriRREygXAewN5jMtypYc+QSQ
   //r0df89AEG/amRFHVJ88AlO61PpyJzQql27/mP+WWrzyYB/spT1VF1P3
   MBm8BxbgKt6RkkQacJa4bOtnYFEOjjuseqkUFgEC6ZqVXRv3Vxct9MXaV
   A==;
X-CSE-ConnectionGUID: RfrJSTn6RH+z5jga9UyIFQ==
X-CSE-MsgGUID: ze+IPSP8TsC4fqu4n0zFeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36230336"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="36230336"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 00:12:16 -0800
X-CSE-ConnectionGUID: tNbAeK8vQPy95+R7gZXx2w==
X-CSE-MsgGUID: diNgJh+IS7eYUvXnRrE6xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103867069"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 00:12:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 00:12:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 00:12:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 00:12:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIjKoccZt46fyz7/5kspr3gywTUYW2sWFxF+Veml78wc/h2fWvoDW488et/JKczJPd16o8oNFasRwjPWDKLw6Bi2Rm7i8sHWR850MgcCHSWZOdGHw2hAJpC3Eb85Ie5DY9DIzoGuO3kqoguoxbSSTSs1tYvPYo1jztp+GDbX87X7SJcHctbNrEFQYIzy2B4f+Xuvgm0q1MPiATW9e5N6y6CTbyf+LsDwmcsZB8Lh/8grB6Z/zBq7nanu+5SCtoBt3LKLLLwtQwHOD+k48Fz2w2nhH4Ulx6ApS0HIX/q/Acx4Fx8aBE3btxVNPn0d3ebOt+9xQYb1B8WwKNBOhMa1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzcVtMMO3MkYFccYfKZlFp9KjNeu96PiblqavPY7Rsc=;
 b=YTcVYfItXQRBUBYCSg2OdkP48WFIGfsy0tZNxPF8sMKkO6p6DTcZ7T7URz0EmNqOexLd8NKQuo0QcWFjfIOloR3z3xz5VeaVvmJTs/ve05o0Ahrd5/rdAK61RSog2a+VRyu6yIu18PQCI5k/NJhg/m6mwI/1EffnHghKZpJZko6+3EeIL1euuQvT9aaJBhABBFMXjpUIFcykMZlNZGltfC/uqKFoZb53DW6Swr2LNOrQjPA9rQGvbX4LfySvsUMCYSKW5fi7H4CrE3DH0Fs3O428kPTiQUe5ZiHyqChtqdS+aqkwxySYzxeg/IZeKGZKpJxRA1IwIAU17QNdnvsSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7796.namprd11.prod.outlook.com (2603:10b6:610:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 08:11:57 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 08:11:50 +0000
Message-ID: <e648c46b-3913-401e-be81-daf83a04b56b@intel.com>
Date: Wed, 8 Jan 2025 09:11:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] igc: return early when failing to read EECD
 register
To: En-Wei Wu <en-wei.wu@canonical.com>
CC: <vitaly.lifshits@intel.com>, <dima.ruinskiy@intel.com>, "Chia-Lin Kao
 (AceLan)" <acelan.kao@canonical.com>, Mor Bar-Gabay
	<morx.bar.gabay@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
 <20250107190150.1758577-4-anthony.l.nguyen@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250107190150.1758577-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::46) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdc57c7-d7a8-4a6e-d4e6-08dd2fbc1acb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3k4aXg4TEZ3dHNvT0pvM1dIbzNBbWloMis5NEFFM3pRQzlPcTRBaXltZ3dI?=
 =?utf-8?B?U2k1aG84TWF4cHZYOXBlbGhnMThhRjM3bTNndGd1M2pIVmwwOTd2K0hnM1dO?=
 =?utf-8?B?YzVKdU9LNjcrbG5pTU9pYkVPYjFHaHpYcUhPek94Qk5QbmptcktsRHMxd0JL?=
 =?utf-8?B?ajc0ZThxM1krQ2ZwTDRLajRsZ3R4WVZqZDN0a24wall0L2dGc0plOTB3cFF5?=
 =?utf-8?B?Ukw2VVZreXBMVWhHcWorejIwU0NJL1QxRDhYVWVjeTNPY2g5Z0xOS0FXNDhE?=
 =?utf-8?B?R3pEd29laVFaMFpjaEcwcENuYTVibVMvOG1qVlpNbFJTQTgyR294Wks5OEJU?=
 =?utf-8?B?VzVJenhsdDNpTnhVZ3I4cTlXT09MdjRUZDg1TC9MZFFGSU5rdkd6ZkplemRU?=
 =?utf-8?B?Q1k4VGZrR0pWc2lxZExxUHIyb2lSYnVFMTNkYVVkeDQxdW80OEl6ODcyYVBU?=
 =?utf-8?B?Q2NnQVVpT2gxdnFoL09heXI3UFBvbHdNTkEyeUdCVXJYYjdyMmNUalFDR1c2?=
 =?utf-8?B?aytleWNNQzVtQ25sSjdneHc1QkhnMVQ4VzNGRW55Y0JpNG5paVZrMWlzVS9t?=
 =?utf-8?B?dFBJZmROdDN3bmMxUnlDRzlabkRUK1RQMCttc2xJTlc5S21WOHptNDNSREtN?=
 =?utf-8?B?em5JbTVkMk1ubUVCamZkODVUUWJVQy8rbzlrUTBmUlBRM05ZNlNqK0ZBZElu?=
 =?utf-8?B?OGN5L2l5N0owT25oZG5kTUhGaURkWndTS0s5NWxlZGh5ejVMa2RWM1VLd3lI?=
 =?utf-8?B?TnNoUzZFczJPVHk4UlRXbGhKcmY4TGNKYW5UanA4b1EzUm43M3ppUnlva092?=
 =?utf-8?B?aWRRcTBuZFNvWkx3MmVPZEMvdE5tOWRkWDJ2UzM1SUZkdUc0NGJvY0l0d0F2?=
 =?utf-8?B?a3VnMGRmMEs0bVVTK2pjbmJBVGNVV2V6bm01Z0I4R1NSUEE0QXUwb2o3ZU00?=
 =?utf-8?B?K29raEtmYmFTREdLMjFZbUl5VUN4dGdRdlFsMGZGVGdHQjZNTGoxbkJzWU1p?=
 =?utf-8?B?VjZjK0Y3Nm81cUdOaDFocDlXd1V6eUFJekYxWVh2OXdlTVFUeWs2RW93SkdL?=
 =?utf-8?B?Vml4K01NM1RLcjRCVHhtQUJNbUJtSkRHV09YQWh3eWlBK1dTU2duR3NBWU5T?=
 =?utf-8?B?RklyT3R4c1ZXWUZnTTYxTHZjeWJXd1RCbWJxZUpDWDNEZXRXUWJTaU5rTXpS?=
 =?utf-8?B?cmlyUHE0YWhRRHRBQ1M3VFNmMGV0bWhtUVV2US9NeDYvNThSb0h1Ylc0S2Jy?=
 =?utf-8?B?Y0FBVVBGY21WbUxCTVphNzhQdG1EZklQNmRGMnpwZzhiMXh6N1pJVjdXVDk0?=
 =?utf-8?B?QjYyOTJJbmppb2lOa2FKaFlrc0FibnlFTW9iQ2d6SndLZXhQbklSeEg4V2FX?=
 =?utf-8?B?WjMzMHBMNHZPN1ZQMkR6OWRqNjNDaEpGYVZpYkpXbGM5RkhzV0tjNzhJenVr?=
 =?utf-8?B?ZndiOGJVclpRVGpRWlhBRjBZWklJL2YxaER6VkhJcWNNQ2hQWFBWTXpqVUpv?=
 =?utf-8?B?aWttRlBwTXcyRlJrL0Q4VWpBSEdnSFh2UWNqcVpDZDFlU0c1K2k1ZlFGSFJL?=
 =?utf-8?B?R0lCc3VKNUFJaU5KWFM3OEp4UlJtZmxwUkZ4KzFvZEZZTzdzL1RTcUF2S2l0?=
 =?utf-8?B?NUZVcnNuaGdndjZ2c2hLU3pSNnhxVzAxQng1V0F6M1BaTnY4aitTSFFmTlBy?=
 =?utf-8?B?aVViUnhoODNtSkYyQzJQeG9mWTdvR3pUNk4zYk5KRHpSQU9WMlp5c2J1Z0dB?=
 =?utf-8?B?NDBIUFNxd001VFkvYzBQYWgxYXJLc3JBVVBMY2p5Vncrb1UwVFFBeXA3UnlN?=
 =?utf-8?B?cjNrbEptaGpSY3U2V3VUQ0F5UVhicWJuYjQ5b0hoYnRrL2ovWDA0b1dSeFZX?=
 =?utf-8?Q?FcBPMpP8Y3zhV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUttUlEvYmhyUTVDTjViMUg1RHA5U0Z4eFJGOWd3d091S1Y3cm5takl3ckxZ?=
 =?utf-8?B?NlQyZkh2TExGS2F6YXE0TU4velZZNGNSdkJxWHp2TjhNOFJ6eW9OcFQzdVJj?=
 =?utf-8?B?cWlFYjYzRzU2aEdWaGswV3ZjYk1HT2dJb1krSVc3SjRWK2krQjc3alRyNnQw?=
 =?utf-8?B?SlZnWDhkc0FKZHEwWGtpYm15TGhIMDZscXZBY2NTVnVRMGNVTEppMmRjL0tP?=
 =?utf-8?B?dVhma1Jodlk1eWRJL0tKc3hjd2N2T3NoajZzVjZVN3dmZTUwRElEZ1BtaVF4?=
 =?utf-8?B?eHhkZlJubUxLbEFHMVF2ZkpCQzJvK0FUREl6cWhjVFVtd0hZN2RSajlRKzlz?=
 =?utf-8?B?ZDZ4eTl1bGtXN3kxYkNrSWhBeVVac0RYaHdGSU55R1NodkY1NTIwT2NJMHlB?=
 =?utf-8?B?WWVwbE9jVFJpa0NlVGhQQXJ4VCt4L2Rvc0NSaThtbW8zR0h0My9qejh5QVVD?=
 =?utf-8?B?cVZXd2hnSXlNQVpiZlloZWRGWjE3ZUNXM1NUNXROMVEyTk56TVdFNExKTmd6?=
 =?utf-8?B?QitQMjEwWTgrTFZwcmpmb0xRcndiZm5OT2hsZDVLc2RuU3BSMnQ0MXIzeHhy?=
 =?utf-8?B?NE02SnRJMXEveGNDOWtWWHk1Z3VpYTdZcHl6eHVZUDUvV1kvWGZLKzlLaFJL?=
 =?utf-8?B?SzRyWGhxdmFlOFRLd0diWGJRYW9JVHViZGp4QVBVeXlDd3p4OWhnb1ZXdkdl?=
 =?utf-8?B?NkdWMWRJTXFaZDFxSWJENjhuaWpQdTc5a0lQRWlwOGV0SVNtYmZDQnZkYkFY?=
 =?utf-8?B?Y3F6OVhxYk1RUjdGdHpLUmczdkhSSkhxb2NUQnordlJQeWsvUzBPaFNLYllF?=
 =?utf-8?B?UmhJSnZBWUo1a1ZPL2tvTjVHR3lqekkvY29QbFA2eUlhWUlGKzY0ZFBzZkd4?=
 =?utf-8?B?ZlcwK29Cb29jc1N2NEtGUS9Xb2tHN2REVWNiTExnV2hrR1JFWGU2K1NQZGxT?=
 =?utf-8?B?TWQvLzNiM21SRkg5aG1wQXpjQzBoS1lQVjFSdkRic1dyZ1h5clR0U3J5Z3A4?=
 =?utf-8?B?bU1mcnU1WEx3VFYrM2ZYOWpHKytpTklGQjhHMjZrcURBcEhRMVZlYmpuVmdl?=
 =?utf-8?B?a3BjeDhHNytkeTR2b0xMNUN3WDNFNXlsN3BMUmNaYXFaVk1neStpd1hEQUlL?=
 =?utf-8?B?SUpXa1Q0ZUVZNXR2RmE0MlNMU2tVM2laNEZTQU95WkhWOE1rN1QyeVZOdGFr?=
 =?utf-8?B?VFBNaG1UM1hNejZFVkNPbFNIWTdxMzNxQlQzb1JQN3dQUldXSENIYzNhS3ZU?=
 =?utf-8?B?U1VQU3dZTXhKUlBNVGt0WXR2L1JNOXVHNHFJVXNuejkwR0t2Mm9ZVEVGWkJ5?=
 =?utf-8?B?Y0hUanZLcG1KVEc4Z1NTRWFHbGx1MnBWRWQ0SUVFV3ZzUHh1VVNTZmczZ21S?=
 =?utf-8?B?djQvUGNDb2hIcXJZdGdVV24yQzhOMGVjWURLNDJweTJVZEtMRnZZM0xwUEl6?=
 =?utf-8?B?eXRyVFVieitmdkEzbDFYS3hPQ09YT0YyTGVhbW1qakNENkxSTU5UckZhQ1k0?=
 =?utf-8?B?UkExU2FBYmxwV2R2cU0vbHU5MUgvRU14OU1EamdBVXV4VDd6aG1XN1ZqZlpo?=
 =?utf-8?B?anFkMEZlSXl6WkFKSjUwazFFa1lPcjd2cU5ISTMyYm05R0w5K001c2JSWlhK?=
 =?utf-8?B?VWtWMlN0dW0rZmpSaXEyMVpmZXQzalk5NEdLdHR2dnZha2hLQTBGK3UzNjRZ?=
 =?utf-8?B?R3QrL3BiN05lc3o2RTZDSEhGQVdkL0xOSFFJNnZOdW9tZXlHZXBma0w2NVR4?=
 =?utf-8?B?RHVaQS82d2plWFp2RzF5elhXVXVjWDE2TGNmT0IxTEgrVFNWMmlRQVRQQ3Vp?=
 =?utf-8?B?UnpYVnRpN011Sy9YdWJjNWk2L20yM2NqaWQ5T090WjZ6L0NTL3ZuYTM1V01r?=
 =?utf-8?B?RFZSb3FwQ04veHhhNnZDV0hEbytETytBcFR1bXJxS2lKZ2RzWTFMZFVSZnUz?=
 =?utf-8?B?YlQ2TUx4QXdiL3MwZWdwRXNtNkZnVEhxWk1vUVNtUXp4T01sV2JyKzV2ekUv?=
 =?utf-8?B?WlNjV2h2cXN1TFBYOUJocGlkMTJzV0w2ckwySXE1ZHkyeFYybHpPWmhFVktj?=
 =?utf-8?B?dDZiMGR1NHNOSUsrTURXblRHREJaNU93cmEvNm9FT0doZXpHSlhmcUV6d1Ft?=
 =?utf-8?B?UERsd3d4SUFrSERlMjVjZGpoZUZkMGVvUWtYNWtjeXZUZk1YTnVaS3RUOHRI?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdc57c7-d7a8-4a6e-d4e6-08dd2fbc1acb
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 08:11:50.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe9VnorcWSVH3Hi/o2pJ+2pBVLsWAT0Mr1P5VgPwyCWzWxvZSG0TwxItgONrvDmoFI6Kk2RT6QRoAO+C8WEtAptYcS+Tz6dClDjBUNoiiNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7796
X-OriginatorOrg: intel.com

On 1/7/25 20:01, Tony Nguyen wrote:
> From: En-Wei Wu <en-wei.wu@canonical.com>
> 
> When booting with a dock connected, the igc driver may get stuck for ~40
> seconds if PCIe link is lost during initialization.
> 
> This happens because the driver access device after EECD register reads
> return all F's, indicating failed reads. Consequently, hw->hw_addr is set
> to NULL, which impacts subsequent rd32() reads. This leads to the driver
> hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
> prevents retrieving the expected value.
> 
> To address this, a validation check and a corresponding return value
> catch is added for the EECD register read result. If all F's are
> returned, indicating PCIe link loss, the driver will return -ENXIO
> immediately. This avoids the 40-second hang and significantly improves
> boot time when using a dock with an igc NIC.
> 
> Log before the patch:
> [    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
> [    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
> [   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
> [   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
> [   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity
> 
> Log after the patch:
> [    1.031000] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    1.032097] igc 0000:70:00.0: PTM enabled, 4ns granularity
> [    1.642291] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
> [    5.480490] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    5.480516] igc 0000:70:00.0: PTM enabled, 4ns granularity
> 
> Fixes: ab4056126813 ("igc: Add NVM support")
> Cc: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/ethernet/intel/igc/igc_base.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index 9fae8bdec2a7..1613b562d17c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
>   	u32 eecd = rd32(IGC_EECD);
>   	u16 size;
>   
> +	/* failed to read reg and got all F's */
> +	if (!(~eecd))
> +		return -ENXIO;
> +
>   	size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
>   
>   	/* Added to a constant, "size" becomes the left-shift value
> @@ -221,6 +225,8 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
>   
>   	/* NVM initialization */
>   	ret_val = igc_init_nvm_params_base(hw);
> +	if (ret_val)
> +		goto out;
>   	switch (hw->mac.type) {
>   	case igc_i225:
>   		ret_val = igc_init_nvm_params_i225(hw);


