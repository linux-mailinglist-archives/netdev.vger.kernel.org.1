Return-Path: <netdev+bounces-241096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F6C7F22F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 07:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A32934E1554
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 06:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3CF2DA760;
	Mon, 24 Nov 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Qt+LLT0z"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE312BE64A
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967536; cv=none; b=IDpJjr0PFMmZFPSRflmNWYXhcBsJC3chyE0D5s7cey36DV+7GON8ypi9nEn6kviCCpAGTA0SFMyATD5gR1Jtpy2ZBd3ZvTWlTogIo1quEYdXnwi+PaHMIU22qbkzjiKg9fALVfVPdnL6efpz28zwYBHTd7SIE46nGCWl1gdZdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967536; c=relaxed/simple;
	bh=l8eiXO8rLwx4DAVLn5/wQcVrlKf9yu8RCDkwk1D7Tn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Mpdcdct97Oiuy36N997LsfGeYHOjkDGCBJ1WyZT6gXT0yG4j65vd7NdCFqmJcynejz4x/z0hmClmnM4a2H9tyOQB8JZZV++jVPbbedakb/lEp1ozCB1xUi5RxI6R8DNcpm1Dj8pY+sUq+RSnl7UUnnCxOoBbCvRHGSYwdnrHCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Qt+LLT0z reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=FWluz43lSYY1ueJhMsEr8zx/CyCgc5IJD4LBhmShDrw=; b=Q
	t+LLT0z8CAS/HIRH0luLVRaTsdlKBDWizFmfnxv9JpzxVp1XVPufJJeAn0eARy95
	pOaZFsTU4Y28+pGP28mAzAOoUUVKIcatbymp6yJf089bR8g5k+6/WmZ24zMaCMU1
	vxH2cpSymWUJkKE8nyoftPFbbBUGg0Wze90sqjW+UA=
Received: from slark_xiao$163.com ( [112.97.80.230] ) by
 ajax-webmail-wmsvr-40-108 (Coremail) ; Mon, 24 Nov 2025 14:57:04 +0800
 (CST)
