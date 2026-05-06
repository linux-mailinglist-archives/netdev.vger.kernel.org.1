Return-Path: <netdev+bounces-284890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGcYAyVV+2n+ZQMAu9opvQ
	(envelope-from <netdev+bounces-284890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:50:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E34DC971
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 684F83061EAF
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AED480DE4;
	Wed,  6 May 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="R+t7bLk7"
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022075.outbound.protection.outlook.com [40.107.149.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B0480DDE
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078180; cv=fail; b=YBiFALYpnGC65mctGjLjXoUmqn+SZEbBz9rCgEgZ8oqSBku4DKiOIdD3haPna0pbn4nT/P5w/tc4kVZ8PW+yr2Z7X8bNH9Zp7j5aQ/V2Tbm6Qut7TzC6p/8fHYNgARzkXwJo9U7L2tsNfOPBisYEkoyfM8QIBhsjY/IQQTypprU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078180; c=relaxed/simple;
	bh=4AWeiahLIuHMPQBC0UMcn6ji8JJ+pV5sfhO3pN3EUak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsabBWdKeydtLbXhQud4syZWlb+R+EY9cz1i+dwnMDsJvFRIAjbI2YHBqgHTAIGnaug69pY4DzoYZ9MGIA8Ss6gZnfALYegvxR0ykwvn6IrtaolB/C5xQJMJ/NsCYS5bx3WUGb8Z44rZTuErQMTQGhGZ/pz5o3VWLn0lw+OZiCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=R+t7bLk7; arc=fail smtp.client-ip=40.107.149.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbLOZgggtBDFbj/J2rk+3rYsd3e2qwkTyi7YgKWnLL9HVSoX2fITTxtZqgAwOO4Kb5YyX2k2O1YsEGvx5hKO+AAJDCtReP6qr965ujcgQBvHiLNIj20pIW0gBTKwxqC24lcBHg8OnwJzoX+GxCk7mEu7lgJg918PKGehWrHzIDE/S0BYUhFT5NJKYVA4i5sBK3ka2qJD+U2hwKX4uuu88C6ankuHnfJqzxtNBSxgWI8DFRdtM8oEin+JUUEtlr9TKYJVpPYmvjuG0Rh4OvH3sL9u9h9JqUuqLT+vsk/FSNJaJW5sZ01F3naS24T2ND4NH4XrDh/1QoPJvlVFB4uaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIQNVhzGr/34ea2KlomiSly4tf3oG+XHAiNlQghwDdk=;
 b=AaLLNvgwmYmxgWjgBBtOfKXGtpVntvuQ6F2edp6vbENjGp+k2L2R8W4O3v8PYnJtPkqJpJCDqCvvMxTLgfUG+7lDLoky7pU15oTkJqxAZNGRsijrB2S67+wBKH5gXFH8kmcIkTHVyEqof6FZfCPw5K8T2dI5zFEqbDixdUFsUzKSuFiEUOKOphn62JmA/LDu7kz5yAUmLvplaD1iMNpFRDLVwb60ltR8DjRHjHXZtSvih88NZ4dOG4CZlV6FjgAC1XHZmM56xEQ2PGjkJHSkvbTeA7eXRICKFBaM8Hcg01SE7KU5uK7naEkzia5tavx5sGdtU14i2yUmlLJcflgIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIQNVhzGr/34ea2KlomiSly4tf3oG+XHAiNlQghwDdk=;
 b=R+t7bLk7zHJ7AUXJalAci2ROIQyXPyDL0y7rK51FRPbSoX/CaM0JrynqsxnLbj/Er8CH3rHt8pvw8IbAPR1O027tg//KhnM0Uw9hJC6n5bFWiLzubqSxXLTYbjeCG+LWM2pJ8RVB6IZ+oiUWM1w0uZ1jUBnjSwKC7cA0iiLwEls=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by BE3P281MB5532.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:36:11 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:36:11 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: AW: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Topic: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Index: AQHc3HSt2FaNRg+Hc0Clgdk/8rilD7X/aQMAgAEuzo+AAGP6gIAAFNIi
Date: Wed, 6 May 2026 14:36:11 +0000
Message-ID:
 <BEZP281MB2245E8C2E2E757761DB5F952D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <62b15f5f-c9db-4443-b0ee-ac7044459c08@lunn.ch>
In-Reply-To: <62b15f5f-c9db-4443-b0ee-ac7044459c08@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|BE3P281MB5532:EE_
x-ms-office365-filtering-correlation-id: 2a649b4d-5520-42ff-889a-08deab7cd1b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 ClERS5nd0mr0YK1HO6Zjg+n7/izbkMzftjjcFV/G5UHgT3Xty8ZiPN/fTIDXp3Lsf+N74pNF8tR5dgcVJ0NZDAqvNcZAqLHjJ7DNnRSmVTuUm8lNdc7LohbrpZ0IG/tKqZYjaJcR+GDoL1scIvYB5aPX7/Of98fPmbUpO9+Hk9qAKBR8eBi5q20JsZxjAboWpB8kl1OAq6W9qWD6Y4Tz2/p2SPfrGyXHeKtl5IOYU9HX9BoR6LKmvvr2Jnfy4ifmWUl/IP/ZWmOojNrhiQ+v1GxQi9wmibAtb5XiJFV83EvcKRa2weXlxw88RjP5gy81FskFUM9W3JN7IOUgl/GHekPzUJRw8E0VM/BbGIUs2vWBWbNwfhBT+9CzlsJYbWIvaTmYIJaQ8r9u1lHifLCqSCrH7UEQ4O78lxIQzcBAKy0nBrMELAfOAtzOKzp8ZImC2mbPqqrXXYAF4NxxI9JD7oE32Gg81lK5+u5PaZvEMchEyK59m9Z2uXtf9IqJ+F3s5NRijioFDtaqsczAb6Ijd0Euv/yl/uQ7owUeH1PO00OA5BBM9Yu9ZWBUGcHIxQGFKcJArgvNbbyePRDLQXOz6/TgpCB1C+GtPZuJiAzLkKIbfcTdy+QMTrQ/xZCOqTXDPZx6AxXMIdXWCmucxSGEAIIVSW9NfN7m1c6Bsgy2uqH0tkWRkBkiHGim41OG2rhfrwcF47a0MSw5M8cNiJhT1JVpJ/Sr7oN+hFmao/9Zv3lOvp28Zc/yxcuZlvtR9myI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DmP9oyGQskz/Kb///oZupxWIsqZB+lXNVs3kQfJuf4Kh75UTsYnu/8c3PJ?=
 =?iso-8859-1?Q?6xg5XTmxWSz3ovnXzD7V0+Fk3TaKA/nyyXnsWZSRs9NDaUkCsgfr2UH1vt?=
 =?iso-8859-1?Q?E5poWZumgltXleLdkmqP4BQd1dH2QkT5dovs1rpcolDermav5lz65wcj3a?=
 =?iso-8859-1?Q?TQsccy8wnvec0PRgDBa7T9SNwwDXBQNxLNFDZBGUDInI1gxK7T+H7bsH4d?=
 =?iso-8859-1?Q?GBw5Jg3nvsPXR9uB9iqCd8iiZn2xBttOjUDCeUtx43Ub0I7AxahLOhHctb?=
 =?iso-8859-1?Q?F1/+AgkArCxhlOetZls4kuIaxcBIbt0hGrPce+O36Ja6M5rs/rV1C73eLF?=
 =?iso-8859-1?Q?5AcLQMstE+PAfSONL0I9xaGvPvTn0fgLeIbtLnAbREQ9cJVAFCNyKQfjHb?=
 =?iso-8859-1?Q?xiTLTrgCjRzMOs3fmXnZ2zcPh9kof188tjXQhLsbGsDLxPx+mP6nflldyQ?=
 =?iso-8859-1?Q?aKPyJvscP2YZEeb3vcUHtlmR+Fwstd8QAu78Ej1HUHRKB8K6kz4kaFHnUg?=
 =?iso-8859-1?Q?hrTOP3Oob5hqFwnLJ9YiCguY+hy9AG3g2rAL3s6wy+FUfhpPrk/b1S5rXY?=
 =?iso-8859-1?Q?TNcghnTEpfSYrIvJgRpU9cLhhB6fVKD0Xhx9GxNwy6tbG95GYHBJagAPrF?=
 =?iso-8859-1?Q?aGGdjghY4nyySjqvqH80bRlzWq9MEqZtfmJ3Qa9zHgYjzLcRfgCmrGWNsh?=
 =?iso-8859-1?Q?z6dnBaDyEuQxA8KRkXZk/8/ZjfIqfKMV3FtdXHHgImHQAhRhLyTG55N69m?=
 =?iso-8859-1?Q?1T0bIjBs8hMu5r9LJCa//ihOUeAYTdjWmU1lRy3X8QKmGmymETtqZ6banw?=
 =?iso-8859-1?Q?FTDhYG9vfkDtP8E+VvtWw6QBZj+4jVQ7SNgMrv15VjPrhoYREteoFJnZiF?=
 =?iso-8859-1?Q?+7jjYUb0yUgtm2NbQ/QpLldkxdP1DCVTJbJtQZfAiYcl+FL5wZyz687r/j?=
 =?iso-8859-1?Q?FQqeSYhVfO5K9p4kB0LH/KXCA4aAPtUGNq12z2ZoUs5uIIlaN4rlymZ2+x?=
 =?iso-8859-1?Q?YS6LzzsDWwhA3erlbULLVn+/nrcFFEgeDJn3NwOQEPFZAvbuLKSI5Kc/Yb?=
 =?iso-8859-1?Q?YgdOrxsCIclQou6kzPE79uMjADbFjS7UJr/1wLaCSbnzE6Ksb4JRoKtBZ0?=
 =?iso-8859-1?Q?FTHHDzrX5RZbFZbggjk5DcNzvU9nVirDhInXG9+ZFE1pSdsYoa57hcIa0x?=
 =?iso-8859-1?Q?21k0tnmksFgfp+l3nkI1WfsmIrV8mlATaoh8GUFYJxOhrcBEMEWPkMRtx8?=
 =?iso-8859-1?Q?IxQXkVMPzWMtU1SJKSIlzf+J+p/r/cFrlDaL4JNSYGa8rWViYcv5Vl1r/u?=
 =?iso-8859-1?Q?7skv0D8lVIDtCFumBGLRjjBC89BhMfAgbG0ZK0NgH5rNmm7wE24IZm84VE?=
 =?iso-8859-1?Q?rDI79MzoJEHGac1ZtpCteUeVmcpuEcSbZdqoFFx+dGSYz2prPYgTZMjgnh?=
 =?iso-8859-1?Q?uIvD3jUF23pyjZ42LVkl5OrcNwJRELtFEekkO23dLBgqPtizFtYqvNQcaL?=
 =?iso-8859-1?Q?jjIsb43SZYx/MYpmc8SB4v0BGCi8L0NAP6l0KbG9aK8JHli5JVwi4QbQbV?=
 =?iso-8859-1?Q?lEWx41/kCRRHaUr1ZqwTH9+nXfgAwcEf9wcElfiBuDh639qYimPDeprkV4?=
 =?iso-8859-1?Q?aLZcHqiHGJmkRM/MZNYMv1wmN3+KA43Ztgbqwxqh3KdsVNn4AUY8Ns/BfZ?=
 =?iso-8859-1?Q?9bZkUB/7Ofs7VqizB3NlfX32h8mKRp/YWXUX1guv2oBXIsRelDOxB/s4IX?=
 =?iso-8859-1?Q?P1s+NVxt4PLhfGanAgAjZbB7JIUshRMx2Z6TuH4itVdIU7w3PEtLs8x4Za?=
 =?iso-8859-1?Q?HEZ8YJ02Iw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a649b4d-5520-42ff-889a-08deab7cd1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 14:36:11.5687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uc3dRqSQ5CQ6quTmSq9atjLDz9AGS0eU7LbFQKF1BXBOBLCM//kXR/fv5gF8jQ+/Vm1YjQrEk0wlItm0rG3pD/6Fl4arsdWkH7Tkz3bemg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB5532
X-Rspamd-Queue-Id: 5D7E34DC971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

Hello Andrew=0A=
=0A=
> Von:=A0Andrew Lunn <andrew@lunn.ch>=0A=
> Gesendet:=A0Mittwoch, 06. Mai 2026 15:15=0A=
> An:=A0Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
> Cc:=A0netdev@vger.kernel.org <netdev@vger.kernel.org>=0A=
> Betreff:=A0Re: assert in phylink.c with lan7801 and dp83tc811 since kerne=
l 6.18=0A=
>=0A=
> [...]=0A=
>=0A=
> Please try this patch.=0A=
>=0A=
>=A0=A0=A0=A0=A0 Andrew=0A=
=0A=
> From ea55645b23092a0de7aa3ab0eaf7bcb73a7fb0e1 Mon Sep 17 00:00:00 2001=0A=
> From: Andrew Lunn <andrew@lunn.ch>=0A=
> Date: Wed, 6 May 2026 08:10:29 -0500=0A=
> Subject: [PATCH] net: usb: lan78xx: Fix cleanup in lan78xx_phy_init=0A=
>=0A=
> If phylink_connect_phy() fails, phylink_disconnect() should not be=0A=
> called. Rather than use lan78xx_phy_uninit() which does too much, add=0A=
> the cleanup at the end of the function and only undo what was=0A=
> successfully done.=0A=
>=0A=
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>=0A=
>=0A=
> ---=0A=
> =A0drivers/net/usb/lan78xx.c | 14 ++++++++------=0A=
> =A01 file changed, 8 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c=0A=
> index bcf293ea1bd3..9cfc122d76ef 100644=0A=
> --- a/drivers/net/usb/lan78xx.c=0A=
> +++ b/drivers/net/usb/lan78xx.c=0A=
> @@ -2842,7 +2842,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev=
)=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 ret =3D lan78xx_mac_prepare_for_phy(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto phylink_uninit;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto destroy_phylink;=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 /* If no PHY is found, set up a fixed link. It i=
s very specific to=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * the LAN7801 and is used in special cases li=
ke EVB-KSZ9897-1 where=0A=
> @@ -2852,7 +2852,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev=
)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (!phydev) {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D lan78xx_set_fixe=
d_link(dev);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto =
phylink_uninit;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto =
destroy_phylink;=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* No PHY found, so set =
up a fixed link and return early.=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * No need to configur=
e PHY IRQ or attach to phylink.=0A=
> @@ -2871,17 +2871,19 @@ static int lan78xx_phy_init(struct lan78xx_net *d=
ev)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 netdev_err(dev->net, "ca=
n't attach PHY to %s, error %pe\n",=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 dev->mdiobus->id, ERR_PTR(ret));=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto phylink_uninit;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto destroy_phylink;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 ret =3D lan78xx_configure_leds_from_dt(dev, phyd=
ev);=0A=
> =0A=
> =A0=A0=A0=A0 if (ret < 0)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto phylink_uninit;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto disconnect_phylink;=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> =A0=0A=
> -phylink_uninit:=0A=
> -=A0=A0=A0=A0=A0=A0 lan78xx_phy_uninit(dev);=0A=
> =0A=
> +disconnect_phylink:=0A=
> +=A0=A0=A0=A0=A0=A0 phylink_disconnect_phy(dev->phylink);=0A=
> +destroy_phylink:=0A=
> +=A0=A0=A0=A0=A0=A0 phylink_destroy(dev->phylink);=0A=
> =0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> =A0}=0A=
> --=0A=
> 2.53.0=0A=
=0A=
This prevents the crash. I think this is the fix for the RTNL Problem. Than=
k you!=0A=
But as you already said it is not giving me working ethernet. Will answer i=
n another email.=0A=
=0A=
Regards,=0A=
=0A=
   Sven=0A=
=0A=
=0A=
=0A=

