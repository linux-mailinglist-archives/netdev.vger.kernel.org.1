Return-Path: <netdev+bounces-298136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IOLRBhGyKmqkvAMAu9opvQ
	(envelope-from <netdev+bounces-298136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:03:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCEC672229
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:03:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=yrbQaQyh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298136-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C43E308A32B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694F33FC5D5;
	Thu, 11 Jun 2026 13:01:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7C3FD125;
	Thu, 11 Jun 2026 13:01:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182875; cv=fail; b=mQ5Yu/SKBItiCZI8o53yn1JYmIb/yMWYJa6JtWP2sCqjs3uqn4T5G7Wu+o25Jla4imHVMKkuFa5mfSqzWYhnqzUrxstkzSZDdrvzZZA38TCqEqzlvfA3kysIQa+viMf+DvPRAvIiMwzkPO5yffkcOUDjm2kzKsQlL3hVYwilq48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182875; c=relaxed/simple;
	bh=7sUkNWp/i2hIuwWjZEU7J/RaU/3m2sa/vRN2u8vYiY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8F67p9a6qf1mBCWLZweO8YSOx9ui/4Xhk4/Ld5+NxJjuipniEaqIJ5uz2tluG1veHQ9fj6AvlSF7WKqvqrMZbT/2CJ3OLrCMHf/Jqjl/OUjVw0tLnFjGu9jPeSaDSZpzxXy8gbpckxlwwOrEUOmP+o+b4rjmOb6AndEPVqm3vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yrbQaQyh; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtxXayjUj2TLaVYIg5RF02HJj0QolIRGlfbR0wmAqp6GzwG6v+GcCpLh6+Sd7F/zLAO8RM7csYEIwdw2q8NkkoHkKRFv2YdBodPE5ghsoj40yBtpX3J6WQRQTY80qDUJ7HE01vnGgv+mebWxJPPFFLI4vUkaEovQyBnNXc6fJab0rWhhdWm5JXTR6cen+y+czstrHcOed0CEt1zdv/zyKmhuLE7IlW2hSHFKZO6yuFuDQ9ig1LSg/bC50irsehesrY9+SQZU+qYJH98wMSe1iBTPbCfE4l1X/3kxppjILSqM0nNKSRqGnyex+1VPjUqM/g4r/rUgLQeyG4Pj+gBzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sUkNWp/i2hIuwWjZEU7J/RaU/3m2sa/vRN2u8vYiY4=;
 b=twNQY7aUUVzPMj7m39MzK5gXHmuiYIaNe6sBSXdUrZ+vxuv21F6mv4Yw5/rLcKuXG/esAJt774I+t+BENive1H5i2m7U/mQDSCX+XlYJy7Aac2yfLPuUBud+VIO4N2f3m9x89eZhRytvpTTNm31RPCg5io9P6lQNQ+6+F11MbpTdlTIJaOSJN0/ajwNX/B3FlzCjztLqNUdQWnOJhRV74Dzv6aN/vZLc5MHp804BGZoAVlePV7NjgUOEyjain7iwmmP9cecpB8N2tMXGqZpnQjODiwymmZRpeDiJ8QJnpb6AzZWn3jujdxzFy9sfwLWuNsSB3b07Sd7Qkthdn4U9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sUkNWp/i2hIuwWjZEU7J/RaU/3m2sa/vRN2u8vYiY4=;
 b=yrbQaQyhkN7StynEvIAPcOQJdW2GsIQr5POzxDC8f9xdGBxjWXzxzRZv1ncjFNYVU+pMLsLsVZad6efMUcNUfkNbqPM4QIbeT+Casj6no70e2u7KROYribI6FEvSevq5vi3RIZHrTqK7ne5f5juGFXrsNS8KE36fPhDqupIXIcHSE0FQgyB3oSY+VAw/KHV0Eq9LVz7QP1jzzZKd8He443bBo+aSY5hBXlVudMtFUH5zbyX+nI4jQ37bDEFweytQAf1BZeGaSBSsQiuRWTpq1LMQXJiVqdrOUredS9oQ5TUc/V2Tvs5Q4j5pAj4Ev5pqa8DclBDUa1cKotC8v0+m6Q==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CY8PR11MB6866.namprd11.prod.outlook.com (2603:10b6:930:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 13:01:09 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 13:01:09 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>, <andrew@lunn.ch>, <conor@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Pier.Beruto@onsemi.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Conor.Dooley@microchip.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index:
 AQHc8eDGO4Y2rMyEmEeRgmYw3vsZ4LYrecyAgAAPEwCAAmo7AIAAlNuAgAAUz4CAAAajgIAFcz6AgAAInwCAAd4WAIAAa50AgABI+YCAAq8HgA==
Date: Thu, 11 Jun 2026 13:01:08 +0000
Message-ID: <56e6c9ea-2e2a-406d-b7d0-ec484e3170e6@microchip.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
 <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
 <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
 <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
 <a02cd86e-a5b8-481c-a07e-7243ee537b24@microchip.com>
 <CY8PR02MB9249EC4F3896121911D0FF3C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <CY8PR02MB9249B913E28E285EB46EC59C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
In-Reply-To:
 <CY8PR02MB9249B913E28E285EB46EC59C831D2@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CY8PR11MB6866:EE_
x-ms-office365-filtering-correlation-id: 088d41ce-b1a8-4673-2932-08dec7b981a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 fcdtNnG02IDR2xmHCzsOjIe15aungS2/KebK1PjPvLv+veonENGHIrGc9+iR5CwxwvWW5Uln4adI3dDf6fwU//P6wZO/GgBRNr+Ngjd+WVmUA5dwlTiNTurd9W2RItife4q9CgEvoSsYI7Rr6YU34ONoVr40EFSixF2XVBmjXlFEFg0nMo46VmdoGEygVVVHuFCCgdqTtzu8ttzsMF7WLg0ZV7RbKokfSY5vw62pm/gyJK2WnWTN07VD7+f0sUSvY9VSZZynwj2J/6sx1LO+x8TAXXklacGeM6WMiA30Uq7hTK7JvIMOmFgw3dr+UePTAZD47hFNOkXBqabioytqWGGW3/sU3rAOEivTEoEEpsZok5XcbJtgYJxVHn3EmQAZLY6c2AF2jj/ctvpwsgDtcffD6Xwoe1Qyy1HaXDdvnfFxadiZ0GI11E1wZUmeUvKugoFrE2CkPM50265KfB8leuQVgVYE1wRmhvd5jZqGFHsAn76KzpDIXDdQX3yg02x01D+ZaA9d3xAivrY77QEmjFFBtNEML0B7OX8PsfSU3GZwKeo/SuE5DGEvQa06WUHXA9hms/CVHu1c+yUEwaA45x9F9YNTGz8PLGhGySnYsYBoJ0xazZG2v8bMhWNjflu7S7XiHCrG+90Hi5JIGppS6/E1yM5Tb4Huo1nW40G3eJzrvwnVxnbuF+JNFmBVAN9gpFeRZUk5X8d+1uvHKbGDL+iIG012cT/Yv6iDfc1zx7kooHBEoeD6YwLbM+iP4eex
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmpDaE1oWTVCVXVMV1c2Ym1CZ0JpLzd1UmRrUWJmd2Z6Ulozdmx2cWN1ZURZ?=
 =?utf-8?B?NHA3VmxobGFwSmM3dXpzYzd1ZEM5MTZzQk1JTWxyQ1M3M0VBcy91RXJINmJT?=
 =?utf-8?B?bm9Fd2c4Y1lOVGdlMXQrWkd2WnRsNWJUdmZGbkR0ekZaNXYxUFpIbDlSejhI?=
 =?utf-8?B?RE9STS9LYUVCNEVYenNpbGI0cURKbW13aG1zczFGdnhTMmgyM0NzWFc0NEhy?=
 =?utf-8?B?ZmdUNmJ1QUFDN0NrTFlWaFBhckJkeDc5TjVvQ3BMSm5jUUlXam95MVB4Smxi?=
 =?utf-8?B?N2ZIUjdoZTJNdGhONElGaGJwMENVWEVFeTloeXpYSU5KUmczV1NueUFPcStI?=
 =?utf-8?B?U0toWWpIYUt6Vzdvd0xuTlhSWEFEU0Ivam05ZEI3ZVVaSHA5a1QyYXV0ek9z?=
 =?utf-8?B?ejBKekl0Y3diMDdsbGR1SkxRR3BOZGQrK0JGUzBHSkcxYkhWb1ZBczNKWkZE?=
 =?utf-8?B?NWJsdWNpekdIejAyQmRRN3g2bHRQSUZBSlZjNzVhTjRhbTlteXU3NGgyTnJL?=
 =?utf-8?B?UitjZG5qTEdZNWYrWnlnZkRGTE5JN0pRcnFlTnZnY0pxOG1xSkxEL2FPSWNE?=
 =?utf-8?B?Y2lKSFJOU1NneFZNb0t0bms2VEVQUGhpNEFPZTlYM3JNaUFjbzcvNVYxbE9G?=
 =?utf-8?B?dm9XRkpwM0EvaU10VEY3VDl2VFdZVUwyVUc3QnhTVWthaFZzVzlraXExTTQ0?=
 =?utf-8?B?bStyelIvQTEyVHVaNTAzajlvQ3NZcjNoS2xESXhQK0RFcGFyR3RNeERpOWxM?=
 =?utf-8?B?TnQyK3ppZWoxeGJqZysxcDJCRG8vZituZFBTd0p4dnpDYkFyTTRIWk9Ta0FO?=
 =?utf-8?B?dkRiUjljZEMrbnYvVXFwc3hxUTdVTnVvRG1ka1NUYUFYNU9Db1NUZ2tMSHpU?=
 =?utf-8?B?QWxPWVZTTUJ2eURidXNhbUZIVWFZaXlZeGgzTThMbHNFK1dlVXRHRXIzVlN2?=
 =?utf-8?B?SWxYNVlJQnI1QWx6R2QvRmgvR3hESjZVaW0veDAwRERHU1lwR3ZtM1E1UE1a?=
 =?utf-8?B?ZVFVY0JFRVlERDNZZ1Q2VHFIUER4TFhoWmhsYnk5Nm15RVlXOFdadloyME9m?=
 =?utf-8?B?TGFOaGpZMUxYa21vWFBucGdvU2plSW9GcUVLSGdJaEYrd2NSVmFhT0kvdFVU?=
 =?utf-8?B?aTBUbjVNM1JBY3ZlRTlLaDN3U3ZYcXhDR3RMNW8vYzJsQk1ZMjlseEU5VjJl?=
 =?utf-8?B?VkF3S3lwcjE2eXlmc1d3cGQyY3VWcy9lTzJ0dFJQMnFLZjlKcWlLbDlPZ0py?=
 =?utf-8?B?MkFJZEhKRXozUThJaWhRT1IvYURDQXZmUk9ua1I1RE5kSTZxLzFyZVZpZG9i?=
 =?utf-8?B?MDVSSnc5aHBFSFZYV0VJbWhNRUJTK0xYMkRkUldXNmJLN0VTUGFUR1JCejRk?=
 =?utf-8?B?L0wyN1pDcnRvNGlyWXZzSFlBRi8xaEx1ZDNzUUVtM0thNE5zV0xFWkJJZnNX?=
 =?utf-8?B?OEFZVnNrdHFkSmZPTzVMNU9vS2I5QWNBUmJPcnJCeGVJNnQzbkpQTFpPWUlX?=
 =?utf-8?B?WitGNXE5d1A2dC82WUVzemtDOVlnQ1NlLzhzblpsRUw4UEZianVQRjYzYmlE?=
 =?utf-8?B?ZnJUdUtUUk1UcS9XSFZ3cWNkK0JpSGF5ejhFTlgvWkxxRFlYQmFCUUovNzlM?=
 =?utf-8?B?bHZ1Qjh3dEpUd2FDcndiU01UNktHTnV6UEJ0cVVFRUJPUDQ1Ui9KZ204UmVv?=
 =?utf-8?B?YVMzRkFvOGlUNjBGWHhJenNRTDUyVU5PTXk2NytPYkN1NDdiWkFaUEhPQjlT?=
 =?utf-8?B?UlZhVHRkOHVNVVN3eEQzZis3NEVlbXhUUjR6UVFIb2k0S1c0bk44N2RmUWZW?=
 =?utf-8?B?SjlmMTBzN0F5bnlXZXg2bE05dVU4d2JRSmVDZ0xjdE16YWdQSnNRWUUyTU5r?=
 =?utf-8?B?THpHbWRpaHp6WFdvMU5XT1h5UGhmbnhuckJ4WmtWYmVRU1NqK1ZNUENaUm5Y?=
 =?utf-8?B?TjFSczJEV1BUMU1IUWxnQzZZMjVyNUg5Q203WUthSlVXalVqUjgza21HdHhv?=
 =?utf-8?B?aUdHcHRISmdoZzZiakQzWmxLa0NxdmVDcUxVeUhSRDRVNEFmWVZRUE9XaWhH?=
 =?utf-8?B?Uml2YWhrM3d1MWl2TWc2WHpEaUNQbnZoRUlOajNLS1ZkeExnek5pUXZIdTdh?=
 =?utf-8?B?Ukd4NUV4cGFoVkljK2ZkMXpBempiRkRWcFE2bXJ5ODFQaUlMU1Jvam1TSFlP?=
 =?utf-8?B?Nlp5Mm80ZHdIU3lSL3ZYQVBTZ3lZSkhhaHNUSkV6VjJBa0lnRFJwNFUvb3BO?=
 =?utf-8?B?VDNkMm9LODZqa3c5WWZRbmVZVnNvS3BqUGlyRCtpdTJ5NjRwcFd0OWhQaVNh?=
 =?utf-8?B?WWRtaE40ckJxN0ZmTUFDRW9JMEozcGVIYmFRQ1owMmVMYXpTZVlUWmxBbjA5?=
 =?utf-8?Q?VE1oZT4y8d8i6IXM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CF0791AF9FDB64386CD5247BF0F701F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088d41ce-b1a8-4673-2932-08dec7b981a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 13:01:08.6409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmeqBWGuRYGc+JUOqZ89wSTVK3uVnrRe/mW/y02PxeVPfty3s0eUeiSa00QZU6q0H/Dzt+ifQvq0QSkSsosm51RE5tehYH+/vq7E0Nfxw/kBVrs5vQquYg/dD2KnvxXH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298136-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RSPAMD_EMAILBL_FAIL(0.00)[parthiban.veerasooran@microchip.com:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBCEC672229

SGkgU2VsdmFtYW5pLA0KDQpPbiAxMC8wNi8yNiAxOjMyIGFtLCBTZWx2YW1hbmkgUmFqYWdvcGFs
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+PiBTdWJq
ZWN0OiBSRTogW1BBVENIIG5ldCB2MyAyLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHVwZGF0ZWQgaW50
ZXJydXB0IHR5cGUgdG8gYmUgYWN0aXZlIGxvdywNCj4+IGxldmVsIHRyaWdnZXJlZA0KPj4NCj4+
DQo+PiBUaGFua3MgUGFydGhpYmFuLg0KPj4gVGhvdWdoIGNvZGUgd2FzIHJlYWR5LCBJIGdvdCBp
bnRvIG90aGVyIHRoaW5ncyBmb3IgdGhlIHBhc3QgdHdvIGRheXMuIFBsZWFzZSBzaGFyZSB5b3Vy
DQo+PiBjaGFuZ2VzLiBJIHdpbGwgY29tcGFyZSB3aXRoIG1pbmUgYmVmb3JlIHN1Ym1pdHRpbmcu
DQo+IA0KPiANCj4gUGFydGhpYmFuLA0KPiANCj4gSnVzdCBzdWJtaXR0ZWQgdGhlIHBhdGNoZXMu
IFdoZW4geW91IGhhdmUgdGltZSwgcGxlYXNlIHJldmlldyBhbmQgdGVzdC4NCj4gQXMgeW91IGNv
dWxkIHNlZSwgb25lIGNoYW5nZSBsZWQgdG8gbW9yZSBpbnZlc3RpZ2F0aW9uLiBJIHNhdyBhIHRy
YWZmaWMgc3RhbGwNCj4gd2hlbiBJIG92ZXJzdWJzY3JpYmVkIHRoZSB0cmFmZmljLiBUaGF0IGlu
dmVzdGlnYXRpb24gbGVkIHRvIGV4dHJhIHBhdGNoZXMuDQo+IA0KPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL2xpc3QvP3Nlcmllcz0xMTA4ODA0DQpUaGFu
ayB5b3UgZm9yIHRoZSB1cGRhdGUuIEkgd2lsbCB0ZXN0IHlvdXIgdjQgc3VibWlzc2lvbiBhbmQg
c2hhcmUgdGhlIA0KZmVlZGJhY2sgYXMgc29vbiBhcyBwb3NzaWJsZS4NCg0KQmVzdCByZWdhcmRz
LA0KUGFydGhpYmFuIFYNCj4gDQo+IA0KPj4NCj4+Pg0KPj4+IEJlc3QgcmVnYXJkcywNCj4+PiBQ
YXJ0aGliYW4gVg0KPj4+Pg0KPiANCg0K

