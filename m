Return-Path: <netdev+bounces-155718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A19A037A0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B9E3A4729
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DAB14B094;
	Tue,  7 Jan 2025 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="gMk9+3R9"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4442594B2;
	Tue,  7 Jan 2025 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229999; cv=none; b=di8d//z4nV+9olBaCmwJWj/5gLnqfVtf5+1z8rDZi11jNl/t/RSUzGRINSip4x0EivTjbxmBhE4zCa+q3bfvLhZuHdzyEYr4d19cC1FNio9vdOLDYzvHRNtezcrWzaXl96iS7rXQf4deGv0Tdzskqj5aSRmWRIAcgGQoAyge4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229999; c=relaxed/simple;
	bh=WON7gQqRw13780pq+Ow0QpLGjZ14hnc5lGbXr/TyLZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hEtWLfUMddOwmsCMGDKagktNiuPH1IqMPHIjQBFI5bd+nUh0AjVehe2VH4+eB6SCJYqdsuKZsvAbEqcKVSapO7zMef02NgJuH7z9gcTb5CH3pP/QHaFSKxOQUO9aAYjf4pVjrWKy49ZTXBW31ZFnT9miFMUPqn3k16nQ9ScFYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=gMk9+3R9 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=3sdmLfVOmOo2p/giyGOh8rmYfFNftuYziZBvUi+1cVA=; b=g
	Mk9+3R9CvIsqVt0ZWuyputB2yNbygaJUPhuNl6Gs5mXslftsICjYyU8mPvCcaiDV
	GZLow7jIDOmDuVcbUEVTagWB6BO2XxXoQwGlCyoQFWd9a1IczEaBgWQj4HFzCWR4
	ecaDH+TjHX3xdLhCpTQKkkGnf3AhR0UKx0Kq/7BSTQ=
Received: from slark_xiao$163.com (
 [2408:8459:3820:7371:147b:c649:857d:3d8d] ) by ajax-webmail-wmsvr-40-112
 (Coremail) ; Tue, 7 Jan 2025 14:05:38 +0800 (CST)
Date: Tue, 7 Jan 2025 14:05:38 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@linaro.org>
Cc: "Muhammad Nuzaihan" <zaihan@unrealasia.net>, 
	"Sergey Ryazanov" <ryazanov.s.a@gmail.com>, 
	"Johannes Berg" <johannes@sipsolutions.net>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH net-next v4] wwan dev: Add port for NMEA channel for
 WWAN devices
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAMZdPi91hR10xe=UzccqtwvtvS9_Wf9NEw6i5-x=e4UdfKMcug@mail.gmail.com>
References: <20250105124819.6950-1-zaihan@unrealasia.net>
 <CAMZdPi91hR10xe=UzccqtwvtvS9_Wf9NEw6i5-x=e4UdfKMcug@mail.gmail.com>
