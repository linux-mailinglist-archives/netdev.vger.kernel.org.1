Return-Path: <netdev+bounces-188795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499BAAEDD9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 23:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7AD1BA8D68
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 21:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8D290083;
	Wed,  7 May 2025 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b="D/amZC5e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2102.outbound.protection.outlook.com [40.107.94.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6028FFEB
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653024; cv=fail; b=kgCSwYeUrdgpunxY0Ri1J36KeaY6EYqsyiKsg0grSGHfM9UqschC6PYUtpS8Vv5o1JbeP3VhoDyGfHoLc3psn8o6+5Ct75VY60CpdmxzupHwgxDFuuaA8MK/dSmkzVL7zmpq/AeUCJTiBETqT4mBsvDTyVe2Jh/fGPN3u0nFz+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653024; c=relaxed/simple;
	bh=7hx5ZQ7C9FVxgN8jW1BDmOTsieVAHaGQWZ1fYMtzjAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PaYNsvaAlVRnp8SZyQJrkdax6bAzIxz9v1DmqOSk0pu+Sjx97okdJykgLkRePEeNwv0eLIZutDuzcoRKmGGuNpuU6VtMm3G+NsYdS6KUJUnQ1OHQhTr3HWVss1usPxQpITwTd/1RxK41KsWs4pNTnjMkfR+UuMsWiHhpTqUt2oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com; spf=pass smtp.mailfrom=palmerwirelessmedtech.com; dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b=D/amZC5e; arc=fail smtp.client-ip=40.107.94.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palmerwirelessmedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9exCsqhIIlSR1Cb6uUNTZxZKLxh2uVNjvqKD0nm8vSw6N81M9wA7YgbKjGKt0WoH/rPxCQQVSVLYIRPZUgic9KxFn5hbJV1P+kNZYEPST42QOe5N9lJgeJeElvqM0Wc2j7KNyVnokD026LA5CyJMj3fP2LbtuzHZXeYUSdv6iI1gXmje37LbNbsStY3FR7dmQwLgSctatWpqgNuTCE7ELVZ5dbgRp/5oaOJanLi13uIyxDWoKmaTjENOwd8AfEzUNLa7qK09VWTDqtmX8aq/kso/ykTLDGQk0zpxds/zv0HEPvMp029NthZxY2TN8gLMTQXSTvHaol59Ck5Y2DqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbyqgYoVLxzVS2arYawuUyTmNenSzplOJMNDMNubADs=;
 b=M4wXcaVncWiJ2Auqlfb2AIXqxlTKC/mKPRzIxpOiQYr4Z05L1MJQGdpZs3dDZiB7aeVa6G4ziStKaZqD5hl1YpJB9bkEedm81Pz2IKXIG6jP2/BaaQby+cpf6riEXf0Umdg/bwiXyBDBY2GjtpmWYEY4hvY7sMB1LKAY3QIpUVdptRtVExXybv3dZeisAd4YV16sif7lNQUkxYrj6IQPgdJ4BOdJcd05U11jwp4i6iJuELtGLJSlhoyvh0nuMgc/T2Dqi9CRkhidlLpjaJkyFgZZYIAmRRA/Ss7oBlPtvzpJeYM5zeyAfQiQM79rC2I98ToY3c/trKNL+Ox8MUXr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=palmerwirelessmedtech.com; dmarc=pass action=none
 header.from=palmerwirelessmedtech.com; dkim=pass
 header.d=palmerwirelessmedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=palmerwirelessmedtechcom.onmicrosoft.com;
 s=selector2-palmerwirelessmedtechcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbyqgYoVLxzVS2arYawuUyTmNenSzplOJMNDMNubADs=;
 b=D/amZC5eI41uSBV3Hh51JPGVniJH9CSVaIdI5INHf4wp+BZGa2lCcS3Ad2M1VqUkajH6viTTh08YADBU5SZqoUBnNXXhJ5FPh8EwlU0sOh+iTR25o4qHzbXeiI5SAm165S1aLd7pU5KYEgFGjoIX1SqE5fa4dh45KRfywNQ0/kk=
