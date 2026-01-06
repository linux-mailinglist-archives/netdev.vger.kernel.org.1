Return-Path: <netdev+bounces-247241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBABCF61D8
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 621B2301EA07
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BE71E9B12;
	Tue,  6 Jan 2026 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqZI251V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9C1E7C34
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660809; cv=none; b=RJ8zlk5etNIl0WATOEi71gxGAUa47MEVok4SGV9sJ91Maq+fkbQ/1rkQ6JA0NQd/tm8g0VhDkEordtSUCykjm2r4DmAIV8Oqcz6pvrqW+yPuFXXQYcZe7KOgCauhVFUN3f/sTXFy9+T/iQA2d4+QISR8aCf6UotFIjMEdJqCVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660809; c=relaxed/simple;
	bh=0m06hVPJmrZrVB6+Cn+qt5R60+BGPmur+4Yk5jNQWV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=huqelIaQ2cUW9bQxUWS8UfEQd6Ci6ngkowaW47MFdUhTruuHdC1YHP+jLprY+wc7NP3UTkYgSostmxXZJsh4p4CbXqApZXqrmlMKME87FLKF7NwFLiEW00Hm4XJjuSH9SzZJt3BddEoX3kV937y+agY7mvp5wCwXTU1SfLea22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqZI251V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B112C116D0;
	Tue,  6 Jan 2026 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660809;
	bh=0m06hVPJmrZrVB6+Cn+qt5R60+BGPmur+4Yk5jNQWV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dqZI251Vo7W1CqGUnpA30m8VtXFHlHUEu5BdOWrrWsDIqWPl6SHK9dWSBCMlRCloh
	 mNPFMmzmDkCr402n4ewzMdODFutnWQIRh623hQ9YTCQjNWT7c/38UsMT78g61f9cgg
	 cC2hd8DNjegVTc5wx0q0yGqf6v2KdXolThm3oQPyBf4GSryL0es4rDm198NMO1uLi9
	 jExJKvT7dgAViIuiVglPcfiAnFl/3vi3c7e5YaPquTV9N6HX6V14N5LwWfsSAGs5XF
	 ZWnXDoQj6sQYKvghACnYdGE9p0kWvdOzJQI+mtVAdBDTWCKFAf7ErCmtvAUiUhJQcc
	 69MHEtQ/Zb2XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78695380AADC;
	Tue,  6 Jan 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: specs: netdev: clarify the page pool API a
 little
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176766060729.1346422.5600291968029106378.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:50:07 +0000
References: <20260104165232.710460-1-kuba@kernel.org>
In-Reply-To: <20260104165232.710460-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, hawk@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Jan 2026 08:52:32 -0800 you wrote:
> The phrasing of the page-pool-get doc is very confusing.
> It's supposed to highlight that support depends on the driver
> doing its part but it sounds like orphaned page pools won't
> be visible.
> 
> The description of the ifindex is completely wrong.
> We move the page pool to loopback and skip the attribute if
> ifindex is loopback.
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: netdev: clarify the page pool API a little
    https://git.kernel.org/netdev/net/c/86c22d475cbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



