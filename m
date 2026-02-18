Return-Path: <netdev+bounces-259182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO91E/ETlWlYKwIAu9opvQ
	(envelope-from <netdev+bounces-259182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:20:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B61527E1
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63309301E3CD
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881B2DB784;
	Wed, 18 Feb 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRZVU9Et"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E352D97BA;
	Wed, 18 Feb 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377622; cv=none; b=C7xmKzuAgnNs6Ly0Xwp7e/RlfM9xQ6X/pVzagN8/humT9uBZ0QbL/mv6eyIvy1woBAGdm+46wR7jsKAD0GIrw31YzoLbXJ6GM6VSmtTVoDBFXNS97kbiHTiSpDNm5BNf8qO/fEfTVn+y0RWIUNmq3YInLBoGyvL6NjuywDqwWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377622; c=relaxed/simple;
	bh=yLy6e66Xx9T4grUdHUY0x3UVLNp7zNXSNvM9usEc2HY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JE901kgJuVtB0HX4/pr9j/fad0eUVH3kGIHXcfR/YpxfBB05IQy7slvg7N2SwWMabzUfYROZGST5BVjF1IJeDFMLisLtbHaXtUDOCIMbkofsdnyp+y2DbSL87Wu5/cGGfcURe8et/w2DBAlm7wHk9UD923OpJL2vhx1dVc5jloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRZVU9Et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899C4C4CEF7;
	Wed, 18 Feb 2026 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377622;
	bh=yLy6e66Xx9T4grUdHUY0x3UVLNp7zNXSNvM9usEc2HY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HRZVU9EtO+EdLOUxQT29tq/fRxWK2qZdOcIaL7PYFFsOp3BymfDAFnGr4xiucURX+
	 2gCI/2LS0NUe5ea+NTBreTYSJ5NsqawatfR+4LJIjTz3eLet/pN9OaL7d3t5aQK20a
	 39hn5FTLrUOdMZ4KXB6gxk+dVGIfR8J9OKtqgJzdIVY0m3M0knwmSo0wWiUd7E3uZM
	 a/38lCK1X5mRo3pZ2xL7mrw/Eb5ONkWU5Ak+UWYUjpJXjFqG9CzylwjkpX5dLJyaLL
	 uyjQohtxwLwVT6U89YMeWK3E445+N33N2xGUMv06d6sqKGNCS57Yuqw9ofijoDPMhh
	 CHbYwR0WTZ2eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8513F3806667;
	Wed, 18 Feb 2026 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: psp: select CONFIG_SKB_EXTENSIONS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137761432.765825.12761342734713845930.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:14 +0000
References: <20260216105500.2382181-1-arnd@kernel.org>
In-Reply-To: <20260216105500.2382181-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: daniel.zahka@gmail.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, arnd@arndb.de,
 horms@kernel.org, geert+renesas@glider.be, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259182-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,arndb.de,glider.be,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: C42B61527E1
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 11:54:54 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> psp now uses skb extensions, failing to build when that is disabled:
> 
> In file included from include/net/psp.h:7,
>                  from net/psp/psp_sock.c:9:
> include/net/psp/functions.h: In function '__psp_skb_coalesce_diff':
> include/net/psp/functions.h:60:13: error: implicit declaration of function 'skb_ext_find'; did you mean 'skb_ext_copy'? [-Wimplicit-function-declaration]
>    60 |         a = skb_ext_find(one, SKB_EXT_PSP);
>       |             ^~~~~~~~~~~~
>       |             skb_ext_copy
> include/net/psp/functions.h:60:31: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>    60 |         a = skb_ext_find(one, SKB_EXT_PSP);
>       |                               ^~~~~~~~~~~
> include/net/psp/functions.h:60:31: note: each undeclared identifier is reported only once for each function it appears in
> include/net/psp/functions.h: In function '__psp_sk_rx_policy_check':
> include/net/psp/functions.h:94:53: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>    94 |         struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
>       |                                                     ^~~~~~~~~~~
> net/psp/psp_sock.c: In function 'psp_sock_recv_queue_check':
> net/psp/psp_sock.c:164:41: error: 'SKB_EXT_PSP' undeclared (first use in this function)
>   164 |                 pse = skb_ext_find(skb, SKB_EXT_PSP);
>       |                                         ^~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - net: psp: select CONFIG_SKB_EXTENSIONS
    https://git.kernel.org/netdev/net/c/6e980df45216

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



