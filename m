Return-Path: <netdev+bounces-101232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1628FDCCE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D691F2391C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD850182BD;
	Thu,  6 Jun 2024 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tdSOBBMs";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cl4WTXUx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E0179A7
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641295; cv=fail; b=uklSuGAp9HNQjVwVWqVHuxqQCZhiz1XDLj+kWVgO3xBYSrePK6kQnS0k3PuyqkiG6myU2nv2/u7gmM5bf18/dQMlehUve4SMFItRHqeEU4Eyt1bg8OPFfKdCfKVp3XixFevcE+HjOTYDXT+T5wQCPp8mk4/NTqP1vH8IfSicCM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641295; c=relaxed/simple;
	bh=wCMnSIo+XIRm65htzOBH0p88UX27bKpR99/KbO3H+FA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYkVrY9nfyeG0SiRFXNHZNmSq1DMfzlik3BYZZRInzb3ovYq+2Jj11Nyn3Y/nAiUiKko0AXwArzSC/rMBnPtA6csa0OFEoPnaRa+WASN4ad3bJom5f+qBEAHpE4DdhTtWlE+Ycyt8xObZzQAzN1821l3QmU8nMm77ykZRLZY0Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tdSOBBMs; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cl4WTXUx; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717641291; x=1749177291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wCMnSIo+XIRm65htzOBH0p88UX27bKpR99/KbO3H+FA=;
  b=tdSOBBMsUrCxilIei31zuJkJ2HXs8iKBKl74LN9Qu2bfSxz7MeKwsJ32
   UdfueQ5GF3B2UWpyWTitbtY7tUF5hBtDxIgcX3xaHoKuTqpVr/JOB1tio
   suskVys0Y6bMxe2hm4KCdJkYKZ2cu/P1cjcoatSGAf9qG76WjM1QAGJUV
   78sp79tIKXvr9heXWC2uCxQ99ycwTRGEA9gQbsEAYFn1pk+6iiBj+IS8V
   AEZEzp5Gi2hdfgAXxb6qY7RSK1+dc5EY5DvovEOhxPq6vuLEmQBiCXhlN
   vUwON8UU6zdTUrZuwqXiDEmqaf8ku9bifHoCer59hisZjf0Uwi55/vTYg
   w==;
X-CSE-ConnectionGUID: c1a4sO6eQpiyT7ZSzWmVHA==
X-CSE-MsgGUID: xCRiSrTLQ5WtPNHhq8RZUw==
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="194447489"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2024 19:34:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 19:34:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 5 Jun 2024 19:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9u95akNNyZwc75svW//rVXLM04DcXrljKUMUSpnzYpEHQduJC93WHFB150UHLLn6RpX4bth/NglbRxk0Xe8YzjOCAHXbZHbag6FD87l1d5XKozBokDMkGxjHGhtiAWD3AazSatrvf+htuqAV3hpAI0O+addxvKsJje6LbqbkirVMb5a2G9XL8HyaydqDTgM23EhVS+iww+IfcsaFC9mgIkxHAEiku1Wjulbo9gS7n2JdJ2n3rdSnrCVWzxbpfFT7OF2OwZIaFn6/KWrOv9LXg5BGz/cM9DTd0ndn9EveviXRXvhyu/L+KEwtwkwmIq40mFtZz9SSeeYjzwgTQm19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCMnSIo+XIRm65htzOBH0p88UX27bKpR99/KbO3H+FA=;
 b=mnhOA2egJoWS1KfRplFtEFpu0vwneXYf84f5WxbOKj/nawDS/tg9UdDg3vcaeA0lIofEF3PL3aHHUPtDjXw/mCc2xB5mDelE9VHNKmKwmG4taQNMu628oFCn3AUw6ZfrLPxa6lXPFW9LV6PvM2aWmuft0bwxL1/c2xUY7ifYqkti0ABgqvkTRZfsVVbjCDH9JUFCFgYevWLWu268A4tEhF+6JGNEZKw/6eYX+BFAvOz5pRiyCcLtBBptuoc9iLpyoau7Bjfa7cpLZzqIOfkzd5XHK1GSFPoD2TmSDwnODS+FFUnSOK9DttVBqvE22sCY43qwiwuAZ0dZcNgadM7lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCMnSIo+XIRm65htzOBH0p88UX27bKpR99/KbO3H+FA=;
 b=cl4WTXUx1Op6+XKWx1zlU2d7c8pnvrhb+ve/q40cZwmVQFfKAfPX5zMB2w8tW/XXf7SXtSZl3r6m0KoFFpAgF2bafVSBYwbbo44ybMkPl3joVnczjtJH/h56e4Md/jbLbpbkqiKxOfskDweNeU+OYB4bd75ifEFouF9+TWRRWIh9sA6I8+pef6aRKVsyVR8PGcsxHVDIc4Me2ekktQen6pJ0pyaGc1mDqGW5lEmZUNGWopWeWTq98aCApobBa5mAxoKDDiJydSG3fFlCwrjrmiJHPnk3iwtZTU0mHfAaoV0MqnZTvk1vzwSIbyZTIEaIJut7vBzttq/yDw6UN+YRfg==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 02:34:11 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547%3]) with mapi id 15.20.7633.018; Thu, 6 Jun 2024
 02:34:11 +0000
