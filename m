Return-Path: <netdev+bounces-249373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6598BD17C9E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CC2D30060FA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C661133986B;
	Tue, 13 Jan 2026 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYKicrx4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D931A57B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296814; cv=none; b=ulE+5IZs3YgeX5uO/oH9NbIYrtU2a1u+WtF24ziEb+k6dlC6SJT4S5laMlhsceJaUwpzto4gMfqbswOmICUZH29nhw0/2a6UZAnCgV48ONtphywN8ETb5Qy+vWannGM7jNAe8u+1AS5BZLYuygdolMesWAZu82hSd8Bb97LXavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296814; c=relaxed/simple;
	bh=ijpwNQkLIJJPei/r7C3Ia22htX7h8kydfRmROue5o14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WVN3bez0dUyLh4XOqoX4sdZtpRWqGF/neMAErlVAVR140vbQVPWLrfYi//YOTMuER49XJz4p+1Wo6IaS5zELe/VDl1pIE2GVru4sU4V+uImZa4TMGlx6+RmfCAmV9OOp5IM5ILgAFuHjEOgjtdup17EEeY1J/I3fdzMvSyTYiAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYKicrx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C303C116C6;
	Tue, 13 Jan 2026 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296814;
	bh=ijpwNQkLIJJPei/r7C3Ia22htX7h8kydfRmROue5o14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VYKicrx4Q5HaaQ9pJ8zXguLE/GdieHhNoTF1MmzgfRV6OgamkgYNPmTf17aPXNLWf
	 32Pa5/QFs9BG9IwjXPs2F2yNgpOAEMSAebElmGjL74HcDIAjggBKLUwXFD1RgK4/Kq
	 I6yo3tjAVH9Oxyrv0dp0y1fZixQw/w/TBwKmBHnNbg3uT8onhu9n7OY9qGpXGVZowb
	 fPKy3UbbV2eG23vdGSizw6HYP75giYcwlJa9JYXoN5y12J3FrTlMZNQjxEO4NdvmDC
	 7PSIUB8N9Cn0PVT4FLBTaoJoen4Cq+wFXQB6nLlRE9WtHXed4cq4knf/39HyZKX6Ir
	 Tteo4VUD9aSSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F36EE3808200;
	Tue, 13 Jan 2026 09:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: add net.core.qdisc_max_burst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176829660680.2152013.15534434316850162609.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 09:30:06 +0000
References: <20260107104159.3669285-1-edumazet@google.com>
In-Reply-To: <20260107104159.3669285-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, ncardwell@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  7 Jan 2026 10:41:59 +0000 you wrote:
> In blamed commit, I added a check against the temporary queue
> built in __dev_xmit_skb(). Idea was to drop packets early,
> before any spinlock was acquired.
> 
> if (unlikely(defer_count > READ_ONCE(q->limit))) {
> 	kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
> 	return NET_XMIT_DROP;
> }
> 
> [...]

Here is the summary with links:
  - [net] net: add net.core.qdisc_max_burst
    https://git.kernel.org/netdev/net/c/ffe4ccd359d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



