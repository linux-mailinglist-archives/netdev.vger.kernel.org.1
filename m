Return-Path: <netdev+bounces-282674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGy7AF3/8mkvwgEAu9opvQ
	(envelope-from <netdev+bounces-282674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B2249E5FD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D5D53014C5D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6957439656E;
	Thu, 30 Apr 2026 07:06:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562FC39446D;
	Thu, 30 Apr 2026 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532761; cv=none; b=ZYf6fxEQMpKZ3iNbLeH5gb/zUKGIszuUjM9JbcOiyKSU/OfF0m4vysRGCxEs2JsWwNHvxHTbfYygvOe774Vnh/nZMP+2dD+LqyLYSKjK3myh3rcbplfp2Ohb8XWGNdEeq8tWfGUgaj0pqewcmaAF8f3x2iXwdbYHXYE71m99SyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532761; c=relaxed/simple;
	bh=Q/CYUFrBY9oiZ1V/DgB1eH5buSeSaju7jfaovk+Eukg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dUOP0JEId391itM7MuBF3p9ZRLZgkxDe3v+WuzhJJquhMkTS6ekcYB2jGNUhrl8ORUszLrt3P8YM9sUq0JbkujAfiJhLVDl5zVdsVF+oerBUvb1rJhnZeQxcOQj+L0G7dIpi6RV/8ilVujJflDK7mSlZtaEjZHgpEBIlHnMZruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Thu, 30 Apr 2026 15:05:13 +0800 (GMT+08:00)
Date: Thu, 30 Apr 2026 15:05:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
	horms@kernel.org
Subject: Re: Re: [PATCH net-next v7 4/4] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <d662fa07-cd0f-48c4-a6e4-03c5fd390e92@lunn.ch>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
 <20260427072603.1191-1-lizhi2@eswincomputing.com>
 <d662fa07-cd0f-48c4-a6e4-03c5fd390e92@lunn.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5e09c674.799b.19ddd34b91f.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgDHaXMp__Jp_vAVAA--.6489W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQENDGnyMpsSHgACs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 84B2249E5FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282674-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.015];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQW5kcmV3IEx1bm4iIDxh
