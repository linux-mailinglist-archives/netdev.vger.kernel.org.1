Return-Path: <netdev+bounces-275276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKwUKkhJ0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:12:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18777398FBA
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0918304A115
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AB538BF9A;
	Fri,  3 Apr 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiO2v2Gs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157FC38B125
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257858; cv=none; b=ObOYn1cjHgGwoh3fGk9Se0IaY3y05vWDYDvXJZveWboIszBGRoP3F8pEbgIpA03eevbDkpLEq81l38XX23aY8rM6Xxv3ZROsMIgxOArU5KwOCBU1YlJUJkdyq+zOdWeXbsd/bm1QiZlVTmmEEmsGs9+yVDZyY1VKmM3vwT9uWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257858; c=relaxed/simple;
	bh=NPq1UFDDgzLzGy7socqCKTpF9sw1bSBc8UfyTp1PMrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AtZoMRxFoBGkczNw/9rN5bsRV5V/QLVDzArQPFwYOa6XAftCCT5lk5yJmeiodTyfLkyKERyMBQ2BNN3xwAKYExar/Y0kDuR6KGISdu3FjHSw0YhKGnwOMEfuqn3XY/98gBAGfS08ZonUfbrj9WvzYQm2/ku6jkmqgB7NCLffe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiO2v2Gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE1BC19423;
	Fri,  3 Apr 2026 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257858;
	bh=NPq1UFDDgzLzGy7socqCKTpF9sw1bSBc8UfyTp1PMrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fiO2v2Gs+ClIglkJqeBAG9T2Di6cAEPs+wASr1W5rNV+K2h7H8mXY41/cqo9vrKTl
	 UGCkxWTy1FafTmtogQTKsaQo7GmCHi0IfWf9Su1cHFABByKI8xSKOcpWkc5dQJc+7o
	 Oznnz4YsdYBXxsnpNyIMRR3Sap5Y9jDTBh6v/4y96ElgVaAx9XUIG7gaw+kKpTJ293
	 zj0UuabegO9Xkj1r56YpL+9tgKFdORT0mIWZgmXWqlLGvcVVWNffn6bon9yYklfIBU
	 3pDKcCk9yVCzIzHnhN1JI3Sm4fhRpr44Ja+0a/pC8wF5tX2awePp8wWR4GKZnC6neW
	 sbHwKSod/fBgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E5F3809A14;
	Fri,  3 Apr 2026 23:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: remove leftover EXPORT_SYMBOL()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525783928.1484550.17733640472253029732.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:39 +0000
References: <20260402174430.2462800-1-edumazet@google.com>
In-Reply-To: <20260402174430.2462800-1-edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-275276-lists,netdev=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: 18777398FBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 17:44:30 +0000 you wrote:
> IPv6 is no longer a module, we no longer need to export these symbols.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/icmp.c        |  4 ----
>  net/ipv4/ipmr_base.c   | 13 -------------
>  net/ipv4/udp_offload.c |  4 ----
>  3 files changed, 21 deletions(-)

Here is the summary with links:
  - [net-next] inet: remove leftover EXPORT_SYMBOL()
    https://git.kernel.org/netdev/net-next/c/1666d945b57b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



