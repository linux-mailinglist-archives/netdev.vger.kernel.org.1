Return-Path: <netdev+bounces-148786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D69E3201
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923D728336C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E2374FF;
	Wed,  4 Dec 2024 03:18:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9135FB95
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282332; cv=none; b=sXdh16BnJR6PGsswGxiTfVd7VipLUTUsRQDCeB/AuAjqcSjbT/wLz6FGf3Xe2+XipcrqCXJtdcX0qGhhrxGSa5PahNPxxxYMq3h43vc04lC65DISvrGN8++1T/AQShHn6CCXQmgSHoqhPyJtCxIrfhTLSByqFo+i2qTBJmSqcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282332; c=relaxed/simple;
	bh=HIC/xw/3u5idZ+sbyTFTtzwri9JhABVCtEy07DUj9AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aXWrSMN7Wq9dxusSnVQP4ExBEzdDly+F522yCThXJFlKGJ0IwdPNsSe+orY3NJuALXoUzZBc5lwYCRE8z1g6MjFhbsxQKax570wDyrQ48LmN4YMTua1JwbJE4AJMc5i4xcgwKzMqm3qZS1mARRMlwAMIRTeOg65JPEoLAwzjJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com; spf=pass smtp.mailfrom=kernelsoft.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from tianyu2$kernelsoft.com ( [106.37.191.2] ) by
 ajax-webmail-mail (Coremail) ; Wed, 4 Dec 2024 11:16:02 +0800 (GMT+08:00)
Date: Wed, 4 Dec 2024 11:16:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: tianyu2 <tianyu2@kernelsoft.com>
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: eric.dumazet@gmail.com, "Pablo Neira Ayuso" <pablo@netfilter.org>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] ipv4: remove useless arg
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT5 build
 20230627(00751abc) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <85376cf2-0c95-4a08-bcbb-33c30c2f2c51@redhat.com>
References: <20241202033230.870313-1-tianyu2@kernelsoft.com>
 <85376cf2-0c95-4a08-bcbb-33c30c2f2c51@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <68a6773c.8deb.1938faae78c.Coremail.tianyu2@kernelsoft.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwBn5uByyU9n5hZVAg--.5757W
X-CM-SenderInfo: xwld05zxs6yvxuqhz2xriwhudrp/1tbiAQAOEmdPN9YBTwAAsa
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiBPbiAxMi8yLzI0IDA0OjMyLCB0aWFueXUyIHdyb3RlOgo+ID4gVGhlICJzdHJ1Y3Qgc29j
ayAqc2siIHBhcmFtZXRlciBpbiBpcF9yY3ZfZmluaXNoX2NvcmUgaXMgdW51c2VkLCB3aGljaAo+
ID4gbGVhZHMgdGhlIGNvbXBpbGVyIHRvIG9wdGltaXplIGl0IG91dC4gQXMgYSByZXN1bHQsIHRo
ZQo+ID4gInN0cnVjdCBza19idWZmICpza2IiIHBhcmFtZXRlciBpcyBwYXNzZWQgdXNpbmcgeDEu
IEFuZCB0aGlzIG1ha2Uga3Byb2JlCj4gPiBoYXJkIHRvIHVzZS4KPiA+IAo+ID4gU2lnbmVkLW9m
Zi1ieTogdGlhbnl1MiA8dGlhbnl1MkBrZXJuZWxzb2Z0LmNvbT4KPiAKPiBUaGUgcGF0Y2ggY29k
ZSBnb29kLCBidXQgdGhlIGFib3ZlIGRvZXMgbm90IGxvb2sgbGlrZSBhIHJlYWwgbmFtZT8hPwo+
IAo+IElmIHNvLCBwbGVhc2UgcmUtc3VibWl0LCB1c2luZyB5b3VyIHJlYWwgZnVsbCBuYW1lIGFu
ZCBpbmNsdWRpbmcgdGhlCj4gdGFyZ2V0IHRyZWUgKG5ldC1uZXh0IGluIHRoaXMgY2FzZSkgaW4g
dGhlIHN1YmogcHJlZml4Lgo+IAo+IFNlZToKPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92Ni4xMi4xL3NvdXJjZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRj
aGVzLnJzdCNMNDQwCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTIuMS9z
b3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2LnJzdCNMMTIKPiAK
PiBAUGFibG86IGFmdGVyIHRoaXMgY2hhbmdlIHdpbGwgYmUgbWVyZ2VkLCBJICp0aGluayogdGhh
dCBhIHBvc3NpYmxlCj4gZm9sbG93LXVwIGNvdWxkIGRyb3AgdGhlICdzaycgYXJnIGZyb20gTkZf
SE9PS19MSVNUIGFuZCBpcF9yY3ZfZmluaXNoKCkgdG9vLgo+IAo+IFRoYW5rcyEKPiAKPiBQYW9s
bwoKVGhhbmsgeW91IGZvciB0aGUgcmVtaW5kZXIuIEnigJlsbCBhZGp1c3QgdGhlIHBhdGNoIGZv
cm1hdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKSWYgaXBfcmN2X2ZpbmlzaCBpcyBtb2RpZmllZCwg
IE5GX0hPT0svTkZfSE9PS19MSVNUIGFsc28gbmVlZHMgdG8gYmUgYWRqdXN0ZWQuIEkgbm90aWNl
ZCB0aGF0IG1hbnkgcGxhY2VzIHVzZSBORl9IT09LLiBUaGVzZSBtb2RpZmljYXRpb25zIHNob3Vs
ZCBiZSBmaW5lLCByaWdodD8KCkhvd2V2ZXIsIEkgZm91bmQgdGhhdCB0aGUgaXBfcmN2X2Zpbmlz
aCBmdW5jdGlvbiBkb2VzbuKAmXQgc2VlbSB0byBiZSBvcHRpbWl6ZWQgYnkgdGhlIGNvbXBpbGVy
LgooQVJNNjQpKCBnY2MgdmVyc2lvbiA4LjUuMCAyMDIxMDUxNCAoUmVkIEhhdCA4LjUuMC00KSAo
R0NDKSApCgpmZmZmODAwMDgwZmFhZjljIHQgaXBfcmN2X2NvcmUuaXNyYS4yNgpmZmZmODAwMDgw
ZmFiMzM0IHQgaXBfcmN2X2ZpbmlzaF9jb3JlCmZmZmY4MDAwODBmYWI3NTggdCBpcF9yY3ZfZmlu
aXNoCmZmZmY4MDAwODBmYWI3YjQgdCBpcF9zdWJsaXN0X3Jjdgo=

