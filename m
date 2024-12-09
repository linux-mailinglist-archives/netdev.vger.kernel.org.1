Return-Path: <netdev+bounces-150019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2329E891A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 03:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C230283131
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 02:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD77D219ED;
	Mon,  9 Dec 2024 02:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1A4C91
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733709987; cv=none; b=aiB6Ih0C9258olpNVGHUBAFHIcHJdSkk5ngRBhYSX6wHX3A/vhK/t/iQ6Dor5E72FOhI0vaYanu5PhJVoimHjgHQX0ur72AoeydGoUPdXphbcpO9N3+xyQEmxS1gudiMxw3vjI4GpwHKDe5gjx97lCEkaHby5LsujnVFgRJ9kgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733709987; c=relaxed/simple;
	bh=aVWyHxT+EoQsLRG/XktewLj4PAWa97k0keeAUErujD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lu9GafsfcbBg5+Z2uAxrjKhPL7jEpomemuVhIL6FCDGLjyPdDqIEH/t08Fi8nHaEpulLP+nS8rdFHC/LMp49ynwF0sgrViCdEXFKrcKHYS3vp9mhShnLMbC0bbowjbIA9CrFdmaLnmWcD4QwypZoGIBBoteJZkxmsn6PDOvTViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com; spf=pass smtp.mailfrom=kernelsoft.com; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from tianyu2$kernelsoft.com ( [106.37.191.2] ) by
 ajax-webmail-mail (Coremail) ; Mon, 9 Dec 2024 10:03:20 +0800 (GMT+08:00)
Date: Mon, 9 Dec 2024 10:03:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: tianyu2 <tianyu2@kernelsoft.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ipv4: remove useless arg
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT5 build
 20230627(00751abc) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <20241207175459.0278112b@kernel.org>
References: <20241205130454.3226-1-tianyu2@kernelsoft.com>
 <20241207175459.0278112b@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2ce18155.9222.193a928231d.Coremail.tianyu2@kernelsoft.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwD3dN_oT1ZntT5rAg--.6157W
X-CM-SenderInfo: xwld05zxs6yvxuqhz2xriwhudrp/1tbiAQAQEmdR2tcBKAAEsV
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKCj4gT24gVGh1LCAgNSBEZWMgMjAyNCAyMTowNDo1NCArMDgwMCB0aWFueXUyIHdyb3RlOgo+
ID4gU2lnbmVkLW9mZi1ieTogdGlhbnl1MiA8dGlhbnl1MkBrZXJuZWxzb2Z0LmNvbT4KPiAKPiBB
cyBQYW9sbyBhbHJlYWR5IHBvaW50ZWQgb3V0IHRoZSBuYW1lIHBvcnRpb24gb2YgdGhlIHNpZ24g
b2ZmIHRhZwo+IHNob3VsZCBiZSB0aGUgQW5nbGljaXNlZCg/KSBmb3JtIG9mIHlvdXIgbmFtZSwg
bm90IHRoZSByZXBlYXQgb2YKPiB5b3VyIGxvZ2luLgo+IC0tIAo+IHB3LWJvdDogY3IKClllcywg
aXQncyBmaW5lIHdpdGggdGhhdCBuYW1lLg==

