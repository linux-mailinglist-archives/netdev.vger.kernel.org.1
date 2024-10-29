Return-Path: <netdev+bounces-139807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D755D9B4415
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9921F235B2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2EA1DFE30;
	Tue, 29 Oct 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="YN6tt5TG"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD554201246;
	Tue, 29 Oct 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190204; cv=none; b=tstKzpQf7G/57JKecG4Au5l02gcFd/zUium1PH4Vc0ZehvOJu6Rg7RGh51tQl/oUI725ec3wqZ7RhzrnCl3Vgry9oa6Xg8IlS76Pb6sCSN27Rry9QOkvWqb8poQNC7m4l7u/1REaAEmN1ADJuXAOjisVY+jyU3vZoWorH7rqaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190204; c=relaxed/simple;
	bh=u1hPCaM4+mot3eLvg/lUNYhp3KH41dUBDGH8iqXOS1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TL9oIh8pkwRS8X9iiqSMYINYSEodJ59N29ZGdk50oynQa7p9zAs/TbVXbKBLFe7nrjs82UgvFRBStgG1el/fNd9pfaPoOnSukfoBkLH2COgoz5NVUFi9unD2mRD3u2dVzxwcSWtg7XgFNYBurA9WIWb8BhA1c4tOOFGsHyj5AUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=YN6tt5TG reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=6WXE9mUg3P5hjkvI4QQV/zWTg3ZpNccIdHRuTSzHYbI=; b=Y
	N6tt5TGtmhU68omS2gBWRZwiNrznTVwhKgoIbeweAaidSYtqThNHkVglvn6rKwak
	3OAF8BFU+vq9mdDqg0XNcXifHuDqfDW/C7MYaxFf24MDWXWyyOsIYi/6y9OCEVnP
	1B+yUHk7VEqxDVhRdpVD7d71d232VSYVnfbh24SLMY=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-117 (Coremail) ; Tue, 29 Oct 2024 16:22:16 +0800
 (CST)
Date: Tue, 29 Oct 2024 16:22:16 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Johan Jonker" <jbx6244@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, david.wu@rock-chips.com, 
	andy.yan@rock-chips.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re:Re: [PATCH v1 2/2] net: arc: rockchip: fix emac mdio node
 support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <0a60a838-42cb-4df8-ab1f-91002dcaaa14@lunn.ch>
References: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
 <f04c2cfd-d2d6-4dc6-91a5-0ed1d1155171@gmail.com>
 <250cdfef.1bfc.192cd6a1f72.Coremail.andyshrk@163.com>
 <0a60a838-42cb-4df8-ab1f-91002dcaaa14@lunn.ch>
