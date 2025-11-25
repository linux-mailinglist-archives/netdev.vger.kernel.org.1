Return-Path: <netdev+bounces-241381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB03BC833DE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B04E3707
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84A23B627;
	Tue, 25 Nov 2025 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="WcGVnIVy"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DA238176;
	Tue, 25 Nov 2025 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041547; cv=none; b=Jg+DaGrL5pbJqYWWH6/WuV31Yj1Mspu6pK5qO26PZoI/YPrR2VKg3/xCkUdDmv0GdvdSdXcT2qVdn3/QVTWjoVPki3uIRJb5Sr0OY3VktqVKeQ86iIOJzhz/FI8bSmRPS0ax7NxHuHKEjvjtUmdjSOGKyiIhjhYEPp7r3uUGQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041547; c=relaxed/simple;
	bh=+6Bo3EQJyFJDvbGos3+e8CFFrzExkKKU+s+6eN0bX80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Nhgf/Dfa8QOLxhtJ+Yqak6J4HWpQDB8jblTAIdVyKBJ2w97NbiUiJCm6nQioUlVM6Y3y+bnJVwMT3ISDlPub29yCE/3on7y9yj4MIEPZzMhUJIw/8XpjtiLujMdr/8wahjCtFjwqdCuRBtnPDAksAxrKutg5RQV5ZxW7EnEkayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=WcGVnIVy reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=fa2v8bqj7XkNuZ9HRDIyOsgTJaX2OL4PRvQ5iRJ73V8=; b=W
	cGVnIVy+ngQYtRoUya8LWKDfYz2tbKBSMG8U5rAV7Bhd+ZQaX3DoGeCtDjR1UDpg
	L111XAZtFXNhsZy5w4oGlwq5BA+zaxGi3XqNc3rs+PWm8IF14w3z4/ix/z7QyqtC
	7bduBKvE0QYJz7cZQbeiNYrjAQN4tEVVVFEnAFhtVU=
Received: from slark_xiao$163.com ( [112.97.86.199] ) by
 ajax-webmail-wmsvr-40-145 (Coremail) ; Tue, 25 Nov 2025 11:31:23 +0800
 (CST)
Date: Tue, 25 Nov 2025 11:31:23 +0800 (CST)
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
In-Reply-To: <20251124192111.566126f9@kernel.org>
References: <20251120114115.344284-1-slark_xiao@163.com>
 <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
 <605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
 <CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
 <623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
 <20251124184219.0a34e86e@kernel.org>
 <33bc243d.33c6.19ab8fa1cb4.Coremail.slark_xiao@163.com>
 <20251124191226.5c4efa14@kernel.org>
 <2188324.36f7.19ab902e6b5.Coremail.slark_xiao@163.com>
 <20251124192111.566126f9@kernel.org>
X-NTES-SC: AL_Qu2dBvyfvkwj5SmcY+kfmk8Sg+84W8K3v/0v1YVQOpF8jCvr1wwvfEV5A37r3OS2MCGAlzmbfQFAyedmcIpqVZgH/wmrwJTDCJw3qhGtDrRu6Q==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1a29d59a.3b7b.19ab910e6bc.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kSgvCgCn3sEMIyVpgCsqAA--.4063W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbibhsRZGklIAYRpQADsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMTEtMjUgMTE6MjE6MTEsICJKYWt1YiBLaWNpbnNraSIgPGt1YmFAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBUdWUsIDI1IE5vdiAyMDI1IDExOjE2OjA2ICswODAwIChDU1QpIFNsYXJr
IFhpYW8gd3JvdGU6Cj4+IEF0IDIwMjUtMTEtMjUgMTE6MTI6MjYsICJKYWt1YiBLaWNpbnNraSIg
PGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6Cj4+ID5PbiBUdWUsIDI1IE5vdiAyMDI1IDExOjA2OjMw
ICswODAwIChDU1QpIFNsYXJrIFhpYW8gd3JvdGU6ICAKPj4gPj4gPkFyZSB5b3Ugc2F5aW5nIHlv
dSBoYXZlIHRvIGNvbmN1cnJlbnQgc3VibWlzc2lvbnMgY2hhbmdpbmcgb25lIGZpbGU/Cj4+ID4+
ID5JZiB5ZXMgcGxlYXNlIHJlcG9zdCB0aGVtIGFzIGEgc2VyaWVzLiAgICAKPj4gPj4gT25lIHBh
dGNoIG9mIHByZXZpb3VzIHNlcmllcyBoYXMgYmVlbiBhcHBsaWVkLiAgIAo+PiA+Cj4+ID5UbyB0
aGUgbWhpIHRyZWU/ICAKPj4gCj4+IFllcy4gSXQgaGFzIGJlZW4gYXBwbGllZCB0byBtaGktbmV4
dCBicmFuY2guIFRoYXQgcGF0Y2ggYXBwbGllZAo+PiBiZWZvcmUgcG9zdGluZyB0aGlzIHBhdGNo
IC4KPgo+SW4gdGhpcyB0cmVlPyAKPmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L21hbmkvbWhpLmdpdC8KWWVzLiAKPlRoYXQnZCBiZSB1bmFjY2VwdGFibGUg
Zm9yIGEgZHJpdmVycy9uZXQvIHBhdGNoLgo+QnV0IEkgZG9uJ3Qgc2VlIHN1Y2ggYSBwYXRjaCBo
ZXJlLiAKPkp1c3QgcGF0Y2hlcyB0byBkcml2ZXJzL2J1cy9taGkvClRoZSBwYXRjaCBmb3IgZHJp
dmVycy9uZXQgc3RpbGwgaW4gYSByZXZpZXdlZCBzdGF0dXMsIGJ1dCBub3QgYXBwbGllZC4KTUhJ
IHNpZGUgaGFzIGluZm9ybSBORVQgc2lkZSBhYm91dCB0aGUgYXBwbHkgc3RhdHVzLiAKaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzE3NjM2MTc1MTQ3MS42MDM5LjE0NDM3ODU2MzYwOTgw
MTI0Mzg4LmI0LXR5QG9zcy5xdWFsY29tbS5jb20vCgpTbyBjdXJyZW50bHkgaXQgc2hhbGwgYmUg
cGVuZGluZyBpbiBORVQgc2lkZT8K

