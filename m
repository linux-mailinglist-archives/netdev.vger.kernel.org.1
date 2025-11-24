Return-Path: <netdev+bounces-241089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3DC7ED07
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 03:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C273A47D2
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7AC2609DC;
	Mon, 24 Nov 2025 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="NVEcxL/u"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE33F9C0;
	Mon, 24 Nov 2025 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763950943; cv=none; b=IO3l3CyqmUKbiRe9/6O9V4p3mNUY5fYgX3Y4w45gip9Il/Bu43KENMv0T7TomnCXf2kePsjf0XQ9uTw0s7Dk39nNCpmihSzvojVVMmBfCsTRU84v4nFeo/iatG3ZSzjyQX1edKKe95GICxecOH0E++32fhu4kxzgbSJnhjDC9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763950943; c=relaxed/simple;
	bh=3aExgBvt6OOcwnlW+aYHTKI0zH9n0H54QFPXhELksio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aE9BincJ+eTgMlZM7hC+9kE6G17+DmHRRKa9cCNXrODEO3cyjlVIDW81sWUVrUWQ5bSQ37lPl+kY4hTAk/A22JwWbArZquIdmxfEkwaFU0VOUBh1QkktrHWJHYIMIwc6Ek6Q7h/0c+A5LhU3E+32m+UWKZzRMzrCWURmsrXP9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=NVEcxL/u reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=SnxYa7JzbsJOUU93aMN2gxsGUb44Ij9abQffpax4eYM=; b=N
	VEcxL/ubIZNvLbrSeeZdsWMVJlMYYBUw+BN6BIBOZA8jz5jryfI+SUE3y0ilfCxq
	5TicmJW2Y6+DJ5mJfkSiUQkH4a3dmmQ6cPF2UumY1YebnPcFrIzZoyrJwc8d3azC
	+R8BWPViwKFi94YqZDbYxNpj6WR0jxzfb7MtwtSBB4=
Received: from slark_xiao$163.com ( [112.97.80.230] ) by
 ajax-webmail-wmsvr-40-119 (Coremail) ; Mon, 24 Nov 2025 10:21:28 +0800
 (CST)
Date: Mon, 24 Nov 2025 10:21:28 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAFEp6-17so5xAbXYBv3vPdOsxmo7_+ELnXHxcQb5zZj7apTjzg@mail.gmail.com>
References: <20251120114115.344284-1-slark_xiao@163.com>
 <CAFEp6-17so5xAbXYBv3vPdOsxmo7_+ELnXHxcQb5zZj7apTjzg@mail.gmail.com>
X-NTES-SC: AL_Qu2dAfWev0Aj7iKQbekfmk8Sg+84W8K3v/0v1YVQOpF8jD7p+B0OW15iJGbm7vmrFA6dqjWaQDJ88spGbbNqVpAIRQTtBle2L5Jrl8EcEbkWJQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3d69aa71.2528.19ab3aa856f.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dygvCgD3_9YowSNpProoAA--.770W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwAidAmkjwSgo2gAA3G
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTEtMjEgMjA6NTc6MDcsICJMb2ljIFBvdWxhaW4iIDxsb2ljLnBvdWxhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4gd3JvdGU6Cj5IaSBTbGFyaywKPgo+T24gVGh1LCBOb3YgMjAsIDIwMjUg
YXQgMTI6NDHigK9QTSBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+IHdyb3RlOgo+Pgo+
PiBDb3JyZWN0IGl0IHNpbmNlIE0uMiBkZXZpY2UgVDk5VzY0MCBoYXMgdXBkYXRlZCBmcm9tIFQ5
OVc1MTUuCj4+IFdlIG5lZWQgdG8gYWxpZ24gaXQgd2l0aCBNSEkgc2lkZSBvdGhlcndpc2UgdGhp
cyBtb2RlbSBjYW4ndAo+PiBnZXQgdGhlIG5ldHdvcmsuCj4+Cj4+IEZpeGVzOiBhZTVhMzQyNjQz
NTQgKCJidXM6IG1oaTogaG9zdDogcGNpX2dlbmVyaWM6IEZpeCB0aGUgbW9kZW0gbmFtZSBvZiBG
b3hjb25uIFQ5OVc2NDAiKQo+PiBGaXhlczogNjViYzU4YzNkY2FkICgibmV0OiB3d2FuOiBtaGk6
IG1ha2UgZGVmYXVsdCBkYXRhIGxpbmsgaWQgY29uZmlndXJhYmxlIikKPgo+T25seSB0aGUgZmly
c3QgRml4ZXMgdGFnIGlzIG5lZWRlZCwgYXMgdGhhdOKAmXMgd2hlcmUgdGhlIG1pc21hdGNoIHdh
cwo+aW50cm9kdWNlZCBhbmQgc2hvdWxkIGJlIGNvbnNpZGVyZWQgdGhlIHBvaW50IG9mIGNvcnJl
Y3Rpb24uCj4KV2lsbCBmaXggdGhpcyBpbiBuZXh0IHZlcnNpb24gcGF0Y2guCgo+PiBTaWduZWQt
b2ZmLWJ5OiBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+Cj4+IC0tLQo+PiAgZHJpdmVy
cy9uZXQvd3dhbi9taGlfd3dhbl9tYmltLmMgfCAyICstCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3d3YW4vbWhpX3d3YW5fbWJpbS5jIGIvZHJpdmVycy9uZXQvd3dhbi9taGlfd3dhbl9tYmltLmMK
Pj4gaW5kZXggYTE0MmFmNTlhOTFmLi4xZDdlM2FkOTAwYzEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvbmV0L3d3YW4vbWhpX3d3YW5fbWJpbS5jCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3d3YW4vbWhp
X3d3YW5fbWJpbS5jCj4+IEBAIC05OCw3ICs5OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgbWhpX21iaW1f
bGluayAqbWhpX21iaW1fZ2V0X2xpbmtfcmN1KHN0cnVjdCBtaGlfbWJpbV9jb250ZXh0ICptYmlt
Cj4+ICBzdGF0aWMgaW50IG1oaV9tYmltX2dldF9saW5rX211eF9pZChzdHJ1Y3QgbWhpX2NvbnRy
b2xsZXIgKmNudHJsKQo+PiAgewo+PiAgICAgICAgIGlmIChzdHJjbXAoY250cmwtPm5hbWUsICJm
b3hjb25uLWR3NTkzNGUiKSA9PSAwIHx8Cj4+IC0gICAgICAgICAgIHN0cmNtcChjbnRybC0+bmFt
ZSwgImZveGNvbm4tdDk5dzUxNSIpID09IDAgfHwKPj4gKyAgICAgICAgICAgc3RyY21wKGNudHJs
LT5uYW1lLCAiZm94Y29ubi10OTl3NjQwIikgPT0gMCB8fAo+PiAgICAgICAgICAgICBzdHJjbXAo
Y250cmwtPm5hbWUsICJmb3hjb25uLXQ5OXc3NjAiKSA9PSAwKQo+PiAgICAgICAgICAgICAgICAg
cmV0dXJuIFdEU19CSU5EX01VWF9EQVRBX1BPUlRfTVVYX0lEOwo+Pgo+PiAtLQo+PiAyLjI1LjEK
Pj4K

