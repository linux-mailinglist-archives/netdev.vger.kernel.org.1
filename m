Return-Path: <netdev+bounces-263699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE8aFjcAqGnynAAAu9opvQ
	(envelope-from <netdev+bounces-263699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:49:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9D1FDE2C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D99131BDDDB
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A39539EF13;
	Wed,  4 Mar 2026 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="E/7isdWF"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1239D6E1;
	Wed,  4 Mar 2026 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617436; cv=none; b=GHB5ZI37RaY+R0rtBufJlZusw/xAK0sTTBVrycuwkuIj/SHUBDT4PjRigyHzXiDLOSqGic1dIII+JLcmrv5OX2vgQkMGGApODg//TtO3qYCeQFDnbGIvUQnCUrjRx4BRfK1S5KFXHhfI/p4yev6C9L09JuONz4yApJm0mjRB+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617436; c=relaxed/simple;
	bh=8QAbcKpW3UIEG2eOsNkcXnIzeUIAlSoCzuCV10kZeLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YoHIodwIZjjRGDKYK/HqYFYvyJSpoND3U9b9IO4LtRwpWzIF/ZUnMHRfgTsC1XyH559Tr0O1XblXwz8KWqvw0JB5h9NKGomAEDDYF93MZwh5kKCJLLTdQQuemcuBEN2bzKYnx2JKvplfVeyZJqXRnyJCCCsxODH7DeT9CUv4ZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=E/7isdWF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6249hMpC53072469, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772617402;
	bh=8QAbcKpW3UIEG2eOsNkcXnIzeUIAlSoCzuCV10kZeLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=E/7isdWFBjbWgFzz621c+/HQFwfDMWtcppeQ7kCoDvjNmK2o8zVcWWyq3lfkNzhqc
	 PDJ4IE+fknY/WQWpC0xXd5/vAsX5gZXpS6aFPgNTTAHIgchr2HOB8tX4fbmAGdUMVl
	 bJSgyN+0BxDbOKtH+nvH3BLI3iHyrcfwtIdNsrkjt+brW1NQUrlPTO+UjvipDZqupE
	 GIKnNhSkBgRwKtw8lshZuPkm5DumL1vULqfGoJZO618HAOwDPXJ5cCozcsodzYrL2g
	 ffbUZoKGgIkHdHA8AWkz0pQrpxRtZztrBzQx1KJxiIJjm9C1pD20f7KIKxe89309Ub
	 UXj58iniNN09w==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6249hMpC53072469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Mar 2026 17:43:22 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 4 Mar 2026 17:43:22 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.1748.039; Wed,
 4 Mar 2026 17:43:22 +0800
From: =?utf-8?B?6K645L+K5Lyf?= <javen_xu@realsil.com.cn>
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
Subject: RE: [PATCH net-next v1 4/4] r8169: enable system enter c10 with
 RTL8116af
Thread-Topic: [PATCH net-next v1 4/4] r8169: enable system enter c10 with
 RTL8116af
Thread-Index: AQHcqg5agfaJnCS8+0OnqQrVxYsUrbWbQ6kAgALQoYA=
Date: Wed, 4 Mar 2026 09:43:22 +0000
Message-ID: <f1912e8588604b9b86646a86eac05c6c@realsil.com.cn>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-5-javen_xu@realsil.com.cn>
 <9b6aeead-4e60-4df4-8aaf-b07ab2c99d46@gmail.com>
In-Reply-To: <9b6aeead-4e60-4df4-8aaf-b07ab2c99d46@gmail.com>
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
X-Rspamd-Queue-Id: B1F9D1FDE2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263699-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Pk9uIDAyLjAzLjIwMjYgMDc6MzIsIGphdmVuIHdyb3RlOg0KPj4gRnJvbTogSmF2ZW4gWHUgPGph
dmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IFJUTDgxMTZhZiBpcyBhIG11bHRpIGZ1bmN0
aW9uIGNoaXAuIEZ1bmN0aW9uIDEgaXMgbG9hZCB3aXRoIHI4MTY5DQo+PiBkcml2ZXIuIEZ1bmN0
aW9uIDAgaXMgYm1jIHZpcnVhbCBkcml2ZXIgd2hpY2ggaXMgdXNlZCBmb3IgcG93ZXINCj4+IG1h
bmFnZW1lbnQuIFRoaXMgcGF0Y2ggc2V0IEZ1bmN0aW9uIDIgdG8gNyBpbnRvIGQzIHN0YXRlIHdo
ZW4gY29uZmlnDQo+PiBod19jb25maWcuIFRoaXMgaGVscHMgdGhlIHdob2xlIHN5c3RlbSBlbnRl
ciBjMTAuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwu
Y29tLmNuPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9t
YWluLmMgfCA5NQ0KPj4gKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgOTUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFs
dGVrL3I4MTY5X21haW4uYw0KPj4gaW5kZXggNzg3ODU5YjBhYjY4Li5kOGZmYzc2MTg2YjIgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0K
Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+IEBA
IC0xMTIxLDYgKzExMjEsMTAwIEBAIERFQ0xBUkVfUlRMX0NPTkQocnRsX29jcF9ncGh5X2NvbmQp
DQo+PiAgICAgICByZXR1cm4gUlRMX1IzMih0cCwgR1BIWV9PQ1ApICYgT0NQQVJfRkxBRzsgIH0N
Cj4+DQo+PiArc3RhdGljIHUzMiBydGxfb3RoZXJfY3NpX3JlYWQoc3RydWN0IHJ0bDgxNjlfcHJp
dmF0ZSAqdHAsIHU4DQo+PiArbXVsdGlfZnVuX3NlbF9iaXQsIGludCBhZGRyKSB7DQo+PiArICAg
ICBSVExfVzMyKHRwLCBDU0lBUiwgKGFkZHIgJiBDU0lBUl9BRERSX01BU0spIHwgbXVsdGlfZnVu
X3NlbF9iaXQNCj48PCAxNiB8DQo+PiArICAgICAgICAgICAgIENTSUFSX0JZVEVfRU5BQkxFKTsN
Cj4+ICsNCj4+ICsgICAgIHJldHVybiBydGxfbG9vcF93YWl0X2hpZ2godHAsICZydGxfY3NpYXJf
Y29uZCwgMTAsIDEwMCkgPw0KPj4gKyAgICAgICAgICAgICBSVExfUjMyKHRwLCBDU0lEUikgOiB+
MDsgfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIHJ0bF9vdGhlcl9jc2lfd3JpdGUoc3RydWN0IHJ0
bDgxNjlfcHJpdmF0ZSAqdHAsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBt
dWx0aV9mdW5fc2VsX2JpdCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBh
ZGRyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHZhbHVlKSB7DQo+PiAr
ICAgICBSVExfVzMyKHRwLCBDU0lEUiwgdmFsdWUpOw0KPj4gKyAgICAgUlRMX1czMih0cCwgQ1NJ
QVIsIENTSUFSX1dSSVRFX0NNRCB8IChhZGRyICYgQ1NJQVJfQUREUl9NQVNLKQ0KPnwNCj4+ICsg
ICAgICAgICAgICAgQ1NJQVJfQllURV9FTkFCTEUgfCBtdWx0aV9mdW5fc2VsX2JpdCA8PCAxNik7
DQo+PiArDQo+PiArICAgICBydGxfbG9vcF93YWl0X2xvdyh0cCwgJnJ0bF9jc2lhcl9jb25kLCAx
MCwgMTAwKTsgfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIHJ0bDgxNjhfY2xlYXJfYW5kX3NldF9v
dGhlcl9mdW5fcGNpX2JpdChzdHJ1Y3QgcnRsODE2OV9wcml2YXRlDQo+KnRwLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBtdWx0aV9mdW5f
c2VsX2JpdCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdTMyIGFkZHIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHUzMiBjbGVhcm1hc2ssDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBzZXRtYXNrKSB7DQo+PiArICAgICB1MzIgdmFs
Ow0KPj4gKw0KPj4gKyAgICAgdmFsID0gcnRsX290aGVyX2NzaV9yZWFkKHRwLCBtdWx0aV9mdW5f
c2VsX2JpdCwgYWRkcik7DQo+PiArICAgICB2YWwgJj0gfmNsZWFybWFzazsNCj4+ICsgICAgIHZh
bCB8PSBzZXRtYXNrOw0KPj4gKyAgICAgcnRsX290aGVyX2NzaV93cml0ZSh0cCwgbXVsdGlfZnVu
X3NlbF9iaXQsIGFkZHIsIHZhbCk7IH0NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBydGw4MTY4X290
aGVyX2Z1bl9kZXZfcGNpX3NldHRpbmcoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBhZGRyLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgY2xlYXJtYXNr
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgc2V0
bWFzaywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTgg
bXVsdGlfZnVuX3NlbF9iaXQpIHsNCj4+ICsgICAgIHUzMiB2YWw7DQo+PiArICAgICB1OCBpOw0K
Pj4gKyAgICAgdTggRnVuQml0Ow0KPj4gKyAgICAgLyogMDogQk1DLCAxOiBOSUMsIDI6IFRDUiwg
MzogVkdBL1BDSUVfVE9fVVNCLCA0OiBFSENJLCA1OiBXSUZJLCA2OiBXSUZJLA0KPjc6IEtDUyAq
Lw0KPj4gKyAgICAgZm9yIChpID0gMDsgaSA8IDg7IGkrKykgew0KPj4gKyAgICAgICAgICAgICBG
dW5CaXQgPSAoMSA8PCBpKTsNCj4+ICsgICAgICAgICAgICAgaWYgKEZ1bkJpdCAmIG11bHRpX2Z1
bl9zZWxfYml0KSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgdTggc2V0X290aGVyX2Z1biA9
IHRydWU7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgICAgICAgaWYgKGkgPT0gMCkgew0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2V0X290aGVyX2Z1biA9IHRydWU7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChpID09IDUgfHwgaSA9PSA2KSB7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodHAtPmRhc2hfZW5hYmxlZCkgew0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWwgPSBydGxfZXJpX3JlYWQo
dHAsIDB4MTg0KTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHZhbCAmIEJJVCgyNikpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2V0X290aGVyX2Z1biA9IGZhbHNlOw0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlbHNlDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc2V0X290aGVyX2Z1biA9IHRydWU7DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+PiArICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbCA9IHJ0bF9vdGhlcl9jc2lfcmVhZCh0cCwg
aSwgMHgwMCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodmFsID09IDB4
ZmZmZmZmZmYpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNldF9v
dGhlcl9mdW4gPSB0cnVlOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZXRfb3RoZXJfZnVuID0g
ZmFsc2U7DQo+PiArICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIGlmIChzZXRfb3RoZXJfZnVuKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cnRsODE2OF9jbGVhcl9hbmRfc2V0X290aGVyX2Z1bl9wY2lfYml0KHRwLCBpLCBhZGRyLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNsZWFybWFzaywgc2V0bWFzayk7DQo+PiArICAgICAgICAgICAgIH0NCj4+
ICsgICAgIH0NCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgcnRsODE2OF9zZXRfZGFzaF9v
dGhlcl9mdW5fZGV2X3N0YXRlX2NoYW5nZShzdHJ1Y3QNCj5ydGw4MTY5X3ByaXZhdGUgKnRwLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dTggZGV2X3N0YXRlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdTgNCj4+ICttdWx0aV9mdW5fc2VsX2JpdCkgew0KPj4gKyAgICAgdTMy
IGNsZWFybWFzazsNCj4+ICsgICAgIHUzMiBzZXRtYXNrOw0KPj4gKw0KPj4gKyAgICAgaWYgKGRl
dl9zdGF0ZSA9PSAwKSB7DQo+PiArICAgICAgICAgICAgIGNsZWFybWFzayA9IChCSVQoMCkgfCBC
SVQoMSkpOw0KPj4gKyAgICAgICAgICAgICBzZXRtYXNrID0gMDsNCj4+ICsgICAgICAgICAgICAg
cnRsODE2OF9vdGhlcl9mdW5fZGV2X3BjaV9zZXR0aW5nKHRwLCAweDQ0LCBjbGVhcm1hc2ssDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZXRtYXNr
LCBtdWx0aV9mdW5fc2VsX2JpdCk7DQo+PiArICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAg
ICBjbGVhcm1hc2sgPSAwOw0KPj4gKyAgICAgICAgICAgICBzZXRtYXNrID0gKEJJVCgwKSB8IEJJ
VCgxKSk7DQo+PiArICAgICAgICAgICAgIHJ0bDgxNjhfb3RoZXJfZnVuX2Rldl9wY2lfc2V0dGlu
Zyh0cCwgMHg0NCwgY2xlYXJtYXNrLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2V0bWFzaywgbXVsdGlfZnVuX3NlbF9iaXQpOw0KPj4gKyAgICAg
fQ0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgdm9pZCByODE2OF9waHlfb2NwX3dyaXRlKHN0cnVj
dCBydGw4MTY5X3ByaXZhdGUgKnRwLCB1MzIgcmVnLA0KPj4gdTMyIGRhdGEpICB7DQo+PiAgICAg
ICBpZiAocnRsX29jcF9yZWdfZmFpbHVyZShyZWcpKQ0KPj4gQEAgLTM3ODUsNiArMzg3OSw3IEBA
IHN0YXRpYyB2b2lkIHJ0bF9od19zdGFydF84MTE3KHN0cnVjdA0KPnJ0bDgxNjlfcHJpdmF0ZSAq
dHApDQo+PiAgICAgICByODE2OF9tYWNfb2NwX3dyaXRlKHRwLCAweGMwOTQsIDB4MDAwMCk7DQo+
PiAgICAgICByODE2OF9tYWNfb2NwX3dyaXRlKHRwLCAweGMwOWUsIDB4MDAwMCk7DQo+Pg0KPj4g
KyAgICAgcnRsODE2OF9zZXRfZGFzaF9vdGhlcl9mdW5fZGV2X3N0YXRlX2NoYW5nZSh0cCwgMywg
MHhmYyk7DQo+PiAgICAgICAvKiBmaXJtd2FyZSBpcyBmb3IgTUFDIG9ubHkgKi8NCj4+ICAgICAg
IHI4MTY5X2FwcGx5X2Zpcm13YXJlKHRwKTsNCj4+ICB9DQo+DQo+VGhpcyBpcyB0aGUgdHlwZSBv
ZiBjb2RlIHRoYXQgd291bGQgbWFrZSByODE2OSBiZWNvbWUgYW4gdW5tYWludGFpbmFibGUNCj5t
ZXNzIGxpa2UgdGhlIHZlbmRvciBkcml2ZXJzLiBXaHkgbm90IHVzZSBzdGFuZGFyZCBtZWFucyBs
aWtlDQo+cGNpX2J1c19yZWFkX2NvbmZpZ193b3JkKCkgZXQgYWw/DQoNClRoYW5rcyBmb3IgdGhl
IHN1Z2dlc3Rpb24uDQpJIGZpcnN0IHRyaWVkIHRvIHVzZSBsc3BjaSwgYnV0IEkgY2FuJ3QgZmlu
ZCBmdW5jdGlvbiAyLTcgaW4gcGNpIHN5c3RlbS4gVGhlbiBJIHRyaWVkIHRvDQp1c2UgcGNpX2J1
c19yZWFkX2NvbmZpZ193b3JkKCkgdG8gYWNjZXNzIEZ1bmN0aW9uIDItNyBhbmQgZ2V0IHJlc3Vs
dCBhcyBiZWxvdy4NCg0KWzIxMjU0Ljk4NDk4M10gUlRMODE2OF9ERUJVRzogU2xvdCAwLCBGdW5j
dGlvbiAyLCBSZWFkIFZlbmRvciBJRDogMHhmZmZmZmZmZg0KDQpUaGlzIGNvbmZpcm1zIHRoYXQg
dGhlc2UgZnVuY2l0b25zIGFyZSBwaHlzaWNhbGx5IGhpZGRlbiBmcm9tIHRoZSBQQ0kgYnVzLiBU
aGV5IGRvDQpub3QgcmVzcG9uZCB0byBzdGFuZGFyZCBQQ0kgY29uZmlndXJhdGlvbiBjeWNsZXMs
IHRoaXMgbWF5YmUgdGhlIHJlYXNvbiB3aHkgc3RhbmRhcmQNClBDSSBBUElzIGNhbm5vdCBiZSB1
c2VkIGhlcmUuDQpUaGVzZSBmdW5jdGlvbnMgYXJlIGltcG9ydGFudCBmb3IgcG93ZXIgc3RhdGUg
aXNzdWUuIFdoZW4gc3lzdGVtIHN1c3BlbmRzLCBsaW51eCBQQ0kNCmNvcmUgYXV0b21hdGljYWxs
eSBoYW5kbGVzIHRoZSBwb3dlciB0cmFuc2l0aW9uIGZvciB0aGUgdmlzaWJsZSBmdW5jdGlvbnMu
IEJ1dCBzaW5jZQ0KZnVuY3Rpb24gMi03IGlzIGludmlzaWJsZSwgdGhlIGtlcm5lbCBjYW5ub3Qg
bWFuYWdlIGl0LiBBcyBhIHJlc3VsdCwgd2UgaGF2ZSBubyBjaG9pY2UgYnV0DQp0byB1c2UgdGhl
IHZlbmRvci1zcGVjaWZpYyBpbmRpcmVjdCBhY2Nlc3MgbWVjaGFuaXNtKHZpYSBDU0lBUiByZWdp
c3RlcikuDQoNClRoYW5rcywNCkphdmVuIFh1DQoNCg==

