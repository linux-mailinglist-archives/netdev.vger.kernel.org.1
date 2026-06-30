Return-Path: <netdev+bounces-303311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rj/PBVf/Q2pKnAoAu9opvQ
	(envelope-from <netdev+bounces-303311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:39:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FD6E6F89
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:39:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=Mfnbn8q+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303311-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD1D53040D81
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261DE3DB651;
	Tue, 30 Jun 2026 17:36:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B4330D25
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:36:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841014; cv=none; b=OdZVjRgKuuBknE/pN+XjyXkLguODAm5qjqzwaK9JQOha3YCpeTJiykTKsweHB9yO4UmbdHwq1P30QRQK6/FmnKOKjPxFgKgomp5goclr5JvqawwwUz/8K4JS1eTr8g/M88uvBBe1M+gNQLheEhUSvezCLUp8dxQdpJqBtEwkpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841014; c=relaxed/simple;
	bh=uxRcFC5SITi4KTqlRWPoUbEPLxbmRADOPbF7cjvktNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Ny0YcWA40ry/X5mo1z860WyKt1s15SvDiRWKA1Z9uODlnGSWD6OSeaCOH4sjE0fq+loWGR7rNpZGWcXZYC+9blvrH6nXBAXzPmZuS+jlBVXYpUoMbh0agoro6DdxynA50NoC6i8XLVoyGQScvEDUQV5c/0nLi17M8pY2tcPg7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Mfnbn8q+; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782841012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxRcFC5SITi4KTqlRWPoUbEPLxbmRADOPbF7cjvktNc=;
	b=Mfnbn8q+AsfcMeGMW2igbWJoYhoYMXOGiozTbEhQFeKzMBLu2MTG5tLP7ecNAFXYx20BXC
	2DjrKSb1lRJfH/Hrik3UnhWVsb3P/Htbe180QtH9H8d9G0IE1PQpgYIDFI3/a3Ri20DOtF
	/FCICpKEV7w+/NC8VenL1bfW69psPgPTgBiOpuVV1BQOYW9/V2wmYguvKGCasx0WYCEuYa
	TqL9ROPhPiO1J4QrUVRHw/Jk8LLW2O3c2arb++1u+Q+7+lWV6BY31Qj2zpihKw4DT9Dli3
	N+UudNPqevN9jCh2aNr+glaxfIihGMeY9ufePC/duVgTUckl+smuEthPfK6J9g==
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-11-1xFjJetvO_aNny73j89smg-1; Tue,
 30 Jun 2026 10:36:48 -0700
X-MC-Unique: 1xFjJetvO_aNny73j89smg-1
X-Mimecast-MFC-AGG-ID: 1xFjJetvO_aNny73j89smg_1782841006
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by IA0PR02MB9751.namprd02.prod.outlook.com (2603:10b6:208:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 17:36:42 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Tue, 30 Jun 2026
 17:36:42 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Jerry Ray <jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v6 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v6 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AQHdB+wZw4OihCeBzE+Ub6CPdp8aWLZXVjmAgAAF9cA=
Date: Tue, 30 Jun 2026 17:36:42 +0000
Message-ID: <CYYPR02MB98284F87BFAA4474F4B5563F83F72@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
 <20260629-s2500-mac-phy-support-v6-12-18ce79500371@onsemi.com>
 <akP3jrbFLBfS5UqV@monoceros>
In-Reply-To: <akP3jrbFLBfS5UqV@monoceros>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|IA0PR02MB9751:EE_
x-ms-office365-filtering-correlation-id: 1b72aa3c-2e24-40fb-1c8a-08ded6ce2648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|38070700021|11063799006|18002099003|4143699003|22082099003|56012099006
x-microsoft-antispam-message-info: 2ukM29N4zImMNaTTPN9fsXljLudtTZ5nvUT8p2xOeYwG/Ss1MUkX+pCYS+ebQVxV/LgoYguBiywgQyJu05s/4WmYNQriK7eic4IajQ8Uc2gHai8weJ1RQ7/0pWsHAyuqgJcXlrMpxsrhtHrAiIv16mk2Rueepb2b+4tBeMutn0162TUu27Vay35KIaawfDKp8veom4cmoa8rZbVYNc0qzeTYxMoJWDkQ8xYHMX8bsusecxm5ZQs7b2vjlFO99cT3oZ1HV84XVbcjOGFGkR6kG9ackq505wEL+rz7dVieApcJXifoVWgIpPWwYr8ypi19fE5sfI7qxpaIkjmIsOslzgK0aH5ZitZGH8GkWb7BAbHuF1RUO349G/8++GN1yrLoaIjyi55Cvl4nVD5k9H6OJ6vVQa9Vn3AWzK606b8rLGLO1KmWP0HyJ1SFBnMwvrknRuovwyI8M5T34oCECSOkpJfzqFkL4q/EpYLAYJathPyLAmrA/IOrEegihkYXHdCQlW+uJ25FrdLViNjgvLTFLXSd+q3OhoOf2hR8uJreYKjfnYCfQTO+PyjuWxBGaLlvkaoGRjiojVKm5nTI81qUZLB9twaBjUsiKcpqmQKMUcifxRUdBNjkO5EowNhzcBxJ/3JC/VOuhFmIq2OpCbc1qiBfApK1YfaT+w/DfL8xop+zwPsJ0Qsewr9zRIzeE21cGK9yJduIe15trm1AAiEabn3Vbm8fFxeRBQNQO9uRD4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(38070700021)(11063799006)(18002099003)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GmQMYKZfcJT1JsDMTWoz8xjpSS92kptDxa9v5+/Zqse0diq19sUVAOT7FE?=
 =?iso-8859-1?Q?gwmuCoiCQPwmclbQLyYZE/mHltMDcZEP7++Eh6WM3gGQUbR5231eXj1JKV?=
 =?iso-8859-1?Q?jYIl7dM5PsDq2JJr/htfDpcqdXQUw9dW7wbVKvW7PheMMXzRpt/awXdCY7?=
 =?iso-8859-1?Q?Rp72CcvptusXQtG/BpGFpmX6g6A4lu1BWQJQXymvnrV3rqOiVN4NFqUr5a?=
 =?iso-8859-1?Q?jODKB6wz07YRz9ONNVBlV5pQ1X+A46ldnDuE24zEC6OrGw6191Qym0FY/5?=
 =?iso-8859-1?Q?uD79UZGoxK0of+QdKCo4A5O+Z7HtD9uCvXaWqiT7LKX68w7aoU/dpPoWnB?=
 =?iso-8859-1?Q?PsJ6PIB4IIi6eah5FBy/t9DbRqn0HSrrnRjesAOY0i127dJnx0/y0IOGWi?=
 =?iso-8859-1?Q?1MEDNsdHvBsUUs7mZz0wqOncddWZ5aqTPX3XcNeTfGwTVBHJPNgevWSgFI?=
 =?iso-8859-1?Q?GF2kCM13v90H8ErNuzMF4F6pkMrEpyZlZ18AhOhypg1fH9QA8oHZuRVH6a?=
 =?iso-8859-1?Q?/byKFdZLSlj1wwIboWIQa9qWhDeJt1UT/vSFH/YX6P0zMqCJZz3Sakh0/H?=
 =?iso-8859-1?Q?VxmrbsrbTyaCzNSmbYECE2Nsi8LnYPL/VO5PFcTxTPSjXb00UYgE7z14Wh?=
 =?iso-8859-1?Q?UW7mrPCWBb5CrLyovDO7l1YWkd5ajxK/YzgyJiOnaNMEkI19u46lu8U8v2?=
 =?iso-8859-1?Q?/rkIDNDhvyfIy29xIKiepT6+vy/3GHgfo+1CKY0nh7bH7LQXhTu/6GPHK5?=
 =?iso-8859-1?Q?biE4rWCeSZXAVkybyGJhFfrPN8CxSoFczTB24XlKOETqTGwC7G3XkBhAkd?=
 =?iso-8859-1?Q?a/Cc0/AN8zE4pl8hwF3PXO4AAH+KhCuOSfKEGWjGI2KQJa5FaFD3E8ZVdv?=
 =?iso-8859-1?Q?2MQPO+uWvTari45zmATaYanbWySpJ9d3/R5gGAZY+VgxHapJS9ulnOtInS?=
 =?iso-8859-1?Q?I8e+V4FywiS+eS99J3HduQlFZFCeq5jGRgFkszkbNGfLP0OEs/lMqU9s9q?=
 =?iso-8859-1?Q?un+yUJPtoGCml6MiRFrRvM9zMPeEjXc40b8CwwCTZeJN2KPz8I7LnJ2WIK?=
 =?iso-8859-1?Q?CBFRmXMZ9MqWZyIK996eZ+ppUtBLLfkUuXGpeDRKM81bnqcZGdfPpQDOcP?=
 =?iso-8859-1?Q?kpcRr9IQp57FE5L4Q+G299Y0ZTQ67jF/Qqh1+JLeWrEzmQ5s+L+Kob8lU1?=
 =?iso-8859-1?Q?Ti0eo8tTP2c7t9hxxwCJY0v8rsR3nGj/UsZUDndtZILhN/AsWT3uQy5qoP?=
 =?iso-8859-1?Q?ilELtK6q8YqSSrg1yidGsMHaPWBQGFH5l0RqJVKu+IhrPN9RW2HlW6qmPh?=
 =?iso-8859-1?Q?aN6jPH4gz7+g6yQuWUuCMwM2+rV0oVE0WJ166bSFZusaUzIACwaXJeYJtK?=
 =?iso-8859-1?Q?U5dtOEA5xXSHou3yILNX4jxmKecttvDNSR57v0x5dTjfcdlkC1sSf1h2iv?=
 =?iso-8859-1?Q?KZ3RwC6BEPi4YHn4SfMltU+gy237hJF6yLXJqq+GFmiQdaWf84tOFRL6Cp?=
 =?iso-8859-1?Q?lgy16S3MFwrgLVgNUA9joQO0rYmFK+3tfe8RKqBxymJUE8E9HS803UoGyR?=
 =?iso-8859-1?Q?duXqUzeyJ2TN8ZMf5NRG2bF22KvMAqdUYS2nwFjMCzsWIlUl55kzztlpeU?=
 =?iso-8859-1?Q?2R7sRkGrqF7DWwtUfFU9+8GXFDUCMltrykWt3O72RSnbz/sdxr0r5ML1qm?=
 =?iso-8859-1?Q?sgEr6HE55OHv0pFMuZ7v86QP3TCKj+BIHJqXEga55tQqqMPRgUg0Wwdj6w?=
 =?iso-8859-1?Q?PaW2qwzIxuISrtPBvOm2cQ4TuDk0OpXNByULAxzpekp6eeP+hygkd0+zfH?=
 =?iso-8859-1?Q?Atsa7sbSTpPnUNYYjYAiwMmHg+vUBg4=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Govf/IVlFvSSLrX501cjvQHXTW1NDhAaCO7B1EWZ+0B4fFYIlYxgHtXCZ3yjBND8cBRPF3cSIJbjRoN3LbVfvzctcuc5P/M8SA8+TL8iSzbQxOLc1QkvAMBmCUH/Fdbjw4odRdeApcGwZk18HxwvbV3AxuAPKtxkKpZZ6PoKjS2BhQJpF/sovEQtsaj+Gyy5hwu/G2ZJldlI9P11rOJTsQZW8HjL84w7TCUkPaUvDWXh8ub8cME163BLyrzxR5fZbe4iO3xIfktdOXCf6VYk0DtQ9AEFyx+jgSHWJA26pYZToCQaNBil9fJIxsXYGywymH1BApj0mFmvW6uibWRDmQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b72aa3c-2e24-40fb-1c8a-08ded6ce2648
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 17:36:42.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymUmzxMmhLZ0RPgea1J6E/9ITv9m8GadJ+uoStAZvkkSVM4VnphC9hyYPW0jwLL3Gd70FoiaxtJ9Hnlwt/28f1rMNmrsd5KEjBIRi0GJHQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9751
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zV2QOOVD4XD3K7Tv2LDMLXmd8fbJo_tX9LC9DEiUlWw_1782841006
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,CYYPR02MB9828.namprd02.prod.outlook.com:mid,onsemi.com:dkim,onsemi.com:from_mime,baylibre.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE1FD6E6F89

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: Tuesday, June 30, 2026 10:08 AM
> Subject: Re: [PATCH net-next v6 12/15] onsemi: s2500: Add driver support =
for TS2500
> MAC-PHY
>=20
> > +static const struct spi_device_id s2500_ids[] =3D {
> > +=09{ "s2500" },
> > +=09{}
>=20
> (i.e. use a named initializer, a space between { and } and no empty line
> before MODULE_DEVICE_TABLE()).
>=20
> Also the driver should probably have a
>=20
> =09MODULE_DEVICE_TABLE(of, s2500_of_match);
>=20
> Best regards
> Uwe

Thanks for your review. Will take care of your three comments
(space between {}, no empty line, missing MODULE_DEVICE_TABLE macro)


