Return-Path: <netdev+bounces-206361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 492BFB02CA2
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B2B1C409D2
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9791D277C95;
	Sat, 12 Jul 2025 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d+vukUOl"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A700F19CD01;
	Sat, 12 Jul 2025 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348750; cv=none; b=UFxcTPjnISAso9Ec1+7KwzNhoui5Nrc+p0RXKKQHQToQQMN6C/9tHkd6xcXZe8L1NgQUnHJONX42GAkYkF+NgZHtjZotSRSvS4lHpAP5UDHiiDZReamiz13nfz+O4KYYFdhrz/2sEFzrTe6tm5N6+NONBqNb41SsmVFVGj/3yUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348750; c=relaxed/simple;
	bh=jF84WdlSrO4hBJMh16zi+kR5rivp+GuG7KPU+714/nk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=N51CYK8qdGC7jRsdIeA+LJc4Of5h3CuGyLUf+c2smIamsnF5KZu/2RjdfCvsBC6hl0X57sEO+L9uWluNyQ4BGrOuSQHqQvLIBpxZUbscMkAJqL5j6GG43l38QZVNn0QeZrh/iVsdmxi3/XJwh39TCCaQWUadvIewxn1Uclqi8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d+vukUOl; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752348742; x=1752953542; i=markus.elfring@web.de;
	bh=wgjZyIoZk6D/SU3ROAr1eCXuYoDCZcBNtih0WnZe3ac=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d+vukUOl/gSqy+fzGZHuHv5sKATGcdBdh+ubC+/z8O2csvy2xX5dTIQ7o3xjXyCW
	 B4es69oMeh2/Mbrk35EkNA7XMW+gzVy5PhKBJ3f0AmXk/jWhddvYP9dd4dUrQAcG5
	 5ENT8M4Q+hAXJIZyp2zhrIwn1/wCdRX1QNFVwrTo+dqxXhBwRhA0E6DeP8Agv4Rr0
	 XjJ/f4c5X5Ac9Mh4A1oOL93e9O53Vwt6XKnAdCBpwBp2RvdCY4WcZQUTwH7hzjnnJ
	 v1sD2LLohVxX4SGSEreaiM+65WBrBPiDEXp8ciHX0YRfoKi34UVdvYoTDVYzhcMew
	 IedDNSNRQyRJqYzQfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.234]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1uOo0B18L7-002uby; Sat, 12
 Jul 2025 21:32:22 +0200
Message-ID: <3e9b1ec2-68e2-4d5f-9c74-c64503f178ac@web.de>
Date: Sat, 12 Jul 2025 21:32:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yue Haibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250712092811.2992283-1-yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in
 mld_del_delrec()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250712092811.2992283-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xtLn4/kBRn+aqUHOAcb4rRlrodefdC/FfcNKazNwYSbNxGpJKgW
 nLjP+jY0FgtQLr22oFxeGDsq5bmVjXcqwxxGDX1wnThhtBLMONLmz4KQLDYv7Qr094M/BSO
 CcTYz0UmT/XFMa31erkFsj2zx19W9H900BHkoFB55+Ugv8YXTSkSXkoG0zvElgLmvxfcFXI
 KlR/UA6L6qCGEdk48eHlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3AicwvgFnzM=;nRnXk2+/HeEnu3T/KcOyC+lvJWZ
 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
 QKtq13/Lwym8Gs=

> These is no need to check null for pmc twice.

Can another wording approach be more appropriate?

  Avoid a duplicate pointer check in this function implementation.


Regards,
Markus

