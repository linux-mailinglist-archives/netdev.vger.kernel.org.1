Return-Path: <netdev+bounces-100488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB038FAE47
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41300285CD6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDC142E9A;
	Tue,  4 Jun 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4nzF63s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803B652;
	Tue,  4 Jun 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491942; cv=fail; b=GHWOuutwlO4l7pNmf9BOkp7AlztvRK0uzUxWTUcSMi38IAKC3pk/P7HPJL1ze3tvcMNhNWwN9013wZYTfOv65oiAc9ywm8Xe+mbUgzf6u4O2ONURKbFjdGM9X0qLqQdR4WFSx6w4ftjaCT5gyxMsK+LZ615LmqEHjJxO8Srnr5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491942; c=relaxed/simple;
	bh=SiS2kqo4jL1kkKs15dxvuijmD3m3jEnset88TenTttw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBcQJkzu+jS98QZMrP9Oe4OgQTLAG/i9C992ZUIrFny4a0uN94nE2BN0RikYD9+FOtowjhZtMNjQjtYXPa2sQJaT2kAuPAnr8gN0E9sFz2Yoidg2OUSt5ttDvG0B5npj+FPoIawAvl5xEHmToXf39mkCZ1Aeqo0Nl1EI1Yq4CwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4nzF63s; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717491940; x=1749027940;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SiS2kqo4jL1kkKs15dxvuijmD3m3jEnset88TenTttw=;
  b=f4nzF63scMYUvhclzs+WKdMmUVN5xd/6pNT0DJFQp+ykPNXXVFSd7Kpr
   4lYwetFiPvLDtGuHlF/ghp3zHWnzTt27ucW9h4g9SzWu0VoFg1KyUHdFF
   WtMVBxowdNiy8K+JQyhqlkdcTgc5fV9B/h9yhGtll+FeyTTglc49zf0yG
   pz7suqc00lugfYN9V4mnxNzWrB04MgYyPd53rQjJdncdOQ93Q9cKRjCB9
   /1SsTKPCk6OU4eeaZiJcf4mLZXFqQojkhqKLyPrbrmp3Ooks243Jg8TNK
   d8EMy8fl5dPGvS0l+98swnKVEJL4/YH55lKezjjzPKgeSxxPjq4BFWOiM
   w==;
