Return-Path: <netdev+bounces-288138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHzbDaJ2BmoUkAIAu9opvQ
	(envelope-from <netdev+bounces-288138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:28:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A886A54867B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06CA83093903
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF4367F33;
	Fri, 15 May 2026 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/swx8YX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8ED1DE8BE;
	Fri, 15 May 2026 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808077; cv=none; b=BWmi2GsnXPXUQ0DiISi6uXDtbrFSySCGar7CR0hL0+sA9DSDpR/jc7KVwbe/IzqGs4Rd7DamAN6B4b9SIB7OSeW8KaLXVdwxubjU5zoq5BA95dKQ08ZTsXAjZCtg9Jo/ZII+8hTWAO/CJV8Rs3wtjLA7W2RX0s3KybPZArYQ79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808077; c=relaxed/simple;
	bh=Lm4gy3Hf7F2RTcb09XsAwDLQV3GEPCims6sv7ELDCGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ak6sZNAUTlApFeqY07ZpUiiPztspr+Hn73wFpy0XHo25/PvPiBhAJhhQFVLW94ZtA9Pi0SxyqQShBWk7GmP5peSDjdj+bi15KmdmE3wqjxqsdY3ex2QxE9Pqv0HFRDgYfPwyP4Wa5zbxGy07yfjqSSSpA8exirvsNElcAtCnQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/swx8YX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C025AC2BCB3;
	Fri, 15 May 2026 01:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808076;
	bh=Lm4gy3Hf7F2RTcb09XsAwDLQV3GEPCims6sv7ELDCGs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M/swx8YXsQDZbWEdpyVyv7S6G8t3YONWbVw+ktTdPNCwv5hQRz7W8phLUmQAnNTnp
	 AdoMuR4ieoh/6F5IyfXxLNSGLc5meDZMsE7PJbh60Q85N3w2nitdEN7ImvEe/fFOuB
	 Kh1/NrxOlXvtKDA5wN5JcxHKAIWJTyCxLFiPlok1JI3w4qOQnNXpAFKRfD9nAmGrEv
	 iSUUm5aGMeo2BnlsT2nEhnXJ9NFHNZ9wQDZSR5jdjE4wIzDYDZNjoKDfeBSdbi/YyA
	 IcKlnULuXIRuh9EJnh4b0Jr0L5Wzb1cJuPd+1z+FAuKAsIdZctIjHV7V86ywuPV68c
	 a8WAHaqC5n68g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE9E39E4DB5;
	Fri, 15 May 2026 01:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: block MSG_NO_SHARED_FRAGS in sendmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880802129.150313.8491869548360910151.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:20:21 +0000
References: <20260512-msg_no_shared_frags-v1-1-55ea46760331@google.com>
In-Reply-To: <20260512-msg_no_shared_frags-v1-1-55ea46760331@google.com>
To: Jann Horn <jannh@google.com>
Cc: edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.fastabend@gmail.com
X-Rspamd-Queue-Id: A886A54867B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288138-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 16:02:03 +0200 you wrote:
> This change should cause no difference in behavior; it just cleans up some
> hazardous code that could have become a problem in the future.
> 
> MSG_NO_SHARED_FRAGS is a kernel-internal flag that cancels the effect of
> MSG_SPLICE_PAGES, another kernel-internal flag that influences the
> data-sharing semantics of SKBs.
> 
> [...]

Here is the summary with links:
  - net: block MSG_NO_SHARED_FRAGS in sendmsg()
    https://git.kernel.org/netdev/net-next/c/4987a5763fd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



