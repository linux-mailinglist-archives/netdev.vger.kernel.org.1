Return-Path: <netdev+bounces-264979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNhABrl0q2lCdQEAu9opvQ
	(envelope-from <netdev+bounces-264979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:43:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 655FC229141
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03C133149F89
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D6284684;
	Sat,  7 Mar 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/8QcP5s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0142116F4
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844007; cv=none; b=TAy6wqzLKL37ttUURVp8MUR8od7erF2/o3DNC+ehhBra3kbtxL5STYOZuFCfGxzHqdl6yYTaxUkrs753xbdEznps8vieM9C9iZV5IXpcxgpKspZIqbj4cTl3/UJv92hrllB0MyKfs3OM/Yq8q3PQ0gGxKmkfmkxlWjo0dH5XneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844007; c=relaxed/simple;
	bh=f1EU187yQ+6e6TlDrFLHz5ysEvIuyd4Y21Hi0mQPxgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ORnLGdLnAX0WqTsJZSg/6yuVfZ18GC7P4ob7xXmTWuoKSL+BwoKkrX/txbY8maH4SZMOY1e1LBFvasXLimZ9pgC24xJrrJVcoQDNdBwmy+NF47RahLXGHz9XXpdE7/mBMTK0zAHMeocRL2jj7xrOkzCTPGuRO/Uz1Z6lhpcI/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/8QcP5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7C1C4CEF7;
	Sat,  7 Mar 2026 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772844006;
	bh=f1EU187yQ+6e6TlDrFLHz5ysEvIuyd4Y21Hi0mQPxgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y/8QcP5sfmZu26H6/aIxUiZklMI5uOo87Zd1ovcum/BsorNA0vU6fkPXiY6AzOojR
	 0Pwc4NOyqbQk09zmMNojhMrR13QloLClZd/H0gMWHyI14AQhAV/Ba/9JyXtdqkNptI
	 IdY+ig6xQcoN4gmpAcy59Va5EvBMFOKd8js8U+NM9NuSxfMCqHEj7mb7F8nUn9IwFK
	 DABpR68BwYjtj3Ew4ZAoGipX+SJn5HQ5wjCkm6B04PKvHhPb8Tq8LUfA8X274PjlBE
	 +dOk6/JU237KUj6eAtLd6TfG76xio5/KCEp1EeYVY/zwnizN1g6+JC5sg2CPHmh1wD
	 5jQH+7td2JXbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE5A3808200;
	Sat,  7 Mar 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] inet_diag: report delayed ack timer
 information
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284400605.107230.7227696281236375503.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 00:40:06 +0000
References: <20260305114829.2163276-1-edumazet@google.com>
In-Reply-To: <20260305114829.2163276-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 655FC229141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264979-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 11:48:29 +0000 you wrote:
> inet_sk_diag_fill() populates r->idiag_timer with the following
> precedence order:
> 
> 1 - Retransmit timer.
> 4 - Probe0 timer.
> 2 - Keepalive timer.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] inet_diag: report delayed ack timer information
    https://git.kernel.org/netdev/net-next/c/c698f5cc940d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



