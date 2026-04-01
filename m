Return-Path: <netdev+bounces-273825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCl/OXl4zGmxTAYAu9opvQ
	(envelope-from <netdev+bounces-273825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:44:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B44AF3738AF
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752003012EB2
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4418286D7D;
	Wed,  1 Apr 2026 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="YYWpfEgQ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBBA54774;
	Wed,  1 Apr 2026 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007861; cv=none; b=WiIDxFG64lIzxopLqOVmUXD9gevnEAFe1nptLBLvjfGSHOnjKqx0aGhICLdGlhSOhdjr4fb1hZijz/wjBHWKagjy62qeg7DMJjcAvki8uGX8LZuaZpXhtr3a9JorO0FxKnXUSNxewkHyjvZKwXZ5R5kMtasxH5f1AFF3wOKXCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007861; c=relaxed/simple;
	bh=lO29Zx+oJWGLKd2CCJxwMvbIKxRNFietDwO0T+oaEqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fqR83G1X9Mu/PclWWzD0E2/qnOYKtEys/6zgY58Hs+CuHvxf33yrk02MlMrUHEvPUQKgwXUok4JzHNPbAmRTt9uEtml01c9nNf7CE3gs5K33kfgLv3X/2E3IkfD+3oVQwgUh2VeziWHIC93D3yvYNVDNdq9Pr6+VULskiPj4AnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=YYWpfEgQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6311hjTY3162515, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1775007826;
	bh=lO29Zx+oJWGLKd2CCJxwMvbIKxRNFietDwO0T+oaEqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YYWpfEgQyFHNIbWiyliZgE/RhxCG01zMKEznDKrNTcneYKdOigxj1F4K2uyojJsd/
	 v7UVjZ929EaBbmy3fofLgAkD8R7Bmt6scba6vnd7cpdN4JEFRkfVmtCOTryS53VsBj
	 0+WQ4JHoPLWd1O4wqUdoSAbo6XpIV6w2JFwrEATRoqaW1vDOfDHd0+dG/cgpJD7RRT
	 QSEwv3Tl8n1tEuIhAKwjPpV974qvkEZzz1TDhZYhbmzTM0Mjf5iqFsw5aB84xlSlN2
	 Tm9nWmbDUAMNk0Gr+mV+OoHNHoarJMQgUtYJhhZKgWFSuUHZK2TvnSS4Eo0OUzYsSV
	 J+w08fFWoq5aA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6311hjTY3162515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 09:43:46 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Apr 2026 09:43:45 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 1 Apr 2026 09:43:45 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
Thread-Topic: [PATCH net-next v1 2/4] r8169: add sfp mode for RTL8116af
Thread-Index: AQHcqg5Z7uVmgFYgw0+wv8VnyYk43LWbR6uAgBDWaXCAAGZPgIAFmeqwgAJIkoCAFTbOgA==
Date: Wed, 1 Apr 2026 01:43:44 +0000
Message-ID: <d4357d7d824f4558842fb1997dff7867@realsil.com.cn>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-3-javen_xu@realsil.com.cn>
 <d2b97f5b-6032-49fd-b80a-6fb47f3fad4c@gmail.com>
 <98d632aecbbb4dd8ad79c24e672765b1@realsil.com.cn>
 <fcb72518-24f7-4e16-8208-fb38441408d2@gmail.com>
 <761cc11222bc4f4cb206629a76292c97@realsil.com.cn>
 <cd96bc5c-1087-4d13-b556-e1fd94e6322e@gmail.com>
In-Reply-To: <cd96bc5c-1087-4d13-b556-e1fd94e6322e@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273825-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B44AF3738AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pk9uIDE3LjAzLjIwMjYgMDQ6MTQsIEphdmVuIHdyb3RlOg0KPj4+IE9uIDEzLjAzLjIwMjYgMDg6
MjUsIEphdmVuIHdyb3RlOg0KPj4+Pj4gT24gMDIuMDMuMjAyNiAwNzozMiwgamF2ZW4gd3JvdGU6
DQo+Pj4+Pj4gRnJvbTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4+Pj4+
DQo+Pj4+Pj4gUlRMODExNmFmIGlzIGEgdmFyaWF0aW9uIG9mIFJUTDgxNjhmcC4gSXQgdXNlcyBT
ZXJEZXMgaW5zdGVhZCBvZiBQSFkuDQo+Pj4+Pj4gQnV0IFNlckRlcyBzdGF0dXMgd2lsbCBub3Qg
cmVsZWN0IHRvIFBIWS4gU28gaXQgbmVlZHMgdG8gYWRkIHNmcA0KPj4+Pj4+IG1vZGUgZm9yIHF1
aXJrIHRvIGhlbHAgcmVmbGVjdCBTZXJEZXMgc3RhdHVzIGR1cmluZyBQSFkgcmVhZC4NCj4+Pj4+
Pg0KPj4+Pj4NCj4+Pj4+IElzIHRoZXJlIGFueSBtYXNzIG1hcmtldCBkZXZpY2UgdXNpbmcgdGhp
cyBjaGlwIHZlcnNpb24/IEFzIGZhciBhcw0KPj4+Pj4gcG9zc2libGUgSSdkIGxpa2UgdG8gYXZv
aWQgYWRkaW5nIHN1cHBvcnQgZm9yIGNoaXAgdmVyc2lvbnMgdGhhdA0KPj4+Pj4gbmV2ZXIgbWFr
ZSBpdCB0byB0aGUgbWFzcyBtYXJrZXQuIFRoaXMganVzdCBtYWtlcyBkcml2ZXINCj4+Pj4+IG1h
aW50ZW5hbmNlDQo+Pj4gaGFyZGVyLg0KPj4+Pj4NCj4+Pj4+IFRoZSBwYXRjaCBpbmNsdWRlcyBz
dXBwb3J0IGZvciAxMDBNYnBzIGZpYmVyIG1vZGUuIElzIHRoZXJlIGFueSB1c2UNCj4+Pj4+IGNh
c2UgZm9yIHN1Y2ggbGVnYWN5IG1vZGVzPw0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4+Pj4+IC0tLQ0KPj4+
Pj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYyB8IDcxDQo+Pj4+
Pj4gKysrKysrKysrKysrKysrKysrKystLS0NCj4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDYyIGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+Pj4+PiBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+Pj4+Pj4gaW5kZXggZmIyMjQ3
YTIwYzM2Li5hNWMwZDM5OTUzMjggMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPj4+Pj4+IEBAIC03MjYsNiArNzI2LDEyIEBAIGVu
dW0gcnRsX2Rhc2hfdHlwZSB7DQo+Pj4+Pj4gICAgICAgUlRMX0RBU0hfMjVfQlAsDQo+Pj4+Pj4g
IH07DQo+Pj4+Pj4NCj4+Pj4+PiArZW51bSBydGxfc2ZwX21vZGUgew0KPj4+Pj4+ICsgICAgIFJU
TF9TRlBfTk9ORSwNCj4+Pj4+PiArICAgICBSVExfU0ZQXzgxNjhfQUYsDQo+Pj4+Pj4gKyAgICAg
UlRMX1NGUF84MTI3X0FURiwNCj4+Pj4+PiArfTsNCj4+Pj4+PiArDQo+Pj4+Pj4gIHN0cnVjdCBy
dGw4MTY5X3ByaXZhdGUgew0KPj4+Pj4+ICAgICAgIHZvaWQgX19pb21lbSAqbW1pb19hZGRyOyAg
ICAgICAgLyogbWVtb3J5IG1hcCBwaHlzaWNhbCBhZGRyZXNzDQo+Ki8NCj4+Pj4+PiAgICAgICBz
dHJ1Y3QgcGNpX2RldiAqcGNpX2RldjsNCj4+Pj4+PiBAQCAtNzM0LDYgKzc0MCw3IEBAIHN0cnVj
dCBydGw4MTY5X3ByaXZhdGUgew0KPj4+Pj4+ICAgICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBp
Ow0KPj4+Pj4+ICAgICAgIGVudW0gbWFjX3ZlcnNpb24gbWFjX3ZlcnNpb247DQo+Pj4+Pj4gICAg
ICAgZW51bSBydGxfZGFzaF90eXBlIGRhc2hfdHlwZTsNCj4+Pj4+PiArICAgICBlbnVtIHJ0bF9z
ZnBfbW9kZSBzZnBfbW9kZTsNCj4+Pj4+PiAgICAgICB1MzIgY3VyX3J4OyAvKiBJbmRleCBpbnRv
IHRoZSBSeCBkZXNjcmlwdG9yIGJ1ZmZlciBvZiBuZXh0IFJ4IHBrdC4gKi8NCj4+Pj4+PiAgICAg
ICB1MzIgY3VyX3R4OyAvKiBJbmRleCBpbnRvIHRoZSBUeCBkZXNjcmlwdG9yIGJ1ZmZlciBvZiBu
ZXh0IFJ4IHBrdC4gKi8NCj4+Pj4+PiAgICAgICB1MzIgZGlydHlfdHg7DQo+Pj4+Pj4gQEAgLTc2
MCw3ICs3NjcsNiBAQCBzdHJ1Y3QgcnRsODE2OV9wcml2YXRlIHsNCj4+Pj4+PiAgICAgICB1bnNp
Z25lZCBzdXBwb3J0c19nbWlpOjE7DQo+Pj4+Pj4gICAgICAgdW5zaWduZWQgYXNwbV9tYW5hZ2Vh
YmxlOjE7DQo+Pj4+Pj4gICAgICAgdW5zaWduZWQgZGFzaF9lbmFibGVkOjE7DQo+Pj4+Pj4gLSAg
ICAgYm9vbCBzZnBfbW9kZToxOw0KPj4+Pj4+ICAgICAgIGRtYV9hZGRyX3QgY291bnRlcnNfcGh5
c19hZGRyOw0KPj4+Pj4+ICAgICAgIHN0cnVjdCBydGw4MTY5X2NvdW50ZXJzICpjb3VudGVyczsN
Cj4+Pj4+PiAgICAgICBzdHJ1Y3QgcnRsODE2OV90Y19vZmZzZXRzIHRjX29mZnNldDsgQEAgLTEx
MjYsNyArMTEzMiw3IEBADQo+Pj4+Pj4gc3RhdGljIGludCByODE2OF9waHlfb2NwX3JlYWQoc3Ry
dWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIHUzMiByZWcpDQo+Pj4+Pj4gICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgIC8qIFJldHVybiBkdW1teSBNSUlfUEhZU0lE
MiBpbiBTRlAgbW9kZSB0byBtYXRjaCBTRlAgUEhZDQo+Pj4+Pj4gZHJpdmVyDQo+Pj4gKi8NCj4+
Pj4+PiAtICAgICBpZiAodHAtPnNmcF9tb2RlICYmIHJlZyA9PSAoT0NQX1NURF9QSFlfQkFTRSAr
IDIgKg0KPk1JSV9QSFlTSUQyKSkNCj4+Pj4+PiArICAgICBpZiAodHAtPnNmcF9tb2RlID09IFJU
TF9TRlBfODEyN19BVEYgJiYgcmVnID09DQo+Pj4+PiAoT0NQX1NURF9QSFlfQkFTRQ0KPj4+Pj4+
ICsgKyAyICogTUlJX1BIWVNJRDIpKQ0KPj4+Pj4+ICAgICAgICAgICAgICAgcmV0dXJuIFBIWV9J
RF9SVExfRFVNTVlfU0ZQICYgMHhmZmZmOw0KPj4+Pj4+DQo+Pj4+Pj4gICAgICAgUlRMX1czMih0
cCwgR1BIWV9PQ1AsIHJlZyA8PCAxNSk7IEBAIC0xMjcwLDYgKzEyNzYsMzQgQEANCj4+Pj4+PiBz
dGF0aWMgaW50IHI4MTY4Z19tZGlvX3JlYWQoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIGlu
dCByZWcpDQo+Pj4+Pj4gICAgICAgcmV0dXJuIHI4MTY4X3BoeV9vY3BfcmVhZCh0cCwgdHAtPm9j
cF9iYXNlICsgcmVnICogMik7ICB9DQo+Pj4+Pj4NCj4+Pj4+PiArLyogVGhlIHF1aXJrIHJlZmxl
Y3RzIFJUTDgxMTZhZiBTZXJEZXMgc3RhdHVzLiAqLyBzdGF0aWMgaW50DQo+Pj4+Pj4gK3I4MTE2
YWZfbWRpb19yZWFkX3F1aXJrKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLCBpbnQgcmVnKSB7
DQo+Pj4+Pj4gKyAgICAgdTggcGh5U3RhdHVzID0gUlRMX1I4KHRwLCBQSFlzdGF0dXMpOw0KPj4+
Pj4+ICsNCj4+Pj4+PiArICAgICBpZiAoIShwaHlTdGF0dXMgJiBMaW5rU3RhdHVzKSkNCj4+Pj4+
PiArICAgICAgICAgICAgIHJldHVybiAwOw0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICAvKiBCTVNS
ICovDQo+Pj4+Pj4gKyAgICAgaWYgKHRwLT5vY3BfYmFzZSA9PSBPQ1BfU1REX1BIWV9CQVNFICYm
IHJlZyA9PSBNSUlfQk1TUikNCj4+Pj4+PiArICAgICAgICAgICAgIHJldHVybiBCTVNSX0FORUdD
T01QTEVURSB8IEJNU1JfTFNUQVRVUzsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICAgLyogUEhZU1Ig
Ki8NCj4+Pj4+PiArICAgICBpZiAodHAtPm9jcF9iYXNlID09IDB4YTQzMCAmJiByZWcgPT0gMHgx
Mikgew0KPj4+Pj4+ICsgICAgICAgICAgICAgaWYgKHBoeVN0YXR1cyAmIF8xMDAwYnBzRikNCj4+
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDB4MDAyODsNCj4+Pj4+PiArICAgICAg
ICAgICAgIGVsc2UgaWYgKHBoeVN0YXR1cyAmIF8xMDBicHMpDQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAweDAwMTg7DQo+Pj4+Pg0KPj4+Pj4gVGhpcyBpcyBhIGNvbXBsZXRl
IGhhY2suIEFueSBtZWFucyB0byBhY2Nlc3MgdGhlIFNlckRlcyBkaXJlY3RseT8NCj4+Pj4NCj4+
Pj4gSGksIEhlaW5lcg0KPj4+PiBOb3cgd2UgZmluZCBhIGluZGlyZWN0IGFjY2VzcyB0byBzZXJk
ZXMgcmVnLiBUaGUgc2VyZGVzIHJlZyBpcw0KPj4+PiBkZXNpZ25lZA0KPj4+IGFjY29yZGluZyB0
byBJRUVFIDgwMi4zLg0KPj4+PiBCSVQgMiBtZWFucyBMaW5rIFN0YXR1cyBhbmQgQklUIDUgbWVh
bnMgQU5FR0NPTVBMRVRFLiBXZSBjYW4gYWNjZXNzDQo+Pj4+IGl0IHRocm91Z2ggcmVhZCBtYWMg
b2NwIDB4ZWIxNCwgSSB3b25kZXIgd2hldGhlciB0aGlzIGluZGlyZWN0DQo+Pj4+IGFjY2VzcyBj
YW4gYmUNCj4+PiBhY2NlcHRlZD8NCj4+Pj4NCj4+PiBCYXNlZCBvbiB0aGUgYml0IG51bWJlcnMg
dGhpcyBzZWVtcyB0byBiZSB0aGUgQk1TUiByZWdpc3Rlci4gQ2FuIGFsbA0KPj4+IGNsYXVzZQ0K
Pj4+IDIyIHJlZ2lzdGVycyBiZSBhY2Nlc3NlZCBpbiBhIHNpbWlsYXIgd2F5IHNvIHRoYXQgYSBN
SUkgYnVzIGNhbiBiZQ0KPj4+IGltcGxlbWVudGVkIGZvciBhY2Nlc3NpbmcgdGhlIFNlckRlcz8N
Cj4+DQo+PiBXZSBjaGVja2VkIG91ciBjaGlwIGRvY3VtZW50YXRpb24gYW5kIGNvbmZpcm1lZCB0
aGF0IHRoZSBTZXJEZXMNCj4+IHJlZ2lzdGVyIGZpbGUgbWFwcyBhbGwgY2xhdXNlIDIyIHJlZ2lz
dGVycyhlLmcuIFdSIDB4ZWIxMDxyZWdfYWRkcj4sDQo+PiBSRCAweGViMTQuIHJlZ19hZGRyIDB4
NDAgaXMgZm9yIEJNQ1IsDQo+PiAweDQxIGZvciBCTVNSLCAweDQyIGZvciBQSFlTSUQxLCAweDQz
IGZvciBQSFlTSUQyLCBldGMuKSBBcyB5b3UNCj4+IHN1Z2dlc3RlZCwgSSB3b25kZXIgd2hldGhl
ciB0aGUgcHJvcGVyIGFwcHJvYWNoIGlzIHRvIGltcGxlbWVudCBhDQo+PiB2aXJ0dWFsIG1paV9i
dXMgYW5kIG1hcCB0aGUgc3RhbmRhcmQgc2VyZGVzIHJlZyBpbiB0aGUgbmV3IG1hcC4NCj4+DQo+
V2UnZCBuZWVkIHRvIGtub3cgaG93IHRoZSBpbnRlcm5hbCBQSFkgYW5kIHRoZSBTZXJEZXMgcGxh
eSB0b2dldGhlci4NCj5XaGV0aGVyIHRoZSB1c3VhbCBpbnRlcm5hbCBQSFkgcGxheXMgYW55IHJv
bGUgaW4gY29tbXVuaWNhdGlvbiBiZXR3ZWVuDQo+TUFDIGFuZCBTZXJEZXMuDQo+SG93IGludGVy
ZmFjZSBtb2RlcyBhcmUgY29udHJvbGxlZCBvbiBNQUMgYW5kIFNlckRlcyBzaWRlLCBldGMuDQo+
SWYgUmVhbHRlayBkb2Vzbid0IGltcGxlbWVudCBwcm9wZXIgbGF5ZXJpbmcgaW4gaHcsIGFuZCBk
b2Vzbid0IGhhdmUgZW5vdWdoDQo+a25vd2xlZGdlIGFib3V0IG1haW5saW5lIG5ldHdvcmsgZHJp
dmVyIHN0cnVjdHVyZXMsIGFuZCBvbiB0aGUgb3RoZXIgaGFuZA0KPmRvZXNuJ3Qgd2FudCB0byBw
cm92aWRlIGNoaXAgZG9jdW1lbnRhdGlvbiwgdGhlbiB0aGUgc2l0dWF0aW9uIHNvbWV3aGF0DQo+
ZGVhZGxvY2tzLg0KPg0KDQpIaSwgSGVpbmVyDQpGb3IgUlRMODExNmFmLCB0aGUgZGF0YXBhdGgg
aXMgc3RydWN0dXJlZCBhcyBNQUMtPlBDUy0+U2VyRGVzLg0KSG93ZXZlciwgUENTIGJsb2NrIGRv
ZXMgbm90IGhhdmUgYSBzdGFuZGFyZCBNRElPIGludGVyZmFjZS4gSW5zdGVhZCwgd2UgaGF2ZSB0
byANCmFjY2VzcyB0aGUgc3RhbmRhcmQgcmVnIHZpYSBNQUMgT0NQLlRoZXNlIHN0YW5kYXJkIHJl
Z2lzdGVycyBhcmUgZXhhY3RseSB0aGUgc3RhbmRhcmQgDQpJRUVFIDgwMi4zIENsYXVzZSAyMiBQ
SFkgcmVnaXN0ZXJzLg0KR2l2ZW4gaGFyZHdhcmUgaW5mb3JtYXRpb24gYWJvdmUsIEkgd291bGQg
bGlrZSB0byBhc2sgZm9yIHlvdXIgYWR2aWNlIG9uIHRoZSByZWNvbW1lbmRlZCANCmFwcHJvYWNo
IHRvIHN1cHBvcnQgUlRMODExNmFmLiBPciBhbnkgb3RoZXIgaW5mb3JtYXRpb24gZG8gSSBuZWVk
IHRvIHByb3ZpZGU/DQoNClRoYW5rcywNCkphdmVuIFh1DQoNCj4+PiBJbiBnZW5lcmFsIGl0J3Mg
aGFyZCB0byBwcm92aWRlIGEgc3RhdGVtZW50IHcvbyBrbm93aW5nIHRoZSBpbnRlcm5hbA0KPj4+
IGxheW91dCBvZiB0aGUgSVAgYmxvY2tzLg0KPj4+IENhbiB5b3UgcHJvdmlkZSBhbnkgY2hpcCBk
b2N1bWVudGF0aW9uIC8gZGF0YXNoZWV0Pw0KPj4+IEZvciBwcm9wZXIgc3VwcG9ydCBvZiBzdWNo
IGEgY29tcG9uZW50IGNoYWluIGJldHdlZW4gTUFDIGFuZCBTRlAgcG9ydA0KPj4+IHRoZSBkcml2
ZXIgd291bGQgaGF2ZSB0byBiZSBjb252ZXJ0ZWQgdG8gdXNlIHBoeWxpbmssIHdoYXQgcmVxdWly
ZXMNCj4+PiBhY2Nlc3MgdG8gdGhlIGludm9sdmVkIGNvbXBvbmVudHMsIGluY2wuIHRoZSBTRlAg
STJDIGJ1cy4NCj4+Pg0KPj4+DQo+Pj4+IFRoYW5rcywNCj4+Pj4gSmF2ZW4gWHUNCj4+Pj4NCj4+
Pj4+DQo+Pj4+Pj4gKyAgICAgfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICByZXR1cm4gMDsNCj4+
Pj4+PiArfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArc3RhdGljIGludCByODExNmFmX21kaW9fcmVhZChz
dHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwgaW50IHJlZykgew0KPj4+Pj4+ICsgICAgIHJldHVy
biByODE2OGdfbWRpb19yZWFkKHRwLCByZWcpIHwNCj4+Pj4+PiArcjgxMTZhZl9tZGlvX3JlYWRf
cXVpcmsodHAsIHJlZyk7IH0NCj4+Pj4+PiArDQo+Pj4+Pj4gIHN0YXRpYyB2b2lkIG1hY19tY3Vf
d3JpdGUoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIGludCByZWcsDQo+Pj4+Pj4gaW50DQo+
Pj4+Pj4gdmFsdWUpICB7DQo+Pj4+Pj4gICAgICAgaWYgKHJlZyA9PSAweDFmKSB7DQo+Pj4+Pj4g
QEAgLTEyODAsNiArMTMxNCwxMyBAQCBzdGF0aWMgdm9pZCBtYWNfbWN1X3dyaXRlKHN0cnVjdA0K
Pj4+Pj4+IHJ0bDgxNjlfcHJpdmF0ZQ0KPj4+Pj4gKnRwLCBpbnQgcmVnLCBpbnQgdmFsdWUpDQo+
Pj4+Pj4gICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgdHAtPm9jcF9iYXNlICsgcmVnLCB2
YWx1ZSk7ICB9DQo+Pj4+Pj4NCj4+Pj4+PiArc3RhdGljIGJvb2wgcnRsX2lzXzgxMTZhZihzdHJ1
Y3QgcnRsODE2OV9wcml2YXRlICp0cCkgew0KPj4+Pj4+ICsgICAgIHJldHVybiB0cC0+bWFjX3Zl
cnNpb24gPT0gUlRMX0dJR0FfTUFDX1ZFUl81MiAmJg0KPj4+Pj4+ICsgICAgICAgICAgICAgKHI4
MTY4X21hY19vY3BfcmVhZCh0cCwgMHhkYzAwKSAmIDB4MDA3OCkgPT0gMHgwMDMwICYmDQo+Pj4+
Pj4gKyAgICAgICAgICAgICAocjgxNjhfbWFjX29jcF9yZWFkKHRwLCAweGQwMDYpICYgMHgwMGZm
KSA9PSAweDAwMDA7DQo+Pj4+Pj4gK30NCj4+Pj4+PiArDQo+Pj4+Pj4gIHN0YXRpYyBpbnQgbWFj
X21jdV9yZWFkKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwLCBpbnQgcmVnKSAgew0KPj4+Pj4+
ICAgICAgIHJldHVybiByODE2OF9tYWNfb2NwX3JlYWQodHAsIHRwLT5vY3BfYmFzZSArIHJlZyk7
IEBADQo+Pj4+Pj4gLTEzODYsNw0KPj4+Pj4+ICsxNDI3LDEwIEBAIHN0YXRpYyBpbnQgcnRsX3Jl
YWRwaHkoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIGludA0KPj4+Pj4+ICtsb2NhdGlvbikN
Cj4+Pj4+PiAgICAgICBjYXNlIFJUTF9HSUdBX01BQ19WRVJfMzE6DQo+Pj4+Pj4gICAgICAgICAg
ICAgICByZXR1cm4gcjgxNjhkcF8yX21kaW9fcmVhZCh0cCwgbG9jYXRpb24pOw0KPj4+Pj4+ICAg
ICAgIGNhc2UgUlRMX0dJR0FfTUFDX1ZFUl80MCAuLi4gUlRMX0dJR0FfTUFDX1ZFUl9MQVNUOg0K
Pj4+Pj4+IC0gICAgICAgICAgICAgcmV0dXJuIHI4MTY4Z19tZGlvX3JlYWQodHAsIGxvY2F0aW9u
KTsNCj4+Pj4+PiArICAgICAgICAgICAgIGlmICh0cC0+c2ZwX21vZGUgPT0gUlRMX1NGUF84MTY4
X0FGKQ0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcjgxMTZhZl9tZGlvX3Jl
YWQodHAsIGxvY2F0aW9uKTsNCj4+Pj4+PiArICAgICAgICAgICAgIGVsc2UNCj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHI4MTY4Z19tZGlvX3JlYWQodHAsIGxvY2F0aW9uKTsN
Cj4+Pj4+PiAgICAgICBkZWZhdWx0Og0KPj4+Pj4+ICAgICAgICAgICAgICAgcmV0dXJuIHI4MTY5
X21kaW9fcmVhZCh0cCwgbG9jYXRpb24pOw0KPj4+Pj4+ICAgICAgIH0NCj4+Pj4+PiBAQCAtMTU3
NSw2ICsxNjE5LDIwIEBAIHN0YXRpYyBib29sIHJ0bF9kYXNoX2lzX2VuYWJsZWQoc3RydWN0DQo+
Pj4+PiBydGw4MTY5X3ByaXZhdGUgKnRwKQ0KPj4+Pj4+ICAgICAgIH0NCj4+Pj4+PiAgfQ0KPj4+
Pj4+DQo+Pj4+Pj4gK3N0YXRpYyBlbnVtIHJ0bF9zZnBfbW9kZSBydGxfZ2V0X3NmcF9tb2RlKHN0
cnVjdCBydGw4MTY5X3ByaXZhdGUNCj4+Pj4+PiArKnRwKSB7DQo+Pj4+Pj4gKyAgICAgaWYgKHJ0
bF9pc184MTI1KHRwKSkgew0KPj4+Pj4+ICsgICAgICAgICAgICAgdTE2IGRhdGEgPSByODE2OF9t
YWNfb2NwX3JlYWQodHAsIDB4ZDAwNik7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgICAgICAgICAg
aWYgKChkYXRhICYgMHhmZikgPT0gMHgwNykNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIFJUTF9TRlBfODEyN19BVEY7DQo+Pj4+Pj4gKyAgICAgfSBlbHNlIGlmIChydGxfaXNf
ODExNmFmKHRwKSkgew0KPj4+Pj4+ICsgICAgICAgICAgICAgcmV0dXJuIFJUTF9TRlBfODE2OF9B
RjsNCj4+Pj4+PiArICAgICB9DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgIHJldHVybiBSVExfU0ZQ
X05PTkU7DQo+Pj4+Pj4gK30NCj4+Pj4+PiArDQo+Pj4+Pj4gIHN0YXRpYyBlbnVtIHJ0bF9kYXNo
X3R5cGUgcnRsX2dldF9kYXNoX3R5cGUoc3RydWN0DQo+Pj4+Pj4gcnRsODE2OV9wcml2YXRlDQo+
Pj4+Pj4gKnRwKSAgew0KPj4+Pj4+ICAgICAgIHN3aXRjaCAodHAtPm1hY192ZXJzaW9uKSB7DQo+
Pj4+Pj4gQEAgLTU2OTMsMTIgKzU3NTEsNyBAQCBzdGF0aWMgaW50IHJ0bF9pbml0X29uZShzdHJ1
Y3QgcGNpX2Rldg0KPj4+Pj4+ICpwZGV2LCBjb25zdA0KPj4+Pj4gc3RydWN0IHBjaV9kZXZpY2Vf
aWQgKmVudCkNCj4+Pj4+PiAgICAgICB9DQo+Pj4+Pj4gICAgICAgdHAtPmFzcG1fbWFuYWdlYWJs
ZSA9ICFyYzsNCj4+Pj4+Pg0KPj4+Pj4+IC0gICAgIGlmIChydGxfaXNfODEyNSh0cCkpIHsNCj4+
Pj4+PiAtICAgICAgICAgICAgIHUxNiBkYXRhID0gcjgxNjhfbWFjX29jcF9yZWFkKHRwLCAweGQw
MDYpOw0KPj4+Pj4+IC0NCj4+Pj4+PiAtICAgICAgICAgICAgIGlmICgoZGF0YSAmIDB4ZmYpID09
IDB4MDcpDQo+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgIHRwLT5zZnBfbW9kZSA9IHRydWU7
DQo+Pj4+Pj4gLSAgICAgfQ0KPj4+Pj4+ICsgICAgIHRwLT5zZnBfbW9kZSA9IHJ0bF9nZXRfc2Zw
X21vZGUodHApOw0KPj4+Pj4+DQo+Pj4+Pj4gICAgICAgdHAtPmRhc2hfdHlwZSA9IHJ0bF9nZXRf
ZGFzaF90eXBlKHRwKTsNCj4+Pj4+PiAgICAgICB0cC0+ZGFzaF9lbmFibGVkID0gcnRsX2Rhc2hf
aXNfZW5hYmxlZCh0cCk7DQo+Pj4+DQo+Pg0KDQo=

