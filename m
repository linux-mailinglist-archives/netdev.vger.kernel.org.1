Return-Path: <netdev+bounces-275277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJLwLlZJ0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF4398FC9
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 264AA304F5F0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7638A285;
	Fri,  3 Apr 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKMmuUGn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A6388E73
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257859; cv=none; b=jWGWyyTFyEGP9lB9nrbKCDYIjDXfF6kIZfE/sNUmxXfSVe8X3QdWAuguielvRbtteYd9s4QeogVL39iCRty2Rq2HtcyJggqlw9WZPfBgJ5uZSmiQSJlrURKaljdnuJPzWGnDefLzIkxPaK9gRbUtAMGV2llyjmBnXs7TvLLe4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257859; c=relaxed/simple;
	bh=lnCuPx+dBrGJh3O8e8jPkcsMa+THBjuYIsp9wgMbjSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A0DhXH00P+OaE34Mp2rBLr7+53f7hINroiiNef+pSboEV2e53yoSBtEYIgE6iV3h0fyPvP247YF3pnlLhYhiwKonBjyp8oKWCylbxV5RhVlbf9ih9Ug0jDQC3vaWqwMMAXrNQ5QUwyXpgl0B5HptDfJkMGsq6cOGNHdLAemqXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKMmuUGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77837C19423;
	Fri,  3 Apr 2026 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257859;
	bh=lnCuPx+dBrGJh3O8e8jPkcsMa+THBjuYIsp9wgMbjSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mKMmuUGnukkBkDJmj0NWWIqn/uRQt/bKdkfZe9NAU4pahL6qbtCm3p3jN325ro1YP
	 uUJUXiM68idCDxrwX+ri/FYdQr7zFi+UFA0iW1Bwv1m2dpAG+j/0x0teBPe0Uog4kv
	 hE+ou/hr448L//o7f1/h2CnVtMEF6DgYXIm7dUdMs+2pttMmr1m5rqpAcz3zcKEVJ6
	 ShSM5qaMn1G2SjAwcsLBbRGLZ0sXBGrC3sOjgiokkd3Ep+MLp1HcH4jC1Ul01dh5VI
	 scchVj99yCh79uJImvTdF0e/j+5lveHBeadxAJ7waMVJH0vuLtDLBSJjiJLysAY3NO
	 2vDTKz6BdqvfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCD3809A14;
	Fri,  3 Apr 2026 23:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: always inline some skb helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525784078.1484550.10899888055002326977.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:40 +0000
References: <20260402152654.1720627-1-edumazet@google.com>
In-Reply-To: <20260402152654.1720627-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275277-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51AF4398FC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 15:26:54 +0000 you wrote:
> Some performance critical helpers from include/linux/skbuff.h
> are not inlined by clang.
> 
> Use __always_inline hint for:
> 
>  - __skb_fill_netmem_desc()
>  - __skb_fill_page_desc()
>  - skb_fill_netmem_desc()
>  - skb_fill_page_desc()
>  - __skb_pull()
>  - pskb_may_pull_reason()
>  - pskb_may_pull()
>  - pskb_pull()
>  - pskb_trim()
>  - skb_orphan()
>  - skb_postpull_rcsum()
>  - skb_header_pointer()
>  - skb_clear_delivery_time()
>  - skb_tstamp_cond()
>  - skb_warn_if_lro()
> 
> [...]

Here is the summary with links:
  - [net-next] net: always inline some skb helpers
    https://git.kernel.org/netdev/net-next/c/a9b460225e47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



