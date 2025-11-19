Return-Path: <netdev+bounces-239875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57506C6D6F3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 480922D40D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0C2F7475;
	Wed, 19 Nov 2025 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="hs/0vQXa"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890022F746F;
	Wed, 19 Nov 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541211; cv=none; b=kFZ38Q12BfPBQhY9LvRqdt/M9dCKQJwI/NdHCKb6FaYwzTl58qTdzKxJF3ymzxYl1BQQnuTRikhWXjk95FIFBjTM61AMpK4zOgSmkoM7A8xGD1XdDtvEdk3ABjmbAeHW4hA6+FyHpcYDNlANM3BwJfe/ont34NeOwyaQ0d/R0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541211; c=relaxed/simple;
	bh=Y9IB5V3y1N3kvkaxQONulTzFzd7J7T/CaNjER1GUzKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DUY3keUCOjjhWiiy/oJUOHz1I87BUh27vYas6QUMHg1DaJfWHCpgQA+3xJZuP39mBhjVLR7LGRrWOTVrSkD9f+puuzM+mF/i9fIsJGtZbcBm27oProMXCuA2NyhcXwdjYdcAwNMqX6HixXbmfffxY9e4GTDs41RSQfl0tx13++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=hs/0vQXa reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=075i64fQmMCm+eTWlI33hFbtb/JLlPuo2MVr3bp3Mio=; b=h
	s/0vQXavrcoj3f47L6DK6rB4Nnjt2xAYLd0GVcdA8e+CoMxNk3jZ0mTOabcT3WAO
	IAXcGZewGMROQuw5QjEHYzUXVvelH1C2MdfTCBj+mx4prI4tMuAL6blYPo5/a9CS
	CHEEvYttXAJ5PbhdXi+V3uOovqzX/jOUCj6dGikahY=
Received: from slark_xiao$163.com (
 [2408:8459:3860:2d7a:43c4:19f8:8dc3:1342] ) by ajax-webmail-wmsvr-40-123
 (Coremail) ; Wed, 19 Nov 2025 16:32:31 +0800 (CST)
Date: Wed, 19 Nov 2025 16:32:31 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] net: wwan: mhi: Add network support for Foxconn
 T99W760
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAFEp6-0EQwmh2JfAwEdBM0514h+UF9q_eec5WNLCax9kdxFHhA@mail.gmail.com>
References: <20251119033917.7526-1-slark_xiao@163.com>
 <CAFEp6-0EQwmh2JfAwEdBM0514h+UF9q_eec5WNLCax9kdxFHhA@mail.gmail.com>
X-NTES-SC: AL_Qu2dAfmfvkku5yGcYOkfmk8Sg+84W8K3v/0v1YVQOpF8jAnpyg8icVhkOV7G/8iADTKmnCKcXBVe5v9ZWqxWYqEqSb2PCgnfY6kyt6yEO1638w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1fbaf01d.7bce.19a9b3e6db1.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgD3X06fgB1pktolAA--.946W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGQcLZGkddW7IcwABsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTEtMTkgMTY6MTg6MjYsICJMb2ljIFBvdWxhaW4iIDxsb2ljLnBvdWxhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4gd3JvdGU6Cj5IaSBTbGFyaywKPgo+T24gV2VkLCBOb3YgMTksIDIwMjUg
YXQgNDo0MeKAr0FNIFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+
IFQ5OVc3NjAgaXMgZGVzaWduZWQgYmFzZWQgb24gUXVhbGNvbW0gU0RYMzUgY2hpcC4gSXQgdXNl
IHNpbWlsYXIKPj4gYXJjaGl0ZWN0dXJlIHdpdGggU0RYNzIvU0RYNzUgY2hpcC4gU28gd2UgbmVl
ZCB0byBhc3NpZ24gaW5pdGlhbAo+PiBsaW5rIGlkIGZvciB0aGlzIGRldmljZSB0byBtYWtlIHN1
cmUgbmV0d29yayBhdmFpbGFibGUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNs
YXJrX3hpYW9AMTYzLmNvbT4KPgo+SXQgc2hvdWxkIGJlIGluIHRoZSBzYW1lIHNlcmllcyBhcyB0
aGUgcGF0Y2ggaW50cm9kdWNpbmcgRm94Y29ubgo+VDk5Vzc2MCBpbnRvIE1ISS9QQ0kgZHJpdmVy
Lgo+Cj5SZWdhcmRzLAo+TG9pYwo+Ck9rYXksIEkgd2lsbCBzZW5kIGl0IGFnYWluLiBBbmQgSSB3
aWxsIGFkZCAgeW91IGFuZCBNYW5pIHRvZ2V0aGVyLgo+Cj4+IC0tLQo+PiAgZHJpdmVycy9uZXQv
d3dhbi9taGlfd3dhbl9tYmltLmMgfCAzICsrLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd3dh
bi9taGlfd3dhbl9tYmltLmMgYi9kcml2ZXJzL25ldC93d2FuL21oaV93d2FuX21iaW0uYwo+PiBp
bmRleCBjODE0ZmJkNzU2YTEuLmExNDJhZjU5YTkxZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9u
ZXQvd3dhbi9taGlfd3dhbl9tYmltLmMKPj4gKysrIGIvZHJpdmVycy9uZXQvd3dhbi9taGlfd3dh
bl9tYmltLmMKPj4gQEAgLTk4LDcgKzk4LDggQEAgc3RhdGljIHN0cnVjdCBtaGlfbWJpbV9saW5r
ICptaGlfbWJpbV9nZXRfbGlua19yY3Uoc3RydWN0IG1oaV9tYmltX2NvbnRleHQgKm1iaW0KPj4g
IHN0YXRpYyBpbnQgbWhpX21iaW1fZ2V0X2xpbmtfbXV4X2lkKHN0cnVjdCBtaGlfY29udHJvbGxl
ciAqY250cmwpCj4+ICB7Cj4+ICAgICAgICAgaWYgKHN0cmNtcChjbnRybC0+bmFtZSwgImZveGNv
bm4tZHc1OTM0ZSIpID09IDAgfHwKPj4gLSAgICAgICAgICAgc3RyY21wKGNudHJsLT5uYW1lLCAi
Zm94Y29ubi10OTl3NTE1IikgPT0gMCkKPj4gKyAgICAgICAgICAgc3RyY21wKGNudHJsLT5uYW1l
LCAiZm94Y29ubi10OTl3NTE1IikgPT0gMCB8fAo+PiArICAgICAgICAgICBzdHJjbXAoY250cmwt
Pm5hbWUsICJmb3hjb25uLXQ5OXc3NjAiKSA9PSAwKQo+PiAgICAgICAgICAgICAgICAgcmV0dXJu
IFdEU19CSU5EX01VWF9EQVRBX1BPUlRfTVVYX0lEOwo+Pgo+PiAgICAgICAgIHJldHVybiAwOwo+
PiAtLQo+PiAyLjI1LjEKPj4K

