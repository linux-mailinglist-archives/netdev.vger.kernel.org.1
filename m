Return-Path: <netdev+bounces-249685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963DD1C278
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71304300CF0C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCE2F49E3;
	Wed, 14 Jan 2026 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JMuQjpN0"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6E230D14
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358620; cv=none; b=F//Xt/LnJxHOBtLv1T2T/emhJsK9/3lPv1WN/PWXCpH70uEm00rX97uy595dkCxlFdi60VFhvzcfwQQjzAYMGtNYU8S3nrj1bu6v3OCIAuXFGvA8PEPoDtDMBcsT9jc0kS3PODvuqr/84tsIpG2Rm8t3+9QCp49Va8FYCGpLK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358620; c=relaxed/simple;
	bh=/rW5UZaz5ZOQtIh9I4JtiS8gsjrVS4aVUNtEk6X1Q1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=XW4IItMXhFsqcz2Cm8jWzL6yrrDcPx3dfI/qSEWvs8WPOez+bIyrHxHrUoIGr+QrhJOgJBlfE10GgutsBasQ6DtckGKuv0fS3LssjAk63xloR+98fgNO7sXyKrUMJxD3+9epDbh9UGLqcPBzMLzH2HJx6lauldKesqsajUNvN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JMuQjpN0; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=/rW5UZaz5ZOQtIh9I4JtiS8gsjrVS4aVUNtEk6X1Q1U=; b=J
	MuQjpN0HutdRDRDiXpYZJvwaEyO11hBiO8QQ2o2OSDfqHjpZTIdSIy9x2u7NA9Q5
	82S3T6Yw17/fek9sxVaLBD9fojDIeH0rDAP7Oyqmbf6Qk6blvxVr7BBHVY67R5Cl
	A6VEvKw4cHPGS1y7eAv26pxUd8Yk92MmpuIwQxEfHI=
Received: from slark_xiao$163.com ( [2409:895a:3956:450d:68c4:1164:504:56a]
 ) by ajax-webmail-wmsvr-40-130 (Coremail) ; Wed, 14 Jan 2026 10:42:42 +0800
 (CST)
Date: Wed, 14 Jan 2026 10:42:42 +0800 (CST)
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
Subject: Re:Re:Re:[RFC PATCH v5 0/7] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <845D539E-E546-4652-A37F-F9E655B37369@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
 <1b1a21b2.31c6.19ba0c6143b.Coremail.slark_xiao@163.com>
 <DF8AF3F7-9A3F-4DCB-963C-DCAE46309F7B@gmail.com>
 <3669f7f7.1b05.19bb517df16.Coremail.slark_xiao@163.com>
 <845D539E-E546-4652-A37F-F9E655B37369@gmail.com>