Received: from IA1PR15MB6008.namprd15.prod.outlook.com (2603:10b6:208:456::5)
 by SA1PR15MB4872.namprd15.prod.outlook.com (2603:10b6:806:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 21:23:38 +0000
Received: from IA1PR15MB6008.namprd15.prod.outlook.com
 ([fe80::a280:9c40:1079:167e]) by IA1PR15MB6008.namprd15.prod.outlook.com
 ([fe80::a280:9c40:1079:167e%3]) with mapi id 15.20.8699.034; Wed, 7 May 2025
 21:23:38 +0000
From: Steve Broshar <steve@palmerwirelessmedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Edward J Palmer <ed@palmerwirelessmedtech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: request for help using mv88e6xxx switch driver
Thread-Topic: request for help using mv88e6xxx switch driver
Thread-Index: AQHbv2Bc+TYavxBZNEG3KPwJ+KHfDbPHRtgAgAAyN4CAABGqgIAAIQog
Date: Wed, 7 May 2025 21:23:38 +0000
Message-ID:
 <IA1PR15MB600866E9A68ACEBABA6F1D7BB588A@IA1PR15MB6008.namprd15.prod.outlook.com>
References: <20250507065116.353114-1-quic_wasimn@quicinc.com>
 <d87d203c-cd81-43c6-8731-00ff564bbf2f@lunn.ch>
 <IA1PR15MB6008DCCD2E42E0B17ACBC974B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
 <0629bce6-f5eb-4c07-bff0-76003b383568@lunn.ch>
 <IA1PR15MB60080519243E5CCD694FCBD4B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
 <86c1f4b8-8902-42ea-a3ae-9b0633f516ed@lunn.ch>
In-Reply-To: <86c1f4b8-8902-42ea-a3ae-9b0633f516ed@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=palmerwirelessmedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR15MB6008:EE_|SA1PR15MB4872:EE_
x-ms-office365-filtering-correlation-id: 57b816b4-92c7-48d5-6759-08dd8dad6e9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VhOpGh8uKcxNJX4yQmE5RX5WUErGPNIYpV62/dUHVy87P+Q7Cyt4qamS75aT?=
 =?us-ascii?Q?mKDqpSclWrOb7tFA68eZMTuK9c1KO2nH1K+EC0z5QV5/XiZwV34XHgG4oQH3?=
 =?us-ascii?Q?w65rVt5F6m8Z3HFUHH2w2QbYmn/o0pnShxzjx4WUUwK6wl8JFpCf/Ro6f00+?=
 =?us-ascii?Q?WyMYtUtwIRNsBmS/02BIgDpmtcQLOTzp0krhFRFyjKQ/2UQh5ru4V/fWbAw9?=
 =?us-ascii?Q?FFKBgFomukHsFxHp373M2RniQeVGgMS6zXlDhYqIq2H/m4iI6pX7yYIvrJL+?=
 =?us-ascii?Q?1OLkXwLYYaG1YTRLQc8sc05QsgNxaGc62xF031YGx3zZiM1cyNrrK4xcoyks?=
 =?us-ascii?Q?PRJxcKtdR9+i1KbR7jroRE2fmk9d27I4OC8HYTJP7G/iLYbz7Yk/7ZYdpvlY?=
 =?us-ascii?Q?fj6Gq5seGFuGHEaC4K4ZWdjJ3lzEA4dYKrsobkEHQvptkbVwZVf4GxJmMC31?=
 =?us-ascii?Q?wIs+0MO7YbwQWuduVoeymeRF2lqbQLDBlG4Nq1rb/PoERx+gOEgLJJ4j3dpc?=
 =?us-ascii?Q?QQmnCJZHdMNR8qRFQfnNeRCjBLk5efQG9kRNb5doEG6EepsjhTZA4a40gUq6?=
 =?us-ascii?Q?lBU0YCcRrpTtGb9tTnfEMkcWpY2nfLAyIZ5E0B3Nkv6tFIP+3IzyZ9UIVv9S?=
 =?us-ascii?Q?niLbUMj9LUkIqD0llRVdE0EigkUZKBUvzj48wKMPcUT0TzVYfej5LdNwDNTR?=
 =?us-ascii?Q?/icY2xGi0P/Ya2qbBwXlAzCLsOBRwFTVxX5GAuwWtQQCdiksrSQCsIXLmTff?=
 =?us-ascii?Q?L3389N81+0N5GyiAzhumXWeNdbdVysSiI8v9VNChkbyJ/mmwWqPTrxREcVpr?=
 =?us-ascii?Q?oNeHb9wPKD7ypDE3jMQfipSTM6HN9XCQ0lC97iNc2AKRGUiR1clOd8Q+iW5d?=
 =?us-ascii?Q?ti53IwSYsYzkVTWyGgfCxTEgt59jgFMn19v8wqLJ/ceUQZlY/I4+Gxb1zc9t?=
 =?us-ascii?Q?oJ4gyKU9uWVMe4Zmsq2phIWXgROe9dRUUS7NmZrmYoWFejJCnzPO6vtmxHqw?=
 =?us-ascii?Q?eLO0p0mVgr+K8kZ/VU5SDOu14k8WNAwKhhiEZJxZliav46mxFGuubAG4E8Bk?=
 =?us-ascii?Q?mSRUGADSLO9FnMaFfYH0hJqrziu93lyHlXzXAiJsNgQxjKgsJgjUru2MpI7u?=
 =?us-ascii?Q?uOKFtL3zuH2emzEL543ZGN/sEz0NDKXuGweDZxdWXdhhMLuiH/Bn1hbgzYrc?=
 =?us-ascii?Q?zUJEtsqGzlnTXA4d2DKN/S86NAdkFWFujNLiw6H6LTa+82mizPClQSpao/wp?=
 =?us-ascii?Q?1QbD1za2swFbwxyqBS9FyIxhWOeCSwcD8x/EAEl/8NvfuYY+f4BLPXG+YNz+?=
 =?us-ascii?Q?F8HuLT+aK7smBfofvZgsl+OG76VQpGKZkiPRJVvGRldY6QJ/xyM+nOact2DH?=
 =?us-ascii?Q?+MGpq98hqKDCBZT+33bibQ+c6i8w4BfIuIRfONn5Yley3S1MFqyu7PcHeRx5?=
 =?us-ascii?Q?128eQrgLDsZMmSvQGeZiu7VmMDU4MIseknuFFhCiJQM7Jb9/PlK8Nw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR15MB6008.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YJI+rvGcfBwurnI7/rJFThZdYcOLzOLpH2OaIrdmaFN9Yxst4lJ0vIiyTns2?=
 =?us-ascii?Q?w9XkNWld7eSQtu0jp5Jdpmcd4CrSC3KUrUL7/9+sPe08v7ZSoI0CNHnPL3es?=
 =?us-ascii?Q?u/fEidtqHp2b7yrzhYgE2Z/q0fR3Q+kepWoBkOlTr+Egb3MxMt8atPRkZb9f?=
 =?us-ascii?Q?ixkG3O7utbIWrSHbe+ccJzMv1Lf02vxqoNEjiTKTUArMQqHFEC6xu4Al2jfh?=
 =?us-ascii?Q?3314Hr5Iw+jmpSllPP9Qt2tznlhZWJ9KkGQGOfR0bbrM9v9oVT3v5Ta4MiOn?=
 =?us-ascii?Q?6f7mIs8mBh8SL9FLDYha4w5spD8oIX9zujxSjWrez4zjSx1k+KYlkI9tEZGp?=
 =?us-ascii?Q?ebrkPpv+Ex8u2CseN5ocK5cUFO7QWI0O3V3uYRpy/QyQnKdPZDoRcIn25bSe?=
 =?us-ascii?Q?5XH37RsYS87+BTKJGDWOD5oM3US9ejqAXa14uqxdDeXigOiypFJM+HRNjpjz?=
 =?us-ascii?Q?E8rptzrcDpfWGR6q0dv6LYWPaEAnFPL97G1FTw5OMze7j6bBUo6i4Krp+m/8?=
 =?us-ascii?Q?X9xupK2q/CiOkMdBBLQgetzbAJ8PaFxWq5dR4gpqJaRwg1sQBaBEFUYefP8G?=
 =?us-ascii?Q?n+GVGCB343Kz3I57wSkuPL0oXrT6mBlJt/IjcqWaWc8AEo+BjUeb+kX6rzYj?=
 =?us-ascii?Q?/J1yohfPGR0ZGFwsv52JszzrwNq97oaRrunWTyG7lqOnKq0vM2v/ED3wLJIY?=
 =?us-ascii?Q?qmDfUVMn2nm71AFmfSgnEtoI8tlwFEiNJ9YfEKB1Lsh4MnPdrRhhuoBimEoT?=
 =?us-ascii?Q?UTMNKYwtk7rbXQyRb/6UrwOoXRiAZnQnVmr07acTqOCvzIqt1BOfivPKW41A?=
 =?us-ascii?Q?iWvwZRa8zyZF8aFf6oGQyUmnXU9HMjghS1s2i2lIyLkkCGdig15pe4Vm8Mdb?=
 =?us-ascii?Q?MkNPReAQUgPod5c9oBWGkfzfQ4ZPfYXXe4KXUeQh+fWm+5Li0/rlZI4qM9Pe?=
 =?us-ascii?Q?6JTUtwX21wAliEiHLs3A4nYzC9OOwaawPhjq+t3yX6mGmBb0sC4f9kMA2Ten?=
 =?us-ascii?Q?AS5sHyNnMonvXd4DXHN7UxneOhAUMlO2rNZ1lbZ6eI9xr7YHKXX6HWXwz4+q?=
 =?us-ascii?Q?G4YR0NwB8DJiXRLa1rwAb9PkYSZjcTG9M8FioNcm2fGEcT/LzkWN8P8M3F1l?=
 =?us-ascii?Q?1fV6eYuw0DReqecFNaOolSPRkv2D8mFzqH5lMRTHkPWoKcqWkbhGGh8pBbP8?=
 =?us-ascii?Q?/SSlrqbNIrHRZBq0IjY8z/V3MQj2gtK9N7gFY6HrJi5NFh0qAY6QYt5RcEt/?=
 =?us-ascii?Q?SlZj/UCktDbQME/GYBYJr5PbrDMvGgvBK214v0u3zq57+HrK/Wya1aMNJGPG?=
 =?us-ascii?Q?LvcTCpMbbsYhrgCcLqVIHoa3ejGJ+1t90evsHKbazeIsj8EbjfJ5QdzMYivK?=
 =?us-ascii?Q?WnNk2cJk6a+FMbCzI1eaGP6I1hLanHMKR3dNEUbb47D4fykMaFNNQgsTqGRv?=
 =?us-ascii?Q?VmFIdgI8kSr8Z8pk3V2j8NmecYjXY0tbFGALd3oKtBytYTNVtmy65nRnBoAC?=
 =?us-ascii?Q?/Jo8HZCuirXTDqxFi3Vxd2PzXi21P3pvMipYUZ+9878sLMld7avlIpXn5Kay?=
 =?us-ascii?Q?/yiacIGmJfSmmouRW9aegCc2eYy3YfPjkt9r/KLJJCUbdDAtumZ+pu8MoDVa?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: palmerwirelessmedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR15MB6008.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b816b4-92c7-48d5-6759-08dd8dad6e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 21:23:38.0792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18187d5c-662c-4549-a9f0-3065d494b8dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Wwan1f30dAuJTYx7Bw3EPsl5re+MxBiL0fKIyQHcvzwlxxynbpjJixoyjl8kKtunk7w9tcT4IcKF7yFz/zjZSUCdoNC4myKRFUypMwSacc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4872

I implemented the changes as I think you suggested.=20

Networking is still not working. There is no noticeable difference in the b=
oot log messages ... although it's very long so hard to know if it's somewh=
at different. But, in the end, still get "No such device".

I was a bit unclear what you meant by "this is wrong". It appears after the=
 line "phy-handle =3D <&swp5>", but I think that instead of that being wron=
g maybe you mean that a fixed-link node is missing. There was (and still is=
) a fixed-link node in port5, but maybe there needs to be one in both the s=
witch node and the port5 node.

Here's the updated DT:

&fec1 {
	// [what is this? Does this tell the driver how to use the pins of pinctrl=
_fec1?]
	pinctrl-names =3D "default";

	// ethernet pins
	pinctrl-0 =3D <&pinctrl_fec1>;
=09
	// internal delay (id) required (in switch/phy not SOC MAC) [huh?]
	phy-mode =3D "rgmii-id";
	// tried for for Compton, but didn't help with ethernet setup
	//phy-mode =3D "rgmii";
=09
	// link to "phy" <=3D> cpu attached port of switch [huh?]
	// [is this needed? port 5 is linked to fec1. is this link also needed?]
	phy-handle =3D <&swp5>;

	// try this here; probably not needed as is covered with reset-gpios for s=
witch;
	// Seems like the wrong approach since get this msg at startup:
	// "Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios"
	//phy-reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
=09
	// enable Wake-on-LAN (WoL); aka/via magic packets
	// Note: commented out since WoL is not needed and probably wouldn't work =
anyway
	// fsl,magic-packet;
=09
	// node enable
	status =3D "okay";
=09
	// MDIO (aka SMI) bus
	mdio1: mdio {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		// Marvell switch -- on Compton's base board
		// node doc: Documentation/devicetree/bindings/net/dsa/marvell.txt
		switch0: switch@0 {
			// Note: even though mv88e6085 is not the right part number, this select=
s the driver
			// for the Compton switch (6320) as well as many other Marvell switches
			compatible =3D "marvell,mv88e6085";

			#address-cells =3D <1>;
			#size-cells =3D <0>;

			// device address (0..31);
			// any value addresses the device on the base board since it's configure=
d for single-chip mode;
			// and that is achieved by not connecting the ADDR[4:0] lines;
			// even though any value should work at the hardware level, the driver s=
eems to want value 0 for single chip mode
			reg =3D <0>;

			// reset line: GPIO2_IO10
			reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;

			// Note: Andrew Lunn, module maintainer, says fixed-link is needed here
			fixed-link {
				speed =3D <1000>;
				full-duplex;
			};

			// cluster setup; not needed since no cluster;
			// from dsa.yaml: "A switch not part of [a] cluster (single device hangi=
ng off a CPU
			// port) must not specify this property"
			// dsa,member =3D <0 0>;

			// note: only list the ports that are physically connected; to be used
			// note: # for "port@#" and "reg=3D<#>" must match the physical port #
			// node doc: Documentation/devicetree/bindings/net/dsa/dsa.yaml
			// node doc: Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
			ports {
				#address-cells =3D <1>;
				#size-cells =3D <0>;

				// primary external port (PHY)
				port@3 {
					reg =3D <3>;
					label =3D "lan3";
				};

				// secondary external port (PHY)
				port@4 {
					reg =3D <4>;
					label =3D "lan4";
				};

				// connection to the SoC
				// note: must be in RGMII mode (which requires pins [what pins?] to be =
high on switch reset)
				swp5: port@5 {
					reg =3D <5>;
				=09
					// driver uses label=3D"cpu" to identify the internal/SoC connection;
					// note: this label isn't visible in userland;
					// note: ifconfig reports a connection "eth0" which is the overall net=
work connection; not this port per se
					// note: I wonder if this is not needed; maybe an obsolete setting; re=
placed by prop 'ethernet'
					label =3D "cpu";
				=09
					// link back to parent ethernet driver [why?]
					ethernet =3D <&fec1>;
				=09
					// media interface mode;
					// Note: Andrew Lunn, module maintainer, says host port and fec should=
 not
					// both specify internal delay (rgmii-id); and further suggests using=
=20
					// rgmii-id in fec and rgmii here
					phy-mode =3D "rgmii";

					// ensure a fixed link to the switch [why?]
					fixed-link {
						speed =3D <1000>;
						full-duplex;
					};
				};
			};
		};
	};
};

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Wednesday, May 7, 2025 2:18 PM
To: Steve Broshar <steve@palmerwirelessmedtech.com>
Cc: Edward J Palmer <ed@palmerwirelessmedtech.com>; netdev@vger.kernel.org
Subject: Re: request for help using mv88e6xxx switch driver

