Return-Path: <netdev+bounces-241090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F04FC7ED1C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 03:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703243A4ED7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F35F284884;
	Mon, 24 Nov 2025 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="AEJSLbl7"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2C157487;
	Mon, 24 Nov 2025 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763951503; cv=none; b=Sd8LyB4Kdva+lgPe9Hvp4yIhjY1r75rVeJRXAGzMQebYm987IG9B9UUysi38P9g5lw/1mRT6Aw11lbPgFKOhGQ7lRm2Sr+tQFJUDpuEDNFuqFwt1jtYo8/HI9BC8i/r9yZJsus+fahxEDjRQSPKjOHSyw65lS/4WIEBlDXkdRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763951503; c=relaxed/simple;
	bh=0Omha8nDxPzWu7D0N9kyjuC3D6uvxAIL7iqETfQPxeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ZELp6bDdKQQyc/RrQ5OJcT+Zavb5OOBBOVxTP0J1qePAtYhrDhP8b/u1QWz+c3Af2AFUNIbXsNwjy2P9YgaLSbBvVMlhECTkYrZ7hNlac27DetgVPdZ9G7daFrxM918lFXh3t19AMnCrqITcK5x+nef9BWP5S8WQjyMndtJp+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=AEJSLbl7 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=cmEp/iL8HB5Ap92boTZxiQyGcHnIk9EEkpQNUiqwF6E=; b=A
	EJSLbl7uFRC7Gls/GIEzoZimiJ3VVHwaoI72pdhz2IGldSvjx4exYJhhaQUMbs2H
	yt6OJ6nZ2l6C3pc2TiE5DwP26yjETSMWTQ7LD1Dc8vPYK2zSE7cgIu+XaHxsFKOV
	nwmogHLvNkr5+QJ4ifZBRr9JoFN28qcdud1lw44h04=
Received: from slark_xiao$163.com ( [112.97.80.230] ) by
 ajax-webmail-wmsvr-40-119 (Coremail) ; Mon, 24 Nov 2025 10:30:56 +0800
 (CST)
Date: Mon, 24 Nov 2025 10:30:56 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
References: <20251120114115.344284-1-slark_xiao@163.com>
 <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
X-NTES-SC: AL_Qu2dAfWevkwu4CSfYekfmk8Sg+84W8K3v/0v1YVQOpF8jD7p+B0OW15iJGbm7vmrFA6dqjWaQDJ88spGbbNqVpAInJRqPY4N06y3eLNCYCO5bQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:dygvCgD338hgwyNpwr4oAA--.792W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwAAskGkjw2CDSgAA3c
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTEtMjIgMTA6MDg6MzYsICJKYWt1YiBLaWNpbnNraSIgPGt1YmFAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBUaHUsIDIwIE5vdiAyMDI1IDE5OjQxOjE1ICswODAwIFNsYXJrIFhpYW8g
d3JvdGU6Cj4+IENvcnJlY3QgaXQgc2luY2UgTS4yIGRldmljZSBUOTlXNjQwIGhhcyB1cGRhdGVk
IGZyb20gVDk5VzUxNS4KPj4gV2UgbmVlZCB0byBhbGlnbiBpdCB3aXRoIE1ISSBzaWRlIG90aGVy
d2lzZSB0aGlzIG1vZGVtIGNhbid0Cj4+IGdldCB0aGUgbmV0d29yay4KPj4gCj4+IEZpeGVzOiBh
ZTVhMzQyNjQzNTQgKCJidXM6IG1oaTogaG9zdDogcGNpX2dlbmVyaWM6IEZpeCB0aGUgbW9kZW0g
bmFtZSBvZiBGb3hjb25uIFQ5OVc2NDAiKQo+PiBGaXhlczogNjViYzU4YzNkY2FkICgibmV0OiB3
d2FuOiBtaGk6IG1ha2UgZGVmYXVsdCBkYXRhIGxpbmsgaWQgY29uZmlndXJhYmxlIikKPj4gU2ln
bmVkLW9mZi1ieTogU2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPgo+Cj5Eb2Vzbid0IGFw
cGx5IHRvIGVpdGhlciBuZXR3b3JraW5nIHRyZWUgOigKSSBoYXZlIGNjIHRoZSBlbWFpbCBhZGRy
ZXNzIGJ5IHRoZSBzeXN0ZW0gY29tbWFuZCAKInNjcmlwdHMvZ2V0X21haW50YWluZXIucGwgcGF0
Y2giLiBEbyB5b3UgbWVhbiBzaGFsbCBJIHJlbW92ZQpuZXRkZXZAdmdlci5rZXJuZWwub3JnIGJ5
IG1hbnVhbD8KPi0tIAo+cHctYm90OiBjcgo=

