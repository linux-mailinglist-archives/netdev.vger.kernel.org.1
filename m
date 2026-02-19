Return-Path: <netdev+bounces-259387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OeIO11llmnxegIAu9opvQ
	(envelope-from <netdev+bounces-259387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:20:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C14B115B5AE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2B79300AC93
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7B25B31D;
	Thu, 19 Feb 2026 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksxT/CpB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B425A2A2;
	Thu, 19 Feb 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771464026; cv=none; b=EFLaiSvD6GFfwpu3OeszR9BIhknSH16qiNp+UNjyb8QyskR4H1wCEb57d2eukrSeCcv3/Hs6++Rh0WII9GlmTkT5goLWcNrlf3KlvE1fN6MnyRz6TXnMIKDyvEFaJ1zUBPPGZhyubMZUHB8ISfYLiy3upaWJdapAmOgDuzijmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771464026; c=relaxed/simple;
	bh=VmtAjIZOutr3x3Q6CAFvx3ilseHXFaCKzuUZ5iSr1dU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z7WNSYQhhZs0ujvWAbNbRRMaWuJNpc69kOF7ojcRv/GCxI2Zlhng5sIXE5flgWx7WTaQqhdPwycoaRFW+wDqrYcE7qvoYxuWuv3FqMU5CQ2FCjGPd9NKvXGbjfZg2MGwgetailfxYaz5Q5+JFeZWddSFFojkNFkbeyEX+LJSZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksxT/CpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94359C116D0;
	Thu, 19 Feb 2026 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771464026;
	bh=VmtAjIZOutr3x3Q6CAFvx3ilseHXFaCKzuUZ5iSr1dU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ksxT/CpB58sf/tzl6XR3iw7wwuXozZ3y/Cm0kBvm9QbPrj5fdEVGjhPKBqHwbpE4V
	 U3mHs2EVgcWqdWSiAo9bW2ej6GBXZ2uq9UIyeCFlverQmaUeBY7KCVBNH96S3yXED2
	 Xh6PERhlCOgNufppCP4Hxz2yqyVM7qOu+vpz7jUCLOZuB91yRct20cvTC0Z7yCUAQE
	 eLyDXvXRACwG+9TufDH9+QphIqZOGIJL7K7XvbMH8LIYuzbBDbes5JzW2x1vFyMICt
	 LLjWb0yvk8KnTAr+sx/MRbSChD6ogSbieEwihOPryfNVW/2BssJzLj1ApihOdc3UGx
	 TmaYvg4VG+7bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFC8380CEE0;
	Thu, 19 Feb 2026 01:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] octeontx2-af: Fix default entries mcam entry action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177146401782.1625981.7221483538428502621.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 01:20:17 +0000
References: <20260216090338.1318976-1-hkelam@marvell.com>
In-Reply-To: <20260216090338.1318976-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259387-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: C14B115B5AE
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 14:33:38 +0530 you wrote:
> As per design, AF should update the default MCAM action only when
> mcam_index is -1. A bug in the previous patch caused default entries
> to be changed even when the request was not for them.
> 
> Fixes: 570ba37898ec ("octeontx2-af: Update RSS algorithm index")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix default entries mcam entry action
    https://git.kernel.org/netdev/net/c/45be47bf5d7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



