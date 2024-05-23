Return-Path: <netdev+bounces-97676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821718CCA6E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 03:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF68B1C20E12
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 01:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F075A34;
	Thu, 23 May 2024 01:46:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0074685;
	Thu, 23 May 2024 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428819; cv=none; b=b5n4lfPlG9+VVB4L4hs8L5x5UbPhHfekYkIat4vmxjKZhug3asacRJUkFYxsSZBH4YKLKMuZHANHvZxmlXc+QGq8twsz+DYqrhztOIxe+gKSai0hoB/9z6PG/ej8xhdCRsBPVv1Ej/wP2Pv88pZXc1oOjwqgL/+Jm8AhD9HNNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428819; c=relaxed/simple;
	bh=qTz1td/mi0RpM4QoyHCs5wFBn/jKg7dIfQXTpEFTgo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=L0NLvvwaYZnwtv1LLAflW8UWQGnSdnUMJLOOyNVByumNFFZFmp0YJVjgBfs5OyZk7gT4QVYFcQ5RYBFw96OPCIYQbjoq5AohzBOVs/Ez4cpKU6/+2W1sd8vn5grN4IM5Cm2FgxhZ3xZdzrHDGdv1XweJfWoCy39YE/Cx5TOMwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [42.120.103.56] ) by
 ajax-webmail-mail-app3 (Coremail) ; Thu, 23 May 2024 09:44:15 +0800
 (GMT+08:00)
Date: Thu, 23 May 2024 09:44:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Simon Horman" <horms@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	larysa.zaremba@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ila: avoid genlmsg_reply when not ila_map
 found
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn zju.edu.cn
In-Reply-To: <20240522170302.GA883722@kernel.org>
References: <20240522031537.51741-1-linma@zju.edu.cn>
 <20240522170302.GA883722@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <44456b54.180f2.18fa31eca2b.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgBn4Vhwn05mtGbmAA--.26237W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMCEmZDiAoQOgAos1
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgU2ltb24uCgo+IAo+IEhpIExpbiBNYSwKPiAKPiBUaGUgbGluZXMgaW1tZWRpYXRlbHkgYWJv
dmUgdGhvc2UgY292ZXJlZCBieSB0aGlzIHBhdGNoIGFyZSBhcyBmb2xsb3dzOgo+IAo+IAlyZXQg
PSAtRVNSQ0g7Cj4gCWlsYSA9IGlsYV9sb29rdXBfYnlfcGFyYW1zKCZ4cCwgaWxhbik7Cj4gCWlm
IChpbGEpIHsKPiAJCXJldCA9IGlsYV9kdW1wX2luZm8oaWxhLAo+IAo+ID4gQEAgLTQ4Myw2ICs0
ODMsOCBAQCBpbnQgaWxhX3hsYXRfbmxfY21kX2dldF9tYXBwaW5nKHN0cnVjdCBza19idWZmICpz
a2IsIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pCj4gPiAgCQkJCSAgICBpbmZvLT5zbmRfcG9ydGlk
LAo+ID4gIAkJCQkgICAgaW5mby0+c25kX3NlcSwgMCwgbXNnLAo+ID4gIAkJCQkgICAgaW5mby0+
Z2VubGhkci0+Y21kKTsKPiA+ICsJfSBlbHNlIHsKPiA+ICsJCXJldCA9IC1FSU5WQUw7Cj4gPiAg
CX0KPiA+ICAKPiA+ICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gCj4gQW5kIHRoZSBsaW5lcyBmb2xs
b3dpbmcsIHVwIHRvIHRoZSBlbmQgb2YgdGhlIGZ1bmN0aW9uLCBhcmU6Cj4gCj4gCWlmIChyZXQg
PCAwKQo+IAkJZ290byBvdXRfZnJlZTsKPiAKPiAJcmV0dXJuIGdlbmxtc2dfcmVwbHkobXNnLCBp
bmZvKTsKPiAKPiBvdXRfZnJlZToKPiAJbmxtc2dfZnJlZShtc2cpOwo+IAlyZXR1cm4gcmV0Owo+
IAo+IEJ5IG15IHJlYWRpbmcsIHdpdGhvdXQgeW91ciBwYXRjaCwgaWYgaWxhIGlzIG5vdCBmb3Vu
ZCAoTlVMTCkKPiB0aGVuIHJldCB3aWxsIGJlIC1FU1JDSCwgYW5kIGdlbmxtc2dfcmVwbHkgd2ls
bCBub3QgYmUgY2FsbGVkLgo+IAo+IEkgZmVlbCB0aGF0IEkgYW0gbWlzc2luZyBzb21ldGhpbmcg
aGVyZS4KCk9oIG15IGJhZCwgaXQgc2VlbXMgdGhpcyBidWcgd2FzIGFscmVhZHkgZml4ZWQgYnkg
dGhlCmNvbW1pdCA2OTNhYTJjMGQ5YjYgKCJpbGE6IGRvIG5vdCBnZW5lcmF0ZSBlbXB0eSBtZXNz
YWdlcwppbiBpbGFfeGxhdF9ubF9jbWRfZ2V0X21hcHBpbmcoKSIpIGxhc3QgeWVhci4KQW5kIG15
IGRhdGVkIGtlcm5lbCBkb2VzIG5vdCBhcHBseSB0aGF0IG9uZS4KClRoYW5rcyBmb3IgcmVtaW5k
aW5nIG1lIG9mIHRoaXMgZmFsc2UgYWxhcm0uCgpSZWdhcmRzCkxpbgo=

