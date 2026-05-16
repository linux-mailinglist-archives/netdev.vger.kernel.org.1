Return-Path: <netdev+bounces-288527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOCrCZTBB2p+HAMAu9opvQ
	(envelope-from <netdev+bounces-288527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:00:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907BD559A8F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B55B301681A
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20828B40E;
	Sat, 16 May 2026 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWy+cqwr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CE288C81
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893197; cv=none; b=PpIf8QxLqhpu2Mj1sfte6Zao4jhlbTASBIOQLliyGOoWd3wthSQQDParsJ2TvWVSHH9dObHHuY0Bm4SZ+JLI+XrU/1DS6t7sWDuK42Fa1wMJNuZD0G8qGLnMFhnb+NWXQIZ/nGu97ri6yA19VvklA318qnthrw01EyrJA1VD/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893197; c=relaxed/simple;
	bh=hGy68KgdJqeA4zSv6Bk1cLq7U72Qkk77ZqDo92yJLAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B16f8ehjIVVvKq9udUMILuWB2VCywptCZIwsnryNFTzd7JS0Z5DV4jCYQdmHGuWtA34efbvRmkOivJzWW8hS+/GdH5IEf5Cy2C4dygnBO0WSWjxHto47M5BWFWCIvOtIJLe8E2Q1eCSj3WWO+nN7yaVwdXk+pH8csRVc5ri9A+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWy+cqwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5C5C2BCB0;
	Sat, 16 May 2026 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893196;
	bh=hGy68KgdJqeA4zSv6Bk1cLq7U72Qkk77ZqDo92yJLAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MWy+cqwriN3ZS1Z7SBlHqJJzmz0Ep5dlM6nZOY6Nu2PDd8HSnFZxo7ZgslL2glYD/
	 Y/IlQc622vL9q02WWvE0zESbydswsQiQ5GhpGi4Dzq4sMHH6of9nYhJMIZdhu/rTlm
	 ELj+KzDrZ23f6CNLHAQnKRZgXVj9TgwRYXddnP5Kks1fPvAr1HMMxwsLtdzVCtFcEz
	 MM5opdZz4+R82xtUUVHNy8URZgRvXP/LtENCWfbZgAH3Jsoz0WUv58Ue0GLr/ZraUL
	 CbqfSyRvVQ3qc7WpR9xcPb+ksRA4AwBrlXEUK00elPPUmXsk+d64ZUyeH8On2PkjW2
	 tzPGy/JAN4Yyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198053930A23;
	Sat, 16 May 2026 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: always declare __sock_wfree() and
 tcp_wfree()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889320974.213149.14979422206734256162.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 01:00:09 +0000
References: <20260514095506.3919094-1-edumazet@google.com>
In-Reply-To: <20260514095506.3919094-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, lkp@intel.com
X-Rspamd-Queue-Id: 907BD559A8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,intel.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-288527-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 09:55:06 +0000 you wrote:
> Even if guarded by IS_ENABLED(CONFIG_INET) compilers need to know
> what __sock_wfree() and tcp_wfree() are:
> 
>    include/net/sock.h:1861:63: note: each undeclared identifier is reported only once for each function it appears in
>    include/net/sock.h:1862:63: error: 'tcp_wfree' undeclared (first use in this function); did you mean 'sock_wfree'?
>     1862 |                (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);
> 
> [...]

Here is the summary with links:
  - [net-next] net: always declare __sock_wfree() and tcp_wfree()
    https://git.kernel.org/netdev/net-next/c/e758acedce4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



