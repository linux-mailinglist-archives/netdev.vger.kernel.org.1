Return-Path: <netdev+bounces-256933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKrzJncFhGn+wwMAu9opvQ
	(envelope-from <netdev+bounces-256933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:50:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDD1EE1D4
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9851C3014C70
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813E2D2483;
	Thu,  5 Feb 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jzp5j7ic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276D1FDE01;
	Thu,  5 Feb 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259826; cv=none; b=WGlhtBYU6gzFAXHkFs+9wsLKeK1+fFFL3RXf2VYScgQbowqohwSVzkptTRfZJqa0RUaATW/BcCzkNST9dfHCrVwp3CRpI+bSCyBD5ZtmlBuDgAzNoeOYpweY5aymI5gqXELmr4esZZhR+o6s3P67PPDSR7tG/S2QkNfAxTr6igI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259826; c=relaxed/simple;
	bh=gEsHVpsl/uccpoAAATd0oIOnvhSELF8QeFYFxJSgi/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XuWDH5cBScoaeBPQg6IfILgtDott+wsxsTt5Dei173I6UElC8+l63fgk1HwMOYdrx0qq4FbJ7MCD/Kq1C0d7uHjIBUDy2WLKfJrUaKKMK3e0q5XKkKqQzVWSg7F4K0e+QhpBumVNY7SkOTCGNtBhywGxGdLcz5wdic2XQuwMB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jzp5j7ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9C4C4CEF7;
	Thu,  5 Feb 2026 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770259825;
	bh=gEsHVpsl/uccpoAAATd0oIOnvhSELF8QeFYFxJSgi/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jzp5j7icXMg0GCWM/CtFH9fWTmWOkwDJIt7TqjxfPgoMrcwT9OfiS678uuzo6zcC4
	 U1yQdmGsQ7rE4HRdQMo0Vwk0EyAonVwHogGxCxnJmmepahXoZy8r2xhOoXOinu+VAi
	 WtS51tgz2fKYct1yhXgggHvrgxvQ9kfs8GoBwy0bLPKFB8MnYk32Kk9+FOzUloPLQ9
	 zdJ/yYyCr8k/DU3qZ4PRd8bTQ77X+C2TPTaTjrSDgDJdxjX2DLcFEChddQ6hp4YtCA
	 kmYrk0WjqhC/Flq7gxoDJivzSlS5wFHTwO+vsqTrhDSf+Z158orNiWlY5IuvaFWGGL
	 5mOygrjpGwk2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B2AA3808200;
	Thu,  5 Feb 2026 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] mptcp: misc. features for v6.20/7.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177025982383.136386.13338094196936067289.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 02:50:23 +0000
References: 
 <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: 
 <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, david.laight.linux@gmail.com,
 yangang@kylinos.cn, thomas.weissschuh@linutronix.de
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256933-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.linux.dev,goodmis.org,efficios.com,gmail.com,kylinos.cn,linutronix.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CDD1EE1D4
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Feb 2026 19:41:16 +0100 you wrote:
> This series contains a few independent new features, and small fixes for
> net-next:
> 
>  - Patches 1-2: two small fixes linked to the MPTCP receive buffer that
>    are not urgent, requiring code that has been recently changed, and is
>    needed for the next patch. Because we are at the end of the cycle, it
>    seems easier to send them to net-next, instead of dealing with
>    conflicts between net and net-next.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] mptcp: do not account for OoO in mptcp_rcvbuf_grow()
    https://git.kernel.org/netdev/net-next/c/6b329393502e
  - [net-next,02/15] mptcp: fix receive space timestamp initialization
    https://git.kernel.org/netdev/net-next/c/70274765fef5
  - [net-next,03/15] mptcp: consolidate rcv space init
    https://git.kernel.org/netdev/net-next/c/5c4dcc52c68a
  - [net-next,04/15] trace: mptcp: add mptcp_rcvbuf_grow tracepoint
    https://git.kernel.org/netdev/net-next/c/2002286e68c9
  - [net-next,05/15] mptcp: pm: align endpoint flags size with the NL specs
    https://git.kernel.org/netdev/net-next/c/d7e712b66f9b
  - [net-next,06/15] mptcp: Change some dubious min_t(int, ...) to min()
    https://git.kernel.org/netdev/net-next/c/b582090005d5
  - [net-next,07/15] mptcp: allow overridden write_space to be invoked
    (no matching commit)
  - [net-next,08/15] selftests: mptcp: diag: sort all #include
    https://git.kernel.org/netdev/net-next/c/f7f4e8e9448c
  - [net-next,09/15] selftests: mptcp: join: wait for estab event instead of MPJ
    https://git.kernel.org/netdev/net-next/c/32207bed0547
  - [net-next,10/15] selftests: mptcp: join: fix wait_mpj helper
    https://git.kernel.org/netdev/net-next/c/ab8b64ca3af3
  - [net-next,11/15] selftests: mptcp: join: userspace: wait for new events
    https://git.kernel.org/netdev/net-next/c/62c0774f0f18
  - [net-next,12/15] selftests: mptcp: join chk_stale_nr: avoid dup stats
    https://git.kernel.org/netdev/net-next/c/91453a62e5ec
  - [net-next,13/15] selftests: mptcp: join: avoid declaring i if not used
    https://git.kernel.org/netdev/net-next/c/79d5069cfbec
  - [net-next,14/15] selftests: mptcp: connect cleanup TFO setup
    https://git.kernel.org/netdev/net-next/c/ae68da495ae9
  - [net-next,15/15] selftests: mptcp: join: no SKIP mark for group checks
    https://git.kernel.org/netdev/net-next/c/4dca8d0030c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



