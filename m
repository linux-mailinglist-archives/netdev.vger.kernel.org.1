Return-Path: <netdev+bounces-253713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA1sMVRYeGkNpgEAu9opvQ
	(envelope-from <netdev+bounces-253713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:16:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D0090532
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96C56300BD9E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B422DECBA;
	Tue, 27 Jan 2026 06:15:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAEE22068F;
	Tue, 27 Jan 2026 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494531; cv=none; b=cpYKmK5OXiZs3Ks0cQjooAI9ib3pHuu7pIv+wyuUUGNOegqU07g++SQNoqOv8cEU5qKbTZ6cmdxxcmMZUmdlMEUrOGbW3tDmyJjNvParqA6Kk79sVpRWlFuCj+Ygp2xGMOrnyvg+8vyGzdJD2JF6RwTACI6DqfGaWCoy9wmSWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494531; c=relaxed/simple;
	bh=+NEiPqbjxxmtoJTRe+GqcHZOke9hYCrR2akyxvdanZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ajtoF/sZyzQjOPlncmxvTZGkoHkTFsDwIyFQe39ojOWB9Qfii+6ZkZpzZGjimAzdCyvtKTyjVZtI4CCtHzdEX/mYMXeKDmNPOF/OdF3wsTGUhwCFEjbgInKdanWx8+3jiNqoLffhLWDOY+X/cfVyqkZu93qjtid8ZVq/1OlIbj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from linmin$eswincomputing.com ( [10.10.96.205] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 27 Jan 2026 14:14:51 +0800 (GMT+08:00)
Date: Tue, 27 Jan 2026 14:14:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Min Lin" <linmin@eswincomputing.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Bo Gan" <ganboing@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	=?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <aXeydXuWEMDz-yVM@shell.armlinux.org.uk>
References: <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
 <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
 <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
 <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
 <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
 <bd202cfa-d6eb-4d0e-982d-b49795dd25f7@lunn.ch>
 <009aefc4-fbc9-4f91-9230-23d18c281bf3@gmail.com>
 <73ea5619.2b71.19bf847c80d.Coremail.linmin@eswincomputing.com>
 <aXeydXuWEMDz-yVM@shell.armlinux.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <32a1f814.2c79.19bfe173225.Coremail.linmin@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgCH+y3bV3hppKsGAA--.1519W
X-CM-SenderInfo: 5olqzx3q6h245lqf0zpsxwx03jof0z/1tbiAgEACWl3l4EWAQAAsV
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253713-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmin@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,kernel.org,eswincomputing.com,vger.kernel.org,davemloft.net,google.com,redhat.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[st.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stormreply.com:email,lunn.ch:email,davemloft.net:email]
X-Rspamd-Queue-Id: 35D0090532
X-Rspamd-Action: no action

SGkgUnVzc2VsbCwKCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZXMtLS0tLQo+IEZyb206ICJSdXNz
ZWxsIEtpbmcgKE9yYWNsZSkiIDxsaW51eEBhcm1saW51eC5vcmcudWs+Cj4gU2VuZCB0aW1lOlR1
ZXNkYXksIDI3LzAxLzIwMjYgMDI6Mjk6MDkKPiBUbzogIk1pbiBMaW4iIDxsaW5taW5AZXN3aW5j
b21wdXRpbmcuY29tPgo+IENjOiAiQm8gR2FuIiA8Z2FuYm9pbmdAZ21haWwuY29tPiwgIkFuZHJl
dyBMdW5uIiA8YW5kcmV3QGx1bm4uY2g+LCAiS3J6eXN6dG9mIEtvemxvd3NraSIgPGtyemtAa2Vy
bmVsLm9yZz4sIOadjuW/lyA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4sIGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5u
ZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3Jn
LCBrcnprK2R0QGtlcm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmcsIHBhYmVuaUByZWRoYXQuY29tLCBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tLCBh
bGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tLCBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0
b3JtcmVwbHkuY29tLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtl
c2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNv
bQo+IFN1YmplY3Q6IFJlOiBSZTogW1BBVENIIHYxIDEvMl0gZHQtYmluZGluZ3M6IGV0aGVybmV0
OiBlc3dpbjogYWRkIGNsb2NrIHNhbXBsaW5nIGNvbnRyb2wKPiAKPiBPbiBNb24sIEphbiAyNiwg
MjAyNiBhdCAxMToxMDoxMkFNICswODAwLCBNaW4gTGluIHdyb3RlOgo+ID4gRHVlIHRvIGNoaXAg
YmFja2VuZCByZWFzb25zLCB0aGVyZSBpcyBhbHJlYWR5IGEgfjQtNW5zIHNrZXcgYmV0d2VlbiB0
aGUgUlgKPiA+IGNsb2NrIGFuZCBkYXRhIG9mIHRoZSBldGgxIE1BQyBjb250cm9sbGVyIGluc2lk
ZSB0aGUgc2lsaWNvbi4KPiAKPiBMZXQncyBhbmFseXNlIHRoaXMuCj4gCj4gCVRYQyAvIFJYQwlU
WEMgLyBSWEMKPiBTcGVlZAlDbG9jayByYXRlCUNsb2NrIHBlcmlvZAo+IDFHCTEyNU1IegkJOG5z
Cj4gMTAwTQkyNU1IegkJNDBucwo+IDEwTQkyLjVNSHoJCTQwMG5zCj4gCj4gVGhlIHJlcXVpcmVk
IHNrZXcgZm9yIFRYQyBhbmQgUlhDIGF0IHRoZSByZWNlaXZlciBpcyBzcGVjaWZpZWQgdG8gYmUK
PiBiZXR3ZWVuIDEgYW5kIDIuNm5zIGlycmVzcGVjdGl2ZSBvZiB0aGUgc3BlZWQuIFRoZSBlZGdl
IG9mIHRoZSBjbG9jawo+IGlzIGFsc28gaW1wb3J0YW50OiB0aGUgcmlzaW5nIGVkZ2UgaW5kaWNh
dGVzIHRoZSBsb3dlciA0IGJpdHMsIGFuZAo+IHRoZSBmYWxsaW5nIGVkZ2UgaW5kaWNhdGVzIHRo
ZSB1cHBlciA0IGJpdHMuCj4gCj4gQXQgMUcgc3BlZWQsIHdpdGggYSAiNCB0byA1bnMiIHNrZXcg
aW4gdGhlIGNoaXAuIElmIHRoaXMgaXMgYWNjdXJhdGUsCj4gdGhlbiBpbnZlcnRpbmcgdGhlIGNs
b2NrIGFuZCBhZGRpbmcgMW5zIG9mIGFkZGl0aW9uYWwgc2tldyBieSBzb21lCj4gbWVhbnMgKFBD
QiB0cmFjZSwgb3IgYXQgdGhlIE1BQyBvciBQSFkpIHdpbGwgZ2l2ZSB0aGUgcmVxdWlyZWQgY2xv
Y2sKPiBhdCB0aGUgcmVjZWl2ZXIuCj4gCgpZZXMsIHRoYXQncyBleGFjdGx5IHRoZSBjYXNlLgoK
PiBUaGUgdGltaW5nIHRhYmxlIGluIHRoZSBSR01JSSBzdGFuZGFyZCAoMy4zKSBhbGxvd3MgZm9y
IFRjeWMgKHRoZQo+IGNsb2NrIHJhdGUpIHRvIGJlIHNjYWxlZCwgYnV0IHRoZXJlIGlzIG5vIGFs
bG93YW5jZSBmb3Igc2NhbGluZwo+IFRza2V3UiAodGhlIHJlcXVpcmVkIDEgdG8gMi42bnMgc2tl
dy4pIFRoaXMgc2tldyBwYXJhbWV0ZXIgaXMKPiBmaXhlZC4KPiAKPiBTbywgYXQgdGhlIG90aGVy
IHNwZWVkcywgeW91IGFyZSBjb21wbGV0ZWx5IHVuYWJsZSB0byBtZWV0IHRoZSB0aW1pbmcKPiBz
cGVjaWZpY2F0aW9uLCB3aGV0aGVyIGlycmVzcGVjdGl2ZSBvZiB0aGUgY2xvY2sgaW52ZXJzaW9u
LiBJbiBlZmZlY3QsCj4gdGhlIG9ubHkgc3BlZWQgdGhhdCB5b3UgY2FuIG1lZXQgdGhlIHNwZWNp
ZmljYXRpb24gaXMgMUcuCj4gCgpUaGUgdGltaW5nIHRhYmxlIGluIHRoZSBSR01JSSBzdGFuZGFy
ZCgzLjMpIHNheXMgdGhlIG1heCB2YWx1ZSBvZiBUc2tldwpmb3IgMTAvMTAwIGlzIHVuc3BlY2lm
aWVkLgpRdW90YXRpb246Im5vdGUxOiAuLi4sRm9yIDEwLzEwMCB0aGUgTWF4IHZhbHVlIGlzIHVu
c3BlY2lmaWVkLiIKCkkgdGhpbmsgZm9yIDEwLzEwMCwgdGhlICI0IHRvIDVucyIgc2tldyBpbiB0
aGUgY2hpcCBkb2Vzbid0IGJyZWFrIHRoZQpzdGFuZGFyZC4gQXQgMTAvMTAwIHNwZWVkcywgaXQg
bWVldHMgdGhlIHRpbWluZyBzcGVjaWZpY2F0aW9uIHdpdGhvdXQKaGF2aW5nIHRvIHRvIGFkZCBj
bG9jayBpbnZlcnNpb24uCkluIHByYWN0aWNlLCBpdCB3b3JrcyBhdCAxMC8xMDAgc3BlZWRzIGlu
IHRoZSByZ21paS1pZCBwaHkgbW9kZS4KCj4gVGh1cywgSSB0aGluayB0aGlzIGlzIHNvbWV0aGlu
ZyB0aGF0IG5lZWRzIGEgbG90IG1vcmUgdGhhbiBqdXN0ICJkbwo+IHdlIG5lZWQgdG8gaW52ZXJ0
IHRoZSBjbG9jayIuIFlvdSBhbHNvIG5lZWQgdG8gcHJldmVudCAxME0gYW5kIDEwME0KPiBiZWlu
ZyBzdXBwb3J0ZWQgSU1ITy4KPiAKClJlZ2FyZHMsCkxpbiBNaW4K

