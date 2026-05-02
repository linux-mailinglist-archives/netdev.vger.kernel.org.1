Return-Path: <netdev+bounces-283321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bu8OJ9B9WluJwIAu9opvQ
	(envelope-from <netdev+bounces-283321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:13:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE84B0733
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B68A3041783
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F97081E;
	Sat,  2 May 2026 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/S14hUj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC6F42A96
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680675; cv=none; b=rH2jFGsjbTF/Wr1E/efQClUuyIO9mIzOwLnnzxDCDDmUvtnA+MxfFL6A0hB9MmDTxUV5+NxnmfU+pBN6ZS8w9kzqhoLpG04P6gqzfxZu1yrXPA+7rs5Xo8izoJZqUikX9DTjgwU+rP/rHvAJloJlvfVwTP/MZCBivhRDpWbeQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680675; c=relaxed/simple;
	bh=2ovS0LicmaeCMRZifqjcbju9NH8Pa9LmqO56Ip8Pt7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cFtOTIOHvwSa29GKFo2iBXYPw+EOCH+2lzGuG0Ynq0rSZxbIZc3weualNIUUtlaFPpwn6j1+r1K+4WTW8s1Z7QBQY0+KoURiZuGSGFRdlewzrw92RwFELXrvRdlehQZo/8kWGexBiiTmFn3tOUXAvH3Ih8Eoyd/3xcla72EVUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/S14hUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FA0C2BCB4;
	Sat,  2 May 2026 00:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680674;
	bh=2ovS0LicmaeCMRZifqjcbju9NH8Pa9LmqO56Ip8Pt7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G/S14hUj4ehPeXsO2CRP1sAzqEuuuSMa/VaTPCpRNH/mCeeyIFfWOtha6n2NrFoa3
	 pSk0FU9Ko9AtpiAOwpVXRid9I04WfZgpx3TjgYIVEgxMHf5w5WsT+0UChXyrTNahos
	 ans/xd2KVMQZyYhoc7rdZIOQVMtnLPBpu98tEqjzPuJQhXXO2Ed3EkNICqk56NFJCv
	 Hw3zUV3vMDHwPPY4bRy7QLazW+hk1uf8N0qz6/3LpmtDfZPXxNWijWqJMX6ibJpmoq
	 8TEfKne7ZwKBNKNS/rYDG/fYq/I5TZsWbfs6GfIQNFbwavBJYn9ck/AG4sgX0JO3hE
	 ssXc9H5zwdEMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC78380CEF5;
	Sat,  2 May 2026 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ip6mr: plug drop_reason to ip6mr_cache_report()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768062779.3667015.8500981849202875314.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 00:10:27 +0000
References: <20260430074004.4133602-1-edumazet@google.com>
In-Reply-To: <20260430074004.4133602-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 idosch@nvidia.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 68FE84B0733
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283321-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 07:40:04 +0000 you wrote:
> - Check mrt->mroute_sk earlier in the function.
> 
> - Use sock_queue_rcv_skb_reason() instead of sock_queue_rcv_skb().
> - Use sk_skb_reason_drop() instead of kfree_skb().
>   Note that we return -ENOMEM if sock_queue_rcv_skb_reason() failed,
>   as the precise error is not really needed for callers.
> 
> [...]

Here is the summary with links:
  - [net-next] ip6mr: plug drop_reason to ip6mr_cache_report()
    https://git.kernel.org/netdev/net-next/c/8d59a7a188c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



