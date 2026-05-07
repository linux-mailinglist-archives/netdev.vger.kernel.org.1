Return-Path: <netdev+bounces-285091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SISeNfvh+2lGGwAAu9opvQ
	(envelope-from <netdev+bounces-285091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:51:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA94E1C5D
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60ADD3019F1C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFC01A681E;
	Thu,  7 May 2026 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ5EOniB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E417A309;
	Thu,  7 May 2026 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778115062; cv=none; b=gYuysLuUE+QdBcE7hWJFItTNDb6d2aOuv4zBCDWTz8LrmKRSlbM5izPJ2z2tp0HMuPRuxF+xVQQWTJq8igpXg3hda4C1wI1Yrpj1RXFxPumHsLHTNk2h4+Ni4Kj/ldEUG4wMX4pQrmKZx9D9Obukyj2da7LhzLOebgkc2KESua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778115062; c=relaxed/simple;
	bh=Ykm/CgbNs4dvp5FgawGmX6mMnfMSO588L6pSP8onnqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=srsk3N+yGyyP71MaEvdAqDfjm1kD5er+KiYcc9uJ4u2J7KJ9XpYLdo0qKF8SkfKH4nUFko/yRFMa+tID55g4I1UOueQY4zkGjI+HkMrJBwHEUIzj4MY7sV+uw6LbohYMJRW9baJMTXxHs0gA4/1qGGRU4x72mkWpPpSBWZnW2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ5EOniB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74963C2BCB0;
	Thu,  7 May 2026 00:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778115062;
	bh=Ykm/CgbNs4dvp5FgawGmX6mMnfMSO588L6pSP8onnqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EZ5EOniB8JPJGfEi9EpSRXcTYnJdQLAs9INpsSm6NtHeCF6636ljw9b3D9FHNLuBy
	 05h7fyoGKzbom7KZfXFcE41wjou/O+LogDClebcehfC9DMEVXIOCdtF3rj6JXl0vVL
	 JsHH8qwkhiihKd5RY1TNEi2QCI2E02yEgnCwdsNrdKhUd/FGevsnYVjpHBZ8ac7z0p
	 CQcFtlxrP18nMfKmmUbp9E6GTCG9NStHKmA44p0ot3dmZ+KFhUUhAxyG8LQ7evAJDD
	 1DJ86DC4MyikynHkDTjH9csq59EaQPi5WR44oi6BUBjqbRB98exAVG2cNF0gSq1nLp
	 /y1JKu1b75ffg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF27393089F;
	Thu,  7 May 2026 00:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] netdevsim: psp: fix init and uninit bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811501205.3280886.6057406571576753588.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 00:50:12 +0000
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
In-Reply-To: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemb@google.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 41EA94E1C5D
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
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285091-lists,netdev=lfdr.de,netdevbpf];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 05 May 2026 03:42:22 -0700 you wrote:
> This series has three fixes. The first is a straightforward NULL
> pointer dereference that is reachable by creating and destroying some
> vfs on a kernel with INET_PSP enabled.
> 
> The last two patches deal with nsim_psp_rereg_write(), which is a
> debugfs handler that reregisters netdevsim's psp_dev without
> aquiescing and disabling tx/rx processing. This was added to enable
> some tests in psp.py where a psp device is unregistered while it still
> referenced by tcp socket state.
> 
> [...]

Here is the summary with links:
  - [net,1/3] netdevsim: psp: only call nsim_psp_uninit() on PFs
    https://git.kernel.org/netdev/net/c/7ce3f1bedaac
  - [net,2/3] netdevsim: psp: serialize calls to nsim_psp_uninit()
    https://git.kernel.org/netdev/net/c/24c96a42006e
  - [net,3/3] netdevsim: psp: rcu protect psp_dev reference
    https://git.kernel.org/netdev/net/c/07bdec3fc737

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



