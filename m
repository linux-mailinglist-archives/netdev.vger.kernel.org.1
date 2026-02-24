Return-Path: <netdev+bounces-260439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uODFN0t0nWmAQAQAu9opvQ
	(envelope-from <netdev+bounces-260439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:50:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B533184EA1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4E3303C024
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C237104E;
	Tue, 24 Feb 2026 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0AVgFcf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54D3644B6
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926599; cv=none; b=QZWM2esBeHEr48n32ZLOyPWd++FNDv3RiF1sp2C89lyB0lmLfRgOOTexwitULnT0R5sMgoGQYutmsorsnKq65MFyXcLCY00YGywHWz2KrMIlmjKsFwpUk4m1BPkF+2+RL+cxhTZ33S9XWTRgW3ouNs2DTNM6G+Qkr5pmyxO3Rh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926599; c=relaxed/simple;
	bh=oOl4lAziSHMQ+qYPAzbUIrDGrPLLnrYf3kmRz13Z6uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fr0tpwyIy74ruoegsrGUHL+JVIPdxjDdfzgmn+9hFebOtU58tTy70PVUgYtg0IaTrnm4YfRNhoOW7d85XVKwX603GUS7Y00yIg83qyt8QmalIP9Av/Md3CKj46I+ELTNSQilQJFyjhsB1GZr3duQL58E5+/+LeOKBby6AvaS+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0AVgFcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015BDC2BC86;
	Tue, 24 Feb 2026 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771926599;
	bh=oOl4lAziSHMQ+qYPAzbUIrDGrPLLnrYf3kmRz13Z6uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R0AVgFcfO2jgzFTS5YvfkeGvxpQpXvZafgp7akZdP2hokq5+w9v6Vtf3gIQAC4g7j
	 5ivHFwQzQUjBQ4/zaqWr8nBKMFynjrOuDTVrpeUjXznTjXT7e8oYvx2+2drNPllM5w
	 Ecvw6k5lrFAL32GA0sslqvu9jS2uK61XNDqqNsFm3qx4i8IUjeSTa4L1fqYMQV6qIF
	 Lj2g56fbrNUaJ/2WYGB09fO3W2MoZrkp5tNQa5wB6whjGWo21gKPdy0weftvotgrzR
	 eQfUk2ydF2L+yFvgR4Ffev1yl27NxocRjsxnGCxuzhI+S49zrfaFKvCqL9C1kglF0+
	 Unr4/0tRnKY5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C723808200;
	Tue, 24 Feb 2026 09:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netconsole: avoid OOB reads,
 msg is not nul-terminated
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177192660480.3419710.2459154595902794412.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 09:50:04 +0000
References: <20260219195021.2099699-1-kuba@kernel.org>
In-Reply-To: <20260219195021.2099699-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, leitao@debian.org
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
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260439-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B533184EA1
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Feb 2026 11:50:21 -0800 you wrote:
> msg passed to netconsole from the console subsystem is not guaranteed
> to be nul-terminated. Before recent
> commit 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
> the message would be placed in printk_shared_pbufs, a static global
> buffer, so KASAN had harder time catching OOB accesses. Now we see:
> 
>     printk: console [netcon_ext0] enabled
>     BUG: KASAN: slab-out-of-bounds in string+0x1f7/0x240
>     Read of size 1 at addr ffff88813b6d4c00 by task pr/netcon_ext0/594
> 
> [...]

Here is the summary with links:
  - [net] netconsole: avoid OOB reads, msg is not nul-terminated
    https://git.kernel.org/netdev/net/c/82aec772fca2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