From: <Arun.Ramadoss@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <linux@armlinux.org.uk>, <horms@kernel.org>, <Tristram.Ha@microchip.com>,
	<Woojung.Huh@microchip.com>, <hkallweit1@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net v5 4/4] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Thread-Topic: [PATCH net v5 4/4] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Thread-Index: AQHatmDvhM1pPMRFbkufEkdpo/QqJLG4hY+AgABItwCAATmSgA==
Date: Thu, 6 Jun 2024 02:34:11 +0000
Message-ID: <c9185f96a613efdcd907797fb786ae5ee3796201.camel@microchip.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240604092304.314636-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <4a3070182e56ca21d9e07e083f30f82c1e886c3f.camel@microchip.com>
	 <50530d02-ede9-4e59-bf97-5e3c9c8debe8@savoirfairelinux.com>
In-Reply-To: <50530d02-ede9-4e59-bf97-5e3c9c8debe8@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|DS7PR11MB7833:EE_
x-ms-office365-filtering-correlation-id: 8bb42eea-eac7-42f5-cabd-08dc85d12619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MnV1ejVyM1lwWkFxUStJcFFWTVU3T1djKzdNYXhxb0xyRVU1T3FGYzhwMGEx?=
 =?utf-8?B?WHlWdjJFYU94ZHVrUTVjS01Zc1BQQzF3QTkyQkxWN2F5VHdSMitRTVl3clFR?=
 =?utf-8?B?aUI5U0ZyRVR4VGh3MXRIUEh3c3psUEhNMDhNNW5ldUtyaU52UXRtWEZZcnZl?=
 =?utf-8?B?K2ZpNDFiWlV0bDQ3eDdSVnhVeVRJRVNnMThRQ0xJU1JYdGlqb25IQUVBb3RV?=
 =?utf-8?B?U3Z1MWZKSm5UODF4OWw5QUl4OFlqSTZLb0wzZnJSbTZZOFh6UC9WTDlIOE9k?=
 =?utf-8?B?WXluRGhwYUpYdGo4THZDbnFUa0MwVWt2Q0V2ekRSMkVGeTdnUUV3WXhTayt6?=
 =?utf-8?B?Wm1UUUt5Q1VyM3ZuNnI0Lyt0QmpFallVWkl4c0pmTXZVOVkzVkdOcWE5WUlq?=
 =?utf-8?B?Vnk0MlpEbURKUDFSNzNObmxrM3dGTDlsVUtiN1Z4WHhOaGpndzlZQjEyejB5?=
 =?utf-8?B?M3dQcUt0UE4wNXhvYnBWcHlTcDBTWVJMaHl0WTRiSk05cmN4d3RtRlA3Y1BQ?=
 =?utf-8?B?YUNPVFhoME4ySW16QXhmd1ExMjNPbjlaNFZuZEhCajFpQzgwbTdWMXdVdUVO?=
 =?utf-8?B?NS8vT0VYSzJUTWRKc1B6VGVjVC9IMUxtdGtEV2plbjd3R1dTRFZ0U1R4ZE5Q?=
 =?utf-8?B?UkVsaTFPUWxnQnZaMXJiak5xYlJad1ZLaHJTRk1odmdzOHZFb0JRTmdxTW42?=
 =?utf-8?B?eVp3YVk0MzNQRDJtOENxVmV3Y1BHdGI4eTU3NWlFeERoS2xURndEcjhMNU1w?=
 =?utf-8?B?UGlGSnBqbVVQdithL1Q0dWdlVk5BYndmL0kzbDhiUjc5SlNaU0MrU0wyRkZp?=
 =?utf-8?B?b2xLYWdCd2llZVpjaWQ3bDRpZEVXdWptK3RGV0I5QTZLUW9QNDJ6YktRcTdX?=
 =?utf-8?B?dWhnaVdEY3FESGduYUF6THFGbWJ0bmFPaDk2K2hwV3padHI3enhUSURnUXRm?=
 =?utf-8?B?alZRMmZQcElhOGQzbnUzd3BkcVU4SUpSVndDS1pBWm53N2JrekkzZzBIYTNX?=
 =?utf-8?B?bUFKaWFjSFhPbmlHZ1BFTkZZK1FBUUhPdm9kditNVys0M3lMRDZSZm1jQnNh?=
 =?utf-8?B?L0t2QWhIN1V3RVFnNWg0Tk8yZEI0QjZhYTBIZjNFYnNxK2JXS0tsRlQ1Um9m?=
 =?utf-8?B?VHZBRWpzV3p6UU5SR0EzVm1jT01rTURBU0ovL3poZmtSUURsMVFxZXo1QVRk?=
 =?utf-8?B?UjZiSklzOWRlMWtId0M4MWpJbTdhYmgyQzJKd2RuT3Vqb1lFVmRVT1lNYUNj?=
 =?utf-8?B?MTNCckg5K0V1YUlDLzJmdDFVOGJLMW5iY0J1eVVEM2pzc09aT3Qyb2N6T0NR?=
 =?utf-8?B?cXlLQ1RtR2VVLzVMNElFblFiK1prYkY4b3RPbVVlWGQ5dzNCR3c3OWZCdnc0?=
 =?utf-8?B?YnJKMUxsL2ZSM3p2WTFrNC9RUGcvU01wbmQvbWdCcGlEL2tRQnhXd2ZxVDEw?=
 =?utf-8?B?cVYwem1vVU1JMWRDV3VvbUo4MnluUXJUNG9vcFV2d2pmaHFaRXN4NldESUlQ?=
 =?utf-8?B?a2R5Kzk5Zk0zS0h1ZEhuRWF6NEc4MHRiRlRNMEtIS3RhMmhvWHI1UnFTNjNh?=
 =?utf-8?B?QUU2bmxBRVBJOEpFUzBxeFdnT054SndJMyttbkIwSzZkTEs0QmswY1RmQ3NB?=
 =?utf-8?B?MjFydTZ1N2M2d1g3b2xiVU0yaFNvMGxTbnZIek0xM2hTOEJ3UC9FNHNMVTFU?=
 =?utf-8?B?NDhzMWdIMnUyVGQycjlxRVBmdjZ0Q0tKcXdha2dibVVSZ3JNRmtMd2lBZDds?=
 =?utf-8?B?SjU4bUFGejJqbFZodjVuNTg1c3BESWgxb3REY3hMb1FQbUgzUVJkRGVrT0gz?=
 =?utf-8?B?ZkZpRDJDS3BwcjltNmNYZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEsvWkYyRFIzTFptN0Z4cDY2TFdISHl6QWVRdm0xN21SSlFMOVJqN2hjbmgw?=
 =?utf-8?B?WU1TRjR0TDdzM0xTT21jL0VKTktrNWU3bzAwYW5WYXFOa3lLR3JEbGVnTkEx?=
 =?utf-8?B?UHZ3TGgxV2Y3REZUT1d2ZjBJc1I5ZzE3ZDk3U3JCbGx5YVRMQWhVVkxweTFD?=
 =?utf-8?B?K2RXRERFY1hxTW1Qa1kwekptWjdwak9GZkxVWmtUYXpCM0lxSUxzZW5CaXBD?=
 =?utf-8?B?OVM0d2VEekgrNFNpY2g5UG0zR253VEhRa2czQWczQTVQWFFJVEhBMUI2MDlt?=
 =?utf-8?B?cnZ5UDducFYwWFprRFBGbHJZSXZmVWpBR0dZMGcxc05xWGRmMnRjS1NRbnVN?=
 =?utf-8?B?TXpzUXdDb1ZtVGE3bDFWUHQ2RzN2VS96OXZzRE95THp1cnNqdEVQR0EyRHJ4?=
 =?utf-8?B?WFZ1ajVCMllQYU5TSi91NzBzMVo0T0FVZ2xnb3NneHpNc3dpRnhJYnJqQVhR?=
 =?utf-8?B?WWpocWk4L0pwalpVcXhMS2hucWxoOEhsbkIybGluZDNVR1VJOWlOQXQydTc5?=
 =?utf-8?B?REVxQWlnc0RWM0xUTGxmWVJlYnhkeTk3VGYzTGF3UWJTTFlxbVNiSzZoUjVH?=
 =?utf-8?B?cEVSUGRqWTRlbUsra1VrbktJUE03NkhFb2ZrYXdJNWo4MGt1c0Zmb2tiWVBZ?=
 =?utf-8?B?QW9vRHFPbURha3pHbXB1OFNwd3RLdmsrRFBNMXE4YlFLOVlVWTlLbnZOdzJK?=
 =?utf-8?B?UFg4aW1xSFdZRFNwWHZ2K2xRWUJvWjI1SG40VW9rOHpOV1lQejk5cWhPNG5j?=
 =?utf-8?B?SXhPS2NBT3ZiOFJXZmxLdDhCd2pMYnJyYUw0ZUQ0MEdMbGZTeHNTS2kwLzZG?=
 =?utf-8?B?anBxRElGWm1OaU5CWWVhamRSb1VwRW01UVdoOWhEQUJvN2FJTmlkKzlaZm1U?=
 =?utf-8?B?ZXhCQWN5eHNQT3lEUWV6d3NwL3FSUFp4ZnlJZXFBQnQvcGtJSGhwWWFqQ2Nn?=
 =?utf-8?B?cU52SDVnNXZTZk1EZVlMdU1Rc05xMHFVQ1BIajFzR0ozSU1jUVJWZUwwR1pa?=
 =?utf-8?B?dHNRaHdpakFUZEtmKzdvMUtMZHA4YU5SZVpkdGh2YUVob3ZybmRnTTFiV2la?=
 =?utf-8?B?c0t3VHYrb1NWS3J0bUNqY21aQTk4NmUrRW04Z01LbUZyMmViSUFMNHRaRzlF?=
 =?utf-8?B?dHZiQTN5MTlSMzU1SmpnWlVseGhYR2J2UEhKYVhXTS8wWFg3UHpiazBvTEVO?=
 =?utf-8?B?L2ZCeW5Fb0M3aENkQkkzblV0bUNuRWZaZ0RYdGFGMU80cW9pVTV0NWVWYVRB?=
 =?utf-8?B?c0JnaHBMZGlMUTJuekcrVmF4UlN6MHFaZXRZQW5YN0RIb3Fud2p4ejZaK2dj?=
 =?utf-8?B?ek1OOExzZmVaNXMrOVh5QWNsZXczRmtnYnhmKzV1akNFdThvVm5TK0ZzejJW?=
 =?utf-8?B?OHpQN1o0aE5lQ2puMU55YVMvSmc3QmhCNEZqQmZ3U1ZVSGZPZ3N6MEZZNTVa?=
 =?utf-8?B?WTl4SHdvbUxJcFBCb2dSNGUzenBnMC9jR2JmTkNLU3J1K3ViOTJ2T2EvQVlt?=
 =?utf-8?B?T2VEMzNOeTBuWEFFZzEzU2tqVmVZSnVWMDZtY05qbzViYXdXQm9OV2xydnA0?=
 =?utf-8?B?ZGZsK2VUaC94by9nVVRWTnNWakRTZGFadDdCRGlyNGF4TGZyRE54MXFFbTJT?=
 =?utf-8?B?MUpuUVlyS0hNemFWOHE2Rm1HTGVMOFBtSVE0U3pPVzlOYkI5dHNKbmRTbno4?=
 =?utf-8?B?alkxQTZLQTdJdUxJM2tYY0tHTysvdjdMRWZodDduTDBUU0FJTEsvam1SRzNo?=
 =?utf-8?B?cFB4RGd5WTlteXVPZk9ERnQvb2prRnZ6dXNmaFJyeUhUcTBLQmExbEwyM3Vy?=
 =?utf-8?B?Vkd4djVQL3dmS2liK3RKUTFBK3JUQ0hDazBBL0hyRTdWY0d1eVFmK29ZaS81?=
 =?utf-8?B?M2dVY0VYaGlEOWZzVnpWb3AvcmYrcHM5ZHdTZXBrYWg3RHorc214NnZOa0w1?=
 =?utf-8?B?OVRnNFNsREJhdzlJTzFLdm52akF1bWs5bzNZZ0g4QStxeUxPa1hZeW9HbE41?=
 =?utf-8?B?WFRjUlloUHB5UjJZSTVTMkI5blNHMk1ycWx1ZTFlNjRYRS93Qkxkb2NVUlJK?=
 =?utf-8?B?ajBUYys0OXVvUjlobmFUdncrdGRqYURrSzFUTU5lUVNHTmNEa3MzWDZ6Zkgv?=
 =?utf-8?B?R3l6NDVwYnF4dThmK2g5RHVqK0Z1blZTbGlPektWMHp6RFhQZ0VRVFo0cmNr?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CA2E254F03C4146968B63A880FAE9EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb42eea-eac7-42f5-cabd-08dc85d12619
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 02:34:11.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PV+W8BHgsA+iyF8c9zZaL1psH5zpOjUXFVK3fwCWOpRdZRnAxPp7qIPlal/BH2FnjAHxxemz61R1ehq032aIjbXsvcfXCKs16ar8z+sU9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833

