Return-Path: <netdev+bounces-221955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9AEB526A2
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 04:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4018C1C80C71
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E5E212572;
	Thu, 11 Sep 2025 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="GCwg7ccH"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929974BE1
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558631; cv=none; b=RzV4PnGGRgKN+uxdALzAeVYFvz35Hs48YXVEAvZRqwfUnmeiEk+4DyY2x1BReb26uWlBciLOwxxzMezQoiF/4PikJT/WtV844CfoIl4gG5BMx+xvGcTC2gPoSk6ybvNUlfncTVdsLbuKYc+l5qo5X5tHeFr9A91PdZ8RjGVukg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558631; c=relaxed/simple;
	bh=MU/XD4jRrzbqFDY4PJ2ig3ltaSIFbgRbkoD5pQN7Vuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EWgEPsnnZaPEFmdJtY8bAlxKT14svXIa1l2p3PttV9roo9DsTS9J9rbMmOWy4V4Uu0uktuTcGq6P3NTJQ733R4kxP6Z0zNDvkQqOR+GzRE/N33fQfSyMF8H1JJvlJ+eB2g/dmYAA+TckGz5UEGtZJIdJR3Hm6ejci9SYRG/iTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=GCwg7ccH reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=wXKIqvl+0Y5zB7haSxb53EXAfD+xkxx/Jt3CVvZiPuA=; b=G
	Cwg7ccHomij1PKiYDRUl/GA5HzR9Da9c2oJ6RWsIdlOyp+xOnvM+lUbLTiH1G41X
	j+RyjyVJ3t8l9tiygQgy6TqGkkeQE6E9scLiAexYGdsC4rP7k+aq/9vf10RF4ADg
	hV4F3ecsE7346Uox5XZNB1WagDcDA/3zzEp7ZYDa8E=
Received: from slark_xiao$163.com ( [223.104.87.160] ) by
 ajax-webmail-wmsvr-40-141 (Coremail) ; Thu, 11 Sep 2025 10:42:53 +0800
 (CST)
Date: Thu, 11 Sep 2025 10:42:53 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: "Sergey Ryazanov" <ryazanov.s.a@gmail.com>,
	"Johannes Berg" <johannes@sipsolutions.net>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"Eric Dumazet" <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	"Muhammad Nuzaihan" <zaihan@unrealasia.net>,
	"Qiang Yu" <quic_qianyu@quicinc.com>,
	"Manivannan Sadhasivam" <mani@kernel.org>,
	"Johan Hovold" <johan@kernel.org>
Subject: Re:Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com>
 <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
