Return-Path: <netdev+bounces-270942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A4RBVBWwmmGbwQAu9opvQ
	(envelope-from <netdev+bounces-270942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C24E3056E9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5D3A30A1EC8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFA3DCD87;
	Tue, 24 Mar 2026 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TO8pGJ7n"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367463DBD53;
	Tue, 24 Mar 2026 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343290; cv=none; b=s6CdO0lfxdZqsrwrYDc6o74kxErJXzeMYNKIqBbSzkuBkwL5chbyVGGJchPFJGR42GjUtPNpBEGHSYpY4uaoTXmzCsBIm/++tLGxWN5bL7CAE9mUJILFM92RNV2U2tu5SAvDAOsBA6bEI/LvBXm8ZmE6xytAwTLGsuZlGXb4Qqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343290; c=relaxed/simple;
	bh=mibbCjdrjU8yBoCWq5s5GbbgutcaVzJ27y9cMJs+vtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gg5ruT5nJ+tQ7OznhaUvfeQpaeW2rduma2nWXRDU8y0sGmlsZUU89kZ4GeHHWjCEtQjz6w9C8fwwwCO74oj+l1uL17TPrFz8GcHZ9eVUVji/LDw1lOf0I7U3P3pP9rfXFyLYfpezpszedjMmQgYmt8iMxN7aBpcjH9MBbM5MvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TO8pGJ7n; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 37B91A0C3F;
	Tue, 24 Mar 2026 10:07:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:from:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=mail; bh=mibbCjdrj
	U8yBoCWq5s5GbbgutcaVzJ27y9cMJs+vtM=; b=TO8pGJ7nl4URV6x4QgMMOWSCy
	O/ubs9x9LxRGzt4dpFVEl4i01f96Ak9jfEHdHnymD7RyOiaWWRSzptsXhs9WXlTa
	nPDHiuH/VTB5Eibxw0m+fsoJU6vg8kstAORw879i+frDU0aGkUTc1lFV5vNKmKwQ
	ESH78z0lMSKfbMYKqLyYypQcEU0iWBFKkhHvMsAgjn0xAJi1zbLFI/5v/w8rILK4
	UegBmYjBuUbvxmCGsHDeobuir6TKIcf5HB/k9+9JJdN1JfLVRp1p2hlhovFoVIel
	L6x0nC/78VP729fVhSVQoVt51yQm4Rp9ksKOHdH/XYXgO9pIuYC0tolvAM6B+Cgr
	VEk5scOaiyw36y+bnOLn9z1Gr0TvC7O5wnsVhEKSfBxdJQt97th9LzCjrwtns40n
	+/QJ/9HnsW1Jv1ofPcNwED8ZKtMZTqJXRP1mdFxNavr1TYYWovrWgcgXst95NtZ/
	JXSXaGOUrGTulJjpDs25cEzz1xcWMiGD7gsqEJfxtQzHTTq2eXhky0zgnDF36TQp
	AzhYbOAFgMKziuyg8hh4IgJLOIfWI+zJHJa9SllB2edUAB3leYaZoKxIx2kW3mcx
	L7ZwxYds0+fvV4zgOEPNRGNGTgwbFY4pm9sT+whEXTpBtEUOjg0zWtaSjAvMd/dQ
	VQnRovIjsdHmj0y7FE=
From: Buday Csaba <Buday.Csaba@prolan.hu>
To: Wei Fang <wei.fang@nxp.com>, Jakub Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, =?utf-8?B?QmVuY2UgQ3PDs2vDoXM=?=
	<bence98@sch.bme.hu>, Francesco Dolcini <francesco.dolcini@toradex.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: RE: [PATCH net v2 1/1] net: fec: fix the PTP periodic output
 sysfs interface
Thread-Topic: RE: [PATCH net v2 1/1] net: fec: fix the PTP periodic output
 sysfs interface
Thread-Index: AQHct7ljjxL82zOBtEWLVp6vDzHTHLW8CD0AgADB4gCAACPTgIAADbqAgAAvOwCAADBKAA==
Date: Tue, 24 Mar 2026 09:07:57 +0000
Message-ID: <983afd55-5007-4929-8fe5-396c46570977@prolan.hu>
References: <7012fbf90b844083d5fa7d764ed6372fe0288157.1773928309.git.buday.csaba@prolan.hu>
 <PAXPR04MB8510889775D757361CEAFA39884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20260323172842.7a62979d@kernel.org>
 <PAXPR04MB85106975EB34F6B1652953FC8848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20260323202603.2897abf4@kernel.org>
 <PAXPR04MB85102EBE72888699094C42EF8848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB85102EBE72888699094C42EF8848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A29676715506D766A
Content-Type: text/plain; charset="utf-8"
Content-ID: <1041B058A708F74B9E7928B600DD8C07@prolan.hu>
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
	DMARC_POLICY_ALLOW(-0.50)[prolan.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[prolan.hu:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270942-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,sch.bme.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Buday.Csaba@prolan.hu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[prolan.hu:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7C24E3056E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pj4+PiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHlvdSB0aGluayB0aGF0IHdlIHNob3VsZCBiZSBl
eHBvc2luZyA0IGNoYW5uZWxzDQo+Pj4+IHRvIHRoZSB1c2VyIHdoZW4gdGhleSBjYW4gb25seSB1
c2Ugb25lLiBBbmQgaGF2ZSB0aGUgdXNlciBndWVzcyB3aGljaA0KPj4+PiBvbmUgc2hvdWxkIGJl
IHByb2dyYW1tZWQuIFBsZWFzZSBleHBsYWluIChhbmQgQnVkYXkgd2lsbCBoYXZlIHRvIHVwZGF0
ZQ0KPj4+PiB0aGUgY29tbWl0IG1lc3NhZ2UpLCB0byBtZSB2MSBsb29rZWQgbGlrZSBhIG11Y2gg
YmV0dGVyIGZpeC4NCj4+Pg0KPj4+IEFzIEkgZXhwbGFpbmVkIGluIHYxLCBJIHRoaW5rIHRoZSAi
Y2hhbm5lbCBpbmRleCIgcGFyYW1ldGVyIG9mDQo+Pj4gIi9zeXMvY2xhc3MvcHRwL3B0cDxOPi9w
ZXJpb2QiIHJlZmVycyB0byB0aGUgaGFyZHdhcmUgY2hhbm5lbCBudW1iZXIsDQo+Pj4gcmF0aGVy
IHRoYW4gdGhlIHNvZnR3YXJlIG1hcHBpbmcgdG8gdGhlIGhhcmR3YXJlIGNoYW5uZWwuDQo+Pg0K
Pj4gQ2FuIHlvdSBjaXRlIGFueSBkb2N1bWVudGF0aW9uIG9yIGV4YW1wbGVzPw0KPiANCj4gVGhl
cmUgaXMgbm8gZG9jdW1lbnRhdGlvbiB0aGF0IGV4cGxpY2l0bHkgc3BlY2lmaWVzIHdoZXRoZXIg
aXQgbXVzdCBiZQ0KPiB0aGUgaGFyZHdhcmUgY2hhbm5lbCBvciB0aGUgc29mdHdhcmUtZGVmaW5l
ZCBjaGFubmVsLiBTbyB0aGlzIGxlYWRzDQo+IHRvIGRpZmZlcmVudCBwZW9wbGUgaGF2aW5nIGRp
ZmZlcmVudCB1bmRlcnN0YW5kaW5ncyBvZiBpdC4NCj4gDQoNCldoYXQgYWJvdXQgdXBkYXRpbmcg
dGhlIGRvY3VtZW50YXRpb24gZmlyc3Q/DQpMaWtlOg0KLS0tIGEvRG9jdW1lbnRhdGlvbi9BQkkv
dGVzdGluZy9zeXNmcy1wdHANCisrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMt
cHRwDQpAQCAtNTksNyArNTksOCBAQCBEYXRlOiAgICAgICAgIFNlcHRlbWJlciAyMDEwDQogIENv
bnRhY3Q6ICAgICAgIFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29tPg0K
ICBEZXNjcmlwdGlvbjoNCiAgICAgICAgICAgICAgICAgVGhpcyBmaWxlIGNvbnRhaW5zIHRoZSBu
dW1iZXIgb2YgcHJvZ3JhbW1hYmxlIHBlcmlvZGljDQotICAgICAgICAgICAgICAgb3V0cHV0IGNo
YW5uZWxzIG9mZmVyZWQgYnkgdGhlIFBUUCBoYXJkd2FyZSBjbG9jay4NCisgICAgICAgICAgICAg
ICBvdXRwdXQgY2hhbm5lbHMgb2ZmZXJlZCBieSB0aGUgUFRQIGhhcmR3YXJlIGNsb2NrLCBhbmQN
CisgICAgICAgICAgICAgICBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4NCg0KICBXaGF0OiAgICAg
ICAgICAvc3lzL2NsYXNzL3B0cC9wdHA8Tj4vbl9waW5zDQogIERhdGU6ICAgICAgICAgIE1hcmNo
IDIwMTQNCg0KU2FtZSBmb3IgdGhlIHBlcmlvZC4NCg0KPj4gV2hhdCB3b3VsZCBiZSB0aGUgYmVu
ZWZpdCBvZiBleHBvc2luZyB0aGUgSUQgd2l0aGluIHRoZSBNQUMgSVAgKG5vdA0KPj4gZXZlbiB0
aGUgYm9hcmQpIHRvIHRoZSB1c2VyPw0KPiANCj4gIEZyb20gbXkgcGVyc3BlY3RpdmUsIEkgZXhw
ZWN0IHRoZSAiY2hhbm5lbCBpbmRleCIgdG8gYmUgY29uc2lzdGVudCB3aXRoDQo+ICJmc2wscHBz
LWNoYW5uZWwiIHByb3BlcnR5LCBvdGhlcndpc2UgdGhpcyBtYXkgY29uZnVzZSBzb21lIHVzZXJz
Lg0KPiANCj4gSGkgQnVkYXksDQo+IA0KPiBJZiB5b3Ugd2FudCB0byByZXZlcnQgdG8gdGhlIGZp
cnN0IHZlcnNpb24sIEkgc3VnZ2VzdCByZW1vdmluZyB0aGUgY2hlY2suDQo+IEJlY2F1c2UgdGhl
IGNoZWNrIGluIHBlcmlvZF9zdG9yZSgpIGFscmVhZHkgZ3VhcmFudGVlcyB0aGF0DQo+IHJlcS5w
ZXJvdXQuaW5kZXggbXVzdCBiZSAwLg0KPiANCj4gDQoNCk9rYXksIEkgd2lsbCBkbyB0aGF0Lg0K


