Return-Path: <netdev+bounces-247550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89126CFB9BC
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F4230AF9C8
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B92253AB;
	Wed,  7 Jan 2026 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmwdHsgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D41EB9F2;
	Wed,  7 Jan 2026 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749614; cv=none; b=q2MC70/MsMWg535vsNHVzvQct77GYEBVSaNiZNfcdK4vGdtU1CAEKCypIjM1bUx/562nAONdnvMXnmgXlEFcWxQ+uzHNYUIQ47t92D5wQyDBjsQ/ZHqWn/TKnk6VxOhW+WpZGKUNsUfncYFiHhYA8LvXSVBDqsWNp6JnFjFd8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749614; c=relaxed/simple;
	bh=jOHbZXYVn1ZnDQ/GTnJFzXF3De/oa2/X7ZkkC0wVBH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FOoom0nzsYMCZ0YI3x/DaXjj0U6CQSeDA7jXhJ4QrPf0ZZ5af7J3tYy/zCpB2CW5IlTbbwIxNUkBHilp51s8yfMfTbmW4ipHiDuRSCOkKJ6fsGt6eorFcTAvyMMpEBTvkhBVgd/CMXXiWLtc71Nh4DVBXh1D5jYU2iT6CUNYpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmwdHsgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44002C116C6;
	Wed,  7 Jan 2026 01:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767749614;
	bh=jOHbZXYVn1ZnDQ/GTnJFzXF3De/oa2/X7ZkkC0wVBH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OmwdHsgkYuLFEFkCWNX7HvZDJ5p9MEUhdJtn7Pt35D5//t8w+tNyTuQVNJpc3K7ly
	 29RMNcN9X4+HJtLHOI1oR76ei7o9l0maFrfEPoWAbzWtMp8Lf80clpsaIlvlHhm6p1
	 Cjs0rGkkSFMLCMAT9eyB0/6Z2BW2ZYr3Ui7avF4Fzq2K57XrIIMufWTtjGOGCIOSFM
	 M/9AlGzZOWVXgcOCf3zIiJ3ryVz/enbBR1fZlIE2HDKKS4dbN0vg3dICBKkX4VQxFu
	 zLMACvR9HpMRuCJU/VhzupPpi2oo9/Lgkx0TZERd0UkugAeXzWCXpCVSKFcwuYb9G4
	 /yOfJI8B+Er0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2846380CEF5;
	Wed,  7 Jan 2026 01:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: spacemit: Remove broken flow control
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774941152.2191782.5264945592916797804.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:30:11 +0000
References: 
 <20260104-k1-ethernet-actually-remove-fc-v3-1-3871b055064c@iscas.ac.cn>
In-Reply-To: 
 <20260104-k1-ethernet-actually-remove-fc-v3-1-3871b055064c@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@gentoo.org,
 vadim.fedorenko@linux.dev, troy.mitchell@linux.spacemit.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 04 Jan 2026 14:00:04 +0800 you wrote:
> The current flow control implementation doesn't handle autonegotiation
> and ethtool operations properly. Remove it for now so we don't claim
> support for something that doesn't really work. A better implementation
> will be sent in future patches.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: spacemit: Remove broken flow control support
    https://git.kernel.org/netdev/net-next/c/f66086798f91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



