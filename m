Return-Path: <netdev+bounces-109170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7469292733E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194041F2382B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FDD1AAE38;
	Thu,  4 Jul 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="isRSLrha"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1F224D7;
	Thu,  4 Jul 2024 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086072; cv=none; b=ZHuv4Yhap/ZazSVWjOx/czI23J4HddnNPdOGrMTIfe20D5j6ENY3MOhUEQKrJO3XfQ8ub1wxyeDcb2fS2DBKHrYmEOegDEb1iW0JC6PGjdLWDw6P73ZBl6cJi94EAcw2+DtfLBIhbGPkqlI9LVT6zg0XeQZAgPJLaO68kOS58Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086072; c=relaxed/simple;
	bh=mMPWIml4fmuqNzP17nn7jXU4sYGMQrQ+ThjB53XSLlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJC+vupfx7J5vKKqSDuwQ8mqiujZ1VFWvdcRYauQAI0u+6Q2yAmvgLjljPp4ROSokk99p04Rj6vG4UK682orNdlvg+Ue1kg8T55G6m/nD54Te7BAJnSqHuxkvySxUcZjYtL5ckwB77V4+PPKTUQaXhzrGr9KWSow27aV1Xp1/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=isRSLrha; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 05DD120135;
	Thu,  4 Jul 2024 17:40:59 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1720086061;
	bh=mMPWIml4fmuqNzP17nn7jXU4sYGMQrQ+ThjB53XSLlU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=isRSLrha9GnivTp45Oq8bArpvqlzHW/WbojTtjz51vmqgXqO/FgZRxheGqGDSMG9P
	 TY0NzlwVHNvtB9RWmh5LcaNeyC3VeZtlm7Y5gFhNYzYJUQx3BBcBUFZBU0QsS8ymPC
	 7R8Q/jdbAG/yAtfoio5ebntFH83PN5Y0N6NSIeQxmjoudlvlKoOeo8mcCb+l3+pv2K
	 n5oV/Ad38tFRejpBfm1TdeJXeRvzjFZiJj2XiwFvtv+syQbQfQwrNaaJmPD0dNejUP
	 Ok+FpSNeD5wyiQTIGBPqucWsczX7s9Jp+fP1plZFEaitPTit97rIaUNGSzvGkbvgCR
	 TrHNU3GFxZGZw==
Message-ID: <835997d71ae1b68f2eb9f1617dce126f75783aae.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Robert Moore
 <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Johnston
 <matt@codeconstruct.com.au>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
Date: Thu, 04 Jul 2024 17:40:59 +0800
In-Reply-To: <20240702225845.322234-2-admiyo@os.amperecomputing.com>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
	 <20240702225845.322234-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQWRhbSwKCj4gK3N0YXRpYyB2b2lkIGNoZWNrX2FuZF9hY2soc3RydWN0IHBjY19jaGFuX2lu
Zm8gKnBjaGFuLCBzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKg
c3RydWN0IHBjY19leHRlbmRlZF90eXBlX2hkciBwY2NfaGRyOwo+ICsKPiArwqDCoMKgwqDCoMKg
wqBpZiAocGNoYW4tPnR5cGUgIT0gQUNQSV9QQ0NUX1RZUEVfRVhUX1BDQ19TTEFWRV9TVUJTUEFD
RSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ICvCoMKgwqDCoMKg
wqDCoG1lbWNweV9mcm9taW8oJnBjY19oZHIsIHBjaGFuLT5zaG1lbV9iYXNlX2FkZHIsCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCBwY2Nf
ZXh0ZW5kZWRfdHlwZV9oZHIpKTsKPiArwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDC
oCAqIFRoZSBQQ0Mgc2xhdmUgc3Vic3BhY2UgY2hhbm5lbCBuZWVkcyB0byBzZXQgdGhlIGNvbW1h
bmQgY29tcGxldGUgYml0Cj4gK8KgwqDCoMKgwqDCoMKgICogYW5kIHJpbmcgZG9vcmJlbGwgYWZ0
ZXIgcHJvY2Vzc2luZyBtZXNzYWdlLgo+ICvCoMKgwqDCoMKgwqDCoCAqCj4gK8KgwqDCoMKgwqDC
oMKgICogVGhlIFBDQyBtYXN0ZXIgc3Vic3BhY2UgY2hhbm5lbCBjbGVhcnMgY2hhbl9pbl91c2Ug
dG8gZnJlZSBjaGFubmVsLgo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoGlm
ICghIWxlMzJfdG9fY3B1cCgmcGNjX2hkci5mbGFncykgJiBQQ0NfQUNLX0ZMQUdfTUFTSykKClRo
aXMgc2hvdWxkIGJlOgoKwqDCoMKgwqDCoMKgwqBpZiAoISEobGUzMl90b19jcHVwKCZwY2NfaGRy
LmZsYWdzKSAmIFBDQ19BQ0tfRkxBR19NQVNLKSkKCi0gb3RoZXJ3aXNlIHlvdSdyZSBiaXR3aXNl
IHRlc3RpbmcgdGhlIHJlc3VsdCBvZiB0aGUgJyEhJy4KCkNoZWVycywKCgpKZXJlbXkK