SGksIA0KT24gV2VkLCAyMDI0LTA2LTA1IGF0IDA5OjUzICswMjAwLCBFbmd1ZXJyYW5kIGRlIFJp
YmF1Y291cnQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
PiANCj4gSGVsbG8sDQo+IA0KPiBPbiAwNS8wNi8yMDI0IDA1OjMxLCBBcnVuLlJhbWFkb3NzQG1p
Y3JvY2hpcC5jb20gd3JvdGU6DQo+ID4gSGkgRW5ndWVycmFuZCwNCj4gPiANCj4gPiANCj4gPiA+
ICtpbnQga3N6OTQ3N19lcnJhdGFfbW9uaXRvcihzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LCBpbnQg
cG9ydCwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCB0eF9sYXRlX2NvbCkN
Cj4gPiA+ICt7DQo+ID4gPiArICAgICAgIHUzMiBwbWF2YmM7DQo+ID4gPiArICAgICAgIHU4IHN0
YXR1czsNCj4gPiA+ICsgICAgICAgdTE2IHBxbTsNCj4gPiA+ICsgICAgICAgaW50IHJldDsNCj4g
PiA+ICsNCj4gPiA+ICsgICAgICAgcmV0ID0ga3N6X3ByZWFkOChkZXYsIHBvcnQsIFJFR19QT1JU
X1NUQVRVU18wLCAmc3RhdHVzKTsNCj4gPiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IA0KPiA+IEJsYW5rIGxpbmUgYWZ0ZXIgcmV0dXJu
IHJldCB3aWxsIGluY3JlYXNlIHJlYWRhYmlsaXR5Lg0KPiA+IA0KPiA+ID4gKyAgICAgICBpZiAo
ISgoc3RhdHVzICYgUE9SVF9JTlRGX1NQRUVEX01BU0spID09DQo+ID4gPiBQT1JUX0lOVEZfU1BF
RURfTUFTSykgJiYNCj4gPiANCj4gPiBXaHkgdGhpcyBjaGVjayBpcyBuZWVkZWQuIElzIGl0IHRv
IGNoZWNrIHJlc2VydmVkIHZhbHVlIDExYi4NCj4gPiANCj4gWWVzIGluZGVlZCwgMTFiIHdvdWxk
IG1lYW5zIHRoYXQgdGhlIHBvcnQgaXMgbm90IGNvbm5lY3RlZC4gU28gaGVyZQ0KPiBJJ20NCj4g
aXNvbGF0aW5nIHBvcnRzIGluIGhhbGYgZHVwbGV4IHdoaWNoIGFyZSBwcm9wZXJseSB1cC4NCg0K
VGhlbiBjYW4geW91IGFkZCB0aGlzIGVpdGhlciBjb21tZW50IGluIGNvZGUgb3IgY29tbWl0IGRl
c2NyaXB0aW9uLCBzbw0KdGhhdCB3ZSBjYW4gdW5kZXJzdGFuZC4gQmVjYXVzZSBtYWNyb3Mgc3Bl
Y2lmaWVzIGxpa2Ugd2UgYXJlIGNoZWNraW5nDQpzcGVlZCBvZiBpbnRlcmZhY2UgYnV0IGFjdHVh
bCBjaGVjayBpcyB3aGV0aGVyIHBvcnQgaXMgY29ubmVjdGVkIG9yDQpub3QuIA0KDQo=

