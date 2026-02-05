Return-Path: <netdev+bounces-257278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBKFOJDYhGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:51:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA0BF631C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6B473006D46
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BA2FFDE3;
	Thu,  5 Feb 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyimNbn5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803219E968
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313808; cv=none; b=XJexTbpl/clpleBKtfZqGkQeKzUjH8OAuqaeP1HBx/TLcmNVNTAbL/smE4ZzskePU7kJBvYvoRlJnh3rFr4u7vwW6nCXatMkn4bqUp4rfieBceYYDz5Y99jrmTQ1t7dUCA1szQ1WABL0QCpNgUWfXqEM/7Rc9AkPXCIjeXUgEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313808; c=relaxed/simple;
	bh=vcxaYP/ueEiyAdsuYc55Oz6qocVq4mnUutnLmoSSZvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I2zGc136jhIlIHUeNcTAOP5L0Lu4Sbfmv69swJBlU5MGMN+9wY1cxW3iIhcFPetFwNMfuMCBRjTTgkA5UnhR4XdwUrWwALKB0InLhCr3Oh9USUQol51tV8+jwg2xfvRsrbnMZwtxIRwmv71D602qaPu+XQ9e3D1Td2BJfAUiEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyimNbn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11776C19421;
	Thu,  5 Feb 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770313808;
	bh=vcxaYP/ueEiyAdsuYc55Oz6qocVq4mnUutnLmoSSZvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AyimNbn5mXgbkVPTkIo9HOO69krNRE9yGL4H/8zw8TwvdRFbvWIyesDJueBig50Hb
	 LFXQGxbF4uR6TUkNick14bPwJSkKI1FqIW5LyKOHuw8tkqLAmvPOsgdQqIbWVejmd1
	 wSxzVoCsrVPu6DoEtINDambXMlYsP4GdN9IJ0/P8nrnEoeu5FzM5lDUF3wYpqXCHrf
	 bHJr/xHXTcsEI1cU6dKYSu5yTPorycQdPaaEYJMF84wkeqUY/1cxlc1UAF5TYc6UPZ
	 AvP3tqw0PGMKRw0fAA3GhfU0DJaDoKhNtEZb1lMCxRaCrAhUUJaYaUR1X5o2tlzv0B
	 dDyVJRtqoBeig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B3253808200;
	Thu,  5 Feb 2026 17:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/sched: don't use dynamic lockdep keys
 with
 clsact/ingress/noqueue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031380558.510957.10572633042146921098.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 17:50:05 +0000
References: 
 <94448f7fa7c4f52d2ce416a4895ec87d456d7417.1770220576.git.dcaratti@redhat.com>
In-Reply-To: 
 <94448f7fa7c4f52d2ce416a4895ec87d456d7417.1770220576.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-257278-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBA0BF631C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Feb 2026 17:02:31 +0100 you wrote:
> Currently we are registering one dynamic lockdep key for each allocated
> qdisc, to avoid false deadlock reports when mirred (or TC eBPF) redirects
> packets to another device while the root lock is acquired [1].
> Since dynamic keys are a limited resource, we can save them at least for
> qdiscs that are not meant to acquire the root lock in the traffic path,
> or to carry traffic at all, like:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/sched: don't use dynamic lockdep keys with clsact/ingress/noqueue
    https://git.kernel.org/netdev/net-next/c/a90f6dcefca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