On Wed, May 07, 2025 at 06:29:18PM +0000, Steve Broshar wrote:
> +Ed (hardware expert)
>=20
> Ed, Do we have a direct MAC to MAC connection between the FEC and the Swi=
tch?
>=20
> Following is the DT configuration which has a fixed-length node in the ho=
st port node. TBO some of these settings have been verified, but many are m=
ysterious.
>=20
> &fec1 {
> 	// [what is this? Does this tell the driver how to use the pins of pinct=
rl_fec1?]
> 	pinctrl-names =3D "default";
>=20
> 	// ethernet pins
> 	pinctrl-0 =3D <&pinctrl_fec1>;
> =09
> 	// internal delay (id) required (in switch/phy not SOC MAC) [huh?]
> 	phy-mode =3D "rgmii-id";

You don't want both the FEC and the Switch MAC to insert the delays. So one=
 needs to be rgmii-id, and the other rgmii. I would suggest the FEC does rg=
mii-id, but it does not really matter.

> 	// tried for for Compton, but didn't help with ethernet setup
> 	//phy-mode =3D "rgmii";
> =09
> 	// link to "phy" <=3D> cpu attached port of switch [huh?]
> 	// [is this needed? port 5 is linked to fec1. is this link also needed?]
> 	phy-handle =3D <&swp5>;

