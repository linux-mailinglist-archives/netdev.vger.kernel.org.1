Return-Path: <netdev+bounces-265897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIj/FOi2r2lzbwIAu9opvQ
	(envelope-from <netdev+bounces-265897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:15:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A43245BE7
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A44F53040AA9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 06:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975A9314A84;
	Tue, 10 Mar 2026 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Vn8DZja3"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023104.outbound.protection.outlook.com [52.101.127.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8992BE621;
	Tue, 10 Mar 2026 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123300; cv=fail; b=Q2mIWe9RMSiRX48qUm8vJ7IIP9WKQpYyMkHeqognf4/1r4s6yQsRJ51kI58xcNu+sCDef2A5yb5BnttvjIGvR2xNCGd6BhEpOoMsQSYaHyKpTtbMUKeOzqtlKFdCZ6/cX8/p8AvLQA7resK17l6a93hVL1cTgMQ5FgwBGH31zq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123300; c=relaxed/simple;
	bh=75Y7HSdBKnhDxJg2vGWjrjhb/aZWKIbjSP1VfNAlDog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L67tWexKE9Bu/hVw9DDMPZS/qJb95k9hb2LobVcg1j84Co397FZd1MN6daijTkXMJWqzJe67JT1W40zwC2vrAnZghnK3+YJdoCNWTTDK7X+WbmIY67t2iHCZW6x5L4pUedY0ATfmW6amOBuG/WXdsu5BdrPgqQfE7pgQt+IzX04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Vn8DZja3; arc=fail smtp.client-ip=52.101.127.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJGBhfh2DUymeriJs43L/IKdEopLg7NfaYokZfGDTpo+7wFgbd/UvZRxDWwKp7IZ8neiYzxIhzq2I+AiCbKkuFP7KbV43m6MpmVgswGdsWad302zscya3DjzmYdWB80YCWTWuhw+im1CXH2N6KcpuRBdljOANQnI7eWrNsJVfYJaxAB+4FqnPlbvkhq11bHmcr33yVeatoJSGb+Q80Me0gpjvmvhdKRsAM1lJDAlz+VeMyUL2yCjRGBwgkA/jNHJqjH8hls+iSbIhLFiKsQIMYGDa0cvjtxzHP9jARcJqs4l/3tACcmbGXUJ7bcPdWYzz7879EZWSGN2JC0rFh0cbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75Y7HSdBKnhDxJg2vGWjrjhb/aZWKIbjSP1VfNAlDog=;
 b=BAcK7qMzsB+0a1/AqSXIXwIkiKOtVj2ILOlFXvSJiN+qULP+noMhC7Eo+Fv2SigD//nYo+urffGj7rwngG901kEVaz1gGn77HLdVMRcjfGpGyFp5Zys4Wmbrp+mC4g0dFfs9pkm3uCvShAp2mFIzdEbU5lfozSdfXIqR3fH1XxplHQqs85mDQvlTCfMtsUavHGmVrIWtXpWVpr/jZrOTvcNXkFWeTopDokfZ1s9Nc5SyFClKA+yqA6vEBv70Jf444/T8W656XNSOCrvEcAGO2pE+jDRxF5LHSY+gOsdBwWtfEpwUQJq6BEOXSFmopqFOBSJwRNaxyhHyg/z7hZer3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75Y7HSdBKnhDxJg2vGWjrjhb/aZWKIbjSP1VfNAlDog=;
 b=Vn8DZja39hoH/SPWE5mdf4rJEiZ78Z707V0D4Sr/nv1kIFTcYd4co/+kQW+aFa5OmRFtHfyx6O/jwtlgJXvAeZQ69XpSyjInYCVOYushZ21VJF2v8cm5y2n7Ri27wl+jp5hv7HqegDSPHXCf4iEPICW0OZZkxm0OsU+hCAUxOhoiGQ//IDzGqEDkACf+unp5jqqybHNZpHfapc4SQF99WrmP4t/p20uuMKb+h6VNh+cUQU4eYBOQc3jSoKX3rrz14ZLRJfxmJm4k1DOg2W7bxq8tNYY2t1R1IcUq/+Ghge2+2x6hY11fyIStbNXZ7VVA10mkOmuQWHThY0YkPlgTCA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB5712.apcprd06.prod.outlook.com (2603:1096:400:280::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 06:14:52 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:14:52 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Thread-Topic: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Thread-Index:
 AQHcqi7Gxnd/yfDNn0+qSBvgjkBecbWbib0AgAPdJDCAAIk4AIABCqiggACUNYCABcZ5QA==
Date: Tue, 10 Mar 2026 06:14:51 +0000
Message-ID:
 <SEYPR06MB51348C264DE5FE428F6EF4329D46A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-5-68319a4c4110@aspeedtech.com>
 <d38f54b2-4a99-4a54-8403-e4f4a9704386@lunn.ch>
 <SEYPR06MB5134AE0B0042E05E8E58A5239D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <70ed84fd-ac9d-4157-ad20-36deec0c5f82@lunn.ch>
 <SEYPR06MB51341775B041AF86CC8769F69D7AA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <344e1aed-f2a5-4249-90c1-2b848ee39d7c@lunn.ch>
In-Reply-To: <344e1aed-f2a5-4249-90c1-2b848ee39d7c@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB5712:EE_
x-ms-office365-filtering-correlation-id: 6b2faf28-0e2a-43f0-bdca-08de7e6c5751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 cQrVmPKIsodJDg3U9MRX4LWXDA1Y1hgPf3Modknq8dwMeezscR3mcdVVs5UXXb+6c88Gc2GA9o3ymtb4J2FjDEGwq/Hb2TcCN+4B5+soZD505TgbDHhpAFO75x1eHj6+keHf4DVT9gjEddR4Qi1z/F1gCaixE8aihm0vJrBOwKSuDf2udMxPH8NtxUhnsDgBHZ4JGVDIle4n8f/LwEMWcMQeixuakyTSOA3uQlb1zImMtRt5tw68QnvssRsrxobm27wq7dkfIyLK/PQKhaIS2i9utWvuU9KVQWsNEDAB+c5AAogcDl/SEfoNcUCofkYidH02zPCYvtRTcE5+/5edwRGKLkHEtcXSgjPWCVlAktgH6VxYNk2qiz0UiaE7apGsYP8g1bX3RcMOWaHVMNUuiyDUTKdH9r/1hYTwLmjeEAa3kz4Jy3mVEjpwiltMPvHgbkpyFLCKDkV5vc9du/3NBTz323cvwR8UsUpVKYWia02S8xfKAf/g3+PXWwumQlV3x+y/Kcx/cY2YdZyl29x7rmL4apRcI5XP0fHtzEg8hqI/WyWGBxASHqTCg/cCY37mvD7yxX1+1GiCj6nRdxd11O4tEYkOTshsCekdP6NMV/4g0uyT8CWGKOO4crH4zHmCmGEx8A6MhKAWLECPpZCsXragff8czEWTm5b6smj3XQ192ZWRYh1yni5FZtJiGxDUZVT3Zo2E03afnT2VPesC3Fj4/VHyy6EuBIeocnBWmksHSwoBMoQM/8SA6J/4u6R5BTm1wWxnVWhe8oajlyLtC7LZtT34R9ZoX15dZjDM3Mc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5/jpOJ04g9jC+qzwm1jVax8NPl7CY50iJLL5gJTHGEUP/8mx8xwkpsdwCRli?=
 =?us-ascii?Q?5i3cf7vIS1/uGAa6uHxyfnGV2krNCA+OAtTCL7Yg6HkHAGKX9tixjTkvrxmn?=
 =?us-ascii?Q?QSKWWROSrLpl0i3vuVFUByQ5HAXguc3c8X0+YMdobsOMffp++lhl3aewHYfs?=
 =?us-ascii?Q?fPjaPb6rVUVgeABLFnC4SjPpiUg2hxWDqss/CwSG7HKgKwH/f+LlDXKF6BWx?=
 =?us-ascii?Q?bIdk/UIeW2bX9fCeYFcrPbPEzXaCe5TbFMJ1ZbuMGBGtfY4eAYmMcAegW2EO?=
 =?us-ascii?Q?3m84tF8C/jRMjO+157Yzr1lkOI1pGVtoIV8LcPL8fY7UTqizE0loTsc2NE7k?=
 =?us-ascii?Q?IktwDJ87xu3rfI8v+h8d6dfJa281ztquMFjWeKnB/yfUn9zbVyhlfVyL78qZ?=
 =?us-ascii?Q?AD/IxJcEL4EI7cb6GxHCW4ui4wjq5YyrQMuhIcyAZBrIXj9g2VGv3haQHryD?=
 =?us-ascii?Q?YTO8UfHD9tu8u1s3dEqtpGBc99A2pkcY2Hvl8IzLpSWOiF0YniSa6PfY/jia?=
 =?us-ascii?Q?JDuHyUXAFa8J7noNdAnkifsLSKaJBpKhpU/GTpx04pli9A8e9KmOMADhbcBM?=
 =?us-ascii?Q?zk84ALDmnf5Q4Pa9TcQ+GrOSHmMUMx1svHXBaAxvhyO43uYe/slgTd7x0Ne0?=
 =?us-ascii?Q?WK2eIdhxAxFwdQ6bej9FA65hKV28FxnZ2Qs/yA07GEVhdLKEtWaPYpr2eqQh?=
 =?us-ascii?Q?zJ+Gt+V3AKwzifYewSeq0julDmyDlvyNDb/DBc8Hns9V2eNoqaheUPNEoaBx?=
 =?us-ascii?Q?0DYIQGANGjfuann+z7OtqizuPgefCyOpZZptr8TRBlNGMsfKPbHEF+Vgmv9v?=
 =?us-ascii?Q?87dolOmRMaz2ndvLKEBTaI0DVj1FR7CxN/MvN7E+u0ymVVH8qFRWyQ/XOQ16?=
 =?us-ascii?Q?OpJhLZQEV/J3WUul/X0gIFPLYDICarCp6SGp72VHlYPMKwH0i/ai+jvJdpVN?=
 =?us-ascii?Q?V9eEdGCDz4OgoLOoFvOS/nkTb+rnsb34SUiLZ20s//VclZZ3lUFSMCcg1IHd?=
 =?us-ascii?Q?e/rAXxYfZMqgnjxk/43Y1tL8t9KqYIDid70oTSuOxJs6VG4uiW82BxbuaeTx?=
 =?us-ascii?Q?Z5WhKLm396KWCyrGyxBlH7+oV/dqYyZ0SC1tmpbK50xCMLq92fGD6yEZJBJI?=
 =?us-ascii?Q?46RgSWj91ahf9yW8UHfwkwF5DuNzFIz1Ev435U1VAvdFYjRmS1HQX4g7fQ+t?=
 =?us-ascii?Q?den1AnEkWmsCwZfzVYHJxjiPa38u9/ebogd8bGjjm/WaaNtgEyePEdb9cmly?=
 =?us-ascii?Q?0Qe0SMMmhd2Nsf+BDl9Qu3h9jsCf0AaFjqq1OU3j2DdfpQ4CEJhL+o3PsccX?=
 =?us-ascii?Q?tS/Pa01dKHaTI7/osUemcT+oJuVPInvkOezd6MhDOFULxhLwVjX4sn/5KFK2?=
 =?us-ascii?Q?3PRDg3tCYrb5omyn94PMPSSVDt94G6H8OYrx/FxqaEAwHjA4yMcjfzgk8Suf?=
 =?us-ascii?Q?0+f93L0KVA5jItuUqH+Fry+5GhedJ5gnsgyqz18FaHCgAWtaW0TGX6m0uLpt?=
 =?us-ascii?Q?x1zlLDQnJS9yr8t0i9cJgr8oIztYUXCN+MkA0speTSVjpyV3LHL65kvGl+Th?=
 =?us-ascii?Q?cOFfliDE1VnRs8O+K+GxmOxMmEfzoHOfbWcyBFeLN6pvljSodpNWm511AWfP?=
 =?us-ascii?Q?kBEX4Fp0TH23tAYMAw301yHJss7Cu3yfI/09E9/627K2xnoATnqPptSsI/dN?=
 =?us-ascii?Q?sOQVMY7Tn8+njn5UwXTSEFme7AGFCPz1WGWMdjVyVQ78i0RzCyrmotL32pYp?=
 =?us-ascii?Q?q7HBAC0Gtw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2faf28-0e2a-43f0-bdca-08de7e6c5751
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:14:51.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lihV60QjzccLfx0nPYPbvd/S1OHU14s6G3kXxc4l9eYuodg66fKZ04n0Kenn67rAZSfUcZ7++/ys4xGmLPhL21Fa370pOVays/fQ9wuf2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5712
X-Rspamd-Queue-Id: E9A43245BE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[aspeedtech.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265897-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SEYPR06MB5134.apcprd06.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > Could you please help confirm how we should proceed with this project?
>=20
> That is up to you.
>=20
> If you do lots of small patches with good comments, you probably can do i=
t in
> Linux. But you need to convince reviewers you are not breaking backwards
> compatibility.
>=20
> I think the bootloader change is simpler. But i've not worked on bootload=
ers for
> a long time.
>=20
> > 3. Send a patch to correct the phy-mode settings in
> > aspeed-ast2600-evb.dts so that they match the bootloader after the fix.
> >
> > mac0: "rgmii-rxid" -> "rgmii-id"
> > mac1: "rgmii-rxid" -> "rgmii-id"
> > mac2: "rgmii" -> "rgmii-id"
> > mac3: "rgmii" -> "rgmii-id"
>=20
> You will do this anyway. However, just so that backwards comparability ge=
ts
> tested all the time, i would suggest you only change mac0 and mac3. Leave
> mac1 and mac2 with old settings, and add comments that old values are bei=
ng
> used for testing, and they should not be cut/paste into new .dts files. A=
nd add a
> comment that mac0 and mac3 require the new bootloader, if you decide to
> solve it that way.
>=20

Thank you for your patience and for the detailed guidance.

I will discuss the possible approaches internally with the team and decide =
on the=20
direction for the fix.=20
Thanks again for your feedback.

Thanks,
Jacky


