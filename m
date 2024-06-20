Return-Path: <netdev+bounces-105129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4190FC53
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D391D1C23751
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B626364DC;
	Thu, 20 Jun 2024 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1ZAxqLwh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="luBhSNOn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B522EED;
	Thu, 20 Jun 2024 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862559; cv=fail; b=NuQcExFliptp1si0oNt1+iJeOPZ1Y5xEaPNZThT97S9UQgp2J/5VJxVI8w81LJ1l/hmQIhM5p1aMCkGhKZfvgt295Oukk9HqidC4aKuaxzmhJ4p7K6P0oqb0CrbvTqSFezJjfAZIKZrEAELyla74lQ4HH92cP71QVORokTo1mp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862559; c=relaxed/simple;
	bh=Ed94cFAbEilIprkInsxNDMwehZNvz+jst5FDUbUY8f0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUvVIh/t8/eae7km2gs+hAclLMezaH+KW0pHaRsGffuuX9eg5FmyMXnHBPU07ck5yaGaN9R7hocP4a9XHAFjpgvYdR68Ufne7RegbFkwV87UmyIQWSPx/Wl1BrUFuloSsISj1I6bTsZBLNA+N3lBtSL3wm7Z6pPS1/mX07RfpWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1ZAxqLwh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=luBhSNOn; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718862557; x=1750398557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ed94cFAbEilIprkInsxNDMwehZNvz+jst5FDUbUY8f0=;
  b=1ZAxqLwhHR3BK67/XFLgZu9CeVV8mrXHl1jBFpcSJF40ajBQ5dFe+V6+
   +bretGup6skdVEXwVr83TERxQcEMAclvvr6htS42KWidHORL3aJcgO2TL
   D8K+k18N8i6RAkr+JgmaZZlJ9byn73+3pGU9pi5j0j1qrrs+LPRTEFAba
   3T9p5qgKkuW2tnKZv5OmO1/ya//tv6kxion94gZ10/3j4GGnG3QO/V/76
   6emolTvPb21WDLJFFgdZNoL/OA73uJlYpg5Xjd96JeHgxaHOpRRWgmHWe
   y/cmUL+cMDQ46ExkgnwbfkFH+JOLVMMkJsw/V0U51VSYYG5j+1zaTeFWr
   g==;
X-CSE-ConnectionGUID: l9zaDWOaTnmRX4FJbGh5cQ==
X-CSE-MsgGUID: LrYwA51UTT+uGHHh4q8ZtQ==
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="28902851"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2024 22:49:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 19 Jun 2024 22:48:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 19 Jun 2024 22:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9iku1jHQyfYwkaDahrwf3sJtGC/g2+WfH7l5XtFoVKeXDg9jxeRBs/EzSBcO4b1s0rQSAFgyTVBk3CKL2kdl8TiahZ0ltJtV+ljAHZImWDdq3gWyyn7uYCqRkQtpPNGo7nlseUoL/wegHpZFCueLjJJG9TyaMUfElUd9bFx9VPaOvKJE0jFCTPNuFBmIhWh6BVM5/UEjOQbaRLmH/rF2oDb0asxDoiX/xZFNZqBqhzLsLydbS5mBQ6tK3tCxAxSlOE3Jf/d6v5bhJCLtDLaReVrjapP8vL4nZQKrboF8+gu32RWMXQQ1gsLbgaY97iJD+391fKssz6MI9Ht8krqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed94cFAbEilIprkInsxNDMwehZNvz+jst5FDUbUY8f0=;
 b=mU362Yhe9KQHCN4+oCE5n1o3d+/U0Q2F5G9cO3Xxr9y6DeqdPwOX4PTWba8Cdt4vcxeyCEkQ6sgIeP4otjm2CzjhSf71sG0lFZmwVQb66Q7RN4+N9r2yk14X7ne4AlmgfXtVGy5wfqcYc+5wQZzb9dryx0O8q238TanHE1lqchMDbuVh0PE0WSN1A+utxul1OFvZJ7ZJCYW8GVBSullVHXSsjhEOOH+dEriVKNMzPzMmVpmtqscYFUArdFZitGOnX3rXex9XN8Kj7eTyy79IraDgaf3YywHFQnl0eTbuXfz2tD3PAwe+czRKC2x20E3zcYkuV3BHv63c/4TOnBsnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed94cFAbEilIprkInsxNDMwehZNvz+jst5FDUbUY8f0=;
 b=luBhSNOncWN5ZATB0l6E67dm+1+gZvVBAAKpzrlrzi2RyqsJwxxkNAGUvOGH+g0aIvzxOfOZvtol9X6i/ga9SzzrGGP3BDZo7IBfE4AkCMnyICy1PzP8zrnKlEIY7YNL/tMZyow/OJdB+RQ95Rk3TDa56sgaK1CyyKg96CDmpHz4BY8Sa2QTsBzDVc6gnaSeq3JIHgZaBOztDkAbAib3bxiw7I8y4/ANqCdY5KkXxxHb+CcJpnTSqPtPeYW0fupsF3GfEjmPcFqI3Z62fBjsPqHTYgGMU4K1Lke/hyUp8k7ZsTcT2n6527DTkThlT5b8905H+UvD0qToYNEu8AOipQ==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 05:48:31 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 05:48:31 +0000
