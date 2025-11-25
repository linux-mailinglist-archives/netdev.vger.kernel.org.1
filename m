Return-Path: <netdev+bounces-241363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731EC832CE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252F63A3844
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF41A9FAC;
	Tue, 25 Nov 2025 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YkGiFGIC"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC97263B;
	Tue, 25 Nov 2025 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040051; cv=none; b=OBzLHVvDwCnU5KSfXwi8bJO9H0sW1bxIuN9dJeOO3bPxvYLH4ITd7EUE+gtC98wo8d6ty6JkOhx3JSnu2oz8iH1y57qBmmd/iZzqtLuLbFKjZXRcTl9tKTwg83N++MGf+4KqZKZ8tVWhP01wZnRKaHzn/pyXiaDbqiy3b4XYrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040051; c=relaxed/simple;
	bh=K38gB3u14U4ou5ctcCUwzTGLp2j9prjEV6GR2HgqsZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FpLk3Lg51WwpiXE916BBj/W9wnIXW7ErP0Wyu9K0l/xSoQTeu3++6R5rGNZ+demfndXV7qSB2K+mvdnwFFB7kumFS6YZ7QYvYtS49SLVT6sAXgZIG9+aDirFwFgBilsyruOIw0tsJ5uaBtzWET7JVzckm0245Quz/vZK2KSsIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YkGiFGIC; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=K38gB3u14U4ou5ctcCUwzTGLp2j9prjEV6GR2HgqsZM=; b=Y
	kGiFGICNpy61EfvWTKJOTXSLxQ1WUS5/saVYpsCQb/gUwuOkG5Pf3h9jH0DNUGuR
	Fr3z8nHnCBrDRnuF2rm17HFa3Ozwjk7OQEtiHYZq05N9FvCakH8kTuXMbW6tIFRr
	cVXEIts1CDoJ0E/DweVKSjkzfaohgUYhVP1cEGlnMo=
Received: from slark_xiao$163.com ( [112.97.86.199] ) by
 ajax-webmail-wmsvr-40-145 (Coremail) ; Tue, 25 Nov 2025 11:06:30 +0800
 (CST)
Date: Tue, 25 Nov 2025 11:06:30 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20251124184219.0a34e86e@kernel.org>
References: <20251120114115.344284-1-slark_xiao@163.com>
 <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
 <605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
 <CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
 <623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
 <20251124184219.0a34e86e@kernel.org>
X-NTES-SC: AL_Qu2dBvyYtkEi5iScZekfmk8Sg+84W8K3v/0v1YVQOpF8jCvr1wwvfEV5A37r3OS2MCGAlzmbfQFAyedmcIpqVZgHZl6W1J42RFliiKLeIVXDAw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <33bc243d.33c6.19ab8fa1cb4.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kSgvCgA3lsE2HSVpeCAqAA--.3976W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbibgURZGklD33sYgACss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTEtMjUgMTA6NDI6MTksICJKYWt1YiBLaWNpbnNraSIgPGt1YmFAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBNb24sIDI0IE5vdiAyMDI1IDE4OjA3OjIyICswODAwIChDU1QpIFNsYXJr
IFhpYW8gd3JvdGU6Cj4+IEkgc2VlLiBBY3R1YWxseSB0aGlzIHBhdGNoIHdhcyBnZW5lcmF0ZWQg
aW4gbWhpIGNvZGUgYmFzZS4KPj4gQnV0IEkgZGlkbid0IHNlZSBhbnkgZGlmZmVyZW5jZSBvZiB0
aGlzIGZpbGUgYmV0d2VlbiBtaGkgYW5kIG5ldC4KPj4gQW5kLCB0aGVyZSBpcyBhbm90aGVyIGNv
bW1pdCBtYXkgYWZmZWN0IHRoaXMgY2hhbmdlOgo+PiAKPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbmV0ZGV2LzIwMjUxMTE5MTA1NjE1LjQ4Mjk1LTMtc2xhcmtfeGlhb0AxNjMuY29tLwo+PiAt
CSAgICBzdHJjbXAoY250cmwtPm5hbWUsICJmb3hjb25uLXQ5OXc1MTUiKSA9PSAwKQo+PiArCSAg
ICBzdHJjbXAoY250cmwtPm5hbWUsICJmb3hjb25uLXQ5OXc1MTUiKSA9PSAwIHx8Cj4+ICsJICAg
IHN0cmNtcChjbnRybC0+bmFtZSwgImZveGNvbm4tdDk5dzc2MCIpID09IDApCj4+IAo+PiBJIGVk
aXRlZCBhYm92ZSBjb21taXQgZmlyc3RseSBhbmQgbm93IGl0J3MgcmV2aWV3ZWQgc3RhdHVzIGJ1
dCBub3QgYXBwbGllZC4KPj4gSWYgSSB1cGRhdGUgdGhpcyBjaGFuZ2UgYmFzZWQgbmV0IG9yIG5l
dC1kZXYsIGFib3ZlIFQ5OVc3NjAgc3VwcG9ydCAKPj4gY29tbWl0IHRoZW4gd291bGQgaGF2ZSBh
IGNvbmZsaWN0IHNpbmNlIHRoZXkgYXJlIG5vdCBhIGNvbW1vbgo+PiBzZXJpZXMuIEhvdyBzaGFs
bCBJIGRvIHRvIGF2b2lkIHRoaXMgcG90ZW50aWFsIGNvbmZsaWN0Pwo+Cj5BcmUgeW91IHNheWlu
ZyB5b3UgaGF2ZSB0byBjb25jdXJyZW50IHN1Ym1pc3Npb25zIGNoYW5naW5nIG9uZSBmaWxlPwo+
SWYgeWVzIHBsZWFzZSByZXBvc3QgdGhlbSBhcyBhIHNlcmllcy4KT25lIHBhdGNoIG9mIHByZXZp
b3VzIHNlcmllcyBoYXMgYmVlbiBhcHBsaWVkLiBEb2VzIGl0IG1hdHRlciB0byByZXBvc3QgYSBu
ZXcKc2VyaWVzIGluY2x1ZGluZyB0aGF0IGFwcGxpZWQgcGF0Y2g/Ck9yIG5ldCB0ZWFtIGFwcGx5
IHRoZSByZXN0IHBhdGNoIG9mIHByZXZpb3VzIHNlcmllcyAsIHRoZW4gdHJ5IHRvIHJldmlldyB0
aGlzIHBhdGNoCmFnYWluLiBJIGd1ZXNzIHRoZXJlIGlzIG5vIGNvbmZsaWN0IGFueSBtb3JlLgog


