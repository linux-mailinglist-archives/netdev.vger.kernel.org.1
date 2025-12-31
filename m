Return-Path: <netdev+bounces-246420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE32CEBB9D
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C08301277D
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F3318151;
	Wed, 31 Dec 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NOEj5xtR"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3D31283C;
	Wed, 31 Dec 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767174837; cv=none; b=tgxmWdvrEbABW4CvPCrZy9Cw5StKJ7GHzEd7pvHJ8BIAm6nsH+MdAyLuMi1lDLTXAz+L3rmrbN9iZaJszvz8zPL273I9vPkazz/QSsU9Y+jXlPnkKzyYfiRJKl4pVdoE7ujL/68VDSy7WQvreaoh2Ao27biTbrrfCCqvmpVjn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767174837; c=relaxed/simple;
	bh=NxR9ts0imMiHN6LadzQ9zE95HT/+I/7XQUnd714e9SM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=M0XJDqtJ7k/zeISMLZvqpXgVm696CQaP5qA766VnnBDlnqKcBjOM1ONvysH02MhlW+4LVtdOvEW1E8q+GVZVvwvndgO4tENbm+yIzJJdY7AjRCKmYUJq4w42N7vAz+tl2uF6JNikOw6dkcGY54NsSG7GqNSmHW8pMTH45WMC1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NOEj5xtR; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NxR9ts0imMiHN6LadzQ9zE95HT/+I/7XQUnd714e9SM=; b=N
	OEj5xtRblvgOOO4qhaxt9TI4Pl04ANhmlKpApPXjbdjruwTDg+VDwkghMHKR8VW9
	vrYelP9lQAOOpcVFmCg/w+RJftxz/IaAUf+gNfb0in7WBQbENGb2FqdPun1O3ENq
	eMQzWmN2xmlN2T211V1Yx/VpqB8WLUHbX5h5TZz5aU=
Received: from slark_xiao$163.com ( [2408:8459:3860:dc2f:9df:7473:4331:5dc1]
 ) by ajax-webmail-wmsvr-40-109 (Coremail) ; Wed, 31 Dec 2025 17:52:44 +0800
 (CST)
Date: Wed, 31 Dec 2025 17:52:44 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Muhammad Nuzaihan" <zaihan@unrealasia.net>,
	"Qiang Yu" <quic_qianyu@quicinc.com>,
	"Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
	"Johan Hovold" <johan@kernel.org>, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, loic.poulain@oss.qualcomm.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	mani@kernel.org, kuba@kernel.org
Subject: Re:Re: [net-next v3 0/8] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <75e23b2c-67bf-41c8-8970-627d22af3147@redhat.com>
References: <20251231065109.43378-1-slark_xiao@163.com>
 <75e23b2c-67bf-41c8-8970-627d22af3147@redhat.com>
