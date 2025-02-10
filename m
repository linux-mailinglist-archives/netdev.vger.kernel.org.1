Return-Path: <netdev+bounces-164543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C35A2E21C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2781886E94
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58E20330;
	Mon, 10 Feb 2025 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GlBL9go3"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80B224CC;
	Mon, 10 Feb 2025 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739152647; cv=none; b=bSYWFcGDWPe/Iy950ythyA6D+/CZredw1quoquxgtDElqVOHWTPERKDdM4keMS4hXMHxLBNM1Aoa7lo86XCTuHQTnce8cKUjnQIYLR5rMz8b2LmjB+Y+iAuaq1UyndhVCUuY0th3FdwZBSFY/U2KkxapKJnoA2si7+xWAarJyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739152647; c=relaxed/simple;
	bh=hY6SLaFofQHWIkZnK6V8wfiHkkONFQowAhTesbBIjZs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TTE0uTAKr8waEbF+jPg+SQmpdRX9X7Km2UHrxf5udh9V1AjFwoqrW/uFI3dshHpRh8oqoQs8Vmofot4f50o8c+9n3AlFuT50ZPbuzc+M+Gncb7OA6wiVhANGoSgL0Cfp6dthJap4p4rHg38GsJOs9S3qcS/SR5b2GumnO1RAoB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GlBL9go3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739152636;
	bh=hY6SLaFofQHWIkZnK6V8wfiHkkONFQowAhTesbBIjZs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GlBL9go3LduLwZjz7RV69JIbFKGF2r+ziV+Rw76/4mpgkEpSSvcNrdDjF7IjQNK0Q
	 HetFt4SpxuVsESoXD4ngNMMecHFauL5um+9RJlwjFMOwPJirhFC5WHgw3en1W5nJkZ
	 qmkFyYCS7SbiAVvqDih90g3Zbll9mPemcgC4o/jFnegNyIZ5rkZWzRte6AJkyAH/xJ
	 RoiA+GKL+C4ZCbKOLuDq2irzistI30aRQobY+W0vgOHs7PETPHhsvmTyGLZ2bVrq9n
	 A+q3Ot7efLiQjSjmvd4D+y8FeOuPX7JAT8/dUvwlFXmYwZb7OOVodUh6fX2CtcXAZl
	 9cag1NzWNHB7g==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B91DA70DCB;
	Mon, 10 Feb 2025 09:57:15 +0800 (AWST)
Message-ID: <d6c53cdc35c3706ee9b6cad8b60db88840975800.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 2/2] net: mctp: Add MCTP USB transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Simon Horman <horms@kernel.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, Santosh Puranik
 <spuranik@nvidia.com>
Date: Mon, 10 Feb 2025 09:57:15 +0800
In-Reply-To: <20250207152639.GZ554665@kernel.org>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
	 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
	 <20250207152639.GZ554665@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSG9ybXMsCgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNrYi0+cHJvdG9j
b2wgPSBodG9ucyhFVEhfUF9NQ1RQKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBza2JfcmVzZXRfbmV0d29ya19oZWFkZXIoc2tiKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjYiA9IF9fbWN0cF9jYihza2IpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGNiLT5oYWxlbiA9IDA7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgbmV0aWZfcngoc2tiKTsKPiAKPiBIaSBKZXJlbXksCj4gCj4gc2tiIGlzIGRlcmVmZXJlbmNl
ZCBhIGZldyBsaW5lcyBmdXJ0aGVyIGRvd24sCj4gYnV0IEkgZG9uJ3QgdGhpbmsgaXQgaXMgaXMg
c2FmZSB0byBkbyBzbyBhZnRlciBjYWxsaW5nIG5ldGlmX3J4KCkuCgpZZXAsIG5laXRoZXIgZG8g
SS4gSSBoYXZlIG1vdmVkIHRoZSByeCBhY2NvdW50aW5nIHByaW9yIHRvIHRoZQpuZXRpZl9yeCgp
IGNhbGwgZm9yIHYyLgoKVGhhbmtzIGZvciB0aGUgY2hlY2shCgpDaGVlcnMsCgoKSmVyZW15Cg==


