Return-Path: <netdev+bounces-238592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4921FC5BB31
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A89D84E8DE3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF0E23184F;
	Fri, 14 Nov 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="D03SKKrU"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26322CBD7
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104152; cv=none; b=kooLJHpaVuML889rs1EuVXwEXGvbILGt6wM9CzlLVDe9kcboHsLtYTlbdUbjhlnUBKtSN1RCc9ITaTGBh+pnHE2yAra67e6jvH0dJLPYjpEivcuuRCZx82HwUJxxcSkzyzrkDBRLMiki4LUEeFUZL8WyWyOCRIHGVWg3rbG1Wwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104152; c=relaxed/simple;
	bh=JQgbjZaVTvwcqkiwnlMdG9ssBF7w9FqqzyymiTv/M9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hcW8NpdlKgzYKpqh5Ke1rA3MrfLxeWBtJ5eFimvyozMwvXOhDgW5ckvSL59pZiaIAjxSO0Ft1G8dVv4P1BL4avRwtwfu1gC6pUJ0bE4XFW3Osymv15/Xc4lqRQey0qs4C3xmY+jAmbIivfsulF6QMdjbH7dpsv38q315VT1JHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=D03SKKrU reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=So2aVsA3sy3c3wHNpVu6q3eXatAuG8FLmwddfDjW35Q=; b=D
	03SKKrUpC8XYSewaBICioyNDr2/1npHPEQ5kgKrsGghgW4azv5dgrf8TFyz2dZ0A
	6BifzM+O7AUDRlRhwRtcMako3BG8kv/C8EapgC1iyfpMRtVIlwzjFENahBse/MBU
	MPJx/xI5k2BX5sp0AV61y0ixs1A5qKMAYnbwyX+bvQ=
Received: from slark_xiao$163.com (
 [2408:8459:3833:1c9c:6275:197f:68de:232a] ) by ajax-webmail-wmsvr-40-103
 (Coremail) ; Fri, 14 Nov 2025 15:08:04 +0800 (CST)
