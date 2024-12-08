Return-Path: <netdev+bounces-149962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C59E8413
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 07:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF88165754
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 06:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6809460DCF;
	Sun,  8 Dec 2024 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="N5xT1YQQ"
X-Original-To: netdev@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118E9460;
	Sun,  8 Dec 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733640836; cv=none; b=sx7pN/FRzszvRrQG9fAgrqBt7HJCRGHIoDic5vlB00n7/l6tue3XQe4V8fgN3HEazAU5vmNmwaxlBPJwi54lVecFy7Z0o14C5fW6SA+GqvE2sYmbSFDYK3BRHNdoo/WNMjlBjXMJ/3zud9kagAHE3eDt61ZXt9+bWH7jaYT4w8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733640836; c=relaxed/simple;
	bh=oOWHOofsVhYOFM4kFzLpemQtHZHcElqZQXZNe1xRZc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xe6VGsMFncD6UGl8nH7r7TS4k0ldp+t2jz2DEXfXZcJbaEfjLueRA89SZYJaEyhhDauNIWMcEg7ffPt9ZofmeR3WZVR/v7LaGfRsY99tz/1sPo5QoRnnG8tFtoWNP+gQYoIVePKU2inuDiiMSwq65U4V9M5xfjhRX5rofQlq2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=N5xT1YQQ; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b908:0:640:4447:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 5076861022;
	Sun,  8 Dec 2024 09:53:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id erdFpRDOjmI0-TPTyuotn;
	Sun, 08 Dec 2024 09:53:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733640822; bh=04/FAibtAp8X23ilLM7jhLcfh4M/7cinEjda/eZanaE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=N5xT1YQQmy8wfsSNk/b+vG0v0f9B1rxIWWfLgdLnlesAdSK0L3GDjr1ViJztqd1/6
	 OhEodt+1BFffqoekiCtJdBBYpX+xrGYkN5biZZwf3CrHIDMkLCqdxOEE9ko4Q2wSLk
	 7zwBtfHxnahYBXotn4JBcjaJqCksk3+zzLIOk33A=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <062ab380-ee73-45ad-9519-e71bb3059c13@yandex.ru>
Date: Sun, 8 Dec 2024 09:53:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: fix group permission check
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20241205073614.294773-1-stsp2@yandex.ru>
 <20241207174400.6acdd88f@kernel.org>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20241207174400.6acdd88f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

08.12.2024 04:44, Jakub Kicinski пишет:
> On Thu,  5 Dec 2024 10:36:14 +0300 Stas Sergeev wrote:
>> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
>>
>> CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Please avoid empty lines in the future.

Ok.

> I personally put a --- line between SOB and the CCs.
> That way git am discards the CCs when patch is applied.
>
I simply used the output of
get_maintainer.pl and copy/pasted
it directly to commit msg.
After doing so, git format-patch
would put --- after CCs.
How to do that properly?


