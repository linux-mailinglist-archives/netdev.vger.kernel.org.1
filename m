Return-Path: <netdev+bounces-120236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47073958A98
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9649CB23155
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052E194A40;
	Tue, 20 Aug 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpEEjBMG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476319004D;
	Tue, 20 Aug 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166040; cv=fail; b=rAWgLJVScfpvULbCIFuLZI3kXIleRpWuOQEfb8RwWxB02e/JvvIljgl9Y4NfItDK8yH29+iVfMelEKHkoRL2VwaxkuhoUhefgJZT61Z6uMd60D1sFHpOdagG2jYAkqRyiFpEO8amK3Tuspi6E4HpTI2fEvknxPOTctJmR367j6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166040; c=relaxed/simple;
	bh=azGnc6d+2Qgp0axmKqlDCUQL0n1AinU+O++Yn9DdhRk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mdxTGMkcdj5OZ2W+0KiOc9pcUdGuEiG0zGONs6Ok1d4wBeS5pRFd/PsYrBap2QxmPu1Y0eS6I0L1a/Jh/M36cH15ylQ1AH9S+PANc6Woe1gu4j3V17X0hHGV+WDR1arp+TcIcTr24ajPVb/uuUVGk9V7sgMnjtNVp0bmFsTsPhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpEEjBMG; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724166038; x=1755702038;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=azGnc6d+2Qgp0axmKqlDCUQL0n1AinU+O++Yn9DdhRk=;
  b=JpEEjBMGuXeuRQamWP1nhStanGOdGc1gWOsn/XR1HWV1q+6AA4iqYpVC
   2PQZI76sU7yco/b0vrubF3OKGpsFRLs2KPF0iDJDPAdFaOzmi2rxwdpdB
   tuE4dzZC8Hiv5n9xMmpRLRBaS114Vfx3CurWnEbjPQHpDN9vkug9rnWGF
   OhhldoshIayaI7NmvmVkLAWaM8XcMS+9dyWeXe1p9xjJnbAK3CdHY0lwk
   7zIojzHlkz4/RlaadiepQJwciqAygmKscrYHH6PrWHd72dWKonbzoACVH
   txUN79HZSF1KL/VidduEp5OBrzD5dKQvGBJL7FDIrsYK7wLps44sVRmtv
   g==;
X-CSE-ConnectionGUID: wDADTki4Ss2gsSddjE8gbA==
X-CSE-MsgGUID: Ddsny98rQnWXQZJKGIhD0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="13114584"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="13114584"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 08:00:37 -0700
X-CSE-ConnectionGUID: boaFTkzkTcC5Mzz+ctxWqQ==
X-CSE-MsgGUID: pWVbrmEKQL6fzvVXuYIMuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="98230531"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 08:00:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 08:00:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 08:00:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 08:00:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/RIcvzqOxK3ePyUeALSBWpjAK8lmNeYm8ghdS5d3PgxOiPUL4DIuOrjXLHnHd7wY4Ai3mQO/JW5lYORYlP/p+jeJO7I0aHFGccGW4lW7sw611PVJefYI6CSBp0VzO2fvoyM4jiuZyWWWSPlPOJm1LpcsL3bH5Ei/2gG02KLjpP8RWQ4fWP+3HYGQH5KNaIxd5u69B7jq8BEToJiPv6gtOctoe1QIpqn2eZW68MsJzEbOdB9kBmdXEMCb/oFTvSSG0R7dtaEkQD9ZFHCUNw0PIptiT8YUjBgEvjxxbYLDYGSAE6FnwpTsSHE4+hGyRuq5RWsK1Ptkv0/AqJy1kTKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXPX7NitPgb1pXIPV4f+h6/5FBdK3hkto97k1oLAo74=;
 b=KQVOVTJPyiYRML19YSelh396fZL+vQIMJucm0lvVsm6USKOpPF6xOU0ogFzafP4ZZmMU/Is8diUDhf+JWs4qAqChrsf8fMg8hqha2u+iyDLo/9kvGSFnBbjtuIw0yT7vW5Z3q8jqRCkcyL4xU0X+FvVuFLuctNalpGxPE6LGHrcxfg0Wb+hW3J5A76H4JHa4FndPPiEUrHVvFC/PwBx55bGlgYRd/z1NuUZFZBG0fKfIhLnX1+N9XKMMsqZK5XsZ1WlB6AqSbziD3JuqfKXJSXH5v54o/5il0pz30Ipm8hjeNSuMH3VabMZWG8c5gja9JU1NaldBRTtlVsko/vA9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL1PR11MB6049.namprd11.prod.outlook.com (2603:10b6:208:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 15:00:25 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 15:00:25 +0000
Message-ID: <821f0baf-8e40-4623-b342-1028c92e5519@intel.com>
Date: Tue, 20 Aug 2024 17:00:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/7] net: stmmac: support fp parameter of
 tc-mqprio
