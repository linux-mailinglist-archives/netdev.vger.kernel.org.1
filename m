Return-Path: <netdev+bounces-198082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E4AADB31E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24B1167037
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7711B6D08;
	Mon, 16 Jun 2025 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+TpS13o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00F1B4231
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082973; cv=none; b=YKh/OjBmCAVa7UjaEK3t/e2ElJdCGQ2sBkOW+5loEfkyZMmJRkvbbeHvfbqOGYFgqvRMqVYawgwuJWMY2gJ6cneBvGPFDsqyWnhVcnaIhH6z6xS71LbbIrrTq64uii7Lxzi8xZgSfaYwf7YLx7fh3yAyZ6Xp1Utxk9W+ibFPgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082973; c=relaxed/simple;
	bh=Z38iWUKwPy08Mg6Mg4GfZfkb+ktx5UqaAE2UbcOC8Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTlzTUGYybB3JCunQYEsAwm82UvERCBKtKQPL2HWr7jjeN4wnjmZz3qfY7P0PHoXM9OUax8XTXTDp95yMbw0n/kMLGxS43RoN8kltckTCOfk9M+bipZ99bBapNtjnPk51u32LesTv9qyTHFtYJq5dIoWotbUqJ1MevBcL4hF13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+TpS13o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73340C4CEEA;
	Mon, 16 Jun 2025 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750082972;
	bh=Z38iWUKwPy08Mg6Mg4GfZfkb+ktx5UqaAE2UbcOC8Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+TpS13obVGKSMRt10ShFgmZ6NEWlbv7QinufND6esN3JNiizuh8XNUQPKFsBE3AX
	 iJ+iwagYM/bnka66IJBIWjs0Qki6ia4GQiRlcblV1UNalcpm+4IMVG80b5cCogkkal
	 qtHkBdz15Jxr5omiF7DrmNscgHE/kjyYLYpFyEvXuWq6lL7WuvZNjSprupAxp6RFdh
	 Adciseb82ETt3git7vlUFMiW+nJ2JT48BdWP0X6dROdEUkvbSwGcAxzpHExe241im3
	 +RxmtDREb7dGtBSCoo6rbLUHyiM4g4tSqi5MnMPAnrbYYMDsbSWueigd0II6N3x/O6
	 jATczdwNQI4cg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRAWf-000000003Fc-1fPG;
	Mon, 16 Jun 2025 16:09:30 +0200
Date: Mon, 16 Jun 2025 16:09:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	netdev@vger.kernel.org,
	Jacek =?utf-8?Q?=C5=81uczak?= <difrost.kernel@gmail.com>
Subject: Re: [PATCH v1 net] af_unix: Allow passing cred for embryo without
 SO_PASSCRED/SO_PASSPIDFD.
Message-ID: <aFAlmTEPUqBdTJJ6@hovoldconsulting.com>
References: <20250611202758.3075858-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611202758.3075858-1-kuni1840@gmail.com>

On Wed, Jun 11, 2025 at 01:27:35PM -0700, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> Before the cited commit, the kernel unconditionally embedded SCM
> credentials to skb for embryo sockets even when both the sender
> and listener disabled SO_PASSCRED and SO_PASSPIDFD.
> 
> Now, the credentials are added to skb only when configured by the
> sender or the listener.
> 
> However, as reported in the link below, it caused a regression for
> some programs that assume credentials are included in every skb,
> but sometimes not now.
> 
> The only problematic scenario would be that a socket starts listening
> before setting the option.  Then, there will be 2 types of non-small
> race window, where a client can send skb without credentials, which
> the peer receives as an "invalid" message (and aborts the connection
> it seems ?):
> 
>   Client                    Server
>   ------                    ------
>                             s1.listen()  <-- No SO_PASS{CRED,PIDFD}
>   s2.connect()
>   s2.send()  <-- w/o cred
>                             s1.setsockopt(SO_PASS{CRED,PIDFD})
>   s2.send()  <-- w/  cred
> 
> or
> 
>   Client                    Server
>   ------                    ------
>                             s1.listen()  <-- No SO_PASS{CRED,PIDFD}
>   s2.connect()
>   s2.send()  <-- w/o cred
>                             s3, _ = s1.accept()  <-- Inherit cred options
>   s2.send()  <-- w/o cred                            but not set yet
> 
>                             s3.setsockopt(SO_PASS{CRED,PIDFD})
>   s2.send()  <-- w/  cred
> 
> It's unfortunate that buggy programs depend on the behaviour,
> but let's restore the previous behaviour.

For the record, this one fixes the wlroots and Xorg crashes on USB-C
DisplayPort Altmode hotplug that I hit consistently with 6.16-rc1 on
machines like the Lenovo ThinkPad X13s and T14s.

> Fixes: 3f84d577b79d ("af_unix: Inherit sk_flags at connect().")
> Reported-by: Jacek Łuczak <difrost.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/68d38b0b-1666-4974-85d4-15575789c8d4@gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Johan