bmRyZXdAbHVubi5jaD4KPiDlj5HpgIHml7bpl7Q6MjAyNi0wNC0yOSAwOTo0MTo1MyAo5pif5pyf
5LiJKQo+IOaUtuS7tuS6ujogbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbQo+IOaKhOmAgTogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGFuZHJldytuZXRkZXZAbHVubi5jaCwgZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldCwgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3JnLCByb2JoQGtl
cm5lbC5vcmcsIGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIG1jb3F1ZWxpbi5zdG0zMkBnbWFp
bC5jb20sIGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20sIHJtaytrZXJuZWxAYXJtbGludXgu
b3JnLnVrLCBwandAa2VybmVsLm9yZywgcGFsbWVyQGRhYmJlbHQuY29tLCBhb3VAZWVjcy5iZXJr
ZWxleS5lZHUsIGFsZXhAZ2hpdGkuZnIsIGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcs
IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20sIGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgbWF4
aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20sIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxp
bm1pbkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwg
cHJpdGVzaC5wYXRlbEBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5n
LmNvbSwgaG9ybXNAa2VybmVsLm9yZwo+IOS4u+mimDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2NyA0
LzRdIHJpc2N2OiBkdHM6IGVzd2luOiBlaWM3NzAwLWhpZml2ZS1wcmVtaWVyLXA1NTA6IGVuYWJs
ZSBFdGhlcm5ldCBjb250cm9sbGVyCj4gCj4gPiArJmdtYWMxIHsKPiA+ICsJcGh5LWhhbmRsZSA9
IDwmZ21hYzFfcGh5MD47Cj4gPiArCS8qCj4gPiArCSAqIEZvciB0aGUgVFggcGF0aCBvZiBnbWFj
MSwgdGhlcmUgaXMgYSBza2V3IGJldHdlZW4gdGhlIFRYIGNsb2NrCj4gPiArCSAqIGFuZCBkYXRh
IG9uIHRoZSBNQUMgY29udHJvbGxlciBpbnNpZGUgdGhlIHNpbGljb24uIFRoaXMgc2tldyBoYXBw
ZW5zCj4gPiArCSAqIHRvIGJlIGFwcHJveGltYXRlbHkgMiBucy4gVGhlcmVmb3JlLCBpdCBjYW4g
YmUgY29uc2lkZXJlZCB0aGF0IHRoZQo+ID4gKwkgKiAyIG5zIGRlbGF5IG9mIFRYIGlzIHByb3Zp
ZGVkIGJ5IHRoZSBNQUMuCj4gPiArCSAqIE5vIGRlbGF5IGNvbmZpZ3VyYXRpb24gZm9yIHR4IGlz
IG5lZWRlZCBpbiBzb2Z0d2FyZSB2aWEgUEhZIGRyaXZlci4KPiA+ICsJICovCj4gPiArCXBoeS1t
b2RlID0gInJnbWlpLXJ4aWQiOwo+IAo+IFRoaXMgaXMgd3JvbmcuIFRha2UgYSByZWFkIG9mCj4g
Cj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTUvc291cmNlL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZXRoZXJuZXQtY29udHJvbGxlci55YW1sI0wy
ODcKPiAKPiBwaHktbW9kZSBkZXNjcmliZXMgdGhlIGJvYXJkLiBJZiB0aGUgYm9hcmQgcHJvdmlk
ZXMgdGhlIDJucyBkZWxheSwgeW91Cj4gdXNlIHJnbWlpLiBJZiB0aGUgTUFDL1BIWSBwYWlyIG5l
ZWRzIHRvIHByb3ZpZGUgdGhlIGRlbGF5LCB5b3UgdXNpbmcKPiByZ21paS1pZC4KPiAKPiBJZiBy
Z21paS1pZCBpcyB1c2VkLCBpdCBpcyB1cCB0byB0aGUgTUFDL1BIWSB0byBkZWNpZGUgd2hpY2gg
d2lsbCBhZGQKPiB0aGUgZGVsYXkuIElmIHRoZSBNQUMgYWRkcyB0aGUgZGVsYXksIGl0IG5lZWRz
IHRvIG1hc2sgdGhlIHZhbHVlIG9mCj4gcGh5LW1vZGUgaXQgcGFzc2VzIHRvIHRoZSBQSFkgc28g
aXQgZG9lcyBub3QgYWxzbyBhZGQgdGhlIGRlbGF5Lgo+IAo+IFlvdXIgYnJva2VuIGhhcmR3YXJl
IG1lYW5zIHlvdSBjYW5ub3Qgc3VwcG9ydCAncmdtaWknIG9yICdyZ21paS1yeCcsCj4gc2luY2Ug
eW91IGNhbm5vdCB0dXJuIG9mZiB0aGlzIDJucyBkZWxheSwgc28geW91IGVuZCB1cCB3aXRoIGRv
dWJsZQo+IGRlbGF5cyBpZiBhbnlib2R5IGRlc2lnbnMgYSBib2FyZCB3aXRoIDJucyBUWCBkZWxh
eSBvbiB0aGUgYm9hcmQKPiBpdHNlbGYuIFNvIHBsZWFzZSB2YWxpZGF0ZSB0aGUgUEhZIG1vZGVz
IGFuZCByZXR1cm4gLUVJTlZBTCBpZiB0aGVzZQo+IG1vZGVzIGFyZSB1c2VkLgo+IAoKVGhhbmtz
IGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24uCgpZb3UgYXJlIHJpZ2h0IHRoYXQgcGh5LW1v
ZGUgc2hvdWxkIGRlc2NyaWJlIHRoZSBib2FyZC1sZXZlbApjb25maWd1cmF0aW9uIGFuZCBzaG91
bGQgbm90IGJlIG1vZGlmaWVkIGluIHRoZSBEVCB0byByZWZsZWN0Ck1BQy1pbnRlcm5hbCBiZWhh
dmlvci4KCkZvciB0aGlzIGhhcmR3YXJlLCB0aGUgTUFDIHVuY29uZGl0aW9uYWxseSBpbnRyb2R1
Y2VzIGFuIH4yIG5zClRYIGRlbGF5IHdoaWNoIGNhbm5vdCBiZSBkaXNhYmxlZC4gVGhpcyBtZWFu
cyB0aGUgY29uZmlndXJhdGlvbgplZmZlY3RpdmVseSBtYXRjaGVzIHJnbWlpLWlkIGF0IHRoZSBi
b2FyZCBsZXZlbCwgd2hlcmUgVFggZGVsYXkKaXMgcHJvdmlkZWQgYnkgdGhlIE1BQyBhbmQgUlgg
ZGVsYXkgYnkgdGhlIFBIWS4KCkkgd2lsbCB0aGVyZWZvcmU6Ci0gS2VlcCB0aGUgRFQgdXNpbmcg
cGh5LW1vZGUgPSAicmdtaWktaWQiIHRvIGNvcnJlY3RseSBkZXNjcmliZQrCoCB0aGUgYm9hcmQt
bGV2ZWwgdGltaW5nLgotIEluIHRoZSBkcml2ZXIsIG1hc2sgdGhlIHBoeV9pbnRlcmZhY2UgcGFz
c2VkIHRvIHRoZSBQSFkgc28gdGhhdArCoCBpdCBkb2VzIG5vdCBhZGQgVFggZGVsYXksIGF2b2lk
aW5nIGRvdWJsZSBkZWxheS4KLSBFeHBsaWNpdGx5IHJlamVjdCB1bnN1cHBvcnRlZCBtb2RlcyBz
dWNoIGFzICJyZ21paSIgYW5kCsKgICJyZ21paS1yeGlkIiwgc2luY2UgdGhlIE1BQyBUWCBkZWxh
eSBjYW5ub3QgYmUgZGlzYWJsZWQgYW5kCsKgIHRoZXNlIGNvbmZpZ3VyYXRpb25zIHdvdWxkIGxl
YWQgdG8gaW5jb3JyZWN0IHRpbWluZy4KClJlZ2FyZGluZyB0aGUgdHgtaW50ZXJuYWwtZGVsYXkt
cHMgcHJvcGVydHksIGl0IHJlcHJlc2VudHMgdGhlCnRvdGFsIGVmZmVjdGl2ZSBUWCBkZWxheSBv
biB0aGUgbGluZSwgaW5jbHVkaW5nIHRoZSBpbmhlcmVudAp+MiBucyBza2V3IGludHJvZHVjZWQg
YnkgdGhlIE1BQyBzaWxpY29uLiBUaGUgZHJpdmVyIHN1YnRyYWN0cwp0aGlzIGluaGVyZW50IHNr
ZXcgYW5kIHByb2dyYW1zIG9ubHkgdGhlIHJlbWFpbmluZyBkZWxheS4KCkFzIGEgcmVzdWx0LCBm
b3IgdGhlIGNsay1pbnZlcnNpb24gdmFyaWFudCwgdGhlIHZhbGlkIHJhbmdlIGlzClsyMDAwLCA0
NTQwXSwgd2hpY2ggbWF0Y2hlcyB0aGUgdXBkYXRlZCBiaW5kaW5nIGNvbnN0cmFpbnRzLgoKSSB3
aWxsIGNsYXJpZnkgaW4gdGhlIGJpbmRpbmcgZGVzY3JpcHRpb24gdGhhdCB0aGlzIHByb3BlcnR5
CnJlcHJlc2VudHMgdGhlIHRvdGFsIFRYIGRlbGF5IChNQUMgKyBwcm9ncmFtbWFibGUpLCB0byBh
dm9pZAphbWJpZ3VpdHkuCgpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lgo=