X-NTES-SC: AL_Qu2YBP6ZtkEo7imYYukfmkgRh+8+X8u1u/0j245WOZ1wjDnp6C0EcllTEXTGzfmDJC2LnQiHVBdn7MFrf7t0e7AuFwljLf+D6WvNjgE7ce7TOw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3c7d38cb.5336.1943f5e66de.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cCgvCgCnj4syxHxnWTNRAA--.563W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRx-NZGd8sfxzywAEsb
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDEtMDcgMDM6NDQ6MzUsICJMb2ljIFBvdWxhaW4iIDxsb2ljLnBvdWxhaW5AbGlu
YXJvLm9yZz4gd3JvdGU6Cj5IaSBNdWhhbW1hZCwKPgo+KyBTbGFyawo+Cj5PbiBTdW4sIDUgSmFu
IDIwMjUgYXQgMTM6NTMsIE11aGFtbWFkIE51emFpaGFuIDx6YWloYW5AdW5yZWFsYXNpYS5uZXQ+
IHdyb3RlOgo+Pgo+PiBCYXNlZCBvbiB0aGUgY29kZTogZHJpdmVycy9idXMvbWhpL2hvc3QvcGNp
X2dlbmVyaWMuYwo+PiB3aGljaCBhbHJlYWR5IGhhcyBOTUVBIGNoYW5uZWwgKG1oaV9xdWVjdGVs
X2VtMXh4X2NoYW5uZWxzKQo+PiBzdXBwb3J0IGluIHJlY2VudCBrZXJuZWxzIGJ1dCBpdCBpcyBu
ZXZlciBleHBvc2VkCj4+IGFzIGEgcG9ydC4KPj4KPj4gVGhpcyBjb21taXQgZXhwb3NlcyB0aGF0
IE5NRUEgY2hhbm5lbCB0byBhIHBvcnQKPj4gdG8gYWxsb3cgdHR5L2dwc2QgcHJvZ3JhbXMgdG8g
cmVhZCB0aHJvdWdoCj4+IHRoZSAvZGV2L3d3YW4wbm1lYTAgcG9ydC4KPj4KPj4gVGVzdGVkIHRo
aXMgY2hhbmdlIG9uIGEgbmV3IGtlcm5lbCBhbmQgbW9kdWxlCj4+IGJ1aWx0IGFuZCBub3cgTk1F
QSAobWhpMF9OTUVBKSBzdGF0ZW1lbnRzIGFyZQo+PiBhdmFpbGFibGUgKGF0dGFjaGVkKSB0aHJv
dWdoIC9kZXYvd3dhbjBubWVhMCBwb3J0IG9uIGJvb3R1cC4KPj4KPj4gU2lnbmVkLW9mZi1ieTog
TXVoYW1tYWQgTnV6YWloYW4gQmluIEthbWFsIEx1ZGRpbiA8emFpaGFuQHVucmVhbGFzaWEubmV0
Pgo+Cj5UaGlzIHdvcmtzIGZvciBzdXJlIGJ1dCBJJ20gbm90IGVudGlyZWx5IGNvbnZpbmNlZCBO
TUVBIHNob3VsZCBiZQo+ZXhwb3NlZCBhcyBhIG1vZGVtIGNvbnRyb2wgcG9ydC4gSW4geW91ciBw
cmV2aW91cyBwYXRjaCB2ZXJzaW9uIFNlcmdleQo+cG9pbnRlZCB0byBhIGRpc2N1c3Npb24gd2Ug
aGFkIHJlZ2FyZGluZyBleHBvc2luZyB0aGF0IHBvcnQgYXMgV1dBTgo+Y2hpbGQgZGV2aWNlIHRo
cm91Z2ggdGhlIHJlZ3VsYXIgR05TUyBzdWJzeXN0ZW0sIHdoaWNoIHdvdWxkIHJlcXVpcmUKPnNv
bWUgZ2VuZXJpYyBicmlkZ2UgaW4gdGhlIFdXQU4gc3Vic3lzdGVtLgo+Cj5TbGFyaywgZGlkIHlv
dSBoYXZlIGFuIG9wcG9ydHVuaXR5IHRvIGxvb2sgYXQgdGhlIEdOU1Mgc29sdXRpb24/Cj4KPlJl
Z2FyZHMsCj5Mb2ljCgpIaSBMb2ljLApUaGlzIHNvbHV0aW9uIHNhbWUgYXMgd2hhdCBJIGRpZCBp
biBsYXN0IHRpbWUuIFdlIGdvdCBhIHd3YW4wbm1lYTAgZGV2aWNlIGJ1dCB0aGlzCmRldmljZSBj
YW4ndCBzdXBwb3J0IGZsb3cgY29udHJvbC4KQWxzbywgdGhpcyBpcyBub3QgdGhlIHNvbHV0aW9u
IHdoYXQgU2VyZ2V5IGV4cGVjdGVkLCBJIHRoaW5rLiAKUGxlYXNlIHJlZmVyIHRvIHRoZSB0YXJn
ZXQgd2UgdGFsa2VkIGxhc3QgdGltZToKLy8vLy8vLy8vLy8vLy8vLy8vLy8vCj4+PiBCYXNpY2Fs
bHksIGNvbXBvbmVudHMgc2hvdWxkIGludGVyYWN0IGxpa2UgdGhpczoKPj4+Cj4+PiBNb2RlbSBQ
Q0llIGRyaXZlciA8LT4gV1dBTiBjb3JlIDwtPiBHTlNTIGNvcmUgPC0+IC9kZXYvZ25zczAKPj4+
Cj4+PiBXZSBuZWVkIHRoZSBHTlNTIGNvcmUgdG8gZXhwb3J0IHRoZSBtb2RlbSBOTUVBIHBvcnQg
YXMgaW5zdGFuY2Ugb2YKPj4+ICdnbnNzJyBjbGFzcy4KPj4+Cj4+PiBXZSBuZWVkIFdXQU4gY29y
ZSBiZXR3ZWVuIHRoZSBtb2RlbSBkcml2ZXIgYW5kIHRoZSBHU05OIGNvcmUgYmVjYXVzZSB3ZQo+
Pj4gbmVlZCBhIGNvbW1vbiBwYXJlbnQgZm9yIEdOU1MgcG9ydCBhbmQgbW9kZW0gY29udHJvbCBw
b3J0IChlLmcuIEFULAo+Pj4gTUJJTSkuIFNpbmNlIHdlIGFyZSBhbHJlYWR5IGV4cG9ydGluZyBj
b250cm9sIHBvcnRzIHZpYSB0aGUgV1dBTgo+Pj4gc3Vic3lzdGVtLCB0aGUgR05TUyBwb3J0IHNo
b3VsZCBhbHNvIGJlIGV4cG9ydGVkIHRocm91Z2ggdGhlIFdXQU4KPj4+IHN1YnN5c3RlbS4gVG8g
a2VlcCBkZXZpY2VzIGhpZXJhcmNoeSBsaWtlIHRoaXM6Cj4+Pgo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAuLS0+IEFUIHBvcnQKPj4+IFBDSWUgZGV2IC0+IFdXQU4gZGV2IC18Cj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICctLT4gR05TUyBwb3J0Cj4+Pgo+Pj4gQmFjayB0byB0aGUgaW1w
bGVtZW50YXRpb24uIFByb2JhYmx5IHdlIHNob3VsZCBpbnRyb2R1Y2UgYSBuZXcgcG9ydAo+Pj4g
dHlwZSwgZS5nLiBXV0FOX1BPUlRfTk1FQS4gQW5kIHRoaXMgcG9ydCB0eXBlIHNob3VsZCBoYXZl
IGEgc3BlY2lhbAo+Pj4gaGFuZGxpbmcgaW4gdGhlIFdXQU4gY29yZS4KPj4+Cj4+IFNpbWlsYXIg
bGlrZSB3aGF0IEkgZGlkIGluIG15IGxvY2FsLiBJIG5hbWVkIGl0IGFzIFdXQU5fUE9SVF9HTlNT
IGFuZAo+PiBwdXQgaXQgYXMgc2FtZSBsZXZlbCB3aXRoIEFUIHBvcnQuCj4+IAo+Pj4gd3dhbl9j
cmVhdGVfcG9ydCgpIGZ1bmN0aW9uIHNob3VsZCBub3QgZGlyZWN0bHkgY3JlYXRlIGEgY2hhciBk
ZXZpY2UuCj4+PiBJbnN0ZWFkLCBpdCBzaG91bGQgY2FsbCBnbnNzX2FsbG9jYXRlX2RldmljZSgp
IGFuZAo+Pj4gZ25zc19yZWdpc3Rlcl9kZXZpY2UoKSB0byByZWdpc3RlciB0aGUgcG9ydCB3aXRo
IEdOU1Mgc3Vic3lzdGVtLgovLy8vLy8vLy8vLy8vLy8vLy8vLwoKVGhhbmtzCgo=