From: <Rengarajan.S@microchip.com>
To: <andrew@lunn.ch>
CC: <linux-usb@vger.kernel.org>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <linux-kernel@vger.kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>, <kuba@kernel.org>
Subject: Re: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Thread-Topic: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Thread-Index: AQHau+QKS3/WRMWFLkKW/F+crLJ6w7HGLayAgAoFDAA=
Date: Thu, 20 Jun 2024 05:48:31 +0000
Message-ID: <06a180e5c21761c53c18dd208c9ea756570dd142.camel@microchip.com>
References: <20240611094233.865234-1-rengarajan.s@microchip.com>
	 <6eec7a37-13d0-4451-9b32-4b031c942aa1@lunn.ch>
In-Reply-To: <6eec7a37-13d0-4451-9b32-4b031c942aa1@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|PH7PR11MB7025:EE_
x-ms-office365-filtering-correlation-id: 67333875-f1c6-4406-6fc6-08dc90ec9e0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?MWR1NENJQWxSc1dZUlgxN0RMMUJzenNoWTd0bUNqRDhMQm5kc1BGWEkwbTF1?=
 =?utf-8?B?c3k0MGxhRVJkSGg3MnQzVHBNc0JST1VUNzF5NkE5L3VYWmM5R2Q0dzJxWFdY?=
 =?utf-8?B?L2ZaeWkrNE01N2RFUDhOS2xGenJteWlWVDYwV1ZQTmw5NlgzYVozSEoyanl5?=
 =?utf-8?B?MHMxS1N6aXI5SXVCNElZV0g2d1FFWGhwaG50RytoWTVDY3VEcHQ2Z05FZmwy?=
 =?utf-8?B?elN5b3cwN3ZGcmgvbjlZTFEwQjNveTBtYW5qczdoOWJYN3Y4ekV0dWRJeUUy?=
 =?utf-8?B?VGZyYVRPTjVhRnpHVithd0lBRDZMaEl2cG1XVHU3T0pJU2hUdkgreWFlRHhl?=
 =?utf-8?B?aUpjandZRTUyOFAzWU0yQ0QvSHlkYnNJblAycTk3VGdFSktUbVh6LzlpTFhE?=
 =?utf-8?B?Q3A1cCtKZ0VWOXBVcm9yY29oZU9URnhDK2lNVFJwdmVJbitaVC8rY1BPMitU?=
 =?utf-8?B?VTlReXBjeStFY1BqN1NkUFcvN1ZKQUdZcUdZeXRVZk83aTJ4ZTN0Q1ZoTWxJ?=
 =?utf-8?B?cHNjSUpvTmpuQS9ZaUR3azVkZml0N3hRZkRCRmRQbUNtZTd3RjkrbFhJd1lV?=
 =?utf-8?B?M0lFZmU4cHQrTVJnVTR5ZVJaQzBiUFVHaHJ3U2NRRGplVytQOTEwSmVXaW5y?=
 =?utf-8?B?cFVLUytaNWJTYWNDVFBjNmdNMk1mamsvSzlXb21sWjN3SFZtM3JUYWtrU3Ev?=
 =?utf-8?B?cDdNTTR2QitzL1daOHBsUzJXRWkyMW0xcGtVbC9tWjB5bXZHRXYxUXB5dHhP?=
 =?utf-8?B?Z1g5WXZaY2NhM0FycVpHb3l2SjUwVlJqb2l0dldDY05GRlZFRnhIN2IxWFpL?=
 =?utf-8?B?ZlBQbVBSUlZlOEJYK0VZdkZoSVF4eDJkSlMya05zSVpnMXI3eHYxV2FOelRv?=
 =?utf-8?B?b1NHaFlMSFY0TUl6bitQUERYc2J6UnBIU1pWWHdadk5QWTRzT2pyTjhxODFr?=
 =?utf-8?B?Q240czJ0aEd2VlYvVmJuOThkR20wMVhua2xHZXJNYWEzRC9XV1JXOWpabVBn?=
 =?utf-8?B?ZHA0WXY5RzBKWENySW9Pb0JicEpQQ1BQaUV3dmZlZ3dVT0hTMFVCUXpJSGFl?=
 =?utf-8?B?UXpRdlRIdS9SdmRDWklVTUM1eTc3dVZOLzFXUmtWQ1J2R0ZtSHRJUTZKSjBx?=
 =?utf-8?B?NHNZeGsrdGZGRUx5MzU0MkNUT052UGxkSW5OMGdPY2JVZHVEdGRXazJLeEtz?=
 =?utf-8?B?eFpjY1NUb2NZVjdGd293bnhSSzhraTk5N2l1bDJMZXRyQkc2MlhSTmU1Q29B?=
 =?utf-8?B?cXFqSWNiYWphcEVLM2hERVlWMWdKcVpoZG1scU1MVVZVS21uT0dlaHNXWkdU?=
 =?utf-8?B?NTJibGJZN2VKckkyNTJHeXFQa3VIZ21QdGZCVHp5MHFVdFFnajBKL3d3TW5y?=
 =?utf-8?B?UVZBTzRlODczeXlJaEh4alVlZ3I1WkduTjdXaCtUbjlhUUg2enNwUHNEY2Jo?=
 =?utf-8?B?ZmdkTDlIS1c0ZmJ0eWQ5MERYdHM5OGI4RWRzcmFTWnY0T3lmOGFKWFh5ajVC?=
 =?utf-8?B?N1MrcWJmUkxjMk94RjlwM0hXaHIrVnErNXcyK3R4VHlMeFl6ZHdwR0pNL0Fo?=
 =?utf-8?B?RWY3aDZUQndqMzJiU25hRlhITzVudjY0M0tFZEdSaS9ZOEsvSi95c0t3bGZ4?=
 =?utf-8?B?UzNuVUhkdUtKcEtwRGxUaGcyekdVUE9PVExNZThoT1dBRWF3eUYvdjZuWkFF?=
 =?utf-8?B?d0o0SVVpWGpmRU9MRm5tTkNla3RvaFVaOFgwVkZEdFVPdEd6V3VVazBRK3R4?=
 =?utf-8?B?ZnMyditoeW43S3dKdURVekkrdmhJaFMyT2NtbHlEc3N1VWpySGRBekd2ek01?=
 =?utf-8?Q?o9PLLBzuzCpFoViQ/jFPdpENSIk9W9/R1DYYY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzVueEl0RkhZcTRGZFYrSjVJQmhLNFVZOW5RZDdiVUhHYmxsNG5PMVYvZjF1?=
 =?utf-8?B?T04za05KcE1iYWJkbUNaMXYyYW1qMVVpT1h2alROcktscGthdFNLUVRPYWFD?=
 =?utf-8?B?dXNHa3VKR1FJWjZ3TnRIcVBLck00NUdKcWZ2Vk04S28yZ0lmQ2tSU3gxVVg5?=
 =?utf-8?B?VGx6QWluWG96Z1VuejhaeTgvWFBleUFXS0lBb3FvQnJ6Zm81Z0FlN3RERUVr?=
 =?utf-8?B?ZmYzUnQ5KzlUL3V0YkRwbVNMdmV6cElSY2p2V2t0ZGxKZ0JnUzFsbDZEZ25s?=
 =?utf-8?B?dzI5NzFBSkVpMVFJTVVWS0hiNUVJTUtwMVBHUjJCcTVMRnpmc0h0dFBHQ1pv?=
 =?utf-8?B?cFRqSWJtZGI3c0V4MFVpdjNJd1NRRzZMWUpOZk94SEV5dlZURkJkeUpvK1B4?=
 =?utf-8?B?Q1QycFBXOStFNW9HSVUzbGdxNnY0dUdPM0hPNk1NeVlYYTg5dmFuMTlFVVh5?=
 =?utf-8?B?eGMxRkE4dk16WFl5Z2syWi9yVGM2cVVuWVBkeXlYeWdpOXo0M1IyamM2S29U?=
 =?utf-8?B?TzdwcUFZNWpNaGNmRlVrNm5BcDdnQjFMSG0yM2RSOStOWWFwUk1OeCtNVFhC?=
 =?utf-8?B?eVNKQWxYZFdkWVFNcUVoOWNpVVdwV1YwTDU4SXNDMGgxWG5ZQjg5eTF0TGky?=
 =?utf-8?B?RmZzajU2L3FsU2VUMktQS2dXcDBuN09xejJXV0k4VllxTVl0MFZHVlVVTFE0?=
 =?utf-8?B?c3dkcWdydXptTjYxdXpiZE9RMnhPTjIybXd0YXhHc2EwUjArRTJka1kxVkV5?=
 =?utf-8?B?ZDMvekpYSjUzL1ErZUhuR0lsbjBvU0hUeVVnZFdTT0tlSW8za3hKVW9DSDNH?=
 =?utf-8?B?N0hORGNpelg1djlxOTRpMXBuNzQ3Y0FnTmRHdktvSnByUXRMU3NXdWtwL2Nw?=
 =?utf-8?B?ZWdmM2cyNGtvek9pMFhKY0tYTVhDcC9DMmVEbzYycnlRRzFzNzk2eE5yZ3Bk?=
 =?utf-8?B?aHV2L29YMFhRVzVtS0Y0VzBmclRyc3c3djcwYXVzZFFaM3R2YlJrb0pvMFdU?=
 =?utf-8?B?NTJWL2ovcVRuS2ZReUQvM3FTOEdjVllyN1psM2lNRGRiUkZ5aVM2WWE1ZEYx?=
 =?utf-8?B?VFN6K05RZVZLd3R4S25sMkdBd1V6a1JkUm8vbitjdEUxYjNWZXBxREQxczhz?=
 =?utf-8?B?OGNYazNtSm9STGhGaEhGbHVodTBLRzc4eUhnVE44TlFrK05oRlpDb1l2SzRH?=
 =?utf-8?B?TnBtOXdLcFJSUkF0NHE2UHdPSlRDaWY1ZUM3WGRJRmlJNS9WMkYvTW5XUTBT?=
 =?utf-8?B?RFc3anZqanpKQlc5UHk3cm1xK2lPejFNTkh6ckIxTzFOV2xzSkhmV1o1MVF1?=
 =?utf-8?B?eU9zRm1ZQlJhQS9FSHA0aklPNmEvQ2ExeFNUN1ZpWmY0OTY2VkNMY3FEYXg5?=
 =?utf-8?B?SWVVVGIwRGZaRy9KMDZZbzhVU0NiUmRpNjBjMzZqMTRBNmV3OHJtQXdaZHRv?=
 =?utf-8?B?RWhEWmlPU01qOU5kVm1JVTJHc2czQVAvek1HVERmU0wyNmFobTNERUM4ZHp6?=
 =?utf-8?B?YU94dUtmVTVHYWFZVWI5R2sxMmNtcVBVZGpmdk1Db0JnSVk3dG9ZRWFIckZl?=
 =?utf-8?B?SXc4QVp3Q09yM001aEZKY0VzNG1pMll4YkhOS213QmU0K0RjSVVUY3NISXdV?=
 =?utf-8?B?Z2F1eGlUZjV5OGJFMHVWRzUvYjdHY2FvTGl3bVJFdjFHRW02NXB3eDRMeEJX?=
 =?utf-8?B?TUxRLzgzSEtiUVdqWUpHSEhZNE9qNWU0bkxlRE8yRlpsbVJ0YVA4SlZXOGFx?=
 =?utf-8?B?d2Rtbmd4MjIwNWFsb1d3WHNzTTRQZlh1VFJFWFBnYjlyZnVhRWtDcVFQTVU0?=
 =?utf-8?B?NjdmU2dTREFyOEFaa0FYNG0ybWp3NDY5Q1M5SHo3ZmtPUnI2YzdYNW00K3ZK?=
 =?utf-8?B?dzY1WmZ3VkZWeXY2dTNYZkFWR3EyamQwU2Q0cDl4bjF3ZG10VlRpeEtOUG5y?=
 =?utf-8?B?OUxjVnZYb0VnYWd6aVlqT0lrRzdKR1ZsSlAvYlpEUkZMS0dhYno0M1VxNkY3?=
 =?utf-8?B?TXpzbyt2T1ZLTGNMOXNZQW1WQ1k5M3gyakN5UHFsU3JyU2U1dFNWWEhSc3p0?=
 =?utf-8?B?OVgxelNFbTExWkVxL2lqWUw2d3B3aVFIWjJnTmNNY2syYlpHbm5zb1ppVG5O?=
 =?utf-8?B?WVVybWt5L29OZS9qTDhuS09JZ05PYWdybHVXYklyeTBGUFFiMnlHMUpHRmZO?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F44B457B854AB48AD6348502BFA2B2D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67333875-f1c6-4406-6fc6-08dc90ec9e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 05:48:31.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aesCgpGoUWv/Hfm43bOgntQVa9x1UxRQSHseuMyBaLrgyRyVAuikilRmWQH2KLU31KCh/9nGaXDWkPZQaE/iDQuAlr4GSAdw+/KCkRyjMN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025

