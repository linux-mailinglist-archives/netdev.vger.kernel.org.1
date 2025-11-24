Return-Path: <netdev+bounces-241128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D62C7FCED
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0262C3A256F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62D62F6566;
	Mon, 24 Nov 2025 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NjeZjeEO"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616D24A043;
	Mon, 24 Nov 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978888; cv=none; b=YQYbxz52Bg1qaFoYo0v6GlhSeFzZro8UN+6dsNYBqIXZL2xCxQI8TwRD/cmxDjAJenBktfIHEaCfjJvLzP66uCyUY4RdarjFr2yB57o0oanzZ8q8I7oxuOfXwgx8hJBcsMs2KghO9vrGXdC0d6DSwnoHdBsOINynadO/MH72Zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978888; c=relaxed/simple;
	bh=GFNZa1oammlopjqY+BH1IHzdl5ZVOv9RXDPULqJDQuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=OJQpugjtqBiZCJjvRdZuUhJwxSYC5QPXUS2XCCcMu1OI+cbduAlDQBRSv/7GEofwfXhw99Q6vU6wczSllaZMfbMGZCw50Gh+4Q+JF16l6n+Yr10YGf12wAtH0O2oeAz8YqZw/uZnEuFHFLA8xT7gIE79JqJgvpP5I+hOxLXF2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NjeZjeEO; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=GFNZa1oammlopjqY+BH1IHzdl5ZVOv9RXDPULqJDQuI=; b=N
	jeZjeEOH690m42l4URZ/jogDDUVS4ZF57I6XDjG8TDr4bwnwwoUmhjA3r/Yax6M/
	q/VNuLOD2E6U3ymul8cXUhlNNXR8oskMWRbjfYaq9mzdXzEsxnZi2FFOGsDppuWD
	aGqKcPJEdojchE2t4/52kDA9bP6XCHgi+VwKVunaOU=
Received: from slark_xiao$163.com ( [112.97.80.230] ) by
 ajax-webmail-wmsvr-40-108 (Coremail) ; Mon, 24 Nov 2025 18:07:22 +0800
 (CST)
Date: Mon, 24 Nov 2025 18:07:22 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] net: wwan: mhi: Keep modem name match with
 Foxconn T99W640
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
References: <20251120114115.344284-1-slark_xiao@163.com>
 <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
 <605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
 <CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
