Return-Path: <netdev+bounces-294674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d0qKLKbfH2pIrgAAu9opvQ
	(envelope-from <netdev+bounces-294674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:02:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF5635790
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:02:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=pH+tbqaI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294674-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294674-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E018300AED7
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD62840800A;
	Wed,  3 Jun 2026 08:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C18403EA2;
	Wed,  3 Jun 2026 08:01:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473682; cv=none; b=JHVd44EfZuAxTqCiyK0zUqipst49gAcOAVq/mOrFSCYm4lPQjgjgNlpAep8pBHTMf0R4xiHdHO+JP+j7Lb4hXkcn8uLVemxWw4QxkNn6J0nXtyTh/c8f4fYrsogaEbdKWbJY/IfHDH3KwP7nTmtVFHn3AAtEd+QWszg/5z7A+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473682; c=relaxed/simple;
	bh=Cz5MJb6xvniBMFvl4ZHdADZPJrwkgz2f2V9m7W0UaKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TVtE0CL+BulrW3mQ4X7I1G4idTGyMh/9HWHEopZN83IcVECY9vp9CeQ7symcyi/lyGs1hkcPCMBOnFIbd5td0mVJ47+cWqt69SP1O57hvr9oLJ0eUJXuiEsgxIKFqft9XHJPamVKLmvv3Oa2umrflEaTCh3qSwQZiciwYbGCBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=pH+tbqaI; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65380hQB23670145, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780473644;
	bh=Cz5MJb6xvniBMFvl4ZHdADZPJrwkgz2f2V9m7W0UaKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pH+tbqaIAS9YsyzkNc4PUjDibbFU6kJegqaBbzK8ZOva/vQFdHQ+oGB8q2uEgjYoP
	 xcOatNrCJlXLRLqVRB/w6uc0OA6ABDx9HIKDMIh/nDYC+eeNHRuRdRYW43l9Ycj1Si
	 kdbcrq+H6evcJ9iL9G4HacjW26Iz5N0tuoLAt7VE9rM32pVsi0i0WsAF7e7vPMrxW+
	 yp9Bnd/kV03lYQEnNcHNHEYB+szIpZwz9hIKJ8Mcc3lC+Czrz11GjzPeRDMC+mwPCF
	 o59Dgjm1woCh/zQ/6RkDyLydBKJK2OI+p1WGq4Di8XsIf+00F83yJjAtg5ttQWEL/9
	 XQnaOt39DJteA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 65380hQB23670145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 16:00:44 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 16:00:43 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 3 Jun 2026 16:00:43 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
Thread-Topic: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
Thread-Index: AQHc8yZ/Mp8SA5nBjkWeW0kSVYYOAbYr622AgACJVcA=
Date: Wed, 3 Jun 2026 08:00:43 +0000
Message-ID: <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
 <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
In-Reply-To: <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3ACF5635790

Pk9uIDYvMy8yNiAwODo1OSwgamF2ZW4gd3JvdGU6DQo+PiBGcm9tOiBKYXZlbiBYdSA8amF2ZW5f
eHVAcmVhbHNpbC5jb20uY24+DQo+Pg0KPj4gQWRkIHN1cHBvcnQgZm9yIHJ0bDgxMTZhZiBkdW1t
eSBwaHkgZHJpdmVyLCBtYXRjaCBwaHkgaWQgYW5kIHJlYWQgbGluaw0KPj4gc3BlZWQgZnJvbSBN
SUlfQk1DUi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKYXZlbiBYdSA8amF2ZW5feHVAcmVhbHNp
bC5jb20uY24+DQo+DQo+Q2FuIHlvdSBlbGFib3JhdGUgbW9yZSBvbiB3aHkgdGhpcyBpcyBuZWVk
ZWQgPw0KPg0KPlRoZSBjb3ZlciBzYXlzIDoNCj4iDQo+SW4gdGhpcyBtb2RlLCB0aGUgZHJpdmVy
DQo+bmVlZHMgYSBkdW1teSBQSFkgSUQgc28gdGhhdCBwaHlsaWIgY2FuIGF0dGFjaCB0byBhIGR1
bW15IFJlYWx0ZWsgUEhZDQo+ZHJpdmVyLCB3aGlsZSBzZWxlY3RlZCBzdGFuZGFyZCBQSFkgcmVn
aXN0ZXJzIGFyZSBoYW5kbGVkIHRocm91Z2ggdGhlIFNlckRlcw0KPnJlZ2lzdGVyLg0KPiINCj4N
Cj5XaHkgY2FuJ3QgeW91IHVzZSB0aGUgU2VyRGVzIHJlZ2lzdGVycyBmb3IgeW91ciBQSFkgZHJp
dmVyID8gVGhlIHBocmFzZSBhYm92ZQ0KPnN1Z2dlc3RzIHRoYXQgdGhlICJTZXJEZXMgcmVnaXN0
ZXJzIiBoYXZlIHRoZSB0eXBpY2FsIEMyMi80NSBsYXlvdXQuIFRoZXJlIGFyZQ0KPlBIWXMgYW5k
IFBDU3Mgb3V0IHRoZXJlIHRoYXQgYXJlbid0IGFjY2Vzc2VkIHRocm91Z2ggcmVndWxhciBNRElP
IHdpdGgNCj5yZWdtYXAgYmVpbmcgdXNlZCB0byB0cmFuc2xhdGUgdGhlIG1kaW8gYWNjZXNzZXMg
ZG9uZSBieSBwaHlsaWIgaW50byB0aGUNCj5hY3R1YWwgcmVnaXN0ZXIgYWNjZXNzIG1ldGhvZCB1
c2VkLg0KPg0KPk1heGltZQ0KPg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KTWF5YmUgSSBz
aG91bGRuJ3QgY2FsbCBpdCBhICJkdW1teSIgUEhZLiBJdCBpcyBhY3R1YWxseSBhIHJlYWwsIGRl
ZGljYXRlZCBQSFkgZHJpdmVyIGZvciB0aGUgUlRMODExNmFmIG9wZXJhdGluZyBpbiBGaWJlci9T
ZXJEZXMgbW9kZS4gVGhlIHJlYXNvbiB3ZSBjYW5ub3QgdXNlIHRoZSBzdGFuZGFyZCBnZW5lcmlj
IFBIWSBkcml2ZXIgaXMgdGhhdCBoYXJkd2FyZSBkb2VzIG5vdCBjb3JyZWN0bHkgcG9wdWxhdGUg
dGhlIHN0YW5kYXJkIEdpZ2FiaXQgU3RhdHVzIFJlZ2lzdGVyIChNSUlfU1RBVDEwMDAsIFJlZyAw
eDBhKS4gDQpIZXJlIGlzIGEgc25pcHBldCBvZiBvdXIgTURJTyByZWFkIHRyYWNlIGR1cmluZyBs
aW5rIHVwOg0KcjgxNjkgMDAwMDo4NTowMC4xOiBNRElPIHJlYWQ6IHRwLT5vY3BfYmFzZT0weGE0
MDAsIHJlZz0weDBhLCB2YWx1ZT0weDAwMDANCnI4MTY5IDAwMDA6ODU6MDAuMTogTURJTyByZWFk
OiB0cC0+b2NwX2Jhc2U9MHhhNDAwLCByZWc9MHgwNSwgdmFsdWU9MHg0MWEwDQpSZWcgMHgwYSBy
ZXR1cm5zIDB4MDAwMCwgdGhlIHBoeWxpYiBnZW5lcmljIHN0YXR1cyBwYXJzZXIgZmFpbHMgdG8g
cmVzb2x2ZSB0aGUgMTAwME1icHMgbGluaywgY2F1c2luZyB0aGUgZHJpdmVyIHRvIGluY29ycmVj
dGx5IGZhbGwgYmFjayB0byBhIGZvcmNlZCAxME1icHMsIGV2ZW4gdGhvdWdoIHRoZSBwaHlzaWNh
bCBsaW5rIGlzIGFjdHVhbGx5IFVQIGF0IDEwMDBNYnBzLiBUaGVyZWZvcmUsIHdlIG5lZWQgdG8g
cmVnaXN0ZXIgYSBjdXN0b20gUEhZIGRyaXZlciB0byBwcm92aWRlIGEgc3BlY2lmaWMgLnJlYWRf
c3RhdHVzIGNhbGxiYWNrIHRoYXQgcGFyc2VzIE1JSV9CTUNSIGluc3RlYWQgb2YgcmVseWluZyBv
biBNSUlfU1RBVDEwMDAuDQoNCkJScywNCkphdmVuDQoNCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbmV0
L3BoeS9yZWFsdGVrL3JlYWx0ZWtfbWFpbi5jIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+ICBpbmNsdWRlL25ldC9waHkvcmVhbHRla19waHkuaCAgICAgICAgICB8ICAxICsNCj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMNCj4+IGIvZHJpdmVycy9uZXQv
cGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMNCj4+IGluZGV4IDI3MjY4ODExZjU2NC4uOWI5Mjgy
OGM0OWQ5IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19t
YWluLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrL3JlYWx0ZWtfbWFpbi5jDQo+
PiBAQCAtMjY1OSw2ICsyNjU5LDQ3IEBAIHN0YXRpYyBpbnQgcnRsZ2VuX3NmcF9nZXRfZmVhdHVy
ZXMoc3RydWN0DQo+cGh5X2RldmljZSAqcGh5ZGV2KQ0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiAg
fQ0KPj4NCj4+ICtzdGF0aWMgaW50IHJ0bDgxMTZhZl9zZnBfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBw
aHlfZGV2aWNlICpwaHlkZXYpIHsNCj4+ICsgICAgIGxpbmttb2RlX3NldF9iaXQoRVRIVE9PTF9M
SU5LX01PREVfMTAwMGJhc2VUX0Z1bGxfQklULA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICBw
aHlkZXYtPnN1cHBvcnRlZCk7DQo+PiArDQo+PiArICAgICBwaHlkZXYtPnNwZWVkID0gU1BFRURf
MTAwMDsNCj4+ICsgICAgIHBoeWRldi0+ZHVwbGV4ID0gRFVQTEVYX0ZVTEw7DQo+PiArDQo+PiAr
ICAgICBwaHlkZXYtPnBvcnQgPSBQT1JUX0ZJQlJFOw0KPj4gKw0KPj4gKyAgICAgcmV0dXJuIDA7
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgcnRsODExNmFmX3NmcF9yZWFkX3N0YXR1cyhz
dHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KSB7DQo+PiArICAgICBpbnQgdmFsLCBlcnI7DQo+PiAr
DQo+PiArICAgICBlcnIgPSBnZW5waHlfdXBkYXRlX2xpbmsocGh5ZGV2KTsNCj4+ICsgICAgIGlm
IChlcnIpDQo+PiArICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+PiArDQo+PiArICAgICBpZiAo
IXBoeWRldi0+bGluaykNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiArDQo+PiArICAg
ICB2YWwgPSBwaHlfcmVhZChwaHlkZXYsIE1JSV9CTUNSKTsNCj4+ICsgICAgIGlmICh2YWwgPCAw
KQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gdmFsOw0KPj4gKw0KPj4gKyAgICAgaWYgKHZhbCAm
IEJNQ1JfU1BFRUQxMDAwKQ0KPj4gKyAgICAgICAgICAgICBwaHlkZXYtPnNwZWVkID0gU1BFRURf
MTAwMDsNCj4+ICsgICAgIGVsc2UgaWYgKHZhbCAmIEJNQ1JfU1BFRUQxMDApDQo+PiArICAgICAg
ICAgICAgIHBoeWRldi0+c3BlZWQgPSBTUEVFRF8xMDA7DQo+PiArDQo+PiArICAgICBpZiAodmFs
ICYgQk1DUl9GVUxMRFBMWCkNCj4+ICsgICAgICAgICAgICAgcGh5ZGV2LT5kdXBsZXggPSBEVVBM
RVhfRlVMTDsNCj4+ICsgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAgcGh5ZGV2LT5kdXBsZXgg
PSBEVVBMRVhfSEFMRjsNCj4+ICsNCj4+ICsgICAgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+
ICBzdGF0aWMgaW50IHJ0bGdlbl9zZnBfcmVhZF9zdGF0dXMoc3RydWN0IHBoeV9kZXZpY2UgKnBo
eWRldikgIHsNCj4+ICAgICAgIGludCB2YWwsIGVycjsNCj4+IEBAIC0yOTQ3LDYgKzI5ODgsMTkg
QEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIHJlYWx0ZWtfZHJ2c1tdID0gew0KPj4gICAgICAg
ICAgICAgICAud3JpdGVfcGFnZSAgICAgPSBydGw4MjF4X3dyaXRlX3BhZ2UsDQo+PiAgICAgICAg
ICAgICAgIC5yZWFkX21tZCAgICAgICA9IHJ0bDgyMnhfcmVhZF9tbWQsDQo+PiAgICAgICAgICAg
ICAgIC53cml0ZV9tbWQgICAgICA9IHJ0bDgyMnhfd3JpdGVfbW1kLA0KPj4gKyAgICAgfSwgew0K
Pj4gKyAgICAgICAgICAgICBQSFlfSURfTUFUQ0hfRVhBQ1QoUEhZX0lEX1JUTDgxMTZBRl9EVU1N
WSksDQo+PiArICAgICAgICAgICAgIC5uYW1lICAgICAgICAgICA9ICJSVEw4MTE2YWYgUEhZIE1v
ZGUiLA0KPj4gKyAgICAgICAgICAgICAuZmxhZ3MgICAgICAgICAgPSBQSFlfSVNfSU5URVJOQUws
DQo+PiArICAgICAgICAgICAgIC5nZXRfZmVhdHVyZXMgICA9IHJ0bDgxMTZhZl9zZnBfZ2V0X2Zl
YXR1cmVzLA0KPj4gKyAgICAgICAgICAgICAuY29uZmlnX2FuZWcgICAgPSBydGxnZW5fc2ZwX2Nv
bmZpZ19hbmVnLA0KPj4gKyAgICAgICAgICAgICAucmVhZF9zdGF0dXMgICAgPSBydGw4MTE2YWZf
c2ZwX3JlYWRfc3RhdHVzLA0KPj4gKyAgICAgICAgICAgICAuc3VzcGVuZCAgICAgICAgPSBnZW5w
aHlfc3VzcGVuZCwNCj4+ICsgICAgICAgICAgICAgLnJlc3VtZSAgICAgICAgID0gcnRsZ2VuX3Jl
c3VtZSwNCj4+ICsgICAgICAgICAgICAgLnJlYWRfcGFnZSAgICAgID0gcnRsODIxeF9yZWFkX3Bh
Z2UsDQo+PiArICAgICAgICAgICAgIC53cml0ZV9wYWdlICAgICA9IHJ0bDgyMXhfd3JpdGVfcGFn
ZSwNCj4+ICsgICAgICAgICAgICAgLnJlYWRfbW1kICAgICAgID0gcnRsODIyeF9yZWFkX21tZCwN
Cj4+ICsgICAgICAgICAgICAgLndyaXRlX21tZCAgICAgID0gcnRsODIyeF93cml0ZV9tbWQsDQo+
PiAgICAgICB9LCB7DQo+PiAgICAgICAgICAgICAgIFBIWV9JRF9NQVRDSF9FWEFDVCgweDAwMWNj
YWQwKSwNCj4+ICAgICAgICAgICAgICAgLm5hbWUgICAgICAgICAgID0gIlJUTDgyMjQgMi41R2Jw
cyBQSFkiLA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3BoeS9yZWFsdGVrX3BoeS5oDQo+
PiBiL2luY2x1ZGUvbmV0L3BoeS9yZWFsdGVrX3BoeS5oIGluZGV4IGQ2ODNiYzFiMDY1OS4uY2Jm
OTFhZjBlYWQ2DQo+PiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbmV0L3BoeS9yZWFsdGVrX3Bo
eS5oDQo+PiArKysgYi9pbmNsdWRlL25ldC9waHkvcmVhbHRla19waHkuaA0KPj4gQEAgLTMsNSAr
Myw2IEBADQo+PiAgI2RlZmluZSBfUkVBTFRFS19QSFlfSA0KPj4NCj4+ICAjZGVmaW5lICAgICAg
UEhZX0lEX1JUTF9EVU1NWV9TRlAgICAgMHgwMDFjY2JmZg0KPj4gKyNkZWZpbmUgUEhZX0lEX1JU
TDgxMTZBRl9EVU1NWSAgMHgwMDFjY2JmZQ0KPj4NCj4+ICAjZW5kaWYgLyogX1JFQUxURUtfUEhZ
X0ggKi8NCg0K