X-CSE-ConnectionGUID: q3qr2tGeTPWJe6PpPhwtww==
X-CSE-MsgGUID: amahpWddQvm9fMRpzGIlMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14180559"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14180559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:05:40 -0700
X-CSE-ConnectionGUID: zOBAxxelSlSDMJb7NNi9vA==
X-CSE-MsgGUID: tEmAddTdR1+ropVray8uMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="74680874"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 02:05:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 02:05:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 02:05:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 02:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2UKfeSbulblj8xgqSGgMdhp3q0AZ1WNwnYGjW0XXQsODrNAi21zcYZn1+Jr6cCXDjlzywm2P2iOxnUa2FDxhTw1VTEagcHcomm7sL/R3DGbDkwkIENO0D/aM8yZAPSTCH3bMJBf1edvAyr4+fmOgwxFStpPn3hs7kOFGjtTzFxPzIEb+l6/GlPn0MUtU1m1sKzN+TnDDtFIujFdwl/Sm0Z9jj/razeiDL3L0wEFO4v745qJG+DuR5HXzQ3CM3SQ7Kak55++k8GHh0tyAWLouzgIaOEL7aHzbMFNzAhE0rY46Kz6yHzho5CD19W/Y63s2J0hV2GQv9NPc0BcdmjvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIRHFPYPlOfUfXaisuKHtIWSPLvWv/iQIHgmT7g1na4=;
 b=IM9jQAbAoR0m4CM1jLvwB+B0yAKtjqGWCA5tYn1sK5SipLG/lZlXBNk0a7P/bk3vcQ36famwrGPv0BmXTtT6jAefAHtIb7Kzr0FfdiOLdw4NupZyApgAb1GrhwSKRdTzFH8utVc3MQ2RqWDRHa/UHW64E2ceDH05jR3bFNL+32U8hUJEr91sJyJA/LoipNwD+NnIMQ81vGzPnIaga2JOT29HHNdR55M5dY8ZRFseSEtY0fagL+BddrDVhgvYdhTHjzP3o7feVSqm6moF8gtpUcdAYPZ6YFtEkMnww3jW0Ljx/h9ilP8MG9tGOAfFJOGfD1/MAmexe35RUmXPLbxj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY5PR11MB6210.namprd11.prod.outlook.com (2603:10b6:930:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 09:05:36 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 09:05:36 +0000
Message-ID: <1a27c18a-e500-434f-b3ca-af1d3dedba41@intel.com>
Date: Tue, 4 Jun 2024 11:05:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: hsr: Send supervisory frames to HSR
 network with ProxyNodeTable data
To: Lukasz Majewski <lukma@denx.de>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Oleksij Rempel
	<o.rempel@pengutronix.de>, <Tristram.Ha@microchip.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>, Nikita Zhandarovich
	<n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, "Arvid
 Brodin" <Arvid.Brodin@xdin.com>, Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>, Casper Andersson
	<casper.casan@gmail.com>, <linux-kernel@vger.kernel.org>, Hangbin Liu
	<liuhangbin@gmail.com>, Geliang Tang <tanggeliang@kylinos.cn>, Shuah Khan
	<shuah@kernel.org>, Shigeru Yoshida <syoshida@redhat.com>
References: <20240604084348.3259917-1-lukma@denx.de>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240604084348.3259917-1-lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:803:1::25) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY5PR11MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f7d222-0083-44a4-981e-08dc84757f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE9Ga2J6VVR0dlpmdjV0cXV2UlF5NkJzTWYva1FGaXZJSGNqQllIMkNNdmxE?=
 =?utf-8?B?OWc1RUNmNEJjTzhpVlAwY051bWpwZUVqZERQcFVNREFUU0dnVE5DRE0yUUdq?=
 =?utf-8?B?eE1ManpucFlWcGZtZ0o5dms5bitqQ0Z4K0dNLzh3ekdHL1JNNkc0TmtOTDlS?=
 =?utf-8?B?dGZ6QXlYVkVzRlAxL0w3anJWNU9PT2xtK0x1SXBSUHFMNXZhYnlEMmp4NXJX?=
 =?utf-8?B?SEhWalJLSlZwekdHUVBuYWc3a0VWa2x1S09Zc2xIblZlOG9TUmNCSWhsYnVD?=
 =?utf-8?B?VjJrc3ROeVRDV3VXZWhFaUJIc0hKSmF6S1VyZkZ2MHJRQlp1TEdNTjE3NWZj?=
 =?utf-8?B?MDBVYmszTC9TRXhmb2ZyOXVOMTZiWC9Bb25ieVBhSENleUJHVEt3TGpReVZu?=
 =?utf-8?B?Y3N2WFMrYVh5LzhMOUxKRnBxWHA4VHA0Tkp2Q3ptaEVjWi9ma0ttRUZMTWwv?=
 =?utf-8?B?NlExb0hkcUN1aUtWQ0V1ajc3VlczWFZ1RlI1bW94aS83LzJ4d2F6V1E1YzJF?=
 =?utf-8?B?ZjltVUJnTGhtZ3EyK2Z2aVJOMGhIcWNHTFQ4N1V1bjFEeVJtVUNyWmhiS2lj?=
 =?utf-8?B?U1dmNXdrZEJBbFA3Mk1hcEhvV1JjRG85cHFlVThiT2tDMnc5S3Q4dTFLR2Er?=
 =?utf-8?B?ZTlJNGFwMUFNemd3dHlZUVF5SGJTdENISFFYdlVlZU1ZU1ZBdENKbGtoUTFQ?=
 =?utf-8?B?UnVjWUx3alMwNHpoMkQvUU5tUGsrTDJoQk44SFova2diRzlQNlZ2RTJaa0tK?=
 =?utf-8?B?ZnN0SzF4MXdxSWlrQTBjYzA1U2xETUxJenQxaDA0aVdwNGJBRjVPLzVIa1NU?=
 =?utf-8?B?eVJkL0tJU1REVkRQbXIxUzV5QTdLWGRRL2UzdjVmdEp6Qi9PS09XbmlnQm41?=
 =?utf-8?B?L09qRWV3N1B1M3UzL3YxZCtkZ3laUG1aZkcvSjM0VXQvMndQUzg2ODNtdE5J?=
 =?utf-8?B?RExMeUZTSk9ZUDF0SC9PbG9wUzJFUXJVTEVaRU9ib0ZXMVlwTEZPWkF6dkpv?=
 =?utf-8?B?T1lJT0JCQ211eG5xM2drQ1krZjB4OWFMTTNMUXYvWXVaaGMvektGbXVTMFJG?=
 =?utf-8?B?VFEzMFl6UWlrbnJGRmhHREt3dmtMR25FVE9RUGJiSFhkSGNMcU40WFRsVm1z?=
 =?utf-8?B?ZElEWVdFekdHY0d3aHd1L3dPMlpUeUIwYmJoM1dGRkEwelBDTkxnRHFKY3pt?=
 =?utf-8?B?Y0cvdU1XVDhzdGF0NDVnNFBvazlVRTh1OWFOdHFrOFlnUGw4YmZpTUxRQ3dE?=
 =?utf-8?B?d2N4Ui95SWZxek1KV1d2S0ZSb3BVelFpTmRROWpIUW83U3RVcjh0SFU5K0Yx?=
 =?utf-8?B?RWFlZ3FxWTJvbHVCckRWaHpGby8xSkx5T3BoNExCRnUrT3haRExITm04TnQ5?=
 =?utf-8?B?cklZenRpOCtHQlo1ZXVxbDNKdnhlNDNjZDY1R1lJeGZwZ3loRk5hbzJaOGNX?=
 =?utf-8?B?dVFUVFl5OC9xK2h2SVpENVVJV0VEdmcyTlJrbFdPVzAvRjB5UlNzLzV1SGlR?=
 =?utf-8?B?RWlXRkxxZDBUWkM4enFBUVo2TEpORUlKb1QyMjJMLzFpOVl5QUtWQ210dU9X?=
 =?utf-8?B?MXNscm1mWUU0OFZFZ2dFZnR0U0hwTVdoYUU4SlZCNFB3STYyb29xMEpXZEpB?=
 =?utf-8?B?My9zTzdGdDVEYTV1aUhFSDlyR21aeGt6NkIvc2IvWWtySCs3aDFVMlh1ME9L?=
 =?utf-8?B?RjV4YXhNYnM1dVk2ZFZOUW13ajY3WHNxcVlncnlCRzZDdExVeTF1djFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxGd0g4blhqMkIwUzI1NXl4bGd0NHVjU0N6ZUJTLzA4d2VrWEhZZFpKekVF?=
 =?utf-8?B?V3BuU1djdnVDTzM0SW84OGxqZE1KM0lKUjZXRWRPNXdpN3IzQzlEeEZ1VFUy?=
 =?utf-8?B?V20vd1pZY3BFRlQ5YzlmaW5yK2ZrdzlaMUwzYVNEaWYyR1dOaS95aElvY2ta?=
 =?utf-8?B?WmtRbVFKL2RjY0JOYUh0bmJjZW5tdXV3Y0svU21zT0hlK1NXM3cwWDFaN1ht?=
 =?utf-8?B?VW5tSFV0OHh3ZW8vSDFnZCtnd3h0TVNRSFk5Z1NacnlKWitOenZCSEthMnlq?=
 =?utf-8?B?N3oydmh3MXNpQm5yWFM5Rmg2cWVaMlYzaDNzeWN4VHdJK3B6bnN6cVl4NGlE?=
 =?utf-8?B?c2JSOTFEY0xZVGMyY1FsSWhqTDZQN3c1RDdRNEVESUcvelJVMWJRc2pQUVBX?=
 =?utf-8?B?bmMzNEVBUTY3VVJIeURYenk5SnpyOVRVWmtUY2t2RzBlMFRHZXFhVnQvd0w1?=
 =?utf-8?B?RFFJOEt3MmoraHA2NlJERkFWZ2Q3NzM5dURqcnEwbWFwWVhVd255K0g1dnd4?=
 =?utf-8?B?cmdIcFF4U2t4VkpWNm4xRUxoZk9heEV0d2FURkJWWHEzMFV0SjljU1RWOVRM?=
 =?utf-8?B?cVIzRHZkbHN1a1l2dGZibU5XVzhNY3VYL2FQcnRnMm9QTmFOV3g2U05ZRnFG?=
 =?utf-8?B?ajRlNzZ4ZFptWkVWSUFpMnpZMy9rVEx6cUFFcU9zclFlYkZKYVlVcjI0bHVX?=
 =?utf-8?B?N3ZxaWtZK2kxN3BVZDJmd1VBTm5CbVZkWXJSTWNNc1g0UW94VW9Qb1hPZ29J?=
 =?utf-8?B?dmVMMzVWWXE2Ni9HTWdxNE1DZlRyVG40c0Zmd0JtOXpGT0g2VXlVMStOVU54?=
 =?utf-8?B?WEZCUVhMdXJYYnpERzJHbk9GdmFSbHR2bm43YVYvWGJWMGZocEhUZWYvOTZm?=
 =?utf-8?B?N096Uiswd0RUTDJKQXkvTHJDSjVmbS9FbDFtakY5N0ExNDl2ZVUrbHVrenlM?=
 =?utf-8?B?TC9iTC9TL1M0S0pVOEY5MWNJRkorYmlIZU9veFVEaWVLOWNFeVRoVzB1TkVG?=
 =?utf-8?B?anJybU50UjFFeW9ZSTB0WEI4VERiQlJUV05pSTVsdWI3SkFUUUxMYmRnNHBi?=
 =?utf-8?B?a3NqM05uQkkvRytzNkR2UVFZL1hHWnA2djlkdWtuYWRWbXkzRGZybFFmN1hu?=
 =?utf-8?B?WFJONFRCRlN5dmZ6MmdKK2J6eTduQk5IdE5pWjhnSGVtNmxxYXFPN09uTm9m?=
 =?utf-8?B?dkhzSVRiT3lXY0pQQloyUG1RYmcvZk55K3E5aDg2ZGNVb1E2Vi9BZ2licjdF?=
 =?utf-8?B?cHZHazBCTG8rZnZOWThLWE1ObXpVV2tPbnFxVC9uVE40TEVJdElrZDZTaGZB?=
 =?utf-8?B?blF2aTJuZTFMUlZocHJVWXpzQklLRUtNajBFZlc4NnUrOEV3WUVVTzRjVEt3?=
 =?utf-8?B?SHhHZXlYQmVONWlpUEFHb0pGd2JrL2ZXWFRkb3lXa0g3emtHVi9aMWw1clhW?=
 =?utf-8?B?SEF4VGpTeHlnYngwdmFmL3hGK3R5Q0pFcXBjVFJQNmFnV1drc3M5REsyOTZp?=
 =?utf-8?B?cFZVc2lkTGRuYld6bHEzR0J3VjlKamcrQS9uWERJS2d3aFdoVTkvMllwTEhK?=
 =?utf-8?B?NGdoUXFZT2VOb2ptbzJjaEt5YU0zcUwzWUNWVDRYYWVScHNMLzhnMWlEZXBr?=
 =?utf-8?B?WVY1WU56V2k2S3JSQWFwd2xqY0x1ZTZxOUZhajIwWXp5c0t5cTJWcVFUZmln?=
 =?utf-8?B?bFRuaHRUVDJUWDJINGVpeXhxKy83UGo5dFlHQXRRWGtEbmV6WGF6UWw0ZGxs?=
 =?utf-8?B?d002UmxpbStFallXM2lJMnpIeTFIcXR6MmVabmh5ZmlKS2VCdWRkQmRoRUJ6?=
 =?utf-8?B?VStMYUp4bXFTcVhFVThRaHdiM0lJam9TMUlyM3NVanVUL3Y5K2R3SGtSaXdT?=
 =?utf-8?B?YUpMUXlDeEo0V09Nb2Z2VE9mdG1STXArRjladHo1UjVWbWdOZ1JXNjNCQVZp?=
 =?utf-8?B?RWRJN1FidWhNV2FWemUwc3B0R2NRR2g4ZnRDTUVsV0NsV01aNDFLQWJ1V1V5?=
 =?utf-8?B?WU91ekhRSXI5SzFzVi8wQ0ZsRisyOVdHOFA5MzJ0K3B3aEtsSjE3VlUxelFz?=
 =?utf-8?B?N1pqRlUvQ0sxVE96cFppU3F0aEI1TE0vOHJrQVo2ak42NkljQzJGRWFWMXJs?=
 =?utf-8?Q?bf6j7ONzb9EYTUamSuaNKCcgr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f7d222-0083-44a4-981e-08dc84757f2d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 09:05:36.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NhcesMWzzFrGHhyyZJw9+4VVjbAYRBxzNLY5xS3jz154Rc1gwgpHyDL15aOOy8w8Iq6+SQuLv7Pe9X3M6JWfzbMu2S4LtVyNONaLfL69cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6210
X-OriginatorOrg: intel.com



On 04.06.2024 10:43, Lukasz Majewski wrote:
> This patch provides support for sending supervision HSR frames with
> MAC addresses stored in ProxyNodeTable when RedBox (i.e. HSR-SAN) is
> enabled.
> 
> Supervision frames with RedBox MAC address (appended as second TLV)
> are only send for ProxyNodeTable nodes.
> 
> This patch series shall be tested with hsr_redbox.sh script.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> 
> Changes for v2:
> - Fix the Reverse Christmas Tree formatting
> - Return directly values from hsr_is_node_in_db() and ether_addr_equal()
> - Change the internal variable check
> ---

Thx,
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  net/hsr/hsr_device.c   | 63 ++++++++++++++++++++++++++++++++++--------
>  net/hsr/hsr_forward.c  | 37 +++++++++++++++++++++++--
>  net/hsr/hsr_framereg.c | 12 ++++++++
>  net/hsr/hsr_framereg.h |  2 ++
>  net/hsr/hsr_main.h     |  4 ++-
>  net/hsr/hsr_netlink.c  |  1 +
>  6 files changed, 105 insertions(+), 14 deletions(-)
> 

<...>

