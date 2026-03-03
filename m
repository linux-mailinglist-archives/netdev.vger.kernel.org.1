Return-Path: <netdev+bounces-263086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OmnDEKnpmkNSgAAu9opvQ
	(envelope-from <netdev+bounces-263086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:17:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8CC1EBB59
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D591302E7C3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336FF374E69;
	Tue,  3 Mar 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="MA9f2hRi"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0F30B517;
	Tue,  3 Mar 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529471; cv=none; b=D992QUS7r7VtzrSecUYZ6+e6/69IAxcaIcybjRWm9CIzR1H6atwSpK21pQIkJB9/YON1o3ojRNX4s40bIcL6R6UVv/aGHPsbIDX4f8usBnzdTIrP+lZ9Cn8s/VY1epyYk+Z5od68Io7k6/1y/MRQ2ektpaDGQrkOIDrxFKKHNII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529471; c=relaxed/simple;
	bh=lfTkenlGujUiq7cUB1nC/ObBWDS72H2J3zBdQhNM9wQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6cGYqHN2CEZLiYipEudPGuE3I/10thtYiC3Y38O3jBE6ZKzZqr9jBhXXfHvhLI2Ej07gRw95WHci3QMmAgml3vMtxqr4NPjR5nG8q+JdkFaSUj4pkg+bKduE5q/3HO4+OSQTFba6OW1Pgkl3xkXw55bJh7tUEGF+1VKdXA3ZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=MA9f2hRi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6239HERI0856084, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1772529435;
	bh=lfTkenlGujUiq7cUB1nC/ObBWDS72H2J3zBdQhNM9wQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MA9f2hRivN9AIIIxruPOKBMSZjTRht6WmiEza9VGX3q1xih9BJUN2rm1V6SpzmibL
	 3pVEHVLwBD24lmz7VYDyQzzpUkzd2ZAGmZRTiphdsr16wHrMfjcNodRvZ1uXVf3NWE
	 DHsobmHQnxRAsbjGhtHAsp2RlMee52cFMsCDNKq52nLQCkUHKcGSqBAhXJ2/uJhl+6
	 V7u9zgTPLsDj3gMDJx9jtYKQ1a5tR/Jw3emdDtpjEZ1meHub+z4kQfyog1RMrXvvca
	 JydizFd/stk04UTptmYkZBEXqxq26YjUiKhHAzm0nBxMF33F2HDeKb1Zxod7fdOpgp
	 MLzVDZYoedEsA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6239HERI0856084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Mar 2026 17:17:14 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 3 Mar 2026 17:17:14 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.1748.039; Tue,
 3 Mar 2026 17:17:14 +0800
From: =?gb2312?B?0O2/oc6w?= <javen_xu@realsil.com.cn>
To: Paolo Abeni <pabeni@redhat.com>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [net-next,v5] r8169: add support for RTL8125cp
Thread-Topic: [net-next,v5] r8169: add support for RTL8125cp
Thread-Index: AQHcpxPZAlERX4Um2UO4eOSYgRMdRLWcjlgQ
Date: Tue, 3 Mar 2026 09:17:14 +0000
Message-ID: <ce89b9957d3446c08cc20db5ae00638e@realsil.com.cn>
References: <20260224025335.298-1-javen_xu@realsil.com.cn>
 <20260226113350.119833-1-pabeni@redhat.com>
In-Reply-To: <20260226113350.119833-1-pabeni@redhat.com>
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
X-Rspamd-Queue-Id: 6F8CC1EBB59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263086-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,lunn.ch,vger.kernel.org,google.com,gmail.com,realtek.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realsil.com.cn:dkim,realsil.com.cn:mid,lunn.ch:email]
X-Rspamd-Action: no action