To: Furong Xu <0x1207@gmail.com>
CC: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xfr@outlook.com>
References: <cover.1724145786.git.0x1207@gmail.com>
 <413a36781a9b215c857bd8ec3c9ee03462e861d7.1724145786.git.0x1207@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <413a36781a9b215c857bd8ec3c9ee03462e861d7.1724145786.git.0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL1PR11MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: f285ebf2-e6bc-49f5-30a8-08dcc128d26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUhOZTVBQXhOM3h3eWpQSG4wRXA5dHNxWEdiWXQ0QmdCbnNMYzNOZFlSQUdo?=
 =?utf-8?B?SjVPVlhjTmJNUzc1SDdZYXZQNWZLL2EzNGs5WWNWUm5hMGR2Z29OVjA0d25q?=
 =?utf-8?B?VVpSVGw3VXVHaDMrbitnRWxjSVh4WmdvZUZNNEFNWGZwUkxiV3FvVTBVYitq?=
 =?utf-8?B?dFcwVHBKWGZKMy9mQmlDNEU0THNwbStKTDZQdjdNSFBmWnRYUVhjUXArL3hD?=
 =?utf-8?B?QVJud2ZGdTBlKzRxR0tZV0t5c2J2Y0FubHg1a1d0UUdWeWxXSVNabnBnTXJX?=
 =?utf-8?B?Nks3aSs0cnFuTHE5TzZZR1NmTCsxMWEvNjJKVmYxbU1BZ3NEc1h2M2dHNVh5?=
 =?utf-8?B?S0RxMFFHSnZSbk5URGt6VkorUHVzakl0MG52SytzMXh6WG5yNEdEVFEwK2RQ?=
 =?utf-8?B?TVNqeGtTZDNZVDBVekQ5b21zbGgzV3cvRkJHL3FhSDA1NmtLVE1aWXgrK1oy?=
 =?utf-8?B?bzNtcVpEZjFSUlFjY3c5c3c5VEo1RUxidmgreHVBWXNoRDM0d0l1bjVBVDdt?=
 =?utf-8?B?ZDZaUTcrSW5TQW15YUE0T1VuVGpEaGxSeWdNRmZndzQ3ZDB3OWlNc1ZYYyt4?=
 =?utf-8?B?UU11c0V2cFFKK1BYTlNHanZhWFRWeG03TnBHdXZ2QS9ieEswYVF4T3dLQm1P?=
 =?utf-8?B?cXMwVFVVbFFaRENUNFkvcWM4M3RPeXFWenNpSkRKSzZYWitCNXFEYmZJUmo0?=
 =?utf-8?B?VUQxWk5NdC9SZVVvcEhHZnpGaUxaSEdtN0JUNGdzeEU0bFY4K1p1Y0kzeGVl?=
 =?utf-8?B?a211N3lhWHJONnpKbDBmYmhyNEhPL3BvY25SUDlOZlJidi96TGFHV3VqMElm?=
 =?utf-8?B?amxRWmY3ekR2VDVicWVGUXFoLzl0cVZzU2x2TXJGSXJSQzZaK3I2bXRycHBY?=
 =?utf-8?B?M2JIeWRUbmVMZHBYZ0YvQ3B4a2F5aVgvMTI1c1FMVHg2SzUvbTNHUmE4dVU1?=
 =?utf-8?B?OXByUDFZemZNbm9OWlJZbXIvazBjeC9vOEdtV0FDY2RPM3pTaSttS0ZmRnM1?=
 =?utf-8?B?RzYxeEtGZDJ0TjFIV0h5M0ZCcjdSYURvTTgrUThnblBYN1hZR0tlMnlIYkdC?=
 =?utf-8?B?UGZscVRhMEtkWG00ZENrRktPU3RDa0pwbGhQcjZqaDBuUUp0TDVSWkJxNHFi?=
 =?utf-8?B?NDd6L3UwUnVncHVtbUUyNlMvdHRDQm5YZ1c4Tlo2MXArQ281d29qVDB3OXo4?=
 =?utf-8?B?emtEV0tVNjIrMHFrQzg5aTdRU3dPaVU1WDZLMlpCQ3JtNmhRa1grMlVQL2RP?=
 =?utf-8?B?ajZCUGQ5K1VpQkI1SjcyaDlSa3hjREFMREtqaTVZVGwzbGdCMjFxeUdHaXlK?=
 =?utf-8?B?SXZpOHZLamdOenl6cVYwN2pIY0xMeTBRNnhnelQ5N1IwdnNNWGdWK3d5Vmha?=
 =?utf-8?B?a2ZFRDZqcXZQUitBa1l3VXpHNnhwNmU2ZGZIRjdpMVM1Q21WSnhPQnBrcmxV?=
 =?utf-8?B?RHFtR2lXUk1wQ2JTWUswWHRpdStMc2gyTytiREYwVnJjcFVVYXBpMThIQktl?=
 =?utf-8?B?T25zT2NQSHpsejBCR1gyRWRQQll6V0RsRnlIWElXWXNyQkZSVGMvVmVRV1Yx?=
 =?utf-8?B?UStHYTBSZlROR2FySWdhNXh3NWh1anUzNGVndXEweWEyL1hsckRaTExGdkJQ?=
 =?utf-8?B?c1g5VTVJT3p2LzB1N29YVm8zcUpWcXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZktsOGdWRnVicFQxdnBuNDFKNWZ3c2F5OVZoNXo1ZWJLbFduM09jd0tibWFa?=
 =?utf-8?B?RU4zZS85WGdkdU5LeU9CQlpkSWh6RVVJTVFwWkxMQ1RIT2VTZGYvWHdyQ3Z5?=
 =?utf-8?B?ZGFlUWV1WVR3dmh5OTB1MjhzQWM2MGNwcitqSGhKS05aSEdYdzloN0NJbUdV?=
 =?utf-8?B?bTdlTFhtV3V1d212MGlUSzZXd1k1cDE4L1hqWXRSTFNtSkRQQk5rQmhmaTJr?=
 =?utf-8?B?cWZqS2JYUi84TVhjdWxMMDdQRERNalRYdnk2OXp5Z2F5dzNYU1UrbmZrQko4?=
 =?utf-8?B?WGxoNWZjTklMb1U0WUFwem85OTlVN205a1JQdzAzS3NKUytabFM0MFd2K215?=
 =?utf-8?B?d0FCOVVxd2NWNDlHU1pGcW9rUUQ1ZzM0R3FpRjRCMFlhM3JOSHJUL1ZWb2pB?=
 =?utf-8?B?MVQwQTNvT3B5bW5kYmNIYVF5WkRoU3BMS0xwUEsyKzZnSVZoQzlLUnFjY0x1?=
 =?utf-8?B?dmo3azZNVksyUDdYUjJGVnhUcmNUZU9WNFBVQjA3ZFpweTg0VG9GNjhZcXdt?=
 =?utf-8?B?dGxqTHJsWkpPRE15Rlo3K3pGQlowbmhYSTV2cFVGVnFZSTFqUFNlU296TDkv?=
 =?utf-8?B?ZndmVjRQMzVnVnZGbERwMU9iejR0R0h0eWVqUlF4TWMzRTUvWFNkT1E4bUVx?=
 =?utf-8?B?ajJXVGtPd0Q5ak9BemNZc3J4dGJvTUhBbk42NnRmT0t4RC9GTGxjZFVHd0NO?=
 =?utf-8?B?bWZ2OU9BM1JBRytPdXRxaElvTnBmZUczZnJvaTl4c0dETUZ5OVEvSHF3cFdH?=
 =?utf-8?B?S2VwL0IxcTNvcG9BeGprdUd2MS9NOUtXMy93RndIcTBReW93UjVoNHh5V0Rw?=
 =?utf-8?B?anNMWkJ3ekhnajA0ZlJDOXlPQ29kMDE0UzRxOGh5eGRQMWZPWWNpZExCYjN0?=
 =?utf-8?B?bUpSeDdmWC90cVl1WCtXVlBlTjRlK2xXVkxTby9YQ1N4K1RMandoelRZMFVx?=
 =?utf-8?B?ODNJa25PbXhQTlBGNTVDeVFtSDFCRFVMTm1SSGxSUTZqcWJ2RGcvcTZtdVE3?=
 =?utf-8?B?ekhJTXNldS80enZZbEw3SUgzb3N5YlFSRVNIMzFMRFp4VWhPR2NPaHlUU3FS?=
 =?utf-8?B?RmFzWFJSVGxKZVc2YXk2V1RyUUJtQzJjbHR5RDNobVVaRjRUQkMrSjZMRDVx?=
 =?utf-8?B?dlJLTElvRHRKaC9RamlQRi9tQUJEQmNQa3MvZUM5WGJoUWFwLzIwdWtCS3hs?=
 =?utf-8?B?MmsyN1RxSndsMkhaR0JOemNjS20yRmdZU2huRHB6ZWFUVHFVc205R2o0YXN0?=
 =?utf-8?B?a2NRcW1FaUg0OTYxd0RwY2VCQXFpWVp4QVhJR3d3UUFPaDJ2Vys3QkU3bWxh?=
 =?utf-8?B?NVZuWDlITmgzakw3NENRcllvNzlGcytuQTk0NExacHcwL1B2SEpidlRCaVhU?=
 =?utf-8?B?ZXA1UXF1c0MzL1ZTUTNnOVcvajIvSDl4NW1mQ2JKMUQzOVM1TW1UN0dHdTJC?=
 =?utf-8?B?NzhTMTJ1VVVmdTRkYU9TbzNYbzF0SFB3S2kxZ0dpTXJ1MVJTcnEzYWRJdEhR?=
 =?utf-8?B?MWJNRWNFOVBuZjdOZ1JnVmFTY0l0b0RWWFZOOWtZK2Noa3ZNczdmRXRzeWps?=
 =?utf-8?B?RENUODUwazBDVDlEKzVpU204eGdwY3RHOHVoTWMyK3VFVXBXRDc3bVVUQ3JH?=
 =?utf-8?B?am5vK0ZVSHNRcU9EUFlEQ29SVU5EbU05a3orbkRMaTRGaXRJVjNnUEVjVVJl?=
 =?utf-8?B?TDF5WSs5dlg0ek9lcjVUZk45V3NHdDBRclk1dlcyZGVxTGNnQjhtbWtzdWkx?=
 =?utf-8?B?M0FGZDRWM0lFU0lBb3NsbWlabTlUU2F0NUE1WmQ0M0phK09EbGdCQ0N5cGxQ?=
 =?utf-8?B?aWI0elNzWGtYbUd6RGZ2Z3dsTnVuZEdoekNQUlBDTWtibjk1YWFEODU4eVA4?=
 =?utf-8?B?NWdrUEZ4VEYxQXNyRGd5aW02SGl0WnduYjdBTmNmL05RRm1GaGhZMmtNMzFa?=
 =?utf-8?B?UmpzZDNMbjU2dFN5SGtUV0Y4cXhWSnVpa1ByZHNVSE9IRFcxRUZaUHJvNE90?=
 =?utf-8?B?SWY3MERwcUp1aXNDbTdWSlRNM0x0Rm9yVmIzUWNEWjFOWTcva1c3T1NWZThV?=
 =?utf-8?B?VkR2REE2akVYZ2lLNmRzZFVTbGtPV0VnWDhyd3J6UzdKQUJGYm1GL1dDaDV3?=
 =?utf-8?B?dnRiUXp5VzZteFhSaS9JSkV4cjQ1RFRaN1Axclp4cVBTRUw2VkpTa1VHcnk5?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f285ebf2-e6bc-49f5-30a8-08dcc128d26d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:00:25.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2KCOzNhKtmVSenYPimNXF2i6MV0Va1ModI+dngYiTSloCgSA7im0n/5zy74otXpIVqXJAsSMQYtYBKIl+jHd64gRC6eiUCfJpSOEG1A+G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6049
