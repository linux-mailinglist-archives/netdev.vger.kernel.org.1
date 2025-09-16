Return-Path: <netdev+bounces-223383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C47B58F18
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B40E7A1B67
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F8278753;
	Tue, 16 Sep 2025 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="nR9KV2KC"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39EF27E049
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007464; cv=none; b=ht1FEsBQwBPwlMh4ovI0qAJRgeajoLh3WEsmLLNluwGUYBU1/6YPiLMoCmggWKE+5yUT7Hx7/rWpVlex32HnTyaC8kVHkHgaJ81R4A5m9phVZocunP84GOO9ERaT3uaO50rJWIsFAvI7HJi+eqjZdy24ds59eXn5TJoE5G9azU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007464; c=relaxed/simple;
	bh=1ARRown3psxtimh8GI/ZmbaEdm2ZSJtOgxnsw3noyd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ZoN62TETc/5JwcKA8eyUXodMsgWTgik+WnRvR1qLv3R2DEGbN4YsNeoMFSXsc6OjI1O+gZFFJFigAAwHBKXVozcr1wBysa6D3Y/ghV3OYLIyuPJqq+KP/qHgzx2PgD2I1j1LSOPY704daep6IDiEok0/mScar16Hj15ydXRLs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=nR9KV2KC reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=0/CJX2i9ynTHEK5K1wk3BuWrC4SDjfoOxQbQtBiAKLo=; b=n
	R9KV2KC0KhaSCOiR4XhfDtV0a3rApMfm7eR4YyPVp4cqnSnoclgclUvHC7G9K1Y0
	tBEvOd+RGVdQ1f1Jtf/OuWXZuiTAXdvJFHKxCqwWDzDFgEt5TF3wqb4mqGJzMYFj
	7h0gRZxFZ/DuQQ0MdhTREAes75Zwk5jOe1D7sY4x3I=
Received: from slark_xiao$163.com ( [2408:8459:3c60:81a:5ea0:7c24:b38e:9af4]
 ) by ajax-webmail-wmsvr-40-122 (Coremail) ; Tue, 16 Sep 2025 15:23:20 +0800
 (CST)
Date: Tue, 16 Sep 2025 15:23:20 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Sergey Ryazanov" <ryazanov.s.a@gmail.com>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>,
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
In-Reply-To: <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com>
 <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com>
 <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
