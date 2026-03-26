Return-Path: <netdev+bounces-272033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGy3L48rxWnb7gQAu9opvQ
	(envelope-from <netdev+bounces-272033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:50:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD5A335788
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E405A3038D6E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73687239086;
	Thu, 26 Mar 2026 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBX16vSK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91D2264B0;
	Thu, 26 Mar 2026 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529421; cv=none; b=B+AAeTdrCbAh3d5tueVHDnklGsao3ZPQFem/w7mJTxzb1Y21G4FvLOZTXABZJ3reWsaKU7gYudViZHLkNJQ/mVaRlgRLIAO2dea4N0kV4cibuBQkJq01uZ4XHI97lblNsaM08oZEYsh46Y1jP4aXjXr4Q40qYPYHUZMNwZljLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529421; c=relaxed/simple;
	bh=nz8zSkm/QwG9xuSPLcqGNPh0yy+Xxb6YSgHtYiiKX/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hykDIooSKTM1+M5x7BMe2nhUgYwcjzt5+5F7LQV5d/U+onQhe8i0o6VjPzB+ER7nA1IrASoaw14jhr3ZEUqJ502s3MvR3ds/vCX4Y66PiNB/MV3zunv0yT56tuUVRf4H2AhnrAozXYw49xao7xPMsptuMFLRr5HU55imFDLkz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBX16vSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8804C116C6;
	Thu, 26 Mar 2026 12:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774529420;
	bh=nz8zSkm/QwG9xuSPLcqGNPh0yy+Xxb6YSgHtYiiKX/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bBX16vSKk2RJ442v4X1RROZTV29ed+azP20KL7akyCDrncKW8ujNBZI3BpEQH0BNp
	 7XZg5Lwq4VGkfYM+KmzsrAWyy0VJeQcI+hGLdSqNJPdCZMg5ZIx9vDG06fEhrr7ob/
	 Z8JnEAqSlnOTktXHPzlPbUQQBgfix/IqUsGfqVDcUXAp6aY/7elenM7zdvtevDPkRo
	 X9brYbViiv9/HL7E/coeTSJxuD10+mSjWdZuAx5zCI1rQ7E/9wR1mcWOR3jpT8QhNH
	 cjkjTcYrFPChsNKR4yP4GWJNsUyj6CjjfFfgJOypVZv1CyMkFUTNJiL3X0iq/bhrxX
	 Ie53GJyg6ObQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA09139EFA65;
	Thu, 26 Mar 2026 12:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-03-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177452940754.2540696.16802163481653825797.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 12:50:07 +0000
References: <20260325194358.618892-1-luiz.dentz@gmail.com>
In-Reply-To: <20260325194358.618892-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272033-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DD5A335788
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Mar 2026 15:43:58 -0400 you wrote:
> The following changes since commit c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f:
> 
>   net: mana: fix use-after-free in add_adev() error path (2026-03-24 21:07:58 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-25
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-03-25
    https://git.kernel.org/netdev/net/c/aa637b2cf303

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



