Return-Path: <netdev+bounces-300942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nL+rCfubOGrXeQcAu9opvQ
	(envelope-from <netdev+bounces-300942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:20:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF66AC0BD
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:20:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300942-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300942-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8BA5300233D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9839130C157;
	Mon, 22 Jun 2026 02:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C052641C6;
	Mon, 22 Jun 2026 02:20:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782094838; cv=none; b=pJHtHHHPxJj2vxpWIUZ4blzWHs2eiAY1bhp+C4XCxl54Z6O1UhheQQ0joSgwMY2RGgrcIRK488b30E/rn2CxqB6iDL6lupqBm9w2Bx4KHGFWipPggO693Xfe9zHRXEI8hXzqRYDncIyR5HmjMGM+YgM4bo3qYQvhsmxjQhe95Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782094838; c=relaxed/simple;
	bh=zNzXLGPbgjHjVIZkEPXI0gjusig9YVEFyMRzgKCkUvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=GJY8tEAiz4ktt0kC23pDsN1zMPyZkQpi5VhQDNsjA/243NVMcTNl5L3FWWJ4O94vBcM/ife47NasRnSq7tm+1+TWMqdPxdlzw0ToGzSZJHj8JHpGo1vik8AEvdvjVJLIraoHh7qvNQgpPzsTWBm8cZd2533UvlOteXN8Cj9BfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Mon, 22 Jun 2026 10:19:50 +0800 (GMT+08:00)
Date: Mon, 22 Jun 2026 10:19:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com, horms@kernel.org, lee@kernel.org
Subject: Re: Re: [PATCH net-next v8 3/6] net: stmmac: eic7700: make RGMII
 delay properties optional
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <30229cfe-b395-4d0f-81ef-eb780ac26599@lunn.ch>
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
 <20260610012937.911-1-lizhi2@eswincomputing.com>
 <eaa645fc-be06-4a15-8c2f-6e82129c4715@bootlin.com>
 <30229cfe-b395-4d0f-81ef-eb780ac26599@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <512b77d5.993b.19eed207fc9.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgDHW3DHmzhqEvksAA--.8326W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEGDGo4EpcWfAACs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lee@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300942-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,eswincomputing.com,einfochips.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4CF66AC0BD

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQW5kcmV3IEx1bm4iIDxh
bmRyZXdAbHVubi5jaD4KPiBTZW5kIHRpbWU6U2F0dXJkYXksIDEzLzA2LzIwMjYgMTU6NDg6NDYK
PiBUbzogIk1heGltZSBDaGV2YWxsaWVyIiA8bWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20+
Cj4gQ2M6IGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20sIGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0
QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3JnLCBrcnprK2R0QGtl
cm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsIHBh
YmVuaUByZWRoYXQuY29tLCBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tLCBhbGV4YW5kcmUudG9y
Z3VlQGZvc3Muc3QuY29tLCBybWsra2VybmVsQGFybWxpbnV4Lm9yZy51aywgcGp3QGtlcm5lbC5v
cmcsIHBhbG1lckBkYWJiZWx0LmNvbSwgYW91QGVlY3MuYmVya2VsZXkuZWR1LCBhbGV4QGdoaXRp
LmZyLCBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC1zdG0zMkBzdC1tZC1t
YWlsbWFuLnN0b3JtcmVwbHkuY29tLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5j
b20sIGxpbm1pbkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBz
LmNvbSwgcHJpdGVzaC5wYXRlbEBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29t
cHV0aW5nLmNvbSwgaG9ybXNAa2VybmVsLm9yZywgbGVlQGtlcm5lbC5vcmcKPiBTdWJqZWN0OiBS
ZTogW1BBVENIIG5ldC1uZXh0IHY4IDMvNl0gbmV0OiBzdG1tYWM6IGVpYzc3MDA6IG1ha2UgUkdN
SUkgZGVsYXkgcHJvcGVydGllcyBvcHRpb25hbAo+IAo+IE9uIFdlZCwgSnVuIDEwLCAyMDI2IGF0
IDEwOjI2OjUwQU0gKzAyMDAsIE1heGltZSBDaGV2YWxsaWVyIHdyb3RlOgo+ID4gSGksCj4gPiAK
PiA+IE9uIDYvMTAvMjYgMDM6MjksIGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20gd3JvdGU6Cj4g
PiA+IEZyb206IFpoaSBMaSA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4KPiA+ID4gCj4gPiA+
IE1ha2UgcngtaW50ZXJuYWwtZGVsYXktcHMgYW5kIHR4LWludGVybmFsLWRlbGF5LXBzIG9wdGlv
bmFsIGluIHRoZQo+ID4gPiBFSUM3NzAwIERXTUFDIGRyaXZlci4KPiA+ID4gCj4gPiA+IFRoZSBk
cml2ZXIgcHJldmlvdXNseSByZXF1aXJlZCBib3RoIHByb3BlcnRpZXMgdG8gYmUgcHJlc2VudCBh
bmQgd291bGQKPiA+ID4gZmFpbCBwcm9iZSB3aGVuIHRoZXkgd2VyZSBtaXNzaW5nLiBUaGlzIHJl
c3RyaWN0cyB2YWxpZCBoYXJkd2FyZQo+ID4gPiBjb25maWd1cmF0aW9ucyB3aGVyZSBSR01JSSB0
aW1pbmcgaXMgaW5zdGVhZCBwcm92aWRlZCBieSB0aGUgUEhZIG9yCj4gPiA+IGJvYXJkIGRlc2ln
bi4KPiA+ID4gCj4gPiA+IFVwZGF0ZSB0aGUgZHJpdmVyIHRvIHRyZWF0IG1pc3NpbmcgZGVsYXkg
cHJvcGVydGllcyBhcyB6ZXJvIGRlbGF5LAo+ID4gPiBhbGxvd2luZyBzeXN0ZW1zIHdpdGhvdXQg
ZXhwbGljaXQgTUFDLXNpZGUgZGVsYXkgdHVuaW5nIHRvIG9wZXJhdGUKPiA+ID4gY29ycmVjdGx5
Lgo+ID4gPiAKPiA+ID4gVGhpcyBhbGlnbnMgdGhlIGRyaXZlciBiZWhhdmlvciB3aXRoIHRoZSB1
cGRhdGVkIGRldmljZSB0cmVlIGJpbmRpbmcKPiA+ID4gYW5kIHByb3ZpZGVzIGEgc2FmZSBkZWZh
dWx0IGNvbmZpZ3VyYXRpb24gd2hlbiBNQUMtc2lkZSBkZWxheQo+ID4gPiBwcm9ncmFtbWluZyBp
cyBub3QgcmVxdWlyZWQuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaGkgTGkgPGxpemhp
MkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtZWljNzcwMC5jIHwgNiAtLS0tLS0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLWVpYzc3MDAuYyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLWVpYzc3MDAuYwo+ID4gPiBpbmRleCA0
YWM5NzlkODc0ZDYuLmVjOTliNTk3YWVhZiAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtZWljNzcwMC5jCj4gPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLWVpYzc3MDAuYwo+ID4gPiBAQCAt
MTY1LDkgKzE2NSw2IEBAIHN0YXRpYyBpbnQgZWljNzcwMF9kd21hY19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gPiAgCQlkd2NfcHJpdi0+ZXRoX2Nsa19kbHlfcGFyYW0g
Jj0gfkVJQzc3MDBfRVRIX1JYX0FESl9ERUxBWTsKPiA+ID4gIAkJZHdjX3ByaXYtPmV0aF9jbGtf
ZGx5X3BhcmFtIHw9Cj4gPiA+ICAJCQkJIEZJRUxEX1BSRVAoRUlDNzcwMF9FVEhfUlhfQURKX0RF
TEFZLCB2YWwpOwo+ID4gPiAtCX0gZWxzZSB7Cj4gPiA+IC0JCXJldHVybiBkZXZfZXJyX3Byb2Jl
KCZwZGV2LT5kZXYsIC1FSU5WQUwsCj4gPiA+IC0JCQkibWlzc2luZyByZXF1aXJlZCBwcm9wZXJ0
eSByeC1pbnRlcm5hbC1kZWxheS1wc1xuIik7Cj4gPiA+ICAJfQo+ID4gPiAgCj4gPiA+ICAJLyog
UmVhZCB0eC1pbnRlcm5hbC1kZWxheS1wcyBhbmQgdXBkYXRlIHR4X2NsayBkZWxheSAqLwo+ID4g
PiBAQCAtMTg3LDkgKzE4NCw2IEBAIHN0YXRpYyBpbnQgZWljNzcwMF9kd21hY19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gPiAgCQlkd2NfcHJpdi0+ZXRoX2Nsa19kbHlf
cGFyYW0gJj0gfkVJQzc3MDBfRVRIX1RYX0FESl9ERUxBWTsKPiA+ID4gIAkJZHdjX3ByaXYtPmV0
aF9jbGtfZGx5X3BhcmFtIHw9Cj4gPiA+ICAJCQkJIEZJRUxEX1BSRVAoRUlDNzcwMF9FVEhfVFhf
QURKX0RFTEFZLCB2YWwpOwo+ID4gPiAtCX0gZWxzZSB7Cj4gPiA+IC0JCXJldHVybiBkZXZfZXJy
X3Byb2JlKCZwZGV2LT5kZXYsIC1FSU5WQUwsCj4gPiA+IC0JCQkibWlzc2luZyByZXF1aXJlZCBw
cm9wZXJ0eSB0eC1pbnRlcm5hbC1kZWxheS1wc1xuIik7Cj4gPiA+ICAJfQo+ID4gCj4gPiBJIHRo
aW5rIHRoZW4geW91IG5lZWQgdG8gaGFuZGxlIFJHTUlJLCBSR01JSV9JRCwgUkdNSUlfUlhJRCBh
bmQgUkdNSUlfVFhJRCwKPiA+IGJ5IHVzaW5nIGRlZmF1bHQgZGVsYXlzIGZvciB0aGVzZSAodXN1
YWxseSBhcm91bmQgMm5zKSwgYXMgaGVyZSBhbGwgZGVsYXlzCj4gPiB3aWxsIGJlIHNldCB0byAw
LCByZWdhcmRsZXNzIG9mIHRoZSBSR01JSSBtb2RlIGluIHVzZS4KPiAKPiBOby4gQnkgZGVmYXVs
dCwgdGhlIE1BQyBhZGRzIDBucyBkZWxheSwgYW5kIHBhc3NlcyB0aGUgcGh5LW1vZGUgdG8gdGhl
Cj4gUEhZLiBJdCB3aWxsIHRoZW4gYWRkIHRoZSAybnMgZGVsYXkuIEl0IGlzIHBvc3NpYmxlIHRv
IHVzZSB0aGUKPiB0eC1pbnRlcm5hbC1kZWxheS1wcyBhbmQgcngtaW50ZXJuYWwtZGVsYXktcHMg
aW4gdGhlIE1BQyB0byBhZGQgc21hbGwKPiB0dW5pbmcgZGVsYXlzLCBidXQgbm90IHRoZSBmdWxs
IDJucy4KPiAKPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xNS9zb3VyY2Uv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ldGhlcm5ldC1jb250cm9sbGVy
LnlhbWwjTDI4Nwo+IAoKVGhhbmtzIGZvciB0aGUgZWFybGllciBkaXNjdXNzaW9uIGFuZCBmb3Ig
aGVscGluZyBjbGFyaWZ5IHRoZSBldGgwCmRlc2lnbi4KCkknbSBwcmVwYXJpbmcgYSB2OSBvZiB0
aGUgc2VyaWVzLiBUaGUgbmV4dCByZXZpc2lvbiB3aWxsIGFkZHJlc3MgdGhlCmlzc3VlcyByZXBv
cnRlZCBieSBTYXNoaWtvIHJldmlldywgbWFpbmx5IERUIGJpbmRpbmcgc2NoZW1hIGFuZCBEVFMK
d2FybmluZ3MuCgpCZWZvcmUgSSBwb3N0IHY5LCBJJ2QgbGlrZSB0byBjaGVjayB3aGV0aGVyIHlv
dSBoYXZlIGFueSBjb25jZXJucyBvcgpzdWdnZXN0aW9ucyByZWdhcmRpbmcgdGhlIGRyaXZlciBj
aGFuZ2VzLgoKVGhhbmtzLApaaGkK

