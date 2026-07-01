Return-Path: <netdev+bounces-303422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oh6pMx5eRGqetgoAu9opvQ
	(envelope-from <netdev+bounces-303422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:23:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A807F6E8E78
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:23:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="R/Jub/2F";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303422-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303422-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80461301E800
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCD51E1024;
	Wed,  1 Jul 2026 00:20:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C254231A23;
	Wed,  1 Jul 2026 00:20:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865237; cv=none; b=SP14f1fcGa7fPIP9sl18DS7dVRQ6z0mptccO+PHFcBnD5Y4/rzNvYZbmSRC1GuukjTlx8gN7jSeNizEJs4zP/JA4dcUsQ8YBPJOBpmZlGvxOP2ZR1DCSr/7takiODGEaoZGqGP/Xg/lNbltFsbFQOiX63/6/NU0/isJ+z87UNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865237; c=relaxed/simple;
	bh=Hf7f23/iHlZFPZotqKYRcBN54Jx/Sux3ic7Z5qoeKQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RtzX4hcrq5gEtN7EfK9lVTiuuEJZN4Rq+pTqiLmBfhdjnFfiKij3jaFmLdukAMKGpgbmvYqh+SUCJJOz3VfFLeSxPCSx9LH4tfqp6Hk4OStfOiA/v6QKGaJzmPUCax5YrTrj1ngtdW44wxMH9uyhfWhAoKFG735VHn02s46rGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/Jub/2F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1321D1F000E9;
	Wed,  1 Jul 2026 00:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865236;
	bh=44+B6p4xMBg4dq9HvarLR1M/OVDs/QGfUr4tzIoLYPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R/Jub/2FB37mmkuG/GspTkXtTZV/8Gfhz24eOgp+KFSWvRXkrn+JDq4ZOpJpmL925
	 eH/Ied1uzAK8Do7jPIiztP/JX9PszT9McnKEQzq04Aq397X022jfTTppUt3ZGLVosr
	 zG4rfh4B31T/kXRJipmG9mqwSeyQdEjKDLSUKwr/C5Hw7N/6+R6qUKrIPhnPSsMIIX
	 Fxgyk59b22RomFkZAzBqa/FOE5PfIXuTGbfwDuSBjxcMI2zb+Rw5rnaRlgsKodB8rq
	 j7D5rfFTdbewwkc8/05a0QUm97z1s/B8S7WihFX7qQBxIKWsnJ6i3GPVkwtqHgvZmz
	 3FNZT1JlcHNlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197C8393A963;
	Wed,  1 Jul 2026 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: do not warn on best-effort skb
 allocation failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286521963.349616.5346803906628044237.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:20:19 +0000
References: <20260629-netpoll_no_warn-v1-0-f380f0b2cd0c@debian.org>
In-Reply-To: <20260629-netpoll_no_warn-v1-0-f380f0b2cd0c@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com,
 vlad.wing@gmail.com, kernel-team@meta.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303422-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:vlad.wing@gmail.com,m:kernel-team@meta.com,m:andrew@lunn.ch,m:vladwing@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A807F6E8E78

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 04:45:39 -0700 you wrote:
> Both netconsole and netpoll keep a small preallocated pool of skbs
> (skb_pool) so they can still get a buffer under memory pressure.
> 
> On the hot path they first attempt a normal GFP_ATOMIC allocation and only
> fall back to the pool when that fails, keeping the pool as a last resort.
> 
> This is where the problem happens. If alloc_skb() fails, we now have
> more than 100 message coming from the page=0 failure, which consumes the
> scarce pool of skb, making the real issue disappear.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] netconsole: do not warn when the best-effort skb allocation fails
    https://git.kernel.org/netdev/net-next/c/09f7a613a14f
  - [net-next,2/2] netpoll: do not warn when the best-effort pool refill fails
    https://git.kernel.org/netdev/net-next/c/84c0ff1efb62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



