Return-Path: <netdev+bounces-145630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF9C9D02DC
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D16F1F22A25
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D9139D07;
	Sun, 17 Nov 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="fhNhH9Jx"
X-Original-To: netdev@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D50E335B5;
	Sun, 17 Nov 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731838292; cv=none; b=pcHXjbwCFIJat4Pz1Xm49WwLPOWeek13Zv1A+HvcYNHCJPAUGy+gwnvA2zWjAadbah9w1dN81p6lANby4iyN5wViPUMX7KSTsVUfb8BX3Ldn4eVWiUA7azO3AHpnokwbs2cau+3Z6RtF7l8OMy0NCbkBDZoIXrlAsPB+6JzqF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731838292; c=relaxed/simple;
	bh=Dxby0uqMdN7as2UyyHjcSaRbFkuNxqYBZvH3idpkSss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Li9cmiFrZaQlx6zw2+Pia8w4OnnQTzk9S+4Uth9y2GsV36HF9X3j4b+zY6uRn+LTGKMT+TnUUceTmiKj/Z0E+fgmj/J7gpXQ/V35kQP46Qkw2HPDm4eDo15zW8JXeANfvaV0PY0e8cmYhPxaanJyBxTcX09LOMYK+Y6TnSQc/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=fhNhH9Jx; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:2cca:0:640:9416:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id E9F1760F04;
	Sun, 17 Nov 2024 13:04:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id r4M6SEROg8c0-pFZwU6ST;
	Sun, 17 Nov 2024 13:04:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731837895; bh=Dxby0uqMdN7as2UyyHjcSaRbFkuNxqYBZvH3idpkSss=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=fhNhH9Jxvc9NeeLktZiL0q18ircVXaacbK+3docRjMX5MUYvX/OzMvMwmpMM2VliM
	 8TUv/YD2Q5IC12SWDU1bvzH0kP/QznbX8OvltEnMKsl1vWH6cFqax78WdGSsGuF30R
	 h5hXq+c8uAhQQCZPD/4HhglwpBZwV8SIWxgk3jbU=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d1e90994-ca11-4a3e-b627-e3425dc5bf26@yandex.ru>
Date: Sun, 17 Nov 2024 13:04:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] scm: fix negative fds with SO_PASSPIDFD
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
References: <20241117091313.10251-1-stsp2@yandex.ru>
 <CAJqdLrp4J57k67R3OWM-_6QZSv8EV9UANzdAtBCiLGQZPTXDcQ@mail.gmail.com>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <CAJqdLrp4J57k67R3OWM-_6QZSv8EV9UANzdAtBCiLGQZPTXDcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

17.11.2024 12:40, Alexander Mikhalitsyn пишет:
> Hi Stas,
>
> Actually, it's not a forgotten check. It's intended behavior to pass
> through errors from pidfd_prepare() to
> the userspace. In my first version [1] of the patch I tried to return
> ESRCH instead of EINVAL in your case, but
> then during discussions we decided to remove that.
>
> [1] https://lore.kernel.org/all/20230316131526.283569-2-aleksandr.mikhalitsyn@canonical.com/
Yes, the patch you referenced above,
only calls put_cmsg() with an error code.

But the code I can see now in git, does
much more. Namely,
if (pidfd_file)
     fd_install(pidfd, pidfd_file);

Or:

put_unused_fd(pidfd);

And I really can't find any ">=0" check
in those funcs. What am I missing?
Is it safe to call fd_install(-22, pidfd_file)?


