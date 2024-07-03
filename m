Return-Path: <netdev+bounces-108693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78E924F7F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 05:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2398B2AEB7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC43C8C0;
	Wed,  3 Jul 2024 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UIl0igWP";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4xGVlxHk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB510A1F;
	Wed,  3 Jul 2024 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976522; cv=fail; b=AkKSfzeYESXqhhvM2Yvlw0CTz4nTGA5yWBsAEem/G8HRfRqdI4Okx5yQvJm16V5mt5AoZQx5LxXpLZ8H7aZPERjjDe7c5h8J4ZcqByeAlmc3gLqk52ZGSrUAPfT9y9LGRhbGLxz7gMqAhlWT27Osdf8WDLJq9BXPFvdSobC17F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976522; c=relaxed/simple;
	bh=aq/IbRyFqWxu19IYDmXJKwlRk6Oe2wyeDeL2Hn6mZa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GTWg5eMW+CnmeOg/iBEJzANyO4d6xPEMiup++A2vQoN8ZgCWgDIRD2IDVflg3ppwpxOg0GdqY7musTArYT4r8A72dYxnfR0MEZj5MZX2J7QfRozeMfEuTGw1FIpdRkb5OjpIr607WzwSyC0TZthaVh1R1PCTXqxIp4u+ZRGVzmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UIl0igWP; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4xGVlxHk; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719976521; x=1751512521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aq/IbRyFqWxu19IYDmXJKwlRk6Oe2wyeDeL2Hn6mZa0=;
  b=UIl0igWPBcENcAzt7DfF4ufR4x2Eas1vWZB7octbq0UMWXbE5ugmKXf1
   J0Oeeg3VCIiRVYlufcUR7HABGva6p4kzhkRL/DmBBXJR8MhTzxl/OwBJx
   W1ktQ4/HeFSqsv+ZmnR2E/nrI7K87JRtxFfoMhKNSg4/M08TbgpdoMG4Q
   Ydvn7W/L5JtPut89NUF/MBb0u4Q+clFr9R5YTr8MQmRjZ67Kxqn70P+G0
   iG6cCpsf7njw7lykJuN2FWIE7jKO5wCTROrEmUXiw5Yk97zROnZGUV/Fl
   pb7H2OE1qlNmyJxngzbGFRKiTqeIE0wGq0KJx7Q3iOAZDSoRWyQHvYcsq
   w==;
