Return-Path: <netdev+bounces-250414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEBFD2AA44
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFF4300EA0C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE130C631;
	Fri, 16 Jan 2026 03:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eq1Xc9Yn"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D718FC86;
	Fri, 16 Jan 2026 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533553; cv=none; b=Olt/eOOpRniculX394VogPuCGD6Jy4Tk4Qctvuiwj6jbVE41dSWO97jdUIaoJZcWtVpChohG+cTa6naRZZAw25ygZfyUUrAkkDx4zFtEyijO1nqZ4Fq/5oNS2udfjhnbjFZV2z0Uig+tR9mLbUSVzXrL1k7B8+MuaEYNf30h+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533553; c=relaxed/simple;
	bh=hjtj2O2no2i2PzcNkxxE0DC9nPNrZZdOR4UYu/VXJVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BwK/g4rrd3U4pDQDZXnGkPS4F6jNy54tZZN6b/ZN3CGsOzT/RXblPj4WMOr2h+FHElvKTAdvAXrRWJXw5Zaat0ec81CWEtvzgou0WfwtiMWL3FXkPcbGx2Vq4CUDsWgyPSjk2BOQS3h39kipG+uEb5oZkOT3HeRoYYBHmmDtfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eq1Xc9Yn; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hjtj2O2no2i2PzcNkxxE0DC9nPNrZZdOR4UYu/VXJVA=; b=e
	q1Xc9YnqSYx0SlhaXdco6TB5fRU8Vj8cLlgJBzDZjlijTZDPZsr7Mtt8A+vz9gkJ
	sv2APU5CuQVF+OclhLOeTKcEuTkpEDC97CdWJbqy1gSgyNfhDUWTfqP9fZRvxxy5
	bwcW2hbSubCHqbjXob8YfEUgBCJb/IbK+IMnOAAZLc=
Received: from slark_xiao$163.com ( [112.97.202.229] ) by
 ajax-webmail-wmsvr-40-133 (Coremail) ; Fri, 16 Jan 2026 11:18:09 +0800
 (CST)
Date: Fri, 16 Jan 2026 11:18:09 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [net-next v7 0/8] net: wwan: add NMEA port type support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260115184352.6dd62bb6@kernel.org>
References: <20260115114625.46991-1-slark_xiao@163.com>
 <20260115184352.6dd62bb6@kernel.org>
X-NTES-SC: AL_Qu2dCvmYvEwj7yiZYekfn0YTguc2WcG3vf0k2YFRc8AFni3K5Toub1VqG1jT6fqjLSGDnje3QRpg9sRlUJlewM9Kz8xy5oTSJNI2snzMXw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <608225e0.3180.19bc4cf78a3.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hSgvCgD3O1TxrWlpReZYAA--.39170W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvxFcwGlprfGVHQAA3m
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTAxLTE2IDEwOjQzOjUyLCAiSmFrdWIgS2ljaW5za2kiIDxrdWJhQGtlcm5lbC5v
cmc+IHdyb3RlOgo+T24gVGh1LCAxNSBKYW4gMjAyNiAxOTo0NjoxNyArMDgwMCBTbGFyayBYaWFv
IHdyb3RlOgo+PiBUaGUgc2VyaWVzIGludHJvZHVjZXMgYSBsb25nIGRpc2N1c3NlZCBOTUVBIHBv
cnQgdHlwZSBzdXBwb3J0IGZvciB0aGUKPj4gV1dBTiBzdWJzeXN0ZW0uIFRoZXJlIGFyZSB0d28g
Z29hbHMuIEZyb20gdGhlIFdXQU4gZHJpdmVyIHBlcnNwZWN0aXZlLAo+PiBOTUVBIGV4cG9ydGVk
IGFzIGFueSBvdGhlciBwb3J0IHR5cGUgKGUuZy4gQVQsIE1CSU0sIFFNSSwgZXRjLikuIEZyb20K
Pj4gdXNlciBzcGFjZSBzb2Z0d2FyZSBwZXJzcGVjdGl2ZSwgdGhlIGV4cG9ydGVkIGNoYXJkZXYg
YmVsb25ncyB0byB0aGUKPj4gR05TUyBjbGFzcyB3aGF0IG1ha2VzIGl0IGVhc3kgdG8gZGlzdGlu
Z3Vpc2ggZGVzaXJlZCBwb3J0IGFuZCB0aGUgV1dBTgo+PiBkZXZpY2UgY29tbW9uIHRvIGJvdGgg
Tk1FQSBhbmQgY29udHJvbCAoQVQsIE1CSU0sIGV0Yy4pIHBvcnRzIG1ha2VzIGl0Cj4+IGVhc3kg
dG8gbG9jYXRlIGEgY29udHJvbCBwb3J0IGZvciB0aGUgR05TUyByZWNlaXZlciBhY3RpdmF0aW9u
Lgo+Cj5JJ20gZ29pbmcgdG8gcmVsZWFzZSB0aGUgcmVzdWx0cyBvZiBBSSBjb2RlIHJldmlldy4g
U2luY2UgeW91IGlnbm9yZWQKPnRoZSByZXBvc3RpbmcgcGVyaW9kIHdpdGggdGhpcyB2ZXJzaW9u
IHBsZWFzZSBkbyBub3QgcG9zdCB2OCB1bnRpbAo+bmV4dCB3ZWVrLgoKU29ycnksIEkgZGlkbid0
IG1lYW4gdG8gYnJlYWsgdGhlc2UgcnVsZXMuIEFuZCBJIHNlbnQgdjcgYmVmb3JlIHlvdSBwcmV2
aW91cyB3YXJtIG5vdGljZSBpbiB2Ni4KQW55d2F5LCBJIHdpbGwgZm9sbG93IGl0IGluIGZ1dHVy
ZS4=