SGkgQW5kcmV3LA0KDQpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiByZXBseS4gVGhhbmtzIGZv
ciByZXZpZXdpbmcgdGhlIHBhdGNoLg0KUGxlYXNlIGZpbmQgbXkgY29tbWVudHMgaW5saW5lLg0K
DQpPbiBUaHUsIDIwMjQtMDYtMTMgYXQgMjI6NDYgKzAyMDAsIEFuZHJldyBMdW5uIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgSnVu
IDExLCAyMDI0IGF0IDAzOjEyOjMzUE0gKzA1MzAsIFJlbmdhcmFqYW4gUyB3cm90ZToNCj4gPiBB
ZGQgbGFuNzgwMSBNQUMgb25seSBzdXBwb3J0IHdpdGggbGFuODg0MS4gVGhlIFBIWSBmaXh1cCBp
cw0KPiA+IHJlZ2lzdGVyZWQNCj4gPiBmb3IgbGFuODg0MSBhbmQgdGhlIGluaXRpYWxpemF0aW9u
cyBhcmUgZG9uZSB1c2luZyBsYW44ODM1X2ZpeHVwDQo+ID4gc2luY2UNCj4gPiB0aGUgcmVnaXN0
ZXIgY29uZmlncyBhcmUgc2ltaWxhciBmb3IgYm90aCBsYW5uODg0MSBhbmQgbGFuODgzNS4NCj4g
DQo+IFdoYXQgZXhhY3RseSBkb2VzIHRoaXMgZml4dXAgZG8/DQoNCkZpeHVwIHJlbGF0ZWQgdG8g
dGhlIHBoeSBoYW5kbGUgYW5kIG1hbmFnZSB0aGUgY29uZmlndXJhdGlvbiBhbmQgc3RhdHVzDQpy
ZWdpc3RlcnMgb2YgYSBwYXJ0aWN1bGFyIHBoeS4gSW4gdGhpcyBwYXRjaCBpdCBpcyB1c2VkIHRv
IGhhbmRsZSB0aGUNCmNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzIG9mIExBTjg4NDEgd2hpY2ggYXJl
IHNpbWlsYXIgdG8gcmVnaXN0ZXJzIGluDQpMQU44ODM1Lg0KDQo+IA0KPiBMb29raW5nIGF0IGl0
LCB3aGF0IHByb3RlY3RzIGl0IGZyb20gYmVpbmcgdXNlZCBvbiBzb21lIG90aGVyIGRldmljZQ0K
PiB3aGljaCBhbHNvIGhhcHBlbnMgdG8gdXNlIHRoZSBzYW1lIFBIWT8gSXMgdGhlcmUgc29tZXRo
aW5nIHRvDQo+IGd1YXJhbnRlZToNCj4gDQo+IHN0cnVjdCBsYW43OHh4X25ldCAqZGV2ID0gbmV0
ZGV2X3ByaXYocGh5ZGV2LT5hdHRhY2hlZF9kZXYpOw0KPiANCj4gcmVhbGx5IGlzIGEgbGFuNzh4
eF9uZXQgKiA/DQoNCkluIHRoaXMgY2FzZSBmaXh1cCBpcyBjYWxsZWQgdGhyb3VnaCBsYW43OHh4
IG9ubHkgd2hlbiBpbnRlcmZhY2luZyB0aGUNCnBoeSB3aXRoIGxhbjc4eHggTUFDLiBTaW5jZSB0
aGlzIHdpbGwgbm90IGJlIGNhbGxlZCBvbiBpbnRlcmZhY2luZyB3aXRoDQpvdGhlciBkZXZpY2Vz
LCBpdCBwcmV2ZW50cyB0aGVtIGZyb20gYWNjZXNzaW5nIHRoZSByZWdpc3RlcnMuDQo=

