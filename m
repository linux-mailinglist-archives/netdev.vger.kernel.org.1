Return-Path: <netdev+bounces-147551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFCB9DA1FB
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 07:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A4EB2208A
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE4145B22;
	Wed, 27 Nov 2024 06:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821ADF51
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687825; cv=none; b=FeXwlA/FdFGk3MoE7mX9LuReYfqljbVAMh5zJp9p46uVy9T71RGx8OY1b5T1aJSevRht/179VwzFwDxcyOKbKWgF8jncJmKb5lsmBANkNAItWyRxM4/EgAHjyNLq9FEMlkc2ZFst/CAV1/eOXS9zAtQVfFW8Rddc0c3FJCBnhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687825; c=relaxed/simple;
	bh=rhYd/WBVinHAqHVUs6/BVwPt+n0Cmrgk1I37Cl/2n6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=RvnzHQFno0iA25ve1En8VuKT1ttcZnp9bkR8JcJXW/Q5K5wlDX3JbA6ji4p9PtKDif5d/bJkolUgdvtoNBnh9GnEJKaZTOHr/Um/f9c6KBo6VSYqaHiAPkag53uImwdmsH7kvJH77cZfx+KeMku4RiNp2meOf+dfOrRTmBjmUfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com; spf=pass smtp.mailfrom=kernelsoft.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from tianyu2$kernelsoft.com ( [106.37.191.2] ) by
 ajax-webmail-mail (Coremail) ; Wed, 27 Nov 2024 14:07:41 +0800 (GMT+08:00)
Date: Wed, 27 Nov 2024 14:07:41 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?55Sw5a6HMg==?= <tianyu2@kernelsoft.com>
To: "Eric Dumazet" <eric.dumazet@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: Re: [RFC] ipv4: remove useless arg
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT5 build
 20230627(00751abc) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <1e418442-722d-488c-858d-8789736b1b5b@gmail.com>
References: <20241126131912.601391-1-tianyu2@kernelsoft.com>
 <1e418442-722d-488c-858d-8789736b1b5b@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <512baaf8.86d5.1936c3b8b2e.Coremail.tianyu2@kernelsoft.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwA3td8tt0ZnESw5Ag--.5380W
X-CM-SenderInfo: xwld05zxs6yvxuqhz2xriwhudrp/1tbiAQAHEmdF-VYCJAAFs+
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gT24gMTEvMjYvMjQgMjoxOSBQTSwgdGlhbnl1MiB3cm90ZToKPiA+IFdoZW4gSSB3YW50ZWQg
dG8ga3Byb2JlIHRoZSBpcF9yY3ZfZmluaXNoX2NvcmUsIEkgZm91bmQgdGhhdCB1c2luZyB4MSB0
bwo+ID4gcGFzcyAic3RydWN0IHNrX2J1ZmYgKnNrYiIuInN0cnVjdCBzb2NrICpzayIgd2FzIG5v
dCB1c2VkIGluIHRoZQo+ID4gZnVuY3Rpb24sIGNhdXNpbmcgdGhlIGNvbXBpbGVyIHRvIG9wdGlt
aXplIGF3YXkuIFRoaXMgcmVzdWx0ZWQgaW4gYQo+ID4gaGFyZCB0byB1c2Uga3Byb2JlLiBXaHkg
bm90IGRlbGV0ZSBoaW0/Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogdGlhbnl1MiA8dGlhbnl1MkBr
ZXJuZWxzb2Z0LmNvbT4KPiA+IC0tLQo+IAo+IFRoaXMgaXMgZ3JlYXQgc2VlaW5nIGNvbXBpbGVy
cyBiZWluZyBzbWFydC4KPiAKPiBTR1RNLCBwbGVhc2Ugc2VuZCB0aGlzIG5leHQgd2VlayB3aGVu
IG5ldC1uZXh0IGlzIG9wZW4gYWdhaW4uCj4gCj4gQWxzbyBkbyB0aGUgc2FtZSBmb3IgaXBfbGlz
dF9yY3ZfZmluaXNoKCkKPiAKT2theSwgdGhhbmtzIGZvciB0aGUgcmVwbHku