X-NTES-SC: AL_Qu2dCv+et00t5CKYZ+kfmk8Sg+84W8K3v/0v1YVQOpF8jADo9w07V2VtA3Tk1++qBTKMgTy3cgpk+/VnQox3Wbo2FOw36bqPFlFU+D4qPzxPoQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7662dad8.2840.19bba6249aa.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gigvCgBn_ueiAmdpQQZWAA--.3371W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvwLcQWlnAqL4vQAA3L
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMDEtMTMgMTQ6NTk6MzYsICJTZXJnZXkgUnlhemFub3YiIDxyeWF6YW5vdi5zLmFA
Z21haWwuY29tPiB3cm90ZToKPk9uIEphbnVhcnkgMTMsIDIwMjYgNDowMzoxOSBBTSwgU2xhcmsg
WGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPiB3cm90ZToKPj5BdCAyMDI2LTAxLTA5IDE1OjExOjU4
LCAiU2VyZ2V5IFJ5YXphbm92IiA8cnlhemFub3Yucy5hQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pk9u
IEphbnVhcnkgOSwgMjAyNiA1OjIxOjM0IEFNLCBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5j
b20+IHdyb3RlOgo+Pj4+QXQgMjAyNi0wMS0wOSAwOTowOTowMiwgIlNlcmdleSBSeWF6YW5vdiIg
PHJ5YXphbm92LnMuYUBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+PlRoZSBzZXJpZXMgaW50cm9kdWNl
cyBhIGxvbmcgZGlzY3Vzc2VkIE5NRUEgcG9ydCB0eXBlIHN1cHBvcnQgZm9yIHRoZQo+Pj4+PldX
QU4gc3Vic3lzdGVtLiBUaGVyZSBhcmUgdHdvIGdvYWxzLiBGcm9tIHRoZSBXV0FOIGRyaXZlciBw
ZXJzcGVjdGl2ZSwKPj4+Pj5OTUVBIGV4cG9ydGVkIGFzIGFueSBvdGhlciBwb3J0IHR5cGUgKGUu
Zy4gQVQsIE1CSU0sIFFNSSwgZXRjLikuIEZyb20KPj4+Pj51c2VyIHNwYWNlIHNvZnR3YXJlIHBl
cnNwZWN0aXZlLCB0aGUgZXhwb3J0ZWQgY2hhcmRldiBiZWxvbmdzIHRvIHRoZQo+Pj4+PkdOU1Mg
Y2xhc3Mgd2hhdCBtYWtlcyBpdCBlYXN5IHRvIGRpc3Rpbmd1aXNoIGRlc2lyZWQgcG9ydCBhbmQg
dGhlIFdXQU4KPj4+Pj5kZXZpY2UgY29tbW9uIHRvIGJvdGggTk1FQSBhbmQgY29udHJvbCAoQVQs
IE1CSU0sIGV0Yy4pIHBvcnRzIG1ha2VzIGl0Cj4+Pj4+ZWFzeSB0byBsb2NhdGUgYSBjb250cm9s
IHBvcnQgZm9yIHRoZSBHTlNTIHJlY2VpdmVyIGFjdGl2YXRpb24uCj4+Pj4+Cj4+Pj4+RG9uZSBi
eSBleHBvcnRpbmcgdGhlIE5NRUEgcG9ydCB2aWEgdGhlIEdOU1Mgc3Vic3lzdGVtIHdpdGggdGhl
IFdXQU4KPj4+Pj5jb3JlIGFjdGluZyBhcyBwcm94eSBiZXR3ZWVuIHRoZSBXV0FOIG1vZGVtIGRy
aXZlciBhbmQgdGhlIEdOU1MKPj4+Pj5zdWJzeXN0ZW0uCj4+Pj4+Cj4+Pj4+VGhlIHNlcmllcyBz
dGFydHMgZnJvbSBhIGNsZWFudXAgcGF0Y2guIFRoZW4gdGhyZWUgcGF0Y2hlcyBwcmVwYXJlcyB0
aGUKPj4+Pj5XV0FOIGNvcmUgZm9yIHRoZSBwcm94eSBzdHlsZSBvcGVyYXRpb24uIEZvbGxvd2Vk
IGJ5IGEgcGF0Y2ggaW50cm9kaW5nIGEKPj4+Pj5uZXcgV1dOQSBwb3J0IHR5cGUsIGludGVncmF0
aW9uIHdpdGggdGhlIEdOU1Mgc3Vic3lzdGVtIGFuZCBkZW11eC4gVGhlCj4+Pj4+c2VyaWVzIGVu
ZHMgd2l0aCBhIGNvdXBsZSBvZiBwYXRjaGVzIHRoYXQgaW50cm9kdWNlIGVtdWxhdGVkIEVNRUEg
cG9ydAo+Pj4+PnRvIHRoZSBXV0FOIEhXIHNpbXVsYXRvci4KPj4+Pj4KPj4+Pj5UaGUgc2VyaWVz
IGlzIHRoZSBwcm9kdWN0IG9mIHRoZSBkaXNjdXNzaW9uIHdpdGggTG9pYyBhYm91dCB0aGUgcHJv
cyBhbmQKPj4+Pj5jb25zIG9mIHBvc3NpYmxlIG1vZGVscyBhbmQgaW1wbGVtZW50YXRpb24uIEFs
c28gTXVoYW1tYWQgYW5kIFNsYXJrIGRpZAo+Pj4+PmEgZ3JlYXQgam9iIGRlZmluaW5nIHRoZSBw
cm9ibGVtLCBzaGFyaW5nIHRoZSBjb2RlIGFuZCBwdXNoaW5nIG1lIHRvCj4+Pj4+ZmluaXNoIHRo
ZSBpbXBsZW1lbnRhdGlvbi4gRGFuaWVsZSBoYXMgY2F1Z2h0IGFuIGlzc3VlIG9uIGRyaXZlcgo+
Pj4+PnVubG9hZGluZyBhbmQgc3VnZ2VzdGVkIGFuIGludmVzdGlnYXRpb24gZGlyZWN0aW9uLiBX
aGF0IHdhcyBjb25jbHVkZWQKPj4+Pj5ieSBMb2ljLiBNYW55IHRoYW5rcy4KPj4+Pj4KPj4+Pj5T
bGFyaywgaWYgdGhpcyBzZXJpZXMgd2l0aCB0aGUgdW5yZWdpc3RlciBmaXggc3VpdHMgeW91LCBw
bGVhc2UgYnVuZGxlCj4+Pj4+aXQgd2l0aCB5b3VyIE1ISSBwYXRjaCwgYW5kIChyZS0pc2VuZCBm
b3IgZmluYWwgaW5jbHVzaW9uLgo+Pj4+Pgo+Pj4+PkNoYW5nZXMgUkZDdjEtPlJGQ3YyOgo+Pj4+
PiogVW5pZm9ybWx5IHVzZSBwdXRfZGV2aWNlKCkgdG8gcmVsZWFzZSBwb3J0IG1lbW9yeS4gVGhp
cyBtYWRlIGNvZGUgbGVzcwo+Pj4+PiAgd2VpcmQgYW5kIHdheSBtb3JlIGNsZWFyLiBUaGFuayB5
b3UsIExvaWMsIGZvciBub3RpY2luZyBhbmQgdGhlIGZpeAo+Pj4+PiAgZGlzY3Vzc2lvbiEKPj4+
Pj5DaGFuZ2VzIFJGQ3YyLT5SRkN2NToKPj4+Pj4qIEZpeCBwcmVtYXR1cmUgV1dBTiBkZXZpY2Ug
dW5yZWdpc3RlcjsgbmV3IHBhdGNoIDIvNywgdGh1cywgYWxsCj4+Pj4+ICBzdWJzZXF1ZW50IHBh
dGNoZXMgaGF2ZSBiZWVuIHJlbnVtYmVyZWQKPj4+Pj4qIE1pbm9yIGFkanVzdG1lbnRzIGhlcmUg
YW5kIHRoZXJlCj4+Pj4+Cj4+Pj5TaGFsbCBJIGtlZXAgdGhlc2UgUkZDIGNoYW5nZXMgaW5mbyBp
biBteSBuZXh0IGNvbW1pdD8KPj4+PkFsc28gdGhlc2UgUkZDIGNoYW5nZXMgaW5mbyBpbiB0aGVz
ZSBzaW5nbGUgcGF0Y2guCj4+Pgo+Pj5HZW5lcmFsbHksIHllYWgsIGl0J3MgYSBnb29kIGlkZWEg
dG8ga2VlcCBpbmZvcm1hdGlvbiBhYm91dCBjaGFuZ2VzLCBlc3BlY2lhbGx5IHBlciBpdGVtIHBh
dGNoLiBLZWVwaW5nIHRoZSBjb3ZlciBsYXR0ZXIgY2hhbmdlbG9nIGlzIHVwIHRvIHlvdS4KPj4+
Cj4+Pj5BbmQgSSB3YW50IHRvIGtub3cgd2hldGhlciAgdjUgb3IgdjYgc2hhbGwgYmUgdXNlZCBm
b3IgbXkgbmV4dCBzZXJpYWw/Cj4+Pgo+Pj5Bbnkgb2YgdGhlbSB3aWxsIHdvcmsuIElmIHlvdSBh
c2tpbmcgbWUsIHRoZW4gSSB3b3VsZCBzdWdnZXN0IHRvIHNlbmQgaXQgYXMgdjYgdG8gY29udGlu
dWUgbnVtYmVyaW5nLgo+Pj4KPj4+PklzIHRoZXJlIGEgcmV2aWV3IHByb2dyZXNzIGZvciB0aGVz
ZSBSRkMgcGF0Y2hlcyAoIGZvciBwYXRjaCAyLzcgYW5kIAo+Pj4+My83IGVzcGVjaWFsbHkpLiBJ
ZiB5ZXMsIEkgd2lsbCBob2xkIG15IGNvbW1pdCB1bnRpbCB0aGVzZSByZXZpZXcgcHJvZ3Jlc3MK
Pj4+PmZpbmlzaGVkLiBJZiBub3QsIEkgd2lsbCBjb21iaW5lIHRoZXNlIGNoYW5nZXMgd2l0aCBt
eSBNSEkgcGF0Y2ggYW5kIHNlbmQKPj4+PnRoZW0gb3V0IGFzYXAuCj4+Pgo+Pj5JIGhhdmUgY29s
bGVjdGVkIGFsbCB0aGUgZmVlZGJhY2suIEUuZy4sIG1pbm9yIG51bWJlciBsZWFrIHdhcyBmaXhl
ZC4gRml4ZWQgb25lIGxvbmcgbm90aWNlZCBtaXN0eXBlLiBBbmQgY29sbGVjdGVkIHR3byBuZXcg
cmV2aWV3IHRhZ3MgZ2l2ZW4gYnkgTG9pYy4gU28sIG15IGFkdmljZSBpcyB0byB1c2UgdGhlc2Ug
cGF0Y2hlcyBhcyBiYXNlIGFuZCBwdXQgeW91ciBNSEkgcGF0Y2ggb24gdG9wIG9mIHRoZW0uCj4+
Pgo+PkhpIFNlcmdleSwKPj5JIGRpZG4ndCBmaW5kIHRoZSByZXZpZXcgdGFncyBmb3IgeW91ciBw
YXRjaCAyLzcgYW5kIDMvNyB1bnRpbCBub3cuIEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4KPllv
dSBhcmUgcmlnaHQsIHRoZXJlIGFyZSBubyByZXZpZXcgdGFncyBoYXZlIGJlZW4gZ2l2ZW4gZm9y
IHRoZXNlIHBhdGNoZXMuIElmIGl0IHdvcmtzIGZvciB5b3VyIGRldmljZSwganVzdCBzZW5kIHRo
ZSBjb21wbGV0ZSBzZXJpZXMuIFlvdSB0ZXN0aW5nIGdvaW5nIHRvIGJlIGVub3VnaC4KCj4KClRo
ZXJlIGlzIGFuIGVycm9yIGJhc2VkIG9uIHlvdXIgUkZDIGNoYW5nZXMuCkl0IGxvY2F0ZXMgaW4g
Ny83IG5ldDogd3dhbjogaHdzaW06IHN1cHBvcnQgTk1FQSBwb3J0IGVtdWxhdGlvbi4KRXJyb3Ig
YXMgYmVsb3c6CgrCoCBDQyBbTV3CoCBkcml2ZXJzL2lucHV0L2dhbWVwb3J0L2ZtODAxLWdwLm8K
ZHJpdmVycy9uZXQvd3dhbi93d2FuX2h3c2ltLmM6IEluIGZ1bmN0aW9uIOKAmHd3YW5faHdzaW1f
bm1lYV9lbXVsX3RpbWVy4oCZOgpkcml2ZXJzL25ldC93d2FuL3d3YW5faHdzaW0uYzoyMzk6NDA6
IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhmcm9tX3RpbWVy4oCZ
OyBkaWQgeW91IG1lYW4g4oCYbW9kX3RpbWVy4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlv
bi1kZWNsYXJhdGlvbl0KwqAgMjM5IHzCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB3d2FuX2h3c2lt
X3BvcnQgKnBvcnQgPSBmcm9tX3RpbWVyKHBvcnQsIHQsIG5tZWFfZW11bC50aW1lcik7CsKgwqDC
oMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+CsKgwqDCoMKgwqAgfMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtb2RfdGltZXIKZHJpdmVycy9uZXQvd3dhbi93d2FuX2h3c2ltLmM6
MjM5OjYwOiBlcnJvcjog4oCYbm1lYV9lbXVs4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0
aGlzIGZ1bmN0aW9uKQrCoCAyMzkgfMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHd3YW5faHdzaW1f
cG9ydCAqcG9ydCA9IGZyb21fdGltZXIocG9ydCwgdCwgbm1lYV9lbXVsLnRpbWVyKTsKwqDCoMKg
wqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBefn5+fn5+fn4KZHJpdmVycy9uZXQvd3dhbi93d2FuX2h3c2ltLmM6MjM5OjYw
OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2Ug
Zm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgpjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcg
dHJlYXRlZCBhcyBlcnJvcnMKbWFrZVs1XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI4
NzogZHJpdmVycy9uZXQvd3dhbi93d2FuX2h3c2ltLm9dIEVycm9yIDEKbWFrZVs0XTogKioqIFtz
Y3JpcHRzL01ha2VmaWxlLmJ1aWxkOjU0NDogZHJpdmVycy9uZXQvd3dhbl0gRXJyb3IgMgoKClRo
aXMgZXJyb3IgY291bGQgYmUgZm91bmQgaW4gbmV0ZGV2LWJwZiB3ZWJzaXRlIC0tQ2hlY2tzIC0t
bmV0ZGV2L2J1aWxkXzMyYml0IGFzIHdlbGwuCkkganVzdCByb2xsYmFjayBpdCB0byBwcmV2aW91
cyB0aW1lcl9jb250YWluZXJfb2YoKSBmdW5jdGlvbiBhbmQgaXQgYnVpbGRzIHdlbGwuCgoKPi0t
Cj5TZXJnZXkKPgo+SGkgU2xhcmssCg==