X-OriginatorOrg: intel.com

From: Furong Xu <0x1207@gmail.com>
Date: Tue, 20 Aug 2024 17:38:33 +0800

> tc-mqprio can select whether traffic classes are express or preemptible.
> 
> After some traffic tests, MAC merge layer statistics are all good.

[...]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> index 4c91fa766b13..1e87dbc9a406 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> @@ -670,3 +670,55 @@ void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
>  
>  	writel(value, ioaddr + MTL_FPE_CTRL_STS);
>  }
> +
> +int dwmac5_fpe_set_preemptible_tcs(struct net_device *ndev,
> +				   struct netlink_ext_ack *extack,
> +				   unsigned long tcs)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);

Can't it be const?

> +	void __iomem *ioaddr = priv->ioaddr;
> +	unsigned long queue_tcs = 0;

Why is @tcs and @queue_tcs unsigned long? You write @queue_tcs via
writel(), IOW it can't go past %U32_MAX.

> +	int num_tc = ndev->num_tc;
> +	u32 value, queue_weight;
> +	u16 offset, count;

Just use u32 here for all three.

> +	int tc, i;
> +
> +	if (!tcs)
> +		goto __update_queue_tcs;
> +
> +	for (tc = 0; tc < num_tc; tc++) {

@tc can be declared right here in the loop declaration.
Also it's u32 as it can't be negative.

> +		count = ndev->tc_to_txq[tc].count;
> +		offset = ndev->tc_to_txq[tc].offset;
> +
> +		if (tcs & BIT(tc))
> +			queue_tcs |= GENMASK(offset + count - 1, offset);
> +
> +		/* This is 1:1 mapping, go to next TC */
> +		if (count == 1)
> +			continue;
> +
> +		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
> +			NL_SET_ERR_MSG_MOD(extack, "TX algorithm SP is not suitable for one TC to multiple TXQs mapping");
> +			return -EINVAL;
> +		}
> +
> +		queue_weight = priv->plat->tx_queues_cfg[offset].weight;
> +		for (i = 1; i < count; i++) {

Same as with @tc for everything.

> +			if (queue_weight != priv->plat->tx_queues_cfg[offset + i].weight) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack, "TXQ weight [%u] differs across other TXQs in TC: [%u]",
> +						       queue_weight, tc);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +__update_queue_tcs:

