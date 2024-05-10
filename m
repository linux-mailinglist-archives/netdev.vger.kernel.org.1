Return-Path: <netdev+bounces-95419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE6B8C2323
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D90A1F21B77
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08CE1649CF;
	Fri, 10 May 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0Pg+pYmU";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4kGjJbjT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EFF16E870;
	Fri, 10 May 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340168; cv=fail; b=DR3GuoCKKGE9bqxFvMpvMGb6Q/F082vz/xVqnQAiQ9Y+JUD6hkx5iyLWjR0SeqJkptD1ewo+8vwi2yErNG27lwNghB+MUgQa3YjxJhLpNAjvvaa3uzb2WOmBTQSycjQ9KEC7L7KwKhLtoOJOZazjetRFDc3i1zsBkpngH51NT+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340168; c=relaxed/simple;
	bh=6FDQz0HmpaAxEICHM++DXEF97rcqFazZlqzTg4ag6Bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+fE1Gkc8HzPNJ91W2sJ50BrBP8rvN5wYyTZU+2bIG1+Gg/yKMPQW3y6XpCOoU5yT5+cxebWanhhHRp64+7vm4OB5vpTOIOzG2fwtzp3GvgxAqYFJXEsdA1omCv2+4Dp2EWZCw47KgJUc0/ZNKQpQtSSN4KflP8v4O58V6hh21Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0Pg+pYmU; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4kGjJbjT; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715340158; x=1746876158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6FDQz0HmpaAxEICHM++DXEF97rcqFazZlqzTg4ag6Bk=;
  b=0Pg+pYmUAMOM4sXsFEvEgOZ+K2a+fcehhED+MkWkNiJpP7NJoilLTiMe
   F/NYjnp4iBU5kvm3PBQZt5hBRKRONvuvUOFHVkm3OwUOkAKouM/hK2W4b
   SDY+q4Gc8TWMbUhcrhkdBrTBrkWQgslxvQbCT3o4NDEcQuq+jaW9r87Gh
   qzSbxbcNfk6pTAvoLtzfmqQWUupljVRC6D4Ze1T/15v4GQsqEsuCygdeb
   JE/ANS2jbX5R0Bd2vDCKygDgZbsfXwontcvKFB8MszKqArepddiCbtbQv
   Q5JT2uxyGKmT3AhUBuVSN5at5kg1kWmToDZ3ywOlFebm+9N7swJ+pryiI
   A==;
