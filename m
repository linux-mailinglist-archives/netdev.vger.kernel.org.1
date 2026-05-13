Return-Path: <netdev+bounces-287447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHgRBTAcBGpDEQIAu9opvQ
	(envelope-from <netdev+bounces-287447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:37:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB052E259
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E379A302C828
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B633D45C1;
	Wed, 13 May 2026 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="AKXbzmur"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D203D45CB;
	Wed, 13 May 2026 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654253; cv=fail; b=V4m2SS5++aZtuCXtfoW/j0sd6ucigtpnJtL4wiwv9+lEtJL2yUjOMkJQ1gHVbdr0JzS7/qNzOPoYjgeVJwz2RiGI+v7hi0w7Ux8N/O1+nKK1U1/5JesgPRWZfBo1R/fr3+b50LDJXwxRz+t4NAYwgCnQKX9BR62/SBe+0+xc9oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654253; c=relaxed/simple;
	bh=RxSCzxbY/9rmCyjk39IK0oGBC8PAlYCkrJO+9q7ANlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1YIZigqAvIw2sVOEfUwh76Ak09vtQEHVX0fMymIQekSRrdEZzWSk/g52XHkSVjeCcTV5frH20b+gI9YeZKOnL2YN7bbi18AR1phPHWB6ltOfc1SgQrZfVzcjXJMV34W5nWZCb6F7QjKFOLNKtqyU1L9UnAX+aWZszyawZvuLT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=AKXbzmur; arc=fail smtp.client-ip=40.107.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhG5zrm0Yk8Nwrm6YCazoXxW+dh7Ti/Z/9MgGkWMX4hrkbti4btirjuJWAab/uWIdfNM31z1GWKLLdxTwuGQxjX4+cHeu2aF+5Rl/wpT+X8sLwn3VMJliqlusr+A9qUWAHPY82YfVKkP8NYZgwem6YjJHe/Mm9RBmFzgZEmQWhspkCdW8O87URD/2mZLC1bBb6zHEiRa8YxWgoe3xn9j8R879RRzDylve5iooXdZoqIqlDKsbyJhWAgj4Aj29yzwAl2G48DSNr+mApxZi3RxPHhv7fH0sm7UuTHughF+szl7aY7n9/bJkG/WL1AuAZgH16Xei+ADzwS7LnzBeOB8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxSCzxbY/9rmCyjk39IK0oGBC8PAlYCkrJO+9q7ANlo=;
 b=bbULnewkn02qlBYAQata2wAWmJl0aY2VNfdhmZPR5QpWWU6PRNwebnezS14T8xCtvORZ+geQGXR8c+8ZJhSR/gIK1mYEG3/ytrmUrNWCWOcnb3mktwGQlNPJynTUavMkgcguyKrUaRNrhXkcjKhtQSHEm3jpImHa/gnZNdVk9791+ufGuhXUrKMfcUEEkfYp+31txCTmOONygULp7oOgSQWKUDqedzgCAuRJfy7p7raWH6dWZK5BW+rFiHp97rQcf6ayF0QS4FHbmV3jJfxke0boha/g4CaVSzej0ctZNlIxdnTIg5A08Qiip4dfPewjrN7pqY8GWZojrCAKHR+4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxSCzxbY/9rmCyjk39IK0oGBC8PAlYCkrJO+9q7ANlo=;
 b=AKXbzmurQWymNVl5sVYoQftzQUr1gg7uhQ8vSa5Q9cgdqNsEnjT6fFQL9MzLFMHKewIpYaibqSGnpFuMAyVuVk39g1jdlLrhm1FBefvfAhX7YpMgIjCsJXt755iIxvvSKcOAamv07c4m+knE9ajgqeqSckatALn/HrdpArTsjjKF+0HKOKlHRUz2/lek2ajn1B4/gKAX1HCVsJiNKyyX6eSMQH0BovYPImbyNveH2vBndNFsiUBcXnYsAR2ORp5svExQaGovBtM0r2lO4G8+wBJsu5/T57S5zCQph3gOgLkXsI+1eO4p6LR6DM3ZY4NOYggRYVD/434yPkEwQBAcxA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB7678.namprd03.prod.outlook.com (2603:10b6:8:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 06:37:28 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:37:28 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: stmmac: Add support for TX/RX channel
 interrupt
Thread-Topic: [PATCH net-next v4] net: stmmac: Add support for TX/RX channel
 interrupt
Thread-Index: AQHc3qpIrSh9XMKDd0aK5CsbRHFKjbYKEi2AgAF2bQA=
Date: Wed, 13 May 2026 06:37:28 +0000
Message-ID: <61f4daf3-a9ec-48b4-8833-2a3f40b5b879@altera.com>
References:
 <20260508051943.9029-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260512081721.83704-1-pabeni@redhat.com>
In-Reply-To: <20260512081721.83704-1-pabeni@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS0PR03MB7678:EE_
x-ms-office365-filtering-correlation-id: c353e305-3f4d-4511-fb3a-08deb0ba1a60
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|38070700021|18002099003|56012099003|22082099003|11063799003|4133799003|3023799003;
x-microsoft-antispam-message-info:
 =?utf-8?B?QU5tSlFyNnpCaFNubDFTSVZjVE1OcDZmSWhGY2V1NU1BbXlDckgycjMvbnZ0?=
 =?utf-8?B?aWZRaFpRa1lJMyt0R2RycllpSHRzUXNtWWJkdFRvTUdTVjUwalp4WGtkU05t?=
 =?utf-8?B?WTFGS24vbDdES0U0SWl1dGZ3aXk1QW9jZFkvQThtMVBLNi9PV1d0dnJ2VVVU?=
 =?utf-8?B?RFpRWkc3ZjZVUFdtY2VIWWI4YlBDQWl4VGpiYythSC8vb2RTWWw5c1d1emZC?=
 =?utf-8?B?VFU5dG1zVG9zaE5Dc2wyRFVYMWYzWDVWdmRFRlUzZ0wxV0dnTzNpc3FFcXl5?=
 =?utf-8?B?eHRTRFA1L2Y0VXdCL1ZBMER2Z05JbmRZYy9aeExrdGRyeHVFQVFQUWt5Q0xt?=
 =?utf-8?B?aUFBSDMzS0x2Y2taNFBzTkJWY3doOWZRMFh5Si9KYXhuTGV5TzcvMmZLbVR2?=
 =?utf-8?B?R1Jmc2VMb3ZrOXA2QjJHZWtuSFpJenE4YjhSMnZjZ3h5VHRFUnRWNEFWNjV4?=
 =?utf-8?B?dklpakJJS2JrUXpSVW81UGVNZER3REFBRE15YWlLQndTa1V2cmN0YW1mMWFX?=
 =?utf-8?B?WFViN1dMNzJXOHRTV0R0OWh2cDZLUGlNdUlrd0FXY2Mra09ya1E1eEorb244?=
 =?utf-8?B?b1ZXemNab1JGWkNOMXhtZTdBR2UzUGdjTGlHcVNSTFhOVnhXb0o3YkF3R3Y4?=
 =?utf-8?B?M3pZS09PQ2l0alZnbDBTT1c1clRXaE1BcWd4MTQzYzVJRUhWSGkxWEFNMG5C?=
 =?utf-8?B?NzZ1a21jU1psck9zVWF0Z0ErR0NjQjRweDVwVm9VWmxYMmVpbEtDTVkvNFpJ?=
 =?utf-8?B?VXZhMW50eisreGZMMWNCZVBsbzNuR3JvcFcwSXk3bU5SOWdxazdPTldYOU5R?=
 =?utf-8?B?U0ZDbUVSTjZMcmpYUFozbVdFTDc4dXhlMUptUkkyM29heEw1MVVwSHRUdjlk?=
 =?utf-8?B?YVp1d0RnSk85UUFYUmxWdVY1dnYxWnRWZmtuUG9wQjB2V2FEYjZKM0ZWRU1a?=
 =?utf-8?B?OXRMeXlpYkk4R2I3TU1kZVJYcWtOS0lYTFY4bDdzWmx3MkZVbFg0VlVqUFFj?=
 =?utf-8?B?TGhGZnl5cU5pRU5VNzlpOUxHT1ZTUEhDc1JBUXFEaEVGenFnbnduOU9nZHNV?=
 =?utf-8?B?aFMrRVUyZ0hSbWRJd0lGT2V6U1g2a3Z4VEFGMU92N0hoN2dZRUVJMW4xUTRx?=
 =?utf-8?B?OThKQ0dzQlZ0N2NWd2ZaaHRtMy96OVI5NjFUYnRLMXUyU2R3WDlFME9mS3J2?=
 =?utf-8?B?Rkh1ajIvREYvMEY0MVZYNDR3VDNoWng2T3VKK24wSWRzOEQza0VyNFNlM3NC?=
 =?utf-8?B?bnVUTUxFNENOYmxQKy9rMjhQQ0dFTmtkbE9Lc0pHYUVFcjFBanU0T2ExemxI?=
 =?utf-8?B?TTJudzZpSi9WcURJR1l0QVdRRUtjT3l6WEdZOERsQnJHWTJTd2k4ako3SUFR?=
 =?utf-8?B?eUQ5ZjlFQUwrQThaOSs5MU1LODdQK2tvU1RYUHdiYlUya0NYN0Z1UEt1QjVm?=
 =?utf-8?B?MytHb0VxRk9QRTRCNG1Pak1kN3h3UjVpdk9HcktKSEZUeXZFR3VrK2JQbHE3?=
 =?utf-8?B?RFR0RkFVd3l2L0FXdHZSMGNISUxPQmhGUkRiekRKUmx3UW43bnFIMVZFait0?=
 =?utf-8?B?bjZudytKcmVTb3ZrMjJidkJiTlVOSkpjVmJNZElqVm1wak54dkpGcmNCZ3Rl?=
 =?utf-8?B?SmlJSkdQcGl2UXFVVncyQ25MWUI1NGIveXpKQThJeXZ6Mk9ZSm44KzV3SFly?=
 =?utf-8?B?MXQrOXp5ZXBjVXN2c1RrK2p6TVNvYUdJVW5sSmtTanZjd2ZiUjZtUmh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(38070700021)(18002099003)(56012099003)(22082099003)(11063799003)(4133799003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEdRY1hzQndoVXdZYkxoNFBueU5zcHZkbzhoZnVWZkNlblByUlEyZ0R6Z01I?=
 =?utf-8?B?bCtQK05lZmFxQkpndUdLd0RUTkw3N1lBWUV6K1NETCtNN0dHZHBvbWNHcEFh?=
 =?utf-8?B?ZVpabGMxcVVubkx6UHdQYzdGb090YkU1aTE0ZUJxWjFIVkxiTTl3M2ZFcUIr?=
 =?utf-8?B?VGdFYUM2WTlCL0Z3S1NIR282VkxxdlJnWElVN05kZW01WVArSHNzU2cvRGtS?=
 =?utf-8?B?M09qVFJBVXNpeTlhdER5dWo5eHRBc3hWYmh1cEtLbzJOWDhWbnVOcW05UWdN?=
 =?utf-8?B?UCtsbmM0TG0vR0dBTk1zMjJqdU8yMkRnc0R5aDNNVWJjaUxBSkV5cGp4NWtY?=
 =?utf-8?B?cTJtYXlVMWRONzFwM2txYVVyMUpDeU9rbXRNMVNFZTFLOE5iRXNoUFVRbk5I?=
 =?utf-8?B?Y2NQVnJBczM0QUhkS0J3KzVpT2dENE5CdHA1d1NpL0VndjZoOTBhNHR0M2d0?=
 =?utf-8?B?QlF2T3pyZ2grS2JQaGFRZnZaWFRXYUlYL1hERmFnR0pWOHAycUFnN211R0Uv?=
 =?utf-8?B?MmNhQlgrT2l1MHlGcXZUME9rL2gvWjJDRnVzYlFIMVoyUGpoeHVSRForWUti?=
 =?utf-8?B?eTNYVC9rMTZRQ1VkbXA2Mkh5RHVPbm0weC8rNmRkcG1wNzg2OWxNTmNIcFFs?=
 =?utf-8?B?ZmtJK2FodE55QnowMHB0SnozNnVUNXpVTWgvOUNEbTdISCtKbXlmTUZxV09z?=
 =?utf-8?B?NW5HeGcxZFlDMWVsUEp4VGc5alFhOEN1SThZaFluVHFkZjVISmhLMW9vQlds?=
 =?utf-8?B?N084MGNna0lNdFp6TEtQTWlJWFlsVnBIRi91Z0puVHM2SFRvRFJFK1NKZWtu?=
 =?utf-8?B?VndQZzNSVGJ2Z1hyU3VtRmN2c01IcnRJanFCUnlMWEFOaURHQitQamRoSlps?=
 =?utf-8?B?V2d2a1Q3ajhlTURYUEsxWkNNL3NESEg0SkpKcXhFVDh1S2JEZ21UdjlxV01R?=
 =?utf-8?B?WUQ4cnhyRTNORU1mQmhpdElxUGZEY2crTjd6bGtHM1ljTzUyZ2VDTkxXQytk?=
 =?utf-8?B?SmdXcDc4Q0lxSWJ4dmlEdUpWRTNYTW5vVnRPZUE5ckVVQ3p2VURXd3Z6U0Za?=
 =?utf-8?B?WDVSbnVPTExZekVXUUNnUE96aGVQVUhjNWxvQXl3MXh1c1UvcGV6OHY5TzV4?=
 =?utf-8?B?YzlQR3ZwMHJtTEpGUVJGYnF1aFljQnFYZitBVUlSNE5UOFI1RmYzVE1SQkQ2?=
 =?utf-8?B?MmhiYnFoeVNsWlc3cW82cFdiaElHL2JNUGtVTWM2Z3dIcnpEMUJyV1ZLaG9a?=
 =?utf-8?B?blFoU0c4cVVTMjhhS2J1ekJlQnI2SUZKTjBDeW1JcHRwNWVDRXE2R01yTDJP?=
 =?utf-8?B?bTUxTHcrWGNqT1lzMzhyMnhZWWo3TzkvaHR5Z3lqOElzeGhXT04zYkZuNk9B?=
 =?utf-8?B?OFRZNlJuZjE2d1dLT2pHT01wcnA0dlM5U0g2ZkJXVGN6SjIrNmZSd2dOME51?=
 =?utf-8?B?cERjOFRvdy9OaXBPZ29yVFpSbW5taUdJZWRZeThia0V3TSsvVUpxbFV4cUNs?=
 =?utf-8?B?QkMwcjNvRXlaNGdWU1FQSTlMVWxzQlZqNllaWEVPcmpSVFpVM3hvaEx2VTFx?=
 =?utf-8?B?V0lvQXRvMlBzdGFpSE5wZExMTWVGQnB6MjRSY3FaMzJycndoMWRaREpxcE0v?=
 =?utf-8?B?MWpENFVidytzWUVQV0pJdXVOaHBQenFkbXNnYmk5aERnLzZOMnM0RXhzWURL?=
 =?utf-8?B?V295OHJWcVFFSjlkeGkxaW81dUxXOGpPZDNDZTE3cGI5SUkyQXZPSnlORXJW?=
 =?utf-8?B?a0ZZWk9HbC95RnRWaG1JZlJZajZJdGlrdmMrdHN2OVBWVitLa3VTZGs1VXBu?=
 =?utf-8?B?Q3ByLzQyb0V0blRITW00WWRuTGs5NTQzbjJtRzczSlBiZFQxV2hob1N4RGZ0?=
 =?utf-8?B?TFB0S2xsaXAyOUk2ZUlFSkgvb1I5Y2RMU1BTMzFueC9hVlJ6WlpKeVFrS0hM?=
 =?utf-8?B?dVVvYk5INzI4SURZMnVHcDd5YW1zejVwdm4vWDBEODJBc2hRVUFLWitjeTdk?=
 =?utf-8?B?MUVua0hXZTRYeXlyb3RTRElHTmZ5bUJjM3pwdXA5UjlWV3J2bmRCYWNpYVds?=
 =?utf-8?B?Q3RjbEZwU2RwRnNUK0FUUVFKTWFlZXJoR3c0eFVnUWQ3bUZSN3cwdGorUTRP?=
 =?utf-8?B?ZlhnZUp3NjNCNkp4RzR1bEVUaVErS3R1Z0tuSnZFb0lpU1lKRXYwMDlEZUhj?=
 =?utf-8?B?S25BdU5ueTdTb2RXR2NHNFNMUzByWTNoZE5KdWVITVY4M2xkblNsT2pEM1F1?=
 =?utf-8?B?MlB6K0F2VkdjRzFKc0dONktOVzNUZXdYV01PbDNKeXUzYzJ3YnNxeW9SdnEx?=
 =?utf-8?B?QW1DL3ZWY216Y2tMa2ZvT1doY0Y4d2pLdTIzTHovQU5NSHk2YWtVcDBuQ0Z3?=
 =?utf-8?Q?nVfgV0FWWqCTqs6B5k9+Fh3UsrBr0lNpTuHFM7WiT39us?=
x-ms-exchange-antispam-messagedata-1: LTQkXQ1eCvZ+OyI8xt+A+Zk4AFoJ1qcr4J4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27C36CEFD6F2314497E81C886604DFF1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c353e305-3f4d-4511-fb3a-08deb0ba1a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 06:37:28.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: saV5/s9cCgMBG4ZPan9+jfTzCNBfPGWEYLdKAXkA8EORYnmBhf42TCMGLuB963ulYeOasL7RDB7BKz7LYWEuh9C3U4wa2pAoNEdy/7k8s37BKKaoEpcdM6Dr7R3giBczoF3p81/chMHahGQScMk37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7678
X-Rspamd-Queue-Id: A5AB052E259
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287447-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:mid,altera.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Action: no action

T24gMTIvNS8yMDI2IDQ6MTcgcG0sIFBhb2xvIEFiZW5pIHdyb3RlOg0KPiBGcm9tOiBBSSBSZXZp
ZXdlciA8YWlAZXhhbXBsZS5jb20+DQo+DQo+IFRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmll
dyBvZiB5b3VyIHBhdGNoLiBUaGUgaHVtYW4gc2VuZGluZyB0aGlzDQo+IGVtYWlsIGhhcyBjb25z
aWRlcmVkIHRoZSBBSSByZXZpZXcgdmFsaWQsIG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4NCj4gRnVs
bCByZXZpZXcgYXQ6IGh0dHBzOi8vbmV0ZGV2LWFpLmJvdHMubGludXguZGV2L3Nhc2hpa28vDQo+
IC0tLQ0KPiBuZXQ6IHN0bW1hYzogQWRkIHN1cHBvcnQgZm9yIFRYL1JYIGNoYW5uZWwgaW50ZXJy
dXB0DQo+DQo+IFRoaXMgY2hhbmdlIGVuYWJsZXMgcGVyLWNoYW5uZWwgVFgvUlggaW50ZXJydXB0
IHJlZ2lzdHJhdGlvbiBmb3IgdGhlDQo+IHN0bW1hYyBkcml2ZXIgYnkgbG9va2luZyB1cCBpbnRl
cnJ1cHRzIHdpdGggZG1hX3J4TiAvIGRtYV90eE4gbmFtZXMNCj4gZnJvbSB0aGUgZGV2aWNlIHRy
ZWUuIFRoZSBjb21taXQgbWVzc2FnZSBkb2N1bWVudHMgdGhlIG5ldyBuYW1lcyB2aWENCj4gYW4g
ZXhhbXBsZSBpbnRlcnJ1cHRzIC8gaW50ZXJydXB0LW5hbWVzIHN0YW56YS4NCj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfcGxhdGZv
cm0uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19wbGF0Zm9y
bS5jDQo+PiBpbmRleCA1Y2FlMmFhNzI5MDYuLjhmOGRjN2YwOGYyMCAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19wbGF0Zm9ybS5jDQo+
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfcGxhdGZv
cm0uYw0KPj4gQEAgLTczMiw3ICs3MzIsMTAgQEAgc3RhdGljIGludCBzdG1tYWNfcGx0ZnJfZ2V0
X2lycV9hcnJheShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPj4gICBpbnQgc3RtbWFj
X2dldF9wbGF0Zm9ybV9yZXNvdXJjZXMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc3RtbWFjX3Jlc291cmNlcyAq
c3RtbWFjX3JlcykNCj4+ICAgew0KPj4gKyAgICBjaGFyIGlycV9uYW1lWzldOw0KPj4gICAgICBp
bnQgcmV0Ow0KPj4gKyAgICBpbnQgaXJxOw0KPj4gKyAgICBpbnQgaTsNCj4NCj4gW0xvd10NCj4g
SXMgaXJxX25hbWVbOV0gaW50ZW50aW9uYWxseSBzaXplZCB0byB0aGUgZXhhY3QgbWluaW11bSBm
b3IgImRtYV9yeE5cMCINCj4gd2l0aCBhIHNpbmdsZS1kaWdpdCBOPw0KPg0KPiBNVExfTUFYX1JY
X1FVRVVFUyBhbmQgTVRMX01BWF9UWF9RVUVVRVMgYXJlIGJvdGggOCB0b2RheSwgc28gc2luZ2xl
DQo+IGRpZ2l0cyBmaXQsIGJ1dCBpZiBlaXRoZXIgY29uc3RhbnQgaXMgcmFpc2VkIHBhc3QgOSB0
aGUgc25wcmludGYoKQ0KPiBiZWxvdyB3b3VsZCBzaWxlbnRseSB0cnVuY2F0ZSAoZm9yIGV4YW1w
bGUgImRtYV9yeDEwIiBiZWNvbWluZw0KPiAiZG1hX3J4MSIpIGFuZCBhbGlhcyBvbnRvIGFub3Ro
ZXIgY2hhbm5lbCBuYW1lLg0KPg0KPiBUaGUgc2libGluZyBoZWxwZXIgc3RtbWFjX3BsdGZyX2dl
dF9pcnFfYXJyYXkoKSBpbiB0aGUgc2FtZSBmaWxlIHVzZXMNCj4gYSAxNi1ieXRlIGJ1ZmZlciBh
bmQgZXhwbGljaXRseSByZWplY3RzIHRydW5jYXRpb246DQo+DQo+ICAgICAgIGlmIChzbnByaW50
ZihuYW1lLCBzaXplb2YobmFtZSksIGZtdCwgaSkgPj0gc2l6ZW9mKG5hbWUpKQ0KPiAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPg0KPiBXb3VsZCBpdCBiZSB3b3J0aCBtYXRjaGluZyB0
aGF0IHBhdHRlcm4gaGVyZSwgc28gdGhlIHR3byBjb2RlIHBhdGhzDQo+IGJlaGF2ZSBjb25zaXN0
ZW50bHkgYW5kIHN0YXkgY29ycmVjdCBpZiB0aGUgcXVldWUgY291bnRzIGdyb3c/DQo+DQo+Pg0K
Pj4gICAgICBtZW1zZXQoc3RtbWFjX3JlcywgMCwgc2l6ZW9mKCpzdG1tYWNfcmVzKSk7DQo+Pg0K
Pj4gQEAgLTc2Nyw2ICs3NzAsMzAgQEAgaW50IHN0bW1hY19nZXRfcGxhdGZvcm1fcmVzb3VyY2Vz
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+PiAgICAgICAgICAgICAgZGV2X2luZm8o
JnBkZXYtPmRldiwgIklSUSBzZnR5IG5vdCBmb3VuZFxuIik7DQo+PiAgICAgIH0NCj4+DQo+PiAr
ICAgIC8qIEZvciBSWCBDaGFubmVsICovDQo+PiArICAgIGZvciAoaSA9IDA7IGkgPCBNVExfTUFY
X1JYX1FVRVVFUzsgaSsrKSB7DQo+PiArICAgICAgICAgICAgc25wcmludGYoaXJxX25hbWUsIHNp
emVvZihpcnFfbmFtZSksICJkbWFfcnglaSIsIGkpOw0KPj4gKyAgICAgICAgICAgIGlycSA9IHBs
YXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYsIGlycV9uYW1lKTsNCj4+ICsgICAg
ICAgICAgICBpZiAoaXJxID09IC1FTlhJTykNCj4+ICsgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPj4gKyAgICAgICAgICAgIGVsc2UgaWYgKGlycSA8IDApDQo+PiArICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gaXJxOw0KPj4gKw0KPj4gKyAgICAgICAgICAgIHN0bW1hY19yZXMtPnJ4X2ly
cVtpXSA9IGlycTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICAvKiBGb3IgVFggQ2hhbm5lbCAq
Lw0KPj4gKyAgICBmb3IgKGkgPSAwOyBpIDwgTVRMX01BWF9UWF9RVUVVRVM7IGkrKykgew0KPj4g
KyAgICAgICAgICAgIHNucHJpbnRmKGlycV9uYW1lLCBzaXplb2YoaXJxX25hbWUpLCAiZG1hX3R4
JWkiLCBpKTsNCj4+ICsgICAgICAgICAgICBpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9v
cHRpb25hbChwZGV2LCBpcnFfbmFtZSk7DQo+PiArICAgICAgICAgICAgaWYgKGlycSA9PSAtRU5Y
SU8pDQo+PiArICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAgICBlbHNl
IGlmIChpcnEgPCAwKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGlycTsNCj4+ICsN
Cj4+ICsgICAgICAgICAgICBzdG1tYWNfcmVzLT50eF9pcnFbaV0gPSBpcnE7DQo+PiArICAgIH0N
Cj4+ICsNCj4+ICAgICAgc3RtbWFjX3Jlcy0+YWRkciA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9y
ZXNvdXJjZShwZGV2LCAwKTsNCj4+DQo+PiAgICAgIGlmIChJU19FUlIoc3RtbWFjX3Jlcy0+YWRk
cikpDQo+DQo+IFtIaWdoLCBMb3ddDQo+IENhbiB0aGlzIG5ldyBibG9jayBhY3R1YWxseSB0YWtl
IGVmZmVjdCBvbiBhIERUIHRoYXQgdXNlcyB0aGUgbmV3DQo+IGRtYV9yeE4gLyBkbWFfdHhOIG5h
bWVzIHNob3duIGluIHRoZSBjb21taXQgbWVzc2FnZT8NCj4NCj4gVGhlIHRhaWwgb2Ygc3RtbWFj
X2dldF9wbGF0Zm9ybV9yZXNvdXJjZXMoKSAodW5jaGFuZ2VkIGJ5IHRoaXMgcGF0Y2gpDQo+IHN0
aWxsIGNhbGxzIHN0bW1hY19wbHRmcl9nZXRfaXJxX2FycmF5KCkgZm9yIHRoZSBsZWdhY3kgbmFt
ZXMgcmlnaHQNCj4gYWZ0ZXIgdGhlc2UgbG9vcHM6DQo+DQo+ICAgICAgIC8qIFRYIGNoYW5uZWxz
IGlycSAqLw0KPiAgICAgICByZXQgPSBzdG1tYWNfcGx0ZnJfZ2V0X2lycV9hcnJheShwZGV2LCAi
dHgtcXVldWUtJWQiLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dG1tYWNfcmVzLT50eF9pcnEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE1UTF9NQVhfVFhfUVVFVUVTKTsNCj4gICAgICAgLi4uDQo+ICAgICAgIC8qIFJYIGNoYW5u
ZWxzIGlycSAqLw0KPiAgICAgICByZXQgPSBzdG1tYWNfcGx0ZnJfZ2V0X2lycV9hcnJheShwZGV2
LCAicngtcXVldWUtJWQiLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdG1tYWNfcmVzLT5yeF9pcnEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1UTF9NQVhfUlhfUVVFVUVTKTsNCj4NCj4gQW5kIHN0bW1hY19wbHRmcl9nZXRfaXJx
X2FycmF5KCkgdW5jb25kaXRpb25hbGx5IG92ZXJ3cml0ZXMgdGhlIHNsb3QsDQo+IHplcm9pbmcg
aXQgaWYgdGhlIGxlZ2FjeSBuYW1lIGlzIGFic2VudDoNCj4NCj4gICAgICAgaXJxc1tpXSA9IHBs
YXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYsIG5hbWUpOw0KPiAgICAgICAuLi4N
Cj4gICAgICAgaWYgKGlycXNbaV0gPD0gMCkgew0KPiAgICAgICAgICAgICAgIGRldl9kYmcoJnBk
ZXYtPmRldiwgIklSUSAlcyBub3QgZm91bmRcbiIsIG5hbWUpOw0KPg0KPiAgICAgICAgICAgICAg
IC8qIFN0b3Agc2lsZW50bHkgb24gZmlyc3QgdW5zZXQgaXJxICovDQo+ICAgICAgICAgICAgICAg
aXJxc1tpXSA9IDA7DQo+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgIH0NCj4NCj4gT24g
YSBEVCB0aGF0IG9ubHkgcHJvdmlkZXMgZG1hX3J4MCAvIGRtYV90eDAgKHRoZSBuYW1pbmcgdGhp
cyBwYXRjaA0KPiBpbnRyb2R1Y2VzKSwgdHgtcXVldWUtMCBhbmQgcngtcXVldWUtMCBhcmUgbm90
IHByZXNlbnQsIHNvIGJvdGgNCj4gc3RtbWFjX3Jlcy0+cnhfaXJxWzBdIGFuZCBzdG1tYWNfcmVz
LT50eF9pcnFbMF0gZW5kIHVwIGJhY2sgYXQgMCBhZnRlcg0KPiB0aGUgbGVnYWN5IGhlbHBlciBy
dW5zLg0KPg0KPiBUaGUgTVNJIHJlZ2lzdHJhdGlvbiBwYXRoIGluIHN0bW1hY19tYWluLmMgdHJl
YXRzIDAgYXMgIm5vIElSUSI6DQo+DQo+ICAgICAgIGlmIChwcml2LT5yeF9pcnFbaV0gPT0gMCkN
Cj4gICAgICAgICAgICAgICBjb250aW51ZTsNCj4NCj4gc28gY2hhbm5lbCAwIGlzIHNpbGVudGx5
IHNraXBwZWQgZm9yIGJvdGggUlggYW5kIFRYLiBJcyB0aGF0IHRoZQ0KPiBpbnRlbmRlZCBiZWhh
dmlvdXIsIG9yIHNob3VsZCB0aGUgbGVnYWN5IGNhbGwgYmUgcmVtb3ZlZCAvIG1hZGUNCj4gbXV0
dWFsbHkgZXhjbHVzaXZlIHdpdGggdGhlIG5ldyBuYW1lcyAob3IgZ2F0ZWQgb24gdGhlIHNsb3Qg
YmVpbmcNCj4gc3RpbGwgMCk/DQo+DQo+IFJlbGF0ZWRseSwgY291bGQgdGhlIGNvbW1pdCBtZXNz
YWdlIHNheSB3aHkgYm90aCBuYW1pbmcgc2NoZW1lcyBuZWVkDQo+IHRvIGV4aXN0IGluIHRoZSBz
YW1lIHByb2JlIHBhdGg/IFJpZ2h0IG5vdyB0aGUgbmV3IGRtYV9yeE4gLyBkbWFfdHhODQo+IG5h
bWVzIGFuZCB0aGUgcHJlLWV4aXN0aW5nIHJ4LXF1ZXVlLU4gLyB0eC1xdWV1ZS1OIG5hbWVzIGFy
ZSBib3RoDQo+IGNvbnN1bHRlZCB3aXRoIG5vIGRvY3VtZW50ZWQgcHJlY2VkZW5jZSBvciBmYWxs
YmFjaywgd2hpY2ggbGVhdmVzDQo+IHBsYXRmb3JtIGF1dGhvcnMgd2l0aG91dCBhIGNsZWFyIGNv
bnRyYWN0Lg0KPg0KPiBbTWVkaXVtXQ0KPiBEb2VzIHRoZSBEVCBiaW5kaW5nIG5lZWQgdG8gYmUg
dXBkYXRlZCBhbG9uZ3NpZGUgdGhpcyBkcml2ZXIgY2hhbmdlPw0KPg0KPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3NucHMsZHdtYWMueWFtbCBjdXJyZW50bHkgb25seQ0K
PiBlbnVtZXJhdGVzIHRoZSBwZXItY2hhbm5lbCBETUEgSVJRIG5hbWVzIGFzOg0KPg0KPiAgICAg
ICAtIF5yeC1xdWV1ZS1bMC03XSQNCj4gICAgICAgLSBedHgtcXVldWUtWzAtN10kDQo+DQo+IFRo
ZSBuZXcgZG1hX3J4TiAvIGRtYV90eE4gbmFtZXMgY29uc3VtZWQgaGVyZSBhbmQgYWR2ZXJ0aXNl
ZCBpbiB0aGUNCj4gY29tbWl0IG1lc3NhZ2UgZG8gbm90IGFwcGVhciBpbiB0aGUgc2NoZW1hLCBz
byBhIERUIHVzaW5nIHRoZSBleGFtcGxlDQo+IHN0YW56YSB3b3VsZCBmYWlsIGR0YnNfY2hlY2su
IFNob3VsZCB0aGlzIHNlcmllcyBpbmNsdWRlIGEgbWF0Y2hpbmcNCj4gdXBkYXRlIHRvIHNucHMs
ZHdtYWMueWFtbCBzbyB0aGUgYmluZGluZyBhbmQgdGhlIGRyaXZlciBsYW5kIHRvZ2V0aGVyDQo+
IGFuZCBEVCBtYWludGFpbmVycyBjYW4gYWNrIHRoZSBuZXcgbmFtZXM/DQpIaSBQYW9sbywgdGhp
cyBwYXRjaCB3aWxsIG5lZWQgdG8gcmUtcG9zdCBiYWNrIHdpdGggYW5vdGhlciBwYXRjaGVzIGlu
DQpzZXJpZXMgYWZ0ZXIgcmV2aWV3aW5nIGNvbW1lbnQgZnJvbSBKYWt1Yi4gV2lsbCByZS1zZW5k
IGJhY2sgc29vbi4gVGhhbmtzIQ0K