Date: Mon, 24 Nov 2025 14:57:04 +0800 (CST)
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
Subject: Re:Re: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAFEp6-3pvrMmyRg37Vyv_NhXeOukY9A4TYBE9f42zMR5i04k_Q@mail.gmail.com>
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
X-NTES-SC: AL_Qu2dAfWduEwp4iOfYekfmk8Sg+84W8K3v/0v1YVQOpF8jCLpwR86WnZKGEDdzciXDzKFlxqzVSpcwOV9UKJ3Xpk1ASlWppjS49Nl4we0d3IYGQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <40f27470.6281.19ab4a6d782.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bCgvCgDnz5fAASRpcvAoAA--.30W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRUQZGkj8biDYAABsZ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTEtMTkgMTk6Mjc6NDksICJMb2ljIFBvdWxhaW4iIDxsb2ljLnBvdWxhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4gd3JvdGU6Cj5IaSBTbGFyaywKPgo+T24gRnJpLCBOb3YgMTQsIDIwMjUg
YXQgODowOOKAr0FNIFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+
Cj4+IEF0IDIwMjUtMTAtMTMgMDY6NTU6MjgsICJTZXJnZXkgUnlhemFub3YiIDxyeWF6YW5vdi5z
LmFAZ21haWwuY29tPiB3cm90ZToKPj4gPkhpIERhbmllbGUsCj4+ID4KPj4gPk9uIDEwLzEwLzI1
IDE2OjQ3LCBEYW5pZWxlIFBhbG1hcyB3cm90ZToKPj4gPj4gSWwgZ2lvcm5vIG1lciA4IG90dCAy
MDI1IGFsbGUgb3JlIDIzOjAwIFNlcmdleSBSeWF6YW5vdgo+PiA+PiA8cnlhemFub3Yucy5hQGdt
YWlsLmNvbT4gaGEgc2NyaXR0bzoKPj4gPj4+IE9uIDEwLzIvMjUgMTg6NDQsIExvaWMgUG91bGFp
biB3cm90ZToKPj4gPj4+PiBPbiBUdWUsIFNlcCAzMCwgMjAyNSBhdCA5OjIy4oCvQU0gRGFuaWVs
ZSBQYWxtYXMgPGRubHBsbUBnbWFpbC5jb20+IHdyb3RlOgo+PiA+Pj4+IFsuLi5dCj4+ID4+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL3d3YW5faHdzaW0uYyBiL2RyaXZlcnMvbmV0
L3d3YW4vd3dhbl9od3NpbS5jCj4+ID4+Pj4+IGluZGV4IGE3NDhiM2VhMTYwMi4uZTRiMWJiZmY5
YWYyIDEwMDY0NAo+PiA+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC93d2FuL3d3YW5faHdzaW0uYwo+
PiA+Pj4+PiArKysgYi9kcml2ZXJzL25ldC93d2FuL3d3YW5faHdzaW0uYwo+PiA+Pj4+PiBAQCAt
MjM2LDcgKzIzNiw3IEBAIHN0YXRpYyB2b2lkIHd3YW5faHdzaW1fbm1lYV9lbXVsX3RpbWVyKHN0
cnVjdCB0aW1lcl9saXN0ICp0KQo+PiA+Pj4+PiAgICAgICAgICAgLyogNDMuNzQ3NTQ3MjIyOTg5
MDkgTiAxMS4yNTc1OTgzNTkyMjg3NSBFIGluIERNTSBmb3JtYXQgKi8KPj4gPj4+Pj4gICAgICAg
ICAgIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBpbnQgY29vcmRbNCAqIDJdID0geyA0MywgNDQsIDg1
MjgsIDAsCj4+ID4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMTEsIDE1LCA0NTU5LCAwIH07Cj4+ID4+Pj4+IC0gICAgICAgc3RydWN0IHd3
YW5faHdzaW1fcG9ydCAqcG9ydCA9IGZyb21fdGltZXIocG9ydCwgdCwgbm1lYV9lbXVsLnRpbWVy
KTsKPj4gPj4+Pj4gKyAgICAgICBzdHJ1Y3Qgd3dhbl9od3NpbV9wb3J0ICpwb3J0ID0gdGltZXJf
Y29udGFpbmVyX29mKHBvcnQsIHQsCj4+ID4+Pj4+IG5tZWFfZW11bC50aW1lcik7Cj4+ID4+Pj4+
Cj4+ID4+Pj4+IGl0J3MgYmFzaWNhbGx5IHdvcmtpbmcgZmluZSBpbiBvcGVyYXRpdmUgbW9kZSB0
aG91Z2ggdGhlcmUncyBhbiBpc3N1ZQo+PiA+Pj4+PiBhdCB0aGUgaG9zdCBzaHV0ZG93biwgbm90
IGFibGUgdG8gcHJvcGVybHkgdGVybWluYXRlLgo+PiA+Pj4+Pgo+PiA+Pj4+PiBVbmZvcnR1bmF0
ZWx5IEkgd2FzIG5vdCBhYmxlIHRvIGdhdGhlciB1c2VmdWwgdGV4dCBsb2dzIGJlc2lkZXMgdGhl
IHBpY3R1cmUgYXQKPj4gPj4+Pj4KPj4gPj4+Pj4gaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2Zp
bGUvZC8xM09iV2lrdWlNTVVFTmwyYVplcnp4RkJnNTdPQjFLTmovdmlldz91c3A9c2hhcmluZwo+
PiA+Pj4+Pgo+PiA+Pj4+PiBzaG93aW5nIGFuIG9vcHMgd2l0aCB0aGUgZm9sbG93aW5nIGNhbGwg
c3RhY2s6Cj4+ID4+Pj4+Cj4+ID4+Pj4+IF9fc2ltcGxlX3JlY3Vyc2l2ZV9yZW1vdmFsCj4+ID4+
Pj4+IHByZWVtcHRfY291bnRfYWRkCj4+ID4+Pj4+IF9fcGZ4X3JlbW92ZV9vbmUKPj4gPj4+Pj4g
d3dhbl9yZW1vdmVfcG9ydAo+PiA+Pj4+PiBtaGlfd3dhbl9jdHJsX3JlbW92ZQo+PiA+Pj4+PiBt
aGlfZHJpdmVyX3JlbW92ZQo+PiA+Pj4+PiBkZXZpY2VfcmVtb3ZlCj4+ID4+Pj4+IGRldmljZV9k
ZWwKPj4gPj4+Pj4KPj4gPj4+Pj4gYnV0IHRoZSBpc3N1ZSBpcyBzeXN0ZW1hdGljLiBBbnkgaWRl
YT8KPj4gPj4+Pj4KPj4gPj4+Pj4gQXQgdGhlIG1vbWVudCBJIGRvbid0IGhhdmUgdGhlIHRpbWUg
dG8gZGVidWcgdGhpcyBkZWVwZXIsIEkgZG9uJ3QgZXZlbgo+PiA+Pj4+PiBleGNsdWRlIHRoZSBj
aGFuY2UgdGhhdCBpdCBjb3VsZCBiZSBzb21laG93IHJlbGF0ZWQgdG8gdGhlIG1vZGVtLiBJCj4+
ID4+Pj4+IHdvdWxkIGxpa2UgdG8gZnVydGhlciBsb29rIGF0IHRoaXMsIGJ1dCBJJ20gbm90IHN1
cmUgZXhhY3RseSB3aGVuIEkKPj4gPj4+Pj4gY2FuLi4uLgo+PiA+Pj4+Cj4+ID4+Pj4gVGhhbmtz
IGEgbG90IGZvciB0ZXN0aW5nLCBTZXJnZXksIGRvIHlvdSBrbm93IHdoYXQgaXMgd3Jvbmcgd2l0
aCBwb3J0IHJlbW92YWw/Cj4+ID4+Pgo+PiA+Pj4gRGFuaWVsZSwgdGhhbmtzIGEgbG90IGZvciB2
ZXJpZnlpbmcgdGhlIHByb3Bvc2FsIG9uIGEgcmVhbCBoYXJkd2FyZSBhbmQKPj4gPj4+IHNoYXJp
bmcgdGhlIGJ1aWxkIGZpeC4KPj4gPj4+Cj4+ID4+PiBVbmZvcnR1bmF0ZWx5LCBJIHVuYWJsZSB0
byByZXByb2R1Y2UgdGhlIGNyYXNoLiBJIGhhdmUgdHJpZWQgbXVsdGlwbGUKPj4gPj4+IHRpbWVz
IHRvIHJlYm9vdCBhIFZNIHJ1bm5pbmcgdGhlIHNpbXVsYXRvciBtb2R1bGUgZXZlbiB3aXRoIG9w
ZW5lZCBHTlNTCj4+ID4+PiBkZXZpY2UuIE5vIGx1Y2suIEl0IHJlYm9vdHMgYW5kIHNodXRkb3du
cyBzbW9vdGhseS4KPj4gPj4+Cj4+ID4+Cj4+ID4+IEkndmUgcHJvYmFibHkgZmlndXJlZCBvdXQg
d2hhdCdzIGhhcHBlbmluZy4KPj4gPj4KPj4gPj4gVGhlIHByb2JsZW0gc2VlbXMgdGhhdCB0aGUg
Z25zcyBkZXZpY2UgaXMgbm90IGNvbnNpZGVyZWQgYSB3d2FuX2NoaWxkCj4+ID4+IGJ5IGlzX3d3
YW5fY2hpbGQgYW5kIHRoaXMgbWFrZXMgZGV2aWNlX3VucmVnaXN0ZXIgaW4gd3dhbl9yZW1vdmVf
ZGV2Cj4+ID4+IHRvIGJlIGNhbGxlZCB0d2ljZS4KPj4gPj4KPj4gPj4gRm9yIHRlc3RpbmcgSSd2
ZSBvdmVyd3JpdHRlbiB0aGUgZ25zcyBkZXZpY2UgY2xhc3Mgd2l0aCB0aGUgZm9sbG93aW5nIGhh
Y2s6Cj4+ID4+Cj4+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5j
IGIvZHJpdmVycy9uZXQvd3dhbi93d2FuX2NvcmUuYwo+PiA+PiBpbmRleCA0ZDI5ZmI4YzE2Yjgu
LjMyYjNmN2M0YTQwMiAxMDA2NDQKPj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvd3dhbi93d2FuX2Nv
cmUuYwo+PiA+PiArKysgYi9kcml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jCj4+ID4+IEBAIC01
OTksNiArNTk5LDcgQEAgc3RhdGljIGludCB3d2FuX3BvcnRfcmVnaXN0ZXJfZ25zcyhzdHJ1Y3Qg
d3dhbl9wb3J0ICpwb3J0KQo+PiA+PiAgICAgICAgICAgICAgICAgIGduc3NfcHV0X2RldmljZShn
ZGV2KTsKPj4gPj4gICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+PiA+PiAgICAgICAgICB9
Cj4+ID4+ICsgICAgICAgZ2Rldi0+ZGV2LmNsYXNzID0gJnd3YW5fY2xhc3M7Cj4+ID4+Cj4+ID4+
ICAgICAgICAgIGRldl9pbmZvKCZ3d2FuZGV2LT5kZXYsICJwb3J0ICVzIGF0dGFjaGVkXG4iLCBk
ZXZfbmFtZSgmZ2Rldi0+ZGV2KSk7Cj4+ID4+Cj4+ID4+IGFuZCBub3cgdGhlIHN5c3RlbSBwb3dl
cnMgb2ZmIHdpdGhvdXQgaXNzdWVzLgo+PiA+Pgo+PiA+PiBTbywgbm90IHN1cmUgaG93IHRvIGZp
eCBpdCBwcm9wZXJseSwgYnV0IGF0IGxlYXN0IGRvZXMgdGhlIGFuYWx5c2lzCj4+ID4+IG1ha2Ug
c2Vuc2UgdG8geW91Pwo+PiA+Cj4+ID5OaWNlIGNhdGNoISBJIGhhZCBhIGRvdWJ0IHJlZ2FyZGlu
ZyBjb3JyZWN0IGNoaWxkIHBvcnQgZGV0ZWN0aW9uLiBMZXQgbWUKPj4gPmRvdWJsZSBjaGVjaywg
YW5kIHRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgbWUgdG8gdGhlIHBvc3NpYmxlIHNvdXJjZSBvZgo+
PiA+aXNzdWVzLgo+PiA+Cj4+ID4tLQo+PiA+U2VyZ2V5Cj4+Cj4+IEhpIFNlcmdleSwKPj4gU29y
cnkgZm9yIGJvdGhlcmluZyB0aGlzIHRocmVhZCBhZ2Fpbi4KPj4gRG8gd2UgaGF2ZSBhbnkgdXBk
YXRlcyBvbiB0aGlzIHBvdGVudGlhbCBpc3N1ZT8gSWYgdGhpcyBpc3N1ZSBpcyBub3QgYSBiaWcg
cHJvYmxlbSwKPj4gQ291bGQgd2UgY29tbWl0IHRoZXNlIHBhdGNoZXMgaW50byBhIGJyYW5jaCB0
aGVuIGV2ZXJ5IG9uZSBjb3VsZCBoZWxwIGRlYnVnCj4+IGl0IGJhc2VkIG9uIHRoaXMgYmFzZSBj
b2RlPwo+PiBJIHRoaW5rIHdlIHNoYWxsIGhhdmUgYSBiYXNlIHRvIGRldmVsb3AuIE5vIGNvZGUg
aXMgcGVyZmVjdC4KPgo+V2Ugc2hvdWxkbuKAmXQgbWVyZ2UgYSBzZXJpZXMgdGhhdCBpcyBrbm93
biB0byBiZSBicm9rZW4gb3IgY2F1c2VzCj5jcmFzaGVzLiBIb3dldmVyLCBiYXNlZCBvbiBEYW5p
ZWxl4oCZcyBmZWVkYmFjaywgdGhlIHNlcmllcyBjYW4gYmUKPmZpeGVkLgo+Cj5Zb3UgY2FuIGNo
ZWNrIHRoZSB0ZW50YXRpdmUgZml4IGhlcmU6Cj5odHRwczovL2dpdGh1Yi5jb20vbG9pY3BvdWxh
aW4vbGludXgvY29tbWl0cy93d2FuL3BlbmRpbmcKPlRoaXMgYnJhbmNoIGluY2x1ZGVzIFNlcmdl
eeKAmXMgcGF0Y2ggZnJvbSB0aGUgbWFpbGluZyBsaXN0IGFsb25nIHdpdGggYQo+cHJvcG9zZWQg
Zml4Lgo+Cj5JZiB5b3UgY2FuIHRlc3QgaXQgb24geW91ciBzaWRlLCB0aGF0IHdvdWxkIGJlIHZl
cnkgaGVscGZ1bC4KPgpJIHdpbGwgaGF2ZSBhIHRyeSBiYXNlZCBvbiB0aGlzIGJyYW5jaCBvbiBv
dXIgcHJvZHVjdHMuCkxldCdzIHN0YXkgaW4gdG91Y2guCgo+QWxzbywgaXTigJlzIGZpbmUgdG8g
cmVzdWJtaXQgdGhlIGNvcnJlY3RlZCBzZXJpZXMgd2l0aG91dCB0aGUgUkZDIHRhZywKPmFzIGxv
bmcgYXMgeW91IGtlZXAgU2VyZ2V5IGFzIHRoZSBvcmlnaW5hbCBhdXRob3IuCj4KPlJlZ2FyZHMs
Cj5Mb2ljCg==