X-NTES-SC: AL_Qu2dBf2cu08t4iCaYekfmEoSheo8XcS4vP0u3Y9Wc+IEmA7G3RoHTWJ/HFzo8vOQFw23iRawdwJpy+F0d7VlHcojw+FyPnsMXQJDivX2hw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <672b7ed6.7f70.19b73d2f601.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bSgvCgDXF_Fs8lRpyblNAA--.8488W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvwxHq2lU8mz2HAAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgpBdCAyMDI1LTEyLTMxIDE3OjA2OjI5LCAiUGFvbG8gQWJlbmkiIDxwYWJlbmlAcmVkaGF0
LmNvbT4gd3JvdGU6Cj5PbiAxMi8zMS8yNSA3OjUxIEFNLCBTbGFyayBYaWFvIHdyb3RlOgo+PiBU
aGUgc2VyaWVzIGludHJvZHVjZXMgYSBsb25nIGRpc2N1c3NlZCBOTUVBIHBvcnQgdHlwZSBzdXBw
b3J0IGZvciB0aGUKPj4gV1dBTiBzdWJzeXN0ZW0uIFRoZXJlIGFyZSB0d28gZ29hbHMuIEZyb20g
dGhlIFdXQU4gZHJpdmVyIHBlcnNwZWN0aXZlLAo+PiBOTUVBIGV4cG9ydGVkIGFzIGFueSBvdGhl
ciBwb3J0IHR5cGUgKGUuZy4gQVQsIE1CSU0sIFFNSSwgZXRjLikuIEZyb20KPj4gdXNlciBzcGFj
ZSBzb2Z0d2FyZSBwZXJzcGVjdGl2ZSwgdGhlIGV4cG9ydGVkIGNoYXJkZXYgYmVsb25ncyB0byB0
aGUKPj4gR05TUyBjbGFzcyB3aGF0IG1ha2VzIGl0IGVhc3kgdG8gZGlzdGluZ3Vpc2ggZGVzaXJl
ZCBwb3J0IGFuZCB0aGUgV1dBTgo+PiBkZXZpY2UgY29tbW9uIHRvIGJvdGggTk1FQSBhbmQgY29u
dHJvbCAoQVQsIE1CSU0sIGV0Yy4pIHBvcnRzIG1ha2VzIGl0Cj4+IGVhc3kgdG8gbG9jYXRlIGEg
Y29udHJvbCBwb3J0IGZvciB0aGUgR05TUyByZWNlaXZlciBhY3RpdmF0aW9uLgo+PiAKPj4gRG9u
ZSBieSBleHBvcnRpbmcgdGhlIE5NRUEgcG9ydCB2aWEgdGhlIEdOU1Mgc3Vic3lzdGVtIHdpdGgg
dGhlIFdXQU4KPj4gY29yZSBhY3RpbmcgYXMgcHJveHkgYmV0d2VlbiB0aGUgV1dBTiBtb2RlbSBk
cml2ZXIgYW5kIHRoZSBHTlNTCj4+IHN1YnN5c3RlbS4KPj4gCj4+IFRoZSBzZXJpZXMgc3RhcnRz
IGZyb20gYSBjbGVhbnVwIHBhdGNoLiBUaGVuIHR3byBwYXRjaGVzIHByZXBhcmVzIHRoZQo+PiBX
V0FOIGNvcmUgZm9yIHRoZSBwcm94eSBzdHlsZSBvcGVyYXRpb24uIEZvbGxvd2VkIGJ5IGEgcGF0
Y2ggaW50cm9kaW5nIGEKPj4gbmV3IFdXTkEgcG9ydCB0eXBlLCBpbnRlZ3JhdGlvbiB3aXRoIHRo
ZSBHTlNTIHN1YnN5c3RlbSBhbmQgZGVtdXguIFRoZQo+PiBzZXJpZXMgZW5kcyB3aXRoIGEgY291
cGxlIG9mIHBhdGNoZXMgdGhhdCBpbnRyb2R1Y2UgZW11bGF0ZWQgRU1FQSBwb3J0Cj4+IHRvIHRo
ZSBXV0FOIEhXIHNpbXVsYXRvci4KPj4gCj4+IFRoZSBzZXJpZXMgaXMgdGhlIHByb2R1Y3Qgb2Yg
dGhlIGRpc2N1c3Npb24gd2l0aCBMb2ljIGFib3V0IHRoZSBwcm9zIGFuZAo+PiBjb25zIG9mIHBv
c3NpYmxlIG1vZGVscyBhbmQgaW1wbGVtZW50YXRpb24uIEFsc28gTXVoYW1tYWQgYW5kIFNsYXJr
IGRpZAo+PiBhIGdyZWF0IGpvYiBkZWZpbmluZyB0aGUgcHJvYmxlbSwgc2hhcmluZyB0aGUgY29k
ZSBhbmQgcHVzaGluZyBtZSB0bwo+PiBmaW5pc2ggdGhlIGltcGxlbWVudGF0aW9uLiBNYW55IHRo
YW5rcy4KPj4gCj4+IENvbW1lbnRzIGFyZSB3ZWxjb21lZC4KPj4gCj4+IENoYW5nZXMgc2luY2Ug
VjE6Cj4+IFVuaWZvcm1seSB1c2UgcHV0X2RldmljZSgpIHRvIHJlbGVhc2UgcG9ydCBtZW1vcnku
IFRoaXMgbWFkZSBjb2RlIGxlc3MKPj4gd2VpcmQgYW5kIHdheSBtb3JlIGNsZWFyLiBUaGFuayB5
b3UsIExvaWMsIGZvciBub3RpY2luZyBhbmQgdGhlIGZpeAo+PiBkaXNjdXNzaW9uIQo+PiAKPj4g
Q2hhbmdlcyBzaW5jZSBWMjoKPj4gQWRkIHN1cHBsZW1lbnQgb2YgTG9pYyBhbmQgU2xhcmsgYWJv
dXQgc29tZSBmaXgKPj4gCj4+IENDOiBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+Cj4+
IENDOiBNdWhhbW1hZCBOdXphaWhhbiA8emFpaGFuQHVucmVhbGFzaWEubmV0Pgo+PiBDQzogUWlh
bmcgWXUgPHF1aWNfcWlhbnl1QHF1aWNpbmMuY29tPgo+PiBDQzogTWFuaXZhbm5hbiBTYWRoYXNp
dmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4KPj4gQ0M6IEpvaGFuIEhvdm9s
ZCA8am9oYW5Aa2VybmVsLm9yZz4KPj4gQ0M6IFNlcmdleSBSeWF6YW5vdiA8cnlhemFub3Yucy5h
QGdtYWlsLmNvbT4KPgo+VWhtLi4uIEkgdGhpbmdoIEkgYWxyZWFkeSBzaGFyZWQgdGhlIGZvbGxv
d2luZyB3aXRoIHlvdSA/IT8KPgo+IyMgRm9ybSBsZXR0ZXIgLSBuZXQtbmV4dC1jbG9zZWQKPgo+
VGhlIG5ldC1uZXh0IHRyZWUgaXMgY2xvc2VkIGZvciBuZXcgZHJpdmVycywgZmVhdHVyZXMsIGNv
ZGUgcmVmYWN0b3JpbmcKPmFuZCBvcHRpbWl6YXRpb25zIGR1ZSB0byB0aGUgbWVyZ2Ugd2luZG93
IGFuZCB0aGUgd2ludGVyIGJyZWFrLiBXZSBhcmUKPmN1cnJlbnRseSBhY2NlcHRpbmcgYnVnIGZp
eGVzIG9ubHkuCj4KPlBsZWFzZSByZXBvc3Qgd2hlbiBuZXQtbmV4dCByZW9wZW5zIGFmdGVyIEph
biAybmQuCj4KPlJGQyBwYXRjaGVzIHNlbnQgZm9yIHJldmlldyBvbmx5IGFyZSBvYnZpb3VzbHkg
d2VsY29tZSBhdCBhbnkgdGltZS4KWWVhaCwgSSBoYXZlIHJlY2VpdmVkIHRoYXQgbm90aWNlLgpT
aW5jZSB0aGVyZSBpcyBhIGhvbGlkYXkgZnJvbSBKYW4gMXN0IHRvIEphbiA0dGgsIHNvIEkgcG9z
dCB0aGVtIHRvIG5ldC1uZXh0IGluIGFkdmFuY2UuCgpZb3UgY2FuIHN0YXJ0IHRvIHJldmlldyBp
dCBhZnRlciBKYW4gMm5kKGFjY29yZGluZyB0byBteSBwcmV2aW91cyBleHBlcmllbmNlLAptYWlu
dGFpbmVyIHdpbGwgaWdub3JlIHRoZXNlIHBhdGNoZXMgdW50aWwgdGhlIG1lcmdlIHdpbmRvdyBp
cyBvcGVuZWQpLgoKVGhhbmsgeW91IGZvciB5b3VyIG5vdGljZSBhZ2Fpbi4KSGFwcHkgbmV3IHll
YXIhCgoK

