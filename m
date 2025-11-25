Return-Path: <netdev+bounces-241374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 061A9C83344
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78B8234C73D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C621DF246;
	Tue, 25 Nov 2025 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="J1981Hlv"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774573BB40;
	Tue, 25 Nov 2025 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040618; cv=none; b=NOOeRkVnrrUBc+GbSk56toO7p/TsGuV6teIvo9HUYbQvmUjg1dzLeXAz3stqkm7NP6BW/GxgUVqIUINRNCmxe7qJ19EIbvq82Qmilrzt+ZZY6M4ytu8PKxKUsNualzYUe6vaEqBRRUrEdXz+ZkuX5HlNqIKGR/W3kB6d1Mk6QJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040618; c=relaxed/simple;
	bh=Eb+CsBLKRF4bX6YeAxTeNsqj12I40NF7LuYhu0I8WpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=UL4R0EnURog5Yqjmlx8kLqbcVMqWceuaeiIexY5ymDFUDqJENPRoi7/xZ6oCOPcpvAZq8nFYsKDEBcKI9+V9y2RcOmToWj2ipeRlE32ylmwNoBqJ29D4V57Ov4nmxaXxFVrx8CoHv/geJb1suA95N0lG2YOyKTnPgrfwDU4VaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=J1981Hlv reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=kduv4pqZzHOHB0/LoCeVpOKG+nGLj211R3Y/2LFcRZE=; b=J
	1981Hlvlc6IXj3R/5ZjG+AWK1FCQaJddFSDcWEMnJ4hIIlAzeVy4yIuuR/SVwYLJ
	edKbL+9brtvpU/ReveZlZ8g8TDDMvY+5ISXACdWtQp6Llj6zkBObDuL6gAO9hZlR
	f5RcV8Eb3uZBLZ73bFGSsfnCNJyweZzI13uNxcGRkk=
Received: from slark_xiao$163.com ( [112.97.86.199] ) by
 ajax-webmail-wmsvr-40-145 (Coremail) ; Tue, 25 Nov 2025 11:16:06 +0800
 (CST)
Date: Tue, 25 Nov 2025 11:16:06 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20251124191226.5c4efa14@kernel.org>
References: <20251120114115.344284-1-slark_xiao@163.com>
 <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
 <605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
 <CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
 <623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
 <20251124184219.0a34e86e@kernel.org>
 <33bc243d.33c6.19ab8fa1cb4.Coremail.slark_xiao@163.com>
 <20251124191226.5c4efa14@kernel.org>
X-NTES-SC: AL_Qu2dBvyfv00t4CScZOkfmk8Sg+84W8K3v/0v1YVQOpF8jCvr1wwvfEV5A37r3OS2MCGAlzmbfQFAyedmcIpqVZgHlfznoG2ORH+gm+duRxYKrQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2188324.36f7.19ab902e6b5.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kSgvCgD3F9N2HyVpJCUqAA--.4069W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvxaI7GklH3YtcwAA32
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTEtMjUgMTE6MTI6MjYsICJKYWt1YiBLaWNpbnNraSIgPGt1YmFAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBUdWUsIDI1IE5vdiAyMDI1IDExOjA2OjMwICswODAwIChDU1QpIFNsYXJr
IFhpYW8gd3JvdGU6Cj4+ID5BcmUgeW91IHNheWluZyB5b3UgaGF2ZSB0byBjb25jdXJyZW50IHN1
Ym1pc3Npb25zIGNoYW5naW5nIG9uZSBmaWxlPwo+PiA+SWYgeWVzIHBsZWFzZSByZXBvc3QgdGhl
bSBhcyBhIHNlcmllcy4gIAo+PiBPbmUgcGF0Y2ggb2YgcHJldmlvdXMgc2VyaWVzIGhhcyBiZWVu
IGFwcGxpZWQuIAo+Cj5UbyB0aGUgbWhpIHRyZWU/CgpZZXMuIEl0IGhhcyBiZWVuIGFwcGxpZWQg
dG8gbWhpLW5leHQgYnJhbmNoLiBUaGF0IHBhdGNoIGFwcGxpZWQgYmVmb3JlIHBvc3RpbmcgdGhp
cwpwYXRjaCAuCg==

