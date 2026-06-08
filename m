Return-Path: <netdev+bounces-296399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cXLZOkNyJmqLWgIAu9opvQ
	(envelope-from <netdev+bounces-296399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB14653A44
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:41:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=O2eNdwtr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296399-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE4203006005
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCCE393DE8;
	Mon,  8 Jun 2026 07:41:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B438F945;
	Mon,  8 Jun 2026 07:41:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904500; cv=none; b=kazBpmmeiro5eK9AdLEIkxAlsLcCl0K2ONVwKRbLOLgGfW4VLjSRhpoaqU5DRjJmnY6UVpJESVWROOYmCV4ENFUc0sNPPiKY3VVvh3QkBcwTAz2Jc0HKze5V0sol3FUd3L00GiqekgaLfxj5w3s4QgqsJsk7eHxbFsXbyOd6XQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904500; c=relaxed/simple;
	bh=20YN+IyEKTpIVjaXhWMeh3R5DFwHUNcFhGJmtM1U7G4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u3fvurV14idOA3zPXIK+Ij5/JrUnTdc0+tQGlgU1bSWcpAs3TwCROf4on5Rp41ofFa4ldiNPHPZivHWG4Dy7YE1W4CUOFBmvWiHg7ZBc2YdS6WVjfNkgZ9xLH2C2ZgsXIF8J/CwOLMpA+GW+jDyXAMJmn4dsDjSGMvFhokUgNu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=O2eNdwtr; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6587evnmF3542208, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780904458;
	bh=20YN+IyEKTpIVjaXhWMeh3R5DFwHUNcFhGJmtM1U7G4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=O2eNdwtr0V8utDJov4a574uGPDf7zQRpjHaQHrMZex2Rm0+vx2DWC0sgNS+tEppD4
	 bC15iNhGPXqigFSiw3tqzj2Nbgg2nG/M38Y7pXbmX2urSHsWXo/gkxATwW2SV7yae6
	 Uii80dmw2MnvT4Q7SO7HjtA2IFDVMHbYhr1SR+b/+7barxGRGZ/18cir7Mfr1zWTyt
	 V+y2d61lHMGbBIgF0Hj8pue7FS8+xz/Wt2rqKUhaIbxo0GUVR0IaUuKVnVu8g41QX6
	 ZHW7iEZfJ35J0cGAkN36ZtFCV+tCbgokMB1FkBIB1ZzWIw3gubB+CIHqb+01G99zC4
	 kSsiDsGdhH7vQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6587evnmF3542208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jun 2026 15:40:58 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Jun 2026 15:40:57 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 8 Jun 2026 15:40:57 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 2/6] r8169: add support for phylink
Thread-Topic: [PATCH net-next v1 2/6] r8169: add support for phylink
Thread-Index: AQHc9NeKCblqIPzpp0uk+oBE0WL0ZbYwx1iAgAN48TA=
Date: Mon, 8 Jun 2026 07:40:57 +0000
Message-ID: <e8ff0b30c02e4bc996380c4bb93225fa@realsil.com.cn>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-3-javen_xu@realsil.com.cn>
 <75cee79b-78d5-4a64-bbfe-8ba89f4cfb7d@bootlin.com>
In-Reply-To: <75cee79b-78d5-4a64-bbfe-8ba89f4cfb7d@bootlin.com>
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
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296399-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEB14653A44

