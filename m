Return-Path: <netdev+bounces-219750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76700B42DC2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CEE1893958
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D323B616;
	Thu,  4 Sep 2025 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjpIsEzQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D77214801;
	Thu,  4 Sep 2025 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944005; cv=none; b=o3nk0lbukH320JxMTkXjBmmu+Tme2BFAJDYsAKkWunVuXeeMW6zSxqYfpJRjrrWzcq9wdJxJge25LEZG3KdIKzddyFjGH1CIvyTdgkpP8JDhhHZSNbQp3kg1sMfbrXjm8tE45M4i1guEuTGsT/tfzMoGeS+7ix6VHg9eDUHJln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944005; c=relaxed/simple;
	bh=I7w3dLpfScmtn7/wKU+AHG4udibaE0xMdWVzWJiexdM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QkTe+4oSk2SfKmuCRmaYSLbGjmDL4O+bEr7KTGpAe5rEuqKIy8dc1y39tU6p0WkjpDgAcJ/lImJVGD6S7jWbpyWI5nMYkHhPps8G8jWtgD5R0x5HhT0wYRmSggBoSac7JTU5boXFo+7MMJMrerT3ukNggi6j7AXldZ90PwZ6pY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjpIsEzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E191CC4CEE7;
	Thu,  4 Sep 2025 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756944003;
	bh=I7w3dLpfScmtn7/wKU+AHG4udibaE0xMdWVzWJiexdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HjpIsEzQmd0pScsMKbzSRUHOOHhU0XjCYRmiyOtcZWRbGkaG0EhrV5mlYjAoYG0Zf
	 4lgFrfdgEI9B6Lc6fARzbq/qyAPxEscC8zWM7pWQ3lb2atYrqmnn3LJevz/l+r7CEZ
	 Em84CIAKcxNfnhBfsGPIVQszgfFo9LSxs1llPt+wkXJCklRAsE1x8L4BKiAGzOCRw9
	 tJECtBfWJe//y4+2rp3fpVkG3fX0wUzK6KVcgIxUuVe9L+E8PYnuJiaCfJNk7Gha1P
	 AX5wWV1tnGh+J3bBvkI5jAGwcIiXKxuBAChj+M+L3hBh94tBH9DVzxc0kR+CBXsCRR
	 H5h6Xef+WPiSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4B383C259;
	Thu,  4 Sep 2025 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: thunder_bgx: add a missing of_node_put
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694400901.1242165.16900024686479366326.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:00:09 +0000
References: <20250901213018.47392-1-rosenp@gmail.com>
In-Reply-To: <20250901213018.47392-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.daney@cavium.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 14:30:18 -0700 you wrote:
> phy_np needs to get freed, just like the other child nodes.
> 
> Fixes: 5fc7cf179449 ("net: thunderx: Cleanup PHY probing code.")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../net/ethernet/cavium/thunder/thunder_bgx.c  | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Here is the summary with links:
  - net: thunder_bgx: add a missing of_node_put
    https://git.kernel.org/netdev/net/c/9d28f9491258

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



