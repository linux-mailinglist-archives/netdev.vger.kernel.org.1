Return-Path: <netdev+bounces-249249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCFD16409
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF82B30055B7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5610265CDD;
	Tue, 13 Jan 2026 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="atxGie5c"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55E1C862F
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269860; cv=none; b=tLHDLhps9Q4jdF8kAzykb2X6mBJuDuBQbzsskdugSjcOFA/4kPEdn6WMnk3nzuK5HXn88sLQ7srBUARHMsh7hiok884amCpKJGPRMmg6hG0c36t2g4f6suz+yV02hTKvFnpH1DU5QRHHAxJw/LThlTf/mI8wm0optof0F0X6FO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269860; c=relaxed/simple;
	bh=I+2N4wREuryIvkzcEpv8eoiAgk0VL8EFLEYPD9vh2c4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=q8DlaSKg7ZF5x3UQz5VBHa2nHM8oG0hF0t6bheWd9PiHKER3ARRekV1r/Nia3kiI3w7KyYDYlYiPqlAYgQ7y0BexslgPhTdTjy9pXd1JzUfkW7rWqfFixt7h+q596b8p2vZ0nRQFi+x3QYgyRPGP8Oa9jKDyFaNusTOw62z9W+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=atxGie5c; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=I+2N4wREuryIvkzcEpv8eoiAgk0VL8EFLEYPD9vh2c4=; b=a
	txGie5cajyv82c6t1mU+WtWq7TdgoqwjKGRw5k4AasWYt96v98NEca8HUWuzX2g6
	p5nrSIYs0zREINL/vn8C5Nsf3bpMA4KeN+8hc1p6rbRLizxLfY5BsEY7zUGmaCe5
	XijxQGQYsril8+YJt3UMbatQT2DetlVaHblOQdIDlU=
Received: from slark_xiao$163.com (
 [2409:895b:3866:aa48:64f5:82f9:a1a0:82de] ) by ajax-webmail-wmsvr-40-116
 (Coremail) ; Tue, 13 Jan 2026 10:03:19 +0800 (CST)
Date: Tue, 13 Jan 2026 10:03:19 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Sergey Ryazanov" <ryazanov.s.a@gmail.com>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>,
	"Johannes Berg" <johannes@sipsolutions.net>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"Eric Dumazet" <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	"Muhammad Nuzaihan" <zaihan@unrealasia.net>,
	"Daniele Palmas" <dnlplm@gmail.com>,
	"Qiang Yu" <quic_qianyu@quicinc.com>,
	"Manivannan Sadhasivam" <mani@kernel.org>,
	"Johan Hovold" <johan@kernel.org>
Subject: Re:Re:[RFC PATCH v5 0/7] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <DF8AF3F7-9A3F-4DCB-963C-DCAE46309F7B@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
 <1b1a21b2.31c6.19ba0c6143b.Coremail.slark_xiao@163.com>
 <DF8AF3F7-9A3F-4DCB-963C-DCAE46309F7B@gmail.com>