X-CSE-ConnectionGUID: IEg3GsvqQ82QyOf2pBrXgw==
X-CSE-MsgGUID: tCyEAJmZQbSEGF9nPb5KNA==
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="24390116"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 May 2024 04:22:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 04:22:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 04:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPUqkb9Ti+LcQ25Dh9+EXXp/WkalizARqiRHErPFGquN0uXvuAIV6glb32zozDgIiAhl4pxv88x+t3fnix5ntncknNI3fnJ+T4ihQkecyjf8eSjyZdDlhUX4hM1Ovd8AdOhzruou066T9CiK34NkvrQ9TavYyrA+MnZv0EE/vrZwqn4Vs79yP5mqyEgaSHb08oFMHwtbLRmWzknWGQtp61mYYgmzi53buOb1RjQ27A6ybH2X0RxYRec5ASqNTtaHeSZqYbW8FQe5stPn+N4HucoB+2hx1xbTbWiH2mAyOtktpzl82T/wWMTaYaYOMKKrSqQzq+dXzhSoDLSpgPrm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FDQz0HmpaAxEICHM++DXEF97rcqFazZlqzTg4ag6Bk=;
 b=V+SehqVLyPuHplBpEmQmkspXFTmiQrvrZAz7ymMQMneWBJqoZBCJF6Py8UALECSmstGiHcM0xL2KUDGAYqjypZNJGOD5Macr37lR/oet9FYa6cVEm7LwIJQUUG0vsj2CQmKScRtUFtcVpDJYXUR3zjf0g9ZDmdI/CB/BN0Qvcu8cO+D9AGxfzg2vD+KYTfVJT6OZd8hujfnnQxpG44/H1PtRAsATYnS0qhg3nPIeJhNG/AFNZc2aCyMuM9I+KyrbFqzMUkOa802V2rIVLdjl5aOKNAPBzWx55qpHtcR7LlKXulcUegNdzvQiRdKRJi3c4xIOdpTPV8+pHtNxzAGefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FDQz0HmpaAxEICHM++DXEF97rcqFazZlqzTg4ag6Bk=;
 b=4kGjJbjTr7M6NfYU+kSTfwBhRHl1JFxsPgzaJz7K3ch3Q6FcGf25toReya4i7UdOvt8ooxqeny6gHArrrEzA8nT5Vt9655mB4z5l2pchNBWtvyQ9Vmji0T2TgnoYFJ7zbePE85PhQ4axgEP1Hjebf1iptIiPBIT7hxDfwFP7fBpBir3SjdnELDTwYAMfwNgnigIxsfhijw0Q0YShxjeJl3NMvBm+Q7gnH1A6jevwZLZuzBzdGPakdwZIkX95Taq+t1g1/H+zNVbeH5T2GnC5sIzQku+WEwEOmEsPi+8Y/Z9TVwjuO7rsIzy14VOyqQAXd9BQyAmRhhzZS76sT1k3wg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH0PR11MB5093.namprd11.prod.outlook.com (2603:10b6:510:3e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 11:22:15 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 11:22:15 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHakY/2Zb5TFJZ12UCHjfgce9+PGrF0voeAgAA2YoCAGHimAIAAQu0AgAFPUYCAAH8FAIAA9qQA
Date: Fri, 10 May 2024 11:22:15 +0000
Message-ID: <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
In-Reply-To: <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH0PR11MB5093:EE_
x-ms-office365-filtering-correlation-id: bc9e2549-099c-4bab-927e-08dc70e37210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dlVzTU55V2s1QVpYcHliZTdQbTBpdUoxaHRobis4Nk8rV3RtVUJPd3dvSk42?=
 =?utf-8?B?U1JVckVmRjVVRmlDcjNVY2JCRjVvUCt4eUVQTEt6d1NjbFYzdkxtMFlHODZo?=
 =?utf-8?B?UDlPZVpycWg0aUhPaDAybEo2cHJUNlROWWR2R21vMm10V3ZSMStDUVJYZGJI?=
 =?utf-8?B?ai9wVHhnNHFHUkp3clJrdnlZUURWM0FTMmtLVDVzc2J0Yk5xdFJJQkJMYVhO?=
 =?utf-8?B?dUE2S3VlcXZkbE1GTURScDZhdHZBVUFTcFpLbHhNNktMYU5TeGx0Wlg5U3lz?=
 =?utf-8?B?bXNoZ082VkUrdWoxY3J4cEJPVWFkTTJ6eEdXNzM5aU8va1QyVXNxMjBPRU9u?=
 =?utf-8?B?enpjTVh3ZVdMM1pzbFdLUnNJT2s4VTFZc0txbmlVYkVuL2pUUWsvbVZrU1ps?=
 =?utf-8?B?TTRhakw0anExdEF4Mkg4anJRTmgyb3VUNGJKUHVxa0ZUSi9KQTJiRHk0WDhh?=
 =?utf-8?B?bmRNK0ozaGpRVm9FNmc2cGZiN2RqTkxJWFJGMVlFaC8vZlVFMTZveEZENll1?=
 =?utf-8?B?bUVRM0NLSW9hVHJmRG91ZDVwdUp5TjNKeUYxWVRSbmJraEdNaXhRZWlMaUta?=
 =?utf-8?B?cERXVnlBWStlMmdJZHpmRTgwMGZUOG9yQkc0bTBQTGRqbmRWdzM1aFJPcFAw?=
 =?utf-8?B?WHRQUi9LSUZyRC9BOEJZVkZlV2VQZEJhMm9kQWg1QnM0VTlTN01nekdzUk8y?=
 =?utf-8?B?bWVtTlI1TzdZbnljRE9hOWVnVUM3elhBWDVlMlp3RmlpaEZUaXloZ3ZpeVhP?=
 =?utf-8?B?QlRYb0Y2aU5PQ3laYkRtUzUwRlM3SlFtT3Rpa1pwRzlMRXFvVzIvbEppTlJH?=
 =?utf-8?B?S0k5Q1IzMGk4bzFGT3BhQzd3bUsvakVYbmh1bndpN1V1QTh6UXJkQjhReW40?=
 =?utf-8?B?Y0wweG9TZEg3cDB6RzlxM20yZWsvZ2FMYnY1TGJ3WXdkWlU3SFU1cEJjbHQw?=
 =?utf-8?B?YjcyWnZ2SHJrYXJWdkJTWXJWTXAyU2MxbVQ5TXUwTFlmZk8wN29pTWkxdGVP?=
 =?utf-8?B?d3JlQm4xQjhDOU4ycTZrWFAyNUxid3Q5Rmt1cHMySjAxYjlENC9LczF2dWhO?=
 =?utf-8?B?OFQ4QlFlZ0JtdURDMmNTcEUxampEYVZQWHBxYVJ4czhDSkdxdnVvb2lWRTZi?=
 =?utf-8?B?cEMxT0NDYmxMdktEbzkxZXU2K0kwaTdkRXVhQlZBN0hoVlZhdEhYMmpsK3A5?=
 =?utf-8?B?SVowTGd6OHRpc2lEYUJnNXV1dUlmcnJhRnJabVBXVENySzVQTUtDenQzTFJJ?=
 =?utf-8?B?UDNDSjdLUGwrMXEwQmh6RkJkRTBHMEpPRlg5TmRDcGxSdVQxQnFEVGxraGZi?=
 =?utf-8?B?OXA2QmkvRGU4c1puZXVKQmZjZXdlaFVRZ20wck1IbnE5OE9iN0ozSlVadXcx?=
 =?utf-8?B?MXJ1MlV6S28ybWZDbklueU9Md0x2VDNFb2pwWjR2NzkrZjlkK0M2QmU0dHZz?=
 =?utf-8?B?aWQ3UlVSL09EM2tBRCtZbUthNnRpQS9vVGFsYnNBcmQxbmI5MUtJb01LMGZS?=
 =?utf-8?B?Nm5XMjhxWnRnNmhmQm1UYlhxb0owQjBFNE1nRlp4VzJYWWtzNVFPNGhZUE1L?=
 =?utf-8?B?S3FNa3F2YjhuSCtvQXZucDkrdG9XOTZsc0NUeFRmSFluKytONlMyUkN1eW51?=
 =?utf-8?B?d1ZGZGpzY294dFFnR2lKQ3dtbjZNb2xra0sxbGFQTTZIWis0c1BhL1pvVEJw?=
 =?utf-8?B?OFVIay9NUUgyeko0dlZHU2N6N0VUTW41WEJiK3B1TENrNUViZWJEZVhYNzJi?=
 =?utf-8?B?MUpSbjcyYXF3c2NZQ2lMYTVZWjJxSUhock5RUGxJZCtlZlZGVktSS2JTYkZu?=
 =?utf-8?B?TWI3OXMycUtjUUlmTHI1QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVBGU25zTzRlbGJYcGY4UVNYb0t4RzNBMENCTWpBYWdtUDN5bTFwTUZUM2Qw?=
 =?utf-8?B?OE56STF5Y1V6TktlNG9oenlBM2NpSjdWVll1bkpENkVGM24rZFdDSTNFb0pV?=
 =?utf-8?B?VjFkTXVaNDEvRC9hR0hFNEVrZXFVNytHSnJ4S09paWQrWWUxTS9veGxiZlBy?=
 =?utf-8?B?TkRoLzd5YjcrTU5EK0tQUjNudkdHQW4rRGtGVXhyZm9SVFhYcTV3Q1A5ZS9U?=
 =?utf-8?B?UWNZSEFDUFVxSnllTGpJeG5rTW4vWEYzUEdKKy9FKzlFakRVOGN5THJZZXA1?=
 =?utf-8?B?SzlrL3ZtL0RrRFRoYzArN0NablVhNmJKQWZFeVpQMHVCREt6ZVAzZytUK2lF?=
 =?utf-8?B?UjB0YUdZZitob1Y3blBOWlg1eXkwWEVGTVFhUlpnNk11ZlowUG9DQXNKOHlZ?=
 =?utf-8?B?eVhCMjA0aWg0Zis3TzdVNVlHYzIrRDZRV3o2UlB0QjBFbW9ycnRqWmduMFBJ?=
 =?utf-8?B?WVR1VlVITzhUQktlQXpWd09ycXQ5ZHlNajFSUTEwQUdBREtKZmlLUlFDdWZX?=
 =?utf-8?B?NDV0dC9vVWxITW1HK3Q4TVp1MVV3TWhxZ0M2QUhvN3FSVG1KbXpLS2lEaXlq?=
 =?utf-8?B?SFF4VTRvdWtyMktZNDBvazRRbTFUYXpyR3NvNlE0aU5HZTZSTm85bXZuTk1i?=
 =?utf-8?B?czJBVSs0dEZsUDdNVU1SbWRPbzdhSEpxanp0RWxaYTY3OEFGbmI1Ulo3bHh4?=
 =?utf-8?B?RWNJZCsvcVJYMi9HMTJCVU94TkcvSXlQNjFPV29RbDBISDRMcnY2cmh3MVc4?=
 =?utf-8?B?a0Q0NlZZc0V3WjArdWNKS3B3aXo5NG54TTJwK1pQZ25kS3c2RDU1MzRTQXEw?=
 =?utf-8?B?T0ZHQnVoVmZPWWN6d1ljaCtDbWV5THdCRTlLUjh3VzFHNHJHU0s0S2w3anUy?=
 =?utf-8?B?NGVvUWt0SzYzbC9XK1VhSzVzWTRla0F5aHFUNzhJNGVzcTNFV1NLbVJrV1B1?=
 =?utf-8?B?dmZ6YXJYQmxvbzMveU1CVE9FcDFESFVvQ2xKQS9oNDNnZ2xsREYwVGJ3cWxL?=
 =?utf-8?B?RWsxN3VlTDNOMXFBb2hxSjlVV1U4Rjl2NnEvTmdnLzdYU1RHNHc5VXRSSDd5?=
 =?utf-8?B?L0REMmFHZ1lOUzRyL1hVUG1HNlpiT1lUeHlIWHo2TEwzTytqNmtYamY0RWhl?=
 =?utf-8?B?cUJjaCtFVnhIclBSUFRzdzRDOGNyWDB6N2JobCsrUEVNU0o1OVFTNXo0ZlBI?=
 =?utf-8?B?WCsyeUZpUFhEdWR1VGVSNXgvVis5cGorODFXeEZPY0M2VUxmenNEYmgzOFpY?=
 =?utf-8?B?MTZuVzd2dzR6NnpPQXB0a0QyL1pwYTJvZUxTdkNiNllzbFNZdUtvdHV5Tm1y?=
 =?utf-8?B?Uk0rVnNyUlgrQmJkNFNsekJYU1BDZEQ0cndUaVV6N0p5UUVsMzhTUG5qZGRV?=
 =?utf-8?B?aFI1cjNSWnJKcEFYeTlsQUhWSHo0bUN2UTRHMUsxNVF6VW50U0drQmhWQjdM?=
 =?utf-8?B?bUROSVpKaVNJUG85a2s0dzNOSHRqaGVXNU5kRmd6MlhrUUtNR1lTajNVY2Vy?=
 =?utf-8?B?dU9tcEM0b3BFb3ZlMXJkQWIwaThnWUtMVEZ2UVJ1Q3h2S3FkWGdycU9pWlhE?=
 =?utf-8?B?TTRINVN6MDczaEpTVE1hTUxJV0E1aWJxaCs5RVFoTHdRUHYzMTZQQVJsV3dD?=
 =?utf-8?B?NlczeWc5V1JnVnVKdDhHa0lyTGcvREhka2s0UmNLNWd0THJRVzlPRkk3amhn?=
 =?utf-8?B?aTN2UERqbThvS296SUc4VTZHcFZmUnNtRWp5bEFmbW8wMHBVdDdtUW5EalYw?=
 =?utf-8?B?WjVXRDhhbVBhUytNV2JYVU51bEkrVzlmQzNOTEI0UlhRSGdrODZmSVpkdnJN?=
 =?utf-8?B?T2J2ZW54dEt0WHVuU0E2cFZoeGhRa3AwbHR3Rjl2amZIeXJ3SDMvN1RXNk1E?=
 =?utf-8?B?N2lheFZ2TXNBUEI3MytmYXM2VHFQU3V0V2JpVE1tWFlhbk41K1FaZW1xd1Ft?=
 =?utf-8?B?b0FjNEpwL2lkeHJzck9zd1V3NUkvemJlbWRzaXhGdkxxUUJUZm9XcUMwVFY2?=
 =?utf-8?B?bmlaM1dpWXZzMEwwRitza1VnQmlNRk8rVFZqbUtPVTJwam9tNWlHbnZqY2x4?=
 =?utf-8?B?Yk1NcTBnRXVNU1NoOHJMaktiOGF1ajUzZVJ1cllxek9iZjYySDNITkhPSHBm?=
 =?utf-8?B?SDdSWW95Q1FIM2RvR09kVzdsa1ZaYjJPVXVUM2Z1RHVqcnh3N0JCRDEyNmhQ?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED43461C57AF9344B73D6D1030FE8544@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9e2549-099c-4bab-927e-08dc70e37210
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 11:22:15.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPzMSYJKzzX4TIEBAftthbUl+4WTfccZGuwUMlwj/ishRkN7VRUOIXNl9dLhpx8SLF05wxQ9jSLGXxHFBoRxC5TVYucz+sRfAgj+18+pnmPnpshfKTgWxDMjp3a253hi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5093

SGkgQW5kcmV3LA0KDQpPbiAxMC8wNS8yNCAyOjA5IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIE1heSAwOSwg
MjAyNCBhdCAwMTowNDo1MlBNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IEhpIEFuZHJldywNCj4+DQo+PiBPbiAwOC8wNS8yNCAxMDozNCBwbSwg
QW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pj4NCj4+Pj4gWWVzLiBJIHRyaWVkIHRoaXMgdGVzdC4gSXQgd29ya3MgYXMgZXhwZWN0ZWQu
DQo+Pj4NCj4+Pj4gICAgICBFYWNoIExBTjg2NTEgcmVjZWl2ZWQgYXBwcm94aW1hdGVseSAzTWJw
cyB3aXRoIGxvdCBvZiAiUmVjZWl2ZSBidWZmZXINCj4+Pj4gb3ZlcmZsb3cgZXJyb3IiLiBJIHRo
aW5rIGl0IGlzIGV4cGVjdGVkIGFzIHRoZSBzaW5nbGUgU1BJIG1hc3RlciBoYXMgdG8NCj4+Pj4g
c2VydmUgYm90aCBMQU44NjUxIGF0IHRoZSBzYW1lIHRpbWUgYW5kIGJvdGggTEFOODY1MSB3aWxs
IGJlIHJlY2VpdmluZw0KPj4+PiAxME1icHMgb24gZWFjaC4NCj4+Pg0KPj4+IFRoYW5rcyBmb3Ig
dGVzdGluZyB0aGlzLg0KPj4+DQo+Pj4gVGhpcyBhbHNvIHNob3dzIHRoZSAiUmVjZWl2ZSBidWZm
ZXIgb3ZlcmZsb3cgZXJyb3IiIG5lZWRzIHRvIGdvIGF3YXkuDQo+Pj4gRWl0aGVyIHdlIGRvbid0
IGNhcmUgYXQgYWxsLCBhbmQgc2hvdWxkIG5vdCBlbmFibGUgdGhlIGludGVycnVwdCwgb3INCj4+
PiB3ZSBkbyBjYXJlIGFuZCBzaG91bGQgaW5jcmVtZW50IGEgY291bnRlci4NCj4+IFRoYW5rcyBm
b3IgeW91ciBjb21tZW50cy4gSSB0aGluaywgSSB3b3VsZCBnbyBmb3IgeW91ciAybmQgcHJvcG9z
YWwNCj4+IGJlY2F1c2UgaGF2aW5nICJSZWNlaXZlIGJ1ZmZlciBvdmVyZmxvdyBlcnJvciIgZW5h
YmxlZCB3aWxsIGluZGljYXRlIHRoZQ0KPj4gY2F1c2Ugb2YgdGhlIHBvb3IgcGVyZm9ybWFuY2Uu
DQo+Pg0KPj4gQWxyZWFkeSB3ZSBoYXZlLA0KPj4gdGM2LT5uZXRkZXYtPnN0YXRzLnJ4X2Ryb3Bw
ZWQrKzsNCj4+IHRvIGluY3JlbWVudCB0aGUgcnggZHJvcHBlZCBjb3VudGVyIGluIGNhc2Ugb2Yg
cmVjZWl2ZSBidWZmZXIgb3ZlcmZsb3cuDQo+Pg0KPj4gTWF5IGJlIHdlIGNhbiByZW1vdmUgdGhl
IHByaW50LA0KPj4gbmV0X2Vycl9yYXRlbGltaXRlZCgiJXM6IFJlY2VpdmUgYnVmZmVyIG92ZXJm
bG93IGVycm9yXG4iLA0KPj4gdGM2LT5uZXRkZXYtPm5hbWUpOw0KPj4gYXMgaXQgbWlnaHQgbGVh
ZCB0byBhZGRpdGlvbmFsIHBvb3IgcGVyZm9ybWFuY2UgYnkgYWRkaW5nIHNvbWUgZGVsYXkuDQo+
Pg0KPj4gQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIHlvdXIgb3BpbmlvbiBvbiB0aGlzPw0KPiAN
Cj4gVGhpcyBpcyB5b3VyIGNvZGUuIElkZWFsbHkgeW91IHNob3VsZCBkZWNpZGUuIEkgd2lsbCBv
bmx5IGFkZCByZXZpZXcNCj4gY29tbWVudHMgaWYgaSB0aGluayBpdCBpcyB3cm9uZy4gQW55IGNh
biBkZWNpZGUgYmV0d2VlbiBhbnkgY29ycmVjdA0KPiBvcHRpb24uDQpTdXJlLCB0aGFua3MgZm9y
IHlvdXIgYWR2aWNlLiBMZXQgbWUgc3RpY2sgd2l0aCB0aGUgYWJvdmUgcHJvcG9zYWwgdW50aWwg
DQpJIGdldCBhbnkgb3RoZXJzIG9waW5pb24uDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBW
DQo+IA0KPiAgICAgICAgICBBbmRyZXcNCj4gDQoNCg==

