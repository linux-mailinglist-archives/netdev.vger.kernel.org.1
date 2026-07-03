Return-Path: <netdev+bounces-304572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mdMNMcvFR2o5fAAAu9opvQ
	(envelope-from <netdev+bounces-304572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:23:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4450703615
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:23:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Asmky+5v;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304572-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304572-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31DE30573E7
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B784C3D9559;
	Fri,  3 Jul 2026 14:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AB3D45EA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 14:10:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087824; cv=none; b=l+lqLA2rrnnsyiFeBsvLgGJP7ZgEpzBraOLibGS3K0GvyGevzG4T3oJXugNdD9ddy4J9nDZQ0BSDpHU2XzjsNBe6b5NxzCpWipWw6c/6De3eTEUOWXlnHOQm3UdtPqTgz/JZ5ok+RUXN+QAn71GP5M49x2tBnZayAk9WTNZA5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087824; c=relaxed/simple;
	bh=ESesChFs0+r6Yzgs8TNi3liAsuiO+QAXmlZj9cyXKtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oyH1esE7AAQ1PvaB1SXg+jj5fDUAdc5wMsk1JKBdO0MrRcVpZtfO8UuvhxSMH2XsUDU6WqFjz384ZzOz6CrCChIqqCPTH+kFL81Fk5hk5I9D8bvpWUvXMoK1yXC1Xz6MYfgFYYrM/oN9cCKQhUL9s5A98N1hivSTW7Lfhl9bCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asmky+5v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FE41F000E9;
	Fri,  3 Jul 2026 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087823;
	bh=ShI3Falo4wUukzF3/zGmd5dxZLFd6IswkKgqGLZof64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Asmky+5vy+Lly7jxreQHNoIOuQk9P9SjZFQPZEWP8msG3uxVc0eC38W0oGitk9ECd
	 cuopHKBCnZuDH2nqRdYP/emfuxhkrRTg8XlOP0GuGYejL/lef7I+IEfa4Bm3qWmG4v
	 URSG135cmu6mvXtN6EGB0LmspOTj5C6ne0L4wmeY+wuyqVD9tLpf9EnVf0lwt6y009
	 Zro47sSMvvveZ1DYA3DoVu5Xn+XKULST6cglRT7nhevw0+qKWSRXtq0Zs96f+4WdnS
	 UsKX8C7fMnnkNSIllZgjJvBr9DpF0/x4ZKPzZiTrpsXDOgMnAFOOJ29w0OBHNbq2qZ
	 ese305ELwUVdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1993C3938EB9;
	Fri,  3 Jul 2026 14:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_teql: move rcu_read_lock()/spin_lock()
 from _bh variants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178308780564.2728910.11131487731747143438.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 14:10:05 +0000
References: <20260630150922.238714-1-jhs@mojatatu.com>
In-Reply-To: <20260630150922.238714-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304572-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4450703615

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 11:09:22 -0400 you wrote:
> This is a followup based on sashiko comments [1] on commit e5b811fe7931
> ("net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF")
> 
> Use plain rcu_read_lock()/spin_lock() in teql_master_xmit() instead of the
> _bh variants, since ndo_start_xmit is already invoked with BH disabled
> by the core stack and the _bh primitives can warn in_hardirq() when xmit
> is reached through netpoll or a softirq xmit path with hard IRQs disabled.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_teql: move rcu_read_lock()/spin_lock() from _bh variants
    https://git.kernel.org/netdev/net/c/6301f6a34ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



