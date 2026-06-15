Return-Path: <netdev+bounces-299328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Te0NKOeSL2r3CgUAu9opvQ
	(envelope-from <netdev+bounces-299328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:51:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF568683961
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:51:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=QglMnNFv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299328-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7283008749
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A13AE715;
	Mon, 15 Jun 2026 05:50:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80063AEB38
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781502641; cv=none; b=OsJ7NO51rq9J7bVJaE9rJwSIzhA8hDsMEEzZ97hlayK2hKZQ7CwY+tXG5ToSKCHzKYYc9atGE3P5kaMg7rRU3R+GH9TU07PunepBsft2sfkpeRK9bK716WMSEfo+3qAbxRjSHAZ4hy353v6tIM+ZsbnWamqThqM638bBVF8tvAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781502641; c=relaxed/simple;
	bh=MpZtlgtq428+fAJADzsAk2b3blz0z457ZXFvTsXJtVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DNCb58oguOOd5+iAwU6X0SArtp5wEqqcV2pxtlGbhjxjQYMuAqmrNujo19scQvZNv/oOm6DWUr0gYopCqJtr86ctg/kDOxv8HsDELGS6rWJBtZ86urTel/GRhU32ikZc85vW4GNbIUzOzUuXTlxGJDVc7tDTsVzbd8w6aUtNBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=QglMnNFv; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1781502633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpZtlgtq428+fAJADzsAk2b3blz0z457ZXFvTsXJtVc=;
	b=QglMnNFvyzUqWiakMcRpEOgUWYIFh+nO0IXFOSqI0K503N+4mEwNO7TOE3Ab0jPWiSDDqD
	Rx4CouvGvdwmhpvrTqpM8lMGPBWmPIYts4hBKYr5D2tWZV1p+2moBV2O8RwYjo/2Rb6SKw
	n5EtUL2lawCEO/IkygJ/KCAtzV0/6q0mcQy9DBMaI3qCnaYjl9g2uLKhPdZUFnDZnnkR3n
	KslK5aGF7GaQXL5A4VPZF6PSQCmq0upM3wvIyuwlBorH+jRCXDNu2cb7kNlMYCEE3B0GEl
	cVG8hYrvWAWiVnCmheDfzBmiTfEqehYYvOSf6NphfSvg+edmCn3YyJL+rd2TIA==
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-17-GHWymTYsP1idVeb8xitvag-1; Sun, 14 Jun 2026 22:50:19 -0700
X-MC-Unique: GHWymTYsP1idVeb8xitvag-1
X-Mimecast-MFC-AGG-ID: GHWymTYsP1idVeb8xitvag_1781502616
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by IA3PR02MB11199.namprd02.prod.outlook.com (2603:10b6:208:542::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 05:50:15 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 05:50:15 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S2500
Thread-Topic: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S2500
Thread-Index: AQHc/B9zVG+75VEz+E+ClqG9Xmjc7bY/Aa4AgAAbL7A=
Date: Mon, 15 Jun 2026 05:50:14 +0000
Message-ID: <CYYPR02MB9828A533A6628CC7391A7B9383E62@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
 <20260614-s2500-mac-phy-support-v5-14-89874b72f725@onsemi.com>
 <20260615041056.GA1426553-robh@kernel.org>
In-Reply-To: <20260615041056.GA1426553-robh@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|IA3PR02MB11199:EE_
x-ms-office365-filtering-correlation-id: 122d1536-7faf-4d39-f58c-08decaa1f90e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006
x-microsoft-antispam-message-info: 9hgzaVHqLx9N09rnKpDbdtVbKBxsCY0e/dAaQTZKHb55KMRYX6CiYczQViDDTJ2MpryrLG6FLFgSvhqbc0BwZ5W9HeIVylLpo1ntQRiXao+NNL7AqRsCIE7p4McwujX/GA4vnNT/84RWV+yVXp9xacshK7N9HAs0vFxX3yu9N4hZ8ErqDiwibLliblFl7Xw2yC15uV/HJUHZIW2ZCYMZhXU9ApkgZT+t23lgQLWNdDqz7LIUIGUS0uUJgpLb4JrYBDZ9v7ftKWWu3ncYgbYxI09SxMa9Cxw7L0Sq7qFH57YnRNLOJnM1LjVIXDCv5kuj3dzGQFRdByKn/rnjGb72XIP7qM8UJSMyA/JQ7oKJFFuWvjLRPgS93kYcdj6Nd39H7/tP3S8cD6RkgalHvJ2541rdQGWc02ybzIxT447FoEmMEOy2fiBvsJEbLCamPG1ovDotmlHKE+2Ba/Y0+RezwQ3wa6NP8P5pTjLQa2hGXVjLAVpqGDdaKlBE3G3aYNWGmGVJ+s9ePybevHBDb1SSwnt9D6pzSnUeP8VUSKUaTsqD4JBvoVUTz24mMqF9uXT5c/wRx21KXkUmzskcyVwJ1SAVeKc9cSdG3DtgWIgxel3EyPGKvO/q1HAoZTkccLUWwBeyd9HD+Pw887VVH21OnVGnN+toi7+GSiWsxTYtYPbuvdi/D0IZ2N9++9YKqHj/cZT059/jgytHQQWwELYv8QfDBTXj7e6C8P8WAVPHHwauoWvtsJwyJi9k/ArlLjl4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3Q5dkxKSm52Vit5Y2gwczhsMFVHaTI1OE9HRlZDdVlQbm94eFFKY3Fvb3Iz?=
 =?utf-8?B?UFdVZS9vOUNtQ01wby9pY3RZOURpMnJPRTFXL1BXcmlySUlhNTh3dDBFMVJo?=
 =?utf-8?B?ajVac2NWeERjU3AyTjIvVkc3RndDdXZId2NhNTZrTldZOWwxcC9TTWY4UWpu?=
 =?utf-8?B?dXFnK0tOVUVMVU9NdW1HTk9lOXB4V2pacXVDWGVrcU5UZkhOdWtYQzA0SzdL?=
 =?utf-8?B?Q3BUeXZyakFXZFFLdWVBam9yeEMxdm9RZXRjQ3FkTWZ1QWVjRFNtc3RTV1RW?=
 =?utf-8?B?WjVibXhBTzd3L0h1a1hsRzQ0QXFtYjZZK1lueHZtNmpGQXJ6bDlXSy9rL2F0?=
 =?utf-8?B?WDVVSHZyWXhZQmY3ZHRDQkJiTTFDck82VnpzNjUraXgrbG1uZnhKMGQ2blZO?=
 =?utf-8?B?YUMwNXl6NGlQcnhSVHQ1bkZOakY1RUVGRVp3QURleWxLR3JyV0N1QW5hSHdv?=
 =?utf-8?B?dVdJZ1kyWXY2dmM2QVpNQXZDS25rSEJ1RERIeWtGL0ZvTW5NdkkvOWF1Z2hE?=
 =?utf-8?B?V1VQM2xUb1VYcEh5S1ZQNWFQS09oVHdrem9YUFJSN3l6USt6dithcjNRRU1D?=
 =?utf-8?B?NGx5Qkd5eHlQTmVYNmJDT0liWVhOc3R3RkNLZENDa3ZzcFRpRjZOeGZETkRs?=
 =?utf-8?B?dUpMMzhzZVAyUnJYYk1HZUlXYjdIMjZxTDcvRXZ3QjBNQWNnM1pmQTZublhm?=
 =?utf-8?B?d24rL1FtYi9id3JjOWlLSlc2OHVDZkZnSmNpMTJDak9ycHB5ekZ3MnRIdWlY?=
 =?utf-8?B?b2xQMVF2eWhWdm5UWWpGYzBUMndwNmwrQWZ5eG1CT3JmNElCdldxZmM1MDUy?=
 =?utf-8?B?ZVRSMnI0dmRHbXplK1M4Mk42R05WT2svRkR2K2FBS09NZlpzdGtaYTlQVEw5?=
 =?utf-8?B?VVdUK09VT2s0dWpDQkRaekU5QW5PS0lVeE1uc09CRWFpRXZJQ0VITEdLWGlU?=
 =?utf-8?B?ZklPOUxSa3ZmY29FbVdBMDJFVG4vVWpMZ3dyWXBqb0ViWEhDajdDR1U2QXV3?=
 =?utf-8?B?ZzBiUHpzWEtsV0xja0pseHRrZ2VjNjBTWjV5TFZnMlYvaFBRUHVVOUx5dG9M?=
 =?utf-8?B?azRVeWdicll2aWFhVURKOXo0aU5Vb2hvS0l6SXI2cGJmV3FrVW96YUkvbTFw?=
 =?utf-8?B?aDIwVHgzbEVuWTROUDJ1YnIzZUdpaE43N3lZVU5NSUhDYVBmOFpRZWRTbk9X?=
 =?utf-8?B?UVphQmNBOWQ5cHZGdW9jZDIzS2d4THFNcWkyOGsvRmRYQ014U1VIa2NIYVBx?=
 =?utf-8?B?M2NaZ1pnczQrbmJYOWtndTduMFc5YU5sTG5laW9jbTRIVmI1SmUrak80Q3gv?=
 =?utf-8?B?M0g1UzdXVXdGek8raHMzeFFuRGNpbWsvMGlmWGpkZEtod2pyS0M5Q05oWkxS?=
 =?utf-8?B?OWZ5Zk0yaG1IMzdkUmx0dTkvMWMvc3BDVTRzVmtROTFzR3VXNTV0cVZkOHlT?=
 =?utf-8?B?ZUcwejgzcDV0SDA3M0hSajlxWEM3RE14MExqSUpRZ0RYTlBaZVhMNDV3cEdM?=
 =?utf-8?B?OVYwUkZ3WThYQVNmOUdENDdBK1h4b3FlUzlPaXpnVG12bTdoVXZjQVJnd1U4?=
 =?utf-8?B?NFBnVk5WY2ZZU2lkOS9YbCtTcXVMTVZtSWc5dkxLditBeDdIeG95VlBqUTE2?=
 =?utf-8?B?SjM5bVlmaThNSGZ3dlp2TEk3djhxaGhPclRROEMzaU1QeTlYckdINXNmYXBx?=
 =?utf-8?B?L2dhSkNOWnV5WWZKSC9xSzRrcXZRTXMrV2xGWXFZTkVBMGM4amw3K09QRERE?=
 =?utf-8?B?TGx3UU5yR3YwNzRuZjdkdTNSM3YvZ2JtOHY4aTBndVNiNzh2SWNvZE9EenB3?=
 =?utf-8?B?aExhNm5EQjIzNFRvdnI2RFdraWRVVXFpQVc0UUxUczBKTVhCemFJVk5sT2VY?=
 =?utf-8?B?UVp0VE9uWTV5SncyK2svY3FZdE1WeVlIOXV4NERlWmF2ODBsYWFxRmlBYlVM?=
 =?utf-8?B?VmFkN0lPSitBQmxBRndTdnpOV3FXOXBybzZCdGZVTXNUaXZpcEdHOXZ2Z0I4?=
 =?utf-8?B?Uzh1RS9BN2NKSnJ5TEJGQ0w4WDNxaHI3RGNEUDcrRjlqWW5BTXhjbjNLcGlJ?=
 =?utf-8?B?TnFGWFduZTlrRGpUWE9Eam5IOC84MnhaTEQvRVBPM0VFcjU1UUVjeW1Kcmgr?=
 =?utf-8?B?bk5IQkJSVlAzeG91L0Z2SWlDOS95dGJnMlBILzZUTzN0ME42V1FVbmttRE80?=
 =?utf-8?B?S2NOWEVFcFI0WThtcnozRVd2M1JzMW5USUZXM0NjRG9Ud3htcDRXTW0vUjc2?=
 =?utf-8?B?c0U2eXNsSUlWNk9kUEQ4MHoxdjBQZE5mcEtzVVBBYnZDRGdGa2ZSRFBlamVt?=
 =?utf-8?B?OGdlY3hoWkJ5SllDam1Sdm51Q204R0ZVNG8xYzFWU0c5alZtWEZlRXNZNDNj?=
 =?utf-8?Q?33/s8axe7bo1gXZ4=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qwQ9c88/TW5aignSG0aLH2ixC26FE3y8xJZ4qC7L24WF/oBRmdd9Z1EqBt5ZIVrNqXo7PYm4oJyhb1nPQ4f4osOh5tw1Ic1dl5Q2xfVsDETlsMT/+a+CXO/w+L6G/N4JIGGk2Myy+C4+ZwX3MeRhrzfTkUgXak+93J4Wwbh/62G4KFODgeck/R77HcrJ6hl78a1b+I7LLg8EHhq9tKEK7M3eA7DDpsvq8tdYEpXiWANP3+zRJbBQWn7P6MZbZAAK0pB15YoGcLL3vrjtcvPYuQgGE+5xVaJmO+Mw6gWmdVlStRXXwyK1bkeJHeqHTaO+kkdgwZwrP5FW5sDr0ppT8A==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122d1536-7faf-4d39-f58c-08decaa1f90e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 05:50:15.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZdwIyeDz4qLgKMRQjgclBZVK3GaqC3/zt/8oWuUv32NGRM9u+OTygS1bfo3TVxuVrbmUdOTRZpnwCSprHGG1WARXmY8ZZDoEojfjRIZWMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11199
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HRouXME2fZJtF36FrsKYhR8kf1HuloVt9zkgVb2g3u0_1781502616
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,CYYPR02MB9828.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF568683961

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHY1IDE0LzE1XSBkdC1iaW5kaW5nczogbmV0
OiBhZGQgb25zZW1pJ3MgUzI1MDANCj4gDQo+IA0KPiA+DQo+ID4gLS0tDQo+IA0KPiBFdmVyeXRo
aW5nIGFmdGVyIHRoaXMgaXMgZHJvcHBlZCBmcm9tIHRoZSBjb21taXQgbWVzc2FnZSB3aGVuIGFw
cGx5aW5nLg0KPiBZb3VyIFNvYiBuZWVkcyB0byBiZSBhYm92ZSBpdC4NCg0KWWVzLiBJIHJlYWxp
emVkIGFmdGVyIHNlZWluZyB0aGUgZXJyb3IgaW4gcGF0Y2h3b3JrLiBGaXhpbmcgaXQuDQoNCj4g
DQo+IEFuZCB5b3UgYXJlIG1pc3NpbmcgdGFncyBmcm9tIHByaW9yIHZlcnNpb25zLiBJdCBpcyB5
b3VyIHJlc3BvbnNpYmlsaXR5DQo+IHRvIGFkZCB0aGVtLg0KDQoNClVudGlsIHYzLCBpdCB3YXNu
J3QgdGhyZWFkZWQgZHVlIHRvIHRoZSB3YXkgSSBzdWJtaXR0ZWQuIEJ1dCBJIGNvdWxkIGxvY2F0
ZSB0aGUgbGluayBhbmQgYWRkIHRoZW0uDQoNCj4gDQo+ID4gY2hhbmdlcyBpbiB2NQ0KPiA+IC0g
bm8gY2hhbmdlcw0KPiA+IGNoYW5nZXMgaW4gdjQ6DQo+ID4gLSBhZGRlZCBzcGktbWF4LWZyZXF1
ZW5jeSBhcyBzdWdnZXN0ZWQgYnkgQUkgcmV2aWV3DQo+ID4gLSBjaGFuZ2VkIGludGVycnVwdCB0
byBJUlFfVFlQRV9FREdFX0ZBTExJTkcgYXMgaXQgaXMNCj4gPiBiZWluZyB0YWtlbiBjYXJlIGlu
IG5ldCAoc3RhYmxlKSBicmFuY2gNCj4gPiBjaGFuZ2VzIGluIHYzDQo+ID4gLSBSZW1vdmVkIFVS
TCBsaW5rIHRoYXQgZmFpbGVkIHZlcmlmaWNhdGlvbg0KPiA+IGNoYW5nZXMgaW4gdjINCj4gPiAt
IHJlbW92ZWQgc3BpLW1heC1mcmVxdWVuY3kgZW50cnkNCj4gPiAtIGNoYW5nZWQgdGhlIGNvbXBh
dGlibGUgc3RyaW5nIHRvIHMyNTAwDQo+ID4gY2hhbmdlcyBpbiB2MQ0KPiA+IC0gQWRkZWQgdGhl
IGZpcnN0IHZlcnNpb24gb2YgWUFNTCBmaWxlIGZvciBvbnNlbWkgTUFDLVBIWQ0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogU2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBv
bnNlbWkuY29tPg0KPiA+IC0tLQ0KPiA+IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vbm5u
LHMyNTAwLnlhbWwgfCA2NyArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gMSBmaWxlIGNoYW5n
ZWQsIDY3IGluc2VydGlvbnMoKykNCg0K


