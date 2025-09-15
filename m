Return-Path: <netdev+bounces-223060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A8B57C5A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B22E162AC0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995330BBB6;
	Mon, 15 Sep 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGHRKAUR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80E302153;
	Mon, 15 Sep 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941612; cv=fail; b=FBeWWJ59CsCeSqSHgbNhZ4tH9eMWZNpynzjqqfzV8LSrSd54iSCcxwA99F51KdnYUIWeV/2Bc7KwNp8sZSpTEN3MPfEKha/a3iAivdbu371c+Er23hVNHbi14ICfpKZM+vT7oTJMUvpS29Cn/Fws6Ol612ZbN4k8ICwBiOIdAfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941612; c=relaxed/simple;
	bh=wBktIqYB7Xc1zCSuLlVlIlSP9AzKvmZGuj4BzBEhZHM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q3P4ND3qYkiIr4zKqhpsX3noya6KowyOgF1G6f7tUr23IhU3+9QwB6fmr+2f0ho2e0bvQTnKaiPdvGjcP+MdQsUns+xqezJKEeUKhSbx4m2lr/yAp5E4yEtndM9gOcoEqXIBhBgBA//yx/k6xIU3l4Ds5oCbpQiVLRabjq8HCl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGHRKAUR; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757941610; x=1789477610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wBktIqYB7Xc1zCSuLlVlIlSP9AzKvmZGuj4BzBEhZHM=;
  b=YGHRKAURTNDcxE9fuKz2Z4QWE959JyoY/HbtLIiQNdWuf0D/Dd3y9S3/
   G9gxX3F6mVLMa1H3UyAVxQuXnTRpVKrHeRrl++/Dmv0f7gdYU7pEVLQpT
   bM7sEVgpP1hWLntodKotinJhaY4NUJs0NRrQXu7qrvOubbvPYG+d5ArCP
   U5hmb9mfOZVPs9PuZ/X0RCmBbpbF/mqNUw1CxxcUPI/OGbPCCj2M2pPVg
   YKUVNUmjuT1OkUa7+xBuG9punWNVc23kkMPb0MqWlwKl9YKuFDc1JzC5q
   PTkNe0LI56MYv3H8TXb5xDxbSCxAxZmACzirX9J2vCM+KAyF6JXHr+Ke2
   w==;
X-CSE-ConnectionGUID: CZnK7jZaRrmAWBHVGVsBbw==
X-CSE-MsgGUID: HRm2B/ubToGWkC3+9ye+YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60112350"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60112350"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 06:06:49 -0700
X-CSE-ConnectionGUID: BQG/4LraQgS+iFhr8jJUyg==
X-CSE-MsgGUID: 6Kq8LCetTA63XRAwocROzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="179790573"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 06:06:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 06:06:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 06:06:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 06:06:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmo1lQl+Wa009retor+GBdoeS2dmI8Kx12UMoNZB+B3IE1lX+B6TGMyZ8KTly5NfcB6ydD2XYxuK86s9lsNcKUGTDNp8BhGIck7IiaaREumDqija5Uzdwq34spRaHzYOMbpR5bsBanFziz7GwdIbPn4YW4Kgx+mKjTuIqVpTFcKKyMmr1c56GdT4/tqk6s69wilZxolus8KyMn/+IKk6YCXnP2w1v5GWv7jTG0OqjtJSXCzoVzBZKb2RSQXvznHjYEN8yvD5J7Ksts/ZBQ0pjWLaSo4P5Ze59AvqW6xgkT+msn5P+AYtJVedafVhVAiIRDf0B3iybMmN1882dY3rTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgmoBMw/N7Qlnbpd6XIPKfk0YKCmcj2aTBm35cAppTA=;
 b=UdXSkvWgukXunfxz16k0uhDQhYxf6m6Ex3hnNKiY6SRqPl+2RARPhnho2Y9daj0Eqp9FhaCuogoquVnthUuukgtFQqecyTbfXKe7SPAOMpZ2vM/dKDTh+8qEpRVzMPvGPf3nZKTU3dT8GvKsGpqEHMqohc3PxqTc3UJAgT2MRtxaudERpmRWej8PdnAcnLjuv7K7hI0qdMq302xycDzC4uFYMbZwLySykAjUmU9Yx7tYlN7CoowvWEbw0Q2VsfLAijY9K0Bu6W6elbu9eCbBueDf+2qiu/k1DrGfMUU6zzWT05PP6C+UdPipwT0TnLFUHooNlae1C01nLP6isrz9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16)
 by DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 13:06:46 +0000
