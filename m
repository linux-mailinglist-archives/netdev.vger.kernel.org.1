Return-Path: <netdev+bounces-263044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLMEG7FopmljPQAAu9opvQ
	(envelope-from <netdev+bounces-263044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:50:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D76961E9120
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121A3310942C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D137419A;
	Tue,  3 Mar 2026 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnMEYgOI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3EE2E541E
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513227; cv=none; b=EFbkwlf2pTHFeyJVC2PNpErk5af/kdvW8wdgqBonwqO4uS++lxapK8spQvkvYrWRyMLY0x2amwhwEisL95VBh1HQU7aU/WiVUFUVWzzuEGP8PLirTXQoNbSV9vJruKaSRqh87DmPuIUf1Vilq5ot3TtxF2joSCzz366zNvLN4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513227; c=relaxed/simple;
	bh=L2kPs4yvsFiZg+JA614pK4ludT5dZh/L65eSLTe9SRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jVTKk6jW3GAomIwHynQ/7mfDs0qT4Gz5sJGR1XaT11RnTDrph7oorUNDllsvwLEm1KbWmW1yHFnapG3+19fBiouMbqedSBTSMF2bI5sP1geZd3q4g7GJbvMzXO9z8hvFYbu49zMeJXhel3ArDjHtJuvCVdvolUfCtwm4KURdZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnMEYgOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0431C116C6;
	Tue,  3 Mar 2026 04:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513227;
	bh=L2kPs4yvsFiZg+JA614pK4ludT5dZh/L65eSLTe9SRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EnMEYgOIxiQBnqeayJumalaYvLWbJPEMIsEpkNNK4mmwKW7hJP6OAQI9JWXAbqxDO
	 /RCg/k1m2PDnO5hcm14ERCaGLHl/JXiu94hgli7kqCHol8P0CyGZjk7TUoHuXr+1SZ
	 3OiCFryZouvgIxGlEiPtigXnL/gVuxs8N8zpcwLbm7EWLclp2wt90UBb7B+AGrKaC6
	 q0AZ8hqidGsi2x8cRXT5y8ra9K6A2SOXYO5gMWVgZymAE67E7blK7qs5i+bv35wXHn
	 34hYF5nWEpdLM9zGwHriJKZ7VTQ5/llEgm6+NapZW0sprDuPidjtkAmGdjTZrLmCKw
	 s6HcgQRV/5PYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD653809A80;
	Tue,  3 Mar 2026 04:47:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] dccp Remove inet_hashinfo2_init_mod().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251322904.625663.4529024196210841547.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:47:09 +0000
References: <20260301063756.1581685-1-kuniyu@google.com>
In-Reply-To: <20260301063756.1581685-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: D76961E9120
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263044-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Mar 2026 06:37:55 +0000 you wrote:
> Commit c92c81df93df ("net: dccp: fix kernel crash on module load")
> added inet_hashinfo2_init_mod() for DCCP.
> 
> Commit 22d6c9eebf2e ("net: Unexport shared functions for DCCP.")
> removed EXPORT_SYMBOL_GPL() it but forgot to remove the function
> itself.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] dccp Remove inet_hashinfo2_init_mod().
    https://git.kernel.org/netdev/net-next/c/425e080a1c34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



