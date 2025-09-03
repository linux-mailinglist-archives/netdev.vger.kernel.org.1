Return-Path: <netdev+bounces-219465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB15B41705
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF4117C78E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24902D8DDB;
	Wed,  3 Sep 2025 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wEslOGSF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/x2LIVrq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0142797AF
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885302; cv=none; b=r4l1QorNCel789eiKB8sH2r5LbgFyjdOqK3HRF4ufFlVqpxvU5hHItNazeYfOKX8N+Y204Pg+LY3HmV1EmU93RRORFbLQpgpDG4TOqnQMotr3FUX23maB3vm1QWiX81jJYpJmB6x78k5MGmcHOGuhfFSR57Q8NdZeuGi9d3/NnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885302; c=relaxed/simple;
	bh=zdHM8Ax76yr2eLMqhAsCV/ru/BJA5sp18Sj23Ug2RSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl6iEo/uWEjyX7VN5mUxhLlpClNcgwAg3g9mxgIK1LF2yK1oD7+E3xxE3ITp2soSWpjrHalqzXfQS+rsSvTrfD3uhp/i56Bz6OP7Ng1bFmTphvqu3NkuJ2NdR0IIyGCD2d8FXzFK2YDbmz2HrJznFBsEpcrLhXXY0LTaURERwxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wEslOGSF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/x2LIVrq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Sep 2025 09:41:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756885293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15AzZAl1ag+/3SspXHD2I1iJWGcEJardTJKtJr13veE=;
	b=wEslOGSFTwuQAoAROzLFnWwu0VdrzzJE5pd1KsBfIbTlmXQxuraBycp5lj4G5B7PwCRUVS
	GP0TjePKfw3s3cOwNFwRnkN5VvR0o8JqdpFTnV5KgmOAOkm0Ik02NxmG4xkO9FrfvDZv8l
	wmalNIsEjkkzhFqjTf63DVgCqGnrXJ7JrIyga57H/0sboFk3gPAXojeDtvXadSWFstpLPy
	FOk8XArJWrRT5UY+0nkOkf/MwCXuPucxBEC9CCp6hpgOj30vhvMkZ6/24uxfJlfcks7nJJ
	i7F5dhsAD6viDJvUuHMcl884q8le6UW8z6cJBbn04s08n9DGinZ4EqpOtDtbVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756885293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15AzZAl1ag+/3SspXHD2I1iJWGcEJardTJKtJr13veE=;
	b=/x2LIVrq/+n/JLhssPxoO79tshIYabp5CNBVi/h7X9Y7KIM/b0Kq5V0325zT/8AFyRpLz1
	9bUU8ofhusRbcuBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] net: lockless sock_i_ino()
Message-ID: <20250903074131.BclfkWQE@linutronix.de>
References: <20250902183603.740428-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902183603.740428-1-edumazet@google.com>

On 2025-09-02 18:36:03 [+0000], Eric Dumazet wrote:
> Followup of commit c51da3f7a161 ("net: remove sock_i_uid()")
> 
> A recent syzbot report was the trigger for this change.
> 
> Over the years, we had many problems caused by the
> read_lock[_bh](&sk->sk_callback_lock) in sock_i_uid().
> 
> We could fix smc_diag_dump_proto() or make a more radical move:
> 
> Instead of waiting for new syzbot reports, cache the socket
> inode number in sk->sk_ino, so that we no longer
> need to acquire sk->sk_callback_lock in sock_i_ino().
> 
> This makes socket dumps faster (one less cache line miss,
> and two atomic ops avoided).
> 
> Prior art:
> 
> commit 25a9c8a4431c ("netlink: Add __sock_i_ino() for __netlink_diag_dump().")
> commit 4f9bf2a2f5aa ("tcp: Don't acquire inet_listen_hashbucket::lock with disabled BH.")
> commit efc3dbc37412 ("rds: Make rds_sock_lock BH rather than IRQ safe.")
> 
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68b73804.050a0220.3db4df.01d8.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

