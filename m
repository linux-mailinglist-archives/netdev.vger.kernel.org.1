Return-Path: <netdev+bounces-253227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIk4IJSSdmkxSQEAu9opvQ
	(envelope-from <netdev+bounces-253227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:00:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82582981
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8C43005773
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87A830DD3A;
	Sun, 25 Jan 2026 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdN0yUU6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60862F5A10
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378421; cv=none; b=MthCJavr3uqMUFmFm9zlIRaUakaa+2LwIvds2RYKn2NSiPJhUNyyFWrQ/otvIp456mNs6xz4UUJIGlzam6W+Esq6SWC7ct0ToMzZleTTT0cDHg/xHmof5pf4I01urLZiTDep2SZ0/2ctauqxiwHF7hhzbDoL/Wv+5MhLoMKMIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378421; c=relaxed/simple;
	bh=arEf7Hlegpaue5TP0KZvsc5JYVz8KucMCnvaO3mxwpE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oSAIoHTC450wYkQEuacRJG9xK8MDEgkU4wMyDA/KhxdnHDXyGie6Ve7/xxVanlCFO2s/wNkdMwlYFZrvisI/59XC4xei88wDSGDbwAIAbr9CIuP5zwiiUMRiM8RdOhDr9OqiH6Dema0IrEn+siqbCqrlrGPd6Dt+Xj2HioaAKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdN0yUU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471F1C16AAE;
	Sun, 25 Jan 2026 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769378421;
	bh=arEf7Hlegpaue5TP0KZvsc5JYVz8KucMCnvaO3mxwpE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CdN0yUU6oVsyGPLdq4itb8z7qw+Lv0zbwPzbtNdTFWbb30AExwxy+6fniXMfiCxg4
	 MHsYe2iwPI66yG77sjBPl8EzjLXtNFDCl6ElNavIBpRMVssOS5mWE+zpAmbWZUoXnk
	 VNN5E+YuENQWcUo4dGTCez13jLYITLMYISBviOOvIeCLwIsGLuST6E0jAHSgD10X3I
	 GKjQeoOY6B/0GqtL+VqOCUITn4rYoTR7xz3Dko8/pUHUtM45pqlbw2X1YSvw809H/r
	 VkvwImlcSqKW30cVqQevGb0PnnTg1hVkje9KI2FvzLLd0eF5AvT3m126yI/Id6AnTS
	 mqxExS/QxDBKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EE153809A15;
	Sun, 25 Jan 2026 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: few critical helpers are inlined again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176937841610.3595884.14160613168661393827.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 22:00:16 +0000
References: <20260122045720.1221017-1-edumazet@google.com>
In-Reply-To: <20260122045720.1221017-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253227-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB82582981
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 04:57:15 +0000 you wrote:
> Recent devmem additions increased stack depth. Some helpers
> that were inlined in the past are now out-of-line.
> 
> Eric Dumazet (4):
>   net: always inline skb_frag_unref() and __skb_frag_unref()
>   gro: change the BUG_ON() in gro_pull_from_frag0()
>   net: inline net_is_devmem_iov()
>   net: inline get_netmem() and put_netmem()
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: always inline skb_frag_unref() and __skb_frag_unref()
    https://git.kernel.org/netdev/net-next/c/c75734b585c6
  - [net-next,2/4] gro: change the BUG_ON() in gro_pull_from_frag0()
    https://git.kernel.org/netdev/net-next/c/cbe41362be2c
  - [net-next,3/4] net: inline net_is_devmem_iov()
    https://git.kernel.org/netdev/net-next/c/87918dd4eafc
  - [net-next,4/4] net: inline get_netmem() and put_netmem()
    https://git.kernel.org/netdev/net-next/c/df7388b3d7be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



