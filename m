Return-Path: <netdev+bounces-260709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM6oCjBbnmlrUwQAu9opvQ
	(envelope-from <netdev+bounces-260709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:15:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0CC190C57
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6112A3252851
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE422820A0;
	Wed, 25 Feb 2026 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewIIkmMf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC724A05D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984227; cv=none; b=UCUC4vDVvKxNuakjxPsY5RpZjc3m/IV/B7MEEZUhTIF6VvjMqLl7PqhwxhhkeMe2prvt2lVfhpelEYN/ZApkpXcRUcIgZBYOKNglstOAUgA+SGiaU5LsJwudGGuMPD2kczuIGZsPEpyVIg+negISGV/Qgbqb7hrzkFfu8PyAZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984227; c=relaxed/simple;
	bh=seZbqLeVPUmzS/y1KUf99PZw1PBWP5WbRPnpKDpyedo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kqkPZPvjHu02JRk1uIwzffWyfEFTsMWvJCZHzue05aCvQ6OxMNykOcviIwMmAfjrtXAFqlhPJDel+ldIyXl00qIQzMwywr/wK90fZ8ISQXv52jeq0lsgebcTWPLtWoN3gv2gdQwFEv1OENWuh0w+QmhsXVEIWjYTxqicN1BYa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewIIkmMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38C7C2BCB6;
	Wed, 25 Feb 2026 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984227;
	bh=seZbqLeVPUmzS/y1KUf99PZw1PBWP5WbRPnpKDpyedo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ewIIkmMf7qtxPDCSmipJ8ZicUGIpaCQNWx3MZIM/Jft6UBOCv48BVArZprTonkNK4
	 8eqXSL3QAF41isGo/6hmhF0va8chTPuVVsRzroWroxI5bwMmfKciuMCbZkx+bES8GR
	 sLghxncyhY+7jmMLtaqYzWlDv4AvZ4KEC9GSmLQ/zSq5RkjYNfrlPBAV8OYTP6mtd4
	 agGgEqZeQuERwxaQJbxcXrCYU8eS4/4SPlRAaiLPQIvbEj4hVsMDJ8BAL+mG4h0zRX
	 DDTnEG0QKYdeuXQyvAGLd3oIyrdpi14Fvx7AktCe2dBx4SSOQ/8qsbqCefr4svbG7m
	 /xq+QMT8YdA9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD313808203;
	Wed, 25 Feb 2026 01:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] tcp: rework tcp_v{4,6}_send_check()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198423303.31093.1316958052517995871.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 01:50:33 +0000
References: <20260223100729.3761597-1-edumazet@google.com>
In-Reply-To: <20260223100729.3761597-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260709-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9A0CC190C57
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 10:07:26 +0000 you wrote:
> tcp_v{4,6}_send_check() are only called from __tcp_transmit_skb()
> 
> They currently are in different files (tcp_ipv4.c and tcp_ipv6.c)
> thus out of line.
> 
> This series move them close to their caller so that compiler
> can inline them.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] tcp: inline __tcp_v4_send_check()
    https://git.kernel.org/netdev/net-next/c/bd5e5e1d41d3
  - [v2,net-next,2/3] tcp: move tcp_v6_send_check() to tcp_output.c
    https://git.kernel.org/netdev/net-next/c/255688652b8c
  - [v2,net-next,3/3] tcp: make tcp_v{4,6}_send_check() static
    https://git.kernel.org/netdev/net-next/c/fcd3d039fab6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