X-NTES-SC: AL_Qu2eBfmet00s5SmcZ+kfmk8Sg+84W8K3v/0v1YVQOpF8jCrr2wcjQFpmA3jz4uyEDga0syWNXBF16OhYfIZheaEpGjulbtTeQmwOt5KkFXhaoA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jSgvCgD3P2cuN8JoNWMIAA--.14101W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbibhLFZGjCMgOAcQABs2
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDYtMzAgMTU6MzA6MTQsICJMb2ljIFBvdWxhaW4iIDxsb2ljLnBvdWxhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4gd3JvdGU6Cj5IaSBTZXJnZXksCj4KPgo+T24gU3VuLCBKdW4gMjksIDIw
MjUgYXQgMTI6MDfigK9QTSBTZXJnZXkgUnlhemFub3YgPHJ5YXphbm92LnMuYUBnbWFpbC5jb20+
IHdyb3RlOgo+Pgo+PiBIaSBMb2ljLAo+Pgo+PiBPbiA2LzI5LzI1IDA1OjUwLCBMb2ljIFBvdWxh
aW4gd3JvdGU6Cj4+ID4gSGkgU2VyZ2V5LAo+PiA+Cj4+ID4gT24gVHVlLCBKdW4gMjQsIDIwMjUg
YXQgMTE6MznigK9QTSBTZXJnZXkgUnlhemFub3YgPHJ5YXphbm92LnMuYUBnbWFpbC5jb20+IHdy
b3RlOgo+PiA+PiBUaGUgc2VyaWVzIGludHJvZHVjZXMgYSBsb25nIGRpc2N1c3NlZCBOTUVBIHBv
cnQgdHlwZSBzdXBwb3J0IGZvciB0aGUKPj4gPj4gV1dBTiBzdWJzeXN0ZW0uIFRoZXJlIGFyZSB0
d28gZ29hbHMuIEZyb20gdGhlIFdXQU4gZHJpdmVyIHBlcnNwZWN0aXZlLAo+PiA+PiBOTUVBIGV4
cG9ydGVkIGFzIGFueSBvdGhlciBwb3J0IHR5cGUgKGUuZy4gQVQsIE1CSU0sIFFNSSwgZXRjLiku
IEZyb20KPj4gPj4gdXNlciBzcGFjZSBzb2Z0d2FyZSBwZXJzcGVjdGl2ZSwgdGhlIGV4cG9ydGVk
IGNoYXJkZXYgYmVsb25ncyB0byB0aGUKPj4gPj4gR05TUyBjbGFzcyB3aGF0IG1ha2VzIGl0IGVh
c3kgdG8gZGlzdGluZ3Vpc2ggZGVzaXJlZCBwb3J0IGFuZCB0aGUgV1dBTgo+PiA+PiBkZXZpY2Ug
Y29tbW9uIHRvIGJvdGggTk1FQSBhbmQgY29udHJvbCAoQVQsIE1CSU0sIGV0Yy4pIHBvcnRzIG1h
a2VzIGl0Cj4+ID4+IGVhc3kgdG8gbG9jYXRlIGEgY29udHJvbCBwb3J0IGZvciB0aGUgR05TUyBy
ZWNlaXZlciBhY3RpdmF0aW9uLgo+PiA+Pgo+PiA+PiBEb25lIGJ5IGV4cG9ydGluZyB0aGUgTk1F
QSBwb3J0IHZpYSB0aGUgR05TUyBzdWJzeXN0ZW0gd2l0aCB0aGUgV1dBTgo+PiA+PiBjb3JlIGFj
dGluZyBhcyBwcm94eSBiZXR3ZWVuIHRoZSBXV0FOIG1vZGVtIGRyaXZlciBhbmQgdGhlIEdOU1MK
Pj4gPj4gc3Vic3lzdGVtLgo+PiA+Pgo+PiA+PiBUaGUgc2VyaWVzIHN0YXJ0cyBmcm9tIGEgY2xl
YW51cCBwYXRjaC4gVGhlbiB0d28gcGF0Y2hlcyBwcmVwYXJlcyB0aGUKPj4gPj4gV1dBTiBjb3Jl
IGZvciB0aGUgcHJveHkgc3R5bGUgb3BlcmF0aW9uLiBGb2xsb3dlZCBieSBhIHBhdGNoIGludHJv
ZGluZyBhCj4+ID4+IG5ldyBXV05BIHBvcnQgdHlwZSwgaW50ZWdyYXRpb24gd2l0aCB0aGUgR05T
UyBzdWJzeXN0ZW0gYW5kIGRlbXV4LiBUaGUKPj4gPj4gc2VyaWVzIGVuZHMgd2l0aCBhIGNvdXBs
ZSBvZiBwYXRjaGVzIHRoYXQgaW50cm9kdWNlIGVtdWxhdGVkIEVNRUEgcG9ydAo+PiA+PiB0byB0
aGUgV1dBTiBIVyBzaW11bGF0b3IuCj4+ID4+Cj4+ID4+IFRoZSBzZXJpZXMgaXMgdGhlIHByb2R1
Y3Qgb2YgdGhlIGRpc2N1c3Npb24gd2l0aCBMb2ljIGFib3V0IHRoZSBwcm9zIGFuZAo+PiA+PiBj
b25zIG9mIHBvc3NpYmxlIG1vZGVscyBhbmQgaW1wbGVtZW50YXRpb24uIEFsc28gTXVoYW1tYWQg
YW5kIFNsYXJrIGRpZAo+PiA+PiBhIGdyZWF0IGpvYiBkZWZpbmluZyB0aGUgcHJvYmxlbSwgc2hh
cmluZyB0aGUgY29kZSBhbmQgcHVzaGluZyBtZSB0bwo+PiA+PiBmaW5pc2ggdGhlIGltcGxlbWVu
dGF0aW9uLiBNYW55IHRoYW5rcy4KPj4gPj4KPj4gPj4gQ29tbWVudHMgYXJlIHdlbGNvbWVkLgo+
PiA+Pgo+PiA+PiBTbGFyaywgTXVoYW1tYWQsIGlmIHRoaXMgc2VyaWVzIHN1aXRzIHlvdSwgZmVl
bCBmcmVlIHRvIGJ1bmRsZSBpdCB3aXRoCj4+ID4+IHRoZSBkcml2ZXIgY2hhbmdlcyBhbmQgKHJl
LSlzZW5kIGZvciBmaW5hbCBpbmNsdXNpb24gYXMgYSBzaW5nbGUgc2VyaWVzLgo+PiA+Pgo+PiA+
PiBDaGFuZ2VzIFJGQ3YxLT5SRkN2MjoKPj4gPj4gKiBVbmlmb3JtbHkgdXNlIHB1dF9kZXZpY2Uo
KSB0byByZWxlYXNlIHBvcnQgbWVtb3J5LiBUaGlzIG1hZGUgY29kZSBsZXNzCj4+ID4+ICAgIHdl
aXJkIGFuZCB3YXkgbW9yZSBjbGVhci4gVGhhbmsgeW91LCBMb2ljLCBmb3Igbm90aWNpbmcgYW5k
IHRoZSBmaXgKPj4gPj4gICAgZGlzY3Vzc2lvbiEKPj4gPgo+PiA+IEkgdGhpbmsgeW91IGNhbiBu
b3cgc2VuZCB0aGF0IHNlcmllcyB3aXRob3V0IHRoZSBSRkMgdGFnLiBJdCBsb29rcyBnb29kIHRv
IG1lLgo+Pgo+PiBUaGFuayB5b3UgZm9yIHJldmlld2luZyBpdC4gRG8geW91IHRoaW5rIGl0IG1h
a2VzIHNlbnNlIHRvIGludHJvZHVjZSBuZXcKPj4gQVBJIHdpdGhvdXQgYW4gYWN0dWFsIHVzZXI/
IE9rLCB3ZSBoYXZlIHR3byBkcml2ZXJzIHBvdGVudGlhbGx5IHJlYWR5IHRvCj4+IHVzZSBHTlNT
IHBvcnQgdHlwZSwgYnV0IHRoZXkgYXJlIG5vdCB5ZXQgaGVyZS4gVGhhdCBpcyB3aHkgSSBoYXZl
IHNlbmQKPj4gYXMgUkZDLiBPbiBhbm90aGVyIGhhbmQsIHRlc3Rpbmcgd2l0aCBzaW11bGF0b3Ig
aGFzIG5vdCByZXZlYWxlZCBhbnkKPj4gaXNzdWUgYW5kIEdOU1MgcG9ydCB0eXBlIGltcGxlbWVu
dGF0aW9uIGxvb2tzIHJlYWR5IHRvIGJlIG1lcmdlZC4KPgo+UmlnaHQsIHdlIG5lZWQgYSBwcm9w
ZXIgdXNlciBmb3IgaXQsIEkgdGhpbmsgc29tZSBNSEkgUENJZSBtb2RlbXMgYWxyZWFkeQo+aGF2
ZSB0aGlzIE5NRUEgcG9ydCBhdmFpbGFibGUsIHNvIGl0IGNhbiBlYXNpbHkgYmUgYWRkZWQgdG8g
dGhpcyBQUi4gRm9yIHN1cmUKPndlIHdpbGwgbmVlZCBzb21lb25lIHRvIHRlc3QgdGhpcy4KPgpI
aSBMb2ljLCBTZXJnZXksCkFueSB1cGRhdGUgYWJvdXQgdGhpcyB0b3BpYz8KSWYgeW91IHdhbnQg
dG8gdGVzdCBpdCwgd2UgY2FuIHByb3ZpZGUgc29tZSBoZWxwIG9uIHRoaXMuIEFsc28sIEkgdGhp
bmsgdGhlIHF1aWNpbmMKY2VudGVyIG1heSBhbHNvIGRvIHNvbWUgdGVzdC4gWW91IGNhbiBjb250
YWN0IGl0IHdpdGggTWFuaSBmb3IgZnVydGhlciBkZXRhaWxzLgoKVGhhbmtzCgo+PiBMZXQncyB3
YWl0IGEgbW9udGggb3Igc28gYW5kIGlmIG5vIGFjdHVhbCBkcml2ZXIgcGF0Y2ggZ29pbmcgdG8g
YmUgc2VuZCwKPj4gdGhlbiBJIHdpbGwgcmVzZW5kIGFzIGZvcm1hbCBwYXRjaCB0byBoYXZlIHRo
ZSBmdW5jdGlvbmFsaXR5IGluIHRoZQo+PiBrZXJuZWwgaW4gYWR2YW5jZS4KPgo+YWNrLgo+Cj5S
ZWdhcmRzLAo+TG9pYwo=