Again underscores.

> +	value = readl(ioaddr + MTL_FPE_CTRL_STS);
> +
> +	value &= ~PEC;
> +	value |= FIELD_PREP(PEC, queue_tcs);
> +
> +	writel(value, ioaddr + MTL_FPE_CTRL_STS);

These are also u32_replace_bits() as in the previous patch.

> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> index e369e65920fc..d3191c48354d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> @@ -40,6 +40,7 @@
>  #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
>  
>  #define MTL_FPE_CTRL_STS		0x00000c90
> +#define PEC				GENMASK(15, 8)

Again some driver prefix would be nice to see.

>  #define AFSZ				GENMASK(1, 0)
>  
>  #define MTL_RXP_CONTROL_STATUS		0x00000ca0

[...]

> @@ -1174,6 +1175,13 @@ static int tc_query_caps(struct stmmac_priv *priv,
>  			 struct tc_query_caps_base *base)
>  {
>  	switch (base->type) {
> +	case TC_SETUP_QDISC_MQPRIO: {
> +		struct tc_mqprio_caps *caps = base->caps;
> +
> +		caps->validate_queue_counts = true;

Why not base->caps->blah directly? I think it would fit 80 cols?

> +
> +		return 0;
> +	}
>  	case TC_SETUP_QDISC_TAPRIO: {
>  		struct tc_taprio_caps *caps = base->caps;
>  
> @@ -1190,6 +1198,78 @@ static int tc_query_caps(struct stmmac_priv *priv,
>  	}
>  }
>  
> +static void stmmac_reset_tc_mqprio(struct net_device *ndev,
> +				   struct netlink_ext_ack *extack)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +
> +	netdev_reset_tc(ndev);
> +	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
> +
> +	stmmac_fpe_set_preemptible_tcs(priv, ndev, extack, 0);
> +}
> +
> +static int tc_setup_mqprio(struct stmmac_priv *priv,
> +			   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct netlink_ext_ack *extack = mqprio->extack;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	struct net_device *ndev = priv->dev;
> +	int num_stack_tx_queues = 0;
> +	int num_tc = qopt->num_tc;
> +	u16 offset, count;

Also u32 for most of these.

> +	int tc, err;
> +
> +	if (!num_tc) {
> +		stmmac_reset_tc_mqprio(ndev, extack);
> +		return 0;
> +	}
> +
> +	if (mqprio->preemptible_tcs && !ethtool_dev_mm_supported(ndev)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Device does not support preemption");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = netdev_set_num_tc(ndev, num_tc);
> +	if (err)
> +		return err;
> +
> +	/* DWMAC CORE4+ can not programming TC:TXQ mapping to hardware.

"can't program" or "can't do programming" or "doesn't support programming".

> +	 * Synopsys Databook:
> +	 * "The number of Tx DMA channels is equal to the number of Tx queues,
> +	 * and is direct one-to-one mapping."
> +	 *
> +	 * Luckily, DWXGMAC CORE can.
> +	 *
> +	 * Thus preemptible_tcs should be handled in a per core manner.
> +	 */

[...]

Thanks,
Olek