Date: Fri, 14 Nov 2025 15:08:04 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Sergey Ryazanov" <ryazanov.s.a@gmail.com>
Cc: "Daniele Palmas" <dnlplm@gmail.com>,
	"Loic Poulain" <loic.poulain@oss.qualcomm.com>,
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
Subject: Re:Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <90747682-22c6-4cb6-a6d1-3bef4aeab70e@gmail.com>
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
X-NTES-SC: AL_Qu2dAf2bu0gj4iaYYOkfmk8Sg+84W8K3v/0v1YVQOpF8jC3p8SAPVmJCF2nL7viUJDiLrQGsYARo++t2UIZnX44EzPhzV9RK2H+Y+JBWirpMWw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6d92e13b.5e8c.19a81315289.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgDXn_xU1RZpwFYiAA--.1888W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRAGZGkWdWWdOwAEsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTAtMTMgMDY6NTU6MjgsICJTZXJnZXkgUnlhemFub3YiIDxyeWF6YW5vdi5zLmFA
Z21haWwuY29tPiB3cm90ZToKPkhpIERhbmllbGUsCj4KPk9uIDEwLzEwLzI1IDE2OjQ3LCBEYW5p
ZWxlIFBhbG1hcyB3cm90ZToKPj4gSWwgZ2lvcm5vIG1lciA4IG90dCAyMDI1IGFsbGUgb3JlIDIz
OjAwIFNlcmdleSBSeWF6YW5vdgo+PiA8cnlhemFub3Yucy5hQGdtYWlsLmNvbT4gaGEgc2NyaXR0
bzoKPj4+IE9uIDEwLzIvMjUgMTg6NDQsIExvaWMgUG91bGFpbiB3cm90ZToKPj4+PiBPbiBUdWUs
IFNlcCAzMCwgMjAyNSBhdCA5OjIy4oCvQU0gRGFuaWVsZSBQYWxtYXMgPGRubHBsbUBnbWFpbC5j
b20+IHdyb3RlOgo+Pj4+IFsuLi5dCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2Fu
L3d3YW5faHdzaW0uYyBiL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9od3NpbS5jCj4+Pj4+IGluZGV4
IGE3NDhiM2VhMTYwMi4uZTRiMWJiZmY5YWYyIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL25l
dC93d2FuL3d3YW5faHdzaW0uYwo+Pj4+PiArKysgYi9kcml2ZXJzL25ldC93d2FuL3d3YW5faHdz
aW0uYwo+Pj4+PiBAQCAtMjM2LDcgKzIzNiw3IEBAIHN0YXRpYyB2b2lkIHd3YW5faHdzaW1fbm1l
YV9lbXVsX3RpbWVyKHN0cnVjdCB0aW1lcl9saXN0ICp0KQo+Pj4+PiAgICAgICAgICAgLyogNDMu
NzQ3NTQ3MjIyOTg5MDkgTiAxMS4yNTc1OTgzNTkyMjg3NSBFIGluIERNTSBmb3JtYXQgKi8KPj4+
Pj4gICAgICAgICAgIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBpbnQgY29vcmRbNCAqIDJdID0geyA0
MywgNDQsIDg1MjgsIDAsCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgMTEsIDE1LCA0NTU5LCAwIH07Cj4+Pj4+IC0gICAgICAgc3RydWN0
IHd3YW5faHdzaW1fcG9ydCAqcG9ydCA9IGZyb21fdGltZXIocG9ydCwgdCwgbm1lYV9lbXVsLnRp
bWVyKTsKPj4+Pj4gKyAgICAgICBzdHJ1Y3Qgd3dhbl9od3NpbV9wb3J0ICpwb3J0ID0gdGltZXJf
Y29udGFpbmVyX29mKHBvcnQsIHQsCj4+Pj4+IG5tZWFfZW11bC50aW1lcik7Cj4+Pj4+Cj4+Pj4+
IGl0J3MgYmFzaWNhbGx5IHdvcmtpbmcgZmluZSBpbiBvcGVyYXRpdmUgbW9kZSB0aG91Z2ggdGhl
cmUncyBhbiBpc3N1ZQo+Pj4+PiBhdCB0aGUgaG9zdCBzaHV0ZG93biwgbm90IGFibGUgdG8gcHJv
cGVybHkgdGVybWluYXRlLgo+Pj4+Pgo+Pj4+PiBVbmZvcnR1bmF0ZWx5IEkgd2FzIG5vdCBhYmxl
IHRvIGdhdGhlciB1c2VmdWwgdGV4dCBsb2dzIGJlc2lkZXMgdGhlIHBpY3R1cmUgYXQKPj4+Pj4K
Pj4+Pj4gaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8xM09iV2lrdWlNTVVFTmwyYVpl
cnp4RkJnNTdPQjFLTmovdmlldz91c3A9c2hhcmluZwo+Pj4+Pgo+Pj4+PiBzaG93aW5nIGFuIG9v
cHMgd2l0aCB0aGUgZm9sbG93aW5nIGNhbGwgc3RhY2s6Cj4+Pj4+Cj4+Pj4+IF9fc2ltcGxlX3Jl
Y3Vyc2l2ZV9yZW1vdmFsCj4+Pj4+IHByZWVtcHRfY291bnRfYWRkCj4+Pj4+IF9fcGZ4X3JlbW92
ZV9vbmUKPj4+Pj4gd3dhbl9yZW1vdmVfcG9ydAo+Pj4+PiBtaGlfd3dhbl9jdHJsX3JlbW92ZQo+
Pj4+PiBtaGlfZHJpdmVyX3JlbW92ZQo+Pj4+PiBkZXZpY2VfcmVtb3ZlCj4+Pj4+IGRldmljZV9k
ZWwKPj4+Pj4KPj4+Pj4gYnV0IHRoZSBpc3N1ZSBpcyBzeXN0ZW1hdGljLiBBbnkgaWRlYT8KPj4+
Pj4KPj4+Pj4gQXQgdGhlIG1vbWVudCBJIGRvbid0IGhhdmUgdGhlIHRpbWUgdG8gZGVidWcgdGhp
cyBkZWVwZXIsIEkgZG9uJ3QgZXZlbgo+Pj4+PiBleGNsdWRlIHRoZSBjaGFuY2UgdGhhdCBpdCBj
b3VsZCBiZSBzb21laG93IHJlbGF0ZWQgdG8gdGhlIG1vZGVtLiBJCj4+Pj4+IHdvdWxkIGxpa2Ug
dG8gZnVydGhlciBsb29rIGF0IHRoaXMsIGJ1dCBJJ20gbm90IHN1cmUgZXhhY3RseSB3aGVuIEkK
Pj4+Pj4gY2FuLi4uLgo+Pj4+Cj4+Pj4gVGhhbmtzIGEgbG90IGZvciB0ZXN0aW5nLCBTZXJnZXks
IGRvIHlvdSBrbm93IHdoYXQgaXMgd3Jvbmcgd2l0aCBwb3J0IHJlbW92YWw/Cj4+Pgo+Pj4gRGFu
aWVsZSwgdGhhbmtzIGEgbG90IGZvciB2ZXJpZnlpbmcgdGhlIHByb3Bvc2FsIG9uIGEgcmVhbCBo
YXJkd2FyZSBhbmQKPj4+IHNoYXJpbmcgdGhlIGJ1aWxkIGZpeC4KPj4+Cj4+PiBVbmZvcnR1bmF0
ZWx5LCBJIHVuYWJsZSB0byByZXByb2R1Y2UgdGhlIGNyYXNoLiBJIGhhdmUgdHJpZWQgbXVsdGlw
bGUKPj4+IHRpbWVzIHRvIHJlYm9vdCBhIFZNIHJ1bm5pbmcgdGhlIHNpbXVsYXRvciBtb2R1bGUg
ZXZlbiB3aXRoIG9wZW5lZCBHTlNTCj4+PiBkZXZpY2UuIE5vIGx1Y2suIEl0IHJlYm9vdHMgYW5k
IHNodXRkb3ducyBzbW9vdGhseS4KPj4+Cj4+IAo+PiBJJ3ZlIHByb2JhYmx5IGZpZ3VyZWQgb3V0
IHdoYXQncyBoYXBwZW5pbmcuCj4+IAo+PiBUaGUgcHJvYmxlbSBzZWVtcyB0aGF0IHRoZSBnbnNz
IGRldmljZSBpcyBub3QgY29uc2lkZXJlZCBhIHd3YW5fY2hpbGQKPj4gYnkgaXNfd3dhbl9jaGls
ZCBhbmQgdGhpcyBtYWtlcyBkZXZpY2VfdW5yZWdpc3RlciBpbiB3d2FuX3JlbW92ZV9kZXYKPj4g
dG8gYmUgY2FsbGVkIHR3aWNlLgo+PiAKPj4gRm9yIHRlc3RpbmcgSSd2ZSBvdmVyd3JpdHRlbiB0
aGUgZ25zcyBkZXZpY2UgY2xhc3Mgd2l0aCB0aGUgZm9sbG93aW5nIGhhY2s6Cj4+IAo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd3dhbi93d2FuX2NvcmUuYyBiL2RyaXZlcnMvbmV0L3d3YW4v
d3dhbl9jb3JlLmMKPj4gaW5kZXggNGQyOWZiOGMxNmI4Li4zMmIzZjdjNGE0MDIgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9uZXQv
d3dhbi93d2FuX2NvcmUuYwo+PiBAQCAtNTk5LDYgKzU5OSw3IEBAIHN0YXRpYyBpbnQgd3dhbl9w
b3J0X3JlZ2lzdGVyX2duc3Moc3RydWN0IHd3YW5fcG9ydCAqcG9ydCkKPj4gICAgICAgICAgICAg
ICAgICBnbnNzX3B1dF9kZXZpY2UoZ2Rldik7Cj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIGVy
cjsKPj4gICAgICAgICAgfQo+PiArICAgICAgIGdkZXYtPmRldi5jbGFzcyA9ICZ3d2FuX2NsYXNz
Owo+PiAKPj4gICAgICAgICAgZGV2X2luZm8oJnd3YW5kZXYtPmRldiwgInBvcnQgJXMgYXR0YWNo
ZWRcbiIsIGRldl9uYW1lKCZnZGV2LT5kZXYpKTsKPj4gCj4+IGFuZCBub3cgdGhlIHN5c3RlbSBw
b3dlcnMgb2ZmIHdpdGhvdXQgaXNzdWVzLgo+PiAKPj4gU28sIG5vdCBzdXJlIGhvdyB0byBmaXgg
aXQgcHJvcGVybHksIGJ1dCBhdCBsZWFzdCBkb2VzIHRoZSBhbmFseXNpcwo+PiBtYWtlIHNlbnNl
IHRvIHlvdT8KPgo+TmljZSBjYXRjaCEgSSBoYWQgYSBkb3VidCByZWdhcmRpbmcgY29ycmVjdCBj
aGlsZCBwb3J0IGRldGVjdGlvbi4gTGV0IG1lIAo+ZG91YmxlIGNoZWNrLCBhbmQgdGhhbmsgeW91
IGZvciBwb2ludGluZyBtZSB0byB0aGUgcG9zc2libGUgc291cmNlIG9mIAo+aXNzdWVzLgo+Cj4t
LQo+U2VyZ2V5CgpIaSBTZXJnZXksClNvcnJ5IGZvciBib3RoZXJpbmcgdGhpcyB0aHJlYWQgYWdh
aW4uCkRvIHdlIGhhdmUgYW55IHVwZGF0ZXMgb24gdGhpcyBwb3RlbnRpYWwgaXNzdWU/IElmIHRo
aXMgaXNzdWUgaXMgbm90IGEgYmlnIHByb2JsZW0sCkNvdWxkIHdlIGNvbW1pdCB0aGVzZSBwYXRj
aGVzIGludG8gYSBicmFuY2ggdGhlbiBldmVyeSBvbmUgY291bGQgaGVscCBkZWJ1ZwppdCBiYXNl
ZCBvbiB0aGlzIGJhc2UgY29kZT8gCkkgdGhpbmsgd2Ugc2hhbGwgaGF2ZSBhIGJhc2UgdG8gZGV2
ZWxvcC4gTm8gY29kZSBpcyBwZXJmZWN0LgoKVGhhbmtzLgoKCg==

