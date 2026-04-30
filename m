Return-Path: <netdev+bounces-282555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAlKLiWl8mk0tQEAu9opvQ
	(envelope-from <netdev+bounces-282555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:41:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A149BCB7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250313020873
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84A2046BA;
	Thu, 30 Apr 2026 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcPriqm3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFD1F7575
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509654; cv=none; b=lBVum1W9qR9ZLd7op44LuCBVTwkXnOmZMEhO91n3rKJ/+2+bTGXMnBsjd4nWmMYNXzJrtw9sv5GU32CFDcVWf3Hf9/VbNza3kZeOmc/ZcVRt0yoMo2Ox86nmHn7DtNSbTnlKkIwR0onTKqk+s28zkCAFRD1Lsl3kspvdzXv0JGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509654; c=relaxed/simple;
	bh=CS+cW54siK10IjRMv2xyPcnjWY0TyOOBhR78aZT5t00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rCgzsMfpgnKH0pkbtaodwjHeODErXvXcczReIAtU/M1QnQnR8L7wDxAMzt/wmMHqyZyA9xUtonYlSkJchu7FoutGbHdCxffs8pD16Jgear+OGV04ee//7URTDU+F82/kZE844df7ZAnlzSsXJmCZl39Vs2A97AuD5qFvZMioXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcPriqm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFD5C19425;
	Thu, 30 Apr 2026 00:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509654;
	bh=CS+cW54siK10IjRMv2xyPcnjWY0TyOOBhR78aZT5t00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rcPriqm3uWosLXSppDkzF51FBgpCm1dDA1675Dx1+dL4Zi5PAEP3m93Ty4d/sssNm
	 qN9KQS4+VFmqBIzW7L8vVGyKz8IQp/uX6YnvoxPY8pnJ/irpl0h1w2B/5tJDI+1/4h
	 KZZ2RMP30AHnvu6ljCdodpi5oF9hijp6Qi0bKVQXS6cW/toGyCddgRlS7fHZb2W63K
	 x6UZwHMrdFVBy3lfm/gGS6SqeTHx2YAoteBSUNlQJugtYcwbzSdMi4Ya+oA4VZafPx
	 drSG2dBuY5hkbHaf2AsqEO7MqzkU2jODEnxWMnfcjdDx+yLlr3ZJAuEtZHqMiDYeY5
	 +RCIUs9yKEavQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F723809A2A;
	Thu, 30 Apr 2026 00:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: update the IPv4/IPv6 entry and add Ido
 Schimmel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177750960955.2238701.5224472058605394931.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 00:40:09 +0000
References: <20260428203924.1229169-1-kuba@kernel.org>
In-Reply-To: <20260428203924.1229169-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com
X-Rspamd-Queue-Id: 505A149BCB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282555-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 13:39:24 -0700 you wrote:
> The IPv4/IPv6 and routing code is not very well separated from
> the TCP/UDP code. Scope it down properly by providing a more
> accurate file list, instead of net/ipv4/ and net/ipv6/
> 
> Now that the entry is more accurately representing layer 3
> and routing merge in the nexthop entry into it.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: update the IPv4/IPv6 entry and add Ido Schimmel
    https://git.kernel.org/netdev/net/c/e73cafaf4ace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



