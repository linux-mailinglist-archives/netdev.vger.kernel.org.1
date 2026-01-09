Return-Path: <netdev+bounces-248327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F3D06FA3
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2DB43013ECE
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1C1E1E04;
	Fri,  9 Jan 2026 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qbyS3+V1"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B377500979
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928951; cv=none; b=QIP2esQpPJ4ABeleFl9QqfsWINkCwPLc4glOr4/74W5VEIyZHYq8dQ78i+yu13PE+8U/8M5tp4sVZPF07p54OkI5GUlavNAz1y7mUQJFuWw+RwIwcdxoPdk7wJ6Aj799/tpsQ0K0IXPc49AYZuWX+6Dx+sM2UfCgIqUEggbI0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928951; c=relaxed/simple;
	bh=zd9kUvEXH79tjFcwBzDhv+a+7Cw5mf0l3OdTC4mdFUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NwU0oGWq7JRt5tpnc8Zz01ScijdyaqN+F2rH/YL89rGGW0s+UlZXQsrOm6uHz25QiG+dSZij7jPrQXVFAK3DGdvRRLzMWcgClp/7icy6HMCOwPQ05YNXfGVlu+7HIiBJyIbaQYaB2+UTm7ROt9Rm2OC/UsNcxEdjNG+lbvknbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qbyS3+V1; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zd9kUvEXH79tjFcwBzDhv+a+7Cw5mf0l3OdTC4mdFUA=; b=q
	byS3+V1qmx//JwlLivTlBpaOuq+tRst5PwjWKVSEAWEcG+NpbyeND6EbWCXK9LPa
	aSicef8kr6LSjwZUjOAKpO6Uf2jCifvi1ujLS32URd1gpqqtlMp4oFrPdc40a8s5
	UeRJMJlXwvsYSQ9I9FUaucIezEQ8LfcJpz1iAgLjx0=
Received: from slark_xiao$163.com (
 [2409:895a:38d7:e1f9:f25c:67d6:8062:df32] ) by ajax-webmail-wmsvr-40-124
 (Coremail) ; Fri, 9 Jan 2026 11:21:34 +0800 (CST)
