Return-Path: <netdev+bounces-250140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F74D24422
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B253012249
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8A38A9D3;
	Thu, 15 Jan 2026 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PRRptX5W"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879023803DA;
	Thu, 15 Jan 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477486; cv=none; b=I/oqCS7xYkMQTrgUgFtFnwEMqNtpbHI8fPfwmDK6VGKme/mJiCHlPpZKo2iBzxp3MV5LzlZ2L7EFaxdJ1cF3FLtM6w1OkmOlF77nG3U4a+kUaPUXBgSsTl7XIlASHIX54k4/LCi9woZ7XVgSrpv/NpYiUTpZP/Wmnd2VKcazXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477486; c=relaxed/simple;
	bh=vs7f1bhY9yDIJnCaMDj6N6nJziV47T+dhFpcwIx6KW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aRYnArOLUjOSDqQSdi3cs9zi5/E3qUnVJ/plVeM0uxFtd5mywED1ZOXElzycBsZZq6hIzDrZjqVexOaF+aDKkR/ls7fovOXIeJ1cyeROX1Lny76o/oexgf2ASC9kXEX1YDIIMeg8fblNgspDttiahgV90gdLYHuD9bLGm2iSW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PRRptX5W; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=vs7f1bhY9yDIJnCaMDj6N6nJziV47T+dhFpcwIx6KW4=; b=P
	RRptX5Ww4bajYCNox36fnJjEWGaVa/Tottr//4XyFWAc1k3iQKdezamlUr/eK8Ke
	HSS6OuFciovYs2p49Jv2ZHdceSx3WvK1A7QC5X3z7hLfgNFdlmUhLD0O/rmrlnUw
	AzsMJp31+F1rqFqT2oSP+NFBkE0yMfI0cGOjyimVdU=
Received: from slark_xiao$163.com (
 [2408:8459:3860:80a7:77ea:6fe3:a3bc:96b9] ) by ajax-webmail-wmsvr-40-130
 (Coremail) ; Thu, 15 Jan 2026 19:43:55 +0800 (CST)
