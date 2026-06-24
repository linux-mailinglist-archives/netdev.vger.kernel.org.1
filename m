Return-Path: <netdev+bounces-301627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U0x3MQzGO2oVcwgAu9opvQ
	(envelope-from <netdev+bounces-301627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:57:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392716BDE0A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:57:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=pM3L93a8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301627-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301627-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B21D302304E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A4E2F5337;
	Wed, 24 Jun 2026 11:56:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980C2ECE91;
	Wed, 24 Jun 2026 11:56:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302216; cv=fail; b=p24k6EcD3+GaGALk6aSZ4vFtU0khzR0kt/qN3MDziFna3p9RFsBOtoixwejBbDZtyfx9NS82QVhbLrOXULFDzo3VbM1KWU9cL2CyL9wf01DU2r2pEbskkBnKUFdZyte7tsPMH3YgZNWNXx2dsiKTlR8mHQUAa9JYqZTmye0HFDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302216; c=relaxed/simple;
	bh=bT/eOYHkuR6M5ezH4qIzXVnuRTCoOCB256Lvj7vHP1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cS0nrprGpDRJZxloeXG0KZ4YCwGyKbOS2cg4yV1+RMROuYn1sN5dIYjMEx1gfbX03j6Ib9CDhVAmR+vnq94jM/ZLkBQ/1LNs4JTT91GEElQSwLdcENy00ofJqhfsBs5NLUf3j1m1PMMXzUcy23euFuslhHrdoulx5thLFL5H7og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=pM3L93a8; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GabEu7NpneUHj0CYrixON149G9vtAMBOgvzfTX6yWUTnLZAGhBY86SDntCU8PO+NHv/sS60CEzoXbv5PdqmluWQaAp3YFwhHOt+LYZtOOOBpNHqbpA0GI+3Ix8MGy0ysAGqcKlrhVGPeC3ZQqH3Kjnjk/xBxkzB6pG2j3h0GawH5T0AeedOXoWP/AEdpSY+5DAepMj+7ooZYLIvYEu+z/kLvnj4ccghk2ewZ3If94IoSTSIvWbPQApaHFf4cN5kDnVsJ2L/v/REyKy/tNm/AtcF7ccORNTD1hrIflMrAFJmkt8mA/ZXa/csEE2FMfuTB6ubomXoYZmaIBCSAeDNC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE16RVerzZg7+4a57TPatDLV3vKlbEy2pN0MfQli+8s=;
 b=y5y/OwEoVAPNpP6x8Yb8HOQwbD0x5UnGMqr5kVtxNag412W0A70iWqMC7yv+EBM4BqsPuAFT+A87mwR4O8++UXYOu3DIN9dgzjdPHSoUTiL6h3d82RnFE98GNSBG88jx/hj61fI0CEOcDT2trM7HKkYvQ7mZhLhWPkV4tAGXKwDKxgu1RR30NyTrttng8xu1P60qq1oxItFhCiEcqePadF1aXtNcGyMXzYMnEF1FD1C3A3fKTbzaVUb8H4Wu5hxxqoPCbGO8ebNsaGXfLaKR/Lytn27moKR7YlrKqY7K4/QAvBXY7cscsI4+MADyvojW6juOXnEphPtUDzlOqqJMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE16RVerzZg7+4a57TPatDLV3vKlbEy2pN0MfQli+8s=;
 b=pM3L93a8upUdnXFiRr7DbOaYCxM6hV6QvIZlaMTu6lCcgktWRENFEUQ37c/w0PuVWGlygE7KJbU0evBAj/bQ6RItfi27Eq/+FbV99lMkievCmZQSQrGVIGGl1zHVFmZb62sshBBnMun/xqxq7oBr/HHBdPzAOvauFNwZlS4K8bQYtSoPHHi1op0uNQaiFJA9BRMLEXa8ugz7vciljwGwoLN05ONY60h/TBtft5DGL0oq9qKLwHS7ZwydDdpwtNRV+iKctfbjexwEyWFASWRIgCvMKc3a5oXVW1fXagKx3PPt0ghx2SK5s2G7FHZBual3FuVPg+fS/xA75LF0oRCHeA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PR3P189MB0953.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:47::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.13; Wed, 24 Jun 2026 11:56:50 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 11:56:50 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Samuel Page <sam@bynar.io>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: fix out-of-bounds read in broadcast Gap ACK
 blocks
Thread-Topic: [PATCH net] tipc: fix out-of-bounds read in broadcast Gap ACK
 blocks
Thread-Index: AQHdAxfpWUKsaZFkyk+mevSBy422FrZNl45A
Date: Wed, 24 Jun 2026 11:56:50 +0000
Message-ID:
 <GV1P189MB1988C9B05348C49E61EFB5A2C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260623135443.3662041-1-sam@bynar.io>
In-Reply-To: <20260623135443.3662041-1-sam@bynar.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PR3P189MB0953:EE_
x-ms-office365-filtering-correlation-id: 9a715ad7-827d-417c-35d8-08ded1e7ad0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 TeN8KitaYw6zCeMQco/jmNvwmuQAqws0CNxNxXQLjN/5Axkx+NzmsUamDhETONK+Rlx2MtfXoSA5rsLnj+QT3xHYgK4VG7a+79QdIMJUBo6hC96K7ZMPTqgxq26feJDXfC93pC4udR5uKBdf4q6e05v9XGGTAF1ZEMeeCHTyac9+Q2xJoCsBsiMd+/grWGdqtglGHGIa98NN2k29940eurdwNDau/S1VK+r7F+kQ/YzTG/jUjmX5bF1G4o+7C2u8UnrM/BBUa+7Cbj4FAQ9mvQfDQ++qUFRMKatTXGKzq+9J+hDJbSb8MjLznScPrLm3p/1g+Ap7ioadPCVyLq3l8nmgWJz4z+/X2q4oN6fM0maldTmfkvYm+FfTgY0PNot4Mw7+DpXbFbSj/bjaqNPsoy9yjGjCLE/qQ0Y4fuv4vC4Ln88Rlxe+vqoNHVL1sT1UuvIU4HIHa3lJ3XIlGoeWdkhz0eOu6TjT8YeneJssiIjiMKELIHWAp3S7F0KuWSjAD4kZ7o4wHDTjjhvRFylgFpjSLGWoXn9+IKK/6Ksh4TQZAIYlDPOxeNo/kKaNFEqWLwD05VH5FlhYyhAjxaz0zMNOYvrEnoYs5Y3S/1SDC08oqM8mYpTMCp6ZMwt4xgVL0uI83ZPSJrOScBPbZ7Jud7vLy5wpC8hoTwrnBS+y1q5LuYw5oc7gBgnNkGQmQS+2rmSfAUq8iQwGo1N6t5WZzNETUoJz9NJ59+kDDGSgiaU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BCT/8jY388XEjXe+OR086ZiU6pxxhnZkS90oeW+IIFS+nS0zBJipLI/8J/EQ?=
 =?us-ascii?Q?c1+zbcUvTYMgV7JedP4xHZJ04sZoxlk+samB2ndaHR+ehIktflaOMPdPtiww?=
 =?us-ascii?Q?htulFpiRnnLhiPM/ulZYPbgAh8rG1wk9Y0UicbWNfBYihVCvoW/uqAvM1R/j?=
 =?us-ascii?Q?PUFmO/7ueSsoF60hYpdBDJ+bZllXWOmjmP+n941tjuek7ROouQmXjC1aPGck?=
 =?us-ascii?Q?rdLqTW5xRdL+XLtCvffYjZWP5nokIrtIG7utqpcNxZFSmqCsD6xA4lOQXbiG?=
 =?us-ascii?Q?YnMOqcn9pIjQfjW7hHeleqsJFn+SOewjWR8SZbz89VNZGojM2UzfXNyCYVjE?=
 =?us-ascii?Q?K3QQ3Ov6/RPaoQKc5yCWj/bFM3L4x7/NNg8AzeR+o2vZAUx/J2gIKZfp3ARE?=
 =?us-ascii?Q?XfOurp5U1qtYAXRpybH4o8gAN1jVQsnDuTF8fNHUk9IwRUmkorEKKcEFDMPz?=
 =?us-ascii?Q?EkmBmtubC8BsUJHkbp/rz70Byr1jV1Mn379nm/KlugC8uHStXlbBFlM93DOB?=
 =?us-ascii?Q?fxrGxRSq+HRHpbI7Cte8zaiB7zFN/9xdX+OcRckGOck2m17cxmI2TXTForP8?=
 =?us-ascii?Q?40F2td3G9w+OtUlJxVYs0c3ak/D2kn0oHDSXQhYHOM9g570s7mSgrOTiHckd?=
 =?us-ascii?Q?OiDCvl7hk+qphcqZJq6Ymda60QWjDLx3j3boKBV3vqR/OjY/PcviJl5Zksh1?=
 =?us-ascii?Q?YR5u9HJb5W1K2hqwowjlbD/pIM0w+2KS2qDmSz0iykmb6jkmw/U34PzkqyS/?=
 =?us-ascii?Q?M/AzR4BCtD1hp8quCGaNqnrBFKiiZgljkLCGUXd+skLmOWkInwmwo9qlympZ?=
 =?us-ascii?Q?iZqFZh2cvCgXJHGBive1pc3CDDoPRo2wHfbH8zFfemzas5vxIa83zA19h2zd?=
 =?us-ascii?Q?HHr7aljUT0SoiU7Rz6xY0BKWKBYekoFgqmWzqK+rVTM/VgbYogzerzwyMZ8Z?=
 =?us-ascii?Q?dcrLq3b+1HuKlRNAB8dh0RUdk77GiXsP83Hv7RIhSiyJQIym61pXv1A21JlT?=
 =?us-ascii?Q?vR7rkmEKD+BGd+wQOMbHqM/4oJ5M+DeGDlCHpHfNEpo9CjzIy7925A5SFyHe?=
 =?us-ascii?Q?0uhh+UH8kO8uGAzg5kY3zHCzB4eu6zYPNR19bu605DBc3CYHQoOwzMb6DKeB?=
 =?us-ascii?Q?rvWHIZEFJlQumCRwdcXfCFwUxVYiWnlVdE8pcHuNc91LRp29hvJhWcyOmTX7?=
 =?us-ascii?Q?HMqvJ5J+RVoEYXC5bz+SGC6fSFAlL7Cir+G1Wxj4XZHDxMlGIXiuNwPq/roq?=
 =?us-ascii?Q?/ahPn/hvqSCUKs0uHKX2ihksRH7IOCT5dCxbk3bK1Q/l7yINVLFyRf7HMOSP?=
 =?us-ascii?Q?jrj2+5QNI1ZrdFUPtNpAUSk/+tqiWAETkY96sy70W3j3BMm0FMaglUkqfSQY?=
 =?us-ascii?Q?W89SDbzotPmDJIIChKtYh/72xFk9r1j8y3SkSSEuWPiLC/D62lw7Qybq3ghS?=
 =?us-ascii?Q?TRAEs3jSjbR6/c41g1lRy1rOJT6aZ1D1M1xqTrZBrsuJ1L14z7Hd18Po4kPZ?=
 =?us-ascii?Q?As2wHByRwtYJ9YH0OYp6Ue51WtM9cz3rrKELCBDJGs42ZuPV92HoF/kk13sG?=
 =?us-ascii?Q?M9uoSTRb5jVJSmNFlDd6LeXeBDOUFvBpEo8aquHlflQq9spTzI+BmMmTwTi0?=
 =?us-ascii?Q?dO27+EQzEz3lCFcf027J8r0RgLgRDaVh8C9/EMqdeg6Cdrt/cQDgsAshUcY3?=
 =?us-ascii?Q?8dEEaNi/nHmVwYZk3ITIgtjAL7bSn6zfHcGRv3w6g2sbdl0fhdqHwn8cFpQ2?=
 =?us-ascii?Q?ulK66+8fpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a715ad7-827d-417c-35d8-08ded1e7ad0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 11:56:50.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HwVfIXE1nLCDwRrV0HabfS16krQn/1OJx62GgiTh4Z16JR7HX0bjmpefhoyJD33+3u6tntnmxxHsQtdSdToJqcARYS6YAjBRlt0xst/++c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0953
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-301627-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam@bynar.io,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,bynar.io:email,est.tech:dkim,est.tech:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 392716BDE0A

>Subject: [PATCH net] tipc: fix out-of-bounds read in broadcast Gap ACK blo=
cks
>
>A broadcast PROTOCOL/STATE_MSG can carry a Gap ACK blocks record in its
>data area. tipc_get_gap_ack_blks() only verifies that the record's len fie=
ld is
>self-consistent with its ugack_cnt/bgack_cnt counts (sz =3D=3D struct_size=
(p, gacks,
>ugack_cnt + bgack_cnt)); it does not check that the record actually fits i=
n the
>message data area, msg_data_sz().
>
>The unicast caller tipc_link_proto_rcv() bounds it ("if (glen > dlen) brea=
k;"), but
>the broadcast caller tipc_bcast_sync_rcv() discards the returned size, so
>tipc_link_advance_transmq() copies the record off the receive skb with an
>attacker-controlled count:
>
>	this_ga =3D kmemdup(ga, struct_size(ga, gacks, ga->bgack_cnt),
>			  GFP_ATOMIC);
>
>A TIPC neighbour that negotiated TIPC_GAP_ACK_BLOCK triggers it with one
>ordinary broadcast STATE_MSG (msg_bc_ack_invalid() clear), sized so its da=
ta
>area is short, carrying a Gap ACK record with len =3D 0x400, bgack_cnt =3D=
 0xff and
>ugack_cnt =3D 0. len then equals struct_size(p, gacks, 255), so the consis=
tency
>check passes and ga is non-NULL; kmemdup() reads struct_size(ga, gacks, 25=
5)
>=3D 1024 bytes out of the much smaller skb:
>
>  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x48/0x60
>  Read of size 1024 at addr ffff0000c7030d38 by task poc864/69
>  Call trace:
>   kmemdup_noprof+0x48/0x60
>   tipc_link_advance_transmq+0x86c/0xb80
>   tipc_link_bc_ack_rcv+0x19c/0x1e0
>   tipc_bcast_sync_rcv+0x1c4/0x2c4
>   tipc_rcv+0x85c/0x1340
>   tipc_l2_rcv_msg+0xac/0x104
>  The buggy address belongs to the object at ffff0000c7030d00
>   which belongs to the cache skbuff_small_head of size 704
>  The buggy address is located 56 bytes inside of
>   allocated 704-byte region [ffff0000c7030d00, ffff0000c7030fc0)
>
>The copied-out bytes are subsequently consumed as gap/ack values, but the
>read is already out of bounds at the kmemdup() regardless of how they are
>used.
>
>Apply the same bound the unicast path uses to the broadcast caller: drop t=
he
>Gap ACK blocks when the reported size exceeds the message data size.
>A NULL ga is already the defined "no Gap ACK blocks" case, so well-formed
>state messages are unaffected.
>
>Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
>Cc: stable@vger.kernel.org
>Assisted-by: Bynario AI
>Signed-off-by: Samuel Page <sam@bynar.io>
>---
>Before posting I found an earlier thread for what looks like the same (or =
a very
>closely related) issue:
>
>
>https://lore.kernel.org/netdev/1316452e465e9a96fce44ec15130a14f3872149f.
>1775809727.git.caoruide123@gmail.com/
>  [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
>
>That one added the validation inside tipc_get_gap_ack_blks() and the threa=
d
>stalled on whether the extra checks were redundant. This patch instead add=
s,
>on the broadcast caller, only the same bound the unicast path already appl=
ies,
>and includes the KASAN reproducer that was asked for there.
>
> net/tipc/bcast.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c index
>76a1585d3f6b..61c83bd95755 100644
>--- a/net/tipc/bcast.c
>+++ b/net/tipc/bcast.c
>@@ -502,6 +502,7 @@ int tipc_bcast_sync_rcv(struct net *net, struct tipc_l=
ink
>*l,
> 	struct sk_buff_head *inputq =3D &tipc_bc_base(net)->inputq;
> 	struct tipc_gap_ack_blks *ga;
> 	struct sk_buff_head xmitq;
>+	u16 glen;
> 	int rc =3D 0;
>
> 	__skb_queue_head_init(&xmitq);
>@@ -510,7 +511,10 @@ int tipc_bcast_sync_rcv(struct net *net, struct tipc_=
link
>*l,
> 	if (msg_type(hdr) !=3D STATE_MSG) {
> 		tipc_link_bc_init_rcv(l, hdr);
> 	} else if (!msg_bc_ack_invalid(hdr)) {
>-		tipc_get_gap_ack_blks(&ga, l, hdr, false);
>+		/* Validate Gap ACK blocks, drop if invalid */
>+		glen =3D tipc_get_gap_ack_blks(&ga, l, hdr, false);
>+		if (glen > msg_data_sz(hdr))
>+			ga =3D NULL;

This is wrong because the skb is not dropped as it should be.
Note that 'ga' is NULL just for legacy TIPC that does not support Selective=
 ACK.
To correctly fix this issue, you need to set a flag (for example, a Boolean=
 output parameter) to TRUE instead of 'ga=3DNULL'.
Then, immediately return and repeatedly pass the flag to tipc_rcv() in orde=
r to drop the skb.

> 		if (!sysctl_tipc_bc_retruni)
> 			retrq =3D &xmitq;
> 		rc =3D tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
>
>base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
>--
>2.54.0