Received: from IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10]) by IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 13:06:46 +0000
Message-ID: <638e837c-ef78-4583-bbf2-3c088fc9586a@intel.com>
Date: Mon, 15 Sep 2025 15:06:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
To: Joseph Steel <recv.jo@gmail.com>, Sebastian Basierski
	<sebastian.basierski@intel.com>
CC: Jacob Keller <jacob.e.keller@intel.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
 <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
 <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
 <63959a5f-a0fd-4e75-8318-4755fcf6e9a7@intel.com>
 <ofapzlvardeiwwybyqpwxhhd3mc64wlkan2h6a2iaj425xk5tf@vpccbegsrcft>
Content-Language: en-US
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
In-Reply-To: <ofapzlvardeiwwybyqpwxhhd3mc64wlkan2h6a2iaj425xk5tf@vpccbegsrcft>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To IA1PR11MB6443.namprd11.prod.outlook.com
 (2603:10b6:208:3a8::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6443:EE_|DS0PR11MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ae1776-eed7-4b32-b142-08ddf458b99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eERiZ3VyMkh4b2gxbFlkai84dDZpV2psYmpNMVk4Q3Vtd2hQMDBDUGFIajR5?=
 =?utf-8?B?dk9WS2Z0VFE0RXRuL1NUQXRHMVZ0cnU1VGsySnpDTEdzY2NKUmU4dU1ubm1z?=
 =?utf-8?B?YWNNMHJqL1djSzlFU09SYkg3eFU2YkozMnRMbEVTUWZvNy95bFBNUkpwRVND?=
 =?utf-8?B?K2UxNFpYK2Njc2pHQmR5OFF1MlpKcnkxZUdYeFJGT2pxdjB0ZkQ3bmhaNVVy?=
 =?utf-8?B?My9STnFlK0N4M0N2bDJYeVBkVURyOUw1Y1oxZURNTXgvS0lJSWJkSTZKNWYr?=
 =?utf-8?B?SitYemJDUnphdzJGeHp3MzJXalhCS0VIWGhUQkVyUDU3RXVlRVpUUmcxS1Vt?=
 =?utf-8?B?ZE4veGt0QzNqNlRPWmxqczUzYXU5Q2VXNHJSUTYxQUE2eXdrNWdlUk9VNmJ3?=
 =?utf-8?B?N3VJbllvaTVhZ1pLT29pVFR3MEx2dGx0NEVVWWRjMmJEM21BcXhWc2I0Vy9k?=
 =?utf-8?B?TDUrNC9OKzRtTlltbDNBa1hSZWJHVDRDUTUrU0ladkh1TEJvOHM4Yk9Bd2ZD?=
 =?utf-8?B?dnY0TncrQysySDZYMm1BQVh3NGFqdVpJQUsvZGVjVGJiUFpGaHVubkNobUM1?=
 =?utf-8?B?RDh6MVRJdng0QjdkSHBvUGI0ZStvMjNQQ0JSeEJSS0UzVzF3cXgrcVVGMFlx?=
 =?utf-8?B?Ym8rb1VKaVQrcWRVM21FZitCdFhjaCtVbWJxMHVGOHdTUVp0akIxVVM3N0dU?=
 =?utf-8?B?RjVFMU93VmVKc1h2S2M0TFBhc04rYnFZZytqVEtLalFYL3hxNUNJM2JjZ0FI?=
 =?utf-8?B?bjJnY2E2TWNzT21MTit3TzRtTGdkOU40amRMMkxjT1VoVlB4R3p4TW1aQ0RL?=
 =?utf-8?B?amVVWGlqUCtlU3pVeWJ3UGsrcTY3Nld3aGUvNGZQVWMrall3MHBRZmRwc0NU?=
 =?utf-8?B?QkJCYS93YVJCS3FWS3BFbE1ieTZOWHVxZzM5S2E0SFBSWFczV3pvclEvYzMr?=
 =?utf-8?B?NXkyZkZ6bjdxQjFsek1BVWJMbU05K3h5Vk80K09NSEc3S3NrZWVwaEY0ZUd5?=
 =?utf-8?B?MGprQ2tYVHRDY2RQdGc5aVFIMHJwVmdhTFo5ZVFjWjU5M0NvclhWRldXVEdI?=
 =?utf-8?B?L0lqellka0RBVVVubXphSWJWQ1VYOUhITWhrV0hUWnk5WnRQUXp0ZHdvYUJi?=
 =?utf-8?B?K2dXUWNoVXQxQ1orRFdaY0ZFSHpKNzFYVTdkUUJGR0IwT3VGbGtmZ1lpeENq?=
 =?utf-8?B?OW5xNzR6WHZBZ3kzTUhWbUFneGFqaWpKWGd3SGdNa2FMYnp2dFdrZ0NmTm5L?=
 =?utf-8?B?Q2M1WEdqc3ZYc3piSE8vQ055NWpnOHJmdCtUYm9CV1VQeTlpNnlxNHFtcGtz?=
 =?utf-8?B?K3VuMyt0RUl1akwvWndiUis2WVp0OVVoeDhWQUNaQ0pZYm02RFRwYmFEV0NX?=
 =?utf-8?B?VEdRMk1hallrNWVBbDJOeXV6U0tzcmR0dmRzam1jY2NWNnhQUi9HZ2JqbU1L?=
 =?utf-8?B?aDlyZ3hyS1hHS2llc25Pejl5ZDdEUjZLMkJtYTBwODdLMElPcFFRWVJIanMy?=
 =?utf-8?B?Z0RTbEdUYS8wVm9Mem1lYjF2MmFUdFhaMXMyL3I4RmYyVHBtRXBiZWMramtr?=
 =?utf-8?B?TGJ3bll6TUQ1QW9YR21jdGE1aWJXa1R4QW40bldRVXBkL2RiamN5TkFYMjBh?=
 =?utf-8?B?TndjcFFyMERXM3lreEY4d0ExbFkyOCtWdDJCN0Z0Q1h5RE1KSGxUTEJoeEdC?=
 =?utf-8?B?N1lEamdydU81Qm81bkxBbENCYllrdE4wd3Iram5LcnpPd0E3WFVTQjFlMVIx?=
 =?utf-8?B?d0l6eGMrL0ZFQTJkUmt3VzVRRzg3a0VMazJ0a1NpQys5NFA1N3BoTzc5YWh1?=
 =?utf-8?Q?FWK4cAg8bz5GNY9J3pAgED5Oz3qLkwSyVzX8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6443.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(42112799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azV6bTJTMzlQM2tkWHJ5TGZJMHlmbmZiam5VTEU2bVlTaU9SWlJtczh3Y1Yw?=
 =?utf-8?B?Ym5UUktYSkRPOFE1dVVlTCtZM2tQR203cmR1bUN0TkljU3pKVElldkM0RVZI?=
 =?utf-8?B?M3MxWURYY0UybFk4YnowUFBpTWVIUVlJM1AvbDBKZStueVhFWjl2bGhkekt0?=
 =?utf-8?B?VjlleUtJYUx5LzNJeEgzbitLcTM1UTRjWmhKODBPN2UvanF1TWRNY2ZTdUtZ?=
 =?utf-8?B?VFFIazY0ajlhUjRpekY2NVI0VDVETXExNWFTVjAxSFVVN21ZUWttWTI5TjRQ?=
 =?utf-8?B?QjhoZXo0TjZFRUVpaDJvSGtDRWNya2NQTmh3NENybVVieFlOMnJ0R3NGeWx2?=
 =?utf-8?B?VGo5dGw3ditMNE9MdzUwMS9yMzBtbWxQeXBBQ1UvVkhZaGE3aVpETVRDbDRo?=
 =?utf-8?B?SlgyaUM4RGtubHE5NXlibklYUGpSQ28vZit3OWZENFk4ZDd3Yk1kSU9pTUgz?=
 =?utf-8?B?M1RaNjNkRE80QStRajJyOG1LZ2Q2ZE9mUjB4S0dxL0FlRzk0WEtDZjJRRHhr?=
 =?utf-8?B?cXRmNHF5Q3kyL09SQ0VLc1JoRDJMbis4empPZS9vTmZDYlJJQStpcExTRVZp?=
 =?utf-8?B?VWszclNUTllnN1UwS1M3d1pkYVdETVgvbkQ0dVM5VUFIbmxYeEF3dmtpcnVZ?=
 =?utf-8?B?NXhzY0VrNTFqaGJocWNLRVdFa0JqcUVJK0Qybk9JZEVheHl6K2pkcThCcDRj?=
 =?utf-8?B?ZDFVSnNqR1VVMk1hcm9xZEY3aGVVRGZIb1FyRWV0alRIM1c4ZHdKdCtsT3c5?=
 =?utf-8?B?USt6MXh1UlJlc3ZldjUyemlHZ0pjRFBSMUViMWhEWkFhYlI2ZWVlUktGYnZh?=
 =?utf-8?B?N1RZVTZLQkV5UkV6RTBkQ014YXNHNGY5cHJsbW9qTFp4Skx3Rzd6VWtOa1JP?=
 =?utf-8?B?M1BCRjFPRjdlbTB5aE9SbXRxMWdjQ2dMSW5FZnVYOTFZcWNaTGp1VG1MWXB3?=
 =?utf-8?B?UWt5M3BkMmN3b0kyZ3JqRVNXQWl2TTlaUy9NbTZhMTZPK3ZTVzI2dVFSMkRJ?=
 =?utf-8?B?KzB3cFVHTEgxaTY3SEZlVWNmUDlXRk9wb29uOGJ3ZjVoRkZPV0lwSTFBcTZu?=
 =?utf-8?B?RkNHeE14L3ZRWnNmSmllR2MraGY4VEg5bE5ZNEdaOXBtK2orV0hUYzhhNEc1?=
 =?utf-8?B?ZkpERnZMRCtwSEJQWndUOFJ5NFJMYisvNmtlQ0xiOHc4UTJYbDRRMkhpSkF2?=
 =?utf-8?B?WGlVUU5rT2Q1clFsQUQ2MVRlakFST21RaFN2N21zLzBWY2twQ3RSSXFIdkRp?=
 =?utf-8?B?alBpT3U1WVNhaGl1NVk0ajF6SGpZZmc2M0ZvdVZVaDd5eUVBWnlGanpnZElJ?=
 =?utf-8?B?SmtRQ1kzSUMwQXJpejQwSkVTWGsrWFBhdFYxQmJIS0k3YnlzanJzNE44MGdy?=
 =?utf-8?B?My9tdklDUTJ1KzZEZk1kYmhvNktET0ViL0diK3ZuRE9ZQmFPNTFaT0Z2TEZs?=
 =?utf-8?B?Zyt2Nm94aGFHS3lNUzVCS2prcGxHaFlDc01FdDFWc1dBeDh2aEtNdGMxTkhM?=
 =?utf-8?B?VHg2UGVteDEvYVBmaVRCM1J4eUplNnNUaUszMStCczBBR1lub3hKZ0VuZDA3?=
 =?utf-8?B?blBWb25YNzdHMUNMOWtyZ2pJYXU1bjYwUmlVSFNHUERkV1hLeFN0R3c3OFlT?=
 =?utf-8?B?WWZOM3cwQWl6QUhaamp1Z0ZjRis5U2N1YVRtaDFqdFFCcjhBaXkxSENRVjA0?=
 =?utf-8?B?b0llTDFURUoxU2pCeE1DY2RwNnJWMW5sM1UwMWdqZU1HckhXQkdUMS9kWlB5?=
 =?utf-8?B?OXZaUHJocnRBd255MDc4VzZlMVJhSFhIQmVSdWV2N0hBNUNHK0NsalpnQ01a?=
 =?utf-8?B?MWJmWS9ncWdJQ2h0VlpkSmtZVHZ4S0hsQUpUSFd5bW9FajJWbUY0L2pUL05K?=
 =?utf-8?B?dmlWSERqenZOOWlpQUhhbFNoSUZtbjZrcXQvbG1qODJZTWJRb1Jpc2pRbVgw?=
 =?utf-8?B?NEFvY2dYMGkza0N3d2VqZ21PcnY4RTJ0Mm5IOUI3YXYvRSsrU2VUT3BsOXVH?=
 =?utf-8?B?NDJMZ0RaTmpWSlNzUUVHWEtsdnVMOEk3VHdQaWV2dXZDaHNTMk1OT3hrOURX?=
 =?utf-8?B?WWZ5Q2p2STRDM0Fha3U4V1BzV2lVM3Y0QVhsWGt3QmtWVDlXeUNnZ1ZUMENy?=
 =?utf-8?B?RUVYQVYrc1pqM1A2WnRJbHFsZGxmaEtjY2l4UnhoVENRbDNtUndhdDNYTFhH?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ae1776-eed7-4b32-b142-08ddf458b99f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6443.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:06:46.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2vff/LTULxsaarVcVZuvtbN37ril9wQacYMKdE0UdSFwICjKRsu/T9RGW3DjlzszRpRLrfZUKo4+Ag2gD/WhDeFjJoUtYz6aTvRrQ0zfTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8718
X-OriginatorOrg: intel.com

On 14-Sep-25 14:53, Joseph Steel wrote:

> On Tue, Sep 09, 2025 at 08:26:29PM +0200, Sebastian Basierski wrote:
>> On 8/30/2025 4:46 AM, Joseph Steel wrote:
>>> On Fri, Aug 29, 2025 at 02:23:24PM -0700, Jacob Keller wrote:
>>>> On 8/28/2025 7:45 AM, Konrad Leszczynski wrote:
>>>>> This series adds four new patches which introduce features such as ARP
>>>>> Offload support, VLAN protocol detection and TC flower filter support.
>>>>>
>>>>> Patchset has been created as a result of discussion at [1].
>>>>>
>>>>> [1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/
>>>>>
>>>>>
>>>>> v1 -> v2:
>>>>> - add missing SoB lines
>>>>> - place ifa_list under RCU protection
>>>>>
>>>>> Karol Jurczenia (3):
>>>>>     net: stmmac: enable ARP Offload on mac_link_up()
>>>>>     net: stmmac: set TE/RE bits for ARP Offload when interface down
>>>>>     net: stmmac: add TC flower filter support for IP EtherType
>>>>>
>>>>> Piotr Warpechowski (1):
>>>>>     net: stmmac: enhance VLAN protocol detection for GRO
>>>>>
>>>>>    drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>>>>>    .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35
>>>>> ++++++++++++++++---
>>>>>    .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++++++-
>>>>>    include/linux/stmmac.h                        |  1 +
>>>>>    4 files changed, 50 insertions(+), 6 deletions(-)
>>>>>
>>>> The series looks good to me.
>>>>
>>>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>> Not a single comment? Really? Three Rb and three Sb tags from Intel
>>> staff and nobody found even a tiny problem? Sigh...
>> Hi Joseph,
>> Thank you for your time and valuable review
>>> Let's start with an easiest one. What about introducing an unused
>>> platform flag for ARP-offload?
>> Right, this patch should not be here. Will be removed in next revision.
>>> Next is more serious one. What about considering a case that
>>> IP-address can be changed or removed while MAC link is being up?
>>>
>>> Why does Intel want to have ARP requests being silently handled even
>>> when a link is completely set down by the host, when PHY-link is
>>> stopped and PHY is disconnected, after net_device::ndo_stop() is
>>> called?
>> While trying to enable ARP offload,
>> we found out that when interface was set down and up,
>> MAC_ARP_Address and ARP offload enable bit were reset to default values,
>> the address was set to 0xFFFFFFFF and ARP offload was disabled.
>> There was two possible solutions out of this:
>> a) caching address and ARP offload bit state
>> b) enabling ARP while interface is down.
>> We choose to go with second solution.
>> But given that fact this code depends on unused STMMAC_ARP_OFFLOAD_EN flag,
>> i guess whether it is fine or not, should not be placed in patchset.
> The reasoning doesn't explain the outcome you provided. Even if the
> controller is reset on the device switching on/off/on cycles the
> driver will re-initialize it anyway. The same could have happened with
> the ARP-engine too should the patch 1 be in in-place. But besides of
> that you submitted patch 2, which _enables_ the network interface to
> respond on the ARP-requests with some initial IP-address even if the
> interface is set down by the user. This makes the host being visible
> to the surrounding network devices behind the user back if the PHY,
> for instance, is unmanaged or reported as fixed. Is that what Intel
> wanted?
>
>>> Finally did anyone test out the functionality of the patches 1 and
>>> 2? What does arping show for instance for just three ARP requests?
>>> Nothing strange?
>> Yes, we have a validation team that verified proposed solution.
> So did they notice anything strange? Is the validation team qualified
> enough to correctly evaluate the change?
>
> Joseph

Hi Joseph,

Thanks for your input. We'll remove both ARP offload-related patches (1 
and 2) from this patchset until an actual platform that uses them will 
be introduced later on. When that time comes we'll also check your 
comments regarding the "host being visible to the surrounding network 
devices behind the user" and adjust the patches accordingly.


