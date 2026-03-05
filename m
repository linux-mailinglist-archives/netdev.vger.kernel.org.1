Return-Path: <netdev+bounces-264314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHgFAk9nqWlN6wAAu9opvQ
	(envelope-from <netdev+bounces-264314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:21:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 124AE210861
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AE39300F7BA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C73845AD;
	Thu,  5 Mar 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4armBV4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB8384226;
	Thu,  5 Mar 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709606; cv=none; b=BggD7Th2vx6fp0REeOptBMOXQvi9XftarQXhcp9JaC+LMujiJplKWDDAUBD8G80gxqX28DChd8I9tU4TYzJ9A3bMzx5AMcRLD8zLVeQxMa3YT2BVEnSenYIxYKhVpeLwcB5Hlz4FLkwMNNsbiuop2mgPa9p9wsDScmwRoXHzAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709606; c=relaxed/simple;
	bh=elaEEUTv4MbbTzOnb1aluZ6NJgO+oaUQdHPfgS+bsrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CPgBzR2JOVD8V9eGqSn+9iyd96fSJigH9/PwG3arP5ZvmvYIeo0dzdavDj2iB7B6YLQeadya/wWnczw/nDJvdaU5pExfEivuFPnE4gYwYGzNjca2AktjjhzoQPrHMVGZW4ZisBdgFH2ZH4zkJCK9nnzsWbaHBi9K0ztRxr4mMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4armBV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0444AC116C6;
	Thu,  5 Mar 2026 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709606;
	bh=elaEEUTv4MbbTzOnb1aluZ6NJgO+oaUQdHPfgS+bsrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J4armBV42aMPkC4rjz7LiHT08N90u6/E6ZW/wTSXq2bYgC3YXROya4EoHIXrD3LQ8
	 LrqLNgFSjeoOCTqOnVfuOwHNsRohTC/cteg7PUjg/4uLhf697D61JzL7zLvR8moB4M
	 /GEmLUxPmOKwl9xl81dHyuQ0qtdr891ARv8KSDO8eZpPxkxt7HPvKFA927VCN0iNBa
	 ZHuCs+7Ig2kCaie3Z6eFMzxgTl6+pSzOEQfwUYytaPcwLTGKKadbWU8YL6IK5riFlj
	 3xKlIO9fUl9W3rAUmP2PMT9qB0hlw8XfnooeJQxuO1intqzGtEFtRaZTCxZj2gKM3N
	 gg2zFpVvTm42w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE693808200;
	Thu,  5 Mar 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Provide a PREEMPT_RT specific check for
 netdev_queue::_xmit_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177270960605.2657587.18286685206790931125.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 11:20:06 +0000
References: <20260302162631.uGUyIqDT@linutronix.de>
In-Reply-To: <20260302162631.uGUyIqDT@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 davem@davemloft.net, andrew+netdev@lunn.ch, spasswolf@web.de,
 clrkwllms@kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, rostedt@goodmis.org
X-Rspamd-Queue-Id: 124AE210861
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264314-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,lunn.ch,web.de,kernel.org,google.com,redhat.com,goodmis.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 2 Mar 2026 17:26:31 +0100 you wrote:
> After acquiring netdev_queue::_xmit_lock the number of the CPU owning
> the lock is recorded in netdev_queue::xmit_lock_owner. This works as
> long as the BH context is not preemptible.
> 
> On PREEMPT_RT the softirq context is preemptible and without the
> softirq-lock it is possible to have multiple user in __dev_queue_xmit()
> submitting a skb on the same CPU. This is fine in general but this means
> also that the current CPU is recorded as netdev_queue::xmit_lock_owner.
> This in turn leads to the recursion alert and the skb is dropped.
> 
> [...]

Here is the summary with links:
  - [net] net: Provide a PREEMPT_RT specific check for netdev_queue::_xmit_lock
    https://git.kernel.org/netdev/net/c/b824c3e16c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



