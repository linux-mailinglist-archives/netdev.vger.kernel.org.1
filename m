Return-Path: <netdev+bounces-271786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EKrAc96xGlXzgQAu9opvQ
	(envelope-from <netdev+bounces-271786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 01:16:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F41B32D916
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 01:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B70123035D4E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 00:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285351DFE12;
	Thu, 26 Mar 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpLSyfs5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F78B67A
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484132; cv=fail; b=Y5BX9JCJvhxe0KTvzHamBA/LXeOFnJMwS+0fADPMXJJ+/inrO932zhG2JdNeVU375q/iFxCX3ijLaEU5KOMl9o9RUMQ8wThBI91WE2+CJB/Rv+UUMsP0+up52pugLusrUvbk7v9zIeh2dtGI3HxwDBD4Ct3qlAtbdEyEqLTD4EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484132; c=relaxed/simple;
	bh=qDpBtcfSADI79uVm5yevWFDmIyx/kDRK/7u93qjnxh0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8MI7xZ746A+/TqTV2FuMVXBEdqSBV7nf1aQRQK0wv7TivQs9SKsS3P9ENZI++KfGzGuizNiumcdDNsOOT/J8gwFGQA6ZXv3SY3yuZgE2cJ1lh6bzm0SPXDKR1rsc8Wh0ekqYrP2r0qwrP8euFwMU7W30830lAFfJf1dB0bgGJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpLSyfs5; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774484131; x=1806020131;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qDpBtcfSADI79uVm5yevWFDmIyx/kDRK/7u93qjnxh0=;
  b=NpLSyfs57LsrCuyQ0Gl3hBx4tS+o9bKRV3uxIXQhEyWzTy0CB8nHmhRf
   3SqMG5/QuJzgeyG2ajriT38AhUWFAoX/04LAxuHq+mROOYOAhseKI+UOm
   Kt2VvkS3Rs/GQE8NdCxPT4fWwtj1jUSjemg9YMUyxQndb6pZqZhdw9+ZG
   PdcB7n8OGUlGk+0CCFy4EiB03QiKppNflJtPbRMTnHMAPC+GSxmFuWx06
   v39XXkSG94ztqR1vPBzoNGajLIwEkbOGVwUAnVRIQ2VKJ3Dsk2W8xcjgc
   i70shO0iQMcK1uk3S0WcKEgSuYx251ZqHlEwMfEHgm43eSWB0we3gtHGG
   Q==;
X-CSE-ConnectionGUID: HwQ5hy8JT1CKEeaH7UPxiw==
X-CSE-MsgGUID: idFKDgorSyiOxA1Ixp2twQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75496470"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75496470"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 17:15:30 -0700
X-CSE-ConnectionGUID: 1axPV7aPR4qi4yYX8g1ovQ==
X-CSE-MsgGUID: BVMurtX7QE+AK7HQ9ckzWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="218243820"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 17:15:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 17:15:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 17:15:28 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 17:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkrxKoLRGLuydCY74slTqrr85IjybMn2Vj4IzIXtauFUYP1Q60+lCwdbgPHImv3mAcWc3NyJb13a0dq6Lh275xCq1iHaP5MwS2k/f7YO+axU7qFFGXnung7Cwds+IeiQdhvwNpmpl3N/2KF8CYqFv1ZuF2oecOIzWLdctnjgtJPdjqXRfgrqKu6Gwy8A7YOK35x6GCovMc9E+Z6ZdUtEboMKTUsVTmJ/bWF7a7Mv4sVP7KfrYGq9mN+EL6mkYccrF2rEgo+W2Q66o+V+JkDDhggcWy0zjGEH4OVmKR20LApfEMyfyFGoiPF7sK8Zz9HlAKNsBq8SVDQeeW234TzIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le1/0ng0vwIAn62+Q7kyvTbPyDAtU7SZJSLNr/+ufik=;
 b=oHNh187eXF0CmZ29SGw+ZJQP26PA1SFvCSkNVoXRQFd18cO8tGkkrh+CbEZ4feqH7XVxjGorlN8BUJxK8RLCBTEjczqc0JIs8CSYQWiMjm8SUjNm9xz0KMd3FQwpnaC4kD3OrccofTMskA9QkPHY4hqv4JBxVHeIKdsxI5MY+ZVhlGnUs2v8kmylcztrZs/jvRiy/eyAhmFLt57+6N/9rA7ZPqt2cLIuvWZS4Sk4WlKcme/6u47pEoKhCabESknIapKblLlgGfubH6Jz2gTgCDhIjht3p7YKL1kbLT5FGdNo6gXK5Vaner1HFNMkuQ11d0BR9SJLAPbkmOk3CYJs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 DS7PR11MB7932.namprd11.prod.outlook.com (2603:10b6:8:e5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Thu, 26 Mar 2026 00:15:26 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 00:15:26 +0000
Message-ID: <dce634db-bd85-4c39-ae01-4272c432f017@intel.com>
Date: Wed, 25 Mar 2026 17:15:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, Simon Horman
	<horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
 <20260310182458.GQ461701@kernel.org>
 <PH0PR11MB49044CA89B5D8780D477561D9447A@PH0PR11MB4904.namprd11.prod.outlook.com>
 <20260313133451.GZ461701@kernel.org>
 <PH0PR11MB490443FB49C3F762297A992E9445A@PH0PR11MB4904.namprd11.prod.outlook.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <PH0PR11MB490443FB49C3F762297A992E9445A@PH0PR11MB4904.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|DS7PR11MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 805e9247-ba22-4225-1c79-08de8accc7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: sVTVHPfveuWQg64pJ4s4+Lfqnb5yPxSVKQjvAFPVnU6P/uh6VlzICxd1ozrlbWnGc2sAVfNN1umaFIaVtdkGjfaVIJvyvvAK/pgbEAJV/Oul2j7qI4Ewx8WwcqUJVZMpKRLtjLJIUtrjbtVxK+UMSw35maCJCqAFgprXtBfrglk9pP7amEudslxi0LuVyAwptKpnmyYkAZC4eoYiZ7apTQS1kSswNkp90fXNFGOiTiRDI0C20/8SNPHywR61wYodVY0fgyIrD2FKxF1uLpW/ZVZ4p1Gvc9IDnIUclYums3yhwWHCkkdT6AhiUDpFoUSI54e6HUWzmXK77PXRtj3nYlhdOVe1gJNnu5ykJNlbgx/sApEHRaS/TMuUH0a5rzf/Tvxz9IW1abBluHERwuJJNW/KmLyh7YbcYIn/vkQXIzuSTEZ1fTMe/3qRapCyMz59er0vfNxfvsXoCNjdCVtYaTp19K8NN2BGGYPjrTbERJP6CCgWbTP0veDt9PEcIqbfIwFlH47ybPHexk/VM1zbo5VtcQWNrzMk49tQXE4+2AjiRa1BYzD8bH9MJb4/wPajwS0XXJkFFlotIQY59566HFKCKz1TUvNwRVN//lE0Lx0ZFWq/H1EXrLb8fV73sNYbYcz7IjzkNcuazIxK0Gtap9l3RSA0LJgeYBsa30I0KkrDOMAfeoYE3+yl1qXrGXcT0NEcA1ZU0bANs8qJGSqu935QhzFCr2J0Mtgsv4sw1BXRUrQqtcfUxL5yQ4oNf1HM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDNjcGJpTnZjV3VsVEhXNlRjdlhmL1QzUVlTUkVuamVNMHA5VWVtdGIzck9G?=
 =?utf-8?B?SFZRZC9iYkNrZHFPOUV0R1AyVERGK3JCOHBGeEgxUUFqeE9mckJFTEg3R25l?=
 =?utf-8?B?dVRmOXpxbWMyQXVRdGs5aFd3V3hyaUFoNkVLK3g5K2VxMGxsNFhrcDk4bXlD?=
 =?utf-8?B?RzU5RWQ2aDlnekZZVjEwTXRrMERXczlaU25Bb2p5R1FYNU5lWkRPeEgzS2pT?=
 =?utf-8?B?SmFueS8vdTY3WHl1dUJqYWdiWHBpbWJuR1FaWG9wNnN1bnNLWlR3WjFDYXAz?=
 =?utf-8?B?TmY3QjBsMVRDWWx2alYxL0dnSFpKb2JSYmxEeVVmeHlKd2pxVFVOUDV3Vk82?=
 =?utf-8?B?VXk1Zy9oRktxd2d0a0VTTFliVWdPZi85cURlRitTT0t4dTN4WldCRHZReDNC?=
 =?utf-8?B?Q2lSb2YwODRaamR3NjZpNlk4SUNJR0hRNEwwWGw0dGJ4TlR2UE9JZnBaS1My?=
 =?utf-8?B?eWk1UExjN3pOUTY1cWdKaHNOeHR3Z1pmeWhKUVFBL3JuZXBlWXhNeERHVXpE?=
 =?utf-8?B?Y1l2TzBkaHN0UlBLZlZpTXdnOTZRZVlXZ3JLUTlJK2pPdUpHK2VpVkd6c1dK?=
 =?utf-8?B?UWJHb3QrZkdTTDhVa1FrNEZGb0pwamxKVjFucXlSbUVyaTJ6T0czRUgyN2tO?=
 =?utf-8?B?Z3dLbU5FV0pXMnNzRnpBUjBVbVpraURscXFGdXdzS01jU0c0N3M3Sy9hSnh4?=
 =?utf-8?B?a3hjR1QxMXA0QThSMlNha2VkVmdvM2tuQXBvdUlCOEFjQk85OUFoanhkakZZ?=
 =?utf-8?B?VnpuZjNRS1V2SlFtQTd3MjlCRHlZa2o1cEJDRFloVmZaZitFQWlsSm1kYmc5?=
 =?utf-8?B?U2k3blBGVndIRlF2Vy9ZTFp4djh0akdJektCSEVLZ0RRakFQK2JnWmc1bHZw?=
 =?utf-8?B?VVFrL2R1WG1xVGZSR01STHZyQlZIMGxFQzNQdUxtMHBHV3BsSjhOYUdqY3po?=
 =?utf-8?B?a1JWU2N5WVBZcytydC9rdGhrK1RGcEpVTkk2dTNCUFdDcmNBNTBYWVpkOHRH?=
 =?utf-8?B?VDd2VXlqL2hSK2N1Qm55MThQMjRIcUpwRUVBWDEzUDF6b0RnK3lUMDNiaFg4?=
 =?utf-8?B?TkxxTTZaMXlCWHRFcERuUzNhZGt0WDV2RXU5bHFMZ0hobk9lSG12U1hZSlgx?=
 =?utf-8?B?NzRqLzV2Vk5HOVFrRUlOMFo5S3lkbEhyUjUwOVZBcG0ybjVDV2s5cmpWRUt5?=
 =?utf-8?B?T0taUU8vdWJ3MGVtSys3WXlvYUJkOEpiVmxQNG9lUldSeHJORnJnYzcyekVI?=
 =?utf-8?B?TXphTXhUVU9IMW1BeTVCOEVmWktQMDJRQTNETG1NQUphdGdrL2lsNlE2QVRh?=
 =?utf-8?B?aUtBWGxZM0o2WVF5TGM0aDNlQThWUDNWUS9qcldmemVnT2FOVU1panV2RGRp?=
 =?utf-8?B?R01iOVBEa25ZbmVIVWd4ak5vdlBtSHVad1RoQ0ZoYXlDWlNxYnNFNXFvUjM4?=
 =?utf-8?B?aklxdFp6OTVTNFVrcHhNQUpKNHFtWm9vUXRLSlhac0tpc3hMMlBhTDFNT0xP?=
 =?utf-8?B?ZFk1bWRvUnlSalZldTNNUGhRb1cvZ3ZjcUE0VTJmc3FBcUp6TzBicEFKOVcv?=
 =?utf-8?B?YnVlbytnQ3JaTUxuSjl6Q1dYa3FBUUpqVWhmQmh6RGdmUjFsSGlZYVVkb2hS?=
 =?utf-8?B?eTZpek5MYUhNeXJYRlhubys0dG81TTBqTDkyM0hSMXBEazVTbFBGNXhZb2VB?=
 =?utf-8?B?NEhjTElNVCt6enRaYytEVDkrQXZGaXpobklLOGZ4azRNZE93WEU3bVpxRmJy?=
 =?utf-8?B?MjltTi9mUU9FcjVxdVJFY1dxY05wK1VPZTdhTTNPNU01aG1QVkF1T3ZLaGpu?=
 =?utf-8?B?dUplQ2pHYXU5aElPN1lxdDAzMGxQTDB0K0FDQ3dLanU1YVIwOEptVXJ3aVUx?=
 =?utf-8?B?MkJMakMyeTQxSmozRmlIRmRuM0lnVlNFMVhncVpCeXp1dUx1UEE3ZlR6SEpI?=
 =?utf-8?B?T1J6akx6N2l6MlJVbUdlSDVWeExydmFuei83eUZJRE5vaUQzSlpnaTY4T3Nv?=
 =?utf-8?B?cWZMbmVwSFBjZ3hxSy9nbEEyMmZkRDhkWlVCZy9QM3NDLzNTWTZud1R5ZXRr?=
 =?utf-8?B?RnpUcVBaSk1RaVZmM3A0ZStOcFpyU2RHcjErTkk2M1hUYkpkRDBUNkU3Witv?=
 =?utf-8?B?T08rVHBaYWhNbTVIU20rVmhvTHlXeWtyZm5XQW4veUxwaUJhSDFjRjRwN1Bs?=
 =?utf-8?B?dGxlamR6RjdNVkwzVWZ6azFUNS9QcWlVb21xRnJma0VHN1hEVE9JRm5MelZo?=
 =?utf-8?B?UnVPelNCa2xoRlNGYjdvZkNzM2dnWU5VL0szOVlBLys5YTQyV0puczdnODNV?=
 =?utf-8?B?MkluMmF3VW9uRkRyOENEUlZ5U3BkeDNGTCs2SXViUlJMMjRONnpzV2ZsQ3BY?=
 =?utf-8?Q?Rp2nRxQwiw3tMwx0=3D?=
X-Exchange-RoutingPolicyChecked: GIKjuDy8Ztlp0Q6ZTIqega5hbBnVmNz3CnL/PLIA965bLegfEF3xnf3JBzniXSRAuKhpvI52eeCALessxoGBxLFT+VSj7BJDXO1EErrZ5p8zE7tslaoMDvO/ja/JSr0wpHE4Vjg0J7eAHeUynDuceBvF0YWcMiR8QfGfBScoL4fD+dMFdqBPM1aH7lwaEMr0NwyW+MRrnjrVlw0K0Z25O1bbPFWeZYIF2gLqpwJl+4FZz9JS++rINNUFWIqITJ8ZZfnFI4wUJqzJncnfPGhOD+aVrOPLOzVHHE0ptdukfbmVrk9SnS+mbBE4B0h39Cx25FxZ3k7iKlicVRwKmjx29Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 805e9247-ba22-4225-1c79-08de8accc7d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 00:15:26.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrGsc0zR1fJe0J3++G5Jyi7dslccF1CW9jUV60ARVhDLLlX2HmXHvSjfE8hP8CmD00GJW8N/5O+L3csXndh4NV+CGBd+3nmM5FVeOrlEK+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7932
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271786-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6F41B32D916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/2026 6:47 AM, Korba, Przemyslaw wrote:
>> -----Original Message-----
>> From: Simon Horman <horms@kernel.org>
>> Sent: Friday, March 13, 2026 2:35 PM
>> To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>
>> Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
>>
>> On Wed, Mar 11, 2026 at 12:42:10PM +0000, Korba, Przemyslaw wrote:
>>>> -----Original Message-----
>>>> From: Simon Horman <horms@kernel.org>
>>>> Sent: Tuesday, March 10, 2026 7:25 PM
>>>> To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
>>>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>>>> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>
>>>> Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
>>>>
>>>> + Jacob
>>>>
>>>> On Mon, Mar 09, 2026 at 03:11:51PM +0100, Przemyslaw Korba wrote:
>>>>> Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
>>>>> .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
>>>>> ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core
>>>>> now requires that the driver set the .supported_perout_flags and
>>>>> .supported_extts_flags fields in PTP clock info. Otherwise, the
>>>>> additional flags will be rejected by the kernel automatically.
>>>>>
>>>>> i40e does not support perout flags, so reject any request with perout
>>>>> flags.
>>>>>
>>>>> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
>>>>> ---
>>>>>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
>>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>>>>> b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>>>>> index 7bcea7d9720f..8d7958692235 100644
>>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>>>>> @@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
>>>>>  	/* TODO: Implement flags handling for EXTTS and PEROUT */
>>>>>  	switch (rq->type) {
>>>>>  	case PTP_CLK_REQ_EXTTS:
>>>>> +		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
>>>>> +					PTP_RISING_EDGE |
>>>>> +					PTP_FALLING_EDGE |
>>>>> +					PTP_STRICT_FLAGS))
>>>>> +			return -EOPNOTSUPP;
>>>>> +
>>>>>  		func = PTP_PF_EXTTS;
>>>>>  		chan = rq->extts.index;
>>>>>  		break;
>>>>>  	case PTP_CLK_REQ_PEROUT:
>>>>> +		if (rq->perout.flags)
>>>>> +			return -EOPNOTSUPP;
>>>>>  		func = PTP_PF_PEROUT;
>>>>>  		chan = rq->perout.index;
>>>>>  		break;
>>>>
>>>> I am a little confused.
>>>>
>>>> My understanding of the cited patches is that they add checking of flags to the code. So code like the above isn't needed in drivers.
>>>
>>> Hi Simon, thank you very much for the review. My understanding is that the driver needs to set the supported flags field, otherwise requests
>> won't go through kernel. The test I've been doing confirm my theory. Here's also example patch, that adds supported flags to drivers:
>> https://lore.kernel.org/intel-wired-lan/20250414-jk-supported-perout-flags-v2-1-f6b17d15475c@intel.com/
>>
>> Sorry for the slow response.
>>
>> My understanding is that the hunk above is not required.
>> But the hunk below is.
>>
> 
> Well, you are very correct. Thank you so much for thorough review and let me send a new version!
> 
Yes, Simon is correct, but we do have to be certain that the driver
actually implements the facts correctly, i.e. that it will actually
honor the RISING or FALLING edge, before you actually add the flags to
the supported flags list.

I don't see any mention of PTP_RISING_EDGE nor PTP_FALLING_EDGE in the
driver. Thus, I can't confirm which edge is actually timestamped.

Thus I would NACK this patch until you can confirm whether the hardware
either a) timestamps one edge, in which case you should set only that
flag as allowed, b) timestamps both edges, in which case you should set
all flags and then explicitly reject the case where only one flag is
set, or c) can be configured based on which flag is set, in which case
you should set all the flags and then check the flags when programming
to enable the appropriate edge.

This patch does none of these, and is therefor incorrect. Applying it
will "allow" the userspace to work but they will not get the strict
behavior of timestamping the desired edge, which completely negates the
point of the strict mode!

As an example, look at the ice driver:

#define GLTSYN_AUX_IN_0_EVNTLVL_RISING_EDGE     BIT(0)
#define GLTSYN_AUX_IN_0_EVNTLVL_FALLING_EDGE    BIT(1)

                /* set event level to requested edge */
                if (rq->flags & PTP_FALLING_EDGE)
                        aux_reg |= GLTSYN_AUX_IN_0_EVNTLVL_FALLING_EDGE;
                if (rq->flags & PTP_RISING_EDGE)
                        aux_reg |= GLTSYN_AUX_IN_0_EVNTLVL_RISING_EDGE;


It sets the appropriate register values to ensure the correct edges are
timestamped as requested.

Thanks,
Jake


