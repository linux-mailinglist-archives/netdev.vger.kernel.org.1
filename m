Return-Path: <netdev+bounces-144358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B8D9C6CFF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97226B246FE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA61FEFAD;
	Wed, 13 Nov 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ncQAHZ1v"
X-Original-To: netdev@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084781C8FB3;
	Wed, 13 Nov 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494181; cv=none; b=NsNVJ9u9I33ZfCqeKWD96PBQFHZjO3bCtrDZqdjEn6dvAn+P9eY+IqSngZL3PAAdyr8UWsKQaKaGJCSW2QpP4Ia8bUzBMkOruCICLngEqGBhUdd6ytddscl8mc4L0SiSqcIc+h0M+SMtNVKV1aqFtFyA/sa0TpEtfClTi2TYlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494181; c=relaxed/simple;
	bh=XkTIs7nu4bLDcQiU5a9HztKYuqyVNXyBCU1tsEqpHA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It0HbAhUshFPnEbolKO48e8iCnzskasAgiLS/ZGjXdiG+aoRN144DwMr/IEp/b7yf1bvQUZTLueQZFv0FZ9CqB+2Q2akA4hYR17qCIrACJi9KSHzEDqxXmIdbeBV3mUBAZNp/BZrHk+/XeG5veL6T0jX3bIUmwcC/fDGu6bGyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ncQAHZ1v; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:1115:0:640:1385:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 1B22761E78;
	Wed, 13 Nov 2024 13:29:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tTI4S8ROdeA0-nKNhkP8v;
	Wed, 13 Nov 2024 13:29:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731493798; bh=+cXUpe34/1kdGa6zXYoByQOZBAwAbSaDWTGSuPHsosY=;
	h=In-Reply-To:To:From:Cc:Date:References:Subject:Message-ID;
	b=ncQAHZ1vGLgEv0GiuJj4jHUvB7Oirh3rh8jmyzWiosC/lpFJdOy69f7DZGYaQGOm5
	 fCZ04tSJZPXOjF2yO1Akm7GbFOROt9x0IzCDWX6wVdU3bry6twML466CBLQ0/0hGCG
	 3ziNnurxFbUQOVgfhDYvWemNOZ4QkX2zkUUVvl4Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <6ff1052f-76d5-42a4-bf0c-ec587ca4faa4@yandex.ru>
Date: Wed, 13 Nov 2024 13:29:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac802154: add a check for slave data list before delete
Content-Language: en-MW
To: Lizhi Xu <lizhi.xu@windriver.com>, miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stefan@datenfreihafen.org,
 syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <87a5e4u35q.fsf@bootlin.com>
 <20241112134145.959501-1-lizhi.xu@windriver.com>
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
In-Reply-To: <20241112134145.959501-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 4:41 PM, Lizhi Xu wrote:

>   	mutex_lock(&sdata->local->iflist_mtx);
> +	if (list_empty(&sdata->local->interfaces)) {
> +		mutex_unlock(&sdata->local->iflist_mtx);
> +		return;
> +	}
>   	list_del_rcu(&sdata->list);
>   	mutex_unlock(&sdata->local->iflist_mtx);

Note https://syzkaller.appspot.com/text?tag=ReproC&x=12a9f740580000 makes an
attempt to connect the only device. How this is expected to work if there are
more than one device?

Dmitry