X-NTES-SC: AL_Qu2YAv2Sv0ko4CifY+lS/DNR+6hBMKv32aNaoMQOZ8UqqTHC6CwvbV1SBFDxyvoKJBLKOS6J7O0VAl6MYG8s
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a7c2431.871a.192d75e5631.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dSgvCgAHJGw4myBntukZAA--.994W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwiHXmcgkjHMLQADsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEFuZHJldywKCkF0IDIwMjQtMTAtMjggMjA6NTk6MTgsICJBbmRyZXcgTHVubiIgPGFuZHJl
d0BsdW5uLmNoPiB3cm90ZToKPj4gSGVsbG8gSm9oYW4sCj4+ICAgICBUaGFua3MgZm9yIHlvdXIg
cGF0Y2guICBNYXliZSB3ZSBuZWVkIGEgRml4ZXMgdGFnIGhlcmU/Cj4KPldoYXQgaXMgYWN0dWFs
bHkgYnJva2VuPwoKVGhlIGVtYWMgZmFpbGVkIHRvIHByb2JlIGFmdGVyIGJlbGxvdyBwYXRjaCBt
ZXJnZWQuCgogWyAgICAyLjMyNDU4M10gbG9vcDogbW9kdWxlIGxvYWRlZAogICAgWyAgICAyLjMy
ODQzNV0gU1BJIGRyaXZlciBzcGlkZXYgaGFzIG5vIHNwaV9kZXZpY2VfaWQgZm9yIHJvY2tjaGlw
LHNwaWRldgogICAgWyAgICAyLjMzODY4OF0gdHVuOiBVbml2ZXJzYWwgVFVOL1RBUCBkZXZpY2Ug
ZHJpdmVyLCAxLjYKICAgIFsgICAgMi4zNDUzOTddIHJvY2tjaGlwX2VtYWMgMTAyMDAwMDAuZXRo
ZXJuZXQ6IG5vIHJlZ3VsYXRvciBmb3VuZAogICAgWyAgICAyLjM1MTg5Ml0gcm9ja2NoaXBfZW1h
YyAxMDIwMDAwMC5ldGhlcm5ldDogQVJDIEVNQUMgZGV0ZWN0ZWQgd2l0aCBpZDogMHg3ZmQwMgog
ICAgWyAgICAyLjM1OTMzMV0gcm9ja2NoaXBfZW1hYyAxMDIwMDAwMC5ldGhlcm5ldDogSVJRIGlz
IDQzCiAgICBbICAgIDIuMzY0NzE5XSByb2NrY2hpcF9lbWFjIDEwMjAwMDAwLmV0aGVybmV0OiBN
QUMgYWRkcmVzcyBpcyBub3cgZTY6NTg6ZDY6ZWM6ZDk6N2MKICAgIFsgICAgMi4zOTY5OTNdIG1k
aW9fYnVzIFN5bm9wc3lzIE1JSSBCdXM6IG1kaW8gaGFzIGludmFsaWQgUEhZIGFkZHJlc3MKICAg
IFsgICAgMi40MDMzMDZdIG1kaW9fYnVzIFN5bm9wc3lzIE1JSSBCdXM6IHNjYW4gcGh5IG1kaW8g
YXQgYWRkcmVzcyAwCiAgICBbICAgIDIuNTA4NjU2XSByb2NrY2hpcF9lbWFjIDEwMjAwMDAwLmV0
aGVybmV0OiBvZl9waHlfY29ubmVjdCgpIGZhaWxlZAogICAgWyAgICAyLjUxNjMzNF0gcm9ja2No
aXBfZW1hYyAxMDIwMDAwMC5ldGhlcm5ldDogZmFpbGVkIHRvIHByb2JlIGFyYyBlbWFjICgtMTkp
CgoKY29tbWl0IDFkYWJiNzQ5NzFiMzhkOTY2ZWNlZjU2NmJhZmRkYzRhMzRmNGRiOWQKQXV0aG9y
OiBKb2hhbiBKb25rZXIgPGpieDYyNDRAZ21haWwuY29tPgpEYXRlOiAgIEZyaSBKdW4gMyAxODoz
NTozOSAyMDIyICswMjAwCgogICAgQVJNOiBkdHM6IHJvY2tjaGlwOiByZXN0eWxlIGVtYWMgbm9k
ZXMKICAgIAogICAgVGhlIGVtYWNfcm9ja2NoaXAudHh0IGZpbGUgaXMgY29udmVydGVkIHRvIFlB
TUwuCiAgICBQaHkgbm9kZXMgYXJlIG5vdyBhIHN1Ym5vZGUgb2YgbWRpbywgc28gcmVzdHlsZQog
ICAgdGhlIGVtYWMgbm9kZXMgb2YgcmszMDM2L3JrMzA2Ni9yazMxODguCiAgICAKICAgIFNpZ25l
ZC1vZmYtYnk6IEpvaGFuIEpvbmtlciA8amJ4NjI0NEBnbWFpbC5jb20+CiAgICBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjIwNjAzMTYzNTM5LjUzNy0zLWpieDYyNDRAZ21haWwu
Y29tCiAgICBTaWduZWQtb2ZmLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNoLmRlPgoK
Pgo+CUFuZHJldwo+Cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+TGludXgtcm9ja2NoaXAgbWFpbGluZyBsaXN0Cj5MaW51eC1yb2NrY2hpcEBsaXN0cy5p
bmZyYWRlYWQub3JnCj5odHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXJvY2tjaGlwCg==

