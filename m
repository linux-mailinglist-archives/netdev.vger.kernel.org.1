Return-Path: <netdev+bounces-295762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t9nVHiahImrXbAEAu9opvQ
	(envelope-from <netdev+bounces-295762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:12:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38F647347
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:12:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=neNwKoGO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295762-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295762-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41001301BF6C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C73DB658;
	Fri,  5 Jun 2026 09:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA293E8325;
	Fri,  5 Jun 2026 09:59:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653567; cv=none; b=cbsPQhdpsv6daYnhWcv8zxhW+fu3n2O7hkfRPwWYmcmX5eBNF6nnJKbvCulL+1spusUwQ82PakdFWLD2uqu4zX6henHQVxiOex3CtRdFRDHxPFRxV44pR6vrIB/as4/56UmNcE7AExtsfSy1PZ5w05psdsULocCny9p+B6uZpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653567; c=relaxed/simple;
	bh=beXL6icbRMRcStpe1b88boZUqln4leUNubu3tDnjd1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTxZWwlqptazeVoZ3eHMqlp4OxUyukHPmd4xlnjXurJhlkAx13yWR+fEg0f44/PRyDcGZOMivclHu1aUoZGwIsvKG2zVArm5nFEnC6ge4kXqaXn+Goo3FvNQr5caTCLEKN/2ahosl25Crl1qo7oGz8noscNUwaQwI5/ABc7SwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=neNwKoGO; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6559wRrW51310688, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780653507;
	bh=beXL6icbRMRcStpe1b88boZUqln4leUNubu3tDnjd1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=neNwKoGOQIRPPN38GE/9LyzAnT83kor2F0Tb1ot29GKuARIURz8PRRxzf3yEdksiV
	 gP2JDeyYwHnqKnSc+X9Cl/eWVgMnazOT6XL2lICMlmkgFuitgQB/cR3k/dhFpfjSwn
	 ZKVCgD40X8YehhDoNjN2CrGbTFpixJ1xCrwAas4tGzHW8fCh9Jk5uUbp7rv+3zZQYa
	 zhx4fImHye3sO+Qkdeki4oup7l9fK9o+YEWyJrRrvfjMPcyKxiHiRSNzSsg3nYDVXp
	 b6kdsWUDgrwAAw2PqbKYqkW+OuHxgQuArySlDJUg1rDUoK/T8G1rQBHgwvPgEC/2o0
	 6/BHl2MDDixWA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6559wRrW51310688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 17:58:27 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 17:58:27 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 5 Jun 2026 17:58:27 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, =?gb2312?B?ucvP/r78?=
	<freddy_gu@realsil.com.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next v3 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Thread-Topic: [PATCH net-next v3 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Thread-Index: AQHc9L8BR5LGE7/b4kyGC8/Vf6LoC7YvJxOAgACRqBA=
Date: Fri, 5 Jun 2026 09:58:27 +0000
Message-ID: <2ef7327934824882a33e43eaca58d923@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-5-javen_xu@realsil.com.cn>
 <b2b2d485db137d26e3838116560f6d59@tipi-net.de>
In-Reply-To: <b2b2d485db137d26e3838116560f6d59@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295762-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E38F647347

PkhpIEphdmVuDQo+DQo+T24gNS42LjIwMjYgMDk6NDMsIGphdmVuIHdyb3RlOg0KPj4gRnJvbTog
SmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IFRoaXMgcGF0Y2ggYWRk
cyBzdXBwb3J0IGZvciBsb2FkaW5nIGZpcm13YXJlLiBEb3dubG9hZCBzb21lIHBhcmFtZXRlcnMN
Cj4+IGZvciBSVEw4MjYxQ19DRy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKYXZlbiBYdSA8amF2
ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAgLSBy
ZW1vdmUgX19wYWNrLCBzdHJ1Y3QgcnRsODI2MXhfZndfaGVhZGVyIGFuZCBydGw4MjYxeF9md19l
bnRyeSB3aWxsDQo+PiBub3QgcGFkDQo+PiAgLSByZXZlcnNlIHhtYXMgdHJlZSBmb3Igc29tZSBk
ZWZpbml0aW9uDQo+PiAgLSBhZGQgZXhwbGFuYXRpb24gb24gcnRsX3BoeV93cml0ZV9tbWRfYml0
cygpDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+ICAtIGFkZCBzdHJ1Y3QgcnRsODI2MXhfcHJp
dg0KPj4gLS0tDQo+DQo+PiBbLi4uXQ0KPg0KPj4gK3N0YXRpYyBpbnQgcnRsODI2MXhfY29uZmln
X2luaXQoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikgew0KPj4gKyAgICAgc3RydWN0IHJ0bDgy
NjF4X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7DQo+PiArICAgICBpbnQgcmV0ID0gMDsNCj4+
ICsNCj4+ICsgICAgIGlmIChwcml2LT5md19uYW1lICYmICFwcml2LT5md19sb2FkZWQpIHsNCj4+
ICsgICAgICAgICAgICAgcmV0ID0gcnRsODI2MXhfZndfbG9hZChwaHlkZXYpOw0KPj4gKyAgICAg
ICAgICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgcGh5ZGV2X2Vycihw
aHlkZXYsICJGaXJtd2FyZSBsb2FkaW5nIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+PiArICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKyAgICAg
fQ0KPg0KPmZ3X2xvYWRlZCBsb2FkcyBvbmNlIHBlciBsaWZldGltZSwgcGh5X2luaXRfaHcoKSBk
b2VzIHNvZnRfcmVzZXQgYmVmb3JlDQo+Y29uZmlnX2luaXQuDQo+U28gYWZ0ZXIgYSByZXNldCAo
ZS5nLiByZXN1bWUpLCBhcmVuJ3QgdGhlIHBhdGNoZXMgZ29uZSBhbmQgbmV2ZXIgcmUtYXBwbGll
ZD8NCj5lbjg4MTFoIGZvciBleGFtcGxlIHJlLXJ1bnMgZXZlcnkgY29uZmlnX2luaXQgLSBidXQg
anVzdCBndWVzc2luZyBhcyBJIGRvbid0DQo+a25vdyB0aGUgaW50ZXJuYWxzIG9mIHlvdXIgZncu
DQo+DQo+PiBbLi4uXQ0KPg0KPlRoYW5rcywNCj5OaWNvbGFpDQoNCkhpLCBOaWNvbGFpDQoNCkZv
ciBSVEw4MjYxQ19DRywgdGhlIHBhdGNoZXMgd2lsbCBub3QgYmUgbG9zdCBhZnRlciByZXN1bWUg
b3Igc29mdF9yZXNldC4gVGhleSBvbmx5IG5lZWQgdG8gYmUgZG93bmxvYWRlZCBhZ2FpbiBhZnRl
ciBhIHBvd2VyIGN5Y2xlIG9yIGEgaGFyZHdhcmUgcmVzZXQuDQpTbyB0aGUgZndfbG9hZGVkIGZs
YWcgaXMgaW50ZW5kZWQgdG8gYXZvaWQgcmVsb2FkaW5nIHRoZSBzYW1lIHBhcmFtZXRlcnMgbXVs
dGlwbGUgdGltZXMgZHVyaW5nIHRoZSBQSFkgZGV2aWNlIGxpZmV0aW1lLg0KDQpUaGFua3MsDQpC
UnMsDQpKYXZlbg0K