Date: Fri, 9 Jan 2026 11:21:34 +0800 (CST)
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
Subject: Re:[RFC PATCH v5 0/7] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
X-NTES-SC: AL_Qu2dBfWZt0Ai4iWZZOkWnUwUgu46UMG3vf8u2IMbbOUivCX92R89d3NBJEbM4uamJAuMvCWqdRpow+1eU7gmtDTUX5cwj6NfSut/d5Rn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1b1a21b2.31c6.19ba0c6143b.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fCgvCgD3nyo+dGBpOYNTAA--.26000W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6B6eA2lgdD501gAA3K
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTAxLTA5IDA5OjA5OjAyLCAiU2VyZ2V5IFJ5YXphbm92IiA8cnlhemFub3Yucy5h
QGdtYWlsLmNvbT4gd3JvdGU6Cj5UaGUgc2VyaWVzIGludHJvZHVjZXMgYSBsb25nIGRpc2N1c3Nl
ZCBOTUVBIHBvcnQgdHlwZSBzdXBwb3J0IGZvciB0aGUKPldXQU4gc3Vic3lzdGVtLiBUaGVyZSBh
cmUgdHdvIGdvYWxzLiBGcm9tIHRoZSBXV0FOIGRyaXZlciBwZXJzcGVjdGl2ZSwKPk5NRUEgZXhw
b3J0ZWQgYXMgYW55IG90aGVyIHBvcnQgdHlwZSAoZS5nLiBBVCwgTUJJTSwgUU1JLCBldGMuKS4g
RnJvbQo+dXNlciBzcGFjZSBzb2Z0d2FyZSBwZXJzcGVjdGl2ZSwgdGhlIGV4cG9ydGVkIGNoYXJk
ZXYgYmVsb25ncyB0byB0aGUKPkdOU1MgY2xhc3Mgd2hhdCBtYWtlcyBpdCBlYXN5IHRvIGRpc3Rp
bmd1aXNoIGRlc2lyZWQgcG9ydCBhbmQgdGhlIFdXQU4KPmRldmljZSBjb21tb24gdG8gYm90aCBO
TUVBIGFuZCBjb250cm9sIChBVCwgTUJJTSwgZXRjLikgcG9ydHMgbWFrZXMgaXQKPmVhc3kgdG8g
bG9jYXRlIGEgY29udHJvbCBwb3J0IGZvciB0aGUgR05TUyByZWNlaXZlciBhY3RpdmF0aW9uLgo+
Cj5Eb25lIGJ5IGV4cG9ydGluZyB0aGUgTk1FQSBwb3J0IHZpYSB0aGUgR05TUyBzdWJzeXN0ZW0g
d2l0aCB0aGUgV1dBTgo+Y29yZSBhY3RpbmcgYXMgcHJveHkgYmV0d2VlbiB0aGUgV1dBTiBtb2Rl
bSBkcml2ZXIgYW5kIHRoZSBHTlNTCj5zdWJzeXN0ZW0uCj4KPlRoZSBzZXJpZXMgc3RhcnRzIGZy
b20gYSBjbGVhbnVwIHBhdGNoLiBUaGVuIHRocmVlIHBhdGNoZXMgcHJlcGFyZXMgdGhlCj5XV0FO
IGNvcmUgZm9yIHRoZSBwcm94eSBzdHlsZSBvcGVyYXRpb24uIEZvbGxvd2VkIGJ5IGEgcGF0Y2gg
aW50cm9kaW5nIGEKPm5ldyBXV05BIHBvcnQgdHlwZSwgaW50ZWdyYXRpb24gd2l0aCB0aGUgR05T
UyBzdWJzeXN0ZW0gYW5kIGRlbXV4LiBUaGUKPnNlcmllcyBlbmRzIHdpdGggYSBjb3VwbGUgb2Yg
cGF0Y2hlcyB0aGF0IGludHJvZHVjZSBlbXVsYXRlZCBFTUVBIHBvcnQKPnRvIHRoZSBXV0FOIEhX
IHNpbXVsYXRvci4KPgo+VGhlIHNlcmllcyBpcyB0aGUgcHJvZHVjdCBvZiB0aGUgZGlzY3Vzc2lv
biB3aXRoIExvaWMgYWJvdXQgdGhlIHByb3MgYW5kCj5jb25zIG9mIHBvc3NpYmxlIG1vZGVscyBh
bmQgaW1wbGVtZW50YXRpb24uIEFsc28gTXVoYW1tYWQgYW5kIFNsYXJrIGRpZAo+YSBncmVhdCBq
b2IgZGVmaW5pbmcgdGhlIHByb2JsZW0sIHNoYXJpbmcgdGhlIGNvZGUgYW5kIHB1c2hpbmcgbWUg
dG8KPmZpbmlzaCB0aGUgaW1wbGVtZW50YXRpb24uIERhbmllbGUgaGFzIGNhdWdodCBhbiBpc3N1
ZSBvbiBkcml2ZXIKPnVubG9hZGluZyBhbmQgc3VnZ2VzdGVkIGFuIGludmVzdGlnYXRpb24gZGly
ZWN0aW9uLiBXaGF0IHdhcyBjb25jbHVkZWQKPmJ5IExvaWMuIE1hbnkgdGhhbmtzLgo+Cj5TbGFy
aywgaWYgdGhpcyBzZXJpZXMgd2l0aCB0aGUgdW5yZWdpc3RlciBmaXggc3VpdHMgeW91LCBwbGVh
c2UgYnVuZGxlCj5pdCB3aXRoIHlvdXIgTUhJIHBhdGNoLCBhbmQgKHJlLSlzZW5kIGZvciBmaW5h
bCBpbmNsdXNpb24uCj4KPkNoYW5nZXMgUkZDdjEtPlJGQ3YyOgo+KiBVbmlmb3JtbHkgdXNlIHB1
dF9kZXZpY2UoKSB0byByZWxlYXNlIHBvcnQgbWVtb3J5LiBUaGlzIG1hZGUgY29kZSBsZXNzCj4g
IHdlaXJkIGFuZCB3YXkgbW9yZSBjbGVhci4gVGhhbmsgeW91LCBMb2ljLCBmb3Igbm90aWNpbmcg
YW5kIHRoZSBmaXgKPiAgZGlzY3Vzc2lvbiEKPkNoYW5nZXMgUkZDdjItPlJGQ3Y1Ogo+KiBGaXgg
cHJlbWF0dXJlIFdXQU4gZGV2aWNlIHVucmVnaXN0ZXI7IG5ldyBwYXRjaCAyLzcsIHRodXMsIGFs
bAo+ICBzdWJzZXF1ZW50IHBhdGNoZXMgaGF2ZSBiZWVuIHJlbnVtYmVyZWQKPiogTWlub3IgYWRq
dXN0bWVudHMgaGVyZSBhbmQgdGhlcmUKPgpTaGFsbCBJIGtlZXAgdGhlc2UgUkZDIGNoYW5nZXMg
aW5mbyBpbiBteSBuZXh0IGNvbW1pdD8KQWxzbyB0aGVzZSBSRkMgY2hhbmdlcyBpbmZvIGluIHRo
ZXNlIHNpbmdsZSBwYXRjaC4KCkFuZCBJIHdhbnQgdG8ga25vdyB3aGV0aGVyICB2NSBvciB2NiBz
aGFsbCBiZSB1c2VkIGZvciBteSBuZXh0IHNlcmlhbD8KSXMgdGhlcmUgYSByZXZpZXcgcHJvZ3Jl
c3MgZm9yIHRoZXNlIFJGQyBwYXRjaGVzICggZm9yIHBhdGNoIDIvNyBhbmQgCjMvNyBlc3BlY2lh
bGx5KS4gSWYgeWVzLCBJIHdpbGwgaG9sZCBteSBjb21taXQgdW50aWwgdGhlc2UgcmV2aWV3IHBy
b2dyZXNzCmZpbmlzaGVkLiBJZiBub3QsIEkgd2lsbCBjb21iaW5lIHRoZXNlIGNoYW5nZXMgd2l0
aCBteSBNSEkgcGF0Y2ggYW5kIHNlbmQKdGhlbSBvdXQgYXNhcC4KCj5DQzogU2xhcmsgWGlhbyA8
c2xhcmtfeGlhb0AxNjMuY29tPgo+Q0M6IE11aGFtbWFkIE51emFpaGFuIDx6YWloYW5AdW5yZWFs
YXNpYS5uZXQ+Cj5DQzogRGFuaWVsZSBQYWxtYXMgPGRubHBsbUBnbWFpbC5jb20+Cj5DQzogUWlh
bmcgWXUgPHF1aWNfcWlhbnl1QHF1aWNpbmMuY29tPgo+Q0M6IE1hbml2YW5uYW4gU2FkaGFzaXZh
bSA8bWFuaUBrZXJuZWwub3JnPgo+Q0M6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4K
Pgo+U2VyZ2V5IFJ5YXphbm92ICg3KToKPiAgbmV0OiB3d2FuOiBjb3JlOiByZW1vdmUgdW51c2Vk
IHBvcnRfaWQgZmllbGQKPiAgbmV0OiB3d2FuOiBjb3JlOiBleHBsaWNpdCBXV0FOIGRldmljZSBy
ZWZlcmVuY2UgY291bnRpbmcKPiAgbmV0OiB3d2FuOiBjb3JlOiBzcGxpdCBwb3J0IGNyZWF0aW9u
IGFuZCByZWdpc3RyYXRpb24KPiAgbmV0OiB3d2FuOiBjb3JlOiBzcGxpdCBwb3J0IHVucmVnaXN0
ZXIgYW5kIHN0b3AKPiAgbmV0OiB3d2FuOiBhZGQgTk1FQSBwb3J0IHN1cHBvcnQKPiAgbmV0OiB3
d2FuOiBod3NpbTogcmVmYWN0b3IgdG8gc3VwcG9ydCBtb3JlIHBvcnQgdHlwZXMKPiAgbmV0OiB3
d2FuOiBod3NpbTogc3VwcG9ydCBOTUVBIHBvcnQgZW11bGF0aW9uCj4KPiBkcml2ZXJzL25ldC93
d2FuL0tjb25maWcgICAgICB8ICAgMSArCj4gZHJpdmVycy9uZXQvd3dhbi93d2FuX2NvcmUuYyAg
fCAyODAgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+IGRyaXZlcnMvbmV0L3d3
YW4vd3dhbl9od3NpbS5jIHwgMjAxICsrKysrKysrKysrKysrKysrKystLS0tLQo+IGluY2x1ZGUv
bGludXgvd3dhbi5oICAgICAgICAgIHwgICAyICsKPiA0IGZpbGVzIGNoYW5nZWQsIDM5NiBpbnNl
cnRpb25zKCspLCA4OCBkZWxldGlvbnMoLSkKPgo+LS0gCj4yLjUyLjAK