X-NTES-SC: AL_Qu2dCv6dtk8i7yGQZ+kfmk8Sg+84W8K3v/0v1YVQOpF8jD3p+gU8c1B4MUHH6uyNNzuNvgacSABu7/1+Q6V/Zo0o2eAT8s/xQ5PPQu9u9TCigw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3669f7f7.1b05.19bb517df16.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dCgvCgD3XyTnp2Vpo_RUAA--.29211W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvwfWO2llp+ev3QAA3r
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMDEtMDkgMTU6MTE6NTgsICJTZXJnZXkgUnlhemFub3YiIDxyeWF6YW5vdi5zLmFA
Z21haWwuY29tPiB3cm90ZToKPk9uIEphbnVhcnkgOSwgMjAyNiA1OjIxOjM0IEFNLCBTbGFyayBY
aWFvIDxzbGFya194aWFvQDE2My5jb20+IHdyb3RlOgo+PkF0IDIwMjYtMDEtMDkgMDk6MDk6MDIs
ICJTZXJnZXkgUnlhemFub3YiIDxyeWF6YW5vdi5zLmFAZ21haWwuY29tPiB3cm90ZToKPj4+VGhl
IHNlcmllcyBpbnRyb2R1Y2VzIGEgbG9uZyBkaXNjdXNzZWQgTk1FQSBwb3J0IHR5cGUgc3VwcG9y
dCBmb3IgdGhlCj4+PldXQU4gc3Vic3lzdGVtLiBUaGVyZSBhcmUgdHdvIGdvYWxzLiBGcm9tIHRo
ZSBXV0FOIGRyaXZlciBwZXJzcGVjdGl2ZSwKPj4+Tk1FQSBleHBvcnRlZCBhcyBhbnkgb3RoZXIg
cG9ydCB0eXBlIChlLmcuIEFULCBNQklNLCBRTUksIGV0Yy4pLiBGcm9tCj4+PnVzZXIgc3BhY2Ug
c29mdHdhcmUgcGVyc3BlY3RpdmUsIHRoZSBleHBvcnRlZCBjaGFyZGV2IGJlbG9uZ3MgdG8gdGhl
Cj4+PkdOU1MgY2xhc3Mgd2hhdCBtYWtlcyBpdCBlYXN5IHRvIGRpc3Rpbmd1aXNoIGRlc2lyZWQg
cG9ydCBhbmQgdGhlIFdXQU4KPj4+ZGV2aWNlIGNvbW1vbiB0byBib3RoIE5NRUEgYW5kIGNvbnRy
b2wgKEFULCBNQklNLCBldGMuKSBwb3J0cyBtYWtlcyBpdAo+Pj5lYXN5IHRvIGxvY2F0ZSBhIGNv
bnRyb2wgcG9ydCBmb3IgdGhlIEdOU1MgcmVjZWl2ZXIgYWN0aXZhdGlvbi4KPj4+Cj4+PkRvbmUg
YnkgZXhwb3J0aW5nIHRoZSBOTUVBIHBvcnQgdmlhIHRoZSBHTlNTIHN1YnN5c3RlbSB3aXRoIHRo
ZSBXV0FOCj4+PmNvcmUgYWN0aW5nIGFzIHByb3h5IGJldHdlZW4gdGhlIFdXQU4gbW9kZW0gZHJp
dmVyIGFuZCB0aGUgR05TUwo+Pj5zdWJzeXN0ZW0uCj4+Pgo+Pj5UaGUgc2VyaWVzIHN0YXJ0cyBm
cm9tIGEgY2xlYW51cCBwYXRjaC4gVGhlbiB0aHJlZSBwYXRjaGVzIHByZXBhcmVzIHRoZQo+Pj5X
V0FOIGNvcmUgZm9yIHRoZSBwcm94eSBzdHlsZSBvcGVyYXRpb24uIEZvbGxvd2VkIGJ5IGEgcGF0
Y2ggaW50cm9kaW5nIGEKPj4+bmV3IFdXTkEgcG9ydCB0eXBlLCBpbnRlZ3JhdGlvbiB3aXRoIHRo
ZSBHTlNTIHN1YnN5c3RlbSBhbmQgZGVtdXguIFRoZQo+Pj5zZXJpZXMgZW5kcyB3aXRoIGEgY291
cGxlIG9mIHBhdGNoZXMgdGhhdCBpbnRyb2R1Y2UgZW11bGF0ZWQgRU1FQSBwb3J0Cj4+PnRvIHRo
ZSBXV0FOIEhXIHNpbXVsYXRvci4KPj4+Cj4+PlRoZSBzZXJpZXMgaXMgdGhlIHByb2R1Y3Qgb2Yg
dGhlIGRpc2N1c3Npb24gd2l0aCBMb2ljIGFib3V0IHRoZSBwcm9zIGFuZAo+Pj5jb25zIG9mIHBv
c3NpYmxlIG1vZGVscyBhbmQgaW1wbGVtZW50YXRpb24uIEFsc28gTXVoYW1tYWQgYW5kIFNsYXJr
IGRpZAo+Pj5hIGdyZWF0IGpvYiBkZWZpbmluZyB0aGUgcHJvYmxlbSwgc2hhcmluZyB0aGUgY29k
ZSBhbmQgcHVzaGluZyBtZSB0bwo+Pj5maW5pc2ggdGhlIGltcGxlbWVudGF0aW9uLiBEYW5pZWxl
IGhhcyBjYXVnaHQgYW4gaXNzdWUgb24gZHJpdmVyCj4+PnVubG9hZGluZyBhbmQgc3VnZ2VzdGVk
IGFuIGludmVzdGlnYXRpb24gZGlyZWN0aW9uLiBXaGF0IHdhcyBjb25jbHVkZWQKPj4+YnkgTG9p
Yy4gTWFueSB0aGFua3MuCj4+Pgo+Pj5TbGFyaywgaWYgdGhpcyBzZXJpZXMgd2l0aCB0aGUgdW5y
ZWdpc3RlciBmaXggc3VpdHMgeW91LCBwbGVhc2UgYnVuZGxlCj4+Pml0IHdpdGggeW91ciBNSEkg
cGF0Y2gsIGFuZCAocmUtKXNlbmQgZm9yIGZpbmFsIGluY2x1c2lvbi4KPj4+Cj4+PkNoYW5nZXMg
UkZDdjEtPlJGQ3YyOgo+Pj4qIFVuaWZvcm1seSB1c2UgcHV0X2RldmljZSgpIHRvIHJlbGVhc2Ug
cG9ydCBtZW1vcnkuIFRoaXMgbWFkZSBjb2RlIGxlc3MKPj4+ICB3ZWlyZCBhbmQgd2F5IG1vcmUg
Y2xlYXIuIFRoYW5rIHlvdSwgTG9pYywgZm9yIG5vdGljaW5nIGFuZCB0aGUgZml4Cj4+PiAgZGlz
Y3Vzc2lvbiEKPj4+Q2hhbmdlcyBSRkN2Mi0+UkZDdjU6Cj4+PiogRml4IHByZW1hdHVyZSBXV0FO
IGRldmljZSB1bnJlZ2lzdGVyOyBuZXcgcGF0Y2ggMi83LCB0aHVzLCBhbGwKPj4+ICBzdWJzZXF1
ZW50IHBhdGNoZXMgaGF2ZSBiZWVuIHJlbnVtYmVyZWQKPj4+KiBNaW5vciBhZGp1c3RtZW50cyBo
ZXJlIGFuZCB0aGVyZQo+Pj4KPj5TaGFsbCBJIGtlZXAgdGhlc2UgUkZDIGNoYW5nZXMgaW5mbyBp
biBteSBuZXh0IGNvbW1pdD8KPj5BbHNvIHRoZXNlIFJGQyBjaGFuZ2VzIGluZm8gaW4gdGhlc2Ug
c2luZ2xlIHBhdGNoLgo+Cj5HZW5lcmFsbHksIHllYWgsIGl0J3MgYSBnb29kIGlkZWEgdG8ga2Vl
cCBpbmZvcm1hdGlvbiBhYm91dCBjaGFuZ2VzLCBlc3BlY2lhbGx5IHBlciBpdGVtIHBhdGNoLiBL
ZWVwaW5nIHRoZSBjb3ZlciBsYXR0ZXIgY2hhbmdlbG9nIGlzIHVwIHRvIHlvdS4KPgo+PkFuZCBJ
IHdhbnQgdG8ga25vdyB3aGV0aGVyICB2NSBvciB2NiBzaGFsbCBiZSB1c2VkIGZvciBteSBuZXh0
IHNlcmlhbD8KPgo+QW55IG9mIHRoZW0gd2lsbCB3b3JrLiBJZiB5b3UgYXNraW5nIG1lLCB0aGVu
IEkgd291bGQgc3VnZ2VzdCB0byBzZW5kIGl0IGFzIHY2IHRvIGNvbnRpbnVlIG51bWJlcmluZy4K
Pgo+PklzIHRoZXJlIGEgcmV2aWV3IHByb2dyZXNzIGZvciB0aGVzZSBSRkMgcGF0Y2hlcyAoIGZv
ciBwYXRjaCAyLzcgYW5kIAo+PjMvNyBlc3BlY2lhbGx5KS4gSWYgeWVzLCBJIHdpbGwgaG9sZCBt
eSBjb21taXQgdW50aWwgdGhlc2UgcmV2aWV3IHByb2dyZXNzCj4+ZmluaXNoZWQuIElmIG5vdCwg
SSB3aWxsIGNvbWJpbmUgdGhlc2UgY2hhbmdlcyB3aXRoIG15IE1ISSBwYXRjaCBhbmQgc2VuZAo+
PnRoZW0gb3V0IGFzYXAuCj4KPkkgaGF2ZSBjb2xsZWN0ZWQgYWxsIHRoZSBmZWVkYmFjay4gRS5n
LiwgbWlub3IgbnVtYmVyIGxlYWsgd2FzIGZpeGVkLiBGaXhlZCBvbmUgbG9uZyBub3RpY2VkIG1p
c3R5cGUuIEFuZCBjb2xsZWN0ZWQgdHdvIG5ldyByZXZpZXcgdGFncyBnaXZlbiBieSBMb2ljLiBT
bywgbXkgYWR2aWNlIGlzIHRvIHVzZSB0aGVzZSBwYXRjaGVzIGFzIGJhc2UgYW5kIHB1dCB5b3Vy
IE1ISSBwYXRjaCBvbiB0b3Agb2YgdGhlbS4KPgpIaSBTZXJnZXksCkkgZGlkbid0IGZpbmQgdGhl
IHJldmlldyB0YWdzIGZvciB5b3VyIHBhdGNoIDIvNyBhbmQgMy83IHVudGlsIG5vdy4gQW0gSSBt
aXNzaW5nIHNvbWV0aGluZz8KCj4+PkNDOiBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+
Cj4+PkNDOiBNdWhhbW1hZCBOdXphaWhhbiA8emFpaGFuQHVucmVhbGFzaWEubmV0Pgo+Pj5DQzog
RGFuaWVsZSBQYWxtYXMgPGRubHBsbUBnbWFpbC5jb20+Cj4+PkNDOiBRaWFuZyBZdSA8cXVpY19x
aWFueXVAcXVpY2luYy5jb20+Cj4+PkNDOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbmlAa2Vy
bmVsLm9yZz4KPj4+Q0M6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4KPj4+Cj4+PlNl
cmdleSBSeWF6YW5vdiAoNyk6Cj4+PiAgbmV0OiB3d2FuOiBjb3JlOiByZW1vdmUgdW51c2VkIHBv
cnRfaWQgZmllbGQKPj4+ICBuZXQ6IHd3YW46IGNvcmU6IGV4cGxpY2l0IFdXQU4gZGV2aWNlIHJl
ZmVyZW5jZSBjb3VudGluZwo+Pj4gIG5ldDogd3dhbjogY29yZTogc3BsaXQgcG9ydCBjcmVhdGlv
biBhbmQgcmVnaXN0cmF0aW9uCj4+PiAgbmV0OiB3d2FuOiBjb3JlOiBzcGxpdCBwb3J0IHVucmVn
aXN0ZXIgYW5kIHN0b3AKPj4+ICBuZXQ6IHd3YW46IGFkZCBOTUVBIHBvcnQgc3VwcG9ydAo+Pj4g
IG5ldDogd3dhbjogaHdzaW06IHJlZmFjdG9yIHRvIHN1cHBvcnQgbW9yZSBwb3J0IHR5cGVzCj4+
PiAgbmV0OiB3d2FuOiBod3NpbTogc3VwcG9ydCBOTUVBIHBvcnQgZW11bGF0aW9uCj4+Pgo+Pj4g
ZHJpdmVycy9uZXQvd3dhbi9LY29uZmlnICAgICAgfCAgIDEgKwo+Pj4gZHJpdmVycy9uZXQvd3dh
bi93d2FuX2NvcmUuYyAgfCAyODAgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+
Pj4gZHJpdmVycy9uZXQvd3dhbi93d2FuX2h3c2ltLmMgfCAyMDEgKysrKysrKysrKysrKysrKysr
Ky0tLS0tCj4+PiBpbmNsdWRlL2xpbnV4L3d3YW4uaCAgICAgICAgICB8ICAgMiArCj4+PiA0IGZp
bGVzIGNoYW5nZWQsIDM5NiBpbnNlcnRpb25zKCspLCA4OCBkZWxldGlvbnMoLSkKPj4+Cj4+Pi0t
IAo+Pj4yLjUyLjAKPgo+SGkgU2xhcmsK