Pg0KPkhpLA0KPg0KPk9uIDYvNS8yNiAxMjozOSwgamF2ZW4gd3JvdGU6DQo+PiBGcm9tOiBKYXZl
biBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+Pg0KPj4gVHJhbnNmZXIgb2xkIGZyYW1l
d29yayB0byBwaHlsaW5rLiBQaHlsaW5rIGNhbiBzdXBwb3J0IGZpYmVyIG1vZGUgY2FyZA0KPj4g
d2hpY2ggY2FuIG5vdCBnZXQgbGluayBzdGF0dXMgb3IgbGluayBzcGVlZCBmcm9tIHN0YW5kYXJk
IHBoeSByZWdpc3RlcnMuDQo+DQo+VGhpcyBpcyBhIGdvb2Qgc3RhcnQsIGJ1dCB5b3UgbmVlZCB0
byBnbyBkZWVwZXIgdGhhbiB0aGF0LiBMb29raW5nIGF0IHRoZSBlbmQNCj5yZXN1bHQsIHlvdSBz
dGlsbCBhY2Nlc3MgdHAtPnBoeWRldiBhIGxvdCBpbiB0aGlzIGRyaXZlciA6DQo+DQo+TG9va2lu
ZyBhdCByODE2OV9tZGlvX3JlZ2lzdGVyKCkgZm9yIGV4YW1wbGUgOg0KPg0KPiAtPiBkb24ndCBj
b25maWd1cmUgdGhlIFBIWSBlZWUgc3VwcG9ydCB3aXRoIHBoeV9zdXBwb3J0X2VlZSgpIGFuZA0K
PiAgICBwaHlfZGlzYWJsZV9lZWVfbW9kZSgpLCBsZXQgcGh5bGluayB0byB0aGF0IGZvciB5b3UN
Cj4NCj5BbGwgb3ZlciB0aGUgZHJpdmVyLCB0aGVyZSdzIHN0aWxsIGEgbG90IG9mIG1hbnVhbCBj
b250cm9sIG9mIHRoZSBQSFkgd2l0aCBwaHlsaWIsDQo+bG9vayBhdCB0aGUgY2FsbHMgZm9yIHBo
eV9pbml0X2h3KCksIHBoeV9yZXN1bWUoKSwgYW5kIHNvIG9uLCB5b3UgbmVlZCB0bw0KPmFzc3Vt
ZSB0aGF0IHdpdGggcGh5bGluayB5b3UgbWF5IG5vdCBoYXZlIGEgUEhZLg0KPg0KPlRoZSBwcm9i
bGVtIHRoZW4gaXMgdGhhdCB0aGVyZSBhcmUgcGxhY2VzIGluIHRoZSBjb2RlIHdoZXJlIFBIWSBy
ZWdpc3RlcnMgYXJlDQo+ZGlyZWN0bHkgYWNjZXNzZWQgOg0KPg0KPnN0YXRpYyB2b2lkIHJ0bDgx
NjlfaW5pdF9waHkoc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApIHsgWy4uLl0NCj4NCj4gICAg
ICAgIGlmICh0cC0+bWFjX3ZlcnNpb24gPT0gUlRMX0dJR0FfTUFDX1ZFUl8wNSAmJg0KPiAgICAg
ICAgICAgIHRwLT5wY2lfZGV2LT5zdWJzeXN0ZW1fdmVuZG9yID09IFBDSV9WRU5ET1JfSURfR0lH
QUJZVEUgJiYNCj4gICAgICAgICAgICB0cC0+cGNpX2Rldi0+c3Vic3lzdGVtX2RldmljZSA9PSAw
eGUwMDApDQo+ICAgICAgICAgICAgICAgIHBoeV93cml0ZV9wYWdlZCh0cC0+cGh5ZGV2LCAweDAw
MDEsIDB4MTAsIDB4ZjAxYik7IFsuLi5dDQo+ICAgICAgICBnZW5waHlfc29mdF9yZXNldCh0cC0+
cGh5ZGV2KTsNCj59DQo+DQo+SW4gdGhlIGVuZCwgeW91IHNob3VsZG4ndCBldmVuIG5lZWQgdG8g
dXNlIHRwLT5waHlkZXYgYXQgYWxsLg0KPg0KPkl0J3MgaGFyZCB0byBrbm93IHdoYXQgdGhpcyBp
cyBhbGwgYWJvdXQsIGJ1dCBpdCBzZWVtcyBsaWtlIHNvbWV0aGluZyBhIFBIWQ0KPmRyaXZlciBz
aG91bGQgaGF2ZSB0byBkbywgbm90IGEgTUFDIGRyaXZlciA6KA0KPg0KPkFsc28sIEknZCBtZXJn
ZSB0aGUgbmV4dCBjb21taXQgd2l0aCB0aGlzIG9uZSB0byBoYXZlIG9uZSBzaW5nbGUgY29tbWl0
IGRvaW5nDQo+dGhlIHBoeWxpbmsgY29udmVyc2lvbi4NCj4NCj5NYXhpbWUNCj4NCkhpIE1heGlt
ZSwNCg0KSSBoYXZlIG9uZSBxdWVzdGlvbiBhYm91dCB0aGUgZXhpc3RpbmcgbGluay1jaGFuZ2Ug
aW50ZXJydXB0IG1vZGVsLg0KDQpGb3IgbW9zdCByODE2OSBjaGlwcywgdGhlIFBIWSBleGlzdHMg
YW5kIHRoZSBjdXJyZW50IGRyaXZlciB1c2VzIHRoZSBNQUMgTGlua0NoZyBpbnRlcnJ1cHQgdG8g
bm90aWZ5IHBoeWxpYjoNCiAgICAgICAgaWYgKHN0YXR1cyAmIExpbmtDaGcpDQogICAgICAgICAg
ICAgICAgcGh5X21hY19pbnRlcnJ1cHQodHAtPnBoeWRldik7DQoNCkFmdGVyIGNvbnZlcnRpbmcg
dGhlIGRyaXZlciB0byBwaHlsaW5rLCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIE1BQyBk
cml2ZXIgc2hvdWxkIGF2b2lkIGtlZXBpbmcgYSBwcml2YXRlIHRwLT5waHlkZXYgcG9pbnRlci4g
VGhlIFBIWSBjYW4gc3RpbGwgYmUgZm91bmQgZHVyaW5nIHNldHVwIGFuZCBwYXNzZWQgdG8gcGh5
bGlua19jb25uZWN0X3BoeSgpLCBidXQgdGhlbiBJIGFtIG5vdCBzdXJlIGhvdyB0aGUgTUFDLXJv
dXRlZCBQSFkgaW50ZXJydXB0IHNob3VsZCBiZSBoYW5kbGVkLg0KDQpXb3VsZCBzd2l0Y2hpbmcg
dGhlIGludGVybmFsIFBIWSB0byBQSFlfUE9MTCBiZSBhY2NlcHRhYmxlICwgb3Igd291bGQgeW91
IHByZWZlciB0byBrZWVwIHRoZSBleGlzdGluZyBpbnRlcnJ1cHQtZHJpdmVuIGJlaGF2aW91cj8g
SWYgdGhlIGxhdHRlciwgd2hhdCB3b3VsZCBiZSB0aGUgcHJlZmVycmVkIHdheSB0byBub3RpZnkg
cGh5bGliIHdpdGhvdXQgc3RvcmluZyB0cC0+cGh5ZGV2IGluIHRoZSBkcml2ZXI/DQoNCkkgYWxz
byBoYXZlIGEgcmVsYXRlZCBxdWVzdGlvbiBhYm91dCB0aGUgZXhpc3RpbmcgZmlybXdhcmUgaGFu
ZGxpbmcgYW5kIHN3X2NudF8xbXNfaW5pIGxvZ2ljLiBTb21lIG9mIHRoaXMgY29kZSB0b3VjaGVz
IE1BQyBNTUlPIHJlZ2lzdGVycywgc28gaXQgZG9lcyBub3Qgc2VlbSBzdWl0YWJsZSB0byBtb3Zl
IGl0IGVudGlyZWx5IGludG8gdGhlIFJlYWx0ZWsgUEhZIGRyaXZlci4gVGhlIGN1cnJlbnQgY29k
ZSB1c2VzIHRwLT5waHlkZXYgaW4gdGhpcyBhcmVhLg0KDQpXaGF0IHdvdWxkIGJlIHRoZSBwcmVm
ZXJyZWQgcGh5bGluay1jb21wYXRpYmxlIHdheSB0byBoYW5kbGUgdGhpcz8gU2hvdWxkIHRoZSBk
cml2ZXIgc3RpbGwga2VlcCB0aGUgdHAtPnBoeWRldiwgb3IgaXMgdGhlcmUgYW5vdGhlciByZWNv
bW1lbmRlZCBhcHByb2FjaD8NCg0KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2
L2I1NGI1ZjNhNjcwMzQ5OGZiYzE3ZTY0NTQ4NTUwYmEwQHJlYWxzaWwuY29tLmNuLw0KDQpUaGFu
a3MsDQpCUnMsDQpKYXZlbg0KDQoNCg==

