Return-Path: <netdev+bounces-249693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E0AD1C306
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D94F43008E15
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1930146C;
	Wed, 14 Jan 2026 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uhaqi4Tv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B02BDC2F;
	Wed, 14 Jan 2026 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359848; cv=none; b=XfhaQM5ZW1U7l9/94avTbK1JWAn5fUyM2dxRzOCmwHj9v6LlOsBTNC8zZYlDlWuEFdCCDCckfnUWo+T/zsxcEVLkX/lsPlap7rWS9EfRP+6e2RqolMv+twfFu7LMvRPnrWmH4h7Zw6GM+kkB347fRfUiWVfL0r5VFR2Ir1zsCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359848; c=relaxed/simple;
	bh=jz16rfEXoQ1MZF0dpWgXuJ+5dfnA04iOpY3Zdz+1bQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aq2ZwqCRf5I6lPVHybj+XgjVHAM3bOoqgnDys7rgsTSH+waOhqVb/sX8f+fzlzBvXzSre+dcLh6KJ4sRvW/qwaz/kpO4/UM+5EaMf+ft9zEi1UhMLED07FGwAUzpRIPG3HhXfJa3vjUllZsj7zbcHXvCg3FCN25uoO3TUcO6FeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uhaqi4Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADCAC116C6;
	Wed, 14 Jan 2026 03:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768359847;
	bh=jz16rfEXoQ1MZF0dpWgXuJ+5dfnA04iOpY3Zdz+1bQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uhaqi4TvByDx6FRWKB0cGPjQFToJcITK8UODo6NbA2jz6iW3CT9nbqPZBffcV/3qr
	 lIpnPHPYCKOpXMUOHMlwms1uF2HU5eCCzI8jUkCZuAmj2l6g/QmCxjRypfxNevXj+q
	 OYOXeDiPPC8mRDT7tFHdrrI1hpOdZp3ySb/F3eYbO09uZGVVRhHqfj8A5xuUFWY6NT
	 +u8sSJugDpfk9RqYObGyNsIqVNCZrhB3JF1XlnQVl7QvRBVPgxWjYYH1ucWJ91/Fsf
	 /oBg4TduxRc4wtmd92cDMybzm0tBAjqRZOMNsUem7ub+Q3rIEiRAs4aIvwnreKWIMO
	 qwP/NjW6X/t0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8083808200;
	Wed, 14 Jan 2026 03:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sxgbe: fix typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176835964083.2565069.8274255305147678443.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:00:40 +0000
References: <20260112044147.2844-1-always.starving0@gmail.com>
In-Reply-To: <20260112044147.2844-1-always.starving0@gmail.com>
To: Jinseok Kim <always.starving0@gmail.com>
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Jan 2026 20:41:47 -0800 you wrote:
> Fix a misspelling in the sxgbe_mtl_init() function comment.
> "Algorith" should be spelled as "Algorithm".
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - net: sxgbe: fix typo in comment
    https://git.kernel.org/netdev/net-next/c/969994f03237

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



