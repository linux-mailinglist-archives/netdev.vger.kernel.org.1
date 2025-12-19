Return-Path: <netdev+bounces-245463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA83CCE327
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 02:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 013D430119ED
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98511272E43;
	Fri, 19 Dec 2025 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d26xa2iS"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE026E6E8
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109484; cv=none; b=QyuLvsMd81mLhStMN+PecN451X4Yv6Al+R81oXR7gq1TC/j2w2N465Vh4UkI3fJLGsLriVH7rhQYiGF9RQFNQ/WKt7TElYmeDd4Pesm2NcA68gCHoPEb9TzldtRjtK0xwD7XmIFZ456DRSqgFqTzilY9H3NJ2w0Ht/Hhht/q2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109484; c=relaxed/simple;
	bh=sud9FnwO9BL+wKkvkAhCVnzkdAA8JfkFKQ1Qn4qgzFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IYqnhnggs0B9Pfoq7OsG9dmSsDpvMNmyyQJYvKg327c3AquCtGwOC1eMDbbtq2AzKJadHdZ7wdAZpHgiXgve3BuxzWDquxDzvw9KsqnzxBqqW/YqlyyvBGfEdYK3LmFbKpoPesLTzKv6dq0YvkKo3HuERQH9CbfeJVZTcwZWbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d26xa2iS; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=sud9FnwO9BL+wKkvkAhCVnzkdAA8JfkFKQ1Qn4qgzFo=; b=d
	26xa2iSDx1aop0E7CWUI1++pg/87RsoONSwFe7Ot4ydGbBAXCoiqMUe58PXIj1To
	vXTbWf4i6eL6M6yupZz/ceZhfpDCCj96xyG+GDYMuMp4bMqUr/e0JCBg18iMeGJU
	8W+fk6uzMI4Tg1WrHcmUNm0za+0p6pZTnPEsJrvQ6Q=
Received: from slark_xiao$163.com (
 [2409:895a:3269:4362:4e3d:9a29:dfbc:7c35] ) by ajax-webmail-wmsvr-40-126
 (Coremail) ; Fri, 19 Dec 2025 09:56:59 +0800 (CST)
Date: Fri, 19 Dec 2025 09:56:59 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: "Sergey Ryazanov" <ryazanov.s.a@gmail.com>,
	"Daniele Palmas" <dnlplm@gmail.com>,
	"Muhammad Nuzaihan" <zaihan@unrealasia.net>,
	"Johannes Berg" <johannes@sipsolutions.net>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"Eric Dumazet" <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	"Qiang Yu" <quic_qianyu@quicinc.com>,
	"Manivannan Sadhasivam" <mani@kernel.org>,
	"Johan Hovold" <johan@kernel.org>
Subject: Re:Re:Re: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type
 support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <40f27470.6281.19ab4a6d782.Coremail.slark_xiao@163.com>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com>
 <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com>
 <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com>
 <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
 <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
 <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
 <CAFEp6-18FHj1Spw-=2j_cccmLTKHDS3uHR4ONw8geiTyWrxN2Q@mail.gmail.com>
 <16c0b1fa-9617-4ee1-b82f-e6237d7b5f6f@gmail.com>
 <CAGRyCJGHv19PJ+hyaTYf40GeGRHMXKi-qO0sgREnS3=7rfWGqA@mail.gmail.com>
 <90747682-22c6-4cb6-a6d1-3bef4aeab70e@gmail.com>
 <6d92e13b.5e8c.19a81315289.Coremail.slark_xiao@163.com>
 <CAFEp6-3pvrMmyRg37Vyv_NhXeOukY9A4TYBE9f42zMR5i04k_Q@mail.gmail.com>
 <40f27470.6281.19ab4a6d782.Coremail.slark_xiao@163.com>
