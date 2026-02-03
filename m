Return-Path: <netdev+bounces-256155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CISADGKRgWl/HAMAu9opvQ
	(envelope-from <netdev+bounces-256155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:10:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF84D50B6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5F1F309CC7E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9A36D4F9;
	Tue,  3 Feb 2026 06:06:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F736CDF7;
	Tue,  3 Feb 2026 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098815; cv=none; b=keC+rMl6cvHwzZklMd2IIbffHu9OHeqbFTVmtnjzQ94rv1V5FK3OPhnF1Mrf4X/drp8a8k/ERO7E0BiAydm/ddd+yWCBX6/lrdaKnCY0okchC27auB03rjzEqMewBXsFCb7iiBsBg1WqcZqqkU8Pd6dESLjdC9RxoJO5D6r6xPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098815; c=relaxed/simple;
	bh=DlFL+QMwywWqe4crdHJgG4bMmcUy/JpC6r6a+eTnvp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=toXAUFsBqm16WYCfXFKMPUEIkhW0cFUd7PdAvdT+GEDWRz44vbRBDupLbWO5tU39rFbzrz+FHeufBx/IPjSDck4CiW0rRzcBk4a6WMbfvGQWssfZbC8LZtk5kkZbeEzliIHj2NDHip5mMDENKDPNLd43zCXnhOKg022kXNtSzak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from linmin$eswincomputing.com ( [10.10.96.205] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 3 Feb 2026 14:06:14 +0800 (GMT+08:00)
Date: Tue, 3 Feb 2026 14:06:14 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Min Lin" <linmin@eswincomputing.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"Krzysztof Kozlowski" <krzk@kernel.org>,
	"Bo Gan" <ganboing@gmail.com>
Cc: "Andrew Lunn" <andrew@lunn.ch>,
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
In-Reply-To: <5c835fe9.2d60.19c0325df03.Coremail.linmin@eswincomputing.com>
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
 <32a1f814.2c79.19bfe173225.Coremail.linmin@eswincomputing.com>
 <973f2b4b-bf8d-4a77-a27a-47495bc21ff8@gmail.com>
 <5c835fe9.2d60.19c0325df03.Coremail.linmin@eswincomputing.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <43c97440.30bb.19c221bd137.Coremail.linmin@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgAnca1WkIFp8h0CAA--.365W
X-CM-SenderInfo: 5olqzx3q6h245lqf0zpsxwx03jof0z/1tbiAQEHCWmA0Y45WQAAsY
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256155-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[armlinux.org.uk,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,eswincomputing.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmin@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stormreply.com:email,einfochips.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email,davemloft.net:email,eswincomputing.com:mid,eswincomputing.com:email,nxp.com:url]
X-Rspamd-Queue-Id: 9CF84D50B6
X-Rspamd-Action: no action

SGkgUnVzc2VsbCwgS3J6eXN6dG9mLAoKCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlcy0tLS0tCj4g
RnJvbTogIk1pbiBMaW4iIDxsaW5taW5AZXN3aW5jb21wdXRpbmcuY29tPgo+IFNlbmQgdGltZTpX
ZWRuZXNkYXksIDI4LzAxLzIwMjYgMTM6NDg6NTkKPiBUbzogIkJvIEdhbiIgPGdhbmJvaW5nQGdt
YWlsLmNvbT4KPiBDYzogIlJ1c3NlbGwgS2luZyAoT3JhY2xlKSIgPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az4sICJBbmRyZXcgTHVubiIgPGFuZHJld0BsdW5uLmNoPiwgIktyenlzenRvZiBLb3psb3dz
a2kiIDxrcnprQGtlcm5lbC5vcmc+LCDmnY7lv5cgPGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20+
LCBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZywgYW5kcmV3K25ldGRldkBsdW5uLmNoLCBkYXZl
bUBkYXZlbWxvZnQubmV0LCBlZHVtYXpldEBnb29nbGUuY29tLCBrdWJhQGtlcm5lbC5vcmcsIHJv
YmhAa2VybmVsLm9yZywga3J6aytkdEBrZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnLCBwYWJlbmlAcmVkaGF0LmNvbSwgbWNvcXVlbGluLnN0bTMy
QGdtYWlsLmNvbSwgYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbSwgbGludXgtc3RtMzJAc3Qt
bWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBuaW5neXVAZXN3aW5jb21wdXRp
bmcuY29tLCBwaW5rZXNoLnZhZ2hlbGFAZWluZm9jaGlwcy5jb20sIHdlaXNoYW5nanVhbkBlc3dp
bmNvbXB1dGluZy5jb20KPiBTdWJqZWN0OiBSZTogUmU6IFtQQVRDSCB2MSAxLzJdIGR0LWJpbmRp
bmdzOiBldGhlcm5ldDogZXN3aW46IGFkZCBjbG9jayBzYW1wbGluZyBjb250cm9sCj4gCj4gSGkg
Qm8gR2FuLAo+IAo+IAo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlcy0tLS0tCj4gPiBGcm9tOiAi
Qm8gR2FuIiA8Z2FuYm9pbmdAZ21haWwuY29tPgo+ID4gU2VuZCB0aW1lOldlZG5lc2RheSwgMjgv
MDEvMjAyNiAxMDozODoyOAo+ID4gVG86ICJNaW4gTGluIiA8bGlubWluQGVzd2luY29tcHV0aW5n
LmNvbT4sICJSdXNzZWxsIEtpbmcgKE9yYWNsZSkiIDxsaW51eEBhcm1saW51eC5vcmcudWs+Cj4g
PiBDYzogIkFuZHJldyBMdW5uIiA8YW5kcmV3QGx1bm4uY2g+LCAiS3J6eXN6dG9mIEtvemxvd3Nr
aSIgPGtyemtAa2VybmVsLm9yZz4sIOadjuW/lyA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4s
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVt
QGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9i
aEBrZXJuZWwub3JnLCBrcnprK2R0QGtlcm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmcsIHBhYmVuaUByZWRoYXQuY29tLCBtY29xdWVsaW4uc3RtMzJA
Z21haWwuY29tLCBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tLCBsaW51eC1zdG0zMkBzdC1t
ZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGlu
Zy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2lu
Y29tcHV0aW5nLmNvbQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIGR0LWJpbmRpbmdz
OiBldGhlcm5ldDogZXN3aW46IGFkZCBjbG9jayBzYW1wbGluZyBjb250cm9sCj4gPiAKPiA+IEhp
IE1pbiwgUnVzc2VsbCwgS3J6eXN6dG9mLAo+ID4gCj4gPiBPbiAxLzI2LzI2IDIyOjE0LCBNaW4g
TGluIHdyb3RlOgo+ID4gPiBIaSBSdXNzZWxsLAo+ID4gPiAKPiA+ID4gCj4gPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiA+ID4+IEZyb206ICJSdXNzZWxsIEtpbmcgKE9yYWNsZSki
IDxsaW51eEBhcm1saW51eC5vcmcudWs+Cj4gPiA+PiBTZW5kIHRpbWU6VHVlc2RheSwgMjcvMDEv
MjAyNiAwMjoyOTowOQo+ID4gPj4gVG86ICJNaW4gTGluIiA8bGlubWluQGVzd2luY29tcHV0aW5n
LmNvbT4KPiA+ID4+IENjOiAiQm8gR2FuIiA8Z2FuYm9pbmdAZ21haWwuY29tPiwgIkFuZHJldyBM
dW5uIiA8YW5kcmV3QGx1bm4uY2g+LCAiS3J6eXN6dG9mIEtvemxvd3NraSIgPGtyemtAa2VybmVs
Lm9yZz4sIOadjuW/lyA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4sIGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQs
IGVkdW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3JnLCBr
cnprK2R0QGtlcm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmcsIHBhYmVuaUByZWRoYXQuY29tLCBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tLCBhbGV4
YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tLCBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3Jt
cmVwbHkuY29tLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcsIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtlc2gu
dmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgd2Vpc2hhbmdqdWFuQGVzd2luY29tcHV0aW5nLmNvbQo+
ID4gPj4gU3ViamVjdDogUmU6IFJlOiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5kaW5nczogZXRoZXJu
ZXQ6IGVzd2luOiBhZGQgY2xvY2sgc2FtcGxpbmcgY29udHJvbAo+ID4gPj4KPiA+ID4+IE9uIE1v
biwgSmFuIDI2LCAyMDI2IGF0IDExOjEwOjEyQU0gKzA4MDAsIE1pbiBMaW4gd3JvdGU6Cj4gPiA+
Pj4gRHVlIHRvIGNoaXAgYmFja2VuZCByZWFzb25zLCB0aGVyZSBpcyBhbHJlYWR5IGEgfjQtNW5z
IHNrZXcgYmV0d2VlbiB0aGUgUlgKPiA+ID4+PiBjbG9jayBhbmQgZGF0YSBvZiB0aGUgZXRoMSBN
QUMgY29udHJvbGxlciBpbnNpZGUgdGhlIHNpbGljb24uCj4gPiA+Pgo+ID4gPj4gTGV0J3MgYW5h
bHlzZSB0aGlzLgo+ID4gPj4KPiA+ID4+IAlUWEMgLyBSWEMJVFhDIC8gUlhDCj4gPiA+PiBTcGVl
ZAlDbG9jayByYXRlCUNsb2NrIHBlcmlvZAo+ID4gPj4gMUcJMTI1TUh6CQk4bnMKPiA+ID4+IDEw
ME0JMjVNSHoJCTQwbnMKPiA+ID4+IDEwTQkyLjVNSHoJCTQwMG5zCj4gPiA+Pgo+ID4gPj4gVGhl
IHJlcXVpcmVkIHNrZXcgZm9yIFRYQyBhbmQgUlhDIGF0IHRoZSByZWNlaXZlciBpcyBzcGVjaWZp
ZWQgdG8gYmUKPiA+ID4+IGJldHdlZW4gMSBhbmQgMi42bnMgaXJyZXNwZWN0aXZlIG9mIHRoZSBz
cGVlZC4gVGhlIGVkZ2Ugb2YgdGhlIGNsb2NrCj4gPiA+PiBpcyBhbHNvIGltcG9ydGFudDogdGhl
IHJpc2luZyBlZGdlIGluZGljYXRlcyB0aGUgbG93ZXIgNCBiaXRzLCBhbmQKPiA+ID4+IHRoZSBm
YWxsaW5nIGVkZ2UgaW5kaWNhdGVzIHRoZSB1cHBlciA0IGJpdHMuCj4gPiA+Pgo+ID4gPj4gQXQg
MUcgc3BlZWQsIHdpdGggYSAiNCB0byA1bnMiIHNrZXcgaW4gdGhlIGNoaXAuIElmIHRoaXMgaXMg
YWNjdXJhdGUsCj4gPiA+PiB0aGVuIGludmVydGluZyB0aGUgY2xvY2sgYW5kIGFkZGluZyAxbnMg
b2YgYWRkaXRpb25hbCBza2V3IGJ5IHNvbWUKPiA+ID4+IG1lYW5zIChQQ0IgdHJhY2UsIG9yIGF0
IHRoZSBNQUMgb3IgUEhZKSB3aWxsIGdpdmUgdGhlIHJlcXVpcmVkIGNsb2NrCj4gPiA+PiBhdCB0
aGUgcmVjZWl2ZXIuCj4gPiA+Pgo+ID4gPiAKPiA+ID4gWWVzLCB0aGF0J3MgZXhhY3RseSB0aGUg
Y2FzZS4KPiA+ID4gCj4gPiA+PiBUaGUgdGltaW5nIHRhYmxlIGluIHRoZSBSR01JSSBzdGFuZGFy
ZCAoMy4zKSBhbGxvd3MgZm9yIFRjeWMgKHRoZQo+ID4gPj4gY2xvY2sgcmF0ZSkgdG8gYmUgc2Nh
bGVkLCBidXQgdGhlcmUgaXMgbm8gYWxsb3dhbmNlIGZvciBzY2FsaW5nCj4gPiA+PiBUc2tld1Ig
KHRoZSByZXF1aXJlZCAxIHRvIDIuNm5zIHNrZXcuKSBUaGlzIHNrZXcgcGFyYW1ldGVyIGlzCj4g
PiA+PiBmaXhlZC4KPiA+ID4+Cj4gPiA+PiBTbywgYXQgdGhlIG90aGVyIHNwZWVkcywgeW91IGFy
ZSBjb21wbGV0ZWx5IHVuYWJsZSB0byBtZWV0IHRoZSB0aW1pbmcKPiA+ID4+IHNwZWNpZmljYXRp
b24sIHdoZXRoZXIgaXJyZXNwZWN0aXZlIG9mIHRoZSBjbG9jayBpbnZlcnNpb24uIEluIGVmZmVj
dCwKPiA+ID4+IHRoZSBvbmx5IHNwZWVkIHRoYXQgeW91IGNhbiBtZWV0IHRoZSBzcGVjaWZpY2F0
aW9uIGlzIDFHLgo+ID4gPj4KPiA+ID4gCj4gPiA+IFRoZSB0aW1pbmcgdGFibGUgaW4gdGhlIFJH
TUlJIHN0YW5kYXJkKDMuMykgc2F5cyB0aGUgbWF4IHZhbHVlIG9mIFRza2V3Cj4gPiA+IGZvciAx
MC8xMDAgaXMgdW5zcGVjaWZpZWQuCj4gPiA+IFF1b3RhdGlvbjoibm90ZTE6IC4uLixGb3IgMTAv
MTAwIHRoZSBNYXggdmFsdWUgaXMgdW5zcGVjaWZpZWQuIgo+ID4gPiAKPiA+ID4gSSB0aGluayBm
b3IgMTAvMTAwLCB0aGUgIjQgdG8gNW5zIiBza2V3IGluIHRoZSBjaGlwIGRvZXNuJ3QgYnJlYWsg
dGhlCj4gPiA+IHN0YW5kYXJkLiBBdCAxMC8xMDAgc3BlZWRzLCBpdCBtZWV0cyB0aGUgdGltaW5n
IHNwZWNpZmljYXRpb24gd2l0aG91dAo+ID4gPiBoYXZpbmcgdG8gdG8gYWRkIGNsb2NrIGludmVy
c2lvbi4KPiA+ID4gSW4gcHJhY3RpY2UsIGl0IHdvcmtzIGF0IDEwLzEwMCBzcGVlZHMgaW4gdGhl
IHJnbWlpLWlkIHBoeSBtb2RlLgo+ID4gPiAKPiA+ID4+IFRodXMsIEkgdGhpbmsgdGhpcyBpcyBz
b21ldGhpbmcgdGhhdCBuZWVkcyBhIGxvdCBtb3JlIHRoYW4ganVzdCAiZG8KPiA+ID4+IHdlIG5l
ZWQgdG8gaW52ZXJ0IHRoZSBjbG9jayIuIFlvdSBhbHNvIG5lZWQgdG8gcHJldmVudCAxME0gYW5k
IDEwME0KPiA+ID4+IGJlaW5nIHN1cHBvcnRlZCBJTUhPLgo+ID4gPj4KPiAKPiA+IAo+ID4gSSBo
YWQgYW4gb2ZmbGluZSBkaXNjdXNzaW9uIHdpdGggWWFvIFppIGFuZCBvdGhlcnMgcmVnYXJkaW5n
IHRoaXMuIFdlIGZlZWwKPiA+IGxpa2UgdGhlIHByb3BlciB3YXkgZm9yIEVTV0lOIHRvIGRlYWwg
d2l0aCB0aGlzIGJyb2tlbiBldGgxIGlzIHRvIGhhdmUgYQo+ID4gZGlmZmVyZW50IGNvbXBhdGli
bGUgc3RyaW5nIGp1c3QgZm9yIGV0aDEsIHdoZXJlIGl0IGNhbiBiZSBhc3NvY2lhdGVkIHdpdGgK
PiA+IHBsYXRmb3JtIGRhdGEgd2l0aCBxdWlya3MgdG8gZG8gZXN3aW4scngtY2xrLWludmVydCBh
dCAxRy4gVGhlIHByb3BlcnR5IGlzCj4gPiB0aGVyZWZvcmUgbm90IHJlcXVpcmVkIHRvIGJlIGV4
cG9zZWQgaW4gRFQuIChQcmV0ZW5kIGl0IGNvbmZvcm1zIHRvIHNwZWMKPiA+IGZvciAxRykuIE5l
ZWQgY29uZmlybWF0aW9uIGZvciAxME0vMTAwTSwgdGhvdWdoLiBJIGRvdWJsZSBjaGVja2VkIExp
biBNaW4ncwo+ID4gY2xhaW0sIGFuZCBpbmRlZWQgdGhlIHNwZWMgc2F5cyAiRm9yIDEwLzEwMCB0
aGUgTWF4IHZhbHVlIGlzIHVuc3BlY2lmaWVkIjoKPiA+IGh0dHBzOi8vY29tbXVuaXR5Lm54cC5j
b20vcHdteHk4NzY1NC9hdHRhY2htZW50cy9wd214eTg3NjU0L2lteC1wcm9jZXNzb3JzLzIwNjU1
LzEvUkdNSUl2Ml8wX2ZpbmFsX2hwLnBkZgo+ID4gCj4gPiBUaG91Z2h0cz8KPiAKPiBJIGFncmVl
IHdpdGggeW91ciBhcHByb2FjaC4KPiAKCgpEbyB5b3UgdGhpbmsgaXQgd291bGQgYmUgcmVhc29u
YWJsZSBmb3IgZXRoMSB0byBoYXZlIGFub3RoZXIgZGlmZmVyZW50IGNvbXBhdGlibGUKc3RyaW5n
LCBzdWNoIGFzICJlc3dpbixlaWM3NzAwLXFvcy1ldGgtcXVpcmsiPwoKVGhhbmtzIGZvciB5b3Vy
IGNvbW1lbnRzLgoKUmVnYXJkcywKTGluIE1pbgo=