Date: Thu, 15 Jan 2026 19:43:55 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mani@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[net-next v6 0/8] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260115095417.36975-1-slark_xiao@163.com>
References: <20260115095417.36975-1-slark_xiao@163.com>
X-NTES-SC: AL_Qu2dCvicuEwo4yeeZOkfmk8Sg+84W8K3v/0v1YVQOpF8jADo5h4+ZGVtJ0XH4uukDwmniRe7bz1rzc9iV4hqZ7sr5FBW7Tv4wEs5xtvfZL1MPw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <41675d06.99df.19bc178277f.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gigvCgBXZU370mhpwINXAA--.2582W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5xtny2lo0vvwpQAA3t
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMDEtMTUgMTc6NTQ6MDksICJTbGFyayBYaWFvIiA8c2xhcmtfeGlhb0AxNjMuY29t
PiB3cm90ZToKPlRoZSBzZXJpZXMgaW50cm9kdWNlcyBhIGxvbmcgZGlzY3Vzc2VkIE5NRUEgcG9y
dCB0eXBlIHN1cHBvcnQgZm9yIHRoZQo+V1dBTiBzdWJzeXN0ZW0uIFRoZXJlIGFyZSB0d28gZ29h
bHMuIEZyb20gdGhlIFdXQU4gZHJpdmVyIHBlcnNwZWN0aXZlLAo+Tk1FQSBleHBvcnRlZCBhcyBh
bnkgb3RoZXIgcG9ydCB0eXBlIChlLmcuIEFULCBNQklNLCBRTUksIGV0Yy4pLiBGcm9tCj51c2Vy
IHNwYWNlIHNvZnR3YXJlIHBlcnNwZWN0aXZlLCB0aGUgZXhwb3J0ZWQgY2hhcmRldiBiZWxvbmdz
IHRvIHRoZQo+R05TUyBjbGFzcyB3aGF0IG1ha2VzIGl0IGVhc3kgdG8gZGlzdGluZ3Vpc2ggZGVz
aXJlZCBwb3J0IGFuZCB0aGUgV1dBTgo+ZGV2aWNlIGNvbW1vbiB0byBib3RoIE5NRUEgYW5kIGNv
bnRyb2wgKEFULCBNQklNLCBldGMuKSBwb3J0cyBtYWtlcyBpdAo+ZWFzeSB0byBsb2NhdGUgYSBj
b250cm9sIHBvcnQgZm9yIHRoZSBHTlNTIHJlY2VpdmVyIGFjdGl2YXRpb24uCj4KPkRvbmUgYnkg
ZXhwb3J0aW5nIHRoZSBOTUVBIHBvcnQgdmlhIHRoZSBHTlNTIHN1YnN5c3RlbSB3aXRoIHRoZSBX
V0FOCj5jb3JlIGFjdGluZyBhcyBwcm94eSBiZXR3ZWVuIHRoZSBXV0FOIG1vZGVtIGRyaXZlciBh
bmQgdGhlIEdOU1MKPnN1YnN5c3RlbS4KPgo+VGhlIHNlcmllcyBzdGFydHMgZnJvbSBhIGNsZWFu
dXAgcGF0Y2guIFRoZW4gdGhyZWUgcGF0Y2hlcyBwcmVwYXJlcyB0aGUKPldXQU4gY29yZSBmb3Ig
dGhlIHByb3h5IHN0eWxlIG9wZXJhdGlvbi4gRm9sbG93ZWQgYnkgYSBwYXRjaCBpbnRyb2Rpbmcg
YQo+bmV3IFdXTkEgcG9ydCB0eXBlLCBpbnRlZ3JhdGlvbiB3aXRoIHRoZSBHTlNTIHN1YnN5c3Rl
bSBhbmQgZGVtdXguIFRoZQo+c2VyaWVzIGVuZHMgd2l0aCBhIGNvdXBsZSBvZiBwYXRjaGVzIHRo
YXQgaW50cm9kdWNlIGVtdWxhdGVkIEVNRUEgcG9ydAo+dG8gdGhlIFdXQU4gSFcgc2ltdWxhdG9y
Lgo+Cj5UaGUgc2VyaWVzIGlzIHRoZSBwcm9kdWN0IG9mIHRoZSBkaXNjdXNzaW9uIHdpdGggTG9p
YyBhYm91dCB0aGUgcHJvcyBhbmQKPmNvbnMgb2YgcG9zc2libGUgbW9kZWxzIGFuZCBpbXBsZW1l
bnRhdGlvbi4gQWxzbyBNdWhhbW1hZCBhbmQgU2xhcmsgZGlkCj5hIGdyZWF0IGpvYiBkZWZpbmlu
ZyB0aGUgcHJvYmxlbSwgc2hhcmluZyB0aGUgY29kZSBhbmQgcHVzaGluZyBtZSB0bwo+ZmluaXNo
IHRoZSBpbXBsZW1lbnRhdGlvbi4gRGFuaWVsZSBoYXMgY2F1Z2h0IGFuIGlzc3VlIG9uIGRyaXZl
cgo+dW5sb2FkaW5nIGFuZCBzdWdnZXN0ZWQgYW4gaW52ZXN0aWdhdGlvbiBkaXJlY3Rpb24uIFdo
YXQgd2FzIGNvbmNsdWRlZAo+YnkgTG9pYy4gTWFueSB0aGFua3MuCj4KPkNoYW5nZXMgUkZDdjEt
PlJGQ3YyOgo+KiBVbmlmb3JtbHkgdXNlIHB1dF9kZXZpY2UoKSB0byByZWxlYXNlIHBvcnQgbWVt
b3J5LiBUaGlzIG1hZGUgY29kZSBsZXNzCj4gIHdlaXJkIGFuZCB3YXkgbW9yZSBjbGVhci4gVGhh
bmsgeW91LCBMb2ljLCBmb3Igbm90aWNpbmcgYW5kIHRoZSBmaXgKPiAgZGlzY3Vzc2lvbiEKPkNo
YW5nZXMgUkZDdjItPlJGQ3Y1Ogo+KiBGaXggcHJlbWF0dXJlIFdXQU4gZGV2aWNlIHVucmVnaXN0
ZXI7IG5ldyBwYXRjaCAyLzcsIHRodXMsIGFsbAo+ICBzdWJzZXF1ZW50IHBhdGNoZXMgaGF2ZSBi
ZWVuIHJlbnVtYmVyZWQKPiogTWlub3IgYWRqdXN0bWVudHMgaGVyZSBhbmQgdGhlcmUKPgo+U2Vy
Z2V5IFJ5YXphbm92ICg3KToKPiAgbmV0OiB3d2FuOiBjb3JlOiByZW1vdmUgdW51c2VkIHBvcnRf
aWQgZmllbGQKPiAgbmV0OiB3d2FuOiBjb3JlOiBleHBsaWNpdCBXV0FOIGRldmljZSByZWZlcmVu
Y2UgY291bnRpbmcKSWdub3JlIHRoaXMgc2VyaWFsIHNpbmNlIGEgdHlwbyB3aGljaCBsZWFkIHRv
IGJ1aWxkIGVycm9yLgpTZWUgbmV4dCB2OCB2ZXJzaW9uIGxhdGVyLgoKPiAgbmV0OiB3d2FuOiBj
b3JlOiBzcGxpdCBwb3J0IGNyZWF0aW9uIGFuZCByZWdpc3RyYXRpb24KPiAgbmV0OiB3d2FuOiBj
b3JlOiBzcGxpdCBwb3J0IHVucmVnaXN0ZXIgYW5kIHN0b3AKPiAgbmV0OiB3d2FuOiBhZGQgTk1F
QSBwb3J0IHN1cHBvcnQKPiAgbmV0OiB3d2FuOiBod3NpbTogcmVmYWN0b3IgdG8gc3VwcG9ydCBt
b3JlIHBvcnQgdHlwZXMKPiAgbmV0OiB3d2FuOiBod3NpbTogc3VwcG9ydCBOTUVBIHBvcnQgZW11
bGF0aW9uCj4KPlNsYXJrIFhpYW8gKDEpOgo+ICBuZXQ6IHd3YW46IG1oaV93d2FuX2N0cmw6IEFk
ZCBOTUVBIGNoYW5uZWwgc3VwcG9ydAo+Cj4gZHJpdmVycy9uZXQvd3dhbi9LY29uZmlnICAgICAg
ICAgfCAgIDEgKwo+IGRyaXZlcnMvbmV0L3d3YW4vbWhpX3d3YW5fY3RybC5jIHwgICAxICsKPiBk
cml2ZXJzL25ldC93d2FuL3d3YW5fY29yZS5jICAgICB8IDI3NyArKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tCj4gZHJpdmVycy9uZXQvd3dhbi93d2FuX2h3c2ltLmMgICAgfCAyMDEgKysr
KysrKysrKysrKysrKysrLS0tLQo+IGluY2x1ZGUvbGludXgvd3dhbi5oICAgICAgICAgICAgIHwg
ICAyICsKPiA1IGZpbGVzIGNoYW5nZWQsIDM5NCBpbnNlcnRpb25zKCspLCA4OCBkZWxldGlvbnMo
LSkKPgo+LS0gCj4yLjI1LjEK

