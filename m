Return-Path: <netdev+bounces-270629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGDMJR6HwWn+TgQAu9opvQ
	(envelope-from <netdev+bounces-270629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:31:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C02FB525
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A272E337E08D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1063C73EE;
	Mon, 23 Mar 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnkEd5NP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FF3C4576;
	Mon, 23 Mar 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286442; cv=fail; b=subHX/n4hdnbeFPA0Uyuj2Vi9K23rCfwDVN/707RLbyFYdjE9fqsFIRBAMmZhuDyF+vllpd4v00+YGCycmiqjFcirBx7GxcVKXBUQ6w1aPwuM51me4vv6dQBqAPGL/TxwkA0MRVZmYNIGlD+9wlExulOLo19ZYvFFb7Lk5zET8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286442; c=relaxed/simple;
	bh=UpkihvpVx+dcbciv70R72o6xonFr/19kcjGOuo/HEic=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hefEixGRutrv7tqnkS7WPJ9nNGTjrdBXE5E/YsuG175W743zJMvXu49+8NQJmN+fnUOMgHoMUHnu74RR5MrPCFNClA02dDWBcI2loGUbmWbEREH8c3HG/l85l2oqylQJBu5Dz97OlZBOcBHf2xTOerZ6wfmDwTmthgLWyv4wyUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnkEd5NP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774286441; x=1805822441;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UpkihvpVx+dcbciv70R72o6xonFr/19kcjGOuo/HEic=;
  b=MnkEd5NPha8y+PdjmoXyKR3TbM93YYrIkCVVgcwCKHOYE/0HOcleuwm+
   DDBab9GC2IDcayXtxlmBIk0ec8fwp+dKX8wN18+0eptv0ia2/n7upCTQn
   iRX0hEg2THQ8ihPYw8oc00PEgldXZkZxbzgLuPCfFHTdvxjjkOZY4xg3I
   wwbKfI6rvXeE2M29sI24roTLKD4LiG+JMtpinB/AvilKpkGOjEF+cCVm2
   lTrIi4GXpzRFCIHXWpGjogK/rqYE8a/SkVbVjsuasI3lqNNDCUX+tPnj5
   4/3sPPUATXAcyUAD5yihMPfLBv3lj8pw+omcQ87HjWiOiL6Cz7nItYZ8e
   g==;
X-CSE-ConnectionGUID: Vb2nJ5VTTOu2LogMIkxN1w==
X-CSE-MsgGUID: AxUs9K2gSxKMKeU8YkvTlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="78887592"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="78887592"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:20:41 -0700
X-CSE-ConnectionGUID: kIyg+hI0TqCj/P/x+sRKbQ==
X-CSE-MsgGUID: ClVnAgV4Svu2+JUtxw9fWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224060780"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:20:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:20:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 10:20:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSfgHfDK3k9ONqJHf9AyT1mA0qjp7+xyRb+MhGhxLuYnp6/iBNj1YL1s1iTopw1T4Fln7lUjp0QTO37ExDyH7jfGx7n8PRx0lXoB+wLL41qInH2WIqh5n4jVntmby69LvwNiio34T6S1lJPNL8bufNxQry/4aVQ15ZTtBCBSq0tICW0LGosT6P13b4fBflrNO9Ju8A8b+cXJL8ongyzWNMVom/ZWEUUD5v4GpNBzqn+c7Ima/qmuohIIsZ1QuQzSmodco1AGfHu98yJUr/6FaCzSgZbjjg3w2rI5zpKS1seMexS2WtAY8MDX2XIwPxIYsOUd4jwAPzz9voB89FxXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP7WKYmJxwa/TEOCbd8Fxy5QrhKQ7kqRgzsfUHMAils=;
 b=hHXgwnU8BfTijJW3XIAPBHn8uFUPX8Mpm0m8R7R8m/Fu7m0I4XQeG2uTIEEv1c9zoc8VPg6P2fxpQPFrRX863BuwnZhjLJW774zcOIZPSxBr4g8HZ56X25byQd4JTFzMwnTYeI/13Y7cyIMNUReiu4joo58YvBQdzWYv42eJYp3GWllnIRrN9qKYGo4/sO24cgCYxHobgM4ldEk4pQJQxaKnoDW0T+uyiMq/dwFRuK2WrA9GPalwtqis95zeocKxGasYr4Laqr2EsFPynbc2wD1lkt5ryLDH9ypaxOPwVSRKaL+MyAuZ4XVx7ah4rlGLYoZ0aqebA+CgBk91GywmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 17:20:35 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 17:20:35 +0000
Message-ID: <abceb7c4-7738-488f-9395-7990aa93c058@intel.com>
Date: Mon, 23 Mar 2026 19:20:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] igc: fix typos in comments
To: <maximilianpezzullo@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Joe Damato <joe@dama.to>
References: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
 <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-2-b6a9f1d336ff@gmail.com>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-2-b6a9f1d336ff@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: ca94e398-88c5-454f-46fd-08de89007ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: IuePP+eyZfEQK2I2+4So4syK3Abz3gUAQiU5Ex2U6micRPOeNmbLwkzuvAjd2nwBOUIbSXA501xGc8XyforHGj+v2CgirMqVYLqgIQ32UJZ9MILF3N0hB7KNJHlHDQM7yJi/vAT/FhECiY6AnIvV0v9Wh0qZq7cbyrl+k3TcuKOqFnwLcK0cBjYXdMAmgKYOoNAKB6Co382tQoE0ZGmn2ipe0xnxA7+RBeBiSugWobk5QcQUAoGfFl2+F3o4mQUsGckzMh2KGSa3lI4pFKtmn67MRFEKyrtLz+0l/Usck81NFVZv+FiWVmZN9RJ56y5t+ryjxWxSvzMhpuw3z46eMlORFj63s1U0CZWSxVKzbCLFS7vxqmtk/RTN2UXV9ctUpWoNXbWWvG5055UdVlRBUZTwZNIVmlxvgcMedumuCbiC1cTpDuwJzVsw9WrAHpRicTI8D7YWNozHyDzfTaSaWyYxkF8SE2EpyL0DBIl79tWcuFEDOOL3x0HtzlDVGVvYzZj21RXm8DJJw0XjUQrTStzikFKyCAdpkFemK4Lu8KBweBhHqhc47LZ4Bz1/O/vzaKSQUVsbBXSOwUlhIHJIaxfPpVlD02ApMzd4dZUKdBS2Ju6snF+EFwJ7ZNWqV/GXcaBhOkKjc95ZOFKidIuvgfn6NZzPil/X2E5i5Dz8RlbMD6KwwmSxVBMqCqqFoH2NEJLdZ40qv/ElRPFp1VRxOFkmtxQ9FChV/sug1fuxLyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(7053199007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXdDSE53TzlMcDBWNTUza1h6a2VHdjZPdW1LMDA1S0pHRWtLWVFvS2tUMWMw?=
 =?utf-8?B?L2ZEVDNGVVloUUxUNTVKQ2xOSktNeGRqdXdhUFRNek01Q000cGJ3Q0ttaGxP?=
 =?utf-8?B?MklyZyt0VFB4OXB1WlNQdFRpdm44NnIxdVpkT054MG00UEVsdmVmMC96b2VB?=
 =?utf-8?B?bTQ5QWJxYWpVNytKaU5WTmhsbjAzcTY4SUdvMVVzcUFVVW53VmFKcXFyTHUw?=
 =?utf-8?B?QVRlN0hFYnp4U3FJMGFmZ25rQVN1Smk5Ui90alJXRkhhczBYWlJtbFZJR2hS?=
 =?utf-8?B?amcxV1ZoUEZQc2pFZDBXSFEzWWpxbVRzSCtJLzNuODNnbzRMZWZDRUZidHlh?=
 =?utf-8?B?aUxoMTdERHhXd0QyVlJPbkdwdjgzbE1DNlBzQjdPSXRzVnNTc3RVQ1daajJ4?=
 =?utf-8?B?dE5DK092aFdIVkowOXVkRHRDOHlWc1ludThmQkVoaGxUZE50ci9PN01jRHJI?=
 =?utf-8?B?R05PMUhyam54MGRlMlBVbHVhbGx3cUI5d2FVcnowUFRUanBMZ3I0Vjk1cTFC?=
 =?utf-8?B?Vld6V1c5WlE1WFFWc3dONnp2bzJyN1FiSENSeWhZcnNnS0VPZFVTcHkxZzlM?=
 =?utf-8?B?bGpPZ09Hb3I2N25VNUY4UEpvWjZkM2VhYy9IYmlwd0ZHRnpLUkFxQXl4Yngw?=
 =?utf-8?B?V1NHQzJUaTJRNG5JZkU2YzN4dkY0TTNSSzZzd3JjRkZGdXc0S1l0dUd6Slcx?=
 =?utf-8?B?clIwVUtmaGhsaDJEZ093VkRwd3ZwcTh5bGtiZEtBdW8zejhqWDFwdWxZdlN0?=
 =?utf-8?B?VHFYcVpQY21pR3d6RzV0ems3SVVlNlNQK2NmSXkzTVdzWEh6THZ6ZmY3RzRN?=
 =?utf-8?B?ZEFyRWlDdUpoMW1NdGJZQSs2eVBhTnU5RCtxMTVkTnFmZmsxVFBHby9KYzRy?=
 =?utf-8?B?Z0VRakRsSitKcmI2NzBTZHZXZGcwa2kyc2cweTEramJEaTl4UWRwNzVxUis1?=
 =?utf-8?B?NVpzVzBVL2tFS3hKa3gvNHFLdjNLTndWZm9lUTU0dlFGTk1Ya1A3eUFUbE0v?=
 =?utf-8?B?MmtaLzB6cWdjYXZQUEZhYTVjbDdMS1FSVVNmYlA1ZzhKVzQrbitLQkliOTlH?=
 =?utf-8?B?QmN3emZpRW9lNml1MUJMNngzSTJJaWJNOXc2WWVXd3c1M1JONG4zbkdxNVdG?=
 =?utf-8?B?aXhFVEd1Z3NzWjZYZHBkSmhsL2xGci9aOEdFLzJIa1VMWklJaWhPd1g5RGdU?=
 =?utf-8?B?bWRMNWtDMjFzWml5RjFpSTArdkdwZzZMVHQ5MDZyclRSNm9vU29wU2ZiYjVw?=
 =?utf-8?B?aHhPZmdvdUY2Rk1qTDk4SnEwcWtHc3YxSkVWOXlGeGFQbDlkdHNNZXcrSFR4?=
 =?utf-8?B?SnA0K2VvRmFHejhjaWFSdlV2RXVzOW5YVjFSd25xdEpSc2xBcnpKRUd3MTZy?=
 =?utf-8?B?WkF2Ujd1d3hMN0E1dXVlZkJ0RXNOSmdtbU85WlliVlNFSko3bVVJR0czMnVV?=
 =?utf-8?B?bEZIWmo4YldoSG1IWlpzM0ZNZDUvemVOYjlITkdodGtpQ2RXQlFpSkxLZWZV?=
 =?utf-8?B?Mk9iVWN4N1JaU2lEbmUwS1V4S2FhMWdHanRLK1F6U2I4cWFnQk5Rd2VoNlFC?=
 =?utf-8?B?WkVieXJseE5rakNwQTRld2lER2FGVVNRQXpVRlNybDgxc1BzQlJEak1hVUZF?=
 =?utf-8?B?NWhEL2QxNUlXclI5czAxRUIrdlJqMCsrN2d3VklsWW5FZ0F6VTlUUk1wTDZM?=
 =?utf-8?B?UGV1UGNQUndtdWlSZitudlBCZGNFMFhvYUxCZk9WeG11c1VoOG9BZldQK2dG?=
 =?utf-8?B?MDFlMEVxOEhBemM1OG9uNjMwRzhNZDloVmc2QU9XN0w0dUYyNzEzb0o1K0sz?=
 =?utf-8?B?aVhiM0NLaVh5cFZ3R0JmYTdhZlcxOHNrWnRFQmFzSG05OGd4TE9aV1lsTkJj?=
 =?utf-8?B?NEZoa1JYa2gvdWVXenVWc0NsWDNYRCt3VEFmcHRncmVneXdkVTdMVloyNjBz?=
 =?utf-8?B?MlRYVHN1Z1M1WEtVbndKQStFeXVWT2VvRWNzbmd6N2daemwxa2QwTitiTWVT?=
 =?utf-8?B?QXFpUGVockM2YURlVXQvVkpFaHdGdWlFUlJQVW5EMVBLdzZnOXN2WWtJMmdB?=
 =?utf-8?B?bTN1SmxPQWxuS3NMTmF3LytxTmdjNEJwalFzdkxBQWJDZzhVemFUWDlDQzRK?=
 =?utf-8?B?WGZqbWVRUy9pTUsxb0VLRFRGbG8vZUdyN05GSU5waU42YWtXUkNYS0ZBRk5P?=
 =?utf-8?B?aXFnM2pZWjZTd09RRXh5bk9nWlZ5cUREMHNlMlZvU1dWem5ySjlyNzRzTVAr?=
 =?utf-8?B?L3JVL3JkZmdzbXR1VUNKTjB1ZElNdGFKUi9aSFgrRStVcmI4a0JMSXJIQWVB?=
 =?utf-8?B?cjFoSGVvemxSajBKbVFRUndNRndhcGh4R28wUXljRGs1SWJFSzltZXoyTDFh?=
 =?utf-8?Q?bbsFlttBTawWqTQc=3D?=
X-Exchange-RoutingPolicyChecked: eMlAys6ogMwgk95CxSZlaqU4o7t8nyJmx32c03SOsr+AVdff0M73tjDYMoXg9OgIbI4Y4ADxiYTEIELYTugQhB+1MnBCSIBpgzViDMcf9zlLunk/81eB3gj+FV0DVrnrEt2a2O6rD0s/YWlhbzQrgNWPqKQkH1JRxxhdfurqUYz9wikyJbreFzfqsbDd3nBsIXv5CkPKAAqHaYSiFeby3jKvzlJ5XeZoz6tRo01P2c29EdppVG13VL7kaa0rmqPeHv7qg3jutktNbnaKJOYuWqbH5lFmOl+1DPiAQa9xV4czQYMPdX33q8fjp6BjemriNme/tx1yih4UWB5WdSccaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca94e398-88c5-454f-46fd-08de89007ed2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:20:35.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1ayLQ27vXinyJhOSkb0ZbJYBgyK+KgQDXpilNwF5/TAUWpXwucUCTdDdJEwyd7hzA8cYdQZVrAuqz6QZ1PyiXvxn+8oWlr3xXNZOpTL8h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avigailx.dahan@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DE0C02FB525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 04/03/2026 9:21, Maximilian Pezzullo via B4 Relay wrote:
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> Fix spelling errors in code comments:
>   - igc_diag.c: 'autonegotioation' -> 'autonegotiation'
>   - igc_main.c: 'revisons' -> 'revisions' (two occurrences)
> 
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

