Return-Path: <netdev+bounces-252925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCyoI+nCc2kCygAAu9opvQ
	(envelope-from <netdev+bounces-252925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:50:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D479C22
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 795C83004F1E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD41EEA5F;
	Fri, 23 Jan 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TziHqFN6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F682158DA3
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194214; cv=none; b=AIQ9Hx/9HqYJ+AOi2SWgNsrpWdOrR2CteR+qbQkr7IcqYl5TyK/rTlBuvN6NAn4YyDn91hjAJQseOvuuBl/w1JUNc8vnZCDRpvmxZUkmsTAOE5K866FAxgfnIFOVglcYLhHhfoMQOJG4aDT54Bc5niEmD/3rLt8wAVShWeBiDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194214; c=relaxed/simple;
	bh=PhGZ5wto9iBlzIfr+FQHQXlfXyqu1yxgBZe4/t3OG2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jlQYz8JL9m+X3D92fRvqLyq4crqv/qzf9dkEvsvks2beobpTrTDqP8CiUWBei8CO6AFtGWVkRI3mgpAFnuitgtf+XFkMb7Bf44TV7B1a+qjIj3Ie6RXSdiVekgNjOOgbQLiU77QodBLnX4DibgXh+DV37XfPbNeK4l9zoJYtsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TziHqFN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343DBC4CEF1;
	Fri, 23 Jan 2026 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194214;
	bh=PhGZ5wto9iBlzIfr+FQHQXlfXyqu1yxgBZe4/t3OG2I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TziHqFN68Mb8PlSh2u8391GbCjorTiMcbbmU+B1dBfqexYJ+iuwjoAOWRgTkUxttz
	 bnxhsl1IeMDgQyI0ZyjfV23kf5dxLib9+TMOjYaABcLXI7Yj/1qJTgIR6+9Rogczqe
	 3nPZSY/iaQSHg6Sc/n2biamm0dQO79PycOQYC22pJtPIXScZhaOcQv/cGhDjKbHpS0
	 T5ONciRgd/kdUMU4fR93UEDiZnm466KMiD8Bv7CxcJlQ0Q7G60/MRs8E80rkfq9uek
	 xBolHHLX3kc+oi88JMLBtDBJ31i5ghmCp+UU5fz2wgEoqXgh+GhWKqXrq5mcTKsbSy
	 pG1H93C6eDg1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4E8833808200;
	Fri, 23 Jan 2026 18:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tcp_stream_memory_free() to tcp.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919420984.2677151.13049852125728948900.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 18:50:09 +0000
References: <20260122090228.1678207-1-edumazet@google.com>
In-Reply-To: <20260122090228.1678207-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-252925-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 239D479C22
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 09:02:27 +0000 you wrote:
> Moving tcp_stream_memory_free() to tcp.c allows the compiler
> to (auto)inline it from tcp_poll() and tcp_sendmsg_locked()
> for better performance.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 2/0 up/down: 118/0 (118)
> Function                                     old     new   delta
> tcp_poll                                     840     923     +83
> tcp_sendmsg_locked                          4217    4252     +35
> Total: Before=22573095, After=22573213, chg +0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tcp_stream_memory_free() to tcp.c
    https://git.kernel.org/netdev/net-next/c/1685e1770856

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



