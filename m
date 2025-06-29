Return-Path: <netdev+bounces-202215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD1AECBFE
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018C8173A3E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE320C494;
	Sun, 29 Jun 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8KIPw/N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAA1F5846;
	Sun, 29 Jun 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751189981; cv=none; b=NhCt9lIUCJPPugNSIIAdy/tLmRarbuCaMDy/DcJ4RXEmOnpHBUuTmKxhvHdv+0Y/rk+UsLN6uW7wNjB3ugA0wEaGdGCjKr7LUjD+DIIihPK82o760JwUm46q7egzKlBlz+Y4K3Sv1sfi0oam/ebQxsiEE0geXgKrXJ+FD2VrmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751189981; c=relaxed/simple;
	bh=d+U5C/PFKPw3xQE+dsdfuy3aYeZGZiAX6G/M0HthP8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QIjfS7LeiEGUFpSffkaZ9uPTnUsAA4tqq2ie47xePr1wTZ7v/55vh0/qROCepAkN3yFxMmtgsNEF5QmlVjg7xUfmf/wxnKhEBIInIYgoaBSIk+T21H9OUkgxhmbiWmVYGdUsoOwzcjwWy2aJ3zwKVI+z49EUW2dJZ3csD/W/gzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8KIPw/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCD3C4CEEB;
	Sun, 29 Jun 2025 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751189980;
	bh=d+U5C/PFKPw3xQE+dsdfuy3aYeZGZiAX6G/M0HthP8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b8KIPw/NhQtnCPSIqcTb7OpIGcwXN/Uep+hUhNeYFhhO4uJIpa0r49h5CQ4hdq8NQ
	 VP7/4/duVXcf4QZBhScRO51xHv4TwWzm6GtexPI+fXgNMUYgtdoPC9FPC0jfi4YqFl
	 knsmpfPSYCXNOL2CNKCJYKMqMAC2vmeDy5+oKB2kE4lY7S0n6br9WM5Guh5aGN1bpy
	 lxjFzYzMnBnQIyjk5TR4zHA5PhS0AL70G73e7DgvzxZdakEYOltDaONzuQW37lB322
	 uDfp1YFVEL+MZVDw4c+zE+DWq9UyoZOiQqYlb9wmT96J8EU9mjCHF7/vxC4GdxaX6V
	 i2KaETp1xvK8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710A638111CE;
	Sun, 29 Jun 2025 09:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: Fix error code in rvu_mbox_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175119000626.2374319.8201551896866216427.git-patchwork-notify@kernel.org>
Date: Sun, 29 Jun 2025 09:40:06 +0000
References: <ee7944ae-7d7d-480d-af33-b77f2aa15500@sabinyo.mountain>
In-Reply-To: <ee7944ae-7d7d-480d-af33-b77f2aa15500@sabinyo.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: saikrishnag@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Jun 2025 10:23:05 -0500 you wrote:
> The error code was intended to be -EINVAL here, but it was accidentally
> changed to returning success.  Set the error code.
> 
> Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] octeontx2-af: Fix error code in rvu_mbox_init()
    https://git.kernel.org/netdev/net-next/c/20a0c20f82ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