X-NTES-SC: AL_Qu2dBP2btkwq7yaQY+kWnUwUgu46UMG3vf8u2IMbauU8vhrK4A4Ccn1yGVj06fq+Aiq+lhidUhxS0fhlVqiqdUcHVAlcyqnQrzUGCC51
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2273d069.3c59.19b345318b2.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:figvCgD3v6DrsERpwNA_AA--.11324W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvwvRNmlEsOviVAAA3T
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI1LTExLTI0IDE0OjU3OjA0LCAiU2xhcmsgWGlhbyIgPHNsYXJrX3hpYW9AMTYzLmNv
bT4gd3JvdGU6Cj4KPkF0IDIwMjUtMTEtMTkgMTk6Mjc6NDksICJMb2ljIFBvdWxhaW4iIDxsb2lj
LnBvdWxhaW5Ab3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6Cj4+SGkgU2xhcmssCj4+Cj4+T24gRnJp
LCBOb3YgMTQsIDIwMjUgYXQgODowOOKAr0FNIFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNv
bT4gd3JvdGU6Cj4+Pgo+Pj4KPj4+IEF0IDIwMjUtMTAtMTMgMDY6NTU6MjgsICJTZXJnZXkgUnlh
emFub3YiIDxyeWF6YW5vdi5zLmFAZ21haWwuY29tPiB3cm90ZToKPj4+ID5IaSBEYW5pZWxlLAo+
Pj4gPgo+Pj4gPk9uIDEwLzEwLzI1IDE2OjQ3LCBEYW5pZWxlIFBhbG1hcyB3cm90ZToKPj4+ID4+
IElsIGdpb3JubyBtZXIgOCBvdHQgMjAyNSBhbGxlIG9yZSAyMzowMCBTZXJnZXkgUnlhemFub3YK
Pj4+ID4+IDxyeWF6YW5vdi5zLmFAZ21haWwuY29tPiBoYSBzY3JpdHRvOgo+Pj4gPj4+IE9uIDEw
LzIvMjUgMTg6NDQsIExvaWMgUG91bGFpbiB3cm90ZToKPj4+ID4+Pj4gT24gVHVlLCBTZXAgMzAs
IDIwMjUgYXQgOToyMuKAr0FNIERhbmllbGUgUGFsbWFzIDxkbmxwbG1AZ21haWwuY29tPiB3cm90
ZToKPj4+ID4+Pj4gWy4uLl0KPj4+ID4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2Fu
L3d3YW5faHdzaW0uYyBiL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9od3NpbS5jCj4+PiA+Pj4+PiBp
bmRleCBhNzQ4YjNlYTE2MDIuLmU0YjFiYmZmOWFmMiAxMDA2NDQKPj4+ID4+Pj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L3d3YW4vd3dhbl9od3NpbS5jCj4+PiA+Pj4+PiArKysgYi9kcml2ZXJzL25ldC93
d2FuL3d3YW5faHdzaW0uYwo+Pj4gPj4+Pj4gQEAgLTIzNiw3ICsyMzYsNyBAQCBzdGF0aWMgdm9p
ZCB3d2FuX2h3c2ltX25tZWFfZW11bF90aW1lcihzdHJ1Y3QgdGltZXJfbGlzdCAqdCkKPj4+ID4+
Pj4+ICAgICAgICAgICAvKiA0My43NDc1NDcyMjI5ODkwOSBOIDExLjI1NzU5ODM1OTIyODc1IEUg
aW4gRE1NIGZvcm1hdCAqLwo+Pj4gPj4+Pj4gICAgICAgICAgIHN0YXRpYyBjb25zdCB1bnNpZ25l
ZCBpbnQgY29vcmRbNCAqIDJdID0geyA0MywgNDQsIDg1MjgsIDAsCj4+PiA+Pj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDExLCAxNSwgNDU1
OSwgMCB9Owo+Pj4gPj4+Pj4gLSAgICAgICBzdHJ1Y3Qgd3dhbl9od3NpbV9wb3J0ICpwb3J0ID0g
ZnJvbV90aW1lcihwb3J0LCB0LCBubWVhX2VtdWwudGltZXIpOwo+Pj4gPj4+Pj4gKyAgICAgICBz
dHJ1Y3Qgd3dhbl9od3NpbV9wb3J0ICpwb3J0ID0gdGltZXJfY29udGFpbmVyX29mKHBvcnQsIHQs
Cj4+PiA+Pj4+PiBubWVhX2VtdWwudGltZXIpOwo+Pj4gPj4+Pj4KPj4+ID4+Pj4+IGl0J3MgYmFz
aWNhbGx5IHdvcmtpbmcgZmluZSBpbiBvcGVyYXRpdmUgbW9kZSB0aG91Z2ggdGhlcmUncyBhbiBp
c3N1ZQo+Pj4gPj4+Pj4gYXQgdGhlIGhvc3Qgc2h1dGRvd24sIG5vdCBhYmxlIHRvIHByb3Blcmx5
IHRlcm1pbmF0ZS4KPj4+ID4+Pj4+Cj4+PiA+Pj4+PiBVbmZvcnR1bmF0ZWx5IEkgd2FzIG5vdCBh
YmxlIHRvIGdhdGhlciB1c2VmdWwgdGV4dCBsb2dzIGJlc2lkZXMgdGhlIHBpY3R1cmUgYXQKPj4+
ID4+Pj4+Cj4+PiA+Pj4+PiBodHRwczovL2RyaXZlLmdvb2dsZS5jb20vZmlsZS9kLzEzT2JXaWt1
aU1NVUVObDJhWmVyenhGQmc1N09CMUtOai92aWV3P3VzcD1zaGFyaW5nCj4+PiA+Pj4+Pgo+Pj4g
Pj4+Pj4gc2hvd2luZyBhbiBvb3BzIHdpdGggdGhlIGZvbGxvd2luZyBjYWxsIHN0YWNrOgo+Pj4g
Pj4+Pj4KPj4+ID4+Pj4+IF9fc2ltcGxlX3JlY3Vyc2l2ZV9yZW1vdmFsCj4+PiA+Pj4+PiBwcmVl
bXB0X2NvdW50X2FkZAo+Pj4gPj4+Pj4gX19wZnhfcmVtb3ZlX29uZQo+Pj4gPj4+Pj4gd3dhbl9y
ZW1vdmVfcG9ydAo+Pj4gPj4+Pj4gbWhpX3d3YW5fY3RybF9yZW1vdmUKPj4+ID4+Pj4+IG1oaV9k
cml2ZXJfcmVtb3ZlCj4+PiA+Pj4+PiBkZXZpY2VfcmVtb3ZlCj4+PiA+Pj4+PiBkZXZpY2VfZGVs
Cj4+PiA+Pj4+Pgo+Pj4gPj4+Pj4gYnV0IHRoZSBpc3N1ZSBpcyBzeXN0ZW1hdGljLiBBbnkgaWRl
YT8KPj4+ID4+Pj4+Cj4+PiA+Pj4+PiBBdCB0aGUgbW9tZW50IEkgZG9uJ3QgaGF2ZSB0aGUgdGlt
ZSB0byBkZWJ1ZyB0aGlzIGRlZXBlciwgSSBkb24ndCBldmVuCj4+PiA+Pj4+PiBleGNsdWRlIHRo
ZSBjaGFuY2UgdGhhdCBpdCBjb3VsZCBiZSBzb21laG93IHJlbGF0ZWQgdG8gdGhlIG1vZGVtLiBJ
Cj4+PiA+Pj4+PiB3b3VsZCBsaWtlIHRvIGZ1cnRoZXIgbG9vayBhdCB0aGlzLCBidXQgSSdtIG5v
dCBzdXJlIGV4YWN0bHkgd2hlbiBJCj4+PiA+Pj4+PiBjYW4uLi4uCj4+PiA+Pj4+Cj4+PiA+Pj4+
IFRoYW5rcyBhIGxvdCBmb3IgdGVzdGluZywgU2VyZ2V5LCBkbyB5b3Uga25vdyB3aGF0IGlzIHdy
b25nIHdpdGggcG9ydCByZW1vdmFsPwo+Pj4gPj4+Cj4+PiA+Pj4gRGFuaWVsZSwgdGhhbmtzIGEg
bG90IGZvciB2ZXJpZnlpbmcgdGhlIHByb3Bvc2FsIG9uIGEgcmVhbCBoYXJkd2FyZSBhbmQKPj4+
ID4+PiBzaGFyaW5nIHRoZSBidWlsZCBmaXguCj4+PiA+Pj4KPj4+ID4+PiBVbmZvcnR1bmF0ZWx5
LCBJIHVuYWJsZSB0byByZXByb2R1Y2UgdGhlIGNyYXNoLiBJIGhhdmUgdHJpZWQgbXVsdGlwbGUK
Pj4+ID4+PiB0aW1lcyB0byByZWJvb3QgYSBWTSBydW5uaW5nIHRoZSBzaW11bGF0b3IgbW9kdWxl
IGV2ZW4gd2l0aCBvcGVuZWQgR05TUwo+Pj4gPj4+IGRldmljZS4gTm8gbHVjay4gSXQgcmVib290
cyBhbmQgc2h1dGRvd25zIHNtb290aGx5Lgo+Pj4gPj4+Cj4+PiA+Pgo+Pj4gPj4gSSd2ZSBwcm9i
YWJseSBmaWd1cmVkIG91dCB3aGF0J3MgaGFwcGVuaW5nLgo+Pj4gPj4KPj4+ID4+IFRoZSBwcm9i
bGVtIHNlZW1zIHRoYXQgdGhlIGduc3MgZGV2aWNlIGlzIG5vdCBjb25zaWRlcmVkIGEgd3dhbl9j
aGlsZAo+Pj4gPj4gYnkgaXNfd3dhbl9jaGlsZCBhbmQgdGhpcyBtYWtlcyBkZXZpY2VfdW5yZWdp
c3RlciBpbiB3d2FuX3JlbW92ZV9kZXYKPj4+ID4+IHRvIGJlIGNhbGxlZCB0d2ljZS4KPj4+ID4+
Cj4+PiA+PiBGb3IgdGVzdGluZyBJJ3ZlIG92ZXJ3cml0dGVuIHRoZSBnbnNzIGRldmljZSBjbGFz
cyB3aXRoIHRoZSBmb2xsb3dpbmcgaGFjazoKPj4+ID4+Cj4+PiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd3dhbi93d2FuX2NvcmUuYyBiL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMK
Pj4+ID4+IGluZGV4IDRkMjlmYjhjMTZiOC4uMzJiM2Y3YzRhNDAyIDEwMDY0NAo+Pj4gPj4gLS0t
IGEvZHJpdmVycy9uZXQvd3dhbi93d2FuX2NvcmUuYwo+Pj4gPj4gKysrIGIvZHJpdmVycy9uZXQv
d3dhbi93d2FuX2NvcmUuYwo+Pj4gPj4gQEAgLTU5OSw2ICs1OTksNyBAQCBzdGF0aWMgaW50IHd3
YW5fcG9ydF9yZWdpc3Rlcl9nbnNzKHN0cnVjdCB3d2FuX3BvcnQgKnBvcnQpCj4+PiA+PiAgICAg
ICAgICAgICAgICAgIGduc3NfcHV0X2RldmljZShnZGV2KTsKPj4+ID4+ICAgICAgICAgICAgICAg
ICAgcmV0dXJuIGVycjsKPj4+ID4+ICAgICAgICAgIH0KPj4+ID4+ICsgICAgICAgZ2Rldi0+ZGV2
LmNsYXNzID0gJnd3YW5fY2xhc3M7Cj4+PiA+Pgo+Pj4gPj4gICAgICAgICAgZGV2X2luZm8oJnd3
YW5kZXYtPmRldiwgInBvcnQgJXMgYXR0YWNoZWRcbiIsIGRldl9uYW1lKCZnZGV2LT5kZXYpKTsK
Pj4+ID4+Cj4+PiA+PiBhbmQgbm93IHRoZSBzeXN0ZW0gcG93ZXJzIG9mZiB3aXRob3V0IGlzc3Vl
cy4KPj4+ID4+Cj4+PiA+PiBTbywgbm90IHN1cmUgaG93IHRvIGZpeCBpdCBwcm9wZXJseSwgYnV0
IGF0IGxlYXN0IGRvZXMgdGhlIGFuYWx5c2lzCj4+PiA+PiBtYWtlIHNlbnNlIHRvIHlvdT8KPj4+
ID4KPj4+ID5OaWNlIGNhdGNoISBJIGhhZCBhIGRvdWJ0IHJlZ2FyZGluZyBjb3JyZWN0IGNoaWxk
IHBvcnQgZGV0ZWN0aW9uLiBMZXQgbWUKPj4+ID5kb3VibGUgY2hlY2ssIGFuZCB0aGFuayB5b3Ug
Zm9yIHBvaW50aW5nIG1lIHRvIHRoZSBwb3NzaWJsZSBzb3VyY2Ugb2YKPj4+ID5pc3N1ZXMuCj4+
PiA+Cj4+PiA+LS0KPj4+ID5TZXJnZXkKPj4+Cj4+PiBIaSBTZXJnZXksCj4+PiBTb3JyeSBmb3Ig
Ym90aGVyaW5nIHRoaXMgdGhyZWFkIGFnYWluLgo+Pj4gRG8gd2UgaGF2ZSBhbnkgdXBkYXRlcyBv
biB0aGlzIHBvdGVudGlhbCBpc3N1ZT8gSWYgdGhpcyBpc3N1ZSBpcyBub3QgYSBiaWcgcHJvYmxl
bSwKPj4+IENvdWxkIHdlIGNvbW1pdCB0aGVzZSBwYXRjaGVzIGludG8gYSBicmFuY2ggdGhlbiBl
dmVyeSBvbmUgY291bGQgaGVscCBkZWJ1Zwo+Pj4gaXQgYmFzZWQgb24gdGhpcyBiYXNlIGNvZGU/
Cj4+PiBJIHRoaW5rIHdlIHNoYWxsIGhhdmUgYSBiYXNlIHRvIGRldmVsb3AuIE5vIGNvZGUgaXMg
cGVyZmVjdC4KPj4KPj5XZSBzaG91bGRu4oCZdCBtZXJnZSBhIHNlcmllcyB0aGF0IGlzIGtub3du
IHRvIGJlIGJyb2tlbiBvciBjYXVzZXMKPj5jcmFzaGVzLiBIb3dldmVyLCBiYXNlZCBvbiBEYW5p
ZWxl4oCZcyBmZWVkYmFjaywgdGhlIHNlcmllcyBjYW4gYmUKPj5maXhlZC4KPj4KPj5Zb3UgY2Fu
IGNoZWNrIHRoZSB0ZW50YXRpdmUgZml4IGhlcmU6Cj4+aHR0cHM6Ly9naXRodWIuY29tL2xvaWNw
b3VsYWluL2xpbnV4L2NvbW1pdHMvd3dhbi9wZW5kaW5nCj4+VGhpcyBicmFuY2ggaW5jbHVkZXMg
U2VyZ2V54oCZcyBwYXRjaCBmcm9tIHRoZSBtYWlsaW5nIGxpc3QgYWxvbmcgd2l0aCBhCj4+cHJv
cG9zZWQgZml4Lgo+Pgo+PklmIHlvdSBjYW4gdGVzdCBpdCBvbiB5b3VyIHNpZGUsIHRoYXQgd291
bGQgYmUgdmVyeSBoZWxwZnVsLgo+Pgo+SSB3aWxsIGhhdmUgYSB0cnkgYmFzZWQgb24gdGhpcyBi
cmFuY2ggb24gb3VyIHByb2R1Y3RzLgo+TGV0J3Mgc3RheSBpbiB0b3VjaC4KPgo+PkFsc28sIGl0
4oCZcyBmaW5lIHRvIHJlc3VibWl0IHRoZSBjb3JyZWN0ZWQgc2VyaWVzIHdpdGhvdXQgdGhlIFJG
QyB0YWcsCj4+YXMgbG9uZyBhcyB5b3Uga2VlcCBTZXJnZXkgYXMgdGhlIG9yaWdpbmFsIGF1dGhv
ci4KPj4KPj5SZWdhcmRzLAo+PkxvaWMKSGkgTG9pYywKV2UganVzdCB2ZXJpZmllZCB0aGlzIHBh
dGNoIG9uIG91ciBNSEkgZGV2aWNlIGFuZCBpdCB3b3JrcyB3ZWxsIHVudGlsIG5vdyBmb3IKYmFz
aWMgZnVuY3Rpb24gZXhjZXB0IGEgY2hhbmdlIGluIGRyaXZlcnMvbmV0L3d3YW4vbWhpX3d3YW5f
Y3RybC5jOgoKICAgICAgICAgIHsgLmNoYW4gPSAiRklSRUhPU0UiLCAuZHJpdmVyX2RhdGEgPSBX
V0FOX1BPUlRfRklSRUhPU0UgfSwKKyAgICAgICAgeyAuY2hhbiA9ICJOTUVBIiwgLmRyaXZlcl9k
YXRhID0gV1dBTl9QT1JUX05NRUEgfSwKCk1heSBJIGFkZCB0aGlzIGludG8geW91ciBicmFuY2gg
YW5kIHRoZW4geW91IGNhbiBtZXJnZSBpbnRvIG5ldCA/CgpUaGFua3M=

