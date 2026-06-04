Return-Path: <netdev+bounces-295071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 67W1Id4pIWq8/wAAu9opvQ
	(envelope-from <netdev+bounces-295071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:31:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC4C63DA48
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:31:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=DqPXP8dn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295071-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295071-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFBE43015885
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836A38911F;
	Thu,  4 Jun 2026 07:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202C37207A;
	Thu,  4 Jun 2026 07:30:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558221; cv=none; b=FwnrnIOMNRlZYBfoMXl2GX3XGvGsP2CpqIhto/oISUkTrCxCYcjJXfsIRdDJUMyNzg5TPCXpqxcMZb9k0Z0RC43dtiHgM7zEtpFukEUNy1YLV3cSJoIKe6LFoUbzbZTkaWWYtRbP++g/fQBRr+1570kDtTfrjmL/qHN8purwYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558221; c=relaxed/simple;
	bh=IErrktiFhjw3sp9hNl9CsHajXDqjX4f5TTVozR9oHMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDViobav9WMI+1AoRr48g4/+yHmPEcGjAW6QTUjZce5DLD4Hq701mmT4F9Ay5pxVFo/c5gYLKVO4GR8C2mWcXAyyGHbmeOHBmksg8q8b24ZWUQ4oFcZeMpqA5xgOCDFiX49DaoEDkA1IcCfWYC6LEyQ0PxgaV/uV2fXPgEwbKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=DqPXP8dn; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6547SlCX2199218, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780558128;
	bh=IErrktiFhjw3sp9hNl9CsHajXDqjX4f5TTVozR9oHMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DqPXP8dnuqMHdxoT0GMwedMgMnQS4latexu55JOVniqXUR+JE/itMEo/RnEend1JA
	 XN5OLNDzo7wYt2EI0D5boplS+7D+zGLUJcwIODI+YjjKbmIYqzWti/8Uh4uhnrFC+J
	 J+LlrjxWoupODdO3iAEF6Qfa7V91YopmDTh0xEfLOAKDy06BlW3qsIhFGwoow1Mem9
	 6fjKIwguoiTqahO1GqPbW4TShGaMjf4u//CzPLgWEpudiBhbsYhbkoxXwIFl9WdmTv
	 k7k0EJ7RuEPo8RKV+29qqwM8rxzpln/CCLwtA1wRcs3TSTi2nlIO6abunQW4GlAvOS
	 5BW8c/1lxG0ww==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6547SlCX2199218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 15:28:47 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 15:28:46 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Thu,
 4 Jun 2026 15:28:46 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "nb@tipi-net.de" <nb@tipi-net.de>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, =?gb2312?B?ucvP/r78?=
	<freddy_gu@realsil.com.cn>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Thread-Topic: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Thread-Index: AQHc8wTLHkcMRnhuOE2mwjUvdnEul7YuASyw
Date: Thu, 4 Jun 2026 07:28:46 +0000
Message-ID: <5ab1cf38672c4b71b3d95d506fa29610@realsil.com.cn>
References: <10b6718e8fe84e1895f82ea05c446925@realsil.com.cn>
 <26c9ecf2-d284-4b4b-b41d-d0a84a31427a@lunn.ch>
In-Reply-To: <26c9ecf2-d284-4b4b-b41d-d0a84a31427a@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295071-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:nb@tipi-net.de,m:daniel@makrotopia.org,m:davem@davemloft.net,m:edumazet@google.com,m:freddy_gu@realsil.com.cn,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[tipi-net.de,makrotopia.org,davemloft.net,google.com,realsil.com.cn,gmail.com,kernel.org,vger.kernel.org,armlinux.org.uk,redhat.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:from_mime,realsil.com.cn:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFC4C63DA48

Pg0KPk9uIFdlZCwgSnVuIDAzLCAyMDI2IGF0IDAyOjMyOjM3QU0gKzAwMDAsIEphdmVuIHdyb3Rl
Og0KPj4gSGksIE5pY29sYWkNCj4+DQo+PiA+PiArLyogQ29uY2F0ZW5hdGVkIDQtYml0IHNwZWVk
IGNvZGUgdmFsdWVzIChTUERfSCA8PCAyIHwgU1BEX0wpICovDQo+PiA+PiArI2RlZmluZSBSVEw4
MjYxWF9TUEVFRF9DT0RFXzUwME0gIDB4MyAgICAgLyogSD0wLCBMPTMgKi8NCj4+ID4+ICsjZGVm
aW5lIFJUTDgyNjFYX1NQRUVEX0NPREVfMTAwME0gMHg3ICAgICAvKiBIPTEsIEw9MyAqLw0KPj4g
Pj4gKyNkZWZpbmUgUlRMODI2MVhfU1BFRURfQ09ERV8yNTAwTSAweDggICAgIC8qIEg9MiwgTD0w
ICovDQo+PiA+PiArI2RlZmluZSBSVEw4MjYxWF9TUEVFRF9DT0RFXzUwMDBNIDB4OSAgICAgLyog
SD0yLCBMPTEgKi8NCj4+ID4+ICsjZGVmaW5lIFJUTDgyNjFYX1NQRUVEXzUwMCAgICAgICAgICAg
ICAgICA1MDANCj4+ID4NCj4+ID4gNTAwIE1CaXQvcyBpc250IGEgc3RhbmRhcmQgcmF0ZSB3aGlj
aCBhbHNvIGlzbnQgcmVwcmVzZW50ZWQgaW4gZXRodG9vbC4NCj4+ID4gSXMgdGhpcyBqdXN0IGZv
ciBkb2N1bWVudGF0aW9uIG9yIGludGVuZGVkIHRvIGJlIHVzZWQ/IElmIHllcywgaG93Pw0KPj4N
Cj4+IEdpZ2EtbGl0ZSAoNTAwTSkgaXMgYSBSZWFsdGVrLXByb3ByaWV0YXJ5IHNwZWVkOiB3aGVu
IHR3byBSZWFsdGVrIFBIWXMNCj4+IHN1cHBvcnRpbmcgR2lnYS1saXRlIGFyZSBjb25uZWN0ZWQg
YW5kIHRoZSBoaWdoZXIgc3BlZWQgaXMgZGlzYWJsZWQgb3INCj4+IHVuc3RhYmxlLCBhdXRvLW5l
Z290aWF0aW9uIG1heSBmYWxsIGJhY2sgdG8gNTAwTS4gU2luY2UgZXRodG9vbCBoYXMgbm8NCj4+
IFNQRUVEXzUwMCBkZWZpbml0aW9uLCB0aGUgZHJpdmVyIHJlcG9ydHMgU1BFRURfVU5LTk9XTiBm
b3IgdGhpcyBjYXNlLg0KPj4gU28gd2UgYWRkIHRoaXMuDQo+DQo+SXMgaXQgbmVnb3RpYXRlZD8g
V2hhdCBiaXQgZG9lcyBpdCB1c2UgaW4gd2hpY2ggY29kZSB3b3JkIHBhZ2UgdG8gYWNjb21wbGlz
aA0KPnRoaXM/IElzIHRoZXJlIGEgcmVnaXN0ZXIgd2hpY2ggY2FuIGJlIHVzZWQgdG8gY29udHJv
bCB0aGUgYWR2ZXJ0aXNlbWVudD8gQ2FuDQo+eW91IHNlZSB0aGUgbGluayBwYXJ0bmVyIGFkdmVy
dGlzZW1lbnQgZm9yIHRoaXMgYml0Pw0KPg0KPiAgICAgICAgQW5kcmV3DQoNClNQRUVEIDUwMCBp
cyByYXJlbHkgdXNlZC4gU28gSSB3aWxsIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCBwYXRjaC4NCg0K
VGhhbmtzLA0KQlJzLA0KSmF2ZW4NCg==