X-CSE-ConnectionGUID: Dqo9LXViRhCMywrhSoe8vw==
X-CSE-MsgGUID: gA37JX8gQg2X+ajYdgkUgA==
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="259667897"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2024 20:15:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jul 2024 20:15:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jul 2024 20:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT2T9rbsCZ4D/1GquSxWuoT00wyAZFBFmU0bgAjTrMYApImPGZUkq7HxEyVjX/np/d3dAPUgEyN7ripG/6FBmy8oMvvjI5MkhjsYgD+w9Ihh5ir7LV6VlUGvAJf4cZlaCoTsMOsYKPoFFx1e0eQtKDWd3JVvvIztqa4CsV1QRSQPXrEAIhuj3k/8DJxFAPqtAGvYmYzuQkkHmoMR7spBeIvAKBACjHWQk4wK/UG6wd5F49Fcnx3mK2fj2URHeW4dpSQlvoXqk/bkeaeng+qd73Q2X4/6IXDQ9SqoNBy1K108qTYls0tWbxQdxLv+XSPYxlZVTkqjaIDlj9ZuaqjE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aq/IbRyFqWxu19IYDmXJKwlRk6Oe2wyeDeL2Hn6mZa0=;
 b=Eu1fmoqcWxwpXHEsDdVhMOj+GIj6V8gLg/SwN0XzVjpqxEgfiBx/jT2oXe03k8tQ+hhO2XjwFJF9gVnH1WJe2d4Ycg34kNB4lgfs26RdBnS1m2DmYUjo2OCir3IGGot5edkfn7tmWuKFqBctJgcbpXu4fV2pFxCNf9N3LitQq2MCr6Ij2PgwJ2G7vQ6LPiKDv5eTyQ3sYCeAUXzcQoemEv8VQLmF1FeNVN490FUuCx2hejMwlcC8KeTA1tjPasQyPdMQ3IaLBZhsQ4aS0Ntc6Rlfd9PgZ7et04TWuzwJd0sUZ+Q41KGiDY5W31+ajkDfW+1lld/dQqH6QunOXeRvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq/IbRyFqWxu19IYDmXJKwlRk6Oe2wyeDeL2Hn6mZa0=;
 b=4xGVlxHk00S4vghHBIbIIP6IWBy3ZGQ3tf4ACMBHv47I7V+W87ImyixyPsjBuK8xhH49DMCitYyO0cvYpyXhMr3pKHXQ3bH9xU/cRUKmFe+2CphoHINEzYMB7Os2akzgVkKENTCTN4R2ClSTpQxJLXjpJNdp9RFmR0rsZMs6ABMUb9aBG7zdJbRQTPhX8QdH1/sEISdAYCNFU9qp01hIY+8GfNLju34GbAw834QY4GTyeP6iMn+tUdD8XcePjr81U2bJHYwIMRApStdoS2zFy3fcsM2m7M4ZyCDGWMAT0oHaVbF9dsPhVm8lSdmz/VBeMjN521OGg+53fSIC6ku50Q==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by IA1PR11MB7269.namprd11.prod.outlook.com (2603:10b6:208:42b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 03:15:06 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7698.033; Wed, 3 Jul 2024
 03:15:06 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <l.stach@pengutronix.de>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: microchip: lan937x: disable
 VPHY support
Thread-Topic: [PATCH net-next v2 3/3] net: dsa: microchip: lan937x: disable
 VPHY support
Thread-Index: AQHay5RAQE1RPnxQ70+nyXtVpKCRm7HkV9oA
Date: Wed, 3 Jul 2024 03:15:06 +0000
Message-ID: <d147c4363c778c6c94f849c0be0996fa8695fdd0.camel@microchip.com>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
	 <20240701085343.3042567-3-o.rempel@pengutronix.de>
In-Reply-To: <20240701085343.3042567-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|IA1PR11MB7269:EE_
x-ms-office365-filtering-correlation-id: 0dae5bcf-98f4-43db-1bc1-08dc9b0e56a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Yk1rUWhKbndSOHBHMEVRL1E3Q0Y1N3BoUk00NGdFNmV3cnhmOEJ5TU5XM1NN?=
 =?utf-8?B?WWlxclhOWGFNYjdSSG1ZMGZGMGFlM201YUdYMmtIS3RoUzV6REo3bXNnTGZS?=
 =?utf-8?B?aWlwQm8zeFc1eW9MRWxqQkpkelQrcDRnalRSS0pxZHVYSWNyaURxWmk0N3Rq?=
 =?utf-8?B?ZjJma3lQNVRRV013WWMxYTdHWGFaazZQWEpiYnR6NmVwcHlRYW4rblVOdEVL?=
 =?utf-8?B?THhXcXBhRHJ3YkNUVmZnWTBuR3drSkNnZ2MzZXdFQ2RHQU9jY2ltdUtnOGZU?=
 =?utf-8?B?RGx6T0w3cHBoV1hQRXlwZS9IL1hHWS9helptcFY1cnZraUJZV3NiVTk4bEhx?=
 =?utf-8?B?bEpDRFBaODEvTjdMd1g0V3ZlV1hsc1Y5bzdqT2U4RXEyNVo4MGhkMlNUNlFm?=
 =?utf-8?B?aGF6RHI0TUwzM3BWMjVWclI3NE5nUmtScFdLY2dBNVRrUENhdTlzSlViNE1Z?=
 =?utf-8?B?eUliUnB5ZUZzUkFBR0NOYnRkbWs0aG9Uc05JMkIyaTlxRzhYeWxJT2FxSUFy?=
 =?utf-8?B?MElNUTI3bWFYM2VCbWJ1Y2dyZ25aOHEwSytBTlplOHB4dVJDSVNjZXdPSWZV?=
 =?utf-8?B?d2xjZUlmQVRla0xlSUIvNFhEaXYvN0VtdFd6QmdyczNheUJkSTZiK2dUeE5t?=
 =?utf-8?B?K0JuMTJLN3hsamdJUEVtU1pDd2JibTJnaC94WFdLMEJTL2o3d0dGZk10Rnht?=
 =?utf-8?B?dW91VVk0clpRb3ljcTdFT01STEVtNDlFREpscFBCeE1rUnNZNXNqQ0IrUG0w?=
 =?utf-8?B?NG8wdGZZeVpscHNUUzRNSUR5eHhsTGlnV1htaGlBZFNxZDQrWVBRZGIrSllo?=
 =?utf-8?B?TXhKUXFLeE1Ka0hjbjBNczkzeG40UkswUEhZQlFRZTRQM3grREp3K0sxak85?=
 =?utf-8?B?aHFkcndHbXZJcFdPa0phRkYzaDF3aXJDVUVSb2tEZ1E1SitacEN2MnZYeHpW?=
 =?utf-8?B?b09JQncxL1ljVDJOalVDWDJhMXFzNk1XWU0xWWpmdHBQbVcyZ2xsOCtrcE9W?=
 =?utf-8?B?RENGQW1ndVZseUgxTnBtVGR3Rm1LVHlIUEpmVXhPMzRZNE1pOGo2VWtwdm80?=
 =?utf-8?B?YklWVWNMaHlxQVFweTNVaTJmTTFXaW44bklNOUdnT2F1UlhNbTg4M1NEU2hW?=
 =?utf-8?B?M25TV3o5Tk9yTDNUY05kdWlZYXh4QlRwUERBL1NzUCtRWGNkaHhSK0ZWVDBF?=
 =?utf-8?B?OWFMZ3RoZDdvT0FXMGtTRzRBbzJtTlVwM1k3ZkxQRWV2VDRwTzRpUGoxcGVa?=
 =?utf-8?B?RklNRzBPb3J0L0ZZNTJOejBybytEWitBdVJjTW90a0IvMzcyRm5GekJxUlZ5?=
 =?utf-8?B?YjNnZFI5dE5CNmoxcG5jeGJraU9WYTM2N3FOR2xObWNxWWxzeWZlUWRob2JJ?=
 =?utf-8?B?V0l2MndvbGtPNGxqTnhVR0RNRFpDYXhqZnFCc0d5YUZ0OUFxYXEvcmNkaFB5?=
 =?utf-8?B?eVNQYXV4eXRUSDByQUF1QnlvTml2S0dHK0IyK3BHZU1oV0UzSHhORGRrUDd3?=
 =?utf-8?B?ZU1aVGNhdTJ6Zjg3V3NlUkdIOHpOVXlmWitpQXpJOHJOMytYK2IvMDljdkgw?=
 =?utf-8?B?QkxvcTI2Y0c0bFlTUllWV09MUDZjbVNWTnNoZzFRcHdsdjlhYW1vZlFISnV5?=
 =?utf-8?B?ejdQdTNKSjkrWWF0YnhKc2Zmcm5TWGFQRXN3WUFQTE8wMHVLRCs3Vm9COFpR?=
 =?utf-8?B?NVRGa0xmV2NFakIzTUdlcXJZQTVqSUpzN3RyMnNMWExYaFE2czF0VHowbzBy?=
 =?utf-8?B?RXIvL01kT050dkJMbjB1VndKSE9JWWthM1dpcXN1MWYrNDNyNVJpT0Z2Ny9X?=
 =?utf-8?B?bjRZMHg5K1lwNS9TMTFRUGlETTVJSEJUMGtnMWxuU2Mxc0FvVTFGMmdjQmx0?=
 =?utf-8?B?czVvajhVSGJEVWY0bllGTTgzbVNqbC9mcXBwNXZtUGhXdVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnY1ZnkvZk1aZVpYUktYQ05iSnBZOGpybktkT05vc2JsQjNnMkttRyswSjJY?=
 =?utf-8?B?aWlVWjQ5Y1VyZEZPWi8zZ0xLczVhbHVkNGpMR3lJdkxnZlRnaWcwTFBlT0U4?=
 =?utf-8?B?WmJvUVo1ekR2eFRTcWNYNWg3OU93R2NOT2dMSGVGWnFzTnRYVERxVk1IdTQ1?=
 =?utf-8?B?QVJzL2h5bjlZMjJ6RUFkYjNPWG9qbUhJdXVhVmV1SzFYS1Yvblg2YVJYZ3o3?=
 =?utf-8?B?Tm1ZU3FpaEluQUI1K29JY1BLUDlkY1NEeG1VUVl2TFc0SnBLNFNMNXlrZHZq?=
 =?utf-8?B?MnFYY0RNbUpUeDNnU1JmbWlzNCtsUlh5UlAyZzNETHU1SThnQWdRNVYwdjEv?=
 =?utf-8?B?d2RYdWw3SGFOYWVuazZ1eVpyNUMrbTlGZ0U5NDVzV2xyNXE1cjdWZGc5OEhZ?=
 =?utf-8?B?L3MyK3NkeXZkTjZ4My9URWY0WkQ3cDAxdTVSUHhFUlNvc05NZGF1Q1p2VVJ2?=
 =?utf-8?B?cElBYVRYaVMzYlBqUkJFVWFqSlYwUEFaZDJqclYzR3hGeG1SVy90VHRLU2tV?=
 =?utf-8?B?U2dwVmVLOFpQWHRWbXpYYk54ZGFXWUI1VFdGREgrcWRFT25HcWJkWjMzdk9D?=
 =?utf-8?B?RGdsbW5pTmNnQllXSEFTTHJJcnpaL0NrWlBwY05Ocmx1cEM3bU44VUZjWVZl?=
 =?utf-8?B?c1B0SDczWWswVHV1bXBPbzBzM3dxM3A2bE9sbSswbjRoKzZnNmJvY2JkYUwr?=
 =?utf-8?B?SXZUSFdETERoL1VGWGRjeGlCdlVjNGx6cHVDMTVzejQxOWY0Y2hkVzI3L1BG?=
 =?utf-8?B?WEpHdit2LzdpbGlhMDUvSnpFUmk2UUpXZ1A2dTBIT2FidnUzQkhjdTBMVWVK?=
 =?utf-8?B?akRwY1M1ZEYvZGhaRHd0QVlJV3JwcmkxWVFhYzBVUll1NUZyM3gzbGxIazdi?=
 =?utf-8?B?bE9ac1NHRm05V2VmMVBGa2U1aHc0VXcraG4xVzk5dG54R2M3YkhWbGtLcVNH?=
 =?utf-8?B?NEpJODdQZytFUEJvWTZXeGIyVmNweThCeTdlRGhOb1VMZUZHR3ZzcnBhdm1J?=
 =?utf-8?B?L1FkWkpVdUg0NGpVWUZUZndLZEdKOStUUjhWQ0VhWHFLanBMcVhQT1VaelJY?=
 =?utf-8?B?WVlrTWkrVVBUbkV4MWgxMFVwaENLUThPVWhyNDR6MTJ4YmprQWY1NjFLL0Q4?=
 =?utf-8?B?M2JPRFNqbm5rN2NCd1UvN3QyZU9TRERIRzRHWjFCb1FrNnY1MC94YitJNjVC?=
 =?utf-8?B?T2NzU3ZLNTZySndROTUzTlAxTDZlVGJJL0hKZnVlMjg5OWVUSlpIYWQ0eEtQ?=
 =?utf-8?B?Nm1vRU5ldTArYlNEWi84SEZwRDN5cmhtNW1hSytSSWY2WDkzN0dpeGlKZDhs?=
 =?utf-8?B?cGtLMFFiRy9vbk5hMWFwdCtvR3A5TkFPNEtkL0JnZnBTWms5aFVIMFh3ZUJK?=
 =?utf-8?B?VVZ5ZzgwcnJIOEhEMWZ6M2hwUWF3T0JwRnpOUkcwOTgzdGU0d0FQV2E1UEkv?=
 =?utf-8?B?WUFBdUNIcEhtV1NESVNaTDJ4dWU4QStwM09vcGpLMEhyekh0NjFtWVVrVUQ1?=
 =?utf-8?B?N3pGOFhkdklZSVR5N2pXWSs3ZzFid0s5UEEzZHVoZDJwSU1OMXBPQlVrejhK?=
 =?utf-8?B?WFQ1aE13b3F6VXlQL1FXK2ZvTGd3MFE3cUlWSDJZUGpyU1J1OUt2SWtCYnVr?=
 =?utf-8?B?bnlEMFNtNXNWcTFwRlhkTDF0N3pxOG1GWTE2Wmlwc0FRMk9DTGtyak13MnZk?=
 =?utf-8?B?WnI4UkhPS0lXajlMWDVpVXNnbThXTS82VHBHNEFKSlBGS2FKb25OTzArNXp3?=
 =?utf-8?B?V1FCWDl5ZGJWby9oWXpHME1EWkJqakFPK3lXVC9sNkpIdUhMVEY0dVlhMmp1?=
 =?utf-8?B?US9ESm53cVFGMEJXWTllWk5vYi9XcXNoNjl5bSt5VFdpeityQXVRTGliM1Mv?=
 =?utf-8?B?OGx2WkgyOE02TzZIYlk3QlhHcTFkbUR5MkZGY0R2RERtcjF3aWRsc3FVWjZG?=
 =?utf-8?B?eVZ0Y2d2OXVnK0dVZ1VKSzhpOEU0U0VCcHUrNUxLVVBPQklLdEluNEE2Um5s?=
 =?utf-8?B?dW1PWlBXTWhRUHNjRTg5L243TE5sdmZTWHVGTmxCTTJObXUwdjVvRUFORWtL?=
 =?utf-8?B?Q1dvM1pqb2h2VTltS2NFM1p4MzdhVmhPZUJXWTEzZUdBTFNtV2I5Ynl4T3di?=
 =?utf-8?B?RVVQNWp1SEZJdk9OT0cwTnF3cGljTmJqNzNlTXB2emdtc2ZIT3JNc3NaL2Ry?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <635F21788939CD47AB7DCF6BDED3B473@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dae5bcf-98f4-43db-1bc1-08dc9b0e56a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 03:15:06.4908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9AzdO/L9dB5H2bB8r8C6nbR+ekux9/KHbX1sjBtelPlU73hL7fALwb/a1VYdspiI4Nmtv4pV0CAQxtuSR+PISN2oLKNFayaRuegpVNPVV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7269

SGkgT2xla3NpaiwNCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9sYW45
Mzd4X21haW4uYyB8IDMgKysrDQo+ICBkcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hf
cmVnLmggIHwgNCArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAvbGFuOTM3eF9tYWluLmMN
Cj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hfbWFpbi5jDQo+IGluZGV4IGVh
YTg2MmViNmIyNjUuLjA2MDY3OTZiMTQ4NTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2Rz
YS9taWNyb2NoaXAvbGFuOTM3eF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3Jv
Y2hpcC9sYW45Mzd4X21haW4uYw0KPiBAQCAtMzkwLDYgKzM5MCw5IEBAIGludCBsYW45Mzd4X3Nl
dHVwKHN0cnVjdCBkc2Ffc3dpdGNoICpkcykNCj4gICAgICAgICBsYW45Mzd4X2NmZyhkZXYsIFJF
R19TV19HTE9CQUxfT1VUUFVUX0NUUkxfXzEsDQo+ICAgICAgICAgICAgICAgICAgICAgKFNXX0NM
SzEyNV9FTkIgfCBTV19DTEsyNV9FTkIpLCB0cnVlKTsNCj4gDQo+ICsgICAgICAgLyogRGlzYWJs
ZSBnbG9iYWwgVlBIWSBzdXBwb3J0LiBSZWxhdGVkIHRvIENQVSBpbnRlcmZhY2UNCj4gb25seT8g
Ki8NCj4gKyAgICAgICBrc3pfcm13MzIoZGV2LCBSRUdfU1dfQ0ZHX1NUUkFQX09WUiwgU1dfVlBI
WV9ESVNBQkxFLA0KPiBTV19WUEhZX0RJU0FCTEUpOw0KDQpEbyB3ZSBuZWVkIHRvIGNoZWNrIHRo
ZSByZXR1cm4gdmFsdWUgb2Yga3N6X3JtdzMyPw0KDQo+ICsNCj4gICAgICAgICByZXR1cm4gMDsN
Cj4gIH0NCj4gDQo+IA0K