PkV4dGVybmFsIG1haWwgOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIHRoZSBv
cmdhbml6YXRpb24uIERvIG5vdA0KPnJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPmtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZS4NCj4NCj4NCj4NCj5UaGlzIGlzIGFuIEFJLWdlbmVyYXRlZCByZXZpZXcgb2Yg
eW91ciBwYXRjaC4gVGhlIGh1bWFuIHNlbmRpbmcgdGhpcyBlbWFpbA0KPmhhcyBjb25zaWRlcmVk
IHRoZSBBSSByZXZpZXcgdmFsaWQsIG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4NCj4NCj5Gb3IgbG9j
YWwgcmVwcm9kdWN0aW9uIHN0ZXBzIHNlZSBodHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRl
di9haS1sb2NhbC5odG1sDQo+LS0tDQo+cjgxNjk6IGFkZCBzdXBwb3J0IGZvciBSVEw4MTI1Y3AN
Cj4NCj5UaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgY2hpcCBSVEw4MTI1Y3Agd2l0aCBYSUQg
MHg3MDgsIGFwcGx5aW5nIGRpZmZlcmVudA0KPmZpcm13YXJlIChydGw4MTI1Y3AtMS5mdykgYW5k
IGEgZGVkaWNhdGVkIFBIWSBjb25maWd1cmF0aW9uIGZ1bmN0aW9uLg0KPg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjkuaA0KPj4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5LmgNCj4+IGluZGV4IGFlZDRjZjg1MjA5MS4uMGI5YzFk
NGViNDhiIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2
OS5oDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5LmgNCj4+IEBA
IC02OCw2ICs2OCw3IEBAIGVudW0gbWFjX3ZlcnNpb24gew0KPj4gICAgICAgUlRMX0dJR0FfTUFD
X1ZFUl82MSwNCj4+ICAgICAgIFJUTF9HSUdBX01BQ19WRVJfNjMsDQo+PiAgICAgICBSVExfR0lH
QV9NQUNfVkVSXzY0LA0KPj4gKyAgICAgUlRMX0dJR0FfTUFDX1ZFUl82NSwNCj4+ICAgICAgIFJU
TF9HSUdBX01BQ19WRVJfNjYsDQo+PiAgICAgICBSVExfR0lHQV9NQUNfVkVSXzcwLA0KPj4gICAg
ICAgUlRMX0dJR0FfTUFDX1ZFUl84MCwNCj4NCj5bIC4uLiBdDQo+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4+IGluZGV4IDJmN2Q5ODA5YzM3My4u
ZDA0MGYyMDc0ZGI2IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRl
ay9yODE2OV9tYWluLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgx
NjlfbWFpbi5jDQo+DQo+WyAuLi4gXQ0KPg0KPj4gQEAgLTQwMjEsNiArNDAyNiw3IEBAIHN0YXRp
YyB2b2lkIHJ0bF9od19jb25maWcoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApDQo+PiAgICAg
ICAgICAgICAgIFtSVExfR0lHQV9NQUNfVkVSXzYxXSA9IHJ0bF9od19zdGFydF84MTI1YV8yLA0K
Pj4gICAgICAgICAgICAgICBbUlRMX0dJR0FfTUFDX1ZFUl82M10gPSBydGxfaHdfc3RhcnRfODEy
NWIsDQo+PiAgICAgICAgICAgICAgIFtSVExfR0lHQV9NQUNfVkVSXzY0XSA9IHJ0bF9od19zdGFy
dF84MTI1ZCwNCj4+ICsgICAgICAgICAgICAgW1JUTF9HSUdBX01BQ19WRVJfNjVdID0gcnRsX2h3
X3N0YXJ0XzgxMjVkLA0KPj4gICAgICAgICAgICAgICBbUlRMX0dJR0FfTUFDX1ZFUl82Nl0gPSBy
dGxfaHdfc3RhcnRfODEyNWQsDQo+PiAgICAgICAgICAgICAgIFtSVExfR0lHQV9NQUNfVkVSXzcw
XSA9IHJ0bF9od19zdGFydF84MTI2YSwNCj4+ICAgICAgICAgICAgICAgW1JUTF9HSUdBX01BQ19W
RVJfODBdID0gcnRsX2h3X3N0YXJ0XzgxMjdhLA0KPg0KPlJUTF9HSUdBX01BQ19WRVJfNjUgKFJU
TDgxMjVDUCkgbWFwcyB0byBydGxfaHdfc3RhcnRfODEyNWQsIHdoaWNoIGlzDQo+YWxzbyB1c2Vk
IGJ5IFZFUl82NCBhbmQgVkVSXzY2LiBIb3dldmVyLCB0aGVzZSB2ZXJzaW9ucyBuZWVkIHNwZWNp
YWwNCj5oYW5kbGluZyBpbg0KPnJ0bF9od19zdGFydF84MTI1KCk6DQo+DQo+c3RhdGljIHZvaWQg
cnRsX2h3X3N0YXJ0XzgxMjUoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApIHsNCj4gICAgICAg
IC4uLg0KPiAgICAgICAgc3dpdGNoICh0cC0+bWFjX3ZlcnNpb24pIHsNCj4gICAgICAgIGNhc2Ug
UlRMX0dJR0FfTUFDX1ZFUl82MToNCj4gICAgICAgIGNhc2UgUlRMX0dJR0FfTUFDX1ZFUl82NDoN
Cj4gICAgICAgIGNhc2UgUlRMX0dJR0FfTUFDX1ZFUl82NjoNCj4gICAgICAgIGNhc2UgUlRMX0dJ
R0FfTUFDX1ZFUl84MDoNCj4gICAgICAgICAgICAgICAgZm9yIChpID0gMHhhMDA7IGkgPCAweGIw
MDsgaSArPSA0KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgIFJUTF9XMzIodHAsIGksIDApOw0K
PiAgICAgICAgICAgICAgICBpZiAodHAtPm1hY192ZXJzaW9uID09IFJUTF9HSUdBX01BQ19WRVJf
ODApDQo+ICAgICAgICAgICAgICAgICAgICAgICAgUlRMX1cxNih0cCwgSU5UX0NGRzFfODEyNSwg
MHgwMDAwKTsNCj4gICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICBkZWZhdWx0Og0KPiAg
ICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgIH0NCj4gICAgICAgIC4uLg0KPn0NCj4NCj5T
aG91bGQgUlRMX0dJR0FfTUFDX1ZFUl82NSBiZSBhZGRlZCB0byB0aGlzIGNhc2UgZ3JvdXA/IEJv
dGggVkVSXzY0DQo+YW5kIFZFUl82Niwgd2hpY2ggc2hhcmUgdGhlIHNhbWUgcnRsX2h3X3N0YXJ0
XzgxMjVkIGZ1bmN0aW9uIGFzIFZFUl82NSwNCj5hcmUgZXhwbGljaXRseSBsaXN0ZWQgaGVyZSB0
byBkaXNhYmxlIGludGVycnVwdCBjb2FsZXNjaW5nIChjbGVhcmluZyByZWdpc3RlcnMNCj4weGEw
MC0weGIwMCkuIFdpdGhvdXQgdGhpcywgdGhlIFJUTDgxMjVDUCBtYXkgb3BlcmF0ZSB3aXRoIHN0
YWxlIGludGVycnVwdA0KPmNvYWxlc2Npbmcgc2V0dGluZ3MsIHBvdGVudGlhbGx5IGNhdXNpbmcg
aW5jb3JyZWN0IGludGVycnVwdCBkZWxpdmVyeS4NCj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X3BoeV9jb25maWcuYw0KPj4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X3BoeV9jb25maWcuYw0KPj4gaW5kZXggMDMyZDlkMmNm
YTJhLi5mNzhjM2RkMzY0ODMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9y
ZWFsdGVrL3I4MTY5X3BoeV9jb25maWcuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
cmVhbHRlay9yODE2OV9waHlfY29uZmlnLmMNCj4+IEBAIC0xMTAyLDYgKzExMDIsMjcgQEAgc3Rh
dGljIHZvaWQgcnRsODEyNWRfaHdfcGh5X2NvbmZpZyhzdHJ1Y3QNCj5ydGw4MTY5X3ByaXZhdGUg
KnRwLA0KPj4gICAgICAgcnRsODEyNV9jb25maWdfZWVlX3BoeShwaHlkZXYpOw0KPj4gIH0NCj4+
DQo+PiArc3RhdGljIHZvaWQgcnRsODEyNWNwX2h3X3BoeV9jb25maWcoc3RydWN0IHJ0bDgxNjlf
cHJpdmF0ZSAqdHAsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHBoeV9kZXZpY2UgKnBoeWRldikgew0KPj4gKyAgICAgcjgxNjlfYXBwbHlfZmlybXdhcmUodHAp
Ow0KPj4gKyAgICAgcnRsODE2OGdfZW5hYmxlX2dwaHlfMTBtKHBoeWRldik7DQo+PiArDQo+PiAr
ICAgICBwaHlfbW9kaWZ5X3BhZ2VkKHBoeWRldiwgMHhhZDAsIDB4MTcsIDB4MDA3ZiwgMHgwMDBi
KTsNCj4+ICsgICAgIHBoeV9tb2RpZnlfcGFnZWQocGh5ZGV2LCAweGFkNywgMHgxNCwgMHgwMDAw
LCBCSVQoNCkpOw0KPj4gKyAgICAgcnRsODEyNV9waHlfcGFyYW0ocGh5ZGV2LCAweDgwN2YsIDB4
ZmYwMCwgMHg1MzAwKTsNCj4+ICsgICAgIHI4MTY4Z19waHlfcGFyYW0ocGh5ZGV2LCAweDgxYjgs
IDB4ZmZmZiwgMHgwMGI0KTsNCj4+ICsgICAgIHI4MTY4Z19waHlfcGFyYW0ocGh5ZGV2LCAweDgx
YmEsIDB4ZmZmZiwgMHgwMGU0KTsNCj4+ICsgICAgIHI4MTY4Z19waHlfcGFyYW0ocGh5ZGV2LCAw
eDgxYzUsIDB4ZmZmZiwgMHgwMTA0KTsNCj4+ICsgICAgIHI4MTY4Z19waHlfcGFyYW0ocGh5ZGV2
LCAweDgxZDAsIDB4ZmZmZiwgMHgwNTRkKTsNCj4+ICsgICAgIHBoeV9tb2RpZnlfcGFnZWQocGh5
ZGV2LCAweDBhNDMsIDB4MTAsIDB4MDAwMCwgMHgwMDAzKTsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXg0KPg0KPkFuZHJl
dyBMdW5uIHN1Z2dlc3RlZCBpbiB2NCByZXZpZXcgdGhhdCBtYWdpYyBiaXQgdmFsdWVzIHNob3Vs
ZCBiZSByZXBsYWNlZA0KPndpdGggbmFtZWQgY29uc3RhbnRzLiBUaGUgdmFsdWUgMHgwMDAzIHNl
dHMgYml0cyBmb3IgJ2xpbmsgc3BlZWQgMTBtIFBMTCBPRkYnDQo+KGJpdCAwKSBhbmQgJ0FMRFBT
IFBMTCBPRkYnIChiaXQgMSkuIFRoaXMgd291bGQgaW1wcm92ZSBjb2RlIHJlYWRhYmlsaXR5IGFu
ZA0KPm1haW50YWluYWJpbGl0eS4gQW5kcmV3IHN1Z2dlc3RlZCBkZWZpbmVzIGxpa2UNCj5SVEw4
MTI1Q1BfTElOS19TUEVFRF8xME1fUExMX09GRiBCSVQoMCksIFJUTDgxMjVDUF9BTERQU19QTExf
T0ZGDQo+QklUKDEpLCBldGMuDQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuIEkgd2lsbCBjb25z
aWRlciB0aGUgdHdvIHN1Z2dlc3Rpb25zIGFuZCByZXN1Ym1pdCBpdCBpbiB2Ni4NCg0KPg0KPlJl
ZmVyZW5jZTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzFhMzZiMDEzLWFlOWItNGQ1
MS04MjU5LQ0KPjkyNzI4NjQ0Y2VhYkBsdW5uLmNoLw0KPg0KPj4gKyAgICAgcGh5X21vZGlmeV9w
YWdlZChwaHlkZXYsIDB4MGE0NCwgMHgxMSwgMHgwMDAwLCBCSVQoNykpOw0KPj4gKw0KPj4gKyAg
ICAgcnRsODEyNV9sZWdhY3lfZm9yY2VfbW9kZShwaHlkZXYpOw0KPj4gKyAgICAgcnRsODE2OGdf
ZGlzYWJsZV9hbGRwcyhwaHlkZXYpOw0KPj4gKyAgICAgcnRsODEyNV9jb25maWdfZWVlX3BoeShw
aHlkZXYpOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgdm9pZCBydGw4MTI1YnBfaHdfcGh5X2Nv
bmZpZyhzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KSAgew0KPg0KPlsgLi4uIF0N
Cg0K

