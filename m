Return-Path: <netdev+bounces-145631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEFA9D02E6
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 11:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2146E1F2218F
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E597E105;
	Sun, 17 Nov 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="v5b2X96/"
X-Original-To: netdev@vger.kernel.org
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A49DF78;
	Sun, 17 Nov 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731838619; cv=none; b=VX82afD/hBmOHtbBurufMa8Ei3yPldVIo8gSbHSl+g6PXkKhBaGYxYEDf8fFSMMjjlQaYp6et+W8XDHVz9aAEldLwkwgAIE8D+1CvysjMS+9Bf6H/dfQwQbsxeBHENrt74Dov+J5cj/xizINe+NhLaTJ6VdawByQmg4fBXY8w80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731838619; c=relaxed/simple;
	bh=jF48xQhmyaUZHrKNZA8fppbrd4JVcULJ1pSR3wUKUUA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BJ/1jwCZCcbJnP3ndf3/AeuoK0EnvY9q73l7RGqJczf4HqW0mwu0cNkAsQcFEtadbJmPxavftSelAl9KuZsC6/CObTpL2+aAXYOxjSZy9MjnvJj5pimDz/l5ZNpTGBudXf65jctAEoovI/1E3WafQ+d1erWvxdzt0zUGZikbbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=v5b2X96/; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2984:0:640:b1d5:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 7D55F61173;
	Sun, 17 Nov 2024 13:11:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wAMTLgUOd0U0-Mn3S3CxG;
	Sun, 17 Nov 2024 13:10:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731838259; bh=NGr8RfwsXTXRfuc0/SFKP/q0lWl0xTcboZNog0Ja5z4=;
	h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
	b=v5b2X96/NUd5mpVhhyn47tLpDJRHxPUbbvFuR5NmAeq0+Ws341Bdihmndyajplqka
	 pkOfYvTtLme+FDEz3HYuuSWa+r/B4wSGMenUq290lIu0nhhn9Ur5/hwL670TsVOLql
	 ib+0W65eCGM0BTWYirWcAx/DLprwEQ6Gct6eOFIw=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d99a9ccc-6cc0-4978-9930-7021979703c8@yandex.ru>
Date: Sun, 17 Nov 2024 13:10:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] scm: fix negative fds with SO_PASSPIDFD
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
References: <20241117091313.10251-1-stsp2@yandex.ru>
 <CAJqdLrp4J57k67R3OWM-_6QZSv8EV9UANzdAtBCiLGQZPTXDcQ@mail.gmail.com>
 <d1e90994-ca11-4a3e-b627-e3425dc5bf26@yandex.ru>
In-Reply-To: <d1e90994-ca11-4a3e-b627-e3425dc5bf26@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

17.11.2024 13:04, stsp пишет:
> 17.11.2024 12:40, Alexander Mikhalitsyn пишет:
>> Hi Stas,
>>
>> Actually, it's not a forgotten check. It's intended behavior to pass
>> through errors from pidfd_prepare() to
>> the userspace. In my first version [1] of the patch I tried to return
>> ESRCH instead of EINVAL in your case, but
>> then during discussions we decided to remove that.
>>
>> [1] 
>> https://lore.kernel.org/all/20230316131526.283569-2-aleksandr.mikhalitsyn@canonical.com/
> Yes, the patch you referenced above,
> only calls put_cmsg() with an error code.
>
> But the code I can see now in git, does
> much more. Namely,
> if (pidfd_file)
>     fd_install(pidfd, pidfd_file); 
Ah, I guess pidfd_file is a culprit.
Thanks.

