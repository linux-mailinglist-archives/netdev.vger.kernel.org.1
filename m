Return-Path: <netdev+bounces-290531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PCXC2UuD2r+HQYAu9opvQ
	(envelope-from <netdev+bounces-290531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:10:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED465A8F15
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D662F329B043
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0C3672A1;
	Thu, 21 May 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG4gBaBp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5E3655DE;
	Thu, 21 May 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376808; cv=none; b=YITx3xCktGMyQ4KbfkkXQjqGFXy4X2mGJfrwYJv57Z1bvgmOMyIqmC+l5ZhEFKJOiS0w4wMOHjTg4eWlIFXoGLbPW+2XZV67iYACvo3Yfls9UBwXAdDUS/uQrOIlMPcBUJnUAY1g4dmNj0ASFXtj15phwLxaaCrvgfYGxRCGZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376808; c=relaxed/simple;
	bh=bqU9EqRV3i/z6sRrSSquLAm2Ik6ZbsYFT3RXrU9MLek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hWGWBRPx3b9L2F3HFCYwPs5D01kUKKFrXekVJAIjc8M8Qd5sBZilsyCWPdhcAYio7pIO40omo8l+sO2/yqGZEke0MB8fixW+0ZJdMyOXussGOIg9EY523YD3GqbvPK07YjpAAliCnYSlQ/ATdHMAwrVJ9F8bhZOzAB48lLUYxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG4gBaBp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF661F000E9;
	Thu, 21 May 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376807;
	bh=SKo9r9PebuvL3KqDY4GRt6Bk/DANWagDYqYzlWhxVIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EG4gBaBpyHv77i1lW4OQGrdfQZf2eh1Mm3WwnCtAembe11B2eT449U/wO9Rf5Rvlj
	 uU6VZ5DBE0t9f6mHy+6QIxnF1rhGZvfT8R2PcW9YR46Zu7fwJgZ161HHctg3ge/4Nd
	 Na/b/S/CFKUYIgES7WWRO28rz7ZkhJl6dU1TFqo7wtnP+gOeRhN0PkeyKdVOCrCoAp
	 Eo+ulWYklo46IlO+sKIXF5pU1nVTLmA2fCuH5iikXcMuy3N5qP4dSwY1YPC7LXxA3M
	 P9TRA4K1EEER9Ul3hKW/fzapuu4gbynV17V6AopuMfKrClHzecH1sSIPvUjFHRh7Lp
	 WalnrsVtXBCKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A413930E00;
	Thu, 21 May 2026 15:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] netpoll: normalize skb->dev to the netpoll device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937681714.379332.13205890047616049295.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:20:17 +0000
References: <20260519104647.3517990-1-rollkingzzc@gmail.com>
In-Reply-To: <20260519104647.3517990-1-rollkingzzc@gmail.com>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-290531-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6ED465A8F15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 18:46:47 +0800 you wrote:
> __netpoll_send_skb() always transmits through np->dev and queues busy
> packets on np->dev->npinfo->txq, but it leaves skb->dev unchanged.
> Stacked callers such as DSA and macvlan can reach netpoll with skb->dev
> still naming the upper device while np->dev is the lower device that
> owns the netpoll state.
> 
> If the skb has to be deferred, queue_process() later dequeues it from
> the lower device's txq but retries it through skb->dev. That can
> re-enter the upper ndo_start_xmit path on an already transformed skb,
> and if the upper device disappears before the lower txq drains the
> workqueue can dereference a stale skb->dev pointer.
> 
> [...]

Here is the summary with links:
  - [v2] netpoll: normalize skb->dev to the netpoll device
    https://git.kernel.org/netdev/net/c/c367b9082194

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