X-NTES-SC: AL_Qu2dAfWct0Av5CmabOkfmk8Sg+84W8K3v/0v1YVQOpF8jCLpwR86WnZKGEDdzciXDzKFlxqzVSpcwOV9UKJ3Xpk1czXBSMvO8PmPGr8BkEIK2A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bCgvCgD3H39bLiRpOUQpAA--.1164W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvxoFaWkkLlofmQAA32
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTEtMjQgMTc6NTM6NTQsICJMb2ljIFBvdWxhaW4iIDxsb2ljLnBvdWxhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4gd3JvdGU6Cj5PbiBNb24sIE5vdiAyNCwgMjAyNSBhdCAzOjMx4oCvQU0g
U2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPiB3cm90ZToKPj4KPj4KPj4gQXQgMjAyNS0x
MS0yMiAxMDowODozNiwgIkpha3ViIEtpY2luc2tpIiA8a3ViYUBrZXJuZWwub3JnPiB3cm90ZToK
Pj4gPk9uIFRodSwgMjAgTm92IDIwMjUgMTk6NDE6MTUgKzA4MDAgU2xhcmsgWGlhbyB3cm90ZToK
Pj4gPj4gQ29ycmVjdCBpdCBzaW5jZSBNLjIgZGV2aWNlIFQ5OVc2NDAgaGFzIHVwZGF0ZWQgZnJv
bSBUOTlXNTE1Lgo+PiA+PiBXZSBuZWVkIHRvIGFsaWduIGl0IHdpdGggTUhJIHNpZGUgb3RoZXJ3
aXNlIHRoaXMgbW9kZW0gY2FuJ3QKPj4gPj4gZ2V0IHRoZSBuZXR3b3JrLgo+PiA+Pgo+PiA+PiBG
aXhlczogYWU1YTM0MjY0MzU0ICgiYnVzOiBtaGk6IGhvc3Q6IHBjaV9nZW5lcmljOiBGaXggdGhl
IG1vZGVtIG5hbWUgb2YgRm94Y29ubiBUOTlXNjQwIikKPj4gPj4gRml4ZXM6IDY1YmM1OGMzZGNh
ZCAoIm5ldDogd3dhbjogbWhpOiBtYWtlIGRlZmF1bHQgZGF0YSBsaW5rIGlkIGNvbmZpZ3VyYWJs
ZSIpCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4K
Pj4gPgo+PiA+RG9lc24ndCBhcHBseSB0byBlaXRoZXIgbmV0d29ya2luZyB0cmVlIDooCj4+IEkg
aGF2ZSBjYyB0aGUgZW1haWwgYWRkcmVzcyBieSB0aGUgc3lzdGVtIGNvbW1hbmQKPj4gInNjcmlw
dHMvZ2V0X21haW50YWluZXIucGwgcGF0Y2giLiBEbyB5b3UgbWVhbiBzaGFsbCBJIHJlbW92ZQo+
PiBuZXRkZXZAdmdlci5rZXJuZWwub3JnIGJ5IG1hbnVhbD8KPgo+VGhpcyBtZWFucyB5b3VyIHBh
dGNoIGRvZXMgbm90IGFwcGx5IGNsZWFubHkgdG8gbmV0LmdpdCBbMV0gb3IgbmV0LW5leHQuZ2l0
Lgo+U28geW91IGhhdmUgdG8gcmViYXNlIHlvdXIgY2hhbmdlIG9uIHRoZSBuZXQuZ2l0IHRyZWUg
YmVmb3JlIHJlc2VuZGluZy4KPgo+UmVnYXJkcywKPkxvaWMKPgo+WzFdIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9uZXQuZ2l0CkhpIExvaWMs
Ckkgc2VlLiBBY3R1YWxseSB0aGlzIHBhdGNoIHdhcyBnZW5lcmF0ZWQgaW4gbWhpIGNvZGUgYmFz
ZS4KQnV0IEkgZGlkbid0IHNlZSBhbnkgZGlmZmVyZW5jZSBvZiB0aGlzIGZpbGUgYmV0d2VlbiBt
aGkgYW5kIG5ldC4KQW5kLCB0aGVyZSBpcyBhbm90aGVyIGNvbW1pdCBtYXkgYWZmZWN0IHRoaXMg
Y2hhbmdlOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjUxMTE5MTA1NjE1LjQ4
Mjk1LTMtc2xhcmtfeGlhb0AxNjMuY29tLwotCSAgICBzdHJjbXAoY250cmwtPm5hbWUsICJmb3hj
b25uLXQ5OXc1MTUiKSA9PSAwKQorCSAgICBzdHJjbXAoY250cmwtPm5hbWUsICJmb3hjb25uLXQ5
OXc1MTUiKSA9PSAwIHx8CisJICAgIHN0cmNtcChjbnRybC0+bmFtZSwgImZveGNvbm4tdDk5dzc2
MCIpID09IDApCgpJIGVkaXRlZCBhYm92ZSBjb21taXQgZmlyc3RseSBhbmQgbm93IGl0J3MgcmV2
aWV3ZWQgc3RhdHVzIGJ1dCBub3QgYXBwbGllZC4KSWYgSSB1cGRhdGUgdGhpcyBjaGFuZ2UgYmFz
ZWQgbmV0IG9yIG5ldC1kZXYsIGFib3ZlIFQ5OVc3NjAgc3VwcG9ydCAKY29tbWl0IHRoZW4gd291
bGQgaGF2ZSBhIGNvbmZsaWN0IHNpbmNlIHRoZXkgYXJlIG5vdCBhIGNvbW1vbgpzZXJpZXMuIEhv
dyBzaGFsbCBJIGRvIHRvIGF2b2lkIHRoaXMgcG90ZW50aWFsIGNvbmZsaWN0PwoKVGhhbmtzCgoK