X-NTES-SC: AL_Qu2eCvybuEwr5iaabOkfmUobhuo3W8u1vvgn1YNfOJl8jDHp6AMdfVFtMFXz0sCOLhqNljqLcwp2z95WYalhbrstHxMbqQFuYjjKEm5VNjgayA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eigvCgD3n19oEMlo2CIyAA--.1914W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJQrJZGjId2372AAHsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDktMTUgMDA6NDM6MDUsICJTZXJnZXkgUnlhemFub3YiIDxyeWF6YW5vdi5zLmFA
Z21haWwuY29tPiB3cm90ZToKPkhpIFNsYXJrLAo+Cj5PbiA5LzExLzI1IDA1OjQyLCBTbGFyayBY
aWFvIHdyb3RlOgo+PiBBdCAyMDI1LTA2LTMwIDE1OjMwOjE0LCAiTG9pYyBQb3VsYWluIiA8bG9p
Yy5wb3VsYWluQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOgo+Pj4gT24gU3VuLCBKdW4gMjksIDIw
MjUgYXQgMTI6MDfigK9QTSBTZXJnZXkgUnlhemFub3YgPHJ5YXphbm92LnMuYUBnbWFpbC5jb20+
IHdyb3RlOgo+Pj4+IE9uIDYvMjkvMjUgMDU6NTAsIExvaWMgUG91bGFpbiB3cm90ZToKPj4+Pj4g
T24gVHVlLCBKdW4gMjQsIDIwMjUgYXQgMTE6MznigK9QTSBTZXJnZXkgUnlhemFub3YgPHJ5YXph
bm92LnMuYUBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+Pj4gVGhlIHNlcmllcyBpbnRyb2R1Y2VzIGEg
bG9uZyBkaXNjdXNzZWQgTk1FQSBwb3J0IHR5cGUgc3VwcG9ydCBmb3IgdGhlCj4+Pj4+PiBXV0FO
IHN1YnN5c3RlbS4gVGhlcmUgYXJlIHR3byBnb2Fscy4gRnJvbSB0aGUgV1dBTiBkcml2ZXIgcGVy
c3BlY3RpdmUsCj4+Pj4+PiBOTUVBIGV4cG9ydGVkIGFzIGFueSBvdGhlciBwb3J0IHR5cGUgKGUu
Zy4gQVQsIE1CSU0sIFFNSSwgZXRjLikuIEZyb20KPj4+Pj4+IHVzZXIgc3BhY2Ugc29mdHdhcmUg
cGVyc3BlY3RpdmUsIHRoZSBleHBvcnRlZCBjaGFyZGV2IGJlbG9uZ3MgdG8gdGhlCj4+Pj4+PiBH
TlNTIGNsYXNzIHdoYXQgbWFrZXMgaXQgZWFzeSB0byBkaXN0aW5ndWlzaCBkZXNpcmVkIHBvcnQg
YW5kIHRoZSBXV0FOCj4+Pj4+PiBkZXZpY2UgY29tbW9uIHRvIGJvdGggTk1FQSBhbmQgY29udHJv
bCAoQVQsIE1CSU0sIGV0Yy4pIHBvcnRzIG1ha2VzIGl0Cj4+Pj4+PiBlYXN5IHRvIGxvY2F0ZSBh
IGNvbnRyb2wgcG9ydCBmb3IgdGhlIEdOU1MgcmVjZWl2ZXIgYWN0aXZhdGlvbi4KPj4+Pj4+Cj4+
Pj4+PiBEb25lIGJ5IGV4cG9ydGluZyB0aGUgTk1FQSBwb3J0IHZpYSB0aGUgR05TUyBzdWJzeXN0
ZW0gd2l0aCB0aGUgV1dBTgo+Pj4+Pj4gY29yZSBhY3RpbmcgYXMgcHJveHkgYmV0d2VlbiB0aGUg
V1dBTiBtb2RlbSBkcml2ZXIgYW5kIHRoZSBHTlNTCj4+Pj4+PiBzdWJzeXN0ZW0uCj4+Pj4+Pgo+
Pj4+Pj4gVGhlIHNlcmllcyBzdGFydHMgZnJvbSBhIGNsZWFudXAgcGF0Y2guIFRoZW4gdHdvIHBh
dGNoZXMgcHJlcGFyZXMgdGhlCj4+Pj4+PiBXV0FOIGNvcmUgZm9yIHRoZSBwcm94eSBzdHlsZSBv
cGVyYXRpb24uIEZvbGxvd2VkIGJ5IGEgcGF0Y2ggaW50cm9kaW5nIGEKPj4+Pj4+IG5ldyBXV05B
IHBvcnQgdHlwZSwgaW50ZWdyYXRpb24gd2l0aCB0aGUgR05TUyBzdWJzeXN0ZW0gYW5kIGRlbXV4
LiBUaGUKPj4+Pj4+IHNlcmllcyBlbmRzIHdpdGggYSBjb3VwbGUgb2YgcGF0Y2hlcyB0aGF0IGlu
dHJvZHVjZSBlbXVsYXRlZCBFTUVBIHBvcnQKPj4+Pj4+IHRvIHRoZSBXV0FOIEhXIHNpbXVsYXRv
ci4KPj4+Pj4+Cj4+Pj4+PiBUaGUgc2VyaWVzIGlzIHRoZSBwcm9kdWN0IG9mIHRoZSBkaXNjdXNz
aW9uIHdpdGggTG9pYyBhYm91dCB0aGUgcHJvcyBhbmQKPj4+Pj4+IGNvbnMgb2YgcG9zc2libGUg
bW9kZWxzIGFuZCBpbXBsZW1lbnRhdGlvbi4gQWxzbyBNdWhhbW1hZCBhbmQgU2xhcmsgZGlkCj4+
Pj4+PiBhIGdyZWF0IGpvYiBkZWZpbmluZyB0aGUgcHJvYmxlbSwgc2hhcmluZyB0aGUgY29kZSBh
bmQgcHVzaGluZyBtZSB0bwo+Pj4+Pj4gZmluaXNoIHRoZSBpbXBsZW1lbnRhdGlvbi4gTWFueSB0
aGFua3MuCj4+Pj4+Pgo+Pj4+Pj4gQ29tbWVudHMgYXJlIHdlbGNvbWVkLgo+Pj4+Pj4KPj4+Pj4+
IFNsYXJrLCBNdWhhbW1hZCwgaWYgdGhpcyBzZXJpZXMgc3VpdHMgeW91LCBmZWVsIGZyZWUgdG8g
YnVuZGxlIGl0IHdpdGgKPj4+Pj4+IHRoZSBkcml2ZXIgY2hhbmdlcyBhbmQgKHJlLSlzZW5kIGZv
ciBmaW5hbCBpbmNsdXNpb24gYXMgYSBzaW5nbGUgc2VyaWVzLgo+Pj4+Pj4KPj4+Pj4+IENoYW5n
ZXMgUkZDdjEtPlJGQ3YyOgo+Pj4+Pj4gKiBVbmlmb3JtbHkgdXNlIHB1dF9kZXZpY2UoKSB0byBy
ZWxlYXNlIHBvcnQgbWVtb3J5LiBUaGlzIG1hZGUgY29kZSBsZXNzCj4+Pj4+PiAgICAgd2VpcmQg
YW5kIHdheSBtb3JlIGNsZWFyLiBUaGFuayB5b3UsIExvaWMsIGZvciBub3RpY2luZyBhbmQgdGhl
IGZpeAo+Pj4+Pj4gICAgIGRpc2N1c3Npb24hCj4+Pj4+Cj4+Pj4+IEkgdGhpbmsgeW91IGNhbiBu
b3cgc2VuZCB0aGF0IHNlcmllcyB3aXRob3V0IHRoZSBSRkMgdGFnLiBJdCBsb29rcyBnb29kIHRv
IG1lLgo+Pj4+Cj4+Pj4gVGhhbmsgeW91IGZvciByZXZpZXdpbmcgaXQuIERvIHlvdSB0aGluayBp
dCBtYWtlcyBzZW5zZSB0byBpbnRyb2R1Y2UgbmV3Cj4+Pj4gQVBJIHdpdGhvdXQgYW4gYWN0dWFs
IHVzZXI/IE9rLCB3ZSBoYXZlIHR3byBkcml2ZXJzIHBvdGVudGlhbGx5IHJlYWR5IHRvCj4+Pj4g
dXNlIEdOU1MgcG9ydCB0eXBlLCBidXQgdGhleSBhcmUgbm90IHlldCBoZXJlLiBUaGF0IGlzIHdo
eSBJIGhhdmUgc2VuZAo+Pj4+IGFzIFJGQy4gT24gYW5vdGhlciBoYW5kLCB0ZXN0aW5nIHdpdGgg
c2ltdWxhdG9yIGhhcyBub3QgcmV2ZWFsZWQgYW55Cj4+Pj4gaXNzdWUgYW5kIEdOU1MgcG9ydCB0
eXBlIGltcGxlbWVudGF0aW9uIGxvb2tzIHJlYWR5IHRvIGJlIG1lcmdlZC4KPj4+Cj4+PiBSaWdo
dCwgd2UgbmVlZCBhIHByb3BlciB1c2VyIGZvciBpdCwgSSB0aGluayBzb21lIE1ISSBQQ0llIG1v
ZGVtcyBhbHJlYWR5Cj4+PiBoYXZlIHRoaXMgTk1FQSBwb3J0IGF2YWlsYWJsZSwgc28gaXQgY2Fu
IGVhc2lseSBiZSBhZGRlZCB0byB0aGlzIFBSLiBGb3Igc3VyZQo+Pj4gd2Ugd2lsbCBuZWVkIHNv
bWVvbmUgdG8gdGVzdCB0aGlzLgo+Pj4KPj4gSGkgTG9pYywgU2VyZ2V5LAo+PiBBbnkgdXBkYXRl
IGFib3V0IHRoaXMgdG9waWM/Cj4+IElmIHlvdSB3YW50IHRvIHRlc3QgaXQsIHdlIGNhbiBwcm92
aWRlIHNvbWUgaGVscCBvbiB0aGlzLiBBbHNvLCBJIHRoaW5rIHRoZSBxdWljaW5jCj4+IGNlbnRl
ciBtYXkgYWxzbyBkbyBzb21lIHRlc3QuIFlvdSBjYW4gY29udGFjdCBpdCB3aXRoIE1hbmkgZm9y
IGZ1cnRoZXIgZGV0YWlscy4KPgo+QmFzaWNhbGx5IHRoZSBmdW5jdGlvbmFsaXR5IGlzIGRvbmUs
IExvaWMgaGFzIHJldmlld2VkIGl0LCB3aGlsZSBub3QgCj5mb3JtYWxseSBhY2tlZCB5ZXQuIEFu
ZCBpdCBjYW4gYmUgbWVyZ2VkIGp1c3Qgbm93LiBPbiBhbm90aGVyIGhhbmQgd2UgCj5oYXZlIG5v
IHVzZXJzIGZvciBpdC4gVGhhdCBpcyB3aHkgSSBoYXZlIG5vdCBzZW50IGl0IGFzIGEgZmluYWwg
cGF0Y2guCj4KPkkgd2FzIGV4cGVjdGVkIHlvdSwgU2xhcmssIG9yIE11aGFtbWFkIHdpbGwgdGFr
ZSB0aGVzZSBwYXRjaGVzLCAKPmluY29ycG9yYXRlIGludG8gYSBkcml2ZXIgY2hhbmdlIHRoYXQg
aW50cm9kdWNlcyBOTUVBIHBvcnQgZXhwb3J0IGFuZCB3ZSAKPmNhbiBtZXJnZSBhbGwgdG9nZXRo
ZXIuIE9yIGlmIHlvdSBwcmVmZXIgdGhpcyBzZXJpZXMgYmVpbmcgbWVyZ2VkIGZpcnN0IAo+YW5k
IHRoZW4geW91IHdpbGwgc2VuZCB5b3VyIGNoYW5nZXMuIEluIHRoaXMgY2FzZSBJIG5lZWQgYSBn
cmVlbiBsaWdodCAKPmZyb20geW91IHRoYXQgeW91IHRlc3RlZCB0aGlzIHNlcmllcyBsb2NhbGx5
IGFuZCB0aGVyZSBhcmUgbm8gb2JqZWN0aW9ucy4KPgo+VG8gc3VtbWFyaXplLCB3ZSBoYXZlIHR3
byBvcHRpb25zOgo+YSkgeW91IGluY29ycG9yYXRlIHRoaXMgc2VyaWVzIGludG8geW91ciBjaGFu
Z2VzIGFuZCBzZW5kIGEgYmlnZ2VyIAo+c2VyaWVzIGltcGxlbWVudGluZyBldmVyeXRoaW5nIGZy
b20gZHJpdmVyIHRvIHRoZSBjb3JlOwo+Yikgd2UgbWVyZ2UgdGhpcyBzZXJpZXMgYXMgaXQgaXMs
IGFuZCB0aGVuIHlvdSBzZW5kIGFuIGZvbGxvdyB1cCBjaGFuZ2VzIAo+aW50cm9kdWNpbmcgYSBk
cml2ZXIgc3VwcG9ydC4KPgo+U2xhcmssIE11aGFtbWFkLCBsZXQgbWUga25vdywgd2hpY2ggd2F5
IGlzIG1vcmUgc3VpdGFibGUgZm9yIHlvdS4KPgo+LS0KPlNlcmdleQoKSSB3b3VsZCBwcmVmZXIg
dG8gc2VsZWN0IG9wdGlvbiAoYikuCkJhc2ljYWxseSB0aGVyZSBpcyBubyBiaWcgcHJvYmxlbSBp
biBteSBsb2NhbCBiYXNlZCBvbiB5b3VyIFYxIHBhdGNoZXMgLgpBbmQgSSB0aGluayBpdCdzIGhh
cmQgdG8gcmVhY2ggdG8gMTAwJSBmb3IgYSBuZXcgZmVhdHVyZS4gVGhlcmUgbXVzdCBiZSBoYXZl
IApzb21lIGV4dHJhIHBhdGNoZXMgdG8gY29tcGxldGUgaXQuCkhvdyBhYm91dCB5b3VyIG9waW5p
b24sIE1hbmk/Cg==

