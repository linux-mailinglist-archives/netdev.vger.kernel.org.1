Return-Path: <netdev+bounces-303241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J9QpDyvWQ2p5jwoAu9opvQ
	(envelope-from <netdev+bounces-303241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:43:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A566E5870
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:43:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=PDDmoHab;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303241-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303241-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D37C2300BCA8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94843C04C;
	Tue, 30 Jun 2026 14:39:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25A40E8E1;
	Tue, 30 Jun 2026 14:39:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830398; cv=fail; b=fqtbxBPFiXyRWcgO3AvGXpXizWLF3m5KYGZ+DsuVs0bIvqjBByo6z/PJ3fY2GIv7Ws7+Ol9Am6H9vA3xMEaNAWzWmn5EO8oiuT0cmqxaz9SFFpzghR77zUzmdA6ubd/lMxtfm/Wrdwy46omumxrzHRCVXLueED3qdn8vVsLTD1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830398; c=relaxed/simple;
	bh=kMiqJo01EeWY3+5U7JC6oOEt2rpKdGWhN+Fqu4Hm4F8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p61foBQapgirhWqDNpWyp+7dw1mHXkxiubvNpN5DqrMHHfYBJbeFsIeS+M9ls3g24IBwvOFfZaaoIseCS81nsevmJKaiEaQrT5DUT3n4bagnTXGMDFWQbxIMA1H8iEmLRlmsWKSVOWoE3Xb4vecoMEGY+SMNda00pBqWuI8i2dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PDDmoHab; arc=fail smtp.client-ip=52.101.57.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFk/VAlbgFR4+wXa+I+hAUuewdzlWDfpcszoNKlOjGBXH6uoigZLY6EcQhZA5WUetyMh4VV1vP+btGVIkjGQyGFCfpQPi/PUOE2R7Tlnt9+PH2hNVatzAknaiZznePclNNFb+qv3jwhTtfh2/MZFvpuq2TqXDnqWyu7Ta3LeaXrmKWfj7uz78TmXDzaIs/6lcfsAmTyvvd7jtUrVmTUb7p14KbeQw5NrSCeAPf0oh6er8qEUzvwecVh8Pgv6hm1CYWDqViweGzoZyC95ok7s2bzR905jpK4OvK3B1+ApqJlwb9+75a6ETMAkA+NtANxxyFHKC/UGyN6wGwMDzT2zSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMiqJo01EeWY3+5U7JC6oOEt2rpKdGWhN+Fqu4Hm4F8=;
 b=F4C2Ry9XUZOVvXQi0f/slnDhycs7Uwn54zTNfFDG0E5LB1Uw7/FnUBLa0n9sivZI+JGJdwETh4BMrxxxoWYhBsKm4KnJSz0BfqvwenghIPhwXdQCTkvf2w9V7UgZjMZqcpjZhiySl9ILL4YXLRdRE+U2ToUo9edQI7WJw1ZivPUdVox2ylDxWXFDUFocbqS+Hb6F3nuIo+zX6DI0VDyvFK2vfZ1WgEHheubtSpJoWg7Xn0gZAdsyMamlMh36yaLUvYqlV8V4N7bj0+8n8ui/e4+FYctn3AcoTXKApVswIMwSS+LW4HpdiFNQ89rC2e+tv/cMcivLzkfOfmD8QmBFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMiqJo01EeWY3+5U7JC6oOEt2rpKdGWhN+Fqu4Hm4F8=;
 b=PDDmoHabvkJcZLkbBTNn8xnBsXMewcok2Up2+oUrXo4sqAHob/IpObEVQ51q7SR5jvg9VYQfr2b3csk4P2u1Piw4znfy0ATaDz94Dy2ZGnibF6Tup2OSeRtIOhdcws1M7sFiG6TAAoD/+fCE+Ihwd81LPwu/ID7S1jLeyFafKx2+lHazloIIiO7K1xrelb0FIHFzmVvItTHvIUclhYpAZX9z1n/Acfn6KEidO9YMrJekJ3EyID8u0d6khVtHnsmhQKTgWSmz+dwnnNOqqmtifoJ16ZkN6ZJ8y7GFcBzlXsgektYsFgOdZCVgMmcVkNDoJyMLtLQyP5P7Jq1S0Fzwdg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MW5PR03MB6929.namprd03.prod.outlook.com (2603:10b6:303:1c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Tue, 30 Jun
 2026 14:39:51 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:39:51 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Thread-Topic: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Thread-Index: AQHdCJS3eKbhTF393kOGxrO3eujj3LZXH+EAgAALkIA=
Date: Tue, 30 Jun 2026 14:39:50 +0000
Message-ID: <347c50ed-234a-4f29-b63a-1e0010c6b09d@altera.com>
References:
 <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
In-Reply-To: <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|MW5PR03MB6929:EE_
x-ms-office365-filtering-correlation-id: 500641a4-a84d-4a76-81f3-08ded6b5714b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|55112099003|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 gqZW4IqQpyPubxsmW3xbjJ88DAogPsEoVHvHe0BO+mOqaGpWw4VfkUoQlgdOrsnRsNZ1Ur9uChZciUU8D6YiJvANjwbj0lk0IwSoeOGXLvzdCw29mnM7sN0XDWO0Uf2MXk9LN5+NiuPTg38dhSDQ+iOobryluYfKiAiA7LTHEJpqRHbeF884HvfRj2iz1AHpN4zRG0E0MdygpvF15+iN+YPVlQa7J5DrkuQtIDCasM+wNrk9AXA6vmB6P6C86YPDhADOjKiDrPPp9XLkRSvdjVh4buVB8C/mIIuwaA1PaRYyiVysdkVv+rrI9CD7tpOMRtEIPV5LFwJQuESkLzA5EECchBjlP95/BanvBn+PGHZXzinl55zKQml/EO3PKalw3CrAbcroYrGCIKVhCAy5sJkG6k+maySJnUfAMqi8J5ceE5Z0Bbmgd4LKPUyDQUpR7kzvqoyOqSkx/C+yTYKMrikOIKHGH41fAZB9IYVan0X2i/cK5bbeKf+Ve6HB55IsUTurkmpPanVYCFcBa+Iow87YBQ2XS85+1YLXaFv9LqEm67gImjYQdkjYpC7NbaSEFBt17B26eY1i07TrdMi0JtjRj8X1tza3cXCYSiJEva/7iapP4Acd0GQOY4ZKgWiXAWDYviuyoxJxMAlsIMuLyfke2VBdzAMcoQ3PKck4LPVOObF8wr01Vj6B4ZXcdAOEfsB4QNSBi2W20ZnVYqLnlJ49OeOWvkEt3VoHHNlMg3Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(55112099003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW5QZlJmSVdsWjE5Z0pzOFk5SnJkTWFiQTluV3E1ZncxM3hEb1hqSEM2bzZl?=
 =?utf-8?B?eCtBUUdiRDdZaGNObCtpZ28wZnYzTDFncEtOcituR05tMGVzWDduQXpidDJU?=
 =?utf-8?B?V2NBVnp3WHhEOXdFL1p4R1hra3MzZStDdGJMczhCdk50aWE4NmxpS2QxZ1NU?=
 =?utf-8?B?Y2RuUEpzOHJ6UVJKTzdPYXFkUENBRERCR3g1bnFCU3Qrc0d1Z2tZUnN0QmZz?=
 =?utf-8?B?ZFROYlFjOGtLQWQzWG1ueGlSRno3bk9zQzUrWEF5TUhtelFDSlltdGNDdmdS?=
 =?utf-8?B?Umx2T052N1RxNGZ1OXIrdDVmVFNwZmd0V3JUYmpnK3BMejA4eFg5MVVyNVBo?=
 =?utf-8?B?Mzh3TzFZQ1RhcFZIb01HTzE0bHp4RVRxZ3VwT1BIR2FvU2VvTHlyVUVMaWls?=
 =?utf-8?B?cHJIeTJKOWZXcFl0TGIxUWJVMFh4UmFXNEtLU2NoQ2hGakN3bUloMHA3SXFC?=
 =?utf-8?B?cG85c2dUdmx0OXg5Wk5MdXduSjVwY0hoKzBzQjkvbUtqWEpBMTJGcGVxU1g1?=
 =?utf-8?B?VEFLL0NvMjFtQS9lbnVFMEk0amY3eXJ2cUxLRFVwQ3llc2tkTzV5Wmd2dDE3?=
 =?utf-8?B?QU10eEJTdnJwMDhCajZRTndtTVBhUE40SEJQbmwrdVlybnU1cmhFVnFueC9r?=
 =?utf-8?B?Y0tPOGlsdTFEai9BMGRlcU8xTU5XeGRoOWs3SWZOZmpzSWswRGQ0SjVVd1ZU?=
 =?utf-8?B?ZkpsMXNaOGJ0SU8ra0NUK1o0bGExc2o4ZENKSDVMTU0yR0RpOUlXZy9BVlhC?=
 =?utf-8?B?V2szNUp0UTIyc0VrSEZmbDN3YkFhMFEzZk15czN3WDZHK1ppL2N2bUF6TmNk?=
 =?utf-8?B?UDF6TGZPMEw5bjlFNUxZUFkxd2lNVWNnNU8xVGlKMUs1TkNiUnVTOEVCcFdo?=
 =?utf-8?B?L1pUYlNqWElLNjEzOVpZdUhwVXNJTTNLMk9OZWc4V1Q3bnZVdnJjTzFLLys4?=
 =?utf-8?B?Z1Z0TXZwdEg3ZUZhdVJMTjZKL2JvYWtTOXNFYTZ1RFVHdklCTjRlL1NmMm4x?=
 =?utf-8?B?bUsvVDB1MGgxQXlQVW1QOWtjQXF6TFlXYWpNODQ5ZFhlK2E2ckEwa1BLUGE3?=
 =?utf-8?B?WGVQQmNFRllFamkzTWZlM0pnQU9MOFpZcDNjalhuQlZWVG9CVUo1VGsvUCto?=
 =?utf-8?B?N24rTFhrcW1mRXBCNmlLdE5SSlJzclBzMVRUT0ZHQzFPL1FJdGd3dXJIbjN4?=
 =?utf-8?B?dHo0WmF2MkhDZEtGSjZrdU95Qkk1YzVZY05vNU9zSk4ySDhKYkNVMENGb0ZJ?=
 =?utf-8?B?ZTdjdUUzN2d4dkMrenI0UHNVRWtEZnlPVnRRZENYaXlJN3lML0FSdTA0NExl?=
 =?utf-8?B?M2ppajdQWnJ3enY3MHFFNlVRU3NXV3pjWmJ0NkFFeXI2WTQ2WGFkQmxSK2g5?=
 =?utf-8?B?VnFrUHdkRlRjMnVUSFIwNzdVNnp1QWt5RlBOY2NSWkFqQllaN0tUVXhEKzFz?=
 =?utf-8?B?S2E4RmhZTG1OWmVZMWhmMEVhUElpVW9HMDhUdDRKVWs1QkNOSm9qYURoSU81?=
 =?utf-8?B?YVlNVytXZFU5UG95VFFYZHV6RXJ2TWJvdStSN3V3TUtLbkFTZFd3dDBtQ1J6?=
 =?utf-8?B?WnNvaDAzNWlVTEJ5cXRjRzdldThkeTZteGpkNzF1MHlUNFZCTTNPTFgrWC9Q?=
 =?utf-8?B?UUh6Z2REOTg3Y3g4aFVKc3Vhc3JHb1BnU3lUTFJ4dWlYcEVKZzR1bHU1TDVP?=
 =?utf-8?B?TWdmWlZ5VjVGdGVXb1N0U1JpSVFwNjRHbHFlNHZBSHBldThtRGtyMUhkZ0Ft?=
 =?utf-8?B?K3lZeC9sYm16QkRnQmU0aCtzK0doSjBNS1BsQlZNdHUxMW1NNkJVcnA2UGdh?=
 =?utf-8?B?Z1ZnMjBWREgzWkRrZ3FBN3lBNXI0QkdXUEEyMXZzVlgza3I4MFZpZm1nd1dR?=
 =?utf-8?B?MGU4RGlrU0hXL0pDM1krUlMwS0NRRkgxK2c2a01mUW96Tk5TYnBRMEpqQXRW?=
 =?utf-8?B?RGQ2elZmN1lvSDFHSVpsb2dCY082SS95N3g5VU9ybS9NY21nQ1pmMi82ZVB3?=
 =?utf-8?B?UGgzY2dNSmlvMWErU090QjRDMm5PVG9KVUc5MWdwOUlWa09tcGdjaTN3R3dF?=
 =?utf-8?B?RnZDVFFUeVduc0lCZDFKRkRFcWhmaUYxTVBjVk9zUFhSdHZ4K1E4dHowOHBV?=
 =?utf-8?B?SlBBOTdid0h1M2UrblpvT0dZbDdCa0Y3bS9lRUd5YldPM2xzUWQ1VG1hSG5E?=
 =?utf-8?B?bnNiUEpZaHRHL0JkT01sejk0R09ybjVUekNRWW10VXNuK2ZLZW44eDVjNURH?=
 =?utf-8?B?S1lxM1BJZ0NWZU55bWF2YXBDaGxqSDBrcEhBUFRrd2c4RFRkb1RvMXk3cWVr?=
 =?utf-8?B?d0pjMEhiWmhzMVk1STlWVE1HNmpzYlZvTWxDK2YrQ0xnVDdpTVpnRmtCVDFJ?=
 =?utf-8?Q?B5sy9rNFj7mFLoDI15VicsBpmhFp4jObnJITepVcUYo6N?=
x-ms-exchange-antispam-messagedata-1: hU57/P1vFEQlYQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <07DAEEA5BDDFC1429211FF3ED10031D8@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 500641a4-a84d-4a76-81f3-08ded6b5714b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 14:39:51.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZcmcHHZd76RzJpydwKX3mIg7Ej3ZUaAmNukwkTccJMvOk9M0//XYK22PX4REo0TG099ZjOmfG2Cl5zUkZe5qN1it32MZNokHLiCd3aERYjSK52YFP0IQaUsuec/GkDJyYh3+CjkaeuoE/KSGnVcixw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6929
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303241-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8A566E5870

T24gMzAvNi8yMDI2IDk6NTggcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4gKyAqIGdtYWMxIGlz
IHRoZSBUU04gcG9ydC4gVGhlIE1BQyBvcGVyYXRlcyBpbiBHTUlJIG1vZGUgaW50ZXJuYWxseQ0K
Pj4gKyAqIHdoaWxlIHRoZSBQSFktc2lkZSBpbnRlcmZhY2UgaXMgUkdNSUksIHNvIG1hYy1tb2Rl
IGFuZCBwaHktbW9kZSBkaWZmZXIuDQo+PiArICovDQo+PiArJmdtYWMxIHsNCj4+ICsJc3RhdHVz
ID0gIm9rYXkiOw0KPj4gKwlwaHktbW9kZSA9ICJyZ21paSI7IC8qIFRYL1JYIGNsb2NrIGRlbGF5
cyBwcm92aWRlZCBieSBBZ2lsZXg1IEkvTyBoYXJkd2FyZSAqLw0KPiBDb3VsZCB5b3UgcHJvdmlk
ZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhpcy4gSSB3YW50IHRvIHVuZGVyc3RhbmQgdGhlDQo+IGJp
ZyBwaWN0dXJlLg0KPiANCj4gTm9ybWFsbHkgd2UgdGFsayBhYm91dCB0aGUgUENCIHByb3ZpZGlu
ZyB0aGUgZGVsYXlzLiBUaGlzIHNvdW5kcyBsaWtlDQo+IGl0IGlzIHRoZSBGUEdBPyBTbyBpIG5l
ZWQgY29udmluY2luZyB0aGlzIGlzIGNvcnJlY3QuDQpIaSBBbmRyZXcsDQoNClRoYW5rcyBmb3Ig
eW91ciBxdWljayByZXZpZXcgYW5kIHllcywgaXQgaXMgdGhlIEZQR0Eg4oCUIHNwZWNpZmljYWxs
eSBhIA0Kc29mdCBJUCBibG9jayBpbiB0aGUgRlBHQSBmYWJyaWMgdGhhdCBpbXBsZW1lbnRzIHRo
ZSBSR01JSSBjbG9jayBkZWxheXMgDQphbmQgaXMgY29uZmlndXJlZCBiZWZvcmUgTGludXggYm9v
dHMgdmlhIHRoZSBGUEdBIGJpdHN0cmVhbS4gVGhlIGRyaXZlciANCm11c3Qgbm90IGFkZCBhZGRp
dGlvbmFsIGRlbGF5cyBvbiB0b3AuDQoNCkJSLA0KTmF6aW0NCg==