This is wrong, and the cause of your problems.

Copy/paste from the example i gave:

        fixed-link {
                speed =3D <1000>;
                full-duplex;
        };

The FEC driver expects there to be a PHY there to tell it what speed to run=
 the MAC at, once autoneg has completed. But since you don't have a PHY, th=
e simplest option is to emulate it. This creates an emulated PHY which repo=
rts the link is running at 1G.

>=20
> 	// try this here; probably not needed as is covered with reset-gpios for=
 switch;
> 	// Seems like the wrong approach since get this msg at startup:
> 	// "Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios"
> 	//phy-reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;

No PHY, so you have nothing to reset.

> =09
> 	// enable Wake-on-LAN (WoL); aka/via magic packets
> 	fsl,magic-packet;

WoL probably does not work. The frames from the switch have an extra header=
 on the beginning, so i doubt the FEC is able decode them to detect a WoL m=
agic packet. If you need WoL, you need to do it in the switch.

> 	// node enable
> 	status =3D "okay";
> =09
> 	// MDIO (aka SMI) bus
> 	mdio1: mdio {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		// Marvell switch -- on Compton's base board
> 		// node doc: Documentation/devicetree/bindings/net/dsa/marvell.txt
> 		switch0: switch@0 {
> 			// used to find ID register, 6320 uses same position as 6085 [huh?]
> 			compatible =3D "marvell,mv88e6085";

Correct, but you know that already, the probe function detected the switch.

>=20
> 			#address-cells =3D <1>;
> 			#size-cells =3D <0>;
>=20
> 			// device address (0..31);
> 			// any value addresses the device on the base board since it's configu=
red for single-chip mode;
> 			// and that is achieved by not connecting the ADDR[4:0] lines;
> 			// even though any value should work at the hardware level, the driver=
 seems to want value 0 for single chip mode
> 			reg =3D <0>;
>=20
> 			// reset line: GPIO2_IO10
> 			reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
>=20
> 			// don't specify member since no cluster [huh?]
> 			// from dsa.yaml: "A switch not part of [a] cluster (single device han=
ging off a CPU port) must not specify this property"
> 			// dsa,member =3D <0 0>;

This is all about the D in DSA. You can connect a number of switches togeth=
er into a cluster, and each needs its own unique ID.

>=20
> 			// note: only list the ports that are physically connected; to be used
> 			// note: # for "port@#" and "reg=3D<#>" must match the physical port #
> 			// node doc: Documentation/devicetree/bindings/net/dsa/dsa.yaml
> 			// node doc: Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> 			ports {
> 				#address-cells =3D <1>;
> 				#size-cells =3D <0>;
>=20
> 				// primary external port (PHY)
> 				port@3 {
> 					reg =3D <3>;
> 					label =3D "lan3";
> 				};
>=20
> 				// secondary external port (PHY)
> 				port@4 {
> 					reg =3D <4>;
> 					label =3D "lan4";
> 				};
>=20
> 				// connection to the SoC
> 				// note: must be in RGMII mode (which requires pins [what pins?] to b=
e high on switch reset)
> 				swp5: port@5 {
> 					reg =3D <5>;
> 				=09
> 					// driver uses label=3D"cpu" to identify the internal/SoC connection=
;
> 					// note: this label isn't visible in userland;
> 					// note: ifconfig reports a connection "eth0" which is the overall n=
etwork connection; not this port per se
> 					label =3D "cpu";
> 				=09
> 					// link back to parent ethernet driver [why?]
> 					ethernet =3D <&fec1>;
> 				=09
> 					// media interface mode;
> 					// internal delay (id) is specified [why?]
> 					// Note: early driver versions didn't set [support?] id
> 					phy-mode =3D "rgmii-id";
> 					// tried for for Compton, but didn't help with ethernet setup
> 					//phy-mode =3D "rgmii";
>=20
> 					// tried this; no "link is up" msg but otherwise the same result
> 					// managed =3D "in-band-status";

Managed is used for SGMII, 1000BaseX and other similar links which have inb=
and signalling. RGMII does not need it.

> 				=09
> 					// ensure a fixed link to the switch [huh?]
> 					fixed-link {
> 						speed =3D <1000>; // 1Gbps
> 						full-duplex;
> 					};
> 				};
> 			};
> 		};
> 	};
> };

The rest looks reasonable.

	Andrew

