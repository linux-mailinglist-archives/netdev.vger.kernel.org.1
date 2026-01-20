Return-Path: <netdev+bounces-251403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6817D3C408
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EB096894BB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879A63B52F7;
	Tue, 20 Jan 2026 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cpha7lAM"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AEF2ECE98;
	Tue, 20 Jan 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900675; cv=none; b=BZMIZ72I4wB4TcKiS468rqa3W92vKx9lhhKYXm1nB5Qm3XS5+ugsiaGryVXjCnEnTghTp2cff4I/H2bEz2tTh2jdmUzqPbuBsvjOLz9QryF04ZC7WyDXiIBi5qu6iy+CA6g0aoFBnwJSehICZ7nN9OLsZY+MBCRz2Q3V8yetJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900675; c=relaxed/simple;
	bh=StN9wjwVQu5h+Q44KanImI4ZsLxQRSu+oxbtMtM7At0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=U0/hWZ68MFp9KpXsvVJi2sYZPGp1dxQrVIstXcJbC+jlQUl7JxqwSGsB0EryYrPAfCCBfp6wnphKcBCAwYKwgY5TpIEMOezFllZokbJAGSLEAWHtOUnkn/Qp2nk5GJAWd8Kcbp6k3jwmm2YSxaQJr4t2hnOWQ7I4uI/AEGwIHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cpha7lAM; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=StN9wjwVQu5h+Q44KanImI4ZsLxQRSu+oxbtMtM7At0=; b=c
	pha7lAM6WHD9OoSe8dfgxIYXyEL2gvSyiXmG9Nn1OVPf+y30Jx9oOu4YhAchAOwF
	ozDD7MbNmh32vkIlcOFfMPvaIElxD0lP00ljEIuxDhuZQuYnvPbFq8Bl9XwrgBX4
	/ZgidxNsgZ9FT80lh9CYlPz54PhFCQ52F+yOLSsCIw=
Received: from slark_xiao$163.com (
 [2408:8459:3810:4821:4946:4a77:40f1:a5d6] ) by ajax-webmail-wmsvr-40-104
 (Coremail) ; Tue, 20 Jan 2026 17:16:56 +0800 (CST)
Date: Tue, 20 Jan 2026 17:16:56 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [net] Revert "net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <1228d107-4a60-4c33-a763-1a199c0b0961@embeddedor.com>
References: <20260120072018.29375-1-slark_xiao@163.com>
 <1228d107-4a60-4c33-a763-1a199c0b0961@embeddedor.com>
X-NTES-SC: AL_Qu2dCvWbv04q4CmaZ+kfmk8Sg+84W8K3v/0v1YVQOpF8jC7p1xwHY0dCPnj00cytBSqhlRSVUz1T9NxzWLR2WY4Mxu78KlYiAXLrURV429YMZA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5e012074.84f7.19bdab162e4.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aCgvCgB3_j8JSG9pLyFbAA--.9838W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwAhKrmlvSAh0WgAA3E
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTAxLTIwIDE1OjUxOjU3LCAiR3VzdGF2byBBLiBSLiBTaWx2YSIgPGd1c3Rhdm9A
ZW1iZWRkZWRvci5jb20+IHdyb3RlOgo+SGkgU2xhcmssCj4KPk9uIDEvMjAvMjYgMTY6MjAsIFNs
YXJrIFhpYW8gd3JvdGU6Cj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZWVlY2Y1ZDNhM2E0ODRjZWRm
YTNmMmY4N2U2ZDUxYTczOTBlZDk2MC4KPj4gCj4+IFRoaXMgY2hhbmdlIGxlYWQgdG8gTUhJIFdX
QU4gZGV2aWNlIGNhbid0IGNvbm5lY3QgdG8gaW50ZXJuZXQuCj4+IEkgZm91bmQgYSBuZXR3cm9r
IGlzc3VlIHdpdGgga2VybmVsIDYuMTktcmM0LCBidXQgbmV0d29yayB3b3Jrcwo+PiB3ZWxsIHdp
dGgga2VybmVsIDYuMTgtcmMxLiBBZnRlciBjaGVja2luZywgdGhpcyBjb21taXQgaXMgdGhlCj4+
IHJvb3QgY2F1c2UuCj4KPlRoYW5rcyBmb3IgdGhlIHJlcG9ydC4KPgo+Q291bGQgeW91IHBsZWFz
ZSBhcHBseSB0aGUgZm9sbG93aW5nIHBhdGNoIG9uIHRvcCBvZiB0aGlzIHJldmVydCwKPmFuZCBs
ZXQgdXMga25vdyBpZiB0aGUgcHJvYmxlbSBzdGlsbCBtYW5pZmVzdHM/IFRoYW5rIHlvdSEKPgo+
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vbWhpX3d3YW5fbWJpbS5jIGIvZHJpdmVycy9u
ZXQvd3dhbi9taGlfd3dhbl9tYmltLmMKPmluZGV4IDFkN2UzYWQ5MDBjMS4uYTI3MWE3MmZlZDYz
IDEwMDY0NAo+LS0tIGEvZHJpdmVycy9uZXQvd3dhbi9taGlfd3dhbl9tYmltLmMKPisrKyBiL2Ry
aXZlcnMvbmV0L3d3YW4vbWhpX3d3YW5fbWJpbS5jCj5AQCAtNzgsOSArNzgsMTIgQEAgc3RydWN0
IG1oaV9tYmltX2NvbnRleHQgewo+Cj4gIHN0cnVjdCBtYmltX3R4X2hkciB7Cj4gICAgICAgICBz
dHJ1Y3QgdXNiX2NkY19uY21fbnRoMTYgbnRoMTY7Cj4tICAgICAgIHN0cnVjdCB1c2JfY2RjX25j
bV9uZHAxNiBuZHAxNjsKPi0gICAgICAgc3RydWN0IHVzYl9jZGNfbmNtX2RwZTE2IGRwZTE2WzJd
Owo+KyAgICAgICBfX1RSQUlMSU5HX09WRVJMQVAoc3RydWN0IHVzYl9jZGNfbmNtX25kcDE2LCBu
ZHAxNiwgZHBlMTYsIF9fcGFja2VkLAo+KyAgICAgICAgICAgICAgIHN0cnVjdCB1c2JfY2RjX25j
bV9kcGUxNiBkcGUxNlsyXTsKPisgICAgICAgKTsKPiAgfSBfX3BhY2tlZDsKPitzdGF0aWNfYXNz
ZXJ0KG9mZnNldG9mKHN0cnVjdCBtYmltX3R4X2hkciwgbmRwMTYuZHBlMTYpID09Cj4rICAgICAg
ICAgICAgIG9mZnNldG9mKHN0cnVjdCBtYmltX3R4X2hkciwgZHBlMTYpKTsKPgo+ICBzdGF0aWMg
c3RydWN0IG1oaV9tYmltX2xpbmsgKm1oaV9tYmltX2dldF9saW5rX3JjdShzdHJ1Y3QgbWhpX21i
aW1fY29udGV4dCAqbWJpbSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgc2Vzc2lvbikKVGhpcyBwYXRjaCB3b24ndCBpbnRy
b2R1Y2UgcHJldmlvdXMgcHJvYmxlbS4KCg==

